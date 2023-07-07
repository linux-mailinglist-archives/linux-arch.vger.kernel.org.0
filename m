Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CF974B5E8
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jul 2023 19:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjGGRhy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Jul 2023 13:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGGRhx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jul 2023 13:37:53 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440EA1FE6;
        Fri,  7 Jul 2023 10:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688751472; x=1720287472;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PRTQ46eKpSZIih7cWbEER3l5RAE84GOA7acWX7yt3Vo=;
  b=g3sCj3J447Tf+knr1WMV9MdfGwUGfLnHs3ehQTsYpuA/eKEUresEBFyp
   VQwb3fKKbXs4EH7C2Yn7fg9yg66Qd33NRBSI+r9ezLZ5swDYu62dm6g+Y
   q16qGx2coqs+i3dlZZUtZFI2HdAVvO/xcBtb8WZLgmHR1MzimeDE5K8Mo
   JMMFzSbjgTJsRmUhxAGdkgZX21bZ/cZsssXj1lnAH2Qryygm3J/obB+fo
   pd0iZotV+hPP9nUKK5Su9gUuxC4m0eOTTW631oOhP+ex2hdWeeLhnw+ND
   KccLa0YKT7a0PEMtNtB8ukGSB84p+l/54kmuoCNessx4k/UR5YUegX+AZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="353787269"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="353787269"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 10:37:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="714104908"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="714104908"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 07 Jul 2023 10:37:50 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 10:37:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 10:37:49 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 10:37:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkrQPFuHtdbe7KyDG+Zj8gfCd7G92bo2iuUBYRMwQm49mrIv7+UMZpQ5UYqQGeeJgMgwQt7zdQbKfW4b3gh6fQe3U92SkW+tHUiVzfmcKdPghzrcKRcm/ds8djnZI8BGguc9JJOvgfwvVsZD2LvetT9WizdfJqi3CLGX7vPI+y4T5LF/tTrLpyemaU4xE78gMbsKrBlNhIdDZ45X70snKt80WefF/N0RZKO/f9IpjYleanJNMJEtleEWFV1Yk+ddYGa2eW4aFB66O3AW1uxkhXCbKOg2RP2iztXv/f65+W7Gk6qvqY2YxIk1y0TDJTHBTGZKpXvF4yZu2UWfXmQFAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRTQ46eKpSZIih7cWbEER3l5RAE84GOA7acWX7yt3Vo=;
 b=hHI9gzsGZYPaO8+TfxKpXtuCJq7XhNGeNLf8Z7dNyBeRX06jA6xVS54XvfiBVVZECJAjV0k0ZkInqY+q2iklv01zq6M5QH63ECI1ivRGHihNwOh3P+7ghOwumyt3grVZLyNQBhhMSCTwtsfDmk1VqKU/QSZQv25Lpw+GFsGkdSyoBIf72LLcoto3uES8s72fy0q4oq+/D5bl2BfDC8roWfrCinBJws/KQCa8RSAueruhvfNbQv/oY5ZLPomRehRARJ0EsZ+uzO39MWvf82hJEVxYRNHoRqWyxSV26BFgpfeN9MvRlIV4im24FZAZCcx1BZTHb9cT9Kd+ST+ZC2/QgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 17:37:45 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec%7]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 17:37:45 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "Lutomirski, Andy" <luto@kernel.org>
CC:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "bp@alien8.de" <bp@alien8.de>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "jannh@google.com" <jannh@google.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Thread-Topic: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Thread-Index: AQHZnYvD++9jHqJtDEOZ5j0eN4/f+6+IoOQAgAALyMOAACwFgIAAIG6AgAAMtoCAACGsAIAA96CAgABofQCAB1K5gIAAhUGAgAEVRoCAAKx+AIABDK+AgAB6bICAAPF/AIAAZrmAgAAVNICAAG62AIAKh/oAgATXZwCAAZabAIADLBsAgAEz1ACAAFjMgIABYAUAgAAlDAA=
Date:   Fri, 7 Jul 2023 17:37:45 +0000
Message-ID: <1c2f524cbaff886ce782bf3a3f95756197bc1e27.camel@intel.com>
References: <ZJQR7slVHvjeCQG8@arm.com>
         <CALCETrW+30_a2QQE-yw9djVFPxSxm7-c2FZFwZ50dOEmnmkeDA@mail.gmail.com>
         <ZJR545en+dYx399c@arm.com>
         <1cd67ae45fc379fd82d2745190e4caf74e67499e.camel@intel.com>
         <ZJ2sTu9QRmiWNISy@arm.com>
         <e057de9dd9e9fe48981afb4ded4b337e8a83fabf.camel@intel.com>
         <ZKMRFNSYQBC6S+ga@arm.com>
         <eda8b2c4b2471529954aadbe04592da1ddae906d.camel@intel.com>
         <ZKa8jB4lOik/aFn2@arm.com>
         <68b7f983ffd3b7c629940b6c6ee9533bb55d9a13.camel@intel.com>
         <ZKguVAZe+DGA1VEv@arm.com>
