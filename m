Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C0F500166
	for <lists+linux-arch@lfdr.de>; Wed, 13 Apr 2022 23:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiDMVxf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Apr 2022 17:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiDMVxe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Apr 2022 17:53:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D7F26126;
        Wed, 13 Apr 2022 14:51:11 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23DJD5AF018804;
        Wed, 13 Apr 2022 21:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ThKbykxu5ThdQEfm7z601i0xonkGU4KENH3NYACejSE=;
 b=JK2iGWGb6BQjkbLbnyus0x68HpNy0uPFRfWJZwtIZxoihwP9mHlxlOOD6A2cUD1+oRBZ
 86yQLGyWqtt9F8wGaCIhZr9s7NdO0GwqMp8w8YrY/JAI7MJkWnHL9Nns96U7pK9H4erI
 4obCSLWySvk/C4J9+X2K6380wq0Lkz86UqWjQXF2p3iRUAnzazX+zZ9OLXlwAA7D7L5f
 aF7oVxnp6ZLHWqiPBBbCcmMTnOUn3jCkpwnrI4htgz5a9VxQ/XfI8FXfun5f1i8taa0A
 fA/36EGztssEwGXT3/JskcpPYOfgxE1QlkC/zGLjMR4O7DhyV0uKrpLNZ+hksYfI6VFo hA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0r1kb01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 21:50:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23DLZl4s024555;
        Wed, 13 Apr 2022 21:50:46 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2042.outbound.protection.outlook.com [104.47.73.42])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k4nqjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 21:50:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKksV4vLeQJaOlrtWF8j0XLKi6t2JrEvxowi2QOqCYcexOeNF/F7t9qxGu9nFEnAAadvS/vo1Q8NReAsyup6nSR/Ie2qBt8OHZVwKXKfwgq7OabDMxIVAgekDVJFPF+aui01GLc1Uupj/LU3LDCY54AOpl+5oBZcDLUM1oE5qiCD9+D+7ciFM5P2PCQDDfN+3jZBXJ/GVGszxlAf+TwdcZsbQd5Ma03oktMRIFccx4oDjFiISFbv5NgdyKCWYzmD53pvPC31gt0TbBTsgS7lwB+yI0KkHLAvqsh8wIKMJm1w5znBBXa2Z4I+MREYz88bwbfGcr3t+P8utwDLtaePwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThKbykxu5ThdQEfm7z601i0xonkGU4KENH3NYACejSE=;
 b=ILgc4+5ifBct3MbiXeFnY5ASID0iYN1pqKcCuFdn67imI8NAAYFn96J2rGWJmhyACkXg1P2g28F2ua4/KRfBP3jTPT9f0bYFqFVQMDLCXu6ejJgGmCERTHDt6KmAP4NAivPWq6w0k1YetyF69C+Xi1xdGGZYInICIu7E86WqQGnhzW4rv2PLO5iL8kX9aFdz8w/tKI1SzgMgEDVqmitdv9TFjWeFYlCocB0aPyKwVNMEtFxQnIQgnl1i7EGU1qmDMQPpCTpxHoK54u1notnDZIkJK44YXJfzp+XjbD6RLDjP2ZqH8lqza3lQhEbUyB4cIKK0qb9KtlNihJCYu4fvuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThKbykxu5ThdQEfm7z601i0xonkGU4KENH3NYACejSE=;
 b=TrHaPXiZQU0ng8fDvNhCPZjPasNfQBJXRjOef7TpwGyLONcBX9C7q9YR5NqtdTPdQbU4rKbgEG9iUdgOCpQY8r/lOFOgPzPVVTzxxhch1n7iVlDo810B71IFRg10Br8effdiHmWtRlOubvq2MrdZVHV3NfMaGeTcp3f3ibc3y/o=
