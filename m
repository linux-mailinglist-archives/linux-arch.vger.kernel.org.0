Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148E65AAC44
	for <lists+linux-arch@lfdr.de>; Fri,  2 Sep 2022 12:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbiIBKVa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Sep 2022 06:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235739AbiIBKVZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Sep 2022 06:21:25 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120085.outbound.protection.outlook.com [40.107.12.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAA2A00CB;
        Fri,  2 Sep 2022 03:21:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwmrrBWbgbAvnbM9CnKyAlG827u8ddoecZEiMAPqgw95skKpirWdMASFknufSkJM3fjJ7nCskZrTDKR/67iLBJOM/oSbf413WTucjSYATMxozP2mPqusN8aMdwDJ2c/GwsUcwnM6Iw6++x49f2Ur2ytVPVt6VE5btyl6lkcWSX45jR/PeJtN6WKchzQ6lSP4vyv9w26k00FF7UJp7SspZWfEphrZQf0VqB5IBVYwE9aD30kUmlMeOLKErX5mHAfpZvhGYl1Ztrne4mPycNhGa9YRce4zAKCDX7ElrBR5shWWlHq1yLPQgu3ZHEyj9brskz1d5wVTlBix9G0EZs/TIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jL/+DqX1vRDWIUwtBAxzBhLB932C7aCjARzOckPjMJg=;
 b=hmekgHB678Cwi1HWXjEuW+mXuPtNl1dmedqH1cQftVzvxUDJTz3rLF4/bK/3zt+z24gaxSzkalWqdnuhCAT2K1LOF9IWIaG+okfihNAWjSI5n+aDHt2WfoIgRTmyYN9J+3mLM9MNnMJFbM6KbNGbaFfVXUoBkXd/pznBxd1vA0TzMelN4EL9QeUfIRMlbCbaUTL3UTyB9wxyIawDQ+/BNAJ7H3iwaq2GL9i8N6yfxP41uPuJcjDyOPcqwDrjUTsrsP1V1AiuQqTHpAAa7MGM0qivMc/Y2MJdQ180Hxif5q+z9Vg4VOsvP1xyCDV0BoSwCnVNsL+qH4FEzCJ7/z1UwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jL/+DqX1vRDWIUwtBAxzBhLB932C7aCjARzOckPjMJg=;
 b=U8D0WHap7cmbFD0VUB5pHYBtTisjl+D7kD/FcUzxN73BC83Og02rHGyju98IAjR0KqbE28nHVEuxSXCpQv0TdeazOrqNFm2wYSiz8Gc9q3yqafc7d488WgH5dAX0pWipLb3hUYM2mEdMZLVlXyrLJC3UDy16EY/Ct0QvLAbNLVTYgXlcGTOZ631ByPV02y91DwEQEFE7xkUeTeiA5THU43y4WrbtRPVinqwUxGvveF/EruQRbG+FH+9ij29bmdY9SDHNRTRKScSaXrNnRviazFZAPdcGNLYTlhyaUWPAuizJDk1tgMOxsCVeWiX9HIXM4czWlyvdJomIlHtS4DZ86Q==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB1899.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:16b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Fri, 2 Sep
 2022 10:21:21 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8%4]) with mapi id 15.20.5588.014; Fri, 2 Sep 2022
 10:21:21 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Keerthy <j-keerthy@ti.com>, Russell King <linux@armlinux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Subject: Re: [PATCH v1 4/8] gpiolib: Get rid of ARCH_NR_GPIOS
Thread-Topic: [PATCH v1 4/8] gpiolib: Get rid of ARCH_NR_GPIOS
Thread-Index: AQHYu8Kiku3lQE6A5kqVB459VJPNJK3H48wAgACfbICAAP00AIACc4qA
Date:   Fri, 2 Sep 2022 10:21:21 +0000
Message-ID: <b11eed9d-719d-cdf3-0efd-3d44425b9372@csgroup.eu>
References: <cover.1661789204.git.christophe.leroy@csgroup.eu>
 <abb46a587b76d379ad32d53817d837d8a5fea8bd.1661789204.git.christophe.leroy@csgroup.eu>
 <CAHp75VcngRihpfUkeKs-g+TbPnpOsZ+-Q37zDVoWp8p_2GbSvQ@mail.gmail.com>
 <18cda49e-84f0-a806-566a-6e77705e98b3@csgroup.eu>
 <1d548a19-feec-42b9-944d-890d6dde2fb8@www.fastmail.com>
