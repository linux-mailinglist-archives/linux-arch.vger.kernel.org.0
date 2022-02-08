Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34264AE3FB
	for <lists+linux-arch@lfdr.de>; Tue,  8 Feb 2022 23:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387582AbiBHWZZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Feb 2022 17:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386422AbiBHU3a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Feb 2022 15:29:30 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF29C0612C0;
        Tue,  8 Feb 2022 12:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644352170; x=1675888170;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mMAVA69mm3DeTHBdIbEyDQJPfom2/Fk+1xMQC/7/tQE=;
  b=Q/xLFOk7D4JfOpTmI2jxirM+FXafnz/upLEj8apt37yOMPm+p4yRou/y
   AsB0HN3s6sIcRltE6GYqEDCIaysyhZWUgR+whEP00LDgGuZmdO7GSmbbv
   aodCnz1DMmVDlG9ezVUaKc/JmVz2nN1a/0e4pGIa6fhi/wwA6sPwtgqNr
   23bjmYj+eWyNYWOYwwLnTh8TfA9VTMp0dWsWfIuev1GByJ4HUHDuk4fZu
   4/OCHr7ut0StZ5jrJ3k/P2fv+cuP6WCOK9nmZwvW2CZNAfvvp0biNleB3
   kThv1FzGEjlIfpTC5BHi2oAZwuYGmVss4eEslriYqyAWJAEJwpV4b8AQ5
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="246632068"
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="246632068"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 12:29:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="585319891"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga008.fm.intel.com with ESMTP; 08 Feb 2022 12:29:29 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 8 Feb 2022 12:29:28 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 8 Feb 2022 12:29:28 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 8 Feb 2022 12:29:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ez6d2ACQCO6nIe0zMUclrZXYLM3OEyYi8fw2QecnG2mRqDlU1V7/mMkFOXtlGiR4r66mCkecj7l8TfSO/24TbJZ+NTDZyzC8iH9aLX9aZvKdNEiq8BjJAp6UMBWAxCHGFSQDmgc64uXUWFM/c8mZbTNZlJpLpfxzNVFPq/jH8YLdSPYfr7TX5RFtA24bK879ZMefQjHHP0eGkILRLiRYVGjqDdErCfJO65onSeaYs1NXKBzY71YR7tcrpKFK2/nFFmZwmyddde6iFK5S+9o/YmBq58y+dMD8Bsx4bW0bQgCr8QfKElxdp4mOfFrOVoD6zoExX1K2klD2TS7WCWSyuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMAVA69mm3DeTHBdIbEyDQJPfom2/Fk+1xMQC/7/tQE=;
 b=fEWCymhMPbmqpgH/9BopLcOy3uZsakiYZX8zFlY2hSBqu6jQQiGlzyWGYGa96coD8ODyygYVH44K1g08Iq4naCQ3ukBYUTG2UVSKYzE/STLn39EIiLMjDQDYuguQR10ofeLo0PjHsS08chtJXUmyV6ZGpr81Ocuj76zPPaEl5eSuJIsG9ORcT2flaatT/bd1icEsaGFdMywyEZjvZWjlrqNoL7/W4wajkx/PBgZrWqEXyXYfz81v4i9W+kVqri1Wb1Yqn9M4NnS3cLyQxsyOCbvy6tZPZOC+hp11D+iPfeRtTUsn1s0z9Ki6nJBS9UehEGIdBoSE3HySK0rrQpZNpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MWHPR11MB1774.namprd11.prod.outlook.com (2603:10b6:300:10a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 8 Feb
 2022 20:29:26 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15%4]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 20:29:25 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
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
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Subject: Re: [PATCH 04/35] x86/cpufeatures: Introduce CPU setup and option
 parsing for CET
Thread-Topic: [PATCH 04/35] x86/cpufeatures: Introduce CPU setup and option
 parsing for CET
