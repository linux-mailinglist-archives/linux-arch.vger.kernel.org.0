Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BE9748C2B
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jul 2023 20:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjGESpz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jul 2023 14:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjGESpw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jul 2023 14:45:52 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7915A1737;
        Wed,  5 Jul 2023 11:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688582747; x=1720118747;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xnhopZDZTaoGQez/FKfZdk/VJuVwli4i2cOezyhsWC8=;
  b=ZOn0LXm6fvPw/YI2tP+VuceITuupMOAnNigq6aZNJff/pf6U0tmEpIkn
   G6reNDg1ndvGHoN24e1qMapyT0VysRF8QE03frCn5FZdMBasISDHGqmP+
   THvYNhvXDA50sjAPQH9kdr4LTU/CaMRrgxp4FridzCM9bnGt6Y5jnzfE/
   ojtJCcT1AhQY1QbcwxiehrxMAOyvDovuq9WkeAKID326BVk7SaRS1IQ4c
   DxCSFlKXbuAxPspIYqTYt4SKPBiN3l+cA2k2IHyJziy9RSM8gEid29Wff
   nr++7qfMGHdo/846bGKKrXH8EFnvKbtr4BA2j67Olt3ipOiJTjtuUrRGx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="394170110"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="394170110"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 11:45:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="863820800"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="863820800"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 05 Jul 2023 11:45:43 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 11:45:42 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 11:45:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 5 Jul 2023 11:45:42 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 5 Jul 2023 11:45:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFgEFbcJec6vd7XW1MJzoowru2WbwIZvSrb+vpRKkxXh3MsilCDYdv0UcZFwZeCJDiRhHROUwCXkhCRo69XtvmXMntTBoOnU05mMMBwbcs5dAQ6yvvegZZiOWa2FCJcCqDtZOHG28BE2Z94itL7TrdQD5Q3lvMCnuS8sySW1nW7uPEI7p4JOCuA/VuTmkwqg1NsNg8psMfqvpbIt4pJoO7LueiZ3dqWysgmPbHdOceqV8xOcMxg4B6Gg6gQFXb2tyPdnHiQs7ts87WrIie4T73hrYqIww2EJOPvwHzOmmRsa7vopyPJGisE6LCFIB5cggzTExd3nM8z/MGsRKP4bJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnhopZDZTaoGQez/FKfZdk/VJuVwli4i2cOezyhsWC8=;
 b=ZV91mX1P8/ZcGaW951zmOs6fdrk9aFOgrrJN8skjucRGprEIXcreb5frWs+8yBxsKjQI0VZlRUlPopqGV4Jo1SuUXoiz9aZ53Lhb+PDCzGJkYw2kWUwYiPbFarZqUDTl1F9FeJWa1+m+KKNGDFwfTZpY9NArD3aFW478eDkS5wv6ndaNPDplmlNqWzjpbJ6iid6/EDtd4lMuAJ/Xa0tc1zfc5DgkDtEL0dCqga3mW2GD1kQ/7hSRvRREq5umyazf7XKecxLUA1xxoe3SSqcGMsWOPvhvrr662UF/TrGu6Xn6VAVfQ31cJt+Eg5MkqxAfEtgQHqjYluC45vL63SFisg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB5976.namprd11.prod.outlook.com (2603:10b6:408:17c::13)
 by PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 18:45:38 +0000
