Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700C37054E1
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 19:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjEPRV3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 13:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjEPRV3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 13:21:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4191683E4;
        Tue, 16 May 2023 10:21:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E6C2321ECA;
        Tue, 16 May 2023 17:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684257661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F4QLYEcz1xYVcgrdV750aUkRSdjMRItCdQ3OQri0yZg=;
        b=MNgnYKgEWd5OiUWO0o16WlIGkqab9zuhFQ9pWssBc0GKmppX7F0jhEGbZCY0axBkj6WvjJ
        us5L+aC/O9KNiMj+6Sgw2IphZzry0FjHiaDXd6wNl0cGF7qJBtttHxa63pcF3QWzspvFRz
        QOlusgEJ3bD+D3GrByEIWd7YziWFkN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684257661;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F4QLYEcz1xYVcgrdV750aUkRSdjMRItCdQ3OQri0yZg=;
        b=0VRi30thqkprhcexw7kSG3kceIqLO3Q+1PxngwUJ1L0JyxBdPTfaBYRBbdhJJyzEfVNIC7
        sYTg30Nr0/Sj5BDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7CD03138F9;
        Tue, 16 May 2023 17:21:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JsfvHH27Y2R/OgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 16 May 2023 17:21:01 +0000
Message-ID: <87ba918b-214b-a58a-ecc4-17b0bd00e8f8@suse.de>
Date:   Tue, 16 May 2023 19:21:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4 38/41] video: handle HAS_IOPORT dependencies
Content-Language: en-US
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-fbdev@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
 <20230516110038.2413224-39-schnelle@linux.ibm.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20230516110038.2413224-39-schnelle@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ySL0ieJRKTzqaUT2isTOi2rw"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ySL0ieJRKTzqaUT2isTOi2rw
Content-Type: multipart/mixed; boundary="------------MGmXOWCcVW1HE0tyqq4jbyie";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Niklas Schnelle <schnelle@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Helge Deller <deller@gmx.de>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
 linux-fbdev@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
 Paul Walmsley <paul.walmsley@sifive.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Bjorn Helgaas <bhelgaas@google.com>, Alan Stern <stern@rowland.harvard.edu>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>
Message-ID: <87ba918b-214b-a58a-ecc4-17b0bd00e8f8@suse.de>
Subject: Re: [PATCH v4 38/41] video: handle HAS_IOPORT dependencies
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
 <20230516110038.2413224-39-schnelle@linux.ibm.com>
In-Reply-To: <20230516110038.2413224-39-schnelle@linux.ibm.com>

