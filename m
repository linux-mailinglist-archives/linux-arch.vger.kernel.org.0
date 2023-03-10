Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035526B4E20
	for <lists+linux-arch@lfdr.de>; Fri, 10 Mar 2023 18:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjCJRNu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Mar 2023 12:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjCJRNs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Mar 2023 12:13:48 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E695D454;
        Fri, 10 Mar 2023 09:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678468426; x=1710004426;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OlotnoHpSVJUGwJxz8KlYWudHOiOINdkuOGK9hz3nuI=;
  b=nGaTYqQwkOZUzaNT1e271DzU5NhDbfsdYf+hQhaJJ6pvzJa6tQlaQb+I
   1fg15q3jYvSdJFG1QZnajgLChJKQ/XiKO5GjlJu+vHamnNcv4nqnRlgQG
   KPngwWPcC15zMuFVHRPH3wHyzrmQ7Xi8xX3CRknJp80v0jQaYBfuisSs9
   rwzDiXeE4WQEBugUhFEKymewsRKYIgOWKs34sFz5gE9BTcaul/d3kE8/E
   C9xDRgVdvuz33tO4IyuWTx6jN/5bBfZ/FjKZBteE/lV/sxwDr9Z0K8xsu
   OEEngHXULnmDkMBHAzCWMN1uGBP7KPJV9cO4d7IjNEeZ1Sn56EEGR0wR0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="325131949"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="325131949"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 09:13:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="655249600"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="655249600"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 10 Mar 2023 09:13:03 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 09:13:02 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 10 Mar 2023 09:13:02 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 10 Mar 2023 09:12:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRQbO21C8vCNMyWklN+AkMoG/ajxjNjphhg5fYikRNMuPtg7iCe+sbuiu5IkG5zs7JaiJ/22kZ7Jtr+OmOpnLnPwN/P7VWZstk7+Ib2vZdhgP+OTeCYQxOo5bzpBV6fOs2inOvCJMDgM+Q2cDZdlLwsYHE666SygWMmflT4Twj4Cm24vMcGxV2cYXH01IyxEbiGR3XnuydDaHmKYqbMEMy0XUv0/u4shycRM2W8HUhrCmuirbfk2zylEJRAO7mDkMkIv0x9Iy2qhfQxltYj0/msUt+yL9P+8kQQSSq+ZQ8nmsAvLb2+kSQKZIQmu+WjOByDvvkZf9eEphE7jfn0bJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlotnoHpSVJUGwJxz8KlYWudHOiOINdkuOGK9hz3nuI=;
 b=MlBArLXTUTfts5yYN/R09vt82svgz/l8tLTg391TAg0tJXwUjfImNB7RkMr3MzhlPBmwMbR7EbOQgBQJUKAe/hKQZisfI7RLE4upcwQK0KOmzq+ruUBY12J0lT7NYgysNYz9xxcZJzjFo1P671YJMepv6uAmASLvlUGh/M+xEBns3Pf6JuEGfjPowkU1P6Ksq4zkF7pk1cpLOg9Nko8AfDoUf6xYOpUHxvNByRXLk7oo6k3Hx0JwdcdAON2lrWvKqG2xXTduGxH2mEN7zFN5vLXTmQJrYonYxI8cZ0E7K1aheA3+l+2f9F8Olv4ORCEx8gFP3pwwyS94b1F8lATIdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SJ0PR11MB5165.namprd11.prod.outlook.com (2603:10b6:a03:2ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 17:12:40 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 17:12:40 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
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
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v7 33/41] x86/shstk: Introduce map_shadow_stack syscall
Thread-Topic: [PATCH v7 33/41] x86/shstk: Introduce map_shadow_stack syscall
Thread-Index: AQHZSvtF2ujwSwjQQE2i7wvNH++zdK70P++AgAARI4A=
Date:   Fri, 10 Mar 2023 17:12:40 +0000
Message-ID: <b85a86e8013280ce17a54d570aa162f1d463a230.camel@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
         <20230227222957.24501-34-rick.p.edgecombe@intel.com>
         <ZAtWp76svXxvQl94@zn.tnic>
