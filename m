Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB7B6EF8BA
	for <lists+linux-arch@lfdr.de>; Wed, 26 Apr 2023 18:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjDZQvG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Apr 2023 12:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbjDZQvE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Apr 2023 12:51:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9405F7EC8;
        Wed, 26 Apr 2023 09:50:54 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QEiVjL023324;
        Wed, 26 Apr 2023 16:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Edtv/rXrLh+RAvkBVKVzY+P/b5NeCvWwYrh6g8zNRzA=;
 b=JCV9Qq1P25GXfMMotXyEYJB8t/PKsrYZcBtFYw4ou4ExrS/KW792k7+fuFX7O6L6m0Om
 TfRUj+ZiGqG/shJOIRom5va//tnsbDZkHWCrto7pMUdpb29f0gBwlPRBkwZPMqUMgb1O
 a1UaTmeXJdHcpyHVzV7DGP3p53DpPte+nAB8rurx/xn3CzF/ZB/6mGzl2pbzlD7Sfxg3
 Ote9nR6KfSjOplddXTLomuQMZVe7TbBXutlUThARguS+tb/cknZezOnDN6MOLZNncOUD
 McyKa2cOY0IOldPjvMInI2mm41/GFfVqgHKuXepxe4Y8MMdv8+0wg3Nbkk9cpZckDBg3 9w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q466222sq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Apr 2023 16:50:09 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33QFfqVM032877;
        Wed, 26 Apr 2023 16:50:08 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4618dqt0-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Apr 2023 16:50:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYSyv1rLsAn1vstsYdXPlvQv9fBdduLsZYebQZTyQtseC9rso0RAPPWoFa7R4NOHok9JMOcAerk29Q7vrFo0xzKeAkUWDXcOHgmIQ/Y1NvZeEgFB0mCscNJq8OHQqBVmVx7dmcZBmzk+nvycFWIDx61IJ47W4urxwmYMSDXXJbnG1xDQFr2HeBb0zNS3NT0AdaBO5QM7s75Orl+aL0CzZCq62u6qhJwo31KS1saM/4KasekTykbds7h/FAl/qQRzhLl+omAnM9ntop/Lka11+6uyOX59kMKGUtqwB6K8rmk3Snpk2yTcXCYXix9Z5gdh1xGLs+vGKXeDOE+XsvK44g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Edtv/rXrLh+RAvkBVKVzY+P/b5NeCvWwYrh6g8zNRzA=;
 b=lLKN1nrUJZox0qbgV/UX59cVN5LSx6+y5wQXYu2MO/78toIOeRPj6d/VpufymGiPF2zXQ0JTMrS89u4FMb9KXYAWOqHPEaM25QzU/60VmRz3zH7gQPdQXQMbvFNeDLueUB1PGG41NhALBNkfEgkOUwo5ub3zmarlhOMSVB6gVqdG4/fO9C5qdusxJAKO012CTCcOOcFqpWfExlJtU9r1428/qXRC2lX9v4yec9bxbAqIJhxUdt7Gb+3nQN52Wk6MUDkJPk5EJJPLJ2P3Pv2zLXeogkaMfB5JUcOWqD+aEVZA8T+ga4WT2UJ78CQ6HpiJWGnDGYxzEqcuWLR0RXwuMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Edtv/rXrLh+RAvkBVKVzY+P/b5NeCvWwYrh6g8zNRzA=;
 b=C1RkdcZ1Yqal+dDCB/o5M9vEIIxDLmIIxlYLNqitPC0rQcNGwEZmHiMV2xM0NTDX6IhApXEQHc0RCaa1NC8HhzbRIQtWMgZowPLORStw9/InvEqsrfRG9uG8yIre3kGVjAu8Q5IS8XkPWU81UzJM8V6t0JnwEPVauSn+9r8ay+w=
