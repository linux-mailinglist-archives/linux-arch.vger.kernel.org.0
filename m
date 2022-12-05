Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C376437ED
	for <lists+linux-arch@lfdr.de>; Mon,  5 Dec 2022 23:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbiLEWTZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Dec 2022 17:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbiLEWTT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Dec 2022 17:19:19 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316D114018;
        Mon,  5 Dec 2022 14:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670278756; x=1701814756;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7PaIHaiDJ7x56mNKtRj7r/YH/C2CLa3skfkKbCAQ+eY=;
  b=Av5Wy8GJFJc2OOlJ7omr9M2//bs8FLg76dbc6Q53qY101KEawxiUM9CI
   YJ/INXQEseTPP9k3j1Jyj60M+bQ/zGR7Uji8iBUI0KWPU9sC3Dv1bDfIx
   T9WhkRQn3OX9H7lDLvJ+c/M3rYjXhYl+MqxbLGcTm/EUmWQxhgQid1myT
   +AxtRKK0JjmIN6I9khTwvlCzqCZ2YHGjkGw7c7oT7tofLiZjllKtqE6Vk
   +vR+pINm8wC24Er6jrn4UZ8RDbZLf7MNhp9QZgKnMH0ibBJhfLYglswwa
   fCkhVu2yTAroWZZTPAvNdsfwrsPIQQEutfosJEyC730QIbH900o9lkPfQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="315186206"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="315186206"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 14:19:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="596354500"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="596354500"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 05 Dec 2022 14:19:07 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 5 Dec 2022 14:19:06 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 5 Dec 2022 14:19:06 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 5 Dec 2022 14:19:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHfH26TSDXvuOwQmzgaymJWmVEV0k+b0o4pcCHvajLFEPuCDUplPyYs97ZP0+DibC6ztWOTG3VPji6kPNiZoBD/jsETixP5urmTqk2T/CtanZdMIK280xtfWGs8ioFj17J5zkl9yOmBhKslfoAwO+87CEKa2kOWBAMqOK9peIAQM3+xQlO1vIpKBZwxUDDih/fYaWutqbQgYQDC4Xx/HArA7cwks8q5yLihGrY7tksyCElei52G5MuCzAq1zY2JgHjMhEfVG+61NcH4QyHvbpNX2okFggAxvOw52mvkBOIFBpnb6HTWEoh5WYc1scsGk5QOhsbGJRVdQQJ5S0dPoqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PaIHaiDJ7x56mNKtRj7r/YH/C2CLa3skfkKbCAQ+eY=;
 b=Dvl/udHHgRubve3f09bMvncKQXsUvIF5kUyCdgKBk51pFR+JU5Bb51JTzJ/VP4a0o5bWRF6Z9TU2JkKZtOcbGBWVX7VvgS/O1rZuCQvDgSQLGET+pvNVTJ5OdBt4aS9/BA/ejAPxtEvz0Rhsd79zm9cymN4+FMcFfaRRGrOEoxbcosE/P8MK+BAa7Wad1A5PQggsvwtfYBLfHvPclmLfo8sb6wuTGHvFv3vXzddIo8EvP79Q1ew0Gm9eLkg2Or09A8mh6LlcjQ/RPezADkHSLMwi7nQirVAN2J586EWfpdoyUrT4eSbDs4CZsWn0jNezwPswV8py8EZsMfgIHwg5+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by LV2PR11MB6000.namprd11.prod.outlook.com (2603:10b6:408:17c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Mon, 5 Dec
 2022 22:19:03 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff%5]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 22:19:03 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "keescook@chromium.org" <keescook@chromium.org>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 30/39] x86/shstk: Introduce map_shadow_stack syscall
Thread-Topic: [PATCH v4 30/39] x86/shstk: Introduce map_shadow_stack syscall
Thread-Index: AQHZBq91/JAPAjJRUEi1vuxjOZMjMq5bdtKAgARq9wA=
Date:   Mon, 5 Dec 2022 22:19:03 +0000
Message-ID: <ebf4214c83877fe7d88dbf89b4d2110cd1f42c33.camel@intel.com>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
         <20221203003606.6838-31-rick.p.edgecombe@intel.com>
         <202212021848.B6277C86@keescook>
