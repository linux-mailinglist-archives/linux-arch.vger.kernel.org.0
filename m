Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769BC6B338C
	for <lists+linux-arch@lfdr.de>; Fri, 10 Mar 2023 02:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjCJBNw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Mar 2023 20:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjCJBNu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Mar 2023 20:13:50 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4ACC5628;
        Thu,  9 Mar 2023 17:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678410829; x=1709946829;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HQNJZLLfpJztSd6rEoHzBxSpeF4s5lQcDhX5EJSN4mQ=;
  b=ljP4rmQoztQQIc6iIcsnTrRVUv1gwv2x7ec9S1Bi2smTQGb0ZlMXHcqJ
   u7RfXNpRo5ojQrFNIKggHmvVdPUzHcXndcmPAcdTu3Utpzl8G6+7c81Aj
   5oxnD2RNAG/mhY46FSUhfAUvm8xcaTxApvZRgxDdlPyDQmHV4HCFCMdMh
   u6KXlMAaEISVKSlwPfuk0H7f2MDSZMiEtK0I3moylkEe1wQTjovIJg1v6
   n1ds+wZZiFTuA0UCKOJ+WWnakDSf5bLs67u/1+Und5iCoI105rWgF1jj1
   R0ByxhjTAiAyrbGYd8fbuICFjMFZjsq78hlcAOk27K76A1Vvky8xqswOc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="317011050"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; 
   d="scan'208";a="317011050"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 17:13:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="1006943608"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; 
   d="scan'208";a="1006943608"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 09 Mar 2023 17:13:47 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 9 Mar 2023 17:13:46 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 9 Mar 2023 17:13:46 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 9 Mar 2023 17:13:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPMfHiaJFfidlSK+l1Zelr4RKeXjJejsw9XzMEMZggMAvgGz+5jJ/dOAKYsYOp0BmGSBdT1bxxL7BZqCnsG6zq/jFUy3ja9xczEHHVuLSa1dc/PpKFd5fUUT3umWB6iW4DW5LDVattMfa+0HwpoGF6CQMh9+l0eC6eXQaGcFehKFJQipfOACvMDs93byuNaOmqG5n9Ezyky23B/NzGtH4q8MOsZ5vAdJhzyE/ph5L/2utKqEDF7PiisE4I5KktUh3B7zQ+nLxOpDOKQaYUbfMlD8szl7ILQvdcxFMbKWpn3Adc7h6RvW0wFn1EfdmLu/Iptt78EsKU1Rn3KHhUvg4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQNJZLLfpJztSd6rEoHzBxSpeF4s5lQcDhX5EJSN4mQ=;
 b=Rw+XkqedeRw0fuF6HTQsYKTNp8hQ2OvOSFXIkSJ9sxCeNY6vBM06QEl9+pb58vpxDXnJJ9fGkKDfC5k4c3MBRnTfzBuq8EEccXKgwp3cBaOgxoBTnaq0nln4zJ0KcmqHS5h7mIcF0r5m53ikYMYk8U1ymXRBkoGJ/7jATc5RtvGjptoi/8F0xsvglX9QRiTwxs2WMcWkuWmQHVIdweQBMktEeD0XcH0RRatQFirzpl/EddfCsApa5TC+8MmS9ojH+teojRgO66qOM+THmiF/ZI7Mn398V1WjfbtD+6QgCEGXdygdA/QWLEa3qu/0u0GRf5p3ud/ptfDyDe701zPcTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM4PR11MB5518.namprd11.prod.outlook.com (2603:10b6:5:39a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Fri, 10 Mar
 2023 01:13:43 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 01:13:43 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>
CC:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
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
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v7 28/41] x86: Introduce userspace API for shadow stack
Thread-Topic: [PATCH v7 28/41] x86: Introduce userspace API for shadow stack
Thread-Index: AQHZSvtC0qoWAoXd0kKURn+giTskNK7wu1QAgADbO4CAAOD+AIAAQrQAgAB0BgCAABbcgA==
Date:   Fri, 10 Mar 2023 01:13:42 +0000
Message-ID: <e83ee9fc1a6e98cab62b681de7209598394df911.camel@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
         <20230227222957.24501-29-rick.p.edgecombe@intel.com>
         <ZAhjLAIm91rJ2Lpr@zn.tnic>
         <9e00b2a3d988f7b24d274a108d31f5f0096eeaae.camel@intel.com>
         <20230309125739.GCZAnXw5T1dfzwtqh8@fat_crate.local>
         <a4dd415ac908450b09b9abbd4421a9132b3c34cc.camel@intel.com>
         <20230309235152.GBZApxGNnXLvkGXCet@fat_crate.local>
