Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127686D860E
	for <lists+linux-arch@lfdr.de>; Wed,  5 Apr 2023 20:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjDESd5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Apr 2023 14:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbjDESdz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Apr 2023 14:33:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0DD6A47;
        Wed,  5 Apr 2023 11:33:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 274AC22388;
        Wed,  5 Apr 2023 18:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680719631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aKm+2KnGcfadUGufvWlUYTOWO8wYUF/m6w9EgTd+Yxg=;
        b=AY9ehin0RCIs0Z/tUz5CKDnk5hMcYELqfYZsQf6JezYbYgl6N+MUriBP2y4z/HS/u2p4uV
        vUpEjY29QAk2ubCGTL9muUVgDVI9nLeBUNgGl3cXLFVPYaIg+72dyNHTO+LDRdjUlU8VdL
        nd1HL6uwb/bGPH2YvPQKvg4RXUfpPNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680719631;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aKm+2KnGcfadUGufvWlUYTOWO8wYUF/m6w9EgTd+Yxg=;
        b=UfgF0YRnUz9dpmsQ4gm6okcJLQEX7z9ep+Kr7HyJzwDq82jBBbfBGRO9qN7DSGXIQELO1T
        DjJ7TAxa27NsccAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD06F13A31;
        Wed,  5 Apr 2023 18:33:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6kDPLA6/LWSPBwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 05 Apr 2023 18:33:50 +0000
Message-ID: <769a46bd-0c35-f61f-6d68-b982fc25cb55@suse.de>
Date:   Wed, 5 Apr 2023 20:33:50 +0200
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
        linux-fbdev@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, loongarch@lists.linux.dev,
        sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20230405150554.30540-1-tzimmermann@suse.de>
 <20230405150554.30540-2-tzimmermann@suse.de>
 <92fe3838-41f0-4e27-8467-161553ff724f@app.fastmail.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <92fe3838-41f0-4e27-8467-161553ff724f@app.fastmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------PH6RE0bdaBjJFU6C368NRApK"
X-Spam-Status: No, score=-3.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------PH6RE0bdaBjJFU6C368NRApK
Content-Type: multipart/mixed; boundary="------------PnZlrreMxn0zLzAk4t4Das5u";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Helge Deller <deller@gmx.de>, Javier Martinez Canillas <javierm@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-fbdev@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, loongarch@lists.linux.dev,
 sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Message-ID: <769a46bd-0c35-f61f-6d68-b982fc25cb55@suse.de>
Subject: Re: [PATCH 01/18] fbdev: Prepare generic architecture helpers
References: <20230405150554.30540-1-tzimmermann@suse.de>
 <20230405150554.30540-2-tzimmermann@suse.de>
 <92fe3838-41f0-4e27-8467-161553ff724f@app.fastmail.com>
In-Reply-To: <92fe3838-41f0-4e27-8467-161553ff724f@app.fastmail.com>

--------------PnZlrreMxn0zLzAk4t4Das5u
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
Cj4gd29ya2Fyb3VuZHMuDQoNCk1ha2Ugc2Vuc2UsIHRoYW5rcyBmb3IgdGhlIGZlZWRiYWNr
LiBJJ2xsIHNlbmQgb3V0IGFuIHVwZGF0ZSBzb29uLg0KDQpCZXN0IHJlZ2FyZHMNClRob21h
cw0KDQo+IA0KPiBJIHNlZSB0aGF0IHNwYXJjNjQgYW5kIHBhcmlzYyB1c2UgcGdwcm90X3Vu
Y2FjaGVkIGhlcmUsIGJ1dCBhcw0KPiB0aGV5IGRvbid0IGRlZmluZSBhIGN1c3RvbSBwZ3By
b3Rfd3JpdGVjb21iaW5lLCB0aGlzIGVuZHMgdXAgYmVpbmcNCj4gdGhlIHNhbWUsIGFuZCB0
aGV5IGNhbiB1c2UgdGhlIGFib3ZlIGRlZmluaXRpb24gYXMgd2VsbC4NCj4gDQo+IG1pcHMg
ZGVmaW5lcyBwZ3Byb3Rfd3JpdGVjb21iaW5lIGJ1dCB1c2VzIHBncHJvdF9ub25jYWNoZWQN
Cj4gaW4gZmJfcGdwcm90ZWN0KCksIHdoaWNoIGlzIHByb2JhYmx5IGEgbWlzdGFrZSBhbmQg
c2hvdWxkIGhhdmUNCj4gYmVlbiB1cGRhdGVkIGFzIHBhcnQgb2YgY29tbWl0IDRiMDUwYmE3
YTY2YyAoIk1JUFM6IHBndGFibGUuaDoNCj4gSW1wbGVtZW50IHRoZSBwZ3Byb3Rfd3JpdGVj
b21iaW5lIGZ1bmN0aW9uIGZvciBNSVBTIikuDQo+IA0KPiAgICAgIEFybmQNCg0KLS0gDQpU
aG9tYXMgWmltbWVybWFubg0KR3JhcGhpY3MgRHJpdmVyIERldmVsb3Blcg0KU1VTRSBTb2Z0
d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJIDQpNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xy
bmJlcmcsIEdlcm1hbnkNCihIUkIgMzY4MDksIEFHIE7DvHJuYmVyZykNCkdlc2Now6RmdHNm
w7xocmVyOiBJdm8gVG90ZXYNCg==

--------------PnZlrreMxn0zLzAk4t4Das5u--

--------------PH6RE0bdaBjJFU6C368NRApK
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmQtvw4FAwAAAAAACgkQlh/E3EQov+B8
SA//S9QvzhCGuS3p6cljiL3iXZKRa6QAzsmTs3qxsBZJVBbAx2oX35juNiYn+llSA4KM2AWgFRYq
Chdjg/0Vxe5/Nl4HGfHpvKLVmZIg1kHtRRwixJ04p4ws8EPfiZN87MeLecWlQo5x9ewt0yCmBeoA
j0eLKDz3kN88NbEuFuTqP3y/H5VaDJUZeqCX2OXBVFPCttZjWgkJ77r5CFvMexzh6fMQ+QP/EKbh
EDDsfHUqq0YKCQobH2KcnEEX+CKJeVR+45+SwdaolfgGzBQ9TFKWnagaJahppLWfzFtg1Tj12NAE
A+Lcrd395eNy1L4TVf3rVDNiWaUGudPY/iAhQ4ivmvj1Rb3esoRkjN4zmSek590XUZ8jZShkgTig
dSgkdgKIWTi/lDCB5NgCZgPpsk6TDcc6Kyj99h6UqYzZiYN3GAaXfP1qgPCPI5el9PphHxaXhOH0
e6PhctJWfsuRVWseHjFXi5M+svclBMYk6bOBvo5K9DYF8PTb5pCSRjk3+P9xqW2DeJfoBQClb5HF
JBrMpw8SyQYttizA3bYrXaib4c+t6gvbtaV1bbSzpzZx8vueBtvFY9RB7V5k9sThNULfdsnNc4Ke
CERFDV8vqaQmPTxLxiFvMGuxGysMG8sljev95fD3tcAQIuWY/QA8bnPq3b1pueBR7t7lp+IQ/e26
RHI=
=NHDz
-----END PGP SIGNATURE-----

--------------PH6RE0bdaBjJFU6C368NRApK--
