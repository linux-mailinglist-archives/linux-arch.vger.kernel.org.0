Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C2B28511F
	for <lists+linux-arch@lfdr.de>; Tue,  6 Oct 2020 19:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgJFRpq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Oct 2020 13:45:46 -0400
Received: from mga04.intel.com ([192.55.52.120]:10281 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgJFRpq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Oct 2020 13:45:46 -0400
IronPort-SDR: OHu3DJ7yN7c3zGpBVZDx+VoyRDCSS4e70vNzxkL3UHD72pG5BEC74TZ4az9eNAYmcT/1NhUCBr
 8IOGJs3d2VdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="161984509"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="161984509"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 10:45:27 -0700
IronPort-SDR: JRARac7cDPmR+X8MJw/wxqcBuSJoJeHDKQi1PYPl7xZ5K9H0Ioz8dtX9kEUF0GRcJX3Dqa14pl
 iavSN+9ykVaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="343877768"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga008.jf.intel.com with ESMTP; 06 Oct 2020 10:45:27 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 6 Oct 2020 10:45:26 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 6 Oct 2020 10:45:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 6 Oct 2020 10:45:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uks/TUTiqxyWR5Xt3sOjQo3JQ7wXtfOSyHXCdoyycg9yBrNsf2vSOTH+qsx6PlmSVrQVRTTGhnyt5qP6p7qPdYdO6bxvGgUBRWVs/cztD9ZWLIsUleLEXaR4t9GhrO6dG5RpbPM9zODRKwvMC+nXwfy8pD417R8iNp8p3SUzE9G8kxNBqHJk/QgYp4xvY0odekj695Bl9DH+OwauIHd0at9iWC4JNXGwNGui+8XVRwXx7C6+Mq12Sn7vSQ5tB+lMqUZOTDdP4E7SFDyiiDVwsNw+WBvKHXNelRu07wDkeN4NCmQlyzHhh+P48uijGkDLRsuRjCIxkIXeX89SSmD4aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56JXqypUm6HJ75S5yy5NYCVLCtNMWiszFuK8RLgR2Zo=;
 b=Hh2alINsNTC4Emz5DhxevSj9dRoc8ySC60uL4LH0CQZT+B27H94q/wH1EGFpeMcVJGRVI+qL7vW2WFXOmHw6pCptNEEm1i/vdFA5cmszLd+A+puEvNvu2ySF/g5GtJkgL2MdyGfHsD4Txj6dormkBbGseNwj7LLv0w+iKtlvy/02KxtG3UhlvKlbllXV46ARLKCR80qHnQJ5+YCcIrgJVSet/brMisoZvQr8iOoGLeJhAy7oEx6/RUaQBzUz+2VgjkqgIpirrUvUV6TrHx+pjKAJSJ+TKhdvQv4HkMQ/PKzlnzlUT3rwLfCOIkw3aV3i9UcozTgvUiPoQzrc/+UxwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56JXqypUm6HJ75S5yy5NYCVLCtNMWiszFuK8RLgR2Zo=;
 b=hE+VEGCRZ0NPz3Py0E3ZaGf0V12t38ENABaINmviLw+w9d9W1Ui2PA2jNGN9EijBtYQTWsjNWhe7GMHSfPiBRhmZJlelT0nGw1z4ghV1mDEUixVh8U1heMSmrTyoHTPpItAqEVB7xdu3FoJvmukh6N+VttL+xGfNCEdba5psl9o=
Received: from BY5PR11MB4056.namprd11.prod.outlook.com (2603:10b6:a03:18c::17)
 by BYAPR11MB3368.namprd11.prod.outlook.com (2603:10b6:a03:1b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.41; Tue, 6 Oct
 2020 17:45:24 +0000
Received: from BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::c598:3d8c:3693:1e58]) by BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::c598:3d8c:3693:1e58%7]) with mapi id 15.20.3455.021; Tue, 6 Oct 2020
 17:45:24 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     "Dave.Martin@arm.com" <Dave.Martin@arm.com>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "bp@suse.de" <bp@suse.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Brown, Len" <len.brown@intel.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>
Subject: Re: [RFC PATCH 1/4] x86/signal: Introduce helpers to get the maximum
 signal frame size
