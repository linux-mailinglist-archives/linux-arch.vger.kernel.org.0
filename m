Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA5072E858
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 18:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243116AbjFMQUY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jun 2023 12:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241585AbjFMQUW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 12:20:22 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BAFE62;
        Tue, 13 Jun 2023 09:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686673217; x=1718209217;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nD9hKEWIlEQms9D1nSVJYfTkusC5Rkk8ZZSw4+aFueo=;
  b=eVmP6rHSrL0pJFH9GjaQNgoB+7/xvcrHbw0DXmx13h41800E/RdtByqW
   QyUNO5/aSvtS+GZ9k0dR6TlXVvQrIl8zKFDGJzFvORqDH6ZjgTHarVde1
   Smtwh1CxAcvKOBsfBLNQaFuB5RztW8a0mFZNN7PDpplN4g26RrsEWSeB9
   Cb8uL500y2Z6cH3XgJGw7+Sf1yDEEB3Wzi6vMgPPaF7Y67MYN+E84Vs/R
   3muoOJ8HM3v/5G8wCsOGqEwpu06sjSWAti3KN4JOAdlC5cDM94xaN63a9
   7DvHQ6clq6GwIlriZNOZ1SJlZuTs2pV4V8DiQKJvjO0HZhZ6L0swvJTer
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="355882947"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="355882947"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 09:20:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="1041832964"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="1041832964"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jun 2023 09:20:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 09:20:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 09:20:15 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 09:20:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiqndRaeBd6lnYxYeTKZoQvchmyXpDOMfKedOeCITbObPavfg1dAi81UQiXFriMQxJ4lyXh51bQlHx4o4ikXfeKpuHs47fZCnf61SNBU43UPgGW23UYZ4837vbyeiMvxqQdgUs2vMt59pnC3DEXHZYq//QwbsUJk0QV93vHwRNfMczuBwC+6e+oZvPQvA5/dq5Ex2iKB/6U3RlbPLLxKkKynRwrp8EO5gbOnd4wSq1WVidw4afoxeRXkBcMcTVr5fWNuXWmoVciPYujTBFipOtvP9PukHgPeWgK4INNS3Xx9Uv3+VM/6oz3uEa6aaAeL6EpkwfMkrBO7/BsnEx5YLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nD9hKEWIlEQms9D1nSVJYfTkusC5Rkk8ZZSw4+aFueo=;
 b=TBppFHl27o19TkLLgQoUDcIjvjom6/7sbs2hyNPP6EaLhf2hg0dkzLH1d1t0W5jxzMtryIssG94xoiPv829P+4G5uOL2DU06VzjPuZmi1K8KzctvPsAhHte6uqwLfNmS3T9AmIwixLm6Fwp5O8XMy/xHduPiHm/wu5mbqLsed4Q/RjNz664Iz+NM4UKg9Dbs4sH8d5USqRr3SorRYG51c+rHEcPJExjJdF3Oi4gkJ+w1ihMoCRlR6Julh2IIFZwW3nHLP4nUueKqe+MHRVTDELlW3eUQaOS7BnbxtVGLqQ8nsZ2HjYOLuMuRa1GAe+IwBLiR1iGTbH/gUo2cGQC7rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA1PR11MB7853.namprd11.prod.outlook.com (2603:10b6:208:3f7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Tue, 13 Jun
 2023 16:20:00 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec%7]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 16:20:00 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v9 02/42] mm: Move pte/pmd_mkwrite() callers with no VMA
 to _novma()
Thread-Topic: [PATCH v9 02/42] mm: Move pte/pmd_mkwrite() callers with no VMA
 to _novma()
Thread-Index: AQHZnYu5myZdSN5guk62QnYDURPfWq+IqbeAgABA/YA=
Date:   Tue, 13 Jun 2023 16:20:00 +0000
Message-ID: <98af2f9db6e98afe5212a2c3828f72d3d70bca5f.camel@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
         <20230613001108.3040476-3-rick.p.edgecombe@intel.com>
         <ab7853ca-70dd-b885-07df-c0764509997f@redhat.com>
