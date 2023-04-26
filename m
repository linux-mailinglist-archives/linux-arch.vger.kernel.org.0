Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFA86EF8BC
	for <lists+linux-arch@lfdr.de>; Wed, 26 Apr 2023 18:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbjDZQvb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Apr 2023 12:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbjDZQv3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Apr 2023 12:51:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC9E7A9D;
        Wed, 26 Apr 2023 09:51:07 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QEiVTx003882;
        Wed, 26 Apr 2023 16:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=2a9Cp+TU2cZIEMZOzlR4LYSra+7XU34K7asDIdEpMes=;
 b=NGCXgb+MRUoVK5+aXnudwcAuFgBoxK2Vv92ciEsSjMDeGzGEf6c6iZ3XBANZTV4Mb8rh
 0SxCi3B4fhk4Fcthvk75XxkOkYvfImNYxwET3RPXP3S+0uNCg+pwIhb7KP3uV2PM0CRk
 F5oFn6w4S5KFQpZKSxflci29pBLOI1aVCRhBuB9LHfQMZpK//aEAWMPHHFux/T6ZqjZu
 2xITvJNVpMDBU45N8vWmmDuBsKgQ19IhHm2TpW27+5etBbe/eHtuP1YjKrkXdRQd2KKx
 jLr47mca6qk7wI3tLo1UbFtVXV6yTFLpWleGwFqJ6yfuW7dlpWRHZw2/DECgOLqzcu4Z NA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q484usxpc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Apr 2023 16:50:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33QFROBF032610;
        Wed, 26 Apr 2023 16:49:59 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4618dqs0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Apr 2023 16:49:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xne7v8a8Nw2TLLoKImiN80dLoIzHNgHf/S3n7Mf17YwvUNpADqAriV0gRWk4uiznEQDlI+q65l3fyPGBWptdSGrLif3kMVNT2M33SEv4Fkdiju/QmQwh7e6taWvgglhxH1Oc8wf2oy+j5ZzkzZZH6gJzr8jCdSm/Z6DjRakHY4BJb/PrruUe+CQCc6KmRP/z5BBLt38+om6yq4InzPqF5voOubT76zad/Fie+2fddWs2fPIJ9Th6ueBnL+NW17lcnd6dFv/XJuoUYNWDhJapaOps44NjYHy6ZCyl9YtQ0gz99o71MNbYk2dvuMkWw8jhOS82wpg3z2MY81gaIFMJtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2a9Cp+TU2cZIEMZOzlR4LYSra+7XU34K7asDIdEpMes=;
 b=GNK9voBDVVzPwUReSIy1gRgzvpPPAYxjcKA8jd6vweDlOO+gUbMR51wSV47INUlBgoaVRrAOqFPj1GaKEsWuDTNg6vT2UEKA2iSlGplNdqe76VBoFl61QgocpMDW8xT+Hvf+ILHG6c+w+HZ5hurVMqKH4IIhTNbtj2j2JXZkXNt1eFjmKgSQ8hj6ukiYFCN9fUlgFQvIUXG3RNrNhCDmY/a5n/ywrodT0CYPzyz2yomS+WQLt8sjGOY9Rgwukvz6TqJpjNZq2iud+PqAr1jujSdZad8gltXAPXNyVlpGBM1BZkWUY1zNUq15LtkFhIZnEPTuBfq8sHMA/Z6qf6/2nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2a9Cp+TU2cZIEMZOzlR4LYSra+7XU34K7asDIdEpMes=;
 b=N2ly96noNEXkGS/R69/NOo58pdqUbIQ1kiyAOnR+ohYeTeyUtX4NqKeAhegG5CHfh3XmzPjsWmUYmOxKY+SQny7YbOVme0H2jtjp506EtuMtVH6grkJSTIavYeMAF1CQWcIoW9h/GgjHMzGZirvv7COwjTXP/vxpI2T62jYOlb8=
