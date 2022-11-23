Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E963634E11
	for <lists+linux-arch@lfdr.de>; Wed, 23 Nov 2022 03:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbiKWCza (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Nov 2022 21:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbiKWCz3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Nov 2022 21:55:29 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westcentralusazon11021027.outbound.protection.outlook.com [40.93.199.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F229CF4D;
        Tue, 22 Nov 2022 18:55:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayvhIbH1AEaswp65LszOD01n6oCxAkRbQyl10+MUMZljpPM+IZ3bOL13sS/8Up5VRcKpNpuvpk5nT+IgIdbIV4VARtq9ST+ZDERctv2RuD/wvVJSEOOBtILa3r/3LT27IFvSKl79Lzo1r+5zQFtTuA7wdrQarDTY67bZEDErCdsDbAuz2xaZzWpNbqYKNXGQhN9ndwb1Wwvx/nAYiNWQx2R1rx3a6moNSwz56YOkwbt74XWTbfrOd3VXssgWXc7y7fOkRXS/+VxlGSfD1fOZvLo4Xn29AHgRNU7FWtivbpXIYIeJde/wHYUswCn+/UyY1oMJyC6jdBnwbOTPJoBLMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieYKBpF+w8QmUoUsAxPe+31KVV3z0yDVRsC3OPdkE58=;
 b=OY+i7rRVLVdWMFse5YXuchzk91xomhaZnbyElQPLcz+CXTGl7n82WDzzE2CqqB8fU3f+fIUwXky3cNCCUFlqXneWO5DjPzAEAFe7iFgM5LU8ayk958MdH9ruuvdYAAXCi/imRWSmGnGiesiDaOQ7VPz9s3jFfUNHi1acOwcpWMLrDesZ6y410BReWcjnuDL0QQyOUz1D7o9sbyYCMoGHPvUbojyEtqlxtMwQBw2VoGKivX78SeZM69qry+tPXwR7zhdSJcQkb9N7ihvLGl/KCW5vhByOtwQdslOCqikpg0RSiHIzaP2bg7q6uuDA+zhieOhB+IJOFSZldsERlI36kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieYKBpF+w8QmUoUsAxPe+31KVV3z0yDVRsC3OPdkE58=;
 b=Yh1c/V/RwZkCMK03cfXH+hkVir5CE3Aa+j4KIyaAfA9XiLzZEL44kOEZ9gSbJ/6qh0PKUD6fk0KEBzaTPOQhpJP4Q/f8hQ6JfhQ3dA5eaQhCY6PWTBCMbZrE2n3DRb1Q56iBq4NLcNQ48xLtAq8PKpbf/LwNF326Zhi8ton6vIw=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by DS7PR21MB3148.namprd21.prod.outlook.com (2603:10b6:8:78::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.2; Wed, 23 Nov
 2022 02:55:26 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817%4]) with mapi id 15.20.5880.002; Wed, 23 Nov 2022
 02:55:26 +0000
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
Subject: RE: [PATCH 2/6] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
Thread-Topic: [PATCH 2/6] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
Thread-Index: AQHY/euu5M0FGuMnSkmqWvcQ39Wr/q5Lzqgw
Date:   Wed, 23 Nov 2022 02:55:26 +0000
Message-ID: <SA1PR21MB133589C3B39E99B73F616A43BF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-3-decui@microsoft.com>
 <6bb65614-d420-49d3-312f-316dc8ca4cc4@intel.com>
In-Reply-To: <6bb65614-d420-49d3-312f-316dc8ca4cc4@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=885d39ec-5c21-48be-8732-b60083a726a2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-23T02:42:38Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|DS7PR21MB3148:EE_
x-ms-office365-filtering-correlation-id: cb024855-0f3e-4a77-18d7-08daccfe2c6e
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5XTVIY3j7h24gOfnFzwIG9aMMQfJ9UdBweK1hjcx2BFxaY8XBNk6lY1/dqo7rSg3BXw6DqSxXpFMaPMS9ulAZTZE5nz/XAwsH3dYeTZba+i0YCdvLwf0DLVaOHdMO8USl6BfRcgqmlOSPEUK9aXscU18Lfdw0OTXomuxsXwF1dO+pSwN/DQcFd5g0lzR+Xv6au0+McPVXFP536bY2MuXaGuF57O56wktMzRzzwmrHQqwUvz7SQCB6FeyFxUJBXKu/Icd8PiEDtyMUt/TAjy3L7EDvO84Za3ZhUkPhcJSOKZ3/Gwvu1V7PRJrmeJrWW74KPgS4jEPKWQXsiZqtkWMv3tvAR5r2wuUR+F1m6tx3ZPXMnWcpV44Vj1k3QAWaGrZrU+9XSZhGXOmBWox7ii7DjJccQ8tiPVabqR/9+z7T1XbG9yO/Vw7mqaFap6/phowPREoaFwwnCHAHsLemoex7/iMYLHMbZ6ytuQE4tymMC75sVijXaVViYlJLZLKv5/G7zc57DLKUZV4MTlyGS6oLiFDyR5TUBnUK5+4SW01f1At5Gdb71rAPzkFBmthNIJ9WworNGfp13F2UgvT9U71p+I3TMnRVUmmkjTwuJukoJDAbXUzSIVVGWHHTq+3mqRRGMcqrcHeAhm+KQeYgUU1VrAab33J8RzJEP5DnkOhxO5mSNyt41wMVZk/TzKHZTNBWVl+omRG6c0oTFmKsjR+97+sOumRUSb9uaOuiR3TzYhQJacXN7Zp/pONQPzFnRpimIX6fLfsGy/uZvFAxgYJ4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199015)(5660300002)(7416002)(55016003)(33656002)(66446008)(9686003)(26005)(53546011)(64756008)(66946007)(66556008)(76116006)(66476007)(316002)(7696005)(6506007)(186003)(52536014)(110136005)(4326008)(8676002)(8936002)(41300700001)(122000001)(82950400001)(38100700002)(38070700005)(921005)(82960400001)(2906002)(86362001)(8990500004)(10290500003)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czl5MGJVb3NaU1hlRFQzMkdxMkFuZG4wRzU4TGxWYkRTTmVJWTlwcnEzZG5a?=
 =?utf-8?B?NWQ2WUdFSmZRc0hoUVlVWUViM00yNDA5RjBzc290N3U4RTRPbS9IWDlQbjNt?=
 =?utf-8?B?ai9wbVNXWVFISDNaQzBDY2k0R3J5SHBGRCtEbWlxZk1LQ3pHclI5bEhUc3RZ?=
 =?utf-8?B?dWJaSTRDZ1VTNFl1Z1hwQ0UxaG4waEVZbjlyZmR4RWVxYWRHRXhQWEhWUzZ0?=
 =?utf-8?B?MmhjY3hEYUhLN3ZHeGdVSnRBclIvcnpxSkdzMGFEM2FJdm9xRHJSWVdTUXlD?=
 =?utf-8?B?eUQwZDJZQ2lBakpYTTVaUlZUTmJkS2RIdUNBbmdOeEljQXpUM3crZVI3V2J5?=
 =?utf-8?B?R0lBbVRRQ3R1TlA3RkdvRWZjOEk0MTk1Nnl1U0k4dXRLVU56MU9EbVI5Ykp0?=
 =?utf-8?B?T0lYaFpUbmRhbkpOLzhUUkE2bVZiYnl5TjE0Z2dLcVQ2VXBnc1JDeCtxUWRy?=
 =?utf-8?B?VmRlOTlFb1Q2ZHYzRkxwRkRUeGJDOFRTM1FUSFY4VzMrdE9UZ3lXMlN1aDBH?=
 =?utf-8?B?MDhkZjIydjhWU200eHQ4c0ZMNkpRK1pOUUlrUmExTWt3U3FxemZHOVdPbWRx?=
 =?utf-8?B?d2RWcGEvblRSMVIrRHgrZ1o5Tk9QdU5IVjhLUEFidkdlUWRlOWpudzh2ZG9a?=
 =?utf-8?B?aXAwQlczbFdKUmxFUnpvVVR1bE9sYUh5ODdqandlZ0hIRUdCcjBPSHR1bFRp?=
 =?utf-8?B?bmRKSTVrTCtMSWxaYklibVQxTGdFd0lLMnFXZlZuREVzSHFkK29jM21nT2Zn?=
 =?utf-8?B?Q1ByZER3ZFJwdGY0OFJibEtIR1E5L3pYR0o5WWdTd3p4eDVRVlUrSkdJR2Fw?=
 =?utf-8?B?TlJlNjl3dW5vUlFzZm5ROVJmVVdSbkRYWHlUUXdBcVRlUkVSditBVjlLaDhN?=
 =?utf-8?B?Wkc5WHYxbGM3N014YjRGSVpFM3ZvU1drVFU3ZGwvZ0I3NGNaSU1FZDNaMzN1?=
 =?utf-8?B?UzFUVWZpMVNGV3RJNjl2ajRJdmlxQzlqb3FsWTQwdWxHaDQxRFVEQzdyMVlG?=
 =?utf-8?B?VngydklFRkpBWDhlVjRPcFlJTmRBaWxYZER5a3JESFdNWjNyZ2txWEk2RkRz?=
 =?utf-8?B?amMxQWV2YkxHK2kxaElHVlBqZUFieHJWaFl4WG1NOUliY21aTFBMWUpwV1pm?=
 =?utf-8?B?dWs0TGUvVkY1cmhXSU11M3hkczBMemVKQm5wK0pJcFp1UXVEK3VJWGJsdTZS?=
 =?utf-8?B?MEpNTzdhR0Q1K0oraFFIWEZQRHRDb3VpQlJQZ3RuTi9rOGxWNktwUGg2UGNa?=
 =?utf-8?B?ME1BdHo5alZHdGhrMTNmcU9PcnROK0VIYmFjVXpwUzVzcDA1WFlPYlF5UGRy?=
 =?utf-8?B?OTB1TW9JeStHYWdMYlV3bGpNeWJuT1hiK2RQRnBmM0cyV2RGYXJ0ZXlMa1g0?=
 =?utf-8?B?ZE1qbkdJdVA2dGZPVmRLVE1vTENtekFDYVFlZXBTTEZPQXBiZU53bDk0ZVVh?=
 =?utf-8?B?THZaVSs0ZHp0NktUTGR6cEhEaFc2QTcxVjdtWHp5MHo0Q1kzMTgvODlaWEd5?=
 =?utf-8?B?Wk5QWXBaTFl5RGtaQ21MZVV2L0I4eEhyNlhocUtvUGdZaU5mM085ZGZ4VzNx?=
 =?utf-8?B?TDVERU9uc2dibkF4WmJyaGJHalhXNGh1bTg2Y0dMUkFEV0VveGgxZExQWkFY?=
 =?utf-8?B?NzN3aDAxS0FVQ1BkeE9oKzUwcWJoVjNxNUh1UXREQ2o2UDhkUmNwYzNSenhV?=
 =?utf-8?B?RzVqQW1MUEZud1dJYzJGNGFzQzUyRW1RN0VWWFJYTlNtU1Fzck5OT1RCUXhH?=
 =?utf-8?B?TDlSNXFiaGdhNW1VdysvcnFlNkpUU3pTdnVMcUhxZmdGOWQwNElLQUIyMjNO?=
 =?utf-8?B?SVFPdFhlM1lKaEYyMEd3R1lGL3IxbTVGOG8wTk1nbkgyc3FyQTZ6VytYVHNS?=
 =?utf-8?B?and2N21lQURMUjhKcmxCM2FjVHJJRzYwNC95MmFGUnpWNG4rODVFbzZIc2xF?=
 =?utf-8?B?OERTWDRDc0VqbUsxcE9uYUJnTnNrSlZ1QUhOb0JOVkJCU05kQXpuVFpwN2Ns?=
 =?utf-8?B?dk1acDJXUWxWOE10V25Hai9BTzY1V1lXSnh1U2VVRCtLbzkzRDFQb0cyYUt4?=
 =?utf-8?B?RjE5M3ZmLzNlenRHY1NjbnRsaENDZWxvOC9QV2dITVg5cWNZZUlqaGY3K053?=
 =?utf-8?Q?aUi6js2ySkrtoKPoDEOadHcHD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb024855-0f3e-4a77-18d7-08daccfe2c6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 02:55:26.5050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oc/GrGycAjIIhxkG5hBeafZlN6ODd3EWKObPXTggwQd9Rtd0uzKRRiQwezOnCkUkQbL/v1EYJxj0PLI5o/6wqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3148
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

