Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48D162A253
	for <lists+linux-arch@lfdr.de>; Tue, 15 Nov 2022 21:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiKOUBU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Nov 2022 15:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiKOUBS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Nov 2022 15:01:18 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A13028E04;
        Tue, 15 Nov 2022 12:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668542477; x=1700078477;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+Rvby8f8zNlTIKX+Ahm8Lj5hAgIbvfqKLE/tZwQ37cg=;
  b=FqryaN4B60DzpaYWq4RmEPqra08q8xutYXxALod8jNMxb1kCqtTi8irr
   3Q9NG4vWVFTYdG34JTjwgBjdA4lPeyUaBeJyuG/AlrLC++DXPoNT/Jwtg
   1DJUQwzDpA3FxzcrS3jftfT+Wd/Tn4/5Eo/DzsbeOMCs21YTcDpFWUZiH
   wOqoP+cL5zrqfpd6KmGP6EC2V5GjSakSQx46D4OfSehRwJTo4bw/a0ClD
   If3MQvdlK9eER+TW7t/LHGcAiass8KkgXziiRaT7K6rh2bQV00DVH7rhb
   k81OPTocl2OShi6kYQ5wbTVx1lwKJlQ+rTPdgi4wDD0XE+/67KTyYX8Ii
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="398643309"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="398643309"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 12:01:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="702571004"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="702571004"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 15 Nov 2022 12:01:15 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 12:01:15 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 12:01:15 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 12:01:15 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 12:01:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6jiH/39K9/AO1QVR4IneGNW9HUb7hBMhcnFLoPoMOA1slwPQFaNS73YxlxBzpqp35oXUXc7GttzOWqneK6zoGYqiTiXgaPbhiyZ6bDPqW16t0CCQuW3z44UiXoptfOPdGW+vKlUK1gZPuSCOxsuCopq2/PyYEKO6oYhP/12uIW3YZGLadGo+OoaGoxqFNGy7Tig12bxIJEYeqoKJ+K2WUCg7UnmRrOasG2ucPiH3evjG5xNihKNP3YzBK5E9jkknRwgXUdreMqCHEU3nmQuapMtUlYpaybL+0brY3mhsVmZ2fhXTquTETd9KaX5ddvWOy5YTu8WtfCNcq3wWLvBmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Rvby8f8zNlTIKX+Ahm8Lj5hAgIbvfqKLE/tZwQ37cg=;
 b=ZcLwC1Ffl77zv2QadTyxTKx9icQgg4LrXZLhLcjAN6Jy5EpIlOMIMhE2trpf/5NUf4gcf5WyYGpiz5ukvIvCVP99E+1JWtZ3azhVqTYzeX0R3MQDJHlk2Lmax+LhjaAQ8AGoZJbET19Z+cZhrJpeLnT3DpZTFLRL/WzDMJEbhQiTaIpHBEObyW+uTbOW2yuBex5Zzfj4sEi6UXPOmexhK21GQ1US6LIDJ2ENz8qdQWzeZLyeyjo/BAq6x7FnEduZLQpS0/qSeaQTD2ZhJN/PWu0tP1JrjjVV6mJZM4WkuCuRV/fdo6Svrq/OSqrvihuyTsQ3dUk6779nYBtOy+sUAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH0PR11MB5675.namprd11.prod.outlook.com (2603:10b6:510:d4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 20:01:13 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3%5]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 20:01:12 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 36/37] x86/cet/shstk: Add ARCH_CET_UNLOCK
Thread-Topic: [PATCH v3 36/37] x86/cet/shstk: Add ARCH_CET_UNLOCK
Thread-Index: AQHY8J5grb40rgp4tkSd5Z4HdgL9Tq5AIQWAgABXwoA=
Date:   Tue, 15 Nov 2022 20:01:12 +0000
Message-ID: <4273232513cd178be303d817b15e442703bda637.camel@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
         <20221104223604.29615-37-rick.p.edgecombe@intel.com>
         <Y3OmaSjhCtjht1nS@hirez.programming.kicks-ass.net>
