Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9B569E8BC
	for <lists+linux-arch@lfdr.de>; Tue, 21 Feb 2023 21:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjBUUCT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Feb 2023 15:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjBUUCR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Feb 2023 15:02:17 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A642A15A;
        Tue, 21 Feb 2023 12:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677009735; x=1708545735;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0thRPCGrhL6e6XwRpkUCjU+rXJgQuoNk1Qw+93DKzAo=;
  b=BI9LhNZc39q0tkq7mClih6CqriTzf3BeJd5IWxKZ3/e2qqVM/o5pdVSq
   Qo8DIN1YNAGUsLRcAuFBtOK90kpPMHR9i4xwfwV7isYsXyur7D00EM//9
   dcFsf8mY59b6h3tS2sY1Od4QYClxfWrcPc0lDzIQtYf5iFYqWqpyCKhWR
   Ud7qZthYc1dbnJSdxLQLp54kdIFJEwJP7NLDjYodgNoh7K8FWbcgzhFQp
   BEA2kAwwSzuzRyBPDKyTFL3bkzZYPeje1kvsyQa8btwl13iydojwnzjuB
   Gdi8WNOQ/iCRC/OEwXrrS0Q0ezFTkjRhxkd0dtpKMHDGjf+L37yFCaUh5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="334099099"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="334099099"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 12:02:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="760680309"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="760680309"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Feb 2023 12:02:13 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 12:02:12 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 21 Feb 2023 12:02:12 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 21 Feb 2023 12:02:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fH9MudZkGCxgYfeRYEADSpIWHw4tbSrfidviJozE8J8gi7E9bIrpLxwjPKr4lngJccFc814xOf0SCAiEuhuzXnkV5cBOQNFfzbT1OAd28eZrPKgA+rf89DlyYx62bOVdUujiFwCFmPp43daJDPpPzw+YK2vHj8vOOWRGzPL28dirGZSkRGmPllMn2SZPnGUaRUOdQiBKzjRkMBitw64VYykSY5Y1DRQ07LDZEG9bPMA+2pppZyELtTlDtAELTJkoG5DFyR4/OmtTl8ren25yypiYqmeXnLj4qamDFg8F+j/T//gztU2eTSsIfQ4uG4ieWKEYNvmEBaWGg6Z+fBAhFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0thRPCGrhL6e6XwRpkUCjU+rXJgQuoNk1Qw+93DKzAo=;
 b=E5AbMe9V474AxyjvUjOya1uVH8663w3EvcHGC3NPFELGKn2enfllr2pnRbjUibdlX9Gx+fvOK/P8HledDHSfwzK8tzZy8m/FROglTBqtQJwPvO9ss4hkLSLbAWAuMN38P2gJHFuoIYWjpzYs79a/LcbLeNVRLZhD1uBgIITDkEpwDcJ51VSJRpY2q8EajWp2YAlOoW9uOWD2O01RzDBLzVwwHX6t0UCAtSFDNjqgGKdDqS7zNiWO8IbJC/bQ/sw7lOHz5520uzWKgXjbKKtxqPARnaCR1ItJ+rHy6MTEin2SKQq2Pu6zH1qxhOzSvZozE776kgsvzH+HLUIeFAMfmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MW4PR11MB7164.namprd11.prod.outlook.com (2603:10b6:303:212::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 20:02:03 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 20:02:03 +0000
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
Subject: Re: [PATCH v6 37/41] selftests/x86: Add shadow stack test
Thread-Topic: [PATCH v6 37/41] selftests/x86: Add shadow stack test
Thread-Index: AQHZQ95ICJxsx2cypUapk1OQ308pxa7ZGsOAgAC8OYA=
Date:   Tue, 21 Feb 2023 20:02:02 +0000
Message-ID: <f61f4a54539c24cd108dbace89e6bc059e896937.camel@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
         <20230218211433.26859-38-rick.p.edgecombe@intel.com>
         <bed841c6-5b37-6c91-81c7-5c06788d38c4@redhat.com>
In-Reply-To: <bed841c6-5b37-6c91-81c7-5c06788d38c4@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MW4PR11MB7164:EE_
x-ms-office365-filtering-correlation-id: 82d6525e-9de9-4a48-c948-08db14467fcf
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NE2rAd1+sntMzirlwqk8fKfbNBpRB8nirLBfcANPxDsHRpWruMY9gi21KUF7M2W0UlT5dbs0zl+OrpgfBr0scQjY8QCx65SZ8QLrquPHsyBDSrChdfDykWsEOSqOa8lei8QkV4H5gR5atHKPGiaPRI27pgyrHEF9+0jr4iH0GcEwcvDK91gSkaDDCikHXgjjNmC5fUbU0VxI/pFtgXYuJmUxVRbPaocx7UkjtwGw7G+ikN+AYKwAvTeBEpJvGwiHGsQ8T17/Soh/L2LFt9gccIBrveTxkZkUt6nFosGqaMbvd2RQwsQxkE98Ze4SWrikYm1CpjlOS5fr7+KacXL6oTFu7b0t773WbMEy8d3Qg41pdElbiqyEYjZL6mjm2RpFO7gxQiArs9Pdf6jJvh3EXmz+iHkq4c7mbanAbYmOmUygQ7JqapTuxTeMd1a0157JQVNrO1UccsYESLRoX2T1IcQb5Rhq8MAoN0XdawJBkW+U63bnLVlhrCqm/5UXx73IkZlJbh5raas5h0PrhcIUghay90PiA6k5C3bNsN2bUjIBhlDlmNQOItn8wCwnrBLcp+W36f29tHBQRVi2oBg7nbzTO+u4Ldw8/Vs9TjC8kS0bSCKvlcAVEeOS/8X5OMZ38JnBq0jxLV+5AdiUmAPv9hakmoJ/tL6yes2kdyzKA58Fp9jOXdQkeRaSFutozBfQbDTwmde48oet9bK8C/wo3MHHA4r1SxFBmI7K9DoKzJ97Fn9to/gcthQ7Xl1qEGiy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199018)(83380400001)(8936002)(7416002)(7406005)(122000001)(71200400001)(26005)(186003)(53546011)(5660300002)(38100700002)(36756003)(38070700005)(2906002)(86362001)(6512007)(91956017)(2616005)(41300700001)(64756008)(76116006)(8676002)(66476007)(66446008)(66556008)(66946007)(82960400001)(316002)(110136005)(921005)(6506007)(6486002)(4326008)(478600001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azYrYXJjS2E3MzFNNjRpdkRmVXloMHZjSVpNVE1ZUjVNSGhZUzlWZ29sblcx?=
 =?utf-8?B?VnlDWVFsQTcwd3NNTTIxREpHVWxxemozY0t0UVN3eklQUGdQblZjZkk1Y01F?=
 =?utf-8?B?L0ErVVliMWRJeXpLYk1Jd3F5MFI0L0dDZk5UUkhWQWVrTDJ5M1VyQXg3MTJH?=
 =?utf-8?B?ODNjaEZQT2h3cFZqSFdNdlNuSUVlL1hGWTdteStvT2pvOFZPMGlqTXh2dTRY?=
 =?utf-8?B?V0hhUXNXZ0JQVDlOMnM1WE1LNTg3NU9kcEYvbVYvcWZZYm9wODZ6ZHZqNEFj?=
 =?utf-8?B?ZWlFWXZLdHkvb1VZS0dsQWlKbXJqTEJNOG1CWXZ6dlA4Z2cxNFlmN21zNFMw?=
 =?utf-8?B?Tk9rcXVGTythTGhXVDZyeVFCQXU5ZnBsRmJnV1FIdEh3ZC94RnZDeE0vZVVI?=
 =?utf-8?B?by82ZWhaeXN6ZDJSVGhOMndBTmw0SDl6aFh0dk9hYXpMZjZ2Y1ZhZWxUb0ll?=
 =?utf-8?B?ZXU0YksyWG85SlVZZjdKaTdiQ3NHZnlQb3drL041NFJQc2lYUm5ZNFdVUG83?=
 =?utf-8?B?NHFuc1BxTUt1UkhmblB6YUlTQVhucEt5bFNQZEljcUNPa2MyMFdEZXgyL25V?=
 =?utf-8?B?UHhQcGYvUnpEeHh0K2lFKzdJZ0lXVlVDM0tWcEt0R2dkcFNsb1pNOW9ZQlBh?=
 =?utf-8?B?SWhVTTVRdDhTYnVmYlRPY0RIWk8veW1xelhPTDlQS2N6VUxSbjdWb3lGZFZS?=
 =?utf-8?B?L3JmMGxHdVoxT2djY1kzdTBkL0NMR283OHN3aGtSS1VTbE9jWElacjc5VGFT?=
 =?utf-8?B?YUY1TGhweWhJdWg4bzJKYzdYN0RkbWRXM3ZGSGU2aUgwSXpENk5JQTd4TUtl?=
 =?utf-8?B?U3kzaVpLbFQycGtXRFY4cXlpdlBDQUlNWHFLYTNuZTBTUTRxYU15NG9JTWFl?=
 =?utf-8?B?YTdYNE9PcVh6bzRCc1liQXRGWExhM1E4anl4aG9Va2ZPZXM3UHB6cllqcUVw?=
 =?utf-8?B?eXE4TDdrYi82a2Y4UHZwZGJOcUlOR0luL0lyclJPVVEvcWxheHRsVk1VazBW?=
 =?utf-8?B?N1RMb2lOcCtMcCtnSXNmMVJqTG5oNnZNZGMySUlIeFFmS3dvWkRYeGlGbENz?=
 =?utf-8?B?eVhNT2ZrMDdCN1g2dWdtTFc1NmVrcWJ0WkUwcm16dGZPTUNGZjdhTko5Wktz?=
 =?utf-8?B?b04rL1pRYUFOd2F4QjUzWWZWYWZMMFNOdWthb3ltZEMrenlQYy90bnJuUld4?=
 =?utf-8?B?RTlmUnJ3MWN2cC8rZlJScW1ubkVYaEIxb3NUampxU1hjSHRNMnFhallMVUxl?=
 =?utf-8?B?b3ZaRmE5aFV5RnB2aVFLM1ZyV1oycTkyVDBFTkh6MXlmb3EvZGFhK0wyejhy?=
 =?utf-8?B?SFFWRlNGWS9NSmRvZkJrdFY2Vm05R2t0ekhBVHVlQmV3WnN6U0xyMHA1KzBD?=
 =?utf-8?B?U2V4RmZueSsrekpFVjVHMVVBb2JmMitlR05EOTdQNUVWZmlCbkxKbmxIUk1H?=
 =?utf-8?B?aEdvWkVGS1NKMlJqYzRPMVNnbmovNEV0WnZzU1BVTEZteGwyYWlqVTl4OE0y?=
 =?utf-8?B?cWYwaHIvUVlBbkM5YThmaUdkWXpOVmNHQ0dhQjZodVB3UncxdlkrdFRaWDBx?=
 =?utf-8?B?QXVoeGUrUUhQV3lZM0Q5UGt4ZUtKemxFazA1WkNCYkw1eGo2ekk4VkVxRklv?=
 =?utf-8?B?U2FFOTVuQkJSRnVXOXZpeDRzbHUvSVJPaktxdk9RRWw2Nk13b2VoYUxRWmo1?=
 =?utf-8?B?ZzFaaVdGaXRaR2NIdWdLbFJ5NDZETUovdWhKeHl5ZERsMktCVGpWRDU4bE1y?=
 =?utf-8?B?Vldka0dVTkE0eVRmUWRMaTF2M1UrS0FJcXdVdEJxMG1ERzM2U1AzTVF1cEVu?=
 =?utf-8?B?Z3B2UmxGOTVWVnFjVmJsb1JOZ3RrODBXUmtTS3o2bEpLUVVtUVUyUmpUWGxa?=
 =?utf-8?B?Ym5janAzSHRnV1hPNDRBM3ZGdFgrbE1Xb285bXpoMG1lWE5NdUkvZWNiRWds?=
 =?utf-8?B?c3RWY3BqMExkcHcxNm5zQWRMckJ5MzJIQmdQMmZhbmVCeGNzSmtJWnAveGRm?=
 =?utf-8?B?WXViUU96Q25DdGpDRXhWRlAyaS9yRTZNZFJLRFRJTFNUNXRLcFR0OHVuNy8v?=
 =?utf-8?B?NFgycFJVOVQ2Lzh4L0VkNGd3RFFEMWNaM08ycXE4Rm5LU2xIQ0NBQ2NkM0s5?=
 =?utf-8?B?Y3NLeWp5bStTOEh1OFVTRWJ3Tm1VNEpYNjUyTXFka2VnTFV6SENXdXRIMkVS?=
 =?utf-8?Q?pTy79PF4WxAb47bTvHTpMwE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3410D83CCFD174CA888E19F333F2423@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d6525e-9de9-4a48-c948-08db14467fcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 20:02:02.7178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aEdQVEyGged71HJK1AnOjgnoNCrii7tXFZ0+z0aUvuvRX8dCJ7uV+7xArrHpHjj61H0/3Rie/VSLVZBWVbcRhNpWOekrXVE2eMktfdPLv3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7164
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIzLTAyLTIxIGF0IDA5OjQ4ICswMTAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4gT24gMTguMDIuMjMgMjI6MTQsIFJpY2sgRWRnZWNvbWJlIHdyb3RlOg0KPiA+IEFkZCBh
IHNpbXBsZSBzZWxmdGVzdCBmb3IgZXhlcmNpc2luZyBzb21lIHNoYWRvdyBzdGFjayBiZWhhdmlv
cjoNCj4gPiAgICAtIG1hcF9zaGFkb3dfc3RhY2sgc3lzY2FsbCBhbmQgcGl2b3QNCj4gPiAgICAt
IEZhdWx0aW5nIGluIHNoYWRvdyBzdGFjayBtZW1vcnkNCj4gPiAgICAtIEhhbmRsaW5nIHNoYWRv
dyBzdGFjayB2aW9sYXRpb25zDQo+ID4gICAgLSBHVVAgb2Ygc2hhZG93IHN0YWNrIG1lbW9yeQ0K
PiA+ICAgIC0gbXByb3RlY3QoKSBvZiBzaGFkb3cgc3RhY2sgbWVtb3J5DQo+ID4gICAgLSBVc2Vy
ZmF1bHRmZCBvbiBzaGFkb3cgc3RhY2sgbWVtb3J5DQo+ID4gDQo+ID4gU2luY2UgdGhpcyB0ZXN0
IGV4ZXJjaXNlcyBhIHJlY2VudGx5IGFkZGVkIHN5c2NhbGwgbWFudWFsbHksIGl0DQo+ID4gbmVl
ZHMNCj4gPiB0byBmaW5kIHRoZSBhdXRvbWF0aWNhbGx5IGNyZWF0ZWQgX19OUl9mb28gZGVmaW5l
cy4gUGVyIHRoZQ0KPiA+IHNlbGZ0ZXN0DQo+ID4gZG9jdW1lbnRhdGlvbiwgS0hEUl9JTkNMVURF
UyBjYW4gYmUgdXNlZCB0byBoZWxwIHRoZSBzZWxmdGVzdA0KPiA+IE1ha2VmaWxlJ3MNCj4gPiBm
aW5kIHRoZSBoZWFkZXJzIGZyb20gdGhlIGtlcm5lbCBzb3VyY2UuIFRoaXMgd2F5IHRoZSBuZXcg
c2VsZnRlc3QNCj4gPiBjYW4NCj4gPiBiZSBidWlsdCBpbnNpZGUgdGhlIGtlcm5lbCBzb3VyY2Ug
dHJlZSB3aXRob3V0IGluc3RhbGxpbmcgdGhlDQo+ID4gaGVhZGVycw0KPiA+IHRvIHRoZSBzeXN0
ZW0uIFNvIGFsc28gYWRkIEtIRFJfSU5DTFVERVMgYXMgZGVzY3JpYmVkIGluIHRoZQ0KPiA+IHNl
bGZ0ZXN0DQo+ID4gZG9jcywgdG8gZmFjaWxpdGF0ZSB0aGlzLg0KPiA+IA0KPiA+IFRlc3RlZC1i
eTogUGVuZ2ZlaSBYdSA8cGVuZ2ZlaS54dUBpbnRlbC5jb20+DQo+ID4gVGVzdGVkLWJ5OiBKb2hu
IEFsbGVuIDxqb2huLmFsbGVuQGFtZC5jb20+DQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBZdS1jaGVu
ZyBZdSA8eXUtY2hlbmcueXVAaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFl1LWNoZW5n
IFl1IDx5dS1jaGVuZy55dUBpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmljayBFZGdl
Y29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0KPiA+IA0KPiA+IC0tLQ0KPiANCj4g
DQo+IFsuLi5dDQo+IA0KPiA+ICtib29sIGd1cF93cml0ZSh2b2lkICpwdHIpDQo+ID4gK3sNCj4g
PiArICAgICB1bnNpZ25lZCBsb25nIHZhbDsNCj4gPiArDQo+ID4gKyAgICAgbHNlZWsoZmQsICh1
bnNpZ25lZCBsb25nKXB0ciwgU0VFS19TRVQpOw0KPiA+ICsgICAgIGlmICh3cml0ZShmZCwgJnZh
bCwgc2l6ZW9mKHZhbCkpIDwgMCkNCj4gPiArICAgICAgICAgICAgIHJldHVybiAxOw0KPiANCj4g
L3Byb2Mvc2VsZi9tZW0gaXMgZm9yIGRlYnVnL3B0cmFjZSBhY2Nlc3MgKEZPTExfRk9SQ0UpLiBJ
IHRoaW5rIHlvdSANCj4gbWlnaHQgYWxzbyB3YW50IHRvIGFkZCB0ZXN0cyBmb3Igb3JkaW5hcnkg
R1VQLCBjaGVja2luZyB0aGF0IHdlIGZhaWwNCj4gdG8gDQo+IG9idGFpbiBhIHdyaXRlIHBpbiAt
LSBhbmQgY2FsbCB0aGVzZSB0ZXN0cyAiZ3VwX3B0cmFjZV9yZWFkIiAvIA0KPiAiZ3VwX3B0cmFj
ZV93cml0ZSINCg0KWWVzLCB0aGlzIG9ubHkgdGVzdHMgdGhlIEZPTExfRk9SQ0UgY2FzZSwgYnV0
IGl0IGRvZXMgZXhlcmNpc2UgR1VQLg0KDQo+IA0KPiBBbiBzaW1wbGUgYXBwcm9hY2ggd291bGQg
YmUgdG8gdHJpZ2dlciBhIHJlYWQoKS93cml0ZSgpIG9uIGEgZmlsZQ0KPiBvcGVuZWQgDQo+IHZp
YSBPX0RJUkVDVCwgdXNpbmcgdGhlIHNoYWRvdyBzdGFjayBhcyBidWZmZXIuIFdoaWxlIHRoZSB3
cml0ZSgpIA0KPiBbcmVhZGluZyBmcm9tIHRoZSBwYWdlXSBpcyBleHBlY3RlZCB0byB3b3JrLCBh
IHJlYWQoKSBbd3JpdGluZyB0bw0KPiB0aGUgDQo+IHBhZ2VdIGhhcyB0byBmYWlsLg0KDQpIbW0s
IGdvb2QgaWRlYS4gVGhpcyB3b3VsZCBiZSBuaWNlIHRvIGFkZC4NCg==
