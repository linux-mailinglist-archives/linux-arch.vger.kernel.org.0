Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A50478A65
	for <lists+linux-arch@lfdr.de>; Fri, 17 Dec 2021 12:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbhLQLtc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Dec 2021 06:49:32 -0500
Received: from mail-eopbgr120042.outbound.protection.outlook.com ([40.107.12.42]:19184
        "EHLO FRA01-PR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230396AbhLQLtb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 17 Dec 2021 06:49:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkEkkJX1xWhhkBjolwVfi/L8q1r3sHoY2uaJULlq9438FgukkrT4wJR8sDhSQf7/YNgv5Y9tsq/s+PmVaDacJ+d+TClXwtu40ju21XyXNoFx67/M+Oh+qEU1TNmNnRO02GbfSKzjm/OPa4FKvPEugCIi2wzHKhM388+MSeBBqB1pI+6dR8NqdXiwg+NCzjlAA3FFIllEmfohmbUZayR77urB0+8fMq7bMa5p76pd1zRbkEQuvohXlZ5PYy8r5uBLcR0V5kJ+XkqYyDyd1/LpUe39OTL2YOrccoOnSvsm6AItBRI7n+iaeXbjyPyKDM6Q5Tv1lj1LHsLJQF2+RK9tUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PaOe1G1aKyZJ8rGQTdgEZqYVnscOtfJqci1u+CAHfR8=;
 b=ma27uY3/x/m4bFUy6b82XIuGI1vA4ksHvcOVYh+LOeNw+FY1BgYWR6ph73SupMl1cKf71I7dLGOSD0+XfMYcWn8xWbLG/8+RqnXmn5o8nMMcYApP7autAnJTsHF/EoSgASRbPUcLkcB7nsa+A12qR/YazA4y7vTi4p1oYsmH9IKSrXwBKWJ00LpH71bywQqc2KbnMX1aGqUdreSDiYluCegj3r8SN/HeOGrKWK+Q+OP0qbl9AXTBvsGvObug0DUJOqnSK2na7w0oqWHiJVbuh0ro75z8RbR4n3nnTWgUPS5k4Tse5Qa8hC+Gn8lT3UUQ6RHFF1ww3FPD0gWSWSwjjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB2594.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:33::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 11:49:28 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::f0ef:856d:b0de:e85d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::f0ef:856d:b0de:e85d%5]) with mapi id 15.20.4801.016; Fri, 17 Dec 2021
 11:49:28 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>
CC:     Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Paul Mackerras <paulus@samba.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 11/12] lkdtm: Fix execute_[user]_location()
Thread-Topic: [PATCH v3 11/12] lkdtm: Fix execute_[user]_location()
Thread-Index: AQHXw1QCbX7Skb+OekykpYQSj675R6w28aGA
Date:   Fri, 17 Dec 2021 11:49:28 +0000
Message-ID: <e7793192-6879-490d-1f37-3d6d6908a121@csgroup.eu>
References: <cover.1634457599.git.christophe.leroy@csgroup.eu>
 <d4688c2af08dda706d3b6786ae5ec5a74e6171f1.1634457599.git.christophe.leroy@csgroup.eu>
