Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B0E4B32AE
	for <lists+linux-arch@lfdr.de>; Sat, 12 Feb 2022 03:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiBLCb1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Feb 2022 21:31:27 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiBLCbY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Feb 2022 21:31:24 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CD31E1;
        Fri, 11 Feb 2022 18:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644633079; x=1676169079;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=cZP1n+UmaOx7qQNT3/+cHNKfppkIWBfnFKHtoZxIKZU=;
  b=RmMEMxGxxwEfNuLuIFF3UXEB9tEENuBxeQDyQwMdTQ/RV8O2w1Yl9RkK
   ntVo57+TkVv5efR6BzJkSusmoafyQGCvXB6Zu+PDpaZElEP73C1j5uNQv
   2WsRegLqEnyTV1wqGIHoCKW8+W0/CKNMAtttE4x/xSbNurc2Yxv5v6ceG
   nmBnr2r185Y7eNRCgpvNaTU/Azue/VvZY4TUWFZHPQdwqwPoelkEHgMu2
   WOvvnIZfjX6iR390kRBNfZ7ko8JD4jYrcOJtZdwOBC2Dod9t3ZUyq+koh
   mNZVHwJEmEm5wNrrtLKSgq+tUKdNN82dGsjGrnaYOLDEtO2gbDW7oe2Ii
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="249595342"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="249595342"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 18:31:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="602538533"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 11 Feb 2022 18:31:18 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 11 Feb 2022 18:31:17 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 11 Feb 2022 18:31:17 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 11 Feb 2022 18:31:17 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 11 Feb 2022 18:31:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqnTtGcm/UMmYSxQV8Ke+AKfQTXUDUYPqjebt48wMTnveysv3fIvosDMcD6deeFxPxz/GXyfr8TZTkIuk3WgtDD6PQAkkSAW9qIpo7x05uXYe2u6YVLpX2okKYnaMPTyRgk+vQ0N55AFwVdoZDJCBm+divhdV7y8/nYw1PWDGYGKA2vjbF9czNB4KcPNvCvicB3lOF0xAAxKsHQs3FrvlFy0TopZ4oRpPnlrgf/Ht5xj2bLInK4yHXTsC3+hSUALcWAiuenz9YDL3DVhwsVL51tZyAaEnZpl8w2eiAEgxjl1fxhGSJFAh19ol6R0D25V8wdhROGD47kuSYpuJWYIZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZP1n+UmaOx7qQNT3/+cHNKfppkIWBfnFKHtoZxIKZU=;
 b=hIornE6c8RmTeCXUSyPJewc0OlzDLnjZQQSaQBdRbVCuTsXtCvAKhQ91zMxxuv/4r0PnlGb11FM7QhjPbAN6O2q/tHnVuSxm69IcAFBQ+SnBhEzWshzSOc+NYyoyGzAblb2U1RkzUgK8rZBlorjvcopkV8eYCMrWEXlUmagNWcI0atGi/xOqzAQAsvx2kAEauPkdsXaUiGp883c99+wQRPxHvmXmdUNBpFW7QkBlcTVOGODUVCHqKKiKf45dmPoRElo/Xi3ciQFSiuy944GAI0kBUVC9c1c0OkdTGAAnv2FRmur24ZEx2hjpRgyMgECGcPfM8fHrmH0BFZVoNJpMsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH0PR11MB5207.namprd11.prod.outlook.com (2603:10b6:510:32::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Sat, 12 Feb
 2022 02:31:14 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15%4]) with mapi id 15.20.4951.021; Sat, 12 Feb 2022
 02:31:14 +0000
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
Subject: Re: [PATCH 23/35] x86/fpu: Add helpers for modifying supervisor
 xstate
Thread-Topic: [PATCH 23/35] x86/fpu: Add helpers for modifying supervisor
 xstate
Thread-Index: AQHYFh92EZjQ/VnlK0C25cYFiAsOpayPIm2AgAAiiIA=
Date:   Sat, 12 Feb 2022 02:31:13 +0000
Message-ID: <7b2be3259a8f062f17048b1b6496a5303e49db46.camel@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
         <20220130211838.8382-24-rick.p.edgecombe@intel.com>
         <d22f9dfc-cb7b-94f6-8585-bb39ed04536b@intel.com>
