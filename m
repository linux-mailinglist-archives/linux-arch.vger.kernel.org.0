Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CCA4A91FC
	for <lists+linux-arch@lfdr.de>; Fri,  4 Feb 2022 02:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356455AbiBDBW5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Feb 2022 20:22:57 -0500
Received: from mga03.intel.com ([134.134.136.65]:42749 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229972AbiBDBW5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 3 Feb 2022 20:22:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643937777; x=1675473777;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MoSaAGMn5nO6qTRRAgfqyXuYH5UoZUkFUL3ZaQS+2TQ=;
  b=VYmU271yo/EemQd8RG9x9PPXpB0XIEATWgwusJ69/lPDYc6PzufZINuY
   xFAaTxflZrxUAksgCdwn8srxKW9ga2cluZF6fZvq9yW5j/Bmwu2pTeU1d
   Bhlvf4L5kdlPodbbSBRNQWWHbgAiLOs4vCQqm3mkTn8S+rhYGXuUjnhzh
   r0ozi4V5a91TDYMhHFmqM1PbyBAImkhjBCPijh9RqnxlPhvBx9dYuMmiE
   gMITU1e2NFKlcgT1G3sItiCXCPIRj57oDq+K4kQkIIkPR7b1jFYIkpsAB
   lP5Rl3Bt8911fA6OPsOal2kEP4821RHN1MT4tma1beW5MtjJQEahrPH/R
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="248240489"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="248240489"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 17:22:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="566606470"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 03 Feb 2022 17:22:56 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 3 Feb 2022 17:22:55 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 3 Feb 2022 17:22:55 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 3 Feb 2022 17:22:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nP2t38466oItq9cG2f0CN8eLw3Jy6G6tpt2sOyY55rbToWTQay/DmymMYAQjhXs+4hX+K5tpRfq25+HA+94dpaWw61AKK5F2sCfX0bKuoUiuIYzk6jVXKMde6IZTMfXKLzJwvpcL/CCwVazylfo+wEbq7EoA/jg+bklLBhRHjgpKH6/Sl0zIAkPWh/cpNm0v1ohpKBAVQgsZQGve4WpBIFyBLzOzDU62KK1oqs2mNPMQDv+FPreEmzfPhLK5UervHb4PIi8wIqSh2cGLqvhCck3nzNjbzZVXVoXuEtLh3+q2klRdS/nE+FR/hFhDDUyCbs60nCcRArlR7BwoCd4GSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MoSaAGMn5nO6qTRRAgfqyXuYH5UoZUkFUL3ZaQS+2TQ=;
 b=FCMgsbGiamqOer+mEVCbBCtTChfQe+/QVMqh3fi+4118jj2qw/JLrjHEfqPvITvhV7GQJHTSxuNgq++jzYFYmhVs/fBARcQ0feQ28vPcR9WiEQ02ORPwJJLhKgq9PdvptzbqsPSYH3iyJFw/L2FsbNePFPwcOZELuJRhU7AHj2biL7wrb9ylxOQXWTVFawqz/L0lNjYT3IckfkavThQX5PPyvW/5EllwOIXH2Wrj6DtH/JweMTRgAS/Kdadreb/K5p0S9OEIrMLO+ylW9oBgCKDnnK2xHLpqOHRCs8iVkWsq3RrnlqXHQvlbqeWnqXWI8j0ucwyN7/rThNFt9Qw06g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 01:22:51 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7053:5a70:1fec:345f]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7053:5a70:1fec:345f%7]) with mapi id 15.20.4930.022; Fri, 4 Feb 2022
 01:22:51 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
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
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Subject: Re: [PATCH 33/35] selftests/x86: Add map_shadow_stack syscall test
Thread-Topic: [PATCH 33/35] selftests/x86: Add map_shadow_stack syscall test
Thread-Index: AQHYFh96to6ND21io0aXw3xYmrYSxKyCcmuAgAAsyAA=
Date:   Fri, 4 Feb 2022 01:22:50 +0000
Message-ID: <aeb9d7079ee784def9601498f9fff08db981fd9c.camel@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
         <20220130211838.8382-34-rick.p.edgecombe@intel.com>
         <e8e1501a-fdb4-0b8b-21a6-3bea1c6d9016@intel.com>
