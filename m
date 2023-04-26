Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A6B6EF8BE
	for <lists+linux-arch@lfdr.de>; Wed, 26 Apr 2023 18:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbjDZQvd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Apr 2023 12:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbjDZQvb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Apr 2023 12:51:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4CA7EFC;
        Wed, 26 Apr 2023 09:51:11 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QEiQag003816;
        Wed, 26 Apr 2023 16:50:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=k5APzXW/ZudHfSFqhzk49VAejkMZvRzADzPwN1MsmQk=;
 b=BtTlHT82OJd+muyZdKptmotc8VtIEt9/5r3DTc1YQRwO7hUcSXoIcl50xwW4I8FxqTif
 jqr5XweMI1+yxcDmlVN8SaU0iqglTY7J/zpLRaeVejdReYW7oN10lGGPv/7mnz7Gu9L2
 jksgcpNwyn2eHjQ79jXglqUs2ejk4tnQwiE40GfbXRdmA2EdQxRVBqtN6m4oQR1+RSv5
 MWCo0I6AOody2hjSHP5zuPPW4TtmlZ56BfOQkH4Ba6tNgv2w3fz5CfxUIE4oZJADvaOp
 gVLWYp7d7gGC5JxA8KE1TZu+UQ4KdqI4ay0cp1/ezQ4oJgShfXZd0xjNmN7QuxkxFTiY 0g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q484usxpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Apr 2023 16:50:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33QFfqVL032877;
        Wed, 26 Apr 2023 16:50:07 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4618dqt0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Apr 2023 16:50:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZWPlwczlKUjolSGUggemrBBvNFmyg7x0RZpTFEpaPX1OFm8rxpfgq6Ungb1UNLjnywsmxfu2UPJOVd3yiKOal854CoCTipeWd2lq3A1Kpyeuxw3pB76wAkfg0vVeBJanQEaGZHvSB6YjPC6eT8RVzonDRmVY7ZJhekOt88uGA35BpjJoCspX4vyGHyIrpwtOfkoMyb8k1aaRkpYZD6iiuWptaGWha0Ev+w8Z6Xxybceu2EDf/ZVNUd0YMXlDYPTctPOPcP/z+2OakkJxe+mBqMNskCPl4O0pvgmEVRl8YhcfuWKngaI77x4h7K5GrXU2CCxTpjUUCu7svW8Ii/AyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5APzXW/ZudHfSFqhzk49VAejkMZvRzADzPwN1MsmQk=;
 b=J3Gp6krS1peVROKEc4tltzGIhkvO42MIcDJRPC4bu1c52gK4N5tLBb7g7/unyy7B9p+KY06d2xIjalj7+xh0oRQhVYH9jEBV9rFxiGRq1HphugmD3K4tjhohtD+J2d6WIYU8Zf33eGFicxc2K1yWybrkxOWcZiVhs3j5I82WXGXU9DkRSWHHwr6yXQY1ygd+35AWn/B/PDVVAA2pQQrkEjktKklGvxMs5DKwsOx9lWsSnT/md5mHknNcFYpv0YvlEmKeAUwBUGPcVVjQK/5q8/MBbMf26sNxyXwSsX6XYy9ZK9pZN4dQDhd1pP0NM6ngrJmpfV3CemNLqPzEN7fZ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5APzXW/ZudHfSFqhzk49VAejkMZvRzADzPwN1MsmQk=;
 b=gY0ipTXiaDjOCOtaC4eLVtmqXNCVfZoFdjZx+p5jXEck0NlevNO5MlPcEKp3tztXAD2kXCh4Oi64AaE88hCdBXsAxJ94PRYfHEJ/8MR7yKaYzGLzxtslrhfrq19jZDH9m2x8Dh+Y69jenmHgCgDT0uZp86zqmK5Nx0rBArJeV10=
