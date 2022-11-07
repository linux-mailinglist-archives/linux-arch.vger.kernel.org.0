Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEE561FE7A
	for <lists+linux-arch@lfdr.de>; Mon,  7 Nov 2022 20:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbiKGTTi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Nov 2022 14:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiKGTTg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Nov 2022 14:19:36 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FC729CA4;
        Mon,  7 Nov 2022 11:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667848775; x=1699384775;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uQw2dPLLO5/H+5s6Ge9ln9r5vsGQQI9hEoysCP5S/js=;
  b=UK2QQg5V82vyqYFAvWN9b3DdT4/UlbMCpmJX3yQw9+s7PXU3y0U9P8rK
   QyT1knbHLLQ8ABQoYnUTm/omFXmNVJzcBlUJXSlz8z30veceQHkVzvHyy
   J942k/VcXGb8n1W9JEWomfeQWNowEtpu5ElffwaQmjfl/qYD11LEnN1jp
   /f5znCii5yCiuyRW+S7xg2WnFesFeC+z/96wnrUTQai4q9OYKBFhiBd2B
   sT+9Gj/rBAl/byxxTmxlC2FuUTQrpWVgRQyUXurcnO4AWxAF/IPcv60x2
   WWHk74zGNxzFylGxDm6IObyPVE3TkbyJmshX8Fb8LBQokJvPDxjbVQg5Z
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="312286735"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="312286735"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 11:19:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="630602559"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="630602559"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 07 Nov 2022 11:19:33 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 11:19:33 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 7 Nov 2022 11:19:33 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 7 Nov 2022 11:19:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8JuDmLFgC+nD49xpiGzuaUtnhrarN94QwRMLG5ifIZ1VUsU8JLxENMovKNrRqLJmhqqZpOx6VFnVy5QX66Bfnx0/qJhnDE1CW5QUIWt8l310u6iH/voGQON0tmX0EuTu04Dmz8qTcO8ewt6ku6iGRE5Qggm7cuYP4s+N5afEa8MZPF8iMKW2DgDwwbAx502BbMRaoXWPwYDPvQ3gpCiGuptOLSoLJtwuQVN2lOd2nb+JMjzTmW16vNVaVU3zlhsuhR2u4/Q4N7ioTOwi2Vrrnc/QPuzuMXJ6WxKwblI8I17SUTDE4w32CJNTWw0oNu4M2pffe/bOAc4Oal4nMwWkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQw2dPLLO5/H+5s6Ge9ln9r5vsGQQI9hEoysCP5S/js=;
 b=EgPovNlSxufutpiOk5gEtQFE5D2GDZyBYQV0FwJM4ENeXq/HaT/2zbHscw/KiRIfdoeGZscJxUz3FsLayIHyR3W4nF7dnLVlzNRiOqm0c2lYUq5mfo8nqKNjYd6Pm5ifrf5ecIZLwBnn7aIytg8RG2gbIV1ip+1FDBufjsk9TkP1KPKwmUhgt0CGCkrjR2Z60OmneLNKOEGRB3Yz2fXg3BxvocFqduTDRZrqDtrs1cMyZ1JMJoBFx63+eF1dhawZ7np2RVo9KGVb2Vw4xIZuAadIWY6h0SL6yyJLlUh9KYNFCg8FXZnIgdjfVjJtqYlJhrw8L1yhdkRsanqSpI867Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by IA1PR11MB7385.namprd11.prod.outlook.com (2603:10b6:208:423::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Mon, 7 Nov
 2022 19:19:21 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5791.027; Mon, 7 Nov 2022
 19:19:21 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
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
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 04/37] x86/cpufeatures: Enable CET CR4 bit for shadow
 stack
Thread-Topic: [PATCH v3 04/37] x86/cpufeatures: Enable CET CR4 bit for shadow
 stack
