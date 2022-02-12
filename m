Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E629E4B3280
	for <lists+linux-arch@lfdr.de>; Sat, 12 Feb 2022 02:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiBLBpI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Feb 2022 20:45:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiBLBpH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Feb 2022 20:45:07 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC5F266;
        Fri, 11 Feb 2022 17:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644630305; x=1676166305;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=C6sgY/bFuUiQCQ5TzpJ2j5248x1haxgma/8dXe79PAA=;
  b=HivQ7Yrr7IOLfHwm/p+Y87maIGB0wbzfcFoo7/nkmWiJVa1MAbaNwMIE
   r61AnchwWIjB3yFDfA5R282JgE/veJarztx6OoOzL0hsuOyirBIeEd0C1
   4zA5fSExHBf9Oz7b9oD2YHoLuuO9u0Av85K5kiizxXlEl9kTB9LuGa9SD
   Ct/kNQYQL3mGcUNcRRxsYqnBH7UlqSK8ibQkCNWtX4WTRK0JESgQFDXcL
   XdPqNDQCEZ5naG/bEypM6hQ9i3hZ/u8CDmmWXXopa09/b46ugpDXOMqvG
   FLy4Ff1iOcT/boRGPjda33pmba5Vgj5qU2EuaRGvFT+WTS8NQNvB0TYK9
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="310579158"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="310579158"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 17:45:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="569208558"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga001.jf.intel.com with ESMTP; 11 Feb 2022 17:45:04 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 11 Feb 2022 17:45:04 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 11 Feb 2022 17:45:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 11 Feb 2022 17:45:03 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 11 Feb 2022 17:45:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7BVwKsGXygSqKLBrWpdFMx5oxPzklrnKiGZQPIs/L1aJOsX4chGDCEoGXtK1TxsyPe+mRqVYr4kGgVpatyuFENeyh5xSuBA17N+idbvHVvv6TJ32GHpJKDY0NxTv0ctFMkMiAJFfagIWRfedL0vagtKJRYzSx0W9aroLJmYTwmFP6OVIK85hz4R9RtQnD9wO4nuYy9w5ZHz9/rrORmRxLie+lhLNoHURsi7CnAkSBXg7kk0R7VJkTNBEGnyEU/7aVeVZ9X8VJvYqP7qwNPr9POITyJO8uFh9S5YGqHmW2Ofb1umQLmz1vH0u9eaWtszp6SCHoJQ9chGPDf5q0MvvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6sgY/bFuUiQCQ5TzpJ2j5248x1haxgma/8dXe79PAA=;
 b=LtpvtgVssW7qMEA+jzYTwuTE/BxKlj3pAQdxpNXRjSvdhfTjqzelngnnk02TcfOJ36ZuZ080D/iLPvWkViSza//7qfSJH++9bm6Bkz+7w1nPRrmdIhRr7W1RCCQhce8nlx3ed9fQNKJyNrUwgIWEiI/1CInoh8wj27KM+lr7xpM0HKH3NfQoknwVunCb2d0we34ZbcSQ1L10bhyIdgGQpYtRDg/nlMs+lKBuUaJpG92mJ+wYHW4GWVGEjtA6QO5d5isQkSdJAtJlMx3cV6MLv3LBTcf7w0NcDoTYIt5qYvUUw7kEsd6dMgKRTPvDiL8t9LIRxvxHPaJDhNpF5JKK0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BN6PR11MB1874.namprd11.prod.outlook.com (2603:10b6:404:107::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Sat, 12 Feb
 2022 01:45:01 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15%4]) with mapi id 15.20.4951.021; Sat, 12 Feb 2022
 01:45:01 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Wang, Zhi A" <zhi.a.wang@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
CC:     "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "airlied@linux.ie" <airlied@linux.ie>
Subject: Re: [PATCH 10/35] drm/i915/gvt: Change _PAGE_DIRTY to
 _PAGE_DIRTY_BITS
Thread-Topic: [PATCH 10/35] drm/i915/gvt: Change _PAGE_DIRTY to
 _PAGE_DIRTY_BITS
Thread-Index: AQHYFh9vdtBQu39zq06k5MnACkwSaKyLgDcAgAIj0wCAAF1wAIABNpEA
Date:   Sat, 12 Feb 2022 01:45:01 +0000
Message-ID: <8439ea495510b58060749a8646aa7a2651f91ac4.camel@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
         <20220130211838.8382-11-rick.p.edgecombe@intel.com>
         <a5bb32b8-8bd7-ac98-5c4c-5af604ac8256@intel.com>
         <04cbcff2e28e378ece76ab1735a81b945583ad7b.camel@intel.com>
         <37652390-1645-8801-05de-a83a7dcfba7a@intel.com>
