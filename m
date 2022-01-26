Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B1249C3BA
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jan 2022 07:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbiAZGif (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Jan 2022 01:38:35 -0500
Received: from mail-eopbgr120078.outbound.protection.outlook.com ([40.107.12.78]:11120
        "EHLO FRA01-PR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229699AbiAZGie (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Jan 2022 01:38:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQc+TrQDU3AqQ+b3Oys2mh5veNMdoMCyYT5Vp+sqD/c/8TTL2p+wq4WvUyHV+ym+0xMQFB1ZpOwfVVXpXg/IzQarMZ3ZcgY8NKuZ3Z3INEirhUfe1SDQaAZmMTOFXsrY9mPbFY/H8rawFcJaX1slZ/ekmO2+zGNouRogMpHjVpbNMFKxwr+qHtxaIxYa/xJnyjCp+pQbTg5mJhFMg+plkNTIMQrQP0lzbmVlnPGVKvftBGwTECgXyKIKAJRZ86tbhq1maAPJxPegKiYHmEOIiBEBsX9/J4qE8ZwIR0MyuXnxO+mZ/UzuLGfmb8O7Bbb2Gk7FEfC74nF1Hq/FCiB1uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUd86j/Zkow3iianPHch57YCimU5xY+HA/U24e3pmjk=;
 b=j2HqrRjsqpum9xgZLRzIrBFRUx7S5I8wdd++TLZz6ZDpDOA26ok08HycjQel68Qmw35ryw7ND5DkjNpV0ALX8BAWWO5Fxkj4YLH6qyruFeHJ8GsReKkiR6dSKHfb8rXIS9QaXJ18RqDheA9boMRUrwYSMX1iClZomQexY6Ch8MT+WOYoH06SEhBOZo88TTUcRSrzXeN5zAqq8IanGunJlI7E7wRA9TY/R+MmnqUZQe8nfFzdryd6pfSow6BL1veQNMS8oYErdzUxe5JDsDF8IkT3WHvLE7EjBkeXhHqP6smfRh6PO5w0zXGp8oNLfSUwSt5HQplJz/RK3/tT7ahV+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB3451.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:14b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 06:38:30 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1%6]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 06:38:30 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Jessica Yu <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 6/7] modules: Add
 CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
Thread-Topic: [PATCH 6/7] modules: Add
 CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
Thread-Index: AQHYEQPri54wm9k2kUic7oR3m4zr7qx0PdwAgACexIA=
Date:   Wed, 26 Jan 2022 06:38:30 +0000
Message-ID: <b49235ef-1fc3-7b8f-7e23-79f461d83e18@csgroup.eu>
References: <cover.1643015752.git.christophe.leroy@csgroup.eu>
 <848d857871f457f4df37e80fad468d615b237c24.1643015752.git.christophe.leroy@csgroup.eu>
 <YfBnNuXpR2l2AuCP@bombadil.infradead.org>
