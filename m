Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657C9634E8C
	for <lists+linux-arch@lfdr.de>; Wed, 23 Nov 2022 05:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbiKWEBj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Nov 2022 23:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbiKWEBi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Nov 2022 23:01:38 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westus2azon11021021.outbound.protection.outlook.com [52.101.47.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE9BE221F;
        Tue, 22 Nov 2022 20:01:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzSdna6Kn84qGXevV0Y8trf3A5D2fI8/ZvMQ2VvG07vLC14lKC3pIxfW4B7Y6xNNY9GUY+nEJnnScdRzfdBucVqU8xb/8vY8tcxBXKLuHs3KZA6eXRtBpueyxFTl8PpdKt7t6X3VA4xnvlT8LdF0V9VTjHzjWHUGsNr5wzOj4A/xhqQToiKIy5u85n1df4iLMXJvNufejAV0CyVHKXdXcmBAPnY/HaC7THV87CNNVKPxl2UvBeo3WhdZXKpvkNGl5cRXEoG1vI8XqIxU4r0T4ivbPPZ7ceqpabGHlL37kdnrWX+9z4Cbz1NmF1RZaNQJgdc5xJStO3YaVQCLe6lVog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxb9oS+9XCPaLKk4gjcrKTZLDvR0udQHVLA/hJ8qjW8=;
 b=mxPKWL3tCDspyMH8W4i2xvmTY/Yp3ZCb70HzPCwqiFJ2syXPrmM3LXwaClTnOqpI0EIIxPYI1Eb1DXTp+E1GqUFoFUq4T7WzeCE/cdn7XqN7H7S/s8YxZXGBUJp69sqBw1ykmooY0nKyHSFZkWEH9zYIaNrIrGRBwlUgaphrQyuMVjD0+0u1kEX5ZUIbhQIrFSN+f0MeBJWsNVh15iDCsuPApcr9wgQ7pyPpDlq9HMEQabeZKMn07jUJ+sIbtGo1OtkbBS9bdjD5bifo3ryizq7N2xJ71EBm0fE8oPlolENZwN6XeLoJfFaTvXxYa5o18hnkKn794m4hK+emlAHp2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxb9oS+9XCPaLKk4gjcrKTZLDvR0udQHVLA/hJ8qjW8=;
 b=K8TArmk302wOZYZ2ktxOEJjjbvRzzZUWFxpo4ukgmLKAt+MHWenDMj/NBqySxZ4zGlE9EJpH084NBlJtVRTEe0RPHMBaXVp+bOIKEHfrM2cp0KiZr8dp6eHiHlSd059+HmkGX+AVEaic45FJYxNpWxpap81w3o6+HnyyrfjX5/o=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by SJ0PR21MB1950.namprd21.prod.outlook.com (2603:10b6:a03:2a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.3; Wed, 23 Nov
 2022 04:01:32 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817%4]) with mapi id 15.20.5880.002; Wed, 23 Nov 2022
 04:01:32 +0000
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
Subject: RE: [PATCH 3/6] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Thread-Topic: [PATCH 3/6] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Thread-Index: AQHY/exSZ424jDhUsEe8P9jmzKLFI65L312A
Date:   Wed, 23 Nov 2022 04:01:32 +0000
Message-ID: <SA1PR21MB1335C940B51C83D84E551EE8BF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-4-decui@microsoft.com>
 <8d3ac4ca-055a-5d54-602c-e378643ad9cd@intel.com>
