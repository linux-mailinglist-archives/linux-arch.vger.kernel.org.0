Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CE573D287
	for <lists+linux-arch@lfdr.de>; Sun, 25 Jun 2023 18:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjFYQoq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 25 Jun 2023 12:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjFYQop (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 25 Jun 2023 12:44:45 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374FB194;
        Sun, 25 Jun 2023 09:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687711484; x=1719247484;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4B+yOtwZZPW0SDF5ENJDPtD3v85aPwnzfhm+DqlkZNU=;
  b=dh5eqsCs+Mkieo3twiAuXVXRe5yMBOswyjXB99vhxPyfhTpbO0DfW0W5
   KOK+Ik5dIChEFrUu6MP4m4rtcjL69uSJBp9ewkRxMBq9SwQXx/ebTzD9f
   f1DFIZjlrSWwgPtk9hlOU/uyZlZu2Tw83th0VxlX5E1Gf68LIBPUTeQzf
   LoUhYiwm9dhmHNAoSC3duv2Xxf+z11hBVO90wqKQw5YxFYTOUtJdlfUDa
   sl6FMhPdhobCTVxZ+3OhqYWWPhmgvoyF6YnXdPn4b7+dvECUa4FnGKRVG
   eblFPDkCL2QXaI+X2vwCPEelrFvhbjgZSCtPkDQ11ckpspjtV7cO4eVNQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="345843700"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="345843700"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 09:44:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="1046227179"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="1046227179"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 25 Jun 2023 09:44:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 25 Jun 2023 09:44:41 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 25 Jun 2023 09:44:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 25 Jun 2023 09:44:41 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 25 Jun 2023 09:44:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBmdR8IysLAjT7GX7yXkauMxPH5nvvCylIOivj1apiosFwTUYEL24k2V3r4BIDq0b8EwlwjpmAGT7ycDhKVm5PDJmnb9rXQ5sdSr0Bm8HR1KCIXLa3ooI2wSwBtcAETZb33yubXrefdrOknsidgM3+mYYEclu73q3rimKG+BsZpmKzdTKkXqouMgPBKFiDex6pDnM1SmQrRfNTjivqWMjzIO68RL24oQdSwPlRIYbwVO3vofNk4Tw2kUeFvcmcLgbRK4qwZ4BWYFSyhsqz+jScFar8UwxKhZf8ZJq+Yir/I7OqMCpxfwFVGJbhcroUjThruOue05wS7uk+6QKf/V8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4B+yOtwZZPW0SDF5ENJDPtD3v85aPwnzfhm+DqlkZNU=;
 b=VNWl+j8YWUMUA/JbV7rca+zLiXMR995rFtFvCF9CP9V4Dua8+/sSZpqSQhcDCiOQJ2ewC+pILG50AqxF04w+wFAUc5V26PJoIMdmgW6RMMREE80CP49YcZZKr1FXvWKcIuKDCTQ0HzwIX3EH6Ci9XYa9L0YP0yOC9bIWefDL6K9uYdosR5FkkMorYLt+Kmq8LNTGNctj2f47GF4aAXqxb6DClHJRzH0dVgqfJTdClJO5MilwKKTltnV7zgWcmWUM3DWG90qMKJXTIQ2zujyVkhHZXhYHoR87GeErJLV0R6npgU+gCaRuU/WqLsd5kcr/Z1qjDRTtODz5BzL9RMvLdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH7PR11MB5983.namprd11.prod.outlook.com (2603:10b6:510:1e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Sun, 25 Jun
 2023 16:44:33 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec%7]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 16:44:33 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>
CC:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "jannh@google.com" <jannh@google.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 16/42] mm: Add guard pages around a shadow stack.
Thread-Topic: [PATCH v9 16/42] mm: Add guard pages around a shadow stack.
Thread-Index: AQHZnYvCDMsjzRn1dEqACIu9bb3yrq+XMYOAgAAB2ICAAN1hAIAATYeAgANvSIA=
Date:   Sun, 25 Jun 2023 16:44:32 +0000
Message-ID: <10673dd87c27ea9def60ff841ebd261d31b46568.camel@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
         <20230613001108.3040476-17-rick.p.edgecombe@intel.com>
         <ZJSRD1xZauOW3jFO@casper.infradead.org>
         <ba77d21492e2631072f51328413d227f31dd78ae.camel@intel.com>
         <20230623074000.GG52412@kernel.org>
         <ZJWNWeqQ8ON9NNfs@finisterre.sirena.org.uk>