In-Reply-To: <202212021848.B6277C86@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|LV2PR11MB6000:EE_
x-ms-office365-filtering-correlation-id: 8b94172a-a9cf-4405-33f6-08dad70eb75c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K1buajj9eP4DtknO3GcFQdzRj14jTIUcsDftUS8MlAJfE6b8rYsdL+8OAlosJGOEl2lAjRvIWwxlsO3tVBpNBP0hQD9rz3y4uYgC1DZSdZpilYZWxl3TpFk1bp2tfYYP1Ty/Gm3EUkACvgYLcwB+ONf2qX7fnIJU8GOPFyx538ICGYR87+Xv1XZ8f8YbEj8F0Ag19FlbXE5aSPwTy4Ds4RZ3xnUyTDHT24kFVlqExn0t5F3m4f0ahBTjnoljJ4D0Rq8C92hRBb5AVM1Zt1EB7u1y0WHsh2u1fRNkzz29iqe76iO2ycHicLANAHJn0jr9B4wvEiozXTY9oQWxEFnQj7mynNXDy/sJBMqHtQnJTnGzLBAKjHN5aoqdrJrksQ0OQUwuBAhif8HFDucJeq1mfIMHKk0Y0yzBEJjv05Ng4S6tXvTNFEaci2sVej3rCfsNP/gNiK5NlSnBbQYv3fuXTNx2MHVA5XiRuwsUhaLovyW5LOPC5d+6It50r0xekHI2aYOt3jKYRSew/JxUcO5l/ZGKu706FndI7J6rE5dbUPjVUZVlbatOGgpke3VENNI24MEo5POAxUMTBq6TImgf/ZVxDijYJRms/wDTeH/rzH/QJRuSrupTPhdmfqsgKqm75GI637w9CC59lkJ11ZoyhTi1WwdSElVxYctcpK26UQ4uMxDpooFy8wc6IcM+LPIdIr5kn/JINVxY1QO0i+85zs8BwkhUkYKwdhZ9t3gNG0I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(346002)(136003)(39860400002)(451199015)(83380400001)(2616005)(186003)(86362001)(38100700002)(122000001)(82960400001)(36756003)(38070700005)(316002)(54906003)(6916009)(66899015)(2906002)(76116006)(66476007)(91956017)(7406005)(41300700001)(66556008)(64756008)(66446008)(66946007)(7416002)(4326008)(8676002)(8936002)(5660300002)(6506007)(6512007)(26005)(71200400001)(6486002)(478600001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zm5PMnpUYXd6TGFyVmRDSlRnemdRRGxzTkgwWWpRQTdzSi9oT3A5TzNYK2JU?=
 =?utf-8?B?VWJobmwrcnBUeHZyUVBFYUhWZFZTYU40Y2hHOUc0V2dUellBRnE0VXQ2WEU3?=
 =?utf-8?B?d2F6TVZxVU5SR20yVS9KYXVmaGVDY01oajhtMFBGQS9JVXREeXNLYVRvbTRY?=
 =?utf-8?B?Z25NRmdyUG1kRVp5dEtxL3BnSmI2TkxEb1J1ZUFPNEJVK0VQdy8yY3d0V1Vn?=
 =?utf-8?B?RVdvRFRjWEVmZWdnaVRnL21XOTBvY1ZlaUVHYkNxZ2xDT2tBQ3BqWnZEZ3M0?=
 =?utf-8?B?TGhSTXFsMTZJUjRoeXplR1JaWEV3dWYzaUw5NUVtOWRvRHl0MUJaUS9FMWJa?=
 =?utf-8?B?ZkJNMHVXSm5UQ3h0QXNDTTIyamRzSlkxMFRMVzcyazVSZzV5MTBQK1dSeTNw?=
 =?utf-8?B?aWZlaEpnS0k4SnBDVGpKNS9pOFRQWE5OM3dIbXMwZitZNlJXR09YSmp5dTN2?=
 =?utf-8?B?eU5BZDFRS3pMckgvWStEa2xic1BDQ2xmNlJiTlR3OCtES1B2eWViOHljUXNB?=
 =?utf-8?B?MnlXbFRWL2g2dXEzQUZaOVRSOThHVGZ0UTdIVi8vZFNURjVuM1J4TDBITVpj?=
 =?utf-8?B?UHdnN3ZKQ05KT1RlSTBLM0p6ZGFXMDMrUmJUanJNenljYVpzd2tNaTZUOHFm?=
 =?utf-8?B?VTV2T2tvZE05QTEyaS9sVnQ1UkRBU0hNNTNBTzJYWFIxeTFkTHJtM1daWE1R?=
 =?utf-8?B?R29rSEVyYzhhRitzSTJtKys5UGZzSnUycG9ERTZQVUdlQVhaTDhjSHM4K1Rq?=
 =?utf-8?B?bG9lR1BQWVdSZlNYSUxmY2duMlBmaEFMSmtYQXRDMjNpdmJRaGFveWpRVTVU?=
 =?utf-8?B?ZXJ2RUhYSFRLcWNFaUsyUmE0WGk5Qy90VGdiZ3BJZ3IwRGJ0RkxhR3RZNnJG?=
 =?utf-8?B?U2FzaXJtekJyNk80aEM0dG1CalZPdW44czByQ3hIY1F1TVEvb2l5dXpEMUVV?=
 =?utf-8?B?MENXaDB5TDdoZlpHTWZvbFUwOTBUd2RnVUJVejdwNldDbThGWGFERnZKdlcz?=
 =?utf-8?B?MkFrQjNhZ2VXVzVsdHBIY1lOcHd0V2N4aklPTGlnWTBMbzdUMjEwUEhCMjdm?=
 =?utf-8?B?dVgxN1N4RXBIZGljTlo5cTZRbFF3Ym00d3ZSWUJLbGNZdFBzc2xxZXN3Y0ND?=
 =?utf-8?B?d1B5V012OHpMeFZHVmpwajExcWtVOGw3M3Nqc2M2am9LZS8zOWRpVlRrME5V?=
 =?utf-8?B?allvRTZtRlJJOXNmVCsrRWhUN1puVWVhRjVjNkZDRDc4VFdvUHBROEtvRTlD?=
 =?utf-8?B?TXA3OUorczk3Vll4LzErOEZ5VjVucDJVZTVhcm5MTHR5M0w3YVYrRmNVc3Z3?=
 =?utf-8?B?cEFRc3NxMkE2Tld2dTQ2TkpxWVVKTVRocytEWm9MMkhZYVNSY2VxLzhNK1Nw?=
 =?utf-8?B?VjdpMVVIM2llS21Iem1nRnlkTWx5QS9GaWRmS3RQazVYWFhUTE11VHk5d05Z?=
 =?utf-8?B?VHFkMDVSMzZrSXdHSmluMU0xVWVyU252NnpwMjAzYnlPWmZDaHcwUDR2L3lu?=
 =?utf-8?B?N1VEOGZzMDdPWDZsUVB2ZTY1bHZuRFpoQ2RZaEFSNFk0TWhWMHgzeG5Ebnhw?=
 =?utf-8?B?elRSbWV5WXBybTZDdGdkcEw4Z0g0Rll1L01Eeks1OFFIRFpHVzg2VzZKUjdO?=
 =?utf-8?B?Y2E5QU8zbmE3S0lIQ0lqZENiSENwMjUydGtXNWJiQUs3Y2pjNk5nV09QcVRY?=
 =?utf-8?B?bXVQTTFZWFd3ZFk2cVcxUlNTdEsxZXNyemcwVG5aMlJoL0tWZnFHTllmczdh?=
 =?utf-8?B?eS9CaWZXYnEzSGt3Nnd6K3lLY2dtNmdjVHMxWjNsMDFBVHg5c0F1cGJBWnM3?=
 =?utf-8?B?YkJtUlVqR2F0NFV3MG5IVU5kOUIxTXVnbW5URWo5ekJlcFc0UDhjSFc5dDBV?=
 =?utf-8?B?amRxaFZVVUkwVWZ2ZWgzOTBvdkZlYjY5b0svTGpRRDBUSEQwRkpsOWtTSWRl?=
 =?utf-8?B?RnlaNmliMWVvY0laZWhGbEdFdTNoTW5CeTB4cXcxaktJREs1aWs3cFl1cXpH?=
 =?utf-8?B?WWF0cGttVytYbDduS29scm5VN1pudXNTZjFmUytncEJnejNyRmtTS0RvaW1o?=
 =?utf-8?B?SHhEeGRYbW5qNW54WGlYSExEZ1BoMXJQQURRUUJ0SjJEaEE4cU5BWW5yRnNo?=
 =?utf-8?B?TVFaMGhHbGVvdE10aDdMSVFnUG9FOXBXNTc0c2orU29XVHBBZUMyUVV1MVBk?=
 =?utf-8?Q?A5CJ+HurhwvHpioS/514UGI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DCCE245B2829E438BA61509E6916C7B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b94172a-a9cf-4405-33f6-08dad70eb75c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2022 22:19:03.1664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MS5Ncoaox2EM269XVvDbl6o0Ivm3+DhZh8vTwzG50Fb9apX87stpnXnYrHBfn98PuY925GlNYqTei8egRZWrtYL94oWOYJxFkmDM0pwDNTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6000
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIyLTEyLTAyIGF0IDE4OjUxIC0wODAwLCBLZWVzIENvb2sgd3JvdGU6DQo+IE9u
IEZyaSwgRGVjIDAyLCAyMDIyIGF0IDA0OjM1OjU3UE0gLTA4MDAsIFJpY2sgRWRnZWNvbWJlIHdy
b3RlOg0KPiA+IFdoZW4gb3BlcmF0aW5nIHdpdGggc2hhZG93IHN0YWNrcyBlbmFibGVkLCB0aGUg
a2VybmVsIHdpbGwNCj4gPiBhdXRvbWF0aWNhbGx5DQo+ID4gYWxsb2NhdGUgc2hhZG93IHN0YWNr
cyBmb3IgbmV3IHRocmVhZHMsIGhvd2V2ZXIgaW4gc29tZSBjYXNlcw0KPiA+IHVzZXJzcGFjZQ0K
PiA+IHdpbGwgbmVlZCBhZGRpdGlvbmFsIHNoYWRvdyBzdGFja3MuIFRoZSBtYWluIGV4YW1wbGUg
b2YgdGhpcyBpcyB0aGUNCj4gPiB1Y29udGV4dCBmYW1pbHkgb2YgZnVuY3Rpb25zLCB3aGljaCBy
ZXF1aXJlIHVzZXJzcGFjZSBhbGxvY2F0aW5nDQo+ID4gYW5kDQo+ID4gcGl2b3RpbmcgdG8gdXNl
cnNwYWNlIG1hbmFnZWQgc3RhY2tzLg0KPiA+IA0KPiA+IFVubGlrZSBtb3N0IG90aGVyIHVzZXIg
bWVtb3J5IHBlcm1pc3Npb25zLCBzaGFkb3cgc3RhY2tzIG5lZWQgdG8gYmUNCj4gPiBwcm92aXNp
b25lZCB3aXRoIHNwZWNpYWwgZGF0YSBpbiBvcmRlciB0byBiZSB1c2VmdWwuIFRoZXkgbmVlZCB0
bw0KPiA+IGJlIHNldHVwDQo+ID4gd2l0aCBhIHJlc3RvcmUgdG9rZW4gc28gdGhhdCB1c2Vyc3Bh
Y2UgY2FuIHBpdm90IHRvIHRoZW0gdmlhIHRoZQ0KPiA+IFJTVE9SU1NQDQo+ID4gaW5zdHJ1Y3Rp
b24uIEJ1dCwgdGhlIHNlY3VyaXR5IGRlc2lnbiBvZiBzaGFkb3cgc3RhY2sncyBpcyB0aGF0DQo+
ID4gdGhleQ0KPiA+IHNob3VsZCBub3QgYmUgd3JpdHRlbiB0byBleGNlcHQgaW4gbGltaXRlZCBj
aXJjdW1zdGFuY2VzLiBUaGlzDQo+ID4gcHJlc2VudHMgYQ0KPiA+IHByb2JsZW0gZm9yIHVzZXJz
cGFjZSwgYXMgdG8gaG93IHVzZXJzcGFjZSBjYW4gcHJvdmlzaW9uIHRoaXMNCj4gPiBzcGVjaWFs
DQo+ID4gZGF0YSwgd2l0aG91dCBhbGxvd2luZyBmb3IgdGhlIHNoYWRvdyBzdGFjayB0byBiZSBn
ZW5lcmFsbHkNCj4gPiB3cml0YWJsZS4NCj4gPiANCj4gPiBQcmV2aW91c2x5LCBhIG5ldyBQUk9U
X1NIQURPV19TVEFDSyB3YXMgYXR0ZW1wdGVkLCB3aGljaCBjb3VsZCBiZQ0KPiA+IG1wcm90ZWN0
KCllZCBmcm9tIFJXIHBlcm1pc3Npb25zIGFmdGVyIHRoZSBkYXRhIHdhcyBwcm92aXNpb25lZC4N
Cj4gPiBUaGlzIHdhcw0KPiA+IGZvdW5kIHRvIG5vdCBiZSBzZWN1cmUgZW5vdWdoLCBhcyBvdGhl
ciB0aHJlYWQncyBjb3VsZCB3cml0ZSB0byB0aGUNCj4gPiBzaGFkb3cgc3RhY2sgZHVyaW5nIHRo
ZSB3cml0YWJsZSB3aW5kb3cuDQo+ID4gDQo+ID4gVGhlIGtlcm5lbCBjYW4gdXNlIGEgc3BlY2lh
bCBpbnN0cnVjdGlvbiwgV1JVU1MsIHRvIHdyaXRlIGRpcmVjdGx5DQo+ID4gdG8NCj4gPiB1c2Vy
c3BhY2Ugc2hhZG93IHN0YWNrcy4gU28gdGhlIHNvbHV0aW9uIGNhbiBiZSB0aGF0IG1lbW9yeSBj
YW4gYmUNCj4gPiBtYXBwZWQNCj4gPiBhcyBzaGFkb3cgc3RhY2sgcGVybWlzc2lvbnMgZnJvbSB0
aGUgYmVnaW5uaW5nIChuZXZlciBnZW5lcmFsbHkNCj4gPiB3cml0YWJsZQ0KPiA+IGluIHVzZXJz
cGFjZSksIGFuZCB0aGUga2VybmVsIGl0c2VsZiBjYW4gd3JpdGUgdGhlIHJlc3RvcmUgdG9rZW4u
DQo+ID4gDQo+ID4gRmlyc3QsIGEgbmV3IG1hZHZpc2UoKSBmbGFnIHdhcyBleHBsb3JlZCwgd2hp
Y2ggY291bGQgb3BlcmF0ZSBvbg0KPiA+IHRoZQ0KPiA+IFBST1RfU0hBRE9XX1NUQUNLIG1lbW9y
eS4gVGhpcyBoYWQgYSBjb3VwbGUgZG93bnNpZGVzOg0KPiA+IDEuIEV4dHJhIGNoZWNrcyB3ZXJl
IG5lZWRlZCBpbiBtcHJvdGVjdCgpIHRvIHByZXZlbnQgd3JpdGFibGUNCj4gPiBtZW1vcnkgZnJv
bQ0KPiA+ICAgIGV2ZXIgYmVjb21pbmcgUFJPVF9TSEFET1dfU1RBQ0suDQo+ID4gMi4gRXh0cmEg
Y2hlY2tzL3ZtYSBzdGF0ZSB3ZXJlIG5lZWRlZCBpbiB0aGUgbmV3IG1hZHZpc2UoKSB0bw0KPiA+
IHByZXZlbnQNCj4gPiAgICByZXN0b3JlIHRva2VucyBiZWluZyB3cml0dGVuIGludG8gdGhlIG1p
ZGRsZSBvZiBwcmUtdXNlZCBzaGFkb3cNCj4gPiBzdGFja3MuDQo+ID4gICAgSXQgaXMgaWRlYWwg
dG8gcHJldmVudCByZXN0b3JlIHRva2VucyBiZWluZyBhZGRlZCBhdCBhcmJpdHJhcnkNCj4gPiAg
ICBsb2NhdGlvbnMsIHNvIHRoZSBjaGVjayB3YXMgdG8gbWFrZSBzdXJlIHRoZSBzaGFkb3cgc3Rh
Y2sgaGFkDQo+ID4gbmV2ZXIgYmVlbg0KPiA+ICAgIHdyaXR0ZW4gdG8uDQo+ID4gMy4gSXQgc3Rv
b2Qgb3V0IGZyb20gdGhlIHJlc3Qgb2YgdGhlIG1hZHZpc2UgZmxhZ3MsIGFzIG1vcmUgb2YNCj4g
PiBkaXJlY3QNCj4gPiAgICBhY3Rpb24gdGhhbiBhIGhpbnQgYXQgZnV0dXJlIGRlc2lyZWQgYmVo
YXZpb3IuDQo+ID4gDQo+ID4gU28gcmF0aGVyIHRoYW4gcmVwdXJwb3NlIHR3byBleGlzdGluZyBz
eXNjYWxscyAobW1hcCwgbWFkdmlzZSkgdGhhdA0KPiA+IGRvbid0DQo+ID4gcXVpdGUgZml0LCBq
dXN0IGltcGxlbWVudCBhIG5ldyBtYXBfc2hhZG93X3N0YWNrIHN5c2NhbGwgdG8gYWxsb3cNCj4g
PiB1c2Vyc3BhY2UgdG8gbWFwIGFuZCBzZXR1cCBuZXcgc2hhZG93IHN0YWNrcyBpbiBvbmUgc3Rl
cC4gV2hpbGUNCj4gPiB1Y29udGV4dA0KPiA+IGlzIHRoZSBwcmltYXJ5IG1vdGl2YXRvciwgdXNl
cnNwYWNlIG1heSBoYXZlIG90aGVyIHVuZm9yZXNlZW4NCj4gPiByZWFzb25zIHRvDQo+ID4gc2V0
dXAgaXQncyBvd24gc2hhZG93IHN0YWNrcyB1c2luZyB0aGUgV1JTUyBpbnN0cnVjdGlvbi4gVG93
YXJkcw0KPiA+IHRoaXMNCj4gPiBwcm92aWRlIGEgZmxhZyBzbyB0aGF0IHN0YWNrcyBjYW4gYmUg
b3B0aW9uYWxseSBzZXR1cCBzZWN1cmVseSBmb3INCj4gPiB0aGUNCj4gPiBjb21tb24gY2FzZSBv
ZiB1Y29udGV4dCB3aXRob3V0IGVuYWJsaW5nIFdSU1MuIE9yIHBvdGVudGlhbGx5IGhhdmUNCj4g
PiB0aGUNCj4gPiBrZXJuZWwgc2V0IHVwIHRoZSBzaGFkb3cgc3RhY2sgaW4gc29tZSBuZXcgd2F5
Lg0KPiA+IA0KPiA+IFRoZSBmb2xsb3dpbmcgZXhhbXBsZSBkZW1vbnN0cmF0ZXMgaG93IHRvIGNy
ZWF0ZSBhIG5ldyBzaGFkb3cgc3RhY2sNCj4gPiB3aXRoDQo+ID4gbWFwX3NoYWRvd19zdGFjazoN
Cj4gPiB2b2lkICpzaHN0ayA9IG1hcF9zaGFkb3dfc3RhY2soYWRkciwgc3RhY2tfc2l6ZSwNCj4g
PiBTSEFET1dfU1RBQ0tfU0VUX1RPS0VOKTsNCj4gPiANCj4gPiBUZXN0ZWQtYnk6IFBlbmdmZWkg
WHUgPHBlbmdmZWkueHVAaW50ZWwuY29tPg0KPiA+IFRlc3RlZC1ieTogSm9obiBBbGxlbiA8am9o
bi5hbGxlbkBhbWQuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNr
LnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiANCj4gPiB2MzoNCj4gPiAgLSBD
aGFuZ2Ugc3lzY2FsbCBjb21tb24gLT4gNjQgKEtlZXMpDQo+ID4gIC0gVXNlIGJpdCBzaGlmdCBu
b3RhdGlvbiBpbnN0ZWFkIG9mIDB4MSBmb3IgdWFwaSBoZWFkZXIgKEtlZXMpDQo+ID4gIC0gQ2Fs
bCBkb19tbWFwKCkgd2l0aCBNQVBfRklYRURfTk9SRVBMQUNFIChLZWVzKQ0KPiA+ICAtIEJsb2Nr
IHVuc3VwcG9ydGVkIGZsYWdzIChLZWVzKQ0KPiA+ICAtIFJlcXVpcmUgc2l6ZSA+PSA4IHRvIHNl
dCB0b2tlbiAoS2VlcykNCj4gPiANCj4gPiB2MjoNCj4gPiAgLSBDaGFuZ2Ugc3lzY2FsbCB0byB0
YWtlIGFkZHJlc3MgbGlrZSBtbWFwKCkgZm9yIENSSVUncyB1c2FnZQ0KPiA+IA0KPiA+IHYxOg0K
PiA+ICAtIE5ldyBwYXRjaCAocmVwbGFjZXMgUFJPVF9TSEFET1dfU1RBQ0spLg0KPiA+IA0KPiA+
ICBhcmNoL3g4Ni9lbnRyeS9zeXNjYWxscy9zeXNjYWxsXzY0LnRibCB8ICAxICsNCj4gPiAgYXJj
aC94ODYvaW5jbHVkZS91YXBpL2FzbS9tbWFuLmggICAgICAgfCAgMyArKw0KPiA+ICBhcmNoL3g4
Ni9rZXJuZWwvc2hzdGsuYyAgICAgICAgICAgICAgICB8IDU2DQo+ID4gKysrKysrKysrKysrKysr
KysrKysrKy0tLS0NCj4gPiAgaW5jbHVkZS9saW51eC9zeXNjYWxscy5oICAgICAgICAgICAgICAg
fCAgMSArDQo+ID4gIGluY2x1ZGUvdWFwaS9hc20tZ2VuZXJpYy91bmlzdGQuaCAgICAgIHwgIDIg
Ky0NCj4gPiAga2VybmVsL3N5c19uaS5jICAgICAgICAgICAgICAgICAgICAgICAgfCAgMSArDQo+
ID4gIDYgZmlsZXMgY2hhbmdlZCwgNTUgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4g
PiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvZW50cnkvc3lzY2FsbHMvc3lzY2FsbF82NC50
YmwNCj4gPiBiL2FyY2gveDg2L2VudHJ5L3N5c2NhbGxzL3N5c2NhbGxfNjQudGJsDQo+ID4gaW5k
ZXggYzg0ZDEyNjA4Y2QyLi5mNjVjNjcxY2UzYjEgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYv
ZW50cnkvc3lzY2FsbHMvc3lzY2FsbF82NC50YmwNCj4gPiArKysgYi9hcmNoL3g4Ni9lbnRyeS9z
eXNjYWxscy9zeXNjYWxsXzY0LnRibA0KPiA+IEBAIC0zNzIsNiArMzcyLDcgQEANCj4gPiAgNDQ4
CWNvbW1vbglwcm9jZXNzX21yZWxlYXNlCXN5c19wcm9jZXNzX21yZWxlYXMNCj4gPiBlDQo+ID4g
IDQ0OQljb21tb24JZnV0ZXhfd2FpdHYJCXN5c19mdXRleF93YWl0dg0KPiA+ICA0NTAJY29tbW9u
CXNldF9tZW1wb2xpY3lfaG9tZV9ub2RlCXN5c19zZXRfbWVtcG9saWN5X2gNCj4gPiBvbWVfbm9k
ZQ0KPiA+ICs0NTEJNjQJbWFwX3NoYWRvd19zdGFjawlzeXNfbWFwX3NoYWRvd19zdGFjaw0KPiA+
ICANCj4gPiAgIw0KPiA+ICAjIER1ZSB0byBhIGhpc3RvcmljYWwgZGVzaWduIGVycm9yLCBjZXJ0
YWluIHN5c2NhbGxzIGFyZSBudW1iZXJlZA0KPiA+IGRpZmZlcmVudGx5DQo+ID4gZGlmZiAtLWdp
dCBhL2FyY2gveDg2L2luY2x1ZGUvdWFwaS9hc20vbW1hbi5oDQo+ID4gYi9hcmNoL3g4Ni9pbmNs
dWRlL3VhcGkvYXNtL21tYW4uaA0KPiA+IGluZGV4IDc3NWRiZDNhZmY3My4uMTVjNWExYzRmYzI5
IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvdWFwaS9hc20vbW1hbi5oDQo+ID4g
KysrIGIvYXJjaC94ODYvaW5jbHVkZS91YXBpL2FzbS9tbWFuLmgNCj4gPiBAQCAtMTIsNiArMTIs
OSBAQA0KPiA+ICAJCSgoa2V5KSAmIDB4OCA/IFZNX1BLRVlfQklUMyA6IDApKQ0KPiA+ICAjZW5k
aWYNCj4gPiAgDQo+ID4gKy8qIEZsYWdzIGZvciBtYXBfc2hhZG93X3N0YWNrKDIpICovDQo+ID4g
KyNkZWZpbmUgU0hBRE9XX1NUQUNLX1NFVF9UT0tFTgkoMVVMTCA8PCAwKQkvKiBTZXQgdXAgYSBy
ZXN0b3JlDQo+ID4gdG9rZW4gaW4gdGhlIHNoYWRvdyBzdGFjayAqLw0KPiA+ICsNCj4gPiAgI2lu
Y2x1ZGUgPGFzbS1nZW5lcmljL21tYW4uaD4NCj4gPiAgDQo+ID4gICNlbmRpZiAvKiBfQVNNX1g4
Nl9NTUFOX0ggKi8NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL3Noc3RrLmMgYi9h
cmNoL3g4Ni9rZXJuZWwvc2hzdGsuYw0KPiA+IGluZGV4IGU1MzIyNWE4ZDM5ZS4uOGYzMjljMjI3
MjhhIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9zaHN0ay5jDQo+ID4gKysrIGIv
YXJjaC94ODYva2VybmVsL3Noc3RrLmMNCj4gPiBAQCAtMTcsNiArMTcsNyBAQA0KPiA+ICAjaW5j
bHVkZSA8bGludXgvY29tcGF0Lmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9zaXplcy5oPg0KPiA+
ICAjaW5jbHVkZSA8bGludXgvdXNlci5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvc3lzY2FsbHMu
aD4NCj4gPiAgI2luY2x1ZGUgPGFzbS9tc3IuaD4NCj4gPiAgI2luY2x1ZGUgPGFzbS9mcHUveHN0
YXRlLmg+DQo+ID4gICNpbmNsdWRlIDxhc20vZnB1L3R5cGVzLmg+DQo+ID4gQEAgLTcxLDE5ICs3
MiwzMSBAQCBzdGF0aWMgaW50IGNyZWF0ZV9yc3Rvcl90b2tlbih1bnNpZ25lZCBsb25nDQo+ID4g
c3NwLCB1bnNpZ25lZCBsb25nICp0b2tlbl9hZGRyKQ0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0N
Cj4gPiAgDQo+ID4gLXN0YXRpYyB1bnNpZ25lZCBsb25nIGFsbG9jX3Noc3RrKHVuc2lnbmVkIGxv
bmcgc2l6ZSkNCj4gPiArc3RhdGljIHVuc2lnbmVkIGxvbmcgYWxsb2Nfc2hzdGsodW5zaWduZWQg
bG9uZyBhZGRyLCB1bnNpZ25lZCBsb25nDQo+ID4gc2l6ZSwNCj4gPiArCQkJCSB1bnNpZ25lZCBs
b25nIHRva2VuX29mZnNldCwgYm9vbA0KPiA+IHNldF9yZXNfdG9rKQ0KPiA+ICB7DQo+ID4gIAlp
bnQgZmxhZ3MgPSBNQVBfQU5PTllNT1VTIHwgTUFQX1BSSVZBVEU7DQo+ID4gIAlzdHJ1Y3QgbW1f
c3RydWN0ICptbSA9IGN1cnJlbnQtPm1tOw0KPiA+IC0JdW5zaWduZWQgbG9uZyBhZGRyLCB1bnVz
ZWQ7DQo+ID4gKwl1bnNpZ25lZCBsb25nIG1hcHBlZF9hZGRyLCB1bnVzZWQ7DQo+ID4gIA0KPiA+
IC0JbW1hcF93cml0ZV9sb2NrKG1tKTsNCj4gPiAtCWFkZHIgPSBkb19tbWFwKE5VTEwsIDAsIHNp
emUsIFBST1RfUkVBRCwgZmxhZ3MsDQo+ID4gLQkJICAgICAgIFZNX1NIQURPV19TVEFDSyB8IFZN
X1dSSVRFLCAwLCAmdW51c2VkLCBOVUxMKTsNCj4gPiArCWlmIChhZGRyKQ0KPiA+ICsJCWZsYWdz
IHw9IE1BUF9GSVhFRF9OT1JFUExBQ0U7DQo+ID4gIA0KPiA+ICsJbW1hcF93cml0ZV9sb2NrKG1t
KTsNCj4gPiArCW1hcHBlZF9hZGRyID0gZG9fbW1hcChOVUxMLCBhZGRyLCBzaXplLCBQUk9UX1JF
QUQsIGZsYWdzLA0KPiA+ICsJCQkgICAgICBWTV9TSEFET1dfU1RBQ0sgfCBWTV9XUklURSwgMCwg
JnVudXNlZCwNCj4gPiBOVUxMKTsNCj4gPiAgCW1tYXBfd3JpdGVfdW5sb2NrKG1tKTsNCj4gPiAg
DQo+ID4gLQlyZXR1cm4gYWRkcjsNCj4gPiArCWlmICghc2V0X3Jlc190b2sgfHwgSVNfRVJSX1ZB
TFVFKGFkZHIpKQ0KPiANCj4gU2hvdWxkIHRoaXMgYmUgSVNfRVJSX1ZBTFVFKG1hcHBlZF9hZGRy
KSAoaS5lLiB0aGUgcmVzdWx0IG9mIHRoZQ0KPiBkb19tbWFwKT8NCg0KT29wcywgeWVzLiBUaGFu
a3MgZm9yIHBvaW50aW5nIHRoYXQuDQoNCj4gDQo+ID4gKwkJZ290byBvdXQ7DQo+ID4gKw0KPiA+
ICsJaWYgKGNyZWF0ZV9yc3Rvcl90b2tlbihtYXBwZWRfYWRkciArIHRva2VuX29mZnNldCwgTlVM
TCkpIHsNCj4gPiArCQl2bV9tdW5tYXAobWFwcGVkX2FkZHIsIHNpemUpOw0KPiA+ICsJCXJldHVy
biAtRUlOVkFMOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArb3V0Og0KPiA+ICsJcmV0dXJuIG1hcHBl
ZF9hZGRyOw0KPiA+ICB9DQo+ID4gIA0KPiA+ICBzdGF0aWMgdW5zaWduZWQgbG9uZyBhZGp1c3Rf
c2hzdGtfc2l6ZSh1bnNpZ25lZCBsb25nIHNpemUpDQo+ID4gQEAgLTEzNCw3ICsxNDcsNyBAQCBz
dGF0aWMgaW50IHNoc3RrX3NldHVwKHZvaWQpDQo+ID4gIAkJcmV0dXJuIC1FT1BOT1RTVVBQOw0K
PiA+ICANCj4gPiAgCXNpemUgPSBhZGp1c3Rfc2hzdGtfc2l6ZSgwKTsNCj4gPiAtCWFkZHIgPSBh
bGxvY19zaHN0ayhzaXplKTsNCj4gPiArCWFkZHIgPSBhbGxvY19zaHN0aygwLCBzaXplLCAwLCBm
YWxzZSk7DQo+ID4gIAlpZiAoSVNfRVJSX1ZBTFVFKGFkZHIpKQ0KPiA+ICAJCXJldHVybiBQVFJf
RVJSKCh2b2lkICopYWRkcik7DQo+ID4gIA0KPiA+IEBAIC0xNzksNyArMTkyLDcgQEAgaW50IHNo
c3RrX2FsbG9jX3RocmVhZF9zdGFjayhzdHJ1Y3QgdGFza19zdHJ1Y3QNCj4gPiAqdHNrLCB1bnNp
Z25lZCBsb25nIGNsb25lX2ZsYWdzLA0KPiA+ICANCj4gPiAgDQo+ID4gIAlzaXplID0gYWRqdXN0
X3Noc3RrX3NpemUoc3RhY2tfc2l6ZSk7DQo+ID4gLQlhZGRyID0gYWxsb2Nfc2hzdGsoc2l6ZSk7
DQo+ID4gKwlhZGRyID0gYWxsb2Nfc2hzdGsoMCwgc2l6ZSwgMCwgZmFsc2UpOw0KPiA+ICAJaWYg
KElTX0VSUl9WQUxVRShhZGRyKSkNCj4gPiAgCQlyZXR1cm4gUFRSX0VSUigodm9pZCAqKWFkZHIp
Ow0KPiA+ICANCj4gPiBAQCAtMzczLDYgKzM4NiwzMyBAQCBzdGF0aWMgaW50IHNoc3RrX2Rpc2Fi
bGUodm9pZCkNCj4gPiAgCXJldHVybiAwOw0KPiA+ICB9DQo+ID4gIA0KPiA+ICtTWVNDQUxMX0RF
RklORTMobWFwX3NoYWRvd19zdGFjaywgdW5zaWduZWQgbG9uZywgYWRkciwgdW5zaWduZWQNCj4g
PiBsb25nLCBzaXplLCB1bnNpZ25lZCBpbnQsIGZsYWdzKQ0KPiA+ICt7DQo+ID4gKwlib29sIHNl
dF90b2sgPSBmbGFncyAmIFNIQURPV19TVEFDS19TRVRfVE9LRU47DQo+ID4gKwl1bnNpZ25lZCBs
b25nIGFsaWduZWRfc2l6ZTsNCj4gPiArDQo+ID4gKwlpZiAoIWNwdV9mZWF0dXJlX2VuYWJsZWQo
WDg2X0ZFQVRVUkVfVVNFUl9TSFNUSykpDQo+ID4gKwkJcmV0dXJuIC1FTk9TWVM7DQo+IA0KPiBV
c2luZyAtRU5PU1lTIG1lYW5zIHRoZXJlJ3Mgbm8gd2F5IHRvIHRlbGwgdGhlIGRpZmZlcmVuY2Ug
YmV0d2Vlbg0KPiAia2VybmVsIGRvZXNuJ3Qgc3VwcG9ydCBpdCIgYW5kICJDUFUgZG9lc24ndCBz
dXBwb3J0IGl0Ii4gU2hvdWxkDQo+IHRoaXMsDQo+IHBlcmhhcHMgcmV0dXJuIC1FTk9UU1VQPw0K
DQpIbW0sIHN1cmUuDQoNCj4gDQo+ID4gKw0KPiA+ICsJaWYgKGZsYWdzICYgflNIQURPV19TVEFD
S19TRVRfVE9LRU4pDQo+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gKw0KPiA+ICsJLyogSWYg
dGhlcmUgaXNuJ3Qgc3BhY2UgZm9yIGEgdG9rZW4gKi8NCj4gPiArCWlmIChzZXRfdG9rICYmIHNp
emUgPCA4KQ0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+ICsNCj4gPiArCS8qDQo+ID4gKwkg
KiBBbiBvdmVyZmxvdyB3b3VsZCByZXN1bHQgaW4gYXR0ZW1wdGluZyB0byB3cml0ZSB0aGUgcmVz
dG9yZQ0KPiA+IHRva2VuDQo+ID4gKwkgKiB0byB0aGUgd3JvbmcgbG9jYXRpb24uIE5vdCBjYXRh
c3Ryb3BoaWMsIGJ1dCBqdXN0IHJldHVybiB0aGUNCj4gPiByaWdodA0KPiA+ICsJICogZXJyb3Ig
Y29kZSBhbmQgYmxvY2sgaXQuDQo+ID4gKwkgKi8NCj4gPiArCWFsaWduZWRfc2l6ZSA9IFBBR0Vf
QUxJR04oc2l6ZSk7DQo+ID4gKwlpZiAoYWxpZ25lZF9zaXplIDwgc2l6ZSkNCj4gPiArCQlyZXR1
cm4gLUVPVkVSRkxPVzsNCj4gPiArDQo+ID4gKwlyZXR1cm4gYWxsb2Nfc2hzdGsoYWRkciwgYWxp
Z25lZF9zaXplLCBzaXplLCBzZXRfdG9rKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgbG9uZyBzaHN0
a19wcmN0bChzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRhc2ssIGludCBvcHRpb24sIHVuc2lnbmVkDQo+
ID4gbG9uZyBmZWF0dXJlcykNCj4gPiAgew0KPiA+ICAJaWYgKG9wdGlvbiA9PSBBUkNIX1NIU1RL
X0xPQ0spIHsNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zeXNjYWxscy5oIGIvaW5j
bHVkZS9saW51eC9zeXNjYWxscy5oDQo+ID4gaW5kZXggMzNhMGVlM2JjYjJlLi4zOTJkYzExZTM1
NTYgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9zeXNjYWxscy5oDQo+ID4gKysrIGIv
aW5jbHVkZS9saW51eC9zeXNjYWxscy5oDQo+ID4gQEAgLTEwNTgsNiArMTA1OCw3IEBAIGFzbWxp
bmthZ2UgbG9uZyBzeXNfbWVtZmRfc2VjcmV0KHVuc2lnbmVkIGludA0KPiA+IGZsYWdzKTsNCj4g
PiAgYXNtbGlua2FnZSBsb25nIHN5c19zZXRfbWVtcG9saWN5X2hvbWVfbm9kZSh1bnNpZ25lZCBs
b25nIHN0YXJ0LA0KPiA+IHVuc2lnbmVkIGxvbmcgbGVuLA0KPiA+ICAJCQkJCSAgICB1bnNpZ25l
ZCBsb25nIGhvbWVfbm9kZSwNCj4gPiAgCQkJCQkgICAgdW5zaWduZWQgbG9uZyBmbGFncyk7DQo+
ID4gK2FzbWxpbmthZ2UgbG9uZyBzeXNfbWFwX3NoYWRvd19zdGFjayh1bnNpZ25lZCBsb25nIGFk
ZHIsIHVuc2lnbmVkDQo+ID4gbG9uZyBzaXplLCB1bnNpZ25lZCBpbnQgZmxhZ3MpOw0KPiA+ICAN
Cj4gPiAgLyoNCj4gPiAgICogQXJjaGl0ZWN0dXJlLXNwZWNpZmljIHN5c3RlbSBjYWxscw0KPiA+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvYXNtLWdlbmVyaWMvdW5pc3RkLmggYi9pbmNsdWRl
L3VhcGkvYXNtLQ0KPiA+IGdlbmVyaWMvdW5pc3RkLmgNCj4gPiBpbmRleCA0NWZhMTgwY2M1NmEu
LmIxMjk0MGVjNTkyNiAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL3VhcGkvYXNtLWdlbmVyaWMv
dW5pc3RkLmgNCj4gPiArKysgYi9pbmNsdWRlL3VhcGkvYXNtLWdlbmVyaWMvdW5pc3RkLmgNCj4g
PiBAQCAtODg3LDcgKzg4Nyw3IEBAIF9fU1lTQ0FMTChfX05SX2Z1dGV4X3dhaXR2LCBzeXNfZnV0
ZXhfd2FpdHYpDQo+ID4gIF9fU1lTQ0FMTChfX05SX3NldF9tZW1wb2xpY3lfaG9tZV9ub2RlLA0K
PiA+IHN5c19zZXRfbWVtcG9saWN5X2hvbWVfbm9kZSkNCj4gPiAgDQo+ID4gICN1bmRlZiBfX05S
X3N5c2NhbGxzDQo+ID4gLSNkZWZpbmUgX19OUl9zeXNjYWxscyA0NTENCj4gPiArI2RlZmluZSBf
X05SX3N5c2NhbGxzIDQ1Mg0KPiA+ICANCj4gPiAgLyoNCj4gPiAgICogMzIgYml0IHN5c3RlbXMg
dHJhZGl0aW9uYWxseSB1c2VkIGRpZmZlcmVudA0KPiA+IGRpZmYgLS1naXQgYS9rZXJuZWwvc3lz
X25pLmMgYi9rZXJuZWwvc3lzX25pLmMNCj4gPiBpbmRleCA4NjBiMmRjZjNhYzQuLmNiOWFlYmQz
NDY0NiAxMDA2NDQNCj4gPiAtLS0gYS9rZXJuZWwvc3lzX25pLmMNCj4gPiArKysgYi9rZXJuZWwv
c3lzX25pLmMNCj4gPiBAQCAtMzgxLDYgKzM4MSw3IEBAIENPTkRfU1lTQ0FMTCh2bTg2b2xkKTsN
Cj4gPiAgQ09ORF9TWVNDQUxMKG1vZGlmeV9sZHQpOw0KPiA+ICBDT05EX1NZU0NBTEwodm04Nik7
DQo+ID4gIENPTkRfU1lTQ0FMTChrZXhlY19maWxlX2xvYWQpOw0KPiA+ICtDT05EX1NZU0NBTEwo
bWFwX3NoYWRvd19zdGFjayk7DQo+ID4gIA0KPiA+ICAvKiBzMzkwICovDQo+ID4gIENPTkRfU1lT
Q0FMTChzMzkwX3BjaV9tbWlvX3JlYWQpOw0KPiA+IC0tIA0KPiA+IDIuMTcuMQ0KPiA+IA0KPiAN
Cj4gT3RoZXJ3aXNlLCBsb29rcyBnb29kIQ0KPiANCg0KVGhhbmtzIGZvciB0aGlzIGFuZCB0aGUg
cmV2aWV3ZWQtYnlzIG9uIG90aGVyIHBhdGNoZXMhDQo=
