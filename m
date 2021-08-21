Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20EA3F3C47
	for <lists+linux-arch@lfdr.de>; Sat, 21 Aug 2021 21:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhHUTVT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 21 Aug 2021 15:21:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:43480 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229914AbhHUTVT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 21 Aug 2021 15:21:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10083"; a="216645857"
X-IronPort-AV: E=Sophos;i="5.84,340,1620716400"; 
   d="scan'208";a="216645857"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2021 12:20:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,340,1620716400"; 
   d="scan'208";a="443031132"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 21 Aug 2021 12:20:38 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Sat, 21 Aug 2021 12:20:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Sat, 21 Aug 2021 12:20:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Sat, 21 Aug 2021 12:20:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pv3sgaxl0uZPqkOn5bGiCM2gqzshpwWh3PschP2lLQSpoQNZ4bNYLhM82DeRrNus62LM4yMowRKd3HFBYi2fyTzxP3J1R4xQ1qiKyqf33aQv8CjwTLEgFqLw8A/ttpBWC7RnKIpAIvZszCnXW2EJO1b7Lx+EpDMV0SIQrqzeIpZ7+WeGR13iH8Igo19L1NBtVZ4PP8RllDzHgqXkHiDP8SV0Ysxw4Jl1oxqw9Kcx+b7gN7mY5uh+ur2pPjlqok1iFgEa2BMC37Ej0c0Tk/T1CVS5hi9nWJB9y2sTIpadMV0UNo9z79BchGQx5IX04ymToq4Msz+MyCAsa2lETNW0ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiUft2wvav2QbvGgWtnO6zCrH1jZg0KdKmvFDkyxqhA=;
 b=DnN/hYMwWuxHx3KL0rCjgpgbUosUw1nEqO0eD1ToirrsmtjS9dZgCMRKhRpuSzNRhuJhqqAZ8OMtz1M1/2t4hUjV6OzXckdowN0TqnMVMITlCgD87bik/w3q6H6oGc5CJohRXI32KqhnizHtcWPPX4rlLocQ72yQA+Zy2WVKi3FQWrTGHh2Nla9sj5TSXMBqFgeswj0iBRb8FHzCwFTEgffrq7egtXnT5zHyAjqPpVczmslXLYhN8++Y28hFeq64HhLG32OSyio43CcH5hJGc4bULxTVndfFGyuJqSCj4IEYXp1gNRQTjyWCKeycqpq3fbraDAkR+Oc16KvgY0U8xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiUft2wvav2QbvGgWtnO6zCrH1jZg0KdKmvFDkyxqhA=;
 b=dQN2CBkMn6zK15CnmabIliHcFYP+7Fy4LzCsLux59q2mYpKAXN3kqPTvJ1OUyuwIOvqqvqiIxtXsFMsWeEJOJ/1007NuXA7L08iei85hqGtGIR4KsBHvxMqvVIim501rwXkCJ4ZI+dIuszX5Le8LvpBNAxNhQuufSnawE15lc1Y=
Received: from SN6PR11MB3184.namprd11.prod.outlook.com (2603:10b6:805:bd::17)
 by SA0PR11MB4608.namprd11.prod.outlook.com (2603:10b6:806:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Sat, 21 Aug
 2021 19:20:32 +0000
Received: from SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::892e:cae1:bef0:935e]) by SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::892e:cae1:bef0:935e%6]) with mapi id 15.20.4436.019; Sat, 21 Aug 2021
 19:20:32 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "esyr@redhat.com" <esyr@redhat.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
CC:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v29 09/32] x86/mm: Introduce _PAGE_COW
Thread-Topic: [PATCH v29 09/32] x86/mm: Introduce _PAGE_COW
Thread-Index: AQHXle/aMI4krKcn/kKrw6oEL7PJsat+V1eA
Date:   Sat, 21 Aug 2021 19:20:32 +0000
Message-ID: <152f757d37d3fd834a06fadad18165cbf44b1b48.camel@intel.com>
References: <20210820181201.31490-1-yu-cheng.yu@intel.com>
         <20210820181201.31490-10-yu-cheng.yu@intel.com>