In-Reply-To: <Y3OmaSjhCtjht1nS@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH0PR11MB5675:EE_
x-ms-office365-filtering-correlation-id: 0ac9284e-8288-4548-0ce0-08dac7442588
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d17B9oU8IpWgayZGDi5LzIltzxge0AI5SYqGW9q8pUQdhxltA3EWTxyP0TUSBET8e636U3RkJ8D2iCvaZu8ZlHvH4YFbfkRkc4wPTUBmco0wITRaRTIagrgJdss/AdjgVIKjjc/ngdMpDUyM/m1m04U3F8aZ76cm4yatw58LM7muwN654tbypDMCzcuRvT4QK5dRGm3HnvkwowIEJrH2Bue4nQqDRRu8P3GiluCoY/6r7l/MskXfBsR5zUUPuRb3iihe1Pl9OTt542KpHlWFmLHmPgamSEe2xOx/L6LYGis9GHAqQLakEfNXxaqJd4Xsbxmr7n56SQpvWyIO9ib+gpOf4PA+qMyEjwcsuNI4nl8bomp+i0+Kcf7JKQyKtiyPNkm6TcL3ofBtud18387C+RBEAP4YSqVBDaSlDBB8yZqB5h+2CphFpnU8FM5Hu4YOJwPf9SIQsoK9BKMDh/BGDcMx/K0zVlUJu575++Sd9R+PPbKEQy7QQRUYtipNQFZ4Tjn6Vjs5qocF+b22n+M0UwkNW6iEGVy7bccwF4WIJmQgQyjmKlNl9PJZLh4iMV9VmbVGxyPfTpopmC4bhNWzSwe4o7s/9DbRHy6XCL3xmpPW+fFdqx66SccovqVMmmtA66wdi0mZ6joc4xzIogyiw9BVD2LVNVaOZnZ6ogYSW/GpAAk2U2FHTu0+iyP8hUAOSnFUKh5zKblom0F0jW2aaucMLP5V78RGg6fAPhgex2q6dVPeI5hzocOA5OfKx6Qx9gadvvnDBHQa0zTU7PfBEJFG5rXC4xC3UUEhY9HVlSE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199015)(66946007)(4001150100001)(2906002)(76116006)(66476007)(91956017)(66556008)(7416002)(5660300002)(7406005)(8936002)(66446008)(4326008)(8676002)(64756008)(41300700001)(6506007)(54906003)(6916009)(26005)(316002)(82960400001)(186003)(2616005)(6512007)(83380400001)(478600001)(6486002)(71200400001)(38100700002)(122000001)(38070700005)(36756003)(86362001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1E0MytqSjg4R2NKK0NaaEtvTEp2Qzd6aTB2WC9hRnBIbmVsUUJQOGJxTEpL?=
 =?utf-8?B?WllJOEhodkV2Vjd3Uk0zMWVHZVdHMzd6WVdOTkx6UEpNY0tGdVJ1RmFWSGkw?=
 =?utf-8?B?Yy9GaGNHaVUyNE54RjdRU2xqMXlYd1Rnc0FFOHp0djJoa3E0K2IvbzYyUW9L?=
 =?utf-8?B?ZnBBUkJ2Y0lqdnNEQ29sbVNid2JtNlppbUl6UVRtS3BXR1d0eW9qd1YzaE9F?=
 =?utf-8?B?d0JnNHkycmlEYWVKMi9jdmxJUy8wZkIrem9qQTdlVno0SmVnYzVOKzdvcGlj?=
 =?utf-8?B?SVI4NEVNRTNHamUrQ1dMdFVyZE9vZDc3cm53dE9TV1NaWlhUNDk5TWNjSzhM?=
 =?utf-8?B?SmNzWDNYbGgrekxiKzcwbTV0Vyt2cW5ycG1FS3NkLzBZWmZQT2xtcEtzdjhN?=
 =?utf-8?B?MklzU05WQjQxdDRCMStxNXd1dmYrNDZ5cWZ1VEhOMVBMUUl3c2o3UGNXa0tL?=
 =?utf-8?B?UmgzYnd0Nmh5S1FVc3dzVTdJVEw0dW1CS0xJUEVYSXY0elFkbGp4MDZXMDI3?=
 =?utf-8?B?M1NrblNIc3ZpWFZjcms3RVNPT0dyZ3g3SlFHUkRPTmVHa3NEWHFoM3dBRlNE?=
 =?utf-8?B?amhsMlNUT0wvdG5JZklpWWpSTW5zb1FqdVhNRVdhZ2s5VEd3NE4rMlJWUGpZ?=
 =?utf-8?B?NS96UDkySGNIcHpBdTF1Q3lqaW1pQ25vdms3em5LRjJDVTVSb0FvTm1yaUNV?=
 =?utf-8?B?QSs4dnlnYnJwVHlmTjZQSm1GTW9tWFhIbzV6bTZ4cVBqUWJMZllJVE9MZC9E?=
 =?utf-8?B?eTQyekVjUXZWcU5pWnMrMXgwNUFuNENxbzU1aFV2eHFFZUNzbWRnSkFqK3Vr?=
 =?utf-8?B?UGtiMjY3Qk1BbG5NNHpMeTRsOEVFRTJTQTU4a2w0YUV0YXhFSzJ0MHdTQ3dV?=
 =?utf-8?B?L3hOZjFISWw0ZE5UZ1k3VWJnRU9ZdjJwQnhCZEdVek9xSTRKQUFSVGUyQnFj?=
 =?utf-8?B?RDR4NG85Y3Y5alpvMXIvVk9YbUxPOU45UkY2bFU4a1lDd2daSzBGWFhFb0xB?=
 =?utf-8?B?K2FxTkhHMlJZRDFXdGlybWloelFYNGpjT0ZCOGMrTVRoNTNuSm8vYkFyak05?=
 =?utf-8?B?QlJMNmRsZjliTDNGMTJWbU14dStqVmRKZUNVYUFhSHlSK0FJa0xJVmh6ZDVO?=
 =?utf-8?B?VmZMV1YwaXhpVU5xZnZaZjhRR3R1YUtkdkp2eHczWlRLOHpHUjhLNGxKSlZj?=
 =?utf-8?B?dWtjYkNaN1BpQytzY3ZrY3ZoWm5zK2gwNWFrT1ZaVVpDUjNBeXJZTm5vKzkr?=
 =?utf-8?B?SVg1cXc3ZjF2WXhicXJkY3E4OXFGYVNaUDdWaDhYWWt3c1dNcXRqUEF5dGJy?=
 =?utf-8?B?K1ZUN083MTc5QWkrT25FbVNsNDdBMmYyQ2NndlZjMHhKUkxLMUhCNTZWS1Zr?=
 =?utf-8?B?TWZYRUxmVTJFemJoZUw5R0pmWEZmdjUzVFFkbUhOU3ZsbFBLS01lQUk1MG91?=
 =?utf-8?B?OWR2TmY1d0FEZ3VQOVBKUTVsUXRsNFA2ZWU5OVM2dFEvNEVMb2YvTkJCT3h1?=
 =?utf-8?B?U2QxSHAzZjF2aFJ4ZC9XSHZqRFEyVWRENVRhbS9zTmRIZFZxNEpkUDZYOHAr?=
 =?utf-8?B?cnRoVkFiK0xnVmJFZXZ6WHU2TmhOd1ZzbjNYOEFDK0dFaGNlS0F1TFF6ZTBX?=
 =?utf-8?B?Y2dOL3B5azNSV3R4V2VhbEZKSWtOVnIyN2dkUlNzcDJvVFN5Ni83VUNocjhO?=
 =?utf-8?B?WTBBeW1tWGh0cmRSdzk4ZUMwU2FZZGFVS3NYSU5nMnJiaVdyMnNtbUtHdWIy?=
 =?utf-8?B?ZGdIWTNidG5NbGgrbytEY29LTkJtWlF6TE82UDF0K1FrLzVna3o5VkxBMnh1?=
 =?utf-8?B?VlVMRkRra0MwdUhCV3FEU3RNT0RhYWswVktjMGlIeEgycVc5b1lHeXRFUkdw?=
 =?utf-8?B?TC9CMXFNMkRSOUsxdkpqTnprVTdmYmZ5MCtKYmpsakJRNWFLb0xNdXVqR3VF?=
 =?utf-8?B?YUgwOXUva0ZZWTBQaDRselA0bGg3eHVaUmg5cS9UQ1dQTHJJcm1pYm1SYmph?=
 =?utf-8?B?N0twRzZvdmFndG5aMXppS3VuRmdZckw1RFl4YWx5aVdVdndCQXJRUllGd3Fn?=
 =?utf-8?B?TjBVRnNyWFc4OThYZ1dWSzg2bFdSS3JQVGF0ZVN4eERoSzlqTFp0Ly9Lek81?=
 =?utf-8?B?Y0ZDbnFLSnN0aU5QZlpIVklPQmR6aUxtZlRldDVjU2dOZ215UGhoTXNyZnVY?=
 =?utf-8?Q?KYcCI4lkj/Uiob+CEVBQ4YE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <173CA8C8F4B75E41B03B02FB83135C07@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac9284e-8288-4548-0ce0-08dac7442588
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 20:01:12.7410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L2Rzr+SbRAiG5sB3LzPjrgDXACB+BUq53Lx2LMXTNEgF4/5D/zGZ+P3O7ADxIiJwSmHmX3fodMTZ1eiPb4Uj9Skj48dECmTi2AupfT3J92U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5675
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTE1IGF0IDE1OjQ3ICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gRnJpLCBOb3YgMDQsIDIwMjIgYXQgMDM6MzY6MDNQTSAtMDcwMCwgUmljayBFZGdlY29t
YmUgd3JvdGU6DQo+IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvc2hzdGsuYyBi
L2FyY2gveDg2L2tlcm5lbC9zaHN0ay5jDQo+ID4gaW5kZXggNzE2MjBiNzdhNjU0Li5iZWQ3MDMy
ZDM1ZjIgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYva2VybmVsL3Noc3RrLmMNCj4gPiArKysg
Yi9hcmNoL3g4Ni9rZXJuZWwvc2hzdGsuYw0KPiA+IEBAIC00NTAsOSArNDUwLDE0IEBAIGxvbmcg
Y2V0X3ByY3RsKHN0cnVjdCB0YXNrX3N0cnVjdCAqdGFzaywgaW50DQo+ID4gb3B0aW9uLCB1bnNp
Z25lZCBsb25nIGZlYXR1cmVzKQ0KPiA+ICAJCXJldHVybiAwOw0KPiA+ICAJfQ0KPiA+ICANCj4g
PiAtCS8qIERvbid0IGFsbG93IHZpYSBwdHJhY2UgKi8NCj4gPiAtCWlmICh0YXNrICE9IGN1cnJl
bnQpDQo+ID4gKwkvKiBPbmx5IGFsbG93IHZpYSBwdHJhY2UgKi8NCj4gDQo+IEJvdGggdGhlIG9s
ZCBhbmQgbmV3IGNvbW1lbnQgYXJlIGVxdWFsbHkgdXNlbGVzcyBmb3IgdGhleSB0ZWxsIHVzDQo+
IG5vdGhpbmcgdGhlIGNvZGUgZG9lc24ndCBhbHJlYWR5Lg0KPiANCj4gV2h5IGlzbid0IHB0cmFj
ZSBhbGxvd2VkIHRvIGNhbGwgdGhlc2UsIGFuZCBkb2Vzbid0IHRoYXQgcmF0aGVyIGxlYXZlDQo+
IENSSVUgaW4gYSBiaW5kLCBpdCBjYW4gdW5sb2NrIGJ1dCBub3QgcmUtbG9jayB0aGUgZmVhdHVy
ZXMsIGxlYXZpbmcNCj4gcmVzdG9yZWQgcHJvY2Vzc2VzIG1vcmUgdnVsbmVyYWJsZSB0aGFuIHRo
ZXkgd2VyZS4NCg0KQXMgSSB1bmRlcnN0YW5kIGl0LCBDUklVIGRvZXMgc29tZSBwb2tpbmcgYXQg
dGhpbmdzIHZpYSBwdHJhY2UgdG8gc2V0dXANCmEgInBhcmFzaXRlIiB3aGljaCBpcyBhY3R1YWwg
ZXhlY3V0YWJsZSBjb2RlIGluamVjdGVkIGluIHRoZSBwcm9jZXNzLg0KVGhlbiBhIGxvdCBvZiB0
aGUgcmVzdG9yZSBjb2RlIGFjdHVhbGx5IHJ1bnMgaW4gdGhlIHByb2Nlc3MgZ2V0dGluZw0KcmVz
dG9yZWQuDQoNCkFzIGZvciBub3QgYWxsb3dpbmcgdW5sb2NrIHRvIGJlIHVzZWQgaW4gdGhlIG5v
bi1wdHJhY2Ugc2NlbmFyaW8gaXQncw0KdG8ga2VlcCBhdHRhY2tlcnMgZnJvbSB1bmxvY2tpbmcg
dGhlIHNoYWRvdyBzdGFjayBkaXNhYmxlIEFQSSBhbmQNCmNhbGxpbmcgaXQgdG8gZGlzYWJsZSBz
aGFkb3cgc3RhY2suDQoNCkFzIGZvciBub3QgYWxsb3dpbmcgdGhlIG90aGVycyB2aWEgcHRyYWNl
LCB0aGUgY2FsbCBpcyBpbiB0aGUgdHJhY2luZw0KcHJvY2Vzc2VzIGNvbnRleHQsIHNvIHRoZXkg
d291bGQgb3BlcmF0ZSBvbiB0aGVpciBvd24gcmVnaXN0ZXJzIGluc3RlYWQNCm9mIHRoZSB0cmFj
ZWVzLg0KDQo+IA0KPiA+ICsJaWYgKHRhc2sgIT0gY3VycmVudCkgew0KPiA+ICsJCWlmIChvcHRp
b24gPT0gQVJDSF9DRVRfVU5MT0NLICYmDQo+ID4gSVNfRU5BQkxFRChDT05GSUdfQ0hFQ0tQT0lO
VF9SRVNUT1JFKSkgew0KPiANCj4gV2h5IG1ha2UgdGhpcyBjb25kaXRpb25hbCBvbiBDUklVIGF0
IGFsbD8NCg0KS2VlcyBhc2tlZCBmb3IgaXQsIEkgdGhpbmsgaGUgd2FzIHdvcnJpZWQgYWJvdXQg
YXR0YWNrZXJzIHVzaW5nIGl0IHRvDQp1bmxvY2sgYW5kIGRpc2FibGUgc2hhZG93IHN0YWNrLiBT
byB3YW50ZWQgdG8gbG9jayBpdCBkb3duIHRvIHRoZQ0KbWF4aW11bS4NCg0KPiANCj4gPiArCQkJ
dGFzay0+dGhyZWFkLmZlYXR1cmVzX2xvY2tlZCAmPSB+ZmVhdHVyZXM7DQo+ID4gKwkJCXJldHVy
biAwOw0KPiA+ICsJCX0NCj4gPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArCX0NCj4gPiAgDQo+
ID4gIAkvKiBEbyBub3QgYWxsb3cgdG8gY2hhbmdlIGxvY2tlZCBmZWF0dXJlcyAqLw0KPiA+ICAJ
aWYgKGZlYXR1cmVzICYgdGFzay0+dGhyZWFkLmZlYXR1cmVzX2xvY2tlZCkNCj4gPiAtLSANCj4g
PiAyLjE3LjENCj4gPiANCg==
