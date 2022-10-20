Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D143606B01
	for <lists+linux-arch@lfdr.de>; Fri, 21 Oct 2022 00:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiJTWIe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Oct 2022 18:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJTWId (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Oct 2022 18:08:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A741226E5E;
        Thu, 20 Oct 2022 15:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666303711; x=1697839711;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MyqIVR85USTu+w4R8ZsGUd/WIUxzYMH/JFpkOEKXFws=;
  b=HSbL73/QyUy57m2wipU759GCCrDfmIsX3La7GJExWyN74AWLp0rTgpCN
   4NFy4tRG343FnwFpDOjX5u92H3VoF4tDrwM1JS6KmS9m6p3s1jHIGlkeb
   fltcI0Smh4KkzJvG/k3pfgzK9IMivmYW8LNv80obVvrm365eloSJ1TR50
   u8dK9y1KxGqDULC4adFH9Z4OfgTf8+P4gTn9pNgj9/zr/i0bwdCVRrXD4
   cfKwbdUl/9QPOd9ACrreBYokUqn7y0anHT1ICITrxq8BnMBVQJpfLagdf
   zTh0wmWdR34wIod9spE68AQ6wj52usdaFfPGs0RNE58b//SfXAWJWQ75l
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="307944453"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="307944453"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 15:08:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="663334212"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="663334212"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 20 Oct 2022 15:08:29 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 15:08:29 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 20 Oct 2022 15:08:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 20 Oct 2022 15:08:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JkFPb8enD13EUdfX1gUrdud2oERZdsw6PG2zAc+lyfncBMbpO3vUYdpFj5sZ5txX/M2m/kLvp7IUmVDdJ+reSM9T3VhT5cJFufTFGOd+lDjOlWi94cBXkc5kg2Q0iH3bjtanRxeU6yokJXaNUUYzK8mbFby2kNJv0JO6juGEwm6KC3TCeAjAZhuIbom8H6Ia1UsT2qeawjL3WxvFBxrKS2j9eS0KFlDFO2t02WMQfhJ7+dK0pE5HiIjxCbCA6PrzNWOxqj7aCwZmkhV3w92T6um1j8ZbjPNkrIOMo458PDuUivbIRTAlcz689NMPsX3HgVLEx6uLH0s+RVKOQzhZiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyqIVR85USTu+w4R8ZsGUd/WIUxzYMH/JFpkOEKXFws=;
 b=QKLUDr8I5LMWwt5WgZWHi8TNBat0FStBwhE8PJ38I4fGw7p81xav9QEWur7VjF7tsVyoKnIdZRlLwwNPnDFZxR/ZFZmaEnvYjAtCnZ/lrDDGxuYx7OP6a9/ZIj1cnJkO485fMCaIOfzf62bXy3rX5fGDNljr3OyDOGAVNNA8UJ460K1VJAsq+PacaURY0rDfw8fTX1h7p3rMx0LO8LQga6Twmv8yRSkafHpXupTbHbrOd1Do2BWhjAH38uoJ9DJnx2IX89nCzcb4YIcDhX/gIYPDQaAlIqTdqqQ22m8RQAKE01BJk4GpIz7agGrCT/gTD9V/0QS/j67gD4NR8C+C2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Thu, 20 Oct
 2022 22:08:18 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 22:08:17 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "keescook@chromium.org" <keescook@chromium.org>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
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
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v2 27/39] x86/cet/shstk: Handle signals for shadow stack
Thread-Topic: [PATCH v2 27/39] x86/cet/shstk: Handle signals for shadow stack
Thread-Index: AQHY1FMixL8rlhzUMUa706vSrkUbfq39K3WAgBrMzAA=
Date:   Thu, 20 Oct 2022 22:08:17 +0000
Message-ID: <56095eac64e95b79ea04e84909d8ba0ab49d9246.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-28-rick.p.edgecombe@intel.com>
         <202210031347.6DBE61199@keescook>