Received: from CH3PR10MB6810.namprd10.prod.outlook.com (2603:10b6:610:140::15)
 by IA0PR10MB6913.namprd10.prod.outlook.com (2603:10b6:208:433::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 16:50:04 +0000
Received: from CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae]) by CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae%5]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 16:50:04 +0000
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
Subject: [PATCH RFC v2 4/4] mm/ptshare: Add page fault handling for page table shared regions
Date:   Wed, 26 Apr 2023 10:49:51 -0600
Message-Id: <9edffd2a12a049a42d9a2c216e3f999aae7e65a4.1682453344.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1682453344.git.khalid.aziz@oracle.com>
References: <cover.1682453344.git.khalid.aziz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:805:de::38) To CH3PR10MB6810.namprd10.prod.outlook.com
 (2603:10b6:610:140::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6810:EE_|IA0PR10MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d7728f-6416-4b0e-993c-08db467648ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SlXtSbuCvg3oE1KP4T5XlxTpikrTsx5uosMfDbpWDOjrs2PVBEk3LOhAf+df6SMPGQft3qDskPVV8d6Jrw3Xx8Q7Cdx0gSIaWesuVBpuB1c8wkMEu4Xx+CqB1BodI8VG3FH/1bkFz8zDmi8cezBTyzfMm0Bv3+etWK2B2LJpXWLZLpUtvNhVB3K2XYKmbN7jEhV553vtaN3HbaKFjVbdaew+ZSk8VBbtb6iolQgtOT2Sn3hu1wVlwT997e3YJmn29MWLintjcdqWzlZWa3iTdlNdKztK7ZtvusELt5D+8L3zJBFK3FEmvE/5A4peCie6wh5ugN9myR7HvTVzeqrR/LaGMXAZjJds7n+reEYl6Rly5Mp+xTnySsz5nWQ52q3FSDeYDlOhHtoeTjiisxlPzhMssw7JgMk9K4zVxoJPLEPagmX/srqMr54dzucs2jW1zd4XIpPMYrNpp1ZwOAjTLdxeGxxPY3a7fmb2QPnbg/5R+lulFmGBd7SMWF3U8lWbX+zYv4KhSekCrSW1FDmXNonqidGKj6j06z6NARL53fjPZkovaXJAqRQ+nvho/NwV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6810.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199021)(6666004)(478600001)(83380400001)(2616005)(6506007)(186003)(36756003)(26005)(6512007)(38100700002)(86362001)(6486002)(41300700001)(316002)(66556008)(66946007)(66476007)(7416002)(4326008)(6636002)(2906002)(30864003)(44832011)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dN0+s8UPOkkdwjUbnryl58VNinOjU2g29ZxoPPRStJTd/Uh/Ku5+bUOc9pPv?=
 =?us-ascii?Q?jXZaMFjvNdTb6wOjzgUNGjwbw1WtdwNg1FuiIZP6p7o+4R87/DyeYOxW5xy2?=
 =?us-ascii?Q?dEmaOZ45UXibM/rjH0Dby6JSN3/Eqgf2ja7hoJqZS6bbaDLunV49E1B8MOSW?=
 =?us-ascii?Q?61NQFafTwIKgRDGvmd2DHlBlwp+qMwwR01oPEHw0HZaTMndYmrMLAaepuHAL?=
 =?us-ascii?Q?VB5B5FgKl6sMGLEFQUM0c90unxi+Wmrf8Okj4m/dIF6kp8UdJFdBmmV4R33T?=
 =?us-ascii?Q?3mmrIqwWeYZerk/gKn3mAevMwHofnNWh92/KwJhV60ajOjr8fhxq/ajcjJW1?=
 =?us-ascii?Q?vq7W/UJcODWBRGw2FsbbXu71HO3A1spdYtMRC8+KO1DLk7rISeug/vk4dMxh?=
 =?us-ascii?Q?T9A/t3xdl/ZEZF3ILG6UjAqLzaLg7MMXajgEbfe0q1bdPMFpKTFkfal+augI?=
 =?us-ascii?Q?3XPpBpOUc1eq9471zdvmDZuYBRMgGLNlYPM/SRekB4HCW+IbCrgoAAqYAoLf?=
 =?us-ascii?Q?En12jEGs7eeM/+Uj8VnPG3KpgwTx986MFyzxoJFge7VAE5MPQtEaAxTzavIF?=
 =?us-ascii?Q?m3PaB7SwCLj0eCJJiTtVyMtLdUop0uXQ+JJ/geYmxa5Vgttll+yELWNH0Jfx?=
 =?us-ascii?Q?1MfX8vm4CLYRj67fr66vo/QM8VBL+zBH6luVCMdQXXAfdxMd/DbwgMj1+BqG?=
 =?us-ascii?Q?m4yTGfIh1VwN+ZlKSfs/4XNsSP06wt16Cg5IIwbEEws1XsLvevaZuliv8vTa?=
 =?us-ascii?Q?q680Dt/a1lCASvkjwxzxo04c39XDINqOqRAdrZaiQMpFrxajw6oTTto0bfmt?=
 =?us-ascii?Q?6CIDeju7jUE24drcK9s3p6nSbzXX/7uGc2VthbxVS3GAzWlmHDT9/XNTdXe6?=
 =?us-ascii?Q?WY3xaORX2vmiBg60oK6umPG2zJXQeoIBLQwZZY4U86gqs2kTwRLJN6ImWqhs?=
 =?us-ascii?Q?ZOZaN5JDavfsbk40PKQ6L5cW2YyhndMdTRlje5yYCHwBDZmoV8QMcm6HZIL+?=
 =?us-ascii?Q?rDTiNH/GYrRwXpenfvSf2rFvyVnqBypAwaSHqjnN0gwIk4GiLDTcUXD9t8At?=
 =?us-ascii?Q?bdgEOkmIu77oWEIrBiaN8RPeeoS20aWh8ng4+nEA5sBcyRM/UjfK3/sWjZs+?=
 =?us-ascii?Q?BYdUUQWKS4Qq2v3L2fGvXT7/Ii3XFHYrKELwgHFnNYBKedGP9Yavx2DCcP9E?=
 =?us-ascii?Q?FC+cQtd0jPQhPCBRTWfdqdniDGePSl4EeSqBT2Q0HCSAutjjx+DPGr3vzFKi?=
 =?us-ascii?Q?kCaPLEZ/mdF3Zf6KOE1UJESCH/H9WN76ryCUje6kYEufUbuppWhtBC7xS71u?=
 =?us-ascii?Q?O/A2Jx0sey094kjHlvjBirt7QaTbQn9P6oihW647ZKH02ydgzZmBTZY+CBkf?=
 =?us-ascii?Q?WefIiZra7mY0B1giA5cG/ZuWrkU+oVDXQNWHzkblqBkZWvT5rt0Jbh+dmhEn?=
 =?us-ascii?Q?7armKzVdHbLTc4n1+U0Z/e21AiC3hyJHTBGzcvgE1FC1yGE6M48UpX2cahC5?=
 =?us-ascii?Q?9E/NRh+6SK1sqzi9pabNpIvf3VjZR8NtapdpR55E4t1xQ7m0OKQizu8dTbTO?=
 =?us-ascii?Q?15S1/xDBmpoUeSkVvc4Krk6jqm9G68llkpkJh8UE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?LLcIZAEun6qq3Ci/TM/UPNMagicFSCoNT8osL62K0UM5alZPuQp1xh/hmFxI?=
 =?us-ascii?Q?C77Ei5yoJ+NLGlYhU7EPCj/TfKN7sNhOzbFY72N6tWwLWnHuenNFXpS5eeF0?=
 =?us-ascii?Q?oYSviLZVBBas0mdM6maM4u46OPgzg8y6eOxxWhBgFW8jEm0VUK6Xlsvz8lmg?=
 =?us-ascii?Q?ZoT72Vb0HCOmL7HSsigT8STfoYldSzPvQrVDYCCovMZasEcm66pd63YSYBbu?=
 =?us-ascii?Q?JvuWUKCm4L+6Qbf8ZQqIIj26nxA8bc6+Pqnj1oatQ4vXI0wfgIVBS4pAMecy?=
 =?us-ascii?Q?UtygSkUA/ClyM+VekfMvcsm8V6+egjzuYl+37riYardWovMqQ297UwtiTmBL?=
 =?us-ascii?Q?qzvcKgDmegOrH+gtgoeFHxYVXR9ekbNQ3sl6WtCW/VwbjZECCD76LaTJspw8?=
 =?us-ascii?Q?StRKmIj4n4/OAs9/5OKfCpR1ieIsLYCsUbZj0aU2AK0yf/1J2SM0GQ5rxMoH?=
 =?us-ascii?Q?CUe97qggPQGRJak5KPLRyKphJ0I9Hi6J3pKblnIYdgxj31m7Ge6fGzsQWcTD?=
 =?us-ascii?Q?8QP9dFKA85E1yIkaRw5Y5uNr33j6vI4yy+ZWuF6vjn2hLE3bAzCeV2Tj9oZG?=
 =?us-ascii?Q?ap8VuwWG6g2C0CAWvAxnVbKfDC7/ba14+hGe5dqWGfXj1UGdV6/Vnd0GKSE2?=
 =?us-ascii?Q?XuF32Ajkdyu+s+llFNGgDv5CK/0XOkOMf+CnNUycN0VVhkk2DKOSWm+jCj0s?=
 =?us-ascii?Q?b77EWGBK3j817AwOpzZLb9OkR1McpjpS21hRtl8+sNUUlgI170OtS292n0Y4?=
 =?us-ascii?Q?9DbJS1z0B1gl7bJqpht8SEDvAMnitO6j5RD/76bdyVcWVQwSkp5t6Zqb4bAr?=
 =?us-ascii?Q?X5w/9LhGILNC0pZg+rIe44ANNfxgP77AiF0hoUrelS1qfuV9x6JhH4lKJ85+?=
 =?us-ascii?Q?m8paHb/dIgoVHNx0opi0a+rsUiiYAnNiZm2b1CwLWCPBzLUFyQiI7JPUSMpt?=
 =?us-ascii?Q?KbKuGAgL3/UFfXzBYyi+6/fybVAh61uMpveVUof7mzhgB94enM5EQC9TtYfn?=
 =?us-ascii?Q?9DiiLabm9afOWx+2RPDS3qrehShKuEzPKhd8qxvoq6NkrT6cFcRWpcpOSdit?=
 =?us-ascii?Q?jXUTIydRWGm5AGvlMoASnZnF9Ea77giWnHswKF6Heocs0GqstqMmhu+LTzvp?=
 =?us-ascii?Q?hi1KSvTgJqmM/UhBN2fjscxQ06kkhjjiysS/Exa72rt+kq6YTMm5wRvydz/G?=
 =?us-ascii?Q?JMZcwX8sXkbjCrUrJLxa/C+CCL8hvmCA18nDicaFsF0z2NFMasDJMTOzvA5/?=
 =?us-ascii?Q?giv4+7VEjgDvx5GGiWZmG7HgtOnZHHLFLRLS8KGfzluWsWL5mnc/EimuTS7V?=
 =?us-ascii?Q?tXjDO4jqAcTX7LEY/rgcV1+I?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d7728f-6416-4b0e-993c-08db467648ac
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6810.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 16:50:04.5724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uDEt9OqIUnFU9nE0b3x5Cn8ENbel0y8E16/M/aGd1xQhIxv8RKbEwQ+Nkh3O74C6UnVsejjcO/f8LxXFdUZuUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6913
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_08,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304260148
X-Proofpoint-ORIG-GUID: r9sQ-rPi09Y3_H-iTY4u9aOCzyz8DFKw
X-Proofpoint-GUID: r9sQ-rPi09Y3_H-iTY4u9aOCzyz8DFKw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add support for creating a new set of shared page tables in a new
mm_struct upon mmap of an region that can potentially share page
tables. Add page fault handling for this now shared region. Modify
free_pgtables path to make sure page tables in the shared regions
are kept intact when a process using page table region exits and
there are other mappers for the shared region. Clean up mm_struct
holding shared page tables when the last process sharing the region
exits.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/internal.h |   2 +
 mm/memory.c   | 105 ++++++++++++++++++++++++++++++------
 mm/ptshare.c  | 143 ++++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 232 insertions(+), 18 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 3efb8738e26f..924065f721fe 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1061,4 +1061,6 @@ struct ptshare_data {
 int ptshare_new_mm(struct file *file, struct vm_area_struct *vma);
 void ptshare_del_mm(struct vm_area_struct *vm);
 int ptshare_insert_vma(struct mm_struct *mm, struct vm_area_struct *vma);
+extern vm_fault_t find_shared_vma(struct vm_area_struct **vmap,
+				unsigned long *addrp, unsigned int flags);
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/memory.c b/mm/memory.c
index 01a23ad48a04..c67318ffd001 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -172,17 +172,28 @@ void mm_trace_rss_stat(struct mm_struct *mm, int member)
  * has been handled earlier when unmapping all the memory regions.
  */
 static void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
-			   unsigned long addr)
+			   unsigned long addr, bool shared_pte)
 {
 	pgtable_t token = pmd_pgtable(*pmd);
 	pmd_clear(pmd);
+	/*
+	 * if this address range shares page tables with other processes,
+	 * do not release pte pages. Those pages will be released when
+	 * host mm that hosts these pte pages is released
+	 */
+	if (shared_pte) {
+		tlb_flush_pmd_range(tlb, addr, PAGE_SIZE);
+		tlb->freed_tables = 1;
+		return;
+	}
 	pte_free_tlb(tlb, token, addr);
 	mm_dec_nr_ptes(tlb->mm);
 }
 
 static inline void free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
 				unsigned long addr, unsigned long end,
