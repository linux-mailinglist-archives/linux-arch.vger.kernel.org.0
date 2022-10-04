Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BFB5F4C9A
	for <lists+linux-arch@lfdr.de>; Wed,  5 Oct 2022 01:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJDXY4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 19:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiJDXYq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 19:24:46 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DF55A892;
        Tue,  4 Oct 2022 16:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664925873; x=1696461873;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Gwqj7p8lMKDtOMnKViKbRH8+RUrJzl0pJY7bjVIrgfE=;
  b=RgsZbzEGy1LjMztu+63AO/Dz2ZRaor2mkUpC9uuAo+ED1pWDM0b8qT1E
   MLDlNp0ZWF3HIdVucICaCNx86zmdNeDjoTNvHjqLp/Axp8cEJJTHXrIe3
   ld2YaFs0Wy4tXAFrVlV3p67WylvfsMAL67J3j9+QJDhpTSqtORKg1LZeW
   XuubbydMibG9ecsuIGTft/jTWfrd0k3lme+TDbSICk6CHzVnIXACK4QtP
   c5BPgI4dOYvryRUBt4+2GDCcuKMJXXQwU0SAnUHbPol/M9aZADAtsJbBY
   VRir88SRdMDceitD6DJSl8qfG/fmTxWtENbfWapMke+72oCUxUZaRPEYO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="364972712"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="364972712"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 16:24:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="654976147"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="654976147"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 04 Oct 2022 16:24:31 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 4 Oct 2022 16:24:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 4 Oct 2022 16:24:31 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 4 Oct 2022 16:24:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evk1d+jxUDFoTWkz8v8D/xTReMOO55cAPDbTpnxphA0MwXWrcygy2ujnOqRgFVWiKobWqGfdzhWRJKRRnvekWKA2sd5jB/1mOcng8vBDvoZQIma+uBbwCMgBWQJEOkQjjSaoS/cF74bDI7zJOcga8aPcKoXHTzKjwsbX/mqnhPOVL5RFq4ieBfd/loz/pm+c7hUJil7SGtNTv3dTdSPDZuKYNCg0lGa1QHicOi2u7moM4rEvMC2DlTsefwDiEnkvB5NSo3NL8/3sRswIt82kBsLZhrPk04sygmPK0fkmbf8R1GJ8slb9y5HfUQjmr4cuPsQfsz3fP1S+RAyxdNF6qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gwqj7p8lMKDtOMnKViKbRH8+RUrJzl0pJY7bjVIrgfE=;
 b=NCE2OLThsJplfobYZLCwDiUJm/n97IKaJfsruKvkNfxH1DFXKQrk+QKCU0d6N4Y4pmUugu3LXwXIZkJsSMbWW0AiioRXji65VWgA+mlqRKjPcYorJgp0VqWB3Gzlg43GYdmCDKYANnk4WlQ7K+nCwYcHqZ5kSZ9oZhWoo3IgC+ICsn7A720FfHREdp5qXRYkmacAKJwVqS4Snhw+Ba19j9Hc1TuIvJOSohh0pTnEehX6wfD77ImPLlQR22RYAfNzO6xhddQ6ZQxM2yyvAhVqyK3loR0FRCEjsyqp/9GPMZTs0ZPm0fseOcSekcrIs0HxR+aCk0jGRdFsH540ubbebw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SN7PR11MB7116.namprd11.prod.outlook.com (2603:10b6:806:29b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Tue, 4 Oct
 2022 23:24:28 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.028; Tue, 4 Oct 2022
 23:24:28 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "hpa@zytor.com" <hpa@zytor.com>,
        "nathan@kernel.org" <nathan@kernel.org>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "babu.moger@amd.com" <babu.moger@amd.com>,
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
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v2 33/39] x86/cpufeatures: Limit shadow stack to Intel
 CPUs
Thread-Topic: [PATCH v2 33/39] x86/cpufeatures: Limit shadow stack to Intel
 CPUs
Thread-Index: AQHY1FMn8lBh+KlmckGpJ8Z/vQs/Tq39XyQAgAADPACAAE+7AIAAtm0AgABB7YCAAA5ogIAABFEAgAAHhACAACOKAA==
Date:   Tue, 4 Oct 2022 23:24:27 +0000
Message-ID: <8429968c22a9532a6855a8fd9e4dd0a7f2344408.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-34-rick.p.edgecombe@intel.com>
         <202210031656.23FAA3195@keescook>
         <559f937f-cab4-d408-6d95-fc85b4809aa9@intel.com>
         <202210032147.ED1310CEA8@keescook> <YzxViiyfMRKrmoMY@dev-arch.thelio-3990X>
         <ae5fea4b-8c33-c523-9d6d-3f27a9ae03d0@amd.com>
         <9e9396e207529af53b4755cce9d1744c0691e8b2.camel@intel.com>
         <YzycjLUVh/WhPtKa@dev-arch.thelio-3990X>
         <73904829-0BAC-41BA-BFD7-025B1645F698@zytor.com>
