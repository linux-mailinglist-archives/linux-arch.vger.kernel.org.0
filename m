Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DD073AD19
	for <lists+linux-arch@lfdr.de>; Fri, 23 Jun 2023 01:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjFVXT7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jun 2023 19:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjFVXTm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2023 19:19:42 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC301FC6;
        Thu, 22 Jun 2023 16:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687475948; x=1719011948;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LVp/PGPDwXqjYDy7Zz7ZBu4brIclCSMkpeEyunKrpVc=;
  b=gjMyMa2L8EW03ZMjHgcr4Xw0jDgFixeWkp1s1rs03xaK/FrztTqMrGRM
   VNZo/7XwhETzE9AdKjb3UkduPimWpMoCiu77EoqDN0Gghtbq5ypZuYmlr
   F2vj4on+gzQ60W0VyNx/sOIk0iYoeuRM4vrauvUAQehgymiFQmE1k+Hxv
   HDfg0pnYk7+jZ/inRL5RRK7Qynh8T4B8J0Dr0hjBBDPZwALdc8XEHYEbW
   R1Pda8WZlZBo9obNB0lKxTlhjN8po9tYZZs1rwqZZqXQrzIhQV4F4t5ZH
   eZ+GVscM/KBqVt9OyLZzcLerb1Okmo82HzW8qQVraVRNQytTxmGt+WAlB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="340238640"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="340238640"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 16:18:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="715117758"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="715117758"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 22 Jun 2023 16:18:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 16:18:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 16:18:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 16:18:29 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 16:18:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaUAU8qs4SdoIPXB+Oh1Edzw53MXtz0KwHljO7Gll9bEHKaa5IrYMMUgMStxKRyy7lr4YNFd8rQusrBK5KrkmDbDb94waUyaDq93tB+GVI/G8aTGyRr3GcMvX7QvlSrALWf0/Rn7X0tyFHwDoE+9vbPGqdpEReVvIj6uuMckQGqlRjX3/XivIWLNnPFTQCMI0xJ/vMz++jjaZXw2w3mJnjFxRklZDqaqC3O8UmuKGJSMVCp65QfeSB0cJbF66X70Kbur32wQjkQ7r9YZpS5y3Xerna2wpB7SN1s4LK9pfvtmUNfqJIH4miSj+8xblTeAtdry4N2QbagW5zwi4gSHlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVp/PGPDwXqjYDy7Zz7ZBu4brIclCSMkpeEyunKrpVc=;
 b=KPiU6LUVEnoVgeAhUy1ZKyyiChrJNH0Lfgp8aCK1BX4G2s4hJ4BBaQZ6/u/BvPt3SbyjxxseBqIeg9FmD1DPBco32MI+IxgxD7muOF52nAl/IsCm+6m9DmMVPcEaCvMpN2aHvHqu1oFCCwrvmxxD2jPV0g8Pi0e0nntxa9VXzl2KLYTqxAcIb73eYpUn1/zSfj3MI8V/QpTuushwTSpjQcJzxG9gNuyyd1VY33DD5xfGgGZqHujcnItfKcaqS4Ke7YimYXlByr8mu8wIZe8CCcHKEgJ/gvLUwRkPIxE9qmKE5Fnbn8w63WtMKORW8AzAtX81hiHavS9ztNRnkmVsUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MW5PR11MB5762.namprd11.prod.outlook.com (2603:10b6:303:196::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 23:18:27 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec%7]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 23:18:27 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "Lutomirski, Andy" <luto@kernel.org>
CC:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "jannh@google.com" <jannh@google.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Thread-Topic: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Thread-Index: AQHZnYvD++9jHqJtDEOZ5j0eN4/f+6+IoOQAgAALyMOAACwFgIAAIG6AgAAMtoCAACGsAIAA96CAgABofQCAB1K5gIAAhUGAgAEVRoCAAKx+AIABDK+AgAB6bICAAPF/AIAAZrmAgAAVNICAAG62AA==
Date:   Thu, 22 Jun 2023 23:18:27 +0000
Message-ID: <1cd67ae45fc379fd82d2745190e4caf74e67499e.camel@intel.com>
References: <ZImZ6eUxf5DdLYpe@arm.com>
         <64837d2af3ae39bafd025b3141a04f04f4323205.camel@intel.com>
         <ZJAWMSLfSaHOD1+X@arm.com>
         <5794e4024a01e9c25f0951a7386cac69310dbd0f.camel@intel.com>
         <ZJFukYxRbU1MZlQn@arm.com>
         <e676c4878c51ab4b6018c9426b5edacdb95f2168.camel@intel.com>
         <ZJLgp29mM3BLb3xa@arm.com>
         <c5ae83588a7e107beaf858ab04961e70d16fe32c.camel@intel.com>
         <ZJQR7slVHvjeCQG8@arm.com>
         <CALCETrW+30_a2QQE-yw9djVFPxSxm7-c2FZFwZ50dOEmnmkeDA@mail.gmail.com>
         <ZJR545en+dYx399c@arm.com>
