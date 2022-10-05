Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46A35F5CDB
	for <lists+linux-arch@lfdr.de>; Thu,  6 Oct 2022 00:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiJEWpJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Oct 2022 18:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJEWpI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Oct 2022 18:45:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E42545F7F;
        Wed,  5 Oct 2022 15:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665009905; x=1696545905;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lHPpZKIpID47V1I/sUDLefkRg40rN1PCnXIP0Jds1RA=;
  b=diQ78ZGqgg3LtTokUrhETjmSuMra5U7kAXGEFxg1+ZCEg6QAXciokQpM
   UdGoajHc1yceFeqN0Roy7o/aynXriC6zyrYsWA3NeXtxY+9fyj6MSUUyT
   B2bfwnAJqJUC/boWJPtF4ihEfp2dK+w8noZ2UTk7JddCEhmTxbISMa8lZ
   /TvwUsZrhoRoHENTA4Yg0hhGMCmNEebNJZftHfjqGKkNjgEtyOytR/Q/g
   hUOkRDNHTW3VCPEjhpFjOdYPkqIrutQ2x7k8PtRu9GdOeVvyuot2h2xY4
   Yh13GvL2z0XVq1DAYOdHu/x7njSh0SzwqVn3aXL/FCzk9emJDVGL7tOt5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="283659848"
X-IronPort-AV: E=Sophos;i="5.95,162,1661842800"; 
   d="scan'208";a="283659848"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 15:45:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="749938467"
