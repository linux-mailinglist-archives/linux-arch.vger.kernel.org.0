Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A1A6A6288
	for <lists+linux-arch@lfdr.de>; Tue, 28 Feb 2023 23:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjB1WgP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Feb 2023 17:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjB1WgN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Feb 2023 17:36:13 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135AE366BD;
        Tue, 28 Feb 2023 14:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677623756; x=1709159756;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2+F3FjvrRVAzdjvVNYDqqRewIo4SHZ09/3WHNjN9sbQ=;
  b=S0HE2F5HJIYwkuh/v2hK9B3fIhwA6kmiNTscczyjTmfm/E8/tdOKaM9V
   naql2B08H6M3k+TNAGe9WKo8NH9ggHHJPQJXogEKKDiU5DBnEN6tdaeaO
   TxxUM1cZnxz5FjCO59uFuSXVSb7xMb4Ih14j1pG+IFhnbIq3sthJ5ku1I
   Y0Y/dmbvXIlSPHkWli8yr7i6wugVqIV//Yu9IjaLFj7wZaMKkp67loJvT
   rzlEdpZnR2825nhIvqPGvi6kUG9eDytGBwjiyszUtSF7cl0SJvrWgxbBx
   2+ETehXhObuCAnTrRWLLvDv9Cqy9TUaAwDxNqr4koV9XwvBJnlMRUN6wP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="313937162"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="313937162"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 14:35:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="704586910"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="704586910"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 28 Feb 2023 14:35:43 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 28 Feb 2023 14:35:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 28 Feb 2023 14:35:42 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 28 Feb 2023 14:35:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdFT+aUe5uPkmgrkC4P20C3/1GxOvevMvl7pKnlPJ07OnM5l1mKflKsMxAnsjEO2W716duYHVVvsTioiejs2A+/aNgEZTOSmD6AlQztp0ShTi2Q9taCBIhTYF5PzHIe2kx5sQpqyjRzDQzwtDM6tyrCWJZ2DvJmh1l3264f/Y7xvrtg2RuIoFiPtfepydifcUvG/SsBdIwxo6O/5+BiPvHpY9zkcIy/BbO/g2IbhiKy3YWE2yuX4ujv1eEFRGaKpb0yD3M+RIPHuo2H/COx7AfIl/G/Jt4mnE8+CbtUgmVAfl3oQau6cHf+1tHbTBD49Jp/OGQPQV/4vwA8HQCt2pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+F3FjvrRVAzdjvVNYDqqRewIo4SHZ09/3WHNjN9sbQ=;
 b=A6lpbYXTkNM6Jjwurkr9gUrB5QH/H88d0jBEloA8b3O626+VhJpMkDTp77C6MXOWx//87K64seRB4B2Km3bVPZIA0BxPokx10X/J9jB/OF54usXIlXhImGvqBKVbKMYrD1zdYW2gQ8hVXU5zv4E3AEC4vMB4++4d7Q+jnNSLLriMuABjXo4aC67jNUk5v7jsDqHcCPGZ6jd6XOY3onFiMaiWUp0wRKwLv5vJVbetnkWGQPW7w9Fc1NziJbHzCaEU8Dz1c+ZeWXe3csJVwOHtWhfYL3ncpr3dSboMtrSaIuhc4yt2C61FXRaFvdzmbA39ZILfjCNZbnLX7KsCQyakMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Tue, 28 Feb
 2023 22:35:39 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 22:35:38 +0000
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
Subject: Re: [PATCH v6 28/41] x86: Introduce userspace API for shadow stack
Thread-Topic: [PATCH v6 28/41] x86: Introduce userspace API for shadow stack
Thread-Index: AQHZQ95DLT0p3p6er0+nOfRd208Kja7eDPuAgABpgQCABcjwgIAAwsyA
Date:   Tue, 28 Feb 2023 22:35:38 +0000
Message-ID: <ef5086cd2480ac1a8d0d752f8a019148c3d712b4.camel@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
         <20230218211433.26859-29-rick.p.edgecombe@intel.com>
         <Y/irg8d6OZ+OCFml@zn.tnic>
         <9c67abd16cce9251bfdb87bcc7e47bbf32e4a9f2.camel@intel.com>
         <Y/3eUQEV95gZEoaF@zn.tnic>
