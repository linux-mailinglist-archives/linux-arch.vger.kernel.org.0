Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA494B1B62
	for <lists+linux-arch@lfdr.de>; Fri, 11 Feb 2022 02:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346939AbiBKBjH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Feb 2022 20:39:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346823AbiBKBjH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Feb 2022 20:39:07 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487FA5F8E;
        Thu, 10 Feb 2022 17:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644543547; x=1676079547;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Uo/Nk/wzP6C8XXo0042bUYchUiplpKzhF2U/FHig0s4=;
  b=NNGZ34n/dMTB0RVu7uplH9msUpnYGZWK6FuGQd8NYmoHygWOitC/7h/Y
   jDwDWjXeuJ1fP3WDib77JP2thTTAGs7B4rAl48seOvAiVVhxZgIWnSrtK
   99w230gm+dCIZFzZmxrjhrwsrjFc3LOW5myt+qDjxbogTR23i0cgyf+yh
   KtM382L4XWNMv7YwVCDkiQJWNWkri+JSJ+Xv4zTbysvcHWHliL8b1C4OY
   EiqssdRLQj9o8lGLFgtDYK/chwJoTcNiyIlCqWRl2LQz4PItfb6mfMmth
   p3x1lY8WIfWvPnVA4cny9WpESs/RJ8gJRhNrHNQocICHl2vp7ZkoQg43G
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="248467440"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="248467440"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 17:39:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="623064631"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Feb 2022 17:39:06 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 10 Feb 2022 17:39:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 10 Feb 2022 17:39:05 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 10 Feb 2022 17:39:05 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 10 Feb 2022 17:39:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ii7twY5zmPlHkK99p9k5u4jg7IU6UeDg8pAF3au9UUw2aD1Fsz/9pabsqBq3wmLklfo+Q9dJ9aA11EjU4SpatChfg+JkOdBJ+LF71/NeyXxyYM3iBdwIlZ8lYn+EAuO9/zQsOkp6gJleBEAE3pZGT3j7KH9KeqcT7wqX/ver9zaFtWizy159eMY2MQGegJKR8+QupY3n2Wh7VETexNnOmtqT3ScVLvRqbCjMZrt8bfscESeSwi3X4NHjePyiFFc02ud6Tq+4ZeWbV0s8XfTxGnJ7CMyBiswttklX9XR8n9wt4jfPjBqejm3SjZ1bSy3htKdDbT8H1/Sm4rkO+wZEPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uo/Nk/wzP6C8XXo0042bUYchUiplpKzhF2U/FHig0s4=;
 b=PctAx1I42PrUmaqVS7SwZ5o4bh3EvqhiJzAac12r94QrYtvPWrLcUFbaGaPifBmygVSpuBpU+Mlc+1/9kENLJTjPVMKwPEsFoI49DqWnXQYJT/8Ri5qxuGoAKQW431zPAaENWNsYvdnX4Dh25NzaBQoCCty8xdXM8vxEjTgF3Pyc2LYT6X7qLixckp4l6Nldzsqr9wss1FziDUqpzvlOGgkitDtSSt6vcZBNx8OiOLEoWKHNQ/kM77ryG4y2Yu3SqojN2OfcdyIN+T2SkzC4yhUR2SVxo06TMer1fpJ+mKrmjvOwTMDOhzcdGbFwqouswg3OxmbK2Sg1BnC1Bz0SqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BN6PR11MB1281.namprd11.prod.outlook.com (2603:10b6:404:47::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 01:39:02 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15%4]) with mapi id 15.20.4951.021; Fri, 11 Feb 2022
 01:39:01 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
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
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
CC:     "Wang, Zhi A" <zhi.a.wang@intel.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>
Subject: Re: [PATCH 10/35] drm/i915/gvt: Change _PAGE_DIRTY to
 _PAGE_DIRTY_BITS
Thread-Topic: [PATCH 10/35] drm/i915/gvt: Change _PAGE_DIRTY to
 _PAGE_DIRTY_BITS