Received: from CH3PR10MB6810.namprd10.prod.outlook.com (2603:10b6:610:140::15)
 by IA0PR10MB6913.namprd10.prod.outlook.com (2603:10b6:208:433::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 16:50:02 +0000
Received: from CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae]) by CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae%5]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 16:50:02 +0000
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
Subject: [PATCH RFC v2 3/4] mm/ptshare: Create new mm struct for page table sharing
Date:   Wed, 26 Apr 2023 10:49:50 -0600
Message-Id: <1fd52581f4e4960a4d07cb9784d56659ec139d3c.1682453344.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1682453344.git.khalid.aziz@oracle.com>
References: <cover.1682453344.git.khalid.aziz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:805:de::16) To CH3PR10MB6810.namprd10.prod.outlook.com
 (2603:10b6:610:140::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6810:EE_|IA0PR10MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: 031d9564-3c56-4b34-db61-08db46764722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Kaqs+Hvx6YnhsT33GzL7LJWvKbkjiJiiyoEMm/tE/Vuiir+rgPiZMKvT7fh4ONq61XS1Uf1YEKowIkj/9SV9p89x/FQb4PsMQGMFe5eNOjEfvk6K9QZ0zGWDme3ao+HOHbUbSA69Rpb2YO+c+DxekHd0VeiH0p2R/VUz7eRQqwZyhxzx9zvhu0PiA6AWNW/z83KMj+3voV2zKKsnXeApR5eCxspwriUK78bS2z/DKuUq7WlQjqf0ZZepgz/fBH97Om8cCyXFgGKWqUq+SbMNTwcBuDnt2hqVvlHe8G2Ln55u/xQ1e3lWdJxSpzoDyKPzvBISQVrNEsjyVOcq2qhxbW0GZf0RPaYKaO9ROcWP4zpbeTsm55xm/vVdShlqWMne//ohYwksDkSXA40hlNY7yiKsGMYwPT0hM7rPtfWQu8PCkiF4FsP8aRTQayLCblw3ka+ZjY1EfXg+FBbliBuxSiiHjmTXS3DswEslsggl8Dx82BSPUwlg7ZrSG0njlfy9+mDWW2UuHmgMvOz8sCu2gqktMa2edA6IM81g5OUGInTyzm0aqm+oM3M/rBDCkZ/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6810.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199021)(6666004)(478600001)(83380400001)(2616005)(6506007)(186003)(36756003)(26005)(6512007)(38100700002)(86362001)(6486002)(41300700001)(316002)(66556008)(66946007)(66476007)(7416002)(4326008)(6636002)(2906002)(44832011)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?82zRG2GBDOnMSvuvHnHMCYQZHvtp5npV9L4sWmU21IRIu9Bp1HAAGKP7yrbw?=
 =?us-ascii?Q?zMuaCYQlvnH7+o1MCHSUBRAA4BvMH63NrDRvxUBJx03blPIkmMCBGjMnVDkb?=
 =?us-ascii?Q?STIJQav9gbg85FRigckQqlblBGlySKbXyS/z/khIFfPixviz2KBXQ6shIu+/?=
 =?us-ascii?Q?vYuGr3GTngcZpRUnjJC/ITFBEdO5ayEMSvj1jGpnNMQ6tbQuLx0MKBnQbe+x?=
 =?us-ascii?Q?43hhEOCKMlbEX3uKMn9eAmLfOq1YOVkvnnUdLsdsqFYtClXjjNfWe4I1sWpF?=
 =?us-ascii?Q?E1u04VGJ4XNbYNfz78hOKLlTah+YxyT/Qywl/ZvnAbtUArutWjc5zzt+s3RL?=
 =?us-ascii?Q?Wi+87XavxqvTtpss5v8JBs1z71YT583XWPxM8RkhHr6KTLOGWQMaNSq/ml13?=
 =?us-ascii?Q?u/qBMyFdUbWvRXk/VOVO1V/s3VnoShiPTrE4VxrAEOltB1QlEalZ6yaWaqHB?=
 =?us-ascii?Q?rydhPXUvOCIjIbNL0FVJyESMhQa5Rbao8R4gWv6n0G+kuvAO8rREx7088LXp?=
 =?us-ascii?Q?wPKEN9e6CkdmBRuIJFUi8v4NWXtMPuMdB7Omph6vZWb8MNIdeYkeA8lkU42S?=
 =?us-ascii?Q?k6yN1hjHA9x0cNOtSI6yfDS2K8A5SBqaog2gDnfF7IxTaQVzakGjwIiQy+jA?=
 =?us-ascii?Q?GVzeUvX44RV1LjiI+Rnf6vsWGhsexJerOzhAWgaj8TE7E/WnNkbPCHA8TqFQ?=
 =?us-ascii?Q?401G3CzprTHckqtKV9FoUr80ajGVoh8MYGeyp2OOFsj+bZKKgHV2b9uyAgXc?=
 =?us-ascii?Q?jnsXAqApGkIiRSfrPDlYhiPakz1I0wFdJuGgNngwNBncO5AEGrLRuOJ6Hzho?=
 =?us-ascii?Q?vsLf/Eb2VrKENhvDpQR/b+puotb5Vl6Uyq3K4gxvdfK6FsXs1fwRm6typBJ1?=
 =?us-ascii?Q?yJhnQV/oUWsmsTK1orJ/3A8H2XO7bC6GcpplH2jp7tp++Y0M10hD1mSI9mLM?=
 =?us-ascii?Q?H0fsqfeAxp4RJaplm5fCmN16LBGXfx6AjKMmjY2g8ad/FdfcdxWur6zItmqk?=
 =?us-ascii?Q?CEl9aIpEQWiQg2TU6dtEQQ/bco84LMzU7cIl8nOiVCdm2FHy3kpuwd1fNejK?=
 =?us-ascii?Q?YiqXhpHVeE6/4OZVGp84jNvx7oUQfLZFPHfBv9UyndWuYq31Z9/dUI+WHM3N?=
 =?us-ascii?Q?GJfsemmH7uI3EX/MKVh2j7Jt3qYccfxqm5fcBJvfRETRuecL7coFmOX41IS7?=
 =?us-ascii?Q?jqdnnUE4SLJ1J1rzEb5iPJsV+lkWYv4sxHdKWgjER459jCX5vju6IoQoXDrJ?=
 =?us-ascii?Q?LQZmRpPG/ykHZrj8BQh5/AOy0rohB4lNGAwunbcoUTtjLTYZSGHobcTKGuxw?=
 =?us-ascii?Q?2aBZDHfq/ZL1imv7O6p54vz9cf867dO5q4WdQnuGewEoOCS2SjaFtc5TAEu5?=
 =?us-ascii?Q?Wkg7YHzMsqQntqzz7kJ7rLP0FzE5Ex1GHEXRAHld/diQgxKmJKUayNr5l64x?=
 =?us-ascii?Q?gRmxmtV35gtvTPq20kR+e7iEXdpLJY8PU+Zoi0UVUukCjS3uTwYyTx3pzv1P?=
 =?us-ascii?Q?f3cfX6X5FuO9+kUNgQLr7IfK6evKcA2LUvkjj0526j1rNRBzd6C5Vi/qC15R?=
 =?us-ascii?Q?4j70cG0qkcctNXIzrXFdsazNsAsTbKVIWX/SpgpE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ECB2OBmhAKVVQgHXYIBoI3/hlHgCauvfqHGZ69z2lM9tj8KDpGLWFtAgaeMF?=
 =?us-ascii?Q?T3ed3TSu0VIhF+qQrYRlh7Z3tSzubAjovWTjl4GRy1S9hC0PZ+Cfx7WoK2j9?=
 =?us-ascii?Q?DFYcMwUpb0QgfhbczlfUzpwDOBVBliXTuOsMJkBlOt9UtYhVTsCg21MgF7y3?=
 =?us-ascii?Q?xosY4zEKNso3oxKBnXjHcnIHyFH/Bc4GU/sZHCFLM4SzxgNpcPanxnbZv/qs?=
 =?us-ascii?Q?NsSen/GM1XLb26VgCZpekkY8VWUl7lO9EGxWeGPR0d+xDPBylWgN6+XXfVYx?=
 =?us-ascii?Q?l8tb0sQKw+/Vrg2uMvhjkxk3GCtlYy/EqNCzX+jsu45M1ekmx9OdxJ68SHs/?=
 =?us-ascii?Q?vDalPsNma/h8XVz2HpserpPRGLvRsdxRQt4bLrZEVN2ZuUU21MbBYQWUBe7G?=
 =?us-ascii?Q?/VN4ckjOcNJq2ZjqYed48UjkTkAuf42C4filSrhHPkBddfimR92nh/DG7NVm?=
 =?us-ascii?Q?u42RY/KpqI29IWAAINb7hNWGVNVCCp6KEwFtQNmw5Ani3rMgVBWdaNlFEVPS?=
 =?us-ascii?Q?TE/AiG7fxle1WukcpC5/MmXMltMpGOv3oocQxKQFjYV8I5abIb855GDWsz+4?=
 =?us-ascii?Q?OVn/Jw4E9Ib9ATLzgFTsI4k7FgHUinO7vgWkcgx2e/j+dyqiqxY6mDHLKl/G?=
 =?us-ascii?Q?QI2R0xOr5ssH75xYYYIBx3xeqL0tqF4bobXcUA/M8aRDImcdQMlkmuIVgX/P?=
 =?us-ascii?Q?eBjIfLoZMzCHYGTaIOxu17ca1keQKeaPAzndY3g3+aIS2tGq+sl88PlU5Ct4?=
 =?us-ascii?Q?Z68+zFrS4CdADZzUzmq7EMYI8BdQYBzP2VdF/eDQ0o3LQ0ekNjPZXguAiyvi?=
 =?us-ascii?Q?vqymsu5hsnHqOS+RhhbtNtOh6P9OGF3RQkbRMT+a2n38XxBeqkuwAPAqVlbc?=
 =?us-ascii?Q?puNj8oFk/pqrTuxELnWOxBkLY1AdSuvBowZKfz/T4UjQJSJGSS7GHmbactoB?=
 =?us-ascii?Q?mTny+qClCh0ZCAgMY7GMo+UqsGyGxAsPE0sTJnbKIENLB3l5Xf95yiVbcr4B?=
 =?us-ascii?Q?JxP55bFPUpZmZpnASX1SqRSswC5g/gr8HilJknmLqYBIn7/Pp00mzfKUE2hI?=
 =?us-ascii?Q?QxOC0gI4h0An/ZkQtgypP4f403On9tAC25PJn0/gV97YUXvAGHnFo1C/tv6h?=
 =?us-ascii?Q?57m1KYNg2jhX6gYWRTJ1R9qWZC68z825UCHtndypw4ayGrTPCQRQP9chmon6?=
 =?us-ascii?Q?PP7ZHEl6HOPbR8QmLCrSqjQyDwzCb9laZ2mvqSGnTPTSSg9k7R54QT4+1WpJ?=
 =?us-ascii?Q?7K0btMlUsbfbtDb9RDgpFBWxvj2BxG6Sp1DwvwzdkpBGxlvSSatQb1nEtTWq?=
 =?us-ascii?Q?1p3hOJjPpaT/vgi2L6dhmfwQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 031d9564-3c56-4b34-db61-08db46764722
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6810.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 16:50:01.9614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLFXNEH4JxGr70AT9ZkSmyGYEH4dTtkU3GVC0+U+7dB59Q/WF2ifcONe9+GBDgVaH11e8tvoCUkVRA8YmmIxuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6913
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_08,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 mlxlogscore=933 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304260148
X-Proofpoint-GUID: QfGvQnN1CUrTTsoTYA2ChFbpzfNp5H01
X-Proofpoint-ORIG-GUID: QfGvQnN1CUrTTsoTYA2ChFbpzfNp5H01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When a process passes MAP_SHARED_PT flag to mmap(), create a new mm
struct to hold the shareable page table entries for the newly mapped
region.  This new mm is not associated with a task.  Its lifetime is
until the last shared mapping is deleted.  This patch also adds a
new pointer "ptshare_data" to struct address_space which points to
the data structure that will contain pointer to this newly created
mm along with properties of the shared mapping. ptshare_data
maintains a refcount for the shared mapping so that it can be
cleaned up upon last unmap.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/fs.h |   2 +
 mm/Makefile        |   2 +-
 mm/internal.h      |  14 +++++
 mm/mmap.c          |  72 ++++++++++++++++++++++++++
 mm/ptshare.c       | 126 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 215 insertions(+), 1 deletion(-)
 create mode 100644 mm/ptshare.c

diff --git a/include/linux/fs.h b/include/linux/fs.h
index c85916e9f7db..db8d3257c712 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -422,6 +422,7 @@ extern const struct address_space_operations empty_aops;
  * @private_lock: For use by the owner of the address_space.
  * @private_list: For use by the owner of the address_space.
  * @private_data: For use by the owner of the address_space.
+ * @ptshare_data: For shared page table use
  */
 struct address_space {
 	struct inode		*host;
@@ -443,6 +444,7 @@ struct address_space {
 	spinlock_t		private_lock;
 	struct list_head	private_list;
 	void			*private_data;
+	void			*ptshare_data;
 } __attribute__((aligned(sizeof(long)))) __randomize_layout;
 	/*
 	 * On most architectures that alignment is already the case; but
diff --git a/mm/Makefile b/mm/Makefile
index 8e105e5b3e29..d9bb14fdf220 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -40,7 +40,7 @@ mmu-y			:= nommu.o
 mmu-$(CONFIG_MMU)	:= highmem.o memory.o mincore.o \
 			   mlock.o mmap.o mmu_gather.o mprotect.o mremap.o \
 			   msync.o page_vma_mapped.o pagewalk.o \
-			   pgtable-generic.o rmap.o vmalloc.o
+			   pgtable-generic.o rmap.o vmalloc.o ptshare.o
 
 
 ifdef CONFIG_CROSS_MEMORY_ATTACH
diff --git a/mm/internal.h b/mm/internal.h
index 4d60d2d5fe19..3efb8738e26f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1047,4 +1047,18 @@ static inline bool vma_is_shared(const struct vm_area_struct *vma)
 {
 	return vma->vm_flags & VM_SHARED_PT;
 }
+
+/*
+ * mm/ptshare.c
+ */
+struct ptshare_data {
+	struct mm_struct *mm;
+	refcount_t refcnt;
+	unsigned long start;
+	unsigned long size;
+	unsigned long mode;
+};
+int ptshare_new_mm(struct file *file, struct vm_area_struct *vma);
+void ptshare_del_mm(struct vm_area_struct *vm);
+int ptshare_insert_vma(struct mm_struct *mm, struct vm_area_struct *vma);
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/mmap.c b/mm/mmap.c
index 8b46d465f8d4..c5e9b7f6de90 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1382,6 +1382,60 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	    ((vm_flags & VM_LOCKED) ||
 	     (flags & (MAP_POPULATE | MAP_NONBLOCK)) == MAP_POPULATE))
 		*populate = len;
+
+#if VM_SHARED_PT
+	/*
+	 * Check if this mapping is a candidate for page table sharing
+	 * at PMD level. It is if following conditions hold:
+	 *	- It is not anonymous mapping
+	 *	- It is not hugetlbfs mapping (for now)
+	 *	- flags conatins MAP_SHARED or MAP_SHARED_VALIDATE and
+	 *	  MAP_SHARED_PT
+	 *	- Start address is aligned to PMD size
+	 *	- Mapping size is a multiple of PMD size
+	 */
+	if (ptshare && file && !is_file_hugepages(file)) {
+		struct vm_area_struct *vma;
+
+		vma = find_vma(mm, addr);
+		if (!((vma->vm_start | vma->vm_end) & (PMD_SIZE - 1))) {
+			struct ptshare_data *info = file->f_mapping->ptshare_data;
+			/*
+			 * If this mapping has not been set up for page table
+			 * sharing yet, do so by creating a new mm to hold the
+			 * shared page tables for this mapping
+			 */
+			if (info == NULL) {
+				int ret;
+
+				ret = ptshare_new_mm(file, vma);
+				if (ret < 0)
+					return ret;
+
+				info = file->f_mapping->ptshare_data;
+				ret = ptshare_insert_vma(info->mm, vma);
+				if (ret < 0)
+					addr = ret;
+				else
+					vm_flags_set(vma, VM_SHARED_PT);
+			} else {
+				/*
+				 * Page tables will be shared only if the
+				 * file is mapped in with the same permissions
+				 * across all mappers with same starting
+				 * address and size
+				 */
+				if (((prot & info->mode) == info->mode) &&
+					(addr == info->start) &&
+					(len == info->size)) {
+					vm_flags_set(vma, VM_SHARED_PT);
+					refcount_inc(&info->refcnt);
+				}
+			}
+		}
+	}
+#endif
+
 	return addr;
 }
 
