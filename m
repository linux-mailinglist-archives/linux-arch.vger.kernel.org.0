Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C0573A6A3
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jun 2023 18:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjFVQzk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jun 2023 12:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjFVQzS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2023 12:55:18 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7942D2132;
        Thu, 22 Jun 2023 09:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687452887; x=1718988887;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KZLM9aeEqQ+6AMQqBsE9QwmXSSeuWxfwnVxhcbgpU/4=;
  b=KVmtb8tVlJ+b0gVsLkxv0LASUGbZ1qwYpqHTQfpaP7FnpCT8cNHHrsRC
   /v96yA35F9y7ozzd08YbPNfeRuD8yZ/HEJIJ0J4q1v7tIGqKYLSmfUlzX
   k7irQANghLrdyr0U551SuA6BdU16wZa0FBciy+xIxDrCozkU6LJBw2xwW
   ad9Ryl3U0mUrg3ZZhGZvEvzxPnrVy+BpsAPNgNsmYSwKujvetladG8gqR
   Kl2kVk5iQxxZ+Kwzb7XaWdt747zwpcpSdiq9c8i7TiGHc0k+LUg+qrHj7
   b1zx9EZlZgSRPLmh/pTdHvnlrD5w4SgQ5q5uIcsAq1BEQfkwii/eGPziV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="363991125"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="363991125"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 09:47:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="859523091"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="859523091"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 22 Jun 2023 09:47:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 09:47:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 09:47:48 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 09:47:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggcQ45YtKoBp0iP8rEwu0j2eFTPnurSYf0yTODsGLl+wZ9pRZzeOpVMTmMowNDcI3/8ojRFLnIjVupnwDxD9pBd/AuBfKuWctqkt1mSzAvMH5cdFSxyHSZXv0G1662EdQNikEDO3QFSSUaVLZmmYqmeMOqG4PjuYoa9zUNJth0Zti7gHnxACkT9Mp+peVrZHs771v6Iu49YlxHqhG34rJUEE4HMdQVnL8Z4AftQFzON8qBUsHsgdNndwb36H12hxIHInaoYwJhLNNRuFEhKEIsWduzfsCR2S2lTcg9X67aZVUAneQzJDezjnc2TbruecWQOOf94knCOy5H24PFg8sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZLM9aeEqQ+6AMQqBsE9QwmXSSeuWxfwnVxhcbgpU/4=;
 b=lxN/BihO1RYK+PpLSoZVSfCc+lI2jcfea0nuZl3gEan8Fpckn0eFSLhiT9XdojOJjiTPD2P8ktXfdhE8ebUie2In5SuuW3iCa0GA+t7X0zlQnTFvxFngE7OSwJ1uiOEZrVgagbraT5xdqMLFolErt6fkzZ4I8Pu2vFMVeHUk4TjvFRhpUESgn/KsK4UeOcs8v/k7cYoRlCqkqm/XrdfZQMdWUFS+NHA7ssEyWF9pE6LIcqk0FY3jJZ9g9XBdqTikcKful4AH6BP/ARC7se8f88glUvHwh7YziprSffAXNnGXEgHn+IAcuIfY38VXXBIj7mLf+FnMRdYQIm070Dh/PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SN7PR11MB7137.namprd11.prod.outlook.com (2603:10b6:806:2a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.39; Thu, 22 Jun
 2023 16:47:42 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec%7]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 16:47:42 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>
CC:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
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
Thread-Index: AQHZnYvD++9jHqJtDEOZ5j0eN4/f+6+IoOQAgAALyMOAACwFgIAAIG6AgAAMtoCAACGsAIAA96CAgABofQCAB1K5gIAAhUGAgAEVRoCAAKx+AIABDK+AgAB6bICAADpMAIAAqOGAgACLyYA=
Date:   Thu, 22 Jun 2023 16:47:41 +0000
Message-ID: <46a5ffc762bfd6ccb60c9568b7fb564d40c04c45.camel@intel.com>
References: <a0f1da840ad21fae99479288f5d74c7ab9095bb6.camel@intel.com>
         <ZImZ6eUxf5DdLYpe@arm.com>
         <64837d2af3ae39bafd025b3141a04f04f4323205.camel@intel.com>
         <ZJAWMSLfSaHOD1+X@arm.com>
         <5794e4024a01e9c25f0951a7386cac69310dbd0f.camel@intel.com>
         <ZJFukYxRbU1MZlQn@arm.com>
         <e676c4878c51ab4b6018c9426b5edacdb95f2168.camel@intel.com>
         <ZJLgp29mM3BLb3xa@arm.com>
         <c5ae83588a7e107beaf858ab04961e70d16fe32c.camel@intel.com>
         <5ae619e03ab5bd3189e606e844648f66bfc03b8f.camel@intel.com>
         <ZJQF636p80oywgqZ@arm.com>
