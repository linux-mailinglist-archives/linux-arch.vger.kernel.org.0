Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0C37BBE7B
	for <lists+linux-arch@lfdr.de>; Fri,  6 Oct 2023 20:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbjJFSNh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Oct 2023 14:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbjJFSNg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Oct 2023 14:13:36 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020024.outbound.protection.outlook.com [52.101.56.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C94DBF;
        Fri,  6 Oct 2023 11:13:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDvo4Yj4/CdG0nSmduvXZlTyqMqg4J33HnASqmN47dG9V94hqoyh2q/cnxjrjYe35XLuZduuTnXgp26m7r/yr9Dz81NCEmqQkU3b2ztdcc9qTTrfs8zIyUs5inHnuFa8wRUGoNyFDd74YtDf435r44FEWB2E7PEuWnhKgVy+254LavjC66O5N96Bc/7EK7b/CazFJ3T1O8+NHXzSwtUNdLh+NZERKlVLf40O2Zud3/CIomyXlrk4dU0a7GQ3OEorIR9cM2Ebz4Yetq8GgDqBxolFuJMBPew7Kjyxp1YaOOtk39zKMVvVVJx2deRhAtlAIlT9/ArKsqqdRLddVlyf+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKnM09NBEwlP05TwXlsD+52zOBv6STmUjPPo4vaMuDg=;
 b=XV565Tc8Nku3TGG9kJgQNFNrAtpvaKC5ZeOs0rzUBCUYNoJ8qOAtXIB3Mn//eer+sMwRsJxcUmo/N4IKXWSrwAW6vL7uQz1Hc3gNQOdEQfMaa0daurkmnrUA9mZTy2u/USkiqWGpexvPm0X4Va08NFiCk7PYn0cMX+sigeBolcdIrZvBgM8dNSLIm/VUHF1P31DzsRQVo+xxmoGk+LwxOfPJSo1PSLts+3aNrUEl5ybnaAnfGDcejkS78DzBBXogX2igHz1rVzoY8utG/qfeqSCzDr3XhuV9R0CtUFXvZOol/9uIBmPzwK1YOYzKhzQNoV4zCMZIXKQ3zuTrpykESw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKnM09NBEwlP05TwXlsD+52zOBv6STmUjPPo4vaMuDg=;
 b=ClfKq0fv4zfh1w+9CeeizDeGfSABXIR0v2ghUHMSfG+esHRf08yIiPZmZBBVPC6eo3uKIOJRcV2ZNlu4cvr3rCo5iCsOMYpt6Z6ujAbNozZuDtFlJUn/qvVEJOpkW8XY/rdXiI4XCoNd1ySKeg1ebFnP2m6Z7rDn/XldkCI2yIc=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by BY5PR21MB1473.namprd21.prod.outlook.com (2603:10b6:a03:239::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.15; Fri, 6 Oct
 2023 18:13:29 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::bc89:f4fb:3df6:66d9]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::bc89:f4fb:3df6:66d9%4]) with mapi id 15.20.6886.015; Fri, 6 Oct 2023
 18:13:28 +0000
From:   Long Li <longli@microsoft.com>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Alex Ionescu <aionescu@gmail.com>,
        Dexuan Cui <decui@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "apais@linux.microsoft.com" <apais@linux.microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        MUKESH RATHOR <mukeshrathor@microsoft.com>,
        "stanislav.kinsburskiy@gmail.com" <stanislav.kinsburskiy@gmail.com>,
        "jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>
Subject: RE: [PATCH v4 09/15] Drivers: hv: Introduce hv_output_arg_exists in
 hv_common.c
Thread-Topic: [PATCH v4 09/15] Drivers: hv: Introduce hv_output_arg_exists in
 hv_common.c
Thread-Index: AQHZ8v8YYiojdoyEt0WH7hU8r776QrA253KAgAMTjACAAx694A==
Date:   Fri, 6 Oct 2023 18:13:28 +0000
Message-ID: <PH7PR21MB3263F2F8507C8472DE00F546CEC9A@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1696010501-24584-10-git-send-email-nunodasneves@linux.microsoft.com>
 <CAJ-90N+A-wS-Uwrs_2WVL86Uo3qzQ1czxm-u9vDj3UuOwjhLdQ@mail.gmail.com>
 <c79ee00f-253d-40d5-9ed6-0f156dc4ebb1@linux.microsoft.com>
