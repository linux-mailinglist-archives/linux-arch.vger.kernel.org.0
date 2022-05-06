Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB84551DF5D
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 20:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbiEFTAC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 May 2022 15:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380836AbiEFTAB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 15:00:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5EF35840;
        Fri,  6 May 2022 11:56:17 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 246Fd0rr018676;
        Fri, 6 May 2022 18:55:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fK9bi4Z9PP1olH/CSmPWyVsEPDWh0Nltk2cgwUNgVzQ=;
 b=0noHKmqViQOlrgGLcvrXPWxFeP+BklSdOiKCxnpVanotL3pcqV6z2Yw1XolB11Kgj4t/
 rl35H91SfQ1zOhjZXuLZ5DhofVz6B7zGMA8AtNyg1u1qP/DgM7wb1XXDxr13ZtZlcldq
 sUt2fsHLkGgKjX/B/Qf5VoVkAunXUzh27imPRUFdwacJeK4YzG8kjjz71YNHQyx3vEjH
 6nFbt9zrz3yrRWgmmmAf73PkrMPdXwRacgzZlbvGW9y2hO43m1yh09bXOsrkKPDJkxtt
 RLSAOt09flQkh9UWStCYjAxEylbtN7EFk9U5v+yZWxR+Dvp2ouDDVO1TE3A+Y1rTdrhy sg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frwntf1sc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 May 2022 18:55:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 246IVQVc015875;
        Fri, 6 May 2022 18:55:19 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fs1a8msuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 May 2022 18:55:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2arjrwrJaD9gClNJ0/lnvhT1m+sLNRyJF8nguHDdK0sfb1aCjPYusYiIn2afn/Ri8xuLowMu/UDtSsoay4gejGeWIRR3FbH3ephCNWFMQjTHoKUNHz8ibkmcJihuu+owy6xShvjHYq9hhfWCc1LA769CWCsUlQJgvwa2N0JBWY7Z2oulnEF/AO9wj/81pjVtf4hdTDwQVNZyD7qEBowc7luT9TvkIAErowzyAFF1OAoKl8UA9kFVKSkim3WNzgHDfmYP8OBO4+7XVFA34kSIeunkxGec0waaXRLk6Ab2QSo2+k/v+B46wOJILDaaZqkEJ9JdWGvLl+w2UmieRkD0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fK9bi4Z9PP1olH/CSmPWyVsEPDWh0Nltk2cgwUNgVzQ=;
 b=dFm2Cf5TTz9kzVRwcYXovCrrbOKj9ZNZCIGj44yholMsT7lTEnp3EBd9wpypoGeZzcRF5DoM3razWKrmWmblOnLnLMD6Ngkol1813/ONQCVf8n9W9YaHGOaOvCVI5UFsGGj2BZ7t/i7PQf4xSY0OcHuUZ7bds3m+eoLc5o0GVM0JR/jclvX81rnVoh7LPhUF1XLhLX2NZIuTaoNW9RwuGJc+9/k9rVlIzP1mPlsQV54Q+pP48Bz2QRrSUzdd4AWU/WZg8LeXN1g6m9XHdzQyy50yUr3Vvhz5SyQ0a/wGhwMJ67I2v2IWDeiMMeMH4DJhUOPrqFjHQVOvaY67my1mjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fK9bi4Z9PP1olH/CSmPWyVsEPDWh0Nltk2cgwUNgVzQ=;
 b=BfG1sCQXuxKcDer2YivLbzRlNtt4e9KXKx5F2PK+1aGVjMqMMk5P+Qyhe8hhv0KPZ5jUmxiCsmr6Fyt+rJDvxU30U27N/pLbxpxLQ1q/nChg1l6wjRAXupnLS1zxhoLxrhFD0yJ53nwMzqSlyfcfDkFBLbq3NvzQ85BUKVYDHyA=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by PH0PR10MB4439.namprd10.prod.outlook.com (2603:10b6:510:41::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Fri, 6 May
 2022 18:55:16 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::e81e:38af:cb6e:59e5]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::e81e:38af:cb6e:59e5%4]) with mapi id 15.20.5227.020; Fri, 6 May 2022
 18:55:16 +0000