X-IronPort-AV: E=Sophos;i="5.95,162,1661842800"; 
   d="scan'208";a="749938467"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 05 Oct 2022 15:45:01 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 5 Oct 2022 15:44:57 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 5 Oct 2022 15:44:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 5 Oct 2022 15:44:56 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 5 Oct 2022 15:44:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kp4glkoTZJ6LKx5fyzJ5Wywq4l2lZOEi1hlekPVSepKWPf0NFlOLkt560YYi/0cNx5GOd1/+MSpQhWc/CiWQHSROtax6vmZpt4tdkVG0OT1GNi+3Q+O+zJH2l5Dd1v9jnCnDZu0F91J+p4RQmLIVTVpN48A9V0h0tbxlneYwS7MEXAYucX4V83icbYSez8poY8k8gPk4zgnMfEsOvuiZMceQhc6LLF512ECZrwzHD1skSSHvz5YkwmURND4IY2hMWmfzR/HfRdO448Wr9km+wE6pV99+6DpogLKsTsXsafvoC7nB8y4CW/JcLZkRxAs/eMMRtBo90F1XN7YF3vkHmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHPpZKIpID47V1I/sUDLefkRg40rN1PCnXIP0Jds1RA=;
 b=IWDOy4in1kYOnRl5si1TjmsrJfnye6f9SUzucaZzHV3XDQPEjgNdQblLfgR2VN6+8xD2oh8gydYC1FRNuGmjfuBaECHEEN9DMTB4BVMeuDX6ad59nCKWM9+anBtLxrcDQBfCjdQ7om07Amj6cTBzTRL7YrnHOCnNAIb4CMGTj4vAZXuoVbgw+J14xt/qwQ7m7Y5TcLP5WbZgFUiH7BHyObNFsVg6m9xF8dQTxK9ZER+Lby+MISL+eSQLu0nat2APw8PyxU2yDk/yiD3uYmXPcNv7A0cr6TX9EIp0/jQS9B3a3dKYBnjr31OTvFEud/ANqX+2tgTgJnbq0peSrdH8fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SN7PR11MB7020.namprd11.prod.outlook.com (2603:10b6:806:2af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Wed, 5 Oct
 2022 22:44:52 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.034; Wed, 5 Oct 2022
 22:44:52 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
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
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>
Subject: Re: [PATCH v2 07/39] x86/cet: Add user control-protection fault
 handler
Thread-Topic: [PATCH v2 07/39] x86/cet: Add user control-protection fault
 handler
Thread-Index: AQHY1FMIU7BZJQMEy0SHUZZeq6SSP63/CMQAgAFmvoA=
Date:   Wed, 5 Oct 2022 22:44:52 +0000
Message-ID: <1025827927635176e95915a43f27ec74e2c59f0d.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-8-rick.p.edgecombe@intel.com>
         <55592df6-a138-4995-5b2f-3720bedccf50@citrix.com>
In-Reply-To: <55592df6-a138-4995-5b2f-3720bedccf50@citrix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SN7PR11MB7020:EE_
x-ms-office365-filtering-correlation-id: da9c6138-9a1a-4da9-9872-08daa7233788
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rZBlHUdaT+iLVInPdMEOZQU0M9l9lc7v4b98Tr42OvfQWgsC25Q6qIbyzAcvm8EW9sQHnTIFmJdQ737B0MqyhrDVFoxN2Rh+oQNZE60x5edyymSkRvE6npXBUjp8WfdoTzbagAqdMITqdEe1JcgjEBX06RfNw2mG3CCxYQETkIKdjsAF5uUQGRAkf3D+iNnQvoj5bXUVF1ZHHh1j+b6RqV/DBJRglDPr5VhmUU6rVzdffU6upwHBmVI467RhzL/TvzCutIkU5XWEuDQxOyVrzTFN9Q8y20enAdWUSV5l64NRwQtq9H6P50xaiv98rq5QzL2A1yo0Q8VlGXqIjRuj7Pp3dxhVvFrNHUj9sCYOko4Z/wDWDUb7gCnVQDFtn/ndNGxJq+K4ec35Wk9KiJtCKmrCLxVPAk7/0fQDTdauUyyGMk8Q3TFS5/7AUsnE+TtovMQhQ9gkTKGynHPrVYzwxdavUClVdudEz1HExeRiewnYzMXoE6bADoAFUTK5xXM9+bYODEhYNnNDILzhraosr8ohrLlV37B5La9Lf84jj0E7kvJLKX8jof7Xzq1mHLDV7Qu9i9HWqEXLBQQmmXTBnVm2v+uVnONDyj0DRwRjxbd78v7abkFvfrrePlFrI4q7tfxl9yJTPD8ZpAlTEpASbNRM2U1UiqmbAbdBM/6hOKCES7LrcLkgMHTAXr65hcKQkFpyc8HoHlExKC31DvL3o2GX37OLK1RZl0zNem+0Q1J2J3HMCFBOYdunIUn/NKfWGRPy/dPNf+m6H/raUyewWmCUZxhzoEEehXRik1FDTeCFR5NDy7m0JbnLZalSIFj1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199015)(66946007)(66476007)(38070700005)(82960400001)(64756008)(921005)(76116006)(66556008)(66446008)(91956017)(8936002)(41300700001)(122000001)(38100700002)(316002)(86362001)(83380400001)(4326008)(186003)(2616005)(478600001)(6486002)(53546011)(26005)(6506007)(6512007)(71200400001)(8676002)(5660300002)(36756003)(2906002)(54906003)(110136005)(7416002)(7406005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGNKTzJJd3VTd2ZQRWdoWHVMMDFIdTRJclRsQk9iQk9qS3FRd2hHaUI4enN3?=
 =?utf-8?B?cktjWjFhTHdhYlVaNmRmYjU3RGFpaUQwR1h1TmZSTGh3cmRDdFpjOC9BSW0z?=
 =?utf-8?B?VWhtTDRQcldLQVR6MXdNN3Z2RmFpa3g4NnBjRWNuNnAzdEVzbUdZaXJXNWtl?=
 =?utf-8?B?bnRabENlZGo1VnNGR2YrdmZkU2VaaVFJNXFzMW5LQWh0SVVGRUVUZWtZZkx4?=
 =?utf-8?B?ZzBlYnZnS1NXMVRoK3VJTTRiNlNod2dLVDBlZTc1UmlPdzJ0S2JpY05qVWFB?=
 =?utf-8?B?bHZ5bEd0Tm9KdEk1U1RmSUtVMXBhamlkOGQyYkl2K1I1QUVaT05yZnhLMW5l?=
 =?utf-8?B?UE1OcXVVUjZOS0QzT3NIVkRwaWRMQmJuVTVnMGJkRXg1YkIrYlgrV3prRVhP?=
 =?utf-8?B?aGZsYTR2L3RHU0JidWNPSisyZ212RVZHZndPNTh6QWx5akNtTEZJbUFhNVg1?=
 =?utf-8?B?emV4S0M5d1dSTmxMTnBBdW9QTm8xN05XRzhNQitGNUw0RlVMbnovVTJoZnEy?=
 =?utf-8?B?bDVlS3ljNjZEb3JtaTZRL25VQmx4VXdIbGozakFVUnlleERpWmVhZ1hnWk4r?=
 =?utf-8?B?Q1dBMUFDNVM5SkVCZkd5SkNrcEtnUnFjMDNDcUMrcUcrTVZUN2p0bUg5N2xQ?=
 =?utf-8?B?MUUycjJvM2VKV1R1OGt0a3pPZFFFajgyQVU5V0tUTzBjZUh3L0Q1bVRiQU5j?=
 =?utf-8?B?NWUvUXB4QUYyYTgyem5pY1BBTGVIVzJ4dEo2Z3BRZXBNQUJOdnZOeDhySFFF?=
 =?utf-8?B?VStPVjZUdVFoMkhzM0QzOVd6OE1NVEFDRC9GY0NiUUdPVzZaRnZRcHlXUmVv?=
 =?utf-8?B?VjRKQlVoV21ZWGQ5Y0hNUDNHNlNReTF5cjlIaXZoMDFINFZ3NU5xVkx3Vyt2?=
 =?utf-8?B?aXZac2cxSnJBVkxMQ0VPbXYwUzR4SFVib3BnQy9mcnZ2YVhBOFFVRW9HRWRG?=
 =?utf-8?B?WG5UeXVmOVVGb2J4N3NKUTIvdlZSSDZ6TUVBOHV4KzdSbERyQkhkd24xUkdS?=
 =?utf-8?B?SUVQNHljMnJPV3hwVXRGQ0RKNUI2emozejhXN1BjMVJqdFRtTEN2ZnBkcG9K?=
 =?utf-8?B?c0krOUR4cnJjcmRFQkR1RTYvZTZCWG4vWFpscHBJSGgzSE00ZFB6Z3BSRkU2?=
 =?utf-8?B?QXhyV1RqRnI0SkJKL3BsVERkQ2lkM3ZqOTJmb0sxRHpzM21KMzF5b3RvVXkr?=
 =?utf-8?B?RjFrdm5QREdzWHp2ZGJ5VTQvbThCYWF1SjJFQ1NkanYvYi9XQXR2bEgvdmJR?=
 =?utf-8?B?K2hSRiszMmlUQU9BTEp4WFVpSGJzZDF1M3JVTUJ4SC9LTXZaT1BWeForakIz?=
 =?utf-8?B?WStKWW52YXNiSk03OUUyZllxN1hVODIrMDM0T3ZVOHplRnZNUmgra2pOa2VB?=
 =?utf-8?B?M1dLSFY4UVcyN29HakhFRHVhSkplcG55ZTZFOGdJU1lZaFBLa1FlR3lydTgz?=
 =?utf-8?B?RnZ4MG43TXNlek81bWxkemN5SHJJNDRwbU84N0VhTUV6T0NEOVJ4SC84SDN5?=
 =?utf-8?B?MmhpMWNDdFByZFRIaTlyZ0tzazVWaG9mcGcva1pFdEl4L3pLNDFESXdSSThh?=
 =?utf-8?B?SEZJWU9nL1lsQnc0b3ZTeXFBc29ML0JDM3htZnJ4MGVCRHNnWmlOZCtQbXZr?=
 =?utf-8?B?TnZqNFBrWVlHSWNGU3hmTUM2UUU3VG13WEVZQ2ZSZlg3M2k3NlVGamVrUWo5?=
 =?utf-8?B?N0FiS2tycWZpcDYrb3BTMXZmMzNnZTgxOGxpNzZ5UHpkWU01QkxDaGYrcFZH?=
 =?utf-8?B?UmdzTG5HT3ExNnA1NWZET2JqQlU5ZENuamJhbURqbURzRUlJZ3p1VEtiblVS?=
 =?utf-8?B?T2xjS1BaUlFwdGJrU0FNZ21nY011aDhVUzVBa05ONHZxSGg4U3IraW5JUktC?=
 =?utf-8?B?VXB1c1U0VU5IdHlHWGwrMExGb1k4T2xFT21NZ1R0V25ZK3JsSU5VV2tCUnNQ?=
 =?utf-8?B?ckgyWWNzYTlWR3RPdCtsYW9ORDMvRjczUHRaUThaZDFVTit1ZVVJYkVGcUF0?=
 =?utf-8?B?eTN6a2MraWxVYlNadCtQRzdDMHVCSnpFOGxNcFhLZkdtUjYzbVZiRlNvdCt6?=
 =?utf-8?B?YmsydmNwZFpsQVJRU3g0RTdrYnZnMjZyckI0dnR2TFBrUnhWclhlbHg3MWpp?=
 =?utf-8?B?RzN4QVNLeUQ3Vzh6Q1ptbWhqZjc2UlpWMHVWVFdxZ0RYbk1CWFpiN2pXYnBO?=
 =?utf-8?Q?Z1QurUGKWWqiCXDR3LTAHuY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E4FBE9C710A5E49BB161FEC5893C21B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da9c6138-9a1a-4da9-9872-08daa7233788
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 22:44:52.3114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fxmUJLfk58gfAi5i6Y5VMKyXG0z+YsQdhhnxyVeSo5205IH1lnrCvDc8hbg61l8x2Uro/zVfenqx+ShhDvVLxsiR62a+l4+oBH2pxh4o9UI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7020
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gV2VkLCAyMDIyLTEwLTA1IGF0IDAxOjIwICswMDAwLCBBbmRyZXcgQ29vcGVyIHdyb3RlOg0K
PiBPbiAyOS8wOS8yMDIyIDIzOjI5LCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToNCj4gPiBkaWZmIC0t
Z2l0IGEvYXJjaC94ODYva2VybmVsL3RyYXBzLmMgYi9hcmNoL3g4Ni9rZXJuZWwvdHJhcHMuYw0K
PiA+IGluZGV4IGQ2MmIyY2I4NWNlYS4uYjdkZGU4NzMwMjM2IDEwMDY0NA0KPiA+IC0tLSBhL2Fy
Y2gveDg2L2tlcm5lbC90cmFwcy5jDQo+ID4gKysrIGIvYXJjaC94ODYva2VybmVsL3RyYXBzLmMN
Cj4gPiBAQCAtMjI5LDE2ICsyMjMsNzQgQEAgZW51bSBjcF9lcnJvcl9jb2RlIHsNCj4gPiAgCUNQ
X0VOQ0wJICAgICA9IDEgPDwgMTUsDQo+ID4gIH07DQo+ID4gIA0KPiA+IC1ERUZJTkVfSURURU5U
UllfRVJST1JDT0RFKGV4Y19jb250cm9sX3Byb3RlY3Rpb24pDQo+ID4gKyNpZmRlZiBDT05GSUdf
WDg2X1NIQURPV19TVEFDSw0KPiA+ICtzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IGNvbnRyb2xf
cHJvdGVjdGlvbl9lcnJbXSA9IHsNCj4gPiArCSJ1bmtub3duIiwNCj4gPiArCSJuZWFyLXJldCIs
DQo+ID4gKwkiZmFyLXJldC9pcmV0IiwNCj4gPiArCSJlbmRicmFuY2giLA0KPiA+ICsJInJzdG9y
c3NwIiwNCj4gPiArCSJzZXRzc2JzeSIsDQo+ID4gK307DQo+IA0KPiBUaGVzZSBhcmUgYSBtaXgg
b2YgU0hTVEsgYW5kIElCVCBlcnJvcnMuICBUaGV5IHNob3VsZCBiZSBpbnNpZGUNCj4gQ09ORklH
X1g4Nl9DRVQgdXNpbmcgS2Vlcycgc3VnZ2VzdGlvbi4NCj4gDQo+IEFsc28sIGlmIHlvdSBleHBy
ZXNzIHRoaXMgYXMNCj4gDQo+IHN0YXRpYyBjb25zdCBjaGFyIGVycm9yc1tdWzEwXSA9IHsNCj4g
ICAgIFswXSA9ICJ1bmtub3duIiwNCj4gICAgIFsxXSA9ICJuZWFyIHJldCIsDQo+ICAgICBbMl0g
PSAiZmFyL2lyZXQiLA0KPiAgICAgWzNdID0gImVuZGJyYW5jaCIsDQo+ICAgICBbNF0gPSAicnN0
b3Jzc3AiLA0KPiAgICAgWzVdID0gInNldHNzYnN5IiwNCj4gfTsNCj4gDQo+IHRoZW4geW91IGNh
biBlbmNvZGUgYWxsIHRoZSBzdHJpbmdzIGluIHJvdWdobHkgdGhlIHNwYWNlIGl0IHRha2VzIHRv
DQo+IGxheQ0KPiBvdXQgdGhlIHBvaW50ZXJzIGFib3ZlLg0KDQpJdCBpcyBvbmx5IHVzZWQgaW4g
dGhlIHVzZXIgc2hhZG93IHN0YWNrIHNpZGUgb2YgdGhlIGhhbmRsZXIuIEkgZ3Vlc3MNCnRoZSBr
ZXJuZWwgSUJUIHNpZGUgb2YgdGhlIGhhbmRsZXIgY291bGQgcHJpbnQgdGhlc2Ugb3V0IHRvby4N
Cg0KQ2FuIHlvdSBleHBsYWluIG1vcmUgYWJvdXQgd2h5IHRoaXMgYXJyYXkgaXMgYmV0dGVyIHRo
YW4gdGhlIG90aGVyIG9uZT8NCg0KPiANCj4gPiArDQo+ID4gK3N0YXRpYyBERUZJTkVfUkFURUxJ
TUlUX1NUQVRFKGNwZl9yYXRlLA0KPiA+IERFRkFVTFRfUkFURUxJTUlUX0lOVEVSVkFMLA0KPiA+
ICsJCQkgICAgICBERUZBVUxUX1JBVEVMSU1JVF9CVVJTVCk7DQo+ID4gKw0KPiA+ICtzdGF0aWMg
dm9pZCBkb191c2VyX2NvbnRyb2xfcHJvdGVjdGlvbl9mYXVsdChzdHJ1Y3QgcHRfcmVncyAqcmVn
cywNCj4gPiArCQkJCQkgICAgIHVuc2lnbmVkIGxvbmcgZXJyb3JfY29kZSkNCj4gPiAgew0KPiA+
IC0JaWYgKCFjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX0lCVCkpIHsNCj4gPiAtCQlw
cl9lcnIoIlVuZXhwZWN0ZWQgI0NQXG4iKTsNCj4gPiAtCQlCVUcoKTsNCj4gPiArCXN0cnVjdCB0
YXNrX3N0cnVjdCAqdHNrOw0KPiA+ICsJdW5zaWduZWQgbG9uZyBzc3A7DQo+ID4gKw0KPiA+ICsJ
LyogUmVhZCBTU1AgYmVmb3JlIGVuYWJsaW5nIGludGVycnVwdHMuICovDQo+ID4gKwlyZG1zcmwo
TVNSX0lBMzJfUEwzX1NTUCwgc3NwKTsNCj4gPiArDQo+ID4gKwljb25kX2xvY2FsX2lycV9lbmFi
bGUocmVncyk7DQo+ID4gKw0KPiA+ICsJaWYgKCFjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFU
VVJFX1NIU1RLKSkNCj4gPiArCQlXQVJOX09OQ0UoMSwgIlVzZXItbW9kZSBjb250cm9sIHByb3Rl
Y3Rpb24gZmF1bHQgd2l0aA0KPiA+IHNoYWRvdyBzdXBwb3J0IGRpc2FibGVkXG4iKTsNCj4gDQo+
IFNvIGl0J3Mgb2sgdG8gZ2V0IGFuIHVuZXhwZWN0ZWQgI0NQIG9uIENFVC1jYXBhYmxlIGhhcmR3
YXJlLCBidXQgbm90DQo+IG9uDQo+IENFVC1pbmNhcGFibGUgaGFyZHdhcmU/DQo+IA0KPiBUaGUg
Y29uZGl0aW9ucyBmb3IgdGhpcyBXQVJOKCkgKGFuZCBvdGhlcnMpIHByb2JhYmx5IHdhbnQgYWRq
dXN0aW5nDQo+IHRvDQo+IHdoYXQgdGhlIGtlcm5lbCBoYXMgZW5hYmxlZCwgbm90IHdoYXQgaGFy
ZHdhcmUgaXMgY2FwYWJsZSBvZi4NCg0KU29ycnksIEkgZG9uJ3QgZm9sbG93LiBUaGlzIGNvZGUg
aXMgb25seSBjb21waWxlZCBpbiBpZiB0aGUga2VybmVsIGhhcw0KYmVlbiBjb21waWxlZCBmb3Ig
dXNlcnNwYWNlIHNoYWRvdyBzdGFja3MuIElmIHRoZSBIVyBzdXBwb3J0cyBpdCBhbmQNCnRoZSBr
ZXJuZWwgaXMgY29uZmlndXJlZCBmb3IgaXQsIGl0IHNob3VsZCBiZSBlbmFibGVkLiBJZiB5b3Ug
Y2xlYXIgaXQNCndpdGggdGhlIGNsZWFyY3B1aWQgY29tbWFuZCBsaW5lIGl0IHNob3VsZCBiZSBh
cyBpZiB0aGUgSFcgZG9lc24ndA0Kc3VwcG9ydCBpdC4gU28gSSB0aGluayBpdCBzaG91bGQgbm90
IGJlIHRvbyB1bmV4cGVjdGVkLCBpbiBzaXR1YXRpb25zDQp3aGVyZSBpdCBnZXRzIHBhc3NlZCB0
aGlzIGNoZWNrLg0KDQo+IA0KPiA+IEBAIC0yODMsOSArMzM1LDI5IEBAIHN0YXRpYyBpbnQgX19p
bml0IGlidF9zZXR1cChjaGFyICpzdHIpDQo+ID4gIH0NCj4gPiAgDQo+ID4gIF9fc2V0dXAoImli
dD0iLCBpYnRfc2V0dXApOw0KPiA+IC0NCj4gPiArI2Vsc2UNCj4gPiArc3RhdGljIHZvaWQgZG9f
a2VybmVsX2NvbnRyb2xfcHJvdGVjdGlvbl9mYXVsdChzdHJ1Y3QgcHRfcmVncw0KPiA+ICpyZWdz
KQ0KPiA+ICt7DQo+ID4gKwlXQVJOX09OQ0UoMSwgIktlcm5lbC1tb2RlIGNvbnRyb2wgcHJvdGVj
dGlvbiBmYXVsdCB3aXRoIElCVA0KPiA+IGRpc2FibGVkXG4iKTsNCj4gPiArfQ0KPiA+ICAjZW5k
aWYgLyogQ09ORklHX1g4Nl9LRVJORUxfSUJUICovDQo+ID4gIA0KPiA+ICsjaWYgZGVmaW5lZChD
T05GSUdfWDg2X0tFUk5FTF9JQlQpIHx8DQo+ID4gZGVmaW5lZChDT05GSUdfWDg2X1NIQURPV19T
VEFDSykNCj4gPiArREVGSU5FX0lEVEVOVFJZX0VSUk9SQ09ERShleGNfY29udHJvbF9wcm90ZWN0
aW9uKQ0KPiA+ICt7DQo+ID4gKwlpZiAoIWNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVf
SUJUKSAmJg0KPiA+ICsJICAgICFjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX1NIU1RL
KSkgew0KPiA+ICsJCXByX2VycigiVW5leHBlY3RlZCAjQ1BcbiIpOw0KPiANCj4gRG8gc29tZSBm
dXR1cmUgcG9vciBzb2xlIGEgZmF2b3VyIGFuZCByZW5kZXIgdGhlIG51bWVyaWMgZXJyb3IgY29k
ZQ0KPiB0b28uICBXaXRob3V0IGl0LCB0aGUgZXJyb3IgaXMgYW1iaWd1b3VzIGJldHdlZW4gU0hT
VEsgYW5kIElCVCB3aGVuDQo+ICVyaXANCj4gcG9pbnRzIGF0IGEgY2FsbC9yZXQgaW5zdHJ1Y3Rp
b24uDQo+IA0KDQpUaGlzIHdhcyBmcm9tIHRoZSBvcmlnaW5hbCBrZXJuZWwgSUJUIGhhbmRsZXIu
IFllcywgYWxsIHRoZXNlIG1lc3NhZ2VzDQpzaG91bGQgcHJvYmFibHkgYmUgdW5pZmllZCB0b28u
IFRoYW5rcy4NCg==
