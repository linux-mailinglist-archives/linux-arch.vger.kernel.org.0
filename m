Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075D5730595
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jun 2023 19:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbjFNRAk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jun 2023 13:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjFNRAj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jun 2023 13:00:39 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D023D1FDD;
        Wed, 14 Jun 2023 10:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686762037; x=1718298037;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3zaZ0bD6+23kzURnAWK/nc1bI2BfpFbmpV+dupnusbY=;
  b=HaBKsjYN4dpcLB39hDPaeyUSY9JpN2oa84nYL29GI3Hd5KXX19+x7S/R
   CYVoYRUjkRwJ1cmG+Hzs9awOw5zUFlCkpNRVEHBML6zDPHdUCXd46TluH
   mOqWfDXocFba8DKV3Kr4WbiDVfA38KegoMZ6CZBI4azxKi630VaaqmSQY
   6bFoxJmbkwroFfR3xjtD07XPhyIHI50Tbo1gRx0KykbtWzGH4OUjCq4rg
   Re3RpcqvDBPqikb7n1rRhvcS7io0jdG7M1FmRpGlT+Bu1vfDG4GYJwsS7
   vTAlSjMfY9ItFnlA18c6IsZHwsxd0GOB58Mckf3RDqHs2h9pT5KgX5UWl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="339022811"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="339022811"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 10:00:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="958860473"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="958860473"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 14 Jun 2023 10:00:35 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 10:00:35 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 10:00:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 14 Jun 2023 10:00:34 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 14 Jun 2023 10:00:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYy1NN3n3qFGqVwRWx8bz4hYQ5u581rb2d4mLfsuhJ25i/pazqvU+e/LNriq078LYiEYN323bqT4cUwKsLPqvYUjbs2Fw+QMySncqt+0cKsClIPo5ESiNyKn2w8nq82PJe5pI3wg66hEaQKmivG7CrdzduyzZACSBNEOMJ4E2sN7s+QmDoQBgXR8uWJBPSgJb34w5wV+UfuoKAeQu61xVE4jyA3kJWMI+PysJlIaPMOmOBNQZSQ537NQmu7JlgnjEBzOxUjJW9cVPY+W4eiK5YeMBKUnK0Pds+bfCuIzGQC7Wi0ysl3z8gg8EWYX+NYN3xTTmBmFpwf7bsX87EGqDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zaZ0bD6+23kzURnAWK/nc1bI2BfpFbmpV+dupnusbY=;
 b=KfskkY8joG+1OJJj9ZuP8nQNOYgtd4qDoOMWP7RiQfA3kz2ndndTJFMVvJs4fmeJ1EOZtlLFJPsHmCKKEguk8DYwZvScgrbYm7QD5oTcvFwMuwVSLhOqhTYdaT3aF3ehLUMwrlPfam5xUh875nTnqtl7pc9oAJ/1gv6gtN5o/bfTacKp9EwO75XWgNaic6H9BsX5iiq8CrKnrq4aZ2VQUHwe6mrDjs+nainE5QwgmBFccFfJdNr8lGv+s0Wuif4AfJAKhwW5Bd+r+pL9llTBm8ZV0NgGMBStvNSHY4R7iG8q8FhXFg+nDH0xEk0LSKjuDX6c8RVISKZKV2I9TAVPXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH0PR11MB5207.namprd11.prod.outlook.com (2603:10b6:510:32::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 17:00:31 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec%7]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 17:00:31 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "david@redhat.com" <david@redhat.com>,
        "rppt@kernel.org" <rppt@kernel.org>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "bp@alien8.de" <bp@alien8.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "jannh@google.com" <jannh@google.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 02/42] mm: Move pte/pmd_mkwrite() callers with no VMA
 to _novma()
Thread-Topic: [PATCH v9 02/42] mm: Move pte/pmd_mkwrite() callers with no VMA
 to _novma()
Thread-Index: AQHZnYu5myZdSN5guk62QnYDURPfWq+IWqsAgACP+gCAAAtSgIABkmQA
Date:   Wed, 14 Jun 2023 17:00:31 +0000
Message-ID: <c4b156249e929d8b38e96df9cc123a433e65d6e0.camel@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
         <20230613001108.3040476-3-rick.p.edgecombe@intel.com>
         <20230613074428.GS52412@kernel.org>
         <21b0342854b067c241206f422bc5b3254b43c7f5.camel@intel.com>
         <8a053da2-0f26-82ca-f437-9b9de11d4584@redhat.com>
