Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23A240B771
	for <lists+linux-arch@lfdr.de>; Tue, 14 Sep 2021 21:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhINTFA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Sep 2021 15:05:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:33748 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232420AbhINTE7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Sep 2021 15:04:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10107"; a="202277891"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="202277891"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 12:03:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="433118741"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga006.jf.intel.com with ESMTP; 14 Sep 2021 12:03:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 14 Sep 2021 12:03:39 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 14 Sep 2021 12:03:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 14 Sep 2021 12:03:38 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 14 Sep 2021 12:03:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXln49XG7nm//GfsVT30uDwPDDCPxrqFKIyP+WpCtCOodQsYcn8GCMuz1zvTwdmXWiE3TplvDN6hFJYw+PgnPmsTtI4R4yQp0mNMGiBv0urb19Pr/ogYDDOFm/oWxFItlc/JFRnddEvOuZgdvyiTh4H5xaq5nnhEO9dlcYb1b+Xlnfdhwt6A52PjDfSshjSLnbE/WYRNkVIc4n3/T+R1hs8qkPdgveKIwuHdEX4EPEEZcN9AP9IiBRUfz9UfVC/rHEqhlOU0cl/r8h0cv9YI0+7o7qPJ1z2bES/2nFk7E0HuNIHVqkIYZneIspD2YpyncWrAxsgFammq740X0hUZ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=PROnw7PL5pJvMOqpIcffd+9jFVydL2xpqTP3ONHBQ/o=;
 b=YUrRdCUZVbwP4C/723E3FbIrvBUN+i37sCpU49mbpsa965yfYWtHf3uD3mB5ELIMdN8HfOqacS4mJzIVRMEiMY/Y4qQD8nX7hJe/sjzH4PoKgtBnEDSN+xTSptKBrXqCTjrjnQMageIwbZCYVmniXvFMhgOmQzk6zP+1+zrf/r65r7WamD6zZqvSBaox6pe1ZWfZeb2lMKn6Z8X9x9rKoV+1cNs6NrdLxwChsSrlZ5fNe6FiNpgg9fpwwQMZdvH/hhcmZIfSRRwiDiEQZOrSJmiLOZXPNBpS18MSJQREpa1w0JJntRqlbAcGKWze7T7RXrTAYXcNW2ao2EbDTCGemA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PROnw7PL5pJvMOqpIcffd+9jFVydL2xpqTP3ONHBQ/o=;
 b=UNRctlYUxzHIFkDrY/jT/Bj417W4x2LK56+yaJavhlUYIrMrVW5NWGbc0ePsYoV+3tRld9V/NYPeRzP5YJdcKNbva3YfCwakQaCi6ITzhl4qHSsADpmSeBEpZySdiG/7Uuqo4bPpKY2jg+f4KZYTSza8S8+sFu4wD8ZqdihuPuY=
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by BY5PR11MB4037.namprd11.prod.outlook.com (2603:10b6:a03:188::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 14 Sep
 2021 19:03:36 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6db5:94d3:e534:617c]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6db5:94d3:e534:617c%7]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 19:03:36 +0000
From:   "Mehta, Sohil" <sohil.mehta@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Lutomirski, Andy" <luto@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Kammela, Gayatri" <gayatri.kammela@intel.com>,
        "Zeng, Guang" <guang.zeng@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Witt, Randy E" <randy.e.witt@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Thomas, Ramesh" <ramesh.thomas@intel.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC PATCH 00/13] x86 User Interrupts support
