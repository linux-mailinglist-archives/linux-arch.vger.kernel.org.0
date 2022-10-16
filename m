Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6D4600179
	for <lists+linux-arch@lfdr.de>; Sun, 16 Oct 2022 18:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiJPQyl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 16 Oct 2022 12:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJPQyj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 16 Oct 2022 12:54:39 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120054.outbound.protection.outlook.com [40.107.12.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56CDEE3B;
        Sun, 16 Oct 2022 09:54:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=An9hM7vUSHT6SJORGehTmcHHByWiX8xNWubQGYe2gGkJpNOgDTyVvmvlzMDicoEjCH+THxGJz3vNvWpivtKTPuB5ceDFi2bk0XtJPTMuk4al8ubqyfUIhoS91OToev2bcnBYjyWjJp2vKZVSnDbBnH2M5Ei8QRxPfHPX2PDscmIkIGxTBCV6OYpeG0Ka3btaUr7N1B3w7uX/Sb7UXiHDDn0uLZM2YeTTCYG1BB3Yj7jBDXgMVjh29rb1Re7Ff9VNYUT5tb+nnRHhA13mG/K2TlEWoaocfDBXJkJRPq8a3Mo02vCjwQOOHbJPq4p2ha0VI/b9kYBRjlyam1lHZn/NGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQcffNxPJqu5gKRvP0/QN+SItEFsQXxaLd/GdpP7AmU=;
 b=Xt5Cng5bDlOKS3ufvuP4BwCZmNbICX+0gjz1untWcYslxR/Zlmfx4fhtwQa2rPPRVYn3lfNyFX5Q54fCV9Y0EiY8ANrXVsvE+RZqmhcUeyZ1sTdUl4IXpmasogO33TzMZ/B4g0UkXsLlJP1SoSqkLYqxigoJ+hyEgWP8DH5+/Q2DUDjmFyHrPkZynIkWgpIin+Xl2+O5bdJ9IqLrlK6pHtJgqAIKHSIn5NCmtB4E3tDy2WUUwTnd6qV+cFjQJT63kYbVDMawJt9WS5GrRBbg/V4NbWxelSOrToacLSkYuxcMfOkLh15Q9e2V5kW++fy6HGcIZwVxxmQvCN3EtJeNVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQcffNxPJqu5gKRvP0/QN+SItEFsQXxaLd/GdpP7AmU=;
 b=a0tU2lwtiWW7k7ohHXGYbdqfoXVG5KzbuTbodfRSZa06UXryeC5ZeAE86RIlE6rUjjp6FcHi4HLvJMLDPih+zEogYRkklDKzrCi8GvS7SMGfru9Bi9SUAJP7GMpx/rJCOxF3cEgv/sbGtsYWSDiohg6ejaEvGR6et+u83/GnZbY96N5BywN7/se31VcgqivGt+JDlGfVGiVpD9dJOmT1zGjdiAeS2dmKE8ui7DbwnYsfsAmNDh8tOePchqhwiyKXQF9YCU3ibkkXZ1uNwB2DefuqxB8xBINb6JGDl72UuOo4krBuOoTA9sCoaojCociR3h+FIK7wkDySh6lgP/emLg==
Received: from MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3d::7) by
 PAZP264MB1430.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:121::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.32; Sun, 16 Oct 2022 16:54:33 +0000
Received: from MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c489:75f:98f4:b143]) by MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c489:75f:98f4:b143%6]) with mapi id 15.20.5723.032; Sun, 16 Oct 2022
 16:54:32 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
CC:     Baoquan He <bhe@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "schnelle@linux.ibm.com" <schnelle@linux.ibm.com>,
        "David.Laight@aculab.com" <David.Laight@aculab.com>,
        "shorne@gmail.com" <shorne@gmail.com>
Subject: Re: [RFC PATCH 3/8] mm/ioremap: Define generic_ioremap_prot() and
 generic_iounmap()
Thread-Topic: [RFC PATCH 3/8] mm/ioremap: Define generic_ioremap_prot() and
 generic_iounmap()
