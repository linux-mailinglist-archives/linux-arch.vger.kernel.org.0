Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B710634D7B
	for <lists+linux-arch@lfdr.de>; Wed, 23 Nov 2022 02:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbiKWB4Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Nov 2022 20:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbiKWB4Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Nov 2022 20:56:24 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westus2azon11021021.outbound.protection.outlook.com [52.101.47.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C1D5DB92;
        Tue, 22 Nov 2022 17:56:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9Ynn+S5xFsqIPonn/CilAW42WWLTjsgZjs+NoSn7ARpagMpw8BWl/Sx9Ey9npXIOk/AzUpIEjmtQL7ThW8kF6VWKsDxWK0VpoRB4FlmtKyz2I2iWTqeA9tcPep8hnCeyAqI2FOaw1fxB0shnk9iq1silEDkfzeYa9PpLo8KnCsB2u/5Mp0Y+nNS5B8YG4s4xEsaIwtesKFtf0TQaLNNowLRPSxAGX2ojgG4Dkk10tdrzxziu1zOnVDb1qxAf4U9g/lmltxT37DVZxr3WP5X7xOf1h9WlvhNx1ZKDZuKG2zw/OosMzwVXpF1o+JRal0Ex3EcaY9jFdRgca+oNqHqCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJrnpS0HF8JKlwOnwxNX2J4pc9tyuY+Da57CpQ9zHJY=;
 b=fWU5upIfdnbl8hUPvv+Xo2QmQSRpEo8rHVEYF+P2n5c5zue2CpU6HtE/kZA8cOb6v5rDLraZYJCoYZfBffhD4V7bNCAJxyfpVaWW8KZKNxcS5imocZy0OrMeGsHxB/9N+BSb+LomoHFjDKyAL8E5RxHrSuHN0fZHRq37aoCrtVGicZoiyGJ+XSR9FHWgFoS1RbphY+JV8sowd3Q17ChGjj32kwSw0eXng3M26JHXWjVKcGhqM7rinbEAzokB6lqOblKoZjkU1Nl1FvU/Cx0PXX7wOoQsbNGnYqGRkZgu6mXpuUJQn6RUV1cKA0MP8Oaza16tzSQX/j5UsHm3T4uCZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJrnpS0HF8JKlwOnwxNX2J4pc9tyuY+Da57CpQ9zHJY=;
 b=Mn/CVC4uJwmh+j7FyKnX1YCOKXYqcv7MsFJEuReWWCDQVcda9Bb37Px11yXES589s1yZDHbX33I6IVJC9reGHfMvKjK7ovEYb0P3DQk/2Mw0ZliHsmYHfLZY2uKuDsxlfk1Akk2jRihQuZNFsy0EXlYjRa/xy51hq5Egrf0vVAw=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by DM6PR21MB1433.namprd21.prod.outlook.com (2603:10b6:5:251::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.2; Wed, 23 Nov
 2022 01:56:21 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817%4]) with mapi id 15.20.5880.002; Wed, 23 Nov 2022
 01:56:20 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     'Dave Hansen' <dave.hansen@intel.com>,
        "'ak@linux.intel.com'" <ak@linux.intel.com>,
        "'arnd@arndb.de'" <arnd@arndb.de>, "'bp@alien8.de'" <bp@alien8.de>,
        "'brijesh.singh@amd.com'" <brijesh.singh@amd.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "'dave.hansen@linux.intel.com'" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "'hpa@zytor.com'" <hpa@zytor.com>,
        "'jane.chu@oracle.com'" <jane.chu@oracle.com>,
        "'kirill.shutemov@linux.intel.com'" <kirill.shutemov@linux.intel.com>,
        KY Srinivasan <kys@microsoft.com>,
        "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>,
        "'linux-hyperv@vger.kernel.org'" <linux-hyperv@vger.kernel.org>,
        "'luto@kernel.org'" <luto@kernel.org>,
        "'mingo@redhat.com'" <mingo@redhat.com>,
        "'peterz@infradead.org'" <peterz@infradead.org>,
        "'rostedt@goodmis.org'" <rostedt@goodmis.org>,
        "'sathyanarayanan.kuppuswamy@linux.intel.com'" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "'seanjc@google.com'" <seanjc@google.com>,
        "'tglx@linutronix.de'" <tglx@linutronix.de>,
        "'tony.luck@intel.com'" <tony.luck@intel.com>,
        "'wei.liu@kernel.org'" <wei.liu@kernel.org>,
        "'x86@kernel.org'" <x86@kernel.org>
