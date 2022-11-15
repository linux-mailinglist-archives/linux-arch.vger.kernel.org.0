Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22EA62A026
	for <lists+linux-arch@lfdr.de>; Tue, 15 Nov 2022 18:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237837AbiKORUZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Nov 2022 12:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiKORTu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Nov 2022 12:19:50 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0120F2F02E;
        Tue, 15 Nov 2022 09:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668532764; x=1700068764;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=H+I4T8zaLO8q67pWWwJgSn7BfYWjVjFb5zUG25qxewU=;
  b=Sa6Q0HLi8IoVoVHMhc9l9X7bCwSTgiLtHWvssBcdaJIsA0zN0BQ2qvRf
   kQRz/Ro7djWEzRtoNs04luZ2aEg3HQ/EwfeZDHUJCPRLkQ+IAcWTHr9Jb
   951d4c+eUtg5v1Fe8/H8fdkEJpdCyPy6x2GH2BF4rYw/1BGCyxm24eCct
   uRvDTbWqaygpf+dadQK+g4HeWil3SzCAyNCNvpWmAVljx/Tqg8tq6G8Ld
   EBE/hWBpwkrTxymbZpirtCfGGKZVGiGKorERNtr31yMExwSuixJ14De1g
   x94s5iVgQbWC0ATJ11oWFIaZlPQQ98vTLjBXDNe3rF1kcHqTDMeKCvmH/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="314123265"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="314123265"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 09:19:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="763990544"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="763990544"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 15 Nov 2022 09:19:01 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 09:19:01 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 09:19:01 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 09:19:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNKwKIqRnWM0pqayu1wPqRCggW+Jg5fn4B75X8r9JcTWX9DtUDi9Ax9I0le8X8+LTVx9O5seHjaPtoOTbwS1zhf6pcpHlevF462EkEtqfXfhzKg/2w/esL5Drq6GP7zR4T9k95NJuxm/UXdsANbx8zHoc3D6yBO9fBnj+tZISoooQ2RJ5TKlmyXnvSAiutmPTQ/ldmDIc6dRDmZS44QX2NpKHNM1pP2Nfbve9YwaUTrkdpKCkbeLct1HeUwMwBrkRdOoUv8Nruoj63inkKJGhv9YfrrqvjKKKFGJW2NN5T8iJw5ZePYlAUCzqdnH/V/s42V54BQqntzfIBqLnADXAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+I4T8zaLO8q67pWWwJgSn7BfYWjVjFb5zUG25qxewU=;
 b=Eezq73m1m0AbxDhkA4drjyqnJzcPs34CJonL53XL09VGBse7yENjxVKm7DXPwcKqW1oLGjLrMpYxI37dNRWbDzrCPetWiZcilzCOconNphCwhRssSZAi3P59uKB3ZOntbCbMqXOmEwWJxogeMGnmeVUrcVsoc7trrU4Fc/7VR+JQET5d3p0WhkTuMSCe5kIN2rmhaty00sNxjtZD9iFK1avHMCvR3mX7xVMMX6Ncxv9bdsW8dHonpzHJHudibT5k07SSE0Rk0A6qzu4s73FtJgSnw6h4X43w9t/3xeWbAnwjobg1mB4S/B3e3VxNwiZyqS1ppe+mYv051eZAiIryQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by IA1PR11MB6321.namprd11.prod.outlook.com (2603:10b6:208:38b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 17:18:47 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3%5]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 17:18:47 +0000
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
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "peterx@redhat.com" <peterx@redhat.com>
Subject: Re: [PATCH v3 13/37] mm: Move VM_UFFD_MINOR_BIT from 37 to 38
Thread-Topic: [PATCH v3 13/37] mm: Move VM_UFFD_MINOR_BIT from 37 to 38
Thread-Index: AQHY8J5SndDp1MUAmEerJGA0DRW+z64/5ysAgABkOwA=
Date:   Tue, 15 Nov 2022 17:18:46 +0000
Message-ID: <920d5657b9eaa9fff762c0d665253f4262bb52c0.camel@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
         <20221104223604.29615-14-rick.p.edgecombe@intel.com>
         <Y3N14v0ddj/vVV+H@hirez.programming.kicks-ass.net>
