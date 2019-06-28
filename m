Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E11495A743
	for <lists+linux-arch@lfdr.de>; Sat, 29 Jun 2019 00:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfF1W7k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Jun 2019 18:59:40 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:55340 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726863AbfF1W7j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Jun 2019 18:59:39 -0400
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E270FC0BD5;
        Fri, 28 Jun 2019 22:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1561762778; bh=aUcgd2RW73NnRbfKGSAnJZAUWnkBSN3fazVaHRexBIA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=JDDcgtRGXVKelBiEPyqJ0RQ52svzDEifFpWC22lZBd6ylcecyc3ZrKMS8+DY0whlw
         /qa63nUHL8JoVPvaYC80o3RMwUY1uGDs13E7ok1hqMXNHvwFR5jQRdAAqBpqjIRH7V
         SJH0HzyWIyKxrPSrQdPIYNBM6i7Fm1+YZHz1WdbXPQuL965/4EDyBmEfFLFBSdDVkE
         kHYEWymWUbFSbykKAhe2l2MAqDk4pC67BbN2GxpUr98cDLIPucl8FrCA5ovHH7RQmF
         d5yhGf7XagWBDC38ozjtapH4IarsDBIzXG/VcYXIFGVDhaII9vAO3YKFTR+H/8MQi1
         nopfQshlX2CCg==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 078F4A0067;
        Fri, 28 Jun 2019 22:59:36 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 28 Jun 2019 15:59:36 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 28 Jun 2019 15:59:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUcgd2RW73NnRbfKGSAnJZAUWnkBSN3fazVaHRexBIA=;
 b=bKbrVutPY6dobuQkd8dXWJVAb5gjbDrWSDD7kpc1r2y4Kwcp4TgqJyaQXD3DY8BL+oJcZU5i8j7yBFitzq5/csdgHlx3o4IUwZvXaiu6zZ0iRg/+c4yIe62lK1/ZX56CfrauDqu3isB51vBdd85a0eQs28x7C+0Qkx4sAMvaEjc=