-				unsigned long floor, unsigned long ceiling)
+				unsigned long floor, unsigned long ceiling,
+				bool shared_pte)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -194,7 +205,7 @@ static inline void free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
 		next = pmd_addr_end(addr, end);
 		if (pmd_none_or_clear_bad(pmd))
 			continue;
-		free_pte_range(tlb, pmd, addr);
+		free_pte_range(tlb, pmd, addr, shared_pte);
 	} while (pmd++, addr = next, addr != end);
 
 	start &= PUD_MASK;
@@ -210,13 +221,19 @@ static inline void free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
 
 	pmd = pmd_offset(pud, start);
 	pud_clear(pud);
-	pmd_free_tlb(tlb, pmd, start);
-	mm_dec_nr_pmds(tlb->mm);
+	if (shared_pte) {
+		tlb_flush_pud_range(tlb, start, PAGE_SIZE);
+		tlb->freed_tables = 1;
+	} else {
+		pmd_free_tlb(tlb, pmd, start);
+		mm_dec_nr_pmds(tlb->mm);
+	}
 }
 
 static inline void free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,
 				unsigned long addr, unsigned long end,
-				unsigned long floor, unsigned long ceiling)
+				unsigned long floor, unsigned long ceiling,
+				bool shared_pte)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -228,7 +245,8 @@ static inline void free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,
 		next = pud_addr_end(addr, end);
 		if (pud_none_or_clear_bad(pud))
 			continue;
