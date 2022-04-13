Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FC24FFF4C
	for <lists+linux-arch@lfdr.de>; Wed, 13 Apr 2022 21:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237849AbiDMTbi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Apr 2022 15:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238409AbiDMTbf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Apr 2022 15:31:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9CB76295;
        Wed, 13 Apr 2022 12:29:06 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23DJNNpq018439;
        Wed, 13 Apr 2022 19:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=grOCfmoXVvFZseKWNHt6lnTIFx2Vo5hre0yG8UvMB7M=;
 b=l4KgBpgdD2mojj/b+QVT/dlOJQe5rIMNtNCQFSPoSBRCoknLYej9nHfNEaDMZf8wWKTc
 hzpO1ztWfp3gxhbkAMBsm/oUh2h8Ijts8W20L1kvx9nMUZNdSlJm8CLqBNNqW3B5asjz
 bRRwoeCc48g1t1tYvs/abot6XmhqJ8oO9SYMXDVjftXERzivbLPrOG8x+Au77FE+X7BA
 wyOPq1zmoynxAcE1ZGNWST9ypR2arGY9ekGP2Vla5UAnNABetIUg1azejhgmu+8Gnv4B
 UXM80F6glKS/Oz1u7Vn1Bv9pAQuwT5XWynAvxnNt3Q70qLSQPPGLONL5LkxGEn1kKh1t zA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0r1k114-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 19:28:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23DJBSEo026270;
        Wed, 13 Apr 2022 19:28:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k4qu04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 19:28:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WF2UccpmmGddMJuDf6ooLd13gobEBKZlgp8Vpt00GADYj6HMQIAFdJFP7F7WMMq0E1d2MHjd4Un17XugstZrHJ9H0Q9cev7YaG3m4n6mynXZBlHUfqpUQ3mdU82UeDS/wloFky91rFyEwTxra20HoCD7K+Zlzq541paaYGMjFMuWiVTW9KVoMi8u/qpxTYp3FZgIZlNopD2H24Nzi9ZYe+Uy5NRucI3K5Lk94NBiAvfaz6DSQB3vE7eI3Oj/f3Wfsf5tkHESZ9Uv+7j1iHekN9ff6xNdX/ivlEYFe49lnp5gD7GuT6tV8+3u9D9FuUZCYIkSTL4IT3SghVWRsdAKqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grOCfmoXVvFZseKWNHt6lnTIFx2Vo5hre0yG8UvMB7M=;
 b=WYNTtqlUKlMbJht1mgwOM/MEx/z2453Znd3Iq/BTWqhYMU43pgjYtc5HcB3jDcVuYcYAyrazRtIj2HPLGRpC7NQZc9uyft75fBh4xe3u5c1Lpv8+NqMZJV25o4+L6CNtNf+wURcFUb9knMh/qrPjPa/ZDxSzZMCF1FNP9iK8U7SyxamgyWYwlBLE/LrY129RQU0/tP5A5haUr2la0diq6mK82VYHVg9nxBlo0b8LWUOB+f95YEdRVFzHBItnEzeS0k/fmauVxXAb0Tr6hGmyADfCW+guTi+bfT5rG04iGRf3SEFgN5IH88LQV6bVTWkWy+QNz1/e4qOj7FqErKKQnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grOCfmoXVvFZseKWNHt6lnTIFx2Vo5hre0yG8UvMB7M=;
 b=qSk0upE+uThPSBSC4U+A6XDcLwYfTwU/efccQ38+WzDwtJagk+plg6tPaW9ECXj7JtalfeyKzhGkdAhAE3rOdd9xKmEgZkzSzFN9WYBYPY7/439aNdn8oKhjvdHMKrHu2vfF7mVa7J9BDLzKtRZz9XeJ1aKq+wxkNoSKqEjYkfM=
