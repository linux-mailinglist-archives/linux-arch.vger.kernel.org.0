Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E32636965
	for <lists+linux-arch@lfdr.de>; Wed, 23 Nov 2022 19:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239224AbiKWS7a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Nov 2022 13:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236940AbiKWS7U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Nov 2022 13:59:20 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11022021.outbound.protection.outlook.com [52.101.53.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8698C0AD;
        Wed, 23 Nov 2022 10:59:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwqU31AUDofkEmilDXP1d2YTz/Ds4zzOgRaNX/MwYpjZH4d8iePG5McaHbBzyV4AR/2ZTPx9cWuas+dAwP4KKxd0RYyrpwyet2IX/NujB3Gi7+Pas7W3BYtnI+a/13XLbFuEEyi75irvuQQw3kibx5zww6LbKGs2auL7zKZDgnPJwpa/Du2YNxc2kFmAb9lWD5zBmuXLqIOoYdYxACToOw1Gl+eKiovXE9r9lSTOZuSqZlPe1W/jp1q3rBykIDLmYHjexr3mcTLaabsBEETrO4JVMP1MZSqvEaFFn1Ui1kyYpTT/f4lJ3b1eu8Q6vAOlsZeX3P7R9sSe9oW8Qg6m7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tnfhErnobc/IbOGs2vXAn3LdCpEqpmjd9ngi22XelA=;
 b=kZXTc6BFErm5Ns5s8E3RKA22xpbBnY/ZwnXS6sT+ahx5GIxe82pQywpg5ePVIMhUxu+zwuhknychjaUy4aveAkxo+fOOtFzwON+SFGcmWLIxZ6yWOB2s3P3foziS9Dh8djl80W6C+s6yLXVHVLtwyQdBPHDvHfGH2OY8hEuFxV2g79zh8XRDm+bfcPFVG6G+B4cCDCIqyMkaZC5mFqsTjt2+vXa9yZ+N82bALRiJVWbQh6PBeL0Z2hdTn97wJMuDl7O0ZqHyJy6VeuyKMO0hBuMKybh0acefpoZHhcoUFP5cNsS1v149QJRbgdSRsbD4GobW9E5TJbvQx9iznWHQ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tnfhErnobc/IbOGs2vXAn3LdCpEqpmjd9ngi22XelA=;
 b=Pj4b0z918mE9ruIy2F+MVBCzX9v4RGeCaqyaa9iKJ1xI4WNnCsLX0bYmH6L8R5LXN11C0xiBXv+0cA/QUuk2LOHNKxseDax4PjAaBupfUs8XkwMsVl7TwW3jBpEVdQxrNCVXH/p2oW3vFkySUDJ+pl8MBIcQNLGm2V5znqHi4LM=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by PH0PR21MB1991.namprd21.prod.outlook.com (2603:10b6:510:1d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.4; Wed, 23 Nov
 2022 18:59:15 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817%5]) with mapi id 15.20.5880.004; Wed, 23 Nov 2022
 18:59:15 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dave Hansen <dave.hansen@intel.com>,
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
Thread-Index: AQHY/elAG0JYcbbfGkmNBxJJMMwuJ65LuIUwgAAITVCAAO31AIAAMB3A
Date:   Wed, 23 Nov 2022 18:59:15 +0000
Message-ID: <SA1PR21MB13355F9EE8F2B80A0844795EBF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-2-decui@microsoft.com>
 <18323d11-146f-c418-e8f0-addb2b8adb19@intel.com>
 <SA1PR21MB13353C24B5BF2E7D6E8BCFA5BF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
 <SA1PR21MB13350DB14A0D6EC943FEF78BBF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
 <7601f686-ed35-5329-a54d-0c5c38dbd518@intel.com>
