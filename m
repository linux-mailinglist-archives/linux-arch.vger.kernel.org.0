Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98E96B51B3
	for <lists+linux-arch@lfdr.de>; Fri, 10 Mar 2023 21:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjCJUUE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Mar 2023 15:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjCJUTy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Mar 2023 15:19:54 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E000FF05;
        Fri, 10 Mar 2023 12:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678479593; x=1710015593;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=//TmaHr6raPDG+8eiTzN/sDfNSMOm5dWQb+VKv5KBdc=;
  b=UnqW+SQNz5hNWdfMDUL2l11bELNW+toqrIijOYU+HzG572gmIOP+sxbo
   JfnF58qI5xqJ2H25KBahwhBShmxHnFIGS3dty6nb0vjCqW3N1eDChhlW5
   3L2nGxxaC2TaEpxPQKka+hvwRGQ3wjVr0wlpjuRBbnK1/VG7xZJxPQVax
   xMdQ4qpT9LvUd4L4/N/WYiK6T1ZOypGbV/xz0P0lG6r/bPtlNuY4pOUNU
   JyraJxrHNSgUciJut/i78HVtIBhpPCRuri/BHJ4ePrdqoR1YOZBIWGAUX
   XHBSeUlfhav70+qkGTFDGXYlvd9XrOEjLlkEyZUknOY/aVF2hYqZQxwlX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="338376447"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="338376447"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 12:19:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="788154685"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="788154685"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 10 Mar 2023 12:19:51 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 12:19:51 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 10 Mar 2023 12:19:51 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 10 Mar 2023 12:19:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZECxbe30G8a+QScxWQ6BjpmnjTKahFhWAerNCIi/VHSCCKw59yXqN4T2SOZ9DJOSnVa3jjFUADi5hB2WUPe2/aWq+qrOk8nD1DZwA9hEwZORoe+vjdpVMkKwuO7piqsP0ytnkrmiA+kHcPfnBXXhiWb7EnK4cSKo8Oo1tmRP5vzlT8OUgrVvdaQOl8qPoArM9LwcdqV4cXPG9wSpZoO4De1WNB6pVmHjTtF2p/cKzYzxAlMwDBpbmcMxAjDaQuYsvxbVXaJ3fkGqeLFxK13/MjpB9hHQnb8BeFbuMnctdZH55DpBy55HGElk7HLeNy69Fm2Xk5XID0DTH+zMIT+Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//TmaHr6raPDG+8eiTzN/sDfNSMOm5dWQb+VKv5KBdc=;
 b=naYy8jbaoCveTjaMKAgRLaXUDkl8fY8QZdu5RW2O50zZ7ktAlbYHQ7v1T64lQyswv1/FZMqyaa2mBsyhodmOWHmAUqujD+BVyMJQp6P7PYKC8UBwzd11onHYWiU7EdBoTJVB8DMyUTCpYAiEpbpwnMASoVHVmw0ud5PR00hWWp7NDSOty8c5jV3wDIkkX8b6BP2osblEJUnDgw/wrKvn3+/4PiyA7FompB/koyi1LMD0hjlXUptCBVjYs2VxgER3ENg8xt3sa3XjhfhzbwUhp+RuCCVy8UpaLgOL5bqFxl4uzvPR2guJYW8cNl5R64iWr2jgV7E5fEtmjruK9vF+Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SN7PR11MB7467.namprd11.prod.outlook.com (2603:10b6:806:34f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Fri, 10 Mar
 2023 20:19:46 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 20:19:46 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
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
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v7 33/41] x86/shstk: Introduce map_shadow_stack syscall
Thread-Topic: [PATCH v7 33/41] x86/shstk: Introduce map_shadow_stack syscall
Thread-Index: AQHZSvtF2ujwSwjQQE2i7wvNH++zdK70P++AgAARI4CAADA+gIAABAiA
Date:   Fri, 10 Mar 2023 20:19:46 +0000
Message-ID: <ff1cb291574703d027bd3ec9ff5551c34d2ffe0b.camel@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
         <20230227222957.24501-34-rick.p.edgecombe@intel.com>
         <ZAtWp76svXxvQl94@zn.tnic>
         <b85a86e8013280ce17a54d570aa162f1d463a230.camel@intel.com>
         <20230310200519.GDZAuNf+bvYjGtazqv@fat_crate.local>
