Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6262C49E996
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jan 2022 19:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiA0SEV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Jan 2022 13:04:21 -0500
Received: from mail-eopbgr90087.outbound.protection.outlook.com ([40.107.9.87]:65033
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231824AbiA0SEU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Jan 2022 13:04:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXNRrGia9aVjNuptmg+TUyvoP1AnxTtNTBg7A28j6hE76heTs2BTp4fmGXhVMut2VoAXtGcSIcJBpFtwHLjwi0X+zXaJvIY6xXkcHo3mNHyDG3fj2avmGmvTF1isjhq0R7yunrEHIMnVU8WD1J0F4AyqrKzpoeqJcfbABsqKazH8Q5M50hEiD8OUhWrERdED+Py6kNdq8kt3aHE9nyTWOsh0gCxJEcAGZm67ggwjkUptt0Yg4wG43WOfVS5oQvtyJUwuWMMhfI9lOVWZlyVBPEJxFvUMk2l97dvNxSJZN+FJEimt/e+E9+jZw79L5Bt9LelkL6S2Nt788qg/emR8Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTp+6sDi9kwsQNO0X49aiaZbxoYyiU074tkbDmHmIbs=;
 b=FMegFqJblKLK3COxtar+1gDMZk/gTS0SFoEGrzB7QUhnOQF006WW+Pd1QK5k18R95Yx6U4H43FbXyiWtrFcCtkNROWFoy0hJjVFUUtbCGCXkAbmHijL68ZCIdoK/Hl+QCJlgiWpVSIWKO0YMscOVrGNJzFS4jIAgYbtbqMW96MHpf5T0Zeye6sA1J5KXYnPwO+znMJHG2Q+OOozbGCsz2jK7P/TXOGNChv9EV+a09V36RdAK1RgkG59fzpAeSH2ecooqOQHI1OuJk4pr3YICkPMMhnRxEMiJULh9Sl2QlKdzXZrNP3pEwW/aH5YSITCfoOOuLeeRpnkzEBQ1v2uADQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAZP264MB2622.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 27 Jan
 2022 18:04:18 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1%6]) with mapi id 15.20.4930.018; Thu, 27 Jan 2022
 18:04:18 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Miroslav Benes <mbenes@suse.cz>
CC:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 6/7] modules: Add
 CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
Thread-Topic: [PATCH 6/7] modules: Add
 CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
Thread-Index: AQHYEQPri54wm9k2kUic7oR3m4zr7qx3DXOAgAAhHoA=
Date:   Thu, 27 Jan 2022 18:04:17 +0000
Message-ID: <134cde32-6bb1-a9e5-42fc-c4f0162c08e4@csgroup.eu>
References: <cover.1643015752.git.christophe.leroy@csgroup.eu>
 <848d857871f457f4df37e80fad468d615b237c24.1643015752.git.christophe.leroy@csgroup.eu>
 <alpine.LSU.2.21.2201271704470.26559@pobox.suse.cz>
