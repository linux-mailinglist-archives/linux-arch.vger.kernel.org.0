Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6425473A838
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jun 2023 20:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjFVS1w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jun 2023 14:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjFVS1u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2023 14:27:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84122100;
        Thu, 22 Jun 2023 11:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687458467; x=1718994467;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qHta24Vr4DSBznieQiAPUgWNUvVlFY7J9DsOMpLvApk=;
  b=ADC8KgXFDsS7jQUe+o1Z6a7+ILfgg142N19TBOMnDq0immHUbtfuwtOQ
   DgDahuLDu8JgjzNwrtPG0e7KatW+0QUi6TM1PvCeZKfa5pF32X37No2Yu
   re39m6oL0j/+92Nf5LlCdQhx3kFfOsTwdboLfGLA0ScJB2SrjtvCLPsUD
   Fk3Tj0/lq15Ni3F89G/sLs+jAE0gOjNH1kL45mDnlQpXlUQsF4WO3Jd5Y
   GjH3BUH/i075zYwq3bT4CHKzdD21WbLUEk5xe1ge2cuygbVm3zyjDrT1p
   QqLCCiiOtNsUMy7awmasi04d2TusuJo3oTp3s7g6gboaxuE7a0AtNtQGL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="350333303"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="350333303"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 11:27:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="709176521"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="709176521"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 22 Jun 2023 11:27:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 11:27:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 11:27:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 11:27:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 11:27:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncC7il4w3RGMGp/Tk+J22180lkxW8ffTE7BUgTPs95ExdkD21NdubPzex4rKQ0lz6QMY94OXxzdDkwOrFHWXJedw/jfCppSYit0C4yRkMKIIl9nsmLK5G6HSWjc/3Y42sH89CRATN7gjV3Xm1XSw5j6Kn8LjtFHyb+vfatsAO7wVHptYeyItRQ6bBk/1S9SptwlIbnH9uSGWwPbm3GZps8Dx5IDZij5tMPPuaHTPTtRYlCr1LYsQeCfv2P6ec8vdshvXww6bcN15hkT69sRy/UOgDJFEEF0qUIDxGQrDFDSNLDC4voll3xSnzB4X9JzJPB2Hz6vkGeLfYXlPsQQ2fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHta24Vr4DSBznieQiAPUgWNUvVlFY7J9DsOMpLvApk=;
 b=dPLOlmBGErpAS/P8QP/+Gn3iIhnUvnsLqMzGaoYYvYgsA7uYzEG/Y8RYYlzJzpQZ08/CkTwr4R5xb+JOvZcU5y6DdnIQldIOPKaeOzOzZ1VeLkkld3uwqdVXrFcmLvHqZTHJYF0aNwkfOFAELjf995T1XQdCHM38enMz5Z7GMMLaWIDNiuB5XoT5SJIOOP+W3mxb+hEQfZmw5GoIDvUHlqZD2qaj+qDjsNu/ZNV5+2+KyH+0cEIPZAp6v3SzRRQwVEuw1YmZ08kF1XB4+/C28fNDhpicX3kpErqoeHkBQGnhieN3mbkqyR/dlh5Q+xY8Y4A/nnwBAOYq2dKoicAswA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH7PR11MB6978.namprd11.prod.outlook.com (2603:10b6:510:206::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Thu, 22 Jun
 2023 18:27:40 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec%7]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 18:27:40 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "willy@infradead.org" <willy@infradead.org>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
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
        "rppt@kernel.org" <rppt@kernel.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
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
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 16/42] mm: Add guard pages around a shadow stack.
Thread-Topic: [PATCH v9 16/42] mm: Add guard pages around a shadow stack.
Thread-Index: AQHZnYvCDMsjzRn1dEqACIu9bb3yrq+XMYOAgAAB2IA=
Date:   Thu, 22 Jun 2023 18:27:40 +0000
Message-ID: <ba77d21492e2631072f51328413d227f31dd78ae.camel@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
         <20230613001108.3040476-17-rick.p.edgecombe@intel.com>
         <ZJSRD1xZauOW3jFO@casper.infradead.org>
