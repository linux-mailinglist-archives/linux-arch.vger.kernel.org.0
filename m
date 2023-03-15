Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AF96BAD73
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 11:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjCOKTd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 06:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjCOKTS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 06:19:18 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2049.outbound.protection.outlook.com [40.107.12.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3D86C1AD;
        Wed, 15 Mar 2023 03:18:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nflIrsrEFuXyWpFOhmVtDZU28CUs98Ea9sbKc/36dXPGDivI4C2NXyFDPomk05uuYgRplFqbEySnm8IGoppztSHhJkKBo4k1jXa3rOx1czfvTL+RgTsCo1oSN2eFO0V539U96KR4mkYlMrLKYETm+L2923QLMUtvdgoniWaOh5kLNBfdk3Zmd1e61MH+nSBMdKZ8xKefn7iBGqHbCnNQg2Wc2B7+otk7KLlDgQxfzY/SWSdkgfzxxKg7FVZVMXvd7JkR7z6ETGr2wGNnnFocDLRz9hjqs8tyfx8PobrTRaetzD8u7alWQWT/P9Liv14uCB+VdDTC9fbenc4A22TsqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGubZEUNBfdLkgmycInfwezwxHfXMP4zTgFbkNw7F3Q=;
 b=MrG7cMdpBlbpBiVDvg4yBkEtcaBroVSBoUsEwAw0hREoqcSWck/yoUiSSkleI9Gxi+KuCZnIJb0yesOnga+nYw/4OGcT4KSfzhriBe9/0KbjPdMxWDe3rOSL7+a7Ive4KcfGmIsGveXHtin3AOo4klWzZeyPfefjXsxwWqxYJ7wMiFNRW+QC2Mxq52V9b19MLXX/GgUwOCwQW14R21pJNt5yPgbI49K08RHJAHM3hdS5pALIWvXDCTi6kGLK5iN6VirogkVHOQ9Oga2296AJspzr3DvN6HF3mTl/Hpin6b1S1QuKk/8IHIItnG4bUPLnRiMkp6+gwPnHvwLt2jwUXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGubZEUNBfdLkgmycInfwezwxHfXMP4zTgFbkNw7F3Q=;
 b=3GuzOK8RKlhj5+NnyQH073GhPFYusuVjmbvmYXBVgiUFa0jShSEJQwCMSTq93H96Fj3gz80OuqRXTkU0jcPK19HAa8z7DOQ7MxtaQfcwJAsIGZCqasjbDu0imhbBpFQ9rCKJtgjyx4Fher0mba5P4DBIyAt3xItovz/hlfrdz9gVha2SSQxh8kYSuMv6ncnJ5sHadG5tPUOiCKv5uYuMbvg2iLbo856mI16vCuLOvqO5yPQ7wgPJa0yPeBb4fM8tTU/+ROhV/b3grTCJ3nRZ1IY1QUiuiNo8V5kQPX7joO1qmAbPS0gVnwbwoG5Ku7XvmRPCzUr3w5PtIs9J7D9k7A==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAZP264MB2333.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Wed, 15 Mar
 2023 10:18:22 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3943:154a:eccc:fe3a]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3943:154a:eccc:fe3a%7]) with mapi id 15.20.6178.029; Wed, 15 Mar 2023
 10:18:22 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v4 20/36] powerpc: Implement the new page table range API
Thread-Topic: [PATCH v4 20/36] powerpc: Implement the new page table range API
Thread-Index: AQHZVv0YjMzoz9l+LU6zj9tdkgq+2a77l0WAgAAJsQA=
Date:   Wed, 15 Mar 2023 10:18:22 +0000
Message-ID: <c7f08247-8bcd-184c-5e06-91f91257f1f6@csgroup.eu>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-21-willy@infradead.org>
 <1743d96f-8efe-0127-2cae-7368ce0eb2e6@csgroup.eu>
