Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAE91A707C
	for <lists+linux-arch@lfdr.de>; Tue, 14 Apr 2020 03:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgDNBTO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Apr 2020 21:19:14 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:58028 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728066AbgDNBTN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Apr 2020 21:19:13 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0637BC0086;
        Tue, 14 Apr 2020 01:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1586827152; bh=PtnNdaOntwdHe1x8AQMVgdwjxEA0YmKVoPX/egM36AI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=L40tEEcj8js+c/LfcUuj8oYD6t2NzrdrvodZzEPgqB6JSUsSFFZVYZq7qwRQoeZ8V
         QJmKCw7x3CA2uG+nX2BPZGe1iGRw6nfKyZZLoeyC9Eew2sTwwV0JhBUuuUwPKoZbS1
         o+nOto/jFMuaWrzz8+fxVjAot1DUDIwT1fWOEirk7jEallxL1fW9xSknRO1rPKgtVy
         yECAORCxLLoJwaG6rDpI4o5UT3Zr4ET6dLB0zvTDTtrol1SRNX35fFppI1vEDNzUay
         x70drAXgvIRvowzCS1O6GH+iBXM9qVihHFNID30D5gqbvkvbv7Z59ShWt2k/KcEupX
         5JptU47mUh0Yw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 1FFA8A008A;
        Tue, 14 Apr 2020 01:19:09 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 13 Apr 2020 18:19:09 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 13 Apr 2020 18:19:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dram8n0p9fsEiHJXQ7MJn/y+p1/xQ8mFWoI6UKmWuRCiB4o76edUbEyKw2Z/kQ1pdjdgqkeRlFYyoNkO7CsWo8atGrj/UDksWLq5LHl1SyVQmMjOF00RBASz+ERCK+KHR17ssetGVj1lgfF44XydIc8UGDRVnzoWGLeqwR7SmVbg+DQY11RTAqwgbGrXi11Q8GAoeCJiyUrKGhWtRufC3VPY7qc0nYf+sLD/BOqcsAPOlLJif9bYz6oOywAgZbq1wcpdHQja+5VPcVr84afeDlvsDu8AJC7mO1epS08DF7cY8aDkhf1TyzZCMl/9AFsl6Dk95CGfsZwKrTTzqgP44w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtnNdaOntwdHe1x8AQMVgdwjxEA0YmKVoPX/egM36AI=;
 b=OLYosYi860YW27coSBrN5rIjzR5I9OqI/dtX/dYizIHE6O08sjPYNcREBmM1bfsCAFkuVDpJqFGiY3DCt/DZG/B8pIhp4IQtTnebfGJuKXY9YrIS3cdeDiFr24OxYeoc0RNzAyDzVDC/R1zO4XbqkNtvvruARKIdaUbCtn1hQQZJFg9tQz5Dc7ubrbJflVSvMYf5FNss0iY9OExpCZBt/q/bokIkPJnuoN8vcdSsPja4IWpaXogkuNK8XSvB98tiKSwnu/8DWqm/dBRp/D+55MTP4R0ehPM0KL1rGAYLgdno5ct13YFDnZBVS4VuRFbZZh2dWEm1udENN2qgoZ+JiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtnNdaOntwdHe1x8AQMVgdwjxEA0YmKVoPX/egM36AI=;
 b=iUWJLBuL87yJEKe3aZIlvQ2ioyjA2BTD7A8uMecezjMfamfwh8bhlhgqwpJtH6BGz/vuwUNVP8sZrfONEOBqgHld8D07cm92/uQv3st76Qo5F+vs0wv7akxe/Q6OPwAd/IteKexiAspLNV+i38kbbFx5rVv96keizTlPOoL1igE=
Received: from BYAPR12MB3592.namprd12.prod.outlook.com (2603:10b6:a03:db::25)
 by BYAPR12MB2613.namprd12.prod.outlook.com (2603:10b6:a03:69::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.28; Tue, 14 Apr
 2020 01:19:07 +0000
Received: from BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::a45a:6a41:3fe5:2eb7]) by BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::a45a:6a41:3fe5:2eb7%7]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 01:19:07 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
CC:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
Thread-Topic: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
Thread-Index: AQHWEfqwZ/jjxftyLUC7pQJHdoRBAw==
Date:   Tue, 14 Apr 2020 01:19:06 +0000
Message-ID: <d9b26292-4b40-f282-b1f6-5ee238358f0e@synopsys.com>
References: <1535567633.4465.23.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
 <20180830094411.GX24124@hirez.programming.kicks-ass.net>
 <20180830095148.GB5942@arm.com> <1535629996.4465.44.camel@synopsys.com>
 <20180830141713.GN24082@hirez.programming.kicks-ass.net>
 <20180830142354.GB13005@arm.com>
 <20180830142920.GO24082@hirez.programming.kicks-ass.net>
 <20180830144344.GW24142@hirez.programming.kicks-ass.net>
