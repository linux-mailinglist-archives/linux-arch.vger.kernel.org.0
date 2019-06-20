Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F04F04D94D
	for <lists+linux-arch@lfdr.de>; Thu, 20 Jun 2019 20:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbfFTSeh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Jun 2019 14:34:37 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:49872 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725921AbfFTSeg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Jun 2019 14:34:36 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9AD2AC1D6C;
        Thu, 20 Jun 2019 18:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1561055676; bh=RMr6ohRX57mopTw5g1/aB217SA5Pa5ceHvd4q23pFns=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=CfHYvxVzKYN4Tty1vRXht07cMlgD7zZ8ANk/OqUOu4MnEXayihErckZSuR7iW37XI
         nnEv4XSJnlPL9D2KqGjHdSly9WhC9wffMprZDc9dAP6gLKo+oQn9//rg20tfdlxZhF
         1ZA9LAtLAkcyg510kHzyHqg3mApWdFOaTQ7kksF10CpzX+JTpMSqTYgefemjKe1RJW
         n7Yhw98PjbqYFyt9X9D83jHBrLb6o7SwdRvNabVWQ5st66h8Recg47EzAKj/dUFrBU
         CdEYc5QUu8UiLM3Xipy+KTYWmNhkuH0/xBuSCjUpeCBSEOfM26HqPMW2bFEB53Wdm9
         tmCpNN2/T1XKg==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 098A5A0093;
        Thu, 20 Jun 2019 18:34:34 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 20 Jun 2019 11:34:34 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 20 Jun 2019 11:34:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMr6ohRX57mopTw5g1/aB217SA5Pa5ceHvd4q23pFns=;
 b=HktHdRoOiC1n+TM01Cpz3CvhlwYsrRReonsdhAMJjdbKv09c5KoDZ8ERCTapkGMiM5NDDn5D4yR+oYC37SS3P041BieetyjZMhL4e0CCP/26LZBqqisRKwBDsr0FbCL6j9vm5uN4EU1fZaW1LzshreCt4O1WV5PM9q19/Kdr4nA=
Received: from SN6PR12MB2670.namprd12.prod.outlook.com (52.135.103.23) by
 SN6PR12MB2653.namprd12.prod.outlook.com (52.135.103.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Thu, 20 Jun 2019 18:34:29 +0000
Received: from SN6PR12MB2670.namprd12.prod.outlook.com
 ([fe80::bd34:8d2b:911e:e495]) by SN6PR12MB2670.namprd12.prod.outlook.com
 ([fe80::bd34:8d2b:911e:e495%5]) with mapi id 15.20.1987.014; Thu, 20 Jun 2019
 18:34:29 +0000
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     "peterz@infradead.org" <peterz@infradead.org>,
        "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>
CC:     "jbaron@redhat.com" <jbaron@redhat.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] ARC: ARCv2: jump label: implement jump label patching
Thread-Topic: [PATCH] ARC: ARCv2: jump label: implement jump label patching
Thread-Index: AQHVItABmoPNpjiRbEyPVk6MS/0psaaip9aAgAJAHQA=
Date:   Thu, 20 Jun 2019 18:34:29 +0000
Message-ID: <50a5120f512e7d6784efa403a7597c159074c8c1.camel@synopsys.com>
References: <20190614164049.31626-1-Eugeniy.Paltsev@synopsys.com>
         <C2D7FE5348E1B147BCA15975FBA2307501A252CCC3@us01wembx1.internal.synopsys.com>
         <20190619081227.GL3419@hirez.programming.kicks-ass.net>
In-Reply-To: <20190619081227.GL3419@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paltsev@synopsys.com; 
x-originating-ip: [84.204.78.101]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 888f84e5-fb9d-4ecc-73a2-08d6f5adee60
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR12MB2653;
x-ms-traffictypediagnostic: SN6PR12MB2653:
x-microsoft-antispam-prvs: <SN6PR12MB2653BF876B5220C628484F00DEE40@SN6PR12MB2653.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0074BBE012
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(396003)(376002)(136003)(199004)(189003)(99286004)(6506007)(476003)(446003)(6436002)(486006)(11346002)(2616005)(110136005)(6512007)(86362001)(3846002)(76176011)(6486002)(229853002)(6636002)(316002)(26005)(6116002)(186003)(2906002)(118296001)(256004)(14444005)(68736007)(8936002)(25786009)(71200400001)(71190400001)(36756003)(66066001)(6246003)(7736002)(478600001)(305945005)(81156014)(81166006)(8676002)(102836004)(14454004)(53936002)(2501003)(54906003)(66446008)(66476007)(66556008)(64756008)(4326008)(73956011)(66946007)(76116006)(91956017)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR12MB2653;H:SN6PR12MB2670.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4DNGjX8hJhtp96kKTCcHMqBJCmYAqFGe1xtENoGiY9kmzunTbFzVEYA/XGIgeWLbDC2Dxv2sx0phnrNos4cqRsu3KtX6owXGG+8J45NJ38cgYc2Dd40PzRaAoxIKtpfMuW2vjr2rB3pl3W6Sxv0ZOJpjgc+6xMdzuthLaPQfCMibDKQyF/WkzbglSTFO4cugaoIjaqVcbXo1lFacC8xdgPBFYyFnh5m4RP8Ag9ZkLUyqFLKefpTxdUCppKR1SNjFxu4sgRzAUHhOL5L9cAp//gKrh8rKhzN9W/xvB5yQQoiZ9q+Mo/MRaTbrv9Sx7mIF7FqjGJ/U1Zch/NdKHlEckZtYdMtTQRzzQSfGDHcFcyjroZouAKHowWLbPBPg4ive0KSHv2QnrQffbZa7jdq0yu6qYe6JqfHmSUI4KAE+3G8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B216DBA167D5AE4C97B8EDFB30EA7A2F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 888f84e5-fb9d-4ecc-73a2-08d6f5adee60
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2019 18:34:29.5620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: paltsev@synopsys.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2653
X-OriginatorOrg: synopsys.com
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

