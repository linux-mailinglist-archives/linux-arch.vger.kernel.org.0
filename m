Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375FC4F9631
	for <lists+linux-arch@lfdr.de>; Fri,  8 Apr 2022 14:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbiDHM4A (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Apr 2022 08:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235989AbiDHMz6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Apr 2022 08:55:58 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120073.outbound.protection.outlook.com [40.107.12.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8204D34B8F;
        Fri,  8 Apr 2022 05:53:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAb/JmodloDpV3/annETMl7Jq48m88h1YLWvtulVaVUK5qBL5aKX9epWS2smN/MHM48FGhABUZqge074ylEzbQ4NSeVIQg2JYYNUoe1mKdKoMZqjzRvtYkWdu/s8Ci6+MwfiBNZZgb7UMEjAg0FvblTgiTg2E/g8bixaBqFcq3XYRcAboBP22lyHwtMAMZ0PLQ2axa0xgIrmDg91ErP/ofskZUJIrGIdPJoRDexXVQEc0cwSy2QahFDVJbKtZH/iJhY7tyljcFccoisU2IZeYXKVFGLfvBVxv+s1HxFgNNqZCygoncjigoOTndw3W/diMFoS8mzGvJJswHgROVMHOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6i0RBb65DOkZIgRJkAkyN/jPD321z0F2UcsUnB0iWyw=;
 b=G43NBqLCmUrgAlPOcD67n926H3z2cOePMpdgD+VMAWcQC7cBfDfEU0Y2eKNlaVcEBuGN8xbcTFNDLFzJIjczo9VucKp2tP3L96ondD4UGEGrvbx7u6p3NW5knseLBkJUPC5nbxpYLsw3tHsQFyXhUXUg7XXyidCgP3xYcJyOSab9eBzySh+nnbvOa8SGnxyTCT7IV3+E3e8LzS/EAwKhkHfIoS8ihdyL1driGvptIV6scg5Pou01A7XkQU3PFqe2DH7SRlCs6ud5ZGI8QtIfGirmbXFISxJVRiPoFCLKZR4JE8QLIT5854bp5Lyrl86hz0YFKVj/RlTaHrrOLovfbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2153.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:16e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 12:53:50 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::59c:ae33:63c1:cb1c]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::59c:ae33:63c1:cb1c%9]) with mapi id 15.20.5144.025; Fri, 8 Apr 2022
 12:53:50 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Paul Mackerras <paulus@samba.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V4 2/7] powerpc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Thread-Topic: [PATCH V4 2/7] powerpc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Thread-Index: AQHYSmwkEA9bNmVUZ0G7LAapbHwGSKzl+ogA
Date:   Fri, 8 Apr 2022 12:53:49 +0000
Message-ID: <e860f404-af69-aebc-c5eb-8822a585e653@csgroup.eu>
References: <20220407103251.1209606-1-anshuman.khandual@arm.com>
 <20220407103251.1209606-3-anshuman.khandual@arm.com>
