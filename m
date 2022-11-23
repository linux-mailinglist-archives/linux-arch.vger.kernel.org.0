Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBE3634DA8
	for <lists+linux-arch@lfdr.de>; Wed, 23 Nov 2022 03:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbiKWCPD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Nov 2022 21:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbiKWCPC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Nov 2022 21:15:02 -0500
Received: from DM4PR02CU001-vft-obe.outbound.protection.outlook.com (mail-centralusazon11022026.outbound.protection.outlook.com [52.101.63.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB593B9BB6;
        Tue, 22 Nov 2022 18:15:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTEFlDBPUisi490A8C+d5nLL8f2YMcmRE8V6YP629WVmKb9bfWrSM+AKOSvIML8pgQhIufVDEelcHWps75LOES/iGmMnBWf1mcr5SziQNfyakPMDweiZyHZQ5HJ9jZzwBhJxeJmEvAG+nyP80PG4puOOyTJFWNjG7fDn6tYTojgIiK1mZP1pRzczAV2FVTjmJe/1Wb6iN/2bvfT8psDVN36/M9Zp9MlssM+Lu/GAcZbuN4DQYL3Q144lZ7gSwilLNpLWS1KHDJqBWMA1ldfW3oWVfCYKKV0vAIeX7iuR8/04f1fEhCtETfD0Z4b0ad2/yxwQLe4UEyoQ9K52aQvC2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lf7s01APPj4JG+5dQfcLpcjGESl/REEdomfbrJSurS0=;
 b=QQeBvYzjoLMWk4eevecstrDSTdLXgUzcqkyeUbKZUICGho+wgaRUMYkLV/lSJN0MEJDsO1Pp4YIyndkj8yT4ysNETjw0dXxVHR3iek5KMpUJcK/0O2bXg/zln5La1fYQIPFec8aQ0F/33AsbDaM05VfGihUaxFpYWhx6y/aJ8pIawtvarRlZGejx7RpdHmQiPNcJAF7B+uHiCIX9dqWg3t84seSLvjzoByj1l3m7WB1a+bC1hLD7x2SZfyBIXQEiXK3s5PL3hoTnBBfvTVGuD5eS47GfXRbsnzmgfigVQCe4S2J2ovjy5Waj+StOVvq0o7CSV8qvnPS7eeZeNLYopw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lf7s01APPj4JG+5dQfcLpcjGESl/REEdomfbrJSurS0=;
 b=XGA8byE0XC15qKd0/n0KMu2vTrROwyiroBihchSyscuYFcbAWYjq9t9jgXj53rgQI1yhv44GTrQJoUt8+4hvgav+zWXVepJNkGkOd5aT0OD9m/YEbKQ7zKbrph8TIGi6BG4sRN18Vx3+wrUZJQ5Y8PiLI2BdyAfBGCJP8i43nLs=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by SJ1PR21MB3649.namprd21.prod.outlook.com (2603:10b6:a03:453::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.2; Wed, 23 Nov
 2022 02:14:58 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817%4]) with mapi id 15.20.5880.002; Wed, 23 Nov 2022
 02:14:58 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
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
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 5/6] x86/hyperv: Support hypercalls for TDX guests
Thread-Topic: [PATCH 5/6] x86/hyperv: Support hypercalls for TDX guests
Thread-Index: AQHY/eSSvJMCdibbbUqzNA0JVsxn0a5Lwurg
Date:   Wed, 23 Nov 2022 02:14:58 +0000
Message-ID: <SA1PR21MB13359D878631F5C327DE8148BF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-6-decui@microsoft.com>
 <344c8b55-b5c3-85c4-72b3-4120e425201e@intel.com>
