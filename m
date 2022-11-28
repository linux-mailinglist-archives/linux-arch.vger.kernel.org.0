Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058CB63B482
	for <lists+linux-arch@lfdr.de>; Mon, 28 Nov 2022 22:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbiK1VyA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Nov 2022 16:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbiK1Vx7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Nov 2022 16:53:59 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westus2azon11021015.outbound.protection.outlook.com [52.101.47.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA722C646;
        Mon, 28 Nov 2022 13:53:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gez4ubQ88isz/VhyVhgKJvd4hbqRzY8XgZuMzWzv2Pr5pXquThDBFCcm3LiY4rbenI7RL3KenGoKPS7nOBEg0YTB28VIJU99KLQJFUXa5MmB1f+lmYDn+RR17GNtA3guhDhGQj5oYta0LySd/dpokmAS3y4vtVzafHW0xd/bhGWFdbMJtPw7E73/1X+9ES2/6tcex9JK6T+Ygzx4o2nAt1x8UimDEb5sSXOt4CGt+Nr/L6a0PeoRdqF45C164yHlz68b2VJUkKPGcSj10d4QPMhdKjiSEAa5bB9eyqFD4M+pgxtBIYv8QHWiKuDVfQSgHMVCmjtEcxnPYmdDxLILpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DV1q7UTSlKutfeI6Gel6faz7khdlXTfHoyq2rDKWl/c=;
 b=e38eSwbbgdIsTec5yroGs2e4RbYbGXKiy8CE/T0UWoycwbA9fXMaNXxr1NYaS0jvZsjEpsStt92/hKqYaZrwy7ZU4ez5Wska7shCSB7AfA3Qcnpq8Ez6LTAZfbXnpMPclk7bC9Qsb27/NmxHmvNgcXlQoUKljgZt7T1mMYQraNd0g+hK7rxGmq7aqUZMJYXLVBSkfNJw7yq9yIQW3J7olF0VfAwqW5xMAvsCJuTqL/p7UYeAB1X0MVXKtXH+PdWorDX5RJEIifXmJakiYMGlUTv0FA5VyD3QfrQta2N+1DdiEtb78F0/FIFJ/u3vql86UheFXnnaBQupvWFay9YBVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DV1q7UTSlKutfeI6Gel6faz7khdlXTfHoyq2rDKWl/c=;
 b=T7mj6CVwZOWbLLimENfRnMpJZ3dVgtk5R8LY5YDpqBLFBz6DIf8xsYpBLqMoxGma92MF9HTVUROWw0j1o02bdjjWmfGLZtwy9Kg6F85z41gWJpNA8YFeHoaSlbRFhtjUPGGoFoTPYum+mej8JxgpBdJxhyub2miaxRZ64t4dE9g=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by DS7PR21MB3150.namprd21.prod.outlook.com (2603:10b6:8:7a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Mon, 28 Nov
 2022 21:53:36 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817%6]) with mapi id 15.20.5880.008; Mon, 28 Nov 2022
 21:53:35 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
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
Thread-Index: AQHY/0oyvJMCdibbbUqzNA0JVsxn0a5TiVBAgADyjYCAAC5pcIAAEXiAgAAD5oCAAAZzgIAABoTwgAAR3ICAAAO4cA==
Date:   Mon, 28 Nov 2022 21:53:35 +0000
Message-ID: <SA1PR21MB1335A32E8CAB43057538DB57BF139@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-6-decui@microsoft.com>
 <BYAPR21MB16886270B7899F35E8A826A4D70C9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <SA1PR21MB133528B2B3637D61368FF5FFBF139@SA1PR21MB1335.namprd21.prod.outlook.com>
 <b692c4da-4365-196d-9d12-33e2679c01de@intel.com>
 <SA1PR21MB1335BA9D27891F6B1BA3A988BF139@SA1PR21MB1335.namprd21.prod.outlook.com>
 <54871aec-823b-1ff5-8362-688d10e97263@intel.com>
 <SA1PR21MB13357B3CC486514D2DF50A4DBF139@SA1PR21MB1335.namprd21.prod.outlook.com>
 <f6d27366-e083-b362-b44c-eaf4d3365b53@intel.com>
 <SA1PR21MB1335BA75F51964636745E486BF139@SA1PR21MB1335.namprd21.prod.outlook.com>
 <8547f6b1-8dd6-1319-5c44-1440f54026f8@intel.com>
