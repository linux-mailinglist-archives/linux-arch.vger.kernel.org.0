Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC6965864D
	for <lists+linux-arch@lfdr.de>; Wed, 28 Dec 2022 20:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbiL1TPu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Dec 2022 14:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiL1TPf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Dec 2022 14:15:35 -0500
Received: from DM4PR02CU001-vft-obe.outbound.protection.outlook.com (mail-centralusazon11022022.outbound.protection.outlook.com [52.101.63.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704C415FD0;
        Wed, 28 Dec 2022 11:15:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcrhFSmidpwI4dTm/6xT9jhZUNHdOs6mhRJr2T4aUP6d10tjGZaHqwRGCpXCO5tc8lcPeEnOj+LMMbEv4eRC9N9o/B2vtgAwey1WcWGa+z6ZdHz9f/JXrbZWw82T/4bqaQegu6FjST4JjokUvj3xGaQuV9q5leP8hPW15cDYJBbZLQcjpOGlkB+X1XEK+0k0eYxzRy3u+jr1he4BVfIP7Tcn07gAafFXFOJYspLcZKZCQxtCtJ23v16QSS/sBMxnLSaFhLulIizRzracKcTDFD0i1fOagcIm+zJ1qnqeQLGN1H67ohsZED1dI9/NVRucf6l7VQPyvaoqQHbK/8zAcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q34Azt9SJRhXCwGZuNcElzTdvcYtkZeZr2lVEBFg8lc=;
 b=D3HZ8RpC41KXGZ/kHbNv2LHMF8yUg3FQTUk/rASllVg/gDqlaiqPm/f1gLPZlfpY7ZZjPO3z6tdFPnyYRf69sGIhW+8ExKjBaRsMJd7WZUgSb6ejJFcH+YRCsCUaJDM63uvmACdTIF2LL4QoaIRdPAfDYfdodL8L3M3apMGloW43cpB/mUpVH5FqytcTeFdqnAYGa8H7/AndTANbiZflDzRDkZzrVA52B0C+M4oWKpF/KpSpjghNQdhayGDDmTGzolRtZFkLrcL2zzkjdyNWl7/LmjBycU7MI8CD5B19HIsM7bA9P3t50TEs5ZlBQwSEz9/qjuu1WOiXraDwlW8YUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q34Azt9SJRhXCwGZuNcElzTdvcYtkZeZr2lVEBFg8lc=;
 b=Q8FoW8vqBWXbnCQ7nF/lJT0wnHXnySbEhW9GvW0vfIdvHlWRlBMwPrFqirHf09xb4GqmKhbEHlHG/13TvAKmebFbJLhx/rh2YOWAy/CC9cNiUHs/qWuCBhrID6da4OQ5ft0G0lxDtuyibHqm/Kf1q/LZ0poGzxTC9gmg13h2tbA=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DS7PR21MB3246.namprd21.prod.outlook.com (2603:10b6:8:7e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.6; Wed, 28 Dec
 2022 19:15:31 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::db1a:4e71:c688:b7b1]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::db1a:4e71:c688:b7b1%7]) with mapi id 15.20.5986.007; Wed, 28 Dec 2022
 19:15:31 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Tianyu Lan <ltykernel@gmail.com>, Borislav Petkov <bp@alien8.de>
CC:     "luto@kernel.org" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "jgross@suse.com" <jgross@suse.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "jiangshan.ljs@antgroup.com" <jiangshan.ljs@antgroup.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
        "srutherford@google.com" <srutherford@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "sandipan.das@amd.com" <sandipan.das@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "venu.busireddy@oracle.com" <venu.busireddy@oracle.com>,
        "sterritt@google.com" <sterritt@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [RFC PATCH V2 01/18] x86/sev: Pvalidate memory gab for
 decompressing kernel
Thread-Topic: [RFC PATCH V2 01/18] x86/sev: Pvalidate memory gab for
 decompressing kernel
Thread-Index: AQHY+8mTKXqZ19wKvkegsFkVhc8bGK5V7GwAgAAdswCALdtJ4A==
Date:   Wed, 28 Dec 2022 19:15:31 +0000
Message-ID: <BYAPR21MB16886D446C3AC972AFF8DAB9D7F29@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20221119034633.1728632-1-ltykernel@gmail.com>
 <20221119034633.1728632-2-ltykernel@gmail.com> <Y4YBfk3lyUJie4bR@zn.tnic>
 <6b3bdbbd-d381-3e52-57ec-729c8ab2d042@gmail.com>
