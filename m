Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196A769EBB8
	for <lists+linux-arch@lfdr.de>; Wed, 22 Feb 2023 01:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjBVAKc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Feb 2023 19:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjBVAKa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Feb 2023 19:10:30 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5875D30E99;
        Tue, 21 Feb 2023 16:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677024614; x=1708560614;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+b7IXXfiO0yVGbRO1va0y8Napiu1zSAoR2TQ4jx9luQ=;
  b=h+LCXeHxi44I5e1K+B1FT3qMX4xNlm+BDKkHiUbjBautYGW0HiJQvZSr
   at+l9rkJ8U8AGwOiPqq9kWoJQeSBm9+3OJfxG5GXE2+9oUQLRfYE3SCAU
   YSj2YDCiQCfGOaFZD1MtmHEkmwuYmhqSZXBctr9wG2Zapj6G/fQwLWhJ0
   kxp3hYfu02gX8Z6SP00ITb+j6me1ds03A48GYK0yL+1L+jSvYwla50xNK
   SdVZdppABeHRWPFDNX5xPfx2o4O48wNrFmh1flTcbJvTPLk14Lsum75QW
   N2C9Ek4jWtJMVyF53RCnABspTTyluyXHhpQdgtxLEbCHI0YwmVwN/kE26
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="397481189"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="397481189"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 16:06:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="781195224"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="781195224"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 21 Feb 2023 16:06:14 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 16:06:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 21 Feb 2023 16:06:13 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 21 Feb 2023 16:06:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmW9wwSLf5x9dZsVgd4ZBCR9uvOyX93gshkDxNyBrlYbnbfpxVwV8IUiYuNnJHkeJNyWCpc8suZiub7wBI5GRX3Vs5jSm/QZD8nJijTayFqef2ShhswlGuv+te+wWM1ET2kWiC41/84LC5B7K38bPGTQXrZ9uJtKyrzc9eFlj5zwn42GDQNSbGklwdKvE+2z6VY5vVguUjniYqY1c1Xihd1J4GGWhBdk414Spr5RqAuTjK5Xe6o4Cf/0bLvojC8HnEyFJtuhwup9p+7GclxC2qItbpx945+74bkHFuxSPCaX3RPyThfpt4P+7W49M4oowvFobZJpPgSNoPeU/OkJAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+b7IXXfiO0yVGbRO1va0y8Napiu1zSAoR2TQ4jx9luQ=;
 b=jjEpqlmYQeYsrOYzExHmiPYc7QzyUkHF9WDfQdOV4iBI3wmk64hakq12LSq3GMW0TYrdaI/kCtcwmWP2JG+R2gEuxrNU4oCzNfLgLJXIPSzoFYJ+mONLom7tTkjsVKLVQvh4K8v7vsrLYDWCjrt/yllrx5gs5cpQHQhwYQ5hy8CMQwIkXMoYKrUseD+gxF0sm/GRwr51827yg4D5adwFcWGydQAg3B0TO0mp/AgUaAZ4FmfGuhDyKcED9yFMze9c4y6mqtGBKaTPNfLBhd5dftZHjfyMe3As05ZAzVS+Ra5t+ZaeJit4BrsqsN2WhVApE+VaReCYGg/vbiHGXG1zgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY4PR11MB1383.namprd11.prod.outlook.com (2603:10b6:903:2d::13)
 by BL1PR11MB6004.namprd11.prod.outlook.com (2603:10b6:208:390::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 00:06:10 +0000
Received: from CY4PR11MB1383.namprd11.prod.outlook.com
 ([fe80::8a50:1507:bb1d:2f89]) by CY4PR11MB1383.namprd11.prod.outlook.com
 ([fe80::8a50:1507:bb1d:2f89%12]) with mapi id 15.20.6111.020; Wed, 22 Feb
 2023 00:06:10 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
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
        "bp@alien8.de" <bp@alien8.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v6 22/41] mm/mmap: Add shadow stack pages to memory
 accounting
Thread-Topic: [PATCH v6 22/41] mm/mmap: Add shadow stack pages to memory
 accounting
