Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800726B6D99
	for <lists+linux-arch@lfdr.de>; Mon, 13 Mar 2023 03:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjCMCpU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 12 Mar 2023 22:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjCMCpS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Mar 2023 22:45:18 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F2114E9C;
        Sun, 12 Mar 2023 19:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678675514; x=1710211514;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=68Sg+SFJhGhh8NyH3mmZmX8uQoQq3JjwiRk9SYLjztM=;
  b=iVGMe2mdSfOwktgkyZCfIl1hnt6eYltL2xUzsR33iq5vYgVDXpBXW/aN
   +1tNEGXpeuYEEMNsN7nZ5h1dhWP8pdZ0NvnzXlUmD66XglU6QCGDgsxt9
   yOwxI6xLMQBTcNGf3ty9W9aCWr7eQv4BPYmT2MP2cbS2whrPG/f5T3KP+
   /bnSAPrUxEmV+csytrMsaeyIj/yHoSC0CjYXr1oKrowsPE0Pbu8lrDv7J
   dmQ84Ccvp4eNGjj2bCC/AoAHGkDXAMLRGcIQN+Nxs3+lT31k2DJK8vu/p
   HbwECXd8X9v5uBKi/HUuuwfixED6glAk4+P3681leP3t6LnaWfuilHitk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="334519924"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="334519924"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 19:45:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="852595125"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="852595125"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 12 Mar 2023 19:45:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 12 Mar 2023 19:45:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sun, 12 Mar 2023 19:45:12 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Sun, 12 Mar 2023 19:45:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fcr9/KF/M7ulV42r53X+lKP7f6UKau9u83QZR0i5Uu9fvGR4mACmeJfEu6gcCphSLmdq02vKMXCmniE9skcTHrcMAHrTLOD/eK1mDZk11XcvCTGRD6apa9lS8qLWZ39ZRGEJY/A063YTf1nOASoKbJs36GidCTO2Xp/eS8acApP/4evNiTFDN1aZ2PCf3evkcAHeiXeIgvvNoTqRNgwSeEXjEOiw3+EqgQJ7yXfdOzGFVcq3Utcu8nTULDMZnmaveYqIbXWoK8nBtq8o12nkZ3EvYVCaN+ANVFXeKhn8z9m2sk3QA1K5DEZ3oAtXw/9+m4GDcsWIud6AS4sGlUE6DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68Sg+SFJhGhh8NyH3mmZmX8uQoQq3JjwiRk9SYLjztM=;
 b=JLgT05sK0WlvJ+GV3iOcl41qyNAQlkII1WLUh1c0sTafFJ1K7T8I8pyYRafl96ZHAQmMTX+OU8RpehJkVoCXNsnXyNQ+o6Ax7ZYQ8AOxzQIgkrPjvX+FqxsJXbvMTOjW6TdM2CxlZ2jweXavHrnVTvnec1dBTC5mcsS8GZj3F1Dae6pkGWikm+Xsc6J78Vimxb1azenF4hQZtqGz2kbkLzmphzZ3uAdvHeHmqg0Wcu7zB0QCkZXzzWKK3FzpOosU0BqyygSJfTin6gvLkaBlZh3k/2shmQ7uJ0pCERkIOPXIhRp0ix737sFJa0s/onEn3kI6boSGA4XfaTSGk3UQsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MW6PR11MB8389.namprd11.prod.outlook.com (2603:10b6:303:23d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 02:45:09 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 02:45:09 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "david@redhat.com" <david@redhat.com>,
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
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v7 38/41] x86/fpu: Add helper for initing features
Thread-Topic: [PATCH v7 38/41] x86/fpu: Add helper for initing features
Thread-Index: AQHZSvtH//l8GkMHSEuT277fH1R14q71m1QAgAJ6WAA=
Date:   Mon, 13 Mar 2023 02:45:08 +0000
Message-ID: <3385eaf888f4178607ce4621ae2103d08ba79994.camel@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
         <20230227222957.24501-39-rick.p.edgecombe@intel.com>
         <ZAx6Egh6U5SCZEby@zn.tnic>
