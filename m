Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E8B72E877
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 18:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243096AbjFMQUW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jun 2023 12:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243081AbjFMQUT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 12:20:19 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0E7A1;
        Tue, 13 Jun 2023 09:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686673215; x=1718209215;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bhYJ198yachG0bkUeuem6pdiFKP0nPpamQIWNCMRb3M=;
  b=gH2/ZiXVGRRFQ1QCIeRNM2hQuLwPgXKTXFnd3TZe55YXiSoOIukBp+Rv
   +ovQuHvHG+XXwNtIIzOjqF5sxBIzGahK1HTlCKu1dQyLtSs20pWOzrvqb
   4/iBj1u51SpFPM345Aqa9iZ3vUTR9FE36oeuVddgoCrkhDgxicOtZfOAj
   mhVkPd9pZ4B64nIuCqw36NIc+c2KsboCHt/8b5fXoWLCERfRPaGVbf5kH
   x1RAJH+NQX3Oilv1RXIPH/kQWYo78QX8rCOLxvYmZH6926FFGywRuG3CL
   O3429lH6BkwvbmhHdr+PuZv9npfvdLefSJg2v3atEzqW82QtnKoNwS9pN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="343072763"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="343072763"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 09:19:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="885906195"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="885906195"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 13 Jun 2023 09:19:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 09:19:58 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 09:19:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 09:19:58 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 09:19:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcMyB/++InbxWu8gaP9ae4ftXUitO56Ys5DOQ0u79tiOm/i7j4QhCix5pyz1nI078atl+I3+NUhzJtrj4+wJshfIgmI73NlSlo5WGBvDeA53w/B6bvbhFGj4KplHf7PFKgCQIf34NP6X9hKKRZ9skaZlIeiKbumxh4LAHnbuAGniJvQbdmJvgq1WS7yrlM581cCRlmmp+LRM+yn3VGYqZs8iBA7eWjrmaPYHAWpJjJilxMCLqo4zJpWtllWX+ZXMiLCl1C7juCkOihyELGOeLoVHr6ImoVkYgWuDex5xlay5ydKHnTEEPyPlFlPQTeX4Vi1fFvfXOhJxIgOCoBV12w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhYJ198yachG0bkUeuem6pdiFKP0nPpamQIWNCMRb3M=;
 b=Ig5LXmsdymy7wYIpd9yJEjSrUn9Jkoq//a170ise01IopUnoaC1SHQvpWuFOFUVsWP5edTkO8U+u0zTUsYk0xu2Uq8VHth9Qr93P6FJPy27MKWEcdtCKQhOyeG0CbPZ/xggJyrUfIhIvZiP/Cg7M+/qdu6iSaMTEZuNGh7MQwJIEsgtmGKiEQDQO/C3lgLV8j9t8iwjQRwetw8Hcv7dVxIYZpXgoqnl97l4VgqAaw4DM9DXvDdgHn5DVD9s91zw5eo1PpVx9NjMZq90s31RdYf28vj7qO/Kc+AmJYtO43lB7pkss77z460FHrXjPYPGQARDfHgG5Q3gSFfeinXU+1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA1PR11MB7853.namprd11.prod.outlook.com (2603:10b6:208:3f7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Tue, 13 Jun
 2023 16:19:47 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec%7]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 16:19:47 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "rppt@kernel.org" <rppt@kernel.org>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 02/42] mm: Move pte/pmd_mkwrite() callers with no VMA
 to _novma()
Thread-Topic: [PATCH v9 02/42] mm: Move pte/pmd_mkwrite() callers with no VMA
 to _novma()
Thread-Index: AQHZnYu5myZdSN5guk62QnYDURPfWq+IWqsAgACP+gA=
Date:   Tue, 13 Jun 2023 16:19:46 +0000
Message-ID: <21b0342854b067c241206f422bc5b3254b43c7f5.camel@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
         <20230613001108.3040476-3-rick.p.edgecombe@intel.com>
         <20230613074428.GS52412@kernel.org>
