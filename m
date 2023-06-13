Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48ADC72EC10
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 21:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237893AbjFMTh7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jun 2023 15:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237696AbjFMTh5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 15:37:57 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606B019A;
        Tue, 13 Jun 2023 12:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686685075; x=1718221075;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0KFH5C3PNuaOS2Iyaq4mrqsP4RrLSs/G5N3gOzvX+9c=;
  b=dtjXQG4ODnOsC4bomV+z8dKjWFm6W8f5LmqnlzHE5vuvypz1bLtivA9t
   omjcdDsZ8B9qFmO3x2qIyKLG7fBLdF1rPQsMNocTsTcXtUBj68ZXU9gFD
   bRbhGJyJE8BqyQFwp6mcCPHyfjpYB03L83XhirtR1sN6HnkJIGeB59sQV
   oFTzt2fyArBjhzqn8/SddOU3WsdzfyqrXqB2Xj3if2v5hGcaXRbzJkewV
   Rm/yMc714zIyODpOHSi3FGcjDgwIYB35Mj/7djVklazfQiU++plTtA5ER
   Pkfq+AoNziWhZvlc76/oG6bP+KN2RpVm0V7P4sfjt94nBtBS/PqVlyWY7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="348093188"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="348093188"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 12:37:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="885953774"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="885953774"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 13 Jun 2023 12:37:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 12:37:53 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 12:37:52 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 12:37:52 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 12:37:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGRx+C/JqxPqaxLCZjBypm+7pX9WrhwloAQKPJ7UzkV+94KOfSO06SWKAVvLdYfihhIsm73zHeLsclmW5QyWI9ukXNrp/E4QJIQjBwhdrBIKWK72ZfLiihwKb2sow4IY9pIcBsELxWLXjhzDBpt4rtKLqj/YBUP60UhironisTaReEv5pJ1MVvUvVYpIsMmF6GULSe6zux8sZBYnmxtqdIzQckLKBglLChzIvYz1tcIEvp5ObZQs0P/kvaHuhDH7esu7r4xac6lbVb9IravMMyl0RTE45+6UOnrQkLSmH2xXukSuoXx6eK6t076WgdsPSl51wViHtezBgx1Mx9jPAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KFH5C3PNuaOS2Iyaq4mrqsP4RrLSs/G5N3gOzvX+9c=;
 b=YjBEALOJ3FZtHO8yY9z4XTaKfFs4u4M9tIagLJ7wbIRoMlg/1MOczG53cBQd2EBq1ppeTGuGpkP/8dLqadvOqZALlDi9B8w3N4kl4HjBZKQusmoNYaSNhAYMNJJmMO4fcOqt57HTq0gCcdvGLpoUJguESMU6E+U4uAMnsia+JCCcu3y1+BzEsPaBUkmstV/M8n32lleAqBVSTULYmI8cOVCEQsZRSQcwa+tG/4GTp9FXVytat1nsKofMiAHuT1GV51HUWHcscajJSD0iywvlzi+LnbWpT6kgCwo/t+PwjFWpHplaTT7uX3ITeh+tipCRPugwzMUmh76dJzrLS62W5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MN2PR11MB4552.namprd11.prod.outlook.com (2603:10b6:208:263::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 19:37:50 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec%7]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 19:37:50 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>
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
Subject: Re: [PATCH v9 10/42] x86/mm: Introduce _PAGE_SAVED_DIRTY
Thread-Topic: [PATCH v9 10/42] x86/mm: Introduce _PAGE_SAVED_DIRTY
Thread-Index: AQHZnYvNY8oRrOBJqk6y3xrSiiZ4gq+JBk0AgAAbrYA=
Date:   Tue, 13 Jun 2023 19:37:50 +0000
Message-ID: <e7b1fb5148f4e21331b99c01fe9cb49f1053a725.camel@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
         <20230613001108.3040476-11-rick.p.edgecombe@intel.com>
         <CAHk-=wgUz9BzHd7Ne1_bUa+4rWoTZanqkQvm4iJt=D7QpE3djw@mail.gmail.com>
