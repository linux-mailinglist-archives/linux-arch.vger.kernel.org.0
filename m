Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545926A0EF7
	for <lists+linux-arch@lfdr.de>; Thu, 23 Feb 2023 18:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjBWR7Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Feb 2023 12:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBWR7X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Feb 2023 12:59:23 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D3E36FC1;
        Thu, 23 Feb 2023 09:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677175162; x=1708711162;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=g4+ynOkSEK3P6nC1cIBaJt3jXwbd+LdI1vrUVa6yvN8=;
  b=ZBCYLciAc/Vjzwd487cyuESd0nZrhbISV467cJQNuE4KmATJ2Ess41A2
   hwDcQJi1wUNkhBoStfJXLd6LNyfrDrlh1+9yk7xZP243+e72dDYxQL4/5
   UXKsXnh8vzpRdlDozFQg3sQMCCpt/42Cd1vANlFrXnWtw1EiIKz8JetaG
   VMeSI7jyWGPe2ZJOTTWkZW0tTAzmy1TSNqHyuBI12lS7WXYdf88lXR/px
   A7WmX5ocRQdre7tW3NcNd0Kx+GhijL1pa2LBilWy/ROYP/uSmJGdaaKUF
   qrgqzcFQjSrMXYJW/ohVNmHcAuafePEKR9C4FevO1AiYsJ/69V/zFvEdG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="331957196"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="331957196"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 09:59:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="918101496"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="918101496"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 23 Feb 2023 09:59:20 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 23 Feb 2023 09:59:20 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 23 Feb 2023 09:59:20 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 23 Feb 2023 09:59:20 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 23 Feb 2023 09:59:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgqPrmLwgSTmQvUeiAnmkES+0aAiX7DmCzb6hJ1yz66hfDl+3778XUQIHFab/6fElgpqmkfArgJ2vCE+toBooSeZYnEG4KDGfWKmZo4xAcZNXnWrtOM1k5tuyAeJP2jMyIV/M6GsMpXIJrOexKFVxAkxmQck7U91M9uTgGGMX9A3z4sfxtXd0+82eVLq/fdHjnZgnHU+RUunpHI2jzHF5iWBAODDQ/3Z8lZrQay6PzyUqi5AjxSztE+ALFdXG6DiEpf0Dqki0AraWw37Dl0dQWlLsF+x+40mAVze3C2h1KVwO5qDTFtHzaB8DQBxoukba9F+/L71XsnVkAhToSucqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4+ynOkSEK3P6nC1cIBaJt3jXwbd+LdI1vrUVa6yvN8=;
 b=Ao2q4nDeeuFQ8ALWh81qKYlnuUvtX459Qoe3Yvi7+09WVMNG4WYz1Izm+BAfI4k1gbCpTqxVL9fn8itqnqdXYbBI04TFCcaa4DoL0MJj5Abexsucx4e2Gw76XRk+8QoMTZ7QO8O6IFUSmHDIXqTYpJKBBLi9lgx0q1Q8lH3CFQrD6bJ2P4LgKe083ckdBD4T6C78oFrwFuNeI55Yq1aRB0FTLkNpVkkv6nsRsDFYSq2Uqb7gy+Y7iHZq2606Q/lMI1h7VhogUxezOYY2wf9PnB7CJKD1UPUwiWc3ZWRv2HRmQZ/qbvLDJrEdM26KCyml4vON/byJT/R7U7899D22Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by IA1PR11MB6322.namprd11.prod.outlook.com (2603:10b6:208:38a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Thu, 23 Feb
 2023 17:59:17 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6134.021; Thu, 23 Feb 2023
 17:59:17 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "hca@linux.ibm.com" <hca@linux.ibm.com>
CC:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gor@linux.ibm.com" <gor@linux.ibm.com>,
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
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v6 12/41] s390/mm: Introduce pmd_mkwrite_kernel()
Thread-Topic: [PATCH v6 12/41] s390/mm: Introduce pmd_mkwrite_kernel()
Thread-Index: AQHZQ9490xkYOGVnNUGxP685zSCNI67cePaAgABgYoA=
Date:   Thu, 23 Feb 2023 17:59:16 +0000
Message-ID: <9125cb75914eba24d730e617b9b8a8869f772a33.camel@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
         <20230218211433.26859-13-rick.p.edgecombe@intel.com>
         <Y/dYmcHQXP63ONeL@osiris>
