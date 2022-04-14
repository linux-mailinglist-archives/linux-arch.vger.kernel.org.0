Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D5B501AB0
	for <lists+linux-arch@lfdr.de>; Thu, 14 Apr 2022 20:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240990AbiDNSEH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Apr 2022 14:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiDNSEG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Apr 2022 14:04:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8665164BD2;
        Thu, 14 Apr 2022 11:01:41 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EFsI8R018804;
        Thu, 14 Apr 2022 18:01:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/h5Xm6MERGlI1+MrHKGWDG1vD5luveVQUZy/ibzxD6w=;
 b=dobzpT4Q8NxbWYGhSk3Zw8+Ibo2OoMF3Z5/4ZELSxz6DSXxIPwbrDbKpL+pk7iOSXfUd
 PmqO3o73nHjfU/WdynJzS0UOZ3Evo5E8BUfNCO5WSfFH0zPWH4nEyGLvceCrrMB8W0mA
 tDKp+LvuQZtlqUxH7tETxKMKsXErAIW0aoypCqqhynHF7UovMbbReTjxXEV7e5QYEw2R
 BUTymdE6/FOspncS/g5WNMcA77fxkE2F60c4PB/svxuRgNJQ9oQ4BsWgcUkmBkLSEyw2
 EOIDw3ApklPYJp5cIXGTWs9FNGYAum1MssOfT3om+hFoeB9LEfVvW4uVWV5q+MjPH9zH ew== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0r1nmq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 18:01:09 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23EHuOjN023376;
        Thu, 14 Apr 2022 18:01:09 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fcg9m0kxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 18:01:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6JwkjO+DXUoBF2WfgrwD4jnhISZxjJgdOovHqc3dBYqNs9nsJFgfLVsI3g/5qB+07lfSX8CnN4cVMwXIRIxhxf9h8gBJYE2MTsPLUPPRmZr4lhFiSqt7p1RVXeIvGfUa7TEd0K+zt/vYVWhB59US3XS53QXTDQ3Li2dTYUzjepeEeqfQgYFmjenl1/nmdVOd/tBskaf3V1MbaD5v4LYJLNbj1eNxmjHA6kSsnpEemhnSYM6bDNcINr068EL2hhldxQxiUDP8qL/Q/J4Wu47wllUl5qI56pDekvSGcQGGG5DotSSO50N7CepW268JPLQVWKf5WCjPoVaIoWsjNjBHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/h5Xm6MERGlI1+MrHKGWDG1vD5luveVQUZy/ibzxD6w=;
 b=Q3EugJ247IQuqvXtoRalj1otOSjTlZycc6IeqiO2VS3lUobFYMFSwo/f6rpOuFCZc+DB9/bVyF7T2rbYJq/vsq6DKdE1OgurKwcQ1hxy9CScEnC8z4VkB/MdB70Zkpyji8hMZW4IY4KLSfX308wC4kR3J5BGtX4y2CotptyXv2bqr5hjuCbsSxvsfwZl1cdjyyhRE9eao33GsDjOk8yUeBRW6sE+qTue+vv+twgxBLGggwTiAyefxYnFtSoq/yK74zh67UV1lVRRGLGmx2KsjD1ISVGRNbIT2Jg9J8hvT5pUK7FdNlHNSPyOIB7oH0z8B/FrfYZSk++Ee4cqcAYp+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/h5Xm6MERGlI1+MrHKGWDG1vD5luveVQUZy/ibzxD6w=;
 b=V+dzvbxDzNvHrl7WotBG8NuVJi/1mBsEJXihROK3Dpwg+1lIJszUfnHilmj01/cX08ObyvY6bAeahxI7DebTiJZroGVXJ2ZIkrIWwRz8S7Dta1on1LxiAMXU5FeYN7QLdJsj63suoNpEj2QSpt9tF/mjS57Ot7bzu7wv3AYr9D8=
