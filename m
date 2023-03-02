Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507986A8B71
	for <lists+linux-arch@lfdr.de>; Thu,  2 Mar 2023 23:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjCBWFo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Mar 2023 17:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjCBWFj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2023 17:05:39 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C782D83D1;
        Thu,  2 Mar 2023 14:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677794732; x=1709330732;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FSkgkT0p10dUpv9YBplcab3rhndlaoIkSpMYTXA7tcE=;
  b=DXCAPgIqVwRsFVRKDNognwL/whz+LKCoQrfECWvVtXaPx6ZShDBEzFYr
   zBW61l1YTyTeLgD5dy19rc1FcLOaUmTzGAqGEwKxV7nM0afYRUZ/2uHtB
   IWCl4ZwzMGG+Ms9cl7vwR11J76JmTmmswOXUk9rAe3rD/1ogXK2DL4ZcI
   NC4sPU6pDP4tIkZ1T92RcVFrYo1QdefUGYA3LrTJHFLZsk4Wuu5/VvjaN
   S2w4NsGdBC38p++KiIlPaKzK5S/65esOiuG6Gnd/BoWiQyArZcjP3GoPk
   2L4jhzd9rzZmfcuRACavxVPWQ1bC7WzuPopeUj70qJ7SsyeSyMIms2qBX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="397449474"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="397449474"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 13:21:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="798990370"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="798990370"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 02 Mar 2023 13:21:21 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 13:21:21 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 13:21:20 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 13:21:20 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 2 Mar 2023 13:21:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SteMOUbPpf2OQ/0xgl+BclePTFTOtd0moZwBcJQbYU8c3Cqs2LTf6yP1a03ILTdh5cs+a3EqJVKHCG9EtFRBo66sFUM9NI00p0t54IoInuXHWOu+kZWcTrFOQza4meN7dUwGxLG7QH+YxIgQ0YX4xvNQz4OB++OohWcwzJ1+wPyqw1zFsb3NjZZwe/C5xUX4urNFkdznqA6eVV9V+dPmael17IWLeBonizuujJLrLSJrlBa6Bw5n+TjXTB6bYlR7WNW4VLUPNbmPj1F4R1+iD80gs8x2Bu6wKvIK1Qp4q6oNSjUmw8DT5vsFFPFqt/04Ph9qFRu62wzIG5tCKqngqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSkgkT0p10dUpv9YBplcab3rhndlaoIkSpMYTXA7tcE=;
 b=AatXwns05xBXZctm8ExK8Ge1IZhGVOiMWtNkyWpjQTQaz4+BVBBpv2dBjLeSnOpMJDFn6WvGEjroZawew5gbc0of7mI8vxmGRT822T5t/q7RB1eGt0Qs30pFGmByr8rtBzCHVAr+vn7kuAR497uybX5qwZQvdrhStbv41aMkiVWWttkMNYXaL3Dx6qR/TFJYBnOILWIpUnBjmx2jRVOdBzedQQgejDoNHakphXb8dissc9O/bbLbrG7UR29xAwAwa434vYPn1uxnDEUCOkbNyzz6F79s/gVrT986KNAFu4hi7baY9uQAYQcLSPxw0KR1u8VWxsI82Pmyz/rHy0Bn0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CY5PR11MB6461.namprd11.prod.outlook.com (2603:10b6:930:33::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Thu, 2 Mar
 2023 21:21:17 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 21:21:17 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
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
CC:     "nd@arm.com" <nd@arm.com>, "al.grant@arm.com" <al.grant@arm.com>
Subject: Re: [PATCH v7 33/41] x86/shstk: Introduce map_shadow_stack syscall
Thread-Topic: [PATCH v7 33/41] x86/shstk: Introduce map_shadow_stack syscall
Thread-Index: AQHZSvtF2ujwSwjQQE2i7wvNH++zdK7nwRCAgABC0IA=
Date:   Thu, 2 Mar 2023 21:21:16 +0000
Message-ID: <0b17d8ecd50e6a25ef2ebff2b09f25c8cf7a98a0.camel@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
         <20230227222957.24501-34-rick.p.edgecombe@intel.com>
         <ZADbP7HvyPHuwUY9@arm.com>
In-Reply-To: <ZADbP7HvyPHuwUY9@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|CY5PR11MB6461:EE_
x-ms-office365-filtering-correlation-id: 202202a8-b2a8-4ba8-40d7-08db1b640f52
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nHk2gdhTj/JtbGl5ZICidaf/gAIYk3zYR1FEd6cdjEz+b9sCxDkALgIzNp/cDo9fKkd/ghDbyhVFXJPl10oU7V/XqdIbAMbrvYdeoC0Yh4V3c1ms/QHsDAANkH2R9IO99h0EyhQnZwdfoVR/d1QSPmR+pn3+XDdB5CgtzjkZ7KXnCcC0RSI8/WY4nx+HG5AmpCDGPBRmQrArLKGnzgtP7S+82VT5C3iCttT12z28QNtQB74vLd1L8iNKsOdSZ8b6etpOCeXp7Vs1DIN/eOSrIgRIYkZ05NkuxDibl1m9dXjLEb1DsIuIcCKzJEaIcYBknTHVw41vTqyY9aFeCPRYZskWb500GolDhP+q45L7Vo7AsOxSozEBWv6zFa9s4HYcXK59RG4gSwZchKP5r730gGAhd+EDDj+XLnRf31Ogfzhbs1bXXUSngkcn57fqnf2lezGd5VpwcfbVExwWBP29YZziS28Uzyt8uggtVtk52JYZWL8+nx+zcB2hYLjq16UO+s1tt1TfPl9QG1yJHl81OVs15yMVOqOnExob/X5hPc4UUgd4196VC5m74CYvGHolKERALO8AxzuTmXVPnm4zY7k0jJH9ofcb/qGrKulHQPmrRvpUBr3s9k84Ka3j3XkHOA+6wLKQ1cM28NNNzCjra7WjqTt3jT+4sjUFHSZSE1FPvFiqq0TK6sqloXWBfw59Jjyo9oJ3H2wUV51PTKorqlCPmpPrq47Vf9DXw6vXjvU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(366004)(39860400002)(136003)(376002)(451199018)(66946007)(82960400001)(122000001)(38070700005)(41300700001)(36756003)(76116006)(71200400001)(26005)(6506007)(921005)(186003)(86362001)(966005)(110136005)(54906003)(6486002)(6512007)(38100700002)(91956017)(8936002)(316002)(8676002)(478600001)(4326008)(64756008)(66556008)(7416002)(7406005)(66446008)(2906002)(66476007)(83380400001)(5660300002)(2616005)(66899018)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEl2MFlDMmlrTTJwb0ZoRXRLS3o0SHB5aHZ1MUJVdm51NkZ5aTNxWWVXVGVH?=
 =?utf-8?B?TDBpR3I5U045aXRlMDZjaVRRR3NkSlNYbXRDbjRCajduUkhRb2gxTE9aVUJ5?=
 =?utf-8?B?bTdBVVhwdVZma2tSdm4zVjRyUm5vdzVvNVVlN1F6Rm4zbzBBbGRTa25KbnMy?=
 =?utf-8?B?dUpFRDhQcXF5YTVCNXFacjJnMnJBUXBjckhIbzVTMzJPT0ROKzdrSG13U1o3?=
 =?utf-8?B?S0oxNFVteFlpWjZyUkVYbUY3ZmhzZzM4cDNhbDBOZWcrempHL0FNbUpXWE43?=
 =?utf-8?B?THAwNGtYb1ZvVTFkNzNRK3NFR2oxaWgrZWJncVBkUzNxWGNEQjNPUGhCc0FV?=
 =?utf-8?B?T2xKOW1IRWZrZE92RlJSLzF1K0pLdmdXeGFuNHY1cWxDdVdoRHVnQ1NSUENx?=
 =?utf-8?B?SEZWS2hTZ2VJajBPSFQ3dWlRTTJQTktyZVVUSWlhdG5lN3NxbW1OMU5CcUs4?=
 =?utf-8?B?dHZiM29INUdPOVBuN0hadmhCQ1V1aytzTHBQUlpteHU1THk3RERYOXFSOVFH?=
 =?utf-8?B?cVR6QUUxT1Jtd215T3NiR3RGaG1RMFJvTXZobmtPc1NsdGFKeWpMbE9UU2Qr?=
 =?utf-8?B?TUtOZThwNzVtOFM0dXlpOEo5Z3RYakRzKzRMUHdPMkNsMytML0tNM0hlU2pn?=
 =?utf-8?B?RTVwWWJVdkJoNVFERjZJOWdDNnJWSWVmT0kyMk5qYTcyZjFkY01EWDhHQ3p6?=
 =?utf-8?B?OGJNdGNJZlpPd3dpV0JaZFFRZ1QwTHlXeExYTnhzKzZPSWdRUkpBNlRhT3hH?=
 =?utf-8?B?TUp0YTNlY0N2SHNJM1hMT1NYUGRuQ05PZ1ZRb090YVI1TVBjSlkrYzMzT2Jk?=
 =?utf-8?B?dkwyU3MvM1JxdFhuYlBvNVRhYnhUYWVXdGpQQUduOHRyTjB3VW45elFXZWp4?=
 =?utf-8?B?M0liTmloUjN1MGNnQXVvelNXUzF4Y2o5dG9OaCtzaHFkSVpkWHRVWHhUNTdC?=
 =?utf-8?B?RDAyVzF6UFkrU0J2ZmZaKzkyQ3VremhkQTRYbmZpYnpyKzZXdzhKY2FWM291?=
 =?utf-8?B?M1ozU3hNeGVQWHBaQVo5U09BUkVxYWo0TklBUVB5Y3ZmUXg5MUFkWWdQVk8z?=
 =?utf-8?B?bGQ4d2p5ZnF5bWZ5cnU5Zk9LTEJPUWxaQWE1bFpNMGwzRGY0TDBtN3IvRUJS?=
 =?utf-8?B?TVRycVBrZ2dObnc0RnM5WXRGbUQ0NGJ1U09yQS9wU0lhTmQ3eTZSc3BYTGhi?=
 =?utf-8?B?clB1aUZJWWljUWhyS0lDRzZPbnpwcUNUQU03ZzBGc0FjNzFjdFpnOE50TEhX?=
 =?utf-8?B?NVJGcGNmNlVyWVo1aEoweG05cU13dVVkWWdjQlhwZzVsT0g4TDU3MzNaUk9T?=
 =?utf-8?B?a01LdjJiNWh6Yzhuc2pYZXB3RDZaOUxUK1QvS0VaZFhzbVAzN0diaThlOWRD?=
 =?utf-8?B?UkhGMCt5SWVJTkpPRDFFMCtvblFKRDNrQnlRRnJLbENjd3JTUDNZK0I1QXlL?=
 =?utf-8?B?eUp0NzlrdlVrWHU3bCtpNXpBNVZyZHcyREZMbFhLL3l4TGFZbjF0OUNZWDNS?=
 =?utf-8?B?RHM0RnhuR0ZxRGF4Tm15VW5Vc3dHV0xidlQzWko1dDdTVTRwMTFQZ2g3d050?=
 =?utf-8?B?cUhCQXBDdUI2UmhUOFBhN1hWanFUSncwRE9WQ0RYTDRNOE9HeUhIcVN1Wmtn?=
 =?utf-8?B?SllLSVpIdGZMNEhOTTh1YnFwN2NXbHpqck9yODZWRVFkdUJtdEZ5OWJpU3JR?=
 =?utf-8?B?RzRhd1AzMFRqUUdyUzNMdWxkZkgyK2dkTFRUaUpVYm1BOUZxdXhNY003cFhs?=
 =?utf-8?B?dzR0SC9WOGREWW5tQ3BPeXZtVDNLZjdqb3BYNGtzZUkveGVmZkpQN3h5eHhh?=
 =?utf-8?B?QUhwSzlHUkd5UU9zdEhuRWt5cCtEYzNEcC9lUWF6azJvSDlReWhBZVRzNlVE?=
 =?utf-8?B?cnhqRTI0UGF5K2hIbDJkMVlLT2xiUFBPTStMYVZLNVF5aDNwUDRhaWNFbkl0?=
 =?utf-8?B?djAyVUl6Yk11eVRoL2NxN0h2RC9iM3FQWjE3dlU0T1BpUi9ycVpDeFNVT1Vv?=
 =?utf-8?B?UTVqMHYza2ZTc2NTMndkYVJaQTcxbGExb1N5cnFZaEZTNnN1RGtTS25STkcv?=
 =?utf-8?B?WE10eXRhTW5NSkJ6aW9HS29VOGVsU3FCQXFNQVFaOWpsNGROa1lvVDVoSFRB?=
 =?utf-8?B?cEhRR3ZhdVVnUzl4QzJpQzEyaFBoR0hxazB1cmFUL0Q4WlNQTFhGNXZhMWZ1?=
 =?utf-8?Q?akntk6UwsZoo7SUcersUXII=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B95842B4564E4A46987F5CEE1A7CEBE0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 202202a8-b2a8-4ba8-40d7-08db1b640f52
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 21:21:17.0160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dc/naEYz7sJh/llwMm/1LqfBCnwH8Mgx0e+rzaLbRB/naB6SgHJyi7+pFXij/OfE1ZsUlxlBBd8lQaxtN9eFyioA0NNPM5IWy+x84L8fkGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6461
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVGh1LCAyMDIzLTAzLTAyIGF0IDE3OjIyICswMDAwLCBTemFib2xjcyBOYWd5IHdyb3RlOg0K
PiBUaGUgMDIvMjcvMjAyMyAxNDoyOSwgUmljayBFZGdlY29tYmUgd3JvdGU6DQo+ID4gUHJldmlv
dXNseSwgYSBuZXcgUFJPVF9TSEFET1dfU1RBQ0sgd2FzIGF0dGVtcHRlZCwNCj4gDQo+IC4uLg0K
PiA+IFNvIHJhdGhlciB0aGFuIHJlcHVycG9zZSB0d28gZXhpc3Rpbmcgc3lzY2FsbHMgKG1tYXAs
IG1hZHZpc2UpIHRoYXQNCj4gPiBkb24ndA0KPiA+IHF1aXRlIGZpdCwganVzdCBpbXBsZW1lbnQg
YSBuZXcgbWFwX3NoYWRvd19zdGFjayBzeXNjYWxsIHRvIGFsbG93DQo+ID4gdXNlcnNwYWNlIHRv
IG1hcCBhbmQgc2V0dXAgbmV3IHNoYWRvdyBzdGFja3MgaW4gb25lIHN0ZXAuIFdoaWxlDQo+ID4g
dWNvbnRleHQNCj4gPiBpcyB0aGUgcHJpbWFyeSBtb3RpdmF0b3IsIHVzZXJzcGFjZSBtYXkgaGF2
ZSBvdGhlciB1bmZvcmVzZWVuDQo+ID4gcmVhc29ucyB0bw0KPiA+IHNldHVwIGl0J3Mgb3duIHNo
YWRvdyBzdGFja3MgdXNpbmcgdGhlIFdSU1MgaW5zdHJ1Y3Rpb24uIFRvd2FyZHMNCj4gPiB0aGlz
DQo+ID4gcHJvdmlkZSBhIGZsYWcgc28gdGhhdCBzdGFja3MgY2FuIGJlIG9wdGlvbmFsbHkgc2V0
dXAgc2VjdXJlbHkgZm9yDQo+ID4gdGhlDQo+ID4gY29tbW9uIGNhc2Ugb2YgdWNvbnRleHQgd2l0
aG91dCBlbmFibGluZyBXUlNTLiBPciBwb3RlbnRpYWxseSBoYXZlDQo+ID4gdGhlDQo+ID4ga2Vy
bmVsIHNldCB1cCB0aGUgc2hhZG93IHN0YWNrIGluIHNvbWUgbmV3IHdheS4NCj4gDQo+IC4uLg0K
PiA+IFRoZSBmb2xsb3dpbmcgZXhhbXBsZSBkZW1vbnN0cmF0ZXMgaG93IHRvIGNyZWF0ZSBhIG5l
dyBzaGFkb3cgc3RhY2sNCj4gPiB3aXRoDQo+ID4gbWFwX3NoYWRvd19zdGFjazoNCj4gPiB2b2lk
ICpzaHN0ayA9IG1hcF9zaGFkb3dfc3RhY2soYWRkciwgc3RhY2tfc2l6ZSwNCj4gPiBTSEFET1df
U1RBQ0tfU0VUX1RPS0VOKTsNCj4gDQo+IGkgdGhpbmsNCj4gDQo+IG1tYXAoYWRkciwgc2l6ZSwg
UFJPVF9SRUFELCBNQVBfQU5PTnxNQVBfU0hBRE9XX1NUQUNLLCAtMSwgMCk7DQo+IA0KPiBjb3Vs
ZCBkbyB0aGUgc2FtZSB3aXRoIGxlc3MgZGlzcnVwdGlvbiB0byB1c2VycyAobmV3IHN5c2NhbGxz
DQo+IGFyZSBoYXJkZXIgdG8gZGVhbCB3aXRoIHRoYW4gbmV3IGZsYWdzKS4gaXQgd291bGQgZG8g
dGhlDQo+IGd1YXJkIHBhZ2UgYW5kIGluaXRpYWwgdG9rZW4gc2V0dXAgdG9vICh0aGVyZSBpcyBu
byBmbGFnIGZvcg0KPiBpdCBidXQgY291bGQgYmUgc3F1ZWV6ZWQgaW4pLg0KPiANCj4gbW9zdCBv
ZiB0aGUgbW1hcCBmZWF0dXJlcyBuZWVkIG5vdCBiZSBhdmFpbGFibGUgKEVJTlZBTCkgd2hlbg0K
PiBNQVBfU0hBRE9XX1NUQUNLIGlzIHNwZWNpZmllZC4NCj4gDQo+IHRoZSBtYWluIGRyYXdiYWNr
IGlzIHJ1bm5pbmcgb3V0IG9mIG1tYXAgZmxhZ3Mgc28gZXh0ZW5zaW9uDQo+IGlzIGxpbWl0ZWQu
IChidXQgdGhlIG5ldyBzeXNjYWxsIGhhcyBsaW1pdGF0aW9ucyB0b28pLg0KDQpEZWVwYWsgR3Vw
dGEgKHdvcmtpbmcgb24gcmlzY3Ygc2hhZG93IHN0YWNrKSBhc2tlZCBzb21ldGhpbmcgc2ltaWxh
ci4NCkNhbiB5b3Ugc2VlIGlmIHRoaXMgdGhyZWFkIGFuc3dlcnMgeW91ciBxdWVzdGlvbnM/DQoN
Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMzAyMjMwMDAzNDAuR0I5NDU5NjZAZGVi
dWcuYmEucml2b3NpbmMuY29tLw0K
