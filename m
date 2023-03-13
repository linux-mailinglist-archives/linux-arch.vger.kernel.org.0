Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419176B7D32
	for <lists+linux-arch@lfdr.de>; Mon, 13 Mar 2023 17:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjCMQPf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Mar 2023 12:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCMQPd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Mar 2023 12:15:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15F6570A0;
        Mon, 13 Mar 2023 09:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678724130; x=1710260130;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xbyIRyOPRwgMQ6+VGNyTHFXmR2By6+UJNs8MEd95ld0=;
  b=H5z0BavZt1gHhGSRrFmg9sHuXmOZDjsks4agtAEwqmQhBg0ee38Keqvs
   DIUTs8/YHEMnYNA+A9PhmNSUGf/jAwq053z5H/hTue2NiWfTB2CMyKrGM
   0pORGPxK79c8wu/Rl9XOYPJrQ7zXbGIc+nglTffKtLcml59so9Kea/Pqw
   votF7h714CAZXGpUmViS0X2RWS92P5HnOlGZNb9/agvgoyJw2J80Supch
   O9/5rozgDxSSgtYcoc4FSX+ZUD03k3RQ3EfLIcx3PEtSFIw2V99R2Zac6
   /3ChxJm2fC+eM2uLXv7TPtpEx+s2F4jI13gnzhFusUwJ0tEjxQRoWIOeR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="325552297"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="325552297"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 09:11:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="788986763"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="788986763"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 13 Mar 2023 09:11:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 09:11:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 09:10:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 13 Mar 2023 09:10:34 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 13 Mar 2023 09:10:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLShmqSR8s6S3j6gEVLM41T9WL+sIwLyRt/oNaKYdSqDXEJYN8xFwNRTsbrNqHuXim7zE37v8NseUq+IZq+mF9sJxViWCpT++XRh6wgyWO58JifR7J1v43AWQd7ybAPetYR4acMqOjerp++xuA8r7kS0D2PPRnCfoBtgfPpnr8uz0q9gnjhBwBvP6W01XmA7tICLiMi+LTUC4jtF9W+anTgCchMKLw2vTJaEtGKMsWgVn0MBpqwt66Mc1joaxPk3ADwS+wM/YrBJeFRYf9+MZ9lcro2kCXO26qtBfmEe54vntndiwj/mPrcjieYSWR7PjWtG/bQYYtHhW986YFVXVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbyIRyOPRwgMQ6+VGNyTHFXmR2By6+UJNs8MEd95ld0=;
 b=i15Ww1vy1LZlmqMTXgLpX86l0AmX1mA/+Ezp80rB9xKME1LCxh93oIv3i9HW2aFcEDaRgYkr8MkRvJ1lZTL2jZpbvODDXIo7uvfpaJ9sTvgJ3s06qmZebvrUQDnPT0hEMuqtfd7kE0CFXotk1qc3B2IwHVP3DgSpEICkDFmpiN8WxrbP3mc3FgNviDxrESlK88ghOoV96FqOG5JhMbl3zbsMwSpl/Wm7f3bEXsuU+lFTIDug1yv9tZz8VZchld6dhbaC57UdNdj+NyOlDR5bCMA2QNHtLTpXvp59SDMo4uhqDS8+IYJdSMFnxBHj+Tfb4MXuUdLP789MhEy5dDmmiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CO6PR11MB5586.namprd11.prod.outlook.com (2603:10b6:5:35d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 16:10:15 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 16:10:15 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v7 38/41] x86/fpu: Add helper for initing features
Thread-Topic: [PATCH v7 38/41] x86/fpu: Add helper for initing features
Thread-Index: AQHZSvtH//l8GkMHSEuT277fH1R14q71m1QAgAJ6WACAAItGgIAAVasA
Date:   Mon, 13 Mar 2023 16:10:14 +0000
Message-ID: <04f821e6d4a8a736e6df2eb73ce811022cd42537.camel@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
         <20230227222957.24501-39-rick.p.edgecombe@intel.com>
         <ZAx6Egh6U5SCZEby@zn.tnic>
         <3385eaf888f4178607ce4621ae2103d08ba79994.camel@intel.com>
         <20230313110335.GAZA8DB6PNSMGOGHpw@fat_crate.local>
