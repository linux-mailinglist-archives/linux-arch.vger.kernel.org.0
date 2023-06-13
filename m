Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22ED72EC15
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 21:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239029AbjFMTiS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jun 2023 15:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239062AbjFMTiK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 15:38:10 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC15119B6;
        Tue, 13 Jun 2023 12:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686685088; x=1718221088;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8PaE35h5PX51SxobO2r4/P1z8Jc3CIVhdawF6r7l7W0=;
  b=V1yRT+LcMBIu2Ve8fmg6Bw/93Bi5q8R/72fnti4EqPiDgR4t9JO/QsM2
   k3lKHTiQDvLMGQU68YImFdYn+6xIQsCuAR00lxVXaVH6FKZrhEgNPuxtZ
   wdzYoa8mGBQp9za0/nOiGSGOFQi/1hzUi6sgU1txKEjiZPi+z2H1q3F4M
   sfaphuKH/+aqUmTi1neFWX7WsfrJuzhAFxkFt1qkuIkhPofil9dC5kwS4
   WT3huMpaRFEhFDFWRKzp0STG2ZXJnY+j/fwq/xrFCfJ28N8ZSYFpNmrlr
   PjnKZbRAkdYnIA/+gYhmN7/YQGngIUCikkN1ISoItI30iXpG7+LPzxCGQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="360916949"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="360916949"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 12:38:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="801608689"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="801608689"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jun 2023 12:38:05 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 12:38:05 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 12:38:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 12:38:04 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 12:38:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJ/M8dy08LiaWaYTj3frejukzB0jx0FZ/f4H57Fno26xwrM7l9jgk9I7tWyeY1TFtqkLt/V6tO0UbPcf8g3UKL8xcYI3wSzUggI1CG2/vPqmCLCsjnuscv45usE93+UwMx28oUIQedxoefVhJ4Er7Gj8UfyXTl0E2egN7cVpF6qt4HRhGiiqF8Rl2DsKHBtAw0rtX7yLNAvhprYfdT4eWxwaUnQ8eha5g8/UcOctPzSp+4LRVUPL8wWBYoHkS+iNOiAgiGlsZ+nGUW87gVd0qN0dxRhTNkqVi5X1Hkvt7rtEVgGzbsUUAASXWNCHjp8mL5T7oOhPA36CAMOzLR5Elw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PaE35h5PX51SxobO2r4/P1z8Jc3CIVhdawF6r7l7W0=;
 b=TwatOkL1rerCesxiFYeEWbGL/rQYFQBZaj8SdkD5+jaHkeauybXxEblh3KXtycxcPgaXzaBUH+EpHuLLxhJnqEjHljiaizeFEirtqFQPleL9XQY1kQC9bYd8B1XT2xFy/xUFMJsYItT+XmLj6sxLblZ+Q+5US3Gm6926LfMMSYNT3bXiQT2HFdlXt53oGs6gn+40Aao3eiTVfZnXcvuKJrOmCZVVWLppfMiKB7zJ87hOOjftIN3ADNsobqge+AKrjJL4Ajmwm3mxcqFaCljpnxF/GhmxhdXwRA2Y/Jowvh8kFs6RQ5/OIrzc/4dQvl7YglcqUH5BK5iHDX6+Mb34JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MN2PR11MB4552.namprd11.prod.outlook.com (2603:10b6:208:263::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 19:38:01 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec%7]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 19:38:01 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "x86@kernel.org" <x86@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 00/42] Shadow stacks for userspace
