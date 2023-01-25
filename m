Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335DB67B718
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jan 2023 17:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbjAYQoA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Jan 2023 11:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbjAYQn7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jan 2023 11:43:59 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E337259E8;
        Wed, 25 Jan 2023 08:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674665038; x=1706201038;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=4ravyM2T85HprlP38KY7ILSO6SYHUVqKQtYUrUMkuTY=;
  b=KlKfgWfec1VSzxtANe4sXfcnX8M/dlhbhK/pHTf4R5Rrp8KKnKxzn+OH
   jDelsX6cyQaCLt5ZUjwRvz8pCTUXnQL+fcZuX8oQRiFbUMmkwikWVogsE
   98vWJbTDzyVbQLObqvthLQ+c4DQRICN6tiX+Him4MfTgWsXf7+zQ+x3YG
   rxo1N1UYJgtMIybMGfj6Qxb7G1EpvPRuqh3SaubG1pTPDGycEfUxnLyqT
   fArdJ/Kd9IWF/ziCuPjQm2Xm/kVOabQVOgjlPEz+eNsE2/KfV9RxlC67O
   cVUaSGHM5bi3TmUmbO57wQwO9tVabCv9hnER5mRyyc9Npt+UloF/P9pis
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="306264996"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="306264996"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 08:43:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="655852581"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="655852581"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 25 Jan 2023 08:43:56 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 08:43:55 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 25 Jan 2023 08:43:55 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 25 Jan 2023 08:43:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHSZb5on+XDtXEDYn+eR0R4aaboS2hvfQLakXi4vMs1+QtNHm5G7xswIeLcOFwXJtHlQR1RRZYPed3FQ3y1c8UzKe6i2Awn8XGspXBTGYcmE1Fb5dE7FpzB++abt1fon6nDwK9SufHtiU09tpfbz8cBWTt8af4ijTs/oExFi5th5LHBmxTvQb8mUzMDmVtMy41T/lEIP1HLNChKNnwZK3HaTukonnYepiMucKcQjCQClAmZHmZTO7TVEuTvKEPTo87s8TcUeo3hfIBhgku511ROdmdQ1UfQQhXZRC5c8mMglKE+1QcIcs8Kx7geoAB64nVlPsX0zRJBLTdeT7eNxUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hh8kAMriKWUitX6y8tUJpdiTem78JoSLIe5pUdk5VRA=;
 b=fRRyda9pGMpVw6zqzlTbj/BBH/6dQlXQ6MULJqtUl7Q7oUQOyA3IU/ETQ43IfLqg+hXY3GIw44UuE6jjew53V6MNQLcdPw0RiCsc56hfpShCx1fPd90WS4PPeh76dBDGItkKoq8Q7jfg7L83KYNLZpE5z9DuTNyGphc4IuZ32nOCulpWenIBn6nX4RCFOkhSVXl7SzqbmXQk1oPFLDiIN/to46jRi6AvG/Xx65nvJfS5uSg48reVwK9u1/02IKO9EmoaaSOknLgdw1x6MAVAMMDWJHzvEf1aeARJnBCI8ApkzDL013nC5ksCylo/j8xpANijLV8SdSpc4HCEOjXDAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY4PR11MB2005.namprd11.prod.outlook.com (2603:10b6:903:2e::18)
 by CH3PR11MB7794.namprd11.prod.outlook.com (2603:10b6:610:125::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Wed, 25 Jan
 2023 16:43:45 +0000
Received: from CY4PR11MB2005.namprd11.prod.outlook.com
 ([fe80::cec1:7ea4:6952:337a]) by CY4PR11MB2005.namprd11.prod.outlook.com
 ([fe80::cec1:7ea4:6952:337a%4]) with mapi id 15.20.6002.033; Wed, 25 Jan 2023
 16:43:45 +0000
From:   "Schimpe, Christina" <christina.schimpe@intel.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "david@redhat.com" <david@redhat.com>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "rppt@kernel.org" <rppt@kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: RE: [PATCH v5 23/39] mm: Don't allow write GUPs to shadow stack
 memory
Thread-Topic: [PATCH v5 23/39] mm: Don't allow write GUPs to shadow stack
 memory
Thread-Index: AQHZLExdUTaobfYwNkOWzEcXowdKDq6rvFwAgAAas2GAAKfZAIABScmAgAAl7QCAAV4I0IAAEpvg
Date:   Wed, 25 Jan 2023 16:43:44 +0000
Message-ID: <CY4PR11MB2005202E424E2B19F4B2CF67F9CE9@CY4PR11MB2005.namprd11.prod.outlook.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
         <20230119212317.8324-24-rick.p.edgecombe@intel.com>
         <aa973c0f-5d90-36df-01b2-db9d9182910e@redhat.com>
         <87fsc1il73.fsf@oldenburg.str.redhat.com>
         <c6dc94eb193634fa27e1715ab2978a3ce4b6c544.camel@intel.com>
         <fd741ac9-8214-a375-00b2-a652a7ef27ea@redhat.com>
 <6adfa0b5c38a9362f819fcc364e02c37d99a7f4a.camel@intel.com>
 <CY4PR11MB2005CA3050147893EAC10B9EF9CE9@CY4PR11MB2005.namprd11.prod.outlook.com>
In-Reply-To: <CY4PR11MB2005CA3050147893EAC10B9EF9CE9@CY4PR11MB2005.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR11MB2005:EE_|CH3PR11MB7794:EE_
x-ms-office365-filtering-correlation-id: 7bf7e0e2-0258-4084-0bc7-08dafef352fe
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1IewiLcxpZg83ldpR+Ha8D0dfMjSUURuglZDwGIsZJQYzhN3jRTcRpKa4QJPuhs8Cuh9xu86jkT7ZURCHGm7Gx94s8ES/KbB3V3/TkVAELstN5ghMW+NVed6+LmgXscqtADf+aelg75s+Z67LxSkFsJwTDMO9pvPpFrrpFbhdnfvNMGTkBLFipylwdq2HSLG4A5uTO858GRWqofPZpezeiYKFzFzCHLU6izebEOuMSEch4mhozepdYS8Cj4rSqTrI9/yHUfe/csU0v5XKfz3ScOKhB1RaDOD0InXEnOlrGTxG0i6d9ZMcSQSXIreBo3eAm9k/p+MaRjZBeEYpwbwsCf8GtjGbj3oeIkaoeJbseAjkoMMOe5xo97tfaWqAM6f///zghwvenk9a6k6EtoXs2VhBgQ8NbKdQ/RZsJWbCsT04vT5kodrRVO51yFPtErz98yoAaoH4Zeft/QbSVo4yPVC5cFm3iJsP1s+gGq7qOosTvTEdL4TiH/eoAunwIEa6m10r4Bkxoitqm6o6oSk5updfJ7BWc3VvkV2AN3Axw9wYxyaLD4k/ARcQvKJG031l9PUnWfW2UgAHT6PH1mCsehFyI04GjXacqFHfuwoWIVAcbgtDCo8HuM3yiIa3J/dHLCMFaRkPXsiUssqRD7Kk7cF9zlYplpa/KepHI++zpWvR0bCHPNp/+Vo3Nr5+bU+sjl5Q1GLLtJD6Ia2trsd6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB2005.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199018)(7696005)(71200400001)(186003)(86362001)(9686003)(26005)(478600001)(2940100002)(54906003)(316002)(33656002)(110136005)(76116006)(66946007)(38070700005)(66476007)(64756008)(66446008)(55016003)(66556008)(4326008)(8676002)(38100700002)(41300700001)(52536014)(8936002)(83380400001)(6506007)(7406005)(7416002)(5660300002)(82960400001)(122000001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVNOVE1Md1JrUklBcFNsai80aWJ2b25XcUhGOFJCU0pHU0crQlo5RzA2ODVU?=
 =?utf-8?B?Q2krTi85bkJLeUc0OGM3RWkvZEJrRlNqZlZkV3RSa3hiUW9RajVxckd4NjlL?=
 =?utf-8?B?UDdOeVpoeHh1YXBEaG94ZWtDczNwNDNmRFhsc3V3dUpRdmxuenkzZFJTMlRC?=
 =?utf-8?B?SXZ2SVdhc2xMei9paEs4NzNlajdGc1dOMVpyb25FWTdIQlZua1BiRUdiOHkr?=
 =?utf-8?B?cExNMEZQekdBSHR6ZDRBSVd2NnZPeHE1MmxFUDJsaTFERkg2U2VnVnVnYTNx?=
 =?utf-8?B?ZzRxSWwyaTN3TzFINERPRFNmYy9IYkdFRzNuTkpTbHI0bEtTS1RtUkh1OUh5?=
 =?utf-8?B?RDhHRVYrOVMvcTRKckZZZTd1VThhNHVPMFhPei9rM3hBZHVLRW5CUWQ0Rk5i?=
 =?utf-8?B?cG9RMGtaTFpXdHJzbkhaWWFXdTR6TTFPY0Z0R2pNSjU3UWNsaG5kdFp6d0dt?=
 =?utf-8?B?cG9pRG9XQ2hTdFlPS3c5MWtJckRRSE1NMStUeHNDVkRIT3dDWE4wNTlHdUNq?=
 =?utf-8?B?aGJMY3FMdWtveUFuNzhucFMzNEx5dnVvYUpSakcxUm1zQStmRDZNTGRFTnY0?=
 =?utf-8?B?azF5N1VidmM3aSs0YTJXRkE5R2hzUGcvMXpZSnFQc01FdFFjVnFQYzgzdnNt?=
 =?utf-8?B?RlgzckJYZGFVWGxSa1RYQjJEUmdNTE40NUtML3Z4bXQ0a0ZmWm5oYUxsRnM5?=
 =?utf-8?B?eHR4TGVLYWFwZTZJTDd5RGZjeFBCZlZ5dDR6V05lbHFQeHZPdE0ycDl2ZmI1?=
 =?utf-8?B?K3h6YWliTXd1UmpWcVFoaVNITE4zMUE2WGdybGZYQmJlR0NDSXBRMGw1RjlO?=
 =?utf-8?B?aDhmRUM5bVFvcitwcHB0Y2dhNFZpQjU2N2UvbllOWmExbTFBK2ovVW9Tbjh6?=
 =?utf-8?B?cHNwMGhrL05LWm54MnhiREw5YkhaelRDcVNMYXBMS1pxcS9kV0ErSThSNGQ0?=
 =?utf-8?B?ZkNWZXZOcHlUTmxOd0VpeEUyN3d2cGU5WFUrdVcwWXpseis1ZE0wRWxlQVBV?=
 =?utf-8?B?aEtpd0JlRVhsMHpKNW93ZDVFbzd6U29CQmorYzEwLzVsQU8yWDRhZGJiZXlj?=
 =?utf-8?B?bGhnZ2ZVRWVtMm8xSG1XU3B6NHY5N0xIWlBGMXNSQkNibWowWGxISzc2Rk5K?=
 =?utf-8?B?Uk4xN2lyTUVBY0F0bll0dkVxbzBVQzJhVCswZ2pzV1pMaEZhRldKOENOTm1z?=
 =?utf-8?B?NHBLcFBuVHFWaFNZdUg4VmtCL2pDSzE2MFN2b1RGRWxyYS9RaDlsMGE4R1po?=
 =?utf-8?B?T2l1djUzdTJsNXVKbUhweThXdnpyVzhVQmVYVGRSbXJLTktBcEJJanpQRS9H?=
 =?utf-8?B?elQ5dkFUQTg1WThqVXFoTENEdVdsMGJwOU1qYVNKbTJBRC9obkdHVXpPQ0Iv?=
 =?utf-8?B?bUZtYlBEcWU0Y3E2L3llN0pXR2tTYm1Dbnh0cWhUQ0V3L2dwMGhVM1QwcU5q?=
 =?utf-8?B?cHVZdnQwT3NhdjVVbjRkdkdXV0c0WEpwZloybDZ2TDVsNWdpZmJIMnNVNHlT?=
 =?utf-8?B?NG94enkxSmZkeVIxT2MxMGpjUFVvVnRaaEE0dkx3YXJUQzQ4NFVDb3d3WlhH?=
 =?utf-8?B?UXFrd0UySWRxdVdIbGdmMThOeXZEaHZHcHo4K2xUMWtjajAwZ0FRQlpmcTVv?=
 =?utf-8?B?UU8vbHJzMldYTWZiVGZQS3c0MVMvSWFDUDFpUjBKYzdsVEVXYlpJNVJEWTUw?=
 =?utf-8?B?cHlkenhwMUN6MHpaRjFaaGtQQ3phWkw5Tjc2NTFmcGFrOFJRN01tcXdpZENm?=
 =?utf-8?B?YkdIYXhYdWJsbm5vR0pVdlJMS2VLUWxVamlQSE9sdnByc0orV09zOUJ1Vzlr?=
 =?utf-8?B?SGc5UUJqN2hrb096NEkzR3plUW9tUDJPWXFjU2U5Vlp3V0pUbnN0ZGkraUs2?=
 =?utf-8?B?STJra1BnU2xyOVQ5U1NtRTQ3eHFEN1phZGY1VktQOUFkaTNrM3Rka01QQ2Vr?=
 =?utf-8?B?UzVpRFZXU211SGc3cTVFeTZGYlZRN3E5ajRMS25OU25tM01DOHZpK2NiUXl2?=
 =?utf-8?B?Z0tsTWl4QXhuOTNXcHBJWTBiODRiRFBFTXRVbHk3YVVLRXJJQ1AwZk9IS05E?=
 =?utf-8?B?YzFnZ1V0czh2YTdaZFprV2VjMkJEaUhwVlVSUVlIR2x4dVBhK2tTYzVMcWs4?=
 =?utf-8?B?b05ZZ1o5ekZFMzBscU5ib3ZXUHo2Rm53L1h1U0ZNMUJRMGlBMDBOMGpsWGtF?=
 =?utf-8?B?aUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB2005.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf7e0e2-0258-4084-0bc7-08dafef352fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2023 16:43:44.9079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /9UkPaMgtscF0AVNGNSpp2KflJ3/T26Xrct9rUQckQSnb9qvzsbz+CRfLVw16UUPBaWOFQvVprJqY2HxEulvli2wBqQooPLtkpmoZ4/tcVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7794
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

PiA+IE9uIFR1ZSwgMjAyMy0wMS0yNCBhdCAxNzoyNiArMDEwMCwgRGF2aWQgSGlsZGVuYnJhbmQg
d3JvdGU6DQo+ID4gPiA+ID4gSXNuJ3QgaXQgcG9zc2libGUgdG8gb3ZlcndyaXRlIEdPVCBwb2lu
dGVycyB1c2luZyB0aGUgc2FtZSB2ZWN0b3I/DQo+ID4gPiA+ID4gU28gSSB0aGluayBpdCdzIG1l
cmVseSByZWZsZWN0aW5nIHRoZSBzdGF0dXMgcXVvLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGVyZSB3
YXMgc29tZSBkZWJhdGUgb24gdGhpcy4gL3Byb2Mvc2VsZi9tZW0gY2FuIGN1cnJlbnRseSB3cml0
ZQ0KPiA+ID4gPiB0aHJvdWdoIHJlYWQtb25seSBtZW1vcnkgd2hpY2ggcHJvdGVjdHMgZXhlY3V0
YWJsZSBjb2RlLiBTbyBzaG91bGQNCj4gPiA+ID4gc2hhZG93IHN0YWNrIGdldCBzZXBhcmF0ZSBy
dWxlcz8gSXMgUk9QIGEgd29ycnkgd2hlbiB5b3UgY2FuDQo+ID4gPiA+IG92ZXJ3cml0ZSBleGVj
dXRhYmxlIGNvZGU/DQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gVGhlIHF1ZXN0aW9uIGlzLCBpZiB0
aGVyZSBpcyByZWFzb25hYmxlIGRlYnVnZ2luZyByZWFzb24gdG8ga2VlcCBpdC4NCj4gPiA+IEkN
Cj4gPiA+IGFzc3VtZSBpZiBhIGRlYnVnZ2VyIHdvdWxkIGFkanVzdCB0aGUgb3JkaW5hcnkgc3Rh
Y2ssIGl0IHdvdWxkIGhhdmUNCj4gPiA+IHRvIGFkanVzdCB0aGUgc2hhZG93IHN0YWNrIGFzIHdl
bGwgKG9oIG15IC4uLikuIFNvIGl0IHNvdW5kcw0KPiA+ID4gcmVhc29uYWJsZSB0byBoYXZlIGl0
IGluIHRoZW9yeSBhdCBsZWFzdCAuLi4gbm90IHN1cmUgd2hlbiBkZWJ1Z2dlcg0KPiA+ID4gd291
bGQgc3VwcG9ydCB0aGF0LCBidXQgbWF5YmUgdGhleSBhbHJlYWR5IGRvLg0KPiA+DQo+ID4gR0RC
IHN1cHBvcnQgZm9yIHNoYWRvdyBzdGFjayBpcyBxdWV1ZWQgdXAgZm9yIHdoZW5ldmVyIHRoZSBr
ZXJuZWwNCj4gPiBpbnRlcmZhY2Ugc2V0dGxlcy4gSSBiZWxpZXZlIGl0IGp1c3QgdXNlcyBwdHJh
Y2UsIGFuZCBub3QgdGhpcyBwcm9jLg0KPiA+IEJ1dCB5ZWEgcHRyYWNlIHBva2Ugd2lsbCBzdGls
bCBuZWVkIHRvIHVzZSBGT0xMX0ZPUkNFIGFuZCBiZSBhYmxlIHRvDQo+ID4gd3JpdGUgdGhyb3Vn
aCBzaGFkb3cgc3RhY2tzLg0KPiANCj4gT3VyIHBhdGNoZXMgZm9yIEdEQiB1c2UgL3Byb2MvUElE
L21lbSB0byByZWFkL3dyaXRlIHNoYWRvdyBzdGFjaw0KPiBtZW1vcnkuDQo+IEhvd2V2ZXIsIEkg
dGhpbmsgaXQgc2hvdWxkIGJlIHBvc3NpYmxlIHRvIGNoYW5nZSB0aGlzIHRvIHB0cmFjZSBidXQg
R0RCDQo+IG5vcm1hbGx5IHVzZXMgL3Byb2MvUElEL21lbSB0byByZWFkL3dyaXRlIHRhcmdldCBt
ZW1vcnkuDQo+IA0KPiBSZWdhcmRzLA0KPiBDaHJpc3RpbmENCg0KSSBqdXN0IG5vdGljZWQgdGhh
dCBHREJTRVJWRVIgYWN0dWFsbHkgdXNlcyBwdHJhY2UsIHNvIG91ciBwYXRjaGVzIGN1cnJlbnRs
eSB1c2UNCmJvdGg6wqBwdHJhY2UgYW5kIHByb2MvUElEL21lbSB0byByZWFkL3dyaXRlIHNoYWRv
dyBzdGFjayBtZW1vcnkuDQoNClJlZ2FyZHMsDQpDaHJpc3RpbmENCkludGVsIERldXRzY2hsYW5k
IEdtYkgKUmVnaXN0ZXJlZCBBZGRyZXNzOiBBbSBDYW1wZW9uIDEwLCA4NTU3OSBOZXViaWJlcmcs
IEdlcm1hbnkKVGVsOiArNDkgODkgOTkgODg1My0wLCB3d3cuaW50ZWwuZGUgPGh0dHA6Ly93d3cu
aW50ZWwuZGU+Ck1hbmFnaW5nIERpcmVjdG9yczogQ2hyaXN0aW4gRWlzZW5zY2htaWQsIFNoYXJv
biBIZWNrLCBUaWZmYW55IERvb24gU2lsdmEgIApDaGFpcnBlcnNvbiBvZiB0aGUgU3VwZXJ2aXNv
cnkgQm9hcmQ6IE5pY29sZSBMYXUKUmVnaXN0ZXJlZCBPZmZpY2U6IE11bmljaApDb21tZXJjaWFs
IFJlZ2lzdGVyOiBBbXRzZ2VyaWNodCBNdWVuY2hlbiBIUkIgMTg2OTI4Cg==

