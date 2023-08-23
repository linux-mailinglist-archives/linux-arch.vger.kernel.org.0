Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAEE785ECF
	for <lists+linux-arch@lfdr.de>; Wed, 23 Aug 2023 19:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237868AbjHWRkW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Aug 2023 13:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236627AbjHWRkV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Aug 2023 13:40:21 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2122.outbound.protection.outlook.com [40.107.96.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2793BE5A;
        Wed, 23 Aug 2023 10:40:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gB1hrVZjwhJJMcBIqlgJmTmolvM8+v5GNPW12EhO+uXWbb9jHhDcB+zYwbsWRTTpEmt/xUbnDpg153vjV8k5hE1D1C9IsmKPB9GOLw0TE6dYT5UqU90cwzwFs9PDC5KVyZn3vQZuOoPsLkcJiiB8KCeFRUMXwylrvrLTSGOOMayWCxxXDzrBT+bMxdd/aY90ASpL3/gOe1YFctzu/391/uGoqTDh/6OuRy4czmNXg8JxNb+HXQUSkdXQDJoa/3+64pSqeaBLhcjXhOfN3MUfLKHYNJmQwsLQDXiGMrBAAdwTjPNmlq5F4V2q6+bWIS5vHg0KwLughZEDWSQKx3rzFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91BPTtMxEg4FVb6B4ph7rmcckph/0g/G/Jw7SOSua0k=;
 b=Fwt8iQ3+UoGncuHIhWv+T2izwRs0SLvsYmNm1U1JxBaAZcXxwJ8BoKggbaxSXO0wYFvsr5gcHf2Wp1UOOXmO2vIligIgRsuBXAmjVr5NzhL5OSGD6sovbzdAxUp+ABk7+F57GzZCCPmnZSchNZ+dfqXP4YBah4TV7KNvoHe+86b8V/1TVP7oAuvdxPrxwagLxTI5oU3GsLCXEPplVhfoMv04qV5SrdFXXgTHX3GUKBjdpRCimYC6BL8OklHOSfs6F8oRgIgrzC/VYdtdrDCC8mUm17K4KK1UO0yNFfFLvFdu9xtVrVr13Q/e+ywBSmMt3Lo88MGPnrHyrPoIMSRW+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91BPTtMxEg4FVb6B4ph7rmcckph/0g/G/Jw7SOSua0k=;
 b=Kn+BxKzzblZ6PRJLKDc3Vpfsjy1tM6TQtObZhBv/Jba1amCPz68dub6m7mSx7FpME5CIOXqwR49YZYhoQkjE+Gsg2aR2sDh3AoJPhOskIZAq4/u6vdw5FpKpY2MjqUlVtoXWMKDldcG5MiJoxk+RcDJ3liEnLwTN7FtnjSTS9Z0=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by MW4PR21MB3823.namprd21.prod.outlook.com (2603:10b6:303:223::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.5; Wed, 23 Aug
 2023 17:40:15 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f%5]) with mapi id 15.20.6745.005; Wed, 23 Aug 2023
 17:40:15 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Tianyu Lan <ltykernel@gmail.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>, jason <jason@zx2c4.com>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        Anthony Davis <andavis@redhat.com>,
        Mark Heslin <mheslin@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "xiaoyao.li@intel.com" <xiaoyao.li@intel.com>
Subject: RE: [PATCH 2/9] x86/hyperv: Support hypercalls for fully enlightened
 TDX guests
Thread-Topic: [PATCH 2/9] x86/hyperv: Support hypercalls for fully enlightened
 TDX guests
Thread-Index: AQHZ1ZBV0WzhzxgTlUOjIYIaUsLzFa/4JQxg
Date:   Wed, 23 Aug 2023 17:40:15 +0000
Message-ID: <SA1PR21MB1335A994B0EAD226CF2D15FEBF1CA@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230811221851.10244-1-decui@microsoft.com>
 <20230811221851.10244-3-decui@microsoft.com>
 <6ba2366a-5a7a-839c-6b7a-3500a43c3d93@gmail.com>
