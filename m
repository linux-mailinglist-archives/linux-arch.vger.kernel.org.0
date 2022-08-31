Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EE95A75CF
	for <lists+linux-arch@lfdr.de>; Wed, 31 Aug 2022 07:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiHaFjs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Aug 2022 01:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiHaFjr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Aug 2022 01:39:47 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120045.outbound.protection.outlook.com [40.107.12.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E48B99F6;
        Tue, 30 Aug 2022 22:39:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOX6EpZtUnWMYTxDhN1NwNjGSb4C12WcSsWfEIRLdaIDlzyHLQgf9i5eFIc5EwUowKUtuWgCBEvg3J599Q1I8CMd/pSYq2cIBkbYNcj9ViqUfNX5JLO6XSyQbfEorKLzZtzUECqvobGqNmHnUWOQOOPMouyT039Yn2+eoAc1xrPcWvn78Etvp559A9GhaoLkkCLcBI8X5Qf/YM3w1lQCLojVFen8CjoPzmHypdcnftsSBKR6xi6DJNfynN86CXEmAgAg5VpLIKGqU13USZ0F5qn8ZoNY/yEKO1gFeqvnwNBUg29nWiZkcch6wG20WUm+yfEEjCvgjdz9ZFjnZ4x1yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0bZ2yAGp51k8nGHReN3js6BV/7yzCJTP4MVT5moiG8=;
 b=Uyo3SSNZUw3HHzS/IPRt6Mwo7JhL4XmxEWtbABwmQU0Y16r8oY8HFvSZZ52eCUvsOS+7/Uz7HZlYo0X6KCq6fCvq/5ndWz6Wn4hb/Bb/oEfWGXo+DHoAdNw15IFA/kp5tEeEtr3VI8vFEviufWJuNlSHEeJHtlWaqHiZfVIOXJ5U1c2LYiKat+5J9Sm55ImRhrp6yrR94uN0Tk10ivUrwM9PSVJdCRVTSv0E3oVPR0QDpkikhM+16IXixIUuHNU0JvUuujejqUi64bvGqDFcvUFx8SZ8+zmygQv7dBI/tXT4M4iYX5eCVWZuKbxx7B5gLIasvHrzfh8RvUey8Jzg6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0bZ2yAGp51k8nGHReN3js6BV/7yzCJTP4MVT5moiG8=;
 b=Br0Sd4ls+KFChP6H+XCal7rHSuN05ruvST/EzkHZsX33OFGWhrCC+/bM18HnwznLHUST+L3DKD9gGrkirEvclKkSMse+vaPoDdaaJIRRSWJ1fYoCEOwEUzn27Rh6y+6o+QTicowcsnccdoZCHkKW4DohR9H62JdyOPJkMq9MCWKPxI8RkPltowf0ChF0knETNMGul9a9dGnhuf2sCQ7qDsQwduZ4qZRpp6oOjijit0h0ePHPo0vqUxDzEbFxjOsnCbQn2PwxvR/6nElUKB7ebDkHm420oFuVHsPGBj2A9lv3jDt/o6v7Lr/CEvdtaTrOR1C9tQQaF3bDm/+qYOaUoA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB4258.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:27::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 05:39:41 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8%4]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 05:39:41 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Keerthy <j-keerthy@ti.com>, Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
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
Subject: Re: [PATCH v1 3/8] gpiolib: Warn on drivers still using static
 gpiobase allocation
Thread-Topic: [PATCH v1 3/8] gpiolib: Warn on drivers still using static
 gpiobase allocation
Thread-Index: AQHYu8KbMU3zGFPEjkivUBYIE3z1O63H4r6AgACd3IA=
Date:   Wed, 31 Aug 2022 05:39:40 +0000
Message-ID: <22c001c0-1109-5579-7420-2e37707688a9@csgroup.eu>
References: <cover.1661789204.git.christophe.leroy@csgroup.eu>
 <92aaf098d7039fd4040015b07ba1f99daf674f50.1661789204.git.christophe.leroy@csgroup.eu>
 <CAHp75VesQgR9arwnvsBZKwm6-skOJQCc9xex5NZsE8cQG_1CwQ@mail.gmail.com>
