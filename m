Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A96C15E88D
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jul 2019 18:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfGCQPO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Jul 2019 12:15:14 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:52194 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725933AbfGCQPO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jul 2019 12:15:14 -0400
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D9F62C00FF;
        Wed,  3 Jul 2019 16:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1562170513; bh=WDDiZDuew8RegZw1RwNP2UM3/pT0484FOMpowsuFhms=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=YGubzmLMIxfbuso0hgSWgzxFUTyeoIY5h9vw45hInb9h5z603SboOjTm1U+E7UUT3
         nLxO3vw8NEW7rwBYuZo0IdtGKiM92ZA1Pc7pA4eV4sV+Lpk9TG1qt+oEiISkoZt8IG
         aVSyGCn4kujkgH69dgjObBVyKWFFuqF1dLF/pMMteAC4HFPSmz+0gKBjjJaF9HXZx9
         S9NJsse7gLlJDHrk+PEpuE6pInZkwQx5DWHj7yxLztCY+0XpEp7ftWJuaej9CGUoKU
         3tCJieJB9a025xq5ImFX/mFWHVfwDRwTETYPsuozfakiQloQ75xplTckZdulZrsJ98
         oR81jD7iciCTw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 9235DA0067;
        Wed,  3 Jul 2019 16:15:12 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 3 Jul 2019 09:15:12 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 3 Jul 2019 09:15:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDDiZDuew8RegZw1RwNP2UM3/pT0484FOMpowsuFhms=;
 b=OLeRriG9A01mLmtWBXti5K7ZLxh+UiUEkvCzh4Pr+C1pjowP0WlvIFMBeQdNOzeCQJxcHLiKlJciryw15luFsle+2QnMMmTqtbYjyBG/Pzum8xSDtgzpLEwh9JyoZanhqQKZpMh6/+uIy7uJXTBzbLVuQGow8QG6k4MAsjbAIUY=
Received: from BN6PR1201MB0035.namprd12.prod.outlook.com (10.174.238.140) by
 BN6PR1201MB0051.namprd12.prod.outlook.com (10.174.114.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.17; Wed, 3 Jul 2019 16:15:10 +0000
Received: from BN6PR1201MB0035.namprd12.prod.outlook.com
 ([fe80::c4ec:41a0:dfb5:767f]) by BN6PR1201MB0035.namprd12.prod.outlook.com
 ([fe80::c4ec:41a0:dfb5:767f%10]) with mapi id 15.20.2032.019; Wed, 3 Jul 2019
 16:15:10 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <Alexey.Brodkin@synopsys.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] ARC: ARCv2: jump label: implement jump label patching
Thread-Topic: [PATCH] ARC: ARCv2: jump label: implement jump label patching
Thread-Index: AQHVMbp1QUnMGryojE2rPVU+oeatwQ==
Date:   Wed, 3 Jul 2019 16:15:09 +0000
Message-ID: <991ace9d-ef6d-0f29-d4f4-03ba47a7f7ff@synopsys.com>
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
x-clientproxiedby: BYAPR06CA0015.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::28) To BN6PR1201MB0035.namprd12.prod.outlook.com
 (2603:10b6:405:4d::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vgupta@synopsys.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e0424bf-9902-4397-ec7a-08d6ffd19eb2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR1201MB0051;
x-ms-traffictypediagnostic: BN6PR1201MB0051:
x-microsoft-antispam-prvs: <BN6PR1201MB00518DF8CC12A9AA4BB97EA6B6FB0@BN6PR1201MB0051.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(110136005)(66066001)(64756008)(66446008)(66476007)(58126008)(5660300002)(229853002)(6486002)(66556008)(54906003)(66946007)(52116002)(65826007)(31696002)(73956011)(6512007)(7736002)(316002)(81156014)(4326008)(86362001)(65956001)(65806001)(81166006)(26005)(8676002)(305945005)(64126003)(386003)(6506007)(8936002)(476003)(53546011)(76176011)(53936002)(186003)(36756003)(4744005)(71200400001)(71190400001)(486006)(6436002)(99286004)(25786009)(31686004)(446003)(102836004)(11346002)(2616005)(3846002)(6116002)(14454004)(68736007)(6246003)(478600001)(2501003)(14444005)(2906002)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR1201MB0051;H:BN6PR1201MB0035.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Nez3vwR5bBm+H7HAeKUFBQ2I0BdvMD3j86W8Hr1kea6UrZk497DTN7hk+U+0BpUXus7JtNAxg+PzZNvMrg7E/tCXat8qsRZuxKyb1fW2Q32LTOcbY//v+UrFK1JJn12bPHPda5erwOHlGD3ny2Y88vpjULd9dazAMkIOXVf6yfUA1JU6RbhzsamGSOZg075qoghqvKfWmttzimDu8GQ/UK6pQGhHuGbkAa9l74osQYgpkfXv+hH3c2BYLOtUom6NPniQ6wwibJfJGgcW58NQVZoJkOGKPhk5cGLYl2tzgTuI4ccpfzY7Ch0dLh2kFZ1QMa/U02LMnjueLF6zDnJq3/AvjMWsMFS70JEDg20rr7gOCKFKgVQZhpQw02B0bVt3ki1TITbdvClRpWAd6wvjB9ABQcFOfJMMpV3qpoQgqmg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F497960BCBDEE4BA2FB30EEE564DBC0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0424bf-9902-4397-ec7a-08d6ffd19eb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 16:15:09.8800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vgupta@synopsys.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0051
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
cy5jb20+DQo+IExHVE0gb3ZlcmFsbCAtIG5pdHMgYmVsb3cuDQo+IA0KDQpDYW4geW91IGFkZHJl
c3MgdGhlIHJldmlldyBjb21tZW50cyBzb29uIHNvIHRoaXMgZ2V0cyBtZXJnZWQgaW4gNS4zIHdo
b3NlIG1lcmdlDQp3aW5kb3cgaXMgbG9vbWluZyAhDQo=