Thread-Topic: [RFC PATCH 1/4] x86/signal: Introduce helpers to get the maximum
 signal frame size
Thread-Index: AQHWlqPb4orsg9VMkES69WmcwzLj6qmJDXUAgAHVeQA=
Date:   Tue, 6 Oct 2020 17:45:24 +0000
Message-ID: <74ca7e8a61f051eadc895cf8b29e591cc3d0f548.camel@intel.com>
References: <20200929205746.6763-1-chang.seok.bae@intel.com>
         <20200929205746.6763-2-chang.seok.bae@intel.com>
         <20201005134230.GS6642@arm.com>
In-Reply-To: <20201005134230.GS6642@arm.com>
Reply-To: "Bae, Chang Seok" <chang.seok.bae@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d2b4b1c-6650-462c-75be-08d86a1f9aec
x-ms-traffictypediagnostic: BYAPR11MB3368:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3368646EC32D664AB080C0B1D80D0@BYAPR11MB3368.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xzp0Ta+DQZ/LieEOUOdpZIjIeY97eaOC6K4cRVNi3s3ebeus2nXTVtYyjGnM+mzBTqWmPl7pf1il2po1HT6f3uSi0TlqoeUBpuW5b+DlZtbN7Ho9Wm424pkEGASLbTG7oDdtCqD157Tvvoc3GmRIoaogf/D2KyiKjuIrjmegMVp1fBVjrmRb77H3zb6V7U67ocEDvhnhePWr4c5E6BJEWHKgdIQVphaa5qNkP+4H8aFlVE7T/iK/H8S2PNAPAXLXgZqBd0bzN8xSBJ6JK8PKv3SAF7y6jbRGpfj1z3XJczqOosay2orUb/DvB4IBszgmNFEp8WJng+JGXQ+iuXnZhO0Va2ee0TxUBuXWYGE6HNSyZ2GFeyGjmweuXEnm8spD0R7ov6ww6rtTnw5JNcLqVBiTXuKExWPaCn10/DsLbhTxAQjGrrh1/6nq4SmTta9rJ++9EcoJEblpRqhabpwXSTE9ibz69rId825dwV9tBIw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4056.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(316002)(8936002)(2616005)(8676002)(6486002)(71200400001)(4326008)(83080400001)(186003)(2906002)(54906003)(86362001)(6506007)(5660300002)(3450700001)(478600001)(26005)(36756003)(6512007)(76116006)(6916009)(7416002)(64756008)(66446008)(66946007)(966005)(66476007)(66556008)(99106002)(15583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 6BBsyQSso6nsE3Wcg6wzHepYB6pska/wv66fSAO96xDIWHyl2Dn9jVMSz49tE2eCiAeaDB9FgJMW4POoXlQn86KzzqxG3MeJ7pBEr7MTDrT6AMe8OioWXXtIzh+DWPKOjOSlak8J9tRav176Ri3+p+FaxIbIUiAxD0kiddUoiAGNkKmt+a42nw2WtV9Qv/KNqd0bn7Mh+t7QJ/kOhj6Jfq543qBIjDV2NFba1b4HolzZTC/YRHGpRht16NqmaAVefr1lcPBPEa7UG5fg8hZpMxQ6ZRvR/ryE2UgvGMx62zuUXAvVIxqVVPSlz93j2QeZreocdduknrPwaVDvLyDhZ6EVyet4b+vuB7rKd9mBWtkq/6SWZ+X1p3yn2H5MqlmF2qRBXQWV5Hcp6PIaKrwdhRxJXoD+2ArDdAiIaxYi/VcZg20vVUMlO9JhSUcrdHnGNTr/phv9sCaInnAoe8dM8CRVFAOl5PsxmaxddytJl1hMGjklukdCwG5e31V5uYwzC5xlbsEg4WmKPPuFpw9vE7NdUb5KVyACj312lGZlP9cQ1vLCJk4HHeMJjdrtqXzAGd2A+AgEvYsnABnZ918eRio2Ysa4OLeETEvZtdI0gdMYL6Fx+QjIaZAm83aoAvRn7pbBKr2yT3olGmZLKMoyOg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DFCAE0ED2A822478FF376D88C5E3EF7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4056.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2b4b1c-6650-462c-75be-08d86a1f9aec
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2020 17:45:24.6684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5W8q+muDiuNdKaStA9gqMmX52/rUlRdbaBk0sTvvUHKyEx+yTBpEKSUHaMpUHMX0Nn+PIekR7xXCdU1EwnN4hbImpoi38Aw9tr4Kjjkma4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3368
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIwLTEwLTA1IGF0IDE0OjQyICswMTAwLCBEYXZlIE1hcnRpbiB3cm90ZToNCj4g
T24gVHVlLCBTZXAgMjksIDIwMjAgYXQgMDE6NTc6NDNQTSAtMDcwMCwgQ2hhbmcgUy4gQmFlIHdy
b3RlOg0KPiA+IA0KPiA+ICsvKg0KPiA+ICsgKiBUaGUgRlAgc3RhdGUgZnJhbWUgY29udGFpbnMg
YW4gWFNBVkUgYnVmZmVyIHdoaWNoIG11c3QgYmUgNjQtYnl0ZSBhbGlnbmVkLg0KPiA+ICsgKiBJ
ZiBhIHNpZ25hbCBmcmFtZSBzdGFydHMgYXQgYW4gdW5hbGlnbmVkIGFkZHJlc3MsIGV4dHJhIHNw
YWNlIGlzIHJlcXVpcmVkLg0KPiA+ICsgKiBUaGlzIGlzIHRoZSBtYXggYWxpZ25tZW50IHBhZGRp
bmcsIGNvbnNlcnZhdGl2ZWx5Lg0KPiA+ICsgKi8NCj4gPiArI2RlZmluZSBNQVhfWFNBVkVfUEFE
RElORwk2M1VMDQo+ID4gKw0KPiA+ICsvKg0KPiA+ICsgKiBUaGUgZnJhbWUgZGF0YSBpcyBjb21w
b3NlZCBvZiB0aGUgZm9sbG93aW5nIGFyZWFzIGFuZCBsYWlkIG91dCBhczoNCj4gPiArICoNCj4g
PiArICogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICsgKiB8IGFsaWdubWVudCBwYWRk
aW5nICAgICB8DQo+ID4gKyAqIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiArICogfCAo
Zil4c2F2ZSBmcmFtZSAgICAgICAgfA0KPiA+ICsgKiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
DQo+ID4gKyAqIHwgZnNhdmUgaGVhZGVyICAgICAgICAgIHwNCj4gPiArICogLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KPiA+ICsgKiB8IHNpZ2luZm8gKyB1Y29udGV4dCAgICB8DQo+ID4gKyAq
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiArICovDQo+ID4gKw0KPiA+ICsvKiBtYXhf
ZnJhbWVfc2l6ZSB0ZWxscyB1c2Vyc3BhY2UgdGhlIHdvcnN0IGNhc2Ugc2lnbmFsIHN0YWNrIHNp
emUuICovDQo+ID4gK3N0YXRpYyB1bnNpZ25lZCBsb25nIF9fcm9fYWZ0ZXJfaW5pdCBtYXhfZnJh
bWVfc2l6ZTsNCj4gPiArDQo+ID4gK3ZvaWQgX19pbml0IGluaXRfc2lnZnJhbWVfc2l6ZSh2b2lk
KQ0KPiA+ICt7DQo+ID4gKwkvKg0KPiA+ICsJICogVXNlIHRoZSBsYXJnZXN0IG9mIHBvc3NpYmxl
IHN0cnVjdHVyZSBmb3JtYXRzLiBUaGlzIG1pZ2h0DQo+ID4gKwkgKiBzbGlnaHRseSBvdmVyc2l6
ZSB0aGUgZnJhbWUgZm9yIDY0LWJpdCBhcHBzLg0KPiA+ICsJICovDQo+ID4gKw0KPiA+ICsJaWYg
KElTX0VOQUJMRUQoQ09ORklHX1g4Nl8zMikgfHwNCj4gPiArCSAgICBJU19FTkFCTEVEKENPTkZJ
R19JQTMyX0VNVUxBVElPTikpDQo+ID4gKwkJbWF4X2ZyYW1lX3NpemUgPSBtYXgoKHVuc2lnbmVk
IGxvbmcpU0laRU9GX3NpZ2ZyYW1lX2lhMzIsDQo+ID4gKwkJCQkgICAgICh1bnNpZ25lZCBsb25n
KVNJWkVPRl9ydF9zaWdmcmFtZV9pYTMyKTsNCj4gPiArDQo+ID4gKwlpZiAoSVNfRU5BQkxFRChD
T05GSUdfWDg2X1gzMl9BQkkpKQ0KPiA+ICsJCW1heF9mcmFtZV9zaXplID0gbWF4KG1heF9mcmFt
ZV9zaXplLCAodW5zaWduZWQgbG9uZylTSVpFT0ZfcnRfc2lnZnJhbWVfeDMyKTsNCj4gPiArDQo+
ID4gKwlpZiAoSVNfRU5BQkxFRChDT05GSUdfWDg2XzY0KSkNCj4gPiArCQltYXhfZnJhbWVfc2l6
ZSA9IG1heChtYXhfZnJhbWVfc2l6ZSwgKHVuc2lnbmVkIGxvbmcpU0laRU9GX3J0X3NpZ2ZyYW1l
KTsNCj4gPiArDQo+ID4gKwltYXhfZnJhbWVfc2l6ZSArPSBmcHVfX2dldF9mcHN0YXRlX3NpZ2Zy
YW1lX3NpemUoKSArIE1BWF9YU0FWRV9QQURESU5HOw0KPiANCj4gRm9yIGFybTY0LCB3ZSByb3Vu
ZCB0aGUgd29yc3QtY2FzZSBwYWRkaW5nIHVwIGJ5IG9uZS4NCj4gDQoNClllYWgsIEkgc2F3IHRo
YXQuIFRoZSBBUk0gY29kZSBhZGRzIHRoZSBtYXggcGFkZGluZywgdG9vOg0KDQoJc2lnbmFsX21p
bnNpZ3N0a3N6ID0gc2lnZnJhbWVfc2l6ZSgmdXNlcikgKw0KCQlyb3VuZF91cChzaXplb2Yoc3Ry
dWN0IGZyYW1lX3JlY29yZCksIDE2KSArDQoJCTE2OyAvKiBtYXggYWxpZ25tZW50IHBhZGRpbmcg
Ki8NCg0KDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90
b3J2YWxkcy9saW51eC5naXQvdHJlZS9hcmNoL2FybTY0L2tlcm5lbC9zaWduYWwuYyNuOTczDQoN
Cj4gSSBjYW4ndCByZW1lbWJlciB0aGUgZnVsbCByYXRpb25hbGUgZm9yIHRoaXMsIGJ1dCBpdCBh
dCBsZWFzdCBzZWVtZWQgYQ0KPiBiaXQgd2VpcmQgdG8gcmVwb3J0IGEgc2l6ZSB0aGF0IGlzIG5v
dCBhIG11bHRpcGxlIG9mIHRoZSBhbGlnbm1lbnQuDQo+IA0KDQpCZWNhdXNlIHRoZSBsYXN0IHN0
YXRlIHNpemUgb2YgWFNBVkUgbWF5IG5vdCBiZSA2NEIgYWxpZ25lZCwgdGhlIChyZXBvcnRlZCkN
CnN1bSBvZiB4c3RhdGUgc2l6ZSBoZXJlIGRvZXMgbm90IGd1YXJhbnRlZSA2NEIgYWxpZ25tZW50
Lg0KDQo+IEknbSBjYW4ndCB0aGluayBvZiBhIGNsZWFyIGFyZ3VtZW50IGFzIHRvIHdoeSBpdCBy
ZWFsbHkgbWF0dGVycywgdGhvdWdoLg0KDQpXZSBjYXJlIGFib3V0IHRoZSBzdGFydCBvZiBYU0FW
RSBidWZmZXIgZm9yIHRoZSBYU0FWRSBpbnN0cnVjdGlvbnMsIHRvIGJlDQo2NEItYWxpZ25lZC4N
Cg0KVGhhbmtzLA0KQ2hhbmcNCg==
