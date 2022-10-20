Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE50606A7E
	for <lists+linux-arch@lfdr.de>; Thu, 20 Oct 2022 23:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiJTVwF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Oct 2022 17:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiJTVwE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Oct 2022 17:52:04 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70E41A7A1A;
        Thu, 20 Oct 2022 14:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666302723; x=1697838723;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Jlzp7yT9m5pst0yVMNv830N7wlmV/berVd97PM4GZVQ=;
  b=avqZPz0QcY9oH1492i3myxxxluMLzeF8eCfP1aC6nSQ1sPWH0mgQ4PLC
   IuJK7TRrrLjjsQnL1b9FR2vAonvO95NJOYIH9xA+pZjXQer54K6LCqSmP
   1gchUmAWsFybJaqb5LIW43hp0iLHKSr8fRHSVc3tDldsMYz5dJuiY2abu
   QLWSxwnp+rFFcDUBMGGtuV3zXJJJiqDWUXVYmtejaMkhAAqNP4DWCNFzE
   Ts/jLULKzPRCn8QCFTZU9VMk+GX9BqdBHbVLbfMX8w6cNBhxcN9K8iqX6
   w2BRUaOOY4K8cwAxAPqpn7OmHnWQF/ky+bwgdpgPaHMcvk5DgtZRtWTqi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="305582629"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="305582629"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 14:51:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="632516150"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="632516150"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 20 Oct 2022 14:51:59 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 14:51:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 14:51:58 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 20 Oct 2022 14:51:58 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 20 Oct 2022 14:51:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvL8nLHZb3fXEfZdzC0zqJTQuU6m0xll9Hljt/wzjx0Ev6vatH2pk2vVCzzqyotRCmFq7IpoR8TQYiQJzN99uChaZy4vX3EjxW7hrQL1Xj9EmXrH3upsV3ltXjFbqOle2YId/LC/jegvvAqMC9YrHB7wHm6B3B+uD3h3fQMEIiIzK1vYDIYAf/rhHPBqVk8lkfF8KLsm+WlKLICUEJN/USdpuzxUahDcjYVq/m893qGvMl3OgAoLnMC9cDzjJu4bQFxCfifxhX2vFySRDjdCsXhZQddxph0HTnTnBJ3MeAh9rq79CZuEm0kCn9WimcpgJOVLMmbXLLV7Nnd43hKBfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jlzp7yT9m5pst0yVMNv830N7wlmV/berVd97PM4GZVQ=;
 b=LkMboP2+xPWzQvNFVrVd7vRgjn9xH57M87LOwy9tTIdwPYPTjJqfSyjWfRXTBtlz7r780CIm77RtPdwlPF41KusUW3QiTi7EIbv7BNk0A8UOMwgD8VPpJ/l5jj+5sooLkZexRKfwFrDSru7wXIGKlyPkHuIugqZl3KSmxfCaom8iv+iiyoH9RynWVPj0QTa6BgPQLOU0yrULiTK7pQXI2+R2pKLFPgPFDgBQlBYcixrdRK8E+61xP+Shm8MH1vNCFpUU8f3QYJcspGF9HZnuzUua1UeqiHueJtQqFwXPWCBAnMY4PE0aObmoD0LpogqGM1XuA0bkG9Z4KJ7wTHpsWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH0PR11MB5928.namprd11.prod.outlook.com (2603:10b6:510:144::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Thu, 20 Oct
 2022 21:51:56 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 21:51:55 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
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
        "bp@alien8.de" <bp@alien8.de>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v2 26/39] x86/cet/shstk: Introduce routines modifying
 shstk
Thread-Topic: [PATCH v2 26/39] x86/cet/shstk: Introduce routines modifying
 shstk
