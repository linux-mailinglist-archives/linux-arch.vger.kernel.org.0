Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807C451DE82
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 19:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352926AbiEFSBZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 May 2022 14:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbiEFSBY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 14:01:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0854F6D3AB;
        Fri,  6 May 2022 10:57:39 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 246FW2al030007;
        Fri, 6 May 2022 17:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=dvzpIwt5+QcB24+EByvUA0dnLmNi8FJ99aXDZjGDbU8=;
 b=szHQF+8lv4TfY1qZu8KtHdXOMO9JhGkuR7v1rSdjMV4+gSaybmTsGN8hmPH/hygcgbzM
 wlUmNy7oBR8CI8OxlJtZvZwNSS9y6VYhUlnmcYdJmirqintgM+cAW8sIWHhmAEzl96ke
 Qg2gidSPDzMWZvbK/GtLGcaPxV5Cl0JwAVgP/V4FW9TqVBzAcjjJbhvwOKbLJk83q6vH
 fHALVF7as2aykVD8nao2EcEQPSBvBIlkSz9ZwY1kJPqxZZgRVeWjamfY9iKwC98Pqzrq
 RhlSyNVV0Lg0X6qXDT7qVr4T5e/IIKXBp/hCX+pCZD+0QlzaunN8EkNa30FYRslqUeUF CQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruq0pvvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 May 2022 17:56:14 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 246HtSCU026597;
        Fri, 6 May 2022 17:56:13 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fs1a8k75y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 May 2022 17:56:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGm4n8FtnVnsiGxgrxhhbwHGduLBBRYr+Tw430xh9UjHuFfX7f/CS+BlALtj5KKGculHUPaT4K2xioGdhU64Rw7B9PbmmtA9rDzD6GU7h2ZfHonm2lOWOxHEyE+zSu0r3iqgcye/c/8+eH4QoQU3ahYHy9oImlgCpXl/2Q1sdehLoxWKfihJMU7uvBDfyF3NAVVHrGMhlvgvFCQqu8WD1RRXXRoFn8BwXkBJB9TvxvF+IKk/E8u04F9/AXO0KbRXqHZ5Dw6fzeXpPZlAeXvqOD+NbMznrbOlV8DoX+x8TBC+/JCQxYv4mfknHOkn3fUGGuguAk85tDplEoI+d0mbsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvzpIwt5+QcB24+EByvUA0dnLmNi8FJ99aXDZjGDbU8=;
 b=gxziFOax49XChajY/51gj+wxvP+YvY7/0L0RX58bwzaMj08zXZMpYcdVRRZ4MvcqljJYJ7W1SkEsWJIMjZdA4LuZRXMX+nK78+FUDV5xkmmX6rjXrWxzN/bEmbUQIuSOgCOqHGBWxQg1f/oDTCBdj3X36Y457r5XTPBSjFLI8NPs8J0UA52FWW5ZEIw+DECk4ClRK38X138Jt/nISd9PNEPdJkih40mSS1gJPEFBxkXhvnBbvlUUNlrCNpmYp5Rq+FVBOX+obQvXNHeB2eXLih2HNo9hmjatda7pQ/pBOHDtfoBeWRI5FzcsmzvVzBV9xArTUeIhMzdKaA8bnCIRHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvzpIwt5+QcB24+EByvUA0dnLmNi8FJ99aXDZjGDbU8=;
 b=ijtx8ilcoPusfnLBiELAw+1Q1dxZpPfgxAjUAl5LUHB4gJoUdMQQ7X8Rm4QPJl56ofP14pS5wJTjFvxLRwnTXGFa+/iV6qD3lKiS4QWEiPRnvevGkKqe6Q7S1iLAWhC92KbO+pvQob/9uvxo7gOXZMYydkc1WyfWflbt/B1CzVM=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by DM6PR10MB3321.namprd10.prod.outlook.com (2603:10b6:5:1a7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Fri, 6 May
 2022 17:56:10 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::e81e:38af:cb6e:59e5]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::e81e:38af:cb6e:59e5%4]) with mapi id 15.20.5227.020; Fri, 6 May 2022
 17:56:10 +0000
Message-ID: <85bd80b4-b4fd-0d3f-a2e5-149559f2f387@oracle.com>
Date:   Fri, 6 May 2022 10:56:07 -0700
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
 <5cab0eca-9630-a7c6-4f5d-5cb45ff82c83@oracle.com>
 <21b11024-e893-8c11-9b98-ab1d13413b61@linux.alibaba.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <21b11024-e893-8c11-9b98-ab1d13413b61@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::23) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c42a7592-f19c-49c3-a51c-08da2f89b423
