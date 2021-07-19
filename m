Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0A33CED86
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jul 2021 22:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351294AbhGSSyJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Jul 2021 14:54:09 -0400
Received: from mga14.intel.com ([192.55.52.115]:28381 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1382897AbhGSRnR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Jul 2021 13:43:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="210832226"
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; 
   d="scan'208";a="210832226"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 11:23:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; 
   d="scan'208";a="656996590"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga006.fm.intel.com with ESMTP; 19 Jul 2021 11:23:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 19 Jul 2021 11:23:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 19 Jul 2021 11:23:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Mon, 19 Jul 2021 11:23:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Mon, 19 Jul 2021 11:23:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BV2U/Mf9JAnco85KyhxHOl0S+ouaRVqPb9g88j+7Qr+BWrw5GufKQHt7ve3fsFpye/qNqZCWjDFBTee81mfDLYGJ4xkGNgUr4PiI8dDFtkhM98npKQbMuGun3LvydgrsFHHaP3dg3FjyOpksOkme5dzbzUBAo9Fpro6lH6r4xixeMNco9AnxaOc3xFs6rOTzCPxAJ8GPYuULNYB08f2pnOBzd4+NE+K5iN7u7jBplfPgA41l7UNA66FpzyHkQLLaBs9c1SE+ZnBMc0R6nbYjcziVC26uIfs6PHH6xF4EAMQp3Q5I7tsseOefCalefWMMLir8boarAoFa1QUq37Al8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WP5lj05K951cRFvT/tS216Ha7D8yZrFGZ5sY3FWPY5Y=;
 b=mnlHNczBRfE2d9Ey5Bx5BQAUtD/2fIBjoRO4h+XhXnNhBCn3afghZ6GXtZ/d/hpztz4IH3/toTtQeLHKQwXkRUcCadSsJO0lKhEzzJvC/NvzqLi9iO8SyY7HBcmsA8/Me7otGOyQOwvReT6vqYBdK6OVUSoEXfjMFEBq/K4qZIu82gYTomCn3HgDE3F41sXtHflp7dLgUYpQjSPI+5+rEtbPMm2DcN0hG3futT8xyO/RahegwIb9EUWRCyOPNWTZgae/EN1jENcYQ0Bbhq1saRg/7+D3shmlf00VzY12UoYMDVVs8H37rRey6r1n2Silk1SuI2Tg+ZrmfeULhzUXdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WP5lj05K951cRFvT/tS216Ha7D8yZrFGZ5sY3FWPY5Y=;
 b=xwWRvZF41GCctdOUEYrQ84wDdK+pUanyw5eFw3WhgxegQwRidWHeYxSXnNtRh7ptIeNh4/fRGKaYw/m5Y5qM/WsCEZwvRnL/GieOq/C2ecRV89sdHsfQ1jUi2o7YJbdy19n+z4h/In7GjmI3dsWp9xTc/3ufhoR74SxqLiPa4q4=
Received: from SN6PR11MB3184.namprd11.prod.outlook.com (2603:10b6:805:bd::17)
 by SA2PR11MB5098.namprd11.prod.outlook.com (2603:10b6:806:11c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Mon, 19 Jul
 2021 18:23:50 +0000
Received: from SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::4046:c957:f6a9:27db]) by SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::4046:c957:f6a9:27db%5]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 18:23:50 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "vedvyas.shanbhogue@intel.com" <vedvyas.shanbhogue@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "esyr@redhat.com" <esyr@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v27 23/31] x86/cet/shstk: Add user-mode shadow stack
 support
Thread-Topic: [PATCH v27 23/31] x86/cet/shstk: Add user-mode shadow stack
 support
Thread-Index: AQHXfLsqvZPe/RWKCEqBVHKeHuz5BatKnPmA
Date:   Mon, 19 Jul 2021 18:23:50 +0000
Message-ID: <798a369d3e7339a42f390321b56423cafd4e477f.camel@intel.com>
References: <20210521221211.29077-1-yu-cheng.yu@intel.com>
         <20210521221211.29077-24-yu-cheng.yu@intel.com>
