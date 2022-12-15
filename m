Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7269F64D499
	for <lists+linux-arch@lfdr.de>; Thu, 15 Dec 2022 01:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiLOAZP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Dec 2022 19:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLOAZO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Dec 2022 19:25:14 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E97E22;
        Wed, 14 Dec 2022 16:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671063913; x=1702599913;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VggfaM4qZzmRlyUkKquP+avIsKzyNcxvRb/Z8onInec=;
  b=SVwxfGooPHm9kkgxAgkfnrdqUISLEUWVpxojIRofRNO0Vf9V5V2Z2wH7
   it1ySpRgK9jK486cpTxqbUVwiVfJR9LfgpBSoyRo9ujsBDabUv1MGkHUx
   n8UiE3DkjhAvjBJ9CxlTu0rEfH87zJ6yEZsy4kwOGg2hvC59jLs6mdkRX
   AjrY9XGKNZTXitXWEP4f2qz1tyCeqrpbvjWNt/5TKwir7WUVMm91lWx6N
   cK/uLR3On3Dpo9UdhUj3hzLsKpbxryIlFCYttGkPNE/CZ3flZY2w2XGoH
   gp9w5tdUUxml6NJ/rry45d3Pq2365OyhyYYDZNRxVYo1s2jBPZtPK+xuF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="317260149"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="317260149"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 16:25:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="791436885"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="791436885"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 14 Dec 2022 16:25:12 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 14 Dec 2022 16:25:11 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 14 Dec 2022 16:25:11 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 14 Dec 2022 16:25:11 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 14 Dec 2022 16:25:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JkBKduYzoEH+Iax1zhBzcsYzhs9Fx7+XF5u2M75xYPaDtEeAgEv56k8QvLHU1JSXxvOUC28qAhX/mksuveZwNDa6hr3rYWVPA6t9wje3KlzZ/CdYAWFwl5QWihpJeNS+VRBLc0xlYGT1PAHZ9YM6lUL8LoLBOrnfFuCAENnrcZJa2qL7YaDzsONNS2daa0BUoCXhoKQDIgQxK5fTiEVf1mShABf2wLp9+JlWRxLh37r6TyyBWeUPpzeWM1XgUqWnElP/O7a4Z7QKZVF7ICZYWJ8a+EpnI8prIq6M6DT0PTMCAAPXyd+lIAzcsnhW1UpmMG8Ov9BL+PVAqpqSNcWBBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VggfaM4qZzmRlyUkKquP+avIsKzyNcxvRb/Z8onInec=;
 b=WfgYaDsJkv29dDIzQzXR0awYtM9v4buK9GRbSMHwDo33l4Pz8VESjg5IoV5QWrRWhVWlAqSZefzsz4CphvQCCWnUQ8ACcFQ2KjjQkCzZHiFNKdFt2GmN0DDI/9fFHvcR0HMqyCJBPkQbCqhbXw8ouSDLkRBLmu8jD3SelLlnINGj+rFyLMS+P0Ov75Vf+I9WArecDJmmm7AE4nZZ0KZ6vJMmBu3FuR9QqQBjIGSH3ln4NXPEHmvKpog/SUTYbdykorJ07z7PjvAoLKC4GUGYqakWiXQBbHUc9ZNEO3S7MZr1GDIwHPuMEZBu19x1jLbg6YeIIi5ZivPLydUBHS6LEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BL1PR11MB5317.namprd11.prod.outlook.com (2603:10b6:208:309::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Thu, 15 Dec
 2022 00:25:08 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff%5]) with mapi id 15.20.5880.019; Thu, 15 Dec 2022
 00:25:08 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Lutomirski, Andy" <luto@kernel.org>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
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
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 33/39] x86: Prevent 32 bit operations for 64 bit shstk
 tasks
Thread-Topic: [PATCH v4 33/39] x86: Prevent 32 bit operations for 64 bit shstk
 tasks
Thread-Index: AQHZBq94wdsyJh8FaUWxWY22Hx/U6K5cxacAgAFxTYCAD/MLgA==
Date:   Thu, 15 Dec 2022 00:25:08 +0000
Message-ID: <17e3d37afeab3821e8df3329603660c8f35e1ad1.camel@intel.com>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
         <20221203003606.6838-34-rick.p.edgecombe@intel.com>
         <CALCETrVMY4UadSrn3fTim5iCzPVf+XXnkyq57wjvnhVUNV1V5w@mail.gmail.com>
         <20af3021fa4e9f1d9a322678b7ce1737d1931fee.camel@intel.com>
