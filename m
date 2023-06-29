Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF217426D6
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jun 2023 15:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjF2NBW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Jun 2023 09:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF2NBV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jun 2023 09:01:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D3C2D50;
        Thu, 29 Jun 2023 06:01:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BA3AD2185F;
        Thu, 29 Jun 2023 13:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688043674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4m+LxHrP4v5vDuAdscRPXrBhg7ZxGweHb/obubiZPnU=;
        b=si2B6/wUmvLGD2VMznJt8GhKzcvK6hB4Sm3g0IU7DBWdt854TRtT+6KzgjHASsdcHT2qXk
        HCPraip0LJ7GF8hGnLz+Li5PFau6wyGSGdtuH5p1TsbrSWE9WHMo/TJgIPtsD+nBI4LdkS
        t3de5D5uJ1xmBO3TJMDA/rEcFDiX/Qo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688043674;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4m+LxHrP4v5vDuAdscRPXrBhg7ZxGweHb/obubiZPnU=;
        b=lrze9wdpBnC4u8EeddONENmfXDlROyI+lNkipjgMxJMypMKJCgGHMuhra1DagsLCA5P7ab
        +ASGEZPEce8WvCBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 160DE139FF;
        Thu, 29 Jun 2023 13:01:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AMtCBJqAnWSeagAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 29 Jun 2023 13:01:14 +0000
Message-ID: <d3de124c-6aa8-e930-e238-7bd6dd7929a6@suse.de>
Date:   Thu, 29 Jun 2023 15:01:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 07/12] arch/x86: Declare edid_info in <asm/screen_info.h>
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
Content-Language: en-US
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <80e3a583-805e-4e8f-a67b-ebe2e4b9a7e5@app.fastmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------SZ3Fp31sJnYOAqWyCv8ANxZ2"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------SZ3Fp31sJnYOAqWyCv8ANxZ2
Content-Type: multipart/mixed; boundary="------------Fba4i0vDnEvGaqqh9SwG9WxN";
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
Message-ID: <d3de124c-6aa8-e930-e238-7bd6dd7929a6@suse.de>
Subject: Re: [PATCH 07/12] arch/x86: Declare edid_info in <asm/screen_info.h>
References: <20230629121952.10559-1-tzimmermann@suse.de>
 <20230629121952.10559-8-tzimmermann@suse.de>
 <80e3a583-805e-4e8f-a67b-ebe2e4b9a7e5@app.fastmail.com>
In-Reply-To: <80e3a583-805e-4e8f-a67b-ebe2e4b9a7e5@app.fastmail.com>

