Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15BA64613B
	for <lists+linux-arch@lfdr.de>; Wed,  7 Dec 2022 19:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiLGSkl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Dec 2022 13:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiLGSkk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Dec 2022 13:40:40 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D4F47328;
        Wed,  7 Dec 2022 10:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670438439; x=1701974439;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=e4MzkD7LHQANHvOvPh20BEg1/YxUGJURzP+3Ql7rIuE=;
  b=R4oaeTxCNscmjkge4v6HJKDQQXVO00BfrjxQIfagd48bDxd0ldkVv1iS
   X4laVsF1kx5uwXGJSnTstYQx5Pjxof/6wMiUkWlFKYvFcvDTIyxChBuO9
   koUUkQZEtU2SbCIrP5xtpa+U1jSL87WO0bbzcarlU2r/7xjiD8k7my/zf
   TAo0HAh7AxdCr9l6s0P6IlW/9r+UBUFf7E812sWhSFrJeqYwKMrdCKdf7
   xOIAh1zSIZ2rAo+brMXIfG9XQ7xr/WDFU1IpyGBEDS/wP/XcVNhYnLmwH
   WWrdu+HaYURB+at9Gh19hspN5fEceuvp0vg46L7Ew556GQfA7Ut7L8+hh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="318108490"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="318108490"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 10:35:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="891908285"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="891908285"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 07 Dec 2022 10:35:59 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 7 Dec 2022 10:35:59 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 7 Dec 2022 10:35:58 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 7 Dec 2022 10:35:58 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 7 Dec 2022 10:35:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eh38phflzg5aQUA/SO//jkBWL9EVSMazWk/VnWLKeWNkNus7TQxCCx8q7P8h1W45G8hA15BF7U8ps/vhNxFaOOX2Hq7dS4c9fF+j+E4U7EVO6uXcLYNYljH3hQ5KTgZJVSCRghzz7VrTRJq9t0N9HHay2uNv/nT1kK5mrAdYktq6zwsu40esmcvnxsMKspaLVQk8jSAa4225tTDihD5lqvIVq64veZ9CozP4qPTe3o41hBQG9UqdRAhlbyQ+qtXUaGyXdGTgqsBdOnnIUoIix+4oe8wsKTLrYH+ufLKM03OPnctzFtfUCEdV5clm3G9NPnR4sHKhho7+6V8AfCrF5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4MzkD7LHQANHvOvPh20BEg1/YxUGJURzP+3Ql7rIuE=;
 b=Z/+RJ2M5fioieDRls5GvBm+iY1vVa0YNBP7gAvB9LXkU9hxo/hTBDTYuJt8esLEgyDe+zGdP+AJPryg4TUEdyYOXpiyzqArIkYLqCkank2YuaC44SjRFod9tarXNsXwKO0TpRf+3SHrlueQzyc1rbtCspW/lxs246TXrZ3v/1DHbSjUUICmxMCPS+KA+owhvn0TWRedhw6vDgb29Ncl4zZ4I4dTPQqoJNEwfaS2p+k27bKoI0GrYaWmdFk3wms7D6Z3WK4eXv4dvY/XSkS1EbUGjZYBSX324w1ErPKiMW1d3U2XaFxrKx4P4+HuB3eFS40zOHQxzTSeZQRpP++73cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BN9PR11MB5340.namprd11.prod.outlook.com (2603:10b6:408:119::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 18:35:54 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff%5]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 18:35:54 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
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
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v4 04/39] x86/cpufeatures: Enable CET CR4 bit for shadow
 stack
Thread-Topic: [PATCH v4 04/39] x86/cpufeatures: Enable CET CR4 bit for shadow
 stack
Thread-Index: AQHZBq9QDPkAeUH43EeLOh1jRkjVO65iZ12AgABgvYA=
Date:   Wed, 7 Dec 2022 18:35:54 +0000
Message-ID: <7dcfa8e55b226853d5a34482fb9f83f6e226f75f.camel@intel.com>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
         <20221203003606.6838-5-rick.p.edgecombe@intel.com>
         <Y5CL4ySPtcTLVrrM@zn.tnic>
