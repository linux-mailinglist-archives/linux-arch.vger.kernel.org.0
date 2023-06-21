Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A02739272
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jun 2023 00:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjFUWXI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Jun 2023 18:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjFUWXH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jun 2023 18:23:07 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F1C1733;
        Wed, 21 Jun 2023 15:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687386186; x=1718922186;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PRBRnx9oWxmAY1Hcmdo/jRDUdbT2/AQK1Ijsy8J5PRI=;
  b=m/4Ms7iyThaf/NZ8oJe8XfEkLk0J231a7zR6SOXFA7/LZpFdlGMALUe1
   VWjO+84uHOUZLd4JWv/JPYulw+G9KuVxcH9THQpKLOKOYQpacXA0MZ3fC
   tP3Z09LZEjRRooBhqwClyDgXUpY/gJPMyh9LsKXEDNCai1DbURJ7dUbb0
   jHvOZzpRz1dROcw4KK3mRUB6WnCGbnebZvUrtihcOVgUuNZXgLIWcsjbd
   zdUrIrMohmKDC8/hWLFnXnKdijX3aWMHageVTxFGjc6j3d0X1rdXqs3xR
   zSrZsvXeJW/KTkDfOQn80ojmz97n4o1JGWEbebvWUKa2QMf8+uo4CEYcg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="389936597"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="389936597"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 15:23:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="717832918"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="717832918"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 21 Jun 2023 15:23:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 15:23:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 15:23:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 21 Jun 2023 15:23:02 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 21 Jun 2023 15:23:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqXnjVMcpQC/ZEn7JJVOx6ICDphdEqp2CVReRFU3c5QkMo/dPcXawCfTN1YTYdRfP4YB0VGraAoIvKayu7hTyrNRmMxtf5wbTYd8m4RLGkSB/8fDEryLRP0KmhgC5pNR4YopOKmxKD7uW5mHkUGVGBnWkZzTVgidVgTvYPBWwyufcZ4tck9Cg9/sk7P0/fyoHAPDsDgmeaOi2fMBxUACRMJlUVAFINGDjTHAF41MXdV6VchYHuw8Qdx7JWve+PVENdROBdT4lzBzoX/F1wcr8jsyP2FwYwRu4FXRxCg591R+jqAgfF2PGdcWhj4oQhnVMgO/7dbN2om0aB9rdqUTRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRBRnx9oWxmAY1Hcmdo/jRDUdbT2/AQK1Ijsy8J5PRI=;
 b=WE1e8wBW4g9Nd22L83LnnovjqZ87hkwnt2xCuhyd8gfN0OgL1tCEtARu2TITz3X/jJT30m2KSwKKXixM2cVj+6BoJSHp6K//E9KyoQeGPhCthfz7yJ1NPtPDcZu0vDOYTmzSoEXs7YgMSP9Rro7oWZQWzTxZCOeAiDy7kn95QLwX8CCN0FL7FN25ZsgdaH+senIS89K9HJtl43XHkysucggwt2dGYQcs06mpOUuN90zTK9YzOHPdfHU4vequr+F3qogDCdIu7QF3Wz2RgTsWN6zOTCLflWFwRj7XXAgBDddNpw53ygNd2PjDnMyaSbLV639LQKAuox76ZnM9Vx2mBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA3PR11MB7536.namprd11.prod.outlook.com (2603:10b6:806:320::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 22:22:58 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec%7]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 22:22:58 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>
