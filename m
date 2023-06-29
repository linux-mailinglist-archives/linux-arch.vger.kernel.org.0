Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B4A74271E
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jun 2023 15:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjF2NSN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Jun 2023 09:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjF2NSM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jun 2023 09:18:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A43213D;
        Thu, 29 Jun 2023 06:18:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2AA752185E;
        Thu, 29 Jun 2023 13:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688044690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K5LR3H2yhcLZRfkUpcC1pYuRSidZ3cqdCZg/hSroVmk=;
        b=iMfm+/ekl0xfXphQ8TVMKTrT9ToRvi4MYfuPCVZZAy+JWtEwFNQpmWYIMp1ahVk0VzxEMc
        9vdJjhaRzuPHB0EZlpDS2j4gGqL462DXX3aZ/YckBYoB9WMBTuLu9QNIxB5UgNdqSpVH7z
        52WX/ny9kEUHZSPElxwmGtlhnjwzsns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688044690;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K5LR3H2yhcLZRfkUpcC1pYuRSidZ3cqdCZg/hSroVmk=;
        b=xp7w81/HcKGr6AkcZ0NPWLrSaMy4em6tA16DRyZDyCoK4iK4hZmFtiZeOi0hbEeJ4JV0Im
        oIingQYV0eMXi6Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C7381139FF;
        Thu, 29 Jun 2023 13:18:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6reCL5CEnWRzcwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 29 Jun 2023 13:18:08 +0000
Message-ID: <90726a74-69db-3f8e-819d-3a1a10e98992@suse.de>
Date:   Thu, 29 Jun 2023 15:18:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 06/12] arch: Declare screen_info in <asm/screen_info.h>
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
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, guoren <guoren@kernel.org>,
        Brian Cain <bcain@quicinc.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>
References: <20230629121952.10559-1-tzimmermann@suse.de>
 <20230629121952.10559-7-tzimmermann@suse.de>
 <b31f42c1-4283-4793-b448-f7b9326be5d4@app.fastmail.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <b31f42c1-4283-4793-b448-f7b9326be5d4@app.fastmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------lHNoVt04HU1vaNtq3nK0adnX"
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
--------------lHNoVt04HU1vaNtq3nK0adnX
Content-Type: multipart/mixed; boundary="------------NaZYgX4ZbucliJsCgNaPg0G7";
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
 Linux-Arch <linux-arch@vger.kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 guoren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Dinh Nguyen <dinguyen@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "David S . Miller" <davem@davemloft.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Kees Cook <keescook@chromium.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Ard Biesheuvel <ardb@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>,
 Juerg Haefliger <juerg.haefliger@canonical.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Linus Walleij <linus.walleij@linaro.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Mike Rapoport <rppt@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Zi Yan <ziy@nvidia.com>
Message-ID: <90726a74-69db-3f8e-819d-3a1a10e98992@suse.de>
Subject: Re: [PATCH 06/12] arch: Declare screen_info in <asm/screen_info.h>
References: <20230629121952.10559-1-tzimmermann@suse.de>
 <20230629121952.10559-7-tzimmermann@suse.de>
 <b31f42c1-4283-4793-b448-f7b9326be5d4@app.fastmail.com>
In-Reply-To: <b31f42c1-4283-4793-b448-f7b9326be5d4@app.fastmail.com>

