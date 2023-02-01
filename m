Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AB2686D12
	for <lists+linux-arch@lfdr.de>; Wed,  1 Feb 2023 18:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjBARco (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Feb 2023 12:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjBARcn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Feb 2023 12:32:43 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D977CCA7;
        Wed,  1 Feb 2023 09:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675272733; x=1706808733;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XhzD45G4KU5MJisHK+7k35dF9RbMu3Ll0PVQIfSHgE8=;
  b=gFa8jQ7uD2m6RJg2HFyI2xDRoYM/zSA0/qhKE3hNA7lFIZzbRiyvXOqD
   IouN+Rv8I8MMLQhJZaE8+tJhXyE84xeifmaVTnoPXgE504z5BcZLaQ9Ib
   llc7JGcemBqrLkMUcDlCJyZwuTHB6PlfZQh+CV29zpb8uKmSFS0nTjFEJ
   cF+f0Kn2Y5UGOGCP7wUY+lIGHsZYY9G+0zLnPPFYsaHj0vAEwMZguw9az
   tSwNZHoYGH/puy6bdZIuF2LJ+FWHXyorZfb9Fygw3sN+DN/OQlKGXwniH
   M6lqSJTmn0CjhEBeXiFHzT9ZsGXVo12U2DUyDKsMxJ/xVwUi8zhVTOeAH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="392791921"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="392791921"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 09:31:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="910384491"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="910384491"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 01 Feb 2023 09:31:54 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 09:31:54 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 1 Feb 2023 09:31:53 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Feb 2023 09:31:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IeAQXfuSt2/fjvHx1D72cHpCcvpB63V8BPiu6nmNE1UgZhjb+IH+X6iwa3B2VH4Qd05JnExv4E6dy3YIsVzcuBDh24RHmkP6/Bhs0z9JSzIvZgTPjXhrmeD0o4Aa9Tf9V76re6Vp0eKJWWzK9moLlw879CGdxHJ2D3oesk6R7abOUf2c1xaXy0L7d2JPfQhhjNQR80vQcSFiIGR56cL9ZkypytI1fYAU91iDyDQZwW75vLqIlAFiVysDSddoi+Md3um/H7Rqg41kX4S+LDlaCaoTzkQLaPskn4nF5uCZH3CkQZr0mww1u+qqE1ZwoFPenKHkL8s5lol2NGU92kVDWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhzD45G4KU5MJisHK+7k35dF9RbMu3Ll0PVQIfSHgE8=;
 b=YM94I3TY6c/qpIXYcR/sFHdyB2gB9dO+fqT1/0PwX0mcvs6iQojr8J+GcIJFJAv/kwHHdS2PVwV7TTvuK+Lw6f0XN1EFy6BidKCES/6x9b1mKpNkY5rjTZWpm4mbtAI5Yo4R6XD461FOQg6pMKlHeEaiXs6uH5Gap/yYeARnBwES0dKt4yESzFg4K0a0QconAArTcfRN+d7aam27LqIBHcnknM5Gn+qzhJudGTOHCUYEyZ+ebqEIpPN8vSBv6i3YTf+ShnnFPisl/M2sMoM2uYqbYTGhusWqDOsNvcvSeHs57KMOuiWyoFJLWvk74t1vbpJLMjHn9Sr2Kw6sq42UhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MN2PR11MB4758.namprd11.prod.outlook.com (2603:10b6:208:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.23; Wed, 1 Feb
 2023 17:31:51 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6043.038; Wed, 1 Feb 2023
 17:31:50 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
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
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v5 06/39] x86/fpu: Add helper for modifying xstate
Thread-Topic: [PATCH v5 06/39] x86/fpu: Add helper for modifying xstate
Thread-Index: AQHZLExN5TDZ+QdBu0eT1URJgicT/K66AGwAgABtHIA=
Date:   Wed, 1 Feb 2023 17:31:50 +0000
Message-ID: <095e9694a682fc47ebedd34fddb660319549d6bb.camel@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
         <20230119212317.8324-7-rick.p.edgecombe@intel.com>
         <Y9pGfsiG9am4HoTZ@zn.tnic>
In-Reply-To: <Y9pGfsiG9am4HoTZ@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MN2PR11MB4758:EE_
x-ms-office365-filtering-correlation-id: e754eecb-7696-4ca9-7d3a-08db047a33c4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OTcT8F5enelv0aL8OyMQ0KjvBaLOx9IMRpngBSbLISsxZ4ZzwAI8Z/rpx/AVMNRPHBW5lg4/5cDB+sXdBi8kPOIiMoI/g4E9SiJ+a49TTXXDVacSFiS59zuibmcYunc3MBfxgpoi0DIRBJDUQy6PXxBvWNAQ5D1ZDtcmjc5ewkKQrE3MbGuBBdEi5E+Rgyw5JfXB63mbmjtbykRuH7DeIYOMl8KJ0sJsPmMS43dP2UBpWNlhHhuhmAh+5lwQw3JSX5+KorUG/qv1qGebYviA7sbd5s/9DVCKeAtqQcTQN9P4JawQuu20c1TPewHBKsVz1S+OOzNQB8168JHi5QuzlQ/Tv7jqbNMMMgDA9mv7OqXvrvA22ezp2wwysgAMNBB56LTWzyELONOLYaetJbnrpdhJO8calFUqFLRsCoMafptgZszVFmBBf5aepqeqm6eS+iN6ocntvNEH0Atnj3gr4+Dd6InQsV8yb0LW+Cpf+yduTc5j7CvIx7nHB7h62GiIR4J2W4YRvSuDg8MP0W0A77oGbq4yXDHDf5qwufL19jHsUkZD19F+Tv3L4LDfCcqngV3MPZn/z///k7+5NEhtP6uaMF3U4s7cqa284XbqYXPRrAAUDjH6+wXPdVqzFbW4nNXcVeCvEHw8iN4zm3Y+X3FqPXys4R3AfbvmNkPQn5IZWAre+alTW6vmJj9Kl9G5w/K5Gx8Q1FfB6OIG0jtyuulKi2f5QEeDTI84rEfBiDk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199018)(26005)(6512007)(186003)(6506007)(478600001)(6486002)(2906002)(83380400001)(71200400001)(4744005)(86362001)(36756003)(316002)(5660300002)(8676002)(7406005)(54906003)(7416002)(82960400001)(41300700001)(8936002)(38070700005)(2616005)(4326008)(6916009)(66446008)(66946007)(122000001)(38100700002)(64756008)(66556008)(76116006)(91956017)(66476007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUM4R2NmNUVQcnF4ZEorOG9lSjlFU0JmZlFLNzJzMWRVYjA5MjBkZThvelBx?=
 =?utf-8?B?ZlIxMGIrVWtiZ3NIRVgvVDZ3dy84S2JmdUdQWSsyc3luN0o5UElCamVKMWVG?=
 =?utf-8?B?czFsKzFYTWtGQ2FkRVg3bXJ3NEN0MnhQdnE0Yi9ESkdCTFhkbEFOVm9MbE90?=
 =?utf-8?B?Tjltc1hEWlBNSHNiVmhqMmxmZXUvTWIvcnZmbndzR1pEQVRMYTVKT1ZYKzRX?=
 =?utf-8?B?Sng3SmJZK2RBWFVIVDR3V3g5TXhiSlB3c002bklEWlBIN25wbWpaa1J2eXc1?=
 =?utf-8?B?ZHpwY0NGOXhjUE50a0x0amU2Qm5WUXlnRFdoVFRoSWZ4V3hDS1VmNUY4TDdM?=
 =?utf-8?B?UEFoSFk5WTRlTVplOUs3Mmg5Qmlub1ZyUVFRQUxsRkpJbGh5VlBzZXp1bisz?=
 =?utf-8?B?dFZzMUJwSVRuNjcwekFvRXJoRGlEV1NTSEl0R05heWQ1UVFsTWRSdnRpZTl3?=
 =?utf-8?B?TDdBTlgxQXg1Z3pmNWVqUXk4RWtHb1ZpWlJBVGY1M3JNTjBUWGVkcXkvZkdI?=
 =?utf-8?B?bDBSZUI1TDdRQzdhRHU4MlMzTUxtRDU3WG51S0k1WTkvMnhYWm05YkxDbXFi?=
 =?utf-8?B?Zk9jRnowa3d6QkxseHI0bHlVOU93TmJyV2d3alpvc01tNWFlLzlaVlJnbWtQ?=
 =?utf-8?B?ay9OREdXbmlEc3Ria3pNNEs4V2YrS1hTZmxLVWVxM0xxSlBIQlZPSHJiK3pt?=
 =?utf-8?B?MG01eXAxaXVKKzR1UzgrZFg1alJEeDJsT0xGc2h6Q1o4a3JQNVJsREFtcGhN?=
 =?utf-8?B?THkrK0FNQ3BLS0FFeC8rVVloNUx3Y1hkMGFlbDFBWWpWUWM0QXF2Y1lqNGhT?=
 =?utf-8?B?ME02bm1zMzhNM1o1UmhQdDlvNURtWEVoeEZLL3dxRi82V0xGZk1LcnptK3Bw?=
 =?utf-8?B?YXZnWW10cHpqNnRZWjlTeVlTTVJsbUpQbk9tWGltbWpvallkVkFBSE05dndV?=
 =?utf-8?B?L2FRWXY5bU5YNEJaeURER3JUR3VVOGsxNjJUSUl6cWtnQ3U0Mk15WGU0d2d3?=
 =?utf-8?B?WGVCbktQaVI1amRDdk53Vk85enQvRE1BckxJYlp0Q040VURkWmZkSU9kOE9V?=
 =?utf-8?B?WUNDeWpRYzQ5VVdUYW9KWTd1aDNOT3NGaEljckZ5aUp6clF6ZTlwNnl6TEM2?=
 =?utf-8?B?YllsbDdyTmk2U1RJeEtMQUNURXVCcUc0MkVsczdiMHVMb0VTdVlGVGVPMUlI?=
 =?utf-8?B?UHVTT3JSODBjeFB6V1R0R25neGtOTDNHbDJWazhOMmlHMWFwSklLTVBwQWor?=
 =?utf-8?B?Y21BNDRRK1VBYVZuMmdlNENLVTZEZkZFQ1RFMTRkc1NEN2FFMGxHUmRXWEJG?=
 =?utf-8?B?S1ZTY3QrRUtzTWtMWVhGYlF1R0tPWE02MVVUTnJkUWtmSzA0UDNFWDVvN1dw?=
 =?utf-8?B?cmJGVVZxb09EeCt3YzQwbUtNUW1ud3YwTTVKVE9FbHNMWU9PWFRNc1Nib08w?=
 =?utf-8?B?WENsRVMrbi8zS3BYZWlPeWtXc05TdlFadzVIRzY5SUg3aWc4bURscU42d25K?=
 =?utf-8?B?UWgwckovck1jVlZuMFRxZ0lOZEh6OUJ0cERSdDYxVGtyaFJ6WS9HZEMreUlv?=
 =?utf-8?B?bFFVdm9JazNXTmdGdks5Tlp0TEpPVWxtQlczOXIvaG5sRktoVjBwK3dOUXIz?=
 =?utf-8?B?cUtla08wRG95SGVsVW41ekVQRExrdUZPRXJCNzlvWW1WL1QzejhzbmV2QVc2?=
 =?utf-8?B?ZDBYV2JLb2J1MSs4MDc5NG9qbVlYR1h1MUJtTGFxZDZ6eEpBNmZFZ3JrYlZh?=
 =?utf-8?B?NDNIY0x2VTNvMWJtbTVxZDNCVmcyTDRsVkRLa3M4MWpNZnc5R01qMVFzLytP?=
 =?utf-8?B?Ym52UFZHYWNDNGZCTXdvQ0hzTjNCTjd3WUVSdkZ0UHAxUkExV3VWblRucmd5?=
 =?utf-8?B?Y2F2SkUvV0pXdXJmMjU4a21rZUNaWVQ4SjdBbjNsTHdwRUZDUE5acmFJOUZZ?=
 =?utf-8?B?YjVyVStrRjROQ1RnMndPVmQrV29KbUVDT2l6LzBoK0VnL1U1OUw5K0pMR0Ju?=
 =?utf-8?B?dkozR2J0M04reHZsbW1CTU9PR0I2cm9zNWhtVkY0RjBHT1FxVHZNcDcxdTZN?=
 =?utf-8?B?bmYvbFhXNHZUZ1NkRERSa3VodVlub1k3emZmWjVFMmQybHZBZ3lLS0ZDZVY1?=
 =?utf-8?B?T1hLaFpvcnlmeHBZVUNGNGo0ei9qbmxac1BLWjdTR1k1Z1NtZlVNNzJjQndv?=
 =?utf-8?Q?l71Yxu7wFRwQajKTmse5ccU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A21EC43860DBE149BE7071A18688583F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e754eecb-7696-4ca9-7d3a-08db047a33c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 17:31:50.3624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rlAZD+BPzTIO6TuCzYwYLjHHMgIx1olaavZWb27cwLOAuRVO8TSI4jyv2cXoedwHMwawhX8V+Y9jWBCWzQPxIT3pvxMDGypQsWr6l6j+J28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4758
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gV2VkLCAyMDIzLTAyLTAxIGF0IDEyOjAxICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFRodSwgSmFuIDE5LCAyMDIzIGF0IDAxOjIyOjQ0UE0gLTA4MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+ICt2b2lkIGZwcmVnc19sb2NrX2FuZF9sb2FkKHZvaWQpDQo+ID4gK3sN
Cj4gPiArICAgICAvKg0KPiA+ICsgICAgICAqIGZwcmVnc19sb2NrKCkgb25seSBkaXNhYmxlcyBw
cmVlbXB0aW9uIChtb3N0bHkpLiBTbw0KPiA+IG1vZGlmeWluZyBzdGF0ZQ0KPiA+ICsgICAgICAq
IGluIGFuIGludGVycnVwdCBjb3VsZCBzY3JldyB1cCBzb21lIGluIHByb2dyZXNzIGZwcmVncw0K
PiA+IG9wZXJhdGlvbiwNCj4gPiArICAgICAgKiBidXQgYXBwZWFyIHRvIHdvcmsuIFdhcm4gYWJv
dXQgaXQuDQo+IA0KPiBJIGRvbid0IGxpa2UgY29tbWVudHMgd2hlcmUgaXQgc291bmRzIGxpa2Ug
d2UgZG9uJ3Qga25vdyB3aGF0IHdlJ3JlDQo+IGRvaW5nLiAiQXBwZWFyIHRvIHdvcmsiPw0KDQpJ
IGNhbiBjaGFuZ2UgaXQuIFRoaXMgcGF0Y2ggc3RhcnRlZCB3aXRoIHRoZSBvYnNlcnZhdGlvbiB0
aGF0IG1vZGlmeWluZw0KeHN0YXRlIGZyb20gdGhlIGtlcm5lbCBoYWQgYmVlbiBnb3R0ZW4gd3Jv
bmcgYSBjb3VwbGUgdGltZXMgaW4gdGhlDQpwYXN0LCBzbyB0aGF0IGlzIHdoYXQgdGhpcyBpcyBy
ZWZlcmVuY2luZy4gU2luY2UgdGhlbiwgdGhlIGZhbmN5DQphdXRvbWF0aWMgc29sdXRpb24gZ290
IGJvaWxlZCBkb3duIHRvIHRoaXMgaGVscGVyIGFuZCBhIGNvdXBsZQ0Kd2FybmluZ3MuDQoNCg==