CC:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
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
Thread-Index: AQHZnYvD++9jHqJtDEOZ5j0eN4/f+6+IoOQAgAALyMOAACwFgIAAIG6AgAAMtoCAACGsAIAA96CAgABofQCAB1K5gIAAhUGAgAEVRoCAAKx+AIABDK+AgAB6bICAADpMAA==
Date:   Wed, 21 Jun 2023 22:22:57 +0000
Message-ID: <5ae619e03ab5bd3189e606e844648f66bfc03b8f.camel@intel.com>
References: <1f04fa59-6ca9-4f18-b138-6c33e164b6c2@sirena.org.uk>
         <49eabafa97032dec8ace7361bccae72c6ecf3860.camel@intel.com>
         <fc2ebfcf-8d91-4f07-a119-2aaec3aa099f@sirena.org.uk>
         <a0f1da840ad21fae99479288f5d74c7ab9095bb6.camel@intel.com>
         <ZImZ6eUxf5DdLYpe@arm.com>
         <64837d2af3ae39bafd025b3141a04f04f4323205.camel@intel.com>
         <ZJAWMSLfSaHOD1+X@arm.com>
         <5794e4024a01e9c25f0951a7386cac69310dbd0f.camel@intel.com>
         <ZJFukYxRbU1MZlQn@arm.com>
         <e676c4878c51ab4b6018c9426b5edacdb95f2168.camel@intel.com>
         <ZJLgp29mM3BLb3xa@arm.com>
         <c5ae83588a7e107beaf858ab04961e70d16fe32c.camel@intel.com>