--------------MGmXOWCcVW1HE0tyqq4jbyie
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMTYuMDUuMjMgdW0gMTM6MDAgc2NocmllYiBOaWtsYXMgU2NobmVsbGU6DQo+
IEluIGEgZnV0dXJlIHBhdGNoIEhBU19JT1BPUlQ9biB3aWxsIHJlc3VsdCBpbiBpbmIoKS9v
dXRiKCkgYW5kIGZyaWVuZHMNCj4gbm90IGJlaW5nIGRlY2xhcmVkLiBXZSB0aHVzIG5lZWQg
dG8gYWRkIEhBU19JT1BPUlQgYXMgZGVwZW5kZW5jeSBmb3INCj4gdGhvc2UgZHJpdmVycyB1
c2luZyB0aGVtIGFuZCBndWFyZCBpbmxpbmUgY29kZSBpbiBoZWFkZXJzLg0KPiANCj4gQ28t
ZGV2ZWxvcGVkLWJ5OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGtlcm5lbC5vcmc+DQo+IFNpZ25l
ZC1vZmYtYnk6IEFybmQgQmVyZ21hbm4gPGFybmRAa2VybmVsLm9yZz4NCj4gU2lnbmVkLW9m
Zi1ieTogTmlrbGFzIFNjaG5lbGxlIDxzY2huZWxsZUBsaW51eC5pYm0uY29tPg0KPiAtLS0N
Cj4gTm90ZTogVGhlIEhBU19JT1BPUlQgS2NvbmZpZyBvcHRpb24gd2FzIGFkZGVkIGluIHY2
LjQtcmMxIHNvDQo+ICAgICAgICBwZXItc3Vic3lzdGVtIHBhdGNoZXMgbWF5IGJlIGFwcGxp
ZWQgaW5kZXBlbmRlbnRseQ0KPiANCj4gICBkcml2ZXJzL3ZpZGVvL2NvbnNvbGUvS2NvbmZp
ZyB8ICAxICsNCj4gICBkcml2ZXJzL3ZpZGVvL2ZiZGV2L0tjb25maWcgICB8IDIxICsrKysr
KysrKysrLS0tLS0tLS0tLQ0KPiAgIGluY2x1ZGUvdmlkZW8vdmdhLmggICAgICAgICAgIHwg
IDggKysrKysrKysNCg0KVGhvc2UgYXJlIDMgZGlmZmVyZW50IHRoaW5ncy4gSXQgbWlnaHQg
YmUgcHJlZmVyYWJsZSB0byBub3QgaGFuZGxlIHRoZW0gDQp1bmRlciB0aGUgdmlkZW8vIHVt
YnJlbGxhLg0KDQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAxMCBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpZGVvL2NvbnNvbGUv
S2NvbmZpZyBiL2RyaXZlcnMvdmlkZW8vY29uc29sZS9LY29uZmlnDQo+IGluZGV4IDIyY2Vh
NTA4MmFjNC4uNjQ5NzRlYWEzYWM1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3ZpZGVvL2Nv
bnNvbGUvS2NvbmZpZw0KPiArKysgYi9kcml2ZXJzL3ZpZGVvL2NvbnNvbGUvS2NvbmZpZw0K
PiBAQCAtMTAsNiArMTAsNyBAQCBjb25maWcgVkdBX0NPTlNPTEUNCj4gICAJZGVwZW5kcyBv
biAhNHh4ICYmICFQUENfOHh4ICYmICFTUEFSQyAmJiAhTTY4SyAmJiAhUEFSSVNDICYmICAh
U1VQRVJIICYmIFwNCj4gICAJCSghQVJNIHx8IEFSQ0hfRk9PVEJSSURHRSB8fCBBUkNIX0lO
VEVHUkFUT1IgfHwgQVJDSF9ORVRXSU5ERVIpICYmIFwNCj4gICAJCSFBUk02NCAmJiAhQVJD
ICYmICFNSUNST0JMQVpFICYmICFPUEVOUklTQyAmJiAhUzM5MCAmJiAhVU1MDQo+ICsJZGVw
ZW5kcyBvbiBIQVNfSU9QT1JUDQo+ICAgCXNlbGVjdCBBUEVSVFVSRV9IRUxQRVJTIGlmIChE
Uk0gfHwgRkIgfHwgVkZJT19QQ0lfQ09SRSkNCj4gICAJZGVmYXVsdCB5DQo+ICAgCWhlbHAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8vZmJkZXYvS2NvbmZpZyBiL2RyaXZlcnMv
dmlkZW8vZmJkZXYvS2NvbmZpZw0KPiBpbmRleCA5NmU5MTU3MGNkZDMuLmE1NmM1N2RkODM5
YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy92aWRlby9mYmRldi9LY29uZmlnDQo+ICsrKyBi
L2RyaXZlcnMvdmlkZW8vZmJkZXYvS2NvbmZpZw0KPiBAQCAtMzM1LDcgKzMzNSw3IEBAIGNv
bmZpZyBGQl9JTVgNCj4gICANCj4gICBjb25maWcgRkJfQ1lCRVIyMDAwDQo+ICAgCXRyaXN0
YXRlICJDeWJlclBybyAyMDAwLzIwMTAvNTAwMCBzdXBwb3J0Ig0KPiAtCWRlcGVuZHMgb24g
RkIgJiYgUENJICYmIChCUk9LRU4gfHwgIVNQQVJDNjQpDQo+ICsJZGVwZW5kcyBvbiBGQiAm
JiBQQ0kgJiYgSEFTX0lPUE9SVCAmJiAoQlJPS0VOIHx8ICFTUEFSQzY0KQ0KPiAgIAlzZWxl
Y3QgRkJfQ0ZCX0ZJTExSRUNUDQo+ICAgCXNlbGVjdCBGQl9DRkJfQ09QWUFSRUENCj4gICAJ
c2VsZWN0IEZCX0NGQl9JTUFHRUJMSVQNCj4gQEAgLTQyOSw2ICs0MjksNyBAQCBjb25maWcg
RkJfRk0yDQo+ICAgY29uZmlnIEZCX0FSQw0KPiAgIAl0cmlzdGF0ZSAiQXJjIE1vbm9jaHJv
bWUgTENEIGJvYXJkIHN1cHBvcnQiDQo+ICAgCWRlcGVuZHMgb24gRkIgJiYgKFg4NiB8fCBD
T01QSUxFX1RFU1QpDQo+ICsJZGVwZW5kcyBvbiBIQVNfSU9QT1JUDQo+ICAgCXNlbGVjdCBG
Ql9TWVNfRklMTFJFQ1QNCj4gICAJc2VsZWN0IEZCX1NZU19DT1BZQVJFQQ0KPiAgIAlzZWxl
Y3QgRkJfU1lTX0lNQUdFQkxJVA0KPiBAQCAtMTMzMiw3ICsxMzMzLDcgQEAgY29uZmlnIEZC
X0FUWV9CQUNLTElHSFQNCj4gICANCj4gICBjb25maWcgRkJfUzMNCj4gICAJdHJpc3RhdGUg
IlMzIFRyaW8vVmlyZ2Ugc3VwcG9ydCINCj4gLQlkZXBlbmRzIG9uIEZCICYmIFBDSQ0KPiAr
CWRlcGVuZHMgb24gRkIgJiYgUENJICYmIEhBU19JT1BPUlQNCj4gICAJc2VsZWN0IEZCX0NG
Ql9GSUxMUkVDVA0KPiAgIAlzZWxlY3QgRkJfQ0ZCX0NPUFlBUkVBDQo+ICAgCXNlbGVjdCBG
Ql9DRkJfSU1BR0VCTElUDQo+IEBAIC0xMzkzLDcgKzEzOTQsNyBAQCBjb25maWcgRkJfU0FW
QUdFX0FDQ0VMDQo+ICAgDQo+ICAgY29uZmlnIEZCX1NJUw0KPiAgIAl0cmlzdGF0ZSAiU2lT
L1hHSSBkaXNwbGF5IHN1cHBvcnQiDQo+IC0JZGVwZW5kcyBvbiBGQiAmJiBQQ0kNCj4gKwlk
ZXBlbmRzIG9uIEZCICYmIFBDSSAmJiBIQVNfSU9QT1JUDQo+ICAgCXNlbGVjdCBGQl9DRkJf
RklMTFJFQ1QNCj4gICAJc2VsZWN0IEZCX0NGQl9DT1BZQVJFQQ0KPiAgIAlzZWxlY3QgRkJf
Q0ZCX0lNQUdFQkxJVA0KPiBAQCAtMTQyNCw3ICsxNDI1LDcgQEAgY29uZmlnIEZCX1NJU18z
MTUNCj4gICANCj4gICBjb25maWcgRkJfVklBDQo+ICAgCXRyaXN0YXRlICJWSUEgVW5pQ2hy
b21lIChQcm8pIGFuZCBDaHJvbWU5IGRpc3BsYXkgc3VwcG9ydCINCj4gLQlkZXBlbmRzIG9u
IEZCICYmIFBDSSAmJiBHUElPTElCICYmIEkyQyAmJiAoWDg2IHx8IENPTVBJTEVfVEVTVCkN
Cj4gKwlkZXBlbmRzIG9uIEZCICYmIFBDSSAmJiBHUElPTElCICYmIEkyQyAmJiBIQVNfSU9Q
T1JUICYmIChYODYgfHwgQ09NUElMRV9URVNUKQ0KPiAgIAlzZWxlY3QgRkJfQ0ZCX0ZJTExS
RUNUDQo+ICAgCXNlbGVjdCBGQl9DRkJfQ09QWUFSRUENCj4gICAJc2VsZWN0IEZCX0NGQl9J
TUFHRUJMSVQNCj4gQEAgLTE0NjMsNyArMTQ2NCw3IEBAIGVuZGlmDQo+ICAgDQo+ICAgY29u
ZmlnIEZCX05FT01BR0lDDQo+ICAgCXRyaXN0YXRlICJOZW9NYWdpYyBkaXNwbGF5IHN1cHBv
cnQiDQo+IC0JZGVwZW5kcyBvbiBGQiAmJiBQQ0kNCj4gKwlkZXBlbmRzIG9uIEZCICYmIFBD
SSAmJiBIQVNfSU9QT1JUDQo+ICAgCXNlbGVjdCBGQl9NT0RFX0hFTFBFUlMNCj4gICAJc2Vs
ZWN0IEZCX0NGQl9GSUxMUkVDVA0KPiAgIAlzZWxlY3QgRkJfQ0ZCX0NPUFlBUkVBDQo+IEBA
IC0xNDkzLDcgKzE0OTQsNyBAQCBjb25maWcgRkJfS1lSTw0KPiAgIA0KPiAgIGNvbmZpZyBG
Ql8zREZYDQo+ICAgCXRyaXN0YXRlICIzRGZ4IEJhbnNoZWUvVm9vZG9vMy9Wb29kb281IGRp
c3BsYXkgc3VwcG9ydCINCj4gLQlkZXBlbmRzIG9uIEZCICYmIFBDSQ0KPiArCWRlcGVuZHMg
b24gRkIgJiYgUENJICYmIEhBU19JT1BPUlQNCj4gICAJc2VsZWN0IEZCX0NGQl9JTUFHRUJM
SVQNCj4gICAJc2VsZWN0IEZCX0NGQl9GSUxMUkVDVA0KPiAgIAlzZWxlY3QgRkJfQ0ZCX0NP
UFlBUkVBDQo+IEBAIC0xNTQzLDcgKzE1NDQsNyBAQCBjb25maWcgRkJfVk9PRE9PMQ0KPiAg
IA0KPiAgIGNvbmZpZyBGQl9WVDg2MjMNCj4gICAJdHJpc3RhdGUgIlZJQSBWVDg2MjMgc3Vw
cG9ydCINCj4gLQlkZXBlbmRzIG9uIEZCICYmIFBDSQ0KPiArCWRlcGVuZHMgb24gRkIgJiYg
UENJICYmIEhBU19JT1BPUlQNCj4gICAJc2VsZWN0IEZCX0NGQl9GSUxMUkVDVA0KPiAgIAlz
ZWxlY3QgRkJfQ0ZCX0NPUFlBUkVBDQo+ICAgCXNlbGVjdCBGQl9DRkJfSU1BR0VCTElUDQo+
IEBAIC0xNTU4LDcgKzE1NTksNyBAQCBjb25maWcgRkJfVlQ4NjIzDQo+ICAgDQo+ICAgY29u
ZmlnIEZCX1RSSURFTlQNCj4gICAJdHJpc3RhdGUgIlRyaWRlbnQvQ3liZXJYWFgvQ3liZXJC
bGFkZSBzdXBwb3J0Ig0KPiAtCWRlcGVuZHMgb24gRkIgJiYgUENJDQo+ICsJZGVwZW5kcyBv
biBGQiAmJiBQQ0kgJiYgSEFTX0lPUE9SVA0KPiAgIAlzZWxlY3QgRkJfQ0ZCX0ZJTExSRUNU
DQo+ICAgCXNlbGVjdCBGQl9DRkJfQ09QWUFSRUENCj4gICAJc2VsZWN0IEZCX0NGQl9JTUFH
RUJMSVQNCj4gQEAgLTE1ODEsNyArMTU4Miw3IEBAIGNvbmZpZyBGQl9UUklERU5UDQo+ICAg
DQo+ICAgY29uZmlnIEZCX0FSSw0KPiAgIAl0cmlzdGF0ZSAiQVJLIDIwMDBQViBzdXBwb3J0
Ig0KPiAtCWRlcGVuZHMgb24gRkIgJiYgUENJDQo+ICsJZGVwZW5kcyBvbiBGQiAmJiBQQ0kg
JiYgSEFTX0lPUE9SVA0KPiAgIAlzZWxlY3QgRkJfQ0ZCX0ZJTExSRUNUDQo+ICAgCXNlbGVj
dCBGQl9DRkJfQ09QWUFSRUENCj4gICAJc2VsZWN0IEZCX0NGQl9JTUFHRUJMSVQNCj4gQEAg
LTIxOTUsNyArMjE5Niw3IEBAIGNvbmZpZyBGQl9TU0QxMzA3DQo+ICAgDQo+ICAgY29uZmln
IEZCX1NNNzEyDQo+ICAgCXRyaXN0YXRlICJTaWxpY29uIE1vdGlvbiBTTTcxMiBmcmFtZWJ1
ZmZlciBzdXBwb3J0Ig0KPiAtCWRlcGVuZHMgb24gRkIgJiYgUENJDQo+ICsJZGVwZW5kcyBv
biBGQiAmJiBQQ0kgJiYgSEFTX0lPUE9SVA0KPiAgIAlzZWxlY3QgRkJfQ0ZCX0ZJTExSRUNU
DQo+ICAgCXNlbGVjdCBGQl9DRkJfQ09QWUFSRUENCj4gICAJc2VsZWN0IEZCX0NGQl9JTUFH
RUJMSVQNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdmlkZW8vdmdhLmggYi9pbmNsdWRlL3Zp
ZGVvL3ZnYS5oDQo+IGluZGV4IDk0N2MwYWJkMDRlZi4uZjRiODA2Yjg1Yzg2IDEwMDY0NA0K
PiAtLS0gYS9pbmNsdWRlL3ZpZGVvL3ZnYS5oDQo+ICsrKyBiL2luY2x1ZGUvdmlkZW8vdmdh
LmgNCj4gQEAgLTIwMywxOCArMjAzLDI2IEBAIGV4dGVybiBpbnQgcmVzdG9yZV92Z2Eoc3Ry
dWN0IHZnYXN0YXRlICpzdGF0ZSk7DQo+ICAgDQo+ICAgc3RhdGljIGlubGluZSB1bnNpZ25l
ZCBjaGFyIHZnYV9pb19yICh1bnNpZ25lZCBzaG9ydCBwb3J0KQ0KPiAgIHsNCj4gKyNpZmRl
ZiBDT05GSUdfSEFTX0lPUE9SVA0KPiAgIAlyZXR1cm4gaW5iX3AocG9ydCk7DQo+ICsjZWxz
ZQ0KPiArCXJldHVybiAweGZmOw0KPiArI2VuZGlmDQo+ICAgfQ0KPiAgIA0KPiAgIHN0YXRp
YyBpbmxpbmUgdm9pZCB2Z2FfaW9fdyAodW5zaWduZWQgc2hvcnQgcG9ydCwgdW5zaWduZWQg
Y2hhciB2YWwpDQo+ICAgew0KPiArI2lmZGVmIENPTkZJR19IQVNfSU9QT1JUDQo+ICAgCW91
dGJfcCh2YWwsIHBvcnQpOw0KPiArI2VuZGlmDQo+ICAgfQ0KPiAgIA0KPiAgIHN0YXRpYyBp
bmxpbmUgdm9pZCB2Z2FfaW9fd19mYXN0ICh1bnNpZ25lZCBzaG9ydCBwb3J0LCB1bnNpZ25l
ZCBjaGFyIHJlZywNCj4gICAJCQkJICB1bnNpZ25lZCBjaGFyIHZhbCkNCj4gICB7DQo+ICsj
aWZkZWYgQ09ORklHX0hBU19JT1BPUlQNCj4gICAJb3V0dyhWR0FfT1VUMTZWQUwgKHZhbCwg
cmVnKSwgcG9ydCk7DQo+ICsjZW5kaWYNCj4gICB9DQoNCkl0IGZlZWxzIHdyb25nIHRoYXQg
dGhlc2UgaGVscGVycyBzaWxlbnRseSBkbyBub3RoaW5nLiBJJ2QgZW5jbG9zZSB0aGVtIA0K
aW4gQ09ORklHX0hBU19JT1BPUlQgZW50aXJlbHkuIFRoZSBkcml2ZXJzIHRoYXQgdXNlIHRo
ZW0gdW5jb25kaXRpb25hbGx5IA0Kd291bGQgdGhlbiBmYWlsIHRvIGJ1aWxkLg0KDQpCZXN0
IHJlZ2FyZHMNClRob21hcw0KDQo+ICAgDQo+ICAgc3RhdGljIGlubGluZSB1bnNpZ25lZCBj
aGFyIHZnYV9tbV9yICh2b2lkIF9faW9tZW0gKnJlZ2Jhc2UsIHVuc2lnbmVkIHNob3J0IHBv
cnQpDQoNCi0tIA0KVGhvbWFzIFppbW1lcm1hbm4NCkdyYXBoaWNzIERyaXZlciBEZXZlbG9w
ZXINClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSA0KRnJhbmtlbnN0cmFz
c2UgMTQ2LCA5MDQ2MSBOdWVybmJlcmcsIEdlcm1hbnkNCkdGOiBJdm8gVG90ZXYsIEFuZHJl
dyBNeWVycywgQW5kcmV3IE1jRG9uYWxkLCBCb3VkaWVuIE1vZXJtYW4NCkhSQiAzNjgwOSAo
QUcgTnVlcm5iZXJnKQ0K

