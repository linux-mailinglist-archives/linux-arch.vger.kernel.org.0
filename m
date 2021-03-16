Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49CE33DC89
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 19:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbhCPS12 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Mar 2021 14:27:28 -0400
Received: from mga03.intel.com ([134.134.136.65]:51537 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232874AbhCPS0v (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Mar 2021 14:26:51 -0400
IronPort-SDR: cORJ9gg8BBx3MiCBxNCG4qEkxZ0I+qxYcfxYD497wwR9JR9DbkyIk8zGiEr06t80HrTyH6kO8R
 UaoZBbdeelbw==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="189362836"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="189362836"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 11:26:49 -0700
IronPort-SDR: bKay//Bkot0C04WPUXs1y4aXEe5ZZ8iZGxPalEROxOkf9TxNaz+pp46kxoCoeRWCb7nE9fXdm7
 f4kQHQAZYUDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="590754197"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 16 Mar 2021 11:26:49 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 16 Mar 2021 11:26:48 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 16 Mar 2021 11:26:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 16 Mar 2021 11:26:48 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 16 Mar 2021 11:26:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yl0y/c5yNiGb3uI7BwwdQiP2dRGc8Hyhkh3hF/3gwiuwQ/XY0KHkQ4O3X1ErnaTafSJeSWrI8YoLhcNQIssSMU+dOnZHAoVW1u6tFxlUT4rP3RGpYNLY99UFlNUOJt3qBNUiwxo0FmpkBFk0J3LqkDU6FifxFnDsAC7Wf+xB21JiyIqIz+xjXShZ2bq4WXT1pJInU+jxxs838vWWyE+veEK2WIFyHbLZ3ncv+9S9cHG5HqGCC1uOL1OUaXzutF9Sg0T5vWr9ZnPkMTWvJ7h3BdeM7ayCc/yuQefI2T8xKqZe2MV3gh7l+QXNdGbg50mmnbpsuBg8C4OGPJWNzjPgwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7flngVU/A7ac7Er1O/lscEvIvNKqOrk4QikJEDvRMc=;
 b=bOb3KPX4QY2uYkAjosyY9MG9RbM1FaomJShdgb5efloE/qme+Q+ejSHZ1cj0GuE+O3LbgOUwt3pOUnY1IFO1N9tKQQcElPwCLAI0d27sqtEzqKEox1Jbbfao1M6y1fgLvkHqj2g4wl2Vzkzmdmm5vPt+usYcHLDHolptDPXhRJW8IF/uj33TtPVkuGvNCraE6Ic33asTXvr1tyteIEYE/qd3I5Tq1RhsgaC0EzCRBcmR/FdNutWvefeUGe7pUqnjTsjclAbnLZJ1gcLJFII9pNluEIp0tcEnRLydgcxUCNuWD3UEzt5dnq6agCuj6nnOyXitlGofBuqST1TLGPwmtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7flngVU/A7ac7Er1O/lscEvIvNKqOrk4QikJEDvRMc=;
 b=unMHpHZiTrZWmTAlAzEh4tdAhUR47ZEfirW3ILXIVJcoY8XoG14V/k3nogjoH7VUwZKm810Z4c7z7/M0RffxyYl5bpiw5x8Yzgx2Hfxe9pXmmkLmw7B0o/ltZe31viiBsHDWqkOCm9iqRwNltufsaCL5+yuWhflP8rvRT7Ftyew=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4870.namprd11.prod.outlook.com (2603:10b6:510:34::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Tue, 16 Mar
 2021 18:26:46 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0%6]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 18:26:46 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Borislav Petkov <bp@suse.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "jannh@google.com" <jannh@google.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "carlos@redhat.com" <carlos@redhat.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 5/6] x86/signal: Detect and prevent an alternate signal
 stack overflow
Thread-Topic: [PATCH v7 5/6] x86/signal: Detect and prevent an alternate
 signal stack overflow
Thread-Index: AQHXGjGh/SWJiX8oekyfIlNJ9KylvKqGgWEAgABuEwA=
Date:   Tue, 16 Mar 2021 18:26:46 +0000
Message-ID: <16A53D65-2460-49B3-892B-81EF8D7B12B9@intel.com>
References: <20210316065215.23768-1-chang.seok.bae@intel.com>
 <20210316065215.23768-6-chang.seok.bae@intel.com>
 <20210316115248.GB18822@zn.tnic>
In-Reply-To: <20210316115248.GB18822@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 419b2ede-2e24-470b-3977-08d8e8a90ed3
x-ms-traffictypediagnostic: PH0PR11MB4870:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB487036E5785DE42E1A4BF10DD86B9@PH0PR11MB4870.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7l5xIUkzVewWh4ctgUL70k2M0YKWkVK6o2X0+v+rlXDNZD4+uLBtTbG8ZspA7CXWyd3iSGf4bMCp7JvGDKA3Gccn32GKDhXQVfJOFB3qTzR1nVa0/3F9UmS4Wy4sGHGQspprEqv9tt/JW+PDZUYh29tblxMAQVMZD+5MFdm1idXsnTNh9zNgcQ70BaPqBHaW5eJ04jiUTK+v4VqdR1EQiv0FUFKpQcQgZwG40F1WpJgvCizk0Y67Feb8MLMdHHnpkBaKH9KaoVvlCucVGj07rIixYDT6/fwezEk0Ahlh0/cPYXNkvTzOYDBYzJM8tBMa28oK+1oaC0iXnAr8f9jVbOBil3iYZXEKXR90A0GN1RyTXKNn8RYgbF/IRoeRM3Gr9ICzGmYn57hRb9KYepDvpx9NsMIiM/kL7Olbr0zsRngTQO75mM38sFisu9YtRmS34i5QZNtwac2rRfhl0bn+x3H/j3jgNPZiPizaLCDouciU6Pf8GlVPysBF3Vg+J5xEvz0oEeZ47cEKRccn2bXFvzR+4J7rVl7SZ0+yBAHegGJmKjUg9Fm4omorOVJBnFF+N000MJZBLkqs77Ux8n4v6txAZLN8ehpB/fDq09CvmYopZgo5WJ2L3HLLKfydYtiu0Gf600ju9pVrsL81ghdXsjGI8RY8pEXRs82ZNZ21mMoZlQckfAEQ9JJAat+znqun
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(376002)(346002)(396003)(136003)(2906002)(5660300002)(8676002)(26005)(6486002)(66446008)(53546011)(54906003)(966005)(86362001)(76116006)(33656002)(478600001)(186003)(8936002)(7416002)(36756003)(6512007)(6916009)(83380400001)(316002)(71200400001)(64756008)(66476007)(2616005)(66946007)(66556008)(4326008)(6506007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VTlyMjJoYWt6b0tvNnoydXhaV0krTERNMjFiTnZoRUdjdldrZUZoOHpMaDJG?=
 =?utf-8?B?cHdkZUNYUVF0WkowcHU5emp0OHR3Q1JOTmc4Q2tub2FkUHkzZzlxOS96NGxp?=
 =?utf-8?B?aTZEcDFsdE53YTFqaVhFMzBxRFE0WjUvZUNZL2UwbXI3dkZrUDZJaHo5cmR5?=
 =?utf-8?B?V0FxditRQnMyUmc4MWJ1dGdnVitiamFqMVl4S3liN0M5eVlWNHdnbjdkUWtm?=
 =?utf-8?B?OEYwRHZrcFZ3Ujd6UUZXcEJKSS92d1Z4RSt1VU1XemlWSGFjSWxCZ01ZM202?=
 =?utf-8?B?QXN0T2RFQ3VuZzZMa0ZkWklxMWQyT1JnQzVHak0yRVpocERQNHlyWEVaSmhr?=
 =?utf-8?B?TlROYVFhL2NiNUlsSHJrL3NSZ3J3RDJPRUlDVlBWRjVYa0I1RTFEUXlFeGMx?=
 =?utf-8?B?ZUxMdE9JbVdqM3RCd3FGTWowU2w1RERQNlFBOU80T29Td2xGTm9QZjYyTXlJ?=
 =?utf-8?B?MllERC9Qd2dWY2dKOE5yZmN3T0dDNlk0dkl2cVNsRTRNVWhqYndVS21nd1gw?=
 =?utf-8?B?NzAwMlBoZWhKaHA2Mi9yWGhkY2JjQU5rUmx5ZytWNk1EU3p4RHgxV0lYUVVp?=
 =?utf-8?B?QjlXcGwzdFQzMnhhYk1SMnpXazFzWjFqL1FENGdmOUFEQzF5THpSZlNzZEl6?=
 =?utf-8?B?b3BPTVNHQjJZck1kK3haTktOSEw4d0N5SHJ5Q3RGcmxNMG1hL09jc3hxUjFV?=
 =?utf-8?B?UUMyaUtVdHBuZld6eDRjb04vYTlwWDZMeXVLemVRY0dHNXk5RmlBcGNtNkp1?=
 =?utf-8?B?Y1p3UmwyL0QxeElqMGxMVWVJZ09mcjlmSDBTSlFub3pLbkNTSGpydVplT01M?=
 =?utf-8?B?WHNRZ0xjWkl5ZzR0V0t6VDVqK2FwNHF6UXk1LzNmK0lIQndJV0FoazNmT1hB?=
 =?utf-8?B?NnJKcm1RaTlValY0aDdvd3IzZjlxOTBKZ3daQkkxNzQxMlVJYkJmL3pPem1Z?=
 =?utf-8?B?QTYyWFcvY3YyM0JqbVVybTAyZ2c4dG9pT2pZY3Zkc0lINndjZmhBUjNhQUta?=
 =?utf-8?B?U2tLTm5DWGVjZEJ6THgxNDBhV0FLazFzRjl1dUtsdWVyU2dYSjBTd0pLaTlO?=
 =?utf-8?B?OUMxU0V4YzdvcnZDU0htaFRNVXZQMDgrR3BiYU1wQ0ltZXZFZU9vdnF4QUhY?=
 =?utf-8?B?VVdxZ3dvYnl2Z0lUbDhxOW92Z1RNNnRNalA5KzB2L3FoZ24reWJ4UkFjNDVy?=
 =?utf-8?B?UzhCaFdjekFpSGdiMUw3SVMrNzdISEJwYUthaEl5ejErNFRFKzJqZ1hTNmth?=
 =?utf-8?B?QTU4VXVYREwvcmhjZDk2S3I3TXlQeFI5WXRuYlc3WElOS3lPcHFaUFUrY25V?=
 =?utf-8?B?VDNQczBiNktZOHlyNVVaSkxpQVJYcGJaUkFnSUJhNHQ0VENKSlpaK0M4dmlI?=
 =?utf-8?B?ODVQamtsQWZXa2dLa1hJejJCVUdXOTY0VkEwZkRTSzBZbmh6aE9zZzBTWlpn?=
 =?utf-8?B?R1JYMTJrVlBkT2t4SmQxV0lBTStwRWFRb2E0Slg5aXEyN0pJeEFneFdJeEdo?=
 =?utf-8?B?bGVVYTJuQVJYS0dEL0V3Vlp4UXRjVW9DZml6ZEJpN1NDWDdDRjd5TUlyT3Fj?=
 =?utf-8?B?dWhuUnFKM3BLY2VJUnRpVUJvOUxzWTI4d0h5K1FwenpZaGs3NjVndTBWTGdk?=
 =?utf-8?B?VUg2NnNkSUVsVU5kTWJxQW5tK09wRjRZeVZUMEdFNjZPbUZhck52UlJJUm9h?=
 =?utf-8?B?YTQ1OWh5b1A5dWJVMW5EWW5nZXhzUmUzcy9DOGd2QjlxeWt4d2FUMlJXa09q?=
 =?utf-8?Q?d70+7G4md72Nmc7qGvHV5lYSMfAfTk2HVBSAGev?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E28F0258ED77C46841B5AE41F7A0597@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 419b2ede-2e24-470b-3977-08d8e8a90ed3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 18:26:46.7720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JPSxrGyuK5MSYOotqlKDDlvDCHS+jcN6J1rUZ2hHa94yOlmoh/UzeKtE3TiQ7Vz9B26V5NWHG90tzXYRGtBpN8+exoPP6dACDuD0/cY2mwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4870
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTWFyIDE2LCAyMDIxLCBhdCAwNDo1MiwgQm9yaXNsYXYgUGV0a292IDxicEBzdXNlLmRlPiB3
cm90ZToNCj4gT24gTW9uLCBNYXIgMTUsIDIwMjEgYXQgMTE6NTI6MTRQTSAtMDcwMCwgQ2hhbmcg
Uy4gQmFlIHdyb3RlOg0KPj4gQEAgLTI3Miw3ICsyNzUsOCBAQCBnZXRfc2lnZnJhbWUoc3RydWN0
IGtfc2lnYWN0aW9uICprYSwgc3RydWN0IHB0X3JlZ3MgKnJlZ3MsIHNpemVfdCBmcmFtZV9zaXpl
LA0KPj4gCSAqIElmIHdlIGFyZSBvbiB0aGUgYWx0ZXJuYXRlIHNpZ25hbCBzdGFjayBhbmQgd291
bGQgb3ZlcmZsb3cgaXQsIGRvbid0Lg0KPj4gCSAqIFJldHVybiBhbiBhbHdheXMtYm9ndXMgYWRk
cmVzcyBpbnN0ZWFkIHNvIHdlIHdpbGwgZGllIHdpdGggU0lHU0VHVi4NCj4+IAkgKi8NCj4+IC0J
aWYgKG9uc2lnc3RhY2sgJiYgIWxpa2VseShvbl9zaWdfc3RhY2soc3ApKSkNCj4+ICsJaWYgKG9u
c2lnc3RhY2sgJiYgdW5saWtlbHkoc3AgPD0gY3VycmVudC0+c2FzX3NzX3NwIHx8DQo+PiArCQkJ
CSAgIHNwIC0gY3VycmVudC0+c2FzX3NzX3NwID4gY3VycmVudC0+c2FzX3NzX3NpemUpKQ0KPj4g
CQlyZXR1cm4gKHZvaWQgX191c2VyICopLTFMOw0KPiANCj4gU28gY2xlYXJseSBJJ20gbWlzc2lu
ZyBzb21ldGhpbmcgYmVjYXVzZSB0cnlpbmcgdG8gdHJpZ2dlciB0aGUgdGVzdCBjYXNlDQo+IGlu
IHRoZSBidWd6aWxsYToNCj4gDQo+IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1
Zy5jZ2k/aWQ9MTUzNTMxDQo+IA0KPiBvbiBjdXJyZW50IHRpcC9tYXN0ZXIgZG9lc24ndCB3b3Jr
LiBSdW5zIHdpdGggTVlfTUlOU0lHU1RLU1ogdW5kZXIgMjA0OA0KPiBmYWlsIHdpdGg6DQo+IA0K
PiB0c3QtbWluc2lnc3Rrc3otMjogc2lnYWx0c3RhY2s6IENhbm5vdCBhbGxvY2F0ZSBtZW1vcnkN
Cj4gDQo+IGFuZCBhYm92ZSAyMDQ4IGRvbid0IG92ZXJ3cml0ZSBieXRlcyBiZWxvdyB0aGUgc3Rh
Y2suDQo+IA0KPiBTbyBzb21ldGhpbmcgZWxzZSBpcyBtaXNzaW5nLiBIb3cgZGlkIHlvdSB0ZXN0
IHRoaXMgcGF0Y2g/DQoNCkkgc3VzcGVjdCB0aGUgQVZYLTUxMiBzdGF0ZXMgbm90IGVuYWJsZWQg
dGhlcmUuDQoNCldoZW4gSSByYW4gaXQgdW5kZXIgYSBtYWNoaW5lIHdpdGhvdXQgQVZYLTUxMiBs
aWtlIHRoaXMsIGl0IGRpZG7igJl0IHNob3cgdGhlDQpvdmVyd3JpdGUgbWVzc2FnZToNCg0KICAg
ICQgY2F0IC9wcm9jL2NwdWluZm8gfCBncmVwIC1tMSAibW9kZWwgbmFtZeKAnQ0KICAgIG1vZGVs
IG5hbWUgICAgICA6IEludGVsKFIpIENvcmUoVE0pIGk5LTEwOTAwSyBDUFUgQCAzLjcwR0h6DQoN
CiAgICAkIHN1ZG8gZG1lc2cgfCBncmVwICJFbmFibGVkIHhzdGF0ZeKAnQ0KICAgIFsgICAgMC4w
MDAwMDBdIHg4Ni9mcHU6IEVuYWJsZWQgeHN0YXRlIGZlYXR1cmVzIDB4MWYsIGNvbnRleHQgc2l6
ZSBpcyA5NjANCiAgICBieXRlcywgdXNpbmcg4oCYY29tcGFjdGVk4oCZIGZvcm1hdC4NCg0KICAg
ICQgZ2NjIHRzdC1taW5zaWdzdGtzei0yLmMgLURNWV9NSU5TSUdTVEtTWj0yMDQ3DQogICAgJCAu
L2Eub3V0DQogICAgYS5vdXQ6IHNpZ2FsdHN0YWNrOiBDYW5ub3QgYWxsb2NhdGUgbWVtb3J5DQoN
CiAgICAkIGdjYyB0c3QtbWluc2lnc3Rrc3otMi5jIC1ETVlfTUlOU0lHU1RLU1o9MjA0OA0KICAg
ICQgLi9hLm91dA0KDQpXaGVuIGRvIGl0IGFnYWluIHdpdGggQVZYLTUxMiwgaXQgZGlkIHNob3cg
dGhlIG1lc3NhZ2U6DQoNCiAgICAkIGNhdCAvcHJvYy9jcHVpbmZvICB8IGdyZXAgLW0xICJtb2Rl
bCBuYW1l4oCdDQogICAgbW9kZWwgbmFtZSAgICAgIDogSW50ZWwoUikgQ29yZShUTSkgaTktNzk0
MFggQ1BVIEAgMy4xMEdIeg0KDQogICAgJCBzdWRvIGRtZXNnIHwgZ3JlcCAiRW5hYmxlZCB4c3Rh
dGXigJ0NCiAgICBbICAgIDAuMDAwMDAwXSB4ODYvZnB1OiBFbmFibGVkIHhzdGF0ZSBmZWF0dXJl
cyAweGZmLCBjb250ZXh0IHNpemUgaXMgMjU2MA0KICAgIGJ5dGVzLCB1c2luZyAnY29tcGFjdGVk
JyBmb3JtYXQuDQoNCiAgICAkIGdjYyB0c3QtbWluc2lnc3Rrc3otMi5jIC1ETVlfTUlOU0lHU1RL
U1o9MjA0OA0KICAgICQgLi9hLm91dA0KICAgIGEub3V0OiBjaGFuZ2VkIGJ5dGUgMTQxMiBieXRl
cyBiZWxvdyBjb25maWd1cmVkIHN0YWNrDQoNCiAgICAkIGdjYyB0c3QtbWluc2lnc3Rrc3otMi5j
IC1ETVlfTUlOU0lHU1RLU1o9MzQ5MA0KICAgICQgLi9hLm91dA0KICAgIGEub3V0OiBjaGFuZ2Vk
IGJ5dGUgMjEgYnl0ZXMgYmVsb3cgY29uZmlndXJlZCBzdGFjaw0KDQogICAgJCBnY2MgdHN0LW1p
bnNpZ3N0a3N6LTIuYyAtRE1ZX01JTlNJR1NUS1NaPTM0OTENCiAgICAkIC4vYS5vdXQNCg0KDQpB
bHNvLCBvbiB0aGUgc2Vjb25kIG1hY2hpbmUsIHdpdGhvdXQgdGhpcyBwYXRjaDoNCg0KICAgICQg
Z2NjIHRzdC1taW5zaWdzdGtzei0yLmMgLURNWV9NSU5TSUdTVEtTWj0zMTkxDQogICAgJCAuL2Eu
b3V0DQogICAgYS5vdXQ6IGNoYW5nZWQgYnl0ZSAzMTkgYnl0ZXMgYmVsb3cgY29uZmlndXJlZCBz
dGFjaw0KDQpCdXQgd2l0aCB0aGlzIHBhdGNoLCBpdCBnYXZlIHNlZ2ZhdWx0IHdpdGggYSB0b28t
c21hbGwgc2l6ZToNCg0KICAgICQgZ2NjIHRzdC1taW5zaWdzdGtzei0yLmMgLURNWV9NSU5TSUdT
VEtTWj0zMTkxDQogICAgJCAuL2Eub3V0DQogICAgU2VnbWVudGF0aW9uIGZhdWx0IChjb3JlIGR1
bXBlZCkNCg0KVGhhbmtzLA0KQ2hhbmc=
