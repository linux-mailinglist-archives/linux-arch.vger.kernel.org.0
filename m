Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF87874361D
	for <lists+linux-arch@lfdr.de>; Fri, 30 Jun 2023 09:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjF3Hq0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Jun 2023 03:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjF3HqQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Jun 2023 03:46:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1436410A;
        Fri, 30 Jun 2023 00:46:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4BFC21FD5E;
        Fri, 30 Jun 2023 07:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688111173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s+v7TzEsD6peXuEp+SUxn6T7G+IGk1te1iZtcpAk67w=;
        b=U5S0JZy6WbjyJY0i+chUuJjKDtyzvNR562iDu4mAoeIRYiMaQH05DYn3oC2IDHuCJ3la0d
        6efMYRbFWwT6WipW7DuzCUm5fOh+iBRlRjda9BeHpkLO1xMw6kBvbeEfXf4OoC4HGF0uY4
        zaQwtseSPMY8DGPVwfpIGEUiwJgpXQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688111173;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s+v7TzEsD6peXuEp+SUxn6T7G+IGk1te1iZtcpAk67w=;
        b=X8HFoQg8L0Cu/1xVytv0JrQeNcv7odrUfIRvQXZWtOmDKktKfLxyOGVAR3qIcYAPoHvLdQ
        4fb9jtJZixVDtrAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 899A313915;
        Fri, 30 Jun 2023 07:46:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZRQNIESInmT0OQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 30 Jun 2023 07:46:12 +0000
Message-ID: <ef7b3899-7d18-8018-47fa-aac0efaa61f4@suse.de>
Date:   Fri, 30 Jun 2023 09:46:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 07/12] arch/x86: Declare edid_info in <asm/screen_info.h>
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Helge Deller <deller@gmx.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>
References: <20230629121952.10559-1-tzimmermann@suse.de>
 <20230629121952.10559-8-tzimmermann@suse.de>
 <80e3a583-805e-4e8f-a67b-ebe2e4b9a7e5@app.fastmail.com>
 <d3de124c-6aa8-e930-e238-7bd6dd7929a6@suse.de>
 <0dbbdfc4-0e91-4be4-9ca0-d8ba6f18453d@app.fastmail.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <0dbbdfc4-0e91-4be4-9ca0-d8ba6f18453d@app.fastmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------2PcBvNvj4NxOJT00dP00OAEN"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------2PcBvNvj4NxOJT00dP00OAEN
Content-Type: multipart/mixed; boundary="------------mO7mj780JaYWOEkXFpUrFA6g";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Arnd Bergmann <arnd@arndb.de>, Helge Deller <deller@gmx.de>,
 Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 Linux-Arch <linux-arch@vger.kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Kees Cook <keescook@chromium.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Ard Biesheuvel <ardb@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>,
 Juerg Haefliger <juerg.haefliger@canonical.com>
Message-ID: <ef7b3899-7d18-8018-47fa-aac0efaa61f4@suse.de>
Subject: Re: [PATCH 07/12] arch/x86: Declare edid_info in <asm/screen_info.h>
References: <20230629121952.10559-1-tzimmermann@suse.de>
 <20230629121952.10559-8-tzimmermann@suse.de>
 <80e3a583-805e-4e8f-a67b-ebe2e4b9a7e5@app.fastmail.com>
 <d3de124c-6aa8-e930-e238-7bd6dd7929a6@suse.de>
 <0dbbdfc4-0e91-4be4-9ca0-d8ba6f18453d@app.fastmail.com>
In-Reply-To: <0dbbdfc4-0e91-4be4-9ca0-d8ba6f18453d@app.fastmail.com>