Thread-Topic: [PATCH v9 00/42] Shadow stacks for userspace
Thread-Index: AQHZnYu1AGwEUQxptkKuIexmuYma76+H81+AgAAbXYCAAPOmAIAADAWAgAAToAA=
Date:   Tue, 13 Jun 2023 19:38:01 +0000
Message-ID: <e5204167f7a43c1c0bbe76bdbc6f02cc3146f93c.camel@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
         <CAHk-=wh0UNRn96k3XLh2AYOo0iz1k_Qk-rQXv8kYjXkKBzUMWA@mail.gmail.com>
         <c239d2c4f7e369690866db455813cac359731e1d.camel@intel.com>
         <CAHk-=wjSWhVV+qr_tV0xg8c0WRn_H9wtFZkUVCpv-VzsddAS-Q@mail.gmail.com>
         <CAHk-=whY0ggV9P+3Ch1LcqefnS3=O7FmWkOPoiABD7QJGtwSHg@mail.gmail.com>
In-Reply-To: <CAHk-=whY0ggV9P+3Ch1LcqefnS3=O7FmWkOPoiABD7QJGtwSHg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MN2PR11MB4552:EE_
x-ms-office365-filtering-correlation-id: 514930e1-d47f-4fc4-5ec2-08db6c45b2e2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JwMWSfOdPLsS0Ozovm92xr8OXBrNsTQjaRJrMgso/B6kb4bcpJTUdawrerxk+PjVVCMiQ3a7t7icYE1x7Xqqd5lqWznFdvEg91MktGbuOFHNzQl1hHAU5hjlqfgDdU41x7NQIzWLO3tkBzb/Tr5JxPQ9+zOR473SSa0dBRan4Jh0Y1sGe2m0fti1nG4OtoDXNapMrjCgqYMqN8b1XC+CsRkxRpW3159tk0V5DWPRd/1PHkmh4yiR1yG/GikUNcCNiWup82us3XHVeGEmWrxPcKeq3FHTcNdel6nn/A42ya2AIiaRAFmwLQmMcY29/Sau+5CRpUHaUuwz2Mrbz1MX0vxAkyvHtrUz5dcEFje6FXoLx4vnCIb+okHFgBKvGfXAH81LHSJJ+ZXjbTJjvSWga7jIA0t/HtXElts10OWNuTV70gvnSVYIC/AntCgNRLVq08VD5gA20KrsGVbQWgcn9Jng0pHpMaW1DOTrOI7oOVfgIrf23unAt6gXUTbJRrLwPxXZR03GlpuFA764ZxNAm69ehSZP4W/UKX9iey6Zt3tJXvJGLmOiCGjlunxYOpdSWzwzhqZVgSXFHanH8hvkeQ9gTzXWdTqnG2418lExkD+RzXzVz8FkWKGK1gPRFSJO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199021)(6916009)(8936002)(7406005)(4326008)(64756008)(66476007)(316002)(91956017)(7416002)(66446008)(41300700001)(76116006)(186003)(2906002)(54906003)(4744005)(66946007)(8676002)(66556008)(5660300002)(71200400001)(478600001)(6486002)(53546011)(6512007)(122000001)(6506007)(26005)(2616005)(36756003)(38070700005)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NThLWDJvUFFsbWdlSER1d3JQWVp3RnFIVjJkNFFtb3FZMGpDeFhjZXFoZUFE?=
 =?utf-8?B?Q0RWQ3ZrdWlFKzdIQ0JDK0pIRWxTQXZtUnUwNWVtWWxPblJuK2RvNDdRSnUy?=
 =?utf-8?B?TlFUbGozeVMwb2RvT2VPRGQ1TDZublMwTnJWVUkrMnNlZ2xYQ2Q1ZnFHdyt4?=
 =?utf-8?B?dGZXOVhRY3lKSjdlWi9MWXQ3R2V6T09ObXFVMG8xcE1xcGt3dU4rWE5zM2Zi?=
 =?utf-8?B?Q2Njejc0UmZGaVJZV3czVGR1Z0llYXRLa2IweXphMjdEVm9MV0xuVTNDbytX?=
 =?utf-8?B?QkIzS0RZcVhqR1FwQWEyRXgvTUZ5VCtlVVR2L0NzbXVUdXJKTStOS0hvaHI1?=
 =?utf-8?B?OUp3WnBzTlZEaCtIYlVXYUIyaWtLcXgyRWZpZ3RjeDVHdVBwS2tvdjBlV0t2?=
 =?utf-8?B?Tkt5aDU3Z2ZCZXZFaXh4Y2RJaFFZdGNtQW9EZXpaVExWN0tNRlp0TmdGajJt?=
 =?utf-8?B?MGx0WEp1SmJ2R2UrMElLZUcvOWJ0dnM3KzNvMFcrekJoaVB4V3h4SGloVUJZ?=
 =?utf-8?B?NFIxR3JSUGNDZk1GS21iWmNyTiszR1lNSU0vdHJDV1QvMW04UXJQZ2MzYjhB?=
 =?utf-8?B?cGRTQkNuMWR1RVBuQzFYT1djRmhhMWFVd0tGbTIwbWR1M0dIUStIbkVzalVZ?=
 =?utf-8?B?SkJadnhyZEJQMk5KVG56SlRHWW03cENUYU9kRnFOQlAzVnYzb1h2ZXY2eVFj?=
 =?utf-8?B?eEdSNnZ2d3hKTUREVG1tRTVOK0xESlFHZnJLTVRiSFcxMlNudXJkZVVER2Nr?=
 =?utf-8?B?MFN3N1RiVThBRXpUTVZKa2I5QXlVcVl1aFcwNWxLeldWQ09lSklnYmhEcUZ4?=
 =?utf-8?B?M29hcGdRNE5QK0dDdmdnbkJ3RWZuRW9iVjhZV0xPWHJMak5IMk1QTXdZc0lC?=
 =?utf-8?B?N0JOMHFwWnA2T0RtcXpTaWRQVm5VaWczYjhsL0xtN1p0eTFTcjczK25NVGRK?=
 =?utf-8?B?RC9jS1F5QlU0NmM1emZyZ1ZPNU1lazA4LzN5cVN1YnZTclBVS213T2dqdGxM?=
 =?utf-8?B?M2V3MG1GMEEzUWUxendOckdOK2s3RXR3eWQraXcyUi9uTFRFSWlvQ1NwWFR3?=
 =?utf-8?B?dEo2K3dSdUQvWjczdXRxcnJkTWFLTFVQK2RFMnFzOFgwRlZyNWlGZkdtdHR6?=
 =?utf-8?B?dXhZT3ljNHk3UzlkS0FuTDh5djYxdzBmMzVCOEZWMzh4aGpiOGdpbVk4bmVQ?=
 =?utf-8?B?OTFITERCb1lyV04yd2NxOGhxYjBkVkNjcVp5OHBqOW9UbEJvaWg4ZG9Ed3JZ?=
 =?utf-8?B?RFE4UGhxQlgzT2I5TS9EZUJNOHBXYnYzeGp6U295MERIUUJ4TkRGT3ROV3VQ?=
 =?utf-8?B?V3VXbzl1enVKODFZU2hjQU9TNi9sRWZXUUVYQUZvQVBmcTB5THhneEtUTHk2?=
 =?utf-8?B?K1UzellQcFg0ckRraU9EbHRBRS9HT201S2c0ZkV6cXNPUEhqSWxVcW5TdkNy?=
 =?utf-8?B?VUNZMThPajJDdkRLV0VQcTVXVDQySDAwemVTNFlyYXQ1Qi9PbmJvK052cnIx?=
 =?utf-8?B?WEpMeFJJVHBTY0o4dTg1cTNYS2w2Z0c4TTdCYW9JZmg4Z052TFJPd3hzRnM4?=
 =?utf-8?B?MHRoRG9nTWRLVVhWbWhjOFJVTVFoaU5TQ2UyOEJOVkxKZEdQZ2JkOFE0ZDRv?=
 =?utf-8?B?VGJTWnU3STRxK0xZQ1Q1OERSZHR4OGljZGY4d1prdUxIdnIyR05rb044MDJS?=
 =?utf-8?B?d0pFcXZaTmdLdXRXZXBtSU1IQWpqeTVydXdZTDNJSWkwYkRuODNTcWd1Sy9D?=
 =?utf-8?B?NlFzZzFGRzNKdm5wRHZ4cCszU2NFd0k1T3VocUZmdWQ0TkN3dFFiakVHVGpN?=
 =?utf-8?B?M1IxR3M1RSs3SllOQU1XalR4Nlh3NlljT01JTWZpNUIvUSs0amI2dHdjanB6?=
 =?utf-8?B?Mm5qMW1hQTI5TmFGOE9HeWpyU0FYb095UWQyVW9xUjRJdGdQRTVJWVF1QXF2?=
 =?utf-8?B?N1VBZ1pPbU0zRDRzdGc3WlJaVFBubkt0RkdYN1ArbVZybW5kY1FQTVd5R1hW?=
 =?utf-8?B?dzBZVkxETTgvd05aOFMyMnhWTElNakEvbW12RGo0L0l6QXRoWkR4KzJnQkUw?=
 =?utf-8?B?bWVKZVVzKzQrNTRWalBxbjRrdnFGR0hxNENuSEVkY1prQTkzbzEvTHpJT1NK?=
 =?utf-8?B?NDJ4L1R1VzVoR3REd2ZwVEIyc3Qzc3JuWktnZDMvZ09FM2haSkYzUzMvQTU5?=
 =?utf-8?Q?xAB6A5otMbPBVwyhbDDVEKQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55A61A764CAC564B87D3FAFFC67B59D9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 514930e1-d47f-4fc4-5ec2-08db6c45b2e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 19:38:01.2570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qn9XmutSFcWV8BmCagMRORk33urjXQP5r8tkOK6mhUBSlvxNPu3Q9V+Z9AQmxZsHUkMwofGC144x4Uzmbd/MdbCEqDNKpvmPyYwCwHKKAAA=
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

