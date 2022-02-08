Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CAB4ACE43
	for <lists+linux-arch@lfdr.de>; Tue,  8 Feb 2022 02:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239205AbiBHBsB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Feb 2022 20:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345132AbiBHBrA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Feb 2022 20:47:00 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EFAC061355;
        Mon,  7 Feb 2022 17:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644284819; x=1675820819;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4lM+AWjIKWUp12iTa/p4Ugx+rW9oiwVAyLCrH+LD+Rg=;
  b=ail96WhQ5IvpKZeiYpMzU/Cz7jQl6IA43lWLR9bgLgqBO3uS4iPmpHEA
   F2b8H6vOc8t1idBUvhPYRXyyjF9cU38yP7qAaCYkm6WUXDDSyM498GhGW
   s/SaJmDu+1DloSwbRgvxv+5ajx2Pv/2C5kgmMFTqGMdiUbiNFczo6kNsY
   snK+tK+KNfp3RLS7APHxi59QkJ7DFOZYPI6zcmh7i29445PfCZDJFSUfW
   dqE8UPADWRmaF8X70JsswNhSzxg9fooITqrcvvHiH3uldFjMpIy2aPuhQ
   0ahDnx7y7BZ/dvEH53z014VBxaHBSzKk9ggT6WD47rqC8n5KgwNSqSVc1
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="248797732"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="248797732"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 17:46:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="700675858"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga005.jf.intel.com with ESMTP; 07 Feb 2022 17:46:57 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 7 Feb 2022 17:46:57 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 7 Feb 2022 17:46:56 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 7 Feb 2022 17:46:56 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 7 Feb 2022 17:46:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIMfcWY1+8f+i2qV+Tz1/Qc4wO6AfBjm+V5IEyFDN3Ap0D9s03fjxm7Fbo/zC1miFI7dc09msIpKPC8rlXSUW820hyw4Y8KC/fgRy+5G52GsfWEvWcyEvekYCSpWnI+4lkVVNVt3exlqppbrOHRndypUm2JfaWmCPWwzJwEioh6K0ePLLz98V1BTQMDsHT7l67d6QgprQgtVAEYn8N/aX35i0KfANtToeXDMMU+rpdasyrylU/4IHRVDMrQCtqMZXAOyBCq9gvbE9uCjiIOiyNxcR7iyJY3gMCo5MDuih/y862ctQIbJRebAkMRUVu+2YBPb2Dmd0E3aDy5qPAHyQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lM+AWjIKWUp12iTa/p4Ugx+rW9oiwVAyLCrH+LD+Rg=;
 b=lXVTjorTvk6uOvUmByoIhm3js0PHh/w77QfmCsAqHU0gQyChn2ILnLgMhu9byhugmnpYUl1rPkf2EXrTQ0g0Srj2g2q+FxWldFRmO5IHYT29vbV4Z3gh8/toVP3cumbmlIAqEZbr3GCwB/rfW7OEn87NJvN9R3low/BgF2rvMGJnn+uavLJ4kobxqBfe7neApVmCIJTWJTX+nz/+eKOr6gGy6EApaftEYONA/2vaHzCrqgU8Lr4nQGSBcH6IwmlnpIJk3Tad19l0dZeSD7lN2Dm0ZApw0Qs3PksfLzqPCbzXIDhPhUliz+8uKYI+dwXqQAtDwr7DyxFJNtE/8YIl6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MWHPR11MB1453.namprd11.prod.outlook.com (2603:10b6:301:c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Tue, 8 Feb
 2022 01:46:51 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15%4]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 01:46:50 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>
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
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
Thread-Topic: [PATCH 00/35] Shadow stacks for userspace
Thread-Index: AQHYFh9orVaVUe6rNECZu4edjJzhZqyCV/wAgABDLwCAAl19kIAABAWAgABxL4CAARiJ8IACaNWA
Date:   Tue, 8 Feb 2022 01:46:50 +0000
Message-ID: <68ee0ba10ee191f1d3925479d400c41a35c5ded3.camel@intel.com>
References: <87fsozek0j.ffs@tglx>
         <a7e59ae16e0e05579b087caf4045e42b174e2167.camel@intel.com>
         <3421da7fc8474b6db0e265b20ffd28d0@AcuMS.aculab.com>
         <CAMe9rOonepEiRyoAyTGkDMQQhuyuoP4iTZJJhKGxgnq9vv=dLQ@mail.gmail.com>
         <9f948745435c4c9273131146d50fe6f328b91a78.camel@intel.com>
         <782f27dbe6fc419a8946eeb426253e28@AcuMS.aculab.com>
