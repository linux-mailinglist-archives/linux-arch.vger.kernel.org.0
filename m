Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AD159B38C
	for <lists+linux-arch@lfdr.de>; Sun, 21 Aug 2022 13:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiHULos (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 21 Aug 2022 07:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiHULor (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 21 Aug 2022 07:44:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7067E186FB;
        Sun, 21 Aug 2022 04:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661082287; x=1692618287;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ptSmfmAjpOjmhk6urfUevRkoqWFR951N4zJqMo86Ifg=;
  b=Hm4lb8hBpxvq0AXQKxBA8TCy9oRoZ/TdENUfj5Fjlae/wAkjakKZuUDu
   26TC7KDWuibzNthBZQoKlRztuomqql23FWIQXWq/iUpaTbPmrhWiohdZq
   UqU00B1Fky1f9n1hUkGAXnv5M3OnSdLzTQ5r6fd90O6d8os2I4HdVxPpe
   pqd0N7ZW0hkYr4qpLgd0I3J68hLLME+qqwgb6VZhb1E0xoG7tjoTtdiFx
   VcnMJ2uRvja1tpBhsID1xOfBBor+lc+zAauChLf3xEIjuOgCt/WFM5pqj
   cF6OjcZPv6Fcs1rg4Ev8MV8CokwGt37S00za2fmynXRje1aQxMjunKxvF
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,252,1654585200"; 
   d="scan'208";a="170214560"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Aug 2022 04:44:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sun, 21 Aug 2022 04:44:44 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Sun, 21 Aug 2022 04:44:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mz5vt9ZgZx9nX4MW/Qp713Tio30MPtShGVMUAQBdDC1VNWKnl/xqRuxdj9/jglAyVtncWxspMrYbnZUErY0LbL9Of8JC6R112miPd48JKlylaFD0Ku6Z6W4NXELL1XKF+6jxMwu/t1JUREBcUFxGbqNnMD22grN5ni10fmOUQPsEHk5EWLv+tp9UK5uo73+FSBYGAQWvMJg4XKCAWwluMXVxH+esxgu4uFoNGXTEBRzAphGj3RasORKmdkWxoKcrW3uGBAMcvofYUGZGOpzKcU6C0Tyik7t4dvRfG9niCOqAz96su7mex5xxveXzeUTN5adCxSHMMcKoC4TR7cOf2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptSmfmAjpOjmhk6urfUevRkoqWFR951N4zJqMo86Ifg=;
 b=EojxIIx/DdgzU+ftbqvcXw4tcaO5KwXK7dwU4ppUDrDucUfdN4Tiac8RADphWLIuPVdoPiwNcYjmczHj09++XuhE2dqf+0/hpW4VTdVXpsrduzz5FZk5L5Dzp4dPrK7rTI9o0BaVxT1+RO/P33n/ui8vQprL+x5mgFb+hp/98KJ+LbFIjJM0il3Jm6jLt+SFj5cGgYPXYmPRBm56earUZbA6EUmhj0z4D0NQMfy29LJ9EoqpV8uKEYSmAOtZ4T/eb7Y+Y3JIAZvCVtFhJQocU1+tN5WL81ucOJj8x3aXPOY6tW6EVOS2dOOBBpMERw1+a37XPu89VX1YOXUaJsAvxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptSmfmAjpOjmhk6urfUevRkoqWFR951N4zJqMo86Ifg=;
 b=ZeH1EJMqkjGQrr6J4KmOIt7OgQztnz51IcYvo5sro8Hf6ELvUtbb4XXiWONFFjDLkEwloGMv9ZjyVklGi6Tdu/7kPOJfWbvNOEJN/HNEUPQYte/m5ZyKTLIewdOzi/ILUsp2SpJzDBmAMZQZUo2jZdJxjHzIVnLW5r/nSJAwOos=
Received: from MWHPR11MB2032.namprd11.prod.outlook.com (2603:10b6:300:2b::13)
 by BYAPR11MB2855.namprd11.prod.outlook.com (2603:10b6:a02:ca::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Sun, 21 Aug
 2022 11:44:42 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MWHPR11MB2032.namprd11.prod.outlook.com (2603:10b6:300:2b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Sun, 21 Aug
 2022 11:44:11 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5546.021; Sun, 21 Aug 2022
 11:44:10 +0000
From:   <Conor.Dooley@microchip.com>
To:     <mail@conchuod.ie>, <monstr@monstr.eu>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <hca@linux.ibm.com>,
        <gor@linux.ibm.com>, <agordeev@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
        <ysato@users.sourceforge.jp>, <dalias@libc.org>,
        <davem@davemloft.net>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>, <arnd@arndb.de>
CC:     <geert@linux-m68k.org>, <keescook@chromium.org>,
        <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>,
        <linux-sh@vger.kernel.org>, <sparclinux@vger.kernel.org>,
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 1/6] asm-generic: add a cpuinfo_ops definition in shared
 code
Thread-Topic: [PATCH 1/6] asm-generic: add a cpuinfo_ops definition in shared
 code
Thread-Index: AQHYtVJWYAEaPR6fJk6EFR/jA4qylK25PAGA
Date:   Sun, 21 Aug 2022 11:44:10 +0000
Message-ID: <6ec9945a-d749-2bed-edb5-837a3e3c95ed@microchip.com>
References: <20220821113512.2056409-1-mail@conchuod.ie>
 <20220821113512.2056409-2-mail@conchuod.ie>
In-Reply-To: <20220821113512.2056409-2-mail@conchuod.ie>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c18ca45-4c4a-4e2b-06c8-08da836a76af
x-ms-traffictypediagnostic: MWHPR11MB2032:EE_|BYAPR11MB2855:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: igO+dvf3XlJk/3UB6K684/LeNJGV9uj+3kM6lHQ4+i3zcdXUbRSZy6Fc2Y/caTL/wDrGgMeHbYvoH+zwBD/rFaL5+H1q//V0LH2QiHNuuRdUOgnp+7JboHa5PJaiqXBPLrjwxmnh5VqkhJEmQtm3sJUlw4ECRqs4zc3S8BrvgUFgMGp+veK1eDtiQZhYPUwWC0ZSE2ok8uoo8JcElyD+frF55GN08pV6k/pOMqZ5xC4N/iuSSAuwjyZwusb8zy2sb9KkovziFFmRPLpqmhf4KzvXHm3htbqoyjqbkcf+fgdJhQ2WNdjml73aP91ynfICM7QUbW2a2+iRw/1tpn2pyh/jOqFnRQEivY14FKMmr7qqzEG0cRbyTuhXo3VthZ18GmAJ0dhI3zcjq/o2T44GG8WPub0QoAQ5hr+yIbJnxWno8W8Ii3RJ6IldX/8Lcnrm5NvkMeTdK9Wp2hh5Z9kEH4nDbYCHD746K3g0aZ9udCWcfwWF93UZJ7GJRwy5N4L4OHDweI7u/gSvF77Qc9y7T4aP25ddnI5qNrhc2W0o2KtJbSTiLDjnyw1OxKINptF6i/hMtpfFjNLitijm0a2KkkcK9KuzWkZI5vxMKLnUUymSozv9D/OG0GaA5wxYkhr3bb6X+QzK1WK11sWxkDUxGcvwqiiINyiSP1Nq/LxprUKoZaoQz5TRhi4wOkhEroukXXf28uaRWhNmoLB4aklKs4BuAS/pv4OS0DPfSbcgLHS6SnInLM9v/NQVtuzUwB84OHWe9B6/AVpKCaZnX6+2aJb0ZwTERlesmA10yS8V31OJxyWtVJ9K9DeQyT+ckaX3+yxiZGlrk+617bxba353LeoOyUjtJXyBTdBPpDKZVePUvYAJPJPJpRNWAcHtj/0o
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB2032.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(376002)(346002)(396003)(39860400002)(2616005)(54906003)(110136005)(66476007)(36756003)(31686004)(64756008)(91956017)(66556008)(66446008)(6486002)(8676002)(66946007)(4326008)(76116006)(478600001)(71200400001)(7416002)(5660300002)(41300700001)(38070700005)(921005)(86362001)(8936002)(31696002)(316002)(53546011)(2906002)(6506007)(38100700002)(6512007)(26005)(122000001)(186003)(83380400001)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?am83VTlQYWZqUkR5NDAwZ0tRY21GV1hiSFQxSnoyc2pCQTdFcEdZNFpKa3Vr?=
 =?utf-8?B?MzJDKzVweStQQlE2WEZOVmtNTURYSGdMcU9tWnJ2RGtaekphZjVjYzBqRnhx?=
 =?utf-8?B?ZzNDR09SOGhKNlA5Yjl1ZkFmTzlGSUpna054R25EeEFiZDdmWkJBYlZrdzhC?=
 =?utf-8?B?Q0g2eUZpZytxSnFJdzYwbVoyM1o0RkJHZnpZMGVGRHNLelZzbGFCc0M3U2FE?=
 =?utf-8?B?VUMzOC8zUWJSQnF5bWNIOHE2Skh1ZWVvQ3hKamM4WHFWSWJ1VFlLZURicjJW?=
 =?utf-8?B?ZFNVVHVOODluNC8vd25wZXI1SFZTZE1pTjBrUmtLb2w4cWozalB3d2gzNkhj?=
 =?utf-8?B?S1JqSzdWemE2czBhM1g0MkpjTjZPNzcvTm01SjBBYmdVay8yN2E2THJ4M2s0?=
 =?utf-8?B?K2pTYU9vUnYxOFB0cCtEUjY5VFpsQzVreTh4bXRYLzEzUlFYOFROTDBpcUg2?=
 =?utf-8?B?Ti8yRVRFVG1yTlF2MmRLck9OV2g1ZzEwd21XZVpEQVJnbzFxakNrVzF4azRK?=
 =?utf-8?B?NE15OXhhdGdhYVo3WVNpL015RjQxREFadm9VVzh0RnFkSmV3TGpDeWtxZG8x?=
 =?utf-8?B?MTBhdXNVYUs0T3djZnNyQWs5ZU1KaEtHTUZETElsVnBBM3dmTkIxa3R5VXll?=
 =?utf-8?B?d2xuWjU4TXorYUNtR1laeHBHbzk1MDRIY0c4ZVVsL01HTHpqMVIyWkxteW1K?=
 =?utf-8?B?ZDBBUUwyR1M5SEY5OWdBQVFFdVd0b3lGT0dzSXNIUGhvMFJrMEl3c2g2bTJp?=
 =?utf-8?B?aVc0UmF3NDZSNFlhMDZyWGtnUTBvUGxJdC9zN2RxdkxBN3E1R2YvYU0vZUJ6?=
 =?utf-8?B?RlVEOGJtZmhHWkptNS84QkRzT1dmTFBqWjlyMWlWQzg1dWFzcVo3ZkZjQ1F6?=
 =?utf-8?B?UTRaWHVnbktnMnRSQWxNdW1OVmhPdDJOb3hkNnFkbkM0eFB5TUp6dVNBTzds?=
 =?utf-8?B?dGVrNkliZGJWWldsR0JsaTBXZzFFQW55dzVmaHZPUS9GWXJ1WDF5a3dYaDEx?=
 =?utf-8?B?TnpaQUNTNVRxSjBhRlY4QldKNHAwY0xTS1FTWVNJaWdBYmdPeTdhbXlIWGVn?=
 =?utf-8?B?ek9VTXVqTUgzT0FvdGtxZEh6NVNhZTlYeTFTL1c1dnMrU2RVZGsweTd6cHcv?=
 =?utf-8?B?c0hJTFU1cTN6Wnl0NTRTVjkwM3pvb3l2Z2dRZWg0L1gwNEpTMmtIYlBUTHQz?=
 =?utf-8?B?ZFZLOXo2bXdNd2xhNVlyWkRQTVQ0NXpJSDNXVFFEU2swQytTMEg3SEYvUkx6?=
 =?utf-8?B?VGlpRVNJbGR2Uy9la1MvR3E3QU1XaENHMzRhNEFsUDhCYVlXdWNuTjVVSmdu?=
 =?utf-8?B?a3pXcCtSSVgwamk4bUJkcEtLMlRzT0lFcStwOWZiTVRwUDJXNXNYekp4YVZx?=
 =?utf-8?B?UFc4NVBSZDkyaWpFa1lTMklpL285bi9peHZ6bVVocW9PeDhCaHNuMmcyWjFQ?=
 =?utf-8?B?QmQwSnkza0JMM0NiWHhua2U0djNOdmRTU0FJQjlNOFpaS1FxL3NuN3NDZGdR?=
 =?utf-8?B?cTFSYTVpTTdxOVpLTDFIdHZPVzF0NFpNSzlaMDFHZ0wzcUlhRVkzaGNGakw1?=
 =?utf-8?B?T0tOQzE4WElEUnZwVE43aE05VkRyRG1SeU9SVlQ3TG1Jd2tOSTBjekttcWpU?=
 =?utf-8?B?QUUvSlBZTlNRSHRvQ1JzUy9jejZqVXgvZThVanpMRkdZYkNBRmZGY2dueTFZ?=
 =?utf-8?B?bU5zdWlFblFRbjBaNTZwa1ozV0Z4UXpuaVhNMUpBcDNEMTIvVUhwNUUwd3hv?=
 =?utf-8?B?WnVCbmlEM0tTcDJMbldkUGJVMmhNT01UaTRuTGlXdHN3Q280ZldKQnFaQ1dS?=
 =?utf-8?B?WkRzblZ6d2dVUGdzYUM3RHJISUpONTkyOXZTQkhEY1RXUWE2NzQwVFMzQjAr?=
 =?utf-8?B?MXNlanZia3gxOHkyTWp5dGJ2aVoxZXRJSVdMSGx3TGhCRnVGMjJaSmgyeDE4?=
 =?utf-8?B?aTY4Q0JPMDJyWDU3NEpaL05QMy9QWjVmaGlQandBdWJTay9xTTExZVBudnNl?=
 =?utf-8?B?SC9saXp2QllDb0swY3prTThXSjZRZ3Nwc2RYbkVRai8yaFowOGp3czJmZHFl?=
 =?utf-8?B?Sk9MdE1WVVNZMEhpaHcySytyZ1ZReFJFdUpxRlVjcjBFb0dUdEkxemJqK3Jl?=
 =?utf-8?Q?TONs8Ph5X3RBmOF/IXBtRKt0g?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <98503B830589B74D947D2585A1E0BD0C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c18ca45-4c4a-4e2b-06c8-08da836a76af
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2022 11:44:10.6987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N/tCBZm8APrXK7ykxdbcRldCzMOvWGoEO1XyUDQzAeEC7QVQyduFW6nC12eQKQXShJG+iI9lhpnnYRu1M8B9xUJNNe0kTQwBT3+oPR6NdIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2855
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMjEvMDgvMjAyMiAxMjozNSwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gYXNtLWdlbmVyaWM6IGFkZCBhIGNwdWluZm9fb3BzIGRl
ZmluaXRpb24gaW4gc2hhcmVkIGNvZGUNCg0KTWVoLCBiYWQgc3ViamVjdC4uDQpPYnZpb3VzbHkg
bm90IGdvaW5nIHRvIHJlc3BpbiByaWdodCBhd2F5IGZvciB0aGF0Lg0KDQo+IA0KPiBGcm9tOiBD
b25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPiANCj4gT24gUklTQy1W
IHNwYXJzZSBjb21wbGFpbnMgdGhhdDoNCj4gYXJjaC9yaXNjdi9rZXJuZWwvY3B1LmM6MjA0OjI5
OiB3YXJuaW5nOiBzeW1ib2wgJ2NwdWluZm9fb3AnIHdhcyBub3QgZGVjbGFyZWQuIFNob3VsZCBp
dCBiZSBzdGF0aWM/DQo+IA0KPiBTdXJlLCBpdCBjb3VsZCBiZSBkdW1wZWQgaW50byBhc20vcHJv
Y2Vzc29yLmggbGlrZSBvdGhlciBhcmNocyBoYXZlDQo+IGRvbmUsIGJ1dCBwdXR0aW5nIGl0IGlu
IGFuIGFzbS1nZW5lcmljIGhlYWRlciBzZWVtcyB0byBiZSBhIHNhbmVyDQo+IHN0cmF0ZWd5Lg0K
PiANCj4gRml4ZXM6IDc2ZDJhMDQ5M2ExNyAoIlJJU0MtVjogSW5pdCBhbmQgSGFsdCBDb2RlIikN
Cj4gU2lnbmVkLW9mZi1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNv
bT4NCj4gLS0tDQo+ICBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3Byb2Nlc3Nvci5oIHwgMSArDQo+
ICBpbmNsdWRlL2FzbS1nZW5lcmljL3Byb2Nlc3Nvci5oICAgIHwgNyArKysrKysrDQo+ICAyIGZp
bGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1
ZGUvYXNtLWdlbmVyaWMvcHJvY2Vzc29yLmgNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2
L2luY2x1ZGUvYXNtL3Byb2Nlc3Nvci5oIGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9wcm9jZXNz
b3IuaA0KPiBpbmRleCAxOWVlZGQ0YWY0Y2QuLmRkMmM5YTM4MjE5MiAxMDA2NDQNCj4gLS0tIGEv
YXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9wcm9jZXNzb3IuaA0KPiArKysgYi9hcmNoL3Jpc2N2L2lu
Y2x1ZGUvYXNtL3Byb2Nlc3Nvci5oDQo+IEBAIC05LDYgKzksNyBAQA0KPiAgI2luY2x1ZGUgPGxp
bnV4L2NvbnN0Lmg+DQo+IA0KPiAgI2luY2x1ZGUgPHZkc28vcHJvY2Vzc29yLmg+DQo+ICsjaW5j
bHVkZSA8YXNtLWdlbmVyaWMvcHJvY2Vzc29yLmg+DQo+IA0KPiAgI2luY2x1ZGUgPGFzbS9wdHJh
Y2UuaD4NCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2FzbS1nZW5lcmljL3Byb2Nlc3Nvci5o
IGIvaW5jbHVkZS9hc20tZ2VuZXJpYy9wcm9jZXNzb3IuaA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0
NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLjJlYzlhZjU2MmU5Yg0KPiAtLS0gL2Rldi9udWxsDQo+
ICsrKyBiL2luY2x1ZGUvYXNtLWdlbmVyaWMvcHJvY2Vzc29yLmgNCj4gQEAgLTAsMCArMSw3IEBA
DQo+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCAqLw0KPiArI2lmbmRlZiBf
X0FTTV9QUk9DRVNTT1JfSA0KPiArI2RlZmluZSBfX0FTTV9QUk9DRVNTT1JfSA0KPiArDQo+ICtl
eHRlcm4gY29uc3Qgc3RydWN0IHNlcV9vcGVyYXRpb25zIGNwdWluZm9fb3A7DQo+ICsNCj4gKyNl
bmRpZiAvKiBfX0FTTV9QUk9DRVNTT1JfSCAqLw0KPiAtLQ0KPiAyLjM3LjENCj4gDQoNCg==
