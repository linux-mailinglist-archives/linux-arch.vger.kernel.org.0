Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E72356BED5
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2019 17:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfGQPKB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Jul 2019 11:10:01 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:45726 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725906AbfGQPKB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 17 Jul 2019 11:10:01 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 24DF8C0ABC;
        Wed, 17 Jul 2019 15:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1563376200; bh=4WuDKry4NMQz7qo173QpDM1hbO7KVVZ0inwJoAulOkc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=HeJn7cHDmLkdnJg7O4DS9DkTLY9ILDspypHoYjNLrgmWYbGddupNKFPooucEQ6rnN
         r/UrLlHmp3FO8S/Vn8Prj/kdlkssc6bK6nwMBhgiEgMYVO9fsQ+nAygZjgXdHZtEgS
         cqpjkWYfpGO4kxaIfzo5OmdEZZ+GzFbAwB8eMPxOxYZjvarc5Y7SM4pkVyonL6pVTk
         HzEi5y12dKSYK7c0vSNqbg2IqUtTaj/z8o5lk0SpKNYP9iE+BEPZlwJLeqQBjBTPQa
         QKTtj9dulttLIxW9h685yHRw/UKMgj0djEhhjOtxH11riTg6ze1tyhu0AGFPAkNqvw
         zvnU0MqOdIfvw==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 9C960A009F;
        Wed, 17 Jul 2019 15:09:58 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 17 Jul 2019 08:09:40 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 17 Jul 2019 08:09:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XU5bl4Lx4Csj7mQpdBFB/Do00f/xlsm9Drbj7NHMS6zTvZw7XVP9DKqUeVYhmGELXDDM4YC8uS3VCRw3Tku3AcTYbJcrrat3ut3fLJPeKkwSN7OGPs20XsdW2pRJXMF0wyKDVQas996Lbfj5i4CyDYSLLig9gwCU2wYNt1BqQ7oe5QE3+sMKxDhqxbMvjmJpZw/ozCJLRSCk1/FLQRO29n2IAiXL4j12FZHy5jZ8fqtL9SZ2pZ0wme/Yhd61K4Sdh8qPKICWnF8LCk7gq7ci/QN4BGtEb2xLMp6p968Hf4hsFH+WFoawwzhydSoB3Hktd7eqR2luYdC2hand21xsYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WuDKry4NMQz7qo173QpDM1hbO7KVVZ0inwJoAulOkc=;
 b=fo0/iJ8I3av9xOHI/We3aIj/glUfZdpkbDrq+KrG9plj0eouj8byfnZByijUWG4E1Ounk08fSCsTX8XliTEwQ/8HCWqUnJJTNw1+K0S9S5lVjbhi3seLLSTOJJuE5rtBxTQc5kPQADx8oIFmc06/XstvvESYM/XhvkulR/l+2NATjq6kwH3ppde/3jP8wpBOQbNeErSiX5/Am4/bgKdIhABxKi0Dy7dcs94IcGAzj/IfCS7Ft8OhwfJ4VmlTvdZuD8SnTiNpGQYTJZ5ob11y38vk3Ish0dcgzdp/rRW84lEiybpvt4KLpmyGySpwcfjTnf2HpFpI85kZsrikO1T1Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=synopsys.com;dmarc=pass action=none
 header.from=synopsys.com;dkim=pass header.d=synopsys.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WuDKry4NMQz7qo173QpDM1hbO7KVVZ0inwJoAulOkc=;
 b=wIc2getZ42v6wiLf4q5Ctwoh+yEXwdGyeOF0mutFclOLiHfYrmeLkBd1Hxl4OshNvv+or+QmsZmKqdOUeZOlMeCCqQ3L4MXlekNKrMl1QZbhD7DgOWYMz0ADC9DjzVS7UjVWqfa5hp8e0t/AImm9R2tMhMCLIolBTAffZKHF3ko=