In-Reply-To: <20af3021fa4e9f1d9a322678b7ce1737d1931fee.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|BL1PR11MB5317:EE_
x-ms-office365-filtering-correlation-id: 4c97b33f-2115-430c-c204-08dade32d248
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0fWlP0mbqu+hSxyd0tXltS2VOJNLoO/DyzQ0ufxSVU57181fFfHiJ9pCBlF5RPn8N9t/wPfd2ZaP+NL3MucpmNcY2sxR2ovzrhEsEV70cJS8CrZ8qogHpHXUlrvlv2ygIBstxQOh74OgcdiPc+QoFxz15oguuad8IWLqJi/ICLe1l7lTxYNtqqN8REAqkVzBxrveSaysxFQWwZ3cB15Mbky11Fzy0PsaIkYTBMqgUca77oNj7qcFu5OGwZ+uN19f2dGGTIWGC2H8T/BXATIBYkMbvDhV44n8v6x6sNu1pOSsLhJsb3iQxfffyKFI7Ss21rZdfe7Y5XNXXmE1+S0mDSCZXl40iX3G4eLGGI1MctM+9v5Luoa8qe28VrIYjCrloS4JdS3bunlRLwG6VsWAV0fwupP0kNC1/kLqptjskLeZhf/tZgVqpBH9gW/ne1GbLXVR9wgXV1FnCe1LUms6YMCm4eAWXoSHER13vxU2QplHhug6fdttWh/8GHlgvSBGEwL7gt3QTJ/M7dBc2hjpW4c2dYBXHZKA5O+d+nplvGPMzu0+rigcJ30pVz4XT+Cy9LGtGGzbKm3jxNI0OqjC1UYC/9xtYNA62eBl07rgWmGaHkoLzPtYhUveFD5GtBYxZ528z07CfqFbjkZVD8UOPm5cw516tHWh/WnTNzqipdzgJ5PDmJkiqMw3vctT3lNSFheX8jS6A53MhDUaOOqH239yVObk81F8kk82QlZNkm4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199015)(76116006)(66446008)(7416002)(36756003)(8676002)(2616005)(4326008)(66946007)(64756008)(66476007)(91956017)(5660300002)(7406005)(316002)(83380400001)(54906003)(2906002)(8936002)(86362001)(38100700002)(122000001)(82960400001)(41300700001)(6916009)(66556008)(6486002)(26005)(71200400001)(478600001)(38070700005)(6512007)(186003)(53546011)(6506007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkcrVHhjRGZUWjZYYWR3WkRHbkxwQUg0dWpuakF4dy82UExQQ2wzTmVZVGg5?=
 =?utf-8?B?a0JjTnFrZGp2UXJBdFNuT1BtNHdUVzdFaDVvWTBPVmNaUVlKQjlVV0dtRWxQ?=
 =?utf-8?B?OTZuWXlLVFNXK0JGQS9xSVp4bXAzNmFxRFRvMUFLQ1RwTGxpOHVmN1AxVXda?=
 =?utf-8?B?RXliaWFWMUxBQ3VmWnJzaHpNQ29CdXIrRzNXL3l6S2h3U3RBQzZWK2svbmxk?=
 =?utf-8?B?cjAzS3p2RnNVQnR3dlRWM1ZiQVI1QjZENTZJNnRROWZodW5ZTGtnMDZPYkNZ?=
 =?utf-8?B?eEtYTmh3N0ZxREU5c0hCeXZaN2lmK3NXaEovOGxiK3VpUHlNclJDL3BrZnRq?=
 =?utf-8?B?R3pOVDhEUk5ibzU5WFFVWG10UWpHNVVDQm83M253ZTZiQU40c3BYSlBZVnZj?=
 =?utf-8?B?dHY1RzVEalJpaEJtbk5uRFRFalpTZkxIdWNrQnlxaXplZFFOb2Juc29Uek9m?=
 =?utf-8?B?VkQvWXdoYUsrWGY2QzBjSEhweGR1NnRFNFE5NXM0eGQvaEc3SkpLWnp3ZGlG?=
 =?utf-8?B?YmhoMTZxSFVMKzdOcUpaZnAwYmtsN0doUFFHYmpKTVFnTE5aWG1hZmE4Nnpl?=
 =?utf-8?B?a1B6dVdTTGF3Z2hVbGtSdk1IOUEzTCtnczd1eEl1a0pqeGJ0ZllkN3V0SVQ0?=
 =?utf-8?B?cytVQkhPSWgwaUlLcHFXdXRqTU5JQzBVMFg4M0NEMTdDNElucTdzV0hoc0hN?=
 =?utf-8?B?YkpRM2t0U0RxejdXNkI3UVJVYXd4dnE0OGZrckpNVCtzQWh4ek1YRGtGamZz?=
 =?utf-8?B?MjJ3Tnc4LzE0dEZlZThzUkhJOWoxZ1FRZmlpWk5KNGtRVTFhNzRzSHQyaS9j?=
 =?utf-8?B?RlFxNDJVVnRxTXAwaXExZWxtMW44a3lKVVdCVEZvMHZaeGlQNExmRE1JQVZ2?=
 =?utf-8?B?RFo2Vy93cldWTTdCQVd0eFdETk1iZ1hjV2pDSmJ4Sy9DaEordGwxdVZoWUhG?=
 =?utf-8?B?anRDWWtRYlJqcWtyMkViSHJyNWVyS3Z1NGZJcGhKMXZUOHRnSHVhR0lBNzIy?=
 =?utf-8?B?aDhTRUpwdVlkT2tzdXphS2RKVW5rVFczNXhNTkpuNDY5VFpsQzA2d3pxWC9l?=
 =?utf-8?B?OVE0VXdjU2cvMjVWKzZwT2hjVTJMc2dJdlB1bEZmd2hjQTlHbnFuczljUVJi?=
 =?utf-8?B?NjF5VDdXWTZFdjNhOTlUNEF6M2N5bTVDamlGbjNUcWZtNlN0RUdyWjN2aDNS?=
 =?utf-8?B?VDZvMUU3aXZUQUN1dmlvVGhOcHVPSFRYek9RTzFPUmlCNVlUaGYzTjE3NzZt?=
 =?utf-8?B?QmlWUis5QUV0M1Y3UDdTaFE3T203dGZRTTNkblJFY0VPQjRIRTN2MWljQlRp?=
 =?utf-8?B?OFFYaHMzNm1uaGVWd1FMc3hTY0FQQlpQcmo2UTZuNG5MUzlhRUtLTW41cHpn?=
 =?utf-8?B?T3lRNFlMNXM4c2tPaXdoOUlpbWJYU3NSU2ZlNXJUcUF0ZmpVOUg2K3o5YjFR?=
 =?utf-8?B?a3Q0K29RODErYm5IQ2tNREFPTmVOR3VxUWdxa1BIWDMweS8yUWl1cGhoVjFy?=
 =?utf-8?B?dHpGL0RzM056cUJ1eEd1am8wTndMdlFwRThIZGY4M2pyaWQ1bC9pSGxPZHVJ?=
 =?utf-8?B?cVpRWG9DdXlHaWVTcGZZVmlYM0pseDVYNVJXWjRBZndTa3NiQWJlZzc0VnFN?=
 =?utf-8?B?eWlLdHRvYUs0VE1TeWFHSFVqSTEveUJ0aFRoWkdSaGtrWGZjelFsb2JIdWQ2?=
 =?utf-8?B?Wkw2T3Q3dHlLZ2Z4OWRzWk5mWlpWeHAzY0VDekpFVUJWK2ZtMld4L2xCU25D?=
 =?utf-8?B?VXUvY1V5VS9FdzlwOVlJVCtmT1VQNHd2TEFMRGYzTUp5OEFlNlYzbktXS1pX?=
 =?utf-8?B?LzcxUXhSc3Rqd3oyQS9GTVgyWURyWXppS3AyMTlXMzdsSnJhZ05lQ0dsTWRN?=
 =?utf-8?B?NDN3R0FQWDlJWjNZcE03UU1PMWFrSDBtNGwvRk92VCs2UmpUWEkwai93eEVo?=
 =?utf-8?B?aFZISmorQlh4UkZsRHdEdmF2aisxWVhLNm5wQm15Mko5cVNMWFlXQUhPUGUy?=
 =?utf-8?B?SHlrazgrYk90akNvQ1F5OTBjdHNDeEZkVjFhNzE4UkNhaGQ2MVR5NDJIQXow?=
 =?utf-8?B?OXFkSUNaMGloaEJhUEVzd1ovbENBZWF4S2pqb0N4K2VqZ2RUQmIxb2xPWnow?=
 =?utf-8?B?UVZ6TTc5bmZTYkt2b3J5T3FicVJEdTV0aXo2OW9vWnFwbzFCc0VERjQxa1cx?=
 =?utf-8?Q?pninfrfATB6Zwq1fx4B2qAU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D7C2505FF6247479FED497BB62A2251@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c97b33f-2115-430c-c204-08dade32d248
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2022 00:25:08.3592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1pBmQq0WwYZdBhjoclYeu9hJyG50uNWAeJOGyEd6zU/V114FALOEm/CeLBKZWqtVTWvaB1Q30wo5xazVOxxNN0jhqGKMcN2uz5cWdxYfUp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5317
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gU3VuLCAyMDIyLTEyLTA0IGF0IDEyOjUxIC0wODAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gT24gU2F0LCAyMDIyLTEyLTAzIGF0IDE0OjQ5IC0wODAwLCBBbmR5IEx1dG9taXJza2kgd3Jv
dGU6DQo+ID4gT24gRnJpLCBEZWMgMiwgMjAyMiBhdCA0OjQ0IFBNIFJpY2sgRWRnZWNvbWJlDQo+
ID4gPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPiB3cm90ZToNCj4gPiA+IA0KPiA+ID4gU28g
c2luY2UgMzIgYml0IGlzIG5vdCBlYXN5IHRvIHN1cHBvcnQsIGFuZCB0aGVyZSBhcmUgbGlrZWx5
IG5vdA0KPiA+ID4gbWFueQ0KPiA+ID4gdXNlcnMuIE1vcmUgY2xlYW5seSBkb24ndCBzdXBwb3J0
IDMyIGJpdCBzaWduYWxzIGluIGEgNjQgYml0DQo+ID4gPiBhZGRyZXNzDQo+ID4gPiBzcGFjZSBi
eSBub3QgYWxsb3dpbmcgMzIgYml0IEFCSSBzaWduYWwgaGFuZGxlcnMgd2hlbiBzaGFkb3cNCj4g
PiA+IHN0YWNrDQo+ID4gPiBpcw0KPiA+ID4gZW5hYmxlZC4gRG8gdGhpcyBieSBjbGVhcmluZyBh
bnkgMzIgYml0IEFCSSBzaWduYWwgaGFuZGxlcnMgd2hlbg0KPiA+ID4gc2hhZG93DQo+ID4gPiBz
dGFjayBpcyBlbmFibGVkLCBhbmQgZGlzYWxsb3cgYW55IGZ1cnRoZXIgMzIgYml0IEFCSSBzaWdu
YWwNCj4gPiA+IGhhbmRsZXJzLg0KPiA+ID4gQWxzbywgcmV0dXJuIGFuIGVycm9yIGNvZGUgZm9y
IHRoZSBjbG9uZSBvcGVyYXRpb25zIHdoZW4gaW4gYSAzMg0KPiA+ID4gYml0DQo+ID4gPiBzeXNj
YWxsLg0KPiA+ID4gDQo+ID4gDQo+ID4gVGhpcyBzZWVtcyB1bmZvcnR1bmF0ZS4gIFRoZSByZXN1
bHQgd2lsbCBiZSBhIGhpZ2hseQ0KPiA+IGluY29tcHJlaGVuc2libGUNCj4gPiBjcmFzaC4gIE1h
eWJlIGluc3RlYWQgZGVueSBlbmFibGluZyBzaGFkb3cgc3RhY2sgaW4gdGhlIGZpcnN0DQo+ID4g
cGxhY2U/DQo+ID4gT3IgYXQgbGVhc3QgcHJfd2Fybl9vbmNlIGlmIGFueXRoaW5nIGdldHMgZmx1
c2hlZC4NCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24hIERlbnlpbmcgc2VlbXMgbXVj
aCBiZXR0ZXIsIEknbGwgY2hhbmdlIGl0Lg0KDQpBcmdoLCB0aGUgc29sdXRpb24gb25seSB3b3Jr
IGluIHRoZSBub3JtYWwgY2FzZSB3aGVyZSB0aGUgZmlyc3QgdGFzaw0KZW5hYmxlcyBzaGFkb3cg
c3RhY2suIE90aGVyd2lzZSB0aGUgcHJvY2VzcyBjb3VsZDoNCjEuIEhhdmUgdHdvIHRocmVhZHMg
d2l0aG91dCBzaGFkb3cgc3RhY2sNCjIuIEVuYWJsZSBzaGFkb3cgc3RhY2sgaW4gdGhyZWFkIDEN
CjMuIFJlZ2lzdGVyIDMyIGJpdCBoYW5kbGVyIGZyb20gdGhyZWFkIDINCjQuIEhhbmRsZSAzMiBi
aXQgc2lnbmFsIGluIHRocmVhZCAxDQoNCkZvciB0aGlzIGFtb3VudCBvZiBzcGVjaWFsIGNhc2Ug
dWdsaW5lc3MgaXQgc2hvdWxkIGZpeCB0aGUgd2hvbGUNCnByb2JsZW0gSSB0aGluay4NCg0KVHJ5
aW5nIHRvIGZpeCBpdCB1cCBieSBhZGRpbmcgMzIgYml0IHNpZ25hbCBibG9ja2luZyBzdGF0ZSBp
bnRvIHN0cnVjdA0Kc2lnaGFuZF9zdHJ1Y3QsIHNvIGl0IHdvdWxkIGFjdHVhbGx5IGJlIHBlci1w
cm9jZXNzLCBzcGlsbHMgdGhpcyBpbnRvDQpjb3JlIGNvZGUuIEkgdGhpbmsgaXQgbWlnaHQgbm90
IGJlIHRoZSBiZXN0IHNvbHV0aW9uLiBJJ20gbm90IHN1cmUgd2hhdA0KaXMgeWV0Lg0K