Thread-Index: AQHY8J5NR6vBThIFiE2muQ7xksETCK4zxHGAgAAFWQCAAATlgIAAC8AA
Date:   Mon, 7 Nov 2022 19:19:21 +0000
Message-ID: <48643073afcca661971bd7475c04659e453113cb.camel@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
         <20221104223604.29615-5-rick.p.edgecombe@intel.com>
         <Y2lHxb5BnbQi499s@zn.tnic>
         <14b4c6e3d5b7b259e832ff44e64597f1cf344ffe.camel@intel.com>
         <Y2lQXXCQRTiYljIg@zn.tnic>
In-Reply-To: <Y2lQXXCQRTiYljIg@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|IA1PR11MB7385:EE_
x-ms-office365-filtering-correlation-id: 98e948df-3b4f-45d1-8541-08dac0f4f981
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cL2lkSXkY0ehCO+ds2Cg57FRDucftG6NNWbUuCaDbuLaSCek98IynzYKKp80le12YpcycVB1ENgwQYbsHRYhuYRr8SGbAynXE81hmU6V1kulzfTqy7DyuRtasU9MhnzpNYcwNd1OvTZ2Q63Y5epTW8qw4qifWw1c5v2mZB8E4h2fgxXp8cfQmO1M6AaTlQ030oCmgl5xatVAuE5xyoVCA65WpYC0FeYEMQzOVM2ID4Zwoa60own9s96F1HebZ42ttOcAewK+Y5oXWIzqXL2VEFqOBk9UHodUSKRPSDtYMYJHkDFdWurDcSQoR+rk4AjiPnoz5TTTuKp60nDL1407LTS/TD6Uzbe34GKQYE+0l3ahu+y9MPyyseDuS5RswDFntuVKV9syDAG8/4Go8FSH0p5rA9aJ/njauCO091RprfZ5oHmGltgI18M+KOKEMXvmjw4hgH2XiAafJQfKgkdMrKtQtgxVRNG/20vdbxBGPURY/noLBqgc5rUq9mt2E/Xcjn+XvqsoaldzSSTa5Anm+uFKjRywPelOS2yFtMTKRQtoyqWyejs04geHrl8jJiuLDVA6pm5lfv732dpPtT9aPGQFfn3bJIQ8x1XJPQrVWPVwWpsW4EXfADsY3ArOnHL4WjL5AJ7Q6tF7qmXrFfA8QGk5xsclOKKPSvZtwkgNQLYrXFfGHfEYNu/8SM6mYt9/7m5IGK9AHRq5V/ZMB3ntHe1qEMUv6JtMZVHjllOJGHgM2aFg2MRME3yMfnRGUfWX2wfErPHUqFnMKAiwtg9JqVbX6oc0RqrY2tmOaoVtkPGlHX/u47cSpNjiYbJcH/1VV85r/HJwA4PrMTpBq7EYag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199015)(316002)(86362001)(122000001)(36756003)(66946007)(8936002)(83380400001)(5660300002)(186003)(64756008)(2616005)(2906002)(66556008)(66476007)(76116006)(66446008)(6506007)(8676002)(26005)(7416002)(41300700001)(38070700005)(4326008)(7406005)(6512007)(478600001)(6486002)(966005)(82960400001)(54906003)(6916009)(38100700002)(71200400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlFITiszaTJobVViYVBHYllSejFtZDdBdE42cjJpNmRMOWVORHcwZHprRU9U?=
 =?utf-8?B?UmxyQTRuSjRVTTN6eXlKeVd6VURLMXdSdm5DTFZWeXN2Vmo0a2drbjR1eERJ?=
 =?utf-8?B?QkRoYlhUMDQxNXJBTU5qSDJkcDNWZENLdkk3OS9ocC82ZlZJMHpwbzByT1NR?=
 =?utf-8?B?NGp2TmV3SXRrWU81UHlTL0liMlYydEtCMU8rbVJyVlpZQTNxSzc0YWx0MEpW?=
 =?utf-8?B?MTVwMEV0OWJWZWdubU0yOHA1Z01jM0ZKbFBCaXM0UlBYZzdWY1ZCbFZubEFv?=
 =?utf-8?B?TSt6bjhnVUxuUVZWNVpBbC95blU0NHk2Y1U5bElTT2ZKc2lyTXlSbFdyd1Z4?=
 =?utf-8?B?bnFzQVhvcTd0SXluUURrVUIzYzZZWUI2WjZ6NS82NmVxUFJHVkIyUVJZUFRr?=
 =?utf-8?B?TGx4a2VSVWNBdmJqSFIyU3Q0TFlDbnYvZlViNkVBa2NNNkNOODhkTVg1Smp6?=
 =?utf-8?B?c1d1SE1FUnFzRTJEbnNlcWxhQ0d4MFBpcDB6U3Yya29pdk1WWFJ5djJkclNB?=
 =?utf-8?B?QWNVNUI2ajVhWDRpenk0UWVJUThyMDZDVCs3ZkFuNFEwMWVYYjYwQ3JXbmxC?=
 =?utf-8?B?TDlaWjNjdEF5ZnA2MWY4dVo3WmJGRE1ZZXkrbGc0STJpbjh2UVo0RWRLT3dQ?=
 =?utf-8?B?bktGQXpJVTlRZWtkTGxXRlYzT3BPR3JqS1cvclRocUV4amd6VS85QzF0cjAw?=
 =?utf-8?B?YnFHZktDaW43Y0w5cER3NVdmSEkxS0szN1pPem4wU25ZMWlwYjIwYytXaVk0?=
 =?utf-8?B?Sy8xTDNXMEw4U1pwU1QxWXJyeS92a1Q0ZURnR0pxVW1kaGlsZUgrVzA1MFdO?=
 =?utf-8?B?U3hYaDVaOXU3aXlXblMwQnB3VFhmYmh0OUVUcTl0SDBpK0NJenU5NG5CVWto?=
 =?utf-8?B?aVNpR3E4bWhHQzlaV0trVGtSbUZzTjduZ2tTUFlVQnQydzBkck1talpzUnVl?=
 =?utf-8?B?M05tbjBsZXdmRHI4VkNxa1U1NWkxY1gzTG9iUUp5UXRyYkxSV1lUcHBveWIw?=
 =?utf-8?B?YUVvOEJyUFFXand6bTdDN2VtZ2NlaTFVWUgxS0VoMk9KQjJZdUNqT1lBM3ds?=
 =?utf-8?B?SzErRWVISmlQeFNnbWQ5Uk9nSDg4S0FnMVVuYjdWcmdsUmNmSzlxMkRNSFho?=
 =?utf-8?B?MGF6OGc3M3czTlVlanNQM2VhMi9QcHc1dWdBVWtBay8raVNVSHh6bzQrbkVO?=
 =?utf-8?B?UEdHNlBsVE56RzJkTDJ1RWFqSG41a0lNdWhYUkpTZS9NRHRZQkdqVERPMFhD?=
 =?utf-8?B?bk9iWUpqQzVkUjhvQVAyOUI3VUk5SmkzaVMzYnBULzNLNGYvbzZtNHY4eUNS?=
 =?utf-8?B?bXdnSVRYcXRPTTYycHU0OXBQNHhCOGROZHdnNHdyVnJ2NERQQTFkQWg3UmFV?=
 =?utf-8?B?Z2xuN0hSZUdMVzRYMDRnRWFUUnlHeGhSWm92ZjlCamZUS2FoeWx5VWR1NVRQ?=
 =?utf-8?B?TVVKYTUxaEZKZDMyTGR4MmVkbTFHT20rOXVWQzRhQWptM0d0Mmo0eUNtc0s1?=
 =?utf-8?B?a0t6ajJXSFVEUDA3RXo5M1FFQ05sRnVOMVl0Rlo1amhmTzg0aHVuK0h0U2lv?=
 =?utf-8?B?aXN2bjF2Z2NHK2dCWnowSnhOZmZLTDd6U3BzS0p2d3Bkb0VIOS9PaTg3NTJS?=
 =?utf-8?B?MzZtbE42bDBIbHYrN1VKQ2RXeGh0MDRxSEZubVhrYzg0cDZncGxjWkpaTjNQ?=
 =?utf-8?B?SDA2T2szR1VHMEt4L0NNQ3pXMklIbWFFWGoyU0xSbHdGbzBORHQxYkhZZGRk?=
 =?utf-8?B?YnBEYWtHRC9WVXBwRGFrREpBNERJRCtxR2pTYXBST0V4azNwSTZ3UE1QeEJx?=
 =?utf-8?B?dUtjcDhuUjQwS200SWJQK0RoT3VjYTFzYU1ucHJjNkRzZEE5aGdvWm1md3Za?=
 =?utf-8?B?YlU2N0NTVXp5Lzh3UFRlalpHclpkam9SbWZXWlljek5JWWhRbkc4aFBPMmd0?=
 =?utf-8?B?eVJjM0RMSVNyUHoxMmtTdS9xbWZ5dndaSVNudXlPdFAzN0NPaWpVY0EzN3Ay?=
 =?utf-8?B?RXhucFNvN1JUYUxBYS9LUlh4ZGZUa0FjODRPbXZ3cFd2d3BDeGc2K3FOWXBq?=
 =?utf-8?B?ZlV5ckR4K0p5NTFjSW9zNUdIdnJ2LzdvSXFKR1Rvc3lORFRwMyt4RXkrcFFE?=
 =?utf-8?B?MjVpWEZock8xS1BpLzZ6eWRxKzNTTDhESXBpS2tvM0FMWW1JT20rQ1VQb2Np?=
 =?utf-8?Q?zx4t99D5TjdrYibg7CKiGbc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83C7C60DB14F7547AE03FD5A018F056C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e948df-3b4f-45d1-8541-08dac0f4f981
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 19:19:21.6289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MWNcR16feqMGljavu2TjWx2iGOtj9A87kwB3/zJHLH9yCKFx32ctFtHgI7I7gcO+Gn5+A/sd41FUI+l+7wzfpFevDPhMdPfrpCLqCyL1tgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7385
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTExLTA3IGF0IDE5OjM3ICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIE1vbiwgTm92IDA3LCAyMDIyIGF0IDA2OjE5OjQ4UE0gKzAwMDAsIEVkZ2Vjb21iZSwg
UmljayBQIHdyb3RlOg0KPiA+IEl0IHdhcyB0byBjYXRjaCBpZiB0aGUgc29mdHdhcmUgdXNlciBz
aGFkb3cgc3RhY2sgZmVhdHVyZSBnZXRzDQo+ID4gZGlzYWJsZWQNCj4gPiBhdCBib290IHdpdGgg
dGhlICJjbGVhcmNwdWlkIiBjb21tYW5kLg0KPiANCj4gSSBkb24ndCB1bmRlcnN0YW5kLiBjbGVh
cmNwdWlkIGRvZXMgc2V0dXBfY2xlYXJfY3B1X2NhcCgpIHRvby4gSXQNCj4gd291bGQNCj4gZXZl
bnR1YWxseSBjbGVhciB0aGUgYml0IGluIGJvb3RfY3B1X2RhdGEueDg2X2NhcGFiaWxpdHkncyBB
RkFJQ1QuDQo+IA0KPiBjcHVfZmVhdHVyZV9lbmFibGVkKCkgbG9va3MgYXQgYm9vdF9jcHVfZGF0
YSB0b28uDQo+IA0KPiBTbyB3aGF0J3MgdGhlIHByb2JsZW0/DQoNCllvdSBhcmUgcmlnaHQsIHRo
ZXJlIGFjdHVhbGx5IGlzIG5vIHByb2JsZW0uIEkgdGhvdWdodCB0aGUNCmFwcGx5X2ZvcmNlZF9j
YXBzKCkgd2FzIGhhcHBlbmluZyB0b28gbGF0ZSwgYnV0IGl0IGlzIG5vdC4gU28gdGhpcw0KY2hl
Y2sgeW91IGhpZ2hsaWdodGVkIHdvdWxkIG5vdCBiZSBuZWVkZWQgaWYgd2Uga2VwdCB0aGUgY2xl
YXJjcHVpZA0KbWV0aG9kLg0KDQpUaGFua3MuDQoNCj4gDQo+IE9oLCBhbmQgYWxzbywgeW91J3Zl
IGFkZGVkIHRoYXQgY2xlYXJjcHVpZCB0aGluZyB0byB0aGUgaGVscCBkb2NzLg0KPiBQbGVhc2Ug
cmVtb3ZlIGl0LiBjbGVhcmNwdWlkPSB0YWludHMgdGhlIGtlcm5lbCBhbmQgd2UndmUgbGVmdCBp
dCBpbg0KPiBiZWNhdXNlIHNvbWUgb2YgeW91ciBjb2xsZWFndWVzIHJlYWxseSB3YW50ZWQgaXQg
Zm9yIHRlc3Rpbmcgb3INCj4gd2hhdG5vdC4NCj4gQnV0IGl0IGlzIGNyYXAgYW5kIGl0IHdhcyBv
biBpdHMgd2F5IG91dCBhdCBzb21lIHBvaW50IHNvIHdlIGJldHRlcg0KPiBub3QNCj4gcHJvbGlm
ZXJhdGUgaXRzIHVzZSBhbnkgbW9yZS4NCj4gDQo+ID4gSXMgdGhlcmUgYSBiZXR0ZXIgd2F5IHRv
IGRvIHRoaXM/DQo+IA0KPiBZZWFoLCBjcHVfZmVhdHVyZV9lbmFibGVkKCkgc2hvdWxkIGJlIGVu
b3VnaCBhbmQgaWYgaXQgaXNuJ3QsIHRoZW4gd2UNCj4gbmVlZCB0byBmaXggaXQgdG8gYmUuDQo+
IA0KPiBXaGljaCByZW1pbmRzIG1lLCBJJ2QgbmVlZCB0byB0YWtlIE1heGltJ3MgcGF0Y2ggdG9v
Og0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIyMDcxODE0MTEyMy4xMzYxMDYt
My1tbGV2aXRza0ByZWRoYXQuY29tDQo+IA0KPiBhcyBpdCBpcyBhIHNpbXBsaWZpY2F0aW9uLg0K
PiANCj4gPiA+IEhlcmUgeW91IG5lZWQgdG8gZG8NCj4gPiA+IA0KPiA+ID4gICAgICBzZXR1cF9j
bGVhcl9jcHVfY2FwKFg4Nl9GRUFUVVJFX0lCVCk7DQo+ID4gPiAgICAgIHNldHVwX2NsZWFyX2Nw
dV9jYXAoWDg2X0ZFQVRVUkVfU0hTVEspOw0KPiA+IA0KPiA+IFRoaXMgb25seSBnZXRzIGNhbGxl
ZCBieSBrZXhlYyB3YXkgYWZ0ZXIgYm9vdCwgYXMga2V4ZWMgaXMgcHJlcHBpbmcNCj4gPiB0bw0K
PiA+IHRyYW5zaXRpb24gdG8gdGhlIG5ldyBrZXJuZWwuIERvIHdlIHdhbnQgdG8gYmUgY2xlYXJp
bmcgZmVhdHVyZQ0KPiA+IGJpdHMgYXQNCj4gPiB0aGF0IHRpbWU/DQo+IA0KPiBIbW0sIEkgd2Fz
IHVuZGVyIHRoZSBpbXByZXNzaW9uIHlvdSdsbCBoYXZlIHRoZSB1c3VhbCBjaGlja2VuIGJpdA0K
PiAibm9zaHN0ayIgd2hpY2ggZ2V0cyBhZGRlZCB3aXRoIGV2ZXJ5IGJpZyBmZWF0dXJlLiBTbyBp
dCdsbCBjYWxsIHRoYXQNCj4gdGhpbmcgaGVyZS4NCg0KVGhlcmUgd2FzIGF0IG9uZSBwb2ludCwg
YnV0IHRoZXJlIHdhcyBhIHN1Z2dlc3Rpb24gdG8gcmVtb3ZlIGluIGZhdm9yDQpvZiBjbGVhcmNw
dWlkLiBJIGNhbiBhZGQgaXQgYmFjay4NCg==
