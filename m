Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4326BD7FA
	for <lists+linux-arch@lfdr.de>; Thu, 16 Mar 2023 19:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCPSQg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Mar 2023 14:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjCPSQf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Mar 2023 14:16:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCFFDCA5D;
        Thu, 16 Mar 2023 11:16:26 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32GI5kvx024492;
        Thu, 16 Mar 2023 18:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=lPH4n3MdTvANBLQneeS4/maqDs2UnA14N1aHiCHzsxU=;
 b=zW7FJaVfDhXLbOESUbPDmuJm4bf/+PV6RGrAhhdcQACcd2yroVfzehnh8vB3jmtIlSrc
 I62dOJeLs8E5AWVOFMXEOGp1mF5h6z8WI6CAmu+f7SOKvALNrwYCEKxGY6Xb4R6RxJo6
 RR+7bXdppwUX085I8UHLmHdBCuSpxMCBmAgvaJ2Vkj8qiJa0JwNi+ug3gtstvRI3q/ZN
 gtVfk+aGR0AS6YgxPLKDek1U0f2Ros2kZhSmkyPkAqWO1oKjjI/X5Itd8c2aQrg8avfb
 DEktCT9vNl/9YOri9RFo5oSP/xPSk+tZF/mR89iQv/PvWzCBZl8ilMxhPDKJGzHkn/Uu Gg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs2assqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Mar 2023 18:15:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32GGjWV7023410;
        Thu, 16 Mar 2023 18:15:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pbqkypbep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Mar 2023 18:15:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FekHbxffsZjlj0/mn7kg02vvKZbOz+hlDP6VYaTWW1bCkfLBl9IDUYgXAP3CkRUrFflHM1vQDl6CcN7q1Ad0d3fG0CnnLVkWgFKK6QbPoEX2R8NLQ7JJag+FXXnrBwkwx2lQB6/vV1MkDPqWqdWjUQCj0x/ox+MIDh5pI92OVeOCydgyTlLcQ3tFPReIRivjmhDdTWDv4MQqj/9mmimSDxmDxuHa4ngzLMyWDG0q6rch0OL/orEau5t9K+Z+WDDN0lbW6ZFeh4F2c7IrFyVaU3SVTO6HlpUn7C1F6WFEFW9MnOnGTlJemmGihJgfWBwVrr+7MvnoIXduB+E818HQDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPH4n3MdTvANBLQneeS4/maqDs2UnA14N1aHiCHzsxU=;
 b=G+CZJ6/SSqBmICTefzD8JySexs3bEp/mG0iD35ZjgUr8wB6bbbMLsa80N9daZbHncVRBPLAJZnC0wSNKTCpQfHTiSdAiuIJXUA8utCbq2YiZbcyDZtGrf5xktFaOVeSAktJxBlDSAUq7+eHdMX1bRufQk3Xtoxl4aO2isllve5I1DPid7ddVscO85MrFvr8SfEVnce/bvdqkz0thNi42QTOgGVsQLgEXvawqt+TCaHOI5oMrYI+ZJHAD4bdcTeUyXtVxqbe99psKHNS+ikBgu4IXGjDz5nU9/cm7Y4dfHec3UqvLXRobl8ZUVXep/4KHr0r9G+CzDdOizMPX6wLL0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPH4n3MdTvANBLQneeS4/maqDs2UnA14N1aHiCHzsxU=;
 b=FaexyarI2uGEKNw9n0hvNqn7Kqg1/4xJHSlqlKWvyd4eUk5jRidr+F4htNVifRTwxoQ7twigeHbkwte9gA6cdv34itlowtZJAI52DH47QNx3nqNGYz19l+f8m0AFX7WxlDc/fPJHu5SNZ7MmI4ehbGgJOirMMt+4CCBaV0IuaMY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH7PR10MB5698.namprd10.prod.outlook.com (2603:10b6:510:126::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Thu, 16 Mar
 2023 18:15:51 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%8]) with mapi id 15.20.6178.029; Thu, 16 Mar 2023
 18:15:51 +0000
