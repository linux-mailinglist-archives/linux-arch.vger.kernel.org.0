Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6C8349B71
	for <lists+linux-arch@lfdr.de>; Thu, 25 Mar 2021 22:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhCYVMH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Mar 2021 17:12:07 -0400
Received: from mga14.intel.com ([192.55.52.115]:30014 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230373AbhCYVMD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Mar 2021 17:12:03 -0400
IronPort-SDR: XUBclb3GYoqfr2FKRajjjjx+r8NWaf5PubfQEyBsincICXq0ji4eWRIERu/Eq3WCpaJWojkjqN
 1jLVAeEao0tQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="190447345"
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; 
   d="scan'208";a="190447345"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 14:12:02 -0700
IronPort-SDR: n2wWp4/O+1jEgH19W3O4YqfNYoelBsA7LMS8rkSgfiS1xDFb6yoyVlLBDEBzPymwSYVxoq5eZF
 iB6y+wpokAuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; 
   d="scan'208";a="377003370"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 25 Mar 2021 14:12:02 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 25 Mar 2021 14:12:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 25 Mar 2021 14:12:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 25 Mar 2021 14:12:01 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 25 Mar 2021 14:12:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaNZlbxUkyirA5q6sY+FDu9wkhIzDzjxWmoBBxJ9J1/AnbrO52f0F2PD3BUJelAGZGvk3jYuonkN3DIa3J13jPT1lZwiEK0A9doNpbzvGfvFjt2qlR6EJsN/owijv9fhBl0pj9GoXjTJ4z2ujcw/CsurzwWPidj642u3Mask7xCRkhy59B4It9w0TYZ1wFDbWaF/mbc895hnn6G92+KLAEqxykDWZAxPPGKuOHFXp382Vi5x3EH7CPHsa3F4OpOFQ3hk3OwoxEwacp7sEaj3KNOc6IC+Wly/JsXN2DPgod4ALLYq0KH0Mw7+UTjBQ3FmqLSab6dWwCiPn9Bu+W7VgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiYYYU8g6V+VZI4WdTGYlUyi1v7CBD8SGAANQRE4huM=;
 b=S83zyW5DJITrCIzHwDmxde3tdnd+m5wT/+81zpHdavJv0qcybAMLwi0D07wa0o96oZY9Vxj3VAgWpKB7P38ypN3Mfz0abjFr1emlFxiRMqhhVml6d8OGjHPn0TfUmAsT5CTmbWQkP3pzhOhVuD0mHf3tZM6gJCIuUyGNIj4G7+RV5gxYNcr7xo0QxaVHnkpAcdnjQHEFnyvwjAaKIjwHnA0SkFrk/OTdDpIJNsKUnjejMOTHCqNiBcWvMuch61ddZ9I3by0zzlHMvHiQTj3VHRwDkFD/zafbPSguGVBufwX4D5aop4BM76vWDnFN7vJJxoyWxDVYCx957rMm3JhtUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiYYYU8g6V+VZI4WdTGYlUyi1v7CBD8SGAANQRE4huM=;
 b=qgDe6+zHXGqencsSPz1Kj827UURzMjEWe+HNlVWnXy5hLErOXhS4lbgcZ5RGXbyKXOQRQh4CFoFJKh3U1qmNlBJVY5dT/jTQV2mMAI+V81EX2dlxIZwOmxGIDiT2KfvVcQjBQA1IOj/DaPgO4Xh1AfKI0+fJP0hCu/rlHxrbNGY=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5128.namprd11.prod.outlook.com (2603:10b6:510:39::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Thu, 25 Mar
 2021 21:11:56 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::8878:2a72:7987:673]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::8878:2a72:7987:673%5]) with mapi id 15.20.3977.029; Thu, 25 Mar 2021
 21:11:56 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Borislav Petkov <bp@suse.de>
CC:     Andy Lutomirski <luto@kernel.org>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Gross, Jurgen" <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Jann Horn <jannh@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Carlos O'Donell <carlos@redhat.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 5/6] x86/signal: Detect and prevent an alternate signal
 stack overflow
Thread-Topic: [PATCH v7 5/6] x86/signal: Detect and prevent an alternate
 signal stack overflow
