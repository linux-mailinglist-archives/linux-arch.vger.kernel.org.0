Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F3F652A99
	for <lists+linux-arch@lfdr.de>; Wed, 21 Dec 2022 01:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiLUAqA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Dec 2022 19:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbiLUAp5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Dec 2022 19:45:57 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72FF1ADBB;
        Tue, 20 Dec 2022 16:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671583556; x=1703119556;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2R3uJ5cQoXJczSFTBvuZ+myvP6cYSHwe+vlN8X3Sjnc=;
  b=VsokIdc+EZGrB+z4EaTk4HgA+5EVKZ3LUt2sF5XvTtt9ZqkK1YdwCQzj
   VWstlkTBxlJQ5PLTITdBxlndaNfewyTuDUgsppbdFMhxJ8AdJ5KW04hPp
   weAehDP0T+2HXR5O+2Pkfjw7wNT6muR85iRZcW2wn4vLEHoOwWNJh9B/8
   kEY5z7qoxu5UPW83YaGlA+NUGsEDvgP9eMbFP3JbZ+nBt3rFKdU5UYPbj
   Yl4N4tYQCc7PgjDgb+LMf6vfJtP+og6PvWDzSS1Z484bY5043mIgfHll8
   efuvoJ7BWAFP1pNfpsMPAAGmx6eMCCzXfL76aP2gWvZR6aS+WpjYPRD1/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="307435205"
X-IronPort-AV: E=Sophos;i="5.96,261,1665471600"; 
   d="scan'208";a="307435205"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 16:45:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="896679890"
X-IronPort-AV: E=Sophos;i="5.96,261,1665471600"; 
   d="scan'208";a="896679890"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 20 Dec 2022 16:45:46 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 20 Dec 2022 16:45:46 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 20 Dec 2022 16:45:46 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 20 Dec 2022 16:45:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxpy5mH8WFkDAIDT9BXZFavtIb0cNN6C9q+8W3C+cuQD3fNARAl5F9QtE6X9JofWOGkbyuOCfRudk/lYg82s+wQUXdBj6QH9BDXQbnYOR5VziJakg3AkhasSNP5EaFkS2L5BbOcaMCv2TYXa1MvoTlcErOPwLPp8JVxZ62h0HCP3u4Th47BV7d4w7GJRXTUy4VwdON6fgC3W62j/0vvu+QqdAggqu91sTTaLDzfDpzFAkZqAJZ531FGyU5ojz0uPlq9PtLkfwxvlJTZR5aUdenTemmfojjchR5vjklcTdANW2YMJI+ziFNTvYoVcAxWcLCB+mc8f5lXE4eWNqG9ScA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2R3uJ5cQoXJczSFTBvuZ+myvP6cYSHwe+vlN8X3Sjnc=;
 b=M7eW4bg4NmSR+PHteUOVDAGfb+RctE7C4K0VSEiTPfAituRE/gIXvem08iPOKpUmvi88oPdwXlek97pGT82/uvnXmsZiyZQvyIZyCoyDq8TJlC6nZ7MLZ7zGRuvy4uWcUPOhwOodZobB4bCbUmdvAc2JALMEIdtaGZyIaoCEsCfuEDES5Rv6Or7HZTGJbW3+7MFYwps/e93ZmJ1PE0xKSTk+0E7aNZrcLXrRFL/h6xvk7G44NbHHABt4/qdBur8DnF8VqpAaVA35SlBTwGEpj5APd5vcK6lUC1SJ/DURDzc7oFcmy/BCZ+9Cll9chSYU41NmeaEqpGAIa8uC9Kanug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MW4PR11MB6691.namprd11.prod.outlook.com (2603:10b6:303:20f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 00:45:43 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff%5]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 00:45:43 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v4 05/39] x86/fpu/xstate: Introduce CET MSR and XSAVES
 supervisor states