Received: from SJ0PR10MB4576.namprd10.prod.outlook.com (2603:10b6:a03:2ae::5)
 by SJ0PR10MB5741.namprd10.prod.outlook.com (2603:10b6:a03:3ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 21:50:44 +0000
Received: from SJ0PR10MB4576.namprd10.prod.outlook.com
 ([fe80::498f:2fd5:893b:f008]) by SJ0PR10MB4576.namprd10.prod.outlook.com
 ([fe80::498f:2fd5:893b:f008%6]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 21:50:44 +0000
Message-ID: <ce420ed3-4a36-122f-460d-8cccd0310033@oracle.com>
Date:   Wed, 13 Apr 2022 14:50:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RESEND 1/1] lib/Kconfig: remove DEBUG_PER_CPU_MAPS
 dependency for CPUMASK_OFFSTACK
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>
References: <20220412231508.32629-1-libo.chen@oracle.com>
 <20220412231508.32629-2-libo.chen@oracle.com>
 <c7d26e9d-8c70-86a6-cdab-b180a365804f@infradead.org>
 <157cb46a-d134-2e72-4a65-14e378dd2b8e@oracle.com>
 <26855467-107d-4ba1-4f32-2afd5918d5b7@infradead.org>
 <cbb6b94e-3b9d-c7b6-a10e-6203a3a8b3f3@oracle.com>
 <4c6b3445-78b2-090f-c7c9-291d49c45019@infradead.org>
 <506db9a9-47ff-658a-a821-27315949e8c3@oracle.com>
 <8eb6f58a-2621-0977-1b67-b2c58e4d5fba@infradead.org>
 <c2e6bb8b-c9d9-ad39-7a8e-3df6849b2fb2@oracle.com>
 <CAK8P3a3wgbYPY6CxbkkFkEboXYLWREaL3oUmHyet5wPYpc4Vng@mail.gmail.com>
From:   Libo Chen <libo.chen@oracle.com>
In-Reply-To: <CAK8P3a3wgbYPY6CxbkkFkEboXYLWREaL3oUmHyet5wPYpc4Vng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0140.namprd11.prod.outlook.com
 (2603:10b6:806:131::25) To SJ0PR10MB4576.namprd10.prod.outlook.com
 (2603:10b6:a03:2ae::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b499b30-4561-4e8e-4cc9-08da1d97a90a
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5741:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB574184A1E2EF3353725EE10F85EC9@SJ0PR10MB5741.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tgk01uWtZ4i33n4RgykPMlAbNKg7oWAZ3OZ2AkDYVgrymc8Zsf3tTLF2AjCHTM+T7eIcQZtzrf5cAdDawIgOt5Oejd1JmRxmLpWXE91VA9f+6y357xg6Myc85lYOyXN1q5/yQIIhvbTQPHIyXsrbx4Wots9yQqXCbbrsE7XwXGjBcL89rvS4qLDnSutgi20kEym+rPJ01Dd5byuNoy+i8XkxbMRP+1YLhiD6PbWngent3gLFKICc87wu5wOBUtM8jnMJVW+Cx2WsypOBoI1NfigB4c9w+qGokNluCNXhFkAUa/IZnFkGajXNm9uS7d/Jl3LCZPk9SVR+ArLHKV9OgGoz31+sj9mSoITNdSNjermDSFsk9o/HmI879j5fdDrdHETkYaOR6xJoM9VU+WaaFWYmkPgmMXDmV5I/2+KkTR7wKDnmjcX/tGSIO9PqcqumPmlV0ofUzPq0DOxXsWlYagGpqz15h/QM4yyU49eOHb+mnxkcztRqXjJfAt1hMt8QmOOxCcLwLPSPQ4D/uvm+DaLUpklVB8SxIuPbDxc8bZLu8OgVm+Y4gQlFD/4UDgqRp6PJJe95DcrhP0Dc844f/C6dqHwucUm8Q4UdUroVPkysJFMvubsEu/a3OI1gdtvKPjUh0tajRrtfmGFYAUmf5gmI4F1fBRAQwk2dwczBArU9jxZB2AbOWqGtQ8vWVmLnYLFren1Zbt08WCPa64K8iP5Mla0KHDCoro81F9Y0nSQsVGPm2y5TcPGIhzJwn8k+8rQlBwitYSoqLt5EIh7F8VqIZPf9aOqe0D4wyX1Wx88=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(86362001)(54906003)(5660300002)(44832011)(508600001)(6512007)(83380400001)(4326008)(6666004)(8676002)(2616005)(2906002)(66476007)(66946007)(8936002)(6486002)(38100700002)(7416002)(66556008)(53546011)(52116002)(186003)(316002)(36756003)(6916009)(31686004)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFNWa3Joei9IcHNVQkhHMUMyRFRQOXZjNjBUV1NYRW5pZFllOFFSUVl0TFln?=
 =?utf-8?B?b1hSSnpNbHV4R0U0NmZWTE9BTmZucHhMUExVTGs3b3ZZSkdvSzFBbitDTklZ?=
 =?utf-8?B?SE41eVlsdDJYWk1uZzk2dFluSE5EK2czdHQ3S1QwM2FtY1F6NmgxZXRjQ3Jn?=
 =?utf-8?B?NW93QkcyaWliRVMvVVRQc1d1Nk9IVGtodk04RlpKWDNaQjRPZnRMUks3b0g3?=
 =?utf-8?B?THdJd1hRbzhKbTNJNGcvY0Y5YzdZeDY3cXZGM1cyczJudW5OMG4wQ0ZDNUlN?=
 =?utf-8?B?d0hJUGlaZkZzNzdqQW1rNFNKcUhDT0FxTmN0MDRBK0tXMlhEOWs0aXBNRUsy?=
 =?utf-8?B?WkNDT1UrU2llaXdKMm1OOGJCM2VvN2k2Qy9nREk5MDhoRjlzWDVXMkI3UG00?=
 =?utf-8?B?ZldZUkFkYkVwRHdZNTdFNmRjN2ZweitiZThLN1Nad2VManRZNFBhTkNBWVpz?=
 =?utf-8?B?UlVRWkVTVHRuRVpRWlNaN0o1eVFMaXBxdmtOSjRmbGF1MFdWWFEvVzRrN3Bw?=
 =?utf-8?B?M2lTQzZvU3dwWGd1SDN4NzBGdm5EUWxJU0FWMUYxaHQrbkdUK0FhTzFLNHFQ?=
 =?utf-8?B?TWhsK0dqQnE1TnJ0YlFiRE1yUXpjbGRJRUZLbzBKd3lmdTE4RXViOEpuZUtX?=
 =?utf-8?B?MEZQVWFmVXgwbEdjZndEQlBHMGtDM1J5LzVPa0JhcXVlditKMUZjdnZ6NGoz?=
 =?utf-8?B?c0VzY3RGeE1KZFVFd1hGblZmV0hBYURDRWdLaTZNNG84c3dDNExqSk1Dd0F3?=
 =?utf-8?B?TFc2NVp3eFdMM3VET2FXTGRuTnp1cWUxT1FwVFd6eFlkUkZkM1RpdGdJTG96?=
 =?utf-8?B?TWYzMUdHV1gxbGRFUWlXcDZmMk5MUHA5WnlFS0d3L1hIWWNTQ2ZDZDZTN0VO?=
 =?utf-8?B?L2xQVTBDcVdFbTBxb003ZzMrRncwUGc1SGY4eGhaN0tCY2J4aUtmdzBqZ3Ri?=
 =?utf-8?B?cEtzbVcrSDVEYXp6SlQyQlE5MEU5QUtIS251RnVOc0RaL2drYk9kdkFnQ0lP?=
 =?utf-8?B?N2xmSllQRlNLaXZlMjJkNHNIUjh2ZUluVytLdnpKYytaT2c3Q3JiaFFGRkEr?=
 =?utf-8?B?Tkh3M3JmbnRua09PLzVWUldlelBwcEdRQlh6QWtoRDd5cjFTbzFQSlQ4alR1?=
 =?utf-8?B?UDBlVmlOaTREZmN3RUFOeWJZbzBBbjc5OGNKVVF3WlFwYVVWTWY3N2Jqa1RF?=
 =?utf-8?B?cGFyemd3MHZJTmpPQWREMFlmRUdaMGEwUHhwemRHWkRiTWFoLzNOVERMNTVy?=
 =?utf-8?B?UlZxNTRqblFtNytGNU95ZmNxSFJJTGdJcmNnc3JhWXFQSDRnNDZHakpwdnlw?=
 =?utf-8?B?aE9YSmxyVno3WWdrOWJBZ2VZRTg4aXVuaXRMc0RzMG9kTmxEVDB6c2hlUENH?=
 =?utf-8?B?ODM0bUt2aWk5TnR2RlRsakYvOVJiUU94dXBnSlptdHBGTHE2SWpCdFZEWlhj?=
 =?utf-8?B?MmVCNyt3eU1CWEExUG1wS2IzU1RCM1hlMHJ1NjFBTXc3SlNPWkU1Q0t0Y0ZZ?=
 =?utf-8?B?UlN5bDI0R0xWbE1maXB2KzlEeGlxeFRDZG13TjliakhVck13YmhMenRQK2xR?=
 =?utf-8?B?OXFQand4K0pkalZkSnZGYXJ6T3ZGNGswYWJyZ1ArTWUvYzNWcGF0V2ZNS3Nu?=
 =?utf-8?B?OTAvSW5kWUhQc1JkVHdVYlJkSVcySW1Va0RZOG9EMWZLb1creDdESW1Dd29D?=
 =?utf-8?B?RUdzUGljRjEyYmRyWnhFVFlEMUo2WDMzYjBpRTdSZVZjQXBoRVcxcTl1ZXpo?=
 =?utf-8?B?RkJhTnYzV0dLMVZzWVUxaGpNQzlrdzMydXVwZnpxejRQa3VkekIwZVJOWUly?=
 =?utf-8?B?d0ZnZFd5TUp2UXVwTm1haDNhcjZYSWtvem9aOWJYaWQvOUhGMGJucXBaU1Jx?=
 =?utf-8?B?Mm1CTWoxaTh2S3BhbTIwbDVFajFIWWs1VThhdnJNSThLVXR5YkRMNGdLT2ov?=
 =?utf-8?B?dzJZZWVpNEhFVjZzTG9qaE9FM05WVkJPMHM2eXk5cmpRREpwc2c5UkkzZnVl?=
 =?utf-8?B?ZDR2RkNvamxJLzdIWDhLQTdRMDdpZFlCUXk3V2FyTEYzWDdHZzUzNlV4VHZB?=
 =?utf-8?B?M1E4QkhuejM3K2ZpcXd6aFFvdnVUMW4yZ1FEajlsakMreEkzVDFZRzE3c0R5?=
 =?utf-8?B?UEc5dTRrVER2eS9iZU55OSt1VmpkWGJXSVZRVDRQNG5HdUFrYnhlNnNNencr?=
 =?utf-8?B?MWlpeEdHa3hKM0JNMUIzMkZWRnhQYXJPM3BCVGhYQlAvWGFlazYweEQ1ZldP?=
 =?utf-8?B?RE9sdjhWT2RXNnV3OEF1NkRJTmhJL0VRSzdXbm1MRFBsb0prdm9YaW9QaVk1?=
 =?utf-8?B?YUdpTG5ldVdMU000bWZ3eHNJbmpFdDFxdUZKZDQ2VmJMdE44aVRES21ReUJk?=
 =?utf-8?Q?VIjm52602cueyqjgMK3O7M4OfPo0Q8g4guNaF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b499b30-4561-4e8e-4cc9-08da1d97a90a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 21:50:44.1512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5eAyel3riVyk77KTPWlb0Y3XUiU7+on9NRp8D88cS77JZDWAyf45jA/F3GTJpykWTvygdqrr0/liEeVYaB7Z6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5741
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-13_04:2022-04-13,2022-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=605 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204130104
X-Proofpoint-GUID: xUuJwZtBq86kZY6H9bxz0qbfOadJl7IX
X-Proofpoint-ORIG-GUID: xUuJwZtBq86kZY6H9bxz0qbfOadJl7IX
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 4/13/22 13:52, Arnd Bergmann wrote:
> On Wed, Apr 13, 2022 at 9:28 PM Libo Chen <libo.chen@oracle.com> wrote:
>> On 4/13/22 08:41, Randy Dunlap wrote:
>>> On 4/12/22 23:56, Libo Chen wrote:
>>>>> --- a/lib/Kconfig
>>>>> +++ b/lib/Kconfig
>>>>> @@ -511,7 +511,8 @@ config CHECK_SIGNATURE
>>>>>         bool
>>>>>       config CPUMASK_OFFSTACK
>>>>> -    bool "Force CPU masks off stack" if DEBUG_PER_CPU_MAPS
>>>>> +    bool "Force CPU masks off stack"
>>>>> +    depends on DEBUG_PER_CPU_MAPS
>>>> This forces every arch to enable DEBUG_PER_CPU_MAPS if they want to enable CPUMASK_OFFSTACK, it's even stronger than "if". My whole argument is CPUMASK_OFFSTACK should be enable/disabled independent of DEBUG_PER_CPU_MASK
>>>>>         help
>>>>>           Use dynamic allocation for cpumask_var_t, instead of putting
>>>>>           them on the stack.  This is a bit more expensive, but avoids
>>>>>
>>>>>
>>>>> As I said earlier, the "if" on the "bool" line just controls the prompt message.
>>>>> This patch make CPUMASK_OFFSTACK require DEBUG_PER_CPU_MAPS -- which might be overkill.
>>>>>
>>>> Okay I understand now "if" on the "boot" is not a dependency and it only controls the prompt message, then the question is why we cannot enable CPUMASK_OFFSTACK without DEBUG_PER_CPU_MAPS if it only controls prompt message? Is it not the behavior we expect?
>>> Yes, it is. I don't know that the problem is...
>> Masahiro explained that CPUMASK_OFFSTACK can only be configured by
>> options not users if DEBUG_PER_CPU_MASK is not enabled. This doesn't
>> seem to be what we want.
> I think the correct way to do it is to follow x86 and powerpc, and tying
> CPUMASK_OFFSTACK to "large" values of CONFIG_NR_CPUS.
> For smaller values of NR_CPUS, the onstack masks are obviously
> cheaper, we just need to decide what the cut-off point is.
I agree. It appears enabling CPUMASK_OFFSTACK breaks kernel builds on 
some architectures such as parisc and nios2 as reported by kernel test 
robot. Maybe it makes sense to use DEBUG_PER_CPU_MAPS as some kind of 
guard on CPUMASK_OFFSTACK.
> In x86, the onstack masks can be selected for normal SMP builds with
> up to 512 CPUs, while CONFIG_MAXSMP=y raises the limit to 8192
> CPUs while selecting CPUMASK_OFFSTACK.
> PowerPC does it the other way round, selecting CPUMASK_OFFSTACK
> implicitly whenever NR_CPUS is set to 8192 or more.
>
> I think we can easily do the same as powerpc on arm64. With the
I am leaning more towards x86's way because even NR_CPUS=160 is too 
expensive for 4-core arm64 VMs according to apachebench. I highly doubt 
that there is a good cut-off point to make everybody happy (or not unhappy).
> ApacheBench test you cite in the patch description, what is the
> value of NR_CPUS at which you start seeing a noticeable
> benefit for offstack masks? Can you do the same test for
> NR_CPUS=1024 or 2048?
As mentioned above, a good cut-off point moves depends on the actual 
number of CPUs. But yeah I can do the same test for 1024 or even smaller 
NR_CPUs values on the same 64-core arm64 VM setup.

Libo

>
>             Arnd

