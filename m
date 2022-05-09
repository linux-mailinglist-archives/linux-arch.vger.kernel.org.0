Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C13E52066B
	for <lists+linux-arch@lfdr.de>; Mon,  9 May 2022 23:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiEIVKu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 May 2022 17:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiEIVKi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 May 2022 17:10:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493D727E3E3;
        Mon,  9 May 2022 14:06:43 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 249K9WPw024435;
        Mon, 9 May 2022 21:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=4n7y4Y+U56Z+bPGRcyxjv1ZRNTS5bz4vSFauGbkWXxg=;
 b=sh0qa8HfEIgyyQBTZSsFdBxegDorp8mUpT01qQ1AJcbugzDjjHdUPd1HQXrBucFpz1E7
 iYG28O3vKsFYizsPxHif/pu/6cT+qOr1f/2Ke9JWp/xumd54GyfXu5hP+KoYN0QQGBQ7
 vMVUvnMoFeYw70pMqBt1ACk8JlpWX7qbK1suJDUag7L7X2i7iD2m+V3OWbBaODlHrz79
 K85YlxrwpRdFlfKrbbTixVvRiFlSn7mjJjgHYQfpxWPHQ7yqJtLBauoeFWfBUR+AvRdy
 HerVc/Ffd+Oz6DbNuKIlAh9Kn4QtO1dCEG2cqKFR4PoPlIMxasK31idC5YT8kcrHE+9x DQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgcsmy3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 May 2022 21:05:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 249L5bjA018161;
        Mon, 9 May 2022 21:05:41 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf727r9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 May 2022 21:05:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hO0dYNN/5p1VFSzWkvC60LX1JkiluoHp8cs1SH1nIk3wUpvGe06dbumxbXB6k9jADIFcqEaRGfUfsIQTnLSNUzWBBGw9sdE5A24wCzbfkp03MSrXAxYXQy7zKXw3YMQu571rThSaVDLj2KH7o8IH1zbCcu6exbk+rBIvOhLvcrgsUQbYhRllrqF91wRs5aB0ROBK4sH+ie4C6LZSreYj7Eu7rjLa3hi6+tD8J9VdKO1I4M4OJSgCjjTAzEhtWh0NUMAizepPI//ODAzpyRstGrk0vFhu85zC6Bu/SLsKCypJMbCBi2nlw8ROydaKG5VmTsz8KRClqy44i34/f3+i3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4n7y4Y+U56Z+bPGRcyxjv1ZRNTS5bz4vSFauGbkWXxg=;
 b=h9SVhZVBxVQuQedNPQvfV4lJnGOHD91SXFnsPCAh8ELvi/NeWY+2Kr0TAv2wwmR9ekgYlCILepC8CIjWGS7KFt+A4Rju1ryL0JNL24vTUMXB/ZiK6G/qKHkQO+9APsy1HZGsM8vM1rhOd6V+Ibrf69cJkGpnbS5uAD4iwxBZ5pws3bBpLJBY3m+sbAyDhANE9DM2TMOLL6QXjItbNe/851Cut7mPncX62iDmJhDakT6aktMw8VQxsKqR3vpcqSL0QQ76xiK7xZqKB3zj/iLOvmAL2yXw4O3KoSwLGizdPciRHnaSwg3hGcCOG6R+TjHgY9iOh46EcJpPl0PCEJTR6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4n7y4Y+U56Z+bPGRcyxjv1ZRNTS5bz4vSFauGbkWXxg=;
 b=zWNu09ZRn+FruwjJDLjYvUNMmheWnU4ZKAuhu3Oxqs3DcBW4DWPNkBuktduUMoocQxuTbpWCUT4iOiFVKmXI/FYVZ/YxjvMmd1hmd0rtwhyvJioNqwAOK0DjHykj+mFMoMvdp5bhf5DtNnd6Dv6zttQmMJklODjx1BEch4Aq4EM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY5PR10MB6048.namprd10.prod.outlook.com (2603:10b6:930:3b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Mon, 9 May
 2022 21:05:39 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461%9]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 21:05:39 +0000
