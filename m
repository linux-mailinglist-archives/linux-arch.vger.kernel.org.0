Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B39FD13D03A
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jan 2020 23:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbgAOWlp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jan 2020 17:41:45 -0500
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:35772 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729418AbgAOWlp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Jan 2020 17:41:45 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 34953C0525;
        Wed, 15 Jan 2020 22:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1579128103; bh=6kaU6BnLDw7i23UTFvJ15v96LtaiTPFv2YflCOwPu4s=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Izmj4Z8tDwXYr97YjfSMzWJQW8JEYstDPNCwqrfxtrW39jKD4UiP8JMubd/FlMPx5
         b5SQ8YkB+byrESE+9zOpmBRR4fqdxLb6H+Sv+ytKe4B2Ro9jWm3Bo1pjzaKxe0K2X9
         nhVfczOa6uu78G7DeP++sE5POvibDDZrETZbo6an9PCjyKM4EnXtza2J3RSSQ2tK0C
         06G8H4tVIcakrY0FUfrYZ98TLzuBtuOjq4uSQCa3KUdwbFh9zBTGA8XoHBY4Yd6pWu
         DbIfi8RYUfE64pnfdB1Tux5p9Sl7LVgH6GWNWWV7FJmm2YJr6qbgicez+4I/uoe+1c
         LDFl1r4rMOj6Q==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id E837BA0067;
        Wed, 15 Jan 2020 22:41:36 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 15 Jan 2020 14:41:22 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 15 Jan 2020 14:41:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PG18A0WB1savvhYx8DZto+PSatuzsvvpIv60dc8wx5Iiu0F1zE41sX4JYE3zE7CcTs2gCt5WS0cRE9AMz1lj9fR3pdTMB1JuVKQylbzvvYFOZEhNayaEfYzk+Z6i0z0fA97EwHmICASP2FYnOuT3XZbNvSxLFcMq/WMskNU9SsTjVKcvnC6HllO/Y3sDIhrgXmmbtKitRfJcCb9xA6WrNjh099jlsiCRmHv8sEQVavs23WEH8drWeNx5CyRdDkSRgwzOgUCLM5UrQ8u2nTcEcX5KY4ydN7qXZvI2EHmwXahiGP16RasAOpKAkydESX1oFeftxaMGfOPXDbjjdfq43w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kaU6BnLDw7i23UTFvJ15v96LtaiTPFv2YflCOwPu4s=;
 b=YbiMtfVkhUpWKEFjCeHDVLSzaugPvz94w9Vy1QXtWiEcnCDQSOuEN/3ptjfPKTx4eNqe8UJTjNDAUIA3xR7sP2W6EDcD/vuWxVXis5tfTGd5W22CnfQQcVHjJSEW2UyktJy5qfqV5Z5pmL75b7Hi2O47gUXgm5IizmGbqVFRwQODxbaIv9uRYS2+L1qK/xCqkEJNBd06pF41Ul4W7roBc6tTPMKjBCKJQP1iwWe4mKl+1wbuWPo8nrC8J34Ns6edLAIUXrhl08R3SMElxf29e4ib9/M15vG4SEV9nwwrI+Tz1ulpjzstUbrzDHzFeF4na9bAW14S3qhU8ghXKoogeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kaU6BnLDw7i23UTFvJ15v96LtaiTPFv2YflCOwPu4s=;
 b=QrKulU74NsP62eTrvLQvjOqBG/nKhvPUiLkSVZS55AfEzA6gLW1SoduEyETJCer9+4yZUt+OsYGuz/wJN6uispCkrTxXw6Z/2f5HsvJ5ONLpWbDqAwLNXtDYhGzaA7/V6dVSCX4tcwrfRs+0cPc06dd/5cE4lEVC0+QmwAdZVtE=