In-Reply-To: <c79ee00f-253d-40d5-9ed6-0f156dc4ebb1@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=74c7efda-59dd-4030-9b77-812f90078a40;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-10-06T18:06:42Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|BY5PR21MB1473:EE_
x-ms-office365-filtering-correlation-id: baf89ef7-e06a-4bf1-a0ab-08dbc697f0ad
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cr8bKvFAKND+unXiyyhJiaV4+PyAXnDJPO55FByUK49HzahqwE9TQrEbEdq5xSUVFk5HvJ147SlQMo5xHenEESI+IVwnKO8sAbQMfxBQAAMkarKuw/mf+9S8+425Ml6RlptgHZfeS/7ZsTggByYLPFpnnbGLcic3rmzZb9rPwhb0gWEy0CD9L/cmTBfD42dzARwcswThsOtQDHyPzSA3ahpAc0zPSG17GewVwaDPOTMJbEnRsHvhVKd2twHnaBKfR4Ly8+5XDL1zxtjiPE4rx9wnZaR+mTuevLsFN2ieyi8IjiQiRaJrl26jvSZjCRvSu0NKQq4cVNp4jbkOBsazGfcOcThYke4P2pLMq8mK4KB75VXfzrwuak/MRoc8ZZ+Sf2fiDiHM9xBt+EtVPyUeB6Le5i2CFk3qJyNlS90PSHkgSOM1X0/keLLy2NMbb9pKSeUJ81j+QzzrWOFB7SZcaQwrT637kx2fp5Aia6c91xEYCih/5WogX+HpbDt9OzD3MG6dKmRCSQNbfvFN15P7ARl39kC2hpo11/ZZz7LdC58Qe6QuensGYbk05PiNE8fWQgtyrpscZsgnfJDkmoDaaCJUor+PxST3e8E0JlIUaszlb3LkvcFKgaD0KgGK8RcXpj6P8FnNnK0MuQUswgMFzB+b1gg3JvKywNSqGuc9zGk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(53546011)(6506007)(7696005)(71200400001)(478600001)(10290500003)(9686003)(26005)(7416002)(4744005)(316002)(2906002)(8990500004)(41300700001)(6636002)(76116006)(110136005)(66446008)(66476007)(66556008)(66946007)(5660300002)(64756008)(4326008)(52536014)(8676002)(8936002)(54906003)(33656002)(38100700002)(38070700005)(86362001)(122000001)(82960400001)(82950400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1kzbTlFblBPZGoxb0M3TWJFZXhVTHNmS3NkVFUzNGJJRENIVEFtOWJlN21h?=
 =?utf-8?B?OWpUYVZuSzQzRFIwV1I5NURiSUFNWXFQMlZST25xc3ExaS8yTksvRE9XTGVs?=
 =?utf-8?B?VStXdkFPWVJsVi9FVGRZU3N2cWV1SVRoL0ViWkorMEVHbms1b1RoNGV1bGd6?=
 =?utf-8?B?dEFCdi95OW5Jd0JUQjlmY29yK3lnK3V5Y056ZG9wV0NpbEp6OGFoK3IwT3Rw?=
 =?utf-8?B?c0tBbms1QlFlR3hIZkdvRkE1YkpDczJBUU9md1l0TlFuQ0kzSlBlTTNwYVJR?=
 =?utf-8?B?Smp1MVFBMUZxVmY5L0NCQTBOVTZyT3dzbWd0TUZWL1NnVjBSS1lBWjAycWQr?=
 =?utf-8?B?clJhNldVU2wxcVJoVmtZcDR1a214L1phNnN1WlVYMSsvbTRPbDBMRnV1RWZl?=
 =?utf-8?B?WVV0N0pxNnllOGUxdmFTSHNuV21nTWNWWm1Qc04wTmwxMVJsa2k2aW12UFFP?=
 =?utf-8?B?WE9mNUQzc2cxRklrREQxNUtvTXNta1BweVhCdFpqTkZYS2NDK1VwL3E5ODkx?=
 =?utf-8?B?ZDZMdzJkcEQrcFV2UjR4cnptVWUrV0JuWnErMGFPbm5pYlRmWXAxM0NUZ2Ni?=
 =?utf-8?B?RjRGMi9ycHZJNnZ1Vjc2MzFHM0xPbjZGWVJ5WUlDZUo0OU0zSHZuUVg3QUho?=
 =?utf-8?B?SHBWWVU3cGRXRzY1ZHB4cWFuU1BKc2NtNXJEbkdMbXMwdFI3aERERWtuUkZ6?=
 =?utf-8?B?NmNmSkthRmFMd3VBblR3SUlXUXZ1Qm4rd3N4ait2czhPQzZCM1JSS3p3SXp1?=
 =?utf-8?B?UHNxQlJpbDh2ZUFvYkF0S0pZblpiRHRHR2loZkFyaFEzV0h6QjJFRS9qOTJi?=
 =?utf-8?B?WGVNdmlrL0pvVG9HNEQ4Tzg2cTk2ankyODFoRjFtTm9hNW4rRXVocWhwYVg1?=
 =?utf-8?B?V0JPTUFMZWlaMk9NeWM1Y1BVenF3MlVQQ29KdFp4NTVEUmtMVjdEQzdDZnlY?=
 =?utf-8?B?cFovdmZLcVo5ZU13Y0MrODBLdUR2R00zbS96aEtFZ1gwdmR6SUVpMmEyZTVG?=
 =?utf-8?B?R0xPNVBwM0paSTBrZ2dzZ3FTTVVjSWFGSCtCeEFmT0RkdUFPc0N3YmVVb2Ja?=
 =?utf-8?B?MVl6SjhOODAxRlpGaVRoMG8wYWplZjFBUmxJNjVFM3ZxK1JydVlyWjl2c0FO?=
 =?utf-8?B?VVpFK2NOaDdEZFV5VHhwL2llYkd4ZDJNcTFrTGtZeHVNMTN0UUd4SFkvd2Np?=
 =?utf-8?B?SUlsZjJxQzQvMTd5cmtTdXFmZnE2L0U5Tm9hMVhBd3hYSXZFWFRCNDhLSGdU?=
 =?utf-8?B?MWtZTjNNanF0R0djWWl5V0xDY0FvSnNMZmVjckxtbHNjMDhBTWE2RStVTWV2?=
 =?utf-8?B?K1JzOFc0Q2M1UDNOMGYzQVd0dWMwRmJRNEY5aHdaRmdCVUdRZ0E4VTg1VjFs?=
 =?utf-8?B?N1dvOS9YVHlGRE5QbW80M0pYOHIyUUl1VnFZWStRM0kwbnpBU3VHVVVTQ1VX?=
 =?utf-8?B?Q0J3NkNLeTZNRjlCejhtb3hlaFBOR1gzNDU2Ny9xWWVmRFY5L3JnRE0yZHJP?=
 =?utf-8?B?NFVqNC9uTCtxaWZNckF2KzVlUy9vbGloMGdFOTQ4c0RvSFBGRFBiOXVHU3Vo?=
 =?utf-8?B?MjFXMi9mbjUrMG9haDMwV3BOVXpGZkVzUFdESW93TjN1MEE3U2o0WnhZQ3lE?=
 =?utf-8?B?ckFOUkRuYXowbTIvQjdyUmw1YkFpOGhxWWVSM2VRM2dYRG55WFdsRUV4U3JJ?=
 =?utf-8?B?NXg0djZnZ2w5Mi9BZy9iT1BQTTA2YWRhbGNYYmFqTGY0bXZFOTF2T1pSMTF1?=
 =?utf-8?B?WUxiaG9GWU9kNE1hczA5cVppenM4ckp3aExtZlVuT2VZSHRHNW9hWjZ1QlEv?=
 =?utf-8?B?SDhBTTRnQ2FwNU1CeHA0cFBvbUVobUVNVkxFR0kySjBNRCtvVlJMNlJUN2kx?=
 =?utf-8?B?cG9XWFNxVi81RTlmbHYvNVFiTzdBNVBKUms5d042MDJZSkUwU3l3dnVIQ2ls?=
 =?utf-8?B?NFhDRi9zS0JLajBLZEgrZ1ZYaEJTWm04Zzdrck8yTnE5ckRYOGVUbDI3WUY3?=
 =?utf-8?B?R0ZlcEJPenA1M2xpNjYyZVpJVjZOZ2liMzAxblZFK1JKenk2RHJxTDVuNVZ3?=
 =?utf-8?B?c3FyaTZEbkJGb0pOaXN5cnltc1NpZTBzNHJBREppelYra1o4WHB5OHU5WmQr?=
 =?utf-8?Q?DtdScc5rUb2aMjtANl5KD7L5U?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baf89ef7-e06a-4bf1-a0ab-08dbc697f0ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 18:13:28.2883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SWkF019aeUNL9ELTgkkkwLhdeCmb194QE/Uy7959Zggb0nHDacHECWtUq61lI69CURAv4SRI5WNptAxnpe1Lbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1473
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDA5LzE1XSBEcml2ZXJzOiBodjogSW50cm9kdWNlIGh2
X291dHB1dF9hcmdfZXhpc3RzIGluDQo+IGh2X2NvbW1vbi5jDQo+IA0KPiBPbiAxMC8yLzIwMjMg
MTI6MjkgUE0sIEFsZXggSW9uZXNjdSB3cm90ZToNCj4gPiBIaSBOdW5vLA0KPiA+DQo+ID4gSXMg
aXQgcG9zc2libGUgdG8gc2ltcGx5IGNoYW5nZSB0byBhbHdheXMgYWxsb2NhdGluZyB0aGUgb3V0
cHV0IHBhZ2U/DQo+ID4gRm9yIGV4YW1wbGUsIHRoZSBvdXRwdXQgcGFnZSBjb3VsZCBiZSBuZWVk
ZWQgaW4gc2NlbmFyaW9zIHdoZXJlIExpbnV4DQo+ID4gaXMgbm90IHJ1bm5pbmcgYXMgdGhlIHJv
b3QgcGFydGl0aW9uLCBzaW5jZSBjZXJ0YWluIGh5cGVyY2FsbHMgdGhhdCBhDQo+ID4gZ3Vlc3Qg
Y2FuIG1ha2Ugd2lsbCBzdGlsbCByZXF1aXJlIG9uZSAoSSByZWFsaXplIHRoYXQncyBub3QgdGhl
IGNhc2UNCj4gPiBfdG9kYXlfLCBidXQgSSBkb24ndCBiZWxpZXZlIHRoaXMgb3B0aW1pemF0aW9u
IGJ1eXMgbXVjaCkuDQo+IA0KPiBJIGFncmVlIC0gaXQgd291bGQgaW5kZWVkIHNpbXBsaWZ5IHRo
ZSBjb2RlLCBhbmQgZ3Vlc3RzIHdpbGwgcHJvYmFibHkgbWFrZSB1c2Ugb2YgaXQNCj4gc29vbmVy
IG9yIGxhdGVyLg0KPiANCj4gSGFwcHkgdG8gbWFrZSB0aGF0IGNoYW5nZSBpZiBIeXBlci1WIGd1
ZXN0IG1haW50YWluZXJzIGFncmVlLg0KPiBMb25nLCBEZXh1YW4sIE1pY2hhZWwsIHdoYXQgZG8g
eW91IHRoaW5rPw0KDQpUaGVyZSBpcyBubyB1c2UgY2FzZSBhcyBvZiB0b2RheSBmb3IgZ3Vlc3Qg
Vk1zLiBBbmQgaXQgYWxsb2NhdGVzIGV4dHJhIG1lbW9yeSB0aGF0IGFyZSBuZXZlciB1c2VkIHdo
ZW4gcnVubmluZyBhcyBndWVzdCBWTXMuDQoNCkkgc3VnZ2VzdCBrZWVwIHRoaXMgY29kZSB1bmNo
YW5nZWQgYXMgaXMuDQoNClRoYW5rcywNCkxvbmcNCg==