In-Reply-To: <73904829-0BAC-41BA-BFD7-025B1645F698@zytor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SN7PR11MB7116:EE_
x-ms-office365-filtering-correlation-id: 27dccb44-ac9b-4e8f-fe78-08daa65f9522
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7xO1H38BI+J/uX7j5yrkBo3zQl65RT/l5krvPjUjEX8U4Gf55Ia+S+J8/ljkvrnUJeF5Bw5Okm4JStGZTvwN80oDsRtoBhl4tAki4I/p+mukcquvwe0H8wS+aiJDR/hZYGPis3A2oZ3Qu+Ll+2HJhGxi6vq606KfezknCTbxnVGxpbMx8KIr6AwvnP3fmY+/Y6GEcdd6Qk3WsZxW8k1hvQris4AK5w2ZvPRVLDWglxUz0/PCiKaHeOxcXPzougDV3nP3rmsSNNMUeED5SjCqzV/bmudbAR+iiYYjSCG+D0rzHHtrGDg0RUsJPconU+CCQpU97MkVcjBnM5RZMW2/XX+HMaAiOcpZh5ZNBOUCiFo+G3i4vgbYdvFBhyzoZETYpdMdZu0WUuqfnc8yi9X5faIbbb5JeJYSOuykFElQWiGHDX8Vffb70uZ/HjWe8MSiCAdpZTUqMFPDGrdG1QSSqX4TELiEGMy4eY/H0NRUaaR15HP9kxeS5BGPJXL8phsczZIg8xvfrUG2uIJqHuuw/x6tGcg4zDUwFbFhiKQEz5BbGT99k+ExtXCVKwBrosnwOzM8V6LWA3KVPwpif7aOTNY565fwQQBj0NBdvTGSaHH55I1KQVLU5Si50xRyP8CP65j0pD0cyZJNuz5fNLP0mx8G0TEOu6WOUm5n1CiLUs5DA3b8Q6hhcT6h0YJVQG8Rm31OFoU3SvTHzqi3QYyMP7ygDUOOyc9yCvVz7vaJk36ubki3tkVlZCxx9sVkSG52D6vuk2z9HueoR5d19h6F8xDv2XXkz8Q7ZD+XUTI9SYA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(376002)(39860400002)(396003)(346002)(451199015)(38070700005)(82960400001)(6486002)(316002)(54906003)(110136005)(71200400001)(478600001)(8936002)(38100700002)(66556008)(122000001)(76116006)(8676002)(66476007)(66946007)(91956017)(64756008)(66446008)(4326008)(7406005)(36756003)(83380400001)(41300700001)(86362001)(53546011)(6512007)(26005)(2906002)(7416002)(5660300002)(6506007)(186003)(2616005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NSsvTi9CVEU4K243aVZUUzZnQ1I2aGRhKzU4UXBQNFBoalR6MlJJUHNHc3ZK?=
 =?utf-8?B?ZWsydWJBd3BvT1NFcndOMXZIdk5CTFpRTk1qaHd6NlgrY0hKcWtXaWhVTlZp?=
 =?utf-8?B?UjZRaUh6NjZNd2sxdVJpVFRUTk80SmZVNm8rRWUvMjVzSnorRUN6RU5CdjVl?=
 =?utf-8?B?UEJ2V2RuNkhFR2hWcFdiSkVrcVVEV1o2eWFiRTc5YlBlQ05jbStxV1MwdnBP?=
 =?utf-8?B?OERXUnJFa28zbXp2dUlXOG5wamhHRVI5emN0QmRzNGJFVGZTSzdXejF4MDB6?=
 =?utf-8?B?azRHQmFaTzJXVU54elppb0J1ZTVkNXZieDg0N3h1OXhjamFqcVBoUEN5SDAx?=
 =?utf-8?B?K2FZcTZaQnh5WGRVdnhMaVo5QmRkSXVrSDIvK0JBM0FyblFXSCtvV1RXREV2?=
 =?utf-8?B?Sjc2RlM0eFphWjFiYUMyeFZuYjNWQnRtaW5vV1ltbjI4MzBHWkRudk5Dbktv?=
 =?utf-8?B?cWlmNTBOVFhJWk5aS1lhVlIvKzdZaVhXc0t6NHU1M3RiQVZqTkI3ZGozdHNs?=
 =?utf-8?B?ZCt2TjNqd3hQZkFkNy9BczdmTkcrU2dwTGErU1IrbEZnS3ZkeWNCSHZYc1dY?=
 =?utf-8?B?d1o4MS9FRndGZUNPRElDcXFMdmdxRExIamtvMUUzNWNQYmZwSWZwTGRhY0VQ?=
 =?utf-8?B?V0orN0JUaUtVVGJyc0RrcGN4dWpWcUdvNCszR2c3NXVJWUlST3NNZzhHc3lH?=
 =?utf-8?B?ejlheUZoV2crYUNZdnFRMnFKc1FnTWpMSE55aTIySDIreGtneU81MXA4VHlk?=
 =?utf-8?B?dFRKWHFESTZnUE1XM2oySlQvcDVYbjhhTGVid1Jqa1FpNDhVSWJZbGk5NHEz?=
 =?utf-8?B?RlJqVG1ueHh2UUJuU2hxQ241d1k5SDhTTXRvUzFsM0RwQWVHV3ZBNHorQk9X?=
 =?utf-8?B?UFhaT1c4UmVjamNiVkNNT2kvRERld04ydTJpNjJGSnpjNlVRalZCNU1rbW1r?=
 =?utf-8?B?STdVck9LUEgvdkpEVEc1aFJnMkdqQWlGcE91bXM2YVVDemszVnovZlJLb1BU?=
 =?utf-8?B?TTlKcEFCU3pCbGgrVVFZcFVCbFFWYjJRUTdvZXZWc2VIMU9haGxQV251MUli?=
 =?utf-8?B?Y1krdmJVNlQzUW1VeU9pRnhkZ0E0dzZDTzJnYjFFTWxYL05ZMGdsN241RGI4?=
 =?utf-8?B?a0RyR0dHWnZXVFE5b2VqREc1dUVTdzRSMU5pNVJwbDVza00rbGpwRjh2bUpE?=
 =?utf-8?B?NFNLQmlDTGZkNmtZcjU2c3hWSU93OTZtS1dlMEd6a1dEd1VyQTRhWnpjZ3Ur?=
 =?utf-8?B?M0dIZ0hwSzQxUm1RcE5HQUl2SHRvL3lyNmlEVEJBRVBVeEJ1czQyb0M0L3NC?=
 =?utf-8?B?L09sOHc3TDl5U2dVN3Ribkx6amFFUDJWSEtpS1hib0pEQTcrYlROMFlpN3hV?=
 =?utf-8?B?dEJJWE8xYTJBRGNLcnlQUEhLZnFOalhFb0JyR01PODZKSVVyVnNJZW84Y2Vp?=
 =?utf-8?B?blU3V1lDR2NrZHpSM25Ic1BScDZlNStLbGd6SGE1OVExRWluR1ZONWthMFZ0?=
 =?utf-8?B?UUZZRnc3WkszRkFLTm9ocmoremxyNlEvZGY3UzBLaEJ0RjBVdXk5WjNrQkxV?=
 =?utf-8?B?cTRzV2dSS0pUSWlOVDVTb2U0elpHN01NcTJoZ3B3cW5JMGNpMEg1dFhqcE1x?=
 =?utf-8?B?REpWRFJETU1xcGxKdGp2L3lyTVpTV1BTTzlCSWgvNGlRdVkrMHdYSTZPRW9B?=
 =?utf-8?B?c2dyUGJ0RWk2NC95dUFJSUdUKzFxS3dzejQ2ZzlITEdOeTladXh1b1FZcnVH?=
 =?utf-8?B?UzhZS2NzRzBHa3NlMnh5UHRkTjRVZWlvZ0dJSCtmQVVUNjN0RjIyRlNRZ0tx?=
 =?utf-8?B?ZWNnNmxHMTNkTEg5NGNyR2Zub3V5V01oQUxHakdDQ2k5d0JGeWtOWnNML3Zr?=
 =?utf-8?B?UTU5OU9zOVVxUkYzbzJ5SDhMY2pwWk5DdTZCa3NvWEl5OWVEbmxwaU1mYkVC?=
 =?utf-8?B?V1ZXVkxoY0NZcEpibW5mbGtsYTdPQlRnOTIwdFBwQllzYityNDI3Wldld3FY?=
 =?utf-8?B?TlJvTmw5VjFMRHNMdUs4REZWcFhRVklFYkJGYlVYeVNTT0thSHd2SEw4ZXR5?=
 =?utf-8?B?V3JLU1ZCNWdnSG4rcHdRb01Cek9uTkFydTZWSUJNVVZ0QTVxTDN6bGF6MW5D?=
 =?utf-8?B?WHZzU3VQNWR1emJKYlo3Ri9rZEdDa2RrUmFHdGlkam43OW53d3FJNlRrcDdw?=
 =?utf-8?Q?vNWkQCxC2Qqdr2FtbWkOgIM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14D56B1278C37F42A6220FA237A62819@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27dccb44-ac9b-4e8f-fe78-08daa65f9522
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 23:24:27.9924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t6Rb9Y7tWPlXneITgRBq4NTdhMm+/izD2y1E9UqFiI9hL0ohPRxOAkDrdvdHHHWHfy4ZAKOl9I3NjntqSFuQDz8m4x6Fm08C9J2CQcF+PUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7116
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIyLTEwLTA0IGF0IDE0OjE3IC0wNzAwLCBILiBQZXRlciBBbnZpbiB3cm90ZToN
Cj4gT24gT2N0b2JlciA0LCAyMDIyIDE6NTA6MjAgUE0gUERULCBOYXRoYW4gQ2hhbmNlbGxvciA8
DQo+IG5hdGhhbkBrZXJuZWwub3JnPiB3cm90ZToNCj4gPiBPbiBUdWUsIE9jdCAwNCwgMjAyMiBh
dCAwODozNDo1NFBNICswMDAwLCBFZGdlY29tYmUsIFJpY2sgUCB3cm90ZToNCj4gPiA+IE9uIFR1
ZSwgMjAyMi0xMC0wNCBhdCAxNDo0MyAtMDUwMCwgSm9obiBBbGxlbiB3cm90ZToNCj4gPiA+ID4g
T24gMTAvNC8yMiAxMDo0NyBBTSwgTmF0aGFuIENoYW5jZWxsb3Igd3JvdGU6DQo+ID4gPiA+ID4g
SGkgS2VlcywNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBPbiBNb24sIE9jdCAwMywgMjAyMiBhdCAw
OTo1NDoyNlBNIC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+ID4gPiA+ID4gPiBPbiBNb24sIE9j
dCAwMywgMjAyMiBhdCAwNTowOTowNFBNIC0wNzAwLCBEYXZlIEhhbnNlbg0KPiA+ID4gPiA+ID4g
d3JvdGU6DQo+ID4gPiA+ID4gPiA+IE9uIDEwLzMvMjIgMTY6NTcsIEtlZXMgQ29vayB3cm90ZToN
Cj4gPiA+ID4gPiA+ID4gPiBPbiBUaHUsIFNlcCAyOSwgMjAyMiBhdCAwMzoyOTozMFBNIC0wNzAw
LCBSaWNrDQo+ID4gPiA+ID4gPiA+ID4gRWRnZWNvbWJlDQo+ID4gPiA+ID4gPiA+ID4gd3JvdGU6
DQo+ID4gPiA+ID4gPiA+ID4gPiBTaGFkb3cgc3RhY2sgaXMgc3VwcG9ydGVkIG9uIG5ld2VyIEFN
RCBwcm9jZXNzb3JzLA0KPiA+ID4gPiA+ID4gPiA+ID4gYnV0IHRoZQ0KPiA+ID4gPiA+ID4gPiA+
ID4ga2VybmVsDQo+ID4gPiA+ID4gPiA+ID4gPiBpbXBsZW1lbnRhdGlvbiBoYXMgbm90IGJlZW4g
dGVzdGVkIG9uIHRoZW0uIFByZXZlbnQNCj4gPiA+ID4gPiA+ID4gPiA+IGJhc2ljDQo+ID4gPiA+
ID4gPiA+ID4gPiBpc3N1ZXMgZnJvbQ0KPiA+ID4gPiA+ID4gPiA+ID4gc2hvd2luZyB1cCBmb3Ig
bm9ybWFsIHVzZXJzIGJ5IGRpc2FibGluZyBzaGFkb3cgc3RhY2sNCj4gPiA+ID4gPiA+ID4gPiA+
IG9uDQo+ID4gPiA+ID4gPiA+ID4gPiBhbGwgQ1BVcyBleGNlcHQNCj4gPiA+ID4gPiA+ID4gPiA+
IEludGVsIHVudGlsIGl0IGhhcyBiZWVuIHRlc3RlZC4gQXQgd2hpY2ggcG9pbnQgdGhlDQo+ID4g
PiA+ID4gPiA+ID4gPiBsaW1pdGF0aW9uIHNob3VsZCBiZQ0KPiA+ID4gPiA+ID4gPiA+ID4gcmVt
b3ZlZC4NCj4gPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1i
eTogUmljayBFZGdlY29tYmUgPA0KPiA+ID4gPiA+ID4gPiA+ID4gcmljay5wLmVkZ2Vjb21iZUBp
bnRlbC5jb20+DQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gU28gcnVubmluZyB0
aGUgc2VsZnRlc3RzIG9uIGFuIEFNRCBzeXN0ZW0gaXMgc3VmZmljaWVudA0KPiA+ID4gPiA+ID4g
PiA+IHRvDQo+ID4gPiA+ID4gPiA+ID4gZHJvcCB0aGlzDQo+ID4gPiA+ID4gPiA+ID4gcGF0Y2g/
DQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBZZXMsIHRoYXQncyBlbm91Z2guDQo+ID4g
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBJIF90aG91Z2h0XyB0aGUgQU1EIGZvbGtzIHByb3Zp
ZGVkIHNvbWUgdGVzdGVkLWJ5J3MgYXQNCj4gPiA+ID4gPiA+ID4gc29tZQ0KPiA+ID4gPiA+ID4g
PiBwb2ludCBpbiB0aGUNCj4gPiA+ID4gPiA+ID4gcGFzdC4gIEJ1dCwgbWF5YmUgSSdtIGNvbmZ1
c2luZyB0aGlzIGZvciBvbmUgb2YgdGhlIG90aGVyDQo+ID4gPiA+ID4gPiA+IHNoYXJlZA0KPiA+
ID4gPiA+ID4gPiBmZWF0dXJlcy4gIEVpdGhlciB3YXksIEknbSBzdXJlIG5vIHRlc3RlZC1ieSdz
IHdlcmUNCj4gPiA+ID4gPiA+ID4gZHJvcHBlZCBvbg0KPiA+ID4gPiA+ID4gPiBwdXJwb3NlLg0K
PiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gSSdtIHN1cmUgUmljayBpcyBlYWdlciB0byB0
cmltIGRvd24gaGlzIHNlcmllcyBhbmQgdGhpcw0KPiA+ID4gPiA+ID4gPiB3b3VsZA0KPiA+ID4g
PiA+ID4gPiBiZSBhIGdyZWF0DQo+ID4gPiA+ID4gPiA+IHBhdGNoIHRvIGRyb3AuICBEb2VzIGFu
eW9uZSB3YW50IHRvIG1ha2UgdGhhdCBlYXN5IGZvcg0KPiA+ID4gPiA+ID4gPiBSaWNrPw0KPiA+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPGhpbnQ+IDxoaW50Pg0KPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiBIZXkgR3VzdGF2bywgTmF0aGFuLCBvciBOaWNrISBJIGtub3cgeSdhbGwgaGF2
ZSBzb21lIGZhbmN5DQo+ID4gPiA+ID4gPiBBTUQNCj4gPiA+ID4gPiA+IHRlc3RpbmcNCj4gPiA+
ID4gPiA+IHJpZ3MuIEdvdCBhIG1vbWVudCB0byBzcGluIHVwIHRoaXMgc2VyaWVzIGFuZCBydW4g
dGhlDQo+ID4gPiA+ID4gPiBzZWxmdGVzdHM/DQo+ID4gPiA+ID4gPiA6KQ0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IEkgZG8gaGF2ZSBhY2Nlc3MgdG8gYSBzeXN0ZW0gd2l0aCBhbiBFUFlDIDc1MTMs
IHdoaWNoIGRvZXMNCj4gPiA+ID4gPiBoYXZlDQo+ID4gPiA+ID4gU2hhZG93DQo+ID4gPiA+ID4g
U3RhY2sgc3VwcG9ydCAoSSBjYW4gc2VlICdzaHN0aycgaW4gdGhlICJGbGFncyIgc2VjdGlvbiBv
Zg0KPiA+ID4gPiA+IGxzY3B1DQo+ID4gPiA+ID4gd2l0aA0KPiA+ID4gPiA+IHRoaXMgc2VyaWVz
KS4gQXMgZmFyIGFzIEkgdW5kZXJzdGFuZCBpdCwgQU1EIG9ubHkgYWRkZWQNCj4gPiA+ID4gPiBT
aGFkb3cNCj4gPiA+ID4gPiBTdGFjaw0KPiA+ID4gPiA+IHdpdGggWmVuIDM7IG15IHJlZ3VsYXIg
QU1EIHRlc3Qgc3lzdGVtIGlzIFplbiAyIChwcm9iYWJseQ0KPiA+ID4gPiA+IHNob3VsZA0KPiA+
ID4gPiA+IGxvb2sgYXQNCj4gPiA+ID4gPiBwcm9jdXJyaW5nIGEgWmVuIDMgb3IgWmVuIDQgb25l
IGF0IHNvbWUgcG9pbnQpLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEkgYXBwbGllZCB0aGlzIHNl
cmllcyBvbiB0b3Agb2YgNi4wIGFuZCByZXZlcnRlZCB0aGlzIGNoYW5nZQ0KPiA+ID4gPiA+IHRo
ZW4NCj4gPiA+ID4gPiBib290ZWQNCj4gPiA+ID4gPiBpdCBvbiB0aGF0IHN5c3RlbS4gQWZ0ZXIg
YnVpbGRpbmcgdGhlIHNlbGZ0ZXN0ICh3aGljaCBkaWQNCj4gPiA+ID4gPiByZXF1aXJlDQo+ID4g
PiA+ID4gJ21ha2UgaGVhZGVyc19pbnN0YWxsJyBhbmQgYSBzbWFsbCBhZGRpdGlvbiB0byBtYWtl
IGl0IGJ1aWxkDQo+ID4gPiA+ID4gYmV5b25kDQo+ID4gPiA+ID4gdGhhdCwgc2VlIGJlbG93KSwg
SSByYW4gaXQgYW5kIHRoaXMgd2FzIHRoZSByZXN1bHQuIEkgYW0gbm90DQo+ID4gPiA+ID4gc3Vy
ZQ0KPiA+ID4gPiA+IGlmDQo+ID4gPiA+ID4gdGhhdCBpcyBleHBlY3RlZCBvciBub3QgYnV0IHRo
ZSBvdGhlciByZXN1bHRzIHNlZW0gcHJvbWlzaW5nDQo+ID4gPiA+ID4gZm9yDQo+ID4gPiA+ID4g
ZHJvcHBpbmcgdGhpcyBwYXRjaC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiAgICAkIC4vdGVzdF9z
aGFkb3dfc3RhY2tfNjQNCj4gPiA+ID4gPiAgICBbSU5GT10gIG5ld19zc3AgPSA3ZjhhMzZjOWZm
ZjgsICpuZXdfc3NwID0gN2Y4YTM2Y2EwMDAxDQo+ID4gPiA+ID4gICAgW0lORk9dICBjaGFuZ2lu
ZyBzc3AgZnJvbSA3ZjhhMzc0YTBmZjAgdG8gN2Y4YTM2YzlmZmY4DQo+ID4gPiA+ID4gICAgW0lO
Rk9dICBzc3AgaXMgbm93IDdmOGEzNmNhMDAwMA0KPiA+ID4gPiA+ICAgIFtPS10gICAgU2hhZG93
IHN0YWNrIHBpdm90DQo+ID4gPiA+ID4gICAgW09LXSAgICBTaGFkb3cgc3RhY2sgZmF1bHRzDQo+
ID4gPiA+ID4gICAgW0lORk9dICBDb3JydXB0aW5nIHNoYWRvdyBzdGFjaw0KPiA+ID4gPiA+ICAg
IFtJTkZPXSAgR2VuZXJhdGVkIHNoYWRvdyBzdGFjayB2aW9sYXRpb24gc3VjY2Vzc2Z1bGx5DQo+
ID4gPiA+ID4gICAgW09LXSAgICBTaGFkb3cgc3RhY2sgdmlvbGF0aW9uIHRlc3QNCj4gPiA+ID4g
PiAgICBbSU5GT10gIEd1cCByZWFkIC0+IHNoc3RrIGFjY2VzcyBzdWNjZXNzDQo+ID4gPiA+ID4g
ICAgW0lORk9dICBHdXAgd3JpdGUgLT4gc2hzdGsgYWNjZXNzIHN1Y2Nlc3MNCj4gPiA+ID4gPiAg
ICBbSU5GT10gIFZpb2xhdGlvbiBmcm9tIG5vcm1hbCB3cml0ZQ0KPiA+ID4gPiA+ICAgIFtJTkZP
XSAgR3VwIHJlYWQgLT4gd3JpdGUgYWNjZXNzIHN1Y2Nlc3MNCj4gPiA+ID4gPiAgICBbSU5GT10g
IFZpb2xhdGlvbiBmcm9tIG5vcm1hbCB3cml0ZQ0KPiA+ID4gPiA+ICAgIFtJTkZPXSAgR3VwIHdy
aXRlIC0+IHdyaXRlIGFjY2VzcyBzdWNjZXNzDQo+ID4gPiA+ID4gICAgW0lORk9dICBDb3cgZ3Vw
IHdyaXRlIC0+IHdyaXRlIGFjY2VzcyBzdWNjZXNzDQo+ID4gPiA+ID4gICAgW09LXSAgICBTaGFk
b3cgZ3VwIHRlc3QNCj4gPiA+ID4gPiAgICBbSU5GT10gIFZpb2xhdGlvbiBmcm9tIHNoc3RrIGFj
Y2Vzcw0KPiA+ID4gPiA+ICAgIFtPS10gICAgbXByb3RlY3QoKSB0ZXN0DQo+ID4gPiA+ID4gICAg
W09LXSAgICBVc2VyZmF1bHRmZCB0ZXN0DQo+ID4gPiA+ID4gICAgW0ZBSUxdICBBbHQgc2hhZG93
IHN0YWNrIHRlc3QNCj4gPiA+ID4gDQo+ID4gPiA+IFRoZSBzZWxmdGVzdCBpcyBsb29raW5nIE9L
IG9uIG15IHN5c3RlbSAoRGVsbCBQb3dlckVkZ2UgUjY1MTUNCj4gPiA+ID4gdy8gRVBZQw0KPiA+
ID4gPiA3NzEzKS4gSSBhbHNvIGp1c3QgcHVsbGVkIGEgZnJlc2ggNi4wIGtlcm5lbCBhbmQgYXBw
bGllZCB0aGUNCj4gPiA+ID4gc2VyaWVzDQo+ID4gPiA+IGluY2x1ZGluZyB0aGUgZml4IE5hdGhh
biBtZW50aW9ucyBiZWxvdy4NCj4gPiA+ID4gDQo+ID4gPiA+ICQgdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMveDg2L3Rlc3Rfc2hhZG93X3N0YWNrXzY0DQo+ID4gPiA+IFtJTkZPXSAgbmV3X3NzcCA9
IDdmMzBjY2NjNWZmOCwgKm5ld19zc3AgPSA3ZjMwY2NjYzYwMDENCj4gPiA+ID4gW0lORk9dICBj
aGFuZ2luZyBzc3AgZnJvbSA3ZjMwY2Q0YzZmZjAgdG8gN2YzMGNjY2M1ZmY4DQo+ID4gPiA+IFtJ
TkZPXSAgc3NwIGlzIG5vdyA3ZjMwY2NjYzYwMDANCj4gPiA+ID4gW09LXSAgICBTaGFkb3cgc3Rh
Y2sgcGl2b3QNCj4gPiA+ID4gW09LXSAgICBTaGFkb3cgc3RhY2sgZmF1bHRzDQo+ID4gPiA+IFtJ
TkZPXSAgQ29ycnVwdGluZyBzaGFkb3cgc3RhY2sNCj4gPiA+ID4gW0lORk9dICBHZW5lcmF0ZWQg
c2hhZG93IHN0YWNrIHZpb2xhdGlvbiBzdWNjZXNzZnVsbHkNCj4gPiA+ID4gW09LXSAgICBTaGFk
b3cgc3RhY2sgdmlvbGF0aW9uIHRlc3QNCj4gPiA+ID4gW0lORk9dICBHdXAgcmVhZCAtPiBzaHN0
ayBhY2Nlc3Mgc3VjY2Vzcw0KPiA+ID4gPiBbSU5GT10gIEd1cCB3cml0ZSAtPiBzaHN0ayBhY2Nl
c3Mgc3VjY2Vzcw0KPiA+ID4gPiBbSU5GT10gIFZpb2xhdGlvbiBmcm9tIG5vcm1hbCB3cml0ZQ0K
PiA+ID4gPiBbSU5GT10gIEd1cCByZWFkIC0+IHdyaXRlIGFjY2VzcyBzdWNjZXNzDQo+ID4gPiA+
IFtJTkZPXSAgVmlvbGF0aW9uIGZyb20gbm9ybWFsIHdyaXRlDQo+ID4gPiA+IFtJTkZPXSAgR3Vw
IHdyaXRlIC0+IHdyaXRlIGFjY2VzcyBzdWNjZXNzDQo+ID4gPiA+IFtJTkZPXSAgQ293IGd1cCB3
cml0ZSAtPiB3cml0ZSBhY2Nlc3Mgc3VjY2Vzcw0KPiA+ID4gPiBbT0tdICAgIFNoYWRvdyBndXAg
dGVzdA0KPiA+ID4gPiBbSU5GT10gIFZpb2xhdGlvbiBmcm9tIHNoc3RrIGFjY2Vzcw0KPiA+ID4g
PiBbT0tdICAgIG1wcm90ZWN0KCkgdGVzdA0KPiA+ID4gPiBbT0tdICAgIFVzZXJmYXVsdGZkIHRl
c3QNCj4gPiA+ID4gW09LXSAgICBBbHQgc2hhZG93IHN0YWNrIHRlc3QuDQo+ID4gPiANCj4gPiA+
IFRoYW5rcyBmb3IgdGhlIHRlc3RpbmcuIEJhc2VkIG9uIHRoZSB0ZXN0LCBJIHdvbmRlciBpZiB0
aGlzIGNvdWxkDQo+ID4gPiBiZSBhDQo+ID4gPiBTVyBidWcuIE5hdGhhbiwgY291bGQgSSBzZW5k
IHlvdSBhIHR3ZWFrZWQgdGVzdCB3aXRoIHNvbWUgbW9yZQ0KPiA+ID4gZGVidWcNCj4gPiA+IGlu
Zm9ybWF0aW9uPw0KPiA+IA0KPiA+IFllcywgbW9yZSB0aGFuIGhhcHB5IHRvIGhlbHAgeW91IGxv
b2sgaW50byB0aGlzIGZ1cnRoZXIhDQo+ID4gDQo+ID4gPiBKb2huLCBhcmUgd2Ugc3VyZSBBTUQg
YW5kIEludGVsIHN5c3RlbXMgYmVoYXZlIHRoZSBzYW1lIHdpdGgNCj4gPiA+IHJlc3BlY3QgdG8N
Cj4gPiA+IENQVXMgbm90IGNyZWF0aW5nIERpcnR5PTEsV3JpdGU9MCBQVEVzIGluIHJhcmUgc2l0
dWF0aW9ucz8gT3IgYW55DQo+ID4gPiBvdGhlcg0KPiA+ID4gQ0VUIHJlbGF0ZWQgZGlmZmVyZW5j
ZXMgd2Ugc2hvdWxkIGhhc2ggb3V0PyBPdGhlcndpc2UgSSdsbCBkcm9wDQo+ID4gPiB0aGUNCj4g
PiA+IHBhdGNoIGZvciB0aGUgbmV4dCB2ZXJzaW9uLiAoYW5kIGFzc3VtaW5nIHRoZSBpc3N1ZSBO
YXRoYW4gaGl0DQo+ID4gPiBkb2Vzbid0DQo+ID4gPiB0dXJuIHVwIGFueXRoaW5nIEhXIHJlbGF0
ZWQpLg0KPiANCj4gSSBoYXZlIHRvIGFkbWl0IHRvIGJlaW5nIGEgYml0IGNvbmZ1c2VkIGhlcmUu
Li4gaW4gZ2VuZXJhbCwgd2UgdHJ1c3QNCj4gQ1BVSUQgYml0cyB1bmxlc3MgdGhleSBhcmUgKmtu
b3duKiB0byBiZSB3cm9uZywgaW4gd2hpY2ggY2FzZSB3ZQ0KPiBibGFja2xpc3QgdGhlbS4NCj4g
DQo+IElmIEFNRCBhZHZlcnRpc2VzIHRoZSBmZWF0dXJlIGJ1dCBpdCBkb2Vzbid0IHdvcmsgb3Ig
dGhleSBkaWRuJ3QNCj4gdmFsaWRhdGUgaXQsIHRoYXQgd291bGQgYmUgYSAoc2VyaW91cyEpIGJ1
ZyBvbiB0aGVpciBwYXJ0IHRoYXQgd2UgY2FuDQo+IGFkZHJlc3MgYnkgYmxhY2tsaXN0aW5nLCBi
dXQgdGhleSBzaG91bGQgYWxzbyBmaXggd2l0aCBhDQo+IG1pY3JvY29kZS9CSU9TIHBhdGNoLg0K
PiANCj4gV2hhdCBhbSBJIG1pc3Npbmc/DQoNCkkgaGF2ZSBub3QgcmVhZCBhbnl0aGluZyBhYm91
dCB0aGUgQU1EIGltcGxlbWVudGF0aW9uIGV4Y2VwdCBoZWFyaW5nDQp0aGF0IGl0IGlzIHN1cHBv
cnRlZC4gQnV0IHRoZXJlIGFyZSBzb21lIG1pY3JvYXJjaGl0ZWN0dWFsLWxpa2UgYXNwZWN0cw0K
dG8gdGhpcyBDRVQgTGludXggaW1wbGVtZW50YXRpb24sIGFyb3VuZCByZXF1aXJpbmcgQ1BVcyB0
byBub3QgY3JlYXRlDQpEaXJ0eT0xLFdyaXRlPTAgUFRFcyBpbiBzb21lIGNhc2VzLCB3aGVyZSB0
aGV5IGRpZCBpbiB0aGUgcGFzdC4gSW4NCmFub3RoZXIgdGhyZWFkIEphbm4gYXNrZWQgaG93IHRo
ZSBJT01NVSB3b3JrcyB3aXRoIHJlc3BlY3QgdG8gdGhpcyBlZGdlDQpjYXNlIGFuZCBJJ20gY3Vy
cmVudGx5IHRyeWluZyB0byBjaGFzZSBkb3duIHRoYXQgYW5zd2VyIGZvciBldmVuIEludGVsDQpI
Vy4gU28gSSBqdXN0IHdhbnRlZCB0byBkb3VibGUgY2hlY2sgdGhhdCB3ZSBleHBlY3QgdGhhdCBl
dmVyeXRoaW5nDQpzaG91bGQgYmUgdGhlIHNhbWUuIEluIGVpdGhlciBjYXNlIHdlIHN0aWxsIGhh
dmUgdGltZSB0byBpcm9uIHRoaW5ncw0Kb3V0IGJlZm9yZSBhbnl0aGluZyBnZXRzIHVwc3RyZWFt
Lg0K