In-Reply-To: <alpine.LSU.2.21.2201271704470.26559@pobox.suse.cz>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d0bca67-706a-41b5-ccd6-08d9e1bf6fd6
x-ms-traffictypediagnostic: PAZP264MB2622:EE_
x-microsoft-antispam-prvs: <PAZP264MB262213F0FA46E011EE5CFFBBED219@PAZP264MB2622.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:826;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TvyQ7Njyiv+62umqmf3FhR51Kn+7ZF3MmkSxIs0TFC+AlUFwFdBYu/KQLZoIuhKouwFrVD5zsxiGDoYcSPOvq6ttY0Bng9xVecZ8n1ofLBm0slFLibUHtzAsz/psnCIVUWYRaWKepOM25oX2dFDJpGYoOUnBh/v1pmccwT08WtRnb5X77tOWv6nRb6M0G0Q3+dbrCRsrtn2v6sVfEnT4nlMPmyT0bFqq+1aJCYsh+ZjfXPaKY+8W/A4rgGSR+RdBNuPoipZtGqW3xLhTOrdJYarefj6dAh1xosEkI3S33b+ylcSmHRhu747lDdaWbbqhX7oS4HQLN4K1JFoU6Du/gNHwT4N0ZkbeptWoixuAOYWet8I3S9hMyx/ksFtSLyjuHYdZjgVivn+9osnbvqUtdo2HvvgxyerVxBnxdq3pvVhata1KmN0DhyJ3FhKe1ehOXW9N8FrWhGTRHs4zMxOAk5RamE4oHpV+pi4J7xA9wG/aQ0wHJQS/nXwLPryG0dsKSbXO6X3o+kgj7JxInYo9/QL9ggQGF+1k5D4qSJRpt1/dKZd+7yLShqQj1K/B2O3nKe1pecXsHk6ArOzQJ/fj7B1wbQoHQHP1HqUYgNtsNEyh+GPFAWXk99YVJJwyaGVDNqTIxAABW3ZvqiiaDFHU/bUUPuUA/6JbCIDssc4Fu0hPqAzzGleiITM11QfFd7C7B+ohZA1HnkRBnRCWa+Hv7fwa7ZfLbv1U0EyB52gGldMXeYMMUgXIkKZqCMOqtJzBQMC3DsZnfNdGRp+5JCkGsA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(186003)(6916009)(508600001)(316002)(38070700005)(2616005)(5660300002)(8936002)(66556008)(66476007)(36756003)(44832011)(54906003)(4744005)(26005)(6486002)(2906002)(31686004)(71200400001)(86362001)(66446008)(38100700002)(122000001)(8676002)(64756008)(31696002)(6512007)(7416002)(66946007)(91956017)(76116006)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHNVRjJLWWphaGJhNkptZ0JDR2xsb3FqQUwwQnc5ZTFyRVFEbHBuN0lhSkN3?=
 =?utf-8?B?cW1XZ044UjlKZFdCV3lTa0lrQWdPUWFXMlAvekR4Ny9ySk1zc2Z5TmVtTTE0?=
 =?utf-8?B?bFVtWGl0YWRBNFJ4SkdWVm5rSytRaEFSYWIwRWRsTHh6Yjk1U1RSNTJEVjZr?=
 =?utf-8?B?alB6a1l6WkJVL0ZSeFBWVVpsWkp2SEowNVNjVDEvZ1NPWTN0dUJ4SDUwc05J?=
 =?utf-8?B?K0RJU2ROeXEvTGluaVA0VEduMGV5TjNya0pidU5hWFhZdjl1T3huOHg5VEM4?=
 =?utf-8?B?QW4vMUJuT0NQL2RjVHhYTHo5RDFwT3ozUXFSSEtZeSsyQWF1cjBObERTSUVp?=
 =?utf-8?B?NXczclBqUlpDYUd2cUk1blIxZVlQbnNxNkc2Q043S0xIemFCcENlZEt2NFVB?=
 =?utf-8?B?bXBpeHJLNmFXOFdJaHBCWE1KZ3pZRk9CRUJoMHBlZE4wSlNtMHIvTGUxai9p?=
 =?utf-8?B?Vm1SaDU1SjRkVndOc0hGVXNGQ3l6K3BDZVBkd05CdGFCUXhITDV4RzJpT2sx?=
 =?utf-8?B?RGxaRWhnTUtkd3VCNHFYK0NDOXU5bHlER2F5cVYzVDRxeXJ6TEJ5ZzBxWHBJ?=
 =?utf-8?B?MkhEd2liS0ZyRG5ZRlpOQ3JWWFdVKzNQSFkzOVpaSFRaNHBJNjAza093NDQr?=
 =?utf-8?B?ckpsSUViZUR5L3ExMEk0N1RWZFV0aHdOOThvQ1dKdEZtTmVoUTdjY3pzUjRh?=
 =?utf-8?B?VFpyWWIzNytwVUNkR3lSbFFpRy9mVzhodHR2c0JJRzIreGlsYnFsaTlVTXJH?=
 =?utf-8?B?eDFOeDB4ODRWOTgwK0VoT2doVkxNa2dNVzFZTGlaY3VHbFhGcnN4ZHFjS1JD?=
 =?utf-8?B?Z3E1ejRIUS8wamJjYzl0a0RnYlU0MitHMStCOE5BUm43V1l0cGk4MEF3SWM1?=
 =?utf-8?B?THN1RU1EQmRBTDAzcUNkbk80eGMrWjAzVGFOOXZqNEJqdzFkL2MrTnNnb2dG?=
 =?utf-8?B?OWtubXJvSzFTd3gvaGVRTGw2THNJK3d2VmJLYmdoNXB3S2E4TVJVUFBzcmtR?=
 =?utf-8?B?Y0VkTGFCT2pjNlJXT0djbUc3dGttSlhRbTl6UnZDeWpqWHh3ZTUxZHFWVVM4?=
 =?utf-8?B?NkR5ampsUWUzVWpEZWRTMmh2cHlEL0lZbkM0WGpGTGJpR2Y2Nkw5SkdrdWx1?=
 =?utf-8?B?Q3M2aDBESk55ZzNQZWIxL3ZVeHc4TjhrNHVWVllQTzFzMk1mMURsK3VpM3NL?=
 =?utf-8?B?ZTd1TTc5SGdMQjJqNm9Lb1B4b1lGcTZpTE1sZTBpTCtpYlhiOUZ3Z210eS9W?=
 =?utf-8?B?WDRxRG5uaXVQbkxZNFVQMUplSFA5dFhhemx1Qkg3S2tPQ0xTM0d0ZjNFdDNN?=
 =?utf-8?B?VTJLNDRrQ2I0amlubm9ZRTFFQ1QrejJ4aXgrZDdnMFpCMVh6QXpYWEUzTDRB?=
 =?utf-8?B?MkJPYkpzYkhsd0FCTU9JY285a253Nk12TmxQQ3hXZFp0WG9hQ3NpWlBkNnlV?=
 =?utf-8?B?VGQwOTAva2xzOVk4WDI3ZE55MkVHcXFLVUJFblExV1VsdFRYMklQZTBLNnVK?=
 =?utf-8?B?Q2MwdTY3d1J5U3VjOW02L3lEYk1JcE5PcTRIaTdoclVraEVlOWNNUEtSTHI2?=
 =?utf-8?B?N1ZHSEd5RHgvSG9HTW1rYzJ5bkZiVEYxTmVpbUJSRlZMOWJhaDhJTkllUENw?=
 =?utf-8?B?cUFLaU1jcUEwNTNVQXNmT3BhNjJ1K3YxbGVpa0RwRGQ0QlFyZGt3U2dxTmQ3?=
 =?utf-8?B?OWtYcnhPQUovclgxMkJmdHN5d2dIRFYvb2JEaVNDYk5qb2l3VlZRQWtuUFFT?=
 =?utf-8?B?cnlRQ3ZFMXBjZnVxRVI1UklQczRxZURnc1JEQzVOZzRyUm5YeEFjU0xrbklM?=
 =?utf-8?B?c05XdTJaWXMvMG1SdUJqRm5tb3ZsNHVpMXdLUGZVV1A1SWFYa1R4WVZwOWtp?=
 =?utf-8?B?NERCdjZ2cHBDVjQrR21US212VEJLVVJFSEhjRkFhMW05NHdmMlRWR1phNFZH?=
 =?utf-8?B?RDFMR1hST3o4YzZ4Smd2T0lNVXlWOUtrMzQyQXpYajJCNjVPUE0vWWRIblE3?=
 =?utf-8?B?MlEvWlMwTXZlcU5Ha3QxYytTK2pOY3R4YXNIMWQzdmdYc0JTT2ZGRTQwUmpu?=
 =?utf-8?B?alVjT1g2S0xUUW4xanpiT01DSklSWUtBTklxV3doaExHWnc2OFUyeEg2WUkx?=
 =?utf-8?B?R25lcm80ZUM2YmRiK1pjUVh2d1J2WDNJRllrbC9XWWMzTGEzYmh5ejQ0V2Vx?=
 =?utf-8?B?c1BMNWY4RmFQK3lRWDQ0NEZPYWJ1UDhIc2ZzenlISUc5Zm9rOE5XQlQvREJ4?=
 =?utf-8?Q?4kQfdApHDguFgS8poomVI+0/zC2ces/h9bOFzcyOwI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A952ACE46F09574E9CF98C0FE54CAA3A@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0bca67-706a-41b5-ccd6-08d9e1bf6fd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 18:04:17.9893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BIW6y61nMjB2aooNyEQdmxXUhlKjLk2t/mQVb86I3VnvNFWoen1QDi7UpKx+dOhxfXyykakI0EWvvM3sty5iAGcSwE8BlHpMaRlfex/07hk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2622
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDI3LzAxLzIwMjIgw6AgMTc6MDUsIE1pcm9zbGF2IEJlbmVzIGEgw6ljcml0wqA6DQo+
PiBAQCAtMTk1LDYgKzIwOCw5IEBAIHN0YXRpYyB2b2lkIG1vZF90cmVlX3JlbW92ZShzdHJ1Y3Qg
bW9kdWxlICptb2QpDQo+PiAgIHsNCj4+ICAgCV9fbW9kX3RyZWVfcmVtb3ZlKCZtb2QtPmNvcmVf
bGF5b3V0Lm10biwgJm1vZF90cmVlKTsNCj4+ICAgCW1vZF90cmVlX3JlbW92ZV9pbml0KG1vZCk7
DQo+PiArI2lmZGVmIENPTkZJR19BUkNIX1dBTlRTX01PRFVMRVNfREFUQV9JTl9WTUFMTE9DDQo+
PiArCV9fbW9kX3RyZWVfcmVtb3ZlKCZtb2QtPmNvcmVfbGF5b3V0Lm10biwgJm1vZF9kYXRhX3Ry
ZWUpOw0KPiANCj4gcy9jb3JlX2xheW91dC9kYXRhX2xheW91dC8gPw0KDQpPb3BzLCB5b3UgYXJl
IHJpZ2h0LiBJIHNob3VsZCBoYXZlIGF3YWl0ZWQgYSBmZXcgbW9yZSBob3VycyBiZWZvcmUgDQpz
ZW5kaW5nIHYyLg0KDQpUaGFua3MNCg0KQ2hyaXN0b3BoZQ==
