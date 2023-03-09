Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0CC6B2B86
	for <lists+linux-arch@lfdr.de>; Thu,  9 Mar 2023 18:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjCIRFM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Mar 2023 12:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjCIREv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Mar 2023 12:04:51 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0662520697;
        Thu,  9 Mar 2023 09:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678381201; x=1709917201;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kiNCEiXo/0pWOCFi3CO0QC5BIGZsL2qbcVpK2tFCz6k=;
  b=dSnQ+WCa32mYgemXWljU1F5h93X13ySJ6JNXokD6qBDRogRTXgreRdUW
   orGWFotgWQk691QIT0dBFI079Pz58V5TXa7sYoC8EoOPMEhYKJUS/iIk5
   igtBj0eeqgVajgvqF0ql9HQDcZ0+hcPh3t3D/X5tt4MWmRdDhFrxJADb8
   uqwaeVvqqtPyyO++rvw5XyB37Q311+UVtlB39x7FUhRM8xbzt9J8k4PAR
   50yV9oN/9dmD4NZa0hQEp55oNSkEZA3Lgr7CcsUrjDaG8YJKWVOeLS8TJ
   ZSE52yh0txiYJTpPPMqNdl7oca7Ai6MXhllmoZ/TiRVTshM1jP0mhcT/B
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="399092226"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="399092226"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 09:00:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="707683965"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="707683965"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 09 Mar 2023 08:59:56 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 9 Mar 2023 08:59:55 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 9 Mar 2023 08:59:55 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 9 Mar 2023 08:59:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXyi8/EvDcI8K9FFh/M/1WmDgxcyIC+A/BSRxA0w+lTwdKexY9W0mdbE0/eG62o3d7196k6sVw7eQ0o3PRGfDvUNmAKXvdsoxUbfO9mirU4hMhjhGrsRGJTCvvSnXjzj2DXqFDpiKK3fNWK/ZrxcYboO85uyjrl2X//LhpFG1j7JYV9kfempYFVZCdO+jKJorxbGNthN/eNULxHenMll0ILnnlScffHNTfa4qyBoIpTpZa5z788GEtlWseQgjRyxaajUVM6U9H/iP3ciQCHFSMD8rechdZ8kbpis8I3Jdy2Py2hxWensmdINm60Tjan0UWItY+E15k6g9syIk2K6Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kiNCEiXo/0pWOCFi3CO0QC5BIGZsL2qbcVpK2tFCz6k=;
 b=Lnr3W82W8NbzLIrmnGwFEQWus9Wj1VNbsUrUCvmpTE22QsZG88PQtaiLt3IjZlXlmF6ebloMAfat+k3C9kBZfmmceqhii60wYiNXEjMPW1ol+Bt1X69BpbCFsQwMrMEVd3J/jwAkWeHE1epdpQIBfP2FHLNfshvW567K2K0nhI0e67SXc7UnpGR3YchD+JTiE/0QFOjHvUPDaxEhcF6w8gDhhBRDgZbleyaLoEJJ1lp9vh0/VYi6d8AmCXum0RQNBRyDas4diO1B+PNmYRykmlUjXnyn18DnM28hRqQCr3NIWeeU6zsabSNG+HXXt191MWXtkxOv1NngMQ0RGm3Sjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM4PR11MB8131.namprd11.prod.outlook.com (2603:10b6:8:190::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Thu, 9 Mar
 2023 16:59:53 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 16:59:53 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v7 30/41] x86/shstk: Handle thread shadow stack
Thread-Topic: [PATCH v7 30/41] x86/shstk: Handle thread shadow stack
Thread-Index: AQHZSvtG+2WnM2cLTkqogSV10ayPpq7xDpwAgABNdwCAATBTgIAALsOA
Date:   Thu, 9 Mar 2023 16:59:52 +0000
Message-ID: <5b0ce47840bf2f6747ebf722053f6b3c1f99bb64.camel@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
         <20230227222957.24501-31-rick.p.edgecombe@intel.com>
         <ZAipCNBCtPA2bcck@zn.tnic>
         <d4d472e2e44787eccfbcc693bdf338370013f8a9.camel@intel.com>
         <ZAnpTYV55gbdROxx@zn.tnic>
