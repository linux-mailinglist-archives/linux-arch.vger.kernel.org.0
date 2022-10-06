Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAA55F6B40
	for <lists+linux-arch@lfdr.de>; Thu,  6 Oct 2022 18:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiJFQLq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Oct 2022 12:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiJFQLo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Oct 2022 12:11:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1075AC3BF;
        Thu,  6 Oct 2022 09:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665072703; x=1696608703;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LALsoupZ/4r03DHnClHEOstizd1UJDPdv/YzHMr/04w=;
  b=bgYZkKoaGWYzJd+Ek8I8qddipxJRSK8i8Tra5aWKyvS3UFAiQw0WesGR
   bLyeUkvnCrNJGW01k31MKhTktLyoGKP8Gq4LKei1LzncbOBzvMdHWr21l
   HFVaFftl7lT/Wj0RVQ+i5hTbzvxcPdQgEYPJRo3CZITvLQzftVbxEh4uw
   e3jHmyqA6kR50oejQ5yyhJSzU+3zvig7+Klm0OkjPxnu6qPkOCKWnUk6j
   L0HQAzeBfu8fKhgj4K5VKXiMCkHfQjRJFxmdbYEqXAaU22WfV2NcIOrEH
   F9ktwm+JRrGRJdzXigp7clZFCyE4UKH+ZB036yacsuSS2MVvK6v+HZfm9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="303466801"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="303466801"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 09:10:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="750198544"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="750198544"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 06 Oct 2022 09:10:50 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 6 Oct 2022 09:10:49 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 6 Oct 2022 09:10:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 6 Oct 2022 09:10:49 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 6 Oct 2022 09:10:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8auzEz6B/fDDOH8bHEvc5LVcEGbaqtcarhjJdcmwI3e159Ej3eQP6uJqcpvdnxJg7VmPwhKYR7VOr4GwVRLAtJC6aU05VdeYJJdgXPxocva56s1YFcJ2V7LI5fq2s/UmDKnlKmJBb/mauo0JTDc359xDGpQZNmtM1bx8skn6+AqRd4VK7L3YDWvdYI0LFeX3FxjOW9s8TOpyT7lLUooeENZu07tz1XNBYoWxjG+KkcJ2XFhvas/98WRaiz9tOciYCvwzSuY9HWgstBWNz8bpZ9LjSYVwwBpIR2H4covcmqPwPIoa0JM6c3OAWItHY4Q86/R14WWKjB/ODKPIw0+xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LALsoupZ/4r03DHnClHEOstizd1UJDPdv/YzHMr/04w=;
 b=hFTqLDINNN9JI7Qt22ii69gAnzcRO7WUObxyH6NtM/t5fvv4qdSFClTCExAFA2+rearqs+hvrWBHt1jiCEci2OIrL6LHxs2XrAz7gfo1WO4K86XCPhCpttwEEYRjdjpY38FMzLRj4zoU9+sssgmdXAwzxZPvSADVBOAuC6L6zCJLXk8VlB+L5Sq71KqI0kPePPSreit98qr6YmnskjNRV0zKo7H8rYTxNxnwG/hLtmCMclg1KoCo3MwYbPRkbaKkCXW3//P7yI9uCQij9ldarPvc0UAoIiErBJ5sPikKel9HK4RchSB+eTLj0hmsnAkoEiNbmUuIrWkdrbVrq6wXWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM4PR11MB6478.namprd11.prod.outlook.com (2603:10b6:8:89::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Thu, 6 Oct
 2022 16:10:44 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.034; Thu, 6 Oct 2022
 16:10:44 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "jannh@google.com" <jannh@google.com>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v2 10/39] x86/mm: Introduce _PAGE_COW
Thread-Topic: [PATCH v2 10/39] x86/mm: Introduce _PAGE_COW
Thread-Index: AQHY1FMOaUlv/a8lEUG05TjT32eaO634FoAAgAl9NwA=
Date:   Thu, 6 Oct 2022 16:10:43 +0000
Message-ID: <43fa92845d9883655dd20c49977ca399671bde20.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-11-rick.p.edgecombe@intel.com>
         <CAG48ez3hXfsUkMqcHmVetzywKC8a+PLhGReceTdwCf7B03Oj7g@mail.gmail.com>