-		free_pmd_range(tlb, pud, addr, next, floor, ceiling);
+		free_pmd_range(tlb, pud, addr, next, floor, ceiling,
+				shared_pte);
 	} while (pud++, addr = next, addr != end);
 
 	start &= P4D_MASK;
@@ -250,7 +268,8 @@ static inline void free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,
 
 static inline void free_p4d_range(struct mmu_gather *tlb, pgd_t *pgd,
 				unsigned long addr, unsigned long end,
-				unsigned long floor, unsigned long ceiling)
+				unsigned long floor, unsigned long ceiling,
+				bool shared_pte)
 {
 	p4d_t *p4d;
 	unsigned long next;
@@ -262,7 +281,8 @@ static inline void free_p4d_range(struct mmu_gather *tlb, pgd_t *pgd,
 		next = p4d_addr_end(addr, end);
 		if (p4d_none_or_clear_bad(p4d))
 			continue;
-		free_pud_range(tlb, p4d, addr, next, floor, ceiling);
+		free_pud_range(tlb, p4d, addr, next, floor, ceiling,
+				shared_pte);
 	} while (p4d++, addr = next, addr != end);
 
 	start &= PGDIR_MASK;
@@ -284,9 +304,10 @@ static inline void free_p4d_range(struct mmu_gather *tlb, pgd_t *pgd,
 /*
  * This function frees user-level page tables of a process.
  */
-void free_pgd_range(struct mmu_gather *tlb,
+static void _free_pgd_range(struct mmu_gather *tlb,
 			unsigned long addr, unsigned long end,
-			unsigned long floor, unsigned long ceiling)
+			unsigned long floor, unsigned long ceiling,
+			bool shared_pte)
 {
 	pgd_t *pgd;
 	unsigned long next;
@@ -342,10 +363,18 @@ void free_pgd_range(struct mmu_gather *tlb,
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
-		free_p4d_range(tlb, pgd, addr, next, floor, ceiling);
+		free_p4d_range(tlb, pgd, addr, next, floor, ceiling,
+				shared_pte);
 	} while (pgd++, addr = next, addr != end);
 }
 
+void free_pgd_range(struct mmu_gather *tlb,
+			unsigned long addr, unsigned long end,
+			unsigned long floor, unsigned long ceiling)
+{
+	_free_pgd_range(tlb, addr, end, floor, ceiling, false);
+}
+
 void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
 		   struct vm_area_struct *vma, unsigned long floor,
 		   unsigned long ceiling)
@@ -375,16 +404,20 @@ void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
 		} else {
 			/*
 			 * Optimization: gather nearby vmas into one call down
+			 * but make sure vmas not sharing page tables do
+			 * not get combined with vmas sharing page tables
 			 */
 			while (next && next->vm_start <= vma->vm_end + PMD_SIZE
-			       && !is_vm_hugetlb_page(next)) {
+			       && !is_vm_hugetlb_page(next)
+			       && (vma_is_shared(next) == vma_is_shared(vma))) {
 				vma = next;
 				next = mas_find(&mas, ceiling - 1);
 				unlink_anon_vmas(vma);
 				unlink_file_vma(vma);
 			}
-			free_pgd_range(tlb, addr, vma->vm_end,
-				floor, next ? next->vm_start : ceiling);
+			_free_pgd_range(tlb, addr, vma->vm_end,
+				floor, next ? next->vm_start : ceiling,
+				vma_is_shared(vma));
 		}
 		vma = next;
 	} while (vma);