In-Reply-To: <1d548a19-feec-42b9-944d-890d6dde2fb8@www.fastmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6aa81194-a3f7-42cc-7a39-08da8ccce182
x-ms-traffictypediagnostic: PR0P264MB1899:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6WBwOaaIIqVNtp4xW6mJ+eE9T8JcdJf5SqwiHkh/wz5LDxAbHUtXVZ5WOeiXPN/rqjILAE1/BMNR1EuYEdhcE/IunzvLy916Ku48ZAM/304o8LBa6zKTo4/1AU7XMgduRdS9ty58fVNjUKWTJBkOI1NoTJ/kaB1YKyzFs93RG2Sd5Tabhzdz1XC3ynSguQ7uVX5jVfVTVaLaBsmu4RZ1ZR/lMksYC59aUdWIN/wb8YAnEVUWPtj9NnnwhWWyh3DMORPkySm1HnMiM3dBgL2zrwUXNswgQaSi6wloxB+Olp6OHDt1rUI4mlUkima2F7HrlID1pjARxs9JUWF24Zgmk2ssdTX0bbKd3YkuYIQL7oO0s4AebFaNrN2QUdi9LtGut6QrhFHi4ItCejCu4dmbm124gYSmgQmGiwMsvJDZ3zVKACAE7rhe9DKmQDnuiqdCwaCbcSqacPDtCmnxEK5gC5x9opSrNaaoCnLOen+vuTOPWuuv3cWeytLqVnZh1x6gqawwiZglBgQ/DiEgZjKmDGkGN11cNLoifqX4Bwq4xu42VFopVqYDKnNTEjzy3aBS1kIYMX3P0RGEiSVs/RM+JMTsQmaHBNlZiEbuqbOh71qcfVtx0yj6iex5zMDp+Tov2XWuTOW/SjmJ4VFc1sCjTjkXO84NzMz0mxkoO8TIzl36c5/JrJaAhnySzNnjH/q6H3mPum3wKLzrHTO1YqRgAUyEpKJK+Qe53JvRQG41FN8kNJimulwBd+MFaJ0edJ7kDqjuNbkrfVgjV/7b7U/I9y7CaXarTnW1W61zRUDyg0HQC/viM27UhhrLJrJoQy8O56QkEHGe+Nxznbt+sbuypnZuGOu2bvQDkrM1RNz3DLA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(136003)(376002)(346002)(366004)(396003)(66574015)(6512007)(6506007)(26005)(53546011)(186003)(2616005)(44832011)(7416002)(8936002)(5660300002)(71200400001)(86362001)(31696002)(36756003)(31686004)(6486002)(478600001)(41300700001)(38070700005)(83380400001)(64756008)(110136005)(66946007)(8676002)(76116006)(66476007)(66556008)(66446008)(2906002)(4326008)(54906003)(316002)(91956017)(38100700002)(122000001)(26583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWNwa25iWDNsSDdZN1crbWxBYlBGWUxISE82MGRlRjVSYks4ZWgvN3J4SXBS?=
 =?utf-8?B?aWFGTy9NTWp6aVBnNmNEV2dxTXBTVHFOUVg1cXBaQzBFSmxVR29PVGhyaDZD?=
 =?utf-8?B?eGthK0lobmxyR2ZrVkI4akZ5WVNrWHhhS25KMzdJSzQvUHEvcEZlaU5ISmMw?=
 =?utf-8?B?NEVSK2I2S0NDZ3E0RGFLcmtXYXZUM2xscGlrRlcyaHRDU3RsdTRjR2ZYS0dV?=
 =?utf-8?B?Y2o3VkxHdW4zcDVtM0pqcllWU3MyMGZVMkdDUVZ6a2pKWUdjN0szdmRMNXE4?=
 =?utf-8?B?MnltYnFxUi8zSGxsRzdJTklXSnp3TjJKeTNaWUhLS1B0V2lmT2FFQkZXNGxF?=
 =?utf-8?B?WVRBZ0Q4bGZUaFFXSTI2ankvc3EyY0JpZVkvcGtyYVdjVHgyUUZtRTlFS0JJ?=
 =?utf-8?B?RVYrZ2JucldyUW5qQ0hrRmdSK2tNNWoxbHB6M0RLTVZKY3ZjaTJxakdKRUwy?=
 =?utf-8?B?amVDdnVTNWRKVHNOUVp2empFalZGY0V6dXlPWTdZN3VVTFVUWENlRURCcXd0?=
 =?utf-8?B?Z0FZZ1pCYlhUN2pUS1lacU80YkxiajJzUHV6YjdaRHdlKzc3cHc2V1VaeG5Z?=
 =?utf-8?B?bkFXb0swWFhYRVVPVi9CL3pGeUNqSENWTzZnSmRrVjNBeGR6UE1Hd0w1S09n?=
 =?utf-8?B?NjNSM0ZFMWVxb3ZpTHZ0MkY2eHIxZFBDQXlGWTFkSC85dU4wNlVnejZ2UFRt?=
 =?utf-8?B?VjVtQ3YzVDRwbGpkeFUxUWpJQUpuajF0NXdIaXZMelU1Z2d3cWlTZ2NXRHhN?=
 =?utf-8?B?OTVHUHB1NFNvZDIyekdsdlhWL3phK1hxVCtBRHZVV3FvMHRBamwyWUlSQklQ?=
 =?utf-8?B?RkorL09iek5ubFkzU0RXU01nS1FWdmd5WURQY3g0QWZsU09yVC9PcEFBU3ZP?=
 =?utf-8?B?Rk1BZmU2bUR1cmRweFdpNC82RFNmZHl1WW45c3NVbEVXZEVGa25EelBSa0d2?=
 =?utf-8?B?TnhoOWpSaHM3MnNyV2hwVHp1bVJ4U2IzVlNHd1Q1Q1lmQTlmemlkM3c4R0xy?=
 =?utf-8?B?YjE1Vmd3ZWJCV1pwTDZDN1dJZ1l3TW9iSDNSRXpReDdUUk5pR0dCNENoUnJM?=
 =?utf-8?B?cWZZaldiMjlWOXlnb05QdXpBYk9UQWJhQ2RDNDRLYXdMdmFDcTZ6UGNtK0Rt?=
 =?utf-8?B?aXVodGNCZHJWM2pjL25Ickk5RWF0TU0wY05JOXpXTURzd29kY3FhZHVJQ1cz?=
 =?utf-8?B?ZVA5OEFUWjBGQmdqUjltemorZk90blRnYndSYWJqN3JranRiaVRjM3U4QUd3?=
 =?utf-8?B?a2pMZzBCdk81cytISjF1L2VRTU5PNlhnM3pTMHdkY2EvTnFISEdkSjJLZFpo?=
 =?utf-8?B?VE14ZTlQOVRvODAxNDN6L0NNengveWl0TXBBUUpaNWFiQXZ2U1h4cVh0Vjc1?=
 =?utf-8?B?VEN6aGF4NnJtczNXMkc5aFFyeDZ1YmxvbHhCZXUrMUtNeHZYRWZVVWorNS8z?=
 =?utf-8?B?QkRtdEhzVDNrY2liWGwyZnQxUUxSOC9NNnBkT3FBcmo2d3MyaUNNRkhtN3A0?=
 =?utf-8?B?UnplZVI5Z2VSeTdtZ2xpd3VGOGMyQzFFamdqWW9TSFJuS2Z4Szd6SlBkUVJm?=
 =?utf-8?B?Q1FRcUtpRUcyVGtkTEZQZnYxcnc4M3pDcDhwR0NydnZGV3d5RWpiaDZxcDdu?=
 =?utf-8?B?anBoL3VjQy9NV2VIR3N6aURRbVl0bXp5WHU0aUdPK1MrMjNhYWE2VjFoU3Mz?=
 =?utf-8?B?akg3UVVGc214ZVRjMk5ZV1k5THVVWDJtUWZCMXJSaFJIbG5JdzUrYnM3VmNp?=
 =?utf-8?B?T29SNUlRTXdLenFRcm5sWkNYYXlmb1NHeGl2MmhQWlpUcGE4ZmNIc09tQkNM?=
 =?utf-8?B?SlF6NXNxUGVvM1ZPa3ZVOGpvVVcra2hnbUZIN1JwQTVvdXdWbk00dERHUzVQ?=
 =?utf-8?B?bVp5Y0l5L3VJTjZKVEdTbitqYlFGQWtMQnJwR0h3MHVRM0VXK2FsZjdITHNW?=
 =?utf-8?B?WGR4K2lRNnA0RHczT2JxZnA0UVlSK2tiNmM3WVVBclF0YlU1K2EvcVZkZFNB?=
 =?utf-8?B?N0k0b1dvT0kxYVZpQjh1eU80OUlYYURkY21lVzAzQ1MyN2g3a0ZXQWNWMklx?=
 =?utf-8?B?NlovUmMzY3kwK0MwcGlDdkU3YVpCUHZ0c2dNTkFPQUFEZlpCLzFZTCtTUHJT?=
 =?utf-8?B?UlNYalEwZ1pvdTFITHhFd0VRQmJQSzkrQ1dHczh5aXYwaFlnelhudjlTaVd2?=
 =?utf-8?Q?QomdOub1lkntrKKV1F/jyfU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D62014AE73F2414C8CD0E9C0C474F2D4@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa81194-a3f7-42cc-7a39-08da8ccce182
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 10:21:21.0832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IUZv8LfKgIdmN3yq4NWkmW+rdrBDw7wyLeuaXdoSHgvlJXwIRywmo0i6pznoQS57k/tLXGnZXUiaa6M1GwswkLBX0kGoMhMSPcTMNcKOUC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB1899
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDMxLzA4LzIwMjIgw6AgMjI6NTUsIEFybmQgQmVyZ21hbm4gYSDDqWNyaXTCoDoNCj4g
T24gV2VkLCBBdWcgMzEsIDIwMjIsIGF0IDc6NDkgQU0sIENocmlzdG9waGUgTGVyb3kgd3JvdGU6
DQo+PiBMZSAzMC8wOC8yMDIyIMOgIDIyOjE4LCBBbmR5IFNoZXZjaGVua28gYSDDqWNyaXTCoDoN
Cj4+PiBPbiBNb24sIEF1ZyAyOSwgMjAyMiBhdCA3OjE5IFBNIENocmlzdG9waGUgTGVyb3kNCj4+
PiA8Y2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1PiB3cm90ZToNCj4+Pj4NCj4+Pj4gU2luY2Ug
Y29tbWl0IDE0ZTg1YzBlNjlkNSAoImdwaW86IHJlbW92ZSBncGlvX2Rlc2NzIGdsb2JhbCBhcnJh
eSIpDQo+Pj4+IHRoZXJlIGlzIG5vIGxpbWl0YXRpb24gb24gdGhlIG51bWJlciBvZiBHUElPcyB0
aGF0IGNhbiBiZSBhbGxvY2F0ZWQNCj4+Pj4gaW4gdGhlIHN5c3RlbSBzaW5jZSB0aGUgYWxsb2Nh
dGlvbiBpcyBmdWxseSBkeW5hbWljLg0KPj4+Pg0KPj4+PiBBUkNIX05SX0dQSU9TIGlzIHRvZGF5
IG9ubHkgdXNlZCBpbiBvcmRlciB0byBwcm92aWRlIGRvd253YXJkcw0KPj4+PiBncGlvYmFzZSBh
bGxvY2F0aW9uIGZyb20gdGhhdCB2YWx1ZSwgd2hpbGUgc3RhdGljIGFsbG9jYXRpb24gaXMNCj4+
Pj4gcGVyZm9ybWVkIHVwd2FyZHMgZnJvbSAwLiBIb3dldmVyIHRoYXQgaGFzIHRoZSBkaXNhZHZh
bnRhZ2Ugb2YNCj4+Pj4gbGltaXRpbmcgdGhlIG51bWJlciBvZiBHUElPcyB0aGF0IGNhbiBiZSBy
ZWdpc3RlcmVkIGluIHRoZSBzeXN0ZW0uDQo+Pj4+DQo+Pj4+IFRvIG92ZXJjb21lIHRoaXMgbGlt
aXRhdGlvbiB3aXRob3V0IHJlcXVpcmluZyBlYWNoIGFuZCBldmVyeQ0KPj4+PiBwbGF0Zm9ybSB0
byBwcm92aWRlIGl0cyAnYmVzdC1ndWVzcycgbWF4aW11bSBudW1iZXIsIHJld29yayB0aGUNCj4+
Pj4gYWxsb2NhdGlvbiB0byBhbGxvY2F0ZSB1cHdhcmRzLCBhbGxvd2luZyBhcHByb3ggMiBtaWxs
aW9ucyBvZg0KPj4+PiBHUElPcy4NCj4+Pj4NCj4+Pj4gSW4gb3JkZXIgdG8gc3RpbGwgYWxsb3cg
c3RhdGljIGFsbG9jYXRpb24gZm9yIGxlZ2FjeSBkcml2ZXJzLCBkZWZpbmUNCj4+Pj4gR1BJT19E
WU5BTUlDX0JBU0Ugd2l0aCB0aGUgdmFsdWUgMjU2IGFzIHRoZSBzdGFydCBmb3IgZHluYW1pYw0K
Pj4+PiBhbGxvY2F0aW9uLg0KPj4+DQo+Pj4gTm90IHN1cmUgYWJvdXQgMjU2LCBidXQgSSB1bmRl
cnN0YW5kIHRoYXQgdGhpcyBjYW4gb25seSBiZSB0aGUgYmVzdCBndWVzcy4NCj4+Pg0KPj4NCj4+
IFdlbGwsIGl0J3MgYWxyZWFkeSBqdXN0IGEgcHJlY2F1dGlvbi4gTGludXMgVydzIGV4cGVjdGF0
aW9uIGlzIHRoYXQNCj4+IHN0YXRpYyBvbmVzIGFyZSBhbGxvY2F0ZWQgYXQgZmlyc3QsIHRoZXkg
c2hvdWxkIGFscmVhZHkgYmUgYWxsb2NhdGVkDQo+PiB3aGVuIHdlIHN0YXJ0IGRvaW5nIGR5bmFt
aWMgYWxsb2NhdGlvbnMgc28gaGUgd2FzIGV2ZW4gdGhpbmtpbmcgdGhhdCB3ZQ0KPj4gY291bGQg
aGF2ZSBzdGFydGVkIGF0IDAgYWxyZWFkeS4NCj4+DQo+PiBCdXQgSSBjYW4gc3RhcnQgaGlnaGVy
IGlmIHlvdSB0aGluayBpdCBpcyBzYWZlciwgbWF5YmUgYXQgNTEyIHdoaWNoIGlzDQo+PiB0aGUg
ZGVmYXVsdCBBUkNIX05SX0dQSU9TIHRvZGF5Lg0KPiANCj4gRldJVywgSSB3ZW50IHRocm91Z2gg
dGhlIGRyaXZlcnMgdGhhdCBzZXQgdGhlIGJhc2UgdG8gYSB2YWx1ZSBvdGhlciB0aGFuDQo+IHpl
cm8gb3IgLTEsIHRvIHNlZSB3aGF0IHRoZXkgdXNlOg0KPiANCg0KPiBhcmNoL2FybS9tYWNoLXMz
Yy9ncGlvLXNhbXN1bmcuYzoJCQkuYmFzZQk9IFMzQzI0MTBfR1BNKDApLCAvLyAzODQNCg0KPiBh
cmNoL2FybS9tYWNoLXMzYy9tYWNoLWgxOTQwLmM6CS5iYXNlCQkJPSBIMTk0MF9MQVRDSF9HUElP
KDApLCAvLyAzODQgKyAyMg0KDQo+IGRyaXZlcnMvbWZkL2FzaWMzLmM6CWFzaWMtPmdwaW8uYmFz
ZSA9IHBkYXRhLT5ncGlvX2Jhc2U7IC8vIDMwMCArIDEwMA0KPiBkcml2ZXJzL21mZC9odGMtaTJj
cGxkLmM6CWdwaW9fY2hpcC0+YmFzZSAgICAgICAgICAgID0gcGxhdF9jaGlwX2RhdGEtPmdwaW9f
aW5fYmFzZTsgLy8gMTkyICsgMTYgKyA4KjgNCg0KDQpPaywgc28gMjU2IGlzIG5vdCBlbm91Z2gs
IGhhdmUgdG8gZ28gdG8gNTEyLg0KDQpDaHJpc3RvcGhl
