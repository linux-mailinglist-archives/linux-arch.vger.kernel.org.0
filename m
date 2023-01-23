Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFED67889F
	for <lists+linux-arch@lfdr.de>; Mon, 23 Jan 2023 21:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjAWUrS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Jan 2023 15:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjAWUrN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Jan 2023 15:47:13 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFCC301B8;
        Mon, 23 Jan 2023 12:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674506831; x=1706042831;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=j2lkhKtITQWTuhhy0BLh+FtscHiTlYvpH3lx2uwEWq4=;
  b=blfDLsdV9bqmd4wiKeEvoLaNiwFAn3cmkSdK1Z7p64b1zlZ4RXjmH1h0
   uAim92NFq9JPDHfTUv4Q28qMyqsXUtWWdIaAJfqSXxWeue1s3rV5ghyoW
   iIFySnwpvUQVofcHiDRYZM19vJRGGKXtt20XufYyr27ltuWhBt11UtbgR
   QV5WSqEBlbYfBy0NT3j2uB3/XP2NMK4kzVU7N4cti2csZqFOiUWHQazuM
   2sfU/XnavYOlMBRjIZVdntlll2N+fRQJMWiE9pWvmLMbzPMhPtlcf1GWG
   AjBgxvSWDYY9dNTJ7vQKgRGKLcbBS8gFwonpKtuSMIrsboUdlH9hSxvUZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="314043373"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="314043373"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 12:47:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="655162428"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="655162428"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 23 Jan 2023 12:47:10 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 23 Jan 2023 12:47:10 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 23 Jan 2023 12:47:09 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 23 Jan 2023 12:47:09 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 23 Jan 2023 12:47:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzDtr8FWByXTm0hOnIxTLijO+YCN1jklDxESxbM2+yh2JApHnjewItZ5rbfVkqfBhkpcuoN/K2dflE5H1ydLlKvzGUVmVp9menZVIv7Ita2MWEJ8ngE8WyM/PAiLYFdiQD8PulJoaP/e9se9AdUuP7btfrHNi5IYct5HkJE+GRJADgOeTfbY1WUDdHn2kDkEv02MlRmL5O9Wj+SJi8IddKBi3nGB0Y+8TFbEq7RzEclpstvoxHs45A9H0+E173QiNXS2V85xZwSE/0uAuhZT4ZZfG6KL+JzEUbW8aRvJXlIW6sclO23be18p6Br1pq8BBZLxONIoYSHVnOmelWAPkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2lkhKtITQWTuhhy0BLh+FtscHiTlYvpH3lx2uwEWq4=;
 b=f1+v0cuLJeo3Os1Z5Ccqb/pWhpRMxMsl3Na6o2X7yLHzRCvUGPHYHLWMGmPacg8VgtZGUyLdichn4fpDz2wahgt8PlbzxlNGU3Q/3VZIFHKWMJdrYT/H/ockAKp1e4xhyD8jMQV2WecarAWyaFIzMwn5uMUPT5PfS2nVFXH28VDVYwFFyZJo9cl48Ys6eoO0KOF8hF5K8pZRbuOmyyxFKmd3B+P2JoZmqJGGRJQzb4gOwgaD+FN+cfS2gdaCkBhxJDtnhqVfAQAfFAaS8GC3XQRXd6ks/X9v6epDY73CukhgPvMh5+XlG4rsT9s2DM1TfPlotVDM8Wjht7xL2MJ52g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MW5PR11MB5930.namprd11.prod.outlook.com (2603:10b6:303:1a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 20:47:06 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 20:47:06 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
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
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
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
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v5 18/39] mm: Handle faultless write upgrades for shstk
Thread-Topic: [PATCH v5 18/39] mm: Handle faultless write upgrades for shstk
Thread-Index: AQHZLExgp79hLxaTJUWnXCRef2z2Ua6rx5SAgAC3h4A=
Date:   Mon, 23 Jan 2023 20:47:05 +0000
Message-ID: <50cf64932507ba60639eca28692e7df285bcc0a7.camel@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
         <20230119212317.8324-19-rick.p.edgecombe@intel.com>
         <7f63d13d-7940-afb6-8b25-26fdf3804e00@redhat.com>