In-Reply-To: <CAHk-=wgUz9BzHd7Ne1_bUa+4rWoTZanqkQvm4iJt=D7QpE3djw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MN2PR11MB4552:EE_
x-ms-office365-filtering-correlation-id: b1d4980b-4443-4758-33e6-08db6c45ac73
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fW3WOGiE5JXGp/EgIGl8ow1TUDZT4bttzeKU/oKtl6JHd0ZU0S884TGknsQ43CapAezVLqeJyyhSZ4rSC6XMcmUNnp9EZinAGAHrCzEe96BD6rrhsjr950ILTvmU6wzxtnJSbSmWPm/h/FcyPLiIYKRozNQw/hmtQbJWS5K2RXR+bXN4JDHpxDA0NvUQvFC+JyiTXHDaGmqftrld1OBCL4UHl6PMQyaq6pRwdTBBa74NaKQM9jDt9ESezGraVbJoIckgoPphAHICsTEEjQF/StAJfBvZBfB1yqroGvrZl82CfGluoR/UYM7hIqZmfkhm2XbpHSY6TRCkjjypJd53TB9J5DC1TOjWoo5N7xhF0uv49aLbSdVYQ0mu3dppKo/Qn72KsD56XxCIBQEPLPi+KYs2UO/qMd+egUhimscPaLQ+AemXl+8tYJJktxFDap6db+hMFUQeUeRmUixQ9c8GcNqLFhxbVelR8uCoC7nj9pkgvuidT/6ZVNdM4jDLQjpmb0A4GQyHv0oznS9219i3XYQaFN8Ezzbqepm7S90vIzGPIemtcNAh2Ar5r9vjogiANs5oeA8BSmtJeyHIvbZ+3wdV0ufMNFutPGKHffynDu9/PszI+Sdj/Rm6y784V3evNCFWh+N6OxWIsmusn1TXuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199021)(6916009)(8936002)(7406005)(4326008)(64756008)(66476007)(316002)(91956017)(7416002)(66446008)(41300700001)(76116006)(186003)(2906002)(54906003)(66946007)(8676002)(66556008)(5660300002)(71200400001)(478600001)(6486002)(53546011)(6512007)(122000001)(6506007)(26005)(2616005)(36756003)(38070700005)(82960400001)(86362001)(38100700002)(14143004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjBrUmRjc0hPY3hzMzA0aktpUVNGUXpzOE1DZ09oUFIzZG8xYW1Pc1RYczc5?=
 =?utf-8?B?TWlTRkh1RWlOOE8xN1NGZHpkK3JKc0htMDJUQytkTWd3TWRQcUIyc202eWRm?=
 =?utf-8?B?aXNkSXRYM0I5UkNZV1BsVkVtUUcrOVVLM1hLNklpQU9tRTh2bndTK1VtRTNz?=
 =?utf-8?B?aDE0ZVBMZDJNTVM4UCt6d2tyQUQvQkdBV0tlc3RiZWtVVStQZnBhUkI2dmR1?=
 =?utf-8?B?WE1GT2tpVmozMG1jZUJDbWZwT29yYncvanB6L3dhMXhKVjJyZkFNbSs3eTIy?=
 =?utf-8?B?NStwdGtMY1VCamZTa2Zha1JRdm1ZbUZ4TGdsdGRJc1FHVEZSRWV4VUsyWU81?=
 =?utf-8?B?UmdaZE1EcFlRVnJJeHhVMi9ka3RyOE10cnVTNEJRdmNQMk55c3d5aGtLbEFy?=
 =?utf-8?B?NDY2U1NTMzdXcVVLSFZwWUY5MEdkR0g0M1B3aDJPczNYUG5UTm9mblBjWlBG?=
 =?utf-8?B?aW5DUUZxL1FUYW42MkRMOEZOSlJNUzRObUVvTEwzaHVad0RETjhHMEJSbEFJ?=
 =?utf-8?B?c0hKNWhmbHRlTmFYU3kwQ2dFY1JLUno4QUVTbklwdXBuRG9vRU93WkpaZjdX?=
 =?utf-8?B?Vm1hUGZtU2ZtSENOYTRCT3FJQXUxMjdkaTZqNHE2NEc5YTNxV2FSVE9KVjJt?=
 =?utf-8?B?VG9PTDZXdCtwUGtXcTBTenZkeS94ZDlHNDJLWWRMT0Q4YWVQN0hzakdybkN0?=
 =?utf-8?B?QnNneVVJanpHNzBVRmJXa3FWYVdSUVFWZjd6amRQV1NPZ04xanJycnhnVW9n?=
 =?utf-8?B?aUsraUpxVlFHbDBaUzRtVFJvbzRnZ3YvL3RXQ24zdXlvT3BsNE5UTDJqWVo1?=
 =?utf-8?B?cjRRZnlXSXVKcWlXekVUSy85VU52WFgzcmJMVURtb3BkRlpRTGVKYUFGWitD?=
 =?utf-8?B?angvQkVuNVBYaUY4enRNcitBS3l5MjNOZGxOQ0t5UndTai80V3hLb2kwYkRt?=
 =?utf-8?B?dFlWbyt1dzNza0RVcGxwblJLS09tNW92VVhFQ0JZSFZJVWNWbFRFVGV2WFJG?=
 =?utf-8?B?VDFqcVVGd0pzR3J3MjhMK0ZoNFAzNkRPNjdySXZibUhoRmNOZFZNR2F1YWsw?=
 =?utf-8?B?S0NONDhzaXBMMEtJb2pBRk8razA4b1YwdEU1UDJuOVJDQzRmbjhLeW1YbXE3?=
 =?utf-8?B?aFFxdlBqdnZxWDd0VmpvTEkwZmd3OTkrV0wrSUJIYnpnRlRBZmwrVXgzNlA4?=
 =?utf-8?B?L2MwY0xyNXNmWE4rU1I2TEtBcTl4WlAxL1JMQ2p2aXBJUzJ3SXdYM1BoVGxL?=
 =?utf-8?B?T2pQMldFOFUwcFBkNVAwVVFWZEptTW0yeU1uTUJtK1dNWDVBUTJJVXl0S05M?=
 =?utf-8?B?ZEFTalM0NXI2b1dYampNMzllbGJKY2dDWUhqQzM2OVFjU3B5VkUrZEhVTkc5?=
 =?utf-8?B?Mk5YSUVCVEJmVlFLM1N0NGxRRGM5Q0E4aFRJN2cxazM5WXdoaEowblFkNWhs?=
 =?utf-8?B?TzA0Q0pob3ZyK01CaklTbTJNZ0JpeXpHYVJtSW1iWHRuVkw0Sk9aL0NOb1pF?=
 =?utf-8?B?ckhOcjNiN0lTbVBQYk4zWDVPTWlWZzhUaHZVcXl4RW5Bb3pOdFMzQVpiMXFv?=
 =?utf-8?B?TFFBdjJneWwvYllOdDJpK3BLdHBEL2JISERHUVdvZjNnTkwvT0lrMDlxRlRz?=
 =?utf-8?B?clBvYVJ5cVNuRXlvN0tkdy9TZHVRNm42alM3am5PN0RtZUhuRnZodTBWSnZH?=
 =?utf-8?B?eDJNRlNRcWNva1RraStlZjc0TG5DR0pNNlZCeE5wR2dkRmRwTGRSVzYvMEpQ?=
 =?utf-8?B?QXRoakp0b2FiTGtqOGI1M1FNNVZwUjB1MFpZR2VMMGZOTTJ5V1RHNWNUKy9n?=
 =?utf-8?B?VElnODlVTVdmS0tsUlVoR0c2R1JNNUxZbWNzYkFuVFNBTVQ2alovVXI2S3g3?=
 =?utf-8?B?VTdUbmdMQ3JHdGxsdXdvZWFuTUhtNzFLUTJjdmxQVzlaM3c3TUxkMldlNXJ3?=
 =?utf-8?B?SVRqZjZsengrK3pteW1xLzBuN2NCd081M2NQVzF5SGUxRURxMWRRaE1Lc2Ez?=
 =?utf-8?B?cUQ2QVZUelZuTy9PUjBvTlJTMTljMmJidDB3cnFuTUZBSG9mbnNpa0RHMk11?=
 =?utf-8?B?bzZVQW56NEYwTVRhbW9JZ2s0SHRJc0dUZVF5WnBoUStGdXdUa3VyMW9lZlA5?=
 =?utf-8?B?czJBMTNSaUEzZW9FWTRuTVJaQVBUSTN2WlRaQTdRNGd5L3RTTExhUnV2cmlz?=
 =?utf-8?Q?Vxa6KWOpF02BnFQ+eDelfMk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <64708A1602027F4C85355A8401E95020@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d4980b-4443-4758-33e6-08db6c45ac73
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 19:37:50.4796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TqLBvCOOvoa32d2v0MaC7ux5Q162olfr9VYRio3TnrwaMV83pz5MGCahGWBgd6U7oqfa9UHVATN/EBKvDdKVyXWcCZZMt9/l+SIiTM4D1EA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4552
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIzLTA2LTEzIGF0IDEwOjU4IC0wNzAwLCBMaW51cyBUb3J2YWxkcyB3cm90ZToN
Cj4gT24gTW9uLCBKdW4gMTIsIDIwMjMgYXQgNToxNOKAr1BNIFJpY2sgRWRnZWNvbWJlDQo+IDxy
aWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gK3N0YXRpYyBpbmxp
bmUgdW5zaWduZWQgbG9uZyBta3NhdmVkZGlydHlfc2hpZnQodW5zaWduZWQgbG9uZyB2KQ0KPiA+
ICt7DQo+ID4gK8KgwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIGNvbmQgPSAhKHYgJiAoMSA8PCBf
UEFHRV9CSVRfUlcpKTsNCj4gPiArDQo+ID4gK8KgwqDCoMKgwqDCoCB2IHw9ICgodiA+PiBfUEFH
RV9CSVRfRElSVFkpICYgY29uZCkgPDwNCj4gPiBfUEFHRV9CSVRfU0FWRURfRElSVFk7DQo+ID4g
K8KgwqDCoMKgwqDCoCB2ICY9IH4oY29uZCA8PCBfUEFHRV9CSVRfRElSVFkpOw0KPiANCj4gSSBh
c3N1bWUgeW91IGNoZWNrZWQgdGhhdCB0aGUgY29tcGlsZXIgZG9lcyB0aGUgcmlnaHQgdGhpbmcg
aGVyZT8NCj4gDQo+IEJlY2F1c2UgdGhlIGFib3ZlIGlzIGtpbmQgb2YgYW4gb2RkIHdheSB0byBk
byB0aGluZ3MsIEkgZmVlbC4NCj4gDQo+IFlvdSB1c2UgYm9vbGVhbiBvcGVyYXRvcnMgYW5kIHRo
ZW4gd29yayB3aXRoIGFuICJ1bnNpZ25lZCBsb25nIiBhbmQNCj4gdGhlbiBzaGlmdCB0aGluZ3Mg
YnkgaGFuZC4gU28geW91J3JlIGtpbmQgb2YgbWl4aW5nIHR3byBkaWZmZXJlbnQNCj4gbWVudGFs
IG1vZGVscy4NCj4gDQo+IFRvIG1lLCBpdCB3b3VsZCBiZSBtb3JlIG5hdHVyYWwgdG8gZG8gdGhh
dCAnY29uZCcgY2FsY3VsYXRpb24gYXMNCj4gDQo+IMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxv
bmcgY29uZCA9ICh+diA+PiBfUEFHRV9CSVRfUlcpICYgMTsNCj4gDQo+IGFuZCBrZWVwIGV2ZXJ5
dGhpbmcgaW4gdGhlICJiaXRvcHMiIGRvbWFpbi4NCg0KVGhhdCBtYWtlcyBzZW5zZS4gSXQgbGV0
cyB0aGUgcmVhZGVyJ3MgYnJhaW4gc3RheSBpbiBiaXRtYXRoIG1vZGUuDQoNCj4gDQo+IEkgc3Vz
cGVjdCAtIGFuZCBob3BlIC0gdGhhdCB0aGUgY29tcGlsZXIgaXMgc21hcnQgZW5vdWdoIHRvIHR1
cm4gdGhhdA0KPiBib29sZWFuIHRlc3QgaW50byBqdXN0IHRoZSBzaGlmdCwgYnV0IGlmIHRoYXQn
cyB0aGUgaW50ZW50LCB3aHkgbm90DQo+IGp1c3Qgd3JpdGUgaXQgd2l0aCB0aGF0IGluIG1pbmQg
YW5kIG5vdCBoYXZlIHRoYXQgImJvdGggd2F5cyIgbW9kZWw/DQoNCldlbGwsIGl0IHdhc24ndCBm
b3IgdGhpcyByZWFzb24sIGJ1dCBnY2MgbGlrZXMgdG8gZW1pdCB0d28gbW9yZQ0KaW5zdHJ1Y3Rp
b25zIGZvciB0aGUgYm9vbGVhbi1sZXNzIHZlcnNpb24uIENsYW5nIGdlbmVyYXRlcyBpZGVudGlj
YWwNCmNvZGUuIElmIGl0IG1ha2VzIHRoaXMgY29tcGxpY2F0ZWQgY29kZSBhbnkgc2ltcGxlciB0
byByZWFkLCBpdCdzDQpwcm9iYWJseSBzdGlsbCB3b3J0aCBpdC4NCg==
