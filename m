Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCA45F33F2
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 18:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiJCQ4h (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 12:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiJCQ4d (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 12:56:33 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF126473;
        Mon,  3 Oct 2022 09:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664816192; x=1696352192;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SU1vIA3pWvo4TSKvPSHQaxpCSK1flZb/R3kno6earf4=;
  b=geCRrhJkEWen1DsB3vqJ6cEf7bhe6t/i9y2HcPgfPEC9QDbYdqtIzJbR
   xWShkPPuIGxgRdLNFgxuuZ2Cb53vJF9Z+GqswEo0Q0ddCl5WCxF6ejZ0r
   17lrDAZuKReOCH+9Kdsl1qVcjfORzb5YWB270osliE3Pzi99MzvAjRkTs
   Bw8cPJUe8RIe5jTly0rFRGPLQtJdpBERJx+G11/9Yh3BRqQZxGlPoJq2J
   UVbe6ogtBw0zRyVlIq4ALpr0WDRbres284NjcLPWn0fhYyj3FxZhtfURQ
   XUh3WYfvFjXl0Q7LZ/0MNwB9e8jTXy1/KvHLGeeaP23BA9+QfHuI9O58N
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="283059944"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="283059944"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 09:56:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="692138324"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="692138324"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 03 Oct 2022 09:56:20 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 09:56:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 09:56:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 3 Oct 2022 09:56:19 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 3 Oct 2022 09:56:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXk4BT3HPZSc2A39ioCweA9AZeU7IGCDTwfpJsQYZkG8/6+jc29RuTffCOL9woz/117G2H3sgq3aV4TVv00+RvuvsCaiDKSzXayItgAUIgY5U9Z0Tw6oBqTlb5A4fBod9gTcVNQ9FcZRyRJuhFSjrntbW1OXCKaCFkXUP3tF1AsCmwhhz1rOe6PbrSg5+e+raWwhQrZXtvC8o6fqcyaTT/quhVeADSKhxZbFz9P17BRgxD65MxIktP0EymyGhg4Qv7+A7R8duNURFIbXObBDwTNXuaXErTErzX85zDWWbKaKuCck6Ugq1OhypumyfmORZmLFhbX4KpzRRjtGHib2Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SU1vIA3pWvo4TSKvPSHQaxpCSK1flZb/R3kno6earf4=;
 b=S2PzGSucUf7O3kI7m4VnQ+C38eOZpVXlagYA+U2aLoIWwH0+hLVk0aU7s/DaWFBmsoHZvAAhXP4WgHgXxTzqBzhLh70l3fKCmlX++xFvt3YLDrGA4ekgZIfDQssN8xG7dq58CVoRbVYUuIhAm8dTaMipsNw6lzhfHEOfv1ArThwRbtwC+X9wZhUmK+9+Z3tegiqP+19/Gfhi0X6ym/DUj1crX5oYw9USrjqBO9zwVT2cE3Dix6ZPUX4uXpDIFosQJAdAJJdDBKe2gQ0/Io8Ry3Ju4UkWhrSRuNy8BwA9QvDZJXNlDkg9JsFpUom9IUEAROfUJ33coJlm1jYnVptdOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH8PR11MB6729.namprd11.prod.outlook.com (2603:10b6:510:1c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 3 Oct
 2022 16:56:11 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 16:56:11 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
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
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v2 01/39] Documentation/x86: Add CET description
Thread-Topic: [PATCH v2 01/39] Documentation/x86: Add CET description
Thread-Index: AQHY1FL/9ZOrfh44YkS3ARV6MT/4g633VEeAgAClcYCAAAJLAIAE7WiA
Date:   Mon, 3 Oct 2022 16:56:10 +0000
Message-ID: <5832fa687e6da50697a7627d53453b728ed1b7b7.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-2-rick.p.edgecombe@intel.com>
         <YzZlT7sO56TzXgNc@debian.me> <87v8p5f0mg.fsf@meer.lwn.net>
         <0eb358ac-068c-d025-07e3-80a3c51ef39c@gmail.com>
In-Reply-To: <0eb358ac-068c-d025-07e3-80a3c51ef39c@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH8PR11MB6729:EE_
x-ms-office365-filtering-correlation-id: 741a09f9-470c-4f24-8aad-08daa5602c94
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wbZhclfvu1xIcAV9J5oR16VvjPgp0IDm/LzSMQArJ89WWG73wT0hUUwoY5HaXhGuD3Ak+pg3GHTQymCNrzbiWc22uGe6YJL93CExsrPxQbCGzwchavQYAh2c4rXuMzTekAnD2UAl3PJHbCxMhPjBa0tUaVKJFIqXoPtf91bB1YH0F1To8ukLxQoXTKA9nHWOqx05WGmwwKkRNzXCHU8QNW9tVBrWvh+unHjmbz9V0ZaF7XwvnBltM1ByRyGLrXJQDQqN3mNmmb4eSv+fmYCabtXztQWeVAJ3d+ulb0c5mF0cSTX4NC7euk1b5vDngyv3JF2afOviW2oLQygqV4GGhtoEsySYyZ62BUQ1kRFfO6NJhPOaCueN0d28DqrVtEQF/CyvjI4yiySD8mibxQoGB4OADYWvPwxK6tWK6k9g3TEfvDbNz9acRGLq8gMvSrs+z71OHlz39DYTIcks+myf3u9/dJtZWcliqzhpOZ2OsWpR9MjX9jO7hhyXjX007km/6w2vBb60dbwpfT1G0o7C1gVi6jwVN/Banfo1RhvyKlXm1l387mAJoC8HPI+GiVVaCF6sY5WaCPP3c07g81krz5eh9i3GXxgPmTP0V5pX6wLQKbsBIZOsFQJw5ywVBFiMEoQyAed2mXUrtjxCQqzRpjERRo8TsDIYDpUYIgvvA6zti4TcpQ5qqdEP4GvM8+EBvVpglGrZ4ufOtyk75qZZJTJf+yVDRL0xlxAbagP2P7tSZkEBpd2N5l5+b6zDUe0otJfIntCFJwbIGCYkS8LkU6Jp6ZeOoBEaj5gVbVAFWX4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199015)(36756003)(6486002)(83380400001)(41300700001)(5660300002)(38100700002)(122000001)(2616005)(86362001)(38070700005)(82960400001)(186003)(478600001)(53546011)(316002)(71200400001)(6506007)(26005)(6512007)(110136005)(8676002)(7416002)(64756008)(76116006)(66946007)(66446008)(66476007)(66556008)(7406005)(8936002)(54906003)(2906002)(4326008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1NqU1lZSUJiekFhb2EyU0t3U05PU0VpNDJKWTJiWnYveWtLZnRMKzlnS29Y?=
 =?utf-8?B?NEV6UCs0TlhMb1dJWDR6M3hMMXBDcWZUaWhJaTA0YkZLc0lkb0VFTDVlWThJ?=
 =?utf-8?B?Unk5Vm1DRXMycWxwc0VYemlHSDdVRFNEZlg2YVF6ZTdVRnVZNHo2ODZsdFJz?=
 =?utf-8?B?aS80MjJuazVoTHgrOFV6Wk1MT2l1cklhWnhsamVFaEE0TlFkVW5kc0hIcnhG?=
 =?utf-8?B?OHhEMTN3VnR4MWh2MVlYVCs3V29YWm5jeVkrSFd3ZlhIQmFPUnd0eDJyNU1O?=
 =?utf-8?B?N2d6M2VzQjJNeTIvRGJCUmI5MC95WmRLS2JBR2RDN1R3c3hqbkxzM25LaU9P?=
 =?utf-8?B?aUZyM3dndExodWtQYlROem9uaEh3MWdPYlMzWm44bGpWY3B2SktJODNDRkVm?=
 =?utf-8?B?N0lLcWlUQUlLSUxHSzZldlh3WTFvUW83dStyYlYxL2JneGEvWmo4ZU5TSGl5?=
 =?utf-8?B?a1A1UGt2c2RjYTVEbE80QWdvMXBkcTdQOURzSUFzRE8zeVVnM21VcnQ1dXph?=
 =?utf-8?B?WTZFRjkwSm1iZ0FjZUJxcHFJT3NRZ2VhY3FFNmt3NkVCRW1RQWxkRmozRXlL?=
 =?utf-8?B?ajZldUd2RDhSK29HeWx6WFo4Ry9vRkppM2JVbHRZSnhQbEV2dFA5SzczT0xU?=
 =?utf-8?B?S0R0SytsM0hCTEtuOUUwZmFTUnAxT1U5cnc5ZGNwelllZWZHUmZwTzFWOGJy?=
 =?utf-8?B?K3NiODFFM3BDZjdJdnJCR2RRaXB1VWk5bmtCVHVYSzNBbnNURHBhL1JRT3hi?=
 =?utf-8?B?YldtaldUYy9ZMUc2TnpEZVl1VHJxWTdKSXlTeUNPNWNKTm90RGZkc011SHhv?=
 =?utf-8?B?QWcxK2tsRzljNDZEdkNyOVFHZjZNcnJaRGFGTDlKVTZyZlZySHVRY0JiNWt3?=
 =?utf-8?B?SXpEd1VFQitla1ZqRFY0MkZhZFM0N2xtdWFPT2JEWG5vcm43ckpmV2MzZ2Va?=
 =?utf-8?B?RmszdlFxOHRLYWppSEdBTVdOclpQdUVpRlFyOXV3SllCd1FxRU5VeHhmeHhO?=
 =?utf-8?B?RVRXY21BSHRnZlFJbEcyZjl6cVMzMGtqRVRVd0RTUmFDNExiNkVQZWxXV3h2?=
 =?utf-8?B?ekJ1ODVBNTQ2RG5ZVFVxS3MrZ1VUR01qYnkxWWxtUUtYM3lZdnhRcGhyMGx4?=
 =?utf-8?B?UmtHcmIwb2xHTytEd1JacWF1Y3JOWjA5M3ZXN2xZNmJmVjZvSTJzZ0lXYWtv?=
 =?utf-8?B?RUZNUDlNTStrNy9xbFV4bDljamVOUGxsNHpYQmRsaU1JZWFHODdQaER5YTk3?=
 =?utf-8?B?RDFLa09pQ1hqOFJNL0E0a3dMNG9qNU9CYW41ekZRSFF6NWQ5a0pPWHhoS2hC?=
 =?utf-8?B?Q2RrR25JNXJtMFh2cjhKNkdMdmhVVmMwdUFnWkpxVTdNMFRHbi92OGNUT2x2?=
 =?utf-8?B?NkFMdWw4KzErNnVza0l0Y1MvTlJJcXl2elpzZVlWM1VxOW5SOVE4MWN2c3Bs?=
 =?utf-8?B?ZGcyUDdNYnYyeE96ZVpJcllSaFVYQTBsOHFFTWx2RmtCN0JXRTYvMmsyRU9p?=
 =?utf-8?B?WHZDMUZYcEVQL1BxY2RUSFJld0VMY28vQTRTWUVYSHo1b1F3M2QrT2xzZC9p?=
 =?utf-8?B?WTQxcHY1OUFRS0JrR1g3RVVXQ3VBb3M4a2ZLaWpyWEdGYWpkQlBWYXg2SDFy?=
 =?utf-8?B?VC9uK0FZRm1xbjJlVHdTTFZDVnVLZ1JIVzZKRzNtbHBFR2xaQjMxektsR1hZ?=
 =?utf-8?B?UXRCYlJhclU0L2hHemtjc21HN3V3WW1CcmVMbFVnR3o1Szhjd3A0d05xbm9B?=
 =?utf-8?B?SzEzd05vMG85ejBaZENMRHluLzAxUUVYQnIvUnB1SEIzUnFaR2dDU2hCWFlS?=
 =?utf-8?B?blp5TUQwaHZGb01JMC9LMW4yMEZzdWJNcW5QbUtQdytjOUloZFlmcWlQZ251?=
 =?utf-8?B?cHdDRERDSUNocTcyOTZLWXNpWGp1cW1PSE5LRWo2TDFoeURxbFZ6L1RQTHpK?=
 =?utf-8?B?ZVRnSWR5MzZHVDY5NFdrWUJESlVXUGJqb0tyTVNMVUExRUtCMUtKNGFOU2V1?=
 =?utf-8?B?M01rcG1LeEZQR0tSVklYSjNVSlFCRUVRYkdMaE5qOVAvcDJWMUhYcGRhYlVh?=
 =?utf-8?B?Y1RDUjNiRGRoaWNaSm15QVRQbzY4V0tmc1BFVjlBbmR5MTlDQXJ6UTNhdnNm?=
 =?utf-8?B?MGRKclQ1MVFnQXdndWpTY08vblhmcjFKVENVTi9zRDQ2S3hZNnUwSEdvZmV2?=
 =?utf-8?Q?hs6NxGfO37Y0OZcSjsKXMyg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAFBA8FB125DE947BA5DC594318AC1FD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 741a09f9-470c-4f24-8aad-08daa5602c94
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 16:56:10.9253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3PN20KDNxP/+BeQSvBsQVg9Th2MsvsTnt3X3KL7Gb38nW5xwMLBeBLglzVT7h+HcxSemPsBDqGZsYZhdKzuXZpIt/5De5SzPrIpPLOq7VBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6729
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIyLTA5LTMwIGF0IDIwOjQxICswNzAwLCBCYWdhcyBTYW5qYXlhIHdyb3RlOg0K
PiBPbiA5LzMwLzIyIDIwOjMzLCBKb25hdGhhbiBDb3JiZXQgd3JvdGU6DQo+ID4gPiAgIENFVCBp
bnRyb2R1Y2VzIFNoYWRvdyBTdGFjayBhbmQgSW5kaXJlY3QgQnJhbmNoIFRyYWNraW5nLg0KPiA+
ID4gU2hhZG93IHN0YWNrIGlzDQo+ID4gPiAgIGEgc2Vjb25kYXJ5IHN0YWNrIGFsbG9jYXRlZCBm
cm9tIG1lbW9yeSBhbmQgY2Fubm90IGJlIGRpcmVjdGx5DQo+ID4gPiBtb2RpZmllZCBieQ0KPiA+
ID4gLWFwcGxpY2F0aW9ucy4gV2hlbiBleGVjdXRpbmcgYSBDQUxMIGluc3RydWN0aW9uLCB0aGUg
cHJvY2Vzc29yDQo+ID4gPiBwdXNoZXMgdGhlDQo+ID4gPiArYXBwbGljYXRpb25zLiBXaGVuIGV4
ZWN1dGluZyBhIGBgQ0FMTGBgIGluc3RydWN0aW9uLCB0aGUNCj4gPiA+IHByb2Nlc3NvciBwdXNo
ZXMgdGhlDQo+ID4gDQo+ID4gSnVzdCB0byBiZSBjbGVhciwgbm90IGV2ZXJ5Ym9keSBpcyBmb25k
IG9mIHNwcmlua2xpbmcgbG90cyBvZg0KPiA+IGBgbGl0ZXJhbA0KPiA+IHRleHRgYCB0aHJvdWdo
b3V0IHRoZSBkb2N1bWVudGF0aW9uIGluIHRoaXMgd2F5LiAgSGVhdnkgdXNlIG9mIGl0DQo+ID4g
d2lsbA0KPiA+IGNlcnRhaW5seSBjbHV0dGVyIHRoZSBwbGFpbi10ZXh0IGZpbGUgYW5kIGNhbiBi
ZSBhIG5ldCBuZWdhdGl2ZQ0KPiA+IG92ZXJhbGwuDQo+ID4gDQo+IA0KPiBBY3R1YWxseSB0aGVy
ZSBpcyBhIHRyYWRlLW9mZiBiZXR3ZWVuIHNlbWFudGljIGNvcnJlY3RuZXNzIGFuZCBwbGFpbi0N
Cj4gdGV4dA0KPiBjbGFyaXR5LiBXaXRoIHJlZ2FyZHMgdG8gaW5saW5lIGNvZGUgc2FtcGxlcyAo
bGlrZSBpZGVudGlmaWVycyksIEkNCj4gZmFsbA0KPiBpbnRvIHRoZSBmb3JtZXIgY2FtcC4gQnV0
IHdoZW4gSSdtIHJldmlld2luZyBwYXRjaGVzIGZvciB3aGljaCB0aGUNCj4gc3Vycm91bmRpbmcg
ZG9jdW1lbnRhdGlvbiBnbyBsYXR0ZXIgY2FtcCAobGVhdmUgY29kZSBzYW1wbGVzIGFsb25lDQo+
IHdpdGhvdXQNCj4gbWFya3VwKSwgSSBjYW4gYWRhcHQgdG8gdGhhdCBzdHlsZSBhcyBsb25nIGFz
IGl0IGNhdXNlcyBubyB3YXJuaW5ncw0KPiB3aGF0c292ZXIuDQoNClRoYW5rcy4gVW5sZXNzIGFu
eW9uZSBoYXMgYW55IG9iamVjdGlvbnMsIEkgdGhpbmsgSSdsbCB0YWtlIGFsbCB0aGVzZQ0KY2hh
bmdlcywgZXhjZXB0IGZvciB0aGUgbGl0ZXJhbC1pemluZyBvZiB0aGUgaW5zdHJ1Y3Rpb25zLiBU
aGV5IGFyZSBub3QNCnJlYWxseSBiZWluZyB1c2VkIGFzIGNvZGUgc2FtcGxlcyBpbiB0aGlzIGNh
c2UuDQoNCkJhZ2FzLCBjYW4geW91IHJlcGx5IHdpdGggeW91ciBzaWduLW9mZiBhbmQgSSdsbCBq
dXN0IGFwcGx5IGl0Pw0K
