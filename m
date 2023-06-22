Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F77673943F
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jun 2023 03:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjFVBHQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Jun 2023 21:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFVBHO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jun 2023 21:07:14 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56EF1739;
        Wed, 21 Jun 2023 18:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687396033; x=1718932033;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ws7Fr92QGrRASH71Gp8rZECgsSJ+ijozB2/k2olxTS8=;
  b=P8NMDiLtpuaYQ27X9hNqVAsem++Oh7nz+BuIPUPaWZRnmMBbvk6cMVkt
   PyD1VKeZg1a9WmCJcdL8NcxdIhfnq/RN7NGOWlMwta+S/WAhdSeqmRTt2
   QUxnWRXACew0s/Dlkpn9m74usOl9yRt+xJXKhf7N6/MzbZKmAaimyKZwX
   mbFcn8EiNgiFI2tQi3z0REjNlxpjVshxT8g1ZAXryysOG+b3zuSDzwGhI
   E8zVVWC9wgBgYL4MKdIGwqq4kAs2Ck3PnQ5OAf6P00WQVmPLLFv0fAG23
   RSPjiNE95LHNclkZbChmE4yVqYFXwgNfJ6lkaZKm5SZHbduqtYCprceMd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="360368338"
X-IronPort-AV: E=Sophos;i="6.00,262,1681196400"; 
   d="scan'208";a="360368338"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 18:07:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="780032176"
X-IronPort-AV: E=Sophos;i="6.00,262,1681196400"; 
   d="scan'208";a="780032176"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jun 2023 18:07:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 18:07:11 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 21 Jun 2023 18:07:11 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 21 Jun 2023 18:07:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQdQMbDQOBCgdleQxgjaWJY77FkPaGlu7O8X1p0Otvuff3UooaKjedBGWNI7KRMUPsqrJdlSlV9Y5MiwY0z2W+3tDxgCyUhW002KnWryRenyhojpHRd7KsAdALQZ33JU2U17jJZPGsOEhAa33oPtgUXvyUZ7E8zgC9++TLJfCtjVDqYGyYTVKDMxKwbW6MwOqYZsaxM3DWTQtWnBTRNVPQdEnkdRnuRgi2tpyQNdiltHLuJiKMA8+fYLooYdRUiLE2V+VrRZ/CB3Tkynyw1+atpoPbUId/egIKIEu9g2A2CCg2oSIdhyryPfiRzokZmjm/K4CP30iV4g64hNR9ZBQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ws7Fr92QGrRASH71Gp8rZECgsSJ+ijozB2/k2olxTS8=;
 b=gi896fXIXQavAkhd5oPkEJU0kDblUCRvlw9swJGEQnF0tTBP/N8UPxO+MXfmEWWBU1oTqyOdYXpVO6G69H2C+K3Vx2IKCr1KfnOLkKALFU/8OYYyG48LB3hr8vXEaEbh2kCvMzigFgQC7y0Y61tdVthvKhd+b6zZHrIBAhskQmNhfk4HjBmaI94SswnL9TxyWVA9AdhRWk5+5duj5jNK6jvoOFPQaDlqan0L0GSc6lunXjFVmu/ujOLNrJ5mfQww9S+zTb0bysuwRfNNo8sD7Xale/DGz+O3aHjABwDMTE0CL1d1tlr28Qr03LrD422xyjrwthGlalyZNFbL8phyOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA0PR11MB7377.namprd11.prod.outlook.com (2603:10b6:208:433::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Thu, 22 Jun
 2023 01:07:09 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec%7]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 01:07:09 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "hjl.tools@gmail.com" <hjl.tools@gmail.com>
