Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFD54FE11A
	for <lists+linux-arch@lfdr.de>; Tue, 12 Apr 2022 14:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354082AbiDLMyh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Apr 2022 08:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355279AbiDLMx4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Apr 2022 08:53:56 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90072.outbound.protection.outlook.com [40.107.9.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2704412C;
        Tue, 12 Apr 2022 05:27:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MeWZ8o1BGfq+dB3awbgJ6HAHxre+KTJfkz75lWFkJaECHhCpEjNxvK4JkUwtnJn0BQkeWACMaC/eLixDtrrCNBSYKZuTCz7y7pUGGgmzMOvrCs2VeUIaYQW7/dg6cSlZ6DbUWoa0rcg7FU/fEX06gvIHOQuA/rz9RPzZbpdJJZ+xdXYXwwugiZTFZQWSIW+4U1tAOry4HQrfxVk9aRRDOAEwWziefUGXuzSN/tAdVfKZm7eaMvDTlTLKboZvijN5moUxZf59MdvVIFfDd8yqosh3V8p5oEMvoNVsiy+cfhftCn/dFSTeIuhKAV45n7fQHZb0jP5IxHiMDa7iDBrJWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjxN+/vng4TgrZxWY3Vz8IAuDBSs8C3XewBwD1zXZ8o=;
 b=PyS8VP26GmzHbA0mev3+QppTo908z6J8ebCRiOZ+6IugIAjtoiyqaceVeChTmSCGb0IQFXHLBic2dIBX7WOVRfswx3N/oektabF96R1saenlKwPDQHzUq9Z4pmLk+Uu+Gtjx9pAjmUGLZSiVcU0Ow349L4xK0Fv8V8yMGuYdk3+9ZsyyJyU3gGUIW7uDOrVdjxzlk8jXZtuKoUC0jYfiM7+2jTSUh98sV0iKFlqqg4xsszXGNCTWeWWgAc1+2i8zUeNnlqf2u4isEHKh1dmBPnun/5Lzhd7zYB3LkFZvtRKgNmo9W6Jh6R8U4KrxBe/1LMjYVr/y3vFw2LW/BSpi+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB4119.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:253::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 12:27:14 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::59c:ae33:63c1:cb1c]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::59c:ae33:63c1:cb1c%9]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 12:27:14 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH V5 2/7] powerpc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Thread-Topic: [PATCH V5 2/7] powerpc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Thread-Index: AQHYTicsKibLt7jeGkKZUI22gkpYnKzsNPWA
Date:   Tue, 12 Apr 2022 12:27:14 +0000
Message-ID: <bc1a9e40-7625-3d22-e72e-9100aca1a523@csgroup.eu>
References: <20220412043848.80464-1-anshuman.khandual@arm.com>
 <20220412043848.80464-3-anshuman.khandual@arm.com>