In-Reply-To: <1743d96f-8efe-0127-2cae-7368ce0eb2e6@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PAZP264MB2333:EE_
x-ms-office365-filtering-correlation-id: 836bc186-c09e-4ef3-9ee1-08db253e9b6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zw6csyt8Tig+97L9lZvW4MBur7eGd3KvUjMeFLr64Oph6DtP2AOSi7TOMpxRCpQ4VW+Ms56ij9NK8iYVg7WzMmvTRa/VLDue282t2eb5HKj6qcr+O+jN8ahPgKaB8rfHI5b5G0UAXx0VYuybl1Xphuhpp+KpO6t9tPZyWpzXG+vDMbdujI636gDAxJNmECmUgarecXhqCuuT8rNP/QG5g3YC0oR3tKAYWgRmjm6/JMExO//KA8kVkfDfxJ3DEGfbrGWrAGckElODMjmFF0D8U/wCzBVY+kjls7Yc5Ea/S1cgEN7i/95ZkelRw4TUufPlqYo8sTGQricozL6i7EQxP2FJrNlVj4eMYIw6OzEzqmj+75AcWKM2Hx9Wj0GTbE1GMDPl7S0mGIiSgnEL0/m2Lg2B/8CS8RdbLpE5sBYlplwey3FrzWu88+/fIcsjM6yRqRqfI/PBYBFo102s2FnSbNyLWenxHAuMyatsNNDcwkHhjdcf+QAFEIrHpLDrEI46yCEREXS8SpxgkOlZQ7S+8kjQzc9AU7kZTQwXxf3BiDlvj08AnnjAMlgCd6hFVw8O8hI6k0ZH1i9Zl+DIwg65yVL+YvKh5WuzE/GxILjDZUWA77HeaUDuzCRQh0MSeDKTJJt0UcqurbFBBNz7k1QU7l0PKJR/UY3WUUDMwyciNAWgaye/L/LrxhwhSzeutf/r0kno6o2QOst23je1Bp1PYYmdBM1s2NInAqXHe0h7fQCm475jKNwBGUenx7MTaonf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199018)(38070700005)(86362001)(31696002)(36756003)(38100700002)(122000001)(44832011)(2906002)(41300700001)(8936002)(5660300002)(4326008)(6512007)(186003)(2616005)(26005)(66574015)(6506007)(316002)(54906003)(83380400001)(110136005)(66556008)(66446008)(64756008)(8676002)(91956017)(66476007)(76116006)(66946007)(6486002)(966005)(71200400001)(478600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2ttRi93R1lqQ3dzNFFDNE1jbDVmM294QnNIVU4xc25rUkY2Yi9nblZhK3pB?=
 =?utf-8?B?aHpyMXB5WXVyNjkvS0kvYWFtVEZiMGpmaXozSFppeVFjQjdzS2dFcWZmMUN4?=
 =?utf-8?B?V0xOZ0NsNktkOVRKbXlBN0Y2U0NUUjhock9WTmUrT3hJNDhKNFMzdHpiSTdG?=
 =?utf-8?B?ejFTMDFLVFJVZThGUmhQVDNONjd5OE9CME9jUnBuMEFSajFEQ25IMURPRXFz?=
 =?utf-8?B?U1hOSFNkbVZ4VHNzTjJpaEdldHFDZnFIODdtck8vRmZZMFlnMGREeklKeWFQ?=
 =?utf-8?B?YkJGT3c3N2dnVms1V0JndEZZRksvY3NkYlE0dFp2NmZ3dmozTDZUQ1RXNUxC?=
 =?utf-8?B?eGlDRUcvSEMrd2FWU0RDWnVJTlpPdFNnR1BwcjJkSW43dXRlV1o5NmxmWU1K?=
 =?utf-8?B?RE1KdzZmRkVMaG84d1BUZnRCRU1tSHIvbVY0WTl4ams1NGlwYmxqNFZXZDVt?=
 =?utf-8?B?dDR1QUNOMXl6cUZqVGFzZytFNVNxNU1KdDRNTUJ2UWl6OGlPcGdBc3RYcEhx?=
 =?utf-8?B?N0srYm9YZHFJeit0eFFuczI2cEdDS2oxWndETVBDVjNhMHZRcVJhcVBtMXFi?=
 =?utf-8?B?ckZhVFR2YldGSnEzZmlJZWxEYjFheHBnTTRCVEVZV09zNTFKWU51VE9LTDlK?=
 =?utf-8?B?SmkvYmxoZE84QldSVVpicWF1K1JFY0NiNVB4Y1JUNSt5NzBsaFdWbkxXMEZN?=
 =?utf-8?B?elJ0bHZjYnM2TDZKaFdyZ3g0ZHgvalpXQ25HVmc2QmkxdlFJVkVRV2VINzVn?=
 =?utf-8?B?YWpjMkYvT1Z1ekcwaW5WRzNQbjNWWXBOZmN2R3A0OXk2SWl6Qk1DSStzRmlU?=
 =?utf-8?B?eGc2V08vRnVTUUs3bEZqTGVidURiZHljUmF2MWlVa2xjOTBUcC94Q1E2SzFm?=
 =?utf-8?B?d1gwUStreVNKUCtQV29adHJBTFc0VHZCQno3anU4VmJOeWhobzR6U0tBTFJB?=
 =?utf-8?B?SE4wNVVYVGkzN011QXFBdkoydWV0NndXdGYzREY2Sm5SV2lqMFdpYWZudEVV?=
 =?utf-8?B?OHNNRHN5KzByUTlrRTBWYnhDc2doV3o5ZnlGREcrbVNRdjAyWUN5RWk4SkY4?=
 =?utf-8?B?Tkt6NVAzdGJqWVhVSnNMS0o4NW9TbWxZaUdRM3VRSGRTTXozemhTK0FObE95?=
 =?utf-8?B?S3NEQ01ZNHErRk5ZTy9zNzZtaWJNUjVzaGt3cmRqQ1IwUnVIT01CUG9PZ1pS?=
 =?utf-8?B?bFNQTXVUeE5vZlNGNTJMU3RtSmFoN3E0QkNNckU1K0pkMExCWC9QSlBsN2Rq?=
 =?utf-8?B?d0F4ZEdjYVJrTGdSMlRpSUJvSzZIRGlFUWlucW1ZTWhWQXBkaktQK09CRmZ2?=
 =?utf-8?B?aVViWU5BZHM4ZUhBYUpNWVJ1S29yTEJmRkJFTGRqZ3hKa1g2VXhBR29YSTNT?=
 =?utf-8?B?dS9qV2lLQWtyS0R3WUVZSFptUy95RUdQTHpXT2ZsbXFJYk9MNWg5TWMvcjhn?=
 =?utf-8?B?dHREZFJJTjZybldHTGcrSElDYXlUc201dGdRdVdBNm9xRWRLMVhlMmNKL2tj?=
 =?utf-8?B?U0pReVc1VEE5ek1SemwwQzFHblJtbGFsWUVCMXhqZlF6MXFyUC8wZEdvNFM0?=
 =?utf-8?B?TGYzVVNxNzRUQjFOYWJkUTQzSENEUjV2MC84OE9zRFRUSG9QMWJOdEdzbVcw?=
 =?utf-8?B?enRRQlhHcGJxRGRHVlVqK1BmSW5ZRm9vQ3B5b0hodHlIcy9EMmQ4WnVCMU5H?=
 =?utf-8?B?bFNYYUlTM2Qzbm5vSlBQaGRNOEIyVVNJeDRsWFRPUUJwQmEvOTN6TFpwNG1W?=
 =?utf-8?B?NVB3L0loTXNyTUt4cjhBWTIzeFJMQW1mK3R2Qy9WZjJJazNjSExKckhYdit3?=
 =?utf-8?B?ZGlDRUV0TW8zTUxmZzgxcnBVZHFBUlAyVU5URDNvR2FlZm5wWmNFRS9WaWtW?=
 =?utf-8?B?dENGN2prUmFPWHlsNFBJQ21ldzN6VldMRjM3VWNWS1VsN05GRnF2ZnZMVkhF?=
 =?utf-8?B?Y253N0lORFhmMFZMK2orUWw1VHhieTFjclA0L1ppYmhHQU00SjVIRjZzVXJ5?=
 =?utf-8?B?YjhGQ3FBRWVZTjR1bGJuaHM5d0RPMGJ6SVl6ZG4xdnNjWFlZMURQVStCYUlZ?=
 =?utf-8?B?V2VnOEpLYTdPWndEaXAvMWtxZ0NaYmJacVM0eHNtZkVjSVVSaUZKVGpEYXd6?=
 =?utf-8?B?T3lsQXpCMFN1WXlUd3dtMlpJL2ZCS1N5Wk9YdWVpZ2psWmFLbmZGQUJoZVVr?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCA731677E505A4BA93AA92626E85C11@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 836bc186-c09e-4ef3-9ee1-08db253e9b6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 10:18:22.8310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1vtqiP90W4A5AtQkWCXPF4EnFaDVlCyMfgGjW3zCkJ6xdRWJsiTNC7YN5iEnrv1u3dfWJjvxpkeYVZNNAgu+fTZSRIXk0U5ytx2+OswfmG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2333
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDE1LzAzLzIwMjMgw6AgMTA6NDMsIENocmlzdG9waGUgTGVyb3kgYSDDqWNyaXTCoDoN
Cj4gDQo+IA0KPiBMZSAxNS8wMy8yMDIzIMOgIDA2OjE0LCBNYXR0aGV3IFdpbGNveCAoT3JhY2xl
KSBhIMOpY3JpdMKgOg0KPj4gQWRkIHNldF9wdGVzKCksIHVwZGF0ZV9tbXVfY2FjaGVfcmFuZ2Uo
KSBhbmQgZmx1c2hfZGNhY2hlX2ZvbGlvKCkuDQo+PiBDaGFuZ2UgdGhlIFBHX2FyY2hfMSAoYWth
IFBHX2RjYWNoZV9kaXJ0eSkgZmxhZyBmcm9tIGJlaW5nIHBlci1wYWdlIHRvDQo+PiBwZXItZm9s
aW8uDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTWF0dGhldyBXaWxjb3ggKE9yYWNsZSkgPHdpbGx5
QGluZnJhZGVhZC5vcmc+DQo+PiBDYzogTWljaGFlbCBFbGxlcm1hbiA8bXBlQGVsbGVybWFuLmlk
LmF1Pg0KPj4gQ2M6IE5pY2hvbGFzIFBpZ2dpbiA8bnBpZ2dpbkBnbWFpbC5jb20+DQo+PiBDYzog
Q2hyaXN0b3BoZSBMZXJveSA8Y2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1Pg0KPj4gQ2M6IGxp
bnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnDQo+PiAtLS0NCg0KPj4gQEAgLTIwMyw3ICsyMDMs
MTQgQEAgdm9pZCBzZXRfcHRlX2F0KHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLCB1bnNpZ25lZCANCj4+
IGxvbmcgYWRkciwgcHRlX3QgKnB0ZXAsDQo+PiDCoMKgwqDCoMKgIHB0ZSA9IHNldF9wdGVfZmls
dGVyKHB0ZSk7DQo+PiDCoMKgwqDCoMKgIC8qIFBlcmZvcm0gdGhlIHNldHRpbmcgb2YgdGhlIFBU
RSAqLw0KPj4gLcKgwqDCoCBfX3NldF9wdGVfYXQobW0sIGFkZHIsIHB0ZXAsIHB0ZSwgMCk7DQo+
PiArwqDCoMKgIGZvciAoOzspIHsNCj4+ICvCoMKgwqDCoMKgwqDCoCBfX3NldF9wdGVfYXQobW0s
IGFkZHIsIHB0ZXAsIHB0ZSwgMCk7DQo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKC0tbnIgPT0gMCkN
Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOw0KPj4gK8KgwqDCoMKgwqDCoMKgIHB0
ZXArKzsNCj4+ICvCoMKgwqDCoMKgwqDCoCBwdGUgPSBfX3B0ZShwdGVfdmFsKHB0ZSkgKyBQQUdF
X1NJWkUpOw0KPiANCj4gSSBkb24ndCBsaWtlIHRoYXQgbWF0aCB0b28gbXVjaCwgYnV0IEkgaGF2
ZSBubyBiZXR0ZXIgaWRlYSBhdCB0aGUgbW9tZW50Lg0KPiANCj4gTWF5YmUgc2V0X3B0ZXMoKSBz
aG91bGQgdGFrZSBhIHBncHJvdF90IGFuZCByZWJ1aWxkIHRoZSBwdGUgd2l0aCANCj4gbWtfcHRl
KCkgb3Igc2ltaWxhciA/DQo+IA0KPj4gK8KgwqDCoMKgwqDCoMKgIGFkZHIgKz0gUEFHRV9TSVpF
Ow0KPj4gK8KgwqDCoCB9DQo+PiDCoCB9DQo+PiDCoCB2b2lkIHVubWFwX2tlcm5lbF9wYWdlKHVu
c2lnbmVkIGxvbmcgdmEpDQoNCkkgaW52ZXN0aWdhdGVkIGEgYml0IGZ1cnRoZXIgYW5kIGNhbiBj
b25maXJtIG5vdyB0aGF0IHRoZSBhYm92ZSB3b24ndCANCmFsd2F5cyB3b3JrLCBzZWUgY29tbWVu
dCANCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjMtcmMyL3NvdXJjZS9hcmNo
L3Bvd2VycGMvaW5jbHVkZS9hc20vbm9oYXNoLzMyL3BndGFibGUuaCNMMTQ3DQoNCkFuZCB0aGVu
IHlvdSBzZWUgDQpodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni4zLXJjMi9zb3Vy
Y2UvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL25vaGFzaC9wdGUtZTUwMC5oI0w2Mw0KDQpDaHJp
c3RvcGhlDQo=