In-Reply-To: <d22f9dfc-cb7b-94f6-8585-bb39ed04536b@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8032fe0b-8683-4285-2418-08d9edcfbd74
x-ms-traffictypediagnostic: PH0PR11MB5207:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <PH0PR11MB5207E2CB2CC059FCDD81E9E4C9319@PH0PR11MB5207.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NIt79nECrIXhk+EC7JoAGYvaVGVdb1HiNldjYVEiTtk8MzdPt4igGEb++S2jJyn8PQhnc3F0mQyzBttwbkQDvq+We7oJtf3Kdn+DPIsy4bJdQrj1uSAerMLaqjlV+7oQqXxtWOVPFOedLrj307z6ulZAK4UW6p2CyiF/m7RS84ylT91IFYepURk3T3kyz+FHCp2vMeoPVTKZtJMsY2lGqtyvCSCxQUSXGZSg7/N3g634zZU2NbwcBVXW/49izvMu7Z8w+IILfP04BMd/DnHmHz2ySjibBrczl+l4+AgR31ofgTnB/oWPKxXn6TtI7nh8vkkzndfqfIY7cF0NsS2bOahMRVVE/nk8Iurmn6woNrVCBnmzJg0srsqwiT2ok+VDpd5mFrAvSlSs7ba/DqfzA+INo17tRiDEB6417dsQXPv+fZtNAIkBCHF7qIzsWoGFuliTTfMbHjG2miSrYTacADo8aUb+++Ro2kKpWq7ftRs4vbEk3OgHJcbzHFU0IyXGUU8baXBaei7CWBTL7PAn92Sq2DLaJY7uDm5/vTKKg3dJiismcJPHCjSrnJ8lkVj4pIHlK2LtlWHvxwfL1/FX+OC2uNmAP7XJwRq1AX2QIJrWOKXJoFhAMSwmox0Y+5fHH/SI1EV0B+cBCFNw8i8ZiNqgx46e87uyHy95rKBXpZAGSQfK79sSrJv0EFIeRMarfbvHSY2GD/ig0DHtbNMD+fzRjHO/9uh0mQfsK/98REM3SiizENHNRu/0H4KMXfWb2XFIhJ1/RfYkxpfBHFZgxwFZGSJEE8sscSkb+AojNTSaCmO4LEwnxIMg9/E+JWJnIzW9XPUyXfqr9MXEau28+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(82960400001)(86362001)(966005)(38070700005)(921005)(6486002)(508600001)(122000001)(38100700002)(71200400001)(110136005)(76116006)(66946007)(7416002)(2616005)(316002)(36756003)(8676002)(83380400001)(8936002)(53546011)(6506007)(5660300002)(64756008)(66446008)(66476007)(66556008)(7406005)(26005)(2906002)(186003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0EzSkM4dFlDV2VocTFodmJWc2lyYnA3YVRHcUkyUTRNUTBLY0lwRUZ6Z2tO?=
 =?utf-8?B?Tml0VlBVM0V5R0pGaHZKaEw4alVuT2N6djhtSGFIb0tkbkd3TmREb0Vsb1FM?=
 =?utf-8?B?ZFNQeE02S0dBUWJFRkQ0RjJuUzFCbG5GODFZUGp2Z1pMckpOUVA3SjFTZVph?=
 =?utf-8?B?N3FiWEF4L2YzR0ZQYUQ3Vzg5aEhQSG5mMyt5Q2cwK0dZRk1CQTF2VHE1Q04r?=
 =?utf-8?B?VnBRUWIvWmp5Q2F6VUhUM0l1dnJuQWJVUG8xdXZRUmk1ZFpRL0J2NGtCZU9j?=
 =?utf-8?B?QTZZZW03NXRadmlDM2s2OGJMS3JSOXhXMkNmaGkrbDB6enFFK2R1N3RJM0g4?=
 =?utf-8?B?cTE5ODFlWUZvTDhsTStlMmFTUnZiRDQ4alNKMG5DZGJoOGhUdkl6K0RnQTBn?=
 =?utf-8?B?MFlla2dMNHJHT3U5c1RQUmttVmxmeWptRERkbmhuRE1NU29HaTNpNmhud2V1?=
 =?utf-8?B?TGVWNXgxZHNSUXhzSWFxYXk3a1NMdEllYWRrWTVsMWYwN3VkNVZBMVY0d1N6?=
 =?utf-8?B?UU9hamE5cGZQTWpCRHFPVFU0L1ZvS2lhQ1AxOURYVk5SUVN3aUdQMVYzR09S?=
 =?utf-8?B?WEhFdjJ3aXd6UFM5NUwrNVFsRTdZZlFwUjdMT25Dcmx4L1F5Y09rdzhNTEVH?=
 =?utf-8?B?b2dDSnY3cGFoOTVmYWwzOFkrWnlpQVczZFB1TkN2MUQ3RlZwdzYrZCsvRjlC?=
 =?utf-8?B?ZlVvbWV1NEpKZHVlT0RNRTFobDNuNm1QaWhlMHJSQkJydWd1RmFmdnNkSE1m?=
 =?utf-8?B?U25oY0lYNXUrdmE0OUlMUTg0WDNrLzA4ZzRKdTFsWnp6bE9CTXo0OVhCQk5Q?=
 =?utf-8?B?WTZmcVVZM3RwVFB0OVJ4elBuellPMW5tTTFHckhIdFFSK0dwS2pldjU5ZWk5?=
 =?utf-8?B?c1N5RXk2aFJNakl4d04vSHFVUCtGNEhOMERDTVgrYUJEajArcCtYaG1lK1ls?=
 =?utf-8?B?N0pIcHFzMzZ2ZFpENUQ2N1RCYXcyV2JqcFZOdDlkYTZBMTdEL3EvSC9zQmdw?=
 =?utf-8?B?YURzQU8raG5HcUI3eit0UkEwanliRmhPRTRZRWhBT3VFV2NqVEROcVFSVlA2?=
 =?utf-8?B?Q2ljVk1Oa1VFdW9FaEM3TXBoYzlQSENjbnFTbEJKV2VNWDNXRGNQM0c0ekhC?=
 =?utf-8?B?MUR3M3haWlhWK1hLQ2d2R0lBM2cvcVRzR2xBZW9ZQzVXNGlMUUYwKzVaNHRJ?=
 =?utf-8?B?bTdsWkJpbzBnRjdXZHdmdXkzL0hRZE1aVVV5QkFqdkppaDhUOTFVU3BEWUJL?=
 =?utf-8?B?R1E1K2lqZzFGSFpMUVFoK1loZ05zQ1FNcHFzeGk1ZDcyR0RrWW1wTEdBd1F1?=
 =?utf-8?B?c1Rwck9wQWYvYjdXS0VldTRteWMzNTRqTHk0Y3ZRSDJGajZwL0lFOW1SNkJV?=
 =?utf-8?B?UkY1NlJJTjRoTjJiS3d0bnk0Vms3TTJaUVF6T0IycWtOV2Q1cDV6bTZtVXFt?=
 =?utf-8?B?TDEzeWloblNLSHlkaDF5Rzdmdk9tRnRMNXozTmZSM2ExUUEzNkh3UmVwMFh3?=
 =?utf-8?B?dnN2U1NlU2FNZmZSRHFQZWZJVGRyZWp4TjU5OUtoRUVBYmpYZC9GMFAyMHRH?=
 =?utf-8?B?UHUyYzQ1UG1jeDBtcC9xMGxtRDhkWnFuMW5Xd3k3UFgySkgvR3ZqQm54ei9R?=
 =?utf-8?B?MzNyYkJONFV1ZzIxdXpXZXFIVTRSZ1RibTdYSDVHRVZxbWpPY3NXbEZBa040?=
 =?utf-8?B?VEJqbGlkTytWbWROblJlVE1JK2VHVDJUSUFxbzFrSVZVOWtVYTNEMkJYVFNC?=
 =?utf-8?B?S3ExdTEzWFEzZHB1bSt1OE4weXpKK2xiRFd2SEcvNmdjNHJVbHEva21DbjBt?=
 =?utf-8?B?bjg1akNNSUg1UmJJQ0JlZXRYdDg4Zk14SkRYVnVzNEdrbTFjanBnVklMKzJU?=
 =?utf-8?B?WmN4Z0U2UEsxdC9xZ3JJS0I3RllhVEVUbzFEb0JvYk40SEFKbzZ5UmFDeThL?=
 =?utf-8?B?djR0WVROMTVSRys1OUhmVkQyVjFUVEVkUVZicktKbzJlcjBYamxaREF3RmYy?=
 =?utf-8?B?bnBzVC81REdmRU1XZGZNa0VaYXl4NmROZm1kc0VRMlRTWFNFWEtRZ3NNODcv?=
 =?utf-8?B?dWxFbnJiV3EwbzVCcjQvbXdVcXZicE1RME00RFkwMEQ3MmRWNzV5UFhLaEFi?=
 =?utf-8?B?Mm5IR2p2NkJ0VEtYY1lMd2g0a0daZk93a1hCV0RWdyt6KzJkTk9wNUp3bzZO?=
 =?utf-8?B?Q1ZYMW01TEJxQzIwL2FDdGVRRXRPV2oySnJNcW5hUUhjeXl1TkoxMjdkQ3hO?=
 =?utf-8?Q?F5e+ahYcfnFoRYJScCc/5ikis9/7RIvn7j1bXeN0YQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <024A4674897714489BDE7B4EDA07E927@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8032fe0b-8683-4285-2418-08d9edcfbd74
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2022 02:31:13.9966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eLaMaEc1o6HIPLvazHNPQTgquXUBUkoBmZf1L+CqE8aRxR+FrJsOUh8nbyO9iD8R8zGmQ4JZ7cSVV/eWgjG8y9/eyviv7sT2aXjL6sZPNnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5207
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIyLTAyLTExIGF0IDE2OjI3IC0wODAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gMS8zMC8yMiAxMzoxOCwgUmljayBFZGdlY29tYmUgd3JvdGU6DQo+ID4gQWRkIGhlbHBlcnMg
dGhhdCBjYW4gYmUgdXNlZCB0byBtb2RpZnkgc3VwZXJ2aXNvciB4c3RhdGUgc2FmZWx5IGZvcg0K
PiA+IHRoZQ0KPiA+IGN1cnJlbnQgdGFzay4NCj4gDQo+IFRoaXMgc2hvdWxkIGJlIGF0IHRoZSBl
bmQgb2YgdGhlIGNoYW5nZWxvZy4NCg0KSG1tLCBvay4NCg0KPiANCj4gPiBTdGF0ZSBmb3Igc3Vw
ZXJ2aXNvcnMgeHN0YXRlIGJhc2VkIGZlYXR1cmVzIGNhbiBiZSBsaXZlIGFuZA0KPiA+IGFjY2Vz
c2VzIHZpYSBNU1Incywgb3Igc2F2ZWQgaW4gbWVtb3J5IGluIGFuIHhzYXZlIGJ1ZmZlci4gV2hl
biB0aGUNCj4gPiBrZXJuZWwgbmVlZHMgdG8gbW9kaWZ5IHRoaXMgc3RhdGUgaXQgbmVlZHMgdG8g
YmUgc3VyZSB0byBvcGVyYXRlIG9uDQo+ID4gaXQNCj4gPiBpbiB0aGUgcmlnaHQgcGxhY2UsIHNv
IHRoZSBtb2RpZmljYXRpb25zIGRvbid0IGdldCBjbG9iYmVyZWQuDQo+IA0KPiBXZSB0ZW5kIHRv
IGNhbGwgdGhlc2UgInN1cGVydmlzb3IgeGZlYXR1cmVzIi4gIFRoZSAic3RhdGUgaXMgaW4gdGhl
DQo+IHJlZ2lzdGVycyIgd2UgY2FsbCAiYWN0aXZlIi4gIE1heWJlOg0KPiANCj4gCUp1c3QgbGlr
ZSB1c2VyIHhmZWF0dXJlcywgc3VwZXJ2aXNvciB4ZmVhdHVyZXMgY2FuIGJlIGVpdGhlcg0KPiAJ
YWN0aXZlIGluIHRoZSByZWdpc3RlcnMgb3IgaW5hY3RpdmUgYW5kIHByZXNlbnQgaW4gdGhlIHRh
c2sgRlBVDQo+IAlidWZmZXIuICBJZiB0aGUgcmVnaXN0ZXJzIGFyZSBhY3RpdmUsIHRoZSByZWdp
c3RlcnMgY2FuIGJlDQo+IAltb2RpZmllZCBkaXJlY3RseS4gIElmIHRoZSByZWdpc3RlcnMgYXJl
IG5vdCBhY3RpdmUsIHRoZQ0KPiAJbW9kaWZpY2F0aW9uIG11c3QgYmUgcGVyZm9ybWVkIG9uIHRo
ZSB0YXNrIEZQVSBidWZmZXIuDQoNCk9rLCB0aGFua3MuDQoNCj4gDQo+IA0KPiA+IEluIHRoZSBw
YXN0IHN1cGVydmlzb3IgeHN0YXRlIGZlYXR1cmVzIGhhdmUgdXNlZCBnZXRfeHNhdmVfYWRkcigp
DQo+ID4gZGlyZWN0bHksIGFuZCBwZXJmb3JtZWQgb3BlbiBjb2RlZCBsb2dpYyBoYW5kbGUgb3Bl
cmF0aW5nIG9uIHRoZQ0KPiA+IHNhdmVkDQo+ID4gc3RhdGUgY29ycmVjdGx5LiBUaGlzIGhhcyBw
b3NlZCB0d28gcHJvYmxlbXM6DQo+ID4gIDEuIEl0IGhhcyBsb2dpYyB0aGF0IGhhcyBiZWVuIGdv
dHRlbiB3cm9uZyBtb3JlIHRoYW4gb25jZS4NCj4gPiAgMi4gVG8gcmVkdWNlIGNvZGUsIGxlc3Mg
Y29tbW9uIHBhdGgncyBhcmUgbm90IG9wdGltaXplZC4NCj4gPiBEZXRlcm1pbmF0aW9uDQo+IA0K
PiAJCQkgICAicGF0aHMiIF4NCj4gDQoNCkFyZywgdGhhbmtzLg0KDQo+IA0KPiA+IHhzdGF0ZSA9
IHN0YXJ0X3VwZGF0ZV94c2F2ZV9tc3JzKFhGRUFUVVJFX0ZPTyk7DQo+ID4gciA9IHhzYXZlX3Jk
bXNybChzdGF0ZSwgTVNSX0lBMzJfRk9PXzEsICZ2YWwpDQo+ID4gaWYgKHIpDQo+ID4gCXhzYXZl
X3dybXNybChzdGF0ZSwgTVNSX0lBMzJfRk9PXzIsIEZPT19FTkFCTEUpOw0KPiA+IGVuZF91cGRh
dGVfeHNhdmVfbXNycygpOw0KPiANCj4gVGhpcyBsb29rcyBPSy4gIEknbSBub3QgdGhyaWxsZWQg
YWJvdXQgaXQuICBUaGUNCj4gc3RhcnRfdXBkYXRlX3hzYXZlX21zcnMoKSBjYW4gcHJvYmFibHkg
ZHJvcCB0aGUgIl9tc3JzIi4gIE1heWJlOg0KPiANCj4gCXN0YXJ0X3hmZWF0dXJlX3VwZGF0ZSgu
Li4pOw0KDQpIbW0sIHRoaXMgd2hvbGUgdGhpbmcgcHJldGVuZHMgdG8gYmUgdXBkYXRpbmcgTVNS
cywgd2hpY2ggaXMgb2Z0ZW4gbm90DQp0cnVlLiBNYXliZSB0aGUgeHNhdmVfcmRtc3JsL3hzYXZl
X3dybXNybCBzaG91bGQgYmUgcmVuYW1lZCB0b28uDQp4c2F2ZV9yZWFkbCgpL3hzYXZlX3dyaXRl
bCgpIG9yIHNvbWV0aGluZy4NCg0KPiANCj4gQWxzbywgaWYgeW91IGhhdmUgdG8gZG8gdGhlIGFk
ZHJlc3MgbG9va3VwIGluIHhzYXZlX3JkbXNybCgpIGFueXdheSwNCj4gSQ0KPiB3b25kZXIgaWYg
dGhlICd4c3RhdGUnIHNob3VsZCBqdXN0IGJlIGEgZnVsbCBmbGVkZ2VkICdzdHJ1Y3QNCj4geHJl
Z3Nfc3RhdGUnLg0KPiANCj4gVGhlIG90aGVyIG9wdGlvbiB3b3VsZCBiZSB0byBtYWtlIGEgbGl0
dGxlIG9uLXN0YWNrIHN0cnVjdHVyZSBsaWtlOg0KPiANCj4gCXN0cnVjdCB4c2F2ZV91cGRhdGUg
ew0KPiAJCWludCBmZWF0dXJlOw0KPiAJCXN0cnVjdCB4cmVnc19zdGF0ZSAqeHJlZ3M7DQo+IAl9
Ow0KPiANCj4gVGhlbiB5b3UgZG86DQo+IA0KPiAJc3RydWN0IHhzYXZlX3VwZGF0ZSB4c3U7DQo+
IAkuLi4NCj4gCXN0YXJ0X3VwZGF0ZV94c2F2ZV9tc3JzKCZ4c3UsIFhGRUFUVVJFX0ZPTyk7DQo+
IA0KPiBhbmQgdGhlbiBwYXNzIGl0IGFsb25nIHRvIGVhY2ggb2YgdGhlIG90aGVyIG9wZXJhdGlv
bnM6DQo+IA0KPiAJciA9IHhzYXZlX3JkbXNybCh4c3UsIE1TUl9JQTMyX0ZPT18xLCAmdmFsKQ0K
PiANCj4gSXQncyBzbGlnaHRseSBsZXNzIGxpa2VseSB0byBnZXQgdHlwZSBjb25mdXNlZCBhcyBh
ICd2b2lkIConOw0KDQpUaGUgJ3ZvaWQgKicgaXMgYWN0dWFsbHkgYSBwb2ludGVyIHRvIHRoZSBz
cGVjaWZpYyB4ZmVhdHVyZSBpbiB0aGUNCmJ1ZmZlci4gU28gdGhlIHJlYWQvd3JpdGVzIGRvbid0
IGhhdmUgdG8gcmUtY29tcHV0ZSB0aGUgb2Zmc2V0IGV2ZXJ5DQp0aW1lLiBJdCdzIG5vdCB0b28g
bXVjaCB3b3JrIHRob3VnaC4gSSdtIHJlYWxseSBzdXJwcmlzZWQgYnkgdGhlIGRlc2lyZQ0KdG8g
b2JmdXNjYXRlIHRoZSBwb2ludGVyLCBidXQgSSBndWVzcyBpZiB3ZSByZWFsbHkgd2FudCB0bywg
SSdkIHJhdGhlcg0KZG8gdGhhdCBhbmQga2VlcCB0aGUgcmVndWxhciByZWFkL3dyaXRlIG9wZXJh
dGlvbnMuDQoNCklmIHdlIGRvbid0IGNhcmUgYWJvdXQgdGhlIGV4dHJhIGxvb2t1cHMgdGhpcyBj
YW4gdG90YWxseSBkcm9wIHRoZQ0KY2FsbGVyIHNpZGUgc3RhdGUuIFRoZSBmZWF0dXJlIG5yIGNh
biBiZSBsb29rZWQgdXAgZnJvbSB0aGUgTVNSIGFsb25nDQp3aXRoIHRoZSBzdHJ1Y3Qgb2Zmc2V0
LiBUaGVuIGl0IGRvZXNuJ3QgZXhwb3NlIHRoZSBwb2ludGVyIHRvIHRoZQ0KYnVmZmVyLCBzaW5j
ZSBpdCdzIGFsbCByZWNvbXB1dGVkIGV2ZXJ5IG9wZXJhdGlvbi4NCg0KU28gbGlrZToNCnN0YXJ0
X3hmZWF0dXJlX3VwZGF0ZSgpOw0KciA9IHhzYXZlX3JlYWRsKE1TUl9JQTMyX0ZPT18xLCAmdmFs
KQ0KaWYgKHIpDQogICAgICAgIHhzYXZlX3dyaXRlbChNU1JfSUEzMl9GT09fMiwgRk9PX0VOQUJM
RSk7DQplbmRfeGZlYXR1cmVfdXBkYXRlKCk7DQoNClRoZSBXQVJOcyB0aGVuIGhhcHBlbiBpbiB0
aGUgcmVhZC93cml0ZXMuIEFuIGVhcmx5IGl0ZXJhdGlvbiBsb29rZWQNCmxpa2UgdGhhdC4gSSBs
aWtlZCB0aGlzIHZlcnNpb24gd2l0aCBjYWxsZXIgc2lkZSBzdGF0ZSwgYnV0IHRob3VnaHQgaXQN
Cm1pZ2h0IGJlIHdvcnRoIHJldmlzaXRpbmcgaWYgdGhlcmUgcmVhbGx5IGlzIGEgc3Ryb25nIGRl
c2lyZSB0byBoaWRlDQp0aGUgcG9pbnRlci4NCg0KPiANCj4gPiArc3RhdGljIHU2NCAqX19nZXRf
eHNhdmVfbWVtYmVyKHZvaWQgKnhzdGF0ZSwgdTMyIG1zcikNCj4gPiArew0KPiA+ICsJc3dpdGNo
IChtc3IpIHsNCj4gPiArCS8qIEN1cnJlbnRseSB0aGVyZSBhcmUgbm8gTVNSJ3Mgc3VwcG9ydGVk
ICovDQo+ID4gKwlkZWZhdWx0Og0KPiA+ICsJCVdBUk5fT05DRSgxLCAieDg2L2ZwdTogdW5zdXBw
b3J0ZWQgeHN0YXRlIG1zciAoJXUpXG4iLA0KPiA+IG1zcik7DQo+ID4gKwkJcmV0dXJuIE5VTEw7
DQo+ID4gKwl9DQo+ID4gK30NCj4gDQo+IEp1c3QgdG8gZ2V0IGFuIGlkZWEgd2hhdCB0aGlzIGlz
IGRvaW5nLCBpdCdzIE9LIHRvIGluY2x1ZGUgdGhlIHNoYWRvdw0KPiBzdGFjayBNU1JzIGluIGhl
cmUuDQoNCk9rLg0KDQo+IA0KPiBBcmUgeW91IHN1cmUgdGhpcyBzaG91bGQgcmV0dXJuIGEgdTY0
Kj8gIFdlIGhhdmUgbG90cyBvZiA8PTY0LWJpdA0KPiBYU0FWRQ0KPiBmaWVsZHMuDQoNCkkgdGhv
dWdodCBpdCBzaG91bGQgb25seSBiZSB1c2VkIHdpdGggNjQgYml0IG1zcnMuIE1heWJlIGl0IG5l
ZWRzIGENCmJldHRlciBuYW1lPw0KDQo+IA0KPiA+ICsvKg0KPiA+ICsgKiBSZXR1cm4gYSBwb2lu
dGVyIHRvIHRoZSB4c3RhdGUgZm9yIHRoZSBmZWF0dXJlIGlmIGl0IHNob3VsZCBiZQ0KPiA+IHVz
ZWQsIG9yIE5VTEwNCj4gPiArICogaWYgdGhlIE1TUnMgc2hvdWxkIGJlIHdyaXR0ZW4gdG8gZGly
ZWN0bHkuIFRvIGRvIHRoaXMgc2FmZWx5LA0KPiA+IHVzaW5nIHRoZQ0KPiA+ICsgKiBhc3NvY2lh
dGVkIHJlYWQvd3JpdGUgaGVscGVycyBpcyByZXF1aXJlZC4NCj4gPiArICovDQo+ID4gK3ZvaWQg
KnN0YXJ0X3VwZGF0ZV94c2F2ZV9tc3JzKGludCB4ZmVhdHVyZV9ucikNCj4gPiArew0KPiA+ICsJ
dm9pZCAqeHN0YXRlOw0KPiA+ICsNCj4gPiArCS8qDQo+ID4gKwkgKiBmcHJlZ3NfbG9jaygpIG9u
bHkgZGlzYWJsZXMgcHJlZW1wdGlvbiAobW9zdGx5KS4gU28gbW9kaWZpbmcNCj4gPiBzdGF0ZQ0K
PiANCj4gCQkJCQkJCSBtb2RpZnlpbmcgXg0KPiAJDQo+ID4gKwkgKiBpbiBhbiBpbnRlcnJ1cHQg
Y291bGQgc2NyZXcgdXAgc29tZSBpbiBwcm9ncmVzcyBmcHJlZ3MNCj4gPiBvcGVyYXRpb24sDQo+
IA0KPiAJCQkJCQleIGluLXByb2dyZXNzDQoNCkkgc3dlYXIgSSByYW4gY2hlY2twYXRjaC4uLg0K
DQo+IA0KPiA+ICsJICogYnV0IGFwcGVhciB0byB3b3JrLiBXYXJuIGFib3V0IGl0Lg0KPiA+ICsJ
ICovDQo+ID4gKwlXQVJOX09OX09OQ0UoIWluX3Rhc2soKSk7DQo+ID4gKwlXQVJOX09OX09OQ0Uo
Y3VycmVudC0+ZmxhZ3MgJiBQRl9LVEhSRUFEKTsNCj4gDQo+IFRoaXMgbWlnaHQgYWxzbyBiZSBh
IGdvb2Qgc3BvdCB0byBjaGVjayB0aGF0IHhmZWF0dXJlX25yIGlzIGluDQo+IGZwc3RhdGUueGZl
YXR1cmVzLg0KDQpIbW0sIGdvb2QgaWRlYS4NCg0KPiANCj4gPiArCWZwcmVnc19sb2NrKCk7DQo+
ID4gKw0KPiA+ICsJZnByZWdzX2Fzc2VydF9zdGF0ZV9jb25zaXN0ZW50KCk7DQo+ID4gKw0KPiA+
ICsJLyoNCj4gPiArCSAqIElmIHRoZSByZWdpc3RlcnMgZG9uJ3QgbmVlZCB0byBiZSByZWxvYWRl
ZC4gR28gYWhlYWQgYW5kDQo+ID4gb3BlcmF0ZSBvbiB0aGUNCj4gPiArCSAqIHJlZ2lzdGVycy4N
Cj4gPiArCSAqLw0KPiA+ICsJaWYgKCF0ZXN0X3RocmVhZF9mbGFnKFRJRl9ORUVEX0ZQVV9MT0FE
KSkNCj4gPiArCQlyZXR1cm4gTlVMTDsNCj4gPiArDQo+ID4gKwl4c3RhdGUgPSBnZXRfeHNhdmVf
YWRkcigmY3VycmVudC0+dGhyZWFkLmZwdS5mcHN0YXRlLQ0KPiA+ID5yZWdzLnhzYXZlLCB4ZmVh
dHVyZV9ucik7DQo+ID4gKw0KPiA+ICsJLyoNCj4gPiArCSAqIElmIHJlZ3MgYXJlIGluIHRoZSBp
bml0IHN0YXRlLCB0aGV5IGNhbid0IGJlIHJldHJpZXZlZCBmcm9tDQo+ID4gKwkgKiBpbml0X2Zw
c3RhdGUgZHVlIHRvIHRoZSBpbml0IG9wdGltaXphdGlvbiwgYnV0IGFyZSBub3QNCj4gPiBuZXNz
YXJpbHkNCj4gDQo+IAkJCQkJCQluZWNlc3NhcmlseSBeDQoNCk9vZiwgdGhhbmtzLg0KDQo+IA0K
PiBTcGVsbCBjaGVja2VyIHRpbWUuICAiOnNldCBzcGVsbCIgaW4gdmltIHdvcmtzIGZvciBtZSBu
aWNlbHkuDQo+IA0KPiA+ICsJICogemVyby4gVGhlIG9ubHkgb3B0aW9uIGlzIHRvIHJlc3RvcmUg
dG8gbWFrZSBldmVyeXRoaW5nIGxpdmUNCj4gPiBhbmQNCj4gPiArCSAqIG9wZXJhdGUgb24gcmVn
aXN0ZXJzLiBUaGlzIHdpbGwgY2xlYXIgVElGX05FRURfRlBVX0xPQUQuDQo+ID4gKwkgKg0KPiA+
ICsJICogT3RoZXJ3aXNlLCBpZiBub3QgaW4gdGhlIGluaXQgc3RhdGUgYnV0IFRJRl9ORUVEX0ZQ
VV9MT0FEIGlzDQo+ID4gc2V0LA0KPiA+ICsJICogb3BlcmF0ZSBvbiB0aGUgYnVmZmVyLiBUaGUg
cmVnaXN0ZXJzIHdpbGwgYmUgcmVzdG9yZWQgYmVmb3JlDQo+ID4gZ29pbmcNCj4gPiArCSAqIHRv
IHVzZXJzcGFjZSBpbiBhbnkgY2FzZSwgYnV0IHRoZSB0YXNrIG1pZ2h0IGdldCBwcmVlbXB0ZWQN
Cj4gPiBiZWZvcmUNCj4gPiArCSAqIHRoZW4sIHNvIHRoaXMgcG9zc2libHkgc2F2ZXMgYW4geHNh
dmUuDQo+ID4gKwkgKi8NCj4gPiArCWlmICgheHN0YXRlKQ0KPiA+ICsJCWZwcmVnc19yZXN0b3Jl
X3VzZXJyZWdzKCk7DQo+IA0KPiBXb24ndCBmcHJlZ3NfcmVzdG9yZV91c2VycmVncygpIGVuZCB1
cCBzZXR0aW5nIFRJRl9ORUVEX0ZQVV9MT0FEPTA/DQo+IElzbid0IHRoYXQgYSBjYXNlIHdoZXJl
IGEgInJldHVybiBOVUxMIiBpcyBuZWVkZWQ/DQoNClRoaXMgaXMgZm9yIHRoZSBjYXNlIHdoZW4g
dGhlIGZlYXR1cmUgaXMgaW4gdGhlIGluaXQgc3RhdGUuIEZvciBDRVQncyANCmNhc2UgdGhpcyBj
b3VsZCBqdXN0IHplcm8gdGhlIGJ1ZmZlciBhbmQgcmV0dXJuIHRoZSBwb2ludGVyIHRvIGl0LCBi
dXQNCmZvciBvdGhlciBmZWF0dXJlcyB0aGUgaW5pdCBzdGF0ZSB3YXNuJ3QgYWx3YXlzIHplcm8u
IFNvIHRoaXMganVzdA0KbWFrZXMgYWxsIHRoZSBmZWF0dXJlcyAiYWN0aXZlIiBhbmQgVElGX05F
RURfRlBVX0xPQUQgaXMgY2xlYXJlZC4gSXQNCnRoZW4gcmV0dXJucyBOVUxMIGFuZCB0aGUgcmVh
ZC93cml0ZXMgZ28gdG8gdGhlIE1TUnMuIEl0IHN0aWxsIGxvb2tzDQpjb3JyZWN0IHRvIG1lLCBh
bSBJIG1pc3Npbmcgc29tZXRoaW5nPw0KDQo+IA0KPiBJbiBhbnkgY2FzZSwgdGhpcyBtYWtlcyBt
ZSB0aGluayB0aGlzIGNvZGUgc2hvdWxkIHN0YXJ0IG91dCBzdHVwaWQNCj4gYW5kDQo+IHNsb3cu
ICBLZWVwIHRoZSBBUEkgYXMtaXMsIGJ1dCBtYWtlIHRoZSBmaXJzdCBwYXRjaCB1bmNvbmRpdGlv
bmFsbHkNCj4gZG8NCj4gdGhlIFdSTVNSLiAgTGVhdmUgdGhlICJmYXN0IiBidWZmZXIgbW9kaWZp
Y2F0aW9ucyBmb3IgYSBmb2xsb3ctb24NCj4gcGF0Y2guDQoNCk9rLiBTaG91bGQgSSBkcm9wIHRo
ZSBvcHRpbWl6ZWQgdmVyc2lvbnMgZnJvbSB0aGUgc2VyaWVzIG9yIGp1c3Qgc3BsaXQNCnRoZW0g
b3V0PyBUaGUgb3B0aW1pemF0aW9ucyB3ZXJlIHRyeWluZyB0byBhZGRyZXNzIEJvcmlzJyBjb21t
ZW50czoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvWVM5NVZ6ck5oRGhGcHNvcEB6bi50
bmljLw0KDQo=