Received: from BN6PR1201MB0035.namprd12.prod.outlook.com (10.174.238.140) by
 BN6PR1201MB0097.namprd12.prod.outlook.com (10.174.114.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.17; Fri, 28 Jun 2019 22:59:34 +0000
Received: from BN6PR1201MB0035.namprd12.prod.outlook.com
 ([fe80::c4ec:41a0:dfb5:767f]) by BN6PR1201MB0035.namprd12.prod.outlook.com
 ([fe80::c4ec:41a0:dfb5:767f%10]) with mapi id 15.20.2032.019; Fri, 28 Jun
 2019 22:59:34 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <Alexey.Brodkin@synopsys.com>,
        Jason Baron <jbaron@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Ard Biesheuvel" <ard.biesheuvel@linaro.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] ARC: ARCv2: jump label: implement jump label patching
Thread-Topic: [PATCH] ARC: ARCv2: jump label: implement jump label patching
Thread-Index: AQHVLgUfQUnMGryojE2rPVU+oeatwQ==
Date:   Fri, 28 Jun 2019 22:59:33 +0000
Message-ID: <7ef18a49-cc5a-6cd1-bed3-beec003a73c3@synopsys.com>
References: <20190614164049.31626-1-Eugeniy.Paltsev@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA2307501A252CCC3@us01wembx1.internal.synopsys.com>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA2307501A252CCC3@us01wembx1.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
x-originating-ip: [198.182.56.5]
x-clientproxiedby: BYAPR11CA0102.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::43) To BN6PR1201MB0035.namprd12.prod.outlook.com
 (2603:10b6:405:4d::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vgupta@synopsys.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2fd736b0-db3c-409b-50c2-08d6fc1c491d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR1201MB0097;
x-ms-traffictypediagnostic: BN6PR1201MB0097:
x-microsoft-antispam-prvs: <BN6PR1201MB00976A764A7D8CD2C2CB5F4AB6FC0@BN6PR1201MB0097.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(376002)(396003)(39860400002)(199004)(189003)(31696002)(186003)(14444005)(66946007)(229853002)(6506007)(486006)(11346002)(8676002)(476003)(68736007)(4326008)(64126003)(2616005)(2501003)(65826007)(52116002)(5660300002)(76176011)(8936002)(81166006)(99286004)(53546011)(7736002)(58126008)(305945005)(81156014)(478600001)(53936002)(6436002)(26005)(73956011)(65956001)(3846002)(66556008)(6246003)(64756008)(316002)(25786009)(6486002)(2906002)(6512007)(31686004)(446003)(6116002)(102836004)(36756003)(66446008)(256004)(386003)(71190400001)(71200400001)(86362001)(54906003)(66066001)(65806001)(4744005)(110136005)(14454004)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR1201MB0097;H:BN6PR1201MB0035.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0Hpotk1mk3HwPce7w5+raYtKU8mOooh1vWpMPoz+BKXDXNGSLr2dUsNIcV6t3gYEJbFCh0C9O/kPF8UnnbhTgRx3scyEZuI6xRbLRVc2ESVuM1Ri1t3aX7uid/5/24RcKFSXE1Pw+/TwnEB0xfyx93Ccrh/D37XEfN0f9rOI+WWibCqlyIACg13iPPHyxx7/Qfxr0jR8QxfVJZ4G6K2NFBGoiscKRa8e4NzFt+BEt+US1owwyUUhkUuQwzwChI+nO1bWmNS7cSP3JQyRPN6nznUCdTK2DSmQFFXB0q7jNsdWekT3u5l2ryKJn64tza7CPPzurraVVGFLikHkqCbf+Oc2nANGaUhuFtPo9OsP7z4rNztjCYFJFuqkm6ntETRyqWx1lyztrPUynRiNu9+it8puDqti7wniuSzxVK5VjzM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31BEBB84CB2C8E47993409B6B497028A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd736b0-db3c-409b-50c2-08d6fc1c491d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 22:59:34.0419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vgupta@synopsys.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0097
X-OriginatorOrg: synopsys.com
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gNi8xOC8xOSA5OjE2IEFNLCBWaW5lZXQgR3VwdGEgd3JvdGU6DQo+IE9uIDYvMTQvMTkgOTo0
MSBBTSwgRXVnZW5peSBQYWx0c2V2IHdyb3RlOg0KPj4gSW1wbGVtZW50IGp1bXAgbGFiZWwgcGF0
Y2hpbmcgZm9yIEFSQy4gSnVtcCBsYWJlbHMgcHJvdmlkZQ0KPj4gYW4gaW50ZXJmYWNlIHRvIGdl
bmVyYXRlIGR5bmFtaWMgYnJhbmNoZXMgdXNpbmcNCj4+IHNlbGYtbW9kaWZ5aW5nIGNvZGUuDQo+
Pg0KPj4gVGhpcyBhbGxvd3MgdXMgdG8gaW1wbGVtZW50IGNvbmRpdGlvbmFsIGJyYW5jaGVzIHdo
ZXJlDQo+PiBjaGFuZ2luZyBicmFuY2ggZGlyZWN0aW9uIGlzIGV4cGVuc2l2ZSBidXQgYnJhbmNo
IHNlbGVjdGlvbg0KPj4gaXMgYmFzaWNhbGx5ICdmcmVlJw0KPj4NCj4+IFRoaXMgaW1wbGVtZW50
YXRpb24gdXNlcyAzMi1iaXQgTk9QIGFuZCBCUkFOQ0ggaW5zdHJ1Y3Rpb25zDQo+PiB3aGljaCBm
b3JjZWQgdG8gYmUgYWxpZ25lZCBieSA0IHRvIGd1YXJhbnRlZSB0aGF0IHRoZXkgZG9uJ3QNCj4+
IGNyb3NzIEwxIGNhY2hlIGxpbmUgYW5kIGNhbiBiZSB1cGRhdGUgYXRvbWljYWxseS4NCj4+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBFdWdlbml5IFBhbHRzZXYgPEV1Z2VuaXkuUGFsdHNldkBzeW5vcHN5
cy5jb20+DQo+IA0KPiBMR1RNIG92ZXJhbGwgLSBuaXRzIGJlbG93Lg0KDQpAUGV0ZXIgY2FuIHdl
IGhhdmUgeW91ciByZXZpZXdlZC9hY2sgb3Igc29tZSBzdWNoIGFzc3VtaW5nIHlvdSBkb24ndCBo
YXZlIGFueQ0Kb2JqZWN0aW9ucyAhDQoNClRoeCwNCi1WaW5lZXQNCg==