--------------NaZYgX4ZbucliJsCgNaPg0G7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMjkuMDYuMjMgdW0gMTU6MDMgc2NocmllYiBBcm5kIEJlcmdtYW5uOg0KPiBP
biBUaHUsIEp1biAyOSwgMjAyMywgYXQgMTM6NDUsIFRob21hcyBaaW1tZXJtYW5uIHdyb3Rl
Og0KPiANCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2FzbS1nZW5lcmljL3NjcmVlbl9pbmZv
LmgNCj4+IGIvaW5jbHVkZS9hc20tZ2VuZXJpYy9zY3JlZW5faW5mby5oDQo+PiBuZXcgZmls
ZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMDAwMC4uNmZkMGU1MGZhYmZjZA0K
Pj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvaW5jbHVkZS9hc20tZ2VuZXJpYy9zY3JlZW5f
aW5mby5oDQo+PiBAQCAtMCwwICsxLDEyIEBADQo+PiArLyogU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IEdQTC0yLjAgKi8NCj4+ICsNCj4+ICsjaWZuZGVmIF9BU01fR0VORVJJQ19TQ1JF
RU5fSU5GT19IDQo+PiArI2RlZmluZSBfQVNNX0dFTkVSSUNfU0NSRUVOX0lORk9fSA0KPj4g
Kw0KPj4gKyNpbmNsdWRlIDx1YXBpL2xpbnV4L3NjcmVlbl9pbmZvLmg+DQo+PiArDQo+PiAr
I2lmIGRlZmluZWQoQ09ORklHX0FSQ0hfSEFTX1NDUkVFTl9JTkZPKQ0KPj4gK2V4dGVybiBz
dHJ1Y3Qgc2NyZWVuX2luZm8gc2NyZWVuX2luZm87DQo+PiArI2VuZGlmDQo+PiArDQo+PiAr
I2VuZGlmIC8qIF9BU01fR0VORVJJQ19TQ1JFRU5fSU5GT19IICovDQo+PiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9saW51eC9zY3JlZW5faW5mby5oIGIvaW5jbHVkZS9saW51eC9zY3JlZW5f
aW5mby5oDQo+PiBpbmRleCBlYWI3MDgxMzkyZDUwLi5jNzY0YjlhNTFjMjRiIDEwMDY0NA0K
Pj4gLS0tIGEvaW5jbHVkZS9saW51eC9zY3JlZW5faW5mby5oDQo+PiArKysgYi9pbmNsdWRl
L2xpbnV4L3NjcmVlbl9pbmZvLmgNCj4+IEBAIC00LDYgKzQsNiBAQA0KPj4NCj4+ICAgI2lu
Y2x1ZGUgPHVhcGkvbGludXgvc2NyZWVuX2luZm8uaD4NCj4+DQo+PiAtZXh0ZXJuIHN0cnVj
dCBzY3JlZW5faW5mbyBzY3JlZW5faW5mbzsNCj4+ICsjaW5jbHVkZSA8YXNtL3NjcmVlbl9p
bmZvLmg+DQo+Pg0KPiANCj4gV2hhdCBpcyB0aGUgcHVycG9zZSBvZiBhZGRpbmcgYSBmaWxl
IGluIGFzbS1nZW5lcmljPyBJZiBhbGwNCj4gYXJjaGl0ZWN0dXJlcyB1c2UgdGhlIHNhbWUg
Z2VuZXJpYyBmaWxlLCBJJ2QganVzdCBsZWF2ZSB0aGUNCj4gZGVjbGFyYXRpb24gaW4gaW5j
bHVkZS9saW51eC8uIEkgd291bGRuJ3QgYm90aGVyIGFkZGluZyB0aGUNCg0KVGhhdCBhcHBl
YXJzIGEgYml0ICd1bi1jbGVhbicgZm9yIHNvbWV0aGluZyB0aGF0IGlzIGRlZmluZWQgaW4g
DQphcmNoaXRlY3R1cmU/IEJ1dCBPSywgSSB3b3VsZCBub3Qgb2JqZWN0Lg0KDQo+ICNpZmRl
ZiBlaXRoZXIsIGJ1dCBJIGNhbiBzZWUgaG93IHRoYXQgaGVscHMgdHVybiBhIGxpbmsNCj4g
ZXJyb3IgaW50byBhbiBlYXJsaWVyIGNvbXBpbGUgZXJyb3IuDQoNClllcywgdGhhdCdzIGlu
dGVudGlvbmFsLiBJZiB0aGVyZSdzIGEgS2NvbmZpZyB0b2tlbiBhbnl3YXksIHdlIGNhbiBh
bHNvIA0KZmFpbCBlYXJseSBkdXJpbmcgdGhlIGJ1aWxkLg0KDQpCZXN0IHJlZ2FyZHMNClRo
b21hcw0KDQo+IA0KPiAgICAgICAgQXJuZA0KDQotLSANClRob21hcyBaaW1tZXJtYW5uDQpH
cmFwaGljcyBEcml2ZXIgRGV2ZWxvcGVyDQpTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJt
YW55IEdtYkgNCkZyYW5rZW5zdHJhc3NlIDE0NiwgOTA0NjEgTnVlcm5iZXJnLCBHZXJtYW55
DQpHRjogSXZvIFRvdGV2LCBBbmRyZXcgTXllcnMsIEFuZHJldyBNY0RvbmFsZCwgQm91ZGll
biBNb2VybWFuDQpIUkIgMzY4MDkgKEFHIE51ZXJuYmVyZykNCg==

--------------NaZYgX4ZbucliJsCgNaPg0G7--

--------------lHNoVt04HU1vaNtq3nK0adnX
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmSdhI8FAwAAAAAACgkQlh/E3EQov+C6
/A/9E2UeLuAYO4oVzr7MYxtHJqgMeXKL3iCmAlD5a1SYNi1ixD68cwakP+lI9m4szzDGyNU/sRYL
Ce3i8WGXgRm991Ydm+ztZ8FO/ph9XOVhq7RFKwEYNy70l+7R56mDOd1ciNpH3MLjEfhoBJ5Xj0cD
rPf/74n/ptJpdYGsFRJSqo+xj78uWljJdj9YQ6bpUNhOIFAJn+a91kvcreTWoVwBfaXlWevy3dHR
lAFUpk+Ji1uldEboHSHzFB3V6FQ7odxZ/oW0ykURjjf2TyqrA4MwLtjZQYJqSr6i0cN1Qfn/IR1o
CHZFJKzcQXgF+jqdXdEmgS3pDi+jmR7paLHGwX0pdlcczcjPuAJ9b0MqjQ5De1mJ1qNTKZCMUHrm
n6BW6VGyUn4n7x/hieov6MXbqJkEXu9dAJgzNR9SQ/5Dszfwn8IJOGS3plNsPJSBYA1ZRAGmv5mv
VtscxfEkzLP1f5IM+ukfQ4lfSC+P9B3jbsa6DqQfcr1IBMQiJkbK6XKI9TQwLqxfWlgkdUfjgp4d
lDwmJfyb7JLxdMktscgr1rlA1KE/jlHX9wxTazYoUnY5uBtdeYco9NNe2fhvRv+c4mfJknGVZ/dR
F72VPBGenSKLgGoPamSowIKZJ/CpjEecYs7IcjmIoSLJ01STOBrZDRjz8iMNHR7pdZRLjuUSHY+B
wjM=
=ZHT8
-----END PGP SIGNATURE-----

--------------lHNoVt04HU1vaNtq3nK0adnX--