In-Reply-To: <37652390-1645-8801-05de-a83a7dcfba7a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70bfd5ff-dc94-4305-d961-08d9edc948b4
x-ms-traffictypediagnostic: BN6PR11MB1874:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB1874536692EF4A67B710C4A4C9319@BN6PR11MB1874.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fzoaRTQnYK0YtmC7dS+m2DMsj9iuUrRLeIzG/GYKzc12OorwVOUZWAQE2fuyrtvgkA6wcbinuVtAdimtPYAgSM4E+ZG6gMojnUFPvaGsWntWEqFPXwPddlpN7If5852ug/jgrCidBZGoxAUO7nJouEL5V/bVT8x36Si87DY3cFucK4nahz+471Y+W7x44qkmsdD0stWMeVzUY2RUENde2nSq5MQO7NHn6dv1LIdOGv+33e/nSUNPeIW3RkDMXf0UQzbQyPlo7NuXIyBTJ7ELUJw4PJ6OvGHxDi/s/9qO71CB4bjcvDrMOYxiF2qEOdjLffkRKB89dZ0VrSRe/pwsXh5Az/EhJJosUst96G7EjjnboEdSP3xfVAKZ7PBh2/P7TAyKDp4ExzSvmHcO6Ow5tHEnzfNwRcotLb4x7cDge4WevcKuVtO61Gpm/BZ9pCZJJZq4KvMV1Iej1hgp5OuJ4Sh2MrVGPdPDed9AoPF74U0+WthVtkH9dfOh+DaVNPfuRIlMzrcFp28gUFa8jGjlpZiPZFcVKjr2sX0++KTxqoDZzoQsZpqiPQKgG+VOUmd9HTlCBb8Sw5TPDujxcWIb7vAAtzVyolj4UQCn6oS1etSgryruM2HFDiXUYTQ5rWA05Pbda0IFyqOFhc1V6NNNtZLLci8iTKs4JPcB9jttwjw1gwZ2oouODqP7hRV8UprdfR6CA1EZlN10Nm4ZfVMrTR6eZzgyw9Gnib9FORb3lHY+2wHBtmotpUX0Hyjaqfu8XVVY9VpMWvk9kbD3dqqPHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(38070700005)(66476007)(64756008)(4326008)(8676002)(66446008)(66556008)(6486002)(508600001)(76116006)(66946007)(82960400001)(36756003)(7406005)(6512007)(5660300002)(7416002)(86362001)(2906002)(558084003)(2616005)(26005)(186003)(71200400001)(110136005)(122000001)(6506007)(38100700002)(316002)(54906003)(921005)(99106002)(14143004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QktjZENOUWxVUHBRNyt6OEZYVnd4MEJCSzlvbjNCMjBvRkRYc2dyMjkyWHFZ?=
 =?utf-8?B?V1RjZXVheENRdk1mNnFTd0NXNk82MTRpQmRhc1FucVFHandKWFk0amkxWm50?=
 =?utf-8?B?YVlnLzBLb0c4eTljN2J2VU9WaVA3Y2pmWE9zKzBraVhGeEtsVjgwZy9YRW5D?=
 =?utf-8?B?VmxKY2RSUE41N1l3UVdZRkx3bWVaUjExdUdZSXdMWEk4TEYwNTh5OElyeURD?=
 =?utf-8?B?V1AzS2ZSZ1BpM2pUWHlWVlc2ei9SRnBJenhYNkhhb21UUzc3S0JHSXA5LzYy?=
 =?utf-8?B?NE81b0NrT3dQcjV3T2JyRHhBaHJqYUxyMWk1RXRCa2dNSjVVL0trdjZRdkJQ?=
 =?utf-8?B?T2tDWE84UnF1RFZDTklVSnNxeXR6dkV0Wjh1VzkrUTB5cXdpN2dvTlQwNGpo?=
 =?utf-8?B?UEpjOTJDd3l4MzgrSGRyTmUwd3FTUmdUZm9UUGYrQlJqTWY2NElEbWlhTjdF?=
 =?utf-8?B?dHplVWxORzVBRFhpMXRGZDVBeThnKy95QXJuNjFjN090UDQxRS9KamZmZXlI?=
 =?utf-8?B?L1oxa3ZkRlZvQ1UwbnVVVHZ5L0trYUk0eGVsTVNBM25wakZCMDc1NVoxU3BZ?=
 =?utf-8?B?TWJSVm9EWDRKZFdGczkvVUxQOUhTTUxPUS9CdFlsTUM5WG9rQThLKzZlMDRR?=
 =?utf-8?B?T2lRSTNhaVZBSitiS25yc2VXdkVNVjFPOVM1RVF1WUlySFk3aUptblM5YVBO?=
 =?utf-8?B?QWI0d29mcW5HOThFc1Nlb2l0Yy8vMTdoZnJGSXovVWJXQTJjWkwrbmFLcWVr?=
 =?utf-8?B?OGV0OCtqYXV4ZE01S29DRlo3U3lxWkRpN0gwKy8yc0NiaVB3K1JTU0FHNEFi?=
 =?utf-8?B?S2dmQldTS2pUUWE0WkdBby8vejlJYmhqUDIzdlg4Tks3SE5FN3RVNTEwbmd4?=
 =?utf-8?B?dDd4QlZzbG95R1JBYzAvUFV5MFJLQTRJYk1DL2ZlQzgwMFpGbDArVTRIMkZr?=
 =?utf-8?B?NUxKN3NlTDlQaHp2bGFXTGZEYlJ0YUhJRmpLb3YrZWdmUlR0MkorYnI3VVh4?=
 =?utf-8?B?SVBLaG02ZmtmTUxvNVZnVzZxaW0vWUhzSHJ5a3dFZ0JRMGFqZzFrTVJUZ3lG?=
 =?utf-8?B?LytFeTJLbUQvWkFXMy81eVY5VHh6NnE4b25yTXI1UDJGSWMySUFKNnVhNEM4?=
 =?utf-8?B?dEV2bnVaYXF0Y1VFWFArUktoZVRnNlBiNm9RdDJpcXZmcTh2Q1NxbzYvelpG?=
 =?utf-8?B?VGxVOWMzaFpGSUtNaFNmYW90ZUtFWGpPcCtsL2xFSkU4RHcySTZKdjlHK2xE?=
 =?utf-8?B?a2d6TmZoRmhVNHgzR294VjVlNWhkSG1mUWxHc2cyaE4vN3FaM21RU0VMMzJG?=
 =?utf-8?B?RjJyekJoelBTWkJVS2VZMWsyZjUzd1g5am90Q015VzNHNnpYc2lENkxTQWJk?=
 =?utf-8?B?NU8zc3hBTEZPK2tnRENXTmtZWW5IV0plMlp4ZXlVZ0VQYm81YnlTVVBTQ0Fy?=
 =?utf-8?B?d1d1VnRzNXQ4NVkxWG5zSDNUd0RnRERZbWN2U0NRTTdzdTI3anhQYVRlMStE?=
 =?utf-8?B?cXNVeEpvZ2haaDQ5WkVMUDVaQTE5VlZYemlidXA5QlcwMXQySEp4elUrM2NB?=
 =?utf-8?B?M2doSkR5ZzdZdWJya2NQaGhLbXlQYURlcktBSkVKVUpheGtMNW0zOEQ1QUUy?=
 =?utf-8?B?YUlaQVRsUTVMZWFzZCs1V2h2dEgzeklDbFBLaGFEWUhSNklYSEpZcUQxbTJW?=
 =?utf-8?B?aGZlN3RXYmp3UlN2eitCMHVSeVV1WEV1UjF2NjR6b0Y4VW1Scm81OXM3cmcx?=
 =?utf-8?B?NHpxK1BJckhURytMNEl5eUQ4T21vRlVGRHliUnZqU0tUWEVIZzAyNThTdWUz?=
 =?utf-8?B?azMxOStFTHlqRUgvQ0p0Y2tJbXlYN3J0K3h2bVhlQkxxejVQYjFtenpTckxy?=
 =?utf-8?B?OTB4OXdxR0QxQmdncUhOV2IySjgwZU1hNnZmT20zd3hVcExxc1pXdjlra1JW?=
 =?utf-8?B?OGs5Z0Qvdi9KUHBIcW9xTzhPK1hHUnZtQnQyQzhIUmF0bnZSWlRTMEZBREFl?=
 =?utf-8?B?dmFEMWNSeTZHb3AxVy9XMm15MWVDZ0VmNkpFNlIvSEkycjNZSW1zdXVod0Rr?=
 =?utf-8?B?NVBSZzR3UnphN2t3YTRsZzg3c214VlY2Z0hWUEh0WFZMNjd5MkVQNHhtRzgx?=
 =?utf-8?B?c2YvVTNFdkZwQ0JwOWsvazVTNVU4dk9TQlkxVXNvdmFuNHRadnBFMDJOdVBP?=
 =?utf-8?B?Zmp4VEJaMmdHTmNGVFFpQW5XQ0k1QlhRM3ViRkt1Nll0MTlpZW9uZnRTVXlT?=
 =?utf-8?Q?XWMdh9D2ipQLev9TjEcflM1JTgBT5TipmrBuyNdqd0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33AE642BC319E348A77A97682F211C6E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70bfd5ff-dc94-4305-d961-08d9edc948b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2022 01:45:01.2250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Ux7O1v59G6XH3dcZ4QDZ2LQNz94GuBp35PALV0Fi2yIIVwPMxPgP8p+ge4+C6T0I3P1/A4Ky6EoGqJa0CLvDk5pCAvjg3AMShPEArDjoYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1874
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

T24gRnJpLCAyMDIyLTAyLTExIGF0IDA3OjEzICswMDAwLCBXYW5nLCBaaGkgQSB3cm90ZToNCj4g
SSB3b3VsZCBzdWdnZXN0IHlvdSBjYW4gcmVtb3ZlIHRoYXQgbGluZSBpbiB5b3VyIHBhdGNoIGFu
ZCBJIHdpbGwNCj4gY2xlYW4NCj4gdGhpcyBmdW5jdGlvbiBhZnRlciB5b3VyIHBhdGNoZXMgZ290
IG1lcmdlZC4NCg0KVGhhbmtzIQ0K
