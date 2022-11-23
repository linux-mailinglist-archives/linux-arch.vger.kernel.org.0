Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20908634D54
	for <lists+linux-arch@lfdr.de>; Wed, 23 Nov 2022 02:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbiKWBho (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Nov 2022 20:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235141AbiKWBhc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Nov 2022 20:37:32 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westus2azon11020017.outbound.protection.outlook.com [52.101.46.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023931157;
        Tue, 22 Nov 2022 17:37:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsExKRm/4x/SyLw8M1uyrdnCYxEXxFuRVqkkO0A9JrMrJzrj+WB5y4LyIiK5qxA+07RgCdS+nkTDv+DYCAPN5brNdRKup65SgS9oDLoYnij920KFUpSxwFIspXSG8bGcAQr3NJTEdpPVOWvQnu9GSKlG2dAG7+NJ1Hueb/g918xOTzp0ts2MiKBIAzE5LPDWu91JiYLVkvoIXgw6heEbEKHxaEnCnzVpoDozBo8GE0MI5bDnXQxTRiT8KDIYyKu363Qkes0/XVJW7JhD6g9rX4EY3Fe6UCFmufUzDc2PWqmfUNFq06Y8zIYbr8MeE60qFVza7epr/nJ/KtGoBt8Y2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOZZeMJ5Vv0UaOqe52t7X+VywTwEyGbLeYElT0Sksr8=;
 b=Ymnw/xci937rg3aHVn1RmhU//VOeefr2hzSIzwNIsmH6/0IONtF8fjiiqv77KpC8g7/IiEPfTI4yXykz95DRjXrw2Xrv54El2tdKn9XNTOxKToltTP5eEHS5ApSOa9q5nsop3WgJG1E5YQDLuTUHLJHPTYxP9v+XsKbrv/Yb+3uGSSTFQNh7YaQz9tMD4TCy7xEb7Rn6EhGKZrm4rvu0pZvqc7Q9K2eT56lN6hRjGTBvvRJ3URN+bAETFDV7Jn1+z7+d6NKcHOch3lmNtS8acMdLxPYA4h++DARavmCHBwCGLA3rQVWx7BioB7rwBnzFhIhV5cSa02vpoJxgZcHKaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOZZeMJ5Vv0UaOqe52t7X+VywTwEyGbLeYElT0Sksr8=;
 b=RGNzOnqP+j8tyDkqCdPj8Am2ugJe0ppF4J9n6rvesFvTt3OjNTFbTq0jg9Nfz3gNc+hluUiMQWcvj4waHSup1yh92pfzRd17s7j25T2N8rb1CPj9d8CSjC7BVzMtH4ZZ19k8f9QrQ+YpBR2shpfOC26SQFX+f9941D2x5WH0jko=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by DM6PR21MB1467.namprd21.prod.outlook.com (2603:10b6:5:22f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.1; Wed, 23 Nov
 2022 01:37:26 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817%4]) with mapi id 15.20.5880.002; Wed, 23 Nov 2022
 01:37:26 +0000
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
Subject: RE: [PATCH 1/6] x86/tdx: Support hypercalls for TDX guests on Hyper-V
Thread-Topic: [PATCH 1/6] x86/tdx: Support hypercalls for TDX guests on
 Hyper-V
Thread-Index: AQHY/elAG0JYcbbfGkmNBxJJMMwuJ65LuIUw
Date:   Wed, 23 Nov 2022 01:37:26 +0000
Message-ID: <SA1PR21MB13353C24B5BF2E7D6E8BCFA5BF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-2-decui@microsoft.com>
 <18323d11-146f-c418-e8f0-addb2b8adb19@intel.com>
In-Reply-To: <18323d11-146f-c418-e8f0-addb2b8adb19@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=176f9b56-b693-4f51-b7fe-faa67c17cdfc;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-23T01:23:19Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|DM6PR21MB1467:EE_
x-ms-office365-filtering-correlation-id: d58246d4-fd87-4065-df72-08daccf346a9
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z6f7bVlCGH0mNKu6EUaK6oFprlvhNAS9C/yf8tqbcKOecxLTYpQsKqSd/xSQ3jYKObsJpGZnfWtO0Q76jdYIYb55+CMZ9GcCAFIcQEeqgnsTYnTVr+h+tjQEAxtij9b/dTCuoh1P1/k+67UI8L57RQm0j6DlnovaKOj6jItkyPb+GbSRMrvAFOD0K6TtPNah6AK/qcigb7qb87uK8NUGASX9gszlUV48pl5nhyxvxJTAYHJdduzVy5l5If5wiz+S9dwul1VXB6ld0f3zXbjhGpMF3K3/o9XMGu4Jcx90qSW7t7Z7JBllWoQvbo+KpHk4jvpLRw3izGxiiQsivppE2+gujWVbiQzekN+IVr5J3b0y9F5IHOeSNjOy4sjjtoaixXzGin4FslEbFj+2af25UEasaiLNDXKrqDIM5y1/YJ9DbGell08IZ0ndPqPYm5vsbQ4ayMr6iUEOKL1w5MnEauDf8A6yWpzMraQIzTTeLTOVrGqkm4U6+27Az70j4kt3fouewOkTEeOe2kcOV0KMeSRAoqPttMDgDaTRfCx/LYcMIuLxiC3NmDZPlXPIFT+KeaoREnCElC2naPtfam/IDBgU505ZbNpnMe37MthYYDovSep8qZzcHQXMQ1jDpL1/vRNKXirqi/dlXlUMRCfdbMC4zLLU1YUyiS2x9Ut5r71HVFAUsfeOZtYUeMSceyfRzee3k/bQeEmByw/AamC/8XKJ1XziANNzmqFHkdSgmewTBiVESWov/NHvv35tk2h3nrYm5d4/eMXtxltPsiyIVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199015)(10290500003)(8990500004)(2906002)(86362001)(478600001)(71200400001)(9686003)(8676002)(53546011)(66556008)(76116006)(64756008)(66446008)(66476007)(66946007)(33656002)(26005)(186003)(52536014)(6506007)(316002)(110136005)(7696005)(7416002)(5660300002)(55016003)(921005)(38070700005)(82950400001)(38100700002)(82960400001)(4326008)(41300700001)(8936002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0xBSkV2cVdPRzhkRG4xZkdDcTB3ZFQ5TGtvQWJNUmc1c3MvQXJKWmdCajds?=
 =?utf-8?B?eXFrTnJBOExYTFlLY2g1c2hIS3ZhYzZkVjB3RjJhelFaMVFjSTJ0dUY3OVpZ?=
 =?utf-8?B?K1J1MFJ3N3BudzBvZ2lrbWlMQlhXMTRlYlFKb2V1Vm0xa0haQkVaWFNXYWIx?=
 =?utf-8?B?RWVCdHRiSHdUTWVGL2JSR3lFUUFxakV0UXFkZnk2Mmd1eGRjQVpaU2Z4a2tM?=
 =?utf-8?B?c2hXYnc0K0xvd0xuck9reEV0dzVGM2V4UU1ubEJnYUZxMUU5WkU1Q0V5MEVC?=
 =?utf-8?B?bGZKQW9YSGNSVWZpeGtSNnJnWXNiRUl0Y0oxVkJJQy93Q2k3N25adCtxVVZz?=
 =?utf-8?B?NjRhQWxYSWxEYnlxWVFrZXVrUElTcE8xK2NGTTBqUFc0Sm91bEVLOCtySTEx?=
 =?utf-8?B?UWNvNVNSb2VlMkR2d3B6SGtUeXBvOUFkVm0zVitFRUJOV3NDTW1ZREt5YVRz?=
 =?utf-8?B?TGcxTjNpRUgvL3FLZzZweC9manIvQ0krS0Rjak9JWnVseWhpZDU4ZW1hcHRS?=
 =?utf-8?B?dlkvMU1PTzJZdCsyZDZsRjBRSVVQbXJSdncyTmdaZkgzZVZXZEZUTWRxbHJU?=
 =?utf-8?B?S0hveUVRQjlqdFVFcXZjWjZkMkptczg0bEhrRVY0VXo5TDBUWWgwMXcyQW8y?=
 =?utf-8?B?TjVUWEMyV1BMUkhyNjhiVTh4QXVlbWxpZDkvWVY3dzhzTTNxUU5ha1grY3RG?=
 =?utf-8?B?NXBzYlFzRHhaMVduV0pZRDFQWDNmYVhTdC83dWRXYStnTllBL3RJUU8vcWJH?=
 =?utf-8?B?cEhxNTBpZ09lUkZleTV3QWN4MnVwcThpWWtuM1kvZlBwY01iV1BnUExGeHk1?=
 =?utf-8?B?YVY5T0V0MXlMcjk3N2xRbU94TVcrenpMMklWaXNFK3RjMXY5MDRKUFdRTTBK?=
 =?utf-8?B?NDYzN0trS2JVQXRDRjVkbDNacEtRTzRzcmo3dGRCNXlnOENTSlB2SnhBeXFy?=
 =?utf-8?B?R1BqWWMrcVBjdjAzUGpsazBwYkxkaW9BVkIwK2lOcXQxaERmb1d4Q1RmbDZP?=
 =?utf-8?B?UlBmZzRZUGFydWhBZXFGUmZ5Um5hbVdVNys1Y0pIZ2VmNGxwWmxuMEhHQm1p?=
 =?utf-8?B?NkF4Nmg4MHZWTWFHMXFJcWkvTGhDdmRWQmZ0RHlISzIvWEhXQVExYlREdkZu?=
 =?utf-8?B?Yk1XT3VGdlV5M3VEalZmSmlEd3BTRVlDLy8vYmZXMUhGWHpya3FZd2VOcXNq?=
 =?utf-8?B?YytKL0R3TUczZFNaSUFWWWVKdWh6RUxlSElqRU9ZTEtLc2pTaFVtc2lIUlR0?=
 =?utf-8?B?NnkvQmp6NjFNWUltbGZ3Z3hvR3JkbXZscFZ0dE5PemtpanNNbzdsSFluS2tD?=
 =?utf-8?B?RWtDTVJvVmVKTU9OWFdudDhnSEpBeDh4RDNKTllJb05SVVFrd0dKQjRpV05i?=
 =?utf-8?B?VUJ6cXhOZXN0NVhjWU9NdCtzQ29BTXVNd1V2WXJTa3dmaU85WHdMajBXd2ln?=
 =?utf-8?B?Qk56L25tWWhNeGxKc3hneTBXRFFmQWlib0ZURXlTSi81NWhKQWM3V3UxQ1Fu?=
 =?utf-8?B?bTljTGFBMG1ybE1zc0dSUE43WUNDYmdEdWxxM09JaFZoLzlBNDVRaWpLdVBV?=
 =?utf-8?B?SUR1SnBjbGJFeGFkSXVUaGNnc0tMSC8yUWRlbXQyUUZZdmRoU01RYXhoUlFM?=
 =?utf-8?B?YXJVYUl1V1FCUFhHMUxGTjY2VGRLRHZxRDVsa09wVVVtaTJqMTBDRVlrMXBy?=
 =?utf-8?B?dDc0SER5cmxyZHJEOFZDVkFUQndZanl5MURCZU9KelJURVVIc2I0OHJqL0g2?=
 =?utf-8?B?ejNpWnZKNGkxc05TZG80YjdwbWJ6aTdJVVZoTUZuTFdkaytiK1MzT2F4Vzhk?=
 =?utf-8?B?V0QwSVNiSjNKZVRqd3JnOU92bDMwcnpubytLdTAvcXpVbXp6NldSMUMvYWJI?=
 =?utf-8?B?cXBqTUFNdTdrcUQyT1d2TkxYcytxeDBWQXdiTjY3ckJNUXowM1J6ZFpCNnVK?=
 =?utf-8?B?NUg2OWVlbmdqeGdtSjBjTFJMQWZTa25XTXpEdjRGRkpjcUZwQkc2WU5DWVhm?=
 =?utf-8?B?a3MxdXpWenQza2NMWVZFbVBzS3U0amgzdjIyN2N4S3R6SG1kakNuL003ZndL?=
 =?utf-8?B?NlYxL2lQd0JKeUVNU0NaT05yTVlJb0xCU3YwY3RtaHRaMzBlMzZoa1kzZi9v?=
 =?utf-8?Q?C7nW+Mz1/kxnpvgJ+KU7I+n+h?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d58246d4-fd87-4065-df72-08daccf346a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 01:37:26.0691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h3sGRHhfCIWW+rUlAkC8Wbk/YabSc3UewEvnwFy9xu/DPfvgyyPmLaJpeYcd/9W/kept+vb4R1lZOVvROv4L9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1467
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
YXksIE5vdmVtYmVyIDIxLCAyMDIyIDEyOjM5IFBNDQo+IFsuLi5dDQo+IE9uIDExLzIxLzIyIDEx
OjUxLCBEZXh1YW4gQ3VpIHdyb3RlOg0KPiA+IF9fdGR4X2h5cGVyY2FsbCgpIGRvZXNuJ3Qgd29y
ayBmb3IgYSBURFggZ3Vlc3QgcnVubmluZyBvbiBIeXBlci1WLA0KPiA+IGJlY2F1c2UgSHlwZXIt
ViB1c2VzIGEgZGlmZmVyZW50IGNhbGxpbmcgY29udmVudGlvbiwgc28gYWRkIHRoZQ0KPiA+IG5l
dyBmdW5jdGlvbiBfX3RkeF9tc19odl9oeXBlcmNhbGwoKS4NCj4gDQo+IE90aGVyIHRoYW4gUjEw
IGJlaW5nIHZhcmlhYmxlIGhlcmUgYW5kIGZpeGVkIGZvciBfX3RkeF9oeXBlcmNhbGwoKSwgdGhp
cw0KPiBsb29rcyAqRVhBQ1RMWSogdGhlIHNhbWUgYXMgX190ZHhfaHlwZXJjYWxsKCksIG9yIGF0
IGxlYXN0IGEgc3RyaWN0DQo+IHN1YnNldCBvZiB3aGF0IF9fdGR4X2h5cGVyY2FsbCgpIGNhbiBk
by4NCj4gDQo+IERpZCBJIG1pc3Mgc29tZXRoaW5nPw0KDQpUaGUgZXhpc3RpbmcgYXNtIGNvZGUg
Zm9yIF9fdGR4X2h5cGVyY2FsbCgpIHBhc3NlcyB0aHJvdWdoIFIxMH5SMTUNCihzZWUgVERWTUNB
TExfRVhQT1NFX1JFR1NfTUFTSykgdG8gdGhlIChLVk0pIGh5cGVydmlzb3IuDQoNClVubHVja2ls
eSwgZm9yIEh5cGVyLVYsIHdlIG5lZWQgdG8gcGFzcyB0aHJvdWdoIFJEWCwgUjgsIFIxMCBhbmQg
UjExDQp0byBIeXBlci1WLCBzbyBJIGRvbid0IHRoaW5rIEkgY2FuIHVzZSB0aGUgZXhpc3Rpbmcg
X190ZHhfaHlwZXJjYWxsKCkgPw0KDQo+IEFub3RoZXIgd2F5IG9mIHNheWluZyB0aGlzOiAgSXQg
c2VlbXMgbGlrZSB5b3UgY291bGQgZG8gdGhpcyB3aXRoIGEgbmV3DQo+IHZlcnNpb24gb2YgX3Rk
eF9oeXBlcmNhbGwoKSAoYW5kIGFsbCBpbiBDKSBpbnN0ZWFkIG9mIGEgbmV3DQo+IF9fdGR4X2h5
cGVyY2FsbCgpLg0KDQpJIGRvbid0IHRoaW5rIHRoZSBjdXJyZW50IFREVk1DQUxMX0VYUE9TRV9S
RUdTX01BU0sgYWxsb3dzIG1lDQp0byBwYXNzIHRocm91Z2ggUkRYIGFuZCBSOCB0byBIeXBlci1W
Lg0KDQpQUywgdGhlIGNvbW1lbnQgYmVmb3JlIF9fdGR4X2h5cGVyY2FsbCgpIGNvbnRhaW5zIHRo
aXMgbGluZToNCg0KIiogUkJYLCBSQlAsIFJESSwgUlNJICAtIFVzZWQgdG8gcGFzcyBWTUNBTEwg
c3ViIGZ1bmN0aW9uIHNwZWNpZmljDQphcmd1bWVudHMuIg0KDQpCdXQgaXQgbG9va3MgbGlrZSBj
dXJyZW50bHkgUkJYIGFuIFJCUCBhcmUgbm90IHVzZWQgYXQgYWxsIGluIA0KYXJjaC94ODYvY29j
by90ZHgvdGRjYWxsLlMgPw0KDQo=
