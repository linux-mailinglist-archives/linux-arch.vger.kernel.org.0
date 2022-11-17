Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AAD62DA9E
	for <lists+linux-arch@lfdr.de>; Thu, 17 Nov 2022 13:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240059AbiKQMZe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Nov 2022 07:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240077AbiKQMZX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Nov 2022 07:25:23 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D1B71F09;
        Thu, 17 Nov 2022 04:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668687922; x=1700223922;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=i6MDBdtMxQSKJ1D9KtGRVtH3qi5rR8OCssXKX9F8TkY=;
  b=SrCsd/MrUdmllhNxW9TH2XcKYGWaDuCudibhPVLDmqiZNrbe3c+x9JK0
   8NGCRhkwZ9vWxM1ihYa4biEKJFXTrlvqcgm0QCekmoZ7FfyuWIF8itqYj
   jR8ZT7qIbcaZql2ceEh34O4lIyOLHFb2ZOU9wkU1NubUySWs8y/6Qxzy4
   a/b8LeJFl4Wah6yZRTlp3jxOfd7Vf8hf6SaasgumIwCQ09YrOyb0BY2VM
   Ilzn2WHpWvCPPdAJB4trlX1YsmBIxsyaWAcakKVN4BI2vqNrTDhzkXCcB
   vKyTRHhlsVkvWF49jOaHSF5sjFLbRWE1DbUWNsiafXV2TIUPY4Ce9z7X0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="300369094"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="300369094"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 04:25:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="708595537"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="708595537"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 17 Nov 2022 04:25:21 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 04:25:20 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 04:25:20 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 17 Nov 2022 04:25:20 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 17 Nov 2022 04:25:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRRyc4sIBFtAS4VNmCKAOiUyKT9xhz/e/HdDPOdEU6QYV96bQJZcZ0LSnH7WRGTkp1O07eq7eibaz5Cf/2lG46iw7/YNLvMb0IkSEBfzQztbPLtObQ00pmttUVafZNnodE+1ZvoPiEYqJNg44e3V6nHYXcJjBCbrgxcYbdzQdM/T5A8Kon8B9JlGI/eFpOfwJQLwmg+wrLRWehANV92OYf/sbUJPoUUxkdMGyF8cRR8XQV2+82tPIrC/sdYEvDHDSFDoBKCM/vzWU/0ComYhcVaaZB5lO5iRatW7K2WHqhrBQ2dh52LSUHdnPjjvFxV4FHq8q2tEs9ArGvT+EBPa0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3fB9bE/r1WyjzR+vB2HCDSKLeolAsUy7kdQx1XnBN4=;
 b=aSHOvQtfPzYeK0rh3h8l8tDYfaRX/ESa6YkDWMiRtj34zfFEgqPGA9XEtZK2LOkdPHejVHDHKgCd8GQCprnmpFS8KS4+s/ew83Sd21UJJ5Llklnbc6bO2AqGyHM/qYLHa6QsvOvHRujHw8TRelzO5yf6SHsc8pwVWgGzUMT04ZrGqnCb1ONaMOsahc+7VSujT4k+83vFPFucw8i3jpyd28o88zLuP1RMq5mDy7b2tc0W+Aov7b8As1jk9MLjJYhunqx0yFQwo5FBrbRs66HKtNT5ZCzqfRVlX3rZUZD5MEGB/HF+GeBNOLkVs14MyOxGNAXQ4DVrJVRIM4L8fTEd4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY4PR11MB2005.namprd11.prod.outlook.com (2603:10b6:903:2e::18)
 by DM6PR11MB4516.namprd11.prod.outlook.com (2603:10b6:5:2a5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 12:25:17 +0000
Received: from CY4PR11MB2005.namprd11.prod.outlook.com
 ([fe80::ad04:c349:b06a:c1b4]) by CY4PR11MB2005.namprd11.prod.outlook.com
 ([fe80::ad04:c349:b06a:c1b4%9]) with mapi id 15.20.5813.020; Thu, 17 Nov 2022
 12:25:17 +0000
From:   "Schimpe, Christina" <christina.schimpe@intel.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
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
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: RE: [PATCH v3 35/37] x86/cet: Add PTRACE interface for CET
Thread-Topic: [PATCH v3 35/37] x86/cet: Add PTRACE interface for CET
Thread-Index: AQHY8J5eaXgH6xugZk20MwPZdy8SOK5AIA2AgACAkACAAnwdkA==
Date:   Thu, 17 Nov 2022 12:25:16 +0000
Message-ID: <CY4PR11MB2005AD47BA1D97BC1A96A769F9069@CY4PR11MB2005.namprd11.prod.outlook.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
         <20221104223604.29615-36-rick.p.edgecombe@intel.com>
         <Y3Olme4Nl+VOkjAH@hirez.programming.kicks-ass.net>
 <223bf306716f5eb68e4f9fd660414c84cddd9886.camel@intel.com>
In-Reply-To: <223bf306716f5eb68e4f9fd660414c84cddd9886.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR11MB2005:EE_|DM6PR11MB4516:EE_
x-ms-office365-filtering-correlation-id: 1d56de1c-9c11-4e9e-6c03-08dac896c902
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Ms4MfSzYGXpBXUwAxooPY0d9vzeXwvPzaXpaO/R4JzWsGdQLraFEUv7npQ810YUqze0Q95V2Ml6sPCbqci7O1pRcfiF7uMGiNFi3yaGXI6bDewfiY7UxONW8wCQBHJynUy8qYghZpZI8qCL+PmiD/YWwAmCgjbodVSa5hI6avVVYQBJXIEIFqSfL5B5W/fMrrYPWlpY/GKm8WTlDt+voc2wUtm3tePEzA/bRekqKmFfTNkxCVrD+A5UNNasedunQ8sMWZ0bGveMqYn5FbpdT9n2unigPMfgKg4QnV6Ksvf+lJgap2YWGMMOj/ipBWWjiNgfdXj/kD5fdtOMVfssnLPipaqf2HJLH2uwI++DvUpHtEv5/F5WCs7fB4W60qJKmhQ9rsn80Sx7d/7HZqW7k50mizpyxYfnAX9WshIWw7FQ+fKCsaX3g/RJ0f62S2I+wivFM6FLT4juFCDk/LZI+eYeUnPD/G27Sbg37r7V8lcTgNnteSJeAg7YscOsj2FTzHGfsVkudhnQo4xV8CCxh7FJuAf0tykrmGHVeZvPmYHg+LEVlVppKP8HvwJNYve7QsvSCQsi8WwlmNKe5wYNS6Q9Py2aPXVghIl+cmWWmwes8Oq0WfzSGbtkJUxseK9R1/6AsbGwHcZ3RnWVi0tPquJm2sOugjlsaCemN1sXTRoIpyYCq3h9EnggyQYOvZwNfX0FJM1ZUpHj+r6JQGmn3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB2005.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199015)(26005)(33656002)(83380400001)(38070700005)(86362001)(122000001)(38100700002)(82960400001)(7406005)(2906002)(55016003)(4001150100001)(186003)(9686003)(5660300002)(7416002)(478600001)(7696005)(110136005)(6506007)(52536014)(41300700001)(66556008)(54906003)(71200400001)(8936002)(66446008)(66476007)(8676002)(64756008)(76116006)(4326008)(66946007)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2FrS1MwV3lNVm51bUVNcDRjRk13K2hxaXRGRkllQ0lUbTRRS3hyYm0zMGFy?=
 =?utf-8?B?a2dtNEFmTWVheldSbUhSeWk1Mzk5eHZXWVF6TG0ydUFTd0lOWVpObFhIRVRm?=
 =?utf-8?B?bHFSY2diOXhONTdsZUhFRVZMNndxWVpsWEZZbHdWTC9pSlAySjFTYm9yQ1lo?=
 =?utf-8?B?QVArQ0o5M25Pd3hyYmVpc0g3bHZpb0didFJnZVgvMFRMaE1tTXlKUy9IWGoy?=
 =?utf-8?B?c3NiTk0yWUlkM2ZHUnNJRXUzOXFmd2FFK3hZMXlPeVMwT2RFbnF6ZmN0OUFt?=
 =?utf-8?B?b2s3cVVQU0g0WnNaNjlXaDhQQ0g4SksrVGR1UG8rRWxFWGVPZThSMmhXSkNY?=
 =?utf-8?B?N0UxcU1QbnljZzV3RUN6NEdpbWRucGVVTmM1YjlJbnBuOUp2cGhRUXNnTTJF?=
 =?utf-8?B?VjY2ZFdOU2hMN2RSOTlGckM2QjBrOHJVNHJXMk9sek9IcVVMMFUrTXNoMWkz?=
 =?utf-8?B?Yi9WZWVKVEwvdENxcGhpTHlic2pvNm5yNU94cGdBOVJLaG9SUFhTSXl3bSs3?=
 =?utf-8?B?bDNGdFBSYkt6UlhLWmZ2WS9sQkxWbDM2elRuaUdqY1E3ajB5RDRkQXc0dkE2?=
 =?utf-8?B?WXFEVFBrTml1QnM0N0QvTXVtWURNTWtObzQyR2oxSEpHSlc3VFgzRVNDeHBq?=
 =?utf-8?B?d0ttdVZvOUVYMVFMZ09qUmFxS1NNS2hsc1RKSHlkTDJQdElpaVRUUE50Q1pE?=
 =?utf-8?B?SlBJYzlVZ2NtbTR6ZExBRm0wUG1MRmVuM2pqK0NzSU5mbzRKTHhzbGJNMndB?=
 =?utf-8?B?RWUyc2lwbVg1eFpQb2tXWno1c01ST003YUpuRVBWZXNBblpwWG90TG9CL1ZF?=
 =?utf-8?B?V2dydk1FUmZGS1hJclE0N1B3WUlmK1A5RnZRbjJBam44RWs4c3I0cUFUMmE3?=
 =?utf-8?B?M3kzS1h5ZXFhVTBXUmVaZi9CSFpkd29OcmljdEVZcFp3aEk2YXBYM3ZXTzZs?=
 =?utf-8?B?cTN3RnIwMTRlMlhWM1VRM2RxNzdvbHlOaWdjUXdtSFBLSVpsc0dSK2ZaUW5I?=
 =?utf-8?B?VW5WN09aODJYUGxucmJxbjM0ZkhtbnErc01jb1V1VkoxcDJ2NnIzVFFEVU85?=
 =?utf-8?B?Rlk0R0JuMDBjNWhVclhVTFI3aVIyNEZOMm9mUzBjUjREVWNVMDFHWkdIZ2sr?=
 =?utf-8?B?dWxUZlAyY0lmQjZ3cmRSRGIxY2ZjSjBqMkI4bzZlYjAvNGlCY3FKQ0Z0bzZC?=
 =?utf-8?B?SldreWR0NGlwT2pzOC9GREZBSnA4YVRCU21KODJMQk5laTFSME1XYWlPak5X?=
 =?utf-8?B?VDNVUURqendoSU5DQll5ZUN3Q1Z0WnJVVTMxeHJkODhhOGo4ZlhGSVBoV081?=
 =?utf-8?B?anF3Z3BSR282UlRkVDhQREx6dEFwOVpBNGMyVUFQdW5Oa1h0NFBOd3hEM3NN?=
 =?utf-8?B?TDhTcFVwMTh6OWFyRmg4RXdzZ0hZaEVQNllwTVlvaDB3dG1GWWd4Y0lEVU8v?=
 =?utf-8?B?cFhqZG5Mb2ZTekM1WG9sbEJMZU1XSkxZUVVmRWFjbElqSHpLVU1YVS9mb2FT?=
 =?utf-8?B?WjliZGtyUnB4R2g3cVM2WDVTYXZqdFRBT1VvYUtjR2p0UUNBV08wNW44ajlZ?=
 =?utf-8?B?TGViYTRKaEh3R1REM1U5QWYrd0JKY1RkVXVRYVFZbDZVTms2UzB0WGRjWkR2?=
 =?utf-8?B?VGkrNWRUWjFSeXJ6ckU4Zzhkdm5mUlQzc0VGWHJCSHFXQjNVUG0yMmsvUngw?=
 =?utf-8?B?ekdaZEI4d2pLTkdQSjM2aWlLSGJudkdwUTBMb0pSM2ZPUEpoVitEOCswMkRF?=
 =?utf-8?B?S0dVQ25LdXVPUHN6TTE3Ty9vaC9Ea1RZOWZGUHlRaHlUanNCZkRYQnZKaHNq?=
 =?utf-8?B?MFE3R015T1lsaFIxKzJiT3cyWktOcmdwaytoalFEM1orL2lzZm5XU2NFM1hK?=
 =?utf-8?B?eFhBczZpamVyK1ZveHhINGU3dzJZUXA1NnVFL2pmaDAxNlM2QVNUNTVTTllk?=
 =?utf-8?B?bFJwUkRmTVB3YWQzQk1YT3pwTW1tMityeitqK1BHUTBkcGp0QXFPWEdmb2t1?=
 =?utf-8?B?ejB3eWJ1QnJNNDNoaFF3emdtU3V3VHZ2VGJUMGZWeklJNnlibUhxUzM5eUUz?=
 =?utf-8?B?TFZlbzRkc00rSnNDcm5vMmllYnU2S3NnaXRuMHpvOEtWTU96bTBrOGltdFE3?=
 =?utf-8?B?bjB1L2RYL294eG9MZGpLbitsZlAyVXRKUDByUHFWVnM5dVVGUVhtdGZwWFBC?=
 =?utf-8?B?WVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB2005.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d56de1c-9c11-4e9e-6c03-08dac896c902
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 12:25:16.9062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HEBed/KjpoDN9gD49tiVkMS++k7V5/4vhVLdN9ga86zRETJmsMDDvR2gjFcxIfYRhMGk4bV00I7K5Mcnco9BXy7qG9Jej5YUo4BodYVbL5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4516
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

