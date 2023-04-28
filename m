Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B716F189A
	for <lists+linux-arch@lfdr.de>; Fri, 28 Apr 2023 14:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345847AbjD1M7g (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Apr 2023 08:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjD1M7f (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Apr 2023 08:59:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCC619BE;
        Fri, 28 Apr 2023 05:59:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 04AD821A72;
        Fri, 28 Apr 2023 12:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682686773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DOHva8/g0e3KXvU8cu2iVqtSznfT7AgOGR+s4nqZR1I=;
        b=LexiP+Jd9kxc3WCeMxN/5rz7hNn9gEEenHUWJCkq+CSvWM3zUVCRO0y0QkpBLoeY6UNnTN
        0a/Yqh2oTZRSXjEwZsidaaqcPkdeJ9Wx2jMHJSW6gpDyJWTQ1VYLJxpNnxQ7cFULSkj8Ry
        qqYuuZqg2ncEw3jHWmZrThebiBxI0FM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682686773;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DOHva8/g0e3KXvU8cu2iVqtSznfT7AgOGR+s4nqZR1I=;
        b=fuPUSiqbmzHaACmAk2lBEDPauY7ziXYZoVbj8FO0dBXjWu9QbQGTjIuP0BztVeW4B3zd/7
        ZzUKvia2Hfsgr0Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A6FF1390E;
        Fri, 28 Apr 2023 12:59:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ssPvIDTDS2TlDAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 28 Apr 2023 12:59:32 +0000
Message-ID: <7f5daedd-0006-b412-ace9-f3f4a9b48931@suse.de>
Date:   Fri, 28 Apr 2023 14:59:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 5/5] fbdev: Define framebuffer I/O from Linux' I/O
 functions
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-fbdev@vger.kernel.org, linux-ia64@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        James.Bottomley@hansenpartnership.com, sparclinux@vger.kernel.org,
        kernel@xen0n.name, sam@ravnborg.org, linux-arch@vger.kernel.org,
        deller@gmx.de, chenhuacai@kernel.org, javierm@redhat.com,
        vgupta@kernel.org, linux-snps-arc@lists.infradead.org,
        arnd@arndb.de, linux-m68k@lists.linux-m68k.org,
        loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net
References: <20230428092711.406-1-tzimmermann@suse.de>
 <20230428092711.406-6-tzimmermann@suse.de>
 <430c73f0-45f4-f81e-6506-bc8cc955d936@arm.com>
 <CAMuHMdUGjtiAR37L4_e0_p8ee2=gxoUj7+e7rqMLTBK+vpV4yw@mail.gmail.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <CAMuHMdUGjtiAR37L4_e0_p8ee2=gxoUj7+e7rqMLTBK+vpV4yw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------9vTZXEQMf5PD7pb3rF0sqz18"
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------9vTZXEQMf5PD7pb3rF0sqz18
Content-Type: multipart/mixed; boundary="------------gFxfHJxEW03j1ssJGn8N0Y6F";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Robin Murphy <robin.murphy@arm.com>
Cc: linux-fbdev@vger.kernel.org, linux-ia64@vger.kernel.org,
 dri-devel@lists.freedesktop.org, James.Bottomley@hansenpartnership.com,
 sparclinux@vger.kernel.org, kernel@xen0n.name, sam@ravnborg.org,
 linux-arch@vger.kernel.org, deller@gmx.de, chenhuacai@kernel.org,
 javierm@redhat.com, vgupta@kernel.org, linux-snps-arc@lists.infradead.org,
 arnd@arndb.de, linux-m68k@lists.linux-m68k.org, loongarch@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net
Message-ID: <7f5daedd-0006-b412-ace9-f3f4a9b48931@suse.de>
Subject: Re: [PATCH v2 5/5] fbdev: Define framebuffer I/O from Linux' I/O
 functions
References: <20230428092711.406-1-tzimmermann@suse.de>
 <20230428092711.406-6-tzimmermann@suse.de>
 <430c73f0-45f4-f81e-6506-bc8cc955d936@arm.com>
 <CAMuHMdUGjtiAR37L4_e0_p8ee2=gxoUj7+e7rqMLTBK+vpV4yw@mail.gmail.com>
In-Reply-To: <CAMuHMdUGjtiAR37L4_e0_p8ee2=gxoUj7+e7rqMLTBK+vpV4yw@mail.gmail.com>

--------------gFxfHJxEW03j1ssJGn8N0Y6F
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgUm9iaW4sIEdlZXJ0DQoNCkFtIDI4LjA0LjIzIHVtIDE0OjI3IHNjaHJpZWIgR2VlcnQg
VXl0dGVyaG9ldmVuOg0KPiBPbiBGcmksIEFwciAyOCwgMjAyMyBhdCAyOjE44oCvUE0gUm9i
aW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4gd3JvdGU6DQo+PiBPbiAyMDIzLTA0
LTI4IDEwOjI3LCBUaG9tYXMgWmltbWVybWFubiB3cm90ZToNCj4+PiBJbXBsZW1lbnQgZnJh
bWVidWZmZXIgSS9PIGhlbHBlcnMsIHN1Y2ggYXMgZmJfcmVhZCooKSBhbmQgZmJfd3JpdGUq
KCkNCj4+PiB3aXRoIExpbnV4JyByZWd1bGFyIEkvTyBmdW5jdGlvbnMuIFJlbW92ZSBhbGwg
aWZkZWYgY2FzZXMgZm9yIHRoZQ0KPj4+IHZhcmlvdXMgYXJjaGl0ZWN0dXJlcy4NCj4+Pg0K
Pj4+IE1vc3Qgb2YgdGhlIHN1cHBvcnRlZCBhcmNoaXRlY3R1cmVzIHVzZSBfX3Jhd18oKSBJ
L08gZnVuY3Rpb25zIG9yIHRyZWF0DQo+Pj4gZnJhbWVidWZmZXIgbWVtb3J5IGxpa2UgcmVn
dWxhciBtZW1vcnkuIFRoaXMgaXMgYWxzbyBpbXBsZW1lbnRlZCBieSB0aGUNCj4+PiBhcmNo
aXRlY3R1cmVzJyBJL08gZnVuY3Rpb24sIHNvIHdlIGNhbiB1c2UgdGhlbSBpbnN0ZWFkLg0K
Pj4+DQo+Pj4gU3BhcmMgdXNlcyBTQnVzIHRvIGNvbm5lY3QgdG8gZnJhbWVidWZmZXIgZGV2
aWNlcy4gSXQgcHJvdmlkZXMgcmVzcGVjdGl2ZQ0KPj4+IGltcGxlbWVudGF0aW9ucyBvZiB0
aGUgZnJhbWVidWZmZXIgSS9PIGhlbHBlcnMuIFRoZSBpbnZvbHZlZCBzYnVzXygpDQo+Pj4g
SS9PIGhlbHBlcnMgbWFwIHRvIHRoZSBzYW1lIGNvZGUgYXMgU3BhcmMncyByZWd1bGFyIEkv
TyBmdW5jdGlvbnMuIEFzDQo+Pj4gd2l0aCBvdGhlciBwbGF0Zm9ybXMsIHdlIGNhbiB1c2Ug
dGhvc2UgaW5zdGVhZC4NCj4+Pg0KPj4+IFdlIGxlYXZlIGEgVE9ETyBpdGVtIHRvIHJlcGxh
Y2UgYWxsIGZiXygpIGZ1bmN0aW9ucyB3aXRoIHRoZWlyIHJlZ3VsYXINCj4+PiBJL08gY291
bnRlcnBhcnRzIHRocm91Z2hvdXQgdGhlIGZiZGV2IGRyaXZlcnMuDQo+Pj4NCj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5Ac3VzZS5kZT4NCj4+
PiAtLS0NCj4+PiAgICBpbmNsdWRlL2xpbnV4L2ZiLmggfCA2MyArKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+Pj4gICAgMSBmaWxlIGNoYW5nZWQs
IDE1IGluc2VydGlvbnMoKyksIDQ4IGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvZmIuaCBiL2luY2x1ZGUvbGludXgvZmIuaA0KPj4+IGluZGV4
IDA4Y2I0N2RhNzFmOC4uNGFhOWU5MGVkZDE3IDEwMDY0NA0KPj4+IC0tLSBhL2luY2x1ZGUv
bGludXgvZmIuaA0KPj4+ICsrKyBiL2luY2x1ZGUvbGludXgvZmIuaA0KPj4+IEBAIC0xNSw3
ICsxNSw2IEBADQo+Pj4gICAgI2luY2x1ZGUgPGxpbnV4L2xpc3QuaD4NCj4+PiAgICAjaW5j
bHVkZSA8bGludXgvYmFja2xpZ2h0Lmg+DQo+Pj4gICAgI2luY2x1ZGUgPGxpbnV4L3NsYWIu
aD4NCj4+PiAtI2luY2x1ZGUgPGFzbS9pby5oPg0KPj4+DQo+Pj4gICAgc3RydWN0IHZtX2Fy
ZWFfc3RydWN0Ow0KPj4+ICAgIHN0cnVjdCBmYl9pbmZvOw0KPj4+IEBAIC01MTEsNTggKzUx
MCwyNiBAQCBzdHJ1Y3QgZmJfaW5mbyB7DQo+Pj4gICAgICovDQo+Pj4gICAgI2RlZmluZSBT
VFVQSURfQUNDRUxGX1RFWFRfU0hJVA0KPj4+DQo+Pj4gLS8vIFRoaXMgd2lsbCBnbyBhd2F5
DQo+Pj4gLSNpZiBkZWZpbmVkKF9fc3BhcmNfXykNCj4+PiAtDQo+Pj4gLS8qIFdlIG1hcCBh
bGwgb2Ygb3VyIGZyYW1lYnVmZmVycyBzdWNoIHRoYXQgYmlnLWVuZGlhbiBhY2Nlc3Nlcw0K
Pj4+IC0gKiBhcmUgd2hhdCB3ZSB3YW50LCBzbyB0aGUgZm9sbG93aW5nIGlzIHN1ZmZpY2ll
bnQuDQo+Pj4gKy8qDQo+Pj4gKyAqIFRPRE86IFVwZGF0ZSBmYmRldiBkcml2ZXJzIHRvIGNh
bGwgdGhlIEkvTyBoZWxwZXJzIGRpcmVjdGx5IGFuZA0KPj4+ICsgKiAgICAgICByZW1vdmUg
dGhlIGZiXygpIHRva2Vucy4NCj4+PiAgICAgKi8NCj4+PiAtDQo+Pj4gLS8vIFRoaXMgd2ls
bCBnbyBhd2F5DQo+Pj4gLSNkZWZpbmUgZmJfcmVhZGIgc2J1c19yZWFkYg0KPj4+IC0jZGVm
aW5lIGZiX3JlYWR3IHNidXNfcmVhZHcNCj4+PiAtI2RlZmluZSBmYl9yZWFkbCBzYnVzX3Jl
YWRsDQo+Pj4gLSNkZWZpbmUgZmJfcmVhZHEgc2J1c19yZWFkcQ0KPj4+IC0jZGVmaW5lIGZi
X3dyaXRlYiBzYnVzX3dyaXRlYg0KPj4+IC0jZGVmaW5lIGZiX3dyaXRldyBzYnVzX3dyaXRl
dw0KPj4+IC0jZGVmaW5lIGZiX3dyaXRlbCBzYnVzX3dyaXRlbA0KPj4+IC0jZGVmaW5lIGZi
X3dyaXRlcSBzYnVzX3dyaXRlcQ0KPj4+IC0jZGVmaW5lIGZiX21lbXNldCBzYnVzX21lbXNl
dF9pbw0KPj4+IC0jZGVmaW5lIGZiX21lbWNweV9mcm9tZmIgc2J1c19tZW1jcHlfZnJvbWlv
DQo+Pj4gLSNkZWZpbmUgZmJfbWVtY3B5X3RvZmIgc2J1c19tZW1jcHlfdG9pbw0KPj4+IC0N
Cj4+PiAtI2VsaWYgZGVmaW5lZChfX2kzODZfXykgfHwgZGVmaW5lZChfX2FscGhhX18pIHx8
IGRlZmluZWQoX194ODZfNjRfXykgfHwgICAgICBcDQo+Pj4gLSAgICAgZGVmaW5lZChfX2hw
cGFfXykgfHwgZGVmaW5lZChfX3NoX18pIHx8IGRlZmluZWQoX19wb3dlcnBjX18pIHx8IFwN
Cj4+PiAtICAgICBkZWZpbmVkKF9fYXJtX18pIHx8IGRlZmluZWQoX19hYXJjaDY0X18pIHx8
IGRlZmluZWQoX19taXBzX18pDQo+Pj4gLQ0KPj4+IC0jZGVmaW5lIGZiX3JlYWRiIF9fcmF3
X3JlYWRiDQo+Pj4gLSNkZWZpbmUgZmJfcmVhZHcgX19yYXdfcmVhZHcNCj4+PiAtI2RlZmlu
ZSBmYl9yZWFkbCBfX3Jhd19yZWFkbA0KPj4+IC0jZGVmaW5lIGZiX3JlYWRxIF9fcmF3X3Jl
YWRxDQo+Pj4gLSNkZWZpbmUgZmJfd3JpdGViIF9fcmF3X3dyaXRlYg0KPj4+IC0jZGVmaW5l
IGZiX3dyaXRldyBfX3Jhd193cml0ZXcNCj4+PiAtI2RlZmluZSBmYl93cml0ZWwgX19yYXdf
d3JpdGVsDQo+Pj4gLSNkZWZpbmUgZmJfd3JpdGVxIF9fcmF3X3dyaXRlcQ0KPj4NCj4+IE5v
dGUgdGhhdCBvbiBhdCBsZWFzdCBzb21lIGFyY2hpdGVjdHVyZXMsIHRoZSBfX3JhdyB2YXJp
YW50cyBhcmUNCj4+IG5hdGl2ZS1lbmRpYW4sIHdoZXJlYXMgdGhlIHJlZ3VsYXIgYWNjZXNz
b3JzIGFyZSBleHBsaWNpdGx5DQo+PiBsaXR0bGUtZW5kaWFuLCBzbyB0aGVyZSBpcyBhIHNs
aWdodCByaXNrIG9mIGluYWR2ZXJ0ZW50bHkgY2hhbmdpbmcNCj4+IGJlaGF2aW91ciBvbiBi
aWctZW5kaWFuIHN5c3RlbXMgKE1JUFMgbW9zdCBsaWtlbHksIGJ1dCBhIGZldyBvbGQgQVJN
DQo+PiBwbGF0Zm9ybXMgcnVuIEJFIGFzIHdlbGwpLg0KPiANCj4gQWxzbyBvbiBtNjhrLCB3
aGVuIElTQSBvciBQQ0kgYXJlIGVuYWJsZWQuDQo+IA0KPiBJbiBhZGRpdGlvbiwgdGhlIG5v
bi1yYXcgdmFyaWFudHMgbWF5IGRvIHNvbWUgZXh0cmFzIHRvIGd1YXJhbnRlZQ0KPiBvcmRl
cmluZywgd2hpY2ggeW91IGRvIG5vdCBuZWVkIG9uIGEgZnJhbWUgYnVmZmVyLg0KPiANCj4g
U28gSSdkIGdvIGZvciB0aGUgX19yYXdfKigpIHZhcmlhbnRzIGV2ZXJ5d2hlcmUuDQoNCk9r
LCBtYWtlcyBzZW5zZS4gQnV0IGl0IGFsc28gbWVhbnMgdGhhdCB3ZSB3b24ndCBiZSBhYmxl
IHRvIHJlbW92ZSB0aGUgDQpmYl8oKSBoZWxwZXJzLiBJZiB3ZSBnbyB3aXRoIHRoaXMgcHJv
cG9zYWwsIEknbGwgYWRkIHlvdXIgY29tbWVudHMgdG8gDQp0aGUgaGVhZGVyIGZpbGUsIHNv
IGl0J3MgY2xlYXIgd2h5IHRoZXkncmUgc3RpbGwgdGhlcmUuDQoNCkJlc3QgcmVnYXJkcw0K
VGhvbWFzDQoNCj4gDQo+IEdye29ldGplLGVldGluZ31zLA0KPiANCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgIEdlZXJ0DQo+IA0KDQotLSANClRob21hcyBaaW1tZXJtYW5uDQpHcmFw
aGljcyBEcml2ZXIgRGV2ZWxvcGVyDQpTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55
IEdtYkgNCkZyYW5rZW5zdHJhc3NlIDE0NiwgOTA0NjEgTnVlcm5iZXJnLCBHZXJtYW55DQpH
RjogSXZvIFRvdGV2LCBBbmRyZXcgTXllcnMsIEFuZHJldyBNY0RvbmFsZCwgQm91ZGllbiBN
b2VybWFuDQpIUkIgMzY4MDkgKEFHIE51ZXJuYmVyZykNCg==

--------------gFxfHJxEW03j1ssJGn8N0Y6F--

--------------9vTZXEQMf5PD7pb3rF0sqz18
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmRLwzQFAwAAAAAACgkQlh/E3EQov+B+
qw//R9K862VucVEoeHQ+G55XwVS6dlyCgHLUP6khfTfdNdi2e/YxEKm6zWEPxutuYpxL89u1jA2N
jw3/6HCvu9+/LvrhUWuCHMB8MHW/HUZbJBpACW6sQ0CrNKOCf6IbEFSO3wlf0dwxWOb3gPONSBar
C7wLfeiqHlNTFUcCxboJGkzgQt7GHRxSiG6XOmHu4RrMS3eZSKEQ8JxyBG7b+7f60sIqD4UoVQZ7
yZ3ffdjcZCK+D/n0NgGr4u95Opx63ThmC2AggTbRWaGxd3SWssKqRPphcDOS4GdqCDbuBmoohmAw
o6Eo03ErV4a5dOCXxOc9sjI9Tff8E1naMlmR42dKQjVFtgqdeSbp0ox0joZxs9J90Ufi+nMUq4KN
tZP8l/rlkb69sdr2DtF1x0NeLHornodWFKx4vWRzK/yw7cJggTDha51Nx24AjGzjhCd2TPMH/TT7
xcT3F/Uu7cdgDuAxqWqObJpsjdtk7sANjfrt1GIvg8W63c9sIKqNUAsNvgXBj9g1trKYRdLapxHb
Jaq/bCwqi+JaVpkI3tatnRmgVlG85l67eLdPSimvFLIznbAqn4A9ank7ZIg2k+0D6T8/3PoT8YI/
3MJbmwaMCpBU2VPgnaeZhewBDXvjhIxb6jXdgWRKuXjgp6KkdLAqJKdii8ExQHnVJhiPgaiPLUWC
rm8=
=cKk+
-----END PGP SIGNATURE-----

--------------9vTZXEQMf5PD7pb3rF0sqz18--
