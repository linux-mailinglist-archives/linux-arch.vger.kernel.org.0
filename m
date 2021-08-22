Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDCD3F3D32
	for <lists+linux-arch@lfdr.de>; Sun, 22 Aug 2021 05:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbhHVDAt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 21 Aug 2021 23:00:49 -0400
Received: from mga11.intel.com ([192.55.52.93]:31102 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231336AbhHVDAs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 21 Aug 2021 23:00:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10083"; a="213813624"
X-IronPort-AV: E=Sophos;i="5.84,341,1620716400"; 
   d="scan'208";a="213813624"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2021 20:00:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,341,1620716400"; 
   d="scan'208";a="424789844"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga006.jf.intel.com with ESMTP; 21 Aug 2021 20:00:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Sat, 21 Aug 2021 20:00:06 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Sat, 21 Aug 2021 20:00:05 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Sat, 21 Aug 2021 20:00:05 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Sat, 21 Aug 2021 20:00:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POkjPRld19EfAgxJWwnx/ihA2y4136O6L5BdE6nnqFSfTLoREEImQYYs0x5rO9vC7affYxXjMOAlD1ZvS3Vekric4Jzwx/DZ6I0Vtnxs6oKzpY9vyyEMlmQaTBnPXkNBRuCXEdUngV2w0qKQnJvWaWVqQIGZxyENwBCpjb4KQy8RI6eVLFRUDgUTdVerRsmLsnXIAiMgYX/R1XaBLjc8lTwdguO3p1VTSx+/ITHOoIP4xqbisdCiv8qyN+jzLClbQcQCekUNeadkMEa5yly5416+XrzwnAWwH7V5q1v7zU13PrX81EgQG+xS1lOiyb+KeGkBuqdwFttEtCW12C944Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMQ4MAgMkYT+9Bq4QjZEUAYyR3x6wmgNe0dyRBtLSho=;
 b=ijHD0OEaUL9MKxiMHI3aN0QtsxwD4HDSpr2GTBmQXWDecV+HyFUbmy02IUM6bSXStSbzO24wtNakYzptqpI3R8ksvCoHv06l59Ys6G1dStEZSqARtblJoYSJCq+GRZX+dSUKBJNUG/UMOzOTJgRBwXthZD4xV2R9jhkzYm4XrD2l8lL3UY+S0dR1hywZKaKysLImzxrrUUcp9O9m4qjl8sssoZP2+gs2+pvt7PGD8u3gFE/FSp9cXyCldHI4Yuu9U7+gWPWhpfEJ4SEglieKbPKDAFMkneVUAygtzkFjWNbQAVG+RbENtDamyKvkcxtx6tfAT86/4GGLEuh5gRIBqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMQ4MAgMkYT+9Bq4QjZEUAYyR3x6wmgNe0dyRBtLSho=;
 b=Yh/aJhWtIziKmEWlW1sPqp0Cidg/l2hfB6kW1ehc+kL4fhQZQyTGW0UF335uFpJdGH3HE53wIxI6G/7KA6mvML72tM8NlJOmUrmyortmk83sOnBguUrktfwX3lKxv6qXoPnMfBPU2qo6U9OrXADf3eojnZGw+YZIM+qkOPEaCh4=
Received: from SN6PR11MB3184.namprd11.prod.outlook.com (2603:10b6:805:bd::17)
 by SN6PR11MB3184.namprd11.prod.outlook.com (2603:10b6:805:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Sun, 22 Aug
 2021 02:59:55 +0000
Received: from SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::892e:cae1:bef0:935e]) by SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::892e:cae1:bef0:935e%6]) with mapi id 15.20.4436.019; Sun, 22 Aug 2021
 02:59:55 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "esyr@redhat.com" <esyr@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