Received: from SJ0PR10MB4576.namprd10.prod.outlook.com (2603:10b6:a03:2ae::5)
 by SN4PR10MB5656.namprd10.prod.outlook.com (2603:10b6:806:20f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 19:28:41 +0000
Received: from SJ0PR10MB4576.namprd10.prod.outlook.com
 ([fe80::498f:2fd5:893b:f008]) by SJ0PR10MB4576.namprd10.prod.outlook.com
 ([fe80::498f:2fd5:893b:f008%6]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 19:28:41 +0000
Message-ID: <c2e6bb8b-c9d9-ad39-7a8e-3df6849b2fb2@oracle.com>
Date:   Wed, 13 Apr 2022 12:28:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RESEND 1/1] lib/Kconfig: remove DEBUG_PER_CPU_MAPS
 dependency for CPUMASK_OFFSTACK
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, gregkh@linuxfoundation.org,
        masahiroy@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        mingo@kernel.org, vbabka@suse.cz, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
References: <20220412231508.32629-1-libo.chen@oracle.com>
 <20220412231508.32629-2-libo.chen@oracle.com>
 <c7d26e9d-8c70-86a6-cdab-b180a365804f@infradead.org>
 <157cb46a-d134-2e72-4a65-14e378dd2b8e@oracle.com>
 <26855467-107d-4ba1-4f32-2afd5918d5b7@infradead.org>
 <cbb6b94e-3b9d-c7b6-a10e-6203a3a8b3f3@oracle.com>
 <4c6b3445-78b2-090f-c7c9-291d49c45019@infradead.org>
 <506db9a9-47ff-658a-a821-27315949e8c3@oracle.com>
 <8eb6f58a-2621-0977-1b67-b2c58e4d5fba@infradead.org>
From:   Libo Chen <libo.chen@oracle.com>
In-Reply-To: <8eb6f58a-2621-0977-1b67-b2c58e4d5fba@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0030.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::43) To SJ0PR10MB4576.namprd10.prod.outlook.com
 (2603:10b6:a03:2ae::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 652c2e2a-351f-4a1d-4b05-08da1d83d0e6
X-MS-TrafficTypeDiagnostic: SN4PR10MB5656:EE_
X-Microsoft-Antispam-PRVS: <SN4PR10MB5656DE9E2E0EC1AC69577C7785EC9@SN4PR10MB5656.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M0lgj6FPg1T8EcwoXLnve+Z8dm61iCu/RdsmtcuI5N+MeWurBMkLWUtCCVVvZylJFmULy8vL9atNFC6YGWz29owG3wPBKq7alj392pEYc7hA57O23pIy5e+LWZbsIsFlnCYnNAmhSbuH6t9rnL6DuwIVRpxNAHCNR3wlDZ62Qomye3XObloSTwx8WV4NlEEqb5UT14p5NM9rjPHigIrQJgvYsApFxnjMTeEt4vXKo4dzPFi8RTmW/+gCyv528REIX/0MLT5z0lUvFwn8izD3NfYlvjSQXnmHXj3KJczbXP4gdc+bwVtpuycxgBa0mHnaeHNYJEWjTEicsH39MCY5zW+ECUSNaWqprfJwN76vo+ar3SU+4zaLammRWLT0cGHdbGJTWj5QIcFxS+UTeyNgOkdnx4F2rMJR73g6o+v+k1BPXQfxkiQ62JOa8Xmvi8IYB9SC8AKBLNZ8Dr+6R8AGfG+5K9hqfoCbqFT2ftN8fcH0aCyJii7iuXD+u27mwew6wUu4SijQsJD0jCQaHeOY5dFZEpxV0o+Dxyx64Rnt6eIzrr61uvU6kngVN5Fps/jB9e0WsBEPYdICdMIq9DSn9fcRWffG3mXUnnGz3QWfbnsAAactQA3arCx9PbzWHncl/EaDNOtHwVAz067BxRppcbp7tBuOBFif60gVW9uNhvVbgDoVo0QW/meNmRFA40F5cIULUpTt4q7M5oi9VsLR0BJ+BbKEEnSJ5SR2q4d4aEUFZkoex5DdcKy4V3m8CDuT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(31686004)(316002)(6512007)(52116002)(6506007)(36756003)(31696002)(508600001)(6666004)(38100700002)(2616005)(53546011)(86362001)(44832011)(2906002)(5660300002)(7416002)(4326008)(66476007)(186003)(66946007)(8676002)(8936002)(66556008)(83380400001)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2lGYURaUEFESk9jUXhEM2hGaTNGbTVhRDFRRnpTTHhqejkvMEJQTGlGT2sr?=
 =?utf-8?B?MlpwSWVqZEQ5Y1pCYVV0UGMxQkJESTRSTit3YUhZOVRVckU0Skx2VHcyZFlM?=
 =?utf-8?B?WXFFQ0xZMmpkU0tObHpsVFBGSG9aMG9yamtRQTlZdHBqL3V2MEpjem1rQU9D?=
 =?utf-8?B?cnQvRlE1Z29wZXNFTU9DY0JuS3VJQ3pZbThtRlR1SXU4OW5tODloSUw4U1FZ?=
 =?utf-8?B?RENLOFdydGNCbVpWdkJLcytrZy9mK1d4UjErMFRIaVNZdUhlU29xTlpEb2hu?=
 =?utf-8?B?bi9xWFBnSktZSE1Db1BtUzk4azBCeldwM0FkdDUvZHhCNit3TGMyMlQwN1ZI?=
 =?utf-8?B?L1RweFVxRzlHaEtlalpNclVUNkdFRGtlSlVLNmRRK29uT3hxSVpJNDRTZGo4?=
 =?utf-8?B?OS9yYmF1eGcrM1dZaWxMM08vR1A4TTRnTUFhSFI3cmJpM3VhNEQ3bUtNT3BI?=
 =?utf-8?B?QVUrWlRLZWVIb0lPZ0FINkcvekovLzNwb2tJdjFmOEo2NUlPMnNIRUZGenNI?=
 =?utf-8?B?M2FLSlRVZnljVzUwQ0JJcDZUOWpPelltNkd1VG1kdzZ0SU91eFM0SHFGNEJG?=
 =?utf-8?B?VDRyOW9ScjlqaGFFdEtPTEVuZGcwdEw5bWswVVptcWxvSWZSUjQ4cmpPUHkr?=
 =?utf-8?B?SHVsT1ZXcm5YOHduK1BCZ3NjWnp5QU5uallCaEZCd2UvYlMvbndCRndnWEpw?=
 =?utf-8?B?R0xpc2V2RVZuVVhKdGdWZG4ya2hGbUF6R0hIRFk3RHZrTTNBcnBOSjdnNzBD?=
 =?utf-8?B?M0FxaHN1UXRoVW1UM0R2bUIrYVRCYUVJQ21FQUJodDd4eHc2blBKWjJubW9l?=
 =?utf-8?B?QjJxZHZBeUtKUmZ1cVNxSnNXN3lzcXNGZFBsd3FEalFwRzdSVFBmazBGNzd3?=
 =?utf-8?B?MWVnZjJORUtxdVVyUjBVSVM1aG1jUkE4aU8vcEVYQ0hzaXYySzArcGdHVDk2?=
 =?utf-8?B?ekZxWk0wTTJiV01uS1VJMTFyQ2NzVmVLUVJXcDZCR0FvU3o2NldyV0JabmZs?=
 =?utf-8?B?T3NRdVFrdk1zdE1Sa2lDd0dnSGp1K0l2dVdsSlpoZHJhNkFNdXlHdjBtRU5M?=
 =?utf-8?B?ZGhVbXJ1MytJVlB6SlI1LzBUdDAzVmcwU1dGTGJjOWZiZDRSd3U3dnlRUkFM?=
 =?utf-8?B?cWNaZGRLTmtJT0dLZWRaRmZEWUVBa2tLY0lFdUlzdkRpdXA0bUlGdlFiWXhZ?=
 =?utf-8?B?UnFyeFdpL1h1a2s2YUNOWTV5bnVWY1JxRXdramR2OE43MEluYWN5SHFvT2Yy?=
 =?utf-8?B?Tm5yUm8yNVo1dThid1R4endkSzdSMjh0UGx6N0swdWRwcDFBSDhDc0FxcnRX?=
 =?utf-8?B?cHR5Mi9jOFVOaVhYSEhGUUpOSFI0R2d3anJMOGxyUHFVdnBPOTA5aVVvUi9o?=
 =?utf-8?B?NEpMSFRHbWdpZW1WVk9QenpucHVNcFJsVGU0RTM1MGhvMUVJRW9xQjdxSm5o?=
 =?utf-8?B?RUpJbGxVeGU2VjNPTHlnVDA5N0lCbEIyUjJWaFg0bVhTVEJHcCtHZXNjREtQ?=
 =?utf-8?B?b0poUFJLNEEzdWRzdFlhMTJPOUcyeXhIN09GWHhmOE51UldoMjZ2aUw0L3Vo?=
 =?utf-8?B?T3RKY3M2bDJaRndqWExBZUk3c0lkUm41aFVpWG5KTnVsaVpVZE8zMDJEek5P?=
 =?utf-8?B?cFdxdUtlaEFsWWx4bHZCdVluK2UwaEZ1Q090OXZJZ0F4KzZ3REkrZFdVVDRz?=
 =?utf-8?B?Y3BGakI1ck1kMkNMMTh4QUZpUHprZk5QSW9COUVrbVlKTEp4Q1BzV2xXTm94?=
 =?utf-8?B?amhpL0ZrS1FzMEsrY2lHTkhSODhWc1FIcnpBemFtWXJmLzZ6amNCL01DbWht?=
 =?utf-8?B?dk4rUTNFcjdJbUpJbWNqSTFXVWVEMDhnR21aYlA0QzFHQ3EvR2tndGtJTlIy?=
 =?utf-8?B?T0lRMXl0azJPdE5UR2doczRIRS9ONW5BNkNkS3MxS016Z3phekkvaUlrRklI?=
 =?utf-8?B?OURoSHZlc0xWWndXcWtabjhBN2VsRkRSSStteXNjRmdPM2JSYzdBcVhLTFFw?=
 =?utf-8?B?aTMxUVBCdVNsQXhxTU42SE56TElndFJoNUY2RVR3OHN6VWZCbmROeUtCV0pa?=
 =?utf-8?B?MU5MMUZQNStQaWJzYTNlTEpVU0tEeUdyYWM2YndzT2ZFUGRQVG9vS01SMUY3?=
 =?utf-8?B?bWJwQkZpcVRNMXhkeHIyc21uT1VEZFR1YjZ1eHRvRWh5c2tSOTVETmo4dHQ5?=
 =?utf-8?B?S1V2YnlvSzV6Qm1KcXU1RDlxSHZZQ0ZRa2xoTHBpZUpHQ0RUYk4xdTV0TGtI?=
 =?utf-8?B?Z2U5RDdJUmVPYUI1azlqaUNlME5UbXdSbktXa01sTnZHTTZLTVRpOFczSitp?=
 =?utf-8?B?WVBGQWpBMW41NWFhbWxBRk9NZ3RkdzNpWmlXQnZIaVJkUjJselZRR2xVaC9Q?=
 =?utf-8?Q?n678LyYrpcbFdAMJAltpPufj5mQGOM6gfBClM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 652c2e2a-351f-4a1d-4b05-08da1d83d0e6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 19:28:41.0595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpPZaKUx7+KMNOwmZdDPpIF3yLLpAQ9k+W7saxiz2uK7x7ZUUOjufO5+66R4lr6ZEvR8RbBhNtA0AH9JqYAjyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5656
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-13_03:2022-04-13,2022-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204130093
X-Proofpoint-GUID: wwYFZV4pJmG9Kh8YxzoYxixmSt0gxu7k
X-Proofpoint-ORIG-GUID: wwYFZV4pJmG9Kh8YxzoYxixmSt0gxu7k
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 4/13/22 08:41, Randy Dunlap wrote:
>
> On 4/12/22 23:56, Libo Chen wrote:
>> Hi Randy
>>
>> On 4/12/22 22:54, Randy Dunlap wrote:
>>> Hi Libo,
>>>
>>> On 4/12/22 19:34, Libo Chen wrote:
>>>> On 4/12/22 19:13, Randy Dunlap wrote:
>>>>> Hi,
>>>>>
>>>>> On 4/12/22 18:35, Libo Chen wrote:
>>>>>> Hi Randy,
>>>>>>
>>>>>> On 4/12/22 17:18, Randy Dunlap wrote:
>>>>>>> Hi--
>>>>>>>
>>>>>>> On 4/12/22 16:15, Libo Chen wrote:
>>>>>>>> Forcing CPUMASK_OFFSTACK to be conditoned on DEBUG_PER_CPU_MAPS doesn't
>>>>>>>> make a lot of sense nowaday. Even the original patch dating back to 2008,
>>>>>>>> aab46da0520a ("cpumask: Add CONFIG_CPUMASK_OFFSTACK") didn't give any
>>>>>>>> rationale for such dependency.
>>>>>>>>
>>>>>>>> Nowhere in the code supports the presumption that DEBUG_PER_CPU_MAPS is
>>>>>>>> necessary for CONFIG_CPUMASK_OFFSTACK. Make no mistake, it's good to
>>>>>>>> have DEBUG_PER_CPU_MAPS for debugging purpose or precaution, but it's
>>>>>>>> simply not a hard requirement for CPUMASK_OFFSTACK. Moreover, x86 Kconfig
>>>>>>>> already can set CPUMASK_OFFSTACK=y without DEBUG_PER_CPU_MAPS=y.
>>>>>>>> There is no reason other architectures cannot given the fact that they
>>>>>>>> have even fewer, if any, arch-specific CONFIG_DEBUG_PER_CPU_MAPS code than
>>>>>>>> x86.
>>>>>>>>
>>>>>>>> Signed-off-by: Libo Chen <libo.chen@oracle.com>
>>>>>>>> ---
>>>>>>>>      lib/Kconfig | 2 +-
>>>>>>>>      1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/lib/Kconfig b/lib/Kconfig
>>>>>>>> index 087e06b4cdfd..7209039dfb59 100644
>>>>>>>> --- a/lib/Kconfig
>>>>>>>> +++ b/lib/Kconfig
>>>>>>>> @@ -511,7 +511,7 @@ config CHECK_SIGNATURE
>>>>>>>>          bool
>>>>>>>>        config CPUMASK_OFFSTACK
>>>>>>>> -    bool "Force CPU masks off stack" if DEBUG_PER_CPU_MAPS
>>>>>>> This "if" dependency only controls whether the Kconfig symbol's prompt is
>>>>>>> displayed (presented) in kconfig tools. Removing it makes the prompt always
>>>>>>> be displayed.
>>>>>>>
>>>>>>> Any architecture could select (should be able to) CPUMASK_OFFSTACK independently
>>>>>>> of DEBUG_PER_CPU_MAPS.
>>>>>> Do you mean changing arch/xxxx/Kconfig to select CPUMASK_OFFSTACK under some config xxx? That will work but it requires code changes for each architecture.
>>>>>> But if you are talking about setting CONFIG_CPUMASK_OFFSTACK=y without CONFIG_DEBUG_PER_CPU_MAPS directly in config file, I have tried, it doesn't work.
>>>>> I'm just talking about the Kconfig change below.  Not talking about whatever else
>>>>> it might require per architecture.
>>>>>
>>>>> But you say you have tried that and it doesn't work. What part of it doesn't work?
>>>>> The Kconfig part or some code execution?
>>>> oh the Kconfig part. For example, make olddefconfig on a config file with CPUMASK_OFFSTACK=y only turns off CPUMASK_OFFSTACK unless I explicitly set DEBUG_PER_CPU_MAPS=y
>>> I can enable CPUMASK_OFFSTACK for arm64 without having DEBUG_PER_CPU_MAPS enabled.
>>> (with a patch, of course.)
>>> It builds OK. I don't know if it will run OK.
>> I am a little confused, did you succeed with your patch (replacing "if" with "depends on") or my patch (removing "if")? Because I definitely cannot enable CPUMASK_OFFSTACK for arm64 without DEBUG_PER_CPUMAPS enabled using your change.
> This patch builds cleanly for me:
>
> ---
>   arch/arm64/Kconfig |    1 +
>   lib/Kconfig        |    2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
>
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -511,7 +511,7 @@ config CHECK_SIGNATURE
>   	bool
>   
>   config CPUMASK_OFFSTACK
> -	bool "Force CPU masks off stack" if DEBUG_PER_CPU_MAPS
> +	bool "Force CPU masks off stack"
>   	help
>   	  Use dynamic allocation for cpumask_var_t, instead of putting
>   	  them on the stack.  This is a bit more expensive, but avoids
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -316,6 +316,7 @@ config ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
>   
>   config SMP
>   	def_bool y
> +	select CPUMASK_OFFSTACK
>   
>   config KERNEL_MODE_NEON
>   	def_bool y
>
> along with:
> # CONFIG_DEBUG_PER_CPU_MAPS is not set
>
>
>>> I think that you are arguing for a patch like this:
>> I am actually arguing for the opposite, I don't think CPUMASK_OFFSTACK should require DEBUG_PER_CPU_MAPS. They should be separate and independent to each other. So removing "if ..." should be enough in my opinion.
> I agree.
>
>>> --- a/lib/Kconfig
>>> +++ b/lib/Kconfig
>>> @@ -511,7 +511,8 @@ config CHECK_SIGNATURE
>>>        bool
>>>      config CPUMASK_OFFSTACK
>>> -    bool "Force CPU masks off stack" if DEBUG_PER_CPU_MAPS
>>> +    bool "Force CPU masks off stack"
>>> +    depends on DEBUG_PER_CPU_MAPS
>> This forces every arch to enable DEBUG_PER_CPU_MAPS if they want to enable CPUMASK_OFFSTACK, it's even stronger than "if". My whole argument is CPUMASK_OFFSTACK should be enable/disabled independent of DEBUG_PER_CPU_MASK
>>>        help
>>>          Use dynamic allocation for cpumask_var_t, instead of putting
>>>          them on the stack.  This is a bit more expensive, but avoids
>>>
>>>
>>> As I said earlier, the "if" on the "bool" line just controls the prompt message.
>>> This patch make CPUMASK_OFFSTACK require DEBUG_PER_CPU_MAPS -- which might be overkill.
>>>
>> Okay I understand now "if" on the "boot" is not a dependency and it only controls the prompt message, then the question is why we cannot enable CPUMASK_OFFSTACK without DEBUG_PER_CPU_MAPS if it only controls prompt message? Is it not the behavior we expect?
> Yes, it is. I don't know that the problem is...
Masahiro explained that CPUMASK_OFFSTACK can only be configured by 
options not users if DEBUG_PER_CPU_MASK is not enabled. This doesn't 
seem to be what we want.

Libo