In-Reply-To: <20230309235152.GBZApxGNnXLvkGXCet@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|DM4PR11MB5518:EE_
x-ms-office365-filtering-correlation-id: 52bb76e8-e6ae-4e53-bcb5-08db2104b0a4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j1GzmuDiDsxJ8eGAosbxP9sXtw6ghLUOCqypfUxU9W0gQmK3a2/anVNamfs4Jy5HcfdgkohTj6LVYkHTH0N3f/Ka6r3v/sJaletC6r1B8h8l1Q23SnESZCaR/OJmUbJeHQF1lxkh/TYXsialz7nyoSp3dfRdVdw4iCcf5t0o+JoXnMk31zLUaF7o0vma0rgfxJFfcILDnGxiQ8Sp+sA/TtIBzpaXiAWwUeZz66ZBB3K/QDiqVdy9ReEmxPFxCmRQ04vvwo6U28uitdWIP/Tmmsloj8eBCFBmKnDUEB9VCUkxH8b7igDWpQpQotxarH38yelm1ig8kppUUd7eUBmEa+MOmePsiIqcXn04vc0+7yakY4MWEWI1RTbVVL2o8/gCkFQ+uVJXXzN73Jl6g47vqedHmx8f5Ey+u9/uIyV4BxV7Sxd6gWeFqx/YexxAWZ7L3Fr92Fx4qhFPluB1J7aqS1o6CCyMLst95vpWsEITseqVtwC4eRpUqjCiGduLIeLJay3NnSIshn5zZULd8tsxZRVsBWThYMFq3BCWY1+HXrOzN5nn2/fQ74rcm/CM6bK9KcuITgg7pTGitjdjAgXJKXYiwZDPdUEoXEiaOcD1BbX2GtNKarTv+miHS0r1JBRo+8hrVpX0Iijcjc3j3yb2Qxv4Vnjswfwipc1t4Vay0C7H6qG52pGeTKILVVftwKFnY9xfHwUMpQROOqMOHA8E7bu/TGrFZXHrbljBYBj7kZU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199018)(36756003)(110136005)(38070700005)(54906003)(7416002)(71200400001)(6486002)(316002)(478600001)(41300700001)(7406005)(5660300002)(66476007)(91956017)(76116006)(66446008)(66556008)(2906002)(64756008)(66946007)(8676002)(8936002)(4326008)(6512007)(82960400001)(186003)(38100700002)(122000001)(26005)(86362001)(6506007)(2616005)(83380400001)(66899018)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkdjRDJrS04xR0NPek5LclpiTXdUSnlha0E5WFFGdVcyMzJzV21XQXdEMWJk?=
 =?utf-8?B?V1B2T0U2aE1pUVZsY2JDcjFwSHBoRUJDRVhKUkdoekJuZG1UU2RvOVh6MVFT?=
 =?utf-8?B?SVJ4a0NreG1xQjJNZmpIeXF5SkNhbFNOTDVpSFMxZjF2L3ZpRG4yaXVPeXpW?=
 =?utf-8?B?K2RCOThpMUptaDhyaUEwYzNCTmUxQnZhRXZuUGt6SEppZGxHbDROTUt2YVVK?=
 =?utf-8?B?Z0E3NHlzeVA1dm5IUUYyMXkvTGltRmVtNjRQZVNZeUtvcEtrd3QyU2hFLzBr?=
 =?utf-8?B?dElZYTZ5RW5rcGlzMEdVZXNwQXhDeTNZR21MRC9ESXYwZ3BaSE9IdDdPbTYv?=
 =?utf-8?B?Z3pJV0ErRzhiSVd5WWlzTFYxYUQ3Zm5zL21LZTNwUkVrNnV1K3YxN2VtWW9H?=
 =?utf-8?B?emxzWDA2S2xTV0wrZWtvQ1pqNWpGRmdnQ1A0ZzVWOWdaTExtSm5BdE40b2s1?=
 =?utf-8?B?bUgwaFZNalZQT3hDejIvL2VvbkNnZlhmWjluT1JLQlBPcnNhbzFVUGkxS3pD?=
 =?utf-8?B?SHlhaW5ndEVlOWJ4WGxEQ2lrR0pXMllEczNOY2F0SGJRU1hRUE16NjJxS3dp?=
 =?utf-8?B?RXp0ZkFDSFdkZUlNQWY4MDR2Z2VnQTBGU2wyQXBDWVB0cStnekp2aCtjNlU2?=
 =?utf-8?B?QWJEbTZQdDBmbWpmZTVjVWNad29HTGIxSXBsai9LQWJIdHpYZVlSVE05OGZx?=
 =?utf-8?B?S0RZRDQ3alN3RUZtSC9jbno5cnQ1eW43ZFpZNzVNVXF1TFpKUHJOdUViRjlR?=
 =?utf-8?B?UGNDZXAwSXo2ZHJxekU3dHF5S0hyZ2VLbXNLQXdIL3Bpc1BsczZibUhhVW9O?=
 =?utf-8?B?dmlqNHRJcHZnNmVRNnNJVTJ4TmZzYTNPTmFnemNOcGVWYkpsT1VXanZ2dHRP?=
 =?utf-8?B?S1A5Y0ZEWTV0VEh1Q0EwR1RsaGZQSGJ0VkxxTGZaYU45QXpsWnBjUXRvaWt3?=
 =?utf-8?B?UDZqVUxLNndrTVdsTUxwNG16WUFBazdqbU9RLzFlSDFucUk0THBkT2RjRm5o?=
 =?utf-8?B?UnJYL3RVRE9xLytXTDF1NW9XUUhkWHpqUy9SemlBR1hXU1p2ZXBkNStOVEVo?=
 =?utf-8?B?ZVBjQTJlNWdRQitiV2ZqV1FFVE5qS2ZmS1pkQVNweGVzbTBCdE5yc2JtMTFi?=
 =?utf-8?B?NVcvSENwVGM2S2loL0VPQWkxVEhEM0ZFazVtY1NRNFRBRmlLcEJVeXAyWXVH?=
 =?utf-8?B?b2pOYnFxWXRjSksvM0R4ZVArWVdmWlg0NkYyaHVHa3VsNm1LckRZeWtSc2xR?=
 =?utf-8?B?SlRESU82WVhKakRCY2dBOXc5K1Vka1UrRXdPTXNFQm9XZmZJUGNoZkRkeWsw?=
 =?utf-8?B?TmV4N21BVkVNMTJQeUlGbGQxb0cvclBMMnc4ZE4xOCtiL1UwNVcraHVQem83?=
 =?utf-8?B?dHJTOFpIcE9vNjdsRDkrOHNIUWtJWUJ1QjlSbmhybUFRakpldEF4Nm5ZOHh6?=
 =?utf-8?B?QVBOUFJJd2FBNTdQd0t0bDFzRFFXTjJYbkl6SFo4MGQyS1p3Q2lZZXpjQmxj?=
 =?utf-8?B?SXdMNEVWTjgrUC9vQ3RFYml6UG43RzNwZ09sWEV5VFVWMnFGSGtGMHZvSHRH?=
 =?utf-8?B?bWQvNFBmMHpTR1EwQnZicHBjNythZjhkam8wN2kycWIwR3FwTkN1ZWpoTUpp?=
 =?utf-8?B?WkVoUjZqSGpyellvWFBQK1Z1bnlPZWhWbzlxdDkwdjB2TVpEOFk5SjNMZWVv?=
 =?utf-8?B?RXE1aFpVc2lsQkxNNTNDdEY4YXlEN0h2eU9ZUGpTWWpwNmV5Q0xzYXVCZmJN?=
 =?utf-8?B?akl3YjhhekVnVGlKdjM4SS9IMVpFOWc2akpEQ0JXWTB3S0Vuc0pWaUdEeVN1?=
 =?utf-8?B?M1pZM1FET2NESENhYjNPL1dKTHlNZzQ2bHFvY0JMUjRaYW5WR1M3UGhUZzdF?=
 =?utf-8?B?TVBSTmlWb2s2SGlVenRRM210VlI0UjQwS2FhbU5nNVZOOTg4NFZ2NW9sS1Fo?=
 =?utf-8?B?UlY0NG5VemxwS0tQajJKVitYc0FoY1F1VTY0YnFjUGxrSFc3dWM3MXZMWW9t?=
 =?utf-8?B?blRGOEgzRkxWMVFOaWRSVHFVU1cydVVoTnY2OW0wa0E1YW9sRFdHRnFNVXNt?=
 =?utf-8?B?V1oyMEt4Z2tOeU5PQkc4ZEdQUUxDZFhLcXdhVmJPd0x4V0kybWx4NzZEemxS?=
 =?utf-8?B?MFdSS0wxb1NtcjRCS3pUMWJoNHE5L1l0Y2FUc0U0Z0NBMFYxbnB4NWNPa0Qz?=
 =?utf-8?Q?bZG0K2vSL965tTOHw6SxkMg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31A62EE4F74A514CA4A39C95750118B1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52bb76e8-e6ae-4e53-bcb5-08db2104b0a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 01:13:43.0072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IYhImyoCZN4HwTnLjvPrws6WYTcgh41VQ43Dntq08ho5tZQeekH2115fYyJX2S31mVPDjX6i7YS41ksriXMJtZoa6D/skPVhtSiwdsHaMro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5518
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