In-Reply-To: <6ba2366a-5a7a-839c-6b7a-3500a43c3d93@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=79b55e83-6ce1-43fa-880e-f12ea38f419b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-23T17:34:37Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|MW4PR21MB3823:EE_
x-ms-office365-filtering-correlation-id: dc497ab4-885d-49d7-5483-08dba40002b3
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t+dQsmwHAjJbEiISKDtDBT24mpdSr4ZMdyWWwB8JdDk0LUQ+oZUGmZ+4HHPIk8gy7HXNzyouCnp979f8Plzxsg5tpLi2KWCB+4btsJo1weidadP2S8eWJBqE0QOgy1sM+uVxwFWXqxa26E19dB8eL7+6gHbQ+7+RNrd1N6Z1AWbkx+95hlb4aTFtCB+MusbDkVB9tMWump3ryYCQzuY4Kr3OUrnl7bih+8xzn2790doR2i8HNCrY5jZGAkdIVj9NZowJzpMjNg5/+m/71LBrS9yTsrQgCXWo302Ac1ti+SVy+oxPjFe43AQHamd/NkztnnFiN59elxfltQh5dwUQzK5qAhsijTZfGK1es5zz5eevwfafd1IGMvHxr73KDlrIgQGwHlcyfGoRh2eqftP4JdvlcRGo5bQkeLRi6fCVLGuTO+EHf9urKuOCPO24YTIbrrF1Nf8zE5Z7r8IKcYFSrxWWcz1klLz3WPj8xdzsQzylg68i+dO+2RcsgMEaoZTYMAUNoQUt9ZnJYpwrj/pjjLAjULZHzq9feO2/px7b+RaCXIJOAoeGdiRstV+54zlgVEmL0Urjug2IQ3bqfuIUKZMg4WLLhiVm1h3zOMta+bU7gfVrZZN7gMJ/AFCE8A0H5tR4LL4qIEVrt4bOXtrWMfXXhgCKg96BSbjUyfWWPT/MKIS1DSmEeOZAkgXQxXJiDeZAaWNA8IlGVMj8lsB54g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(376002)(136003)(1800799009)(186009)(451199024)(71200400001)(55016003)(8676002)(8936002)(4326008)(110136005)(66476007)(66946007)(66446008)(66556008)(54906003)(64756008)(316002)(6636002)(10290500003)(478600001)(12101799020)(76116006)(53546011)(41300700001)(6506007)(7696005)(9686003)(38100700002)(82950400001)(921005)(122000001)(38070700005)(8990500004)(82960400001)(33656002)(7406005)(2906002)(7416002)(86362001)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bE9VTlRucVlWenVnTTBLT0Fhb2hnU2JqZGcveUg1UHdsT2pxMmtvdmpUWXNq?=
 =?utf-8?B?eWgzakZiaVd5bk9EckF6Rld2RXlDRkdkdDlKdUxyVnRXeHdjZVZnYVlkbUdM?=
 =?utf-8?B?YVA0MDFlVjFiZUF6ZHV4SnRHTG4yNS9rRnFwYXhkYXEyTEVwSUgrbzh5ZG94?=
 =?utf-8?B?cFdnS09nbHhncjMzd050TVhYUENRUWJPdlEzZEFJanhOYTFSM2ExVGJKOHlU?=
 =?utf-8?B?bGZKcUxDVlROVXpjamtFUGh4a1ZvTlgyUTBiRm8wSkhwNDNwa1JOUTlKSU9z?=
 =?utf-8?B?a2pDNjN5UDRzRnJMcG9pWkxwL3BmNW9INlFkaXVOcVlkTkVIdnNCU0lHTm5J?=
 =?utf-8?B?bitPbHlQUWlOc3M2QUNlL3c5WUtYWlZ2WHF2eWh0WDk4ZWJmK2JaT1Z3M0dE?=
 =?utf-8?B?S0t4a0tReFA2OFhyTlVxbkZzZjhXVW1mUHB3eXJYZkpKY0UwZVREVXZhRTZh?=
 =?utf-8?B?K0RUc1hCTG10WW45L21FNlZuQng0MWpqZ2UyWkFFQ1pBaUw3ZVlOT2QxNlVR?=
 =?utf-8?B?K2svaXVXWXk0OHp3dGYxL2Rnb3JFL0lKSWVhcHlWaGtLRTVlbm43NUJGeG84?=
 =?utf-8?B?VHk5amhuV2duV09tSFJheTZCVGlxdFNJMWpRZDRkZkZ0dlJoNGMxb0M5cmFv?=
 =?utf-8?B?U2pqbFR2cHNidDZ4bDRqOVNVb1RWRzdTeGY2THdwSWYvUnZMUmkwMVBZVEVY?=
 =?utf-8?B?ODRKV056ZEx0YzU0NjhuQ2JsWmw1U1ZVeGZuSnROYUpKcGgycDc0VDdrbGRz?=
 =?utf-8?B?Y1NDRjVxbWpxN2lkc0Myd2NoODloTHF4cGVaZWlwVVJCblFiUXFHajIzcHVx?=
 =?utf-8?B?bFlqemZVY05FNHpPRjlZNUhMSEMvOHNwdSs4TitTRE10amRTN2MxSm5lVk1T?=
 =?utf-8?B?VG1pUXMvSjFTQk9yWCtRWkdCMXFtV1l5WkdLeEdZQnRVOXdYYU92THVYRWJ4?=
 =?utf-8?B?YWEyTlJGL1BiTjNKOVV3ZURLUHBjNGJubVlpRC9vbUxoMXUzOVFqcXZaWmFR?=
 =?utf-8?B?TzdEUWQzT3FlTW9TczRjeFJCc25QeHQyY2taYy9TQys0YWZsM3JxbzluNXlP?=
 =?utf-8?B?WHV1ZnVNT01rdW5QZHpnOEhZOE1OSmtDVDM1L1dscFBqVFBoUDlvYXJucHll?=
 =?utf-8?B?Zk5veUQvTnJ5NWdCSk5UMWUxS3FsVEdaL3VXRkNGbmdpS0dpY3R5WUdUbFk5?=
 =?utf-8?B?RmMrdmhjTE5oeE41cjh6WFNtc3pOZ2RmQkNTSmtmNVA0eTBSN1R5NUdhUmxU?=
 =?utf-8?B?Um13RlAwNkVkVXVTTkJpRmhJUlFoejJiZmRLUGZzQ0ZaQWhHdnZyRGFqQzJ0?=
 =?utf-8?B?MFlySW9QNnRoYkVkLzBhMWZkckVxUWZRT0J4ZklwZnRJc3pjV1ZneUNCYk0v?=
 =?utf-8?B?QjBnSFhUOW5qOGU2QndKeDV3Q3VSaWJWVlZ4NVRpKzVheVdvWU9WNXNRbGZu?=
 =?utf-8?B?WEdwamVtU1BaMldzTHNYeFVhMndsRmtabzRpcXRvTXNXQlFydnVPbXBIWHpj?=
 =?utf-8?B?bGVheVZ5VU9INm92L21qRSttM0RaenlYcFlxcUE3aVlmUTB5b00zcnkrU3ht?=
 =?utf-8?B?bWhGTkpCeUVPMHVWYVErT3BXUjdHdHBsa3IxcWdZOUZKcEtYUURpQTg3NHpO?=
 =?utf-8?B?dmZMa3VQVyttbXNaS08rL0hCMk1yMGhyTC9STXpQbXg4emZKUW5NaURGQ1dS?=
 =?utf-8?B?czBZZTVHa2hmTlR1TFlybXBKSHhxdWNCVDZaKzVodGtyUEZvNzRFbi81VXcr?=
 =?utf-8?B?QlRkOVpJektkRFUxL1dlY01JSzBsTnVOTXFxNDM2WEJpbmN3WC9uZGJxWnF6?=
 =?utf-8?B?QzZlNzZPL01Jd0V4cytBQUZ3ZFJ3RFYvVjQwZXdLbWZhWDhtNXRxRnRFcWlE?=
 =?utf-8?B?eXJpaTY4enk2MlVwaHVqWG9CZUYxeVVyTXgzYjZpUkhEN0xmK05EUXV3L1ZO?=
 =?utf-8?B?S0J5NXpoOWVlNllKSjQ3c2FUc0w1UDhrM0JVdmJVM21PUm1VZDhMOWNxNkQw?=
 =?utf-8?B?MU00ZmlIaU9iMnliL1VoYjlsVGUzc2h1RjY5by9zeEE0Rjk2TjFENjJxT3Zi?=
 =?utf-8?B?QXA3ejNUNUNCS2l6TlN4dVlxZnR6S09seUw1U3JRVWdIVSt0ZjlTbFlTV3RV?=
 =?utf-8?B?emNLOEF6d2ZXaDJZVWFBZWY4a24yd2pzRUw5dTNlWWFla1RqN2htcFh5TWg2?=
 =?utf-8?Q?vMEnmT3ffN3On7Mq4AucEc6ibb2yQ7F4IrzAiPnzhYq+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc497ab4-885d-49d7-5483-08dba40002b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 17:40:15.5093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kTR3fcs0BcxvudUFh4MGBxTRHME+kUzq8ldphv7asvVIaqpjxt4TpOevkgSOGkqQbfY5rtItGtBTkxFOr/+S9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB3823
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

