Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354B867CB08
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jan 2023 13:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjAZMoK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Jan 2023 07:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjAZMoJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2023 07:44:09 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2072.outbound.protection.outlook.com [40.107.12.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819CA23319;
        Thu, 26 Jan 2023 04:44:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHwkZjUy1it43so/tWskikTSbLVaY28DZvMbDqaNm9YcM858ciqCvnpfy896yO53qOfvEufdsBYetP4oSk21AFDUPeFP6rgwNGVqf+jIrsMsRglm2BVfY2ktjlOIaj63qhtZ6/Wr7sYnSImdfEPkvUYTT6+VsSYVI+j606PIaxckdS+vqvK/6MRJ8itDrvvLoCk+/jWOH6qzAr+X3brNm782ojzdkBhcCPb8EuQI8qvo8XNnXmZVGO2azE7N+cnVvIeVrUPoTwHUq6ea6Nl9lVn4Lmmc7iB0E8wehipc1mPyI/N8BvFEWakxliJaeVX22L8oyYLh+Nx7jxnjIor3jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFUP4CmVZvUhoWzATH6jiLkELql0Ufo1I0yzUtMA2ao=;
 b=kiy+bAC/sVb8bikkI54O/hkBXk+vY7CQXt46bX572ZhcvMgMfqmLr0EfjKFDRIX+5De9O1dforDBNjAophQ3e6DuJNQKV+7UEHoP16hC5QtoiLpZGjuftN7rvh1Wjb9fg7S8I0y8gXxq9rvHEt4wZZZGFS2oSy/u3NE3hxgcKEOrz0GsMg9eUamseEBQG+mVsStL7JmuNN56NvvqaSD2GcFetxShl7fqqA3xN3W+BKGHKnB6A82Cz/vOsLN1ImdKVfq7kz7J+ZxERWS+65lismcw6F+uiZWWuxymWQ1fE+rQ/za3gdJ/zK6/eLmgYlbH2mqZ6xdyP4+N+b75aAkTZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFUP4CmVZvUhoWzATH6jiLkELql0Ufo1I0yzUtMA2ao=;
 b=uvnlMd+CqS3k2UQGYng4QXjjaU7/PoBRulfk40EcMmc9PZ087FyMZBjIyxeqMdx6XaamZYkxbaSVRLorJrhP45rKE/fpvtiiWcm0OpKHRSkVzhVGT2y4VbUxCGSYwxrHToM/lXqTyOAslRwTszW7HH5OrZk2Btp+MiRYatP4L3Kfrzg/sHqIfBvJ0ovdC5qojmn8ejtF2u2aiqOaD5zeannA3v7s9TzvvjNQLswRvjQIotDMzb/jryCBiId9gyTjheKQ73C5eoiWob1FdTeY4pgR8EymhdHqIx8cerhfi48kytPj9Ng9mfIpSrSVrhdwJaIkI+BnpviWNBLqMcrrdw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB3273.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:110::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Thu, 26 Jan
 2023 12:44:02 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097%4]) with mapi id 15.20.6002.033; Thu, 26 Jan 2023
 12:44:01 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        Pierluigi Passaro <pierluigi.p@variscite.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/5] gpiolib: fix linker errors when GPIOLIB is
 disabled
Thread-Topic: [PATCH v1 1/5] gpiolib: fix linker errors when GPIOLIB is
 disabled
Thread-Index: AQHZMPkA08flZIRpAUqSzkFtrKPDGK6wWpEAgAAixYCAAChygA==
Date:   Thu, 26 Jan 2023 12:44:01 +0000
Message-ID: <7b7df1f7-4f47-d19a-02ff-91984b25ba98@csgroup.eu>
References: <20230125201020.10948-1-andriy.shevchenko@linux.intel.com>
 <20230125201020.10948-2-andriy.shevchenko@linux.intel.com>
 <ca399c86-5bfc-057b-6f9f-50614b91a9b9@csgroup.eu>
 <Y9JTo1RkxT2jORPE@smile.fi.intel.com>
