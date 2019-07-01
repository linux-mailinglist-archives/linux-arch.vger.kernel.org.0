Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E97D95C423
	for <lists+linux-arch@lfdr.de>; Mon,  1 Jul 2019 22:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfGAUF5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Jul 2019 16:05:57 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:46444 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726652AbfGAUF4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Jul 2019 16:05:56 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 64CB2C016B;
        Mon,  1 Jul 2019 20:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1562011556; bh=bBSpu+iXNHu4IfS6luAh9KbyIW7wamAstgje5wKxMVA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=RCCh/RUOIDmBOiH8OuqSlEchJlFO4YfkI+2bFQtqlQ2mXY5zEsF+JUN8k7zx8pU3l
         cZst1Hquo72rxKXKyORDargdNaiIHf+vjyMT71u80FxyLMQUHTf/PMuB9O8R+XVrQe
         eGOqy6/Svhlk3CCQJ5GP7rB1gPfbAHOLN+oJivTMJRDrpz5V4RuCV7wcPRKkehjzeH
         1TMGn2XkYrRNMBkaStIPJOVJmWiEVZcXrabEdt0WZqAY9mwGgxhR44ZC8JHLDD7aS5
         2K32L7nm295GqFPONrhzNaobd9k8IdFZc1F2oJ+N5ln4CvKy1hkXRonn59MWqgFIHX
         psyWmILpJV5CQ==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id AF6F6A023B;
        Mon,  1 Jul 2019 20:05:53 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 1 Jul 2019 13:05:53 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 1 Jul 2019 13:05:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBSpu+iXNHu4IfS6luAh9KbyIW7wamAstgje5wKxMVA=;
 b=b1XvnNOBA67JrecOpTR304gJxW2qcvURBXVVSJEY0aA3SiSKPyjj3YdgdqyELRUjzTeVQK5EmqVO6eOzPCrA/+vtW3GDneQx8e9hcgPGTaaojE8KbOYDf4qjrew72CzjknuDQVOhl7j9FBQnvsWlx+3VyAWxSCiGe9mxksyuv6M=