In-Reply-To: <c5ae83588a7e107beaf858ab04961e70d16fe32c.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA3PR11MB7536:EE_
x-ms-office365-filtering-correlation-id: 6566bb11-54d0-4ee6-58a0-08db72a610e5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dmjnOHuYwT2NTv9NPvPN2B7PZzv75FlW4yiXSgohjZdptaF93dzXdkNrrz0aNHMxQY7LI+wR4Ne8ZcOXbDhZjeTC7rdgzj6i9okbWfogZ3WP7ntgZAeaHT9kn4DsFnXg2VcahHDN5NSxs57DA+lkEJIOxiWt/859Qe9PAgMzqckr3q/IY/n+5DBZEHnhtsDeVHglg3YSf5Y1eFhuMbCjBlB3ftD2czBGdcbaX2XpPSSVcQd26CAABys8dY4iI0ENQWkN0Ji5m4uWBd0KBTqKWikrXTPOwVHe2amV9Ru/s4+yTHsDCzFB2oV2zavfvwaNunlG2pzGLyg8fIMfqC2bIJt18PXOctoPmQaQRdr7FtT1FfyHez4LmBkS9UwI69q+LsvJqUznaGm7ufoeYjfEmyrjrSRkE35CwQNr/odeJp87ho4jLLNu/16t5ojDbkqPYlrCiR7+dj1Epr+bgCA3gsav7ifSNsLNKTVWE/fFgOmFQf8ThphgIDVV/3lxrSXpO2K9HkJ/PBJ+JkZcWzbawzol6c/tjLocqL/KbIEoz6BfvVAS12RHlDmDcee0MDCQvZONosvkUf53G/nSGaPgM6yYgexl2Or9VbPnGjtxuB7sIQSdbVS2R0SLbFYNHDVJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199021)(2906002)(7416002)(7406005)(71200400001)(41300700001)(5660300002)(8676002)(8936002)(316002)(4326008)(66946007)(91956017)(76116006)(66556008)(66446008)(64756008)(66476007)(110136005)(54906003)(478600001)(36756003)(6486002)(86362001)(38100700002)(186003)(122000001)(2616005)(83380400001)(6512007)(82960400001)(26005)(38070700005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDVlZlZtNkxsVlRKS1hpTnVPZ1JvWk1FdXNZN0IxV0drRW1PdVorWjNLZFNC?=
 =?utf-8?B?MUNvaFB3bGhKYktMYnk3MVZKSklNaTZHSmkyeTFTNEErLzFiS1JvcVN1VjhH?=
 =?utf-8?B?TzRwV3M0dHFHa2xnM09YSjVvMTk4RjBoMmx3cXZXTDl5eENoU1phOHRoOWVx?=
 =?utf-8?B?aWpRVnVaVi9hV3JOS0dEZ2hOdU5XU21tRHNJV3N2ZTB2RDdWT3J1Y3F5d05r?=
 =?utf-8?B?WkZHNlZYVmVyaUo4TStZUDIzWEpIRmZJWUltc0wySGxDQ3dJMm03azRRcWV2?=
 =?utf-8?B?QjZQbHlER2xaUXhvN3hRZjMxeXJXRG1JeXdqcFRtVjMxTnVZSElIVld3cTBI?=
 =?utf-8?B?UVM2dVgrZk1RWkhwcjdyREEyMFBDMnV4RFQ2b2ZpcGdieGozWVc5bFpFTmQ1?=
 =?utf-8?B?N05VSlkxMEZ4M01XQ1p5eE1CalBidWJxTXNGOUUyc3poM0JBdFd6aStaOWhL?=
 =?utf-8?B?elFDaFA1MlZZZ0N2eEZiTmZhbk5nMk96TFBMaTl2SmlOOTVvVGNZdDdaRm5P?=
 =?utf-8?B?VDkvMmpHSGl6K1dMWDJkMEFYbnR1OWRYTlNxSGlva2tyQlkrNnV0SlBSL3M3?=
 =?utf-8?B?VmxWUXZmeEZxVU5SYUFaREtqaVBjR3plTHFqSkMzM1Y2alpOSlBqb1RMY3Ar?=
 =?utf-8?B?RzVIOWNoUjg3dHM0a3VMVlFmc0QwT09iWEFVWllQMVFJNHBad0hOUGVTT3Vy?=
 =?utf-8?B?eWlhbWlXQTZiQ1phOVJPN0ZPVmZQVUZGUnZwQmJyRlV6YjN6bkxBSzNpNmcy?=
 =?utf-8?B?VkVjYzQ2a203YlBJSXVJYjIzSndaeW9uaVlaR0l4U3N4dlk2TjhncS9UcmJY?=
 =?utf-8?B?OFZzWVBLVmd1T3FVWTJ4SGthdFREcUtldk83Q0RGSjJMZEJtbFVJUTRFbXRk?=
 =?utf-8?B?ejFGNi80Uk5xL3BoTzRFdlZSbWY0UTNMV3FaclNwQ3dtdE1xaUJtb3h5WkxO?=
 =?utf-8?B?a3B2VjV4THUzNjdiUWtsOVo3MHAxZGh2NVExeTBxTmR2TXFFOEdxU0pkNFRp?=
 =?utf-8?B?WG10T1ZtQ0RERlVyM1YzUVdJM1NwZzR0Y255T2Fhak14bHk0VS9EWkIwenpV?=
 =?utf-8?B?YmQ0cExKV3I3VXNVaVJlSmM2QitlbWkyb016a0dJM1ZvbXBlTEdtOXFySmkx?=
 =?utf-8?B?bUNCcU56UWMwdXVBMDdySHdNOGhrT1NQUkRsRTh3Y0JSREZRRldTcjE5UEpP?=
 =?utf-8?B?S01JMVFYeDBTckpOTkFoc21IaU1sYklkeTVLaHl0SjY5NG9kOFJFa1NrNzBw?=
 =?utf-8?B?TGFlOEpPSWd0ZmhsV2dUajIrREhiWURKdEZCZG9XWHdsWUNjN0hweXJSZXJU?=
 =?utf-8?B?NE0wS002Y1lBeFZscUFqTmJIemNmMjE2ako2OU9uWFNDbHZuTU9kcHFXQ1ZF?=
 =?utf-8?B?Y000UTcyVWdrNDVCN1o2UnQ4Y3dGbjRUbmdXWHczWmVnanZlZnliblZkZmhI?=
 =?utf-8?B?YmJpZVplTjRSc0JoQjlFU2pLRW1xT2V4cUhsbUtPdzRXVUlVeG5nZ21TcCty?=
 =?utf-8?B?MVA5S2hrVEZPUWsweDY0MnA3elNmWGdiMzkzQlVUa3hJbUVURWVMUzQ1a3dD?=
 =?utf-8?B?cmZ3R3RTRW0rMXFTZUNOeUxaYUt3RUdNQnJoZWU0Mld0WE5aaXd0TURpRTNO?=
 =?utf-8?B?VklreWRsSU00OE5yR2JYRVBHemVjK282dmRUaW81RC9jNW4rSnZmRWRZaXZS?=
 =?utf-8?B?Y1pwRDBzQU9JTWkrVGNjL2NWdHdXOWdIRTNZY3pIQmFObWs0dGsyUGVjbk9v?=
 =?utf-8?B?Wkw0WXJKT3lBVmhRYlBOMUx0NWpwT1ozT1dwa0FsV0VIT0RqUWR6YmpYTlhC?=
 =?utf-8?B?UG5lUUpSNDRMTVNFc250UmhNZDNPSkU1Ykh2RkZuTVBDbEVFSW41STMyeTZZ?=
 =?utf-8?B?bm9IRkVodWdVUmsyMWFYMlc2cmlXSllSN1NxeHlGZitLTDc0ZE9tZjF0cU1W?=
 =?utf-8?B?TzFxTmpqMXFNQlZIZXZYUkJ5Z29nL2lqSmF6VEgxbEJlZU9ZcTNvZFpBc0hM?=
 =?utf-8?B?Ti9OVlFIM3AzcGNxa0VwcS9Sb0lXV0ZIbzduRmo5WTh0Vmg3YnlyVHQzVUxy?=
 =?utf-8?B?RGlFZkdySHVIU2xLL3RIYnFMYXRYeW5qOVBRd3JHdTlDV0RVZkp0Y3p3SEQ4?=
 =?utf-8?B?ZnFDcno1MTQ0UGg3NE1XNkJQNTJ1TUhmZDNHbmRMaVlpYnlqR2o4NEM1UUdY?=
 =?utf-8?B?cFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B27175E2FAD6B4089CC13BCDD6F5B3B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6566bb11-54d0-4ee6-58a0-08db72a610e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 22:22:57.6429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 42iLF/VxZnpWTFEKILBtnzdBvHEOaphpjWIQ4K9WMiY+mvRbRMgX4xDGU8+eY6iTccWh9ZcRGqQSv25eH0Gu04wbNQBHNDcFLxZyoPzE60s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7536
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

T24gV2VkLCAyMDIzLTA2LTIxIGF0IDExOjU0IC0wNzAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gPiA+ID4gPiA+ID4gdGhlcmUgaXMgbm8gbWFnaWMsIGxvbmdqbXAgc2hvdWxkIGJlIGltcGxl
bWVudGVkIGFzOg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDC
oHRhcmdldF9zc3AgPSByZWFkIGZyb20gam1wYnVmOw0KPiA+ID4gPiA+ID4gPiDCoMKgwqDCoMKg
wqDCoMKgY3VycmVudF9zc3AgPSByZWFkIHNzcDsNCj4gPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoGZvciAocCA9IHRhcmdldF9zc3A7IHAgIT0gY3VycmVudF9zc3A7IHAtLSkgew0KPiA+ID4g
PiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICgqcCA9PSByZXN0b3Jl
LXRva2VuKSB7DQo+ID4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoC8vIHRhcmdldF9zc3AgaXMgb24gYSBkaWZmZXJlbnQNCj4gPiA+ID4g
PiA+ID4gc2hzdGsuDQo+ID4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHN3aXRjaF9zaHN0a190byhwKTsNCj4gPiA+ID4gPiA+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnJlYWs7DQo+ID4g
PiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQ0KPiA+ID4gPiA+ID4g
PiDCoMKgwqDCoMKgwqDCoMKgfQ0KPiA+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgZm9yICg7
IHAgIT0gdGFyZ2V0X3NzcDsgcCsrKQ0KPiA+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoC8vIHNzcCBpcyBub3cgb24gdGhlIHNhbWUgc2hzdGsgYXMNCj4gPiA+ID4g
PiA+ID4gdGFyZ2V0Lg0KPiA+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGluY19zc3AoKTsNCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IHRoaXMgaXMgd2hh
dCBzZXRjb250ZXh0IGlzIGRvaW5nIGFuZCBsb25nam1wIGNhbiBkbyB0aGUNCj4gPiA+ID4gPiA+
ID4gc2FtZToNCj4gPiA+ID4gPiA+ID4gZm9yIHByb2dyYW1zIHRoYXQgYWx3YXlzIGxvbmdqbXAg
d2l0aGluIHRoZSBzYW1lIHNoc3RrDQo+ID4gPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+ID4gPiBm
aXJzdA0KPiA+ID4gPiA+ID4gPiBsb29wIGlzIGp1c3QgcCA9IGN1cnJlbnRfc3NwLCBidXQgaXQg
YWxzbyB3b3JrcyB3aGVuDQo+ID4gPiA+ID4gPiA+IGxvbmdqbXANCj4gPiA+ID4gPiA+ID4gdGFy
Z2V0IGlzIG9uIGEgZGlmZmVyZW50IHNoc3RrIGFzc3VtaW5nIG5vdGhpbmcgaXMNCj4gPiA+ID4g
PiA+ID4gcnVubmluZw0KPiA+ID4gPiA+ID4gPiBvbg0KPiA+ID4gPiA+ID4gPiB0aGF0IHNoc3Rr
LCB3aGljaCBpcyBvbmx5IHBvc3NpYmxlIGlmIHRoZXJlIGlzIGEgcmVzdG9yZQ0KPiA+ID4gPiA+
ID4gPiB0b2tlbg0KPiA+ID4gPiA+ID4gPiBvbiB0b3AuDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4g
PiA+ID4gPiB0aGlzIGltcGxpZXMgaWYgdGhlIGtlcm5lbCBzd2l0Y2hlcyBzaHN0ayBvbiBzaWdu
YWwgZW50cnkNCj4gPiA+ID4gPiA+ID4gaXQgaGFzDQo+ID4gPiA+ID4gPiA+IHRvIGFkZCBhIHJl
c3RvcmUtdG9rZW4gb24gdGhlIHN3aXRjaGVkIGF3YXkgc2hzdGsuDQoNCldhaXQgYSBzZWNvbmQs
IHRoZSBjbGFpbSBpcyB0aGF0IHRoZSBrZXJuZWwgc2hvdWxkIGFkZCBhIHJlc3RvcmUgdG9rZW4N
Cm9uIHRoZSBjdXJyZW50IHNoYWRvdyBzdGFjayBiZWZvcmUgaGFuZGxpbmcgYSBzaWduYWwsIHRv
IGFsbG93IHRvDQp1bndpbmQgZnJvbSBhbiBhbHQgc2hhZG93IHN0YWNrLCByaWdodD8gQnV0IGlu
IHRoaXMgc2VyaWVzIHRoZXJlIGlzIG5vdA0KYW4gYWx0IHNoYWRvdyBzdGFjaywgc28gc2lnbmFs
IHdpbGwgYmUgaGFuZGxlZCBvbiB0aGUgY3VycmVudCBzaGFkb3cNCnN0YWNrLiBJZiB0aGUgdXNl
ciBzdGF5cyBvbiB0aGUgY3VycmVudCBzaGFkb3cgc3RhY2ssIHRoZSBleGlzdGluZw0Kc2ltcGxl
IElOQ1NTUCBiYXNlZCBzb2x1dGlvbiB3aWxsIHdvcmsuDQoNCklmIHRoZSB1c2VyIHN3YXBjb250
ZXh0KCkncyBhd2F5IHdoaWxlIGhhbmRsaW5nIGEgc2lnbmFsICh3aGljaCAqaXMqDQpjdXJyZW50
bHkgc3VwcG9ydGVkKSB0aGV5IHdpbGwgbGVhdmUgdGhlaXIgb3duIHJlc3RvcmUgdG9rZW4gb24g
dGhlIG9sZA0Kc3RhY2suIEh5cG90aGV0aWNhbGx5IGdsaWJjIGNvdWxkIHVud2luZCBiYWNrIHRo
cm91Z2ggYSBzZXJpZXMgb2YNCnVjb250ZXh0IHN0YWNrcyBieSBwaXZvdGluZywgaWYgaXQga2Vw
dCBzb21lIG1ldGFkYXRhIHNvbWV3aGVyZSBhYm91dA0Kd2hlcmUgdG8gcmVzdG9yZSB0by4gU28g
dGhlcmUgYXJlIGFjdHVhbGx5IGFscmVhZHkgZW5vdWdoIHRva2VucyB0bw0KbWFrZSBpdCBiYWNr
IGluIHRoaXMgY2FzZSwgZ2xpYmMganVzdCBkb2Vzbid0IGRvIHRoaXMuDQoNCkJ1dCBob3cgZG9l
cyB0aGUgcHJvcG9zZWQgdG9rZW4gcGxhY2VkIGJ5IHRoZSBrZXJuZWwgb24gdGhlIG9yaWdpbmFs
DQpzdGFjayBoZWxwIHRoaXMgcHJvYmxlbT8gVGhlIGxvbmdqbXAoKSB3b3VsZCBoYXZlIHRvIGJl
IGFibGUgdG8gZmluZA0KdGhlIGxvY2F0aW9uIG9mIHRoZSByZXN0b3JlIHRva2VucyBzb21laG93
LCB3aGljaCB3b3VsZCBub3QgbmVjZXNzYXJpbHkNCmJlIG5lYXIgdGhlIHNldGptcCgpIHBvaW50
LiBUaGUgc2lnbmFsIHRva2VuIGNvdWxkIGV2ZW4gYmUgb24gYQ0KZGlmZmVyZW50IHNoYWRvdyBz
dGFjay4NCg0KU28gSSB0aGluayB0aGUgYWJvdmUgaXMgc2hvcnQgb2YgYSBkZXNpZ24gZm9yIGEg
dW5pdmVyc2FsbHkgY29tcGF0aWJsZQ0KbG9uZ2ptcCgpLg0KDQpXaGljaCBtYWtlcyBtZSB0aGlu
ayBpZiB3ZSBkaWQgd2FudCB0byBtYWtlIGEgbW9yZSBjb21wYXRpYmxlIGxvbmdqbXAoKQ0KYSBi
ZXR0ZXIgdGhlIHdheSB0byBkbyBpdCBtaWdodCBiZSBhbiBhcmNoX3ByY3RsIHRoYXQgZW1pdHMg
YSB0b2tlbiBhdA0KdGhlIGN1cnJlbnQgU1NQLiBUaGlzIHdvdWxkIGJlIGxvb3NlbmluZyB1cCB0
aGUgc2VjdXJpdHkgc29tZXdoYXQgKGhhdmUNCnRvIGJlIGFuIG9wdC1pbiksIGJ1dCBsZXNzIHNv
IHRoZW4gZW5hYmxpbmcgV1JTUy4gQnV0IGl0IHdvdWxkIGFsc28gYmUNCndheSBzaW1wbGVyLCB3
b3JrIGZvciBhbGwgY2FzZXMgKEkgdGhpbmspLCBhbmQgYmUgZmFzdGVyIChtYXliZT8pIHRoYW4N
CklOQ1NTUGluZyB0aHJvdWdoIGEgYnVuY2ggb2Ygc3RhY2tzLg0KDQpJJ20gYWxzbyBub3Qgc3Vy
ZSBsZWF2aW5nIGEgdG9rZW4gb24gc2lnbmFsIGRvZXNuJ3Qgd2Vha2VuIHRoZSBzZWN1cml0eQ0K
aXQgaXQncyBvd24gd2F5IGFzIHdlbGwuIEFueSB0aHJlYWQgY291bGQgdGhlbiBzd2FwIHRvIHRo
YXQgdG9rZW4uDQpXaGVyZSBhcyB0aGUgc2hhZG93IHN0YWNrIHNpZ25hbCBmcmFtZSBzc3AgcG9p
bnRlciBjYW4gb25seSBiZSB1c2VkDQpmcm9tIHRoZSBzaGFkb3cgc3RhY2sgdGhlIHNpZ25hbCB3
YXMgaGFuZGxlZCBvbi4NCg0KU28gSSB0aGluaywgaW4gYWRkaXRpb24gdG8gYmxvY2tpbmcgdGhl
IHNoYWRvdyBzdGFjayBvdmVyZmxvdyB1c2UgY2FzZQ0KaW4gdGhlIGZ1dHVyZSwgbGVhdmluZyBh
IHRva2VuIGJlaGluZCBvbiBzaWduYWwgd2lsbCBub3QgcmVhbGx5IGhlbHANCmxvbmdqbXAoKS4g
KG9yIGF0IGxlYXN0IEknbSBub3QgZm9sbG93aW5nKQ0KDQo=
