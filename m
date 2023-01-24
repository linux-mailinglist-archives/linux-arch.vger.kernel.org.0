Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FC867A6F9
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jan 2023 00:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjAXXlT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Jan 2023 18:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjAXXlR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Jan 2023 18:41:17 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D25366AD;
        Tue, 24 Jan 2023 15:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674603676; x=1706139676;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VzOq3TyoGqjqXICFiyTZUtQdjuSGdiZQMPvbjHXjM1s=;
  b=OgYkepQ24XZSz3IFGNEwUEy6Hu7X/226TpLcWr/ZNYKUlw/pYA1oSVZ9
   QrOfPekzhr9ewT3Q2WQQK0IPLn5LzbW60ipZBtzI+ypuSUwjMvNKD3jPR
   bn2UwyWuFqhBU7w+zCmHo9cfiaiEB0/2g+PiqHJGirzfVnNxh3H2P9k3W
   TngAApHYkgdQv4wleO05kX7PBEageLzfj/7j+ByResE5ZRCBKiGSbIwr+
   6K1LgcXCoLb4s5DdCKZUE1d3yDOQOltH0hLjS7sb80bkwnj3/FXZcXIAQ
   RgGNiUDYo2LQggW00HXbc9jschMKWdTdmvfaG9q1I600Edc/mfjbKjFHY
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="412673247"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="412673247"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 15:41:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="991077270"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="991077270"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jan 2023 15:41:13 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 24 Jan 2023 15:41:12 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 24 Jan 2023 15:41:11 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 24 Jan 2023 15:41:11 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 24 Jan 2023 15:41:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFiR6dgAWz9JaTXP78AliLuO850UrA5t/zyDc+hK2vM0T7pk8dgN4m3VHlLQt69GHMpnJtC1s6d067ffdjPDkFfQZADC6RqlBXadLQKLS/fqqVRuMeXh98oUyLV3i4NPFyAyXsw32s2NhtAD2dW8FL2a+SavNWAojGXYRrW8rR5XX/kerUY4KNf+gUpCTqozQhoemElqzeWXu3XHCdtsArFdBNXHpjncewQmbwZx3CgT9EZSXm4AP3pGHn6jVMdc+zM9FWwjPPCs4Mpys5z6v+dQVrT9oZCPsneJUJJyo5kQxwAxkqgNtxjFwDNVI2C/jOT7WvpY9t+nZ3mruLFB8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzOq3TyoGqjqXICFiyTZUtQdjuSGdiZQMPvbjHXjM1s=;
 b=XnHTSufJb+5HAslhdFUmSiYZkY7KWVBKaOggGLDNA4Qo8SvTLWz6x+RcFUtfyGUu9pDjeCi/XhPIJSuJph70TuTZ0zCZEJzSVFEhEOD+hJho1NAShb3iZIpFE5W+EzmkeBcPkSrUVH6FnmixadPil/ZHM82PRI2VNcFiXTcTF0ajOAPpabWlfjmHkrFYEBgfuclvOdxqPPRyWp34OMVqN5uKU/8Q/aiiXid3Gg9RZyfoA2uea9IBsUopNKeqgo2YyftvNDqEGiO7kUeVyR+5K1OcLowYy/pLTgKwCvEyHL9TFnlgvO3W+xpCsL4O05G10grT+jJM9IGOybaBAzrYVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SA1PR11MB5873.namprd11.prod.outlook.com (2603:10b6:806:228::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 23:41:04 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 23:41:04 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "fweimer@redhat.com" <fweimer@redhat.com>,
        "david@redhat.com" <david@redhat.com>,
        "kees@kernel.org" <kees@kernel.org>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 23/39] mm: Don't allow write GUPs to shadow stack
 memory
Thread-Topic: [PATCH v5 23/39] mm: Don't allow write GUPs to shadow stack
 memory
Thread-Index: AQHZLExd1uIADC0jSEapGta3tBezb66rvFwAgAAatYeAAKfVgIABScuAgAAl7ICAAEphAIAACQ2A
Date:   Tue, 24 Jan 2023 23:41:03 +0000
Message-ID: <19ff6ea3b96d027defb548fb6b7f89de17905a4b.camel@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
         <20230119212317.8324-24-rick.p.edgecombe@intel.com>
         <aa973c0f-5d90-36df-01b2-db9d9182910e@redhat.com>
         <87fsc1il73.fsf@oldenburg.str.redhat.com>
         <c6dc94eb193634fa27e1715ab2978a3ce4b6c544.camel@intel.com>
         <fd741ac9-8214-a375-00b2-a652a7ef27ea@redhat.com>
         <6adfa0b5c38a9362f819fcc364e02c37d99a7f4a.camel@intel.com>
         <5B29D7A0-385A-41E8-AA56-EF726E6906BF@kernel.org>