Received: from BN6PR1201MB0035.namprd12.prod.outlook.com (10.174.238.140) by
 BN6PR1201MB0260.namprd12.prod.outlook.com (10.174.112.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Mon, 1 Jul 2019 20:05:51 +0000
Received: from BN6PR1201MB0035.namprd12.prod.outlook.com
 ([fe80::c4ec:41a0:dfb5:767f]) by BN6PR1201MB0035.namprd12.prod.outlook.com
 ([fe80::c4ec:41a0:dfb5:767f%10]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 20:05:51 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Will Deacon <Will.Deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: single copy atomicity for double load/stores on 32-bit systems
Thread-Topic: single copy atomicity for double load/stores on 32-bit systems
Thread-Index: AQHVMEhfFNWopC40tEusWb/Dn7ECJQ==
Date:   Mon, 1 Jul 2019 20:05:51 +0000
Message-ID: <73510bc7-8386-746c-ed1e-422fb5adaec5@synopsys.com>
References: <2fd3a455-6267-5d21-c530-41964a4f6ce9@synopsys.com>
 <20190531082112.GH2623@hirez.programming.kicks-ass.net>
In-Reply-To: <20190531082112.GH2623@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
x-originating-ip: [198.182.56.5]
x-clientproxiedby: BY5PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::20) To BN6PR1201MB0035.namprd12.prod.outlook.com
 (2603:10b6:405:4d::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vgupta@synopsys.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e3c5d55-afd6-49b8-2f98-08d6fe5f83c3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR1201MB0260;
x-ms-traffictypediagnostic: BN6PR1201MB0260:
x-microsoft-antispam-prvs: <BN6PR1201MB0260C0897E5A2BAE535D78C2B6F90@BN6PR1201MB0260.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39860400002)(376002)(136003)(199004)(189003)(14444005)(102836004)(53936002)(486006)(6506007)(53546011)(386003)(54906003)(2906002)(26005)(11346002)(8676002)(76176011)(446003)(256004)(2616005)(476003)(6436002)(6512007)(14454004)(316002)(186003)(6246003)(58126008)(31696002)(36756003)(229853002)(71200400001)(71190400001)(52116002)(99286004)(6486002)(6916009)(5660300002)(66446008)(66556008)(6116002)(64756008)(73956011)(66946007)(68736007)(64126003)(66476007)(3846002)(4326008)(81156014)(65826007)(8936002)(25786009)(66066001)(478600001)(65956001)(65806001)(7736002)(305945005)(81166006)(86362001)(31686004);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR1201MB0260;H:BN6PR1201MB0035.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MF+x7QSGkmfN8htSSDGLuWDBL1PeReFcOmm0WxqnWm40EucxfEfJ0L+b41PQo0lk2dAsXE28sZNa5IOl5BGeYClf5MIXsllPQM6/OszmA2UIqfLIUanTaXEZ8tOJ/BoBA5w0NcamF2pW1CgEFTxEhfDmak4HWJ5oFGUNby4wE4cJk6q8bqaaX9WOCTHYTTDU/MRipzf0Y5nHxL3/A0ibqZdcF2HmQWtaenx8drXaDwP/rhsZ7oGExq1nUeP6QMWscVbcEyJwCEtPa6BuwiMenpuDF5b9Jjh9EIdWQx59VuHR9jeRXT4+pNr96BxG4zMN1q0OzRaXwJlPTsjLQwl4eoSQSf8eQpsnt3FQz2nfAzx32Rq1RuMsecIfnrWGHqQWb+smWSO48H/ST5k5DFuuzdrh94/Bi3xwsMog9kYzJUc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <294D3C562614794FA2E2F2E3C0D1A171@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3c5d55-afd6-49b8-2f98-08d6fe5f83c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 20:05:51.2324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vgupta@synopsys.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0260
X-OriginatorOrg: synopsys.com
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gNS8zMS8xOSAxOjIxIEFNLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4gT24gVGh1LCBNYXkg
MzAsIDIwMTkgYXQgMTE6MjI6NDJBTSAtMDcwMCwgVmluZWV0IEd1cHRhIHdyb3RlOg0KPj4gSGkg
UGV0ZXIsDQo+Pg0KPj4gSGFkIGFuIGludGVyZXN0aW5nIGx1bmNoIHRpbWUgZGlzY3Vzc2lvbiB3
aXRoIG91ciBoYXJkd2FyZSBhcmNoaXRlY3RzIHBlcnRpbmVudCB0bw0KPj4gIm1pbmltYWwgZ3Vh
cmFudGVlcyBleHBlY3RlZCBvZiBhIENQVSIgc2VjdGlvbiBvZiBtZW1vcnktYmFycmllcnMudHh0
DQo+Pg0KPj4NCj4+IHwgICgqKSBUaGVzZSBndWFyYW50ZWVzIGFwcGx5IG9ubHkgdG8gcHJvcGVy
bHkgYWxpZ25lZCBhbmQgc2l6ZWQgc2NhbGFyDQo+PiB8ICAgICB2YXJpYWJsZXMuICAiUHJvcGVy
bHkgc2l6ZWQiIGN1cnJlbnRseSBtZWFucyB2YXJpYWJsZXMgdGhhdCBhcmUNCj4+IHwgICAgIHRo
ZSBzYW1lIHNpemUgYXMgImNoYXIiLCAic2hvcnQiLCAiaW50IiBhbmQgImxvbmciLiAgIlByb3Bl
cmx5DQo+PiB8ICAgICBhbGlnbmVkIiBtZWFucyB0aGUgbmF0dXJhbCBhbGlnbm1lbnQsIHRodXMg
bm8gY29uc3RyYWludHMgZm9yDQo+PiB8ICAgICAiY2hhciIsIHR3by1ieXRlIGFsaWdubWVudCBm
b3IgInNob3J0IiwgZm91ci1ieXRlIGFsaWdubWVudCBmb3INCj4+IHwgICAgICJpbnQiLCBhbmQg
ZWl0aGVyIGZvdXItYnl0ZSBvciBlaWdodC1ieXRlIGFsaWdubWVudCBmb3IgImxvbmciLA0KPj4g
fCAgICAgb24gMzItYml0IGFuZCA2NC1iaXQgc3lzdGVtcywgcmVzcGVjdGl2ZWx5Lg0KPj4NCj4+
DQo+PiBJJ20gbm90IHN1cmUgaG93IHRvIGludGVycHJldCAibmF0dXJhbCBhbGlnbm1lbnQiIGZv
ciB0aGUgY2FzZSBvZiBkb3VibGUNCj4+IGxvYWQvc3RvcmVzIG9uIDMyLWJpdCBzeXN0ZW1zIHdo
ZXJlIHRoZSBoYXJkd2FyZSBhbmQgQUJJIGFsbG93IGZvciA0IGJ5dGUNCj4+IGFsaWdubWVudCAo
QVJDdjIgTEREL1NURCwgQVJNIExEUkQvU1RSRCAuLi4uKQ0KPiANCj4gTmF0dXJhbCBhbGlnbm1l
bnQ6ICEoKHVpbnRwdHJfdClwdHIgJSBzaXplb2YoKnB0cikpDQo+IA0KPiBGb3IgYW55IHU2NCB0
eXBlLCB0aGF0IHdvdWxkIGdpdmUgOCBieXRlIGFsaWdubWVudC4gdGhlIHByb2JsZW0NCj4gb3Ro
ZXJ3aXNlIGJlaW5nIHRoYXQgeW91ciBkYXRhIHNwYW5zIHR3byBsaW5lcy9wYWdlcyBldGMuLg0K
PiANCj4+IEkgcHJlc3VtZSAoYW5kIHRoZSBxdWVzdGlvbikgdGhhdCBsa21tIGRvZXNuJ3QgZXhw
ZWN0IHN1Y2ggOCBieXRlIGxvYWQvc3RvcmVzIHRvDQo+PiBiZSBhdG9taWMgdW5sZXNzIDgtYnl0
ZSBhbGlnbmVkDQo+Pg0KPj4gQVJNdjcgYXJjaCByZWYgbWFudWFsIHNlZW1zIHRvIGNvbmZpcm0g
dGhpcy4gUXVvdGluZw0KPj4NCj4+IHwgTERNLCBMREMsIExEQzIsIExEUkQsIFNUTSwgU1RDLCBT
VEMyLCBTVFJELCBQVVNILCBQT1AsIFJGRSwgU1JTLCBWTERNLCBWTERSLA0KPj4gfCBWU1RNLCBh
bmQgVlNUUiBpbnN0cnVjdGlvbnMgYXJlIGV4ZWN1dGVkIGFzIGEgc2VxdWVuY2Ugb2Ygd29yZC1h
bGlnbmVkIHdvcmQNCj4+IHwgYWNjZXNzZXMuIEVhY2ggMzItYml0IHdvcmQgYWNjZXNzIGlzIGd1
YXJhbnRlZWQgdG8gYmUgc2luZ2xlLWNvcHkgYXRvbWljLiBBDQo+PiB8IHN1YnNlcXVlbmNlIG9m
IHR3byBvciBtb3JlIHdvcmQgYWNjZXNzZXMgZnJvbSB0aGUgc2VxdWVuY2UgbWlnaHQgbm90IGV4
aGliaXQNCj4+IHwgc2luZ2xlLWNvcHkgYXRvbWljaXR5DQo+Pg0KPj4gV2hpbGUgaXQgc2VlbXMg
cmVhc29uYWJsZSBmb3JtIGhhcmR3YXJlIHBvdiB0byBub3QgaW1wbGVtZW50IHN1Y2ggYXRvbWlj
aXR5IGJ5DQo+PiBkZWZhdWx0IGl0IHNlZW1zIHRoZXJlJ3MgYW4gYWRkaXRpb25hbCBidXJkZW4g
b24gYXBwbGljYXRpb24gd3JpdGVycy4gVGhleSBjb3VsZA0KPj4gYmUgaGFwcGlseSB1c2luZyBh
IGxvY2tsZXNzIGFsZ29yaXRobSB3aXRoIGp1c3QgYSBzaGFyZWQgZmxhZyBiZXR3ZWVuIDIgdGhy
ZWFkcw0KPj4gdy9vIG5lZWQgZm9yIGFueSBleHBsaWNpdCBzeW5jaHJvbml6YXRpb24uDQo+IA0K
PiBJZiB5b3UncmUgdGhhdCBjYXJlbGVzcyB3aXRoIGxvY2tsZXNzIGNvZGUsIHlvdSBkZXNlcnZl
IGFsbCB0aGUgcGFpbiB5b3UNCj4gZ2V0Lg0KPiANCj4+IEJ1dCB1cGdyYWRlIHRvIGEgbmV3IGNv
bXBpbGVyIHdoaWNoDQo+PiBhZ2dyZXNzaXZlbHkgInBhY2tzIiBzdHJ1Y3QgcmVuZGVyaW5nIGxv
bmcgbG9uZyAzMi1iaXQgYWxpZ25lZCAodnMuIDY0LWJpdCBiZWZvcmUpDQo+PiBjYXVzaW5nIHRo
ZSBjb2RlIHRvIHN1ZGRlbmx5IHN0b3Agd29ya2luZy4gSXMgdGhlIG9udXMgb24gdGhlbSB0byBk
ZWNsYXJlIHN1Y2gNCj4+IG1lbW9yeSBhcyBjMTEgYXRvbWljIG9yIHNvbWUgc3VjaC4NCj4gDQo+
IFdoZW4gYSBwcm9ncmFtbWVyIHdhbnRzIGd1YXJhbnRlZXMgdGhleSBhbHJlYWR5IG5lZWQgdG8g
a25vdyB3dGggdGhleSdyZQ0KPiBkb2luZy4NCj4gDQo+IEFuZCBJJ2xsIHN0YW5kIGJ5IG15IGVh
cmxpZXIgY29udmljdGlvbiB0aGF0IGFueSBhcmNoaXRlY3R1cmUgdGhhdCBoYXMgYQ0KPiBuYXRp
dmUgdTY0IChiZSBpdCBhIDY0Yml0IGFyY2ggb3IgYSAzMmJpdCB3aXRoIGRvdWJsZS13aWR0aA0K
PiBpbnN0cnVjdGlvbnMpIGJ1dCBoYXMgYW4gQUJJIHRoYXQgYWxsb3dzIHUzMiBhbGlnbm1lbnQg
b24gdGhlbSBpcyBkYWZ0Lg0KDQpTbyBJIGFncmVlIHdpdGggUGF1bCdzIGFzc2VydGlvbiB0aGF0
IGl0IGlzIHN0cmFuZ2UgZm9yIDgtYnl0ZSB0eXBlIGJlaW5nIDQtYnl0ZQ0KYWxpZ25lZCBvbiBh
IDY0LWJpdCBzeXN0ZW0sIGJ1dCBpcyBpdCB0b3RhbGx5IGJyb2tlbiBldmVuIGlmIHRoZSBJU0Eg
b2YgdGhlIHNhaWQNCjY0LWJpdCBhcmNoIGFsbG93cyBMRC9TVCB0byBiZSBhdWdtZW50ZWQgd2l0
aCBhY3EvcmVsIHJlc3BlY3RpdmVseS4NCg0KU2F5IHRoZSBJU0EgZ3VhcmFudGVlcyBzaW5nbGUt
Y29weSBhdG9taWNpdHkgZm9yIGFsaWduZWQgY2FzZXMgKGkuZS4gZm9yIDgtYnl0ZQ0KZGF0YSBv
bmx5IGlmIGl0IGlzIG5hdHVyYWxseSBhbGlnbmVkKSBhbmQgaW4gbGFjayB0aGVyZW9mIHByb2dy
YW1tZXIgbmVlZHMgdG8gdXNlDQp0aGUgcHJvcGVyIGFjcS9yZWxlYXNlDQoNCkluIG15IGVhcmxp
ZXIgZXhhbXBsZSBvbiBsb2NrbGVzcyBjb2RlLCB3ZSBkbyBhc3N1bWUgdGhhdCBwcm9ncmFtbWVy
IHdpbGwgdXNlIGENCnJlbGVhc2UgaW4gdGhlIHVwZGF0ZSBvZiBmbGFnLg0K
