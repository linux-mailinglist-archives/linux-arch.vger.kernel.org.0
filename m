Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B195983D5
	for <lists+linux-arch@lfdr.de>; Thu, 18 Aug 2022 15:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244894AbiHRNLX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Aug 2022 09:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244526AbiHRNLW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Aug 2022 09:11:22 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90052.outbound.protection.outlook.com [40.107.9.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA324057D;
        Thu, 18 Aug 2022 06:11:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYagQeAE7xvCgNVNZCV3GMFYAZ4imMEJwCFrGH0mNgg22kYKo0MeqnPmcfs0icXitp7IVOiC1zwbbHS8dn+jEWnc0SpnpDPXL8SBbtLrW4OsCqVHBAQ1bjawJF1X41sWuLurppYbU9AqATrqHk+aOBiOirjcy4uAPBjccYaZA+Z43bEC75tHjztP35l7q2mWvb4jqvWA0fc8WlL7Zla5uwAUIoRziKuew7SHRpPfMH6GsJP7cCjsklaZEErR6J7pJmnRBc7dCPIU7hUtTcmxjkd6WoZRIVQklvWP/Vc/dnfkRMoD3xSUfLIW2qRQ3QW+JaUelFYoxU+0Mmf8CZi56w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FW40dqe3ED68a8aqMncGYwZ/mhN4/dih82Nw52QB78g=;
 b=Gz3v6bGwfYDArRWIvKOBKk0hhKJyF1QYwtJfX4zGmkLaoim0JY08j8QjYK43tzUFFqd+DtM/kIcW3/izUidrv2P+nTU9y+jl+wlqMI8bPlCoLREsm/idvqAy7Fy6unbqH8ljxl7KGRJWm+otrv9kZ/0WtRMw58S6qNEgOrUHb636Z9sfpZtuSH7Oqf63gUGQE9zZaM9Q2JlbkvFSJ1vt40zsn2uq5JQy4HUbuGSNpx8SlpP6U0ES5BLnGL9UaRsUS13FJtIZFLoqft6MtWDARUMgXMvgK4+SEZk2HoEYSc0fnwL1ZZbxxAErNOqzNDa/X7BgMXU14VP21P8EySf0xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FW40dqe3ED68a8aqMncGYwZ/mhN4/dih82Nw52QB78g=;
 b=KydjFDJ7JQezgJcujGNAyUwC6RyA8Lki/RECMA7KIvhQahOjZlNm5z+wNK0i1swG5HT0hRa6RgjDYDnZ2j5y+DyjXchxpBebM+6XsKG0SMQeun/hB+rwHkyVSF7ZjDmrb9jB/L+utp3373LAAPlvfcst7OvcCJgyyYRCGIxMtduiXbRpHnYeaS2/gDEGPio+U1sJZ1m9H0G/i2oCOid8ydX85RKXN60nauKEMvrfIaIYlPTHk1WN/ThQVko56NiOY3pQhXWjLeo9YnamUPOktJ95m05ZNdFfgOqQuUBQdyQxl3K2cPTT6qmhkhYzuPnTyL356W5CqxuqjAdwSw3kOg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAZP264MB3736.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 18 Aug
 2022 13:11:17 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::888e:a92e:a4ee:ce9e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::888e:a92e:a4ee:ce9e%5]) with mapi id 15.20.5504.028; Thu, 18 Aug 2022
 13:11:17 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
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
Thread-Index: AQHYq9yc0+2EsNg9hki12SrFrcAXy620c0uAgAAEKoCAABfpAIAABZOAgAAOlYCAAAXLgIAABvQA
Date:   Thu, 18 Aug 2022 13:11:16 +0000
Message-ID: <1289c5fd-2600-66ae-919e-3d48885e4f8f@csgroup.eu>
References: <f31b818cf8d682de61c74b133beffcc8a8202478.1660041358.git.christophe.leroy@csgroup.eu>
 <CACRpkdY53c0qXx24Am1TMivXr-MV+fQ8B0CDjtGi6=+2tn4-7A@mail.gmail.com>
 <CAK8P3a1Vh1Uehuin-u5QrTO5qh+t0aK_hA-QZwqc00Db_+MKcw@mail.gmail.com>
 <CACRpkdbhbwBe=jU5prifXCYUXPqULhst0se3ZRH+sWOh9XeoLQ@mail.gmail.com>
 <CAK8P3a0j-54_OkXC7x3NSNaHhwJ+9umNgbpsrPxUB4dwewK63A@mail.gmail.com>
 <CACRpkda0+iy8H0YmyowSDn8RbYgnVbC1k+o5F67inXg4Qb934Q@mail.gmail.com>
 <CAK8P3a0uuJ_z8wmNmQTW_qPNqzz7XoxZdHgqbzmK+ydtjraeHg@mail.gmail.com>