--------------mO7mj780JaYWOEkXFpUrFA6g
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMjkuMDYuMjMgdW0gMTU6MjEgc2NocmllYiBBcm5kIEJlcmdtYW5uOg0KPiBP
biBUaHUsIEp1biAyOSwgMjAyMywgYXQgMTU6MDEsIFRob21hcyBaaW1tZXJtYW5uIHdyb3Rl
Og0KPj4gQW0gMjkuMDYuMjMgdW0gMTQ6MzUgc2NocmllYiBBcm5kIEJlcmdtYW5uOg0KPj4+
IE9uIFRodSwgSnVuIDI5LCAyMDIzLCBhdCAxMzo0NSwgVGhvbWFzIFppbW1lcm1hbm4gd3Jv
dGU6DQo+Pj4+IFRoZSBnbG9iYWwgdmFyaWFibGUgZWRpZF9pbmZvIGNvbnRhaW5zIHRoZSBm
aXJtd2FyZSdzIEVESUQgaW5mb3JtYXRpb24NCj4+Pj4gYXMgYW4gZXh0ZW5zaW9uIHRvIHRo
ZSByZWd1bGFyIHNjcmVlbl9pbmZvIG9uIHg4Ni4gVGhlcmVmb3JlIG1vdmUgaXQgdG8NCj4+
Pj4gPGFzbS9zY3JlZW5faW5mby5oPi4NCj4+Pj4NCj4+Pj4gQWRkIHRoZSBLY29uZmlnIHRv
a2VuIEFSQ0hfSEFTX0VESURfSU5GTyB0byBndWFyZCBhZ2FpbnN0IGFjY2VzcyBvbg0KPj4+
PiBhcmNoaXRlY3R1cmVzIHRoYXQgZG9uJ3QgcHJvdmlkZSBlZGlkX2luZm8uIFNlbGVjdCBp
dCBvbiB4ODYuDQo+Pj4NCj4+PiBJJ20gbm90IHN1cmUgd2UgbmVlZCBhbm90aGVyIHN5bWJv
bCBpbiBhZGRpdGlvbiB0bw0KPj4+IENPTkZJR19GSVJNV0FSRV9FRElELiBTaW5jZSBhbGwg
dGhlIGNvZGUgYmVoaW5kIHRoYXQNCj4+PiBleGlzdGluZyBzeW1ib2wgaXMgYWxzbyB4ODYg
c3BlY2lmaWMsIHdvdWxkIGl0IGJlIGVub3VnaA0KPj4+IHRvIGp1c3QgYWRkIGVpdGhlciAn
ZGVwZW5kcyBvbiBYODYnIG9yICdkZXBlbmRzIG9uIFg4NiB8fA0KPj4+IENPTVBJTEVfVEVT
VCcgdGhlcmU/DQo+Pg0KPj4gRklSTVdBUkVfRURJRCBpcyBhIHVzZXItc2VsZWN0YWJsZSBm
ZWF0dXJlLCB3aGlsZSBBUkNIX0hBU19FRElEX0lORk8NCj4+IGFubm91bmNlcyBhbiBhcmNo
aXRlY3R1cmUgZmVhdHVyZS4gVGhleSBkbyBkaWZmZXJlbnQgdGhpbmdzLg0KPiANCj4gSSBz
dGlsbCBoYXZlIHRyb3VibGUgc2VlaW5nIHRoZSBkaWZmZXJlbmNlLg0KDQpUaGUgaWRlYSBo
ZXJlIGlzIHRoYXQgQVJDSF9IQVNfIHNpZ25hbHMgdGhlIGFyY2hpdGVjdHVyZSdzIHN1cHBv
cnQgZm9yIA0KdGhlIGZlYXR1cmUuICBEcml2ZXJzIHNldCAnZGVwZW5kcyBvbicgaW4gdGhl
aXIgS2NvbmZpZy4NCg0KQW5vdGhlciBLY29uZmlnIHRva2VuLCBWSURFT19TQ1JFRU5fSU5G
TyBvciBGSVJNV0FSRV9FRElELCB3b3VsZCB0aGVuIA0KYWN0dWFsbHkgZW5hYmxlIHRoZSBm
ZWF0dXJlLiAgRHJpdmVycyBzZWxlY3QgVklERU9fU0NSRUVOX0lORk8gb3IgDQpGSVJNV0FS
RV9FRElEIGFuZCB0aGUgYXJjaGl0ZWN0dXJlcyBjb250YWlucyBjb2RlIGxpa2UNCg0KI2lm
ZGVmIFZJREVPX1NDUkVFTl9JTkZPDQpzdHJ1Y3Qgc2NyZWVuX2luZm8gc2NyZWVuX2luZm8g
PSB7DQoJLyogc2V0IHZhbHVlcyBoZXJlICovDQp9DQojZW5kaWYNCg0KVGhpcyBhbGxvd3Mg
dXMgdG8gZGlzYWJsZSBjb2RlIHRoYXQgcmVxdWlyZXMgc2NyZWVuX2luZm8vZWRpZF9pbmZv
LCBidXQgDQphbHNvIGRpc2FibGUgc2NyZWVuX2luZm8vZWRpZF9pbmZvIHVubGVzcyBzdWNo
IGNvZGUgaGFzIGJlZW4gZW5hYmxlZCBpbiANCnRoZSBrZXJuZWwgY29uZmlnLg0KDQpTb21l
IGFyY2hpdGVjdHVyZXMgY3VycmVudGx5IG1pbWljIHRoaXMgYnkgZ3VhcmRpbmcgc2NyZWVu
X2luZm8gd2l0aCANCmlmZGVmIENPTkZJR19WVCBvciBzaW1pbGFyLiBJJ2QgbGlrZSB0byBt
YWtlIHRoaXMgbW9yZSBmbGV4aWJsZS4gVGhlIA0KY29zdCBvZiBhIGZldyBtb3JlIGludGVy
bmFsIEtjb25maWcgdG9rZW5zIHNlZW1zIG5lZ2xpZ2libGUuDQoNCj4gDQo+PiBSaWdodCBu
b3csIEFSQ0hfSEFTX0VESURfSU5GTyBvbmx5IHdvcmtzIG9uIHRoZSBvbGQgQklPUy1iYXNl
ZCBWRVNBDQo+PiBzeXN0ZW1zLiBJbiB0aGUgZnV0dXJlLCBJIHdhbnQgdG8gYWRkIHN1cHBv
cnQgZm9yIEVESUQgZGF0YSBmcm9tIEVGSSBhbmQNCj4+IE9GIGFzIHdlbGwuIEl0IHdvdWxk
IGJlIHN0b3JlZCBpbiBlZGlkX2luZm8uIEkgYXNzdW1lIHRoYXQgdGhlIG5ldw0KPj4gc3lt
Ym9sIHdpbGwgYmVjb21lIHVzZWZ1bCB0aGVuLg0KPiANCj4gSSBkb24ndCBzZWUgd2h5IGFu
IE9GIGJhc2VkIHN5c3RlbSB3b3VsZCBoYXZlIHRoZSBzYW1lIGxpbWl0YXRpb24NCj4gYXMg
bGVnYWN5IEJJT1Mgd2l0aCBzdXBwb3J0aW5nIG9ubHkgYSBzaW5nbGUgbW9uaXRvciwgaWYg
d2UgbmVlZA0KPiB0byBoYXZlIGEgZ2VuZXJpYyByZXByZXNlbnRhdGlvbiBvZiBFRElEIGRh
dGEgaW4gRFQsIHRoYXQgd291bGQNCj4gcHJvYmFibHkgYmUgaW4gYSBwZXIgZGV2aWNlIHBy
b3BlcnR5IGFueXdheS4NCg0KU29ycnkgdGhhdCB3YXMgbXkgbWlzdGFrZS4gT0YgaGFzIG5v
dGhpbmcgdG8gZG8gd2l0aCB0aGlzLg0KDQo+IA0KPiBJIHN1cHBvc2UgeW91IGNvdWxkIHVz
ZSBGSVJNV0FSRV9FRElEIG9uIEVGSSBvciBPRiBzeXN0ZW1zIHdpdGhvdXQNCj4gdGhlIG5l
ZWQgZm9yIGEgZ2xvYmFsIGVkaWRfaW5mbyBzdHJ1Y3R1cmUsIGJ1dCB0aGF0IHdvdWxkIG5v
dA0KPiBzaGFyZSBhbnkgY29kZSB3aXRoIHRoZSBjdXJyZW50IGZiX2Zpcm13YXJlX2VkaWQo
KSBmdW5jdGlvbi4NCg0KVGhlIGN1cnJlbnQgY29kZSBpcyBidWlsZCBvbiB0b3Agb2Ygc2Ny
ZWVuX2luZm8gYW5kIGVkaWRfaW5mby4gSSdkIA0KcHJlZmVyYWJseSBub3QgcmVwbGFjZSB0
aGF0LCBpZiBwb3NzaWJsZS4NCg0KQmVzdCByZWdhcmRzDQpUaG9tYXMNCg0KPiANCj4gICAg
ICAgQXJuZA0KDQotLSANClRob21hcyBaaW1tZXJtYW5uDQpHcmFwaGljcyBEcml2ZXIgRGV2
ZWxvcGVyDQpTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgNCkZyYW5rZW5z
dHJhc3NlIDE0NiwgOTA0NjEgTnVlcm5iZXJnLCBHZXJtYW55DQpHRjogSXZvIFRvdGV2LCBB
bmRyZXcgTXllcnMsIEFuZHJldyBNY0RvbmFsZCwgQm91ZGllbiBNb2VybWFuDQpIUkIgMzY4
MDkgKEFHIE51ZXJuYmVyZykNCg==

