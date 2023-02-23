Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351C36A13EA
	for <lists+linux-arch@lfdr.de>; Fri, 24 Feb 2023 00:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjBWXof (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Feb 2023 18:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBWXoe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Feb 2023 18:44:34 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A6D1557A;
        Thu, 23 Feb 2023 15:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677195873; x=1708731873;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lXhvd3Wmt7gptkKe8EFcee5uM2la3riwwUv/+l5C8T0=;
  b=nypDNmoxfdpZwWx/6I0k4bJ3Ief22dk95OYEdG7rVcEar7GRfEVzISnv
   jbrvIP7u8hPD8ifMaG+lf8BizFAkPJ2f+es5ioEYXCCB8vm4qzEKMxEO4
   hZ6ZO8TTurhFPAzac6kb1yzoyrzZWVFv1IxbjwFUCBvOxMFAHaqJf60/d
   PEcdq8n82ozUzl2fNUBquAAQgA+4FZwYgTfCWRIiO+Hfy8zcFlxqxes2x
   +HCWJ5/f5zI09QOhAij+kR8RUetquZ2wVqK8UDr0DHHjkirsEA2OdowTe
   pGmP9Pq5mbftub3xJtRd/5VRg5M9bLE5g/lKe2z97qc34L9hyMs3c9cLu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="419587990"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="419587990"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 15:44:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="782117541"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="782117541"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 23 Feb 2023 15:43:18 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 23 Feb 2023 15:42:15 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 23 Feb 2023 15:42:15 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 23 Feb 2023 15:42:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfhbrI0gwss+ZerR1sCFDk8wBj15hiIEmHuWNuRjvK3sLaF86OlTURj2Q4+79PJVRQtM/ofsc6c/CRBWh85srJLSWGigkyNA+Q7cQjwWHcwY6xboc9/BYGr5K2v/ZtJA5gTlFVnA+Z0DJncBThULJo29SAsPtshOc04YKK3CrUl8GAc3vPbKx7UcEwsBc06bOHKtGNURN4gJLF5KUtBcuv8Q9rQf4Az3HMT1UGZNdafBNughnoSh1Ogzvy9uzUAw39FpOCv8Kxd5+6SXMuYBnLs8iD4w0VoomamlyL1zeIDDQcLtMjisN3vdSEF2sqk96OUFUtHng6PN6tBUws+kPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXhvd3Wmt7gptkKe8EFcee5uM2la3riwwUv/+l5C8T0=;
 b=dA2CG67RlJCUDIgsopIntEcDn1+TB0qcOXKgfIcyaz++7/fROGe5bRvqLx33+41g2lhgCxtTunG+Wr4PbN4FKqz7D7Yq62tze9UHaTyZZK6gQBJ1RkctP9v0E1p2Xoepb05WNnHfzFP0oMwbBIqnQWGSwL/GODrfmGiGuOR6/z7UxSmpUiAAj2pNRLyycDZcjFN/oO4v/T5kmRhzIQx6V601QhkOqRv0GB+/nOKq8RWg48NP+Jvo3Gvy9LfgxRaHwSpzUrC3LAKRUglzVJt65KKhFS/Kr5xmj5QkK3B2s+RWq2392xj6xg1vJBb3dDc3CgCCnCekOravkhsKkkoR6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CH3PR11MB8238.namprd11.prod.outlook.com (2603:10b6:610:155::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Thu, 23 Feb
 2023 23:42:11 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6134.021; Thu, 23 Feb 2023
 23:42:11 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "debug@rivosinc.com" <debug@rivosinc.com>
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
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v6 33/41] x86/shstk: Introduce map_shadow_stack syscall
Thread-Topic: [PATCH v6 33/41] x86/shstk: Introduce map_shadow_stack syscall
Thread-Index: AQHZQ95FnziH/18UIkugiXvZUjmnPK7brNUAgAAS0YCAAVHQAIAAJ7IA
Date:   Thu, 23 Feb 2023 23:42:11 +0000
Message-ID: <3006cca47feff431feb9dae48a2b8c997569ad5c.camel@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
         <20230218211433.26859-34-rick.p.edgecombe@intel.com>
         <20230223000340.GB945966@debug.ba.rivosinc.com>
         <49a151d5a704487d541e421699cf798c87a80ca5.camel@intel.com>
         <CAKC1njSXDY_NUxLdrbJbF6zGaP4aifAh3g1ku0E5RkAxK4tqLA@mail.gmail.com>
In-Reply-To: <CAKC1njSXDY_NUxLdrbJbF6zGaP4aifAh3g1ku0E5RkAxK4tqLA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|CH3PR11MB8238:EE_
x-ms-office365-filtering-correlation-id: 8a907cdc-1650-427b-5a54-08db15f7956c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tMqe8+CF9+Z+CMsbFA030Z3Su7Ld7VTsFXXlIDQwX4+4aubRO3Dm2Ml0XChpuhtulkiyNw9ACd0eUbjtdec5Ij62f56lmhZvD28WY4fTNHOjyIV/G5mkyMnKes/EPtqBl4Zpqd6UqweGz1Rzyb+kJ1w076k/4C4vHiqHJAE8I5is9J2vcPe7blLJCpkBcKnwsWhiAhJ963kbpJU5ZJJ5W334jEnMfrA7aejsiE/8921U+QZsScPVulIPFmRj756Zc7XjliWWZdTEidbbnRG2UJJefhHo4MovEudFRoeWfgc8Ij4aKfuDShnxoHxqz/DlOOxTIoXm8dmrRqD1+wwkBqaltU+VTF0y4hohaAk4E7VL22PbrywMFwsuRfcRPeFpywlFo3sEvdrxw7G/pzrT/HdVb8aJYSANzBKXdnmvuGAro3ukvibwVlA9QQsSvG7nUzyJc7LIreWNnP4K3FefTP8undXUnBV9szdHA3PUy749aFXQ007Xot2VkTP5aNpwXRJAM8c8KDKfzcZgtlyWuh70x7Ok980iwJTDypBJyz5M3b61fB5TSJNTGcNFDZgNRhLSiuy1+ZxDDwEXs+exFd6zqSFdUAnWn/mtY5ebSQUF6oanwNrcWq6tpAo8F4WYAGCcssJuu5QZFQIqCEPC0I6NdE9nW+pnVnoncFsm6AeEnh0LTZc90YHzifBXC71f9iaEtWrzGVhPJ7nWPrRCjY+Ewb8XVnC3n3bLWWpo1FE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199018)(54906003)(41300700001)(5660300002)(26005)(316002)(478600001)(76116006)(86362001)(6486002)(7416002)(7406005)(66946007)(66446008)(64756008)(66476007)(4326008)(8676002)(6916009)(38070700005)(8936002)(66556008)(82960400001)(71200400001)(122000001)(38100700002)(6512007)(6506007)(2906002)(83380400001)(2616005)(186003)(36756003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azE5Z2gvTENrTElSMlF4SXlKekhVV09TTHErNEYvcm9nRzNUZFZ3Qmt6UzJq?=
 =?utf-8?B?dTR0RVZtM09aYjViMS95Z3h2L3R6YlFLaGI3RjZINWt2cG1YeWJiZ2JxbWxm?=
 =?utf-8?B?MThybHZOaWtELzZmNEJkWEVLeVRJZzlUeTFlcUtQTjlGME1qSE1oQTZIUTdW?=
 =?utf-8?B?akRuemV2U3ZIejVRY3plcSs0eXdqRGpFa0Z0bjFXZk9VNENJYTU1OHhkb1dE?=
 =?utf-8?B?T3hBTUhHTlRaN1lwZG9CZklJRklSL1NoaC9ZWTVJd1NsZVY3UHNGMUpzRXRj?=
 =?utf-8?B?MVBWbUMvMVl1QTN6UDVFVVU3K2pCbEsyNFNXZVlJUU9pOHloeVhMMTdzcVdN?=
 =?utf-8?B?VGJuMmZEdWhpaWJWeHpKZ1FNT0ZiUmNzVFhZWEprV1NaK3J4bnNHaEcwekxZ?=
 =?utf-8?B?ZW5oWHZKQ3BUek1uclhNbmZxY3VJWUtNbUJreStLamlZR2M1N0MzclUzRGFr?=
 =?utf-8?B?Y0tZRno3VCtPMHJpUEVabUYrVENrRldmWDFiUzdtQjF5ZVh2QU0ySU8wVExR?=
 =?utf-8?B?Zmx4bFErRHp4dU9SdlpkZ2g4MXN0TkNtQTFDZ1lJaTNKUHp5K3M4cTBVYVFX?=
 =?utf-8?B?RzdJeXd4blQzTWVFckRQWXYvMGxPRHdqR1U3QXdLMm9JT3ZWTHJUZW9kbXdB?=
 =?utf-8?B?Tm1EMk1QVXk2bzRvZ0dsV1lvWnJ0WnFJcWppZXhkeWpDUk4xTmxjUkkveXd5?=
 =?utf-8?B?UDlpWGhPRDJXUEdhNGZiQ0REbDFlQlNxdlZRUDIxOW5aOWNTRWgwU1dneTdv?=
 =?utf-8?B?UzRWRjVGbWhxQ2t2T29zVlB2dVBQOFRqZUNKNUZieGlKU3BkdHdjd2dWaS9s?=
 =?utf-8?B?Q3E1NFoxNEhPeDRUb1htMkhMK0oxMDlwdFcyQ3hwTFk0QkwyWVIzOEVsdGto?=
 =?utf-8?B?Sm9lbGhrN1ZTYlI5emJaZjJYSlZMaml5ZFhvOWdLaldFckNGUXhUVHV4bEZm?=
 =?utf-8?B?Y3VheThERkhvTU05YzRhSzlsNHhwc3AyOFFtRzBUczlvVmJ3VGpvY0FWelYv?=
 =?utf-8?B?VFVKYU1HM2RPbDRwSGQxNGZYV3U5aXJmYzUxbndPaWpDQWtOOXpZNEFCN1JB?=
 =?utf-8?B?bXl1UncxdWs1VEMvOFA0ZUd5MzdURzV4Vlh0SnhIUlRWVXMwbkhJSklNZHV0?=
 =?utf-8?B?NSs2K0FSN1hwUVN2U3d5ZFJYRzFpTzFWUE44b1ZXaENLYVZKdkhjaEhMS2hH?=
 =?utf-8?B?TzBaMDdNbnc4bldINm55dHllS0tqN05OY3lHckVmbnFENmU1M04xNXVMMzZ4?=
 =?utf-8?B?OTBKUDdMSE0yQXVrZnFpcEdkOCtYSytRamlLcXMvcjRQZjVUVXJBUjhkRUs1?=
 =?utf-8?B?T3F1SllYd2xyeW9FNHYrcTNNenR1WkpqdmFsRjEvOFFSUkNQQTAvellaSko1?=
 =?utf-8?B?eGl0a2NyK203V1pNKytvdFZxdXRLamw0V2QybGxuUFhyWVVmenUvZ3czWW9q?=
 =?utf-8?B?dnUrZllPOXE4YVNsb3VQSStzUFNlWTlZaDI3Y01aenc5alFYclNva1hwbk5X?=
 =?utf-8?B?UkttREsyV2YrVXFDVGI5UnpqSjE0Q2cwMTQvbXIzSzgrK0k0Y1duMzlyNFRS?=
 =?utf-8?B?Uno1N3BpM3c5YWVBWDA5QmtGQ1lLQm1wbmFUN05xdmd1TFBuSGg0bG85MkJF?=
 =?utf-8?B?MG5yakpLMFBkTk5YeHNXTC9ZNHFHeXNHRG1oVmhqdlVJZVk4VWVBTUJCZjVV?=
 =?utf-8?B?ZnV0WGRucmc4MlBIZUVhVWp3TlpQM0pWakNOVWRISkw4d3JYNEpUZXZ4OGpq?=
 =?utf-8?B?SUpzSElGejl2NGJuNHgzdUJPcE5IQVJrQmRwUUJYMlFUQnlpOWRJdzJpR091?=
 =?utf-8?B?N1V6NE1mZ1RHSCt5RmxScmZPMVQzZk9jWi9NcVRZekV4MFZ5TXRNcTlwcUJh?=
 =?utf-8?B?TmpjZHplOVNJUEt5V2MweWg3MmhwSVd3V25ISmVWdWE4bWY3cTA0UjFycjZB?=
 =?utf-8?B?Z2dsTGxMR1I3ZWFNZ3E5SkFoS212RUQzMjJEQjhGdk9FTldlK2gvSnlmUDZy?=
 =?utf-8?B?bFdUTG96WGc5djFuTFY0VlZCMm56UlpoRlBvN1BDWC8yLzJ5bUlMUmVIWGdI?=
 =?utf-8?B?c0Q5cHdZcVV5eXlmbGNGRXhaNkRkZk0zZ3dpYTMwbm04SXVGTTR1KzFHdVVZ?=
 =?utf-8?B?K0pNeUlURXJyb1lvM3ppc0l3YWVxMDdmNTRKaG1aZ2tIVDFzTllGUlZmR3JL?=
 =?utf-8?Q?edOhH0mqEpplMuVN6H60Yek=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1EAEBDDE98A8D4EBE6B37AF8D5EBA5B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a907cdc-1650-427b-5a54-08db15f7956c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 23:42:11.0756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EjEbKyZCifvLKid6sHbwWcq9LNAGmLZHrRu9oVMjqxeEgw+fcyIocRWG5F4yTJOrOkja8Pr3c37Ju0AS/u0LWPMQQkuw8zZE0iKcvA0S2KM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8238
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVGh1LCAyMDIzLTAyLTIzIGF0IDEzOjIwIC0wODAwLCBEZWVwYWsgR3VwdGEgd3JvdGU6DQo+
ID4gSXQgZG9lc24ndCBzZWVtIGxpa2UgdGhlIGNvbXBsZXhpdHkgb2YgdGhlIGNoZWNrcyBpcyB3
b3J0aCBzYXZpbmcNCj4gPiB0aGUNCj4gPiB0aW55IHN5c2NhbGwuIElzIHRoZXJlIHNvbWUgcmVh
c29uIHdoeSByaXNjdiBjYW4ndCB1c2UgdGhlIHNhbWUNCj4gPiBzeXNjYWxsDQo+ID4gc3R1Yj8g
SXQgZG9lc24ndCBuZWVkIHRvIGxpdmUgZm9yZXZlciBpbiB4ODYgY29kZS4gTm90IHN1cmUgd2hh
dA0KPiA+IHRoZQ0KPiA+IHNhdmluZ3MgYXJlIGZvciByaXNjdiBvZiB0aGUgbW1hcCtjaGVja3Mg
YXBwcm9hY2ggYXJlIGVpdGhlci4uLg0KPiANCj4gSSBkb24ndCBzZWUgYSBsb3Qgb2YgZXh0cmEg
Y29tcGxleGl0eSBoZXJlLg0KPiBJZiBgbXByb3RlY3RgIGFuZCBmcmllbmRzIGRvbid0IGtub3cg
YWJvdXQgYFBST1RfU0hBRE9XU1RBQ0tgLA0KPiB0aGV5J2xsDQo+IGp1c3QgZmFpbCBieSBkZWZh
dWx0ICh3aGljaCBpcyBkZXNpcmVkKQ0KDQpUbyBtZSwgdGhlIG9wdGlvbnMgbG9vayBsaWtlOiBj
cmFtIGl0IGludG8gYW4gZXhpc3Rpbmcgc3lzY2FsbCBvcg0KY3JlYXRlIG9uZSB0aGF0IGRvZXMg
ZXhhY3RseSB3aGF0IGlzIG5lZWRlZC4NCg0KVG8gcmVwbGFjZSB0aGUgbmV3IHN5c2NhbGwgd2l0
aCBtbWFwKCksIHdpdGggdGhlIGV4aXN0aW5nIE1NDQppbXBsZW1lbnRhdGlvbiwgSSB0aGluayB5
b3Ugd291bGQgbmVlZCB0byBhZGQgdG8gbW1hcDoNCjEuIExpbWl0IFBST1RfU0hBRE9XX1NUQUNL
IHRvIGFub255bW91cywgcHJpdmF0ZSBtZW1vcnkuDQoyLiBMaW1pdCBQUk9UX1NIQURPV19TVEFD
SyB0byBNQVBfQUJPVkU0RyAob3IgY3JlYXRlIGEgTUFQX1NIQURPV19TVEFDSw0KdGhhdCBkb2Vz
IGJvdGgpLiBNQVBfQUJPVkU0RyBwcm90ZWN0cyBmcm9tIHVzaW5nIHNoYWRvdyBzdGFjayBpbiAz
MiBiaXQNCm1vZGUsIGFmdGVyIHNvbWUgQUJJIGlzc3VlcyB3ZXJlIHJhaXNlZC4gU28gaXQgaXMg
c3VwcG9zZWQgdG8gYmUNCmVuZm9yY2VkLg0KMy4gQWRkIGFkZGl0aW9uYWwgbG9naWMgZm9yIE1B
UF9BQk9WRTRHIHRvIHdvcmsgd2l0aCBNQVBfRklYRUQgYXMgaXMNCnJlcXVpcmVkIGJ5IENSSVUu
DQo0LiBBZGQgYW5vdGhlciBNQVBfIGZsYWcgdG8gc3BlY2lmeSB3aGV0aGVyIHRvIHdyaXRlIHRo
ZSB0b2tlbiAoQUZBSUsNCnRoZSBmaXJzdCBmbGFnIHRoYXQgd291bGQgZG8gc29tZXRoaW5nIGxp
a2UgdGhhdC4gU28gdGhlbiBsaWtlbHkgaGF2ZQ0KZGViYXRlcyBhYm91dCB3aGV0aGVyIGl0IGZp
dHMgaW50byB0aGUgZmxhZ3MpLiBTb3J0IG91dCB0aGUgYmVoYXZpb3Igb2YNCnRyeWluZyB0byB3
cml0ZSB0aGUgdG9rZW4gdG8gYSBub24tUFJPVF9TSEFET1dfU1RBQ0sgbW1hcCBjYWxsLg0KNS4g
QWRkIGFyY2ggYnJlYWtvdXQgZm9yIG1tYXAgdG8gY2FsbCBpbnRvIHRoZSB0b2tlbiB3cml0aW5n
Lg0KDQpJIHRoaW5rIHlvdSBhcmUgcmlnaHQgdGhhdCBubyBtcHJvdGVjdCgpIGNoYW5nZXMgd291
bGQgYmUgbmVlZGVkIHdpdGgNCnRoZSBjdXJyZW50IHNoYWRvdyBzdGFjayBNTSBpbXBsZW1lbnRh
dGlvbiAoaXQgd2Fzbid0IHRoZSBjYXNlIGZvciB0aGUNCm9yaWdpbmFsIFBST1RfU0hBRE9XX1NU
QUNLKS4gQnV0IEknbSBzdGlsbCBub3Qgc3VyZSBpZiBpdCBpcyBzaW1wbGVyDQp0aGVuIHRoZSBz
eXNjYWxsLg0KDQpJIGRvIHdvbmRlciBhIGxpdHRsZSBiaXQgYWJvdXQgdHJ5aW5nIHRvIHJlbW92
ZSBzb21lIG9mIHRoZXNlDQpsaW1pdGF0aW9ucyBvZiB0aGUgZXhpc3Rpbmcgc2hhZG93IHN0YWNr
IE1NIGltcGxlbWVudGF0aW9uLCB3aGljaCBjb3VsZA0KbWFrZSBhbiBtbWFwIGJhc2VkIGludGVy
ZmFjZSBhIGxpdHRsZSBiZXR0ZXIgZml0LiBMaWtlIGlmIHNvbWVkYXkNCnNoYWRvdyBzdGFjayBt
ZW1vcnkgYWRkZWQgc3VwcG9ydCBmb3IgYWxsIHRoZSBvcHRpb25zIHRoYXQgbW1hcA0Kc3VwcG9y
dHMuIEJ1dCBJJ20gbm90IHN1cmUgaWYgdGhhdCB3b3VsZCBqdXN0IHJlc3VsdCBpbiBtb3JlIGNv
bXBsZXhpdHkNCmluIG90aGVyIHBsYWNlcyAoTU0sIHNpZ25hbHMpIHRoYXQgd291bGQgYmFyZWx5
IGdldCB1c2VkLiBMaWtlLCBJJ20gbm90DQpzdXJlIGhvdyBzaGFkb3cgc3RhY2sgcGVybWlzc2lv
bmVkIG1tYXAoKWVkIGZpbGVzIHNob3VsZCB3b3JrLiBZb3UNCndvdWxkIGhhdmUgdG8gcmVxdWly
ZSB3cml0YWJsZSBmaWxlcyB0byBtYXAgdGhlbSBhcyBzaGFkb3cgc3RhY2ssIGJ1dA0KdGhlbiB0
aGF0IGlzIG5vdCBhcyBsb2NrZWQgZG93biBhcyB3ZSBoYXZlIHRvZGF5IHdpdGggdGhlIGFub255
bW91cw0KbWVtb3J5LiBBbmQgYSAic2hhZG93IHN0YWNrIiBmaWxlIHBlcm1pc3Npb24gd291bGQg
c2VlbSBhIGJpdA0Kb3ZlcmJvYXJkLg0KDQpUaGVuIHByb2JhYmx5IHNvbWUgbW9yZSBkaXJ0eSBi
aXQgaXNzdWVzIHdpdGggbW1hcGVkIGZpbGVzLiBJJ20gbm90DQpmdWxseSBzdXJlLiBUaGF0IG9u
ZSB3YXMgZGVmaW5pdGVseSBhbiBpc3N1ZSB3aGVuIFBST1RfU0hBRE9XX1NUQUNLIHdhcw0KZHJv
cHBlZCwgYnV0IERhdmlkIEhpbGRlbmJyYW5kIGhhcyBub3cgcmVtb3ZlZCBhdCBsZWFzdCBzb21l
IG9mIHRoZQ0KaXNzdWVzIGl0IGhpdC4NCg0KU28gdGhlIG9wdGltdW0gc29sdXRpb24gbWlnaHQg
ZGVwZW5kIG9uIGlmIHdlIGFkZCBtb3JlIHNoYWRvdyBzdGFjayBNTQ0Kc3VwcG9ydCBsYXRlci4g
QnV0IGl0IGlzIGFsd2F5cyBwb3NzaWJsZSB0byBhZGQgbW1hcCBzdXBwb3J0IGxhdGVyIHRvby4N
Cg0KPiANCj4gSXQncyBvbmx5IGBtbWFwYCB0aGF0IG5lZWRzIHRvIGJlIGVubGlnaHRlbmVkLiBB
bmQgaXQgY2FuIGp1c3QgcGFzcw0KPiBgVk1BX1NIQURPV19TVEFDS2AgdG8gYGRvX21tYXBgIGlm
IGlucHV0IGlzIGBQUk9UX1NIQURPV1NUQUNLYC4NCj4gDQo+IEFkZGluZyBhIHN5c2NhbGwganVz
dCBmb3IgbWFwcGluZyBzaGFkb3cgc3RhY2sgaXMgd2VpcmQgd2hlbiBpdCBjYW4NCj4gYmUNCj4g
c29sdmVkIHdpdGggZXhpc3Rpbmcgc3lzdGVtIGNhbGxzLg0KPiBBcyB5b3Ugc2F5IGluIHlvdXIg
cmVzcG9uc2UgYmVsb3csIGl0IHdvdWxkIGJlIGdvb2QgdG8gaGF2ZSBzdWNoIGENCj4gc3lzY2Fs
bCB3aGljaCBzZXJ2ZSBsYXJnZXIgcHVycG9zZXMgKGUuZy4gcHJvdmlzaW9uaW5nIHNwZWNpYWwN
Cj4gc2VjdXJpdHktdHlwZSBtZW1vcnkpDQo+IA0KPiBhcm02NCdzIG1lbW9yeSB0YWdnaW5nIGlz
IG9uZSBzdWNoIGV4YW1wbGUuIE5vdCBleGFjdGx5IHNlY3VyaXR5LXR5cGUNCj4gbWVtb3J5IChi
dXQgZXZlbnR1YWwgYXBwbGljYXRpb24gaXMgc2VjdXJpdHkgZm9yIHRoaXMgZmVhdHVyZSkgLg0K
PiBJdCBhZGRzIGV4dHJhIG1lYW5pbmcgdG8gdmlydHVhbCBhZGRyZXNzZXMgKGkuZS4gYW4gYWRk
cmVzcyBoYXMNCj4gdGFncykuDQo+IGFybTY0IHdlbnQgYWJvdXQgdXNpbmcgYSBwcm90ZWN0aW9u
IGZsYWcgYFBST1RfTVRFYCBpbnN0ZWFkIG9mIGENCj4gc3BlY2lhbCBzeXN0ZW0gY2FsbC4NCg0K
SXQgbG9va3MgbGlrZSB0aGF0IG1lbW9yeSBjYW4gYmUgd3JpdHRlbiB3aXRoIGEgc3BlY2lhbCBp
bnN0cnVjdGlvbj8NCkFuZCBzbyBpdCBkb2Vzbid0IG5lZWQgdG8gYmUgcHJvdmlzaW9uZWQgYnkg
dGhlIGtlcm5lbCwgYXMgaXMgdGhlIGNhc2UNCmhlcmUuDQoNCj4gDQo+IEJlaW5nIHNhaWQgdGhh
dCBzaW5jZSB0aGlzIHBhdGNoIGhhcyBnb25lIHRocm91Z2ggbXVsdGlwbGUgcmV2aXNpb25zDQo+
IGFuZCBJIGFtIG5ldyB0byB0aGUgcGFydHkuIElmIG90aGVycyBkb250IGhhdmUgaXNzdWVzIG9u
IHRoaXMgc3BlY2lhbA0KPiBzeXN0ZW0gY2FsbCwNCj4gSSB0aGluayBpdCdzIGZpbmUgdGhlbi4g
SW4gY2FzZSBvZiByaXNjdiBJIGNhbiBjaG9vc2UgdG8gdXNlIHRoaXMNCj4gbWVjaGFuaXNtIG9y
IGdvIHZpYSBhcm0ncyByb3V0ZSB0byBkZWZpbmUgUFJPVF9TSEFET1dTVEFDSyB3aGljaCBpcw0K
PiBhcmNoIHNwZWNpZmljLg0KDQpPaywgc291bmRzIGdvb2QuIFRoZSBhZHZpY2UgSSBnb3QgZnJv
bSBtYWludGFpbmVycyBhZnRlciB0aGUgbWFueQ0KYXR0ZW1wdHMgdG8gY3JhbSBpdCBpbnRvIHRo
ZSBleGlzdGluZyBpbnRlcmZhY2VzIHdhczogZG9uJ3QgYmUgYWZyYWlkDQp0byBhZGQgYSBzeXNj
YWxsLiBBbmQgc3VyZSBlbm91Z2gsIHdoZW4gTUFQX0FCT1ZFNEcgY2FtZSBhbG9uZyBpdA0KY29u
dGludWVkIHRvIG1ha2UgdGhpbmdzIHNpbXBsZXIuDQo=