Message-ID: <4ef41c10-61f4-558e-76b3-3ea517779985@oracle.com>
Date:   Mon, 9 May 2022 14:05:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 2/3] mm: rmap: Fix CONT-PTE/PMD size hugetlb issue when
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
References: <cover.1652002221.git.baolin.wang@linux.alibaba.com>
 <1ec8a987be1a5400e077260a300d0079564b1472.1652002221.git.baolin.wang@linux.alibaba.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <1ec8a987be1a5400e077260a300d0079564b1472.1652002221.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0205.namprd04.prod.outlook.com
 (2603:10b6:303:86::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01c1ea13-c64c-4462-c657-08da31ffabaf
X-MS-TrafficTypeDiagnostic: CY5PR10MB6048:EE_
X-Microsoft-Antispam-PRVS: <CY5PR10MB60485B79C48731F7EAC3398EE2C69@CY5PR10MB6048.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zwQOWccpzWpg9SZCFB1t6nvqHNhAyx6YsrMFFPq7VoEQObf26Fvf+yRaFm6OaxvPG6/438ZBxJI8HW9P5s+1fTzmBTTEfhqj9kwkPktdSWPXr3BY8OeYQPLX6ReAQWt/MbFOaiK5i6t9KV84oXpdvu86wf3Kxj0gaLtMdsIGswjGMPBURel4HDUoV8FWWY4ve+Dcpbl7E8WI7Jmpip/+X/WkuIxUPwbTCG18VC/ydfUczXAnc5HDtEbHNrYcFcCYM7pQBtB6fS7p5J6ykpp0RPOnM8/3qAG44jjQDsphDPpoQMb/Dnh7QQKHptlALe7QRHZmye7FInhiylvuwBOIIRA+xyBRKHT/XcdaJnIJVp4kBR8M4ZdFdzwqugq81Eic/3axm04TZTlmGtYKmJSZAvKVhpkzJ8wCR63eAtlF6+d3sWSa/PRxkVkidZQxVq2o7aTTNnu6+kfzpoq9NjKswJh777b5z2y+534iZDFWBq4nvQmDVyF+nlAjaOUAjqd3k/O8bfGphHVOHxR/W6h1Q5yIgZ3nYSS3tN3t786CzSkzKGoZIKEmkW7H9z4F4A6Nc0fi1jcpzdUUYLijVSPyQ+rtS4JTaeM1RbhHWVL+Ba+XHtDqbLvC+Vr63XOkfUmshglB0/NsmUb34HYeEcXSeRhATOR1Kl9ql9ItoiCZ8JCfNdff5ZpKoYDyxgFfWcTFIay4+END8yhfQzGClHSpqWl1pedlIwSIiUWroWj/zPAWHTFGoYZsTNg6oJ11rJDsS18Zel1TzngYQtgzM80W+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(7406005)(7416002)(83380400001)(44832011)(508600001)(36756003)(8936002)(2906002)(31686004)(6486002)(316002)(66556008)(4326008)(66476007)(66946007)(8676002)(2616005)(52116002)(6512007)(26005)(186003)(6666004)(53546011)(6506007)(31696002)(38350700002)(86362001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajVISUdxUDdLZWNGN2NEYjRvQURuWUlqOHhNMEhCZi9NUTVGSmlwaEhESEpD?=
 =?utf-8?B?cHI2SHAwQ0JhMWVIUk02YWFueTZXdEQ3SGQyd2k2QVIxek5TeDV6VDduQngx?=
 =?utf-8?B?SnpaYjNxQ2tkb0FWVGkvZit0MkVHazlmNWZJY3hxUFVlZ2s2WWt5SG04a0x4?=
 =?utf-8?B?Q0FtZkc2dDdyZnJLQ0txNDU5cUhkVEZWVlZSUE9MRTRvY25LQ3BjUkxOREJF?=
 =?utf-8?B?RUt1SHNNRXM2bkNxdGFKMENJOFpoNEhubnpHR0ladVN0YXcyOXlHdnl1aHNS?=
 =?utf-8?B?R09palliZWlhVE5ReDBmajVnTXpNV0pTbjFDMEF3a3Z6UnZ4ZmkrNlZDKytY?=
 =?utf-8?B?cEx0cXNQR1R6cEdFOVpPMmtXaTZ4TjNWN2xiYkIxNHYwUFhpTXJGZFhTTXFD?=
 =?utf-8?B?YzhUcXdoaFlFRUo0Y3VMZy9jZ3NKVk9DZXd0a0lxTFM2OTBaZ0hRcW84MFJY?=
 =?utf-8?B?NUlBNkNRTHM4RFdmQk9tTXJBWXlvUktURVh5dC82MGxYUlZtdnN2WlFlYmEw?=
 =?utf-8?B?VEt3OWhjREFRaGZwejJPUFBoejlXM2l0VU55QXRLMUphTDhKekZIaVZGTnpQ?=
 =?utf-8?B?ODRFM0JXdXpZRzRlZThqVVZzU1dtRkNaNEVWZ0NoZVVlRVhlR01VSG1RLyt0?=
 =?utf-8?B?cW5MOFlwUjdlRlk5Sm5JcXV2VHFLWDdSN3lSc3VGZWluOW40SGlEQnNiTUVn?=
 =?utf-8?B?RkYxbFEzU0Z3WHRKRzBZZjhvQVpQcjQ3RTBNT2NrbTJBUHQyckZtOTlVOHVW?=
 =?utf-8?B?bGlLYW1LZ2t5RVFNamFPdEdkVi94aGdQVHdXb0t3WkZLdTZjR3BsMm5xQ1RB?=
 =?utf-8?B?UURBMUNGQXJXL0J3QlRwSUJmdURkd0VCdnNGdnpvdHZFQTJYUVBTbFRkZW5r?=
 =?utf-8?B?c2ppVHZXVGlvQWdGb0dQbnkwNGxwcy9ZM3RaSlRYSEQzWURNQ3EzcGlwbTRP?=
 =?utf-8?B?akZPc0UwcDBNMWx3MVhZUDBBN0VVeGFrUFMxTVVLS3lpWEs5c1RoN1ZVN0xF?=
 =?utf-8?B?U0MzSkZab3NyNTZ2cHJQVSswcXNpSjFlRGE4ZjcwbUZQc21IWUlHSkNqVmdK?=
 =?utf-8?B?aklWY2o0Vlh2UmZEcUNLMThyZDVjWlNpaFpUMFpkWEp1ZVRJOWZPcnpDd2pz?=
 =?utf-8?B?WGRmSFFOZk5pVTdRNmQ5dEpDZzZVVzZVQUFISWpUSERwZWxkZ3hzT3NwUEdB?=
 =?utf-8?B?cHptOWloUndlMlVxV1BxSWxJc2FUZDdQQzR5UTJDcE1HZHNCWi9IQStOdG44?=
 =?utf-8?B?QWM3ZmNJMWc2cGV5aTFxNTQrQ0tNK1FBWFpWS3FxblBwcEFsVUdxSHBPRG50?=
 =?utf-8?B?bHhyQ09xSWNPWHp5dWFoc0hBRUx5TXpPK2pwSnBMS0dUVmVTMnV2VlFwdmNx?=
 =?utf-8?B?cjV2M0p5REJ3ZFBjMGxKbVJMc3ExdXYxUStiWWRaeHhqczlsRG9wakRkbWtP?=
 =?utf-8?B?SkFaR0dqSnJUelRDZTRIeW81bytpcVozVlZZTk5tTm5zWTA0dGxvUEQ0MUdI?=
 =?utf-8?B?cnBDOFplTm90UXhabzA4QlNrUHhESmNreHJsMmVnazIra3pUYzEreXJzbmIz?=
 =?utf-8?B?a0RyOThEeTYzRDQ4MmY2VUs2S1RrK0gwcFdWLzd3eGJqNHFkTjRreUNqQmJh?=
 =?utf-8?B?c2hTOFRtSE9NaEhZVXNnbDBkcHNmVU5lTFU3REVIRVRHQVM3WkhqL3E0MXUr?=
 =?utf-8?B?eERtSVdHQlVveW01Tk1VMkxiZ1d6NmxuSzcwQnBRdE9RUFcyVzlqaFR1cThB?=
 =?utf-8?B?SVNaT2h3WEZzbWdJaW5HOWVGT3dGb0E2aXRZS20yZE5GamFIbTZNNmE3bkFx?=
 =?utf-8?B?cnlnTW9PVXhqMi9yL3RQMXJHWUJRcmg1K2YvQVMwYm9Ea3k4VUI2NTg3d0tU?=
 =?utf-8?B?WEdySHpMTzhMcWRUbGRwV3RFWTl0RExhMmphUGgwZFhIYkhiWlZUbVFKNmZw?=
 =?utf-8?B?MkxFMjZuTldROWI2SG9KOWpBUWNpSWNZTm1tNjkrdVM3NUp3UDh5T0NoRlhP?=
 =?utf-8?B?T1dQSmRJcWswTkZmazh6V21pYTVmZ0ZnbjJsOW83UHltSkJWN0RhTXh6ZHVj?=
 =?utf-8?B?bSswSXBCTndKS2MrSnhmUXlVVzJkNnNkNi9PMmdGejBrRzI2OHJ0Z2g4TC9v?=
 =?utf-8?B?OFVpWVR0VzdUazQ0TVBGRzdhN3c1Y1JCa2tGaDZEd1kwb2hHMC9WWmUxTDBy?=
 =?utf-8?B?NzB4NTBJMTRTNjNPMEpmTnQrakFod1BLem1EMDIyK0laRXFJcjg5RmdzS1dk?=
 =?utf-8?B?SFJlOG1QWjlFUFJBMEF4ckU1cFE0Vm5kOVJCTlZkakVYanB3WVhlRVY1d0p0?=
 =?utf-8?B?Y3NFS2xJSU9GMTdzeklFR2h5RGZlZ1BaSXc0cU12M3JYSmc2clkwelMvVDcz?=
 =?utf-8?Q?fSnGQJhnLYzKWuA4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c1ea13-c64c-4462-c657-08da31ffabaf
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 21:05:39.5691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RD8poBMlJyElIBuWBmZGumJjKljODrxnAo3zer7ynEe5HNCzvFXxIENgH9xXaffkZoOYue7p0WTTSN+gDN5Hcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6048
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-09_05:2022-05-09,2022-05-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205090107
X-Proofpoint-GUID: eYfmCoUkIXycAZsh9vTo0jIKHCg5fZkW
X-Proofpoint-ORIG-GUID: eYfmCoUkIXycAZsh9vTo0jIKHCg5fZkW
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/8/22 02:36, Baolin Wang wrote:
> On some architectures (like ARM64), it can support CONT-PTE/PMD size
> hugetlb, which means it can support not only PMD/PUD size hugetlb:
> 2M and 1G, but also CONT-PTE/PMD size: 64K and 32M if a 4K page
> size specified.
> 
> When migrating a hugetlb page, we will get the relevant page table
> entry by huge_pte_offset() only once to nuke it and remap it with
> a migration pte entry. This is correct for PMD or PUD size hugetlb,
> since they always contain only one pmd entry or pud entry in the
> page table.
> 
> However this is incorrect for CONT-PTE and CONT-PMD size hugetlb,
> since they can contain several continuous pte or pmd entry with
> same page table attributes. So we will nuke or remap only one pte
> or pmd entry for this CONT-PTE/PMD size hugetlb page, which is
> not expected for hugetlb migration. The problem is we can still
> continue to modify the subpages' data of a hugetlb page during
> migrating a hugetlb page, which can cause a serious data consistent
> issue, since we did not nuke the page table entry and set a
> migration pte for the subpages of a hugetlb page.
> 
> To fix this issue, we should change to use huge_ptep_clear_flush()
> to nuke a hugetlb page table, and remap it with set_huge_pte_at()
> and set_huge_swap_pte_at() when migrating a hugetlb page, which
> already considered the CONT-PTE or CONT-PMD size hugetlb.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/rmap.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)

With the addition of !CONFIG_HUGETLB_PAGE stubs,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