Date:   Thu, 16 Mar 2023 11:15:47 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] mm, treewide: Redefine MAX_ORDER sanely
Message-ID: <20230316181547.GA6211@monkey>
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
 <20230315113133.11326-11-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315113133.11326-11-kirill.shutemov@linux.intel.com>
X-ClientProxiedBy: MW4PR04CA0181.namprd04.prod.outlook.com
 (2603:10b6:303:86::6) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH7PR10MB5698:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d1d59fb-ebc4-4431-0eeb-08db264a794e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uV+UA8/eIDgnAbfdWRy7VvlbGm27Iho5J2KfX7IkpIw5gm/NWwW1ePonBiISLpy4cq/gkQQJCqFziOtt0d70spwGbZxwNdrtPLwF4tlEroVXxpUAmBaFREcXq3sFRIZDgjHfbgzf3TdPzPCAFS626Hsc0V+Lxtywv2CM8bBkSoX3pxjEv/EK9CUosHzU+6lKFxZ8nDtbaBOyqC7fjH0CKDMtDOVz/wGY1BLNVS0rWRlmO3ZxIKAmuDpFaep4ZK06SHZYAa/35oRDDwcsqRKUDZOiNM56o1e7B0RdDnPYE7wb2xrP8zqHVTG88ZhShaBzlabpzoPvCEFJj1HaR8QrG+eyHaCjjc0yPs1edNMvvyb5WN1+LSGYXq5Dz5mOHTqG+DIBdy+cqIanrks66Hp0GIz3azBOMeOplxIwsadhfvRujnoZeiZq3KPX3OEO+BWc8iMPPuazBwBWYI6nXhu8zUMnDFVh1JZuGShXk7F3Hka3FaZbpmDgeB2aTyZevx1y4nTOPtmlcU0T7IZap6n5rSdkYGhySWG5lUjPu30pFXlIb53sFmSFxfq8Bv17aRHCbA+zMEs5Qa/mEVKP5k9+FdqH7MKY7Uf69W1YrdCVsIFElCg/fX2hUTm6sfECMjlyaC7C42WCXhPxSWNvFVTB6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199018)(6486002)(6666004)(83380400001)(186003)(478600001)(1076003)(9686003)(6506007)(6512007)(66946007)(54906003)(316002)(66476007)(66556008)(6916009)(4326008)(41300700001)(8936002)(53546011)(44832011)(5660300002)(4744005)(38100700002)(2906002)(26005)(8676002)(33716001)(86362001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EPDgoc/H9Skm4brhIXY3WQPnZ74NPy+YLG08eM/JADlOAB1AOaZDNeBFmMIi?=
 =?us-ascii?Q?6FbBWXH71pY8Rw2OgoQ/2GKZ0eE3CXjs+s2p37sUzScw1AFbDXzXXSGcj74I?=
 =?us-ascii?Q?Q+FoCNQAcdoeHoRfBGbigIJECbxlggSukgUXGTAkW/ANzpm32FTGcs+mIDws?=
 =?us-ascii?Q?4IfGVN11z1cOuc+mdNRm5A0uH4hyQ6aPAMYm2qgWqgHWWx3xEQeqhBYI8I37?=
 =?us-ascii?Q?iXXDC5KOr9GmeRCUJ7kqrHxkU7JJCv6tTDe6QYR4mAG/Ag5ApS57gae323Ad?=
 =?us-ascii?Q?p45KsAMaBZYZ4jPp1jSF0ie15wZdMFV7BXTeTeaUKPzhlKgQVxDiu0/UzT3N?=
 =?us-ascii?Q?iaTx4kMUKrvzhi2mUC5uu40MQHxvSOEhEMS+PKfAhpErfsurT0OJz6V5tiDU?=
 =?us-ascii?Q?Z7mp9Dbv5cBO3E2OAOaMeRDNJ4sCVlGj4EffQAakak0dqRTAr/rxti4Jjdk+?=
 =?us-ascii?Q?IFKAGET4VCww+d3fvJLE1t1c2es449lQLyUeI1bVQO/XS7ftIBCsogMrYX2n?=
 =?us-ascii?Q?3hZWdx3T4QXMGWFObkrvpzkdPETrPRZDOq0oU4CtZMA5Vvr6JkdlcyXJ2MTj?=
 =?us-ascii?Q?5rekmG0jWpXHzVRGTAAcuHYBFahJ4DFJvtrszgMiWRfF5uFswJUMUh/wCc++?=
 =?us-ascii?Q?mZEWqiH/X+i51AHSzn+h7fnrj5tTUlhwXJSSmcFWN7GHgD7rkvFdaMKk7eRH?=
 =?us-ascii?Q?KGS3HA+AN8sEAmzCQU0hxgfEnDBImzBEyCmW8E7PzotODAuAZnKI8OY49oWq?=
 =?us-ascii?Q?4m20bm3jex4xs1YjgpmqEqf+yj6ZhMKaMq4CfWEmQqsXwjqkRi56XhrQHR1c?=
 =?us-ascii?Q?qmZs+yH4LxFlHA1xoyU6aaIGhteHq8uBpfpayhapBAD1gJkGuW/koNaS3JLh?=
 =?us-ascii?Q?5cSvEycAy7ZHKzJcbJ1xvXAzXXlNSPyphjv2Gm9x5EcgXPRgwuDHTsuabN/M?=
 =?us-ascii?Q?xPviwmePgrvd+/uhlLwlLwu7CZumA7jzgaM985wpl3ANWtCsAPmn6T3Y96GK?=
 =?us-ascii?Q?JrwYoCbQnaUX+r7PokfvDqa2ZFHSqZwSDOailizdKNUWumSwgvbtbbe13H3g?=
 =?us-ascii?Q?pXa6LkAdZt9Vw+4Re4MVs6+6sv1HuyIYcFHT2pEmpUMDl0+9xy8jWMj4tD9B?=
 =?us-ascii?Q?XpmlmajN8JPQbaqpI3XGf4dSYZY9l2tjY/EHZHcASLuNLTLjjYHG4OKB9E9p?=
 =?us-ascii?Q?NwMj+89639/lQHGH448rxBh2cTLmLFcVjLRjZW+w+tz7qYvXQGSVxPlojymu?=
 =?us-ascii?Q?AbRBcLBd51jUYWJtmXmEfMOHhxOfpD958EiwbWZD8mZlwJQoCSDfVIKiWwmB?=
 =?us-ascii?Q?RVPH5W2/pqTpJir7GgMT4kV9d5ErD3aT6RlLyFgYTXgN3rFXMMUibB9LAJdo?=
 =?us-ascii?Q?1YkQtjmvcKzMjCjCfN1+vb1sbpKDhowR+utKZ0OJHoq0/UZvPs+RMaxjSWma?=
 =?us-ascii?Q?nHzHWX4o8q1QTd9aTiy1Ncwo1TLDebQohUVc/dfjHXYhipuhvCcW4eprv7mT?=
 =?us-ascii?Q?g+jn4Q/LNmQLvS38XeWMLxaFjygMCpJdR1ziKwTWAK6JXHnruwrKFhe/OAkk?=
 =?us-ascii?Q?JEZyW7XKYjAeQLHzV/oBIMHhK6ycwN/U1afYD6OylXDQnvokfa6ALUcMYg7I?=
 =?us-ascii?Q?qA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Bzs8Qwl/kEYoLG3/kjh1oTKmrmzZ5HR0Fhvv/5I6iARkPOA3qD11Zh9KiDYK?=
 =?us-ascii?Q?YCXiaW34kSdm2MQGzbmdgQkfuXIBxJkcrugp+oWdXDg4dci877ccaBo1yA1d?=
 =?us-ascii?Q?0r8/ju7ZnGhnZznLSe958CrmSeByk7n2FKkVIwgnyEfNvve8jQZSy7A7D8KI?=
 =?us-ascii?Q?r6b39EWWqjyps1h9ntypn6k0eCUBeF4XG309jns870AyhITN5LVglp6XA8s9?=
 =?us-ascii?Q?vE53s2f9P3OswQA6ZmEIDluy0RDK7A4COGvazfhHwVl6EQvhCwth/4yTTZ+R?=
 =?us-ascii?Q?8LmFQPZXnpyvGhDKhZkU3H6avqi3eLcmrTshrHKI4eyMkH/NQwcv+C8hgY3+?=
 =?us-ascii?Q?HG/YVAWkHRbPnZIbnZqrLQnQnUsHbMbvfHOChg9S+0xMS3id0Xe/WkQmSXO4?=
 =?us-ascii?Q?K9ty6LdpnOYierk7f1vzus9DgE+SSnBQ9rAHpdFyH8dFyNmpH8sRD7xLdN2Q?=
 =?us-ascii?Q?W7FWZzXGKXxcjDzNthZjoSvJXnt71anYFkN4dd4LMq5jEH8qPS8LzqDBE4+t?=
 =?us-ascii?Q?wDjlIzGRXdD+civwjQjJ3S2FkhlNe5vyZgWAAImYU8NR90xSvrnkYIwDuV/e?=
 =?us-ascii?Q?24SIndAdgoTRK50tGyVeSjHNQo14OFTwVCK0dH+YQkdEcdTLaZm/ZhpSq0gi?=
 =?us-ascii?Q?G7IwsOBXi0u9WyoWU8JaYYkmHf8Dkm0amO5l3mC+cN+H0BoQBRtgRDgHgh0k?=
 =?us-ascii?Q?PTQzuEgvWbkePTQW6CIMjFy0RT/rNSqihdsTYW1hQhyUaEfkdoXcrSV9sKnG?=
 =?us-ascii?Q?3CwKwGlHAT0+E+OS8m3ZCBi6leDokKPASh17gq1tPBYhH4vfoXdFfGoP0dEL?=
 =?us-ascii?Q?3gLulrpvHRrxyYYIDWzOkYFzktNW4P66klM9PUGPsRuYPnTKZaBlmBkpl6vp?=
 =?us-ascii?Q?BimSuWzEov4/MH7wLycaiLKZR8glO4H3QHGGCuPyXhR8Vp/E4ZkiBt7Z5EvU?=
 =?us-ascii?Q?2sNaR7EZlgbxXxzVT2jq5Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1d59fb-ebc4-4431-0eeb-08db264a794e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 18:15:51.1244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pd5WnIzV0Kqz6QyAmsmZ6HV8lN8R+oy4HfRav3acsmiQoM9L+DAJ2w+ZM4XhZp5m8ahTW7/1LKSRH11qRL85/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5698
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_12,2023-03-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=755 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303160141
X-Proofpoint-ORIG-GUID: X4gdT7VCshWkc10hyexNuolqLpWcwxIu
X-Proofpoint-GUID: X4gdT7VCshWkc10hyexNuolqLpWcwxIu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 03/15/23 14:31, Kirill A. Shutemov wrote:
> MAX_ORDER currently defined as number of orders page allocator supports:
> user can ask buddy allocator for page order between 0 and MAX_ORDER-1.
> 
> This definition is counter-intuitive and lead to number of bugs all over
> the kernel.
> 
> Change the definition of MAX_ORDER to be inclusive: the range of orders
> user can ask from buddy allocator is 0..MAX_ORDER now.
> 
> --- a/arch/arc/Kconfig
> +++ b/arch/arc/Kconfig
> @@ -556,7 +556,7 @@ endmenu	 # "ARC Architecture Configuration"
>  
>  config ARCH_FORCE_MAX_ORDER
>  	int "Maximum zone order"
> -	default "12" if ARC_HUGEPAGE_16M
> -	default "11"
> +	default "11" if ARC_HUGEPAGE_16M
> +	default "10"

Is this Kconfig file wrong (off by 1) today?  It seems like it wants MAX_ORDER
to be sufficiently large to allocate 16M if ARC_HUGEPAGE_16M.  So, seems like
it should be 13 today?

-- 
Mike Kravetz
