Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F366B6DA5
	for <lists+linux-arch@lfdr.de>; Mon, 13 Mar 2023 03:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjCMCxf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 12 Mar 2023 22:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjCMCxd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Mar 2023 22:53:33 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9679E22780;
        Sun, 12 Mar 2023 19:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678676011; x=1710212011;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oHSLpd8lXC9bNU9V41bm4MO4cbpqggWv3PataWFEE1U=;
  b=TH3KjgSUxju/QE0kK4f4XhpwpD3ACy34Lu83eZmxkaPdA+O4kJkDlhPK
   KTqVIYWcOIg6jy8UU+sfDso+F/AgHm7AzqSSIpZsl3Fw42RSk2arTbCqQ
   GnAoDCKdmC8hZz8FEhkArk/LA3eyOXkbp/UyDp/yIoQBepTfbcHxBAPOa
   pKCRNiXqeEFZAYPWiLh1Srb5ul2coN0zM/QbXjEWnGPIBsS/QhRSMZMr3
   evHMQcfP2tjYTyXcKA7zYvZOgm+s+UrA0DZ4At9gushmT9gMwkTE3L3t6
   MlJEmCK/hOTJP1/qZ9TeRZyCUGkJWXircGj5giKEmsslCHe9nCnt9wo3Q
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="401913917"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="401913917"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 19:53:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="1007823972"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="1007823972"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 12 Mar 2023 19:53:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 12 Mar 2023 19:53:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sun, 12 Mar 2023 19:53:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Sun, 12 Mar 2023 19:53:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buaPgK39zQvBeNJPbTP/X/302zbfMctTZzd+/TY9iHJLGzjUZAY6FM7ujSav7NbOuIVlJSgVqZII1GxNWp09svJvWmQqgMNmqUA4fQe2/jHkVQKf0E2tU2f0Be7wvnyA5j1H6Jx3SZKzvYsiitDb/0Se2mX6RsYJQzh59JOD+q0s6shxFUgL4Vb0wEro5Wht/qBE2SPu9lRjJCMfR5LxCGe+yd2EvEJohi5g8WoRPtFCUuIEJ03w5c59Di9TCYCluzxTFK4O1n9MI8attXH+pCWiP/yUKcBeg9e994vOopJkzXZMBIXFT1/THBdGSILzkCWrCTRGrUWaYLMLEHJLsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHSLpd8lXC9bNU9V41bm4MO4cbpqggWv3PataWFEE1U=;
 b=O0x2pENPS4qd/3jov936t2Vv0kohWqEr3gMRSeVqItWwBIrgS/rS40kyj781aXueObR0h/ghpEBNa7dxMYSaBfwAoZbmi2qUB5p/BaH9QMGDcr8+Jks/T/SgNSyvt8BiWPaCfmevIc4z0f6Y+U7IQ694DF5Z+dckPeVokfynaKOE/vOB3VV1pIJ9UKDVCMI0gACE/KfTQ709tbrp2btkz+d5fSUJlBwZciaVieFli3sgjnIToM8zkqytQXgl/tqnlXBjKpIPTpWWjfBahhkZLijR95MmLNK+D3fNQRyeH9nr3C1L5sSwpcw2h++KVhtaqhcr+sXspaKeDXRyTDrAgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH8PR11MB6707.namprd11.prod.outlook.com (2603:10b6:510:1c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 02:53:19 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 02:53:19 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
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
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v7 39/41] x86: Add PTRACE interface for shadow stack
Thread-Topic: [PATCH v7 39/41] x86: Add PTRACE interface for shadow stack
Thread-Index: AQHZSvtHwdFouI2K/UKOkw6dvX54Qa71wAYAgAJX8QA=
Date:   Mon, 13 Mar 2023 02:53:19 +0000
Message-ID: <a4853ba2f42b7be9fc32cb2f941fcf4209a02a5d.camel@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
         <20230227222957.24501-40-rick.p.edgecombe@intel.com>
         <ZAyY2mor+HJAO1ht@zn.tnic>