T24gVHVlLCAyMDIzLTA2LTEzIGF0IDExOjI3IC0wNzAwLCBMaW51cyBUb3J2YWxkcyB3cm90ZToN
Cj4gT24gVHVlLCBKdW4gMTMsIDIwMjMgYXQgMTA6NDTigK9BTSBMaW51cyBUb3J2YWxkcw0KPiA8
dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiA+IA0KPiA+IEFueXdheSwg
SSdtIHNjYW5uaW5nIHRocm91Z2ggaXQgcmlnaHQgbm93LiBObyBjb21tZW50cyB5ZXQsIEkgb25s
eQ0KPiA+IGp1c3QgZ290IHN0YXJ0ZWQuDQo+IA0KPiBXZWxsLCBpdCBhbGwgbG9va2VkIGZpbmUg
ZnJvbSBhIHF1aWNrIHNjYW4uIE9uZSBzbWFsbCBjb21tZW50LCBhbmQNCj4gZXZlbiB0aGF0IHdh
cyBqdXN0IGEgbWlub3Igc3R5bGlzdGljIG5pdC4NCj4gDQo+IEkgZGlkbid0IGFjdHVhbGx5IGxv
b2sgdGhyb3VnaCB0aGUgeDg2IHN0YXRlIGluZnJhc3RydWN0dXJlIHNpZGUgLQ0KPiBJJ2xsIGp1
c3QgdHJ1c3QgdGhhdCBpcyBmaW5lLCBhbmQgaXQgZG9lc24ndCBpbnRlcmFjdCB3aXRoIGFueXRo
aW5nDQo+IGVsc2UsIHNvIEkgZG9uJ3QgcmVhbGx5IHdvcnJ5IGFib3V0IGl0LiBJIG1haW5seSBj
YXJlIGFib3V0IHRoZSBWTQ0KPiBzaWRlIG5vdCBjYXVzaW5nIHByb2JsZW1zLCBhbmQgdGhlIGNo
YW5nZXMgb24gdGhhdCBzaWRlIGFsbCBsb29rZWQNCj4gZmluZS4NCg0KVGhhbmtzIQ0K
