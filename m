Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015495AC412
	for <lists+linux-arch@lfdr.de>; Sun,  4 Sep 2022 13:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiIDLNW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 4 Sep 2022 07:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiIDLNV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 4 Sep 2022 07:13:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1E53AE59;
        Sun,  4 Sep 2022 04:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662289998; x=1693825998;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KBCZ2uzUynDmomK6Mt5ZZInD/zML7Fbjn1mbCcXAIeQ=;
  b=sFAOpJC0R475iwNN6n1Sj+EUMi0r+JxngMRCMtSgZRTTeMX4jDQQxWbO
   Sn3aXqXcP/DoNcKNJfTbRM9VDZxcthsk4jL6V7NabdrOqsGU2V36XOK95
   WjxpmSfyhc83pFCGPelWvByl4m2LWvG0lMDeqcuqg9vbzzzjL32ynIcoi
   CMcNF8gVJVHdZyRjkxwOGin3qvBcEFc9appZ8JVx3Cwn+yATUqn4LhQSU
   rpJl1ECfhhLFDUs8Lx/tAiajXGdfUrBRBj1LouHT0lAubCaWRlc6bVFzW
   7r1hfFWTrdn/jRhrhI7MrGaBpKksyXV0Zug0bHpjJYgE4aSJm3dKlRJrX
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,289,1654585200"; 
   d="scan'208";a="189345834"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Sep 2022 04:13:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sun, 4 Sep 2022 04:13:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Sun, 4 Sep 2022 04:13:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3025c1YmlZUfCubHIR9AOgm8WPWKKyYJiivd3uKS8bBdwneZDPwLeuI/9AEwmh7AX8+K13wFUbdsPd9+U7rIr99fXmkPLJ+8qe26wGepvOfuRgs3GV3vaOTnD65nLxsPwZLq0Sa0AB48KeLUNViCqTeIhJVt4T2OM+vdfckhWgCHzirNS8mQJ9sP5buVGoJwWTp+7A1nYZFeG9+57b758fdpMGJ+VHNdsAP3VIaf5QpgEXjwhOT/5H7eWIZZ2lL+CEVln0lroNxmElZANapn9rebBKuo0FBxBTVQECkBsA+i64KAORwkBCYLGgHZqJwMROkfWFPdLpiBP3CUeLV1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBCZ2uzUynDmomK6Mt5ZZInD/zML7Fbjn1mbCcXAIeQ=;
 b=eGz0R2Z03ynt2MjoY3q8T4aZKaz4LDnJv1vS9OVvwgJgpaJMKlVom/8ItjeDAs99uOvl6De9j924Ptp71e4/3f6LT+CWgv3WvbZlqljS/X5g0aQYXXQukaGCIwE6h33k/6qym7+w5NxX2f9FMR5faDix0ga4TKqBIHzdplSjTDvHxhnnEj2G1IiAdMPlNnM2a7CDTLtsxBdv6G00pErogE5woIryuMARuz4wrn0aHlMsDl7ZrsazBrkd2agDbgjY1TKa3Vhx5L46JD4qqmFVPrqZA0CJjmmtoNfm2Q6kjKfyzVOe8R2mMPPq4Tgg2VdjQ1JAi6IVYKHSmLGBeWH/2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBCZ2uzUynDmomK6Mt5ZZInD/zML7Fbjn1mbCcXAIeQ=;
 b=WbNV988KLVXKq5yUH3z6ikgrH98SlC8yCy4bUoNbFWZRrSMh/+kLF3wEtwi+0fRtswaoXfbWQSfZQ5c8tyjp+IUedhBcZuhIKNAsP41cU1pLDZ1jQjGin0Ipn4PXECWbQKQun5iidpcC7eVqbwE7q4pChM/8ir4q0WcaYobmuJg=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MN0PR11MB6229.namprd11.prod.outlook.com (2603:10b6:208:3c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Sun, 4 Sep
 2022 11:13:15 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5588.018; Sun, 4 Sep 2022
 11:13:15 +0000
From:   <Conor.Dooley@microchip.com>
To:     <guoren@kernel.org>, <Conor.Dooley@microchip.com>
CC:     <arnd@arndb.de>, <palmer@rivosinc.com>, <tglx@linutronix.de>,
        <peterz@infradead.org>, <luto@kernel.org>, <heiko@sntech.de>,
        <jszhang@kernel.org>, <lazyparser@gmail.com>, <falcon@tinylab.org>,
        <chenhuacai@kernel.org>, <apatel@ventanamicro.com>,
        <atishp@atishpatra.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <guoren@linux.alibaba.com>, <lkp@intel.com>
Subject: Re: [PATCH V2 5/6] riscv: elf_kexec: Fixup compile warning
Thread-Topic: [PATCH V2 5/6] riscv: elf_kexec: Fixup compile warning
Thread-Index: AQHYwC/gSov6LLzR/EOOdHeAB9nrWa3PFAuAgAAFpYCAAASWAA==
Date:   Sun, 4 Sep 2022 11:13:14 +0000
Message-ID: <8551463c-376c-8c64-6bf3-31dd5d9133d8@microchip.com>
References: <20220904072637.8619-1-guoren@kernel.org>
 <20220904072637.8619-6-guoren@kernel.org>
 <98efc4d8-f846-1ff1-2635-d18b7fca4ac8@microchip.com>
 <CAJF2gTQn0PpjERzKoBpx6npUs+gZmBNeRReNgeRP7RPod2WssA@mail.gmail.com>
In-Reply-To: <CAJF2gTQn0PpjERzKoBpx6npUs+gZmBNeRReNgeRP7RPod2WssA@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51d06006-648d-4580-bac4-08da8e667664
x-ms-traffictypediagnostic: MN0PR11MB6229:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7WC7pkV5o8E5X44uMMR7aoQH2OPe2nDsbUNcDNBPF/KmcyjkUUjKoSNMtWzK8ib5PVb2TSbkPAd39itvdckQYR3gB+98ZMK2hnNCTnwTbTQ0WEX5+EojVnH32ehgAdfgTOADcRv9DyPVCgSzf95Tg4WKHVBAAxC6e2Gvl86oCWakqpdzeQ0mFzNwfpVEYgEkQQLlpbWZ6BMA7dsRniD/cAiiN181zUFmeBEB8zUC0cEc8Ajixgq9BBBJ/jSx2mMufyrgWWmfumW+5sJVWtjVVtA0Kamp/iQv5ZaLgJgPY3kiERuBuXn15z25QNXOAi0klygFXsNhXfZIW7qs1wNtmDo8d8YB1V+8cBUzOqD19b8FdeX4SSgdHGPpWQGsit6B2d8tAVuqfevOPpv7tIWKVwHJNnnaZdzlQ+ietUKEOOw7Jor2RZNz03/TgjPqIuhDh14dGw+bIS3Ba4LqHumUlyImupD12Pu6VN4RoNPKTlknsmQ1QkhXXwWGzYEIA1fhIF42pVlgGla3/HMPgOROqsn8kkfPZFkDQdnfByJud8hzPCqlJ8iGk8mHD/AHerLtyC3iCSmg2tnMa4nyoprYkR6M9NqoUlcL3cgxqhNzmA4hjXqk1Gi6zkeHrms2r2e1VVxL8DVY5UzEai00Ewws/q+Jnfl0OTn8ox66Hg4ohf+yRuXy0aA7FUwYG4LV8vGGYpMrhWUYmwsgUvymlM8COBMp4atYByOkiyF3nkq2cN1+l7vJOZLQ3tgdrtvSA9klALeoWwDhlz/U+6X/C25xiVmi8eSMtzI2NKBdKNLV23L2hk+knl3Vw63E94vDKAE56aLqc57LgDqWpbb2eHYXMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(396003)(366004)(376002)(39850400004)(122000001)(2616005)(186003)(5660300002)(53546011)(6506007)(6512007)(26005)(38070700005)(31686004)(71200400001)(41300700001)(478600001)(6486002)(31696002)(36756003)(83380400001)(38100700002)(316002)(86362001)(54906003)(7416002)(8936002)(2906002)(64756008)(76116006)(66446008)(110136005)(66476007)(91956017)(66946007)(66556008)(4326008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L29BbmY4TGIrWG1Xb0tzRmYrdDdRM0VSL0R3ZUdINzg2Q01tSWFDTjVOeE5C?=
 =?utf-8?B?enB0TFZURlBnTXZKN0Z6ZTFhMFppQUJDcmhncUV5R3cyVDFLM0Q3MWRKN3Nm?=
 =?utf-8?B?RTd4ZFNGaUZScXM1d3lLeWlxNklYak9xcTNZeHJCc2U4b2w4SERvOTYxaTF1?=
 =?utf-8?B?MllLaEFya3J2VFQxVjNHcnVBckc1YkpKMG1RajZUK0hLZHkrQ1g2SGJLT2tl?=
 =?utf-8?B?WGc1S1V3VDEvdEJ6TnJrOEkvR0hWMXZXT2IrdktJYkwrclRtRS80ZGhJeXQv?=
 =?utf-8?B?cE1tSytwSmprT2hFTmxDVE1IK2xzT05oZThHLytvRzJHb1V5dFROU3MzaFlM?=
 =?utf-8?B?dnE5RmQ2OXFSTXRxTW9mV2RPVkV3THRWeTdKUVJ4dlF5ZXFkUXdyRDZnYjUz?=
 =?utf-8?B?N3c3SlVLa2hVUjVyd0psNlh2QTN2aDVra1h4clhkLzd4bEdnSXdJRFF1dktL?=
 =?utf-8?B?VWtZeVZWcUpqaVNFK09BdHczaTNwRnZoZU04YUZrRU4yRnV1SXhDcEtXZlVq?=
 =?utf-8?B?NUkwV2JOVUhjdysxT3FOd1h1WVNGOWE0bzNSWVV4VGxHN2lWSEZuOEJnWHhF?=
 =?utf-8?B?MEFNMUQ0K0srLzhnQWlYQ050TWhHQ1hzNUpVOWpZMitoYzhNTjFtRGgwUFhr?=
 =?utf-8?B?L3NlSE84cXJGRXdJMTRLcTJCTWt3RGRySUdYeUFnK3B4enprNkJyUFFITmJL?=
 =?utf-8?B?Q0EzWU9FeE84bWJtc01LTlY0NXQ4VXBVS241ejdBWUdMWVNySngwMlNGdHFk?=
 =?utf-8?B?MU9UZXpSTGFzeEdYMTlWL0pncGcvMXlpTzdFc1VjTWI5ZVhUd2NaaEtNUE1V?=
 =?utf-8?B?NUJVTUx5TnkwUU0ySWhxc2FZNEhEeHZJYzlscUFZZjdxYk5ua09oZUVoZXZn?=
 =?utf-8?B?eWR1V05JRFpIeDE3WElpVllueTIwMXZVOGdNTkc5Tk4xZmVJdzQ2aGZFT3Nn?=
 =?utf-8?B?U2w4NXFqMXpCV3RvbGtBOEJPczk5NlVESGNwU1dGSmxxZ0xVMzIyRHdodlEz?=
 =?utf-8?B?bEJ1QzA1TytHRHVCRWUwYjdrR21qUWFwamJXM3RVQ1NGaXZzL2xUUzhicmsx?=
 =?utf-8?B?TlJSelpNUGdXai9zaVhTQ2tqcjVzdTRkMmR5U21tOUdKS2xoVTd4UmJaZVd0?=
 =?utf-8?B?QmF0YjQvNU5oZWhhNDYvd0EydzRaeXZmeGc1TU56UHVlQ3dtYlVwa2h6Ujc1?=
 =?utf-8?B?dzhjSVUzMHlURVUrZTErZTBWMVNleGVLRnk3WW9BWEpjNFNEQjB5YnkrclJh?=
 =?utf-8?B?SkQyZWNsUWtEV0dMc3RHWlhIWjBpaGhzakNlcVFwMnAwQ09rNFh5Nng2Mm9M?=
 =?utf-8?B?MWR3ckpNa0ZsUnltMG1TR3hUaTZGMTNyR1pIdTNOVVYyaUNHc2JSYXBIemw0?=
 =?utf-8?B?cUhiZzNVVUlMME5hTHhDNzJRYVN5Zm10M1EwMjFqRktiQm5OdXVvYjBOTi8w?=
 =?utf-8?B?MHNPUklhNDRZWDkvMU1Hb09LbVptTE01UjlFNnlzaHBlb3hoajZNM2VSUndJ?=
 =?utf-8?B?K2VHa202bXVEbllGUDlVRENFeXRNa0haZGs4RVhJdmo2MXpQKy9GaVBYSW5P?=
 =?utf-8?B?ZXpmODhaalJVYW9HZW9NeklJZnZxaWRPKzRmc2pCQ0t5dGZseVkvYWpmeDVB?=
 =?utf-8?B?Tm0vZjZFTGo4YWlCcmRlRDJVMkltZzIyOHRYREJoRzBzd0NoeE5PVUI5T0ND?=
 =?utf-8?B?TUZwdnkydytMSnQ1QUtKQ2ZvSEtCZ3F4NHhmdVJ3K1VqTFBIT2lTemxzcHIw?=
 =?utf-8?B?aWd4NTVjRzNvZnFIdjZUekRoZDgxajlvWEgyZFhuaUJ1VjB6UUYvQ0ljR3hH?=
 =?utf-8?B?SWR2KzFTdXlmNHpHOE80RkQ3MmhRK2FQaFdsRDZCSjlmWTBaY0t0TmNxd1l5?=
 =?utf-8?B?VkZRNEZRdnNUejZSMzlVaENyNUErV042RldsOVNhOCtwK1NCM05CQnhDV2Jq?=
 =?utf-8?B?NnpYSzRJRnNIaGt0bW1FQ3A3NGZkVnVWRWJCTTVWclZqcEFNYWFOQlBCUFFr?=
 =?utf-8?B?dW9rNEIydHNHVnRLNEY5SkpwUGhrUVhCTzZIb1hlL2szb1NhODJYc3JWc3Rr?=
 =?utf-8?B?cFdUc2kxdnBSNW9lQnYva2RiWEZZWmZjQmVDR1ZWcVlXbG84ZjBIQ0hjQStU?=
 =?utf-8?Q?1buZ8oNA4ORoy6eW1sTDNbLpi?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D895136B1C75344388AFF83D06899612@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d06006-648d-4580-bac4-08da8e667664
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2022 11:13:14.9842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CXksz9Hon7B/Fe74Cz/Ond6ZzlVMiLTcoI/0DBcbrnLPUbVrcIaJmGUBrVp0EFwmp0ZS4m6ITLkGmOGoIydc7KhIy6fOsHNQhgyrc5gOUi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6229
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMDQvMDkvMjAyMiAxMTo1NiwgR3VvIFJlbiB3cm90ZToNCj4gT24gU3VuLCBTZXAgNCwgMjAy
MiBhdCA2OjM2IFBNIDxDb25vci5Eb29sZXlAbWljcm9jaGlwLmNvbT4gd3JvdGU6DQo+Pg0KPj4g
T24gMDQvMDkvMjAyMiAwODoyNiwgZ3VvcmVuQGtlcm5lbC5vcmcgd3JvdGU6DQo+Pj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+Pj4NCj4+PiBGcm9tOiBHdW8gUmVuIDxndW9y
ZW5AbGludXguYWxpYmFiYS5jb20+DQo+Pj4NCj4+PiBDT01QSUxFUl9JTlNUQUxMX1BBVEg9JEhP
TUUvMGRheSBDT01QSUxFUj1nY2MtMTIuMS4wIG1ha2UuY3Jvc3MgVz0xDQo+Pj4gTz1idWlsZF9k
aXIgQVJDSD1yaXNjdiBTSEVMTD0vYmluL2Jhc2ggYXJjaC9yaXNjdi8NCj4+Pg0KPj4+IC4uL2Fy
Y2gvcmlzY3Yva2VybmVsL2VsZl9rZXhlYy5jOiBJbiBmdW5jdGlvbiAnZWxmX2tleGVjX2xvYWQn
Og0KPj4+IC4uL2FyY2gvcmlzY3Yva2VybmVsL2VsZl9rZXhlYy5jOjE4NToyMzogd2FybmluZzog
dmFyaWFibGUNCj4+PiAna2VybmVsX3N0YXJ0JyBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1i
dXQtc2V0LXZhcmlhYmxlXQ0KPj4+ICAgMTg1IHwgICAgICAgICB1bnNpZ25lZCBsb25nIGtlcm5l
bF9zdGFydDsNCj4+PiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn4N
Cj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEd1byBSZW4gPGd1b3JlbkBsaW51eC5hbGliYWJhLmNv
bT4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBHdW8gUmVuIDxndW9yZW5Aa2VybmVsLm9yZz4NCj4+PiBS
ZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+Pg0KPj4gSXMg
dGhpcyB0aGVuIGENCj4+IEZpeGVzOiA4MzhiM2UyODQ4OGYgKCJSSVNDLVY6IExvYWQgcHVyZ2F0
b3J5IGluIGtleGVjX2ZpbGUiKQ0KPj4gPw0KPj4NCj4+IENvdWxkIHlvdSBhbHNvIGFkZCBzb21l
dGhpbmcgbGlrZToNCj4+ICJJZiBDT05GSUdfQ1JZVFBPIGlzIG5vdCBlbmFibGVkLCAuLi4uIiB0
byBleHBsYWluIHdoeSB0aGlzDQo+PiBtYXkgYmUgdW51c2VkPw0KPj4NCj4+PiAtLS0NCj4+PiAg
YXJjaC9yaXNjdi9rZXJuZWwvZWxmX2tleGVjLmMgfCA0ICsrKysNCj4+PiAgMSBmaWxlIGNoYW5n
ZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3Yva2Vy
bmVsL2VsZl9rZXhlYy5jIGIvYXJjaC9yaXNjdi9rZXJuZWwvZWxmX2tleGVjLmMNCj4+PiBpbmRl
eCAwY2I5NDk5MmMxNWIuLmJiYTM3MjNhMDkxNCAxMDA2NDQNCj4+PiAtLS0gYS9hcmNoL3Jpc2N2
L2tlcm5lbC9lbGZfa2V4ZWMuYw0KPj4+ICsrKyBiL2FyY2gvcmlzY3Yva2VybmVsL2VsZl9rZXhl
Yy5jDQo+Pj4gQEAgLTE4Miw3ICsxODIsOSBAQCBzdGF0aWMgdm9pZCAqZWxmX2tleGVjX2xvYWQo
c3RydWN0IGtpbWFnZSAqaW1hZ2UsIGNoYXIgKmtlcm5lbF9idWYsDQo+Pj4gICAgICAgICB1bnNp
Z25lZCBsb25nIG5ld19rZXJuZWxfcGJhc2UgPSAwVUw7DQo+Pj4gICAgICAgICB1bnNpZ25lZCBs
b25nIGluaXRyZF9wYmFzZSA9IDBVTDsNCj4+PiAgICAgICAgIHVuc2lnbmVkIGxvbmcgaGVhZGVy
c19zejsNCj4+PiArI2lmZGVmIENPTkZJR19BUkNIX0hBU19LRVhFQ19QVVJHQVRPUlkNCj4+PiAg
ICAgICAgIHVuc2lnbmVkIGxvbmcga2VybmVsX3N0YXJ0Ow0KPj4+ICsjZW5kaWYgLyogQ09ORklH
X0FSQ0hfSEFTX0tFWEVDX1BVUkdBVE9SWSAqLw0KPj4+ICAgICAgICAgdm9pZCAqZmR0LCAqaGVh
ZGVyczsNCj4+PiAgICAgICAgIHN0cnVjdCBlbGZoZHIgZWhkcjsNCj4+PiAgICAgICAgIHN0cnVj
dCBrZXhlY19idWYga2J1ZjsNCj4+PiBAQCAtMTk3LDcgKzE5OSw5IEBAIHN0YXRpYyB2b2lkICpl
bGZfa2V4ZWNfbG9hZChzdHJ1Y3Qga2ltYWdlICppbWFnZSwgY2hhciAqa2VybmVsX2J1ZiwNCj4+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZvbGRfa2VybmVsX3BiYXNlLCAmbmV3X2tl
cm5lbF9wYmFzZSk7DQo+Pj4gICAgICAgICBpZiAocmV0KQ0KPj4+ICAgICAgICAgICAgICAgICBn
b3RvIG91dDsNCj4+PiArI2lmZGVmIENPTkZJR19BUkNIX0hBU19LRVhFQ19QVVJHQVRPUlkNCj4+
PiAgICAgICAgIGtlcm5lbF9zdGFydCA9IGltYWdlLT5zdGFydDsNCj4+PiArI2VuZGlmIC8qIENP
TkZJR19BUkNIX0hBU19LRVhFQ19QVVJHQVRPUlkgKi8NCj4+DQo+PiBJbnN0ZWFkIG9mIGFkZGlu
ZyBtb3JlICNpZmRlZnMgdG8gdGhlIGZpbGUsIGNvdWxkIHdlIGluc3RlYWQganVzdCBkcm9wIHRo
ZQ0KPj4ga2VybmVsX3N0YXJ0IHZhcmlhYmxlPyBGb3IgdGhlIHNha2Ugb2YgY29tcGlsYXRpb24g
Y292ZXJhZ2UsIHdlIGNvdWxkIHRoZW4NCj4+IGFsc28gZG8gdGhlIGZvbGxvd2luZyAoYnVpbGQt
dGVzdGVkIG9ubHkpOg0KPiBFbS4uLiBJIHByZWZlcjoNCg0KVWgsIHRoYXQgd29ya3MgZm9yIG1l
LiBUaGUgYmVsb3cgZGlmZiBpczoNClJldmlld2VkLWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRv
b2xleUBtaWNyb2NoaXAuY29tPg0KDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9rZXJu
ZWwvZWxmX2tleGVjLmMgYi9hcmNoL3Jpc2N2L2tlcm5lbC9lbGZfa2V4ZWMuYw0KPiBpbmRleCAw
Y2I5NDk5MmMxNWIuLjRiOTI2NDM0MGI3OCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9yaXNjdi9rZXJu
ZWwvZWxmX2tleGVjLmMNCj4gKysrIGIvYXJjaC9yaXNjdi9rZXJuZWwvZWxmX2tleGVjLmMNCj4g
QEAgLTE5OCw3ICsxOTgsNyBAQCBzdGF0aWMgdm9pZCAqZWxmX2tleGVjX2xvYWQoc3RydWN0IGtp
bWFnZSAqaW1hZ2UsDQo+IGNoYXIgKmtlcm5lbF9idWYsDQo+ICAgICAgICAgaWYgKHJldCkNCj4g
ICAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiAgICAgICAgIGtlcm5lbF9zdGFydCA9IGltYWdl
LT5zdGFydDsNCj4gLSAgICAgICBwcl9ub3RpY2UoIlRoZSBlbnRyeSBwb2ludCBvZiBrZXJuZWwg
YXQgMHglbHhcbiIsIGltYWdlLT5zdGFydCk7DQo+ICsgICAgICAgcHJfbm90aWNlKCJUaGUgZW50
cnkgcG9pbnQgb2Yga2VybmVsIGF0IDB4JWx4XG4iLCBrZXJuZWxfc3RhcnQpOw0KPiANCj4gICAg
ICAgICAvKiBBZGQgdGhlIGtlcm5lbCBiaW5hcnkgdG8gdGhlIGltYWdlICovDQo+ICAgICAgICAg
cmV0ID0gcmlzY3Zfa2V4ZWNfZWxmX2xvYWQoaW1hZ2UsICZlaGRyLCAmZWxmX2luZm8sDQo+IA0K
PiANCj4+DQoNCkZlZWwgZnJlZSB0byBpbmNsdWRlIHRoaXMgcGF0Y2ggaW4geW91ciB2MyB0aGVu
Og0KPj4gLS0gPjggLS0NCj4+IEZyb206IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3Jv
Y2hpcC5jb20+DQo+PiBEYXRlOiBTdW4sIDQgU2VwIDIwMjIgMTE6Mjc6MDcgKzAxMDANCj4+IFN1
YmplY3Q6IFtQQVRDSF0gcmlzY3Y6IGVsZl9rZXhlYzogcmVwbGFjZSBpZmRlZiB3aXRoIElTX0VO
QUJMRUQoKQ0KPj4NCj4+IElTX0VOQUJMRUQoKSBnaXZlcyBiZXR0ZXIgY29tcGlsZSB0aW1lIGNv
dmVyYWdlIHRoYW4gI2lmZGVmLg0KPj4gUmVwbGFjZSB0aGUgaWZkZWYgQ09ORklHX0FSQ0hfSEFT
X0tFWEVDX1BVUkdBVE9SWSBpbiBlbGZfa2V4ZWNfbG9hZCgpDQo+PiBzaW5jZSBub25lIG9mIHRo
ZSBjb2RlIGl0IGd1YXJkcyB1c2VzIGEgc3ltYm9sIHRoYXQncyBtaXNzaW5nIGlmIGl0DQo+PiBp
cyBub3Qgc2V0Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9v
bGV5QG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+ICBhcmNoL3Jpc2N2L2tlcm5lbC9lbGZfa2V4
ZWMuYyB8IDI4ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0NCj4+ICAxIGZpbGUgY2hhbmdl
ZCwgMTQgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBh
L2FyY2gvcmlzY3Yva2VybmVsL2VsZl9rZXhlYy5jIGIvYXJjaC9yaXNjdi9rZXJuZWwvZWxmX2tl
eGVjLmMNCj4+IGluZGV4IDBjYjk0OTkyYzE1Yi4uMjljYmY2NTVjNDc0IDEwMDY0NA0KPj4gLS0t
IGEvYXJjaC9yaXNjdi9rZXJuZWwvZWxmX2tleGVjLmMNCj4+ICsrKyBiL2FyY2gvcmlzY3Yva2Vy
bmVsL2VsZl9rZXhlYy5jDQo+PiBAQCAtMjQ4LDIxICsyNDgsMjEgQEAgc3RhdGljIHZvaWQgKmVs
Zl9rZXhlY19sb2FkKHN0cnVjdCBraW1hZ2UgKmltYWdlLCBjaGFyICprZXJuZWxfYnVmLA0KPj4g
ICAgICAgICAgICAgICAgIGNtZGxpbmUgPSBtb2RpZmllZF9jbWRsaW5lOw0KPj4gICAgICAgICB9
DQo+Pg0KPj4gLSNpZmRlZiBDT05GSUdfQVJDSF9IQVNfS0VYRUNfUFVSR0FUT1JZDQo+PiAtICAg
ICAgIC8qIEFkZCBwdXJnYXRvcnkgdG8gdGhlIGltYWdlICovDQo+PiAtICAgICAgIGtidWYudG9w
X2Rvd24gPSB0cnVlOw0KPj4gLSAgICAgICBrYnVmLm1lbSA9IEtFWEVDX0JVRl9NRU1fVU5LTk9X
TjsNCj4+IC0gICAgICAgcmV0ID0ga2V4ZWNfbG9hZF9wdXJnYXRvcnkoaW1hZ2UsICZrYnVmKTsN
Cj4+IC0gICAgICAgaWYgKHJldCkgew0KPj4gLSAgICAgICAgICAgICAgIHByX2VycigiRXJyb3Ig
bG9hZGluZyBwdXJnYXRvcnkgcmV0PSVkXG4iLCByZXQpOw0KPj4gLSAgICAgICAgICAgICAgIGdv
dG8gb3V0Ow0KPj4gKyAgICAgICBpZiAoSVNfRU5BQkxFRChDT05GSUdfQVJDSF9IQVNfS0VYRUNf
UFVSR0FUT1JZKSkgew0KPj4gKyAgICAgICAgICAgICAgIC8qIEFkZCBwdXJnYXRvcnkgdG8gdGhl
IGltYWdlICovDQo+PiArICAgICAgICAgICAgICAga2J1Zi50b3BfZG93biA9IHRydWU7DQo+PiAr
ICAgICAgICAgICAgICAga2J1Zi5tZW0gPSBLRVhFQ19CVUZfTUVNX1VOS05PV047DQo+PiArICAg
ICAgICAgICAgICAgcmV0ID0ga2V4ZWNfbG9hZF9wdXJnYXRvcnkoaW1hZ2UsICZrYnVmKTsNCj4+
ICsgICAgICAgICAgICAgICBpZiAocmV0KSB7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICBw
cl9lcnIoIkVycm9yIGxvYWRpbmcgcHVyZ2F0b3J5IHJldD0lZFxuIiwgcmV0KTsNCj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPj4gKyAgICAgICAgICAgICAgIH0NCj4+ICsg
ICAgICAgICAgICAgICByZXQgPSBrZXhlY19wdXJnYXRvcnlfZ2V0X3NldF9zeW1ib2woaW1hZ2Us
ICJyaXNjdl9rZXJuZWxfZW50cnkiLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAma2VybmVsX3N0YXJ0LA0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplb2Yoa2VybmVsX3N0YXJ0
KSwgMCk7DQo+PiArICAgICAgICAgICAgICAgaWYgKHJldCkNCj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgIHByX2VycigiRXJyb3IgdXBkYXRlIHB1cmdhdG9yeSByZXQ9JWRcbiIsIHJldCk7DQo+
PiAgICAgICAgIH0NCj4+IC0gICAgICAgcmV0ID0ga2V4ZWNfcHVyZ2F0b3J5X2dldF9zZXRfc3lt
Ym9sKGltYWdlLCAicmlzY3Zfa2VybmVsX2VudHJ5IiwNCj4+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICZrZXJuZWxfc3RhcnQsDQo+PiAtICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplb2Yoa2VybmVsX3N0YXJ0KSwgMCk7
DQo+PiAtICAgICAgIGlmIChyZXQpDQo+PiAtICAgICAgICAgICAgICAgcHJfZXJyKCJFcnJvciB1
cGRhdGUgcHVyZ2F0b3J5IHJldD0lZFxuIiwgcmV0KTsNCj4+IC0jZW5kaWYgLyogQ09ORklHX0FS
Q0hfSEFTX0tFWEVDX1BVUkdBVE9SWSAqLw0KPj4NCj4+ICAgICAgICAgLyogQWRkIHRoZSBpbml0
cmQgdG8gdGhlIGltYWdlICovDQo+PiAgICAgICAgIGlmIChpbml0cmQgIT0gTlVMTCkgew0KPj4g
LS0NCj4+IDIuMzcuMQ0KPj4NCj4gDQo+IA0K