In-Reply-To: <202210031347.6DBE61199@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH7PR11MB5941:EE_
x-ms-office365-filtering-correlation-id: b803a017-1606-4835-31c4-08dab2e7978a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ruYJKA/ErOAP8TFyHigXpV2rJwf1QKaOoiKoidF2KNuJfi6U18JK3o9q8s+AuF8hTe0iWITGGyqqzx0KfkF2Oz4FFqhwuCTpYfIlMJBJXze8JI+jrvp0r1odfGB8HdruJFMZQMZa5nd4Pr/ooOPoaRPcBlV/668uDW+Lr06h8N6N01hiS1+Navmi1HnUaL9B+8gf7mds7lw9G17yPh4T67BgzwYtZ9xHt9XMvleebk503g4rdQjZ0IO40j2mjDzz3uLRu1jMdowXZZdTCQFxgJe0L6qyK/MKIstmvyiPsHtH4jDi813JFQGihFGrjpDz9FqMo+ey3CV+2dJTPxEVGMVG206b0ah6qEr1BQH7fSePLll07ZaD8zzxC4ttBYojzIyscZNccYCliuWgsu47NcDtC1ycrXK3g3IMjwcb5lgxfK0L9/Wj69PCfT40OvyvB2r+Jl/lva1at5U8jIftHL++0fXKVmbQKCN97UUPVOakwc++1QWSD1iZ2CibwAsQtgA/vtm7Ci97F0UhcwE5RexGSTtEAVxUpjTUjNG5y6uvvrfuiClOkhdeWyszjEQ25s0p0q8+K26Af49BdJC2FHAeW43E7oH+BvRlxSVDLe0w0MfPlMv+BwOl1Qghox+Q7MhLsVnpUEMHZj8qTXQTFuFrAS01u6ajVyqV2tSslJbtk43WsloC3lasYr4zxX1llgDkwMlUJNzNXPBA+cMVA0ASu9GVeasikiGrph3a3Tq51H+TY01BJ4qivPG9jwJkFdUbyg01oDvoR2iFDZhrKXWPECjG2dpxEminXU29ITg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199015)(41300700001)(54906003)(2906002)(2616005)(316002)(186003)(36756003)(6506007)(8676002)(6512007)(5660300002)(7406005)(8936002)(7416002)(6916009)(26005)(91956017)(4326008)(83380400001)(66946007)(64756008)(66446008)(86362001)(66556008)(66476007)(76116006)(82960400001)(38100700002)(478600001)(71200400001)(122000001)(38070700005)(6486002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXZuRjJFSUlUYnpZZjlDZVY2YzBDZm9rZmZLRHhFdU9GYVVIQkc3bVJPWDE1?=
 =?utf-8?B?MG81YnJNU21UR1plYytLU1ZkRi81QnRGZy9uYmI1c0xHUW9aREpuQUtOdE5F?=
 =?utf-8?B?QXN3RFBzYjZua2lmeWREclZsVVczYUQwRStLbG9xUklxclQ3TGY2VlNMWjBS?=
 =?utf-8?B?dkNzVEkvUVNCVUtwQUZIUWRGYllvSUZJNktSUTYxaTZNVHlveENLY3pidkpv?=
 =?utf-8?B?dC9aVWJBWHROS1NITXFPbWIvMDR3clZtc0JMM2hCMWh1VDNKSTBiOFpnNnhZ?=
 =?utf-8?B?SVh2REJGVUpCeXdlU2NHVnhHcHQ1d2wzUEcyUExJNGo5SFlTeDBXc0xoU3E3?=
 =?utf-8?B?RjMwejE5a3pGSzcyRXIzbXBsWER2VE1jOTVVdG10ZnI0Q1F1VmpEL1BwbGpO?=
 =?utf-8?B?anIwcStwbnJxY0pQemFJeC80c014R0dFS05aTXQwMDJ1SVQ2TVIvVVF6UGkv?=
 =?utf-8?B?T2hmV2tMOTZENnNLYk5nc3cxdHErcUdvZTB0czJKaUY0aUZhVm1sM0FaUlpF?=
 =?utf-8?B?U09MMWdraUVmTGFoOU0zQWlNQXNwLzVWMFlZUFludXZ6T0xUbkxCSlNaMWlD?=
 =?utf-8?B?cTVEL21rb25tVG1YYlhEaHVOMXNjeE93Y0Z0d3l4UDFobWs5RFVGWFJtU2xE?=
 =?utf-8?B?MHFSbmMwRmtvaXNEQVYzVDlTTGNsSFp1QUdqV201UkUxMktxR05nNW50eVBR?=
 =?utf-8?B?M0lUTDRoOHNVRThCNjluZHJpQVZGRnVaWTVaUmo3NmttSWZ0N2QzTHA2WmZQ?=
 =?utf-8?B?SWhNdHJTUmN4bXVjNCtXcnA3VFZKdzM0WlI4dFdDV3BOZEtaS01aeGhSSVg5?=
 =?utf-8?B?QllZcXErL2IyTkVUQVo1enM5cWRmRVdOZkZlWlQzSTROZmZGaWR2dVE2a3g1?=
 =?utf-8?B?L1p5dnp3dWZmamxxQUpEbjFiUmpReW5EdWN6eVdlZFlRNHlMb1RGUXR5S0lS?=
 =?utf-8?B?WlFJeE5CdnVUUzhHVjNqR2dGZ2JHdHZ2R1BqZnUwbXo0RjhQYWFyM2RTWGNN?=
 =?utf-8?B?MFkyWHZNK3owZlR1a0JzcEt4cjA5NWpIbzVkUW5aemYza0pkbFduQnM0OXh0?=
 =?utf-8?B?aVg0d250SG1ETEVQa0lwdmJnZWdRcHlJSlBvWmxMRTZZM3RYbFlnK2VxZlFQ?=
 =?utf-8?B?ZWJhL0VWakluR3NtZFNyMG9MR25ZTkw4cEpRSWFkakJ3MWFIYXNEZWEwOXhs?=
 =?utf-8?B?UDc0eDk1WHZWVnorQUE5S3FxU0pEaUNpTFh6RTErRzdhbzdROE42aEhWSWdN?=
 =?utf-8?B?bi9jS1hiUGZIcW5SRXhYRUxHL2xZZmE3aHlQWUJUUmNKNzAxck00R3RrR3Ru?=
 =?utf-8?B?TkIwQk5qZ0dVejNMNzZrbEd5MjVuZXVZMmwxWkRwYlc2ejJDb3NTTjhHSGdI?=
 =?utf-8?B?QjZDQmgrSm5UMERUVjFpVVU4Mnh0clczcE9tenRnZUszZkFCMCsvYkJSMVNB?=
 =?utf-8?B?MnJjbnFuS3MzTDh0WFcxdVAveDIrQjBpb2NyRElVZzZKM0NJalo3alNLTzQ3?=
 =?utf-8?B?ODVQTFlnclU1T211WlNUd2xXZ2hlVjhuNUp3QjVYc3c3OHZFWVIxMVF6UVcr?=
 =?utf-8?B?cEV2VWhxZmhlQTFzbTB2NUJ3NGwveWt0VUU1blgvT1ZNbWhJaUQyaWptM1I4?=
 =?utf-8?B?Vm5lYTNmU1dQMHpkMkoxT2YyL2NZNCszeHBtSTYxbnVia0x6elVXdWF3a2xu?=
 =?utf-8?B?TmZBb01kOGZvc244MENDTStBWTRTcTd6WGFWNGVMTVhLVjd6L2ZNSmk4bUdF?=
 =?utf-8?B?Nzd4cWFFWmtVclJSRVZtQlZ3anI1dkovR09IS2RuWjAxWjlzOWtYbGFCR0hO?=
 =?utf-8?B?NURLVDZJTUZrR2xSdTR6S3E4YXYwQ0FDVXJvREFGWHR3T0JMb0JETFRPZldm?=
 =?utf-8?B?Tkg2RDE4Y0UvOXVocCtVZXpQclBFc3JaV05lekExbnpUQTBlTDcrcXNpd0ND?=
 =?utf-8?B?cGhFNGFqTjhjcEJLZ1FxSGl6dlI3bWhrME1XZEIwTlZXamZpTUdHa2ZyLy9R?=
 =?utf-8?B?QWxjeUU2RkxSNXNzSHNkcENyaFlpSDdwY1hOV2NxQW5RekJ3ZVdKa0ttNUJI?=
 =?utf-8?B?MDFmcG5qbWVsUENSbmx5S1ZXeDNQSjIzQlZNUmI1U01JUHdjZ3RneGZFbXF1?=
 =?utf-8?B?KzNwNnVBWXdwUzJ6dHdaNlZEMHBhS0lCeHVmdmVwQTZyYmRwMXgwSDRnZzhm?=
 =?utf-8?Q?Adu6lhjMsuLB4oZ3ZBWicVc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F349950B7B855D468D52358F565864A6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b803a017-1606-4835-31c4-08dab2e7978a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 22:08:17.5327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IftMHK4Pa1wc619Q4ljPVtnFKRef1WT4TA8hIs8jt2Ni4IAOp13FwnNnePkn8LukLE2fof5alXfOBMJzLii6IhiasrRpuy78xytcYBw5XjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5941
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

S2Vlcywgc29ycnkgZm9yIHRoZSBkZWxheWVkIHJlc3BvbnNlLiBUaGVyZSB3YXMgc28gbXVjaCBm
ZWVkYmFjaywgSQ0KbWlzc2VkIHJlc3BvbmRpbmcgdG8gc29tZS4NCg0KT24gTW9uLCAyMDIyLTEw
LTAzIGF0IDEzOjUyIC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+IE9uIFRodSwgU2VwIDI5LCAy
MDIyIGF0IDAzOjI5OjI0UE0gLTA3MDAsIFJpY2sgRWRnZWNvbWJlIHdyb3RlOg0KPiA+IEZyb206
IFl1LWNoZW5nIFl1IDx5dS1jaGVuZy55dUBpbnRlbC5jb20+DQo+ID4gDQo+ID4gV2hlbiBhIHNp
Z25hbCBpcyBoYW5kbGVkIG5vcm1hbGx5IHRoZSBjb250ZXh0IGlzIHB1c2hlZCB0byB0aGUNCj4g
PiBzdGFjaw0KPiA+IGJlZm9yZSBoYW5kbGluZyBpdC4gRm9yIHNoYWRvdyBzdGFja3MsIHNpbmNl
IHRoZSBzaGFkb3cgc3RhY2sgb25seQ0KPiA+IHRyYWNrJ3MNCj4gPiByZXR1cm4gYWRkcmVzc2Vz
LCB0aGVyZSBpc24ndCBhbnkgc3RhdGUgdGhhdCBuZWVkcyB0byBiZSBwdXNoZWQuDQo+ID4gSG93
ZXZlciwNCj4gPiB0aGVyZSBhcmUgc3RpbGwgYSBmZXcgdGhpbmdzIHRoYXQgbmVlZCB0byBiZSBk
b25lLiBUaGVzZSB0aGluZ3MgYXJlDQo+ID4gdXNlcnNwYWNlIHZpc2libGUgYW5kIHdoaWNoIHdp
bGwgYmUga2VybmVsIEFCSSBmb3Igc2hhZG93IHN0YWNrcy4NCj4gPiANCj4gPiBPbmUgaXMgdG8g
bWFrZSBzdXJlIHRoZSByZXN0b3JlciBhZGRyZXNzIGlzIHdyaXR0ZW4gdG8gc2hhZG93DQo+ID4g
c3RhY2ssIHNpbmNlDQo+ID4gdGhlIHNpZ25hbCBoYW5kbGVyIChpZiBub3QgY2hhbmdpbmcgdWNv
bnRleHQpIHJldHVybnMgdG8gdGhlDQo+ID4gcmVzdG9yZXIsIGFuZA0KPiA+IHRoZSByZXN0b3Jl
ciBjYWxscyBzaWdyZXR1cm4uIFNvIGFkZCB0aGUgcmVzdG9yZXIgb24gdGhlIHNoYWRvdw0KPiA+
IHN0YWNrDQo+ID4gYmVmb3JlIGhhbmRsaW5nIHRoZSBzaWduYWwsIHNvIHRoZXJlIGlzIG5vdCBh
IGNvbmZsaWN0IHdoZW4gdGhlDQo+ID4gc2lnbmFsDQo+ID4gaGFuZGxlciByZXR1cm5zIHRvIHRo
ZSByZXN0b3Jlci4NCj4gPiANCj4gPiBUaGUgb3RoZXIgdGhpbmcgdG8gZG8gaXMgdG8gcGxhY2Ug
c29tZSB0eXBlIG9mIGNoZWNrYWJsZSB0b2tlbiBvbg0KPiA+IHRoZQ0KPiA+IHRocmVhZCdzIHNo
YWRvdyBzdGFjayBiZWZvcmUgaGFuZGxpbmcgdGhlIHNpZ25hbCBhbmQgY2hlY2sgaXQNCj4gPiBk
dXJpbmcNCj4gPiBzaWdyZXR1cm4uIFRoaXMgaXMgYW4gZXh0cmEgbGF5ZXIgb2YgcHJvdGVjdGlv
biB0byBoYW1wZXIgYXR0YWNrZXJzDQo+ID4gY2FsbGluZyBzaWdyZXR1cm4gbWFudWFsbHkgYXMg
aW4gU1JPUC1saWtlIGF0dGFja3MuDQo+ID4gDQo+ID4gRm9yIHRoaXMgdG9rZW4gd2UgY2FuIHVz
ZSB0aGUgc2hhZG93IHN0YWNrIGRhdGEgZm9ybWF0IGRlZmluZWQNCj4gPiBlYXJsaWVyLg0KPiA+
IEhhdmUgdGhlIGRhdGEgcHVzaGVkIGJlIHRoZSBwcmV2aW91cyBTU1AuIEluIHRoZSBmdXR1cmUg
dGhlDQo+ID4gc2lncmV0dXJuDQo+ID4gbWlnaHQgd2FudCB0byByZXR1cm4gYmFjayB0byBhIGRp
ZmZlcmVudCBzdGFjay4gU3RvcmluZyB0aGUgU1NQDQo+ID4gKGluc3RlYWQNCj4gPiBvZiBhIHJl
c3RvcmUgb2Zmc2V0IG9yIHNvbWV0aGluZykgYWxsb3dzIGZvciBmdXR1cmUgZnVuY3Rpb25hbGl0
eQ0KPiA+IHRoYXQNCj4gPiBtYXkgd2FudCB0byByZXN0b3JlIHRvIGEgZGlmZmVyZW50IHN0YWNr
Lg0KPiA+IA0KPiA+IFNvLCB3aGVuIGhhbmRsaW5nIGEgc2lnbmFsIHB1c2gNCj4gPiAgLSB0aGUg
U1NQIHBvaW50aW5nIGluIHRoZSBzaGFkb3cgc3RhY2sgZGF0YSBmb3JtYXQNCj4gPiAgLSB0aGUg
cmVzdG9yZXIgYWRkcmVzcyBiZWxvdyB0aGUgcmVzdG9yZSB0b2tlbi4NCj4gPiANCj4gPiBJbiBz
aWdyZXR1cm4sIHZlcmlmeSBTU1AgaXMgc3RvcmVkIGluIHRoZSBkYXRhIGZvcm1hdCBhbmQgcG9w
IHRoZQ0KPiA+IHNoYWRvdw0KPiA+IHN0YWNrLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFl1
LWNoZW5nIFl1IDx5dS1jaGVuZy55dUBpbnRlbC5jb20+DQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBS
aWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0KPiA+IENj
OiBBbmR5IEx1dG9taXJza2kgPGx1dG9Aa2VybmVsLm9yZz4NCj4gPiBDYzogQ3lyaWxsIEdvcmN1
bm92IDxnb3JjdW5vdkBnbWFpbC5jb20+DQo+ID4gQ2M6IEZsb3JpYW4gV2VpbWVyIDxmd2VpbWVy
QHJlZGhhdC5jb20+DQo+ID4gQ2M6IEguIFBldGVyIEFudmluIDxocGFAenl0b3IuY29tPg0KPiA+
IENjOiBLZWVzIENvb2sgPGtlZXNjb29rQGNocm9taXVtLm9yZz4NCj4gPiANCj4gPiAtLS0NCj4g
PiANCj4gPiB2MjoNCj4gPiAgLSBTd2l0Y2ggdG8gbmV3IHNoc3RrIHNpZ25hbCBmb3JtYXQNCj4g
PiANCj4gPiB2MToNCj4gPiAgLSBVc2UgeHNhdmUgaGVscGVycy4NCj4gPiAgLSBFeHBhbmQgY29t
bWl0IGxvZy4NCj4gPiANCj4gPiBZdS1jaGVuZyB2Mjc6DQo+ID4gIC0gRWxpbWluYXRlIHNhdmlu
ZyBzaGFkb3cgc3RhY2sgcG9pbnRlciB0byBzaWduYWwgY29udGV4dC4NCj4gPiANCj4gPiBZdS1j
aGVuZyB2MjU6DQo+ID4gIC0gVXBkYXRlIGNvbW1pdCBsb2cvY29tbWVudHMgZm9yIHRoZSBzY19l
eHQgc3RydWN0Lg0KPiA+ICAtIFVzZSByZXN0b3JlciBhZGRyZXNzIGFscmVhZHkgY2FsY3VsYXRl
ZC4NCj4gPiAgLSBDaGFuZ2UgQ09ORklHX1g4Nl9DRVQgdG8gQ09ORklHX1g4Nl9TSEFET1dfU1RB
Q0suDQo+ID4gIC0gQ2hhbmdlIFg4Nl9GRUFUVVJFX0NFVCB0byBYODZfRkVBVFVSRV9TSFNUSy4N
Cj4gPiAgLSBFbGltaW5hdGUgd3JpdGluZyB0byBNU1JfSUEzMl9VX0NFVCBmb3Igc2hhZG93IHN0
YWNrLg0KPiA+ICAtIENoYW5nZSB3cm1zcmwoKSB0byB3cm1zcmxfc2FmZSgpIGFuZCBoYW5kbGUg
ZXJyb3IuDQo+ID4gDQo+ID4gIGFyY2gveDg2L2lhMzIvaWEzMl9zaWduYWwuYyB8ICAgMSArDQo+
ID4gIGFyY2gveDg2L2luY2x1ZGUvYXNtL2NldC5oICB8ICAgNSArKw0KPiA+ICBhcmNoL3g4Ni9r
ZXJuZWwvc2hzdGsuYyAgICAgfCAxMjYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
ID4gLS0tLS0tDQo+ID4gIGFyY2gveDg2L2tlcm5lbC9zaWduYWwuYyAgICB8ICAxMCArKysNCj4g
PiAgNCBmaWxlcyBjaGFuZ2VkLCAxMjMgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pDQo+
ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2lhMzIvaWEzMl9zaWduYWwuYw0KPiA+IGIv
YXJjaC94ODYvaWEzMi9pYTMyX3NpZ25hbC5jDQo+ID4gaW5kZXggYzljMzg1OTMyMmZhLi44OGQ3
MWI5ZGU2MTYgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYvaWEzMi9pYTMyX3NpZ25hbC5jDQo+
ID4gKysrIGIvYXJjaC94ODYvaWEzMi9pYTMyX3NpZ25hbC5jDQo+ID4gQEAgLTM0LDYgKzM0LDcg
QEANCj4gPiAgI2luY2x1ZGUgPGFzbS9zaWdmcmFtZS5oPg0KPiA+ICAjaW5jbHVkZSA8YXNtL3Np
Z2hhbmRsaW5nLmg+DQo+ID4gICNpbmNsdWRlIDxhc20vc21hcC5oPg0KPiA+ICsjaW5jbHVkZSA8
YXNtL2NldC5oPg0KPiA+ICANCj4gPiAgc3RhdGljIGlubGluZSB2b2lkIHJlbG9hZF9zZWdtZW50
cyhzdHJ1Y3Qgc2lnY29udGV4dF8zMiAqc2MpDQo+ID4gIHsNCj4gPiBkaWZmIC0tZ2l0IGEvYXJj
aC94ODYvaW5jbHVkZS9hc20vY2V0LmgNCj4gPiBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2NldC5o
DQo+ID4gaW5kZXggOTI0ZGU5OWUwYzYxLi44YzZmYWI5ZjQwMmEgMTAwNjQ0DQo+ID4gLS0tIGEv
YXJjaC94ODYvaW5jbHVkZS9hc20vY2V0LmgNCj4gPiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9jZXQuaA0KPiA+IEBAIC02LDYgKzYsNyBAQA0KPiA+ICAjaW5jbHVkZSA8bGludXgvdHlwZXMu
aD4NCj4gPiAgDQo+ID4gIHN0cnVjdCB0YXNrX3N0cnVjdDsNCj4gPiArc3RydWN0IGtzaWduYWw7
DQo+ID4gIA0KPiA+ICBzdHJ1Y3QgdGhyZWFkX3Noc3RrIHsNCj4gPiAgCXU2NAliYXNlOw0KPiA+
IEBAIC0yMiw2ICsyMyw4IEBAIGludCBzaHN0a19hbGxvY190aHJlYWRfc3RhY2soc3RydWN0IHRh
c2tfc3RydWN0DQo+ID4gKnAsIHVuc2lnbmVkIGxvbmcgY2xvbmVfZmxhZ3MsDQo+ID4gIHZvaWQg
c2hzdGtfZnJlZShzdHJ1Y3QgdGFza19zdHJ1Y3QgKnApOw0KPiA+ICBpbnQgc2hzdGtfZGlzYWJs
ZSh2b2lkKTsNCj4gPiAgdm9pZCByZXNldF90aHJlYWRfc2hzdGsodm9pZCk7DQo+ID4gK2ludCBz
ZXR1cF9zaWduYWxfc2hhZG93X3N0YWNrKHN0cnVjdCBrc2lnbmFsICprc2lnKTsNCj4gPiAraW50
IHJlc3RvcmVfc2lnbmFsX3NoYWRvd19zdGFjayh2b2lkKTsNCj4gPiAgI2Vsc2UNCj4gPiAgc3Rh
dGljIGlubGluZSBsb25nIGNldF9wcmN0bChzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRhc2ssIGludCBv
cHRpb24sDQo+ID4gIAkJICAgICAgdW5zaWduZWQgbG9uZyBmZWF0dXJlcykgeyByZXR1cm4gLUVJ
TlZBTDsgfQ0KPiA+IEBAIC0zMyw2ICszNiw4IEBAIHN0YXRpYyBpbmxpbmUgaW50IHNoc3RrX2Fs
bG9jX3RocmVhZF9zdGFjayhzdHJ1Y3QNCj4gPiB0YXNrX3N0cnVjdCAqcCwNCj4gPiAgc3RhdGlj
IGlubGluZSB2b2lkIHNoc3RrX2ZyZWUoc3RydWN0IHRhc2tfc3RydWN0ICpwKSB7fQ0KPiA+ICBz
dGF0aWMgaW5saW5lIGludCBzaHN0a19kaXNhYmxlKHZvaWQpIHsgcmV0dXJuIC1FT1BOT1RTVVBQ
OyB9DQo+ID4gIHN0YXRpYyBpbmxpbmUgdm9pZCByZXNldF90aHJlYWRfc2hzdGsodm9pZCkge30N
Cj4gPiArc3RhdGljIGlubGluZSBpbnQgc2V0dXBfc2lnbmFsX3NoYWRvd19zdGFjayhzdHJ1Y3Qg
a3NpZ25hbCAqa3NpZykNCj4gPiB7IHJldHVybiAwOyB9DQo+ID4gK3N0YXRpYyBpbmxpbmUgaW50
IHJlc3RvcmVfc2lnbmFsX3NoYWRvd19zdGFjayh2b2lkKSB7IHJldHVybiAwOyB9DQo+ID4gICNl
bmRpZiAvKiBDT05GSUdfWDg2X1NIQURPV19TVEFDSyAqLw0KPiA+ICANCj4gPiAgI2VuZGlmIC8q
IF9fQVNTRU1CTFlfXyAqLw0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvc2hzdGsu
YyBiL2FyY2gveDg2L2tlcm5lbC9zaHN0ay5jDQo+ID4gaW5kZXggODkwNGFlZjQ4N2JmLi4wNDQ0
MjEzNGFhZGQgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYva2VybmVsL3Noc3RrLmMNCj4gPiAr
KysgYi9hcmNoL3g4Ni9rZXJuZWwvc2hzdGsuYw0KPiA+IEBAIC0yMjcsNDEgKzIyNywxMjkgQEAg
c3RhdGljIGludCBnZXRfc2hzdGtfZGF0YSh1bnNpZ25lZCBsb25nDQo+ID4gKmRhdGEsIHVuc2ln
bmVkIGxvbmcgX191c2VyICphZGRyKQ0KPiA+ICB9DQo+ID4gIA0KPiA+ICAvKg0KPiA+IC0gKiBW
ZXJpZnkgdGhlIHVzZXIgc2hhZG93IHN0YWNrIGhhcyBhIHZhbGlkIHRva2VuIG9uIGl0LCBhbmQg
dGhlbg0KPiA+IHNldA0KPiA+IC0gKiAqbmV3X3NzcCBhY2NvcmRpbmcgdG8gdGhlIHRva2VuLg0K
PiA+ICsgKiBDcmVhdGUgYSByZXN0b3JlIHRva2VuIG9uIHNoYWRvdyBzdGFjaywgYW5kIHRoZW4g
cHVzaCB0aGUgdXNlci0NCj4gPiBtb2RlDQo+ID4gKyAqIGZ1bmN0aW9uIHJldHVybiBhZGRyZXNz
Lg0KPiA+ICAgKi8NCj4gPiAtc3RhdGljIGludCBzaHN0a19jaGVja19yc3Rvcl90b2tlbih1bnNp
Z25lZCBsb25nICpuZXdfc3NwKQ0KPiA+ICtzdGF0aWMgaW50IHNoc3RrX3NldHVwX3JzdG9yX3Rv
a2VuKHVuc2lnbmVkIGxvbmcgcmV0X2FkZHIsDQo+ID4gdW5zaWduZWQgbG9uZyAqbmV3X3NzcCkN
Cj4gDQo+IE9oLCBocm0uIFByaW9yIHBhdGNoIGRlZmluZXMgc2hzdGtfY2hlY2tfcnN0b3JfdG9r
ZW4oKSBhbmQNCj4gZG9lc24ndCBjYWxsIGl0LiBUaGlzIHBhdGNoIHJlbW92ZXMgaXQuIDpQIENh
biB5b3UgcGxlYXNlIHJlbW92ZQ0KPiBzaHN0a19jaGVja19yc3Rvcl90b2tlbigpIGZyb20gdGhl
IHByaW9yIHBhdGNoPw0KDQpZZXMsIHRoaXMgZnVuY3Rpb24gaXMgbm90IG5lZWRlZCB1bnRpbCB0
aGUgYWx0IHNoYWRvdyBzdGFjayBzdHVmZi4gSXQNCmdvdCBhbGwgbWFuZ2xlZCBhY3Jvc3MgZWFy
bGllciBwYXRjaGVzLiBJIHJlbW92ZWQgaXQgYWxsIHRvZ2V0aGVyIG5vdy4NClRoYW5rcy4NCg0K
PiANCj4gPiAgew0KPiA+IC0JdW5zaWduZWQgbG9uZyB0b2tlbl9hZGRyOw0KPiA+IC0JdW5zaWdu
ZWQgbG9uZyB0b2tlbjsNCj4gPiArCXVuc2lnbmVkIGxvbmcgc3NwLCB0b2tlbl9hZGRyOw0KPiA+
ICsJaW50IGVycjsNCj4gPiArDQo+ID4gKwlpZiAoIXJldF9hZGRyKQ0KPiA+ICsJCXJldHVybiAt
RUlOVkFMOw0KPiA+ICsNCj4gPiArCXNzcCA9IGdldF91c2VyX3Noc3RrX2FkZHIoKTsNCj4gPiAr
CWlmICghc3NwKQ0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+ICsNCj4gPiArCWVyciA9IGNy
ZWF0ZV9yc3Rvcl90b2tlbihzc3AsICZ0b2tlbl9hZGRyKTsNCj4gPiArCWlmIChlcnIpDQo+ID4g
KwkJcmV0dXJuIGVycjsNCj4gPiArDQo+ID4gKwlzc3AgPSB0b2tlbl9hZGRyIC0gc2l6ZW9mKHU2
NCk7DQo+ID4gKwllcnIgPSB3cml0ZV91c2VyX3Noc3RrXzY0KCh1NjQgX191c2VyICopc3NwLCAo
dTY0KXJldF9hZGRyKTsNCj4gPiArDQo+ID4gKwlpZiAoIWVycikNCj4gPiArCQkqbmV3X3NzcCA9
IHNzcDsNCj4gPiArDQo+ID4gKwlyZXR1cm4gZXJyOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0
aWMgaW50IHNoc3RrX3B1c2hfc2lnZnJhbWUodW5zaWduZWQgbG9uZyAqc3NwKQ0KPiA+ICt7DQo+
ID4gKwl1bnNpZ25lZCBsb25nIHRhcmdldF9zc3AgPSAqc3NwOw0KPiA+ICsNCj4gPiArCS8qIFRv
a2VuIG11c3QgYmUgYWxpZ25lZCAqLw0KPiA+ICsJaWYgKCFJU19BTElHTkVEKCpzc3AsIDgpKQ0K
PiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+ICANCj4gPiAtCXRva2VuX2FkZHIgPSBnZXRfdXNl
cl9zaHN0a19hZGRyKCk7DQo+ID4gLQlpZiAoIXRva2VuX2FkZHIpDQo+ID4gKwlpZiAoIUlTX0FM
SUdORUQodGFyZ2V0X3NzcCwgOCkpDQo+ID4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gIA0KPiA+
IC0JaWYgKGdldF91c2VyKHRva2VuLCAodW5zaWduZWQgbG9uZyBfX3VzZXIgKil0b2tlbl9hZGRy
KSkNCj4gPiArCSpzc3AgLT0gU1NfRlJBTUVfU0laRTsNCj4gPiArCWlmIChwdXRfc2hzdGtfZGF0
YSgodm9pZCAqX191c2VyKSpzc3AsIHRhcmdldF9zc3ApKQ0KPiA+ICAJCXJldHVybiAtRUZBVUxU
Ow0KPiA+ICANCj4gPiAtCS8qIElzIG1vZGUgZmxhZyBjb3JyZWN0PyAqLw0KPiA+IC0JaWYgKCEo
dG9rZW4gJiBCSVQoMCkpKQ0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gKw0K
PiA+ICtzdGF0aWMgaW50IHNoc3RrX3BvcF9zaWdmcmFtZSh1bnNpZ25lZCBsb25nICpzc3ApDQo+
ID4gK3sNCj4gPiArCXVuc2lnbmVkIGxvbmcgdG9rZW5fYWRkcjsNCj4gPiArCWludCBlcnI7DQo+
ID4gKw0KPiA+ICsJZXJyID0gZ2V0X3Noc3RrX2RhdGEoJnRva2VuX2FkZHIsICh1bnNpZ25lZCBs
b25nIF9fdXNlcg0KPiA+ICopKnNzcCk7DQo+ID4gKwlpZiAodW5saWtlbHkoZXJyKSkNCj4gPiAr
CQlyZXR1cm4gZXJyOw0KPiA+ICsNCj4gPiArCS8qIFJlc3RvcmUgU1NQIGFsaWduZWQ/ICovDQo+
ID4gKwlpZiAodW5saWtlbHkoIUlTX0FMSUdORUQodG9rZW5fYWRkciwgOCkpKQ0KPiA+ICAJCXJl
dHVybiAtRUlOVkFMOw0KPiANCj4gV2h5IGRvZXNuJ3QgdGhpcyBhbHdheXMgZmFpbCwgZ2l2ZW4g
QklUKDApIGJlaW5nIHNldD8gSSBkb24ndCBzZWUgaXQNCj4gZ2V0dGluZyBjbGVhcmVkIHVudGls
IHRoZSBlbmQgb2YgdGhpcyBmdW5jdGlvbi4NCg0KQmVjYXVzZSBpdCBpc24ndCBhIG5vcm1hbCB0
b2tlbiwgaXQgd2FzIGFuIGFkZHJlc3MgaW4gdGhlICJkYXRhIGZvcm1hdCINCnRoYXQgaGFkIGJp
dCA2MyBzZXQuIFRoZW4gYml0IDYzIHdhcyBjbGVhcmVkLCBtYWtpbmcgaXQgYSBub3JtYWwNCmFk
ZHJlc3MuDQoNCj4gDQo+ID4gIA0KPiA+IC0JLyogSXMgYnVzeSBmbGFnIHNldD8gKi8NCj4gPiAt
CWlmICh0b2tlbiAmIEJJVCgxKSkNCj4gPiArCS8qIFNTUCBpbiB1c2Vyc3BhY2U/ICovDQo+ID4g
KwlpZiAodW5saWtlbHkodG9rZW5fYWRkciA+PSBUQVNLX1NJWkVfTUFYKSkNCj4gPiAgCQlyZXR1
cm4gLUVJTlZBTDsNCj4gDQo+IEJJVCg2MykgYWxyZWFkeSBnb3QgY2xlYXJlZCBieSBoZXJlIChp
biBnZXRfc2hzdGtfZGF0YSgpLCBidXQgeWVzLA0KPiB0aGlzIGlzIHN0aWxsIGEgcmVhc29uYWJs
ZSBjaGVjay4NCg0KR29vZCBwb2ludC4gSSBndWVzcyBJIGNhbiBsZWF2ZSBpdC4gVGhhbmtzLg0K
DQo+IA0KPiA+ICANCj4gPiAtCS8qIE1hc2sgb3V0IGZsYWdzICovDQo+ID4gLQl0b2tlbiAmPSB+
M1VMOw0KPiA+ICsJKnNzcCA9IHRva2VuX2FkZHI7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+
ID4gK30NCj4gDQo+IA0K