Received: from SN6PR12MB2670.namprd12.prod.outlook.com (52.135.103.23) by
 SN6PR12MB2703.namprd12.prod.outlook.com (52.135.103.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Wed, 17 Jul 2019 15:09:35 +0000
Received: from SN6PR12MB2670.namprd12.prod.outlook.com
 ([fe80::ecdd:a159:c3f7:67a]) by SN6PR12MB2670.namprd12.prod.outlook.com
 ([fe80::ecdd:a159:c3f7:67a%6]) with mapi id 15.20.2073.012; Wed, 17 Jul 2019
 15:09:34 +0000
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "Vineet Gupta" <Vineet.Gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "jbaron@redhat.com" <jbaron@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] ARC: ARCv2: jump label: implement jump label patching
Thread-Topic: [PATCH] ARC: ARCv2: jump label: implement jump label patching
Thread-Index: AQHVItABmoPNpjiRbEyPVk6MS/0psabPHaMA
Date:   Wed, 17 Jul 2019 15:09:34 +0000
Message-ID: <57076361ad37f4fe7a5584643ae47adf30a99d35.camel@synopsys.com>
References: <20190614164049.31626-1-Eugeniy.Paltsev@synopsys.com>
         <C2D7FE5348E1B147BCA15975FBA2307501A252CCC3@us01wembx1.internal.synopsys.com>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA2307501A252CCC3@us01wembx1.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paltsev@synopsys.com; 
x-originating-ip: [84.204.78.101]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86463fc7-48fe-4d13-6298-08d70ac8c751
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR12MB2703;
x-ms-traffictypediagnostic: SN6PR12MB2703:
x-microsoft-antispam-prvs: <SN6PR12MB2703A0B0AB30E04060E7503ADEC90@SN6PR12MB2703.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01018CB5B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(39860400002)(396003)(136003)(189003)(199004)(36756003)(68736007)(86362001)(256004)(14444005)(26005)(476003)(186003)(6512007)(6506007)(53546011)(305945005)(76176011)(486006)(118296001)(8676002)(6486002)(11346002)(7736002)(8936002)(2616005)(446003)(66066001)(99286004)(25786009)(229853002)(6246003)(14454004)(91956017)(76116006)(53936002)(81166006)(4326008)(66946007)(81156014)(5660300002)(66556008)(66476007)(66446008)(64756008)(2906002)(316002)(71200400001)(71190400001)(6436002)(3846002)(6116002)(478600001)(2501003)(102836004)(54906003)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR12MB2703;H:SN6PR12MB2670.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VfifBPh87GIlb8ScASj4b+CcAOvnEOfLIK1lxcqHcWDzm6Ky1D4ANWRE8NoaKlzAWLaCOd1JLUBo7sdWRLL3vADy5XAv3y+03f2T340e0UmkgT6qvK6Rzh7ha6z6x0PVRZdOPvCpvXFxUXaYpHHVDUpVRqP5CZz737NxEE9fTMgAnFwKVXol4bHKLRftEti/MNyr5Z+L7Zon4YoDwCMrDm7Czh8/SuBpuz0xnjCBcpszGf5q77t9BtsQoL4X625pHbDY9SlsvZKRjVyDvbgb79K2oiItyGaOenqHwhDd1B4FTL5xd37gTqAURn5eI+pjZh5g/Kr0OQ9m0dvTE169XXWp+FKAEY95qiH/sVYUKa2yDetLfGsAyPw04jRVsdsQ53V0WxXvQK1N9zAzwtP+JidnmGxfPBCEqyUhJQ9tCXg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7C326816A754845AF2E747A7106B602@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 86463fc7-48fe-4d13-6298-08d70ac8c751
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2019 15:09:34.7812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: paltsev@synopsys.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2703
X-OriginatorOrg: synopsys.com
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