CC:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "david@redhat.com" <david@redhat.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
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
Thread-Index: AQHZnYvD++9jHqJtDEOZ5j0eN4/f+6+IoOQAgAALyMOAACwFgIAAIG6AgAAMtoCAACGsAIAA96CAgABofQCAB1K5gIAAhUGAgAEVRoCAAKx+AIABDK+AgAB6bICAADpMAIAAC9qAgAAC1YCAAB8wgA==
Date:   Thu, 22 Jun 2023 01:07:08 +0000
Message-ID: <66042cf07ed596d33f714ef152153361c77567d7.camel@intel.com>
References: <1f04fa59-6ca9-4f18-b138-6c33e164b6c2@sirena.org.uk>
         <49eabafa97032dec8ace7361bccae72c6ecf3860.camel@intel.com>
         <fc2ebfcf-8d91-4f07-a119-2aaec3aa099f@sirena.org.uk>
         <a0f1da840ad21fae99479288f5d74c7ab9095bb6.camel@intel.com>
         <ZImZ6eUxf5DdLYpe@arm.com>
         <64837d2af3ae39bafd025b3141a04f04f4323205.camel@intel.com>
         <ZJAWMSLfSaHOD1+X@arm.com>
         <5794e4024a01e9c25f0951a7386cac69310dbd0f.camel@intel.com>
         <ZJFukYxRbU1MZlQn@arm.com>
         <e676c4878c51ab4b6018c9426b5edacdb95f2168.camel@intel.com>
         <ZJLgp29mM3BLb3xa@arm.com>
         <c5ae83588a7e107beaf858ab04961e70d16fe32c.camel@intel.com>
         <5ae619e03ab5bd3189e606e844648f66bfc03b8f.camel@intel.com>
         <CAMe9rOpZYwD=v0vcseBrjNvMy4J3Kgy2i8hCcBsU+1gNUcR9qA@mail.gmail.com>
         <c7df57a7489ff555fc531d19a5a4a689f6f99a7c.camel@intel.com>
