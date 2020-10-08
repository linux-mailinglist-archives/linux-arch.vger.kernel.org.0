Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED20287EC7
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 00:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgJHWoB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Oct 2020 18:44:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:32662 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgJHWoB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Oct 2020 18:44:01 -0400
IronPort-SDR: nKfrJNhAMOSXlqgRC3Dabfzk4pIErrFghjTYzP4NpM4GHZ7H5Gh1vuUhNIvTXbWMUm7EJhPycv
 vg1ZvIBhHFaA==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="182850148"
X-IronPort-AV: E=Sophos;i="5.77,352,1596524400"; 
   d="scan'208";a="182850148"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 15:44:00 -0700
IronPort-SDR: 29KQQ8jOnuh7nFpCT+2yUCwax0I/wsiJJwfT9xs0Q63Ziz8Y9VIh5QcAB7zYTQyDaxVTJxpMVu
 fERj3glWSnOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,352,1596524400"; 
   d="scan'208";a="328713790"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 08 Oct 2020 15:44:00 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 8 Oct 2020 15:44:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 8 Oct 2020 15:44:00 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 8 Oct 2020 15:43:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/Vw/IUHYaXY8CZu3B4Kw7E0i7EtBKWxtZicVh2vBnaYxVStoVD9Zn8ZgnzZKlAC4B+GF25iPJK3lLB++9bjQ7zWDK1aYk7J95KJbTgYdKQxVnHTftK0bDPyFMvJ+YaHJQwhBx7fIu/+aXaHr7M7X15nRDZe2e8ON7Ximcdw9lIVBSffM5xkvNlwNDJBDsiuUH0PlDgvZB6VRT0abaS5CqLMKKM+e7QwXn/WS46gBX7tmzG07QCRG8tpmCAmudJW7+amGV29qHcTveDbuUIXrQuykHPKN18cAInJ/ZT3PG3EJDa1ZGCgWmbbz65mAXwd43RwGwevrLCnpE4kUBYFMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtInekmf15S4lZ6aAXYXeCzfQKdRGmKcmwTNTkJMMJE=;
 b=MFaNYHm5f7SWLWHNuE2B9msLvNMmwAKumLcmTpZpD0KSZGtdJX9bniD3C61JKQdKADxWuzmGiEM/AfJtxiL0lPMRy93xTEXcntCqh3I/JXC3G0SJ2cmsf4g3lFlL0/B+gUOYJuf5Ihy0BhNltpaZYV1jKr0M0/RSS1/EPZ1vtlm7h5hBJxJwbUIa3Rny36uGv0cTkaqy4DxcQpnoHyvG+4GGXvbyPWjb/Qe0WOfGSGdFC6nTpiIzl0n4zuiv81hhPsAu2E/aijYMCk9Sz+VSvZmb2rH+S+bNvUP/EHUBMdd+usFyUvecWxDrUeON9uhWgYa0bbV5cgNzirYTvw9mCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtInekmf15S4lZ6aAXYXeCzfQKdRGmKcmwTNTkJMMJE=;
 b=RYOHVBCOzSyz3WRNhgBSgCP2AFIut/O5togTnrKzZh7yPaNl5LhY1ShxPossblZ+o8B9t4FEN4BHbsLQ/LmI+6JK7rTU6+UcOi9kMnd7O1XR3CY6hFTbcfqqJGZJzyhxvPPz6lNEtIPdoBrYeFtkJGjDRCkMMY4DW4MTneHTQhc=
Received: from BY5PR11MB4056.namprd11.prod.outlook.com (2603:10b6:a03:18c::17)
 by BYAPR11MB2616.namprd11.prod.outlook.com (2603:10b6:a02:c6::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.38; Thu, 8 Oct
 2020 22:43:51 +0000
Received: from BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::c598:3d8c:3693:1e58]) by BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::c598:3d8c:3693:1e58%7]) with mapi id 15.20.3455.023; Thu, 8 Oct 2020
 22:43:51 +0000
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
Thread-Index: AQHWlqPb4orsg9VMkES69WmcwzLj6qmJDXUAgAHVeQCAARKygIACZVOA
Date:   Thu, 8 Oct 2020 22:43:50 +0000
Message-ID: <20ae46ae9b74036723ff7b9f731374f78536dc88.camel@intel.com>
References: <20200929205746.6763-1-chang.seok.bae@intel.com>
         <20200929205746.6763-2-chang.seok.bae@intel.com>
         <20201005134230.GS6642@arm.com>
         <74ca7e8a61f051eadc895cf8b29e591cc3d0f548.camel@intel.com>
         <20201007100558.GE6642@arm.com>
