Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C723497C4
	for <lists+linux-arch@lfdr.de>; Thu, 25 Mar 2021 18:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhCYRVc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Mar 2021 13:21:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:35208 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229868AbhCYRVN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Mar 2021 13:21:13 -0400
IronPort-SDR: f2qR+IyrKjhVy00tIY7Gn8xja0H8KWAPjVMY6EprmOLMs0mGiIrGwfp2PooRR28aPJRiriiyKP
 63RQlDpEOo8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="252337940"
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; 
   d="scan'208";a="252337940"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 10:21:12 -0700
IronPort-SDR: DUlWfcOrxTuEXYYbmB1ymtFqoxTMBjhubwA729zaOcEe3UFpcbZp071IND0Qli5iGCS1z+HApf
 ut91tVVDBT9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; 
   d="scan'208";a="442885346"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 25 Mar 2021 10:21:12 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 25 Mar 2021 10:21:11 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 25 Mar 2021 10:21:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 25 Mar 2021 10:21:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 25 Mar 2021 10:21:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tp8J4BJLObS06XOA4RBGn5Rtpd42Yp7t/ZxWnnK/Sa0lu6xU/gfMUe5NBfwcI/lYz/yDc3ASB4MJUrjXOAdC4HQbfa8L/2+eOYzUDpKDafvJf8IRxV5jzph8WLb5jmeHIA78lbOnB+6hN85ksMkVYbXzo2uDpigSbkoS5owZDvLC7M66/dpleLaKg9msAChA7ryuDJTdLeYxrSENfqeL70b9ETSX7v62TYx6DuObznOZf8yCFKyjZ6Jx5eLEMaXsbJsjyYNhBxC9DOTjJbQGjlUXMFiIuKdPi9Zso+DWpVXHSOvKzj9iMR+V89O1qLwgtI6vMOO3LI65gg/HxNn6ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mR2nqyJo8XJB4QhQLc14AR7uLMpMYd+a/e71qYx74Og=;
 b=QwUKZu3bGauBLZU4XPPU4+buGOCf/ijG2dzS1ZCs5DEyKO5c1U481BnN3ui/vVhMEMsvzlGpc9A3Iy9ffcBlPN9AIqYMwsclMJqFrsSzfFgaGdAuzV5a602pRBroVa9tmFt7mSjQP2N4NG6HvGpdJq8B1U5wSjjeDch33Yx9wXG+E0cEBo1/KVUN7dG4b9SezvqdQbjjZokJzRd+B+SJlDrqQPYF9zzgMbJVA65CtOujoKFpFTbWsVIWDHn4E/U5H38J9PXtwEuIIJUF1GXjSEfNkWWLeh35R/w5uUzDN7X2518PHrl8zV4r80r/ttZ9aWm5EIPVt3g9wC3pLNKeHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mR2nqyJo8XJB4QhQLc14AR7uLMpMYd+a/e71qYx74Og=;
 b=XEzP5Wysdo8O5syY8Qb4xvmriN9HPIdrt6uW6/I/rSoHo8PATxdiF5ACUZcNBgL0i69pfDMknH3z5kQKghnqTAHQ4zswAP3YDnZ3hw5S47JDOPFCGQcvRY85l9l7HQzkI4/VMrodf7ZYPrdQrPb1N4F72uH1Cnfyn1JTvMDptc4=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5208.namprd11.prod.outlook.com (2603:10b6:510:3b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Thu, 25 Mar
 2021 17:21:04 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::8878:2a72:7987:673]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::8878:2a72:7987:673%5]) with mapi id 15.20.3977.029; Thu, 25 Mar 2021
 17:21:04 +0000
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
Thread-Index: AQHXGjGh/SWJiX8oekyfIlNJ9KylvKqGgWEAgABuEwCADgHIgIAAENgA
Date:   Thu, 25 Mar 2021 17:21:04 +0000
Message-ID: <06722BDE-738A-4513-886E-2C1442C97369@intel.com>
References: <20210316065215.23768-1-chang.seok.bae@intel.com>
 <20210316065215.23768-6-chang.seok.bae@intel.com>
 <20210316115248.GB18822@zn.tnic>
 <16A53D65-2460-49B3-892B-81EF8D7B12B9@intel.com>
 <20210325162047.GA32296@zn.tnic>