In-Reply-To: <Y/dYmcHQXP63ONeL@osiris>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|IA1PR11MB6322:EE_
x-ms-office365-filtering-correlation-id: 9dc30949-7a19-4341-e9f8-08db15c7addf
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /hHaA50AsvcPbU/u3jflGvzeoWlL71hX5acZy2eHxz4wnNxBLVtDwNuZqclAAz3rS5Tp2GkMb/wjiYOw3hDiwkjhDlRd6s5mvJNj4ynsiasRRyIT9ld7jHkHDdUGGUJAn9MYVQmvaebLSBsNbL0zXwHiPTqvIqN5vK3synp68H9AlTwYaiyDALxCkfkloz/TBghTB7c+SRhPFlF9IodQ99XmRfac2TjWhXw62+7k3kbC/2ukJ8hFeVHGqzcl0uwrlxQ5xtk8VsIoO5UB4QSt1ubv/kWZ3rUzZ7rtq9OkLp3b3Kq5wGIEvKS9GWf9tKxb9XloJ1ikeeCVsirRQU8nXa7dMgu1GOEaEYeSP6VJB5z115ETDiblgxvuySMlduMox1h+LFyI/VkOjl6H8O/QJy8ZxWEHFT+sks+EPJcUj0bC79kSniGti7Z5h3fZhWVTsO+wJhvF59yczqbTYfb3qTCAP6CnvSj5mzNFvi2W+lFktY3Wi762OcMYKLetXFDOHO37HasQbnsISlbWN7d4WJeQcAzVyJhHHDmPL9Xu8vEPj6mxLVLwHnI8VpZXa/lz4detGZOE6PgVlKhkNRFz8vLRr5bChcfSZPqDIzyBOy783PHmxjZQL79VyxG+iICBY5ev2zl/jfG6RJjmBHO5t96F9Q/rRnTVs5jRDBuO6Vgx8qijM7xai5a6IZ7xL+laB4FYYjpYNosFMoJIMPozXkYMqGyUMPLz+gQV1rs9hE4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(136003)(396003)(376002)(366004)(451199018)(558084003)(36756003)(54906003)(478600001)(8936002)(64756008)(5660300002)(6486002)(7416002)(91956017)(316002)(7406005)(66446008)(66476007)(2906002)(66556008)(76116006)(66946007)(41300700001)(4326008)(71200400001)(38100700002)(122000001)(6916009)(82960400001)(8676002)(38070700005)(2616005)(86362001)(6512007)(186003)(6506007)(26005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q21BbzZyazZaR3B2d3NTZFBXZFgwb3dDTFNYUG4rUHQxYW9UbDJCU0tCRXla?=
 =?utf-8?B?b2VrMFBoNVlVczAzUTNROENqN0ZUbUdZMTRWRXBKS28vVDJFUU9CQXhOclJJ?=
 =?utf-8?B?OW5WcjdsK0J0bTRjSGJHR3lJRHB4N1pJZndDOUlmVGN2NE9EbEhvckd2VHlK?=
 =?utf-8?B?VE9xWVFTcE16YklLS05aNjFpTVh5QUpyWlNNWGJMYlBGUTdpZzdIME5obFVw?=
 =?utf-8?B?ZS9oQWNNbGw5d1RMU3hCc1BmUTI5ankrMEJXc2V2RjR6NFozNnFGbnRaY0FU?=
 =?utf-8?B?ek9RN2s0Mnk0VUlmUEpnd0VMbVVkS3NzVDErQUJ5OFI3ZUxnMjhOcjhnNTVk?=
 =?utf-8?B?SXJ5QXV2UTQzS05oRVhxWSs4SnFaVGxHNDBJOHRKdGxsNHVJQjI2L29CZkZY?=
 =?utf-8?B?Sjc1NWlTVDQ0N29IU0V5d2VYZVdVaXlhaGtEMEo2UVpXY2FuMFFGTTFQaUEx?=
 =?utf-8?B?RnNEMmlpRVNPdUpZU0liYXpxVmNlUGhTYS9NN0RTSUp5V0J4bm1UeENmK0JC?=
 =?utf-8?B?SHpsM1M1UUEyMHdZNWJTa0FiVzJYRzRhTzgvV3BDalJQM2NKTzYvblRKVnpP?=
 =?utf-8?B?d1k5enJOcUx2UzBJU3N1RDJ0alJvQnhyckFYekcvOWxya0N5bmNBYWtHSG02?=
 =?utf-8?B?eHBkR3hkS3RvR0YxS1YwcytIU3pqWlpLbDVmRGRycTBaNG5Kc2s4aGFYbnNR?=
 =?utf-8?B?dFhyNExLNC80cFNiNkdlQnlMcVBTSmRlNnN4U0Jkb2FPNmFyVGdRR1l5TzY1?=
 =?utf-8?B?THYyaitqYWFCRmUvWi9VOWIvT0RxcVJhdmhWcUhXQ2sxRVE3RnJ5RzFjdk9q?=
 =?utf-8?B?L0gyZmhJd01BdWtCUDRyRzJoMXZmUGNaVll1VXd4SUdmMnNlL0xPVGRYM3dr?=
 =?utf-8?B?T1VOZEZvNEJhVitqRFB2cnR0bUV4bUJMK1RsSm85OFJmbHN2YU1KTjFEWjdq?=
 =?utf-8?B?V1hnQzJ6NExDSmhPS1pKSlBLVHlQNWMwMkwxdHE4bmc0eVBqSG9ybTRNZENS?=
 =?utf-8?B?cjJDRzZqa0E5d0k2bkhQajdhQUszbTEzVTlQMkxRMm5EY3Nnc003RU85TVkx?=
 =?utf-8?B?bzE3V2VEQVNySnZiTE9sNnRGVWFJODZLaHIzSXRTWjEwUThXU2lOT1U4L3dT?=
 =?utf-8?B?ZjkvWG0vNUhUR2RVYTQweS9vZmI3ZlBJcEhjK2hQL0dYRHVwclY1UVY0elR5?=
 =?utf-8?B?cU5PSHBxV0xwb2xWNEttSE8wU1JJYncwNDVvTnpMODUrblV6Q21TNHplV1hB?=
 =?utf-8?B?TXhxY2JDVDIyMkRxMVpDaUhyM1A1VTFmVmdVNXladUF5MWNveUx5MEJlUFds?=
 =?utf-8?B?T1JVdnNKcjVyeWZyWmlGbHZIOWhLTHB3WFRDSHJzV3EvRUF4cUNzQTIxd0Ey?=
 =?utf-8?B?dFdMbWZFTUtXVVhOOStaY3hUVkJ4aDdFNVdGVEIwWDJiUklndU5Mck50YlJG?=
 =?utf-8?B?YVgyVVNwVDhSQml0VXJRK2VyeGxlRTR3MFRmYmdkNlFuMjNIMW1wMURwV1Jr?=
 =?utf-8?B?T1RMdWN5cEVXNXJaWkZXUUJKcW95SWJCcXJ3aHNmK0ZJcitZM2VCTlg4RzRu?=
 =?utf-8?B?Yk54QzB2Yk45bm0zM1l2cDBHc0RTa2NRcGUrWE5ielAzSkRyc2JPb3l3TjlO?=
 =?utf-8?B?K0g5bnJEdG85TDdkRmxFM1pwbUZyYXFVU3hCUjFBVjhPalBNQVVYRlJ6cXJ5?=
 =?utf-8?B?RkkwU0pMcjcyamhBZE1pVE5zczZMQnN1OW5hdzlJR0YzMitDSVI4YXBFbzVT?=
 =?utf-8?B?dXMwTW5VY0lhWGJ4ZFVKbnRXT2JNN2k0S0FWWk1ybVovcnM3a0Y1RSt3eFNo?=
 =?utf-8?B?RFhxM2lZa3c1UUtTckRWbGd2QnRpRnJuTUp1ZDgxN0NFS3AxaXh2aXV6bGRQ?=
 =?utf-8?B?ZXp6Tm9yREw5NkdqblAwTGtNNXRuSDc5SVVYUGFiNGZnNlNwczJTb0dEa1Fq?=
 =?utf-8?B?WUZjRGp2TGpoQk1SQ2JDV3dXZVVubk95aU9iS1FxN2Z5OGl6bmg5SnMvUHpZ?=
 =?utf-8?B?ZEJYR3JaRVlnZXBRc2oxU2hiRFJVZ3NsR3dIZzVvYTlFUURIVjlaRWhFbVAx?=
 =?utf-8?B?SWp2L29qTWtlZmhtT1dKRVcyb1JmSmU1RDFuTExrdVFnNzVsRFAxUHh5UjVi?=
 =?utf-8?B?WFR4d2pwbVRCT1gzMTUycDVJUUFFbjg3WG44dUgwNDRjUytuL2QzcTFDb1VL?=
 =?utf-8?Q?bWaxgVokjN8v8tnbOa+ul2g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D935DD0E46569449B3792C8EF67DED88@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc30949-7a19-4341-e9f8-08db15c7addf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 17:59:16.2240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lu/vg35S3pYfyNlcP5tmgzLeIPYBPiSKoc7qvDGsVSTButPCs6mVpGcwxn9Zac6im/CX3FQDpV/86I+Y67OGe2q5TJm7j0xwIjnu2RGRH7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6322
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVGh1LCAyMDIzLTAyLTIzIGF0IDEzOjE0ICswMTAwLCBIZWlrbyBDYXJzdGVucyB3cm90ZToN
Cj4gQWNrZWQtYnk6IEhlaWtvIENhcnN0ZW5zIDxoY2FAbGludXguaWJtLmNvbT4NCg0KVGhhbmtz
IQ0K