In-Reply-To: <CAK8P3a0uuJ_z8wmNmQTW_qPNqzz7XoxZdHgqbzmK+ydtjraeHg@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a80926c0-daab-48f7-a8f6-08da811b228d
x-ms-traffictypediagnostic: PAZP264MB3736:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Ym9t1ik0lor7De1b3DhGJo/yRKfMwLxq6jL89lbH9PhRIhSLh1KOt6YmYFFIhba4SHxmosg4FSrbMEJ1Q+Kiln0nh1N/dTKsS9uxJ5GLeJTFhZ5wUJ10kvF3OCZjCBVivDK05O1kAeglb6iW2aDsl5xNjpjjgsuVdi7s6Px9DOaItnlJ6Q5GDCNUnKW2VNgCA/6/8UuJRgsIU2Ns20+uQJAFrc5/iRTWJ/5j2C0wWfPtfFXvOyvnwbwN0mXKr/RVin7PqHaiwy1MZflySlmHg3//Saf0Hl9+pGZNlG/lOTHNaq5Q2Sl5QeEFpW4hHJrFez/pCEwobrdS7dI1AzxcG8VESfiAR8N/MJOQTncKl2BaehQLywid0oe93emcAS2kSljJoUjwZMhhR2Hlaq6cmTcTQ+LflB8/cSoLRAFAxjKxfDI0W4PoZmjnr/FKWLqN73A3dToQEABAxkHFhYwBVJw4yHNcFfgx8hX/WDqfBx35EMCZXtedzB98P8ptfvMfdaa0szVGmnC2aYnM2tEiRX+vJutDkzfp77mSR8p0DM7TsaAT7xXiSfpY3xBT5PM0rM1r1kkM6mDE+/N77pyrCJ20qRTpE5zyF2Xn58pabVQGkzTdEMe7tM/ndQrJyjobX32A5YPl8cQM74JPUhqzNNXjPGRrpyXKUQMTuAQpCo0WyDa+pxhfhCstLNuwNQ8jp7tjE7JoHpGoPn5QZXzJESvRK23upiR/Sua8b5vuznSH683qB7TPNLczRWw6bNizL+xhLUVL94sjzCTENIPGjNZi/KeKUwpXf6MmHE6LXZuoQ9lP6SCowsnMwZtCHt3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(366004)(376002)(39850400004)(136003)(110136005)(6512007)(53546011)(54906003)(31696002)(6506007)(26005)(71200400001)(478600001)(41300700001)(6486002)(2616005)(38070700005)(38100700002)(86362001)(122000001)(186003)(316002)(83380400001)(8936002)(36756003)(7416002)(66946007)(66476007)(66556008)(76116006)(8676002)(5660300002)(4326008)(91956017)(31686004)(2906002)(64756008)(66574015)(44832011)(66446008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dklLb2hxcFpOb2xOcFVmY09PckZpTjF6V1hUdzM1cFNOUVhnNUMrNG94QkFp?=
 =?utf-8?B?YWVQclkrSVhxR0VLQkxTYWVRd0xvOC9oSjNvYWxkU2h4N01VM3ZnUHZFWG1l?=
 =?utf-8?B?bkh4bkE3U0hnbmo2bXRla3lkNk04VEZTNUhUWmdxNUd4RjJ3THlTM010VHdp?=
 =?utf-8?B?Vk9ETVhMV0p4UjdtNUc2K3YvaGhyTVd3aWZONU5xdmZTTElSZmdpWmZWNGpP?=
 =?utf-8?B?TzY1RnJSUDBHK1NuMVUxS1FtVzVtQk9uaHd4ek5NTXVWNVY4OWlFNWFvNDFM?=
 =?utf-8?B?eURRQmNrVERXRGFuR0RiWTNtTCt4VVFtY2FxeW56dDVmSE9BS0xSUXZnbHlN?=
 =?utf-8?B?L1oxZHZNdTA5L2FVcFNCRjJpUjN3cHJwRitrUWd4TGFxRFBmZDlYNlBEZ3BJ?=
 =?utf-8?B?TDh1QnBVZmdRK3pXUU1KQnBWNFhHRUV5M2pNTDlJcU1LNEZuVW5DaXlCaVIw?=
 =?utf-8?B?UHp3ZjVLMGZJTzQwdENQcVVmOHhGNDRrMytMclRpT3cxYzAxQ2hPeUd2MkVL?=
 =?utf-8?B?cjlJbk8rOFhvKzdsRGd6Q2ozYWQyalpFZFdhRk5GZ0VJTVJKaEpiMU9VVnNJ?=
 =?utf-8?B?MjlsVUlSYVZRTnBncTU2S1ptTjJsM1U3WTArYUJiT01zRHl3R1luWGFPWDhU?=
 =?utf-8?B?a0hvNE1LQ0pHR0pFWGVtcUJDUkNVY2hhWUFwRTN6VUNmTXRpbzBqQTFlTDVI?=
 =?utf-8?B?TndPdXNxNURpZnF6ZlVmb2JoRUhnYXhaSnAvSThjVEk4alArb0Y4c3d0VnFU?=
 =?utf-8?B?K1hGOGZrWEd1MVJhL0l5enNPVWtxWUxGclFsakpmNG9TWnljQmpLVUQ3bW5M?=
 =?utf-8?B?STlvUURwdmQraytUbllNWW51K0hNUmk1V01sNW5kU3h4bUs1S0FPbzVwb0lT?=
 =?utf-8?B?MFo4d2xzWU9BMDAvbkNEc2JqSHRYRlB5THZOV0R3Q2pxMFovY1NWbVFBYjFW?=
 =?utf-8?B?Sm9xdmhFV1FmWDU5UzJtMXBsR2YyYnNtTDIxTXpKSzNjdWNqem8xeEUwUmNR?=
 =?utf-8?B?bnA0VEhQbE5nSWNUMGtSVWh6OUFFL2JzVWJ3YmM0cHdKWkhQVmpFeVBOQ0pq?=
 =?utf-8?B?WmNRVWxwUmpHQnd6R1FFREh6WW0xaDVaakpoM1paWUNzRWF5anNnRjk1Qk8x?=
 =?utf-8?B?WDlnMTBmTjFqQm5oTGxjQ1pJMUNMb0habXplQTJqUnZuUnA3dW5Sak5odXFE?=
 =?utf-8?B?Ujdqc3JEdzhqK3RrOU9abW5QMEdlN251Rkt5MDFVZzRTNm1oM2VYRGsxdzFG?=
 =?utf-8?B?a05UaUEzc2NGcU40NGovMjJnc09PM0F4NHBxSWRSdkFLZ3lBejFvR3puZWwz?=
 =?utf-8?B?eHJsYTB4MDVkMUpQVVhHYzVmVE5MNG5DZjFHVDB5UHk2NlBFSHdXd3JCNXVM?=
 =?utf-8?B?TlY3UnFyTjVyMzN6THBuYldpZnJFWWl3ZXdUeFhwRjh2YXYwbkFEZTkyWXRu?=
 =?utf-8?B?WktQN2ovN2lQQnRFMGV4MzB3ZUNLbFNNV1cvMUY1bGFHN2Y4NENEdjFiQUVv?=
 =?utf-8?B?ZDRpc2ZmMkY4WmhKVlVtQXJqTDVvQUZOZFVlWGY2Z1NFQnA1LzhUMGRlVEV6?=
 =?utf-8?B?L08xZVNMcTYrYitjQTZ1QmEzbDlYVWQzQVZmZ2hpbmxtRS85WVBBZXdPMldS?=
 =?utf-8?B?VTJtRkxJMHBRbXRUeUxHWTZYT2dwNDZpVDRXSGVsZEx4ZkR0d0JLNFpkQk5I?=
 =?utf-8?B?RzlIYmVjdy9BOGdidEs4QVkvSll6WE1QZlJyZHpSSkZBSTA1OTBsK0dNR0dN?=
 =?utf-8?B?bm9EaGk1SWR3M1dzcTJTa1hZNFZnTVR4MnNZTmxDWTc1dlNTT1JJRS93Q1lE?=
 =?utf-8?B?ODFFa0h6R0k5MlVYUStUZzhMMGszRWZObXgyT1NoSmp0N2RTWDdRcVhWU3FW?=
 =?utf-8?B?bG15ZTRNcUU3aVJYVkhreUJFMzhOVXVWM0R0SzBjaTB0bkR4dXNwSXJobWxQ?=
 =?utf-8?B?bExKR0w4RzRyYzFQRFFwNmxza2ZmYkZ4MHVlSkJWRjN6RFpzaDNwSngyVDlN?=
 =?utf-8?B?ZldhTEFVdVA1bkh5REo0ZktiVHVmTStoaWNZYXM4YlpNN1hCNkpFTXR2RXNO?=
 =?utf-8?B?dk84VU9UREFRNnp3b3pudkhtSjdORUxQRVgvY2taZmZvMHhUUktqK3g0OStw?=
 =?utf-8?B?UWtmVUZyaE1sRFVUZUw1SGV5M2Zjc0djZHpGd2hvR01KWDNFMWE5ZU9Ielpi?=
 =?utf-8?B?Q2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2EF242A8DFD4634AA4F0B02F3480931A@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a80926c0-daab-48f7-a8f6-08da811b228d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 13:11:16.9999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tky9QLXSxxBheCgPXPzYsEdk/yqNzMeOGonCWQEJBIWFcqtsd20XjzUNZK9egTAk0LtGTQbveWUSVBnQexKlT1XsJom5kA8TPhos5TtdHIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB3736
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDE4LzA4LzIwMjIgw6AgMTQ6NDYsIEFybmQgQmVyZ21hbm4gYSDDqWNyaXTCoDoNCj4g
T24gVGh1LCBBdWcgMTgsIDIwMjIgYXQgMjoyNSBQTSBMaW51cyBXYWxsZWlqIDxsaW51cy53YWxs
ZWlqQGxpbmFyby5vcmc+IHdyb3RlOg0KPj4gT24gVGh1LCBBdWcgMTgsIDIwMjIgYXQgMTozMyBQ
TSBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPiB3cm90ZToNCj4+PiBPbiBUaHUsIEF1ZyAx
OCwgMjAyMiBhdCAxOjEzIFBNIExpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxlaWpAbGluYXJvLm9y
Zz4gd3JvdGU6DQo+Pj4+IEkgdGhpbmsgdGhlcmUgbWF5IGJlIHN5c3RlbXMgYW5kIHVzZXJzIHRo
YXQgc3RpbGwgZGVwZW5kIG9uIEdQSU8gYmFzZQ0KPj4+PiBudW1iZXJzIGJlaW5nIGFzc2lnbmVk
IGZyb20gQVJDSF9OUl9HUElPUyBhbmQNCj4+Pj4gZG93bndhcmRzICh1c2Vyc3BhY2UgR1BJTyBu
dW1iZXJzIGluIHN5c2ZzIHdpbGwgYWxzbyBjaGFuZ2UuLi4pDQo+Pj4+IG90aGVyd2lzZSB3ZSBj
b3VsZCBhc3NpZ24gZnJvbSAwIGFuZCB1cC4NCj4+Pg0KPj4+IElzIGl0IHBvc3NpYmxlIHRvIGZp
bmQgaW4ta2VybmVsIHVzZXJzIHRoYXQgZGVwZW5kIG9uIHdlbGwta25vd24NCj4+PiBudW1iZXJz
IGZvciBkeW5hbWljYWxseSBhc3NpZ25lZCBncGlvcz8gSSB3b3VsZCBhcmd1ZQ0KPj4+IHRoYXQg
dGhvc2UgYXJlIGFsd2F5cyBicm9rZW4uDQo+Pg0KPj4gTW9zdCBpbi1rZXJuZWwgdXNlcnMgaGFy
ZC1jb2RlIHRoZSBiYXNlIHRvIHNvbWV0aGluZyBsaWtlDQo+PiAwIGV0YyBpdCdzIG9ubHkgdGhl
IG9uZXMgdGhhdCBjb2RlIC0xIGludG8gLmJhc2UgdGhhdCBhcmUgaW4NCj4+IHRyb3VibGUgYmVj
YXVzZSB0aGF0IHdpbGwgYWN0aXZhdGUgZHluYW1pYyBhc3NpZ25tZW50IGZvciB0aGUNCj4+IGJh
c2UuDQo+Pg0KPj4gZ2l0IGdyZXAgJ2Jhc2UgPSAtMScgeWllbGRzIHRoZXNlIHN1c3BlY3RzOg0K
Pj4NCj4+IGFyY2gvYXJtL2NvbW1vbi9zYTExMTEuYzogICAgICAgc2FjaGlwLT5nYy5iYXNlID0g
LTE7DQo+PiBhcmNoL2FybS9jb21tb24vc2Nvb3AuYzogICAgICAgIGRldnB0ci0+Z3Bpby5iYXNl
ID0gLTE7DQo+PiBhcmNoL3Bvd2VycGMvcGxhdGZvcm1zLzUyeHgvbXBjNTJ4eF9ncHQuYzogICAg
ICBncHQtPmdjLmJhc2UgPSAtMTsNCj4+IGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvODN4eC9tY3Vf
bXBjODM0OWVtaXR4LmM6IGdjLT5iYXNlID0gLTE7DQo+Pg0KPj4gVGhhdCdzIGFsbCEgV2UgY291
bGQganVzdCBjYWxjdWxhdGUgdGhlc2UgdG8gNTEyLW5ncGlvcyBhbmQNCj4+IGhhcmRjb2RlIHRo
YXQgaW5zdGVhZC4NCj4gDQo+IEhvdyBkbyB0aGUgY29uc3VtZXJzIGZpbmQgdGhlIG51bWJlcnMg
Zm9yIHRoZXNlIGZvdXI/DQo+IA0KPj4+PiBSaWdodCBub3cgdGhlIHNhZmVzdCB3b3VsZCBiZToN
Cj4+Pj4gQXNzaWduIGZyb20gNTEyIGFuZCBkb3dud2FyZHMgdW50aWwgd2UgaGl0IDAgdGhlbiBh
c3NpZ24NCj4+Pj4gZnJvbSBzb21ldGhpbmcgaGlnaCwgbGlrZSBVMzJfTUFYIGFuZCBkb3dud2Fy
ZC4NCj4+Pj4NCj4+Pj4gVGhhdCByZXF1aXJlcyBkcm9wcGluZyBncGlvX2lzX3ZhbGlkKCkgZXZl
cnl3aGVyZS4NCj4+Pj4NCj4+Pj4gSWYgd2Ugd2FubmEgYmUgYm9sZCwganVzdCBkZWxldGUgZ3Bp
b19pc192YWxpZCgpIGFuZCBhc3NpZ24NCj4+Pj4gYmFzZXMgZnJvbSAwIGFuZCBzZWUgd2hhdCBo
YXBwZW5zLiBCdXQgSSB0aGluayB0aGF0IHdpbGwNCj4+Pj4gbGVhZCB0byByZWdyZXNzaW9ucy4N
Cj4+Pg0KPj4+IEknbSBzdGlsbCB1bnN1cmUgaG93IHJlbW92aW5nIGdwaW9faXNfdmFsaWQoKSB3
b3VsZCBoZWxwLg0KPj4NCj4+IElmIHdlIGFsbG93IEdQSU8gYmFzZSBhbGwgdGhlIHdheSB0byBV
MzJfTUFYDQo+PiB0aGlzIGZ1bmN0aW9uIGJlY29tZXM6DQo+Pg0KPj4gc3RhdGljIGlubGluZSBi
b29sIGdwaW9faXNfdmFsaWQoaW50IG51bWJlcikNCj4+IHsNCj4+ICAgICAgICAgIHJldHVybiBu
dW1iZXIgPj0gMCAmJiBudW1iZXIgPCBVMzJfTUFYOw0KPj4gfQ0KPj4NCj4+IGFuZCB3ZSBjYW4g
dGhlbiBqdXN0DQo+Pg0KPj4gI2RlZmluZSBncGlvX2lzX3ZhbGlkIHRydWUNCj4+DQo+PiBhbmQg
aW4gdGhhdCBjYXNlIGl0IGlzIGJldHRlciB0byBkZWxldGUgdGhlIHVzZSBvZiB0aGlzIGZ1bmN0
aW9uDQo+PiBhbHRvZ2V0aGVyIHNpbmNlIGl0IGNhbiBub3QgZmFpbC4NCj4gDQo+IFMzMl9NQVgg
bWlnaHQgYmUgYSBiZXR0ZXIgdXBwZXIgYm91bmQuIFRoYXQgYWxsb3dzIHRvDQo+IGp1c3QgaGF2
ZSBubyBudW1iZXIgYXNzaWduZWQgdG8gYSBncGlvIGNoaXAuIEFueSBkcml2ZXINCj4gY29kZSBj
YWxsaW5nIGRlc2NfdG9fZ3BpbygpIGNvdWxkIHRoZW4gZ2V0IGJhY2sgLTENCj4gb3IgYSBuZWdh
dGl2ZSBlcnJvciBjb2RlLg0KPiANCj4gTWFraW5nIHRoZSBvbmVzIHRoYXQgYXJlIGludmFsaWQg
dG9kYXkgdmFsaWQgc291bmRzIGxpa2UNCj4gYSBzdGVwIGJhY2t3YXJkcyB0byBtZSBpZiB0aGUg
Z29hbCBpcyB0byBzdG9wIHVzaW5nDQo+IGdwaW8gbnVtYmVycyBhbmQgbW9zdCBjb25zdW1lcnMg
bm8gbG9uZ2VyIG5lZWQgdGhlbS4NCj4gDQoNCldoYXQgYWJvdXQgR1BJTyBBR0dSRUdBVE9SLCBk
cml2ZXJzL2dwaW8vZ3Bpby1hZ2dyZWdhdG9yLmMNCg0KCWJpdG1hcCA9IGJpdG1hcF9hbGxvYyhB
UkNIX05SX0dQSU9TLCBHRlBfS0VSTkVMKTsNCg0KDQpDaHJpc3RvcGhl