In-Reply-To: <ZKguVAZe+DGA1VEv@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MN0PR11MB5987:EE_
x-ms-office365-filtering-correlation-id: 817533d0-63ef-4c29-ec27-08db7f10dfbf
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f8hzohZp91TvofrNJRSByh9GulCgZWsc3NlbcUOryaYL5a8ITslhd17YFw4qUBxHdkQPxGBwzhr+qovYPO2pFD7JI+aVseQSI16JUnnxSF6akHWXvkjUVUDQjjwl7W1fzek77Nn8MV/fMu98IdQ2aCXPAsMBsa1nFGwveV/MT9aW0XQgcx5WWT8dWhBliBhSrryZxh5ikTJVwuNg+AdN/OeuqsRG/ebOufXfDqL87xpztYsqWNBGeN88Fg/GBAKmWH3eGsOmrtY6O+saTJHhmaVuDgcLMRDjyk+77stm7KCOBIDct1gOo89Pg64Pez5NTvhjAIQz50tiqnVyz0MJ5p1oirhovfR8Qev91cyiEUYdUtD3UGugIL56gcsZrNFM/XVF3+HB2nqK7vVXpBKZqU8LyumX+V34slCy0F4bwaxGFW8IG3dBV4mIUDWD3qDP++5XDXshzbNyfJZXoem2dIf0T8zdMNNBFy0+J/gbe46YRAH/ZqNh6iW8F6v8S4RSQF83YbGyJpGnPFO0PBhWGjqor3tEdD0DQl6L3rmvglYbAp7HClVkJPDrKzBn6/9824uWd+5xU1ZTBfhvMLpPHgbLrHFbrjLDkq7E1U/aG58Yd3jnZb8sRSPSCwjAvh48
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199021)(6486002)(91956017)(54906003)(478600001)(71200400001)(76116006)(110136005)(26005)(38070700005)(2616005)(36756003)(86362001)(66946007)(6506007)(83380400001)(186003)(6512007)(122000001)(38100700002)(82960400001)(64756008)(4326008)(66446008)(2906002)(66476007)(66556008)(316002)(5660300002)(41300700001)(7406005)(8936002)(8676002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L29oVVlJUVNIcmQwVVlVNDJ6UHpUK29wWjJscGFqQW53dXFCWlhqWGFLSkp1?=
 =?utf-8?B?QjhPejlHOGFsT2lkMVo4bWV2OVd1RjZCeE9tOHg4RFlzcnBXNXAvSzFEcHp4?=
 =?utf-8?B?K0U4WGVXWFNoNktaMTJHODVxUkJiWkJxRlM5dWJPb1p1ZTRpN1p2SjZTSVY4?=
 =?utf-8?B?SVhDUGdRK2JwZjBwTXNFcEYra3QwWVdUdmVGQzJ2RTN6dTJBTTgzNEhLYVBL?=
 =?utf-8?B?MVJEcDFQWjQzSUIyNWFVZmUzTTR5SFpqRkdKWlNDdVgxaWV6TWxiMkMybzYz?=
 =?utf-8?B?MlJ2clRidTYxZ1Q1dDRSYlpjRGZsNFBDQW9hZTUrMFpDNmUzQkJCb3EybEpX?=
 =?utf-8?B?OHZnaXI5cmJIb2xtNXpaYnpLbGxZeERPbGFpTldjWVhxSk5ScU92NEFnbS85?=
 =?utf-8?B?aG1ETUM0eHZSQkpQUjNvU1VoaGE1WjhyellTTjBQUjA1UE4vVlZ4SXZCRVRm?=
 =?utf-8?B?RFdhdThFTXNKUE1kR3RxTXU5cHhYdUx1SW5lU0s5QUdZbXZoaDFPd2NlY0pm?=
 =?utf-8?B?OVpzd1RDVWxxajlGcG0vd2tVb1J5RXhxRXl0TjJVTVpSb0E5bUZxTHNmSjM0?=
 =?utf-8?B?eDVzSnp4T2R4cXlSUFVmZzVJSnhkZXZTOGJSQlVoa3U4aGVVM2hWT095NkV1?=
 =?utf-8?B?M1ltZEJiTW9EY3RvdDI1ZzUwS3ZmQlczMjZBeTAyTHU5YXhMQVRwQitOaUN2?=
 =?utf-8?B?UWpiK09jOHU0VENkazNiSWpZWXE3VE9OU3NiOG5OVzY0WXZUV3RtdGJJc01M?=
 =?utf-8?B?cVJDdkRuQTRIb0d1UE5YaXJlY21GQXRDSENid01VSmxTMU1qNFM3Y0ZYSUdG?=
 =?utf-8?B?L0FiM3ZKRldkSE5IK01ObmQrblF6RVlMUVFZZEx4enFZdTF6Ti9USXVHWFIz?=
 =?utf-8?B?L1AyRU5pS1NyNjE2ZGczOTNvSEtKbVBYL1Z3dFNtaUN4eEJoR3BONWNsd3Q1?=
 =?utf-8?B?Nk8wU1J4dFpOWVQrUGd3UWRwUzJqVE9uTDJ2Nm4rY0srWWtIcEFvYjJsZ2Qr?=
 =?utf-8?B?ZFVSejdQaTJYejRJK29LQVpqRkYzT0ZQZWU1MXFjVHVrVy9rYm43dy84ekk5?=
 =?utf-8?B?NithaUwvVjYwVitQdkh0RitmSlhGMkVqN0lkNC92eklJWTVCeXhjR09sWm5U?=
 =?utf-8?B?TmtHVkF3cHNJd2hpUHpHaG92d3ZEQ2pOVHp3bno2NDNGTTUzVDJoK0RHc1J6?=
 =?utf-8?B?bGZVOE9veUxDQW5hem53ZDZIVWd0Myt3ZXhrYWg4QlVUTzRWS251MjlXZ2pF?=
 =?utf-8?B?OTdTYkkzM0VXSkFnallKNDRQVW9FcGVOanVrYXFsQnQ3b1JJNml4aTAwQ2E0?=
 =?utf-8?B?NUwrN0puWnRUakY4TlVEQnNXSm1CN3l1VVdIM2JTdVlxYktlNlQ4OTh3R3Nv?=
 =?utf-8?B?eHViaVEvYUJKVVBvTGhXeDRrQnRhWHArMnlvYzhaKzN6SWJsbGJHY3ZwZlZl?=
 =?utf-8?B?TkxKWnNBdjBscU5EaVp3NXcvY1VNYzhkemtoeEM1djM3M3FQa2I5MVd0bS8w?=
 =?utf-8?B?ek55MGdVc25Hc3ZJdDNENGJsMFB6ejd0a0s0UnBKK2sxZjkvWXI0bVYydTdl?=
 =?utf-8?B?WkNzcEdYK1hYTDRTV3ZMa20yVFNCb3BSYXhRMkpXTmpsd0JoM1dBRUIrVFY2?=
 =?utf-8?B?eE5oZmFHd0dtSG5nZ01DMVpaRTdtemhtNkEwY0FNNWF5Nk4vcmkxWXB5cnVj?=
 =?utf-8?B?cjNsVzJvMkY4MitPaVpaRVEwU2NRWHpMM0xtR21FWXQ0aVpKcGVmUkVwSTJI?=
 =?utf-8?B?MmFWdHhNRnVPWkF0SktERjV5VjhaelQrU3FUb2dLaHEvK0hpUXJ1QkhrQkhm?=
 =?utf-8?B?OGM0R2ozSlIyTDAxVW00R3JzQXUvUDRKWkVNeHNDczB6Wm4vcWNnanFRVmg2?=
 =?utf-8?B?elUvTkRlcHJUYVhIRFhoNm1ObHZpTWlKRktPak9IQVdLcFZ6SWZqTHRwTUJ5?=
 =?utf-8?B?Uy9MVHlJd1JINnEzRTRRcGZmTFd1TXlKWW8zV0NmUldUM1IwYm5LVGdWcjRh?=
 =?utf-8?B?ZmNHeS85SnRMdGg2RTJHakZSRWRvZW9Xek1tMUZQaVV4WE13NGdCay95Mzhi?=
 =?utf-8?B?cHZrMHZnQWtaSWxhZk1Pc09TdUJ3bEo3SUJBcUNyemR1dExhRmdTVDFJcmlT?=
 =?utf-8?B?cjExaTFqNm50V1p1TWZpOUhUdnplWDJlS2Nja1FqQVRxV2ZjSEJLbG1zU1dD?=
 =?utf-8?B?VEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D0A6F8533503D448404DFB23C5546BF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 817533d0-63ef-4c29-ec27-08db7f10dfbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 17:37:45.2968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mDdwF97imRKVWNPNfTjlsUSOFORHQDnVaz461NHiiHxcwRWXsitwcKUYKhRno9a8cp5okugBxcrx9dmvB75wZsHtu9ERBDue7y63KczS2gU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5987
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

T24gRnJpLCAyMDIzLTA3LTA3IGF0IDE2OjI1ICswMTAwLCBzemFib2xjcy5uYWd5QGFybS5jb20g
d3JvdGU6DQo+ID4gU2VwYXJhdGUgZnJvbSBhbGwgb2YgdGhpcy4uLm5vdyB0aGF0IGFsbCB0aGUg
Y29uc3RyYWludHMgYXJlDQo+ID4gY2xlYXJlciwNCj4gPiBpZiB5b3UgaGF2ZSBjaGFuZ2VkIHlv
dXIgbWluZCBvbiB3aGV0aGVyIHRoaXMgc2VyaWVzIGlzIHJlYWR5LA0KPiA+IGNvdWxkDQo+ID4g
eW91IGNvbW1lbnQgYXQgdGhlIHRvcCBvZiB0aGlzIHRocmVhZCBzb21ldGhpbmcgdG8gdGhhdCBl
ZmZlY3Q/IEknbQ0KPiA+IGltYWdpbmluZyBub3QgbWFueSBhcmUgcmVhZGluZyBzbyBmYXIgZG93
biBhdCB0aGlzIHBvaW50Lg0KPiA+IA0KPiA+IEZvciBteSBwYXJ0LCBJIHRoaW5rIHdlIHNob3Vs
ZCBnbyBmb3J3YXJkIHdpdGggd2hhdCB3ZSBoYXZlIG9uIHRoZQ0KPiA+IGtlcm5lbCBzaWRlLCB1
bmxlc3MgZ2xpYmMvZ2NjIGRldmVsb3BlcnMgd291bGQgbGlrZSB0byBzdGFydCBieQ0KPiA+IGRl
cHJlY2F0aW5nIHRoZSBleGlzdGluZyBiaW5hcmllcy4gSSBqdXN0IHRhbGtlZCB3aXRoIEhKLCBh
bmQgaGUNCj4gPiBoYXMNCj4gPiBub3QgY2hhbmdlZCBoaXMgcGxhbnMgYXJvdW5kIHRoaXMuIElm
IGFueW9uZSBlbHNlIGluIHRoYXQgY29tbXVuaXR5DQo+ID4gaGFzDQo+ID4gKEZsb3JpYW4/KSwg
cGxlYXNlIHNwZWFrIHVwLiBCdXQgb3RoZXJ3aXNlIEkgdGhpbmsgaXQncyBiZXR0ZXIgdG8NCj4g
PiBzdGFydA0KPiA+IGdldHRpbmcgcmVhbCB3b3JsZCBmZWVkYmFjayBhbmQgZ3JvdyBiYXNlZCBv
biB0aGF0Lg0KPiA+IA0KPiANCj4gdGhlIHg4NiB2MSBhYmkgdHJpZXMgdG8gYmUgY29tcGF0aWJs
ZSB3aXRoIGV4aXN0aW5nIHVud2luZGVycy4NCj4gKGFyZSB0aGVyZSBvdGhlciBiaW5hcmllcyB0
aGF0IGNvbnN0cmFpbnMgdjE/IHBvcnRhYmxlIGNvZGUNCj4gc2hvdWxkIGJlIGZpbmUgYXMgdGhl
eSByZWx5IG9uIGxpYmMgd2hpY2ggd2UgY2FuIHN0aWxsIGNoYW5nZSkNCj4gDQo+IGkgd2lsbCBo
YXZlIHRvIGRpc2N1c3MgdGhlIGFybSBwbGFuIHdpdGggdGhlIGFybSBrZXJuZWwgZGV2cy4NCj4g
dGhlIHVnbHkgYml0IGkgd2FudCB0byBhdm9pZCBvbiBhcm0gaXMgdG8gaGF2ZSB0byByZWltcGxl
bWVudA0KPiB1bndpbmQgYW5kIGp1bXAgb3BzIHRvIG1ha2UgYWx0IHNoYWRvdyBzdGFjayB3b3Jr
IGluIGEgdjIgYWJpLg0KPiANCj4gaSB0aGluayB0aGUgd29yc2UgYml0IG9mIHRoZSB4ODYgdjEg
YWJpIGlzIHRoYXQgY3Jhc2ggaGFuZGxlcnMNCj4gZG9uJ3Qgd29yayByZWxpYWJseSAoZS5nLiBh
IGNyYXNoIG9uIGEgdGlueSBtYWtlY29udGV4dCBzdGFjaw0KPiB3aXRoIHRoZSB1c3VhbCBzaWdh
bHRzdGFjayBjcmFzaCBoYW5kbGVyIGNhbiB1bnJlY292ZXJhYmx5IGZhaWwNCj4gZHVyaW5nIGNy
YXNoIGhhbmRsaW5nKS4gaSBndWVzcyB0aGlzIGNhbiBiZSBzb21ld2hhdCBtaXRpZ2F0ZWQNCj4g
YnkgYm90aCBsaW51eCBhbmQgbGliYyBhZGRpbmcgYW4gZXh0cmEgcGFnZSB0byB0aGUgc2hhZG93
IHN0YWNrDQo+IHNpemUgdG8gZ3VhcmFudGVlIHRoYXQgYWx0IHN0YWNrIGhhbmRsZXJzIHdpdGgg
Y2VydGFpbiBkZXB0aA0KPiBhbHdheXMgd29yay4NCg0KU29tZSBtYWlscyBiYWNrLCBJIGxpc3Rl
ZCB0aGUgdGhyZWUgdGhpbmdzIHlvdSBtaWdodCBiZSBhc2tpbmcgZm9yIGZyb20NCnRoZSBrZXJu
ZWwgc2lkZSBhbmQgcG9pbnRlZGx5IGFza2VkIHlvdSB0byBjbGFyaWZ5LiBUaGUgb25seSBvbmUg
eW91DQpzdGlsbCB3ZXJlIHdpc2hpbmcgZm9yIHVwIGZyb250IHdhcyAiTGVhdmUgYSB0b2tlbiBv
biBzd2l0Y2hpbmcgdG8gYW4NCmFsdCBzaGFkb3cgc3RhY2suIg0KDQpCdXQgaG93IHlvdSB3YW50
IHRvIHVzZSB0aGlzIGludm9sdmVzIGEgbG90IG9mIGRldGFpbHMgZm9yIGhvdyBnbGliYw0Kd2ls
bCB3b3JrIChhdXRvbWF0aWMgc2hhZG93IHN0YWNrIGZvciBzaWdhbHRzdGFjaywgc2Nhbi1yZXN0
b3JlLWluY3NzcCwNCmV0YykuIEkgdGhpbmsgeW91IGZpcnN0IG5lZWQgdG8gZ2V0IHRoZSBzdG9y
eSBzdHJhaWdodCB3aXRoIG90aGVyIGxpYmMNCmRldmVsb3BlcnMsIG90aGVyd2lzZSB0aGlzIGlz
IGp1c3QgYnJhaW5zdG9ybWluZy4gSSdtIG5vdCBhIGdsaWJjDQpjb250cmlidXRvciwgc28gd2lu
bmluZyBtZSBvdmVyIGlzIG9ubHkgaGFsZiB0aGUgYmF0dGxlLg0KDQpPbmx5IGFmdGVyIHRoYXQg
aXMgc2V0dGxlZCBkbyB3ZSBnZXQgdG8gdGhlIHByb2JsZW0gb2YgdGhlIG9sZCBsaWJnY2MNCnVu
d2luZGVycywgYW5kIGhvdyBpdCBpcyBhIGNoYWxsZW5nZSB0byBldmVuIGFkZCBhbHQgc2hhZG93
IHN0YWNrIGdpdmVuDQpnbGliYydzIHBsYW5zIGFuZCB0aGUgZXhpc3RpbmcgYmluYXJpZXMuDQoN
Ck9uY2UgdGhhdCBpcyBzb2x2ZWQgd2UgYXJlIGF0IHRoZSBvdmVyZmxvdyBwcm9ibGVtLCBhbmQg
dGhlIGN1cnJlbnQNCnN0YXRlIG9mIHRoaW5raW5nIG9uIHRoYXQgaXMgImknbSBmYWlybHkgc3Vy
ZSB0aGlzIGNhbiBiZSBkb25lIChidXQNCmluZGVlZCBjb21wbGljYXRlZCkiLg0KDQpTbyBJIHRo
aW5rIHdlIGFyZSBzdGlsbCBtaXNzaW5nIGFueSBhY3Rpb25hYmxlIHJlcXVlc3RzIHRoYXQgc2hv
dWxkDQpob2xkIHRoaXMgdXAuDQoNCklzIHRoaXMgYSByZWFzb25hYmxlIHN1bW1hcnk/DQo=