--------------Fba4i0vDnEvGaqqh9SwG9WxN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMjkuMDYuMjMgdW0gMTQ6MzUgc2NocmllYiBBcm5kIEJlcmdtYW5uOg0KPiBP
biBUaHUsIEp1biAyOSwgMjAyMywgYXQgMTM6NDUsIFRob21hcyBaaW1tZXJtYW5uIHdyb3Rl
Og0KPj4gVGhlIGdsb2JhbCB2YXJpYWJsZSBlZGlkX2luZm8gY29udGFpbnMgdGhlIGZpcm13
YXJlJ3MgRURJRCBpbmZvcm1hdGlvbg0KPj4gYXMgYW4gZXh0ZW5zaW9uIHRvIHRoZSByZWd1
bGFyIHNjcmVlbl9pbmZvIG9uIHg4Ni4gVGhlcmVmb3JlIG1vdmUgaXQgdG8NCj4+IDxhc20v
c2NyZWVuX2luZm8uaD4uDQo+Pg0KPj4gQWRkIHRoZSBLY29uZmlnIHRva2VuIEFSQ0hfSEFT
X0VESURfSU5GTyB0byBndWFyZCBhZ2FpbnN0IGFjY2VzcyBvbg0KPj4gYXJjaGl0ZWN0dXJl
cyB0aGF0IGRvbid0IHByb3ZpZGUgZWRpZF9pbmZvLiBTZWxlY3QgaXQgb24geDg2Lg0KPiAN
Cj4gSSdtIG5vdCBzdXJlIHdlIG5lZWQgYW5vdGhlciBzeW1ib2wgaW4gYWRkaXRpb24gdG8N
Cj4gQ09ORklHX0ZJUk1XQVJFX0VESUQuIFNpbmNlIGFsbCB0aGUgY29kZSBiZWhpbmQgdGhh
dA0KPiBleGlzdGluZyBzeW1ib2wgaXMgYWxzbyB4ODYgc3BlY2lmaWMsIHdvdWxkIGl0IGJl
IGVub3VnaA0KPiB0byBqdXN0IGFkZCBlaXRoZXIgJ2RlcGVuZHMgb24gWDg2JyBvciAnZGVw
ZW5kcyBvbiBYODYgfHwNCj4gQ09NUElMRV9URVNUJyB0aGVyZT8NCg0KRklSTVdBUkVfRURJ
RCBpcyBhIHVzZXItc2VsZWN0YWJsZSBmZWF0dXJlLCB3aGlsZSBBUkNIX0hBU19FRElEX0lO
Rk8gDQphbm5vdW5jZXMgYW4gYXJjaGl0ZWN0dXJlIGZlYXR1cmUuIFRoZXkgZG8gZGlmZmVy
ZW50IHRoaW5ncy4NCg0KUmlnaHQgbm93LCBBUkNIX0hBU19FRElEX0lORk8gb25seSB3b3Jr
cyBvbiB0aGUgb2xkIEJJT1MtYmFzZWQgVkVTQSANCnN5c3RlbXMuIEluIHRoZSBmdXR1cmUs
IEkgd2FudCB0byBhZGQgc3VwcG9ydCBmb3IgRURJRCBkYXRhIGZyb20gRUZJIGFuZCANCk9G
IGFzIHdlbGwuIEl0IHdvdWxkIGJlIHN0b3JlZCBpbiBlZGlkX2luZm8uIEkgYXNzdW1lIHRo
YXQgdGhlIG5ldyANCnN5bWJvbCB3aWxsIGJlY29tZSB1c2VmdWwgdGhlbi4NCg0KQmVmb3Jl
IHRoaXMgcGF0Y2hzZXQsIEkgb3JpZ2luYWxseSB3YW50ZWQgdG8gbWFrZSB1c2Ugb2YgZWRp
ZF9pbmZvIGluIA0KdGhlIHNpbXBsZWRybSBncmFwaGljcyBkcml2ZXIuIEJ1dCBJIGZvdW5k
IHRoYXQgdGhlIHJzcCBjb2RlIGNvdWxkIHVzZSANCnNvbWUgd29yayBmaXJzdC4gTWF5YmUg
dGhlIHBhdGNoc2V0IGFyZSBhbHJlYWR5IHRhaWxvcmVkIHRvd2FyZHMgdGhlIA0KZnV0dXJl
IGNoYW5nZXMuDQoNCkJlc3QgcmVnYXJkcw0KVGhvbWFzDQoNCj4gDQo+ICAgICAgICBBcm5k
DQoNCi0tIA0KVGhvbWFzIFppbW1lcm1hbm4NCkdyYXBoaWNzIERyaXZlciBEZXZlbG9wZXIN
ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSA0KRnJhbmtlbnN0cmFzc2Ug
MTQ2LCA5MDQ2MSBOdWVybmJlcmcsIEdlcm1hbnkNCkdGOiBJdm8gVG90ZXYsIEFuZHJldyBN
eWVycywgQW5kcmV3IE1jRG9uYWxkLCBCb3VkaWVuIE1vZXJtYW4NCkhSQiAzNjgwOSAoQUcg
TnVlcm5iZXJnKQ0K

--------------Fba4i0vDnEvGaqqh9SwG9WxN--

--------------SZ3Fp31sJnYOAqWyCv8ANxZ2
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmSdgJkFAwAAAAAACgkQlh/E3EQov+Cl
bxAAm+hGmlLm1iLWXP6jD2U5nsiXRjJcsGyJdloLEa0TBl/4XdOzljHvQSLp2jQ9hLPoWaYoRyPd
D9cWI1UaCcGh+9WCeX0mforFfLFs7K3CuOwUXPP9Dfe/c5d5wy+SubTjvPRw2+Z3jdwZrz8GZ1Tw
HGtRvA1xIK12wyil9CFCyGKonc8sIItE1FWd8C0qIIG85oE4U4N1Zg+UgMeFt6AiyWuPiu6Lojse
YbUMT9KLt/J5dKTeDe8oJtkFzlopQIyZkik9XyRTV12/zAWnzNXOS237Kqj6PkzyD7Y0ExWX/91F
2y+e7rflzXYzEO2eUjEuZ1e8xsYZNuvXFHvCqYRh5QAUykF1GE5j73eNth0gY+y0AqRGDPCnBoJ9
alTkBF9VnCAJgQBlJwUHMTXj6m5JmZvQNqH9hde1g9eqeu33rU9MgVqsjKzIZP2D2AIAFLwdZAM/
u3ywiagO9K2LVWYORCJ0A3QGMxYm+bGOMUAn0lavFHENLB0Q/UAByw70L8cneLamlb2hiI0sqBKH
gGvTY4ZOrQV2qVfh0KOM6phWAHMf9O78kpg4hHuNnbF2I6zeZKbW/rJKUTUJMevtpA+c9vceIOQC
ni2rIZCmtVyAOh2lpbfiI1Ed9NMc1I7pB7dOpq9/3sG0DGptpxoGUwo0BrTkqqpxM34KSw/lQMQo
Ql0=
=PuWP
-----END PGP SIGNATURE-----

--------------SZ3Fp31sJnYOAqWyCv8ANxZ2--