In-Reply-To: <8547f6b1-8dd6-1319-5c44-1440f54026f8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4b48bd1c-ea0f-43c0-bf5b-b5c99681898b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-28T21:28:39Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|DS7PR21MB3150:EE_
x-ms-office365-filtering-correlation-id: c33872c4-56be-44c1-b92e-08dad18b0012
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: az/bAc5Xl/YKujG+aVIyA2Bf/7oxHs/xcysunTX/+bR/CdxjF45BuSSnskxMvjCI0ObS+Q9jDOw2ZiyIKB4qcbGCExDDgm/T0xjKXqKpwZgp/1CzkcXCKfD7XM8ICvDJVUgXoHuDbNeFEmukHVJtoq2LOQe8cg8vbcc7ai4m1YECcsvV3QQ38STAGVnJUP9WoDCW+3zzYKudHk0+ozi/Nj4lwmsV4wNc9U73+7Bp6WWcRpvx8qNErLNXhgK0KQnbJugSZbcmf4dZRXlkySba+TeyJCOHNjvn4j/DFM7WYUYO5CfETewI2Dkqtl/8TlhSXKazuP6UkdNWpZvhy1aK/Xm8Xm0iseyKUQ1mKJXS3sc7iUvSHMjNnD7NIVf0KzNlp9vYYZ7p7pslARjy/ORDVtULTUIghoVZUo4EUJj068TMqnD8ohvMqzoUB0qXmzFd2F5aN53lXyBgcQTtnmoqYZ/o8coDWsnoMVXcYxUfU7xt8xHK1nOSIWgieAnznXNojjfIFPTGEYhxoneLvil3d7O9C22w2EeylzpmDoA9PojH+b9W/xkmnN381hEeTSJFcZBHeBUXilwJBz0CpymhcY5utnWKoJNncFmrySuBejbWo/Wz7dnNTEMqclFkZSQ9nGADA4PCA1LuIzfHYyIMVZlClzrnRj7ZyIO2AoXbLPG0i4AYofr+4pIfxnl9uUDmDaZjSMbXQKQrMlOd8EJkt4Z3pL4tpDqC+dMtomgeUd1XHI52iXpFbHUq3qRqP1bgd7HxKqYuRtyDRwCjz1KqPwU34WTu2PhqcxXp0v9/rBM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199015)(66899015)(122000001)(8936002)(7416002)(38100700002)(2906002)(8990500004)(186003)(55016003)(33656002)(86362001)(52536014)(966005)(38070700005)(10290500003)(478600001)(921005)(82950400001)(82960400001)(76116006)(66946007)(66476007)(66556008)(41300700001)(66446008)(316002)(7696005)(9686003)(5660300002)(4326008)(6506007)(8676002)(71200400001)(64756008)(26005)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djVTM0ZURVl5Vy9JYUlIVzh3KzNyL1F4MjN6L3hZSWtjNm5hTUVlbVEyc043?=
 =?utf-8?B?V0dpV29RYUorbWlzbkRHNzFsSGRyTmw3V2hQdEorTDUzM09yZWdUSk5rR2x1?=
 =?utf-8?B?T29LM1EvU1BySHNjQnBmWFR2SGx2VWRyMDlLUzhZSlQrVFhTRVlYaU5qa0po?=
 =?utf-8?B?VUttYWRUUkZaRzFHTFZMSFBaeDFLeWVVZ2svdHk5OFFSOW5CS2czQzl6SjVH?=
 =?utf-8?B?SG5ucUw2ejNDeWQwc0VvRnFoZEJOL1MvV3ZCRlpqbFk4aHlMekNNcFRtdyt3?=
 =?utf-8?B?Y1VkYnNySERPTjJUVmNxSkJVb2hKeFloWFAzL29aYk5vcTFYWXJMYmRySis5?=
 =?utf-8?B?QmRTZDNnWTRWUjY0aCtONEU4L3FsS0NZZStvU1V6NkhKNkdXUWhYd3NHL3c3?=
 =?utf-8?B?NDNmaFJwWlRSTm40TFVuUzdrNWRQUWxHMjgvSkovOGNpTWVXNTlsNDJNQUMy?=
 =?utf-8?B?cHBmM3pUNnFWdEdhSWJaaWh6UnhZaTJVYmJPbEJLbVdGT2I2NEJXbUVNZ1JY?=
 =?utf-8?B?UWR1TU8vM1p6ODhiR0w0ZDdrWGF4bDVISktuTXQyVHh0cklDNFRNbDBUMUxL?=
 =?utf-8?B?MlNrUWhCSTRucWw2SFVsNXlydzhYTm45V3BmNkNpM1VoenhIMnNnM2NYNTc0?=
 =?utf-8?B?Sk55MEhmNW02Uzdydk9Hd0d4cHRkVkdaTHd0K3hrZlZKL2x5M3BSaGFKU0o1?=
 =?utf-8?B?eUZHQWxKTkU1L3VNU0xzVGxZNjlmT1NXQ0FmSVlqazBhYmgyblUvdXh6d3A0?=
 =?utf-8?B?bisvR3F3eW12RitNcThTalFOVzZ6OU5kMDFSRlpCT0JWT25FSFJMMmY3cEtn?=
 =?utf-8?B?aEZlNU9hOFBERzFsd1I5Z1RvclhTV0YvbVhBRWtkZFRia09SSVFmZDdxZzNR?=
 =?utf-8?B?Um1LUERySzFXRDZmWlVmWDRtc0sxUmdvZ2N5LytqV3RtRjFPYWQzQlZJYURO?=
 =?utf-8?B?Z05sUVZGZnNvdTk2ZTdEM3puTlp4ekZVY0JFdDFRUVVNRFF3TmlDVC80VVNF?=
 =?utf-8?B?ZHcxKzFLcmlSSFdsbk5CaU1NdXlqWVdzY3cwZUVwRTU0c0JZaHpYK3RsK0xF?=
 =?utf-8?B?STJLY2NoZ1NkZERlRys5QVM2cGtRUW0rWTZHZWNMbVFaNUtwODBUNU5QQzFR?=
 =?utf-8?B?V2NwZDY2WWhyaUhuQ3FJaHUrWEFVYk0zS0l6djRMK2NKUktmK1dsUERVNkpn?=
 =?utf-8?B?NjZySXR3bXgxQnMxaTc5a094cXM5QXJoYkZwYTF3UzcwN2JoTHBBQ3hwVmpv?=
 =?utf-8?B?RmR5V2NVUmNIUEx6ZllPWHU1dzhVMlVVeGY2RC9TRGt0RnQyMys3YTVVOElr?=
 =?utf-8?B?VEpSNGx5aUZQUDNiR3FuUHVDaFg1Ulk5OGpLZHh0SUE4eFBvbXpPaHJrRlgw?=
 =?utf-8?B?Z2c2RTBSenA5MzRTUFYwZElKZURpbjZ3cFBKOS9wVFJsdjNvc1BkaHVxdEJv?=
 =?utf-8?B?R2JPd2owQ1U4OWtPN0F2Q3RoeG9ycTlsMDBQbWhVOXRELzNab2F2ZE1IN3R4?=
 =?utf-8?B?NDQwNno1dEVEWGlQRWRjaUcrMTZ1aWE0Y2pWNUoyWkRoWmxYMnVvcE1ScEtP?=
 =?utf-8?B?YW5IQ3c2RHI0SjM0em5kZERHMERuZ0FqYTQ1Y1UzZUl6N3Q4MHJLVlhXbzhm?=
 =?utf-8?B?UTgwZVlvMlFaRG1mZ3pWSEJIckFlOXNUZE96aGczSzRCZmc5Y1BRRnl0VTBh?=
 =?utf-8?B?YXRydVRGYytlUTRFbkNGOENCcEdaR2F0OU50TVlVaTRMRmdCMDB3NXNHek9S?=
 =?utf-8?B?Vis4MGY5UHRyL0dMNHQxekpzMysraWxWcjZIcTBlU1lJc0RZT1poQ0hjaitT?=
 =?utf-8?B?NWtqenhEUlF1OFR3SjhEKzkrQVhralV4Mk1UTWR1aVMvRXpleFZMWldBblZi?=
 =?utf-8?B?NFZNVXJ1UDdraDgxNkhQL0NLdkhaYzRLWXpDRVEweXpSWEtwUDZJbnI1cHBm?=
 =?utf-8?B?dVI2bzNKMUZPcnl6c1BZMWRid1JXai9rMjN1c0x3UWh2N09lM3ZzUmV6R1Jq?=
 =?utf-8?B?cWxVakllWjFZMC8yK2RZSzZBY21QMGxzZFBOQWpYUHRjQ2lRVkphZjl4cllR?=
 =?utf-8?B?ekRMTndaWU4weFZDSys5S1hMb3RYSUlSNGVFU24yYmVwYUNFWHlIbkZLOFR4?=
 =?utf-8?Q?PmyDiEvfX9RxDNSx860EjwB1n?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c33872c4-56be-44c1-b92e-08dad18b0012
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 21:53:35.7920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pgOd4KQS0xQZd+9VyOmOiExdB21zBSdkwafrpC0SijcmkDb90raQd2o3J2tC3XPQo0sMF29a5mgsc7t/Tb9ENQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3150
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

