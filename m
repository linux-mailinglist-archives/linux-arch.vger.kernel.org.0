Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01F365E237
	for <lists+linux-arch@lfdr.de>; Thu,  5 Jan 2023 02:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjAEBH2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Jan 2023 20:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjAEBHX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Jan 2023 20:07:23 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE593054E;
        Wed,  4 Jan 2023 17:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672880833; x=1704416833;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AP2SriYOVqPIdRADy3oNnB27MKDSnYfLuxhY43mSNMM=;
  b=O2gEO/uTX33SBimrA4crFOFlLj7uPqRPaZReORT6Cjx9Lah2WhpIiyNL
   1PAf5DHpa5nmc0EgDGjTPDr2sl9IVu0YdkBrG0onAQ49juxY2KlTWcOBM
   /91dkMVrYT3TKenbQGlkwtpKM2jXQrpP229P2mA8FIc3QwcA9Ei/twkTR
   LOJTroDg85GaU2pCZFJI9zqW2orGxCEX+5DVmFFXZRYT8HSMguvfeHi0+
   s5PUSuqlboVFYQgejSYDcg4siO0cKYdOcYOwGXE3Pt/UXBjdItvwXR9m3
   r4ZpGfDvugb+3wi6R/GjVfO/XFW7kI09+R5YcIzz4e+Ejqc2wXQFTdQ1a
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="319788925"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="319788925"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 17:07:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="632985463"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="632985463"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 04 Jan 2023 17:07:11 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 17:07:11 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 17:07:11 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 4 Jan 2023 17:07:11 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 4 Jan 2023 17:07:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXLQmTe8dbYocKU7c+A0SXwwuJrmVu18D2rB5zkbBASPsOXerjOaY/UXh1jFL2vvuqGSH4bny4IXnPCR/OiBRaOMCsxeBQQBQFjWoQpZw0hs5l1l823aqvIjTzu3E0+sp4hZNUlX09elXWBvhsPmZKY1FOh6VShMSZry0QGoH1Vp45gG2lZWyZnWKFUKtm35CYNMyzlxDy6MBSUhhqUayNZehDjxN663/xO4kwCJfSu+hcDCHfu45Mz2LOS/fryMpl6OPDA5kpl3h2MIP5wRx5Y2Shx/W7/5K+rgY6kxLQ5aNq29jcJk+TBRjyH3Wm2XybflG8dYcUNn9T8fy3fK5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AP2SriYOVqPIdRADy3oNnB27MKDSnYfLuxhY43mSNMM=;
 b=Cg3WjSFZorkVolC8xw/xUaPPaPyc62HG59xRewOHDJ6qTr0oxU/IluWg6F5tRIfkdRPvDtaWW4wS7ElU60bT7Mh8KNJ0OA0ZbpSaQkYvQWf/vOz1bPsaqFhOjd8Y9Ow68eM9xvCZ95wl8sqRz52Xmr/OTsPIi9ZsJdp88dz1/Fd2UI/fNj0PlRvP/m4sYk2YLrOnqI4JOhJ7HQhqJYgDsAHzmgkZkAPCYZMsgWBcc/uWfgK8cgJTzYSRbnxoCjkrHO6rCV6rPDkS2XxMRhQw5sBAbnJGpUjlmrU5ytTuT81P2sAYlo0cpr2zaD+n6pyWKFJpCM4hJ1ExS+/H2XCTWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MN6PR11MB8169.namprd11.prod.outlook.com (2603:10b6:208:47d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 01:06:50 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff%5]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 01:06:50 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
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
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v4 11/39] x86/mm: Update pte_modify for _PAGE_COW
Thread-Topic: [PATCH v4 11/39] x86/mm: Update pte_modify for _PAGE_COW
Thread-Index: AQHZBq9emZWK0Ia1IEy8YRukVHWfCa6BwyUAgADGMgCAC+lygIAAw9KA
Date:   Thu, 5 Jan 2023 01:06:50 +0000
Message-ID: <96aac5364a144e601ff2f63a4f96dc1161ca42dd.camel@intel.com>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
         <20221203003606.6838-12-rick.p.edgecombe@intel.com>
         <Y6raFBB+oVx+2WXl@zn.tnic>
         <060f1009199b09b7f8b9698e9f6f8375d9d1b66d.camel@intel.com>
         <Y7V+ZbTa3bWmXzKo@zn.tnic>