In-Reply-To: <ZAtWp76svXxvQl94@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SJ0PR11MB5165:EE_
x-ms-office365-filtering-correlation-id: f655040a-4b8a-406e-46de-08db218aa772
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2BSUcaorR2K+KZX6hY2+II4ELAbTWTCrJ1zHaWxugskKovRdACcbetktJVJKRg5oEVc6SyIUoJKIjc3XHEV03CXYxLWBSolj1hoOVIt2dqq18wPETJfouKUIC9bGpOgtwH14RtoT4B4AE/9Jh/amOIBjKeqHnht52tCnL5FuTwZy05y8go7wcfBD+Asag/BLvSXLhG01F8y//AevMWYxvxnO3lYhit0U9CsZcTN9ZE+Gmhye/YOk0TJcX2ntxmn8rGgZNo2cF/DdbX9CnNFA1dfdBG5kUXqINUjBkRappculBH2PIp/pPrtzysNC9SeLmw9YuvkN7gnsky5yA52QZqCJpqC62eQxHSIUA0bn5oBARWTjm9b3VOwZU01Dovh19j1Qpt8ftpemtOL91LZQ2HV2Q5zTInRWVj3vLYI8vsB7IcXFFwy3BVEkXEBAJjQsO2Qm21WIetTaAzGTdEjTYdqG8gOliv5HojR+b3vaJ0+ZgrtrsVTMe701PkNWMOVEpxxREaYxpejrjc5KZ9p4zIZeADFx2EIUsIRQbyReC7cxqVO54CpF9qPRNIjGoSr9QSy3nl0EmObtKpyvsDfCIyUrRnsqMcta7WmBTqZEfdwgkl9SMxIBvqFs7Jzi9qTnsEJbbiKJplrUJQ+z94MtdTN+oxL0+zDhzNjKfLS5LpqHMEL608pko0LVQn+yFLbCvsKV9DgX3SxswzjqfDtK6ptyA/3G4CN7/HFm0sJbuC0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199018)(4744005)(36756003)(7406005)(5660300002)(7416002)(26005)(8936002)(6506007)(82960400001)(6512007)(122000001)(38100700002)(186003)(91956017)(2616005)(64756008)(8676002)(86362001)(54906003)(316002)(4326008)(66946007)(41300700001)(66556008)(6916009)(66446008)(76116006)(6486002)(71200400001)(478600001)(38070700005)(2906002)(66476007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUZwWFdaV0ZqTHJKYm9GeTlaZHJHemJEVnpIdzVIaFN3aisva1pHWTl4VDcy?=
 =?utf-8?B?RXBhQXY5d2RKWm9sUXZWdk1JMW90N3FRQ2FQdlMwNzh2a3RJRTcvSjlsd3li?=
 =?utf-8?B?M1A0VG5DNFZnMmh4eW1hOW1jZVJUNlZTOERhRE54Snh2UjFENnZXL25WYU1a?=
 =?utf-8?B?RkFhWVl1cVJHWkpEWkhYbVdzY1hFVmJ0YlJDaHVTM2lOUFN2eUQxTzdlM01q?=
 =?utf-8?B?NVYrUE9qeXBFUmNyYUJ3ODJ6SXR4WllFNmR6ZnpvNHgrOUIwUHFiVWtRUUt4?=
 =?utf-8?B?cklMZDNnYmtrNE5ycXJRcjdLOTlUOUMxYmRuYytYZlZpYUs0cVNzMFBoRHBZ?=
 =?utf-8?B?a0p0ZGY4eEZ5ZExWRHk2RlYyTlVQZDlSUklnb2Zxb0NDcGtVK0ljcTlvSWJ5?=
 =?utf-8?B?Ylk2RGE4N0kvZENhbzBUUUtFNGk1TURtV2ZhYWNtT2sxUG1VbGV2b0lkQ0pK?=
 =?utf-8?B?OGxVYzh4WlI2dHpRcTFCMkI3MUcwTGlycVRTS1RPdTBqM0FvRTBlTTl3d1Bp?=
 =?utf-8?B?ek9KSTQ0Y043Y0E2OW1lVE9ZWjRkMXdiT3RmOU01SHpEWjlzWk54OU45QTFw?=
 =?utf-8?B?eUhEOW42c1VBZGd3MWZQNnVjZkp5OVdvdk1Ycy9zL0VjMStPQjNCUGJ2RGpE?=
 =?utf-8?B?dHR4bGQ5aFYybW9aZm00TUlSTkFTUHRGa0Y1bktoNi8vc0VqZDFtbjU5TDZj?=
 =?utf-8?B?WDZoTCtHRHRldVBWR0VVb3lMbjdpK1RhQnh5OWJlWXdXYWEvbmp3aTBKWjVr?=
 =?utf-8?B?UTVsVVlzWndHNGQ2Z3JVeXFxLytpdXJKZndOTnRvT0tjNlBTNUkyaEFKODRX?=
 =?utf-8?B?VzVwcEJIU1YrR1hMS0VrcHpMYUp1Y0hCd1hBcURGdUdoKzBDM3pjZDh5eHBO?=
 =?utf-8?B?SU81ZkVCcmt1cWhwR25nNy8yaHc5TkthTTN3MVZjZCtRNW9UcFRReXlUaktO?=
 =?utf-8?B?TjJNWVcyakRjNVN2cG9WeHo2R1RkOHRRWDc3ZVk4VVkvMjhoTDJ4SlErQkt4?=
 =?utf-8?B?ZTYyNEM4UUcvTFZwZ0FabERrcnA4TnBCZkY0eitlUTIxdGZTMHdEc280cC9F?=
 =?utf-8?B?NFY3STlVS0hJczFmWkNaMldUQkllWklad1RDUjJOaVZxeFNFQXowcHVkYTRE?=
 =?utf-8?B?Z3FQaCtUOTNGNmtUR2dsZ245M3d2bDlYOHBtNzFtbXFDelhLN3Juek55azFm?=
 =?utf-8?B?c2dRVWZKQlhtNWVMWjNKbnlFN3hjNlI4OUdERFlXZ3Z2cmM4TytDaUlwV3Zk?=
 =?utf-8?B?OUxrY0s1Yy9ENmhoMHBjT0FZQmMycjF1QlFkUnlOVlNZSlZERGh4YURvcE54?=
 =?utf-8?B?YUFRR0NmczA5QWlIRFJkMzVxQkxvNldMOW56TnRmVVBtM28yQlI2ZnUzcHBZ?=
 =?utf-8?B?ZElmdUl6SjBKTXlGWDFjQk01OWpCcFBOT0owL0dMeW9Hd3JaaFlrWHFxd3dt?=
 =?utf-8?B?aGFOd1J4SzlHa3QzQzBiV3haY3pSWFNGZk53YkZITHkwWHdxVlBZVzVqYTJK?=
 =?utf-8?B?amQzRTc1aDZtL3NpdURjOURLZ2U4MUpMbkxJMnhaKzFvUjRoc0FVM0JVdVZ4?=
 =?utf-8?B?MHVPdThENWRnNnJVaGxNTUxvcm9RUG1lSE1KMUNzWkt4cWIvY01HanBRNjl4?=
 =?utf-8?B?TVQ1QW9iTmJwZGtFNFJXMGsxNU9DUkVINjVoZjBjZ2tiSEFua2VDOGJnNzBB?=
 =?utf-8?B?bmFOUlcvbTFWWERrZXJHWm0yZjhpV24yczdzbzdzV204MDB4Um1FZzBDcTBV?=
 =?utf-8?B?c2FTVFZmcGZickYzb005S3JpSm9GbVAzcTdnZG4rWmZXMmZlL21DV1ViWUp0?=
 =?utf-8?B?bFhMay9FS0lTUzFNcGdXeVFmTGpyZFYrRGwxa2c3SS8vQ0F0QzY0K3prSXNy?=
 =?utf-8?B?QXI3QXRvTllwRjdqdCtHQTdoUkM0T3E1aXFESDl3aGYvRXpiSFZLNDdFWHA0?=
 =?utf-8?B?MUtMRTJRKzhwR1ZtTUd0OFY2T1ROUFNOU0U5b3B5eDU5UVRJK0JmdWErNWFX?=
 =?utf-8?B?SUhDTDl1dllGSVVWUnJFQlJ6YkRSR0FMcFNRemRQTWxDYmYxQmo2SXhLNTZk?=
 =?utf-8?B?aHhGRjkxNTVhZmNSeHErcWxmMU80QVV4L04rSFE3S2lpOGpjTWUycXNnT2FW?=
 =?utf-8?B?b3h2b21uWW9lQU83RmxXd2IzamZOTmp5dTZEdzhtSlBMV0pLN1ZrY1BHbUxu?=
 =?utf-8?Q?T9NbCstOh3FK5tb9FnHAfsY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0BC4CCD946F67049A826BE68AC664902@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f655040a-4b8a-406e-46de-08db218aa772
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 17:12:40.1076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HlAl1dKqhvRN92xuMmVsdJyMgCgG5Cyig8YiT3Nqq75YiogZlSq0uEsHRBt9xm04oPCNrVmjWXnk/ad9omto4ASONdbobSVi8NaOJZ4KW3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5165
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

