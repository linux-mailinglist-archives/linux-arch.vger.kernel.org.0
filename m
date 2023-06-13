Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603D672E80F
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 18:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243105AbjFMQQz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jun 2023 12:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243109AbjFMQQp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 12:16:45 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575B119BC;
        Tue, 13 Jun 2023 09:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686673000; x=1718209000;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=C5Ys1f9+JE7Bmibl52QMo05WseGH+YcevQbOApSKGbw=;
  b=G8GcF2R9+7h4UAxNje1b9Rt7VuEtGwWr7dDE7QaOjbAgYGg5EQDVoflR
   n8VTSTQNAHM2/jmf2ca1oBs8RwrAIbDsN9R6kMRUbymN2VrpOnQURnu30
   YKjgOHpwzcoQ6HzNwc1t4BZbIbVbgJM3F5iBZfh/mWrrvLE0j1o+ET608
   fXiDXKSmFf0CCw1pZD7aDl9VH46wyz4frNOMx1NLwugn870oQeyIUwUXY
   LsbCKdi6+2AG0VFEAc2re+MZrG2NH0Lfg8X3rnsN2kvTH5O+YMMR06ZG6
   l+jX2XRx5+av6Qp8KxcYrxvlsSXIXgzRyXixaOnUvTIpPIWpqw0uauMsc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="358382759"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="358382759"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 09:14:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="781738182"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="781738182"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 13 Jun 2023 09:14:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 09:14:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 09:14:17 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 09:14:17 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 09:14:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsNFXvIGVT2Tnp6sCNnPOFUyLd+0T6oNDBJvSD/gyXdnBInWtWlPBkRSTrbIQM7KBF1Kt6eN9eJinUtY9GM/X71kJY3+Uyr0EwqpmY6OnUROeu5tyThwDFYULjPpmIoOYqJ/Q09RJnw+4x+0N3gFP5gENBTqXn1fhXglnmUGZqyTmzIE01ZIyv8PCmzU0g9WEWfqSHmYBFj/s8ORhNCmzIpZMCyjyvY7/eDIBHMR9vrp9ITS6osXw+VAfu6XRMoSLLzLQC6AQ7qtUutpDnV50WFpDevMhdTSTJcvXumL9l8OdE8UHnIEn2/kd0gSJ1SCxycws+pZ6TqVTsbLkryHiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5Ys1f9+JE7Bmibl52QMo05WseGH+YcevQbOApSKGbw=;
 b=e4QQYK4mJiShT32HmsJ5qu2JwoqvPi5Irrq77LSyzVp3rZk75uV1zCYmc25iCAXbGY1+VEWl6SwrWBbO8SA9HhKMQqZmmxpuIMxdXx7QEjAQKX6fo1nW5VQSf7KXT7dF2PV8yBbj0Oz8SLbS/myZ7vy6R5TWlHnW9Fn1BT/JKNrwwBNOZag0TCMeHL14Rcprs1nmEnMrdFUUKfxiqyKwNwuULNPMmcKxNyb5E5RPgR85K4qHh6k6fGiDD+NZvT8WAXzO6Ft+DbqhpfggY/M8u1Ee6i7aM8IOLZUth5JSKaKEr86gINtp+pGms4A9XzOda+R7W9olefCw1MuJXHa6Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH8PR11MB6925.namprd11.prod.outlook.com (2603:10b6:510:227::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Tue, 13 Jun
 2023 16:14:11 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec%7]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 16:14:10 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "geert@linux-m68k.org" <geert@linux-m68k.org>
CC:     "Schimpe, Christina" <christina.schimpe@intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "david@redhat.com" <david@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "torvalds@linuxfoundation.org" <torvalds@linuxfoundation.org>,
        "bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "jannh@google.com" <jannh@google.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v9 01/42] mm: Rename arch pte_mkwrite()'s to
 pte_mkwrite_novma()
Thread-Topic: [PATCH v9 01/42] mm: Rename arch pte_mkwrite()'s to
 pte_mkwrite_novma()
Thread-Index: AQHZnYu46x2k3QQH7UG560N9dHwyWK+IU7QAgACVX4A=
Date:   Tue, 13 Jun 2023 16:14:10 +0000
Message-ID: <13a368447d2c64d09b69fa7d1556dd9ea55f70b7.camel@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
         <20230613001108.3040476-2-rick.p.edgecombe@intel.com>
         <CAMuHMdX7K-9gXuOM3KkFieM_W2-Sbb3AVZ-sR65abRMdSBux5A@mail.gmail.com>