In-Reply-To: <5B29D7A0-385A-41E8-AA56-EF726E6906BF@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SA1PR11MB5873:EE_
x-ms-office365-filtering-correlation-id: fa25c158-740d-4199-4437-08dafe64750e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z/7wV5hQNJiYejZs9qz661ggRaxsdxRyTBeK3Hv+BMIixUqqgP/cVEDanNJTOpu8xOKaeiVeF+WGvU/OgLKjLagw7eFoMu21d/dUYh37XFUOvgaGaNJeca+fmQMWiohhGO4WMKuadOONGdNAS9JymTFcI2tzQ4tEGwp9qP+ffleI5r1rYyx4WtGQs7EYkK9koRnDcznbfGQ931GasD0J3V59G+Rscyb0rFBzeRAtDoi3lxFFzl7uzBIfGQgb4c2H+3XcW1Ds1bCajAouJfsGWyLscqghsXo1BWBzeCb0hqLxaitlOO/G19riKiQeol2wBputcQdW4SmoEEMSsh5NVtUnqbxVm0dk7Kph9Krl+HzSLIohAvTfMf7CXRNu8fAQ4U1GrL7uoAQglOoujPhQ87Hx4XykazA/SAXZ5Iz+KuEJWz1Mc/EPXnTmEWYkdBfJY4g8AtMiMogI1zYlpsKtXcyL6XZgvh5Fkt/Ns0NCitRTylJVrfRSApesmDTjrXOQFnddzmhX1duqQB3XeKk3BCORRen2jktJupFQjN2z3AbJ/WYc3AaoJlYTA5SPR1FEyuNzOEz1CMhqjekwzYAOzG7ROKmzA6wkrKXXChgYfM6bdvUft7IM0z7bcmhyYVpAX22fg0Lc3SCh1YaV2gXj+w8LEzI68wqxIqqiO0WNEFKG5+movFt7xujLAFBqOqFQn36gyudbZ6e3ziRHkIJvoq2q5mW/R6h9OvfVoOfjCLo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199018)(83380400001)(38100700002)(122000001)(66556008)(54906003)(66446008)(2616005)(478600001)(64756008)(8676002)(186003)(66476007)(71200400001)(66946007)(6486002)(36756003)(38070700005)(91956017)(76116006)(110136005)(4744005)(2906002)(86362001)(7416002)(41300700001)(82960400001)(26005)(5660300002)(316002)(6506007)(6512007)(4326008)(7406005)(8936002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1pIL280cDdiYzlLSnBqZ3d6WHBoejh2eVNBQVI5TkREb0k2QWJTbXNwZDFY?=
 =?utf-8?B?cTlsdTFxNDZYZ0hVLzVRS1hUbXRtdjY0Nm5yZFJjNDRhOE41NFMyTC9nTzlC?=
 =?utf-8?B?Smd2bHh2aVhkbE5JR29GR3RLUlcvVE9zMFUrUENhZ0tEaWQ2SWpXVkUzSGQ1?=
 =?utf-8?B?ZVdhNTJuTjM3VzdwK3NYenpyTWs0cmFPN1Rqbzg0bks3Tm9KN1pQRVpuSkd2?=
 =?utf-8?B?UVllc0t6SGFTdGVWSWIvVk9aQkVVMXBPNDJGNXpLNUo4WVloT1dKRkQyYjN2?=
 =?utf-8?B?dDV6U0JFaFFvZnBra0h2dVQ2bmZKMm5sd2tuVWRyYzkvUEVPdkpqRE1IdnRy?=
 =?utf-8?B?WTIrQ01sV250bjN1a3J3VVNOU1Fnazl1L2l0S3RTTjZuVklsazdIKzJZMm9Z?=
 =?utf-8?B?dTZkRGZ2VDNWZTA3OXE2dUxBM2oxZUZkTUYwS3pjZlR0VDA2ZW85RVpVUmI2?=
 =?utf-8?B?cHExeDNZSkpLNDZQUE92L3BuYXFFYmFTUCtodDJrY2F6a2JjdFpzdThsOURI?=
 =?utf-8?B?WUVlRHh6U1RRUlRaZ3llWUY4aGRnQkg3VEM1T254Q09GbHYyQjhRVXVqaWpI?=
 =?utf-8?B?L3FNSGZzVURvL3JjYWZOV0EyM0FPVjhxTGVtRjhpdHJzWFZPdWd3MFcvRTFI?=
 =?utf-8?B?dW5UMGt4VDdhWVhsNmI2RldYV2VlaE1rQWJkby9HbU1hQ2pQaEg5VmpjV1A4?=
 =?utf-8?B?TXJ2K01KckJYZitxa3lubEsyVU5LR21JSXMvWkxHcWF1YlAxUmhVeWVMTUNS?=
 =?utf-8?B?NllNU2gxTVlWTkV1MVVOSHEwbmxZRCtXTVVzRlcwbm5OZ0J5b0gybGVOY0po?=
 =?utf-8?B?WTcrbDB6QlNLL0FTV29DTDdqRUgxNlV1aDVqcld2cmYrMDBCL3FiTFRpTjN3?=
 =?utf-8?B?ZzRNZytVQTFnOHIvcFF3VUE4TUNLOXNSRXBULzJVem1yNTMwMUwwdVc5VDNl?=
 =?utf-8?B?NzF4QUZTby9iSHk4c2Z3bEdKSkFML24xYzNjSStiWUc5M0VhdDFRRCtweVVp?=
 =?utf-8?B?ODN5bmlobW1sNVFkeEExbHZILzBycUpFSmMxd1dpSUkzMnVvUGRxWDdGdHRR?=
 =?utf-8?B?eW55Z2I1ZElMbDZyK2RjbCtQUXEya0ZZelQ5VXhBdkNnNW56TG9mMEs5dS8z?=
 =?utf-8?B?ZDJaYUdlcHRXbm9nMEMwZ05teHp0cXY3OTNwUHBvVkViL2o3LzcxOE9hbldC?=
 =?utf-8?B?RHY4L2FDL0FOL2FZMXoxaUM4aXFhVFlrM2tONGs5L1FWaWdodGQ1NnZVNzY5?=
 =?utf-8?B?U21Qa2VxSElnd2lacVp2VTArekJTWFVhMUJuOHg2TUFVQUptay9FeWUzN1VI?=
 =?utf-8?B?YmZyaGFtWEJ3RWh0cjBnd0hzWkZ6bFNadzIrSi94NHdpbEo0K2JHbVVUSmIx?=
 =?utf-8?B?THE1aUpnQXhrczlpd1I2aWVRTFQweC9xWnc2WjlodE5peU9QNSs0MWhqYzFz?=
 =?utf-8?B?eDl1ZmNHbnBGa0ZWaTRNRWN3ek9pTjlGMUhKaU1qd1ltL0Z6eFpOcFFVTnph?=
 =?utf-8?B?RENpNXFpRThwYW9UTW5IeXFIQTBhVktoM3U3Uk9LeUl5dThhdm1KbUVSaXhJ?=
 =?utf-8?B?R2RDZ3A3UjFwOEE4eHNHemlFa01iN3MvbHgxMVVncms5UjVOQ2JqK2taT1FB?=
 =?utf-8?B?WEVBVllLYVlucXA5bDBjR0ZlMFpRWmZ1OHNvYTFxcXRMSTJhWGE4MHdYNmkr?=
 =?utf-8?B?UGVTMGpFMEswV212YmEvVHVyYU03WUlLZ2FJU3ZqQ0hodmRUK3d0YlRNQm9R?=
 =?utf-8?B?cUM5WmU2UFRicDBvRVIvcnEvRjNodU5XL3lRSFVld2M1R1VUWjVjWGozR2l1?=
 =?utf-8?B?NE00U1l2NjBydXdRamorRmFVUUxNZGdQcnNocnRmVGpPT3RYeGczVEQwa1Bu?=
 =?utf-8?B?dUdmclhUMUw4Mi8xSm9WR0RyVG5NWEtrWEMzSmpndU1JSncxVEZ0bTdVNUR0?=
 =?utf-8?B?VytLVTZ1NWdkbEpaTlIwMmNremZMSC9tV0dQUW1TZHVza3FTcWJ3M0RydWox?=
 =?utf-8?B?WkhuYUJTdmdMV0tqVGpqQWwrRmMwdkcwZ2ZOcEZ3OTdOSzdNWlpYVXJseExl?=
 =?utf-8?B?UkFqL09SZjZlRVdoVnF0ZUxkWlppV2pYTE1vRHYrakJQL1BQejVRY0haZkJs?=
 =?utf-8?B?cHJRbmxsbmV2RXE4M0gzSW1CYm1rSkp2bnR4cnRvR1huSTNVQk1VWjcwYU8w?=
 =?utf-8?Q?MYrt4CJ4qzWiVuZcC2KxsZA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B16374372612984599FD5B1F872C843D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa25c158-740d-4199-4437-08dafe64750e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2023 23:41:03.9775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ctd5G8x+BM0jinNDAhcZXAsABhDmEWpIK6h4Bpy9tb25c9UokfAGI0vh8NPQN0gFv5S+nbhTGqJAbQJWkPabju1vdc4FMpWboQjyVALqc5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5873
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIzLTAxLTI0IGF0IDE1OjA4IC0wODAwLCBLZWVzIENvb2sgd3JvdGU6DQo+ID4g
R0RCIHN1cHBvcnQgZm9yIHNoYWRvdyBzdGFjayBpcyBxdWV1ZWQgdXAgZm9yIHdoZW5ldmVyIHRo
ZSBrZXJuZWwNCj4gPiBpbnRlcmZhY2Ugc2V0dGxlcy4gSSBiZWxpZXZlIGl0IGp1c3QgdXNlcyBw
dHJhY2UsIGFuZCBub3QgdGhpcw0KPiA+IHByb2MuDQo+ID4gQnV0IHllYSBwdHJhY2UgcG9rZSB3
aWxsIHN0aWxsIG5lZWQgdG8gdXNlIEZPTExfRk9SQ0UgYW5kIGJlIGFibGUNCj4gPiB0bw0KPiA+
IHdyaXRlIHRocm91Z2ggc2hhZG93IHN0YWNrcy4NCj4gDQo+IEknZCBwcmVmZXIgdG8gYXZvaWQg
YWRkaW5nIG1vcmUgRk9MTF9GT1JDRSBpZiB3ZSBjYW4uIElmIGdkYiBjYW4gZG8NCj4gc3RhY2sg
bWFuaXB1bGF0aW9ucyB0aHJvdWdoIGEgcHRyYWNlIGludGVyZmFjZSB0aGVuIGxldCdzIGxlYXZl
IG9mZg0KPiBGT0xMX0ZPUkNFLg0KDQpQdHJhY2UgYW5kIC9wcm9jL3NlbGYvbWVtIGJvdGggdXNl
IEZPTExfRk9SQ0UuIEkgdGhpbmsgcHRyYWNlIHdpbGwNCmFsd2F5cyBuZWVkIGl0IG9yIHNvbWV0
aGluZyBsaWtlIGl0IGZvciBkZWJ1Z2dpbmcuDQoNClRvIGpvZyB5b3VyIG1lbW9yeSwgdGhpcyBz
ZXJpZXMgZG9lc24ndCBjaGFuZ2Ugd2hhdCB1c2VzIEZPTExfRk9SQ0UuIEl0DQpqdXN0IHNldHMg
dGhlIHNoYWRvdyBzdGFjayBydWxlcyB0byBiZSB0aGUgc2FtZSBhcyByZWFkLW9ubHkgbWVtb3J5
LiBTbw0KZXZlbiB0aG91Z2ggc2hhZG93IHN0YWNrIG1lbW9yeSBpcyBzb3J0IG9mIHdyaXRhYmxl
LCBpdCdzIGEgYml0IG1vcmUNCmxvY2tlZCBkb3duIGFuZCBGT0xMX0ZPUkNFIGlzIHJlcXVpcmVk
IHRvIHdyaXRlIHRvIGl0IHdpdGggR1VQLg0KDQpJZiB3ZSBqdXN0IHJlbW92ZSBGT0xMX0ZPUkNF
IGZyb20gL3Byb2Mvc2VsZi9tZW0sIHNvbWV0aGluZyB3aWxsDQpwcm9iYWJseSBicmVhayByaWdo
dD8gSG93IGRvIHdlIGRvIHRoaXM/IFNvbWUgc29ydCBvZiBvcHQtaW4/DQo=
