Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC34B69FC43
	for <lists+linux-arch@lfdr.de>; Wed, 22 Feb 2023 20:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjBVTc1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Feb 2023 14:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbjBVTcW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Feb 2023 14:32:22 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627D72ED67;
        Wed, 22 Feb 2023 11:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677094307; x=1708630307;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2Gi2mkz5iuYQfHrcJwfj/QUBDgfHCM6Rtl3aM2/RZe4=;
  b=Ti6dqY5D+KJ3vmECIEFUnuTJ4OnnpRN/XwEa//le/IvqMsJitAzDtq4c
   nuf5MsvSH6JHltMRFYUCqm7HpHZOI4+k93cGSoxcyTsQ54iIn/Y+dZq57
   7fM4NASIPXcGvZWn8qBpcgxJRWfPsPRfq8A9nAe7HPXn1tKm1caKQHgO6
   mYUeFkt+ReVv0SSVsF4hQx++qftoZAIPBTgoEwSB7sCzETozUCvsTYUOz
   gYf1fSHY9GjL8tXqXdRq5CTHbMz+YWgunsQXRUchrgsPfOHG89XnYPj9k
   swlAkAFNlXDKRQNrUDi7onbD4t/fV1rWq+pCkm+PMBu7qfrlL6eby32Fc
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="313395973"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="313395973"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 11:31:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="665468326"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="665468326"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 22 Feb 2023 11:31:35 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 22 Feb 2023 11:31:35 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 22 Feb 2023 11:31:34 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 22 Feb 2023 11:31:34 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 22 Feb 2023 11:31:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ao1gytQkRt9sPm2zI0VFef1WqgochTFrMp5cTpEbIpD3B4HwD7A3mx2hPmdiLloB0ukStmLOnc/NqKZz4+ilKYxc4ug7mFcxSTx7dKHJO2XfP6RZYnBtIY/EDkzwTgaaUJvAQVy4Z4xvi0zMOjaF+SPvSKlDFh13FEeETBODzKRGoMyU0h8NvtyME/Rc+tuGYrkYmctrAWJh/nS2nQFymnmQdAdV5AfyoGs7G9XfTLw5T3+XkLsRRUaCr7L6vSV/90R/jAKLS7/Lz4mo9YtYsoyNe3vCoXr9ro/MwcDhudoqAQW1stDe1G4dTqDWMUkPMmAJfW5e+1ecPMxULUIX3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Gi2mkz5iuYQfHrcJwfj/QUBDgfHCM6Rtl3aM2/RZe4=;
 b=MyClHBEFWQTYO0BwpGvZRHujVSq4Hf9m9XxcVG4IKhLNPtvL/VcQezvCr/3iMxt71my2a79gF18LL3xf1NULR8hdmKOOcxqigB/FJ7AQT/6YruEygNzCi3mzibc0BnuGAmrcVWqnOZOEVOK4JYZBxFCVTFLrvx0NKQbFQ845iDDvPg+d+lm0Vs9lgLpmgNvTUrXx58KMLBWfAbVfVRAp2AhKjFuhKHpW6+nFI5kirnvEB1jpL5nSU/8WYVzQkaPwKcIIfI7ra9K5FM9o1ydrqFSShtD9xUXP5f5Wvnpr7PGexl8ImCBT+TNjLpZqEScDJSi7g/9qlPunegapirV5AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by IA1PR11MB7870.namprd11.prod.outlook.com (2603:10b6:208:3f8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 19:31:31 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 19:31:31 +0000
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
Subject: Re: [PATCH v6 00/41] Shadow stacks for userspace
Thread-Topic: [PATCH v6 00/41] Shadow stacks for userspace
Thread-Index: AQHZQ94zC/f+ziZRo0mOlVOyPZwhw67bYBAAgAAAuYA=
Date:   Wed, 22 Feb 2023 19:31:30 +0000
Message-ID: <7b16ee4ed8123a317db29255f049ca42c09a97b1.camel@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
         <Y/Zs9mO+T3uz6RNf@zn.tnic>
In-Reply-To: <Y/Zs9mO+T3uz6RNf@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|IA1PR11MB7870:EE_
x-ms-office365-filtering-correlation-id: 4e4a7665-e096-4828-3ed4-08db150b6637
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: os3ZStfimNLVVOT7Wg989rogavoJLzbFqfLQRLLsfrBX/ZjHBr+f+2qGRltw6TfKt1+Pu1dreYrIZI8LQ1UiuRWooqSs5rxrjJDQWY39v8o9aEkNKPRjxzxk6RLhL5XFGpMS/JJOuPOhH3UPYbS+KfNHQ5dmDmB9CeN1yLZmEQF7FTnQruZWM3uavqSEbT+CLzEAAYx9yBKWA+xQbEY2ER+hv4bUJEs/5NRWcYaJ7AKeyKkq7I3NTFs1VQUseZRrUw+WLqdjMlX6x6gWCHV/JrOqKb7jP6SocYT87xlKNjoNjs4u01aEV2zPhnXwe3NxhaLuziHm7kO7NARfeifZvQvF9L/3jCgKhbfdst9nfp11KFjRKeKIIv/Tv7e7bbGse80zzU1NWegn38rzGqCPu2BL3O6qszj0D2mbF5zEk+cQCiG/evdDImJlc+SvelFZitwDlLGNqKWR711GPCg95pnN5aEIgZ8kQuLGYcorDRx82r0s5FEul8wfoMNJJ7lPrz9mrPO3vBR9Fny6BSGToxBEEwormy3+uqGMQK1bDsv8CTE9FGrzuNU8fAgVqLTGCsjBq7BO9+8CW03bW1NjFj0bbqJn+PKCKsA+nkBrGSlH4ljx28QS+1ICHwcKV4U9yvXSwO+HZNXx/8SZDwRwLGRg780Yo87L8TPmW+NCqolcD9+YZV0SkEh31vyA4I5eeEn427/ddLZxbi2X1tKS79xxyIeqzKz6aoyRiRsYL1w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(346002)(136003)(366004)(376002)(451199018)(186003)(26005)(6512007)(6486002)(6506007)(2616005)(71200400001)(54906003)(478600001)(316002)(2906002)(122000001)(76116006)(82960400001)(6916009)(66946007)(4326008)(38100700002)(66446008)(64756008)(66556008)(8676002)(66476007)(7416002)(41300700001)(7406005)(4744005)(8936002)(5660300002)(38070700005)(36756003)(86362001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXlVTHlWa2JmY2lKN0JpZEpiYVRDUmZGQTZSNGhiYlBNSys4L3VCZkgwa3lw?=
 =?utf-8?B?UkJ3VS9NQmpHbTY5MXVQbWlGY3RjR0FHRUdFVlhnZVcxam5CVlBpNnNoNCtR?=
 =?utf-8?B?MjF1NnlaRkljRUtZRDVXTmNteDRHWjRvNXRFZ2NsaTBlNUlyaWM2Wmpvc1k3?=
 =?utf-8?B?eWI0cW1qSmNaM2NZTFE1ZThEWVhhUjVLcDNFUWJucytIcnRURFBYM0Y2VUZw?=
 =?utf-8?B?Nk9hazcxdGNmeGtWZkVaTkpWaUd1QTAyNjNuK3hRMUV4ek13blpDRGtaNjFC?=
 =?utf-8?B?OTJHMTlyNnFsWFEwUHkxNVZLOGo3d0dKYW53SmR5cjFsN2s1ZFpvZitIbDla?=
 =?utf-8?B?U3l1MUh6NU9BYzFORHJIbjdjSDg0YlhseVlTZm9CTERjcWlzeTdkWDAzNk1U?=
 =?utf-8?B?aUJKdDUyUUNuM1VJZThYZG9zRzIrZkdCQnNBS3NFR3FydkJ0OGJEYVJzTVYz?=
 =?utf-8?B?NlhHS0pZNUdqWFZ5R1RQUGF0VUx3NkxldnV2V0NINUh6UEpsU21VWFAwaXEz?=
 =?utf-8?B?emJ4dW5WWUNxRWRLZCtYN0xoOGMzSHJOYlo1c0Z2RitWOW05d0NpRkIrbGlt?=
 =?utf-8?B?VnFGZ0pXZ29wa09EVW9tU282U3FMdmNhZEpuSGlyKzJaUE5GUStnb1lFNVVU?=
 =?utf-8?B?K1JiOTJFQnAxVHNOL2VHekdMb1NrT0NZNi9TT3JTbEJSTDRCbFJXRnVVQlFi?=
 =?utf-8?B?MCtnWEtyTWlRUC9sQXpIZy9vRG11cDJGKzM3S1oxWFZOSFcwUzF2QUFuSDNz?=
 =?utf-8?B?ZTFBSHkwSFdCUEVDUld3VUlnZmUwTkJVU2FtS3RlbU93UFJLenFzYW90Y1dw?=
 =?utf-8?B?YmF6Z3JCU1o2ZkFNQngzOTZTM3B3NXFDMElCai9TMmJJQ3MvTnRTd3pGZ216?=
 =?utf-8?B?VW1vSkpxUWJUSG1ZaTVucjNkNGRQNlZXV0VyUWRRTmFOYVlpZXd1WklPMG8w?=
 =?utf-8?B?cjRKNFNBQkUyQ2p6UWVVVDFITW4vSi9RN3pzZ3hiaG9OZC9Oc0FJcUR1bkRt?=
 =?utf-8?B?L01JRnVxZzhPVWhSbG5ma2N4VGpTZEprMXg0cjE5SGpIT2JuTzI0V2ZNaXNt?=
 =?utf-8?B?dFM0b3FYVVJUeUJhOE0vZytXdmpFeC81bDRzTkprSFUyWnlKbzBINWFpTTBN?=
 =?utf-8?B?M2hYRThVZTBBNHhRamdvSWRqRWtZS2hJVURTVFhwY1BsZldoTHhiM2dZTHU4?=
 =?utf-8?B?TDRCM2I4ZWNmU0pJdVFLUWF1WlZCV1pvNS9rVFBlaUYxSDlkRGhvMndLTWJE?=
 =?utf-8?B?UVFXYWUrTVBUaHNHaTBvSko4SDJmRFk1Q1lBSmxQaFZaYU9WSWJSQmRicFlV?=
 =?utf-8?B?akJjMk9lZVdRbzBsTU1UM3pJMFFWaGU5em45emwxN2lyMDlacTU3TXBpRzJl?=
 =?utf-8?B?TmRIZk93SzVlcGNWMEs0dnVLbjNDeStaeUxEWXduaDN4R0w5UExJMThVdEFP?=
 =?utf-8?B?Ui9JUG8wd3RQa0kxN2NCaG8rK0IyeHltc011TnI0LytnalRjYWMwblQ1TnBE?=
 =?utf-8?B?YjJvS1lvRElOMkhPN2NjTnlGL3gyMmprZU5CVUF0aWxDZW9MR2RtUXFpUGk4?=
 =?utf-8?B?bDFLaXBXU3F3cXI2Sk1zSWt4c1c1ZDg4Z21WRitZNFpvS3dFYTFaQVBCcUJ6?=
 =?utf-8?B?Y0NucGg1SW9pTWZ4TWdRY0wyb09yczN1YlhpYW9kMkNhSE5taXJ3emg5QU14?=
 =?utf-8?B?RUx2bTUvc3Ficm1wVGlDZlRUTlFVbmlqRUZMQjBnUUpLZDd5VWczS1VsaTJk?=
 =?utf-8?B?bWRsY3BuLzdvZGoxQis2R1VKSEVqMWFwNHgxZEpzOEFRZ0JsSk5pVTJOTlRH?=
 =?utf-8?B?eVROOC9Vdlo1TGtReVFpYUtydHpSTis1WlFvd2ZjYTg0Mk9idEY0T3ptZ3ZG?=
 =?utf-8?B?Ty94bDRiTW1rRjBHZ1FmMzNyTlJCVVBwYTAwcW5NMk9ObHNWbFZ1UVROMkQ1?=
 =?utf-8?B?enFZMjlpLzNyL1Avc05CL0NqclZvL2lDWXl1MktkcXRKNjVVWS9UZ3FrUjE5?=
 =?utf-8?B?aXd3ODdXcFpUaE05dGZNblUrVTRyRGpZNEEzeWM2MFZVVzFKdG5YSnRrYUQz?=
 =?utf-8?B?UTF5TlVLRzlCVTM1Y1dVQUZEb3VUZTB4b0JoVXh3azdKNHhIZ0xTVkI1YTNQ?=
 =?utf-8?B?NEw5VjVwOXAzODlsNC91U1hBSTFyOE81RVBXb0hDOUZsOGVkcDBhSjNXdWo4?=
 =?utf-8?Q?hTt6jK7T6ktlTaP05zsDsjk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0E228A3BE0FAC45A876D0A74541BAA2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4a7665-e096-4828-3ed4-08db150b6637
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 19:31:30.6621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w2Q0WIs77Uxb4IgKveWZDGk7qLh+qPRsjNKyNG8mR/JN2zS4JEBaODSYOb3kjlMO6TnP5Gbh4rCpoZ3rZ5k6XvtYglvq1nHKMtnRD52a3AY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7870
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gV2VkLCAyMDIzLTAyLTIyIGF0IDIwOjI4ICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFNhdCwgRmViIDE4LCAyMDIzIGF0IDAxOjEzOjUyUE0gLTA4MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+IEhpLA0KPiA+IA0KPiA+IFRoaXMgc2VyaWVzIGltcGxlbWVudHMgU2hh
ZG93IFN0YWNrcyBmb3IgdXNlcnNwYWNlIHVzaW5nIHg4NidzDQo+ID4gQ29udHJvbC1mbG93IA0K
PiANCj4gV2hhdCBpcyB0aGUgYmFzZSBjb21taXQgdGhpcyBhcHBsaWVzIG9uPw0KPiANCj4gSXQg
YWluJ3QgdjYuMi4uLg0KDQpJdCB3YXMgdGlwL21hc3RlciB0aGUgd2VlayBJIHNlbnQgaXQgb3V0
Og0KMGE1ZTk4NWZiMWM4DQoNCg==
