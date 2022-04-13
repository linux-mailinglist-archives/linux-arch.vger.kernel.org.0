Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715D14FEF46
	for <lists+linux-arch@lfdr.de>; Wed, 13 Apr 2022 08:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbiDMGKP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Apr 2022 02:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbiDMGKO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Apr 2022 02:10:14 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90041.outbound.protection.outlook.com [40.107.9.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9674335AB0;
        Tue, 12 Apr 2022 23:07:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7k9IlD4YqjTjmLH88GSQUtICWLx9RA7LoEtmN9uHpnAZeoV0tST97xj/ZDF0RWdCKdN8aL9kvJRJnmBtz97XSAialtOcXrKv0O07dP5P3OB4qtovX7RtvvwTDiyCro1Ob1YyhkJtQ716amwqvXtX7DA4uhJKqkRWn2Ra5XKyl6czRr9Om4qiHwjCU7z5hRIAvjpNFg9JXwCcNduTwRzMzI/H9ide8E+n1w27sCa6zb2tltQqQbGRVDRDucYwN1Cv00Nlp43NFOaGy1ilnDG9qq7luaXXu/X6SPyyfK38MgxetwHsASIJvGWKJN9TkEO6X7irhgtSmJARV5lLy5MvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lotfj25gymw+66lxZeOp43qX/JSJZD/b+QUyDW7Y7Y=;
 b=jsx5gNMrWi0yJx7hHOET5uhlsAE9Mzo5FP201sWOmyngzefQkcUFsJC0pyFWPg7rZktBSFD99rUOquLUelgcQMaOdka1tvWqeMFoz+u7Jum5QbXxNCKR1RMQYC7qhMTdirlICfY0utYrnhMEd5dV6E80B/dNzUFXaYDo+j832Fb1YTpw9rVTBqO4zrl1SlLouStQNVIQ1SKAfaobyl3H1TA/6iTQWzMX+d05VWVN5zDNPgV+eJSuW7PNSWWTMB+oJKzGTvJkiNhIqSaDjoRLb6833WvC4bQyh6NQ495ihKpFVaoVcM6IJwKr7oEnsXUXDOwgmDn31R7AT7HgKQGnHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2137.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:168::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 06:07:49 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::59c:ae33:63c1:cb1c]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::59c:ae33:63c1:cb1c%8]) with mapi id 15.20.5164.020; Wed, 13 Apr 2022
 06:07:49 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V6 1/7] mm/mmap: Add new config ARCH_HAS_VM_GET_PAGE_PROT
Thread-Topic: [PATCH V6 1/7] mm/mmap: Add new config ARCH_HAS_VM_GET_PAGE_PROT
Thread-Index: AQHYTvt9uFmHBK9nfE6hekh92vZjMaztW6GA
Date:   Wed, 13 Apr 2022 06:07:49 +0000
Message-ID: <5527d07c-d9c9-b17f-22e9-1b2d3cde95c6@csgroup.eu>
References: <20220413055840.392628-1-anshuman.khandual@arm.com>
 <20220413055840.392628-2-anshuman.khandual@arm.com>
