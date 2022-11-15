Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF20962A38F
	for <lists+linux-arch@lfdr.de>; Tue, 15 Nov 2022 21:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238654AbiKOU4t (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Nov 2022 15:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238701AbiKOU4X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Nov 2022 15:56:23 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADFA3136C;
        Tue, 15 Nov 2022 12:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668545781; x=1700081781;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+Qi5q6qoo+EVPdJZ4dE4GoJNoAUDXJohyQTTmrd6vn4=;
  b=R6x1xCkXm0qVE67ELp88USIkukxp10GZfnuiL7k+xita0ednl9sCIl0s
   56m6t2UwvmjMsLsS2lTaizX3bCuUpPJ4hnFtj3D8Z9NoDvQVyRO59vaEj
   FhAzeK5cCdF9Z7CUyqGfQtt65uE6kYXAERfsRRhH1ZC0YfTNznGS83rml
   z/KOHTCGvdLwH6y7tZ7z8phFrLcuf9Qv4IMhteVZx9nEkVb1cpJGh8hDD
   INMUzjA/uHqGM92FdTqs0Y+2BvIYhEUxeDeFKRkRyTJmdNOlY2yXRZNDH
   ic7W/HqfaskEMooCmrcDnFV4wb8f3h2csG2hG61rPGqqgAkLbbfTeT6yd
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="295732931"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="295732931"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 12:56:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="744748661"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="744748661"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 15 Nov 2022 12:56:20 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 12:56:20 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 12:56:19 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 12:56:19 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 12:56:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8AjYnCiaBffbCTWs1a3htYk2XxaEUoyiXaXjyWRFtAQKOyvrNK1446FIVLUitkyNKJiR7HkM6czWvdl33iKjky9HDhGA62BwD26d+HQPU6+Jhugl8I1FnILWfIlnkxdYKeUHyBjLqo/knLEGKQpfRwOcitVZqu7x9xVljYT348Pv9vOHGdsRaKLOeZNSlnaIWfa4+v4DS8AcpBHQ9e/nTbDZMc1avKNQqDAQC32jc0I5HlR5WVk6K5BQG8ByBSXh+tcgUxMiBUTjEApglnqWfGAePMkUisqR51lPZh9yhELu2lN7LlyNdMQNhyERBaO2oSzVD8gPVrpcFa9SxgSjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Qi5q6qoo+EVPdJZ4dE4GoJNoAUDXJohyQTTmrd6vn4=;
 b=MLOedT23EW0p3m+i+EQyFmQUVFMptIZ2SUpQu2AN4QXSDQubfgulBM+RiiQEexFIbaiI8B907HggB0QInr5csfo5iWkjObEF63Q1mSlpGsKawPgtAvZkdE9GlQDFXPx6F/06SUWIrhZsuNG6updZS7BOSBqYthz+zm1XbW5groAJsH+iTjhmShaWLW8Go5GQuo4wrYiTaY6B/MZWClK6cmINqrOsK1cOpVDxP5sjcPzElSoroUSfRAYewo3UWW+TnuUUE6OVVKpxuUaPLCSfWcP9iDzw7kFe/7RBAcVzT0zcrd3v93uWDYEgof0mmbyTALtNClXuFq46FDPdjovVIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH7PR11MB6882.namprd11.prod.outlook.com (2603:10b6:510:201::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 20:56:16 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3%5]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 20:56:16 +0000
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
Subject: Re: [PATCH v3 27/37] x86/shstk: Introduce routines modifying shstk
Thread-Topic: [PATCH v3 27/37] x86/shstk: Introduce routines modifying shstk
Thread-Index: AQHY8J5fUoAN1KmpVkaYCSerQ8NxVK5AGgSAgABuJAA=
Date:   Tue, 15 Nov 2022 20:56:16 +0000
Message-ID: <b16f268f8eb7a97dc350b647d9446262b1d2501d.camel@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
         <20221104223604.29615-28-rick.p.edgecombe@intel.com>
         <Y3OgiUzWTTvhk9JR@hirez.programming.kicks-ass.net>
In-Reply-To: <Y3OgiUzWTTvhk9JR@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH7PR11MB6882:EE_
x-ms-office365-filtering-correlation-id: 61a8430d-b10b-4e1c-730e-08dac74bd6a3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RgmyR4/NqSHpQhyuv/Ec8PKb9ec0icrW95S2WCHd+zT5275mqaDgF/4l9M1NMF2XHCUOFOJ3oCcHZkaUYxXWzI2cF6hH8xpcSzqhqprOiee4Xw9etYk3fVWCP5sSTBg53q/nVWX114HBlah6yJGdpJYtKud1JYZhOQ0GHcvxJAOZdVI6BxjQF2L8PZ3m4daWLSwyTJuZ354Fwc2dXbNqGxiT6vzB/7N8uUQomiyBfEugFiG21fvExvLzhE+Hd3wbLhr6Fm88lW1ziDi+Zk+o9rN8Ls/vhNYzkX+rWH5hNejk42oLEP+PxAAMdaO3acD0rmJFz8e5/LG1jlhDGDtEy5928pqvrfa9yjj1g6Wns0fpmjQ5BmbugM/4idDFrEb2gv14HvsouT9WJwCuBxCi7NiRc8r2eHXWn9ylhwO5hJDDYXUI+vERZxm/lcql7bPvz09RI6EPors037xeM4XWrHlb8vmHzPaXRar/FG68njs3qEjlmxbGtPsJ+JCFzo0dRiuZEsBKk48iT2ttJ9C6orlnoyEJ+xgpdw0uIFAbetEgaZZ0MFAnR+gtG0LfgU9war2DxEgXmY436pHS3GTCF9n9MUW4SNRWidnM+gqPQxndnXsu1sO9A1TTZ6XqCFqj3In7R9/d8Lz0aaPrlUduIvvF+HlZ6lf8Zg0uI+73qJsZoAXDwcAUvO2L86yZnNJ+SNnuL6uHZ77FMDlK42f+LUW/50zFdm9cAwwp94JOvE+B4xS3aIyHzYa7QST8jB0Li94LIWsExCVuxtOy3aDTOHnv2jPYhEBhznTEGe5Km/2xyCS/iJl1tJ2X7TnAT6da
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(366004)(39860400002)(376002)(451199015)(83380400001)(38070700005)(186003)(2616005)(4001150100001)(82960400001)(2906002)(122000001)(4744005)(7416002)(478600001)(38100700002)(7406005)(8936002)(6486002)(8676002)(6512007)(71200400001)(6506007)(26005)(4326008)(66556008)(66476007)(64756008)(41300700001)(76116006)(66946007)(5660300002)(66446008)(6916009)(91956017)(54906003)(316002)(36756003)(86362001)(99106002)(17423001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QytPWHJQbFZvMHllRmo5UGFBUStXa0c3QXJCN3ZGOFB1TnhOSUtQbW5tZldL?=
 =?utf-8?B?QTBnZXNEbXB1N2QwdUdpQTNFV0NBZ2dKcFI2bGNvU2lmb2ZLNGV5SFp6UlZW?=
 =?utf-8?B?bFk5TGowYXRvYnE5eWxFM2R5bXVNazlrSEREelNoZXRJZVNrelBQaEJuMGhs?=
 =?utf-8?B?SEwxdUY5b2I2aTVaS2c5eHRmcG0xdXdubktWcCtiUk03Z25FZlcwS0xFZWxm?=
 =?utf-8?B?cjZvUEFSN3pRenhPY2NvdFFCbFYwWE1XUk1XbldTdUl2aFQyaHBocVZnbTVs?=
 =?utf-8?B?NVA3aHBOZnZWdnlITmlmdDh3UW9wLzNhVFZhd0w5Q01iNGJJQjhYRnNVKzg0?=
 =?utf-8?B?MEZIUllROWJ3ell3TDg2VUxuQnJlVUFhNytyWnE2RVpyK2FwazhPSjJnb1Fz?=
 =?utf-8?B?dHhQZmRCbmY3UnNDNWgzR3pPaDhvcG5GbWVHa3J4QXdHQlhzeUYzeVV0dGhU?=
 =?utf-8?B?Zlg0YmJWWFJBZ0U1eXR1WWZVdkgzZ08yYzFzV2lNM1NrTzBUUU5rMktORXRK?=
 =?utf-8?B?aUY1ai9XNlEzanZRWE5vYkJ3aW0wY1ZoVC9TblBaK0pETWFHbXZhODZtVldY?=
 =?utf-8?B?MjR4R2YvUE1ZUDY3aU5Cb2xVN01SRFNITVNGOUxGYXdZY1dzWi9WQXlZSVJE?=
 =?utf-8?B?aDQzTG51ZFljbkVlOW9mQ3R0MUtvMGNSNjROQUw0Y0kwSE9zYVBJSlRaK29P?=
 =?utf-8?B?QytwQWRxQm5iV2NwbFdpT1FOWTU1S1F2YjRFbGJjaUxsejFYaVhOUitQQ1ZH?=
 =?utf-8?B?Yk5zNmpsMkxPTm9zeTNPcTFMMDVqK2c4L2NsbFlBTWpseGFPOWxWVWoxNWZX?=
 =?utf-8?B?THp2MTh2alRmSjdoQ3QyTm5lU2R5dk1qTU11WkdvOXVJM08ySmlIYkVXY00y?=
 =?utf-8?B?VjVwb1IvS1FzZjR3Wk83Nit0Q25ZSFRGOXd0TldNcGdQOXdpd01xZXhmRW96?=
 =?utf-8?B?YkZlTkxPWFYwMlR3VStjOFNoN2JNam5weEQxRFdjMmJEQ3oyNFFxOFZiM3Vm?=
 =?utf-8?B?dFdybnZuV2w2U2tLR0kyZ3Z0eXBwN0kwNFhhN3JHWmorWmFsek9QcWNVTHJ4?=
 =?utf-8?B?TkhNU0IrNU40dm5qUU9RV2p1YTh6Q0VEZ29UOE0wQUM1MDFGVlpEV08vSHRk?=
 =?utf-8?B?UWJKMmczWFpBYjJEeEFoTWk0STU5cVYzQ2ZpZHAwVlFOMDQrdFBpVnhudmxX?=
 =?utf-8?B?QmFyL3ZJejlyam5IZUdNbS82RE04OElSZ0lsN3hHSlFkOTFEM1dpckJVSW5S?=
 =?utf-8?B?QWpBbFBLR3E2YXZzYUFhbSs3T1UyZm41VHlMTHJ1VittRXlubDV6MUE2dlhI?=
 =?utf-8?B?UDc3K0J4UjNxS1lPdGhLVUFHZkZOb3JxcWpBWHA1WXRRNndWcVR2akJyeC9v?=
 =?utf-8?B?ZEpxL3ExM2hKZGFaNWlHcG9odll3c3hiUlRWTENZeW9NemlXdXhmSWJiL0Ja?=
 =?utf-8?B?anc2ZHkySVpYT0NLQmZQNEE5M0JTbDZKVU5CemlIeHFMN2xmWTk4TXk4cmxV?=
 =?utf-8?B?bUtONlUrc1pwaStPSUNuZmh6V2pOdkpHcUMzcUI1enkrcXN6YmFsMjFhdnhi?=
 =?utf-8?B?TW1keXFUSUtObHlLNnNra0xFK05MT0liZUhDT1VBWkFueUliWmJuUDJENWZF?=
 =?utf-8?B?M1JGL2Rxb3draHdwVDhMeFcwYS9oK0dMZHVFSU0zMzJzYllpcm5DZ1ByU0RP?=
 =?utf-8?B?VFZPZzQ2MTkxaWhSWHVVZWNueEU4REI2UjNiTFdObkR1Q0YyZlMxS2JIQnhE?=
 =?utf-8?B?VS9Xc2xIUFRRMlF2bERmWm40TkRIMVFGR1hPUFBzZWMxVDc0UTZGU1l1WDV2?=
 =?utf-8?B?SU5OcnNIeG40aFhLUGdicEczbUhVYnJNOVJhMWl5M0JHYitiT1kwTXE1R08y?=
 =?utf-8?B?RzhWV2Y5S25zRjM0OTZuMkgwcU1WQXVObkNZWEthcEVybGVoUkVMU3VtZnk4?=
 =?utf-8?B?Ri9WbVlvaE9sbVJZc3M0MUJ1ZTVQaURZa0xLRHRqOS93blpKZlVGOHZFWldM?=
 =?utf-8?B?U3d5STE1RFR1NW14Vm9hWTJWaVRPRmJJSWdOOUdjU1IyeFFOR1pwZ3F3TTBu?=
 =?utf-8?B?Vndhbkpuek9lcHliaVhJOTF3cnc2RXFLS0lSU0hOMmF4RWp3ekpZVzZybXN0?=
 =?utf-8?B?M0xRN29weC8zczlrdHFDOXZjT2p5UFN2Q2hSRi9ORTlGYjRFN3ZodVRET1Av?=
 =?utf-8?Q?ebQ8mcQ9ahy9uxKp7fpcFPo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <536BBA94D1021F4EB21C82945501C73F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a8430d-b10b-4e1c-730e-08dac74bd6a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 20:56:16.3544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SR3qnd1skRf4ksCOkpMundsLX3EPMxNbE6vBdS0ReRpQV/cG7vQqI5pf51qiATwBq9GyaBB/IYbtMPgssuVIOMg6Li1BooMbcIb5a1ioPhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6882
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTE1IGF0IDE1OjIyICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gRnJpLCBOb3YgMDQsIDIwMjIgYXQgMDM6MzU6NTRQTSAtMDcwMCwgUmljayBFZGdlY29t
YmUgd3JvdGU6DQo+ID4gK3N0YXRpYyB1bnNpZ25lZCBsb25nIGdldF91c2VyX3Noc3RrX2FkZHIo
dm9pZCkNCj4gPiArew0KPiA+ICsgICAgIHVuc2lnbmVkIGxvbmcgbG9uZyBzc3A7DQo+ID4gKw0K
PiA+ICsgICAgIGZwcmVnc19sb2NrX2FuZF9sb2FkKCk7DQo+ID4gKw0KPiA+ICsgICAgIHJkbXNy
bChNU1JfSUEzMl9QTDNfU1NQLCBzc3ApOw0KPiA+ICsNCj4gPiArICAgICBmcHJlZ3NfdW5sb2Nr
KCk7DQo+ID4gKw0KPiA+ICsgICAgIHJldHVybiBzc3A7DQo+ID4gK30NCj4gDQo+IFRoaXMgZG9l
c24ndCByZXR1cm4gdGhlIHNoc3RrIGFkZHIsIHVubGlrZSB3aGF0IHRoZSBuYW1lIHN1Z2dlc3Rz
LA0KPiByaWdodD8NCg0KVGhhdCdzIGEgZ29vZCBwb2ludC4gZ2V0X3VzZXJfc3NwKCkgd291bGQg
YmUgYSBiZXR0ZXIgbmFtZS4NCg==
