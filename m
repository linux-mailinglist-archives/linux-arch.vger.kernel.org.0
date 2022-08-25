Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29075A12D7
	for <lists+linux-arch@lfdr.de>; Thu, 25 Aug 2022 16:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241752AbiHYOAk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Aug 2022 10:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241272AbiHYOAi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Aug 2022 10:00:38 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90049.outbound.protection.outlook.com [40.107.9.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962776E2E0;
        Thu, 25 Aug 2022 07:00:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZhvTK6a3NDrEmc5JtCAXFvHa53ZmdVeY2MVO3FDqNgCivI5QINC/08IEdQX06Zv1/jqZEHpJQiTNi0O6ytRAQzEAkqOVAxAmhMz7QNmmBuufwjK+ahzrSfkWOUJ2TB4Twx2rA/GN4Yd8NBTReDEorEgKKJLhvh23ax+J3/tlj954mJPK/0uPpdiAWSceyuLeshF8RzODrzlOVHFlWL728qswtUkKCnd226t6nMvOPwOmvxXkUgFtYjLmda8KbRmS6CGiB9p5NmlZ2ZzChkpnr5AtLcO2wy1i5uMEC4SOT6mblbI8X52N0ET30hYOgq1Obdq7n3b7i3OwYALsR2uYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Riu0lU23siMbXPSOmPKdvWW7f2n4KVlmKJ4VortBL7w=;
 b=AdxVu0YHi82zcE5MH59SYEmidTbKff3LXEO/gqVjsWlfI4ZOP3YxS/+qu9+qyqTUkBX3oVA4YTTTPbLxyZ466d5fjS2CmXJ5Cd9Bv5QRSdePCFCpPWbal/ZR3r0TfdUFUl+mTnQb6xYtUXzRxSA+9J257EmjvurSva2fwlwVy7etyHhrxfOMsV/t8jfjG5qeA5rplWO+nyhhHzEWlck2zUWDC//FuUaPElLI2uUSf9HqfmbLOvCRcSFn3oPy08jUoh8VPDw0YQdTYBQSaYJz9micnoTzDH/OBwwN0F/kZ68/W6f1QUgT0KWxswKFP9pkq7BcfN55K6tPV8AtSVJGAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Riu0lU23siMbXPSOmPKdvWW7f2n4KVlmKJ4VortBL7w=;
 b=BuTDeA4gE5ZcChLahpJp/0wELTrtujZcl5fNoFh7HzaFDCr9LjyXcOUvjuu08tkLTpqMY9x97TinymXW13Gwgpugd0QqVQYcGHh7yUQVP5v9prK16YvWstkJUNSiPbYOLhKDpYSwf5/7107iDkikyGBrraxmgkf8iejK8M97+pJiOE3Kpa6oUuj+dFAvtBUaxgKM2/FAGoFcIcMZEmpB5X4l1mgI+VYMSUyas+QvGnJcbBlVesYDPD0zgCED2u4hRRpDfYCY4n+XbhOCMRwnUyDL81Y8bfQiV2fLLr7Dv8Dol6HcieUBejkBHcV+mK/HKZAr19Nglq5KC+VSNvOPww==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAZP264MB2831.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 14:00:32 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8%4]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 14:00:32 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Alexandre Courbot <gnurou@gmail.com>,
        Alexandre Courbot <acourbot@nvidia.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] gpio: Allow user to customise maximum number of GPIOs
Thread-Topic: [PATCH] gpio: Allow user to customise maximum number of GPIOs
Thread-Index: AQHYq9yc0+2EsNg9hki12SrFrcAXy620c0uAgAAEKoCAABfpAIAABZOAgAAOlYCAAAXLgIALDnQAgAAGlgA=
Date:   Thu, 25 Aug 2022 14:00:32 +0000
Message-ID: <87f2ff4c-3426-201c-df86-2d06d3587a20@csgroup.eu>
References: <f31b818cf8d682de61c74b133beffcc8a8202478.1660041358.git.christophe.leroy@csgroup.eu>
 <CACRpkdY53c0qXx24Am1TMivXr-MV+fQ8B0CDjtGi6=+2tn4-7A@mail.gmail.com>
 <CAK8P3a1Vh1Uehuin-u5QrTO5qh+t0aK_hA-QZwqc00Db_+MKcw@mail.gmail.com>
 <CACRpkdbhbwBe=jU5prifXCYUXPqULhst0se3ZRH+sWOh9XeoLQ@mail.gmail.com>
 <CAK8P3a0j-54_OkXC7x3NSNaHhwJ+9umNgbpsrPxUB4dwewK63A@mail.gmail.com>
 <CACRpkda0+iy8H0YmyowSDn8RbYgnVbC1k+o5F67inXg4Qb934Q@mail.gmail.com>
 <CAK8P3a0uuJ_z8wmNmQTW_qPNqzz7XoxZdHgqbzmK+ydtjraeHg@mail.gmail.com>
 <CACRpkdb5ow4hD3td6agCuKWvuxptm5AV4rsCrcxNStNdXnBzrA@mail.gmail.com>
