Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751C26A7336
	for <lists+linux-arch@lfdr.de>; Wed,  1 Mar 2023 19:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjCASPA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Mar 2023 13:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjCASO7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Mar 2023 13:14:59 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BEC28207;
        Wed,  1 Mar 2023 10:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677694498; x=1709230498;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=i6KaB6CdYWq9fZzELYNEy4YcZ6HgJFs1trf6mV7yugU=;
  b=gjcSMhFI8WDRrr8oajSfguUgdIVWH83VGvqKSIw/k5frDgL3/dOXrwmq
   +gwVSFronu8ZqbRBbrGZ0HEX0x9ywjc/MArKurR+qCog5r3V3BXlWBiLS
   Y4ajCvlx+C6hV8pOAyAFV6AgpZKEAItgEjkCNkiIm1woVkbzcK84aFVv4
   cUFEV/01pvLyjbZ2sYzoKuYvbEb5VU2TQvcgQWmPInagqNy6CRMQ9U3d3
   PCWf1P7WtQa6FvyEiQnS4yaa/XBP5f1enS6UNWQj68KaKxHNk0mOx1p4Y
   Dgz1VaPOvo2qXu48o0dvvQtDlO2kONljnjqG6eS9gf6YauKMuiyQTRY79
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="333209269"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="333209269"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 10:14:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="784444035"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="784444035"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 01 Mar 2023 10:14:56 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 10:14:55 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 10:14:55 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 1 Mar 2023 10:14:55 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Mar 2023 10:14:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7848tc2I1roZST7ERqX3vN4IPTlC72gunhQjZN7HMkQ66hAoEFB5tUBBJX3QZywkZZGJ2bG5DtmeTnkIav3fScWw0JiZo81Bb5ZRXpgT5fUEJfSmbry3UkfTbZSfdJLZpuxsmanPrGEYtAYsruvpgGDOasowN3NSebrZ0rslTb+cIA5RwZsfubeGR6B0+H/cLEekK2w6XfFXtdkeOGSBl5v5qRXZ50mK2UqTEiLkB5NKgcwoldh2M22jCxZ06c1uRvdmjd7zGa0sfM7AhGYqm9s31laqJZeZzbR2TbS2ny7dhSg0aF5zf6DFrgdeDAa14+0gvduMfqQSFAIlfTEkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6KaB6CdYWq9fZzELYNEy4YcZ6HgJFs1trf6mV7yugU=;
 b=CwN/nPL3RLoCx+5/QIwVeAC+IZna2J5RrLL3GhzZsBqUQSiO5/TufrAahIIHvq9tGMVGerrb7Kv/UF5CtrEOxxf8szs/GgwVY1L4A5N5ld+9iHgWTzQy6E6lxbVNfqUmSN3bU+vf9iE+DBA6cAK8+BEA+sgFgIw0q6MJ2WDJ+OOW65j8GwCm44cGV6QbimiSusfGl2HZ/T3VLZOcvDd/wLkkeSeVWacWkjyD62yBsYb0NMOUvY9kI/s69AlkchX+r+nFwrXVmvLmz6AWEEayiz5F6nhG5ImGs+yRSeFT4/20IGJM8tsvYukKfb7a3684uOO0qvAlxZmUb2CA2yvVTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BL1PR11MB5511.namprd11.prod.outlook.com (2603:10b6:208:317::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Wed, 1 Mar
 2023 18:14:45 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 18:14:45 +0000
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
        "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v7 08/41] x86/shstk: Add user control-protection fault
 handler
Thread-Topic: [PATCH v7 08/41] x86/shstk: Add user control-protection fault
 handler
Thread-Index: AQHZSvs5y11HW9CvBkWrjcxdrHCuGK7mOwmAgAACZYA=
Date:   Wed, 1 Mar 2023 18:14:44 +0000
Message-ID: <0dc30a3fc7eeb83289317590cb95a1ed0bed3520.camel@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
         <20230227222957.24501-9-rick.p.edgecombe@intel.com>
         <Y/+UEdolvD1U+tGw@zn.tnic>
In-Reply-To: <Y/+UEdolvD1U+tGw@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|BL1PR11MB5511:EE_
x-ms-office365-filtering-correlation-id: 3277ff7b-149c-41d3-62a4-08db1a80d5ae
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mqwUfCnltr44ARVHaS1GLUETDPeFY1BstpNPgB8cBiJrF3NuDp/pq3qaGe04cjRfwMmI8uXdZXD3u4S2qMmm/zE1Vh1X9AkFNAoe3E8TKJlWZrV1yQUx0le66si6zG71H5cQUOWYQXqDFXPai863w/Qbg1ieLwm7Oy8SyHTpdllGHoLDbnZxOvYOJGvOGKLT8/g730z0/+MBgvxgEDgZx/e95IFYBQup/zVdF8fZIMxNogzX5ZeAkJT5ngO143f94vOsnA0HRMRUqaJUr3ibqH43JLO1FPWznl/V/jdqDNEEnaZ3ZaJ2WCtgRZCkyGe3L5Yg2n67sFSlMMJOQxBdkF++6uVurfbFl5ICDra3K6ArQk3Kmi0SWIqidzO8Oaxirjl649PKVBQpCJ76HIT1/Qo36ELUAQsN0nSL7KiUM8m5io+aLziw1ktVbrGZyelJinAXWeS+EnY5n/yUvwepy0yNa0RV5IU37EZNd1teFjZNyVA1mKRrt2lkJ/eiLrWmm8ZQLQH0r8qCahlhTg0PzMARTH1iAhiSShNeW4xvTyeIQ8vpn1AToeW9v5CivMZYuibfnoVEjsWBO/I3Rq/Ed2ucSPKia1dLUKtLnEV0KNq9DGkfM35qy0FGyfTxs6YfTTw17ymDoBQkemmVcYPp16cT8k8w6BOMMvlZ1KHEOQgQTsSJQUliz1++wBLS2crekh5ZLh9a9El6Jb1icF46GA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199018)(8936002)(122000001)(4744005)(5660300002)(7406005)(7416002)(82960400001)(4326008)(8676002)(6916009)(41300700001)(38100700002)(66946007)(76116006)(66446008)(66556008)(54906003)(64756008)(2616005)(478600001)(36756003)(966005)(6486002)(2906002)(91956017)(66476007)(71200400001)(6506007)(6512007)(86362001)(26005)(316002)(38070700005)(186003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWZEaEFSVHZoUTZPVVBwTHQ5dWx5emVMbFdPZ01JUVVoVUF0bXFNb1RncHRt?=
 =?utf-8?B?aWNJT2RhS0piWTZSdkRkcVBRU0tkdXF4UThBVjhaMysrOW95M0YvcHZwUkZD?=
 =?utf-8?B?TU5rQXNlZFA1RStPb25vUkFJQVI5VjJPVjlVVENZaXRpZEd6aEhxZngxSUp0?=
 =?utf-8?B?aCtpY3dLL2xSSDl0Uk1VNkNoQmM3UmZmTjFnc2dhNktBTWlqQnZKUm9iKzRD?=
 =?utf-8?B?VDQ2cWpESUxSQlI3aXh3Z2pGdWdhZlF2dk5MazBzZHpwMUc4RnlpOTdPS3ZX?=
 =?utf-8?B?Vm9IWmpPUnJlUVJkck41TjFFM0tOWXdjSWozY2ZQOWVINjgyWkZITGFyTUMw?=
 =?utf-8?B?eHFxMnlTQmRNL0xmT0xaUTJlZ21hUzVEVUxmSUgxcDNhV2tDVGxOKzhRbG0v?=
 =?utf-8?B?MGVHeVRhT3RseHlzb0dXY1ZqNVhEd1Z0b3NURlh0NjI0ZDZsblo3VStzNzlY?=
 =?utf-8?B?aEdkMzRtcHBVYU5mZEdLb05TS0VwcXdqZkprZ3daWnpvSFFZWGtZRmFUaVlC?=
 =?utf-8?B?S1hYVlVHeUV0a2hKR0dxamtqZFhDSC9EQ09Qc3hFQTcxVER6cXJnQ1gxdHNi?=
 =?utf-8?B?cFFRU29BblNYZVlQL1NyYW1GUEVBcE4zZFJFRGtmZVBxb1dxdlYzTkM0VUta?=
 =?utf-8?B?eXhHWE5QVmxDTGRrUmhvZDVmWEpvM3BZZkhMd1FPbm9mb2JLTVBPQWM2SEhz?=
 =?utf-8?B?QndxWUdRaTZ4WDFVQkQ5MTgzQzV6ektDN3BBUGRhbDNtY0I0Uzd6ejY4K3ZS?=
 =?utf-8?B?OUZpdzZYbW1sTmVRTS9MRjJOKzAwQU1NM3VHUFdVaHpiWkt5OXl4OGRSZ0VN?=
 =?utf-8?B?MFliRlJlOTVGcjdzellJOFZMaU5VK05Tc3RkM1J3Smhvazl6OEMzMFJ6NU1t?=
 =?utf-8?B?R2NFV2lxaUZMTldQV3d4YXFLa1NXV3JZdkhvWHQ5QzBKY1kwdlhMU1IyUktU?=
 =?utf-8?B?MnRFNVFPeFgxeGtwQS9Cb3gxY0VzNWU2azhtZHRrcWIxNzdjVTg0Z290bzNi?=
 =?utf-8?B?Q29LSTJ3Uk41TnpLRksxd2RrY3hVeTBQeFBFKy9CUE9rR3hlbFhyM1MvSGZa?=
 =?utf-8?B?c1lxeEJrM3ZLc3F1RmMya0Z1dE1NWWg5LzQzYVZBT2ZTNzJ4QXc4QnhtVTU1?=
 =?utf-8?B?SEMvWEFnNWNUcWtIeGg1Zi9qNlUycFJsSWpURmI5a1lhUnFLV0pkNWtkT3Z5?=
 =?utf-8?B?aTFUL2xWYmw3bTJ5MCtwbXZ4c3JSclVIZnNManpFMzdqeFdLakVFZ3VGOTVL?=
 =?utf-8?B?NWRDbmhPNGUwN1IremR1cnBqd0NYTU1obEVkS3IydXJZV1FkTU1vYWdDeXpF?=
 =?utf-8?B?aHFhOVd3ei85ZnJjL0pCaHRlMUdBT2pMb1lTVlN2MDgrSDRDb2FsWDB2em15?=
 =?utf-8?B?M0hLNkxlUGFpQlBMQWR1SHhMUkFGOTNBY2dEQjhYaDRpdjVSWGdVUVY2NFlk?=
 =?utf-8?B?M2FNWDNhVVdIT0Zwb0ZxSUZXZTdYUWtlTTFEbmtoUlJHc3Fjd05yZXRmanhM?=
 =?utf-8?B?SjYzMmEwQjZzL3FHVXdrTUdOcWhZcGdZTzd1RDVZUVc0eTA4cmZNOHprdU95?=
 =?utf-8?B?RG1ZZkNLRWwrdGp5NUtwZHRtK2Jnc3NmVzNPS1NacVdwNFZ1NDhYdUdjZTJE?=
 =?utf-8?B?UGpnRXh0NVZCczFEMk40ZjVvL1JmMFlneE94aUIvL3hkb3ZXTkRXZVhiSW53?=
 =?utf-8?B?Z0tPNWZ2U0hnZTV5cXRMSStsbUd5QUsxbUI5NlM4TkpuQVFJVU5jdnRycUo4?=
 =?utf-8?B?MGw4cGIzc3N0ejQvY0w0aUkwY1gvZ0xROWdpQllTRHU0ZFdJMXVNaWFzV0xZ?=
 =?utf-8?B?VjFqeG5iTTAzaUJxalQ5WmhBb0dkb21YUm9TM3FiQkR1blcwczhrRTJvK29k?=
 =?utf-8?B?dHJUaXl5WTJ4YStvM1M2WURWQmd3cjIya2NDT2hHejQ5SVJNZlFxbmNHSXNw?=
 =?utf-8?B?M2h1V0FPZE5HWHVuY2pJV25XOExCbEp3TER6UE9sb0RnSDUwRlF5QXhyejZl?=
 =?utf-8?B?aFRMSTMwUE9tVUJud1pUa20welhYcURXdnlERXJaK1dzc2JSRnVscXA1aTRF?=
 =?utf-8?B?WFR1Vk1uaENvUHRTbVJXRGJneTNmMysvaDlnbitCTGRtV0N6NWhDSU9DRXAx?=
 =?utf-8?B?SEpNRjVyK0Q5SlZZd0N5cit2eHF4YVl1RGdvSVdESjYzT2U2MndxbDRnR1FI?=
 =?utf-8?Q?bwht1AsD3NfDr8xrsVXYdq0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFC2A57B4A1FCF438171FB327B8C1B00@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3277ff7b-149c-41d3-62a4-08db1a80d5ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 18:14:44.5543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rqVqpbWEJxAmT4SkpyCe7Rkj4BeoZuSOaVqi7DJdor4pVVqHBSfVGu9LA1pbXtC1WkE3mfqiv19936VJmscpEXRf93GWvOhLtqiuplyMxbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5511
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gV2VkLCAyMDIzLTAzLTAxIGF0IDE5OjA2ICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIE1vbiwgRmViIDI3LCAyMDIzIGF0IDAyOjI5OjI0UE0gLTA4MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY2V0LmMgYi9hcmNo
L3g4Ni9rZXJuZWwvY2V0LmMNCj4gPiBpbmRleCA3YWQyMmI3MDViNjQuLmNjMTBkOGJlOWQ3NCAx
MDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY2V0LmMNCj4gPiArKysgYi9hcmNoL3g4
Ni9rZXJuZWwvY2V0LmMNCj4gPiBAQCAtNCwxMCArNCw2IEBADQo+ID4gICAjaW5jbHVkZSA8YXNt
L2J1Z3MuaD4NCj4gPiAgICNpbmNsdWRlIDxhc20vdHJhcHMuaD4NCj4gPiAgIA0KPiA+IC1zdGF0
aWMgX19yb19hZnRlcl9pbml0IGJvb2wgaWJ0X2ZhdGFsID0gdHJ1ZTsNCj4gPiAtDQo+ID4gLWV4
dGVybiB2b2lkIGlidF9zZWxmdGVzdF9pcCh2b2lkKTsgLyogY29kZSBsYWJlbCBkZWZpbmVkIGlu
IGFzbQ0KPiA+IGJlbG93ICovDQo+ID4gLQ0KPiA+ICAgZW51bSBjcF9lcnJvcl9jb2RlIHsNCj4g
PiAgICAgICAgQ1BfRUMgICAgICAgID0gKDEgPDwgMTUpIC0gMSwNCj4gDQo+IEZyb20gYSBwcmV2
aW91cyByZXZpZXc6DQo+IA0KPiAiVGhhdCBsb29rcyBsaWtlIGEgbWFzaywgc28NCj4gDQo+ICAg
ICAgICAgQ1BfRUNfTUFTSw0KPiANCj4gSSBndWVzcy4iDQoNCkl0IGlzIGZyb20gdGhlIGV4aXN0
aW5nIGNvZGU6DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMzkzYTAzZDA2M2RlZTU4
MzFhZjkzY2E2NzYzNmRmNzVhNzY0ODFjMy5jYW1lbEBpbnRlbC5jb20vI3QNCg0KVGhlIHJlbmFt
ZSBjZXJ0YWlubHkgZG9lc24ndCBiZWxvbmcgaW4gdGhlIGNvZGUgbW92ZSBwYXRjaCwgYnV0IEkg
dG9vaw0KdGhlIHByZXZpb3VzIGRpc2N1c3Npb24gdG8gbWVhbiBpdCBkaWRuJ3QgYmVsb25nIGlu
IHRoaXMgcGF0Y2ggZWl0aGVyLg0KRG8geW91IHdhbnQgbWUgdG8gYWRkIGl0IHRvIHRoaXMgb25l
IG9yIGEgc2VwYXJhdGUgb25lPw0K
