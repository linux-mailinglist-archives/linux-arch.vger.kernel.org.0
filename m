Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B32D6D990E
	for <lists+linux-arch@lfdr.de>; Thu,  6 Apr 2023 16:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238817AbjDFOH2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Apr 2023 10:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239128AbjDFOHL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Apr 2023 10:07:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AF793E4;
        Thu,  6 Apr 2023 07:06:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 035D61FE10;
        Thu,  6 Apr 2023 14:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680789996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tj6qTYY7HjBmnMQqASkMGFG64SRZ5nWbwwt6tzxcRgc=;
        b=rvHBfS6gogvIKS2WovtcYsR106i5Tjq5cU3i0pyVVXeX5J+IdGwrUy5cVxbSC7rEOcYUuN
        gdRVtyDitINz4rfczZjNAiRkxY+HEt1kkOY5tjWweZ2J3cdVv86FTh6Z7dXc1Fa5xxfePP
        yDVhu5n/+Pfw2Xj2dzYQIZfJnflUEyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680789996;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tj6qTYY7HjBmnMQqASkMGFG64SRZ5nWbwwt6tzxcRgc=;
        b=YcQ4OxRj56Q1ndvbvFNPAjAa2H/rnTTFQzthtdsdnqAvv70fsma6TU4T/gg2qX1w8ECDl8
        V9wHzCwWeVJyFEDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 90DAF1351F;
        Thu,  6 Apr 2023 14:06:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QOptIuvRLmTYIAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 06 Apr 2023 14:06:35 +0000
Message-ID: <71e5450f-aad2-1f7c-a961-c0b0fce62eea@suse.de>
Date:   Thu, 6 Apr 2023 16:06:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 01/18] fbdev: Prepare generic architecture helpers
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org
References: <20230405150554.30540-1-tzimmermann@suse.de>
 <20230405150554.30540-2-tzimmermann@suse.de>
 <92fe3838-41f0-4e27-8467-161553ff724f@app.fastmail.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <92fe3838-41f0-4e27-8467-161553ff724f@app.fastmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------5BePbc0zJRAG34NMI313OlgI"
X-Spam-Status: No, score=-4.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------5BePbc0zJRAG34NMI313OlgI
Content-Type: multipart/mixed; boundary="------------MODvgaz0WeNglR1dVG2UtKLY";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Helge Deller <deller@gmx.de>, Javier Martinez Canillas <javierm@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-snps-arc@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Message-ID: <71e5450f-aad2-1f7c-a961-c0b0fce62eea@suse.de>
Subject: Re: [PATCH 01/18] fbdev: Prepare generic architecture helpers
References: <20230405150554.30540-1-tzimmermann@suse.de>
 <20230405150554.30540-2-tzimmermann@suse.de>
 <92fe3838-41f0-4e27-8467-161553ff724f@app.fastmail.com>
In-Reply-To: <92fe3838-41f0-4e27-8467-161553ff724f@app.fastmail.com>

