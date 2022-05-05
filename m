Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068A951CCFE
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 01:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386960AbiEEX6W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 May 2022 19:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379884AbiEEX6V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 May 2022 19:58:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AACA60D8E;
        Thu,  5 May 2022 16:54:40 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 245LD91r026132;
        Thu, 5 May 2022 23:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=A9+wXYUYyUAGlF0mbEuM+sIc/r/G9bD7HU7dyO9Lgpk=;
 b=NPsXpnRbFZ2cqnmvcfNd7Vo7NR8COb8sN7r9L1iVAjQyG2fn7PnR18mAMF8+/bKrYCe1
 sCf23FEE2+xnhf1H0YzDYRwIYDFKl8JT2jzGxsGs6L9Aomxsy0flQ24tPd8VZ6BfuJIk
 9rjIo/2gac37o7DqzexDd+o9MrqkIfblAwUkz4FTGhFYkNcsIxIq8FH47SdvxKSIpQgT
 gNYdXEe0qH4eYx7+OK3r0j5X45Uw37O2JWwvOFqCVyh7rvIGymVCpTj5l7ncA7rVkzi1
 Ii2Lf2kNK5RIRGT9jgS42h71f4QB6WSv3ByqZcIMXvRtuk2XJA2ndcGm4260sCVJ7aq1 SQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruhcch99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 23:53:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 245Nj2Nf017161;
        Thu, 5 May 2022 23:53:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3frujbc8fg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 23:53:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzDzLX4zeGK99M2hgjcxEU+riDLZKMbl+XZHNwn86KNj4XZDN3JyV90UdVQrc1UN1mx+24GgsCS5Vz7cVlH/YIWM58tif5GBOUv1hPyBBZaqBn4btzHruuwFVxu63LtObYD0qpI/pj0PaQBl9peHRY3Sfm8r6My0Qn/sOhfPRtpRg8bt6uIEXcSrPzsKibDrfHQld79DJvhj9HC7X3XanuIbYBD9v24jUm26Oh5143Z4IudZEd5/+GiPekQ2df2dI5zHimX/HlErFq5+rHqr9jrjCOY5ASC/OpSmKtd32KFIMBaUrFSS+N0MACfOjfgnJiU1wr3z9DPuFJT0EvgItg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9+wXYUYyUAGlF0mbEuM+sIc/r/G9bD7HU7dyO9Lgpk=;
 b=ErvhFWgq5qOuoWZ7GQyiJJDQKBYld6we/cAJBfZdg42wbN+gFrYdJFCm6tbGap11D/b4ffyXIAP/fbo7ucWB/O2ca0eMp2H7w6m4EZK1OCeGIzNB3JraE306FJy61TkrgG7rW0LSndQZpUqFhBABPI4Onf7+agm+Z4UnR+A9+OhnfP/qddru6mHSU0wXJeyMrAS4TbkzJ25l3l3COtLOc8vmJfUAtMDku0rfthUaFxdRvlDpBohVOP9w576xEe4DOW433qQu3htMkZ7+duOv73010h30PAob5mGwfKIxa23+PlicNnjGsnfJLc+/oUqBUckNW7lCQi69W6eoqk4x9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9+wXYUYyUAGlF0mbEuM+sIc/r/G9bD7HU7dyO9Lgpk=;
 b=PCPFOcR+60YMBlMgjAEDFOCLqDKzdHhHUtUfYfQXRqO7lYmZWBNwvegQG8J1DMgzY0Es34exGkbumcukuc7nWG0u3bwUwnZl2bXxH4MFdFwrGGpWllNVwmWrp2DuYW/qxi9AUuDtcV5MzfYRex7E9rwSr2rmZK9SGt2mCXFK9UQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM6PR10MB3833.namprd10.prod.outlook.com (2603:10b6:5:1d2::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Thu, 5 May
 2022 23:53:38 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461%7]) with mapi id 15.20.5206.024; Thu, 5 May 2022
 23:53:38 +0000
