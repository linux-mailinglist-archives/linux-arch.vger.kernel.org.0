Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66FE6B2BBA
	for <lists+linux-arch@lfdr.de>; Thu,  9 Mar 2023 18:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjCIRMD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Mar 2023 12:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjCIRLg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Mar 2023 12:11:36 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FE959D8;
        Thu,  9 Mar 2023 09:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678381743; x=1709917743;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=721GW4MKO03M0z47t3YnUvuWglacwqg9zpqA5sE3EW4=;
  b=BKMGXwRt37kVopKcO92x49VkZ/xfU6YFniZEcCijjaRjiZU3pPLTbEsL
   u+W00bJr3MY96munuGl1WZTpJ8lobuyddcvrPw9K6lMF2Zoca4rRq3AkD
   7+Bma0FD6qYZ40AmvVbtji2qtzsDlD5GnidKVpAJAkMJq/uczlahPU1AG
   EocSRecnnAEQjNqn0D9QLAlck9EGRSp9xUQSL86pEWv/rNsOOrblR5r22
   9Wii8/w0dqLPYmZoM+RLObH9X6kmMVf5+TC9DZeODXWDUininLUcpdCB5
   PM8e6miR3b5BzOTO24146v1UVb9BOlpffbEppmwHn78dx1uPwXuUsHjaf
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="364146214"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="364146214"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 09:03:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="670818324"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="670818324"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 09 Mar 2023 09:03:55 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 9 Mar 2023 09:03:54 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 9 Mar 2023 09:03:54 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 9 Mar 2023 09:03:54 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 9 Mar 2023 09:03:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jH3oxdBT4tHTQCX/3NBFxdD3y1wBF0PR2CFUodztumEYPSaSp9X6XG4y8XtkuI4mBsNeR5+n6K6yvFLgGO2qaZDbc/dEEzbpOXEVq2EzmLQGMGMZRBuyoDh4c9ma5mwpSuSvUCd3zla2Idp4gvp9ogD66tpMfj9O3WYvtHVxR1yTfUelO8kHA/KDxbNCqNvM/ha/YfTAUl/UMXy7Uv3mlCtX8AJQO9oA+CFgksF6KR/6CWMo+ylhHApd1OGvocmb44WFgHI0boM+4KWmimkMnSEo2WFA0Rpf02lq3t5bqIqQyAK5zHxdhZDylHFXTsnDK6L4VsRDid6j0m5xaUs9ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=721GW4MKO03M0z47t3YnUvuWglacwqg9zpqA5sE3EW4=;
 b=IoHvmqTQKRZ32VALmmFshq8Cgxb9UVtBn1hNsPBBMz0PrDTd75WDL7a/iJjvRkCzLDE97OfqSmn4x8iuRS66/StmpvKfM2IMNVHE8qX9smMb+Gf/PqtubHqZHQTS+sQztQu46b9N3VcbwvCOEO4dwcXFkPGIyD6O1B4m+nxdPm4i/4q4O83mNd5Cp86tZG0dbCM1zU6CHsaxGiUPaY4yvxztHQWD+cFzXNGduGkC8cskLI7wwRiF5LIucmmpVl/2VT7/ByqyHM5QJXxA3xAyxCSN6EyOv3WcaTRMTqowPmh2eKgJEAIDpc8q+Pb4dmjCa50OewcGSjg13Ttr8aoRUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BY1PR11MB8078.namprd11.prod.outlook.com (2603:10b6:a03:52a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Thu, 9 Mar
 2023 17:03:26 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 17:03:26 +0000
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
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v7 31/41] x86/shstk: Introduce routines modifying shstk
Thread-Topic: [PATCH v7 31/41] x86/shstk: Introduce routines modifying shstk
Thread-Index: AQHZSvtEQB+T+Su81EOPTesFttbPMK7yuAwAgAAEHIA=
Date:   Thu, 9 Mar 2023 17:03:26 +0000
Message-ID: <c42747e7c67027423940e17b6fc248db945e6d63.camel@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
         <20230227222957.24501-32-rick.p.edgecombe@intel.com>
         <ZAoN6tGi8kzgcLrK@zn.tnic>