Thread-Index: AQHZQ95AuCiA6kLAS0S/RX8WTDnCKq7XzlwAgACjmwCAAKP/AIABBTuA
Date:   Wed, 22 Feb 2023 00:06:10 +0000
Message-ID: <54f73dbb6a26641616e258857f3cf1275d99ef16.camel@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
         <20230218211433.26859-23-rick.p.edgecombe@intel.com>
         <6ccc8d30-336a-12af-1179-5dc4eca3048d@redhat.com>
         <8bd58778e062bb9526c905c5573a2ee20cb41eef.camel@intel.com>
         <c2db1af6-972c-2aef-2732-d37c41c310a1@redhat.com>
In-Reply-To: <c2db1af6-972c-2aef-2732-d37c41c310a1@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR11MB1383:EE_|BL1PR11MB6004:EE_
x-ms-office365-filtering-correlation-id: de42b7b1-7d87-4874-1ae4-08db14689a62
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: apdnUAu6yX1frxITvuoNjGu+yNEE+UEJIdW2Orjens+LNNUK1X0Pewv+4/cn86tymJYIl+FvGHfZigPoR15MgX/HQX4sKNW10EusvdL7o2wBXn1STtwrH/p/8zpTyZNH57eNmFLdxKeXJ71EkktmpIMnLn9ofECT+b8Cu0Zpk7jpJiqaRnP7usg0m2GfiQWVOmrgl0BaAD4YlOjmEElluYOozcZuKpRfh8E6QUcCyvZpch8QsM4SmaUngyqjAn5Ma3CvawEkxulZHHBVpJKFu/I2JxdTdcPtyactG21zLYi0fX0q10ik2NWCC2lDapQ0ciDazgP2XFKj/U4b3s6QOolj3GPs+P8f1uIo0kYHzNS1/NH/tTUV3mMdFUYlJ1S1m0OMqTVsrJhqfrdOokrlAp54s2Yjfj3n1BLna1/8cNKGhp2yzw5sTRYpjpJS+IlGxoJ0lZRIEsD6IoSJxUG39ukoMr3kueF9x8C1fsgNSgNkVMJV+Cg0PBHDJOez8SKxhKQWs9K07nebQHNSS0TjQsdf5M5r3RIbqu1ZIo/rBi7QAQkmUL5rlWO06/kde5gvAi2UvHswhhbvh1CJaztVy0HCjblc+bhP8DgqVfrdWQkEtfycwaOOjK8LpAYt+WpmH20tpjlx7u7cys9yIAUBbGY6ugK8D0AZ+IARxZRSjCFDzRPhGlLQIG12m+4p9Gp7ViEOJQCXDs8jpifiBfGvg38MV7nip5jF2loXI98CZKo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199018)(2616005)(316002)(6486002)(966005)(26005)(6506007)(6512007)(38070700005)(186003)(478600001)(921005)(71200400001)(86362001)(4744005)(110136005)(7416002)(83380400001)(66556008)(66446008)(4326008)(66476007)(64756008)(91956017)(76116006)(66946007)(8936002)(8676002)(41300700001)(5660300002)(38100700002)(7406005)(82960400001)(36756003)(15650500001)(122000001)(2906002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDQvb3ZwVW00eWtrOXlMOC9jUHRQQlpQVkxPUEl2SlFCM241MlhxdU5RRlJI?=
 =?utf-8?B?L3pzT3d2Z0I1Qnd1VHE5YVZ1YlprV1BkdE1UdWsydGxHRGFhb1kwVFprTFEw?=
 =?utf-8?B?bDNHK2pFeVRoZGQ5YjNXeXlGd2NiMC9lY0dYclpUdUs1aUZROUlaZnpWdXNF?=
 =?utf-8?B?aUFyRTRSRzVBUG5HRjQ4M0djZzZVUjhqNmJIWkNNd0FRUEJIVTE1U1NET3ZC?=
 =?utf-8?B?ZkZzUktnQVhtV0JER1VIL0EySGJtUDdKYis4aVFWTldCaGQycDE0RHJNeEdZ?=
 =?utf-8?B?cUZYMnZaT2JJR2QzUUM3SWwvdXpWeWh0Wk41WnppVWlZRlkvZVE0UkYvSlpY?=
 =?utf-8?B?RU9pWkpiQkNPN0FCZWVaSFlVQ0FvYjY3bjE1S0VmZWk1ZTNYUkIySEJNWndr?=
 =?utf-8?B?QVFSb2QweWNFSmplV0UwZ3l1TFlxSFN3NnlwSXRUWkYzVmxPQ0tBVzhUbktU?=
 =?utf-8?B?VzRuNERIdnlhK2tOb2g4NmtIcnBuRjNPMEZ4SDdWZGpFYyt1UEROTEhNVERo?=
 =?utf-8?B?dG9mTytNNnNzY1RYcTEwMUh5eUxxWjFwWXd4RE5mMjhnbGhUakRHSWhXdnpZ?=
 =?utf-8?B?b0VEREFRYWZ3WnkyUmxycTQzT09TOHd4dmRaSGZsL0l5azZOcXd2VWlMT2dR?=
 =?utf-8?B?aGpkTFNtbG9BcUphSFNqbmxXa3ZCRFNOUjVsNW05ZW9SQ0VUcTJCVXNYN01L?=
 =?utf-8?B?aWZWalFEZ0E1NGZ4SU4xYTkxckN2d0ZYWTZUNlV5RldUbk56OHR6RVUzdVli?=
 =?utf-8?B?eHlzZVlpNzB1WHQ0TC9zRVVHcE8xeWNSL2VGWmFmTm5xUWt0VEFNVm1CNFor?=
 =?utf-8?B?NHZXUHhMN2ViS013VHRveGdxRjVZRXdrMTE4dXZ5U3JuZGtoT1ZGb1BjZUpF?=
 =?utf-8?B?ZVJ5VUVWRHcyYnM5SlZUZStXT3JXeFEvejE1elV2b3ZZYUhhSUZRM05PSVJr?=
 =?utf-8?B?aGZvU3hqdEYxNmhPT0hEN2hBUUMvR2tUZjlyTmhNN1ZudjRwb3U0ZnE4ZDFQ?=
 =?utf-8?B?TE0wRVpSSTdUYUNDL1p5N3hHbkFqa1RkbnJncjh2b3RFOU8rMEJXaXdzcU54?=
 =?utf-8?B?RkJRZVpOY0FET0N3RWovMFc3QjlkQWpudFFhYkZaclNNV2EwNGJnK0lXd29L?=
 =?utf-8?B?M1BMb2pFMk5RT1BZWk5nclI2RjRXcEVwRnRwZ0ROR041emk2MHBHTkgweUEx?=
 =?utf-8?B?RHpHdUwyQkhZV3p0bDJtZ2UrVTlDTFVrYXIvQXFBZXB4NDdaNXpnUEg0VHVL?=
 =?utf-8?B?Yi8rVnFuK1FNY2poZU5ZcXlyRjJkY3RlblhIUjZ4bzJLUWNTWVcrTU01Q0wz?=
 =?utf-8?B?MnA0cDhONEdUTHNYeXlkY3FhNlFnYWF6R0VoV2VKbVFSLytVZTVmUGMzRW8x?=
 =?utf-8?B?WDhkRXBtWmtaSWx3aW1ZaFBRZnh0cXh3akNsRDRLMVlNNTl0MHFyZ3lYZUlr?=
 =?utf-8?B?OGJ3WDVOc1ZBVGM0UXNNTGk2eTRkZElrT0RVL3JuUVJuLzdpWWY3cTdUck0v?=
 =?utf-8?B?WWp2VVV1RDIwSUQzcW1FalhBcStVcWxpZUM4eWRFa21UK2VwL0c2cnFkU1Vo?=
 =?utf-8?B?NE5zMDgzaHZxcysxZjRac3dtaXRIeFhSV1pBVFdrT0VGbEZjYzBNSklaMnIw?=
 =?utf-8?B?SWQ2akQvRmZCZWVqQkhJbnlCZzRHNTIyaUMzeEk1N1A3ZTlWUDZVOVNUWi9h?=
 =?utf-8?B?STN3OEloRGc5Tkwrd2xJT2N6ZEsrRUk5SWordVArUkh3WjB1QVZ0N200UjRM?=
 =?utf-8?B?R3VqZ2VnR2FQeW8wMWwwYm5lTVRiYzFxOXBpbEZYR0Y1cGNlWHdadkhVaDd2?=
 =?utf-8?B?SHJIdlhNQWpQd2hXS0FKTDFxMDJvRGlwYldDWWJzVU5ELzdOMEtOallCd3dE?=
 =?utf-8?B?SURxcWJVcVpNSzZBb0Y4dVpnK1NVZURqR2FacFVCSGRVdlU2NEtUNEtJQlJN?=
 =?utf-8?B?QWVnOFlCSGY5Y0I5UXB2cm1LWC9yemlWN2lZSmw0anNHSHRlNnhodTdJbWpE?=
 =?utf-8?B?UGdoZFZ1bG1WTGk1MnhheDVmbWRicnZIYVUyOXlxQldpaFVRMUg0bGpkekt1?=
 =?utf-8?B?M0FIRStLU0Jpa3ZvMXkwRjY1dWZRRzR0VnVDVEgzUFdLZHRiTUVmNjdnSVVy?=
 =?utf-8?B?WVY0d2RESXNCRkg4WUtzV20ycmN1V1VBeGtXNWwxdnVGMGdLaHZKazJFdjM0?=
 =?utf-8?Q?G6PbfIrbi+ulKZzOt2xT7Fw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D85E8E97CFCDB84793C38948876BF3D4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de42b7b1-7d87-4874-1ae4-08db14689a62
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 00:06:10.2019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Jhl3JOcnwuoAk6Nm/fi1m6hchPd6BGVJe+aioysd2XIyTke8jTw5ft+Xx7JPbNsqxpNVdnU51I/dWowVVxeyVodPL99tfQLmbsJzDHH7VE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6004
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIzLTAyLTIxIGF0IDA5OjMxICswMTAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4gPiA+IFdoeSBub3QgbW9kaWZ5IGlzX3N0YWNrX21hcHBpbmcoKSA/DQo+ID4gDQo+ID4g
SXQga2luZCBvZiBzdGlja3Mgb3V0IGEgbGl0dGxlIGluIHRoaXMgY29uZGl0aW9uYWwsIGJ1dA0K
PiA+IGlzX3N0YWNrX21hcHBpbmcoKSBoYXMgdGhpcyBjb21tZW50Og0KPiA+IC8qDQo+ID4gICAg
KiBTdGFjayBhcmVhIC0gYXV0b21hdGljYWxseSBncm93cyBpbiBvbmUgZGlyZWN0aW9uDQo+ID4g
ICAgKg0KPiA+ICAgICogVk1fR1JPV1NVUCAvIFZNX0dST1dTRE9XTiBWTUFzIGFyZSBhbHdheXMg
cHJpdmF0ZSBhbm9ueW1vdXM6DQo+ID4gICAgKiBkb19tbWFwKCkgZm9yYmlkcyBhbGwgb3RoZXIg
Y29tYmluYXRpb25zLg0KPiA+ICAgICovDQo+ID4gDQo+ID4gU2hhZG93IHN0YWNrIGRvbid0IGdy
b3csIHNvIGl0IGRvZXNuJ3QgcXVpdGUgZml0LiBUaGVyZSB1c2VkIHRvIGJlDQo+ID4gYW4NCj4g
PiBpc19zaGFkb3dfc3RhY2tfbWFwcGluZygpLCBidXQgaXQgd2FzIHJlbW92ZWQgYmVjYXVzZSBh
bGwgdGhhdCB3YXMNCj4gPiBuZWVkZWQgKGZvciB0aGUgdGltZSBiZWluZykgd2FzIHRoZSBzaW1w
bGUgYml0d2lzZSBBTkQ6DQo+ID4gDQo+ID4gDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21s
LzgwNGFkYmFjLTYxZTYtMGZkMi1mNzI2LTU3MzVmYjI5MDE5OUBpbnRlbC5jb20vDQo+IA0KPiBB
cyB0aGVyZSBpcyBvbmx5IGEgc2luZ2xlIHVzZXIgb2YgaXNfc3RhY2tfbWFwcGluZygpLCBJJ2Qg
c2ltcGx5DQo+IGhhdmUgDQo+IGFkanVzdGVkIHRoZSBkb2Mgb2YgaXNfc3RhY2tfbWFwcGluZygp
IHRvIGluY2x1ZGUgc2hhZG93IHN0YWNrcy4NCg0KT2ssIEknbGwgdXBkYXRlIHRoZSBjb21tZW50
IGFuZCBhZGQgaXQgdGhlcmUuDQo=