In-Reply-To: <d4688c2af08dda706d3b6786ae5ec5a74e6171f1.1634457599.git.christophe.leroy@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14675373-1449-4ff7-581b-08d9c15347f5
x-ms-traffictypediagnostic: MR1P264MB2594:EE_
x-microsoft-antispam-prvs: <MR1P264MB25944F2BA9FED17095BB3930ED789@MR1P264MB2594.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tB/KSSdzQ7vcPaHl9bhmkpKMc6Pp9KNmJ3l9sMaVth/vLGA1U3NgNkzodjwV0O+cdC5poKnHezc1gdCkYR49SthmPGzbg9vWbjH+YZ3BW/09Anf7nb7Rlk3IhVVFn8mlpATQvZQPxes7xKR9DhBP2pxOPQHW98X9P0jMJ4aEJ7Y+Nwm0GlCdp30LeXRD5EmfSZ2ZiqaFhMIBAVXUa/0xCes9mltL0lMRWKDYUCHvXoveMhZSeuhyjlyXDSp8Cm1asG8Z0wV2ADaVhj01PZxXjbwkmz2n5vlKH7rYGuc0CDf52izEq04paWHwUCUBfzwCMwTqM1tLEyUYh8emw53rzZKVI675clG5x1kXpicqCZhUss4U+kWkkmXN6JWDYap5IyYqCRTAWhoucZGXh0PWNeH44KJaLSZipvVGoTGOd1AKZb1ryb38WRBM21A59y8XBaqQtgKC2eQkyNV/i0E6v6/6pUJE1qjsh0XKe4Rwh3+YKgODh0wpeyjGV7jL7aAONZqLaaoqBT7/2ZUMf83udQCDfTs2Hzlk5grMxp/lJiEt5W/ypddiyVob49j8/aMAB4j7LCqEdls+wMW3PHJFKV8Mjz3gEPdo5rjtOpNBmWA80Pbpc0GvQYn7vsBb7LD4kxWa4W3QBfIMq1MBCbdEpitSLih2Gy8bx+OUJ4ygLvH+9O3gKEcL2RplyeZHHNZGU7t7GA5TMSpP3m+qN5uWvgytGJS9g7/P0Qh+Lsqr0togcwFeI4h1d5zrOK6xGxJ+zRDQirWy8z6Yvac8A50EPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(31686004)(2616005)(86362001)(44832011)(66946007)(508600001)(91956017)(54906003)(31696002)(316002)(110136005)(2906002)(26005)(36756003)(76116006)(4326008)(186003)(6506007)(66556008)(66446008)(64756008)(6512007)(122000001)(38100700002)(7416002)(71200400001)(38070700005)(66476007)(8676002)(5660300002)(8936002)(6486002)(83380400001)(66574015)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1piWXlxTVJpcCs4c240eVFHdkNHbGVjOEt2RHRlc2tFK0lxQTdDM2p1d3lI?=
 =?utf-8?B?a1h6aUlFb3hqRkY2UDJoaUJUSncydzFDdmZ4ckk0OU9SK3FFN0FobG5rUEpl?=
 =?utf-8?B?WjZscmZXckVKZGNZU0ZGS3R3dUNJRndGQjQxa0xiUzdCd3hna0p0WmpwZlVu?=
 =?utf-8?B?dWVVVXlVcHhYc1hLcFUvRm9adlJBcUFxa2VDTGpsUklHQ05vV3NMU0p3RXF4?=
 =?utf-8?B?VTI3QVczK0tsbFhqSDRvMFJIdjBid1g4Y3ZMSGp3L2phZitxMnRHeFovZlRz?=
 =?utf-8?B?TWhVYjhtRmYyMDBmWGRtdlBVSlVib0poYTdCWGxvSGhiejVSOVpwSThvQzE2?=
 =?utf-8?B?anoxbWMyMzk4WFQxQThYRSt1UTNRRkpYS3dncmh1amFZZjl6aGZYY2FLZWdQ?=
 =?utf-8?B?cHJCeHdOZ1dkd0hKVnB3TXMySnNRSVRkSHJRT3NXK2xSbmlJK09UT004TlR6?=
 =?utf-8?B?M1l3MmZBdjRmNzVUYXhlTHU3eUFMSXNvOTNBd3pqUFlsSVYvTDFWZ0M3L2dU?=
 =?utf-8?B?Z3ZhOHYvWkU1NTRZTDlYcEJmcXhGSkNtQk9pTUFlUk5NUHFEbWg2SjNPVmR6?=
 =?utf-8?B?Y1J0K2NRZzhxaVBlbEZPMTFENFozTzZNam1UM1lIbkVGYTd2QW9Vc2FOQnRw?=
 =?utf-8?B?aTN5OFZLVDVYcllBMU5mWnRFWEFVNzNtckhvY3dUNWwycTZScGFJZ3MwSG43?=
 =?utf-8?B?M2dJdEtObWxSbkNaUm5WcGE1cWlGM0Z0KzE5TjZBOHBvaUI0VldEcFRXVGwz?=
 =?utf-8?B?aFNkUy9IelFWd1JYME5QTWZSZnQyRnpIVDE2YzVLK1Zqa2lERWpGaEFYR0ZO?=
 =?utf-8?B?dlpHb0xyTFc0d20yUXFRNk8wbkNjTHdpUWh0ZjNxdnN2enQzMlpTRXBpVlBN?=
 =?utf-8?B?STBDRU9PVXFoNmFua0tyU1FJSnFua3pneGtESVQ0djA1TDRVcmxGRE0yTEpu?=
 =?utf-8?B?ZUtIU0hYN2xtZC90QUMyUkl5RVdxbWJhMTJYeEtJWTg1a3JkR25rNU5heVVV?=
 =?utf-8?B?WGJRWXgvZ2RSb3VPclNCSWdaK0FXVk10SElRV0dZOVlUcDBlbzZqQjNTczdH?=
 =?utf-8?B?TTBWT3hLOGZPZWkvbDFVaFlpVG1kQ3hXTXhnQVJ0dGNZVlRMQ3RpUGpwNTJq?=
 =?utf-8?B?VEM4SThyZDhZQzZGbWhSVkpsYWJ2N0M2Sk1nZkExRGtzazI4ZjlxdnVJK2J3?=
 =?utf-8?B?Ri9IZ2M2RFJpYVI5R2xBb0lPaGFjTFZFMWJkNHNQYWpKSFhQLzRkQmdQaUlO?=
 =?utf-8?B?cWtoWlQrU0RqZnlKS0xWTmxNajQydlM0K3JvYWJqK0VxTlVNcTU5a3gvMFZj?=
 =?utf-8?B?NTVRRURScUV1UmhyVXgrTDFZY2xYNG5Nb2ZEVUdiaXFyK0R6a2hZR1YwcjI1?=
 =?utf-8?B?NkNFbUlTY1kzR2dxVUxSbXVNS2hsTEJKOCtRVGVRbGdESnlrNjlWUElCc0Jo?=
 =?utf-8?B?ODM4N1FFOW5Oa0MxdWh0UVNUSFFjYzc5STNSZHFQaWt1bGNUYmxjaGo2Rkwz?=
 =?utf-8?B?NjJjKzhQUEhwMzlzYXJyRHRkOGhSTVBXSXYyWWdseGRNNnM3elBUdUc1aExw?=
 =?utf-8?B?V1hreHQ2RlpCVHRMaWpoTXFtRDVkYS9sUzVYZlVCQzhqcHZqM0JXT3lQWHpv?=
 =?utf-8?B?UGxWd0FLN0ZGK2FManFkVVY0WmxaL0JjbnU1WVlHNFVMZDdHaWxGb3cvanUr?=
 =?utf-8?B?cHlFZlg5SEJsdmVxTGJSUFpseHVoZ2NtZzV1NlptWnNLc3doUkE2eS9jTjVX?=
 =?utf-8?B?NUk3Yk9HWEx4SGtPTUI1ZjJ1VEoydkNNdjhPQjcrdW9IR1p6Yk96VDQ0ZUlD?=
 =?utf-8?B?RXVOYzRTVEJyaElJY3BXQ1hicWNlaUU3TnZrVWk0d3N6TUR6Mks3bkpRT016?=
 =?utf-8?B?N0pTek11ZTg4czBhcXpsZXJnY0gvSXFBdnpWZ0h6bHByYjhmWFFkTGhBbGE4?=
 =?utf-8?B?MVdsRmhJZlJKb3pHNnFhbWw1dnB4TGNTUjdtYlhYSVZ5S2tyU3lXdUVoYTRR?=
 =?utf-8?B?cm9MYzJXd2IyNGZrWnF4OTZ4YzB1K1lVNU81YnpFTkQ4bWlTUXl2cWx0M2Rv?=
 =?utf-8?B?bHRBQVJGM2t0ckNyWERpNGNNV0dnRy9YdkZVZGZUTy9BamNLVXcwRHpBbGEr?=
 =?utf-8?B?YU9NamFyK2F1UmZOWHUveHJqYVJHU0F1eDlrQjVQMUZLNFN6NVl1WnVreFhK?=
 =?utf-8?B?czZBK1RwNjNZZlJqanl0cHQ1c2Vmc2dkcTBmdFAxalRBajgxWTRxcTJTRG5p?=
 =?utf-8?Q?avgw5ytZuzQOutpHmV4w3hgLmgkwGImv4ZA88WI6as=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <87C604BE9A55874B9649B1622AD20728@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 14675373-1449-4ff7-581b-08d9c15347f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 11:49:28.2718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mJJCXBQ9QYKW/BY5SgLgoRqpL3Gb6aV6mVLOxRK0cgXoTCmPtXjaxvaBCghkutkWq0j1S7Q2ZfR73dQS9QpftR+K/QmdL9kL0+NgslLnvSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2594
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