T24gRnJpLCAyMDIzLTAzLTEwIGF0IDE3OjExICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQoNClsuLi5dDQoNClRoYW5rcyBvbiBhbGwgdGhlIHRleHQgZWRpdHMuDQoNCj4gT24gTW9uLCBG
ZWIgMjcsIDIwMjMgYXQgMDI6Mjk6NDlQTSAtMDgwMCwgUmljayBFZGdlY29tYmUgd3JvdGU6DQo+
ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2VudHJ5L3N5c2NhbGxzL3N5c2NhbGxfNjQudGJsDQo+
ID4gYi9hcmNoL3g4Ni9lbnRyeS9zeXNjYWxscy9zeXNjYWxsXzY0LnRibA0KPiA+IGluZGV4IGM4
NGQxMjYwOGNkMi4uZjY1YzY3MWNlM2IxIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L2VudHJ5
L3N5c2NhbGxzL3N5c2NhbGxfNjQudGJsDQo+ID4gKysrIGIvYXJjaC94ODYvZW50cnkvc3lzY2Fs
bHMvc3lzY2FsbF82NC50YmwNCj4gPiBAQCAtMzcyLDYgKzM3Miw3IEBADQo+ID4gIDQ0OAljb21t
b24JcHJvY2Vzc19tcmVsZWFzZQlzeXNfcHJvY2Vzc19tcmVsZWFzDQo+ID4gZQ0KPiA+ICA0NDkJ
Y29tbW9uCWZ1dGV4X3dhaXR2CQlzeXNfZnV0ZXhfd2FpdHYNCj4gPiAgNDUwCWNvbW1vbglzZXRf
bWVtcG9saWN5X2hvbWVfbm9kZQlzeXNfc2V0X21lbXBvbGljeV9oDQo+ID4gb21lX25vZGUNCj4g
PiArNDUxCTY0CW1hcF9zaGFkb3dfc3RhY2sJc3lzX21hcF9zaGFkb3dfc3RhY2sNCj4gDQo+IFll
YWgsIHRoaXMnbGwgbmVlZCBhIG1hbnBhZ2UgdG9vLCBJIHByZXN1bWUuIEJ1dCBsYXRlci4NCg0K
SSBoYXZlIG9uZSB0byBzdWJtaXQuDQoNClsuLi5dDQoNCj4gPiArDQo+ID4gKwlpZiAoYWRkciAm
JiBhZGRyIDw9IDB4RkZGRkZGRkYpDQo+IA0KPiAJCQk8IFNaXzRHDQo+IA0KPiA+ICsJCXJldHVy
biAtRUlOVkFMOw0KPiANCj4gQ2FuIHdlIHVzZSBkaXN0aW5jdCBuZWdhdGl2ZSByZXR2YWxzIGlu
IGVhY2ggY2FzZSBzbyB0aGF0IGl0IGlzIGNsZWFyDQo+IHRvDQo+IHVzZXJzcGFjZSB3aGVyZSBp
dCBmYWlscywgKmlmKiBpdCBmYWlscz8NCg0KR29vZCBpZGVhLCBJIHRoaW5rIG1heWJlIEVSQU5H
RS4NCg0K
