Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC41967C593
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jan 2023 09:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjAZIOz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Jan 2023 03:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236338AbjAZIOy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2023 03:14:54 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4CF67786;
        Thu, 26 Jan 2023 00:14:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e24dhEUyKbVI4mFQPhbbIGxPveH7my7PfbXS9Tpj+hP8UANRg33Mzukj0H+2EEozvrNifvE9U3s7c+s6hifafSiJLjsjZVXkxK1bdanZjeHTO3Gdm2xf5noV8ZVfzCx/r4+iSuhkj17jsPTP+jparqbbwEWmsJ6E2mBZP+wX56D0L1Qcx18FbJqnQv+mTX/ypNRcTG3IUj+2GjgofyKZCIARWpFWewq/hRWJL5nzfJNGrXMywJDzIGilZifN68vu3zycU7MRfP0LMO1dZl4MmE5b/HyLEHSDbRKL+s6SCSCTjCsyhxlp4oBAWYMuyqNYJBQEex2tVI/0FJD8fn51ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+J9aEtkhkyZ5LzS8D4f2Eec2HXO0xny+0G3s4MLPxC4=;
 b=Ml6qNeMekrJjHif9UDSSwOmHNMeA5l2GgtRoCLyzkPA7zgkm+RDjcyVsn/BMP4gRrmn7D5jQwz1a/RpYPmEXUCeppBJCBaB3fKfPT0wJwcNFnlyHsoLKHiZ/DmGNS1LUWBDCV8rSmRgkpHMdq8LDllWwYTdhRhwozMmQ0UOuftv/cKfscu6zn+1X7KtiLLyvIYReQj0/FliNjtcPMkz7GPZU5AjNBz9XGvgKSi/BHHJRGi/+H5pR26FICiL8RnPk5F0tVkWAuOM9QdpFieToDgsEnOYK673VfKrdV7jmZSZs1iGQda0spi0/iAJE3E7KSSAfPjHl8nK4g4lfIke0IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+J9aEtkhkyZ5LzS8D4f2Eec2HXO0xny+0G3s4MLPxC4=;
 b=uXRTYWgtGulfPOA63ikZOqaUdYN/A04tzD8wu27VTKWmN8pNEMhmUpI58ffkzkMKN/Xh/2XZQEApEevVMDGU0kRXA83fJmYUQAeWj1z2PvYkqyAGQGQu+SnFjko0kHi/VqbWDNnCST3nnHmgKYohjbMVfi7oYoQ8zEs7KfCRFE7DY0ilN971anSzp/cevtTyA5+SlhZa0W6bg2K//ZhKT6/lvNwq7uvzn3O0w+fJbKmDf17/vuj6G22f3Dg0v9EjxeL4E4GvhmFmh5TwkWi5gof17dZZtUFndcPlEmSBes7ceOiGkEobubz3ZJR0F1Hr+y6zuFQRjARpZ+qt7KTbVg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB3363.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:2a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 08:14:49 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097%4]) with mapi id 15.20.6002.033; Thu, 26 Jan 2023
 08:14:49 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        Pierluigi Passaro <pierluigi.p@variscite.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/5] gpiolib: fix linker errors when GPIOLIB is
 disabled
Thread-Topic: [PATCH v1 1/5] gpiolib: fix linker errors when GPIOLIB is
 disabled
Thread-Index: AQHZMPkA08flZIRpAUqSzkFtrKPDGK6wWpEA
Date:   Thu, 26 Jan 2023 08:14:49 +0000
Message-ID: <ca399c86-5bfc-057b-6f9f-50614b91a9b9@csgroup.eu>
References: <20230125201020.10948-1-andriy.shevchenko@linux.intel.com>
 <20230125201020.10948-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230125201020.10948-2-andriy.shevchenko@linux.intel.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB3363:EE_
