Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066076788D4
	for <lists+linux-arch@lfdr.de>; Mon, 23 Jan 2023 21:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjAWU5n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Jan 2023 15:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbjAWU5i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Jan 2023 15:57:38 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C4D34C29;
        Mon, 23 Jan 2023 12:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674507446; x=1706043446;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Qa7EdAAsaGk0XvWr9J8lCOzJP3rsN9YGj5HrkxHFzcg=;
  b=nj32wC1gM0o3G9xKsDhJ//Pli8I4F/hfHyJQ3wGVeYBt1s+dJrrF4M+C
   c3dwtaHLjyH1Q83bvg/MipV7CdyLTUirj3udrOpnZMMnCbecTkJHecFqG
   h4mj0HdLdFFgbkDG6Erh1q+KwEHfIPxyi27fvBDyi1szMIdo3nAbHEODM
   pu6OmSmg6TZAnU3uDPclte224woM0sB8NoUdJv8fgy23+hvXOlUvpqmVk
   X6eVSHdil6sZddSpIMU8rry4TdSTOI26xb8/wvuTQVqISIeFx8v8O0ecL
   72INxqlQOkdl1NUjTrCsrYynKpyYwr72dfklkr9Jgnyx7Tkke7l7SVx4b
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="390651824"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="390651824"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 12:56:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="725217679"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="725217679"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 23 Jan 2023 12:56:42 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 23 Jan 2023 12:56:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 23 Jan 2023 12:56:41 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 23 Jan 2023 12:56:41 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 23 Jan 2023 12:56:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuoanlzMrlJpK6jmKR0V6eKSuwIY0oXVManSXOWP6aKtlw4O5vwaI1SIIf5hyiIYsPkd8TKyz/Sl/JBZ5VqF7aloEocuPkP17K5iuO6xT75oxkzvd62u0nCVkLTSaRU+b0977Kaa59RXUP5i0pllb50KztTt/DrfUmTjwXyox1UonY7j36d0H3HYsAR6RtL1CYkeQgmX5X3KV1I/4NOgqmBhLN0Z8AghGppB/NyfrBvem/2P+PFTEp2Rs9TUVdhIcpmnhe5aBQ8rP+KQ+w+QAqk52Cw/TikULNhDSh18WI8JArYAZlkWdXRy5rCoomXy2fb84kIk9Gvc7dOOZAWRtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qa7EdAAsaGk0XvWr9J8lCOzJP3rsN9YGj5HrkxHFzcg=;
 b=ZODzCWaLZ2mORoURe6ZiWWejc/RKlcSNofaG9tE921Jw6BBdnRDI9G3YR3xPrlr4uaR+UQNEPP+O4jrvV4zak+OppcpZItEfvtj0IPcmRFSLzp8OfxMcuAbMGDs5AOk7/69F0ZDtADPom18zT46Jiur2/7jPGhU6HsiE4xTiB65yrvIdjp6Wg7zI6hmtbBQuKPtEeQMdOQgU4bIxOh6sIG4GwiVLG+gc4/2SqT94tD0yVp3A2UBzJjXlM9a+CBMke41pQq3Vak8AlIR9/+EpY6Vkrnz4o6E/QXKumhDU4i6mO8PsR1Y+HvuFeCBJmTE7U2fcRnGKdlHV7P/Vp96MVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH8PR11MB6732.namprd11.prod.outlook.com (2603:10b6:510:1c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 20:56:37 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 20:56:37 +0000
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
Subject: Re: [PATCH v5 10/39] x86/mm: Introduce _PAGE_COW
Thread-Topic: [PATCH v5 10/39] x86/mm: Introduce _PAGE_COW
Thread-Index: AQHZLExT784/QHnuOkagf6IWvoAn2a6rwXqAgADASgA=
Date:   Mon, 23 Jan 2023 20:56:36 +0000
Message-ID: <bbc4f4df98ec798ae15e5daa6b5ceab41bcc66f9.camel@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
         <20230119212317.8324-11-rick.p.edgecombe@intel.com>
         <634aa365-1f51-8684-24ae-3b68aba1e12a@redhat.com>
In-Reply-To: <634aa365-1f51-8684-24ae-3b68aba1e12a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH8PR11MB6732:EE_
x-ms-office365-filtering-correlation-id: bcdf3953-b8f7-47de-df3b-08dafd84515b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KvIEG1ZLPyQl0OXjp0g4B6q68Xs3Pvq6nXVEpb+Fzua9E8Xd7GVK6H1x9mRL5gv/tOe7n50h7/jjBAEXB6t79jrRPD47qp9HFtnFHdMltmKFOa9MIDVlkmEUTNXe1ZkPi60zgASu/HtGA5mfxCl2brstoEGvNqGex6WCDsJRSPEZRd2VpvxR3KfQnxPoOu7islKpbY5BQL7UBa3VFZiOzZxIQ1iKfQWSeExzBIAABmIbLdj4KlVOZnzbuR4EwhI0QNi9h4QcVRe1dbPdynV/jP33uL7/3dRVoT1H9rmIPS7b5+BzogtF2nsA8ZywFaOWE8yAkI8Tigvr8P1rVQKEDMomaHVlP3eSQCZqkmRuMQs8Eym8w7Nh0p7nGZF6er9wZ4xFhePOP5qQw6ZXMYDZj12UrKTTrUXY9KFh4bG0qnpnN8R3HDkyB35BejtOjqxGL4TpsE9zC6RToZeXa9cXa1B+mzLlkaMrPr98X5+d0VEpgbIZUIlGbAfjPHBKf8M7Ir2FZFIZG0mJh3Hyzo//BeRr3jxelEmBUVQo/gggtfXxoavvkrtg4DXLwChJ386T1eYZHwnYfFWciMVBHWlhXZVEThgb3yu8X962xEshseFMDvJONok7tVyobKGwuKNlBYw2ioUuiJLQdmud65NXYpoe8KhY7FiLtECIjFkAZ2domfGbXfgVpD8YSgd7oL8cGkLfra+pKggl9XratWmjyWI+iuAl9njvHmnWvuICw3EpeT5g44aPeiSxqLKT0d0D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(39860400002)(136003)(366004)(346002)(451199015)(41300700001)(921005)(38070700005)(82960400001)(38100700002)(91956017)(66946007)(36756003)(76116006)(8936002)(66556008)(66476007)(4326008)(66446008)(64756008)(8676002)(316002)(7406005)(5660300002)(110136005)(86362001)(2906002)(122000001)(7416002)(6486002)(6512007)(2616005)(186003)(26005)(6506007)(478600001)(71200400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFo3c2lrTmV2Q1lWKzc1TTQ1SVhTQjlBaFVpU1JqbVFDSmg5clF4akhjemVz?=
 =?utf-8?B?UTBlTmtXa0NQQ2dQYXF5Z3NVc0ZQMEpYZmt6THZFM3FFczRYMFcraXhXdm94?=
 =?utf-8?B?Z2c5V0RHRnUvUDdaUnVMY3FPc3A4NVpGZmRneWQrMkJ3NEsyZVNYb0VPbWkv?=
 =?utf-8?B?elUveitVeXBEMyt2aFdDS1E5SnhDcDFYcHhGbG8rZFFoM0V5REllb2U1Mk1t?=
 =?utf-8?B?enR2RUhKTGFVNngrZ0JUSkprdG9odGV6QlpLN1VOWGFjMHVTUTZkMFdWUk1v?=
 =?utf-8?B?VHZpaUZteWRBdHBvVkJESXJZbXQ2d2k5MmJPSFJacm9veUs4S2xBNnVna0J1?=
 =?utf-8?B?by9yZVhsNEFLMkQ0S3BxVUhrN2o2WndmWXAxVkdxc1BmVjgrQ3dwU0FCS0RE?=
 =?utf-8?B?anpJZUJINGhIeVZGTUkyWk9yd2YwOGtFTTBGcHJqbEJTMWtsMHJVUjV6K054?=
 =?utf-8?B?dkU0VDZKTUN0c0YyU2RsdGlCY2RkK1g4ZkpsNUdtK2haclo3UjR4aWZScVNW?=
 =?utf-8?B?TU1qcnpOQ2tJbFZHZitDL0FwemloVkxDcjFOVHNCemtEVHlCN2p4Sy9iTVBU?=
 =?utf-8?B?bEw3czh5VzNYUS9tbjRhaG5oOHZ6bTA3TWl5MkY4NXVWWGJ1aVViR245Q1M2?=
 =?utf-8?B?NTJYbHVvakJRZTdnQjk1d2tLcXN3LzZtNjA2Y2xGV1p6UTh2bWNicVVkSU1o?=
 =?utf-8?B?UG1rVFphZWFiY2xCZFUza2hMS01NWEdjUElJdGVwVE1mRWlPeUpFVlJVZ0ZD?=
 =?utf-8?B?bWM5cmt2eXo2VTM4ajFKc0pDajJHNEZjSTg2WU9YWGRycjUvUE5XdStZZ1k4?=
 =?utf-8?B?Qm8vWlVBTndNaW56eEo5OFNyaENnMzBlL2dYdVdla1pBZnkzWmQvWDFNa1Bt?=
 =?utf-8?B?S3lnSlZSRVVGbkdXVkp1UVBiazBMSFJPSjFvaU8rWE9ES1ZITm52YmNyUzc4?=
 =?utf-8?B?eWFqYzBuUkUxK3BucHk5cWNXM2hWempKMk1RYTB0NSs2VUo3N2NHc21FcFFE?=
 =?utf-8?B?SHdwZUI3Z0haczBCRXZuZUUwdWtxTTZjNyttZiszREZvdVA0VkhHcG80OHVI?=
 =?utf-8?B?Qm1PMU1jZnR2bVk1YnJiSy85NjdCWUN6NzU2STcweTZuOVV0a2ptTHJ2YjE5?=
 =?utf-8?B?bk5Pd3N5OFNIcjFqVE94TC9JQ1N0NDY1MEprNS91QVNvRnA3VnhiTXBBeTJy?=
 =?utf-8?B?UzNaM2o3dHB1clJ6QWNtbThpdXZidmVKc1k3dG15ckMrM21PS0NUT3hPeXEz?=
 =?utf-8?B?WEduUE9aNXV0V0tZZHkzdSswVm9MM3grYjNjM0J4aVhPV01JaWZiVzNUdi9X?=
 =?utf-8?B?bDVFSzJjeHhXblJTK29kYmNMSDdqbDFkNHN4TGozaFNIc05tZUVrMUFTWEpQ?=
 =?utf-8?B?YmZmcVZWMjZRd1BkZDNEd3VHOWtyTld5ZFIzaEovQThoWmk2ZlRSZDFPQ2xl?=
 =?utf-8?B?c3RiaHZHL2p2Ni9US2lVU0JzeGt0VVdGK1NneHNpaWs2TkpvZ2hseVBwY0NF?=
 =?utf-8?B?aEdLWGxYNmhVam9pU2w2VXZxQ1J4cGtPbERMN0hrb2FyU1dwU3dVNXk1RzBG?=
 =?utf-8?B?VzFDVHBtYnhEYlEzTXFjTzNacVpLU2pnNkZtOHA5VGUzdWRJeGFNZDN3UHFs?=
 =?utf-8?B?OGhzaTBsY1Z4VjRGZWJxc1IxZUpVelNoNjMzTnZJRTRqemI1Qi94bFFrQ1FF?=
 =?utf-8?B?Nk1uOE41bEhzUFU4WElpNHkxNGtyUmxreW8xT2VHWHU3ZWlyQ2lYK2tJNytI?=
 =?utf-8?B?UEMzbVBYMXFCdzZmd3VrM1NSV0I2YXNXSktPaUxZYlEvVmIrcUdDdkdUNXdj?=
 =?utf-8?B?TTR5d0FBbjg5QmR6ZzBDd0J1ZjVBaTM1STRkdy8wL2xXU2RYRVdOUXFMbWwy?=
 =?utf-8?B?WTlseVhHVlVHMnF1dS9LcmdMN0FWRzl4b2lGUGpyOTNtb1FuZDVvNENxQmFJ?=
 =?utf-8?B?R0dhQXBNUWdFYTBWTDRKTkYwUTFRK2ZUYVFqQlhUSmZ3eGxjbTRiVmN1WldS?=
 =?utf-8?B?RmlVYkt0TXpsb2tYeGhhMzlLaFR5dlFzUkVIaFZwSUZOTGIxSEVRV2FiT2Vq?=
 =?utf-8?B?dU1DeVl1VHlhL3MzNTA5eHRkYWtVN0NEaml4ZG8yb2hBZ3Y2cWtvMFdPcERr?=
 =?utf-8?B?L2ZRd2FqZ1FhRDdqWi9YTkExK29IQkJtdnEzVlZFRDJTQ3hvck9hVWh6OXFP?=
 =?utf-8?Q?JQOdshKtu6Nqb+w1bgikhw8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DEB02E2E5F0CB48AE105FD3E716B1DB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdf3953-b8f7-47de-df3b-08dafd84515b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 20:56:36.8676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KWxeqTMQL8M+qbNYLLL6LM5rPocj0a7OjS8uM8P49ZC0bFUqX7eZoKwKcDVOa7CmSzkoljxbOuYoCDZeWCKVPV2qk60wxn0z9uBMdYrTaBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6732
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

VHJ5aW5nIHRvIGFuc3dlciBib3RoIHF1ZXN0aW9ucyB0byB0aGlzIHBhdGNoIG9uIHRoaXMgb25l
Lg0KDQpPbiBNb24sIDIwMjMtMDEtMjMgYXQgMTA6MjggKzAxMDAsIERhdmlkIEhpbGRlbmJyYW5k
IHdyb3RlOg0KPiA+ICsvKg0KPiA+ICsgKiBOb3JtYWxseSBDT1cgbWVtb3J5IGNhbiByZXN1bHQg
aW4gRGlydHk9MSxXcml0ZT0wIFBURXMuIEJ1dCBpbg0KPiA+IHRoZSBjYXNlDQo+ID4gKyAqIG9m
IFg4Nl9GRUFUVVJFX1VTRVJfU0hTVEssIHRoZSBzb2Z0d2FyZSBDT1cgYml0IGlzIHVzZWQsIHNp
bmNlDQo+ID4gdGhlDQo+ID4gKyAqIERpcnR5PTEsV3JpdGU9MCB3aWxsIHJlc3VsdCBpbiB0aGUg
bWVtb3J5IGJlaW5nIHRyZWF0ZWQgYXMNCj4gPiBzaGFkb3cgc3RhY2sNCj4gPiArICogYnkgdGhl
IEhXLiBTbyB3aGVuIGNyZWF0aW5nIENPVyBtZW1vcnksIGEgc29mdHdhcmUgYml0IGlzIHVzZWQN
Cj4gPiArICogX1BBR0VfQklUX0NPVy4gVGhlIGZvbGxvd2luZyBmdW5jdGlvbnMgcHRlX21rY293
KCkgYW5kDQo+ID4gcHRlX2NsZWFyX2NvdygpDQo+ID4gKyAqIHRha2UgYSBQVEUgbWFya2VkIGNv
bnZlbnRpb25hbGx5IENPVyAoRGlydHk9MSkgYW5kIHRyYW5zaXRpb24NCj4gPiBpdCB0byB0aGUN
Cj4gPiArICogc2hhZG93IHN0YWNrIGNvbXBhdGlibGUgdmVyc2lvbiBvZiBDT1cgKENvdz0xKS4N
Cj4gPiArICovDQo+IA0KPiBUQkgsIEkgZmluZCB0aGF0IGFsbCBoaWdobHkgY29uZnVzaW5nLg0K
PiANCj4gRGlydHk9MSxXcml0ZT0wIGRvZXMgbm90IGluZGljYXRlIGEgQ09XIHBhZ2UgcmVsaWFi
bHkuIFlvdSBjb3VsZA0KPiBoYXZlIA0KPiBib3RoLCBmYWxzZSBuZWdhdGl2ZXMgYW5kIGZhbHNl
IHBvc2l0aXZlcy4NCj4gDQo+IEZhbHNlIG5lZ2F0aXZlOiBmb3JrKCkgb24gYSBjbGVhbiBhbm9u
IHBhZ2UuDQo+IA0KPiBGYWxzZSBwb3NpdGl2ZXM6IHdycG90ZWN0KCkgb2YgYSBkaXJ0eSBhbm9u
IHBhZ2UuDQo+IA0KPiANCj4gSSB3b25kZXIgaWYgaXQgcmVhbGx5IGhhcyB0byBiZSB0aGF0IGNv
bXBsaWNhdGVkOiB3aGF0IHlvdSByZWFsbHkNCj4gd2FudCANCj4gdG8gYWNoaWV2ZSBpcyB0byBk
aXNhbGxvdyAiRGlydHk9MSxXcml0ZT0wIiBpZiBpdCdzIG5vdCBhIHNoYWRvdw0KPiBzdGFjayAN
Cj4gcGFnZSwgY29ycmVjdD8NCg0KVGhlIG90aGVyIHRoaW5nIGlzIHRvIHNhdmUgdGhhdCB0aGUg
UFRFIGlzL3dhcyBEaXJ0eT0xIHNvbWV3aGVyZSAoZm9yDQpub24tc2hhZG93IHN0YWNrIG1lbW9y
eSkuIEEgc2xpZ2h0bHkgZGlmZmVyZW50IGJ1dCByZWxhdGVkIHRoaW5nLiBCdXQNCmxvc2luZyB0
aGF0IGluZm9ybWF0aW9uIHdvdWxkIHdvdWxkIGludHJvZHVjZSBkaWZmZXJlbmNlcyBmb3INCnB0
ZV9kaXJ0eSgpIGJldHdlZW4gd2hlbiBzaGFkb3cgc3RhY2sgd2FzIGVuYWJsZWQgb3Igbm90LiBH
VVAvQ09XDQpkb2Vzbid0IG5lZWQgdGhpcyBhbnltb3JlIGJ1dCB0aGVyZSBhcmUgbG90cyBvZiBv
dGhlciBwbGFjZXMgaXQgZ2V0cw0KY2hlY2tlZC4NCg0KUGVyaGFwcyBmb2xsb3dpbmcgeW91ciBH
VVAgY2hhbmdlcywgX1BBR0VfQ09XIGlzIGp1c3Qgbm93IHRoZSB3cm9uZw0KbmFtZSBmb3IgaXQu
IF9QQUdFX1NBVkVEX0RJUlRZIG1heWJlPw0K