Thread-Topic: [PATCH v4 05/39] x86/fpu/xstate: Introduce CET MSR and XSAVES
 supervisor states
Thread-Index: AQHZBq9RBkStIhaYNEWfAEq3cagmvK52wDEAgADdiwA=
Date:   Wed, 21 Dec 2022 00:45:43 +0000
Message-ID: <69ff1d29f7018f91a29b3b8d5e41e2940505c02a.camel@intel.com>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
         <20221203003606.6838-6-rick.p.edgecombe@intel.com>
         <Y6GdXvj2woHqG4qa@zn.tnic>
In-Reply-To: <Y6GdXvj2woHqG4qa@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MW4PR11MB6691:EE_
x-ms-office365-filtering-correlation-id: e23d5a3c-c140-4687-94f5-08dae2ecb0ea
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1GSCRL5jpyVdewyacGhAtb9rmajHDlKEkSDk/RunGFFpZgU3bbBq100vVcJdu04Z9ws30UhuuWqCxqpR0vv0ghrPeHM30DVLoX3XrHpIEtA9qtUR9xfW2YE+CvB2rZw7pNOe+rm3NJwGdl6O3Sp8CWqBnayUY0K01e21XHGVM+7opOHhFpwPi2X+Q4DrhN2N0Xg1T/PqsK/3RsR8jko9bGB1PDjoL4kqyZSmCGXjm103GlOBHdVrRvkRCn0u2JWiqw/gCuSmKrcGmB8rhom+f4kkm306poJN/PdqYMvEXUFo2vu/1BglTvLydCFdLNSHzd3sWnyHDJy/aOcOrWvQDD0rCAaR7qSoAUufIok7/GSvamPStYyEHPA8AjFFSoIU4Q70MDYh9SFC1qQxO9EX1N6kgArURgNdID9zEn53/IY2jq3ZhUlW8ePL7cFfRGHOVigZBUVDydfMxIhay/LSqNAIU3vrVoeGcMlqeO0zn60i9qiZyg4lxLdpXxVxZ+kHUwwiGNeZlBrYHk+uoq0SzpR4l5Ys3akoshx/FPdIdsHYMASEydvAl1G1LnQRXe7RM6uwh6tX9xVq+wE7PeWEsXYHjve+8BKDsNBZtVctrV7VHe0Age7RsrStsFaPcuk9C8CD9pwCHv9FqXEiaA66t8fw5d/2zYKH8ea++p2OeqOJCikycTlAD2yk6gmDjwHIoCm1z91Mlpr5QAxktexLmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(39860400002)(346002)(396003)(451199015)(8936002)(38100700002)(6486002)(71200400001)(36756003)(6506007)(4001150100001)(41300700001)(54906003)(2906002)(478600001)(4744005)(26005)(186003)(122000001)(5660300002)(6916009)(6512007)(316002)(7406005)(8676002)(7416002)(4326008)(2616005)(66446008)(91956017)(64756008)(86362001)(66946007)(76116006)(82960400001)(66556008)(66476007)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVVuSlVkZ3JhOFVXTWs4TTZXUklpRWZxc1NlYUs3ZzdzVnFrNzVoQllHaGRl?=
 =?utf-8?B?N3NQTzBib1BSbnJCRHFUMytLb1o1SGhWTHZBdUZTWkFvL2Njd2sxelpaUFd1?=
 =?utf-8?B?aStiZ2xqdzkxaFFjQVoyK29IZzhYNDRBT2lNdDVnRFlvR2laZ0l0blBXMXNZ?=
 =?utf-8?B?YkZ1ckZlVXgvajJOYUtRYUk4YmFoTFJzcEdyZzlNNkJ3dDRoTGJibEhMdnEw?=
 =?utf-8?B?cnJBMEJJQVgyUGRKWlZ0YkRrSXAvbVBzTzJJNkRoQWFiTlB1VDNZVlBkM1BE?=
 =?utf-8?B?bDhXSkpUWW1nZFJSeUEzeEwvQkNzTHJ2VG1UVW1LUnl4VXg0blUxaEJEZVoy?=
 =?utf-8?B?SE5Hd3NSTDJ3TWtWdE55dFNIdDRWWTdnNlE5SmRDei9rTldiS0ZiYURIdDli?=
 =?utf-8?B?ZlhXeURMTjJGNHZ1eCtKNW43eHBjcVpYVG82OHJNRlNvdS93cGN5Wk9ISGZX?=
 =?utf-8?B?bUR2ZHJpWEpiM2hsWGNaSkNIdHFKM1UzWkZqdHEvSWx4ZHFVR01BRGt5MG00?=
 =?utf-8?B?OUZHam5ld3UzV2RHeGE1WlBrbWVLa1NpaFFzbml5czdHTVJvUWtQeWx4bkNh?=
 =?utf-8?B?elV0L1NKRkRlUzlmK3VrRnR4Y0pFNlhjekcxSm9ydExIQkt5ZW81bGRZcWZw?=
 =?utf-8?B?a1BJMFFPd1dxbWszYmhUTEpSc0swN3ZvYzA2cWE4SEJBK3ZxeDVsT29KOG9K?=
 =?utf-8?B?Tzl2TVcrTnU1YTVSQ0R4Y1J6aFVoNEpTNEdwV0ZJZEQyUVpmZzJ2RXVvNElm?=
 =?utf-8?B?MldXWW8wK1pjcWptN1BKYWEybk5BM3hVTGtMQ0JVOENaam1rTDlvOTFBR2RR?=
 =?utf-8?B?QVpyQS8zaFpYT2ZlaXU0di9IWHlUdDJoUjl1OERIaWsrMUJ3T2FVZjZUdHRZ?=
 =?utf-8?B?NnlLSXdySDRoTlFkeFlHK2E3d2hlMzl5ZnhDS1IwWVRDdmJHbS8ybDZPKzQz?=
 =?utf-8?B?T0laMGJHTk5xVHJ3MWtpQmhIbDVtdmlIcWlUQktBRzVFZzNtL1pjQTFLdVJE?=
 =?utf-8?B?eUdLUERDRGNQSUpFUmlHaGpNZFVIKzczb1ZPYU5pWDE5SU8zR0o4ZVhMc1N5?=
 =?utf-8?B?czh5dFBHQXBLV3lOQmtoVWs5LzZ6VXdrUVB3U2xzTnMvS3AxRGljWXhkWUlk?=
 =?utf-8?B?cUFyQXdWYk8yMUpNR041UUZybU5BVUNxVnlrdHJqRWdmZFp2WXd5Z0VLRHg2?=
 =?utf-8?B?N1hodXhDVThpcmFqcm95aTZZVyszMDAxQnpGVVl3cmJRZFk0SDlXM0RmVmJh?=
 =?utf-8?B?K3dJNUdheWxlcml0bnczYWRISlNFd3hpQTJaY05nMmx3bzEyakVxQnV3TDlU?=
 =?utf-8?B?eXpCQzBISmRkMGpDMW5Rd0YwNDRwQ3RZZjkydEVMb1pIOUZ2YW5MS1BkSW1Y?=
 =?utf-8?B?UytPZUhNa3JyUlJ4eG9GWHkyMTVkRGdDOU5TdGlmcWhtOUlPZVdWbVdtSXMx?=
 =?utf-8?B?cnc2NGVhKzFud0RwbERIbWVKVHdFQ0V4WmdYYkFqekE4VkdERHEraEV6c1JU?=
 =?utf-8?B?a3ltMGFmT3JYdDlkTG01QTdWQTJRQVdYR1JrYll6cjZrSlY0SDEvSkE4WWNX?=
 =?utf-8?B?b1hpNDFjNHRFQzVxRWJJcXNzTEVzVVdJREw1eDlsRDA5elFaTVhMbkRWTzNm?=
 =?utf-8?B?N1d6UkpZRzJoRTFDNlV1cU9ueGFqcTZIM0Z3dkxZUWE2UnBOQkhmTklOUE5Y?=
 =?utf-8?B?QzJROHJ1TXVmQjZMcllUYmxDRkx5aDZUUzZZMGtXOTY5c2JPeWVpQkxpejQw?=
 =?utf-8?B?YVduZkhieDN3dUNCc2c1N2hhdnBuS0MzUkVPS3JneXQxWDNTeVBaaWdlTHdy?=
 =?utf-8?B?T0N4cmUwNXdJdkxoQU9WWUJGbnZLWEI2cXdaZEtTcGJVaTBTcCtYOG0vcFlQ?=
 =?utf-8?B?T0lRMzZCNlhFYkZ1a2ZOR1pzTmREWGltZHVCclhEY1QvOENxZXJlQUV0TTdi?=
 =?utf-8?B?aTYzTlh5NWE5ZDl3Nm1vY0xuTHlHQnRYT0tYcGFVZGcyWFBtTzY5N1pzS2pU?=
 =?utf-8?B?ajU4ZHM4dXJHbjl5ZHpta09MM2owSTUydmpIeWtWd2hOTGU0UkdaUlFGK0N5?=
 =?utf-8?B?L01EeG5DUVkySjN1NTh5aFFTaCtnUHNxZUc5RTQ5V3lFanFaT010T0MxaGlm?=
 =?utf-8?B?ZkU5MFRoMXVWTnZKWHlsckYwZTQvLzY2aWpoTC9qdlc5dzNCSjZKMDhjZDh3?=
 =?utf-8?Q?uJKo8rO4sc78paFF10G4H20=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66F499DE2C19254382BB70377156CA88@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e23d5a3c-c140-4687-94f5-08dae2ecb0ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2022 00:45:43.4200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nhyio5+AkW6lJHiIlVkCM/pQ5ovaGoLkvVHs5HqmSl4WFbfMuxy706Wksp/VynuP0ife6Y1vmB3U1VBttA5uK0GVWbUEQXIN+SHZPXMTDjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6691
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIyLTEyLTIwIGF0IDEyOjMyICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIEZyaSwgRGVjIDAyLCAyMDIyIGF0IDA0OjM1OjMyUE0gLTA4MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+IEBAIC0yNTIsNiArMjU0LDE0IEBAIHN0cnVjdCBwa3J1X3N0YXRlIHsN
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgdTMywqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBhZDsNCj4gPiDCoCB9IF9fcGFja2VkOw0KPiA+IMKg
IA0KPiA+ICsvKg0KPiA+ICsgKiBTdGF0ZSBjb21wb25lbnQgMTEgaXMgQ29udHJvbC1mbG93IEVu
Zm9yY2VtZW50IHVzZXIgc3RhdGVzDQo+ID4gKyAqLw0KPiA+ICtzdHJ1Y3QgY2V0X3VzZXJfc3Rh
dGUgew0KPiA+ICvCoMKgwqDCoMKgwqDCoHU2NCB1c2VyX2NldDvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoC8qIHVzZXIgY29udHJvbC1mbG93DQo+ID4gc2V0dGluZ3MgKi8N
Cj4gPiArwqDCoMKgwqDCoMKgwqB1NjQgdXNlcl9zc3A7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAvKiB1c2VyIHNoYWRvdyBzdGFjaw0KPiA+IHBvaW50ZXIgKi8NCj4gDQo+
IFBsZWFzZSBwdXQgdGhvc2Ugc2lkZSBjb21tZW50cyBvdmVyIHRoZSBtZW1iZXJzLCBsaWtlIHN0
cnVjdCBmcHN0YXRlDQo+IGRvZXMgaXQgaW4gdGhhdCBzYW1lIGZpbGUuDQoNClN1cmUsIHRoYW5r
cy4NCg==