Thread-Index: AQHYFh9okjytVKr1tU2DcWbGKpvDxayIvcGAgAFrHYA=
Date:   Tue, 8 Feb 2022 20:29:25 +0000
Message-ID: <62c16006934bd84f9394625a7a9440d927017d09.camel@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
         <20220130211838.8382-5-rick.p.edgecombe@intel.com>
         <d53abb4b-2459-e1f7-3b7f-a8017cdd3757@intel.com>
In-Reply-To: <d53abb4b-2459-e1f7-3b7f-a8017cdd3757@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b917cc7f-a31f-417a-c2b3-08d9eb41b31b
x-ms-traffictypediagnostic: MWHPR11MB1774:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR11MB17744ABDD559D00464C21D92C92D9@MWHPR11MB1774.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7LMhHoohE3thb+pwW/vsIXhDLrX5a4ddifXI7dSiLDbutZuVryBQwf4A6AxRerCd96GFnNDWuoY6HMgWRRNs1lXnq5pyUKCCe+0jX9sIZiSvrlFpH4u0t2A7pKjuGlAMW1j8qO8fvC1WEQdPBjyDlk9+H3/X6WNgD+HDAeNQi7wcOUxUNsDdEr3IYG0I2uLEMrv8xV70epG/SdNunCuO1OpjX4N00TPmBKlzTSLbbapTnIE0mEta0LjS/MBxX1eRymCrSzFY8sjxlwDpz1L6mBjrkZjXLyi0hJyJo26Eh2ft8Z3Yze5IKB7KIzC0vJTvmwo/od0hoV6k4WJRu4ZxDS2f7lc3y80sQnQRzUQDDKmHRp4q3IwVFRChTI1WoGIyuIFvGqZ4lSibtb3wIe2JwA88t7dG/Ne1+5Fl7ZRZNiez9CQO0L5x/tKYZDRGpsg/CZn+n74dpMZx4PTr+WZoCtB7nMgWsW3s783HyNM5QjO4zlaqCtnZVXV3NiuF1BACuhCfVZnCq+XeVwg6jqCyo2bLeTa/PlQaLmda47iOA39zAbgmppBFwGtUpNjptU/l+wW7jMPdjvr9agzmimgz387coCdd9CpLjn8AwJK9RgDS1A+t+qO0aYiqEUbso5ZlOyf90usugdyGuuyNdnN0ZyfE8ZvLC5gfG3xfa/jLEPX46T9qgDxCMKUQ+Z8cIconQrDfCPmsJNWEKCEd58Gh8AFf3J7WDzHKbfGJtDSNPg9ttVDE8iddpfCGZAl+5cH+iU6uQ3sp7fNT7jIgPk8MIt95F+G1PBPLD2FA8WxtMSUF+UyH5MSJQe8xrsrpFOhG8BBy3jma6EiwEEk1mpcpiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(36756003)(316002)(110136005)(86362001)(71200400001)(2906002)(6512007)(6506007)(4744005)(66946007)(66476007)(66556008)(966005)(66446008)(64756008)(8676002)(4326008)(6486002)(8936002)(921005)(76116006)(122000001)(26005)(186003)(7416002)(508600001)(7406005)(5660300002)(2616005)(38100700002)(82960400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjNjMkh0M1VFZDdzMGVoWGJtV2FMeVRhQ2F0c2Q0TW5Mb2NNTEY5V2JOUEdm?=
 =?utf-8?B?bXRUazAzaDg1TVZGY0R4ZHVJRDlMMWhYTUhaMGhHZ2U1NVZkbW1KeEk2ekEy?=
 =?utf-8?B?L0U2a0R5QkZLenpzaDdvL2o3SHBIb0Q1OFFtdGx3NjZkYnJGalFMU2ZXMTJa?=
 =?utf-8?B?WHpFLzMvVk1MWDhCSzhvVGR2QjBUSFZoSk1taktRNy9TL21BYy9GdXJkejdh?=
 =?utf-8?B?cXJweGJmYjNiUVlIU1RIWC9DVzYwNnNaZWQ2NE95QXYvT2NaalRtdmJiZnJQ?=
 =?utf-8?B?VkliYkhrdnF4SXdTSFhOVmdpY0g1WVF5ZXFYREc0YklSdWtSc1FlblMyTjVQ?=
 =?utf-8?B?aUcvbUJyTjZ2SXJ4K0Q5Tk5aeWNWbU51OWdSTHV3N2lMRnJibVQyeTdySHBL?=
 =?utf-8?B?c0sxQ3R6ZUdkbllPUGdlU0F4OHFZQTRiYTNyTWtNRThXNHhvTFZBYkZvcHRQ?=
 =?utf-8?B?OWtaTnlUQ1l1VDRJcWQ4bkpGbnVwT0pySDFzRGd1UnVlQnhUY3N6U3RqRXh3?=
 =?utf-8?B?d1huWFlBSjRQY0NpeEowNkowRzRiM2RnQllxbVBoYWRBT0duUS9tdXp0bENO?=
 =?utf-8?B?em5KZEZxUjRubWJLODlJRlNjZlh0S0RwNVdCRHdmaVlCUWN0NDJKZFM2Ukhs?=
 =?utf-8?B?THhiaGZmdUpOa091T3V4eFBGN2U4MVVmVGRVVU5oOFFVU3JHSExFdVNjNWl4?=
 =?utf-8?B?dEpCdUZjcUNXcFhvekk0aSt1UE8yUDE3bWxOazlsOEdGODdlNUc2M0FZNjU0?=
 =?utf-8?B?UWpFMC9xM0s3K2o1Y2wva0NkcUtQTk5CYVprYm5XQUdFVzhpam4yeGhsUFJu?=
 =?utf-8?B?cVhsZ1EzaDQ4aFFoVVg5K21RNW5WMzQ1eEVxV0tDZCtWOFpRaHpWK3JoOGRQ?=
 =?utf-8?B?bHd2Wm02cWVvZzRwM0UxcktCUlVNR21kUW80QVRXTUtWWmlOelJuWUROL1c3?=
 =?utf-8?B?eHgrRytyUFpXM1JWVkEvY2UwNUdRNGVXdERoem54TUZSdGpKTWdvZFJ6V0g3?=
 =?utf-8?B?YzkrQXZJMFZ5ZUlsZFNvMGt3dUFubUdPRU9CRDNtL2FUUFBWbkV4ZnRFa2dV?=
 =?utf-8?B?ZngwbE9rcTdEQzM5NHc3a29CdlhTODZicURibEZmQlBxeFJBY2t0Sk56ZHVI?=
 =?utf-8?B?SHpkUnRiVWtJUUhPRjIvSVRTa2s4ZHB3OEtyUE1KSmdDWndNMkhEUmtvSWdM?=
 =?utf-8?B?eTJuTDk2eFNFZGNtL3NxTVJPbXQ2Q1JOMDdHSzhLanhYRnVqZ2tSZDVXS0ZT?=
 =?utf-8?B?cUJkQ3FpQkdoTUVFV0ZlZmJxaXZYNGZZekNTY0liT0xZSXc2L0MxOVA4OEFT?=
 =?utf-8?B?aW5jSzNUVjJuM0txbFc2MG9CbllhbS9XZTE4Z0RhcWZMTU02dHNOMWNkTzlE?=
 =?utf-8?B?WjRiUU5IMTlaV2lwc0I0bGhzM0p6TEVYUFRYTTR4RHRZM0tYZms0emRobjdU?=
 =?utf-8?B?KzdYZUFUUktPWjZqWjRvMldadjhXOGVLVGE1Y3htS21vYnEzcnNJaWZLWGxH?=
 =?utf-8?B?UGloZmdYdWh2WkxBRFd2Nzc2cWpoc1B2ak4vOC9ZaUlwU0tkRk1PeFdMMVd0?=
 =?utf-8?B?Z08vajJtQmtUWUhobi90OXIxcHVWalgxTDlSd0l6MEJrcEREVHJNZGFUbjFh?=
 =?utf-8?B?RlczWVp5U0pickZtbFdkNGd3ZXBTeHRTOUQ5SzdISWlXem9lRUdGME02OHZ2?=
 =?utf-8?B?eHBtRnpxSElZVjVLV1VWZk03eStNRkxXMUpwMHlTekFLRE45OEdwSENqVm5h?=
 =?utf-8?B?MUNPNEdrTXNUNnRDclkvWW9pN3lLQlloSVc4bG1NV1BJc3diRXlyV3kxSU9q?=
 =?utf-8?B?R3U2T2VKSmEvbURjTFlPWSsxR2I0S2prQmE4YVR6di9zenZTcU5HVTVqYSs2?=
 =?utf-8?B?QlpRYlp5dGZKUUc2UWxvUGszYXBJT2NTUldtNThpR3VMV0NGdjFCRzdvd0lp?=
 =?utf-8?B?VTdvcStMN3oxV3FUSkZpMUdhUnFJdzZ2Z2UrZ1J3RjFZbjhzUnBmcFZSQytI?=
 =?utf-8?B?TUw2OVFGSWVxRHMreFZLWngyaGd6UHNoRkMyWkRaSG5oODViMmt2cHdkNmI4?=
 =?utf-8?B?dStwdmFOSTRYOThBTElLVlc1Z1V5ZWlwRmdKdUhKMDU0bE5Ec0xDWjdQQlBo?=
 =?utf-8?B?TWEyVlVYUTBsd0ZtRGI2dDJDaUQ5QzB6Y1hEZzRDZ1IvTjF5THlhRG5kR1Z1?=
 =?utf-8?B?eGZmTW83TzZ6V3RwUCtEWkJySEkzdXZWMFFiT2JxWjNheFgyV3ZkVXNpdHRS?=
 =?utf-8?Q?h9viRsPXzUJgP2c6UvKRTIayNzHFcbk8/CEOCL6Ooc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CCD35E02AA4D543807CFCE172BBFD89@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b917cc7f-a31f-417a-c2b3-08d9eb41b31b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 20:29:25.8259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CJL/T+T3NUDMX5fB+VGQyDbdocAbX8C4joNltaoHsKDr+44ywP/dGZzkb+F1eQk7pDktcP2hkcKR9UGwZLpYjW0FzCvH2oLLenpnRPHlK7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1774
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTAyLTA3IGF0IDE0OjQ5IC0wODAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
R2l2ZW4gdGhpczoNCj4gDQo+ICAgICAgICAgDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC8yMDIyMDEyNzExNTYyNi4xNDE3OS0yLWJwQGFsaWVuOC5kZS8NCj4gDQo+IEknZCBwcm9iYWJs
eSB5YW5rIHRoZSBjb21tYW5kLWxpbmUgb3B0aW9uIG91dCBvZiB0aGlzIHNlcmllcywgb3INCj4g
c3RpY2sNCj4gaXQgaW4gYSBzZXBhcmF0ZSBwYXRjaCB0aGF0IHlvdSB0YWNrIG9uIHRvIHRoZSBl
bmQuDQoNCk1ha2VzIHNlbnNlLiBJJ2xsIGNoYW5nZSB0aGUgZG9jcyB0byBwb2ludCBvdXQgZXhh
Y3RseSBob3cgdG8gdXNlIHRoaXMNCm5ldyBwYXJhbWV0ZXIgZm9yIHNoYWRvdyBzdGFjay4gSXQg
Y291bGQgY29tZSBpbiBoYW5keSBpZiBzb21lDQppbXBvcnRhbnQgc2VydmljZSBtaXNzIG1hcmtz
IGl0c2VsZiBhcyBzaGFkb3cgc3RhY2sgY2FwYWJsZSBhbmQNCmNvbXBsaWNhdGVzIGJvb3QuDQoN
ClRoYW5rcy4NCg==