Thread-Index: AQHY1FMi0mGJj2nvSk6XePU1fP3/w63/H8cAgAFQYoCAAAMLgIAXgHsA
Date:   Thu, 20 Oct 2022 21:51:55 +0000
Message-ID: <1d9c6497405eb66f687f7f640b33f5c61e62b83a.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-27-rick.p.edgecombe@intel.com>
         <052e3e8c-0bb0-fd2d-9f67-08801a72261c@citrix.com>
         <fe5d52cebe4aaca0234856f789b3153f202eb9cf.camel@intel.com>
         <8031fb5f-ca53-d89e-1e29-262514552708@citrix.com>
In-Reply-To: <8031fb5f-ca53-d89e-1e29-262514552708@citrix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH0PR11MB5928:EE_
x-ms-office365-filtering-correlation-id: 13c68b75-87fb-4d72-54e7-08dab2e54e48
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WLB9g5BDHsuD3ftwKOx8twMDnNf1R30HoZ0pihuD+n0pQRjJqBsBA52zjVgyR7bX0CZYN5Eat3tCS1pw20dtMxrtZzZBDlc7gtC/8xgmodfTuBQtiMz83AAi58/H0EJV44K7oWndqcsUMtnMyhdgns6p0iB9fXbYOBhK7byhQgepMccYionAcIEG1ISe4WrjgqwW1m9kpTI1Gb4PYsegpBBVoIkj6+V5yYFLbyW3/FeNVN4avuY/nquC8EYdHAXLmfRTbW8BtrWGDn5ZIJxOXwPqkttqqo+G6QOyJjM/cob8fberP+CCT6iLah/6rDjBWjeL71yeqaTOVJ5Fl+MpFlBj9Xse44ZTAFPtiX5i6Fp4S2UHJYTYP8I6Z5HwK8teUAqcfR+qdAPCl+tnllgX6naurRN6iXrxjbynG8Y+cQsX9hg49U+WkpbNLKjBNy3Ze55EQn/6ZQqdq5EAd0v6FihRYndpc/IX5i0KCHcCtXIar1TqJyN7ieCUGxKtswCBsumiV5ChyF0dTq/CyCCtovsoRRuuRHFcmbJv9+Eo7F5hFAPCcKPE0/CDc8Pwe+wtfKAajx0Q04XRvmbH+Ktkm2QEmNrMD9scetxREpudhkPrNTonuLi70gMMa3sXsEjRdzM3s77O66r4T2bxZHRXkXmQouEF2O7EQA6uVxnWaCUk+p1THtQb9UElklTadozsWjfb/BKznOIVA09CANF5XARPwUP3KeotYP6OqT84alXIszIAA/2bkWz6vUjRp5hGFCcOR0608lb1bjOAYAz0pgJ4JpXEIYDu0QgPJ6MFcfL+k9NY+HaB7eSqI/bwK7odZedaaO+DLtsKX/mfw3h6Wg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199015)(53546011)(6506007)(82960400001)(4326008)(5660300002)(8676002)(91956017)(76116006)(8936002)(66946007)(66476007)(66556008)(64756008)(66446008)(38100700002)(86362001)(2906002)(122000001)(110136005)(6512007)(2616005)(316002)(36756003)(26005)(186003)(478600001)(921005)(7406005)(7416002)(71200400001)(41300700001)(6486002)(38070700005)(99106002)(17423001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVR5UEpTeDlvUDZsRVNnZTZmSFFrQWJMVThwYkJSV0RpNFpLNlNLQ1RNK00r?=
 =?utf-8?B?d1F4MlZWVU9aRnRIL0UzTXhhdVM4SURKWDB6L0tZNWYvK1VXMEc4cTNYeWJo?=
 =?utf-8?B?ZGxOdW00VlQxWThUMERyMG9TeldYL21zQ3UraGFxNEJ0NVZNMGMzQmlqazVO?=
 =?utf-8?B?OXJPcDNQUU54VUgrUVhkajhSNEZ0ejZwa3huSHhmNGJJTkdpYjhpc0pXYmMy?=
 =?utf-8?B?VmFVVkdidWtPVnN4SEZ0aGpQSzVtVDBxYkZzckp1eDdLSkViVHc0czRKS212?=
 =?utf-8?B?Z1ptY1lQb29FdEltclJMMytweE02cUhidU1OaitJOHhZdlRheFZaMkZSMnhx?=
 =?utf-8?B?cm5LMUpFS3pZUXA1RXV6VC9iZVBmbElIUkJVKzhFWGxPRU1qQXdjY1dPcFRB?=
 =?utf-8?B?OVVaWDhzS0tsR1VwcjVlSVFwQjZQWTVpYlE4ZFlEa1lVQk0wU0dtVXQ0ak9s?=
 =?utf-8?B?NmpCUkQ1bkxPY2J4ckE5UWNsOWNjZWVta2JRRFp2cnZFa0lTZUJoOGNpQTNz?=
 =?utf-8?B?dkpPTlNpTXJEOTd6TDZBdXhpSERQcWJZWXBPWlJiMzBZT0NrM2NZcXc4TGtS?=
 =?utf-8?B?MXp6c0hTTlNGbm9CeWN5b3AvTEhYaURPRGNiUUwrSlhjcENFMTQvQ0xYKzVj?=
 =?utf-8?B?azFOUXlTY09rZHlSY3lPUFFrSCt0c1hFTVA3SEpFeEI3VXNYekhMWkVoNkJv?=
 =?utf-8?B?QzgwNHQ4ZllYQ2tpMDJpMm5XdnpOeDJhdnRwcUJuN1doRGhVVm43RksxWmRo?=
 =?utf-8?B?TVR6Tnl5NlJrSlcvblhqMzJ4NlZYUERrOUd5RGN0Y0xheDVqd3oyMG12SnYr?=
 =?utf-8?B?VHB1WnFpeEkyNU9hZjc3TTM0L2dRbUYxMHJoOHRhSDhiVDZ4THYrRzMxY3Nj?=
 =?utf-8?B?d09XMXhraXZjVHlOMDhWeVJGVzVjWnRLSW5mU0N3SUNLTU1zQmdmajFSN2hY?=
 =?utf-8?B?UDZqUzJMWVY2dlhOYkg4MmM4bGNXMTRqNS9UNUdmWm9McXp1cFhaYU9vR3BF?=
 =?utf-8?B?OHprblRGbG44b0JURWNYZjY2YzNlRUtYUm02SDZnUjIxQjNkRm84VmQxaTBM?=
 =?utf-8?B?NEFWZENkUE8rLzdrc0p6UURUWDhjbzZLaXZ5REJyWUxXNCtKcnN3YlFwajVC?=
 =?utf-8?B?YVBQOTRHMmUzVk5XYldMZjVyT1l5dEc5TlhNM3NtT3UwRXFtaENtV1lFUVk3?=
 =?utf-8?B?aDRNMUZWTlpwdGpKMnNHWkhYaGtWWTVHaUhSVzZ5dEVYRTh2VFJjZUxubVBo?=
 =?utf-8?B?Z2s2dUpHRHhWK0lkdVZmV2g5VnNMMWpvaXZNQmtKRitKMmZYTnR0Mzh1eHQw?=
 =?utf-8?B?L2tSY3NmMmwremh2RmF4SC9JU25MazBCZEVSZi95ZnNzNFVORjUxdEx5VDNJ?=
 =?utf-8?B?SDVnUU5iUGtUYkR5cm9uQ2dqYWc1RDBsL2pSVkxxZGt6RzlFYUdPZURrbWJj?=
 =?utf-8?B?UmN3UWFSNU9va3hYS0JuWVRub0JJaXF6QVROK3dHUnJra1VLQzIyRDcvempT?=
 =?utf-8?B?c29VUXphTFE0Zm5XVUg4azhYYk9qaG1kOXNLNitqN3I3KzdJOGc0bFAyNlNy?=
 =?utf-8?B?TVNINEh6MHZHRjlVNWYyemdONTlmelRwTngyamJMTk9wdmt0WktmRmtqU3Ur?=
 =?utf-8?B?UEg2ckhlMHBTTkZpeDlJZXFKR3RkK1l2WXF4M0d5OUkzM1ZnR1VJcnJLLzVN?=
 =?utf-8?B?dlNTMHlDejJxNjlacndFMXoxbjZWazdEMzNLUmswWUVDcEp0anE2WDB3SG9I?=
 =?utf-8?B?MFJpaytkMm5FUXZlc0JVbXRDVVVhdHBOeGlyM2FyUFpMMm1xYTRUbW1DcTRv?=
 =?utf-8?B?eFZaUm9Ka1VheDIwczVPZzdlOHZnaDVBYnhXQ3Y2eUNFdk9KS25MRnpFdzZQ?=
 =?utf-8?B?Tk1BSUgvblpTaE9BM2dnV0pBOHc2dE0vYUx1RmV1Q0xpM29QTFh5TmRXV2hi?=
 =?utf-8?B?eklkOUE3OGtKQmwxc3A3UGxQV05NbW5Xa1lEZE9hcDdsOWpPbDgrYzk2ckp5?=
 =?utf-8?B?NUkzRys5TlJFQzZ4NlZESHpZT2haa0U4bjl6UHNVRTc0eHRXalV1TFBvWFJI?=
 =?utf-8?B?MzRPSUdBOERWK0xLZkxrUVhyMDRlWWlsbHU4dG1SRXZYYXI2WmxmMDhqaW1Y?=
 =?utf-8?B?Q09KTU9BS0FWOTFGM2d2ZkQzSFl5ZnBQU2JkSGFjQkt5dXdYTDNkbGNEK1g5?=
 =?utf-8?Q?JVrK1yYwKNN3F81vOOwZy9o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF36AFF72190924BA5C0B72182EBFB6E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c68b75-87fb-4d72-54e7-08dab2e54e48
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 21:51:55.6808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bUcgU5jY1kyfOrUgX5AcT3a5+xU1IbWpT/6FGQtWC7D3FTy+2orVkagwhqEIt9kabK0cnCFjaQ8Yq/dW5Hwfm0QhrX4/dB9liD/IQEFAxfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5928
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gV2VkLCAyMDIyLTEwLTA1IGF0IDIyOjU4ICswMDAwLCBBbmRyZXcgQ29vcGVyIHdyb3RlOg0K
PiBPbiAwNS8xMC8yMDIyIDIzOjQ3LCBFZGdlY29tYmUsIFJpY2sgUCB3cm90ZToNCj4gPiBPbiBX
ZWQsIDIwMjItMTAtMDUgYXQgMDI6NDMgKzAwMDAsIEFuZHJldyBDb29wZXIgd3JvdGU6DQo+ID4g
PiBPbiAyOS8wOS8yMDIyIDIzOjI5LCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToNCj4gPiA+ID4gZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NwZWNpYWxfaW5zbnMuaA0KPiA+ID4gPiBi
L2FyY2gveDg2L2luY2x1ZGUvYXNtL3NwZWNpYWxfaW5zbnMuaA0KPiA+ID4gPiBpbmRleCAzNWY3
MDlmNjE5ZmIuLmYwOTZmNTJiZDA1OSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvYXJjaC94ODYvaW5j
bHVkZS9hc20vc3BlY2lhbF9pbnNucy5oDQo+ID4gPiA+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUv
YXNtL3NwZWNpYWxfaW5zbnMuaA0KPiA+ID4gPiBAQCAtMjIzLDYgKzIyMywxOSBAQCBzdGF0aWMg
aW5saW5lIHZvaWQgY2x3Yih2b2xhdGlsZSB2b2lkDQo+ID4gPiA+ICpfX3ApDQo+ID4gPiA+ICAg
ICAgICAgICAgICAgICA6IFtwYXhdICJhIiAocCkpOw0KPiA+ID4gPiAgICB9DQo+ID4gPiA+ICAg
IA0KPiA+ID4gPiArI2lmZGVmIENPTkZJR19YODZfU0hBRE9XX1NUQUNLDQo+ID4gPiA+ICtzdGF0
aWMgaW5saW5lIGludCB3cml0ZV91c2VyX3Noc3RrXzY0KHU2NCBfX3VzZXIgKmFkZHIsIHU2NA0K
PiA+ID4gPiB2YWwpDQo+ID4gPiA+ICt7DQo+ID4gPiA+ICsgICAgIGFzbV92b2xhdGlsZV9nb3Rv
KCIxOiB3cnVzc3EgJVt2YWxdLCAoJVthZGRyXSlcbiINCj4gPiA+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgX0FTTV9FWFRBQkxFKDFiLCAlbFtmYWlsXSkNCj4gPiA+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgOjogW2FkZHJdICJyIiAoYWRkciksIFt2YWxdICJyIiAodmFsKQ0KPiA+ID4g
PiArICAgICAgICAgICAgICAgICAgICAgICA6OiBmYWlsKTsNCj4gPiA+IA0KPiA+ID4gIjE6IHdy
c3NxICVbdmFsXSwgJVthZGRyXVxuIg0KPiA+ID4gX0FTTV9FWFRBQkxFKDFiLCAlbFtmYWlsXSkN
Cj4gPiA+IDogW2FkZHJdICIrbSIgKCphZGRyKQ0KPiA+ID4gOiBbdmFsXSAiciIgKHZhbCkNCj4g
PiA+IDo6IGZhaWwNCj4gPiA+IA0KPiA+ID4gT3RoZXJ3aXNlIHlvdSd2ZSBmYWlsZWQgdG8gdGVs
bCB0aGUgY29tcGlsZXIgdGhhdCB5b3Ugd3JvdGUgdG8NCj4gPiA+ICphZGRyLg0KPiA+ID4gDQo+
ID4gPiBXaXRoIHRoYXQgZml4ZWQsIGl0J3Mgbm90IHZvbGF0aWxlIGJlY2F1c2UgdGhlcmUgYXJl
IG5vDQo+ID4gPiB1bmV4cHJlc3NlZA0KPiA+ID4gc2lkZQ0KPiA+ID4gZWZmZWN0cy4NCj4gPiAN
Cj4gPiBPaywgdGhhbmtzIQ0KPiANCj4gT24gZnVydGhlciBjb25zaWRlcmF0aW9uLCBpdCBzaG91
bGQgYmUgIj1tIiBub3QgIittIiwgd2hpY2ggaXMgZXZlbg0KPiBsZXNzDQo+IGNvbnN0cmFpbmVk
LCBhbmQgZXZlbiBlYXNpZXIgZm9yIGFuIGVudGVycHJpc2luZyBvcHRpbWlzZXIgdG8gdHJ5IGFu
ZA0KPiBkbw0KPiBzb21ldGhpbmcgdXNlZnVsIHdpdGguDQoNCkFGQUlDVCB0aGlzIHdvbid0IHdv
cmsgb24gYWxsIGdjY3MuIEFzbSBnb3RvJ3MgdXNlZCB0byBub3Qgc3VwcG9ydA0KaGF2aW5nIG91
dHB1dHMuIFRoZXkgYXJlIGFsc28gaW1wbGljaXRseSB2b2xhdGlsZSBhbnl3YXkuIFNvIEkgdGhp
bmsNCkknbGwgaGF2ZSB0byBsZWF2ZSBpdC4gQnV0IEkgY2FuIGNoYW5nZSB0aGUgd3JzcyBvbmUg
aW4gdGhlIHNlbGZ0ZXN0IHRvDQoiPW0iLg0K