In-Reply-To: <20220407103251.1209606-3-anshuman.khandual@arm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e310db21-9b34-4fd4-4fc4-08da195ed402
x-ms-traffictypediagnostic: PR0P264MB2153:EE_
x-microsoft-antispam-prvs: <PR0P264MB2153ACD69DD161FED7766089EDE99@PR0P264MB2153.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KtI2TzImwGcbQstOe4dOXawLWMr8s54DLpMifAWUX675okwlNcGRnGoW5VpzVgeC5GhYbXlvX7U2514/yE6/IkkoZWxb0GMAP2vJFHjHQTLUvj8m6I/GxMd4TI9k2AH6nkcC/W7JrmcOUTMSX/PXhrLxAOr4S0eFm/Ag5iE2ufOZw9uZkv3G6us0roseEpbhDoY9amfJKfE1FcV9qMToXopXPlJeGsAOTVpHk+uQ+RiFaEwcm18MvKuYF9ScGPXX7y983xZjYFAIozAKaMaLlQGoaeuQWDY+VXJ2pHLJlTb+NaMX82rgWG2Xoy/ipdwUTFibgQYVJVtFqKTsdRb+BZ0OaVFB1PZ1gqJYfte+VavShdC0jmiXOyQk8Qo2thH2x9ulttX8lpjr8/wViJpJcJgavvAocEQG69GANYj2r9n2r4ClmlPNfj5UCShznMeOuMYYxpLLKP1aV9SlfdZNsymXBABjgnAkTO4RCbwflWrhRrSWG0HnCdemZWy5LHJyXiFbm5ydyfGX10s0N9Qcb2owjmf5TZA0sibCnLpfyxbfAFPSbAsJ1YaGXMD5nFkkA8FEdlXMGBNWaeoDCT3t06gGOeECg1cRO5aLa7a0pW9tIUmOarlLqGDAtbUG/NtrCLULmSSxu5Fe2haQaq1aXbe2IX6tmLiY9ZSrPEN/mG3F97Dffq2qNM+6mxhfzDhHPDYBTH6OSD0DrPx1hh0M+C7QRYOFRuAV7b1LCXVtu71OG9STwXkNe6Hgz7u8wJslRZx0IjAzm6g+EfA6w0PCvERH8F9TQTrzcJcSVeTeOYy3SlOexb6bpwqGcYXv5Y6gd300r4BLlTAfG4J71vvQkOmunkdwV4r1NsaHel1S7HQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(7416002)(38070700005)(66476007)(66556008)(6512007)(66946007)(86362001)(36756003)(31686004)(5660300002)(44832011)(2616005)(6486002)(6506007)(508600001)(966005)(71200400001)(186003)(76116006)(122000001)(26005)(31696002)(91956017)(38100700002)(83380400001)(110136005)(66574015)(54906003)(316002)(66446008)(8676002)(4326008)(64756008)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1JITkNtSGp6RU5LRG5XLzAxVHNiSmVNdWN2dDFlcmJKNDV6UFBEWHpha0I0?=
 =?utf-8?B?TWp4WGxvTTltcFJkSjVzUHVnckhQa243UWtMVGxoaWFEKzJHd0ttNlJRT3Rp?=
 =?utf-8?B?OG1RZXZ3UkVNd1ZOSVVrQTJJSDdzdStXSE1iV3hCbUthV0tVSzNtNzJSZkpm?=
 =?utf-8?B?R0JTNkxucVBDbS8zQnFyampXQzd1L0U3ZXZObDErY3BORm1ra3ljR1V3R2tV?=
 =?utf-8?B?b1VvSFh5R05mSWRXMjJmYmxMSndtZS9WTXpFMEVKbitteGxveUg0VnFvQTU2?=
 =?utf-8?B?QUZFZWlQcjhaMC8xbHNtZGMvRmNueEE5TS9WVTI3ckhVWTZyNnBkV0lsNXhh?=
 =?utf-8?B?ZEUxNDJWZXBTdTdVQUk5Y2l0cGR2Y1kyOXBkaUNrTWVhU2E3dXJ6eExobUpO?=
 =?utf-8?B?N01IWFZDMDVnajJRU08zNm9TN1hlSVJqSHFuaHdpNE8vMUdDK1lKdWdQNEhC?=
 =?utf-8?B?MXJsQWh5SGVzc2FiTFhpdFZERCtBQ1ZNdGhKczY2OHNiNkJUdVN4dXdkRXRp?=
 =?utf-8?B?UnljQnRRQlIyOVFYS2lVRllwSTdweHhYR1Zib2t5aEtQZVZPTElpVDFBMFVi?=
 =?utf-8?B?NmhqK2FNQVF0anBxaTZDRkMwU2tSYUptQlJPdFE2WGFmOGk4SUhGNVlFclZs?=
 =?utf-8?B?YVhsOXEvZ2VVUUxJTi9CNTYzWHRWZE1CcXBiOVpmUEVhemV6U3lGSmVhZUN0?=
 =?utf-8?B?VTducitPaE93SkF5UzNaL0U0aGllZEJvL0dFRUZZVHRPOUgvZnpjWDdCeTZk?=
 =?utf-8?B?YUJRNXFjYk5JcEVDL0VVMGI1YlU1SEhtRW5qb2lQTlY3K25vWlA1M1pVdm4r?=
 =?utf-8?B?QUxJazVvcThtU1FiWnNUNWdFZXpZWDR0bEdDWkUraDNUZ1l2R3EyZVdQTlNq?=
 =?utf-8?B?bWpOMFZqWm5iWWk4WWRLU01BaEZQeml4Nml4RjhZWUppSVo0R0QzSFF6cXFp?=
 =?utf-8?B?Y1BDSk5EWUduc3JyeXFiNEJYMGRueWlhUk84ci9lZkhsMGlWRXg1KzZHNmp2?=
 =?utf-8?B?OFh0T0ZDalBNU2RDT1NPNFNJMTdDYmkrYkpvZVVCTnBqVXJveFc4TDh5enZ6?=
 =?utf-8?B?VHYxU1N3enNxbHZ0WmVJLzRhWnlmN2RqL08wOEpPRE9ONVdBVHlUV2xheEdB?=
 =?utf-8?B?NkNKK1hDSkVLSTJtUXF3THM3cWphVmxhanFMckpWNlVNaTUzR0VFbGNYVnk0?=
 =?utf-8?B?d2RzNkp1MGxXRTYwR2UvYk55S2gwSjB6MzJPZlZFRTVERW5zTEF1M2orNzFq?=
 =?utf-8?B?dVZ0cDd1TFl6VVZqb0hhekROYlZnL3dtQUZwTFh5VXdmQmlLa3ZxME8zS0xP?=
 =?utf-8?B?WldaQTRsd2ttOXpaajFLWFRtTms4N1V4M2ZodFpwZlZsK1A4U2RPbnk0VGF4?=
 =?utf-8?B?RGNzcEtaeTBJaEFtOW1hbG80VG5VZWhSWmtwYlk2ZnZMNlhTdmVsTUdOMExz?=
 =?utf-8?B?dnFpbDBlWUZYa0d6VUY1YTM2L2dlYTVhZU9wL3RIbTZ6VUdSNGF0TFpyazM2?=
 =?utf-8?B?TnQ5RTU2VUdsL0srWDc0TUZXMGV1OHlsZm5hYlIwK2tnQm5nengzM0xnTHJ1?=
 =?utf-8?B?WTA5Y0RlckxqTmpWekxWMGRJcGtFZVJucnVBbXNBdEtnSGZYV3dMSVloUTUy?=
 =?utf-8?B?ZUFOUE5IdTZ0YmcyTnV3a2tkdjloNFg0NTczMFJTZ1Z3WE1YWGdPeE0rVXlN?=
 =?utf-8?B?em5zUXpZUDVtclcySmVHSnVJeFhGOHFKZGw0TjZ0V1NhNG54RFNZUUJyOXBP?=
 =?utf-8?B?Z0ZyS0FyOHMxRkd4UldMYTNkQjNLZ09Bbmo0OFNicUJqakxhKytkOU12U2JB?=
 =?utf-8?B?NzcxaG9kYjV6UXl2QllGOGNNTnMwaXBmZnBlcmJtajFQZTZuVEpZdGlqdkc5?=
 =?utf-8?B?Uk9EU3BwUmtTT0JMQkhObzg1aGlrbGpqcE90Y29IczBvQTRPdUZaVFNzb1Rt?=
 =?utf-8?B?N204VU0rVWxBbVpPOHhDSllEcXFLSWhJTEd3ZHRhQUhPVTdrcjBpUVNHWEFM?=
 =?utf-8?B?RzNqa01yazgraDNUUjRFYTBlemVBNVpCY0llMVo1OG1aVDJyL29GNGVpSFpM?=
 =?utf-8?B?S2NhbWxSM2xBTTE5ejRWaTJqRVRjT0RvK1VqWDdTYnNTeWJINUxBbWpZSzZE?=
 =?utf-8?B?OHpOUld0ZkVxcE9IZGlCUkRqM2VTNVpQMlBJRjU1Qy93SWc5S2V2M0RYWDRp?=
 =?utf-8?B?dEw5anR2TTZzaHh2T2VqSUJ1aG56bFdVQzZJaXVoM0R0Q25zVkI4aHBmTHZB?=
 =?utf-8?B?bytzaDFVanVQUjh5UG40S1dmYVJjRkFZdDgvZmYxVVRYaFdKSWNZWGNOV0VE?=
 =?utf-8?B?N3JNNWhJV1pQeDQ2aFZNT3ByZnY4MTVLTklaK280ejBJWU1hNnlXT1NIdzNv?=
 =?utf-8?Q?NACpqWPWc5DoHuBLDSlKIgjXgYTnty5k/T6Ms?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <761E843D7CDF224D842AC58FF86F28EE@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e310db21-9b34-4fd4-4fc4-08da195ed402
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 12:53:50.0263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TKeRoXFM8IValQwNct1shC9/XXHj6wF+/Jj9ChJiMDu3o6xrLtKSDHu8YYh41Sx073AzOAE8xW5Qt1u/zi3FvRHjCsHwtzWKOfrgqahJfAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2153
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDA3LzA0LzIwMjIgw6AgMTI6MzIsIEFuc2h1bWFuIEtoYW5kdWFsIGEgw6ljcml0wqA6
DQo+IFRoaXMgZGVmaW5lcyBhbmQgZXhwb3J0cyBhIHBsYXRmb3JtIHNwZWNpZmljIGN1c3RvbSB2
bV9nZXRfcGFnZV9wcm90KCkgdmlhDQo+IHN1YnNjcmliaW5nIEFSQ0hfSEFTX1ZNX0dFVF9QQUdF
X1BST1QuIFdoaWxlIGhlcmUsIHRoaXMgYWxzbyBsb2NhbGl6ZXMNCj4gYXJjaF92bV9nZXRfcGFn
ZV9wcm90KCkgYXMgcG93ZXJwY192bV9nZXRfcGFnZV9wcm90KCkgYW5kIG1vdmVzIGl0IG5lYXIN
Cj4gdm1fZ2V0X3BhZ2VfcHJvdCgpLg0KPiANCj4gQ2M6IE1pY2hhZWwgRWxsZXJtYW4gPG1wZUBl
bGxlcm1hbi5pZC5hdT4NCj4gQ2M6IFBhdWwgTWFja2VycmFzIDxwYXVsdXNAc2FtYmEub3JnPg0K
PiBDYzogbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogQW5zaHVtYW4gS2hhbmR1YWwgPGFuc2h1
bWFuLmtoYW5kdWFsQGFybS5jb20+DQo+IC0tLQ0KPiAgIGFyY2gvcG93ZXJwYy9LY29uZmlnICAg
ICAgICAgICAgfCAgMSArDQo+ICAgYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL21tYW4uaCB8IDEy
IC0tLS0tLS0tLS0tLQ0KPiAgIGFyY2gvcG93ZXJwYy9tbS9tbWFwLmMgICAgICAgICAgfCAyNiAr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgMjcgaW5zZXJ0
aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBj
L0tjb25maWcgYi9hcmNoL3Bvd2VycGMvS2NvbmZpZw0KPiBpbmRleCAxNzRlZGFiYjc0ZmEuLmVi
OWI2ZGRiZjkyZiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9wb3dlcnBjL0tjb25maWcNCj4gKysrIGIv
YXJjaC9wb3dlcnBjL0tjb25maWcNCj4gQEAgLTE0MCw2ICsxNDAsNyBAQCBjb25maWcgUFBDDQo+
ICAgCXNlbGVjdCBBUkNIX0hBU19USUNLX0JST0FEQ0FTVAkJaWYgR0VORVJJQ19DTE9DS0VWRU5U
U19CUk9BRENBU1QNCj4gICAJc2VsZWN0IEFSQ0hfSEFTX1VBQ0NFU1NfRkxVU0hDQUNIRQ0KPiAg
IAlzZWxlY3QgQVJDSF9IQVNfVUJTQU5fU0FOSVRJWkVfQUxMDQo+ICsJc2VsZWN0IEFSQ0hfSEFT
X1ZNX0dFVF9QQUdFX1BST1QNCj4gICAJc2VsZWN0IEFSQ0hfSEFWRV9OTUlfU0FGRV9DTVBYQ0hH
DQo+ICAgCXNlbGVjdCBBUkNIX0tFRVBfTUVNQkxPQ0sNCj4gICAJc2VsZWN0IEFSQ0hfTUlHSFRf
SEFWRV9QQ19QQVJQT1JUDQo+IGRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20v
bW1hbi5oIGIvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL21tYW4uaA0KPiBpbmRleCA3Y2I2ZDE4
ZjVjZDYuLjFiMDI0ZTY0YzhlYyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9wb3dlcnBjL2luY2x1ZGUv
YXNtL21tYW4uaA0KPiArKysgYi9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vbW1hbi5oDQo+IEBA
IC0yNCwxOCArMjQsNiBAQCBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGxvbmcgYXJjaF9jYWxjX3Zt
X3Byb3RfYml0cyh1bnNpZ25lZCBsb25nIHByb3QsDQo+ICAgfQ0KPiAgICNkZWZpbmUgYXJjaF9j
YWxjX3ZtX3Byb3RfYml0cyhwcm90LCBwa2V5KSBhcmNoX2NhbGNfdm1fcHJvdF9iaXRzKHByb3Qs
IHBrZXkpDQo+ICAgDQo+IC1zdGF0aWMgaW5saW5lIHBncHJvdF90IGFyY2hfdm1fZ2V0X3BhZ2Vf
cHJvdCh1bnNpZ25lZCBsb25nIHZtX2ZsYWdzKQ0KPiAtew0KPiAtI2lmZGVmIENPTkZJR19QUENf
TUVNX0tFWVMNCj4gLQlyZXR1cm4gKHZtX2ZsYWdzICYgVk1fU0FPKSA/DQo+IC0JCV9fcGdwcm90
KF9QQUdFX1NBTyB8IHZtZmxhZ190b19wdGVfcGtleV9iaXRzKHZtX2ZsYWdzKSkgOg0KPiAtCQlf
X3BncHJvdCgwIHwgdm1mbGFnX3RvX3B0ZV9wa2V5X2JpdHModm1fZmxhZ3MpKTsNCj4gLSNlbHNl
DQo+IC0JcmV0dXJuICh2bV9mbGFncyAmIFZNX1NBTykgPyBfX3BncHJvdChfUEFHRV9TQU8pIDog
X19wZ3Byb3QoMCk7DQo+IC0jZW5kaWYNCj4gLX0NCj4gLSNkZWZpbmUgYXJjaF92bV9nZXRfcGFn
ZV9wcm90KHZtX2ZsYWdzKSBhcmNoX3ZtX2dldF9wYWdlX3Byb3Qodm1fZmxhZ3MpDQo+IC0NCj4g
ICBzdGF0aWMgaW5saW5lIGJvb2wgYXJjaF92YWxpZGF0ZV9wcm90KHVuc2lnbmVkIGxvbmcgcHJv
dCwgdW5zaWduZWQgbG9uZyBhZGRyKQ0KPiAgIHsNCj4gICAJaWYgKHByb3QgJiB+KFBST1RfUkVB
RCB8IFBST1RfV1JJVEUgfCBQUk9UX0VYRUMgfCBQUk9UX1NFTSB8IFBST1RfU0FPKSkNCj4gZGlm
ZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9tbS9tbWFwLmMgYi9hcmNoL3Bvd2VycGMvbW0vbW1hcC5j
DQo+IGluZGV4IGM0NzVjZjgxMGFhOC4uY2QxN2JkNmZhMzZiIDEwMDY0NA0KPiAtLS0gYS9hcmNo
L3Bvd2VycGMvbW0vbW1hcC5jDQo+ICsrKyBiL2FyY2gvcG93ZXJwYy9tbS9tbWFwLmMNCj4gQEAg
LTI1NCwzICsyNTQsMjkgQEAgdm9pZCBhcmNoX3BpY2tfbW1hcF9sYXlvdXQoc3RydWN0IG1tX3N0
cnVjdCAqbW0sIHN0cnVjdCBybGltaXQgKnJsaW1fc3RhY2spDQo+ICAgCQltbS0+Z2V0X3VubWFw
cGVkX2FyZWEgPSBhcmNoX2dldF91bm1hcHBlZF9hcmVhX3RvcGRvd247DQo+ICAgCX0NCj4gICB9
DQo+ICsNCj4gKyNpZmRlZiBDT05GSUdfUFBDNjQNCj4gK3N0YXRpYyBwZ3Byb3RfdCBwb3dlcnBj
X3ZtX2dldF9wYWdlX3Byb3QodW5zaWduZWQgbG9uZyB2bV9mbGFncykNCj4gK3sNCj4gKyNpZmRl
ZiBDT05GSUdfUFBDX01FTV9LRVlTDQo+ICsJcmV0dXJuICh2bV9mbGFncyAmIFZNX1NBTykgPw0K
PiArCQlfX3BncHJvdChfUEFHRV9TQU8gfCB2bWZsYWdfdG9fcHRlX3BrZXlfYml0cyh2bV9mbGFn
cykpIDoNCj4gKwkJX19wZ3Byb3QoMCB8IHZtZmxhZ190b19wdGVfcGtleV9iaXRzKHZtX2ZsYWdz
KSk7DQo+ICsjZWxzZQ0KPiArCXJldHVybiAodm1fZmxhZ3MgJiBWTV9TQU8pID8gX19wZ3Byb3Qo
X1BBR0VfU0FPKSA6IF9fcGdwcm90KDApOw0KPiArI2VuZGlmDQo+ICt9DQo+ICsjZWxzZQ0KPiAr
c3RhdGljIHBncHJvdF90IHBvd2VycGNfdm1fZ2V0X3BhZ2VfcHJvdCh1bnNpZ25lZCBsb25nIHZt
X2ZsYWdzKQ0KPiArew0KPiArCXJldHVybiBfX3BncHJvdCgwKTsNCj4gK30NCj4gKyNlbmRpZiAv
KiBDT05GSUdfUFBDNjQgKi8NCg0KQ2FuIHdlIHJlZHVjZSB0aGlzIGZvcmVzdCBvZiAjaWZkZWZz
IGFuZCBtYWtlIGl0IG1vcmUgcmVhZGFibGUgPw0KDQptbS9tbWFwLmMgaXMgZ29pbmcgYXdheSB3
aXRoIHBhdGNoIA0KaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2xpbnV4cHBj
LWRldi9wYXRjaC9kNmQ4NDk2MjFmODIxYWYyNTNlNzc3YTI0ZWRhNGM2NDg4MTRhNzZlLjE2NDY4
NDc1NjIuZ2l0LmNocmlzdG9waGUubGVyb3lAY3Nncm91cC5ldS8NCg0KU28gaXQgd291bGQgYmUg
YmV0dGVyIHRvIGFkZCB0d28gdmVyc2lvbnMgb2Ygdm1fZ2V0X3BhZ2VfcHJvdCgpLCBmb3IgDQpp
bnN0YW5jZSBvbmUgaW4gbW0vcGd0YWJsZV82NC5jIGFuZCBvbmUgaW4gbW0vcGd0YWJsZV8zMi5j
DQoNCg0KPiArDQo+ICtwZ3Byb3RfdCB2bV9nZXRfcGFnZV9wcm90KHVuc2lnbmVkIGxvbmcgdm1f
ZmxhZ3MpDQo+ICt7DQo+ICsJcmV0dXJuIF9fcGdwcm90KHBncHJvdF92YWwocHJvdGVjdGlvbl9t
YXBbdm1fZmxhZ3MgJg0KPiArCQkJKFZNX1JFQUR8Vk1fV1JJVEV8Vk1fRVhFQ3xWTV9TSEFSRUQp
XSkgfA0KPiArCSAgICAgICBwZ3Byb3RfdmFsKHBvd2VycGNfdm1fZ2V0X3BhZ2VfcHJvdCh2bV9m
bGFncykpKTsNCj4gK30NCj4gK0VYUE9SVF9TWU1CT0wodm1fZ2V0X3BhZ2VfcHJvdCk7DQoNCkJ5
IHRoZSB3YXkgSSdtIGEgYml0IHB1enpsZWQgd2l0aCB0aGUgbmFtZSBwb3dlcnBjX3ZtX2dldF9w
YWdlX3Byb3QoKSwgDQp0aGUgbmFtZSBzdWdnZXN0cyB0aGF0IGl0J3MganVzdCBhIHBvd2VycGMg
cmVwbGFjZW1lbnQgb2YgDQp2bV9nZXRfcGFnZV9wcm90KCkuIEknZCBwcmVmZXIgaWYgaXQgd2Fz
IG5hbWVkIF9fdm1fZ2V0X3BhZ2VfcHJvdCgpLCBpdCANCndvdWxkIGJlIGNsZWFyZXIgdGhhdCBp
dCBpcyBhIGNvbXBsZW1lbnQgdG8gdm1fZ2V0X3BhZ2VfcHJvdCgpIGFuZCBub3QgYSANCnJlbXBs
YWNlbWVudC4NCg0KQ2hyaXN0b3BoZQ==