In-Reply-To: <CAMuHMdX7K-9gXuOM3KkFieM_W2-Sbb3AVZ-sR65abRMdSBux5A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH8PR11MB6925:EE_
x-ms-office365-filtering-correlation-id: cb856960-e485-45f7-dfea-08db6c2938ad
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L51AovXYTb/lD1zWwxDNM0LSxrizK9kAwcWXdfvqK2bJv2uUruAOOVUUDbe06gApGeF8MThXKmIsmkS0vmcyP2tEUxzBomqSQzsz+gQ90vCSWc+/eXSO40fLYZao2p9umjwfAYMfv9rzrAbA5rEZVPTrrmVq+vqL0EW7oUCroJ/jzwrnKSnjtfnOaKvQl7ZFfS3BNutUFWiDCYYXRTu4ajfy4G/qS8UKJJEsIPChjnG8jvZ7mtoHR7xQz27lBrvL9aEqS60Ia7dGX8YWi7RuE6b7xMIqyv/DIHitCTWQtv+2VdyhFTpj1Jy4qbVT5lO6nuq15/MNd8MJrw0Jx0FYNKLG9owTIh0nUOiJECoo6BDe+g4iqjOEhNanHmVRoAJZMmi16dXMBwwBBMc2hVONoQvpRpvTa7I1jYrvM5pW4AB1WzRGk4wFXtJuFp6E/QkmwDotZ+LEx/ksx+b/FamLbE3XxovrM4zxmxhS5BkOBXNYDMgfg7HtDtMhQL7QCYf53Qm9ZZOBGFz4Ix7OUXkhztszzUhgx/rnPG2JSCzlNsn/QkMFCLucz3TMkLH5/TyN2d2ZoVuHArbf7YvDo7ztgyi/G55+wKXSy21oY+oiVj/ehSTqB1rtgcMzj57gfB0U
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199021)(5660300002)(7416002)(8936002)(8676002)(2906002)(7406005)(64756008)(7366002)(66946007)(91956017)(66446008)(66476007)(66556008)(76116006)(54906003)(71200400001)(6486002)(4326008)(186003)(6506007)(6512007)(41300700001)(26005)(316002)(6916009)(82960400001)(2616005)(478600001)(558084003)(36756003)(38070700005)(38100700002)(86362001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0lEVzVOQ003aUtOcXMzSFliUHFVcXdYM2RMbCtUR0ZFUjJ4QjVsRFFwOHdz?=
 =?utf-8?B?VTlyZXpTRC9zRURjZWNQNUp6VWdwcllHQ2JJT0YzUWpFQW5JTzhPUldPekFV?=
 =?utf-8?B?ZmdDbWhGdnJrdDlpOE1iZUFvY0RXL0FBZjBlQ1VyWjhraisxVnJRTVRPcUZy?=
 =?utf-8?B?dDlvM0FKMmxqcWdQNnF2T2VNaWNoT045dGFjWWcyN0JST2p1VG9NOU8zQncr?=
 =?utf-8?B?a2VLREFPWFlPOXR2ZWZHb2R5Q2c3SS9BUW1pQzN5M2MwUnNEL05SVXA4V09R?=
 =?utf-8?B?SDdqM3JCanZxZE5pSmlGa0R6aXRBc212aVBJbFBLMVcwcDFpTmFVeDA3TnIv?=
 =?utf-8?B?Rm52QVI1a2ZJQkpkL0d0aHMxS1IyVzFtekQ5bGR3K29OeXBzcGhvOWxBMk14?=
 =?utf-8?B?dlhUc1ZiODBnTVhBZTg2bWJxMHE3WGxiVy90cXJBbWt0SHdiaW5qcVI2ZVdH?=
 =?utf-8?B?dGZCVjBjbXRENm03R3VkRStjRy9DWUZjditSMVh4azR4dFY0NEc4VytQOEFh?=
 =?utf-8?B?VCtTV001QjFUMWZOMnVxK0hjcUxodUFqekJFaWRZTFMzZlpoOHRteWd6WGxu?=
 =?utf-8?B?T3hFbjFLSTYvMUZlcjNnVDZuTytnMEx0RjdTdndWcXNDRmJNSGdUV0oyOEZJ?=
 =?utf-8?B?UU9VUlpsN3lCWnNSZ0ZaZG1qdUwxSzZaN3E0SEVsRW1qS0NDaXUvU3VqZm5B?=
 =?utf-8?B?VVNocnVFQ2l2ei9wMXpObG9rTHVvR2FVQUpvYlIrcHZlbGhiUVNEZWxqb2tJ?=
 =?utf-8?B?RU9NdURsT1k0V3NFR3ZFV25jY3VLelNOTE9Nd3puempjaVR3cFBEQWZWT0Vt?=
 =?utf-8?B?M2M3QWtWOUJZRmR0TjVrclNBVzd5TU84YjZTbWEyNVBaRFBrMUNTTmhpaGNC?=
 =?utf-8?B?T25LRGhmaEFnRWQ3MEhyRkVUck16dlBrQllremN0RjNJakp2N045K3YxYmRa?=
 =?utf-8?B?ZWU3WVFtOGJLMUpSYWtZdkRFc3dtS1YrdWxQTkR6emFReEMvei8wWUdWTDV4?=
 =?utf-8?B?WnRnSWh2ZENJQkkwUWNjYlBELzM2S0lwZUtDV2RZeFFQUlZXQzRLalVma1lw?=
 =?utf-8?B?SUNDSHROcnBQSnl2Wm1OSm81cTBHak5NdTVrL3huelRnbGdhMlNvWlFYcjA3?=
 =?utf-8?B?cDkrTDhneG81UU9yaGZsNldNZU5hWTFiUVVvMy84eXlWZ3ljR2lLU2NhdTht?=
 =?utf-8?B?Y1hpNnlveHZzR2Jia29CdU1ReFNWVzVaL1pRU3J5T1dJL25vc1YwMlVybmFi?=
 =?utf-8?B?L254dTFJaFBOTGNsRDgwT1g0YkROR1ZULzhFdkdjZCs3R2JSUHR1VmlzS25E?=
 =?utf-8?B?eS95eW15QWNuNTlFMVpnaEYzRFBLWmJSN05XVUQwMWo3Tk9TNk94c2pyaU5F?=
 =?utf-8?B?bWdqbExzU1ZQTTFCMUhJU3ZvQmRLNmZsZ2RhK3BKWlBOWjVIVHV3d294VEk4?=
 =?utf-8?B?WE5jQUtnQ1B2T09wM2tLMzJlY3VCenpXSkFBVEFBZEhSS0JZUTVJVkU5Wjhn?=
 =?utf-8?B?bzdsclZZc1NZdnlZdE1pZGQrVjVRdU5YV0FNVzFjcVJuRjVQcFZrb2xWZkUv?=
 =?utf-8?B?V3pvWFBMeHFTcTRPYlF0YUplMFFNZGs3MzY0OFZPNGVnTGp2clYrRnhibnRT?=
 =?utf-8?B?QUF3OFpKQ3ZSRllvUjF3U2J5MzdoSVBIM1VvbzI5bjNlUVBNTGJHR2g3czJD?=
 =?utf-8?B?bTZoSzc2MktXUFNUR1QwejV3WndDUEdJU1hORWN3RmxmbHUvVVNTRlNBYmlu?=
 =?utf-8?B?czBkNTdLeWxVT0MrSHZhTzYxOEdjcG9UMjZkdW5ISFVKWUdHVDhJaEQvTjJy?=
 =?utf-8?B?QjFGZnpVTnF5Q0JGVFUzNjRQNlMyTDFqVzYyQTVOODVXbllnZHZHdTcrQVd2?=
 =?utf-8?B?aC9OMlFPVHBzbTd6SFl5MW5YNFM3ZC9zbVNuNWhseERDdVZiYzlJbnpubUtS?=
 =?utf-8?B?L0s0dFlBYVFMSCtBNlpDMVhlSVM0ZmQzejVPRXdwZ2orRHh4ekZNK29RYnho?=
 =?utf-8?B?Y0ViNEc4cXd6Qkl6SkcwSW9ZcVkzbDJCOERmM0o0amFGNUcyM0lMZTY1V0ZK?=
 =?utf-8?B?Zm1qNDFDcFlJSXU0K2VPN1p1aTE0REkwOFE2UkVDa0Z1YU5SL0p1OHJWcFlm?=
 =?utf-8?B?d2ExRURRV0g5SWRBb2hyTDFwZm5BMU9iYXBkazNYVDlaNmFyWTRsUGkrTHhC?=
 =?utf-8?B?c2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CB5F580BF0FAB4999F6807B618856D7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb856960-e485-45f7-dfea-08db6c2938ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 16:14:10.3433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y5Ba9yqCd37QBZlnBYLY2l1lOTn9vcjy+a+N+Z/tWy/zZXmXRSHRB82rHf+MszWekM6j9Ykb0wSUmjVxJlECtfBuM1qdER7y6d58C+cYX3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6925
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIzLTA2LTEzIGF0IDA5OjE5ICswMjAwLCBHZWVydCBVeXR0ZXJob2V2ZW4gd3Jv
dGU6DQo+IEFja2VkLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3Jn
Pg0KDQpUaGFua3MhDQo=