In-Reply-To: <ZJQF636p80oywgqZ@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SN7PR11MB7137:EE_
x-ms-office365-filtering-correlation-id: 767d5daf-bee5-49e9-8f09-08db7340656c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FlizOWJDpcZ+b/a0iraVZkUeE3Si3f7Cw5lEXrfIV/N77nhvKYQ7xCEoPfPNd7vFjpGjf7y+9MvsAmEYbydJc2x7H2OMlHXMaUgxTCcmKwYI0FchnYAK6PVgzRyDwT+i8b7kWhlTTXmn0HNz9wG4H+YCSS+ikGLIFGUpiyAiupR2ggi0UW9vqULclgSK8b8rKeoi9T+azRIOnV6eYRJoCmThNJcJnrqkMu3e0hyZJEiWKAlVCkzUPHvD7zgK4uJRsWE/aqnF6Ozi4ewoaMtwOJOkS3ZbGPef9bV9/30aKNUvwPct1NTjO6XsFYm384t2MLbc8ciiIblIFjWSWiHYz5AivOAE3meEFKoQzJ8Sr0vzRmznvGOtgNJx6sAca9O0PMoV8C1j5GBlKypkxHaC1CBaLhBeY4NwSB/wjO6K5zq5v4vijkbVAM/Pm6ZvV6HXljHOvkRLRTVYaggQRbitWP+VDAJd6qlG/xsFfU3KMT/B29H+Lt3ab3yb/xh2dWVSSLjJim5Hby3TQWYwhiAnqHgPI4JQvmA3SCbKgms1lXzrHk+z+jlfaPCGZ85Li7OIA6wHPE4HjxlcDf8I5YsJbfhI5w8/aqP4HGjasrJr3wMeSeqhIZHN6J307jgcduVp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(366004)(396003)(346002)(451199021)(2906002)(66899021)(38070700005)(66946007)(76116006)(6486002)(66446008)(66476007)(66556008)(64756008)(4326008)(478600001)(36756003)(71200400001)(316002)(91956017)(110136005)(86362001)(54906003)(186003)(6512007)(83380400001)(26005)(6506007)(2616005)(38100700002)(82960400001)(122000001)(7406005)(5660300002)(8936002)(41300700001)(8676002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzJ4Z0tBcS81WXczRmtjdzhXemE2SlZDcDB1VWRRNmJhOVc4b0ZIU3M0bng2?=
 =?utf-8?B?TzRVMUhIM3JoNXg5RTRib1FRVDUrNGhXTmw5ZUIxYmk5RVNVdDF2TEJON1RD?=
 =?utf-8?B?L2ZjVlRIUDRpdFRKbDF5RW5CUWZBQjlTVWZQSFFzblR0ajB3TER0blVtczJW?=
 =?utf-8?B?enFBV1ZTZktOK3pyYmxYOWNuaXlRb01TQm5GYUs2VkNyYjAxVUlvZ0FQeEMr?=
 =?utf-8?B?MjUvTUU4Wlg0NXJ0RnlNQkZ5TFZmNStTcW04STVDR2FNVndhWFRnWkQ5dmRU?=
 =?utf-8?B?NFNKQjdTVGFQQzhNNlhEWTlNcGpZUDNvbGxjcjFoMDQxL0cwenNZT2JCTDZH?=
 =?utf-8?B?ZG4wZmtYdzdOVDdEaXZSb2UwcEdKSUt5TjBTdXI3Q3pTSTFmaUw3WnlhZU0w?=
 =?utf-8?B?Z3ZjK1hILzBMWGh5MjZWTDFDZ2tEdFJoWkIyUkpkam5GZU50ZVp2M2xFR1pU?=
 =?utf-8?B?My8wb0krZWJKbmh4NXQyTHN0d0ZFMlArK1RXRHY2RWp3cHhGazVoR1VZWEl6?=
 =?utf-8?B?RjlFb3pEVS9YUll5UDJXaGp6Q0RJTXRtT2tjZUcrQlQ5QlN0amNqSzFHQXhI?=
 =?utf-8?B?VzAvNWIyTTJwQk1EdWlxT1R1YmhtSU1xUXFUak4vajdpTE16cldvd3kxQlRK?=
 =?utf-8?B?V1Q4c3lBTmM4akJ2UW9UVEZIR25lOUYxV3F2eHY0QnNOMmhpYnFzL1pTeWw1?=
 =?utf-8?B?ZFI3c2hJRGxWRGNlNUJHdUpPTWFJeG0vK0dqbUpuQy8wdEd0MkkzVGZLcjli?=
 =?utf-8?B?ZFVEQVdEbXl3MFp6MTJKWnFteGkvamhjdWtWNnBSNS93WkNtQnVZNGY2dlRL?=
 =?utf-8?B?OWI3OVJJcStMeDBYbWhCS3NWOGVETVV0WjluNFpkYk45RVpBaGQ4Sklwb1RW?=
 =?utf-8?B?MnhEU3FJb1l0TjJQVkdHTmVnQ00wY2hVSUlKWnVQMVJ4ZFFZdXV6YVN1TGNx?=
 =?utf-8?B?RXV1ZEcyY2ZlSHRGNEwxT2NsUnp2Mk5QVlBhV3F1Q1dvZUMrZW1NbXhhaGJJ?=
 =?utf-8?B?TElpVy93WWRZNk0wR1M5cVMrNnNiYklSVFNHSmgyRHNEclMwR0ZYVFVveGEv?=
 =?utf-8?B?QmFDYVFJeGJFUjg1S1dSRmhMdk5FS3p2d3pEMU1ieEJjTlQzMG1ZVVB1QWQ1?=
 =?utf-8?B?Y29odDN4dGVSNDRiYzZ1MWtDb1JlT0pDNGxlaGdMUm1xOTJTRGd1bzdQTUxD?=
 =?utf-8?B?V1RXLzJpcU41K0tzQ0pCb0l0aFZmcHQ2WmFNTzBsQWp2N05OM2E1TWxJUHNM?=
 =?utf-8?B?TlRQc09ha2pnY2R6Y3Nwd0ppZU5TWUlVWmZCT1F6bVNZMStyTXE5VWFEYUQv?=
 =?utf-8?B?ZUVJcFRQSit2T2x3b29uNjl6OW9IL0tPNUIvWC9PQm9ZRWhFVU9jeWpFM1Z1?=
 =?utf-8?B?d1R3ZTR5Uko2NS91d1IwZnJGT08wOEhmbFZ2dXdhVzlRVXEwbHFGd3pSazhV?=
 =?utf-8?B?TTdweVNyTXNNcGRMd0NEUTFOMzRlUVM3eEdhcDFSVU5kVU1id1JmNzM2ODhu?=
 =?utf-8?B?MFFHTnVCRTRuWUs1MUtNSDF6aXJuanVuOU1jZzByV1ZnSThOdzBlTUNFR1hV?=
 =?utf-8?B?RTdVT1BIRlFHSUVvUUFuWW9KL2RPNENmOVgyallHQTd6RTRuYzBlWVJSMGdq?=
 =?utf-8?B?aHJKdHh5VFNxN1VuYU9IWkVMLzVmdGVQWnZsVWo4azVTczZvQzRrWC8yNjhN?=
 =?utf-8?B?MkJHaEZuUm9QNFo4aXI3K2N4a0lLS2ljOUtHbk1ySnBFcUZJN3hoRTlMZHRa?=
 =?utf-8?B?U2xSdHhsL0VIYlJQZ1ZvcVBRTWtFT2ZXYlNwenNWaHphc1pMRENiRXJ1Qnh0?=
 =?utf-8?B?V1ZtZHRkdkRibGxnaEZzYUtlRHZ1TkdXb1lldzJxcHNjWGlaYzViemN0emlS?=
 =?utf-8?B?ekFpS1hsMFh1TlB4dG85cFVBaGxTcXJXTEpRRTd4RERmUVZLRlZ5NkNWUTBj?=
 =?utf-8?B?TTNiMHMxekIzTGl0bW9oQ29VR3RFUWdRVHNjVFlRd1ZzRko5VVRRVmFBWmw5?=
 =?utf-8?B?RDRqZXNJNmRZR0FKUlhiMzVMYWFqMDRMMHE1bXh0TzBDYjlySkxzNXo0amcy?=
 =?utf-8?B?S0pVbkIwZFlBa0RiOGpwRGQrbzRPN1RXdTlwckhoL1ZJU0k3YytWeUMvV3k3?=
 =?utf-8?B?Ym9MUG40ZE9HNlJEMGRLTTIxNWlXVUxGN2ZMYm5aWkhmelovYVZLUWhPZGdv?=
 =?utf-8?B?cVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A2D553479181E45A299E9CBC52B6517@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 767d5daf-bee5-49e9-8f09-08db7340656c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 16:47:41.9468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1eKtjmdlR1AhrvohPUoxWCjuqBmbtjmFI2ejIPf1SNEeWFnF2OHxEibdAorceeIxvreu7qnfIr0rXcP4VzSmg8M8F54CxwViOcq83dLyTfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7137
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVGh1LCAyMDIzLTA2LTIyIGF0IDA5OjI3ICswMTAwLCBzemFib2xjcy5uYWd5QGFybS5jb20g
d3JvdGU6DQoNCg0KWyBzbmlwIF0NCg0KPiBzd2FwY29udGV4dCBpcyBjdXJyZW50bHkgKm5vdCog
c3VwcG9ydGVkOiBmb3IgaXQgdG8gd29yayB5b3UgaGF2ZSB0bw0KPiBiZSBhYmxlIHRvIGp1bXAg
KmJhY2sqIGludG8gdGhlIHNpZ25hbCBoYW5kbGVyLCB3aGljaCBkb2VzIG5vdCB3b3JrDQo+IGlm
DQo+IHRoZSBzd2FwY29udGV4dCB0YXJnZXQgaXMgb24gdGhlIG9yaWdpbmFsIHRocmVhZCBzdGFj
ayAoaW5zdGVhZCBvZg0KPiBzYXkgYSBtYWtlY29udGV4dCBzdGFjaykuDQo+IA0KPiBqdW1waW5n
IGJhY2sgY2FuIG9ubHkgYmUgc3VwcG9ydGVkIGlmIGFsdCBzdGFjayBjYW4gYmUgcGFpcmVkIHdp
dGgNCj4gYW4gYWx0IHNoYWRvdyBzdGFjay4NCj4gDQo+IHVud2luZGluZyBhY3Jvc3MgYSBzZXJp
ZXMgb2Ygc2lnbmFsIGludGVycnVwdHMgc2hvdWxkIHdvcmsgZXZlbg0KPiB3aXRoIGRpc2NvbnRp
bm91cyBzaHN0ay4gbGliZ2NjIGRvZXMgbm90IGltcGxlbWVudCB0aGlzIHdoaWNoIGlzDQo+IGEg
cHJvYmxlbSBpIHRoaW5rLg0KDQpJIHdvdWxkIGJlIGhlbHBmdWwgaWYgeW91IGNvdWxkIGVudW1l
cmF0ZSB0aGUgY2FzZXMgeW91IHRoaW5rIGFyZQ0KaW1wb3J0YW50IHRvIHN1cHBvcnQuIEkgd291
bGQgbGlrZSB0byBzZWUgaG93IHdlIGNvdWxkIHN1cHBvcnQgdGhlbSBpbg0KdGhlIGZ1dHVyZSBp
biBzb21lIG1vZGUuDQoNCj4gDQo+ID4gQnV0IGhvdyBkb2VzIHRoZSBwcm9wb3NlZCB0b2tlbiBw
bGFjZWQgYnkgdGhlIGtlcm5lbCBvbiB0aGUNCj4gPiBvcmlnaW5hbA0KPiA+IHN0YWNrIGhlbHAg
dGhpcyBwcm9ibGVtPyBUaGUgbG9uZ2ptcCgpIHdvdWxkIGhhdmUgdG8gYmUgYWJsZSB0bw0KPiA+
IGZpbmQNCj4gPiB0aGUgbG9jYXRpb24gb2YgdGhlIHJlc3RvcmUgdG9rZW5zIHNvbWVob3csIHdo
aWNoIHdvdWxkIG5vdA0KPiA+IG5lY2Vzc2FyaWx5DQo+ID4gYmUgbmVhciB0aGUgc2V0am1wKCkg
cG9pbnQuIFRoZSBzaWduYWwgdG9rZW4gY291bGQgZXZlbiBiZSBvbiBhDQo+ID4gZGlmZmVyZW50
IHNoYWRvdyBzdGFjay4NCj4gDQo+IGkgcG9zdGVkIHRoZSBleGFjdCBsb25nam1wIGNvZGUgYW5k
IGl0IHRha2VzIGNhcmUgb2YgdGhpcyBjYXNlLg0KDQpJIHNlZSBob3cgaXQgd29ya3MgZm9yIHRo
ZSBzaW1wbGUgY2FzZSBvZiBsb25nam1wKCkgZnJvbSBhbiBhbHQgc2hhZG93DQpzdGFjay4gSSB3
b3VsZCBzdGlsbCBwcmVmZXIgYSBkaWZmZXJlbnQgc29sdXRpb24gdGhhdCB3b3JrcyB3aXRoIHRo
ZQ0Kb3ZlcmZsb3cgY2FzZS4gKHByb2JhYmx5IG5ldyBrZXJuZWwgZnVuY3Rpb25hbGl0eSkNCg0K
QnV0IEkgZG9uJ3Qgc2VlIGhvdyBpdCB3b3JrcyBmb3IgdW53aW5kaW5nIG9mZiBvZiBhIHVjb250
ZXh0IHN0YWNrLiBPcg0KdW53aW5kaW5nIG9mZiBvZiBhbiB1Y29udGV4dCBzdGFjayB0aGF0IHdh
cyBzd2FwcGVkIHRvIGZyb20gYW4gYWx0DQpzaGFkb3cgc3RhY2suDQoNCj4gDQo+IHNldGptcCBk
b2VzIG5vdCBuZWVkIHRvIGRvIGFueXRoaW5nIHNwZWNpYWwuDQo+IA0KPiB0aGUgaW52YXJpYW50
IGlzIHRoYXQgYW4gc2hzdGsgaXMgZWl0aGVyIGNhcHBlZCBieSBhIHJlc3RvcmUgdG9rZW4NCj4g
b3IgaW4gdXNlIGJ5IHNvbWUgZXhlY3V0aW5nIHRhc2suIHRoaXMgaXMgZ3VhcmFudGVlZCBhcmNo
aXRlY3R1cmFsbHkNCj4gKHdoZW4gc2hzdGsgaXMgc3dpdGNoZWQgd2l0aCBhbiBpbnN0cnVjdGlv
bikgYW5kIHNob3VsZCBiZSBndWFyYW50ZWVkDQo+IGJ5IHRoZSBrZXJuZWwgdG9vICh3aGVuIHNo
c3RrIGlzIHN3aXRjaGVkIGJ5IHRoZSBrZXJuZWwpLg0KPiANCj4gPiBJJ20gYWxzbyBub3Qgc3Vy
ZSBsZWF2aW5nIGEgdG9rZW4gb24gc2lnbmFsIGRvZXNuJ3Qgd2Vha2VuIHRoZQ0KPiA+IHNlY3Vy
aXR5DQo+ID4gaXQgaXQncyBvd24gd2F5IGFzIHdlbGwuIEFueSB0aHJlYWQgY291bGQgdGhlbiBz
d2FwIHRvIHRoYXQgdG9rZW4uDQo+ID4gV2hlcmUgYXMgdGhlIHNoYWRvdyBzdGFjayBzaWduYWwg
ZnJhbWUgc3NwIHBvaW50ZXIgY2FuIG9ubHkgYmUgdXNlZA0KPiA+IGZyb20gdGhlIHNoYWRvdyBz
dGFjayB0aGUgc2lnbmFsIHdhcyBoYW5kbGVkIG9uLg0KPiANCj4gYXMgZmFyIGFzIGknbSBjb25j
ZXJuZWQgaXQgaXMgYSB2YWxpZCBwcm9ncmFtbWluZyBtb2RlbCB0byBzd2l0Y2gNCj4gdG8gYSBz
dGFjayB0aGF0IGlzIGN1cnJlbnRseSBub3QgaW4gdXNlIGFuZCB3ZSBzaG91bGQgYWx3YXlzIGFs
bG93DQo+IHRoYXQuIChzaWduYWwgaGFuZGxlZCBvbiBhbiBhbHQgc3RhY2sgbWF5IG5vdCByZXR1
cm4pDQoNClNvbWUgcGVvcGxlIGp1c3Qgd2FudCBzaGFkb3cgc3RhY2sgZm9yIGxpa2UsIGEgc3Vw
ZXIgc3RhY2sgY2FuYXJ5LCBhbmQNCndhbnQgZXZlcnl0aGluZyB0byAianVzdCB3b3JrIi4gU29t
ZSBwZW9wbGUgd2FudCB0byBsb2NrIHRoaW5ncyBkb3duIGFzDQptdWNoIGFzIHBvc3NpYmxlIGFu
ZCBjaGFuZ2UgdGhlaXIgY29kZSB0byBkbyBpdCBpZiBuZWVkZWQuDQoNCkl0IHN1cmUgaXMgYSBj
aGFsbGVuZ2UgdG8gZmlndXJlIG91dCB3aGVyZSB0aGUgaGFwcHkgbWVkaXVtIGlzLiBJZGVhbGx5
DQp0aGVyZSB3b3VsZCBiZSBzZXZlcmFsIG1vZGVzIHNvIGFsbCB0aGUgdXNlcnMgY291bGQgYmUg
aGFwcHksIGJ1dCBJDQp3b3VsZG4ndCB3YW50IHRvIHN0YXJ0IHdpdGggdGhhdCBmb3IgbXVsdGlw
bGUgcmVhc29ucy4gQWx0aG91Z2ggd2UgZG8NCmhhdmUgV1JTUyB0b2RheSwgd2hpY2ggY2FuIHN1
cHBvcnQgcHJldHR5IG11Y2ggZXZlcnl0aGluZw0KZnVuY3Rpb25hbGl0eS13aXNlLg0KDQpCdXQg
aW4gYW55IGNhc2UsIHdlIGhhdmUgbGltaXRlZCByb29tIGZvciBtb3ZlbWVudC4gSSBhY3R1YWxs
eSBoYWQgc29tZQ0Kb3RoZXIgQUJJIHR3ZWFrcyBmdWxseSByZWFkeSB0byBwb3N0IGFyb3VuZCB0
aGUgdHJhY2luZyB1c2FnZXMsIGJ1dCBJDQpqdXN0IHRob3VnaHQgZ2l2ZW4gdGhlIHNpdHVhdGlv
biwgaXQgd2FzIGJldHRlciB0byBzdGFydCB3aXRoIHdoYXQgd2UNCmhhdmUuIFRoaXMgcHJvamVj
dCBjb3VsZCByZWFsbHkgdXNlIGEgdGltZSBtYWNoaW5lLi4uDQoNCj4gDQo+ID4gU28gSSB0aGlu
aywgaW4gYWRkaXRpb24gdG8gYmxvY2tpbmcgdGhlIHNoYWRvdyBzdGFjayBvdmVyZmxvdyB1c2UN
Cj4gPiBjYXNlDQo+ID4gaW4gdGhlIGZ1dHVyZSwgbGVhdmluZyBhIHRva2VuIGJlaGluZCBvbiBz
aWduYWwgd2lsbCBub3QgcmVhbGx5DQo+ID4gaGVscA0KPiA+IGxvbmdqbXAoKS4gKG9yIGF0IGxl
YXN0IEknbSBub3QgZm9sbG93aW5nKQ0KPiANCj4gdGhlIHJlc3RvcmUgdG9rZW4gbXVzdCBvbmx5
IGJlIGFkZGVkIGlmIHNoc3RrIGlzIHN3aXRjaGVkDQo+IChjdXJyZW50bHkgaXQgaXMgbm90IHN3
aXRjaGVkIHNvIGRvbid0IGFkZCBpdCwgaG93ZXZlciBpZg0KPiB3ZSBhZ3JlZSBvbiB0aGlzIHRo
ZW4gdGhlIHVud2luZGVyIGNhbiBiZSBmaXhlZCBhY2NvcmRpbmdseS4pDQoNCkkgZG8gYWdyZWUg
dGhhdCBhIHRva2VuIHNob3VsZCBub3QgYmUgYWRkZWQgd2hlbiB0aGUgc3RhY2sgaXMgbm90DQpz
d2l0Y2hlZCwgYXMgdG9kYXkuIEJ1dCBJIGRvbid0IGFncmVlIG9uIHRoaXMgc29sdXRpb24gZm9y
IGFsdCBzaGFkb3cNCnN0YWNrcy4gQWdhaW4sIEkgYWN0dWFsbHkgYnVpbHQgdGhhdCBleGFjdCBk
ZXNpZ24gaW4gYWN0dWFsIGNvZGUsIHNvDQppdCdzIG5vdCBhIE5JSCB0aGluZy4gSXQganVzdCBk
b2Vzbid0IHdvcmsgZm9yIHZhbGlkIHVzZSBjYXNlcy4NCg==
