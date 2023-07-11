Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DFD74E5FE
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jul 2023 06:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjGKEla (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jul 2023 00:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjGKEk6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jul 2023 00:40:58 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2070.outbound.protection.outlook.com [40.107.9.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD8FE49;
        Mon, 10 Jul 2023 21:40:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYhmXeFpYunysoCgiTrF8tvyAx8FwfXHET4ogdmNFkuz2rJZmtTlXvYSZzSmwVRsHuNPvdSbxjeF0AXP675mZN3wtJHlx5xNYGUNxrltuvOF9O7xHZcmTDPyLdV4g5kIngPeUWhYwoDW9dswi3LydRdx4MApp+6AVbm3Kx477GNlhF77VkCpBYzCtpAZ5bZwpXJ5YVuXl+86segfUKgLE8x9s8ZvG/9i6GAIp2GYKpwiMWE1Bao9X1G1hNygVIKgYEvvWNXqvIfoexG3YPl5whbuPPGiAbRdrGVG4JdCTBWzzcGWKZ40XHlAkec0vG0nTtMJduJifw+ZAhVfXCw/UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWNLzssa5n7lkF7jq24PEaNR6uKInLlcFIUW6mFpeeo=;
 b=JdHmW3R9A3rTRpu/5L2mujYw/zBkQQQLVRPL2ngDgaKxaN/W/e+3/y5j7teAS41V22UqvPbotCG1FmyiZeVS9fBO8iJIcY8aGx/A/SvGj++1pxG1zrCv+UvFWx4hpD3Z3dhZ75tZ15fXPO7qfKNmMRqdfVDawMkY8D8s/s4DGLhpKBOjABji2N5XxOz1+Lg3L432A87Uq+VrKlYINgYRIsuGUMU+j+60t32LqUnh+qcSxoKQCj0aNrYOzjsaynFfaj/JQczK2DyDV2yrbZznLJ5IPltOfbBCwHPC4sta4bp7OqjdOsxDJa3Pc/O3Uyo5I3pO2bvDegOAy1swd6/+KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWNLzssa5n7lkF7jq24PEaNR6uKInLlcFIUW6mFpeeo=;
 b=SWDGW1dGGvcB3SKLfwC65W0cH9oRGqe73LaNuvEbDw79lsbfH3VYcx9VLXMx/s+PYaZSlVQMfTmrDcMODC0CfOAf0t73KZSLBEbS6ma/2zjJUDYgRStLE2/sQ8OA+1tc2eTnCRQ2bCtPHPdHnPSXmJnBTmxi/2e5DlW6zBzP4KdThi2fNuBGCtDoPUFlOipC9X7uBYd7x1DUYDIRWjK8Oi5WkKiYbcRCAVm5rZYXV4MaQJCM3UBSChrAz2xqzxtHWrfadxOQVk/eCXljQf3Upixa12CGHk0xI0yYPexheb+LMyU0FRcMkWeFf5SxKyrUE1pybru+BW7d6PAUVvd4gA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB1818.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:16d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 04:40:09 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::802b:33:561c:4217]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::802b:33:561c:4217%4]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 04:40:09 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v4 20/36] powerpc: Implement the new page table range API
Thread-Topic: [PATCH v4 20/36] powerpc: Implement the new page table range API
Thread-Index: AQHZVv0YjMzoz9l+LU6zj9tdkgq+2a77l0WAgAAJsQCAArduAIAB7v6AgLPjoYCAAIqOgA==
Date:   Tue, 11 Jul 2023 04:40:09 +0000
Message-ID: <679a7aea-f754-2ad4-1d6d-36a9647e617f@csgroup.eu>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-21-willy@infradead.org>
 <1743d96f-8efe-0127-2cae-7368ce0eb2e6@csgroup.eu>
 <c7f08247-8bcd-184c-5e06-91f91257f1f6@csgroup.eu>
 <ZBPizB6TmDp0psOl@casper.infradead.org>
 <eb8ad2f2-06ae-4daf-5163-11b950e640ad@csgroup.eu>
 <ZKxo79JYjEvMGAW3@casper.infradead.org>
