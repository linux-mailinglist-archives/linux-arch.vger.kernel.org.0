Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA07748DAA
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jul 2023 21:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbjGETWg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jul 2023 15:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbjGETWV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jul 2023 15:22:21 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8BF49E5;
        Wed,  5 Jul 2023 12:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688584725; x=1720120725;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gmy+XkV3KNoVMQjREYV/x2+5znpTb/dXMUQ5f9/f6LA=;
  b=OA1YHbDG1dnMni9s8ylCYhzjfVZ4kQqd7W59xdjCCMtPOMJkne7aYOkn
   9gibSu6bmlO2CMR4bf0YMuzUIScxoMj1iFseALu/P8zeG4geadVIQ77RO
   /qC2QvXFYVZXEQU28vxSCKAuAxWpPhW62nvZD2KhemxxJuvA4nuJHZh4G
   GNfRZrFuen3Tur17091wnFRQVtu87loeGbifW9tfPX4hVCgrT5h1f+Jzg
   9GRd/QLYBpEJy50BPHM6UHzs4Ag05XgzUJQquwqXtJc2H0vBmlNMU5Gw/
   ieuZ2CtTqvH6A1OYj1kZlrLyrfJIsJkAwO+KD9a8inPYw5ToDGRuxAGqh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="343750819"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="343750819"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 12:17:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="965928563"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="965928563"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 05 Jul 2023 12:17:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 12:17:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 5 Jul 2023 12:17:29 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 5 Jul 2023 12:17:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/syDgizWYTZoO6N0HwOELZlAi5EzFoDy6rqyL0/nwWCB52gbyVT3yEfO2ZOh2xj7wm88wOwv5ATKIb7TXnChaUHoIG+6o8twu49QnLyx06Azbu22CgNaF1ovvHUzpUdvIDFsOz5HN89LQorgPe82DwYOs03wiVxOPUGQvzAXXLyCT2PbafOLzxtD6MkPi2Lu/HO8Qs2z+zT/mG5xGCceIpEd5wPmLGoZ91LFI2I+qI13gepU6qPgVJg7xwmGS+QhU0vO7TwzHp2Gn5S3K42X1F68OUtjv0hvwk/+uCN4xzK5+SjeIbMU/IEir/oWarSvo6helS/lPDEbPHhAWVOUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmy+XkV3KNoVMQjREYV/x2+5znpTb/dXMUQ5f9/f6LA=;
 b=WG1vTszglW+sIoKxahEDzm5YPUuAkLAYnzgPjQUIVSjz0hWaes7PaC/cYvj3/Ng2lJ+OTVd5UA0ANKvpQghCLCvpS6peZEb7TvxoP+poL0UlfSXqS2GA4ykNrmKTv6KDe5HNyVT8+EG+eM03GmdfO4UK/pLlj1/k0gHC2gyS4pwDPfSMNWir8oEnagflN7rLh/GdprJAFEibH1dHv0duewsq24h4+GUZfSlPPB4wllkQ+o6Vvo2dh5JhGNa0nrWS5oRiLkr92ciMT7Sg3hKlgf6iP27/TCGOUKE6aICSxWESwhnIYLWTuUb19A4EVXldswC08RuqU2ql16RT3JciVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB5976.namprd11.prod.outlook.com (2603:10b6:408:17c::13)
 by DM4PR11MB5550.namprd11.prod.outlook.com (2603:10b6:5:38b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 19:17:26 +0000
Received: from LV2PR11MB5976.namprd11.prod.outlook.com
 ([fe80::1a0a:44f8:c653:5b00]) by LV2PR11MB5976.namprd11.prod.outlook.com
 ([fe80::1a0a:44f8:c653:5b00%6]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 19:17:25 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
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
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "jannh@google.com" <jannh@google.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Thread-Topic: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Thread-Index: AQHZnYvD++9jHqJtDEOZ5j0eN4/f+6+IoOQAgAALyMOAACwFgIAAIG6AgAAMtoCAACGsAIAA96CAgABofQCAB1K5gIAAhUGAgAEVRoCAAKx+AIABDK+AgAB6bICAAPF/AIAAZrmAgAAVNICAAG62AIAKh/oAgATXZwCAAZabAIADLBsAgAAG/ACAAAHjgA==
Date:   Wed, 5 Jul 2023 19:17:25 +0000
Message-ID: <0a9ade13b989ea881fd43fabbe5de1d248cf4218.camel@intel.com>
References: <eda8b2c4b2471529954aadbe04592da1ddae906d.camel@intel.com>
         <2a30ac58-d970-45c3-87d2-55396c0a83f9@sirena.org.uk>
In-Reply-To: <2a30ac58-d970-45c3-87d2-55396c0a83f9@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB5976:EE_|DM4PR11MB5550:EE_
x-ms-office365-filtering-correlation-id: 5abbfa8e-c573-4d35-dd68-08db7d8c773d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gGiV6t2w/l1NMTWEpEUw2r6NyblvNXQARPHdZctc6uIUpIUmctQTRmnHMVk6594WfwC57ER+nqahQoCx9RHTFSG2TkQpBKBn4fj2aCerWuAk9+QYuNt1GQxb6cwU81Sd4Z6oyI+j8tcMy0/obnLQR0vJhZSNSWcV6ZsqxxOthNrqtfnHbhvzAjlsSfnwbpSGZzNCprVuLTyoPZUDMpShPp1QfCAPnCo3mIBhV9iu8bLRNPJdSQcJEQm9jbjptKZNvo+g1lZZ9Lp3MsZvbLtT6g4MwA2fk8QiIvuYr8sHvDZ5iOWuXM3gtWYI1XLhGrOhGi3Ri/IRWDPC2T4VS9kl0VojrUCaGX+O+98luTM9YNuQSkNtDupZl1lyybWU2khTy6Qn4MowPTwtxo7YnJE7+iveipgIkosp+SPCX3kOvoLJi9wfv6YGzrS4e5oD04V2oqACueRA9htKrCSTQUD6wSsfCbqgxSzN/8aAYFd0UgVkwxZbJqEAOxFdzrRB7fuVGxy+8Z+D+8SXTdS6uSeXiRtwTi99emjhMVY/IJ4xmLu3yasy23ZxllQm8n+Vv8Y4GNCn5Qd+z4/nD60Af7URZzkqi9PBB2/maI0EgrCGBqQsvZjnhFtLksdiyyR3Yr61
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB5976.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199021)(36756003)(7416002)(38070700005)(86362001)(2906002)(7406005)(5660300002)(6512007)(186003)(83380400001)(6506007)(26005)(91956017)(6486002)(122000001)(82960400001)(54906003)(66556008)(66446008)(6916009)(4326008)(66476007)(2616005)(38100700002)(76116006)(66946007)(64756008)(316002)(8676002)(478600001)(71200400001)(8936002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UU5xMU9xWE9pY3NSM0JQWmdmOStjUDEyWU50Rkp6c2daT0YyeUxKK1VrU0ty?=
 =?utf-8?B?Y2EwTHpGTWZtZEJOeExoa1VPaE5JcHBsQ2pxSHp4NE9BU3FpTlBDK2trVVJk?=
 =?utf-8?B?RjNwM1RwV0szZU1acVFpbk5UTUVVY1JzOFh0RE5GcGRGQXk4eFduVVVUSmZW?=
 =?utf-8?B?bU44NDJEUE9aVEQyN0hEL0hnYzV3Z1JJZTJ0V1p2L3doQWE1V1dXOE1KdTJN?=
 =?utf-8?B?dFIyL3ZzcE83UFpwYklCdkxwbWR0am9DeFpZN3c2cHNZbHJ5RUN1bUREbEFh?=
 =?utf-8?B?Tm9pUEVNUHBpUGplYVZITm45NDlSZW9GZkFRc3daYjVQS0dQTGJQNmlsOWNl?=
 =?utf-8?B?UlB6SDE0R204QmVNeVcvYXBNeXIrK1VqSW1KSFRyQnkxNU10WnZKOUc0dUdZ?=
 =?utf-8?B?SExtOGQ4VnlDakxOSGZoZnNjSTJNZkpWNG5ZNCtTdWNVTGJHazdPdmtQMFlU?=
 =?utf-8?B?N3A3bEd5Wk8weHRxN2l6cVYyaHVjVllIa1RBNHBhVmMySlc1Tml4NktZOWVL?=
 =?utf-8?B?UWtSaEdreXk2QTlnbUVyY0wxeXJsRDVLRThVcXkwdTdsV1c2T21MbnpkcUhB?=
 =?utf-8?B?c3BCaEV1UDRmMDFyS1A0Y1FnaDRjNjJtK3gyTlR2TVJRRU9GQlU0SHVSMkNl?=
 =?utf-8?B?Vm5NckVHUFM1dEVzaE44Qk1wY1hjc041U0ZTUmpTR3k3RU5EbDFZa0dyMWNr?=
 =?utf-8?B?NzdHc1M0SUg2SE9ka0xLL2I2RVdNWlVjMEpQMlhHWWU3Mi9BTERIVEVOL05Q?=
 =?utf-8?B?Qk1MQXFkeDNzQllORHN4aytBa0JyMDA2S3JDVFM1Y1BoTitGV2R3WVRVTlND?=
 =?utf-8?B?M2lwVndFdVVOM3I2MUpmZ2NlSmM4VElESkYzUEgzNjNqaDdMVjJGZTRLNWgy?=
 =?utf-8?B?T0RCV244Vk1HY3FjMVdabmhqMndLQWVKUzllNjl1eUlBWEloMk5Vc1RvNGsy?=
 =?utf-8?B?UEdQSkxWKzFsREZaSEN6TGo3ZkJxYjNXV1llQVpwM2xLWFFjTmhXb01QQjY1?=
 =?utf-8?B?OVErYTAzZGdtckdJNE9iZWxNSHNqRUlkaW9ZZ3dmV0pNcjRYUXNBOHF6d1Nn?=
 =?utf-8?B?NFJSYWhZZWgyM0NUY2JkY09LVDJ1MlpnRU5seW00K1hVc1NGQjJueUlRY092?=
 =?utf-8?B?bURScWgveTNCM3R0M1JtOVpjOXc4TmFCN21lOEcwQUZTMTBpMStiUnliQnB3?=
 =?utf-8?B?WGdoUXRjTnovZkxqWlZMNkhoMWFIN3N2MlYzSnpXY0hxQ3hIMXdIelVCL3I1?=
 =?utf-8?B?R2MwMWdab0xUSm9WQk1oa0tjeS81TUphdEJ6Y1lVeWdzbW5LczNncTFHY0hU?=
 =?utf-8?B?emgyMTBSbkxCelZzOHR3L091d0pNWmYvaUNmNWszL1hubEorVk11YTJDMTg1?=
 =?utf-8?B?UjhqRm1xOWpzQkd5a2IwaHZETXZ1eXdTNkVpZVNFTzlCWHhVdlc5VFRQajBx?=
 =?utf-8?B?WjJZNU5NRW9rU2FqSndIa21BazhRUWlsZElKN0pyMXU4VURVVU5leEsvVENT?=
 =?utf-8?B?R2RYQU5mY1U5c1ZRVjcyTGFXWnk4ZlpCMkRYS0hnVGJlVGlmVktONVNjcDFH?=
 =?utf-8?B?bTlzdnlEYTFUbVFJcU9mbkhqRE10NlpWTkV5RmIxeG50ZFpQRW5xOUk0MTNF?=
 =?utf-8?B?eEhFemNmZHVGeFl5VlBFeUdYWHFoL3RkUzhJaWZPUnZZb3h5WUs3ZzE3Tnlp?=
 =?utf-8?B?VFNYSlNlZlljMERLRjJjZ2dWL055clBRdElqaktoNGtQU25seGFvOEJ0ZGEx?=
 =?utf-8?B?SmVpd0JlQlhIdEl3UktyMGY5V3Q1Z2xHSG13YVo2aUNJaGx6dUpKV3p3UHg1?=
 =?utf-8?B?NWk5cnZ1cEVtaUZGN3Jtcm8xN0pud2NrOWVtK2J0V3VOZ0sxaStGdUVsQ0JJ?=
 =?utf-8?B?YVhXS3VSdExqMnMzUGFYOEsveU9odlhBQjF2d3p6R0tkcE9XcUFIWFZTUC96?=
 =?utf-8?B?OGoxVVNHT0psMnRBNXYzUm9jUk5CbGJuRVoyMjdFcExoeGVZRjZuMnBJbzAr?=
 =?utf-8?B?RitIVEN5akgxdnhlZ0lsQ09jbVY0aEtMTFFZSm5BK3JMN0Fod2NscHdOZXFx?=
 =?utf-8?B?QjVGS2ljb0pUYnNYRmhteGxrMFlBVzFCd1FHcVJmUVczTTE1bkV4MnJyUThl?=
 =?utf-8?B?cjB5VHJ2MXpSeDhENnhYY1VzU3M3SEJldlVBYWozQ2pZbXlsUjRLNVpCRllF?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4A617831C0EB34C87200233B7AA5FFB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB5976.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abbfa8e-c573-4d35-dd68-08db7d8c773d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 19:17:25.2194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IK3EtRaYWh5I1NdnjGPO3NS/qFxr20qAyyZtNbolFaljRenXOkuUuPTTef0zMtQiFqZjHdHp/Hrh8HjD+WeT6IHAUUn7Y6p5th+D8H8ousU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5550
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gV2VkLCAyMDIzLTA3LTA1IGF0IDIwOjEwICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBXZWQsIEp1bCAwNSwgMjAyMyBhdCAwNjo0NTozOFBNICswMDAwLCBFZGdlY29tYmUsIFJpY2sg
UCB3cm90ZToNCj4gDQo+ID4gTG9va2luZyBhdCB0aGUgZG9jcyBNYXJrIGxpbmtlZCAodGhhbmtz
ISksIEFSTSBoYXMgZ2VuZXJpYyBHQ1MgUFVTSA0KPiA+IGFuZA0KPiA+IFBPUCBzaGFkb3cgc3Rh
Y2sgaW5zdHJ1Y3Rpb25zPyBDYW4gQVJNIGp1c3QgcHVzaCBhIHJlc3RvcmUgdG9rZW4gYXQNCj4g
PiBzZXRqbXAgdGltZSwgbGlrZSBJIHdhcyB0cnlpbmcgdG8gZmlndXJlIG91dCBlYXJsaWVyIHdp
dGggYSBwdXNoDQo+ID4gdG9rZW4NCj4gPiBhcmNoX3ByY3RsPyBJdCB3b3VsZCBiZSBnb29kIHRv
IHVuZGVyc3RhbmQgaG93IEFSTSBpcyBnb2luZyB0bw0KPiA+IGltcGxlbWVudCB0aGlzIHdpdGgg
dGhlc2UgZGlmZmVyZW5jZXMgaW4gd2hhdCBpcyBhbGxvd2VkIGJ5IHRoZSBIVy4NCj4gDQo+ID4g
SWYgdGhlcmUgYXJlIGRpZmZlcmVuY2VzIGluIGhvdyBsb2NrZWQgZG93bi9mdW5jdGlvbmFsIHRo
ZSBoYXJkd2FyZQ0KPiA+IGltcGxlbWVudGF0aW9ucyBhcmUsIGFuZCBpZiB3ZSB3YW50IHRvIGhh
dmUgc29tZSB1bmlmaWVkIHNldCBvZg0KPiA+IHJ1bGVzDQo+ID4gZm9yIGFwcHMsIHRoZXJlIHdp
bGwgbmVlZCB0byBzb21lIGdpdmUgYW5kIHRha2UuIFRoZSB4ODYgYXBwcm9hY2gNCj4gPiB3YXMN
Cj4gPiBtb3N0bHkgdG8gbm90IHN1cHBvcnQgYWxsIGJlaGF2aW9ycyBhbmQgYXNrIGFwcHMgdG8g
ZWl0aGVyIGNoYW5nZQ0KPiA+IG9yDQo+ID4gbm90IGVuYWJsZSBzaGFkb3cgc3RhY2tzLiBXZSBk
b24ndCB3YW50IG9uZSBhcmNoaXRlY3R1cmUgdG8gaGF2ZSB0bw0KPiA+IGRvDQo+ID4gYSBidW5j
aCBvZiBzdHJhbmdlIHRoaW5ncywgYnV0IHdlIGFsc28gZG9uJ3Qgd2FudCBvbmUgdG8gbG9zZSBz
b21lDQo+ID4ga2V5DQo+ID4gZW5kIHVzZXIgdmFsdWUuDQo+IA0KPiBHQ1MgaXMgYWxsIG9yIG5v
dGhpbmcsIGVpdGhlciB0aGUgaGFyZHdhcmUgc3VwcG9ydHMgR0NTIG9yIGl0DQo+IGRvZXNuJ3Qu
DQo+IFRoZXJlIGFyZSBmaW5lciBncmFpbmVkIGh5cGVydmlzb3IgdHJhcHMgKHNlZSBIRkd4VFJf
RUwyIGluIHRoZQ0KPiBzeXN0ZW0NCj4gcmVnaXN0ZXJzKSBidXQgdGhleSBhcmVuJ3QgaW50ZW5k
ZWQgdG8gYmUgdXNlZCB0byBkaXNhYmxlIHBhcnRpYWwNCj4gZnVuY3Rpb25hbGl0eSBhbmQgdGhl
cmUncyBhIHN0cm9uZyBjaGFuY2Ugd2UnZCBqdXN0IGRpc2FibGUgdGhlDQo+IGZlYXR1cmUNCj4g
aW4gdGhlIGZhY2Ugb2Ygc3VjaCB1c2FnZS7CoCBUaGUga2VybmVsIGRvZXMgaGF2ZSB0aGUgb3B0
aW9uIHRvDQo+IGNvbnRyb2wNCj4gd2hpY2ggZnVuY3Rpb25hbGl0eSBpcyBleHBvc2VkIHRvIHVz
ZXJzcGFjZSwgaW4gcGFydGljdWxhciB3ZSBoYXZlDQo+IHNlcGFyYXRlIGNvbnRyb2xzIGZvciB1
c2Ugb2YgdGhlIEdDUywgdGhlIHB1c2gvcG9wIGluc3RydWN0aW9ucyBhbmQNCj4gdGhlDQo+IHN0
b3JlIGluc3RydWN0aW9ucyAoc2ltaWxhcmx5IHRvIHRoZSBjb250cm9sIHg4NiBoYXMgZm9yIFdS
U1MpLg0KPiBTaW1pbGFybHkgdG8gdGhlIGhhbmRsaW5nIG9mIFdSU1MgaW4geW91ciBzZXJpZXMg
bXkgcGF0Y2hlcyBhbGxvdw0KPiB1c2Vyc3BhY2UgdG8gY2hvb3NlIHdoaWNoIG9mIHRoZXNlIGZl
YXR1cmVzIGFyZSBlbmFibGVkLg0KDQpBaCwgaW50ZXJlc3RpbmcsIHRoYW5rcyBmb3IgdGhlIGV4
dHJhIGluZm8uIFNvIHdoaWNoIGZlYXR1cmVzIGlzIGdsaWJjDQpwbGFubmluZyB0byB1c2U/IChw
cm9iYWJseSBtb3JlIG9mIGEgcXVlc3Rpb24gZm9yIFN6YWJvbGNzKS4gQXJlIHB1c2gNCmFuZCBw
b3AgY29udHJvbGxhYmxlIHNlcGFyYXRlbHk/DQo=