X-MS-TrafficTypeDiagnostic: DM6PR10MB3321:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3321E56858F51C6BA7974186E2C59@DM6PR10MB3321.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zjKhOp3nWFz4YdOCaPRRB29ZRh7650JBF6YgVueZCZ9hOp8i+4hhbSmtohz6NxsIrCYgbg4UIoKxJQEABny3dxJx9fzkl9lwr7ookOEZB/H10gxyVVpWLHb3aA3jh8wLFaVg73yqU5vbqzRb6DbJAKGHz/NkgTSt+WcVGLaRcdumfHuQdsE6I5EjXTgSjEVQXH8jUyrOjpD+erGl/mMWAv47G/2iYqdVu5OD4RgtQv81qGr9VSmPZjQdN1QGLnpTgmAlC4qrn+92gLiUBlggUQ6EOxW1JLn5FOHxWA2TCTslYJdhZILh5KsLAHMCgDGjddTpU+tKzG8vaNJdFXh02V+bZEmPSm58lpP7wSKZt0lClfGWJ0ujwGpcs9Ny5OsJQ5YI7odL9Ix9FbRtOZeXJVec51AU8uspssF03N1kvYDmxblDI+8tZz9wXsQamQN83rN9Y6bTR75P8VGwrNDxdJ/NTdWQSgVXyantfRiFuLfMt8TyoA0+2OXjn1IFiBF6i1XXqbnuNmYIg+guQbZ7dcYPOUDx+s2K/pvpjMRgasdnKdh1CqdLxyLm1o/nzAP2ArpFkcEPbOMG2NUQc8lj+RUaybJH3XQ9sdK/Plpi34V/KxCzL7X7a+eCo50NOv26/EBh2CVTKmTQGeLrrOmp/UkRSfcZhri9L7bhI1Hv+bwea7wTz4LpZtMkdoG5kY1JUunUtja63ENWHvLzCY24lACpahgs4kuC6SBQcuVVtZRvdJK3tj9pI4DiiRjuz929GbuuBq05lkTrydnLlw8s+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(26005)(6506007)(2906002)(6666004)(83380400001)(52116002)(2616005)(186003)(6512007)(4326008)(316002)(5660300002)(36756003)(7416002)(7406005)(86362001)(31686004)(508600001)(6486002)(8936002)(38350700002)(38100700002)(31696002)(44832011)(66556008)(66476007)(66946007)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVBJeEJQZklNSVpPNGNSaUxWNXV4elgxUGZBazhibC9LeUYzMnFHVHFiRzc0?=
 =?utf-8?B?bWZTc2t0VlVQL2hFc1hOMWFSWG5IY2pJRSs1UlV4MjBUK0lBT1pSczJUNGMz?=
 =?utf-8?B?OUlYMktuajJJQnRkdUE4aVlHb1NlNHp4dFIxSHV0aGFWVGFTNWt5UnFTYy92?=
 =?utf-8?B?T0krTlZHamkycTYrLzN0c1h3U3RyTkJwSDUrazFLZDZieVhTemYrWVJZck4z?=
 =?utf-8?B?c2lJcG40RnMrRWFEWGJQbytBd2ZKN1NaZklKR09jSENvVEM3S3ViK2tEdUd6?=
 =?utf-8?B?T3U0cjBHM1B0U2VqVys5M3hCZHB6TGRKdmY3b08yajJhMkhmNm1DNFhBR1JX?=
 =?utf-8?B?WTRadVUzeWdTVkVZaUtPbmZjeEdJNmhpcFVJeFg4ZTEyRVlRd3ErVXhXMW1X?=
 =?utf-8?B?NU9xZEZ0ZXg5ZExJbHkybDNDblo1dkE4T3FaejR0Z3I3Yk9ZdGFVTUt1cVhJ?=
 =?utf-8?B?b3RpVWZSYmJnZm9TNmxEenhiQWlaQ01TWmNReFgwZHBoUEdGdWJOS3VIWlVY?=
 =?utf-8?B?NUEzUkZ4ejFQdnhUUEJCNEV3ZUNBZCtXN0Z2SUxZWDFEd09RZDgwVlhvbWw0?=
 =?utf-8?B?VEdQUWRWUFFRYngwdWhiaE1yVGVtZXRHdjNiUWlpL3lBUnFpY2orMmRQd2I1?=
 =?utf-8?B?aXRabzUzbzVLbncrWHFYS2NxT2FRWlhXbEVEdFpmeVVkUk1xRjhVTVRpSFEv?=
 =?utf-8?B?aEg2cmQ4NzV2RlJpdzAyVVA5bGZXTngyTFY0Uk83UXkzTGZ5OFMzTGNBL1FL?=
 =?utf-8?B?NmdsZTV3RFhzYnlTT2xBZXhFRzAzY3llYitwRVJhTGxhaFBhVEZMMnNERmhl?=
 =?utf-8?B?TWhNNS9lZU1mY2Q2SW42VWt1RnBzdDBZaGhoelMxU1RBY21RWnBVVUo1TDJw?=
 =?utf-8?B?ajYvSTBnL3FqYTRJWmlLMFFvQlRwRUNZRE81Z2dNbzQrZFdqSGNHSkdabVg0?=
 =?utf-8?B?ci83REsrRGRPOGc5d1U1YW1JRkppZTRldE83clI0NURiOHlPZytxMnN3NnZs?=
 =?utf-8?B?MTNLZVdaYzQ3ckFrTWJoVncxZEVkVk1Ua3c2ODZEa1Jvb0dkd2gwZGV3alZV?=
 =?utf-8?B?VVErVjJscm9KVUFwWStMSUdONlRwRGg3S1dOaHVqOFJNRVhBMXVTZVhWY3JP?=
 =?utf-8?B?TzZYaWJYWTNQcy9PMnR0M3AyS3pIeGZoQ1VHNVNuMVlHRWtWTDFWdUh1VHlo?=
 =?utf-8?B?aERUZWViaHNDRDh5NnB4OWxYc0ZUTERESlF5SUU3SUpUWnBjRVZqZjZaQjlI?=
 =?utf-8?B?NTZtNFpRdDdFRDhFb25QVHZCNlE2SFhwd2t0eURJRi96MHgrYzZJNXdFb3hU?=
 =?utf-8?B?RjFnbllTK1M2aFcwT1ZDdStjZjJncFFwSHp0WEdwUG1TWnhHL01tcE9kRVA3?=
 =?utf-8?B?am5PVmY3ZWpMVVdXQ1dUeHRiV25IWVNHNlhkYS9DWHVZTUt1VExBRTRNbWRC?=
 =?utf-8?B?S0E4WFZlcW1Td3I3ZVVRblhqditLRDN6UTBQNTBucG04anVIbkhLcmpSRklB?=
 =?utf-8?B?RUI1UFJVN1FNbFgvZkRrY0tRYWNSNGt4eG9pZ2hLOGRBbVFvdUhaNlRrWkIy?=
 =?utf-8?B?T25GUTYwWE1ubnVrMHJnUzZpT2NmT0hMSU1qaVRnbnRQM3liYTV3N1BoMnVM?=
 =?utf-8?B?QVRsa1lBc0NkZWlibHNZRFlNYWVPcEMyNGJwQ21ZTU1yVDA5OExsQnZOaDlS?=
 =?utf-8?B?c2pYYjFjRFg3aUFvYnliNlloSzIxSnBZTGt6emFOemQvMm9DL1FpeDMzVHR5?=
 =?utf-8?B?UFQ0UkE5ZzlEbG1Hb2liYnFLblZ1SGhJR2FweXI0ZUlFUmpSQ2xta2Z4eHRs?=
 =?utf-8?B?RmdkWGl5UU9taWpOVkI0UjBTcC9MQVBaOVJhRTJiRG1zOGRWLytlTU44cW50?=
 =?utf-8?B?bGI2VGdrS0l3UkxNOFBUdk53VnU0Rmt4bnBKVWpXc1UxSDUzUldNMmQ1akwv?=
 =?utf-8?B?bVd2YzZTUmFtenJPcVYyRURqS1NOdERiSThsU2tqeC9EWElyK1BGU053c1g0?=
 =?utf-8?B?QkFhV1dWbklFQ002MEo3S3NndzIxdmtZZjQ2aVFYVFkzRHFFSlhhMTlyZDZt?=
 =?utf-8?B?cFo4UG1uMU8zcEF2VGIvSlRXWGdBdGd0c0c0YWRtSXJGVGZaR2JMZklrQjVi?=
 =?utf-8?B?cERraVdDbi9CQjY2TFhNSVhTZ2RBWnlVWFYrK1RibnFydDdOSUxha1NxV1Na?=
 =?utf-8?B?d28rYlZPTlJQYmVLUzI2b2E2aTZ2aWpyOFZIb095MFVBRDY4NTV3QUU1Z0Nm?=
 =?utf-8?B?Vm44VWpLN3FRQ3hON0F1RDlHQzdkTkpCb1FaUUpKdDVwZjNWM2ljQ05DV1d6?=
 =?utf-8?B?dGVpZndiemNqd09UNkxzejQxOVFaemNlNkp5dDdXWjJsWUZRa3pOMjVKVlNp?=
 =?utf-8?Q?HguP9yiBHDzAad78=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c42a7592-f19c-49c3-a51c-08da2f89b423
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 17:56:10.7793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XbKCDCkv5ffaYXs43rx2K4D3gvl9Z9W4Jll47blD0Y0FpxpJ/Dkvg0fG3DaE9jLohinFWXfZxZY/Ld8nYP07mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3321
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-06_07:2022-05-05,2022-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=845 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205060091
X-Proofpoint-ORIG-GUID: aKof-JxTZ_IL3JOHP418iQRiEd6Ec4Ty
X-Proofpoint-GUID: aKof-JxTZ_IL3JOHP418iQRiEd6Ec4Ty
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/5/22 20:39, Baolin Wang wrote:
> 
> On 5/6/2022 7:53 AM, Mike Kravetz wrote:
>> On 4/29/22 01:14, Baolin Wang wrote:
>>> On some architectures (like ARM64), it can support CONT-PTE/PMD size
>>> hugetlb, which means it can support not only PMD/PUD size hugetlb:
>>> 2M and 1G, but also CONT-PTE/PMD size: 64K and 32M if a 4K page
>>> size specified.
>> <snip>
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index 6fdd198..7cf2408 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -1924,13 +1924,15 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>>>                       break;
>>>                   }
>>>               }
>>> +
>>> +            /* Nuke the hugetlb page table entry */
>>> +            pteval = huge_ptep_clear_flush(vma, address, pvmw.pte);
>>>           } else {
>>>               flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
>>> +            /* Nuke the page table entry. */
>>> +            pteval = ptep_clear_flush(vma, address, pvmw.pte);
>>>           }
>>>   
>>
>> On arm64 with CONT-PTE/PMD the returned pteval will have dirty or young set
>> if ANY of the PTE/PMDs had dirty or young set.
> 
> Right.
> 
>>
>>> -        /* Nuke the page table entry. */
>>> -        pteval = ptep_clear_flush(vma, address, pvmw.pte);
>>> -
>>>           /* Set the dirty flag on the folio now the pte is gone. */
>>>           if (pte_dirty(pteval))
>>>               folio_mark_dirty(folio);
>>> @@ -2015,7 +2017,10 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>>>               pte_t swp_pte;
>>>                 if (arch_unmap_one(mm, vma, address, pteval) < 0) {
>>> -                set_pte_at(mm, address, pvmw.pte, pteval);
>>> +                if (folio_test_hugetlb(folio))
>>> +                    set_huge_pte_at(mm, address, pvmw.pte, pteval);
>>
>> And, we will use that pteval for ALL the PTE/PMDs here.  So, we would set
>> the dirty or young bit in ALL PTE/PMDs.
>>
>> Could that cause any issues?  May be more of a question for the arm64 people.
> 
> I don't think this will cause any issues. Since the hugetlb can not be split, and we should not lose the the dirty or young state if any subpages were set. Meanwhile we already did like this in hugetlb.c:
> 
> pte = huge_ptep_get_and_clear(mm, address, ptep);
> tlb_remove_huge_tlb_entry(h, tlb, ptep, address);
> if (huge_pte_dirty(pte))
>     set_page_dirty(page);
> 

Agree that it 'should not' cause issues.  It just seems inconsistent.
This is not a problem specifically with your patch, just the handling of
CONT-PTE/PMD entries.

There does not appear to be an arm64 specific version of huge_ptep_get()
that takes CONT-PTE/PMD into account.  So, huge_ptep_get() would only
return the one specific value.  It would not take into account the dirty
or young bits of CONT-PTE/PMDs like your new version of
huge_ptep_get_and_clear.  Is that correct?  Or, am I missing something.

If I am correct, then code like the following may not work:

static int gather_hugetlb_stats(pte_t *pte, unsigned long hmask,
                unsigned long addr, unsigned long end, struct mm_walk *walk)
{
        pte_t huge_pte = huge_ptep_get(pte);
        struct numa_maps *md;
        struct page *page;

        if (!pte_present(huge_pte))
                return 0;

        page = pte_page(huge_pte);

        md = walk->private;
        gather_stats(page, md, pte_dirty(huge_pte), 1);
        return 0;
}

-- 
Mike Kravetz
