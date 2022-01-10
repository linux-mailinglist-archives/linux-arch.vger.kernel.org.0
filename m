Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A234893E2
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jan 2022 09:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242043AbiAJIo3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jan 2022 03:44:29 -0500
Received: from mail-eopbgr90059.outbound.protection.outlook.com ([40.107.9.59]:27699
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242130AbiAJIm1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 Jan 2022 03:42:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V88iDg6iliDfOQhy0idROWpbZ2umUO/Mg7F69C4E7Ls7+905nQbjCfiKcn40Zt66NwozgcuayEjnL5HNvhzpHx0Chq+MjfZ0m584EOBWxUURLZ/KPtE7Y8UefJct7lvVE3EDEnx1ACYGSncFUAs7jWmXlyEr1wnEN+bwYMl4G9AYH/2pj/YXFyNi8GM6MJUP5bHAC/+L8ee/b0wnWQHO+6hKCyBeBvzwSd8BOMxmnLMzSv5JwxFQdAeoPRsRZuhbfp7M2ifWJYNkfgrCmZAInKcnTj4tCoKttErNUn1CKBZa1iLOaqc8FvawD7qOoXuEu6XGxoZJoOEYngiWRrObRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2SFqx+1BSoYytG9SahBgXvn4WeoGuBwTSeHvT6ybbo=;
 b=TiLteEPcGvtzjm13vJLXQpbsgagPKIIVQk/hRSQEQxcSiF/e6ML81jKPQDaA0SxSMYlq7CxpnEL7A7AV0HZwmtHleCOGbl0yMv2j/BTZrICYtfCb16FtjLFbvIVSzhp8dQrTyzzCxKsMLBK7c2hCEuViHe7Is5yOKROnlCL/Z4wujnIHBWYEsLbDNKng09IyWcKTyJ4pT396i1B+v1TSyjCS86dwZdDamIesDzcKAAPaYD8zHx/DHieGlfDrXuJyfaKKdpI+mQrGiFo/Utha1GPkqrViBJK94qfuRp/dS0Y9PJzAksiKP5nWY0lksMPFAVl4umPqtATv1kcvDyfP+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB1761.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.7; Mon, 10 Jan 2022 08:42:24 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9d4f:1090:9b36:3fc5]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9d4f:1090:9b36:3fc5%4]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 08:42:24 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>
CC:     linux-arch <linux-arch@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Paul Mackerras <paulus@samba.org>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH 06/23] powerpc/membarrier: Remove special barrier on mm
 switch
Thread-Topic: [PATCH 06/23] powerpc/membarrier: Remove special barrier on mm
 switch
Thread-Index: AQHYBK8Vp3ngND2g9EaYIs/zM8hDkKxb8puA
Date:   Mon, 10 Jan 2022 08:42:24 +0000
Message-ID: <ac6d9054-7bf2-f1f0-2fb0-d73b7f0293d7@csgroup.eu>
References: <cover.1641659630.git.luto@kernel.org>
 <e1664cf686034204b8dd5dc1d2bf18e4058b00fd.1641659630.git.luto@kernel.org>
