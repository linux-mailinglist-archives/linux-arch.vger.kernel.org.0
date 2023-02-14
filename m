Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB6B696CBE
	for <lists+linux-arch@lfdr.de>; Tue, 14 Feb 2023 19:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjBNSYh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Feb 2023 13:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjBNSYg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Feb 2023 13:24:36 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256242BF12;
        Tue, 14 Feb 2023 10:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676399074; x=1707935074;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Wj4R/snFc+rjqhKVqSfhODl1DPJTIY7UyHZ56R2fk+g=;
  b=ejDAfvoyz8qdC7Izi0Z/YDycJMqG58rQBS+ONu7YsNiiRsNIgRIfJvVG
   ztwcmPlFmsJZSjvttXTEAonWgdKmniAbe79dh6Fe+TNTGoCNA8AhHKX48
   Vk0DiEcDMWZvAubrGd3MTCQMApjF/pgkvdEcGmzcxvsBZwmLD33lyGcw5
   B1FvhAu4vIUaOMzezVABKFSlj1zSau8crURDnjGuPHHieQ5uV/e7XIOQV
   bvzI90lIW8zoRq0uaW+ClTNfh0CsCMBrPmoWAl6W5jTzphVknlRLFP6nV
   surkUzjTPRhfwM9/t5qWiYEgNtWxZlebw3KCOki3HS0MCmMRdrMCgIX4t
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="358647426"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="358647426"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 10:24:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="619150006"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="619150006"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 14 Feb 2023 10:24:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 10:24:15 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 10:24:14 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 10:24:14 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 10:24:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhT1O5Y4BSg/A5RfHlp6OmjJtdFbqn3kOHF1TplUBJSKIzyDbKik91ajr9/wcwNnYS8fC3BxFLu6yzy5AEque7spUP1kcDNxmMWnjkkhFAApFOt7LOfeCT7XNRoaH7EZUrV/z79of/ef/dPphY5tb2dfV5VyBikYPUbp078E6HEW5aocyZLqMFFSEI+8c1uOqvxGiYmBQnj9SCP4Iqy00IDgm0oh4zWy4IgNC+vyJItxzqPEx7ZNAtPrdSCJ+8ouZ45a8cLwjYR/G+hDGgu4QNI/V6fipwJAz8VWKSkvVq1NbU4C87mL+hACxRju/s3M1K4zn13Msi2SU+v+aZICIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wj4R/snFc+rjqhKVqSfhODl1DPJTIY7UyHZ56R2fk+g=;
 b=j7EqirZCxQW5SbdAEBfsb3ShopgFNCA0OL4L8X+E4Z3RF1Cs/BJgMIPIK/jQLIWPN0kgTZOCC08nJY+K6nkLui4hCijGPEt+2kt5jHpt/I58aRpGklNm3h69HinlkiutVDEyxH+9JZGZO5+owCVxBKAXyUQ5vZiQ4kqYaWevnCYoDZ0B6DeHfTcsCNRWcQz2mtBfsCC9fWgbhW6F1LhnjRLbnkf2ZmZpaZbtr4rLwGRL89/LFWFT1QIEtxQ4RGiqObaJVIAtZkYmaE2u2+NS5ZVUmUfblomaql+jEkACxPFl0ZbB6O1RDD4/zz/es8XoPPwpIWLls0txIR9jPMqSSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CO1PR11MB4801.namprd11.prod.outlook.com (2603:10b6:303:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 18:24:08 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 18:24:08 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "debug@rivosinc.com" <debug@rivosinc.com>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
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
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v5 19/39] mm: Fixup places that call pte_mkwrite()
 directly
Thread-Topic: [PATCH v5 19/39] mm: Fixup places that call pte_mkwrite()
 directly
Thread-Index: AQHZLExhHYeOx8u1uE+GSfMVtoENIa7NuLKAgAAQGICAAFSVgIAAzRSA
Date:   Tue, 14 Feb 2023 18:24:08 +0000
Message-ID: <9ea047ed05d75822991325b709f583ee10b0fa34.camel@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
         <20230119212317.8324-20-rick.p.edgecombe@intel.com>
         <20230214000947.GB4016181@debug.ba.rivosinc.com>
         <1dd1c61c69739fde6db445df79ebbbbec0efe8cd.camel@intel.com>
         <20230214061007.GC4016181@debug.ba.rivosinc.com>
