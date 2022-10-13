Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B345FD21A
	for <lists+linux-arch@lfdr.de>; Thu, 13 Oct 2022 03:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiJMBCJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Oct 2022 21:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbiJMBBw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Oct 2022 21:01:52 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A3CDFBB;
        Wed, 12 Oct 2022 17:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665622718; x=1697158718;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LbhMj9BjFiUT2tNOw9SYaWasQFSKcWGpqmUWT6vOhdE=;
  b=URtXYSZoZ8GVMrPxnPGyESqLkx7+VcRNmLa1gQdwRgsaRPd+FWhkodwZ
   +OLwV+mUd3Lww7ObSxTAKh9dFmc6G5C4vuTjSH9MGdwaMzKjuo4Qrrklc
   myQt/wmUctDvqJn+0Z2Oux5Whqc6C+6ng+xuotWBCuObthTJXzGkBaZ+m
   Sms+tWA8yqwm/lhbu+UzizMGmZkAMmshIX60oRpGJ7fma/Gu+3Bn0yB7f
   JGiV4ZjqyWYgi3QCSIc5Xoov17sASnal/oVdf+gOkVV16sg5WvDLKzZwQ
   vSjU5sWlhBAvymy/QsAcGt3R4EhX/70EwI9gErxK3n6urXNZl8f5NaWq+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="391247735"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="391247735"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 17:31:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="626964154"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="626964154"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 12 Oct 2022 17:31:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 12 Oct 2022 17:31:40 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 12 Oct 2022 17:31:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 12 Oct 2022 17:31:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YV9QV8ZP9qEaMrwCxQvLSwCURmz+sTH1k/yuCxaUeB4ZYJPuDPt0MerlxY35CwyZynpmK3FFNibElennepZ6OAERbHha177AE0HNZ5jfsSXfyG0e7nTH8YJUg0hYzdw/8bPw2V9o80it0mHDhZ8WDjHRbeCqCKKm9f395majKnpCiT10aYNu/6xFtWDuHVth7StgA1Fqjjc6mu8/+MBhkrRdEThUF2NccpMJpVFlw4CTDTvGcExef78xNLEjHNCaDy9lrzN2Z3vha2uGLRRW+9AVNl5VgCdvPhTIlaH3u46AWtatk5W0hkXXfZ5OcyDOyMdEXm5lfRTdpgKlc4JrgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbhMj9BjFiUT2tNOw9SYaWasQFSKcWGpqmUWT6vOhdE=;
 b=JftkirETt+fJ+a7lNm7KwNrGeY1oEQ4bZ7GrhKffhP+Sp6KqXq0QMUOfUvZdto/ZQcIl02N7T+GEcI04d7N2KAKWn5meApBf0NstHILEwSBu4ISsgyZLSdSYTcyGPu6d7Jk+XVPr+xsPjX6YCvYrZOOF0bW1ktp3AKzeijNJa6WU+M86ivPQwNU0rkWNkcwkuy3s9vakjz9pOxSBc2foVTiibxmtFHiXq5EoRA7PC9uJLOpisfOcm5/bYr/OLHioXSIng7Wek8ZzTnCFvYucsC7rTFtun/xmrkF1uknrFvPIIZ9MZkhghXK0cUBpNoZ40tf3vm7zQykSAW85rY50Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BL1PR11MB5431.namprd11.prod.outlook.com (2603:10b6:208:315::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Thu, 13 Oct
 2022 00:31:38 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5709.021; Thu, 13 Oct 2022
 00:31:38 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
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
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v2 02/39] x86/cet/shstk: Add Kconfig option for Shadow
 Stack
Thread-Topic: [PATCH v2 02/39] x86/cet/shstk: Add Kconfig option for Shadow
 Stack
Thread-Index: AQHY1FMAO2++jn8eSkiiPpemqAqzVa4LQuwAgABKvIA=
Date:   Thu, 13 Oct 2022 00:31:38 +0000
Message-ID: <d2cb7f4d97d05036608c8b4324de17df2e2acfa7.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-3-rick.p.edgecombe@intel.com>
         <Y0cduNYq/ml6vtxB@zn.tnic>
