Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507AA62A26D
	for <lists+linux-arch@lfdr.de>; Tue, 15 Nov 2022 21:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiKOUD7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Nov 2022 15:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbiKOUDn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Nov 2022 15:03:43 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CAF6440;
        Tue, 15 Nov 2022 12:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668542622; x=1700078622;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yteYjwZsaVzHhhf3XEJYe/1c2b1X8flW4l9mmJKt2AU=;
  b=YIvEeDLJGw7L663sofirgH2/AkfnLuN0/ZxMO61ts/uKKkkOFeiFtQjP
   AL+ScFhn+bYL11qQH0FaNFDi8iQrU1o1ZnoGbaU/1QyTlkC68p/CYUMFI
   M347RZE8b+ZzWfzOZr2lrG6O8HRpT44iDX4ex3gqDqqU36d2PGv3cn1xp
   Z8M7N/k/cSbWrShFvBlp9Qin/VlqVWjTypoyt9ffnPreRxUXccst6Oqdr
   KeMNFy+q+vIYM8vrlyxiBjm2HwW6U+KHIzR4tVm5vWaL2lgaDGM4FFMJe
   GRSUwZO5gVbfJrXD2+lD0KZgBGZjdm/YH5tnQcdrrqwj0o6a2q2mCJzop
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="339158762"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="339158762"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 12:03:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="702571797"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="702571797"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 15 Nov 2022 12:03:12 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 12:03:11 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 12:03:11 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 12:03:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5wKMw9TOk6NLQRPMboxsoyGyJaeeXnyXkJfYS34S+2bZ5yakCvPh5w0jLY/gBp4YL4QNx5En7vBFevZiDkCbYQIoLQgboXHpShMEy0X+WVr0sQMVSjVbMGy5YPaK/skIYAnibvx0lNA3yw2MacqWlEgbDPm4qILT6foMA2NaFFrLjt6/bbcmLGz2k4ktemSCq+QZOQos1MUUAt3AZ9pcqyVf8p0L1Lvh/yRzLujSCtycgUiuxkUeSkT7nzddCb1AvjnqgxABv+4Hq6wCw2byFfIgn/QYOD/VDLnZNsglDLuchka0WhVkJaDUYM32+aeBMbXRdkoo+Z2n8eAXQpZ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yteYjwZsaVzHhhf3XEJYe/1c2b1X8flW4l9mmJKt2AU=;
 b=UpA8xbgEpQ69+5ogvq8B4xgMVeHDrV11eQEnvnqIDORHg+fqFPi64XGbChu5Q0qYqyqd1vbqP9YZtGyGPM0qGbw2Vp+789EyKUWbJyRkK+5tkyklp9r87RFxuA/kpA+LUep7nOt4vJ+FdQ/xv+wN9xh85ou9m6DVFK1wwtFIJHG6Dd+ii4JR/plbwNhOXyP3Pb1Yo/a4d2tOo3Jx5khJArheh6WDLXRJE8clJN/j/n4T1YxpAta8r0aXBMadfRgBy+Erxw/kWKSmpKmXtTgYV6bS4s2/tGbNpeefCSMtchFDQBSWMpbgdRsATKVQirMuvPq5s8IxhzA6faa1WLDPqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CY8PR11MB7060.namprd11.prod.outlook.com (2603:10b6:930:50::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 20:03:06 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3%5]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 20:03:06 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
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
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 15/37] x86/mm: Check Shadow Stack page fault errors
Thread-Topic: [PATCH v3 15/37] x86/mm: Check Shadow Stack page fault errors
Thread-Index: AQHY8J5a/ZcFBTphoU2iG+E5IUjl1q4/7s4AgACKgYA=
Date:   Tue, 15 Nov 2022 20:03:06 +0000
Message-ID: <b89565c96a0330c27ae179d96be05d2fc006121c.camel@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
         <20221104223604.29615-16-rick.p.edgecombe@intel.com>
         <Y3N8Sn65TzyD6jwL@hirez.programming.kicks-ass.net>