In-Reply-To: <ZJSRD1xZauOW3jFO@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH7PR11MB6978:EE_
x-ms-office365-filtering-correlation-id: e0eefaf9-d5d1-42eb-95c5-08db734e5cbf
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pHVotlmNWBNyCuxL7tRhYvjepTkb6NyGeXNAjmiUVBbSsiZWAIhhBFZHcuvtcdZytUYG3z6YWYrOP/VqwJAcUOrwr62AuL88bSCEpRDyrEWOLvSI3/gnH1X8G/pX1yZiPfxC+usiuq+VktO509TJD7nMLlKJTXgX5x7bLzvnOPDCMwLp6D0a7mp77Kwbe7rI29RgcoLlzusx8Q/95E6j344VROpDe/ezlzRodBJxCJ06fdSWXsIZFTNZLup+16YBmqMxLZr8CTb2YWJsQTzE7VvYqDaCfLhkjTYm0xXu8cwNZd1ljB4+dARL3sKSJHeBpVikT85mcEmdoqZ8oMQ4nZ1k/Hgf03JAeGzhFdajWeDffoPzGMfbf/2CE/ckzaFdeRJti/v740CbC8CHWFHYlzYF+Q3eNPJnnuE2zlXvmbvORD4UvFu4Wp03OWJmfAOj99PO1Gi+II3qnPT0X7XdcamGY5cYWDp3EdwwpSEoFW9RqigNCtt04ESmM8TCqX1sYazFy7GOWEEEM0aWKH96ox606vltU5D6GQSDuz/mrvaVbvZa0o0YHU8HceHZfgiWpLHXkOcZ+8umWmWWdZosbTJLPwCraQ6X80CYe11XraE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(39860400002)(376002)(136003)(451199021)(6506007)(186003)(36756003)(7406005)(7416002)(5660300002)(6916009)(8676002)(66446008)(66556008)(38100700002)(316002)(4326008)(8936002)(64756008)(122000001)(86362001)(76116006)(91956017)(66946007)(82960400001)(2616005)(966005)(6486002)(38070700005)(478600001)(26005)(2906002)(6512007)(66476007)(41300700001)(71200400001)(83380400001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b09xY3c1NEFSNUdRVHhRak52dmlPeFhvQVlpMkNxWkZ5U1h0Zk9Bb0FlbUR1?=
 =?utf-8?B?VlFqcThNdVhFQURjdnk0M1dOS3JNaDJyZGQvY3dVanFmb1VpR1NMVXgrczRZ?=
 =?utf-8?B?dUpFbHJVUThFaFRCdkxKZlJ4TnJ3cnJqWGNKVUNCeWZaMXE2NEZRT0lQMkIv?=
 =?utf-8?B?OWhSWURBRHBkSytLNGY1ZlJJcEhKWDY3elgwUjhrMEdvR3YraGZkVTR2Nytw?=
 =?utf-8?B?M0NoU1VtbGtObGRJYlpkYzZNUThGa1d6L0UwYXF4MHJYZ3dqQlBzTWlFcnha?=
 =?utf-8?B?cWJFR1RaTVVDQ3dnWnRzODBQT0I3T3Ivd3lyVTZCMjQyakJXZlpWc2hya2l6?=
 =?utf-8?B?NnJaWXMzMnpsc2RCTjl4cEZmSTZVOUVIMk15Y2szRlZmYWlWWFFoajFDbEdn?=
 =?utf-8?B?U2NGNWErZmNnTkNrZ2VmVTNoM1grYndpaS9MVytoWXBWVXd5QnRqTXUxTCsr?=
 =?utf-8?B?RDl2ZGkyUDZzTlNpR0had3BBYVNSV1VuS3hqZTVRYVhNQXFJdUpSWlBRc2VZ?=
 =?utf-8?B?N3k3UkRER0xDS205cnVmckdnTFl6QTRtM0YvYzMvRmdQQkZsczN1R3JnNlRE?=
 =?utf-8?B?U0FId1pEUDc2WXR2aFlvaWMxczA3OWRQK21lK0RjK0p1VzhEUEhNR09uM3FT?=
 =?utf-8?B?UEpyTDViQlh2aDBaRVNnNGRXVUJtREtZWU1nUXdmc2ZSS2w3VG8xcmlNbVpJ?=
 =?utf-8?B?cjZMWGZudjhiWWMwZmptc0xrZzdVVCtSaURHcERZS3VLNVBmb3p3RE1kb2RR?=
 =?utf-8?B?RXNxMUtWcGdTemtlWWp6VnFlUGd3anI5QVFxSjMxMWdPYnBKclhOWWRTWmhk?=
 =?utf-8?B?blhTOG91QXVsY0p0NnJsT1BLb0MyOTcrOUVjcGg0VXpTK2IyTU5UY3I4K0VY?=
 =?utf-8?B?VnJ4SkR1b3dxM1NQaHVEVHgvb3FBWG4zN3F3Q0hWUmo1Ti8weTdUMmhWaTJN?=
 =?utf-8?B?UVQ1d2lUY1JKSmZndmF0VUJjSmhydXc1NE90NWQ4MHNLNHVXd0h3SEl5YkhK?=
 =?utf-8?B?bUZycUZNUUJMVVgzdUtXTVBzaCsvdUI5bENvS0U1ZFZ6YUlHUWJQN0tFRDlW?=
 =?utf-8?B?L2VIMksrS2FTTElJRXRIUHNaNmlGN3k1eFFPaVNMN09RcUNKUGhoVWl1N3Ew?=
 =?utf-8?B?SDlIMGduYkVScjQ2QTFUZnMvREpQd3l3QVNrM3hiOGRoWmNJOWwxODZWbjhT?=
 =?utf-8?B?ZTRGYWtPNXliVGlEVzdsaDJBemVxQWd1Z0loeUFPTmEybmg5QlFEbXRSWXlj?=
 =?utf-8?B?UE1ld3h0Qms1THMyeXNKbVdKcncreWxGcmVadEtJUUZtNXFGSDBaT0IvQ09Y?=
 =?utf-8?B?azRtTFNxMDh0clNLYXkvQlpRZjRSaVZtWFJYMkdNQ0xlOUxrMkJ0eXpIZWhv?=
 =?utf-8?B?dGZadytvTCtEQzRURnBudmVVRUtFZE92dHhPVHNldmdKTlo5RGJiKzZSaWRx?=
 =?utf-8?B?c0tkV1p4d281YzAyc2FETm1xSXI3TnN0L2ZXT3d6R3kwaHdDOU9qKzNmSERh?=
 =?utf-8?B?ekJrTXVpUFVJellveFBoWHFpeXcra2N3a3BpMGt6dzBVeFpxT0dtdHpZSkRP?=
 =?utf-8?B?RVI5T0RSUzlDdWU4YVZoMjdjZ2Njbmk0Mi9oM1Y3OU1NNHZlODJidW5aMzVZ?=
 =?utf-8?B?RkdoaVA4dlcrcHIySDFsREdyUVd5Yk9ORHYzeGZqOWhtYmd3RVZZWDFKdHp5?=
 =?utf-8?B?WXZ6YytETTl1bGJzVFJnVmJ0aWhPanI0cXo1MlNZbUhqeFNIN1lTMmpPdnN2?=
 =?utf-8?B?SHlDckJMVHIzakZEcnhuSUZha3ppekRWcVJkOGRSTTg4M2VrZVZiSDF4bmFK?=
 =?utf-8?B?TDdLcjBTZ1pTSjkxTlBPOHRISWFKVzlOcVhGdzVickZucDBFL2NZUHNjZ2xV?=
 =?utf-8?B?UFpNU3RvMWZzMUowekRzZW00VkFHYU9UamN0d0c4UXJzMXBQenVSN1kra00x?=
 =?utf-8?B?ZTVPRzRJMVVNaitrelMvRzYrZWgwMXBhNmJQV1IzSGE4YXVpbWlmRHBpS2d3?=
 =?utf-8?B?ZGJLZmpkd24wMzV1T3VTcDRmT2Z0UEJjdGYxWStJdG1hZU9DRStMVTlTR2Fm?=
 =?utf-8?B?WGpZanZaTDZkNm45a3pvcHlyRnlzbEpQVWFidGQ1UFo2NzlxdnF6ZDVCcEgy?=
 =?utf-8?B?cXh6MFhLaENzWWxTNlhMNG42REFUYnNFZjlMU0ttc3hiaklsbnpuVi8vRzJW?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D17A4053EC50B4BB1A1EB905A68ACF6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0eefaf9-d5d1-42eb-95c5-08db734e5cbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 18:27:40.3695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hCs0aHQFRcX2SAwhMu1Mmr/TzfEZZ4n8nhSS6lVL1alNXq955sklP7VTmxNwnMv5Bux4IVbZCOerP3KzhUHlPGJuT/dgy8BwwPz65wjWa98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6978
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVGh1LCAyMDIzLTA2LTIyIGF0IDE5OjIxICswMTAwLCBNYXR0aGV3IFdpbGNveCB3cm90ZToN
Cj4gT24gTW9uLCBKdW4gMTIsIDIwMjMgYXQgMDU6MTA6NDJQTSAtMDcwMCwgUmljayBFZGdlY29t
YmUgd3JvdGU6DQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9tbS5oDQo+ID4gQEAgLTM0Miw3ICsz
NDIsMzYgQEAgZXh0ZXJuIHVuc2lnbmVkIGludCBrb2Jqc2l6ZShjb25zdCB2b2lkDQo+ID4gKm9i
anApOw0KPiA+IMKgICNlbmRpZiAvKiBDT05GSUdfQVJDSF9IQVNfUEtFWVMgKi8NCj4gPiDCoCAN
Cj4gPiDCoCAjaWZkZWYgQ09ORklHX1g4Nl9VU0VSX1NIQURPV19TVEFDSw0KPiA+IC0jIGRlZmlu
ZSBWTV9TSEFET1dfU1RBQ0vCoMKgwqDCoMKgwqDCoFZNX0hJR0hfQVJDSF81IC8qIFNob3VsZCBu
b3QgYmUgc2V0DQo+ID4gd2l0aCBWTV9TSEFSRUQgKi8NCj4gPiArLyoNCj4gPiArICogVGhpcyBm
bGFnIHNob3VsZCBub3QgYmUgc2V0IHdpdGggVk1fU0hBUkVEIGJlY2F1c2Ugb2YgbGFjayBvZg0K
PiA+IHN1cHBvcnQNCj4gPiArICogY29yZSBtbS4gSXQgd2lsbCBhbHNvIGdldCBhIGd1YXJkIHBh
Z2UuIFRoaXMgaGVscHMgdXNlcnNwYWNlDQo+ID4gcHJvdGVjdA0KPiA+ICsgKiBpdHNlbGYgZnJv
bSBhdHRhY2tzLiBUaGUgcmVhc29uaW5nIGlzIGFzIGZvbGxvd3M6DQo+ID4gKyAqDQo+ID4gKyAq
IFRoZSBzaGFkb3cgc3RhY2sgcG9pbnRlcihTU1ApIGlzIG1vdmVkIGJ5IENBTEwsIFJFVCwgYW5k
DQo+ID4gSU5DU1NQUS4gVGhlDQo+ID4gKyAqIElOQ1NTUCBpbnN0cnVjdGlvbiBjYW4gaW5jcmVt
ZW50IHRoZSBzaGFkb3cgc3RhY2sgcG9pbnRlci4gSXQNCj4gPiBpcyB0aGUNCj4gPiArICogc2hh
ZG93IHN0YWNrIGFuYWxvZyBvZiBhbiBpbnN0cnVjdGlvbiBsaWtlOg0KPiA+ICsgKg0KPiA+ICsg
KsKgwqAgYWRkcSAkMHg4MCwgJXJzcA0KPiA+ICsgKg0KPiA+ICsgKiBIb3dldmVyLCB0aGVyZSBp
cyBvbmUgaW1wb3J0YW50IGRpZmZlcmVuY2UgYmV0d2VlbiBhbiBBREQgb24NCj4gPiAlcnNwDQo+
ID4gKyAqIGFuZCBJTkNTU1AuIEluIGFkZGl0aW9uIHRvIG1vZGlmeWluZyBTU1AsIElOQ1NTUCBh
bHNvIHJlYWRzDQo+ID4gZnJvbSB0aGUNCj4gPiArICogbWVtb3J5IG9mIHRoZSBmaXJzdCBhbmQg
bGFzdCBlbGVtZW50cyB0aGF0IHdlcmUgInBvcHBlZCIuIEl0DQo+ID4gY2FuIGJlDQo+ID4gKyAq
IHRob3VnaHQgb2YgYXMgYWN0aW5nIGxpa2UgdGhpczoNCj4gPiArICoNCj4gPiArICogUkVBRF9P
TkNFKHNzcCk7wqDCoMKgwqDCoMKgIC8vIHJlYWQrZGlzY2FyZCB0b3AgZWxlbWVudCBvbiBzdGFj
aw0KPiA+ICsgKiBzc3AgKz0gbnJfdG9fcG9wICogODsgLy8gbW92ZSB0aGUgc2hhZG93IHN0YWNr
DQo+ID4gKyAqIFJFQURfT05DRShzc3AtOCk7wqDCoMKgwqAgLy8gcmVhZCtkaXNjYXJkIGxhc3Qg
cG9wcGVkIHN0YWNrIGVsZW1lbnQNCj4gPiArICoNCj4gPiArICogVGhlIG1heGltdW0gZGlzdGFu
Y2UgSU5DU1NQIGNhbiBtb3ZlIHRoZSBTU1AgaXMgMjA0MCBieXRlcywNCj4gPiBiZWZvcmUNCj4g
PiArICogaXQgd291bGQgcmVhZCB0aGUgbWVtb3J5LiBUaGVyZWZvcmUgYSBzaW5nbGUgcGFnZSBn
YXAgd2lsbCBiZQ0KPiA+IGVub3VnaA0KPiA+ICsgKiB0byBwcmV2ZW50IGFueSBvcGVyYXRpb24g
ZnJvbSBzaGlmdGluZyB0aGUgU1NQIHRvIGFuIGFkamFjZW50DQo+ID4gc3RhY2ssDQo+ID4gKyAq
IHNpbmNlIGl0IHdvdWxkIGhhdmUgdG8gbGFuZCBpbiB0aGUgZ2FwIGF0IGxlYXN0IG9uY2UsIGNh
dXNpbmcgYQ0KPiA+ICsgKiBmYXVsdC4NCj4gPiArICoNCj4gPiArICogUHJldmVudCB1c2luZyBJ
TkNTU1AgdG8gbW92ZSB0aGUgU1NQIGJldHdlZW4gc2hhZG93IHN0YWNrcyBieQ0KPiA+ICsgKiBo
YXZpbmcgYSBQQUdFX1NJWkUgZ3VhcmQgZ2FwLg0KPiA+ICsgKi8NCj4gPiArIyBkZWZpbmUgVk1f
U0hBRE9XX1NUQUNLwqDCoMKgwqDCoMKgwqBWTV9ISUdIX0FSQ0hfNQ0KPiA+IMKgICNlbHNlDQo+
ID4gwqAgIyBkZWZpbmUgVk1fU0hBRE9XX1NUQUNLwqDCoMKgwqDCoMKgVk1fTk9ORQ0KPiA+IMKg
ICNlbmRpZg0KPiANCj4gVGhpcyBpcyBhIGxvdCBvZiB2ZXJ5IHg4Ni1zcGVjaWZpYyBsYW5ndWFn
ZSBpbiBhIGdlbmVyaWMgaGVhZGVyIGZpbGUuDQo+IEknbSBzdXJlIHRoZXJlJ3MgYSBiZXR0ZXIg
cGxhY2UgZm9yIGFsbCB0aGlzIHRleHQuDQoNClllcywgSSBjb3VsZG4ndCBmaW5kIGFub3RoZXIg
cGxhY2UgZm9yIGl0LiBUaGlzIHdhcyB0aGUgcmVhc29uaW5nOg0KaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGttbC8wN2RlYWZmYzEwYjFiNjg3MjFiYmJjZTM3MGUxNDVkOGZlYzJhNDk0LmNhbWVs
QGludGVsLmNvbS8NCg0KRGlkIHlvdSBoYXZlIGFueSBwYXJ0aWN1bGFyIHBsYWNlIGluIG1pbmQ/
DQo=