In-Reply-To: <Y3N14v0ddj/vVV+H@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|IA1PR11MB6321:EE_
x-ms-office365-filtering-correlation-id: c2c60447-c7c5-45c4-04d4-08dac72d749b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /vFf8VqYzZRa8FN0p4vVQZkK1LVAoEFa/WN1W8pTwxuBKcKihap2IDoBBvb4oroDuJOjuO8cfdUAWuunvjaROgpaAoJ7tG4yv4UnEnwhXsO6FHvyZ42wCt3G8QOeuLbpM+kyJjefKKuCgXybgJroWig45pmJFoELW20cpyzgQp5AF38oce0YfavSR7SPan0SqKPb7UkEZdUtua/VOUhRNsgNkSkWN/ld11WK40oypN4iQJhCMkbHaJitQ4Unm0c5eaiIh9E4sphrYydFbvLWyZpLpDO8TxfHoqsd/2D7U4u/M/HZWTTlpxohS/ediJvYJekNKuMvk13Jw+OV/7kAFHx0izlW2nbxFzpRzLfFU+KC4+xljVxEFg8H9GVGoxD1t5r/y4Z9i0NvmeiDkdlKNySfQTcEjYoHqLgbFx8iMhaD/dC7H0MPM8fqdrFfHfjjF/91jhnUFKDEtRgsJumfa/d7XkiTZ9xHo0CwAFTmMOKOKUgo/z0XuU7w5L76+3+sSj6xbK0M8okN1jFZFF/D8fUn047k6IJhlKeDG+izOCNrFLchabelO7AYYeB1l0eS8Rr8ZXmobQkgbRZJ0fFpohev4yOe61fxpQIh4MBVz2EuIC1u4qv+RUC60tnziijP0xIeiGcbV8hPcieVaAPiTYfYAn+ZYuYIyl5aPNlT1Tc0l+2iOvZ3+fTTi5uzxD7Ykt9Q9XjmEA9jMhn+x72gD3qHptIodWyrXxNr022H+GhkDKqRJZFNGW0eM8h/b6RH5/mGyZYIxcBnQYpZgavErNEgOce8co6z5UXtB4wMi/g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199015)(38070700005)(7406005)(4744005)(7416002)(4001150100001)(8936002)(2906002)(36756003)(86362001)(122000001)(186003)(2616005)(26005)(6512007)(6506007)(66476007)(91956017)(66556008)(66446008)(5660300002)(316002)(54906003)(82960400001)(66946007)(41300700001)(76116006)(64756008)(6916009)(71200400001)(8676002)(4326008)(38100700002)(6486002)(478600001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlJzQ2NKTzJqZTlFNkEwZklQT1FXeDZKZXY3L3F2SjlKNEdUUE5uTUVZM3VS?=
 =?utf-8?B?ZHp1OGltY0tPaUVMZ3NCYUF0N3lsdTZ2eHJwV0lkLzdqV0oxVVVFMmFyQ3ov?=
 =?utf-8?B?ZnEvQ283ampvRnNMcGx4eDZEZ2ZTeVRZYVhtSXJNTitTTFRwWlQ1RDBVZzFv?=
 =?utf-8?B?UWVVc05jWWE3b1Rhc0p5WlR2c1YyZWcvUnhxZHZIeE4zbmF2RjFRYmd0Nm42?=
 =?utf-8?B?OEJTUE83aUlvWkswV3ZTQ3Fmd3VmaEpTUTA1cmF2OWhkYmxYWEJZWTlMWVJD?=
 =?utf-8?B?ektlNW44dHBnK2wzQzVMWHlWZlc5UncxMVh2SjFKbjRFckVHRUhCTVRHc1F5?=
 =?utf-8?B?aXlOWEZmU0Q0bklwYVl3N0t1QkZVRUVoR1N3ZFVoSllPRDdJVGVRaGNXYmFE?=
 =?utf-8?B?Z1ZzNkhlQURZanM2VSt5UGRCVGdsYUUwdHNJTmVGcTRIT1NubTlRMG1qZXFE?=
 =?utf-8?B?K1lNdHJqaGZBQWZraXlKSUIxbmZleUhtMkd5L3RudDBKWUIzbHViMXh2azBy?=
 =?utf-8?B?eDJvYTR3RXY5RElDU3FleksyeWJRSlMzV2Zxc0xsREpiTFhFY3RVd1JiSVFG?=
 =?utf-8?B?V2NMM29Td3hNeHRpY1B1d0N3bU83aEw1NHU2eHRCUjIwMU1IQUxGL3cwYlU3?=
 =?utf-8?B?LzBYY21QbWdkRkVyUXozOVJLYm4vOHg1aEthZFliWllOWGxkRm52dUdjZWdt?=
 =?utf-8?B?UjJuYmtBN21wempTa09wMDNsUmNDNTJ3WXVQZmhjTkZlMXpSM0tHRGJpY1V1?=
 =?utf-8?B?dVdDTHg5cEhjOVF0aGxzN2ZqcUZVTWZ1QWRZeXBkTmdkQzdPZzhudGtuZVdY?=
 =?utf-8?B?MHlVY0dPcEMzNGU0NzVIbjNDallpNkhCb2lXUkdRNHhWcEQreVlYU1BzYTN4?=
 =?utf-8?B?TUFUK2p1c0FGVzZJUW80ci9xUDc4WXhjOGpMTkRJQ1A3cGQ1NGMzbW5ZdE4r?=
 =?utf-8?B?aXhqUlZaelJJa2h1T251T1hPMUgzcnBDT3A5cHJ6ODREbTdHb0E2U0c4NkZl?=
 =?utf-8?B?b2xWNWZCMjZhc2lUOTBXanZKbVNwTU9ycUZYZS9WRC84RFYwRTRsSndkeWFI?=
 =?utf-8?B?QVExdGk1M2pxWEQ0UFR4ZXJLZElqNmdzblFWejRyZHJzY0lxUWxzMGcyaG0v?=
 =?utf-8?B?R3g1WWVSU2t6a3VlVkZzaGFmbVk4WEpUR2dYYTZjdkdkaUEzNmQ5VDhFVm41?=
 =?utf-8?B?d3pEUXIydVFhRUY1UCtvS1hOWmM5MDhQclB5N3FEWXBlMjB5NUxoTlQySlhL?=
 =?utf-8?B?ZGtsUjdtVExnR2YxQkpOa2ZRdWV6d0dkbzh2aXllcEtvc2lVMS9VTXlVU3hz?=
 =?utf-8?B?NnBwcndsa1E0OGlhclVvMmUxMnliRE1QNVY4OGdYRDd2QVg3M09naGIwakxh?=
 =?utf-8?B?SFdzbDN0dXpaNmUvaTdleVJ2bXZVVGJEYzViWU5pMzMwb1dlUmc1aEdqWEh4?=
 =?utf-8?B?K0htWHJmSmxHZkRoZVVZS3BLZnZpWXZnUnRSbEowcUVYaTloWFBjTklZbXY5?=
 =?utf-8?B?VDRPNFJvOHovUVpNNWlrdnphbWdob0UyaDVXVE54R2VidDR6ZDRJYTg2MENT?=
 =?utf-8?B?REpXbUJMb1Rlcnkyc202YmYyTm1lSWVVNHVZclIwZUxhdkxSOTBjb01hVFNy?=
 =?utf-8?B?djI5OGVyZnJsYnVtOXlFM0RNZmUxRFB3MDJ3UTU3SmZIZGdWeWNmUFkrcFYv?=
 =?utf-8?B?NjliM21IeFVNTXZReUlRS0NvUVZuQjkvaGJwelR4NkkzQUNxWDN3MEJhM1Za?=
 =?utf-8?B?UFNYRFFDWVBWVUJlY2dMT1NNTmV6WjJ1TmY2b2Z4NExHQTk5eGw4WlEyMm93?=
 =?utf-8?B?RE9EWHNPQnQ5Zk9vUzZOT0pZNnp2bEJaazZ2a1FFQlZTN0ZMRGU4WUpVZlVH?=
 =?utf-8?B?UEhHN3IzeGJJZW95a0MreUZjMkI2T2hXcmh0Z2ZSSUYxKzJldzRHamozRnNy?=
 =?utf-8?B?S1RnaUJlUmw2bVErZjE4bEVSdkR1cTNWY0xFVXcwMEVJTEREdlVTeEtidk44?=
 =?utf-8?B?ZStaREZ4TlcvYnQ3dlB3d0pKRjN1YnFFMVFubTdIY0k5SEdXMjIvcGo0RGJt?=
 =?utf-8?B?TWhEMW1icExTVlJBK21HcFpIVzEyOXhWNW9SSmIwbzk5Z2NQQW1sdnBTVG5z?=
 =?utf-8?B?dlVkemxuR2ZiYkRVSWJXSDR6Q3hIWTZ6QXcxVHBKSlNpUEVhUnplVTk0YUta?=
 =?utf-8?Q?mdzdel0FU0cGxO4Nm4yRtbc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F03186E3834144C965EB03AA4B19AB3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c60447-c7c5-45c4-04d4-08dac72d749b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 17:18:46.9806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EPMECAbtShQo+bVjawUmzy945LA7mvBrvWBLJxpriHJQK3Q0lJnmiK2BBq25XUktFH8YRziPd6MexnExp7vSb45qY1OLuw0Jk9zNpEGjlxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6321
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTE1IGF0IDEyOjIwICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gRnJpLCBOb3YgMDQsIDIwMjIgYXQgMDM6MzU6NDBQTSAtMDcwMCwgUmljayBFZGdlY29t
YmUgd3JvdGU6DQo+ID4gRnJvbTogWXUtY2hlbmcgWXUgPHl1LWNoZW5nLnl1QGludGVsLmNvbT4N
Cj4gPiANCj4gPiBUbyBpbnRyb2R1Y2UgVk1fU0hBRE9XX1NUQUNLIGFzIFZNX0hJR0hfQVJDSF9C
SVQgKDM3KSwgYW5kIG1ha2UgYWxsDQo+ID4gVk1fSElHSF9BUkNIX0JJVHMgc3RheSB0b2dldGhl
ciwgbW92ZSBWTV9VRkZEX01JTk9SX0JJVCBmcm9tIDM3IHRvDQo+ID4gMzguDQo+IA0KPiBXaHkg
dGhvdWdodCA/IT8gQ2hhbmdlbG9nIHV0dGVybHkgZmFpbHMgdG8gcHJvdmlkZSByYXRpb25hbGUu
DQoNCkkgY2FuIGJlZWYgdGhpcyB1cC4gSXQgaXMganVzdCBhIGNsZWFudXAgdHlwZSB0aGluZyB0
byBtYWtlIHRoaW5ncyBsZXNzDQpzY2F0dGVyZWQgYXJvdW5kLg0KDQpUaGFua3MuDQo=