--------------MODvgaz0WeNglR1dVG2UtKLY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMDUuMDQuMjMgdW0gMTc6NTMgc2NocmllYiBBcm5kIEJlcmdtYW5uOg0KPiBP
biBXZWQsIEFwciA1LCAyMDIzLCBhdCAxNzowNSwgVGhvbWFzIFppbW1lcm1hbm4gd3JvdGU6
DQo+PiBHZW5lcmljIGltcGxlbWVudGF0aW9ucyBvZiBmYl9wZ3Byb3RlY3QoKSBhbmQgZmJf
aXNfcHJpbWFyeV9kZXZpY2UoKQ0KPj4gaGF2ZSBiZWVuIGluIHRoZSBzb3VyY2UgY29kZSBm
b3IgYSBsb25nIHRpbWUuIFByZXBhcmUgdGhlIGhlYWRlciBmaWxlDQo+PiB0byBtYWtlIHVz
ZSBvZiB0aGVtLg0KPj4NCj4+IEltcHJvdmUgdGhlIGNvZGUgYnkgdXNpbmcgYW4gaW5saW5l
IGZ1bmN0aW9uIGZvciBmYl9wZ3Byb3RlY3QoKSBhbmQNCj4+IGJ5IHJlbW92aW5nIGluY2x1
ZGUgc3RhdGVtZW50cy4NCj4+DQo+PiBTeW1ib2xzIGFyZSBwcm90ZWN0ZWQgYnkgcHJlcHJv
Y2Vzc29yIGd1YXJkcy4gQXJjaGl0ZWN0dXJlcyB0aGF0DQo+PiBwcm92aWRlIGEgc3ltYm9s
IG5lZWQgdG8gZGVmaW5lIGEgcHJlcHJvY2Vzc29yIHRva2VuIG9mIHRoZSBzYW1lDQo+PiBu
YW1lIGFuZCB2YWx1ZS4gT3RoZXJ3aXNlIHRoZSBoZWFkZXIgZmlsZSB3aWxsIHByb3ZpZGUg
YSBnZW5lcmljDQo+PiBpbXBsZW1lbnRhdGlvbi4gVGhpcyBwYXR0ZXJuIGhhcyBiZWVuIHRh
a2VuIGZyb20gPGFzbS9pby5oPi4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgWmlt
bWVybWFubiA8dHppbW1lcm1hbm5Ac3VzZS5kZT4NCj4gDQo+IE1vdmluZyB0aGlzIGludG8g
Z2VuZXJpYyBjb2RlIGlzIGdvb2QsIGJ1dCBJJ20gbm90IHN1cmUNCj4gYWJvdXQgdGhlIGRl
ZmF1bHQgZm9yIGZiX3BncHJvdGVjdCgpOg0KPiANCj4+ICsNCj4+ICsjaWZuZGVmIGZiX3Bn
cHJvdGVjdA0KPj4gKyNkZWZpbmUgZmJfcGdwcm90ZWN0IGZiX3BncHJvdGVjdA0KPj4gK3N0
YXRpYyBpbmxpbmUgdm9pZCBmYl9wZ3Byb3RlY3Qoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVj
dCB2bV9hcmVhX3N0cnVjdCAqdm1hLA0KPj4gKwkJCQl1bnNpZ25lZCBsb25nIG9mZikNCj4+
ICt7IH0NCj4+ICsjZW5kaWYNCj4gDQo+IEkgdGhpbmsgbW9zdCBhcmNoaXRlY3R1cmVzIHdp
bGwgd2FudCB0aGUgdmVyc2lvbiB3ZSBoYXZlIG9uDQo+IGFyYywgYXJtLCBhcm02NCwgbG9v
bmdhcmNoLCBhbmQgc2ggYWxyZWFkeToNCj4gDQo+IHN0YXRpYyBpbmxpbmUgdm9pZCBmYl9w
Z3Byb3RlY3Qoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1h
LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIG9m
ZikNCj4gew0KPiAgICAgICAgIHZtYS0+dm1fcGFnZV9wcm90ID0gcGdwcm90X3dyaXRlY29t
YmluZSh2bWEtPnZtX3BhZ2VfcHJvdCk7DQo+IH0NCj4gDQo+IHNvIEknZCBzdWdnZXN0IG1h
a2luZyB0aGF0IHZlcnNpb24gdGhlIGRlZmF1bHQsIGFuZCB0cmVhdGluZyB0aGUNCj4gZW1w
dHkgb25lcyAobTY4a25vbW11LCBzcGFyYzMyKSBhcyBhcmNoaXRlY3R1cmUgc3BlY2lmaWMN
Cj4gd29ya2Fyb3VuZHMuDQo+IA0KPiBJIHNlZSB0aGF0IHNwYXJjNjQgYW5kIHBhcmlzYyB1
c2UgcGdwcm90X3VuY2FjaGVkIGhlcmUsIGJ1dCBhcw0KPiB0aGV5IGRvbid0IGRlZmluZSBh
IGN1c3RvbSBwZ3Byb3Rfd3JpdGVjb21iaW5lLCB0aGlzIGVuZHMgdXAgYmVpbmcNCj4gdGhl
IHNhbWUsIGFuZCB0aGV5IGNhbiB1c2UgdGhlIGFib3ZlIGRlZmluaXRpb24gYXMgd2VsbC4N
Cj4gDQo+IG1pcHMgZGVmaW5lcyBwZ3Byb3Rfd3JpdGVjb21iaW5lIGJ1dCB1c2VzIHBncHJv
dF9ub25jYWNoZWQNCj4gaW4gZmJfcGdwcm90ZWN0KCksIHdoaWNoIGlzIHByb2JhYmx5IGEg
bWlzdGFrZSBhbmQgc2hvdWxkIGhhdmUNCj4gYmVlbiB1cGRhdGVkIGFzIHBhcnQgb2YgY29t
bWl0IDRiMDUwYmE3YTY2YyAoIk1JUFM6IHBndGFibGUuaDoNCj4gSW1wbGVtZW50IHRoZSBw
Z3Byb3Rfd3JpdGVjb21iaW5lIGZ1bmN0aW9uIGZvciBNSVBTIikuDQoNCkkgd291bGQgbm90
IHdhbnQgdG8gY2hhbmdlIGFueSBvZiB0aGUgb3RoZXIgcGxhdGZvcm0ncyBmdW5jdGlvbnMg
dW5sZXNzIA0KdGhlIHJzcCBwbGF0Zm9ybSBtYWludGFpbmVycyBhc2sgbWUgdG8uDQoNCkJl
c3QgcmVnYXJkcw0KVGhvbWFzDQoNCj4gDQo+ICAgICAgQXJuZA0KDQotLSANClRob21hcyBa
aW1tZXJtYW5uDQpHcmFwaGljcyBEcml2ZXIgRGV2ZWxvcGVyDQpTVVNFIFNvZnR3YXJlIFNv
bHV0aW9ucyBHZXJtYW55IEdtYkgNCk1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZywg
R2VybWFueQ0KKEhSQiAzNjgwOSwgQUcgTsO8cm5iZXJnKQ0KR2VzY2jDpGZ0c2bDvGhyZXI6
IEl2byBUb3Rldg0K