CC:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v29 09/32] x86/mm: Introduce _PAGE_COW
Thread-Topic: [PATCH v29 09/32] x86/mm: Introduce _PAGE_COW
Thread-Index: AQHXle/aMI4krKcn/kKrw6oEL7PJsat+V1eAgACAWQA=
Date:   Sun, 22 Aug 2021 02:59:54 +0000
Message-ID: <b545f4957412884d8e0fed88235a8d23fc6060c1.camel@intel.com>
References: <20210820181201.31490-1-yu-cheng.yu@intel.com>
         <20210820181201.31490-10-yu-cheng.yu@intel.com>
         <152f757d37d3fd834a06fadad18165cbf44b1b48.camel@intel.com>
In-Reply-To: <152f757d37d3fd834a06fadad18165cbf44b1b48.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a32bd834-2ac5-49c1-895c-08d96518eb74
x-ms-traffictypediagnostic: SN6PR11MB3184:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB3184330B3CDD87F206943B9BC9C39@SN6PR11MB3184.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mzok3vok6p82t3ZIqKglgttRBs22yOo64wOx1O1X2uG/YxonmA0/TnqFkf/YlqDDrotKRL/anuaSmyegq4daDSVNUaeBZxXc1AZ+4ukdgtcpKnhwu7r4r2wQjZpAa8aHnbIs9VQc49gqVVQKl45RnGVGxAYKEUs/8fLNVi5TWpZ2U9CTiTjxGtmFA/UbUUhq2rZ+9RcrzAj1PEW/HvBnhkUxVwSyXApzH4iaQqbbWsTCFvym5agRj5vDI5lr1MMgqvaG+raqXom7UUc9YyZm0Vr0ZElxTweBMGn3RIfIuwYpmNy246KRH3XbNf1Sg0uqgKLWzxDJWSwZjeoO74UQjPuV7B/LznfM4Sm6QjBGY0TQKvQyFmKtomoKVXiL0kQS8zYkFDDsBQI/65LeMN/uFVl0LY3Hj4gSmY5/L1IH1Ua6ABnCTkg9CsIVnUXuiuezU8HE0oAuvvSh04YvKIALf2AvLGWVlcPlwvlYVysufEbhthW1Xo28w0H6A5jPk7iG81UoD4whSgWMwpUNE/h7x398HmnUTDfspz7kH8W2H9sblL9bc/ESDeJE12BKqXAbTOyJC1w3du5bJlzzElMSO5c266e2pExHHOydEzRDA9d6tSKsvS4xWtsNU1+DZztTwuayTJS5q4Es7c1/ChMZ+y89WVg+n2/4m8wcbA6W6BcKkasyrQ3JeIfkZTaUA9M0CXkVtDMj22bBuCPEqgYRzQkc1Y5qYBroQIajVJeekaIE4fpG8Wf6lanXJWm5Uzxg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3184.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66946007)(6506007)(5660300002)(76116006)(91956017)(122000001)(6486002)(36756003)(7406005)(921005)(7416002)(66446008)(2906002)(66556008)(316002)(26005)(2616005)(508600001)(64756008)(8936002)(4744005)(86362001)(8676002)(71200400001)(38070700005)(4326008)(38100700002)(6512007)(186003)(110136005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjlzTzlXczkvb28zTHFKS3crOWRnK3N0SzQxZFdrWkxFTWVtWlgvQzV5SHRN?=
 =?utf-8?B?YVpCaExHZi9SSGJNRXpLNFU1SlEySE11WVdpUFNRVjNKcHdyY2o5elpteEYw?=
 =?utf-8?B?cTFCdDRTbXVXMXFWWDBaL3NTRnN0cmMvai9LN0tTbjVrekROTWdwQnlIM3FF?=
 =?utf-8?B?a0FlSlpheVZxcmNtaTBRL09WbDZiaitYeW9VQkRtbGdEaGdqR2NRdHZYQmRI?=
 =?utf-8?B?Uk9MVU1BRWZzTEVDeGZKWU1BRkZWaEtiLzVXRG9BVUF3emFuSmlZUGFmd1d1?=
 =?utf-8?B?ZStCdDBXNlhHZ3Q5c21PSENHL1AwS3pUdms0YVZ5eXhWNmc1NC9vZUN6ZWVB?=
 =?utf-8?B?T09oQkQ2bE9SS3RtZUVWeHY2YnZmVlViakJwOG56bEZORXJzQWZPY05DTm9P?=
 =?utf-8?B?UndoaVFmSDlYZ1B5SEEwOGg0a0ZjZ1g1bzBneENQUTU0TGRtclpRd25EM1pZ?=
 =?utf-8?B?NlRncDIycGplcnJnZStTc3M4NUlGVnFNVDdWUVRNTUU2eFJpcHhCQk1yMk9v?=
 =?utf-8?B?eWIybDNTNmplUnJaNHZnbEdHS3h2WDN4VXF0YkRvelVrYlFYN2ljaC90RFZ5?=
 =?utf-8?B?MXVGY0QxUGJiOTNNVExDSUVicWlYd1h6YWVUa25NamIySFRoMFovV3JtVDc5?=
 =?utf-8?B?Nkpua1JZaFdSZldqVDNzeWJPbHVkVU0wdG0rQTNpUjV4L0pVcng3Mzh1WWZB?=
 =?utf-8?B?VXhZenVjLzFsQVpNNnZpK094K2lEeElYMGE5MVFUbDBDNk91Nkx1RmVvZFNq?=
 =?utf-8?B?ZDBFWHFTNUI0bjBvK2JXb1F0R3RFaGJOTjhZQkJvbnVEVm54ZzVYVzdFSkIv?=
 =?utf-8?B?T21SMmNxUlM3YWRvblRSek9ZbDIyZnJMOHllb2tZcVBFM2tpRlc0cktJUzI4?=
 =?utf-8?B?YWR1c2lOQ3BmZUVQUmdFeVlUK3Q2K1RlRzA5RnV1V09rT1ZFaVhBNzVEVndp?=
 =?utf-8?B?MkptRFR0WTRFeFU3UUlzcVBEVFRzVE4wRTBUQkdIUjVVRWo4L0V0WXpDU2JD?=
 =?utf-8?B?YnJnMXJQWW9SZ0l0SGxJeTE2dG1ud0M0bFc4ZTJnT1lkMEUyd2xpR3VycEZq?=
 =?utf-8?B?dFU2SkNWcU9id1JuSmxvcWQ4NDBTc01iQVZjNThzWGhNcTJtQkl2bkkraits?=
 =?utf-8?B?MHdjTE5RSld4NCsvdGlRUGNFZld4ZlFBZlM2QzZSc0NIUVF4WFFMbkNhK085?=
 =?utf-8?B?T01qbDdNVXZGK2F0OURQdXdwcnNmQnlIb1pzYjV1Y3QzRkk4alNvWEdMMXQv?=
 =?utf-8?B?WDFxZm04UVJlTW5UcWxNcHdWNTZNZjdMWGlZZ2lkSzRuc0hzTU1RdkNOSXps?=
 =?utf-8?B?aUc1MzlMZ085eTg2WE1iN0lCekVmYVhweGE2SHg5VUMxNXVoYVdTNGFFcmxL?=
 =?utf-8?B?cGNwME9tZGJtQnJ0OVJMOU1meUVzcXhhWk1KWTlBcU9XSGduRUN4b2dFb0Qz?=
 =?utf-8?B?akVrNkoyV1FPRHVHZC9IQWsrbmF4N3hhTm9kMTRWSVdySGtaYzVnSUtBUWRT?=
 =?utf-8?B?SUJ1ZTdsU2RTbVNMRk4rSXI2OFFPNzBLRUZ6ZFBXSGE2RU56c2JKamU1dEpa?=
 =?utf-8?B?RDBhbWIxUnUzYWJ3eGJNNVhMQjdjSUVCSlRYTHB6Y0MyVmVzbU9VYmZNeVU5?=
 =?utf-8?B?Y3BuTlNralhEN1FINjlxNitUbjdxNEhTZHhXTURHWXZhODhuRzJMak5zVjlI?=
 =?utf-8?B?bVV5VzhNNm9lajVJWnRDMm5FVVhqeXo3ZEk5UnpPREVkc1hWUjIwMGNsNy9B?=
 =?utf-8?B?R1d1dGtQRGNZUmF2U1JSbHkyU0dtODRPOTVub1ZjK3NScUYwUjhlVDZHYmx4?=
 =?utf-8?B?RmxuUXEzQzRMc1VsU2pOUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46C0EAF0080602469A7CEB6EA7AFD640@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3184.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a32bd834-2ac5-49c1-895c-08d96518eb74
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2021 02:59:55.1040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p6RT59lXdurR7fnfEeMl+TkAGU00mI+tKZncpWaxwOsoZGkCekw+NTrxdPYX34Ymj7rkHKEDwYJR/fw7znfbgMoWsGNungFUU4S7b2Z9Nh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3184
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gU2F0LCAyMDIxLTA4LTIxIGF0IDE5OjIwICswMDAwLCBFZGdlY29tYmUsIFJpY2sgUCB3cm90
ZToNCj4gK0tWTSBsaXN0Lg0KPiANCj4gT24gRnJpLCAyMDIxLTA4LTIwIGF0IDExOjExIC0wNzAw
LCBZdS1jaGVuZyBZdSB3cm90ZToNCj4gPiAgDQo+ID4gIHN0YXRpYyBpbmxpbmUgaW50IHB0ZV93
cml0ZShwdGVfdCBwdGUpDQo+ID4gIHsNCj4gPiAtICAgICAgIHJldHVybiBwdGVfZmxhZ3MocHRl
KSAmIF9QQUdFX1JXOw0KPiA+ICsgICAgICAgLyoNCj4gPiArICAgICAgICAqIFNoYWRvdyBzdGFj
ayBwYWdlcyBhcmUgYWx3YXlzIHdyaXRhYmxlIC0gYnV0IG5vdCBieQ0KPiA+IG5vcm1hbA0KPiA+
ICsgICAgICAgICogaW5zdHJ1Y3Rpb25zLCBhbmQgb25seSBieSBzaGFkb3cgc3RhY2sgb3BlcmF0
aW9ucy4gDQo+ID4gVGhlcmVmb3JlLA0KPiA+ICsgICAgICAgICogdGhlIFc9MCxEPTEgdGVzdCB3
aXRoIHB0ZV9zaHN0aygpLg0KPiA+ICsgICAgICAgICovDQo+ID4gKyAgICAgICByZXR1cm4gKHB0
ZV9mbGFncyhwdGUpICYgX1BBR0VfUlcpIHx8IHB0ZV9zaHN0ayhwdGUpOw0KPiA+ICB9DQo+ID4g
IA0KPiANCj4gS1ZNIHVzZXMgdGhpcyBpbiBhIGNvdXBsZSBwbGFjZXMgd2hlbiBjaGVja2luZyBF
UFQgcHRlcy4gQnV0IGJpdCA2DQo+IChkaXJ0eSkgaXMgYSB0b3RhbGx5IGRpZmZlcmVudCBtZWFu
aW5nIGluIEVQVC4gSSB0aGluayBpdCdzIGp1c3QgdXNlZA0KPiB0byB0cmlnZ2VyIGFuIG9wdGlt
aXphdGlvbiwgYnV0IHdvbmRlcmluZyBpZiBLVk0gc2hvdWxkIGhhdmUgaXRzIG93bg0KPiBURFAg
c3BlY2lmaWMgZnVuY3Rpb24gaW5zdGVhZCBvZiB1c2luZyBwdGVfd3JpdGUoKS4NCj4gDQpBcmdo
LCBuZXZlciBtaW5kLiBJIG1pc3JlYWQgdGhlIG5ldyBLVk0gbW11IG5vdGlmaWVyIHJlZmFjdG9y
Lg0KDQo=