In-Reply-To: <Y7V+ZbTa3bWmXzKo@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MN6PR11MB8169:EE_
x-ms-office365-filtering-correlation-id: 2359b81d-8239-413f-705f-08daeeb9201f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XCzVGKkAfw5VdBrQDyTKyAKlHGrVMHH/KXV0R9VKQFuY92CBymNRSpkYb0DrjvOxZoonGIfkmrg8XNE9YdAAsF4aC9CuSdZtv4KwdyVLfIFXwxTPT4aIso88rvh+QyooWwhMUxayUc7jDgpo86RIJCGIJh6rLpbKtN5h23ThOZa1ff/kPhrbJ84b9BdWVg3rg8uspRfhmyEW317C7GPabEfWdRCaUUKQsSF2ugdpL8uGHDwGzgkSmJIWsi/LgNoW605YJLaukyzZEVaoFlHE9XSldtKmDgcaBxB/KSwgqq5KorTYfpCQCjO2OPze2+AaD6l5d5fDiChVSnyuj9yxCV78c1k04gukizyEttllWlCPvFF2/3mFoh2dcQAz4rPtWRFW76L8iWF42stGb0NRynXLp7VojdT4TyiPCA43xHIcjeHolm7Haqqu+TTkcLUQfwImQgEnOrIbV2se3+3pLvLD77NneIXhtfaGDJI/CG+eQbRENRAektcHr5dyMjkJKUwlG/y4S+Olsvt+h78RmUG1R5ywKf26So5nWLm1rb+TFcrHjbT4Rholb1kmTosaxWjRO8fQFfg8zTZp1mzGvXSxFDEf7VPaiCAeFyBipBsPikdf4EXw1WNLzz3/AG5cFffpYhV6jXyV6ByKZKTNvgE8BVApuS5ON9qNllRabTdfvugzJkG6hdzx8WBfdPQNffz9IUHqfaPCPYp8jKdPU41jE8KKQI6T5zbbOtBXLPD5QfIFTi7qvsM4cQgKfRo1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(366004)(396003)(346002)(376002)(451199015)(38070700005)(122000001)(82960400001)(38100700002)(36756003)(86362001)(66556008)(6916009)(2616005)(6512007)(66476007)(64756008)(66446008)(6506007)(478600001)(76116006)(71200400001)(186003)(966005)(26005)(7416002)(316002)(54906003)(6486002)(91956017)(8676002)(66946007)(2906002)(41300700001)(4326008)(8936002)(83380400001)(5660300002)(7406005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjVrUy91M29PblpNZXlJWXd4VTVBQWlKbENnN1l1M2x5NU0xMlplalZyN0Qv?=
 =?utf-8?B?YUVLNXVHSkpqZjE2YWpLek5ob0pHdEp1WE5MbFhrOUt2dERrU0g2Ny9mODR3?=
 =?utf-8?B?OHROVEYwTWpWbmZ1N0lTR2JIclhwdk5BTEZBV3hQNEdORFFnbHpGUkZpQzl1?=
 =?utf-8?B?eTNFeU5yMTFjNll5NFEwU2Y0cUFtYUVCOVc1dVpYczk5M0NIOUQ1T0NML0Zq?=
 =?utf-8?B?YUp5Q2VlT291U2xGWUtMUGlORWxXUXdidkdwdDU2YmEvbVlxUXpFbWg3VkRF?=
 =?utf-8?B?UnNWcjlXUjgreG4veFVVNUZCZTlYZ3V2ZXZZVTUrdG1PdkxIZTlDSmJZaWRM?=
 =?utf-8?B?L096dUIrQlBPN3RMNWdFZldTWlFEWGsyWGxQb3piUDNET2Z1NEhuU2FEajdm?=
 =?utf-8?B?b3FOeWdCa0ZrYnZ5czJLZUx0clFlK1FtanlObEU5b0tZQnVzVFN5a1c3M1Q2?=
 =?utf-8?B?UUJOVmN0cjVITjU1ckxPb25wamF6ZWptei95aURQMENGK0VodmF4N3A1R3pR?=
 =?utf-8?B?UmZHVmhOdm9mYXdQL0ttQ3pHTFBiSXN3WWlBdFFZSGt4cm5XZWFTS1JXeHJR?=
 =?utf-8?B?U2FBU1Z5MWkzQWZxeSt1YXY4SmJpSlRwUG5sTWhYeWo5WGlSVkh1ZFNhcjZO?=
 =?utf-8?B?V25OOFFDZjliWGlBOVFESWo4cXhDaWJScC9Da2FvWEpIeU5LZTA3QmxnVkZ2?=
 =?utf-8?B?S3lTL3czekRqdEhQK2ZQOWtKaTg1U0R6Q0NCOFMxUVhSWnRlUXZtNUNCcjVQ?=
 =?utf-8?B?c2l1Q1BnUit6RVAwMVJmeTdLRjkyNm00enlNbk5LMlBpV3o4S29nbUF2YkUr?=
 =?utf-8?B?NkNjWFliM1RpeFZBeW5IZmtPdVgyVXhoK1hPcDdiRnVyTi96SlEzeXRYaDBR?=
 =?utf-8?B?SWFSNTM0NG52dzZsYmxCT2o5OVZ2SGdXckt4OURVVCtVbnVQYzByZnBLbGJO?=
 =?utf-8?B?ZlVpWFAxR1owNGRuUXNaaXdsbEgyN3M4MTFnN2s5UTcrNFdKQzJHL3Z4UEdH?=
 =?utf-8?B?akFyY0xSaW1sekczOGhPL25nV1NmdVZWdVg5WnhZQ2crYm1FYnliMlc1WlZi?=
 =?utf-8?B?RjhZNFd3aHp6VDFETDMxT0t5ZlVDdVNGdkVVTnBHd3Rnc0FYNmFCN3Q3QUxE?=
 =?utf-8?B?Tm5pZmMyNFYxM0FlR2dXa0FvaGszVlQ3d21JRmVwbXBlUVRKQmM5YmlHbkpF?=
 =?utf-8?B?aSt2bno1WnNDTFNvYmhQK2IvV3hxMldVc0kySVpHbjJSRi82YUtIWjFsYi90?=
 =?utf-8?B?SGEzekJnV1J2RXJuRjFvZm1wYjF6dDArYTBVU2Y3TWRIdHpEbXZ2Yko2a0lY?=
 =?utf-8?B?VTYxOGtDVEpsbHA3bCtaUm9PVVFPbEVFR29jZ1ZMUVQyYXhsY3NzakpvVGd2?=
 =?utf-8?B?MlMvcU5TbzYxRzVobzBIbm9hS25VcGZySXA1WGdJS2l1aDBQWEwwelZTQkxW?=
 =?utf-8?B?K04rZXFiSU5od1RjK2cyWStIQ3E3aTBOdFFuMkQ3WTFYOGRFdjVZdHpRZVN1?=
 =?utf-8?B?dTA1STUzUlpzVTdtd3BwQnpObmJoNVNwVXFRQ1UyaUZCOC9FdkZRQ3dFZnNi?=
 =?utf-8?B?elJaNUdJcTV4QVdtWSsrd2R3bU53OXJUQ090SHlTbm1zcllYUi9GQ2o0VTdW?=
 =?utf-8?B?NkhRUU9nWkFaODYzWU0wTWZuMXVPYk0rd1VVb2lSU2JxMHBGdXF1a3R0OEtx?=
 =?utf-8?B?djhhem9wZmpidWpTQU9rbU5zTCtpNWdOQ1pXMWVkMCt4WDh2QkFRYnRNS25C?=
 =?utf-8?B?NnVObkRHWmo1WERGbTJSaXlYTW9wN29UcHJRUEVobHFDRGtsc2FyK1NuZHpn?=
 =?utf-8?B?dHF1eXlLL1MveUJlVmdmQ2llWTZoVWNvalAwVE02Rk9iQm9wbjF0VlpKVndm?=
 =?utf-8?B?T2RKeG8wT1FMeGxQRk5PYTBLdFhpeXU3RTZTUG02R1dvOVprUi94cW9FZzN2?=
 =?utf-8?B?S2J0RTVHQm4vUVZiWStCOUppdlEwVjRVaXpFdEZHL2JWcGI1ZFhaS1g3emFi?=
 =?utf-8?B?QnA5R042UGpMU3lpdy9JRXVROU44bGJSek94WHpqSThsaE83Y1IvSFJwV2oy?=
 =?utf-8?B?QkVvVEsrWmYxc25GWjdrMmNFeVFZK1dROVBqUHdWTDU1WWFFVnEvNDJzUXEw?=
 =?utf-8?B?MjQzMEI3MGwrd3JrZVlnaEJVOWhrajFnZnRxdElOVk5ZZTZvbTZURUFzeldY?=
 =?utf-8?Q?jXZAr0JUF/mBAHJA4fe8TSs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB8EB7516456904A8AC450F58DB8A12E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2359b81d-8239-413f-705f-08daeeb9201f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 01:06:50.1169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PfC0ZQ4M+rbjXDX7H6XSDS9dpNDnDrqCfPDifotyeQ1Mhq5vKR9FzxkdB7rwKTzX9daWgF01+1RfVGzqOcxFFMSSDB0ZLDSs71U2X4Befjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8169
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gV2VkLCAyMDIzLTAxLTA0IGF0IDE0OjI1ICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFR1ZSwgRGVjIDI3LCAyMDIyIGF0IDExOjMxOjM3UE0gKzAwMDAsIEVkZ2Vjb21iZSwg
UmljayBQIHdyb3RlOg0KPiA+IFRoZSBjb21tZW50IGlzIHJlZmVycmluZyB0byB0aGUgZGlydHkg
Yml0cyBwb3NzaWJseSBjb21pbmcgZnJvbQ0KPiA+IG5ld3Byb3QsDQo+IA0KPiBBaCByaWdodCwg
b2ZjLg0KPiANCj4gPiBidXQgbG9va2luZyBhdCBpdCBub3cgSSB0aGluayB0aGUgY29kZSB3YXMg
YnJva2VuIHRyeWluZyB0bw0KPiA+IGZpeCB0aGUgcmVjZW50IHNvZnQgZGlydHkgdGVzdCBicmVh
a2FnZS4gTm93IGl0IG1pZ2h0IGxvc2UgcHJlLQ0KPiA+IGV4aXN0aW5nDQo+ID4gZGlydHkgYml0
cyBpbiB0aGUgcHRlIHVuZXNzYXJpbHkuLi4gSSB0aGluay4NCj4gDQo+IFJpZ2h0LCBkb2VzIHRo
aXMgY29kZSBuZWVkIHRvIGJlIHNpbXBsaWZpZWQ/DQo+IA0KPiBJLmUuLCBtYXRjaCB0aGUgc2hh
ZG93IHN0YWNrIFBURSAoV3JpdGU9MCxEaXJ0eT0xKSBhbmQgaGFuZGxlIHRoYXQgaW4NCj4gYSBz
ZXBhcmF0ZQ0KPiBoZWxwZXI/DQo+IA0KPiBTbyB0aGF0IHRoZSBmbG93cyBhcmUgc2VwYXJhdGUu
IEknbSBub3QgYSBtbSBndXkgYnV0IHRoaXMgZnVuY3Rpb24NCj4gbWFrZXMgbXkgaGVhZA0KPiBo
dXJ0IC0gZHVubm8gYWJvdXQgb3RoZXIgZm9sa3MuIDopDQoNClllYSwgdGhlIHdob2xlIFdyaXRl
PTAsRGlydHk9MSB0aGluZyBoYXMgYmVlbiBhIGJpdCBvZiBhIGNoYWxsZW5nZSB0bw0KbWFrZSBj
bGVhciBpbiB0aGUgTU0gY29kZS4gRGF2ZSBoYWQgc3VnZ2VzdGVkIGEgc2tldGNoIGhlcmUgZm9y
DQpwdGVfbW9kaWZ5KCk6DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvOTUyOTllOTAt
MjQ1Yi02MWM1LThlZjAtNWU2ZGEzYzM3YzVlQGludGVsLmNvbS8NCg0KVGhlIHByb2JsZW0gd2Fz
IHRoYXQgcHRlX21rZGlydHkoKSBhbHNvIHNldHMgdGhlIHNvZnQgZGlydHkgYml0LiBTbyBpdA0K
ZGlkIG1vcmUgdGhhbiBwcmVzZXJ2ZSB0aGUgZGlydHkgYml0IC0gaXQgYWxzbyBhZGRlZCBvbiB0
aGUgc29mdCBkaXJ0eQ0KYml0LiBJIGV4dHJhY3RlZCBhIGhlbHBlciBfX3B0ZV9ta2RpcnR5KCkg
dGhhdCBjYW4gb3B0aW9uYWxseSBub3Qgc2V0DQp0aGUgc29mdCBkaXJ0eSBiaXQuIFNvIHRoZW4g
aXQgbG9va3MgcHJldHR5IGNsb3NlIHRvIGhvdyBEYXZlDQpzdWdnZXN0ZWQ6DQoNCnN0YXRpYyBp
bmxpbmUgcHRlX3QgcHRlX21vZGlmeShwdGVfdCBwdGUsIHBncHJvdF90IG5ld3Byb3QpDQp7DQoJ
cHRldmFsX3QgX3BhZ2VfY2hnX21hc2tfbm9fZGlydHkgPSBfUEFHRV9DSEdfTUFTSyAmDQp+X1BB
R0VfRElSVFk7DQoJcHRldmFsX3QgdmFsID0gcHRlX3ZhbChwdGUpLCBvbGR2YWwgPSB2YWw7DQoJ
cHRlX3QgcHRlX3Jlc3VsdDsNCg0KCS8qDQoJICogQ2hvcCBvZmYgdGhlIE5YIGJpdCAoaWYgcHJl
c2VudCksIGFuZCBhZGQgdGhlIE5YIHBvcnRpb24gb2YNCgkgKiB0aGUgbmV3cHJvdCAoaWYgcHJl
c2VudCk6DQoJICovDQoJdmFsICY9IF9wYWdlX2NoZ19tYXNrX25vX2RpcnR5Ow0KCXZhbCB8PSBj
aGVja19wZ3Byb3QobmV3cHJvdCkgJiB+X3BhZ2VfY2hnX21hc2tfbm9fZGlydHk7DQoJdmFsID0g
ZmxpcF9wcm90bm9uZV9ndWFyZChvbGR2YWwsIHZhbCwgUFRFX1BGTl9NQVNLKTsNCg0KCXB0ZV9y
ZXN1bHQgPSBfX3B0ZSh2YWwpOw0KDQoJLyoNCgkgKiBEaXJ0eSBiaXQgaXMgbm90IHByZXNlcnZl
ZCBhYm92ZSBzbyBpdCBjYW4gYmUgZG9uZQ0KCSAqIGluIGEgc3BlY2lhbCB3YXkgZm9yIHRoZSBz
aGFkb3cgc3RhY2sgY2FzZSwgd2hlcmUgaXQNCgkgKiBtYXkgbmVlZCB0byBzZXQgX1BBR0VfQ09X
LiBfX3B0ZV9ta2RpcnR5KCkgd2lsbCBkbyB0aGlzIGluDQoJICogdGhlIGNhc2Ugb2Ygc2hhZG93
IHN0YWNrLg0KCSAqLw0KCWlmIChwdGVfZGlydHkocHRlKSkNCgkJcHRlX3Jlc3VsdCA9IF9fcHRl
X21rZGlydHkocHRlX3Jlc3VsdCwgZmFsc2UpOw0KDQoJcmV0dXJuIHB0ZV9yZXN1bHQ7DQp9DQo=