In-Reply-To: <20230613074428.GS52412@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA1PR11MB7853:EE_
x-ms-office365-filtering-correlation-id: 9b9da263-0c70-4fea-b1e0-08db6c2a0157
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /U7vQk5+ikQZBx7KOG0adLmQN6e0O6ym32VFx4JTXPrIoxG3uL4Ie/WasOi78Vu1yBlDkMFVwdxWrS1tpE1ML9n/iKZf1WXQxAVeCXMKniNcnaowZ25DwiO7HOG754QPPRuVPUwLtonyqDRicfXbNoOUCmvGkVwVnWuC35RWoQX7r3HkihV/UZevAXp/aLBVytR+PtKMrTGATy7DqFCNtubzvVHBvwGzjUufJ1xw/dDdZvIvPfnMXYWndjyw/fVsbzbTd9X0LsId42H27OhwU5yfxfs/nP7ACsGpb2kqLCCcIApD1m8VTLd1bzDlvoygaWq4VdM5uQAL3/9XPnss6ks2xxfn2eIWEZLEClaQP8XlmvAd8sBVcmT+Pt1Hj4ODIpJMY5hQ37pGQwyVgvelM/nmrG3piwwB+g40adifaTAERKOSU0k23HMMTImnKMzdNR/seiN0zXEzpOPi6qeX55K4TGdmechiOB53xYU4YtYvL4O8it3HXasgPRy1pR2bUbpYX9SdZepxjCtXJ+fL7h5nv/8tiKEj2pZRZRrKN7OBT+oFb+kJ0NNCdaJKUw2qq2R5e2e+T2M3pRYC6fJ83iIRXduDKloq1clJi96oD6aDtLKRFaXa3jhS9FoUkkQQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199021)(38070700005)(86362001)(36756003)(91956017)(66556008)(4326008)(54906003)(6916009)(478600001)(71200400001)(316002)(66946007)(66476007)(64756008)(66446008)(76116006)(6486002)(5660300002)(2906002)(8936002)(7416002)(8676002)(7406005)(2616005)(82960400001)(41300700001)(122000001)(38100700002)(6512007)(6506007)(186003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTRBRFJjZFk4dyt0ZWJpUWhmUzVPcTltd1dVdVdoOHF5eDZFeFpMNjZ3cVNB?=
 =?utf-8?B?TnhtLzZXajB2eXY0UzVCd2tpU0dmYXU2MVN2NjNzY1I3QkszRERlWGVtMmZB?=
 =?utf-8?B?OXpEUVpVYmw5eWkycWpCRkJFVkZkUlVBVkNucERoeElUWlpGcHp0T0xqMmhQ?=
 =?utf-8?B?SmczOUd0NTN5aExHV1JmemxOZVhrMXNTWGhkelg2L1dYelVUczdxaTVaVkwr?=
 =?utf-8?B?NGJQK080NndrK1JzVzhBQks5SkNXYTBPazVNdXZpMGNvR1BVK1JvUDlnSHJn?=
 =?utf-8?B?MUI5TVIwOFFSWDhwSDVxSUxoVTdWbFNyV1dyOUQ3SG12dHhpN0NLMmN0Ry8v?=
 =?utf-8?B?MXBFeVdtcjB6R0t2dVhGckhVS25yVlBPSFNyOVdJSjhlaDdidzRacjNlNUpV?=
 =?utf-8?B?d09Dc0tPNzgzUU8wZDkrODV2MjFWeU5icEdYMGdIOFBlWjNQeWVHd1I5ZEdn?=
 =?utf-8?B?emNUK3luY1dlZ0JLM3pwY3pZNGFsYml1aGpadVZDM3VkaWtOd1BBU3NHTFRo?=
 =?utf-8?B?cUdFNjBmVUhJamV0czNzUDJscGlBeXZPQnJSMDRGTXIrbllRRERsaGl1QlF4?=
 =?utf-8?B?Z3hkWmJkWnJERkRxcW9UajVtRWU0T3FMdXB3eGhtZERuUUwyWGV1ZVlTVCtD?=
 =?utf-8?B?MTAxZVAvUDRoWUQrNjcreE0xTFBQaTllelNsRk1ROTk2R3FlK1ZSdFVzZXVn?=
 =?utf-8?B?bWtWU2F6aDNPQk5PM3JYVHVadnlSdUZXeWc3MzU4ZUFWNFNRdm96dEhPem9P?=
 =?utf-8?B?UUUzbDdScVhFcGpscmV3R0UzQnR5VlFPTE9SK1ZuWGhKQkNON0xTblNPODYw?=
 =?utf-8?B?VmNDVVN4ZGs0ZnZvbThqc0JyVVd4ckJtSndnWmg0Rzgyd08zMXhJdEFpT3Qy?=
 =?utf-8?B?anhPQWNpUHRCYm9hS2ZqME5xTzlLYTZhNmJSdnRTRDBaUXdrNGc2SURoR2Vx?=
 =?utf-8?B?OTRJM1JzMzVnTDZQbXlQY3FLSmovcHpCS3luVGxSbVBVU1piNTVXL0drZVhy?=
 =?utf-8?B?SGFkV0lmZ1EwcWZSM1kwTGhUYnoyK25qbXZLQkx2ays4MEplV0xhbEU0YVo0?=
 =?utf-8?B?OHVBU1djVWNqK1UyMW1nVlpUdm91SGM5dTVtVFRIa1N1WjZiangydHRmVWJr?=
 =?utf-8?B?RzFSdENPcVBPRmxCaFhJc3RIZHhCMFlaN1k3SUkxMXVIK1I0Rjh5aTEzMGpW?=
 =?utf-8?B?STd6cmQ3UnBsSTFaZXdnb2twUXhWQmgzWld5b3pEM3Z6QnFFdlRpTmFMaDF1?=
 =?utf-8?B?UFYrcGZhdEo3UzZHL0lUZkl4SWpRNVVhNmxnbDZIQndXWjdkdlhWZ1B3TTdj?=
 =?utf-8?B?N0tsMXN0eSt1T1k2KzY2a1BEQVBtRFlwSVhEU2JLUG1OWlhsakhlZ1JRZmk3?=
 =?utf-8?B?TFJ2S21pRDhJdzI5U1EzWjVveFdJMTRwUW9hMHJDSTBZQ1RUTDRpc1lKM0xi?=
 =?utf-8?B?cld0a0k3YVhpSU8rYWxTWTlhcDhjdXp4TTEyM3FxT1g0RWhWRW1uR2JPVHha?=
 =?utf-8?B?NkNSU0NId1dsUGloWTVaOUZKZm85NmVLWkRwa3BPWTU5THhLQ21YZldNamMx?=
 =?utf-8?B?T2tnWUt4aVdkOUZISXBmM0JDQmhHdU1GSHhlWEpwL2xqUTU4RExldlNuRHNX?=
 =?utf-8?B?NjlYVG5kd0pVNHN3ejQvYjA4TkhGdjViZVQvQXNtZmZEdEFYeTlvOGJGUDVH?=
 =?utf-8?B?blBuYjdvV3ZFTE00TlJWbEk3cEtmbWpEekZSQXlKRlJ3NmNnVnBnckd5RjVW?=
 =?utf-8?B?YktVeStxNzJ1STdzL3VaWk9Wbk5VTzRBckZPNld1VnNwU0s1eDlIRkhGR2Nk?=
 =?utf-8?B?bVI0Q3VoLys4YjcrTVM2QXlKOHdPWGZkaWpXNldCeGxmdGFIQmt3WnhKdEw4?=
 =?utf-8?B?UElxOVRHa0l6YTY4QktwNUY5Ynh5WDJRYXZQY0tYNjZ0bkVxZ2Z0blVhVmQx?=
 =?utf-8?B?cVM4TnY0K0dvbkRDV09XQmdsNHovcHI3N05CZzJuZlk3eVd3UXM3MTFxeTJp?=
 =?utf-8?B?bnY5RnNVZld1RXJXdzEvK0FTdGZidVRCaVdnOFg5MVc4Y3JWWDFtWVQxbmgw?=
 =?utf-8?B?R0xYOTVhMWNtL3hQZ3BsaTNqSCtxN3ZXaHdlSFl1eXo1MmEvSkpuRE1QdHhs?=
 =?utf-8?B?OXU4TE5COGJCcEVULzdncEh6U3d6T2tqcE1ybHBYV0RPWjYwbWdSRFc5OExE?=
 =?utf-8?B?M0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B3CEF624AE8DC41B02D10F98216A552@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b9da263-0c70-4fea-b1e0-08db6c2a0157
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 16:19:46.9659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ybYeNg36NgBEMUS4FaI2ZYO7hLFljUw/Kl0/VlfQCuI+9gz/nVKFUbj2Y97FPfQ5s1GVgQml4sOmxcvbZF6fdTaPhZ8dxwr9h8GswkD9Aao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7853
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIzLTA2LTEzIGF0IDEwOjQ0ICswMzAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiA+IFByZXZpb3VzIHBhdGNoZXMgaGF2ZSBkb25lIHRoZSBmaXJzdCBzdGVwLCBzbyBuZXh0IG1v
dmUgdGhlIGNhbGxlcnMNCj4gPiB0aGF0DQo+ID4gZG9uJ3QgaGF2ZSBhIFZNQSB0byBwdGVfbWt3
cml0ZV9ub3ZtYSgpLiBBbHNvIGRvIHRoZSBzYW1lIGZvcg0KPiANCj4gSSBoZWFyIHg4NiBtYWlu
dGFpbmVycyBhc2tpbmcgdG8gZHJvcCAicHJldmlvdXMgcGF0Y2hlcyIgOy0pDQo+IA0KPiBNYXli
ZQ0KPiBUaGlzIGlzIHRoZSBzZWNvbmQgc3RlcCBvZiB0aGUgY29udmVyc2lvbiB0aGF0IG1vdmVz
IHRoZSBjYWxsZXJzIC4uLg0KDQpSZWFsbHk/IEkndmUgbm90IGhlYXJkIHRoYXQuIEp1c3QgYSBz
dHJvbmcgYXZlcnNpb24gdG8gInRoaXMgcGF0Y2giLg0KSSd2ZSBnb3QgZmVlZGJhY2sgdG8gc2F5
ICJwcmV2aW91cyBwYXRjaGVzIiBhbmQgbm90ICJ0aGUgbGFzdCBwYXRjaCIgc28NCml0IGRvZXNu
J3QgZ2V0IHN0YWxlLiBJIGd1ZXNzIGl0IGNvdWxkIGJlICJwcmV2aW91cyBjaGFuZ2VzIi4NCg0K
PiANCj4gPiBwbWRfbWt3cml0ZSgpLiBUaGlzIHdpbGwgYmUgb2sgZm9yIHRoZSBzaGFkb3cgc3Rh
Y2sgZmVhdHVyZSwgYXMNCj4gPiB0aGVzZQ0KPiA+IGNhbGxlcnMgYXJlIG9uIGtlcm5lbCBtZW1v
cnkgd2hpY2ggd2lsbCBub3QgbmVlZCB0byBiZSBtYWRlIHNoYWRvdw0KPiA+IHN0YWNrLA0KPiA+
IGFuZCB0aGUgb3RoZXIgYXJjaGl0ZWN0dXJlcyBvbmx5IGN1cnJlbnRseSBzdXBwb3J0IG9uZSB0
eXBlIG9mDQo+ID4gbWVtb3J5DQo+ID4gaW4gcHRlX21rd3JpdGUoKQ0KPiA+IA0KPiA+IENjOiBs
aW51eC1kb2NAdmdlci5rZXJuZWwub3JnDQo+ID4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZw0KPiA+IENjOiBsaW51eC1zMzkwQHZnZXIua2VybmVsLm9yZw0KPiA+IENj
OiB4ZW4tZGV2ZWxAbGlzdHMueGVucHJvamVjdC5vcmcNCj4gPiBDYzogbGludXgtYXJjaEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gPiBDYzogbGludXgtbW1Aa3ZhY2sub3JnDQo+ID4gU2lnbmVkLW9mZi1i
eTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0KPiANCj4gUmV2
aWV3ZWQtYnk6IE1pa2UgUmFwb3BvcnQgKElCTSkgPHJwcHRAa2VybmVsLm9yZz4NCg0KVGhhbmtz
IQ0K