Received: from CH3PR10MB6810.namprd10.prod.outlook.com (2603:10b6:610:140::15)
 by IA0PR10MB6913.namprd10.prod.outlook.com (2603:10b6:208:433::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 16:49:56 +0000
Received: from CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae]) by CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae%5]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 16:49:56 +0000
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     akpm@linux-foundation.org, willy@infradead.org,
        markhemm@googlemail.com, viro@zeniv.linux.org.uk, david@redhat.com,
        mike.kravetz@oracle.com
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, andreyknvl@gmail.com,
        dave.hansen@intel.com, luto@kernel.org, brauner@kernel.org,
        arnd@arndb.de, ebiederm@xmission.com, catalin.marinas@arm.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhiramat@kernel.org, rostedt@goodmis.org,
        vasily.averin@linux.dev, xhao@linux.alibaba.com, pcc@google.com,
        neilb@suse.de, maz@kernel.org
Subject: [PATCH RFC v2 1/4] mm/ptshare: Add vm flag for shared PTE
Date:   Wed, 26 Apr 2023 10:49:48 -0600
Message-Id: <a1bc313a3f50f085ab9fcd9826b3cdc20bc15269.1682453344.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1682453344.git.khalid.aziz@oracle.com>
References: <cover.1682453344.git.khalid.aziz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0098.namprd03.prod.outlook.com
 (2603:10b6:5:3b7::13) To CH3PR10MB6810.namprd10.prod.outlook.com
 (2603:10b6:610:140::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6810:EE_|IA0PR10MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: 108f3ebd-3d4a-49e1-be5e-08db467643f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Db7h8TxMJNjWJfalmBZWrBafvgTmOc7gXlVIC/+kpu4zOv3gmNGnwzsKAc7fjcFv0AV4bcvYOF2r2IdfQ6GSpMccq4AUfVNAAT9UtceSPpUDz6N/J5+97rrDpcNzNBHfc+UuKVvQPzEzP5PVVIvESQ2QJY7hYYDCiL07mmb2a49JOfJSqOlcf8Qe5c9nbK5TLMVrj6mvKrQOr+yGK3xeX8Dd/JeRmmSXf/IjtKeyJ1J9We94qdXuD67FJ8awkRrQl34Qs4+TCADq7trKwiyvKjfPDg+ltsou969J5lLe7rJiipbghKJ2HTa9nFLP4ksbawU0YsiZ7YGwtO+HDe50RD7raKMf9pw/aJ+8Z6LTGZ1UolTFTpbkB/Dggy8SSrNXY4cL7bJ7F20Ef7aMekmnBvNMH9Txz+7ofkYotTJEPE1vXFx7SLJdh6Om4nWV/2vDaxhCKO4RdipcHxysPePLFRPDwttGrZqaJFRXrI9qgHZ1sfJzS1trrVOw4eLPvyrYeNnceT95onnAUT0Tqu+kYgGRNSO/yZ6MXvxY1UAOeNwyz9/B/lU6i9ebIyBX+u5H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6810.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199021)(6666004)(478600001)(83380400001)(2616005)(6506007)(186003)(36756003)(26005)(6512007)(38100700002)(86362001)(6486002)(41300700001)(316002)(66556008)(66946007)(66476007)(7416002)(4326008)(6636002)(2906002)(44832011)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NwUyEbmQ3OSVXRgkFn67u/YIvNI4qI4/Eb8LqLaCzjp9k82NV33Bi86ZJMxC?=
 =?us-ascii?Q?tKl/HTFe6H2t/+zj8m9aL2HgZ+ibUYa5gLj+JvfTZgx4fg56fxnjIau9YaUK?=
 =?us-ascii?Q?d3beic2Kr9Czujfn9Gedet5N6NjCF0PfAk4DKsVnjOKuTZXSMJ7zfGneelID?=
 =?us-ascii?Q?0+fRJpv6sbcgsLuk84wLLOgREWVTL+RQV5KcJBa8lXA1UYi321lSqLLArIvz?=
 =?us-ascii?Q?SqUdLDCdLqdDqHXiFI5rnss5pJ7oIk94gaQ8HVaZGdVVd6yBWH/rmcNGkCGx?=
 =?us-ascii?Q?tGTABEKXbqyIcPAKao7kGPgjBr6ozomWTjSgBFT/U/onWcpenYQuuT56hqTQ?=
 =?us-ascii?Q?J5S1LKhloncGZNYBX0pOSw3cDcEWWPdtwnEmHWgZ4gwrVZQ6MOrZ9kOt5OCf?=
 =?us-ascii?Q?ExUfiQV+Y2rL62dHkzFzu1K5dCjZ8KdePg3bU5I+qcBIGWVQ7Xh0X/195CEm?=
 =?us-ascii?Q?AjQ3JH/JWeXX71NN1s7bTHjywrcBeqMwtD2XeIcJYInLk9G51+c1IQpeFiwH?=
 =?us-ascii?Q?ci+2eW8Spqf55V690m2mCeUYUGTGKqML4InisxccRagdeTsBevla/uHtLmCm?=
 =?us-ascii?Q?AzkdkqM7uXz96syaYVxiayCW21r74BiCQIq62lNDeNHLSGRRcc4taNkXdepA?=
 =?us-ascii?Q?6my/NkuWAN6tUBsvg3+eI1fn4/YvEOfcvJBAANxjpPGDyX+sn+BwALItKuCA?=
 =?us-ascii?Q?VtSwxS385HT1RiDfAx0mjj12d8TZCTdAclZ29knbeiCSWUoZjPrKDn0yiLXx?=
 =?us-ascii?Q?iqVPAQpwHiUq+88ebM6nVnIyLNeFIw0QKX+loa2ZFGQAA8SnKT4pDPZE2ftw?=
 =?us-ascii?Q?pEYoeLo4Izgl64gAeGAdl5EHuBmlg1XDrRPgecF/xelabLAzceoGRvTZDycv?=
 =?us-ascii?Q?yBvQIPxHSPYXqBMXevFTkT7aJsiOpcZjIfqL5IQAee6/oSHj1LSPFg1rwprZ?=
 =?us-ascii?Q?4BhFxtm+68lwVXELUbacUembKXT247ZMJlyWGoLWsN1ZRwIZpv/KQtkaAO0Q?=
 =?us-ascii?Q?AprUOZA+yswkK3pzcuHAN/qOcKSJUX+OR9nvq+JzH84QzhQLzKFMYv3rAN3o?=
 =?us-ascii?Q?AtmhwP/h64ry5f/vrCtquC6BOP/XFsA5ubi3UV93MHjuDAflwBOr0MupevB7?=
 =?us-ascii?Q?JkJfhdFjL0Ka9dAcEmgcfkB0GgyyEmtcc5xnhRMbTDm5egXbtmXzWw1faIrk?=
 =?us-ascii?Q?Idn+0hFleL3qF0Q0JyHFa+C+zHFaQogKIY48p69XaG/mgDgqI4NlreY8oylM?=
 =?us-ascii?Q?+afjZY2V4LyhIc0MoZDRhuO16JtInNV2UhkWm7bAm5Bq9LBoAD2KqKsaLs3p?=
 =?us-ascii?Q?QLB+YpU1r5bMo9oDPjmx9Ciihn2XjUw6T26OBPIS+XjCo6I9XYARK5EYs1xU?=
 =?us-ascii?Q?H82H+0s4RtsdARDWWRDFxw8cDYL5C+o5kUSpxOHHGlh3dZQRCyuWMsGe5qZB?=
 =?us-ascii?Q?Kjjn3wdN5JQOAkjZi0yqzgDAwveOWpku2Ac5/OqUqG9JsQJ4Unid69Ek97Jx?=
 =?us-ascii?Q?0MuIId5YfUzxltOokGISl70eRivePdycawrccWAw/Nkd1DSCDP9RDa/U+SiZ?=
 =?us-ascii?Q?NYisBDQ+EHJIL4vwxzgcgpFAbiGBa/Z5nwFNtHOQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?rrea3AqaECYHuvisDa0QnI+HtvlsSz5W4S1cC8Rc9wqZBpsFzXNMpuTAtutx?=
 =?us-ascii?Q?gMFi2pHlVJtEcx4d48OMu6KPe62RGAPCySwPSrYqQBn2tqLbjA+CvnjAQy3Y?=
 =?us-ascii?Q?oU73Ypp9Bq2ZWi643hdkyMqgIVGheSaeqUiWnpqwZ+9dnwwzjjzGZap8j9o2?=
 =?us-ascii?Q?8DMFGlslLzxcaw7eb9bpTwccOB/jlFt88N0up70JDNk7SWM3/uCWhMzZaULn?=
 =?us-ascii?Q?yq5nYGK11GycYYE5F4WubTnVD60OsJ6s4TgTryM5/ddWDspdm9SzAmOlCXN0?=
 =?us-ascii?Q?NvLywNJWPFUMBEa7OtTPMbOpJBOTK6XGvyN9id0vlWRtUJGSUYPJ+gLYOv1A?=
 =?us-ascii?Q?/47gGaNlaxC0x/jsjOpRYyxoqqfaYtzMGhyLbmk5Yy24fgf8fVcDuOT+2b8P?=
 =?us-ascii?Q?jSeoRbC0R7bnCnhIgU45CAW598mD6Zfj7rjbEHg4w0Ut+lwT8BkgEUs7RT0N?=
 =?us-ascii?Q?D93dxZEEpTZTdyn0rGKO0CAuLyjogUfRzVFOQvJSbv2pmT4SNdYPvOKtN6gi?=
 =?us-ascii?Q?siASrZ5jHvUuJ4pTMypiJ/gsRnYIP+NNxoUJbIHpbCfd3WITePDSjCODFA0u?=
 =?us-ascii?Q?XHMfa4VTMfYqN5gSpQpleVsGEjFeruQeQvNi21luJzRO6iPT+xCV6EKLWAOj?=
 =?us-ascii?Q?ZeRQcc9SW5HR3sspdNrzVQCtCg5ivIqcQWxZbUqkx1ZMd4SW0iBNatCs7QV4?=
 =?us-ascii?Q?zpg/3sXqnrjYlXOyYsZ1RngbUVooEMkMtdw+tSUU4EdVKCPyOBnuKqYXTGUS?=
 =?us-ascii?Q?1xfdXQbagrU/NBinuHjTm8n79OXyR1zNJ6cV4COW/djlKaA9wlI3SRgHQer7?=
 =?us-ascii?Q?jCtezOjhlMKnZQsqotYcfZTGkuamKr6SJnDVrNg8E2pP4cpgxvaFUh498fCJ?=
 =?us-ascii?Q?sqCQkp/Rqw4tO1msW5DmqvZxilfwe4STIqrmFnLI4gM5NUfpr15g2phMdtEY?=
 =?us-ascii?Q?yfXkEds5JXEHfHRmhzfLJee3fj8DIxoYiwNPs3CZdo1FCPEYV1B2lnpmLW6f?=
 =?us-ascii?Q?uthKczI7GJ+1n/IsdXiAW2RfsbVJS8WQ2uJ1QEHv3fayXCbmHL4sF/gSf/uh?=
 =?us-ascii?Q?T4i+J8HagiXO8Ny/2RccGCmumY6KuW4INC4EbJUKPdnYvgZoBFIYDhEcHl1e?=
 =?us-ascii?Q?680xgRglzmV/vYIP8RZJBLARHEPil0v/8Rop4FNE+OCMzxG/xh/ggEKoooKx?=
 =?us-ascii?Q?dxRs6IypryTzpg0d/7ASjFLPpzaYuCYuyMUBcucnHZtQrCUq64XOzD3KAD1M?=
 =?us-ascii?Q?NG5FXRUl8T2kRKxRWyHhvgSoOramwlQW20VSdObu/kFTwGLHW183voch+74Z?=
 =?us-ascii?Q?TmK1CrTjpUzVNXq7Un4tIQAN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 108f3ebd-3d4a-49e1-be5e-08db467643f5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6810.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 16:49:56.6046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rgoIJBTgt795gDaTidhQEU1K6uP+vNhFJJFVKn2y/41E0PjUS2HB0lG10ucFYzQpBsNq279c+mRxBJcA7MHWiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6913
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_08,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 mlxlogscore=641 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304260148
X-Proofpoint-GUID: 9VjU5Vai42hnSpoIwODJyFWAqxNiSaGt
X-Proofpoint-ORIG-GUID: 9VjU5Vai42hnSpoIwODJyFWAqxNiSaGt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add a bit to vm_flags to indicate a vma shares PTEs with others. Add
a function to determine if a vma shares PTE by checking this flag.
This is to be used to find the shared page table entries on page fault
for vmas sharing PTE.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h             | 8 ++++++++
 include/trace/events/mmflags.h | 3 ++-
 mm/internal.h                  | 5 +++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1f79667824eb..539becab551a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -326,11 +326,13 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_HIGH_ARCH_BIT_2	34	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_3	35	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_4	36	/* bit only usable on 64-bit architectures */