Thread-Index: AQHXGjGh/SWJiX8oekyfIlNJ9KylvKqVEKUAgAALkICAACZgAA==
Date:   Thu, 25 Mar 2021 21:11:56 +0000
Message-ID: <AA7AD300-2D6D-4D97-A8A5-B77B3F0537DD@intel.com>
References: <20210316065215.23768-1-chang.seok.bae@intel.com>
 <20210316065215.23768-6-chang.seok.bae@intel.com>
 <CALCETrU_n+dP4GaUJRQoKcDSwaWL9Vc99Yy+N=QGVZ_tx_j3Zg@mail.gmail.com>
 <20210325185435.GB32296@zn.tnic>
In-Reply-To: <20210325185435.GB32296@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25cabbad-d72c-4c17-c492-08d8efd29f59
x-ms-traffictypediagnostic: PH0PR11MB5128:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB5128BDA76D7D0BCC32FF95B3D8629@PH0PR11MB5128.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GTEGhnVC/EK6UtqKkcsuo5mi4cg2KbSQ859ohUYr7unMvYIiHAJeNmKrr3FboAooA3W8cBjduqniDEJ0f0UGapX42cANy84T36PDCYaycr16A8GpfwUqLypV+CCrX/bdyajIUZvknGNd/JWg9+t8+R2fsFRhgRKDe261gynuVlrbDuvsJKLDrWJIW6BHsd7rZeX5rZdciBkMVupkXFZEqoX8+MxYoe2FSGqAMBDyl2pauZLje9nSH2PfOwi5IcGsA91gs/zVSrPrhl/j0BZW/svV1E+CvotjFKwfGUTGLP9MTri8kJX4/LpU9tnTfUO1QkPAJ8wO1B7XVdET1f9fp1S4n2YzmgtjPQxSCFy8YPiEb/5kvlcxXoISxBrLA8YvAeT2yA70fv+mjenAmJADFrqw8x2cdEd6mVeE/MbAnceGWgT1ZwcX6zgYXKYiFFX2ANsIAJLcxfKmc50wjW9Pbre2IDuUK0eKy9fzHAEsgkIfjfvqLhu75+MURnicRJV7Jl2IGTkUHd8HiGPaXZ44xdFFTN3Pbrkb+zUOGHyp9wnpDDqBZvVqE7UzHsB2lGUVmH893hkblEIQkazIKN6+oPUAzovAM5Wp8g4EYvGvjWG+OII1jsx7RLgMswfMo6JQdiAOKkrfYeZ425aoyclp3L445dxyFbYRswIIpoFNXSE5oohUPTHjJVdBBsm5tWJmX3bs+diqLFCZxrYnbd9F5h0h4OHOtlpj+hBQt97ywbCoyuxmg7AxwxPH8oTFLDhocAcNWDfin/K5yk/mQRvNig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(366004)(346002)(136003)(39860400002)(316002)(6916009)(478600001)(186003)(54906003)(4326008)(6512007)(71200400001)(83380400001)(86362001)(26005)(7416002)(2616005)(966005)(66556008)(2906002)(36756003)(53546011)(76116006)(6506007)(8936002)(5660300002)(66946007)(8676002)(64756008)(66446008)(66476007)(33656002)(38100700001)(6486002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ajEvL014NWpaTFhIQ28vSVc0ZkZBUFFDWWFPUS9kaVdra2kyZjFEQ0tpbWRJ?=
 =?utf-8?B?bFVuOWtPVG5XcU5Pa1pyU0cwcXN4eld4ZWNMNGdPcFd5bE5sNnZDNmxkR2Iy?=
 =?utf-8?B?djB4cXR4WGJXWk1uR0xmN2JRcW56UjVpa1F2eElpYmdQVGEzdm5IKytCN3VU?=
 =?utf-8?B?TG9iOHVFWXNSWExtUWlwQncrMCt5N0trNkRHWUU0OGorMkkwNUZDblBySzR0?=
 =?utf-8?B?V3dFNmdoL1c0T080Vmo5ZXpoalVwZGZ2YXhtSjJWditLaFFCUTZOQ0xqZUEr?=
 =?utf-8?B?NG9sVFRWc0l5bEs3dDVkbmxjQldsNWhCNWZid3RFUkhuS1c0V1l4N0Z0Q1Jt?=
 =?utf-8?B?SWQxWHRoUFJFKzRRUWRwajlHa0NxU0VtcDllZkhOMFEycmdGa3kxRGFLM1hZ?=
 =?utf-8?B?a1FCejlSNmpOUDYxVE1VL28rNTNxdjRxN3VpTE9HL25ZcjZWN1F5dEY3a3d1?=
 =?utf-8?B?SGwxNy9keVhweXBxUDMzSk10TmJsbi9OUkc1RG0xbTdaZGtiNGVxdnp0b2Rh?=
 =?utf-8?B?Q2orU1NyVkwybHVOTngrNUhpd1RxWDU2UTYrOGFFbEM4bTd2TndscUZEbW0z?=
 =?utf-8?B?cTAwVnc3SkJQUmF1MFpLSUtDbnhvMGp5WEVwcUtsT3VoSCtsWlRTc0dMMDFs?=
 =?utf-8?B?Q0dzZWMvOW52WE5FeVZJaFdERGV5YkpEcThNNUFUUHgrMHp4NmNFQTkyenNR?=
 =?utf-8?B?aDc1S0svMWViWm1OTWpqUDBEQXc3US8rOW9PVDViZE1hdllVN0tRdDlMRUtW?=
 =?utf-8?B?aXVqZlBRYXVETVdObnIwTlVSQU83d1Z0MFVhUEJPMXFBNjRmai81Sy9oRmpH?=
 =?utf-8?B?R1FnMWN4YUc3ZHYySEVhNExhbXhVUHh5bUp2bWJha0xxUTc3T1FvYWQyZERl?=
 =?utf-8?B?eTN0UFovQ1lTcktOeEpnMTJCald2dkswamNsQVJ0NnUzMHRQYWNobDZvUFo1?=
 =?utf-8?B?MTE5MTc3VVZ5RzdxRC8xcWlXc0hSb1JxVGhNa1NoWUp4ZzY4elVDc3hJQkQ4?=
 =?utf-8?B?NXpIMW10QkVFaGR0OTNFNStMeFhBNFEvdGhqNHlCVUhCZzdnOXBXZVhXQjdq?=
 =?utf-8?B?VzhoQ0ZrUE9pSStVVm9qeGlCMy9HVEhXQy9QQlUvWG5IU1BLOEk0RmxJZHhu?=
 =?utf-8?B?eTFPQ1ZVT1RBTkVuVkVsUWtaTTQ0c1Vhd0xPQ3NIZFZQelFhMXY1dWJhUjAz?=
 =?utf-8?B?SURpT08vcEVEM2cwRTlINTFUcEkydzMvbGNIOURUTWVwZ0M2aGJnUElHcHVL?=
 =?utf-8?B?WFIxSUdYQTBURVpaNFZqT0dTeHBTNFA3b3dNdm5lelNNME1RZ2tZVDhsdHNw?=
 =?utf-8?B?ZXFuMWVoRWdUVE5kU2cwTThLYU5NcFJFL0I2V3ROazhOVis2UVYwOTRaMU5y?=
 =?utf-8?B?S3pzOVBid1lXTUt3UERGWkRDZFRRTXlNY2xibndVUEZlKzhJd0V4T0ZndVJa?=
 =?utf-8?B?TWtMZXVCZEpaUVBRTWFOaTArbDBub2RQdjFyZzd6N2pnRHowNVdVMHVTN0p4?=
 =?utf-8?B?VkIvQkJ1OWpuc2EybmNSSVBYb3NIK3lDQktFeERMSU1XcDZYdWZ5TWN2WUpC?=
 =?utf-8?B?Q0V5c28yeVdNTFpkSUhHNmkyQVg4bURUVDhiMEV5eEs2UXpzc0h6MGQ0Nk00?=
 =?utf-8?B?RW1ZQ2ZocUZZdVdJdFQ4UVNENHVBOXFNS29CRFYyWEFZQldqRXNwakxWTTIw?=
 =?utf-8?B?dGtSekg3dDU4dlNpbkhNc0JKVExYSStoV2xxb2JVd1Z0RWorVG50MnBGZmx4?=
 =?utf-8?Q?EYJvdGVQIii9Ved1Ym+sIR0dmLmYFKByhctR1NO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BB207A767C334488B41E1EE2F5DA75D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25cabbad-d72c-4c17-c492-08d8efd29f59
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2021 21:11:56.7072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: outVzh+58iBywQKvprT0o1FuwbH0u3QAsiJydwv+trJzLxiFIcxlNMdylvDbekHOxSWY9HcmoB5gvpOioQsW8Ynp994oKYWi4J6G9iI5CZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5128
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTWFyIDI1LCAyMDIxLCBhdCAxMTo1NCwgQm9yaXNsYXYgUGV0a292IDxicEBzdXNlLmRlPiB3
cm90ZToNCj4gT24gVGh1LCBNYXIgMjUsIDIwMjEgYXQgMTE6MTM6MTJBTSAtMDcwMCwgQW5keSBM
dXRvbWlyc2tpIHdyb3RlOg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9zaWduYWwu
YyBiL2FyY2gveDg2L2tlcm5lbC9zaWduYWwuYw0KPj4gaW5kZXggZWE3OTRhMDgzYzQ0Li41Mzc4
MTMyNGEyZDMgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvc2lnbmFsLmMNCj4+ICsr
KyBiL2FyY2gveDg2L2tlcm5lbC9zaWduYWwuYw0KPj4gQEAgLTIzNyw3ICsyMzcsOCBAQCBnZXRf
c2lnZnJhbWUoc3RydWN0IGtfc2lnYWN0aW9uICprYSwgc3RydWN0IHB0X3JlZ3MgKnJlZ3MsIHNp
emVfdCBmcmFtZV9zaXplLA0KPj4gCXVuc2lnbmVkIGxvbmcgbWF0aF9zaXplID0gMDsNCj4+IAl1
bnNpZ25lZCBsb25nIHNwID0gcmVncy0+c3A7DQo+PiAJdW5zaWduZWQgbG9uZyBidWZfZnggPSAw
Ow0KPj4gLQlpbnQgb25zaWdzdGFjayA9IG9uX3NpZ19zdGFjayhzcCk7DQo+PiArCWJvb2wgYWxy
ZWFkeV9vbnNpZ3N0YWNrID0gb25fc2lnX3N0YWNrKHNwKTsNCj4+ICsJYm9vbCBlbnRlcmluZ19h
bHRzdGFjayA9IGZhbHNlOw0KPj4gCWludCByZXQ7DQo+PiANCj4+IAkvKiByZWR6b25lICovDQo+
PiBAQCAtMjQ2LDE1ICsyNDcsMjUgQEAgZ2V0X3NpZ2ZyYW1lKHN0cnVjdCBrX3NpZ2FjdGlvbiAq
a2EsIHN0cnVjdCBwdF9yZWdzICpyZWdzLCBzaXplX3QgZnJhbWVfc2l6ZSwNCj4+IA0KPj4gCS8q
IFRoaXMgaXMgdGhlIFgvT3BlbiBzYW5jdGlvbmVkIHNpZ25hbCBzdGFjayBzd2l0Y2hpbmcuICAq
Lw0KPj4gCWlmIChrYS0+c2Euc2FfZmxhZ3MgJiBTQV9PTlNUQUNLKSB7DQo+PiAtCQlpZiAoc2Fz
X3NzX2ZsYWdzKHNwKSA9PSAwKQ0KPj4gKwkJLyoNCj4+ICsJCSAqIFRoaXMgY2hlY2tzIGFscmVh
ZHlfb25zaWdzdGFjayB2aWEgc2FzX3NzX2ZsYWdzKCkuDQo+PiArCQkgKiBTZW5zaWJsZSBwcm9n
cmFtcyB1c2UgU1NfQVVUT0RJU0FSTSwgd2hpY2ggZGlzYWJsZXMNCj4+ICsJCSAqIHRoYXQgY2hl
Y2ssIGFuZCBwcm9ncmFtcyB0aGF0IGRvbid0IHVzZQ0KPj4gKwkJICogU1NfQVVUT0RJU0FSTSBn
ZXQgY29tcGF0aWJsZSBidXQgcG90ZW50aWFsbHkNCj4+ICsJCSAqIGJpemFycmUgYmVoYXZpb3Iu
DQo+PiArCQkgKi8NCj4+ICsJCWlmIChzYXNfc3NfZmxhZ3Moc3ApID09IDApIHsNCj4+IAkJCXNw
ID0gY3VycmVudC0+c2FzX3NzX3NwICsgY3VycmVudC0+c2FzX3NzX3NpemU7DQo+PiArCQkJZW50
ZXJpbmdfYWx0c3RhY2sgPSB0cnVlOw0KPj4gKwkJfQ0KPj4gCX0gZWxzZSBpZiAoSVNfRU5BQkxF
RChDT05GSUdfWDg2XzMyKSAmJg0KPj4gLQkJICAgIW9uc2lnc3RhY2sgJiYNCj4+ICsJCSAgICFh
bHJlYWR5X29uc2lnc3RhY2sgJiYNCj4+IAkJICAgcmVncy0+c3MgIT0gX19VU0VSX0RTICYmDQo+
PiAJCSAgICEoa2EtPnNhLnNhX2ZsYWdzICYgU0FfUkVTVE9SRVIpICYmDQo+PiAJCSAgIGthLT5z
YS5zYV9yZXN0b3Jlcikgew0KPj4gCQkvKiBUaGlzIGlzIHRoZSBsZWdhY3kgc2lnbmFsIHN0YWNr
IHN3aXRjaGluZy4gKi8NCj4+IAkJc3AgPSAodW5zaWduZWQgbG9uZykga2EtPnNhLnNhX3Jlc3Rv
cmVyOw0KPj4gKwkJZW50ZXJpbmdfYWx0c3RhY2sgPSB0cnVlOw0KPj4gCX0NCj4gDQo+IFdoYXQg
YSBtZXNzIHRoaXMgd2hvbGUgc2lnbmFsIGhhbmRsaW5nIGlzLiBJIG5lZWQgYSBjb3Vyc2UgaW4g
c2lnbmFsDQo+IGhhbmRsaW5nIHRvIHVuZGVyc3RhbmQgd2hhdCdzIGdvaW5nIG9uIGhlcmUuLi4N
Cj4gDQo+PiANCj4+IAlzcCA9IGZwdV9fYWxsb2NfbWF0aGZyYW1lKHNwLCBJU19FTkFCTEVEKENP
TkZJR19YODZfMzIpLA0KPj4gQEAgLTI2Nyw4ICsyNzgsMTYgQEAgZ2V0X3NpZ2ZyYW1lKHN0cnVj
dCBrX3NpZ2FjdGlvbiAqa2EsIHN0cnVjdCBwdF9yZWdzICpyZWdzLCBzaXplX3QgZnJhbWVfc2l6
ZSwNCj4+IAkgKiBJZiB3ZSBhcmUgb24gdGhlIGFsdGVybmF0ZSBzaWduYWwgc3RhY2sgYW5kIHdv
dWxkIG92ZXJmbG93IGl0LCBkb24ndC4NCj4+IAkgKiBSZXR1cm4gYW4gYWx3YXlzLWJvZ3VzIGFk
ZHJlc3MgaW5zdGVhZCBzbyB3ZSB3aWxsIGRpZSB3aXRoIFNJR1NFR1YuDQo+PiAJICovDQo+PiAt
CWlmIChvbnNpZ3N0YWNrICYmICFsaWtlbHkob25fc2lnX3N0YWNrKHNwKSkpDQo+PiArCWlmICh1
bmxpa2VseShlbnRlcmluZ19hbHRzdGFjayAmJg0KPj4gKwkJICAgICAoc3AgPD0gY3VycmVudC0+
c2FzX3NzX3NwIHx8DQo+PiArCQkgICAgICBzcCAtIGN1cnJlbnQtPnNhc19zc19zcCA+IGN1cnJl
bnQtPnNhc19zc19zaXplKSkpIHsNCj4gDQo+IFlvdSBjb3VsZCd2ZSBzaW1wbHkgZG9uZQ0KPiAN
Cj4gCWlmICh1bmxpa2VseShlbnRlcmluZ19hbHRzdGFjayAmJiAhb25fc2lnX3N0YWNrKHNwKSkp
DQo+IA0KPiBoZXJlLg0KDQpCdXQgaWYgc2lnYWx0c3RhY2soKeKAmWVkIHdpdGggdGhlIFNTX0FV
VE9ESVNBUk0gZmxhZywgYm90aCBvbl9zaWdfc3RhY2soKSBhbmQNCnNhc19zc19mbGFncygpIHJl
dHVybiAwIFsxXS4gVGhlbiwgc2VnZmF1bHQgYWx3YXlzIGhlcmUuIHY1IGhhZCB0aGUgZXhhY3QN
Cmlzc3VlIGJlZm9yZSBbMl0uDQoNClsxXSBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20v
bGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9pbmNsdWRlL2xpbnV4L3Nj
aGVkL3NpZ25hbC5oI241NzYNClsyXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL0NBTENF
VHJYdUZySFVVLUw9SE1vZlRnRURaazltdVBuVnRLPUVqc1RIcVEwMVhoYlJZZ0BtYWlsLmdtYWls
LmNvbS8NCg0KVGhhbmtzLA0KQ2hhbmcNCg0K
