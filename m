Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B23C69D61C
	for <lists+linux-arch@lfdr.de>; Mon, 20 Feb 2023 23:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjBTWIQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Feb 2023 17:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjBTWIP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Feb 2023 17:08:15 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D97EB74A;
        Mon, 20 Feb 2023 14:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676930894; x=1708466894;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5gXC/mqZEGk0vc6lHI6l2megC9zQPVA+RnklBJwceSM=;
  b=Utv/8gtprQdsRV958S3FTXtd51jBYXR2DfywjI2xIcFRK5SKAHJ6fNja
   xgBN4N63yofEbsXIrZpIsHEL7zE2d0qxajMxVeS0hLRvFhUMEDB44kLwJ
   /lvYkjkT4NrzFJGQXBCro3y31UxvjepGxoRB4ETu6V5ZmY8uWtydAAjiI
   XVMjP7ambhTYIJwvMtuHWLPMeLUvEE1LPHVxOt90xQlyDTBUMVVCDmI4s
   ijEdZQphStawlSBnRzwUVIjUn90XGa5vnosl6T22N12WqO4rr56ce9gmP
   wB3g3MCnIwyyu7KutLkzuubhdd9MgxenyAyhVnD4wSlTMTdyn6WRvZBX9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="331161351"
X-IronPort-AV: E=Sophos;i="5.97,313,1669104000"; 
   d="scan'208";a="331161351"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 14:08:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="740179645"