@@ -5181,6 +5214,8 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 			   unsigned int flags, struct pt_regs *regs)
 {
 	vm_fault_t ret;
+	bool shared = false;
+	struct mm_struct *orig_mm;
 
 	__set_current_state(TASK_RUNNING);
 
@@ -5191,6 +5226,16 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 	if (ret)
 		return ret;
 
+	orig_mm = vma->vm_mm;
+	if (unlikely(vma_is_shared(vma))) {
+		ret = find_shared_vma(&vma, &address, flags);
+		if (ret)
+			return ret;
+		if (!vma)
+			return VM_FAULT_SIGSEGV;
+		shared = true;
+	}
+
 	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
 					    flags & FAULT_FLAG_INSTRUCTION,
 					    flags & FAULT_FLAG_REMOTE))
@@ -5212,6 +5257,36 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 
 	lru_gen_exit_fault();
 
+	/*
+	 * Release the read lock on shared VMA's parent mm unless
+	 * __handle_mm_fault released the lock already.
+	 * __handle_mm_fault sets VM_FAULT_RETRY in return value if
+	 * it released mmap lock. If lock was released, that implies
+	 * the lock would have been released on task's original mm if
+	 * this were not a shared PTE vma. To keep lock state consistent,
+	 * make sure to release the lock on task's original mm
+	 */
+	if (shared) {
+		int release_mmlock = 1;
+
+		if (!(ret & VM_FAULT_RETRY)) {
+			mmap_read_unlock(vma->vm_mm);
+			release_mmlock = 0;
+		} else if ((flags & FAULT_FLAG_ALLOW_RETRY) &&
+			(flags & FAULT_FLAG_RETRY_NOWAIT)) {
+			mmap_read_unlock(vma->vm_mm);
+			release_mmlock = 0;
+		}
+
+		/*
+		 * Reset guest vma pointers that were set up in
+		 * find_shared_vma() to process this fault.
+		 */
+		vma->vm_mm = orig_mm;
+		if (release_mmlock)
+			mmap_read_unlock(orig_mm);
+	}
+
 	if (flags & FAULT_FLAG_USER) {
 		mem_cgroup_exit_user_fault();
 		/*
diff --git a/mm/ptshare.c b/mm/ptshare.c
index f6784268958c..e0991a877355 100644
--- a/mm/ptshare.c
+++ b/mm/ptshare.c
@@ -13,6 +13,136 @@
 #include <asm/pgalloc.h>
 #include "internal.h"
 
+/*
+ */
+static pmd_t
+*get_pmd(struct mm_struct *mm, unsigned long addr)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	pgd = pgd_offset(mm, addr);
+	if (pgd_none(*pgd))
+		return NULL;
+
+	p4d = p4d_offset(pgd, addr);
+	if (p4d_none(*p4d)) {
+		p4d = p4d_alloc(mm, pgd, addr);
+		if (!p4d)
+			return NULL;
+	}
+
+	pud = pud_offset(p4d, addr);
+	if (pud_none(*pud)) {
+		pud = pud_alloc(mm, p4d, addr);
+		if (!pud)
+			return NULL;
+	}
+
+	pmd = pmd_offset(pud, addr);
+	if (pmd_none(*pmd)) {
+		pmd = pmd_alloc(mm, pud, addr);
+		if (!pmd)
+			return NULL;
+	}
+
+	return pmd;
+}
+
+/*
+ * Find the shared pmd entries in host mm struct and install them into
+ * guest page tables.
+ */
+static int
+ptshare_copy_pmd(struct mm_struct *host_mm, struct mm_struct *guest_mm,
+			struct vm_area_struct *vma, unsigned long addr)
+{
+	pgd_t *guest_pgd;
+	p4d_t *guest_p4d;
+	pud_t *guest_pud;
+	pmd_t *host_pmd;
+	spinlock_t *host_ptl, *guest_ptl;
+
+	guest_pgd = pgd_offset(guest_mm, addr);
+	guest_p4d = p4d_offset(guest_pgd, addr);
+	if (p4d_none(*guest_p4d)) {
+		guest_p4d = p4d_alloc(guest_mm, guest_pgd, addr);
+		if (!guest_p4d)
+			return 1;
+	}
+
+	guest_pud = pud_offset(guest_p4d, addr);
+	if (pud_none(*guest_pud)) {
+		host_pmd = get_pmd(host_mm, addr);
+		if (!host_pmd)
+			return 1;
+
+		get_page(virt_to_page(host_pmd));
+		host_ptl = pmd_lockptr(host_mm, host_pmd);
+		guest_ptl = pud_lockptr(guest_mm, guest_pud);
+		spin_lock(host_ptl);
+		spin_lock(guest_ptl);
+		pud_populate(guest_mm, guest_pud,
+			(pmd_t *)((unsigned long)host_pmd & PAGE_MASK));
+		put_page(virt_to_page(host_pmd));
+		spin_unlock(guest_ptl);
+		spin_unlock(host_ptl);
+	}
+
+	return 0;
+}
+
+/*
+ * Find the shared page tables in hosting mm struct and install those in
+ * the guest mm struct
+ */
+vm_fault_t
+find_shared_vma(struct vm_area_struct **vmap, unsigned long *addrp,
+			unsigned int flags)
+{
+	struct ptshare_data *info;
+	struct mm_struct *host_mm;
+	struct vm_area_struct *host_vma, *guest_vma = *vmap;
+	unsigned long host_addr;
+	pmd_t *guest_pmd, *host_pmd;
+
+	if ((!guest_vma->vm_file) || (!guest_vma->vm_file->f_mapping))
+		return 0;
+	info = guest_vma->vm_file->f_mapping->ptshare_data;
+	if (!info) {
+		pr_warn("VM_SHARED_PT vma with NULL ptshare_data");
+		dump_stack_print_info(KERN_WARNING);
+		return 0;
+	}
+	host_mm = info->mm;
+
+	mmap_read_lock(host_mm);
+	host_addr = *addrp - guest_vma->vm_start + host_mm->mmap_base;
+	host_pmd = get_pmd(host_mm, host_addr);
+	guest_pmd = get_pmd(guest_vma->vm_mm, *addrp);
+	if (!pmd_same(*guest_pmd, *host_pmd)) {
+		set_pmd(guest_pmd, *host_pmd);
+		mmap_read_unlock(host_mm);
+		return VM_FAULT_NOPAGE;
+	}
+
+	*addrp = host_addr;
+	host_vma = find_vma(host_mm, host_addr);
+	if (!host_vma)
+		return VM_FAULT_SIGSEGV;
+
+	/*
+	 * Point vm_mm for the faulting vma to the mm struct holding shared
+	 * page tables so the fault handling will happen in the right
+	 * shared context
+	 */
+	guest_vma->vm_mm = host_mm;
+
+	return 0;
+}
+
 /*
  * Create a new mm struct that will hold the shared PTEs. Pointer to
  * this new mm is stored in the data structure ptshare_data which also
@@ -38,6 +168,7 @@ ptshare_new_mm(struct file *file, struct vm_area_struct *vma)
 	new_mm->task_size = len;
 	if (!new_mm->task_size)
 		new_mm->task_size--;
+	new_mm->owner = NULL;
 
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info) {
@@ -63,7 +194,7 @@ ptshare_new_mm(struct file *file, struct vm_area_struct *vma)
  * insert vma into mm holding shared page tables
  */
 int
-ptshare_insert_vma(struct mm_struct *mm, struct vm_area_struct *vma)
+ptshare_insert_vma(struct mm_struct *host_mm, struct vm_area_struct *vma)
 {
 	struct vm_area_struct *new_vma;
 	int err = 0;
@@ -80,12 +211,18 @@ ptshare_insert_vma(struct mm_struct *mm, struct vm_area_struct *vma)
 	 */
 	vm_flags_clear(new_vma, (VM_SHARED | VM_SHARED_PT));
 	vm_flags_set(new_vma, VM_NOHUGEPAGE);
-	new_vma->vm_mm = mm;
+	new_vma->vm_mm = host_mm;
 
-	err = insert_vm_struct(mm, new_vma);
+	err = insert_vm_struct(host_mm, new_vma);
 	if (err)
 		return -ENOMEM;
 
+	/*
+	 * Copy the PMD entries from host mm to guest so they use the
+	 * same PTEs
+	 */
+	err = ptshare_copy_pmd(host_mm, vma->vm_mm, vma, vma->vm_start);
+
 	return err;
 }
 
-- 
2.37.2