In-Reply-To: <20230310200519.GDZAuNf+bvYjGtazqv@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SN7PR11MB7467:EE_
x-ms-office365-filtering-correlation-id: 61c16bc2-35b9-4df4-1156-08db21a4cabc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zoRLP14mDVegMGzySNT77/442Mu86WY0KQE4gDaklKRh9kWrcaQ2tpp8MsLd1zlaT7bLTPR8ua0rjHUd7l3wKiv/rfd8dYRoRSyXRcbwXoomD84FQ2KETUekfQ/lNMX5IenBg74W49PkBa27n46UJec950/jy0WtK1zEr7C0BMntmaFsw5/v8JEYLAhVJYNsIf6NxKKDjA9ElggwUKWc0qmmDt5aip+QxiOJ7EEH79npSQ99AEFfLOZq8qmzeJ1biGxsP4U+uwNjk1gV95V4Ou+tk4bkno6E+If6gIZ5tHERmHyhkYRMkg/a+zdpJhU1zjoXxGC6+Kb3x1Xj79TaZVFmS4t2r+zVaIRK6xsgAvGHq5gNnVwUV7KJbVKklJZVDexp83nUFWYRqRQ2JIK+HO5mcUQcmLG4d+QGufAvBOPhZP4MkyRfGZi3M9ZiHJJM6a9siqFeW2GfVQQgxI8ilQdpVSnpVxTlkfE+uepB0X4XywMQxPIN7RdL9wd40QWM/SWFq93EcSjvLz1pFyTumVv4GDkWGiTiQMk7CMMNpj6n/3zEcvagulTLozKWx04f+5IMyYWncgW+GVLGzBvPz9evf1h9Y86vlMZsNwM1iV/bfF3h7E2Q+sV2/AOsFzC0gHn/R0IRiDeKe7sD4mrtX/05G+jREpD0qrqeXy6ootjjTbUoaWZ2vabbLNdJZ6nGZickLK5hP6kzyEgmw/5G0TwUng59Fu1wiwtD9rEhYnU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(39860400002)(366004)(346002)(136003)(451199018)(66476007)(66446008)(6916009)(64756008)(8676002)(66556008)(7406005)(4326008)(7416002)(4744005)(66946007)(76116006)(5660300002)(41300700001)(6486002)(86362001)(8936002)(83380400001)(186003)(82960400001)(2906002)(316002)(36756003)(38100700002)(478600001)(122000001)(6506007)(6512007)(26005)(54906003)(71200400001)(2616005)(38070700005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGJtb3Z3clZWQXN6UVBodjIybGR5SUlqajVJcVYvR3dlVE5zRlZOQzVublZp?=
 =?utf-8?B?akJrb2QrVjJ6TnhLVWxBQTVSK3cvQnlKN2ZLYnNYSU04eGdTVXRnbGpZaGU3?=
 =?utf-8?B?angvU2VLZ1VpR0dvVWJWSWhEM2w2bVBERnlENkl6UUdhZWdlUTFUb2liTmFY?=
 =?utf-8?B?UFEyTGtaL0lBZDcxNU0zTkE5Vm9Rb0VIakhpYjVqV0M1blFzQXRzWkhTYzBI?=
 =?utf-8?B?MWtPWVV4V2IrUElxQXN4K2JXbzRHKy8rbUdxWE5qcEQyeGxzMCsyU2FQYTlw?=
 =?utf-8?B?ZUVCUkdmRm9kcFJybXlVUFpVOUNRNzlKTTR4cllUV2pxcFpSS2VpQnI1Skl1?=
 =?utf-8?B?KzZtczNsSjYzdmZvY1hXQkFrTTZkWDgzd0E5UVhaWEx1SFNsUVYveVNlSWRM?=
 =?utf-8?B?YnBQSFB6QWN4Y1lENk1Scjl1czBLQVBybnBxb3p1UnkyMUhWcnFHc2JBSlo2?=
 =?utf-8?B?WEJqQm56VndoZTFiTGt3L3lHbzI0UkFhZTRWeVZEV0JFajdzQURxMGR5aGtC?=
 =?utf-8?B?bnRZcUx0cmhRMWVCU3E2RW04ZkhoUDNKT3J2YTJzV0JRbGFJYzVnYTZ0dmx6?=
 =?utf-8?B?YzhyWng5ZWZlNWNkYk11K3lDMTlvT3VDNXFidmRKVUVOUkhMSTFXa0l3TlZN?=
 =?utf-8?B?Uk9VRTFia1dOYWVnb0hRY09GeTdBRWpnaEZtVWZnaVlwVlRUR085bXRTT0pT?=
 =?utf-8?B?VzVCVWpsaXNPNDBKU0c0TFRxcEp0T0pydWRGZUtRUVl1SE5Sekx3SUc2V1ZP?=
 =?utf-8?B?d2c2OHR4dDFrNUhtaGFCdmVxd0VQTFRkT3lKY2c5aHpsOUNmN1V0a1JqVEwr?=
 =?utf-8?B?Rk85NFpqVkZYSUtZVG9UTGNXa1d1UHo1VHdiaTFka05aYlA0THhpWm1DNk5y?=
 =?utf-8?B?d2Z5MVBTUS8rWnFGTDllMFJKSFJyRG9WMDltZkMzb1VjODRQbzFaM0N1bTA3?=
 =?utf-8?B?Z3hDSGVFbnM3Vlo5cktDS3FrdDFFbzlKVHVMVDFIMThQNlkxOTJrdjFlWUlI?=
 =?utf-8?B?WFFWTDVMNlVGUmV2NFhlMlhBR1hLMXhZMithK1VCb3BWcENPczBheGQ1eUJE?=
 =?utf-8?B?cHpaRzV3b1o2WFlybTU3MThrSnhqOTFxSUtQYU1mSUNaTkFFaGt2ODZlMjE1?=
 =?utf-8?B?cXNlTzlsZVFUUGVhdnplVzhqdEFrajE3TFdEOWt5UFl4YnJSTUVNTGRmSUto?=
 =?utf-8?B?QkZBT1lKYXdvU24xZzNza3pDeVN2NDVyTjJ5U21XdWxRcDB1aGRIR1dVNW9i?=
 =?utf-8?B?SGFna2ZFbVFDUmR3d2Z2b053N29HVkUxazdRVnJkaERnUEszNVZQRnFSdTcv?=
 =?utf-8?B?MW1vRDVJZ1ZwQXZTY3g5UlVSY0M1UlNJT1E3amlSMzdBRlk1Y2dxNkFSYm9B?=
 =?utf-8?B?UDBDaHd4TmJ5eG1DNnBORUJWb2tjNXRhN2VSNGtHSDBPaUprd0VnQjZzM05U?=
 =?utf-8?B?eGpXN0hGTmFMWjVHYXU4OFdUaGMvVUtRd3l4Uy9VZHlwNkxQb0hoTDdPK0VQ?=
 =?utf-8?B?bmkySndHaTEzeFJFM0MwT1FpWFRIZXNmKzUvc3VuVzZDTVpOaEVvNkQrTitE?=
 =?utf-8?B?TEJ6WG1mdEU0ekI2aUM4NGNaMDBDc1diRzJwRER0Y3I0STZISU9IZWdWYis3?=
 =?utf-8?B?NlZaTzN6TVZsOTErTzNheTZLYnJ1eEZoRnFIbFlqRDdVdFF6OWpwcTBFeENt?=
 =?utf-8?B?cjNmMHRFVHNML1BLWktBcUMxSjcyTVFteHVCL2VwMkF5azlpUWxsTWlyaHE2?=
 =?utf-8?B?T0hFQ1hLakFHRHZHWWlWaXNpRW5ReUlHajgwWGZISUhTWmppeXh2bzJCTS9t?=
 =?utf-8?B?RjVjcm9ZWU5NTklYTnlWRFZ0QWRGWDVBN216emlaSGtiQ0hDZVcxdE4wS3pL?=
 =?utf-8?B?WmRublBrOGYxS052R3hFNDZNSDRza0h0WlhYclYxejNtaFMzeDlscXVOc1c2?=
 =?utf-8?B?ckNMRkl3V2F6Qkg2ay9BYmpDdVhJaDBob3cwKzdBT0tqV3VuNFZlb0FEUFRn?=
 =?utf-8?B?NStrZTJaVU5yNHl4WWhsVVdKbVk1djJOU0FxWnhIb0Z0ZUZJV2JKNWE2SlFm?=
 =?utf-8?B?bDVSeWtyQUFzRklpMmh3QnlWRDBNYlZuRys0N251dzU0WmFOczRMZXFFY2lC?=
 =?utf-8?B?Mjc0QkVMTy9RTVZmakdDNUdoMHFCYWVYWnVoM1ozU0htNTFtc1V2b2dURUlY?=
 =?utf-8?Q?xv30qBgJ+4VOF5vP9g6+OPk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4142724223346943B16865DC1A13FB50@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c16bc2-35b9-4df4-1156-08db21a4cabc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 20:19:46.2264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AUm0LsIpqrVkN9zum8BBN3Fl2S/MAc+wG4n1zNBS2vu+HqKA1i/Q6RpoPZ7t7TR/mg30pS+lsmJ29t1upUggBiQEXpzSxfzQfXirt7GpSUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7467
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIzLTAzLTEwIGF0IDIxOjA1ICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIEZyaSwgTWFyIDEwLCAyMDIzIGF0IDA1OjEyOjQwUE0gKzAwMDAsIEVkZ2Vjb21iZSwg
UmljayBQIHdyb3RlOg0KPiA+ID4gQ2FuIHdlIHVzZSBkaXN0aW5jdCBuZWdhdGl2ZSByZXR2YWxz
IGluIGVhY2ggY2FzZSBzbyB0aGF0IGl0IGlzDQo+ID4gPiBjbGVhcg0KPiA+ID4gdG8NCj4gPiA+
IHVzZXJzcGFjZSB3aGVyZSBpdCBmYWlscywgKmlmKiBpdCBmYWlscz8NCj4gPiANCj4gPiBHb29k
IGlkZWEsIEkgdGhpbmsgbWF5YmUgRVJBTkdFLg0KPiANCj4gRm9yIHRob3NlIHR3bywgcmlnaHQ/
DQo+IA0KPiAgICAgICAgIC8qIElmIHRoZXJlIGlzbid0IHNwYWNlIGZvciBhIHRva2VuICovDQo+
ICAgICAgICAgaWYgKHNldF90b2sgJiYgc2l6ZSA8IDgpDQo+ICAgICAgICAgICAgICAgICByZXR1
cm4gLUVJTlZBTDsNCj4gDQo+ICAgICAgICAgaWYgKGFkZHIgJiYgYWRkciA8PSAweEZGRkZGRkZG
KQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+IA0KPiBUaGV5IGFyZSBraW5k
YSByYW5nZS1jaGVja2luZyBvZiBzb3J0cy4gQSB3aWRlciByYW5nZSBidXQgc3RpbGwNCj4gc2lt
aWxhci4uLiANCg0KSSB3YXMgdGhpbmtpbmcgRVJBTkdFIHdvdWxkIGJlIGZvciB0aGUgNEdCIGxp
bWl0LiBUaGlzIGlzIHRoZSB3ZWlyZCAzMg0KYml0IGxpbWl0aW5nIHRoaW5nLiBTbyBpZiBzb21l
b25lIGhpdCBpdCB0aGV5IGNvdWxkIGxvb2sgdXAgaW4gdGhlIGRvY3MNCndoYXQgaXMgZ29pbmcg
b24uIFRoZSBzaXplLWJpZy1lbm91Z2gtZm9yLWEtdG9rZW4gY2hlY2sgY291bGQgYmUNCkVOT1NQ
Qz8gVGhlbiBlYWNoIHJlYXNvbiBjb3VsZCBoYXZlIGEgZGlmZmVyZW50IGVycm9yIGNvZGUuDQoN
Cg==