In-Reply-To: <CAHp75VesQgR9arwnvsBZKwm6-skOJQCc9xex5NZsE8cQG_1CwQ@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0598020e-28c0-4848-b2c8-08da8b133375
x-ms-traffictypediagnostic: MR1P264MB4258:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DtWr5Aywesys7xFlm53LzOphyxPY3HDZFiMjXqoZYCOU+xhh7hfq/Qwevo5a09fr9Gq86/XhCneNPF3bw/b8+vKzJheGed3nf9Hx8eu33MorulGG7oA/RA2zJyt7oj6Fi1O+sIvudHMbjApYi6LczNJoIXNoRKUQP+FS7FtqoqVpd9Azn/0Xkz0Mkic61Vtwl1IjqbHvRCxUP3yKMyxWOc/iHda5nPmkISYMBl9JBN0hKr3eb0jjTu9u3Y+EDawLzUBew5NxA7DXTbvRt2z5HMEnttsIcK1oWNbzWpJ95KSqsrY8/PhZophv0kkoZs4xVV0EBywLmxX3d8kGTXDC0z+tGC2CVDJqMR1w0pDec368qQ+78gLKWrhzB76eku/07PGQ0EbcvqECCd67rUNIcUj5tPWwIuKh0WWkodjQqRnVN0Q3jqdGikJIRT89ICWitKMLfOkkBElZQkmKw0U76b8L6CUMGz4nf4E8atxGiGx3ZqvWeeMCno01zGrNBqe06ltTAWUnncwjbB1YBuoMrLjI9/pbLsPtgUdZ29MHoiKxg+n9ifUaAAwhQIfCM4jUHawVzsAH+FpDyz2nSbNx6UN4gI/1hgxu8lhCZBssLslGk7HR3qdDzveewpVjU83bu3rVJGhEzrCTxbCGzlviApL2/VKxS9/ezhp3BNEtvnpAQn+flhMG1mDbgu4BdL94KAGFnf4w3aUdmLW3A5ZLH0o6WBVtBNQLekoYrjMWXxvJbjltNj55Z5pLSDEKnOvmA8Kdahd5netPuGIC2vF7L31F2w5OlBqawnfYSMx6kwz1hWuwf+ptv7gMJ2w498KqJa2VIAxtmglwxUpP/LEyDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(396003)(376002)(346002)(136003)(366004)(478600001)(6486002)(71200400001)(66476007)(76116006)(8676002)(64756008)(4326008)(66556008)(66446008)(66946007)(91956017)(316002)(6916009)(54906003)(38070700005)(186003)(2616005)(66574015)(83380400001)(6506007)(38100700002)(53546011)(41300700001)(122000001)(6512007)(26005)(7416002)(5660300002)(31696002)(44832011)(8936002)(2906002)(4744005)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUVoV3ZOekJCZ1Y2VDBZRGtyanpMUlJFSTQ5Tmt5VVYvRWh3bjZGNXR2ckpE?=
 =?utf-8?B?cHB6dk5qUDFwdGQzOGdPZ2JVbmlrUGt6MFQrU2VaMjVHcDB3bEt3VGNEMUwx?=
 =?utf-8?B?bk0vOXlvdkt5SG1qd0hqMHM1dFRydTZycU1zWlVGaEhZZVBnVThEYnhnOTUz?=
 =?utf-8?B?eDgrTHN2b3ZPSlZuQ2FrMzVqUHh5enArbk5KSWhrcFlkZnlxN09zejhoOEtL?=
 =?utf-8?B?UkJtaklzc3RqZmF4WjhYOU5KQm5KNkRHOVJjaDBsZE1SRC9ZTUxBaXlkTmVz?=
 =?utf-8?B?K0ZxdlpWMVlOd0dmcHRYMnQ3MFdMaDNlNlBuYmU2K3dOZkpjdDRaZXVDMXV3?=
 =?utf-8?B?NHhFZklKRTRRL1c3MXdPTGhvYTEzTHFyUDNtUG5vTnBFaXphTTBzVVZwbHk3?=
 =?utf-8?B?TlVLV2ZnaHFRTXBqOEFHdlN1aWpGOFd0anY4RTJ2Vjh6MUxKMXlmSFE1MmNG?=
 =?utf-8?B?WTNka0ZVMjRhMGJsd0QrbzdXbEJvd2pMZyt6REl3WDBjZmRKQWpGT3VOemti?=
 =?utf-8?B?a3BNOTdVT0ZMUjBSZnB4QU50ZnlRYThwcXhTajA1eWVXR2h3TXREM1hjRmQx?=
 =?utf-8?B?blZja3J5TVBvMlpRTUtjakV3VHYrcCtJTjVPUmUvL1MwNFN2UzNwOVhWZlhU?=
 =?utf-8?B?cmVGRlEwWmhkZkdkanB3ejF3UUx1S1NWcnN2QmdramRiVkdPY3BOaEdPQSsz?=
 =?utf-8?B?ZkRyY09OOXN0TmRsVXpXdHBhZVdzelpCalFKQ2NBOUFrSnFFZEc2UGgvVG9P?=
 =?utf-8?B?VGdDaVNpTm1yVldmcWxRWTZkc0hUdnlOai9vdzhZZXZLUUdiUGlXai9KVUpX?=
 =?utf-8?B?bVpPVk9Zc1M1UnorZndwQkFFMXR3NmliV2VJcVI4TVpjYnpvcEg4UzFsaC9a?=
 =?utf-8?B?eW5FcytuWkpPTGVxSEFzS3BrcXJtVEtwbUxTNjg1Rnhabm9vd1U0LzgrenBL?=
 =?utf-8?B?dXBHS3V0L1U3WVZNd0c2Q1JTeHh2OWFoenRwcGVJWnNXdjJyYW1MRk0rZlBw?=
 =?utf-8?B?ZVYycEdJLzNMdzEvYyt1bTRSS1BEUm10ZUw3dGF3ckNxS3o1UTJ3bkFiMTlt?=
 =?utf-8?B?eXBYbjVWTGx6Nng5OEVaUEhLQXpOMHlKL0JKNDIxNjgyRFV0K1VVMU0rRjc4?=
 =?utf-8?B?QW9RSkp2SzlvbXdOOGJ5QWJBWTd6Z3UvK0FjckpRN0tLQWsyQ2JzMis0bWNX?=
 =?utf-8?B?VGs1NmhNbTNHSDNPdEJhYlNpanpqZVVuem8wbEQvbTkvVUREU2ZqbG9BQjV4?=
 =?utf-8?B?MEZMVG10UGlQNTVaSWlkMXFaVHhhRnlJMWtoMU5LMlZDSmNUc003QmNUcURt?=
 =?utf-8?B?R3Q2TWZZckxEeXFVNzBQL3FLR1VZWGF4b2RBN1BBQWpFTU9TSkd5VkJXUmov?=
 =?utf-8?B?aU16K29yYng1TEJkK05Kd3B3cWMxbzNMeSsvaW5xV1VpSnpWVFlDRGw5VmYv?=
 =?utf-8?B?WktMWnVmWUtkWDdWREIwRGc1N2w3YVhEQ0pkeG5wYzFnajJQaHd1cmVCWGlB?=
 =?utf-8?B?UHRaSTJ1Wmx0UU1Sdm8wSGUrbTRwUDdyWUhrUkl5aHAvVFJZNUlHNm91TWQ4?=
 =?utf-8?B?VXhUcXdhcEl1REJYbDgyUXRFN3hFT3ZKcnFIV2E0ZUVvKytkbUlRSGJWcGYr?=
 =?utf-8?B?d3RIM3ZzcXpuN3BIbjRzUnFIYVBPVHlETU5NMTMwVTNJOCtjZ0VVWEZkRVBz?=
 =?utf-8?B?aUtxOW1NZmhSTndNeDJWUGlZc2RVN1RreGJGUVlFc1h4UGFsRko5QUZ5TEhi?=
 =?utf-8?B?MHpDWU1HZGptS0prQVJXYnZCN2w5S2M4U2JqS3REdjI2SWMzd1pEbXVwbmtS?=
 =?utf-8?B?dWtFaUo4WFMyTDVNNVJlTXJBY3FCcGxTTFRXdW9URzRVVFZZNTJJL3dVSHhx?=
 =?utf-8?B?T2RTaFdVVDdFM3Z2R0tFK3pYeDlmVjUyK3BERzloc1hjeFIzYWtvWmx6V1pQ?=
 =?utf-8?B?ZXZLbE13dGV2R3JKL0pneXNIU253WUFQa3pXZlVwVWY0SkJmZDNSOU5GemtO?=
 =?utf-8?B?MGN1b1IvZWdORzFTbHNESm5wRGdMZHRrcmR0SzZrQzlvb3dpVzlBa281ekVi?=
 =?utf-8?B?U2l3SUs4c05INGVKV08xMHppVzJBbHUyM1hHblpVREtGR1BlekwwS2pidWZ6?=
 =?utf-8?B?Z0tYQzZuWnJ5dDRuTHlQSGowK2Z4N1I5MldtL09wa0dFclRwdVRSU2VQYXFP?=
 =?utf-8?B?T1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E23C35932F9E546899A3C821229686A@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0598020e-28c0-4848-b2c8-08da8b133375
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 05:39:40.9868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OXhUhghcNx8A8BOEvc5DqKNirYYPxEJmh3COs9GGk2nKXCPQ/oSZeJ3xvSklwZOfxacJ8BlZIA3VR+735+JXaUJZei0hEn/HBTy0fpDZovE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB4258
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDMwLzA4LzIwMjIgw6AgMjI6MTQsIEFuZHkgU2hldmNoZW5rbyBhIMOpY3JpdMKgOg0K
PiBPbiBNb24sIEF1ZyAyOSwgMjAyMiBhdCA3OjE4IFBNIENocmlzdG9waGUgTGVyb3kNCj4gPGNo
cmlzdG9waGUubGVyb3lAY3Nncm91cC5ldT4gd3JvdGU6DQo+Pg0KPj4gSW4gdGhlIHByZXBhcmF0
aW9uIG9mIGdldHRpbmcgY29tcGxldGVseSByaWQgb2Ygc3RhdGljIGdwaW9iYXNlDQo+PiBhbGxv
Y2F0aW9uIGluIHRoZSBmdXR1cmUsIGVtaXQgYSB3YXJuaW5nIGluIGRyaXZlcnMgc3RpbGwgZG9p
bmcgc28uDQo+IA0KPiAuLi4NCj4gDQo+PiArICAgICAgICAgICAgICAgZGV2X3dhcm4oJmdkZXYt
PmRldiwgIlN0YXRpYyBhbGxvY2F0aW9uIG9mIEdQSU8gYmFzZSBpcyAiDQo+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgImRlcHJlY2F0ZWQsIHVzZSBkeW5hbWljIGFsbG9j
YXRpb24uIik7DQo+IA0KPiBGaXJzdCBvZiBhbGwsIGRvIG5vdCBzcGxpdCBzdHJpbmcgbGl0ZXJh
bHMuIFNlY29uZCwgeW91IGZvcmdvdCAnXG4nLg0KPiANCg0KVGhlbiBJIGdldCBhIGxpbmUgbG9u
Z2VyIHRoYW4gMTAwIGNoYXJzLCBpcyB0aGF0IGFjY2VwdGFibGUgPw0KDQpTaW5jZSBjb21taXQg
NWZkMjlkNmNjYmM5ICgicHJpbnRrOiBjbGVhbiB1cCBoYW5kbGluZyBvZiBsb2ctbGV2ZWxzIGFu
ZCANCm5ld2xpbmVzIiksICJcbiIgYXJlIGp1c3QgdmlzdWFsIHBvbGx1dGlvbiwgYXJlbid0IHRo
ZXkgPw0KDQpDaHJpc3RvcGhl