--------------MODvgaz0WeNglR1dVG2UtKLY--

--------------5BePbc0zJRAG34NMI313OlgI
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmQu0esFAwAAAAAACgkQlh/E3EQov+A3
+Q//XOh61SSsVY48Py2Qalvs1ZdXTTRJozsv2OV7IZPGNx2cNXvMk7k0wZz2OwgpV4+lWxgq+yvD
An33+eafJLUSvtNpjYl5omC4MaOfnHk5CdOFw+exisXyQs+mN4fFeZRfaG8pEloJPbr5hz1Ecl9G
D0eey1O1uv8TDN/grrY6+6TyOnYQGFmpYYRrE4gKaL5EdRKy1Zs0BQSWXe0sV/4iaAEpJzPuhcfA
S2EHgrw1S024RFR0tpttyy8RilJa2qahDL8iWrhLIfo3S0ufRvtGLm2QW2K+/x7lOufPlQsw/X16
c50C6N4UFCtWwlyyJGX5jbN/ewELBAVVLgA6/APMVAnKfg1742JNBSRQ/e19LFrNgiFbk9DD2X47
z9K7LklM8KoW0GYV7Oihqdeov9mVkbK+kr4euXPEOSvuGLvlW3mm56zvTgDJnKy4szqXr9Z4tJt2
Eo5QfO2VIAjjji9HdAfc55ygnPfjLikSWUwktYEPsrFv3dYg8BYa6W4uaAzbBwwu1RR+xjfXic40
Jr+a1a/Bd3HI+zPXW2PF6Fbi9XYn/6DTPy+0UZnuV6NPG9v51ekpdxJFFL6hOGrQBGBP0VOhWKYO
7c5sc8Bbosxe7TtLw0DnQJRNwIkAkzlKfptXIGasPvIuXrUE4VvceO5fTc1H2IexRQpdBK72wSJ1
VWE=
=wP7T
-----END PGP SIGNATURE-----

--------------5BePbc0zJRAG34NMI313OlgI--