Thread-Index: AQHY3iLU/0uwwPHZeUK4FsonoODIqa4QsnKAgACRKIA=
Date:   Sun, 16 Oct 2022 16:54:32 +0000
Message-ID: <d00b3561-8f79-23a7-ac87-89766adf6513@csgroup.eu>
References: <cover.1665568707.git.christophe.leroy@csgroup.eu>
 <32dedfbe00c1da0114f66d6a43c56f4a16a85b64.1665568707.git.christophe.leroy@csgroup.eu>
 <Y0u9ec0Bi+FWtyA5@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
In-Reply-To: <Y0u9ec0Bi+FWtyA5@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MR1P264MB2980:EE_|PAZP264MB1430:EE_
x-ms-office365-filtering-correlation-id: 0d9adf66-d7ac-4315-9ca9-08daaf971985
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UsalWbmYmIZAepYng2MDRMWJy8JbZJ8XQjq0dliwSYE1a5zN4AK/yjgtN/+qQF3U7KftIaoFcQA098ayl/o+qtXCvANawxpNrD/VqfiR1T8Styyx58K2UUfGwOmCsTPZtOsRAZM5ZpuGPwvpIYQRYcAi+zNTdTa5GI1i3fVz5IJycX9gXNVlzypQrNDVbs2+T9gs04A2S6gif25NTHrFos+6bpnp9/q894CPVRjPS7mGTNqDlF9D8ZIidIhmHFTaH6AZ0y+ETB+nVPC7RdwI0YVjyw3hh06bSX6PCtIsnhMCw8Tc/Xgqk0GrB6sJaL0sjgG/KYm51WqRAI+56U6agtfunBLLKIc98frhWb0v1zovtukPA1tUZDAMgXDJl/AKdCorN/5NBdr5l+kC3+aqWeWH91coy3wcJ4SnOkaOPFm2W2rIgijIaemEnRQjfP3PndhrAt4vbLPZwVYThDH+JF0WaU6wJk7Fum5/xnWbkzKgKS+I3dzjUvMJBGQUgcq0qopxm4Xamutkb+dC82IYQhJiQWDPimjWI+yHSNJj0csDyN7kOdTp3YuMbfn6GtrVatlXcFMKqLzQNaJjAMW2K44HuC5cEXvfQvMVcEb72c61NnasYzRt/1kyO6uZienhjN47bX54v1BU+Ly29ttxVOMa0vvfbasTZ5YowxCpce9BMZ9ervJsxiyOG56L6Th00nLl0EsQhhrg44u7obnhM4odJ1OfmQDBT2Toium1qqQ14Z9Vr1bi72h57j5IejAACeoOVR5pgAU9dE5JuBvOL+Cd7l8oYGToFqGf8fPaiU78KfiSdCiENJCH7LtJx2t74ARYBjKEcjzIa6j72oq2c2MpwbSDg28lq5i+iyqidXw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39850400004)(376002)(346002)(396003)(136003)(451199015)(66574015)(38070700005)(36756003)(122000001)(86362001)(31696002)(38100700002)(83380400001)(91956017)(76116006)(66556008)(66476007)(64756008)(8676002)(66446008)(5660300002)(54906003)(316002)(6916009)(31686004)(66946007)(7416002)(44832011)(4326008)(186003)(71200400001)(6486002)(2906002)(8936002)(2616005)(6506007)(478600001)(6512007)(26005)(41300700001)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUFrNzJaellRRWI0Z0xBc1hvY2tMYkNMWHpkY0tiTE9WaFpTeXRoL3VMd0d1?=
 =?utf-8?B?RGtsK1Z2Z2lPdGRTamxrNXZ1MGlvSG5INjBlZEdFMjlHMkVSK2h3RGpkZG1h?=
 =?utf-8?B?YXhYRnRsTksrSDFiRGJuVVV1L0djQTgxQ1lkSHRML3VkOVNNNWhmQUQ2dmpK?=
 =?utf-8?B?dmZNWjNtS3IwaHBZSmErRE9pTXlsY0xhODlRMU9wN0U4ZUtqcThRcVJack4x?=
 =?utf-8?B?OHdzQWMrUzhoZzZmbVJmNk53dVRXRUh4S1ZGdGI3V3NCdmN5ZEpzdnQ4Mmg0?=
 =?utf-8?B?VmF4b0NuZkRvU2NsL2lhRjJBWUlQWWxrenc4L0lFcFJyTVl0NTFiN2swN1d2?=
 =?utf-8?B?aDRwTDR4Y1U3d3FaS2w4d3lBWHBJQzdGNUFzRjEvOXlwZjZxSERHa1FqaDJT?=
 =?utf-8?B?emNjbWlHNEhIMS9IcEVuakdpYXgwWU8vUWlHRTd6SkFwZ3EyQlNOeEJQR2d0?=
 =?utf-8?B?MUQ0TGJWZHRyMkRPVFBMdXRwcG9kQTVHeTAza1pha3hidU4vb3FBQWxKOHJt?=
 =?utf-8?B?emJIOEcrU1NEMU1HYmVsUkplTS8xOVB1RHpob2Q1MEpmc3Z1WitHamtoajJk?=
 =?utf-8?B?TW9SNnVad080WFZoNTJnL0ROdDlYdE5KZDZiVkRTa0J4ZmoxUUxoYkN5cTN3?=
 =?utf-8?B?ZTdadW5CZUJXUTBPbDJ3OFkyZmplNFFSUDR3RmU0WnYyMmFvQWVpcjhGY1ZK?=
 =?utf-8?B?UWVWY1dxcmN3VEI2TWdRRm5yQVkxSTRnUUFHS0NQZXdEOFVTY2ZXaXlCRmlo?=
 =?utf-8?B?RWJ4YmpMdDVkcjlYSzRuOUM5RWpaVTBHUG04TkVvcVpQUHJwWmswUVMxQnNV?=
 =?utf-8?B?YkE0dkpzWmVlMUx1U2RtWW01U2ViY2owTkF6WU9nUXpjeThETTF1WGpTUXlp?=
 =?utf-8?B?VHlGSUxmZ2xuSUxxQmd1Unc1Wlp3WXZEVStXWUNza0N5aUo4NEZTRzRhV3Yy?=
 =?utf-8?B?cHZkaE5waEN3ZjFGNjU4NzBycVNzVDk0Q2tEcFlDbjlRdTdFKy82YW13YzFC?=
 =?utf-8?B?eFQ4UGtlUDJNUy9Wb1YyUHVlei9UU1ZhVXljUDAyakN5TXRBUC9MSm5UdVk0?=
 =?utf-8?B?TzZlUkREdUZ3aUF2L0dnNHlrVVFacmJaMDdhNlI5Nk5uWE5JaXdzSmcxOURE?=
 =?utf-8?B?TURkM0Z5bko3ZTY4YWpheGdjdk9zeGxTUTFBbjdMRG5wbjVsK3VjcXZoY1Zt?=
 =?utf-8?B?aEJ0MGxRbC9iZ1d6RTNJbVdvN0J1eE5yS2NLYlRLalVQZ3VjSlk3ZUJmWmtZ?=
 =?utf-8?B?RXZ2ZE9zaWlpVDcyUHRBRlR3Yk9pKzV1S3BGeW9Xd1RwbUlqcW1YNkJocnBM?=
 =?utf-8?B?QmU1M3c0cGZ1a3pjUHRoUllpKzVVdWxreG1uMUxvUnp6amh2SlRtSFhMVGFn?=
 =?utf-8?B?QmM4NXFMdm9iQ1ZiaEFQV0JDRGc2MUt3U0NIOURpNm9mdjA1UGpocnBYcmRz?=
 =?utf-8?B?ZEs5SkdLcDlIM2h4TzBsRFVwQmVCWjhhLzlOUnJyZ2ZmcW0wWXJIZGJXQ04x?=
 =?utf-8?B?dFRWblRPRHdxM3ZLNk44NGIrL25KSjRZanZQUENKQUlDdVp2cjQyNWpBT00w?=
 =?utf-8?B?bHhsWUFDSFpGeCtSRmgvOTFWNkprcHdUWmRiNmtZcVlRUTZLd3BaYnJLbjIw?=
 =?utf-8?B?VkJRMkUvYkxXNWsvakhCMysyNmNwalpuMlV5S01iczJOQWwxVTRYU0h4UnNk?=
 =?utf-8?B?Y0hBelVGM0c2eUczVU1aZms1REhIUEZ6QUU2bFdRQlYzdEpPVnY3WlcwQ0Vk?=
 =?utf-8?B?UVVCb1R0TURCUWM2MzVtU01mKzdGbnNMakdBbUR3Qi93VlAzbzRlWEJySVhB?=
 =?utf-8?B?WmM2NnJPMDNwSlZDdGk4cXBKR3FFWnc3ekVYUjlNdkNEQVZMRXlldXpNQnM0?=
 =?utf-8?B?N242RmsxVHVVR1IxWkFCWm5pb2FSTDd4NmNnRmM3b1RjRkUvNjdRY29EbkpG?=
 =?utf-8?B?c1ZoTlVhRkw2YUp0enNac1NGSmFqU2QwWXM3Yk54Y0QrS3pDSzJ2Y0pXZnND?=
 =?utf-8?B?RU0xR3E3VUVtUjZVdFhsT1dlTGVzMmJnUUh6aSs0L25oZUh5R09wM1dBcmFN?=
 =?utf-8?B?WEFDZ0J5T2RCYUVHVzhGR3liVVdLSkhVcFpnczZXMHlKMGY4eHVwUldUWHpY?=
 =?utf-8?B?TWhFK0tTaVJUWkxyU2U1VlNQa0puSkxib0V3bU1qOEdpcmxscHJxN2JlWWVT?=
 =?utf-8?Q?OhsY0cVf9UPM4q+ertdl/ko=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AE706DEE82663429705589D9E096A50@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9adf66-d7ac-4315-9ca9-08daaf971985
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2022 16:54:32.8987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fqkZExvYES8rzJBHzZt+4EfljkFV/T7S1PBsCxfOONZ1IK+ndpxILBHdqhRmk2OFrbHKkhfiNZ9KQeQ7qumRgtkIpOeAjhfSa7YDCH8x1lE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB1430
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDE2LzEwLzIwMjIgw6AgMTA6MTQsIEFsZXhhbmRlciBHb3JkZWV2IGEgw6ljcml0wqA6
DQo+IE9uIFdlZCwgT2N0IDEyLCAyMDIyIGF0IDEyOjA5OjM5UE0gKzAyMDAsIENocmlzdG9waGUg
TGVyb3kgd3JvdGU6DQo+PiBEZWZpbmUgYSBnZW5lcmljIHZlcnNpb24gb2YgaW9yZW1hcF9wcm90
KCkgYW5kIGlvdW5tYXAoKSB0aGF0DQo+PiBhcmNoaXRlY3R1cmVzIGNhbiBjYWxsIGFmdGVyIHRo
ZXkgaGF2ZSBwZXJmb3JtZWQgdGhlIG5lY2Vzc2FyeQ0KPj4gYWx0ZXJhdGlvbiB0byBwYXJhbWV0
ZXJzIGFuZC9vciBuZWNlc3NhcnkgdmVyaWZpY2F0aW9ucy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBDaHJpc3RvcGhlIExlcm95IDxjaHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+DQo+IA0KPiBb
Li4uXQ0KPiANCj4+IGRpZmYgLS1naXQgYS9tbS9pb3JlbWFwLmMgYi9tbS9pb3JlbWFwLmMNCj4+
IGluZGV4IDg2NTI0MjYyODJjYy4uOWYzNGE4ZjkwYjU4IDEwMDY0NA0KPj4gLS0tIGEvbW0vaW9y
ZW1hcC5jDQo+PiArKysgYi9tbS9pb3JlbWFwLmMNCj4+IEBAIC0xMSw4ICsxMSw4IEBADQo+PiAg
ICNpbmNsdWRlIDxsaW51eC9pby5oPg0KPj4gICAjaW5jbHVkZSA8bGludXgvZXhwb3J0Lmg+DQo+
PiAgIA0KPj4gLXZvaWQgX19pb21lbSAqaW9yZW1hcF9wcm90KHBoeXNfYWRkcl90IHBoeXNfYWRk
ciwgc2l6ZV90IHNpemUsDQo+PiAtCQkJICAgdW5zaWduZWQgbG9uZyBwcm90KQ0KPj4gK3ZvaWQg
X19pb21lbSAqZ2VuZXJpY19pb3JlbWFwX3Byb3QocGh5c19hZGRyX3QgcGh5c19hZGRyLCBzaXpl
X3Qgc2l6ZSwNCj4+ICsJCQkJICAgcGdwcm90X3QgcHJvdCkNCj4+ICAgew0KPj4gICAJdW5zaWdu
ZWQgbG9uZyBvZmZzZXQsIHZhZGRyOw0KPj4gICAJcGh5c19hZGRyX3QgbGFzdF9hZGRyOw0KPj4g
QEAgLTI4LDcgKzI4LDcgQEAgdm9pZCBfX2lvbWVtICppb3JlbWFwX3Byb3QocGh5c19hZGRyX3Qg
cGh5c19hZGRyLCBzaXplX3Qgc2l6ZSwNCj4+ICAgCXBoeXNfYWRkciAtPSBvZmZzZXQ7DQo+PiAg
IAlzaXplID0gUEFHRV9BTElHTihzaXplICsgb2Zmc2V0KTsNCj4+ICAgDQo+PiAtCWlmICghaW9y
ZW1hcF9hbGxvd2VkKHBoeXNfYWRkciwgc2l6ZSwgcHJvdCkpDQo+PiArCWlmICghaW9yZW1hcF9h
bGxvd2VkKHBoeXNfYWRkciwgc2l6ZSwgcGdwcm90X3ZhbChwcm90KSkpDQo+PiAgIAkJcmV0dXJu
IE5VTEw7DQo+IA0KPiBJdCBzZWVtcyB0byBtZSBpb3JlbWFwX2FsbG93ZWQoKSBpcyBub3QgbmVl
ZGVkIGFueW1vcmUuDQo+IFdoYXRldmVyIGlzIGNoZWNrZWQgaGVyZSB3b3VsZCBtb3ZlIHRvIGFy
Y2hpdGVjdHVyZS0NCj4gc3BlY2lmaWMgaW1wbGVtZW50YXRpb24uDQoNClllcyBjYW4gcHJvYmFi
bHkgYmUgcmVtb3ZlZCBhcyBhIGZvbGxvdy11cC4gSSBkaWRuJ3Qgd2FudCB0byBjaGFuZ2UgDQpl
eGlzdGluZyBpbXBsZW1lbnRhdGlvbnMgYXQgdGhlIGZpcnN0IHBsYWNlLCBhbmQgc2VlIHdoYXQg
aXQgbG9va3MgbGlrZSANCm9uY2UgYWxsIGFyY2hpdGVjdHVyZXMgaGF2ZSBiZWVuIGxvb2tlZCBh
dC4NCg0KPiANCj4+ICAgCWFyZWEgPSBnZXRfdm1fYXJlYV9jYWxsZXIoc2l6ZSwgVk1fSU9SRU1B
UCwNCj4+IEBAIC0zOCwxNyArMzgsMjQgQEAgdm9pZCBfX2lvbWVtICppb3JlbWFwX3Byb3QocGh5
c19hZGRyX3QgcGh5c19hZGRyLCBzaXplX3Qgc2l6ZSwNCj4+ICAgCXZhZGRyID0gKHVuc2lnbmVk
IGxvbmcpYXJlYS0+YWRkcjsNCj4+ICAgCWFyZWEtPnBoeXNfYWRkciA9IHBoeXNfYWRkcjsNCj4+
ICAgDQo+PiAtCWlmIChpb3JlbWFwX3BhZ2VfcmFuZ2UodmFkZHIsIHZhZGRyICsgc2l6ZSwgcGh5
c19hZGRyLA0KPj4gLQkJCSAgICAgICBfX3BncHJvdChwcm90KSkpIHsNCj4+ICsJaWYgKGlvcmVt
YXBfcGFnZV9yYW5nZSh2YWRkciwgdmFkZHIgKyBzaXplLCBwaHlzX2FkZHIsIHByb3QpKSB7DQo+
PiAgIAkJZnJlZV92bV9hcmVhKGFyZWEpOw0KPj4gICAJCXJldHVybiBOVUxMOw0KPj4gICAJfQ0K
Pj4gICANCj4+ICAgCXJldHVybiAodm9pZCBfX2lvbWVtICopKHZhZGRyICsgb2Zmc2V0KTsNCj4+
ICAgfQ0KPj4gKw0KPj4gKyNpZm5kZWYgaW9yZW1hcF9wcm90DQo+IA0KPiBJIGd1ZXNzLCB0aGlz
IGlzIGFsc28gbmVlZGVkOg0KPiANCj4gI2RlZmluZSBpb3JlbWFwX3Byb3QgaW9yZW1hcF9wcm90
DQoNCldoeSB3b3VsZCBpdCBuZWVkIHRoYXQgPyBXZSBhcmUgaW4gaW9yZW1hcC5jLCBhbnkgZGVm
aW5lIGRvbmUgaGVyZSBpcyANCmV4Y2x1c2l2ZWx5IHNlZW4gaGVyZSBpbiB0aGlzIEMgZmlsZS4g
SXQncyBub3QgbGlrZSBhIGhlYWRlciBmaWxlLg0KDQo+IA0KPj4gK3ZvaWQgX19pb21lbSAqaW9y
ZW1hcF9wcm90KHBoeXNfYWRkcl90IHBoeXNfYWRkciwgc2l6ZV90IHNpemUsDQo+PiArCQkJICAg
dW5zaWduZWQgbG9uZyBwcm90KQ0KPj4gK3sNCj4+ICsJcmV0dXJuIGdlbmVyaWNfaW9yZW1hcF9w
cm90KHBoeXNfYWRkciwgc2l6ZSwgX19wZ3Byb3QocHJvdCkpOw0KPj4gK30NCj4+ICAgRVhQT1JU
X1NZTUJPTChpb3JlbWFwX3Byb3QpOw0KPj4gKyNlbmRpZg0KPj4gICANCj4+IC12b2lkIGlvdW5t
YXAodm9sYXRpbGUgdm9pZCBfX2lvbWVtICphZGRyKQ0KPj4gK3ZvaWQgZ2VuZXJpY19pb3VubWFw
KHZvbGF0aWxlIHZvaWQgX19pb21lbSAqYWRkcikNCj4+ICAgew0KPj4gICAJdm9pZCAqdmFkZHIg
PSAodm9pZCAqKSgodW5zaWduZWQgbG9uZylhZGRyICYgUEFHRV9NQVNLKTsNCj4+ICAgDQo+PiBA
QCAtNTgsNCArNjUsMTEgQEAgdm9pZCBpb3VubWFwKHZvbGF0aWxlIHZvaWQgX19pb21lbSAqYWRk
cikNCj4+ICAgCWlmIChpc192bWFsbG9jX2FkZHIodmFkZHIpKQ0KPj4gICAJCXZ1bm1hcCh2YWRk
cik7DQo+PiAgIH0NCj4+ICsNCj4+ICsjaWZuZGVmIGlvdW5tYXANCj4gDQo+IFNhbWUgaGVyZS4N
Cg0KU2FtZSwgSSBkb24ndCBzZWUgd2hhdCBpdCB3b3VsZCBhZGQuDQoNCj4gDQo+PiArdm9pZCBp
b3VubWFwKHZvbGF0aWxlIHZvaWQgX19pb21lbSAqYWRkcikNCj4+ICt7DQo+PiArCWdlbmVyaWNf
aW91bm1hcChhZGRyKTsNCj4+ICt9DQo+PiAgIEVYUE9SVF9TWU1CT0woaW91bm1hcCk7DQo+PiAr
I2VuZGlm