In-Reply-To: <20230313110335.GAZA8DB6PNSMGOGHpw@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|CO6PR11MB5586:EE_
x-ms-office365-filtering-correlation-id: cc5d0c87-bec2-4438-8046-08db23dd6e5b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YeTQKM515azt8rVV0S4JIlxlTvv8gQdwBlvrKkehJL6J3RT84crL0wPaa3R5f4nHg8Q0Hf90zkA5YBmKNYt9xH8u9Q+gH/DSj4PAlbWS6/39enTLztzbNjVA4A4In9PQ2y9E/o89714ndZ3z1rY0sUmehpFCiXwgNHmHX/ZLxtTY6QR/C+pjVPG4+HxFfpAhjzQYGuwKVnq5yfbtEg6yRSO5zwxkma8wKKbRp8hZFTzJctgYzSseof4EmXExra3zNEdZw0FRCMPYTdLo+iA5hP/dN7n37qkl2DQqfLJK8b+omJ07tVRK71m8NyW1NsizNBeynkd6Kj3Y+7/D8i1aYdwyKys9hUexdSZbUQenKavjtgpHgU6Mn+JT4Z3xtTvqcYOnpk6ZDov8vS52Yta4Nzcouvq8V3IhtMRqOMZ7hA2upzt8hEOoVeVGpYaSUvUwd3Nho77cYk2PM1VO5rJJN/dfSDb/u3ylzBhAxGdjPDRca9rdqcayA5UPhnuARbW3k+AB4KBs3vm9SpWmAX2e61Ps7dM2Qxiy6bWrR0aedyUlqnexMFxFAdEuLh2HEK+ygbEvQbpe79cC1jia4foBFWYvDa9nJJLSSpQ+dG+g2ZvY6Nb0F3uHSIU65a8UMldeeGwtkjbEdx9cVAOWuGWD4mKu2KdfOA4tERkyjaHHN3MHPI+AdBEfK5xrlZYJ3COT1sS8Z+JDUb6s+bagtIgBKIQp2t2Hgg7xT9gldSLwASI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199018)(38070700005)(86362001)(36756003)(38100700002)(82960400001)(122000001)(66476007)(66556008)(66946007)(4326008)(6916009)(76116006)(66446008)(64756008)(8676002)(41300700001)(54906003)(478600001)(8936002)(7406005)(5660300002)(7416002)(2906002)(2616005)(6486002)(71200400001)(6512007)(26005)(186003)(6506007)(316002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmdDSzBKK3Rpb0tTRDhDMTA5SEUzK0VFN3l3azY5Ull1dlRCQjRwRTJUR1ZN?=
 =?utf-8?B?ZkRQTWFpbnVFdnFUUjcwR1ozWGNwdHYxMkQwWTBROTJEeUJQOHFYWWN4cjlz?=
 =?utf-8?B?Y05aaTg1dnl4SGZneHNPaEpzNWNHc2NpZUszYVlLU3BkZEw3czRKWWNuMGhO?=
 =?utf-8?B?bjNkM0REY3V1TGF2NitlQWZ0ekUvUnlSa2t1aXh2bDRRSFQ0SWhKVUZCMjFU?=
 =?utf-8?B?MGIzRzFVK1FGMGFyYjM2cVU3aUhOYzg0MTQ2RE9hNi9yNUhscTZ4WXhjVVBQ?=
 =?utf-8?B?ZS9OdE9WdVpmVXp0d3IySXNXeWEvVXhqd2ZoWllCVy9MS1JXNk1kZ3lGeXBn?=
 =?utf-8?B?bmI4SnllZU5yeHlWYkMrSHJGOFZmTXZpRnFJU05lM2p6NGxUeVFwdmxnK1h5?=
 =?utf-8?B?RzV5dFVhTjhza1FEcTlhL1cwN1RDNU1WOERydEx2Z0lpTXlyUUFEcTJVdU1V?=
 =?utf-8?B?RkZKTFVadEU0czRBUmswWGFTS0xmbmJnc3IxaC9uMXNyc2NmTFNYZ2FKd2tS?=
 =?utf-8?B?TCtYNHRpL29YL1pJRFdtZ25DOE1XVXFQL2pVSXl1VS9JV0Yva2VEckdVQjkz?=
 =?utf-8?B?QVdYMW1rQ3NVUU5yY0ppeVNJMGdyT0xtMG9FL2pvQTRGTUc1Syt5am9aQXQx?=
 =?utf-8?B?TnFpT0FFWFBXT29PREpHanRrekErQ2ZVVTIyeUF4OXBLZ21SQ0lOYjlNWlZm?=
 =?utf-8?B?ZU1qcmRRUEh1ckorQ3hxSHR3djJWK0Q5OW9zOHkyQ05ZUEN1QTZXUkkxOG9M?=
 =?utf-8?B?Q0tEb0h3MkpSemtadkdjSm12dm40dUk1VFpQaFBrVUVyOVpSUnd1VXdYZEVY?=
 =?utf-8?B?eW42MHFNcnR0RnlYSTFBMzdoNjFtU0ZnMEFuTFp0Zk1BNVhFNVowd2UxY2Fu?=
 =?utf-8?B?dmR1NThSbEJuRVFxN3E2dWdHS1ArOVRoZGlrM2RYT3JXcW95UWdIUmF2RXl5?=
 =?utf-8?B?Ri81bkswaWQ0ckhBNVNLdXhXR0NVMlVzNlhlN2ZFVldxbldGUUE0ZnEyL0Fq?=
 =?utf-8?B?TVJqN0FoeE4va2tDSysrcUtIYWk5NjNabkdKM0pUZ3RQQTFwb2dGeFZPWmNm?=
 =?utf-8?B?K1FZZGIzSFpZMWgvS2ZiMHN6VnJDcUtxTHlRK2E2MzdaZnZNelNpdE9XL3Z2?=
 =?utf-8?B?K1NrMTlWOVV4ZEg0bHdZR0h0S1VzKzVBRmRxbkl2alI1SGhFUFkycmRua3Zo?=
 =?utf-8?B?a0pLU1JLQ0F6SDRkWHhYaHNKczlnZDFDaVpVYzYxZHpnK0kvRERhNHFBZUta?=
 =?utf-8?B?OUYzWVVwRnZKOStWZXg5SU8zU05SdEhlYUpkdllabVBXZVBmVEZjc0E3emc3?=
 =?utf-8?B?dHJKdHJhZTRmTXQrZEdVKy9sNXJYL3F0WXU3NWVzSVFmRDlVS2l2dzgrc0Jq?=
 =?utf-8?B?TGhVNFZuWW53RlFZUzFyTFNUeTE3MnltaEFCeHlXOFJWMmFtbEpGMVNheGl3?=
 =?utf-8?B?SUFUVzFxZm40TTVVMzNHL2tCTjBxYkVlTklHdkRSdjNTMGZRVnBNMDBFdlhr?=
 =?utf-8?B?b1A0YU1mcm42bHRhclZ1N1VaV3F0RjNnSXJlQnV4NHBNYWh6UUNMS0tUSmo3?=
 =?utf-8?B?UTZyamdpNlVhQXZhL1B4cDZDN1JKODM2Z1hUUlplNEVnQXBEMGFsNWdUNWEz?=
 =?utf-8?B?cXNVeTdtNXNrby9Eb2lmeERDYUJLd0theGZCY2RENzlCYTA1WkR2UElOTzJS?=
 =?utf-8?B?Sk1IM2RoQW9ERkorVHZBVFVQejA4dmx5QnhsdlcvcjFMd0gvL1BPclhmeDZp?=
 =?utf-8?B?dVJ1c3J3UzlsbGl5QlJvVXJ4algwRFVYTmdDL0p4TWhhR2QvZDJlRVRLVU91?=
 =?utf-8?B?MzV6VVBPYmd0a1VRRnVzVVlBUVN1TmJZOEVuWTJOTmVyb2VxRjNFWTRKNXln?=
 =?utf-8?B?UCs3Rkp6VmJpOEczempnRHRPbzI4ZnNGS1FwNXFWbzRJY3l1dytweS9pcjFj?=
 =?utf-8?B?RUtJWW83V2pEL3Z4WEx2N0R1NEtPRUNEc2EvU2gvMUVRMUZiUVA3QnBYbW5s?=
 =?utf-8?B?VWlacmR4VzdSTXFvNTdndVFDOXY0Y0daQjh4cm5QdUdWRUZMOXcrOTlPOXF0?=
 =?utf-8?B?eEtIaC94Sk9PV1dZYVhvNVkzZEZvNUxxcUlTQlV1SS80ZUN6Z1BnNEJERDkz?=
 =?utf-8?B?RnJKQWVZWjJGclEwTTVmaVFiZWdlTDhOQmhzdW5TUUdYZXkzL1dnMnlKMjUr?=
 =?utf-8?Q?CLd9vtv3UhxmfSlocE8xOSs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <502F7F5861171447ACC9017BDE752B47@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5d0c87-bec2-4438-8046-08db23dd6e5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 16:10:14.8823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AVKCKEcCMNik/oi4Z170ysCwfpZvSEvusg2K0WNRNM93EPRa7aVDZ5ekp+LB5EfRPVbYr9QnvcIB/ArKCGTtiA9qvQrNEwBTIUGTIi/oAQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5586
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

T24gTW9uLCAyMDIzLTAzLTEzIGF0IDEyOjAzICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIE1vbiwgTWFyIDEzLCAyMDIzIGF0IDAyOjQ1OjA4QU0gKzAwMDAsIEVkZ2Vjb21iZSwg
UmljayBQIHdyb3RlOg0KPiA+IFRoZXNlIHR3byBhcmUgZnJvbSB0aGUgZXhpc3RpbmcgY29kZS4g
QmFzaWNhbGx5IHRoZXkgZ2V0IGV4dHJhY3RlZA0KPiA+IGludG8NCj4gPiBhIG5ldyBmdW5jdGlv
bi4NCj4gDQo+IEkga25vdyBidXQgeW91IGNhbiBmaXggdGhlbSB3aGlsZSBhdCBpdC4NCg0KT2su
DQoNCj4gDQo+ID4gSSBkaWQgaXQgdXAsIGFuZCBpdCBtYWtlcyB0aGUgY2FsbGVyIGNvZGUgY2xl
YW5lci4gQnV0IEknbSBub3Qgc3VyZQ0KPiA+IHdoYXQgdG8gdGhpbmsgb2YgaXQuIElzIHRoaXMg
bm90IG1peGluZyB0d28gb3BlcmF0aW9ucyB0b2dldGhlcj8NCj4gPiBUb2RheQ0KPiA+IGdldF94
c2F2ZV9hZGRyKCkgcHJldHR5IG11Y2gganVzdCBnZXRzIGEgYnVmZmVyIG9mZnNldCB3aXRoIHNv
bWUNCj4gPiBjaGVja3MuIE5vdyBpdCB3b3VsZCBjb21wdXRlIHRoZSBvZmZzZXQgYW5kIGFsc28g
c2lsZW50bHkgZ28gb2ZmDQo+ID4gYW5kDQo+ID4gY2hhbmdlcyB0aGUgYnVmZmVyLg0KPiANCj4g
T2ssIHNvIHdoeSBkb24ndCB5b3Ugd3JpdGUgdGhlIGNhbGwgc2l0ZSB0aGlzIHdheSBpbnN0ZWFk
Og0KPiANCj4gICAgICAgICBjZXRyZWdzID0gZ2V0X3hzYXZlX2FkZHIoeHNhdmUsIFhGRUFUVVJF
X0NFVF9VU0VSKTsNCj4gICAgICAgICBpZiAoIWNldHJlZ3MpIHsNCj4gICAgICAgICAgICAgICAg
IGlmICh4ZmVhdHVyZV9zYXZlZCh4c2F2ZSwgWEZFQVRVUkVfQ0VUX1VTRVIpKSB7DQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgIFdBUk4oInNvbWV0aGluZydzIHdyb25nIHdpdGggdGhpcyBidWZm
ZXIiKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLi4uOw0KPiAgICAgICAgICAg
ICAgICAgfQ0KPiANCj4gICAgICAgICAgICAgICAgIC8qIE5vdCBzYXZlZCwgaW5pdGlhbGl6ZSBp
dCAqLw0KPiAgICAgICAgICAgICAgICAgaW5pdF94ZmVhdHVyZSh4c2F2ZSwgWEZFQVRVUkVfQ0VU
X1VTRVIpKTsNCj4gICAgICAgICB9DQo+IA0KPiAgICAgICAgIGNldHJlZ3MgPSBnZXRfeHNhdmVf
YWRkcih4c2F2ZSwgWEZFQVRVUkVfQ0VUX1VTRVIpOw0KPiAgICAgICAgIGlmICghY2V0cmVncykg
ew0KPiAgICAgICAgICAgICAgICAgV0FSTl9PTigiV1RGIikNCj4gICAgICAgICAgICAgICAgIHJl
dHVybiAtRU5PREVWOw0KPiAgICAgICAgIH0NCj4gDQo+IE5vdyBpdCBpcyBjbGVhciB3aGF0IGhh
cHBlbnMgYW5kIGl0IGlzIGEgY29tbW9uIGNvZGUgcGF0dGVybiBvZg0KPiB0cnlpbmcNCj4gdG8g
Z2V0IHNvbWV0aGluZyBhbmQgaW5pdGlhbGl6aW5nIGl0IGlmIGl0IHdhc24ndCBpbml0aWFsaXpl
ZCB5ZXQsDQo+IGFuZA0KPiB0aGVuIHJldHJ5aW5nLi4uDQo+IA0KPiBIbW0/DQoNClRoaXMgc2Vl
bXMgbW9yZSBjbGVhci4gSSdtIHNvcnJ5IGZvciB0aGUgbm9pc2UgaGVyZSB0aG91Z2gsIGJlY2F1
c2UNCnRoaXMgaGFzIG1hZGUgbWUgcmVhbGl6ZSB0aGF0IHRoZSBpbml0aW5nIGxvZ2ljIHNob3Vs
ZCBuZXZlciBiZSBoaXQuIFdlDQp1c2VkIHRvIHN1cHBvcnQgdGhlIGZ1bGwgQ0VUX1Ugc3RhdGUg
aW4gcHRyYWNlLCBidXQgdGhlbiBkcm9wcGVkIGl0IHRvDQpqdXN0IHRoZSBTU1AgYW5kIG9ubHkg
YWxsb3dlZCBpdCB3aGVuIHNoYWRvdyBzdGFjayBpcyBhY3RpdmUuIFRoaXMNCm1lYW5zIHRoYXQg
Q0VUX1Ugd2lsbCBhbHdheXMgaGF2ZSBhdCBsZWFzdCB0aGUgQ0VUX1NIU1RLX0VOIGJpdCBzZXQg
YW5kDQpzbyBub3QgYmUgaW4gdGhlIGluaXQgc3RhdGUuIFNvIHRoaXMgY2FuIHByb2JhYmx5IGp1
c3Qgd2FybiBhbmQgYmFpbCBpZg0KaXQgc2VlcyBhbiBpbml0IHN0YXRlLg0KDQpVbmxlc3MgdGhl
IGV4dHJhIGxvZ2ljIHNlZW1zIG1vcmUgcm9idXN0PyBCdXQgaXQgaXMgYWx3YXlzIG5pY2Ugd2hl
bg0KdGhlIGNoYW5jZSBjb21lcyB0byBkcm9wIGEgcGF0Y2ggb3V0IG9mIHRoaXMgdGhpbmcuLi4N
Cg==