Message-ID: <5cab0eca-9630-a7c6-4f5d-5cb45ff82c83@oracle.com>
Date:   Thu, 5 May 2022 16:53:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/3] mm: rmap: Fix CONT-PTE/PMD size hugetlb issue when
 migration
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org, catalin.marinas@arm.com, will@kernel.org
Cc:     tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
        davem@davemloft.net, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
References: <cover.1651216964.git.baolin.wang@linux.alibaba.com>
 <11b92502b3df0e0bba6a1dc71476d79cab6c79ba.1651216964.git.baolin.wang@linux.alibaba.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <11b92502b3df0e0bba6a1dc71476d79cab6c79ba.1651216964.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0390.namprd04.prod.outlook.com
 (2603:10b6:303:81::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e82b4d86-edaf-45f4-aaf8-08da2ef279aa
X-MS-TrafficTypeDiagnostic: DM6PR10MB3833:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3833F118C4D75E89DD34E9D7E2C29@DM6PR10MB3833.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bnkD5keNChWMxZ9gCa6gI9MwwqVTC/KboBefSOEkshNrw9xKbeMD7como7mTxxl8JBRA0a589vu6N3PwJta0VyNGOZ6xTMDJGqalkUZRkvRCbNglbSLla3QapFBaALgZEmXyzunOVT1UfwNU4hQSkmWgEumUsxr2kgJrDmSpY2uq8uBSN/HfrzAnN1OZaOgHkN55joMF81PqarrjDxB2upvXAm3DlaghVcZzu3Rtm+QS/R6aUU6yTRIoraILiVrZh/lZfXchlSr+OuVTldoVNQm2WQF0Orjb2nsjuqlFg/huBHs16XTQof5I31PHzCLWMLhZkQECaiNjzLmQRGHjNTrDebzLPcY26vRUD4Y7POpxWsNjpwHuV+27gnqNiUR2cO7NCfpCUeyRKmyfGsYwGnWvNYAMb/VK2rizSPe3bq/KST80n9GDb4oWjeN6zU1qbTL9aVPVhgf2PqtEAOPgF2HPccKTz3nMpS4v6jvBB4J6XbAiSIefXmu+MdswiS+Q74EVyfbj3y69FnJdzA2442BUVxGE5H43dOG5aK0RPd9ZYJeQPT3IUoqBq2Yxdcabg81HiTNVbkqsOb7shiB73eDuz09gJxeZthxFa6Be1urDDU7nemWmw2o9W81wEMd8k35zw/H+vbIC9XpNe4kjZmBM18/8aKuxI5c+y6OroVwPF1PZGg61q/tA+qjhIEpPvZLnmZox4ISQoNA4+V0/9hTeUaXz3M0QsD9zs3sA6F+DZ4cifxo2onp+P/cYO6DS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7406005)(508600001)(5660300002)(7416002)(44832011)(6486002)(66476007)(8936002)(36756003)(2906002)(31686004)(316002)(8676002)(66556008)(4326008)(66946007)(6512007)(2616005)(6666004)(26005)(52116002)(186003)(53546011)(6506007)(38100700002)(31696002)(38350700002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXZPY3NHMjQ4L3B5c2x6NlpwaitMeVZRZTZmb0dTR2ZTbzJVaGZYNFZLSGFr?=
 =?utf-8?B?Q1Y0Nndqc0hqTjlkNjUvZEgyeE1SNGtsdExOWk5MRTArN2h5aWlBY1hGL2x0?=
 =?utf-8?B?ejBtK3RZUEJmdjNTM3BFTWxaU2U2N2F2VjRUMW5iSExKci8vdkRIVkNGeWdo?=
 =?utf-8?B?MDZacmlxTU8xVGRYb043Q3ZSem9OSCtCOTg4UU1iOE5tMUU2NUVFaU9hVWRn?=
 =?utf-8?B?NUYvMHQ4bWxYaVZhcWxDWlF5WmZwRFoxNWtrL3EyOUx0ZlVWOEVEcmUrSE5h?=
 =?utf-8?B?bmxmWXYxejJMVzRQVHhMQWkrZVRSamtEYUV1ZkZVR3l5T2l3Miswai9jRXh2?=
 =?utf-8?B?ZWZVR0hlL21jdkVuZURuVWE2andMeFh0aXowdGFEQytiM20yYkZEMU1TZ2Qw?=
 =?utf-8?B?Y2ppYi94SmRVY1pNUFd5QnVrYTQycHRhR1E0Sy9memNuQ3JZY0o1NVBqUW1q?=
 =?utf-8?B?dmFoeDhsZlF4TThXK0pUdkVFbUJHYlF6cVY4eURnUjhXMVhnQU9FRlB1dkl2?=
 =?utf-8?B?TlFvdjIyeE1td3B2R01LcmwxTVBUbXZIT3U1Wm9CUHVzdS9lc2tYeWJBWGxq?=
 =?utf-8?B?RW1WNlZqcWtXU0NNWFIzTzdSdEt0WldicFFCZ1V3dWJHbGhVN25maGlrTldU?=
 =?utf-8?B?aVM4T2ZFVndKcmpOSXpLUlFWQW84UG8zcWt0WGFRNFhzLzhESkxpeGVpd3Jx?=
 =?utf-8?B?QVU5K2JYcHhlTjdkWnE1TFQ5REwrdTNQbU41aHRVOVZaaW9HeUZzdVJOeGRK?=
 =?utf-8?B?QWtEcFp4WkZlbEh2RjVNSk9Bc3h3QTJoK0FvUmJvbG9lUTdSK29pQmJMbHl4?=
 =?utf-8?B?dHVGR0lEVFhKdmx0bEl5SlErR21lZ2Y4Y2lqd2dxVytmczJ3bGQycnRQeVJz?=
 =?utf-8?B?VUhXaUZCT3VoekJTT0hVaU1ZRVFZblhnNVhPREJrRlFjTGtEWndHRTVRc1V0?=
 =?utf-8?B?SFF2TXFuREtjZE94ZGVlN25SRG8rcFN2cmUrcUxXMnpNTHQyM2dVc0Z4Ullh?=
 =?utf-8?B?Vjd1eW5NNVJiRXI4cXNPRThMNmNSQUhjUnlSY1ZmcjVBRlNDUDBVUmdVK3Zn?=
 =?utf-8?B?Y3l6cnFFWk42Y1FwUUJGOXdOWW5IN3FVWEl1ellVYTVRa3M4ODQyTXJjNkVs?=
 =?utf-8?B?MExKSkwvRmdpK1kwWDhwWllrMzJJbXg4THBvUVZBRmxoOURYWllTR0drV2Jk?=
 =?utf-8?B?Z2lYVmFxNDdMTWsxbGZVVVZNc1RmdkZpWVFJU2xHZFdoazNqczhya0lqeEtk?=
 =?utf-8?B?aUEzMmNoY3c2ZzgzQjg5dGw4QjFGeUJ3SFEvMFh6QzZGdjM4eXB4K0JUOHND?=
 =?utf-8?B?Yjd0THRuclU3ZXJ0bms2cCtqL213ZnVVbEMzWVBpcnhrMUtLd3lROW4xeFdD?=
 =?utf-8?B?VU5QWG9tQm9nb0VQOXE2cnV6Njd1WU4yN2Njc2wzZGpiNW5iME9iRjIrOFRq?=
 =?utf-8?B?WEdIZWE5T09FaTBwS24wNWdBdHpmYjdSSHpCUURFTk1pN1N5QUhhUjhNbito?=
 =?utf-8?B?eENlbXVaV05BOVR4K3RnOHpvc1hkZGNudnltUVBTSGtvcmt0N0dGcDNsSXh4?=
 =?utf-8?B?WGFVckE2TjhHN3REaFJIdkNVTlVvQlRENDlRcVBCWUhVQnN6S1hTbkd3b0Z5?=
 =?utf-8?B?ZE5pb1BtenF0dVhXYjdRWVpoVDlNRjlRZVN2azVIbDlGWWhJTC8zY09TT3cv?=
 =?utf-8?B?QmNPREZZVXp2Q1hHMzk1c0VOVVBaZExDczZ5MWRrbnd5QW1NMEZZZnFKMGZX?=
 =?utf-8?B?cHNJK0dwMFAxL0x4WERVcmduY29mZVJTZE1SajRPZVFpRUZFdXh3empvSzA1?=
 =?utf-8?B?dEx4SjZ5bnFwWlcxQlRzT2VyU2J2eGlyT3BQYTRFM2FsUlRIQ21aU2NEMSto?=
 =?utf-8?B?bjZNQ3pJQU5mcEdGNUhSWjdJQkhkc3BnaHVqMmdwdlcwRmtvMlZOblBWRDBi?=
 =?utf-8?B?dGhQRFFVRVF0YnpKZnA5MzRGRHFFakpkMXRrSEtpY0JFMFV5ZUozZXNDcGty?=
 =?utf-8?B?d2RwMXg3ZHBTK1lFcDk4a1N0QzEvcmtpdDlCTnJreDMzalRhbzNDTnduTFZa?=
 =?utf-8?B?RnBRTURlWU1veGlZR3VnQWZzRG9yZ3N4M0lydkl1dW5sSlN6b1lCTUNlTTJB?=
 =?utf-8?B?N3ZlaGE3cnJuRFovSnJkem1BS0VVNUpIQ1BQYzlOV0tkMjJqUC9VUm5XNXht?=
 =?utf-8?B?RkRaems2Nmg0QndDQkVEcHk1eHpGL1BmVG5vcTVScWs3ZG9mdXQ2K0NkVkN2?=
 =?utf-8?B?L1ZjdWNsNm1zWHdFUEx6d3ZXQ2VBRGF1K0lQV1RmSVJKTFZ6eVdzRDN2bjl0?=
 =?utf-8?B?dFRhU0xabTJVVmUvaFdhQU1sSldudHZIb2NlZldjckdRQjgwdlJFbmJPZDBP?=
 =?utf-8?Q?J6UxcxvKUEswB6GA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e82b4d86-edaf-45f4-aaf8-08da2ef279aa
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 23:53:38.8130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5T7WMELgiLbaPMEVV9E0tFeZALiNTF08+yfO3IaMZBzDpoDCwOYIu+qshuU7Fw/eSXQrwngK7bFqxiIWtEl2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3833
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-05_10:2022-05-05,2022-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=817 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205050150
X-Proofpoint-GUID: VzSeLcTGNL8M4sL4QLvtS66MJppnyJ8Y
X-Proofpoint-ORIG-GUID: VzSeLcTGNL8M4sL4QLvtS66MJppnyJ8Y
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/29/22 01:14, Baolin Wang wrote:
> On some architectures (like ARM64), it can support CONT-PTE/PMD size
> hugetlb, which means it can support not only PMD/PUD size hugetlb:
> 2M and 1G, but also CONT-PTE/PMD size: 64K and 32M if a 4K page
> size specified.
<snip>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 6fdd198..7cf2408 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1924,13 +1924,15 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>  					break;
>  				}
>  			}
> +
> +			/* Nuke the hugetlb page table entry */
> +			pteval = huge_ptep_clear_flush(vma, address, pvmw.pte);
>  		} else {
>  			flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
> +			/* Nuke the page table entry. */
> +			pteval = ptep_clear_flush(vma, address, pvmw.pte);
>  		}
>  

On arm64 with CONT-PTE/PMD the returned pteval will have dirty or young set
if ANY of the PTE/PMDs had dirty or young set.

> -		/* Nuke the page table entry. */
> -		pteval = ptep_clear_flush(vma, address, pvmw.pte);
> -
>  		/* Set the dirty flag on the folio now the pte is gone. */
>  		if (pte_dirty(pteval))
>  			folio_mark_dirty(folio);
> @@ -2015,7 +2017,10 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>  			pte_t swp_pte;
>  
>  			if (arch_unmap_one(mm, vma, address, pteval) < 0) {
> -				set_pte_at(mm, address, pvmw.pte, pteval);
> +				if (folio_test_hugetlb(folio))
> +					set_huge_pte_at(mm, address, pvmw.pte, pteval);

And, we will use that pteval for ALL the PTE/PMDs here.  So, we would set
the dirty or young bit in ALL PTE/PMDs.

Could that cause any issues?  May be more of a question for the arm64 people.
-- 
Mike Kravetz