@@ -2495,6 +2549,22 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 	if (end == start)
 		return -EINVAL;
 
+	/*
+	 * Check if this vma uses shared page tables
+	 */
+	vma = find_vma_intersection(mm, start, end);
+	if (vma && unlikely(vma_is_shared(vma))) {
+		struct ptshare_data *info = NULL;
+
+		if (vma->vm_file && vma->vm_file->f_mapping)
+			info = vma->vm_file->f_mapping->ptshare_data;
+		/* Don't allow partial munmaps */
+		if (info && ((start != info->start) || (len != info->size)))
+			return -EINVAL;
+		ptshare_del_mm(vma);
+	}
+
+
 	 /* arch_unmap() might do unmaps itself.  */
 	arch_unmap(mm, start, end);
 
@@ -2664,6 +2734,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			}
 		}
 
+		if (vm_flags & VM_SHARED_PT)
+			vm_flags_set(vma, VM_SHARED_PT);
 		vm_flags = vma->vm_flags;
 	} else if (vm_flags & VM_SHARED) {
 		error = shmem_zero_setup(vma);
diff --git a/mm/ptshare.c b/mm/ptshare.c
new file mode 100644
index 000000000000..f6784268958c
--- /dev/null
+++ b/mm/ptshare.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Share page table entries when possible to reduce the amount of extra
+ * memory consumed by page tables
+ *
+ * Copyright (C) 2022 Oracle Corp. All rights reserved.
+ * Authors:	Khalid Aziz <khalid.aziz@oracle.com>
+ *		Matthew Wilcox <willy@infradead.org>
+ */
+
+#include <linux/mm.h>
+#include <linux/fs.h>
+#include <asm/pgalloc.h>
+#include "internal.h"
+
+/*
+ * Create a new mm struct that will hold the shared PTEs. Pointer to
+ * this new mm is stored in the data structure ptshare_data which also
+ * includes a refcount for any current references to PTEs in this new
+ * mm. This refcount is used to determine when the mm struct for shared
+ * PTEs can be deleted.
+ */
+int
+ptshare_new_mm(struct file *file, struct vm_area_struct *vma)
+{
+	struct mm_struct *new_mm;
+	struct ptshare_data *info = NULL;
+	int retval = 0;
+	unsigned long start = vma->vm_start;
+	unsigned long len = vma->vm_end - vma->vm_start;
+
+	new_mm = mm_alloc();
+	if (!new_mm) {
+		retval = -ENOMEM;
+		goto err_free;
+	}
+	new_mm->mmap_base = start;
+	new_mm->task_size = len;
+	if (!new_mm->task_size)
+		new_mm->task_size--;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		retval = -ENOMEM;
+		goto err_free;
+	}
+	info->mm = new_mm;
+	info->start = start;
+	info->size = len;
+	refcount_set(&info->refcnt, 1);
+	file->f_mapping->ptshare_data = info;
+
+	return retval;
+
+err_free:
+	if (new_mm)
+		mmput(new_mm);
+	kfree(info);
+	return retval;
+}
+
+/*
+ * insert vma into mm holding shared page tables
+ */
+int
+ptshare_insert_vma(struct mm_struct *mm, struct vm_area_struct *vma)
+{
+	struct vm_area_struct *new_vma;
+	int err = 0;
+
+	new_vma = vm_area_dup(vma);
+	if (!new_vma)
+		return -ENOMEM;
+
+	new_vma->vm_file = NULL;
+	/*
+	 * This new vma belongs to host mm, so clear the VM_SHARED_PT
+	 * flag on this so we know this is the host vma when we clean
+	 * up page tables. Do not use THP for page table shared regions
+	 */
+	vm_flags_clear(new_vma, (VM_SHARED | VM_SHARED_PT));
+	vm_flags_set(new_vma, VM_NOHUGEPAGE);
+	new_vma->vm_mm = mm;
+
+	err = insert_vm_struct(mm, new_vma);
+	if (err)
+		return -ENOMEM;
+
+	return err;
+}
+
+/*
+ * Free the mm struct created to hold shared PTEs and associated data
+ * structures
+ */
+static inline void
+free_ptshare_mm(struct ptshare_data *info)
+{
+	mmput(info->mm);
+	kfree(info);
+}
+
+/*
+ * This function is called when a reference to the shared PTEs in mm
+ * struct is dropped. It updates refcount and checks to see if last
+ * reference to the mm struct holding shared PTEs has been dropped. If
+ * so, it cleans up the mm struct and associated data structures
+ */
+void
+ptshare_del_mm(struct vm_area_struct *vma)
+{
+	struct ptshare_data *info;
+	struct file *file = vma->vm_file;
+
+	if (!file || (!file->f_mapping))
+		return;
+	info = file->f_mapping->ptshare_data;
+	WARN_ON(!info);
+	if (!info)
+		return;
+
+	if (refcount_dec_and_test(&info->refcnt)) {
+		free_ptshare_mm(info);
+		file->f_mapping->ptshare_data = NULL;
+	}
+}
-- 
2.37.2