PiArIENocmlzdGluYQ0KPiANCj4gT24gVHVlLCAyMDIyLTExLTE1IGF0IDE1OjQzICswMTAwLCBQ
ZXRlciBaaWpsc3RyYSB3cm90ZToNCj4gPiBPbiBGcmksIE5vdiAwNCwgMjAyMiBhdCAwMzozNjow
MlBNIC0wNzAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToNCj4gPiA+IEZyb206IFl1LWNoZW5nIFl1
IDx5dS1jaGVuZy55dUBpbnRlbC5jb20+DQo+ID4gPg0KPiA+ID4gU29tZSBhcHBsaWNhdGlvbnMg
KGxpa2UgR0RCIGFuZCBDUklVKSB3b3VsZCBsaWtlIHRvIHR3ZWFrIENFVCBzdGF0ZQ0KPiA+ID4g
dmlhIHB0cmFjZS4gVGhpcyBhbGxvd3MgZm9yIGV4aXN0aW5nIGZ1bmN0aW9uYWxpdHkgdG8gY29u
dGludWUgdG8NCj4gPiA+IHdvcmsgZm9yIHNlaXplZCBDRVQgYXBwbGljYXRpb25zLiBQcm92aWRl
IGFuIGludGVyZmFjZSBiYXNlZCBvbiB0aGUNCj4gPiA+IHhzYXZlIGJ1ZmZlciBmb3JtYXQgb2Yg
Q0VULCBidXQgZmlsdGVyIHVubmVlZGVkIHN0YXRlcyB0byBtYWtlIHRoZQ0KPiA+ID4ga2VybmVs
4oCZcyBqb2IgZWFzaWVyLg0KPiA+ID4NCj4gPiA+IFRoZXJlIGlzIGFscmVhZHkgcHRyYWNlIGZ1
bmN0aW9uYWxpdHkgZm9yIGFjY2Vzc2luZyB4c3RhdGUsIGJ1dCB0aGlzDQo+ID4gPiBkb2VzIG5v
dCBpbmNsdWRlIHN1cGVydmlzb3IgeGZlYXR1cmVzLiBTbyB0aGVyZSBpcyBub3QgYSBjb21wbGV0
ZWx5DQo+ID4gPiBjbGVhciBwbGFjZSBmb3Igd2hlcmUgdG8gcHV0IHRoZSBDRVQgc3RhdGUuIEFk
ZGluZyBpdCB0byB0aGUgdXNlcg0KPiA+ID4geGZlYXR1cmVzIHJlZ3NldCB3b3VsZCBjb21wbGlj
YXRlIHRoYXQgY29kZSwgYXMgaXQgY3VycmVudGx5IHNoYXJlcw0KPiA+ID4gbG9naWMgd2l0aCBz
aWduYWxzIHdoaWNoIHNob3VsZCBub3QgaGF2ZSBzdXBlcnZpc29yIGZlYXR1cmVzLg0KPiA+ID4N
Cj4gPiA+IERvbuKAmXQgYWRkIGEgZ2VuZXJhbCBzdXBlcnZpc29yIHhmZWF0dXJlIHJlZ3NldCBs
aWtlIHRoZSB1c2VyIG9uZSwNCj4gPiA+IGJlY2F1c2UgaXQgaXMgYmV0dGVyIHRvIG1haW50YWlu
IGZsZXhpYmlsaXR5IGZvciBvdGhlciBzdXBlcnZpc29yDQo+ID4gPiB4ZmVhdHVyZXMgdG8gZGVm
aW5lIHRoZWlyIG93biBpbnRlcmZhY2UuIEZvciBleGFtcGxlLCBhbiB4ZmVhdHVyZQ0KPiA+ID4g
bWF5IGRlY2lkZSBub3QgdG8gZXhwb3NlIGFsbCBvZiBpdOKAmXMgc3RhdGUgdG8gdXNlcnNwYWNl
LiBBIGxvdCBvZg0KPiA+ID4gZW51bSB2YWx1ZXMgcmVtYWluIHRvIGJlIHVzZWQsIHNvIGp1c3Qg
cHV0IGl0IGluIGRlZGljYXRlZCBDRVQNCj4gPiA+IHJlZ3NldC4NCj4gPiA+DQo+ID4gPiBUaGUg
b25seSBkb3duc2lkZSB0byBub3QgaGF2aW5nIGEgZ2VuZXJpYyBzdXBlcnZpc29yIHhmZWF0dXJl
DQo+ID4gPiByZWdzZXQsIGlzIHRoYXQgYXBwcyBuZWVkIHRvIGJlIGVubGlnaHRlbmVkIG9mIGFu
eSBuZXcgc3VwZXJ2aXNvcg0KPiA+ID4geGZlYXR1cmUgZXhwb3NlZCB0aGlzIHdheSAoaS5lLiB0
aGV5IGNhbuKAmXQgdHJ5IHRvIGhhdmUgZ2VuZXJpYw0KPiA+ID4gc2F2ZS9yZXN0b3JlIGxvZ2lj
KS4gQnV0IG1heWJlIHRoYXQgaXMgYSBnb29kIHRoaW5nLCBiZWNhdXNlIHRoZXkNCj4gPiA+IGhh
dmUgdG8gdGhpbmsgdGhyb3VnaCBlYWNoIG5ldyB4ZmVhdHVyZSBpbnN0ZWFkIG9mIGVuY291bnRl
cmluZw0KPiA+ID4gaXNzdWVzIHdoZW4gbmV3IGEgbmV3IHN1cGVydmlzb3IgeGZlYXR1cmUgd2Fz
IGFkZGVkLg0KPiA+DQo+ID4gUGVyIHRoaXMgYXJndW1lbnQgdGhpcyBzaG91bGQgbm90IHVzZSB0
aGUgQ0VUIFhTQVZFIGZvcm1hdCBhbmQgQ0VUDQo+ID4gbmFtZSBhdCBhbGwsIGJlY2F1c2UgdGhh
dCBjb25mbGF0ZXMgdGhlIHNpdHVhdGlvbiB2cyBJQlQuIEVuYWJsaW5nDQo+ID4gdGhhdCBtaWdo
dCBub3Qgd2FudCB0byBmb2xsb3cgdGhpcyBwcmVjZWRlbnQuDQo+IA0KPiBIbW0sIHdlIGRlZmlu
aXRlbHkgbmVlZCB0byBiZSBhYmxlIHRvIHNldCB0aGUgU1NQLiBDaHJpc3RpbmEsIGRvZXMgR0RC
IG5lZWQNCj4gYW55dGhpbmcgZWxzZT8gSSB0aG91Z2h0IG1heWJlIHRvZ2dsaW5nIFNIU1RLX0VO
Pw0KDQpJbiBhZGRpdGlvbiB0byB0aGUgU1NQLCB3ZSB3YW50IHRvIHdyaXRlIHRoZSBDRVQgc3Rh
dGUuIEZvciBpbnN0YW5jZSBmb3IgaW5mZXJpb3IgY2FsbHMsDQp3ZSB3YW50IHRvIHJlc2V0IHRo
ZSBJQlQgYml0cy4NCkhvd2V2ZXIsIHdlIHdvbid0IHdyaXRlIHN0YXRlcyB0aGF0IGFyZSBkaXNh
bGxvd2VkIGJ5IEhXLg0KSW50ZWwgRGV1dHNjaGxhbmQgR21iSApSZWdpc3RlcmVkIEFkZHJlc3M6
IEFtIENhbXBlb24gMTAsIDg1NTc5IE5ldWJpYmVyZywgR2VybWFueQpUZWw6ICs0OSA4OSA5OSA4
ODUzLTAsIHd3dy5pbnRlbC5kZSA8aHR0cDovL3d3dy5pbnRlbC5kZT4KTWFuYWdpbmcgRGlyZWN0
b3JzOiBDaHJpc3RpbiBFaXNlbnNjaG1pZCwgU2hhcm9uIEhlY2ssIFRpZmZhbnkgRG9vbiBTaWx2
YSAgCkNoYWlycGVyc29uIG9mIHRoZSBTdXBlcnZpc29yeSBCb2FyZDogTmljb2xlIExhdQpSZWdp
c3RlcmVkIE9mZmljZTogTXVuaWNoCkNvbW1lcmNpYWwgUmVnaXN0ZXI6IEFtdHNnZXJpY2h0IE11
ZW5jaGVuIEhSQiAxODY5MjgK