Thread-Topic: [RFC PATCH 00/13] x86 User Interrupts support
Thread-Index: AQHXqNqTrxrKS5qv40GIaIDowcHo6Kuiad+AgAEC0AA=
Date:   Tue, 14 Sep 2021 19:03:36 +0000
Message-ID: <BYAPR11MB33203044CD5D7413846655F9E5DA9@BYAPR11MB3320.namprd11.prod.outlook.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <c08f38db-77da-c50e-23f7-b3a76688deeb@intel.com>
In-Reply-To: <c08f38db-77da-c50e-23f7-b3a76688deeb@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
x-ms-exchange-imapappendstamp: BYAPR11MB3320.namprd11.prod.outlook.com
 (15.20.4500.019)
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52cbe371-8034-4aef-05be-08d977b25b15
x-ms-traffictypediagnostic: BY5PR11MB4037:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB4037BFE7799EA5A4AD1D5E61E5DA9@BY5PR11MB4037.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g2LtJlUAQjjnd0MlgdzKPhr0dLHhDD6DLgKvdD9e4CdI5A14AeVcMkg0n6PpAQIg03omG1I9HdStMw8tIe1PaqxIhhaQ/jRJ7tezqzSYnjnvDjP8WSlKuNpuylgralXET073OMWMmnDhLr98uHnTpFvd+XMIk3SaLj3/gh1aAgS4Y+u1QqkWFkK1F7sh2LiQnv9Vq0lQa//4qSCqeRO8oNYh46t2Fr3vDugkNgeuG9VI3ScqWYdIR908nYpiqGlce4rXYc1U/bkypqW62Z5PofsWcXXbARaywqHkFjW/ivOqjX3KA/WNHsEdRMr1wT51kgEoXaR50rbFGGec3d3DxhAAGXRWlMV3QgUMZ8IgHYmpT0bEanf1Um6t8MZ08E7dgkJ909FUCsxQVT3ul1orhHU1KqkQRA8X+pVHeCdteqGAym3w4KjiBgK6G49TXrtKxL7e3ogTHkm7vQ3LUSkaspFLabN5+Mb5B2FYgwO33mKxeEB8lDS9djQPtX8g9lZHi1+d+hFNvCINlnkNuWR/GlnQh+3owgNwpj53vuhX5Wt5UdXahcuUbim5G7S9BZxHOs8r9fCYDcmxSN6WnwMxp4q1snjc4ea8Kiy8HTYAJbkn/Um9/in2MB2JL4obD37opzkZm+DcIWqB2XeKgChjvYRS6hriXTXQjoQ2ehIBuEpQoq9zHIneVnDbw7HqvMCi8XYK+V7sY3axTnnvhoEDjXl8NX/GHqmP2wfFrLoHdWuzhvttFIq4KAkeQ5WJy5TOYH4d6G3sqzQCqwhh9pz1dw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(83380400001)(4326008)(122000001)(55016002)(9686003)(71200400001)(86362001)(33656002)(2906002)(478600001)(64756008)(66446008)(316002)(7696005)(7416002)(66476007)(66946007)(54906003)(66556008)(26005)(8676002)(110136005)(186003)(38070700005)(53546011)(6506007)(38100700002)(5660300002)(76116006)(8936002)(52536014)(65966003)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTdMRCtVaVJJV1V6Q1RJb0srU1RaellSdkJONU04WWlRbVpGZ2ZkZ1hwakV5?=
 =?utf-8?B?Qm5zbk9aU1lPTEJhNzRkTndieldUR0cwS0o5elRMb09xYXRFZTFWWUVFOUNh?=
 =?utf-8?B?cFdFb2lXYWZxZmlXNXR5TFdXQ3AzVENzaWpUWGJwd3BBSGFmbHlJRDBkQmlB?=
 =?utf-8?B?M1JyYm5yT3B6TCtUTnZod0xEUjlBVVNKT0VjZlNRN2t2VkxVUHBPUlJWYkY5?=
 =?utf-8?B?U0xLbXRCYTAzb0pETVhzVFd1c0RJM3RvV0ZsMHEwbmNmYkxSTUZDOTBmcjNn?=
 =?utf-8?B?ZnA3RmR5SHFLdWI0bm54TnJTS21PcU5DMHN3SWdQRWVCVGNEODA1c1hBUW1i?=
 =?utf-8?B?NElMZnIxMkJUaEJHSUFoLzRBU3hiaWxTQVk4YmxWaDZiWllIRHpNdmV1OFg5?=
 =?utf-8?B?OGxDQk0rNnBLQ2FGT0J5cXlIeUF4Y0xnY3JyNXVXQTZSOVJJVHFVeE00WmJR?=
 =?utf-8?B?bEVlYmkvQ296ek8rSndIbmRlcFQwU1VwSjBkUmJpRFRobFVXTkhwd3VlRU9E?=
 =?utf-8?B?ektMYzVNYzRZOXkyK0k0R0FsVWpKNWlkVkwvV3ZBR2h0YmxRdVpDVHNBc1k3?=
 =?utf-8?B?Z2FLSHlnTGV5MmIyTkY4bk51YUxJR2JHNnJyTkN1ZFBxeWtQOFJyZWFZd21X?=
 =?utf-8?B?T0t1cXYzbFVxK0ZUVmFUZVBQc1Vhdy9aOUVnVHVXei9tR0QvZXUvU0VGcWlk?=
 =?utf-8?B?aXdsME1UYStldm1LSnowVGRqOUdGcTZhdTZoY28yak1IdDBLMTBvM0t3L0JV?=
 =?utf-8?B?YnluVmcwdGlqTWdXM3pINGR6Qm1mRVJKMnpWNEZLQ3RoN0pJT01pWDgrbVFT?=
 =?utf-8?B?bFd4UVRjTHZPdEc0SnFMQ203TSs1eFhsYjc2ODlISUNGZllUOU1YS0ZFOW9s?=
 =?utf-8?B?Q2x6eEc3Wk9SQU1zRmZiSHgxYXUwbE9IRis3NFU1aDlueVF6S2llSzRUVTBP?=
 =?utf-8?B?djBYMmp0WkJkbkxLZUFDOGFSQnJLN1c3Y3h1cW1uRkJycHlSTHVRQko4YktC?=
 =?utf-8?B?UnZDQnJOdUxPME1pRTlTdTZQMjYvanhDOG9iTkFDbGJCcTVQcGsrOVl3c1BI?=
 =?utf-8?B?SFJoQ0ZKazk3aTZKUko3WkJEa3lCODFUb1FYYTJaWkxnYVFmRERVbjc3YWg5?=
 =?utf-8?B?aWhycU82OUZNV0dCUWxYL3l1OTMwY0JaWmVBQjdOQU85QjM1d0E4d2xvcDBC?=
 =?utf-8?B?MmlweFU5SE5TL0haSXhzM0Q4N25ZRGUvU1dBajJVSHVzNnkwQ0ZuaXB6Q0ZP?=
 =?utf-8?B?aVpnbDBTSjM1ODZ4ZDRSQUUvQVE5cnR3V1U5a0ZNdkMzVmhQcW1NZSt3U2tQ?=
 =?utf-8?B?VzVUUHA0WEl4eE9xWUYzMnpibVlkdkNLSnh3MnNaRFNqRzl6dDNoNFkxQzhP?=
 =?utf-8?B?a0gwMXFVMlpadEEwYmJKNTdMek1pc1FtZTE4NUY0dUptbE45ZWNWbWYrRmRB?=
 =?utf-8?B?aWZFTnBSZHJyaFdSSFhFMk5NRmF4QWdQd2xDS2RINkZ0UDI2anRBV1ZWMStz?=
 =?utf-8?B?REhIQW4xMDJuU0lLelhJTjRjMHRmT3NDbWR4TGxUVVZWNnU2aCs3dGlBWHhT?=
 =?utf-8?B?d0FHM0ptK05EOXVuYm1ETjZtbzVXd2NCZ2k1NVVIMG5FY2VrTUFHWTcxem5P?=
 =?utf-8?B?MVU1VEtVdzY3aEpKN1YzZGpUamxsYkludjhZd2YxNVhSQTJKcThLOXdYNmQy?=
 =?utf-8?B?ZnFmanNHdUJQcVFFamluQlpJZ0JKSDNjNFF5b3VwZy9yT1piMlJ0NGE5anlG?=
 =?utf-8?Q?+UhL5mXjBd0dA+H+WkjTCZPy42Gg8BoyhUcS0Sg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <706D106DC9625046B5DCB2AA0B870AE3@intel.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52cbe371-8034-4aef-05be-08d977b25b15
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2021 19:03:36.3595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xYrYpHdR/3MDYJOAGsy2b5KzDfc8BMB7LbQQK3bCFA+gt6G8r/L4UTXf3Vt7CLSRFO/MlYP7EYiPQwTrdbSZVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4037
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