Received: from BYAPR12MB3592.namprd12.prod.outlook.com (20.178.54.89) by
 BYAPR12MB3176.namprd12.prod.outlook.com (20.179.92.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Wed, 15 Jan 2020 22:41:20 +0000
Received: from BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::39a1:22ee:7030:8333]) by BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::39a1:22ee:7030:8333%6]) with mapi id 15.20.2623.017; Wed, 15 Jan 2020
 22:41:20 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Christian Brauner <christian@brauner.io>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>
Subject: clone3 on ARC (was Re: [PATCH v3 2/2] arch: wire-up clone3() syscall)
Thread-Topic: clone3 on ARC (was Re: [PATCH v3 2/2] arch: wire-up clone3()
 syscall)
Thread-Index: AQHVy/TngCclMbwH00CGms7u4UXAag==
Date:   Wed, 15 Jan 2020 22:41:20 +0000
Message-ID: <a58c8425-83a3-b64c-339a-7e94a72f4bee@synopsys.com>
References: <20190604160944.4058-1-christian@brauner.io>
 <20190604160944.4058-2-christian@brauner.io>
 <CAK8P3a0OfBpx6y4m5uWX-DUg16NoFby5ik-3xCcD+yMrw0tbEw@mail.gmail.com>
 <20190604212930.jaaztvkent32b7d3@brauner.io>