In-Reply-To: <6b3bdbbd-d381-3e52-57ec-729c8ab2d042@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ac012643-ebf8-460f-af35-ac31c1e50536;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-12-28T18:59:20Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DS7PR21MB3246:EE_
x-ms-office365-filtering-correlation-id: 6f4ad7d9-862e-4c8a-d273-08dae907e367
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N68grn8vqTyaSv5bYMlRjYPU30YPTOPcv1iHjUAo8tlwvs4bJ0Z5Fnt6u8wiZeNL0x1a70CQZdlafi/XyHuAeionZIR/titQIbua6cbJH5/lHiO9VmKxTWrbUc+xNymX14wsap4ArkdjgSa4M6cednoU/ZwJqTMSHyt3nvtLgckiZXrOUgNek55SHokh14C7WfCq9WVsyuCTaoa5VoqFf2EXNlsX5nA1Y29S0x5M0Fh57OdxyAfd1hZBRKWqMvHqh79RiygNxK995chJMLw1NsyaF7aAId813pD2/L/T8+4LcEnBV6iiCVarwNfik8A6rnKQugl6pV2+9HjxpwV71sdEYQ+neRGxnsMscPNKNZpoSgf/85O4yYf1AjkccX439a/ph063SafvKk9Q+mP4d8qaAhFJ36aX1MFWqu9JOKDRmbfULpoUbG73mXil9CT9yZ+h4EaSaNk8e6yQcYh67X3IoVJb3i7ijaoYmrJ6rpe+GD5g5I/TjgfqwW1ro+jhuRIXbzAlzmC1ke0EnN6yw3QFjAVGML1t2m3EidpdfUJOFDM6DViH7k/UEgMeXdPIbxFGzvOeSTRMV3E7CEu0FNP98V3Xzic9KJc3d5UjS8UarxSyk2KSX+PjS8rlq639Hjwgh8+OzLQy9uHV99rY/D+5Jc6BBG1TxTIrVqGV0eDYDKijjGL3l/txXRzTU3yRFFR0KFOzVkKgM9KsrnV2J9sDwJaG5EcJy3r9auR41AE/2HMsdYDIfAEph4GUU32r
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(451199015)(33656002)(316002)(2906002)(55016003)(8990500004)(54906003)(83380400001)(4326008)(41300700001)(7416002)(7406005)(5660300002)(52536014)(64756008)(66946007)(8676002)(110136005)(76116006)(8936002)(66556008)(66446008)(66476007)(86362001)(53546011)(6506007)(7696005)(122000001)(478600001)(71200400001)(38070700005)(82960400001)(82950400001)(9686003)(186003)(10290500003)(38100700002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWxIdzhNZjYrVHdvTnlBOU5ZVEFHWVFuc0F3bUFubEZTZkNVS3FEVnh5VHpP?=
 =?utf-8?B?Q3JuVlNEdkFqNWFKZTFhZG1lR3ZZZ09GZyt4SFZ2WGFUNnVJQkdMQXF3Vkk3?=
 =?utf-8?B?c09SSVdESjZVRGI3bVE3dnFYVEp5aHJRcmI1QU5wS1N0UEExNHl5TURocU43?=
 =?utf-8?B?Tk8xK1ZQYUlUWjRyRVpPWEZ1Q1E1WVNKSmN3VFNBSnlndUhtUmRYYzRJSUI0?=
 =?utf-8?B?RGVXWXpsc08wZWh2aHB1cEZKOGE5MmxLdTZGUVh1UWdjbS9Qell3TzA4RU80?=
 =?utf-8?B?TWplbVRMYXhrRFRnN284VEFyWTRaQ0FpanZZOUUxVHVDVm0zbko4OWpOMmx5?=
 =?utf-8?B?Y2V0M3hjU0VjR21vVCtkSVZGZUlhb2Y5Wm5GMzNqak9uWGZJcVlqZjRCeTlK?=
 =?utf-8?B?TlZmRzgzRTFOa3ZYcmFoTXVEYUNRbzJtNHJCaVlmaE5HY1Bkb0pzNW5QZDl5?=
 =?utf-8?B?UVhFZkxlUWtTTkpVU3lDeGI5QUJSL0ZQQjIyTXpUdUFKMm9WQUlQYmQ1MjlW?=
 =?utf-8?B?Tlk1MFoxMFF0eW1NUFdRYnZ3dXBBZ1FYWkpWNElOMzFCQkJuR2c1YXZXY2F1?=
 =?utf-8?B?blJETE0zV2g0dE9lNkZ1bVNwMEJncmRmSGJ1V1BTeWE1d3d3bzBaekpZQ1FT?=
 =?utf-8?B?T3A4Mkk2aWQyQlhwdjRnSElQaFZMQmd1di9YTTd4RHNyYk5HdjRCSWNUVURi?=
 =?utf-8?B?bThuakVDRWFEZU0zM0l6WnZpaG9CNW01cDBzWnJjODh4NGM1MzNnM0prekEy?=
 =?utf-8?B?bHpieEVwVDA5QjFrSXNKUXgzaWFNa3owalU2ZFRCcTA3RTFONGZYQzBocm1j?=
 =?utf-8?B?QURmKzA2THZ4ODdNaVRDVHQwOG5RUGdGQmVpZW9VTVVpc3REM0g2bXUwYzhn?=
 =?utf-8?B?MmNFZUhmVnFLOC9aK0lMbjFCb1ozU3Zva0I4UldKbU8vZEszNUhLVXpTeWg0?=
 =?utf-8?B?SnpGbnNRNFNnZmg1anBiOWV0cW9HMmFnSXpObCtkMWJWWnBySkdGcmFmWjEz?=
 =?utf-8?B?K2hwQzNQSHF2Z2dXeXlCcGx6L3Bzc0o5UUZYcCtTSS84NENwdXlOeEhWcXhu?=
 =?utf-8?B?WTJkdmxpOFhSejYrU1oxbTIvOHRkbnBmb043Rmg4enMvWUVrT09obUlRVXhH?=
 =?utf-8?B?dkRqM3hvV0E2S3VDWS9JZmhtWDFxa0V6U1NNV2sxcHQyVlFxYTcyaER0RURj?=
 =?utf-8?B?cFRoVTc5SXM1SnNpVGxVSU1hOVpvUU05dmNseWJubmdiV0FCRlFrOVNDWG4x?=
 =?utf-8?B?aC9TL0lrSktSbG93RzlwMDgvVTlCS1JJVVRzdEtCdWw0Yi8rM1krNGVVOUd0?=
 =?utf-8?B?YnpTckYvYVhEVFVWRW1mMjl5SVF5QmQxMTRTa0czaW9TTW9MbVFzUUtzdXIz?=
 =?utf-8?B?OHlxQ0VDODUwRlVwY1hNSXhxdG0wbmlIWE1qN2tSbGlsT0Y5bktKQ2Z1em92?=
 =?utf-8?B?R09kZnRab1M2dTlwSVh3a0FuVWpxZi9VMHNaK0E2TGFzZE45VkR4VUJsYm9E?=
 =?utf-8?B?SHpqejBzcjFvdGZYQ1N5NWpwZjNOaGd1OTI0UW03dDkzNlRzZ3hHRHoxdDl2?=
 =?utf-8?B?TG81ZVE1Z2l0Vlk2QllCekpGZlJybGhRUEYybHVQSjhYVnltQmZ6c1VKbG9V?=
 =?utf-8?B?anAzTUdsSmgxZWI3WU5SdGJyZ1J0UHdtMHpwZUFmT1dXTG92MDcyTDVmR2dF?=
 =?utf-8?B?elVTb2VkdXFyV1phalNpY2R5eUNQTW8wNlptUUxVVzVJME5OMUdJN2g4dFE0?=
 =?utf-8?B?RFBJN29QNzN1bWxDNUV0c1AxcnlGZFFRRlBQSHBEMGdIQUorcUNCckQ3NERj?=
 =?utf-8?B?VnZPQk1yU05saFVuVzUwQ1l2K2tIbkpGSm1SV3pIbGg5bThXSFFjV3VuUzBa?=
 =?utf-8?B?V1FzZG5nbE1VWG9MS0wvNjBXcXh1VXlhQjVtV3N2am55SWFrYmZEc3pNbVp5?=
 =?utf-8?B?OEcxU3RWRkJDeHdGdHNXVnRuK3pxYmcxYjc0RCtJcG1jNE56cnVYRWxWZDNv?=
 =?utf-8?B?YjFxSmx2bmhLUHhYczlkUHFlb2tTSmM1dWtsUEVyVnF4VHpkZ3BRSnlhL2ZB?=
 =?utf-8?B?bHFteWNrWDl2cTUyWHMvRUxLSklPMENva0RaeHQvR1ErQmJMNDNIUHVEZGVn?=
 =?utf-8?B?RCs1N0EzN0dyVDM3d24zbnFrVUVhK1hDK2JwNXZmUEtqakhKNUNwT050VDlG?=
 =?utf-8?B?MGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4ad7d9-862e-4c8a-d273-08dae907e367
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2022 19:15:31.4996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bYkhb+h7hHM7+t0C46ZYis9GUcGDAkR5fPpNYzIuS/7Uk3XGkLOcqTZVnYZ3yaTyp5BKqsH+RAogQrqYSE5m8XuKd0q/N96kheTw2M1ibR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3246
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogVGlhbnl1IExhbiA8bHR5a2VybmVsQGdtYWlsLmNvbT4gU2VudDogVHVlc2RheSwgTm92
ZW1iZXIgMjksIDIwMjIgNjo0MyBBTQ0KPiANCj4gT24gMTEvMjkvMjAyMiA4OjU2IFBNLCBCb3Jp
c2xhdiBQZXRrb3Ygd3JvdGU6DQo+ID4+ICsvKiBDaGVjayBTRVYtU05QIHZpYSBNU1IgKi8NCj4g
Pj4gK3N0YXRpYyBib29sIHNldl9zbnBfcnVudGltZV9jaGVjayh2b2lkKQ0KPiA+IEZ1bmN0aW9u
cyBuZWVkIHRvIGhhdmUgYSB2ZXJiIGluIHRoZSBuYW1lLg0KPiA+DQo+ID4+ICt7DQo+ID4+ICsJ
dW5zaWduZWQgbG9uZyBsb3csIGhpZ2g7DQo+ID4+ICsJdTY0IHZhbDsNCj4gPj4gKw0KPiA+PiAr
CWFzbSB2b2xhdGlsZSgicmRtc3JcbiIgOiAiPWEiIChsb3cpLCAiPWQiIChoaWdoKSA6DQo+ID4+
ICsJCQkiYyIgKE1TUl9BTUQ2NF9TRVYpKTsNCj4gPj4gKw0KPiA+PiArCXZhbCA9IChoaWdoIDw8
IDMyKSB8IGxvdzsNCj4gPj4gKwlpZiAodmFsICYgTVNSX0FNRDY0X1NFVl9TTlBfRU5BQkxFRCkN
Cj4gPj4gKwkJcmV0dXJuIHRydWU7DQo+ID4gVGhlcmUgYWxyZWFkeSBpcyBhIHNldl9zbnBfZW5h
YmxlZCgpIGluIHRoYXQgdmVyeSBzYW1lIGZpbGUuIERpZCB5b3Ugbm90DQo+ID4gc2VlIGl0Pw0K
PiA+DQo+ID4gV2h5IGFyZSB5b3UgZXZlbiBhZGRpbmcgc3VjaCBhIGZ1bmN0aW9uPyENCj4NCj4g
SGkgQm9yaXM6DQo+IAlUaGFua3MgZm9yIHlvdXIgcmV2aWV3LiBzZXZfc25wX2VuYWJsZWQoKSBp
cyB1c2VkIGFmdGVyDQo+IHNldl9zdGF0dXMgd2FzIGluaXRpYWxpemVkIGluIHNldl9lbmFibGUo
KSB3aGlsZSAgcHZhbGlkYXRlX2Zvcl9zdGFydHVwXw0KPiA2NCgpIGlzIGNhbGxlZCBiZWZvcmUg
c2V2X2VuYWJsZSgpLiBTbyBhZGQgc2V2X3NucF9ydW50aW1lX2NoZWNrKCkgdG8NCj4gY2hlY2sg
c2V2IHNucCBjYXBhYmlsaXR5IGJlZm9yZSBjYWxsaW5nIHNldl9lbmFibGUoKS4NCg0KSSB1bmRl
cnN0YW5kIG5lZWRpbmcgdG8gZmluZCBvdXQgaWYgU0VWLVNOUCBpcyBlbmFibGVkIGJlZm9yZSBz
ZXZfZW5hYmxlKCkNCmhhcyBzZXQgdGhlIHZhbHVlIG9mIHNldl9zdGF0dXMuICBVbmZvcnR1bmF0
ZWx5LCBqdXN0IGNoZWNraW5nIHRoZQ0KU0VWX1NOUF9FTkFCTEVEIGJpdCBpbiBNU1JfQU1ENjRf
U0VWIGlzbid0IHN1ZmZpY2llbnQuICBzZXZfZW5hYmxlKCkNCmNvcnJlY3RseSBkb2VzIGEgbW9y
ZSBjb21wbGV4IGNoZWNrLiAgVGhlIENQVUlEIGJpdCBpcyBjaGVja2VkIGZpcnN0LCBhbmQNCnRo
ZSBNU1IgaXMgcmVhZCBvbmx5IGlmIHRoZSBDUFVJRCBiaXQgaW5kaWNhdGluZyBTRVYgaXMgc2V0
LiAgVGhlIHJlYXNvbiBmb3INCnRoaXMgYmVoYXZpb3IgaXMgZGVzY3JpYmVkIGluIHRoZSBjb21t
aXQgbWVzc2FnZSBmb3IgMDA5NzY3ZGJmNDJhLg0KRnVydGhlcm1vcmUsIGV2ZW4gaWYgdGhlIE1T
UiBpcyBzYWZlIHRvIHJlYWQsIGp1c3QgY2hlY2tpbmcgdGhlDQpTRVZfU05QX0VOQUJMRUQgYml0
IGlzbid0IHN1ZmZpY2llbnQgYmVjYXVzZSB0aGF0IGJpdCBpcyAiMSIgaW4gYSB2VE9NIFZNLg0K
VGhlIE1TUiBjaGVjayB3b3VsZCBuZWVkIHRvIGJlIHRoYXQgU0VWX1NOUF9FTkFCTEVEIGlzIHNl
dCwgYW5kDQpWVE9NX0VOQUJMRUQgaXMgbm90IHNldC4NCg0KTWljaGFlbA0KDQo+IA0KPiA+DQo+
ID4+ICsJcmV0dXJuIGZhbHNlOw0KPiA+PiArfQ0KPiA+PiArDQo+ID4+ICAgc3RhdGljIGlubGlu
ZSBib29sIHNldl9zbnBfZW5hYmxlZCh2b2lkKQ0KPiA+PiAgIHsNCj4gPj4gICAJcmV0dXJuIHNl
dl9zdGF0dXMgJiBNU1JfQU1ENjRfU0VWX1NOUF9FTkFCTEVEOw0KPiA+PiBAQCAtNDU2LDMgKzQ3
NSw2OCBAQCB2b2lkIHNldl9wcmVwX2lkZW50aXR5X21hcHModW5zaWduZWQgbG9uZyB0b3BfbGV2
ZWxfcGd0KQ0KPiA+Pg0KPiA+PiAgIAlzZXZfdmVyaWZ5X2NiaXQodG9wX2xldmVsX3BndCk7DQo+
ID4+ICAgfQ0KPiA+PiArDQo+ID4+ICtzdGF0aWMgdm9pZCBleHRlbmRfZTgyMF9vbl9kZW1hbmQo
c3RydWN0IGJvb3RfZTgyMF9lbnRyeSAqZTgyMF9lbnRyeSwNCj4gPj4gKwkJCQkgIHU2NCBuZWVk
ZWRfcmFtX2VuZCkNCj4gPj4gK3sNCj4gPj4gKwl1NjQgZW5kLCBwYWRkcjsNCj4gPj4gKwl1bnNp
Z25lZCBsb25nIGVmbGFnczsNCj4gPj4gKwlpbnQgcmM7DQo+ID4+ICsNCj4gPj4gKwlpZiAoIWU4
MjBfZW50cnkpDQo+ID4+ICsJCXJldHVybjsNCj4gPj4gKw0KPiA+PiArCS8qIFZhbGlkYXRlZCBt
ZW1vcnkgbXVzdCBiZSBhbGlnbmVkIGJ5IFBBR0VfU0laRS4gKi8NCj4gPj4gKwllbmQgPSBBTElH
TihlODIwX2VudHJ5LT5hZGRyICsgZTgyMF9lbnRyeS0+c2l6ZSwgUEFHRV9TSVpFKTsNCj4gPj4g
KwlpZiAobmVlZGVkX3JhbV9lbmQgPiBlbmQgJiYgZTgyMF9lbnRyeS0+dHlwZSA9PSBFODIwX1RZ
UEVfUkFNKSB7DQo+ID4+ICsJCWZvciAocGFkZHIgPSBlbmQ7IHBhZGRyIDwgbmVlZGVkX3JhbV9l
bmQ7IHBhZGRyICs9IFBBR0VfU0laRSkgew0KPiA+PiArCQkJcmMgPSBwdmFsaWRhdGUocGFkZHIs
IFJNUF9QR19TSVpFXzRLLCB0cnVlKTsNCj4gPj4gKwkJCWlmIChyYykgew0KPiA+PiArCQkJCWVy
cm9yKCJGYWlsZWQgdG8gdmFsaWRhdGUgYWRkcmVzcy5uIik7DQo+ID4+ICsJCQkJcmV0dXJuOw0K
PiA+PiArCQkJfQ0KPiA+PiArCQl9DQo+ID4+ICsJCWU4MjBfZW50cnktPnNpemUgPSBuZWVkZWRf
cmFtX2VuZCAtIGU4MjBfZW50cnktPmFkZHI7DQo+ID4+ICsJfQ0KPiA+PiArfQ0KPiA+PiArDQo+
ID4+ICsvKg0KPiA+PiArICogRXhwbGljaXRseSBwdmFsaWRhdGUgbmVlZGVkIHBhZ2VzIGZvciBk
ZWNvbXByZXNzaW5nIHRoZSBrZXJuZWwuDQo+ID4+ICsgKiBUaGUgRTgyMF9UWVBFX1JBTSBlbnRy
eSBpbmNsdWRlcyBvbmx5IHZhbGlkYXRlZCBtZW1vcnkuIFRoZSBrZXJuZWwNCj4gPj4gKyAqIGV4
cGVjdHMgdGhhdCB0aGUgUkFNIGVudHJ5J3MgYWRkciBpcyBmaXhlZCB3aGlsZSB0aGUgZW50cnkg
c2l6ZSBpcyB0byBiZQ0KPiA+PiArICogZXh0ZW5kZWQgdG8gY292ZXIgYWRkcmVzc2VzIHRvIHRo
ZSBzdGFydCBvZiBuZXh0IGVudHJ5Lg0KPiA+PiArICogVGhlIGZ1bmN0aW9uIGluY3JlYXNlcyB0
aGUgUkFNIGVudHJ5IHNpemUgdG8gY292ZXIgYWxsIHBvc3NpYmxlIG1lbW9yeQ0KPiA+IFNpbWls
YXIgaXNzdWUgYXMgYWJvdmU6IHlvdSBkb24ndCBuZWVkIHRvIHNheSAidGhpcyBmdW5jdGlvbiIg
YWJvdmUgdGhpcw0KPiA+IGZ1bmN0aW9uLiBJT1csIGl0IHNob3VsZCBzYXk6DQo+ID4NCj4gPiAi
SW5jcmVhc2UgdGhlIFJBTSBlbnRyeSBzaXplLi4uIg0KPiA+DQo+ID4gSS5lLiwgaW1wZXJhdGl2
ZSBtb29kIGFib3ZlLg0KPiA+DQo+ID4+ICsgKiBhZGRyZXNzZXMgdW50aWwgaW5pdF9zaXplLg0K
PiA+PiArICogRm9yIGV4YW1wbGUsICBpbml0X2VuZCA9IDB4NDAwMDAwMCwNCj4gPj4gKyAqIFtS
QU06IDB4MCAtIDB4MF0sICAgICAgICAgICAgICAgICAgICAgICBNW1JBTTogMHgwIC0gMHhhMDAw
MF0NCj4gPj4gKyAqIFtSU1ZEOiAweGEwMDAwIC0gMHgxMDAwMF0gICAgICAgICAgICAgICAgW1JT
VkQ6IDB4YTAwMDAgLSAweDEwMDAwXQ0KPiA+PiArICogW0FDUEk6IDB4MTAwMDAgLSAweDIwMDAw
XSAgICAgID09PiAgICAgICBbQUNQSTogMHgxMDAwMCAtIDB4MjAwMDBdDQo+ID4+ICsgKiBbUlNW
RDogMHg4MDAwMDAgLSAweDkwMDAwMF0gICAgICAgICAgICAgIFtSU1ZEOiAweDgwMDAwMCAtIDB4
OTAwMDAwXQ0KPiA+PiArICogW1JBTTogMHgxMDAwMDAwIC0gMHgyMDAwMDAwXSAgICAgICAgICAg
IE1bUkFNOiAweDEwMDAwMDAgLSAweDIwMDEwMDBdDQo+ID4+ICsgKiBbUkFNOiAweDIwMDEwMDAg
LSAweDIwMDcwMDBdICAgICAgICAgICAgTVtSQU06IDB4MjAwMTAwMCAtIDB4NDAwMDAwMF0NCj4g
PiBXaGF0IGlzIHRoaXMgdHJ5aW5nIHRvIHRlbGwgbWU/DQo+ID4NCj4gPiBUaGF0IHRoZSBlbmQg
cmFuZ2UgMHgyMDA3MDAwIGdldHMgcmFpc2VkIHRvIDB4NDAwMDAwMD8NCj4gPg0KPiA+IFdoeT8N
Cj4gPg0KPiA+IFRoaXMgYWxsIHNvdW5kcyBsaWtlIHRoZXJlIGlzIHNvbWUgcmVxdWlyZW1lbnQg
c29tZXdoZXJlIGJ1dCBub3RoaW5nDQo+ID4gc2F5cyB3aGF0IHRoYXQgcmVxdWlyZW1lbnQgaXMg
YW5kIHdoeS4NCj4gPg0KPiA+PiArICogT3RoZXIgUkFNIG1lbW9yeSBhZnRlciBpbml0X2VuZCBp
cyBwdmFsaWRhdGVkIGJ5IG1zX2h5cGVydl9pbml0X3BsYXRmb3JtDQo+ID4+ICsgKi8NCj4gPj4g
K19fdmlzaWJsZSB2b2lkIHB2YWxpZGF0ZV9mb3Jfc3RhcnR1cF82NChzdHJ1Y3QgYm9vdF9wYXJh
bXMgKmJvb3RfcGFyYW1zKQ0KPiA+IFRoaXMgZG9lc24ndCBkbyBhbnkgdmFsaWRhdGlvbi4gQW5k
IHlldCBpdCBoYXMgInB2YWxpZGF0ZSIgaW4gdGhlIG5hbWUuDQo+ID4NCj4gPj4gK3sNCj4gPj4g
KwlzdHJ1Y3QgYm9vdF9lODIwX2VudHJ5ICplODIwX2VudHJ5Ow0KPiA+PiArCXU2NCBpbml0X2Vu
ZCA9DQo+ID4+ICsJCWJvb3RfcGFyYW1zLT5oZHIucHJlZl9hZGRyZXNzICsgYm9vdF9wYXJhbXMt
Pmhkci5pbml0X3NpemU7DQo+ID4gTm9wZSwgd2UgbmV2ZXIgYnJlYWsgbGluZXMgbGlrZSB0aGF0
Lg0KPiA+DQo+ID4+ICsJdTggaSwgbnJfZW50cmllcyA9IGJvb3RfcGFyYW1zLT5lODIwX2VudHJp
ZXM7DQo+ID4+ICsJdTY0IG5lZWRlZF9lbmQ7DQo+ID4gVGhlIHRpcC10cmVlIHByZWZlcnJlZCBv
cmRlcmluZyBvZiB2YXJpYWJsZSBkZWNsYXJhdGlvbnMgYXQgdGhlDQo+ID4gYmVnaW5uaW5nIG9m
IGEgZnVuY3Rpb24gaXMgcmV2ZXJzZSBmaXIgdHJlZSBvcmRlcjo6DQo+ID4NCj4gPiAJc3RydWN0
IGxvbmdfc3RydWN0X25hbWUgKmRlc2NyaXB0aXZlX25hbWU7DQo+ID4gCXVuc2lnbmVkIGxvbmcg
Zm9vLCBiYXI7DQo+ID4gCXVuc2lnbmVkIGludCB0bXA7DQo+ID4gCWludCByZXQ7DQo+ID4NCj4g
PiBUaGUgYWJvdmUgaXMgZmFzdGVyIHRvIHBhcnNlIHRoYW4gdGhlIHJldmVyc2Ugb3JkZXJpbmc6
Og0KPiA+DQo+ID4gCWludCByZXQ7DQo+ID4gCXVuc2lnbmVkIGludCB0bXA7DQo+ID4gCXVuc2ln
bmVkIGxvbmcgZm9vLCBiYXI7DQo+ID4gCXN0cnVjdCBsb25nX3N0cnVjdF9uYW1lICpkZXNjcmlw
dGl2ZV9uYW1lOw0KPiA+DQo+ID4gQW5kIGV2ZW4gbW9yZSBzbyB0aGFuIHJhbmRvbSBvcmRlcmlu
Zzo6DQo+ID4NCj4gPiAJdW5zaWduZWQgbG9uZyBmb28sIGJhcjsNCj4gPiAJaW50IHJldDsNCj4g
PiAJc3RydWN0IGxvbmdfc3RydWN0X25hbWUgKmRlc2NyaXB0aXZlX25hbWU7DQo+ID4gCXVuc2ln
bmVkIGludCB0bXA7DQo+ID4NCj4gPj4gKwlpZiAoIXNldl9zbnBfcnVudGltZV9jaGVjaygpKQ0K
PiA+PiArCQlyZXR1cm47DQo+ID4+ICsNCj4gPj4gKwlmb3IgKGkgPSAwOyBpIDwgbnJfZW50cmll
czsgKytpKSB7DQo+ID4+ICsJCS8qIFB2YWxpZGF0ZSBtZW1vcnkgaG9sZXMgaW4gZTgyMCBSQU0g
ZW50cmllcy4gKi8NCj4gPj4gKwkJZTgyMF9lbnRyeSA9ICZib290X3BhcmFtcy0+ZTgyMF90YWJs
ZVtpXTsNCj4gPj4gKwkJaWYgKGkgPCBucl9lbnRyaWVzIC0gMSkgew0KPiA+PiArCQkJbmVlZGVk
X2VuZCA9IGJvb3RfcGFyYW1zLT5lODIwX3RhYmxlW2kgKyAxXS5hZGRyOw0KPiA+PiArCQkJaWYg
KG5lZWRlZF9lbmQgPCBlODIwX2VudHJ5LT5hZGRyKQ0KPiA+PiArCQkJCWVycm9yKCJlODIwIHRh
YmxlIGlzIG5vdCBzb3J0ZWQuXG4iKTsNCj4gPj4gKwkJfSBlbHNlIHsNCj4gPj4gKwkJCW5lZWRl
ZF9lbmQgPSBpbml0X2VuZDsNCj4gPj4gKwkJfQ0KPiA+PiArCQlleHRlbmRfZTgyMF9vbl9kZW1h
bmQoZTgyMF9lbnRyeSwgbmVlZGVkX2VuZCk7DQo+ID4gTm93KnRoaXMqICBmdW5jdGlvbiBkb2Vz
IGNhbGwgcHZhbGlkYXRlKCkgYW5kIHlldCBpdCBkb2Vzbid0IGhhdmUNCj4gPiAicHZhbGlkYXRl
IiBpbiB0aGUgbmFtZS4gVGhpcyBhbGwgbG9va3MgcmVhbCBjb25mdXNlZC4NCj4gPg0KPiA+IFNv
IGZpcnN0IG9mIGFsbCwgeW91IG5lZWQgdG8gZXhwbGFpbip3aHkqICB5b3UncmUgZG9pbmcgdGhp
cy4NCj4gPg0KPiA+IEl0IGxvb2tzIGxpa2UgaXQgaXMgYmVjYXVzZSB0aGUgZ3Vlc3QgbmVlZHMg
dG8gZG8gdGhlIG1lbW9yeSB2YWxpZGF0aW9uDQo+ID4gYnkgaXRzZWxmIGJlY2F1c2Ugbm9ib2R5
IGVsc2UgZG9lcyB0aGF0Lg0KPiA+DQo+ID4gSWYgc28sIHRoaXMgbmVlZHMgdG8gYmUgZXhwbGFp
bmVkIGluIGRldGFpbCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuDQo+IA0KPiBZZXMsIEkgd2lsbCB1
cGRhdGUgaW4gdGhlIG5leHQgdmVyc2lvbi4gVGhhbmtzIGZvciBzdWdnZXN0aW9uLg0KPiANCj4g
Pg0KPiA+IEFsc28sIHdoeSBpcyB0aGF0IG9rIGZvciBTTlAgZ3Vlc3RzIG9uIG90aGVyIGh5cGVy
dmlzb3JzIHdoaWNoIGdldCB0aGUNCj4gPiBtZW1vcnkgdmFsaWRhdGVkIGJ5IHRoZSBib290IGxv
YWRlciBvciBmaXJtd2FyZT8NCj4gDQo+IFRoaXMgaXMgZm9yIExpbnV4IGRpcmVjdCBib290IG1v
ZGUgYW5kIHNvIGl0IG5lZWRzIHRvIGRvIHN1Y2ggY2hlY2sNCj4gaGVyZS4gV2lsbCBmaXggdGhp
cyBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0K