In-Reply-To: <ZJWNWeqQ8ON9NNfs@finisterre.sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH7PR11MB5983:EE_
x-ms-office365-filtering-correlation-id: 8a701f59-8e9d-4e97-efe0-08db759b73e7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uTMueGTLoTJNxziU3X80MD2YZwgVHN9MMKvXXMX405HUBDV0C4zOPgdD8faCTuHwN59yvscUC5F+cGqs13PLD1z2s4z7mpmWsFjbTKc/R7aLldZoeoDcbO/91/5z1GxcwJlBWZq68kkDRzrt13ppdT0yHsfoNt1QWqWlnmMiQgRUfjIgl04jvMjOdnfE/fO/kP8pk1xdk5+tbis0W8/8UE56FV20N0I7OuCXCl/n1I/iOKowOM8PothbUSIVEE+ZKYh7/hiRZeKInbwFlI7//ZnhsmJkEBHmUG0ENQM3t4iS9M5mmimYrmPyuqsLIDRvTtL4hYcrlUIky18UFlOo4SfLQKMcXNYc1ksD2Xk3Iee6W4WTenCt2rZDQeHcqw34RKRmde2wMwV3a3LuzMz+Nc1kR2jX79ol9fleoeo4DlvyYSgexPYgeDgUkJKmOStOKRpz9CwS0NnbcjUT96XgWovk4pvrhPVRnug2Ek2uvS+bqUjshdxjk5yffQhYRWgpVgu/M05sLCyiyoAAvyB3MLnK+x1v3GnSrvROID8hss0yGWnM9xmFvC7BBmLhuttj9OwnrEdBsY8bXQSK2nBdG6W7ZcLac+dTNEvuPdhwLek=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199021)(66446008)(36756003)(5660300002)(7406005)(7416002)(64756008)(8936002)(8676002)(41300700001)(86362001)(38070700005)(66556008)(66476007)(76116006)(91956017)(4326008)(38100700002)(122000001)(316002)(66946007)(82960400001)(966005)(6506007)(26005)(6512007)(2906002)(186003)(71200400001)(2616005)(478600001)(54906003)(83380400001)(110136005)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azJyKzZqbkZJK2wwNjNSU0drTlhLZk1FazdYbjAzLzU4MHNwWXZVNm85akxr?=
 =?utf-8?B?U0JROTdVbFVraVdGQ3lqWmFIa0ZaOE5xcjBDUVljaHFnRmNxeUJGNDJIaUpP?=
 =?utf-8?B?SWdUWEVOdWhIK2VXY3ltcmZSbktrcUVkZmQzR0VTSTlUT1NZMnNBRUZ3YVd1?=
 =?utf-8?B?UnIxeUNRRlNXblBORnhXdGY4NWt3dHdBeldveGlYOVhnL2RNMDViUll2eVNK?=
 =?utf-8?B?bW1GbVNHS1VOb1UycDBrY1hTc0pQZitORHhLSDhCQUdDSDRacFB2bnFjMkZ1?=
 =?utf-8?B?ZG0zRUwyQ090R1ZSeFJzanJCajR5bFZ6UkhGK0sxYTQxdlJKeDVLNElBM3Jn?=
 =?utf-8?B?ZitROHFISFROM0dGR21CbktxMmw0YlkzUmY0SEY5aEtIa1pqMkIvOTg1bVo3?=
 =?utf-8?B?bStzczRzN0ljbjE3VG1qSHgwNUY3MzNuckQrc05CRDM3VTFpSUdxcVF1WFF1?=
 =?utf-8?B?azNVZ3JsRGtSaEtyNTA0WmN6dkJYcGFNOE1ib0lNRzBiMGpZQTJMRDdYU1lq?=
 =?utf-8?B?VENEZ3JEam1KNnhrZEdnSy9aY1ZaWkVjelQ1OTBGTFIwWXp3NU9lUnRVV3Bh?=
 =?utf-8?B?b1ZlZVFhQXdEdUJvSGMzK2wzSWF5Mlk5ODZubGk5Y1Z6UDJMMUt4REdOdkRF?=
 =?utf-8?B?ekMyNnBpa0FtaEx0QWQwUzIwcUlGdlBJdlg2c1dYMjd3b2ZwUXFpVmdFSWZ2?=
 =?utf-8?B?cGJtZnV2N1JmMFRGbEpFS2pVTlNUTXJyWkl4VDFwQ1JIeDlQa3JZc0VGYkJ1?=
 =?utf-8?B?UnBFdVhCZlo5OElVeklEKzJQeWUwdHR5NkpuRkFNcnFFQlB4R2pDYVB6TUUw?=
 =?utf-8?B?RXFKSENybXc3TnNMbHFFZXV6Y1Bia3ZBMlFPL0hPa2NTaFRVU2NET2NQUTNJ?=
 =?utf-8?B?bTRhWDgwWHVpejN3bjVlNmxKREhIWHMwbGkyK0h4dlNxZzMwbW5wMkxoQmsz?=
 =?utf-8?B?RU4zWWRlbXZoR0dIT1RsTFcvUGZpaFVmZFlGaHA1SmN0VlF1RStqSTF2V2hr?=
 =?utf-8?B?bmUxWWZ1REt0ZEkvaEo4Y2Q1Q051SEpJWkdpZ2liOWpiWHpZUHVhbTFrT21X?=
 =?utf-8?B?QU9jUlIybzhSWlF0SjlDUDMyNlRIRTZYVENlbXo2ODFOa2U3YkQ1TllrTy8z?=
 =?utf-8?B?Q0M1NHdUaWpERVlqQ2xEaExEbWNxeG9xZDNLNEV3QktBejRlUXM3SDcweHVh?=
 =?utf-8?B?MUZLNCtqbFp4bHZsTlNHNUJNNzdINzVZYkhWWFhla28xYXN4dXBCaDErbnJO?=
 =?utf-8?B?YnVRZkpTVTg1SG95dzZsQUlxOTExb0dGZVUvaSt0MVVFbGdMNEdFbXVaVGRv?=
 =?utf-8?B?QklxbFZwU250N1AvaFNvTjJFWnJIaEk3VmpqY1U1emRXMFdFNFJuZkZrczNE?=
 =?utf-8?B?VTBJNFR4SVJhd2NpdVVlNTZSUTB3Rk5iREwxaW80VzdmUU9TRVZ1c3RmalEz?=
 =?utf-8?B?T29mKzRsUzl4ZSs0NHB5WnU0WkN0akhnSDhPcUVxd2Uzbnd0TGQ2d3d1VnpC?=
 =?utf-8?B?SER1K2Z5QXpFZkRMbHRJc01zK3lRSGV0U3p4ZlZqZ082M01aa3NJeVhIQ0s5?=
 =?utf-8?B?Nkx1Wms4ZGtoSkxnTFoydzk2c0xwRnkzanJ1eUt3aE83Rkd6bGt0a3Vxb1Y0?=
 =?utf-8?B?cFZMWEltOXMzYk11NmlZaXB4OG5odnNLeXdsdTgrUmJqR3IzZm1tTzhrdmlQ?=
 =?utf-8?B?Ulc3eWVuK2xPTnd0VkN5djhtNTFIZjhrQStmdnUreVFJbHIrc3U3U2gzYUkv?=
 =?utf-8?B?bmxRZlRCaEVlOC9RaUdFQUJVemRVTzUxbmxaM2dyNmRvdUEyRXp4cHVZaS95?=
 =?utf-8?B?NFEyOHRJaEVjeFNqb0RNdU9GRDNhejJmcC9WNWRTdnZ5cEd2YXV2eTJieTRY?=
 =?utf-8?B?andwNzBjcFladWE2WXpJVmc0bzh6MVJ3cHVsOVE3aWs1cFhWNXNRZldralVB?=
 =?utf-8?B?MHh6WnNPMlVNREVoNUYxeldMeHhmQ2NiZUpWUlNRSDVQamljeG5BUXRDbHU0?=
 =?utf-8?B?bEJlNEs3TkE0aUdFMXRkRGVQV1VTWm9Ga3FDQnc0a2FXVlRocWl3TEpSekRI?=
 =?utf-8?B?a0xiNUZwWENqNXpCcjV4L1Q3Vlg5Q3JiTStjZit1cCt5TTRjWHFaNG1HaVIy?=
 =?utf-8?B?ZUY0b2NGbTdraFFVRzIyYXVTUU50L0V1cGtDMzNsSjBQWmdMbWdHZ2FwNHlo?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C74C11A1891D8F48B26B3726FA8E63D4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a701f59-8e9d-4e97-efe0-08db759b73e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2023 16:44:32.7822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GoUjFODhh1M+jwygkX5Y5GHAjCn7cEJZOY+moSDTItvAnkXgs1iclG9PrSCV0OwC1J+KOOGgglD6/ixlfqDZ9dKq5dEhJFpmHHKQXIUvXes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5983
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIzLTA2LTIzIGF0IDEzOjE3ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBGcmksIEp1biAyMywgMjAyMyBhdCAxMDo0MDowMEFNICswMzAwLCBNaWtlIFJhcG9wb3J0IHdy
b3RlOg0KPiA+IE9uIFRodSwgSnVuIDIyLCAyMDIzIGF0IDA2OjI3OjQwUE0gKzAwMDAsIEVkZ2Vj
b21iZSwgUmljayBQIHdyb3RlOg0KPiANCj4gPiA+IFllcywgSSBjb3VsZG4ndCBmaW5kIGFub3Ro
ZXIgcGxhY2UgZm9yIGl0LiBUaGlzIHdhcyB0aGUNCj4gPiA+IHJlYXNvbmluZzoNCj4gPiA+IA0K
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzA3ZGVhZmZjMTBiMWI2ODcyMWJiYmNlMzcw
ZTE0NWQ4ZmVjMmE0OTQuY2FtZWxAaW50ZWwuY29tLw0KPiANCj4gPiA+IERpZCB5b3UgaGF2ZSBh
bnkgcGFydGljdWxhciBwbGFjZSBpbiBtaW5kPw0KPiANCj4gPiBTaW5jZSBpdCdzIG5lYXIgQ09O
RklHX1g4Nl9VU0VSX1NIQURPV19TVEFDSyB0aGUgY29tbWVudCBpbiBtbS5oDQo+IGNvdWxkIGJl
IA0KPiANCj4gPiAvKg0KPiA+IMKgICogVk1BIGlzIHVzZWQgZm9yIHNoYWRvdyBzdGFjayBhbmQg
aW1wbGllcyBndWFyZCBwYWdlcy4NCj4gPiDCoCAqIFNlZSBhcmNoL3g4Ni9rZXJuZWwvc2hzdGsu
YyBmb3IgZGV0YWlscw0KPiA+IMKgICovDQo+IA0KPiA+IGFuZCB0aGUgbG9uZyByZWFzb25pbmcg
Y29tbWVudCBjYW4gYmUgbW92ZWQgbmVhciBhbGxvY19zaHN0ayBpbg0KPiA+IGFyY2gveDg2L2tl
cm5lbC9zaHN0ay5oDQoNCk1ha2VzIHNlbnNlLiBOb3Qgc3VyZSB3aHkgSSBkaWRuJ3QgdGhpbmsg
b2YgdGhpcyBlYXJsaWVyLg0KDQo+IA0KPiBUaGlzIGlzbid0IGFuIHg4NiBzcGVjaWZpYyBjb25j
ZXB0LCBhcm02NCBoYXMgYSB2ZXJ5IHNpbWlsYXINCj4gZXh0ZW5zaW9uDQo+IGNhbGxlZCBHdWFy
ZGVkIENvbnRyb2wgU3RhY2sgKHdoaWNoIEkgc2hvdWxkIGJlIHB1Ymxpc2hpbmcgY2hhbmdlcw0K
PiBmb3INCj4gaW4gdGhlIG5vdCB0b28gZGlzdGFudCBmdXR1cmUpIGFuZCByaXNjdiBhbHNvIGhh
cyBzb21ldGhpbmcuwqAgRm9yDQo+IGFybTY0DQo+IEknbSB1c2luZyB0aGUgZ2VuZXJpYyBtbSBj
aGFuZ2VzIHdob2xlc2FsZSwgd2UgaGF2ZSBhIHNpbWlsYXIgbmVlZA0KPiBmb3INCj4gZ3VhcmQg
cGFnZXMgYXJvdW5kIHRoZSBHQ1MgYW5kIHdoaWxlIHRoZSBtZWNoYW5pY3Mgb2YgYWNjZXNzaW5n
IGFyZQ0KPiBkaWZmZXJlbnQgdGhlIHJlcXVpcmVtZW50IGVuZHMgdXAgYmVpbmcgdGhlIHNhbWUu
wqAgUGVyaGFwcyB3ZSBjb3VsZA0KPiBqdXN0DQo+IHJld3JpdGUgdGhlIGNvbW1lbnQgdG8gc2F5
IHRoYXQgZ3VhcmQgcGFnZXMgcHJldmVudCBvdmVyL3VuZGVyZmxvdyBvZg0KPiB0aGUgc3RhY2sg
YnkgdXNlcnNwYWNlIGFuZCB0aGF0IGEgc2luZ2xlIHBhZ2UgaXMgc3VmZmljaWVudCBmb3IgYWxs
DQo+IGN1cnJlbnQgYXJjaGl0ZWN0dXJlcywgd2l0aCB0aGUgZGV0YWlscyBvZiB0aGUgd29ya2lu
ZyBmb3IgeDg2IHB1dCBpbg0KPiBzb21lIHg4NiBzcGVjaWZpYyBwbGFjZT8NCg0KU29tZXRoaW5n
IHNvcnQgb2Ygc2ltaWxhciBjYW1lIHVwIGluIHJlZ2FyZHMgdG8gdGhlIHJpc2N2IHNlcmllcywg
YWJvdXQNCmFkZGluZyBzb21ldGhpbmcgbGlrZSBhbiBpc19zaGFkb3dfc3RhY2tfdm1hKCkgaGVs
cGVyLiBUaGUgcGxhbiB3YXMgdG8NCm5vdCBtYWtlIHRvbyBtYW55IGFzc3VtcHRpb25zIGFib3V0
IHRoZSBmaW5hbCBkZXRhaWxzIG9mIHRoZSBvdGhlcg0Kc2hhZG93IHN0YWNrIGZlYXR1cmVzIGFu
ZCBsZWF2ZSB0aGF0IGZvciByZWZhY3RvcmluZy4gSSB0aGluayBzb21lIGtpbmQNCm9mIGdlbmVy
aWMgY29tbWVudCBsaWtlIHlvdSBzdWdnZXN0IG1ha2VzIHNlbnNlLCBidXQgSSBkb24ndCB3YW50
IHRvDQp0cnkgdG8gYXNzZXJ0IGFueSBhcmNoIHNwZWNpZmljcyBmb3IgZmVhdHVyZXMgdGhhdCBh
cmUgbm90IHVwc3RyZWFtLiBJdA0Kc2hvdWxkIGJlIHZlcnkgZWFzeSB0byB0d2VhayB0aGUgY29t
bWVudCB3aGVuIHRoZSB0aW1lIGNvbWVzLg0KDQpUaGUgcG9pbnRzIGFib3V0IHg4NiBkZXRhaWxz
IG5vdCBiZWxvbmdpbmcgaW4gbm9uLWFyY2ggaGVhZGVycyBhbmQNCmhhdmluZyBzb21lIGFyY2gg
Z2VuZXJpYyBleHBsYW5hdGlvbiBpbiB0aGUgZmlsZSBhcmUgd2VsbCB0YWtlbiB0aG91Z2guDQo=
