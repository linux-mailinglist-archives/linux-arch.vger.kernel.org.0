Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFAA49C361
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jan 2022 06:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbiAZFy7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Jan 2022 00:54:59 -0500
Received: from mail-eopbgr120084.outbound.protection.outlook.com ([40.107.12.84]:9920
        "EHLO FRA01-PR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233890AbiAZFy6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Jan 2022 00:54:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gvj3ILBt6GR8pDtLMBh6v4YugvkHVzGTnMIaYP4sZ7a/Xjj6pFXvRb17xz4A9Tum7bgi9W4M/GzTDrHN0dML0J2fWJXAyUOfC5YHOIQLpsioD1BZoLRUkBwMUMQVFNAtHne2DghVyaRxVmOcWK8iIOGBUxeBuMWxHTcXGgm5jw1kA1XML4+/ti9EXIdKwpRzi+pXDTX3WbZigiA5OFLvIqiVEPgaVoN0WQVggy6MleqlUp7hKGRMVp1GTF79wUPKP8aiga4a5N8RG7QlSWghwUey6BMeVZqCdKP+gkh4Rh7sAN6UJDM7qqZLxWGfI6G9NQ4OdhSiRVwcn6O+UGnU6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWSSKz0MztGAKg5d+AfEV210hM7g0WNGzCn/A1KEIks=;
 b=cIU3wINQxgzh5OcFTkPzs8Dd6wkosAVlK2xbd2nY/jMDanJuzpMsRDSZu5TiN6pSINiCt+67b0TbOg+moFc0tF94RD6kV1O+FrD/LrmL60VEYOW6lx8TEuApjmsHfoirzKs0eIK/GFfnPX4u5K8g49XPfK4DxlSoT9FtlotSHB0slDrrPumr3AGdCIQpzkJZZcXnV/ls3C7sM2vXCU0lC8aaYrQ3k5FRyd3nWjlf65+o551UWYgVob1+Yj4ey+bEGBorMZNHKyhEHDoczFGP1UjYnyPAOs1JqbyHgHed8tlBaAx+b7TT2wGNWbUpgW6S4nwMQ6ncOOvpf9ALLQOE9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR2P264MB0863.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Wed, 26 Jan
 2022 05:54:55 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1%6]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 05:54:55 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Jessica Yu <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 0/7] Allocate module text and data separately
Thread-Topic: [PATCH 0/7] Allocate module text and data separately
Thread-Index: AQHYEQPeal2Ru1Vo80yWM9wORGS9c6x0ON2AgACXlgA=
Date:   Wed, 26 Jan 2022 05:54:55 +0000
Message-ID: <68e18364-b904-4ac2-2bf3-504a0b147ecf@csgroup.eu>
References: <cover.1643015752.git.christophe.leroy@csgroup.eu>
 <YfBjBRFEbljfbrvx@bombadil.infradead.org>
