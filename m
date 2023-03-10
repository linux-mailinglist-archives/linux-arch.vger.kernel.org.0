Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D736B51CC
	for <lists+linux-arch@lfdr.de>; Fri, 10 Mar 2023 21:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjCJU1Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Mar 2023 15:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjCJU1X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Mar 2023 15:27:23 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C3D13907F;
        Fri, 10 Mar 2023 12:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678480042; x=1710016042;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=m6UEL4qxDQGaJ2IfT2926Ygg16nP0mXnzUDcv1DVTlA=;
  b=MJk7vZGmksEM9POQBrqdoi+4I5lzBarnB/ek3Eq49Kbk9PSCa/R1B5Kw
   xCNolLgxG7w3htvDwBOMYYZJrJKof6C4Znj4NDIpZM9VlZaJiwdV1XW+o
   +mkaABW8tTHjEtUnM1mFG0hJR+JP15yeuDj8CcZm65sEDSDpwhGA7oJe+
   Z6cE600YZx8LJ/pLA3pFU0IY156ST3QD82yyzjhZ9l0MjSDJjBMrpZtlO
   bqgGDv+I2U3NUBl35AcW9LdIVM2htnCI7pXkYGfytJZqx3y1WmPKaPAdC
   naboFH/ijbwG40PmaT2sODu2fz96Kp5kx81cy1rcsgE5oWmR09Wc6stzw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="316471339"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="316471339"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 12:27:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="742113420"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="742113420"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 10 Mar 2023 12:27:21 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 12:27:21 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 10 Mar 2023 12:27:21 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 10 Mar 2023 12:27:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajy4yUhMdFVLyabUNE41zyQg0K1axwiDAI5pX963Ots4kB+9p6qn8L8wA6ic+SJRkBZ7QIpmDj7x/jugzjtlfz1Mc9lzmrkB8VUikHfApIFQSlnxX13mvOL/YTS5ewNnZoIuSERQlbJnx1vtPii2LrCofPwQC/brGG7EqHWygqr82S/lgNxzDD4+48wl/LPhQplzq12MmSk33GQSybJ2hHwWkkKt7Xfo7JfRp7DzOWrxOR/xoIv04yaUfUl3cPialKswp2nFUHwjL701RqEQ3Zdp9dD4e03YYs0nd6LVnnLW0Ttw+GzwE9pikzoC+o7RmNp0ruUnx9Pj1ocH3KdKpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6UEL4qxDQGaJ2IfT2926Ygg16nP0mXnzUDcv1DVTlA=;
 b=BItdjX0sNgKs2YCx+gYQCEoE6LuOriIp+7bvxcixmC6ErdAAQAsC5LtEKaH8k4ENtfq5d1IWpu5gWsPCJSWs2cvT9OIB4CvEsgmpq9zcgt/pw1Xeqb9XnwQWGdbz/C4D0NDYQ7ud5TPIU/GgXHkG0ow3oXA8AfTsZ/o0VxiMv4XWwJJWkjPLf4oZCnvAOuBIagHebjLpeFgaxIUcxeLFReRIqNKpIYVrEQohRuNBGf2hUr3OQtgD/nbvtJyPNDhRt7cRqwaKniO8JxNdfmlHpo8smfbzOo22kexhorbUCQUV06QsTMkwMCUwO6x6ImSJCrb9JBqdtspPirC2eMDdUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM4PR11MB6456.namprd11.prod.outlook.com (2603:10b6:8:bc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Fri, 10 Mar
 2023 20:27:12 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 20:27:11 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "hjl.tools@gmail.com" <hjl.tools@gmail.com>
CC:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v7 28/41] x86: Introduce userspace API for shadow stack
Thread-Topic: [PATCH v7 28/41] x86: Introduce userspace API for shadow stack
Thread-Index: AQHZSvtC0qoWAoXd0kKURn+giTskNK7wu1QAgADbO4CAAOD+AIAAQrQAgAB0BgCAABbcgIAADgKAgAEs5ICAAAdhAA==
Date:   Fri, 10 Mar 2023 20:27:11 +0000
Message-ID: <f020ce5ba5727dc6e25b6cc158be15e9c2ad0bee.camel@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
         <20230227222957.24501-29-rick.p.edgecombe@intel.com>
         <ZAhjLAIm91rJ2Lpr@zn.tnic>
         <9e00b2a3d988f7b24d274a108d31f5f0096eeaae.camel@intel.com>
         <20230309125739.GCZAnXw5T1dfzwtqh8@fat_crate.local>
         <a4dd415ac908450b09b9abbd4421a9132b3c34cc.camel@intel.com>
         <20230309235152.GBZApxGNnXLvkGXCet@fat_crate.local>
         <e83ee9fc1a6e98cab62b681de7209598394df911.camel@intel.com>
         <CAMe9rOrK2d6+Y_Xb+NUW4i+GWRbX+mGx+mJLwnEAB4hvsQ_eiw@mail.gmail.com>
         <CAMe9rOo990TPY-VDzOgGq7aN1aQUjZaWiXLRC81XTq_xqFUm9w@mail.gmail.com>