In-Reply-To: <CAG48ez3hXfsUkMqcHmVetzywKC8a+PLhGReceTdwCf7B03Oj7g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|DM4PR11MB6478:EE_
x-ms-office365-filtering-correlation-id: 4c3b1501-bd96-4a00-d1ad-08daa7b55270
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mJHw+Yo2Q7Q0a8MfZDiY5cTDrnaMv3KNYmzCRJ6P9oJ8xzjG76HOgHs7uT7/WPhjlZ6Uk7msN5egs938WSU1S4D1MJJAobGK1pNluCmxdHCahYqnHNzetoq83ZsQ44XkHh/Z7iOA79BExr9E9q3Wml57NjFUZEsF+9ePjV3BLrQvOTYrlcLPOt2sKnxr/cC6RLARCNpew5WPIKS7fmgDfyo9NueYTvMVO1x2WGr0ZoMlDs8ETNiVFbNbOC7Ixsgx2v2kQl7VXjsI09UCd3+EYJ1jIBqeQKMzwPV//jR2UrWh8J8VMYihQ6/xwVFwmcEJb6rhQEticYKi0IANSIEBITEGyoLGb9VO0YDSoubZKcuOVnLi2a6EIQ4/Zpk8J3ctQSDcoc1r/2O0us3d2sG3Tfep320quS4+Z/Ua2w7/5dQQUWaC8odWbbRFdxBrpVIohpVyJVBNi5Y9Oup0ijttHT2ZEWTwHX4DyH/TXgnebOxUzOcUx8o4jTPVv8uZddm1Waa+bQVVfYTagCa5xm0frbfPg/NJAKZ6QmqcuCJaLkgiIFh1Bi5kE4TXojm/ZtavxsvSCJ6JNx2DwchbuP12QaLl6bknh8lNxA5zfo3EMMCJa0dlgoTL8M2Ss7Gc42jVjevnJ2mHb2mBOe5toGcE8MQJ5xw6xQfctWlxdWHl1ngZaXGZzS0H+YAFYJax3x8ofnps5AuvP+orNBnA2g4oifeNv9FM6Ganq21KM1iEacCc6/3gYnvOkge+GZyV8aYRkP4roL4+DFPm2qB7SMjBne/qcZ8VMvTHMJ2yoSpEA/0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(396003)(366004)(136003)(39860400002)(451199015)(7416002)(5660300002)(8936002)(66946007)(26005)(36756003)(6512007)(6486002)(82960400001)(66446008)(8676002)(91956017)(66556008)(186003)(83380400001)(66476007)(2906002)(41300700001)(38100700002)(4744005)(478600001)(122000001)(7406005)(76116006)(316002)(4326008)(6506007)(6916009)(64756008)(71200400001)(2616005)(38070700005)(53546011)(86362001)(54906003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUlBL05rOEhEb05scUVpR2RlSE5BdXRzY3M0Z1VybUNCTDN2aWlHSFE1dXJE?=
 =?utf-8?B?ZmtkYUY1K0VBMk4rbkhyQmFiWEtmTnF5M0Y0SkFNZThWeDdUYk1YRHBhZ29k?=
 =?utf-8?B?QkU0S1lGMHFsZGlGVm80dC9KUTg1UTNLNTJmQkVMcTk2S2c4MStiRVhUNVZi?=
 =?utf-8?B?MEZydlpxWHhIU0JwcEZ4OElDZjRBUHpFekdMcXpvQmEyTnk5MG82Q0RITzhH?=
 =?utf-8?B?RUlRcUFxVFVZZU54cFJMbFo4SzhJbjJmWmR0NFBDM2lVRjNra2RkWnZIcHkz?=
 =?utf-8?B?dzBxMFo1dnlqc092RFcrS2x1SDV0QkpjV2dEMzRueUZzRTh3VGsxUUFSVjhp?=
 =?utf-8?B?WEtGZnM5TXkwRUlaUVY5ZllKVytZUDkzZ0hrUDFERjZjeTl0QWZpd2NrVnRa?=
 =?utf-8?B?L2JsTUE2YkdYZVZMREFlY01kSkJpeE1leVhXZERtdEc1bHdNeVZxVk9aTmhZ?=
 =?utf-8?B?R1VyRTVseUx0WEt5SmFjdmxtekZoRDVPYzBtM3JUeTR2TXNnNVJWVGRxa2tH?=
 =?utf-8?B?a1grZWJ0VUIvMitzM01HOXFYWE4rOGFQZmFOREJmVUdOSVJhTDZna1FFbXNj?=
 =?utf-8?B?N3J4cnFpaGlGd3dQWnZZZ1huZHlUMklIMm1oOXpzRjBtY1R2c0dVMjg0MmRL?=
 =?utf-8?B?MEFWT1MxYmdZelkrb1VJZWlqYVVsbWVSVGxUelA4aFE4V3JDVHdvWUNWOW43?=
 =?utf-8?B?UGdKWm4rUVZ0Q0d5WG5UcUlxT1d6bTBTNS9BbklsUUtqaWdaRWZxM1NDTDFD?=
 =?utf-8?B?WDdQUkJIRkNWS3ZUTFByUVBXZ2pPeStJVHVaaTNpTWt4L2pjSEdodFU2SjBR?=
 =?utf-8?B?eVdmL2FvRy9XTzYrQWEzand3RnowTjZmOGVnc1pzR2poR2NOQVBveitjVVlx?=
 =?utf-8?B?Rkx5aDFNanlWaHluWU9HV1N0WlpUa1dua0piMUdmeGU0bmJYdkRMMnh3aDVt?=
 =?utf-8?B?QkV2MWI5ZHBhVnNwZkFMMk5ZeEZTanh3ZWtlbExUemdzeWdOY1ZReEpRbGUy?=
 =?utf-8?B?QjlSSXhqeWR2VUg2YS9nWmJXdG5wVndFU2Q1Y0VGUVBMZzJ6NUxib1plQ0Ny?=
 =?utf-8?B?bUh6OU5tcnFXam5mYUlhZG5pb3BHalpzN21GbysxU3V6UzAzdHBLUGRQSmxK?=
 =?utf-8?B?WGsyTm0zWDhJNXd5QkpLZWhoeDNyNmU0MXJRREdETXJuYzBKNGNqUmZlYzI0?=
 =?utf-8?B?elE2WjlLUHhRSlFqbENXbHpjc29JMGd3cnd5VTY2UVpraUs2SHVIbi9UdGg4?=
 =?utf-8?B?V2tiLzE1eDNSS3lWL2pFUWJOMXI4azF0R3c1SnA5aUVSOWtVMHY2NC9sc0tT?=
 =?utf-8?B?ZUhpSGVKanFNMjVIOVgvcURaUWFvRDhwVW9wQzJwQXFxT1JlM2xIN092Zytu?=
 =?utf-8?B?aXhQL05IY05uTTMyM3MvTGIvRFJwY0FhekFnZXhqZ0tHSm1wSXcyVDhDZkFo?=
 =?utf-8?B?NncrM3FBT3BIckViQ3ZLNnhlR1E0TmZ4WGVIa3pkbHdqazdhRXBkbUhxTnZh?=
 =?utf-8?B?VlF4TkNoWkZyeXFWZlorRzdMSE1Vci9lUmlDekdDc0FFWmhJVEJsTm9ob2Ru?=
 =?utf-8?B?Z1VSY3Z4SlYwaEFkRTl5TVpjWHNHS0hkRWg5OThGTVUwT29qQWk4N3N6Q2dW?=
 =?utf-8?B?YVJJeUhkZ0M3ZW5EbnU2K2N4TW45Y1d1Q1h1MVJnVWUvUTNic2xaNDRnbmxN?=
 =?utf-8?B?TjNRR0NWdXQzdUFNL2RTTjBtUUkydHh1bnFxOWtzdDBaWjlYeW84dHVZQytt?=
 =?utf-8?B?TEtGTGFZNmQwWFk2a2tlZWNTZzlOWGkyNnRYWENXQTJIajNRY2Z6WXl6RXFz?=
 =?utf-8?B?a3lqdWpheVBCR0NDL2lUVTFIRFNERVlTQXU5elNQWXpYQi9iVDlmeE9La056?=
 =?utf-8?B?Ti9EbmM1MlVZTWJJT0hTVUpxWkNJbVUvWWJlQWIzWklJWWZNRWJzaHVLTnRC?=
 =?utf-8?B?STluQSsvTHEzZ2pMTFZIZUJpSDJGaWoyT3E2aXBrWFRVUWw4MEVaMjg5cGZG?=
 =?utf-8?B?M3Z0b0hTL1I1bGUrb1grZ1A2WnhuRHh5VGNvWVdGRWg0ZHZxejVPMHJzNE52?=
 =?utf-8?B?clNUaDMxM0Q0cFI5bWFFU0xIYS93M3o2QjhBSDE3a2pmbENuL0tyRU9uNHZL?=
 =?utf-8?B?cmdQaUdJMVRmRzNibFMvU1hGZlYyelowSDVuRjVib2xpWmpqcWdGUzhQK3Vr?=
 =?utf-8?Q?zyyh2kLNzti+L5BPAuQT6zg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2C1D59494FBB344B6FB608B95E8EE52@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3b1501-bd96-4a00-d1ad-08daa7b55270
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 16:10:44.0078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x9Kou8YZnKPcgjuHINXvjuBYNdUy+PCmlHxIgdboPqW4mCBh37JGPFH7PJL8uRk6rTqBtfdRy1lP744iO5MxEToPZ+14dbf2U70IJDu+2OU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6478
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIyLTA5LTMwIGF0IDE3OjE2ICswMjAwLCBKYW5uIEhvcm4gd3JvdGU6DQo+IE9u
IEZyaSwgU2VwIDMwLCAyMDIyIGF0IDEyOjMwIEFNIFJpY2sgRWRnZWNvbWJlDQo+IDxyaWNrLnAu
ZWRnZWNvbWJlQGludGVsLmNvbT4gd3JvdGU6DQo+ID4gVGhlIHJlYXNvbiBpdCdzIGxpZ2h0bHkg
dXNlZCBpcyB0aGF0IERpcnR5PTEgaXMgbm9ybWFsbHkgc2V0DQo+ID4gX2JlZm9yZV8gYQ0KPiA+
IHdyaXRlLiBBIHdyaXRlIHdpdGggYSBXcml0ZT0wIFBURSB3b3VsZCB0eXBpY2FsbHkgb25seSBn
ZW5lcmF0ZSBhDQo+ID4gZmF1bHQsDQo+ID4gbm90IHNldCBEaXJ0eT0xLiBIYXJkd2FyZSBjYW4g
KHJhcmVseSkgYm90aCBzZXQgV3JpdGU9MSAqYW5kKg0KPiA+IGdlbmVyYXRlIHRoZQ0KPiA+IGZh
dWx0LCByZXN1bHRpbmcgaW4gYSBEaXJ0eT0wLFdyaXRlPTEgUFRFLiBIYXJkd2FyZSB3aGljaCBz
dXBwb3J0cw0KPiA+IHNoYWRvdw0KPiA+IHN0YWNrcyB3aWxsIG5vIGxvbmdlciBleGhpYml0IHRo
aXMgb2RkaXR5Lg0KPiANCj4gU3R1cGlkIHF1ZXN0aW9uLCBzaW5jZSBJIGp1c3QgcmVjZW50bHkg
bGVhcm5lZCB0aGF0IElPTU1VdjIgaXMgYQ0KPiB0aGluZzogSSBhc3N1bWUgdGhpcyBhbHNvIGhv
bGRzIGZvciBJT01NVXMgdGhhdCBpbXBsZW1lbnQNCj4gSU9NTVV2Mi9TVkEsDQo+IHdoZXJlIHRo
ZSBJT01NVSBkaXJlY3RseSB3YWxrcyB0aGUgdXNlcnNwYWNlIHBhZ2UgdGFibGVzLCBhbmQgbm90
DQo+IGp1c3QNCj4gZm9yIHRoZSBDUFUgY29yZT8NCg0KU29ycnkgZm9yIHRoZSBkZWxheSwgSSBo
YWQgdG8gZ28gZmluZCBvdXQuIElPTU1VIGJlaGF2ZXMgc2ltaWxhciB0byB0aGUNCkNFVCBDUFVz
IGluIHRoaXMgcmVnYXJkLiBUaGFua3MgZm9yIHRoZSBxdWVzdGlvbi4NCg0KDQoNCg==