In-Reply-To: <c7df57a7489ff555fc531d19a5a4a689f6f99a7c.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA0PR11MB7377:EE_
x-ms-office365-filtering-correlation-id: 4b1dce68-6a21-4357-ffb2-08db72bd0084
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NzBDWpcClG06yNVrxk3xRWgCavH/VaHG95/KFgOI0MYIugnvT8ZIHOaw7P7efkpFVfFFFVNNm8hNk0vY9Qvlcn8Kq4l5C7ix5cgCnAWQdwGEx+lxiT9MVRVZCaC0rq6t4dalzqZDJUO9FeAmKnbi0T6T/Pb/dALMSGhLdl40AOr6rf8IIl9hhjFT5TWtVkoXjj2tL2SiCT/8vmAl0ZwTCx8nhCDwa2CBgCErlesJcaOikXCRye4ob/Pi3ta83teJ5myVCTEBu3hXe1kaW/OYOCoIcMXpOR5gI53YWQo/ojhlccWApaRwcODsew8z1MqsqqZoeHPWAhYHtK09s+mSAVZrjPnFlMLBtHZiRsk8OGUIKFyKBSZ3f6DUQALSxPJm/2v1XWTcm+hLxuxK9MiaoaUs14OFGjDngXz09gj7WSMVhEwlTZRpA+zA9NGFWNVVb2K1U53pPGiuKR2TsYHl2LlZ1Ll7jx8uIhlWgjEUQhdeRwdrCJl8a/hLoF10NuVZS0zRtVXKRYHKU5Pm2PG9GUQ/LWOryf4wkMpIA2Mz+aOsV69MK5mw9bkvZ8zagUtgmxACCe9ECd8MLpqX1gy2D0dBFUHWpOSJICN+UcsUYvf0/Ur8/VSxx9o3VxphqI2N
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(7406005)(7416002)(83380400001)(6486002)(54906003)(91956017)(64756008)(316002)(38100700002)(8936002)(6512007)(8676002)(36756003)(26005)(2616005)(86362001)(4326008)(186003)(6506007)(41300700001)(5660300002)(66946007)(6916009)(76116006)(66556008)(66446008)(66476007)(82960400001)(122000001)(71200400001)(38070700005)(478600001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFN5cTl6ZmZsc0cvWllUdkg2aU5jZk5sWnFYT3pqcUFLMnB5aW9RS2tDUU8v?=
 =?utf-8?B?WXJ6azNFWUQ2THR6QzAyRWNtUVhEclNZb3B2WjFDcDhseEZtWFBqQm55eC9v?=
 =?utf-8?B?c3pyejlQNG1GZWtObTVzMFkyQVdzMUM2NkVXam9rOTA4N213WWZJMWI1K0VR?=
 =?utf-8?B?MnVtZFA5Z2pwMWw2dTF1d0czUko5aFNRdVBtK3doa0ttSWUzUjArN1NMcWJr?=
 =?utf-8?B?NnJWQysvWER3aDIxclNrZTFLc2xtR1V1aGhSeVRGby9XajI2eDJGR25GYU4r?=
 =?utf-8?B?SklDSXJRSWJ4QVkxb0hrVnlxREQwQjFXLzFqVC9yV0lhSXVuUkVxc2xmZ0Jo?=
 =?utf-8?B?bXNhREhFR01wKzRMaFJkRmFBeU84Ym96WWdYcFRiZFNiVjNPdFpNQ1pCNWtl?=
 =?utf-8?B?TUtwOHJTQjcvRHhhOU9tMmIwMC9rY3owQk9FSEdidktmbUQ2QlN0ZlExU3NG?=
 =?utf-8?B?RVE2VWdKR2V2WTBzalcxY0Z0ZFFzckNKcXRJTHBNanZvUFVSZHBHMmxRWHV0?=
 =?utf-8?B?UzI2bHFQaDEvaFdGOWp2bmxDQXFSbnR4Uk1FeGRwZy90ZmZCZ0IvMnRHYkFj?=
 =?utf-8?B?UThtTVU3TFFscGhWYTZ2dUg4a0ZnRXlFZVFqS0h1OFc4Sno5UGUwbkpzbGxr?=
 =?utf-8?B?YzRPRHpDYVBudWpMNGdDaGNNVmloUEJmSThKUmN3WVF4OG10NitTcmJhZzRz?=
 =?utf-8?B?MVlmQkV3Mll1d0lLRlNjYjU0Rk5ONHlVcFBxVUFuNWo4SVRMdzBkMWlyYzlI?=
 =?utf-8?B?cWcxaU1xbUp6eVllRi84SWdBOXdSc3h0WnlMc3NPU2p0VHhNMGZQemVUNHpO?=
 =?utf-8?B?SkhDdy9OTFRWbFprd2xqaHgrRGcvVmpVUWVXRkcydmlXREVNMGRrSDBMelU1?=
 =?utf-8?B?ZGlLUzhHa3l4OU1RZnNNVFhnUGFrSTFuNkRtYzhsbHdxQ3k0eVFPb244alU1?=
 =?utf-8?B?dnlxY2hBRys4ZnNSeWNOYWRPK1J2SC9rYUMvTXlqTHdSdVBmZnlMcFdPSkls?=
 =?utf-8?B?MkhPR2dHcitad24xSXA2blMrbjRsU1pHcWVDNUhsYlFtOFpmNEtEdUttdlYz?=
 =?utf-8?B?YmxDYW1RbjZwV2VDM2JKMUNnTE9sTzJYUm95OU1SRVIyNFlXMVJOUEYyNUd4?=
 =?utf-8?B?S3pPQkRpNHdHK00xTDZXMXd3RkQyYnRYa0IyT0NGK0xxeC8yYVJOaGFLdkhu?=
 =?utf-8?B?OUNPM2Vma0lOZ2V1ek04QTFiS2V5Q3A2ajY0Q0FMRi9wdjZxTk93dEhTWmlT?=
 =?utf-8?B?R1Z4RVZSRElyM1VzdElMb3Qramp3ZnQybGNMc1NBbWY5RnNOUVR6NjJjWVdj?=
 =?utf-8?B?Qk90d3RodDhWQkJtSnVvN1JSY3pHclYraG1rWlFOTzRiUGhBamo0Ukl0Qnkv?=
 =?utf-8?B?bW1JdTNIL1JocFlhNEdSd2NJdHJOaC91T25ManoxMnFtaFYvTXM4M2d0Y2k0?=
 =?utf-8?B?amloZUgzaVgvOC9sdEhXWlN6K29xLy9Oc0ZOekR1bkVwTXpOdGxSRW5ZQVEr?=
 =?utf-8?B?UnhyY2RieUkyZytyVE11R1FpaTFabFNSVy9MbXNoOTlqanFpMHFzM3FjRzUx?=
 =?utf-8?B?SkZlbitweXpYZkZKMDhweFNiUVJSWThFRUxTWFlXbUtPUVBqQm1VTUxXc29F?=
 =?utf-8?B?RGhHR1JUN0RFUWIva1VSdzdUNVRPek9XeDBHY0oxZlpOMGFuRDJmQmJTSmRY?=
 =?utf-8?B?MDFBQzQyMlVXNmZ0Znl0T0FKV1dXejZaT1p4bHU3aVZPWlF3bzhwZlE4RUll?=
 =?utf-8?B?SlFPbVNjU3g2Y0E0TTlzbFNxWnVHak1JZU9WK08vRjYyZVlVUFhEV3dvZjRF?=
 =?utf-8?B?cE1WOHpIUjhsUkplNWRDNGJXRDZFemt0dlZydFFBQXlwNmpsUFlZQTF1Wk42?=
 =?utf-8?B?Rks3eHBRZ1RaZytoQkJKRG1JbE4zZnAzVWlmVCtWR25xVVZiZDNwcFdCOVhK?=
 =?utf-8?B?aktFeklvdUtINUl0a2RVL2FURlkyY3VnT0t5UmFucllSSWgra3lGbHF3eVJQ?=
 =?utf-8?B?Mm9lQlZoNzVEZ1pLOUt0V3JvNmdOakZweWJBZEo1aTJDYlUyanlVblo3eEox?=
 =?utf-8?B?SEFUWW0xbi95QVZPRmpPTDZoWU93UGw2TStSS2dKTVFJMDVmM0paM2ZldFlN?=
 =?utf-8?B?a2JHQkxRMGFsYWlKTWF2MGVRK0ZmL0I4ZVJ6NytXUjhYR2J0OUJ1R1hmZVIx?=
 =?utf-8?B?eGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDAEB620EF340047A496EF66D6AC7110@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1dce68-6a21-4357-ffb2-08db72bd0084
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 01:07:08.5798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CjMRdWsdIE99E5slZc8iTOSNYNT2eGzueBd1wGFHLVHMNTcqfZ6V5ZmHEHHLByXeJnVE70X97TfbZI961ACUqqP79RC+TBlOe/ZL59fHP68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7377
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

T24gV2VkLCAyMDIzLTA2LTIxIGF0IDE2OjE1IC0wNzAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gT24gV2VkLCAyMDIzLTA2LTIxIGF0IDE2OjA1IC0wNzAwLCBILkouIEx1IHdyb3RlOg0KPiA+
ID4gV2hpY2ggbWFrZXMgbWUgdGhpbmsgaWYgd2UgZGlkIHdhbnQgdG8gbWFrZSBhIG1vcmUgY29t
cGF0aWJsZQ0KPiA+ID4gbG9uZ2ptcCgpDQo+ID4gPiBhIGJldHRlciB0aGUgd2F5IHRvIGRvIGl0
IG1pZ2h0IGJlIGFuIGFyY2hfcHJjdGwgdGhhdCBlbWl0cyBhDQo+ID4gPiB0b2tlbg0KPiA+ID4g
YXQNCj4gPiA+IHRoZSBjdXJyZW50IFNTUC4gVGhpcyB3b3VsZCBiZSBsb29zZW5pbmcgdXAgdGhl
IHNlY3VyaXR5IHNvbWV3aGF0DQo+ID4gPiAoaGF2ZQ0KPiA+ID4gdG8gYmUgYW4gb3B0LWluKSwg
YnV0IGxlc3Mgc28gdGhlbiBlbmFibGluZyBXUlNTLiBCdXQgaXQgd291bGQNCj4gPiA+IGFsc28N
Cj4gPiA+IGJlDQo+ID4gPiB3YXkgc2ltcGxlciwgd29yayBmb3IgYWxsIGNhc2VzIChJIHRoaW5r
KSwgYW5kIGJlIGZhc3RlciAobWF5YmU/KQ0KPiA+ID4gdGhhbg0KPiA+ID4gSU5DU1NQaW5nIHRo
cm91Z2ggYSBidW5jaCBvZiBzdGFja3MuDQo+ID4gDQo+ID4gU2luY2UgbG9uZ2ptcCBpc24ndCBy
ZXF1aXJlZCB0byBiZSBjYWxsZWQgYWZ0ZXIgc2V0am1wLCBsZWF2aW5nIGENCj4gPiByZXN0b3Jl
DQo+ID4gdG9rZW4gZG9lc24ndCB3b3JrIHdoZW4gbG9uZ2ptcCBpc24ndCBjYWxsZWQuDQo+IA0K
PiBPaCBnb29kIHBvaW50LiBIbW0uDQoNCkp1c3QgaGFkIGEgcXVpY2sgY2hhdCB3aXRoIEhKIG9u
IHRoaXMuIEl0IHNlZW1zIGxpa2UgaXQgKm1pZ2h0KiBiZSBhYmxlDQp0byBtYWRlIHRvIHdvcmsu
IEhvdyBpdCB3b3VsZCBnbyBpcyBzZXRqbXAoKSBjb3VsZCBhY3QgYXMgYSB3cmFwcGVyIGJ5DQpj
YWxsaW5nIGl0J3Mgb3duIHJldHVybiBhZGRyZXNzICh0aGUgZnVuY3Rpb24gdGhhdCBjYWxsZWQg
c2V0am1wKCkpLg0KVGhpcyB3b3VsZCBtZWFuIGluIHRoZSBjYXNlIG9mIGxvbmdqbXAoKSBub3Qg
YmVpbmcgY2FsbGVkLCBjb250cm9sIGZsb3cNCndvdWxkIHJldHVybiB0aHJvdWdoIHNldGptcCgp
IGJlZm9yZSByZXR1cm5pbmcgZnJvbSB0aGUgY2FsbGluZyBtZXRob2QuDQpUaGlzIHdvdWxkIGFs
bG93IGxpYmMgdG8gZG8gYSBSU1RPUlNTUCB3aGVuIHJldHVybmluZyB0aG91Z2ggc2V0am1wKCkg
DQppbiB0aGUgbm9uLXNoYWRvdyBzdGFjayBjYXNlLCBhbmQgZXNzZW50aWFsbHkgc2tpcCBvdmVy
IHRoZSBrZXJuZWwNCnBsYWNlZCByZXN0b3JlIHRva2VuLCBhbmQgdGhlbiByZXR1cm4gZnJvbSBz
ZXRqbXAoKSBsaWtlIG5vcm1hbC4gSW4gdGhlDQpjYXNlIG9mIGxvbmdqbXAoKSBiZWluZyBjYWxs
ZWQsIGl0IGNvdWxkIFJTVE9SU1NQIGRpcmVjdGx5IHRvIHRoZQ0KdG9rZW4sIGFuZCB0aGVuIHJl
dHVybiBmcm9tIHNldGptcCgpLg0KDQpBbm90aGVyIG9wdGlvbiBjb3VsZCBiZSBnZXR0aW5nIHRo
ZSBjb21waWxlcnMgaGVscCB0byBkbyB0aGUgUlNUT1JTU1ANCmluIHRoZSBjYXNlIG9mIGxvbmdq
bXAoKSBub3QgYmVpbmcgY2FsbGVkLiBBcHBhcmVudGx5IGNvbXBpbGVycyBhcmUNCmF3YXJlIG9m
IHNldGptcCgpIGFuZCBhbHJlYWR5IGRvIHNwZWNpYWwgdGhpbmdzIGFyb3VuZCBpdCAobWFrZXMg
c2Vuc2UNCkkgZ3Vlc3MsIGJ1dCBuZXdzIHRvIG1lKS4NCg0KQW5kIGFsc28sIHRoaXMgYWxsIHdv
dWxkIGFjdHVhbGx5IHdvcmsgd2l0aCBJQlQsIGJlY2F1c2UgdGhlIGNvbXBpbGVyDQprbm93cyBh
bHJlYWR5IHRvIGFkZCBhbiBlbmRiciBhdCB0aGF0IHBvaW50IHJpZ2h0IGFmdGVyIHNldGptcCgp
Lg0KDQpJIHRoaW5rIG5laXRoZXIgb2YgdXMgd2VyZSByZWFkeSB0byBiZXQgb24gaXQsIGJ1dCB0
aG91Z2h0IG1heWJlIGl0DQpjb3VsZCB3b3JrLiBBbmQgZXZlbiBpZiBpdCB3b3JrcyBpdCdzIG11
Y2ggbW9yZSBjb21wbGljYXRlZCB0aGFuIEkNCmZpcnN0IHRob3VnaHQsIHNvIEkgZG9uJ3QgbGlr
ZSBpdCBhcyBtdWNoLiBJdCdzIGFsc28gdW5jbGVhciB3aGF0IGENCmNoYW5nZSBsaWtlIHRoYXQg
d291bGQgbWVhbiBmb3Igc2VjdXJpdHkuDQoNCkFzIGZvciB1bndpbmRpbmcgdGhyb3VnaCB0aGUg
ZXhpc3Rpbmcgc3dhcGNvbnRleHQoKSBwbGFjZWQgcmVzdG9yZQ0KdG9rZW5zLCB0aGUgcHJvYmxl
bSB3YXMgYXMgYXNzdW1lZCAtIHRoYXQgaXQncyBkaWZmaWN1bHQgdG8gZmluZCB0aGVtLg0KRXZl
biBjb25zaWRlcmluZyBicnV0ZSBmb3JjZSBvcHRpb25zIGxpa2UgZG9pbmcgbWFudWFsIHNlYXJj
aGVzIGZvciBhDQpuZWFyYnkgdG9rZW4gdG8gdXNlIHR1cm5lZCB1cCBlZGdlIGNhc2VzIHByZXR0
eSBxdWljay4gU28gSSB0aGluayB0aGF0DQpraW5kIG9mIGxlYXZlcyB1cyB3aGVyZSB3ZSB3ZXJl
IG9yaWdpbmFsbHksIHdpdGggbm8ga25vd24gc29sdXRpb25zDQp0aGF0IHdvdWxkIHJlcXVpcmUg
YnJlYWtpbmcga2VybmVsIEFCSSBjaGFuZ2VzLg0KDQoNCkFyZSB5b3UgaW50ZXJlc3RlZCBpbiBo
ZWxwaW5nIGdldCBsb25nam1wKCkgZnJvbSBhIHVjb250ZXh0IHN0YWNrDQp3b3JraW5nIGZvciBz
aGFkb3cgc3RhY2s/IE9uZSBvdGhlciB0aGluZyB0aGF0IGNhbWUgdXAgaW4gdGhlDQpjb252ZXJz
YXRpb24gd2FzIHRoYXQgd2hpbGUgaXQgaXMga25vd24gdGhhdCBzb21lIGFwcHMgYXJlIGRvaW5n
IHRoaXMsDQp0aGVyZSBhcmUgbm8gdGVzdHMgZm9yIG1peGluZyBsb25nam1wIGFuZCB1Y29udGV4
dCBpbiBnbGliYy4gU28gd2UgbWF5DQpub3Qga25vdyB3aGljaCBjb21iaW5hdGlvbnMgb2YgbWl4
aW5nIHRoZW0gdG9nZXRoZXIgZXZlbiB3b3JrIGluIHRoZQ0Kbm9uLXNoYWRvdyBzdGFjayBjYXNl
Lg0KDQpJdCBjb3VsZCBiZSB1c2VmdWwgdG8gYWRkIHNvbWUgdGVzdHMgZm9yIHRoaXMgdG8gZ2xp
YmMgYW5kIHdlIGNvdWxkIGdldA0Kc29tZSBjbGFyaXR5IG9uIHdoYXQgYmVoYXZpb3JzIHNoYWRv
dyBzdGFjayB3b3VsZCBhY3R1YWxseSBuZWVkIHRvDQpzdXBwb3J0Lg0K