In-Reply-To: <8d3ac4ca-055a-5d54-602c-e378643ad9cd@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0ad5624b-c813-4a1b-bfa1-3a2479c0d546;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-23T03:42:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|SJ0PR21MB1950:EE_
x-ms-office365-filtering-correlation-id: 28c39f24-7ff9-4ea0-ee24-08dacd076839
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7MqlToOQMbP4Np6i7/Sm7MtVpHiGkZOzIXRYjJKQjgcYuDZTYxjDm0a1CjGLhqnktRvGXH8yiGz2JcibkjewloS6TKv820NeI7kakJjPNDMApBaRVO0aZsc3Je/wjrhS95n8a4m1HyEjAcDR9fxtX+DTssu3W83XdJhx0owPOp2LSnpD7JVgFMjA5TmZtyKP5eWpXRnDZcGh5FmstTghEXbjwygHr1CBFffb2JBbjjuvDRlaqkRSZPSpl9gP5SfE8sDeViGgVW6XuPE7ovBujZt/aryXpE3qCYLX9TCjzMp3cOTlGWbQu9W0yxbvFtfcTbetR0dVz7aqwYw1Sbv7p09uQJ8YlQ6nED6zE/y082HJvQWlOOsTEcIoBCHk7yvKGZ/kB4FdJ4eaV/3tIn0B4D+DANiZ13Bms0px/QZs4mCZgr/spp3R/4bhdXR0DkHc8hW5/WotryNDm+4WBHFfK0Mhpu9Sqzbof1vydbBkPhoXgQNz5ccRBO9CpCkE9XG2C2eUrPfbsjj7brKx63m0I0wRXY5EX9U3vPLxOBGR8Zv4b4Fp64nxB8YMz4Q7zgLCiHdR5KQj36Qn8oWDsE+83stcCBzRy+CLJeXFuV2R28TK8i3Tf/frpyCzJQfwEahk9rRuOJPN0xNA4ZaKlXRD09pWmzugKlI9v3iQ76hqvtqE03uHC/gSebA6IaupzsUi+H1wg8gA1ETvOsubdUmwMGnuK2Mfob2ilcDOCGF+SccttNYaVvaPwFxFXMvgLk9MBj+cTMTm3mHzo8fSTnzUYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(451199015)(38070700005)(7696005)(6506007)(2906002)(5660300002)(921005)(38100700002)(10290500003)(122000001)(52536014)(26005)(9686003)(8936002)(33656002)(110136005)(82950400001)(82960400001)(71200400001)(55016003)(316002)(7416002)(53546011)(41300700001)(4326008)(8990500004)(66446008)(8676002)(64756008)(66476007)(66556008)(186003)(86362001)(83380400001)(478600001)(66946007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXN5MGtld21ENVdRbFIyc3M1Qk9BWVRrcXhpbjdienp3aXQ0RlZPbUpmb3Rl?=
 =?utf-8?B?Z1lyS2t2UXFpV2NUUDBBbWllSkRHT2RueGRDVUVsY1M1R1R4b2k0SzFQeERO?=
 =?utf-8?B?T1NLV3Fac0VmMURWUFlhN0IwcWNaL042VEhDN3pBQi83NkhRZjA0elpOZ3pa?=
 =?utf-8?B?ZW4zRmxIaDI3SzM4YVVtd3pHM1F1amE5RnUvd3l1eGVjbWxpZUtHTGEwWjRS?=
 =?utf-8?B?Z05KdDRSUmFXNGt6TXVnOXYrVzBsTkZGTmtibGQrMXBudi9heVR1aG16eFJp?=
 =?utf-8?B?TzlwRHRudS9yTVFYdzB0WXlMQmZLNUFJSjNmcjM2eDd6b2liVHRJRm9VZVBG?=
 =?utf-8?B?dWVyejN0YVJzd1JOMURNUUhiQzNRbTV6LzkrenJveE90U3BDTm51ME8xam9X?=
 =?utf-8?B?ZHcvU0E2RWVpUnlHL0hrL0hVb21zWFIyT1MycFJDYS9MVG9yUGNtSEFWazhC?=
 =?utf-8?B?ZUhpdXFYVm1aVDRZVnBVVVA1R2k2UW85UWxLTllHWjJjNW9TT2dSZ2hPU2RR?=
 =?utf-8?B?MG1HWWlDQWVXOS9TUFU0VlJjTWVIQWV3ZnZkWm01Tm9vWE1lYS8vd21MZHVk?=
 =?utf-8?B?MHRZemZZaVRFeDlIZ2Z0dHdTSXRITXF1M0JnbjZKNzlzdnM0aXRQbjBlVHdI?=
 =?utf-8?B?M2lRa09tL2txd1Rwd1ZEVXdjRlBUZGJpUHNUUlJMSEYvS2NBcm1nSnk3bmZv?=
 =?utf-8?B?ZTM2d1ZzVE10ak9ZQmt1MXFaa0Z2akxTZ0RxWm1KdmdiUStDNCsvZ3JDdmdj?=
 =?utf-8?B?ejhmVi9zY3oxS2lTOHdrUTNhN3NiWlFQMlUyZHIwWEtSTE42VkpFRi9acmFD?=
 =?utf-8?B?SFZxbnZnbVRyYkYwb3hReE9XNC9xRS94a0MvZCtZcVUwcnY5akdkNEJUZjM1?=
 =?utf-8?B?dmdxMCtSOUZ2bzgwampDKzNTYnhhV0ovV2pTTDl1dy93Y3VmMXR4REt6UW8r?=
 =?utf-8?B?djVVMXE5VXB0Wm1SZzRrWTV3S0hEVGVwU3Nxa21XcnlreElNVzU0ZG5reE5p?=
 =?utf-8?B?UkpoUkpvUWRMU2Z1OFV2VGl6a2tHQmMzZUUvM1E4UDJ2dUNLY1Z1UkxESUo3?=
 =?utf-8?B?NDFuMHdOekRHY2QvcUNXQXB4NUZtOGs5OTBCWkUxK3lTVFY1T2NsRXUzSnhN?=
 =?utf-8?B?eGZDQ1FSK1RaaEJsZHlBMG1ZdnFRZTBqenMyb0thMTJFZnBkOWFyM3RTbTUx?=
 =?utf-8?B?NlFBd0hLSUN2RXA4aXR5VkN6ZVZ2WVphcmpIVjBJZmp5cTE0djhxeUc3NWdP?=
 =?utf-8?B?RXZSdENPemdnWU95MWZCZ0xZWTVJeFJlQW9UN1c1ekRlK1RLaXZjM015Nlgz?=
 =?utf-8?B?anhrMkRWOFJSWmRsRC9xajh1emtadFhINUlIZGtlS0NoUUJTU0l3TmEybllC?=
 =?utf-8?B?Snl3WXN3SHY2QzFJTVo3U3lDckhBV2Z2QTNyai9ZdXRhazJLT1VLb3JPK05Q?=
 =?utf-8?B?MTJPclg0RG1vTW9VRjR3cUVTNENaY3hnYVI2Y0NwY0dtclREMW9SbVFVdVZs?=
 =?utf-8?B?ZmtRdHVrcDlmRmhNWkY5RDFEYWhjQjVFK1dqK2tRT2dJZURpT2dub3daMWN1?=
 =?utf-8?B?OEhxYkwyTks3ZnAxZG9aYjRGWkd3aVdtUXV0Q0JJVnB3WmNCUEQzQk1jc1lM?=
 =?utf-8?B?UmM3MW9PaVJic3BwK3E4MUUxWlR6L1hQbXBsd1pzTjd6Qy9HWDZZRGV2c1JD?=
 =?utf-8?B?bzBWSWR5TlZyMXVCbGl0WnJERG9sbGlaMDZlSU15N3FiZnorVG9CMVhjVHlS?=
 =?utf-8?B?SklFTE5RVGpGakZHWEJZZjFEWFdENVdPT0JqUnorT0pVL3BuUzVTbTd3R1Bq?=
 =?utf-8?B?amxTeWd3THhpR3ExYUlOUnA0cFg0dzROQnJZM25LUjdQWEZXSDBNLzZXZHBF?=
 =?utf-8?B?Y1RGeDg1Rm84RVN1Yjl1T3hodXp3bExId0RkU3Y4VklMdCtoVzlsT1JBS3Jm?=
 =?utf-8?B?ejc4dGlsQURmV2hpS0hQam83WVNxbTZmZ3hlb1NBM1p6WGlxK2pxYmNJUENq?=
 =?utf-8?B?cThOL2FOSnozQXRUNUZMWTRQa25IN09aTXVQYStRMkpBOE5VVVovWDIvYTVh?=
 =?utf-8?B?bzR0T3hQOHloaTBhRlBoc01RVjk0SS94emRUT3FZRmRoWGpPME1XMzlvOXYz?=
 =?utf-8?Q?m4VhiNQowtGfj/TfLXBVDgF6D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c39f24-7ff9-4ea0-ee24-08dacd076839
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 04:01:32.3126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +JilshdhDccAqpuEjnhOjMD/OjrGWHtNkxDAag1iUEf/3WvKreuylKlZ+hMVeWFXmDilbEoqpf+jW+6Cf/ia9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1950
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
YXksIE5vdmVtYmVyIDIxLCAyMDIyIDE6MDEgUE0NCj4gWy4uLl0NCj4gT24gMTEvMjEvMjIgMTE6
NTEsIERleHVhbiBDdWkgd3JvdGU6DQo+ID4gLXN0YXRpYyBib29sIHRkeF9lbmNfc3RhdHVzX2No
YW5nZWQodW5zaWduZWQgbG9uZyB2YWRkciwgaW50IG51bXBhZ2VzLA0KPiBib29sIGVuYykNCj4g
PiArc3RhdGljIGJvb2wgdGR4X2VuY19zdGF0dXNfY2hhbmdlZF9mb3JfY29udGlndW91c19wYWdl
cyh1bnNpZ25lZCBsb25nDQo+IHZhZGRyLA0KPiA+ICsJCQkJCQkJaW50IG51bXBhZ2VzLCBib29s
IGVuYykNCj4gDQo+IFRoYXQgbmFtaW5nIGlzIHVuZm9ydHVuYXRlLg0KPiANCj4gRmlyc3QsIGl0
J3MgZ2V0dGluZyB3YXkgdG9vIGxvbmcuDQo+IA0KPiBTZWNvbmQsIHlvdSBkb24ndCBuZWVkIHR3
byBvZiB0aGVzZSBmdW5jdGlvbnMgYmVjYXVzZSBpdCdzIGNvbnRpZ3VvdXMgb3INCj4gbm90LiAg
SXQncyBiZWNhdXNlIHRkeF9lbmNfc3RhdHVzX2NoYW5nZWQoKSBvbmx5IHdvcmtzIG9uIHRoZSBk
aXJlY3QgbWFwLg0KDQpXaWxsIHRyeSB0byBtYWtlIG9uZSBmdW5jdGlvbiB3aXRoIGJldHRlciBu
YW1pbmcuDQoNCj4gPiArc3RhdGljIGJvb2wgdGR4X2VuY19zdGF0dXNfY2hhbmdlZF9mb3Jfdm1h
bGxvYyh1bnNpZ25lZCBsb25nIHZhZGRyLA0KPiA+ICsJCQkJCSAgICAgICBpbnQgbnVtcGFnZXMs
IGJvb2wgZW5jKQ0KPiA+ICt7DQo+ID4gKwl2b2lkICpzdGFydF92YSA9ICh2b2lkICopdmFkZHI7
DQo+ID4gKwl2b2lkICplbmRfdmEgPSBzdGFydF92YSArIG51bXBhZ2VzICogUEFHRV9TSVpFOw0K
PiA+ICsJcGh5c19hZGRyX3QgcGE7DQo+ID4gKw0KPiA+ICsJaWYgKG9mZnNldF9pbl9wYWdlKHZh
ZGRyKSAhPSAwKQ0KPiA+ICsJCXJldHVybiBmYWxzZTsNCj4gPiArDQo+ID4gKwl3aGlsZSAoc3Rh
cnRfdmEgPCBlbmRfdmEpIHsNCj4gPiArCQlwYSA9IHNsb3dfdmlydF90b19waHlzKHN0YXJ0X3Zh
KTsNCj4gPiArCQlpZiAoIWVuYykNCj4gPiArCQkJcGEgfD0gY2NfbWtkZWMoMCk7DQo+ID4gKw0K
PiA+ICsJCWlmICghdGR4X21hcF9ncGEocGEsIHBhICsgUEFHRV9TSVpFLCBlbmMpKQ0KPiA+ICsJ
CQlyZXR1cm4gZmFsc2U7DQo+ID4gKw0KPiA+ICsJCS8qDQo+ID4gKwkJICogcHJpdmF0ZS0+c2hh
cmVkIGNvbnZlcnNpb24gcmVxdWlyZXMgb25seSBNYXBHUEEgY2FsbC4NCj4gPiArCQkgKg0KPiA+
ICsJCSAqIEZvciBzaGFyZWQtPnByaXZhdGUgY29udmVyc2lvbiwgYWNjZXB0IHRoZSBwYWdlIHVz
aW5nDQo+ID4gKwkJICogVERYX0FDQ0VQVF9QQUdFIFREWCBtb2R1bGUgY2FsbC4NCj4gPiArCQkg
Ki8NCj4gPiArCQlpZiAoZW5jICYmICF0cnlfYWNjZXB0X29uZSgmcGEsIFBBR0VfU0laRSwgUEdf
TEVWRUxfNEspKQ0KPiA+ICsJCQlyZXR1cm4gZmFsc2U7DQo+IA0KPiBEb24ndCB3ZSBzdXBwb3J0
IGxhcmdlIHZtYWxsb2MoKSBtYXBwaW5ncyB0aGVzZSBkYXlzPw0KDQpJIGp1c3Qgbm90aWNlZCBO
aWNob2xhcyBQaWdnaW4ncyBodWdlIHZtYWxsb2MgbWFwcGluZyBwYXRjaGVzIHRoYXQgd2VyZQ0K
bWVyZ2VkIGluIEFwcmlsIDIwMjEuIEknbGwgdGFrZSBhIGxvb2sgYW5kIHNlZSB3aGF0IEkgY2Fu
IHVzZSBoZXJlLg0KDQo+ID4gKwkJc3RhcnRfdmEgKz0gUEFHRV9TSVpFOw0KPiA+ICsJfQ0KPiA+
ICsNCj4gPiArCXJldHVybiB0cnVlOw0KPiA+ICt9DQo+IA0KPiBJIHJlYWxseSBkb24ndCBsaWtl
IHRoZSBjb3B5LWFuZC1wYXN0ZSBmb3JrIGhlcmUuDQo+IA0KPiBJJ2QgYWxtb3N0IGp1c3QgcmF0
aGVyIGhhdmUgdGhpcyAqb25lKiAidm1hbGxvYyIgY29weSB0aGF0IGRvZXMNCj4gc2xvd192aXJ0
X3RvX3BoeXMoKSBvbiBkaXJlY3QgbWFwIGFkZHJlc3NlcyB0aGFuIGhhdmUgdHdvIGNvcGllcy4N
Cg0KSXQgbG9va3MgbGlrZSB0eXBpY2FsbHkgc2V0X21lbW9yeV97ZGUvZW59Y3J5cHRlZCgpIGFy
ZSBub3QgaW52b2tlZA0KZnJlcXVlbnRseSB3aGVuIExpbnV4IGlzIHJ1bm5pbmcsIGUuZy4gdGhl
IHN3aW90bGIgYm91bmNlIGJ1ZmZlcnMgYXJlDQpvbmx5IGluaXRpYWx6ZWQgb25jZSB3aXRoIHNl
dF9tZW1vcnlfZGVjcnlwdCgpLiBBIGRyaXZlciBydW5zIGluIGEgZ3Vlc3QNCm9uIGEgaHlwZXJ2
aXNvciB0eXBpY2FsbHkgYWxzbyBvbmx5IGluaXRpYWxpemVzIHRoZSBidWZmZXJzICh3aGljaCBu
ZWVkIHRvDQpiZSBzaGFyZWQgd2l0aCB0aGUgaHlwZXJ2aXNvcikgd2l0aCBzZXRfbWVtb3J5X2Rl
Y3J5cHQoKSBvbmNlIHdoZW4NCnRoZSBkcml2ZXIgaW5pdGlhbGl6ZXMgdGhlIGRldmljZS4gU28s
IGl0IGxvb2tzIGxpa2Ugc2xvd192aXJ0X3RvX3BoeXMoKSBtYXkgYmUNCmFjY2VwdGFibGUgZm9y
IGNvbmZpZ3VvdXMgbWVtb3J5IHBhZ2VzIGFzIHdlbGwuDQoNCj4gQ2FuIHlvdSBwbGVhc2UgbG9v
ayBpbnRvIG1ha2luZyAqb25lKiBmdW5jdGlvbiB0aGF0IHdvcmtzIG9uIGVpdGhlciBraW5kDQo+
IG9mIG1hcHBpbmc/DQoNCk9rLiBMb29raW5nIGludG8gdGhpcyB1c2luZyBzbG93X3ZpcnRfdG9f
cGh5cygpIGZvciBkaXJlY3QgbWFwDQphZGRyZXNzZXMgYXMgd2VsbC4NCg==
