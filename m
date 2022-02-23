Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135CF4C19C3
	for <lists+linux-arch@lfdr.de>; Wed, 23 Feb 2022 18:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237619AbiBWRS2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Feb 2022 12:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237427AbiBWRS1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Feb 2022 12:18:27 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90052.outbound.protection.outlook.com [40.107.9.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375173465D;
        Wed, 23 Feb 2022 09:17:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrJgHH3Uh+MSSkZ8yeZGzYQb/vsErqeQRsWxcU5Zvxo3YTzNT8F/5J6HhdDr3PYrefEAlBnOX7tpypouthn3418kbXK8ExlEsc5bpp465nfxDOSzyBcZV6PVAxuvqKRXpqBDuYdwNssqcuI443H9i954hXZe8SqZBBJd8gsZsKsqzEQHD8cG+noPfOpu2BSY7cBbXnrxETe6GrBFtlMMG/6AGB3iMOKQmvsHAIeM5FtoEz0USxD7fPreyLf/lmbiJ8/U06PPM9CBqO2vtLNKoD2bIfcoYLfZfU7yQHeRJ4R16F3y/ff+awq5fgEmtaDkqEnq8kqSodkZUrpQ+KWghw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rM8/F+BQo+clkAER7HP5WhpPpTLC6MnQsyHO1gN1Uw=;
 b=Bp1df9b1i3isPDZFHBNtI9GD+DDqDcWV3UpBOUPKa564z3tn7pnFuNk9NpCAlcmClIJCVso2s1KEIXNh8ITYHwkDMjPXQnM9R+3D4FuVTIuMpQtUHthgC11nI6S8YvlUOqxam75Bx6ldNibWtbjgS/twxQllAPTIZdmtup5pdD3MDaGgFtSLX3h3aegqA4T3YChDD4vfymXiWqMJ9bA/riRAO+y8FwcK/cEaShGs/soyppXUnJgbQhcDtykNo3vEcYp2oneFTdMyVr3nU8PP9hvleFUIn/nqGo9YL1mbWlstjOwc2tGuMGO00kZWGcAX+4Kojmt94c1F7CzbBcdbNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB2230.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:193::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 23 Feb
 2022 17:17:56 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8142:2e6f:219b:646d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8142:2e6f:219b:646d%5]) with mapi id 15.20.5017.021; Wed, 23 Feb 2022
 17:17:56 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [RFC PATCH] lkdtm: Replace lkdtm_rodata_do_nothing() by
 do_nothing()
Thread-Topic: [RFC PATCH] lkdtm: Replace lkdtm_rodata_do_nothing() by
 do_nothing()