PiBGcm9tOiBUaWFueXUgTGFuIDxsdHlrZXJuZWxAZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNk
YXksIEF1Z3VzdCAyMywgMjAyMyAxMjowNiBBTQ0KPiBUbzogRGV4dWFuIEN1aSA8ZGVjdWlAbWlj
cm9zb2Z0LmNvbT47IGFrQGxpbnV4LmludGVsLmNvbTsNCj4gWy4uLl0NCj4gT24gOC8xMi8yMDIz
IDY6MTggQU0sIERleHVhbiBDdWkgd3JvdGU6DQo+ID4gQSBmdWxseSBlbmxpZ2h0ZW5lZCBURFgg
Z3Vlc3Qgb24gSHlwZXItViAoaS5lLiB3aXRob3V0IHRoZSBwYXJhdmlzb3IpIG9ubHkNCj4gPiB1
c2VzIHRoZSBHSENJIGNhbGwgcmF0aGVyIHRoYW4gaHZfaHlwZXJjYWxsX3BnLg0KPiA+DQo+ID4g
SW4gaHZfZG9faHlwZXJjYWxsKCksIEh5cGVyLVYgcmVxdWlyZXMgdGhhdCB0aGUgaW5wdXQvb3V0
cHV0IGFkZHJlc3Nlcw0KPiA+IG11c3QgaGF2ZSB0aGUgY2NfbWFzay4NCkknbGwgcmVtb3ZlIHRo
ZSBhYm92ZSBzZW50ZW5jZSwgc2luY2UgdGhpcyBpcyBubyBsb25nZXIgdHJ1ZSBvbg0KZ2VuZXJh
bGx5IGF2YWlsYWJsZSBIeXBlci1WOiBjY19tYXNrIHN0aWxsIHdvcmtzLCBidXQgaXQncyBub3Qg
cmVxdWlyZWQuDQoNCj4gPiBbLi4uXQ0KPiBSZXZpZXdlZC1ieTogVGlhbnl1IExhbiA8dGlhbGFA
bWljcm9zb2Z0LmNvbT4NClRoYW5rcyENCg0KPiA+IC0tLSBhL2FyY2gveDg2L2h5cGVydi9odl9p
bml0LmMNCj4gPiArKysgYi9hcmNoL3g4Ni9oeXBlcnYvaHZfaW5pdC5jDQo+ID4gQEAgLTQ4MSw2
ICs0ODEsMTAgQEAgdm9pZCBfX2luaXQgaHlwZXJ2X2luaXQodm9pZCkNCj4gPiAgIAkvKiBIeXBl
ci1WIHJlcXVpcmVzIHRvIHdyaXRlIGd1ZXN0IG9zIGlkIHZpYSBnaGNiIGluIFNOUCBJVk0uICov
DQo+ID4gICAJaHZfZ2hjYl9tc3Jfd3JpdGUoSFZfWDY0X01TUl9HVUVTVF9PU19JRCwgZ3Vlc3Rf
aWQpOw0KPiA+DQo+ID4gKwkvKiBBIFREWCBndWVzdCB1c2VzIHRoZSBHSENJIGNhbGwgcmF0aGVy
IHRoYW4gaHZfaHlwZXJjYWxsX3BnLiAqLw0KPiA+ICsJaWYgKGh2X2lzb2xhdGlvbl90eXBlX3Rk
eCgpKQ0KPiA+ICsJCWdvdG8gc2tpcF9oeXBlcmNhbGxfcGdfaW5pdDsNCj4gPiArDQo+IA0KPiBO
aXRwaWNrOg0KPiAJUHV0IGh5cGVyY2FsIHBhZ2UgaW5pdGlhbGl6YXRpb24gY29kZSBpbnRvIGEg
c2VwZWFyYXRlIGZ1bmN0aW9uIGFuZA0KPiBza2lwIHRoZSBmdW5jdGlvbiBpbiB0aGUgdGR4IGd1
ZXN0IGluc3RlYWQgb2YgYWRkaW5nIHRoZSBsYWJlbC4NClRoaXMgaXMgZG9hYmxlLiBUaGUgaW50
ZW50aW9uIGhlcmUgaXMgdG8gbWluaW1pemUgdGhlIGNoYW5nZXMuDQpJbiB0aGUgZnV0dXJlLCB3
ZSdsbCBpbnRyb2R1Y2UgYSBoeXBlcmNhbGwgZnVuY3Rpb24gc3RydWN0dXJlLiBXZSBjYW4NCmRv
IGNvZGUgcmVmYWN0b3JpbmcgYXQgdGhhdCB0aW1lLg0K