In-Reply-To: <782f27dbe6fc419a8946eeb426253e28@AcuMS.aculab.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 589dda5d-10c0-4ecf-b296-08d9eaa4e065
x-ms-traffictypediagnostic: MWHPR11MB1453:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR11MB145387EFB6D9FF8D4A3ABBE5C92D9@MWHPR11MB1453.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q2vtEuRyx1kiJJ+MccD4lRussCRGBqHoJTCR149Lx5IBnMhhvgiWGtizNgtRutFM1gDvB4k01i221D2mFB5PY8ovgzN7Hsr1J2e6I4bTeP4uYLoRuzTuM1US+bKX4L2THmopFhcSbKowwWh86NmrIxkVy6jQDghNsllwgV3e+OwJjPxWRzaoSppjKvbU4/5iv0h29TfGstTyElTty1lNaumW5pTFlHflOdBWWA2g9pFqeFeQBnAbNQkYbT5vM8yu+xL8I3E4gYK7YkgfIlolNpRN7/+Fa1fAXEpES010r0yHxCg+vdd9W8gij+guzW0LwJ7zQ4tCu77YF9YTdgwHIHn+t84IxOk+ElXLX3WoqALPWejYTGTQ5YeQ46gIGAR0zofAIMnKnTU6ZQbeRqRTAzhEvuaXQZpdZOFKzpv2bSZZLef0Dtso7uLAlloIZrvJ3wUmEa6kMCfAypihqCAvJLemgpZ49NmDd4wOEEDoNDooCRC5Dztp8tKgNbMB/FvKaTK2xWSqTFjE9Q84PUQ1mJZTnYde6rmZ8iZ+BdmxT+4MNzKiy6jm9th2Alw++K99F50uxOKoEyQGTo972H2ZzUTbr8QJdsd600XCIEDd5rl0KlfWAjReHtYIs+wQtHH/yeJ3iiLp3sYfuWQMs9E/7sNsWPzJR8ouRHSCjaQY14rNAcX8qGXKr1khbEdboddU7p9c+EeprDoZYZDaxnsyZg2s17gPmvG1mMFoH3jQrBA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(122000001)(82960400001)(2906002)(38070700005)(508600001)(86362001)(54906003)(110136005)(38100700002)(83380400001)(71200400001)(36756003)(6486002)(7406005)(7416002)(2616005)(186003)(26005)(5660300002)(4326008)(8936002)(8676002)(64756008)(66446008)(6506007)(6512007)(66476007)(66946007)(76116006)(66556008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHNoTkFvdE14MDE1U1NNSVAzTTZPMnRuMkZPMFdGdU9rOVg2c21LUUIwY2lC?=
 =?utf-8?B?c21RdEVXWlBMd3l3U1lEOTRkQzB6b1ZOL0kyYlg3MTJlMTFSNEYzQktMSlo5?=
 =?utf-8?B?YW5UMVhGNVc4b3hTaEVIdW9iNk45d0IyWmFTd3Z4VTBrMXROcVhEeHhWYjg0?=
 =?utf-8?B?aGdVa3djTTNsd2ZTTyt5L1JFR1lYaXllWHVuVkJNRzZDVGdKWHUvVnROS3hW?=
 =?utf-8?B?S3NWT1B5elNVOGd0THdzcURFMzVuN2pIQytxNWlEZzJNS3dDZitTTGh5MEhE?=
 =?utf-8?B?V3NMaGIzSkwrSVFDU21lWkZVV2VtY0JiUmcreDZYK3JvZm1kMVNRT1dYbW0v?=
 =?utf-8?B?cmxZdjVBaDZLRkNmem80QkdvbUJ2a3Z0QzMrME1HeWtKcjdvQWVCSk5CV0R6?=
 =?utf-8?B?eWU1UGhaWHkwU2NxK1RvcEFGek9WNHN3aGZ4MkpiN3ZUYzU3NTJWTGp3OWNX?=
 =?utf-8?B?N0pSa3gzSHpsWElRaXI1cVFvQnlCZUpvMEtkMjVHeDJjYmZjcEtDcUxqM1Jl?=
 =?utf-8?B?aGRTMWNMWVhDS3pZRDFHY1oyUkpjeW9GaWdqa1dFd3ByODdid0VjeHQ0N0Y4?=
 =?utf-8?B?UHRQdXcxUUNDTE1tZkppKy9CR1lyOG1ka2VEOVRxNWtqUmNxUWdBVG9DTFN5?=
 =?utf-8?B?Mk9QRVpnVHhXYzZwTElHMmJGMVkvcTRBcVJFckJ4OHRLczZYN1dpRzM4R2JK?=
 =?utf-8?B?T1hzOHFUM1lqN1M3a0VTMjVVTXlZU1F4V2xMMUJCakxFQy90dzFKL0dPUTR6?=
 =?utf-8?B?dG56MFNkVzhnaGJBUWxIZ0xhMUV0M0thWkxIV1UxZXZoWENrd0JJZWJEY0R3?=
 =?utf-8?B?eFFRY3pkTDNNeUdwY3AzUW91Qy9PRjBBWDhiZkF0Q0lhRVQ1c21GL0h0STlu?=
 =?utf-8?B?V3hSaVJwQkpIU2xrMi8yK3lVSFU5L0JCM3Q3MnhYOW9menlycXRhblUrQ25n?=
 =?utf-8?B?NStqUEY5QThDTEZINldaRjZvUTVBMEJuZHNUbzZsMHdtQ21kNDlyU2lUZFVn?=
 =?utf-8?B?N1FqblJ4N1VNdHp6OW1JaWZyK2xrSFVPQ2ExUlBmOW9RbTJuaGJ1bVBWN1ho?=
 =?utf-8?B?T1pQWDJLVmZ6bmlVVTdhQjVWSzhONzBucTJneGpHZGlsUVJxRGkwOVZWOW5H?=
 =?utf-8?B?ajV4anBrUXAveHp5NW9ENWszSDJvTmhpbkllbCtlTnhqWXpES0NocWlXMlR3?=
 =?utf-8?B?QVljT05aL2xxQjdjRWVIN2htZ2FEUTBTOERmMk0rektOTHRBTHprRFBLNmVT?=
 =?utf-8?B?S3JYYnRTQXlMYm1UNjFFMzltcUxaOFhpOXNZLzNXRkFIYklUMUs3bytxZzRV?=
 =?utf-8?B?NDNvWXBDRDdudHA4ZUhxbmtKUjBQNmZaZFgvQmpTbHl5NWlWTTJhcEpsMldQ?=
 =?utf-8?B?V1VLTFBQNkx0aGV0QmpwdnBCYWhMQjl5OGszU0tVa1BEYUJkS25FbUZzUFg2?=
 =?utf-8?B?U0t0cmdaYno4ZHpBU3FHa3NYU0hTdDVJTWJxNlFodjRPOHpGKytUNnc4cjla?=
 =?utf-8?B?eW1EYkJURXNwWm5XanBqY29sWmloYUcxNmh5OElDQWc5bEwvU2U5bXJwYzA0?=
 =?utf-8?B?eW53QTl3bHNIN1VYWEwxODRzOTRUVzZ3a3pyY1pDNHU3S0FQZEdHbUpsOFNq?=
 =?utf-8?B?MUdDaWswbnhER1BUcVNheDdma1YvR2VKT3gyTXdieWFRQUoxUXBTSERjU2pI?=
 =?utf-8?B?bDIxZXZJc1ZTZ0hwaTJPbHlidFVTamp3d2l5Rkgxa09qOU91RitDV3ptcnhz?=
 =?utf-8?B?UitGcXgrQVlGcTRHKzdXSUZtV0wyOGMzcCtHdStPeGhXcFRxYWNlaTQ2VDdE?=
 =?utf-8?B?SU1tamlTeTBVYXAwUXY1YlBKeWlLRFcra29lVDM3bGo4VE5YSC80VTJJM0xi?=
 =?utf-8?B?MXVITlFOc3F5U1doUUVyaEFIeGFXOUFDVU0rQnM1dFFGZmg1Z2NWMWVaUnl3?=
 =?utf-8?B?bWhjMzZBbThadDc2ZXNFTVFIRW5WQzRSajZ4NXorUjRkakRSWUFCM0FxelR1?=
 =?utf-8?B?eE5UczdLbVNJQmhibm1iMGs0R3hhN3pGY2Jwa2JEclNQbDE1cWJXWWhJQkFn?=
 =?utf-8?B?YWJEbStZa3h2a05DVVFsSmpKNzFlanhXSGdTY1V2WDNaR3RDUEttZW9FU3Zo?=
 =?utf-8?B?OXFORzc5Mmc0TVg3NzBRck9KeDZLTGswQytMWFpQRTZBMnNOUmVJbzBhNHdk?=
 =?utf-8?B?cGd5bERnbC9naHRzQVRCb0hLNnN1R25BNWlXeEp2TlZRbGhBRXZRY25RSS9X?=
 =?utf-8?Q?ZzStRXZW+kcpb+zX1RGl6Ul5Cw2RO/23wFfl2T5u40=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7AEA71D38DAEDF4AB24BF14EAB8246BA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 589dda5d-10c0-4ecf-b296-08d9eaa4e065
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 01:46:50.7276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fybjNIMZlkThY92awuzTjeYFgSdZBRjJFiQtcFup1hJ113Lm1bq5f0QhzBSvp8kR4wDfQekwdfXWjU/fCl/Qt/Fe96EzaJqspcLgE2olu/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1453
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gU3VuLCAyMDIyLTAyLTA2IGF0IDEzOjQyICswMDAwLCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+
ID4gSSBkb24ndCB0aGluayB0aGlzIGlzIGFzIGRpZmZpY3VsdCB0byBhdm9pZCBiZWNhdXNlIHVz
ZXJzcGFjZSBzc3ANCj4gPiBoYXMNCj4gPiBpdHMgb3duIHJlZ2lzdGVyIHRoYXQgc2hvdWxkIG5v
dCBiZSBhY2Nlc3NlZCBhdCB0aGF0IHBvaW50LCBidXQgSQ0KPiA+IGhhdmUNCj4gPiBub3QgZ2l2
ZW4gdGhpcyBhc3BlY3QgZW5vdWdoIGFuYWx5c2lzLiBUaGFua3MgZm9yIGJyaW5naW5nIGl0IHVw
Lg0KPiANCj4gU28gdGhlIHVzZXIgc3NwIGlzbid0IHNhdmVkIChvciByZXN0b3JlZCkgYnkgdGhl
IHRyYXAgZW50cnkvZXhpdC4NCj4gU28gaXQgbmVlZHMgdG8gYmUgc2F2ZWQgYnkgdGhlIGNvbnRl
eHQgc3dpdGNoIGNvZGU/DQo+IE11Y2ggbGlrZSB0aGUgdXNlciBzZWdtZW50IHJlZ2lzdGVycz8N
Cj4gU28geW91IGFyZSBsaWtlbHkgdG8gZ2V0IHRoZSBzYW1lIHByb2JsZW1zIGlmIHJlc3Rvcmlu
ZyBpdCBjYW4gZmF1bHQNCj4gaW4ga2VybmVsIChlZyBmb3IgYSBub24tY2Fub25pY2FsIGFkZHJl
c3MpLg0KDQpQTDNfU1NQIGlzIGxhemlseSBzYXZlZCBhbmQgcmVzdG9yZWQgYnkgdGhlIEZQVSBz
dXBlcnZpc29yIHhzYXZlIGNvZGUsDQp3aGljaCBoYXMgaXRzIGJ1ZmZlciBpbiBrZXJuZWwgbWVt
b3J5LiBGb3IgdGhlIG1vc3QgcGFydCBpdCBpcw0KdXNlcnNwYWNlIGluc3RydWN0aW9ucyB0aGF0
IHVzZSB0aGlzIHJlZ2lzdGVyIGFuZCB0aGV5IGNhbiBvbmx5IG1vZGlmeQ0KaXQgaW4gbGltaXRl
ZCB3YXlzLg0KDQpJdCBkb2VzIGxvb2sgbGlrZSBJUkVUIGNhbiBjYXVzZSBhICNDUCBpZiB0aGUg
UEwzIFNTUCBpcyBub3QgYWxpZ25lZCwNCmJ1dCBvbmx5IGFmdGVyIFJJUCBhbmQgQ1BMIGFyZSBz
ZXQgYmFjayB0byB1c2Vyc3BhY2UuIEknbSBub3QgY29uZmlkZW50DQplbm91Z2ggaW50ZXJwcmV0
aW5nIHRoZSBzcGVjcyB0byBhc3NlcnQgdGhlIHNwZWNpZmljIGJlaGF2aW9yIGFuZCB3aWxsDQpm
b2xsb3cgdXAgaW50ZXJuYWxseSB0byBjbGFyaWZ5Lg0KDQo=