In-Reply-To: <20220413055840.392628-2-anshuman.khandual@arm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8024d83-dec4-4ffe-5603-08da1d13efd8
x-ms-traffictypediagnostic: PR0P264MB2137:EE_
x-microsoft-antispam-prvs: <PR0P264MB21379C8BFF50748170B86E31EDEC9@PR0P264MB2137.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CDbjLomtDTkrzDE9l0KHZglzpxHQ20C+0U0sL9uMbe9NoA9PziMZefRMDgsFyAHNNb+560M/fI9/xb9uqpwqBCjnkjVU6CgyAif4R+ElnR3Y8Q7AdrzDnbCtto4ktwPbozpXmb2tjRD0VR34X3QltqhgOrBm/5wRD2jpQxBhg3NRB0DPFR2PLA1SlP4VbK91JMYfsszwgczBNDuM/HAWBM0H8v6xvUoKBVMNHIWSXOkS4sCotCwG31JLEjjq6jV3lMF0Uu+6NOKGgv0aUMMIYYE/yQGgtmWUJpRYrnQlSQmqoSS/mKeDT9Wa+2LDPQbk/5uLxK38Uxk5W2Dbw8FEcc7J/834TJPq1uxVExu/saUImQbglfa06bXFORbNGW8+5AedqgKuv3iilGLrPQSaBrd1LW+w3Na5/+k9M9GaY9gtO78PAm+IsekpBYKyKfVRZYHfcSCJ3CcRytV704FbS0swbabxgtgq1v2RfDTZ+yK/lRGXKd9sRoDVb8ea2oXegxJQ04yYxeXhca29jrZHhh8rSWyKlHUNo5L4jjRmy7Od1pzGy3x8yjR87W38wq+nsHLaKg1bMHmYI4fRnrAzBxNJE6YrhXmzBzHOAOWTOPs0A+AGsK+cHxJos2VM4fhC7rDtkAxSDF+XNZaWRNR04MkbUO9EomEHzN8MR8ZEQYnEeLEP4/672OvfgwEKV0r2kTFfVosptKS1Qxy9UZeGd4YxB2zc0Be5d6pe9scq25pn84Z7Zs+P3oLaS59wzHnzsyN2PkwJnJTT5zYj0SrDGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66446008)(66476007)(186003)(38070700005)(86362001)(7416002)(66556008)(66946007)(36756003)(6512007)(508600001)(31696002)(122000001)(31686004)(2616005)(8936002)(38100700002)(26005)(6506007)(2906002)(91956017)(44832011)(110136005)(54906003)(316002)(76116006)(6486002)(5660300002)(64756008)(71200400001)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2I1WDA2MWdRb3pRbGJpTHlaczRCeVVlbE1FQ3llTjdINk9WY2RSWVRYUW1O?=
 =?utf-8?B?S0R0UmVrckd4RW8vcjVYUkxpcnV3d1g3d2pQT3FiRkgvVzRCeHFEeTJKSTY5?=
 =?utf-8?B?UXNpN25IR0V3V1llSVRWcmxManlYdjl6ZFJhdUhBVnNEUE1NZW9ndEZWY2x4?=
 =?utf-8?B?TVhyV2ppQm5BVUJsdWZpRnBsZ3R4YUVZaURVZlZtbWZCMEdRRDdYaUkrdmRR?=
 =?utf-8?B?QzhWcHcxTlE2ZmcyMzBZVkR0U2Z5bkhIajhielR4VGtDbTR3azdIVys3OENX?=
 =?utf-8?B?S0tWTDB3S3JpUmJLaVo0TEQ0Mzk0Y2k1T0VVRlVJTmNQUVpBUTRpeHBoc2Ey?=
 =?utf-8?B?T0tiTURIbm9sajAzUCtCY1BPbE1tWkRmWmJ1dEM2eTR5aWMrQUF4VzlGR0Jr?=
 =?utf-8?B?cXh2RUF3bTNJelV6NXRrN3FaNHZlTzRvOUo0VENDYVNnM29mdEF4OEV2eFVX?=
 =?utf-8?B?V1I4YWtZS05FZWZma3BiaEdhbm5tcTh2bGZMSjkvbk1xZmpqTmVaTlJqRjgw?=
 =?utf-8?B?ZVlZY21KTjBtMXhub3IxUEN0cmhEem9Ebkw2bXE0Si9XWnVOWExhSFBWUnJW?=
 =?utf-8?B?aVlaWWY0RzZRTjBFYmFzY0ZBUXhLWm5uVytTQUpSWDVHSFZpZURzY0tCS1Fj?=
 =?utf-8?B?R2Z1dWJPT0JFK1lRbjhCNm41UTBXYjZUOGVPeE5tMnVaUzhxbytTRnZNNWUv?=
 =?utf-8?B?YWtxZDJYcFBaWWlSbmxYR2FYVEp3dFBPT05hamV1NFhhR3BnNG0zaXN2UjFz?=
 =?utf-8?B?VGtpdDRhYzNlaWtDQ3JWdWNXWmJQVVl1aVN1ZSt3T1RYczdBaTZlYmI2WjNY?=
 =?utf-8?B?eithVXJ2eTdQTXJzc3JnY3RFTFVpYVZCdGNaRyt6RE9JN1pIWWdoUlR1RDBh?=
 =?utf-8?B?YTNjTlpSaDdDMm9uSFJFWk1RcUNKVERwRDR3OVFhKy9IRWdmLy9MbjE0Y3By?=
 =?utf-8?B?bVJJalo0anNDRUJHWlNRUkpUYXpPaEs2S1phT0pVZ1ZDY3ZVZUZEK0ovYnRO?=
 =?utf-8?B?ZHlVQXpZSmNacW1ZNkpJUkhqZXgweGJVQjhvaUdDejZNTHc1bEkxTE9aQ2Vo?=
 =?utf-8?B?THdaT3A3djFPSTZVN0x1ZVdYc0t0RmtCMjE4MXF3QjIwYWpoTlhhVjdZK0dZ?=
 =?utf-8?B?d2laS0NFVURFOTZLUkd1U25UcHRyR0txQnhXTkVvbGJ0T1dVdVhJRzZGQUYz?=
 =?utf-8?B?L0h4UjVvOFBDMG5CcitSdGE3Y1VqY29nOXFkcDBZbURsNFlsd3FhcG84UlJy?=
 =?utf-8?B?b3Y4cVRLMnV0ZkVPV2s1M0J4TDRzOUUxbFhDUHdSMlBIdnc1MFJkNkZuM0Qz?=
 =?utf-8?B?YnhwOXJTTDhPZ0dFZHFac1Raa1ZDQmpJNUYwdEpTSlIzaDB0eVllTzRlNGhz?=
 =?utf-8?B?dUFzUWgyb0k4RW1ITHBOYmc1QjdqdENKZVorNGxDZU5vbm5wZjc4cklqbEcw?=
 =?utf-8?B?Vk0xVlJrSmRsTEJhTXpLSFB0WnFwNWRmYmpNbUkzMUMwVnFwYnhpUXZsb0lT?=
 =?utf-8?B?SGRIRG5DMnI3dllRWHVGb0UxQVdoRktjSXE4WFllTU04MDV5OTVtNVRxRjI2?=
 =?utf-8?B?c2hERFhVeStxcC9rTU5wZzJmMlQ0T1BEWncvekltRFdhaWtDQ0RQSERNVWRq?=
 =?utf-8?B?WnY3dmYxNkF6ZHNIK0JkeUFsL1VJdjcxaVVhQjQ4aXc0SWpRY2JrOFZlYXVJ?=
 =?utf-8?B?MG5xbU55VVhDUDVIR3ZrOFNCTWd4c1ZaZ05SM3NEeHBPV2oyTFgyMUJscWRN?=
 =?utf-8?B?amIvcUhpREtmQ2s5alZneXNDTEU2TTFvUm5ZNWpEWVR5REMvajRzUnEzbjJp?=
 =?utf-8?B?MmJGZ25mREtPbUlhNnAvUmY5NGxQZWQ5V2VmTjUwRlNFZnZMVXJlY2ZFTlEw?=
 =?utf-8?B?TkpUZEFhSUFZTVF2RzZHVDlqTHN4SEJJcXp1a3VHR3NPU2NhamN5QW5uR3N1?=
 =?utf-8?B?bGF5amxtNlhqY3hmSU9nY01UNHYrcHR4NFNJbmQrU1ZEaEVjQnl4a0gwSGdK?=
 =?utf-8?B?a0Z4S0tZRlc5SXNrd3JjVk1KbmZ2WnJyc0xqUllXbHRMOFR0ZGY1cFQyVGZ5?=
 =?utf-8?B?UTFpWlV1N1E0T1V3NGFvS1Vac1hVTVM1RnFBeWNXdVpUOTA2OHJ2ZEdZdFIx?=
 =?utf-8?B?TlppUm1McGVJM0lMZFdNTHVnV2ZxTWkxQk9RTGZNTDk1a2RKQVlJek50U0xC?=
 =?utf-8?B?VnFDSEYwTlkremxwVmJXaHlvZ0tETUhDdHhQVmRXSjQ3N3dRUWM5ZXJnU1NR?=
 =?utf-8?B?UzV5M2VYS0FidWttQ1ZLdE40K09UaFZmaDUyZHFLcTU1bEVja0xINlZReHBs?=
 =?utf-8?B?eUR1eTNHbDdZQ0VMZDhZbFNkTy9YZUlxL3d0ZUtDcUJPcThDOWkzaEYycUVF?=
 =?utf-8?Q?3ZcEOmp5yunoAZCc8yScMffVVYsEYzsSaPWRT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1206DB192815D145881CD1245F45DF2A@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b8024d83-dec4-4ffe-5603-08da1d13efd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 06:07:49.1081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jE2cH91+NY8uCAu9Zt7I1hxgglkrRNpAvDvusOpYODq/8SCqX4yGms+amAfuMqQ1K77tf2TM+PEtBy0E1v7VFN0L5Tm9e+mg2vaPjzYtF+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2137
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDEzLzA0LzIwMjIgw6AgMDc6NTgsIEFuc2h1bWFuIEtoYW5kdWFsIGEgw6ljcml0wqA6
DQo+IEFkZCBhIG5ldyBjb25maWcgQVJDSF9IQVNfVk1fR0VUX1BBR0VfUFJPVCwgd2hpY2ggd2hl
biBzdWJzY3JpYmVkIGVuYWJsZXMgYQ0KPiBnaXZlbiBwbGF0Zm9ybSB0byBkZWZpbmUgaXRzIG93
biB2bV9nZXRfcGFnZV9wcm90KCkgYnV0IHN0aWxsIHV0aWxpemluZyB0aGUNCj4gZ2VuZXJpYyBw
cm90ZWN0aW9uX21hcFtdIGFycmF5Lg0KPiANCj4gQ2M6IEFuZHJldyBNb3J0b24gPGFrcG1AbGlu
dXgtZm91bmRhdGlvbi5vcmc+DQo+IENjOiBsaW51eC1tbUBrdmFjay5vcmcNCj4gQ2M6IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gUmV2aWV3ZWQtYnk6IENhdGFsaW4gTWFyaW5hcyA8
Y2F0YWxpbi5tYXJpbmFzQGFybS5jb20+DQo+IFN1Z2dlc3RlZC1ieTogQ2hyaXN0b3BoIEhlbGx3
aWcgPGhjaEBpbmZyYWRlYWQub3JnPg0KDQpSZXZpZXdlZC1ieTogQ2hyaXN0b3BoZSBMZXJveSA8
Y2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1Pg0KDQo+IFNpZ25lZC1vZmYtYnk6IEFuc2h1bWFu
IEtoYW5kdWFsIDxhbnNodW1hbi5raGFuZHVhbEBhcm0uY29tPg0KPiAtLS0NCj4gICBtbS9LY29u
ZmlnIHwgMyArKysNCj4gICBtbS9tbWFwLmMgIHwgMiArKw0KPiAgIDIgZmlsZXMgY2hhbmdlZCwg
NSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbW0vS2NvbmZpZyBiL21tL0tjb25m
aWcNCj4gaW5kZXggMDM0ZDg3OTUzNjAwLi5iMWY3NjI0Mjc2ZjggMTAwNjQ0DQo+IC0tLSBhL21t
L0tjb25maWcNCj4gKysrIGIvbW0vS2NvbmZpZw0KPiBAQCAtNzY1LDYgKzc2NSw5IEBAIGNvbmZp
ZyBBUkNIX0hBU19DVVJSRU5UX1NUQUNLX1BPSU5URVINCj4gICBjb25maWcgQVJDSF9IQVNfRklM
VEVSX1BHUFJPVA0KPiAgIAlib29sDQo+ICAgDQo+ICtjb25maWcgQVJDSF9IQVNfVk1fR0VUX1BB
R0VfUFJPVA0KPiArCWJvb2wNCj4gKw0KPiAgIGNvbmZpZyBBUkNIX0hBU19QVEVfREVWTUFQDQo+
ICAgCWJvb2wNCj4gICANCj4gZGlmZiAtLWdpdCBhL21tL21tYXAuYyBiL21tL21tYXAuYw0KPiBp
bmRleCAzYWE4MzlmODFlNjMuLjg3Y2IyZWFmN2UxYSAxMDA2NDQNCj4gLS0tIGEvbW0vbW1hcC5j
DQo+ICsrKyBiL21tL21tYXAuYw0KPiBAQCAtMTA2LDYgKzEwNiw3IEBAIHBncHJvdF90IHByb3Rl
Y3Rpb25fbWFwWzE2XSBfX3JvX2FmdGVyX2luaXQgPSB7DQo+ICAgCV9fUzAwMCwgX19TMDAxLCBf
X1MwMTAsIF9fUzAxMSwgX19TMTAwLCBfX1MxMDEsIF9fUzExMCwgX19TMTExDQo+ICAgfTsNCj4g
ICANCj4gKyNpZm5kZWYgQ09ORklHX0FSQ0hfSEFTX1ZNX0dFVF9QQUdFX1BST1QNCj4gICAjaWZu
ZGVmIENPTkZJR19BUkNIX0hBU19GSUxURVJfUEdQUk9UDQo+ICAgc3RhdGljIGlubGluZSBwZ3By
b3RfdCBhcmNoX2ZpbHRlcl9wZ3Byb3QocGdwcm90X3QgcHJvdCkNCj4gICB7DQo+IEBAIC0xMjIs
NiArMTIzLDcgQEAgcGdwcm90X3Qgdm1fZ2V0X3BhZ2VfcHJvdCh1bnNpZ25lZCBsb25nIHZtX2Zs
YWdzKQ0KPiAgIAlyZXR1cm4gYXJjaF9maWx0ZXJfcGdwcm90KHJldCk7DQo+ICAgfQ0KPiAgIEVY
UE9SVF9TWU1CT0wodm1fZ2V0X3BhZ2VfcHJvdCk7DQo+ICsjZW5kaWYJLyogQ09ORklHX0FSQ0hf
SEFTX1ZNX0dFVF9QQUdFX1BST1QgKi8NCj4gICANCj4gICBzdGF0aWMgcGdwcm90X3Qgdm1fcGdw
cm90X21vZGlmeShwZ3Byb3RfdCBvbGRwcm90LCB1bnNpZ25lZCBsb25nIHZtX2ZsYWdzKQ0KPiAg
IHs=