In-Reply-To: <ZAx6Egh6U5SCZEby@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MW6PR11MB8389:EE_
x-ms-office365-filtering-correlation-id: 7015017f-7c52-4ae4-229f-08db236cf578
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pdMz2Knjy1DJEgX8/GzJTz9P/4VsKasYpX5aKlyHxWhLANWF9INbk76KOs8WCsmYg93AiTT93mApt9jyI1tJJrwlc3MFgubyW8hlUU+kYT4CY/ICJHFBnJQpVgsouainhxyXnIy1wGFCv/ElQq/G5oMDvBkiGqnVI8j8/N+krC54D1NTBetucs7l/UfgkN7GOUoGrp5VSWzS2xnbqHAURYpIARvYVxrpj+0h6rjSbA8H2VLGlnGARLjG0vBFopyIuFZETyvi2koIy0Zgqp0TqKeMlbBZNh3Z+ZlDTbcxLldaUX0Zn/bQncgLqKnhK9vWxYso8AK5y6XrqU4oOJ5l09mMuSGk0Ic4H3kM17RyVJNt2TZBhMZx2g+Q75LylDHdNpX2x0hcFhLXQWujv5zzfiph/CHNN9NLI0Gzc5s/zlUQlLNtQmfH40OwAcX0sObJaQ4BO+sLdbc7UNfPBGtBoMdqprLpS9whBiDBB9mL5ExFR7zRWZBZ3+yWlelj2/ZxmN1/xvzgj4A2y9h3t30ZImGotg2JwHaQoCm13UdCGX4aIQWrQtIzIz01Q7Jov5FX7zDaif5Vu5EPSbzj5BKe1e+JFYNuyzedOwTBLa5l0t6YxUD1tKYU4Uy92NoktM0IkvYp0dXmr4Rea4dBaTt5Tjkcngdfgq/pQOyUwta/RurCjd+nFtFeqiIp6v7hww9550DDukpeP9Xxo5uHTgOeyCR/s/7UtIZSSJ1lmqp8zTo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199018)(6506007)(6512007)(91956017)(54906003)(316002)(41300700001)(66476007)(66446008)(4326008)(64756008)(8676002)(6916009)(66946007)(66556008)(186003)(2616005)(26005)(6486002)(76116006)(478600001)(83380400001)(71200400001)(38070700005)(36756003)(38100700002)(86362001)(82960400001)(2906002)(122000001)(8936002)(5660300002)(7416002)(7406005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXhZa21vbVd3c3VrTjBxWithdTVDZUZwellUazk4QmdXYWdFM29HRVEyd2Fa?=
 =?utf-8?B?ZGFtZm8xNVI2KzQwNXNLRXpPN1E1M3EwVDV0eTJ3OXlkOVVaNURZdDNuYnFR?=
 =?utf-8?B?c0dGbU55NEVsRVdiNHZOYnR2SEJ3WE4zS1NpenFEL0pzOXJ4Mi9lcko4QWpB?=
 =?utf-8?B?Sk1zK01aOXFGZE44cXV2czcrcWRnMFhCbkFDc0pBRTNXT0hZU1gyY2RuSy9x?=
 =?utf-8?B?K1NKMnhlYnl5Q3hlMFNoNXFGbk9wQkttMDBHQzNtampsMjc0TFZJVm9iNlhx?=
 =?utf-8?B?WUJWRnI4ZkZEWDZHbHF3TFpzSFNJdk9CL25NdWM4VnNxakdXcFFFSWZPVlJ2?=
 =?utf-8?B?YU9BN1hBeU1yQWllVGhOY1I0SUlmUzU3THdKeGRwdkJWdkV5OHA3QXJTbUlS?=
 =?utf-8?B?SUpFUXdNQjhWdWVDZk8rbC93aEIvcU9tTkRLT3JsVVl5SWIyMFE3WUdiWmg2?=
 =?utf-8?B?M21iZVU1Y1Y3NTdVMEtOZ0IrcG5PREtMNUdVZHpHYnB4NFpJcngyWHVsNFJ3?=
 =?utf-8?B?dGNuMG94cFMrancwRDNoK1NSbDhYa3lwZ0xJVU5nMG05Ym4rdElZODlwM0Iy?=
 =?utf-8?B?QkRDMGpjTGRVdDJhZFIzR01QMG1TY2E1TXBmc3VZWE9raHFQaUpEL2Y4Slpn?=
 =?utf-8?B?UkUwa2ZNZFU1a2RtN0YzNUxKam5EVXVtRGtRalNQVGlYMzc2QnI3MDBKb3kx?=
 =?utf-8?B?dWVBbERZRzRJZDNheTlWUlp0a1BmNkl0ZW9obDMrUitXUnJ2b3JSUXpvemF5?=
 =?utf-8?B?WCs1ZDJGc3NFM253SmlpUjdJZkQwaU9meEJYT0prMk9CbXFVRytDbTI5c0M3?=
 =?utf-8?B?ZDY0SEk1Y0psRjRaZldEV1hPMUVRSkJDeUlFZEh5MGJsK0M0WWsydlNzNEN2?=
 =?utf-8?B?cXQrK1RGZVRadE5mcWRuaHV1dHlMcUcwQWJRMW0xL2RsYzFmY2E5djBOTlVJ?=
 =?utf-8?B?N2dDTnFSMFlmVHJtWjNXVnlPR21PN3lKMmVRU3hMcGRWZ1QwM25WenRhS3JG?=
 =?utf-8?B?MHRCdUFidnNVemtOdURIN0U5UFJ1RG1UUWJ1VGFLOXl4SDlaSVl4dDNqR3Ar?=
 =?utf-8?B?dXVONkZGbTlJMGhnMDZuZ2hLKzhBQ3BTOHVqNVVsb1lJYmFqTXdnRG1JY1Yr?=
 =?utf-8?B?MGlxY3NYZkhjR0VkN1N4QmVyakRSTWI0d0ZOK2JaRjRnZDI0VVdEa1lFSDNy?=
 =?utf-8?B?NGIwWmtkN2wyWnZFSnlvcU4yRFJjUlNUUHh0UTd6dzFjWFhtWGFyU09FVyto?=
 =?utf-8?B?QWdBTE5nVXFNaTB5eDluNldTNXZYd0NGVTFsRDI1QVhNNkE2YjRGdlFFODVF?=
 =?utf-8?B?emFjeDU5bXdqbG5VMUZxckFFMGJXcnFkajNlYVM3RFJ4OUt5OTdRMGNOdEV4?=
 =?utf-8?B?cjJqcCswVFR2M2NQNk0yNElXKzRVbkQ3N1BidlRYTm15MjhLYXozY29ndWFC?=
 =?utf-8?B?TzBMOHNSNTEzTHRoemJLNDM1ZVB1Z0ZieVJJVk91MDN0NVJDMDlYVDdZSnls?=
 =?utf-8?B?Qi9rTUl5VVNFdHF6S2dDVlZ4ZnJKVHliSDZmTWdCZHFwM0VxbEJXaVpNT0Na?=
 =?utf-8?B?N3Z3Y0o2WmdibTR3ZHdvZTRaRDNPWWxtc1pPdDN3R2VsNkJEV3JZV3gxekYr?=
 =?utf-8?B?TEYwbmdNNmZXTU1OVFJpN2VKdE82QUg1dk5iVkhWS1ZMQzBFaTJvSUh1Rlg0?=
 =?utf-8?B?WUxsbzYra3Z2aXVKK1czazhJYzcwZDBNdno2Z0tXRDlGZkJpMS82N2lvZTdS?=
 =?utf-8?B?TmJleGx4TFN4N3h6ZWpoS1NCcmNPU1NieWFlUi9mUDBtbS9ZWE1xVlVlNXRV?=
 =?utf-8?B?LzBPdHBHeU45WGlCVERjNkZDMW02K3NJMGRaU1o0MnRXSWd0Z05qUEdDS01u?=
 =?utf-8?B?Ny9TYk9IMzdRSURtOEVqVG5uWUMxRUZuUm5Pb0JrMzdoQ3pidjdzL0RLc1lz?=
 =?utf-8?B?SDZma2E0c1NXbFhIaDl1MHo5Q3NyY3p1VjNmQUpwRnRGNTlnYVBPSlQxZXd6?=
 =?utf-8?B?ZTJ2YVk4YVhDckE3SzJRczJDeVE5R2l1eTFyOUd5MjJZaGFMb1RMbVVJb2oy?=
 =?utf-8?B?VmVUcXB2cThNclF2b0xjOHdwUUpGb0NUUmI5ZXVUS1NNeEdVcVJ3NDNWQ0xU?=
 =?utf-8?B?OTlxNHVsdmZ1MmxxeW5nL1RWcGF1ZktEN0dvdUZhT0g0OHIvSHNZVXhHV2R2?=
 =?utf-8?Q?R/kU8Q7PvkDiEi15ClWvcFc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <545063BA47BB784BAB2197121F41FFC5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7015017f-7c52-4ae4-229f-08db236cf578
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 02:45:08.4319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ArTXJhkGqKLC6U8i7hrzmYooUEe5dq17h4dUqIQvkm3yEWi7IVyAhPKrpEpP/KU0CIAndOvLGjD2PsvkRnfBopeFO5QAbSdkLvr13xDe/Xo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8389
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gU2F0LCAyMDIzLTAzLTExIGF0IDEzOjU0ICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIE1vbiwgRmViIDI3LCAyMDIzIGF0IDAyOjI5OjU0UE0gLTA4MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMzgvNDFdIHg4Ni9mcHU6IEFk
ZCBoZWxwZXIgZm9yIGluaXRpbmcNCj4gPiBmZWF0dXJlcw0KPiANCj4gImluaXRpYWxpemluZyIN
Cg0KU3VyZS4NCg0KPiANCj4gPiBJZiBhbiB4ZmVhdHVyZSBpcyBzYXZlZCBpbiBhIGJ1ZmZlciwg
dGhlIHhmZWF0dXJlJ3MgYml0IHdpbGwgYmUgc2V0DQo+ID4gaW4NCj4gPiB4c2F2ZS0+aGVhZGVy
LnhmZWF0dXJlcy4gVGhlIENQVSBtYXkgb3B0IHRvIG5vdCBzYXZlIHRoZSB4ZmVhdHVyZQ0KPiA+
IGlmIGl0DQo+ID4gaXMgaW4gaXQncyBpbml0IHN0YXRlLiBJbiB0aGlzIGNhc2UgdGhlIHhmZWF0
dXJlIGJ1ZmZlciBhZGRyZXNzDQo+ID4gY2Fubm90DQo+IA0KPiAiaXRzIg0KDQpJIGNsZWFybHkg
bmVlZCB0byBiZSBiZXR0ZXIgYWJvdXQgaXQncyBhbmQgaXRzLg0KDQo+IA0KPiA+IGJlIHJldHJp
ZXZlZCB3aXRoIGdldF94c2F2ZV9hZGRyKCkuDQo+ID4gDQo+ID4gRnV0dXJlIHBhdGNoZXMgd2ls
bCBuZWVkIHRvIGhhbmRsZSB0aGUgY2FzZSBvZiB3cml0aW5nIHRvIGFuDQo+ID4geGZlYXR1cmUN
Cj4gPiB0aGF0IG1heSBub3QgYmUgc2F2ZWQuIFNvIHByb3ZpZGUgaGVscGVycyB0byBpbml0IGFu
IHhmZWF0dXJlIGluIGFuDQo+ID4geHNhdmUgYnVmZmVyLg0KPiA+IA0KPiA+IFRoaXMgY291bGQg
b2YgY291cnNlIGJlIGRvbmUgZGlyZWN0bHkgYnkgcmVhY2hpbmcgaW50byB0aGUgeHNhdmUNCj4g
PiBidWZmZXIsDQo+ID4gaG93ZXZlciB0aGlzIHdvdWxkIG5vdCBiZSByb2J1c3QgYWdhaW5zdCBm
dXR1cmUgY2hhbmdlcyB0byBvcHRpbWl6ZQ0KPiA+IHRoZQ0KPiA+IHhzYXZlIGJ1ZmZlciBieSBj
b21wYWN0aW5nIGl0LiBJbiB0aGF0IGNhc2UgdGhlIHhzYXZlIGJ1ZmZlciB3b3VsZA0KPiA+IG5l
ZWQNCj4gPiB0byBiZSByZS1hcnJhbmdlZCBhcyB3ZWxsLiBTbyB0aGUgbG9naWMgcHJvcGVybHkg
YmVsb25ncw0KPiA+IGVuY2Fwc3VsYXRlZA0KPiA+IGluIGEgaGVscGVyIHdoZXJlIHRoZSBsb2dp
YyBjYW4gYmUgdW5pZmllZC4NCj4gPiANCj4gPiBUZXN0ZWQtYnk6IFBlbmdmZWkgWHUgPHBlbmdm
ZWkueHVAaW50ZWwuY29tPg0KPiA+IFRlc3RlZC1ieTogSm9obiBBbGxlbiA8am9obi5hbGxlbkBh
bWQuY29tPg0KPiA+IFRlc3RlZC1ieTogS2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5vcmc+
DQo+ID4gQWNrZWQtYnk6IE1pa2UgUmFwb3BvcnQgKElCTSkgPHJwcHRAa2VybmVsLm9yZz4NCj4g
PiBSZXZpZXdlZC1ieTogS2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5vcmc+DQo+ID4gU2ln
bmVkLW9mZi1ieTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0K
PiA+IA0KPiA+IC0tLQ0KPiA+IHYyOg0KPiA+ICAtIE5ldyBwYXRjaA0KPiA+IC0tLQ0KPiA+ICBh
cmNoL3g4Ni9rZXJuZWwvZnB1L3hzdGF0ZS5jIHwgNTggKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystLS0NCj4gPiAtLS0tDQo+ID4gIGFyY2gveDg2L2tlcm5lbC9mcHUveHN0YXRlLmggfCAg
NiArKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNTMgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRp
b25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9mcHUveHN0YXRl
LmMNCj4gPiBiL2FyY2gveDg2L2tlcm5lbC9mcHUveHN0YXRlLmMNCj4gPiBpbmRleCAxM2E4MDUy
MWRkNTEuLjNmZjgwYmUwYTQ0MSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvZnB1
L3hzdGF0ZS5jDQo+ID4gKysrIGIvYXJjaC94ODYva2VybmVsL2ZwdS94c3RhdGUuYw0KPiA+IEBA
IC05MzQsNiArOTM0LDI0IEBAIHN0YXRpYyB2b2lkICpfX3Jhd194c2F2ZV9hZGRyKHN0cnVjdA0K
PiA+IHhyZWdzX3N0YXRlICp4c2F2ZSwgaW50IHhmZWF0dXJlX25yKQ0KPiA+ICAJcmV0dXJuICh2
b2lkICopeHNhdmUgKyB4ZmVhdHVyZV9nZXRfb2Zmc2V0KHhjb21wX2J2LA0KPiA+IHhmZWF0dXJl
X25yKTsNCj4gPiAgfQ0KPiA+ICANCj4gPiArc3RhdGljIGludCB4c2F2ZV9idWZmZXJfYWNjZXNz
X2NoZWNrcyhpbnQgeGZlYXR1cmVfbnIpDQo+IA0KPiBGdW5jdGlvbiBuYW1lIG5lZWRzIGEgdmVy
Yi4NCg0KUmlnaHQuDQoNCj4gDQo+ID4gK3sNCj4gPiArCS8qDQo+ID4gKwkgKiBEbyB3ZSBldmVu
ICpoYXZlKiB4c2F2ZSBzdGF0ZT8NCj4gPiArCSAqLw0KPiANCj4gVGhhdCBjb21tZW50IGlzIHN1
cGVyZmx1b3VzLg0KPiANCj4gPiArCWlmICghYm9vdF9jcHVfaGFzKFg4Nl9GRUFUVVJFX1hTQVZF
KSkNCj4gDQo+IGNoZWNrX2Zvcl9kZXByZWNhdGVkX2FwaXM6IFdBUk5JTkc6IGFyY2gveDg2L2tl
cm5lbC9mcHUveHN0YXRlLmM6OTQyOg0KPiBEbyBub3QgdXNlIGJvb3RfY3B1X2hhcygpIC0gdXNl
IGNwdV9mZWF0dXJlX2VuYWJsZWQoKSBpbnN0ZWFkLg0KPiANCj4gPiArCQlyZXR1cm4gMTsNCj4g
PiArDQo+ID4gKwkvKg0KPiA+ICsJICogV2Ugc2hvdWxkIG5vdCBldmVyIGJlIHJlcXVlc3Rpbmcg
ZmVhdHVyZXMgdGhhdCB3ZQ0KPiANCj4gUGxlYXNlIHVzZSBwYXNzaXZlIHZvaWNlIGluIHlvdXIg
Y29tbWl0IG1lc3NhZ2U6IG5vICJ3ZSIgb3IgIkkiLCBldGMsDQo+IGFuZCBkZXNjcmliZSB5b3Vy
IGNoYW5nZXMgaW4gaW1wZXJhdGl2ZSBtb29kLg0KDQpUaGVzZSB0d28gYXJlIGZyb20gdGhlIGV4
aXN0aW5nIGNvZGUuIEJhc2ljYWxseSB0aGV5IGdldCBleHRyYWN0ZWQgaW50bw0KYSBuZXcgZnVu
Y3Rpb24uDQoNCj4gDQo+ID4gKwkgKiBoYXZlIG5vdCBlbmFibGVkLg0KPiA+ICsJICovDQo+ID4g
KwlpZiAoV0FSTl9PTl9PTkNFKCF4ZmVhdHVyZV9lbmFibGVkKHhmZWF0dXJlX25yKSkpDQo+ID4g
KwkJcmV0dXJuIDE7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4g
IC8qDQo+ID4gICAqIEdpdmVuIHRoZSB4c2F2ZSBhcmVhIGFuZCBhIHN0YXRlIGluc2lkZSwgdGhp
cyBmdW5jdGlvbiByZXR1cm5zDQo+ID4gdGhlDQo+ID4gICAqIGFkZHJlc3Mgb2YgdGhlIHN0YXRl
Lg0KPiA+IEBAIC05NTQsMTcgKzk3Miw3IEBAIHN0YXRpYyB2b2lkICpfX3Jhd194c2F2ZV9hZGRy
KHN0cnVjdA0KPiA+IHhyZWdzX3N0YXRlICp4c2F2ZSwgaW50IHhmZWF0dXJlX25yKQ0KPiA+ICAg
Ki8NCj4gPiAgdm9pZCAqZ2V0X3hzYXZlX2FkZHIoc3RydWN0IHhyZWdzX3N0YXRlICp4c2F2ZSwg
aW50IHhmZWF0dXJlX25yKQ0KPiA+ICB7DQo+ID4gLQkvKg0KPiA+IC0JICogRG8gd2UgZXZlbiAq
aGF2ZSogeHNhdmUgc3RhdGU/DQo+ID4gLQkgKi8NCj4gPiAtCWlmICghYm9vdF9jcHVfaGFzKFg4
Nl9GRUFUVVJFX1hTQVZFKSkNCj4gPiAtCQlyZXR1cm4gTlVMTDsNCj4gPiAtDQo+ID4gLQkvKg0K
PiA+IC0JICogV2Ugc2hvdWxkIG5vdCBldmVyIGJlIHJlcXVlc3RpbmcgZmVhdHVyZXMgdGhhdCB3
ZQ0KPiA+IC0JICogaGF2ZSBub3QgZW5hYmxlZC4NCj4gPiAtCSAqLw0KPiA+IC0JaWYgKFdBUk5f
T05fT05DRSgheGZlYXR1cmVfZW5hYmxlZCh4ZmVhdHVyZV9ucikpKQ0KPiA+ICsJaWYgKHhzYXZl
X2J1ZmZlcl9hY2Nlc3NfY2hlY2tzKHhmZWF0dXJlX25yKSkNCj4gPiAgCQlyZXR1cm4gTlVMTDsN
Cj4gPiAgDQo+ID4gIAkvKg0KPiA+IEBAIC05ODQsNiArOTkyLDM0IEBAIHZvaWQgKmdldF94c2F2
ZV9hZGRyKHN0cnVjdCB4cmVnc19zdGF0ZQ0KPiA+ICp4c2F2ZSwgaW50IHhmZWF0dXJlX25yKQ0K
PiA+ICAJcmV0dXJuIF9fcmF3X3hzYXZlX2FkZHIoeHNhdmUsIHhmZWF0dXJlX25yKTsNCj4gPiAg
fQ0KPiA+ICANCj4gPiArLyoNCj4gPiArICogR2l2ZW4gdGhlIHhzYXZlIGFyZWEgYW5kIGEgc3Rh
dGUgaW5zaWRlLCB0aGlzIGZ1bmN0aW9uDQo+ID4gKyAqIGluaXRpYWxpemVzIGFuIHhmZWF0dXJl
IGluIHRoZSBidWZmZXIuDQo+IA0KPiBzL3RoaXMgZnVuY3Rpb24gaW5pdGlhbGl6ZXMvaW5pdGlh
bGl6ZS8NCg0KU3VyZS4NCg0KPiANCj4gPiArICoNCj4gPiArICogZ2V0X3hzYXZlX2FkZHIoKSB3
aWxsIHJldHVybiBOVUxMIGlmIHRoZSBmZWF0dXJlIGJpdCBpcw0KPiA+ICsgKiBub3QgcHJlc2Vu
dCBpbiB0aGUgaGVhZGVyLiBUaGlzIGZ1bmN0aW9uIHdpbGwgbWFrZSBpdCBzbw0KPiA+ICsgKiB0
aGUgeGZlYXR1cmUgYnVmZmVyIGFkZHJlc3MgaXMgcmVhZHkgdG8gYmUgcmV0cmlldmVkIGJ5DQo+
ID4gKyAqIGdldF94c2F2ZV9hZGRyKCkuDQo+IA0KPiBTbyB1c2VycyBvZiBnZXRfeHNhdmVfYWRk
cigpIHdvdWxkIGhhdmUgdG8ga25vdyB0aGF0IHRoZXkgd291bGQgbmVlZA0KPiB0bw0KPiBjYWxs
IGluaXRfeGZlYXR1cmUoKT8NCg0KVGhhdCBpcyB0aGUgc2l0dWF0aW9uIHRvZGF5LiBGV0lXIGJv
dGggb2YgdGhlc2UgZnVuY3Rpb25zIGFyZSBsaW1pdGVkDQp0byB0aGUgRlBVIGludGVybmFscywg
c28gSSB3b3VsZCB0aGluayBpdCdzIG5vdCBhIHRvbyB1bnJlYXNvbmFibGUNCmFzc3VtcHRpb24u
DQoNCj4gDQo+IEkgdGhpbmsgdGhlIGJldHRlciBhcHByb2FjaCB3b3VsZCBiZToNCj4gDQo+IHZv
aWQgKmdldF94c2F2ZV9hZGRyKHN0cnVjdCB4cmVnc19zdGF0ZSAqeHNhdmUsIGludCB4ZmVhdHVy
ZV9uciwgYm9vbA0KPiBpbml0KQ0KPiANCj4gYW5kIHRoZW4gdGhhdCBAaW5pdCBjb250cm9scyB3
aGV0aGVyIGdldF94c2F2ZV9hZGRyKCkgc2hvdWxkIGluaXQgdGhlDQo+IGJ1ZmZlci4NCj4gDQo+
IEFuZCB0aGVuIHlvdSBkb24ndCBoYXZlIHRvIGhhdmUgYSBidW5jaCBvZiBzbWFsbCBmdW5jdGlv
bnMgaGVyZSBhbmQNCj4gdGhlcmUgYW5kIGtub3cgd2hlbiB0byBjYWxsIHdoYXQgYnV0IGdldF94
c2F2ZV9hZGRyKCkgd291bGQgc2ltcGx5DQo+IERUUlQuDQoNCkl0IHdvdWxkIGhhdmUgdG8gYWN0
dWFsbHkgY29weSB0aGUgaW5pdCBzdGF0ZSB0byB0aGUgYnVmZmVyDQpmcm9tIGluaXRfZnBzdGF0
ZSwgYmVjYXVzZSBvdGhlcndpc2UgdGhlIGNhbGxlciBjb3VsZG4ndCBrbm93IA0KaWYgZ2V0X3hz
YXZlX2FkZHIoKSB3YXMgcmV0dXJuaW5nIHZhbGlkIGRhdGEgb3Igc29tZSBvbGQgZGF0YSBpbiB0
aGUNCmJ1ZmZlci4gQW5kIEkgZ3Vlc3MgdGhlIGBpbml0YCBtZWFuIHRvIGluaXRpYWxpemUgaXQg
b25seSBpZiBpdCBpcyBpbg0KdGhlIGluaXQgc3RhdGUsIG5vdCB0byBvdmVyd3JpdGUgdGhlIGN1
cnJlbnQgc3RhdGUgd2l0aCB0aGUgaW5pdCBzdGF0ZS4NCg0KSSBkaWQgaXQgdXAsIGFuZCBpdCBt
YWtlcyB0aGUgY2FsbGVyIGNvZGUgY2xlYW5lci4gQnV0IEknbSBub3Qgc3VyZQ0Kd2hhdCB0byB0
aGluayBvZiBpdC4gSXMgdGhpcyBub3QgbWl4aW5nIHR3byBvcGVyYXRpb25zIHRvZ2V0aGVyPyBU
b2RheQ0KZ2V0X3hzYXZlX2FkZHIoKSBwcmV0dHkgbXVjaCBqdXN0IGdldHMgYSBidWZmZXIgb2Zm
c2V0IHdpdGggc29tZQ0KY2hlY2tzLiBOb3cgaXQgd291bGQgY29tcHV0ZSB0aGUgb2Zmc2V0IGFu
ZCBhbHNvIHNpbGVudGx5IGdvIG9mZiBhbmQNCmNoYW5nZXMgdGhlIGJ1ZmZlci4NCg0KSSBsb29r
ZWQgYXQgdGhpcyBmcHUgY29kZSBvcmlnaW5hbGx5IGFuZCB0aG91Z2h0IEkgY291bGQgYWRkIHNv
bWUNCnVzZWZ1bCBhYnN0cmFjdGlvbnMsIGJ1dCB0aGlzIGZhaWxlZC4gSSBjYW1lIGF3YXkgd29u
ZGVyaW5nIGlmIHRoaXMgd2FzDQpqdXN0IGFuIGFyZWEgd2l0aCBzbyBtYW55IHNwZWNpYWwgY2Fz
ZXMgYW5kIGRldGFpbHMsIHRoYXQgYWJzdHJhY3Rpb25zDQpqdXN0IGFkZGVkIGNvbmZ1c2lvbi4g
SSdtIGp1c3QgYnJpbmdpbmcgdGhpcyB1cCBiZWNhdXNlIHRoZSBvdGhlcg0Kb3B0aW9uIGlzIHRv
IGp1c3QgZG8gdGhpcyBpbiB0aGUgcmVnc2V0IGNvZGU6DQp4c2F2ZS0+aGVhZGVyLnhmZWF0dXJl
cyB8PSBCSVRfVUxMKFhGRUFUVVJFX0NFVF9VU0VSKTsNCg0KTGV0IG1lIGtub3cgaWYgeW91IHRo
aW5rIGl0IHdvdWxkIGJlIGJldHRlciB0byBqdXN0IG9wZW4gY29kZSBpdC4NCg0KPiANCj4gVGh4
Lg0KPiANCg==