In-Reply-To: <Y9JTo1RkxT2jORPE@smile.fi.intel.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB3273:EE_
x-ms-office365-filtering-correlation-id: fc9c7240-8f51-4888-8ea0-08daff9b0075
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nPDsZsphxncl0lcOlElfP/74MTYWovJb0xfGM2jmKo1pj2Ua2Ow6+5Nh3GjTUxGDltQITp6DbaOrOwXUEg/6rZkD/ovMXNCK9JZUfgGLXffAWLEu5vn0PjLy+tA8QKEUjFs0y908KNhVbA8bBHO19E2l8nDojjoyT61M/EEHoWSrJ6Eh7HgpDEmgD0BFr+hBiCyS7cxmSDlR6rn0MWelxDx3vbMblNbFa5Qv3//GMm9upBwnGu9KsDMtrTkaBg94ZJO9jUGpxzcVkJXuGSf/22h1v3jObY4Dl9Ql412U5paxviXpbiTcAXYb3pEIY6vKZ2bWmxZL1TxInbStU6aJbNTvIhe9G9dspYWRyJIV5oELzA26Kp4RjCOPo2XtrBgfuNw+8TsQqMRwpznueb+x8CMdv6R5I7aS/lNBIlyEl7I60UwKgscrMxnKwz0+Hp1hkKiJAUzzXosRCNLUHPUd6SeJW1RM95UYR0RrnrLfRSgPg9RUrQTD8JeheBfcPSn88XT6QEawaomrqzC5cfeLw/enIRwxuvIW3t1RMoxcNLRj82l8/rSNg/YBHlauPQ4Xvi37SBXMivW95tR8+VQ3lfxijaBSwHbYJd9li06I6OvErYqNdifSA4JSE7WY701z8zT5mrgVAVwk8kvkjIqhZvPFBeH6osFR3lKL9z9VfqGnAgFrJKTlBTTxCWFW1FyZ1qPV3fPbBfzSoASqxS56HCLXTKBGLpLWWGYW8S35/I6Kut6YC6xolWBKdAbyDxeeKtiDGgk3vjC8qma6K9PpIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(366004)(136003)(39850400004)(451199018)(44832011)(66446008)(478600001)(2616005)(6512007)(31686004)(71200400001)(4326008)(8676002)(91956017)(66574015)(64756008)(66476007)(6506007)(186003)(26005)(66946007)(6916009)(83380400001)(76116006)(8936002)(5660300002)(41300700001)(66556008)(7416002)(316002)(2906002)(122000001)(38100700002)(31696002)(38070700005)(54906003)(36756003)(86362001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDhXWHM3czBRQUJwbXVOTFRYTE5NbzFxLzI0dTY0RVRqNURYMnlIU1FmcjJ0?=
 =?utf-8?B?ZWVYaTY5UXlCZCtzcHErNVpYb0dWK1p3SWlOaXZDcSsxYVFZei84TEI2Lzhq?=
 =?utf-8?B?M2VFc290VWNLMXZSMXFDdTVwT1krYndGSDdYSnd4dGZkNHZqdE1jOXdkRFUy?=
 =?utf-8?B?OXVJb0g4ZWFGZTV1aUdwSzlOY3FNVFhJcWFPNFlWY3NHUHBXZ3lXMHNvSjRJ?=
 =?utf-8?B?TzNBT21QQ2d0RWU4SXBJV3Zsbiswb1drRzNCTGF5eGdsZC9DamdHUUVKYUhw?=
 =?utf-8?B?WHV2UjhvQkVpZzRpVmR5STYrcmVBWVYxbUxmOWdsSGpadzdDc2hIbGsrTmg1?=
 =?utf-8?B?RUZtOVFzdVZBUkR5NFZEMEJnVGxQSUFKSU5vY2lZdWFGZE1qUHVwd1ZGWTR2?=
 =?utf-8?B?NzZYZFRDNVBuRTUxRkVMSjBKa2M3QXQ3TWpvaEZXa1RwQ3FoMUpJMVd4enFN?=
 =?utf-8?B?ZHZCY3lYQ3c3NFZibE9DTzNwOHNWWXRxNjNVK1B5NkRYdmw2cXBKZ1JjRStJ?=
 =?utf-8?B?NzVYWFpEcWdPTzU1TjA5bmZac2d4NUR2T0lSclRxU3RZTkEwSUowQ1BoWDlU?=
 =?utf-8?B?K0g2U3FSTE82VlVSbllyNVord0FQNDdjbzgwSm5OZWloeGU1bnRHc2tjL0dW?=
 =?utf-8?B?ZjJMdWhnWU9NRmwwTzA4OFgzSkVTZUEwRlRXMi9CY3QvS05BRFdPWkdFUnZi?=
 =?utf-8?B?RXZSejlCYlFabGxsbE90NHU2UFJMOTFmUklKQUZHWmNwOStJdVBvNmY1Z3hP?=
 =?utf-8?B?VUJBZzFFY05aejZPMlM5SnVPWHQ1NGNLZ3BYU1U4dE1tSERaaWZZekNCb1NZ?=
 =?utf-8?B?UW5wQkx3djk0bmlJTnFJQ2ZIV2JXMTU4dlhpaDJFR01sQTEvQThUenFWaHRh?=
 =?utf-8?B?QUtlcHV4WkJTd1ZTeHhzVWlJQUVuaDVMZ3BaM0REaGxIeWltS0FWMjhvZE1M?=
 =?utf-8?B?cVc5NUsyaEZrR3FkWCs0eDJjL2V6RkVCQjMvNnJRUnNmcnVTVEdCbnhVUnA3?=
 =?utf-8?B?Z0YwQUtuczBmQjNIVyt4THUwR2h6Y05NWTBkSUtZaHlmdmhjaDNtdC80R21D?=
 =?utf-8?B?eUtsRGhJY2F4MFRVMUZSaEdRV2p0VWR3bnF0bHJsS0w0N2xIZ1BkVXZqczhz?=
 =?utf-8?B?OGYwN1dkTWs5bWhIZXRueElTeFl4TGE1WURJMit5N21pQ3RzY1dCbTNaSDM4?=
 =?utf-8?B?ejFFUk5NUGtUaWladi80VTcrZFlwdWZ4T0xKTUFtSFU0MFRmcHJ2ZVBENFlN?=
 =?utf-8?B?UjFVYUhHTnpkbk1IcWtrYkpjdHVxUDVVZmt2dm5hZjhKTUhmOVVQSGRtTlN2?=
 =?utf-8?B?Um1vdy85bStjSE45bE52akhZTmtRNkhwa3UxcjlMY1NqSlVpOWl1OWI3NDd5?=
 =?utf-8?B?cHAyczBKcGwzcnhCQ2xDWUhOQnMxdkdqSVYxa2kxY1c2THo0VGpJeStUd0Zj?=
 =?utf-8?B?SlZYT01wc2FIRTkwd1Z3K1p3WTdTczd1Mkh2ekxOZU5OdGdsbFJNUHVSWW9o?=
 =?utf-8?B?VDZ2UE9GUGVKaU80QVR6cmRXRzNkNzZQQ2oyOHlGR2pJUXNVR3M3dXZYNG5l?=
 =?utf-8?B?bEFDRnpZeTBLOGpudXdlWEVRaUwyeGw5WGVIcTRnbXZic081U2orZHcxU0g3?=
 =?utf-8?B?RUlCeU5RaXFiNC9LNGY5SFhSUGZtcTdQMjhwV1FsVTYxMXZTMFBrRnJBQlda?=
 =?utf-8?B?MWNkbEZRenk0dm9rOUZtaU8zc0wxU2w1aElvdWZsbnJiTk5BcDY2NnNsUEFM?=
 =?utf-8?B?RGVKVHdzSGI4d2w5MWxzaFFmeXlvMEREaC9Pc25RaTFkMDhScjk2Y1poaHYy?=
 =?utf-8?B?Z2o0T1N2dUd1TXJnVmxkODdScFdDR01jNXUyRVhFd2wwWkgvL2dIQ2lCWDZL?=
 =?utf-8?B?NDN4U1pnR0JJdXdYeFZOcXROTkUyQkJzTFhHa296OHN6T0J3WGFRenV4cEtr?=
 =?utf-8?B?M2tOYjNNSitUVW5ublRJZDY5eW1Oc3J5Mk54eU9EWHBmb0FNMjVQVEZGSlNi?=
 =?utf-8?B?VEk3K21iQlA2cXdjL0tyRVlmQndqRmVXUmIyTElDSjBIbVJ6S3ZrN3dkTTlW?=
 =?utf-8?B?VE9sK0N2WUFQNnZaZDB0ME9ibzZYZzZvTHJ6Mkc1QUVFWGlWZ1A1Y3FRV05G?=
 =?utf-8?B?TGhuVXVLWnhTYytsSXVocU1ESGFNR3FIS3BWVitzRGZ3WVg1QzJiRGhLSzVY?=
 =?utf-8?B?akE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2171F6EA6699834BA94CE47ED51AC8F9@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9c7240-8f51-4888-8ea0-08daff9b0075
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2023 12:44:01.8439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iodVlpD2ZMVGNwjYV2DALmngROVgQio4A48OncpOL889Ti3oFnzk0wEHyoOgTNu6F2kjSHGOmlJtq+uKnwDjo9ufuKCrvTvSKFS5yN45dvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3273
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDI2LzAxLzIwMjMgw6AgMTE6MTksIEFuZHkgU2hldmNoZW5rbyBhIMOpY3JpdMKgOg0K
PiBPbiBUaHUsIEphbiAyNiwgMjAyMyBhdCAwODoxNDo0OUFNICswMDAwLCBDaHJpc3RvcGhlIExl
cm95IHdyb3RlOg0KPj4gTGUgMjUvMDEvMjAyMyDDoCAyMToxMCwgQW5keSBTaGV2Y2hlbmtvIGEg
w6ljcml0wqA6DQo+Pj4gRnJvbTogUGllcmx1aWdpIFBhc3Nhcm8gPHBpZXJsdWlnaS5wQHZhcmlz
Y2l0ZS5jb20+DQo+Pj4NCj4+PiBCb3RoIHRoZSBmdW5jdGlvbnMgZ3Bpb2NoaXBfcmVxdWVzdF9v
d25fZGVzYyBhbmQNCj4+PiBncGlvY2hpcF9mcmVlX293bl9kZXNjIGFyZSBleHBvcnRlZCBmcm9t
DQo+Pj4gICAgICAgZHJpdmVycy9ncGlvL2dwaW9saWIuYw0KPj4+IGJ1dCB0aGlzIGZpbGUgaXMg
Y29tcGlsZWQgb25seSB3aGVuIENPTkZJR19HUElPTElCIGlzIGVuYWJsZWQuDQo+Pj4gTW92ZSB0
aGUgcHJvdG90eXBlcyB1bmRlciAiI2lmZGVmIENPTkZJR19HUElPTElCIiBhbmQgcHJvdmlkZQ0K
Pj4+IHJlYXNvbmFibGUgZGVmaW5pdGlvbnMgYW5kIGluY2x1ZGVzIGluIHRoZSAiI2Vsc2UiIGJy
YW5jaC4NCj4+DQo+PiBDYW4geW91IGdpdmUgbW9yZSBkZXRhaWxzIG9uIHdoZW4gYW5kIHdoeSBs
aW5rIGZhaWxzID8NCj4+DQo+PiBZb3UgYXJlIGFkZGluZyBhIFdBUk4oKSwgSSB1bmRlcnN0YW5k
IGl0IG1lYW4gdGhlIGZ1bmN0aW9uIHNob3VsZCBuZXZlcg0KPj4gZXZlciBiZSBjYWxsZWQuIFNo
b3VsZG4ndCBpdCBiZSBkcm9wcGVkIGNvbXBsZXRlbHkgYnkgdGhlIGNvbXBpbGVyID8gSW4NCj4+
IHRoYXQgY2FzZSwgbm8gY2FsbCB0byBncGlvY2hpcF9yZXF1ZXN0X293bl9kZXNjKCkgc2hvdWxk
IGJlIGVtaXR0ZWQgYW5kDQo+PiBzbyBsaW5rIHNob3VsZCBiZSBvay4NCj4+DQo+PiBJZiBsaW5r
IGZhaWxzLCBpdCBtZWFucyB3ZSBzdGlsbCBoYXZlIHVuZXhwZWN0ZWQgY2FsbHMgdG8NCj4+IGdw
aW9jaGlwX3JlcXVlc3Rfb3duX2Rlc2MoKSBvciBncGlvY2hpcF9mcmVlX293bl9kZXNjKCksIGFu
ZCB3ZSBzaG91bGQNCj4+IGZpeCB0aGUgcm9vdCBjYXVzZSBpbnN0ZWFkIG9mIGhpZGluZyBpdCB3
aXRoIGEgV0FSTigpLg0KPiANCj4gSSBhZ3JlZSwgYnV0IHdoYXQgZG8geW91IHN1Z2dlc3QgZXhh
Y3RseT8gSSB0aGluayB0aGUgY2FsbHMgdG8gdGhhdCBmdW5jdGlvbnMNCj4gc2hvdWxkbid0IGJl
IGluIHRoZSBzb21lIGRyaXZlcnMgYXMgaXQncyBsYXllcmluZyB2aW9sYXRpb24gKHRoZXkgYXJl
IG5vdCBhDQo+IEdQSU8gY2hpcHMgdG8gYmVnaW4gd2l0aCkuIFNpbXBseSBhZGRpbmcgYSBkZXBl
bmRlbmN5IG5vdCBiZXR0ZXIgdGhhbiB0aGlzIG9uZS4NCj4gDQoNCk15IHN1Z2dlc3Rpb24gaXMg
dG8gZ28gc3RlcCBieSBzdGVwLiBGaXJzdCBzdGVwIGlzIHRvIGV4cGxpY2l0ZWx5IGxpc3QgDQpk
cml2ZXJzIHRoYXQgY2FsbCB0aG9zZSBmdW5jdGlvbnMgd2l0aG91dCBzZWxlY3RpbmcgR1BJT0xJ
Qi4NCg0KT25jZSB3ZSBoYXZlIHRoaXMgbGlzdCB3ZSBjYW4gc2VlIG9uZSBieSBvbmUgaG93IHdl
IHNvbHZlIGl0Lg0KDQpBbmQgaWYgd2Ugd2FudCB0byBjYXRjaCB0aGUgcHJvYmxlbSBiZWZvcmUg
dGhlIGZpbmFsIGxpbmssIHRoZW4gSSB0aGluayANCndlIG1heSB1c2UgQlVJTERfQlVHKCkgYnV0
IG5vdCBXQVJOIG9yIFdBUk5fT04uDQoNCkNocmlzdG9waGUNCg==