In-Reply-To: <344c8b55-b5c3-85c4-72b3-4120e425201e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8940600e-02c4-4354-90e5-09a490922e6f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-23T02:00:24Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|SJ1PR21MB3649:EE_
x-ms-office365-filtering-correlation-id: 40fde8ca-d529-4b3b-5abe-08daccf88547
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ijx+Mu4/Fn16QStrmd/Op+QAOGjtv0ldcVd7uM/a9owECoQdWOdKAJAdWnnBTm6mR8rUccLKtplhPvdvocyMQD1nLSqFoGQw4E1qYZreniCFxZfcOPj5/dIOCeXIJAKK8W01jwprokDU38xD+1mjRaUcY8mbcrE+lHipH0aw1b5CCGWJP2sm7miiz9nIJTB7DGWQLsIOFCjXFrLnHaMvtp3D7mKgyvszBEq/BkzJOfxLmSxdKKYKHvBN5rw121NVM8Kzw+TprjtJ+S9W3wCZI6m0J6qQH+bWgp6/nx/7VTnPl4yCuFa83fAASxAJhnffTtd9u79zALV9D+Lcy08pj1v07IbgXA+PsK6Zx7asARL7hST34bNbrxNxfVHSiFBg9IS8v5q7gvt0CffDXHP5FaFR682M/A6nWji50koKhzFJfjGVHGNwbKMLOY2+zY31pcmCwIc3jUOoTH6bMlClCyjdDL29wBTPkfuDCxwHPPDDVr9ZbbwrjzGucDSz022rNxC031oJ7ky6DkZM1OrJxMfj2A7d8WwBbnkg4+RSKLPEK1dfkFg1txj380DF8baRkgqf05mkxUGXuFCOmUwq7rjwROB7p7d2k0EQANVLBypIcFCHJ253aRSA5g3nsye0KCQ7cE/MR7dpxBoH/azFsGRA2zQFCxe7AT1/hZCK0vmuCqaM8SAYuZTAVlY/FSHQdtdBqWhRAzpQpqiFBuZ/rUUNYcTnPWm3clW0r4OLJR7xRLcYZF6KxN1WEmSVYZ33B9aiu5XGtLjtpNaJ9lxoVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(451199015)(8936002)(52536014)(7416002)(4326008)(8676002)(66476007)(64756008)(66556008)(66446008)(76116006)(66946007)(316002)(2906002)(41300700001)(5660300002)(8990500004)(478600001)(71200400001)(38100700002)(122000001)(33656002)(6506007)(26005)(9686003)(7696005)(186003)(10290500003)(110136005)(83380400001)(55016003)(38070700005)(921005)(86362001)(82960400001)(82950400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVNLbU13SzU0a0dHSlpLb0FleXRYOHErcmYxYnRHb2piR29DZEV6cGlkK1V5?=
 =?utf-8?B?dkhNVU5QaGZROG1CR1BBcU42eDV0Yko3RWtwYU1Sa1dZd0lvVVg3cHVjczVT?=
 =?utf-8?B?M1hHYjhXRzRrNkN1bWFVbnpySGFNZUpyZEFwbFhmbDdtQzhNak9RcFdmSTRp?=
 =?utf-8?B?cEE4T2VPamZvNFMxejVRbEZVeUFrSDFQQldzV3FPNVhaM0xxMlRhcTVieTZ5?=
 =?utf-8?B?NXJ1MC9zQi8rSyszMEpmdEFmREZ3VVlxR2prdjBybUMvMjl6c1lMNnVDVFRi?=
 =?utf-8?B?cElpanR6eUdmUjBJSHhnbks5UU56NVJLa2hueEM2bTZmYkdYelQyR04wQTlr?=
 =?utf-8?B?R0lYYTJqOEdNNU1FYndrb0VCOUNDcm1nREFFeWU0eitGSDF6dlVMUDJ0bjAx?=
 =?utf-8?B?OHF0TVRBKzJscHdyVWtNQ01jQitvZnQvbWUyVUpzdS9nY2JDcENyNW5JTUxG?=
 =?utf-8?B?bVFoZzV1MUpiYnZqRU9NdFBVMzFsd1pjenFBNC9JZVlqOEprQWh1bXRjeUxp?=
 =?utf-8?B?Rnc0cVdRYy9IeStlWkdRNFR5Z0dtZ2ZVbDQ1b09yeVptc1NKRENTS2l4a2tW?=
 =?utf-8?B?aVArcm55dSt6UmdyaGVyaDJ3djk0ZnN1YmF5YmpEMU0xZ01YV3ZZNVRzTStk?=
 =?utf-8?B?SklBK09NbTVxZS9yNTlLUVFkSGQzSjJoSDNveHhDVmpCR2lmR0c1UnJ1ZmxX?=
 =?utf-8?B?LzVFcFdTcnFja2l2L2pnSGpLSlF3anF2U0VMTFhzZ2dMNEJzNW8vQjdLQ2hW?=
 =?utf-8?B?VGhQaGFCL1NyR1hwcGhVMFdzZThIRG52dXhlWjZoOCt3Y0FkRWhSc2gwRlor?=
 =?utf-8?B?eUt6cWY0Smk0eW94VU1ZMkNHblkwVFIyTWdmVGVhVzRCUHFjL0hucE9RL3Fj?=
 =?utf-8?B?czdBUjBDVU9JUnRuYnRyUWdLVUhrRlhCcnhzaGJLanNTYUxzTUVmN3pib3Mx?=
 =?utf-8?B?Z0JXbHMzV0hjZXQ0ZDVWMmVmWk9OblpaM09vR2xwZnZ6S014T2VnbHVaUWp6?=
 =?utf-8?B?Sk1FUlNrTWY4ZHMyZG9sZXpnVEE2b2dVT09JcG82cmdEcHU0NXJrRnNjTWll?=
 =?utf-8?B?YncraFN0ampHZVdHUDNyandOdE5HQ0FFYUNTN2FCcVFhZHc2Y0loUFFOU21O?=
 =?utf-8?B?d1dYR1hBR2x1R3lWNlR6SXFrdUkxRFUyeEhrMC9TNWlQY2FoanczQkFSYjJK?=
 =?utf-8?B?YTBVblNxVFBtQ2dMWmZjVk43TlE3cHZ1NWhlVmFyRzgwb0dmVVFsdVY0MjZF?=
 =?utf-8?B?N3pmRnZUNlJrdFNGcGZzRzZmVXM5KzlRMDFpVWR1TjM2WVF0VTB2QWJMQUNu?=
 =?utf-8?B?aTdwNjBsSGJBcEJaZHZsVXF3TVE2UVZ3eFB4RnlEVlBLOFh1WUFjMFI3ZGtj?=
 =?utf-8?B?NEZSRHJKcUdFZFJkaVBrSjlXWmxpZzNBM3ZDRkc0dklyazFxcFJYUEw3TURK?=
 =?utf-8?B?N1FXUlpwN3ZZQWtYL095ODJzUUNSVG1Lc1FtY053UWZqNzdNMU5tNlRmdHY3?=
 =?utf-8?B?dnJiRlBLU3VsQzB1RkFUQXdkQkFzVHdlWUNVcE8vQXRuTmNzNHBtYUlHTnRq?=
 =?utf-8?B?ZVBNQVhEY1FSZ2l3UnF6d3Z0MGVHV1JkejNLdFZTQWMvYnpHMzlyLzY4RGRp?=
 =?utf-8?B?K0JvNnkxeWZJSGlqR095UUZLTnhMS2Rpa3RzTkFxNUZnUFFzdklFUWY4dFhi?=
 =?utf-8?B?emFxcEh4TkdIY0xnNkZ6N2g1TW00WWJkV0xUS0N4bHQxcmZkeDVoOW9aZTNk?=
 =?utf-8?B?UDZqSTBnWGJaci9nMHNxTFhCaXlJZWN1cUxtQzZMK1R3ekd6STRkZTFPYytQ?=
 =?utf-8?B?R1lIeWtqNUd0a0hZMDJpSEVXUHNIelRUakFiTTF2N2Y1NkliYVlBTWQ3MzFl?=
 =?utf-8?B?c3RVRVFORFViamRCTjIyNTAzcUNhQzlqZllXOXY0alpsTlFEVU5HRHRhTUJJ?=
 =?utf-8?B?QkZtWDVSWE00MTZHNHdtTE1vNXp4L08xM054MkVrMTZ2OXd2VFRMdElkSHNK?=
 =?utf-8?B?YzduZkZmNTk2UkVzN0x3aU5LZmFtanM1bDdoMjErRlpEMGIrUWVLZkVJWXNX?=
 =?utf-8?B?YmxBalB6NEpIVDBFMERwTWd3R3EyM1kyMkJtcENMNWY0L1ArZjlqWEdHK0Zu?=
 =?utf-8?Q?0PQcPLqHJIs4qX07UhYFElKh8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fde8ca-d529-4b3b-5abe-08daccf88547
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 02:14:58.6191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v6wRsOP5Smhz2A6XvJe5V4zIdfJHgwsn1nRbw1p4HS/cHsEnoka4if3yix6OvqWnsQ0KE0Y+9W3LhB/gU/ixfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3649
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

PiBGcm9tOiBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AaW50ZWwuY29tPg0KPiBTZW50OiBNb25k
YXksIE5vdmVtYmVyIDIxLCAyMDIyIDEyOjA1IFBNDQo+IFsuLi5dDQo+ID4gICNpZmRlZiBDT05G
SUdfWDg2XzY0DQo+ID4gKyNpZiBDT05GSUdfSU5URUxfVERYX0dVRVNUDQo+ID4gKwlpZiAoaHZf
aXNvbGF0aW9uX3R5cGVfdGR4KCkpIHsNCj4gDQo+ID4gICNpZmRlZiBDT05GSUdfWDg2XzY0DQo+
ID4gKyNpZiBDT05GSUdfSU5URUxfVERYX0dVRVNUDQo+ID4gKwlpZiAoaHZfaXNvbGF0aW9uX3R5
cGVfdGR4KCkpDQo+IA0KPiA+ICAjaWZkZWYgQ09ORklHX1g4Nl82NA0KPiA+ICsjaWYgQ09ORklH
X0lOVEVMX1REWF9HVUVTVA0KPiA+ICsJaWYgKGh2X2lzb2xhdGlvbl90eXBlX3RkeCgpKQ0KPiA+
ICsJCXJldHVybiBfX3RkeF9tc19odl9oeXBlcmNhbGwoY29udHJvbCwgaW5wdXQyLCBpbnB1dDEp
Ow0KPiANCj4gU2VlIGFueSBjb21tb24gcGF0dGVybnMgdGhlcmU/DQo+IA0KPiBUaGUgIm5vICNp
ZmRlZidzIGluIEMgZmlsZXMiIHJ1bGUgd291bGQgYmUgZ29vZCB0byBhcHBseSBoZXJlLiAgUGxl
YXNlDQo+IGRvIG9uZSAjaWZkZWYgaW4gYSBoZWFkZXIuDQoNClNvcnJ5LCBJIHNob3VsZCB1c2Ug
I2lmZGVmIHJhdGhlciB0aGFuICNpZi4gSSdsbCBmaXggaXQgbGlrZSB0aGUgYmVsb3cuDQoNCkkg
ZG9uJ3QgdGhpbmsgSSBjYW4gZG8gb25lICNpZmRlZiwgYmVjYXVzZSwgaW4gdGhlIGhlYWRlciBm
aWxlLCB0aGVyZSBhcmUNCmFscmVhZHkgMyBleGlzdGluZyBpbnN0YW5jZXMgb2YgDQojaWZkZWYg
Q09ORklHX1g4Nl82NA0KI2Vsc2UNCiNlbmRpZg0KYW5kIEknbSBqdXN0IGFkZGluZyBhIG5ldyBi
bG9jayAiI2lmZGVmIENPTkZJR19JTlRFTF9URFhfR1VFU1QgLi4uICNlbmRpZiINCnRvIHRoZSBD
T05GSUdfWDg2XzY0IGNhc2UuIEZXSVcsIENPTkZJR19JTlRFTF9URFhfR1VFU1QgYWxyZWFkeQ0K
ZGVwZW5kcyBvbiBDT05GSUdfWDg2XzY0Lg0KDQotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9t
c2h5cGVydi5oDQorKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc2h5cGVydi5oDQpAQCAtNDgs
NyArNDgsNyBAQCBzdGF0aWMgaW5saW5lIHU2NCBodl9kb19oeXBlcmNhbGwodTY0IGNvbnRyb2ws
IHZvaWQgKmlucHV0LCB2b2lkICpvdXRwdXQpDQogICAgICAgIHU2NCBodl9zdGF0dXM7DQoNCiAj
aWZkZWYgQ09ORklHX1g4Nl82NA0KLSNpZiBDT05GSUdfSU5URUxfVERYX0dVRVNUDQorI2lmZGVm
IENPTkZJR19JTlRFTF9URFhfR1VFU1QNCiAgICAgICAgaWYgKGh2X2lzb2xhdGlvbl90eXBlX3Rk
eCgpKSB7DQogICAgICAgICAgICAgICAgaWYgKGlucHV0X2FkZHJlc3MpDQogICAgICAgICAgICAg
ICAgICAgICAgICBpbnB1dF9hZGRyZXNzICs9IG1zX2h5cGVydi5zaGFyZWRfZ3BhX2JvdW5kYXJ5
Ow0KQEAgLTk3LDcgKzk3LDcgQEAgc3RhdGljIGlubGluZSB1NjQgaHZfZG9fZmFzdF9oeXBlcmNh
bGw4KHUxNiBjb2RlLCB1NjQgaW5wdXQxKQ0KICAgICAgICB1NjQgaHZfc3RhdHVzLCBjb250cm9s
ID0gKHU2NCljb2RlIHwgSFZfSFlQRVJDQUxMX0ZBU1RfQklUOw0KDQogI2lmZGVmIENPTkZJR19Y
ODZfNjQNCi0jaWYgQ09ORklHX0lOVEVMX1REWF9HVUVTVA0KKyNpZmRlZiBDT05GSUdfSU5URUxf
VERYX0dVRVNUDQogICAgICAgIGlmIChodl9pc29sYXRpb25fdHlwZV90ZHgoKSkNCiAgICAgICAg
ICAgICAgICByZXR1cm4gX190ZHhfbXNfaHZfaHlwZXJjYWxsKGNvbnRyb2wsIDAsIGlucHV0MSk7
DQogI2VuZGlmDQpAQCAtMTMzLDcgKzEzMyw3IEBAIHN0YXRpYyBpbmxpbmUgdTY0IGh2X2RvX2Zh
c3RfaHlwZXJjYWxsMTYodTE2IGNvZGUsIHU2NCBpbnB1dDEsIHU2NCBpbnB1dDIpDQogICAgICAg
IHU2NCBodl9zdGF0dXMsIGNvbnRyb2wgPSAodTY0KWNvZGUgfCBIVl9IWVBFUkNBTExfRkFTVF9C
SVQ7DQoNCiAjaWZkZWYgQ09ORklHX1g4Nl82NA0KLSNpZiBDT05GSUdfSU5URUxfVERYX0dVRVNU
DQorI2lmZGVmIENPTkZJR19JTlRFTF9URFhfR1VFU1QNCiAgICAgICAgaWYgKGh2X2lzb2xhdGlv
bl90eXBlX3RkeCgpKQ0KICAgICAgICAgICAgICAgIHJldHVybiBfX3RkeF9tc19odl9oeXBlcmNh
bGwoY29udHJvbCwgaW5wdXQyLCBpbnB1dDEpOw0KICNlbmRpZg0K