In-Reply-To: <20210820181201.31490-10-yu-cheng.yu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc4b4f1c-e4ad-4549-06b2-08d964d8becd
x-ms-traffictypediagnostic: SA0PR11MB4608:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR11MB4608F7091302AB57E1702C2EC9C29@SA0PR11MB4608.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y5gtL800oJCfMDRVADuRsvsv77+5oScTFxfxH0EFTOZAU547WvA3kmEiC15z+SC/Krlkvpx2zTQiAt2QGvkydfHViaU2ykbgGwUIL0/YjAD87cl0TPwddP9s2bfRIYC4JAyldV8eCNqlcsl8shthy1Eodhujy0VU/q0/NtOJ8/0bJ2/4OC89R7hHz14pASRyeJGY8izK34Wz3YkjIdnFC03ZwDpDeFvUMvMDY0k/oh+2TxLeayT7s6+V846f+DyBGkZiabiYVwdxOqF+JwrlOtHm1++SLGej8oSojUq+57Ot5NFHbPHycJhW/YLTec0O0tOiKO2Ht2xzG7BHaVOYOSkiPa3xSRgUAUDlcf5sEgdlfv3NN4+isR2OO3Nz4y7bpEs0NFjE6YjxLnH9xyBoVcjdW1G71npFJEfE2AkO93NIvHnuSJvk3PBuKHl4VhNDIWaB53b4KE/SEM7CyzVCRmqoqx9Jo205sl5KpnyPeohvQPft2h2XE+7SH6Zg1rKhS4Zbf3upckSi6M7nalgwACn7SXvwrmBOkiUdznGorbug1WF3B2NBVuAvToiZFbPUVadLpSVjF6k5VJ4OySrzzi1WakGdf5XzLLiV8DA83tN9IlA2EVUVJIDOWiR3XTdSoQHmrCAHKEUpHpKdrQ/a3kNwG/PLFMjPO43q8Glcretvgozc7A0yEHbnwSNKerJklY/laYGV9WEF5erLAEOoJr2EXu6sVDqwjf15V96R7DAef4kNAtLI/P7jfKU4ubJo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3184.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(86362001)(66556008)(91956017)(66946007)(66446008)(110136005)(316002)(478600001)(6506007)(8936002)(8676002)(6512007)(76116006)(64756008)(66476007)(2616005)(38070700005)(2906002)(4326008)(122000001)(71200400001)(6486002)(921005)(7406005)(26005)(38100700002)(36756003)(186003)(4744005)(5660300002)(7416002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3NYNWs1WllVOWx3cUFVZmJXbU1tK2wxVUxYa1JXN3VoTjV1Z241OE0zK3Ez?=
 =?utf-8?B?WEhsOExWNG9mb0Q1OWYvSXVFTXJpaHZBVFFOT1d4UzhuTmtpdDFwZmZjNWd2?=
 =?utf-8?B?eGVNd1Vuelo1UzBaQmRCMk1qUGdsVXIxWmN5UndsUTVJVmh2ZXNSekhjclVz?=
 =?utf-8?B?WWZOZW1Xb0lMcExnRXVmeWZ3V1Q0RmlJQlhJeUV5NWR0VUxyYXJLNXdVVk4w?=
 =?utf-8?B?dFEzTURSVjVrRGRVazVLeHpxTUFSaFZ0MzBxbGlMRWxtZXUzQ1QzZGMvUFJQ?=
 =?utf-8?B?N21oVTJmUXljR0d2dnRtL0ZQS3dla0FuVVRGWWVjVUZwRTFWdjV3UGpvVG1l?=
 =?utf-8?B?azdTUkt5UDJ4KythbEFNem5lbklyNG1OaFhYNlduRXhuUWFCWjBnRExFd3d4?=
 =?utf-8?B?U1hnWEVCdVpvdC9uU0hwSGVCR1diT2UrVTlwZkpxRnRsRUxmM1hSdkgyRVB3?=
 =?utf-8?B?Q1Q4REZqZUJlRlpodUh2MVR4K1lMQ3dONVcwV3pIM0tuckNGYlgrOXRGcEJJ?=
 =?utf-8?B?K0VQN05SVmx6Y05uQmNDYXZlbzBvMVlKWElZcHVwbGc1WmtCK3RHUjl4ZmRM?=
 =?utf-8?B?NkpBNHdJS24vaUNLYXdaMVd3eVV1RmdMRzR2V3BVcjJUMXpDYjduVzNCMEZ0?=
 =?utf-8?B?UkRJWkpoRk16ZEJxbmRHN0w3SlE2OGxzcHJjdExvRHo0MXpTVTBCY29BSXNo?=
 =?utf-8?B?Vzd6eTVTbDF2UWRxU1Y1eThYR3VPeUVvRlNMcHdnMU5EUXJsUmQ4M0JZWVky?=
 =?utf-8?B?eGNyLzFkU1c4MUt2anNrRmlwbHpGdW41TUdKL3hab09EaWJtOXdiTkErVnBL?=
 =?utf-8?B?dkRpNElrWGcvSkcvM3QxTE1aYUExUUpROG5kTEhvVngzRElBZTI5NUE3RzND?=
 =?utf-8?B?eHVMT2Z2cnhOckxHS24renJVQ0I2cmE2bFREQ3lCbjZaQmE2YjhsRXQ3WGFu?=
 =?utf-8?B?WEMvL0FvVWpYdzROUTJYbGxFTnEybzViSUZ2MFg4SXhMZVg5aURiTDFBVE5Q?=
 =?utf-8?B?ZUpWRUpxUFZZNmVaOTd5dE05TzlyUlQzMTM0OXR3LzFTV25GMFA1aXpkSFZU?=
 =?utf-8?B?YkwzRzVUSm9LSlNadkp2TDdjbHFpc1lKYWkwTzk1T0l4YXJGdnQxL1RKVHVQ?=
 =?utf-8?B?c3FNSVkxT3hKcGVQK2hwemFGWXF4d1RKajA2bUExVGFYV0FYQjVUSEh3bDQy?=
 =?utf-8?B?SE5saUdHK1dvbFNLWFA2cld0eVIvQ1pnNmR6dzhRMW9hZ1pRWE5iL2YrZExj?=
 =?utf-8?B?NGlZVnNXM080NW9sUGpEUDltY3NKWmVLUjByQlEwaGVtVEx5eGtxSEI4ZXJT?=
 =?utf-8?B?cWtyNFEvTEptZS9Eb0V2TnNrdERCRlAxSzlvNXhKT0JHckhBOEVrMVM2ckY1?=
 =?utf-8?B?SUl3aE8vaXNpeXQ2dUEyRzF5LzVKZ1liMHY4MzJYbWl2NlpYNnlWUktucUNl?=
 =?utf-8?B?a2FONzhNdDdWeVdERWZKWEFOcHdQMGRvblFTZ242bkloVWdHNjVKNTJaeW9w?=
 =?utf-8?B?dlBUTnlpb2dsdUp4V3c2KzBTd0RsMGo0dGxuZ2MvV1pIZlBXZXJqaHNXVGlI?=
 =?utf-8?B?aVZJdGxLVDgzOXg0cllmamdkTE1qNkJyS094bS9PQWYrL2NYSHVkdUlINVBZ?=
 =?utf-8?B?eDFoaWtsb3c3T1F1R1hvdnVDZmFuT0llWFBaM1VsKzE5R1JBSGEwN09aU0dR?=
 =?utf-8?B?SFRVSFp0RVNwaHczZ0dNeHhOQiszcXZaZ0duSFg2MHBPZUhzcFYyUFZqK2RP?=
 =?utf-8?B?YncyRGkrVGduMDFnSGJNdk1pS0Y3cGx2eUtWTW54Z0E3eFRKTCs2UzM4dDlF?=
 =?utf-8?B?bDcvZWp5cDY1Mm1ENTdFdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15CCB0CBD0451B4191BB5C31CB59FC2B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3184.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4b4f1c-e4ad-4549-06b2-08d964d8becd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2021 19:20:32.5627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: moVqC69EvPsRG7iFW3ciF9Q/xgxrmUe1K3xulbDcmYdTkoa2JFqJzZOvrqcrwJhLpfhMjFexpfremEdPLnBopmrcpmNb0hlR2+f5aW3Azdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4608
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

K0tWTSBsaXN0Lg0KDQpPbiBGcmksIDIwMjEtMDgtMjAgYXQgMTE6MTEgLTA3MDAsIFl1LWNoZW5n
IFl1IHdyb3RlOg0KPiAgDQo+ICBzdGF0aWMgaW5saW5lIGludCBwdGVfd3JpdGUocHRlX3QgcHRl
KQ0KPiAgew0KPiAtICAgICAgIHJldHVybiBwdGVfZmxhZ3MocHRlKSAmIF9QQUdFX1JXOw0KPiAr
ICAgICAgIC8qDQo+ICsgICAgICAgICogU2hhZG93IHN0YWNrIHBhZ2VzIGFyZSBhbHdheXMgd3Jp
dGFibGUgLSBidXQgbm90IGJ5IG5vcm1hbA0KPiArICAgICAgICAqIGluc3RydWN0aW9ucywgYW5k
IG9ubHkgYnkgc2hhZG93IHN0YWNrIG9wZXJhdGlvbnMuIA0KPiBUaGVyZWZvcmUsDQo+ICsgICAg
ICAgICogdGhlIFc9MCxEPTEgdGVzdCB3aXRoIHB0ZV9zaHN0aygpLg0KPiArICAgICAgICAqLw0K
PiArICAgICAgIHJldHVybiAocHRlX2ZsYWdzKHB0ZSkgJiBfUEFHRV9SVykgfHwgcHRlX3Noc3Rr
KHB0ZSk7DQo+ICB9DQo+ICANCktWTSB1c2VzIHRoaXMgaW4gYSBjb3VwbGUgcGxhY2VzIHdoZW4g
Y2hlY2tpbmcgRVBUIHB0ZXMuIEJ1dCBiaXQgNg0KKGRpcnR5KSBpcyBhIHRvdGFsbHkgZGlmZmVy
ZW50IG1lYW5pbmcgaW4gRVBULiBJIHRoaW5rIGl0J3MganVzdCB1c2VkDQp0byB0cmlnZ2VyIGFu
IG9wdGltaXphdGlvbiwgYnV0IHdvbmRlcmluZyBpZiBLVk0gc2hvdWxkIGhhdmUgaXRzIG93bg0K
VERQIHNwZWNpZmljIGZ1bmN0aW9uIGluc3RlYWQgb2YgdXNpbmcgcHRlX3dyaXRlKCkuDQoNCg==