Thread-Index: AQHXw3s+6c9UQ+pWBkyusfSb2ZFtUKyiK6CA
Date:   Wed, 23 Feb 2022 17:17:56 +0000
Message-ID: <26d37781-9824-3306-240d-6ce6044c2412@csgroup.eu>
References: <fe36bf23fb14e7eff92a95a1092ed38edb01d5f5.1634491011.git.christophe.leroy@csgroup.eu>
In-Reply-To: <fe36bf23fb14e7eff92a95a1092ed38edb01d5f5.1634491011.git.christophe.leroy@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d0cd990-3656-4380-e131-08d9f6f06f13
x-ms-traffictypediagnostic: PR1P264MB2230:EE_
x-microsoft-antispam-prvs: <PR1P264MB223073409853F2E4E04238E2ED3C9@PR1P264MB2230.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zpuionsf4cVRMaC0kFomF3C0lLRJI+IwaZnOv1wcl+tIgBb9HUM3dxKppEjsXe6QO9rkSIZ6JPlSu76NHrLKDLiW1uWewj7rxQBWs+UoRLDBvW7oOZIbi7waWNixFwfzXppAv/FuHz3w7Imvtqqu9XDMaDWexUKWiQoee7SHOhwClIkqoQ6gJxQjVT7k85XIvrO1Ww/UH3hNsSsPrkpWZFIKmO/3WM7whYkvklSOAFR3aXKrFl1PUo/EuuNtLnaD6ybapxRmEYNr05my5RkAo7P0QhyU3ZluG0mOtehxTjwBIT0/jYV5/hOcyVINsUOSqlmt1stIeirJBhpWqc6GJYfne5mw/P3y1bcJ/Qp0fP4X9YlGtHviUmNoD/DSykuvuKS1ewKytWuOIrxhatLYEI1Lr5yzbIhy9sZJX+ZnRQwdwDsmfcfkCaOnza0eRKAIGdmmUmYmUG+ZH33/1nRJG4aUEudOCvREUK9xZ71zi7OG8R+hT3OKc0ysVqvT0CEpbZ4wJuRpV/kEdO7XR2dXw0ax5/3QwgQKBAsQ0PczTew2YV7hYxtHFj7o9Uwh+Fuo0A/xZnMjqyi04PqFBB32YMd6fmWhaKyrF/9G4xEv+mXfDcMhr6mdP4Cn66QY5q+zuo8G9WLRexqjTbAH0yP43M7Ie3yZVOuLFYfA2xyF+055tH/ONuglRHepj0u7gkq4O/7cGxFUo7idotRCCWnsOYDwbEo88Nq6JfVigkuCvqEOl3+Dj4PK+W4GkJlZFKlbJV6IZjDp6FL9562jGsEFNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(6506007)(36756003)(186003)(4326008)(5660300002)(6512007)(2616005)(8676002)(66446008)(26005)(31696002)(31686004)(2906002)(86362001)(122000001)(66556008)(508600001)(6486002)(38100700002)(64756008)(71200400001)(8936002)(44832011)(66946007)(91956017)(83380400001)(38070700005)(66574015)(316002)(110136005)(76116006)(54906003)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3BlMmFocFhsZWUxcjJwZjNEaWxRSXh2Q1drTXFOY01tbTVjSXBPY1RKdlZZ?=
 =?utf-8?B?WmwvUnFsYWlxWUM3WEo1RDVvWmJjanplWHBMVHlqcVVyeHRLSEVaRjQ4K3d2?=
 =?utf-8?B?R3hjTVpiRmRscE9VaG1tTkt6WWlDUUxFN21QVStwdHNzQU9haUdEUnJ3MTAv?=
 =?utf-8?B?R3hKQkFTYnRveVkwZGo0RWZPdjJYSDFkT1pJUHJIUitBRXdkV0xnalZLU1o0?=
 =?utf-8?B?KzRsV0VGcXo5ZjVJRkhlTzc5MndFZnExK1pyU0dXNDNLSU9PNWpKNGNjRm4y?=
 =?utf-8?B?NWFNN2RGdmcwNHJRNk9sTjdCZW9LcUhpWEk4OUVxTVkvaDI0TXljekFSWS9E?=
 =?utf-8?B?NUovbWtRQTNyQzBKd3lSVC93ZWhKRTdSMHNQUkJFSG44Mm9HalJUay8yckda?=
 =?utf-8?B?c0tCc1lQemFxZUh1TE42OEc0bXVTbFU5dVNzY1cxakpEOG5JTzhPS3ljWTBs?=
 =?utf-8?B?ZXpYMWc3WFlJTmZoU2FyM1F5eFhIYjJYUGN3cUZLT0laU1hRa1VBc2UzQ0xU?=
 =?utf-8?B?aE9BM21mc3hHc0syazRGMWg1bjRmZkU5VlFFOGJmVzRMU1d5NDZ6TjlRc2tU?=
 =?utf-8?B?emt5VFBJQWh3N1JvZURZalZWaTdQcVhZZnBQVUxiZTJRSkdEeWtWaGpudktZ?=
 =?utf-8?B?emZUa2hodHU2RHRQTi9ucXJwSE1UWS8xZEM1cFpZS2RZMFlxd21hSW40U1Fl?=
 =?utf-8?B?UlJKUGF3RUFGSjZKdUZ4Z09mLzh5UmVEQXpYV0JVd1M4Szk5UVlJalY2NGd2?=
 =?utf-8?B?YXpCc0dLU2RWTnBnQ3NvMDJaemo2bGEzY3djR3JJcXRHRWlCOWowQlN6NEtM?=
 =?utf-8?B?aFpQN29SOVExYVRMUmF2eTIyWnU1bkpzSWdkKzVaTXVpZHY0MHpXRndLTUNw?=
 =?utf-8?B?ZEloSEpPSmowenlKcE1yT2N2clRQNVgwMnRvTkNPMnJXeDFLNTVMZ0NSV09z?=
 =?utf-8?B?MWFoVW5RNGh2bTRFL25xZDlnUkpRL3o0ZWI4TnpsQWhUMGxNUWg4Q0JTdkI2?=
 =?utf-8?B?UXc5SFJ5N1I1bXViQmMvUVlFdUNvMDU0cCtqU3VrNnFXSUFVSldGaWlSVGR6?=
 =?utf-8?B?d0dyNFVSS0I2STZUcUgrMlBobVJ4azJNSVhXVyt0TUF4Y1p0a1cvaXg5b01Z?=
 =?utf-8?B?V3BJdFE2a2dwR25uTFJtOE9aVW5iQTQ3cXRrdVpmY3VFMXJzZ005OFF1SVlv?=
 =?utf-8?B?TWtrU0ZhanV1SDFTUnBEWEsxZUk1Z2h3dW93V01vaVRPaTBGK2l4TVBwUVdu?=
 =?utf-8?B?aUdrSktDQlJKcnEvbzFKVHRwOHRsTEtNSFpzZC8wa3JkYkxHVXdOUEJvS29W?=
 =?utf-8?B?Qk85ZU5tT0trbTR3aHdIcDhmOFNncm5pZmdjYXVENGZhZTg0Zk9WVEV2UEgv?=
 =?utf-8?B?VjB3cHBzUXhHdUtNR0FNZEd5NnNmVTBYOUdYK2ZDRm8xOEZMOEpsQ1J6Vytj?=
 =?utf-8?B?dS9ZOUhmUEpMd0p4U3NKQVNlU0RiUGE1VGdDQlh5eU85T01UVUlZRG4vQlJT?=
 =?utf-8?B?SzNMUGFaWFVDcU4xL3h3WElCRFpJRlFLMUxvdWdHT284dDZ6NXR4aTgwa3Qz?=
 =?utf-8?B?VFJ0VVdSNGVZQUo3eEc4VUgzYjhlNkV2aTk0VlNzZGorRHdiR091dHd4Q2pL?=
 =?utf-8?B?K2pWS1RQL1RjS0d6eFFjTjAxSHAxSjlYWHZjTC84WVpSNjRRbW9XMjd4anRn?=
 =?utf-8?B?YW1mMWwrUzhsR1NIL1g1ME1kd1ByMllGVU5YVTFUaXpmV2VvSmJxZzQvMTQ1?=
 =?utf-8?B?SjVpMWNxN3ZZZmhZQmY3YmFwY1VCZFY1TVFMRG5jaEo3dkJWY1V4Q3QxZUdY?=
 =?utf-8?B?Y0RNcWdrc281Uk83VFNIOUsyRjg4TTVmVUIyaFNqWE1DdWJndjBkVlV6TG1q?=
 =?utf-8?B?ODZ0cXZUM29QYlRWL0QvdmZyNlpUTFJXbWcyYUM5YUdTNUNlOUFwUitkU2Vl?=
 =?utf-8?B?Z3JiZ05ZSDFhT1BjV1YrUHpVUWdGOTEzOXVFcDRZZ3Z5ZXpXVDJPVUM5MEFS?=
 =?utf-8?B?a0tScVRPZDdyTUFZQmh1QUpNcDhBVGhGS2V0WG9aQlBrKzduQkx5T0lRR2Fn?=
 =?utf-8?B?dHpHVTNqYy92UnFEcEo4ZW41azhKN2VjOTVJcFZiM3Q2b3dZODBnS1NPbjJJ?=
 =?utf-8?B?M3VEWUl6WVdqUi81dkF0RHYzdHEzMjBVQU0rYjZqZjNrNk9weC80S2hSMTQv?=
 =?utf-8?B?ZWNKSHB0dTkxOWhqL25rUkwvSk1USWJydjBleGRaNmRJWkRYNml5YktoUmls?=
 =?utf-8?Q?Lgqa71kxTrvxxbIpttH/KIIU9CUn681k0IdYJ0umX4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15590CE0773E1E419153015EC015227A@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0cd990-3656-4380-e131-08d9f6f06f13
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 17:17:56.4856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U9Q6bX266l51r5hK7NuWwwB+HWCU9ejtUrjdwHv8n9yBVC6lasLsaKVvk3Soq+LXnbea9bdyhhF7p6zQ/v6m9Vliq9GDtmu7F+e5lRDm3wI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB2230
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

