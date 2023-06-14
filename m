Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8E5730588
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jun 2023 18:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbjFNQ6D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jun 2023 12:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236189AbjFNQ6C (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jun 2023 12:58:02 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809EC1FF7;
        Wed, 14 Jun 2023 09:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686761880; x=1718297880;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BfT36pJOzemj6+h+ctsbhNtP/UefOZ0LAoNb5mmrV+4=;
  b=b9sBL61v4eD+n6/z5toIZts0jV/WZFuxCjMbVnCpEG9uINbWZgOp0ILG
   l/kQp/ki1CeNBzePnB72bca7KJQFC+y/pPku9Ixk+i1E9KkIFOBxd20P5
   VJDL3ny8QVfgL1yN6Ho7OBFcNMlNFGxSGgiPoXGdl4o9co/42eBWzQHkm
   z9VUHIZvz2KN3C7zCCQD7wDJ5GBA9o9m8/UVTDhTaN9yKaseozWAb4u0P
   uLr9S3PJaPBDa2QCOnq1Rdcb6E+6bbA3QIGvpmo79MpBTdkNGD9kprbs1
   Ikr2HgaYnbildUTuD0ui/Gk8HMun60Hk2G/mBIb1pKzyI83e6Af5oDwBL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="338306894"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="338306894"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 09:57:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="886326340"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="886326340"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 14 Jun 2023 09:57:58 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 09:57:56 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 09:57:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 14 Jun 2023 09:57:56 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 14 Jun 2023 09:57:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSYZDrXhp/5OF38Bahr/E9BgEj+Zm6C8q0XxV2W39XgVQkjt7erJt88bT6qFgDIF29/WbIfutTJ4Fl1vL8f7i1C+flIzNl7M+Q5Xaqba/eS6qzmcXDnF4i4nm7xrVslsFk4La0iimL4m2U+J3DQpA3fM1YQdbCCXMFFighY3WiPGzRKs+nbyYTOEl50KhLVj2cHqcaX66KpWT7uobK4MMoeO9PQDU1BhxLWXT+0xCkw3/DVssz7DJ7YihP4sqhI7GQKlTREWsHrjRgJJ12A5jNwpEvUumk2zXTmDfutkv8tC9cPx6I2KPOLdx7NRnSM694WAnE3eHyRDe7wA7NFSqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfT36pJOzemj6+h+ctsbhNtP/UefOZ0LAoNb5mmrV+4=;
 b=AK1GxrPgNlRxsgEN67kOkHgN1bQjebBQ7CAWkGfOnTegHLbcNwleNf8YZs+ZA/lxbmtTXWNkRuVXWJWyfdFiJpC/tnZeeOobsz06MNWP26auztyAfrK5p/aJ36dW3b83Zb/28An05Dr85G7l8h8hixssnnQTBO9ciST9tKMkmHZ1UzSzrL21Tepu6LGSqhZxH27+yf8sq+N5XWEeJLm12dHQZ1a878qrUkksnSkcKoQjkxWI5t83DogQu+qKb4k3pV9Yx7B4TXoRpwsS1P3tNJSbzFd59aRVsi5n4u9npqnNIomFkCeRlcR43pxDNUK0GywssH+B4Gqf69YiJ7aE6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SN7PR11MB6677.namprd11.prod.outlook.com (2603:10b6:806:26b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Wed, 14 Jun
 2023 16:57:53 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec%7]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 16:57:53 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>
CC:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "jannh@google.com" <jannh@google.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Thread-Topic: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Thread-Index: AQHZnYvD++9jHqJtDEOZ5j0eN4/f+6+IoOQAgAALyMOAACwFgIAAIG6AgAAMtoCAACGsAIAA96CAgABofQA=
Date:   Wed, 14 Jun 2023 16:57:53 +0000
Message-ID: <64837d2af3ae39bafd025b3141a04f04f4323205.camel@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
         <20230613001108.3040476-24-rick.p.edgecombe@intel.com>
         <0b7cae2a-ae5b-40d8-9ae7-10aea5a57fd6@sirena.org.uk>
         <87y1knh729.fsf@oldenburg.str.redhat.com>
         <1f04fa59-6ca9-4f18-b138-6c33e164b6c2@sirena.org.uk>
         <49eabafa97032dec8ace7361bccae72c6ecf3860.camel@intel.com>
         <fc2ebfcf-8d91-4f07-a119-2aaec3aa099f@sirena.org.uk>
         <a0f1da840ad21fae99479288f5d74c7ab9095bb6.camel@intel.com>
         <ZImZ6eUxf5DdLYpe@arm.com>
In-Reply-To: <ZImZ6eUxf5DdLYpe@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SN7PR11MB6677:EE_
x-ms-office365-filtering-correlation-id: f6e7906e-733e-4024-3d75-08db6cf87e77
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y71TKfKX5MmvAJZwQBlF6jmv1DDm4+B/gCjdJNbn99e5etDH8YAAoiOKrIZtGeKotxC5yP2BAp6KPOeqqkcrI4zLoh/hBXcVxHHAnTqRH+MXSkgLtqSqT6QToETpUF/TedkTZOnNpQOHWyzfTUe/WZ1CowJm1I5u90KU42RY7u6XydjLxA/N5toaI23U1xGil+EgfyzD6qJslEm4FtTUMMw46nY1XUwr2dtyG9mjDQyx7n9jQNYcmUSf0+zG8KxVdpQAbQRGuIPBEA3Ke17FtpTvtZOO8zY24smcHknoa8oeyVIkc0s8FtBbUBdcfaLBLxOUFCF6cUNIsfb+GjPYIkFQySB4qvX7n9/9YESS+lQQyq1EJZqmrDS9WJT6egFSKOGy5YcjvZWrsnj3B3Dhr/fCtXKibDl5Wec8Z0Je/hzdK8veWY3T2pJq5z9IG2O7ZshQsX3O6lPf7t3hM0QzS2emYEBe8yMIWAsNw5zx/OaUK6mnDYRUHU0b1xZ22M8nOd28S3RVsbzcK7dZCTBGmTOoxKxClWd40qoQTHUUMdv/ALruRZTfw4q8z2UEShZrV5Avv0jUPlrUbHiuv096JZ0ElnhEK6LZw7j6lWJQwPqCtUpa/SMDmWX5cvJYjv++aIkBBJ1n++4deEjhya8UXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199021)(66899021)(186003)(83380400001)(71200400001)(26005)(6506007)(2616005)(6512007)(38070700005)(7406005)(966005)(5660300002)(86362001)(7416002)(2906002)(8676002)(8936002)(76116006)(66446008)(316002)(82960400001)(66946007)(122000001)(38100700002)(66476007)(4326008)(64756008)(66556008)(6486002)(91956017)(36756003)(110136005)(54906003)(41300700001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?am5VV0w3bVRvSjZnZEdBUjdPMnA2WlFFMkx0QlRQdEozOFpNc3JGc1RiWVlN?=
 =?utf-8?B?dHpXVWxiODlhYmpQNHUyeW9wb1pPTzlsTjVwVDhhdkxCK2phakxOdFRtZWpS?=
 =?utf-8?B?UzlIOFg5WElZVDkrMzFHRTFRaE1DTm1LYnFBOTRJSnQzQXNBa2V4TGxVVzk5?=
 =?utf-8?B?T0FPRGIzTWJ2U05pVks2YjVhRVRGT1BKSG5rWWhXY3ZwNDQyQUEvT3lRY3lq?=
 =?utf-8?B?bGdMd21LL05WLzZBYm9MZ0l5Zm9jVGxBbjhWVnE3SW1raFBrYmYyQndQODY1?=
 =?utf-8?B?WWdraGpSNGN1cVpiNE1lM1E1SzU4bUxHbW9xU0duZHpwVUlWVEtvd3NsMTAx?=
 =?utf-8?B?TUdmZXdwRXNVT2NtWTNkbDFEV2NMaE11cnVwbVc4OURjMkJ5eVcydHlOOFdF?=
 =?utf-8?B?cUdZemNZYm45bW52UzNXMHRRU0lCOXp4d0NGZnZlVWQrWHZ6K1V3eG0zeEg5?=
 =?utf-8?B?MGM3c1QxcFUwdHY3cDY0VkZXdXFQaGdkZDBaaTRYVnJHYkpBZDhiSituR0lN?=
 =?utf-8?B?TnNtbHB2RjlZNTZqd29tR1pTc3gvckZWVWVCazloZnNzaUpUZ2g0QmdPV2pS?=
 =?utf-8?B?M1p4K2tmdjREVXc4dzhqbU9Qak95OStlZHRZR1QxL1FEU2Y2ZUR0NDVCMVFy?=
 =?utf-8?B?eFBUMjFBdDl5dXJrL0Rna3RWcUVDeDBUZ3RibDJDRlEyWVBZQisrTCtIVnJG?=
 =?utf-8?B?aXY1Y3lTcm00QTY5RE9zb2p5aDZKM3QybktDcmwvRlVKSnVPNmM4ZUV6eE9O?=
 =?utf-8?B?WEN6Ym5ZOWdYUzNpUGt1ZStlZnozYnFyMUNselg0OXllUmlscTIyZDZwVFdG?=
 =?utf-8?B?Y2JGYVlVYXRSSERZNlFPMHE3WUQ4VnNuODZ3SjlKbWF2NDdEOWNMR0JNTWNT?=
 =?utf-8?B?V215Zkw4TXpUdGpud3VUWVc2MUNSZ0pvR2lXVmdsOEtSeEhMaHVvVllCZFlH?=
 =?utf-8?B?OHdZUkpnQlRqTUNQSlNvS0UzcG55cXJYYk9HMkFUb3VBU0ZNcnJkNnJIZTlo?=
 =?utf-8?B?bjFldHNURE1aeTgrTG1OWnZlbWFqMmhoU29iR2NieW0yWTBEN1JBb0l5TnRI?=
 =?utf-8?B?ZGNyempHTkFNVDM3SWJJN1NUaTU3YnlLbk1MZzFkSElDcXBOSkwzQWxxdUcw?=
 =?utf-8?B?U0ZqYm5xYTB6RlZnRzMwcWkyTVo4VXJuU0VrR1BjdlQ4UzRwRmNYNFVrVXI1?=
 =?utf-8?B?MlVubmdqeHlpYVB6OXpIZGJmRmJ5NFg2dWVzR2U2emU3dnNPd04rNlJnTWZi?=
 =?utf-8?B?Q1QvdG9xUU5iZW1hTHlzUitMOUxtdW4vNkluTi9lanJIbmZsbEIycFZaTVBY?=
 =?utf-8?B?dUxYVjZORnVLay9taE1GbHlXYmg5N2Vpem4rUGU1aERKcEwzaVBmT0dROUdu?=
 =?utf-8?B?Qm5aUitQNUc3T0FnT0VrbHdDZkpMRE9XUlNCWnpsekFSNUl2VkRHVHJNejhm?=
 =?utf-8?B?L0lWMGJiU2VrdWR6aDRwN1V1dTNPcy82dGlKVVdvNnZ0TjBPT0tENFZvaktB?=
 =?utf-8?B?QXphMitNYWpsc0ViM0NlbVdpZTBaWk1XVFdRUFlLaC81OVZETnZQNWNOcjA0?=
 =?utf-8?B?NjE5OEhabXExNWpZNWc2S1FXT2cyMUtJS2dOQ0haL252cFB0cjZLUjBCTmo2?=
 =?utf-8?B?MUdIb3hVNlJnUUQ3N2hCVjZDSnZCUFlRVnltUE5lWXhiYXVWQjFXWWR6M2hC?=
 =?utf-8?B?RGxCNGFVaDhnNkdUMUViSks5VGFVNHpMcm1GZ0JLcVBwNEVreWJLRE9abDNt?=
 =?utf-8?B?UDQyY2N6ODc0WnNkMy9wL0tocitTWFB3WlBYMlRvc0U2WjF6T3RhcW1OejBM?=
 =?utf-8?B?cjFJUjF3TmE2NGdKSGo1L1o3Vkh1cXo2Nld0NmFWallRTlltUWx0Y2pEYUVr?=
 =?utf-8?B?K21GOW5sWXN3TGczTCttcStFMWtvc3pkYnplVjJpRGhFQW8zaEIybFZiUk5V?=
 =?utf-8?B?K1dkbU1zc0xIQmRMN1VMalJFMHRNQ1RUNXFwNHRyRFZVa3N2S1g2M2orU0J6?=
 =?utf-8?B?V3FyMFlURTNraGJNbjNsM3Jrb2MyMzZhWkNLblA0WU91c0FONWpFaVFRNmdj?=
 =?utf-8?B?cVdvOU1HV3RBMjNlU2Jlak0zY0Y5SVNMTG95Tkx0SkV4cW1yU3RhSmZBUUdn?=
 =?utf-8?B?aloyWWN5RzVPa3VrWSttY2t0MmpOZCtxdXFjYjlHZW5pZ283eEVDdXlyVnVu?=
 =?utf-8?B?MkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACD71DE9BFE05A4FB737380A3ED828BF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e7906e-733e-4024-3d75-08db6cf87e77
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 16:57:53.2112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fW4zw1R7ALikISrv2CgPrjob2j03xJDvditxXNauwrjuIScWbktU733FmvBsVps5s1V36dAOUlV3yJriTTeD9SZgm51fSI1Z5syfxDmawu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6677
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gV2VkLCAyMDIzLTA2LTE0IGF0IDExOjQzICswMTAwLCBzemFib2xjcy5uYWd5QGFybS5jb20g
d3JvdGU6DQo+IFRoZSAwNi8xMy8yMDIzIDE5OjU3LCBFZGdlY29tYmUsIFJpY2sgUCB3cm90ZToN
Cj4gPiBPbiBUdWUsIDIwMjMtMDYtMTMgYXQgMTg6NTcgKzAxMDAsIE1hcmsgQnJvd24gd3JvdGU6
DQo+ID4gPiA+ID4gPiBGb3IgbXkgcGFydCwgdGhlIHRoaW5nIEkgd291bGQgcmVhbGx5IGxpa2Ug
dG8gc2VlIHVuaWZpZWQNCj4gPiA+ID4gPiA+IGFzDQo+ID4gPiA+ID4gPiBtdWNoID4gPiBhcw0K
PiA+ID4gPiA+ID4gcG9zc2libGUgaXMgYXQgdGhlIGFwcCBkZXZlbG9wZXIncyBpbnRlcmZhY2Ug
KGdsaWJjL2djYykuDQo+ID4gPiA+ID4gPiBUaGUNCj4gPiA+ID4gPiA+IGlkZWENCj4gPiA+ID4g
PiA+IHdvdWxkIGJlIHRvIG1ha2UgaXQgZWFzeSBmb3IgYXBwIGRldmVsb3BlcnMgdG8ga25vdyBp
Zg0KPiA+ID4gPiA+ID4gdGhlaXINCj4gPiA+ID4gPiA+IGFwcA0KPiA+ID4gPiA+ID4gc3VwcG9y
dHMgc2hhZG93IHN0YWNrLiBUaGVyZSB3aWxsIHByb2JhYmx5IGJlIHNvbWUNCj4gPiA+ID4gPiA+
IGRpZmZlcmVuY2VzLA0KPiA+ID4gPiA+ID4gYnV0ID4gPiBpdA0KPiA+ID4gPiA+ID4gd291bGQg
YmUgZ3JlYXQgaWYgdGhlcmUgd2FzIG1vc3RseSB0aGUgc2FtZSBiZWhhdmlvciBhbmQgYQ0KPiA+
ID4gPiA+ID4gc21hbGwgPiA+IGxpc3QNCj4gPiA+ID4gPiA+IG9mIGRpZmZlcmVuY2VzLiBJJ20g
dGhpbmtpbmcgYWJvdXQgdGhlIGJlaGF2aW9yIG9mDQo+ID4gPiA+ID4gPiBsb25nam1wKCksDQo+
ID4gPiA+ID4gPiBzd2FwY29udGV4dCgpLCBldGMuDQo+ID4gPiA+IA0KPiA+ID4gPiBZZXMsIHZl
cnkgbXVjaCBzby7CoCBzaWdhbHRjb250ZXh0KCkgdG9vLg0KPiA+IA0KPiA+IEZvciBhbHQgc2hh
ZG93IHN0YWNrJ3MsIHRoaXMgaXMgd2hhdCBJIGNhbWUgdXAgd2l0aDoNCj4gPiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9sa21sLzIwMjIwOTI5MjIyOTM2LjE0NTg0LTQwLXJpY2sucC5lZGdlY29t
YmVAaW50ZWwuY29tLw0KPiA+IA0KPiA+IFVuZm9ydHVuYXRlbHkgaXQgY2FuJ3Qgd29yayBhdXRv
bWF0aWNhbGx5IHdpdGggc2lnYWx0c3RhY2soKS4gU2luY2UNCj4gPiBpdA0KPiA+IGhhcyB0byBi
ZSBhIG5ldyB0aGluZyBhbnl3YXksIGl0J3MgYmVlbiBsZWZ0IGZvciB0aGUgZnV0dXJlLiBJDQo+
ID4gZ3Vlc3MNCj4gPiB0aGF0IG1pZ2h0IGhhdmUgYSBiZXR0ZXIgY2hhbmNlIG9mIGJlaW5nIGNy
b3NzIGFyY2guDQo+IA0KPiBpIGRvbnQgdGhpbmsgeW91IGNhbiBhZGQgc2lnYWx0c2hzdGsgbGF0
ZXIuDQo+IA0KPiBsaWJnY2MgYWxyZWFkeSBoYXMgdW53aW5kZXIgY29kZSBmb3Igc2hzdGsgYW5k
IHRoYXQgY2Fubm90IGhhbmRsZQ0KPiBkaXNjb250aW5vdXMgc2hhZG93IHN0YWNrLg0KDQpBcmUg
eW91IHJlZmVycmluZyB0byB0aGUgZXhpc3RpbmcgQysrIGV4Y2VwdGlvbiB1bndpbmRpbmcgY29k
ZSB0aGF0DQpleHBlY3RzIGEgZGlmZmVyZW50IHNpZ25hbCBmcmFtZSBmb3JtYXQ/IFllYSB0aGlz
IGlzIGEgcHJvYmxlbSwgYnV0IEkNCmRvbid0IHNlZSBob3cgaXQncyBhIHByb2JsZW0gd2l0aCBh
bnkgc29sdXRpb25zIG5vdyB0aGF0IHdpbGwgYmUgaGFyZGVyDQpsYXRlci4gSSBtZW50aW9uZWQg
aXQgd2hlbiBJIGJyb3VnaHQgdXAgYWxsIHRoZSBhcHAgY29tcGF0aWJpbGl0eQ0KcHJvYmxlbXMu
WzBdDQoNClRoZSBwcm9ibGVtIGlzIHRoYXQgZ2NjIGV4cGVjdHMgYSBmaXhlZCA4IGJ5dGUgc2l6
ZWQgc2hhZG93IHN0YWNrDQpzaWduYWwgZnJhbWUuIFRoZSBmb3JtYXQgaW4gdGhlc2UgcGF0Y2hl
cyBpcyBzdWNoIHRoYXQgaXQgY2FuIGJlDQpleHBhbmRlZCBmb3IgdGhlIHNha2Ugb2Ygc3VwcG9y
dGluZyBhbHQgc2hhZG93IHN0YWNrIGxhdGVyLCBidXQgaXQNCmhhcHBlbnMgdG8gYmUgYSBmaXhl
ZCA4IGJ5dGVzIGZvciBub3csIHNvIGl0IHdpbGwgd29yayBzZWFtbGVzc2x5IHdpdGgNCnRoZXNl
IG9sZCBnY2Mncy4gSEogaGFzIHNvbWUgcGF0Y2hlcyB0byBmaXggR0NDIHRvIGp1bXAgb3ZlciBh
DQpkeW5hbWljYWxseSBzaXplZCBzaGFkb3cgc3RhY2sgc2lnbmFsIGZyYW1lLCBidXQgdGhpcyBv
ZiBjb3Vyc2Ugd29uJ3QNCnN0b3Agb2xkIGdjYydzIGZyb20gZ2VuZXJhdGluZyBiaW5hcmllcyB0
aGF0IHdvbid0IHdvcmsgd2l0aCBhbg0KZXhwYW5kZWQgZnJhbWUuDQoNCkkgd2FzIHdhZmZsaW5n
IG9uIHdoZXRoZXIgaXQgd291bGQgYmUgYmV0dGVyIHRvIHBhZCB0aGUgc2hhZG93IHN0YWNrDQpb
MV0gc2lnbmFsIGZyYW1lIHRvIHN0YXJ0LCB0aGlzIHdvdWxkIGJyZWFrIGNvbXBhdGliaWxpdHkg
d2l0aCBhbnkNCmJpbmFyaWVzIHRoYXQgdXNlIHRoaXMgLWZub24tY2FsbC1leGNlcHRpb25zIGZl
YXR1cmUgKGlmIHRoZXJlIGFyZQ0KYW55KSwgYnV0IHdvdWxkIHNldCB1cyB1cCBiZXR0ZXIgZm9y
IHRoZSBmdXR1cmUgaWYgd2UgZ290IGF3YXkgd2l0aCBpdC4NCk9uIG9uZSBoYW5kIHdlIGFyZSBh
bHJlYWR5IGp1Z2dsaW5nIHNvbWUgY29tcGF0aWJpbGl0eSBpc3N1ZXMgc28gbWF5YmUNCml0J3Mg
bm90IHRvbyBtdWNoIHdvcnNlLCBidXQgb24gdGhlIG90aGVyIGhhbmQgdGhlIGtlcm5lbCBpcyB0
cnlpbmcgaXRzDQpiZXN0IHRvIGJlIGFzIGNvbXBhdGlibGUgYXMgaXQgY2FuIGdpdmVuIHRoZSBz
aXR1YXRpb24uIEl0IGRvZXNuJ3QNCipuZWVkKiB0byBicmVhayB0aGlzIGNvbXBhdGliaWxpdHkg
YXQgdGhpcyBwb2ludC4NCg0KSW4gdGhlIGVuZCBJIHRob3VnaHQgaXQgd2FzIGJldHRlciB0byBk
ZWFsIHdpdGggaXQgbGF0ZXIuDQoNCj4gIChtYXkgYWZmZWN0IGxvbmdqbXAgdG9vIGRlcGVuZGlu
ZyBvbg0KPiBob3cgaXQgaXMgaW1wbGVtZW50ZWQpDQoNCmdsaWJjJ3MgbG9uZ2ptcCBpZ25vcmVz
IGFueXRoaW5nIGV2ZXJ5dGhpbmcgaXQgc2tpcHMgb3ZlciBhbmQganVzdCBkb2VzDQpJTkNTU1Ag
dW50aWwgaXQgZ2V0cyBiYWNrIHRvIHRoZSBzZXRqbXAgcG9pbnQuIFNvIGl0IGlzIG5vdCBhZmZl
Y3RlZCBieQ0KdGhlIHNoYWRvdyBzdGFjayBzaWduYWwgZnJhbWUgZm9ybWF0LiBJIGRvbid0IHRo
aW5rIHdlIGNhbiBzdXBwb3J0DQpsb25nam1waW5nIG9mZiBhbiBhbHQgc2hhZG93IHN0YWNrIHVu
bGVzcyB3ZSBlbmFibGUgV1JTUyBvciBnZXQgdGhlDQprZXJuZWwncyBoZWxwLiBTbyB0aGlzIHdh
cyB0byBiZSBkZWNsYXJlZCBhcyB1bnN1cHBvcnRlZC4NCg0KPiANCj4gd2UgY2FuIGNoYW5nZSB0
aGUgdW53aW5kZXIgbm93IHRvIGtub3cgaG93IHRvIHN3aXRjaCBzaHN0ayB3aGVuDQo+IGl0IHVu
d2luZHMgdGhlIHNpZ25hbCBmcmFtZSBhbmQgYmFja3BvcnQgdGhhdCB0byBzeXN0ZW1zIHRoYXQN
Cj4gd2FudCB0byBzdXBwb3J0IHNoc3RrLiBvciB3ZSBjYW4gaW50cm9kdWNlIGEgbmV3IGVsZiBt
YXJraW5nDQo+IHNjaGVtZSBqdXN0IGZvciBzaWdhbHRzaHN0ayB3aGVuIGl0IGlzIGFkZGVkIHNv
IGluY29tcGF0aWJpbGl0eQ0KPiBjYW4gYmUgZGV0ZWN0ZWQuIG9yIHdlIHNpbXBseSBub3Qgc3Vw
cG9ydCB1bndpbmRpbmcgd2l0aA0KPiBzaWdhbHRzaHN0ayB3aGljaCB3b3VsZCBtYWtlIGl0IHBy
ZXR0eSBtdWNoIHVzZWxlc3MgaW4gcHJhY3RpY2UuDQoNClllYSwgSSB3YXMgdGhpbmtpbmcgYWxv
bmcgdGhlIHNhbWUgbGluZXMuIFNvbWVkYXkgd2UgY291bGQgZWFzaWx5IG5lZWQNCnNvbWUgbmV3
IG1hcmtlci4gTWF5YmUgYmVjYXVzZSB3ZSB3YW50IHRvIGFkZCBzb21ldGhpbmcsIG9yIG1heWJl
DQpiZWNhdXNlIG9mIHRoZSBwcmUtZXhpc3RpbmcgdXNlcnNwYWNlLiBJbiB0aGF0IGNhc2UsIHRo
aXMNCmltcGxlbWVudGF0aW9uIHdpbGwgZ2V0IHRoZSBiYWxsIHJvbGxpbmcgYW5kIHdlIGNhbiBs
ZWFybiBtb3JlIGFib3V0DQpob3cgc2hhZG93IHN0YWNrIHdpbGwgYmUgdXNlZC4gU28gaWYgd2Ug
bmVlZCB0byBicmVhayBjb21wYXRpYmlsaXR5DQp3aXRoIGFueSBhcHBzLCB3ZSB3b3VsZCBub3Qg
cmVhbGx5IGJlIGluIGEgZGlmZmVyZW50IHNpdHVhdGlvbiB0aGFuIHdlDQphcmUgYWxyZWFkeSBp
biAoaWYgd2UgYXJlIGdvaW5nIHRvIHRha2UgcHJvcGVyIGNhcmUgdG8gbm90IGJyZWFrDQp1c2Vy
c3BhY2UpLiBTbyBpZi93aGVuIHRoYXQgaGFwcGVucyBhbGwgdGhlIGxlYXJuaW5nJ3MgY2FuIGdv
IGludG8gdGhlDQpjbGVhbiBicmVhay4NCg0KQnV0IGlmIGl0J3Mgbm90IGNsZWFyLCB1bndpbmRl
cidzIHRoYXQgcHJvcGVybHkgdXNlIHRoZSBmb3JtYXQgaW4gdGhlc2UNCnBhdGNoZXMgc2hvdWxk
IHdvcmsgZnJvbSBhbiBhbHQgc2hhZG93IHN0YWNrIGltcGxlbWVudGVkIGxpa2UgdGhhdCBSRkMN
CmxpbmtlZCBlYXJsaWVyIGluIHRoZSB0aHJlYWQuIEF0IGxlYXN0IGl0IHdpbGwgYmUgYWJsZSB0
byByZWFkIGJhY2sgdGhlDQpzaGFkb3cgc3RhY2sgc3RhcnRpbmcgZnJvbSB0aGUgYWx0IHNoYWRv
dyBzdGFjaywgaXQgY2FuJ3QgYWN0dWFsbHkNCnJlc3VtZSBjb250cm9sIGZsb3cgZnJvbSB3aGVy
ZSBpdCB1bndvdW5kIHRvLiBGb3IgdGhhdCB3ZSBuZWVkIFdSU1Mgb3INCnNvbWUga2VybmVsIGhl
bHAuDQoNClswXQ0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC83ZDgxMzNjN2UwMTg2YmRh
ZWIzODkzYzFjODA4MTQ4ZGMwZDExOTQ1LmNhbWVsQGludGVsLmNvbS8NCg0K