SGkgUGV0ZXIsDQoNCk9uIFdlZCwgMjAxOS0wNi0xOSBhdCAxMDoxMiArMDIwMCwgUGV0ZXIgWmlq
bHN0cmEgd3JvdGU6DQo+IE9uIFR1ZSwgSnVuIDE4LCAyMDE5IGF0IDA0OjE2OjIwUE0gKzAwMDAs
IFZpbmVldCBHdXB0YSB3cm90ZToNCj4gDQo+ID4gPiArLyoNCj4gPiA+ICsgKiBUbyBtYWtlIGF0
b21pYyB1cGRhdGUgb2YgcGF0Y2hlZCBpbnN0cnVjdGlvbiBhdmFpbGFibGUgd2UgbmVlZCB0byBn
dWFyYW50ZWUNCj4gPiA+ICsgKiB0aGF0IHRoaXMgaW5zdHJ1Y3Rpb24gZG9lc24ndCBjcm9zcyBM
MSBjYWNoZSBsaW5lIGJvdW5kYXJ5Lg0KPiA+ID4gKyAqDQo+IA0KPiBPaCB1cmdoLiBJcyB0aGF0
IHRoZSBvbmx5IHdheSBBUkMgY2FuIGRvIHRleHQgcGF0Y2hpbmc/IFdlJ3ZlIGFjdHVhbGx5DQo+
IGNvbnNpZGVyZWQgc29tZXRoaW5nIGxpa2UgdGhpcyBvbiB4ODYgYXQgc29tZSBwb2ludCwgYnV0
IHRoZXJlIHdlIGhhdmUNCj4gdGhlICdmdW4nIGRldGFpbCB0aGF0IHRoZSBpLWZldGNoIHdpbmRv
dyBkb2VzIG5vdCBpbiBmYWN0IGFsaWduIHdpdGggTDENCj4gc2l6ZSBvbiBhbGwgdWFyY2hzLCBz
byB0aGF0IGdvdCBjb21wbGljYXRlZCByZWFsIGZhc3QuDQo+IA0KPiBJJ20gYXNzdW1pbmcgeW91
J3ZlIGxvb2tlZCBhdCB3aGF0IHg4NiBjdXJyZW50bHkgZG9lcyBhbmQgZm91bmQNCj4gc29tZXRo
aW5nIGxpa2UgdGhhdCBkb2Vzbid0IHdvcmsgZm9yIEFSQz8NCg0KVG8gYmUgaG9uZXN0IEkndmUg
bW9zdGx5IGxvb2sgYXQgYXJtL2FybTY0IGltcGxlbWVudGF0aW9uIDopDQoNCkJ1dCB5ZWFoIGl0
J3MgZ29vZCByZW1hcmsgYWJvdXQgaS1mZXRjaCB3aW5kb3cuDQpJdCdzIG5hbWVkICdpbnN0cnVj
dGlvbl9mZXRjaF9ibG9ja193aWR0aCcgaW4gQVJDIGRvY3VtZW50YXRpb24gYW5kIGl0J3MNCnNt
YWxsZXIgdGhhbiBMMSBJJCBsaW5lIHNpemUuIE9uIEFSQ3YyIGl0J3MgMTYgYnl0ZS4NClNvIGlu
IGN1cnJlbnQgaW1wbGVtZW50YXRpb24gd2UgbmVlZCB0byBndWFyYW50ZWUgdGhhdCB0aGlzIGlu
c3RydWN0aW9uIGRvZXNuJ3QNCmNyb3NzICdpbnN0cnVjdGlvbl9mZXRjaF9ibG9jaycgYW5kIG5v
dCBMMSBjYWNoZSBsaW5lIGJvdW5kYXJ5Lg0KDQpTbyB0aGVyZSBpcyBubyBwcm9ibGVtIHdpdGgg
dGhpcyBjb2RlIGl0c2VsZiBidXQgdGhlIGNvbW1lbnQgc2hvdWxkIGJlIGZpeGVkLg0KDQpbc25p
cF0NCi0tIA0KIEV1Z2VuaXkgUGFsdHNldg0K