Thread-Index: AQHYFh9vdtBQu39zq06k5MnACkwSaKyLgDcAgAIj0wA=
Date:   Fri, 11 Feb 2022 01:39:01 +0000
Message-ID: <04cbcff2e28e378ece76ab1735a81b945583ad7b.camel@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
         <20220130211838.8382-11-rick.p.edgecombe@intel.com>
         <a5bb32b8-8bd7-ac98-5c4c-5af604ac8256@intel.com>
In-Reply-To: <a5bb32b8-8bd7-ac98-5c4c-5af604ac8256@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a336e8d-714e-442c-ca30-08d9ecff4819
x-ms-traffictypediagnostic: BN6PR11MB1281:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB12815E712AA58F6BDE559DEDC9309@BN6PR11MB1281.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2MLVzvgsc+/LVgzb7Im99016iAgmtRJrEprtNgLOQHsoU6G/tPX5t4w5Ht7Qpp6dDpXNWEI49uQEKEIeWNjzV0suOVKdNORDGaxFeTbl6X3/SkR6A3STPzl6eol/8E2F0yRBttj+7WBLL8Sy9DBtcEOmoTmkG9Rhw5UKKleICJAReH687tyYDJbcprtCoEloN+jIpE4Bp1rE6BOc/fidLFN00c2riPEWdGu3E8Ur8vTePVbsPzRcMiBuKja6eVArxIgB7o73NlRxX6k/VFLSUTEu+5+ypXYELfLG2IZaG7w/6nX8vq353ou9cvUmX0mdzFBY5IZTcQowM2PNkSGV3JV3tlwLrLquBSXcn3YG+87kKapBTFN/gz1pXwDHyRZMJmvoxhqYWnKrKXtwxMV/O5hRewoQetgR/I2JwAudHzIDm2wmtP1eaAjY35TqBKl0+xIJSoA7HJE6Ylmm8hF22Wl+p2wb4ivI3s6yzdNWZpiq3aCECxjdLRgcj+SUg3w4Pj4DbLjN63wV9vnb+5ivWrjTzSubXTJOeEG+Ro0kLtJndcWUzgUChevbO0vGRZKgqxxetxznpJyBIbQUGAGZZH9FHWGdQl85tEsMTNr9s/GLWW9aBJMgHsgM/ITEjtKD6MPipWmZteL9EmBJi4MVYCGOG7jtCw/3ClLbUc+T4XnIJFRxNW1ziEe6HjlUGC7He8jCTgeuCaZCXCfswAMkkLx/4DPd5ysmSN3IBacjgwXQAtWoXAzxGdqEOg1fvoxSj5mwMzEIdniZe9rpY3OApQ8nSd9reaAPYwtqFZU7lZ10kcSgWpPpNRRyk2CpKu19JMd2hAIxv6sNdKXCy3jKcPVoC5bZtWImMmYmTNSsWPUPtlU/Dk23RSdsh8vnA7XLBLLzZ7IAFtbxDyc0f9+Z2g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(64756008)(8676002)(4326008)(53546011)(8936002)(6486002)(66476007)(26005)(66556008)(66946007)(6506007)(5660300002)(966005)(2616005)(82960400001)(921005)(38100700002)(186003)(76116006)(122000001)(7406005)(7416002)(508600001)(83380400001)(54906003)(86362001)(316002)(38070700005)(36756003)(71200400001)(2906002)(6512007)(110136005)(99106002)(14143004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c05YTHo3ODdjUGI2RTNaTjdnRUkwMmhVUVUzT1N1RnV2ZlhnSXVCKzU5ektr?=
 =?utf-8?B?ZWZLaXdmQnhnbXArNC91MjJ1OVlPdXV6SmJFekp4OE1kWWE1a3RzaUJUN3hy?=
 =?utf-8?B?dHlySnF2bDBlbVhFaFBLdHFFU01ndjNpVWFMVG1TQlhNc1B3UkpqSzFKYXVy?=
 =?utf-8?B?UEdJYVQ0aTZCcGhDL1RVUC94RFNEQzV6Zlg1SkxaNWJWbHloUTVjYm1oK2RJ?=
 =?utf-8?B?eVVCUWhWVlV1a1N4Yk15Q3FBenZtYzdxb20rMktubGtpbFc4OWhleCt5UGlB?=
 =?utf-8?B?Zk9kQktiYXpvL0hxaVV2ZGhHY29QM2lWMVpodUh3cHBQWlVrUEFHY2F3dVJj?=
 =?utf-8?B?N0ZENkZ5a1RJKzhETUo2K0F2bnFRN2t2enVON0hqT1BGSkhwRFI2SkZZdFNK?=
 =?utf-8?B?NDVxY3o4RURoZU53VklpOHVhbitpZ0Zram96Wm5JRVB1dVAyb1l0YjR2UnBI?=
 =?utf-8?B?cjVqVDY1Y0tWT2tZWWorRVl1azVhUzNHZ1QrdVQwK3lBam40TDBjRVhOS2Nr?=
 =?utf-8?B?TFp6bWxhNWJ0eDc0QVFVSzhEN3EzQVRVTE1NNWMxVFlHbng2KzBTb251RlBo?=
 =?utf-8?B?NDR1dzZ3QUY5NzdiRUJIcFh3V092NUFWSUlWUncrcFhmRVRDMVh5c2tXVzY1?=
 =?utf-8?B?aXNrZVFLK0hGdUU3bTc3aDhhTXQ2K3JOdlRDdWJiYmxJM2EyRGY3dUlielNh?=
 =?utf-8?B?bm1ySGlTc1VXSWFYZlFYMDhRYmU3RnBCZWdFTkhWdlpwMlJ5VHNyRFBGSGhO?=
 =?utf-8?B?STRndHB1Q21VdUt0RlNLeDk0SUo5WUFzTUZOTnVDWWJPK0U3M0ZpaXJUYWYx?=
 =?utf-8?B?TkxRSHFvdDNUQ3BEeEZxaVRieEsrbWZ5bmVMdy9PSXc1ZnVRVDBUNmpYNEor?=
 =?utf-8?B?YzZrSTVxL1E2cnE2WFlRMGZ0SnVhbCswSDIrN3RzaGVMOTlGTTUzTnRETE5F?=
 =?utf-8?B?UU94c3ZZaTIxTVpMelVxd0FTWC9vY1AwTDZteWdZWG9EVW93SnFJdEExZmhn?=
 =?utf-8?B?aTQ3WlVKMWtmZ2NJVU56dC9jVkJmZ3ZHNFMyT09oSEdkN0JlTDdNZllnM3ln?=
 =?utf-8?B?M1hDM0pWU1luU29KeGlCZlNKNVljT3Rnc3hhekZZeHFRQkNzdUpHV2UydDBT?=
 =?utf-8?B?eWVzaFFxOFFLT25KejVqWkY0N0FXaHkvQ1JoQ1ZKeFBsSlBoUlViWDhyVG01?=
 =?utf-8?B?U0xCbnNhM3h1U1M4azRLQWpkR1JKbVdBcU5oUkNoZ21zYm4rU05pQjh6WFpJ?=
 =?utf-8?B?N2NENDBySkZuWWViYzZLSHNNcVI5TmNOZGN5ZHZWNFZ3QS9MMGd0ZUtNMFBo?=
 =?utf-8?B?MmVINkVUaEsybk1wRkU1YkNBcmVSVllrdTJUcEJtY0lUWjBQcTZYRWtuWVJS?=
 =?utf-8?B?K1Z6Y25WZ01NUGUvVG9NZ05ZQXpCNVhKLy83VWE5U202T1pUMmVBTzJkUWYv?=
 =?utf-8?B?cWp6UGVYTFVZOTB5QmhRbFdDbUlkbE5BU2ZJZ1VXMHBGMFZtMDVSck9zeG9C?=
 =?utf-8?B?cE8waXJleE9qMEM1eEZMcy96emhVT1RSaExyZTY4YUxXZGtNNDlQWTJNSE53?=
 =?utf-8?B?aEpTYk10NE5xVnVreFUwblBJRkZSM1liTDFlMnFpL0REVSt2bXZLMy9NSHpV?=
 =?utf-8?B?aG5FMVhTUDlCdXU5dUVJclAwMUI0Z3FuNVpKR0tXRGFIRGhSOCthWGM5T1Bl?=
 =?utf-8?B?eTlTNzAwTTVSQlltRlFyck4vemx3aUV4WWR0bTlGZ241MUI1TFAwY3VkRUI4?=
 =?utf-8?B?d0tsUHpsY0FOY3BlanBMWWJaaHZBRUFSKzNVbTZjc09oRGFuNVZzRGRGZ3Za?=
 =?utf-8?B?c1ZacXJIcFJSU0JVYVdOckV5VUZjQjRseklOck9nNERyR2VNWms2Y0dXb29w?=
 =?utf-8?B?V0ZkRURuOWsyZmZQSmFGbkRJS2tRTm5jY1c3aU1XemZaKy82bXRZbE85dHA2?=
 =?utf-8?B?VU1sU2tUaHJDSHB3blU3RGxjSFpkdFRybG4xTHN6UjlabmxGNFF1M2NxU3ZT?=
 =?utf-8?B?SkF0SzZZU2kycGxZK0tTZDl1blpNSk9Kb2hteXJUZjNNdDk3ZW10azJ5Y2lW?=
 =?utf-8?B?RHkvYXMrR0xIQUxoZHFCcmd6NjJ6MkhLUmNldTM1YnBQOS9EdW9XNHVpU1pv?=
 =?utf-8?B?ZGErYitUMnNaaDhXQ3VQKzFLTXhZV3R5MFJGQUZjdkVIRHFxNEVzeXhLVDBr?=
 =?utf-8?B?TUR3MUdxZUx5alhJNnp3VUcxcllrS3FsVFBMbEY3ay9WTFZtUjZNbWZjTmFN?=
 =?utf-8?Q?enlDpj7+yjE5Jx7+GUXnJGxVBgsd8tAPTkMiCYBevA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DA60266BBD40E48B65748ECB310D0D8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a336e8d-714e-442c-ca30-08d9ecff4819
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 01:39:01.8069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Utj8M49eXXm7TNaZEcbqVNYK/jBR+oxY67Z/ujbiKIPqHTswWpLLo8ntOv7ZjV6O+B3xMFNqvqatuL+naOMnfNxbXFwO2/gs6/DerNMsA2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1281
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Q0MgaW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KDQpUaHJlYWQ6IA0KaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGttbC9hNWJiMzJiOC04YmQ3LWFjOTgtNWM0Yy01YWY2MDRhYzgyNTZA
aW50ZWwuY29tLw0KDQpPbiBXZWQsIDIwMjItMDItMDkgYXQgMDg6NTggLTA4MDAsIERhdmUgSGFu
c2VuIHdyb3RlOg0KPiBPbiAxLzMwLzIyIDEzOjE4LCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToNCj4g
PiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZ3Z0L2d0dC5jDQo+ID4g
Yi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9ndnQvZ3R0LmMNCj4gPiBpbmRleCA5OWQxNzgxZmE1ZjAu
Ljc1Y2U0ZTgyMzkwMiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9ndnQv
Z3R0LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9ndnQvZ3R0LmMNCj4gPiBAQCAt
MTIxMCw3ICsxMjEwLDcgQEAgc3RhdGljIGludCBzcGxpdF8yTUJfZ3R0X2VudHJ5KHN0cnVjdA0K
PiA+IGludGVsX3ZncHUgKnZncHUsDQo+ID4gIAl9DQo+ID4gIA0KPiA+ICAJLyogQ2xlYXIgZGly
dHkgZmllbGQuICovDQo+ID4gLQlzZS0+dmFsNjQgJj0gfl9QQUdFX0RJUlRZOw0KPiA+ICsJc2Ut
PnZhbDY0ICY9IH5fUEFHRV9ESVJUWV9CSVRTOw0KPiA+ICANCj4gPiAgCW9wcy0+Y2xlYXJfcHNl
KHNlKTsNCj4gPiAgCW9wcy0+Y2xlYXJfaXBzKHNlKTsNCj4gDQo+IEFyZSB0aGVzZSB4ODYgQ1BV
IHBhZ2UgdGFibGUgdmFsdWVzPyAgSSBzZWUgLT52YWw2NCBiZWluZyB1c2VkIGxpa2UNCj4gdGhp
czoNCj4gDQo+ICAgICAgICAgZS0+dmFsNjQgJj0gfkdFTjhfUEFHRV9QUkVTRU5UOw0KPiBhbmQN
Cj4gCXNlLnZhbDY0IHw9IEdFTjhfUEFHRV9QUkVTRU5UIHwgR0VOOF9QQUdFX1JXOw0KPiANCj4g
d2hlcmUgd2UgYWxzbyBoYXZlOg0KPiANCj4gI2RlZmluZSBHRU44X1BBR0VfUFJFU0VOVCAgICAg
ICAgICAgICAgIEJJVF9VTEwoMCkNCj4gI2RlZmluZSBHRU44X1BBR0VfUlcgICAgICAgICAgICAg
ICAgICAgIEJJVF9VTEwoMSkNCj4gDQo+IFdoaWNoIHRlbGxzIG1lIHRoYXQgdGhlc2UgYXJlIHBy
b2JhYmx5ICpjbG9zZSogdG8gdGhlIENQVSdzIHBhZ2UNCj4gdGFibGVzLg0KPiAgQnV0LCBJIGhv
bmVzdGx5IGRvbid0IGtub3cgd2hpY2ggZm9ybWF0IHRoZXkgYXJlLiAgSSBkb24ndCBrbm93IGlm
DQo+IF9QQUdFX0NPVyBpcyBzdGlsbCBhIHNvZnR3YXJlIGJpdCBpbiB0aGF0IGZvcm1hdCBvciBu
b3QuDQo+IA0KPiBFaXRoZXIgd2F5LCBJIGRvbid0IHRoaW5rIHdlIHNob3VsZCBiZSBtZXNzaW5n
IHdpdGggaTkxNSBkZXZpY2UgcGFnZQ0KPiB0YWJsZXMuDQo+IA0KPiBPciwgYXJlIHRoZXNlIHNv
bWVob3cgbWFnaWNhbGx5IHNoYXJlZCB3aXRoIHRoZSBDUFUgaW4gc29tZSB3YXkgSQ0KPiBkb24n
dA0KPiBrbm93IGFib3V0Pw0KPiANCj4gWyBJZiB0aGVzZSBhcmUgZGV2aWNlLW9ubHkgcGFnZSB0
YWJsZXMsIGl0IHdvdWxkIHByb2JhYmx5IGJlIG5pY2UgdG8NCj4gICBzdG9wIHVzaW5nIF9QQUdF
X0ZPTyBmb3IgdGhlbS4gIEl0IHdvdWxkIGF2b2lkIGNvbmZ1c2lvbiBsaWtlIHRoaXMuDQo+IF0N
Cg0KVGhlIHR3byBSZXZpZXdlZC1ieSB0YWdzIGFyZSBnaXZpbmcgbWUgcGF1c2UsIGJ1dCBhcyBm
YXIgYXMgSSBjYW4gdGVsbA0KdGhpcyBzaG91bGQgbm90IGJlIHNldHRpbmcgX1BBR0VfRElSVFlf
QklUUy4gVGhpcyBjb2RlIHNlZW1zIHRvIGJlDQpzaGFkb3dpbmcgZ3Vlc3QgcGFnZSB0YWJsZXMs
IGFuZCB0aGUgY2hhbmdlIHdvdWxkIGNsZWFyIHRoZSBDT1cNCnNvZnR3YXJlIGJpdCBpbiB0aGUg
Z3Vlc3QgcGFnZSB0YWJsZXMuIFNvLCB5ZXMsIEkgdGhpbmsgdGhpcyBzaG91bGQgYmUNCmRyb3Bw
ZWQuDQo=
