Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5797D5A3CF4
	for <lists+linux-arch@lfdr.de>; Sun, 28 Aug 2022 11:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiH1JGk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 Aug 2022 05:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiH1JGj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 28 Aug 2022 05:06:39 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90079.outbound.protection.outlook.com [40.107.9.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B1648CAF;
        Sun, 28 Aug 2022 02:06:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVtyHs7aIG+l7jpQ4AYlC6tv2LkItcnvuy1WMEOW/DDyyCqLqvG9Ya8c3oQ07I4jDM/PTqvoQt6DlP1FB6iElh8N2+1VLb2j/RIpQqsC/Z8AyyjO57QikYa2lQYWTD+My7gnGqkB3zdE4YlvMZ26r/cnHjn6HIyMQI0cjl9y02X6mc3y9N6vYU/mktVSLMBrLOcoamFoYhZPeThu1g+QZsAAiy37hKXLa6B/Cf3ohx0Xr0R5lbyiwB9afxZreDTEg72s+NcRJYlgq6kNokSUEA1k3JjFFmqI7/7EMUYjmF7sp81igykqMZVD9iz/+W1sGkUYO7tZEeao/OoGHux52g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDXOeNFgUNFtVedajbO09g5nvsc4IG2aZYSqZtRen8s=;
 b=RSiyz0Oh93/gZbf4SBV2X2BkkQZ11KweXBywFziZT9E91NzZeAyEiOyi7ZZtQaua0Zryh1nbFQFThyG044J4pbeYVzYoyzwMnf1+KxNzhkvxbkEQhvuIH54XxeB5QI5VuZ5CbmeGbCh1UoFyjfdutN1hV7QSPeXbo4bS5b30McFB7Ht/6tkqiQThI1Z2++M+ylTHYwyKqJXdx/eZ4IfZ5eXMKjqIsjGriQaSxvUyLaFE+ViaUowIHPUyDS7P15PSJTZXTIt+SDt45u/xzcJ+7Jin9S0+fBym6yl09frp2cTtbLzdtTP5M5L9pEwP/NPV7qzrioe+tIVfJp3rQk+eMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDXOeNFgUNFtVedajbO09g5nvsc4IG2aZYSqZtRen8s=;
 b=MLP6QR9vuuj1DL7NONbWMnGwT1AR3OOlI5tliopBMEqBidoYgS2uDJb3kgS9xJCjzlYLrzAdEetpj+yNLZl5GMPPmbQKYMUao5SvRRpDaEbk+0iQVWW72yUtGvak3cOwkxqCOrt2eyvHgTWuYgQ291PD7sQsiRAJph71XiqDYVm/06uj5LcDuo5D5RiArPNtshamFp4ml02XhN6M0pLLbnsPoyu/ehmnCR8lB1vW0WQBzRkvVetXZGLvZuMLilTNESvFg0xnJzea1EJPe3vwAJzunRoWI6fLJfZg9ivPWldZOLIBKtcZjoitvqqQfdXQ5i30910hLWtOCAKSdY7Uxw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB1439.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sun, 28 Aug
 2022 09:06:35 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8%4]) with mapi id 15.20.5566.021; Sun, 28 Aug 2022
 09:06:35 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Alexandre Courbot <gnurou@gmail.com>,
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
Thread-Index: AQHYq9yc0+2EsNg9hki12SrFrcAXy620c0uAgAAEKoCAABfpAIAABZOAgAAOlYCAAAXLgIALDnQAgAAGlgCAAY9WgIAAFeqAgABxeACAAk4kAA==
Date:   Sun, 28 Aug 2022 09:06:35 +0000
Message-ID: <515364a9-33a1-fafa-fdce-dc7dbd5bb7fb@csgroup.eu>
References: <f31b818cf8d682de61c74b133beffcc8a8202478.1660041358.git.christophe.leroy@csgroup.eu>
 <CACRpkdY53c0qXx24Am1TMivXr-MV+fQ8B0CDjtGi6=+2tn4-7A@mail.gmail.com>
 <CAK8P3a1Vh1Uehuin-u5QrTO5qh+t0aK_hA-QZwqc00Db_+MKcw@mail.gmail.com>
 <CACRpkdbhbwBe=jU5prifXCYUXPqULhst0se3ZRH+sWOh9XeoLQ@mail.gmail.com>
 <CAK8P3a0j-54_OkXC7x3NSNaHhwJ+9umNgbpsrPxUB4dwewK63A@mail.gmail.com>
 <CACRpkda0+iy8H0YmyowSDn8RbYgnVbC1k+o5F67inXg4Qb934Q@mail.gmail.com>
 <CAK8P3a0uuJ_z8wmNmQTW_qPNqzz7XoxZdHgqbzmK+ydtjraeHg@mail.gmail.com>
 <CACRpkdb5ow4hD3td6agCuKWvuxptm5AV4rsCrcxNStNdXnBzrA@mail.gmail.com>
 <87f2ff4c-3426-201c-df86-2d06d3587a20@csgroup.eu>
 <CACRpkdYizQhiJXzXNHg7TXUVHzhkwXHFN5+e58kH4udGm1ziEA@mail.gmail.com>
 <f76dbc49-526f-6dc7-2ef1-558baea5848b@csgroup.eu>
 <CACRpkdZpwdP+1VitohznqRfhFGcLT2f+sQnmsRWwMBB3bobwAw@mail.gmail.com>
