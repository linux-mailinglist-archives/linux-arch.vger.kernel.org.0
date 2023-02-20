Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0EA69D661
	for <lists+linux-arch@lfdr.de>; Mon, 20 Feb 2023 23:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjBTWif (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Feb 2023 17:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbjBTWie (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Feb 2023 17:38:34 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5E7A261;
        Mon, 20 Feb 2023 14:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676932713; x=1708468713;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qXYRUEEOCa//SXYwr7sPV+oOrraEGhKW+3tz2bbXLAc=;
  b=PimtrfPb4dNNJ0xJzEOu4NAgt7cR5v69KQx4zqFdJYMTsLHxbKfk1as5
   peTnbOWhb5aFal6T4znKckXVSecejoIrxjNFsCjfvyk/w5nG1UhZ3WJ+m
   KL2K+ClxNxYLt5lbbAgRehJp595uHCKXt8Kf2h0Xqo7fd3TOQbc6wirnk
   4bUOawNaiIrUx8C+RVSdybjNcdyl3dA5760J1YeIghxBtMXawZiS175tB
   zlDsdolqiIoy/iG8Owsf7HRr6jX8v79nFjpp48alxgpBp5v+e1ALvW1n1
   p/8Hhw6kmNAqvpOuTXm4LxiYkXoBJ7bpZk/rNOOct1Z9Y2rMV9PyMZ/eu
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="332507945"
X-IronPort-AV: E=Sophos;i="5.97,313,1669104000"; 
   d="scan'208";a="332507945"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 14:38:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="916970214"
X-IronPort-AV: E=Sophos;i="5.97,313,1669104000"; 
   d="scan'208";a="916970214"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 20 Feb 2023 14:38:31 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 20 Feb 2023 14:38:30 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 20 Feb 2023 14:38:30 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 20 Feb 2023 14:38:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGd2dGN5WOFBdDNVqK2BxKCZUDsJQTEN4jNsKqTfms03uj/9ITolb7Wl/pL5L0AydzMRyKTixiv1QUORQMaQpJHjWM3duDJypN3w02y2KvThxbHMKZ0Z623Zs736jFKPgflAjNZXwUYB2zDIt+RsK6L9hhSedr/2nuQShj3eKV4NmZijRpFFNdGGV0SBOiHIYjCJGMvHtmFdueMgUkkirEiYaKDPecNhh4P8U3q/X1fPYLiQ3MZdPmWdRijiZdCOM28nIlsLD4Ckl/b2/Tpg/kDoOiBbuB/kyQJftvNbfmw1bxVSg76bYLXEa0T2Nz73FnS5AmNbl474E4CSoY+iVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXYRUEEOCa//SXYwr7sPV+oOrraEGhKW+3tz2bbXLAc=;
 b=TC5wfEUnFH/zJsF4yDciXU/CD9QfcRpWRDeO4Yw27pKzwDLkNEokMM5m68K/YIOKtHIM96RIxAQP2GUlH9/p9IPzbUKr6Pl3TfXghrnrVFnPWL7YffPjvnTL1TKDCxmFEtAkoccde+ffC4ajWE/sE/vAuZhVBd6eGhyjtq+ttPdciJthyxaKherk4ORwmSLOkgxfSJp4X9NST3omAFyTaKawuIhmhC7SC5j91yCc2Sl/g3+bhzIMHgpLO1pX8Jxr62rzR3dAznc/boSbNjf7pEs+VPkOOCLu/z+SjxEmHPJwwn/6aC7odby3SLcQbzszkxx5uQmhaXNhZ0TFsq2zrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CH0PR11MB8235.namprd11.prod.outlook.com (2603:10b6:610:187::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 20 Feb
 2023 22:38:28 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6111.019; Mon, 20 Feb 2023
 22:38:28 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "keescook@chromium.org" <keescook@chromium.org>
CC:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
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
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v6 25/41] x86/mm: Introduce MAP_ABOVE4G
Thread-Topic: [PATCH v6 25/41] x86/mm: Introduce MAP_ABOVE4G
Thread-Index: AQHZQ95BPbIpQ7A+r0Kopm57jq8KXK7WvggAgAGyUwA=
Date:   Mon, 20 Feb 2023 22:38:27 +0000
Message-ID: <8a3bea3b66cee020326b00a5769e941244a77942.camel@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
         <20230218211433.26859-26-rick.p.edgecombe@intel.com>
         <63f28a0d.170a0220.21bf7.b03c@mx.google.com>
In-Reply-To: <63f28a0d.170a0220.21bf7.b03c@mx.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|CH0PR11MB8235:EE_
x-ms-office365-filtering-correlation-id: b3c38e2c-cfb5-4642-b108-08db13932f32
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FIGOhNsBrolqk1hiUs5aUho8zF6fxokEOIJRb6GdD5a2+iVBRhOholz6mKMrfEp/adJYI3G+Uss5jsre1c7FxwARusyc97yA8k0f4eWZ+/VtnSyqB0wmHgmMtKWVkJNgGke5opNmx/hUARIOKgO/fh0A2RQfhDnEEQagfD2UFgKZaO5iKhtAhSqeGnlMI6E9uFRDBcIvF6bxg9pY+PiagPQd/rt3MpEOBp+qOsOug+jU6inVQNhHShTTxEEJf4BNPsxeI8XU7OLLGGG/p5blgjfHvgqVryoX+RqlWLH8dULH+HscBAdxXlzcZ3kV13SnmmkbV6c09R/8aArbrP3qRBFSoRTZLwVURR4J0fUYANy5thfqPl14GNfPB2D6cPSx7RpHqJMdVC4VHKlhEbkOy+O0wSQP8sdJmJIk9dlV+QQOQP9SiT3ovoc/gSukMh8yvAvXJQiQVrdauWeu3oq4bzUljxwbcUSrWVdbnMt3LUPwsiliY05Ab+hhKtt/JkzfFnuZ6lcbPGorVIW/J+4Z3G267vpogQ5vUaMvLR1vP+LFTnrNWcpjN8Z9jTF4oVUndLpg/sQRIapDUCvu5RJKdihFHASUBeWgREtqYsfGA6KwhAO7R0a1tOPxLMV7F0iHQg5JEcvZYgSgC5QmGVlNq1D259pIjg6wPNrPvhgsr+ssO7w/sKIHBGu9bjeVjT6FEkvZqvV3HuAb+2Pw2TbkSpdqglO3hj5yri/8+xnsiWc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199018)(83380400001)(66946007)(76116006)(66556008)(66446008)(8676002)(64756008)(66476007)(71200400001)(54906003)(478600001)(316002)(6512007)(6506007)(186003)(26005)(38070700005)(8936002)(7406005)(7416002)(2616005)(6486002)(36756003)(4326008)(6916009)(41300700001)(5660300002)(38100700002)(86362001)(122000001)(82960400001)(2906002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NENuVFBaUFN6b1lsT1QvWTNjcHRnNVE5WjdLQUZZb2Y3ZVgxT0ZVVkNHMVlJ?=
 =?utf-8?B?SFh6SmlPQllwc2tjak5LeFNNakVmajNDenhCUytzY1ZKMFlmUjROVmhTS1VE?=
 =?utf-8?B?Ri91RHJmcUZqQUZEUUc3MlhnNlVvd0RzdTVsODJlT0xuejF1U0lFRW1GZWcx?=
 =?utf-8?B?MlIzV3VJZzFWcVFndFpqOGRGR09zazdicUtQTHBuLzNaMENBR0hxMUNRK1FF?=
 =?utf-8?B?VnEybHF5V3lUWDNvbk5RREVLNnlFSkpMWWI3cFAxQ2Rrc2ExaTVTdmM4Qzlt?=
 =?utf-8?B?Q3RCR05ONUlTOHJGUXdhRWg3ZXZnRlBqUzBwdFRXdjVMS1FOYW1VS1BsaDAw?=
 =?utf-8?B?dTBkdGM0aHk5eU5CVjJERXVaN3JRRGdZdlcrY09hcXB2L1pDdDlyaTYzQ1FS?=
 =?utf-8?B?RndzNk9aU2lIdE1FcHpDWENOdFFwRXYvVjdSUDdyUEM0Zmo3YUZqMTM1T29S?=
 =?utf-8?B?aVNxUnBMMjUvbEN6bXNSdkMyWnFZQVJyOExvOENJRkc1eVU5WXZWQ0creXQ4?=
 =?utf-8?B?bzZ2RVZrOEx4YWFxM3FvN0owclNlNzFCRFVJU3JTQm43Q3MvY0o3NzFtbjFS?=
 =?utf-8?B?bW5qWlpua2t1NWpRMHpVWDdKMW9ndlR6OWh1NU1DNjcvZlgyeXVIOWlYeFZW?=
 =?utf-8?B?Z1cveG1lbGZjS3RYYXI0RkUzWDBUVHp4OElOVnFTbWZzZi9kMzJDU3E2UEVs?=
 =?utf-8?B?eTRnWjJzSlJlWTl6ZDhQdUprYmQxZ3prY04wQ0F1TzBvaEh6TTNsTWFNQytv?=
 =?utf-8?B?UEc0S3RFV3RQb3ExMGtKVGNmcTlXbk9TeXkwOE05RmdOMnJkSFdhU3lwdGFC?=
 =?utf-8?B?aFFVWlUyUDlpc21UTUxuSHdkaTlaQlpXQmFyZWlnRlJLNW9BRFBNTy9SVVM5?=
 =?utf-8?B?aUlqSlFvVEo1cm9BdVkrTnlpOW9TMEtRQnZLd05LWE1uakE3VEtaN2Yxd2Qr?=
 =?utf-8?B?SEI4RmROOUVQWThSTVJ3RG8xcHJ4MU1IYkwwRFg1Qk1jNS9tdU5BNUlSc3hO?=
 =?utf-8?B?T0RXaTk5N0JyVmd0N0xQRUQ3c2M3b2hQY3c0MFUwcTBuMDBDUEZxdlhSMnd1?=
 =?utf-8?B?U1ZuUkpXdmdzb1JYV0tRUWM5dStKR1VxU1o0VHdLMGFQWmJSei90YWU2M3Ni?=
 =?utf-8?B?bXNlMmNwVkdZaDJ5R1RnUzMyc1dUODJEN3RqRnN2TUFKbjhCUEV3WFhjNzRx?=
 =?utf-8?B?SFdRSmF3VWc1NTdidTBhZWtwZnJ6TGtodUxOc3lDb2RCbDcyRnVWdnZkc1Ju?=
 =?utf-8?B?TlJhWlBFZnd4RXVLbUtBNFlLVkZDVWFmdngvUm5LQll1OGpXL3VFMm8wWGxj?=
 =?utf-8?B?bzhlR1NEMGUvQVArU00yNUdrelFSWWwrN2cxMjJxZ2xIZUVKZ2NWSEFKM3hW?=
 =?utf-8?B?NDFCM09pVHNtZzdDR0J0UmVRZS9icW5OQ0pNWFE1MkJra2N1d2pOVjV0NVdv?=
 =?utf-8?B?c3l6L3FDKy8zbTNZNVI0SjRhbUtIRWtJM3RIQS9zd3EzM09OK1hvVGlzQ2NT?=
 =?utf-8?B?cVU2MmkwbGx3NE5Ib3NnMWQ0cE9MTjJvUWRySk5xTmRhNnQ3bXRyK3FFSHRy?=
 =?utf-8?B?dURVTmVTZXAxUWVoVW1YbStndzJENXFyUFNhdHBFdnVOb243bVhQc0tvT1Rl?=
 =?utf-8?B?SFpLNUlGMmRFZ0dGOWhiRThzakt3SktWOU5CMGJQVURac3dYcXk3OTAwYUg1?=
 =?utf-8?B?YlNJN2x2THl5NVhFeTV2dWFBY2NYQnh3SU5SMXM0RGd0Z1BCWXBMMUFtclZk?=
 =?utf-8?B?YzdzR1BheFV5NExzRXZPcjRJallLVEloUDdSMk5LajdDNDVuVDN5NGNKYTdk?=
 =?utf-8?B?R1Z5WVdTSERUTmVUdnpacjZTWFcwSWdNRVFtR0syUnJLV0VYeGhqdU4wYnow?=
 =?utf-8?B?dUFoR2JxRlliMWJUM0U5K21xWEdxZksrVGkvNGx2VCttRG9ENy9KTEFuOEZ1?=
 =?utf-8?B?czVjb2p2NzZTY2Q1VnlDMGtMZmQvQjNSOU9wUjd4NDJOeC9FcGo5NXB4NERN?=
 =?utf-8?B?YUtNbVEvTTg4bktmYnFsaGlkM25iNzF1alZCQlNFSXNEOXA0VnFKOWl3TnFp?=
 =?utf-8?B?Zlk1Y0Q4MU0yNkpCVFBieUsxdHRjMFFFdmtnVGQ3S1g5WXdUeDVLZmxFdngy?=
 =?utf-8?B?SnBmb1VmVndONHJlYWZQbTlocUVLT2xVb3RSTHhYcWxIdVU2ZCt6a3FFK1k0?=
 =?utf-8?Q?9ytfydJQufThYdh2ZUc/npw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE0475DDEDF6444BB4D10349A7D66F4F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c38e2c-cfb5-4642-b108-08db13932f32
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 22:38:27.5559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m9RV8nnl2oDUzQoyl2OhN4Jxw0B23tqUVJrAjAqlexZ7fvz5CrDhuPRzcI3sjrutFndyLp6eA6qfQG7zxdmn1XDtD/Cr4653AWu05U74UCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8235
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gU3VuLCAyMDIzLTAyLTE5IGF0IDEyOjQzIC0wODAwLCBLZWVzIENvb2sgd3JvdGU6DQo+IE9u
IFNhdCwgRmViIDE4LCAyMDIzIGF0IDAxOjE0OjE3UE0gLTA4MDAsIFJpY2sgRWRnZWNvbWJlIHdy
b3RlOg0KPiA+IFRoZSB4ODYgQ29udHJvbC1mbG93IEVuZm9yY2VtZW50IFRlY2hub2xvZ3kgKENF
VCkgZmVhdHVyZSBpbmNsdWRlcw0KPiA+IGEgbmV3DQo+ID4gdHlwZSBvZiBtZW1vcnkgY2FsbGVk
IHNoYWRvdyBzdGFjay4gVGhpcyBzaGFkb3cgc3RhY2sgbWVtb3J5IGhhcw0KPiA+IHNvbWUNCj4g
PiB1bnVzdWFsIHByb3BlcnRpZXMsIHdoaWNoIHJlcXVpcmUgc29tZSBjb3JlIG1tIGNoYW5nZXMg
dG8gZnVuY3Rpb24NCj4gPiBwcm9wZXJseS4NCj4gPiANCj4gPiBPbmUgb2YgdGhlIHByb3BlcnRp
ZXMgaXMgdGhhdCB0aGUgc2hhZG93IHN0YWNrIHBvaW50ZXIgKFNTUCksIHdoaWNoDQo+ID4gaXMg
YQ0KPiA+IENQVSByZWdpc3RlciB0aGF0IHBvaW50cyB0byB0aGUgc2hhZG93IHN0YWNrIGxpa2Ug
dGhlIHN0YWNrIHBvaW50ZXINCj4gPiBwb2ludHMNCj4gPiB0byB0aGUgc3RhY2ssIGNhbid0IGJl
IHBvaW50aW5nIG91dHNpZGUgb2YgdGhlIDMyIGJpdCBhZGRyZXNzIHNwYWNlDQo+ID4gd2hlbg0K
PiA+IHRoZSBDUFUgaXMgZXhlY3V0aW5nIGluIDMyIGJpdCBtb2RlLiBJdCBpcyBkZXNpcmFibGUg
dG8gcHJldmVudA0KPiA+IGV4ZWN1dGluZw0KPiA+IGluIDMyIGJpdCBtb2RlIHdoZW4gc2hhZG93
IHN0YWNrIGlzIGVuYWJsZWQgYmVjYXVzZSB0aGUga2VybmVsDQo+ID4gY2FuJ3QgZWFzaWx5DQo+
ID4gc3VwcG9ydCAzMiBiaXQgc2lnbmFscy4NCj4gPiANCj4gPiBPbiB4ODYgaXQgaXMgcG9zc2li
bGUgdG8gdHJhbnNpdGlvbiB0byAzMiBiaXQgbW9kZSB3aXRob3V0IGFueQ0KPiA+IHNwZWNpYWwN
Cj4gPiBpbnRlcmFjdGlvbiB3aXRoIHRoZSBrZXJuZWwsIGJ5IGRvaW5nIGEgImZhciBjYWxsIiB0
byBhIDMyIGJpdA0KPiA+IHNlZ21lbnQuDQo+ID4gU28gdGhlIHNoYWRvdyBzdGFjayBpbXBsZW1l
bnRhdGlvbiBjYW4gdXNlIHRoaXMgYWRkcmVzcyBzcGFjZQ0KPiA+IGJlaGF2aW9yDQo+ID4gYXMg
YSBmZWF0dXJlLCBieSBlbmZvcmNpbmcgdGhhdCBzaGFkb3cgc3RhY2sgbWVtb3J5IGlzIGFsd2F5
cw0KPiA+IGNyYXRlZA0KPiA+IG91dHNpZGUgb2YgdGhlIDMyIGJpdCBhZGRyZXNzIHNwYWNlLiBU
aGlzIHdheSB1c2Vyc3BhY2Ugd2lsbA0KPiA+IHRyaWdnZXIgYQ0KPiA+IGdlbmVyYWwgcHJvdGVj
dGlvbiBmYXVsdCB3aGljaCB3aWxsIGluIHR1cm4gdHJpZ2dlciBhIHNlZ2ZhdWx0IGlmDQo+ID4g
aXQNCj4gPiB0cmllcyB0byB0cmFuc2l0aW9uIHRvIDMyIGJpdCBtb2RlIHdpdGggc2hhZG93IHN0
YWNrIGVuYWJsZWQuDQo+ID4gDQo+ID4gVGhpcyBwcm92aWRlcyBhIGNsZWFuIGVycm9yIGdlbmVy
YXRpbmcgYm9yZGVyIGZvciB0aGUgdXNlciBpZiB0aGV5DQo+ID4gdHJ5DQo+ID4gYXR0ZW1wdCB0
byBkbyAzMiBiaXQgbW9kZSBzaGFkb3cgc3RhY2ssIHJhdGhlciB0aGFuIGxlYXZlIHRoZQ0KPiA+
IGtlcm5lbCBpbiBhDQo+ID4gaGFsZiB3b3JraW5nIHN0YXRlIGZvciB1c2Vyc3BhY2UgdG8gYmUg
c3VycHJpc2VkIGJ5Lg0KPiA+IA0KPiA+IFNvIHRvIGFsbG93IGZ1dHVyZSBzaGFkb3cgc3RhY2sg
ZW5hYmxpbmcgcGF0Y2hlcyB0byBtYXAgc2hhZG93DQo+ID4gc3RhY2tzDQo+ID4gb3V0IG9mIHRo
ZSAzMiBiaXQgYWRkcmVzcyBzcGFjZSwgaW50cm9kdWNlIE1BUF9BQk9WRTRHLiBUaGUNCj4gPiBi
ZWhhdmlvcg0KPiA+IGlzIHByZXR0eSBtdWNoIGxpa2UgTUFQXzMyQklULCBleGNlcHQgdGhhdCBp
dCBoYXMgdGhlIG9wcG9zaXRlDQo+ID4gYWRkcmVzcw0KPiA+IHJhbmdlLiBUaGUgYXJlIGEgZmV3
IGRpZmZlcmVuY2VzIHRob3VnaC4NCj4gPiANCj4gPiBJZiBib3RoIE1BUF8zMkJJVCBhbmQgTUFQ
X0FCT1ZFNEcgYXJlIHByb3ZpZGVkLCB0aGUga2VybmVsIHdpbGwgdXNlDQo+ID4gdGhlDQo+ID4g
TUFQX0FCT1ZFNEcgYmVoYXZpb3IuIExpa2UgTUFQXzMyQklULCBNQVBfQUJPVkU0RyBpcyBpZ25v
cmVkIGluIGENCj4gPiAzMiBiaXQNCj4gPiBzeXNjYWxsLg0KPiANCj4gU2hvdWxkIHRoZSBpbnRl
cmZhY2UgcmVmdXNlIHRvIGFjY2VwdCBib3RoIHNldCBpbnN0ZWFkPw0KDQpJIGd1ZXNzIHRoYXQg
bWlnaHQgYmUgbGVzcyBzdXJwcmlzaW5nLiBCdXQgSSB0aGluayB0byBkbyB0aGlzIHdvdWxkDQpl
aXRoZXIgcmVxdWlyZSBhZGRpbmcgbG9naWMgdG8gY29yZSBtbSBvciBhIG5ldyBhcmNoIGJyZWFr
b3V0LiBJDQphY3R1YWxseSBraW5kIG9mIHdpc2ggdGhlcmUgd2FzIGFuIGVhc3kgd2F5IHRvIGtl
ZXAgdGhpcyBmbGFnIGZyb20NCmJlaW5nIHVzZWQgZnJvbSB1c2Vyc3BhY2UgYW5kIGp1c3QgYmUg
YSBrZXJuZWwgb25seSB0aGluZy4gSXQgaXMgb25seQ0KdXNlZCBpbnRlcm5hbGx5IGluIHRoaXMg
c2VyaWVzIGFuZCB0aGVyZSBpc24ndCBhbnkga25vdyB1c2UgZm9yDQp1c2Vyc3BhY2UuDQoNCj4g
DQo+IFJldmlld2VkLWJ5OiBLZWVzIENvb2sgPGtlZXNjb29rQGNocm9taXVtLm9yZz4NCg==