UmVzZW5kaW5nLi4gVGhlcmUgd2VyZSBzb21lIGVtYWlsIGRlbGl2ZXJ5IGlzc3Vlcy4NCg0KT24g
OS8xMy8yMDIxIDE6MjcgUE0sIERhdmUgSGFuc2VuIHdyb3RlOg0KPglVc2VyIEludGVycnVwdHMg
ZGlyZWN0bHkgZGVsaXZlciBldmVudHMgdG8gdXNlciBzcGFjZSBhbmQgYXJlDQo+CTEweCBmYXN0
ZXIgdGhhbiB0aGUgY2xvc2VzdCBhbHRlcm5hdGl2ZS4NCg0KVGhhbmtzIERhdmUuIFRoaXMgaXMg
ZGVmaW5pdGVseSBtb3JlIGF0dGVudGlvbi1ncmFiYmluZyB0aGFuIHRoZQ0KcHJldmlvdXMgaW50
cm8uIEknbGwgaW5jbHVkZSB0aGlzIG5leHQgdGltZS4NCg0KT25lIHRoaW5nIHRvIG5vdGUsIHRo
ZSAxMHggZ2FpbiBpcyBvbmx5IGFwcGxpY2FibGUgZm9yIFVzZXIgSVBJcy4NCkZvciBvdGhlciBz
b3VyY2Ugb2YgVXNlciBJbnRlcnJ1cHRzIChsaWtlIGtlcm5lbC10by11c2VyDQpub3RpZmljYXRp
b25zIGFuZCBvdGhlciBleHRlcm5hbCBzb3VyY2VzKSwgd2UgZG9uJ3QgaGF2ZSB0aGUgZGF0YQ0K
eWV0Lg0KDQpJIHJlYWxpemVkIHRoZSBVc2VyIElQSSBkYXRhIGluIHRoZSBjb3ZlciBhbHNvIG5l
ZWRzIHNvbWUNCmNsYXJpZmljYXRpb24uIFRoZSAxMHggZ2FpbiBpcyBvbmx5IHNlZW4gd2hlbiB0
aGUgcmVjZWl2ZXIgaXMNCnNwaW5uaW5nIGluIFVzZXIgc3BhY2UgLSB3YWl0aW5nIGZvciBpbnRl
cnJ1cHRzLg0KDQpJZiB0aGUgcmVjZWl2ZXIgd2VyZSB0byBibG9jayAod2FpdCkgaW4gdGhlIGtl
cm5lbCwgdGhlIHBlcmZvcm1hbmNlDQp3b3VsZCBkcm9wIGFzIGV4cGVjdGVkLiBIb3dldmVyLCBV
c2VyIElQSSAoYmxvY2tlZCkgd291bGQgc3RpbGwgYmUNCjEwJSBmYXN0ZXIgdGhhbiBFdmVudGZk
IGFuZCA0MCUgZmFzdGVyIHRoYW4gc2lnbmFscy4NCg0KSGVyZSBpcyB0aGUgdXBkYXRlZCB0YWJs
ZToNCistLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsNCnwg
SVBDIHR5cGUgICAgICAgICAgICB8ICAgUmVsYXRpdmUgTGF0ZW5jeSAgICAgIHwNCnwgICAgICAg
ICAgICAgICAgICAgICB8KG5vcm1hbGl6ZWQgdG8gVXNlciBJUEkpIHwNCistLS0tLS0tLS0tLS0t
LS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsNCnwgVXNlciBJUEkgICAgICAgICAg
ICB8ICAgICAgICAgICAgICAgICAgICAgMS4wIHwNCnwgVXNlciBJUEkgKGJsb2NrZWQpICB8ICAg
ICAgICAgICAgICAgICAgICAgOC45IHwNCnwgU2lnbmFsICAgICAgICAgICAgICB8ICAgICAgICAg
ICAgICAgICAgICAxNC44IHwNCnwgRXZlbnRmZCAgICAgICAgICAgICB8ICAgICAgICAgICAgICAg
ICAgICAgOS43IHwNCnwgUGlwZSAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAx
Ni4zIHwNCnwgRG9tYWluICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAxNy4zIHwN
CistLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsNCg0KLS1T
b2hpbA0KDQo=