In-Reply-To: <8a053da2-0f26-82ca-f437-9b9de11d4584@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH0PR11MB5207:EE_
x-ms-office365-filtering-correlation-id: 5cd5210a-16a4-43b9-323e-08db6cf8dcb5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kIHGgA+rB1wKPeA/nkWGr7eohUaS+G2Es6UN8mXzmrcyKc/VQbrwhha5iqwmPfwcsHb19dHODNUy7ewUX5mveoszhKK/8N/6lVBrROcrN2OCFEgZ1GocLSNlBiUBy4wJn9WK6RIW9RVi7EqM8mYe32hs6L1WQpVleZl00pdSVMFJWARg5592UEiPUQ1Memp0TBEi9WiOZZ0fMmFrmtjRGjyCK4n6uIlSa+y7nXQ0zPT+/FjTo4VFLSFQZ1kHD8mDazKbL0FXlphHT12HjPTPFliKR+Px77r9xdXqziOC3LDift0hTWqVfwUOOKL5KWGgh/uhME76WDE1gdSF38AVc0vrp3MkQuWKm2HhEWwS/JKZqAysgxTzvPs6IBBeHnEaFw/Sx96t+rR5P/orY4L2MT7uqsFgJ0176kpuEfn/D0VhONOcsgg9WabBC1PSHMlT/y/hjXKTvsyRQF0tKDbbpmU3wDq5SsufYs1RfmZeLxubvvSOVu2b+iZD9OLjzWZ65Dhb4JZZnnvKWqNn8Vpkc7itANJzTM7SoBj+Vugorqu3Cx0pylHI/DW293MCswff3YMIYMCicRiabieu++zRyoGGXRQHvTqWwFsneg6iHyoKbG8WWt7nKK09XR6gniQ7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199021)(8936002)(6486002)(26005)(8676002)(6512007)(41300700001)(38100700002)(478600001)(82960400001)(36756003)(71200400001)(66946007)(66446008)(64756008)(4326008)(76116006)(66556008)(66476007)(86362001)(91956017)(316002)(122000001)(110136005)(54906003)(38070700005)(53546011)(6506007)(5660300002)(83380400001)(186003)(7406005)(2616005)(7416002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDlHMHdOaFl5d1VQUTg2NFBkallIa2x6UjB3Y1A2aHEvcFFOOVFIVC9ocnFW?=
 =?utf-8?B?M0hrclhneUQrdEczamNxUU9IWWV2cGtDTDlGZ1l3RjRUNzBYRno1VEp5SnM5?=
 =?utf-8?B?SUVlcnhtRjdpd01XNnZuNUUxaGJSVjdZZHMzMlNNTDMyaENOeENwTkszUmNI?=
 =?utf-8?B?a2gveHhleVJoUDJxOG81S2ovZUFRb0FLUG5FOWs2RXNLd2dqMHVZeGx5WXYr?=
 =?utf-8?B?ekQyUURJRFlNa2NWSTJzQlNkV3Vybm9ydzFuamJZaGdxWWNiS2VZWWM1MXZ0?=
 =?utf-8?B?SHhUc2J4ODdSVHdTbGRDRmc2R3FoZmdQL0NpdGVLNjdhVzl3U2RxY1JETE1q?=
 =?utf-8?B?T3dSbVpLWnVPSXhCZ0xUZUZOcUZBd3lGWENkclNZNzhNTWQyU1JYQ1N5K2Vz?=
 =?utf-8?B?cTc4UklIQkZBOVdMQ1FiUVg5VkpZZEJFRkwxV0FNTUdOTitlNDZ6UVNvNXA2?=
 =?utf-8?B?RGk2dnY3OW90UGxoZzZ1YUtPQ0g5b3NXOEFWeFRRWTFFcXRqeVJtaWl2TFlX?=
 =?utf-8?B?NDhuN2pSMU92Q2RxS0h3aS9Ld3dqNDhCdEFBTzN3ME03aklsWGxMQW8zcTdR?=
 =?utf-8?B?eE1hWmNhazJyQ21YSkVxS0lyQkZEYTlWbHViSG5oSDJoKzMycUhHK3IxQnBD?=
 =?utf-8?B?Wkh5REtaTTYyUjdMQmRQbEpQNjZ0bFZnc1BPY3hDWC9Ud3lNMVFHRkN6bVU1?=
 =?utf-8?B?dFpwUTk0MGo4UGRpVk1iMTArL2hvM1dIdWNyL1FPSlFoYzN2Wm5ncWdVNXAz?=
 =?utf-8?B?MG9mbWlZVnJUTnFteVM0aWoyZ0RnTE1PeitPMU5USHl2ZEt3YlhHMGt0N2NO?=
 =?utf-8?B?TTVlT05aMHcwY2hXTGF4dmx3MTFSaXdaWXFPTmN5SUQwWGVRRWJIQitoNFBF?=
 =?utf-8?B?Njlsd2s5eWRXM1JrSVZ0UnJrUG9jczhIL1RXelBDTktuNDJBdERmdkZHQUgz?=
 =?utf-8?B?M2lKOENRZEk5djN2aU9xdHY3cnYvVHpJcCtFb1daM3RhdW5HckltN1g0RDFN?=
 =?utf-8?B?Q2VacnJRR243cUMwUnBVa0FlMmpXSVl5MVpYWVh6SXNNUG51NVV2eGowd0l1?=
 =?utf-8?B?SVh3MU4vYS9nWmtWdFFEN1ZCSnpwQkpQL28xc29VYU5md2k2aTk1dXc4bVND?=
 =?utf-8?B?OXNDWm9GSit2OHoyMk1ka3hVb2lqcUtiNTMzOUtoMXJPbFRKY1dtQUtxcC9N?=
 =?utf-8?B?SGpyVHVuSGlOV09IU2M3aUZyWUxSTHJFMkVoczlqem1Bak50ekUxczhPYnRT?=
 =?utf-8?B?ZTNwejZrUzhsV3VBMFZVYjRFRklpQk93OTZHbElNM0hHZE91MzZJTStHL0VI?=
 =?utf-8?B?bk5HR040MjRUWDMwdHpuTzNTVVJacnNEWTFsaC9sbmRScnhLbEFjQUZTcFRs?=
 =?utf-8?B?UWo1bm1XU3lnemg2Z1ZabW0wMFpLMEZJV0ZRNXl4QVJJQzU3Q1VsY0RqMUhL?=
 =?utf-8?B?bUhNdkdhTGF3bklIdVdtcHlRenMwclBSRUhURllyKzA2SUVXZ0szeWg3bWcr?=
 =?utf-8?B?N2hsLzNnK1pGMGdHdHkzajg2YU12dTJ4T0FZbFd5YnpzNmREZ0lyZ2M3c3Ry?=
 =?utf-8?B?M3RqdFI0eTVFSzFnd29jbnJIelc3SCtMbmlXTDhPakt0MDludm0zZDhMNmdk?=
 =?utf-8?B?OGdsNlJqUWtEbjZGT1I5SnlWTXkwN0dIcWtxdlNXa2RERnljdGRNYVYxZjF0?=
 =?utf-8?B?NjErbkV2Z0o1aFkzdkJqM2VUbkR2L1dEZURtTlNJRWQwZ1lSeE4vUTE1clRa?=
 =?utf-8?B?Q1Jnd1F4NERnbE9lMTNKUSthRjd3TnhDQWZ0K0dFcTJ2d25seDhsbWxRSXZP?=
 =?utf-8?B?WklSTlFEMDVLWDM4UDE0c2lSQjIrZkIvTklMQXIrTUowVkVIVWJjRDAxckRp?=
 =?utf-8?B?dVY0OFhxaUpKNXhtTVNPelQyOTA5U010Y0xGaEZDc3YzWisxQkw5VktEV0pq?=
 =?utf-8?B?K1lUZHFNZG5WbEZaa21HY2E3ZFFOS3o4OFovQ3ZrNG52a21qMnp2anVFUFpE?=
 =?utf-8?B?UXBmTGVNN25tZGFpWjJucTBLR3lIa0J2OXFBZzJxYmI3VHNiQVhPc2kreWJB?=
 =?utf-8?B?Q0IvMnVhbUFtVEVhWXVtQ0FlVUxuZXhCTzZyNm9LbVUyY2ZLQnVPZXJPUEYy?=
 =?utf-8?B?aFluUHduczd5OUhsclQvWFhGaXFKL3IwRWZabloydWdMNHF4RFQzbGpTOG9l?=
 =?utf-8?B?VkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C01EF7287C0C04C9E6A50CA31372C82@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd5210a-16a4-43b9-323e-08db6cf8dcb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 17:00:31.3410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qgdVmBo35mMKF068hpYjqWbMJNuGTEBs6C68aT8vOWZnvRgzxW/ZwIBl1VnvEVHvLg0pbze25SZ++AJqEDZgMLKjVABYTblTjsXsxsTap0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5207
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIzLTA2LTEzIGF0IDE5OjAwICswMjAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4gT24gMTMuMDYuMjMgMTg6MTksIEVkZ2Vjb21iZSwgUmljayBQIHdyb3RlOg0KPiA+IE9u
IFR1ZSwgMjAyMy0wNi0xMyBhdCAxMDo0NCArMDMwMCwgTWlrZSBSYXBvcG9ydCB3cm90ZToNCj4g
PiA+ID4gUHJldmlvdXMgcGF0Y2hlcyBoYXZlIGRvbmUgdGhlIGZpcnN0IHN0ZXAsIHNvIG5leHQg
bW92ZSB0aGUNCj4gPiA+ID4gY2FsbGVycw0KPiA+ID4gPiB0aGF0DQo+ID4gPiA+IGRvbid0IGhh
dmUgYSBWTUEgdG8gcHRlX21rd3JpdGVfbm92bWEoKS4gQWxzbyBkbyB0aGUgc2FtZSBmb3INCj4g
PiA+IA0KPiA+ID4gSSBoZWFyIHg4NiBtYWludGFpbmVycyBhc2tpbmcgdG8gZHJvcCAicHJldmlv
dXMgcGF0Y2hlcyIgOy0pDQo+ID4gPiANCj4gPiA+IE1heWJlDQo+ID4gPiBUaGlzIGlzIHRoZSBz
ZWNvbmQgc3RlcCBvZiB0aGUgY29udmVyc2lvbiB0aGF0IG1vdmVzIHRoZSBjYWxsZXJzDQo+ID4g
PiAuLi4NCj4gPiANCj4gPiBSZWFsbHk/IEkndmUgbm90IGhlYXJkIHRoYXQuIEp1c3QgYSBzdHJv
bmcgYXZlcnNpb24gdG8gInRoaXMNCj4gPiBwYXRjaCIuDQo+ID4gSSd2ZSBnb3QgZmVlZGJhY2sg
dG8gc2F5ICJwcmV2aW91cyBwYXRjaGVzIiBhbmQgbm90ICJ0aGUgbGFzdA0KPiA+IHBhdGNoIiBz
bw0KPiA+IGl0IGRvZXNuJ3QgZ2V0IHN0YWxlLiBJIGd1ZXNzIGl0IGNvdWxkIGJlICJwcmV2aW91
cyBjaGFuZ2VzIi4NCj4gDQo+IFRhbGtpbmcgYWJvdXQgcGF0Y2hlcyBtYWtlIHNlbnNlIHdoZW4g
ZGlzY3Vzc2luZyBsaXRlcmFsIHBhdGNoZXMgc2VudA0KPiB0byANCj4gdGhlIG1haWxpbmcgbGlz
dC4gSW4gdGhlIGdpdCBsb2csIGl0J3MgY29tbWl0LCBhbmQgImZ1dHVyZSBjb21taXRzIg0KPiBv
ciANCj4gImZvbGxvdy11cCB3b3JrIi4NCj4gDQo+IFllcywgd2UgdXNlICJwYXRjaGVzIiBhbGwg
b2YgdGhlIHRpbWUgaW4gY29tbWl0IGxvZ3MsIGVzcGVjaWFsbHkgd2hlbg0KPiB3ZSANCj4gwqAg
aW5jbHVkZSB0aGUgY292ZXIgbGV0dGVyIGluIHRoZSBjb21taXQgbWVzc2FnZSAoYXMgZG9uZSBm
cmVxdWVudGx5DQo+IGluIA0KPiB0aGUgLW1tIHRyZWUpLg0KDQpJIHRoaW5rIEknbGwgc3dpdGNo
IG92ZXIgdG8gdGFsa2luZyBhYm91dCAiY2hhbmdlcyIuIElmIHlvdSB0YWxrIGFib3V0DQpjb21t
aXRzIGl0IGRvZXNuJ3QgbWFrZSBhcyBtdWNoIHNlbnNlIHdoZW4gdGhleSBhcmUgc3RpbGwganVz
dCBwYXRjaGVzLg0KVGhhbmtzLg0K