In-Reply-To: <20220412043848.80464-3-anshuman.khandual@arm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5bc4e18-47e1-4727-2d74-08da1c7fc673
x-ms-traffictypediagnostic: PR1P264MB4119:EE_
x-microsoft-antispam-prvs: <PR1P264MB4119BAB9972B6DAD431B537EEDED9@PR1P264MB4119.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u+ywrolnm818khe8bp8I6zoP+xBmr0fMiVlodyMhHgX8cTe/H+nTxmhTFi+wvKHI5QL1cmcCFB63+9PEsiok5lbGIpJ0DZ2pd3EINDNYZsCD5l0QiUqejcogvTDCXgoV7UpSnlBXfXsBtlx/BJEXxDtxSgQZZauN0jlRp2BACYGTEe8QGmVzmq7f7ME2tYaIgufS7FtLk9JkGsCJ3vk+kJ2DWAchQwYZXKUMqc3E80BFiywWaeHAMe8h02EKJnjMU3j+9jf3IDF729v5Anma9PQv0SdwgPw0usmIKjC6UCVIGlYAt/1vJtpVztC37lmfWDkcRCGeKufdghyY378Gd8bm+9MXfHCsrajjw0l8rSt2AiIhSZRi3I/WtAxr/5wgD78r9PIabUjg3lkBQA3kRuuEWuUFa/e8U22QbN06q6sijaS3jM0i35e19CPnfLgLskNeDyD5EtZx3Y9JRM90xWuNjIp19b22/KZXq7k165NLWbzVxInuXm5UiDVCR/qExbvOcoSiqmn3D6xmydm7rScqIUQBDWVc1UvQzIWIiuVCEBjq/1PNtI6qJZC9gXxUHGX6lLRUQVmNFeFSKge7vE41RFEo6tb92BG7boef0kCHDPquvEs0PRoQ6clVD6dZqEp76/5PIOqHZx3SuqF69ry9wVJKCkGpS7jCmK0yqzxypPhUkKhYu0LzrihqCqPIte1+IokwT605VnOdwbDZdbcPFFQUkxycHDlVr0heTgANEeF9pzxp58VKST9dsXJSqI0qtVLx2tf+Epa0KhGeHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(44832011)(508600001)(8936002)(5660300002)(76116006)(110136005)(31686004)(31696002)(4326008)(2906002)(66446008)(6486002)(36756003)(66476007)(66556008)(8676002)(66946007)(91956017)(64756008)(54906003)(316002)(38100700002)(71200400001)(86362001)(122000001)(83380400001)(6512007)(6506007)(7416002)(66574015)(186003)(2616005)(38070700005)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0lDTmlxZFpZczlZd0lWQW9yM2g2ZEJsU1BERGNEN0x2dVVCcDJQNVFZOHpT?=
 =?utf-8?B?SkRrS1lvUk1EZlRpaFFZanMrWGNVUmF5V3liU0EyYy9JeXN6eHN1QzZpOHBY?=
 =?utf-8?B?dWZENzJPeExtS0g1VlNydERSVHhnZ21rS0RZTjNxY1RVSGFyMDlGeWdlK1k4?=
 =?utf-8?B?aVpJdmJMTVdja1RtSUNUNDlqdGFIQWw5bnAvdGFLcDNCWG82Y0dXTkE5cVFT?=
 =?utf-8?B?Ukc5bWt6WDhuUGhabFB0Z3ZQRWFJYVRwd0s3eVV1blBtTU4yR2I3RjJ6dFdI?=
 =?utf-8?B?VHVRdFhablQ1K0RHY2RjWEhMOWkzVHE5azFaOVlUcEEyZlBleHc4d2lZd25N?=
 =?utf-8?B?MmpJc0NyY3k4TWFaT1NhYTc2NnVJbWpqTGw2MVpkeDJRZTRtdko2bHdma0F6?=
 =?utf-8?B?eDZOSHk0RXF5elJjaHMwQ0VLUnFMbjdYTm1GUGtjSHR6Lzh0R3pkelJBOWtB?=
 =?utf-8?B?YXBOSVV5N2psODR1b3Rkb1YzRU9ZOG9xdDVOaHpwN1Y0eVo4TVZjeGxmbUR4?=
 =?utf-8?B?RWROQ1p1RXRLbk84d0dkZkNZK2tpcjFYc1QvOHN5UzJjdkVjRUVING9SZ2pw?=
 =?utf-8?B?MG5ySURyd3RGSUtzSkJZK051eE9RUGJCQXlSQ3R0VVc0VE5yVERlV0JXQ2JH?=
 =?utf-8?B?YkFtUEF0cnowckxISlFRUkVrSms2dEFGUHNmLzJHYzFYVmRlUmExTStKMmtF?=
 =?utf-8?B?a1RjU0NSK0VMeXVCTEJZZjJUdE9xVUlXaC82d3ROZmdlOUp4ckI2VVBLbHJC?=
 =?utf-8?B?N0pTWGw0Y2RDOUdmdEdZT2pzcVMrZzVWOTJWeVlmdlNMUVppekh2K3VQZmlw?=
 =?utf-8?B?OHBublZrVzlYdmZRdHF1dTlaR1ZheGJPRFlnWUtrTU05WnhSNmFFMlNYMGpY?=
 =?utf-8?B?KzNVY24zK3ZHZnl2a2w4TFVROEo1Qytta2VWMUJyaFcrMnBVYnJhVDVqNnJS?=
 =?utf-8?B?YkRyRER5TkhUZlRIMG5BT2JrR1pEL1FTc01BRWVMaUQ5emErbnY3enc1TFJq?=
 =?utf-8?B?SFkvNklvTS9vcFFHcGU4Z1NLbDNjRzk1NThXTTRHc1ppelhuOXJNVDQ1Yk1J?=
 =?utf-8?B?OGhnQnQrdHhWSUd5eHNIQ1NpWHJjSXVPbEJscGpxQ0hLU1dTcHlLN2dyVXhT?=
 =?utf-8?B?RTlWKzFESVZBdmhqcFcyb2IrZWpzYjRUTnUzTXo2WlliNU91MG1kQUhaOWw3?=
 =?utf-8?B?MHF3MURIM3hyRUs2ZTZ3bjhvUFNPaWFwelV1YllNRW1xUWtZOTNVUGd3N2xa?=
 =?utf-8?B?RCtRSGl1cjNtMjN6Vi8rUlJ2ZlJJbVVRUlFHQVQweUJzOE5sNHdkMkE4elM0?=
 =?utf-8?B?VDlxVlo2UWxtOGdEc2xjd0d2cWlkZGFNQTYrQzRvbklXdGRLdlZuZ09PZjRD?=
 =?utf-8?B?Ry8vS01LT3JyeGtTRFBzUDhHTnhyblhPZ2YvUzdiUnNVeVFyN0VGSU1PVzRX?=
 =?utf-8?B?V1dpcGl4WXJlTDZDTjBCSnF4NjllTG1IK3czWis1a1RDZ3NlazJyZnFJdUVI?=
 =?utf-8?B?V2tpZkUwZEJEZFlHZTgxZjhFenBJMmlFS2pVdkxkaGRJcEpqM3FMNlNzQ0FL?=
 =?utf-8?B?Y1ptUER4Mm5jamlqYjFTTmd5YVI3YUFBTmZERGFTK2FweEFaSHRubGZaUm5D?=
 =?utf-8?B?UXhnWHE0YVl1UnZvTU54MmJZOVhxUmRzaXBqYXJ2TE5HVXAwUGVlNnJieWhl?=
 =?utf-8?B?ODZCMjZPZjBEb29PWHM3QmVFaTNhb2FKRWhxb0lxZWZRY0FsamtKVWtYVkN4?=
 =?utf-8?B?eEN4V3BoeFR0dlZvSEVTKzdYY2hEdnNCUmxncEFaeDEreWowZW1oME5Ec1VF?=
 =?utf-8?B?a2hmdUUzQXE2dUhwb2lPMWdnUHVPdG5pTnBxUGRGbHdJbldVdGJidS9RaW9E?=
 =?utf-8?B?UmlVWExrODlBQ2xyNitGd05LQWhmRVE2QnZrYWpBNnpjNGFoZmhQa3ZadFBI?=
 =?utf-8?B?VDN3Mk9OS2QyRnRtcE1aZnl0c1ZIdE0rSFgvdURwc0RPK0Q5bWxnVzBDanR4?=
 =?utf-8?B?aWg4WUFyV2Zpc05ucDBROUxOdEo0UXZOaHAyOEZBTCtVUlk0bjQ1Y3drUE1B?=
 =?utf-8?B?N2o1eWtISDVBNk9vaElEM1ZtNERSRzluUU8zYXVzVmNuOXRzQjlFenpwcjY5?=
 =?utf-8?B?bTZQbjVXUGNsdFB6MEVyZVY0RUpTWExiM3FySkRvUThzN1ZxZ0wrWTNnSzlT?=
 =?utf-8?B?RDQyWUdaQVRCdHY4WFJ6elo0a29EMlJMUEJhUGRjaEJiMUJvbnZqaThxWW5X?=
 =?utf-8?B?anhqYm00V0o4Rnd2d3ZLNkRldWpNaEdVaFpRWGtwOE9QdHc1V2pzdU5idk45?=
 =?utf-8?B?ME5wMUFEdy9hNlA0QzlkVmpLa1BSbjUrM0RFN0l3RGNqRVVGb3VKRnVkZzNL?=
 =?utf-8?Q?yHPUvXiQT7XV/AVy26GnDeDZmODR7mIaVimb0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0A5E1DC3D64C84F948138B588B64B14@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f5bc4e18-47e1-4727-2d74-08da1c7fc673
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 12:27:14.1426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zcYsTxFe+myNZeMROChU3rdyS/eTq/EAuZAFJY/jKMCn4gdYm0RMOQ1AZOOBx3ocA19MlifHAvMGSgn6G23El5lzeYd0ABFzfssD3bEcKrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB4119
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDEyLzA0LzIwMjIgw6AgMDY6MzgsIEFuc2h1bWFuIEtoYW5kdWFsIGEgw6ljcml0wqA6
DQo+IFRoaXMgZGVmaW5lcyBhbmQgZXhwb3J0cyBhIHBsYXRmb3JtIHNwZWNpZmljIGN1c3RvbSB2
bV9nZXRfcGFnZV9wcm90KCkgdmlhDQo+IHN1YnNjcmliaW5nIEFSQ0hfSEFTX1ZNX0dFVF9QQUdF
X1BST1QuIFdoaWxlIGhlcmUsIHRoaXMgYWxzbyBsb2NhbGl6ZXMNCj4gYXJjaF92bV9nZXRfcGFn
ZV9wcm90KCkgYXMgX192bV9nZXRfcGFnZV9wcm90KCkgYW5kIG1vdmVzIGl0IG5lYXINCj4gdm1f
Z2V0X3BhZ2VfcHJvdCgpLg0KPiANCj4gQ2M6IE1pY2hhZWwgRWxsZXJtYW4gPG1wZUBlbGxlcm1h
bi5pZC5hdT4NCj4gQ2M6IFBhdWwgTWFja2VycmFzIDxwYXVsdXNAc2FtYmEub3JnPg0KPiBDYzog
bGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogQW5zaHVtYW4gS2hhbmR1YWwgPGFuc2h1bWFuLmto
YW5kdWFsQGFybS5jb20+DQo+IC0tLQ0KPiAgIGFyY2gvcG93ZXJwYy9LY29uZmlnICAgICAgICAg
ICAgICAgfCAgMSArDQo+ICAgYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL21tYW4uaCAgICB8IDEy
IC0tLS0tLS0tLS0tLQ0KPiAgIGFyY2gvcG93ZXJwYy9tbS9ib29rM3M2NC9wZ3RhYmxlLmMgfCAy
MCArKysrKysrKysrKysrKysrKysrKw0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9u
cygrKSwgMTIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL0tj
b25maWcgYi9hcmNoL3Bvd2VycGMvS2NvbmZpZw0KPiBpbmRleCAxNzRlZGFiYjc0ZmEuLjY5ZTQ0
MzU4YTIzNSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9wb3dlcnBjL0tjb25maWcNCj4gKysrIGIvYXJj
aC9wb3dlcnBjL0tjb25maWcNCj4gQEAgLTE0MCw2ICsxNDAsNyBAQCBjb25maWcgUFBDDQo+ICAg
CXNlbGVjdCBBUkNIX0hBU19USUNLX0JST0FEQ0FTVAkJaWYgR0VORVJJQ19DTE9DS0VWRU5UU19C
Uk9BRENBU1QNCj4gICAJc2VsZWN0IEFSQ0hfSEFTX1VBQ0NFU1NfRkxVU0hDQUNIRQ0KPiAgIAlz
ZWxlY3QgQVJDSF9IQVNfVUJTQU5fU0FOSVRJWkVfQUxMDQo+ICsJc2VsZWN0IEFSQ0hfSEFTX1ZN
X0dFVF9QQUdFX1BST1QJaWYgUFBDX0JPT0szU182NA0KPiAgIAlzZWxlY3QgQVJDSF9IQVZFX05N
SV9TQUZFX0NNUFhDSEcNCj4gICAJc2VsZWN0IEFSQ0hfS0VFUF9NRU1CTE9DSw0KPiAgIAlzZWxl
Y3QgQVJDSF9NSUdIVF9IQVZFX1BDX1BBUlBPUlQNCj4gZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJw
Yy9pbmNsdWRlL2FzbS9tbWFuLmggYi9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vbW1hbi5oDQo+
IGluZGV4IDdjYjZkMThmNWNkNi4uMWIwMjRlNjRjOGVjIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Bv
d2VycGMvaW5jbHVkZS9hc20vbW1hbi5oDQo+ICsrKyBiL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2Fz
bS9tbWFuLmgNCj4gQEAgLTI0LDE4ICsyNCw2IEBAIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9u
ZyBhcmNoX2NhbGNfdm1fcHJvdF9iaXRzKHVuc2lnbmVkIGxvbmcgcHJvdCwNCj4gICB9DQo+ICAg
I2RlZmluZSBhcmNoX2NhbGNfdm1fcHJvdF9iaXRzKHByb3QsIHBrZXkpIGFyY2hfY2FsY192bV9w
cm90X2JpdHMocHJvdCwgcGtleSkNCj4gICANCj4gLXN0YXRpYyBpbmxpbmUgcGdwcm90X3QgYXJj
aF92bV9nZXRfcGFnZV9wcm90KHVuc2lnbmVkIGxvbmcgdm1fZmxhZ3MpDQo+IC17DQo+IC0jaWZk
ZWYgQ09ORklHX1BQQ19NRU1fS0VZUw0KPiAtCXJldHVybiAodm1fZmxhZ3MgJiBWTV9TQU8pID8N
Cj4gLQkJX19wZ3Byb3QoX1BBR0VfU0FPIHwgdm1mbGFnX3RvX3B0ZV9wa2V5X2JpdHModm1fZmxh
Z3MpKSA6DQo+IC0JCV9fcGdwcm90KDAgfCB2bWZsYWdfdG9fcHRlX3BrZXlfYml0cyh2bV9mbGFn
cykpOw0KPiAtI2Vsc2UNCj4gLQlyZXR1cm4gKHZtX2ZsYWdzICYgVk1fU0FPKSA/IF9fcGdwcm90
KF9QQUdFX1NBTykgOiBfX3BncHJvdCgwKTsNCj4gLSNlbmRpZg0KPiAtfQ0KPiAtI2RlZmluZSBh
cmNoX3ZtX2dldF9wYWdlX3Byb3Qodm1fZmxhZ3MpIGFyY2hfdm1fZ2V0X3BhZ2VfcHJvdCh2bV9m
bGFncykNCj4gLQ0KPiAgIHN0YXRpYyBpbmxpbmUgYm9vbCBhcmNoX3ZhbGlkYXRlX3Byb3QodW5z
aWduZWQgbG9uZyBwcm90LCB1bnNpZ25lZCBsb25nIGFkZHIpDQo+ICAgew0KPiAgIAlpZiAocHJv
dCAmIH4oUFJPVF9SRUFEIHwgUFJPVF9XUklURSB8IFBST1RfRVhFQyB8IFBST1RfU0VNIHwgUFJP
VF9TQU8pKQ0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL21tL2Jvb2szczY0L3BndGFibGUu
YyBiL2FyY2gvcG93ZXJwYy9tbS9ib29rM3M2NC9wZ3RhYmxlLmMNCj4gaW5kZXggMDUyZTY1OTBm
ODRmLi5kMDMxOTUyNGUyN2YgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcG93ZXJwYy9tbS9ib29rM3M2
NC9wZ3RhYmxlLmMNCj4gKysrIGIvYXJjaC9wb3dlcnBjL21tL2Jvb2szczY0L3BndGFibGUuYw0K
PiBAQCAtNyw2ICs3LDcgQEANCj4gICAjaW5jbHVkZSA8bGludXgvbW1fdHlwZXMuaD4NCj4gICAj
aW5jbHVkZSA8bGludXgvbWVtYmxvY2suaD4NCj4gICAjaW5jbHVkZSA8bGludXgvbWVtcmVtYXAu
aD4NCj4gKyNpbmNsdWRlIDxsaW51eC9wa2V5cy5oPg0KPiAgICNpbmNsdWRlIDxsaW51eC9kZWJ1
Z2ZzLmg+DQo+ICAgI2luY2x1ZGUgPG1pc2MvY3hsLWJhc2UuaD4NCj4gICANCj4gQEAgLTU0OSwz
ICs1NTAsMjIgQEAgdW5zaWduZWQgbG9uZyBtZW1yZW1hcF9jb21wYXRfYWxpZ24odm9pZCkNCj4g
ICB9DQo+ICAgRVhQT1JUX1NZTUJPTF9HUEwobWVtcmVtYXBfY29tcGF0X2FsaWduKTsNCj4gICAj
ZW5kaWYNCj4gKw0KPiArc3RhdGljIHBncHJvdF90IF9fdm1fZ2V0X3BhZ2VfcHJvdCh1bnNpZ25l
ZCBsb25nIHZtX2ZsYWdzKQ0KPiArew0KPiArI2lmZGVmIENPTkZJR19QUENfTUVNX0tFWVMNCj4g
KwlyZXR1cm4gKHZtX2ZsYWdzICYgVk1fU0FPKSA/DQo+ICsJCV9fcGdwcm90KF9QQUdFX1NBTyB8
IHZtZmxhZ190b19wdGVfcGtleV9iaXRzKHZtX2ZsYWdzKSkgOg0KPiArCQlfX3BncHJvdCgwIHwg
dm1mbGFnX3RvX3B0ZV9wa2V5X2JpdHModm1fZmxhZ3MpKTsNCj4gKyNlbHNlDQo+ICsJcmV0dXJu
ICh2bV9mbGFncyAmIFZNX1NBTykgPyBfX3BncHJvdChfUEFHRV9TQU8pIDogX19wZ3Byb3QoMCk7
DQo+ICsjZW5kaWYNCj4gK30NCj4gKw0KPiArcGdwcm90X3Qgdm1fZ2V0X3BhZ2VfcHJvdCh1bnNp
Z25lZCBsb25nIHZtX2ZsYWdzKQ0KPiArew0KPiArCXJldHVybiBfX3BncHJvdChwZ3Byb3RfdmFs
KHByb3RlY3Rpb25fbWFwW3ZtX2ZsYWdzICYNCj4gKwkJCShWTV9SRUFEfFZNX1dSSVRFfFZNX0VY
RUN8Vk1fU0hBUkVEKV0pIHwNCj4gKwkJCXBncHJvdF92YWwoX192bV9nZXRfcGFnZV9wcm90KHZt
X2ZsYWdzKSkpOw0KPiArfQ0KPiArRVhQT1JUX1NZTUJPTCh2bV9nZXRfcGFnZV9wcm90KTsNCg0K
VGhpcyBsb29rcyBmdW5jdGlvbm5hbHkgT0ssIGJ1dCBJIHRoaW5rIHdlIGNvdWxkIGdvIGluIHRo
ZSBzYW1lIA0KZGlyZWN0aW9uIGFzIEFSTSBhbmQgdHJ5IHRvIGludGVncmF0ZSBfX3ZtX2dldF9w
YWdlX3Byb3QoKSBpbnNpZGUgDQp2bV9nZXRfcGFnZV9wcm90KCkgdG8gZ2V0IHNvbWV0aGluZyBz
aW1wbGVyIGFuZCBjbGVhbmVyOg0KDQpTb21ldGhpbmcgbGlrZSBiZWxvdyAodW50ZXN0ZWQpOg0K
DQpwZ3Byb3RfdCB2bV9nZXRfcGFnZV9wcm90KHVuc2lnbmVkIGxvbmcgdm1fZmxhZ3MpDQp7DQoJ
dW5zaWduZWQgbG9uZyBwcm90ID0gcGdwcm90X3ZhbChwcm90ZWN0aW9uX21hcFt2bV9mbGFncyAm
DQoJCQkJIChWTV9SRUFEfFZNX1dSSVRFfFZNX0VYRUN8Vk1fU0hBUkVEKV0pOw0KDQoJaWYgKHZt
X2ZsYWdzICYgVk1fU0FPKQ0KCQlwcm90IHw9IF9QQUdFX1NBTw0KDQojaWZkZWYgQ09ORklHX1BQ
Q19NRU1fS0VZUw0KCXByb3QgfD0gdm1mbGFnX3RvX3B0ZV9wa2V5X2JpdHModm1fZmxhZ3MpOw0K
I2VuZGlmDQoNCglyZXR1cm4gX19wZ3Byb3QocHJvdCk7DQp9