In-Reply-To: <ZKxo79JYjEvMGAW3@casper.infradead.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB1818:EE_
x-ms-office365-filtering-correlation-id: 460f4212-83d2-4558-25a9-08db81c8e85b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n5BvDzFOWDRzKNPPdJUJjSNC+EWn8VMNkrGA8X9waX+sjZEksYIJM+jwScY0xjIxabsTykx9znSGCRfhjvMHrRYnc/5ohJIvz8FPowAqtqxpXHLxXMIqd1U76H4r2Rwpq3z+PuSovXBGg7SqCh3amAUo7bi+MHOQotqTv1RQ9rY/IbcK/z7a27ujW/bFcK/E71S6LXlbRem4PJRnjJOkIfwuIH2dIyb3YvTL+6v0RZzzCck3wTZjvSjsXG4QnsT8BVoB+51nxFtiM7eCG8vXwTJ2R2w/X8kMhbDUN8hMP9GsMVSANfuYR/xyk+XThIhUHA6VB00vk93lOOEIKfHaI8OCpNX2elKuzo40WNBXgUkAnTF+WlqdkGd7qM18vtkmV0H3wJZ4Wr6bM7r8eGB7I2SiuyJzDdYl8/X2xi4wYeINVnno3c90J9G9J36xftHGmiCMIl002sSt6FvSd36n0wYZHmZYUHkZzEobb6bhbf1N20C5HpidJWD0HXMHyN13kBtWzZusrXmqshxAcm0MUUwUlsXDOMQ+10rNOyJ4itvIm7ODOUhw/+Ha8Uzb0CI+SVFRugpmLKk0xu6gavoW2IGuuSndUyaSkzRU6c/yUw+8/pZd5NGoiOpJgL4tReNanRvuG8GINjVma0n6Eo6bCV3X6KoKu2dYaRflKms2UL8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(136003)(396003)(366004)(376002)(346002)(451199021)(31686004)(76116006)(6486002)(478600001)(71200400001)(91956017)(54906003)(66574015)(83380400001)(36756003)(86362001)(31696002)(38070700005)(2616005)(2906002)(66946007)(186003)(6506007)(26005)(6512007)(64756008)(122000001)(38100700002)(8676002)(6916009)(5660300002)(4326008)(316002)(66476007)(41300700001)(8936002)(66556008)(44832011)(66446008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEVBVmlzekpFamxPdVZza3ZhbWtrZTBhQ3oxVkVMWGowdjhPZ1krVHY3Z1Zr?=
 =?utf-8?B?b3YvOStVeEdsQ2h2em1oS1JMTkhvQWYvQXFOTnE2RzRTSTV1K2hoMWNzcEY0?=
 =?utf-8?B?S0l3blUzN1grVnlmYnhzZnBjb0FXdVV5NkwyNVFUZkdPUmorTmhPTDI1b2ZY?=
 =?utf-8?B?R2c2YjlPMlhyM1NZbkM0L2dRbUFneWlFRVZTRFcza2dPZ0czcS9wWTlySzhJ?=
 =?utf-8?B?djh3Z2VnNENac2c0ZFI0S1FBeUhHYkJ1U0h5UkhocGg0cUdXU1d3aWJlZ0t0?=
 =?utf-8?B?V0FuU0tleU1wWnZKMG52d1NVVFpDTWFFTE1IeUNvMSt3V2VXSUFOcXFnekw4?=
 =?utf-8?B?SXVKTVZjdGZnMENoOXdyV0R4Z245V1A5MjNOL2RQUnF0bDVBRHBwWFA1cmky?=
 =?utf-8?B?VzZkVGwwR0prT0xVSGlRWGo2WVk0M09GcmRhU1ByYnUwT0YyYmlzU29ZSWVR?=
 =?utf-8?B?NnVDRS9OcllZWHNHZTJmLzM5QVNueFJXd0gwRTVUNHVKVFRvSklianpack1m?=
 =?utf-8?B?SUJVTEJORlgxOThMQ2FENjQrQU4vUEp2S2d4WWplVUQ0OW1vUEVtY3IzTDY2?=
 =?utf-8?B?T1M0b1JJYkdSeEVpbXF4UUk1TmlHUVBwclJFTVVzSGkxSzFmcm9HQ3RVUUV6?=
 =?utf-8?B?T3hiTWVxazJNeXpjN0QxbVZ1OVJiM1BFQzNrNHh0TjR3djBaUStJVm5GZUlJ?=
 =?utf-8?B?V2RTYS9EYlhaUk9rb1FPQ2lBb3lFODVSaUQ1bGJNaXFEazRkQytvVDV4RXox?=
 =?utf-8?B?eDZEMy8xQ2thZDNaNk9sb0dYK0xPancyVGFSUFRtaHdpeURSSStwWGc0Y0pN?=
 =?utf-8?B?VUdIa1JoaGxTTFA4bWx4c3ZCdHRMdElsWlRjcHpDNkNGRDdWb1Z0ZnRvZ3Ez?=
 =?utf-8?B?Rm1JSTJqMk5xMkJWSXI4TGRzZ2NkK1J5MEIyL3ZnaHh1ZGZCd09VeGdJd2FZ?=
 =?utf-8?B?NWt0S2lyc0hCaUNDRTFTRDcwR1NRcmNzUG1uSkRhb09CZ2ZJbiswclh4R3Fr?=
 =?utf-8?B?dUZQZmxoODlrd1lKdmlEcGpzWklyV0VISmpxMnZYV01FeS9jN1ZpN1NtWWlo?=
 =?utf-8?B?eDE3NUI5MWlWalZ5ZzRzeHM4SHJra3RaK2x1S3dOTFI1eEdheXFCeFo4SktF?=
 =?utf-8?B?YzltTUVJbnFEUXdwVlBMd3JZSGVYRHF6cklrQi9QaDdJRWFweDRHd1ppRC9v?=
 =?utf-8?B?b09iZXV6SWllOGloUFZ5WGNHYmgzU0RlWGhDNzJUVWRqYjRmZ2NMam8vdTVM?=
 =?utf-8?B?SzdpN1ZzN3BLbmtja3lTVWphcU45VmM2eE5JWjlZbGVMNFhEWWY0ZUc5YTFr?=
 =?utf-8?B?Qk8zR2ljeElIZ1kwQndIREprLy9SeFUyQkJoR2tYWWlBdi9VUm9jV09ITWhq?=
 =?utf-8?B?VjhDa1BhZloxVmtzMnNKYThtdzFlRnRqZW04WjFoc3dLTEJaRWsrZGJRQXRU?=
 =?utf-8?B?QlFUTGk1NktkWWVVOFhKdVdPd09iTy9MVHN5Zm92aUVOSkRhYk9lMWx1V0Zk?=
 =?utf-8?B?LzJYWHI0Vzhna3p3SWRIUlNNcDZHUVJJOVRDZ2t6R1VNb1JqSlIwOWdWTWk3?=
 =?utf-8?B?TWp0ZG95NzNkbEdNT3M0aVhJWlFkV2ZwRVU5UENBcmVTbDREY2VORTYyK1NM?=
 =?utf-8?B?SDBseE9VSmkyemY1dXlybFMvN2cwUDVXSzk0WHhPUUZZZjRzczdBWkFDZHY5?=
 =?utf-8?B?ckppU2RON1g2cGZMZ2pwL0ZyemV2eURHbGpjWTZaYUJodDlVcTB2ZmJQakFC?=
 =?utf-8?B?b3RwSUtLdXdjU1V2RkNvb3lyUTBIYTdOdjE1ZkgvUjRpRFBVTExQSU1sU3Bh?=
 =?utf-8?B?aDZUekhiZDU0TndYOHdKMlhSSEJsZklOU3lBWGpCWFMxRWZIYWJrQmhFc1Y2?=
 =?utf-8?B?Y01xeDhjcDQ0WnVTZXY3Y0tqMGloR2htNytaeTBZM2ZkUDZmb0J4elRKbVpv?=
 =?utf-8?B?NWM5MlZqOEcxdGFCUzA2d2JjREQ5d1BTekZpQmtWVXBQL1JqamlwNkZYMlpM?=
 =?utf-8?B?cm5ZZmtvQWgycU5wR1lsWE1Cb3cwR3FDeWdJRjA4ejVibzhqQjBhRDBBRCtn?=
 =?utf-8?B?SzFHNmFHZDJyYnB5bmZaNFdCV1REMU9kd3c3a2pXYzBtWnBpMGxNQzc1ZzU1?=
 =?utf-8?B?aEROUDdkZzg1MzJYVXkvZDRwVTB5aUEzUHZERTFoK1FFMnpYUkk3MVQrZGln?=
 =?utf-8?B?d1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC34E8370E3A1D449FB72810A139CC6A@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 460f4212-83d2-4558-25a9-08db81c8e85b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 04:40:09.4507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Q9kli28GPC1xDIMyUttd9yb8s8HDLOTfQv2Dqucc76exnvDsqoGtKxkBoqecUP/Lx15Tj6o4LHtdLv2EviOvfpQmbZ4bxW+yEzIulkF7yY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB1818
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDEwLzA3LzIwMjMgw6AgMjI6MjQsIE1hdHRoZXcgV2lsY294IGEgw6ljcml0wqA6DQo+
IE9uIFNhdCwgTWFyIDE4LCAyMDIzIGF0IDA5OjE5OjA0QU0gKzAwMDAsIENocmlzdG9waGUgTGVy
b3kgd3JvdGU6DQo+PiB2b2lkIHNldF9wdGVzKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLCB1bnNpZ25l
ZCBsb25nIGFkZHIsIHB0ZV90ICpwdGVwLA0KPj4gCQlwdGVfdCBwdGUsIHVuc2lnbmVkIGludCBu
cikNCj4+IHsNCj4+IAlwZ3Byb3RfdCBwcm90Ow0KPj4gCXVuc2lnbmVkIGxvbmcgcGZuOw0KPj4g
CS8qDQo+PiAJICogTWFrZSBzdXJlIGhhcmR3YXJlIHZhbGlkIGJpdCBpcyBub3Qgc2V0LiBXZSBk
b24ndCBkbw0KPj4gCSAqIHRsYiBmbHVzaCBmb3IgdGhpcyB1cGRhdGUuDQo+PiAJICovDQo+PiAJ
Vk1fV0FSTl9PTihwdGVfaHdfdmFsaWQoKnB0ZXApICYmICFwdGVfcHJvdG5vbmUoKnB0ZXApKTsN
Cj4+DQo+PiAJLyogTm90ZTogbW0tPmNvbnRleHQuaWQgbWlnaHQgbm90IHlldCBoYXZlIGJlZW4g
YXNzaWduZWQgYXMNCj4+IAkgKiB0aGlzIGNvbnRleHQgbWlnaHQgbm90IGhhdmUgYmVlbiBhY3Rp
dmF0ZWQgeWV0IHdoZW4gdGhpcw0KPj4gCSAqIGlzIGNhbGxlZC4NCj4+IAkgKi8NCj4+IAlwdGUg
PSBzZXRfcHRlX2ZpbHRlcihwdGUpOw0KPj4NCj4+IAlwcm90ID0gcHRlX3BncHJvdChwdGUpOw0K
Pj4gCXBmbiA9IHB0ZV9wZm4ocHRlKTsNCj4+IAkvKiBQZXJmb3JtIHRoZSBzZXR0aW5nIG9mIHRo
ZSBQVEUgKi8NCj4+IAlmb3IgKDs7KSB7DQo+PiAJCV9fc2V0X3B0ZV9hdChtbSwgYWRkciwgcHRl
cCwgcGZuX3B0ZShwZm4sIHByb3QpLCAwKTsNCj4+IAkJaWYgKC0tbnIgPT0gMCkNCj4+IAkJCWJy
ZWFrOw0KPj4gCQlwdGVwKys7DQo+PiAJCXBmbisrOw0KPj4gCQlhZGRyICs9IFBBR0VfU0laRTsN
Cj4+IAl9DQo+PiB9DQo+IA0KPiBJJ2QgcmF0aGVyIHRoZSBwZXItYXJjaCBjb2RlIHdlcmUgYXMg
c2ltaWxhciB0byBlYWNoIG90aGVyIGFuZCB0aGUNCj4gZ2VuZXJpYyBpbXBsZW1lbnRhdGlvbiBh
cyBwb3NzaWJsZS4gIEZld2VyIGJ1Z3MgdGhhdCB3YXkgYW5kIGVhc2llcg0KPiBmb3Igb3RoZXIg
cGVvcGxlIHRvIG1ha2UgY2hhbmdlcyB0aGF0IGhhdmUgdG8gdG91Y2ggZXZlcnkgYXJjaGl0ZWN0
dXJlDQo+IGluIHRoZSBmdXR1cmUuDQoNCkkgdW5kZXJzdGFuZCB5b3VyIHBvaW50IGJ1dCBJIGRp
c2xpa2UgdGhlIGlkZWEgb2Ygb3BlbiBjb2RpbmcgcHRlIA0KbWFuaXB1bGF0aW9ucyB3aGVuIHlv
dSBoYXZlIGhlbHBlcnMgZm9yIHRoYXQuIElmIHlvdSBoYWQgdXNlZCBoZWxwZXJzIA0KZnJvbSB0
aGUgYmVnaW5pbmcgeW91IHdvdWxkbid0IGhhdmUgaGFkIHRoZSBtaXNoYXAgeW91IGhhZCBpbiB2
NC4NCg==