In-Reply-To: <20210325162047.GA32296@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3ac890c-7d46-4823-53ce-08d8efb25e94
x-ms-traffictypediagnostic: PH0PR11MB5208:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB5208127D5ACECA7690DA134ED8629@PH0PR11MB5208.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vCpV0pBj+zjLc9MSlPUnDkAYguIDFyL8AsAt13M9aryTFw6mWGNPTXj37GsfebP21+Sx4WE7xOEzVuJzw3qLb4Cclf/NgXQixTypgT2T3s/e0NQNulEjUjkQWKzm5DD2b8wT4zbMToXD8BOtSSuY4S95VZ11oSiGtfPor6nKbP3Qzohw8rwJHG+iqGGVWfh6ZZ8s6BQVlH8gZxYhCiC1Q7suCEh1/CwoYDwLN21FBwB7tuW6Mmw/ROQKbSrThAEN5LaFjF4AaGrIJEScXtM+0NmP3kfppfkhkgTK8hGWWkzZnNbmxZjIHY6cUuwLKff+74JF2/KoahboAVfaxUqvLd+ENrTVnoe8DMTiBnFhN5jUf8cBskx5tamapzde1yo47Pm0pagtly9gsOb1HVSnkxlwJSHZtoS74y6RZfCbh9OeCWUj3cs3T8Bl7jjqFyJ10ELr+KcQjQm7d+lL19riKpaEBGupX9Wld8Lh+rVsj80uGSN6caITNT3AsYmXpgtKqPq8lL8pXsv1tg/xEF0u+jtR8xJSCL+cyW1Bv9tZGSxcyDRx6Sfwi+K5iF+CSzOyUC98zSknnTEbDO3RQtNsA+6GjHrnYQVn0X5ugk07/zIP7DRwroKGNGC4ukpKcR0OfW7J7lMVN10budo4yqhcXX/m15X37MvDGgdDijnY3Wue0QsRepjzOPNoAYqJhQS1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(39860400002)(396003)(366004)(6506007)(6486002)(316002)(8676002)(4326008)(6916009)(8936002)(2616005)(36756003)(71200400001)(478600001)(53546011)(86362001)(186003)(38100700001)(83380400001)(76116006)(66446008)(64756008)(33656002)(66556008)(66476007)(66946007)(7416002)(26005)(5660300002)(6512007)(2906002)(54906003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dmM4ZzJSeWsxSjZ3dFd5UHNoK1JCVDBiWVVpdWtRMXpPR2RHa01PcnUxYTVv?=
 =?utf-8?B?bE1nSkpOalBacnBSTzJMNVJMMmxDcHJXVTNOUTdGZEs3OHRHc0k1TU5DRjhq?=
 =?utf-8?B?ZkZFdHBZYU80c3NtSW5IV1VhQzlTb1lxME5MUXJBeHN4dGRSaEFBY3BSNkh2?=
 =?utf-8?B?bGxtVEhjMS9naEQ5NHVnYnVWVitZY1JoUUdJcEdGenUxNkFwSU9vdWdSSWxp?=
 =?utf-8?B?anVKVjBXMGhhTGFCSmxCWnlOeXlySGlkeTVvVmRRcUowYkpIRzRsWllwMHM0?=
 =?utf-8?B?ZjJBMmcxMm1jM3psRGZ3RXVPd3dyUEVZZUl0TkgvTjNEYzdNSHVRZDZhMytq?=
 =?utf-8?B?QzZFVHIvQk90emVEYXJhT3R2cW5XR1hSTGpsSWRFdkR4SVZoaEFrSWxaNFY5?=
 =?utf-8?B?dmhMa3Iwb1k2bHp6S3ZYeHdCTzBKMVR6eHV5T25JMmVHYWhzSnE3Ti9EckVp?=
 =?utf-8?B?UDJmSVpEYkZnTkhENUU3eVV6d0Y3cENYTTcyMVRhdWdVS1I2OGU0Qkw4UGNK?=
 =?utf-8?B?djdUT3JBQUJSUENKZlI3K25BMEgzY3Bvbmh5c3R4MzN6N1FUT1RyTmZ1UFlO?=
 =?utf-8?B?L3ZSWTFiV25zckdTRDJmQkxSSVFSaW14MFRQdzBEUE56Rm5xd2k5SXRJSzFB?=
 =?utf-8?B?dXdpUkt2RVFwVWlMQWc4dGNMcFdtU05kbllJNGtHUFpWdXdUUTN2SlpEeEFC?=
 =?utf-8?B?NCtrN1kyTTRzYW8rUkVYaHB3dUNqTm5IQjVIcis1aHpkcHA2UjZzcjBnZXFD?=
 =?utf-8?B?UnNvS1VwWi92NnBvcVpvK0xjWFptNXBHcHhqNTVxMXdiRUk0eWZMRzBLV1I1?=
 =?utf-8?B?dFN3K0YzZCt0aGFYUDllTnU4VjVYVzNxbjkyY3B1M240QmZhMGNHMEswcEN6?=
 =?utf-8?B?OEJJOFNiSit2VWNldW5qSndqZFJoNGFDR1JtRmR0UzJ6RzBkN1JkN1BlVnNN?=
 =?utf-8?B?WVNzQUltUVNMeDZHaHd2ckMxWmVuVS9SMUNzMWRBWmJrVTVMbnRBUWhwZzVw?=
 =?utf-8?B?d3lWaW9rVlhhM1M4YTZDRUo4Q0FRTGpKaHlqUG1WR3QzblBWRkZWcXROQU1v?=
 =?utf-8?B?MVZScnBXQTBQaUE0Uks2dWtRUUZ2K01LYkFaTEFjRVlWOCtFSjkrY0VyRFJ3?=
 =?utf-8?B?WkZZMDg2cE9XcGJJREVMdmNHMGZwMjI2ZHBBakg4c0VILzNUYXR2QjZiS2ZX?=
 =?utf-8?B?bytqaitPRy81aDZjUnlRV01SRW9TTnJieEEvcHdwTkxJdWYyZEpLZGxNSUdJ?=
 =?utf-8?B?WGFpajdpV0doeXdmM0k3VDgrUjN3L1h6dUoxT1loSHhoUlBTSStNYXk5MlNV?=
 =?utf-8?B?QUJqNlBkaVZkNzBkdVVBZkhrNURUS0dnV0t0M2JuOFQrZ2xVU0tmSHh2WWR1?=
 =?utf-8?B?Z2FyVWI1eTV3OENZZDBtallFN0VieDQzWGxncUFVeW10aEpnQVBGdjRjVEtt?=
 =?utf-8?B?cmwyQXd0VkZiQXdsNjNpWDkvSWtjUlFpdnhoVTFJQXRXcC9wMzVjbVA2Q3Ev?=
 =?utf-8?B?V2pMczVwVmdxSDA2dml5ZW81SHhadlJzcUNCbGtsbGhVT3ZpRVgzbG5DWlhm?=
 =?utf-8?B?OCs4WWdKV0NDd2tPaTZhWUVrcW1kOTFuK1ova21iY0xhUzZZNmpGNHFHSjdu?=
 =?utf-8?B?SFk3bFZ2VVl4dVBlTmhGRGVxUlFwQ0ZZdkZSajFTWU42QllGeWpIb0ZSdzhT?=
 =?utf-8?B?TmdFL29FbGtUZ1E3dEJ4Z1JqRlRzVVRoM2kreVF3NTg4WW5xVE9oNkFnZHpa?=
 =?utf-8?Q?YrWPFzaxxEZu+G87zhrpcjtD2qB7u/MlrwwLFlf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2842D10385F7A4BA083DBDFA79EA5B7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ac890c-7d46-4823-53ce-08d8efb25e94
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2021 17:21:04.2095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XqPrA7/xk2EuTLhzeHYgtJF6QnKNZErJwUlODoqpp7t4yH5yTbs6KGEK0HeGJQeq19C0+ZGOrtq8uZM7og7NdfvYsgqZZIWUdaOX8mjwOSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5208
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTWFyIDI1LCAyMDIxLCBhdCAwOToyMCwgQm9yaXNsYXYgUGV0a292IDxicEBzdXNlLmRlPiB3
cm90ZToNCj4gDQo+ICQgZ2NjIHRzdC1taW5zaWdzdGtzei0yLmMgLURNWV9NSU5TSUdTVEtTWj0z
NDUzIC1vIHRzdC1taW5zaWdzdGtzei0yDQo+ICQgLi90c3QtbWluc2lnc3Rrc3otMg0KPiB0c3Qt
bWluc2lnc3Rrc3otMjogY2hhbmdlZCBieXRlIDUwIGJ5dGVzIGJlbG93IGNvbmZpZ3VyZWQgc3Rh
Y2sNCj4gDQo+IFdob29wcy4NCj4gDQo+IEFuZCB0aGUgZGVidWcgcHJpbnQgc2FpZDoNCj4gDQo+
IFsgNTM5NS4yNTI4ODRdIHNpZ25hbDogZ2V0X3NpZ2ZyYW1lOiBzcDogMHg3ZjU0ZWMzOWU3Yjgs
IHNhc19zc19zcDogMHg3ZjU0ZWMzOWU2Y2UsIHNhc19zc19zaXplIDB4ZDdkDQo+IA0KPiB3aGlj
aCB0ZWxscyBtZSB0aGF0LCBBRkFJQ1QsIHlvdXIgY2hlY2sgd2hldGhlciB3ZSBoYXZlIGVub3Vn
aCBhbHQgc3RhY2sNCj4gZG9lc24ndCBzZWVtIHRvIHdvcmsgaW4gdGhpcyBjYXNlLg0KDQpZZXMs
IGluIHRoaXMgY2FzZS4NCg0KdHN0LW1pbnNpZ3N0a3N6LTIuYyBoYXMgdGhpcyBjb2RlOg0KDQpz
dGF0aWMgdm9pZA0KaGFuZGxlciAoaW50IHNpZ25vKQ0Kew0KICAvKiBDbGVhciBhIGJpdCBvZiBv
bi1zdGFjayBtZW1vcnkuICAqLw0KICB2b2xhdGlsZSBjaGFyIGJ1ZmZlclsyNTZdOw0KICBmb3Ig
KHNpemVfdCBpID0gMDsgaSA8IHNpemVvZiAoYnVmZmVyKTsgKytpKQ0KICAgIGJ1ZmZlcltpXSA9
IDA7DQogIGhhbmRsZXJfcnVuID0gMTsNCn0NCuKApg0KDQogIGlmIChoYW5kbGVyX3J1biAhPSAx
KQ0KICAgIGVycnggKDEsICJoYW5kbGVyIGRpZCBub3QgcnVuIik7DQoNCiAgZm9yICh2b2lkICpw
ID0gc3RhY2tfYnVmZmVyOyBwIDwgc3RhY2tfYm90dG9tOyArK3ApDQogICAgaWYgKCoodW5zaWdu
ZWQgY2hhciAqKSBwICE9IDB4Q0MpDQogICAgICBlcnJ4ICgxLCAiY2hhbmdlZCBieXRlICV6ZCBi
eXRlcyBiZWxvdyBjb25maWd1cmVkIHN0YWNrXG4iLA0KICAgICAgICAgICAgc3RhY2tfYm90dG9t
IC0gcCk7DQrigKYNCg0KSSB0aGluayB0aGUgbWVzc2FnZSBjb21lcyBmcm9tIHRoZSBoYW5kbGVy
4oCZcyBvdmVyd3JpdGluZywgbm90IGZyb20gdGhlIGtlcm5lbC4NCg0KVGhlIHBhdGNoJ3MgY2hl
Y2sgaXMgdG8gZGV0ZWN0IGFuZCBwcmV2ZW50IHRoZSBrZXJuZWwtaW5kdWNlZCBvdmVyZmxvdyAt
LQ0Kd2hldGhlciBhbHQgc3RhY2sgZW5vdWdoIGZvciBzaWduYWwgZGVsaXZlcnkgaXRzZWxmLiAg
VGhlIHN0YWNrIGlzIHBvc3NpYmx5DQpub3QgZW5vdWdoIGZvciB0aGUgc2lnbmFsIGhhbmRsZXIn
cyB1c2UgYXMgdGhlIGtlcm5lbCBkb2VzIG5vdCBrbm93IGZvciBpdC4NCg0KVGhhbmtzLA0KQ2hh
bmcNCg0KDQoNCg0KDQo=