In-Reply-To: <20230214061007.GC4016181@debug.ba.rivosinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|CO1PR11MB4801:EE_
x-ms-office365-filtering-correlation-id: 35d23e12-b3d4-4a78-7c9a-08db0eb8a983
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xyOfnCP4ggNF6N/RdJZblSgGWTlwAcggSy7tZEaHRivR8XvkW2bnsKMd6gzrJC80hpPvm+XGQb3jq/HZKUfhJxINrI+dnQcoRJijWx3vg8wQbmLjYL63y8YHxYQVg/ID8l9L0DmvpcrmXu6AMY3g13VECNPwgsqgqpl2SIEDzxvpfW+HL87Iqk78hsXorUB606m53hXdWP+qKMQLhFrP2zWwIrU4d8B1FbfZBAKPGRz/LucEnBOAF65rBNt4KHkbXFeCwWYbajmvGf3t8M1v9liUHWhRE7zdF6TgvLStgjGCikxmnhZUmtraX92X8kz6ViHLoVw/gAFdLBmIbsk8tJz3r/RtadEU7s/MY/xOXN2ZcqEBOnNmtKn7S/1tKi9IDIjA+u7obJZGX1pKIsp23sF1oySnOPEbOQLibeIWtoJ5Jbf/ydtB46UnJcBdZ1JntGIwqtcKI+PcF404kOM5vMwfPy6SPmHoWAvEynngn5ztfmRQphaIFa8L50j4rGLXWvQzJbpv/9l05Ycf1zMdHWQZNlsYhrwvVwOKSRhxpn8MU0mMWJBXJAtGnSvl4O2ztVzYGqILyQWE97iSL/CriHKOiFNTSbtxZoOcW2GDyJa6J8/lGdXT5aweXP7CT6ZztUL53//fzG8WS0kttdouH2COd3oy0bCnalU6UcRr0F3aMHAg25QQrc9JCVzY5ufWIOzWfoPUkEs4z0Va11vDU8Kiyr6iYupkku/yk5MGJmGNhIoPB+cP/ylSQeoKF2yl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(136003)(396003)(366004)(39860400002)(451199018)(2906002)(36756003)(7416002)(7406005)(5660300002)(6512007)(83380400001)(26005)(186003)(38070700005)(6506007)(2616005)(66476007)(122000001)(82960400001)(38100700002)(4326008)(6916009)(8676002)(64756008)(54906003)(66446008)(316002)(8936002)(66556008)(76116006)(478600001)(86362001)(966005)(71200400001)(66946007)(6486002)(41300700001)(66899018)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnZUQm4xRGFrT1dYR0R6K04rSUNYUHlSTHBNMC9NM1BWTUh3WUZvTUI4YVVk?=
 =?utf-8?B?NjNOck53dHpXRDZPZDFVUzhRWXR4cUk1ZWtlamdUcHlJdXUzcTVSZHUrSDRB?=
 =?utf-8?B?Y0E2U3BBa2VsdEIyKzc0L3VFUjY3clg1YS9VRGFXWFZrNmRFYUVaR3luNndY?=
 =?utf-8?B?MHRyVUhNTlZLc1U2Qm1uMEVIVWR3Z1F1ZzZ2Y1V1b21FckpYZ3cyNFVNeCtF?=
 =?utf-8?B?cVltM0kwQVVMQUVYZjlreUxJL1dYc0lBdUxNVitsTjIyb05LSTB3VzhBN3Bu?=
 =?utf-8?B?cGgrTjFQTWpQQmNwRmpydHgzNjhxanNSVXJ0cnNuR3JzdUw2TU5Od25zbDhC?=
 =?utf-8?B?RTZ4Z1p5MnY4Zlo5Y1BEc1JodXc4Y3JVWE9qT3c3bFBUL3diNE0zeEE1R1lr?=
 =?utf-8?B?RDdQNE1wZXRxM0JPMlU3TEVPVkcyTkRSVlVsVThZMjUrN0VXQjk3RlMyTDFk?=
 =?utf-8?B?RVJEN0h4VG1aNlE1VlFLRHg2dDNvM1hWN2w0Yk9PSENFYzlwN2FqZVJkaFhX?=
 =?utf-8?B?K21KRzZTWDhYajZjYWRGWmJMZTZnYlRIdVBzeGg2eTJ5TU1UM2NBc3JQN2Yw?=
 =?utf-8?B?LzMvam10Y0FtN0J3OUFWNGRweU1rMjR3WG5reFhLWTZwU1hDLytSUDZrWmtw?=
 =?utf-8?B?bE9ZMy9yNEsyUmM2NnNXdHJSL2I4UXdJOXRIWFhyT0FaQUFrb3dLcVpJY2JT?=
 =?utf-8?B?TzV6TmpXYWFsdFdXc3dJOFBkY0o2VTU4U2l4UkFHaW5pNWp1TTJLYWUvK2lx?=
 =?utf-8?B?WnRHQ1o2SUNWWHRJc2pNSWVsRzBTa0xFTS9DNVhsZVpUYjFLSUZJRGM2bDVy?=
 =?utf-8?B?ZEZoa0pqYTlDSURlZWVUT0tKL3NQVWRFQ0NFNXBwNldUaHFYSC9IWGdQLzNi?=
 =?utf-8?B?dytGN3U1ZTlFeCtNSEcxQm92b1NyMzdsdnZQK0JnUi96MDlEdDRTelRDUGFu?=
 =?utf-8?B?a3lZRURXSWV3ZXlrQnJLZGJFNC9IcWpFQmhWQXNqUTM3UUxaeitGNHBpUVNj?=
 =?utf-8?B?M2lFVW1mRkhOY0lFWDIzVUtaUktMRTZIY054QmNCQlhlbXNLVVhCV0U4OCsz?=
 =?utf-8?B?dHpjUkdzQStJSFArYnowdmhlSm1GTlNqcHJpNms2MUs1UE5iSmFyUEY1SmxY?=
 =?utf-8?B?d3Y3WUphM3RCa3RselFCNlhhRzZBOE5IMVVYcnpHZTgwUTNVTTU0ZWs4WWpI?=
 =?utf-8?B?T0UvT1pFWGJrTmowdWxqU2FWVDg4Z2N2ZnFxd0VLWVZLV2dRMUxOZ0VBSldJ?=
 =?utf-8?B?NmZnajNBdW1iS1FRcWZoLzQ0YW5vZENJZStvc0M3T1lCM3ZWK3FHZ08zamM0?=
 =?utf-8?B?SjJCdlJJQjJNWHhpNGNnMmsrT2YzRjFzRTloSGFoVEJzdmtwSFFBMCt0cGJr?=
 =?utf-8?B?WkZPRjN5dTlXaVdmc0JmMnRZMVJJM3MxZEs3OEpRbjB0My9XUFc4UlJZQkw2?=
 =?utf-8?B?NVRodE5ySStlVDVaU3pieWRveVRoSjhGNDF3akFOWjlhVUd3VkdhR3p3Y0g2?=
 =?utf-8?B?ZzkwWVFLeFpHSVptS21NU2NWaWdNb2paWUQxTEcwcWo1VEpoVmpoRjlVYTFI?=
 =?utf-8?B?Tkt0UG9wOUNRNEhNMkRtaW4yczV4bVdPVDVJcDNocU5ZdWZqd3p1dzhSdjdy?=
 =?utf-8?B?QWJJNHVYWngrUXhvR0JVZ3VOc0pvSDJuQnRpdmluZXkyWjF1aVlyYmVqd2FY?=
 =?utf-8?B?bG5EN1luWUJ1d29GR0Q2RGpLSHJXKzFXMkpRVDg1dVl0RWduWTZpRUJqMXlm?=
 =?utf-8?B?OFFjN3dpL3dJYlowSEdUR1luTlA3azZlTzFBUE9jUDNUczhXb2lRUjB3eThO?=
 =?utf-8?B?aXNLOE5haFZpdmNwNENDWDRNWFo0NUFMTFV4M2U1VmZTdEVJTEl1WnRsZHhB?=
 =?utf-8?B?VlZiTGZXdjRLQS9UcDhRQjUwTFNGR2pWSXV5QXY4d2h5ZlZVZkFybm1MMGEz?=
 =?utf-8?B?alBJNTFlY095a3dtaStBeklDSllnbFp0SytRUVBwY1NjOEtGa1BEdmh6M2ho?=
 =?utf-8?B?eTQ5ZEo5NzhUaTBiMWQyV09oRHgvWEJVYmdqanh5d0I5bllKVENLV0JaQjYr?=
 =?utf-8?B?bnhaQUFFQVg2U2toNEJGV1JBS2g5SGFPbWRNOEJqMHRXWVV6dDhNQnA2T2JR?=
 =?utf-8?B?QkdjSUI3QkZ0WnBsbVlIMmZBOHlqVlhMN2pjbmNjK3kyeVdBNXR3VFQzQklQ?=
 =?utf-8?Q?95UMfzAObYLcjf0ZgSiQJyA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C47B18FDF6CF4F48828285681367699C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d23e12-b3d4-4a78-7c9a-08db0eb8a983
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 18:24:08.3482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I2N9JmgcIA1jMsuh46HKWQtJSYtDEMXpy7vTRTtFgOGgLEb74bcPPaF7+IhFZDx1Yz8bwQd2yBkVg8O7d7VpWsyrlWngDa6ZwLChxMHCWsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4801
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIzLTAyLTEzIGF0IDIyOjEwIC0wODAwLCBEZWVwYWsgR3VwdGEgd3JvdGU6DQo+
IE9uIFR1ZSwgRmViIDE0LCAyMDIzIGF0IDAxOjA3OjI0QU0gKzAwMDAsIEVkZ2Vjb21iZSwgUmlj
ayBQIHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAyMy0wMi0xMyBhdCAxNjowOSAtMDgwMCwgRGVlcGFr
IEd1cHRhIHdyb3RlOg0KPiA+ID4gU2luY2UgSSd2ZSBhIGdlbmVyYWwgcXVlc3Rpb24gb24gb3V0
Y29tZSBvZiBkaXNjdXNzaW9uIG9mIGhvdyB0bw0KPiA+ID4gaGFuZGxlDQo+ID4gPiBgcHRlX21r
d3JpdGVgLCBzbyBJIGFtIHRvcCBwb3N0aW5nLg0KPiA+ID4gDQo+ID4gPiBJIGhhdmUgcG9zdGVk
IHBhdGNoZXMgeWVzdGVyZGF5IHRhcmdldGluZyByaXNjdiB6aXNzbHBjZmkNCj4gPiA+IGV4dGVu
c2lvbi4NCj4gPiA+IA0KPiA+IA0KPiA+IA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8y
MDIzMDIxMzA0NTM1MS4zOTQ1ODI0LTEtZGVidWdAcml2b3NpbmMuY29tLw0KPiA+ID4gDQo+ID4g
PiBTaW5jZSB0aGVyZSdyZSBzaW1pbGFyaXRpZXMgaW4gZXh0ZW5zaW9uKHMpLCBwYXRjaGVzIGhh
dmUNCj4gPiA+IHNpbWlsYXJpdHkNCj4gPiA+IHRvby4NCj4gPiA+IE9uZSBvZiB0aGUgc2ltaWxh
cml0eSB3YXMgdXBkYXRpbmcgYG1heWJlX21rd3JpdGVgLiBJIHdhcyBhc2tlZA0KPiA+ID4gKGJ5
DQo+ID4gPiBkaGlsZGVuYg0KPiA+ID4gb24gbXkgcGF0Y2ggIzExKSB0byBsb29rIGF0IHg4NiBh
cHByb2FjaCBvbiBob3cgdG8gYXBwcm9hY2ggdGhpcw0KPiA+ID4gc28NCj4gPiA+IHRoYXQNCj4g
PiA+IGNvcmUtbW0gYXBwcm9hY2ggZml0cyBtdWx0aXBsZSBhcmNoaXRlY3R1cmVzIGFsb25nIHdp
dGggdGhlIG5lZWQNCj4gPiA+IHRvDQo+ID4gPiB1cGRhdGUgYHB0ZV9ta3dyaXRlYCB0byBjb25z
dW1lIHZtYSBmbGFncy4NCj4gPiA+IEluIHg4NiBDRVQgcGF0Y2ggc2VyaWVzLCBJIHNlZSB0aGF0
IGxvY2F0aW9ucyB3aGVyZSBgcHRlX21rd3JpdGVgDQo+ID4gPiBpcw0KPiA+ID4gaW52b2tlZCBh
cmUgdXBkYXRlZCB0byBjaGVjayBmb3Igc2hhZG93IHN0YWNrIHZtYSBhbmQgbm90DQo+ID4gPiBu
ZWNlc3NhcmlseQ0KPiA+ID4gYHB0ZV9ta3dyaXRlYCBpdHNlbGYgaXMgdXBkYXRlZCB0byBjb25z
dW1lIHZtYSBmbGFncy4gTGV0IG1lIGtub3cNCj4gPiA+IGlmDQo+ID4gPiBteQ0KPiA+ID4gdW5k
ZXJzdGFuZGluZyBpcyBjb3JyZWN0IGFuZCB0aGF0J3MgdGhlIGN1cnJlbnQgZGlyZWN0aW9uICh0
bw0KPiA+ID4gdXBkYXRlDQo+ID4gPiBjYWxsIHNpdGVzIGZvciB2bWEgY2hlY2sgd2hlcmUgYHB0
ZV9ta3dyaXRlYCBpcyBpbnZva2VkKQ0KPiA+ID4gDQo+ID4gPiBCZWluZyBzYWlkIHRoYXQgYXMg
SSd2ZSBtZW50aW9uZWQgaW4gbXkgcGF0Y2ggc2VyaWVzIHRoYXQNCj4gPiA+IHRoZXJlJ3JlDQo+
ID4gPiBzaW1pbGFyaXRpZXMgYmV0d2VlbiB4ODYsIGFybSBhbmQgbm93IHJpc2N2IGZvciBpbXBs
ZW1lbnRpbmcNCj4gPiA+IHNoYWRvdw0KPiA+ID4gc3RhY2sNCj4gPiA+IGFuZCBpbmRpcmVjdCBi
cmFuY2ggdHJhY2tpbmcsIG92ZXJhbGwgaXQnbGwgYmUgYSBnb29kIHRoaW5nIGlmIHdlDQo+ID4g
PiBjYW4NCj4gPiA+IGNvbGxhYm9yYXRlIGFuZCBjb21lIHVwIHdpdGggY29tbW9uIGJpdHMuDQo+
ID4gDQo+ID4gT2ggaW50ZXJlc3RpbmcuIEkndmUgbWFkZSB0aGUgY2hhbmdlcyB0byBoYXZlIHB0
ZV9ta3dyaXRlKCkgdGFrZSBhDQo+ID4gVk1BLg0KPiA+IEl0IHNlZW1zIHRvIHdvcmsgcHJldHR5
IHdlbGwgd2l0aCB0aGUgY29yZSBNTSBjb2RlLCBidXQgSSdtIGxldHRpbmcNCj4gPiAwLQ0KPiA+
IGRheSBjaGV3IG9uIGl0IGZvciBhIGJpdCBiZWNhdXNlIGl0IHRvdWNoZWQgc28gbWFueSBhcmNo
J3MuIEknbGwNCj4gPiBpbmNsdWRlIHlvdSB3aGVuIEkgc2VuZCBpdCBvdXQsIGhvcGVmdWxseSBs
YXRlciB0aGlzIHdlZWsuDQo+IA0KPiBUaGFua3MuDQo+ID4gDQo+ID4gRnJvbSBqdXN0IGEgcXVp
Y2sgbG9vaywgSSBzZWUgc29tZSBkZXNpZ24gYXNwZWN0cyB0aGF0IGhhdmUgYmVlbg0KPiA+IHBy
b2JsZW1hdGljIG9uIHRoZSB4ODYgaW1wbGVtZW50YXRpb24uDQo+ID4gDQo+ID4gVGhlcmUgd2Fz
IHNvbWV0aGluZyBsaWtlIFBST1RfU0hBRE9XX1NUQUNLIGJlZm9yZSwgYnV0IHRoZXJlIHdlcmUN
Cj4gPiB0d28NCj4gPiBwcm9ibGVtczoNCj4gPiAxLiBXcml0YWJsZSB3aW5kb3dzIHdoaWxlIHBy
b3Zpc2lvbmluZyByZXN0b3JlIHRva2VucyAobWF5YmUgdGhpcw0KPiA+IGlzDQo+ID4ganVzdCBh
biB4ODYgdGhpbmcpDQo+ID4gMi4gQWRkaW5nIGd1YXJkIHBhZ2VzIHdoZW4gYSBzaGFkb3cgc3Rh
Y2sgd2FzIG1wcm90ZWN0KCllZCB0bw0KPiA+IGNoYW5nZSBpdA0KPiA+IGZyb20gd3JpdGFibGUg
dG8gc2hhZG93IHN0YWNrLiBBZ2FpbiB0aGlzIG1pZ2h0IGJlIGFuIHg4NiBuZWVkLA0KPiA+IHNp
bmNlDQo+ID4gaXQgbmVlZGVkIHRvIGhhdmUgaXQgd3JpdGFibGUgdG8gYWRkIGEgcmVzdG9yZSB0
b2tlbiwgYW5kIHRoZSBndWFyZA0KPiA+IHBhZ2VzIGhlbHAgd2l0aCBzZWN1cml0eS4NCj4gDQo+
IEkndmUgbm90IHNlZW4geW91ciBlYXJsaWVyIHBhdGNoIGJ1dCBJIGFtIGFzc3VtaW5nIHdoZW4g
eW91IHNheQ0KPiB3aW5kb3cgeW91DQo+IG1lYW4gdGhhdCBzaGFkb3cgc3RhY2sgd2FzIG9wZW4g
dG8gcmVndWxhciBzdG9yZXMgKG9yIEkgbWF5IGJlDQo+IG1pc3NpbmcNCj4gc29tZXRoaW5nIGhl
cmUpDQo+IA0KPiBJIGFtIHdvbmRlcmluZyBpZiBtYXBwaW5nIGl0IGFzIHNoYWRvdyBzdGFjayAo
aW5zdGVhZCBvZiBoYXZpbmcNCj4gdGVtcG9yYXJ5DQo+IHdyaXRlYWJsZSBtYXBwaW5nKSBhbmQg
dXNpbmcgYHdydXNzYCB3YXMgYW4gb3B0aW9uIHRvIHB1dCB0aGUgdG9rZW4NCj4gb3INCj4geW91
IHdhbnRlZCB0byBhdm9pZCBpdD8NCj4gDQo+IEFuZCB5ZXMgb24gcmlzY3YsIGFyY2hpdGVjdHVy
ZSBpdHNlbGYgZG9lc24ndCBkZWZpbmUgdG9rZW4gb3IgaXRzDQo+IGZvcm1hdC4NCj4gU2luY2Ug
aXQncyBSSVNDLCBzb2Z0d2FyZSBjYW4gZGVmaW5lIHRoZSB0b2tlbiBmb3JtYXQgYW5kIHRodXMg
Y2FuDQo+IHVzZQ0KPiBlaXRoZXIgYHNzcHVzaGAgb3IgYHNzYW1vc3dhcGAgdG8gcHV0IGEgdG9r
ZW4gb24gYHNoYWRvdyBzdGFja2ANCj4gdmlydHVhbA0KPiBtZW1vcnkuDQoNCldpdGggV1JTUyBh
IHRva2VuIGNvdWxkIGJlIGNyZWF0ZWQgdmlhIHNvZnR3YXJlLCBidXQgeDg2IHNoYWRvdyBzdGFj
aw0KaW5jbHVkZXMgaW5zdHJ1Y3Rpb25zIHRvIGNyZWF0ZSBhbmQgc3dpdGNoIHRvIHRva2VucyBp
biBsaW1pdGVkIHdheXMNCihSU1RPUlNTUCwgU0FWRVBSRVZTU1ApLCB3aGVyZSBXUlNTIGxldHMg
eW91IHdyaXRlIGFueXRoaW5nLiBUaGVzZQ0Kb3RoZXIgaW5zdHJ1Y3Rpb25zIGFyZSBlbm91Z2gg
Zm9yIGdsaWJjLCBleGNlcHQgZm9yIHdyaXRpbmcgYSByZXN0b3JlDQp0b2tlbiBvbiBhIGJyYW5k
IG5ldyBzaGFkb3cgc3RhY2suDQoNClNvIFdSU1MgaXMgbWFkZSBvcHRpb25hbCBzaW5jZSBpdCB3
ZWFrZW5zIHRoZSBwcm90ZWN0aW9uIG9mIHRoZSBzaGFkb3cNCnN0YWNrLiBTb21lIGFwcHMgbWF5
IHByZWZlciB0byB1c2UgaXQgdG8gZG8gZXhvdGljIHRoaW5ncywgYnV0IHRoZQ0KZ2xpYmMgaW1w
bGVtZW50YXRpb24gZGlkbid0IHJlcXVpcmUgaXQuDQoNCj4gDQo+ID4gDQo+ID4gU28gaW5zdGVh
ZCB0aGlzIHNlcmllcyBjcmVhdGVzIGEgbWFwX3NoYWRvd19zdGFjayBzeXNjYWxsIHRoYXQgbWFw
cw0KPiA+IGENCj4gPiBzaGFkb3cgc3RhY2sgYW5kIHdyaXRlcyB0aGUgdG9rZW4gZnJvbSB0aGUg
a2VybmVsIHNpZGUuIFRoZW4NCj4gPiBtcHJvdGVjdCgpDQo+ID4gaXMgcHJldmVudGVkIGZyb20g
bWFraW5nIHNoYWRvdyBzdGFjaydzIGNvbnZlbnRpb25hbGx5IHdyaXRhYmxlLg0KPiA+IA0KPiA+
IGFub3RoZXIgZGlmZmVyZW5jZSBpcyBlbmFibGluZyBzaGFkb3cgc3RhY2sgYmFzZWQgb24gZWxm
IGhlYWRlcg0KPiA+IGJpdHMNCj4gPiBpbnN0ZWFkIG9mIHRoZSBhcmNoX3ByY3RsKClzLiBTZWUg
dGhlIGhpc3RvcnkgYW5kIHJlYXNvbmluZyBoZXJlDQo+ID4gKHNlY3Rpb24gIlN3aXRjaCBFbmFi
bGluZyBJbnRlcmZhY2UiKToNCj4gPiANCj4gPiANCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xr
bWwvMjAyMjAxMzAyMTE4MzguODM4Mi0xLXJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tLw0KPiA+
IA0KPiA+IE5vdCBzdXJlIGlmIHRob3NlIHR3byBpc3N1ZXMgd291bGQgYmUgcHJvYmxlbXMgb24g
cmlzY3Ygb3Igbm90Lg0KPiANCj4gQXBhcnQgZnJvbSBtYXBwaW5nIGFuZCB3aW5kb3cgaXNzdWUg
dGhhdCB5b3UgbWVudGlvbmVkLCBJIGNvdWxkbid0DQo+IHVuZGVyc3RhbmQgb24gd2h5IGVsZiBo
ZWFkZXIgYml0IGlzIGFuIGlzc3VlIG9ubHkgaW4gdGhpcyBjYXNlIGZvcg0KPiB4ODYNCj4gc2hh
ZG93IHN0YWNrIGFuZCBub3QgYW4gaXNzdWUgZm9yIGxldCdzIHNheSBhYXJjaDY0LiBJIGNhbiBz
ZWUgdGhhdA0KPiBhYXJjaDY0IHByZXR0eSBtdWNoIHVzZXMgZWxmIGhlYWRlciBiaXQgZm9yIEJU
SS4gRXZlbnR1YWxseSBpbmRpcmVjdA0KPiBicmFuY2ggdHJhY2tpbmcgYWxzbyBuZWVkcyB0byBi
ZSBlbmFibGVkIHdoaWNoIGlzIGFuYWxvZ291cyB0byBCVEkuDQoNCldlbGwgZm9yIG9uZSwgd2Ug
aGFkIHRvIGRlYWwgd2l0aCB0aG9zZSBvbGQgZ2xpYmMncy4gQnV0IGRvZXNuJ3QgQlRJDQp0ZXh0
IG5lZWQgdG8gYmUgbWFwcGVkIHdpdGggYSBzcGVjaWFsIFBST1QgYXMgd2VsbD8gU28gaXQgZG9l
c24ndCBqdXN0DQp0dXJuIG9uIGVuZm9yY2VtZW50IGF1dG9tYXRpY2FsbHkgaWYgaXQgZGV0ZWN0
cyB0aGUgZWxmIGJpdC4NCg0KPiANCj4gQlRXIGV2ZW50dWFsbHkgcmlzY3YgYmluYXJpZXMgcGxh
biB0byB1c2UgYC5yaXNjdi5hdHRyaWJ1dGVzYCBzZWN0aW9uDQo+IGluIHJpc2N2IGVsZiBiaW5h
cnkgaW5zdGVhZCBvZiBgLmdudS5ub3RlLnByb3BlcnR5YC4gU28gSSBhbSBob3BpbmcNCj4gdGhh
dA0KPiBwYXJ0IHdpbGwgZ28gaW50byBhcmNoIHNwZWNpZmljIGNvZGUgb2YgZWxmIHBhcnNpbmcg
Zm9yIHJpc2N2IGFuZA0KPiB3aWxsIGJlDQo+IGNvbnRhaW5lZC4NCj4gDQo+ID4gDQo+ID4gRm9y
IHNoYXJpbmcgdGhlIHByY3RsKCkgaW50ZXJmYWNlLiBUaGUgb3RoZXIgdGhpbmcgaXMgdGhhdCB4
ODYgYWxzbw0KPiA+IGhhcw0KPiA+IHRoaXMgIndyc3MiIGluc3RydWN0aW9uIHRoYXQgY2FuIGJl
IGVuYWJsZWQgd2l0aCBzaGFkb3cgc3RhY2suIFRoZQ0KPiA+IGN1cnJlbnQgYXJjaF9wcmN0bCgp
IGludGVyZmFjZSBzdXBwb3J0cyBib3RoLiBJJ20gdGhpbmtpbmcgaXQncw0KPiA+IHByb2JhYmx5
IGEgcHJldHR5IGFyY2gtc3BlY2lmaWMgdGhpbmcuDQo+IA0KPiB5ZXMgYWJpbGl0eSB0byBwZXJm
b3JtIHdyaXRlcyBvbiBzaGFkb3cgc3RhY2sgYWJzb2x1dGVseSBhcmUNCj4gcHJldmVudGVkIG9u
DQo+IHg4Ni4gU28gZW5hYmxpbmcgdGhhdCBzaG91bGQgYmUgYSBhcmNoIHNwZWNpZmljIHByY3Rs
Lg0KPiANCj4gPiANCj4gPiBBQkktd2lzZSwgYXJlIHlvdSBwbGFubmluZyB0byBhdXRvbWF0aWNh
bGx5IGFsbG9jYXRlIHNoYWRvdyBzdGFja3MNCj4gPiBmb3INCj4gPiBuZXcgdGFza3M/IElmIHRo
ZSBBQkkgaXMgY29tcGxldGVseSBkaWZmZXJlbnQgaXQgbWlnaHQgYmUgYmVzdCB0bw0KPiA+IG5v
dA0KPiA+IHNoYXJlIHVzZXIgaW50ZXJmYWNlcy4gQnV0IGFsc28sIEkgd29uZGVyIHdoeSBpcyBp
dCBkaWZmZXJlbnQuDQo+IA0KPiBZZXMgYXMgb2Ygbm93IHBsYW5uaW5nIGJvdGg6DQo+IC0gYWxs
b2NhdGUgc2hhZG93IHN0YWNrIGZvciBuZXcgdGFzayBiYXNlZCBvbiBlbGYgaGVhZGVyDQo+IC0g
dGFzayBjYW4gY3JlYXRlIHRoZW0gdXNpbmcgYHByY3Rsc2AgKGZyb20gZ2xpYmMpDQo+IA0KPiBB
bmQgeWVzIGBmb3JrYCB3aWxsIGdldCB0aGUgYWxsIGNmaSBwcm9wZXJ0aWVzIChzaGRvdyBzdGFj
ayBhbmQNCj4gYnJhbmNoIHRyYWNraW5nKQ0KPiBmcm9tIHBhcmVudC4NCg0KSGF2ZSB5b3UgbG9v
a2VkIGF0IGEgcmlzY3YgbGliYyBpbXBsZW1lbnRhdGlvbiB5ZXQ/IEZvciB1bmlmeWluZyBBQkkg
SQ0KdGhpbmsgdGhhdCBtaWdodCBiZSBiZXN0IGludGVyZmFjZSB0byB0YXJnZXQsIGZvciBhcHAg
ZGV2ZWxvcGVycy4gVGhlbg0KZWFjaCBhcmNoIGNhbiBpbXBsZW1lbnQgZW5vdWdoIGtlcm5lbCBm
dW5jdGlvbmFsaXR5IHRvIHN1cHBvcnQgbGliYw0KKGZvciBleGFtcGxlIG1hcF9zaGFkb3dfc3Rh
Y2spLg0KDQoNCg==
