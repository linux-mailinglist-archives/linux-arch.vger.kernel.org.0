Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293A65F5DEC
	for <lists+linux-arch@lfdr.de>; Thu,  6 Oct 2022 02:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJFAiQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Oct 2022 20:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiJFAiP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Oct 2022 20:38:15 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B193DBE3;
        Wed,  5 Oct 2022 17:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665016693; x=1696552693;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VuoWAICRGlu+dv9OFpqlbNn4BizBS3WtvOjWdUin2Vo=;
  b=ADx9arKTxJkmKIc/xVPgdgFbrHH69P5gbmwPbaCdl4kkIpXmem7lJxqd
   sClwJWcWUpQI9OENvzP6/H3eYr3ibJ6PJxgmLYJljArVuexFrXLqDiTCC
   I+sjyqAEZWP05oaVBkpdHURrMUbtxSpkWM46R0TtGjS/0iP2NMOJhrBgu
   dwGnpjTINWnHL5ju2/gHvqAOQPWL4VwqTyrO2tTmCiPGqcdvzR9/+Y4ev
   nvtMKTayN2T/jEiyQ5cpa5SNAzNqOD2kY1QZj6WUwd9M9M2gCaeRAxuxY
   5DQ/y8GmJwSjfblFMqT0YNcL3wMnFnORwM9M0NfY5wh58FNGHy/0BSdR6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="389598437"
X-IronPort-AV: E=Sophos;i="5.95,162,1661842800"; 
   d="scan'208";a="389598437"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 17:38:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="869639063"
X-IronPort-AV: E=Sophos;i="5.95,162,1661842800"; 
   d="scan'208";a="869639063"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 05 Oct 2022 17:38:09 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 5 Oct 2022 17:38:08 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 5 Oct 2022 17:38:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 5 Oct 2022 17:38:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 5 Oct 2022 17:38:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPLOUmY/VXQ3wvx2lNWG4fEmOySION7dVsiwpTBSZtCw9rrFTfxjj6OP/zLSwb4A46R7/Hhkq5OSGDjwc3W846QR5mv8oQiiwcgXmawWURGS+WbsDOHGoSKTZy4pPZDz+TR04aswEO9VNuXdavMmDVz+VE1V8dh1w/fqvgISKNBu7w6pbQa5/mIfcwaYQb8CQe1tgG6dUF7mMOAV4oqiCZR52awJLT9uimLyRCtS4m3figA94/GH5RrDMPp0flxEvDk2UtVD7+yTpq1JqAy/Ogn46qCkI7jVK+2JZylJL4pzr8EGo1Ltg1m+bk1TDN+kDU/rYpnBoyzvIVXVzGo1PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuoWAICRGlu+dv9OFpqlbNn4BizBS3WtvOjWdUin2Vo=;
 b=KXgB0GZNBaYVhJhx9WkJg1alc6fC71MaYjvYzg0CR1gLhkd9ASaNXW1UzczSm6PzJNcRSBl3lhh3LeGhuSPI8v3M7234nbzouhhvsM/dVoO01/ohCaIzniDGENw2IljUYOIESiBlnTtctBCrjslmuoWHlhnakDFAH3jrpRT0d/kwH0zD/DCSKOstpuVqOqP+c83Twwut7SKS+4Z2/d8uiGEKe57RMe438H2rl01M4B1tZthsSiQ29akZtjyihlgOWQkALyAvW1qjfNU1wyZHqn9SIVaXxn92YXmKXjITS7D+zElHqtNaDZFnxNN6cznbRg4nbGrMcFIOPTOBv6BdOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Thu, 6 Oct
 2022 00:38:06 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.034; Thu, 6 Oct 2022
 00:38:06 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "keescook@chromium.org" <keescook@chromium.org>,
        "Lutomirski, Andy" <luto@kernel.org>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v2 29/39] x86/cet/shstk: Support wrss for userspace