In-Reply-To: <e8e1501a-fdb4-0b8b-21a6-3bea1c6d9016@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b8a7325-8dcc-483d-466e-08d9e77cdc82
x-ms-traffictypediagnostic: PH0PR11MB5112:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <PH0PR11MB5112ED342A0496A710A00BECC9299@PH0PR11MB5112.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zyFIcUl0P65ojKQzQcV1bG7+NKbPu+cOWy+67uolVu2mgrqn9XEUmIUBtFL2+AP+2QV38AHD/yGBval8ftBtHcqy50k/lGpit9rpA0YCc1xSeQBt4dCEUacUUQkKZWfP9q9MqQRjN28zFMypq/VZURPtXJ160Bd+sCrd/rFXt3BwsseqPnQQhhpJ9OIR1YFOHJup4x4gA8kWJnFXHvI9FZezDZZ7z6Y5GyGNm2lLVisF+eGDdTqAr/RIc9vKJwfJv2UwQfAF29suSR8gkJvtcbanTrMde0pV7ILyov8F2iJ3M3sGbCVGIuOwvUf+4qT10v8Y+USO+fZz33k3AbKTBE6w8vtq5Gm5b9b9GOAmz0s20lx7qLYCrltfSXTtWVFDwdh1I4VmdFTOEyYnjRpDNpX7nget8bZ63s+XznQ46sMJP3KA0/QOZSlzbPnGq0jhh1ZHhks0HE0JymdZ1paF37XJb67Kn1VkS5M6S54cTuKboFnLxfkoFFgm2cHgd8fHgKODElzgRODg2qa2gpNHh0kRXX70Euc8qu2reK3YKL39Q6brgZo3kjjSkrybkvd6ZiToANwNZrKhJTUzVODI4NIC9geAq0IOHjLG+C4ALmIu6L7vKmRzicEMHROj0L9cvxAcUVEYX3fDPO0uNT5u+xq0H7UWS+XvktMVi+NGHlE/+c/K9uWM5qFBItQrIQ+G8wZtgwxxBNKcshtYkkiOMz1ArZIN4nV6dD3f6C7XffGn4Epmban9YJdP7eCfAE10
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(5660300002)(66476007)(38070700005)(4326008)(8936002)(2906002)(7406005)(66556008)(7416002)(6486002)(76116006)(86362001)(66446008)(64756008)(38100700002)(66946007)(122000001)(921005)(186003)(508600001)(83380400001)(36756003)(82960400001)(316002)(26005)(6506007)(71200400001)(2616005)(6512007)(110136005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2lnZ3l4NjZvMG9TRlZDSFJ3dzYraDVQbFFxRjRyQytZZlB2Uk43ZmcxMzRP?=
 =?utf-8?B?WExMUStqWTRod1pSWlQ3NG41QUg4dm56eFh1TXdlaEtQWGpYbThDQURPSTd3?=
 =?utf-8?B?aWprSjlyWEVCbklWWlZGQ3M0RXZLMzdUcWVFWTFjMkF6cVc4dGZBUlVsTnFB?=
 =?utf-8?B?QVRlMmlJWGJpLzFzTGI5R3lpSS91QUlVWlFqOEF4eDMxZmlRdFdwVmU0ZUZO?=
 =?utf-8?B?M083aGlHWk83dVVzQWtlM0ZNdGRoYk5ZQlhlV1U4N0JRTFI2ZXg2RCticEh3?=
 =?utf-8?B?R2trbkVodCtGUHRiV1MwSitXazNncEdaSGFtNkZyVWtlWDRhSVRyQnZKMkVr?=
 =?utf-8?B?cmx2S05aejhxV1RHRTBXNlpKcXo5WVg4ZWVyeGx2MGQzcU5kb0NhdDNzc1ha?=
 =?utf-8?B?K2RXQWJ5TXZENGF2Z3ZBblZ4OHI3RHRHNC9YY29NVjZ6VWI5cHBOb1AwaXlp?=
 =?utf-8?B?R2pMTS92Vk5nUmxnMlZOdTVIYVpkR0MrOGhRL3hUayttaDhxUVNLWkNxeXZB?=
 =?utf-8?B?MVNjeG1XRGcySEErY2g0WmEzOWtUUVhXdXJPUXlLVnVvaThiRUo2WUcrcXR0?=
 =?utf-8?B?THJZaGF3RHJvTjlGN09POGlXNDRGUXAyS09YWjh0ZTVrUjFiR3RscTVHVTlu?=
 =?utf-8?B?VU1lWGVXSUhyWHFkc3orT1NEczNnelBCYXJlRHJLRUVCQytHQnFqanprK0Zn?=
 =?utf-8?B?NHBRTGRXUC9mek1FZXlyMkc3T0cxV1I3ZkNHZitMdG5VYTFsUG85RUpsdjFq?=
 =?utf-8?B?SkpxeEhvTFhtY0ZBYk9LaEc1N3ZRY0VQcWtYcndjallYZW9VSGdMbEZ4aDJ4?=
 =?utf-8?B?ZWdnOUV2bnNZNEdlNFVDZmxra09GdDY1OXE0ekJKcUZRcE9DdnRjdVdxYWxQ?=
 =?utf-8?B?Z1pDWU9sQ1hvVTQ5eGRVcEhMTDEyclRIZlZUcTJlZm9QR1BCdkNXa2pjREw5?=
 =?utf-8?B?VVdsY1Z0YU9qd2MyRW52TkRRRVZRZmhOVFdtNDhVSTFpb2ZVNHFucjhvYVBa?=
 =?utf-8?B?YnFqY3dxVnhwdWJueDNYcUVRZ2ZhZDV1UXNlNVZ4VlN1U3NueDBTQkp4L1lQ?=
 =?utf-8?B?Y1dDMjNzbEE0ZDMwMHE4d1U0cGdMakR1U3RrQzZqbzVKNzZabVFrUkRKcDZ3?=
 =?utf-8?B?bjlqMXlRbEhDalVNRWFuVURBYTA4WHpvdnZtenVwVlExczVQTTdER0ZQN3E4?=
 =?utf-8?B?K0VueXI5QXlrMGY0dVRRSDVnYVdYTGRXaGFQbWpJQ1ZadnprREVLYjBQYm8x?=
 =?utf-8?B?U2NKWjB0T0owdDVuK0hCRFl6dVJKbnhPRVpxbkl1M3g2cTVVeXEwSythaHY3?=
 =?utf-8?B?QjcraVVLNzYwZiszVDh3b3VQNmlZTmg5ZDFJc0ZQbkxLVGp3bW9nMTFzVEdq?=
 =?utf-8?B?bXluMjl6YzRQQnJUUWdydWdaVjhadkNsZGpxS01XNElGUGh3anZZNVA0WURm?=
 =?utf-8?B?SlM1MkFwZTBVREFXTUk4SW82TldCMVdIVVR6L2FhOHRrY205bW5IUFNXM29h?=
 =?utf-8?B?VElJWnVocTFKa3ZCcFhsUmd5dklSSGhsWUVOcmJIUEhOeWpNUERlL1Y3ZzVi?=
 =?utf-8?B?Q1Yxc1pXalVxK2RTbG1VK1dncFFxcElSUGV4YWJxZkdhQ0lZZythNDZIY2Jx?=
 =?utf-8?B?ajE2ZmQ4dThyeWN2ZnJWU0UrakVrQUZENmlGVDNocHNpdFYvZWh4cGRLYWJI?=
 =?utf-8?B?SFJxem9YUlRHdlFLYmNHUmJxdkttUTZ0eUkwcUhoRVpiY0Y2amhDT1JIVENw?=
 =?utf-8?B?bi83VjhPMG0rdUNackRoWFhmMjV4eTVETENLbWxSRVEwLy9CaGo5UzFHZFdY?=
 =?utf-8?B?QW5GUlVUaSt4cWRIUnViVHZLYlpoQTQ3TzY0OWZzcys4MnBoSjZIZWx5by92?=
 =?utf-8?B?MUpHR01USVhORDY4eXJKRkpBVmxjd2RQNjVUY3ozNmE2NEhyNXlFRHNYdms2?=
 =?utf-8?B?dEtHbzB6NjUrWnY5Tmh4VzMzWVF3YXBHUThtdTZESW4ySXdLQnpqcllUeFRK?=
 =?utf-8?B?dmZNZUFpWUk0Z21EUGVaQUd1ZlFuM3RuWHUyR1VTVmFteXdOZEFHVjBOaCtt?=
 =?utf-8?B?SE12bjFHZmdSSlJabTdmRFoyWFV6eGJBZkdkU2laWXFyVWRDRDZOUmtUQXJo?=
 =?utf-8?B?bVkzZFYwdmdHbkNKdXg1VjU1b2Fsd3FrZzloT1QwekF6VWZ0R200TWl6b2Ns?=
 =?utf-8?B?NUNPVXFYTUxMQnN6YS92aERGRTNBNXBDaUxTNU4zS1VPU0lXRTJ0VUsxY1Np?=
 =?utf-8?Q?rGLOEMx3cjAd82IKZG1twkMqrPfiRJD5Xe0e1/1arY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0F29454640B87418AD70F1A00B7F5FA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8a7325-8dcc-483d-466e-08d9e77cdc82
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 01:22:50.7997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yEWtTIk5swbNSq4JcNxVsPVrFUCArevhgYdXMGRA61yyAw8Wvnsb3hQYVoDxgSr3PZZg7B2U1ll+chfddFi2dZ69d4GPzdMnAAv6no2sHVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5112
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVGh1LCAyMDIyLTAyLTAzIGF0IDE0OjQyIC0wODAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
VGhpcyBpcyBhIGdvb2Qgc3RhcnQgZm9yIHRoZSBzZWxmdGVzdC4gIEJ1dCwgaXQgd291bGQgYmUg
cmVhbGx5IG5pY2UNCj4gdG8NCj4gc2VlIGEgZmV3IGFkZGl0aW9uYWwgc21va2UgdGVzdHMgaW4g
aGVyZSB0aGF0IGFyZSBpbmRlcGVuZGVudCBvZiB0aGUNCj4gbGlicmFyeSBzdXBwb3J0Lg0KDQpT
dXJlLiBJIGhhZCBhY3R1YWxseSBpbmNsdWRlZCB0aGlzIGp1c3QgYmVjYXVzZSB0aGUgImFkZGlu
ZyBhIHN5c2NhbGwiDQpkb2NzIHNhaWQgdG8gbWFrZSBzdXJlIHRvIGluY2x1ZGUgYSB0ZXN0IGZv
ciB0aGUgc3lzY2FsbC4gVGhlcmUgYXJlDQpzb21lIG90aGVyIHRlc3RzIHRoYXQgd2VyZSBiZWlu
ZyBwbGFubmVkIGFzIGEgZm9sbG93IHVwLg0KDQo+IA0KPiBGb3IgaW5zdGFuY2UsIGl0IHdvdWxk
IGJlIG5pY2UgdG8gaGF2ZSB0ZXN0cyB0aGF0Og0KPiANCj4gMS4gV3JpdGUgdG8gdGhlIHNoYWRv
dyBzdGFjayB3aXRoIG5vcm1hbCBpbnN0cnVjdGlvbnMgKGFuZCByZWNvdmVyDQo+IGZyb20NCj4g
ICAgdGhlIGluZXZpdGFibGUgU0VHVikuICBNYWtlIHN1cmUgdGhlIHNpZ2luZm8gbG9va3MgbGlr
ZSB3ZSBleHBlY3QuDQo+IDIuIENvcnJ1cHQgdGhlIHJlZ3VsYXIgc3RhY2ssIG9yIG1heWJlIGp1
c3QgdXNlIGEgcmV0cG9saW5lDQo+ICAgIGRvIGluZHVjZSBhIHNoYWRvdyBzdGFjayBleGNlcHRp
b24uICBEaXR0byBvbiBjaGVja2luZyB0aGUgc2lnaW5mbw0KPiAzLiBEbyBlbm91Z2ggQ0FMTHMg
dGhhdCB3aWxsIGxpa2VseSB0cmlnZ2VyIGEgZmF1bHQgYW5kIGFuIG9uLWRlbWFuZA0KPiAgICBz
aGFkb3cgc3RhY2sgcGFnZSBhbGxvY2F0aW9uLg0KPiANCj4gVGhhdCB3aWxsIHRlc3QgdGhlICpi
YXNpY3MqIGFuZCBzaG91bGQgYmUgcHJldHR5IHNpbXBsZSB0byB3cml0ZS4NCg0KTW9zdCBvZiB0
aGlzIGFscmVhZHkgZXhpc3RzIGluIHRoZSBwcml2YXRlIHRlc3RzLiBJJ2xsIGNvbWJpbmUgaXQg
aW50bw0KYSBzaW5nbGUgc2VsZnRlc3QuIEhhdmluZyB3cnNzIG5vdyBuaWNlbHkgbWFkZSBpdCBh
IGJpdCBlYXNpZXIgYmVjYXVzZQ0KdGhvc2Ugd3JpdGVzIGFyZSB0cmVhdGVkIGFzIHNoYWRvdyBz
dGFjayBhY2Nlc3Nlcywgc28gd2UgY2FuIGRvIHRoZXNlDQpvcGVyYXRpb25zIGRpcmVjdGx5IHdp
dGhvdXQgdG9vIG11Y2ggY2FsbGluZyBhY3JvYmF0aWNzLg0KDQpUaGFua3MsDQoNClJpY2sNCg==