In-Reply-To: <ZAoN6tGi8kzgcLrK@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|BY1PR11MB8078:EE_
x-ms-office365-filtering-correlation-id: 2e101470-d006-4b11-546c-08db20c03325
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J7InvoxkyLzSuEumlsJX2R4IxguIuROUUxtDC21kIkBcC6uKDOCGWO+wzlpmi0Whad38xNkzEgHBGmE2pJVjm3qYbsyTY8N0EebmhUtYlGe6mijaN4qwR+3pmSPAeM6BlMjVO6b4B1L0iyqLj772VtUWbiC0yc6S2LUSfLh4+wUs0S++T0I9akaW3/qJvHCVmXffDz4n8UsXj2IPdBF8FaIuXhzfbmpifLBThn6DzQuaqNRDMlv7hY7vhOaCvupEhNwLrEPpWMUy8qNlaRt92C3m9xraRJpv6aXv7hx6edz6r78NC2GcUD0QoDhnM6ssyOuPmy4e/hB2370RqJ87E0dC6XaHavQ/bFYC64THRJg6q6M2rf157wtva+g0NL00sqvtFxO7bzZleD55Tbhsf5Odt87RGKkPFQShD6zWIUKhPEqR1IVXuFAZ23q5W+Uz3ygyds5MZKUTSCCi4bUhqNewF4hNnRUBGW0GcLEU8an4Q2hxTloObn/aQM56iV1tqsrYTV9lDUhjQwM2sCEP+rrp9CzHW+DwRiQRPJn3mGtgN83hTeEMqtIWrCJOoMY2UYFFBJhcu2JhEzXk4snd5VMgAjmNJuyBixtHD+n/rGB7MSqiFdL6lllz/+M4mZUE3V4x8U9xpPaf83xntJmr/VOUSaAuLSHCElPhwUj2hGfyWo17DRKT5fKD3DmXRt6xrj0L2/+AMSuY5vLYft/z92pQsS/P+hywAx27YNP97nXZmo3NKtZNR2N1+kxLv2wz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199018)(8936002)(7406005)(5660300002)(7416002)(66446008)(8676002)(4326008)(6916009)(91956017)(64756008)(76116006)(66946007)(86362001)(66556008)(83380400001)(36756003)(54906003)(71200400001)(478600001)(316002)(41300700001)(66476007)(6486002)(82960400001)(186003)(2906002)(38100700002)(122000001)(6506007)(6512007)(26005)(2616005)(38070700005)(99106002)(17423001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTgweUhKTVVPc3BuQ2k0WmhJNmxIL1k5Y3lpazRhK3VLN1JSWWxMS0JETi9W?=
 =?utf-8?B?NjQwTzlVeVJiZHIyOXROU21razNrcUxOa2lTZjVrVU1aaHZqT3JPR25UT1lM?=
 =?utf-8?B?RlNrOXc2VzNiOFJ3MXREYTlaMlIxNE82QjE4NlNpeVJRVjZrUWFWL09ITGhj?=
 =?utf-8?B?eWpWM0lmbmc0b05SM1hLSGxkeEZROVBqcXVTQ0YycU5TNkgwVjByQi9vbzVJ?=
 =?utf-8?B?YnVMK1g2YkQ5UVVPbGxtUWEzTTBRZjJrZHNrZXd6TDkwbDFQNlhLOGY0djFx?=
 =?utf-8?B?TVAyUlQ5blJSVjNreDFuaU55WUJUS2ttK2pZNzJwckgrdk1BcS9KaXVJa3dz?=
 =?utf-8?B?RVc3OG5jdkdnK2s2MUFMTDE1OGdISWlFaldZM0R0NlpJQmtZeENaY21MVytT?=
 =?utf-8?B?Y29UV2F3SmNUVVVwbVQ3eGkreHYrRStPUjB3a01TRVVwRTlvUDhSUGZSY2w3?=
 =?utf-8?B?TWwwT0kxeTJjcDV5Q1VpcFhGMkN4TGIwNmVGaDQ0dHJhUWNhTm82WkgzaDhn?=
 =?utf-8?B?eVlQSXUrR1M5MFFQaUt2Tk9UbzNiMkFHeExCaVNMN0Z4TkRJdEM3Q0lnYzFJ?=
 =?utf-8?B?UDRkZHNJampPbjNzaHNlMTZUcm5tVHUrend2Vk1SVlZCbmx5Snl6M2RIL2NW?=
 =?utf-8?B?bkZsRjlUSmdlYzRHT2RmQ3NDTDZENGVlYjJGUUx5UitnZ2tiZzlEVWUxckRy?=
 =?utf-8?B?MDFYRWEzQmhKN2RmbExKQWFYSEh0bkRlZWJLTGY1TFNIdE1manlSUnV1NzJx?=
 =?utf-8?B?Q1B1Qk1qRzM3aVQ4TXl6NG9semhPR3Bqc2pWaS9BTUJpbUVrcUtZbFR5Zitz?=
 =?utf-8?B?TC8ydjM2MVNBd3FoK3hOajBHSHdHc3hFbXVreHBsUXluUlZWVTJGYnBlcUlw?=
 =?utf-8?B?TGVHWExyUE8vL2QrTDd4bGpKSG5JRDlRUXl6U2RDL1B1OThzdXVjcmNyb2Np?=
 =?utf-8?B?OEJhRk9nRHFUUmpBSy9nRUV1Q1hrYjJFRDdBZU5xWUphR1RCODduZ1ExYUc5?=
 =?utf-8?B?N09LNVg0Z3pmQ0E0MExFQXltWnJuZnVrTHMrb1ZEVWlwUE0wbHFtZ1FZamdW?=
 =?utf-8?B?ZUhLcEVCQ3hqY3hOL0pRODJ1ekJFTHNpQjZqby9tOUJpc1M3Z2o3ZHhPVy9Y?=
 =?utf-8?B?RnVkYWExM0VYRCtWeGxSaFc3NElZbWhNUlE3d0xCODV5M05pNFJvMkxuUWlW?=
 =?utf-8?B?UmxGSEwzNVQrSFhFVUhFdGlVaDBFRUp2dzRKOEVzWGZUdFV6ZkN5akptbUFv?=
 =?utf-8?B?dzZmY0EzeHFzWHRicDZ0UGJSa3NsY0x4ZzNtSHB2aUxFNC9NUjg4aTd3dDcv?=
 =?utf-8?B?THllZHBGaC9xS2FwRFp1K3YwQXVyaDFFYnUrVHZ4SjNBeUhEOFBKcS9wd3NJ?=
 =?utf-8?B?a3lEY1BIam1vcjR0S2h3NkRHallYbnNJNTA0NW84b2d3cllVWVFtOEkzWGRv?=
 =?utf-8?B?blpUMjk5d21Xdm5HR2pPdERuQzBHNmg5c3huUnFVUzNlMjJ6d2V6SE1aNnh0?=
 =?utf-8?B?OEJpRlUyL1RJRWd6M3NtRU1nMHBKM09PRE5SMkk0SWdaRFI0SXFKQWZaTk84?=
 =?utf-8?B?citqNW5ESFJMWU02UVhUTzNYZ3g4WXZ4VlBGMStpTVJ5cmlQbFN0R0xDSm0x?=
 =?utf-8?B?TlB5ZGp6YVYraGZXUW9VejFDT0xHbDlKQVcyS2JnaDNOakdybS9oTCtFOTNT?=
 =?utf-8?B?RU9zTlhadEVEMHRDMThURVBsZ1N6SFlOc29WVmxwai9OZ3hTWWxBK1RJSFpa?=
 =?utf-8?B?OW8xK3Iwd1FKVkZrMVpLNDlWRXBaTEVabHI5cUhIZ2REeitCSzhXMFFHK0pK?=
 =?utf-8?B?LyttQzkxRDdSc1NWZVN2d3JLUXBMaFhQaUlPRXlKRk1WTWRLbDhVdDNrWkQy?=
 =?utf-8?B?YUNUZDJSRUVnMFQra1ZpM1dhOEkwSzNmQUF6QWJmZWFPNW5aNjc3SjNuMkh2?=
 =?utf-8?B?cVdxeXBzOHU1c3JLTk5Ma0FWalJOa3h1djFpVUozL1UyeU1HNiszOVdlRDda?=
 =?utf-8?B?MGVFUTljQWhzZ0NpVUE3UFp6WXN4Y0Q4WEpLUERVd1dETTcvV3BtWWRyNFcz?=
 =?utf-8?B?djVYczE2TnBGNlVNQWNxSmtpL1ZnejkwRlYxUERmWXlDbVNPTVZ2QzdyTjkx?=
 =?utf-8?B?RVBWM0FmaUxuVUR1NHdGd1liUDVpWi9pQjZuVXdLNHV4NE9UZ1RyR040TzJq?=
 =?utf-8?Q?B3bjGKfyFh3t3QlDb2P4dYI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3EDA8FFD90D314E9555C7EE6ABB0B48@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e101470-d006-4b11-546c-08db20c03325
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 17:03:26.6482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: slkza3bTQ9BQE0DDhyq/cZVBYz3wEju7AUC5mwvIAf207aWoitkKw9JDWbkYKe6JPBHDjPrs/UTPnbgPnyMpHnnbaCiP+jzeI0vUWCHimbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8078
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

T24gVGh1LCAyMDIzLTAzLTA5IGF0IDE3OjQ4ICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIE1vbiwgRmViIDI3LCAyMDIzIGF0IDAyOjI5OjQ3UE0gLTA4MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+IEZyb206IFl1LWNoZW5nIFl1IDx5dS1jaGVuZy55dUBpbnRlbC5jb20+
DQo+ID4gDQo+ID4gU2hhZG93IHN0YWNrcyBhcmUgbm9ybWFsbHkgd3JpdHRlbiB0byB2aWEgQ0FM
TC9SRVQgb3Igc3BlY2lmaWMgQ0VUDQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBeDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlu
ZGlyZWN0bHkuDQoNCkR1bm5vIGhlcmUsIFJTVE9SU1NQL1NBVkVQUkVWU1NQIGFyZSBraW5kIG9m
IGRpcmVjdC4NCg0KPiANCj4gPiBpbnN0cnVjdGlvbnMgbGlrZSBSU1RPUlNTUC9TQVZFUFJFVlNT
UC4gSG93ZXZlciBkdXJpbmcgc29tZSBMaW51eA0KPiA+IG9wZXJhdGlvbnMgdGhlIGtlcm5lbCB3
aWxsIG5lZWQgdG8gd3JpdGUgdG8gZGlyZWN0bHkgdXNpbmcgdGhlDQo+ID4gcmluZy0wIG9ubHkN
Cj4gDQo+ICJIb3dldmVyLCBzb21ldGltZXMgdGhlIGtlcm5lbCB3aWxsIG5lZWQgdG8uLi4iDQoN
Ck9rLg0KDQo+IA0KPiA+IFdSVVNTIGluc3RydWN0aW9uLg0KPiA+IA0KPiA+IEEgc2hhZG93IHN0
YWNrIHJlc3RvcmUgdG9rZW4gbWFya3MgYSByZXN0b3JlIHBvaW50IG9mIHRoZSBzaGFkb3cNCj4g
PiBzdGFjaywgYW5kDQo+ID4gdGhlIGFkZHJlc3MgaW4gYSB0b2tlbiBtdXN0IHBvaW50IGRpcmVj
dGx5IGFib3ZlIHRoZSB0b2tlbiwgd2hpY2gNCj4gPiBpcyB3aXRoaW4NCj4gPiB0aGUgc2FtZSBz
aGFkb3cgc3RhY2suIFRoaXMgaXMgZGlzdGluY3RpdmVseSBkaWZmZXJlbnQgZnJvbSBvdGhlcg0K
PiA+IHBvaW50ZXJzDQo+ID4gb24gdGhlIHNoYWRvdyBzdGFjaywgc2luY2UgdGhvc2UgcG9pbnRl
cnMgcG9pbnQgdG8gZXhlY3V0YWJsZSBjb2RlDQo+ID4gYXJlYS4NCj4gPiANCj4gPiBJbnRyb2R1
Y2UgdG9rZW4gc2V0dXAgYW5kIHZlcmlmeSByb3V0aW5lcy4gQWxzbyBpbnRyb2R1Y2UgV1JVU1Ms
DQo+ID4gd2hpY2ggaXMNCj4gPiBhIGtlcm5lbC1tb2RlIGluc3RydWN0aW9uIGJ1dCB3cml0ZXMg
ZGlyZWN0bHkgdG8gdXNlciBzaGFkb3cgc3RhY2suDQo+ID4gDQo+ID4gSW4gZnV0dXJlIHBhdGNo
ZXMgdGhhdCBlbmFibGUgc2hhZG93IHN0YWNrIHRvIHdvcmsgd2l0aCBzaWduYWxzLA0KPiA+IHRo
ZSBrZXJuZWwNCj4gPiB3aWxsIG5lZWQgc29tZXRoaW5nIHRvIGRlbm90ZSB0aGUgcG9pbnQgaW4g
dGhlIHN0YWNrIHdoZXJlDQo+ID4gc2lncmV0dXJuIG1heSBiZQ0KPiA+IGNhbGxlZC4gVGhpcyB3
aWxsIHByZXZlbnQgYXR0YWNrZXJzIGNhbGxpbmcgc2lncmV0dXJuIGF0IGFyYml0cmFyeQ0KPiA+
IHBsYWNlcw0KPiA+IGluIHRoZSBzdGFjaywgaW4gb3JkZXIgdG8gaGVscCBwcmV2ZW50IFNST1Ag
YXR0YWNrcy4NCj4gPiANCj4gPiBUbyBkbyB0aGlzLCBzb21ldGhpbmcgdGhhdCBjYW4gb25seSBi
ZSB3cml0dGVuIGJ5IHRoZSBrZXJuZWwgbmVlZHMNCj4gPiB0byBiZQ0KPiA+IHBsYWNlZCBvbiB0
aGUgc2hhZG93IHN0YWNrLiBUaGlzIGNhbiBiZSBhY2NvbXBsaXNoZWQgYnkgc2V0dGluZyBiaXQN
Cj4gPiA2MyBpbg0KPiA+IHRoZSBmcmFtZSB3cml0dGVuIHRvIHRoZSBzaGFkb3cgc3RhY2suIFVz
ZXJzcGFjZSByZXR1cm4gYWRkcmVzc2VzDQo+ID4gY2FuJ3QNCj4gPiBoYXZlIHRoaXMgYml0IHNl
dCBhcyBpdCBpcyBpbiB0aGUga2VybmVsIHJhbmdlLiBJdCBpcyBhbHNvIGNhbid0IGJlDQo+ID4g
YQ0KPiANCj4gcy9pcyAvLw0KDQpZZXAsIHRoYW5rcy4NCg0KPiANCj4gPiB2YWxpZCByZXN0b3Jl
IHRva2VuLg0KPiANCj4gLi4uDQo+IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS9zcGVjaWFsX2luc25zLmgNCj4gPiBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NwZWNpYWxf
aW5zbnMuaA0KPiA+IGluZGV4IGRlNDhkMTM4OTkzNi4uZDZjZDkzNDRmNmM3IDEwMDY0NA0KPiA+
IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NwZWNpYWxfaW5zbnMuaA0KPiA+ICsrKyBiL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL3NwZWNpYWxfaW5zbnMuaA0KPiA+IEBAIC0yMDIsNiArMjAyLDE5
IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBjbHdiKHZvbGF0aWxlIHZvaWQgKl9fcCkNCj4gPiAgICAg
ICAgICAgICAgICA6IFtwYXhdICJhIiAocCkpOw0KPiA+ICAgfQ0KPiA+ICAgDQo+ID4gKyNpZmRl
ZiBDT05GSUdfWDg2X1VTRVJfU0hBRE9XX1NUQUNLDQo+ID4gK3N0YXRpYyBpbmxpbmUgaW50IHdy
aXRlX3VzZXJfc2hzdGtfNjQodTY0IF9fdXNlciAqYWRkciwgdTY0IHZhbCkNCj4gPiArew0KPiA+
ICsgICAgIGFzbV92b2xhdGlsZV9nb3RvKCIxOiB3cnVzc3EgJVt2YWxdLCAoJVthZGRyXSlcbiIN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICBfQVNNX0VYVEFCTEUoMWIsICVsW2ZhaWxdKQ0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgIDo6IFthZGRyXSAiciIgKGFkZHIpLCBbdmFsXSAi
ciIgKHZhbCkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICA6OiBmYWlsKTsNCj4gPiArICAg
ICByZXR1cm4gMDsNCj4gPiArZmFpbDoNCj4gPiArICAgICByZXR1cm4gLUVGQVVMVDsNCj4gDQo+
IE5pY2UhDQo+IA0KPiA+ICt9DQo+ID4gKyNlbmRpZiAvKiBDT05GSUdfWDg2X1VTRVJfU0hBRE9X
X1NUQUNLICovDQo+ID4gKw0KPiA+ICAgI2RlZmluZSBub3AoKSBhc20gdm9sYXRpbGUgKCJub3Ai
KQ0KPiA+ICAgDQo+ID4gICBzdGF0aWMgaW5saW5lIHZvaWQgc2VyaWFsaXplKHZvaWQpDQo+IA0K
PiAuLi4NCj4gDQo+ID4gK3N0YXRpYyBpbnQgcHV0X3Noc3RrX2RhdGEodTY0IF9fdXNlciAqYWRk
ciwgdTY0IGRhdGEpDQo+ID4gK3sNCj4gPiArICAgICBpZiAoV0FSTl9PTl9PTkNFKGRhdGEgJiBC
SVQoNjMpKSkNCj4gDQo+IER1bm5vLCBtYXliZSBzb21ldGhpbmcgbGlrZToNCj4gDQo+IC8qDQo+
ICAqIEEgY29tbWVudCBleHBsYWluaW5nIHdoYXQgdGhhdCBpcy4uLg0KPiAgKi8NCj4gI2RlZmlu
ZSBTSFNUS19TSUdSRVRVUk5fVE9LRU4gICBCSVRfVUxMKDYzKQ0KPiANCj4gb3Igc28/DQo+IA0K
PiBBbmQgdXNlIHRoYXQgaW5zdGVhZCBvZiB0aGF0IG1hZ2ljYWwgYml0IDYzLg0KDQpTZWVtcyB2
ZXJ5IHJlYXNvbmFibGUuIFNpbmNlIHdlIGFyZSBjYWxsaW5nIHRoaXMgdGhlICJkYXRhIGZvcm1h
dCIsIEkNCm1pZ2h0IGdvIHdpdGggU0hTVEtfREFUQV9CSVQuDQo=