Received: from LV2PR11MB5976.namprd11.prod.outlook.com
 ([fe80::1a0a:44f8:c653:5b00]) by LV2PR11MB5976.namprd11.prod.outlook.com
 ([fe80::1a0a:44f8:c653:5b00%6]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 18:45:38 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "Lutomirski, Andy" <luto@kernel.org>
CC:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Thread-Topic: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Thread-Index: AQHZnYvD++9jHqJtDEOZ5j0eN4/f+6+IoOQAgAALyMOAACwFgIAAIG6AgAAMtoCAACGsAIAA96CAgABofQCAB1K5gIAAhUGAgAEVRoCAAKx+AIABDK+AgAB6bICAAPF/AIAAZrmAgAAVNICAAG62AIAKh/oAgATXZwCAAZabAIADLBsA
Date:   Wed, 5 Jul 2023 18:45:38 +0000
Message-ID: <eda8b2c4b2471529954aadbe04592da1ddae906d.camel@intel.com>
References: <ZJFukYxRbU1MZlQn@arm.com>
         <e676c4878c51ab4b6018c9426b5edacdb95f2168.camel@intel.com>
         <ZJLgp29mM3BLb3xa@arm.com>
         <c5ae83588a7e107beaf858ab04961e70d16fe32c.camel@intel.com>
         <ZJQR7slVHvjeCQG8@arm.com>
         <CALCETrW+30_a2QQE-yw9djVFPxSxm7-c2FZFwZ50dOEmnmkeDA@mail.gmail.com>
         <ZJR545en+dYx399c@arm.com>
         <1cd67ae45fc379fd82d2745190e4caf74e67499e.camel@intel.com>
         <ZJ2sTu9QRmiWNISy@arm.com>
         <e057de9dd9e9fe48981afb4ded4b337e8a83fabf.camel@intel.com>
         <ZKMRFNSYQBC6S+ga@arm.com>
In-Reply-To: <ZKMRFNSYQBC6S+ga@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB5976:EE_|PH0PR11MB5095:EE_
x-ms-office365-filtering-correlation-id: 7a66d84e-0922-43a4-2b45-08db7d8806dd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q3Fea+Sw4WsSlSYYaNxHhBK2gzRungbMiz9p6wy7m4Y/Rn/i5rX6b4e2On3F3VVwbV2oGwA9/LUt4s7SfII3RuEY5St0GDDSj75EhmEdNOI2PM/UqsI0O9f6RO9nusIEMCzd3CNDY4R0mO9jO1/RJVBqzNDP0Wq/zoQu2m8ErTeuagpFowdQfa8aCVZTQQzf4GyOHM+NF13D+duxgY20dHjSMhsRgL2M8V5qOHyYVGTCtLMgLqEanXl9l076mb3amv/tiIfvHYrgqg/hphZ+eqTVb6Z+snR8ipkv/vlayhTSCFTIw5CQSE5MCgQdatA41jOLAobvoOdjdKa/nd7am94Cbxee86s6sjCR6LJ8xtX752E2MHYKU4zDP7VGDkvKtWE7juvSpQCs+Ie5Y8HtqEdeAWv17g3BmXptSopsUBpmpFIMOrNY03mmSG2vO+dByR6BWjj70QRgV4vrmxKjjF78x/vLkwiw4464PRciE0JxlQJ7x7nsmvv6gY5ZGQP91rNSpmUUYzjzLhakIr0tRqgwyBykF2vAKoqN9HbsLJozrc9ivd4oUgqlaBbLO3dJrWK36ZbilRxucuEvBXpgVxb3qkVR71V58ugbEUbfZshRj7K35WRBXO0X6NbhDIDJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB5976.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199021)(6486002)(7406005)(478600001)(5660300002)(7416002)(66476007)(82960400001)(4326008)(26005)(66946007)(186003)(86362001)(91956017)(76116006)(66446008)(6512007)(64756008)(36756003)(2616005)(6506007)(2906002)(66556008)(71200400001)(8676002)(38070700005)(316002)(8936002)(83380400001)(38100700002)(41300700001)(66899021)(122000001)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGYyYi91TFRJMUZuK0pvajFQRGFPaWxrekwxZDAwbVgwTEhhYXlBc3duOWdk?=
 =?utf-8?B?NWRMSExWNXk3NzZPaW82K25DeG00VTJ5dTN1NDk5aS9zdGU0Y2dKZ1dwL01U?=
 =?utf-8?B?YjFLeHdGTFoxbmIxV3U4bmZPR2lJNFlvRW9TcklCVTNjelhrcVB3YU1uT3ZC?=
 =?utf-8?B?MTNGMFM4QjZUQ1BxQSsxZ3A0OW9aVFRoNytzSC9XcDQrcUpKOWNEbTlFMVdZ?=
 =?utf-8?B?Mm9PcGZFdDdTUjNwUVN2bmpNMEM1VjBjQ2doRVhQbXlQVnNvV0tORlJ4RElm?=
 =?utf-8?B?M0lud2hsemtUSVBiaUw4UXJ6MmxBVDR2amZFUkdTQ254Z0lrM08wUVl6NFZM?=
 =?utf-8?B?MmNyR3VmZmVpRzZYVHFRS1UzOWgzd05hVTJMMjcyK1FhZmhMbVFKMnM3aXFC?=
 =?utf-8?B?TkV2S0F5ajkxZUVPVzVML1YwdFA4VTFMM25nQU0vUWl6dGx6SGVYTitIT2li?=
 =?utf-8?B?bTJDR0t1RlZ4K3U0YUdSSWVkYWtOd1NZb0FoM0c1dlhJSXFSQThCUEpDSVFQ?=
 =?utf-8?B?bUs5VnMxV09Xd2Z0QmJXZGlKVVFRSFpablFXbWlMUlR1dlc3LzhrZHVJa3J6?=
 =?utf-8?B?MUZ6Ky9FRExZMk0vVmhWb1pOam13VnIySWQ5UjVWa21DVlZFYVJaMTMxNXZC?=
 =?utf-8?B?M3BaSWR6eHlWRW45VTNLN3BrRnNhSXdrcHhzZlZURW1ZRlVqTmJSR1Z5NHV0?=
 =?utf-8?B?RVpRcllEZXNQY3RHVC9NVVBIbkpqNlR4bzc1YzFjaEVyREdra2g4bkNmaElO?=
 =?utf-8?B?L2dkWjhrMmx2cmt4M1VtQnozcS81SDBndWt4QU1mejJJRXkvcDZpbWUzUHpI?=
 =?utf-8?B?djV3b3dvd1lpV2hMUUJKNTIybTkxN3grYi9POGl5M2paUlpLSko5b3NrbVZz?=
 =?utf-8?B?VGRpMDNRZDFDdUlManVlRkV3M0Q4TEI0ZTNuRmk5NHdST1dVOCtDaFkvamFK?=
 =?utf-8?B?TjVOODc2MTdQUE1jd3J0MzJoMzczaUNTRlNOQ1ZzYnVvWVVnYWJyazBNWDNq?=
 =?utf-8?B?YytodUx4b0pxMEtFYnFCQ3lKYlBxSFZwdkRXbnQveWFmY0xPeEJmekZIVmJO?=
 =?utf-8?B?QXU3Nmc5TFlHaTlXV3dZY2dsUC9ONEJJdUN2Mzg2MnF5VVJSR0ZXUjNmUy9o?=
 =?utf-8?B?NmJBRW1xdlRVbGl2NFJySnVvdjBybUdhS0g0aVE5bTZRNWtzQkZkRElkYUZ0?=
 =?utf-8?B?SDM1RDAxYUpnTEpRVGMxSHphRnJiRkRHU0NtK3RtbnNhRHV5SkdOVTZoYlIz?=
 =?utf-8?B?QXV0RURyZXgyNnJCVUo2UVc0RzJ1bE1rOGR5a0pzRWVRZEt2eFEzeGdtVjA0?=
 =?utf-8?B?NTNUd1RoUml0STFnd0Q1VTRGdjRiTG1UTTNOVkV2SHZqdUtoUXZhVUhEVy9p?=
 =?utf-8?B?bkREU3lJNklDMUhwdlBJM1JDRzJNVGNyQk9qaTYrUy81TGVESW4xenJBNUVo?=
 =?utf-8?B?RHE4NkZreUFDRTlubWpaK1dMeDAxemU3Q1Z3YkdBbVJaTjhnTFV5VnhEc1dD?=
 =?utf-8?B?ZGhrOGhQdEFwVExNQkZGaHVjLzBwL0tkeTdydUlDZ2tmek1lcWZycXpRdTRk?=
 =?utf-8?B?VFVJS2V4OHplc3BxMnJraERmMmhvOE1UTlVuZ0cyeXUvd0tBaktjOXdaVnNF?=
 =?utf-8?B?ZFBKdHZvZ3JlVW5BaTE5N016d2V6eCtGcC9YUTcwRXZuZGM5bmxMbmV3TFpK?=
 =?utf-8?B?NUdjQjIxenFSeW8zTzFUNFU5OGdJTjNUdzZsMG9DWmh4ak1yNWwxbnZFZHlx?=
 =?utf-8?B?aytnTUZNd0Y0ZG9FRUVEc1ExUWNlL0dDc25pclpmWnBIbTY3Ry94QjNXNmpn?=
 =?utf-8?B?ZXdXT095YU5Dc0xmZm4yWFJyN2g0a2VyYjF2ajVZRHVHNmxacnZCYXZUbkly?=
 =?utf-8?B?QWdUNFkrZVd2dnpPZ2FSMjVSZHlETDNqMk1oVVBCVUIrelFpcEl2VG1KUWxq?=
 =?utf-8?B?dmdGVFdBTkFlVTZkb2J2TjdNYjE5cW5qeVBZWUg4b3pXQzV3Tlk1Z2ZnZnFj?=
 =?utf-8?B?U0dCWXNNQ2JaZi9neTNwT3M5cE50WkE3NE84WjlrT1U2VmhSclNodG83SDlQ?=
 =?utf-8?B?M1hxdjBvZDZ5NkF5YVo2RXFvRlBGQktKVnhqZmdDcUUzdVRXU3lZcU9DR2Jo?=
 =?utf-8?B?Vmh2MWpwbU96VzVvaXFOd3l5SE1DQlEzdGZaQXlSRjFHK2xiYnIwUW9RNytu?=
 =?utf-8?B?aWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9560172F2EDBE845BEFBAFBA4F59C1FF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB5976.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a66d84e-0922-43a4-2b45-08db7d8806dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 18:45:38.7045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5w1YP73eV1WTsw/zKquRK+oD9Vbuj+0AFmgaK/MJ8oH5asZugaKKFMS+3os+yMcAnltoDsozDJkoke9p3eXX8rY5xWABmjDf43ty77r109Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5095
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIzLTA3LTAzIGF0IDE5OjE5ICswMTAwLCBzemFib2xjcy5uYWd5QGFybS5jb20g
d3JvdGU6DQo+IENvdWxkIHlvdSBzcGVsbCBvdXQgd2hhdCAidGhlIGlzc3VlIiBpcyB0aGF0IGNh
biBiZSB0cmlnZ2VyZWQ/DQo+IA0KPiBpIG1lYW50IGp1bXBpbmcgYmFjayBmcm9tIHRoZSBtYWlu
IHRvIHRoZSBhbHQgc3RhY2s6DQo+IA0KPiBpbiBtYWluOg0KPiBzZXR1cCBzaWcgYWx0IHN0YWNr
DQo+IHNldGptcCBidWYxDQo+IMKgwqDCoMKgwqDCoMKgwqByYWlzZSBzaWduYWwgb24gZmlyc3Qg
cmV0dXJuDQo+IMKgwqDCoMKgwqDCoMKgwqBsb25nam1wIGJ1ZjIgb24gc2Vjb25kIHJldHVybg0K
PiANCj4gaW4gc2lnbmFsIGhhbmRsZXI6DQo+IHNldGptcCBidWYyDQo+IMKgwqDCoMKgwqDCoMKg
wqBsb25nam1wIGJ1ZjEgb24gZmlyc3QgcmV0dXJuDQo+IMKgwqDCoMKgwqDCoMKgwqBjYW4gY29u
dGludWUgYWZ0ZXIgc2Vjb25kIHJldHVybg0KPiANCj4gaW4gbXkgcmVhZGluZyBvZiBwb3NpeCB0
aGlzIGlzIHZhbGlkIChhbmQgd29ya3MgaWYgc2lnbmFscyBhcmUgbWFza2VkDQo+IHN1Y2ggdGhh
dCB0aGUgYWx0IHN0YWNrIGlzIG5vdCBjbG9iYmVyZWQgd2hlbiBqdW1waW5nIGF3YXkgZnJvbSBp
dCkuDQo+IA0KPiBidXQgY2Fubm90IHdvcmsgd2l0aCBhIHNpbmdsZSBzaGFyZWQgc2hhZG93IHN0
YWNrLg0KDQpBaCwgSSBzZWUuIFRvIG1ha2UgdGhpcyB3b3JrIHNlYW1sZXNzbHksIHlvdSB3b3Vs
ZCBuZWVkIHRvIGhhdmUNCmF1dG9tYXRpYyBhbHQgc2hhZG93IHN0YWNrcywgYW5kIGFzIHdlIHBy
ZXZpb3VzbHkgZGlzY3Vzc2VkIHRoaXMgaXMgbm90DQpwb3NzaWJsZSB3aXRoIHRoZSBleGlzdGlu
ZyBzaWdhbHRzdGFjayBBUEkuIChPciBhdCBsZWFzdCBpdCBzZWVtZWQgbGlrZQ0KYSBjbG9zZWQg
ZGlzY3Vzc2lvbiB0byBtZSkuDQoNCklmIHRoZXJlIGlzIGEgc29sdXRpb24sIHRoZW4gd2UgYXJl
IGN1cnJlbnRseSBtaXNzaW5nIGEgZGV0YWlsZWQNCnByb3Bvc2FsLiBJdCBsb29rcyBsaWtlIGZ1
cnRoZXIgZG93biB5b3UgcHJvcG9zZWQgbGVha2luZyBhbHQgc2hhZG93DQpzdGFja3MgKHF1b3Rl
ZCB1cCBoZXJlIG5lYXIgdGhlIHJlbGF0ZWQgZGlzY3Vzc2lvbik6DQoNCk9uIE1vbiwgMjAyMy0w
Ny0wMyBhdCAxOToxOSArMDEwMCwgc3phYm9sY3MubmFneUBhcm0uY29tIHdyb3RlOg0KPiBtYXli
ZSBub3QgaW4gZ2xpYmMsIGJ1dCBhIGxpYmMgY2FuIGludGVybmFsbHkgdXNlIGFsdCBzaGFkb3cg
c3RhY2sNCj4gaW4gc2lnYWx0c3RhY2sgaW5zdGVhZCBvZiBleHBvc2luZyBhIHNlcGFyYXRlIHNp
Z2FsdHNoYWRvd3N0YWNrIGFwaS4NCj4gKHRoaXMgaXMgd2hhdCBhIHN0cmljdCBwb3NpeCBjb25m
b3JtIGltcGxlbWVudGF0aW9uIGhhcyB0byBkbyB0bw0KPiBzdXBwb3J0IHNoYWRvdyBzdGFja3Mp
LCBsZWFraW5nIHNoYWRvdyBzdGFja3MgaXMgbm90IGEgY29ycmVjdG5lc3MNCj4gaXNzdWUgdW5s
ZXNzIGl0IHByZXZlbnRzIHRoZSBwcm9ncmFtIHdvcmtpbmcgKHRoZSBzaGFkb3cgc3RhY2sgZm9y
DQo+IHRoZSBtYWluIHRocmVhZCBsaWtlbHkgd2FzdGVzIG1vcmUgbWVtb3J5IHRoYW4gYWxsIHRo
ZSBhbHQgc3RhY2sNCj4gbGVha3MuIGlmIHRoZSBsZWFrcyBiZWNvbWUgZG9taW5hbnQgaW4gYSB0
aHJlYWQgdGhlIHNpZ2FsdHN0YWNrDQo+IGxpYmMgYXBpIGNhbiBqdXN0IGZhaWwpLg0KDQpJdCBz
ZWVtcyBsaWtlIHlvdXIgcHJpb3JpdHkgbXVzdCBiZSB0byBtYWtlIHN1cmUgcHVyZSBDIGFwcHMg
ZG9uJ3QgaGF2ZQ0KdG8gbWFrZSBhbnkgY2hhbmdlcyBpbiBvcmRlciB0byBub3QgY3Jhc2ggd2l0
aCBzaGFkb3cgc3RhY2sgZW5hYmxlZC4NCkFuZCB0aGlzIGF0IHRoZSBleHBlbnNlIG9mIGFueSBw
ZXJmb3JtYW5jZSBhbmQgbWVtb3J5IHVzYWdlLiBEbyB5b3UNCmhhdmUgc29tZSBmb3JtYWxpemVk
IHByaW9yaXRpZXMgb3IgZGVzaWduIHBoaWxvc29waHkgeW91IGNhbiBzaGFyZT8NCg0KRWFybGll
ciB5b3Ugc3VnZ2VzdGVkIGdsaWJjIHNob3VsZCBjcmVhdGUgbmV3IGludGVyZmFjZXMgdG8gaGFu
ZGxlDQptYWtlY29udGV4dCgpIChtYWtlcyBzZW5zZSkuIFNob3VsZG4ndCB0aGUgc2FtZSB0aGlu
ZyBoYXBwZW4gaGVyZT8gSW4NCndoaWNoIGNhc2Ugd2UgYXJlIGluIGNvZGUtY2hhbmdlcyB0ZXJy
aXRvcnkgYW5kIHdlIHNob3VsZCBhc2sgb3Vyc2VsdmVzDQp3aGF0IGFwcHMgcmVhbGx5IG5lZWQu
DQoNCj4gDQo+ID4gPiDCoCB3ZQ0KPiA+ID4gwqAgY2FuIGlnbm9yZSB0aGF0IGNvcm5lciBjYXNl
IGFuZCBhZGp1c3QgdGhlIG1vZGVsIHNvIHRoZSBzaGFyZWQNCj4gPiA+IMKgIHNoYWRvdyBzdGFj
ayB3b3JrcyBmb3IgYWx0IHN0YWNrLCBidXQgaXQgbGlrZWx5IGRvZXMgbm90IGNoYW5nZQ0KPiA+
ID4gdGhlDQo+ID4gPiDCoCBqdW1wIGRlc2lnbjogZXZlbnR1YWxseSB3ZSB3YW50IGFsdCBzaGFk
b3cgc3RhY2suKQ0KPiA+IA0KPiA+IEFzIHdlIGRpc2N1c3NlZCBwcmV2aW91c2x5LCBhbHQgc2hh
ZG93IHN0YWNrIGNhbid0IHdvcmsNCj4gPiB0cmFuc3BhcmVudGx5DQo+ID4gd2l0aCBleGlzdGlu
ZyBjb2RlIGR1ZSB0byB0aGUgc2lnYWx0c3RhY2sgQVBJLiBJIHdvbmRlciBpZiBtYXliZQ0KPiA+
IHlvdQ0KPiA+IGFyZSB0cnlpbmcgdG8gZ2V0IGF0IHNvbWV0aGluZyBlbHNlLCBhbmQgSSdtIG5v
dCBmb2xsb3dpbmcuDQo+IA0KPiBpIHdvdWxkIGxpa2UgYSBqdW1wIGRlc2lnbiB0aGF0IHdvcmtz
IHdpdGggYWx0IHNoYWRvdyBzdGFjay4NCg0KQSBzaGFkb3cgc3RhY2sgc3dpdGNoIGNvdWxkIGhh
cHBlbiBiYXNlZCBvbiB0aGUgZm9sbG93aW5nIHNjZW5hcmlvczoNCiAxLiBBbHQgc2hhZG93IHN0
YWNrDQogMi4gdWNvbnRleHQNCiAzLiBjdXN0b20gc3RhY2sgc3dpdGNoaW5nIGxvZ2ljDQoNCklm
IHdlIGxlYXZlIGEgdG9rZW4gb24gc2lnbmFsLCB0aGVuIDEgYW5kIDIgY291bGQgYmUgZ3VhcmFu
dGVlZCB0byBoYXZlDQphIHRva2VuICpzb21ld2hlcmUqIGFib3ZlIHdoZXJlIHNldGptcCgpIGNv
dWxkIGhhdmUgYmVlbiBjYWxsZWQuDQoNClRoZSBhbGdvcml0aG0gY291bGQgYmUgdG8gc2VhcmNo
IGZyb20gdGhlIHRhcmdldCBTU1AgdXAgdGhlIHN0YWNrIHVudGlsDQppdCBmaW5kcyBhIHRva2Vu
LCBhbmQgdGhlbiBzd2l0Y2ggdG8gaXQgYW5kIElOQ1NTUCBiYWNrIHRvIHRoZSBTU1Agb2YNCnRo
ZSBzZXRqbXAoKSBwb2ludC4gVGhpcyBpcyB3aGF0IHdlIGFyZSB0YWxraW5nIGFib3V0LCByaWdo
dD8NCg0KQW5kIHRoZSB0d28gcHJvYmxlbXMgYXJlOg0KIC0gQWx0IHNoYWRvdyBzdGFjayBvdmVy
ZmxvdyBwcm9ibGVtDQogLSBJbiB0aGUgY2FzZSBvZiAoMykgdGhlcmUgbWlnaHQgbm90IGJlIGEg
dG9rZW4NCg0KTGV0J3MgaWdub3JlIHRoZXNlIHByb2JsZW1zIGZvciBhIHNlY29uZCAtIG5vdyB3
ZSBoYXZlIGEgc29sdXRpb24gdGhhdA0KYWxsb3dzIHlvdSB0byBsb25nam1wKCkgYmFjayBmcm9t
IGFuIGFsdCBzdGFjayBvciB1Y29udGV4dCBzdGFjay4gT3IgYXQNCmxlYXN0IGl0IHdvcmtzIGZ1
bmN0aW9uYWxseS4gQnV0IGlzIGl0IGdvaW5nIHRvIGFjdHVhbGx5IHdvcmsgZm9yDQpwZW9wbGUg
d2hvIGFyZSB1c2luZyBsb25nam1wKCkgZm9yIHRoaW5ncyB0aGF0IGFyZSBzdXBwb3NlZCB0byBi
ZSBmYXN0Pw0KTGlrZSwgaXMgdGhpcyB0aGUgdHJhZGVvZmYgcGVvcGxlIHdhbnQ/IEkgc2VlIHNv
bWUgcmVmZXJlbmNlcyB0byBmaWJlcg0Kc3dpdGNoaW5nIGltcGxlbWVudGF0aW9ucyB1c2luZyBs
b25nam1wKCkuIEkgd29uZGVyIGlmIHRoZSBleGlzdGluZw0KSU5DU1NQIGxvb3BzIGFyZSBub3Qg
Z29pbmcgdG8gYmUgaWRlYWwgZm9yIGV2ZXJ5IHVzYWdlIGFscmVhZHksIGFuZA0KdGhpcyBzb3Vu
ZHMgbGlrZSBnb2luZyBmdXJ0aGVyIGRvd24gdGhhdCByb2FkLg0KDQpGb3IganVtcGluZyBvdXQg
b2NjYXNpb25hbGx5IGluIHNvbWUgZXJyb3IgY2FzZSwgaXQgc2VlbXMgaXQgd291bGQgYmUNCnVz
ZWZ1bC4gQnV0IEkgdGhpbmsgd2UgYXJlIHRoZW4gdGFsa2luZyBhYm91dCB0YXJnZXRpbmcgYSBz
dWJzZXQgb2YNCnBlb3BsZSB1c2luZyB0aGVzZSBzdGFjayBzd2l0Y2hpbmcgcGF0dGVybnMuDQoN
Ckxvb2tpbmcgYXQgdGhlIGRvY3MgTWFyayBsaW5rZWQgKHRoYW5rcyEpLCBBUk0gaGFzIGdlbmVy
aWMgR0NTIFBVU0ggYW5kDQpQT1Agc2hhZG93IHN0YWNrIGluc3RydWN0aW9ucz8gQ2FuIEFSTSBq
dXN0IHB1c2ggYSByZXN0b3JlIHRva2VuIGF0DQpzZXRqbXAgdGltZSwgbGlrZSBJIHdhcyB0cnlp
bmcgdG8gZmlndXJlIG91dCBlYXJsaWVyIHdpdGggYSBwdXNoIHRva2VuDQphcmNoX3ByY3RsPyBJ
dCB3b3VsZCBiZSBnb29kIHRvIHVuZGVyc3RhbmQgaG93IEFSTSBpcyBnb2luZyB0bw0KaW1wbGVt
ZW50IHRoaXMgd2l0aCB0aGVzZSBkaWZmZXJlbmNlcyBpbiB3aGF0IGlzIGFsbG93ZWQgYnkgdGhl
IEhXLg0KDQpJZiB0aGVyZSBhcmUgZGlmZmVyZW5jZXMgaW4gaG93IGxvY2tlZCBkb3duL2Z1bmN0
aW9uYWwgdGhlIGhhcmR3YXJlDQppbXBsZW1lbnRhdGlvbnMgYXJlLCBhbmQgaWYgd2Ugd2FudCB0
byBoYXZlIHNvbWUgdW5pZmllZCBzZXQgb2YgcnVsZXMNCmZvciBhcHBzLCB0aGVyZSB3aWxsIG5l
ZWQgdG8gc29tZSBnaXZlIGFuZCB0YWtlLiBUaGUgeDg2IGFwcHJvYWNoIHdhcw0KbW9zdGx5IHRv
IG5vdCBzdXBwb3J0IGFsbCBiZWhhdmlvcnMgYW5kIGFzayBhcHBzIHRvIGVpdGhlciBjaGFuZ2Ug
b3INCm5vdCBlbmFibGUgc2hhZG93IHN0YWNrcy4gV2UgZG9uJ3Qgd2FudCBvbmUgYXJjaGl0ZWN0
dXJlIHRvIGhhdmUgdG8gZG8NCmEgYnVuY2ggb2Ygc3RyYW5nZSB0aGluZ3MsIGJ1dCB3ZSBhbHNv
IGRvbid0IHdhbnQgb25lIHRvIGxvc2Ugc29tZSBrZXkNCmVuZCB1c2VyIHZhbHVlLg0KDQpJJ20g
dGhpbmtpbmcgdGhhdCBmb3IgcHVyZSB0cmFjaW5nIHVzZXJzLCBnbGliYyBtaWdodCBkbyB0aGlu
Z3MgYSBsb3QNCmRpZmZlcmVudGx5ICh1c2Ugb2YgV1JTUyB0byBzcGVlZCB0aGluZ3MgdXApLiBT
byBJJ20gZ3Vlc3Npbmcgd2Ugd2lsbA0KZW5kIHVwIHdpdGggYXQgbGVhc3Qgb25lIG1vcmUgInBv
bGljeSIgb24gdGhlIHg4NiBzaWRlLg0KDQpJIHdvbmRlciBpZiBtYXliZSB3ZSBzaG91bGQgaGF2
ZSBzb21ldGhpbmcgbGlrZSBhICJtYXggY29tcGF0aWJpbGl0eSINCnBvbGljeS9tb2RlIHdoZXJl
IGFybS94ODYvcmlzY3YgY291bGQgYWxsIGJlaGF2ZSB0aGUgc2FtZSBmcm9tIHRoZQ0KZ2xpYmMg
Y2FsbGVyIHBlcnNwZWN0aXZlLiBXZSBjb3VsZCBhZGQga2VybmVsIGhlbHAgdG8gYWNoaWV2ZSB0
aGlzIGZvcg0KYW55IGltcGxlbWVudGF0aW9uIHRoYXQgaXMgbW9yZSBsb2NrZWQgZG93bi4gQW5k
IG1heWJlIHRoYXQgaXMgeDg2J3MgdjINCkFCSS4gSSBkb24ndCBrbm93LCBqdXN0IHNvcnQgb2Yg
dGhpbmtpbmcgb3V0IGxvdWQgYXQgdGhpcyBwb2ludC4gQW5kDQp0aGlzIHNvcnQgb2YgZ2V0cyBi
YWNrIHRvIHRoZSBwb2ludCBJIGtlZXAgbWFraW5nOiBpZiB3ZSBuZWVkIHRvIGRlY2lkZQ0KdHJh
ZGVvZmZzLCBpdCB3b3VsZCBiZSBncmVhdCB0byBnZXQgc29tZSB1c2VycyB0byBzdGFydCB1c2lu
ZyB0aGlzIGFuZA0Kc3RhcnQgdGVsbGluZyB1cyB3aGF0IHRoZXkgd2FudC4gQXJlIHBlb3BsZSBj
YXJpbmcgbW9zdGx5IGFib3V0DQpzZWN1cml0eSwgY29tcGF0aWJpbGl0eSBvciBwZXJmb3JtYW5j
ZT8NCg0KW3NuaXBdDQoNCg==