In-Reply-To: <YfBjBRFEbljfbrvx@bombadil.infradead.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92e7f53e-5053-4702-515e-08d9e0906124
x-ms-traffictypediagnostic: PR2P264MB0863:EE_
x-microsoft-antispam-prvs: <PR2P264MB0863908ADA2CBB0A6AEFBDC8ED209@PR2P264MB0863.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XFDLBHhy+4J0bZCx7kC3JyVP69pYGk/XADk1QZsP40Hmc32UJFBJ7oRb4Bz9WsQJ/VXCZCctmy3VgaKRVh3V+x6/Iqq/bD16JeEp3ZLKVQjfAimv2TtZGn2ndCm1gvmV5OOFiVrnTUTvan4k+EuyZfh3RiyCUxOPGdoims9grvM7427yKtgOEK6vMnnhSIfhtecTdKM+q5uEu3kdiawcnPBdvWg5FcO3Hb5nSUJlpb/BLRjr9lnMGdRr8yydb03q14CwbPojV+TLi9rSn0JuP++NGqhzWcdo1ZKktU5ndBVkjn12zavfy4ZpXxdO0HjMyNwUkrHHza5t+db/seEShVlCYg2zgQJxIEMhpB0lZ+9M59gU45VmfSnFTzEl2cfAZnSixJ7z9KFawwaSNEnojWUsiZNj1i+YAllaJjhdxcuHX2zBAhMVLfWlP+t+bUdsZiiLqFKQ5B9bA+CU2JCxv0lrmiMV6nZQkQdW6zFzq3by5rgIAGy+nV2aEVO5cjcR88xCmmq6kjVJeOeULClHgcYRktKaZ9s4g8zg9hLtclumBJ/lG0uCr+GTQ4k3cEtBp+oGaXxcfzMMH7PlbBGmj2i0cjyzQIOL5hwFYlQQW/Hy4nPceJV2wJQqraxZnlm8FbAxVsf5+wdPw7W6N3YcoVakvK8D0oOc+rKbL7IzYAtQ7ffjlrRuWtY2VTrsUDevYlDub0OHAmS7KYgOzhQ6iqgglRuXxykDMGFN5RJC2FIGNEEIB4ZZgD9MVpBvpGmVV6L+C8nNetvxQxsDMnc3mg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(54906003)(86362001)(71200400001)(2906002)(8936002)(91956017)(38070700005)(38100700002)(508600001)(31686004)(2616005)(122000001)(8676002)(6512007)(66476007)(36756003)(76116006)(5660300002)(44832011)(4326008)(31696002)(6506007)(83380400001)(26005)(64756008)(6916009)(186003)(66446008)(66556008)(66574015)(316002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0dTS0VPbjhJOFg5R1VXSXE4amxiT0RxMHlQUjhOazFLcktmZDVuQTAzRVJJ?=
 =?utf-8?B?dTlWOUVkeUFGVEl6N0htK2o0YkNYVnBqZWYwdU1yUGN0ODJCNjFINUthalYy?=
 =?utf-8?B?MjRFR3F2WTdsS2ZNS3dHbStXaHlZQWlmbzFZSllTQXlGU3dDcXgvWUt0bzFu?=
 =?utf-8?B?c2N6ampTMnZFbkdHK3ZqelY4bTdrZ2VFS1lKby9OVDdvQno5b2xiZHgyVnNk?=
 =?utf-8?B?eURjeXVVNHEyVDVtZ2VPWCsrRnpLR3ltY2pUYWJLQVVCVWtHTlc2eDBGWFEw?=
 =?utf-8?B?UnhML2p5R1BtMjI4RzMyN09xaHNiSDlIeWJ2cjJlT2h1TzFTeVd0VWQvVXA1?=
 =?utf-8?B?cEVoWmFVRnNiZ0FIMElEOEVTblNuQVdSVVZ6RjFUWG1pMEdoWDBaUTQ5dy9t?=
 =?utf-8?B?U3lyOG1vMGlyTk9KSGJBMFdHL2dZUU02bFFmQ1AvYW5mc2VtQXBLeE16SXgw?=
 =?utf-8?B?NWpabFdsODVSSGVhM3p5Z3FhbXA3NHlSNWN2WFpqVG1rdTM0NHpBR1A2cXNy?=
 =?utf-8?B?TVU1ZU9mSTZnNmtlYmVSYzVDOGJWQzlyWDJQcFhwcFNCVFVHMG0vRkZ5b0F5?=
 =?utf-8?B?eG9KNVFsWmh2OE9oTXNNTW51cVRVYUw1YmFWZmxQc2FHRFpxcDJzZ1pxaXBS?=
 =?utf-8?B?OTNNcjdYUlZISnFlZUV4WXQ3QlJPcTc0c2tpalIrRlFtVVhLSmJNNHdQNExE?=
 =?utf-8?B?VUV1UFJVbWxsM3VJeWRldW4zME9zODBYRkExUGNaU1ptbzJwVk5HKzlZTWQ2?=
 =?utf-8?B?MmhUUUs3aVZsWE1VeVFWb2hxYlZzR0dnTmJKV1RkK29DNHdJUTBlRjMvSE40?=
 =?utf-8?B?VUg2UlF2RG5ITVhSTHFGenRLOFl1SEVoVUdUZkM2QWc2eWJJOTNMWGhuSlhH?=
 =?utf-8?B?Y0RwZXFWckxDdWtodzNUZ1lNM0M5SkVIS096UmFZUkRRQWp5UTdUc1F6YVY2?=
 =?utf-8?B?MDRTU1BTTWJLNDBKdjFMcE5tWjVjL2paRSt4Ymlia0t6N1lNUUREaFdKN3Ir?=
 =?utf-8?B?QVR0Q29KSUZEWmhGQkhuUTFORFozeWNtYTVQT3FnTFIvWUNEYmQ1YXorMFlR?=
 =?utf-8?B?cGlaVyt2aU5VN21ocGJwY0JQM2JqNk12bmU3K3hVSUN5R1NXMENNVmlJT3Ex?=
 =?utf-8?B?bit3SmZrUHpmd3IyQ1cyU2JmZXc3MVpOTFBnbGRkMlBwbVRJSVRmYjM3NDN2?=
 =?utf-8?B?aXQzWjlEQndVR2QxeUR3WXRIbXovdTc1R01lY1ZrcWhzUzdDQVJKRHpFTlhy?=
 =?utf-8?B?aGxSdUFaL1Vud2RXcld5a25MNmtYZUYyb0ZITXZqZGo3WHE1VEdMWDQrVE9C?=
 =?utf-8?B?SW1QeE5abDdXZ0hBV0plUFdsd0RyNDkzSjhqZnVlaUVObC9uQ1MxZHY2N1pT?=
 =?utf-8?B?S1h3eE1sM1ZqK3k0OGlaeVZsa1ZMNmVzajJTRVVoNjlXV0RyNE5oQXh0L1gr?=
 =?utf-8?B?M29DUy9tVnZ4NGFtVXRQTVVHelYxaGNoQms4eWV1ZVRKMitwbWl2WkR4TWl1?=
 =?utf-8?B?S2ZxSDVCanNSZWo4azVMbVcza29lYW9jSDBJK1dHM3kveHVTRngyOGVET3NQ?=
 =?utf-8?B?NjZGL2ZiRWUwc2NNa0RyTitjb2c5dFNPRkUrTkRUSVI1N0o2TFdMUmJvK24w?=
 =?utf-8?B?Tys2c2dJZ1RoZzhYd0lDdkN6N0VwbzgxZS9FaEFEbC9KcWt2bG5IZWwrZTAz?=
 =?utf-8?B?UGZ1KzNHRk5JejdyZmpjUVFCQmZ3MHJ0cS9yUXB1M3prZlNFdTN4eU4yWTRM?=
 =?utf-8?B?RnhxTFVxeFpIbDA5MXYrTll4Ylh3Tk1pVkZnczJ3ODRmNjFZaHpnT2dCdDls?=
 =?utf-8?B?YmpwaFBKWTlQN3VCUzJHbEcrSWdxVTRJZ0ZaYm1XaWNpcDhVd3VsMFB2eWtK?=
 =?utf-8?B?b0JkaTd3VTJqeWhQZWV4SDRIQVNZaXVzZFZwNEJkVytIdHFQTklBL2ZJSGN1?=
 =?utf-8?B?OWVhUTFVTTlkTG40blBQU0ZUWnBac3JDUzNpZ3RKQWRmRlYzMVV1c25GWTV2?=
 =?utf-8?B?dHBSYXp6Tm1wM2JCMzUxVXh4NVdFM2thVENpbFJ6TFlXRS9IdkFINGlrVTZ4?=
 =?utf-8?B?eXVNU2U5N1pnS3V4SGFjOFNvbzdYT1pKekpwWHJiOUdmcUVrdFpJQi94Wi9G?=
 =?utf-8?B?M2ZxSWQ2NTV3ajAyQm5TSmkwWkdjcGhsczhCNUhaTmNBOWhVUTdYakhqbThS?=
 =?utf-8?B?VmR2N25VT0kzT1lscHRtZDVGMW84YmhBU21qR2VqRFZ2cXgzUFNFcXNWbTh2?=
 =?utf-8?Q?ePuvRUG2xVTXoAw71Jzs20uV8XnFhFEvi5DWx5/pfM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DB86BE173B5184995B5A97ABA97F1C1@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e7f53e-5053-4702-515e-08d9e0906124
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 05:54:55.8537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mVHRlbCyO+gZxDYnm0HAbPzXrswZoFgVtw6sLjHuKKqithr52lpOToYAtDuD0x9uZ/4sU5+MpYaJks9VPQ6vS5dYb9O503nmPImGWd8hAxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2P264MB0863
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDI1LzAxLzIwMjIgw6AgMjE6NTIsIEx1aXMgQ2hhbWJlcmxhaW4gYSDDqWNyaXTCoDoN
Cj4gT24gTW9uLCBKYW4gMjQsIDIwMjIgYXQgMDk6MjI6MTFBTSArMDAwMCwgQ2hyaXN0b3BoZSBM
ZXJveSB3cm90ZToNCj4+IFRoaXMgc2VyaWVzIGFsbG93IGFyY2hpdGVjdHVyZXMgdG8gcmVxdWVz
dCBoYXZpbmcgbW9kdWxlcyBkYXRhIGluDQo+PiB2bWFsbG9jIGFyZWEgaW5zdGVhZCBvZiBtb2R1
bGUgYXJlYS4NCj4+DQo+PiBUaGlzIGlzIHJlcXVpcmVkIG9uIHBvd2VycGMgYm9vazNzLzMyIGlu
IG9yZGVyIHRvIHNldCBkYXRhIG5vbg0KPj4gZXhlY3V0YWJsZSwgYmVjYXVzZSBpdCBpcyBub3Qg
cG9zc2libGUgdG8gc2V0IGV4ZWN1dGFiaWxpdHkgb24gcGFnZQ0KPj4gYmFzaXMsIHRoaXMgaXMg
ZG9uZSBwZXIgMjU2IE1ieXRlcyBzZWdtZW50cy4gVGhlIG1vZHVsZSBhcmVhIGhhcyBleGVjDQo+
PiByaWdodCwgdm1hbGxvYyBhcmVhIGhhcyBub2V4ZWMuDQo+Pg0KPj4gVGhpcyBjYW4gYWxzbyBi
ZSB1c2VmdWwgb24gb3RoZXIgcG93ZXJwYy8zMiBpbiBvcmRlciB0byBtYXhpbWl6ZSB0aGUNCj4+
IGNoYW5jZSBvZiBjb2RlIGJlaW5nIGNsb3NlIGVub3VnaCB0byBrZXJuZWwgY29yZSB0byBhdm9p
ZCBicmFuY2gNCj4+IHRyYW1wb2xpbmVzLg0KPiANCj4gQW0gSSB1bmRlcnN0YW5kaW5nIHRoYXQg
dGhpcyBlbnRpcmUgZWZmb3J0IGlzIGZvciAzMi1iaXQgcG93ZXJwYz8NCj4gSWYgc28sIHdoeSBz
dWNoIGFuIGludGVyZXN0IGluIDMyLWJpdCB0aGVzZSBkYXlzPw0KPiANCg0KMzIgYml0IHBvd2Vy
cGMgcHJvY2Vzc29ycyBhcmUgc3RpbGwgbWFudWZhY3R1cmVkIGFuZCBhcmUgd2lkZWx5IHVzZWQg
aW4gDQplbWJlZGRlZCBwcm9kdWN0cyBsaWtlIGludGVybmV0IGJveGVzLCBzbWFsbCByb3V0ZXJz
LCBldGMgLi4uDQpPbmUgb2YgdGhlIHJlYXNvbiBpcyB0aGF0IHRoZXJlIHBvd2VyIGNvbnN1bXB0
aW9uIGhlbmNlIHRoZWlyIGhlYXQgDQpkaXNzaXBhdGlvbiBpcyB3YXkgbG93ZXIgdGhhbiA2NCBi
aXRzIHZhcmlhbnRzLg0KDQpJIGZvdW5kIHRoZSBlZmZvcnQgcXVpdGUgc21hbGwgY29tcGFyZWQg
dG8gdGhlIGJlbmVmaXQgaXQgcHJvdmlkZXMuDQoNCkNocmlzdG9waGU=