--------------MGmXOWCcVW1HE0tyqq4jbyie--

--------------ySL0ieJRKTzqaUT2isTOi2rw
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmRju30FAwAAAAAACgkQlh/E3EQov+CF
PBAAvjMIb1oGDJVpeY0CGY5lPnPATKDg5s5tmrfuCFa4BV4Nz9xbO7icWIjvwOGIglUeX+JoJIOj
/jw1/4a1wHT6AA2b8NGf3MgF6NLdD+4XUh8CEDhLIeD81U4crqeEkV/cj4KxnY47kzwisFRDMm4C
4xb1shU/lWKzfpk5EGuuPleqQxWsp09BIf52hiJpe/TKF2r/FdXb1Z/f3N7rAEOB8MYgWmQKVaqq
3jKPLuSk4wMCp8gxSycfNKfWWoR1RhTV8L1QUp5E+1tCeN9OdAwnAuSGmQ0Yz5WD8LQYfzcESoH5
4PIRErIVFtTfA5uYCl565d/569kSqidWqy9qid1lUuxzp3ojfjVqy2g3raO0iPXoEQ1UMJ3Z/X9C
cXUlbWyXVJ4VPyduB8S1NMRz3hbWhVSZjJt0C7PJuAvI86XbXNeksrGMuqzy6wfEnmS1AHUWy4CQ
ZGXU3Zj3klVC1+XRkhYMk724XGDrPlFGeUHGqTj0zd2j82ynYdSnKdL2GnMk7eXt9WjRkMOiCP2+
YRIpIaeqUeb0VjQa/ZjTObD9eUSUC6BvtgmI0JGyIYXr/IRFIfMHNP7hNZFXaeySswPyTu6ebhnF
zWvptwDGKBHZP5+O/NOddSMx3nMWaMwEWjp1SumCezc2HabMHpbXkqkML+EJ5pf8O5QiIXW9MTyz
d1Q=
=KM9V
-----END PGP SIGNATURE-----

--------------ySL0ieJRKTzqaUT2isTOi2rw--
