package com.mwyq.service;


//import com.codetrans.latintoun.biz.LatinToUnicodeRuleList;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrServer;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrServer;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocument;
import java.io.IOException;
import java.util.*;

public class DocQuery
{
    private final String SOLRURL = "http://10.10.130.152:8983/solr/clir";
    private SolrQuery query = new SolrQuery();
    private QueryResponse response = null;

    public SolrServer server = new HttpSolrServer(SOLRURL);

    private final Logger logger = Logger.getLogger(DocQuery.class);
    public DocQuery() throws IOException {
        //PropertyConfigurator.configure(this.getClass().getClassLoader().getResource("log4j.properties"));
    }
    public List<SolrDocRes> query(String keyWords, String langType, String isSensitive, int start, int rows_num){
        List<SolrDocRes> docResList = new ArrayList<SolrDocRes>();
        int rows = rows_num;
        if (rows < 1){
            rows = 10;
        }
        String[] fileds = {"news_title", "news_content", "news_id", "news_time","crawl_source"};
        String queryString = "news_title:".concat(keyWords)
                .concat(" OR news_content:").concat(keyWords)
                .concat(" OR news_time:").concat(keyWords);
//        int rows = 10;
        if (start < 1)
            start = 1;
        start = (start - 1)*rows;
//        if(langType.equals("meng")){
//            keyWords = LatinToUnicodeRuleList.getLatinString(keyWords,false);
//            queryString = "title_lading:".concat(keyWords).concat("OR content_lading:").concat(keyWords);
//        }
        logger.info("queryString:".concat(queryString));
        query.setQuery(queryString);
        query.addFilterQuery("lang_type:".concat(langType))
                .addFilterQuery("is_sensitive:".concat(isSensitive));
        query.setStart(start);
        query.setRows(rows);
        query.setFields(fileds);

        try {
            response = server.query(query);
            for (Iterator<SolrDocument> docIter = response.getResults().iterator(); docIter.hasNext();
                    ) {
                SolrDocument solrDoc = docIter.next();
                SolrDocRes docRes = new SolrDocRes();
                docRes.setNewsId(solrDoc.getFieldValue(SolrFields.ID.getName()).toString());
                docRes.setNewsTitle(solrDoc.getFieldValue(SolrFields.TITLE.getName()).toString());
                docRes.setNewsContent(solrDoc.getFieldValue(SolrFields.CONTENT.getName()).toString());
                docRes.setNewsTime(solrDoc.getFieldValue(SolrFields.TIME.getName()).toString());
                docRes.setCrawlSource(solrDoc.getFieldValue(SolrFields.SOURCE.getName()).toString());
                docResList.add(docRes);
            }
        } catch (SolrServerException e) {
            e.printStackTrace();
        }
        return docResList;
    }
    enum SolrFields{
        TITLE("news_title"),
        ID("news_id"),
        CONTENT("news_content"),
        TIME("news_time"),
        SOURCE("crawl_source");
        private String name;
        SolrFields(String name){
            this.name = name;
        }

        public String getName() {
            return this.name;
        }
    }
    public static void main( String[] args ) throws IOException {
        DocQuery docSolr = new DocQuery();
        List<SolrDocRes> response = docSolr.query("你是一个好人", "cn", "0", 1,10);
        for (SolrDocRes docRes:response) {
            System.out.println(docRes.getNewsId());
            System.out.println(docRes.getCrawlSource());
            System.out.println(docRes.getNewsContent());
            System.out.println("========================");
        }
    }
}
