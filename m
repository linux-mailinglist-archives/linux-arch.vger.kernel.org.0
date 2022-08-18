Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226F6597E51
	for <lists+linux-arch@lfdr.de>; Thu, 18 Aug 2022 08:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243501AbiHRGAn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Aug 2022 02:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243492AbiHRGAm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Aug 2022 02:00:42 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90070.outbound.protection.outlook.com [40.107.9.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81917E00C;
        Wed, 17 Aug 2022 23:00:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpllEyECQTSzavIm2LhJ8XmqXvZE0AH2AgKjiYOeBvNukpA4Pi5m/pq5EIAXVmnNRF1S5FWuZVAtalzN8ikkykgiyN/UUb1pQqwjmo+4ClTZtSXINuSs940v4CuSsNMbNoc1Qzo2r0P/jitzF5qxMU0L2s3sQ0dvWpKUBnXxnneF3w10/n5faQy1iugxCGMPfSO1skcgvyMcBb3WUBgpzdYLfaNSEBrrFNyDw0Jd0JDDXOWy/i/sQY0D+1gHQ4k9reJEjRdpC8hvcqaYX04frAycJbW3ssttrng/dD/Pxq5gKnl9wiqrTU3dGlB+hru9ze9Vmy7E9ZDH2I0UljC41A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDHheIS2ijWIAHjqTyuM8K/l/cnq9I/DJ4jehW1O45k=;
 b=Xwu/sW6jNW9Gi3FV3r7n6Qi6mSutams97M9Z9ILm8qMzToVVi+fKARbQUP9Q0oTDILHrsLf8HSYG0iPBPxjwMEjjCzCCLmSWoikS9dUpvYSBpjmPL1UGZ26/stC4Zv/B55OzkvC01Kr2NHNCd8y0tN5MdyFtpUWnm9aeiHhUV4wT19FqCCSkaIyGT++nwjlnqYLrxxxJtG4C117Xy+C50SlO40pj3UAInnrhp0oGVCkwOSS9dw+QWyu1Cbid2QA8JtHDMw1JzwqR0lqKk5pOUdt1UCKkSquG6xLW6y6E8znP870Uh0By97zd/YV5lpPQiqWiBwvll1x8VU0+IKBvIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDHheIS2ijWIAHjqTyuM8K/l/cnq9I/DJ4jehW1O45k=;
 b=dWnbogsCteaJnNu1D0CUy5/KlnyztfD82JxEXeoPU2gFLQt6Ra9WUHViPVUjHeFGX3EpFUuCNFCOuM/gM/urMlhj0U0xHC3w2AQg79gdC2HFPo/8ZC8g3avi0HIks/C1yV6+zKybmSmbBJCajgqLZCyHiJl6tiYFHOzYV4qOTnUAc94ydlJJc9qg9I+x9OoWtfoHmVhviRAWMF8R3JXVt6VEGvnZIn3pHmu/qLKEZ9dIaJsK7CC07HYcUc2k1Q/bmNfC9+u0aLyTcalWX27V+Pk+swYbUqIE3iMk6lWsRDBXhYd4rWYSTwnCc8IwQAeaA7Dab6VlByLmvU35/84A8Q==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2089.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:166::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 18 Aug
 2022 06:00:37 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::888e:a92e:a4ee:ce9e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::888e:a92e:a4ee:ce9e%5]) with mapi id 15.20.5504.028; Thu, 18 Aug 2022
 06:00:37 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] gpio: Allow user to customise maximum number of GPIOs
Thread-Topic: [PATCH] gpio: Allow user to customise maximum number of GPIOs
Thread-Index: AQHYq9yc0+2EsNg9hki12SrFrcAXy62zatcAgADNGwA=
Date:   Thu, 18 Aug 2022 06:00:36 +0000
Message-ID: <6103c908-dc48-40e2-2a89-b0f31e4c55f4@csgroup.eu>
References: <f31b818cf8d682de61c74b133beffcc8a8202478.1660041358.git.christophe.leroy@csgroup.eu>
 <CAK8P3a3bJVTLZy3HnVvEN8zDgzAMhSUdUkZ5Jd=omNjYJZKA4Q@mail.gmail.com>