In-Reply-To: <YfBnNuXpR2l2AuCP@bombadil.infradead.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77b3bc4d-fabc-449f-b2dd-08d9e0967767
x-ms-traffictypediagnostic: PR0P264MB3451:EE_
x-microsoft-antispam-prvs: <PR0P264MB3451D227325A69A00E6EA0B1ED209@PR0P264MB3451.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fY6Smy7HuhLdPWgiYKvvFrUnD+UTjaLkpJn1J+/zMiw0zq+ecw7vnz1cY5EChTrw4ZLP4BSoBnNggTv4eUUHh0/WW7geGDy6Y492uW0aqJTZeP80Zyy/U3B5MBJ8STqfXwwOq528KV2MSqjk7Eu4SzL/YdwKLwnJ3b2+uTEuN4myX0KTAbGD/6iLciob3pm9ZnbP7yorEsW5wkM9wn1oNxVAl4OIFHPisTMFQOopajwcV3Ou17FOqm/APlNkOH8b9dvf+b9/xP+XGO+XCt9NplLdRAxolL6IF7xMMsnG8e792xBwRJU00xgyjNPozkzHsCiXinhnKTHvkyi/FWFCfvKcp1o0kho+G2PaIg3YJL6G24xDicw+vBJPFWNFVGVy84CXluRdM+EOJofTzCvFbR/oqyanqvNuUHVq9W8nVZxQcaw8r8SVTwP5v/1IWfLUGGkdzD7fboMgRu90FQ+xh3bwgv0ZO8UBEj9ziwQxGOkwdglt+2hrRovrd4sXyZ+eo/XN+/glvIQvZx8TCIEHrtah6U8BsNOtkw3mPWxmcaV6eCOxqq2lOwYVdPkSHVc1es3KR6Q8IiIKqTO+w+n8Jj39/b99aPfJ+fAVrtLwUlgj+OPsNYLq10OYURlhkHITrt9EHZwExaqqZ6rnV8sjESNr3jvCg8g1WrLckSujfVLmywDf55lQTH9U7pTgsvPv63+kr5z1QGWzLvuUjV8aUH/0TZ1L1by8W8weAbzTI3HyBcxmzfWRazfP3lfBS8CB4do0DB2okMOUYr/lSu97oV+oJZk1cnRizd3l008GB1DrwIwnISxOHELYt23rKro2aabiRN4CtdJjBPicqzSSaJ3MYiQ9OMTy1rcfKCwnb7Pp8jUUmKdQ2Xh1zJ+5lJDt10sSZ8h/3mA2tMoW6MPbKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(122000001)(508600001)(966005)(6486002)(5660300002)(7416002)(44832011)(2906002)(31686004)(6512007)(36756003)(64756008)(8936002)(8676002)(66556008)(66476007)(66946007)(316002)(76116006)(91956017)(86362001)(6916009)(54906003)(31696002)(66574015)(4326008)(83380400001)(66446008)(2616005)(71200400001)(38100700002)(186003)(26005)(6506007)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjN3SHgwWURwMWcrZmRpVCs1alhyZzZNRnhlQ25lVmprT1V5Nm5SOEhzTHNH?=
 =?utf-8?B?N0RIUEJQek9ycTRxMzBNLzd4VGRFa2lObFZrbGRwbGN5d1Vwa01YYVBWaUJ3?=
 =?utf-8?B?M05pYnNpYVA1cEtBSk9ZS3V4cWxEMWlkVks2ZWhZendYWGlhRGtsZTJWZVhR?=
 =?utf-8?B?dy9aNTJ1cEU1STJkMlRDN0Q1TzFvMHpOanNsSWUwa3ZkbDJHZ3dGTW9KNm5X?=
 =?utf-8?B?QTBrSXJvWWtVVzRBOHo3YXZWakZEZ1ZWZWYwMmVJeHQrNEU0bkpTUERUYjJq?=
 =?utf-8?B?eENra3BDVmNjcUpNOUszaDFTa2dZSFB6VmtqaGpnNWtXeHVkVVorWm5uMS9D?=
 =?utf-8?B?WitDZkNTWk42VTQ2aDZKZ0hiTnQ4eDF5S2ROWFZuQlVtRzRGUW1nN2RqWVNQ?=
 =?utf-8?B?Z2FtTWlkSkM3U2UyT3dGSXNvQnJQaTFEMTcwd0QxUFNDU2YwcXdxVy9HZFlq?=
 =?utf-8?B?TkZSQWpMeWhyWnlUalFVTWdZeE92ZWU5OHhDZzhoMFBiOWxLaDNnbDVySHFP?=
 =?utf-8?B?THo5R0RVZHZhMEVlanovclNjdlFGanRjVDJFVW9uMUNZZjZwc2k2RnFwZ2p0?=
 =?utf-8?B?Y0FLcHREUDBlQTRZVkIrM01iditnVDhXTUIwSGRFeVhnYm14TnU5T1c3YklQ?=
 =?utf-8?B?eGJWWEo3T1l3RFI3Y1dUYVY1N1IxSTNNa21wcEVLUXJhT1U4Z01EemhrUEFx?=
 =?utf-8?B?RTkvSlBLUXdMekRTL25DaS95ZDBHTmhQK3QyNk1qbDRmUGUydFBjVmZ1YkV5?=
 =?utf-8?B?WDluVDhPM0xqQ2tGczJ2bEtoNGJjKzFzb3BqSFdyL0xLVEdDU2JCSHJyUGQy?=
 =?utf-8?B?S09SRmV1RE1pdFFJL280YlhWR3k4bTJnM0QxUDdsSko1eGFQL0kxa3YzNEtN?=
 =?utf-8?B?U3NTWVcwcTNFQkY5ZGc4SGNJZThVNUdoOWZud1pnMGVoRGhObkF6ZTVFbkdo?=
 =?utf-8?B?Q2d6NUdZeDJQZitRdnh5QTdXWUMxd3QxMWRqKy9ZeEduWWtNemhDY1ZyM0Rm?=
 =?utf-8?B?WmhGSWJodmU1Y1JUWElCd1BTektBUkw1Y3JoQnNvSWhMY01xY0xHekhEajZV?=
 =?utf-8?B?YnNlRGVodFBHMkt6d21FSjhjN21nVnh1MkViVWM3SHlzV3F5MUpmTUdNcTJO?=
 =?utf-8?B?THlyWW9jV3VHaDFjeEZEamZGaWl3RUtaK1ovMDVlNk84TzBIYnBuQjRUSXdt?=
 =?utf-8?B?R3d1ZW9EOC9vY2ZVOGxBaTBtMzI3aGNSVVdMenN4MWdjOTZVMjZmdDgxeFZD?=
 =?utf-8?B?cnFvOXorKzB2Wjl3Qk9HTlA1VFhhbGEyTCt3cjBUek43eXVYbFM0Z2J5TzNw?=
 =?utf-8?B?T3dRUnBSNmJJY3lNNGFmWXFnY3MwTGJRMW9OaDIvWElzT0NPUElTWXBtOEpJ?=
 =?utf-8?B?bDZOWitPKzBOUmllaTZPRS9tMkNFU0hpdk5FdGZjNVpHVkpiczVVMVFEVk85?=
 =?utf-8?B?NFhrbGtRbmVrVkxzek1QT0xFNXBXbFdpSlBoZTdkZ0g1Wlh4MzFhUzhaeGdE?=
 =?utf-8?B?bTFtVlV0WDBETkphWmlOZzFieFcyMzBYMDV5Smk5cnpiTnk0QkovWFNuUHVm?=
 =?utf-8?B?aXdTaVdGSW5Wdk9qZm9EcGExMDdkWjU5QWZyajVtNmNIY3ErcVUyOXVnT2xQ?=
 =?utf-8?B?bXMvMEY3bmZHWlQ3RnU3aWlKMWtxWEFsa1JEdUZINURvUDkxYXovWlVHQlcr?=
 =?utf-8?B?Vm5qZnRqam9Ic2pOVFhIcS8vN2pGczJlL3VrYnhTbzlMOXNEN3BsZWhYTkRy?=
 =?utf-8?B?S0dNUWlVbFV0UDVsUm52Qk82RFBFVHhLTTZGNElhTlJBbVlhdW0xcit6N2FY?=
 =?utf-8?B?Q1BjTEpjZk9YN1B2L0h0Tk4xMjZldjloRG8zOHV6S3ZiTkZYMCtoN0U4VXJp?=
 =?utf-8?B?aEx1UXVxTTViTWNMdUxSSGpJbnVjWnVrV3YvYmVRbnhZOStuczZJUXd1TlNW?=
 =?utf-8?B?WjYrVmlyS1dUZjJpWUZSQ2ZUYUY3SnVva3pudmM5ZnhHeEo5Wit4Y29udUJQ?=
 =?utf-8?B?Qkk1ZmVKMjNjU1prUUJqTzhybnVwNkh4bU5hRnNsZEFHcjVOekNvbUFiNy9M?=
 =?utf-8?B?bnVrdWxwb2h4RGVDNWtZajBRd2J0RjFueDAvQWlOWTR4M2R6WFBtaVRLemx4?=
 =?utf-8?B?S1ZENHFITkQ4ZkM1MHA0cHR1ZWF3QnpsRVBHREVuM3hOeGtUUmpPVGh5MEds?=
 =?utf-8?B?bC92c01YazFlcmVUY1lNRGI0eG5maExlbVYxWkVndmJYMHBvWmx6TG13dUNi?=
 =?utf-8?Q?9pfSTmklcEQ/IABTAJjjJ3IBTls7ckSB0/GP9oyW/g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1AAC6DC17686F04A922EA2975729582E@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b3bc4d-fabc-449f-b2dd-08d9e0967767
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 06:38:30.1386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UqEYRDkdo/d0tNaPatEW2eJqazrmiaqYFrMy4DM9cJP8Brvfp455B1UOn9zgWm5kgqOZ1MWyuGdy1vvmiRf8z2ACqeZv+oneY5jscjuXzp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3451
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDI1LzAxLzIwMjIgw6AgMjI6MTAsIEx1aXMgQ2hhbWJlcmxhaW4gYSDDqWNyaXTCoDoN
Cj4gT24gTW9uLCBKYW4gMjQsIDIwMjIgYXQgMDk6MjI6MzRBTSArMDAwMCwgQ2hyaXN0b3BoZSBM
ZXJveSB3cm90ZToNCj4+IFRoaXMgY2FuIGFsc28gYmUgdXNlZnVsIG9uIG90aGVyIHBvd2VycGMv
MzIgaW4gb3JkZXIgdG8gbWF4aW1pemUgdGhlDQo+PiBjaGFuY2Ugb2YgY29kZSBiZWluZyBjbG9z
ZSBlbm91Z2ggdG8ga2VybmVsIGNvcmUgdG8gYXZvaWQgYnJhbmNoDQo+PiB0cmFtcG9saW5lcy4N
Cj4gDQo+IEN1cmlvdXMgYWJvdXQgYWxsIHRoaXMgYnJhbmNoIHRyYW1wb2xpbmUgdGFsay4gRG8g
eW91IGhhdmUgZGF0YSB0byBzaG93DQo+IG5lZ2F0aXZlIGltcGFjdCB3aXRoIHRoaW5ncyBhcy1p
cz8NCg0KU2VlIA0KaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4cHBjL2xpbnV4L2NvbW1pdC8yZWMx
M2RmMTY3MDQwY2QxNTNjMjVjNGQ5NmQwZmZjNTczYWM0YzQwDQoNCk9yIA0KaHR0cHM6Ly9naXRo
dWIuY29tL2xpbnV4cHBjL2xpbnV4L2NvbW1pdC83ZDQ4NWY2NDdjMWY0YTY5NzYyNjRjOTA0NDdm
YjBkYmYwN2IxMTFkDQoNCg0KPiANCj4gQWxzbywgd2FzIHBvd2VycGMvMzIgYnJva2VuIHRoZW4g
d2l0aG91dCB0aGlzPyBUaGUgY29tbWl0IGxvZyBzZWVtcyB0bw0KPiBzdWdnZXN0IHNvLCBidXQg
SSBkb24ndCB0aGluayB0aGF0J3MgdGhlIGNhc2UuIEhvdyB3YXMgdGhpcyBpc3N1ZSBub3RpY2Vk
Pw0KDQoNCllvdXIgcXVlc3Rpb24gaXMgcmVsYXRlZCB0byB0aGUgdHJhbXBvbGluZSB0b3BpYyBv
ciB0aGUgZXhlYy9ub2V4ZWMgDQpmbGFnZ2luZyA/DQoNClJlZ2FyZGluZyB0cmFtcG9saW5lLCBl
dmVyeXRoaW5nIGlzIHdvcmtpbmcgT0suIFRoYXQncyBqdXN0IGNoZXJyeSBvbiANCnRoZSBjYWtl
LCB3aGVuIHB1dHRpbmcgZGF0YSBhd2F5IHlvdSBjYW4gaGF2ZSBtb3JlIGNvZGUgY2xvc2VyIHRv
IHRoZSANCmtlcm5lbC4gQnV0IHRoYXQgd291bGQgbm90IGhhdmUgYmVlbiBhIHJlYXNvbiBpbiBp
dHNlbGYgZm9yIHRoaXMgc2VyaWVzLg0KDQpSZWdhcmRpbmcgdGhlIGV4ZWMvbm9leGVjIGRpc2N1
c3Npb24sIGl0J3MgYSByZWFsIGlzc3VlLiBwb3dlcnBjLzMyIA0KZG9lc24ndCBob25vciBwYWdl
IGV4ZWMgZmxhZywgc28gd2hlbiB5b3Ugc2VsZWN0IFNUUklDVF9NT0RVTEVTX1JXWCBhbmQgDQpm
bGFnIG1vZHVsZSBkYXRhIGFzIG5vLWV4ZWMsIGl0IHJlbWFpbnMgZXhlY3V0YWJsZS4gVGhhdCdz
IGJlY2F1c2UgDQpwb3dlcnBjLzMyIE1NVSBkb2Vzbid0IGhhdmUgYSBwZXIgcGFnZSBleGVjIGZs
YWcgYnV0IG9ubHkgYSBwZXIgDQoyNTZNYnl0ZXMgc2VnbWVudCBleGVjIGZsYWcuDQoNClR5cGlj
YWwgUFBDMzIgbGF5b3VudDoNCjB4ZjAwMDAwMDAtMHhmZmZmZmZmZiA6IFZNQUxMT0MgQVJFQSA9
PT4gTk8gRVhFQw0KMHhjMDAwMDAwMC0weGVmZmZmZmZmIDogTGluZWFyIGtlcm5lbCBtZW1vcnkg
bWFwcGluZw0KMHhiMDAwMDAwMC0weGJmZmZmZmZmIDogTU9EVUxFUyBBUkVBID09PiBFWEVDDQow
eDAwMDAwMDAwLTB4YWZmZmZmZmYgOiBVc2VyIHNwYWNlID09PiBFWEVDDQoNClNvIFNUUklDVF9N
T0RVTEVTX1JXWCBpcyBicm9rZW4gb24gc29tZSBwb3dlcnBjLzMyDQoNCj4gDQo+IEFyZSB0aGVy
ZSBvdGhlciBmdXR1cmUgQ1BVIGZhbWlsaWVzIGJlaW5nIHBsYW5uZWQgd2hlcmUgdGhpcyBpcyBh
bGwgdHJ1ZSBmb3INCj4gYXMgd2VsbD8gQXJlIHRoZXkgZ29pbiB0byBiZSAzMi1iaXQgYXMgd2Vs
bD8NCg0KRnV0dXJlIEkgZG9uJ3Qga25vdy4NCg0KUmVnYXJkaW5nIHRoZSB0cmFtcG9saW5lIHN0
dWZmLCBJIHNlZSBhdCBsZWFzdCB0aGUgZm9sbG93aW5nIGV4aXN0aW5nIA0KYXJjaGl0ZWN0dXJl
cyB3aXRoIGEgc2ltaWxhciBjb25zdHJhaW50Og0KDQpBUk06DQoNCmh0dHBzOi8vZWxpeGlyLmJv
b3RsaW4uY29tL2xpbnV4L3Y1LjE2L3NvdXJjZS9hcmNoL2FybS9pbmNsdWRlL2FzbS9tZW1vcnku
aCNMNTUNCg0KQVJNIGV2ZW4gaGFzIGEgY29uZmlnIGl0ZW0gdG8gYWxsb3cgdHJhbXBvbGluZXMg
b3Igbm90LiBJIG1pZ2h0IGFkZCB0aGUgDQpzYW1lIHRvIHBvd2VycGMgdG8gcmVkdWNlIG51bWJl
ciBvZiBwYWdlcyB1c2VkIGJ5IG1vZHVsZXMuDQoNCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29t
L2xpbnV4L3Y1LjE2L3NvdXJjZS9hcmNoL2FybS9LY29uZmlnI0wxNTE0DQoNCk5EUzMyIGhhcyB0
aGUgY29uc3RyYWludA0KDQpodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92NS4xNi9z
b3VyY2UvYXJjaC9uZHMzMi9pbmNsdWRlL2FzbS9tZW1vcnkuaCNMNDENCg0KTklPUzIgaGFzIHRo
ZSBjb25zdHJhaW50LCBhbGx0aG91Z2ggdGhleSBoYW5kbGVkIGl0IGluIGEgZGlmZmVyZW50IHdh
eToNCg0KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjUuMTYvc291cmNlL2FyY2gv
bmlvczIva2VybmVsL21vZHVsZS5jI0wzMA0KDQoNCg0KRXZlbiBBUk02NCBiZW5lZml0cyBmcm9t
IG1vZHVsZXMgY2xvc2VyIHRvIGtlcm5lbDoNCg0KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20v
bGludXgvdjUuMTYvc291cmNlL2FyY2gvYXJtNjQvS2NvbmZpZyNMMTg0OA0KDQoNCkFub3RoZXIg
ZnV0dXJlIG9wcG9ydHVuaXR5IHdpdGggdGhlIGFiaWxpdHkgdG8gYWxsb2NhdGUgbW9kdWxlIHBh
cnRzIA0Kc2VwYXJhdGVseSBpcyB0aGUgcG9zc2liaWxpdHkgdG8gdGhlbiB1c2UgaHVnZSB2bWFs
bG9jIG1hcHBpbmdzLg0KDQpUb2RheSBodWdlIHZtYWxsb2MgbWFwcGluZ3MgY2Fubm90IGJlIHVz
ZWQgZm9yIG1vZHVsZXMsIHNlZSByZWNlbnQgDQpkaXNjdXNzaW9uIGF0IA0KaHR0cHM6Ly9wYXRj
aHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2xpbnV4cHBjLWRldi9wYXRjaC8yMDIxMTIyNzE0NTkw
My4xODcxNTItNC13YW5na2VmZW5nLndhbmdAaHVhd2VpLmNvbS8NCg0KQ2hyaXN0b3BoZQ==