PiBGcm9tOiBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AaW50ZWwuY29tPg0KPiBTZW50OiBNb25k
YXksIE5vdmVtYmVyIDI4LCAyMDIyIDE6MTUgUE0NCj4gWy4uLl0NCj4gVGhpcyBpcyB0aGUgcG9p
bnQgd2hlcmUgdGhlIG1haW50YWluZXIgZ2V0cyBhIHdlZSBiaXQgZ3J1bXB5LiAgVGhlIHBhZ2UN
Cj4gSSBqdXN0IHBvaW50ZWQgeW91IHRvICh0d2ljZSkgaGFzIHRoaXMgbmljZSBxdW90ZToNCj4g
DQo+IAlJZiB0aGUgaHlwZXJjYWxsIGludm9sdmVzIG5vIGlucHV0IG9yIG91dHB1dCBwYXJhbWV0
ZXJzLCB0aGUNCj4gCWh5cGVydmlzb3IgaWdub3JlcyB0aGUgY29ycmVzcG9uZGluZyBHUEEgcG9p
bnRlci4NCj4gDQo+IFNvLCBicmF2byB0byB5b3VyIGNvbGxlYWd1ZXMgd2hvIG5pY2VseSBkb2N1
bWVudGVkIHRoaXMuICBCdXQsDQo+IHVuZm9ydHVuYXRlbHksIHlvdSBkaWRuJ3QgdGFrZSBhZHZh
bnRhZ2Ugb2YgdGhlaXIgZ3JlYXQgZG9jdW1lbnRhdGlvbi4NCj4gSW5zdGVhZCwgeW91IG1hZGUg
bWUgc2VhcmNoIGZvciBpdCB0byBwcm92aWRlIGFjdHVhbCBmYWN0cyB0byBjb21iYXQgdGhlDQo+
IHdlYWsgY29uamVjdHVyZSB5b3Ugb2ZmZXJlZCBhYm92ZS4NCg0KU29ycnksIEkgc2hvdWxkIHJl
YWxseSBoYXZlIHJlYWQgdGhlIGRvY3VtZW50IGJlZm9yZSBzdGFydGluZyB0byBjb25qZWN0dXJl
Li4uDQoNCj4gPiBUaGUgYWJvdmUgaXMganVzdCBteSBjb25qZWN0dXJlLiBJIGRvbid0IGtub3cg
aG93IGV4YWN0bHkgSHlwZXItViB3b3Jrcy4NCj4gDQo+IEkgZG8hICBJIGxpdGVyYWxseSBHb29n
bGVkICJIViBIWVBFUkNBTEwgRkFTVCBCSVQiIGFuZCB0aGUgZmlyc3QgcGFnZQ0KPiB0aGF0IGNh
bWUgdXAgdG9sZCBtZSBhbGwgSSBuZWVkZWQgdG8ga25vdy4NCj4gDQo+IEkgY291bGQgYmUgbWVy
cmlseSBtZXJnaW5nIHlvdXIgcGF0Y2hlcy4gIEJ1dCwgaW5zdGVhZCwgSSdtIHJlYWRpbmcNCj4g
ZG9jdW1lbnRhdGlvbiB0aGF0IGNhbiBiZSB0cml2aWFsbHkgZm91bmQgYW5kIHJlcGVhdGVkbHkg
cmVndXJnaXRhdGluZyBpdC4NCj4gDQo+IFBsZWFzZSwgc2xvdyBkb3duLiAgVGFrZSBzb21lIHRp
bWUgdG8gYW5zd2VyIGVtYWlscyBhbmQgZG8gaXQgbW9yZQ0KPiBkZWxpYmVyYXRlbHkuICBUaGlz
IGlzbid0IGEgcmFjZS4NCg0KVGhhbmtzLCBJIGxlYXJuIGEgbGVzc29uLiBIb3BlZnVsbHkgdGhl
IGJlbG93IGxvb2tzIGdvb2QgZW5vdWdoLiANCg0KQ29tcGFyZWQgdG8gdGhlIGVhcmxpZXIgdmVy
c2lvbiwgdGhlIG9ubHkgY2hhbmdlcyBhcmU6IDEpIHNpbXBsaWZpZWQgdGhlDQpjaGFuZ2UgaW4g
aHZfZG9faHlwZXJjYWxsKCk7IDIpIGFkZGVkIGEgY29tbWVudCBiZWZvcmUgdGhlIGZ1bmN0aW9u
Lg0KDQpCVFcsIEkgY2FuJ3QgcG9zdCB0aGUgdjIgcGF0Y2hzZXQgcmlnaHQgbm93LCBhcyBJJ20g
d2FpdGluZyBmb3IgS2lyaWxsIHRvDQpleHBhbmQgX190ZHhfaHlwZXJjYWxsKCkgZmlyc3Q6DQpo
dHRwczovL2x3bi5uZXQvbWwvbGludXgta2VybmVsL1NBMVBSMjFNQjEzMzVFRUVDMURFNENCNDJG
NjQ3N0E1RUJGMEM5QFNBMVBSMjFNQjEzMzUubmFtcHJkMjEucHJvZC5vdXRsb29rLmNvbS8NCkkn
bSBhbHNvIHRoaW5raW5nIGFib3V0IGhvdyB0byBwcm9wZXJseSBhZGRyZXNzIHRoZSB2bWFsbG9j
DQppc3N1ZSB3aXRoIHRkeF9lbmNfc3RhdHVzX2NoYW5nZWQoKS4NCg0KZGlmZiAtLWdpdCBhL2Fy
Y2gveDg2L2h5cGVydi9pdm0uYyBiL2FyY2gveDg2L2h5cGVydi9pdm0uYw0KaW5kZXggNzAxNzAw
NDliZTJjLi40MTM5NTg5MWQxMTIgMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9oeXBlcnYvaXZtLmMN
CisrKyBiL2FyY2gveDg2L2h5cGVydi9pdm0uYw0KQEAgLTI0Miw2ICsyNDIsMjAgQEAgYm9vbCBo
dl9pc29sYXRpb25fdHlwZV90ZHgodm9pZCkNCiB7DQogICAgICAgIHJldHVybiBzdGF0aWNfYnJh
bmNoX3VubGlrZWx5KCZpc29sYXRpb25fdHlwZV90ZHgpOw0KIH0NCisNCit1NjQgaHZfdGR4X2h5
cGVyY2FsbCh1NjQgY29udHJvbCwgdTY0IHBhcmFtMSwgdTY0IHBhcmFtMikNCit7DQorICAgICAg
IHN0cnVjdCB0ZHhfaHlwZXJjYWxsX2FyZ3MgYXJncyA9IHsgfTsNCisNCisgICAgICAgYXJncy5y
MTAgPSBjb250cm9sOw0KKyAgICAgICBhcmdzLnJkeCA9IHBhcmFtMTsNCisgICAgICAgYXJncy5y
OCAgPSBwYXJhbTI7DQorDQorICAgICAgICh2b2lkKV9fdGR4X2h5cGVyY2FsbCgmYXJncywgVERY
X0hDQUxMX0hBU19PVVRQVVQpOw0KKw0KKyAgICAgICByZXR1cm4gYXJncy5yMTE7DQorfQ0KK0VY
UE9SVF9TWU1CT0xfR1BMKGh2X3RkeF9oeXBlcmNhbGwpOw0KICNlbmRpZg0KDQogLyoNCmRpZmYg
LS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc2h5cGVydi5oIGIvYXJjaC94ODYvaW5jbHVk
ZS9hc20vbXNoeXBlcnYuaA0KaW5kZXggOWNjNmRiNDVjM2JjLi4wNTViNmZiODk0MWYgMTAwNjQ0
DQotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc2h5cGVydi5oDQorKysgYi9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS9tc2h5cGVydi5oDQpAQCAtMTAsNiArMTAsNyBAQA0KICNpbmNsdWRlIDxhc20v
bm9zcGVjLWJyYW5jaC5oPg0KICNpbmNsdWRlIDxhc20vcGFyYXZpcnQuaD4NCiAjaW5jbHVkZSA8
YXNtL21zaHlwZXJ2Lmg+DQorI2luY2x1ZGUgPGFzbS9jb2NvLmg+DQoNCiB1bmlvbiBodl9naGNi
Ow0KDQpAQCAtMzksNiArNDAsMTIgQEAgaW50IGh2X2NhbGxfZGVwb3NpdF9wYWdlcyhpbnQgbm9k
ZSwgdTY0IHBhcnRpdGlvbl9pZCwgdTMyIG51bV9wYWdlcyk7DQogaW50IGh2X2NhbGxfYWRkX2xv
Z2ljYWxfcHJvYyhpbnQgbm9kZSwgdTMyIGxwX2luZGV4LCB1MzIgYWNwaV9pZCk7DQogaW50IGh2
X2NhbGxfY3JlYXRlX3ZwKGludCBub2RlLCB1NjQgcGFydGl0aW9uX2lkLCB1MzIgdnBfaW5kZXgs
IHUzMiBmbGFncyk7DQoNCit1NjQgaHZfdGR4X2h5cGVyY2FsbCh1NjQgY29udHJvbCwgdTY0IHBh
cmFtMSwgdTY0IHBhcmFtMik7DQorDQorLyoNCisgKiBJZiB0aGUgaHlwZXJjYWxsIGludm9sdmVz
IG5vIGlucHV0IG9yIG91dHB1dCBwYXJhbWV0ZXJzLCB0aGUgaHlwZXJ2aXNvcg0KKyAqIGlnbm9y
ZXMgdGhlIGNvcnJlc3BvbmRpbmcgR1BBIHBvaW50ZXIuDQorICovDQogc3RhdGljIGlubGluZSB1
NjQgaHZfZG9faHlwZXJjYWxsKHU2NCBjb250cm9sLCB2b2lkICppbnB1dCwgdm9pZCAqb3V0cHV0
KQ0KIHsNCiAgICAgICAgdTY0IGlucHV0X2FkZHJlc3MgPSBpbnB1dCA/IHZpcnRfdG9fcGh5cyhp
bnB1dCkgOiAwOw0KQEAgLTQ2LDYgKzUzLDEwIEBAIHN0YXRpYyBpbmxpbmUgdTY0IGh2X2RvX2h5
cGVyY2FsbCh1NjQgY29udHJvbCwgdm9pZCAqaW5wdXQsIHZvaWQgKm91dHB1dCkNCiAgICAgICAg
dTY0IGh2X3N0YXR1czsNCg0KICNpZmRlZiBDT05GSUdfWDg2XzY0DQorICAgICAgIGlmIChodl9p
c29sYXRpb25fdHlwZV90ZHgoKSkNCisgICAgICAgICAgICAgICByZXR1cm4gaHZfdGR4X2h5cGVy
Y2FsbChjb250cm9sLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2NfbWtk
ZWMoaW5wdXRfYWRkcmVzcyksDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBj
Y19ta2RlYyhvdXRwdXRfYWRkcmVzcykpOw0KICAgICAgICBpZiAoIWh2X2h5cGVyY2FsbF9wZykN
CiAgICAgICAgICAgICAgICByZXR1cm4gVTY0X01BWDsNCg0KQEAgLTgzLDYgKzk0LDkgQEAgc3Rh
dGljIGlubGluZSB1NjQgaHZfZG9fZmFzdF9oeXBlcmNhbGw4KHUxNiBjb2RlLCB1NjQgaW5wdXQx
KQ0KICAgICAgICB1NjQgaHZfc3RhdHVzLCBjb250cm9sID0gKHU2NCljb2RlIHwgSFZfSFlQRVJD
QUxMX0ZBU1RfQklUOw0KDQogI2lmZGVmIENPTkZJR19YODZfNjQNCisgICAgICAgaWYgKGh2X2lz
b2xhdGlvbl90eXBlX3RkeCgpKQ0KKyAgICAgICAgICAgICAgIHJldHVybiBodl90ZHhfaHlwZXJj
YWxsKGNvbnRyb2wsIGlucHV0MSwgMCk7DQorDQogICAgICAgIHsNCiAgICAgICAgICAgICAgICBf
X2FzbV9fIF9fdm9sYXRpbGVfXyhDQUxMX05PU1BFQw0KICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIDogIj1hIiAoaHZfc3RhdHVzKSwgQVNNX0NBTExfQ09OU1RSQUlOVCwNCkBA
IC0xMTQsNiArMTI4LDkgQEAgc3RhdGljIGlubGluZSB1NjQgaHZfZG9fZmFzdF9oeXBlcmNhbGwx
Nih1MTYgY29kZSwgdTY0IGlucHV0MSwgdTY0IGlucHV0MikNCiAgICAgICAgdTY0IGh2X3N0YXR1
cywgY29udHJvbCA9ICh1NjQpY29kZSB8IEhWX0hZUEVSQ0FMTF9GQVNUX0JJVDsNCg0KICNpZmRl
ZiBDT05GSUdfWDg2XzY0DQorICAgICAgIGlmIChodl9pc29sYXRpb25fdHlwZV90ZHgoKSkNCisg
ICAgICAgICAgICAgICByZXR1cm4gaHZfdGR4X2h5cGVyY2FsbChjb250cm9sLCBpbnB1dDEsIGlu
cHV0Mik7DQorDQogICAgICAgIHsNCiAgICAgICAgICAgICAgICBfX2FzbV9fIF9fdm9sYXRpbGVf
XygibW92ICU0LCAlJXI4XG4iDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Q0FMTF9OT1NQRUMNCg==