Received: from SJ0PR10MB4576.namprd10.prod.outlook.com (2603:10b6:a03:2ae::5)
 by CO6PR10MB5602.namprd10.prod.outlook.com (2603:10b6:303:149::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 18:01:06 +0000
Received: from SJ0PR10MB4576.namprd10.prod.outlook.com
 ([fe80::498f:2fd5:893b:f008]) by SJ0PR10MB4576.namprd10.prod.outlook.com
 ([fe80::498f:2fd5:893b:f008%6]) with mapi id 15.20.5164.020; Thu, 14 Apr 2022
 18:01:06 +0000
Message-ID: <32dc2eb2-1d2c-0f07-3bea-d275d55bb66d@oracle.com>
Date:   Thu, 14 Apr 2022 11:01:03 -0700
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
 <ce420ed3-4a36-122f-460d-8cccd0310033@oracle.com>
 <CAK8P3a0uy8JcHP_G_ebz61AMB-Mx6jr5+vuzJHmWbDCajTdTfQ@mail.gmail.com>
From:   Libo Chen <libo.chen@oracle.com>
In-Reply-To: <CAK8P3a0uy8JcHP_G_ebz61AMB-Mx6jr5+vuzJHmWbDCajTdTfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0045.namprd07.prod.outlook.com
 (2603:10b6:a03:60::22) To SJ0PR10MB4576.namprd10.prod.outlook.com
 (2603:10b6:a03:2ae::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba5c03b5-7d0d-478d-3eed-08da1e40bf50
X-MS-TrafficTypeDiagnostic: CO6PR10MB5602:EE_
X-Microsoft-Antispam-PRVS: <CO6PR10MB56029EBADFFF4DE89A25D9C785EF9@CO6PR10MB5602.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: itRxn2bZSZr86+YtUT4Us3sOD171jwlnEMjcaxhACejgiSLv0372R42W5nfqboyl81ufb4jDcMu4FsFGCBPLVfRLdGbO6nOHwRteiOLhy/w00c93v2YtzVIPE1lquLdkJx6ldFnD/L8z6DbfDFuLRSmk1lQ2YuDoXXEUc8NOlDZkphNiJYfPLum/d0fLQ9DtgZv/MrxEJMReiPwRfFzg6yx+Mj8ikGkBcrhggf25AMmoFeSTVVmtXIpuvSPSAAStOair59UzrpQgapp6b+fibaMopOEB1Y/aKVZNqLIcYSC0mdQtCZomIlKhKGoGKSPNb8t83J3ny+Ve5Dx2a/QVSzNTAVGm52XhPGOznk/0xlawszXTsONQxHLetQTav12AmW+FK1KSmdQIa7QaSEW31L3PC2eH9ZklQcmU6dAO1jl/IzhCeShyQQLpIRfclbfjlZk2wl0cFPdP1KNR7A8HXdaNbfGTJGp4yOyAciH20d6TxhJN5sxvaK0OO+KYbJccOWwo3hrk3alljl3dpC4s6WA6/TWAJ/ukjZMbS9BR6kPUz47sVxyG9GeknQUzV97PwiFvHZmUN7EdgJXdlIx60t5dVu74aVHIIuGDeI8op+S5/1yigiudHRGyKBOs7YD1slmXR0BbZ2CH4U+j83xAYHeVjNOIb5gtEJBmC9stogMDkAtW8XInjQBrC138c/isQUw+vffhEULL0MFYbSQQhI9wjx9M9QB4P9IYgrWdUtk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(6512007)(316002)(86362001)(36756003)(6666004)(38100700002)(66476007)(52116002)(66946007)(508600001)(66556008)(2616005)(31686004)(186003)(44832011)(8676002)(5660300002)(7416002)(83380400001)(2906002)(54906003)(8936002)(6916009)(6506007)(53546011)(4326008)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmlmR1ZUQ3RlNjlEYzl1Qm9CRkc3cTREcVNrMjIzSlduNGIvd1ZNNGJGMVFl?=
 =?utf-8?B?bzFhVWhPclh6Vk05VGlpWHF0d3FZZHRXVHlzZ0ZEcGppMWp5MFJXOGlsU01Q?=
 =?utf-8?B?ZnVuZUxWUHo2VGZEUllYMklCNTFuL1lZMVdnL3JXU05oek8vcFhQcS9hOTA1?=
 =?utf-8?B?MEsrUnY3bE5uN29ZOVNQdHVOVHFob3JtazZBVi9UOFR3MjVaZk01SjdnV0RG?=
 =?utf-8?B?d1RvSEp2cmRqTEovWnBmcFNGdE04ZG9kV2F1NDAyVnFYSFJpMzRTNFd3RFNk?=
 =?utf-8?B?RUJNODRVbmI2KzZTQ2s5ZnVtSlVpTVpFaUZENk1XcFM0TER6dWVNY1RaUzhn?=
 =?utf-8?B?eUZ4NlY4aEMvRVNtZTdWN2NiNVI4cEdOeDk1aXhOK0VGSFljTVZ5RnFWV2k5?=
 =?utf-8?B?b0VrSjlJRTNtZ0xpYnVCbXJaK1MxUG1EN1JGVmV1dGdZMW9OaEpXSUxyWXFk?=
 =?utf-8?B?MzZWVkxoWWplN3RXL2ZaMkI1cG5BcUdRTFdodFcyZkhXM28wOEpQSUxkakox?=
 =?utf-8?B?aHhiNmJudjV3cG9NaG9XVDF1QWJ6N1JEYWpzZEhlZkp1N1dkYjZOb01EZ2dS?=
 =?utf-8?B?SzRNN3p5akphQUkvUjVXY1RGQXNWVksxL1pmUXVReUlia3p4a2p5TzgrK25K?=
 =?utf-8?B?ZkhGMitGVXRUei9lSURUSUdkdzhWYWZhSTd4UDZkZFlKRXlUVmV6UkJqaTBq?=
 =?utf-8?B?ZU43VW9lL1ptc003Vndhc1BMSkhzOGFENzNZbzJmZDdpZ2c3Q0p5cW94TGJO?=
 =?utf-8?B?UXNQS3g0bUxVcy9LaFFDa3BSa2Y4N1VIdGJTRmo4VEhIeHNKeVR3bGRXRUd4?=
 =?utf-8?B?TE5RYlNkekU4dGIyRm9FcFVORjIxTmxxYTNtTlVHb2cxSy83V0JnU0JrV3Ev?=
 =?utf-8?B?TE9mWi85V2dqU1VkNUlqUG5ueWhUdVl1bHljdFV1bkhrYTI1R1EwdjBydm9v?=
 =?utf-8?B?QXcraVB1OHpIWkRzNVAza2dqRitZaGU4SUNvSUZLdG4xbFV0U0l4Mkg1dmhQ?=
 =?utf-8?B?YlNnZ3oveEdES00rRldUejU3dUJIZHk1bjkwbURlSUVkVzZGVE5jTk8zZnE0?=
 =?utf-8?B?ekRUL2NLMXQ1QmJIbEltc0hPODBMSW5NajdSMG51aWI2VHh5SDBiZjlJU1JH?=
 =?utf-8?B?STBKcnBJcklXUHo5STdvRzB5MGorZmJ0UGl2TGJTSU12UkdSQnk3Y2svQml6?=
 =?utf-8?B?VjlIT1QvYUFEdEwzbi85YVNqMW9rTWpNMGpjNyt1cTN0dFJuUnUvcHNleHRH?=
 =?utf-8?B?SysvTFVIUlcvQTNWaERqVnhPV2hBcCtlbGpDV09uSjBObEVyTFVrSUlqV2Jr?=
 =?utf-8?B?cXR1blJjOU91UTJCbzJJdkhTSWQ0cGtUUzhPTjJLNGZ3OFU5bHl4SHJMb1ZT?=
 =?utf-8?B?aHdFZzB1bXZ1WkRpeExIakFUWHJOMDlUcGdMbXByaURYVW9iV0VCUXpnVzVy?=
 =?utf-8?B?Z2JXR1RjZUtsOHBNUmxRUkNJWmVBUm13bzZOd2ZUWVVPWUw1SEFBUmZLMkM4?=
 =?utf-8?B?UnNCUjFNcnlaSmVXNmpId3BZSDEySGpkYkRRd1UrekNYSDI5WGNUSlV6dnJu?=
 =?utf-8?B?VW1aZllaY3ZjZFVGSGplcGJab2orc2tRbDFqOWRTanAzN3JPbk1LWjFsZWxt?=
 =?utf-8?B?aVlYRUJCelhoemhuOWhZNGxOZ0lBcDFvL2Mrb09TVHV0b0p3bTNobCtMVUxK?=
 =?utf-8?B?Wkl5ODdTbEN4b3BpTTU2aDNWbENNRGRLbHhwTU53eFFScWdWNVo3NGYwZkxs?=
 =?utf-8?B?OGVreTRUR3VmcXhzcGo3NmpNWTNyR3g2bGk5ejljaVJYUlVjeEFXdzJYc2Qy?=
 =?utf-8?B?NHdoOUQvaS9rbGxtbDkrdlhEN05mT29NM2xTUVdyeE5DZXg3Z1JzVUlyN1BC?=
 =?utf-8?B?Z0hCcC9rTXJXSXNuaWRlUmdSWE1pYVpya3JxcXZDbjBDaWptY281YmVxQlRj?=
 =?utf-8?B?VjRVWGNlRW9aempGR2lEQU9NTk1VUnA5NkEwa3AzZCtQRWZ3dFNYNWZtUWpa?=
 =?utf-8?B?bEtGMm5uNkF5SGg0SzRJdmt6cjRCbUVPejlLN0wwTkcwbEp5bnRHMkRKOHh1?=
 =?utf-8?B?QndVZE1kbUppUldUaHd1QTNzN1JBR0dDKzZ1TDFnL2U1Wk9rRm5OTVh0QXZU?=
 =?utf-8?B?MTM0WEs1QW01emJ3em9GVHhGaFpTTnNhTzgwNTFKaDRRTFZWR2dyY1crZUZx?=
 =?utf-8?B?QmNuRW5mckxrcnRkMnVNNStZTlMvZ3lKUFB2L0VMbStwTnQxNnUyRk14NFRD?=
 =?utf-8?B?UThwUEhOZ3J3a0h6T3F0bkhCYzgxUmlBWTdmcTdFSm5raFV0NlFzbVM1clNZ?=
 =?utf-8?B?Q0RES0trVlpha1VIcHhlMlNvNVMzQThrZ29ldzRMOFpHL0R5WldoYUNSNkhm?=
 =?utf-8?Q?IpS6DkCn7DY0sN4rpO5lsYU4nt+SjSRAK48AR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5c03b5-7d0d-478d-3eed-08da1e40bf50
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 18:01:06.4199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hpO4EMUXFJ+zi9BLfjKS54vviX8CRU/mPHjz+2gJTVsYlQG/LGat+U3JkZjKMuUixSdVMY51BvMWAk8ESGYYWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5602
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-14_05:2022-04-14,2022-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204140095
X-Proofpoint-GUID: LJmQ0XI9uMhKocNzWf7I-1krnlKUmb4t
X-Proofpoint-ORIG-GUID: LJmQ0XI9uMhKocNzWf7I-1krnlKUmb4t
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 4/14/22 04:41, Arnd Bergmann wrote:
> On Wed, Apr 13, 2022 at 11:50 PM Libo Chen <libo.chen@oracle.com> wrote:
>> On 4/13/22 13:52, Arnd Bergmann wrote:
>>>>> Yes, it is. I don't know that the problem is...
>>>> Masahiro explained that CPUMASK_OFFSTACK can only be configured by
>>>> options not users if DEBUG_PER_CPU_MASK is not enabled. This doesn't
>>>> seem to be what we want.
>>> I think the correct way to do it is to follow x86 and powerpc, and tying
>>> CPUMASK_OFFSTACK to "large" values of CONFIG_NR_CPUS.
>>> For smaller values of NR_CPUS, the onstack masks are obviously
>>> cheaper, we just need to decide what the cut-off point is.
>> I agree. It appears enabling CPUMASK_OFFSTACK breaks kernel builds on
>> some architectures such as parisc and nios2 as reported by kernel test
>> robot. Maybe it makes sense to use DEBUG_PER_CPU_MAPS as some kind of
>> guard on CPUMASK_OFFSTACK.
> NIOS2 does not support SMP builds at all, so it should never be possible to
> select CPUMASK_OFFSTACK there. We may want to guard
> DEBUG_PER_CPU_MAPS by adding a 'depends on SMP' in order to
> prevent it from getting selected.
>
> For PARISC, the largest configuration is 32-way SMP, so CPUMASK_OFFSTACK
> is clearly pointless there as well, even though it should technically
> be possible
> to support. What is the build error on parisc?
Similar to NIOS2, A bunch of undefined references to *_cpumask_var() 
calls.  It seems that PARISC doesn't support the cpumask offstack API at all

>>> In x86, the onstack masks can be selected for normal SMP builds with
>>> up to 512 CPUs, while CONFIG_MAXSMP=y raises the limit to 8192
>>> CPUs while selecting CPUMASK_OFFSTACK.
>>> PowerPC does it the other way round, selecting CPUMASK_OFFSTACK
>>> implicitly whenever NR_CPUS is set to 8192 or more.
>>>
>>> I think we can easily do the same as powerpc on arm64. With the
>> I am leaning more towards x86's way because even NR_CPUS=160 is too
>> expensive for 4-core arm64 VMs according to apachebench. I highly doubt
>> that there is a good cut-off point to make everybody happy (or not unhappy).
> It seems surprising that you would see any improvement for offstack masks
> when using NR_CPUS=160, that is just three 64-bit words worth of data, but
> it requires allocating the mask dynamically, which takes way more memory
> to initialize.
>
>>> ApacheBench test you cite in the patch description, what is the
>>> value of NR_CPUS at which you start seeing a noticeable
>>> benefit for offstack masks? Can you do the same test for
>>> NR_CPUS=1024 or 2048?
>> As mentioned above, a good cut-off point moves depends on the actual
>> number of CPUs. But yeah I can do the same test for 1024 or even smaller
>> NR_CPUs values on the same 64-core arm64 VM setup.
> If you see an improvement for small NR_CPUS values using offstack masks,
> it's possible that the actual difference is something completely
> different and we
> can just make the on-stack case faster, possibly the cause is something about
> cacheline alignment or inlining decisions using your specific kernel config.
>
> Are you able to compare the 'perf report' output between runs with either
> size to see where the extra time gets spent?
Okay yeah I will take some time to gather more data. It does appear that 
something else may also contribute to the performance difference.

Thanks
Libo
>          Arnd