In-Reply-To: <CACRpkdb5ow4hD3td6agCuKWvuxptm5AV4rsCrcxNStNdXnBzrA@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff32e4ed-57fa-4bb1-422f-08da86a22d30
x-ms-traffictypediagnostic: PAZP264MB2831:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GyyvcO7Pu4v3zGt3TI254GhHNqdbWsVCU3CyZPF1qOEFGp9qZdRxgFxlwRrK5lqWzeRaLQekW61bH9WY1LNhQFqQykt0iW2L75lNgCxuxbUsqwFavF0VWdKCveZ0XZ/NRvcdBAWOU7pBuzHPrUs46OA0+RRiHAktm51uztekcr4zMH21jYDO/DEWSAzQLmZ+hPXrb5DtX7BG1RYUbgTp4loW3IFU7Y4Y6l5ZhfoKhbW9Q+smLBeOrRdJP0wlr8KGUkl4s/e2mNEBHNH0vJgI5cXJ13Bji/U6t3PRiy9eVReulkzvkt0CmJvGk7x00FfEbnKlDdnzkrJrTsYrvcA/Z5WhgOnmNvMDiasJn6wY5+jhpU5yXmSwO9R/S0yszngxbSbpEArUwFVzhwwPaXT1ChxMIVGGHtuRI6EnsqMFVvomWqRpM8iaxCzJmUHBbPTlVAJAeCLzbcYDklgvXBphK+LwNrg0XMt7d4bMMTX+enSWpIDPQHxKh2hssThUv28IiWUqKty7bief+vTEz+R+px8NzRR2qz3MD7yJ/nchfoE3TesCyh8u12qDzReHjg7nqjtxxTUfHdKddAWwuP0zpp/CFH1rhKWXq7EiDFMTseaypvJW1THt+ufeVphL8piy5CRhz/jxHchH50Qma7haxDJ+R0jRkPxgAjL6WnH4iooGJAC7GW3FeGad9aapcxUzeCVfgg7XnrG2SBHTLjdwzVDCCYTL8rVy6DICVLPfqLJxc1dtNZAWPiLAhLcmJ3oiJmk28YnoQH7WyEp3S5tn1VXUgjOXurXEvUt/IFpDKR/2R3c55cbIWJbrmFzybwJn77msNQ8vz35Tb/VJoJIVSQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(39850400004)(366004)(396003)(66556008)(44832011)(71200400001)(122000001)(4326008)(66446008)(64756008)(66476007)(38100700002)(66946007)(66574015)(76116006)(91956017)(2616005)(54906003)(31686004)(6486002)(8676002)(36756003)(110136005)(478600001)(86362001)(2906002)(31696002)(41300700001)(6506007)(53546011)(26005)(38070700005)(7416002)(6512007)(316002)(186003)(5660300002)(8936002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnFlWTZ5dlY1Y3I4UkRpZ3dQcXNjYWRta0t1M2ZJUnJ1WWJFdHJ1VDl1NjhU?=
 =?utf-8?B?TjVaTksvTFdLNXM0cVlGaXN5b09zbkNJcXVLekpTRkZhTWF2UGRoYmRpTndL?=
 =?utf-8?B?ZEREeEhxckFhejRNTVpxcFhTaHBaNHNsWG1JeG9WWjBMUERaWGcwc1ZuSU42?=
 =?utf-8?B?azUyQU1LcDFEdVRETTE1MlhBU1VMdy9ZeEVNVlk5T1BvZ0tkOTlWZHNtZjNJ?=
 =?utf-8?B?Y05qQUFZaWFaOTJTbFc3VGR2Y3lBQmtxSHpGby9sZ1NNL3dPTlRlVWxvOWhO?=
 =?utf-8?B?RGRwakVjSDF3c25JYkRreWhveE5Va283aVBwUDI2WVZCLzg1cjZMOTZRbnlv?=
 =?utf-8?B?eEt2WUt5YjRsbWdDb0ZQYXFlWjdVbTVObDQyV01wSHIxUlNhRFc4b2pyRGdG?=
 =?utf-8?B?aS9aZXFTS09WQVNtS0liOUVZMlBmb2EwYTROaVBMbU5RSmthRDBGU0JRRUk1?=
 =?utf-8?B?aWJhVERZSXZPYVdnYjRHeURIcCtnVHY4L25YMDMzdk5iYXBJcG5LQ2xJVXFG?=
 =?utf-8?B?aWk3UWpCWVdoT2hpWENlT2I5ZzV5UlltQXh5MWhxV1NXT0lwSGtZZlNObXQy?=
 =?utf-8?B?ekJWU3BET1BDQmdFM095WTFNTzdySnpCdE84RWp5NDI3STdhQkducXpHZTRu?=
 =?utf-8?B?WmNTbkF6ZkhCMzN4UjB1TFBSRXlodzJFQUFhSDVQakViYUNQWjlERjJ3TW5R?=
 =?utf-8?B?QVlnYnc3c0U4dTJqbFYzcUdIdzBGQmJlSzFzeE9wRGZaOW5QVGRKMTBhaTNG?=
 =?utf-8?B?K3ZodVJCWmVrL2VsMFR5cGhQdWRkRjdPU29ndUxqTnFicTlCTER6WHV0QnJ3?=
 =?utf-8?B?WGMrdTlrK0JnUU43dXpQTkJPelpibTdBSTNmTkNYeEU4WHliMTRYMTNrdE9l?=
 =?utf-8?B?eGNWVXYvV0NSTnM1dDhIUEQyODhFQUlvRC9LOEFIZ1ZjSFEzWUk0K1hDYTdy?=
 =?utf-8?B?TUVIamFHTGcwZXVzRmZXNk9nUHhOUlZjSFM4TzdHMVhTcDFOMXhqSG9ZUWxm?=
 =?utf-8?B?VGFxeFlUYVJhL3daeEp4YkZhYXZWSXFMN0pMSGs3YWxSczV5OVhMQml5WDlo?=
 =?utf-8?B?UGtnaVBJbmZUdnpEVWlkeXdOVE00L3duR1FQOUVBbkhrS2N6RHA3M0lUaFZY?=
 =?utf-8?B?d1JHaTdtNzlVelV3dDhQQUxJUERnbnZZTlZIVlJPN0VRd0lVSVZlMXRBVXJt?=
 =?utf-8?B?bDZKLzcwMVJzYUFDQ1R3YVRDS2FKWGFIc200SEt2c0szWGNzR0lxek9lQzBV?=
 =?utf-8?B?OC9KSTkvTThGbVRHOC9LY0VMTkM1T3ZqNGx4enNCMHRrQmFaS3JTMWczWGRx?=
 =?utf-8?B?di8xc2FEZlJ3WC9MemVZZ2YweEh0NjRzK3M1ck11dHB6cm9NOWNVMGU0Q09V?=
 =?utf-8?B?c3MyeFZtTStVMy85cjNrY0w2bFJGNFQ4R0dyVXVFcHVwOTgrWEgxQXphbjM1?=
 =?utf-8?B?bkRIdzVha281QXNMbHlGaGN3MlZmUlNuRThiVFVxMHFObldXR2NZVXY0cTFJ?=
 =?utf-8?B?TlFDM1FXTXRHcVd1UzRiaEgvNXNBL1U1RGlnU2J4S1Y1SFJhZGhkMFZJaGRj?=
 =?utf-8?B?eExpWm03WjVWcG9iT0VZYjg2L3A4SXppRzZScjlObE1Xc292TStiRk1jbTh6?=
 =?utf-8?B?SVdMQWphd2gwcVlJYnVOaTRQZUdWeWtaQ05NU2FhQXdOalMzcXFObHlwcDgz?=
 =?utf-8?B?VE54SFEzQmxPa1gxZHdTY2FkQWtVUHZUMmVSekNKTEExcHJqR3JEU1ZPejAr?=
 =?utf-8?B?ZHNnT1NOaTRmR0crcG5GTTFtRUdQRzlrenlXZkcwUFFDTi82QnVlMG93YWMw?=
 =?utf-8?B?UVdHMkFRN2JqdmNFeUYxZmMvMDI3czR0R2h5RGZMVjhzVEZmaTd0S1BWM3ZK?=
 =?utf-8?B?Rk95S3o3R0ZnRXBFRElMclM3SzBQU3NrM2VtbStOdS9QamVodzlyUjFHc0xE?=
 =?utf-8?B?YXlmNzFpVytwT3I5cGswWXpTclZFWk1NMlZaQk1DNElxLzMyM1ZqT1JZS3h0?=
 =?utf-8?B?U0JNSGZ2RHFxS1ZtYWo2bmNscDg2eWtVYTV4OUlzek9ndkFuUk50YUZFRWFN?=
 =?utf-8?B?VVBkemw5bk0zanVEMFdaMmdGOG1RNXZBU0NkTnRUdzFQMFliZDdHTGRDOXU1?=
 =?utf-8?B?ZG5vRml0RiszWWZFNitxbjZNb0x3eEk1ZFJwZkRVZVRWcmlNMWIrcHM4R1I4?=
 =?utf-8?Q?fBNi4chR6njcX5QF9CFDIZI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0750DF964E958546B6207221BF90F3A6@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ff32e4ed-57fa-4bb1-422f-08da86a22d30
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 14:00:32.6682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KtXuQiZT+NOj3Asy/xjPMfw8eVI+VUsrK5JjRYvDEjcrt90T70/ngbDw5WrBx6otn/iWd8tBvOm/dZiF9J0NwZ+0adjdeLvzOrRIlUn8axM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2831
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDI1LzA4LzIwMjIgw6AgMTU6MzYsIExpbnVzIFdhbGxlaWogYSDDqWNyaXTCoDoNCj4g
T24gVGh1LCBBdWcgMTgsIDIwMjIgYXQgMjo0NiBQTSBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRi
LmRlPiB3cm90ZToNCj4+IE9uIFRodSwgQXVnIDE4LCAyMDIyIGF0IDI6MjUgUE0gTGludXMgV2Fs
bGVpaiA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPiB3cm90ZToNCj4gDQo+Pj4gZ2l0IGdyZXAg
J2Jhc2UgPSAtMScgeWllbGRzIHRoZXNlIHN1c3BlY3RzOg0KPj4+DQo+Pj4gYXJjaC9hcm0vY29t
bW9uL3NhMTExMS5jOiAgICAgICBzYWNoaXAtPmdjLmJhc2UgPSAtMTsNCj4+PiBhcmNoL2FybS9j
b21tb24vc2Nvb3AuYzogICAgICAgIGRldnB0ci0+Z3Bpby5iYXNlID0gLTE7DQo+Pj4gYXJjaC9w
b3dlcnBjL3BsYXRmb3Jtcy81Mnh4L21wYzUyeHhfZ3B0LmM6ICAgICAgZ3B0LT5nYy5iYXNlID0g
LTE7DQo+Pj4gYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy84M3h4L21jdV9tcGM4MzQ5ZW1pdHguYzog
Z2MtPmJhc2UgPSAtMTsNCj4+Pg0KPj4+IFRoYXQncyBhbGwhIFdlIGNvdWxkIGp1c3QgY2FsY3Vs
YXRlIHRoZXNlIHRvIDUxMi1uZ3Bpb3MgYW5kDQo+Pj4gaGFyZGNvZGUgdGhhdCBpbnN0ZWFkLg0K
Pj4NCj4+IEhvdyBkbyB0aGUgY29uc3VtZXJzIGZpbmQgdGhlIG51bWJlcnMgZm9yIHRoZXNlIGZv
dXI/DQo+IA0KPiBGb3IgU0ExMTExIHRoZSBjaGlwIGdldHMgbmFtZWQgInNhMTExMSIgYW5kIHNv
bWUgY29uc3VtZXJzIGFjdHVhbGx5DQo+IHVzZSBwcm9wZXIgbWFjaGluZSBkZXNjcmlwdGlvbnMs
IG1heWJlIGFsbD8NCj4gDQo+IGFyY2gvYXJtL21hY2gtc2ExMTAwL2pvcm5hZGE3MjAuYzogICAg
ICAgICAgICAgIEdQSU9fTE9PS1VQKCJzYTExMTEiLA0KPiAwLCAiczAtcG93ZXIiLCBHUElPX0FD
VElWRV9ISUdIKSwNCj4gYXJjaC9hcm0vbWFjaC1zYTExMDAvam9ybmFkYTcyMC5jOiAgICAgICAg
ICAgICAgR1BJT19MT09LVVAoInNhMTExMSIsDQo+IDEsICJzMS1wb3dlciIsIEdQSU9fQUNUSVZF
X0hJR0gpLA0KPiAoLi4uKQ0KPiANCj4gRm9yIFNjb29wIGl0IGlzIGNvbmRpdGlvbmFsbHkgb3Zl
cnJpZGRlbiBpbiB0aGUgY29kZS4gSSBndWVzcyBhbHdheXMNCj4gb3ZlcnJpZGRlbi4NCj4gDQo+
IEZvciBwb3dlcnBjIHRoZXNlIHNlZW0gdG8gYmUgdXNpbmcgKG9sZCBidXQgd29ya2luZykgZGV2
aWNlIHRyZWUNCj4gbG9va3Vwcywgc28gc2hvdWxkIG5vdCBiZSBhbiBpc3N1ZS4NCj4gDQo+IFNh
ZGx5IEknbSBub3QgMTAwJSBzdXJlIHRoYXQgdGhlcmUgYXJlIG5vIHJhbmRvbSBoYXJkLWNvZGVk
DQo+IEdQSU8gbnVtYmVycyByZWZlcnJpbmcgdG8gd2hhdGV2ZXIgdGhlIGZyYW1ld29yayBnYXZl
IHRoZW0NCj4gYXQgdGhlIHRpbWUgdGhlIGNvZGUgd2FzIHdyaXR0ZW4gOigNCg0KT24gbXkgUFBD
IGJvYXJkLCB0aGUgb25lIGJlZm9yZSB0aGUgbGFzdCBsb29rcyBzdXNwaWNpb3VzIC4uLi4NCg0K
WyAgICAwLjU3MzI2MV0gZ3BpbyBncGlvY2hpcDA6IHJlZ2lzdGVyZWQgR1BJT3MgNDk2IHRvIDUx
MSBvbiANCi9zb2NAZmYwMDAwMDAvY3BtQDljMC9ncGlvLWNvbnRyb2xsZXJAOTUwDQpbICAgIDAu
NTc3NDYwXSBncGlvIGdwaW9jaGlwMTogcmVnaXN0ZXJlZCBHUElPcyA0NjQgdG8gNDk1IG9uIA0K
L3NvY0BmZjAwMDAwMC9jcG1AOWMwL2dwaW8tY29udHJvbGxlckBhYjgNClsgICAgMC41ODYwMTFd
IGdwaW8gZ3Bpb2NoaXAyOiByZWdpc3RlcmVkIEdQSU9zIDQ0OCB0byA0NjMgb24gDQovc29jQGZm
MDAwMDAwL2NwbUA5YzAvZ3Bpby1jb250cm9sbGVyQDk2MA0KWyAgICAwLjU5MTA1N10gZ3BpbyBn
cGlvY2hpcDM6IHJlZ2lzdGVyZWQgR1BJT3MgNDMyIHRvIDQ0NyBvbiANCi9zb2NAZmYwMDAwMDAv
Y3BtQDljMC9ncGlvLWNvbnRyb2xsZXJAOTcwDQpbICAgIDAuNTk1OTc5XSBncGlvIGdwaW9jaGlw
NDogcmVnaXN0ZXJlZCBHUElPcyA0MDAgdG8gNDMxIG9uIA0KL3NvY0BmZjAwMDAwMC9jcG1AOWMw
L2dwaW8tY29udHJvbGxlckBhYzgNClsgICAgMC42MjkyOTJdIGdwaW9fc3R1Yl9kcnYgZ3Bpb2No
aXA1OiByZWdpc3RlcmVkIEdQSU9zIDM4NCB0byAzOTkgb24gDQovbG9jYWxidXNAZmYwMDAxMDAv
Y3BsZC1jbXBjQDUsMDAwMDAwMC9ncGlvLWNvbnRyb2xsZXJAMg0KWyAgICAwLjYzNjU1Nl0gZ3Bp
b19zdHViX2RydiBncGlvY2hpcDY6IHJlZ2lzdGVyZWQgR1BJT3MgMzY4IHRvIDM4MyBvbiANCi9s
b2NhbGJ1c0BmZjAwMDEwMC9mcGdhLW1ANCwwMDAwMDAwL2dwaW8tY29udHJvbGxlckAwMA0KWyAg
ICAwLjYzOTUwM10gZ3Bpb19zdHViX2RydiBncGlvY2hpcDc6IHJlZ2lzdGVyZWQgR1BJT3MgMzUy
IHRvIDM2NyBvbiANCi9sb2NhbGJ1c0BmZjAwMDEwMC9mcGdhLW1ANCwwMDAwMDAwL2dwaW8tY29u
dHJvbGxlckAwMg0KWyAgICAwLjY0MjQzNF0gZ3Bpb19zdHViX2RydiBncGlvY2hpcDg6IHJlZ2lz
dGVyZWQgR1BJT3MgMzM2IHRvIDM1MSBvbiANCi9sb2NhbGJ1c0BmZjAwMDEwMC9mcGdhLW1ANCww
MDAwMDAwL2dwaW8tY29udHJvbGxlckAwNA0KWyAgICAwLjY0NTI1N10gZ3Bpb19zdHViX2RydiBn
cGlvY2hpcDk6IHJlZ2lzdGVyZWQgR1BJT3MgMzIwIHRvIDMzNSBvbiANCi9sb2NhbGJ1c0BmZjAw
MDEwMC9mcGdhLW1ANCwwMDAwMDAwL2dwaW8tY29udHJvbGxlckAxMA0KWyAgICAwLjY0ODIzMF0g
Z3Bpb19zdHViX2RydiBncGlvY2hpcDEwOiByZWdpc3RlcmVkIEdQSU9zIDMwNCB0byAzMTkgb24g
DQovbG9jYWxidXNAZmYwMDAxMDAvZnBnYS1tQDQsMDAwMDAwMC9ncGlvLWNvbnRyb2xsZXJAMjAN
ClsgICAgMC42NTEwNzBdIGdwaW9fc3R1Yl9kcnYgZ3Bpb2NoaXAxMTogcmVnaXN0ZXJlZCBHUElP
cyAyODggdG8gMzAzIG9uIA0KL2xvY2FsYnVzQGZmMDAwMTAwL2ZwZ2EtbUA0LDAwMDAwMDAvZ3Bp
by1jb250cm9sbGVyQDIyDQpbICAgIDAuNjUzOTg2XSBncGlvX3N0dWJfZHJ2IGdwaW9jaGlwMTI6
IHJlZ2lzdGVyZWQgR1BJT3MgMjcyIHRvIDI4NyBvbiANCi9sb2NhbGJ1c0BmZjAwMDEwMC9mcGdh
LW1ANCwwMDAwMDAwL2dwaW8tY29udHJvbGxlckAyNA0KWyAgICAwLjY1NjgwN10gZ3Bpb19zdHVi
X2RydiBncGlvY2hpcDEzOiByZWdpc3RlcmVkIEdQSU9zIDI1NiB0byAyNzEgb24gDQovbG9jYWxi
dXNAZmYwMDAxMDAvZnBnYS1tQDQsMDAwMDAwMC9ncGlvLWNvbnRyb2xsZXJAMjYNClsgICAgMC42
NTk3NjFdIGdwaW9fc3R1Yl9kcnYgZ3Bpb2NoaXAxNDogcmVnaXN0ZXJlZCBHUElPcyAyNDAgdG8g
MjU1IG9uIA0KL2xvY2FsYnVzQGZmMDAwMTAwL2ZwZ2EtbUA0LDAwMDAwMDAvZ3Bpby1jb250cm9s
bGVyQDI4DQpbICAgIDAuNjYyNjIyXSBncGlvX3N0dWJfZHJ2IGdwaW9jaGlwMTU6IHJlZ2lzdGVy
ZWQgR1BJT3MgMjI0IHRvIDIzOSBvbiANCi9sb2NhbGJ1c0BmZjAwMDEwMC9mcGdhLW1ANCwwMDAw
MDAwL2dwaW8tY29udHJvbGxlckAyQQ0KWyAgICAwLjY2NTQ1NF0gZ3Bpb19zdHViX2RydiBncGlv
Y2hpcDE2OiByZWdpc3RlcmVkIEdQSU9zIDIwOCB0byAyMjMgb24gDQovbG9jYWxidXNAZmYwMDAx
MDAvZnBnYS1tQDQsMDAwMDAwMC9ncGlvLWNvbnRyb2xsZXJAMkMNClsgICAgMC42NzM1NTJdIGdw
aW9fc3R1Yl9kcnYgZ3Bpb2NoaXAxNzogcmVnaXN0ZXJlZCBHUElPcyAxOTIgdG8gMjA3IG9uIA0K
L2xvY2FsYnVzQGZmMDAwMTAwL2ZwZ2EtbUA0LDAwMDAwMDAvZ3Bpby1jb250cm9sbGVyQDMwDQpb
ICAgIDAuNjc3MjgxXSBncGlvX3N0dWJfZHJ2IGdwaW9jaGlwMTg6IHJlZ2lzdGVyZWQgR1BJT3Mg
MTc2IHRvIDE5MSBvbiANCi9sb2NhbGJ1c0BmZjAwMDEwMC9mcGdhLW1ANCwwMDAwMDAwL2dwaW8t
Y29udHJvbGxlckAzMg0KWyAgICAwLjY4MDIzNV0gZ3Bpb19zdHViX2RydiBncGlvY2hpcDE5OiBy
ZWdpc3RlcmVkIEdQSU9zIDE2MCB0byAxNzUgb24gDQovbG9jYWxidXNAZmYwMDAxMDAvZnBnYS1t
QDQsMDAwMDAwMC9ncGlvLWNvbnRyb2xsZXJANDANClsgICAgMC42ODU4NzZdIGdwaW9fc3R1Yl9k
cnYgZ3Bpb2NoaXAyMDogcmVnaXN0ZXJlZCBHUElPcyAxNDQgdG8gMTU5IG9uIA0KL2xvY2FsYnVz
QGZmMDAwMTAwL2ZwZ2EtbUA0LDAwMDAwMDAvZ3Bpby1jb250cm9sbGVyQDQyDQpbICAgIDAuNjk0
NDMxXSBncGlvX3N0dWJfZHJ2IGdwaW9jaGlwMjE6IHJlZ2lzdGVyZWQgR1BJT3MgMTI4IHRvIDE0
MyBvbiANCi9sb2NhbGJ1c0BmZjAwMDEwMC9mcGdhLW1ANCwwMDAwMDAwL2dwaW8tY29udHJvbGxl
ckA0NA0KWyAgICAwLjY5NzI1N10gZ3Bpb19zdHViX2RydiBncGlvY2hpcDIyOiByZWdpc3RlcmVk
IEdQSU9zIDExMiB0byAxMjcgb24gDQovbG9jYWxidXNAZmYwMDAxMDAvZnBnYS1tQDQsMDAwMDAw
MC9ncGlvLWNvbnRyb2xsZXJANTANClsgICAgMC43MDAyMjBdIGdwaW9fc3R1Yl9kcnYgZ3Bpb2No
aXAyMzogcmVnaXN0ZXJlZCBHUElPcyA5NiB0byAxMTEgb24gDQovbG9jYWxidXNAZmYwMDAxMDAv
ZnBnYS1tQDQsMDAwMDAwMC9ncGlvLWNvbnRyb2xsZXJANTINClsgICAgMC43MDMxODNdIGdwaW9f
c3R1Yl9kcnYgZ3Bpb2NoaXAyNDogcmVnaXN0ZXJlZCBHUElPcyA4MCB0byA5NSBvbiANCi9sb2Nh
bGJ1c0BmZjAwMDEwMC9mcGdhLW1ANCwwMDAwMDAwL2dwaW8tY29udHJvbGxlckA1NA0KWyAgICAw
LjcwODIyNl0gZ3Bpb19zdHViX2RydiBncGlvY2hpcDI1OiByZWdpc3RlcmVkIEdQSU9zIDY0IHRv
IDc5IG9uIA0KL2xvY2FsYnVzQGZmMDAwMTAwL2ZwZ2EtbUA0LDAwMDAwMDAvZ3Bpby1jb250cm9s
bGVyQDM0DQpbICAgIDAuNzU2ODE3XSBncGlvIGdwaW9jaGlwMjY6IHJlZ2lzdGVyZWQgR1BJT3Mg
MCB0byAyIG9uIGdlbmVyaWMNClsgICAgNC41MzAzOTddIGdwaW8gZ3Bpb2NoaXAyNzogcmVnaXN0
ZXJlZCBHUElPcyAzNiB0byA2MyBvbiBtYXg3MzAxDQoNCg0KPiANCj4gQW5vdGhlciByZWFzb24g
dGhlIGJhc2UgaXMgYXNzaWduZWQgZnJvbSBhYm92ZSAodXN1YWxseQ0KPiBmcm9tIDUxMiBhbmQg
ZG93bndhcmQpIGlzIHRoYXQgdGhlIHByaW1hcnkgU29DIEdQSU8gdXN1YWxseQ0KPiB3YW50IHRv
IGJlIGF0IGJhc2UgMCBhbmQgdGhlcmUgaXMgbm8gZ3VhcmFudGVlIHRoYXQgaXQgd2lsbA0KPiBn
ZXQgcHJvYmVkIGZpcnN0LiBTbyBoYXJkLWNvZGVkIEdQSU8gYmFzZXMgZ28gZnJvbSAwIC0+IG4N
Cj4gYW5kIGR5bmFtaWNhbGx5IGFsbG9jYXRlZWQgR1BJTyBiYXNlcyBmcm9tIG4gPC0gNTEyLg0K
PiANCj4gVGhlbiB3ZSBob3BlIHRoZXkgZG9uJ3QgbWVldCBhbmQgb3ZlcmxhcCBpbiB0aGUgbWlk
ZGxlLi4uDQo+IA0KPj4+IGFuZCBpbiB0aGF0IGNhc2UgaXQgaXMgYmV0dGVyIHRvIGRlbGV0ZSB0
aGUgdXNlIG9mIHRoaXMgZnVuY3Rpb24NCj4+PiBhbHRvZ2V0aGVyIHNpbmNlIGl0IGNhbiBub3Qg
ZmFpbC4NCj4+DQo+PiBTMzJfTUFYIG1pZ2h0IGJlIGEgYmV0dGVyIHVwcGVyIGJvdW5kLiBUaGF0
IGFsbG93cyB0bw0KPj4ganVzdCBoYXZlIG5vIG51bWJlciBhc3NpZ25lZCB0byBhIGdwaW8gY2hp
cC4gQW55IGRyaXZlcg0KPj4gY29kZSBjYWxsaW5nIGRlc2NfdG9fZ3BpbygpIGNvdWxkIHRoZW4g
Z2V0IGJhY2sgLTENCj4+IG9yIGEgbmVnYXRpdmUgZXJyb3IgY29kZS4NCj4+DQo+PiBNYWtpbmcg
dGhlIG9uZXMgdGhhdCBhcmUgaW52YWxpZCB0b2RheSB2YWxpZCBzb3VuZHMgbGlrZQ0KPj4gYSBz
dGVwIGJhY2t3YXJkcyB0byBtZSBpZiB0aGUgZ29hbCBpcyB0byBzdG9wIHVzaW5nDQo+PiBncGlv
IG51bWJlcnMgYW5kIG1vc3QgY29uc3VtZXJzIG5vIGxvbmdlciBuZWVkIHRoZW0uDQo+IA0KPiBP
SyBJIGdldCBpdC4uLg0KPiANCj4gTm93OiB3aG8gd2FudHMgdG8gd3JpdGUgdGhpcyBwYXRjaD8g
OikNCj4gDQo+IENocmlzdG9waGU/IFdpbGwgeW91IHRha2UgYSBzdGFiIGF0IGl0Pw0KPiANCg0K
DQpXaGljaCBwYXRjaCBzaG91bGQgSSB3cml0ZSA/DQoNCkNocmlzdG9waGU=