In-Reply-To: <7f63d13d-7940-afb6-8b25-26fdf3804e00@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MW5PR11MB5930:EE_
x-ms-office365-filtering-correlation-id: 12a5afdc-a598-4844-06b1-08dafd82fd0d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /5af+hiraf6hRrLEeYN4RA3h/xraRupIzkqD7ncq28wC/mWLCEWuUi8iM0u09gUChRadNWAflLbNdQZxIDgaV4ZMcs7su0Pcia049dIMcc39H2OQhLwHMuLWYlkgaC1L6Dn9qd2GmHsphHwO08HQPogE7gZfN1dij2nOt5Wuho5+hXQmDgowMERbMDofdqIGCyvc2/idT6r60WdwN9l1DjnctokleccLVyye1EQ0eirXd1zxasEjf7gcDiO8x/6oK2//r8sqlEXw0+wm9GBjZVeqczSA85hrYnZuVLS2gVvgDXm5AIxAOSP8+2EtOG+DO4/Q/QRhIQ6t1iFvstEzUFZYMAh1mw8RLNWdgK0LfON+UEIZTPin9dn2Fi2GioZrS+QakvkRDu/KIv6nnVWnGcc61IqfEzABj+niZv+8vfUgG/yZUN4WGkUT2UzwKDIlt3QYANceu9GpdJa9l7g+xL+HiOW3LfmulHiK+e6GHKEeDAS1EaVYQ6mAOGoJOo/dCfkApB+S9MEDmqyiGmdSiIMU5Zh4o8LnlnTHy/aqbRMNszih7HqSzvMjtnuNrSGU8dW/X3Utl2yXId+3CXeWK65gE9WpYLeoOcmG2jdpOaER1hup6APHkjcnT9bclwohcN6EwE0dw6m3BndTgjo99iFNCSG8INsgAR1X8XZDtpTT9d51riv7jNO5v/++awORD7oWCQUrylgEPvJqy1sEoIjajSFHV9GahaERdY02Mt7hQV0XLz4aNDTrHPYjcPUCVnWcOImLMAhw97kzHgGvRQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199015)(4326008)(83380400001)(122000001)(41300700001)(38100700002)(82960400001)(2906002)(8936002)(5660300002)(921005)(86362001)(7406005)(7416002)(66476007)(53546011)(8676002)(6506007)(26005)(6512007)(66446008)(316002)(66946007)(2616005)(66556008)(64756008)(76116006)(91956017)(71200400001)(6486002)(186003)(110136005)(478600001)(38070700005)(36756003)(99106002)(17423001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlJCaEN6RHdLV3VEUmpsM24vTkNqaHh1QzIvQVRhTnloN3pZR3k1WUhZdlBy?=
 =?utf-8?B?ai9UUnBBMGdmOGxNaWJjTnpUb0FEaVp6cjkyRGQwUGJoUUFSNGx1dVcxWWx6?=
 =?utf-8?B?MXlBTklZY3I1MFdwWmMraEFKa2xuQUpNWHVISHh4eVdOMllxNHBXcFRWUTM2?=
 =?utf-8?B?QkhBOHRNMzRHQ1kwbmxFVllmUHd6cktpbFc5c254dnpWUUp3S0xHWkd1TWhl?=
 =?utf-8?B?UWI2NldkbTREbCtzTjNabWJxb2M4MEN3WitlTDhyNDYrZytsM3UxTlNrUFpM?=
 =?utf-8?B?NERyaS9ua0NyMUxXMHBaMHdhUjB4SjlWQjN5a2hRMUp6Z0wzb1htVHo4RlRq?=
 =?utf-8?B?S21YelRnTUhkL3g5V0VCVWgweE96cHRRN1VmNVRDSVJISVJhcmlCY1dzOUtF?=
 =?utf-8?B?NVRmblUrdnJwdjB6VFVsdG9IL1Mrd01uVVFiTkcwMXNZMlp1MmN0MlNwQUNv?=
 =?utf-8?B?OVhYSkhLYkdKcU9wRlBxcCtCWk9mR2NUMXNEN3JUTkxWWWlKTS9veXh4aHkw?=
 =?utf-8?B?VXFqOE03aHpQM201ZUZHcElVcFRyamVOQ3pwNlJKK0tvNG8rbFRQcmhKNHBD?=
 =?utf-8?B?RlpENjZmdlVEem9YUTVUUm5mRGdVa2ltZ0tid0c1aU1mcVI5RUMvUVdXc2Zy?=
 =?utf-8?B?VkhxSGZaWGVmcExLenNtc0JYOGlHTDJvQ3RPamcrb0ozQnBDeXVQV0VST1N5?=
 =?utf-8?B?SFU5YWlUaVRud3VrTU1RWkE1aTFLM2hRZDltVFpSR045djdpSDBreEQ5cmFK?=
 =?utf-8?B?S09EME5lUlJQbjQ2TUo4dGE0MWp3REprY1JqcFp0N09uYWhMSWZPQlRVZThB?=
 =?utf-8?B?ZytZTmZXWVg5YWdoOGNOcllaR2ZianBKYS9vUE1SUE9aU2FWcnp6THdSOVJ3?=
 =?utf-8?B?UzR2dW5qNFJtQ2NVSlFoOXBSMzNOdXI1alIxd2p3bEFIa0M1VkFDTCs0UHNO?=
 =?utf-8?B?WUV0WHNEUThhYVJEVEhtbXFXMUEyeTcwNmNrY20vN2QvQ2hQaHJRT2gvc2Y0?=
 =?utf-8?B?MFBNMGpRT2JGaWM4U1pMeFJNRE1rT3YyUkh1U1UzNnRoZGV3dVRGd1ZFMVI4?=
 =?utf-8?B?bGY1cU9Ec1ZsblJlMGljMjZFcWhQK0N1ZlhrR0lrVEp3bUd4akV6NjJSZXFx?=
 =?utf-8?B?bm4rMHphUWRieGRwam9veGk2MDNEUmNTRitOTmZUTkFLRTM1TGlKd0thVVNX?=
 =?utf-8?B?RFZIYmVFWHpvWDJ2aC9jZ0pLbW1zRlJYc2htb2pwWkNySnNsV3pOeEg1RHBB?=
 =?utf-8?B?enhVT3dneG9iRjBmbGoyWUpxT2VBakorK3I3ZDdqVkpGSDhuNWR1L25jWjgy?=
 =?utf-8?B?Vnl3bFZlMkc1aDVvMWRXdEhOSjJwemJVMUlOQ0R6R1I2ZVVQOWdkUUF6T2x3?=
 =?utf-8?B?d3JYWU82SnZmWks2LytXa05TSSt5TXpYWU5wbFlFZEpBNUNXOUI2cDBTYmM5?=
 =?utf-8?B?SE95SjJCcVVNU0lETDR5K0ttZC81NWx4RnZnSkg4MU5SSWw1bzFXeE5MSito?=
 =?utf-8?B?ajZaNHBMRDNtMUxjTXdLS0RqcVZub1puUDl3UWkyZ3JHSHdlWTMycFF6eHVW?=
 =?utf-8?B?Z3BuMjkvTlVYR3FUVndNcGxKdVBJUmE2dDNUa012STNqOS9GMCtubEFPS2Fa?=
 =?utf-8?B?MXg2cFNnaW1scnZZVDZHYSswR3h5NE16NzIxU3V6UE93alNEZWFCVTk5dk5s?=
 =?utf-8?B?S28xY3VzWmMrWFlkN2lXb25SNUxqY3orLytjZ0lFckd6aWhSbS9jZzVHWFhM?=
 =?utf-8?B?d2tGSGxuT25oWWM0czZqTUNDdGlpMDZtcE1UYmJGSTBJSXZOL01UMU5WTytT?=
 =?utf-8?B?U3ZBSGN6MHhNVWl0TUwzL0xpaFYvNENxdldnUDdrWFM2VUgvN1lIUHRtQ0gr?=
 =?utf-8?B?TnpxNXVFd1ZrdzllNFFZYUxqRVdwSFVRTW1RWTU0K1FhOHB1NG1WMUFsRC9q?=
 =?utf-8?B?UHVGTjYwZmlTd21mUjVEdUVvWVJOQnF4RGo2elUyWkhWWkZRbHd6Q29XWk14?=
 =?utf-8?B?RWMwanNLbzNBeTJYV3BRWUloYVBsVkxwalE2TVlySm44bURUMXQxWUsrQno3?=
 =?utf-8?B?cFBlSmZwZkR4TW9VRHJSRFJKTlYzQk04K0l6WU9sOHBzdFdJZGlqaE1TVWU3?=
 =?utf-8?B?Y2xEZHhVbHF2bFZTdVViOUs0dkQvYnFMUnBDYkVBeG1lV2gzRVRYblRRRXFI?=
 =?utf-8?Q?k129SUThyTt2uNRlTPVvC6o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D42D052ED984C4BA7AC5B8BC6CF9F95@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a5afdc-a598-4844-06b1-08dafd82fd0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 20:47:05.9099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mk4jYMoJ+MUAom2YwSMOHIe77+gGVt+yX3L7JanU+d/iGujl8W9b6NgdL2i75s3H8/BJpKU7B23AeDH10K4o+bdjZVg3FYUn6Fl7ar2zr0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5930
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIzLTAxLTIzIGF0IDEwOjUwICswMTAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4gT24gMTkuMDEuMjMgMjI6MjIsIFJpY2sgRWRnZWNvbWJlIHdyb3RlOg0KPiA+IFRoZSB4
ODYgQ29udHJvbC1mbG93IEVuZm9yY2VtZW50IFRlY2hub2xvZ3kgKENFVCkgZmVhdHVyZSBpbmNs
dWRlcw0KPiA+IGEgbmV3DQo+ID4gdHlwZSBvZiBtZW1vcnkgY2FsbGVkIHNoYWRvdyBzdGFjay4g
VGhpcyBzaGFkb3cgc3RhY2sgbWVtb3J5IGhhcw0KPiA+IHNvbWUNCj4gPiB1bnVzdWFsIHByb3Bl
cnRpZXMsIHdoaWNoIHJlcXVpcmVzIHNvbWUgY29yZSBtbSBjaGFuZ2VzIHRvIGZ1bmN0aW9uDQo+
ID4gcHJvcGVybHkuDQo+ID4gDQo+ID4gU2luY2Ugc2hhZG93IHN0YWNrIG1lbW9yeSBjYW4gYmUg
Y2hhbmdlZCBmcm9tIHVzZXJzcGFjZSwgaXMgYm90aA0KPiA+IFZNX1NIQURPV19TVEFDSyBhbmQg
Vk1fV1JJVEUuIEJ1dCBpdCBzaG91bGQgbm90IGJlIG1hZGUNCj4gPiBjb252ZW50aW9uYWxseQ0K
PiA+IHdyaXRhYmxlIChpLmUuIHB0ZV9ta3dyaXRlKCkpLiBTbyBzb21lIGNvZGUgdGhhdCBjYWxs
cw0KPiA+IHB0ZV9ta3dyaXRlKCkgbmVlZHMNCj4gPiB0byBiZSBhZGp1c3RlZC4NCj4gPiANCj4g
PiBPbmUgc3VjaCBjYXNlIGlzIHdoZW4gbWVtb3J5IGlzIG1hZGUgd3JpdGFibGUgd2l0aG91dCBh
biBhY3R1YWwNCj4gPiB3cml0ZQ0KPiA+IGZhdWx0LiBUaGlzIGhhcHBlbnMgaW4gc29tZSBtcHJv
dGVjdCBvcGVyYXRpb25zLCBhbmQgYWxzbyBwcm90X251bWENCj4gPiBmYXVsdHMuDQo+ID4gSW4g
Ym90aCBjYXNlcyBjb2RlIGNoZWNrcyB3aGV0aGVyIGl0IHNob3VsZCBiZSBtYWRlDQo+ID4gKGNv
bnZlbnRpb25hbGx5KQ0KPiA+IHdyaXRhYmxlIGJ5IGNhbGxpbmcgdm1hX3dhbnRzX21hbnVhbF9w
dGVfd3JpdGVfdXBncmFkZSgpLg0KPiA+IA0KPiA+IE9uZSB3YXkgdG8gZml4IHRoaXMgd291bGQg
YmUgaGF2ZSBjb2RlIGFjdHVhbGx5IGNoZWNrIGlmIG1lbW9yeSBpcw0KPiA+IGFsc28NCj4gPiBW
TV9TSEFET1dfU1RBQ0sgYW5kIGluIHRoYXQgY2FzZSBjYWxsIHB0ZV9ta3dyaXRlX3Noc3RrKCku
IEJ1dA0KPiA+IHNpbmNlDQo+ID4gbW9zdCBtZW1vcnkgd29uJ3QgYmUgc2hhZG93IHN0YWNrLCBq
dXN0IGhhdmUgc2ltcGxlciBsb2dpYyBhbmQgc2tpcA0KPiA+IHRoaXMNCj4gPiBvcHRpbWl6YXRp
b24gYnkgY2hhbmdpbmcgdm1hX3dhbnRzX21hbnVhbF9wdGVfd3JpdGVfdXBncmFkZSgpIHRvDQo+
ID4gbm90DQo+ID4gcmV0dXJuIHRydWUgZm9yIFZNX1NIQURPV19TVEFDS19NRU1PUlkuIFRoaXMg
d2lsbCBzaW1wbHkgaGFuZGxlIGFsbA0KPiA+IGNhc2VzIG9mIHRoaXMgdHlwZS4NCj4gPiANCj4g
PiBDYzogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQo+ID4gVGVzdGVkLWJ5
OiBQZW5nZmVpIFh1IDxwZW5nZmVpLnh1QGludGVsLmNvbT4NCj4gPiBUZXN0ZWQtYnk6IEpvaG4g
QWxsZW4gPGpvaG4uYWxsZW5AYW1kLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZdS1jaGVuZyBZ
dSA8eXUtY2hlbmcueXVAaW50ZWwuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBLaXJpbGwgQS4gU2h1
dGVtb3YgPGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1i
eTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0KPiA+IC0tLQ0K
PiANCj4gSW5zdGVhZCBvZiBoYXZpbmcgdGhlc2UgeDg2LXNoYWRvdyBzdGFjayBkZXRhaWxzIGFs
bCBvdmVyIHRoZSBNTQ0KPiBzcGFjZSwgDQo+IHdhcyB0aGUgb3B0aW9uIGV4cGxvcmVkIHRvIGhh
bmRsZSB0aGlzIG1vcmUgaW4gYXJjaCBzcGVjaWZpYyBjb2RlPw0KPiANCj4gSUlVQywgb25lIHdh
eSB0byBnZXQgaXQgd29ya2luZyB3b3VsZCBiZQ0KPiANCj4gMSkgSGF2ZSBhIFNXICJzaGFkb3dz
dGFjayIgUFRFIGZsYWcuDQo+IDIpIEhhdmUgYW4gIlNXLWRpcnR5IiBQVEUgZmxhZywgdG8gc3Rv
cmUgImRpcnR5PTEiIHdoZW4gIndyaXRlPTAiLg0KDQpJIGRvbid0IHRoaW5rIHRoYXQgaWRlYSBj
YW1lIHVwLiBTbyB2bWEtPnZtX3BhZ2VfcHJvdCB3b3VsZCBoYXZlIHRoZSBTVw0Kc2hhZG93IHN0
YWNrIGZsYWcgZm9yIFZNX1NIQURPV19TVEFDSywgYW5kIHB0ZV9ta3dyaXRlKCkgY291bGQgZG8N
CldyaXRlPTAsRGlydHk9MSBwYXJ0LiBJdCBzZWVtcyBsaWtlIGl0IHNob3VsZCB3b3JrLg0KDQo+
IA0KPiBwdGVfbWt3cml0ZSgpLCBwdGVfd3JpdGUoKSwgcHRlX2RpcnR5IC4uLiBjYW4gdGhlbiBt
YWtlIGRlY2lzaW9ucw0KPiBiYXNlZCANCj4gb24gdGhlICJzaGFkb3dzdGFjayIgUFRFIGZsYWcg
YW5kIGhpZGUgYWxsIHRoZXNlIGRldGFpbHMgZnJvbSBjb3JlLQ0KPiBtbS4NCj4gDQo+IFdoZW4g
bWFwcGluZyBhIHNoYWRvd3N0YWNrIHBhZ2UgKG5ldyBwYWdlLCBtaWdyYXRpb24sIHN3YXBpbiwg
Li4uKSwgDQo+IHdoaWNoIGNhbiBiZSBvYnRhaW5lZCBieSBsb29raW5nIGF0IHRoZSBWTUEgZmxh
Z3MsIHRoZSBmaXJzdCB0aGluZw0KPiB5b3UnZCANCj4gZG8gaXMgc2V0IHRoZSAic2hhZG93c3Rh
Y2siIFBURSBmbGFnLg0KDQpJIGd1ZXNzIHRoZSBkb3duc2lkZSBpcyB0aGF0IGl0IHVzZXMgYW4g
ZXh0cmEgc29mdHdhcmUgYml0LiBCdXQgdGhlDQpvdGhlciBwb3NpdGl2ZSBpcyB0aGF0IGl0J3Mg
bGVzcyBlcnJvciBwcm9uZSwgc28gdGhhdCBzb21lb25lIHdyaXRpbmcNCmNvcmUtbW0gY29kZSB3
b24ndCBpbnRyb2R1Y2UgYSBjaGFuZ2UgdGhhdCBtYWtlcyBzaGFkb3cgc3RhY2sgVk1Bcw0KV3Jp
dGU9MSBpZiB0aGV5IGRvbid0IGtub3cgdG8gYWxzbyBjaGVjayBmb3IgVk1fU0hBRE9XX1NUQUNL
Lg0K