In-Reply-To: <ZAnpTYV55gbdROxx@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|DM4PR11MB8131:EE_
x-ms-office365-filtering-correlation-id: 2f746b20-c9db-4cc2-c6ea-08db20bfb3b1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Ezf47acR3pnaBH8aByQy8Yx76Rv6vF/3ELkEntEVTMqSgV26C9+jV1yT/bCtAAlQ1hY9qTYBhiw8ufSOcX2R2dH3zZ3Agc3DEKdHQT1yTliQBPnKfa8jCspnQW9NhvYRRg/OpIIwScWstIhg9rtjmRDWd0Hce97gKJW+eY0Vo8saMD5qip7hnTU8MnF8maENXkG6HI53li96AdfzMNmqZls+ljppcahVM2ag0BHn+wbxhxQF9m48UWPG+eR6yBi3J0Vax7g3Yh85WZTHUunK1I43Ey6s+BEQFjHHTYOa1k52Pep+JnoEXID47Kaf2fvfSXs0j4G81ToMnKq+59bw6r+8sc1OzZd8NwQ+iJXOQylgfXPY24ng5jayPpIWOJuQAU+XW1rA/V35b7RJxww1oiNLjWRUdbrMUJMUrAkY97Iz5ph5M6nVgOWj2xG/SW2Tf35iMVF6HakL+0mLJXCIus2bWv7Lvs0wv0EIoY9obgmdEMYPSIoeojOscfXDRZ4phowAicQaSRFDN6k5bZjYLMmDgWJO9pLa/clcOolRqW4TEOAepADRsLGIa/03cdtTFnpN6h2QoKG+qjuksnhXttAtAfS2GqOK746MBGnjWXAoa4MuL5qjDPz+aGlF7w8mw3xUDD5q+qlW55+5NKvZgUHzu3uhCxV1uoF2UM8YU63Klcv/+9OQ/DiHL3wsIl83bttyw7MsIzJalixP07dekN2VZeS5T8nYJiBD0seGtU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(376002)(39860400002)(366004)(136003)(451199018)(478600001)(5660300002)(7406005)(7416002)(36756003)(86362001)(6506007)(186003)(6512007)(26005)(2906002)(4744005)(2616005)(6486002)(71200400001)(83380400001)(64756008)(66946007)(76116006)(66556008)(66446008)(91956017)(6916009)(4326008)(8676002)(66476007)(82960400001)(122000001)(38100700002)(38070700005)(8936002)(316002)(41300700001)(54906003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUVnVXRCdW10MTBsUS9rajVqc3JYOGhWZk05TWpETTZGNm4yOC9FTVFuVVdv?=
 =?utf-8?B?aUFYcUNQdXdmTnl5L0NidXdGMk9vYlFZK05ZbG9IeCtUdTVWOHJJSHJ3eUZN?=
 =?utf-8?B?dmU3ZitEMGRTU0NKKy9iamxUSlhZWEI0SXVNTVpCbzd6S1ZsWUZMZ21uN05i?=
 =?utf-8?B?Smp5TjhEcHJnQ1hnRUpWWmZRM2RJZjA3V1NRTDU3ZlovUEttWlpIL2hMbW5h?=
 =?utf-8?B?OGEzWWhRVFJPandjOEpHcmUvYVpFQTVTNURLcThRcW8zMFgyYUQ3d3BQY1oz?=
 =?utf-8?B?MDBxc0FwRlpRVy9YQlcwK2pMM0tnamxPVlNCQTNEdHdNbkFYNStqSGdtNitp?=
 =?utf-8?B?OG54MVovcjdycW84bHBnM2l5b2d4WnNGd2lyNWI2RjNZa1RsV3VoV1RFTnlU?=
 =?utf-8?B?cWNON1Zsa1dhcHAxMktMckVveWU1OEhkYnUvWGJlWnZHL1M2enlxMVgxUzhz?=
 =?utf-8?B?bS9WdFJrLzRWRFpBRHlkR24zb2l4VkNOQnRhZFFUUlJhRGhRZDJzWmZLU2Vk?=
 =?utf-8?B?THlLdFg0N0J0QTEzamFGeFF1ckkrMkZKQ3pwNlhFb2MvRWF1L3dhODVNdmto?=
 =?utf-8?B?R2FzbFJhN2lIaTJtTnVaMWdFMWtzNk8vMVFubmRyNWZXOXRKRFY3U1A3dC9T?=
 =?utf-8?B?UGVZQU52K2V0STFwYmZVR3JicEZGaW5XRGIxOXNLZ3EvYmZ0NjI1eVdVbENi?=
 =?utf-8?B?NitQRDJlazJNTEFMalpiWWZWd2FhSXJwYWUySGF0aXM2Zjh3NXVrcURDamVq?=
 =?utf-8?B?bEg0QWlLS09JcVlMSEI4dWtXKzZmd1JjOWV1SjFrbVY4VDdmeFcyT0xVTTJ1?=
 =?utf-8?B?Vnl2ZTl2WUVMek9hazE2ajdpSEZ5NlpJNm5VL1JaM0taWU5qd3hNRFVMU0JX?=
 =?utf-8?B?MDRYcWM0MEVHS0VUNHNVZUlJOGs2R2pYWnJjV0NqbXFwU3JlMGt4aE1ER2Rz?=
 =?utf-8?B?NHMvcXZ6cjFPVGNOdm5BdUNLUkk1alY5VTlGL3NZbldZT3VUMU5MQUxLbVJN?=
 =?utf-8?B?QkZzZGwwaFpVZElYanh5STVWVTNMaGVONFQ1Kzl5aElicVJQYWRYRmlncXpl?=
 =?utf-8?B?RXB2REErVEZwS0tQSk0xV3oxM3l0SzE2dnVuV25mN25mc3Q5ZTZIbHhhemZ3?=
 =?utf-8?B?NERHL3dTek9BQXM2dGFtNm1MRi83WEIzMHVMdFoyZjZmOWJXT1orMXkyZ1lo?=
 =?utf-8?B?bG9Gbm1qSklSeEFFUkRvLzVYOVVnMmV1ZTU0Q25SWGR5eFI1MUhrOXlHS2h6?=
 =?utf-8?B?S2Vmckpkb1dWQ2U2RE9pNUZGNE5PRnJqOThkTnJQd3RMcEk3aEZtV1BWby9V?=
 =?utf-8?B?ZFEwTVA1elphVE85QTVLYnhyZTZkN0tRMjZ5MUIyVENCajkweU1oU29CZUtK?=
 =?utf-8?B?dUpycG90SmU2NVJnT011VjE4RmhVODI2TDJWVVJIdkNHcmJkQ1ZFeHNuRHRa?=
 =?utf-8?B?QjhIS1Q0QVNqdkY5MDR0NWlJdDBzWjZhaGtGNHVQTjZid2FlcWFXeXpZdTJ0?=
 =?utf-8?B?RnFnL094SFVuREh5MHl5R2xadEJ1aGdxbnMrbFhxUVFVNUhQZHdRQlRLQnZQ?=
 =?utf-8?B?TGdOZHJWOTQvZG5hcmZYSS8yYnhLNEVweE96OWRhd1pVb3ZkaGxjT3lQY0Vq?=
 =?utf-8?B?Qy9ESWo0WUNkSU5aeGI5ZTJxSjRSdDBXbEM0RTc4YVNWc3lOZmxxUmdQR21i?=
 =?utf-8?B?SWU2TkpXSERPQnc4dTJIeU84N1psV0E4SDVjOXRrZmY5N2pPa2ZMTCt3N0Q4?=
 =?utf-8?B?SHV4ZkJ3MXNEQklEUHNEWGUyNVBwaEJRWmhxRXRxMFZXeFNRanZhWmdKdmhT?=
 =?utf-8?B?RS9MUm9teUVWaERUSmJvSS9EZFl3ZjY1bG1pV0NTU25rWWVQV0c4aUlEV0xm?=
 =?utf-8?B?K0VYb0xiTmRhMDNUNlZPVy9RcEsydkdLek4xYk1sUVYzL0hMeVpZVlAwVE9y?=
 =?utf-8?B?emtzN0ZPRmhmK3RiM0lWK1FiR0pBTXhUSUNVUUV5c3YrMzVHMUFTRjdtM2hG?=
 =?utf-8?B?WTlqZWxWQUpGbU5VRGhDcjBzcGt6Q1V5RG5qTXZTZTlZM2htMnJ3NVh0QjJs?=
 =?utf-8?B?Nmh0RWhnR2FmTFZta0ZZTVBPajAwZlcxSHRMbEExbHhkUVNGL3FKZUIwSmM1?=
 =?utf-8?B?Z1JlWXBoblQrME1rZ1AxWDJhQ05PUWNaZy96UUVUc0pGSkM2U0dsV1hJQTls?=
 =?utf-8?Q?R4UVChJKO13gwdr0ZvzXadI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C07912AC62970A4880D74AF27D17DF16@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f746b20-c9db-4cc2-c6ea-08db20bfb3b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 16:59:52.8359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0um2wCXDN64HV5LuaKtasT/SkwCsHfObt0JPhBVXfj+oYZs4YB2e6fCFfEy2X1VIv8LcyO3YyxANS/tThQ6ZymVhZrIBPiFG15X6I0zNLK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8131
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVGh1LCAyMDIzLTAzLTA5IGF0IDE1OjEyICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFdlZCwgTWFyIDA4LCAyMDIzIGF0IDA4OjAzOjE3UE0gKzAwMDAsIEVkZ2Vjb21iZSwg
UmljayBQIHdyb3RlOg0KPiANCj4gQnR3LA0KPiANCj4gcGxzIHRyeSB0byB0cmltIHlvdXIgcmVw
bGllcyBhcyBJIG5lZWQgb3Qgc2Nyb2xsIHRocm91Z2ggcGFnZXMgb2YNCj4gcXVvdGVkDQo+IHRl
eHQgdG8gZmluZCB0aGUgcmVzcG9uc2UuDQoNClN1cmUgc29ycnkuDQoNCg0KWy4uLl0NCj4gDQo+
ID4gSWYgdGhlIGRlZmF1bHQgU1NQIHZhbHVlIGxvZ2ljIGlzIHRvbyBoaWRkZW4sIHdoYXQgYWJv
dXQgc29tZQ0KPiA+IGNsZWFyZXINCj4gPiBjb2RlIGFuZCBjb21tZW50cywgbGlrZSB0aGlzPw0K
PiANCj4gVGhlIHByb2JsZW0gd2l0aCB0aGlzIGZ1bmN0aW9uIGlzIHRoYXQgaXQgbmVlZHMgdG8g
cmV0dXJuIHRocmVlDQo+IHRoaW5nczoNCj4gDQo+ICogc3VjY2VzczoNCj4gICoqIDANCj4gIG9y
DQo+ICAqKiBzaGFkb3cgc3RhY2sgYWRkcmVzcw0KPiAqIGZhaWx1cmU6IGR1ZSB0byBhbGxvY2F0
aW9uLg0KPiANCj4gSG93IGFib3V0IHRoaXMgYmVsb3cgaW5zdGVhZD8gKHRvdGFsbHkgdW50ZXN0
ZWQgb2ZjKToNCg0KQWgsIEkgc2VlIHdoYXQgeW91IHdlcmUgc2F5aW5nIG5vdy4gSXQgbG9va3Mg
bGlrZSBpdCB3aWxsIHdvcmsgdG8gbWUgaWYNCnlvdSB0aGluayBpdCBpcyBiZXR0ZXIgc3R5bGlz
dGljYWxseS4NCg==