PiBTZW50OiBNb25kYXksIE5vdmVtYmVyIDIxLCAyMDIyIDEyOjU2IFBNDQo+IE9uIDExLzIxLzIy
IDExOjUxLCBEZXh1YW4gQ3VpIHdyb3RlOg0KPiA+ICtzdGF0aWMgYm9vbCB0ZHhfbWFwX2dwYShw
aHlzX2FkZHJfdCBzdGFydCwgcGh5c19hZGRyX3QgZW5kLCBib29sIGVuYykNCj4gPiArew0KPiA+
ICsJdTY0IHJldCwgcjExOw0KPiANCj4gJ3IxMScgbmVlZHMgYSByZWFsLCBsb2dpY2FsIG5hbWUu
DQoNCk9LLCB3aWxsIHVzZSAibWFwX2ZhaWxfcGFkZHIiIChhcyB5b3UgaW1wbGllZCBiZWxvdyku
DQogDQo+ID4gKwl3aGlsZSAoMSkgew0KPiA+ICsJCXJldCA9IF90ZHhfaHlwZXJjYWxsX291dHB1
dF9yMTEoVERWTUNBTExfTUFQX0dQQSwgc3RhcnQsDQo+ID4gKwkJCQkJCWVuZCAtIHN0YXJ0LCAw
LCAwLCAmcjExKTsNCj4gPiArCQlpZiAoIXJldCkNCj4gPiArCQkJYnJlYWs7DQo+ID4gKw0KPiA+
ICsJCWlmIChyZXQgIT0gVERWTUNBTExfU1RBVFVTX1JFVFJZKQ0KPiA+ICsJCQlicmVhazsNCj4g
PiArDQo+ID4gKwkJLyoNCj4gPiArCQkgKiBUaGUgZ3Vlc3QgbXVzdCByZXRyeSB0aGUgb3BlcmF0
aW9uIGZvciB0aGUgcGFnZXMgaW4gdGhlDQo+ID4gKwkJICogcmVnaW9uIHN0YXJ0aW5nIGF0IHRo
ZSBHUEEgc3BlY2lmaWVkIGluIFIxMS4gTWFrZSBzdXJlIFIxMQ0KPiA+ICsJCSAqIGNvbnRhaW5z
IGEgc2FuZSB2YWx1ZS4NCj4gPiArCQkgKi8NCj4gPiArCQlpZiAoKHIxMSAmIH5jY19ta2RlYygw
KSkgPCAoc3RhcnQgJiB+Y2NfbWtkZWMoMCkpIHx8DQo+ID4gKwkJICAgIChyMTEgJiB+Y2NfbWtk
ZWMoMCkpID49IChlbmQgICYgfmNjX21rZGVjKDApKSkNCj4gPiArCQkJcmV0dXJuIGZhbHNlOw0K
PiANCj4gVGhpcyBzdGF0ZW1lbnQgaXMsIHVtLCBhIHdlZSBiaXQgdWdseS4NCj4gDQo+IEZpcnN0
LCBpdCdzIG5vdCBvYnZpb3VzIGF0IGFsbCB3aHkgdGhlIGFkZHJlc3MgbWFza2luZyBpcyBuZWNl
c3NhcnkuDQoNCkl0IHR1cm5zIG91dCB0aGF0IHRoZSBtYXNraW5nIGlzIGNvbXBsZXRlbHkgdW5u
ZWNlc3NhcnkgOi0pDQoNCkkgaW5jb3JyZWN0bHkgYXNzdW1lZCB0aGF0IGlmIHRoZSBpbnB1dCAn
c3RhcnQnIGhhcyB0aGUgYml0IDQ3LCBIeXBlci1WDQphbHdheXMgcmV0dXJucyBhIHBoeXNpY2Fs
IGFkZHJlc3Mgd2l0aG91dCBiaXQgNDcuIFRoaXMgaXMgbm90IHRoZSBjYXNlLg0KDQpJJ2xsIHJl
bW92ZSB0aGUgbWFza2luZyBjb2RlIGluIHYyLg0KIA0KPiBTZWNvbmQsIGl0J3MgdXR0ZXJseSBp
bnNhbmUgdG8gZG8gdGhhdCBtYXNrIHRvICdyMTEnIHR3aWNlLiAgVGhpcmQsIGl0J3MNCj4gc2ls
bHkgZG8gbG9naWNhbGx5IHRoZSBzYW1lIHRoaW5nIHRvIHN0YXJ0IGFuZCBlbmQgZXZlcnkgdGlt
ZSB0aHJvdWdoDQo+IHRoZSBsb29wLg0KPiANCj4gVGhpcyBhbHNvIHNlZW1zIHRvIGhhdmUgYnVp
bHQgaW4gdGhlIGlkZWEgdGhhdCBjY19ta2RlYygpICpTRVRTKiBiaXRzDQo+IHJhdGhlciB0aGFu
IGNsZWFyaW5nIHRoZW0uICBUaGF0J3MgdHJ1ZSBmb3IgVERYIHRvZGF5LCBidXQgaXQncyBhDQo+
IGhvcnJpYmxlIGNodW5rIG9mIGNvZGUgdG8gbGVhdmUgYXJvdW5kIGJlY2F1c2UgaXQnbGwgY29u
ZnVzZSBhY3R1YWwNCj4gbGVnaXRpbWF0ZSBjY19lbmMvZGVjKCkgdXNlcnMuDQo+IA0KPiBUaGUg
bW9yZSBJIHdyaXRlIGFib3V0IGl0LCB0aGUgbW9yZSBJIGRpc2xpa2UgaXQuDQo+IA0KPiBXaHkg
Y2FuJ3QgdGhpcyBqdXN0IGJlOg0KPiANCj4gCQlpZiAoKG1hcF9mYWlsX3BhZGRyIDwgc3RhcnQp
IHx8DQo+IAkJICAgIChtYXBfZmFpbF9wYWRkciA+PSBlbmQpKQ0KPiAJCQlyZXR1cm4gZmFsc2U7
DQo+IA0KPiBJZiB0aGUgaHlwZXJ2aXNvciByZXR1cm5zIHNvbWUgY3JhenkgYWRkcmVzcyBpbiBy
MTEgdGhhdCBpc24ndCBtYXNrZWQNCj4gbGlrZSB0aGUgaW5wdXRzLCBqdXN0IGZhaWwuDQoNCldp
bGwgdXNlIHlvdXIgZXhhbXBsZSBjb2RlIGluIHYyLg0KDQo+ID4gKwkJc3RhcnQgPSByMTE7DQo+
ID4gKw0KPiA+ICsJCS8qIFNldCB0aGUgc2hhcmVkIChkZWNyeXB0ZWQpIGJpdC4gKi8NCj4gPiAr
CQlpZiAoIWVuYykNCj4gPiArCQkJc3RhcnQgfD0gY2NfbWtkZWMoMCk7DQo+IA0KPiBXaHkgaXMg
b25seSBvbmUgc2lkZSBvZiB0aGlzIG5lY2Vzc2FyeT8gIFNob3VsZG4ndCBpdCBuZWVkIHRvIGJl
DQo+IHNvbWV0aGluZyBsaWtlOg0KPiANCj4gCQlpZiAoZW5jKQ0KPiAJCQlzdGFydCA9IGNjX21r
ZW5jKHN0YXJ0KTsNCj4gCQllbHNlDQo+IAkJCXN0YXJ0ID0gY2NfbWtkZWMoc3RhcnQpOw0KPiAN
Cj4gPz8NClRoZSBjb2RlIGlzIHVubmVjZXNzYXJ5LiBXaWxsIHJlbW92ZSBpdCBpbiB2Mi4NCg==
