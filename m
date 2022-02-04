Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FE04AA11D
	for <lists+linux-arch@lfdr.de>; Fri,  4 Feb 2022 21:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbiBDUXs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Feb 2022 15:23:48 -0500
Received: from mga11.intel.com ([192.55.52.93]:1152 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234839AbiBDUXr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Feb 2022 15:23:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644006227; x=1675542227;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=QIPPcXzKkvEnfpBcMxFCA/2tacrqSLTq03bWOeE5z1Y=;
  b=fkqqoxWmjC6raeDgpPzC/Jxo8Ckp7VbsX9Uo/w/pTB0/1aDdz8jqIDZk
   GAbD2r06gCEkQyhxZCm7Ppe2WgoH2ZrHzvcWwfBbqW+5Y88Xn7v2MPbF6
   vX1D/s2cA3E5QY0efH5BxI+/P+tVvHDpxCJNMS0tlvUzD0zhmJ+aXfeRP
   eTiMgooksQg7wmkF+j9DFZlT8YnGfD3bmcSt6TPN23Oo99UfXchP3iG+H
   6AOVrxZO7SwPiuPvGruqq9k52pLsIxj9zl1DhI31R+7x2qlWwUGd/BrsL
   1i3TLZRzRvlHkQIs7hKeSXPC5wGOoKj7IgZznoMSbmR0gBgxd6UNLD+wr
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="246025716"
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="246025716"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 12:23:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="524430263"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga007.jf.intel.com with ESMTP; 04 Feb 2022 12:23:44 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 4 Feb 2022 12:23:44 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 4 Feb 2022 12:23:43 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 4 Feb 2022 12:23:43 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 4 Feb 2022 12:23:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6rbAcOAb1VTFQx1DabCUROP2cX8iJSiCOuP0WhF1zKEslWicjMeCkAoSXkdSQc2rOKf+sUI0ikwZRk0ysnGLrqbkjapmv3RhE/AVxtd0e5caZe6+aImojIoBx8V89D34AIWlyosbnanVH2x4L16Vvh/0EsiRGDo48mRyEdCataQCMs8IXwkmEg/WarKRPgVpz2TLmuJH6H5nAP+dMQ2zYmkjMC2TzEPXRLTiCP3QZUR0plKVZHsDd9eku2c7av57EWFN1tftt9H/hi3qX5cXy+QCMLo5zLyJ/Cx5AMY7YCZksdqhMAHJqnFnFbnzQEK44lio2ZsN/XToBEtGYdQoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIPPcXzKkvEnfpBcMxFCA/2tacrqSLTq03bWOeE5z1Y=;
 b=Z0cpWMMAyuAAmqRv92zMER0w8gSuZyHttA6TgyTMR+gLZe8At5HXww/4D+zDCW5GAioLUYVYU41jMTntf6a16+sqnv3iJ4tJ03q3tZ/Q6amfdyMECfB3AYi3a2qGHhHf1lcXdx5XxKYLPf5+kMLoVO2F6iI7B20ITNJ+4hH2PfcLLiHuYPCoVfy7dJ4GgUt9AH3ftWJpFFJc92ld99WUeh7eN5VHgc2mYoLcKAjv7UmcDnDDd2pRDOjLbOYOtKf/o4oLZ4KA1n5DUfXRuczSX9NwIOIIkx5ujMM+ygtgZSnddVFb0Ss//j4nTA3Ap1lCK0IKRH+e5sSCAXu4hVP9yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CH2PR11MB4488.namprd11.prod.outlook.com (2603:10b6:610:4a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Fri, 4 Feb
 2022 20:23:39 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15%4]) with mapi id 15.20.4951.016; Fri, 4 Feb 2022
 20:23:39 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
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
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
Thread-Topic: [PATCH 00/35] Shadow stacks for userspace
Thread-Index: AQHYFh9orVaVUe6rNECZu4edjJzhZqyCV/wAgABDLwCAAEZSgIAA/HKA
Date:   Fri, 4 Feb 2022 20:23:38 +0000
Message-ID: <e83cf0ff1834bcfc7436d9370ae2807e5a026f32.camel@intel.com>
References: <87fsozek0j.ffs@tglx>
         <a7e59ae16e0e05579b087caf4045e42b174e2167.camel@intel.com>
         <6b04d8cb-844e-42a5-9ea2-db0e8eafaa19@www.fastmail.com>