+#define VM_HIGH_ARCH_BIT_5	37	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_0	BIT(VM_HIGH_ARCH_BIT_0)
 #define VM_HIGH_ARCH_1	BIT(VM_HIGH_ARCH_BIT_1)
 #define VM_HIGH_ARCH_2	BIT(VM_HIGH_ARCH_BIT_2)
 #define VM_HIGH_ARCH_3	BIT(VM_HIGH_ARCH_BIT_3)
 #define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
+#define VM_HIGH_ARCH_5	BIT(VM_HIGH_ARCH_BIT_5)
 #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
 
 #ifdef CONFIG_ARCH_HAS_PKEYS
@@ -372,6 +374,12 @@ extern unsigned int kobjsize(const void *objp);
 # define VM_MTE_ALLOWED	VM_NONE
 #endif
 
+#ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
+#define VM_SHARED_PT	VM_HIGH_ARCH_5
+#else
+#define VM_SHARED_PT	VM_NONE
+#endif
+
 #ifndef VM_GROWSUP
 # define VM_GROWSUP	VM_NONE
 #endif
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 9db52bc4ce19..26f751e76c46 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -194,7 +194,8 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY,	"softdirty"	)		\
 	{VM_MIXEDMAP,			"mixedmap"	},		\
 	{VM_HUGEPAGE,			"hugepage"	},		\
 	{VM_NOHUGEPAGE,			"nohugepage"	},		\
-	{VM_MERGEABLE,			"mergeable"	}		\
+	{VM_MERGEABLE,			"mergeable"	},		\
+	{VM_SHARED_PT,			"sharedpt"	}		\
 
 #define show_vma_flags(flags)						\
 	(flags) ? __print_flags(flags, "|",				\
diff --git a/mm/internal.h b/mm/internal.h
index 7920a8b7982e..4d60d2d5fe19 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1042,4 +1042,9 @@ struct vma_prepare {
 	struct vm_area_struct *remove;
 	struct vm_area_struct *remove2;
 };
+
+static inline bool vma_is_shared(const struct vm_area_struct *vma)
+{
+	return vma->vm_flags & VM_SHARED_PT;
+}
 #endif	/* __MM_INTERNAL_H */
-- 
2.37.2