--------------mO7mj780JaYWOEkXFpUrFA6g--

--------------2PcBvNvj4NxOJT00dP00OAEN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmSeiEMFAwAAAAAACgkQlh/E3EQov+As
5Q/9H55ggR4DmBaaIorbgBWGfEk+cZYwIsKGIz88GTA+c5VuSIo6Mc6nMauV6sDZwQuqK4aWIzzR
jVTZ+JGcp3h1o6Cb0aTHu4wIa0XkYCuT1Lo7p8q02mhS2T/EtbkiMAktmfNBBOCQ2Fp1RYjL5Fnx
D8F1O/+gATcQgYGWJ4V3Y0khLBjCIhqZLpoDUZgvIznRExZlWP+eZ/NIuYR/PiM7/z0Gu/p+FZEo
XIZrcJeJGET5ciMIAmV2d8zLT2YAwSz0bsLLYt5xyeZkVZBUKuQ93wUicuYaqXHIqpUz760GPe3M
uITt6uKCQQHv2MOawwpy/YMei3eFhbCAixdayLHfhcyo1u3fnGsQWaLYStVYNnkfTEEb3abRZrUz
gR90CVdui0m94ExphiWAzSjj/SbKYkUc0haYzE/CHronlSSiqHhTDghKfjEli6yS8cAAxSDZVcgw
pggFLw7Xz3f+ITbu/zV1QzMHX5bOV+3ThWxpDGXmeQ4k60lx80NaI3unnFQqi4KN0Gyu2i2ptFNU
KRuLox9gnQf9J50AkJOShkapFUjTVNDwxJ0Ftikb/pv/UXdsLrnWzrPgi4Qn6Y49jqHRb2wNFcIF
erX2SS+S6zYk36Pg6L77ceHnxC0rIaZBtZ81YxFtMiZ9l8YV2rJS8orASwSIzF/yPiZXZgFY3ZQm
S2Y=
=pDNZ
-----END PGP SIGNATURE-----

--------------2PcBvNvj4NxOJT00dP00OAEN--