In-Reply-To: <Y0cduNYq/ml6vtxB@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|BL1PR11MB5431:EE_
x-ms-office365-filtering-correlation-id: 19fc2c4b-60b8-4535-fcb6-08daacb24a97
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JyKxNhRe4pg7zkFs9/Ypun8yKYVDbbxQRRmBtuTpppU73brpjTUmJjtqxRC5ghMi0xLfA45+Zl5CE+eurgzJwmNRX6foHGeL5OAAmZliRX8eMHtETzSh163LRxE6Nzr9gKFsOx7hrkznZ4RPIXqtkWlzdeEbUTLxX3TeY2Fs7+AmZvmytLvkLR9JmklBpXHIVuMAcGdhq6xpwNAS0uZEe70WvOy/yOvT6gTf2JGyZuXSbiR7CIU0B5ZiT3DEcmK80N8H8tKODCq2zhPLY/Gy4ZXvU7G+9MeL+B1hKWmNPTjSQVG/dCxE+T/DAGFasnJaJxe59Pu34c7U0XJBgFTZh6r7qYV67HsiH4TX42L4FVqmbxPkVMscotMUgYL/0VyafZS/KfPWFM1YlTVSj9oc/Ca+q8feY2dsZ9j3JtwGTaIu9ZwNxU1V8VuQqWIif6+4w/l+iiEHwj2dNdTEf048NB9sliC9EYBrglrs7o24THoxyLp9vkZVys/6jv3f7A/n+UfBfmSYcZUenk2GfL6/0b8ZAmDRK1CsHjaYv8Hp4NZNcOPuuGlQBMTaXZrwaK+2IhCsxCLv4g03cojnSzaiPNL4oURGP/U+1pDBLy8d+8S3J0ERk9CAYt/aX7dPCvx8+rIcc83pJ6NXcKsMBsmXZuaIbdzFF0EHBo8oWPg80ecYlly+nZmB4GpVI8MtTrz2p9grAckr6sOoC0c5/CRnPtvgaP8jfe1bJrQgLIXNafYw3s72Ff8yVT03WVeMy1gfzF5SmJl+kih34JZCbpMeUcbTwEp58uAt9dWeZ/rY/z0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199015)(86362001)(36756003)(38100700002)(7416002)(7406005)(5660300002)(82960400001)(4001150100001)(186003)(122000001)(2616005)(38070700005)(6506007)(316002)(71200400001)(8676002)(26005)(91956017)(64756008)(6512007)(54906003)(6916009)(6486002)(76116006)(66946007)(66556008)(66476007)(66446008)(478600001)(2906002)(8936002)(4326008)(41300700001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MW15L3E4YUhuU1JaTk5LNWhTNzJLV05oS2E0TElLTk40RkhxdHB1UlRHdEdP?=
 =?utf-8?B?MW9ldFhHaDF6ZTh0UGc2UFFhSHptbDZrLytWVUhVa1R5c3NqZ09FakFGLzZZ?=
 =?utf-8?B?WVR4UkZWWnJKOWhqM1BjUWdheFFnb2NRbU9jcWIyZGMwNGIzRmp0bmJ0K25s?=
 =?utf-8?B?SUMwK1k5bXByZTZaT0tjcS9ma0piTXBZUzZ2UENRQUc4K1R0NGZsUDV3a1JR?=
 =?utf-8?B?UUNwOHhuQThDZnNEZldQMzRLTEkrSUZDN1ZXcUkyblFHS21MMkRyL2VKclVF?=
 =?utf-8?B?R3M5TXFESFU3dCtWR3F2N3NrSHdBMDVSTUxXSnZTU2VERXlVcXJJT1V0M2FN?=
 =?utf-8?B?S056RHRLZVh4UW9iTHdHR2o4TGdGZ3FPYTJ0ZWtBTDBVQWlKQVMzMWNNYkxj?=
 =?utf-8?B?dVd4Q0Y0OEg2WmZGQndsK2JJVGpnZVNUcENqL2RIbWt0M3dOaW9OYUhmMGta?=
 =?utf-8?B?SFRnUTZLS1pnZkFqYmk2K3o5YjBWTGZCRXR0SlIyaGZZWWxvdTJhclMwWmUv?=
 =?utf-8?B?YnJUSWIvQ2J6aW1HcGdONkE4cnJpQU5xa3BOU0lNQ3pDbEhiS3NPODNMQU8r?=
 =?utf-8?B?eHZBaWhVYkdEZDA4UTJoaERibVVnRzkyNCs3cEs0aHdGZFQ4aXNpREFVVGZx?=
 =?utf-8?B?aGNQa0Z3d0xDTkg5ODZGVnNlWkxnVzRXQit2TjArdUlvVjVEVU1IelcyeUxk?=
 =?utf-8?B?N2pROGdGQnM1WXdhRlNsMFJNVnQydVFBRmxGWk9EN3l5TVdzWExLMXU0SEZP?=
 =?utf-8?B?ZW1ZSkFtRE1VRUVtVUNvSEtqU3NmZzdPa0RxYjFQc2FuaFA5VWhHaGFTN0No?=
 =?utf-8?B?bmhUZk13WHgzYXVHcGhQMVk2eUhNQUtmYkkxY0tBYnZOc2hETTVqNTBha3pM?=
 =?utf-8?B?aFQ0dDNZVGlpdWpYSmc5bU01OVJKTW1XeVhLcWZwdnBvNk9KSEJzUVFVZUIw?=
 =?utf-8?B?VGNzYXdBdWMwMms0REVNZ1UrTUZtcXN2T1hrME45QUdIdU5URytsYkUySGpw?=
 =?utf-8?B?RCtQVWRqUmlsY2J3QVBRMUJLNGk5NWNlMStxdUFQSGh5aUF0Q2N0V3RIUDMw?=
 =?utf-8?B?dHlydE1MbnZUcEZlS3I1RkZPVUNJRWw5dkdWTmxwV2V6djIvdW5PV0pQUGdR?=
 =?utf-8?B?UitZVmNnQjJwbEZaS0U2MlJGVWhoNGZWanZwbHk5OEV0a3ZXaDhyZ3hZUjNs?=
 =?utf-8?B?WXkxWXFEOGVnRzVWcHlhREZFOWVjdjN2TFp2SUNoS3A4VlBZLzcvejUvSkh6?=
 =?utf-8?B?ajZCek1zZzJyMzdpMFJGTDU4RGEzV1ZlaElUVmxLQjBGc1dTTk5pMlpGU3h5?=
 =?utf-8?B?WkV2cVJYdUxUKzkwUDlSSExZRWpBSFJUVnU3YkFLaUxtTTJhL0dsYnkvUUpV?=
 =?utf-8?B?U3dzMkUyRDNQTXJkVmpMb29ZTVZsZjZFRmZvOVpFM2ZYWlZQMmNSbm1TWkV0?=
 =?utf-8?B?TkYwZDFWRDJOZVVLd3A3Q2k4dDdHMGlmY3lONkw1TlVnZzVXdzc4UGdmN1J6?=
 =?utf-8?B?d3dudGhkNmJYZ212QXhFQjN6akUwVlEvTk11MVZ0ZXR1OEtPdnJtam11c0hZ?=
 =?utf-8?B?VnROMyt6VjN2Ykp4dDBXUWVDdjE0Q244RFRveU52NVlVTW5iUzNVSXY1ZE1m?=
 =?utf-8?B?YXZ5blhNamhKYVdQWHRQeE1BN2xJMCsrMHBYWEgrQVlRVElGQkpldjF1dkhL?=
 =?utf-8?B?cEpXRktWZXhJSDV5cjQ3S0l2VnRhUWFPV0IwS0pUWm40RzVlL3lVYU1sOFI5?=
 =?utf-8?B?UmphMzVzblhrdEdvbEtuUUVoUWdEN0JPeHJld21mVVVnS0cvZGRzZ0U1UDNI?=
 =?utf-8?B?RHo5VUlkdXFpaTFtQmExcS9VWnNHdFluZW51REN6bWkyWlVPdERMNmlkM3da?=
 =?utf-8?B?RzFQdTEyTWNPQXBkK1I0QUtmZGg3WUhhT2piZmhrSGRvSmpUL1Y4blhTNEdT?=
 =?utf-8?B?T0h0MVBxS3BNYU5YTC9LU051VENQclNSYzI3VFBCT2Z2MGtzUkFmdzRGMEp6?=
 =?utf-8?B?dFliWEhKd2p3OW1MM1NaSVUyWSszVitrK00rbjEraXRJYTJUVmYrVmdjV2ls?=
 =?utf-8?B?V01XRFhsVTI3TXp6RXdGWXJIS3c4U0lQRSt2dmdXQzBEWHNRNlJqNW9kODZz?=
 =?utf-8?B?eGZKYUtSVXB2ZVNsRTd0Q0dFV2JJbkNKNHpiczZBNWlsZWNnWEpQT2VvSkxp?=
 =?utf-8?Q?495K9xy/Df9zhPzFRUOTirw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <51B7BF74FDFED9419515645F77E616E2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19fc2c4b-60b8-4535-fcb6-08daacb24a97
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2022 00:31:38.1664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5xpfO1KveFvdYbzAAW+A57CgSH+j4k/OG7IyblvSqfzTgC6dqSWVV4P1mpzq+v4LkYnnWZBDsoSo4ds6BV2UIbHuJuMFrlWInbXzDHWhUbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5431
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gV2VkLCAyMDIyLTEwLTEyIGF0IDIyOjA0ICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFRodSwgU2VwIDI5LCAyMDIyIGF0IDAzOjI4OjU5UE0gLTA3MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+IEZyb206IFl1LWNoZW5nIFl1IDx5dS1jaGVuZy55dUBpbnRlbC5jb20+
DQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwMi8zOV0geDg2L2NldC9zaHN0azogQWRkIEtj
b25maWcgb3B0aW9uIGZvcg0KPiA+IFNoYWRvdyBTdGFjaw0KPiANCj4gUGxlYXNlIHJlbW92ZSBh
bGwgIkNFVCIsICJjZXQiLCBldGMgc3RyaW5ncyBmcm9tIHRoZSB0ZXh0IGFzIHRoYXQgaXMNCj4g
Y29uZnVzaW5nLiBXZSBzaG91bGQgdXNlIGVpdGhlciBzaGFkb3cgc3RhY2sgb3IgSUJUIGFuZCBu
b3QgQ0VULg0KDQpHb29kIHBvaW50LCBJJ2xsIHJlbW92ZSBpdC4gVGhhbmtzLg0KDQo+IA0KPiA+
ICtjb25maWcgQVJDSF9IQVNfU0hBRE9XX1NUQUNLDQo+IA0KPiBEbyBJIHNlZSBpdCBjb3JyZWN0
bHkgdGhhdCB0aGlzIHRoaW5nIGlzIG5lZWRlZCBvbmx5IG9uY2UgaW4NCj4gc2hvd19zbWFwX3Zt
YV9mbGFncygpPw0KPiANCj4gSWYgc28sIGNhbiB3ZSBkbyBhIGFyY2hfc2hvd19zbWFwX3ZtYV9m
bGFncygpLCBjYWxsIGl0IGF0IHRoZSBlbmQgb2YNCj4gZm9ybWVyIGZ1bmN0aW9uIGFuZCBhdm9p
ZCBhZGRpbmcgeWV0IGFub3RoZXIgS2NvbmZpZyBzeW1ib2w/DQoNClllYSwgSSB3YXMgdGhpbmtp
bmcgdG8gbWF5YmUganVzdCBjaGFuZ2UgaXQgdG8NCkNPTkZJR19YODZfVVNFUl9TSEFET1dfU1RB
Q0sgaW4gc2hvd19zbWFwX3ZtYV9mbGFncygpLiBJbiB0aGF0IGZ1bmN0aW9uDQp0aGVyZSBpcyBh
bHJlYWR5IENPTkZJR19BUk02NF9CVEkgYW5kIENPTkZJR19BUk02NF9NVEUuDQoNCkknbSBub3Qg
c3VyZSBpZiB0aGVyZSBpcyBhbnkgYXZlcnNpb24gdG8gaGF2aW5nIGFyY2ggQ09ORklHcyBpbiBj
b3JlDQpjb2RlLCBidXQgaXQncyBraW5kIG9mIG5pY2UgdG8gaGF2ZSBhbGwgb2YgdGhlIHBvdGVu
dGlhbGx5IGNvbmZsaWN0aW5nDQpzdHJpbmdzIGluIG9uY2UgcGxhY2UuDQo=