Message-ID: <f64f0d4f-f0fc-f07c-3c17-96f124da21e4@oracle.com>
Date:   Fri, 6 May 2022 11:55:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 3/3] mm: rmap: Fix CONT-PTE/PMD size hugetlb issue when
 unmapping
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
 <c91e04ebb792ef7b72966edea8bd6fa2dfa5bfa7.1651216964.git.baolin.wang@linux.alibaba.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <c91e04ebb792ef7b72966edea8bd6fa2dfa5bfa7.1651216964.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:303:b9::20) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 209860d6-20c3-4eba-43b0-08da2f91f5ad
X-MS-TrafficTypeDiagnostic: PH0PR10MB4439:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB44392B12890DC9B907E973ECE2C59@PH0PR10MB4439.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N8S/Iud4EVW/6af5agJresYZeKtQCGiqyU4kvzNoGHn4/8WHJfH5f/UBiKzTiIGD1SwOTMkVGDtPrxwP8NY9YlzTGHPfUuP0ru5RwkZVvlO9KRbQU1gc+9NkDZHRU0LmUFMq2wd1vcpKByxXlkr75SJiLPYKQlq0IRnh0yyJ/QDLvaPOxPfjUM+A/HNChI7O5VsYumJPz8I2kIJrHQ3K+HElE8FFjlpC5ByOftIlpkID5O0/Pf7Li7/1p9QSUfCiVJxZdq1XS5/LwFs45TDKj91p/GzQ1usSz6GGM3CCWnNQ3FA9or3XMamY2hnSvO1c316KkNafs9x1FfifeTeFNhwecvB6oN6XfSoiTYW9q49Y45676JjxPwIm5utN6VaPQqWFCortVtDbr07BhwLyiUzm3z8cI/iTysnMuSIgTBGLzU91VKg2HmnuYrRcV15sXhc0gx91bxSPALruFUVlglt0AifT98uR8P+qVeDsEe7tQJ/ygTiE58Rn6mcpqTND05fTWTHoZTXmtTRjDBx7OHIRqIaYriUjyjQeM/zWDxh5SlPPnruQMMcg0y7UhNnIvIHcsHD6FIapuYXzvCCrSIa6yoZSAGJEGlXzhcAO8Drq2zbSoTnutxWzQfRVX6VaCMZKT2xoFa8PmqwRjPZi36QvrlNUAFAq/oxJ+ziR4hcSyTYW11XGPdSk2eN126Msb430C4qw6uYl0htVpGOjkibR02OKzzn3QkNEslLIPp3+I0JWNk8q43zwgNeon417pOjNZQM6xvd8SqfVyCt73Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66556008)(8936002)(52116002)(26005)(66476007)(4326008)(8676002)(86362001)(6512007)(6486002)(31686004)(508600001)(44832011)(6666004)(2906002)(36756003)(316002)(6506007)(53546011)(83380400001)(38100700002)(38350700002)(2616005)(5660300002)(31696002)(7406005)(7416002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWZoZ3dlckEzVDIveHdWWW10WnZhTUF0djFRN0JqWmlFUWR2N0RVTWJVZGdW?=
 =?utf-8?B?OGRZbGoySkhqbVhqT2h4VHNIRWlpd21zZkFadkoxM2pHc3BzNy9rR2ZoWERj?=
 =?utf-8?B?a0U1NmhVVThTc1QvcU5Eb2RPV2kxNnU4elc5YW5TMFpZQmdueTNXMVArTGdM?=
 =?utf-8?B?cnhvbEgyZXFMMnV4VW9wZU9qeG1SemhFb1JZb0F5UlN4dmZaa3ozVVFOM0hU?=
 =?utf-8?B?cThYbEJhdTVrSEJnS1dYcWU2cVdtcllLT0U0WkRjTGhTQTVHc0xndGc5QTMz?=
 =?utf-8?B?OENXekM2MmxmRHF2VFRsTXB3RXZ3N09DOFNRQWpYMnZla0tSWkZNeW1pTDE4?=
 =?utf-8?B?N0tJb3VkWVRtUFZESVFYUHpELzZpeVkzUS92b3gyVlYrZ3BjbmI1NXd0eDRB?=
 =?utf-8?B?aXpMdCt1WWxNYXdEckVsWWhaYVJ3ZTA0THkyVnpGUTRzcDM5bnpvcEp2SDFp?=
 =?utf-8?B?ZUQyWW1jQVJ5ckFrWnZVOW5wd1hTMFBxM2RoZXZxSFplZ2ttRFd5MVJzRTQy?=
 =?utf-8?B?R2FWczB0ZVNic2wveUpnUTl5WHBCbDdTT0crRlhFNk1rTWtUMzQ5VkZhU0t0?=
 =?utf-8?B?U1prRmtTSUtmbitDYVhpRjN1ZHRBT0xpV0szZ2xRWFBUZ3FFVVV0bitqeEtY?=
 =?utf-8?B?SUM5KzBWZitocDNZc3FMd1gza29pRE9DUDJ1MFFuaC9CUTk0eTJBSm1OQnhG?=
 =?utf-8?B?SUhsdXNsa0Q1Rmowd0FUem5iZTY2QlhzREord0R3TExMblFjdHFlZUh0WUpZ?=
 =?utf-8?B?dHd0TUhmVm1LaDlscVZadkVjajByMHk0ZDV0UzhXOWZUM2VWZjAvSkY5MUhj?=
 =?utf-8?B?NWZoOVhkY1NCenN1eWRQVnV3djlaekZDa0J5WGZZaWdHY1E5QmtFdWJaYTA4?=
 =?utf-8?B?KzM5dGRUc29BenZtSFp2ODc2L013aEtkcGZ4Y1VnUk1ySGl1L2EzQW03ekxy?=
 =?utf-8?B?ZHJydk5jSnIwQlhMUVZTTkxGWkE1cmV2K3d1YnNraytiRFJmeXBENS8yZHFm?=
 =?utf-8?B?S3l3eVJ3RXNrNUNxYUltRkFmOWx0d3FxcGhJWDVYb0Q0eHp6bTRFQ1hxS3pa?=
 =?utf-8?B?VTNjWFN2WGJRd2l0Sytmam9wcHNMSmh2TTRYK0tHY3NlcHFWbUdscm4zZ1dQ?=
 =?utf-8?B?RUpwQ2NmYWJNVy8zMWNKTXBZY0pNRWNwY3pUT25EenYyZi9pZVZuUVArODdK?=
 =?utf-8?B?NjIyYkFQV25UZE1rTzhsL0ROWWc1YkdLbXhpaUoyUkdnSkY4d1NZWXhmclBW?=
 =?utf-8?B?bkp1alJONGRJWStEY3dDa0pBTk9GNW5yU2N5eTZkYXBENWVJZWFSZUdvdyt6?=
 =?utf-8?B?NzFxWVdQZDlaM3poRHg5MmNGSU41OElvYmVPNXpVUzFZeU9xZG52M2hpNSto?=
 =?utf-8?B?QVI4Tk0zZHczRVlkT3dvRHNMdDdzRGJCK2c1UDB5LzcvNUw1azllNkYwMlRz?=
 =?utf-8?B?bmk1VlcyeDZuVVpMeUtxekxjcGpuclJJS09xQ2U4Q2l3eHBOZlhTczY5b2hy?=
 =?utf-8?B?RjRqMVNadit0YjJxblF6ajlkNUxnOVV1RmZpZEJvbnpHT1c0U0pkelZXSytM?=
 =?utf-8?B?eGJ1bHM2VVFjYWVRakl1UzVoWjVDek94TkgrQko5WnlrMnFGR0ZONVFHRU1X?=
 =?utf-8?B?VWxOeVBzT0xWeGk2YVZpVjFsMnhxSWJJdHNmc29Dbzk3aGJDM1VJdVNnVTVL?=
 =?utf-8?B?VnAxUHhlWTdVOUxQWGVyNlhFZ1gzZHhObGRFS0JId2FENWdPalBSWG1VK1o5?=
 =?utf-8?B?eTFoZkxTWm1QM2ltQWl1OW5ZbFN3ZldjcEFRa2ZqQVJFUVQ2T3NVOFB3TkM0?=
 =?utf-8?B?SjFDQ0EwYU0zNitJOUN0MGJock16dmNNTzJkV2JSSjhhdzRjV0wxOUJXd1RF?=
 =?utf-8?B?bC8xRnBONUU4V0hGWUEycmEwa29ERHBjRDJrV3ZVRUlreDRLSXpFYVVjeXNk?=
 =?utf-8?B?c3c5YjFBMU9lMTQ1OUNWWVVYM3Nyak91V2xsYTgrMzJnY1BDMmVRKzFwNFFX?=
 =?utf-8?B?cmloeE9iN3QyYXRCczR5cUN2TUxKMWRPcFJZNUhhTnBQeW1vdlhNdVIwNHBn?=
 =?utf-8?B?OEcvYXZOOEl5OStVdFNYSk5qWDE3eUl5aTZDaWkxVDhqREJBZGFkK2lVZkpS?=
 =?utf-8?B?VWhDb1RaRkpYcHh6bXBQR3NIMzVjcVkyWDNPdVVDdzA2OUF5d3FXcUxiSTBN?=
 =?utf-8?B?ZTk1U2tYSHlMZW1SRE8rbVZhZlhlSVlDQjVlZkFHYkx1SzNncXpzWW56L25I?=
 =?utf-8?B?cDFKaWhSdGRtajRRMUdOdkE5OE5vaDRHeTIydXFzdGViMWVQLzRvZGtTWDEr?=
 =?utf-8?B?WHVCQ3YrWC9UTFdsNmYxVmoyV0hFeEczR3Zkc2h6STM0REI0QlRYVlJCdUpr?=
 =?utf-8?Q?vRm4JoL/XGz2SVLY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 209860d6-20c3-4eba-43b0-08da2f91f5ad
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 18:55:16.7538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aftZ1eOZjlvfrZ3Fe/clwbMN35axAwAmL5ylzxdHSeVL7VW8rwRHnhZpeKN/2gTT3P2osTxUUYoCaij3j70yAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4439
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-06_07:2022-05-05,2022-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205060094
X-Proofpoint-ORIG-GUID: 8lQTCZsc2Jh1nAO4EezT2oArc2bhH9vd
X-Proofpoint-GUID: 8lQTCZsc2Jh1nAO4EezT2oArc2bhH9vd
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
> 
> When unmapping a hugetlb page, we will get the relevant page table
> entry by huge_pte_offset() only once to nuke it. This is correct
> for PMD or PUD size hugetlb, since they always contain only one
> pmd entry or pud entry in the page table.
> 
> However this is incorrect for CONT-PTE and CONT-PMD size hugetlb,
> since they can contain several continuous pte or pmd entry with
> same page table attributes, so we will nuke only one pte or pmd
> entry for this CONT-PTE/PMD size hugetlb page.
> 
> And now we only use try_to_unmap() to unmap a poisoned hugetlb page,

Since try_to_unmap can be called for non-hugetlb pages, perhaps the following
is more accurate?

try_to_unmap is only passed a hugetlb page in the case where the
hugetlb page is poisoned.

It does concern me that this assumption is built into the code as
pointed out in your discussion with Gerald.  Should we perhaps add
a VM_BUG_ON() to make sure the passed huge page is poisoned?  This
would be in the same 'if block' where we call
adjust_range_if_pmd_sharing_possible.

-- 
Mike Kravetz

> which means now we will unmap only one pte entry for a CONT-PTE or
> CONT-PMD size poisoned hugetlb page, and we can still access other
> subpages of a CONT-PTE or CONT-PMD size poisoned hugetlb page,
> which will cause serious issues possibly.
> 
> So we should change to use huge_ptep_clear_flush() to nuke the
> hugetlb page table to fix this issue, which already considered
> CONT-PTE and CONT-PMD size hugetlb.
> 
> Note we've already used set_huge_swap_pte_at() to set a poisoned
> swap entry for a poisoned hugetlb page.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/rmap.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)