In-Reply-To: <20190604212930.jaaztvkent32b7d3@brauner.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vgupta@synopsys.com; 
x-originating-ip: [149.117.75.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57f91a18-6ee4-421a-95c1-08d79a0c0ab3
x-ms-traffictypediagnostic: BYAPR12MB3176:
x-microsoft-antispam-prvs: <BYAPR12MB31764FAE45B4B67442116A1EB6370@BYAPR12MB3176.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(39860400002)(396003)(189003)(199004)(186003)(31696002)(31686004)(5660300002)(7416002)(6506007)(26005)(71200400001)(110136005)(316002)(36756003)(478600001)(86362001)(4326008)(54906003)(53546011)(64756008)(8936002)(81166006)(66556008)(66946007)(66476007)(8676002)(76116006)(6486002)(6512007)(2906002)(2616005)(81156014)(66446008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR12MB3176;H:BYAPR12MB3592.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rzyKHcHQCSwkcDFNMj42j1MSQ54Xfozr8Cp79Oy55uokY63yJLzt9Xai/exOCGgJwxWyylqtMiqMVix39li3sv05Wg7KeaDvmZ9jeiOIQIogU39Jam9KQxOCA8a4gXFzePBEaz4yIsFPz7O8wDSvmYWAw/HDBaOBg00NwwxRq/bFV9LNB3pd10oEuOWCdBtK/ceIu7X22K9TzZkWomLQZnmT9Yb391U0DUQoyql+3lu9rtVgNNP1S6ZdCeaOfw2lGucpIMEhzhaj4py4EBQ/M+1p7fx1CIZl34q0BblDrY0KmIUJsGrvpqX9wT1YGW0Ik/IIzMzHuSDqCBJ4KTRPOriA0FiDSAmdrbRJ7dk61VUIcxgAugUpyBtSmgdE+AV8BRhnxsuh9DwhbL4prOz9RAVyME+50Rhi8Rr8j2LwulBXswSH7DfmEa0NrB7Ph1D4
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB017E12F10A4D488BE280BF32F60C06@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f91a18-6ee4-421a-95c1-08d79a0c0ab3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 22:41:20.4162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FeYhHoSm3clZwAsCf+R5XoBOu/krrgTXV8zMSaVDqgR2/wVVbJE7UycWLxIUqmFv9tbUqiy3NG1I+PaWrC2e6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3176
X-OriginatorOrg: synopsys.com
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gNi80LzE5IDI6MjkgUE0sIENocmlzdGlhbiBCcmF1bmVyIHdyb3RlOg0KPiBPbiBUdWUsIEp1
biAwNCwgMjAxOSBhdCAwODo0MDowMVBNICswMjAwLCBBcm5kIEJlcmdtYW5uIHdyb3RlOg0KPj4g
T24gVHVlLCBKdW4gNCwgMjAxOSBhdCA2OjA5IFBNIENocmlzdGlhbiBCcmF1bmVyIDxjaHJpc3Rp
YW5AYnJhdW5lci5pbz4gd3JvdGU6DQo+Pj4NCj4+PiBXaXJlIHVwIHRoZSBjbG9uZTMoKSBjYWxs
IG9uIGFsbCBhcmNoZXMgdGhhdCBkb24ndCByZXF1aXJlIGhhbmQtcm9sbGVkDQo+Pj4gYXNzZW1i
bHkuDQo+Pj4NCj4+PiBTb21lIG9mIHRoZSBhcmNoZXMgbG9vayBsaWtlIHRoZXkgbmVlZCBzcGVj
aWFsIGFzc2VtYmx5IG1hc3NhZ2luZyBhbmQgaXQgaXMNCj4+PiBwcm9iYWJseSBzbWFydGVyIGlm
IHRoZSBhcHByb3ByaWF0ZSBhcmNoIG1haW50YWluZXJzIHdvdWxkIGRvIHRoZSBhY3R1YWwNCj4+
PiB3aXJpbmcuIEFyY2hlcyB0aGF0IGFyZSB3aXJlZC11cCBhcmU6DQo+Pj4gLSB4ODZ7XzMyLDY0
fQ0KPj4+IC0gYXJtezY0fQ0KPj4+IC0geHRlbnNhDQo+Pg0KPj4gVGhlIG9uZXMgeW91IGRpZCBs
b29rIGdvb2QgdG8gbWUuIEkgd291bGQgaG9wZSB0aGF0IHdlIGNhbiBkbyBhbGwgb3RoZXINCj4+
IGFyY2hpdGVjdHVyZXMgdGhlIHNhbWUgd2F5LCBldmVuIGlmIHRoZXkgaGF2ZSBzcGVjaWFsIGFz
c2VtYmx5IHdyYXBwZXJzDQo+PiBmb3IgdGhlIG9sZCBjbG9uZSgpLiBUaGUgbW9zdCBpbnRlcmVz
dGluZyBjYXNlcyBhcHBlYXIgdG8gYmUgaWE2NCwgYWxwaGEsDQo+PiBtNjhrIGFuZCBzcGFyYywg
c28gaXQgd291bGQgYmUgZ29vZCBpZiB0aGVpciBtYWludGFpbmVycyBjb3VsZCB0YWtlIGENCj4+
IGxvb2suDQo+IA0KPiBZZXMsIGFncmVlZC4gVGhleSBjYW4gc29ydCB0aGlzIG91dCBldmVuIGFm
dGVyIHRoaXMgbGFuZHMuDQo+IA0KPj4NCj4+IFdoYXQgZG8geW91IHVzZSBmb3IgdGVzdGluZz8g
V291bGQgaXQgYmUgcG9zc2libGUgdG8gb3ZlcnJpZGUgdGhlDQo+PiBpbnRlcm5hbCBjbG9uZSgp
IGZ1bmN0aW9uIGluIGdsaWJjIHdpdGggYW4gTERfUFJFTE9BRCBsaWJyYXJ5DQo+PiB0byBxdWlj
a2x5IHRlc3Qgb25lIG9mIHRoZSBvdGhlciBhcmNoaXRlY3R1cmVzIGZvciByZWdyZXNzaW9ucz8N
Cj4gDQo+IEkgaGF2ZSBhIHRlc3QgcHJvZ3JhbSB0aGF0IGlzIHJhdGhlciBob3JyZW5kb3VzbHkg
dWdseSBhbmQgSSBjb21waWxlZA0KPiBrZXJuZWxzIGZvciB4ODYgYW5kIHRoZSBhcm1zIGFuZCB0
ZXN0ZWQgaW4gcWVtdS4gVGhlIHByb2dyYW0gYmFzaWNhbGx5DQo+IGxvb2tzIGxpa2UgWzFdLg0K
DQpJIGp1c3QgZ290IGFyb3VuZCB0byBmaXhpbmcgdGhpcyBmb3IgQVJDIChwYXRjaCB0byBmb2xs
b3cgYWZ0ZXIgd2Ugc29ydCBvdXQgdGhlDQp0ZXN0aW5nKSBhbmQgd2FzIHRyeWluZyB0byB1c2Ug
dGhlIHRlc3QgY2FzZSBiZWxvdyBmb3IgYSBxdWNpayBhbmQgZGlydHkgc21va2UNCnRlc3QgKHNv
IGV4aXN0aW5nIHRvb2xjaGFpbiBsYWNraW5nIHdpdGggaGVhZGVycyBsYWNraW5nIE5SX2Nsb25l
MyBvciBzdHJ1Y3QNCmNsb25lX2FyZ3MgZXRjKS4gSSBkaWQgaGFjayB0aG9zZSB1cCwgYnV0IHRo
ZW4gc3BvdHRlZCBiZWxvdw0KDQp1YXBpL2xpbnV4L3NjaGVkLmgNCg0KfCAgICBzdHJ1Y3QgY2xv
bmVfYXJncyB7DQp8CV9fYWxpZ25lZF91NjQgZmxhZ3M7DQp8CV9fYWxpZ25lZF91NjQgcGlkZmQ7
DQp8CV9fYWxpZ25lZF91NjQgY2hpbGRfdGlkOw0KfAlfX2FsaWduZWRfdTY0IHBhcmVudF90aWQ7
DQouLg0KLi4NCg0KQXJlIGFsbCBjbG9uZTMgYXJnIGZpZWxkcyBzdXBwb3NlZCB0byBiZSA2NC1i
aXQgd2lkZSwgZXZlbiB0aGluZ3MgbGlrZSBAY2hpbGRfdGlkLA0KQHRscyAuLi4uIHdoaWNoIGFy
ZSB0cmFkaXRpb25hbGx5IEFSQ0ggd29yZCB3aWRlID8NCg0KDQo+IA0KPiBDaHJpc3RpYW4NCj4g
DQo+IFsxXToNCj4gI2RlZmluZSBfR05VX1NPVVJDRQ0KPiAjaW5jbHVkZSA8ZXJyLmg+DQo+ICNp
bmNsdWRlIDxlcnJuby5oPg0KPiAjaW5jbHVkZSA8ZmNudGwuaD4NCj4gI2luY2x1ZGUgPGxpbnV4
L3NjaGVkLmg+DQo+ICNpbmNsdWRlIDxsaW51eC90eXBlcy5oPg0KPiAjaW5jbHVkZSA8c2NoZWQu
aD4NCj4gI2luY2x1ZGUgPHNpZ25hbC5oPg0KPiAjaW5jbHVkZSA8c3RkaW50Lmg+DQo+ICNpbmNs
dWRlIDxzdGRpby5oPg0KPiAjaW5jbHVkZSA8c3RkbGliLmg+DQo+ICNpbmNsdWRlIDxzeXMvbW91
bnQuaD4NCj4gI2luY2x1ZGUgPHN5cy9zb2NrZXQuaD4NCj4gI2luY2x1ZGUgPHN5cy9zdGF0Lmg+
DQo+ICNpbmNsdWRlIDxzeXMvc3lzY2FsbC5oPg0KPiAjaW5jbHVkZSA8c3lzL3N5c21hY3Jvcy5o
Pg0KPiAjaW5jbHVkZSA8c3lzL3R5cGVzLmg+DQo+ICNpbmNsdWRlIDxzeXMvdW4uaD4NCj4gI2lu
Y2x1ZGUgPHN5cy93YWl0Lmg+DQo+ICNpbmNsdWRlIDx1bmlzdGQuaD4NCj4gDQo+IHN0YXRpYyBw
aWRfdCByYXdfY2xvbmUoc3RydWN0IGNsb25lX2FyZ3MgKmFyZ3MpDQo+IHsNCj4gCXJldHVybiBz
eXNjYWxsKF9fTlJfY2xvbmUzLCBhcmdzLCBzaXplb2Yoc3RydWN0IGNsb25lX2FyZ3MpKTsNCj4g
fQ0KPiANCj4gc3RhdGljIHBpZF90IHJhd19jbG9uZV9sZWdhY3koaW50ICpwaWRmZCwgdW5zaWdu
ZWQgaW50IGZsYWdzKQ0KPiB7DQo+IAlyZXR1cm4gc3lzY2FsbChfX05SX2Nsb25lLCBmbGFncywg
MCwgcGlkZmQsIDAsIDApOw0KPiB9DQo+IA0KPiBzdGF0aWMgaW50IHdhaXRfZm9yX3BpZChwaWRf
dCBwaWQpDQo+IHsNCj4gCWludCBzdGF0dXMsIHJldDsNCj4gDQo+IGFnYWluOg0KPiAJcmV0ID0g
d2FpdHBpZChwaWQsICZzdGF0dXMsIDApOw0KPiAJaWYgKHJldCA9PSAtMSkgew0KPiAJCWlmIChl
cnJubyA9PSBFSU5UUikNCj4gCQkJZ290byBhZ2FpbjsNCj4gDQo+IAkJcmV0dXJuIC0xOw0KPiAJ
fQ0KPiANCj4gCWlmIChyZXQgIT0gcGlkKQ0KPiAJCWdvdG8gYWdhaW47DQo+IA0KPiAJaWYgKCFX
SUZFWElURUQoc3RhdHVzKSB8fCBXRVhJVFNUQVRVUyhzdGF0dXMpICE9IDApDQo+IAkJcmV0dXJu
IC0xOw0KPiANCj4gCXJldHVybiAwOw0KPiB9DQo+IA0KPiAjZGVmaW5lIHB0cl90b191NjQocHRy
KSAoKF9fdTY0KSgodWludHB0cl90KShwdHIpKSkNCj4gI2RlZmluZSB1NjRfdG9fcHRyKG4pICgo
dWludHB0cl90KSgoX191NjQpKG4pKSkNCj4gDQo+IGludCBtYWluKGludCBhcmdjLCBjaGFyICph
cmd2W10pDQo+IHsNCj4gCWludCBwaWRmZCA9IC0xOw0KPiAJcGlkX3QgcGFyZW50X3RpZCA9IC0x
LCBwaWQgPSAtMTsNCj4gCXN0cnVjdCBjbG9uZV9hcmdzIGFyZ3MgPSB7MH07DQo+IAlhcmdzLnBh
cmVudF90aWQgPSBwdHJfdG9fdTY0KCZwYXJlbnRfdGlkKTsNCj4gCWFyZ3MucGlkZmQgPSBwdHJf
dG9fdTY0KCZwaWRmZCk7DQo+IAlhcmdzLmZsYWdzID0gQ0xPTkVfUElERkQgfCBDTE9ORV9QQVJF
TlRfU0VUVElEOw0KPiAJYXJncy5leGl0X3NpZ25hbCA9IFNJR0NITEQ7DQo+IA0KPiAJcGlkID0g
cmF3X2Nsb25lKCZhcmdzKTsNCj4gCWlmIChwaWQgPCAwKSB7DQo+IAkJZnByaW50ZihzdGRlcnIs
ICIlcyAtIEZhaWxlZCB0byBjcmVhdGUgbmV3IHByb2Nlc3NcbiIsDQo+IAkJCXN0cmVycm9yKGVy
cm5vKSk7DQo+IAkJZXhpdChFWElUX0ZBSUxVUkUpOw0KPiAJfQ0KPiANCj4gCWlmIChwaWQgPT0g
MCkgew0KPiAJCXByaW50ZigiSSBhbSB0aGUgY2hpbGQgd2l0aCBwaWQgJWRcbiIsIGdldHBpZCgp
KTsNCj4gCQlleGl0KEVYSVRfU1VDQ0VTUyk7DQo+IAl9DQo+IA0KPiAJcHJpbnRmKCJyYXdfY2xv
bmU6IEkgYW0gdGhlIHBhcmVudC4gTXkgY2hpbGQncyBwaWQgaXMgICAlZFxuIiwgcGlkKTsNCj4g
CXByaW50ZigicmF3X2Nsb25lOiBJIGFtIHRoZSBwYXJlbnQuIE15IGNoaWxkJ3MgcGlkZmQgaXMg
JWRcbiIsDQo+IAkgICAgICAgKihpbnQgKilhcmdzLnBpZGZkKTsNCj4gCXByaW50ZigicmF3X2Ns
b25lOiBJIGFtIHRoZSBwYXJlbnQuIE15IGNoaWxkJ3MgcGFyZW5fdGlkIHZhbHVlIGlzICVkXG4i
LA0KPiAJICAgICAgICoocGlkX3QgKilhcmdzLnBhcmVudF90aWQpOw0KPiANCj4gCWlmICh3YWl0
X2Zvcl9waWQocGlkKSkNCj4gCQlleGl0KEVYSVRfRkFJTFVSRSk7DQo+IA0KPiAJaWYgKHBpZCAh
PSAqKHBpZF90ICopYXJncy5wYXJlbnRfdGlkKQ0KPiAJCWV4aXQoRVhJVF9GQUlMVVJFKTsNCj4g
DQo+IAljbG9zZShwaWRmZCk7DQo+IA0KPiAJcHJpbnRmKCJcblxuIik7DQo+IAlwaWRmZCA9IC0x
Ow0KPiAJcGlkID0gcmF3X2Nsb25lX2xlZ2FjeSgmcGlkZmQsIENMT05FX1BJREZEIHwgU0lHQ0hM
RCk7DQo+IAlpZiAocGlkIDwgMCkgew0KPiAJCWZwcmludGYoc3RkZXJyLCAiJXMgLSBGYWlsZWQg
dG8gY3JlYXRlIG5ldyBwcm9jZXNzXG4iLA0KPiAJCQlzdHJlcnJvcihlcnJubykpOw0KPiAJCWV4
aXQoRVhJVF9GQUlMVVJFKTsNCj4gCX0NCj4gDQo+IAlpZiAocGlkID09IDApIHsNCj4gCQlwcmlu
dGYoIkkgYW0gdGhlIGNoaWxkIHdpdGggcGlkICVkXG4iLCBnZXRwaWQoKSk7DQo+IAkJZXhpdChF
WElUX1NVQ0NFU1MpOw0KPiAJfQ0KPiANCj4gCXByaW50ZigicmF3X2Nsb25lX2xlZ2FjeTogSSBh
bSB0aGUgcGFyZW50LiBNeSBjaGlsZCdzIHBpZCBpcyAgICVkXG4iLA0KPiAJICAgICAgIHBpZCk7
DQo+IAlwcmludGYoInJhd19jbG9uZV9sZWdhY3k6IEkgYW0gdGhlIHBhcmVudC4gTXkgY2hpbGQn
cyBwaWRmZCBpcyAlZFxuIiwNCj4gCSAgICAgICBwaWRmZCk7DQo+IA0KPiAJaWYgKHdhaXRfZm9y
X3BpZChwaWQpKQ0KPiAJCWV4aXQoRVhJVF9GQUlMVVJFKTsNCj4gDQo+IAlpZiAocGlkICE9ICoo
cGlkX3QgKilhcmdzLnBhcmVudF90aWQpDQo+IAkJZXhpdChFWElUX0ZBSUxVUkUpOw0KPiANCj4g
CXJldHVybiAwOw0KPiB9DQo+IA0KDQo=