Thread-Topic: [PATCH v2 29/39] x86/cet/shstk: Support wrss for userspace
Thread-Index: AQHY1FMjOx7eQC8w0EqZogI4sq/qaa39RluAgAAI5ACAAF4EAIAC4eKA
Date:   Thu, 6 Oct 2022 00:38:06 +0000
Message-ID: <33ee10b3d41bfa1f8cf03f87f1d13e565bea3120.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-30-rick.p.edgecombe@intel.com>
         <202210031525.78F3FA8@keescook>
         <6ea0841f-5086-9569-028b-922ec01a9196@kernel.org>
         <202210032129.44F6E027D@keescook>
In-Reply-To: <202210032129.44F6E027D@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH0PR11MB5077:EE_
x-ms-office365-filtering-correlation-id: 5efb9dae-bed6-491d-a381-08daa733090b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BYJxqIqw5v3IRPWdcUIvd2eIqLQXwnAUq+EZoipINtrhz7zG5RgvbDBpOiiXywYCLzvfzyUtGNrKFaC5yu5s1ZEa2tZ5SWYY3QZpKlKGGIjGFeCx79nOZu3TbNfszakinnX7RqHM9/qFtEU9xY86guDefYK2XBM0VBgtCeodDAW1/mKTdYiQbDVBDZiZZAq5OTKkMxLQAEpTaRh7FizEcGrSb6ZsSQbBOxLs7YCw+3wAtDEWmtd0AhCto4x9qpzkN3wa0egbGp++BRWET826SRpM7bcdAmMpKTWTIkfiq4cZJbHpCITTOXNRhvPjhjbv0Gxk77ryZUdfYSwA9Ir9LRHEyxbJ3CT8zaW/3l4NCI7Y6P+/CI3z0QstFi99LjQnbIaq8qZYFrBHQDUWfP1wKtOWBp6OMwPiE4G5lXnfoesobvqeBmtZyXpOKKTkWsUWWhaZ6nm1et7VIgLe+ZwBFV5aX50cu7rnoGkqsaDUIU19dIwqh4BCmj+yGxmJ2tNyWVvH56Ksu9Y6c/BIBZx51vogpfKfaK+bWgWgUAboOvDToWhuqFzAlZafxoMmhgf9Ic67IDzQJExfwtuLPDy3hd/xWhaNaIen/cetH+jwEeuAH+GlobkxCV2QUcsPnL//T/5WsI3aWEIHFmvwSSqH3iod8qmj+DELpd6eeC9yBl7G0k90aHbxfnlyPjDGnAg5sgOVFI0S9V7pFN8nTKIdf5P1tg6RNr8pchvlG6z+Lo0vxM9796tIhfz4MOL/4t44
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199015)(478600001)(6486002)(8936002)(966005)(71200400001)(7416002)(5660300002)(7406005)(38070700005)(186003)(86362001)(83380400001)(82960400001)(6506007)(53546011)(36756003)(2616005)(2906002)(41300700001)(38100700002)(6512007)(122000001)(26005)(4326008)(66476007)(64756008)(66556008)(8676002)(66446008)(66946007)(76116006)(91956017)(54906003)(110136005)(316002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEorNU5FU3FrbzliTG9qMnNSaGo2OGJOVFE2aGRmVTgwdlJmeHRYbnV1bU1I?=
 =?utf-8?B?M1kvOExTQjhuZTdVOWtlYkFESnBzZWhQdll4NWVObGxVVlR5RkE0K0lOeS8y?=
 =?utf-8?B?R2xNcUpQOWMxMDlYRjB5TXEvRTkwM1RsRTZKVTROQmF4WTVXN1RvNzVzRGxG?=
 =?utf-8?B?VU1aNHlRYy8wVEZoMkxYRW5VNlQrbXVLMWRXdzdWVGxUTjN5OVJBbW5OSkc1?=
 =?utf-8?B?OFZhZm0wQmlNNHdUQ2N1dFQvcFc4SUdOODROU0QxQ3FZR0s3MFB0Mi9Hcms1?=
 =?utf-8?B?cVM5VHlJVmVNRk1DRlpYODRUUkQ5bytpZlJ4WFp1bU93M0tHMEwrNTVDU1dB?=
 =?utf-8?B?VTNqdjNrZnVDNlRSTWJVcVJkUldJREkzWFUwKzQzdTZZb2dBeGlpdmlwY0c2?=
 =?utf-8?B?TUs2S0NzeUFsY2RuOFk3QXNybHc1YysrdTFiUGt3YUZkaXU0R1FaTnA0dXc3?=
 =?utf-8?B?Yldaa08yT2V1QktiSUd4ckJWSCtocHg1VS9vYXU5eTBranlQVlpzay8wTE04?=
 =?utf-8?B?OVY5ZlpMRmxzWi9lcFZaYXBuQjhFaEhySHlMUzZmMmdsUkRWbW9uTU5vMzBG?=
 =?utf-8?B?WWVMdDJjdFVYTUlhUE1iL1VTMEVVdUQ1MVNHOVNEMUE1TFVSYitUUWRCalBG?=
 =?utf-8?B?dytPejU0cWhRczVTRG03cHN6Zm9GY2U4dlpEcXZveklzdFI4VFJQSkNiRHQ4?=
 =?utf-8?B?VWVmOVV6Z1gxTnZRTXM3VFlpMkxaUEt3a250WGEzZ2lLdGlMV1BkT0ZZUGUy?=
 =?utf-8?B?SHFNUCtZQXlpT0l4QWhYY3g5V1p1SGc3OEx5aytyUTZjalZQMC9Xb1UxTlpD?=
 =?utf-8?B?NXkyUlorYzlkcDdFclE2bzBYQXplUVhHOEtGcGpFUzVFOWoxMDFLY0RPdjc1?=
 =?utf-8?B?Zmc5d2ZTSlAzbHA2RGdxYkNQUnduSjVaN0l6RkIzbU9GL20yT0J2V29yanhV?=
 =?utf-8?B?SWFaWDM3dmdlUVFocXNJL0g1akx3STMzSVYzMGk0dTdnb1duWnllMnkyUURy?=
 =?utf-8?B?VjB2eHJ0MFNrNndjS2F0TnV1VW1zNmVnZkp2VzVDVkh0dU5ZYytpQnNtZnU2?=
 =?utf-8?B?b21YenZ1bzN4OWVsdlh3VklSMGE0WVIyTEY2MTg1anhLbkxGTkltdVdJeUpV?=
 =?utf-8?B?WGJmb2pXMzFZbU01cURZMTZtSUFuMytsd2ZRSkV0emg4K2c3azQ1cWExU21y?=
 =?utf-8?B?RjdTQk4yWkNYT0lHQ3A2bFdudUx6U1BDVm9ma2VEVGRmTmpTcWFZNFFTcTZQ?=
 =?utf-8?B?MFNoenNmdXNUMkg3VmR5VnEvck43azRTRHlGUnBwUmV6TTF4TERpRjBlZHJu?=
 =?utf-8?B?aXIxTDRzNTcwQlZwQzB2S0pxb2ppZVcyWktQRU1yNGFKbUkxalk5ZWdHTGtF?=
 =?utf-8?B?NWtpQXlqU1VNSG96UUNmZWFOZHRZWnowVDdKWjhKNTB2NmVYZ3R5Y2tRNC9C?=
 =?utf-8?B?M3BjN05WZkxWcTdZVjUyY3Y3RnhXcitXR3NIaU8xeEYzbTdjY2QrUjVLSldq?=
 =?utf-8?B?UWdLQmV3a0VsdmQxWVdIZTZ5Z2dCWngzRVdEZkYzRW5ZdWNkUHJINXZSOFNj?=
 =?utf-8?B?YTRqT0l0MWtyQWt4ck12Y29VYkVpSDJxY0FsWlk4TytvMitCZ0pPT0tEK3pt?=
 =?utf-8?B?VmFmdkFwd0NTdHJMeWIyY09Zc0pLNHJPR3RQT1VyOGpPelJYVEdFQWl5eFV2?=
 =?utf-8?B?QXVvMHF5T1U2Vk1adHJseXFMREduVHJUR2JRTU1YVk5LUFNZRmE2TFRNWDIx?=
 =?utf-8?B?K2E3bnlZUEVqVHBKc1JNWkpoYlk3ZFdvNHYyTkRLUndmVTRORHZxVStLYW90?=
 =?utf-8?B?UVhLTHcrT1Z1SUxFMk5yQmJTdlc0WXdNYUZxeERTWVZtNDgxMlYybXpmNlRu?=
 =?utf-8?B?T2JaYit4SldPd2FJcUMvTTJFYnFxdjdJalkvK01BaDdReTVYb251eTVUR2RV?=
 =?utf-8?B?cHJHc2ZlaHdGMjAySDc4WmdXZWIwZEhGM1owbFBQcS9jRW16bW5WV09IQzE0?=
 =?utf-8?B?L3hDU2IvNFlhdmdEbDNkTGEyMzQybFVJaGcyaUNrMTBkRTVvbElseE0ranp0?=
 =?utf-8?B?MmxZakF4d093OVZqdEptNGJ0RFhSLy9TQmZhY0s4NWVxZC9VUVRHNjM1cW4z?=
 =?utf-8?B?UWVObGZ0M1FibzFGaG5tYndpNEh0cEZ3MGNDa2Y2SGxSWFhUcm55ZDZONmY0?=
 =?utf-8?Q?6IJCtXtZXZ2BpZRayy1BvKw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1D35815582F6D4F9D3E2D555C148D15@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5efb9dae-bed6-491d-a381-08daa733090b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 00:38:06.2649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5NOEck/52czQXUFcqikTtxW+Up0DpHvlZROSc0WVV9L5XXrq24cMwQhol7tf16zCAlWSQHFXOo+pvRSqbbX9S870Y4lc6s+HrSYfitTxEK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5077
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTAzIGF0IDIxOjM3IC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+IE9u
IE1vbiwgT2N0IDAzLCAyMDIyIGF0IDA0OjAwOjM2UE0gLTA3MDAsIEFuZHkgTHV0b21pcnNraSB3
cm90ZToNCj4gPiBPbiAxMC8zLzIyIDE1OjI4LCBLZWVzIENvb2sgd3JvdGU6DQo+ID4gPiBPbiBU
aHUsIFNlcCAyOSwgMjAyMiBhdCAwMzoyOToyNlBNIC0wNzAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90
ZToNCj4gPiA+ID4gRm9yIHRoZSBjdXJyZW50IHNoYWRvdyBzdGFjayBpbXBsZW1lbnRhdGlvbiwg
c2hhZG93IHN0YWNrcw0KPiA+ID4gPiBjb250ZW50cyBlYXNpbHkNCj4gPiA+ID4gYmUgYXJiaXRy
YXJpbHkgcHJvdmlzaW9uZWQgd2l0aCBkYXRhLg0KPiA+ID4gDQo+ID4gPiBJIGNhbid0IHBhcnNl
IHRoaXMgc2VudGVuY2UuDQo+ID4gPiANCj4gPiA+ID4gVGhpcyBwcm9wZXJ0eSBoZWxwcyBhcHBz
IHByb3RlY3QNCj4gPiA+ID4gdGhlbXNlbHZlcyBiZXR0ZXIsIGJ1dCBhbHNvIHJlc3RyaWN0cyBh
bnkgcG90ZW50aWFsIGFwcHMgdGhhdA0KPiA+ID4gPiBtYXkgd2FudCB0bw0KPiA+ID4gPiBkbyBl
eG90aWMgdGhpbmdzIGF0IHRoZSBleHBlbnNlIG9mIGEgbGl0dGxlIHNlY3VyaXR5Lg0KPiA+ID4g
DQo+ID4gPiBJcyBhbnl0aGluZyB1c2luZyB0aGlzIHJpZ2h0IG5vdz8gV291bGRuJ3QgdGhpbmcg
YmUgc2FmZXIgd2l0aG91dA0KPiA+ID4gV1JTUz8NCj4gPiA+IChXaHkgY2FuJ3Qgd2Ugc2tpcCB0
aGlzIHBhdGNoPykNCj4gPiA+IA0KPiA+IA0KPiA+IFNvIHRoYXQgcGVvcGxlIGRvbid0IHdyaXRl
IHByb2dyYW1zIHRoYXQgbmVlZCBlaXRoZXIgKHNoc3RrIG9mZikgb3INCj4gPiAoc2hzdGsNCj4g
PiBvbiBhbmQgV1JTUyBvbikgYW5kIGNyYXNoIG9yIG90aGVyd2lzZSBmYWlsIG9uIGtlcm5lbHMg
dGhhdCBzdXBwb3J0DQo+ID4gc2hzdGsNCj4gPiBidXQgZG9uJ3Qgc3VwcG9ydCBXUlNTLCBwZXJo
YXBzPw0KPiANCj4gUmlnaHQsIHllcy4gSSBtZWFudCBtb3JlICJ3aGF0IHByb2dyYW1zIGN1cnJl
bnRseSBuZWVkIFdSU1MgdG8NCj4gb3BlcmF0ZQ0KPiB1bmRlciBzaHN0az8gKEFuZCB3aGF0IGlz
IGl0IHRoYXQgdGhleSBhcmUgZG9pbmcgdGhhdCBuZWVkcyBpdD8pIg0KPiANCj4gQWxsIGlzIHNl
ZSBjdXJyZW50bHkgaXMgY29tcGlsZXIgc2VsZi10ZXN0cyBhbmQgZW11bGF0b3JzIHVzaW5nIGl0
Pw0KPiANCmh0dHBzOi8vY29kZXNlYXJjaC5kZWJpYW4ubmV0L3NlYXJjaD9xPSU1Q2IlMjh3cnNz
JTdDV1JTUyUyOSU1Q2ImbGl0ZXJhbD0wJnBlcnBrZz0xDQoNCk1vc3QgYXBwcyB0aGF0IHdlcmVu
J3QganVzdCBhdXRvbWF0aWNhbGx5IGNvbXBpbGVkIGhhdmVuJ3QgaGFkDQppbXBsZW1lbnRhdGlv
biBlZmZvcnQgeWV0LiAob2YgY291cnNlIGdsaWJjIGhhcyBoYWQgYSBidW5jaCkgSSBob3BlIHdl
DQp3b3VsZCBzZWUgbW9yZSBvZiB0aGF0IHdoZW4gd2UgZmluYWxseSBnZXQgaXQgdXBzdHJlYW0u
IFNvIEkgdGhpbmsgYQ0KYmV0dGVyIHF1ZXN0aW9uIGlzLCBob3cgbWFueSBhcHBzIHdpbGwgbmVl
ZCBXUlNTIHdoZW4gdGhleSBnbyB0byBlbmFibGUNCnNoYWRvdyBzdGFjay4gSSdtIHRoaW5raW5n
IHRoZSBhbnN3ZXIgbXVzdCBiZSBzb21lIGFuZCBpdCBjb3VsZCBiZSBuaWNlDQp0byBjYXRjaCB0
aGVtIHdoZW4gdGhleSBmaXJzdCBpbnZlc3RpZ2F0ZSBlbmFibGluZyBpdC4NCg0KQnV0IHllcywg
ZXhjZXB0IGZvciBNaWtlJ3MgQ1JJVSBicmFuY2gsIHRoZXJlIGFyZW4ndCBhbnkgcHJvZ3JhbXMg
dGhhdA0KdXNlIGl0IHRvZGF5LCBhbmQgd2UgY291bGQgZHJvcCBpdCBmb3IgYSBmaXJzdCBpbXBs
ZW1lbnRhdGlvbi4gSSBkb24ndA0Kc2VlIGl0IGFzIHNvbWV0aGluZyB0aGF0IHdvdWxkIG9ubHkg
bWFrZSB0aGluZ3MgbGVzcyBzYWZlIHRob3VnaC4gSXQNCmp1c3QgbGV0cyBhcHBzIHRoYXQgY2Fu
J3QgZWFzaWx5IHdvcmsgd2l0aGluIHRoZSBzdHJpY3RlciBzaGFkb3cgc3RhY2sNCmVudmlyb25t
ZW50LCBhdCBsZWFzdCBnZXQgYWNjZXNzIHRvIGEgd2Vha2VyIGJ1dCBzdGlsbCBiZW5lZmljaWFs
IG9uZS4NCg0KS2VlcywgZGlkIHlvdSBjYXRjaCB0aGF0IGl0IGNhbiBiZSBsb2NrZWQgb2ZmIHdo
aWxlIGVuYWJsaW5nIHNoYWRvdw0Kc3RhY2s/DQo=