In-Reply-To: <6b04d8cb-844e-42a5-9ea2-db0e8eafaa19@www.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50427d4a-689b-493e-c07b-08d9e81c3ac1
x-ms-traffictypediagnostic: CH2PR11MB4488:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CH2PR11MB44886ABB476EE2E0E8BC040BC9299@CH2PR11MB4488.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MoEME0luwHShrKxGTb/VrvnZ7akl6dpAXIsWtRaU6xX5VkIsYHJWSs9x8vxUHidYUwglwY2rOpIc2GeqIFJ7tZNolWZoNuAGX/Ni88ncN7LJC/uVxr6MYgC+hqO6coJN/lnvcUTo7WySkEMeF7VONBAYZicqXd1zqHsLyMthwo+C4jCcfGi9/JGiuSIhgonlMDgnRzoGTGs/FtHYnlRs1wMhD2nyHluoesX40gzuDi4B8UoQnVX3Hti0VqXEUV9sC7uMtwuhjt/yi9gKxaFLBg6DSXxPmDNXhzNbabxIy+zaO4GfhxVVLeM1Z4UfXSsc7OEq04mfm475/Ai7/7pn0ol9PXn3Ag8jN8qHCOkF65Tp7i2nYArY1XOyzMfTcJHfz+yptTlH+WWXfJClgEhMoXhAcHl6dsFpziR1sLCQRYIro9/IV22g5qTQCjDf17CQKK0su/XbSepNwuTfw5AtmBSqRXQsFo8l6nu9iAQViwFodJRwoBxFWS5UFXZuQglBWjYda/8R84P/OximGV2F1a0cibOc9oYvBWFnbjm1PFdULqOot8e69k3ypkI+w2Gww69pIWYnOZtA/1DPtrpKAhGhtbS5VdA11v8qzx0OMGMXTpBkd/68L4SCyemROMfQGm1umWc7bk6ajvu1vDIe6zLZOzTNR3EPXcVh5b9ORMZQ5bamDtk5u+ER418AOvVh6EfvAA/VTxx5KcR34pFcux1xUFqRREDqOjZ+nYWLW8phkjiguAfbg2M8J2xNP9YAs62xKXtsqkE4v8sKnLFzm5fbDQFuuIp2IexIC8Qj6X84i6/qmcsQh2ZBXbjMN8g9Nh5zUsLDdLAJTDChosdUJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(316002)(38100700002)(921005)(76116006)(82960400001)(71200400001)(122000001)(6512007)(2616005)(6506007)(186003)(5660300002)(110136005)(26005)(6486002)(83380400001)(966005)(508600001)(66946007)(7416002)(86362001)(7406005)(2906002)(36756003)(8936002)(8676002)(38070700005)(66446008)(64756008)(66556008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEFCRCttSzNSQldWcFUrdFpsZHcra2w5RzZUcmN5RnozVjBacU5CTVRvZzE1?=
 =?utf-8?B?MWhNVUwwd09iUytETGhLQmxhVFlsSnRtcmxrUFNNemVRdWliVFVHQXJBK0Q4?=
 =?utf-8?B?WUVzd3BLM2RsVVliaGlXNjg5TFJPN0g0Z2srU2t6SVNFd1JXb2dJOGdsUVd3?=
 =?utf-8?B?aCtmOUlscDliNDI3Zks2RWVOOGNKaTVsaGp1d3QxZDUzZE44dVlaYWlyTnpX?=
 =?utf-8?B?cGNEM0NuMUVqekhMcndXMVVNNFJqWGVhMldhc3NmUlUxa21ZOVZwZ21zdDUx?=
 =?utf-8?B?a00vZkdTWlloeFRxVGw5ZVp1WVVTT3hzdmxLNEZXMlBIVnJxTnBFaWJPOWV5?=
 =?utf-8?B?dUFLcTZ0WUw5citiMXVlZEw5bkU2L0J3b3dYZWVHdk05S1A3ajdPTXRmVUo1?=
 =?utf-8?B?dGxGSWFwQnpMc2hGV3lLRHdjUFc1elNkSjdBSm9KalNFNzJpaklZMklRWnRn?=
 =?utf-8?B?VXVYZjRoUUF1QllmNy9nNDRmZDdqa0lScFZ6RHVKVlJnNSs5Ny9oRHRDMGs5?=
 =?utf-8?B?bjE4TG83OFd0ZjQyZ0JvcmZ3SThqL215K05QTUIxYUZDYXE3UUR5eUVmVlJ3?=
 =?utf-8?B?MjhTSlZpZjBoeVAwSEJoRTBVN25LWlRLZmMwMnBmWm9URjRFWDJtMGZ2YVd6?=
 =?utf-8?B?WlJZTHZpTXhmK2cxcG45N2lXMFpKejhGUVNXalJ5dFhKK29Oc09KN0tFOUJv?=
 =?utf-8?B?VkE3YUxIei9rWUkzYU4yNDVTMEUzY0NpVnArU1JXbXNDMjdVUFFsckJPaURH?=
 =?utf-8?B?MHM3aTNKWk9mckt0enRPVENoN1YvWWJTOEd0QUJJUVVCT2RFMEo5NytqeGo0?=
 =?utf-8?B?cnBiT2tQdno1YVVNNUlGZm1DUFdrdUtnVDRIekp5S3pkYTZORTE5YWlNbm9U?=
 =?utf-8?B?djU3Z2wzVmxzYUUvWlI4TjNaZVZlajZwakZZeEhQRnZEUWRGNVpCZUhNMUo1?=
 =?utf-8?B?S2lJdDBZVDdjWGhIK0FMZHdCN1EyUHIzUXpmdWN1RjFJS3NhRXEvUGJCNnY2?=
 =?utf-8?B?aXhYclhFTjdaMDBLeGdtZjdZMkFCc0VsbXlicGNkZFBZM3ZISFZETXB2MFFP?=
 =?utf-8?B?eHRka1Njc2JVSzVhenF4aHM5Rk1RU3hOSzJLSERyNlk1Y3R6cXZ6OTZCZ3pq?=
 =?utf-8?B?VmkxYXhzbUFoTmlLY1ZhaHdqQlRzNGlOQ2pvQ3RwUXF5SXBJWEZkcWpTS2ll?=
 =?utf-8?B?blNQUnByNGxOVjhmbElYU0lKdUl5ODBJeEx5R2tlMGVndzNvbXphU1Q5aE1T?=
 =?utf-8?B?WUZ6ckJoZG1ubjBFM3BPS1h6YlBqUjZPeHc3YWVCUThKSnRtMGlNNnRjWVNq?=
 =?utf-8?B?RVdSTHdGT0dUNjhpZS9BRFc3WEVFYWpqS1FYdnM4ejBQa1FzeEcyL3oyWjc2?=
 =?utf-8?B?MkwxcEJSSUZyeTU1UWhkaDhpUWV1ajZ6T0lXakJoRU9xTTkzYXRUSkRmUVd2?=
 =?utf-8?B?RHFtTDJIRVY3R3hFUFhzdVNLTWlJL0Q3WUpQb25DMGtnUXJrcTFZQkg3WU1C?=
 =?utf-8?B?ZHRESVoxaTBPdjVUT2ZQUlM0K1o2MDhOWFZVMTVONm5paXBOTS9FWHBxQnlU?=
 =?utf-8?B?T1g1QTcvNTRzK2M5Wll0Ly9QaHVYT1JjdVk2K1RkRXIzdG41dW4xSjFGMU94?=
 =?utf-8?B?S0lKUTlOcTQ0b0FjQThQZVlaZ2o0S0ZOcERKSkF3RHFhR3JRVW1zK1dQM3VU?=
 =?utf-8?B?K1BJampXVHgza0JBVlZ0blZ6NFN6NmFtNU5nemE0V1MzSGtuMjljeXRyK0kz?=
 =?utf-8?B?THVPdFlqd3haS0VPek5vZTA2Y1pqZUtZL01mdzA3WHdqS1dIYVpxa094ZFNP?=
 =?utf-8?B?bjJ4RDh1SzA3TFJFRktQN0c2R0tkWFJxZ3o0L21lZkZMV0FZemlnUGg1SUw5?=
 =?utf-8?B?amtIdjQ3RTc1Y25GN0FxUjM5c2dwMm9NUkc3RnhIQ0Qrak5EWUZ4SmRpdG1Y?=
 =?utf-8?B?K0NoYm1OT0NieUd4VmQ3ZG1CVm1yUlFQUFdhQnJ6OFZNZTZXbjRsbzVhMGgr?=
 =?utf-8?B?V2I2d2ZZMVBYblpiQWwzNHFEL1RoaENkZnd3VGZQU3dpamp1UXBjNndYV3h6?=
 =?utf-8?B?c3RHZzVLUUQrM2FmY2dIenpuTmg5RFVVY2R3ejQyVHIxdEtlV2RQUXlnY0Fs?=
 =?utf-8?B?RGVoTXZMMW9Cck9ubTFJdnBqSnIzYVJNNXl3anZ0a2t0Z0crMkEwWWhSY2Vs?=
 =?utf-8?B?bklFc3ZONU5FdWpwREFGYVpRNE52eC9wUm41OC9JME1qcHpvSE4vbXBlTUZU?=
 =?utf-8?Q?w9s/Qap2sHyxUK30EGaCZV75tdX15vDm9JXg/Ehvus=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71CB2E42DCA92F4D83B61D75A6B22896@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50427d4a-689b-493e-c07b-08d9e81c3ac1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 20:23:38.9171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z84NOQGlsBEI++J7TWyPhvc1ItmGtOQt5/GAgcMH8hhziGv+/3O6i9Vc29JinC9bm3vWMfoGOFrwqhjO9BrTOj5LMiOZ/NVcgzdvIVL9lX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4488
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVGh1LCAyMDIyLTAyLTAzIGF0IDIxOjIwIC0wODAwLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6
DQo+IE9uIFRodSwgRmViIDMsIDIwMjIsIGF0IDU6MDggUE0sIEVkZ2Vjb21iZSwgUmljayBQIHdy
b3RlOg0KPiA+IEhpIFRob21hcywNCj4gPiA+ID4gICAgICAgICBTaWduYWxzDQo+ID4gPiA+ICAg
ICAgICAgLS0tLS0tLQ0KPiA+ID4gPiAgICAgICAgIE9yaWdpbmFsbHkgc2lnbmFscyBwbGFjZWQg
dGhlIGxvY2F0aW9uIG9mIHRoZSBzaGFkb3cNCj4gPiA+ID4gc3RhY2sNCj4gPiA+ID4gcmVzdG9y
ZSANCj4gPiA+ID4gICAgICAgICB0b2tlbiBpbnNpZGUgdGhlIHNhdmVkIHN0YXRlIG9uIHRoZSBz
dGFjay4gVGhpcyB3YXMNCj4gPiA+ID4gcHJvYmxlbWF0aWMgZnJvbSBhIA0KPiA+ID4gPiAgICAg
ICAgIHBhc3QgQUJJIHByb21pc2VzIHBlcnNwZWN0aXZlLg0KPiANCj4gV2hhdCB3YXMgdGhlIGFj
dHVhbCBwcm9ibGVtPw0KDQpUaGUgbWVhdCBvZiB0aGUgZGlzY3Vzc2lvbiB0aGF0IEkgc2F3IHdh
cyB0aGlzIHRocmVhZDoNCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9DQUxDRVRyVlRl
WWZ6Ty1YV2grVndUdUtDeVB5cC1vT01HSD1RUl9tc0c5dFBRNHhQbUFAbWFpbC5nbWFpbC5jb20v
DQoNClRoZSBwcm9ibGVtIHdhcyB0aGF0IHRoZSBzYXZlZCBzaGFkb3cgc3RhY2sgcG9pbnRlciB3
YXMgcGxhY2VkIGluIGENCmxvY2F0aW9uIHVuZXhwZWN0ZWQgYnkgdXNlcnNwYWNlIChhdCB0aGUg
ZW5kIG9mIHRoZSBmbG9hdGluZyBwb2ludA0Kc3RhdGUpLCB3aGljaCBhcHBhcmVudGx5IGNhbiBi
ZSByZWxvY2F0ZWQgYnkgdXNlcnNwYWNlIHRoYXQgd291bGQgbm90DQpiZSBhd2FyZSBvZiB0aGUg
c2hhZG93IHN0YWNrIHN0YXRlIGF0IHRoZSBlbmQuIEkgdGhpbmsgYW4gZWFybGllcg0KdmVyc2lv
biB3YXMgbm90IGV4dGVuZGFibGUgZWl0aGVyLg0KDQpJdCBkb2VzIG5vdCBzZWVtIHRvIGJlIGEg
ZnVsbHkgZGVhZCBlbmQsIGJ1dCBJIGhhdmUgdG8gYWRtaXQgSSBkaWRu4oCZdA0KZnVsbHkgaW50
ZXJuYWxpemUgdGhlIGxpbWl0cyBpbXBvc2VkIGJ5IHRoZSB1c2Vyc3BhY2UgZXhwZWN0YXRpb25z
IG9mDQp0aGUgc2lnZnJhbWUgYmVjYXVzZSB0aGUgY3VycmVudCBzb2x1dGlvbiBzZWVtZWQgZ29v
ZC4gSeKAmWxsIGhhdmUgdG8gZGlnDQppbnRvIGl0IGEgbGl0dGxlIG1vcmUgYmVjYXVzZSBhbHQg
c3RhY2ssIENSSVUgYW5kIHRoZXNlIGV4cGVjdGF0aW9ucw0KYWxsIHNlZW0gaW50ZXJ0d2luZWQu
DQoNCkhlcmUgaXMgYSBxdWVzdGlvbiBmb3IgeW91IGd1eXMgdGhvdWdoIOKAkyBpcyBhIGdlbmVy
YWwgdWNvbnRleHQNCmV4dGVuc2lvbiBzb2x1dGlvbiBhIG5pY2UtdG8taGF2ZSBvbiBpdHMgb3du
Pw0KDQpJIHdhcyB0aGlua2luZyB0aGF0IGl0IHdvdWxkIGJlIGJldHRlciB0byBrZWVwIENFVCBz
dHVmZiBvdXQgb2YgdGhlDQpzaWdmcmFtZSByZWxhdGVkIHN0cnVjdHVyZXMgaWYgaXQgY2FuIGJl
IGF2b2lkZWQuIE9uZSByZWFzb24gaXMgdGhhdCBpdA0Ka2VlcHMgc2VjdXJpdHkgcmVsYXRlZCBy
ZWdpc3RlciB2YWx1ZXMgb3V0IG9mIHdyaXRhYmxlIGxvY2F0aW9ucy4gSeKAmW0NCm5vdCB0aGlu
a2luZyBvZiBhbnkgc3BlY2lmaWMgcHJvYmxlbSwgYnV0IGp1c3QgYSBnZW5lcmFsIGlkZWEgb2Yg
bm90DQpvcGVuaW5nIHRoYXQgc3R1ZmYgdXAgaWYgaXTigJlzIG5vdCBuZWVkZWQuIEFuIGV4YW1w
bGUgaXMgaW4gdGhlIElCVA0Kc2VyaWVzLCB0aGUgd2FpdC1mb3ItZW5kYnJhbmNoIHN0YXRlIHdh
cyBzYXZlZCBpbiBhIHVjb250ZXh0IGZsYWcuIFNvbWUNCnVzYWdlcyBtYXkgd2FudCB0byBrZWVw
IGl0IGZyb20gYmVpbmcgY2xlYXJlZCBpbiBhIHNpZ25hbCBhbmQgdGhlDQplbmRicmFuY2ggY2hl
Y2sgc2tpcHBlZC4gU28gZm9yIHNoYWRvdyBzdGFjaywganVzdCB0aGUgZ2VuZXJhbCBub3Rpb24N
CnRoYXQgdGhpcyBpcyBub3QgaWRlYWwgc3RhdGUgdG8gb3BlbiB1cC4NCg0KT24gd2hlcmUgdG8g
a2VlcCB0aGUgd2FpdC1mb3ItZW5kYnJhbmNoIHN0YXRlLCBQZXRlclogaGFkIHN1Z2dlc3RlZCB0
aGUNCnBvc3NpYmlsaXR5IG9mIGhhdmluZyBhIHBlci1tbSBoYXNobWFwIG9mICh1c2Vyc3BhY2Ug
c3RhY2sgYWRkcmVzc2VzKS0+IA0KKGtlcm5lbCBzaWRlIHNhdmVkIHN0YXRlKSwgbGltaXRlZCB0
byBzb21lIHNlbnNpYmxlIGxpbWl0IG9mIGl0ZW1zLg0KVGhpcyBjb3VsZCBiZSBleHRlbmRhYmxl
IHRvIG90aGVyIHN0YXRlIGJlc2lkZXMgQ0VUIHN0dWZmLiBJIHdhcw0KdGhpbmtpbmcgdG8gbG9v
ayBpbiB0aGF0IGRpcmVjdGlvbiBpZiBpdOKAmXMgbmVlZGVkIGZvciB0aGUgYWx0IHNoYWRvdw0K
c3RhY2suDQoNCkJ1dCwgaXMgaXQgc3dpbW1pbmcgYWdhaW5zdCB0aGUgcGxhY2Ugd2hlcmUgc2F2
ZWQgc3RhdGUgaXMgInN1cHBvc2VkIg0KdG8gYmU/IFRoZXJlIGlzIHNvbWUgb3B0aW11bSBvZiBj
b21wYXRpYmlsaXR5IChtb3JlIGFwcHMgYWJsZSB0byBvcHQtDQppbikgYW5kIHNlY3VyaXR5LiBJ
IGd1ZXNzIGl0J3MgcHJvYmFibHkgbm90IGdvb2QgdG8gaGF2ZSB0aGUga2VybmVsDQpiZW5kIG92
ZXIgYmFja3dhcmRzIHRyeWluZyB0byBnZXQgYm90aC4NCg0KPiA+ID4gPiBTbyB0aGUgcmVzdG9y
ZSBsb2NhdGlvbiB3YXMNCj4gPiA+ID4gaW5zdGVhZCBqdXN0IA0KPiA+ID4gPiAgICAgICAgIGFz
c3VtZWQgZnJvbSB0aGUgc2hhZG93IHN0YWNrIHBvaW50ZXIuIFRoaXMgd29ya3MNCj4gPiA+ID4g
YmVjYXVzZSBpbg0KPiA+ID4gPiBub3JtYWwgDQo+ID4gPiA+ICAgICAgICAgYWxsb3dlZCBjYXNl
cyBvZiBjYWxsaW5nIHNpZ3JldHVybiwgdGhlIHNoYWRvdyBzdGFjaw0KPiA+ID4gPiBwb2ludGVy
DQo+ID4gPiA+IHNob3VsZCBiZSANCj4gPiA+ID4gICAgICAgICByaWdodCBhdCB0aGUgcmVzdG9y
ZSB0b2tlbiBhdCB0aGF0IHRpbWUuIFRoZXJlIGlzIG5vDQo+ID4gPiA+IGFsdGVybmF0ZSBzaGFk
b3cgDQo+ID4gPiA+ICAgICAgICAgc3RhY2sgc3VwcG9ydC4gSWYgYW4gYWx0IHNoYWRvdyBzdGFj
ayBpcyBhZGRlZCBsYXRlciB3ZQ0KPiA+ID4gPiB3b3VsZA0KPiA+ID4gPiAgICAgICAgIG5lZWQg
dG8NCj4gPiA+IA0KPiA+ID4gU28gaG93IGlzIHRoYXQgZ29pbmcgdG8gd29yaz8gYWx0c3RhY2sg
aXMgbm90IGFuIGVzb3RlcmljIGNvcm5lcg0KPiA+ID4gY2FzZS4NCj4gPiANCj4gPiBNeSB1bmRl
cnN0YW5kaW5nIGlzIHRoYXQgdGhlIG1haW4gdXNhZ2VzIGZvciB0aGUgc2lnbmFsIHN0YWNrIHdl
cmUNCj4gPiBoYW5kbGluZyBzdGFjayBvdmVyZmxvd3MgYW5kIGNvcnJ1cHRpb24uIFNpbmNlIHRo
ZSBzaGFkb3cgc3RhY2sNCj4gPiBvbmx5DQo+ID4gY29udGFpbnMgcmV0dXJuIGFkZHJlc3NlcyBy
YXRoZXIgdGhhbiBsYXJnZSBzdGFjayBhbGxvY2F0aW9ucywgYW5kDQo+ID4gaXMNCj4gPiBub3Qg
Z2VuZXJhbGx5IHdyaXRhYmxlIG9yIHBpdm90YWJsZSwgSSB0aG91Z2h0IHRoZXJlIHdhcyBhIGdv
b2QNCj4gPiBwb3NzaWJpbGl0eSBhbiBhbHQgc2hhZG93IHN0YWNrIHdvdWxkIG5vdCBlbmQgdXAg
YmVpbmcgZXNwZWNpYWxseQ0KPiA+IHVzZWZ1bC4gRG9lcyBpdCBzZWVtIGxpa2UgcmVhc29uYWJs
ZSBndWVzc3dvcms/DQo+IA0KPiBJdCdzIGFsc28gdXNlZCBmb3IgdGhpbmdzIGxpa2UgRE9TRU1V
IHRoYXQgZXhlY3V0ZSBpbiBhIHdlaXJkIGNvbnRleHQNCj4gYW5kIHRoZW4gdHJhcCBiYWNrIG91
dCB0byB0aGUgb3V0ZXIgcHJvZ3JhbSB1c2luZyBhIHNpZ25hbCBoYW5kbGVyDQo+IGFuZCBhbiBh
bHRzdGFjay4gIEFsc28sIGltYWdpbmUgc29tZW9uZSB3cml0aW5nIGEgU0lHU0VHViBoYW5kbGVy
DQo+IHNwZWNpZmljYWxseSBpbnRlbmRlZCB0byBoYW5kbGUgc2hhZG93IHN0YWNrIG92ZXJmbG93
Lg0KDQpJbnRlcmVzdGluZywgdGhhbmtzLiBJIGhhZCBiZWVuIHRoaW5raW5nIHRoYXQgYW4gYWx0
IHNoYWRvdyBzdGFjayB3b3VsZA0KcmVxdWlyZSBhIG5ldyBpbnRlcmZhY2UgdGhhdCB3b3VsZCBt
b3N0bHkganVzdCBzaXQgZG9ybWFudCB0YWtpbmcgdXANCnNwYWNlLiBCdXQgcHJvYmFibHkgYW4g
KG9idmlvdXMpIGJldHRlciB3YXkgd291bGQgYmUgdG8ganVzdCBoYXZlIHRoZQ0Kc2lnbmFsc3Rh
Y2soKSBzeXNjYWxsIGF1dG9tYXRpY2FsbHkgY3JlYXRlIGEgbmV3IHNoYWRvdyBzdGFjaywgbGlr
ZSB0aGUNCnJlc3Qgb2YgdGhlIHNlcmllcyBkb2VzIGF1dG9tYXRpY2FsbHkgZm9yIG5ldyB0aHJl
YWRzLiBJ4oCZbGwgdGhpbmsgSeKAmWxsDQpzZWUgaG93IHRoYXQgd291bGQgbG9vay4NCg0KPiAN
Cj4gVGhlIHNoYWRvdyBzdGFjayBjYW4gYmUgcGl2b3RlZCB1c2luZyBSU1RPUlNTUC4NCg0KWWVz
LCBJIGp1c3QgbWVhbnQgdGhhdCB0aGUgYWJpbGl0eSB0byBwaXZvdCBvciBtb2RpZnkgaXMgcmVz
dHJpY3RlZCAoaW4NClJTVE9SU1NQJ3MgY2FzZSBieSByZXN0b3JlIHRva2VuIGNoZWNrcykgYW5k
IHNvIHdpdGggbGVzcyBhYmlsaXR5IHRvDQppbnRlcmFjdCB3aXRoIGl0LCBpdCBjb3VsZCBiZSBs
ZXNzIGxpa2VseSBmb3IgdGhlcmUgdG8gYmUgY29ycnVwdGlvbnMuDQpUaGlzIGlmIG9mIGNvdXJz
ZSBqdXN0IHNwZWN1bGF0aW9uLg0K