SGkgS2VlcywNCg0KTGUgMTcvMTAvMjAyMSDDoCAxOToxOSwgQ2hyaXN0b3BoZSBMZXJveSBhIMOp
Y3JpdMKgOg0KPiBBbGwgRVhFQyB0ZXN0cyBhcmUgYmFzZWQgb24gcnVubmluZyBhIGNvcHkgb2Yg
ZG9fbm90aGluZygpDQo+IGV4Y2VwdCBsa2R0bV9FWEVDX1JPREFUQSB3aGljaCB1c2VzIGEgZGlm
ZmVyZW50IGZ1bmN0aW9uDQo+IGNhbGxlZCBsa2R0bV9yb2RhdGFfZG9fbm90aGluZygpLg0KPiAN
Cj4gT24gYXJjaGl0ZWN0dXJlcyB1c2luZyBmdW5jdGlvbiBkZXNjcmlwdG9ycywgRVhFQyB0ZXN0
cyBhcmUNCj4gcGVyZm9ybWVkIHVzaW5nIGV4ZWN1dGVfbG9jYXRpb24oKSB3aGljaCBpcyBhIGZ1
bmN0aW9uDQo+IHRoYXQgbW9zdCBvZiB0aGUgdGltZSBjb3BpZXMgZG9fbm90aGluZygpIGF0IHRo
ZSB0ZXN0ZWQNCj4gbG9jYXRpb24gdGhlbiBkdXBsaWNhdGVzIGRvX25vdGhpbmcoKSBmdW5jdGlv
biBkZXNjcmlwdG9yDQo+IGFuZCB1cGRhdGVzIGl0IHdpdGggdGhlIGFkZHJlc3Mgb2YgdGhlIGNv
cHkgb2YgZG9fbm90aGluZygpLg0KPiANCj4gQnV0IGZvciBFWEVDX1JPREFUQSB0ZXN0LCBleGVj
dXRlX2xvY2F0aW9uKCkgdXNlcw0KPiBsa2R0bV9yb2RhdGFfZG9fbm90aGluZygpIHdoaWNoIGlz
IGFscmVhZHkgaW4gcm9kYXRhIHNlY3Rpb24NCj4gYXQgYnVpbGQgdGltZSBpbnN0ZWFkIG9mIHVz
aW5nIGEgY29weSBvZiBkb19ub3RoaW5nKCkuIEhvd2V2ZXINCj4gaXQgc3RpbGwgdXNlcyB0aGUg
ZnVuY3Rpb24gZGVzY3JpcHRvciBvZiBkb19ub3RoaW5nKCkuIFRoZXJlDQo+IGlzIGEgcmlzayB0
aGF0IHJ1bm5pbmcgbGtkdG1fcm9kYXRhX2RvX25vdGhpbmcoKSB3aXRoIHRoZQ0KPiBmdW5jdGlv
biBkZXNjcmlwdG9yIG9mIGRvX3RoaW5nKCkgaXMgd3JvbmcuDQo+IA0KPiBUbyByZW1vdmUgdGhl
IGFib3ZlIHJpc2ssIGNoYW5nZSB0aGUgYXBwcm9hY2ggYW5kIGRvIHRoZSBzYW1lDQo+IGFzIGZv
ciBvdGhlciBFWEVDIHRlc3RzOiB1c2UgYSBjb3B5IG9mIGRvX25vdGhpbmcoKS4gVGhlIGNvcHkN
Cj4gY2Fubm90IGJlIGRvbmUgZHVyaW5nIHRoZSB0ZXN0IGJlY2F1c2UgUk9EQVRBIGFyZWEgaXMg
d3JpdGUNCj4gcHJvdGVjdGVkLiBEbyB0aGUgY29weSBkdXJpbmcgaW5pdCwgYmVmb3JlIFJPREFU
QSBiZWNvbWVzDQo+IHdyaXRlIHByb3RlY3RlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENocmlz
dG9waGUgTGVyb3kgPGNocmlzdG9waGUubGVyb3lAY3Nncm91cC5ldT4NCg0KQW55IG9waW5pb24g
b24gdGhpcyBwYXRjaCA/DQoNClRoYW5rcw0KQ2hyaXN0b3BoZQ0KDQo+IC0tLQ0KPiBUaGlzIGFw
cGxpZXMgb24gdG9wIG9mIHNlcmllcyB2MyAiRml4IExLRFRNIGZvciBQUEM2NC9JQTY0L1BBUklT
QyINCj4gDQo+ICAgZHJpdmVycy9taXNjL2xrZHRtL01ha2VmaWxlIHwgMTEgLS0tLS0tLS0tLS0N
Cj4gICBkcml2ZXJzL21pc2MvbGtkdG0vbGtkdG0uaCAgfCAgMyAtLS0NCj4gICBkcml2ZXJzL21p
c2MvbGtkdG0vcGVybXMuYyAgfCAgOSArKysrKysrLS0NCj4gICBkcml2ZXJzL21pc2MvbGtkdG0v
cm9kYXRhLmMgfCAxMSAtLS0tLS0tLS0tLQ0KPiAgIDQgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRp
b25zKCspLCAyNyBkZWxldGlvbnMoLSkNCj4gICBkZWxldGUgbW9kZSAxMDA2NDQgZHJpdmVycy9t
aXNjL2xrZHRtL3JvZGF0YS5jDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9taXNjL2xrZHRt
L01ha2VmaWxlIGIvZHJpdmVycy9taXNjL2xrZHRtL01ha2VmaWxlDQo+IGluZGV4IGUyOTg0Y2U1
MWZlNC4uM2Q0NWEyYjMwMDdkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21pc2MvbGtkdG0vTWFr
ZWZpbGUNCj4gKysrIGIvZHJpdmVycy9taXNjL2xrZHRtL01ha2VmaWxlDQo+IEBAIC02LDIxICs2
LDEwIEBAIGxrZHRtLSQoQ09ORklHX0xLRFRNKQkJKz0gYnVncy5vDQo+ICAgbGtkdG0tJChDT05G
SUdfTEtEVE0pCQkrPSBoZWFwLm8NCj4gICBsa2R0bS0kKENPTkZJR19MS0RUTSkJCSs9IHBlcm1z
Lm8NCj4gICBsa2R0bS0kKENPTkZJR19MS0RUTSkJCSs9IHJlZmNvdW50Lm8NCj4gLWxrZHRtLSQo
Q09ORklHX0xLRFRNKQkJKz0gcm9kYXRhX29iamNvcHkubw0KPiAgIGxrZHRtLSQoQ09ORklHX0xL
RFRNKQkJKz0gdXNlcmNvcHkubw0KPiAgIGxrZHRtLSQoQ09ORklHX0xLRFRNKQkJKz0gc3RhY2ts
ZWFrLm8NCj4gICBsa2R0bS0kKENPTkZJR19MS0RUTSkJCSs9IGNmaS5vDQo+ICAgbGtkdG0tJChD
T05GSUdfTEtEVE0pCQkrPSBmb3J0aWZ5Lm8NCj4gICBsa2R0bS0kKENPTkZJR19QUENfQk9PSzNT
XzY0KQkrPSBwb3dlcnBjLm8NCj4gICANCj4gLUtBU0FOX1NBTklUSVpFX3JvZGF0YS5vCQk6PSBu
DQo+ICAgS0FTQU5fU0FOSVRJWkVfc3RhY2tsZWFrLm8JOj0gbg0KPiAtS0NPVl9JTlNUUlVNRU5U
X3JvZGF0YS5vCTo9IG4NCj4gLUNGTEFHU19SRU1PVkVfcm9kYXRhLm8JCSs9ICQoQ0NfRkxBR1Nf
TFRPKQ0KPiAtDQo+IC1PQkpDT1BZRkxBR1MgOj0NCj4gLU9CSkNPUFlGTEFHU19yb2RhdGFfb2Jq
Y29weS5vCTo9IFwNCj4gLQkJCS0tcmVuYW1lLXNlY3Rpb24gLm5vaW5zdHIudGV4dD0ucm9kYXRh
LGFsbG9jLHJlYWRvbmx5LGxvYWQsY29udGVudHMNCj4gLXRhcmdldHMgKz0gcm9kYXRhLm8gcm9k
YXRhX29iamNvcHkubw0KPiAtJChvYmopL3JvZGF0YV9vYmpjb3B5Lm86ICQob2JqKS9yb2RhdGEu
byBGT1JDRQ0KPiAtCSQoY2FsbCBpZl9jaGFuZ2VkLG9iamNvcHkpDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL21pc2MvbGtkdG0vbGtkdG0uaCBiL2RyaXZlcnMvbWlzYy9sa2R0bS9sa2R0bS5oDQo+
IGluZGV4IDE4OGJkMGZkNjU3NS4uOTA1NTU1ZDRjMmNmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L21pc2MvbGtkdG0vbGtkdG0uaA0KPiArKysgYi9kcml2ZXJzL21pc2MvbGtkdG0vbGtkdG0uaA0K
PiBAQCAtMTM3LDkgKzEzNyw2IEBAIHZvaWQgbGtkdG1fUkVGQ09VTlRfU1VCX0FORF9URVNUX1NB
VFVSQVRFRCh2b2lkKTsNCj4gICB2b2lkIGxrZHRtX1JFRkNPVU5UX1RJTUlORyh2b2lkKTsNCj4g
ICB2b2lkIGxrZHRtX0FUT01JQ19USU1JTkcodm9pZCk7DQo+ICAgDQo+IC0vKiByb2RhdGEuYyAq
Lw0KPiAtdm9pZCBsa2R0bV9yb2RhdGFfZG9fbm90aGluZyh2b2lkKTsNCj4gLQ0KPiAgIC8qIHVz
ZXJjb3B5LmMgKi8NCj4gICB2b2lkIF9faW5pdCBsa2R0bV91c2VyY29weV9pbml0KHZvaWQpOw0K
PiAgIHZvaWQgX19leGl0IGxrZHRtX3VzZXJjb3B5X2V4aXQodm9pZCk7DQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL21pc2MvbGtkdG0vcGVybXMuYyBiL2RyaXZlcnMvbWlzYy9sa2R0bS9wZXJtcy5j
DQo+IGluZGV4IDJjNmFiYTNmZjMyYi4uOWI5NTFjYTQ4MzYzIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL21pc2MvbGtkdG0vcGVybXMuYw0KPiArKysgYi9kcml2ZXJzL21pc2MvbGtkdG0vcGVybXMu
Yw0KPiBAQCAtMjcsNiArMjcsNyBAQCBzdGF0aWMgY29uc3QgdW5zaWduZWQgbG9uZyByb2RhdGEg
PSAweEFBNTVBQTU1Ow0KPiAgIA0KPiAgIC8qIFRoaXMgaXMgbWFya2VkIF9fcm9fYWZ0ZXJfaW5p
dCwgc28gaXQgc2hvdWxkIHVsdGltYXRlbHkgYmUgLnJvZGF0YS4gKi8NCj4gICBzdGF0aWMgdW5z
aWduZWQgbG9uZyByb19hZnRlcl9pbml0IF9fcm9fYWZ0ZXJfaW5pdCA9IDB4NTVBQTU1MDA7DQo+
ICtzdGF0aWMgdTggcm9kYXRhX2FyZWFbRVhFQ19TSVpFXSBfX3JvX2FmdGVyX2luaXQ7DQo+ICAg
DQo+ICAgLyoNCj4gICAgKiBUaGlzIGp1c3QgcmV0dXJucyB0byB0aGUgY2FsbGVyLiBJdCBpcyBk
ZXNpZ25lZCB0byBiZSBjb3BpZWQgaW50bw0KPiBAQCAtMTkzLDggKzE5NCw3IEBAIHZvaWQgbGtk
dG1fRVhFQ19WTUFMTE9DKHZvaWQpDQo+ICAgDQo+ICAgdm9pZCBsa2R0bV9FWEVDX1JPREFUQSh2
b2lkKQ0KPiAgIHsNCj4gLQlleGVjdXRlX2xvY2F0aW9uKGRlcmVmZXJlbmNlX2Z1bmN0aW9uX2Rl
c2NyaXB0b3IobGtkdG1fcm9kYXRhX2RvX25vdGhpbmcpLA0KPiAtCQkJIENPREVfQVNfSVMpOw0K
PiArCWV4ZWN1dGVfbG9jYXRpb24ocm9kYXRhX2FyZWEsIENPREVfQVNfSVMpOw0KPiAgIH0NCj4g
ICANCj4gICB2b2lkIGxrZHRtX0VYRUNfVVNFUlNQQUNFKHZvaWQpDQo+IEBAIC0yNjksNCArMjY5
LDkgQEAgdm9pZCBfX2luaXQgbGtkdG1fcGVybXNfaW5pdCh2b2lkKQ0KPiAgIHsNCj4gICAJLyog
TWFrZSBzdXJlIHdlIGNhbiB3cml0ZSB0byBfX3JvX2FmdGVyX2luaXQgdmFsdWVzIGR1cmluZyBf
X2luaXQgKi8NCj4gICAJcm9fYWZ0ZXJfaW5pdCB8PSAweEFBOw0KPiArDQo+ICsJbWVtY3B5KHJv
ZGF0YV9hcmVhLCBkZXJlZmVyZW5jZV9mdW5jdGlvbl9kZXNjcmlwdG9yKGRvX25vdGhpbmcpLA0K
PiArCSAgICAgICBFWEVDX1NJWkUpOw0KPiArCWZsdXNoX2ljYWNoZV9yYW5nZSgodW5zaWduZWQg
bG9uZylyb2RhdGFfYXJlYSwNCj4gKwkJCSAgICh1bnNpZ25lZCBsb25nKXJvZGF0YV9hcmVhICsg
RVhFQ19TSVpFKTsNCj4gICB9DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21pc2MvbGtkdG0vcm9k
YXRhLmMgYi9kcml2ZXJzL21pc2MvbGtkdG0vcm9kYXRhLmMNCj4gZGVsZXRlZCBmaWxlIG1vZGUg
MTAwNjQ0DQo+IGluZGV4IGJhYWNiODc2ZDFkOS4uMDAwMDAwMDAwMDAwDQo+IC0tLSBhL2RyaXZl
cnMvbWlzYy9sa2R0bS9yb2RhdGEuYw0KPiArKysgL2Rldi9udWxsDQo+IEBAIC0xLDExICswLDAg
QEANCj4gLS8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+IC0vKg0KPiAtICog
VGhpcyBpbmNsdWRlcyBmdW5jdGlvbnMgdGhhdCBhcmUgbWVhbnQgdG8gbGl2ZSBlbnRpcmVseSBp
biAucm9kYXRhDQo+IC0gKiAodmlhIG9iamNvcHkgdHJpY2tzKSwgdG8gdmFsaWRhdGUgdGhlIG5v
bi1leGVjdXRhYmlsaXR5IG9mIC5yb2RhdGEuDQo+IC0gKi8NCj4gLSNpbmNsdWRlICJsa2R0bS5o
Ig0KPiAtDQo+IC12b2lkIG5vaW5zdHIgbGtkdG1fcm9kYXRhX2RvX25vdGhpbmcodm9pZCkNCj4g
LXsNCj4gLQkvKiBEb2VzIG5vdGhpbmcuIFdlIGp1c3Qgd2FudCBhbiBhcmNoaXRlY3R1cmUgYWdu
b3N0aWMgInJldHVybiIuICovDQo+IC19