In-Reply-To: <Y5CL4ySPtcTLVrrM@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|BN9PR11MB5340:EE_
x-ms-office365-filtering-correlation-id: 181d5a73-c157-47af-a07b-08dad881dfc2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XmMev6CizsP8AGVzEO/zFj9pkZG6xruzaRzt9yTarjSKMYmrosH5WFa6Z0yS46T8NDk696efZmC0pvfpEc7e0Z4783qNbsCPAEWVW2Zi4Uw3mNBuf4gV+NMvzcWA1upy3rqM6q9TDRpylJ38BNESmIPUylcmUE1UaygTHG1n8eac9hXvZT+InG0pVG+V8vHlQ2cNhiCiSogIAj49zfxDeZUODn65/SsHAM12iHke1bK+KhwlWV/HazCiSOFU754zboeznpdc/G8dBheYbmCz2U2IJGRejJR/Fm6Y852scwDVfVev5tz89todMZciFVHw3VJyIRcWmadNt2vC84W828uUKuVdzpsIU40DoDuxx6i9rQwHwun0W/ih6Gin5nmvmitxkmcyOWNgqEW4/lPhk0+2U6KhNrwwNbwvo54g8qe6pFAD+cTIJZjvkACOGDk+02zyfzZSnOm9OBBp99P18fX2rZUYlRY62+Jk4R2mj6ezcMwz5VQkNiYyXRfPZOF+HDtMI1188v9BI2lSAuJl0fl3qmmKJUTvjVZKR7lKwLMjdXsYxwHoONHg+h6m80BI3APcRDqSqzTJsdiTT24zlGBydzN6Ds7ckHWNUF/bgKyeEronW4kLoiCMHLsAAyCqoBBue/Y7/4bzPBr8z4t9bEccRaCJ/q1rCsoUWPzOkSlt5bgMX7dw3IZzWxG7enaZD2eRi/AAuJ5GC8WRxKQqPDw1OTYOEjEmmfcz7Hx1+/4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199015)(83380400001)(8676002)(66556008)(86362001)(38100700002)(5660300002)(38070700005)(2906002)(7406005)(4744005)(66476007)(41300700001)(122000001)(4326008)(82960400001)(8936002)(7416002)(6486002)(66446008)(64756008)(6512007)(6506007)(186003)(26005)(316002)(2616005)(54906003)(91956017)(6916009)(66946007)(76116006)(71200400001)(478600001)(36756003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlBKbFhsbnU3UU43UytrbWdxckgzVGxkQUtaNHJFUnBUQk9BTzVMa0N5eGVU?=
 =?utf-8?B?R21Kdkl6ajV0ZDBab2doZUFnMUhGTXMwajk5ZWZvWkZPQnFvMHRSbjdMZFF2?=
 =?utf-8?B?ZFBvU2Z4OGxONjhualcrcFZjdEp5SnlUSWpON2hQdk5NMGpxL1dUOEtjb0Vu?=
 =?utf-8?B?djc3eGRtODBIYWVNZmJaN0hPU0ljSjdCOC9remNaMDIxN2prbVRYajEwSGN0?=
 =?utf-8?B?dmgzOEtoOXJMdWFZUUNSU3NVT3hscXFnZFRubXBtbnRzdGNlekl1cmtEWDFa?=
 =?utf-8?B?M3lzQ1RnOTk2cjVRek9NdGNCWC8xVnJESjlDUnJ3aThHQ2hMRloxbTBmSFJ4?=
 =?utf-8?B?cktQY1VFYVk4d1hDZ3VRMjM2YlJLV3NNc1p4UHZFelRxNzRZUkF0R1QvdFIx?=
 =?utf-8?B?aTcybEZSN3VUamFzY09aWEhGUzZ0Q1crYXI1dkJXUmZrNXBxTHc3RmpLV1No?=
 =?utf-8?B?UC9OMFdRMVRpaWZjdmV6b1ArY29vK0oyTStZMHhoNk0vNlB2amtKR1hESDZT?=
 =?utf-8?B?ZURoNEdFK3ArNWJ4ZFU5M3JsMzdqZ2h0NGUyTWlTZlVHaFR4ZTBiQTBobWdo?=
 =?utf-8?B?QStvMkFaQ1B6TFg2Yk44S0RYOWYxaUZRSEY1L2dCV3o5czV6ZzExanVNRVIz?=
 =?utf-8?B?V3dFU0RLZ0pUclhmWDRxa2l3ZW9GUGZYZGVmQmlnRkdZSHFQS2tJc3NXWDBO?=
 =?utf-8?B?MDNWR1pwbWE3QmlSQWlCam9LMm00Rzl5NHhrK0YxYmtKZG1rY3pUNHd6cFZ4?=
 =?utf-8?B?SGNOYUxSdEVKQnMxQjlXbVU5eGFsYzdSREJRM0hJQVdOZVBrNjhRb3lFcC9q?=
 =?utf-8?B?UFQ4cDlpb0gzcDNRSzBCSFZmemRRM2RwTFpGZGFpMUY3Kzg2RG95VGlHWlhV?=
 =?utf-8?B?cVFBNCtYc2xxUTRwMnU3MS9nMW0xYXQ5Z0JxZ0ttU2FkZHhsK0l5Q2NBZEhx?=
 =?utf-8?B?bUhjNlRYYVAyaDM5VkZNUEdKZEJMOEJzSGE2alVhL1BJMnpkdFYyTW4rTlFZ?=
 =?utf-8?B?T3hQZCs2em5HUFdaZ0xLZHRwRjZnZjNCSnVjQXcyTVhwM2s2YXd1RU5aODJY?=
 =?utf-8?B?Q2pCSFY3cS9RVzIzbVJyQnJlZ0tSdWU0SmFDTmYzU0Z5VEpnVWxlMVZSVldi?=
 =?utf-8?B?UjZGZzBlMjBMMGhiNm5MdDVHU0NlV2NPQ25zdWNSK2tGL29ZVm5uUTA5QWpr?=
 =?utf-8?B?T2xvL2ZweXFua0lmNWVITUkvUEpkSVhBSUl4TmI1bGxvN0VhTzdYUmx0dzJS?=
 =?utf-8?B?TnAwMXo4eWJDVENWc0EvYnI3dGpDYm83clZ1OE1XazRZZ2NjbHpJMWQxRUR5?=
 =?utf-8?B?RzFzMEJCWmpPbWZTTkFyQkcwNnM2RzZoVExKdk8wckUwTkhLM2dSdU9TZ3Zo?=
 =?utf-8?B?Q2FoWDRhZHlqb3J4cHdhQ01UaVplQ3J0UDRJMkk1K2V3RlZPeGRaZm9uNEZO?=
 =?utf-8?B?WWhlL0VsTU40cWJ3bUF0UFVidzdHUXkzRXhWQi9zV2hzQVVVMjFDRkhBRUV3?=
 =?utf-8?B?Tys0dDJFTjFPUzdrU0tXQWU2RmtISzFmeVAzUFl0TnVoRWRud0hOTVphY3hS?=
 =?utf-8?B?c2Mwcm40ZnFHWjEyakdHdEI1MmJ0aXNuT2JEVGtXVi81eVBjeEd4dUZBRXA5?=
 =?utf-8?B?ZFNLRlBrMDZISGI4S0thaTdPZnRWMEpOYW85REsyU3Bpam9kcGYvd1ZjNG1R?=
 =?utf-8?B?NThhaElzeWRqMEl5cUZaelQvRVlnY05iREdhbExwcS9JU2hVQkpLaTZnU2Fy?=
 =?utf-8?B?RTI2b3ZmYXdRMDZqemlWdkJXOFl5YmEvWmNaN2orM0Q0R0pPbUliRGlLV09W?=
 =?utf-8?B?OTh4VkxtSkp2ODZjakdTM01rd284Yk9uK1dQbGE2bE1HZ0hNelYzTHVOamkz?=
 =?utf-8?B?MUhwdlgzQlJycVh5TFp6Z21WL1NhZ2k4V1ljRXUrYnRjOFBkU2N1bmkrSEgy?=
 =?utf-8?B?N1RueGVmZG9rUEpFcVd4Y2VtSjhTQms3QzAxZjJielVkSmlLeksrQ281WDhr?=
 =?utf-8?B?UmwxT3hVZk9Gb3hJTmN1clc2RkVqbjdVd2o5bmZ5SWhxU2dSdEM4NzU4MHIv?=
 =?utf-8?B?dEMzM2dySVpIdFUybmpmMFhFY3FVdjd1WnZmVkJ2NCtKRVpaUWd5WVY1RE1K?=
 =?utf-8?B?L245ZEJSWG9yb3NMTC9YRlM0YW1GM1FTSFdBOWFhZ3NFMk5QVGw5SWhsMGY5?=
 =?utf-8?Q?BVLd8TH6PtNZoMe6jX65prA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2364185934FF4447AEE0F05CA6D52D7F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 181d5a73-c157-47af-a07b-08dad881dfc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2022 18:35:54.2645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tx+WMWl/oZaIh4CrYT7g33knaWKk6CH5YXRNxSd5Atwseuf2q6LzvOv8beuA/MjLAAMcU16pg+COY4u+2rAdiBG8VSCYp3ZXI9EGAiZ/CBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5340
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

T24gV2VkLCAyMDIyLTEyLTA3IGF0IDEzOjQ5ICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIEZyaSwgRGVjIDAyLCAyMDIyIGF0IDA0OjM1OjMxUE0gLTA4MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+IEZyb206IFl1LWNoZW5nIFl1IDx5dS1jaGVuZy55dUBpbnRlbC5jb20+
DQo+ID4gDQo+ID4gU2V0dGluZyBDUjQuQ0VUIGlzIGEgcHJlcmVxdWlzaXRlIGZvciB1dGlsaXpp
bmcgYW55IENFVCBmZWF0dXJlcywNCj4gPiBtb3N0IG9mDQo+ID4gd2hpY2ggYWxzbyByZXF1aXJl
IHNldHRpbmcgTVNScy4NCj4gDQo+IC4uLg0KPiANCj4gPiAgIGFyY2gveDg2L2tlcm5lbC9jcHUv
Y29tbW9uLmMgfCAzNyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ID4gLS0tLS0N
Cj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0K
PiANCj4gTG9va3MgYmV0dGVyLg0KPiANCj4gTGV0J3MgZ2V0IHJpZCBvZiB0aGUgaWZkZWZmZXJ5
IGFuZCBzaW1wbGlmeSBpdCBldmVuIG1vcmUuIERpZmYgb250b3A6DQoNClN1cmUsIHRoYW5rcyEN
Cg==