In-Reply-To: <ZJR545en+dYx399c@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MW5PR11MB5762:EE_
x-ms-office365-filtering-correlation-id: ec78a810-d51a-4d00-68d3-08db7376fc05
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gnZB3BkyIUBSfBNY5KLcyGDayXEm69PgiMioyXdxn7nxnNPbA56WwTOKPxB1Lxj5f/u7B0Znk4vU6TyIYtjG1PLXQiVfwc9jUWArehN/O+rjYRYxsBmUZMCqBFpFhnqIx+F4jhz5Jd0XL5JJcwHRc7L9l+J3LidokxuRuRjMUKKaNjVheZJiLMCfM603hz2D5djCxeDHLZbamudKizcA3seWrzhkSqHuJQ9OD1pZ0lFKC6wmRFNY3QTXqa13iIQ7piWX4IJtUgOU2kMyHdYry0XxdvhDF/K+e0qB6Iq+NCX61RW/zVbCHg77E46ojgRP2VxzzyNoQUVkAIUtYlPnziAbNs9zMg2o5iigiRCOJ1sGuj4BrKkPxG2Io77s/mkg8kRwJoW2Dx/NKn3ZqIiO161eg5uv4KqWY4U9/ecmcl8JWiUIb6Q/ZhSwwK3BfVFvSSW+BrQ4jszE9z/WaC7qATokxahwF9l8Glq3RgTDlzjNQ2sxFjTOY5dTu448Yh8tCPwUrXYDCdWzjmwolM2YTZZflVAnXZQsNNsSqePt70yr2Iv0QGU3offKhisnU7K9fFOYsVEb/k88PBV0o3VvOmuSeeAkFLukPOYuVnfoMNR7yT6XR51dY3WsBK8fs8+W
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(396003)(366004)(136003)(39860400002)(451199021)(6486002)(71200400001)(478600001)(110136005)(54906003)(76116006)(91956017)(83380400001)(2616005)(36756003)(86362001)(38070700005)(4744005)(2906002)(66946007)(6512007)(6506007)(26005)(38100700002)(82960400001)(122000001)(41300700001)(186003)(316002)(66446008)(7416002)(7406005)(66556008)(66476007)(8936002)(8676002)(64756008)(4326008)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVF3aVdqS2lvME8xTXZCd2d2RWdmY1hOUEpxQ0NRNFY2ZGtMSmRXNEdNbHEw?=
 =?utf-8?B?L2p5bUd2ZE9WSURxTWNjaWM3b0JqTHExTzdmR01VYWpNenI2OHRiN0YweFZW?=
 =?utf-8?B?Q0VadnF0cXowRmhQaHE3KytFcHFncVFnK1hTUjgwZXdmaWhIVUszUWNQYkQ5?=
 =?utf-8?B?Smx1NkdTU2ZpczJjZXpkSUxrQURFTDlOb2ZHbURONDZMVGZvQzIrNy9JNkZK?=
 =?utf-8?B?YTMvTTg0NUg5aDlnVXlsM3NOem5YVXBJNTNvVmM4aUF1RjdmVnc5OTZvUXJB?=
 =?utf-8?B?RDlwVzhPKzduWUhSNGhVUmtzR3haZ0ZyZDZWRFNocTlWcXhEZnVrU1o4WTg2?=
 =?utf-8?B?OTl4U2ZJT0t1R0lvZlUzbEM1ekJMcmQwL3lkSU1qbDVleWtMU01mZ1U1aXdG?=
 =?utf-8?B?V2pPeFp1cEVWKzV0YjdTeGZOdHEwdDBRYVFkajdldkhrMXcrL0dPVlZJTjdp?=
 =?utf-8?B?c3NuTHBBS3E4ZGRxWFpLaXArMkNEWDd5Mk9aaFNlTTZ0ckFWQTVjMVdEU1Nx?=
 =?utf-8?B?b2NJTGI5TENKeXlCSmxWUXN6OStHSWh6N1prbzNkK3Zmd3ZudW85SnNSVXFq?=
 =?utf-8?B?YWNZT203MEs2Q05seWx4Z3BwTnJ0REl4eXpqWHE4MnNnNlFlRkc4a1ZFQ1NX?=
 =?utf-8?B?RjdtY1NEZHlFR0p2WnR3dUxPSWJJQVVjYWQycDBXSUllVjBXV2N6ZEZ4dnVQ?=
 =?utf-8?B?TjNidTZkcXI5MVEvRnBFWUtDU1IyaTB2ZW96TGNPTVBkbVFIQjh5WElWQ0dP?=
 =?utf-8?B?aFQrZEYwWmNTelVsRUFSbE1pU25lTHFWRUErSGFsRjE4MXd2WnVrY2V6RTZn?=
 =?utf-8?B?K1dQVE0wYUJyN2pLS2MzbmxIaDE5cys3NVlZcjRheU5UWURHeFMzRm8xWTN2?=
 =?utf-8?B?Q1dXOW9sUW5EQjJhN3FpLzJ6UGpKYlFLS0lWSGJzUkRtUHh3cVgzOUJpSjJZ?=
 =?utf-8?B?emtZT05JM3k4TjZGOVhoRGZmeEJuNGJRS3VWN3o3cHZJdWR6S1hvUllhM3Bt?=
 =?utf-8?B?MUw1N0JmS3VTUFJDRDA1V01QSTNrMnFjQW9lK0NKbGJFYndaYzlmMjVDOUJx?=
 =?utf-8?B?K2xSYlgyNTluMCtvbEJBY0Fjdk5INHZQOCtJZXMxQTVMVkpxZnRLdEE1L0dk?=
 =?utf-8?B?cW5pQkhOOHlTM3FmbmpGNzlFNkJrQ2xwLzJQR204OVkzOVpOMGRGMHRjWlg0?=
 =?utf-8?B?UTdmZTh4c1VpSzU2RXBIUHFLZHlqZTJndHQxWlBZNGp3K3pkNnJHeHBmQUJy?=
 =?utf-8?B?UGQ2QzY0U0pWL3E5SndFczlzUnhScklreW02YmVEcUVobW8wTzNYZnhYOE9q?=
 =?utf-8?B?UkF3ZXlQckFsZTZuU3FQdk03NDc0L3JBY3lmSlg3TityRXpQVm80R2pqeUNk?=
 =?utf-8?B?dHd2TWJnMUtJOGxXK1ZtSEE3ZXRqVGR1SUFNWFBOWGl6cFQ1TDRlNEJDTjZL?=
 =?utf-8?B?UGFvbit0cWtQV2w3aFc0VXl5akFna1BleVY4WElQT3k5bFFURWJVdlV1aXJG?=
 =?utf-8?B?Qkd2c2JmQlYvTjhIWWQvUSswQU81Sm0rREx1QXA2bEdhWHFoL1dIL3VwYytB?=
 =?utf-8?B?WWg1TzNxbmt3aW9QOVpnWml4MTJ4OFJBN0lTdk44V3ErRVZqeTB2MFF2Tnhz?=
 =?utf-8?B?SmVMU1NvbW1yWWs1MGJHYWgvVzZJdTZjZzR5RU9JbDM5aXpSUjgwb2VneVNI?=
 =?utf-8?B?ZDlYbVBkYkVlako4eWVCZDFVL09iL0tKa1Mzc25hcjNobjFWem9Dd1FQKzEz?=
 =?utf-8?B?ZFg4a09GaG1RREF2R3ZJNzFCL2Jvc1FqV0NtTnpwMHRNeEJVc1dHd1RPK1hj?=
 =?utf-8?B?V1dzY25ISEpOTlRiNVdjMjFRb2x6RWVPVldRM2pZWmdxc25WREEvWS9RODBI?=
 =?utf-8?B?Ukx6aEgzTVJKQk1YMWdteHp6R3hpZWcvL3paSVdHS0JiNFBOY3hGUlE0Y2xL?=
 =?utf-8?B?c2xzQzI3dWMwMW8rbTZTbEJIYVczczBXQlltdjdoMVUvU0VuejMwSEJkamxh?=
 =?utf-8?B?SGp6QUt5eGhjdmIyM0ZicnJ5SVpkVG5rMVVPQzd3MzJPVkkvUTNyRlV1aytY?=
 =?utf-8?B?dkFQZlBWdnY3ZU1SakZqWkR4VE5jdGkrWjA0eitGajJyeEkwZ0lxdnpNVDNo?=
 =?utf-8?B?QzBoMUUwM1dlM2xXMWV1ek5OZE0yVUd3VmkzdnlPancrZ2lYWE1YSWx3L0ly?=
 =?utf-8?B?b3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01D8CCAC3D16B04DB1C61B0F3632CE4E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec78a810-d51a-4d00-68d3-08db7376fc05
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 23:18:27.4211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jwmGdgZGkivdiGLOegoKukkcAoRhaQJ3Lxwb83Gq23Ugm/RfYiAJWFXpgpCEWjJ2sVmILyAFWddZnpjCWtksFkGGzEfTBZvsY2ozUh6bpb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5762
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVGh1LCAyMDIzLTA2LTIyIGF0IDE3OjQyICswMTAwLCBzemFib2xjcy5uYWd5QGFybS5jb20g
d3JvdGU6DQo+IHRoZSBkb3duc2lkZSBpcyB0aGF0IGxvbmdqbXAgYWNyb3NzIG1ha2Vjb250ZXh0
IG5lZWRzIGENCj4gc2VwYXJhdGUgc29sdXRpb24gdGhlbiB3aGljaCBpbXBsaWVzIHRoYXQgYWxs
IHNoc3RrIG5lZWRzDQo+IGEgZGV0ZWN0YWJsZSB0b2tlbiBhdCB0aGUgZW5kIG9mIHRoZSBzaHN0
ay4uIHNvIGFnYWluDQo+IHNvbWV0aGluZyB0aGF0IHdlIGhhdmUgdG8gZ2V0IHJpZ2h0IG5vdyBh
bmQgY2Fubm90IGFkZA0KPiBsYXRlci4pDQoNClRoaXMgc291bmRzIGxpa2Ugc29tZSBzY2hlbWUg
dG8gc2VhcmNoIGZvciBhIHRva2VuIG9uIGFub3RoZXIgc3RhY2ssDQp3aGljaCBpZiBzbywgeW91
IGhhdmVuJ3QgZWxhYm9yYXRlZCBvbi4NCg0KSSdtIG5vdCBnb2luZyB0byBiZSBhYmxlIHRvIGNv
bnRyaWJ1dGUgb24gdGhpcyB0aHJlYWQgbXVjaCBvdmVyIHRoZQ0KbmV4dCB3ZWVrLCBidXQgaWYg
eW91IHRoaW5rIHlvdSBrbm93IHRvIHNvbHZlIHByb2JsZW1zIHdoaWNoIGhhdmUNCnJlbWFpbmVk
IHVuc29sdmVkIGZvciB5ZWFycywgcGxlYXNlIHNwZWxsIG91dCB0aGUgc29sdXRpb25zLg0KDQpJ
J2QgYWxzbyBhcHByZWNpYXRlIGlmIHlvdSBjb3VsZCBzcGVsbCBvdXQgZXhhY3RseSB3aGljaDoN
CiAtIHVjb250ZXh0DQogLSBzaWduYWwNCiAtIGxvbmdqbXANCiAtIGN1c3RvbSBsaWJyYXJ5IHN0
YWNrIHN3aXRjaGluZw0KDQpwYXR0ZXJucyB5b3UgdGhpbmsgc2hhZG93IHN0YWNrIHNob3VsZCBz
dXBwb3J0IHdvcmtpbmcgdG9nZXRoZXIuDQpCZWNhdXNlIGV2ZW4gYWZ0ZXIgYWxsIHRoZXNlIG1h
aWxzLCBJJ20gc3RpbGwgbm90IHN1cmUgZXhhY3RseSB3aGF0IHlvdQ0KYXJlIHRyeWluZyB0byBh
Y2hpZXZlLg0K
