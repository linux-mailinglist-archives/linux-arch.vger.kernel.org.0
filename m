Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA05678893
	for <lists+linux-arch@lfdr.de>; Mon, 23 Jan 2023 21:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjAWUqe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Jan 2023 15:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjAWUqd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Jan 2023 15:46:33 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926025FC9;
        Mon, 23 Jan 2023 12:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674506792; x=1706042792;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/dZ8D0GnL72ZhS0ertXaTdr1+ddb63j6kNmEHdhgEhc=;
  b=Ws4H7E/CGgzF5rs+VsWZIXZbQSg011Lwnj0adBJhNOjVD3AwWmbv0rZf
   nWao2XypTbb3ZC0qIb5K3b9ueEk1RxAv0LDzS0rgD20F4gFUFeZSXeiHw
   Lc6GmbgQ160bFrPV/T5L7mqL9+aE6bxfS+XROksQ/xxl7n3lig1r79S5K
   uV1Hfqwqmtqv7edWF33i5ffUlJKYI+XQSQ8lPYDx9hEQwWD7lmwsK9eeg
   aKgGtTV4qVaLSwk88RZG3WqaqR7V15rQuEJdIzPW9RGmpkx908XRU9Njx
   DuhzaDbaG3KO2l0Wl9QDe/kGtH9+vohjjRNXW+pXn/VY1si8gTAJGnga3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="306501653"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="306501653"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 12:46:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="663817607"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="663817607"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 23 Jan 2023 12:46:30 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 23 Jan 2023 12:46:30 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 23 Jan 2023 12:46:30 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 23 Jan 2023 12:46:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4fEEahQFUeZ7oKOMWuEWtoRlR3eUH4kQMqPFl9G4K6LGAQwsXB0jS0P8Kcn7hbE5gJuIOtWjCLVOhHsNYzTQORqTACEwI7kg+P7iQHJ5U/EjGZtrL/Cb4h1DnCV6SaE1GHlT+fmkaNmtPXtHEbfpKmcN9RE9E5+dneNswC/aOIuRbewCkuH6MIAXL3JAtRSCn75Bu3+/71quwRAfYBfji3ogGfpkuV+Uc5cxmpB3Bc9eOwxKJU3xpoquPk06vAaAOlhMhHh2EjP7Nw8BZgNFvtk08Of1N/hTrALqmp2so/2kfxhsrUTyKK+nMwWDkvfFp6Yw0fHkcjFvlIhzvM5oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dZ8D0GnL72ZhS0ertXaTdr1+ddb63j6kNmEHdhgEhc=;
 b=EO/xu4Zxa8gvkvP9HsTi3Alvvc2Jlde5TKUJcHQuwTj2Bqwqy2louQYRDDS68LG/+YsIglPYMoA0bkn02gOH8goi1Sfw/+qpvZmtMqNR0uBoQ7Vy4OG3eukst+r7pyjhSIKM/SXjKmm3NS0AF7tYN9zcBo/vNkn53Cg/bK9bFbTNOwFWh1KVXydSWU0r48lIIqwL9vsUA7r9SQcchJ59gQW/wDsUPFARcn8Et1toRYIOB+8ohuzidCv2hlS+pQsJ7W3ogCWWOqWU2qccPu20ZSN5w7CU+y7CUO+YVUSBwf2qBPBsc1d6H8fgd+KCC7J9hSKBBv8cOeWS5sCHzACMCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DS7PR11MB6104.namprd11.prod.outlook.com (2603:10b6:8:9f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Mon, 23 Jan 2023 20:46:22 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 20:46:22 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "fweimer@redhat.com" <fweimer@redhat.com>,
        "david@redhat.com" <david@redhat.com>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
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
Subject: Re: [PATCH v5 23/39] mm: Don't allow write GUPs to shadow stack
 memory
Thread-Topic: [PATCH v5 23/39] mm: Don't allow write GUPs to shadow stack
 memory
Thread-Index: AQHZLExd1uIADC0jSEapGta3tBezb66rvFwAgAAatYeAAKfVgA==
Date:   Mon, 23 Jan 2023 20:46:22 +0000
Message-ID: <c6dc94eb193634fa27e1715ab2978a3ce4b6c544.camel@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
         <20230119212317.8324-24-rick.p.edgecombe@intel.com>
         <aa973c0f-5d90-36df-01b2-db9d9182910e@redhat.com>
         <87fsc1il73.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87fsc1il73.fsf@oldenburg.str.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|DS7PR11MB6104:EE_
x-ms-office365-filtering-correlation-id: fa800ca7-682e-41eb-f376-08dafd82e300
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UNF7c33QaWWP0soSkzcXz+GviHyZt91i+qmNk8hWSWImy1rV3jW2s5DcfdbGThVOZLU8Qck1YSpuwgyEaOUWwbpiX3l1vf5mDaYu8rhRnKigRIcJZqeIhFkEDKLom6cxV374tGRhxvaP28UzwALzgnLsWAFJixZ4/u4MAVVlAxM6hskFZslmcmjjpI2hF+LJzkIkoVPKoOGx/B6Vvcox0ln2Gkkq95fnPKRv3PWieP/5q58BaOQGEjo8OtqETEGH0Ahw6rb/ZQiC4tqOwH5lzLZnpKmbYmPMr9P/S8crS+nir/ss90ETgrFiWjMvYTfPesWGXjGuLgb5CdUKv4jDXV5AOx3CBh+WKZCqMig5gWmRNgqsIhkFNASI5THEMGr2Fgr+9w248pYd13eJ+3a550lNx098hoKeHXlH60bJ6Q801wdDDvOEGq61xTMGF+hcYGpZlRh62G0TZxkMghcU+XJmENJemfaRyzXFk1yo3mqMCUlEbOl4RUGkPWBM5M2QMiPgdou3T5O7GRUtxbl7G/Vc3EfqqNkzWq1aKWajY3GPSrRVSv3dY17cFqTUEnnZzUwJ2l1KItlwlGT7AW0RxOfqlEwbwrgK/DQyH/kCVrwwXhunNtPTIrAh1n18eZHTpFXFgH3gYpxnpx3Baf2eQSD9T00S6NtsHKOmv+m7S/957aVqgw7Brac8uFoVY1bWLd8mQLPOIV5NN1IclLcZX9q4p953WhulFCHy1we6sfk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(366004)(39860400002)(376002)(451199015)(38100700002)(2616005)(4326008)(66476007)(122000001)(66446008)(66946007)(64756008)(8936002)(86362001)(38070700005)(83380400001)(7406005)(5660300002)(7416002)(8676002)(82960400001)(91956017)(6512007)(186003)(26005)(53546011)(6486002)(6506007)(316002)(41300700001)(54906003)(2906002)(71200400001)(110136005)(76116006)(478600001)(66556008)(36756003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bU1KOFVtWlM3YzYyQzZ3VEJMQStLTmxnc1paamhuU2R3OGtVeGxkS0lraFJp?=
 =?utf-8?B?RHNvVHNPcHlJRlc3RTlsR29LbVVBb2ZZUitWLzlyUkJQS1BBRDZJbGExRlZj?=
 =?utf-8?B?S2RZNlVZZXljVkw2NHQ0d0lPaEZURTJZK0NrL1hYTFkvc0hIelJyMjRHUys2?=
 =?utf-8?B?TW5PQTdsRHc0Wlk4OGZyMlFxeHltSkV5c0FyMUEyMStYZTJFd0JCMERNM3Qy?=
 =?utf-8?B?YVdnN2VabzZuZHgwalM4K3puRTlsQVlzcXhSbkdWUU0zV2IreXRCTS9zOVY2?=
 =?utf-8?B?UG4vd3dYOTlJUy9CR25RYWIwS1RHNzMwVG5PVllUN3hiZkFTdDBlbW1reWcr?=
 =?utf-8?B?OEV1RDJKQTZOb1NESW40RFRRRk5kZXo4c3ZKa1BtMTYzNTJ4MWRPYUlXZjFS?=
 =?utf-8?B?QWlEOHZ2ZE9oR05yZy9LTEdOUm9MbDlPRUJDR3VhNTdETnJNQlBtQUdHZnhn?=
 =?utf-8?B?NTNwT2JuTDltYzZEOTYrcVJWczNvSERjYys3Tk1jSm5vWnRyeXplQkN4Zkhq?=
 =?utf-8?B?UEFyMmxEM0pGWm9nYkJEQUxFME1zazZrS2JPbjhXMlFRTTdYT3FnSG4vZjFm?=
 =?utf-8?B?d1Ziejk3TVFxRlV3NnZHY2I0WDQ5bVZ1ODQ0QmtJNHFyWm9FNXZ4WEYwOFBU?=
 =?utf-8?B?QitLUGU2UnZhLzU0bUhYQTBHdmdMN012aTA0RGdoekZrSEdqc2dQbHJEVEZl?=
 =?utf-8?B?RXZRc09GaFA2ZXNCaGtiU2d5MFpHN2M5NmovY2F3R3gzaVRJelZPRGdRWStu?=
 =?utf-8?B?Ty9aMzRzRFVSNlFJYVpSRGtKZXF0a3NOOEg3VmFYUCtXWTV0czNVZGRXNlAx?=
 =?utf-8?B?ektKZGQ0YWNlZGpqbzNieVVqTkZSQm1nMVlJckRrcHJycXF1cHFLcTJweThx?=
 =?utf-8?B?bE1yVThjTCtVOUc5VzBGbzNialRpc0RIUGVSaEpyODVuSVJORHJHNHVybHFV?=
 =?utf-8?B?WFBaeExIUk5lVExvekF4MUh1L0t3bmVwQlNYRzVxWTYzYk1CZWRlWmFaRlM0?=
 =?utf-8?B?Mk0xR2FtdkpTb2ZDa01LT3ROai94MWI0VXd3VzBob1lHc2hTR1JVN3h5RDBw?=
 =?utf-8?B?eTV2bVNBdmdRQ2lUQUNHZGxzOFNjcG1LSEFpNGdtSmFUL25vL1k2Q2xpd2ha?=
 =?utf-8?B?WUlZbGdDWTNJT2NXTS9FNWllamQ2WFpwaHhsVnRjV01CQUEra3Z3MUI4ZXB2?=
 =?utf-8?B?TWZYWDl6UnN2eVN6cDhjczIrVkxqcFJZRWJ3K2xQV3BzYkY2TTFUd21WaTVO?=
 =?utf-8?B?K2lGeGQ3SS9rRmhNSll6aGdRSEUxRTJmWmRtc0U3Rk1JZlE0Tk5Xd2FRSjVH?=
 =?utf-8?B?NUhyZ2xRemZZbHlKTk5wcFRNZHVxWmdVZ2lxT3psSW10WS9OTXBGRWVXRVdu?=
 =?utf-8?B?ZVMyN3RGNHFncC90V2dYTjgvbXdWZlZxR1RKV2xjRjZDRUZ1c0xWcXdiZFZL?=
 =?utf-8?B?R3pFUHR5TUhneHBEMWR6MXMvOWZZRWE5cng3RDZONG94VjNxUTgzUWFUWjdl?=
 =?utf-8?B?bHJzdXZRNXZMditDcjgrRTJGcW42Tk5yZVhOa09jVzh5UHlLdmtRbHVNeDNi?=
 =?utf-8?B?dlErQmd1U1JRaC96Z09TUUhxSGxYRXkxYXVhbnFaMmN2ZkxkOWZiQkM5dXZB?=
 =?utf-8?B?cXJZQUc5Z3FDbnVZTUNEWVFkNUI4bW9SaVZCbjRPT1BEekYrZ0EwenI0MWR5?=
 =?utf-8?B?OUtKMnFKcWZuSmJQZGZoSWIzSHZHN3dibDM5cWV6NkgzTVErSTRVK3NMYmVi?=
 =?utf-8?B?aC8xbDZOS1NYdGhuYUdOdisvdEZ2b0t5QmRnNGtaTHgzdWdZVzJXSk5iSHg0?=
 =?utf-8?B?cGlBVVRWc2RPQ09zckxhdmJkb3ZObUpQN0NrU2pBbzVjRy9WVmE1NGllZVBS?=
 =?utf-8?B?RlpMY1ozV2Qzam9LQUptVXRxeWhVaXZwNmhHcjhSQnQ1bUJ0L2VjQWFVU01v?=
 =?utf-8?B?VzMzRmtrcjRuUE5sUGgwd1VQb0pZbzF3MU05dkRENXQzajdvTjlQVmh5MlJk?=
 =?utf-8?B?RHZ1QnBLUVZQdEJxRXdDb0JvRm9PWXl6TkhHMUo3dXdFMnVoMmpmMjUxenBT?=
 =?utf-8?B?NElhQUt4UmwxUlFPUTdZWmYzK0V6YW1mL3hlNGNvNWJjeHhFUVJoT29XTHFm?=
 =?utf-8?B?aGU1aTFiODg2ZEYzYmc4RlVPRHFTOGx5UkNtc0l6aVlKdkxNODg1dWFlR2pn?=
 =?utf-8?Q?UxzPuNKGRfz/DUAkGfQXKtk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B13705346737741B7F78D822EE5E7F8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa800ca7-682e-41eb-f376-08dafd82e300
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 20:46:22.2256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /cgqFGHIf+aO/1J6YW2UzaN2Lk6fh2m5GAVZMFv2nzMO5qIEVH/3NPEF9f0/mtO+f7XIXu3BcA3oV8RFZtKy7XeJcRlrIeNbJc2viW9HqFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6104
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIzLTAxLTIzIGF0IDExOjQ1ICswMTAwLCBGbG9yaWFuIFdlaW1lciB3cm90ZToN
Cj4gKiBEYXZpZCBIaWxkZW5icmFuZDoNCj4gDQo+ID4gT24gMTkuMDEuMjMgMjI6MjMsIFJpY2sg
RWRnZWNvbWJlIHdyb3RlOg0KPiA+ID4gVGhlIHg4NiBDb250cm9sLWZsb3cgRW5mb3JjZW1lbnQg
VGVjaG5vbG9neSAoQ0VUKSBmZWF0dXJlDQo+ID4gPiBpbmNsdWRlcyBhIG5ldw0KPiA+ID4gdHlw
ZSBvZiBtZW1vcnkgY2FsbGVkIHNoYWRvdyBzdGFjay4gVGhpcyBzaGFkb3cgc3RhY2sgbWVtb3J5
IGhhcw0KPiA+ID4gc29tZQ0KPiA+ID4gdW51c3VhbCBwcm9wZXJ0aWVzLCB3aGljaCByZXF1aXJl
cyBzb21lIGNvcmUgbW0gY2hhbmdlcyB0bw0KPiA+ID4gZnVuY3Rpb24NCj4gPiA+IHByb3Blcmx5
Lg0KPiA+ID4gU2hhZG93IHN0YWNrIG1lbW9yeSBpcyB3cml0YWJsZSBvbmx5IGluIHZlcnkgc3Bl
Y2lmaWMsIGNvbnRyb2xsZWQNCj4gPiA+IHdheXMuDQo+ID4gPiBIb3dldmVyLCBzaW5jZSBpdCBp
cyB3cml0YWJsZSwgdGhlIGtlcm5lbCB0cmVhdHMgaXQgYXMgc3VjaC4gQXMgYQ0KPiA+ID4gcmVz
dWx0DQo+ID4gPiB0aGVyZSByZW1haW4gbWFueSB3YXlzIGZvciB1c2Vyc3BhY2UgdG8gdHJpZ2dl
ciB0aGUga2VybmVsIHRvDQo+ID4gPiB3cml0ZSB0bw0KPiA+ID4gc2hhZG93IHN0YWNrJ3Mgdmlh
IGdldF91c2VyX3BhZ2VzKCwgRk9MTF9XUklURSkgb3BlcmF0aW9ucy4gVG8NCj4gPiA+IG1ha2Ug
dGhpcyBhDQo+ID4gPiBsaXR0bGUgbGVzcyBleHBvc2VkLCBibG9jayB3cml0YWJsZSBHVVBzIGZv
ciBzaGFkb3cgc3RhY2sgVk1Bcy4NCj4gPiA+IFN0aWxsIGFsbG93IEZPTExfRk9SQ0UgdG8gd3Jp
dGUgdGhyb3VnaCBzaGFkb3cgc3RhY2sgcHJvdGVjdGlvbnMsDQo+ID4gPiBhcw0KPiA+ID4gaXQN
Cj4gPiA+IGRvZXMgZm9yIHJlYWQtb25seSBwcm90ZWN0aW9ucy4NCj4gPiANCj4gPiBTbyBhbiBh
cHAgY2FuIHNpbXBseSBtb2RpZnkgdGhlIHNoYWRvdyBzdGFjayBpdHNlbGYgYnkgd3JpdGluZyB0
bw0KPiA+IC9wcm9jL3NlbGYvbWVtID8NCj4gPiANCj4gPiBJcyB0aGF0IHJlYWxseSBpbnRlbmRl
ZD8gTG9va3MgbGlrZSBzZWN1cml0eSBob2xlIHRvIG1lIGF0IGZpcnN0DQo+ID4gc2lnaHQsIGJ1
dCBtYXliZSBJIGFtIG1pc3Npbmcgc29tZXRoaW5nIGltcG9ydGFudC4NCj4gDQo+IElzbid0IGl0
IHBvc3NpYmxlIHRvIG92ZXJ3cml0ZSBHT1QgcG9pbnRlcnMgdXNpbmcgdGhlIHNhbWUgdmVjdG9y
Pw0KPiBTbyBJIHRoaW5rIGl0J3MgbWVyZWx5IHJlZmxlY3RpbmcgdGhlIHN0YXR1cyBxdW8uDQoN
ClRoZXJlIHdhcyBzb21lIGRlYmF0ZSBvbiB0aGlzLiAvcHJvYy9zZWxmL21lbSBjYW4gY3VycmVu
dGx5IHdyaXRlDQp0aHJvdWdoIHJlYWQtb25seSBtZW1vcnkgd2hpY2ggcHJvdGVjdHMgZXhlY3V0
YWJsZSBjb2RlLiBTbyBzaG91bGQNCnNoYWRvdyBzdGFjayBnZXQgc2VwYXJhdGUgcnVsZXM/IElz
IFJPUCBhIHdvcnJ5IHdoZW4geW91IGNhbiBvdmVyd3JpdGUNCmV4ZWN1dGFibGUgY29kZT8NCg0K
VGhlIGNvbnNlbnN1cyBzZWVtZWQgdG8gbGVhbiB0b3dhcmRzIG5vdCBtYWtpbmcgc3BlY2lhbCBy
dWxlcyBmb3IgdGhpcw0KY2FzZSwgYW5kIHRoZXJlIHdhcyBzb21lIGRpc2N1c3Npb24gdGhhdCAv
cHJvYy9zZWxmL21lbSBzaG91bGQgbWF5YmUgYmUNCmhhcmRlbmVkIGdlbmVyYWxseS4NCg==