X-IronPort-AV: E=Sophos;i="5.97,313,1669104000"; 
   d="scan'208";a="740179645"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 20 Feb 2023 14:08:13 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 20 Feb 2023 14:08:13 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 20 Feb 2023 14:08:13 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 20 Feb 2023 14:08:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ttyti4Mk96aKR6510yJhVKJgZNVt3ModHm4lKmtQBPO8ocKwQi9JTtuV7AN9xVkEerjxd8V90BBfHW14UbE9gV0h/QmUuWxBj7WXC884Y/HVNjO6ikZTWQlSU42P92SJ4pH0Rl+r57JKghm5FvCk1XM9zGNG8eVZJcyFzWgRXlcIZk3q2OWyk9ouazrhTUIBd76Wq54Un5aAXnypQzAiZspZ4lk6cUPFe1xxJhV4F9H2ZjQb4nFJudiIzTK9FPC8b/+19hwqust+Nr33K7mlLowgLABYhq1JEPFau+yaSS84+THHd9kz9G3A7+YlwefCDUdzEIgbciB81XFiOREf1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gXC/mqZEGk0vc6lHI6l2megC9zQPVA+RnklBJwceSM=;
 b=B7PRWeS4+C+DcAP0z+uqPtdHu630lp/o8179ZR406FLEe30GSckfojNnkr1RUmhfqWbNMOW52VwDcwpI4TJmWGRCFi9ca6wNopiXNX7kSKVaKinI81GUd0me71rU5VZ+/xqCBQ/Iveb7bYFMPC6v0WRTbZojewZC8QxgVezCTcfvpucu7W5gLoJpNXI3XMBZLgymoVL2kPBeUSiL8/fBDTENAYr1gBu4aWuNsyJ/FcsuIa64m9LLP5ghfHaOXgNpV2IQ74cvW84eJimH7PcRQzccZjMxtFHfpBBWslWMKjoMcEB5WucmK3N7LcRO23YNjxar+c8AayMh1JM1leJE1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SJ0PR11MB5119.namprd11.prod.outlook.com (2603:10b6:a03:2d6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Mon, 20 Feb
 2023 22:08:09 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6111.019; Mon, 20 Feb 2023
 22:08:08 +0000
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
        "debug@rivosinc.com" <debug@rivosinc.com>,
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
Subject: Re: [PATCH v6 18/41] mm: Introduce VM_SHADOW_STACK for shadow stack
 memory
Thread-Topic: [PATCH v6 18/41] mm: Introduce VM_SHADOW_STACK for shadow stack
 memory
Thread-Index: AQHZQ95BKWcEOqttR0Cvz7IQRRxEFa7XzaiAgACaOQA=
Date:   Mon, 20 Feb 2023 22:08:08 +0000
Message-ID: <9e25a24f3783f3960e2c1e5e68a6c6fdf3d89442.camel@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
         <20230218211433.26859-19-rick.p.edgecombe@intel.com>
         <366c0af9-850f-24b1-3133-976fa92c51e2@redhat.com>
In-Reply-To: <366c0af9-850f-24b1-3133-976fa92c51e2@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SJ0PR11MB5119:EE_
x-ms-office365-filtering-correlation-id: 3aa2f32a-c307-4984-d586-08db138ef2c0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mJIhEkCBfmfzF8eXT/T3wAejYLhKxGQi+TA8GCDbvdx92kwoXLAS76jrUu63R8mfnicJ6V1YE8USVOXggCPKIrHXxFzbPxwtvvOLgSEiNXe2l/USRtqQgDszqs/Fh7l/Z+ilXk3N26hjLMyHJL5eCe76K5KLGyRH+fqWUcJ8DHwZWzQus24Os5PCsE0DIEnb6nCIonKvaXLb63krJ7IGfsOU0mnwlVPVmFZiSfVtKGVtgZNkBL24cc84Q3rQxZtheSCzSvv0S8AhzJTo1H1crB4wef5I85GOTrEdDKUjEHc4koCZTlbjcbkXyJtjRMB2nR/CvSpfdwixgFN2pGaPjsKMkG6h6mtvIsR2OzsTlAotu+Lp431Hm71g0w8nmsajsPIrzn2ToFM/T44irziCQ/oDXS0Q1brwkTI6CgQ0R7l1JKuDnqD7NMQBQM8C7jEAa38t5qA+wMool67cLM8HQY51q+BM1b/yJIPIv3m2gGu/2s9bddJVHaOLxqul8C7+26Mr8joU8Wfj74Au0e6waNqGKlLOzA+Y3wl/IzWDKyOHkz7KVFhFO9WNmh9YzHc2i9e1C/rQ+k/QKVWG+aPHGyY5ax6sd2+8XggYvYdGqWIcn1Bm+TF4fGZfq0ba+6CTezXJ9N4skMJ5tb6Vi+g+SxaWfYhXl0ol1gVB1vyDrxw0mR9brzldOqbGE6W3hrmHnclXOtvaTok69p6ey1/xsfRJxKCH6mzQcwleIYGnIyo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199018)(38070700005)(83380400001)(5660300002)(7406005)(8936002)(7416002)(41300700001)(86362001)(4326008)(6512007)(6486002)(966005)(26005)(186003)(6506007)(76116006)(8676002)(2906002)(64756008)(66556008)(66946007)(66446008)(66476007)(316002)(71200400001)(2616005)(478600001)(53546011)(110136005)(921005)(38100700002)(36756003)(82960400001)(122000001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVVqaFZocmdPTEZCQjR0VWp0cVpXZHAybllSdjRwakNvdWFZamNqWnNLcXcw?=
 =?utf-8?B?aGM0K0tWTmJKc2ZnTXoxcGdOTnN6OFFGVmlIeHY4VXIybzhPVDVMcTJydFNs?=
 =?utf-8?B?OTRPcFJHSWJnTlRNZTg3MmpCREFTQ0ZlVGV2cG5KYk4rdnNlNUdpYnE1VDYw?=
 =?utf-8?B?RmtnLzE2SzN1aEliUVdQVmtTQW14MzdieXU4WE1oc0tWWU11alRPODZFM0Vi?=
 =?utf-8?B?MUxUYzZUa3FORDMxUmczL3NLQXZ5V3czWDhOV1BFNGV5dUorUTBKWmsrTVc2?=
 =?utf-8?B?Rlp4dEVNbzZoZFhHTGUzcm00eVdJaHBSRnFQSmdjMWh6RFJDWmNza29YTjRR?=
 =?utf-8?B?ZkxBSEkyaGUvMEp0eTRPNUtvSlZJSko3c2V3RVR3ZUdjWi9rYmxxaVZjUEND?=
 =?utf-8?B?NXdIOHpLd2dDS3hpNWtWRmkwR2FNUTIxNXZhaU9kUllSUCtkRVI5bVU1SzUr?=
 =?utf-8?B?ZVlac1k0eWJSamNzODY2SG5ZaXRGZTkxcUd6RFRLTEozR21TelY0WFp5L0p0?=
 =?utf-8?B?SWN2dmdCSHMvRklvZ3EvazUwOTQvemp3Wk92T0ZSVzRoODNGOHYxQzAzQ2U5?=
 =?utf-8?B?b0dIU3U2VTViQTMwc0dIcXc0WjJjQkdSWGluOGlldjVXOE5MWlQ2aFRCK3l6?=
 =?utf-8?B?YW9hN2xiQ1JLa0F5VUlJWWxaM2N1cnI5blZuQmRiMzJuY05DQWNmQURPeEhF?=
 =?utf-8?B?dythNld1NThjM3NzTjVETlhDK2xSTjJnVCtCbE43eHY5cEpYOGRSYjFsQlIv?=
 =?utf-8?B?eS9GRkZTUHozNEZyUm5zQWh0d2JXblFueWdpbHl5M29wcVcwYzlsOUdrL3hQ?=
 =?utf-8?B?ZXpkQTFLYmE2YVhxVCtjSHlhOCtEZFd2TVFxVHB3YUhpakNSWWVZK2FuVTFU?=
 =?utf-8?B?ZFJIWVZYYXhBbmRQSnNuQUF6RnJjeFJuVWxSQmtjYk1GNDIwaEhFWDVTMDBC?=
 =?utf-8?B?bnVOZHNWYlVnQmRkTXNmZXRhdmhSRGdoeVFrZTQ4dUQrM1d5eCtXcnM5VGhE?=
 =?utf-8?B?eTBZZ2JLK2RBNm8rZjdWQmR6WVY1L3hLTlRWdno3RHB2UGVXSFdPZTdpZHJS?=
 =?utf-8?B?MVhUZXdMSk8xNk5mellCM3pBYm1Vd2dYcnZaRitzMi9hMUNMNFVrNlBXMDdZ?=
 =?utf-8?B?UUFJd0ZnZ2FKOVlybERnWnkydExwTUp3UU1hRkxwZEZSSUdVbUdReERQN1c0?=
 =?utf-8?B?Tk5FT1RmMG1xS1NIbGcwd0RKRTJEN2RjUURxdTY2REJPc0xYbWdBb245eEc1?=
 =?utf-8?B?dDdocHBqVlp4ZURHVzZTa1pHWUp5NlRDdThnb052MjRBSjJraGtmWnZSRURP?=
 =?utf-8?B?SlphTEtLRGFZRmFaVnhld3V5WHJ5NWVDVFVPOWxEbUNzaTQwMW44a3FudjYy?=
 =?utf-8?B?WWtWOTRHOVZEN1J4VVNuODdPWDI2RTAzVEVkTFhxWnhDMzdHNGNuOGo1cXFB?=
 =?utf-8?B?Q05lUExwSlRyNFhOYnJweU5EdDJoYTdjdlBpL0p4TTZsUHphTGhuODRYcEpG?=
 =?utf-8?B?Mk5iYWJvUGdNYy92QzZpTnFDbHlvSE8vRU1BRFg1a2lZN1kzVm1oaldrOWlN?=
 =?utf-8?B?MFptYW5YcnZIR1hMc0ZMTVRzNGhBSngySjFUNENXN3hBWHF4REF4NllScFpI?=
 =?utf-8?B?azlJN0trdmk5cUtINCtCRy9vNFJsa0xieHVQcUFScUZ6UzN5VkQ1USt3VzQw?=
 =?utf-8?B?OGNUMWsrRytuRUhEWnBDOGtXeHlndFhxSEZ6Q0x6UVZyVTErNlliNUlaRU9k?=
 =?utf-8?B?dUdaTk90S2c4dE5VTEEwWFlpc05PSU5nUnlodHRMMHpBMjBHdjhaWW54OTJF?=
 =?utf-8?B?S0YvL3h1ZjFJVElza3ZJRURLQkxhOVJSeXlJbi9weksxei9wK3IzQUYrWkVO?=
 =?utf-8?B?MHZlQ2lDYlZseUJCTDdLRmJaOHZ0MkVnTjh1WThjMEVCRWpRWVRCTGFtK0Ev?=
 =?utf-8?B?NWQrc0pTK3ZiUU92cFgzbWZINTVkRGZ2czlCeFdsVUtST0dRbjE1aFZZc1lL?=
 =?utf-8?B?a2gzYkxsMGdRVVhLWFc1Q1ZRT3l0SWtBUldoYSsyLzZmRnNaQXZVSXhWa1FL?=
 =?utf-8?B?V0FaT0wyVDJETkNEbTUvWmZYamxXVU5GNjBaWHhDVENxYzRwbGFmakJDMkR4?=
 =?utf-8?B?WjcrV3RENE5TU1djcHNSOU10NEV3TEhxQmJTejZ0RFRqNnVnY3JVSmZjNmRR?=
 =?utf-8?Q?rWKRsvnfzIzCWSyevimfCSI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1123FC9C3D70E42B368EEB0328C0DCF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa2f32a-c307-4984-d586-08db138ef2c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 22:08:08.1439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qAmQHuMXAlCS4Hxv4gA/xIvFRru7f5YjGS+NTXbynU4j0bizYPqZvA7jWRSYVowe84zzCGFF/n/quO6cssk1FAmANYwanSXp5K2jrqLi0nw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5119
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIzLTAyLTIwIGF0IDEzOjU2ICswMTAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4gT24gMTguMDIuMjMgMjI6MTQsIFJpY2sgRWRnZWNvbWJlIHdyb3RlOg0KPiA+IEZyb206
IFl1LWNoZW5nIFl1IDx5dS1jaGVuZy55dUBpbnRlbC5jb20+DQo+ID4gDQo+ID4gVGhlIHg4NiBD
b250cm9sLWZsb3cgRW5mb3JjZW1lbnQgVGVjaG5vbG9neSAoQ0VUKSBmZWF0dXJlIGluY2x1ZGVz
DQo+ID4gYSBuZXcNCj4gPiB0eXBlIG9mIG1lbW9yeSBjYWxsZWQgc2hhZG93IHN0YWNrLiBUaGlz
IHNoYWRvdyBzdGFjayBtZW1vcnkgaGFzDQo+ID4gc29tZQ0KPiA+IHVudXN1YWwgcHJvcGVydGll
cywgd2hpY2ggcmVxdWlyZXMgc29tZSBjb3JlIG1tIGNoYW5nZXMgdG8gZnVuY3Rpb24NCj4gPiBw
cm9wZXJseS4NCj4gPiANCj4gPiBBIHNoYWRvdyBzdGFjayBQVEUgbXVzdCBiZSByZWFkLW9ubHkg
YW5kIGhhdmUgX1BBR0VfRElSVFkgc2V0Lg0KPiA+IEhvd2V2ZXIsDQo+ID4gcmVhZC1vbmx5IGFu
ZCBEaXJ0eSBQVEVzIGFsc28gZXhpc3QgZm9yIGNvcHktb24td3JpdGUgKENPVykgcGFnZXMuDQo+
ID4gVGhlc2UNCj4gPiB0d28gY2FzZXMgYXJlIGhhbmRsZWQgZGlmZmVyZW50bHkgZm9yIHBhZ2Ug
ZmF1bHRzLiBJbnRyb2R1Y2UNCj4gPiBWTV9TSEFET1dfU1RBQ0sgdG8gdHJhY2sgc2hhZG93IHN0
YWNrIFZNQXMuDQo+IA0KPiBJIHN1Z2dlc3Qgc2ltcGxpZnlpbmcgYW5kIGFic3RyYWN0aW5nIHRo
YXQgZGVzY3JpcHRpb24uDQo+IA0KPiAiTmV3IGhhcmR3YXJlIGV4dGVuc2lvbnMgaW1wbGVtZW50
IHN1cHBvcnQgZm9yIHNoYWRvdyBzdGFjayBtZW1vcnksDQo+IHN1Y2ggDQo+IGFzIHg4NiBDb250
cm9sLWZsb3cgRW5mb3JjZW1lbnQgVGVjaG5vbG9neSAoQ0VUKS4gTGV0J3MgYWRkIGEgbmV3IFZN
IA0KPiBmbGFnIHRvIGlkZW50aWZ5IHRoZXNlIGFyZWFzLCBmb3IgZXhhbXBsZSwgdG8gYmUgdXNl
ZCB0byBwcm9wZXJseSANCj4gaW5kaWNhdGUgc2hhZG93IHN0YWNrIFBURXMgdG8gdGhlIGhhcmR3
YXJlLiINCg0KQWggeWVhLCB0aGF0IHRvcCBibHVyYiB3YXMgYWRkZWQgdG8gYWxsIHRoZSBub24t
eDg2IGFyY2ggcGF0Y2hlcyBhZnRlcg0Kc29tZSBmZWVkYmFjayBmcm9tIEFuZHJldyBNb3J0b24u
IEhlIGhhZCBzYWlkIGJhc2ljYWxseSAoaW4gc29tZSBtb3JlDQpjb2xvcmZ1bCBsYW5ndWFnZSkg
dGhhdCB0aGUgY2hhbmdlbG9ncyAoYXQgdGhlIHRpbWUpIHdlcmUgd3JpdHRlbg0KYXNzdW1pbmcg
dGhlIHJlYWRlciBrbm93cyB3aGF0IGEgc2hhZG93IHN0YWNrIGlzLg0KDQpTbyBpdCBtaWdodCBi
ZSB3b3J0aCBrZWVwaW5nIGEgbGl0dGxlIG1vcmUgaW5mbyBpbiB0aGUgbG9nPw0KDQo+IA0KPiA+
IA0KPiA+IFJldmlld2VkLWJ5OiBLZWVzIENvb2sgPGtlZXNjb29rQGNocm9taXVtLm9yZz4NCj4g
PiBUZXN0ZWQtYnk6IFBlbmdmZWkgWHUgPHBlbmdmZWkueHVAaW50ZWwuY29tPg0KPiA+IFRlc3Rl
ZC1ieTogSm9obiBBbGxlbiA8am9obi5hbGxlbkBhbWQuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFl1LWNoZW5nIFl1IDx5dS1jaGVuZy55dUBpbnRlbC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEtp
cmlsbCBBLiBTaHV0ZW1vdiA8a2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbT4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+
DQo+ID4gQ2M6IEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPg0KPiA+IA0KPiA+IC0t
LQ0KPiA+IHY2Og0KPiA+ICAgLSBBZGQgY29tbWVudCBhYm91dCBWTV9TSEFET1dfU1RBQ0sgbm90
IGJlaW5nIGFsbG93ZWQgd2l0aA0KPiA+IFZNX1NIQVJFRA0KPiA+ICAgICAoRGF2aWQgSGlsZGVu
YnJhbmQpDQo+IA0KPiBNaWdodCB3YW50IHRvIGFkZCBzb21lIG1vcmUgbWVhdCB0byB0aGUgcGF0
Y2ggZGVzY3JpcHRpb24gd2h5IHRoYXQNCj4gaXMgDQo+IHRoZSBjYXNlLg0KDQpTdXJlLg0KDQo+
IA0KPiA+IA0KPiA+IHYzOg0KPiA+ICAgLSBEcm9wIGFyY2ggc3BlY2lmaWMgY2hhbmdlIGluIGFy
Y2hfdm1hX25hbWUoKS4gVGhlIG1lbW9yeSBjYW4NCj4gPiBzaG93IGFzDQo+ID4gICAgIGFub255
bW91cyAoS2lyaWxsKQ0KPiA+ICAgLSBDaGFuZ2UgQ09ORklHX0FSQ0hfSEFTX1NIQURPV19TVEFD
SyB0bw0KPiA+IENPTkZJR19YODZfVVNFUl9TSEFET1dfU1RBQ0sNCj4gPiAgICAgaW4gc2hvd19z
bWFwX3ZtYV9mbGFncygpIChCb3JpcykNCj4gPiAtLS0NCj4gPiAgIERvY3VtZW50YXRpb24vZmls
ZXN5c3RlbXMvcHJvYy5yc3QgfCAxICsNCj4gPiAgIGZzL3Byb2MvdGFza19tbXUuYyAgICAgICAg
ICAgICAgICAgfCAzICsrKw0KPiA+ICAgaW5jbHVkZS9saW51eC9tbS5oICAgICAgICAgICAgICAg
ICB8IDggKysrKysrKysNCj4gPiAgIDMgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQ0K
PiA+IA0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL3Byb2MucnN0
DQo+ID4gYi9Eb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL3Byb2MucnN0DQo+ID4gaW5kZXggZTIy
NGI2ZDViNjQyLi4xMTU4NDNlOGNjZTMgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9m
aWxlc3lzdGVtcy9wcm9jLnJzdA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZmlsZXN5c3RlbXMv
cHJvYy5yc3QNCj4gPiBAQCAtNTY0LDYgKzU2NCw3IEBAIGVuY29kZWQgbWFubmVyLiBUaGUgY29k
ZXMgYXJlIHRoZSBmb2xsb3dpbmc6DQo+ID4gICAgICAgbXQgICAgYXJtNjQgTVRFIGFsbG9jYXRp
b24gdGFncyBhcmUgZW5hYmxlZA0KPiA+ICAgICAgIHVtICAgIHVzZXJmYXVsdGZkIG1pc3Npbmcg
dHJhY2tpbmcNCj4gPiAgICAgICB1dyAgICB1c2VyZmF1bHRmZCB3ci1wcm90ZWN0IHRyYWNraW5n
DQo+ID4gKyAgICBzcyAgICBzaGFkb3cgc3RhY2sgcGFnZQ0KPiA+ICAgICAgID09ICAgID09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA+ICAgDQo+ID4gICBOb3RlIHRo
YXQgdGhlcmUgaXMgbm8gZ3VhcmFudGVlIHRoYXQgZXZlcnkgZmxhZyBhbmQgYXNzb2NpYXRlZA0K
PiA+IG1uZW1vbmljIHdpbGwNCj4gPiBkaWZmIC0tZ2l0IGEvZnMvcHJvYy90YXNrX21tdS5jIGIv
ZnMvcHJvYy90YXNrX21tdS5jDQo+ID4gaW5kZXggYWYxYzQ5YWUxMWIxLi45ZTJjZWZlNDc3NDkg
MTAwNjQ0DQo+ID4gLS0tIGEvZnMvcHJvYy90YXNrX21tdS5jDQo+ID4gKysrIGIvZnMvcHJvYy90
YXNrX21tdS5jDQo+ID4gQEAgLTcxMSw2ICs3MTEsOSBAQCBzdGF0aWMgdm9pZCBzaG93X3NtYXBf
dm1hX2ZsYWdzKHN0cnVjdCBzZXFfZmlsZQ0KPiA+ICptLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3Qg
KnZtYSkNCj4gPiAgICNpZmRlZiBDT05GSUdfSEFWRV9BUkNIX1VTRVJGQVVMVEZEX01JTk9SDQo+
ID4gICAJCVtpbG9nMihWTV9VRkZEX01JTk9SKV0JPSAidWkiLA0KPiA+ICAgI2VuZGlmIC8qIENP
TkZJR19IQVZFX0FSQ0hfVVNFUkZBVUxURkRfTUlOT1IgKi8NCj4gPiArI2lmZGVmIENPTkZJR19Y
ODZfVVNFUl9TSEFET1dfU1RBQ0sNCj4gPiArCQlbaWxvZzIoVk1fU0hBRE9XX1NUQUNLKV0gPSAi
c3MiLA0KPiA+ICsjZW5kaWYNCj4gPiAgIAl9Ow0KPiA+ICAgCXNpemVfdCBpOw0KPiA+ICAgDQo+
ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbW0uaCBiL2luY2x1ZGUvbGludXgvbW0uaA0K
PiA+IGluZGV4IGU2ZjE3ODljOGU2OS4uNzZlMGEwOWFlZmZlIDEwMDY0NA0KPiA+IC0tLSBhL2lu
Y2x1ZGUvbGludXgvbW0uaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvbW0uaA0KPiA+IEBAIC0z
MTUsMTEgKzMxNSwxMyBAQCBleHRlcm4gdW5zaWduZWQgaW50IGtvYmpzaXplKGNvbnN0IHZvaWQN
Cj4gPiAqb2JqcCk7DQo+ID4gICAjZGVmaW5lIFZNX0hJR0hfQVJDSF9CSVRfMgkzNAkvKiBiaXQg
b25seSB1c2FibGUgb24gNjQtDQo+ID4gYml0IGFyY2hpdGVjdHVyZXMgKi8NCj4gPiAgICNkZWZp
bmUgVk1fSElHSF9BUkNIX0JJVF8zCTM1CS8qIGJpdCBvbmx5IHVzYWJsZSBvbiA2NC0NCj4gPiBi
aXQgYXJjaGl0ZWN0dXJlcyAqLw0KPiA+ICAgI2RlZmluZSBWTV9ISUdIX0FSQ0hfQklUXzQJMzYJ
LyogYml0IG9ubHkgdXNhYmxlIG9uIDY0LQ0KPiA+IGJpdCBhcmNoaXRlY3R1cmVzICovDQo+ID4g
KyNkZWZpbmUgVk1fSElHSF9BUkNIX0JJVF81CTM3CS8qIGJpdCBvbmx5IHVzYWJsZSBvbiA2NC1i
aXQNCj4gPiBhcmNoaXRlY3R1cmVzICovDQo+ID4gICAjZGVmaW5lIFZNX0hJR0hfQVJDSF8wCUJJ
VChWTV9ISUdIX0FSQ0hfQklUXzApDQo+ID4gICAjZGVmaW5lIFZNX0hJR0hfQVJDSF8xCUJJVChW
TV9ISUdIX0FSQ0hfQklUXzEpDQo+ID4gICAjZGVmaW5lIFZNX0hJR0hfQVJDSF8yCUJJVChWTV9I
SUdIX0FSQ0hfQklUXzIpDQo+ID4gICAjZGVmaW5lIFZNX0hJR0hfQVJDSF8zCUJJVChWTV9ISUdI
X0FSQ0hfQklUXzMpDQo+ID4gICAjZGVmaW5lIFZNX0hJR0hfQVJDSF80CUJJVChWTV9ISUdIX0FS
Q0hfQklUXzQpDQo+ID4gKyNkZWZpbmUgVk1fSElHSF9BUkNIXzUJQklUKFZNX0hJR0hfQVJDSF9C
SVRfNSkNCj4gPiAgICNlbmRpZiAvKiBDT05GSUdfQVJDSF9VU0VTX0hJR0hfVk1BX0ZMQUdTICov
DQo+ID4gICANCj4gPiAgICNpZmRlZiBDT05GSUdfQVJDSF9IQVNfUEtFWVMNCj4gPiBAQCAtMzM1
LDYgKzMzNywxMiBAQCBleHRlcm4gdW5zaWduZWQgaW50IGtvYmpzaXplKGNvbnN0IHZvaWQNCj4g
PiAqb2JqcCk7DQo+ID4gICAjZW5kaWYNCj4gPiAgICNlbmRpZiAvKiBDT05GSUdfQVJDSF9IQVNf
UEtFWVMgKi8NCj4gPiAgIA0KPiA+ICsjaWZkZWYgQ09ORklHX1g4Nl9VU0VSX1NIQURPV19TVEFD
Sw0KPiANCj4gDQo+IFNob3VsZCB3ZSBhYnN0cmFjdCB0aGlzIHRvIENPTkZJR19BUkNIX1VTRVJf
U0hBRE9XX1NUQUNLLCBzZWVpbmcNCj4gdGhhdCANCj4gb3RoZXIgYXJjaGl0ZWN0dXJlcyBtaWdo
dCBzaW1pbGFybHkgbmVlZCBpdD8NCg0KVGhlcmUgd2FzIGFuIEFSQ0hfSEFTX1NIQURPV19TVEFD
SyBidXQgaXQgZ290IHJlbW92ZWQgZm9sbG93aW5nIHRoaXMNCmRpc2N1c3Npb246DQoNCmh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvZDA5ZTk1MmQ4YWU2OTZmNjg3ZjA3ODdkZmViN2JlNzY5
OWMwMjkxMy5jYW1lbEBpbnRlbC5jb20vDQoNCk5vdyB3ZSBoYXZlIHRoaXMgbmV3IFJGQyBmb3Ig
cmlzY3YgYXMgcG90ZW50aWFsbHkgYSBzZWNvbmQNCmltcGxlbWVudGF0aW9uLiBCdXQgaXQgaXMg
c3RpbGwgdmVyeSBlYXJseSwgYW5kIEknbSBub3Qgc3VyZSBhbnlvbmUNCmtub3dzIGV4YWN0bHkg
d2hhdCB0aGUgc2ltaWxhcml0aWVzIHdpbGwgYmUgaW4gYSBtYXR1cmUgdmVyc2lvbi4gU28gSQ0K
dGhpbmsgaXQgd291bGQgYmUgYmV0dGVyIHRvIHJlZmFjdG9yIGluIGFuIEFSQ0hfSEFTX1NIQURP
V19TVEFDSyBsYXRlcg0KKGFuZCBzaW1pbGFyIGFic3RyYWN0aW9ucykgb25jZSB0aGF0IHNlcmll
cyBpcyBtb3JlIG1hdHVyZSBhbmQgd2UgaGF2ZQ0KYW4gaWRlYSBvZiB3aGF0IHBpZWNlcyB3aWxs
IGJlIHNoYXJlZC4gSSBkb24ndCBoYXZlIGEgcHJvYmxlbSBpbg0KcHJpbmNpcGxlIHdpdGggYW4g
QVJDSCBjb25maWcsIGp1c3QgZG9uJ3QgdGhpbmsgd2Ugc2hvdWxkIGRvIGl0IHlldC4NCg0KPiAN
Cg==