In-Reply-To: <7601f686-ed35-5329-a54d-0c5c38dbd518@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=05f16ef9-d303-4b32-92a5-c1431cb91f99;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-23T18:56:56Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|PH0PR21MB1991:EE_
x-ms-office365-filtering-correlation-id: e7d73d78-f943-4587-593f-08dacd84d10d
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cBa1fH6TV2govnRid8SEDvVSAPT59MU2olOewTyIb7oj/hy37MQqdCCTD0Ro5EIXDUdvEaATQmen3enkfqlCuhbV24uz9+VZfSM0eimvxAI3Buqoc9h25qQ5ZW1bv7cRuH3L4vLvn80zOkTJRV8QGa4lVWh/BrNnKZFzFWdccWrrcTyY3nloiR+bN/d10dMntH0R+yYm/SCVIKZBnchAzT6HUmzFNz1NtYs4KZzfuqNBESW5Q39sa5muXHyQRWdM+At1o7ylVLN2a7wy8lkUwzWI6I2KQTGDYliTXs6mLyx0IMJtZpExUYOL2bfkk662oNg1NlF5CGa2Smmi4FKa7sVSnUahpYFMnVUZjmKiT4CJZ52QORFXl93dHCRj1c8d9WxS/JEfEzWW2LkdnNiHQYdaWF3MgQqSY/C+1hd22ecsW9Yp+EPC7T/0IDTYAdj1tfYnPB8MvBTyf9UckcD+PAXdBmeo84gUfFBgLfD20awY3gsfStK+V6FhxRrw8pvb73CfcWbS+cf0ufBiq416EEwd/c18nHhNYqYXzcO10Lp5KpSRkEomHaZwGaeKzpgqWrYkPsDgsx9azXU3QimjEZEcjfelEWxpEyE0Oxe+zcTqCAX6NeY+GQK4EWPadRKzcb0Qsy+8W/att02gby5Qp/khtqDme0dWqemBB7wOIs5NuGrqjPtCm98Ron4nh3RY8mH64GQd/FL69vLyjlLLX3pO+tKAAqtxUD9mxKcwiv3LnU0cqhe3AqW7Gx2j0fe8JQ+r8hSpukCfbvwQDOHOsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199015)(41300700001)(5660300002)(7416002)(110136005)(2906002)(38070700005)(26005)(8936002)(9686003)(52536014)(921005)(38100700002)(10290500003)(6506007)(82960400001)(82950400001)(7696005)(122000001)(53546011)(55016003)(316002)(33656002)(71200400001)(4744005)(66899015)(66446008)(4326008)(8676002)(66476007)(8990500004)(66556008)(64756008)(86362001)(186003)(83380400001)(66946007)(478600001)(76116006)(491001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Um03VUFHOWFpYVNJY1VZYzNvMjRrbytJb2hDbi83VllNSUNpbHRnZDR1cXFx?=
 =?utf-8?B?V0lwS2Z2d1ovQ0ViRUNMK3MvUjdkR1JSY0FlZFlmRDVTWEJtaHRVL3h4Rjcy?=
 =?utf-8?B?d0dOdG5XcW95ZHJWK2hQc1hta2Zia3ZXVngwcnduZ3hWbVFmQWd5c2Yxb2pM?=
 =?utf-8?B?cHEyb1NIN1gxeWxOTnhPVGVHUUNxTlUxS0M1ZzJGTll6TDUwS2JaYkxETDcr?=
 =?utf-8?B?QzBaQ2lWb0JmcEo3OFRqMWVVbmNSQXhROHcxUnFldjdHb1k4NW9NYmdsZzQv?=
 =?utf-8?B?bVdQbUY4OFplVlk3R21lNi9MZlI5K3Q5WWJsaFRka2g5QW9QU2Iya0N5QWJ4?=
 =?utf-8?B?UHlzNGdjMzk2TDVIY2ZwSzczc0ZtaHVoRUpHZTVmUTBTV3lYTVpKRXJ3dnZ2?=
 =?utf-8?B?TTFTWEhzdXUrL05SNGJuQU9VRzZYTW5qV0tKOHNrSWZYOWMrS1hHMzhBeURk?=
 =?utf-8?B?NFVjUHdlWi9PbE5KNWYzYXZFZUtBYkEvayt5c3NRenQ5WGo5VmVIYlFCaW5r?=
 =?utf-8?B?ZnpMMkluU1plM3Nkd0JPRTZHUnFxd3JvNCtFeHE1N3BRaHFjQjlYOCtlYnZn?=
 =?utf-8?B?Y3oram9YNmtzZjVNbmNpem4vQ1NOTFEraTVUSmxuTDcyckNwNklINzlsWU9r?=
 =?utf-8?B?Rmh4MUs2NldjeCt5ZWJQeTlGSytiVUZld0ZKWjMwbm1xb1phSDAzbFRDNjJG?=
 =?utf-8?B?SWVWVjZTNThUOW9lYUhCanNycGhWczFqWStmbHp3YlpMSUM1cXFaQytoYlMz?=
 =?utf-8?B?MmxjcXhYSGI0MU9HTDI3dHVIaVNVSWMwbW5rL1g2a1AyOE1vaG5CQUlEN0Uw?=
 =?utf-8?B?Z3RLZzIrTm53U1RnOUh2VXlETjFEWHJNUDhYcFZSdGgyM0NpZ3crRGxqaWpk?=
 =?utf-8?B?d0tWU1VEYjdqZ3hiS3hyR2ZQT3RuK295cVRYazdMYzVHMUVQdWh1K2EvVENr?=
 =?utf-8?B?VXRTVUlFZlpZTVVNT2hlNHZYYzVJTTRZVnBMNUUxRzlLVWlKNmJEbjBrTldN?=
 =?utf-8?B?ZkgzZ1dSRXI5MFNKa3gxV1R4MGdHUDJpbUdmV1NWTXIvNFUrN2dXeSszNjY5?=
 =?utf-8?B?TVR1T2QvckU5bFZUQkdLTy9QNlZCdnZqMkhIdlQwZXl0NkZVM0xHRFkxZmZ2?=
 =?utf-8?B?WW90NnkyNDlIUVNaN2V5ZC8ySDBpak9QYU16TWFLa1I3ZlJzZU1CUlFOVTdt?=
 =?utf-8?B?WmtESmh0ZGhIV2ZwTVUwYytvMG1EaVdvaDVCeWkzdGRmVWplYVhoUHNCSGRJ?=
 =?utf-8?B?eHE4b3VWbTJ4d3l1TGo1RmJNWEo2enN4MDVGaUF2NnB0a0JBOVg3a2pJWjR4?=
 =?utf-8?B?eUdWeSt0VXJYcWk3cTAyQ1o1RlpGS3dETE83b0ZZSTZiSnYzQzJpZE43QzBW?=
 =?utf-8?B?WjE4NzRjZmhKSHpLSlZtM0RaUnoycFQyUVR2ei82Vjl1RlhDYy8zeDJUUHNy?=
 =?utf-8?B?eFhiVzQvaXFUWXVuZzFOUWpHS0pGaHRDQXFmWVd2dXBwL3R5UU1uaHpzODBp?=
 =?utf-8?B?RkRwSTcxS05WbUJkVWtCcmE0VDYzR3BnZ0h2UmQzUTJDM1JsTm0xNE1jaGRZ?=
 =?utf-8?B?aDFDOTFGaHYyeVdlR05uTGRXVEZIRHlZYmdHcWZuby84QVh0U3puRStrVXhv?=
 =?utf-8?B?ellUOUR0b29qWEEwb20rYmRRaHhCUTBHSVhMSzRtdmtvTjZzb3Eya1o5NWxD?=
 =?utf-8?B?RnkwdnhEcUU2R0VZK09oeFlHaFlpR0lPVWNGcmwxTitURVRYakw1VEVrNldE?=
 =?utf-8?B?VVFaNEx2S2MyT0xwblZacnc1cXBlTUV1VkVQS01yMks0L2c0TnlNd0U0R2x4?=
 =?utf-8?B?R0JsUDYrQURGQzltYXZlWmN4TlpNUG50eGRTMThJWFRpN0JoRW82eDBVK2Zy?=
 =?utf-8?B?aG9Jd3Rabm1yU09DQlhzZTRNWER5UERwTlJCR0c0NlN6MWNJRnhLZ3AyMVBa?=
 =?utf-8?B?N1pGZ0pyT0pUaXpxb0hCaEk0Mld3VkluSFVTUXhlVUZsdGs3TkdOZHJBdkdi?=
 =?utf-8?B?Q0tWU0tvb1QwTVgwOEtzamJVWXJiQ3VJN2QzK1BwWHE2T3Y0QzlJWGFwd2FR?=
 =?utf-8?B?WU1sWmppMkpVVUpFSXIzLzRINmxSUjUxVzFjMnB2RmZUZDE2UlI4bjhzdTJz?=
 =?utf-8?Q?NxWOMSh8NwyCqZz7O9UPbVcGx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d73d78-f943-4587-593f-08dacd84d10d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 18:59:15.2723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DmR0cv8fOoBpwmTDjWC19FMGMuArK/PenQOOFiphnxvnaDGF609TRCKKH9TvAyx0pIqBnZDuA06lwMNw3JjMmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1991
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

PiBGcm9tOiBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIE5vdmVtYmVyIDIzLCAyMDIyIDg6MDUgQU0NCj4gT24gMTEvMjIvMjIgMTc6NTYsIERl
eHVhbiBDdWkgd3JvdGU6DQo+ID4+IEZyb206IERleHVhbiBDdWkNCj4gPj4gWy4uLl0NCj4gPj4g
VGhlIGV4aXN0aW5nIGFzbSBjb2RlIGZvciBfX3RkeF9oeXBlcmNhbGwoKSBwYXNzZXMgdGhyb3Vn
aCBSMTB+UjE1DQo+ID4+IChzZWUgVERWTUNBTExfRVhQT1NFX1JFR1NfTUFTSykgdG8gdGhlIChL
Vk0pIGh5cGVydmlzb3IuDQo+ID4+DQo+ID4+IFVubHVja2lseSwgZm9yIEh5cGVyLVYsIHdlIG5l
ZWQgdG8gcGFzcyB0aHJvdWdoIFJEWCwgUjgsIFIxMCBhbmQgUjExDQo+ID4+IHRvIEh5cGVyLVYs
IHNvIEkgZG9uJ3QgdGhpbmsgSSBjYW4gdXNlIHRoZSBleGlzdGluZyBfX3RkeF9oeXBlcmNhbGwo
KSA/DQo+ID4gSSdtIGNoZWNraW5nIHdpdGggdGhlIEh5cGVyLVYgdGVhbSB0byBzZWUgaWYgaXQn
cyBwb3NzaWJsZSBmb3IgdGhlbQ0KPiA+IHRvIG5vdCB1c2UgUkRYIGFuZCBSOCwgYW5kIHVzZSBS
MTIgYW5kIFIxMyBpbnN0ZWFkLiBXaWxsIGtlZXAgdGhlDQo+ID4gdGhyZWFkIHVwZGF0ZWQuDQo+
IA0KPiBUaGF0IHdvdWxkIGJlIG5pY2UuICBCdXQsIHRvIGJlIGhvbmVzdCwgSSBkb24ndCBleHBl
Y3QgdGhlbSB0byBjaGFuZ2UNCj4gdGhlIEFCSSBmb3Igb25lIE9TLiAgSXQncyBub3QgYSBiaWcg
ZGVhbCB0byBqdXN0IG1ha2UgdGhlIGZ1bmN0aW9uIGEgYml0DQo+IG1vcmUgZmxleGlibGUuDQoN
ClRoZW4gSSdsbCBpbXBsZW1lbnQgYSBDIGZ1bmN0aW9uIHVzaW5nIF9fdGR4X2h5cGVyY2FsbCgp
IHRoYXQgd2lsbA0KYmUgZXhwYW5lZWQgYnkgS2lyaWxsLiBUaGFuayB5b3UgYWxsIGZvciB0aGUg
c3VnZ2VzdGlvbnMhDQo=