SGkgS2VlcywNCg0KTGUgMTcvMTAvMjAyMSDDoCAxNDozOCwgQ2hyaXN0b3BoZSBMZXJveSBhIMOp
Y3JpdMKgOg0KPiBleGVjdXRlX2xvY2F0aW9uKCkgYW5kIGV4ZWN1dGVfdXNlcl9sb2NhdGlvbigp
IGludGVudA0KPiB0byBjb3B5IGRvX25vdGhpbmcoKSB0ZXh0IGFuZCBleGVjdXRlIGl0IGF0IGEg
bmV3IGxvY2F0aW9uLg0KPiBIb3dldmVyLCBhdCB0aGUgdGltZSBiZWluZyBpdCBkb2Vzbid0IGNv
cHkgZG9fbm90aGluZygpIGZ1bmN0aW9uDQo+IGJ1dCBkb19ub3RoaW5nKCkgZnVuY3Rpb24gZGVz
Y3JpcHRvciB3aGljaCBzdGlsbCBwb2ludHMgdG8gdGhlDQo+IG9yaWdpbmFsIHRleHQuIFNvIGF0
IHRoZSBlbmQgaXQgc3RpbGwgZXhlY3V0ZXMgZG9fbm90aGluZygpIGF0DQo+IGl0cyBvcmlnaW5h
bCBsb2NhdGlvbiBhbGx0aG91Z2ggdXNpbmcgYSBjb3BpZWQgZnVuY3Rpb24gZGVzY3JpcHRvci4N
Cj4gDQo+IFNvLCBmaXggdGhhdCBieSByZWFsbHkgY29weWluZyBkb19ub3RoaW5nKCkgdGV4dCBh
bmQgYnVpbGQgYSBuZXcNCj4gZnVuY3Rpb24gZGVzY3JpcHRvciBieSBjb3B5aW5nIGRvX25vdGhp
bmcoKSBmdW5jdGlvbiBkZXNjcmlwdG9yIGFuZA0KPiB1cGRhdGluZyB0aGUgdGFyZ2V0IGFkZHJl
c3Mgd2l0aCB0aGUgbmV3IGxvY2F0aW9uLg0KPiANCj4gQWxzbyBmaXggdGhlIGRpc3BsYXllZCBh
ZGRyZXNzZXMgYnkgZGVyZWZlcmVuY2luZyBkb19ub3RoaW5nKCkNCj4gZnVuY3Rpb24gZGVzY3Jp
cHRvci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waGUgTGVyb3kgPGNocmlzdG9waGUu
bGVyb3lAY3Nncm91cC5ldT4NCg0KRG8geW91IGhhdmUgYW55IGNvbW1lbnQgdG8gdGhpcyBwYXRj
aCBhbmQgdG8gcGF0Y2ggMTIgPw0KDQpJZiBub3QsIGlzIGl0IG9rIHRvIGdldCB5b3VyIGFja2Vk
LWJ5ID8NCg0KVGhhbmtzDQpDaHJpc3RvcGhlDQoNCj4gLS0tDQo+ICAgZHJpdmVycy9taXNjL2xr
ZHRtL3Blcm1zLmMgfCAzNyArKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tDQo+
ICAgMSBmaWxlIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9taXNjL2xrZHRtL3Blcm1zLmMgYi9kcml2ZXJzL21pc2Mv
bGtkdG0vcGVybXMuYw0KPiBpbmRleCAwMzVmY2NhNDQxZjAuLjFjZjI0YzRhNzllOSAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9taXNjL2xrZHRtL3Blcm1zLmMNCj4gKysrIGIvZHJpdmVycy9taXNj
L2xrZHRtL3Blcm1zLmMNCj4gQEAgLTQ0LDE5ICs0NCwzNCBAQCBzdGF0aWMgbm9pbmxpbmUgdm9p
ZCBkb19vdmVyd3JpdHRlbih2b2lkKQ0KPiAgIAlyZXR1cm47DQo+ICAgfQ0KPiAgIA0KPiArc3Rh
dGljIHZvaWQgKnNldHVwX2Z1bmN0aW9uX2Rlc2NyaXB0b3IoZnVuY19kZXNjX3QgKmZkZXNjLCB2
b2lkICpkc3QpDQo+ICt7DQo+ICsJaWYgKCFoYXZlX2Z1bmN0aW9uX2Rlc2NyaXB0b3JzKCkpDQo+
ICsJCXJldHVybiBkc3Q7DQo+ICsNCj4gKwltZW1jcHkoZmRlc2MsIGRvX25vdGhpbmcsIHNpemVv
ZigqZmRlc2MpKTsNCj4gKwlmZGVzYy0+YWRkciA9ICh1bnNpZ25lZCBsb25nKWRzdDsNCj4gKwli
YXJyaWVyKCk7DQo+ICsNCj4gKwlyZXR1cm4gZmRlc2M7DQo+ICt9DQo+ICsNCj4gICBzdGF0aWMg
bm9pbmxpbmUgdm9pZCBleGVjdXRlX2xvY2F0aW9uKHZvaWQgKmRzdCwgYm9vbCB3cml0ZSkNCj4g
ICB7DQo+IC0Jdm9pZCAoKmZ1bmMpKHZvaWQpID0gZHN0Ow0KPiArCXZvaWQgKCpmdW5jKSh2b2lk
KTsNCj4gKwlmdW5jX2Rlc2NfdCBmZGVzYzsNCj4gKwl2b2lkICpkb19ub3RoaW5nX3RleHQgPSBk
ZXJlZmVyZW5jZV9mdW5jdGlvbl9kZXNjcmlwdG9yKGRvX25vdGhpbmcpOw0KPiAgIA0KPiAtCXBy
X2luZm8oImF0dGVtcHRpbmcgb2sgZXhlY3V0aW9uIGF0ICVweFxuIiwgZG9fbm90aGluZyk7DQo+
ICsJcHJfaW5mbygiYXR0ZW1wdGluZyBvayBleGVjdXRpb24gYXQgJXB4XG4iLCBkb19ub3RoaW5n
X3RleHQpOw0KPiAgIAlkb19ub3RoaW5nKCk7DQo+ICAgDQo+ICAgCWlmICh3cml0ZSA9PSBDT0RF
X1dSSVRFKSB7DQo+IC0JCW1lbWNweShkc3QsIGRvX25vdGhpbmcsIEVYRUNfU0laRSk7DQo+ICsJ
CW1lbWNweShkc3QsIGRvX25vdGhpbmdfdGV4dCwgRVhFQ19TSVpFKTsNCj4gICAJCWZsdXNoX2lj
YWNoZV9yYW5nZSgodW5zaWduZWQgbG9uZylkc3QsDQo+ICAgCQkJCSAgICh1bnNpZ25lZCBsb25n
KWRzdCArIEVYRUNfU0laRSk7DQo+ICAgCX0NCj4gLQlwcl9pbmZvKCJhdHRlbXB0aW5nIGJhZCBl
eGVjdXRpb24gYXQgJXB4XG4iLCBmdW5jKTsNCj4gKwlwcl9pbmZvKCJhdHRlbXB0aW5nIGJhZCBl
eGVjdXRpb24gYXQgJXB4XG4iLCBkc3QpOw0KPiArCWZ1bmMgPSBzZXR1cF9mdW5jdGlvbl9kZXNj
cmlwdG9yKCZmZGVzYywgZHN0KTsNCj4gICAJZnVuYygpOw0KPiAgIAlwcl9lcnIoIkZBSUw6IGZ1
bmMgcmV0dXJuZWRcbiIpOw0KPiAgIH0NCj4gQEAgLTY2LDE2ICs4MSwxOSBAQCBzdGF0aWMgdm9p
ZCBleGVjdXRlX3VzZXJfbG9jYXRpb24odm9pZCAqZHN0KQ0KPiAgIAlpbnQgY29waWVkOw0KPiAg
IA0KPiAgIAkvKiBJbnRlbnRpb25hbGx5IGNyb3NzaW5nIGtlcm5lbC91c2VyIG1lbW9yeSBib3Vu
ZGFyeS4gKi8NCj4gLQl2b2lkICgqZnVuYykodm9pZCkgPSBkc3Q7DQo+ICsJdm9pZCAoKmZ1bmMp
KHZvaWQpOw0KPiArCWZ1bmNfZGVzY190IGZkZXNjOw0KPiArCXZvaWQgKmRvX25vdGhpbmdfdGV4
dCA9IGRlcmVmZXJlbmNlX2Z1bmN0aW9uX2Rlc2NyaXB0b3IoZG9fbm90aGluZyk7DQo+ICAgDQo+
IC0JcHJfaW5mbygiYXR0ZW1wdGluZyBvayBleGVjdXRpb24gYXQgJXB4XG4iLCBkb19ub3RoaW5n
KTsNCj4gKwlwcl9pbmZvKCJhdHRlbXB0aW5nIG9rIGV4ZWN1dGlvbiBhdCAlcHhcbiIsIGRvX25v
dGhpbmdfdGV4dCk7DQo+ICAgCWRvX25vdGhpbmcoKTsNCj4gICANCj4gLQljb3BpZWQgPSBhY2Nl
c3NfcHJvY2Vzc192bShjdXJyZW50LCAodW5zaWduZWQgbG9uZylkc3QsIGRvX25vdGhpbmcsDQo+
ICsJY29waWVkID0gYWNjZXNzX3Byb2Nlc3Nfdm0oY3VycmVudCwgKHVuc2lnbmVkIGxvbmcpZHN0
LCBkb19ub3RoaW5nX3RleHQsDQo+ICAgCQkJCSAgIEVYRUNfU0laRSwgRk9MTF9XUklURSk7DQo+
ICAgCWlmIChjb3BpZWQgPCBFWEVDX1NJWkUpDQo+ICAgCQlyZXR1cm47DQo+IC0JcHJfaW5mbygi
YXR0ZW1wdGluZyBiYWQgZXhlY3V0aW9uIGF0ICVweFxuIiwgZnVuYyk7DQo+ICsJcHJfaW5mbygi
YXR0ZW1wdGluZyBiYWQgZXhlY3V0aW9uIGF0ICVweFxuIiwgZHN0KTsNCj4gKwlmdW5jID0gc2V0
dXBfZnVuY3Rpb25fZGVzY3JpcHRvcigmZmRlc2MsIGRzdCk7DQo+ICAgCWZ1bmMoKTsNCj4gICAJ
cHJfZXJyKCJGQUlMOiBmdW5jIHJldHVybmVkXG4iKTsNCj4gICB9DQo+IEBAIC0xNTMsNyArMTcx
LDggQEAgdm9pZCBsa2R0bV9FWEVDX1ZNQUxMT0Modm9pZCkNCj4gICANCj4gICB2b2lkIGxrZHRt
X0VYRUNfUk9EQVRBKHZvaWQpDQo+ICAgew0KPiAtCWV4ZWN1dGVfbG9jYXRpb24obGtkdG1fcm9k
YXRhX2RvX25vdGhpbmcsIENPREVfQVNfSVMpOw0KPiArCWV4ZWN1dGVfbG9jYXRpb24oZGVyZWZl
cmVuY2VfZnVuY3Rpb25fZGVzY3JpcHRvcihsa2R0bV9yb2RhdGFfZG9fbm90aGluZyksDQo+ICsJ
CQkgQ09ERV9BU19JUyk7DQo+ICAgfQ0KPiAgIA0KPiAgIHZvaWQgbGtkdG1fRVhFQ19VU0VSU1BB
Q0Uodm9pZCkNCj4g