In-Reply-To: <20210521221211.29077-24-yu-cheng.yu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3969d90-4bd4-43a9-b63f-08d94ae25b1b
x-ms-traffictypediagnostic: SA2PR11MB5098:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR11MB5098E2DA6D0F907A7A2371EFC9E19@SA2PR11MB5098.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G8Na5aOOa8gJCUdVXkERh/63qhDLaofy5y1mn+RLTs7d42vx80mLaahiNhdtG0DLJTNMmV3ztGWXiyZE5huqIY+PjMisaAZ0CeSI78riE98yWGer0fxLbON01lpJujtzBctQMGmpYuhmn597pv/Kp/G2tTEwYj/iG5RwrWOcrXLOFmpS6l6uiX+05VHHirVi69Qn9kYkAmsZdiSqp9vRp0axhoVSUa+g4ZUAiHQyzjEz7HCBcz3NwqBeWDB/J/T9DNePgHYCwsP79KEJikEw+i8MfJSjMNk3oCEwIBuY+tPzEfgb+grj/WpXzWkyDqNTYrYWdSD4+ewi3FWA4KyZKkwGpfT+HWeNFT7DK1fqK7cdmZcGQ4Lwnys1mpL6HxdUbTjuP0u2Tc6QyWRveAKvKJuq+sc+YK8imtAgEdw1x0zbQTlcw/0l0GHUNhcouBmu/wuK+GNsJhSXnRTcgX9ySThXVrwmMNL/dA/wThUqk4vWUE8p+4zk+f8ZjiqoTtbIx/3JWbiHW73FNSyqxqdVgxZj1K50s8SaXCvp1igjz+aiLs3WWaAOXggWbSdtYOEeBHy9XIVwTnbayD1X7uwHBWaG7/ErxXLHMD9adbN3UbIlxho9EZMvyCf+B4+Fjld8CMm7x5hJ6N3KPHO3FoUIrk9l/yPp6iObBQGHURTX03IDxksocmmyFEeJHuZGSNbIbBLtspRgZP2jR2I9b/hDE5/MVGPlMwbkwQv5I1dKG/Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3184.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(38100700002)(7416002)(122000001)(86362001)(91956017)(71200400001)(36756003)(2616005)(66556008)(2906002)(83380400001)(5660300002)(66946007)(66476007)(76116006)(8676002)(316002)(186003)(921005)(6506007)(6512007)(26005)(110136005)(478600001)(8936002)(66446008)(64756008)(6486002)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDhQVlVJU3dSREVvYjliT2xXK2F2czUyUVpGNnZ5ZUhVakIvRTlKeXd3RE0w?=
 =?utf-8?B?WVZDNG9ubEg5Yy9va0xxcE0yRGJLb0tuR1RDRVVoZDBicitCK0dDN3hEczZs?=
 =?utf-8?B?TmV3R0xHc2w3cjlOd3JMMFBxM2lHc3BWSTA4N0luaHd5ZHVDQVA2WVJxR2xI?=
 =?utf-8?B?bVhyRXZhZ0trYXFrenIxU050aDV5L2NCODVqZ29KOXBBZll4V0hFanpCOGZn?=
 =?utf-8?B?bElsV0g1RnNVR2xlUHFYQldYQlJjcmc5b0N3ZWo4MnowbWJKcXNsSzd3K1dF?=
 =?utf-8?B?cFpkUGtKSTFZbTJBaTYrNzFSUko2Zy9nWitORDZlWGxCbEFmV2pYeHVqQU9v?=
 =?utf-8?B?anEwcmVGRUF1RlhUeG5qc2ZDTjd4ZHpWKzJ4Skt0am9UUUlZM25WbC9OVGxi?=
 =?utf-8?B?eENwcFk4cFlNYllpZ3N2alZWMzVodFErMDZWVXMvS1NlN1JaeXhqSkRYSEsz?=
 =?utf-8?B?T3J2WjhRdUVBY2RvQ3UrNFlHS2s3N2hMV280SEVLc2gxdG82MUNqMXlORVZN?=
 =?utf-8?B?UTVURDUyV2kwcUc0d01xODkvQXA0dDZGTExjRjhkZGRqbHJhdTNNTnlscURU?=
 =?utf-8?B?N2c4bWZMMFZBU3dXeVJ2dTZoTCtDZHViT29kWjB6SHQyM3BiUk9lTkRZQ1A2?=
 =?utf-8?B?R2U3d0pBWGpkYjk5b0dWdzFEYjVTTGpLYkkvcll0SXVRa3BDVkRNRmVjZGIr?=
 =?utf-8?B?RTJ4VXZUZmdvVGsyMjR3Y2ZKalMweDEwaVlNRHdxMFVuMHJFaXFUbzBxWlJP?=
 =?utf-8?B?YStkU3M1U0FRaGVxTzVlempHOXhHdjAwU1ptdlBrZ1Y3WCtUSUlWNVFzRTA2?=
 =?utf-8?B?U0p4YW9Gekp1blpFaHpyM041aUFmMTQ5bGUzQ1YwSGVNekFQcW5hakFSL1M2?=
 =?utf-8?B?OXptOUZBOEFXRFRoTjdtOTM0SXc4S3FjRm12NG51NFBNcW8zSDVyOXRYVnZz?=
 =?utf-8?B?U0ZHbzhidDJIRlowbWk0UE5aZXpFUTROMHRCYVBTaW9TcFdMbEhiYU1EMURa?=
 =?utf-8?B?S0Y0YXhWUm91K3pEN1lrTytLNTlvS1d0R0I0bFE1TzBxSnI3R3MxOUZ3U1k4?=
 =?utf-8?B?Z0VadDNOSkVONmdoQzlkYVdLS0xwd1huTGI3VVplUWE1NDBOTFZsVVNXYVVO?=
 =?utf-8?B?OU9RampHVXV2YnpFWW1UQnZHajhJN0xCZGMrNHNRd21oZGhUTzF5YlBpYysv?=
 =?utf-8?B?VExGYk5YZTZueWRhY3A0aXZPbFhHTXVHaEdrYjlYaXBocmNjWHVMeVB3QVdZ?=
 =?utf-8?B?MkpQVlMrT2UvV3I2anU1Mm1oQmx0MWkwc2pRL3RYOVcveVUweTE4Vnd0ZHdH?=
 =?utf-8?B?TEJEbk9WSUlubG1qWTB5QVVOT2RuWnAyTFdFS0k0ZjkxU0pjMmQybjVYS2w4?=
 =?utf-8?B?MlBWT21ldWlYalRYRys1b2NlcHRZTlVwZ1RvaDg2L2J1S2sySzlBZFlpYnpw?=
 =?utf-8?B?Z3RGZldaUlpXWE9YWHgrY0Q1OGZiTThWeXp2bk5nVEdrS0gxMCtZZzZ6dDY3?=
 =?utf-8?B?NU1kYjRwOEU0SUdBVHlVa2VZbTZ5UElLNEZUeGd6bmxTN3RSajFEd2h3blJY?=
 =?utf-8?B?ajBNQWNvYzEzKzlGYmFvU3E5UFlPcXFhZkFYUFBjbmZPV2NudlJ2TVNOcy93?=
 =?utf-8?B?N3AvOGpwLzRURWVxcXJtY2JxTUxoU0ZJY2tEeUdramg5cGQ5aGxmVkhLdzBk?=
 =?utf-8?B?K081eEV2WUlsZEpNVXd0NzY0am1EMXNLRFRUdVVPcUdmeDZJbnpPb2tHWG1s?=
 =?utf-8?B?UWlHRTFicGdBODkwdmRmeStjL2tSMzZjK0lKY3RScVNqdmZlMkYydnNMZ0Jr?=
 =?utf-8?B?cFNpWlZMZWVFRy95Q0oxdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A6BC96A64EB0747A9708E2FD50B1487@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3184.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3969d90-4bd4-43a9-b63f-08d94ae25b1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2021 18:23:50.0583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J7xBooRQPkDOGYZCDBD2WzFQJcOjDDEFokHY9WdmAZyjprpUVkOqcfuVG0DsynjzELHcv7wgF100SopN6NPEWjq+Ov1DCOY3186R9eRGUzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5098
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIxLTA1LTIxIGF0IDE1OjEyIC0wNzAwLCBZdS1jaGVuZyBZdSB3cm90ZToNCj4g
SW50cm9kdWNlIGJhc2ljIHNoYWRvdyBzdGFjayBlbmFibGluZy9kaXNhYmxpbmcvYWxsb2NhdGlv
biByb3V0aW5lcy4NCj4gQSB0YXNrJ3Mgc2hhZG93IHN0YWNrIGlzIGFsbG9jYXRlZCBmcm9tIG1l
bW9yeSB3aXRoIFZNX1NIQURPV19TVEFDSw0KPiBmbGFnDQo+IGFuZCBoYXMgYSBmaXhlZCBzaXpl
IG9mIG1pbihSTElNSVRfU1RBQ0ssIDRHQikuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZdS1jaGVu
ZyBZdSA8eXUtY2hlbmcueXVAaW50ZWwuY29tPg0KPiBDYzogS2VlcyBDb29rIDxrZWVzY29va0Bj
aHJvbWl1bS5vcmc+DQo+IC0tLQ0KPiB2Mjc6DQo+IC0gQ2hhbmdlICdzdHJ1Y3QgY2V0X3N0YXR1
cycgdG8gJ3N0cnVjdCB0aHJlYWRfc2hzdGsnLCBhbmQgY2hhbmdlDQo+IG1lbWJlcg0KPiDCoCB0
eXBlcyBmcm9tIHVuc2lnbmVkIGxvbmcgdG8gdTY0Lg0KPiAtIFJlLW9yZGVyIGxvY2FsIHZhcmlh
YmxlcyBpbiByZXZlcnNlIG9yZGVyIG9mIGxlbmd0aC4NCj4gLSBXQVJOX09OX09OQ0UoKSB3aGVu
IHZtX211bm1hcCgpIGZhaWxzLg0KPiANCj4gwqBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9jZXQuaMKg
wqDCoMKgwqDCoCB8wqAgMzAgKysrKysrKw0KPiDCoGFyY2gveDg2L2luY2x1ZGUvYXNtL3Byb2Nl
c3Nvci5oIHzCoMKgIDUgKysNCj4gwqBhcmNoL3g4Ni9rZXJuZWwvTWFrZWZpbGXCoMKgwqDCoMKg
wqDCoMKgIHzCoMKgIDEgKw0KPiDCoGFyY2gveDg2L2tlcm5lbC9zaHN0ay5jwqDCoMKgwqDCoMKg
wqDCoMKgIHwgMTMwDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gwqA0IGZp
bGVzIGNoYW5nZWQsIDE2NiBpbnNlcnRpb25zKCspDQo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGFy
Y2gveDg2L2luY2x1ZGUvYXNtL2NldC5oDQo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gveDg2
L2tlcm5lbC9zaHN0ay5jDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20v
Y2V0LmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9jZXQuaA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0
NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLjY0MzJiYWY0ZGUxZg0KPiAtLS0gL2Rldi9udWxsDQo+
ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2NldC5oDQo+IEBAIC0wLDAgKzEsMzAgQEANCj4g
Ky8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wICovDQo+ICsjaWZuZGVmIF9BU01f
WDg2X0NFVF9IDQo+ICsjZGVmaW5lIF9BU01fWDg2X0NFVF9IDQo+ICsNCj4gKyNpZm5kZWYgX19B
U1NFTUJMWV9fDQo+ICsjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4NCj4gKw0KPiArc3RydWN0IHRh
c2tfc3RydWN0Ow0KPiArDQo+ICsvKg0KPiArICogUGVyLXRocmVhZCBDRVQgc3RhdHVzDQo+ICsg
Ki8NCj4gK3N0cnVjdCB0aHJlYWRfc2hzdGsgew0KPiArwqDCoMKgwqDCoMKgwqB1NjTCoMKgwqDC
oMKgYmFzZTsNCj4gK8KgwqDCoMKgwqDCoMKgdTY0wqDCoMKgwqDCoHNpemU7DQo+ICt9Ow0KPiAr
DQo+ICsjaWZkZWYgQ09ORklHX1g4Nl9TSEFET1dfU1RBQ0sNCj4gK2ludCBzaHN0a19zZXR1cCh2
b2lkKTsNCj4gK3ZvaWQgc2hzdGtfZnJlZShzdHJ1Y3QgdGFza19zdHJ1Y3QgKnApOw0KPiArdm9p
ZCBzaHN0a19kaXNhYmxlKHZvaWQpOw0KPiArI2Vsc2UNCj4gK3N0YXRpYyBpbmxpbmUgaW50IHNo
c3RrX3NldHVwKHZvaWQpIHsgcmV0dXJuIDA7IH0NCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBzaHN0
a19mcmVlKHN0cnVjdCB0YXNrX3N0cnVjdCAqcCkge30NCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBz
aHN0a19kaXNhYmxlKHZvaWQpIHt9DQo+ICsjZW5kaWYNCj4gKw0KPiArI2VuZGlmIC8qIF9fQVNT
RU1CTFlfXyAqLw0KPiArDQo+ICsjZW5kaWYgLyogX0FTTV9YODZfQ0VUX0ggKi8NCj4gZGlmZiAt
LWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3Byb2Nlc3Nvci5oDQo+IGIvYXJjaC94ODYvaW5j
bHVkZS9hc20vcHJvY2Vzc29yLmgNCj4gaW5kZXggNTU2YjJiMTdjM2UyLi43ZWI1NmE4MzdjZmEg
MTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3Byb2Nlc3Nvci5oDQo+ICsrKyBi
L2FyY2gveDg2L2luY2x1ZGUvYXNtL3Byb2Nlc3Nvci5oDQo+IEBAIC0yNyw2ICsyNyw3IEBAIHN0
cnVjdCB2bTg2Ow0KPiDCoCNpbmNsdWRlIDxhc20vdW53aW5kX2hpbnRzLmg+DQo+IMKgI2luY2x1
ZGUgPGFzbS92bXhmZWF0dXJlcy5oPg0KPiDCoCNpbmNsdWRlIDxhc20vdmRzby9wcm9jZXNzb3Iu
aD4NCj4gKyNpbmNsdWRlIDxhc20vY2V0Lmg+DQo+IMKgDQo+IMKgI2luY2x1ZGUgPGxpbnV4L3Bl
cnNvbmFsaXR5Lmg+DQo+IMKgI2luY2x1ZGUgPGxpbnV4L2NhY2hlLmg+DQo+IEBAIC01MTgsNiAr
NTE5LDEwIEBAIHN0cnVjdCB0aHJlYWRfc3RydWN0IHsNCj4gwqANCj4gwqDCoMKgwqDCoMKgwqDC
oHVuc2lnbmVkIGludMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNpZ19vbl91YWNjZXNzX2Vycjox
Ow0KPiDCoA0KPiArI2lmZGVmIENPTkZJR19YODZfU0hBRE9XX1NUQUNLDQo+ICvCoMKgwqDCoMKg
wqDCoHN0cnVjdCB0aHJlYWRfc2hzdGvCoMKgwqDCoMKgc2hzdGs7DQo+ICsjZW5kaWYNCj4gKw0K
PiDCoMKgwqDCoMKgwqDCoMKgLyogRmxvYXRpbmcgcG9pbnQgYW5kIGV4dGVuZGVkIHByb2Nlc3Nv
ciBzdGF0ZSAqLw0KPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGZwdcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBmcHU7DQo+IMKgwqDCoMKgwqDCoMKgwqAvKg0KPiBkaWZmIC0tZ2l0IGEvYXJj
aC94ODYva2VybmVsL01ha2VmaWxlIGIvYXJjaC94ODYva2VybmVsL01ha2VmaWxlDQo+IGluZGV4
IDBmNjY2ODJhYzAyYS4uYjBlNTk5MTAyMjc3IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rZXJu
ZWwvTWFrZWZpbGUNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL01ha2VmaWxlDQo+IEBAIC0xNDks
NiArMTQ5LDcgQEAgb2JqLSQoQ09ORklHX1VOV0lOREVSX0ZSQU1FX1BPSU5URVIpwqDCoMKgwqDC
oMKgwqDCoCs9DQo+IHVud2luZF9mcmFtZS5vDQo+IMKgb2JqLSQoQ09ORklHX1VOV0lOREVSX0dV
RVNTKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqArPSB1bndpbmRfZ3Vlc3Mubw0KPiDCoA0KPiDCoG9i
ai0kKENPTkZJR19BTURfTUVNX0VOQ1JZUFQpwqDCoMKgwqDCoMKgwqDCoMKgwqArPSBzZXYubw0K
PiArb2JqLSQoQ09ORklHX1g4Nl9TSEFET1dfU1RBQ0spwqDCoMKgwqDCoMKgwqDCoMKgKz0gc2hz
dGsubw0KPiDCoCMjIw0KPiDCoCMgNjQgYml0IHNwZWNpZmljIGZpbGVzDQo+IMKgaWZlcSAoJChD
T05GSUdfWDg2XzY0KSx5KQ0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL3Noc3RrLmMg
Yi9hcmNoL3g4Ni9rZXJuZWwvc2hzdGsuYw0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRl
eCAwMDAwMDAwMDAwMDAuLjVlYTJiNDk0ZTlmOQ0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2Fy
Y2gveDg2L2tlcm5lbC9zaHN0ay5jDQo+IEBAIC0wLDAgKzEsMTMwIEBADQo+ICsvLyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiArLyoNCj4gKyAqIHNoc3RrLmMgLSBJbnRlbCBz
aGFkb3cgc3RhY2sgc3VwcG9ydA0KPiArICoNCj4gKyAqIENvcHlyaWdodCAoYykgMjAyMSwgSW50
ZWwgQ29ycG9yYXRpb24uDQo+ICsgKiBZdS1jaGVuZyBZdSA8eXUtY2hlbmcueXVAaW50ZWwuY29t
Pg0KPiArICovDQo+ICsNCj4gKyNpbmNsdWRlIDxsaW51eC90eXBlcy5oPg0KPiArI2luY2x1ZGUg
PGxpbnV4L21tLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvbW1hbi5oPg0KPiArI2luY2x1ZGUgPGxp
bnV4L3NsYWIuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC91YWNjZXNzLmg+DQo+ICsjaW5jbHVkZSA8
bGludXgvc2NoZWQvc2lnbmFsLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvY29tcGF0Lmg+DQo+ICsj
aW5jbHVkZSA8bGludXgvc2l6ZXMuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC91c2VyLmg+DQo+ICsj
aW5jbHVkZSA8YXNtL21zci5oPg0KPiArI2luY2x1ZGUgPGFzbS9mcHUvaW50ZXJuYWwuaD4NCj4g
KyNpbmNsdWRlIDxhc20vZnB1L3hzdGF0ZS5oPg0KPiArI2luY2x1ZGUgPGFzbS9mcHUvdHlwZXMu
aD4NCj4gKyNpbmNsdWRlIDxhc20vY2V0Lmg+DQo+ICsNCj4gK3N0YXRpYyB2b2lkIHN0YXJ0X3Vw
ZGF0ZV9tc3JzKHZvaWQpDQo+ICt7DQo+ICvCoMKgwqDCoMKgwqDCoGZwcmVnc19sb2NrKCk7DQo+
ICvCoMKgwqDCoMKgwqDCoGlmICh0ZXN0X3RocmVhZF9mbGFnKFRJRl9ORUVEX0ZQVV9MT0FEKSkN
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoF9fZnByZWdzX2xvYWRfYWN0aXZhdGUo
KTsNCj4gK30NCj4gKw0KPiArc3RhdGljIHZvaWQgZW5kX3VwZGF0ZV9tc3JzKHZvaWQpDQo+ICt7
DQo+ICvCoMKgwqDCoMKgwqDCoGZwcmVnc191bmxvY2soKTsNCj4gK30NCj4gKw0KPiArc3RhdGlj
IHVuc2lnbmVkIGxvbmcgYWxsb2Nfc2hzdGsodW5zaWduZWQgbG9uZyBzaXplKQ0KPiArew0KPiAr
wqDCoMKgwqDCoMKgwqBpbnQgZmxhZ3MgPSBNQVBfQU5PTllNT1VTIHwgTUFQX1BSSVZBVEU7DQo+
ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBtbV9zdHJ1Y3QgKm1tID0gY3VycmVudC0+bW07DQo+ICvC
oMKgwqDCoMKgwqDCoHVuc2lnbmVkIGxvbmcgYWRkciwgcG9wdWxhdGU7DQo+ICsNCj4gK8KgwqDC
oMKgwqDCoMKgbW1hcF93cml0ZV9sb2NrKG1tKTsNCj4gK8KgwqDCoMKgwqDCoMKgYWRkciA9IGRv
X21tYXAoTlVMTCwgMCwgc2l6ZSwgUFJPVF9SRUFELCBmbGFncywNCj4gVk1fU0hBRE9XX1NUQUNL
LCAwLA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZwb3B1
bGF0ZSwgTlVMTCk7DQo+ICvCoMKgwqDCoMKgwqDCoG1tYXBfd3JpdGVfdW5sb2NrKG1tKTsNCj4g
Kw0KPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gYWRkcjsNCj4gK30NCj4gKw0KPiAraW50IHNoc3Rr
X3NldHVwKHZvaWQpDQo+ICt7DQo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCB0aHJlYWRfc2hzdGsg
KnNoc3RrID0gJmN1cnJlbnQtPnRocmVhZC5zaHN0azsNCj4gK8KgwqDCoMKgwqDCoMKgdW5zaWdu
ZWQgbG9uZyBhZGRyLCBzaXplOw0KPiArDQo+ICvCoMKgwqDCoMKgwqDCoGlmICghY3B1X2ZlYXR1
cmVfZW5hYmxlZChYODZfRkVBVFVSRV9TSFNUSykpDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqByZXR1cm4gLUVPUE5PVFNVUFA7DQpUaGUgb25seSBjYWxsZXIgb2YgdGhpcyB3aWxs
IHNraXAgaXQgaWYNCiFjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX1NIU1RLKSwgc28g
dGhpcyBpcyBkZWFkIGxvZ2ljLiBTYW1lDQpwYXR0ZXJuIGluIHRoZSBJQlQgcGF0Y2guDQoNCj4g
Kw0KPiArwqDCoMKgwqDCoMKgwqBzaXplID0gcm91bmRfdXAobWluX3QodW5zaWduZWQgbG9uZyBs
b25nLA0KPiBybGltaXQoUkxJTUlUX1NUQUNLKSwgU1pfNEcpLCBQQUdFX1NJWkUpOw0KPiArwqDC
oMKgwqDCoMKgwqBhZGRyID0gYWxsb2Nfc2hzdGsoc2l6ZSk7DQo+ICvCoMKgwqDCoMKgwqDCoGlm
IChJU19FUlJfVkFMVUUoYWRkcikpDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBy
ZXR1cm4gUFRSX0VSUigodm9pZCAqKWFkZHIpOw0KPiArDQo+ICvCoMKgwqDCoMKgwqDCoHNoc3Rr
LT5iYXNlID0gYWRkcjsNCj4gK8KgwqDCoMKgwqDCoMKgc2hzdGstPnNpemUgPSBzaXplOw0KPiAr
DQo+ICvCoMKgwqDCoMKgwqDCoHN0YXJ0X3VwZGF0ZV9tc3JzKCk7DQo+ICvCoMKgwqDCoMKgwqDC
oHdybXNybChNU1JfSUEzMl9QTDNfU1NQLCBhZGRyICsgc2l6ZSk7DQo+ICvCoMKgwqDCoMKgwqDC
oHdybXNybChNU1JfSUEzMl9VX0NFVCwgQ0VUX1NIU1RLX0VOKTsNCj4gK8KgwqDCoMKgwqDCoMKg
ZW5kX3VwZGF0ZV9tc3JzKCk7DQo+ICsNCj4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIDA7DQo+ICt9
DQo+ICsNCj4gK3ZvaWQgc2hzdGtfZnJlZShzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRzaykNCj4gK3sN
Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IHRocmVhZF9zaHN0ayAqc2hzdGsgPSAmdHNrLT50aHJl
YWQuc2hzdGs7DQo+ICsNCj4gK8KgwqDCoMKgwqDCoMKgaWYgKCFjcHVfZmVhdHVyZV9lbmFibGVk
KFg4Nl9GRUFUVVJFX1NIU1RLKSB8fA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqAgIXNoc3RrLT5z
aXplIHx8DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoCAhc2hzdGstPmJhc2UpDQo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm47DQo+ICsNCj4gK8KgwqDCoMKgwqDCoMKgaWYg
KCF0c2stPm1tKQ0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuOw0KPiAr
DQo+ICvCoMKgwqDCoMKgwqDCoHdoaWxlICgxKSB7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBpbnQgcjsNCj4gKw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgciA9
IHZtX211bm1hcChzaHN0ay0+YmFzZSwgc2hzdGstPnNpemUpOw0KPiArDQo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAvKg0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICogdm1fbXVubWFwKCkgcmV0dXJucyAtRUlOVFIgd2hlbiBtbWFwX2xvY2sgaXMgaGVsZA0KPiBi
eQ0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogc29tZXRoaW5nIGVsc2UsIGFu
ZCB0aGF0IGxvY2sgc2hvdWxkIG5vdCBiZSBoZWxkDQo+IGZvciBhDQo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgKiBsb25nIHRpbWUuwqAgUmV0cnkgaXQgZm9yIHRoZSBjYXNlLg0K
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovDQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBpZiAociA9PSAtRUlOVFIpIHsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb25kX3Jlc2NoZWQoKTsNCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb250aW51ZTsNCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0NCj4gKw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgLyoNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIEZvciBhbGwgb3Ro
ZXIgdHlwZXMgb2Ygdm1fbXVubWFwKCkgZmFpbHVyZSwgZWl0aGVyDQo+IHRoZQ0KPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogc3lzdGVtIGlzIG91dCBvZiBtZW1vcnkgb3IgdGhl
cmUgaXMgYnVnLg0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovDQo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBXQVJOX09OX09OQ0Uocik7DQo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBicmVhazsNCj4gK8KgwqDCoMKgwqDCoMKgfQ0KPiArDQo+ICvC
oMKgwqDCoMKgwqDCoHNoc3RrLT5iYXNlID0gMDsNCj4gK8KgwqDCoMKgwqDCoMKgc2hzdGstPnNp
emUgPSAwOw0KPiArfQ0KPiArDQo+ICt2b2lkIHNoc3RrX2Rpc2FibGUodm9pZCkNCj4gK3sNCj4g
K8KgwqDCoMKgwqDCoMKgc3RydWN0IHRocmVhZF9zaHN0ayAqc2hzdGsgPSAmY3VycmVudC0+dGhy
ZWFkLnNoc3RrOw0KPiArwqDCoMKgwqDCoMKgwqB1NjQgbXNyX3ZhbDsNCj4gKw0KPiArwqDCoMKg
wqDCoMKgwqBpZiAoIWNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfU0hTVEspIHx8DQo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoCAhc2hzdGstPnNpemUgfHwNCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgICFzaHN0ay0+YmFzZSkNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJl
dHVybjsNCj4gKw0KPiArwqDCoMKgwqDCoMKgwqBzdGFydF91cGRhdGVfbXNycygpOw0KPiArwqDC
oMKgwqDCoMKgwqByZG1zcmwoTVNSX0lBMzJfVV9DRVQsIG1zcl92YWwpOw0KPiArwqDCoMKgwqDC
oMKgwqB3cm1zcmwoTVNSX0lBMzJfVV9DRVQsIG1zcl92YWwgJiB+Q0VUX1NIU1RLX0VOKTsNCj4g
K8KgwqDCoMKgwqDCoMKgd3Jtc3JsKE1TUl9JQTMyX1BMM19TU1AsIDApOw0KPiArwqDCoMKgwqDC
oMKgwqBlbmRfdXBkYXRlX21zcnMoKTsNCj4gKw0KPiArwqDCoMKgwqDCoMKgwqBzaHN0a19mcmVl
KGN1cnJlbnQpOw0KPiArfQ0KDQo=