In-Reply-To: <20201007100558.GE6642@arm.com>
Reply-To: "Bae, Chang Seok" <chang.seok.bae@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36ba3cc0-bc62-4459-4d4f-08d86bdba105
x-ms-traffictypediagnostic: BYAPR11MB2616:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB26169E61792D444D33541F6BD80B0@BYAPR11MB2616.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L/GqcZYc88kyIO4wJHB8uaK0YhFthdYScqPA1CdQcPVOu0Od3UtYTGIgg6aW/6IA1RW7PnrSnXWpGX4xvzB9IZuSK5B4M9hikp7tamohH98910Ub3E5cWN38MKm7HpywZGJ/T2PlcCvvWBlGT9P7sC3yWtIbWzXjSp9ms+7E++P23QLMib+7gGyR2XkvBdO3MLNlRawTX4T9EnS/6x9Z/Yu29CXgqLhYQkpQH4VOwUGsyzW3hZJlKGy0kG20BNoWL7ctj6mB+OfLSUwcb/QWQBFflsDxlcI3Zh+vRCHC2Mqkft65wh6GBlSLs3lMNSyZbxLY82DDH77AAJjc1d7Tyt8QVFSZWfLtgdATqGHJZ8NpYYYveOsFVHsAeqhL9yJbqP7N8QW4b4v12I8yQJWPiap74K5nq65Bvku4v091ERcnUGbX5anS6a46Z9JJtKtAuyNYD6mlMDO7YMWSqE9Zr9xEf97hrMYBy6TP7CQAMOk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4056.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(66556008)(6506007)(5660300002)(6916009)(6486002)(478600001)(36756003)(83380400001)(2906002)(71200400001)(2616005)(186003)(64756008)(76116006)(66446008)(66946007)(966005)(3450700001)(86362001)(66476007)(26005)(83080400001)(8936002)(54906003)(4326008)(6512007)(7416002)(316002)(8676002)(99106002)(15583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: D5FP+VSCg/uxr0aD2ghfNa61xZXukXGAmgJg1zzf9mPT5L5HOKdFM6fz7RM5gjfXbHNorSFlDv9GzS67PH/L9RUfI/sVUQlQ1RD4AH04oRB2OyV3Eq4zOc2yGATOFGMhiRhXfL4+zLfQvaJ6XIzHwam3ZmgEXOLHJH/QquSzra/i5cth7vONyArDokhRP8esHAr1IF4Izv86ItqXXqL4MuhUkZ1C3GiGm3XeMuF+TIV+RDsfUtu451uKGdirFTnf4x2aQlPdOd/zwz5bxkBVNBGl8egafr358LtxZjSWU7TF0z+nDF8M15/fE8OIkpjoADnxyNgSBpe7K+gc3mgDWy0OPCnu37ifPc+K5koZFzeRH9VzHP1FpAtZHaBF44+EKKp42J8z/v7nW2jHRUvwCcHs/dd4P3zVeLCdc/zdO6mCsMd3PCwGRB9zPJmkNZkpG/3ip+rM11Ts+LwkX/tjNxS6nkOCzJwE9+mFNgKqUVNJ+HXqSawcee5cbt8WA8qtldYNqtMFO9Rr8tdIhkWteQrP5KgNpF2w1HzN8YBmBMEvAmGkn9krUi4x7pGtC8qXojZBlDuEr83P0R6JLKsUK+fiCEqKVo1uVPfAhUQi9RW48bttDLHnlLg0rE8xaXcTfGG1Yjb3RGWpRaBOEmP+GA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4F9E272181C8448BA4DE9991575652D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4056.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ba3cc0-bc62-4459-4d4f-08d86bdba105
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2020 22:43:50.9388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UOGOMja8dkjCMxd9dRI1Mq5ihfwip9pSKuAtCnHZkpN0G3xMREe+FgvpufJJ9JY+lOHhgmmRCk2tFzHFsj9fHjIQkx+drgwjhVu3JrAYyzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2616
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gV2VkLCAyMDIwLTEwLTA3IGF0IDExOjA1ICswMTAwLCBEYXZlIE1hcnRpbiB3cm90ZToNCj4g
T24gVHVlLCBPY3QgMDYsIDIwMjAgYXQgMDU6NDU6MjRQTSArMDAwMCwgQmFlLCBDaGFuZyBTZW9r
IHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAyMC0xMC0wNSBhdCAxNDo0MiArMDEwMCwgRGF2ZSBNYXJ0
aW4gd3JvdGU6DQo+ID4gPiBPbiBUdWUsIFNlcCAyOSwgMjAyMCBhdCAwMTo1Nzo0M1BNIC0wNzAw
LCBDaGFuZyBTLiBCYWUgd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiArLyoNCj4gPiA+ID4gKyAq
IFRoZSBGUCBzdGF0ZSBmcmFtZSBjb250YWlucyBhbiBYU0FWRSBidWZmZXIgd2hpY2ggbXVzdCBi
ZSA2NC1ieXRlIGFsaWduZWQuDQo+ID4gPiA+ICsgKiBJZiBhIHNpZ25hbCBmcmFtZSBzdGFydHMg
YXQgYW4gdW5hbGlnbmVkIGFkZHJlc3MsIGV4dHJhIHNwYWNlIGlzIHJlcXVpcmVkLg0KPiA+ID4g
PiArICogVGhpcyBpcyB0aGUgbWF4IGFsaWdubWVudCBwYWRkaW5nLCBjb25zZXJ2YXRpdmVseS4N
Cj4gPiA+ID4gKyAqLw0KPiA+ID4gPiArI2RlZmluZSBNQVhfWFNBVkVfUEFERElORwk2M1VMDQo+
ID4gPiA+ICsNCj4gPiA+ID4gKy8qDQo+ID4gPiA+ICsgKiBUaGUgZnJhbWUgZGF0YSBpcyBjb21w
b3NlZCBvZiB0aGUgZm9sbG93aW5nIGFyZWFzIGFuZCBsYWlkIG91dCBhczoNCj4gPiA+ID4gKyAq
DQo+ID4gPiA+ICsgKiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gPiA+ICsgKiB8IGFs
aWdubWVudCBwYWRkaW5nICAgICB8DQo+ID4gPiA+ICsgKiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQo+ID4gPiA+ICsgKiB8IChmKXhzYXZlIGZyYW1lICAgICAgICB8DQo+ID4gPiA+ICsgKiAt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gPiA+ICsgKiB8IGZzYXZlIGhlYWRlciAgICAg
ICAgICB8DQo+ID4gPiA+ICsgKiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gPiA+ICsg
KiB8IHNpZ2luZm8gKyB1Y29udGV4dCAgICB8DQo+ID4gPiA+ICsgKiAtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQo+ID4gPiA+ICsgKi8NCj4gPiA+ID4gKw0KPiA+ID4gPiArLyogbWF4X2ZyYW1l
X3NpemUgdGVsbHMgdXNlcnNwYWNlIHRoZSB3b3JzdCBjYXNlIHNpZ25hbCBzdGFjayBzaXplLiAq
Lw0KPiA+ID4gPiArc3RhdGljIHVuc2lnbmVkIGxvbmcgX19yb19hZnRlcl9pbml0IG1heF9mcmFt
ZV9zaXplOw0KPiA+ID4gPiArDQo+ID4gPiA+ICt2b2lkIF9faW5pdCBpbml0X3NpZ2ZyYW1lX3Np
emUodm9pZCkNCj4gPiA+ID4gK3sNCj4gPiA+ID4gKwkvKg0KPiA+ID4gPiArCSAqIFVzZSB0aGUg
bGFyZ2VzdCBvZiBwb3NzaWJsZSBzdHJ1Y3R1cmUgZm9ybWF0cy4gVGhpcyBtaWdodA0KPiA+ID4g
PiArCSAqIHNsaWdodGx5IG92ZXJzaXplIHRoZSBmcmFtZSBmb3IgNjQtYml0IGFwcHMuDQo+ID4g
PiA+ICsJICovDQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlpZiAoSVNfRU5BQkxFRChDT05GSUdfWDg2
XzMyKSB8fA0KPiA+ID4gPiArCSAgICBJU19FTkFCTEVEKENPTkZJR19JQTMyX0VNVUxBVElPTikp
DQo+ID4gPiA+ICsJCW1heF9mcmFtZV9zaXplID0gbWF4KCh1bnNpZ25lZCBsb25nKVNJWkVPRl9z
aWdmcmFtZV9pYTMyLA0KPiA+ID4gPiArCQkJCSAgICAgKHVuc2lnbmVkIGxvbmcpU0laRU9GX3J0
X3NpZ2ZyYW1lX2lhMzIpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJaWYgKElTX0VOQUJMRUQoQ09O
RklHX1g4Nl9YMzJfQUJJKSkNCj4gPiA+ID4gKwkJbWF4X2ZyYW1lX3NpemUgPSBtYXgobWF4X2Zy
YW1lX3NpemUsICh1bnNpZ25lZCBsb25nKVNJWkVPRl9ydF9zaWdmcmFtZV94MzIpOw0KPiA+ID4g
PiArDQo+ID4gPiA+ICsJaWYgKElTX0VOQUJMRUQoQ09ORklHX1g4Nl82NCkpDQo+ID4gPiA+ICsJ
CW1heF9mcmFtZV9zaXplID0gbWF4KG1heF9mcmFtZV9zaXplLCAodW5zaWduZWQgbG9uZylTSVpF
T0ZfcnRfc2lnZnJhbWUpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJbWF4X2ZyYW1lX3NpemUgKz0g
ZnB1X19nZXRfZnBzdGF0ZV9zaWdmcmFtZV9zaXplKCkgKyBNQVhfWFNBVkVfUEFERElORzsNCj4g
PiA+IA0KPiA+ID4gRm9yIGFybTY0LCB3ZSByb3VuZCB0aGUgd29yc3QtY2FzZSBwYWRkaW5nIHVw
IGJ5IG9uZS4NCj4gPiA+IA0KPiA+IA0KPiA+IFllYWgsIEkgc2F3IHRoYXQuIFRoZSBBUk0gY29k
ZSBhZGRzIHRoZSBtYXggcGFkZGluZywgdG9vOg0KPiA+IA0KPiA+IAlzaWduYWxfbWluc2lnc3Rr
c3ogPSBzaWdmcmFtZV9zaXplKCZ1c2VyKSArDQo+ID4gCQlyb3VuZF91cChzaXplb2Yoc3RydWN0
IGZyYW1lX3JlY29yZCksIDE2KSArDQo+ID4gCQkxNjsgLyogbWF4IGFsaWdubWVudCBwYWRkaW5n
ICovDQo+ID4gDQo+ID4gDQo+ID4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4
L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvYXJjaC9hcm02NC9rZXJuZWwvc2ln
bmFsLmMjbjk3Mw0KPiA+IA0KPiA+ID4gSSBjYW4ndCByZW1lbWJlciB0aGUgZnVsbCByYXRpb25h
bGUgZm9yIHRoaXMsIGJ1dCBpdCBhdCBsZWFzdCBzZWVtZWQgYQ0KPiA+ID4gYml0IHdlaXJkIHRv
IHJlcG9ydCBhIHNpemUgdGhhdCBpcyBub3QgYSBtdWx0aXBsZSBvZiB0aGUgYWxpZ25tZW50Lg0K
PiA+ID4gDQo+ID4gDQo+ID4gQmVjYXVzZSB0aGUgbGFzdCBzdGF0ZSBzaXplIG9mIFhTQVZFIG1h
eSBub3QgYmUgNjRCIGFsaWduZWQsIHRoZSAocmVwb3J0ZWQpDQo+ID4gc3VtIG9mIHhzdGF0ZSBz
aXplIGhlcmUgZG9lcyBub3QgZ3VhcmFudGVlIDY0QiBhbGlnbm1lbnQuDQo+ID4gDQo+ID4gPiBJ
J20gY2FuJ3QgdGhpbmsgb2YgYSBjbGVhciBhcmd1bWVudCBhcyB0byB3aHkgaXQgcmVhbGx5IG1h
dHRlcnMsIHRob3VnaC4NCj4gPiANCj4gPiBXZSBjYXJlIGFib3V0IHRoZSBzdGFydCBvZiBYU0FW
RSBidWZmZXIgZm9yIHRoZSBYU0FWRSBpbnN0cnVjdGlvbnMsIHRvIGJlDQo+ID4gNjRCLWFsaWdu
ZWQuDQo+IA0KPiBBaCwgSSBzZWUuICBUaGF0IG1ha2VzIHNlbnNlLg0KPiANCj4gRm9yIGFybTY0
LCB0aGVyZSBpcyBubyBhZGRpdGlvbmFsIGFsaWdubWVudCBwYWRkaW5nIGluc2lkZSB0aGUgZnJh
bWUsDQo+IG9ubHkgdGhlIHBhZGRpbmcgaW5zZXJ0ZWQgYWZ0ZXIgdGhlIGZyYW1lIHRvIGVuc3Vy
ZSB0aGF0IHRoZSBiYXNlDQo+IGFkZHJlc3MgaXMgMTYtYnl0ZSBhbGlnbmVkLg0KPiANCj4gSG93
ZXZlciwgSSB3b25kZXIgd2hldGhlciBwZW9wbGUgd2lsbCB0ZW5kIHRvIGFzc3VtZSB0aGF0IEFU
X01JTlNJR1NUS1NaDQo+IGlzIGEgc2Vuc2libGUgKGlmIG1pbmltYWwpIGFtb3VudCBvZiBzdGFj
ayB0byBhbGxvY2F0ZS4gIEFsbG9jYXRpbmcgYW4NCj4gb2RkIG51bWJlciBvZiBieXRlcywgb3Ig
YW55IGFtb3VudCB0aGF0IGlzbid0IGEgbXVsdGlwbGUgb2YgdGhlDQo+IGFyY2hpdGVjdHVyZSdz
IHByZWZlcnJlZCAob3IgbWFuZGF0ZWQpIHN0YWNrIGFsaWdubWVudCBwcm9iYWJseSBkb2Vzbid0
DQo+IG1ha2Ugc2Vuc2UuDQo+IA0KPiBBQXJjaDY0IGhhcyBhIG1hbmRhdG9yeSBzdGFjayBhbGln
bm1lbnQgb2YgMTYgYnl0ZXM7IEknbSBub3Qgc3VyZSBhYm91dA0KPiB4ODYuDQoNClRoZSB4ODYg
QUJJIGxvb2tzIHRvIHJlcXVpcmUgMTYtYnl0ZSBhbGlnbm1lbnQgKGZvciBib3RoIDMyLS82NC1i
aXQgbW9kZXMpLg0KRldJVywgdGhlIDMyLWJpdCBBQkkgZ290IGNoYW5nZWQgZnJvbSA0LWJ5dGUg
YWxpZ25lbWVudC4NCg0KVGhhbmsgeW91IGZvciBicmluaW5nIHVwIHRoZSBwb2ludC4gQWNrLiBU
aGUga2VybmVsIGlzIGV4cGVjdGVkIHRvIHJldHVybiBhDQoxNi1ieXRlIGFsaWduZWQgc2l6ZS4g
SSBtYWRlIHRoaXMgY2hhbmdlIGFmdGVyIGEgZGlzY3Vzc2lvbiB3aXRoIEguSi46DQoNCmRpZmYg
LS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvc2lnbmFsLmMgYi9hcmNoL3g4Ni9rZXJuZWwvc2lnbmFs
LmMNCmluZGV4IGMwNDIyMzZlZjUyZS4uNTI4MTVkN2MwOGZiIDEwMDY0NA0KLS0tIGEvYXJjaC94
ODYva2VybmVsL3NpZ25hbC5jDQorKysgYi9hcmNoL3g4Ni9rZXJuZWwvc2lnbmFsLmMNCkBAIC0y
MTIsNiArMjEyLDExIEBAIGRvIHsJCQkJCQkJDQoJCVwNCiAgKiBTZXQgdXAgYSBzaWduYWwgZnJh
bWUuDQogICovDQogDQorLyogeDg2IEFCSSByZXF1aXJlcyAxNi1ieXRlIGFsaWdubWVudCAqLw0K
KyNkZWZpbmUgRlJBTUVfQUxJR05NRU5UCTE2VUwNCisNCisjZGVmaW5lIE1BWF9GUkFNRV9QQURE
SU5HCUZSQU1FX0FMSUdOTUVOVCAtIDENCisNCiAvKg0KICAqIERldGVybWluZSB3aGljaCBzdGFj
ayB0byB1c2UuLg0KICAqLw0KQEAgLTIyMiw5ICsyMjcsOSBAQCBzdGF0aWMgdW5zaWduZWQgbG9u
ZyBhbGlnbl9zaWdmcmFtZSh1bnNpZ25lZCBsb25nIHNwKQ0KIAkgKiBBbGlnbiB0aGUgc3RhY2sg
cG9pbnRlciBhY2NvcmRpbmcgdG8gdGhlIGkzODYgQUJJLA0KIAkgKiBpLmUuIHNvIHRoYXQgb24g
ZnVuY3Rpb24gZW50cnkgKChzcCArIDQpICYgMTUpID09IDAuDQogCSAqLw0KLQlzcCA9ICgoc3Ag
KyA0KSAmIC0xNnVsKSAtIDQ7DQorCXNwID0gKChzcCArIDQpICYgLUZSQU1FX0FMSUdOTUVOVCkg
LSA0Ow0KICNlbHNlIC8qICFDT05GSUdfWDg2XzMyICovDQotCXNwID0gcm91bmRfZG93bihzcCwg
MTYpIC0gODsNCisJc3AgPSByb3VuZF9kb3duKHNwLCBGUkFNRV9BTElHTk1FTlQpIC0gODsNCiAj
ZW5kaWYNCiAJcmV0dXJuIHNwOw0KIH0NCkBAIC00MDQsNyArNDA5LDcgQEAgc3RhdGljIGludCBf
X3NldHVwX3J0X2ZyYW1lKGludCBzaWcsIHN0cnVjdCBrc2lnbmFsDQoqa3NpZywNCiAJdW5zYWZl
X3B1dF9zaWdjb250ZXh0KCZmcmFtZS0+dWMudWNfbWNvbnRleHQsIGZwLCByZWdzLCBzZXQsDQpF
ZmF1bHQpOw0KIAl1bnNhZmVfcHV0X3NpZ21hc2soc2V0LCBmcmFtZSwgRWZhdWx0KTsNCiAJdXNl
cl9hY2Nlc3NfZW5kKCk7DQotCQ0KKw0KIAlpZiAoY29weV9zaWdpbmZvX3RvX3VzZXIoJmZyYW1l
LT5pbmZvLCAma3NpZy0+aW5mbykpDQogCQlyZXR1cm4gLUVGQVVMVDsNCiANCkBAIC02ODUsNiAr
NjkwLDggQEAgU1lTQ0FMTF9ERUZJTkUwKHJ0X3NpZ3JldHVybikNCiAgKiAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQogICogfCBmc2F2ZSBoZWFkZXIgICAgICAgICAgfA0KICAqIC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCisgKiB8IGFsaWdubWVudCBwYWRkaW5nICAgICB8DQorICogLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KICAqIHwgc2lnaW5mbyArIHVjb250ZXh0ICAgIHwNCiAg
KiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogICovDQpAQCAtNzEwLDcgKzcxNywxMiBAQCB2
b2lkIF9faW5pdCBpbml0X3NpZ2ZyYW1lX3NpemUodm9pZCkNCiAJaWYgKElTX0VOQUJMRUQoQ09O
RklHX1g4Nl82NCkpDQogCQltYXhfZnJhbWVfc2l6ZSA9IG1heChtYXhfZnJhbWVfc2l6ZSwgKHVu
c2lnbmVkDQpsb25nKVNJWkVPRl9ydF9zaWdmcmFtZSk7DQogDQorCW1heF9mcmFtZV9zaXplICs9
IE1BWF9GUkFNRV9QQURESU5HOw0KKw0KIAltYXhfZnJhbWVfc2l6ZSArPSBmcHVfX2dldF9mcHN0
YXRlX3NpZ2ZyYW1lX3NpemUoKSArDQpNQVhfWFNBVkVfUEFERElORzsNCisNCisJLyogVXNlcnNw
YWNlIGV4cGVjdHMgYW4gYWxpZ25lZCBzaXplLiAqLw0KKwltYXhfZnJhbWVfc2l6ZSA9IHJvdW5k
X3VwKG1heF9mcmFtZV9zaXplLCBGUkFNRV9BTElHTk1FTlQpOw0KIH0NCiANCiB1bnNpZ25lZCBs
b25nIGdldF9zaWdmcmFtZV9zaXplKHZvaWQpDQoNCg0KVGhhbmtzLA0KQ2hhbmcNCg0KDQoNCg==
