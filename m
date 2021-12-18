Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E652D479B0F
	for <lists+linux-arch@lfdr.de>; Sat, 18 Dec 2021 14:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhLRNjH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Dec 2021 08:39:07 -0500
Received: from mail-vi1eur05on2105.outbound.protection.outlook.com ([40.107.21.105]:25889
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229580AbhLRNjH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 18 Dec 2021 08:39:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1lVIY6asmvj5cMnOFctaMv4SOyB7er9xjKV/BndwxEfY7hTW/A8K3sgFHQGNEQ5QnQ/os3iYk9TU3Dig2KuHdxplUAtvJDIMHgQ07s9XMFUW8DwugPjNGWmVWCOLOvimb1veD/uuJQ+zn1Aa+DN3R5NB+ILCTDzhBlI7ZTuezpJpBfxqkC4LSksxlhtQfnghb/a2XO8UymlUFhlsUmxP25zlCjLWDRxaFSNdvxur+jbpd6Hc6CflE7mUa3CxQ/R6CryX30j3hxpOQHp7mSWf/jEDtYW2DM/ea2XalhX0sZDFmKmrAHkTs/0UbBmOQEXlZm49OIc98sCY2QQEMVVBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dz/dKKH3xho/NN9VVxdhDZBC/VLu1kaAe67EoD8P6k=;
 b=BIW8ztzOPb35qLl2loj0WAyjmx4QZsPPAOQjLULgDt8p1pn8NiZl0foywpOFGaWjo3QPPChw+QPkZLWXKZxNbGEAObfEB1YLPCBEMNmR8SqSD+7z4fKIa0az5uEjnWnK1L8ryKKedwrsO544ZNRe7qqXd0wPdr2we0XwlBp/xbBKaRih0e+rzVDcETxOu61AeYtpuGV66JfRlSIswgYUZBIDtgjq4zj3JfeckyZceTAFHFWKCHf8zzdquXxv+ja0izLzriN1rcii2ekzUwuJ53/co+WCldV9O9kn6N7lb/pJCR0+szlDNMWlmpcbhFJUXh+3QnULJaVoURAkrXuYIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dz/dKKH3xho/NN9VVxdhDZBC/VLu1kaAe67EoD8P6k=;
 b=hYpWLcoFzYRyO0+HgabJp17qGj/myO290HkisvBTnsAyqNIu1ucyfSQtEjcTS+5YgGY6sEwJgVRvk09UsMrQY0jEdl+qqNjKZ0P8+Ddj7vg63hokGz1D0Iv+BRBq4Xeh/nTh5OrxMjDChx3wSnuNNNIu6Ml5Ah3vac2tbBoXH5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB5630.eurprd08.prod.outlook.com (2603:10a6:800:1ae::7)
 by VI1PR0802MB2573.eurprd08.prod.outlook.com (2603:10a6:800:b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Sat, 18 Dec
 2021 13:39:03 +0000
Received: from VE1PR08MB5630.eurprd08.prod.outlook.com
 ([fe80::5807:e24c:a173:3b71]) by VE1PR08MB5630.eurprd08.prod.outlook.com
 ([fe80::5807:e24c:a173:3b71%4]) with mapi id 15.20.4801.017; Sat, 18 Dec 2021
 13:39:03 +0000
Subject: Re: [PATCH/RFC] mm: add and use batched version of
 __tlb_remove_table()
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        kernel@openvz.org
References: <20211217081909.596413-1-nikita.yushchenko@virtuozzo.com>
 <YbzZaFY+ht+bUtcz@ravnborg.org>
From:   Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Message-ID: <f955a1a8-eaac-0ab7-a48c-6237b3511312@virtuozzo.com>
Date:   Sat, 18 Dec 2021 16:38:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YbzZaFY+ht+bUtcz@ravnborg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P194CA0094.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:8f::35) To VE1PR08MB5630.eurprd08.prod.outlook.com
 (2603:10a6:800:1ae::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db7c3c49-8eb6-4bb3-1afb-08d9c22bc170
X-MS-TrafficTypeDiagnostic: VI1PR0802MB2573:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0802MB25735FD7D9E7A1475B86065AF4799@VI1PR0802MB2573.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0MBmv84COZQskTJfjqiT3nLWJCO0c6YTtghw7KxA0IHOO1kfgoNuV2N7Xl9+rZ4SlJD/KThJTm3OsEx+am8UKynAD9IVVbid+qjFBf4unuXy/atRQGpllEVBdvPvz5CM1+/7o8WtcmmAX+mpo7tNPsqZj85FcKA9Deef40gziWMddfUcLfLcPvR49YFikwGcjEgXEKwb/9OtsZLaTxrYZMTWvLYm767JmOFLGFl7hr1lEG5PlDs8q1gsa0ZVsecFgjY853jOF/7ikkN14WfO1E/Vvk0cvTxoxM7HhqnxjhsFKelMNuSjZ9SMbDvgbTFl+B80drh7AZuu5VkaVCsfN6n7cxj59wPRxrxJQFzJVZubEiiy004NItExzF/6yNVBU9DDu+zNLIb7NEWToIMGtfqCPDZk4x5ZzoddXXHqTZ3VnzCGkpzyrfmR5/p3jinkum0WZEmacyARD2qgs4dt95OKZJVMA0Q3xwAsVaVqA8JKAf+FvGbMgWWBL7RhFbVtvKT0gNGw7Tzh2IimMxdPEnNoSA/6n3SkqOO3ZylBBKNx8pd88G1HrLjYtLllHE1bwl1bbLx6LrCDyyEUV9pJ2xmfYPODgQK9kTgR/4zp8bVXoocrPdEfjucaxfuwZwBcF4P9AlHTs6EmYen6bfOeBaFX1s/i3g8CKpWlHBRsnKZZvNQ1iHwQ9Q+pswzSpPVeyPCm0symXATo1spjqo9nMgprKhFVkB9xbkltGzSfRts=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB5630.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(66476007)(107886003)(31686004)(186003)(4744005)(7416002)(6916009)(66556008)(8676002)(4326008)(6666004)(2906002)(6512007)(508600001)(36756003)(316002)(5660300002)(66946007)(2616005)(44832011)(6506007)(31696002)(38100700002)(54906003)(8936002)(86362001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWp5bDNhNzNqQ3I5SW03MFlmbWx6NmtmS0pDSkQ0SWovS09FcXBFWWQya0tn?=
 =?utf-8?B?NWxDWnU3NDVqOFJzcEtzVnlydzlEZ043dTFMcmxxNHRyV2dQajRkUFkvTDJ0?=
 =?utf-8?B?UGV5RjhUOWhwTlNKUXQzVTZWbFpGNm81QlIwb2R5NWRGbGc0SWJvNDk2TE0r?=
 =?utf-8?B?aisvcDM0SDVJSStEUUVpUjVLanI0aERXRW5JUWZqRi9PTHdzVTg0VU9FMjBX?=
 =?utf-8?B?UFdhbTR4ZmxQNUhHVnVLMUNRellseUpJWFB6VkRiYklLVHFvWG53YSs5WTlE?=
 =?utf-8?B?Q0x4ZFl4b09OMEVWQUdnT0hvOVA5K29BbEJMUGQ2d1NZdjIramdyWTdEUVJ3?=
 =?utf-8?B?K1UycEErZVFHU0J5S1kzU2hNMktZc0RtUS9Wa3kxTVRXT0RybUp4T0NOTGhi?=
 =?utf-8?B?RzI4bElYdC9hRFRRRnViZXoxREpldDdIa2puazJVMVpqdXNiNjZvSkdPd0ly?=
 =?utf-8?B?elRXK3h0L0hmR3YxTHhuQjdTcDdjOUZGUVNkNFVKeUU0c1U0WDRGTUVPVkZZ?=
 =?utf-8?B?UVU2TmhSSzgxUk5weE1TL3hFMVFsRTlHS3F4eXZkR0xHTXFiZWpabmpZZ3hV?=
 =?utf-8?B?OGlzMkgvRUdySTY1aEFobTdyWFdXdDA0S0JuODByc3JDTkQxTGh1cnM1a3Nl?=
 =?utf-8?B?eWx6K2hFV3lQRXVWZm8xSG9PeWNzYWU4WTh0VkJuUkNFRFhQTzlLcEtESnFG?=
 =?utf-8?B?dVVsU3FHLzBDV1lBTTA3eUJtcUtDL0ZlSVlZZi9ZZ1dNWmI0Ny9KdVNFdXJr?=
 =?utf-8?B?K3luQTlSbSsrVzlnZUtKUzJ2djJDRm5mM1RNTGFaUFdhRElQL3hNME9vd3p4?=
 =?utf-8?B?Y0NCbE9YR2FZa2l3NG5PZWZSY2p5R2V5VDVWNVkxVXg2bUxZTVR2OEVvZXV0?=
 =?utf-8?B?NTF1RVhiaDc0UUJXeUx6NHdpNDZqSVRWRHVUblh2NktXUEZEcGlyU2d0L2py?=
 =?utf-8?B?MU5jRVF1a0VadTdRcURyVDJudDRzbGFRZ29UZmJXWVVtRUp1UUtwMFJkWXFU?=
 =?utf-8?B?dGJhUzJ4TWJPQVh0N25KdVJhSmVtS3NRaUQyOHYxcVJFanVsNEpQU0lYSDZZ?=
 =?utf-8?B?SmtoQ0wzdmJrU2pyb1lSdzBzNzQvS3ZiWWZSZmp0K2xRMTFSd0F6ajhtUUVG?=
 =?utf-8?B?WGlDNlFwM3JQR1VVV1FGYTlaOTJSdnFpaEtJSVVjQWF4dVBmcTFhK2llVkgv?=
 =?utf-8?B?QmtwT21maXQwWGFReGlGUjFGblZ1V3hBcjJZMHpJKytrUFlKMklGNklMVEtZ?=
 =?utf-8?B?L1Z3R0ZyZ1E4cHBla2p5dEFhS3djTHpaQzcvS0x1S21yMUVzTWNzRXFoRWJD?=
 =?utf-8?B?dWhxUWNEck4zYWtPNmVXYlM0cm9PZ01SakIvbTM5WnFSVTFjblVZb0xPVjdL?=
 =?utf-8?B?ZzF1a1V5YlI3MG5uSVlaNktXNStoTEp5bHNQSDVmUlRzekhBUjcrOVBmTTVw?=
 =?utf-8?B?V2xJNEVYa3M1M0doRE5RUDArS3NHN1ZoYVhFcTU5NnhTTGxsNzNScGZ1V3JE?=
 =?utf-8?B?NGtNWFJIOWkvWlhuWnpzYStyc21sbWhsdGc4eVRIak53WFlvZ1hjTDQ5UEJp?=
 =?utf-8?B?dlcrZXhXNjkyb3lLTWxvVjNjUHU5N21Ed1dYeG92WjY0REhpVlR3a2VMR0Nm?=
 =?utf-8?B?T3Vnc3VRVVBpWGRUZE91c25hZU1DT1JlbDU3Q0JKd2YxcXlCU1lINFNSODJi?=
 =?utf-8?B?MWxuQmVwYnlSRUwxVjAxK0NlajA2bllYUzNkeURtWWJXY0x3SWlOWFZMcS82?=
 =?utf-8?B?UUJZd3k5VC9ta0oyZERSR1FYb1krNnB3MDYwaGJ1MWFOaXJDRllnMEkvaDVS?=
 =?utf-8?B?M1FEYmNQbUtEQ3Y4ZXNmTFB2YVdYaDhNRHZnekIzZkRBV1FzVUkycTNhUUhI?=
 =?utf-8?B?V2V5RnhPYS9xUFphano1VytHSXFSdWZzVGp3Q0UrWExtYWpKWTBlOW8vMFJh?=
 =?utf-8?B?TUliZU1penBkSmd6cXV0dDJzdGc2WmdFQm1SNk9QcWphcWpncVJDclRYM3dD?=
 =?utf-8?B?SGxJWHBHVDZ5VE53YTAxUTVxTlh6VHpPUndYYWtvaVkxUGM0bmVyQ0xxdVkx?=
 =?utf-8?B?M09JMTlTaHhTUjZzN2cvbVBlSU1iNkRWYUdQYTRyN1JNZUgxeXhlcU5NbFNL?=
 =?utf-8?B?MitMRWs4S1l1d1JWZXpSUGVYdWdPbkxqQkRlUWhYT2RJOUc1Yk1sMzh3UHVE?=
 =?utf-8?B?ZUZKZ0gxQXJ2SVZOdGVhb2Jwc3ovUHQvVDVaaGZxd2x0b2F0SjdFcTcwRW9a?=
 =?utf-8?B?Z2FoTGZvdkovL2hOU3ZWcS96Nk9RPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db7c3c49-8eb6-4bb3-1afb-08d9c22bc170
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB5630.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2021 13:39:03.6757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQkRBSv1MLpLzqTLy4SDb+LPVrLq6YWd26BWPiJ0/LQbpgz+IUWp0kOgg8TfABH53vuICG6QcVHbmfLeEckTI7ATuXHEHH7arme8W38UXp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2573
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

17.12.2021 21:39, Sam Ravnborg wrote:
> Hi Nikita,
> 
> How about adding the following to tlb.h:
> 
> #ifndef __tlb_remove_tables
> static void __tlb_remove_tables(...)
> {
> 	....
> }
> #endif
> 
> And then the few archs that want to override __tlb_remove_tables
> needs to do a
> #define __tlb_remove_tables __tlb_remove_tables

Hi Sam.

Thanks for you suggestion.

I think that what Peter suggested in the other reply is even better. I will follow that approach.

Nikita