CC:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/6] x86/tdx: Support hypercalls for TDX guests on Hyper-V
Thread-Topic: [PATCH 1/6] x86/tdx: Support hypercalls for TDX guests on
 Hyper-V
Thread-Index: AQHY/elAG0JYcbbfGkmNBxJJMMwuJ65LuIUwgAAITVA=
Date:   Wed, 23 Nov 2022 01:56:20 +0000
Message-ID: <SA1PR21MB13350DB14A0D6EC943FEF78BBF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-2-decui@microsoft.com>
 <18323d11-146f-c418-e8f0-addb2b8adb19@intel.com>
 <SA1PR21MB13353C24B5BF2E7D6E8BCFA5BF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
In-Reply-To: <SA1PR21MB13353C24B5BF2E7D6E8BCFA5BF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=176f9b56-b693-4f51-b7fe-faa67c17cdfc;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-23T01:23:19Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|DM6PR21MB1433:EE_
x-ms-office365-filtering-correlation-id: 5ab734e5-1351-44f4-048b-08daccf5eb08
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5AR/q4wQUxYge/qvidNdLbaGedF8UeOiG8WTeoUL1fjyDZdh65S8lVICmHDnm+o5kibvljxSkT0ltTvvHvx+3Ac+copXAaSkW4paXzTOSPsy7mEUH+Pn5qQsoUOR5yDbjC7afE+4QwLKN0dGpPOSDwiF1c3UqI8q7KrXuqzble5yTjDrtK7eQKh2C4HeQ5oWAXZZeCtgUxW2NLxZhS6I/zqPshWvc4bF3dU5cqaciaEUqBEgOSR8/ZsDBjAm/kVcUZmSj97PrvVmH5jCgkCJv8Db02r+Eo0xFVD9RpnCva5YEDHH8pAa3rtpMffORT5HHii/ZmtBOQDgykHjUwc5UYAMmUnwLE02YMsgKAUn50XDBkoylEJN1wdS6aEIgm3cliW/TZahFDoDFVT2m4m1gHoaU/EnFKdFkfBw01kFlirkVldkZMBdNZzZpZLz597QjsibPmLdhlH4VugIDBcpkiD+JLdO7gA4BirABV4Va11ITBr0CUlcwK9lQjq25YQQNL6c+ohAzyN9VbqhPhfQVWkcmg/T902GmMHA2GcSk/y6iaZndMMpQ6afnfsj2wxJ3J4DiJq6JUqHnb+DIzt0BtNRzV3Io4Np2hYRgTjO/MD1Z0gVAj1LnlfZqDuUfnbBmRw3ekId+qtK6QfSEF7mg9i3kvQwTPcCA9JUK76b+NqjJ6tAm1kOKcrjx3CnHK6hrfLPeumNnHBaDWrcQ5CHtnDN3TqTMmZFaN8mwsqgZOVj+5wWo5Ld+xXbIvmFt/8ahoNsXAy+MrEgBjhozlWDM+soi4ZdoqIZkRsj+E7TAJ4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199015)(4744005)(7416002)(5660300002)(55016003)(33656002)(2940100002)(26005)(9686003)(64756008)(66946007)(66476007)(76116006)(66446008)(66556008)(7696005)(6506007)(316002)(186003)(52536014)(110136005)(4326008)(8936002)(41300700001)(122000001)(82950400001)(38070700005)(38100700002)(8676002)(921005)(82960400001)(83380400001)(2906002)(86362001)(8990500004)(10290500003)(71200400001)(478600001)(491001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eU9Dc1FsMjRONGJETlJkam1veGlRMi9VVEdhYzNibDFySm13VjBjenFtdFVi?=
 =?utf-8?B?RnJ0WDBQdStLUytFc2pRa2ozazl3Sm1EUDdsTWVXdE15SGY4T0xXeFZ1dE5I?=
 =?utf-8?B?K1pCRThZemM2dUdROEJXME5sa0gxTDhIVTVVVzhnaWNSa1V0dFdZM0hMOWJo?=
 =?utf-8?B?eDlXMEl2OGgvK1hMWlVIWkJ5bHVHOW0xZE5XbUVkWkhVWHJya21WdTN3WE9Q?=
 =?utf-8?B?aUkyMnV3MlZhRjlhdFNvSVhBTHRIWWE4MDdwcnQrTGowUVYzSnAzbGRQVDU0?=
 =?utf-8?B?ODhiTk9jUURWVEpUbUU0TFViMEdmRVNpQ1JJNzZPU2xXM1QyOEc4UUg2TFlk?=
 =?utf-8?B?UjZYc0xzdGxWMzhINzJXSk5DbnRZSkNMOHgwcTZURHVTaTNzM1ptUTJhV0xM?=
 =?utf-8?B?QXBIMnhRUDhkbHNadVdaV1ZhUjNIRUZrMGY2K0R0VVFzWTFLaVdJWGZYRUpC?=
 =?utf-8?B?Y1IyOVpYR2pHZEFoNFhpZTNvT2lwUStxZVpDbm92dVF3VmxSR1MyU21BUDh2?=
 =?utf-8?B?RzVNTzJ2SUFXZXRPek5LdjhXbjVzSGJEUzdEZzlGVkpGR1BuRnB6d3JkeUNO?=
 =?utf-8?B?aGpjVzVXaVJwblJIUHZYdCtGcDh3ZSt6MmRodGY5SXczNXZmbldFV0NiV0p4?=
 =?utf-8?B?WHlmUHF2My90U1ByVmtka3l4Ky9RNWZTcU5xSHF5U00vNTJNRGl3bjkrVVhS?=
 =?utf-8?B?U0gveUVoS0czTVp2ODU4bEMxTHB3VXc0RUV0U0xzMG9XTmhqK0FKQWpPZS9s?=
 =?utf-8?B?WGM0aGphb2FSQ1ZHTldkbGZvY1FpT0hqVWErbmpyL1FMWngza3JNVms0djFN?=
 =?utf-8?B?czU5OHJqOW5UdmFGUGxyb2E3dmZtWEZ4ZjZPeHlMaTlFdVpjcmYwS04xYUxH?=
 =?utf-8?B?MFpBS2Jzb083NkE4dVgyclZTaUpNbUovd3RHa3lyYnBueE9jaXdmRGJ1aTRM?=
 =?utf-8?B?emVWaHdYU0o5M25DR1doalNSUE1JT2I5ZXR5akw0OGZDTkIzeUk2QW15aHJx?=
 =?utf-8?B?cHRNblhudHBPaXEwVjZFVXpiUEhNS3YzWXZucDZUZ3VCUDV4bkdBWnVkSVAw?=
 =?utf-8?B?Uisyb1p1WFhIZ2pkT0M3dFJSaGtBajl4RGxocXRITkowaVRKcDY3U1hXMDFx?=
 =?utf-8?B?TUcvcm41dG9XRlpNNWc1U3ZGQm9XdThpT2VuRG1HZEdmVCtpQVNDZzVGdFNO?=
 =?utf-8?B?aS8wMVRUbmVmRFJnZndJdm9KSys0bm5seWFrZVlQaWs1eGVBVEplcXNhVGtC?=
 =?utf-8?B?eVRMMVIxVDBMVndtRHdwYXN0T2tWWkpvSWFLWmxheU1tUlQyeEYrVFZxUFVp?=
 =?utf-8?B?SG4zUUpVVTFydjVzaEpmMWxrK0NyYS9lZ1V0K08wc1ExRUhDOUpRV0JldUpi?=
 =?utf-8?B?WWZ3eGJnYzUxZTFucFpRUEFjRXlucm40UHgrWUFXYUJYYzIyQ2hWaTdOazZo?=
 =?utf-8?B?anBDSmY1M1pyZCtNdXFkSXZkVFFwSy9iSzk0VW4zWE9oNGhRR25Lc2pvWCt4?=
 =?utf-8?B?MzFpdklSc3pKa2VMeldQVWNvVE1lUUlmcThTNHMzVGJnMXlFZFVkVVdyQ1F4?=
 =?utf-8?B?RnAwcjJ1M2FGamxvSU5QNjlGWEJscG1iMTFSVmNoSUNXVnJRNzFIZzRUUlZa?=
 =?utf-8?B?UXN6aGpHMGx3RUJQMlFWNnRjQ3BMMk41TklMd1EvQVBxZlNyK0RnUDR6NXFm?=
 =?utf-8?B?dVZ5SFN0SHBaVWhNS1RVRld3MnZGSkZHZzhQMGxQekJDR1QzQ1oyRTI0cmNI?=
 =?utf-8?B?K0N5Z2hFc1hTMm43OWdKWU95aENGTXlxSFZWb0NxaHhwM2FTZDBDcU5jQVVi?=
 =?utf-8?B?NDBiTnVmVVlHWjl6NncxM2lzd04xYXg3aW1rbUdXR3hLMW45bGR2bnJ5dXFu?=
 =?utf-8?B?UEZxM2J6YitvV0c4Yk9CVUcvTWpHbG43U3JsZlJrY0dleXE4aWdNKzVOYXFI?=
 =?utf-8?B?VzJVc1BRK1l3bXpNQVcvUnR6RjllL2VMUnRWRGxpZkRaYmt6VzQ1c1AwYjVV?=
 =?utf-8?B?bFRhRnd6ektBSWdOb3crcE5sckdWYXQvWm5neHJ1N0NUb2hlb2MyOExLYk9i?=
 =?utf-8?B?bW50dXV6WWJlRFExMkF5RXpoanFncDdXeE9pZi9oTHEwYlVmekxHTzJqWXZl?=
 =?utf-8?Q?uLlM8KStetsOLDqMH0m+9ZRrY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab734e5-1351-44f4-048b-08daccf5eb08
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 01:56:20.8259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2DLUBmj7rHv8ESVo4VrThk9huXWV+5WZb7v0pQ9AiPMT6Oa+ZmVRYrWjgZuw3w2WlIi14XHdiSaDUkw563GeoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1433
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

PiBGcm9tOiBEZXh1YW4gQ3VpDQo+IFsuLi5dDQo+IFRoZSBleGlzdGluZyBhc20gY29kZSBmb3Ig
X190ZHhfaHlwZXJjYWxsKCkgcGFzc2VzIHRocm91Z2ggUjEwflIxNQ0KPiAoc2VlIFREVk1DQUxM
X0VYUE9TRV9SRUdTX01BU0spIHRvIHRoZSAoS1ZNKSBoeXBlcnZpc29yLg0KPiANCj4gVW5sdWNr
aWx5LCBmb3IgSHlwZXItViwgd2UgbmVlZCB0byBwYXNzIHRocm91Z2ggUkRYLCBSOCwgUjEwIGFu
ZCBSMTENCj4gdG8gSHlwZXItViwgc28gSSBkb24ndCB0aGluayBJIGNhbiB1c2UgdGhlIGV4aXN0
aW5nIF9fdGR4X2h5cGVyY2FsbCgpID8NCg0KSSdtIGNoZWNraW5nIHdpdGggdGhlIEh5cGVyLVYg
dGVhbSB0byBzZWUgaWYgaXQncyBwb3NzaWJsZSBmb3IgdGhlbQ0KdG8gbm90IHVzZSBSRFggYW5k
IFI4LCBhbmQgdXNlIFIxMiBhbmQgUjEzIGluc3RlYWQuIFdpbGwga2VlcCB0aGUNCnRocmVhZCB1
cGRhdGVkLg0K