In-Reply-To: <Y/3eUQEV95gZEoaF@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|DM4PR11MB5262:EE_
x-ms-office365-filtering-correlation-id: 47daac59-5837-4310-d8ef-08db19dc1db6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ifdzA+J81FdCbiPndKF/BzdLsCJDTWnZ1BgQqPrRfNI6J7BUP0FdnB6g3vBjBPJ7cjFCGKIEEKw9rXTK5NW8kNWeOSEaM6Fwj1SWd2JBsqjee9BNS/4tply8kPwf454qA5YAQdeY65baadEJIPqIVQAYkN+lbHKFvMr4CLybswvtPBr4seGlDsToPmW41M0hvcWFQlbzgbv7S6RfsMjykx2hCgEJKaw72X5XirCa6iqiPqQwGPRs1aTFQxZn1CaqaTNaGQKqyzH7lp1AAQXCkknsPQfVju5t+82CJ63tuiQwC4G2uw6LenOCovNIMIrQAFZMsU14gQ7XYJ48NAvORr6dJqn/UxMM4Jip1xeznIf7+CTRj7gpD5BGOgVqim15l+zXbyT7tqR4BIAMNVwPFBwzTwbwX8WNsPXGB+MvKOBYGwjt3V1ENLoFfEFr/7TwxO+PyGx2qU1i0WR8+NqU1yEwEh4poW966r37uq67lWmwsTJi3vNrrRYE9wT1qty0S9ikvaXzbPQ8g+qto6uk21Ra1lckgT9hIuAbYmVZPnZE/rHtpAtL4v0AmGjI6KCiii+4g7ITLMbIZFJnSeruf9ij5Ci+PkulP1nLzfTh+zOgRAhZ12Pch8/VJU9/3pZXpD8cXdUNe+vfrQhRX6yU1rhZStvfBosy89oybZxrbZYobYIolqCNhaOTHFoAOg1grFwOfxJkUSMz8htRw/zo52yqkA092/JMOUEv/ycIRNxfov5kPtGa0+26oX1S2iKAOCgIq2M4XBJ16hu4NIzmYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199018)(36756003)(54906003)(316002)(7416002)(6486002)(966005)(5660300002)(7406005)(478600001)(2906002)(8936002)(71200400001)(6916009)(8676002)(66946007)(76116006)(91956017)(66446008)(4326008)(66556008)(64756008)(66476007)(41300700001)(82960400001)(122000001)(38100700002)(38070700005)(26005)(6512007)(86362001)(2616005)(6506007)(186003)(83380400001)(66899018)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVNsWXFwbzM1UVhsRHB3VllNNUVxUzRYcTFMVHVsZWxEdVV4NERhT010czI5?=
 =?utf-8?B?VEJDN2NVSS9Wa2dGdTNSOFdzNm1kdk1OWmhqZjFYUnRIWCt6Tm03T1dkbmxC?=
 =?utf-8?B?Ym5BOHExOGl0azhYWTRYMzRCaW1mbnc5ZHI3VE9CWTRnNWpQRU9PWElORE5o?=
 =?utf-8?B?Ymx2QXU5cHFoaVZ3RHU0djMwS0piOFB3dmJtNEZYZUF5Qmt1WVp0WllWaS9h?=
 =?utf-8?B?bm4vcUIwRllLQ2VOOGVVZWdpV3JvQnNva0NxMDA3dmRBazdpbktBZ2J3WWtR?=
 =?utf-8?B?a0tQRjZueVdhYVIxUlI4MzdRdFR5V0VEKzhQUTdiT0wvZ2dRS3cydGN6TG4r?=
 =?utf-8?B?QU5nVnV0THpWT2hkbUM4Ky9qTjFwRGhqWC8yZnY3eW1HT3dmcEM1azdYWEFu?=
 =?utf-8?B?TFF0LzNLVThneVRnZGxBMFlEcWNJM0Jzc3QybnJnQmF1THoyQndHUDhOYTBj?=
 =?utf-8?B?NU9LRWJ5TU00eURQcllJMlhYMzJrM3BHbWRFS2JSVnV3aGpRNjNyc3BtMVF0?=
 =?utf-8?B?ODNPZWVGMU82Tnl4WWx4TXlKcXRzdTdXbnd4em5QK24xa0EyRmxrNkZPaFJN?=
 =?utf-8?B?dEJqQzE0b3VhYVNOS1ZYalJhejZhOStLNzFkMUNQUHlYUmhlUklVSzNwUXl3?=
 =?utf-8?B?UmdNWkVRV1Fod3RlNUtrVDl1a3g5MUNVSnNpalJHYzhrZVNRbXdYRG1ycUhL?=
 =?utf-8?B?dk9lbjJ6UUpQV0pKTVhCNEplWDNzalEyNllaVld5MkNYNU55bUZmMXZ3T0pK?=
 =?utf-8?B?WnVnZmttUy9WUU1xL1dSTEppbVJraUpPUDJBY2ttN2EyVFF2SHZqS3NjZFpx?=
 =?utf-8?B?QVJ1dSs4MjVkaFRUQkxycjNJd1lBcEZvamlPZndHTDk3S25NY0RkdHhRTVJj?=
 =?utf-8?B?cnpPL1dLcjUyYm5OTlhIbmFpaDVPcnQ4NXI5amRuM2ZWU1BBOGJkVWhnVlAr?=
 =?utf-8?B?RE9MbXE1R0dMemxwdzRsTEV6aHB1MUxRN3ZxaGpDMGpObmRVLzVwMy9hNUNM?=
 =?utf-8?B?eWVDejg4S1BSN0c1bWcxdmNZMkRNZzNOdmthMkhWRWY5SitibnRDWnoycEpL?=
 =?utf-8?B?VlFhYmdnR2RoMUlHbGZnbEhBdktBSmRuODdpeWJ2NjVqRUNyU0tOSU04NFRE?=
 =?utf-8?B?ZVMwSmpwZUg4VHRHWGpzMC9nSDNVSTNha3hVNWZBVGVEOXhXNGpmU1IzM1Ju?=
 =?utf-8?B?STJ3RjhuTDlCZVp2QzNvWG5wNERvb2hPYmhncXVkUzI1S2JkU3JJY2Nzb3dm?=
 =?utf-8?B?QUpaYXROM3VxdFY3M0dHekgzUlQ0aG5nQmE4RG9WMEt6dFoyNHRtY29PODlJ?=
 =?utf-8?B?M0tDT0o4T2lFbFVRZUllZllEWklTSjZHcDlicnUxTzkrODhFQXhJYWU2SDJw?=
 =?utf-8?B?clRnVXIzZkdlMFJ0TWRnZG84K0lxQlZkakFRNHB5a0VnVDM0cEZQRjNtSWRj?=
 =?utf-8?B?dFJsM1pZcmZvZ0VrelkvYVlBanBmOWJITVJVdm1FbzJSaktaelVUeFYwb00z?=
 =?utf-8?B?R2drQ1lDYWd4TVkyWTBIWmE4SkNvQy9mSVY5Zi9HOEcyMEJaYXVjOXEyZld4?=
 =?utf-8?B?NUxjRmFsRVdpWWFjZkFyTTBJQ3ZlQzZqZzdENzZTeGl6VUdUMTFSZVJjZzcy?=
 =?utf-8?B?a3lMTjEyZHFLMTc1UEc4U1VEWUIwUFZLZDhObHMwMHFYMzhCMTNCZ2dDa3BG?=
 =?utf-8?B?ZFFWeUJEOURQSnd4c0czbE1JK05ja1lWUjVMblF4bmhqN1laV1lGVVJhVXdS?=
 =?utf-8?B?dzFlalEyVUIxcDNMcnNEby9jSGpVdUR2UmhOS1BOWjdKMkhzQTUwZElNS2RV?=
 =?utf-8?B?MVQwbDFoK0tFQndpdnBNRDJVeGdWQzhvNkFSazk3ZDY0WkNSNldKRk1xdWJy?=
 =?utf-8?B?YnNjczJXM255ZTVGMG9kUXA3cm9idnRTQWZ5eXVmcFJkUG41Zmkwc25PVm1I?=
 =?utf-8?B?NWFBYUdwM3o0a0dwTGprM2t2aDl4RENsUlE2OUtCMTJZOVNzb2NFTmFKVlFu?=
 =?utf-8?B?TnRaR0F6cG5vbHI4eEVyV0pIUjJEbGlPNGdxY29tWkZPUzU0RmU2MXhjVFlJ?=
 =?utf-8?B?eDc4YkJDbVI1dEJDRzh0MHFtUjB0VXdFVzNFMWFQZkg1Tmo0dkVkbzBodzNa?=
 =?utf-8?B?MG1vU2JRT0RKK2JManN4V0ErdHVFaDJFSlQwWHVUdHBqWmFObEZRL2R2cTh1?=
 =?utf-8?Q?6YS+k/70II+N1Q5M2E8FkdE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1895D26761AF14996E82E44BA6BEC28@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47daac59-5837-4310-d8ef-08db19dc1db6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 22:35:38.4454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zi995H15G4aFiTZKhEzQUpG4Hs1xWhSJXki4smaZP7w7CdfKlU7d2YOO2TZbp+Xxp3jU5ljXjn7AGn+bezlth3/g2MsaVXXRmNY2SlWVgUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5262
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIzLTAyLTI4IGF0IDExOjU4ICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIEZyaSwgRmViIDI0LCAyMDIzIGF0IDA2OjM3OjU3UE0gKzAwMDAsIEVkZ2Vjb21iZSwg
UmljayBQIHdyb3RlOg0KPiA+IEluIHRoZSBmaXJzdCBwYXRjaDoNCj4gPiANCj4gPiANCmh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMzAyMTgyMTE0MzMuMjY4NTktMi1yaWNrLnAuZWRn
ZWNvbWJlQGludGVsLmNvbS8NCj4gPiANCj4gPiBUaGVuIHNvbWUgbW9yZSBkb2N1bWVudGF0aW9u
IGlzIGFkZGVkIGFib3V0IEFSQ0hfU0hTVEtfVU5MT0NLIGFuZA0KPiA+IEFSQ0hfU0hTVEtfU1RB
VFVTICh3aGljaCBhcmUgZm9yIENSSVUpIGluIHRob3NlIHBhdGNoZXMuDQo+IA0KPiBSaWdodCwg
SSB3YXMgdGhpbmtpbmcgbW9yZSBhYm91dCBBUkNIX1BSQ1RMKDIpLCB0aGUgbWFuIHBhZ2UuDQo+
IA0KPiBCdXQgeW91IGNhbiBzZW5kIHRoYXQgdG8gdGhlIG1hbnBhZ2VzIGZvbGtzIGxhdGVyLiBJ
LmUuLCBpdCBzaG91bGQgYmUNCj4gbmVhcmx5IGltcG9zc2libGUgdG8gYmUgbWlzc2VkLiA6KQ0K
DQpTdXJlIEkgY2FuIGFkZCBzb21ldGhpbmcuIFNvbWV3aGVyZSBJIGhhdmUgYSBtYW4gcGFnZSBm
b3INCm1hcF9zaGFkb3dfc3RhY2sgd3JpdHRlbiB1cCBhcyB3ZWxsLg0KDQo+IA0KPiA+IFRoZXJl
IGFyZSBnbGliYyBwYXRjaGVzIHByZXBhcmVkIGJ5IEhKIHRvIHVzZSB0aGUgbmV3IGludGVyZmFj
ZSBhbmQNCj4gPiBpdCdzIG15IHVuZGVyc3RhbmRpbmcgdGhhdCBoZSBoYXMgZGlzY3Vzc2VkIHRo
ZSBjaGFuZ2VzIHdpdGggdGhlDQo+ID4gb3RoZXINCj4gPiBnbGliYyBmb2xrcy4gVGhvc2UgZ2xp
YmMgcGF0Y2hlcyBhcmUgdXNlZCBmb3IgdGVzdGluZyB0aGVzZSBrZXJuZWwNCj4gPiBwYXRjaGVz
LCBidXQgd2lsbCBub3QgZ2V0IHVwc3RyZWFtIHVudGlsIHRoZSBrZXJuZWwgcGF0Y2hlcyB0bw0K
PiA+IGF2b2lkDQo+ID4gcmVwZWF0aW5nIHRoZSBwYXN0IHByb2JsZW1zLiBTbyBJIHRoaW5rIGl0
J3MgYXMgcHJlcGFyZWQgYXMgaXQgY2FuDQo+ID4gYmUuDQo+IA0KPiBHb29kLg0KPiANCj4gPiBP
bmUgZnV0dXJlIHRoaW5nIHRoYXQgbWlnaHQgY29tZSB1cC4uLiBHbGliYyBoYXMgdGhpcyBtb2Rl
IGNhbGxlZA0KPiA+ICJwZXJtaXNzaXZlIG1vZGUiLiBXaGVuIGdsaWJjIGlzIGNvbmZpZ3VyZWQg
dGhpcyB3YXkgKGNvbXBpbGUgdGltZQ0KPiA+IG9yDQo+ID4gZW52IHZhciksIGl0IGlzIHN1cHBv
c2VkIHRvIGRpc2FibGUgc2hhZG93IHN0YWNrIHdoZW4gZGxvcGVuKClpbmcNCj4gPiBhbnkNCj4g
PiBEU08gdGhhdCBkb2Vzbid0IGhhdmUgdGhlIHNoYWRvdyBzdGFjayBlbGYgaGVhZGVyIGJpdC4N
Cj4gDQo+IE1heWJlIEkgZG9uJ3QgdW5kZXJzdGFuZCBhbGwgdGhlIHBvc3NpYmxlIHVzZSBjYXNl
cyBidXQgaWYgSSB3ZXJlDQo+IGludGVyZXN0ZWQgaW4gdXNpbmcgc2hhZG93IHN0YWNrLCB0aGVu
IEknZCBlbmFibGUgaXQgZm9yIGFsbCBvYmplY3RzLg0KDQpFbmFibGluZyBmb3IgYWxsIG9iamVj
dHMgaXMgdGhlIGlkZWFsLCBidXQgaW4gcHJhY3RpY2UgZGlzdHJvcyBkb24ndA0KaGF2ZSB0aGF0
Lg0KDQo+IEFuZCBpZiBJIHdhbnQgcGVybWlzc2l2ZSwgSSdkIGRpc2FibGUgaXQgZm9yIGFsbC4g
QSBtaXhlZCB0aGluZw0KPiBzb3VuZHMNCj4gbGlrZSBhIG1peGVkIGNhbiBvZiB3b3JtcyB3YWl0
aW5nIHRvIGJlIG9wZW5lZC4NCg0KSXQgaXMgZGVmaW5pdGVseSBhIGNhbiBvZiB3b3Jtcy4NCg0K
DQo=