In-Reply-To: <e1664cf686034204b8dd5dc1d2bf18e4058b00fd.1641659630.git.luto@kernel.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7ab4e15-6e7b-40af-182f-08d9d4152001
x-ms-traffictypediagnostic: MR1P264MB1761:EE_
x-microsoft-antispam-prvs: <MR1P264MB1761614D42A4B1BD2EC3D391ED509@MR1P264MB1761.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XrBFguzwDCOHvMAc+ix/os0bKLKEcnLxsAtJg4db9Dt+f05hbnWg5vuwpilb1bgENPjh/Y2YmjHy/o0lOkzYv0a8xShrK9gXDSLPMsWp+b8siTKsBa84ewVJlR483/EV7kRRiPO51Qg9vAJWeJEIZb+3T+kJGyiZjyYz+ncjSbecSUadylvbiorIXonqh8hKzLyfbWI7Zw1cf2Uz94GnJLlm79OBpi2SKLkvEGS2bTYokR2Cptj8YgZPcYhBNBNFyPY4ndeUWg1aaaDduwZ3L8Qce5pb5CGcYLrAAOAQdMx5Gk7DrO3UKb9wl7HYKXRyJ6nlsJlKNdC73tPXzhspNdDDOL4KjQl0sEGHftOcxwqhVtPO2MvbF3BfVaSjg3eukhkcYL1RZu7XxaNjnpK7AKoMDJrdAl1braKDAvGPpIXgJVZ1ktv1Kolpodc+gBT1PGShvCkXLoTsofSomsYvP/oUjJuIN71CoyPFbfgX7dMxlS+or26wdBvjn9AQXCzDGgOqkW9P98jKTO3h0bf3uUUuTdM8M3S3UZCjM8SK/GVHFWcbzOR+0h98QeLoGTe8GfWyyPIHjob/Ym9S+//jrrgVfPWB0061EFfyGS0CG+G2/c9IhAn05faTShORVWh4mkzBsx0iNMB0oGHRcVHdLU8GKR4FR/le3NQmy+vKhaMDcBfE2u5sEF2LUiz/TB0NhyjK0+wnKEaL+mjD1SMGFjFRY4QG/OB0XC7Rq4dSHNAliAvhnb/XroCnY9HeE4Qj6t9xMlI6mtpfV0f+gJacXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(31696002)(31686004)(66946007)(76116006)(38070700005)(91956017)(71200400001)(508600001)(54906003)(110136005)(8936002)(4326008)(86362001)(66446008)(6506007)(44832011)(64756008)(2616005)(8676002)(2906002)(66556008)(66476007)(6512007)(6486002)(83380400001)(66574015)(5660300002)(38100700002)(186003)(122000001)(26005)(7416002)(316002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NU1lZE1HZE5IYi9saE56QzZUS2krRFd5VHhWZzdsdm1rTzVBMXVTbll4VlRr?=
 =?utf-8?B?Z2lYMDZOOU9UaFJKV1JpRTlsZmsrTnVVamZuUGVhN293ZjBTMjVmTzMvL1hH?=
 =?utf-8?B?M2EzVVl0NWQ4cmxxL0FDb0lGYWZ2SUY3cnozdDd5ZjE1RnVWVDUxWTAwdUli?=
 =?utf-8?B?TnBkeVh1TE5KeVhiZ1JIaUxlcUR6TEVSR3NIcDFsYkVCKzRNbmpWZkdXTWZ6?=
 =?utf-8?B?N2I2cXpxOHJsYlZ2WHhxakpUdFpDaGFSdWt4KzV6VXlTYVA1VTFhUHlZNks4?=
 =?utf-8?B?cTJCbGwrQ0lyUlAzczBPSFMrSzQ1Qmo4MEtFU2ptUDR5Z1U1MUp5a0lJZHhU?=
 =?utf-8?B?czBpaWFWMnc0NVpWUzRIUVNCZHBlREpiL3dNU0xEY3FHNnBKRVRSTWJwSkJj?=
 =?utf-8?B?RUVmTEphYlNjRnBXYlF0UWI0NldxTzdIaE9XczdZUkt3dUk0WUo0d050V1Zl?=
 =?utf-8?B?aDMyQ0xhSS9RamRkTWIyR3ZQNWcxMTRjcW8xQ3pMYzhNakNLeTdqbk80WmNH?=
 =?utf-8?B?cnVGQ0VjMGVRdkYyZEl4aGh1cEt2ZmFscjJlZEUrQytIdGo0VUtGZmNpS3lY?=
 =?utf-8?B?R1FjTG9Jb0trcFdqUzM1SlJ5ai9mZ2prVlZmcEV6TjZxS0R2WjRTTVdRUUNo?=
 =?utf-8?B?NjNZYTFObXpvZlBobVN1T1VhdnNwZm8vR0dVbVlsSmE5OEh4WjJRM0l5Rksz?=
 =?utf-8?B?Q3JsdjdyUlZxQU5TTlVVSFBLQ0FkalVyNEV5NXFYZCtOMzFhTGRDR2ZEdmc5?=
 =?utf-8?B?dGNsbzN2NnNzN3U1YmpaUkcrWXR3SzZkTjZ2eFEzOWkrVnlYZkhEVWdJU0JU?=
 =?utf-8?B?bHoxSWVIbTNaNmZqNTd4dEZvSUxmbkUwQmZkbThEOFFvMXcza3hDVS9VakZq?=
 =?utf-8?B?VkF3bHF1bjBmbStTcDBUU2xLaTVFeUxBNFk5ZTk4eGlKQ2g2WkVYSnVRVUlP?=
 =?utf-8?B?TzVDdXhBVGxoQlNkZEp0bjV2VGRDTnN2eVUyVzgrMFdsRk9vYUgxUUtGSjgw?=
 =?utf-8?B?S21BOEsxZjZUdENubnFHL0xhYXJRcXc5TVJDeDZZYmYxVHJ1cEoxSVFwaGN3?=
 =?utf-8?B?cEQ3dlZWL21jc2t6TDYzTVZjUExMc3hpVGY5TjFhQjh0K2NIZlNQb2Rnc3JI?=
 =?utf-8?B?bmZDcGxPZGZDNEhzaXpQTTczaXNkRno1NVlDblpyaTlxclJFdnJEbmNCWXh4?=
 =?utf-8?B?NG9XaGZMZHR2bTFoNjBCUjRqaWJ2Nm56RU1FbHlxTGVuY2NGak1ia21Mdy95?=
 =?utf-8?B?Sjd3UnpTc1E3MEo2bUYyOTNBOTBibFNEUkNOZFJkVk9IWkhKUHB1Ty9teVJv?=
 =?utf-8?B?YVdoTXhWMnIwU1hNbXhyem1OL25CdVpUdFNwSG5CbnpJSVN6UzJMOXplaXli?=
 =?utf-8?B?Q1FnR0RkSDFCN2IxVjZOMitkR3ZXeXhvZkdtVWI5WjM4Qi9mT1NpMjlpcmRy?=
 =?utf-8?B?N3FQT1NnQkNPaUxTR29zbXk1YVYrUTlNc3I2ZDFUUDNUQk5YajNIVVhjZXlZ?=
 =?utf-8?B?Y1dSQlpONUlzbkVBRzN3UjZELzdDWVlMdG1yTW5Qb1Z6WmJIOFNGWmhFK0Zw?=
 =?utf-8?B?QmgzbXlNVFkrTFF1WW14czYraW1Cdi9uYTg4S2N3TVp2dmFJM3Vxbml5M3Ru?=
 =?utf-8?B?UUhtVjVVQ3dvR3ZJaE16Q01GaGcydGxQSk5DaVJzVDNVSEtIeVFCRU9hUGtY?=
 =?utf-8?B?dVJRVno5UFd3enJjOGhCaVZpTk1TOGM0dTE5ODh2TmJ4amozVkFOaUhTLzNl?=
 =?utf-8?B?ZGRiSmxKZEhNOHpEZVRyMnJ3OWRNbXF6YkxEVTM2c3lMcnRGa0xITHYyelNY?=
 =?utf-8?B?SWlwa1ZSejlQNXFoZWh0SWpqZ1kzeTgzak5ucmd1VVlFYWd5THVKQWI0bFIx?=
 =?utf-8?B?aVZRYUd1MjdrckdzY2U1L1Fab0F1dW1kekpSSHhpdUtOV1UzRy9hNnc3SG9L?=
 =?utf-8?B?NjhsZ3h2emZYTkZ5eE9UTUFTSDl6ZmVUNDdOWjNQSmFZUytCeEM0U3Zad3Zp?=
 =?utf-8?B?M2w0TmNFbFZTOUoxWWJGYkg2YkJ6Z01qd1QzeTJSSlUrTHFETzZRZ1J5VmFk?=
 =?utf-8?B?ekRNd296Ni9Wa3pWOUxvampBSTVsZTk0eXpOOUVWU0RaNmwwUDdVOFBmS1JZ?=
 =?utf-8?B?bk5DTFRqM0JITU1LQmxPSmJkanFWOGRpMUcxTFZGdFRKczlDZzBEWWgzUmVW?=
 =?utf-8?B?eDZuQmNkc1FQcmNJVGF0VjhEbThJSVJvaVZzaFNZQXBsdEMyTzdlb0ZDQm0w?=
 =?utf-8?Q?731hBrSTwXP9BvUC4sqk2auvlPnvAqQamv7UDSFuB4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0436170F4449543B6CD6BE4E7A9C61F@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ab4e15-6e7b-40af-182f-08d9d4152001
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2022 08:42:24.5342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /h2NJ79Qw+6vWfdqlxYn1O8M02+P5+Gbdr0ilmd0Mw668+vPRMJgRhBKRPAs548+krAR4G2P49qJEOKfZad7K6t/MgLqv/S9hHOiA+sCN04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB1761
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDA4LzAxLzIwMjIgw6AgMTc6NDMsIEFuZHkgTHV0b21pcnNraSBhIMOpY3JpdMKgOg0K
PiBwb3dlcnBjIGRpZCB0aGUgZm9sbG93aW5nIG9uIHNvbWUsIGJ1dCBub3QgYWxsLCBwYXRocyB0
aHJvdWdoDQo+IHN3aXRjaF9tbV9pcnFzX29mZigpOg0KPiANCj4gICAgICAgICAvKg0KPiAgICAg
ICAgICAqIE9ubHkgbmVlZCB0aGUgZnVsbCBiYXJyaWVyIHdoZW4gc3dpdGNoaW5nIGJldHdlZW4g
cHJvY2Vzc2VzLg0KPiAgICAgICAgICAqIEJhcnJpZXIgd2hlbiBzd2l0Y2hpbmcgZnJvbSBrZXJu
ZWwgdG8gdXNlcnNwYWNlIGlzIG5vdA0KPiAgICAgICAgICAqIHJlcXVpcmVkIGhlcmUsIGdpdmVu
IHRoYXQgaXQgaXMgaW1wbGllZCBieSBtbWRyb3AoKS4gQmFycmllcg0KPiAgICAgICAgICAqIHdo
ZW4gc3dpdGNoaW5nIGZyb20gdXNlcnNwYWNlIHRvIGtlcm5lbCBpcyBub3QgbmVlZGVkIGFmdGVy
DQo+ICAgICAgICAgICogc3RvcmUgdG8gcnEtPmN1cnIuDQo+ICAgICAgICAgICovDQo+ICAgICAg
ICAgaWYgKGxpa2VseSghKGF0b21pY19yZWFkKCZuZXh0LT5tZW1iYXJyaWVyX3N0YXRlKSAmDQo+
ICAgICAgICAgICAgICAgICAgICAgIChNRU1CQVJSSUVSX1NUQVRFX1BSSVZBVEVfRVhQRURJVEVE
IHwNCj4gICAgICAgICAgICAgICAgICAgICAgIE1FTUJBUlJJRVJfU1RBVEVfR0xPQkFMX0VYUEVE
SVRFRCkpIHx8ICFwcmV2KSkNCj4gICAgICAgICAgICAgICAgIHJldHVybjsNCj4gDQo+IFRoaXMg
aXMgcHV6emxpbmc6IGlmICFwcmV2LCB0aGVuIG9uZSBtaWdodCBleHBlY3QgdGhhdCB3ZSBhcmUg
c3dpdGNoaW5nDQo+IGZyb20ga2VybmVsIHRvIHVzZXIsIG5vdCB1c2VyIHRvIGtlcm5lbCwgd2hp
Y2ggaXMgaW5jb25zaXN0ZW50IHdpdGggdGhlDQo+IGNvbW1lbnQuICBCdXQgdGhpcyBpcyBhbGwg
bm9uc2Vuc2UsIGJlY2F1c2UgdGhlIG9uZSBhbmQgb25seSBjYWxsZXIgd291bGQNCj4gbmV2ZXIg
aGF2ZSBwcmV2ID09IE5VTEwgYW5kIHdvdWxkLCBpbiBmYWN0LCBPT1BTIGlmIHByZXYgPT0gTlVM
TC4NCj4gDQo+IEluIGFueSBldmVudCwgdGhpcyBjb2RlIGlzIHVubmVjZXNzYXJ5LCBzaW5jZSB0
aGUgbmV3IGdlbmVyaWMNCj4gbWVtYmFycmllcl9maW5pc2hfc3dpdGNoX21tKCkgcHJvdmlkZXMg
dGhlIHNhbWUgYmFycmllciB3aXRob3V0IGFyY2ggaGVscC4NCg0KSSBjYW4ndCBmaW5kIHRoaXMg
ZnVuY3Rpb24gbWVtYmFycmllcl9maW5pc2hfc3dpdGNoX21tKCksIG5laXRoZXIgaW4gDQpMaW51
cyB0cmVlLCBub3IgaW4gbGludXgtbmV4dCB0cmVlLg0KDQo+IA0KPiBhcmNoL3Bvd2VycGMvaW5j
bHVkZS9hc20vbWVtYmFycmllci5oIHJlbWFpbnMgYXMgYW4gZW1wdHkgaGVhZGVyLA0KPiBiZWNh
dXNlIGEgbGF0ZXIgcGF0Y2ggaW4gdGhpcyBzZXJpZXMgd2lsbCBhZGQgY29kZSB0byBpdC4NCj4g
DQo+IENjOiBNaWNoYWVsIEVsbGVybWFuIDxtcGVAZWxsZXJtYW4uaWQuYXU+DQo+IENjOiBCZW5q
YW1pbiBIZXJyZW5zY2htaWR0IDxiZW5oQGtlcm5lbC5jcmFzaGluZy5vcmc+DQo+IENjOiBQYXVs
IE1hY2tlcnJhcyA8cGF1bHVzQHNhbWJhLm9yZz4NCj4gQ2M6IGxpbnV4cHBjLWRldkBsaXN0cy5v
emxhYnMub3JnDQo+IENjOiBOaWNob2xhcyBQaWdnaW4gPG5waWdnaW5AZ21haWwuY29tPg0KPiBD
YzogTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4NCj4g
Q2M6IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4NCj4gU2lnbmVkLW9mZi1i
eTogQW5keSBMdXRvbWlyc2tpIDxsdXRvQGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiAgIGFyY2gvcG93
ZXJwYy9pbmNsdWRlL2FzbS9tZW1iYXJyaWVyLmggfCAyNCAtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCj4gICBhcmNoL3Bvd2VycGMvbW0vbW11X2NvbnRleHQuYyAgICAgICAgIHwgIDEgLQ0KPiAg
IDIgZmlsZXMgY2hhbmdlZCwgMjUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJj
aC9wb3dlcnBjL2luY2x1ZGUvYXNtL21lbWJhcnJpZXIuaCBiL2FyY2gvcG93ZXJwYy9pbmNsdWRl
L2FzbS9tZW1iYXJyaWVyLmgNCj4gaW5kZXggZGU3Zjc5MTU3OTE4Li5iOTA3NjZlOTViZDEgMTAw
NjQ0DQo+IC0tLSBhL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9tZW1iYXJyaWVyLmgNCj4gKysr
IGIvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL21lbWJhcnJpZXIuaA0KPiBAQCAtMSwyOCArMSw0
IEBADQo+ICAgI2lmbmRlZiBfQVNNX1BPV0VSUENfTUVNQkFSUklFUl9IDQo+ICAgI2RlZmluZSBf
QVNNX1BPV0VSUENfTUVNQkFSUklFUl9IDQo+ICAgDQo+IC1zdGF0aWMgaW5saW5lIHZvaWQgbWVt
YmFycmllcl9hcmNoX3N3aXRjaF9tbShzdHJ1Y3QgbW1fc3RydWN0ICpwcmV2LA0KPiAtCQkJCQkg
ICAgIHN0cnVjdCBtbV9zdHJ1Y3QgKm5leHQsDQo+IC0JCQkJCSAgICAgc3RydWN0IHRhc2tfc3Ry
dWN0ICp0c2spDQo+IC17DQo+IC0JLyoNCj4gLQkgKiBPbmx5IG5lZWQgdGhlIGZ1bGwgYmFycmll
ciB3aGVuIHN3aXRjaGluZyBiZXR3ZWVuIHByb2Nlc3Nlcy4NCj4gLQkgKiBCYXJyaWVyIHdoZW4g
c3dpdGNoaW5nIGZyb20ga2VybmVsIHRvIHVzZXJzcGFjZSBpcyBub3QNCj4gLQkgKiByZXF1aXJl
ZCBoZXJlLCBnaXZlbiB0aGF0IGl0IGlzIGltcGxpZWQgYnkgbW1kcm9wKCkuIEJhcnJpZXINCj4g
LQkgKiB3aGVuIHN3aXRjaGluZyBmcm9tIHVzZXJzcGFjZSB0byBrZXJuZWwgaXMgbm90IG5lZWRl
ZCBhZnRlcg0KPiAtCSAqIHN0b3JlIHRvIHJxLT5jdXJyLg0KPiAtCSAqLw0KPiAtCWlmIChJU19F
TkFCTEVEKENPTkZJR19TTVApICYmDQo+IC0JICAgIGxpa2VseSghKGF0b21pY19yZWFkKCZuZXh0
LT5tZW1iYXJyaWVyX3N0YXRlKSAmDQo+IC0JCSAgICAgKE1FTUJBUlJJRVJfU1RBVEVfUFJJVkFU
RV9FWFBFRElURUQgfA0KPiAtCQkgICAgICBNRU1CQVJSSUVSX1NUQVRFX0dMT0JBTF9FWFBFRElU
RUQpKSB8fCAhcHJldikpDQo+IC0JCXJldHVybjsNCj4gLQ0KPiAtCS8qDQo+IC0JICogVGhlIG1l
bWJhcnJpZXIgc3lzdGVtIGNhbGwgcmVxdWlyZXMgYSBmdWxsIG1lbW9yeSBiYXJyaWVyDQo+IC0J
ICogYWZ0ZXIgc3RvcmluZyB0byBycS0+Y3VyciwgYmVmb3JlIGdvaW5nIGJhY2sgdG8gdXNlci1z
cGFjZS4NCj4gLQkgKi8NCj4gLQlzbXBfbWIoKTsNCj4gLX0NCj4gLQ0KPiAgICNlbmRpZiAvKiBf
QVNNX1BPV0VSUENfTUVNQkFSUklFUl9IICovDQo+IGRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMv
bW0vbW11X2NvbnRleHQuYyBiL2FyY2gvcG93ZXJwYy9tbS9tbXVfY29udGV4dC5jDQo+IGluZGV4
IDc0MjQ2NTM2YjgzMi4uNWYyZGFhNmIwNDk3IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Bvd2VycGMv
bW0vbW11X2NvbnRleHQuYw0KPiArKysgYi9hcmNoL3Bvd2VycGMvbW0vbW11X2NvbnRleHQuYw0K
PiBAQCAtODQsNyArODQsNiBAQCB2b2lkIHN3aXRjaF9tbV9pcnFzX29mZihzdHJ1Y3QgbW1fc3Ry
dWN0ICpwcmV2LCBzdHJ1Y3QgbW1fc3RydWN0ICpuZXh0LA0KPiAgIAkJYXNtIHZvbGF0aWxlICgi
ZHNzYWxsIik7DQo+ICAgDQo+ICAgCWlmICghbmV3X29uX2NwdSkNCj4gLQkJbWVtYmFycmllcl9h
cmNoX3N3aXRjaF9tbShwcmV2LCBuZXh0LCB0c2spOw0KDQpBcmUgeW91IHN1cmUgdGhhdCdzIHdo
YXQgeW91IHdhbnQgPw0KDQpJdCBub3cgbWVhbnMgeW91IGhhdmU6DQoNCglpZiAoIW5ld19vbl9j
cHUpDQoJc3dpdGNoX21tdV9jb250ZXh0KHByZXYsIG5leHQsIHRzayk7DQoNCg0KPiAgIA0KPiAg
IAkvKg0KPiAgIAkgKiBUaGUgYWN0dWFsIEhXIHN3aXRjaGluZyBtZXRob2QgZGlmZmVycyBiZXR3
ZWVuIHRoZSB2YXJpb3Vz