In-Reply-To: <ZAyY2mor+HJAO1ht@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH8PR11MB6707:EE_
x-ms-office365-filtering-correlation-id: a9f466af-0b8d-4195-e9d5-08db236e1a0c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +RR7zxGcOKAfRH84wdnsQG/ZUqjH1GmRQLonqflQ8GWUtyy3esREc5eXpErXH3xlvdeB+iwJU1TGwWtTsKOCZGp0W/fjIDQtIj5SyIa5Ew4AgSZcbyeWiLHBeOD1pb1fwJBxXxui6xOthAkSthLMkAQbcXrKUAq3nCprZRF8iPRLDbRlwQXDLPU9XHJHjdYsTT4zXMlKT5LFjLIrgYI1IN7b2NaWKNP3rykAbzoTuXO9PP2uVHHhgN4uHthFtnW6u+MYWCpfRgQoFfoouq/QwfhxAyEzthDPpk4GkR6tkv5b+AdfN+vQCb3UpHggutQ4dTw4EOu1n2AeeNnhvz9YKy9wrLIeN09b8AergzhH3Lw7DTzab7GDRxsAFlHPUKKosJ/Y4J/VWNBxlIMilQ9IhSXWCQsBJ068MEKs6ziHwLo0SSOzIRrDE/gTYrOaidCW878vx8CFcLuZMZ4I9mm7Gc+TzEduSAE5yyQSIICu5Y29kHc/Qz6z0WfMDaFUz4kbrQhHMJCbvwPT7dnuGDxxQB1yHBRXKP798Dkt+mOWvefMDaYv7qvL/qh5FdDyd9lAuhShbbjlc4L3CxFg+CSg54WantCyHZPEG9YmwRBZdit/MnUVvBIqpkZGyqcCh+sjMGR3MnKZILidfUcpy9AsHJ3El/7pIVQCg5UthtSbaGXxcfAaniV7mZzNmhebAP/nhje5t8BgW77gwYn/SI21ARythkSb0c1EXA5ePLo0iQo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199018)(54906003)(41300700001)(8936002)(91956017)(478600001)(6916009)(66476007)(4326008)(66946007)(66556008)(66446008)(64756008)(76116006)(8676002)(36756003)(86362001)(38070700005)(122000001)(38100700002)(82960400001)(26005)(6506007)(6486002)(71200400001)(186003)(7406005)(7416002)(5660300002)(2906002)(316002)(6512007)(83380400001)(2616005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXhUWDFWajVzc2IxeGpkZDhDd0dLNnBmclBVTVFGL01tbFkwR0ZXR2ZTTENN?=
 =?utf-8?B?Q2xwSVlBdFpEK212RHZnMUtTb0l3eG16Z3oxS1VBMGhmbS84enN1YVc4Zmlo?=
 =?utf-8?B?YnJZejVMRHhSNGdoNW1RdldyTHFnVXJvaWxkSlVlMTBXb2JHWjdtdFpGQU5a?=
 =?utf-8?B?dWovU3JMUU0yYkE5TDlQNEQ5cmpXYm1YZ1h6djFFZ1NZQ2xycWIzTWE0NFBD?=
 =?utf-8?B?cS94bllOcmJzTVZyRjY5V1dmZHFIcjJGRE1jaXU1RjlpYi9yYnNmYXFwK0Nl?=
 =?utf-8?B?SENQR2wvZXJmRjluVXVxelluNm1YR3hjUy9sN1VhMm03MThDUzBXdTJab0gr?=
 =?utf-8?B?MVFyM2pBTnBaaXhaT3pBTnh6V0phL21HUlIzNm9Gc284V3R0Rk52UkI5TXlM?=
 =?utf-8?B?cFZ6U1B4Y29ranV0RVRxUXUwUCtPSjNKZXQwWUtWbFd3YW8ydy9rYllnUGxn?=
 =?utf-8?B?VWhWTUFBMkhrYU5yTUl2UGI1S01vdEVpWVJ0NmhBRnd5azVRMXh2bm13UlBQ?=
 =?utf-8?B?Z0NsL2tJUEZVM3FpSnJNaUQzbjNFMXF5NXZLT0l5ck5aQUI1a1RLb3h4WUZv?=
 =?utf-8?B?dFU2Z2NJQ25XaHVoYzhxUEN6NzhJZnovUVhYSVRQWmlRckRhbnJzZE9HSHJw?=
 =?utf-8?B?ZWxrRU44QnRUZVE5SjQrYndCbjdyMHpRYkxKdGxodkZ6WVhqWURkOW1IdXZq?=
 =?utf-8?B?M0ZzR0pLSjFrbkVKTkUvKyt4R25KV3B2ME1XVkJCVlVmTmN0QU9aVldxc25v?=
 =?utf-8?B?ZHhoMU41ZjJoV1p1UldxTTl1RnhIdUpRdy92V2RxbVJHbExJZkNFNDZPR3g1?=
 =?utf-8?B?Z0N1b3pYbGEvU1hTVVFSVkpQeGdWNmFBYzd4N0s0TjdjbmdJcU1UYW9Vc2hl?=
 =?utf-8?B?dmxSUXIvZk1KeDFWK0FiT05RSG9pV2Roc28vOGljVFhMSDl4TDhyS29xbGgv?=
 =?utf-8?B?ZzZub1BuM080YUI1Yk91bzVWMU9qeW9ZaEdiV3dLcUxQMTNKK0wzS0l0cCt6?=
 =?utf-8?B?ZjRnVFkrejZZUHVFbmhpdXFxcEF4M2dXY1FjcXhXb3lIdTFTRldEam1nUW9W?=
 =?utf-8?B?M1BIRlFZMlVhWlc4WnYxNHJpRXZHTVAzQ3RabE9KVHBwazU3anZYeU5ISTFi?=
 =?utf-8?B?NFRQV2FPdlg2VytrNEJ3MlE1bnlLU2t1UStKRmd5WTBiamNxTVo2eWxnYTdw?=
 =?utf-8?B?MEJYajlDUC9nUWxKMUNzT3hRbElFeTIwZHFpdkRpd2ViOUFTOTRwSEQyaXk4?=
 =?utf-8?B?L0x5WTJrWFloOUUrazNud2thc1QzNE5HK0dPaDlOY0QrN0VJc3RKU29zcFVs?=
 =?utf-8?B?SDNlVHRBZzVoeUcyNGUvVmdneHkzSkRtdWoycE5qT3RqUlhldzZWV2lDYnM2?=
 =?utf-8?B?ZmdUWjRlQlRkUVpsRmpOelAzTTFFeEVZcW01RlY1SG5hZUZHRW1HL1Q2MVl3?=
 =?utf-8?B?MVIxSVBRVW5TWEtOYmR3ZXk0YVBvM3MzeDJ1c1R6K1ZyOTF2VzBpeUU2ZGc5?=
 =?utf-8?B?V0FLNno1eThwdTA1eUFoUGdKa2I3QTNmNndLdkM0N01sbk5vM2E5QVR5T1c2?=
 =?utf-8?B?Z3NVd2VyUThWbXl0Mzc5SUFQU0tHUjdxSDIrZVRSRGw4RXhvWGp5YTRydzl5?=
 =?utf-8?B?UFZNOU5QZ0k0d1FGdHhsTTJCZHB5cWVxdkx3dmlkZlpQQjlxaEx6MzVmZ2cx?=
 =?utf-8?B?WUN1a1ZFNXNhZVNZTTEraVNKY25jbnJHc2pGMktkRTZFVnc5QVpwbWtLNWxW?=
 =?utf-8?B?R2lRUXlQRHhQQlVIREdJcWx0Y0hLWk05VzlWUjVvTlBIM2h2Mm1GbEUzbTVh?=
 =?utf-8?B?N04xODM0bDlVbE5hUGc5MlZZcWwvRVBETmUyZmhhdXdvRU15WXRoZXNPL2Zx?=
 =?utf-8?B?cW0waDNoSVVBeCtkOVkwYVRsaG01aFlBL0E3MS9VeE5zWExFcmtINEU5MzZh?=
 =?utf-8?B?QzVPYytMVzQrTThOTm5jbEVNVyt4NFN6ckloanJxQmU3NnIwWWp6RXdEeXEx?=
 =?utf-8?B?T0NTZC91KytUcXdTUVF0bEhuUkJGT1VqQytranpwd2hVRVZ5WHcrLzUyS01T?=
 =?utf-8?B?NEN6Z1k2cFFoOGJicVgvSVJUNlB0c2NSNzVhOEpkR08rcFlvdytlK3l4VnVP?=
 =?utf-8?B?TERwcjluUzRVWXZmV3R6SG9OU09YbFAzWFc5blFZU1NsczBHeDh5aGVZNkE3?=
 =?utf-8?Q?tcCylVZL5FJ2hNQrh/M3UL4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F619EDE08220E449C2B6C7074E1C0DD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f466af-0b8d-4195-e9d5-08db236e1a0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 02:53:19.3017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b/nXXNfhs0ZyZoPGgzdxT64dAHXx+9NaNzkw9BpDAo0ex30d1Z3HLS+PVhX8R14CVYLdF7+aB7EnptuxhTNObQkZ/8HtXKUtJ3PmTgXNIr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6707
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gU2F0LCAyMDIzLTAzLTExIGF0IDE2OjA2ICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIE1vbiwgRmViIDI3LCAyMDIzIGF0IDAyOjI5OjU1UE0gLTA4MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KWy4uLl0NClRlc3RlZC1ieTogUGVuZ2ZlaSBYdSA8cGVuZ2ZlaS54dUBpbnRl
bC5jb20+DQo+ID4gVGVzdGVkLWJ5OiBKb2huIEFsbGVuIDxqb2huLmFsbGVuQGFtZC5jb20+DQo+
ID4gVGVzdGVkLWJ5OiBLZWVzIENvb2sgPGtlZXNjb29rQGNocm9taXVtLm9yZz4NCj4gPiBBY2tl
ZC1ieTogTWlrZSBSYXBvcG9ydCAoSUJNKSA8cnBwdEBrZXJuZWwub3JnPg0KPiA+IFJldmlld2Vk
LWJ5OiBLZWVzIENvb2sgPGtlZXNjb29rQGNocm9taXVtLm9yZz4NCj4gPiBDby1kZXZlbG9wZWQt
Ynk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+DQo+
ID4gU2lnbmVkLW9mZi1ieTogWXUtY2hlbmcgWXUgPHl1LWNoZW5nLnl1QGludGVsLmNvbT4NCj4g
DQo+IEkgdGhpbmsgeW91ciBTT0Igc2hvdWxkIGNvbWUgbGFzdDoNCg0KUmlnaHQgb24gY29tbWl0
IGxvZyB0eXBvcywgYW5kIHllYSB0aGlzIGlzIHNjcmV3ZWQgdXAuIEkgdGhpbmsgRGF2ZSByZS0N
Cm9yZGVyZWQgdGhlIFNPQidzIGFscmVhZHkuDQoNCj4gDQo+IC4uLg0KPiBTaWduZWQtb2ZmLWJ5
OiBZdS1jaGVuZyBZdSA8eXUtY2hlbmcueXVAaW50ZWwuY29tPg0KPiBDby1kZXZlbG9wZWQtYnk6
IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCj4gU2lnbmVkLW9m
Zi1ieTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0KPiANCj4g
UGxzIGNoZWNrIHdob2xlIHNldC4NCj4gDQo+IA0KPiA+ICsjaWZkZWYgQ09ORklHX1g4Nl9VU0VS
X1NIQURPV19TVEFDSw0KPiA+ICtpbnQgc3NwX2FjdGl2ZShzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRh
cmdldCwgY29uc3Qgc3RydWN0DQo+ID4gdXNlcl9yZWdzZXQgKnJlZ3NldCkNCj4gPiArew0KPiA+
ICsgICAgIGlmICh0YXJnZXQtPnRocmVhZC5mZWF0dXJlcyAmIEFSQ0hfU0hTVEtfU0hTVEspDQo+
ID4gKyAgICAgICAgICAgICByZXR1cm4gcmVnc2V0LT5uOw0KPiA+ICsNCj4gPiArICAgICByZXR1
cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiAraW50IHNzcF9nZXQoc3RydWN0IHRhc2tfc3RydWN0
ICp0YXJnZXQsIGNvbnN0IHN0cnVjdCB1c2VyX3JlZ3NldA0KPiA+ICpyZWdzZXQsDQo+ID4gKyAg
ICAgICAgIHN0cnVjdCBtZW1idWYgdG8pDQo+ID4gK3sNCj4gPiArICAgICBzdHJ1Y3QgZnB1ICpm
cHUgPSAmdGFyZ2V0LT50aHJlYWQuZnB1Ow0KPiA+ICsgICAgIHN0cnVjdCBjZXRfdXNlcl9zdGF0
ZSAqY2V0cmVnczsNCj4gPiArDQo+ID4gKyAgICAgaWYgKCFib290X2NwdV9oYXMoWDg2X0ZFQVRV
UkVfVVNFUl9TSFNUSykpDQo+IA0KPiBjaGVja19mb3JfZGVwcmVjYXRlZF9hcGlzOiBXQVJOSU5H
OiBhcmNoL3g4Ni9rZXJuZWwvZnB1L3JlZ3NldC5jOjE5MzoNCj4gRG8gbm90IHVzZSBib290X2Nw
dV9oYXMoKSAtIHVzZSBjcHVfZmVhdHVyZV9lbmFibGVkKCkgaW5zdGVhZC4NCj4gDQo+IENoZWNr
IHlvdXIgd2hvbGUgc2V0IHBscy4NCg0KT2suIEkgdGhpbmsgdGhlIG90aGVyIGNhc2UgaXMgaW4g
Ing4Ni9mcHU6IEFkZCBoZWxwZXIgZm9yIGluaXRpbmcNCmZlYXR1cmVzIiB3aGVyZSBpdCB3YXMg
bW92ZWQgY29kZS4NCg==
