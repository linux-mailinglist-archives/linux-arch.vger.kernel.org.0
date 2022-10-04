Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02365F4C67
	for <lists+linux-arch@lfdr.de>; Wed,  5 Oct 2022 01:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiJDXGU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 19:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiJDXGO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 19:06:14 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7541E29833;
        Tue,  4 Oct 2022 16:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664924762; x=1696460762;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=iocTBEO1TgQ/KhmwgPoizP4FSKFG7IN6ae5zK+BfmwQ=;
  b=kZSBZZrVQjyjE25P2mf2k/EUXmRdusPmjWBY1XkoNusdRa8RJDlFW3FS
   BobhIZ4bb0rHTEeB67E/ucLuKZBiQVnJwkOYxuM+H1xbXoBzNUixRZcrH
   rueqaFrnKkrX73ehDpH7GEp3IQtaIDFU8wkIxjqkwbRf5WOuZU6FK6P+y
   F6oGwSg5+Mc5qlhrSa6YwvuNTI4bMwDm0/OW8I/Jm2x3UfSsHTPt/AyoB
   hvN4+yV7FMdP/4BVTpAMb8f448OBbsnQ+1vi9Ja1/4kFE8ux24ykA92BF
   +StzzZh0LGn6+ajMM4xuaP1hYuZJRG9XyXzigCfertE/w8jBUJudeepka
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="283413964"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="283413964"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 16:06:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="952977614"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="952977614"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 04 Oct 2022 16:06:00 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 4 Oct 2022 16:06:00 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 4 Oct 2022 16:06:00 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 4 Oct 2022 16:05:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWFfzyQgyv3BtXMo2IItnQ5xabzXO5Tpq50IMVX9CSa/Gkhqx7XxmpTvWsWbgUZW+5jS753CI8H536mpFUohZW1cFpJWdp/dDI3QVqImn8k29IXGDZDuy2+7ltJXQMgn4Oxet8PLCGao715sh3y5fy+mJqVD3vL5OXAzv8LKN2uVspO/Jx8ZPSG9kn0B44OD/eu7yBCCxCpKO4Gu4dbZkm24Ks/KejGyrm8QIei2ZoLZVEbTLuBW1yhwh6iGeM+rnqmjy5PzwggUHNqte7eI+n0th1HJLV/R5i3TwKHlSwQPF+UasbyhfMNbJrxAIw/WXKOzfXiaVD/TxjXMaQfAzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iocTBEO1TgQ/KhmwgPoizP4FSKFG7IN6ae5zK+BfmwQ=;
 b=XqBP7tXjeuAXkLmJM52Sk2AA/+rhhMqaYaaPNgXEGZibg0L2FE7WKmWAuxHZJyAlowG5iMmRqHEF1gGgMmtPVU0wE2ToVZ4nCtFnwWbbITk2X0JgvhwzGa2/hnXPvfxcYeK0mEvKs1LV/XJF/FRGnMKDZgALXIjizTQ+fS8WblKpd80AvK4al1DajHQkrxkpiaxyPRlXZrDONpTGID0jZSaNutFcwErpuQHRO88HBXdFmnXqmvdld4cbFQTgvDwy/1eIi+r5TucmxC88/+VuTjO73/24Z5wUDRTPeOKWyNW1eZ2KZluCbQjr01YzmOaGBA+Nht+D1rdxl/I2pBr3Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MN2PR11MB4613.namprd11.prod.outlook.com (2603:10b6:208:26d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Tue, 4 Oct
 2022 23:05:57 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.028; Tue, 4 Oct 2022
 23:05:57 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
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
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [OPTIONAL/RFC v2 36/39] x86/fpu: Add helper for initing features
Thread-Topic: [OPTIONAL/RFC v2 36/39] x86/fpu: Add helper for initing features
Thread-Index: AQHY1FNFA/h6tyQvpU2V9NTSRx5trK39Dg0AgAHVBAA=
Date:   Tue, 4 Oct 2022 23:05:57 +0000
Message-ID: <d73d9abca9d4b0a8c630235d9cfb3ccc5148e298.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-37-rick.p.edgecombe@intel.com>
         <8c1d2951-1f95-774f-cc8a-35b7d69c521e@intel.com>
In-Reply-To: <8c1d2951-1f95-774f-cc8a-35b7d69c521e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MN2PR11MB4613:EE_
x-ms-office365-filtering-correlation-id: c35c0a5c-4170-47e0-0261-08daa65cff47
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e5kaliaxxjh5eOEEdaXvBmdRBTwvcdoKUlpdR3TJC8rnWPuF3qBGNOB6ve+si0/CWGVYgbiEk0pwugqXl8xFpscXvwIIT0dqzqb+B7wgnw12fvCBZMgNjVK1cxgZ+mZm/QhjQGnb7XLSNmRROontKkms3JQDnXFu73i01ggPhur8ltJQFncv3RxFGgPcSrQ6ILPlC2jH/rzXXDAw1KPHYqXP79l73DojnXPvyZn+rdowAEdT4Ryq4xONsRuk8SWF9AIy2iskNs44vcxsO6PFnkAAXm4MvteBxbANITEvJ1CBpLycz87qT4yH3K8x2UqZWgPUm9FyyzXiOiXwdc8dAcUaEuAKCXk+TapLokZ1cloaQs5tOmkM4B+sWAeq9Ee6hznDg7OWvFjjpFVi4lGEms/17widM8Xj5maaexmqeXXdgSCKpHBIDWSGcHMfv8eHZMmWa3zRk7+psvYPSXoQ0LBkXhStcqAxGwG2Z1BpqIAlaW0g+pdwZQ7srAhCrTKpmA2hN8YjFvSiEFlivS1kApEqNOeWkarJBSPoKQ3dpNUPctaYdc6pLYo0wflyi235yJT8HEcPJroIUBhPQqmx0UuZKHFBiL7sZdwxwwFeX5GGJarwmRbgn0+nMayFubdIfk6zkPw8E2EUk+RKgDyR1cbXOlTlgSXzS6VhzZedUKbuiOc2AtQiKIDpl+N/s8jJsz8u13zbvndKsrT5GfCiczQE/XzaYhK0VCEmpScaISrV/5vhKV6zYvp41vfGhIK3/ERtdM+nu/kvtdxlhD8mGzcx6XmwhTqevDKwUpKD7DvryV11SXAJ9XgSGW37y0t/Efu3dzLb+DD/+ZfISvMgVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199015)(2906002)(6506007)(5660300002)(7406005)(26005)(41300700001)(86362001)(38100700002)(7416002)(6512007)(66556008)(478600001)(66946007)(66476007)(82960400001)(83380400001)(186003)(64756008)(71200400001)(122000001)(8936002)(2616005)(38070700005)(921005)(91956017)(66446008)(6486002)(966005)(8676002)(36756003)(110136005)(316002)(76116006)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzltZUVPZU9KL1Zyb0JIQVg0TmpDeVFyV2J3R1dmdWVTeHR3RzVDbnFJV3Bv?=
 =?utf-8?B?cUZReXE5TGUzVzZEZXdRQndTc3JHYS9OR0V1TVc3OXlqdklmaDBrOWJ1NUJB?=
 =?utf-8?B?ME5GbHNoVnpTdTYzODhRSHVScDFzMVVlbXRtenhKMUQyWnRSakhuMXA3R1RQ?=
 =?utf-8?B?MS9DVE5Ma3lCb29QVEdWM04reFZzQ1dhSGFJYUpneUJhK0cvcCtwazFCVnNF?=
 =?utf-8?B?NkFVM3lEQ2RwZDNlNEJWdEU5bUhqMkJURklhVGtUZnB3cFRhbWI3WjAvY2dR?=
 =?utf-8?B?T1oxbDZ3VTdva0JBWEZ4RVBkWDE5Y0xiS0RpUjNjeWpZZ1FjUU1QcmxWQlNF?=
 =?utf-8?B?VkpDL1lJMjl0b242TEFMbE11ODNYQVdHV2x6TWFEZ3pHeHQzZENWQ0xtZlk3?=
 =?utf-8?B?dUZHa2w3V3pRQnFvenZOM1lWZDh3WWlqQ0YyY2drMm9ERlFmd05kc3dxaGNt?=
 =?utf-8?B?T3ZxaE8vNnhVWGp6cjl1ZEFpaGYxVWtEQ3RGT0JxWGdpMWc2OUd4RnNyVVhR?=
 =?utf-8?B?TURqOWI0bXR0VG9EU2pTVmVtWmM5Q1N4T0pzakExbmdrREVnOTVaMndzcDJW?=
 =?utf-8?B?NnpRbnNrU1ZqTkV1MTNyNFB5K0V6OU5NU2Exa2p4TkN1b2U1Yk9tWmlyVzU4?=
 =?utf-8?B?aTdjMUx0QTBUOG4xdEl1MnBDWjZKbHdkWlRpc0dudjkzSXpXazAvQnNDemhz?=
 =?utf-8?B?eXkrdzV3cmIrOTdFdWxsYXVlemRnZk1Ka0hkeXdSeGlXZGVoYjhnZFpvcEJJ?=
 =?utf-8?B?UXB1TVRtdlkvQ0VXQ0M0SzFJWDVYYUVBRTByVlVzdVllVWdaODBuY0o4RlRU?=
 =?utf-8?B?KytYK1dzOERzWGk2djR1NkV1RCsyNDFYZkkvY21hYzRCNDEvOFprV0VMLzV5?=
 =?utf-8?B?R0EraTZzU0ZNb20rNEZFMnVOSG1qY0Rsd2VvQ0s3VS91RVFBSE1MaGRZUzZW?=
 =?utf-8?B?RjYzZVBlTXV6SGNRSWlFV0grbFY2Q1pqNjNpemNYWkcyYmo3L1BnWFcwR2tl?=
 =?utf-8?B?cFdoT2VyV3VPaUVLanhZUVVHTGxPOTdMWExHZmJkL1I1M20rTDFzY0pzdkVt?=
 =?utf-8?B?a1BRSlJkZHROM1pwZUl2ZjdySGJlQTA0VDJRMi95Z0U0c0FSVmhkMGFNQWdS?=
 =?utf-8?B?K1VOcWIwcFR2K0tZZXArZTNBRVAxNGlXK1pYQU9BK3RVOGFiOVREK3FWUldV?=
 =?utf-8?B?WFZNSVZueUt2VzkvUjJsWWRhbTdPOGVqejF6S3Z6UGlGYnV4Wng4aEs3QnIr?=
 =?utf-8?B?SHJtaUtMRUR5SVhvZUNXM1dhU0JOSHFVUVZ5ZjRPV2k1UVl0YlJ2TDFqcWZw?=
 =?utf-8?B?U2ZJNjE1SnRGNGlpWlBwdWFVTHBKbVMvNm9jNi9tc2NHcU1DQ09TVURidkxn?=
 =?utf-8?B?dGQxdlZBZEJNeTN4R2d6d0tYS0ZQeW1ZZnZZVU1NOTRkZlZ0LzNiV1Nhek9G?=
 =?utf-8?B?NlRSSmFPUWZ3MTZHSFR4Y1NhYTkvSjVzaklwNXZZSHlLME9sY3VydW8reE1w?=
 =?utf-8?B?QzJxcWNKQkI0QlU2OFRtYnJvdXFwcjFmRG9obEhISi9SdUs4V0FpSUw0UHQv?=
 =?utf-8?B?cVFWZ3FwQklXamYxKzJOVTJ1TFdmMXhNQ2tmR2VWOWdkWlN0bEpTa0VXZFBu?=
 =?utf-8?B?OGRsdTZFL25FKzduby9QeUgyVnNvcSs5c1R5aXlXSk4vUUtDbGtjK0JKSkVt?=
 =?utf-8?B?VlhSckNMU0V4V0dubUVRV2cvOTdMNDd5ei9EVDNhVzJKcVJqV21OM3dQZSto?=
 =?utf-8?B?QmtpVmJUUGErNTFVQS9FWVV4M04ybTNpVzE4dEo3bzMrM2VwUUpkWXFWZTc1?=
 =?utf-8?B?dzlVYXhXaGI5Y3BKV1VLbUV4WVZYUnNQSlFzVm1zUzVTbnBRS0x0MGRxSjdY?=
 =?utf-8?B?R29Xb1duR0ViQk5PUjljVmJ0MUphbVhDcElqUHJIU3l0UnV6U2Y5eEUvRVBv?=
 =?utf-8?B?anhZN3Y5YSs0K3JqTkhNNmpsOUFuTUpybnM4dmJkYUI3eS85M1hSYllBTDRY?=
 =?utf-8?B?UzNXdHRSN1FhdlpCUUoyNVNiMFM3MlhRQ0hBdERVNjBjaWdRbDNZMmNIeDM3?=
 =?utf-8?B?bUs1c3FSWUpOdEpMblRJWlBoY0w0cjVOTzVSLzVnOG1Obk5naVpVU3NkSmdT?=
 =?utf-8?B?dldBajFHV25OK1o2SnNoMVRlaFREK1REZkMra3cvWEt6UEtMaHRDN1lyREJs?=
 =?utf-8?Q?cDglFdTTEb3l/clMAhsMZ6E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1FCA8839F4AC344B8DD7FF574FB7E75C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c35c0a5c-4170-47e0-0261-08daa65cff47
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 23:05:57.5923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8N5WihJsxPizOqhlBuSrENz+uKe+w/nIhPqxOir7WsKjR1+fA9jkheH88/u6bM0TKlYl9DDj6FQqQFrt+yNCMup1HWiUMPkhtG4xmSDvuec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4613
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTAzIGF0IDEyOjA3IC0wNzAwLCBDaGFuZyBTLiBCYWUgd3JvdGU6DQo+
ID4gKy8qDQo+ID4gKyAqIEdpdmVuIHRoZSB4c2F2ZSBhcmVhIGFuZCBhIHN0YXRlIGluc2lkZSwg
dGhpcyBmdW5jdGlvbg0KPiA+ICsgKiBpbml0aWFsaXplcyBhbiB4ZmVhdHVyZSBpbiB0aGUgYnVm
ZmVyLg0KPiANCj4gQnV0LCB0aGlzIGZ1bmN0aW9uIHNldHMgWFNUQVRFX0JWIGJpdHMgaW4gdGhl
IGJ1ZmZlci4gVGhhdCBkb2VzIG5vdCANCj4gKmluaXRpYWxpemUqIHRoZSBzdGF0ZSwgcmlnaHQ/
DQoNCk5vLCBpdCBkb2Vzbid0IGFjdHVhbGx5IHdyaXRlIG91dCB0aGUgaW5pdCBzdGF0ZSB0byB0
aGUgYnVmZmVyLg0KDQo+IA0KPiA+ICsgKg0KPiA+ICsgKiBnZXRfeHNhdmVfYWRkcigpIHdpbGwg
cmV0dXJuIE5VTEwgaWYgdGhlIGZlYXR1cmUgYml0IGlzDQo+ID4gKyAqIG5vdCBwcmVzZW50IGlu
IHRoZSBoZWFkZXIuIFRoaXMgZnVuY3Rpb24gd2lsbCBtYWtlIGl0IHNvDQo+ID4gKyAqIHRoZSB4
ZmVhdHVyZSBidWZmZXIgYWRkcmVzcyBpcyByZWFkeSB0byBiZSByZXRyaWV2ZWQgYnkNCj4gPiAr
ICogZ2V0X3hzYXZlX2FkZHIoKS4NCj4gDQo+IExvb2tzIGxpa2UgdGhpcyBpcyB1c2VkIGluIHRo
ZSBuZXh0IHBhdGNoIHRvIGhlbHAgcHRyYWNlcigpLg0KPiANCj4gV2UgaGF2ZSB0aGUgc3RhdGUg
Y29weSBmdW5jdGlvbiAtLSBjb3B5X3VhYmlfdG9feHN0YXRlKCkgdGhhdA0KPiByZXRyaWV2ZXMg
DQo+IHRoZSBhZGRyZXNzIHVzaW5nIF9fcmF3X3hzYXZlX2FkZHIoKSBpbnN0ZWFkIG9mIGdldF94
c2F2ZV9hZGRyKCksDQo+IGNvcGllcyANCj4gdGhlIHN0YXRlLCBhbmQgdGhlbiB1cGRhdGVzIFhT
VEFURV9CVi4NCj4gDQo+IF9fcmF3X3hzYXZlX2FkZHIoKSBhbHNvIGVuc3VyZXMgd2hldGhlciB0
aGUgc3RhdGUgaXMgaW4gdGhlDQo+IGNvbXBhY3RlZCANCj4gZm9ybWF0IG9yIG5vdC4gSSB0aGlu
ayB5b3UgY2FuIHVzZSBpdC4NCj4gDQo+IEFsc28sIEknbSBjdXJpb3VzIGFib3V0IHRoZSByZWFz
b24gd2h5IHlvdSB3YW50IHRvIHVwZGF0ZSBYU1RBVEVfQlYgDQo+IGZpcnN0IHdpdGggdGhpcyBu
ZXcgaGVscGVyLg0KPiANCj4gT3ZlcmFsbCwgSSdtIG5vdCBzdXJlIHRoZXNlIG5ldyBoZWxwZXJz
IGFyZSBuZWNlc3NhcnkuDQoNClRob21hcyBoYWQgZXhwZXJpbWVudGVkIHdpdGggdGhpcyBvcHRp
bWl6YXRpb24gd2hlcmUgaW5pdCBzdGF0ZQ0KZmVhdHVyZXMgd2VyZW4ndCBzYXZlZDoNCmh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMjA0MDQxMDM3NDEuODA5MDI1OTM1QGxpbnV0cm9u
aXguZGUvDQoNCkl0IG1hZGUgbWUgdGhpbmsgbm9uLWZwdSBjb2RlIHNob3VsZCBub3QgYXNzdW1l
IHRoaW5ncyBhYm91dCB0aGUgc3RhdGUNCm9mIHRoZSBidWZmZXIsIGFzIEZQVSBjb2RlIG1pZ2h0
IGhhdmUgdG8gbW92ZSB0aGluZ3Mgd2hlbiBpbml0aW5nIHRoZW0uDQpTbyB0aGUgb3BlcmF0aW9u
IGlzIHdvcnRoIGNlbnRyYWxpemluZyBpbiBhIGhlbHBlci4gSSB0aGluayB5b3UgYXJlDQpyaWdo
dCwgdG9kYXkgaXQgaXMgbm90IGRvaW5nIG11Y2ggYW5kIGNvdWxkIGJlIG9wZW4gY29kZWQuIEkg
Z3Vlc3MgdGhlDQpxdWVzdGlvbiBpcywgc2hvdWxkIGl0IGJlIG9wZW4gY29kZWQgb3IgY2VudHJh
bGl6ZWQ/IEknbSBmaW5lIGVpdGhlcg0Kd2F5Lg0K