In-Reply-To: <CAK8P3a3bJVTLZy3HnVvEN8zDgzAMhSUdUkZ5Jd=omNjYJZKA4Q@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfdff4c2-0dd6-4627-6271-08da80def8b2
x-ms-traffictypediagnostic: PR0P264MB2089:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 404mfDtSGs0UCeO+qHMUixkESs278/4bvbrNFiD0Xdm0ZAAiDCoS1WFpX7PYf9SemEMzm8w9GI9l9r+PS2ChiV/NuFBHVFuJWLtBr2P/1Ou6G2f4VkdNjwv0NiBzwon8/03sO/VjBRpXjKRZxq1Fsb4WbRy9uW4FuN/Dln789afY7c0o3awpETLFbaDoDQMKHbe0Dqww+guzLQEfOofhCwo9hdc2lhWe1gYfnIZA5P93kieZycrlaFIOP/BstqjxQCzUjRofAlmiN9JG3AZNbecH7rnN3LNO1WtIjV5DyTic9UKXFa2ZhgPyUgSU/0p9PwKt98ri1dY/sY9kVd4RYdsVUguSrJbWb9iMApazqzs3PLDc+8qidopcwmimYGeekHwYLhh2SE2/ZJLMfud6qagiK9rkRHmnUKtkpin7XG7F71Om2ADvbV4cE4utWYu8io7UvjYNRo2qt65O+ntcVZsqKVvTg4X9PRpiCMjvjnfOruNFZbhtvQ3azwdkJ112miGZpZ0CxKyOAs2JZ26k2nzzg1jcHHmb3oxxWP4GfrE+FLUHwKTJQOLCn2Ri5bQrFxpuyYfspE/9g12Nn1bTMXoqokICXbS1MKQRd2os24JWrra1rrqpdkHRPdlltIbk0qV/FOXlE2KBg6Yk4rCIiYdKfKGdpsoudLWb5X6UgXkL89KF1QmQbGHKLT1+3gNxyfFnzCnuV9/ofuQ5q4O56SVqSSc5+pMt+pXpAqeSSd2FlyLjPWHcUusNcXmGX+lVFou353sCNIZTI/VUouAgSPnc4s8IbIDlYl0Am77CwgEru9Yb4jLUC2xVtrCXyTt7Gr3go5RRmoy8+Hnjx+2g5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(376002)(39850400004)(346002)(4326008)(76116006)(2616005)(66556008)(91956017)(64756008)(8676002)(66446008)(83380400001)(66476007)(316002)(6512007)(31686004)(36756003)(66946007)(53546011)(186003)(26005)(2906002)(44832011)(7416002)(86362001)(31696002)(5660300002)(8936002)(71200400001)(478600001)(6506007)(122000001)(54906003)(6486002)(41300700001)(6916009)(38070700005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlloT1FuaHNrZjZqMnFDK0ZNakNkeWEwS2pmakh0TzlQMUJYU3BoZ1RIRk9h?=
 =?utf-8?B?VlpNTWo1dU1haXVnSklCZEpsQzJ4ZEl5Nkw5TkNyV3hLNW9rMXQ2aXhOZERq?=
 =?utf-8?B?K0RJc1ZmUkZ5UTcwYjZrS2xFSnBlSktabXNHNDR6R00zUk0yOWFxN2g4ZDFW?=
 =?utf-8?B?cmVlYkN6eVdIRVdSbkJud1RsZlZ4Z3RDbTJ1TmtvVndSVFkvdjNDc3RESFZS?=
 =?utf-8?B?bThlSVc1Y2gvMkVvdFFOeDlYRDQ2bmxOSFhrTEg3NXRlUkV0UVBRQmdIUGFW?=
 =?utf-8?B?VFVvRVBqVkI4QmY2dHYzclpIK0xXN0tvU2hzSXRpVHd6VTdKa0dNTXAwMFIy?=
 =?utf-8?B?VnZLeFprdG1xWmt4V3ZHWlpZVlpZN0g4TlFsRGxYZUh0aGRrdjZMYi9kaXMv?=
 =?utf-8?B?QmluUSt2bzFWZysrcDBkVWRJUEIxcU9aNUpFMUs5bEkzeUorYnVBa1JKZHpX?=
 =?utf-8?B?QVFNZ2JoSmhBbVZvR2NSbXA4c3dYOE1uZnhUdGZZck1HQVNmMHlPa2NQRytr?=
 =?utf-8?B?QXV6SVQzR0dXd25CSS8reWNtdy9sQnIrb1dkUHdycWVWRlJIL2NZdDY0Tkd6?=
 =?utf-8?B?Vm1wd28yUVpWbE5xejd3VW1mVTNiTW1EUEVnbWZmUi9PbDZxWjJuQlNvc0dW?=
 =?utf-8?B?ZG8rMFZ0aVNtdm9lN20vT2hsamVYU1hpcW1NQzQ1T2FkTm5oV212R1RVcmVl?=
 =?utf-8?B?bGFwUEU4RTJSTXN6OVhIWlAvWSs3bU04azlZU09hR2tjaTZSUythbW05Ryto?=
 =?utf-8?B?YjhQanhZTlpXbE5rbTY1cWI1eFRrSnZDMnlkUnIrY3A0YU9ncWxTL2VzWGI1?=
 =?utf-8?B?ZmdWNU42Vk5Lb3hiZ3RjT3UxMXdiUjN0ak1YSlAxTFphNTRXNE9jN2trZ3Fl?=
 =?utf-8?B?dWZhSW5jV2NtZ2xrd24rKzRHS0x2aTNpamkxOWxIb2NkVUkrcDVVTDg0Uk5X?=
 =?utf-8?B?aDRGWC9JODh1T2gySGtiZHRpbWlENUw4RnlXdm5RNWRLODRCcWNvV0hPK3ZY?=
 =?utf-8?B?UVdBa2MrclNaODJtSWVMZ3drNDJReml3VllnbHV5dVBleXVqc0c3NlpROFRQ?=
 =?utf-8?B?MStUTTh3OGlUY3czZ2FNN0lMelN3TFRacTFBQ240d3lCaWk2R1RJWjRCRUVw?=
 =?utf-8?B?b0dpd1g1TzNqUFlPU0NPbUFpZUUvQ2lRd3BZWVgvODBkQUdzMm51eElkUGFL?=
 =?utf-8?B?NGRzVUwzOFQ4Z1VwbTlGb3ZvNE1BeUwxZTF1c0VoS2tWd0c3dGQ1ZG1VT0Z1?=
 =?utf-8?B?UlNRLy9sNmhZYVJYcXVKdlg2cUpYenlWWEY1M3lSY0VQVXhTNW1UNVZYNWdL?=
 =?utf-8?B?NHY4RXZtY1BPT0RVUWJHcWZBUVBHUGRzZm5IQ0tiaVBvVHBSeGdtdW9xWk53?=
 =?utf-8?B?bTBqU3h2VC9oVkpHL2ZRNGQ3b0dhTHJhL2xRTWpXWVFROVJuM1FTR3RldmxM?=
 =?utf-8?B?S3AyS0dWMC9CYW4wQzZMZnMwZm81M0UzY1J3U1Q3RnNFUHdGUWIwS3R1SDM4?=
 =?utf-8?B?N0NFTjJGek5qSlk5WENEUVVDbE00SldHRERQaFVkdHVhZkJoc0lZUWFWNGJ4?=
 =?utf-8?B?b05vNmVFNGRSOGFxVUFsdXVFdEpKZWtuNExGVFNmcFhtbGZMSnY2WWJlVEtr?=
 =?utf-8?B?YktCa05sWWZ5d3NwajBDc2xHUFRxNmMzcWxRdm0vL3VKdjhvcnFzZUxDYktt?=
 =?utf-8?B?Z1MwUEl3YlQxemRnM2FtYURsdkdnVkpobW5HSU5wdzhma2h3d2NaMmI4NFY1?=
 =?utf-8?B?U1pCUXhJcllkekFmSVZGb2s5ZXJlNUlFbXVyN29uWFIzTWN0RGYxdk9XWFlG?=
 =?utf-8?B?NE5yTHJxTUNjaEE5NWpnN0tYTzAzT2o3N01yYUd3cEU1aGU1U3J4YmFEaEVE?=
 =?utf-8?B?WEdjU0dRZkxwazlVcVdhdllDK3Q4QkV6cnAyeG9TdEo2eEJIakY4T1hMNHVv?=
 =?utf-8?B?Y2lCaDlkZjNaSkxvQndiTnhOYXdIbU1LMXVDQzRMQm5ZUEt3UXN2TFVwZ0hY?=
 =?utf-8?B?cnI5OCtzRFhBanhTbFBiK3FCb0haTDhTUW1jVTdHUkJ3emNKMUc0ZEJjZWNw?=
 =?utf-8?B?OHFhTXBWUDNsWnhVK1FyTGFNK282TkVibVk3YTgzWjhzUVBWOVkrc3B4UUNV?=
 =?utf-8?B?b3pBbkx6TG5DZmEvZmExa29rKzhjNVlFRVFOV3ljTDVqU241cjhmTHIyQXoy?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0340F79A8CDB74FA77800FD877CF4A3@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: dfdff4c2-0dd6-4627-6271-08da80def8b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 06:00:36.9725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QPKY0kXOdPXSbpC+wINTfyUusz4pB+D0j2mGiJzwM0ZE8q5EqanzZ+4NlnTbKrAl183wFa4vjNp6v0Xonhj6tSUQryRbYBeHvfKxH5M1PWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2089
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDE3LzA4LzIwMjIgw6AgMTk6NDYsIEFybmQgQmVyZ21hbm4gYSDDqWNyaXTCoDoNCj4g
T24gVHVlLCBBdWcgOSwgMjAyMiBhdCAxMjo0MCBQTSBDaHJpc3RvcGhlIExlcm95DQo+IDxjaHJp
c3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+IHdyb3RlOg0KPj4NCj4+IEF0IHRoZSB0aW1lIGJlaW5n
LCB0aGUgZGVmYXVsdCBtYXhpbXVtIG51bWJlciBvZiBHUElPcyBpcyBzZXQgdG8gNTEyDQo+PiBh
bmQgY2FuIG9ubHkgZ2V0IGN1c3RvbWlzZWQgdmlhIGFuIGFyY2hpdGVjdHVyZSBzcGVjaWZpYw0K
Pj4gQ09ORklHX0FSQ0hfTlJfR1BJTy4NCj4+DQo+PiBUaGUgbWF4aW11bSBudW1iZXIgb2YgR1BJ
T3MgbWlnaHQgYmUgZGVwZW5kZW50IG9uIHRoZSBudW1iZXIgb2YNCj4+IGludGVyZmFjZSBib2Fy
ZHMgYW5kIGlzIHNvbWV3aGF0IGluZGVwZW5kZW50IG9mIGFyY2hpdGVjdHVyZS4NCj4+DQo+PiBB
bGxvdyB0aGUgdXNlciB0byBzZWxlY3QgdGhhdCBtYXhpbXVtIG51bWJlciBvdXRzaWRlIG9mIGFu
eQ0KPj4gYXJjaGl0ZWN0dXJlIGNvbmZpZ3VyYXRpb24uIFRvIGVuYWJsZSB0aGF0LCByZS1kZWZp
bmUgYQ0KPj4gY29yZSBDT05GSUdfQVJDSF9OUl9HUElPIGZvciBhcmNoaXRlY3R1cmVzIHdoaWNo
IGRvbid0IGFscmVhZHkNCj4+IGRlZmluZSBvbmUuIEd1YXJkIGl0IHdpdGggYSBuZXcgaGlkZGVu
IENPTkZJR19BUkNIX0hBU19OUl9HUElPLg0KPj4NCj4+IE9ubHkgdHdvIGFyY2hpdGVjdHVyZXMg
d2lsbCBuZWVkIENPTkZJR19BUkNIX0hBU19OUl9HUElPOiB4ODYgYW5kIGFybS4NCj4+DQo+PiBP
biBhcm0sIGRvIGxpa2UgeDg2IGFuZCBzZXQgNTEyIGFzIHRoZSBkZWZhdWx0IGluc3RlYWQgb2Yg
MCwgdGhhdA0KPj4gYWxsb3dzIHNpbXBsaWZ5aW5nIHRoZSBsb2dpYyBpbiBhc20tZ2VuZXJpYy9n
cGlvLmgNCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGhlIExlcm95IDxjaHJpc3RvcGhl
Lmxlcm95QGNzZ3JvdXAuZXU+DQo+PiAtLS0NCj4+ICAgRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBp
L2dwaW8vbGVnYWN5LnJzdCB8ICAyICstDQo+PiAgIGFyY2gvYXJtL0tjb25maWcgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgMyArKy0NCj4+ICAgYXJjaC9hcm0vaW5jbHVkZS9hc20vZ3Bpby5o
ICAgICAgICAgICAgICB8ICAxIC0NCj4+ICAgYXJjaC94ODYvS2NvbmZpZyAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAxICsNCj4+ICAgZHJpdmVycy9ncGlvL0tjb25maWcgICAgICAgICAgICAg
ICAgICAgICB8IDE0ICsrKysrKysrKysrKysrDQo+PiAgIGluY2x1ZGUvYXNtLWdlbmVyaWMvZ3Bp
by5oICAgICAgICAgICAgICAgfCAgNiAtLS0tLS0NCj4+ICAgNiBmaWxlcyBjaGFuZ2VkLCAxOCBp
bnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVu
dGF0aW9uL2RyaXZlci1hcGkvZ3Bpby9sZWdhY3kucnN0IGIvRG9jdW1lbnRhdGlvbi9kcml2ZXIt
YXBpL2dwaW8vbGVnYWN5LnJzdA0KPj4gaW5kZXggOWIxMmVlYjg5MTcwLi41NjZiMDZhNTg0Y2Yg
MTAwNjQ0DQo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvZ3Bpby9sZWdhY3kucnN0
DQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvZ3Bpby9sZWdhY3kucnN0DQo+PiBA
QCAtNTU4LDcgKzU1OCw3IEBAIFBsYXRmb3JtIFN1cHBvcnQNCj4+ICAgVG8gZm9yY2UtZW5hYmxl
IHRoaXMgZnJhbWV3b3JrLCBhIHBsYXRmb3JtJ3MgS2NvbmZpZyB3aWxsICJzZWxlY3QiIEdQSU9M
SUIsDQo+PiAgIGVsc2UgaXQgaXMgdXAgdG8gdGhlIHVzZXIgdG8gY29uZmlndXJlIHN1cHBvcnQg
Zm9yIEdQSU8uDQo+Pg0KPj4gLUl0IG1heSBhbHNvIHByb3ZpZGUgYSBjdXN0b20gdmFsdWUgZm9y
IEFSQ0hfTlJfR1BJT1MsIHNvIHRoYXQgaXQgYmV0dGVyDQo+PiArSXQgbWF5IGFsc28gcHJvdmlk
ZSBhIGN1c3RvbSB2YWx1ZSBmb3IgQ09ORklHX0FSQ0hfTlJfR1BJTywgc28gdGhhdCBpdCBiZXR0
ZXINCj4+ICAgcmVmbGVjdHMgdGhlIG51bWJlciBvZiBHUElPcyBpbiBhY3R1YWwgdXNlIG9uIHRo
YXQgcGxhdGZvcm0sIHdpdGhvdXQNCj4+ICAgd2FzdGluZyBzdGF0aWMgdGFibGUgc3BhY2UuICAo
SXQgc2hvdWxkIGNvdW50IGJvdGggYnVpbHQtaW4vU29DIEdQSU9zIGFuZA0KPj4gICBhbHNvIG9u
ZXMgb24gR1BJTyBleHBhbmRlcnMuDQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vS2NvbmZpZyBi
L2FyY2gvYXJtL0tjb25maWcNCj4+IGluZGV4IDUzZTZhMWRhOWFmNS4uZTU1YjY1NjBmZTRmIDEw
MDY0NA0KPj4gLS0tIGEvYXJjaC9hcm0vS2NvbmZpZw0KPj4gKysrIGIvYXJjaC9hcm0vS2NvbmZp
Zw0KPj4gQEAgLTE0LDYgKzE0LDcgQEAgY29uZmlnIEFSTQ0KPj4gICAgICAgICAgc2VsZWN0IEFS
Q0hfSEFTX0tDT1YNCj4+ICAgICAgICAgIHNlbGVjdCBBUkNIX0hBU19NRU1CQVJSSUVSX1NZTkNf
Q09SRQ0KPj4gICAgICAgICAgc2VsZWN0IEFSQ0hfSEFTX05PTl9PVkVSTEFQUElOR19BRERSRVNT
X1NQQUNFDQo+PiArICAgICAgIHNlbGVjdCBBUkNIX0hBU19OUl9HUElPDQo+PiAgICAgICAgICBz
ZWxlY3QgQVJDSF9IQVNfUFRFX1NQRUNJQUwgaWYgQVJNX0xQQUUNCj4+ICAgICAgICAgIHNlbGVj
dCBBUkNIX0hBU19QSFlTX1RPX0RNQQ0KPj4gICAgICAgICAgc2VsZWN0IEFSQ0hfSEFTX1NFVFVQ
X0RNQV9PUFMNCj4+IEBAIC0xMjQzLDcgKzEyNDQsNyBAQCBjb25maWcgQVJDSF9OUl9HUElPDQo+
PiAgICAgICAgICBkZWZhdWx0IDM1MiBpZiBBUkNIX1ZUODUwMA0KPj4gICAgICAgICAgZGVmYXVs
dCAyODggaWYgQVJDSF9ST0NLQ0hJUA0KPj4gICAgICAgICAgZGVmYXVsdCAyNjQgaWYgTUFDSF9I
NDcwMA0KPj4gLSAgICAgICBkZWZhdWx0IDANCj4+ICsgICAgICAgZGVmYXVsdCA1MTINCj4gDQo+
IFRoaXMgbGlzdCBzaG91bGQgYmUga2VwdCBzb3J0ZWQsIG90aGVyd2lzZSB5b3Ugc3RpbGwgZ2V0
IGUuZy4gdGhlICcyNjQnIGRlZmF1bHQNCj4gdmFsdWUuIElmIHlvdSBoYXZlIGEgR1BJTyBleHRl
bmRlciB0aGF0IHByb3ZpZGVzIGhhcmRjb2RlZCBHUElPDQo+IG51bWJlcnMgb24geW91ciBtYWNo
aW5lLCB0aGVyZSBzaG91bGQgYmUgYSBjb25maWd1cmF0aW9uIG9wdGlvbiBmb3INCj4gdGhhdCBk
cml2ZXIuDQoNCkkgZG9uJ3Qgd2FudCB0byBjaGFuZ2UgdGhlIGJlaGF2aW91ciBmb3IgZXhpc3Rp
bmcgY29uZmlndXJhdGlvbnMuIElmIHRoZSANCnVuY29uZGl0aW9uYWwgZGVmYXVsdCBnb2VzIGJl
Zm9yZSBjb25kaXRpb25hbCBvbmVzLCB0aGVuIGFsbCBmb2xsb3dpbmcgDQpkZWZhdWx0cyB3aWxs
IGJlIGlnbm9yZWQgYW5kIHlvdSdsbCBnZXQgNTEyIGluc3RlYWQgb2YgMjY0IGlmIE1BQ19INDcw
MCANCmlzIHNlbGVjdGVkIGZvciBpbnN0YW5jZS4NCg0KQXQgdGhlIHRpbWUgYmVpbmcsIHlvdSBn
ZXQgMCBvbmx5IHdoZW4gbm8gb3RoZXIgZGVmYXVsdCB3YXMgc2VsZWN0ZWQsIA0KdGhlbiB0aGF0
IDAgaW1wbGllcyA1MTIgaW4gYXNtLWdlbmVyaWMvZ3Bpby5oIGJ5Og0KDQojaWYgZGVmaW5lZChD
T05GSUdfQVJDSF9OUl9HUElPKSAmJiBDT05GSUdfQVJDSF9OUl9HUElPID4gMA0KI2RlZmluZSBB
UkNIX05SX0dQSU9TIENPTkZJR19BUkNIX05SX0dQSU8NCiNlbHNlDQojZGVmaW5lIEFSQ0hfTlJf
R1BJT1MJCTUxMg0KI2VuZGlmDQoNCj4gDQo+IFdoaWNoIGRyaXZlciBpcyBpdCB0aGF0IG5lZWRz
IGV4dHJhIGhhcmRjb2RlZCBHUElPIG51bWJlcnMgZm9yIHlvdT8NCj4gSGF2ZSB5b3UgdHJpZWQg
Y29udmVydGluZyBpdCB0byB1c2UgR1BJTyBkZXNjcmlwdG9ycyBzbyB5b3UgZG9uJ3QNCj4gbmVl
ZCB0aGUgbnVtYmVyIGFzc2lnbm1lbnQ/DQoNCkl0IGlzIGEgbWF4NzMwMSAoZHJpdmVycy9ncGlv
L2dwaW8tbWF4NzMweC5jKSBidXQgSSBjYW4ndCB1bmRlcnN0YW5kIA0Kd2hhdCB5b3UgbWVhbi4g
R1BJTyBkZXNjcmlwdG9ycyBhcmUgZm9yIGNvbnN1bWVycywgYXJlbid0IHRoZXkgPw0KDQpEdXJp
bmcgYm9vdCBJIGdldCA6DQoNClsgICAgMC42MDE5NDJdIGdwaW9jaGlwX2ZpbmRfYmFzZTogZm91
bmQgbmV3IGJhc2UgYXQgNDk2DQpbICAgIDAuNjA2MzM3XSBncGlvY2hpcF9maW5kX2Jhc2U6IGZv
dW5kIG5ldyBiYXNlIGF0IDQ2NA0KWyAgICAwLjYxNjQwOF0gZ3Bpb2NoaXBfZmluZF9iYXNlOiBm
b3VuZCBuZXcgYmFzZSBhdCA0NDgNClsgICAgMC42MjE4MjZdIGdwaW9jaGlwX2ZpbmRfYmFzZTog
Zm91bmQgbmV3IGJhc2UgYXQgNDMyDQpbICAgIDAuNjI3MjI4XSBncGlvY2hpcF9maW5kX2Jhc2U6
IGZvdW5kIG5ldyBiYXNlIGF0IDQwMA0KWyAgICAwLjY2MDk4NF0gZ3Bpb2NoaXBfZmluZF9iYXNl
OiBmb3VuZCBuZXcgYmFzZSBhdCAzODQNClsgICAgMC42Njk2MzFdIGdwaW9jaGlwX2ZpbmRfYmFz
ZTogZm91bmQgbmV3IGJhc2UgYXQgMzY4DQpbICAgIDAuNjcyNzEzXSBncGlvY2hpcF9maW5kX2Jh
c2U6IGZvdW5kIG5ldyBiYXNlIGF0IDM1Mg0KWyAgICAwLjY3NTgwNV0gZ3Bpb2NoaXBfZmluZF9i
YXNlOiBmb3VuZCBuZXcgYmFzZSBhdCAzMzYNClsgICAgMC42Nzg4ODVdIGdwaW9jaGlwX2ZpbmRf
YmFzZTogZm91bmQgbmV3IGJhc2UgYXQgMzIwDQpbICAgIDAuNjgyMTc4XSBncGlvY2hpcF9maW5k
X2Jhc2U6IGZvdW5kIG5ldyBiYXNlIGF0IDMwNA0KWyAgICAwLjY4NTI3NV0gZ3Bpb2NoaXBfZmlu
ZF9iYXNlOiBmb3VuZCBuZXcgYmFzZSBhdCAyODgNClsgICAgMC42ODgzNjZdIGdwaW9jaGlwX2Zp
bmRfYmFzZTogZm91bmQgbmV3IGJhc2UgYXQgMjcyDQpbICAgIDAuNjkxNjc4XSBncGlvY2hpcF9m
aW5kX2Jhc2U6IGZvdW5kIG5ldyBiYXNlIGF0IDI1Ng0KWyAgICAwLjY5NDc2Ml0gZ3Bpb2NoaXBf
ZmluZF9iYXNlOiBmb3VuZCBuZXcgYmFzZSBhdCAyNDANClsgICAgMC42OTc4NDddIGdwaW9jaGlw
X2ZpbmRfYmFzZTogZm91bmQgbmV3IGJhc2UgYXQgMjI0DQpbICAgIDAuNzAxNDQxXSBncGlvY2hp
cF9maW5kX2Jhc2U6IGZvdW5kIG5ldyBiYXNlIGF0IDIwOA0KWyAgICAwLjcwOTQyN10gZ3Bpb2No
aXBfZmluZF9iYXNlOiBmb3VuZCBuZXcgYmFzZSBhdCAxOTINClsgICAgMC43MTM4NTldIGdwaW9j
aGlwX2ZpbmRfYmFzZTogZm91bmQgbmV3IGJhc2UgYXQgMTc2DQpbICAgIDAuNzE4MDAyXSBncGlv
Y2hpcF9maW5kX2Jhc2U6IGZvdW5kIG5ldyBiYXNlIGF0IDE2MA0KWyAgICAwLjcyMzMxNl0gZ3Bp
b2NoaXBfZmluZF9iYXNlOiBmb3VuZCBuZXcgYmFzZSBhdCAxNDQNClsgICAgMC43MzExMDVdIGdw
aW9jaGlwX2ZpbmRfYmFzZTogZm91bmQgbmV3IGJhc2UgYXQgMTI4DQpbICAgIDAuNzM3NDAzXSBn
cGlvY2hpcF9maW5kX2Jhc2U6IGZvdW5kIG5ldyBiYXNlIGF0IDExMg0KWyAgICAwLjc0MDYxNF0g
Z3Bpb2NoaXBfZmluZF9iYXNlOiBmb3VuZCBuZXcgYmFzZSBhdCA5Ng0KWyAgICAwLjc0MzcwMV0g
Z3Bpb2NoaXBfZmluZF9iYXNlOiBmb3VuZCBuZXcgYmFzZSBhdCA4MA0KWyAgICAwLjc0NzI0Nl0g
Z3Bpb2NoaXBfZmluZF9iYXNlOiBmb3VuZCBuZXcgYmFzZSBhdCA2NA0KWyAgICA0LjY2MzY3N10g
Z3Bpb2NoaXBfZmluZF9iYXNlOiBmb3VuZCBuZXcgYmFzZSBhdCAzNg0KWyAgICA1LjA1MDc5Ml0g
Z3Bpb2NoaXBfZmluZF9iYXNlOiBmb3VuZCBuZXcgYmFzZSBhdCAxNg0KWyAgICA1LjA2NDg5Ml0g
Z3Bpb2NoaXBfZmluZF9iYXNlOiBjYW5ub3QgZmluZCBmcmVlIHJhbmdlDQpbICAgIDUuMDk1NTI3
XSBncGlvY2hpcF9maW5kX2Jhc2U6IGNhbm5vdCBmaW5kIGZyZWUgcmFuZ2UNCg0KZ3Bpb2NoaXBf
ZmluZF9iYXNlKCkgaXMgY2FsbGVkIGZvciBhbnkgR1BJTyBkcml2ZXIsIGJ5IGdwaW9jaGlwX2Fk
ZCgpIC8gDQpncGlvY2hpcF9hZGRfZGF0YV93aXRoX2tleSgpLCBhbmQgdGhlcmUgaXMgdGhlIGZv
bGxvd2luZyBjb21tZW50Og0KDQoJLyoNCgkgKiBUT0RPOiB0aGlzIGFsbG9jYXRlcyBhIExpbnV4
IEdQSU8gbnVtYmVyIGJhc2UgaW4gdGhlIGdsb2JhbA0KCSAqIEdQSU8gbnVtYmVyc3BhY2UgZm9y
IHRoaXMgY2hpcC4gSW4gdGhlIGxvbmcgcnVuIHdlIHdhbnQgdG8NCgkgKiBnZXQgKnJpZCogb2Yg
dGhpcyBudW1iZXJzcGFjZSBhbmQgdXNlIG9ubHkgZGVzY3JpcHRvcnMsIGJ1dA0KCSAqIGl0IG1h
eSBiZSBhIHBpcGUgZHJlYW0uIEl0IHdpbGwgbm90IGhhcHBlbiBiZWZvcmUgd2UgZ2V0IHJpZA0K
CSAqIG9mIHRoZSBzeXNmcyBpbnRlcmZhY2UgYW55d2F5cy4NCgkgKi8NCg0KU28sIHdoYXQgZGlk
IEkgbWlzcyA/DQoNClRoYW5rcw0KQ2hyaXN0b3BoZQ==