K0pvYW8gcmVnYXJkaW5nIG1peGVkIG1vZGUgZGVzaWducw0KDQpPbiBGcmksIDIwMjMtMDMtMTAg
YXQgMDA6NTEgKzAxMDAsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVGh1LCBNYXIgMDks
IDIwMjMgYXQgMDQ6NTY6MzdQTSArMDAwMCwgRWRnZWNvbWJlLCBSaWNrIFAgd3JvdGU6DQo+ID4g
VGhlcmUgaXMgYSBwcm9jIHRoYXQgc2hvd3MgaWYgc2hhZG93IHN0YWNrIGlzIGVuYWJsZWQgaW4g
YSB0aHJlYWQuDQo+ID4gSXQNCj4gPiBkb2VzIGluZGVlZCBjb21lIGxhdGVyIGluIHRoZSBzZXJp
ZXMuDQo+IA0KPiBOb3QgZ29vZCBlbm91Z2g6DQo+IA0KPiAxLiBidXJpZWQgc29tZXdoZXJlIGlu
IHByb2Mgd2hlcmUgbm8gb25lIGtub3dzIGFib3V0IGl0DQo+IA0KPiAyLiBpdCBpcyBwZXIgdGhy
ZWFkIHNvIHVzZXIgbmVlZHMgdG8gZ3JlcCAqYWxsKg0KDQpTZWUgIng4NjogRXhwb3NlIHRocmVh
ZCBmZWF0dXJlcyBpbiAvcHJvYy8kUElEL3N0YXR1cyIgZm9yIHRoZSBwYXRjaC4NCldlIGNvdWxk
IGVtaXQgc29tZXRoaW5nIGluIGRtZXNnIEkgZ3Vlc3M/IFRoZSBsb2dpYyB3b3VsZCBiZToNCiAt
IFJlY29yZCB0aGUgcHJlc2VuY2Ugb2YgZWxmIFNIU1RLIGJpdCBvbiBleGVjDQogLSBPbiBzaGFk
b3cgc3RhY2sgZGlzYWJsZSwgaWYgaXQgaGFkIHRoZSBlbGYgYml0LCBwcl9pbmZvKCJiYWQhIikN
Cg0KPiANCj4gPiAgIC4uLiBXZSBwcmV2aW91c2x5IHRyaWVkIHRvIGFkZCBzb21lIGJhdGNoIG9w
ZXJhdGlvbnMgdG8gaW1wcm92ZQ0KPiA+IHRoZQ0KPiA+ICAgcGVyZm9ybWFuY2UsIGJ1dCB0Z2x4
IGhhZCBzdWdnZXN0ZWQgdG8gc3RhcnQgd2l0aCBzb21ldGhpbmcNCj4gPiBzaW1wbGUuDQo+ID4g
ICBTbyB3ZSBlbmQgdXAgd2l0aCB0aGlzIHNpbXBsZSBjb21wb3NhYmxlIEFQSS4NCj4gDQo+IEkg
YWdyZWUgd2l0aCBzdGFydGluZyBzaW1wbGUgYW5kIHRoYW5rcyBmb3IgZXhwbGFpbmluZyB0aGlz
IGluDQo+IGRldGFpbC4NCj4gDQo+IFRCSCwgdGhvdWdoLCBpdCBhbHJlYWR5IHNvdW5kcyBsaWtl
IGEgbWVzcyB0byBtZS4gSSBndWVzcyBhIG1lc3MNCj4gd2UnbGwNCj4gaGF2ZSB0byBkZWFsIHdp
dGggYmVjYXVzZSB0aGVyZSB3aWxsIGFsd2F5cyBiZSB0aGlzIGNhc2Ugb2Ygc29tZQ0KPiBzaGFy
ZWQgb2JqZWN0L2xpYiBub3QgYmVpbmcgZW5hYmxlZCBmb3Igc2hzdGsgYmVjYXVzZSBvZiByYWlz
aW5zLg0KDQpUaGUgY29tcGF0aWJpbGl0eSBwcm9ibGVtcyBhcmUgdG90YWxseSB0aGUgbWVzcyBp
biB0aGlzIHdob2xlIHRoaW5nLg0KV2hlbiB5b3UgdHJ5IHRvIGxvb2sgYXQgYSAicGVybWlzc2l2
ZSIgbW9kZSB0aGF0IGFjdHVhbGx5IHdvcmtzIGl0IGdldHMNCmV2ZW4gbW9yZSBjb21wbGV4LiBK
b2FvIGFuZCBJIGhhdmUgYmVlbiBiYW5naW5nIG91ciBoZWFkcyBvbiB0aGF0DQpwcm9ibGVtIGZv
ciBtb250aHMuDQoNCkJ1dCB0aGVyZSBhcmUgc29tZSBleHBlY3RlZCB1c2VycyBvZiB0aGlzIHRo
YXQgc2F5OiB3ZSBjb21waWxlIGFuZA0KY2hlY2sgb3VyIGtub3duIHNldCBvZiBiaW5hcmllcywg
d2Ugd29uJ3QgZ2V0IGFueSBzdXJwcmlzZXMuIFNvIGl0J3MNCm1vcmUgb2YgYSBkaXN0cm8gcHJv
YmxlbS4NCg0KPiANCj4gQW5kIFRCSCAjMiwgSSB3b3VsZCd2ZSBkb25lIGl0IGV2ZW4gc2ltcGxl
cjogaWYgc29tZSBzaGFyZWQgb2JqZWN0DQo+IGNhbid0DQo+IGRvIHNoYWRvdyBzdGFjaywgd2Ug
ZGlzYWJsZSBpdCBmb3IgdGhlIHdob2xlIHByb2Nlc3MuIEkgbWVhbiwgd2hhdCdzDQo+IHRoZQ0K
PiBwb2ludD8gDQoNCllvdSBtZWFuIGEgbGF0ZSBsb2FkZWQgZGxvcGVuKCllZCBEU08/IFRoZSBl
bmFibGluZyBsb2dpYyBjYW4ndCBrbm93DQp0aGlzIHdpbGwgaGFwcGVuIGFoZWFkIG9mIHRpbWUu
DQoNCklmIHlvdSBtZWFuIGlmIHRoZSBzaGFyZWQgb2JqZWN0cyBpbiB0aGUgZWxmIGFsbCBzdXBw
b3J0IHNoYWRvdyBzdGFjaywNCnRoZW4gdGhpcyBpcyB3aGF0IGhhcHBlbnMuIFRoZSBjb21wbGlj
YXRpb24gaXMgdGhhdCB0aGUgbG9hZGVyIHdhbnRzIHRvDQplbmFibGUgc2hhZG93IHN0YWNrIGJl
Zm9yZSBpdCBoYXMgY2hlY2tlZCB0aGUgZWxmIGxpYnMgc28gaXQgZG9lc24ndA0KdW5kZXJmbG93
IHRoZSBzaGFkb3cgc3RhY2sgd2hlbiBpdCByZXR1cm5zIGZyb20gdGhlIGZ1bmN0aW9uIHRoYXQg
ZG9lcw0KdGhpcyBjaGVja2luZy4NCg0KU28gaXQgZG9lczoNCjEuIEVuYWJsZSBzaGFkb3cgc3Rh
Y2sNCjIuIENhbGwgZWxmIGxpYnMgY2hlY2tpbmcgZnVuY3Rpb25zDQozLiBJZiBhbGwgZ29vZCwg
bG9jayBzaGFkb3cgc3RhY2suIEVsc2UsIGRpc2FibGUgc2hhZG93IHN0YWNrLg0KNC4gUmV0dXJu
IGZyb20gZWxmIGNoZWNraW5nIGZ1bmN0aW9ucyBhbmQgaWYgc2hzdGsgaXMgZW5hYmxlZCwgZG9u
J3QNCnVuZGVyZmxvdyBiZWNhdXNlIGl0IHdhcyBlbmFibGVkIGluIHN0ZXAgMSBhbmQgd2UgaGF2
ZSByZXR1cm4gYWRkcmVzc2VzDQpmcm9tIDIgb24gdGhlIHNoYWRvdyBzdGFjaw0KDQpJJ20gd29u
ZGVyaW5nIGlmIHRoaXMgY2FuJ3QgYmUgaW1wcm92ZWQgaW4gZ2xpYmMgdG8gbG9vayBsaWtlOg0K
MS4gQ2hlY2sgZWxmIGxpYnMsIGFuZCByZWNvcmQgaXQgc29tZXdoZXJlDQoyLiBXYWl0IHVudGls
IGp1c3QgdGhlIHJpZ2h0IHNwb3QNCjMuIElmIGFsbCBnb29kLCBlbmFibGUgYW5kIGxvY2sgc2hh
ZG93IHN0YWNrLg0KDQpCdXQgaXQgZGVwZW5kcyBvbiB0aGUgbG9hZGVyIGNvZGUgZGVzaWduIHdo
aWNoIEkgZG9uJ3Qga25vdyB3ZWxsDQplbm91Z2guDQoNCj4gT25seSBzb21lIG9mIHRoZSBzdGFj
ayBpcyBzaGFkb3dlZCBzbyBhbiBhdHRhY2tlciBjb3VsZCBmaW5kDQo+IGEgd2F5IHRvIGtlZXAg
dGhlIHByb2Nlc3MgcGVyaGFwcyBydW4gdGhpcyBzaHN0ay11bnN1cHBvcnRpbmcgc2hhcmVkDQo+
IG9iamVjdCBtb3JlL2xvbmdlciBhbmQgUk9QIGl0cyB3YXkgYXJvdW5kIHRoZSBzeXN0ZW0uDQoN
CkkgaG9wZSBub24tcGVybWlzc2l2ZSBtb2RlIGlzIHRoZSBzdGFuZGFyZCB1c2FnZSBldmVudHVh
bGx5Lg0KDQo+IA0KPiBCdXQgSSB0ZW5kIHRvIG92ZXJzaW1wbGlmeSB0aGluZ3Mgc29tZXRpbWVz
IHNvLi4uDQo+IA0KPiBXaGF0IEknZCBsaWtlIHRvIGhhdmUsIHRob3VnaCwgaXMgYSBrZXJuZWwg
Y21kbGluZSBwYXJhbSB3aGljaA0KPiBkaXNhYmxlcw0KPiBwZXJtaXNzaXZlIG1vZGUgYW5kIHVz
ZXJzcGFjZSBjYW4ndCBkbyBhbnl0aGluZyBhYm91dCBpdC4gU28gdGhhdA0KPiBvbmNlDQo+IHlv
dSBib290IHlvdXIga2VybmVsLCB5b3UgY2FuIGtub3cgdGhhdCBldmVyeXRoaW5nIHRoYXQgcnVu
cyBvbiB0aGUNCj4gbWFjaGluZSBoYXMgc2hzdGsgYW5kIGlzIHByb3Blcmx5IHByb3RlY3RlZC4N
Cg0KU3phYm9sY3MgTmFneSB3YXMgY29tbWVudGluZyBzb21ldGhpbmcgc2ltaWxhciBpbiBhbm90
aGVyIHRocmVhZCwgZm9yDQpzdXBwb3J0aW5nIGtlcm5lbCBlbmZvcmNlZCBzZWN1cml0eSBwb2xp
Y2llcy4gSSB0aGluayB0aGUgd2F5IHRvIGRvIGl0DQp3b3VsZCBoYXZlIHRoZSBrZXJuZWwgZGV0
ZWN0IHRoZSB0aGUgZWxmIGJpdCBpdHNlbGYgKGxpa2UgaXQgdXNlZCB0bykNCmFuZCBlbmFibGUg
c2hhZG93IHN0YWNrIG9uIGV4ZWMuIElmIHlvdSBjYW4ndCByZWx5IG9uIHVzZXJzcGFjZSB0byBj
YWxsDQppbiB0byBlbmFibGUgaXQsIGl0J3Mgbm90IGNsZWFyIGF0IHdoYXQgcG9pbnQgdGhlIGtl
cm5lbCBzaG91bGQgY2hlY2sNCnRoYXQgaXQgZGlkLg0KDQpCdXQgdGhlbiBpZiB5b3UgdHJpZ2dl
ciBvZmYgb2YgdGhlIGVsZiBiaXQgaW4gdGhlIGtlcm5lbCwgeW91IGdldCBhbGwNCnRoZSByZWdy
ZXNzaW9uIGlzc3VlcyBvZiB0aGUgb2xkIGdsaWJjcyBhdCB0aGF0IHBvaW50LiBCdXQgaXQgaXMN
CmFscmVhZHkgYW4gIkkgZG9uJ3QgY2FyZSBpZiBJIGNyYXNoIiBtb2RlLCBzby4uLg0KDQpJIHRo
aW5rIGlmIHlvdSB0cnVzdCB5b3VyIGxpYmMsIGdsaWJjIGNvdWxkIGltcGxlbWVudCB0aGlzIGlu
IHVzZXJzcGFjZQ0KdG9vLiBJdCB3b3VsZCBiZSB1c2VmdWwgZXZlbiBhcyBhcyB0ZXN0aW5nIG92
ZXJyaWRlLg0KDQo+IA0KPiBBbHNvLCBpdCdsbCBhbGxvdyBmb3IgZmFzdGVyIGZpeGluZyBvZiBh
bGwgdGhvc2Ugc2hhcmVkIG9iamVjdHMgdG8NCj4gdXNlDQo+IHNoc3RrIGJ5IHdheSBvZiBwb2xp
dGljYWwgcHJlc3N1cmUuDQo=