In-Reply-To: <20180830144344.GW24142@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vgupta@synopsys.com; 
x-originating-ip: [2601:641:c100:83a0:7c06:2fd:ae14:dd9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a8791ee-ab26-413b-57f3-08d7e011d3ec
x-ms-traffictypediagnostic: BYAPR12MB2613:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2613A32DC0F7B058476891A5B6DA0@BYAPR12MB2613.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3592.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(346002)(376002)(396003)(366004)(39860400002)(136003)(6486002)(36756003)(186003)(31686004)(6512007)(478600001)(71200400001)(31696002)(64756008)(66446008)(66556008)(76116006)(81156014)(66946007)(54906003)(8676002)(66476007)(110136005)(6506007)(8936002)(86362001)(4326008)(2906002)(2616005)(5660300002)(316002)(53546011)(41533002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UARJD4GPPkQ65xp2YZluSm5OiNRLu3loQItdibZg/LlYv2Ma1Eg3F3po140zpdNSJ7snJZovh5wUCdArblAK4V3/3QWwa15rHSR4mIRKSOwWSdCt3p9M/0gSFhV0W9E//V99k7gfxsLfILjVIXOTGosJk3OsSCFLmD0ZylitsIlNUgS9KgeWLcAWWCdQNvIxACvFqFWktDn2rg2Z1121YNJ+CbjQd51EC4j0YxnTCdRZX1WKFXK47nGtkfbb2FLWcVyUehOeYH20nd1FbXjDYK7VFQqwRiacNy+q/JQkCwrDaFs2vxdFJWOVDoC3MazSXUwEnznqCLOk9zoC5c5q6HD8nWM7joupP1g4LBdAJwXq/nrkejSRgv3dZqVXnqLJv+NDHUUHWRdnQBa3T9fbYst6hJ5jfYbx50EpXbkvHM0iJhisdXK02VmdwpcPD5eKtMhQLRv0bLYA48AmPtAGI0hjtOzi6QH+b1g9EYa5uJf04Gsx2TLHTc36H1dBwgAp
x-ms-exchange-antispam-messagedata: Z8CqEliFiUJL3sEsnYRPsv44mciXNfc2q/o7cP9SbhuowYTrY82YaEjvuUKHlDb9y0xwboCeNhClqzK5v8/rM0b05bmTwjbeRZ6uHug0zkE23SzQ8lH7jVKgEhmKWt93sTN90o6Q1QhAavdyDPvHE18qMyRL/m9aYd2cstPoVqj55wYwYRCg7SVpgOSVgTJNGdCe1wAIiGMDhccpVwxGZg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1A41C114C659A49A5C62FC67F388E00@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8791ee-ab26-413b-57f3-08d7e011d3ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 01:19:06.8703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YjH0t/sZeR0JTDOCZqAuED7NEGeqSyPo7QU4Veo/YhpCk77It0JEjqvwfKZv4feLkr8AoECQfalnabW2cdyyJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2613
X-OriginatorOrg: synopsys.com
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gOC8zMC8xOCA3OjQzIEFNLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4gT24gVGh1LCBBdWcg
MzAsIDIwMTggYXQgMDQ6Mjk6MjBQTSArMDIwMCwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+DQo+
PiBBbHNvLCBvbmNlIGl0IGFsbCB3b3JrcywgdGhleSBzaG91bGQgbG9vayBhdCBzd2l0Y2hpbmcg
dG8gX3JlbGF4ZWQNCj4+IGF0b21pY3MgZm9yIExML1NDLg0KPiBBIGxpdHRsZSBzb21ldGhpbmcg
bGlrZSBzby4uIHNob3VsZCBzYXZlIGEgZmV3IHNtcF9tYigpLg0KDQpGaW5hbGx5IGdvdCB0byB0
aGlzIC0gdGltZSBmb3Igc29tZSBzcHJpbmcgY2xlYW5pbmcgOy0pDQoNCg0KPiAtLS0NCj4NCj4g
ZGlmZiAtLWdpdCBhL2FyY2gvYXJjL2luY2x1ZGUvYXNtL2F0b21pYy5oIGIvYXJjaC9hcmMvaW5j
bHVkZS9hc20vYXRvbWljLmgNCj4gaW5kZXggNGUwMDcyNzMwMjQxLi43MTRiNTRjMzA4YjAgMTAw
NjQ0DQo+IC0tLSBhL2FyY2gvYXJjL2luY2x1ZGUvYXNtL2F0b21pYy5oDQo+ICsrKyBiL2FyY2gv
YXJjL2luY2x1ZGUvYXNtL2F0b21pYy5oDQo+IEBAIC00NCw3ICs0NCw3IEBAIHN0YXRpYyBpbmxp
bmUgdm9pZCBhdG9taWNfIyNvcChpbnQgaSwgYXRvbWljX3QgKnYpCQkJXA0KPiAgfQkJCQkJCQkJ
CVwNCj4gIA0KPiAgI2RlZmluZSBBVE9NSUNfT1BfUkVUVVJOKG9wLCBjX29wLCBhc21fb3ApCQkJ
CVwNCj4gLXN0YXRpYyBpbmxpbmUgaW50IGF0b21pY18jI29wIyNfcmV0dXJuKGludCBpLCBhdG9t
aWNfdCAqdikJCVwNCj4gK3N0YXRpYyBpbmxpbmUgaW50IGF0b21pY18jI29wIyNfcmV0dXJuX3Jl
bGF4ZWQoaW50IGksIGF0b21pY190ICp2KQlcDQo+ICB7CQkJCQkJCQkJXA0KDQpUaGlzIGJlaW5n
IHJlbGF4ZWQsIHNob3Vkbid0IGl0IGFsc28gcmVtb3ZlIHRoZSBzbXBfbWIoKSBiZWZvcmUgdGhl
IG9wZXJhdGlvbiBhbmQNCmxlYXZlIHRoZSBnZW5lcmljIGNvZGUgdG8gYWRkIG9uZSAvIG1vcmUg
c21wX21iKCkgYXMgYXBwcm9wcmlhdGUgZm9yIGZ1bGx5DQpvcmRlcmVkLCBhY3F1aXJlIGFuZCBy
ZWxlYXNlIHZhcmlhbnRzID8NCg0KPiAgCXVuc2lnbmVkIGludCB2YWw7CQkJCQkJXA0KPiAgCQkJ
CQkJCQkJXA0KPiBAQCAtNjksOCArNjksMTEgQEAgc3RhdGljIGlubGluZSBpbnQgYXRvbWljXyMj
b3AjI19yZXR1cm4oaW50IGksIGF0b21pY190ICp2KQkJXA0KPiAgCXJldHVybiB2YWw7CQkJCQkJ
CVwNCj4gIH0NCj4gIA0KPiArI2RlZmluZSBhdG9taWNfYWRkX3JldHVybl9yZWxheGVkCWF0b21p
Y19hZGRfcmV0dXJuX3JlbGF4ZWQNCj4gKyNkZWZpbmUgYXRvbWljX3N1Yl9yZXR1cm5fcmVsYXhl
ZAlhdG9taWNfc3ViX3JldHVybl9yZWxheGVkDQo+ICsNCj4gICNkZWZpbmUgQVRPTUlDX0ZFVENI
X09QKG9wLCBjX29wLCBhc21fb3ApCQkJCVwNCj4gLXN0YXRpYyBpbmxpbmUgaW50IGF0b21pY19m
ZXRjaF8jI29wKGludCBpLCBhdG9taWNfdCAqdikJCQlcDQo+ICtzdGF0aWMgaW5saW5lIGludCBh
dG9taWNfZmV0Y2hfIyNvcCMjX3JlbGF4ZWQoaW50IGksIGF0b21pY190ICp2KQlcDQo+ICB7CQkJ
CQkJCQkJXA0KPiAgCXVuc2lnbmVkIGludCB2YWwsIG9yaWc7CQkJCQkJXA0KPiAgCQkJCQkJCQkJ
XA0KPiBAQCAtOTYsNiArOTksMTQgQEAgc3RhdGljIGlubGluZSBpbnQgYXRvbWljX2ZldGNoXyMj
b3AoaW50IGksIGF0b21pY190ICp2KQkJCVwNCj4gIAlyZXR1cm4gb3JpZzsJCQkJCQkJXA0KPiAg
fQ0KPiAgDQo+ICsjZGVmaW5lIGF0b21pY19mZXRjaF9hZGRfcmVsYXhlZAlhdG9taWNfZmV0Y2hf
YWRkX3JlbGF4ZWQNCj4gKyNkZWZpbmUgYXRvbWljX2ZldGNoX3N1Yl9yZWxheGVkCWF0b21pY19m
ZXRjaF9zdWJfcmVsYXhlZA0KPiArDQo+ICsjZGVmaW5lIGF0b21pY19mZXRjaF9hbmRfcmVsYXhl
ZAlhdG9taWNfZmV0Y2hfYW5kX3JlbGF4ZWQNCj4gKyNkZWZpbmUgYXRvbWljX2ZldGNoX2FuZG5v
dF9yZWxheGVkCWF0b21pY19mZXRjaF9hbmRub3RfcmVsYXhlZA0KPiArI2RlZmluZSBhdG9taWNf
ZmV0Y2hfb3JfcmVsYXhlZAkJYXRvbWljX2ZldGNoX29yX3JlbGF4ZWQNCj4gKyNkZWZpbmUgYXRv
bWljX2ZldGNoX3hvcl9yZWxheGVkCWF0b21pY19mZXRjaF94b3JfcmVsYXhlZA0KPiArDQo+ICAj
ZWxzZQkvKiAhQ09ORklHX0FSQ19IQVNfTExTQyAqLw0KPiAgDQo+ICAjaWZuZGVmIENPTkZJR19T
TVANCj4gQEAgLTM3OSw3ICszOTAsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgYXRvbWljNjRfIyNv
cChsb25nIGxvbmcgYSwgYXRvbWljNjRfdCAqdikJCVwNCj4gIH0JCQkJCQkJCQlcDQo+ICANCj4g
ICNkZWZpbmUgQVRPTUlDNjRfT1BfUkVUVVJOKG9wLCBvcDEsIG9wMikJCSAgICAgICAgCVwNCj4g
LXN0YXRpYyBpbmxpbmUgbG9uZyBsb25nIGF0b21pYzY0XyMjb3AjI19yZXR1cm4obG9uZyBsb25n
IGEsIGF0b21pYzY0X3QgKnYpCVwNCj4gK3N0YXRpYyBpbmxpbmUgbG9uZyBsb25nIGF0b21pYzY0
XyMjb3AjI19yZXR1cm5fcmVsYXhlZChsb25nIGxvbmcgYSwgYXRvbWljNjRfdCAqdikJXA0KPiAg
ewkJCQkJCQkJCVwNCj4gIAl1bnNpZ25lZCBsb25nIGxvbmcgdmFsOwkJCQkJCVwNCj4gIAkJCQkJ
CQkJCVwNCj4gQEAgLTQwMSw4ICs0MTIsMTEgQEAgc3RhdGljIGlubGluZSBsb25nIGxvbmcgYXRv
bWljNjRfIyNvcCMjX3JldHVybihsb25nIGxvbmcgYSwgYXRvbWljNjRfdCAqdikJXA0KPiAgCXJl
dHVybiB2YWw7CQkJCQkJCVwNCj4gIH0NCj4gIA0KPiArI2RlZmluZSBhdG9taWM2NF9hZGRfcmV0
dXJuX3JlbGF4ZWQJYXRvbWljNjRfYWRkX3JldHVybl9yZWxheGVkDQo+ICsjZGVmaW5lIGF0b21p
YzY0X3N1Yl9yZXR1cm5fcmVsYXhlZAlhdG9taWM2NF9zdWJfcmV0dXJuX3JlbGF4ZWQNCj4gKw0K
PiAgI2RlZmluZSBBVE9NSUM2NF9GRVRDSF9PUChvcCwgb3AxLCBvcDIpCQkgICAgICAgIAkJXA0K
PiAtc3RhdGljIGlubGluZSBsb25nIGxvbmcgYXRvbWljNjRfZmV0Y2hfIyNvcChsb25nIGxvbmcg
YSwgYXRvbWljNjRfdCAqdikJXA0KPiArc3RhdGljIGlubGluZSBsb25nIGxvbmcgYXRvbWljNjRf
ZmV0Y2hfIyNvcCMjX3JlbGF4ZWQobG9uZyBsb25nIGEsIGF0b21pYzY0X3QgKnYpCVwNCj4gIHsJ
CQkJCQkJCQlcDQo+ICAJdW5zaWduZWQgbG9uZyBsb25nIHZhbCwgb3JpZzsJCQkJCVwNCj4gIAkJ
CQkJCQkJCVwNCj4gQEAgLTQyNCw2ICs0MzgsMTQgQEAgc3RhdGljIGlubGluZSBsb25nIGxvbmcg
YXRvbWljNjRfZmV0Y2hfIyNvcChsb25nIGxvbmcgYSwgYXRvbWljNjRfdCAqdikJXA0KPiAgCXJl
dHVybiBvcmlnOwkJCQkJCQlcDQo+ICB9DQo+ICANCj4gKyNkZWZpbmUgYXRvbWljNjRfZmV0Y2hf
YWRkX3JlbGF4ZWQJYXRvbWljNjRfZmV0Y2hfYWRkX3JlbGF4ZWQNCj4gKyNkZWZpbmUgYXRvbWlj
NjRfZmV0Y2hfc3ViX3JlbGF4ZWQJYXRvbWljNjRfZmV0Y2hfc3ViX3JlbGF4ZWQNCj4gKw0KPiAr
I2RlZmluZSBhdG9taWM2NF9mZXRjaF9hbmRfcmVsYXhlZAlhdG9taWM2NF9mZXRjaF9hbmRfcmVs
YXhlZA0KPiArI2RlZmluZSBhdG9taWM2NF9mZXRjaF9hbmRub3RfcmVsYXhlZAlhdG9taWM2NF9m
ZXRjaF9hbmRub3RfcmVsYXhlZA0KPiArI2RlZmluZSBhdG9taWM2NF9mZXRjaF9vcl9yZWxheGVk
CWF0b21pYzY0X2ZldGNoX29yX3JlbGF4ZWQNCj4gKyNkZWZpbmUgYXRvbWljNjRfZmV0Y2hfeG9y
X3JlbGF4ZWQJYXRvbWljNjRfZmV0Y2hfeG9yX3JlbGF4ZWQNCj4gKw0KPiAgI2RlZmluZSBBVE9N
SUM2NF9PUFMob3AsIG9wMSwgb3AyKQkJCQkJXA0KPiAgCUFUT01JQzY0X09QKG9wLCBvcDEsIG9w
MikJCQkJCVwNCj4gIAlBVE9NSUM2NF9PUF9SRVRVUk4ob3AsIG9wMSwgb3AyKQkJCQlcDQo+IEBA
IC00MzQsNiArNDU2LDEyIEBAIHN0YXRpYyBpbmxpbmUgbG9uZyBsb25nIGF0b21pYzY0X2ZldGNo
XyMjb3AobG9uZyBsb25nIGEsIGF0b21pYzY0X3QgKnYpCVwNCj4gIA0KPiAgQVRPTUlDNjRfT1BT
KGFkZCwgYWRkLmYsIGFkYykNCj4gIEFUT01JQzY0X09QUyhzdWIsIHN1Yi5mLCBzYmMpDQo+ICsN
Cj4gKyN1bmRlZiBBVE9NSUM2NF9PUFMNCj4gKyNkZWZpbmUgQVRPTUlDNjRfT1BTKG9wLCBvcDEs
IG9wMikJCQkJCVwNCj4gKwlBVE9NSUM2NF9PUChvcCwgb3AxLCBvcDIpCQkJCQlcDQo+ICsJQVRP
TUlDNjRfRkVUQ0hfT1Aob3AsIG9wMSwgb3AyKQ0KPiArDQoNCkZvciBjbGFyaXR5IEkgc3BsaXQg
b2ZmIHRoaXMgaHVuayBpbnRvIGEgc2VwZXJhdGUgcGF0Y2ggYXMgaXQgZWxpZGVzIGdlbmVyYXRp
b24gb2YNCnVudXNlZCBiaXR3aXNlIG9wcy4NCg0KPiAgQVRPTUlDNjRfT1BTKGFuZCwgYW5kLCBh
bmQpDQo+ICBBVE9NSUM2NF9PUFMoYW5kbm90LCBiaWMsIGJpYykNCj4gIEFUT01JQzY0X09QUyhv
ciwgb3IsIG9yKQ0KPg0KDQo=
