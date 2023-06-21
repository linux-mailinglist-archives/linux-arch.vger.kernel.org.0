Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1432C738F42
	for <lists+linux-arch@lfdr.de>; Wed, 21 Jun 2023 20:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjFUSyz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Jun 2023 14:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjFUSys (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jun 2023 14:54:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2BE2107;
        Wed, 21 Jun 2023 11:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687373664; x=1718909664;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1dLXrdxTODUrXMdfOaX7lUvGocFLHu7Y3PO3GGaAD/Y=;
  b=aU1x0mMRIOPhguYtdX6jFLAB5SFw6X3+aQ72tGkZMtIpu5Qy4X2sMwLV
   FXzFLL0E59VI6CP+Wdu/lkdi1/MFg55GxcmR0mXlHlgOZl2kZEqwDUal7
   4GLtptAcbhWAy0YqK04wQxlJF6QrbjPRFadrwn29icrQRB2e4OPbdDU2K
   bWBjWK/z+vCG1x8uDNdYLfpjDjOdF7cP2iAi7LK5sSo3G2i1EdzDYawTf
   ZB0Z7gF1f/SYN8gBeSYHwoUDX2BNgHbyjpdg0YmUNpBebYh5l80ruWXEm
   lSpFmJR2KbmlM3qibLtpa8jzKFS5aouNFXJof6rNewJuOyKo64LZUVT7I
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="363686702"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="363686702"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 11:54:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="779942971"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="779942971"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jun 2023 11:54:22 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 11:54:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 21 Jun 2023 11:54:21 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 21 Jun 2023 11:54:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZMQ0cOToyuYsj1fXpHw0CEUEdDbmqfCPbKhcERxz1r1AuSNv6K17uYkvFQnNfoUrhXX0ins1qx7KdvtSohsUb7xH+XCQHO7WhvofMnUI1C7yx2b5vAxPo/AeNLbBeGQcVNMWK30nS/vcT5naGGZZaLXdERyDNCZ2kmUlyH2n7ta/ifNOOKBsZ8evr19DqadvRk3v6uvzjy7UCy3D0iNitzDdhAd4B3iXY1qCSj/b3qFuuosC5YgQ9ePskYLGjAGgPKtwKXO19DY81fOaBVNLrQ65QcnioWI4cnQALxYJZwK9TNKKAi+QX1DRi1WN0P6NKS6j7lKh6t/s1Y2sdjn0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dLXrdxTODUrXMdfOaX7lUvGocFLHu7Y3PO3GGaAD/Y=;
 b=Fme/RbGMbndOEauFuqJBpClN9wRy9N1TnkgoHJzjdKy5tNTdmSf5D6WJ3x0Y4kUpfLJZYfFxfY9GK7d7jRM/zlEupyPc8JIMINLOVqmeWMd+vcptlni3RV92jUhgf0fVFR8WKkf/I20C+1fXj0vpa/c2KYLAYtnI2Dby6PfYMZHKtU5EUdl6lXN7jYG8i7DRKzVP5zqXIRLVZcPvlPYvFKsM3Q5137JgXygAkAkG1/VxwQhPRwDG/2ZCYO740ejEPmk7L82I2TvZP06LB8SetHF6WWyCDf7ZG1Ay0T0OH2vjSlk4KVjAOhYcoU+1hQcv4ysC08n3I0oIE1oD6cdjsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH0PR11MB4933.namprd11.prod.outlook.com (2603:10b6:510:33::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 18:54:18 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec%7]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 18:54:18 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>
CC:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Thread-Topic: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Thread-Index: AQHZnYvD++9jHqJtDEOZ5j0eN4/f+6+IoOQAgAALyMOAACwFgIAAIG6AgAAMtoCAACGsAIAA96CAgABofQCAB1K5gIAAhUGAgAEVRoCAAKx+AIABDK+AgAB6bIA=
Date:   Wed, 21 Jun 2023 18:54:17 +0000
Message-ID: <c5ae83588a7e107beaf858ab04961e70d16fe32c.camel@intel.com>
References: <1f04fa59-6ca9-4f18-b138-6c33e164b6c2@sirena.org.uk>
         <49eabafa97032dec8ace7361bccae72c6ecf3860.camel@intel.com>
         <fc2ebfcf-8d91-4f07-a119-2aaec3aa099f@sirena.org.uk>
         <a0f1da840ad21fae99479288f5d74c7ab9095bb6.camel@intel.com>
         <ZImZ6eUxf5DdLYpe@arm.com>
         <64837d2af3ae39bafd025b3141a04f04f4323205.camel@intel.com>
         <ZJAWMSLfSaHOD1+X@arm.com>
         <5794e4024a01e9c25f0951a7386cac69310dbd0f.camel@intel.com>
         <ZJFukYxRbU1MZlQn@arm.com>
         <e676c4878c51ab4b6018c9426b5edacdb95f2168.camel@intel.com>
         <ZJLgp29mM3BLb3xa@arm.com>
In-Reply-To: <ZJLgp29mM3BLb3xa@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH0PR11MB4933:EE_
x-ms-office365-filtering-correlation-id: dcb09174-7325-4ec3-e7c7-08db7288ea95
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kG5fPz4gMYkTNv+lT+33Vocy0sYjjvJcYVS9+28zFUfcpxlSkmH2qonUfMdlf9PfeMISXurQbftlRY9wY92RIPHhnxl7UA9ASVv60H4WRcXufJW7uT2dTT9n6cGo2K/05seMmrX9O8gtz8Ig2ZuU+Fwk92Zm/PCAUeppEcsoIjZo0X5hYofLQsUO8Ki87fNDCp7Sib/a5mX8MWqUqmR5pB4isaNfrZ9HNqr6+euXVMaEJEdB7Qy82U3nASarqe7IXpr3KMaF3zmo5uXwX2DqJm+kDTnIkNOMXQmzIbrO4cN/k55SLXFwHl7xNrnWGxMCiMQByBzgzhJh31lu1XwrGD3A/mI9wA22MhzEjwLswy68SfciSIRWtOE5a1iyGwPLR6hO2jFe2ywuk2zFa9A3bcielq5CiNenNzCk6im0mRG+zMbXxGdClYwyAPjWbyhOmU4OtyqF8qPmP77Y3RwFuuTc9PX2sc9TPabBHb+6u7ZK7Ht94oZjNjlMmqwYQbf183bl8LaCmuwhG4J0DQ4HLNVwc7mwNlW+Q1dJn5YM5ubsnzR4TkbIIxPIwRwiKtzJjmpSpcR+xDToDJ1vri0kLRHIyXXDkj+phFGyGDz/GVNzT1gMUKDqP51JCMw5bdpn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199021)(66899021)(186003)(36756003)(7416002)(5660300002)(7406005)(38070700005)(41300700001)(66446008)(8676002)(66476007)(66556008)(64756008)(8936002)(38100700002)(122000001)(91956017)(76116006)(316002)(4326008)(82960400001)(66946007)(86362001)(2616005)(6486002)(478600001)(26005)(2906002)(6506007)(6512007)(71200400001)(54906003)(83380400001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TW9YSDRZWTd5UzJwS29BVVFodnp1Z2R5cktWRWNLcDdiRWlySVNYSGZ4dVFG?=
 =?utf-8?B?alM4VG9HdUFOOWxKY1h4YjkybE92aEFxQ3VwQ2ZFdFFyUVAzTHlDS05VeDFh?=
 =?utf-8?B?MEE0czRBYWQ5OTF1UmlGNDV1eUpVN0FtRWx4aWVhL3hMNzVtdW9vOUdIbU16?=
 =?utf-8?B?RVFTQ0VpaFlPUnZkSTR0alVUZDR4dnRPcU55Kzhmb2E3U1pIemRzWmZKeXVU?=
 =?utf-8?B?RllTVE5UaG1RWWliNCtLdjM3YWpRYUZaZy9ZdVpOejlOMXJuZ016cG1uMEN4?=
 =?utf-8?B?Q2dtMzNNQlBlMm9nODFYbElwYzVNR3ZEVzh6Z05pK01ZOGh3eVJvanlOVGxa?=
 =?utf-8?B?UDBpMGZPTkZCWlhvNG53c29ndWFQQ3ZqQ3ozWG14YTRFZWFXZXppZTVlQ0FS?=
 =?utf-8?B?VEtHT2ptZXV6QnlSVUtTMlA0WU5yZ2tFRzJBcHJSNXYwK05YL01PcXA1R1dq?=
 =?utf-8?B?dTVkYWxUU1dFcmZhUVh1dzU1Tk0yMDA3NldhcnVURHV1M2JQRFlwTXQzSEJq?=
 =?utf-8?B?Nm1HelNuTVpSeDZxdVZwcEdFaFZNYUppY0dKN2JSWEFOelNOUW0vL2g0N1FN?=
 =?utf-8?B?M0NadEhCSXcxc1hzR0N1NVJ0UkRzcmM1OWtqMTE1YmIzQXIwNmthV2owdWxx?=
 =?utf-8?B?dXJrVnhQYTRTUThxSlZBVDlFcmNVTHRhVHBQSGJFOGFuTUV3NTFtUXRPN09k?=
 =?utf-8?B?dEdNOVFnNDYyVHZaZ2ZvcjRyTW45Vzg4eFpJRUZ3TDZDb2Q0NW11Ky9Jelc1?=
 =?utf-8?B?KzFOaTZscGpNMk1PNVRsRlBpSTBQS1M0azVnTDRvVEZBd0MzTmlWY1Z5UFdw?=
 =?utf-8?B?RjZlelpiV1Z1SnFuQnJEVUozQ2hTYzJhcHcwaTdtamVudEFUTVYxcHh0bndu?=
 =?utf-8?B?L1VaZjU3TDNkZUN3cTlhTVpwcmJYVndOMzdnMHZPMjhNREJqQUgxV1NEbElF?=
 =?utf-8?B?MFVuUzlQWjBRSnU1TWN2QmN0TGw2L3h3QU5sT2FVdW5jdDk2ZEdiOVZpbVV5?=
 =?utf-8?B?b25lTXQyMExidHhuSmlkQUwyayt4SXRkN2w0ZjgvRDdIZVk4d21hNVRob25I?=
 =?utf-8?B?bWIvSVR1OHVaU0xZcWpXSlp1bGZ5RDhHMEU2VklIQzViS0Z1cWVObnFqV3pa?=
 =?utf-8?B?NXF1TGJieUhOY2pqeEFxT3I2M2orRUw4WE9Ya1BEcmxnTVkveXJBMk80QThO?=
 =?utf-8?B?d2kvWndZTldDcE5vb1JVZ2s5NlRHYW54VjMwTC9LaXB1TjZic1l2dkhFU1pR?=
 =?utf-8?B?K0VpYWFDdTRiQzE5RnJHbHNiVTRXVTZSYkR3dkdKQjhRcXRsL3lISHdrKy95?=
 =?utf-8?B?UHVmdXVYS3hpUnZnYlY1K29ycGNPL3hZcGFUL011VnVod054eC9XZDFscDM4?=
 =?utf-8?B?b3FQSDQ5U2lFZkYwSWZnUWg2NzdNNlZpRDg3aDBmUERLMzErUzgrY01XSmdV?=
 =?utf-8?B?OGhWT3JHb0kxazNoQld2b000RFZheW9zUHowTVVQU3ZkSmVlYUJldCtMclVH?=
 =?utf-8?B?UzNqdm5ielNiWC85dmNJb3h0NDV4UUdQSlIrcVliaTZqOU5PUUhrVzNia1FN?=
 =?utf-8?B?aDJtNDVzbkpUWlppeFloVHJJQ2pNTm1qY0l6eTJvLzJVQ0w4Z0xmaWdzdVNI?=
 =?utf-8?B?aWM0bjNRMUttU2IrMjI3MEx4MkdVdUZvZUV1R0ovTkl6eS9TOXZ6TlZiVEcw?=
 =?utf-8?B?M3RrQ1lYRzFzME9UeU1DcEVvdjV1S2hLY2dBTjMvaFcxUzl1VWE5NE9qaTJz?=
 =?utf-8?B?SGx6TFJYVTlpK2JBaUdTNWlYSzd4SkxKVEVQTytMVUJTT2MvQ2lyZEdYR2dY?=
 =?utf-8?B?SVoxdEFUUmlTRlJoK2ExMExkSit6WlFrVDNucEhIRFpJM2VtbmJCajRFZzRs?=
 =?utf-8?B?NE14MFN1YU15aXNFTlNQNDlEbWdkcFlkUDAxTVdGUUNMbTRRRzcwLzFQVEtp?=
 =?utf-8?B?RUI3V1E5aTFObEVBTnRxYXZvalNmRStidW10czV3SHgwdWlqemt0Q003QUM0?=
 =?utf-8?B?NnF0VFlaQlN6VVU0bFlhT2hCaENNMGx6ZFdabmNrTFlxMDJrOVc1TnJmTldJ?=
 =?utf-8?B?NVVQK1FSLzd4ejZDVERRN3ErZ1VyY1JGQ0hjSWRnbEFGUnpwcHRjS1NBVkdw?=
 =?utf-8?B?ZWFtVXIrV0Z2YSswMWhxd3QyOXkwZGIyZWJJSHQ2dTRjS3A0K0JMSUExRkZj?=
 =?utf-8?B?NGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <100F96E2026BDA498D5BCEE872D635F5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb09174-7325-4ec3-e7c7-08db7288ea95
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 18:54:17.9620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y9wU4d47+0jE6yibB1ohljXEDkjRx5hnF0l/pSo9PUiT8lrzwhtc9Rf0QY8pD0KAul3zfiWaCM3Aana4yc1md8RRpRIYiVZNEJq+JMjP45g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4933
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

T24gV2VkLCAyMDIzLTA2LTIxIGF0IDEyOjM2ICswMTAwLCBzemFib2xjcy5uYWd5QGFybS5jb20g
d3JvdGU6DQo+ID4gVGhlIDA2LzIwLzIwMjMgMTk6MzQsIEVkZ2Vjb21iZSwgUmljayBQIHdyb3Rl
Og0KPiA+ID4gPiBPbiBUdWUsIDIwMjMtMDYtMjAgYXQgMTA6MTcgKzAxMDAsIHN6YWJvbGNzLm5h
Z3lAYXJtLmNvbcKgd3JvdGU6DQo+ID4gPiA+ID4gPiBpZiB0aGVyZSBpcyBhIGZpeCB0aGF0J3Mg
Z29vZCwgaSBoYXZlbid0IHNlZW4gaXQuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IG15IHBv
aW50IHdhcyB0aGF0IHRoZSBjdXJyZW50IHVud2luZGVyIHdvcmtzIHdpdGggY3VycmVudA0KPiA+
ID4gPiA+ID4ga2VybmVsDQo+ID4gPiA+ID4gPiBwYXRjaGVzLCBidXQgZG9lcyBub3QgYWxsb3cg
ZnV0dXJlIGV4dGVuc2lvbnMgd2hpY2gNCj4gPiA+ID4gPiA+IHByZXZlbnRzDQo+ID4gPiA+ID4g
PiBzaWdhbHRzaHN0ayB0byB3b3JrLiB0aGUgdW53aW5kZXIgaXMgbm90IHZlcnNpb25lZCBzbyB0
aGlzDQo+ID4gPiA+ID4gPiBjYW5ub3QNCj4gPiA+ID4gPiA+IGJlIGZpeGVkIGxhdGVyLiBpdCBv
bmx5IHdvcmtzIGlmIGRpc3Ryb3MgZW5zdXJlIHNoc3RrIGlzDQo+ID4gPiA+ID4gPiBkaXNhYmxl
ZA0KPiA+ID4gPiA+ID4gdW50aWwgdGhlIHVud2luZGVyIGlzIGZpeGVkLiAoaG93ZXZlciB0aGVy
ZSBpcyBubyB3YXkgdG8NCj4gPiA+ID4gPiA+IGRldGVjdA0KPiA+ID4gPiA+ID4gb2xkIHVud2lu
ZGVyIGlmIHNvbWVib2R5IGJ1aWxkcyBnY2MgZnJvbSBzb3VyY2UuKQ0KPiA+ID4gPiANCj4gPiA+
ID4gVGhpcyBpcyBhIHByb2JsZW0gdGhlIGtlcm5lbCBpcyBoYXZpbmcgdG8gZGVhbCB3aXRoLCBu
b3QNCj4gPiA+ID4gY2F1c2luZy4gPiA+IFRoZQ0KPiA+ID4gPiB1c2Vyc3BhY2UgY2hhbmdlcyB3
ZXJlIHVwc3RyZWFtZWQgYmVmb3JlIHRoZSBrZXJuZWwuIFVzZXJzcGFjZQ0KPiA+ID4gPiA+ID4g
Zm9sa3MNCj4gPiA+ID4gYXJlIGFkYW1hbnRseSBhZ2FpbnN0IG1vdmluZyB0byBhIG5ldyBlbGYg
Yml0LCB0byBzdGFydCBvdmVyDQo+ID4gPiA+IHdpdGggYQ0KPiA+ID4gPiBjbGVhbiBzbGF0ZS4g
SSB0cmllZCBldmVyeXRoaW5nIHRvIGluZmx1ZW5jZSB0aGlzIGFuZCB3YXMgbm90DQo+ID4gPiA+
IHN1Y2Nlc3NmdWwuIFNvIEknbSBzdGlsbCBub3Qgc3VyZSB3aGF0IHRoZSBwcm9wb3NhbCBoZXJl
IGlzIGZvcg0KPiA+ID4gPiB0aGUNCj4gPiA+ID4ga2VybmVsLg0KPiA+IA0KPiA+IGkgYWdyZWUs
IHRoZSBnbGliYyBhbmQgbGliZ2NjIHBhdGNoZXMgc2hvdWxkIG5vdCBoYXZlIGJlZW4gYWNjZXB0
ZWQNCj4gPiBiZWZvcmUgYSBsaW51eCBhYmkuDQo+ID4gDQo+ID4gYnV0IHRoZSBvdGhlciBkaXJl
Y3Rpb24gYWxzbyBob2xkczogdGhlIGxpbnV4IHBhdGNoZXMgc2hvdWxkIG5vdCBiZQ0KPiA+IHB1
c2hlZCBiZWZvcmUgdGhlIHVzZXJzcGFjZSBkZXNpZ24gaXMgZGlzY3Vzc2VkLiAodGhlIGN1cnJl
bnQgY29kZQ0KPiA+IHVwc3RyZWFtIGlzIHdyb25nLCBhbmQgbmV3IGNvZGUgZm9yIHRoZSBwcm9w
b3NlZCBsaW51eCBhYmkgaXMgbm90DQo+ID4gcG9zdGVkIHlldC4gdGhpcyBpcyBub3QgeW91ciBm
YXVsdCwgaSdtIHNheWluZyBpdCBoZXJlLCBiZWNhdXNlIHRoZQ0KPiA+IGRpc2N1c3Npb24gaXMg
aGVyZS4pDQoNClRoaXMgc2VyaWVzIGhhcyBiZWVuIGRpc2N1c3NlZCB3aXRoIGdsaWJjL2djYyBk
ZXZlbG9wZXJzIHJlZ3VsYXJseQ0KdGhyb3VnaG91dCB0aGUgZW5hYmxpbmcgZWZmb3J0LiBJbiBm
YWN0IHRoZXJlIGhhdmUgYmVlbiBvbmdvaW5nDQpkaXNjdXNzaW9ucyBhYm91dCBmdXR1cmUgc2hh
ZG93IHN0YWNrIGZ1bmN0aW9uYWxpdHkuIA0KDQpJdCdzIG5vdCBsaWtlIHRoaXMgZmVhdHVyZSBo
YXMgYmVlbiBhIGZhc3Qgb3IgaGlkZGVuIGVmZm9ydC4gWW91IGFyZQ0KanVzdCB3YWxraW5nIGlu
dG8gdGhlIHRhaWwgZW5kIG9mIGl0LiAobXVjaCBvZiBpdCBwcmVkYXRlcyBteQ0KaW52b2x2ZW1l
bnQgQlRXLCBpbmNsdWRpbmcgdGhlIGluaXRpYWwgZ2xpYmMgc3VwcG9ydCkNCg0KQUZBSUsgSEog
cHJlc2VudGVkIHRoZSBlbmFibGluZyBjaGFuZ2VzIGF0IHNvbWUgZ2xpYmMgbWVldGluZy4gVGhl
DQpzaWduYWwgc2lkZSBvZiBnbGliYyBpcyB1bmNoYW5nZWQgZnJvbSB3aGF0IGlzIGFscmVhZHkg
dXBzdHJlYW0uIFNvIEknbQ0Kbm90IHN1cmUgY2hhcmFjdGVyaXppbmcgaXQgdGhhdCB3YXkgaXMg
ZmFpci4gSXQgc2VlbXMgeW91IHdlcmUgbm90IHBhcnQNCm9mIHRob3NlIG9sZCBkaXNjdXNzaW9u
cywgYnV0IHRoYXQgbWlnaHQgYmUgYmVjYXVzZSB5b3VyIGludGVyZXN0IGlzDQpuZXcuIEluIGFu
eSBjYXNlIHdlIGFyZSBjb25zdHJhaW5lZCBieSBzb21lIG9mIHRoZXNlIGVhcmxpZXIgb3V0Y29t
ZXMuDQpNb3JlIG9uIHRoYXQgYmVsb3cuDQoNCj4gPiANCj4gPiA+ID4gSSBhbSBndWVzc2luZyB0
aGF0IHRoZSBmbm9uLWNhbGwtZXhjZXB0aW9ucy9leHBhbmRlZCBmcmFtZSBzaXplDQo+ID4gPiA+
IGluY29tcGF0aWJpbGl0aWVzIGNvdWxkIGVuZCB1cCBjYXVzaW5nIHNvbWV0aGluZyB0byBncm93
IGFuDQo+ID4gPiA+IG9wdC1pbiA+ID4gYXQNCj4gPiA+ID4gc29tZSBwb2ludC4NCj4gPiANCj4g
PiB0aGVyZSBhcmUgaW5kZXBlbmRlbnQgdXNlcnNwYWNlIGNvbXBvbmVudHMgYW5kIG5vdCBldmVy
eSBjb21wb25lbnQNCj4gPiBoYXMgYSBjaGFuY2UgdG8gb3B0LWluLg0KPiA+IA0KPiA+ID4gPiA+
ID4gaG93IGRvZXMgImZpeGVkIHNoYWRvdyBzdGFjayBzaWduYWwgZnJhbWUgc2l6ZSIgcmVsYXRl
cyB0bw0KPiA+ID4gPiA+ID4gIi1mbm9uLWNhbGwtZXhjZXB0aW9ucyI/DQo+ID4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiA+IGlmIHRoZXJlIHdlcmUgaW5zdHJ1Y3Rpb24gYm91bmRhcmllcyB3aXRoaW4g
YSBmdW5jdGlvbg0KPiA+ID4gPiA+ID4gd2hlcmUgdGhlDQo+ID4gPiA+ID4gPiByZXQgYWRkciBp
cyBub3QgeWV0IHB1c2hlZCBvciBhbHJlYWR5IHBvcGVkIGZyb20gdGhlIHNoc3RrDQo+ID4gPiA+
ID4gPiB0aGVuDQo+ID4gPiA+ID4gPiB0aGUgZmxhZyB3b3VsZCBiZSByZWxldmFudCwgYnV0IHNp
bmNlIHB1c2gvcG9wIGhhcHBlbnMNCj4gPiA+ID4gPiA+IGF0b21pY2FsbHkNCj4gPiA+ID4gPiA+
IGF0IGZ1bmN0aW9uIGVudHJ5L3JldHVybiAtZm5vbi1jYWxsLWV4Y2VwdGlvbnMgbWFrZXMgbm8N
Cj4gPiA+ID4gPiA+IGRpZmZlcmVuY2UgYXMgZmFyIGFzIHNoc3RrIHVud2luZGluZyBpcyBjb25j
ZXJuZWQuDQo+ID4gPiA+IA0KPiA+ID4gPiBBcyBJIHNhaWQsIHRoZSBleGlzdGluZyB1bndpbmRp
bmcgY29kZSBmb3IgZm5vbi1jYWxsLQ0KPiA+ID4gPiBleGNlY3B0aW9ucw0KPiA+ID4gPiBhc3N1
bWVzIGEgZml4ZWQgc2hhZG93IHN0YWNrIHNpZ25hbCBmcmFtZSBzaXplIG9mIDggYnl0ZXMuDQo+
ID4gPiA+IFNpbmNlID4gPiB0aGUNCj4gPiA+ID4gZXhjZXB0aW9uIGlzIHRocm93biBvdXQgb2Yg
YSBzaWduYWwsIGl0IG5lZWRzIHRvIGtub3cgaG93IHRvDQo+ID4gPiA+IHVud2luZA0KPiA+ID4g
PiB0aHJvdWdoIHRoZSBzaGFkb3cgc3RhY2sgc2lnbmFsIGZyYW1lLg0KPiA+IA0KPiA+IHNvcnJ5
IGJ1dCB0aGVyZSBpcyBzb21lIG1pc3VuZGVyc3RhbmRpbmcgYWJvdXQgLWZub24tY2FsbC0NCj4g
PiBleGNlcHRpb25zLg0KPiA+IA0KPiA+IGl0IGlzIGZvciBlbWl0dGluZyBjbGVhbnVwIGFuZCBl
eGNlcHRpb24gaGFuZGxlciBkYXRhIGZvciBhDQo+ID4gZnVuY3Rpb24NCj4gPiBzdWNoIHRoYXQg
dGhyb3dpbmcgZnJvbSBjZXJ0YWluIGluc3RydWN0aW9ucyB3aXRoaW4gdGhhdCBmdW5jdGlvbg0K
PiA+IHdvcmtzLCB3aGlsZSBub3JtYWxseSBvbmx5IHRocm93aW5nIGZyb20gY2FsbHMgd29yay4N
Cj4gPiANCj4gPiBpdCBpcyBub3QgYWJvdXQgKnVud2luZGluZyogZnJvbSBhbiBhc3luYyBzaWdu
YWwgaGFuZGxlciwgd2hpY2ggaXMNCj4gPiAtZmFzeW5jaHJvbm91cy11bndpbmQtdGFibGVzIGFu
ZCBzaG91bGQgYWx3YXlzIHdvcmsgb24gbGludXgsIG5vcg0KPiA+IGZvcg0KPiA+IGRlYWxpbmcg
d2l0aCBjbGVhbnVwL2V4Y2VwdGlvbiBoYW5kbGVycyBhYm92ZSB0aGUgaW50ZXJydXB0ZWQgZnJh
bWUNCj4gPiAobGlrZXdpc2UgaXQgd29ya3Mgb24gbGludXggd2l0aG91dCBzcGVjaWFsIGNmbGFn
cykuDQo+ID4gDQo+ID4gYXMgZmFyIGFzIGkgY2FuIHRlbGwgdGhlIGN1cnJlbnQgdW53aW5kZXIg
aGFuZGxlcyBzaHN0ayB1bndpbmRpbmcNCj4gPiBjb3JyZWN0bHkgYWNyb3NzIHNpZ25hbCBoYW5k
bGVycyAoc3luYyBvciBhc3luYyBhbmQgPg0KPiA+IGNsZWFudXAvZXhjZXB0aW9ucw0KPiA+IGhh
bmRsZXJzIHRvbyksIGkgc2VlIG5vIGlzc3VlIHdpdGggImZpeGVkIHNoYWRvdyBzdGFjayBzaWdu
YWwgZnJhbWUNCj4gPiBzaXplIG9mIDggYnl0ZXMiIG90aGVyIHRoYW4gZnV0dXJlIGV4dGVuc2lv
bnMgYW5kIGRpc2NvbnRpbm91cw0KPiA+IHNoc3RrLg0KDQpISiwgY2FuIHlvdSBsaW5rIHlvdXIg
cGF0Y2ggdGhhdCBtYWtlcyBpdCBleHRlbnNpYmxlIGFuZCB3ZSBjYW4gY2xlYXINCnRoaXMgdXA/
IE1heWJlIHRoZSBpc3N1ZSBleHRlbmRzIGJleW9uZCBmbm9uLWNhbGwtZXhjZXB0aW9ucywgYnV0
IHRoYXQNCmlzIHdoZXJlIEkgcmVwcm9kdWNlZCBpdC4NCg0KPiA+IA0KPiA+ID4gPiA+ID4gdGhl
cmUgaXMgbm8gbWFnaWMsIGxvbmdqbXAgc2hvdWxkIGJlIGltcGxlbWVudGVkIGFzOg0KPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgdGFyZ2V0X3NzcCA9IHJlYWQgZnJv
bSBqbXBidWY7DQo+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgY3VycmVudF9zc3AgPSByZWFk
IHNzcDsNCj4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqBmb3IgKHAgPSB0YXJnZXRfc3NwOyBw
ICE9IGN1cnJlbnRfc3NwOyBwLS0pIHsNCj4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgaWYgKCpwID09IHJlc3RvcmUtdG9rZW4pIHsNCj4gPiA+ID4gPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8vIHRhcmdldF9zc3Ag
aXMgb24gYSBkaWZmZXJlbnQNCj4gPiA+ID4gPiA+IHNoc3RrLg0KPiA+ID4gPiA+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3dpdGNoX3Noc3RrX3Rv
KHApOw0KPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgYnJlYWs7DQo+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoH0NCj4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqB9DQo+ID4gPiA+ID4gPiDCoMKgwqDC
oMKgwqDCoMKgZm9yICg7IHAgIT0gdGFyZ2V0X3NzcDsgcCsrKQ0KPiA+ID4gPiA+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvLyBzc3AgaXMgbm93IG9uIHRoZSBzYW1lIHNoc3Rr
IGFzIHRhcmdldC4NCj4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
aW5jX3NzcCgpOw0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiB0aGlzIGlzIHdoYXQgc2V0Y29u
dGV4dCBpcyBkb2luZyBhbmQgbG9uZ2ptcCBjYW4gZG8gdGhlDQo+ID4gPiA+ID4gPiBzYW1lOg0K
PiA+ID4gPiA+ID4gZm9yIHByb2dyYW1zIHRoYXQgYWx3YXlzIGxvbmdqbXAgd2l0aGluIHRoZSBz
YW1lIHNoc3RrIHRoZQ0KPiA+ID4gPiA+ID4gZmlyc3QNCj4gPiA+ID4gPiA+IGxvb3AgaXMganVz
dCBwID0gY3VycmVudF9zc3AsIGJ1dCBpdCBhbHNvIHdvcmtzIHdoZW4NCj4gPiA+ID4gPiA+IGxv
bmdqbXANCj4gPiA+ID4gPiA+IHRhcmdldCBpcyBvbiBhIGRpZmZlcmVudCBzaHN0ayBhc3N1bWlu
ZyBub3RoaW5nIGlzIHJ1bm5pbmcNCj4gPiA+ID4gPiA+IG9uDQo+ID4gPiA+ID4gPiB0aGF0IHNo
c3RrLCB3aGljaCBpcyBvbmx5IHBvc3NpYmxlIGlmIHRoZXJlIGlzIGEgcmVzdG9yZQ0KPiA+ID4g
PiA+ID4gdG9rZW4NCj4gPiA+ID4gPiA+IG9uIHRvcC4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gdGhpcyBpbXBsaWVzIGlmIHRoZSBrZXJuZWwgc3dpdGNoZXMgc2hzdGsgb24gc2lnbmFsIGVu
dHJ5DQo+ID4gPiA+ID4gPiBpdCBoYXMNCj4gPiA+ID4gPiA+IHRvIGFkZCBhIHJlc3RvcmUtdG9r
ZW4gb24gdGhlIHN3aXRjaGVkIGF3YXkgc2hzdGsuDQo+ID4gPiA+IA0KPiA+ID4gPiBJIGFjdHVh
bGx5IGRpZCBhIFBPQyBmb3IgdGhpcywgYnV0IHJlamVjdGVkIGl0LiBUaGUgcHJvYmxlbSBpcywN
Cj4gPiA+ID4gaWYNCj4gPiA+ID4gdGhlcmUgaXMgYSBzaGFkb3cgc3RhY2sgb3ZlcmZsb3cgYXQg
dGhhdCBwb2ludCB0aGVuIHRoZSBrZXJuZWwNCj4gPiA+ID4gPiA+IGNhbid0DQo+ID4gPiA+IHB1
c2ggdGhlIHNoYWRvdyBzdGFjayB0b2tlbiB0byB0aGUgb2xkIHN0YWNrLiBBbmQgc2hhZG93IHN0
YWNrDQo+ID4gPiA+ID4gPiBvdmVyZmxvdw0KPiA+ID4gPiBpcyBleGFjdGx5IHRoZSBhbHQgc2hh
ZG93IHN0YWNrIHVzZSBjYXNlLiBTbyBpdCBkb2Vzbid0IHJlYWxseQ0KPiA+ID4gPiA+ID4gc29s
dmUNCj4gPiA+ID4gdGhlIHByb2JsZW0uDQo+ID4gDQo+ID4gdGhlIHJlc3RvcmUgdG9rZW4gaW4g
dGhlIGFsdCBzaHN0ayBjYXNlIGRvZXMgbm90IHJlZ3Jlc3MgYW55dGhpbmcNCj4gPiBidXQNCj4g
PiBtYWtlcyBzb21lIHVzZS1jYXNlcyB3b3JrLg0KPiA+IA0KPiA+IGFsdCBzaGFkb3cgc3RhY2sg
aXMgaW1wb3J0YW50IGlmIGNvZGUgdHJpZXMgdG8ganVtcCBpbiBhbmQgb3V0IG9mDQo+ID4gc2ln
bmFsIGhhbmRsZXJzIChkb3NlbXUgZG9lcyB0aGlzIHdpdGggc3dhcGNvbnRleHQpIGFuZCBmb3Ig
dGhhdCBhDQo+ID4gcmVzdG9yZSB0b2tlbiBpcyBuZWVkZWQuDQo+ID4gDQo+ID4gYWx0IHNoYWRv
dyBzdGFjayBpcyBpbXBvcnRhbnQgaWYgdGhlIG9yaWdpbmFsIHNoc3RrIGRpZCBub3QNCj4gPiBv
dmVyZmxvdw0KPiA+IGJ1dCB0aGUgc2lnbmFsIGhhbmRsZXIgd291bGQgb3ZlcmZsb3cgaXQgKHNt
YWxsIHRocmVhZCBzdGFjaywgaHVnZQ0KPiA+IHNpZ2FsdHN0YWNrIGNhc2UpLg0KPiA+IA0KPiA+
IGFsdCBzaGFkb3cgc3RhY2sgaXMgYWxzbyBpbXBvcnRhbnQgZm9yIGNyYXNoIHJlcG9ydGluZyBv
biBzaHN0aw0KPiA+IG92ZXJmbG93IGV2ZW4gaWYgbG9uZ2ptcCBkb2VzIG5vdCB3b3JrIHRoZW4u
IGxvbmdqbXAgdG8gYQ0KPiA+IG1ha2Vjb250ZXh0DQo+ID4gc3RhY2sgd291bGQgc3RpbGwgd29y
ayBhbmQgbG9uZ2ptcCBiYWNrIHRvIHRoZSBvcmlnaW5hbCBzdGFjayBjYW4NCj4gPiBiZQ0KPiA+
IG1hZGUgdG8gbW9zdGx5IHdvcmsgYnkgYW4gYWx0c2hzdGsgb3B0aW9uIHRvIG92ZXJ3cml0ZSB0
aGUgdG9wDQo+ID4gZW50cnkNCj4gPiB3aXRoIGEgcmVzdG9yZSB0b2tlbiBvbiBvdmVyZmxvdyAo
dGhpcyBjYW4gYnJlYWsgdW53aW5kaW5nIHRob3VnaCkuDQo+ID4gDQoNClRoZXJlIHdhcyBwcmV2
aW91c2x5IGEgcmVxdWVzdCB0byBjcmVhdGUgYW4gYWx0IHNoYWRvdyBzdGFjayBmb3IgdGhlDQpw
dXJwb3NlIG9mIGhhbmRsaW5nIHNoYWRvdyBzdGFjayBvdmVyZmxvdy4gU28geW91IGFyZSBub3cg
c3VnZ2VzdGluZyB0bw0KdG8gZXhjbHVkZSB0aGF0IGFuZCBpbnN0ZWFkIHRhcmdldCBhIGRpZmZl
cmVudCB1c2UgY2FzZSBmb3IgYWx0IHNoYWRvdw0Kc3RhY2s/DQoNCkJ1dCBJJ20gbm90IHN1cmUg
aG93IG11Y2ggd2Ugc2hvdWxkIGNoYW5nZSB0aGUgQUJJIGF0IHRoaXMgcG9pbnQgc2luY2UNCndl
IGFyZSBjb25zdHJhaW5lZCBieSBleGlzdGluZyB1c2Vyc3BhY2UuIElmIHlvdSByZWFkIHRoZSBo
aXN0b3J5LCB3ZQ0KbWF5IGVuZCB1cCBuZWVkaW5nIHRvIGRlcHJlY2F0ZSB0aGUgd2hvbGUgZWxm
IGJpdCBmb3IgdGhpcyBhbmQgb3RoZXINCnJlYXNvbnMuDQoNClNvIHNob3VsZCB3ZSBzdHJ1Z2ds
ZSB0byBmaW5kIGEgd2F5IHRvIGdyb3cgdGhlIGV4aXN0aW5nIEFCSSB3aXRob3V0DQpkaXN0dXJi
aW5nIHRoZSBleGlzdGluZyB1c2Vyc3BhY2U/IE9yIHNob3VsZCB3ZSBzdGFydCB3aXRoIHNvbWV0
aGluZywNCmZpbmFsbHksIGFuZCBzZWUgd2hlcmUgd2UgbmVlZCB0byBncm93IGFuZCBtYXliZSBn
ZXQgYSBjaGFuY2UgYXQgYQ0KZnJlc2ggc3RhcnQgdG8gZ3JvdyBpdD8NCg0KTGlrZSwgbWF5YmUg
MyBwZW9wbGUgd2lsbCBzaG93IHVwIHNheWluZyAiaGV5LCBJICpyZWFsbHkqIG5lZWQgdG8gdXNl
DQpzaGFkb3cgc3RhY2sgYW5kIGxvbmdqbXAgZnJvbSBhIHVjb250ZXh0IHN0YWNrIiwgYW5kIG5v
IG9uZSBzYXlzDQphbnl0aGluZyBhYm91dCBzaGFkb3cgc3RhY2sgb3ZlcmZsb3cuIFRoZW4gd2Ug
a25vdyB3aGF0IHRvIGRvLiBBbmQNCm1heWJlIGRvc2VtdSBkZWNpZGVzIGl0IGRvZXNuJ3QgbmVl
ZCB0byBpbXBsZW1lbnQgc2hhZG93IHN0YWNrIChoaWdobHkNCmxpa2VseSBJIHdvdWxkIHRoaW5r
KS4gTm93IHRoYXQgSSB0aGluayBhYm91dCBpdCwgQUZBSVUgU1NfQVVUT0RJU0FSTQ0Kd2FzIGNy
ZWF0ZWQgZm9yIGRvc2VtdSwgYW5kIHRoZSBhbHQgc2hhZG93IHN0YWNrIHBhdGNoIGFkb3B0ZWQg
dGhpcw0KYmVoYXZpb3IuIFNvIGl0J3Mgc3BlY3VsYXRpb24gdGhhdCB0aGVyZSBpcyBldmVuIGEg
cHJvYmxlbSBpbiB0aGF0DQpzY2VuYXJpby4NCg0KT3IgbWF5YmUgcGVvcGxlIGp1c3QgZW5hYmxl
IFdSU1MgZm9yIGxvbmdqbXAoKSBhbmQgZGlyZWN0bHkganVtcCBiYWNrDQp0byB0aGUgc2V0am1w
KCkgcG9pbnQuIERvIG1vc3QgcGVvcGxlIHdhbnQgZmFzdCBzZXRqbXAvbG9uZ2ptcCgpIGF0IHRo
ZQ0KY29zdCBvZiBhIGxpdHRsZSBzZWN1cml0eT8NCg0KRXZlbiBpZiwgd2l0aCBlbm91Z2ggZGlz
Y3Vzc2lvbiwgd2UgY291bGQgb3B0aW1pemUgZm9yIGFsbA0KaHlwb3RoZXRpY2FscyB3aXRob3V0
IHJlYWwgdXNlciBmZWVkYmFjaywgSSBkb24ndCBzZWUgaG93IGl0IGhlbHBzDQp1c2VycyB0byBo
b2xkIHNoYWRvdyBzdGFjay4gU28gSSB0aGluayB3ZSBzaG91bGQgbW92ZSBmb3J3YXJkIHdpdGgg
dGhlDQpjdXJyZW50IEFCSS4NCg0KDQo=
