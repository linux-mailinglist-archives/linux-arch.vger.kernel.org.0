Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF9C78F204
	for <lists+linux-arch@lfdr.de>; Thu, 31 Aug 2023 19:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238623AbjHaRin (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 31 Aug 2023 13:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjHaRin (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 31 Aug 2023 13:38:43 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2041.outbound.protection.outlook.com [40.107.9.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98656CF3;
        Thu, 31 Aug 2023 10:38:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1+v0nJxk5ZUVhKg487Y1x2NAF8DQm/nmZyu/oc4rNmRBLkEp6sbKanKmtUzU2ic90WMDWBoKDTbW5PlMgpT0by45CTOjVNTBoV9mV5afbcm8tiNLCIkvjNZ4js7L7BPmVsZpAVIbsiQiOdXsy5IY6UvhcvtZ0PpPH99W/WQqP2dC+K2N40oGaaKWnppw0imJxuqwcG3uHLHATJ973Y4QvhzKBDar4c5nGdkmVcJq4FWBtypfWxmZM4LQjDkUEZURaJ+aSppmJiAdwUy/GfehBXH+kuTByRn0f3yQZNsxkahNVTW/WZbLw45J/xCA6+aV78uV1pC3DlpyVsa+tOzCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgjyH6m5X8uo/d3WzInbuzQVzracSEjcT5WEZ1QnITw=;
 b=eDp8Gch+PBSswbJuO05hDXelBluddLGQTDkR1HtDtZ1WZ99YfTDJt5yMrkE3KGcbDUL8kw87TPJhScUr5bsMQgkxc6hDws13OzRrX+qnLLgNH0LGd36O4NOVaFO5azMT4mx4q+i8/HdldmfM6gxtrsDdXkk+ax3oPeAVg4qtNhEIQTgln6WxqFzAzCjL7wF6bgHWp2KLiHRZHf51Y9k7v8IaUTxP6IoHQaWKSz1m/jEr8K4D/vsBmsuOWHDicMNR1l349g6hR2Vas70hGPrDnlQcn3Se63Fw/6y+d1tkDbpP6as8mbrn7AC2voGUxLKGlCJWOYyLvKDG0XsTFzzbQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgjyH6m5X8uo/d3WzInbuzQVzracSEjcT5WEZ1QnITw=;
 b=Ail3EzdY+x8J3WJ0X4pFAVYpmhBS1mWANYQSekGov0z6jA/CkOODxNIusSscf6aUgBsPSo/IANWwQdUMW+3Wt3yNm7P3dVAIyS8U9HpBb82hJggHLJTV6q9bByDaiwHt+B036BvTG5FfJhV2DVSf2DvjdVgI+1nqsf9/oAoKnWSlmkIaYeRQ7pziYQe2YFq3D4ceNNfosRIJI97y8z/9KmU2+Ft8ryL3OTAGusDXLoaqPeXOQMabBBfLmCnm5qcA6qZyb4MYEhJQptkb3tnjPkkvdmDHwKjT4T288jUO8Ttx0yQaOQJeYEBNmhLN2EUu+7/+MD7j0SLmhlKW1vbIyg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB1632.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.25; Thu, 31 Aug
 2023 17:38:36 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e%7]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 17:38:35 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Thomas Zimmermann <tzimmermann@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Helge Deller <deller@gmx.de>
CC:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: Framebuffer mmap on PowerPC
Thread-Topic: Framebuffer mmap on PowerPC
Thread-Index: AQHZ3BlEDkN2rOOk3UWNJ6HsYG/HmLAEq7sA
Date:   Thu, 31 Aug 2023 17:38:35 +0000
Message-ID: <aea5e33a-1251-3188-6222-719fe9358762@csgroup.eu>
References: <5501ba80-bdb0-6344-16b0-0466a950f82c@suse.com>
In-Reply-To: <5501ba80-bdb0-6344-16b0-0466a950f82c@suse.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR1P264MB1632:EE_
x-ms-office365-filtering-correlation-id: cb0c4329-d604-45b5-7606-08dbaa491a98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7WLUaQXLmHgdI3mj838WjzYINDKGz2vQOa4Oeg1K2Bser/f8cNVPKvho5mrntZAEUaxcR+5XEPZKB38JlHwAmzrl+y/IJEnWn1H1qhyvHyPEmNIFfiaVgQZ86kBsh6BGKtkVhV2HZQSpMJ6SiCSbBYb1m86IIk5BXkYCrruJmdiuVE4XKKTwaBNFDAJO5w8JPKWK959u5GJzW8GIOXxiDz3J0jrYByajyGDM5fdXvU17SBZgJESAkehH6zXkjhebH8rpvaAXAynckBZXpm3dKFURnqNrJmVMiyIYOZv8A4eCNLBPYQKAKBuL7xo+L9L76TiQZFHHFsNh7RihZ8rQRYnZe16Mg7PKK1yYw6iSzncBK5tfFQ73BQuhMxUSt2Ok7sPoaw/8p8CMEvnNHmUpKqGWA2CY1WJXDj/KlJsZR0MtKLuwWyZJAIVb5qZ9C5Dzk2LLtZcpS50cyN2V7vpge4isG6ZlTVf6DV4sQrdI+/uTHQ6aAfByRbeSJTnrTl0qe6ELq9ypTe0yvtGFjOSeeWGJmJAjcS0LERHbNrLZDaFzbdRZhSY9+yH5bVOjvc4Ug15KEC4IeEIVyeVb3Is+eKXO/GKZ8yN9RUIWd6qekP9MOvr5QXNQcmonmYasdTXv3owe+k6ULzG4s9JzwrryLOwnXMmbG0TY7+t0niA5Uxw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39850400004)(1800799009)(186009)(451199024)(41300700001)(122000001)(38100700002)(38070700005)(86362001)(31696002)(966005)(478600001)(2616005)(83380400001)(71200400001)(26005)(3480700007)(6506007)(6512007)(6486002)(66574015)(76116006)(54906003)(64756008)(66446008)(66476007)(66556008)(36756003)(2906002)(91956017)(110136005)(316002)(66946007)(8676002)(8936002)(44832011)(4326008)(31686004)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1FLT2I2Qlg4cDF0Z0U5VmhWUnRoNUlmK2kxMkZnN1hwNmNtTy81U29SdEVP?=
 =?utf-8?B?aERJeHVnbUllT1M5TGlibGJqV1ZuYjIyTTRmKzJTL2pINHdnU0g3VDVJOFRO?=
 =?utf-8?B?aC92bDhLUWdMazVIQXlQT3dMemlSZ29RWDJzZHIvODZiUFRuUngzdzRrOE9u?=
 =?utf-8?B?djBRRjZCQkQ3V0VoNDFXNUwwblladnplSGFLbXp0aHpJVDdoNXJ3TGRpVStY?=
 =?utf-8?B?WERNL2o2S3d2Wi9Xa0FOK1lkMnpSeVVlNWpwYlpKNHRNQjdPaU1QNzdEWUgw?=
 =?utf-8?B?b1RlRkorbWxOT1Y2WFlFNUhxb1pKeldPMzlmdXdFZHhSKytnZVVJdlpWSWJU?=
 =?utf-8?B?ZUhiaWl0eE00TlN2UHcrZUZsenRwRkVhcVZhQ3ZWV05XekUvZjFpME92Rk5B?=
 =?utf-8?B?WHFXOUUzdDdCVkZSZUFjd3BvR2tSdWoxQ0F6YTdZZ2YweFhwSHhpZlZjUXpj?=
 =?utf-8?B?MVlmVkJZZ0VnTGVKVzR0R1FWQlg0QU5DaGdQVkhxT2ZsWEtPa3VuVnZDcEp0?=
 =?utf-8?B?RTRva1c2aUM5QWVWblNjMmhrQzB1NHdkemx6dXNuWUdwVlBkempvUTNyZlM5?=
 =?utf-8?B?ZjBaRmJ3TE04MkExZktTdHhVVXcvY0hRRnkzUzM0RnIxUHp2ckluZnZncXh0?=
 =?utf-8?B?RWtwd2JyK2xjUE5WVzkzNGJHNEtCb2hTRUhFQTYycHAvbmpOQmV1WldMT1lJ?=
 =?utf-8?B?bEZuOTkwMHdHRFV3VDVaS2xQcEJwVC9sbWRmM2IzMmZoTlZ2ZkZkcWRMKzVz?=
 =?utf-8?B?VmlhU3orT1ZUV0JDMTlkbUtQTjQyLzZaWm15b2R0TnM4bVh0VExoeEZKUzRW?=
 =?utf-8?B?S1JMUk1RZG5tQW0zQktqYnFLOU1MeG1OSElka3oyM0pCd2FYNzhMV292Q3Y5?=
 =?utf-8?B?TU1pdHVCb0lITzlEaE55UnBrVy9XelVQNzg0YmFlY1lreXNXZ1BTOEE5VWNZ?=
 =?utf-8?B?dE5TYUZGVXFoVEN1ME5kb3h6MFhMT05taTh0YWprdjltb2NOdTBkUXRCSGlL?=
 =?utf-8?B?Qml0bktkK2crZDRER0tuT2NOOXBsYURXbVJhVGdFaWk1cE1xUXJCQWdHRGZ5?=
 =?utf-8?B?WXhUSG02ZVpWbVVBMjRoejFpdmptaXhHeDBCQ05sV01Wd01HVjUwcTZwTS9X?=
 =?utf-8?B?ZUdtN3h5bFNnSzBNNTI3OUY5c1lpRklYcGYrb25BRWtvR2tqMm5WZVNFZjlP?=
 =?utf-8?B?NUIvcjZBWjNJTUlDTzVtUXNRZmMxUE9aazJ1SFNBTUM3TzJJZDZ2YVBYcnRM?=
 =?utf-8?B?ajRGT0lXaE9aZXRXTjNJY2dqL2lhbE9UUjNrT0xYN0JjdU51Z1VaVUlqRjBz?=
 =?utf-8?B?NGx5dkQrSUxVb0kwNzFrODQ0Q1ErZE84UDNidjRXSjhhTHlMQU5RN0xHUVJi?=
 =?utf-8?B?b2w3cTVCM3RacCtONjMySXhIUWs5UmQxcDVOMnpWanV6TlpRbXR2aHVTc3hl?=
 =?utf-8?B?MkZpVWNxV0NINzIvRFJsT0lNUXFhMFY3K3pRN1k0WG1QZUVNVndwQ3RXbUxN?=
 =?utf-8?B?aDNtc2Z5dkV4RUpNeHA4UG1RbEtvUnhWNFVZdlFzNW81SzduendoUDBZOFM5?=
 =?utf-8?B?Ly9BWlZSR1Q3cGMxNkIrN0hlT1pWT2pVWnlDVkNoNTFJeDU1SS8yNmdrVDZM?=
 =?utf-8?B?dWRaaG5RWGxJRVIvR3BTeXMwNWRBMG5tbnBWVUxsZEFwdXpKNkE1aitUOVZE?=
 =?utf-8?B?WFZUTStsRWtqS1dTeDNwWjVkL29qczJKK0RtRTdTOTBOUmlNV3NCWWp5TlBZ?=
 =?utf-8?B?aWg0SjdnQ0ROcTZaRlUrczY3bTUwWVFmSDdmZy9TNi9ack52a241TzdLa09F?=
 =?utf-8?B?MjlNaEZDckhsVnZ5bVpBVUFkREtLTmtCbytqQWV2S29zNHg5Z21BdTkrV2x3?=
 =?utf-8?B?azc1aDBjN3BjOFVzb2UrcXBNdk9HRlZObmZvMytRTWNaNXRYNUJYRnorZWUx?=
 =?utf-8?B?RzE0MTkzbkRuQTZKZko1U2ViRGJUTS9Rbkl4RTBCZklTcGU1QmlOM1UrcW9s?=
 =?utf-8?B?UTBRcWlwRi9palJyd0JrWTIzV3d2czU5UElxUmtYanpyOGJWQ3dWWnZoOFlj?=
 =?utf-8?B?eWVPQlgrUUlmV3Q0NEFHc0p6SUhPWHo4eFZSYVA3VmpSR3p6RFlwOXFac1A3?=
 =?utf-8?B?bDJMUGtyK1UvSTVPS1R5N2hkOVc0TlZtTTd6N29ITm9EM21CR0hhTGJxRlc1?=
 =?utf-8?B?akE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B24713005EED35499F6AA3AABA0F0C79@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0c4329-d604-45b5-7606-08dbaa491a98
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 17:38:35.8405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0au0hYKTzqBOEQ8hSDkYro8dlnaZSUHgU9daR2TZMvgSIlyL5fJNyU4R2LCzlpIWbJiP8qPnHmdh3CEaepWQ8QZHeu+CGiUGRInGlxM1gLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1632
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDMxLzA4LzIwMjMgw6AgMTY6NDEsIFRob21hcyBaaW1tZXJtYW5uIGEgw6ljcml0wqA6
DQo+IEhpLA0KPiANCj4gdGhlcmUncyBhIHBlci1hcmNoaXRlY3R1cmUgZnVuY3Rpb24gY2FsbGVk
IGZiX3BncHJvdGVjdCgpIHRoYXQgc2V0cyANCj4gVk1BJ3Mgdm1fcGFnZV9wcm90IGZvciBtbWFw
ZWQgZnJhbWVidWZmZXJzLiBNb3N0IGFyY2hpdGVjdHVyZXMgdXNlIGEgDQo+IHNpbXBsZSBpbXBs
ZW1lbnRhdGlvbiBiYXNlZCBvbiBwZ3Byb3Rfd3JpdGVjb21pbmUoKSBbMV0gb3IgDQo+IHBncHJv
dF9ub25jYWNoZWQoKS4gWzJdDQo+IA0KPiBPbiBQUEMgdGhpcyBmdW5jdGlvbiB1c2VzIHBoeXNf
bWVtX2FjY2Vzc19wcm90KCkgYW5kIHRoZXJlZm9yZSByZXF1aXJlcyANCj4gdGhlIG1tYXAgY2Fs
bCdzIGZpbGUgc3RydWN0LiBbM10gUmVtb3ZpbmcgdGhlIGZpbGUgYXJndW1lbnQgd291bGQgaGVs
cCANCj4gd2l0aCBzaW1wbGlmeWluZyB0aGUgY2FsbGVyIG9mIGZiX3BncHJvdGVjdCgpLiBbNF0N
Cj4gDQo+IFdoeSBpcyB0aGUgZmlsZSBldmVuIHJlcXVpcmVkIG9uIFBQQz8NCj4gDQo+IElzIGl0
IHBvc3NpYmxlIHRvIHJlcGxhY2UgcGh5c19tZW1fYWNjZXNzX3Byb3QoKSB3aXRoIHNvbWV0aGlu
ZyBzaW1wbGVyIA0KPiB0aGF0IGRvZXMgbm90IHVzZSB0aGUgZmlsZSBzdHJ1Y3Q/DQoNCkxvb2tz
IGxpa2UgcGh5c19tZW1fYWNjZXNzX3Byb3QoKSBkZWZhdWx0cyB0byBjYWxsaW5nIHBncHJvdF9u
b25jYWNoZWQoKSANCnNlZSANCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjUv
c291cmNlL2FyY2gvcG93ZXJwYy9tbS9tZW0uYyNMMzcgDQpidXQgZm9yIGEgZmV3IHBsYXRmb3Jt
cyB0aGF0J3Mgc3VwZXJzZWVkZWQgYnkgDQpwY2lfcGh5c19tZW1fYWNjZXNzX3Byb3QoKSwgc2Vl
IA0KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuNS9zb3VyY2UvYXJjaC9wb3dl
cnBjL2tlcm5lbC9wY2ktY29tbW9uLmMjTDUyNA0KDQpIb3dldmVyLCBhcyBmYXIgYXMgSSBjYW4g
c2VlIHBjaV9waHlzX21lbV9hY2Nlc3NfcHJvdCgpIGRvZXNuJ3QgdXNlIGZpbGUgDQpzbyB5b3Ug
Y291bGQgbGlrZWx5IGRyb3AgdGhhdCBhcmd1bWVudCBvbiBwaHlzX21lbV9hY2Nlc3NfcHJvdCgp
IG9uIA0KcG93ZXJwYy4gQnV0IHdoZW4gSSBmb3IgaW5zdGFuY2UgbG9vayBhdCBhcm0sIEkgc2Vl
IHRoYXQgdGhlIGZpbGUgDQphcmd1bWVudCBpcyB1c2VkLCBzZWUgDQpodHRwczovL2VsaXhpci5i
b290bGluLmNvbS9saW51eC92Ni41L3NvdXJjZS9hcmNoL2FybS9tbS9tbXUuYyNMNzEzDQoNClNv
LCB0aGUgc2ltcGxlc3QgaXMgbWF5YmUgdGhlIGZvbGxvd2luZywgYWxsdGhvdWdoIHRoYXQncyBw
cm9iYWJseSB3b3J0aCANCmEgY29tbWVudDoNCg0KZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9p
bmNsdWRlL2FzbS9mYi5oIGIvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL2ZiLmgNCmluZGV4IDVm
MWEyZTVmNzY1NC4uOGI5Yjg1NmY0NzZlIDEwMDY0NA0KLS0tIGEvYXJjaC9wb3dlcnBjL2luY2x1
ZGUvYXNtL2ZiLmgNCisrKyBiL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9mYi5oDQpAQCAtNiwx
MCArNiw5IEBADQoNCiAgI2luY2x1ZGUgPGFzbS9wYWdlLmg+DQoNCi1zdGF0aWMgaW5saW5lIHZv
aWQgZmJfcGdwcm90ZWN0KHN0cnVjdCBmaWxlICpmaWxlLCBzdHJ1Y3QgDQp2bV9hcmVhX3N0cnVj
dCAqdm1hLA0KLQkJCQl1bnNpZ25lZCBsb25nIG9mZikNCitzdGF0aWMgaW5saW5lIHZvaWQgZmJf
cGdwcm90ZWN0KHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLCB1bnNpZ25lZCANCmxvbmcgb2Zm
KQ0KICB7DQotCXZtYS0+dm1fcGFnZV9wcm90ID0gcGh5c19tZW1fYWNjZXNzX3Byb3QoZmlsZSwg
b2ZmID4+IFBBR0VfU0hJRlQsDQorCXZtYS0+dm1fcGFnZV9wcm90ID0gcGh5c19tZW1fYWNjZXNz
X3Byb3QoTlVMTCwgb2ZmID4+IFBBR0VfU0hJRlQsDQogIAkJCQkJCSB2bWEtPnZtX2VuZCAtIHZt
YS0+dm1fc3RhcnQsDQogIAkJCQkJCSB2bWEtPnZtX3BhZ2VfcHJvdCk7DQogIH0NCg0KDQpDaHJp
c3RvcGhlDQoNCg0KPiANCj4gQmVzdCByZWdhcmRzDQo+IFRob21hcw0KPiANCj4gDQo+IFsxXSAN
Cj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuNS9zb3VyY2UvaW5jbHVkZS9h
c20tZ2VuZXJpYy9mYi5oI0wxOQ0KPiBbMl0gDQo+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29t
L2xpbnV4L3Y2LjUvc291cmNlL2FyY2gvbWlwcy9pbmNsdWRlL2FzbS9mYi5oI0wxMQ0KPiBbM10g
DQo+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjUvc291cmNlL2FyY2gvcG93
ZXJwYy9pbmNsdWRlL2FzbS9mYi5oI0wxMg0KPiBbNF0gDQo+IGh0dHBzOi8vZWxpeGlyLmJvb3Rs
aW4uY29tL2xpbnV4L3Y2LjUvc291cmNlL2RyaXZlcnMvdmlkZW8vZmJkZXYvY29yZS9mYm1lbS5j
I0wxMjk5DQo+IA0KPiANCg==
