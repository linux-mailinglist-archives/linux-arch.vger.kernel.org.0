Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3526569D5E3
	for <lists+linux-arch@lfdr.de>; Mon, 20 Feb 2023 22:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjBTVik (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Feb 2023 16:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjBTVij (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Feb 2023 16:38:39 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1B9EB4C;
        Mon, 20 Feb 2023 13:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676929114; x=1708465114;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SATvkBulu6OYqqGJEMVuO0hAF0WuJXoPDsCJQW5VUxk=;
  b=hUuBdNn0c2UR83YiZSVv7IjjAJkgVfViatSljzJodK3xnnla+RJkl9wK
   i8TgctGLmkatlW4CAwIdOwPWO/MKYGET8+yilrwMhKmLDFOqBopekkgDS
   FUfKZs3PahJSIcIZDop+tW2QosbqdP3Q3UWP8sT0kgoImTUJBZN7BkTHw
   bsv4STZoaASaBdDksKrw4EaEkAM5mkXtAnNaTtDXCc3T66vIMWO35CByw
   gKQVMO9tPyKdaZDl0H9Si+hQwQ33yfh7LnpurXxmRfzqB6IZUVcvE2F1u
   CF/YKizVLvcapGJeDdL5j2ntbtqDdaYcExyG49l3nU1NRAA1QsHuahbyy
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="330214732"
X-IronPort-AV: E=Sophos;i="5.97,313,1669104000"; 
   d="scan'208";a="330214732"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 13:38:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="735252391"
X-IronPort-AV: E=Sophos;i="5.97,313,1669104000"; 
   d="scan'208";a="735252391"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 20 Feb 2023 13:38:32 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 20 Feb 2023 13:38:32 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 20 Feb 2023 13:38:31 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 20 Feb 2023 13:38:31 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 20 Feb 2023 13:38:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afzHfem7HoOyDzEWaWiP6J+7PYR0aRaqQ8JgM/RG0HHjsaouhFbrfVlVjx8MHpebC4pTPMr4EvwT7oDCuyS4e5WHLXqjjhkC0EaCkfpJB52nTAX2eTxyNeyj2tZxo+8bP01Sq14byoByvpgXAEHecAt9wRs9NWlCTaFuBSsMqIYtrAfeoYkSdscQw7f2MyGCNozXK2RAo5GLrAlk5Ecw4x8vZGK/vER/bZFyS7wTW0wIY7GYWpzR75PXhZwH/gCZ8mHVbxhFIZnTP3clslQg4SIuoMTbeKsF1boSMOe4CWIs0suHSxFnKqkhIhEdlE1ZMU6OrEz5VcVwsXasgTP68w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SATvkBulu6OYqqGJEMVuO0hAF0WuJXoPDsCJQW5VUxk=;
 b=UdHwbtQCeH0fVNkiT8I2liwGdz5aCFZTRZj3bPRUj/zeSLpAN8rstKCqC9iUGZeDslntKXMzxaPcem0Va37G6IhOUC8RgUKLUE4NnfbWHCoC9VKeHa7P2S3nPAXuM2hBK2kHznxLN4NWMJb9lHcqNcl5+Kd3HXcQXD/W/nTUOPskfC0bS7UXwUckUhnlVVo9Vh7279kHn47QOPKnfH716EEhOEMFlVAqLP4IQxNN9juS2uGLsTDCA7Ozxq0rr0ryQf7yUXe5eQx4O4G8ZbCc2uuWyC3vR7h/yxeh43YDUzUXGdSALqjnzkyeFZymGjBI3ygWgS54tIPb+a4F0r39rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH7PR11MB6353.namprd11.prod.outlook.com (2603:10b6:510:1ff::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Mon, 20 Feb
 2023 21:38:28 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6111.019; Mon, 20 Feb 2023
 21:38:28 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "david@redhat.com" <david@redhat.com>,
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
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
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
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v6 14/41] x86/mm: Introduce _PAGE_SAVED_DIRTY
Thread-Topic: [PATCH v6 14/41] x86/mm: Introduce _PAGE_SAVED_DIRTY
Thread-Index: AQHZQ95AseCELEMbPEKUKa6WOvZcWa7XtimAgACpbgA=
Date:   Mon, 20 Feb 2023 21:38:27 +0000
Message-ID: <6f19d7c7ad9f61fa8f6c9bd09d24524dbe17463f.camel@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
         <20230218211433.26859-15-rick.p.edgecombe@intel.com>
         <70681787-0d33-a9ed-7f2a-747be1490932@redhat.com>
In-Reply-To: <70681787-0d33-a9ed-7f2a-747be1490932@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH7PR11MB6353:EE_
x-ms-office365-filtering-correlation-id: 68498211-224c-412c-cafe-08db138acd83
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /S9Zhf2zQEtDcjask8uzbcYqOpsHA0T4xEO9nK/awkdM/DmFdQpENr7rhAJv3mwDaFFh9WRIl3CddXioInTtFI+kxuwDoII6qvdnfGvh5IuKCwPawbAMvWhb4KDXzwfKuv/NTunJa2XxoPsliu6dnAOMP4YdFqfUcfwFugf7qfCNsecAN/6DvcjOAZ9lZWbiWb3Ys0M7pu9ZQ/L1H55WUS7cgIClPBAqOYlWKGtSmbJ/pjR/K09FqdtFswSRip+X+6gJr4G4NNWpLbjVAYJJfuHVse2NBQO0G66zjr9j2xi4VG+TG26pPkY82wEPH3Jk7nw2cBToCLFdmeeVGDERd8Rjan5RfHyX8R3OnpdkWCdopwLoqHJ0P4etMiyyt9+g9fY89itiiCOH1FZqkpuv2lMj9v/bVYGcPIl5AIKH6htpO3ana27v7is5rzBvXR3Hj/ukVCuLxUCdTz6moWW6MkBqiuKz0QA7hpcoc2Bkkq1wiH/QoVPL4i6e8boOY6gGS7307W7/GIbpjw82QD+xiyWIWX+vRDEKh65kH2PqAwokJWg16Txf8qEqQ8xfqhaNfUxxlRRE09XaXBe4Kp14yVS2gj6kjixE3pMxo0htKX61lpJKqmEIj7OWncNc7VHGQmytaPmjoJoN8Kty8LRGiYCU7teYEsDb9heXmEZHTPc/x0eQT9r/QUUtJtLtgvcT00eqD00g0QYYBDYXZAMnXj7U8QSohzcfennX4V6fAqUJSUyvnV5bHpNY+uUkxaRjwHByK/pr67URCnZh6Eug7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199018)(53546011)(6506007)(6512007)(71200400001)(41300700001)(86362001)(122000001)(7416002)(38100700002)(2616005)(26005)(478600001)(83380400001)(186003)(66556008)(6486002)(66446008)(64756008)(38070700005)(4326008)(7406005)(66476007)(66946007)(76116006)(8676002)(36756003)(30864003)(8936002)(5660300002)(921005)(110136005)(316002)(2906002)(82960400001)(99106002)(14143004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmttNmtPYlR3MVJkcmFZRm95UzEzUlJhaTlkUzVSaUI3TGNlaUJITURYQmNM?=
 =?utf-8?B?OFoxdTA5eDhFZGRqVzBwUUpaZ1NKclAyODU3TlNTRFRHOGdFTVZ6d2hVNGFv?=
 =?utf-8?B?UklOQUEvM05qZ3V0K29FS0kxWEE1Y2ROdjU4bEo1SEVSYUR6TnAvbHkxQUIy?=
 =?utf-8?B?N2s2VzZ5Z2FLWEVyKzJjbm9RdWJnZjNDY2JEK0NvaTlUcXNLb1JiRTFFbVpF?=
 =?utf-8?B?YnVmeVVNOUZpNUdFRUpNNnR3amN1bWRuSjVvT3NhcklmbTJtWjl3VUM4VldQ?=
 =?utf-8?B?MzZTRTMzQTRncTJyL2RITThESWNhY3liN0o5SU1NeFJBMTlLR05Femo3ZUc3?=
 =?utf-8?B?dllGRjVROWlOUnZ5Sk1wMFQ3TjNCQ3A0S0xHbDVlU3FNR1J5dndQMWRBUlZp?=
 =?utf-8?B?UGg1KzdvN05XcjRtbDRpV0FBWjkvV1JKcmF3M0pCeXJlTmNGRFQ1NWNhVmxk?=
 =?utf-8?B?ZXc5RmdYeG51ZExiV0ZsTFpjRW9XVTk2SWRMR2kvdXlYTnlnSlN3VEdoSVZB?=
 =?utf-8?B?QjIzNVVXck92Y2wrNDhFNmMzZ0o1ZGZUMzFYWjBuNERORThMVEdVQ1FoMEVu?=
 =?utf-8?B?QzRLNTBzWEE1d3VQTEVEVDhHb3h1emRkSWtucm9lYno2a3VBOU5zRm1CbXJ0?=
 =?utf-8?B?ZmpybExyZHZTY1NwQzB4bFJ6cGRxZFNYMjBVL1lnaUloRE1sdDNKcEFKT243?=
 =?utf-8?B?V3U1bEpkOWtpZitHcHFQdlhQdkw1ZTZnYURVR01CKzk0VXFxVDhQQlBGeWp3?=
 =?utf-8?B?cnpvWno0RU1MWjNNa3k3TmxvdUtvZXZwQ2F0YVZZRk9hU1Z5RDJUVUJOR3d0?=
 =?utf-8?B?ZWU1elJBUjJ4aTFSNjcvVTltSnZqcDljZFU2RUhiQm5EM1lQMUU4VnlBUzNX?=
 =?utf-8?B?UjhnMXU3REVXUGVZVlA0dWxKWGlod1JvMlFEV1pQOXJMY1orS0FzWXhVc1A4?=
 =?utf-8?B?QWRWYWRxelNvNVJ1ODN3cndtZ2U0RzN1Y0JSY1JaTDBZSUVoTW9hZzlJU2Vm?=
 =?utf-8?B?ZzRHRmhicll3UmlSNWtnYXErZmw2WUE4SUp5cHg0RWpSTG1pcGFiWU1PT25z?=
 =?utf-8?B?Mlp5RVJTNUJWV1N1b3dXekVPTDZFZEQrcFRWU3NnaHpKSWJyWWVMWTlmSC9w?=
 =?utf-8?B?ZEQ4eVEyNjloNW9uNU5XN1dKUHE3MGJMVzZCZkU2enNFc2dwSW1LSGZiQlRP?=
 =?utf-8?B?UE16ZE1mNFd3QTVycVBHNk1vNVlsYmhDcmh6UU00ODl1cG5XUjc5RUZPUE1i?=
 =?utf-8?B?a1ZvZW9BNlFzOVc0TURFWXl0UUNZRFdTSlhUNGRyTlZYQzlZakh2aFNMRlhr?=
 =?utf-8?B?dmg3K1ZUNjg4ai9MMmxoZ20yd2FRUmdpTm1BM2xWNGM5YmwzNW9ZM2hqL2RO?=
 =?utf-8?B?OGRScXdWRzFGa2xNQ01zUDAvMGhpcDd1WFF6cTF0cEhtWGcwbHFUdmhYajEw?=
 =?utf-8?B?ZlEvd0VYWC9rK1RxWEpYMkw0VWh1cjdoZjZGSjUzUnhLNlBRMExTMFlNY2ZL?=
 =?utf-8?B?UkszaXQ2YUZNSnBPUVVxNDJQSEpZaGtzUGZSR3hpQ1Z0c3ZpK1ZQNHhLU0Vq?=
 =?utf-8?B?YmpzUXV6RU0wYURldTNLSCtWZ2lBV2NhOEl1ZFpoUXFXK3pFV1g5NGoxV3dE?=
 =?utf-8?B?eEVmQjVqM0MwZ1RBT2ZhcFNpeWtLTGdsQkp0M3c1Yy9vSnZLY3pIQ1Jab3Zk?=
 =?utf-8?B?Mnpna3JWQjlJdmtXSCsxR2ZjMm4xaVZzMWdRNlhYUk11dFVkdmVQa2FTTVRY?=
 =?utf-8?B?azIyMlV5Mk1UUXUxLzh2N2ZZZzBnYVVsSk82Q1VFZXA4RGwwREplQk5XMnhB?=
 =?utf-8?B?MkZyd0FEcndBa29aWWRPVUx0aFl6aElGZTBPSlpzazBidUFiWnk1VlJoUUdy?=
 =?utf-8?B?Ry9laHRjNVRqQWUvQjAzNHptSUQ4eFZYdDE1eW5jRm5qTU1jZUdCN2MrQnRE?=
 =?utf-8?B?VmRRUUxVNGtucU5NckkxeGFlK1Y0bWhvMWk1TWJuRllHOHl4TkJKSGFMM0l5?=
 =?utf-8?B?SWpXMUordHZ1QzEvRHRRakw2V0xlVzN3bDJEejJZVVFlUC9MWGcxUjk2ZG5B?=
 =?utf-8?B?VzNDUlFPY3FjWDl6VEp5OEgzNTAvczZtNnFpdkdlSGx3RUtUMER1UjFEWlRo?=
 =?utf-8?B?UTF4ZTc0VXBnRGtZWERVcHNja3E2bXYyZExQbHg0TUlFTFdhWDV3aDlWVUtz?=
 =?utf-8?Q?NeEvAwDG1yb8cpWwQbwJsqU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83040C1DDA15A6458D0186B97CA2CA11@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68498211-224c-412c-cafe-08db138acd83
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 21:38:27.6813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mkyCLaHrQq3/PgFS3VLVgtnUY4fXVxum2boo8DXaMRx5/zQdXtvDL4yb8K15aQO8g1A/DpoABGMZSwIK39FbXxoOlrpJmmLeVeiXUJQimpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6353
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIzLTAyLTIwIGF0IDEyOjMyICswMTAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4gT24gMTguMDIuMjMgMjI6MTQsIFJpY2sgRWRnZWNvbWJlIHdyb3RlOg0KPiA+IFNvbWUg
T1NlcyBoYXZlIGEgZ3JlYXRlciBkZXBlbmRlbmNlIG9uIHNvZnR3YXJlIGF2YWlsYWJsZSBiaXRz
IGluDQo+ID4gUFRFcyB0aGFuDQo+ID4gTGludXguIFRoYXQgbGVmdCB0aGUgaGFyZHdhcmUgYXJj
aGl0ZWN0cyBsb29raW5nIGZvciBhIHdheSB0bw0KPiA+IHJlcHJlc2VudCBhDQo+ID4gbmV3IG1l
bW9yeSB0eXBlIChzaGFkb3cgc3RhY2spIHdpdGhpbiB0aGUgZXhpc3RpbmcgYml0cy4gVGhleSBj
aG9zZQ0KPiA+IHRvDQo+ID4gcmVwdXJwb3NlIGEgbGlnaHRseS11c2VkIHN0YXRlOiBXcml0ZT0w
LERpcnR5PTEuIFNvIGluIG9yZGVyIHRvDQo+ID4gc3VwcG9ydA0KPiA+IHNoYWRvdyBzdGFjayBt
ZW1vcnksIExpbnV4IHNob3VsZCBhdm9pZCBjcmVhdGluZyBtZW1vcnkgd2l0aCB0aGlzDQo+ID4g
UFRFIGJpdA0KPiA+IGNvbWJpbmF0aW9uIHVubGVzcyBpdCBpbnRlbmRzIGZvciBpdCB0byBiZSBz
aGFkb3cgc3RhY2suDQo+ID4gDQo+ID4gVGhlIHJlYXNvbiBpdCdzIGxpZ2h0bHkgdXNlZCBpcyB0
aGF0IERpcnR5PTEgaXMgbm9ybWFsbHkgc2V0IGJ5IEhXDQo+ID4gX2JlZm9yZV8gYSB3cml0ZS4g
QSB3cml0ZSB3aXRoIGEgV3JpdGU9MCBQVEUgd291bGQgdHlwaWNhbGx5IG9ubHkNCj4gPiBnZW5l
cmF0ZQ0KPiA+IGEgZmF1bHQsIG5vdCBzZXQgRGlydHk9MS4gSGFyZHdhcmUgY2FuIChyYXJlbHkp
IGJvdGggc2V0IERpcnR5PTENCj4gPiAqYW5kKg0KPiA+IGdlbmVyYXRlIHRoZSBmYXVsdCwgcmVz
dWx0aW5nIGluIGEgV3JpdGU9MCxEaXJ0eT0xIFBURS4gSGFyZHdhcmUNCj4gPiB3aGljaA0KPiA+
IHN1cHBvcnRzIHNoYWRvdyBzdGFja3Mgd2lsbCBubyBsb25nZXIgZXhoaWJpdCB0aGlzIG9kZGl0
eS4NCj4gPiANCj4gPiBTbyB0aGF0IGxlYXZlcyBXcml0ZT0wLERpcnR5PTEgUFRFcyBjcmVhdGVk
IGluIHNvZnR3YXJlLiBUbyBhY2hpZXZlDQo+ID4gdGhpcywNCj4gPiBpbiBwbGFjZXMgd2hlcmUg
TGludXggbm9ybWFsbHkgY3JlYXRlcyBXcml0ZT0wLERpcnR5PTEsIGl0IGNhbiB1c2UNCj4gPiB0
aGUNCj4gPiBzb2Z0d2FyZS1kZWZpbmVkIF9QQUdFX1NBVkVEX0RJUlRZIGluIHBsYWNlIG9mIHRo
ZSBoYXJkd2FyZQ0KPiA+IF9QQUdFX0RJUlRZLg0KPiA+IEluIG90aGVyIHdvcmRzLCB3aGVuZXZl
ciBMaW51eCBuZWVkcyB0byBjcmVhdGUgV3JpdGU9MCxEaXJ0eT0xLCBpdA0KPiA+IGluc3RlYWQN
Cj4gPiBjcmVhdGVzIFdyaXRlPTAsU2F2ZWREaXJ0eT0xIGV4Y2VwdCBmb3Igc2hhZG93IHN0YWNr
LCB3aGljaCBpcw0KPiA+IFdyaXRlPTAsRGlydHk9MS4gRnVydGhlciBkaWZmZXJlbnRpYXRlZCBi
eSBWTUEgZmxhZ3MsIHRoZXNlIFBURSBiaXQNCj4gPiBjb21iaW5hdGlvbnMgd291bGQgYmUgc2V0
IGFzIGZvbGxvd3MgZm9yIHZhcmlvdXMgdHlwZXMgb2YgbWVtb3J5Og0KPiANCj4gSSB3b3VsZCBz
aW1wbGlmeSAoc2VlIGJlbG93KSBhbmQgbm90IHJlcGVhdCB3aGF0IHRoZSBwYXRjaCBjb250YWlu
cw0KPiBhcyANCj4gY29tbWVudHMgYWxyZWFkeSB0aGF0IGRldGFpbGVkLg0KDQpUaGlzIHZlcmJp
YWdlIGhhcyBoYWQgcXVpdGUgYSBiaXQgb2YgeDg2IG1haW50YWluZXIgYXR0ZW50aW9uIGFscmVh
ZHkuDQpJIGhlYXIgd2hhdCB5b3UgYXJlIHNheWluZywgYnV0IEknbSBhIGJpdCBoZXNpdGFudCB0
byB0YWtlIHN0eWxlDQpzdWdnZXN0aW9ucyBhdCB0aGlzIHBvaW50IGZvciBmZWFyIG9mIHRoZSBz
aXR1YXRpb24gd2hlcmUgcGVvcGxlIGFzaw0KZm9yIGNoYW5nZXMgYmFjayBhbmQgZm9ydGggYWNy
b3NzIGRpZmZlcmVudCB2ZXJzaW9ucy4gVW5sZXNzIGFueSB4ODYNCm1haW50YWluZXJzIHdhbnQg
dG8gY2hpbWUgaW4gYWdhaW4/IE1vcmUgcmVzcG9uc2VzIGJlbG93Lg0KDQo+IA0KPiA+IA0KPiA+
IChXcml0ZT0wLFNhdmVkRGlydHk9MSxEaXJ0eT0wKToNCj4gPiAgIC0gQSBtb2RpZmllZCwgY29w
eS1vbi13cml0ZSAoQ09XKSBwYWdlLiBQcmV2aW91c2x5IHdoZW4gYSB0eXBpY2FsDQo+ID4gICAg
IGFub255bW91cyB3cml0YWJsZSBtYXBwaW5nIHdhcyBtYWRlIENPVyB2aWEgZm9yaygpLCB0aGUg
a2VybmVsDQo+ID4gd291bGQNCj4gPiAgICAgbWFyayBpdCBXcml0ZT0wLERpcnR5PTEuIE5vdyBp
dCB3aWxsIGluc3RlYWQgdXNlIHRoZSBTYXZlZERpcnR5DQo+ID4gYml0Lg0KPiA+ICAgICBUaGlz
IGhhcHBlbnMgaW4gY29weV9wcmVzZW50X3B0ZSgpLg0KPiA+ICAgLSBBIFIvTyBwYWdlIHRoYXQg
aGFzIGJlZW4gQ09XJ2VkLiBUaGUgdXNlciBwYWdlIGlzIGluIGEgUi9PIFZNQSwNCj4gPiAgICAg
YW5kIGdldF91c2VyX3BhZ2VzKEZPTExfRk9SQ0UpIG5lZWRzIGEgd3JpdGFibGUgY29weS4gVGhl
IHBhZ2UNCj4gPiBmYXVsdA0KPiA+ICAgICBoYW5kbGVyIGNyZWF0ZXMgYSBjb3B5IG9mIHRoZSBw
YWdlIGFuZCBzZXRzIHRoZSBuZXcgY29weSdzIFBURQ0KPiA+IGFzDQo+ID4gICAgIFdyaXRlPTAg
YW5kIFNhdmVkRGlydHk9MS4NCj4gPiAgIC0gQSBzaGFyZWQgc2hhZG93IHN0YWNrIFBURS4gV2hl
biBhIHNoYWRvdyBzdGFjayBwYWdlIGlzIGJlaW5nDQo+ID4gc2hhcmVkDQo+ID4gICAgIGFtb25n
IHByb2Nlc3NlcyAodGhpcyBoYXBwZW5zIGF0IGZvcmsoKSksIGl0cyBQVEUgaXMgbWFkZQ0KPiA+
IERpcnR5PTAsIHNvDQo+ID4gICAgIHRoZSBuZXh0IHNoYWRvdyBzdGFjayBhY2Nlc3MgY2F1c2Vz
IGEgZmF1bHQsIGFuZCB0aGUgcGFnZSBpcw0KPiA+ICAgICBkdXBsaWNhdGVkIGFuZCBEaXJ0eT0x
IGlzIHNldCBhZ2Fpbi4gVGhpcyBpcyB0aGUgQ09XIGVxdWl2YWxlbnQNCj4gPiBmb3INCj4gPiAg
ICAgc2hhZG93IHN0YWNrIHBhZ2VzLCBldmVuIHRob3VnaCBpdCdzIGNvcHktb24tYWNjZXNzIHJh
dGhlciB0aGFuDQo+ID4gICAgIGNvcHktb24td3JpdGUuDQo+ID4gDQo+ID4gKFdyaXRlPTAsU2F2
ZWREaXJ0eT0wLERpcnR5PTEpOg0KPiA+ICAgLSBBIHNoYWRvdyBzdGFjayBQVEUuDQo+ID4gICAt
IEEgQ293IFBURSBjcmVhdGVkIHdoZW4gYSBwcm9jZXNzb3Igd2l0aG91dCBzaGFkb3cgc3RhY2sg
c3VwcG9ydA0KPiA+IHNldA0KPiA+ICAgICBEaXJ0eT0xLg0KPiA+IA0KPiA+IFRoZXJlIGFyZSBz
aXggYml0cyBsZWZ0IGF2YWlsYWJsZSB0byBzb2Z0d2FyZSBpbiB0aGUgNjQtYml0IFBURQ0KPiA+
IGFmdGVyDQo+ID4gY29uc3VtaW5nIGEgYml0IGZvciBfUEFHRV9TQVZFRF9ESVJUWS4gTm8gc3Bh
Y2UgaXMgY29uc3VtZWQgaW4gMzItDQo+ID4gYml0DQo+ID4ga2VybmVscyBiZWNhdXNlIHNoYWRv
dyBzdGFja3MgYXJlIG5vdCBlbmFibGVkIHRoZXJlLg0KPiA+IA0KPiA+IEltcGxlbWVudCBvbmx5
IHRoZSBpbmZyYXN0cnVjdHVyZSBmb3IgX1BBR0VfU0FWRURfRElSVFkuIENoYW5nZXMgdG8NCj4g
PiBzdGFydA0KPiA+IGNyZWF0aW5nIF9QQUdFX1NBVkVEX0RJUlRZIFBURXMgd2lsbCBmb2xsb3cg
b25jZSBvdGhlciBwaWVjZXMgYXJlDQo+ID4gaW4gcGxhY2UuDQo+ID4gDQo+ID4gVGVzdGVkLWJ5
OiBQZW5nZmVpIFh1IDxwZW5nZmVpLnh1QGludGVsLmNvbT4NCj4gPiBUZXN0ZWQtYnk6IEpvaG4g
QWxsZW4gPGpvaG4uYWxsZW5AYW1kLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogS2VlcyBDb29rIDxr
ZWVzY29va0BjaHJvbWl1bS5vcmc+DQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBZdS1jaGVuZyBZdSA8
eXUtY2hlbmcueXVAaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFl1LWNoZW5nIFl1IDx5
dS1jaGVuZy55dUBpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmljayBFZGdlY29tYmUg
PHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0KPiA+IA0KPiA+IC0tLQ0KPiA+IHY2Og0KPiA+
ICAgLSBSZW5hbWUgX1BBR0VfQ09XIHRvIF9QQUdFX1NBVkVEX0RJUlRZIChEYXZpZCBIaWxkZW5i
cmFuZCkNCj4gPiAgIC0gQWRkIF9QQUdFX1NBVkVEX0RJUlRZIHRvIF9QQUdFX0NIR19NQVNLDQo+
ID4gDQo+ID4gdjU6DQo+ID4gICAtIEZpeCBsb2csIGNvbW1lbnRzIGFuZCB3aGl0ZXNwYWNlIChC
b3JpcykNCj4gPiAgIC0gUmVtb3ZlIGNhcGl0YWxpemF0aW9uIG9uIHNoYWRvdyBzdGFjayAoQm9y
aXMpDQo+ID4gDQo+ID4gdjQ6DQo+ID4gICAtIFRlYWNoIHB0ZV9mbGFnc19uZWVkX2ZsdXNoKCkg
YWJvdXQgX1BBR0VfQ09XIGJpdA0KPiA+ICAgLSBCcmVhayBhcGFydCBwYXRjaCBmb3IgYmV0dGVy
IGJpc2VjdGFiaWxpdHkNCj4gPiANCj4gPiB2MzoNCj4gPiAgIC0gQWRkIGNvbW1lbnQgYXJvdW5k
IF9QQUdFX1RBQkxFIGluIHJlc3BvbnNlIHRvIGNvbW1lbnQNCj4gPiAgICAgZnJvbSAoQW5kcmV3
IENvb3BlcikNCj4gPiAgIC0gQ2hlY2sgZm9yIFBTRSBpbiBwbWRfc2hzdGsgKEFuZHJldyBDb29w
ZXIpDQo+ID4gICAtIEdldCB0byB0aGUgcG9pbnQgcXVpY2tlciBpbiBjb21taXQgbG9nIChBbmRy
ZXcgQ29vcGVyKQ0KPiA+ICAgLSBDbGFyaWZ5IGFuZCByZW9yZGVyIGNvbW1pdCBsb2cgZm9yIHdo
eSB0aGUgUFRFIGJpdCBleGFtcGxlcw0KPiA+IGhhdmUNCj4gPiAgICAgbXVsdGlwbGUgZW50cmll
cy4gQXBwbHkgc2FtZSBjaGFuZ2VzIGZvciBjb21tZW50LiAocGV0ZXJ6KQ0KPiA+ICAgLSBGaXgg
Y29tbWVudCB0aGF0IGltcGxpZWQgZGlydHkgYml0IGZvciBDT1cgd2FzIGEgc3BlY2lmaWMgeDg2
DQo+ID4gdGhpbmcNCj4gPiAgICAgKHBldGVyeikNCj4gPiAgIC0gRml4IHN3YXBwaW5nIG9mIFdy
aXRlL0RpcnR5IChQZXRlclopDQo+ID4gLS0tDQo+ID4gICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9w
Z3RhYmxlLmggICAgICAgfCA3OQ0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4g
PiAgIGFyY2gveDg2L2luY2x1ZGUvYXNtL3BndGFibGVfdHlwZXMuaCB8IDY1ICsrKysrKysrKysr
KysrKysrKysrLS0tDQo+ID4gICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS90bGJmbHVzaC5oICAgICAg
fCAgMyArLQ0KPiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxMzggaW5zZXJ0aW9ucygrKSwgOSBkZWxl
dGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vcGd0
YWJsZS5oDQo+ID4gYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZ3RhYmxlLmgNCj4gPiBpbmRleCAy
YjQyM2Q2OTc0OTAuLjExMGU1NTJlYjYwMiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9pbmNs
dWRlL2FzbS9wZ3RhYmxlLmgNCj4gPiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZ3RhYmxl
LmgNCj4gPiBAQCAtMzAxLDYgKzMwMSw0NSBAQCBzdGF0aWMgaW5saW5lIHB0ZV90IHB0ZV9jbGVh
cl9mbGFncyhwdGVfdCBwdGUsDQo+ID4gcHRldmFsX3QgY2xlYXIpDQo+ID4gICAJcmV0dXJuIG5h
dGl2ZV9tYWtlX3B0ZSh2ICYgfmNsZWFyKTsNCj4gPiAgIH0NCj4gPiAgIA0KPiA+ICsvKg0KPiA+
ICsgKiBDT1cgYW5kIG90aGVyIHdyaXRlIHByb3RlY3Rpb24gb3BlcmF0aW9ucyBjYW4gcmVzdWx0
IGluDQo+ID4gRGlydHk9MSxXcml0ZT0wDQo+ID4gKyAqIFBURXMuIEJ1dCBpbiB0aGUgY2FzZSBv
ZiBYODZfRkVBVFVSRV9VU0VSX1NIU1RLLCB0aGUgc29mdHdhcmUNCj4gPiBTYXZlZERpcnR5IGJp
dA0KPiA+ICsgKiBpcyB1c2VkLCBzaW5jZSB0aGUgRGlydHk9MSxXcml0ZT0wIHdpbGwgcmVzdWx0
IGluIHRoZSBtZW1vcnkNCj4gPiBiZWluZyB0cmVhdGVkIGFzDQo+ID4gKyAqIHNoYWRvdyBzdGFj
ayBieSB0aGUgSFcuIFNvIHdoZW4gY3JlYXRpbmcgZGlydHksIHdyaXRlLXByb3RlY3RlZCANCj4g
PiBtZW1vcnksIGENCj4gPiArICogc29mdHdhcmUgYml0IGlzIHVzZWQgX1BBR0VfQklUX1NBVkVE
X0RJUlRZLiBUaGUgZm9sbG93aW5nDQo+ID4gZnVuY3Rpb25zDQo+ID4gKyAqIHB0ZV9ta3NhdmVk
ZGlydHkoKSBhbmQgcHRlX2NsZWFyX3NhdmVkZGlydHkoKSB0YWtlIGENCj4gPiBjb252ZW50aW9u
YWwgZGlydHksDQo+ID4gKyAqIHdyaXRlLXByb3RlY3RlZCBQVEUgKFdyaXRlPTAsRGlydHk9MSkg
YW5kIHRyYW5zaXRpb24gaXQgdG8gdGhlDQo+ID4gc2hhZG93IHN0YWNrDQo+ID4gKyAqIGNvbXBh
dGlibGUgdmVyc2lvbi4gKFdyaXRlPTAsU2F2ZWREaXJ0eT0xKS4NCj4gPiArICovDQo+ID4gK3N0
YXRpYyBpbmxpbmUgcHRlX3QgcHRlX21rc2F2ZWRkaXJ0eShwdGVfdCBwdGUpDQo+ID4gK3sNCj4g
PiArCWlmICghY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9VU0VSX1NIU1RLKSkNCj4g
PiArCQlyZXR1cm4gcHRlOw0KPiA+ICsNCj4gPiArCXB0ZSA9IHB0ZV9jbGVhcl9mbGFncyhwdGUs
IF9QQUdFX0RJUlRZKTsNCj4gPiArCXJldHVybiBwdGVfc2V0X2ZsYWdzKHB0ZSwgX1BBR0VfU0FW
RURfRElSVFkpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW5saW5lIHB0ZV90IHB0ZV9j
bGVhcl9zYXZlZGRpcnR5KHB0ZV90IHB0ZSkNCj4gPiArew0KPiA+ICsJLyoNCj4gPiArCSAqIF9Q
QUdFX1NBVkVEX0RJUlRZIGlzIHVubmVjZXNzYXJ5IG9uICFYODZfRkVBVFVSRV9VU0VSX1NIU1RL
DQo+ID4ga2VybmVscywNCj4gPiArCSAqIHNpbmNlIHRoZSBIVyBkaXJ0eSBiaXQgY2FuIGJlIHVz
ZWQgd2l0aG91dCBjcmVhdGluZyBzaGFkb3cNCj4gPiBzdGFjaw0KPiA+ICsJICogbWVtb3J5LiBT
ZWUgdGhlIF9QQUdFX1NBVkVEX0RJUlRZIGRlZmluaXRpb24gZm9yIG1vcmUNCj4gPiBkZXRhaWxz
Lg0KPiA+ICsJICovDQo+ID4gKwlpZiAoIWNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVf
VVNFUl9TSFNUSykpDQo+ID4gKwkJcmV0dXJuIHB0ZTsNCj4gPiArDQo+ID4gKwkvKg0KPiA+ICsJ
ICogUFRFIGlzIGdldHRpbmcgY29waWVkLW9uLXdyaXRlLCBzbyBpdCB3aWxsIGJlIGRpcnRpZWQN
Cj4gPiArCSAqIGlmIHdyaXRhYmxlLCBvciBtYWRlIHNoYWRvdyBzdGFjayBpZiBzaGFkb3cgc3Rh
Y2sgYW5kDQo+ID4gKwkgKiBiZWluZyBjb3BpZWQgb24gYWNjZXNzLiBTZXQgdGhlIGRpcnR5IGJp
dCBmb3IgYm90aA0KPiA+ICsJICogY2FzZXMuDQo+ID4gKwkgKi8NCj4gPiArCXB0ZSA9IHB0ZV9z
ZXRfZmxhZ3MocHRlLCBfUEFHRV9ESVJUWSk7DQo+ID4gKwlyZXR1cm4gcHRlX2NsZWFyX2ZsYWdz
KHB0ZSwgX1BBR0VfU0FWRURfRElSVFkpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICAgI2lmZGVmIENP
TkZJR19IQVZFX0FSQ0hfVVNFUkZBVUxURkRfV1ANCj4gPiAgIHN0YXRpYyBpbmxpbmUgaW50IHB0
ZV91ZmZkX3dwKHB0ZV90IHB0ZSkNCj4gPiAgIHsNCj4gPiBAQCAtNDIwLDYgKzQ1OSwyNiBAQCBz
dGF0aWMgaW5saW5lIHBtZF90IHBtZF9jbGVhcl9mbGFncyhwbWRfdCBwbWQsDQo+ID4gcG1kdmFs
X3QgY2xlYXIpDQo+ID4gICAJcmV0dXJuIG5hdGl2ZV9tYWtlX3BtZCh2ICYgfmNsZWFyKTsNCj4g
PiAgIH0NCj4gPiAgIA0KPiA+ICsvKiBTZWUgY29tbWVudHMgYWJvdmUgcHRlX21rc2F2ZWRkaXJ0
eSgpICovDQo+ID4gK3N0YXRpYyBpbmxpbmUgcG1kX3QgcG1kX21rc2F2ZWRkaXJ0eShwbWRfdCBw
bWQpDQo+ID4gK3sNCj4gPiArCWlmICghY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9V
U0VSX1NIU1RLKSkNCj4gPiArCQlyZXR1cm4gcG1kOw0KPiA+ICsNCj4gPiArCXBtZCA9IHBtZF9j
bGVhcl9mbGFncyhwbWQsIF9QQUdFX0RJUlRZKTsNCj4gPiArCXJldHVybiBwbWRfc2V0X2ZsYWdz
KHBtZCwgX1BBR0VfU0FWRURfRElSVFkpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICsvKiBTZWUgY29t
bWVudHMgYWJvdmUgcHRlX21rc2F2ZWRkaXJ0eSgpICovDQo+ID4gK3N0YXRpYyBpbmxpbmUgcG1k
X3QgcG1kX2NsZWFyX3NhdmVkZGlydHkocG1kX3QgcG1kKQ0KPiA+ICt7DQo+ID4gKwlpZiAoIWNw
dV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfVVNFUl9TSFNUSykpDQo+ID4gKwkJcmV0dXJu
IHBtZDsNCj4gPiArDQo+ID4gKwlwbWQgPSBwbWRfc2V0X2ZsYWdzKHBtZCwgX1BBR0VfRElSVFkp
Ow0KPiA+ICsJcmV0dXJuIHBtZF9jbGVhcl9mbGFncyhwbWQsIF9QQUdFX1NBVkVEX0RJUlRZKTsN
Cj4gPiArfQ0KPiA+ICsNCj4gPiAgICNpZmRlZiBDT05GSUdfSEFWRV9BUkNIX1VTRVJGQVVMVEZE
X1dQDQo+ID4gICBzdGF0aWMgaW5saW5lIGludCBwbWRfdWZmZF93cChwbWRfdCBwbWQpDQo+ID4g
ICB7DQo+ID4gQEAgLTQ5MSw2ICs1NTAsMjYgQEAgc3RhdGljIGlubGluZSBwdWRfdCBwdWRfY2xl
YXJfZmxhZ3MocHVkX3QgcHVkLA0KPiA+IHB1ZHZhbF90IGNsZWFyKQ0KPiA+ICAgCXJldHVybiBu
YXRpdmVfbWFrZV9wdWQodiAmIH5jbGVhcik7DQo+ID4gICB9DQo+ID4gICANCj4gPiArLyogU2Vl
IGNvbW1lbnRzIGFib3ZlIHB0ZV9ta3NhdmVkZGlydHkoKSAqLw0KPiA+ICtzdGF0aWMgaW5saW5l
IHB1ZF90IHB1ZF9ta3NhdmVkZGlydHkocHVkX3QgcHVkKQ0KPiA+ICt7DQo+ID4gKwlpZiAoIWNw
dV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfVVNFUl9TSFNUSykpDQo+ID4gKwkJcmV0dXJu
IHB1ZDsNCj4gPiArDQo+ID4gKwlwdWQgPSBwdWRfY2xlYXJfZmxhZ3MocHVkLCBfUEFHRV9ESVJU
WSk7DQo+ID4gKwlyZXR1cm4gcHVkX3NldF9mbGFncyhwdWQsIF9QQUdFX1NBVkVEX0RJUlRZKTsN
Cj4gPiArfQ0KPiA+ICsNCj4gPiArLyogU2VlIGNvbW1lbnRzIGFib3ZlIHB0ZV9ta3NhdmVkZGly
dHkoKSAqLw0KPiA+ICtzdGF0aWMgaW5saW5lIHB1ZF90IHB1ZF9jbGVhcl9zYXZlZGRpcnR5KHB1
ZF90IHB1ZCkNCj4gPiArew0KPiA+ICsJaWYgKCFjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFU
VVJFX1VTRVJfU0hTVEspKQ0KPiA+ICsJCXJldHVybiBwdWQ7DQo+ID4gKw0KPiA+ICsJcHVkID0g
cHVkX3NldF9mbGFncyhwdWQsIF9QQUdFX0RJUlRZKTsNCj4gPiArCXJldHVybiBwdWRfY2xlYXJf
ZmxhZ3MocHVkLCBfUEFHRV9TQVZFRF9ESVJUWSk7DQo+ID4gK30NCj4gPiArDQo+ID4gICBzdGF0
aWMgaW5saW5lIHB1ZF90IHB1ZF9ta29sZChwdWRfdCBwdWQpDQo+ID4gICB7DQo+ID4gICAJcmV0
dXJuIHB1ZF9jbGVhcl9mbGFncyhwdWQsIF9QQUdFX0FDQ0VTU0VEKTsNCj4gPiBkaWZmIC0tZ2l0
IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vcGd0YWJsZV90eXBlcy5oDQo+ID4gYi9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS9wZ3RhYmxlX3R5cGVzLmgNCj4gPiBpbmRleCAwNjQ2YWQwMDE3OGIuLjNiNDIw
YjZjMDU4NCAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZ3RhYmxlX3R5
cGVzLmgNCj4gPiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZ3RhYmxlX3R5cGVzLmgNCj4g
PiBAQCAtMjEsNyArMjEsOCBAQA0KPiA+ICAgI2RlZmluZSBfUEFHRV9CSVRfU09GVFcyCTEwCS8q
ICIgKi8NCj4gPiAgICNkZWZpbmUgX1BBR0VfQklUX1NPRlRXMwkxMQkvKiAiICovDQo+ID4gICAj
ZGVmaW5lIF9QQUdFX0JJVF9QQVRfTEFSR0UJMTIJLyogT24gMk1CIG9yIDFHQiBwYWdlcyAqLw0K
PiA+IC0jZGVmaW5lIF9QQUdFX0JJVF9TT0ZUVzQJNTgJLyogYXZhaWxhYmxlIGZvciBwcm9ncmFt
bWVyICovDQo+ID4gKyNkZWZpbmUgX1BBR0VfQklUX1NPRlRXNAk1NwkvKiBhdmFpbGFibGUgZm9y
IHByb2dyYW1tZXIgKi8NCj4gPiArI2RlZmluZSBfUEFHRV9CSVRfU09GVFc1CTU4CS8qIGF2YWls
YWJsZSBmb3IgcHJvZ3JhbW1lciAqLw0KPiA+ICAgI2RlZmluZSBfUEFHRV9CSVRfUEtFWV9CSVQw
CTU5CS8qIFByb3RlY3Rpb24gS2V5cywgYml0IDEvNA0KPiA+ICovDQo+ID4gICAjZGVmaW5lIF9Q
QUdFX0JJVF9QS0VZX0JJVDEJNjAJLyogUHJvdGVjdGlvbiBLZXlzLCBiaXQgMi80DQo+ID4gKi8N
Cj4gPiAgICNkZWZpbmUgX1BBR0VfQklUX1BLRVlfQklUMgk2MQkvKiBQcm90ZWN0aW9uIEtleXMs
IGJpdCAzLzQNCj4gPiAqLw0KPiA+IEBAIC0zNCw2ICszNSwxNSBAQA0KPiA+ICAgI2RlZmluZSBf
UEFHRV9CSVRfU09GVF9ESVJUWQlfUEFHRV9CSVRfU09GVFczIC8qIHNvZnR3YXJlDQo+ID4gZGly
dHkgdHJhY2tpbmcgKi8NCj4gPiAgICNkZWZpbmUgX1BBR0VfQklUX0RFVk1BUAlfUEFHRV9CSVRf
U09GVFc0DQo+ID4gICANCj4gPiArLyoNCj4gPiArICogSW5kaWNhdGVzIGEgU2F2ZWQgRGlydHkg
Yml0IHBhZ2UuDQo+ID4gKyAqLw0KPiA+ICsjaWZkZWYgQ09ORklHX1g4Nl9VU0VSX1NIQURPV19T
VEFDSw0KPiA+ICsjZGVmaW5lIF9QQUdFX0JJVF9TQVZFRF9ESVJUWQkJX1BBR0VfQklUX1NPRlRX
NSAvKg0KPiA+IGNvcHktb24td3JpdGUgKi8NCj4gDQo+IE5vcGUsIG5vdCAiY29weS1vbi13cml0
ZSIgOikgSXQncyBtb3JlIGxpa2UgImRpcnR5IGJpdCB3aGVuIHRoZSBody0NCj4gZGlydHkgDQo+
IGJpdCBjYW5ub3QgYmUgdXNlZCIuIE1heWJlIHNpbXBseSBkcm9wIHRoZSBjb21tZW50Lg0KDQpP
b3BzLCBJIG1pc3NlZCB0aGlzIHdoZW4gSSBzY3J1YmJlZCBfUEFHRV9DT1cuIFRoYW5rcy4gV2ls
bCBmaXguDQoNCj4gDQo+ID4gKyNlbHNlDQo+ID4gKyNkZWZpbmUgX1BBR0VfQklUX1NBVkVEX0RJ
UlRZCQkwDQo+ID4gKyNlbmRpZg0KPiA+ICsNCj4gPiAgIC8qIElmIF9QQUdFX0JJVF9QUkVTRU5U
IGlzIGNsZWFyLCB3ZSB1c2UgdGhlc2U6ICovDQo+ID4gICAvKiAtIGlmIHRoZSB1c2VyIG1hcHBl
ZCBpdCB3aXRoIFBST1RfTk9ORTsgcHRlX3ByZXNlbnQgZ2l2ZXMgdHJ1ZQ0KPiA+ICovDQo+ID4g
ICAjZGVmaW5lIF9QQUdFX0JJVF9QUk9UTk9ORQlfUEFHRV9CSVRfR0xPQkFMDQo+ID4gQEAgLTEx
Nyw2ICsxMjcsNDAgQEANCj4gPiAgICNkZWZpbmUgX1BBR0VfU09GVFc0CShfQVQocHRldmFsX3Qs
IDApKQ0KPiA+ICAgI2VuZGlmDQo+ID4gICANCj4gPiArLyoNCj4gPiArICogVGhlIGhhcmR3YXJl
IHJlcXVpcmVzIHNoYWRvdyBzdGFjayB0byBiZSByZWFkLW9ubHkgYW5kIERpcnR5Lg0KPiA+ICsg
KiBfUEFHRV9TQVZFRF9ESVJUWSBpcyBhIHNvZnR3YXJlLW9ubHkgYml0IHVzZWQgdG8gc2VwYXJh
dGUgY29weS0NCj4gPiBvbi13cml0ZQ0KPiA+ICsgKiBQVEVzIGZyb20gc2hhZG93IHN0YWNrIFBU
RXM6DQo+IA0KPiBJJ2Qgc3VnZ2VzdCBwaHJhc2luZyB0aGlzIGRpZmZlcmVudGx5LiBDT1cgaXMg
anVzdCBvbmUgc2NlbmFyaW8NCj4gd2hlcmUgDQo+IHRoaXMgY2FuIGhhcHBlbi4gQWxzbywgSSBk
b24ndCB0aGluayB0aGF0IHRoZSBkZXNjcmlwdGlvbiBvZiANCj4gInNlcGFyYXRpb24iIGlzIGNv
cnJlY3QuDQo+IA0KPiBTb21ldGhpbmcgbGlrZSB0aGUgZm9sbG93aW5nIG1heWJlPw0KPiANCj4g
Ig0KPiBIb3dldmVyLCB0aGVyZSBhcmUgdmFsaWQgY2FzZXMgd2hlcmUgdGhlIGtlcm5lbCBtaWdo
dCBjcmVhdGUgcmVhZC0NCj4gb25seSANCj4gUFRFcyB0aGF0IGFyZSBkaXJ0eSAoZS5nLiwgZm9y
aygpLCBtcHJvdGVjdCgpLCB1ZmZkLXdwKCksIHNvZnQtZGlydHkgDQo+IHRyYWNraW5nKS4gSW4g
dGhpcyBjYXNlLCB0aGUgX1BBR0VfU0FWRURfRElSVFkgYml0IGlzIHVzZWQgaW5zdGVhZA0KPiBv
ZiANCj4gdGhlIEhXLWRpcnR5IGJpdCwgdG8gYXZvaWQgY3JlYXRpbmcgYSB3cm9uZyAic2hhZG93
IHN0YWNrIiBQVEVzLg0KPiBTdWNoIA0KPiBQVEVzIGhhdmUgKFdyaXRlPTAsU2F2ZWREaXJ0eT0x
LERpcnR5PTApIHNldC4NCj4gDQo+IE5vdGUgdGhhdCBvbiBwcm9jZXNzb3JzIHdpdGhvdXQgc2hh
ZG93IHN0YWNrIHN1cHBvcnQsIHRoZSANCj4gX1BBR0VfU0FWRURfRElSVFkgcmVtYWlucyB1bnVz
ZWQuDQo+ICINCj4gDQo+IFRoZSBJIHdvdWxkIHNpbXBseSBkcm9wIGJlbG93ICh3aGljaCBpcyBh
bHNvIHRvbyBDT1ctc3BlY2lmaWMgSQ0KPiB0aGluaykuDQoNCkNPVyBpcyB0aGUgbWFpbiBzaXR1
YXRpb24gd2hlcmUgc2hhZG93IHN0YWNrcyBiZWNvbWUgcmVhZC1vbmx5LiBTbywgYXMNCmFuIGV4
YW1wbGUgaXQgaXMgbmljZSBpbiB0aGF0IENPVyBjb3ZlcnMgYWxsIHRoZSBzY2VuYXJpb3MgZGlz
Y3Vzc2VkLg0KQWdhaW4sIGRvIGFueSB4ODYgbWFpbnRhaW5lcnMgd2FudCB0byB3ZWlnaCBpbiBo
ZXJlPw0KDQo+IA0KPiA+ICsgKg0KPiA+ICsgKiAoV3JpdGU9MCxTYXZlZERpcnR5PTEsRGlydHk9
MCk6DQo+ID4gKyAqICAtIEEgbW9kaWZpZWQsIGNvcHktb24td3JpdGUgKENPVykgcGFnZS4gUHJl
dmlvdXNseSB3aGVuIGENCj4gPiB0eXBpY2FsDQo+ID4gKyAqICAgIGFub255bW91cyB3cml0YWJs
ZSBtYXBwaW5nIHdhcyBtYWRlIENPVyB2aWEgZm9yaygpLCB0aGUNCj4gPiBrZXJuZWwgd291bGQN
Cj4gPiArICogICAgbWFyayBpdCBXcml0ZT0wLERpcnR5PTEuIE5vdyBpdCB3aWxsIGluc3RlYWQg
dXNlIHRoZSBDb3cNCj4gPiBiaXQuIFRoaXMNCj4gPiArICogICAgaGFwcGVucyBpbiBjb3B5X3By
ZXNlbnRfcHRlKCkuDQo+ID4gKyAqICAtIEEgUi9PIHBhZ2UgdGhhdCBoYXMgYmVlbiBDT1cnZWQu
IFRoZSB1c2VyIHBhZ2UgaXMgaW4gYSBSL08NCj4gPiBWTUEsDQo+ID4gKyAqICAgIGFuZCBnZXRf
dXNlcl9wYWdlcyhGT0xMX0ZPUkNFKSBuZWVkcyBhIHdyaXRhYmxlIGNvcHkuIFRoZQ0KPiA+IHBh
Z2UgZmF1bHQNCj4gPiArICogICAgaGFuZGxlciBjcmVhdGVzIGEgY29weSBvZiB0aGUgcGFnZSBh
bmQgc2V0cyB0aGUgbmV3IGNvcHkncw0KPiA+IFBURSBhcw0KPiA+ICsgKiAgICBXcml0ZT0wIGFu
ZCBTYXZlZERpcnR5PTEuDQo+ID4gKyAqICAtIEEgc2hhcmVkIHNoYWRvdyBzdGFjayBQVEUuIFdo
ZW4gYSBzaGFkb3cgc3RhY2sgcGFnZSBpcyBiZWluZw0KPiA+IHNoYXJlZA0KPiA+ICsgKiAgICBh
bW9uZyBwcm9jZXNzZXMgKHRoaXMgaGFwcGVucyBhdCBmb3JrKCkpLCBpdHMgUFRFIGlzIG1hZGUN
Cj4gPiBEaXJ0eT0wLCBzbw0KPiA+ICsgKiAgICB0aGUgbmV4dCBzaGFkb3cgc3RhY2sgYWNjZXNz
IGNhdXNlcyBhIGZhdWx0LCBhbmQgdGhlIHBhZ2UgaXMNCj4gPiArICogICAgZHVwbGljYXRlZCBh
bmQgRGlydHk9MSBpcyBzZXQgYWdhaW4uIFRoaXMgaXMgdGhlIENPVw0KPiA+IGVxdWl2YWxlbnQg
Zm9yDQo+ID4gKyAqICAgIHNoYWRvdyBzdGFjayBwYWdlcywgZXZlbiB0aG91Z2ggaXQncyBjb3B5
LW9uLWFjY2VzcyByYXRoZXINCj4gPiB0aGFuDQo+ID4gKyAqICAgIGNvcHktb24td3JpdGUuDQo+
ID4gKyAqDQo+ID4gKyAqIChXcml0ZT0wLFNhdmVkRGlydHk9MCxEaXJ0eT0xKToNCj4gPiArICog
IC0gQSBzaGFkb3cgc3RhY2sgUFRFLg0KPiA+ICsgKiAgLSBBIENvdyBQVEUgY3JlYXRlZCB3aGVu
IGEgcHJvY2Vzc29yIHdpdGhvdXQgc2hhZG93IHN0YWNrDQo+ID4gc3VwcG9ydCBzZXQNCj4gPiAr
ICogICAgRGlydHk9MS4NCj4gPiArICovDQo+IA0KPiANCg==