In-Reply-To: <CACRpkdZpwdP+1VitohznqRfhFGcLT2f+sQnmsRWwMBB3bobwAw@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a511c3ee-fcfe-4d2c-b919-08da88d49bb3
x-ms-traffictypediagnostic: PR1P264MB1439:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m73zoFU7C4LVo13ylLtYGaQr5EwnDQFKLfnDuDdh28Px6WwqiFS3AbAkI6ZHAQGGDFh5hWMXVUvt88TYCTwnMq8I4AlGJtuBDqnAwGpZ9S5X/l8pNh1SeAXIou6QJvPzvMu/gFzatfW13agWc2eo73W+A/1If7Pnf1dDkLi1LmGmZ9HQgImDE33qzuO7piEatwyRkwsYf/KyYd7N0HPiH7HpyAqzRdAf3LN41+fJlLQU7Vbet6VpzbL8ILtu8p5e0BBKS5POU4HYKqdtixdA7kh6BMmGsbCcxDLEXRTzm+WwN/j+vTmjciQLL2iGBhUHN6BmrEpnfCyneVO6F8RaOGMQHvVZBGgHevI+rBuYi9wM5bLerMMvxQkA1qZfnD6s91LJJkTfFNOMR72kLzGQSBkusqjhqBl4KCDjR8BCPPQ8G1AjWgydP7jIuEs9WvLlxHeTqEGVQ5m4+DYRm0ruocgT7ewpd1soJ3pLhAeh5pvuTY76e2abR+5W21D9bG3WEOTRx3SLtwKGs74snmgwhYh7ly9GIghfURvu7MLl0lCV+OR7WnppoQygeikMoX3/jyNsQrcPgQ8FOT4VySCccVmOBCBN9mWCsUNXuRzrqP2GKO1bssI2INVedrzwMddv+7u5WHHdUKhMm5w39Vf6xMmH8IbuR6SwOZs49xuYFWgG/+LsSt7nMT07ec9RuxYzwvD3WFJeOyPz96UaM1u+7XWaCQ8KQi+gujJGGFGJNEE0FzNpl+VVzi4JR+bGZ1bLmgCaZpwtQ2e97yKNTt0L91i1A+8FRS4bvNAWDRvRSjcPpSJzxtWRvWHVVSc9FxBO/uEreVTuB7dBEwgE7F57Gw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(39840400004)(346002)(376002)(396003)(64756008)(66446008)(66476007)(54906003)(2906002)(6916009)(66556008)(5660300002)(66946007)(8936002)(8676002)(4326008)(2616005)(91956017)(44832011)(7416002)(76116006)(36756003)(31686004)(316002)(478600001)(6486002)(41300700001)(6506007)(6512007)(26005)(53546011)(86362001)(71200400001)(31696002)(38070700005)(186003)(83380400001)(122000001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ujl1VGtmZkVJSDd3SjJ6N21DSjJTaTBVenhzOHZ3eTlQajUzUHFMamJYUzFa?=
 =?utf-8?B?bkZ2a084S3ZjYzJwaG1ydCtsN2Q0WWRtY2hyVjM1THMrbERlcGJjUmEwTzJp?=
 =?utf-8?B?SUtubjE4b1FYWGIvbXFJeUJwRVZMbm85dkZIOWlBZFN5eS9tcDRMVGF2ZlpJ?=
 =?utf-8?B?RG1ublNOanFXcGhLcDg4MDdWVE13R0pKK3crTERXUFNQaWE2STNMaFFCSm1X?=
 =?utf-8?B?OUpZTjlQRm1TNGlzY1BORlZWZmpWcnQrRExqTWJ1cUZTMkZUYjVONHM1cXJD?=
 =?utf-8?B?eVFkZ005ZjJlSDROcnNtN2VIem9nbTM2anY3cUhYZGFoWFZwR2taUXRUWEsz?=
 =?utf-8?B?UENRUkxLdW1GUEVHK2ZBYWZkT2k1NW53SFBEQVZ6cnhqTTdXMzlqUlJLU1du?=
 =?utf-8?B?eHh4eXpFbXJkM1NXa3R1ZjhpOHlKRTU2QWhlZFY1c1NBL2JOTUtwNjZSSzBW?=
 =?utf-8?B?TGc0UGI4M0dhN09qZ3dXbjg4bzg4Y0VFS2d1VmJweGJsRGtsTmpoc0xkUDBk?=
 =?utf-8?B?NmNzcmlWcGhXUWFWQ0VWaDgwdUg2VUxqTFhOSHh6ejgyRkpIT21admJXMmJG?=
 =?utf-8?B?R1dvekRpS1Q2bUprQjdLbWZPUVVjb2JNdU1wL3lyZTA3UUdodmVTSzEzQ1lT?=
 =?utf-8?B?VEZVNGRneE1uTGY0ZVhQTXBkQUpWcFRaK2NjM0I0eURaMzZTekJqdEczTlVH?=
 =?utf-8?B?UUhyNkJ5VHpzZjZ2Z2JqUjhDYnVLcnBEM1R3L0dRcU1QM2RvcFlGSXJBYmFV?=
 =?utf-8?B?aU5tOUhMcFN4bGFENWtRYzBqVExFQjYwaUIyeE92aWhJZHpRNjAwU1BUUmdj?=
 =?utf-8?B?N0lyU2RDN0JHVFFvem5zaVJUMHUrRFNCL05oeENWNlpQMklzSEV1VGlHU2VI?=
 =?utf-8?B?LzBVZkdhUWxsSW5xSzZHUUFnODhFa1I2OWw2N0duamdnaUlCZ3dDaWNZRk5J?=
 =?utf-8?B?dVdFVlNhODRaNXJESStLOFM2ZEtmR1VUbkFsKzI0UEYzY0d4MlBaY05Od0lZ?=
 =?utf-8?B?cEJxWDhzTnR5NW1LS3RiNTM1Rm1YOGV2Y01RbHpiUVRrdXNGYVR1ZWhSZ0ZQ?=
 =?utf-8?B?VXhIUGh0WVROMFN6MjgzUXFBajkxQmxiRmIzSkFBTU10NUh3SlRkVkc2RTdL?=
 =?utf-8?B?SG55VkxKYkhsZDdGUHlSdS9HRTVuVUY4ODc1YU53MmVtNTJ0VFpEN1lUVWY1?=
 =?utf-8?B?cExIVUtUOTFTZmJHc2RzYTUwRGZuTnFkQnNWK2UvOEdIMXFDOWlKS05oeWQr?=
 =?utf-8?B?OU4vakVMc2ppZFFBazFIOStpUCs1eW90UG1qcEo1Y3d3cDYrT1p0Um1BWGhr?=
 =?utf-8?B?RmMyMjRHaWprb21SWGJMR0JjYVJ4bnVjL3ZIOW9pNjdBMWxNRTFEOWU4RmVT?=
 =?utf-8?B?UUtnQThQTE14K3hGcW1acytlNW1CdDRrZHFSbzZZMEJSUUJsM0Vvd0tVazFO?=
 =?utf-8?B?Ujh5dS96Y20yUEczaGxjTzRldVhrZ2tXMzl1L3BDNStaVVJXdEFwQXlpMFRR?=
 =?utf-8?B?bmNWWHpLZ01tbkpBL0I4cjdsQ24rUXBYQkhJUUFyMVluZGVldWIxL3BydE1O?=
 =?utf-8?B?aWFDMC9SNi9Yam9OcC9GYVpXSUpYSnRqbHM0WE02Wkx0Z0g3cDhCMDRxNVlo?=
 =?utf-8?B?bitVTE1FT0NJTVVqZ2hhUDdhaitUaTEveE9UcFFubkJMYWRxRTg2akFta3BZ?=
 =?utf-8?B?Q3lPOWZxV2ZzL2l5RDVyMmpmWmNXY2VPVmF3YnlQeGwzc1ZkTXYvb1pXOTk0?=
 =?utf-8?B?Ujl4K1E5M1hSK1VHYkkvT3BTTHp1dzVtb3FxdWxkeFZ2ZTBSZU9KSDUvSldo?=
 =?utf-8?B?WFh2Q2FEc0crT2ZLRURqdUM1bVdFbE9JYnlLbVdSYklTZGc0bmhqOW9QL1l3?=
 =?utf-8?B?aTA0YmFBOEM0eWlJQitxdHJ3eE42MmtiNUlJU2dGUlZoREtBWnNVUEQ4Um5U?=
 =?utf-8?B?RWNjVStDbWZ5dHJybDRXT3RqMHkzbW1jazlKT2tEMHl5UHpoVGZ1aVZGSFVp?=
 =?utf-8?B?TnNCU3hyTW1HdlVWTis5L2lIbXBBWHV4amhEbk05emFDTGRyTzhXaXk3ZmFH?=
 =?utf-8?B?amFFeWhQTXpndGcvYW1oOXB1NXNRckZWb1U4Q25naDZEL1B3WnVLZ0VhTTRL?=
 =?utf-8?B?K0IrWllySFAwOXRyMU9wVXZoaFQ3ellFTkZTUWIrMnBoU0ZhOWxZUVkyanlL?=
 =?utf-8?Q?eOwxmeRLPQAXQGlrO3SPf4A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60F35EF01A62B942AEA27174702FC643@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a511c3ee-fcfe-4d2c-b919-08da88d49bb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2022 09:06:35.2881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nB+bHcE4nVtHE3oZdIFe/SzpXUkwypNQj5gR7s9aQx3nrGI93XNR+vmFj70DNkT0ymLywt4sPYAqwhvyQLNlxIwM1l73gWLm9j73mVwAIgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1439
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDI2LzA4LzIwMjIgw6AgMjM6NTQsIExpbnVzIFdhbGxlaWogYSDDqWNyaXTCoDoNCj4g
T24gRnJpLCBBdWcgMjYsIDIwMjIgYXQgNTowOCBQTSBDaHJpc3RvcGhlIExlcm95DQo+IDxjaHJp
c3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+IHdyb3RlOg0KPj4gTGUgMjYvMDgvMjAyMiDDoCAxNTo0
OSwgTGludXMgV2FsbGVpaiBhIMOpY3JpdCA6DQo+Pj4gT24gVGh1LCBBdWcgMjUsIDIwMjIgYXQg
NDowMCBQTSBDaHJpc3RvcGhlIExlcm95DQo+Pj4gPGNocmlzdG9waGUubGVyb3lAY3Nncm91cC5l
dT4gd3JvdGU6DQo+Pj4NCj4+Pj4+IENocmlzdG9waGU/IFdpbGwgeW91IHRha2UgYSBzdGFiIGF0
IGl0Pw0KPj4+Pg0KPj4+PiBXaGljaCBwYXRjaCBzaG91bGQgSSB3cml0ZSA/DQo+Pj4NCj4+PiBP
bmUgdGhhdCByZW1vdmVzIENPTkZJR19BUkNIX0hBU19OUl9HUElPIGVudGlyZWx5LCB0aGVuDQo+
Pj4gYWxsb2NhdGUgYmFzZXMgZm9yIG5ldyBHUElPIGNoaXBzIGZyb20gMCBhbmQgdXB3YXJkIGlu
c3RlYWQuDQo+Pj4gQW5kIHRoZW4gc2VlIHdoYXQgaGFwcGVucy4NCj4+Pg0KPj4NCj4+IE9rLCBJ
IGNhbiBnaXZlIGl0IGEgdHJ5Lg0KPiANCj4gTmljZSENCj4gDQo+PiBCdXQgd2hhdCBkbyBJIGRv
IHdpdGg6DQo+Pg0KPj4gZHJpdmVycy9ncGlvL2dwaW8tYWdncmVnYXRvci5jOiBiaXRtYXAgPSBi
aXRtYXBfYWxsb2MoQVJDSF9OUl9HUElPUywNCj4+IEdGUF9LRVJORUwpOw0KPiANCj4gVGhhdCdz
IGp1c3QgdXNlZCBsb2NhbGx5IGluIHRoYXQgZHJpdmVyIHRvIGxvb3Agb3ZlciB0aGUgYXJndW1l
bnRzIHRvIHRoZQ0KPiBhZ2dyZWdhdG9yIChmcm9tIHRoZSBmaWxlIGluIHN5c2ZzKS4gSSB3b3Vs
ZCBzZXQgc29tZSBhcmJpdHJhcnkgcm9vdA0KPiBsaWtlDQo+ICNkZWZpbmUgQUdHUkVHQVRPUl9N
QVhfR1BJT1MgNTEyDQo+IGFuZCBqdXN0IHNlYXJjaC9yZXBsYWNlIHdpdGggdGhhdC4NCj4gDQoN
CkFuZCB3aGF0IGFib3V0IGdzdGFfZ3Bpb19zZXR1cCgpIHRoYXQgcmVxdWVzdHMgYmFzZSAwIHdp
dGggdGhlIGZvbGxvd2luZyANCmNvbW1lbnQ6DQoNCgkvKg0KCSAqIEFSQ0hfTlJfR1BJT1MgaXMg
Y3VycmVudGx5IDI1NiBhbmQgZHluYW1pYyBhbGxvY2F0aW9uIHN0YXJ0cw0KCSAqIGZyb20gdGhl
IGVuZC4gSG93ZXZlciwgZm9yIGNvbXBhdGliaWxpdHksIHdlIG5lZWQgdGhlIGZpcnN0DQoJICog
Q29ubmVYdCBkZXZpY2UgdG8gc3RhcnQgZnJvbSBncGlvIDA6IGl0J3MgdGhlIG1haW4gY2hpcHNl
dA0KCSAqIG9uIG1vc3QgYm9hcmRzIHNvIGRvY3VtZW50cyBhbmQgZHJpdmVycyBhc3N1bWUgZ3Bp
bzAuLmdwaW8xMjcNCgkgKi8NCg0KDQpBbmQgSSBndWVzcyB0aGVyZSBtaWdodCBiZSBvdGhlciBk
cml2ZXJzIGxpa2UgdGhhdCAoSSBmb3VuZCB0aGF0IG9uZSANCmJlY2F1c2Ugb2YgaXRzIGNvbW1l
bnQgbWVudGlvbm5pbmcgQVJDSF9OUl9HUElPUy4NCg0KQW5vdGhlciBzb2x1dGlvbiBjb3VsZCBi
ZSB0byBsZWF2ZSBmaXJzdCBHUElPcyBmb3Igc3RhdGljIGFsbG9jYXRpb24sIA0KYW5kIGFsbG9j
YXRlIGR5bmFtaWMgb25lcyBmcm9tIDI1NiBvciBmcm9tIDUxMiA/DQoNCk1heWJlIGluIHR3byBz
dGVwczoNCi0gRmlyc3Qgc3RlcDogQWxsb2NhdGUgZHluYW1pYyBmcm9tIDI1NiB1cHdhcmRzIGFu
ZCBhZGQgYSBwcl93YXJuKCkgZm9yIA0KYWxsIHN0YXRpYyBhbGxvY2F0aW9ucy4NCi0gU2Vjb25k
IHN0ZXAgbGF0ZXI6IEFsbG9jYXRlIGR5bmFtaWMgZnJvbSAwIGFuZCBmb3JiaWQgc3RhdGljIGFs
bG9jYXRpb24uDQoNCkFueSBvcGluaW9uID8NCg0KQ2hyaXN0b3BoZQ==