In-Reply-To: <Y3N8Sn65TzyD6jwL@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|CY8PR11MB7060:EE_
x-ms-office365-filtering-correlation-id: 6d2c7fe9-c2b2-4a2d-945f-08dac7446934
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L9XGgd37jJ4bPPomQap0nFzeSrtWk02BJzxkPXoClk0c6kVgvCOTlEL45oPlvaOHJ6rAXnrtxp8Ltv6WgyqN6YMaaGRwr2mJ9xBZle6iQkziBM2gCE6K/yhHqTitTIKWx/oXn3zUzJ3J+K1fH18LaqO9/v7Wnikkp6KrCpBJz3EoTScDptWlhjG9LlqJRJ1njhuG4HYeGYC0ANgEU1vkQGxiXpOGULlnvuRrJyrzWdcBYP5qS7jnUx3Dz8dLFZMqhHOtZ95O5E+NCqDPhTKnlZELcdWQ9/LdYEBth/gD+9PMriuvkIc63SfhXx3vrgGdX9Ob7ysPXKuKVLstd2mZAJmC+uycBAmq4O+s7zdcfDsnr569bE0tZKZ7K3geHVLSnmCB1+ekXfLTNWlXEmG7ZDzpcCepFyhmc9fMHVE9uupK1vHyxaC4PFIuyX8hlnHiDVGvCF6dexfhKz0dyQMYH0N6N7GTD4k7BfNmWZ5lJMCaUMctz3mu5WewF2C4kXSaVm9obYC7bTyLhU7cnkbr7txBdBsm/J4IC1SMPKaFEQk7M1efJfpbOnbB7LRA5tECcLSIa3+rPD+3RH0iutyiqJawKlmfPeekLabKkjFP8hwTSCnPMOS0rBUVq+P2HdcjApJFBDj614NvHBGVUnhr+8mFE81Ac2JC/+DIyATN505nklRzZ4BopgsKRHIQxgqXpVF7M47IrHz4hqUnPIyuy4MnLejeqAei24y5iHgzNsAeRZ9kNhUiXntk3yrVa01prok47cv/+iO4Os0WE7wZRoRfwNvFDNrgMNn8FJ2c4F0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(39860400002)(136003)(396003)(451199015)(5660300002)(7416002)(7406005)(8936002)(86362001)(478600001)(82960400001)(6486002)(41300700001)(2906002)(4001150100001)(38100700002)(122000001)(83380400001)(71200400001)(26005)(6512007)(6506007)(36756003)(38070700005)(2616005)(186003)(316002)(4326008)(91956017)(54906003)(66946007)(8676002)(66446008)(66556008)(66476007)(64756008)(6916009)(76116006)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkkreVFVV1lrL3hqOXQ1eDNDK0VsZm9UQ01URDVsMEltQ0c1S0hyTHNTQjFs?=
 =?utf-8?B?UkhiUERZZjVlR21ZRTdsemtDUklHbjVSZlY0TmpaRnkwUC9xU0FadnNnQ0tp?=
 =?utf-8?B?dTc2cGR3TmliNWtoQjFoYmpQZ3lvU1FaL2FtZUc0dks3a1NhZnBtc3p1T04z?=
 =?utf-8?B?djFQOHRzNHhUM1o1WDFnakNvaUhZNnQ4aUYvZHVzRXA5QWMzSzFwWmhkRWxG?=
 =?utf-8?B?Rjluck1UVmVaWVNqUDVEODZnYVhPczc3L3JXVG9rbnYzd2NNaEsrUndnMmlM?=
 =?utf-8?B?ZHRtcVBxRFFWTWdRT1lDUGZRWGpVa3lkTjJndnRtVnFMWnVwZ2JIMHBQWkM2?=
 =?utf-8?B?RzNnTDFjZjRhTnJROXBFc1M1R05mS21vSXF5emlFVVFMSW96bHp0Y2FxMk5q?=
 =?utf-8?B?enFVNlJMSzJqbndZZVdTZGFKZ1JxOHVyUEF6Y0ZhYkkwbTcxWE9zTGIxZEdP?=
 =?utf-8?B?QTdJNjdnaHRuMGNuVHdWUzVWK3J6SkcvbG45SlprMW45S1lZaTMvRDg5ejhG?=
 =?utf-8?B?QXAwSkhGYWVLM2Uza1JydHA2SkxrY0NEb0dGTlNFL0plaUpobWFaOVZaL0Rj?=
 =?utf-8?B?TXBJL0pCRldDV1Y2UHF3TTRJbnBSMElXM1R5YnVYYmF6ckxLYXEzYUQ0ZzZl?=
 =?utf-8?B?ZWNrSDJZUDRnUDB5QnIxWGdFZDNyWXVvSmRZRUZMQk5jam9Fdm92UnJPcHQ5?=
 =?utf-8?B?ODdnT2Uyc1pZVFhjZVl6cVpLcjgrYzVlMFZOOHE5ekNBdGI3b1g5SFlTQjNV?=
 =?utf-8?B?RzQ1OWZyelg3em1WUHNsaDNTVVNDYytEMXhOek5TUDZCa0VwbEZnalRaL0Zl?=
 =?utf-8?B?UVBha0tOTEZOQ3ltSytXMi9hMlNHaEE3RTFDc3N0algzTzlVUitBNEw0eWVk?=
 =?utf-8?B?bXlKQTM5ckJrbjJWaEZQRTAwc3htRWVlUnI1N2M4ZlZReG5aRXNnSXNkSU9X?=
 =?utf-8?B?VnZ4NUpDZjhGbFpMZkZRblV1RWNPdDAydEFkWXgzWjBqdG9pWEwyZGNuekh1?=
 =?utf-8?B?b0R1YXJnSnl0S05lbnpLa2oybXdtdlFrd2xwdU5PMWphYzhMNkljMEpQSlFu?=
 =?utf-8?B?MjllZVM3aWNIZnAzT2h2V00zaGpsbEZCVy9mMWp5SmFrL3BKc1gyMTBZdmUz?=
 =?utf-8?B?Zk5tdzZXRmFhVTdmVDNlQzhWWU1WRmZCaVJGM3Z1VFhvZFdKSWZPYVJUbm14?=
 =?utf-8?B?MUlVbmh0cnRwV1RHencvaDJxaGd3TnUrRFl1NzA4SU1oU2RvYWhnbTRWVkh0?=
 =?utf-8?B?bWVRU2ZTK1k3YklRQ1FLNU43SHFwbVdJclRqcllOZW9kVy8rUTJsVFUxVXpO?=
 =?utf-8?B?NnNhS2UxYVJBdTVXcW9iVHZRMjU2MzduZXFYK2U3SktOQWZKTTVBdTB1M1JE?=
 =?utf-8?B?bTB5eWM1Wk1IUmgvODRJUVF1Zk93Mkt4UUNnZ29hUUcvaDJsQjNYeXZacG1l?=
 =?utf-8?B?TWFsdjJBTFdYTGZTZU1CYnRFa0hJaUZVUjhkdHpVZ1FmemttcWt5eUx5cjQx?=
 =?utf-8?B?c0RQblZQeHgrWUw1MGlOL0VhV2d1Nnl3VWgyWjhObjRwVEVRNXNHZDh0dEJN?=
 =?utf-8?B?eGZWUm4ycWI4ckFvTTlGNFlyTHBGVERTdGNIOUsrSWdHMGtucVZUbW1pMUdK?=
 =?utf-8?B?dC93VUVwRytJdW01cHowd1hPU1I1K0tNa1hRakp6Z0ExVHUzTGRNT2o3MHdT?=
 =?utf-8?B?TXJxK0VoZERwUTdQM2JPaDF4M1dUZjdGdTJRNWdqVXBuMkVjcWtjNkhubS9Z?=
 =?utf-8?B?ei93cURPNjFESG9xK2pmcGhMNHdlNXFHaXk1MHNPUkhDYTJxYU85U2QvdzlM?=
 =?utf-8?B?YTJIelZpV2kvblFaNGJhMSt5d1pMZWQ3MUdTamxTc2ZqTnBVN2xvL0lrM09p?=
 =?utf-8?B?eGNDM05xaW52VG1kSGVNZVRLZWxUYXJoV3ZIbEtkVkczUENOc0s5KzlxMFUr?=
 =?utf-8?B?eXBnRWZ1KzBBMFJYd0VFZmVObHZLNDkwVHVJb2NxR2NzZlJVN2U2TnFpbTll?=
 =?utf-8?B?NFYwVGVLTHd1WDFyVS9tNFpJVUthcnNncEp5bGsrYzhuSFVMZzg2bWM5UXB3?=
 =?utf-8?B?UHBYa0cxRmUrRi8xZXhUSzJoZUk3UWVoQmYycnVod3RGUkJnMTdoeGJkdk5a?=
 =?utf-8?B?Y0pLMm5FT3k2RERmcWVXWXBPakpGcmFKRDN0YUlDK2pjcGxoL1B1QWlPdUln?=
 =?utf-8?Q?Oh1fZLnRBKOqjVn2kAIISAM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <85DE58AED0B31C40960E3840F1DFF244@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2c7fe9-c2b2-4a2d-945f-08dac7446934
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 20:03:06.2634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 38ERvlZ1Zaaa+G0Ef3AKa5Yh+lk7k5fNkMf7THYLJAm5WDklAbkOjWRZwRkHCQYFBKRozTSYH3xHJaU+rqzpcyKCJ9OfRWg0ysPQnpJioHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7060
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTE1IGF0IDEyOjQ3ICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gRnJpLCBOb3YgMDQsIDIwMjIgYXQgMDM6MzU6NDJQTSAtMDcwMCwgUmljayBFZGdlY29t
YmUgd3JvdGU6DQo+ID4gQEAgLTEzMzEsNiArMTM0NSwxOCBAQCB2b2lkIGRvX3VzZXJfYWRkcl9m
YXVsdChzdHJ1Y3QgcHRfcmVncw0KPiA+ICpyZWdzLA0KPiA+ICAgDQo+ID4gICAgICAgIHBlcmZf
c3dfZXZlbnQoUEVSRl9DT1VOVF9TV19QQUdFX0ZBVUxUUywgMSwgcmVncywgYWRkcmVzcyk7DQo+
ID4gICANCj4gPiArICAgICAvKg0KPiA+ICsgICAgICAqIFRvIHNlcnZpY2Ugc2hhZG93IHN0YWNr
IHJlYWQgZmF1bHRzLCB1bmxpa2Ugbm9ybWFsIHJlYWQNCj4gPiBmYXVsdHMsIHRoZQ0KPiA+ICsg
ICAgICAqIGZhdWx0IGhhbmRsZXIgbmVlZHMgdG8gY3JlYXRlIGEgdHlwZSBvZiBtZW1vcnkgdGhh
dCB3aWxsDQo+ID4gYWxzbyBiZQ0KPiA+ICsgICAgICAqIHdyaXRhYmxlICh3aXRoIGluc3RydWN0
aW9ucyB0aGF0IGdlbmVyYXRlIHNoYWRvdyBzdGFjaw0KPiA+IHdyaXRlcykuDQo+ID4gKyAgICAg
ICogSW4gdGhlIGNhc2Ugb2YgQ09XIG1lbW9yeSwgdGhlIENPVyBuZWVkcyB0byB0YWtlIHBsYWNl
DQo+ID4gZXZlbiB3aXRoDQo+ID4gKyAgICAgICogYSBzaGFkb3cgc3RhY2sgcmVhZC4gT3RoZXJ3
aXNlIHRoZSBzaGFyZWQgcGFnZSB3aWxsIGJlDQo+ID4gbGVmdCAoc2hhZG93DQo+ID4gKyAgICAg
ICogc3RhY2spIHdyaXRhYmxlIGluIHVzZXJzcGFjZS4gU28gdG8gdHJpZ2dlciB0aGUNCj4gPiBh
cHByb3ByaWF0ZSBiZWhhdmlvcg0KPiA+ICsgICAgICAqIGJ5IHNldHRpbmcgRkFVTFRfRkxBR19X
UklURSBmb3Igc2hhZG93IHN0YWNrIGFjY2Vzc2VzLA0KPiA+IGV2ZW4gaWYgdGhlDQo+ID4gKyAg
ICAgICogYWNjZXNzIHdhcyBhIHNoYWRvdyBzdGFjayByZWFkLg0KPiA+ICsgICAgICAqLw0KPiAN
Cj4gQ2xlYXIgYXMgbXVkLi4uIFNvIFNTIHBhZ2VzIGFyZSAnV3JpdGU9MCxEaXJ0eT0xJywgd2hp
Y2gsIHBlcg0KPiBjb25zdHJ1Y3Rpb24sIGxhY2sgYSBSVyBiaXQuIEFuZCB0aGVzZSBwYWdlcyBh
cmUgd3JpdGFibGUgKFdSVVNTKS4NCj4gDQo+IHB0ZV93cnByb3RlY3QoKSBzZWVtcyB0byBkbzog
X1BBR0VfRElSVFktPl9QQUdFX0NPVyAod2hpY2ggaXMgcmVhbGx5DQo+IHdlaXJkIGluIHRoaXMg
c2l0dWF0aW9uKSwgcmVzdWx0aW5nIGluOiAnV3JpdGU9MCxEaXJ0eT0wLENvdz0xJy4NCj4gDQo+
IFRoYXQncyByZWd1bGFyIFJPIG1lbW9yeSBhbmQgd29uJ3QgcmFpc2UgcmVhZC1mYXVsdHMuDQo+
IA0KPiBCdXQgSSdtIHRoaW5raW5nIFJFVCB3aWxsIHRyaXAgI1BGIGhlcmUgd2hlbiBpdCB0cmll
cyB0byByZWFkIHRoZSBTUw0KPiBiZWNhdXNlIHRoZSBTU1AgaXMgbm90IGEgcHJvcGVyIHNoYWRv
dyBzdGFjayBwYWdlPw0KPiANCj4gQW5kIGluIHRoYXQgY2FzZSB5b3Ugd2FudCB0byB0aWNrbGUg
cHRlX21rd3JpdGUoKSB0byB1bmRvIHRoZQ0KPiBwdGVfd3Jwcm90ZWN0KCkgYWJvdmU/DQo+IA0K
PiBTbyB3aGlsZSB0aGUgI1BGIGlzIGEgJ3JlYWQnIGZhdWx0IGR1ZSB0byBSRVQgbm90IGFjdHVh
bGx5IHdyaXRpbmcgdG8NCj4gdGhlIHNoYWRvdyBzdGFjaywgeW91IHdhbnQgdG8gZm9yY2UgYSB3
cml0ZSBmYXVsdCBzbyBpdCB3aWxsIHJlLQ0KPiBpbnN0YXRlDQo+IHRoZSBTUyBwYWdlLg0KPiAN
Cj4gRGlkIEkgZ2V0IHRoYXQgcmlnaHQ/DQoNClRoYXQncyByaWdodC4gSSB0aGluayB0aGUgYXNz
dW1wdGlvbiB0aGF0IG5lZWRzIHRvIGJlIGJyb2tlbiBpbiB0aGUNCnJlYWRlcnMgaGVhZCBpcyB0
aGF0IHlvdSBjYW4gc2F0aXNmeSBhIHJlYWQgZmF1bHQgd2l0aCByZWFkLW9ubHkgUFRFLg0KVGhp
cyBpcyBraW5kIG9mIGJha2VkIGluIGFsbCBvdmVyIHRoZSBwbGFjZSB3aXRoIHRoZSB6ZXJvLXBm
biwgQ09XLA0KZXRjLiBNYXliZSBJIHNob3VsZCB0cnkgdG8gc3RhcnQgd2l0aCB0aGF0Lg0K