In-Reply-To: <ab7853ca-70dd-b885-07df-c0764509997f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA1PR11MB7853:EE_
x-ms-office365-filtering-correlation-id: 980c5848-0524-491c-300c-08db6c2a0931
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jee6UUnbSU9RlYLZUdDotSXwYnK2GL3yO3111PBo/pDe/+0wC/wsimYk/KGniWOjvq4RyDxLVA/CCO68LAdk1UNUtK/CxRKYsq1Ky9cqOXB8HGgdends56El6J5ReCW8vN7eDnUiGSZtwpRpM25KjCQbYgM11P8OCneHxXWcxyFPN2UT34OgVnSnPRmD+YR+CE1EmQw+vdNcbBWTQjlMzFM5IHJBE32lOQDAI2IJX44Ns4gtz2gkm+ozRImFuqg/2B1ziEvilNo9IvEAXuh11AFhCK4PBNfkw1kADb4X5FXDD7QoguGTSUeD9dnv+jLxzNNIt64ZGcpp1wJXtdxzx198c5Zfqq+Fd0qe/1N5T8CFfPAQNCabbWc+xN7Fb2YRh/sA9VzP1zC28E5dcyQPO4nUENA7JnEw+KoixdbvKp8tq6eMe0gXpzY82dZ3lFKZhVg1VCOLT7FCldwMl5Fg1kiveY0ASao51D2VdfymPs6p8Rt5+ui43WMiO2POhj3cvs1Cm+Rk2to2qSTwInpfEIvfrBB7sVNvNUH5rX8CMLY36u425c+peog8HHSpJuMpHbD9lTD79rBHEmLQfRwLTNMNl2CgfWbcovDyjDfFSKrj3X5pZMIBedJPs4eZeZ/VFpp22F6Dkpo5+lCdMrx0Ow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199021)(38070700005)(86362001)(36756003)(558084003)(91956017)(66556008)(110136005)(4326008)(54906003)(478600001)(71200400001)(316002)(66946007)(66476007)(64756008)(66446008)(76116006)(6486002)(5660300002)(2906002)(8936002)(7416002)(8676002)(7406005)(2616005)(921005)(82960400001)(41300700001)(122000001)(38100700002)(6512007)(6506007)(186003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDhydXMzNi9xeVpJQWpyVE4zVXdrdVlVU0JiS2ZJT1BwRTlVeXhhWGFvYkNr?=
 =?utf-8?B?dFFaNFlHeGxVbVhFcDBEcGhpVnVranA3VHRKSHlweXZIMmVMbktxZTRXVjZz?=
 =?utf-8?B?WExIcVFSbko1K1dGVlEvaTdTTDBOcERqek9wYmxZRkVhRm0yOFJ3ajF4Q2Rr?=
 =?utf-8?B?VjAyK2JvWGp2bnJjaVJxR0oyLzlna0d0djlsZ2kwQVBKQVhaNjVNczlZc0Fa?=
 =?utf-8?B?RldpMkM3bXlBUy9KU3I0WjBOeElFT1FiVzBFYXZQWHlYcmJKTjdPZzM5d2pr?=
 =?utf-8?B?dWdvajZBZkJxK1MrVlFNZ3ZpazlIZ3h0Q3d6bm9QaXFNUVRwdllCVUdmTVNF?=
 =?utf-8?B?aDJXOFQrbWxocG9kc1lvYjhMc0kreTV1dnRKd3k3d2FBT0g5bW91c0pRSmVh?=
 =?utf-8?B?TlVsVzlyc1RicHdZaWZFMlQwaFpMN0lCYjhyRS9xQ1g2SlN5Tmk5dGJOVnBy?=
 =?utf-8?B?RmxnRFRVcFl1cXJSWXJLN2lzNGxXN3A4NGhTdHhvSmF3K055WVZiNHlFYmQx?=
 =?utf-8?B?RzNRa0xERUwyVnRweGF6RERXVm9VK3RPY2dnMGFiS3hmVWhQTmcvaG9wS0FE?=
 =?utf-8?B?MWYvaEVRK3ZiYjZMUEJ6VHducVhUK1U1WUdadkwxanhTZ3lsTmRERnJrQThj?=
 =?utf-8?B?bVdFUGM1a1E1WE5kVGV5M2dKR01qZjZpR2o3ekUyamV1dVovQ1dhNUd6cDRN?=
 =?utf-8?B?VHRUYWVTVWJnMFZZVUpiSHlrbEpCMmFOV3dLZUxiWThoNThQUVE2UzFqdmEx?=
 =?utf-8?B?aHE0elk4cW9SNk5QanRFQWpIYlNseSt1ZWNxV2FseTh2RnBoOVpIWjlITlJi?=
 =?utf-8?B?bmJNWEg2NjVoN1ZpeE5Uc3g3bjJSZkZQS0EzNldNRGVLYndxek1sTnFqbE1T?=
 =?utf-8?B?VXd5Q2JGanBPN1lmMHV4eG8wMW5PT0Y3TlhmUlFDUGp0MHdqQUpZcnJTc0dk?=
 =?utf-8?B?VTRaZDI1cWF6ejRaTFRDTDVkQlk0NGNudVJRV0c5akptQzFiRUFEVTcwV3o5?=
 =?utf-8?B?dHBSUTRpWVJQeVRiWlZtYmNIZ2YvbU0yUG1PdTRmdlg3MU5PWU1RSU1PQW1L?=
 =?utf-8?B?VHZhbC9mYTcwSWhIRWxvbmp4V2tLMld3MFVsakhtSHJESUpxTkdveVV2VG9m?=
 =?utf-8?B?RXJpeFh0ZWRJU29oRnkrcmFCWllOZ1E0YXN6Y3lsZVpFaXZzcjRtdTdPbzIw?=
 =?utf-8?B?TWJ4bVFIVEMzUldKUzVESGVtc2FSU3hWWXhOSjlneWp4WnI0OERUZUs1RnVN?=
 =?utf-8?B?WmR1NjcyRGNMank5cmN5S3ZXYmJ4Tkk2bFJyMUVUK3J4Sng3RloxYkMvcVNi?=
 =?utf-8?B?MTRFN0JoaUM3emRLc3U0bXdhRUd6Tll5WitsSXE5RlVRZUs0NWdDcGx0OHVF?=
 =?utf-8?B?TS9HUVBlT0kwSzBHNDN1cnF1TzVYYnA0TjNpd01mckZhanVtSVg2NG5Oa2N3?=
 =?utf-8?B?VXR2QitwTmhHZWpiMEI0NTFSR1ZoSGRiQnd2alJZcFM4cDZhQ205S3pEemJv?=
 =?utf-8?B?R05tNWY4U1cvNVVTeXB1MGJZR09TZzhOVE9NNXpmNWlpWXl6eU5MK0I3Rndq?=
 =?utf-8?B?clNIOGc2NDUyL1NtRWNabnhlRllvRXV5cXgwR0Zab3BqV24wbmxPd244N01Z?=
 =?utf-8?B?WFZzbVR1MHJVcGhWQml0TFlLSjdqbTU3Smdkc0UyZVVZNk1veUpuQjlQOXpD?=
 =?utf-8?B?dUszR2xlZjdGSS8rbnJjRFNUZlljQk1taUFoa0FncjJBOStkN2tFQXVYUUtk?=
 =?utf-8?B?WWRrTy9hc2tlU1FFcDdOZGk1aHBEeWxmOEd1NHh1RElFUUN6bWlWUmlUSjZz?=
 =?utf-8?B?OCs2RERsWklmRU5wSUVraE5mZG9qVzlrNzNzV2RoY0tEVDltZEUzcnNmUHQx?=
 =?utf-8?B?M0dmbFZ5WkdvdG1tZXVpcldLNFNOTFVLUGJiQ3lUanJlVVA1VkRrU0p1b29w?=
 =?utf-8?B?RHpzUUpRMS9OZEVKWmlkSUYwYzB6Skh5SXJwbzh1T1Y4ZXNJK0RPaFI5QjBU?=
 =?utf-8?B?QVhabHdqRnY4Z0RqU3ZNeFNBbGI2eS9STC9xSGppTldwdVV3YTBFKzZXdTJR?=
 =?utf-8?B?cXg0NFJDRjlheG5LSGphMGdTM1BRZzg0enJUWitOUXVac2RHbzFTZVZDWmpq?=
 =?utf-8?B?Mk1yNHVkSGtSZW9qN2ROYjVic01kUXJFSExsM2xWNXJHVU9yZ3hCR3p0ZTV4?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <18D51465F1E71A49BE36B63A2C8628C0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 980c5848-0524-491c-300c-08db6c2a0931
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 16:20:00.1302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Ucay9Po8N/qSUmQwzTCVODt0Qqi/7AxP4N0CmF8OKYzkkxwS2ddnGUBt1/T9NuOXD+WHrZkBqL/4ajUAQ/wcXisj0nxSpHxFhISct8CFrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7853
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIzLTA2LTEzIGF0IDE0OjI3ICswMjAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4gQWNrZWQtYnk6IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPg0KDQpU
aGFua3MhDQo=