In-Reply-To: <CAMe9rOo990TPY-VDzOgGq7aN1aQUjZaWiXLRC81XTq_xqFUm9w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|DM4PR11MB6456:EE_
x-ms-office365-filtering-correlation-id: c22f100c-6101-44c4-ca31-08db21a5d439
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1xeRB8X6hvv9Wyz1KGyCEdRtcynk/U40/g8zhmhlxFEu73bmpizn+8+JxphWOXof+tmk/qCrYlSf5TJTVxxkZVH2ukk0zouY43HEsGwMhCCbdB0fMhafKvsI6IpJ3gNqhoGreO3ZtP2WoftWgWJDRzVmCkQ9j5kRZ+8ln4X/l/4SbSd+AWtEU4l7lhq2W8nGdEyZEUEEukq4ms7UOYE3bXoXeN+xMxA8zxbb0bKoxpjtudpnszpT88KNFlcCeQegEUANnP+3wc1LH+FUCRBxDK2D/MpUmuWa/7gambZ3pPXsxHhgTYPerUCutYVKn2Blgnm0GmgHd8xKnpqkFUxfKaQfwNfUnhnUtJd75Og2uK/cCD+nMP51QilvKAK8/Av2XTuQI78yTis66EXaqA0tVnSO1/0jbgktz69seY3FNmqP1QNKzw7gxBtlZ+TKqkoTmurZ6sMuNTo4w5IfiMTRa2N7bTOCnch0z3friR7ZPDMGFvoOdlHRt6FsFge2ahY5r7A3n0Y6sncI+DaByzufxZhvjEDSUsiLkqDyNcm2GIEoE+McpDGZUYCm5BLsSt148pHrJ/clxj7lRh9XNDYHJW5xAtC4n3m4pgUal5GGtKpeaA7IaiscfXHZxuofFMFzNlQRUk6o9y1IpUZdLDQPSJZXYzE56Jpv3usujIXS/frO7EtmMYWTWCrL4MenAY+5NL9gInDqL3OtynqIHrODYitj2Fzh7QN9DVMIy/Trvew=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199018)(4326008)(41300700001)(38100700002)(36756003)(122000001)(4744005)(66556008)(7416002)(2906002)(66446008)(8936002)(8676002)(6916009)(76116006)(66946007)(38070700005)(5660300002)(86362001)(66476007)(64756008)(82960400001)(71200400001)(316002)(54906003)(478600001)(7406005)(6486002)(2616005)(6512007)(83380400001)(186003)(6506007)(26005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEVZajBZRExDYUVGbGNBTHdQRXAvNFlEQ2ZDSVR4c2RUL0UvcDdYejk3S0JE?=
 =?utf-8?B?NGdHNktvVEFvY0ROeStjU0U1VVNLNlNFUmlyTEg4cHVvdDh5VFNxcDRVYUVw?=
 =?utf-8?B?clNQcFVHbFNmaktVSEE3TGNzU0trV083QUZ5ZUxUaTdGdTNYMnBqZzM0elVs?=
 =?utf-8?B?L29yanpMWVA1Q3JZM3ZXb3BGNUFYVmlnSEd2Ym4xbGtVRFhTbytReGxCRysw?=
 =?utf-8?B?d1N5R29OZ0J4N3JhRlFjMFJ6WjZmZWpaQ0VrWUlBV21RaHJsMElpSUY5S0NO?=
 =?utf-8?B?RUNvSElyQzg5aUhuclFwS1dPS3BjTVoxcEFYQm5VMWM2d3d3NjNhcDhwY3Mw?=
 =?utf-8?B?L1JQYmxxM2xMdVdsdTUrazBsNTRkR1NkZFg5QUpLYjRpTXJHYnJaRUNOQTJ1?=
 =?utf-8?B?Y3hmdDRCdGd4eDFDOTU3dTF0cTVZaEVIdnFPN0FiNDZ2WVhydlVJVG1UbXI1?=
 =?utf-8?B?eWpqRzZDR0F4a3UyWUt1ZzV6eFZZekx4ZW5rQVhiVVdzeEpFTGVZT0cwbXJO?=
 =?utf-8?B?dFhtQzk4MGNyRy93UUtwRE4wWDQ2UHI1Sm54ZmxWc0Iydm9uejJyM09weUFC?=
 =?utf-8?B?VzJGZzVaOXUwd1RZNForUEplYnVHZkxTeHJZZ3hid0FMZ2ZUcWtoTkhpaDE5?=
 =?utf-8?B?U2IxL2hnWFM5WmNUWHdRYjJaWlRzdzlOMlZGbmY4V0lMcWpJWVl0azB6NU1q?=
 =?utf-8?B?RTdHTHowR0NHekFBRkszZ2gxQ1pqT2EzcnJXTHo1RWxkcGl6dVpRaE1QcWhL?=
 =?utf-8?B?VE5zdXhUREx6cUxjci8vQVg1dEc3RDB1TERiZXVJcFU4aDBWbFdpZFBhYkhN?=
 =?utf-8?B?dkE2dExpMnFTYjYrcHJOelhwOTFvMVZrRDNyN1BOWDBwa2lnSzQxYzliekNv?=
 =?utf-8?B?SnAwUFMveURZTHVVRmY3VmJIZURaNVB4eDA1dVk1ZThHVU45Q0RGOVJBRldX?=
 =?utf-8?B?d1FJcnhtVmZWMmVPR09QTEVObDdKQVQwdDhpUmhwUFQ5OHhzWDM1L3Y4ZDVq?=
 =?utf-8?B?MkZheUJRei9kNWpmdUZmLzhESUlLQjc5ZklvUEJNL001ZjNJaUtnQlpka2JK?=
 =?utf-8?B?UVZka3RoTGUvaCtpV2tscHRMamZvdW9vWGNsMTF3ZENZRndEY3YxTzlqS3Qz?=
 =?utf-8?B?THFITEdkQkV2OVlTZUJDN3g2NzU1RDR3K0Z5ZlFYNlhmYmppbHRFMitLMFgy?=
 =?utf-8?B?a0RreW9MZDdqb3VLSis0d1lPUm9nOGh5QkRkRGdlNVJQQVRxb2ZqYmFXV2hT?=
 =?utf-8?B?bEVRaGVlYkhPUGY1blNhb2djTHdKK2ZkdmZ0QnNPa0E2ZFE3cGxRYjlDSGdP?=
 =?utf-8?B?Zk5ucWF4Qm1NYm9IYlJ0QjVaTXFuTUU3eVVLWjJQZzR1dnIxaFZPMGFiTEVB?=
 =?utf-8?B?Tm91Nkl1S0s5UnFnVm11bFNnS1FHcURRNjU3RmVMSi93M3pMN2U5b3dTbHpv?=
 =?utf-8?B?U1FORklGR3V3aVBQMENMTGFqUm5CeVlJL3lIZFgwUFQxV25GQjlEZzV2bVR0?=
 =?utf-8?B?dEJGOW1lYkhjWTN5RWhlcTBSb3ZVS2hTZWhjMmpLTG9IWkgyN3VycVFmNEV1?=
 =?utf-8?B?OFl1eVU0ZUhraXZ0bzJUbnZCenRtZnIyUllncERKNjgvMGJOOENQTVBpcTRG?=
 =?utf-8?B?eFZ6cDFRL0MwSDlKbTcyNWZMdEppUnd4NG1hOVpPQUNjQnhrYk5qTDZ3ZEZW?=
 =?utf-8?B?ZmswbHpvU0EyVnp3Nm9qRkE2U1BkR0pGbHcvemlvcFdDZkFGOHc2cXNrUU93?=
 =?utf-8?B?dWgvNVhybGVOK3JlWkF1YitIczExRUJIWVRZTXVBR1pMcmxSbnhnUGRhdW9y?=
 =?utf-8?B?ZnRYcGk5SmNWU21xVlJEYmdtNkZLVHlBT3NBYzJkbGRlVFN0dFFuMkpQc3o1?=
 =?utf-8?B?RUVncTZXdDNTbXpqazFxSlcwUjl2V2dpWmFCYUN3cUZreGJvd1Nyb1VNdndi?=
 =?utf-8?B?czBBb3dDRGtaditXSkVMSkdCNmJvRUhHY0Y4T2poS1JSQXFreDJmZnR6a20v?=
 =?utf-8?B?aWVITUpaR2hySDMrM1o3WEFid1V0L0tuSG5hNC9sMGRLK3JrV3hXSWJEamt6?=
 =?utf-8?B?akFSUnkvbWZkelI3QlJ0anFYVzltSUt3dldsMjMwdXB6VGZzc2M2OEIvUTBB?=
 =?utf-8?B?bEVzODlVYWpERlhmWWJzS1Rwcng2T3FQUlBoNnQrQ3AyNXE0SUdTYWVkM0xN?=
 =?utf-8?Q?L/BeXxrQHVVicjyIiPJXSlo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C341609A59F2048A65CDC7BAA76DBF9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c22f100c-6101-44c4-ca31-08db21a5d439
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 20:27:11.6465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Mddg/LK8Yf6Bpr0LtIxPolu5sfRghwTBLeJnVta6mQtSZjKTuhMoXMbekerwR3UR9L1Nsg8+XwmtAzrniRzTqxbcson6HyFf4v/jD6yid0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6456
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIzLTAzLTEwIGF0IDEyOjAwIC0wODAwLCBILkouIEx1IHdyb3RlOg0KPiA+ID4g
U28gaXQgZG9lczoNCj4gPiA+IDEuIEVuYWJsZSBzaGFkb3cgc3RhY2sNCj4gPiA+IDIuIENhbGwg
ZWxmIGxpYnMgY2hlY2tpbmcgZnVuY3Rpb25zDQo+ID4gPiAzLiBJZiBhbGwgZ29vZCwgbG9jayBz
aGFkb3cgc3RhY2suIEVsc2UsIGRpc2FibGUgc2hhZG93IHN0YWNrLg0KPiA+ID4gNC4gUmV0dXJu
IGZyb20gZWxmIGNoZWNraW5nIGZ1bmN0aW9ucyBhbmQgaWYgc2hzdGsgaXMgZW5hYmxlZCwNCj4g
PiA+IGRvbid0DQo+ID4gPiB1bmRlcmZsb3cgYmVjYXVzZSBpdCB3YXMgZW5hYmxlZCBpbiBzdGVw
IDEgYW5kIHdlIGhhdmUgcmV0dXJuDQo+ID4gPiBhZGRyZXNzZXMNCj4gPiA+IGZyb20gMiBvbiB0
aGUgc2hhZG93IHN0YWNrDQo+ID4gPiANCj4gPiA+IEknbSB3b25kZXJpbmcgaWYgdGhpcyBjYW4n
dCBiZSBpbXByb3ZlZCBpbiBnbGliYyB0byBsb29rIGxpa2U6DQo+ID4gPiAxLiBDaGVjayBlbGYg
bGlicywgYW5kIHJlY29yZCBpdCBzb21ld2hlcmUNCj4gPiA+IDIuIFdhaXQgdW50aWwganVzdCB0
aGUgcmlnaHQgc3BvdA0KPiA+ID4gMy4gSWYgYWxsIGdvb2QsIGVuYWJsZSBhbmQgbG9jayBzaGFk
b3cgc3RhY2suDQo+ID4gDQo+ID4gSSB3aWxsIHRyeSBpdCBvdXQuDQo+ID4gDQo+IA0KPiBDdXJy
ZW50bHkgZ2xpYmMgZW5hYmxlcyBzaGFkb3cgc3RhY2sgYXMgZWFybHkgYXMgcG9zc2libGUuICBU
aGVyZQ0KPiBhcmUgb25seSBhIGZldyBwbGFjZXMgd2hlcmUgYSBmdW5jdGlvbiBjYWxsIGluIGds
aWJjIG5ldmVyIHJldHVybnMuDQo+IFdlIGNhbiBlbmFibGUgc2hhZG93IHN0YWNrIGp1c3QgYmVm
b3JlIGNhbGxpbmcgbWFpbi4gICBUaGVyZSBhcmUNCj4gcXVpdGUgc29tZSBjb2RlIHBhdGhzIHdp
dGhvdXQgc2hhZG93IHN0YWNrIHByb3RlY3Rpb24uICAgSXMgdGhpcw0KPiBhbiBpc3N1ZT8NCg0K
VGhhbmtzIGZvciBjaGVja2luZy4gSG1tLCBkb2VzIHRoZSBsb2FkZXIgZ2V0IGF0dGFja2VkPw0K