x-ms-office365-filtering-correlation-id: eada4dba-f477-4f1f-ec9d-08daff75649c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YYmZutx8ja0lrLBSejxrKHiiqtah8cjRoUuqmq5cL2EA8YUW+qZHOvgwe4idH8S0APJyl4wjolZgkc7rHpbLhZDmEy3e2myjsP9CAGdotM9mZWC04dhEN6qDfOHkWzJUPdhKmhnlUokyOFidvy/0DyfGnA3E0XtDvyQod/urr1IJl5Epd+0JkOrcjlGOvahaEGbEAnd5iAQoeO/uYYa4YK6l8tlJt2vWATXmC25YAnk3FUBbfU8M3/6yVqhzAsorBzDOww2JPEwqf1yKLhZHHuSQsS2tAghENXhRnj9wALCsUGSDHtQw3mpasGSAWhMON/4knpQV+qcqSa6fHPdLFMs2DjjGEbGA5b86tcms34gr3QZFQ4+Xx4rTTco96HLyvmZr3P4Ithdsc8a3+drjLYEblXCR8hcW48/qnne/KtvHXByDsLLkahCJtEG41LgC6j16UFFiZspXJdagY1UN6RdhSIAm/zEF7cv6bDuZYLm6tzX+aUuKPNEIZDTuKITjpC+CBBvx/L3ZHvCm93RBSTPqqbwryHebvFE+ER8oDT8u3/3ku9Mym1qLY+rLc5BQnNIrzVAa3+SxbAcQVu6B4yyPVkrDjwoBxJC8AtErJfawFw9Lv19oIOrcs72A1hlqydDxMC87Jkf+VI2ml7oxZWUwzWmlsFi5ZEufiZ1wqm64yMFql4moRpQpXL93fcslLcBkXOWTDnVDXb0q5fDK0pO0mz//ICLMiPvrpMcxYl0Rz/cLFt7kbD0di7L/3+/jlCb3t+HyP+ZHStbj4ZTcmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(366004)(39850400004)(136003)(396003)(451199018)(54906003)(110136005)(316002)(38100700002)(122000001)(41300700001)(8676002)(66476007)(66556008)(64756008)(66446008)(4326008)(91956017)(76116006)(66946007)(31696002)(44832011)(7416002)(5660300002)(86362001)(8936002)(38070700005)(36756003)(2906002)(6506007)(6512007)(26005)(186003)(31686004)(478600001)(6486002)(83380400001)(66574015)(71200400001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2VQRkw1dk9QcUdJMnFpZGNpSFJESzlxdktpMkYzdHVOeDlVN09ncmg1MVAy?=
 =?utf-8?B?NXFRZDlYaHhzMWx1Q01ZanRqa09tbmNsYXdmbUR2ZEJhM04wdXNvN0U1YTBZ?=
 =?utf-8?B?TXlYK1RaUDhwWUV5ZkFOOFFQbGxUQmIxaWVreWY4MnJYQ3NJUDhGdWV4TEI2?=
 =?utf-8?B?bGcxVnNDbjIyZkZnbU1pRzhjQUpNTkRBTXVQYXRRK3NBeGlzQmNMeU5uYWRF?=
 =?utf-8?B?aGFYeStyeXdFdjE1WXBCdXdQSEcvS3RGSkhSZEhBUjU5STFnbUo2QjZqVCtl?=
 =?utf-8?B?VkdjTlVJYmg3NFJNV2JVMnprdlFBUGdxbllnMlhCUDBLN0pqdmJvNm5NQ0lz?=
 =?utf-8?B?RVF5L1ZqTUhzWXY5amUyZDY3OGRrYThKZ3NYSEozUGNDZi85am9WZUlhT280?=
 =?utf-8?B?aWtqd1ZWNy96S0ZySVJTeDFjTEEvNjFBZG51bnRLWDRIcy8xRC9TS0NUbTlF?=
 =?utf-8?B?RURkcytuRnd4SGFkcm95YVRBeVpXaXgvSTRpd3g1cVdveStkNTRON3lKUVVh?=
 =?utf-8?B?STYwNzRBNW1PSFN0Y0JXYnQ5cDRDalZqVnp5SFlJOUJNNCtJSktwMHhKTmVm?=
 =?utf-8?B?eWJrcVFPcHhDc3hlNmdsZTZkY1I1TjdCaXZ5cko3SlgrYzhPamxOb050dytF?=
 =?utf-8?B?QVhreFR6TUN3WnUycGZseHNGU0lzVGY4VU45dTZKaVQvSHRibzNJamZqckI0?=
 =?utf-8?B?L3VCeEJMVVpNb3V6K0l0OGYyUkVtdXdYeXA3UExuTmRuQTF6bko4cmhWZDVW?=
 =?utf-8?B?eG5HbCtyRFdSamRWRnlGalM0R0hFRUl5WHg2YmdYcGZZK2VYbjZ2bGpqMmlz?=
 =?utf-8?B?SHRMTzdhVEVrVmlJVVkreHhkK1FZQnR6cVpPOFErYnk1bUJQTk04b3dUNFhv?=
 =?utf-8?B?NUo5ekdzRitlWEdHNE9XSnlBb1REMnVwdlpwOUJZN1ZJbUd3c0JkQWp1bFFF?=
 =?utf-8?B?ZVRrcHFBUk04VHpuV1Z4eUFKZGx6LzNGQ3lVUkhjRUl4WkVLOGR2L2dheEJB?=
 =?utf-8?B?T3BINE9OeHFBRjhzanNnQVlvYzF4UTBLZ2VKcW96MUp2WGMyMWQyUU5vWkFp?=
 =?utf-8?B?THhRcVZLM0ZmSTdFUDl0YzVUR2kweldXTXpVcTRETVU1dXhlQlBIZWw1aWZw?=
 =?utf-8?B?S0xRR1FuS0gwdXllQlBDclJMVk56UksvYWNUZ1o3WjFnZU92QUlmUWtqLzFq?=
 =?utf-8?B?UkxtVlpuK2wzcTNydkVzZDlYdy9ZV1prRXl6clhWNHJEWEl2Ti9uMFlDQUlm?=
 =?utf-8?B?VXRUUjNFTjVSYyt4VWpJU0pTYWFwU0lvL2VWaTR3MDl0OG1ZbmpiQTFsVXRU?=
 =?utf-8?B?T0psVjIyS3UvVEg1RWZzbS84OXorN3RjQ041Y0ZnK3ZxMzNnLzV2VTRBbjdQ?=
 =?utf-8?B?WURIRHN3R01XTWNFT0owRWlKS3ROeXdhWVpib0J1T09JRGJYQlFkUk5LVGJX?=
 =?utf-8?B?T2ROSENzVzR2ck80dHhhWWF3OXlVUVVITGVlZms2cE1Qdk92VmdXTnFOVmpL?=
 =?utf-8?B?c3ZUYXRpWFZBc2R3Rms2SHBHNjlPcW05dG5sMkNEUXpNdUtDQm9jSDVmOEh6?=
 =?utf-8?B?ZWhmZTJPRWhrWlJhN2RDYkJJSFNOeTh5dTRWVjRrV2ZLSTk5TFpXS3prN1JM?=
 =?utf-8?B?b2o4bFh6M0FOZG1OMTgyb0VVdktpaWlNYnBsM1FHOUZ1czdrak12VVJCMDBO?=
 =?utf-8?B?MEJaT0hFaStxbjIyb0NOQ05JTVJkQktTelhLdGN3UFRsV24zSnBoRXRKaXJ0?=
 =?utf-8?B?VmVSK09LUlB6ZmNPZGgzbytxMFZSTUdHSUxMZGJnVlNXMTVwRTU1WGdzMDVU?=
 =?utf-8?B?aXpiT0xyWXg5Y01tOUowTWFmU2JJWS9NbDlLMHI5RFBiR2U0TVlOcHpnRzVV?=
 =?utf-8?B?bnpCbkxEOU4wZ3hpTU1oMXdaVDZIcUtBLzhydXRZY0lrZUhRZHVMcUFIVGV1?=
 =?utf-8?B?NFpTUzN6d0ozbHhSY3JaVlJMMG1ERXE1clFSeTFoRjNMeCtXcjM2djBQWmwv?=
 =?utf-8?B?MVhjaGo1cmF5TVZqY09PL0d4RkFSU0RrMDVTUVNrVTZqUU1LTW9zbHpzV0hY?=
 =?utf-8?B?em9tcXNFRURQaUIyYU5LRHdSSm40cDYrZEphbEFET3A1TXU4bE5nUnFQOGJl?=
 =?utf-8?B?NEYxQlpjYjR3SWZ3aXY1UnJCYkxkdjNqKzVWQkdvVkhDSDRDQVBOTFdiSzV0?=
 =?utf-8?B?V3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66E745544785954FA06AC91385985E7D@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: eada4dba-f477-4f1f-ec9d-08daff75649c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2023 08:14:49.0296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z3/xsz7QALbosi2c/cM+e25gNL9D+iVtKp0hOL8jawIJyGrLwcpp9OJjs9qTtFEIB5F+FHZov+Jx+fpXQFeeeCAqRYQBtRYL0jIeKuAg6Mw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3363
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDI1LzAxLzIwMjMgw6AgMjE6MTAsIEFuZHkgU2hldmNoZW5rbyBhIMOpY3JpdMKgOg0K
PiBGcm9tOiBQaWVybHVpZ2kgUGFzc2FybyA8cGllcmx1aWdpLnBAdmFyaXNjaXRlLmNvbT4NCj4g
DQo+IEJvdGggdGhlIGZ1bmN0aW9ucyBncGlvY2hpcF9yZXF1ZXN0X293bl9kZXNjIGFuZA0KPiBn
cGlvY2hpcF9mcmVlX293bl9kZXNjIGFyZSBleHBvcnRlZCBmcm9tDQo+ICAgICAgZHJpdmVycy9n
cGlvL2dwaW9saWIuYw0KPiBidXQgdGhpcyBmaWxlIGlzIGNvbXBpbGVkIG9ubHkgd2hlbiBDT05G
SUdfR1BJT0xJQiBpcyBlbmFibGVkLg0KPiBNb3ZlIHRoZSBwcm90b3R5cGVzIHVuZGVyICIjaWZk
ZWYgQ09ORklHX0dQSU9MSUIiIGFuZCBwcm92aWRlDQo+IHJlYXNvbmFibGUgZGVmaW5pdGlvbnMg
YW5kIGluY2x1ZGVzIGluIHRoZSAiI2Vsc2UiIGJyYW5jaC4NCg0KQ2FuIHlvdSBnaXZlIG1vcmUg
ZGV0YWlscyBvbiB3aGVuIGFuZCB3aHkgbGluayBmYWlscyA/DQoNCllvdSBhcmUgYWRkaW5nIGEg
V0FSTigpLCBJIHVuZGVyc3RhbmQgaXQgbWVhbiB0aGUgZnVuY3Rpb24gc2hvdWxkIG5ldmVyIA0K
ZXZlciBiZSBjYWxsZWQuIFNob3VsZG4ndCBpdCBiZSBkcm9wcGVkIGNvbXBsZXRlbHkgYnkgdGhl
IGNvbXBpbGVyID8gSW4gDQp0aGF0IGNhc2UsIG5vIGNhbGwgdG8gZ3Bpb2NoaXBfcmVxdWVzdF9v
d25fZGVzYygpIHNob3VsZCBiZSBlbWl0dGVkIGFuZCANCnNvIGxpbmsgc2hvdWxkIGJlIG9rLg0K
DQpJZiBsaW5rIGZhaWxzLCBpdCBtZWFucyB3ZSBzdGlsbCBoYXZlIHVuZXhwZWN0ZWQgY2FsbHMg
dG8gDQpncGlvY2hpcF9yZXF1ZXN0X293bl9kZXNjKCkgb3IgZ3Bpb2NoaXBfZnJlZV9vd25fZGVz
YygpLCBhbmQgd2Ugc2hvdWxkIA0KZml4IHRoZSByb290IGNhdXNlIGluc3RlYWQgb2YgaGlkaW5n
IGl0IHdpdGggYSBXQVJOKCkuDQoNCkNocmlzdG9waGUNCg0KDQo+IA0KPiBGaXhlczogOTA5MTM3
M2FiN2VhICgiZ3BpbzogcmVtb3ZlIGxlc3MgaW1wb3J0YW50ICNpZmRlZiBhcm91bmQgZGVjbGFy
YXRpb25zIikNCj4gU2lnbmVkLW9mZi1ieTogUGllcmx1aWdpIFBhc3Nhcm8gPHBpZXJsdWlnaS5w
QHZhcmlzY2l0ZS5jb20+DQo+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGlu
dGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNo
ZW5rb0BsaW51eC5pbnRlbC5jb20+DQo+IC0tLQ0KPiAgIGluY2x1ZGUvbGludXgvZ3Bpby9kcml2
ZXIuaCB8IDIzICsrKysrKysrKysrKysrKysrKysrKy0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIx
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC9ncGlvL2RyaXZlci5oIGIvaW5jbHVkZS9saW51eC9ncGlvL2RyaXZlci5oDQo+IGlu
ZGV4IDI2YTgwOGZiOGEyNS4uNjc5OTA5MDhhMDQwIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xp
bnV4L2dwaW8vZHJpdmVyLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9ncGlvL2RyaXZlci5oDQo+
IEBAIC03NTEsNiArNzUxLDggQEAgZ3Bpb2NoaXBfcmVtb3ZlX3Bpbl9yYW5nZXMoc3RydWN0IGdw
aW9fY2hpcCAqZ2MpDQo+ICAgDQo+ICAgI2VuZGlmIC8qIENPTkZJR19QSU5DVFJMICovDQo+ICAg
DQo+ICsjaWZkZWYgQ09ORklHX0dQSU9MSUINCj4gKw0KPiAgIHN0cnVjdCBncGlvX2Rlc2MgKmdw
aW9jaGlwX3JlcXVlc3Rfb3duX2Rlc2Moc3RydWN0IGdwaW9fY2hpcCAqZ2MsDQo+ICAgCQkJCQkg
ICAgdW5zaWduZWQgaW50IGh3bnVtLA0KPiAgIAkJCQkJICAgIGNvbnN0IGNoYXIgKmxhYmVsLA0K
PiBAQCAtNzU4LDggKzc2MCw2IEBAIHN0cnVjdCBncGlvX2Rlc2MgKmdwaW9jaGlwX3JlcXVlc3Rf
b3duX2Rlc2Moc3RydWN0IGdwaW9fY2hpcCAqZ2MsDQo+ICAgCQkJCQkgICAgZW51bSBncGlvZF9m
bGFncyBkZmxhZ3MpOw0KPiAgIHZvaWQgZ3Bpb2NoaXBfZnJlZV9vd25fZGVzYyhzdHJ1Y3QgZ3Bp
b19kZXNjICpkZXNjKTsNCj4gICANCj4gLSNpZmRlZiBDT05GSUdfR1BJT0xJQg0KPiAtDQo+ICAg
LyogbG9jay91bmxvY2sgYXMgSVJRICovDQo+ICAgaW50IGdwaW9jaGlwX2xvY2tfYXNfaXJxKHN0
cnVjdCBncGlvX2NoaXAgKmdjLCB1bnNpZ25lZCBpbnQgb2Zmc2V0KTsNCj4gICB2b2lkIGdwaW9j
aGlwX3VubG9ja19hc19pcnEoc3RydWN0IGdwaW9fY2hpcCAqZ2MsIHVuc2lnbmVkIGludCBvZmZz
ZXQpOw0KPiBAQCAtNzY5LDYgKzc2OSwyNSBAQCBzdHJ1Y3QgZ3Bpb19jaGlwICpncGlvZF90b19j
aGlwKGNvbnN0IHN0cnVjdCBncGlvX2Rlc2MgKmRlc2MpOw0KPiAgIA0KPiAgICNlbHNlIC8qIENP
TkZJR19HUElPTElCICovDQo+ICAgDQo+ICsjaW5jbHVkZSA8bGludXgvZ3Bpby9tYWNoaW5lLmg+
DQo+ICsjaW5jbHVkZSA8bGludXgvZ3Bpby9jb25zdW1lci5oPg0KPiArDQo+ICtzdGF0aWMgaW5s
aW5lIHN0cnVjdCBncGlvX2Rlc2MgKmdwaW9jaGlwX3JlcXVlc3Rfb3duX2Rlc2Moc3RydWN0IGdw
aW9fY2hpcCAqZ2MsDQo+ICsJCQkJCSAgICB1bnNpZ25lZCBpbnQgaHdudW0sDQo+ICsJCQkJCSAg
ICBjb25zdCBjaGFyICpsYWJlbCwNCj4gKwkJCQkJICAgIGVudW0gZ3Bpb19sb29rdXBfZmxhZ3Mg
bGZsYWdzLA0KPiArCQkJCQkgICAgZW51bSBncGlvZF9mbGFncyBkZmxhZ3MpDQo+ICt7DQo+ICsJ
LyogR1BJTyBjYW4gbmV2ZXIgaGF2ZSBiZWVuIHJlcXVlc3RlZCAqLw0KPiArCVdBUk5fT04oMSk7
DQo+ICsJcmV0dXJuIEVSUl9QVFIoLUVOT0RFVik7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbmxp
bmUgdm9pZCBncGlvY2hpcF9mcmVlX293bl9kZXNjKHN0cnVjdCBncGlvX2Rlc2MgKmRlc2MpDQo+
ICt7DQo+ICsJV0FSTl9PTigxKTsNCj4gK30NCj4gKw0KPiAgIHN0YXRpYyBpbmxpbmUgc3RydWN0
IGdwaW9fY2hpcCAqZ3Bpb2RfdG9fY2hpcChjb25zdCBzdHJ1Y3QgZ3Bpb19kZXNjICpkZXNjKQ0K
PiAgIHsNCj4gICAJLyogR1BJTyBjYW4gbmV2ZXIgaGF2ZSBiZWVuIHJlcXVlc3RlZCAqLw0K