SGkgVmluZWV0LA0KSSdtIGZpbmFsbHkgYmFjaywgc28gc2VlIG15IGNvbW1lbnRzIGJlbG93Lg0K
DQpPbiBUdWUsIDIwMTktMDYtMTggYXQgMTY6MTYgKzAwMDAsIFZpbmVldCBHdXB0YSB3cm90ZToN
Cj4gT24gNi8xNC8xOSA5OjQxIEFNLCBFdWdlbml5IFBhbHRzZXYgd3JvdGU6DQo+ID4gSW1wbGVt
ZW50IGp1bXAgbGFiZWwgcGF0Y2hpbmcgZm9yIEFSQy4gSnVtcCBsYWJlbHMgcHJvdmlkZQ0KPiA+
IGFuIGludGVyZmFjZSB0byBnZW5lcmF0ZSBkeW5hbWljIGJyYW5jaGVzIHVzaW5nDQo+ID4gc2Vs
Zi1tb2RpZnlpbmcgY29kZS4NCj4gPiANCj4gPiBUaGlzIGFsbG93cyB1cyB0byBpbXBsZW1lbnQg
Y29uZGl0aW9uYWwgYnJhbmNoZXMgd2hlcmUNCj4gPiBjaGFuZ2luZyBicmFuY2ggZGlyZWN0aW9u
IGlzIGV4cGVuc2l2ZSBidXQgYnJhbmNoIHNlbGVjdGlvbg0KPiA+IGlzIGJhc2ljYWxseSAnZnJl
ZScNCj4gPiANCj4gPiBUaGlzIGltcGxlbWVudGF0aW9uIHVzZXMgMzItYml0IE5PUCBhbmQgQlJB
TkNIIGluc3RydWN0aW9ucw0KPiA+IHdoaWNoIGZvcmNlZCB0byBiZSBhbGlnbmVkIGJ5IDQgdG8g
Z3VhcmFudGVlIHRoYXQgdGhleSBkb24ndA0KPiA+IGNyb3NzIEwxIGNhY2hlIGxpbmUgYW5kIGNh
biBiZSB1cGRhdGUgYXRvbWljYWxseS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbml5
IFBhbHRzZXYgPEV1Z2VuaXkuUGFsdHNldkBzeW5vcHN5cy5jb20+DQo+IA0KPiBMR1RNIG92ZXJh
bGwgLSBuaXRzIGJlbG93Lg0KPiANCj4gPiAtLS0NCj4gPiAgYXJjaC9hcmMvS2NvbmZpZyAgICAg
ICAgICAgICAgICAgIHwgICA4ICsrDQo+ID4gIGFyY2gvYXJjL2luY2x1ZGUvYXNtL2p1bXBfbGFi
ZWwuaCB8ICA2OCArKysrKysrKysrKysNCj4gPiAgYXJjaC9hcmMva2VybmVsL01ha2VmaWxlICAg
ICAgICAgIHwgICAxICsNCj4gPiAgYXJjaC9hcmMva2VybmVsL2p1bXBfbGFiZWwuYyAgICAgIHwg
MTY4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICA0IGZpbGVzIGNoYW5nZWQs
IDI0NSBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FyYy9pbmNs
dWRlL2FzbS9qdW1wX2xhYmVsLmgNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJjL2tl
cm5lbC9qdW1wX2xhYmVsLmMNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcmMvS2NvbmZp
ZyBiL2FyY2gvYXJjL0tjb25maWcNCj4gPiBpbmRleCBjNzgxZTQ1ZDFkOTkuLmIxMzEzZTAxNmM1
NCAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FyYy9LY29uZmlnDQo+ID4gKysrIGIvYXJjaC9hcmMv
S2NvbmZpZw0KPiA+IEBAIC00Nyw2ICs0Nyw3IEBAIGNvbmZpZyBBUkMNCj4gPiAgCXNlbGVjdCBP
Rl9FQVJMWV9GTEFUVFJFRQ0KPiA+ICAJc2VsZWN0IFBDSV9TWVNDQUxMIGlmIFBDSQ0KPiA+ICAJ
c2VsZWN0IFBFUkZfVVNFX1ZNQUxMT0MgaWYgQVJDX0NBQ0hFX1ZJUFRfQUxJQVNJTkcNCj4gPiAr
CXNlbGVjdCBIQVZFX0FSQ0hfSlVNUF9MQUJFTCBpZiBJU0FfQVJDVjIgJiYgIUNQVV9FTkRJQU5f
QkUzMg0KPiA+ICANCj4gPiAgY29uZmlnIEFSQ0hfSEFTX0NBQ0hFX0xJTkVfU0laRQ0KPiA+ICAJ
ZGVmX2Jvb2wgeQ0KPiA+IEBAIC01MjksNiArNTMwLDEzIEBAIGNvbmZpZyBBUkNfRFcyX1VOV0lO
RA0KPiA+ICBjb25maWcgQVJDX0RCR19UTEJfUEFSQU5PSUENCj4gPiAgCWJvb2wgIlBhcmFub2lh
IENoZWNrcyBpbiBMb3cgTGV2ZWwgVExCIEhhbmRsZXJzIg0KPiA+ICANCj4gPiArY29uZmlnIEFS
Q19EQkdfU1RBVElDX0tFWVMNCj4gPiArCWJvb2wgIlBhcmFub2lkIGNoZWNrcyBpbiBTdGF0aWMg
S2V5cyBjb2RlIg0KPiA+ICsJZGVwZW5kcyBvbiBKVU1QX0xBQkVMDQo+ID4gKwlzZWxlY3QgU1RB
VElDX0tFWVNfU0VMRlRFU1QNCj4gPiArCWhlbHANCj4gPiArCSAgRW5hYmxlIHBhcmFub2lkIGNo
ZWNrcyBhbmQgc2VsZi10ZXN0IG9mIGJvdGggQVJDLXNwZWNpZmljIGFuZCBnZW5lcmljDQo+ID4g
KwkgIHBhcnQgb2Ygc3RhdGljLWtleXMtcmVsYXRlZCBjb2RlLg0KPiANCj4gV2h5IGNhbid0IHdl
IGp1c3QgZW5hYmxlIHRoaXMgaWYgU1RBVElDX0tFWVNfU0VMRlRFU1QNCg0KQXMgd2UgZXh0ZW50
IFNUQVRJQ19LRVlTX1NFTEZURVNUIG9wdGlvbiBzdWNoIGRlcGVuZGVuY3kgbG9va3MgbW9yZSBy
ZWFzb25hYmxlIGZvciBtZQ0KKHdlIGVuYWJsZSBvdXIgY2hlY2tzIC0+IGxldHMgZW5hYmxlIGNv
cnJlc3BvbmRpbmcgZ2VuZXJpYyBvbmVzKQ0KSSBkb24ndCBpbnNpc3QsIHRob3VnaC4NCg0KPiA+
ICBlbmRpZg0KPiA+ICANCj4gPiAgY29uZmlnIEFSQ19CVUlMVElOX0RUQl9OQU1FDQo+ID4gZGlm
ZiAtLWdpdCBhL2FyY2gvYXJjL2luY2x1ZGUvYXNtL2p1bXBfbGFiZWwuaCBiL2FyY2gvYXJjL2lu
Y2x1ZGUvYXNtL2p1bXBfbGFiZWwuaA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5k
ZXggMDAwMDAwMDAwMDAwLi44OTcxZDA2MDhmMmMNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysr
IGIvYXJjaC9hcmMvaW5jbHVkZS9hc20vanVtcF9sYWJlbC5oDQo+ID4gQEAgLTAsMCArMSw2OCBA
QA0KPiA+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCAqLw0KPiA+ICsjaWZu
ZGVmIF9BU01fQVJDX0pVTVBfTEFCRUxfSA0KPiA+ICsjZGVmaW5lIF9BU01fQVJDX0pVTVBfTEFC
RUxfSA0KPiA+ICsNCj4gPiArI2lmbmRlZiBfX0FTU0VNQkxZX18NCj4gPiArDQo+ID4gKyNpbmNs
dWRlIDxsaW51eC90eXBlcy5oPg0KPiA+ICsNCj4gPiArI2RlZmluZSBKVU1QX0xBQkVMX05PUF9T
SVpFIDQNCj4gPiArDQo+ID4gKy8qDQo+ID4gKyAqIFRvIG1ha2UgYXRvbWljIHVwZGF0ZSBvZiBw
YXRjaGVkIGluc3RydWN0aW9uIGF2YWlsYWJsZSB3ZSBuZWVkIHRvIGd1YXJhbnRlZQ0KPiA+ICsg
KiB0aGF0IHRoaXMgaW5zdHJ1Y3Rpb24gZG9lc24ndCBjcm9zcyBMMSBjYWNoZSBsaW5lIGJvdW5k
YXJ5Lg0KPiA+ICsgKg0KPiA+ICsgKiBBcyBvZiB0b2RheSB3ZSBzaW1wbHkgYWxpZ24gaW5zdHJ1
Y3Rpb24gd2hpY2ggY2FuIGJlIHBhdGNoZWQgYnkgNCBieXRlIHVzaW5nDQo+ID4gKyAqICIuYmFs
aWduIDQiIGRpcmVjdGl2ZS4gSW4gdGhhdCBjYXNlIHBhdGNoZWQgaW5zdHJ1Y3Rpb24gaXMgYWxp
Z25lZCB3aXRoIG9uZQ0KPiA+ICsgKiAxNi1iaXQgTk9QX1MgaWYgdGhpcyBpcyByZXF1aXJlZC4N
Cj4gPiArICogSG93ZXZlciAnYWxpZ24gYnkgNCcgZGlyZWN0aXZlIGlzIG11Y2ggc3RyaWN0ZXIg
dGhhbiBpdCBhY3R1YWxseSByZXF1aXJlZC4NCj4gPiArICogSXQncyBlbm91Z2ggdGhhdCBvdXIg
MzItYml0IGluc3RydWN0aW9uIGRvbid0IGNyb3NzIGwxIGNhY2hlIGxpbmUgYm91bmRhcnkNCj4g
PiArICogd2hpY2ggY2FuIGJlIGFjaGlldmVkIGJ5IHVzaW5nICIuYnVuZGxlX2FsaWduX21vZGUi
IGRpcmVjdGl2ZS4gVGhhdCB3aWxsIHNhdmUNCj4gPiArICogdXMgZnJvbSBhZGRpbmcgdXNlbGVz
cyBOT1BfUyBwYWRkaW5nIGluIG1vc3Qgb2YgdGhlIGNhc2VzLg0KPiA+ICsgKg0KPiA+ICsgKiBU
T0RPOiBzd2l0Y2ggdG8gIi5idW5kbGVfYWxpZ25fbW9kZSIgZGlyZWN0aXZlIHVzaW5nIHdoaW4g
aXQgd2lsbCBiZQ0KPiA+ICsgKiBzdXBwb3J0ZWQgYnkgQVJDIHRvb2xjaGFpbi4NCj4gPiArICov
DQo+ID4gKw0KPiANCj4gU28gYmxvY2sgY29tbWVudHMgb24gdG9wIG9mIGEgZnVuY3Rpb24gaW1w
bHkgc3VtbWFyeSBvZiBmdW5jdGlvbiBldGMuDQo+IFdoYXQgeW91IGFyZSBkb2luZyBoZXJlIGlz
IGNhbGxpbmcgb3V0IHRoZSBuZWVkIGZvciAuYmFsaWduIHF1aXJrLiBTbyBiZXR0ZXIgdG8NCj4g
cGhyYXNlIGl0IGlzIGFzICJOb3RlIGFib3V0IC5iYWxpZ24iIGFuZCB0aGVuIGRlc2NyaWJlIHRo
ZSB0aGluZw0KDQpPaywgd2lsbCBmaXggaW4gdjIuDQoNCj4gPiArc3RhdGljIF9fYWx3YXlzX2lu
bGluZSBib29sIGFyY2hfc3RhdGljX2JyYW5jaChzdHJ1Y3Qgc3RhdGljX2tleSAqa2V5LA0KPiA+
ICsJCQkJCSAgICAgICBib29sIGJyYW5jaCkNCj4gPiArew0KPiA+ICsJYXNtX3ZvbGF0aWxlX2dv
dG8oIi5iYWxpZ24gNAkJCVxuIg0KPiA+ICsJCSAiMToJCQkJCVxuIg0KPiA+ICsJCSAibm9wCQkJ
CQlcbiINCj4gPiArCQkgIi5wdXNoc2VjdGlvbiBfX2p1bXBfdGFibGUsIFwiYXdcIglcbiINCj4g
PiArCQkgIi53b3JkIDFiLCAlbFtsX3llc10sICVjMAkJXG4iDQo+ID4gKwkJICIucG9wc2VjdGlv
bgkJCQlcbiINCj4gPiArCQkgOiA6ICJpIiAoJigoY2hhciAqKWtleSlbYnJhbmNoXSkgOiA6IGxf
eWVzKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gZmFsc2U7DQo+ID4gK2xfeWVzOg0KPiA+ICsJcmV0
dXJuIHRydWU7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBfX2Fsd2F5c19pbmxpbmUgYm9v
bCBhcmNoX3N0YXRpY19icmFuY2hfanVtcChzdHJ1Y3Qgc3RhdGljX2tleSAqa2V5LA0KPiA+ICsJ
CQkJCQkgICAgYm9vbCBicmFuY2gpDQo+ID4gK3sNCj4gPiArCWFzbV92b2xhdGlsZV9nb3RvKCIu
YmFsaWduIDQJCQlcbiINCj4gPiArCQkgIjE6CQkJCQlcbiINCj4gPiArCQkgImIgJWxbbF95ZXNd
CQkJCVxuIg0KPiA+ICsJCSAiLnB1c2hzZWN0aW9uIF9fanVtcF90YWJsZSwgXCJhd1wiCVxuIg0K
PiA+ICsJCSAiLndvcmQgMWIsICVsW2xfeWVzXSwgJWMwCQlcbiINCj4gPiArCQkgIi5wb3BzZWN0
aW9uCQkJCVxuIg0KPiA+ICsJCSA6IDogImkiICgmKChjaGFyICopa2V5KVticmFuY2hdKSA6IDog
bF95ZXMpOw0KPiA+ICsNCj4gPiArCXJldHVybiBmYWxzZTsNCj4gPiArbF95ZXM6DQo+ID4gKwly
ZXR1cm4gdHJ1ZTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArdHlwZWRlZiB1MzIganVtcF9sYWJlbF90
Ow0KPiA+ICsNCj4gPiArc3RydWN0IGp1bXBfZW50cnkgew0KPiA+ICsJanVtcF9sYWJlbF90IGNv
ZGU7DQo+ID4gKwlqdW1wX2xhYmVsX3QgdGFyZ2V0Ow0KPiA+ICsJanVtcF9sYWJlbF90IGtleTsN
Cj4gPiArfTsNCj4gPiArDQo+ID4gKyNlbmRpZiAgLyogX19BU1NFTUJMWV9fICovDQo+ID4gKyNl
bmRpZg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FyYy9rZXJuZWwvTWFrZWZpbGUgYi9hcmNoL2Fy
Yy9rZXJuZWwvTWFrZWZpbGUNCj4gPiBpbmRleCAyZGM1ZjQyOTZkNDQuLjMwN2Y3NDE1NmQ5OSAx
MDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FyYy9rZXJuZWwvTWFrZWZpbGUNCj4gPiArKysgYi9hcmNo
L2FyYy9rZXJuZWwvTWFrZWZpbGUNCj4gPiBAQCAtMjIsNiArMjIsNyBAQCBvYmotJChDT05GSUdf
QVJDX0VNVUxfVU5BTElHTkVEKSAJKz0gdW5hbGlnbmVkLm8NCj4gPiAgb2JqLSQoQ09ORklHX0tH
REIpCQkJKz0ga2dkYi5vDQo+ID4gIG9iai0kKENPTkZJR19BUkNfTUVUQVdBUkVfSExJTkspCSs9
IGFyY19ob3N0bGluay5vDQo+ID4gIG9iai0kKENPTkZJR19QRVJGX0VWRU5UUykJCSs9IHBlcmZf
ZXZlbnQubw0KPiA+ICtvYmotJChDT05GSUdfSlVNUF9MQUJFTCkJCSs9IGp1bXBfbGFiZWwubw0K
PiA+ICANCj4gPiAgb2JqLSQoQ09ORklHX0FSQ19GUFVfU0FWRV9SRVNUT1JFKQkrPSBmcHUubw0K
PiA+ICBDRkxBR1NfZnB1Lm8gICArPSAtbWRwZnANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcmMv
a2VybmVsL2p1bXBfbGFiZWwuYyBiL2FyY2gvYXJjL2tlcm5lbC9qdW1wX2xhYmVsLmMNCj4gPiBu
ZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uOTNlM2JjODQyODhm
DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2FyY2gvYXJjL2tlcm5lbC9qdW1wX2xhYmVs
LmMNCj4gPiBAQCAtMCwwICsxLDE2OCBAQA0KPiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogR1BMLTIuMA0KPiA+ICsNCj4gPiArI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KPiA+ICsj
aW5jbHVkZSA8bGludXgvanVtcF9sYWJlbC5oPg0KPiA+ICsNCj4gPiArI2luY2x1ZGUgImFzbS9j
YWNoZWZsdXNoLmgiDQo+ID4gKw0KPiA+ICsjZGVmaW5lIEpVTVBMQUJFTF9FUlIJIkFSQzoganVt
cF9sYWJlbDogRVJST1I6ICINCj4gPiArDQo+ID4gKy8qIEhhbHQgc3lzdGVtIG9uIGZhdGFsIGVy
cm9yIHRvIG1ha2UgZGVidWcgZWFzaWVyICovDQo+ID4gKyNkZWZpbmUgYXJjX2psX2ZhdGFsKGZv
cm1hdC4uLikJCQkJCQlcDQo+ID4gKyh7CQkJCQkJCQkJXA0KPiA+ICsJcHJfZXJyKEpVTVBMQUJF
TF9FUlIgZm9ybWF0KTsJCQkJCVwNCj4gPiArCUJVRygpOwkJCQkJCQkJXA0KPiANCj4gRG9lcyBp
dCBtYWtlIHNlbnNlIHRvIGJyaW5nIGRvd24gdGhlIHdob2xlIHN5c3RlbSB2cy4gZmFpbGluZyBh
bmQgcmV0dXJuaW5nLg0KPiBJIHNlZSB0aGVyZSBpcyBubyBlcnJvciBwcm9wYWdhdGlvbiB0byBj
b3JlIGNvZGUsIGJ1dCBzdGlsbC4NCg0KSSB0b3RhbGx5IGFncmVlIHdpdGggUGV0ZXIsIGFuZCBJ
IHByZWZlciB0byBzdG9wIHRoZSBzeXN0ZW0gb24gdGhpcyBlcnJvcnMuIEhlcmUgaXMgZmV3IGFy
Z3VtZW50czoNCkFsbCB0aGlzIGNoZWNrcyBjYW4ndCBiZSB0b2dnbGUgaW4gc3lzdGVtIG9wZXJh
dGluZyBub3JtYWxseSBhbmQgb25seSBtYXkgYmUgY2F1c2VkIGJ5IGJhZCBjb2RlIGdlbmVyYXRp
b24gKG9yIHNvbWUgY29kZS9kYXRhIGNvcnJ1cHRpb24pOg0KMSkgV2UgZ290IG91ciBpbnN0cnVj
dGlvbiB0byBwYXRjaCB1bmFsaWduZWQgYnkgNCBieXRlcyAoZGVzcGl0ZSB0aGUgZmFjdCB0aGF0
IHdlIHVzZWQgJy5iYWxpZ24gNCcgdG8gYWxpZ24gaXQpDQoyKSBXZSBnb3QgYnJhbmNoIG9mZnNl
dCB1bmFsaWduZWQgKHdoaWNoIG1lYW5zIHRoYXQgd2UgY2FsY3VsYXRlIGl0IHdyb25nIGF0IGJ1
aWxkIHRpbWUgb3IgY29ycnVwdCBpdCBpbiBydW4gdGltZSkNCjMpIFdlIGdvdCBicmFuY2ggb2Zm
c2V0IHdoaWNoIG5vdCBmaXRzIGludG8gczI1LiBBcyB0aGlzIGlzIG9mZnNldCBpbnNpZGUgb25l
IGZ1bmN0aW9uIChpbnNpZGUgb25lICdpZicgc3RhdGVtZW50IGFjdHVhbGx5KSB3ZSBuZXdlciBn
ZXQgc3VjaCBodWdlDQpvZmZzZXQgaW4gcmVhbCBsaWZlIGlmIGNvZGUgZ2VuZXJhdGlvbiBpcyBv
ay4NCg0KSWYgd2Ugb25seSB3YXJuIHRvIGxvZyBhbmQgcmV0dXJuIHdlIHdpbGwgZmFjZSB3aXRo
IGNvbXByb21pc2VkIGtlcm5lbCBmbG93IGxhdGVyLg0KSS5FLiBpdCBjb3VsZCBiZSAnaWYnIHN0
YXRlbWVudCBpbiBrZXJuZWwgdGV4dCB3aGljaCBpcyBzd2l0Y2hlZCB0byB3cm9uZyBzdGF0ZTog
dGhlIGNvbmRpdGlvbiBpcyB0cnVlIGJ1dCB3ZSB0YWtlIHRoZSBmYWxzZSBicmFuY2guDQpBbmQg
SXQgd2lsbCBiZSB0aGUgaXNzdWUgd2hpY2ggaXMgbXVjaCBtb3JlIGRpZmZpY3VsdCB0byBkZWJ1
Zy4NCg0KRG9lcyBpdCBzb3VuZCByZWFzb25hYmx5Pw0KDQpJZiB5b3UgcmVhbGx5IGRvbid0IHdh
bnQgdG8gaGF2ZSBCVUcgaGVyZSwgSSBjYW4gbWFrZSBpdCBjb25kaXRpb25hbGx5IGVuYWJsZWQN
CmluIGRlcGVuZCBvbiBDT05GSUdfQVJDX1NUQVRJQ19LRVlTX0RFQlVHIGFzIEkgd2FudCB0byBo
YXZlIGl0IGVuYWJsZWQgYXQgbGVhc3Qgb24gQVJDIGRldmVsb3BtZW50IHBsYXRmb3Jtcy4NCg0K
W3NuaXBdDQotLSANCiBFdWdlbml5IFBhbHRzZXYNCg==
