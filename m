Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AB6747F5B
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jul 2023 10:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbjGEIT1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jul 2023 04:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbjGEITI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jul 2023 04:19:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281931FCA;
        Wed,  5 Jul 2023 01:18:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 210151F889;
        Wed,  5 Jul 2023 08:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688545100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W4UNbanusOFxqm7hkNbMAuWfI8njzbZ+1xH+95ErApk=;
        b=f1m05wOooggnusYApEllJA4DHXKKKu62i1rkKSNolG6RSiDRMKyS6d2VnsKHmZ8xzEctgP
        2uFR9SUawf/L7AX58ys1K0ADYPqUxnoHpg1XHgDcVjhPphPABiv3BNAKFSe9wj6pbNGgEY
        29iqc7Q/KqHfbr7HBz8cCkvPeICaCO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688545100;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W4UNbanusOFxqm7hkNbMAuWfI8njzbZ+1xH+95ErApk=;
        b=gtb/O4Zal0aHIFkUGIjHzs3Xs2V7RNCILA5sbQaaw7ZE4XgZbEe5tDa00OtkRXs35FPUwp
        QCeM4ulI7ec97LAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7965C13460;
        Wed,  5 Jul 2023 08:18:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +47LHEsnpWRgSAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 05 Jul 2023 08:18:19 +0000
Message-ID: <150c0fa2-bff2-0644-d6e5-c4dab7f79048@suse.de>
Date:   Wed, 5 Jul 2023 10:18:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 07/12] arch/x86: Declare edid_info in <asm/screen_info.h>
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Helge Deller <deller@gmx.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@gmail.com>
Cc:     linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mips@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-hexagon@vger.kernel.org, linux-staging@lists.linux.dev,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Borislav Petkov <bp@alien8.de>, loongarch@lists.linux.dev,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        linux-alpha@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org
References: <20230629121952.10559-1-tzimmermann@suse.de>
 <20230629121952.10559-8-tzimmermann@suse.de>
 <80e3a583-805e-4e8f-a67b-ebe2e4b9a7e5@app.fastmail.com>
 <d3de124c-6aa8-e930-e238-7bd6dd7929a6@suse.de>
 <0dbbdfc4-0e91-4be4-9ca0-d8ba6f18453d@app.fastmail.com>
 <ef7b3899-7d18-8018-47fa-aac0efaa61f4@suse.de>
 <dd5aa01e-afad-48d2-bf4c-4a58b74f1644@app.fastmail.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <dd5aa01e-afad-48d2-bf4c-4a58b74f1644@app.fastmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------2k3MbKSxf2z9hgV165j2f9MP"
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
--------------2k3MbKSxf2z9hgV165j2f9MP
Content-Type: multipart/mixed; boundary="------------9nOsvmrIChEQyu9JM4jWfbbm";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Arnd Bergmann <arnd@arndb.de>, Helge Deller <deller@gmx.de>,
 Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@gmail.com>
Cc: linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-riscv@lists.infradead.org, Ard Biesheuvel <ardb@kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-hexagon@vger.kernel.org,
 linux-staging@lists.linux.dev,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Sami Tolvanen <samitolvanen@google.com>,
 Kees Cook <keescook@chromium.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Borislav Petkov <bp@alien8.de>,
 loongarch@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Juerg Haefliger
 <juerg.haefliger@canonical.com>, linux-alpha@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Message-ID: <150c0fa2-bff2-0644-d6e5-c4dab7f79048@suse.de>
Subject: Re: [PATCH 07/12] arch/x86: Declare edid_info in <asm/screen_info.h>
References: <20230629121952.10559-1-tzimmermann@suse.de>
 <20230629121952.10559-8-tzimmermann@suse.de>
 <80e3a583-805e-4e8f-a67b-ebe2e4b9a7e5@app.fastmail.com>
 <d3de124c-6aa8-e930-e238-7bd6dd7929a6@suse.de>
 <0dbbdfc4-0e91-4be4-9ca0-d8ba6f18453d@app.fastmail.com>
 <ef7b3899-7d18-8018-47fa-aac0efaa61f4@suse.de>
 <dd5aa01e-afad-48d2-bf4c-4a58b74f1644@app.fastmail.com>
In-Reply-To: <dd5aa01e-afad-48d2-bf4c-4a58b74f1644@app.fastmail.com>

--------------9nOsvmrIChEQyu9JM4jWfbbm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgQXJuZA0KDQpBbSAzMC4wNi4yMyB1bSAxMzo1MyBzY2hyaWViIEFybmQgQmVyZ21hbm46
DQo+IE9uIEZyaSwgSnVuIDMwLCAyMDIzLCBhdCAwOTo0NiwgVGhvbWFzIFppbW1lcm1hbm4g
d3JvdGU6DQo+PiBBbSAyOS4wNi4yMyB1bSAxNToyMSBzY2hyaWViIEFybmQgQmVyZ21hbm46
DQo+Pj4gT24gVGh1LCBKdW4gMjksIDIwMjMsIGF0IDE1OjAxLCBUaG9tYXMgWmltbWVybWFu
biB3cm90ZToNCj4+Pj4gQW0gMjkuMDYuMjMgdW0gMTQ6MzUgc2NocmllYiBBcm5kIEJlcmdt
YW5uOg0KPj4+Pj4gT24gVGh1LCBKdW4gMjksIDIwMjMsIGF0IDEzOjQ1LCBUaG9tYXMgWmlt
bWVybWFubiB3cm90ZToNCj4+DQo+Pj4+DQo+Pj4+IEZJUk1XQVJFX0VESUQgaXMgYSB1c2Vy
LXNlbGVjdGFibGUgZmVhdHVyZSwgd2hpbGUgQVJDSF9IQVNfRURJRF9JTkZPDQo+Pj4+IGFu
bm91bmNlcyBhbiBhcmNoaXRlY3R1cmUgZmVhdHVyZS4gVGhleSBkbyBkaWZmZXJlbnQgdGhp
bmdzLg0KPj4+DQo+Pj4gSSBzdGlsbCBoYXZlIHRyb3VibGUgc2VlaW5nIHRoZSBkaWZmZXJl
bmNlLg0KPj4NCj4+IFRoZSBpZGVhIGhlcmUgaXMgdGhhdCBBUkNIX0hBU18gc2lnbmFscyB0
aGUgYXJjaGl0ZWN0dXJlJ3Mgc3VwcG9ydCBmb3INCj4+IHRoZSBmZWF0dXJlLiAgRHJpdmVy
cyBzZXQgJ2RlcGVuZHMgb24nIGluIHRoZWlyIEtjb25maWcuDQo+Pg0KPj4gQW5vdGhlciBL
Y29uZmlnIHRva2VuLCBWSURFT19TQ1JFRU5fSU5GTyBvciBGSVJNV0FSRV9FRElELCB3b3Vs
ZCB0aGVuDQo+PiBhY3R1YWxseSBlbmFibGUgdGhlIGZlYXR1cmUuICBEcml2ZXJzIHNlbGVj
dCBWSURFT19TQ1JFRU5fSU5GTyBvcg0KPj4gRklSTVdBUkVfRURJRCBhbmQgdGhlIGFyY2hp
dGVjdHVyZXMgY29udGFpbnMgY29kZSBsaWtlDQo+IA0KPiBGYWlyIGVub3VnaC4gSW4gdGhh
dCBjYXNlLCBJIGd1ZXNzIEZJUk1XQVJFX0VESUQgd2lsbCBqdXN0IGRlcGVuZCBvbg0KPiBB
UkNIX0hBU19FRElEX0lORk8sIG9yIHBvc3NpYmx5ICJkZXBlbmRzIG9uIEZJUk1XQVJFX0VE
SUQgfHwgRUZJIg0KPiBhZnRlciBpdCBzdGFydHMgY2FsbGluZyBpbnRvIGFuIEVGSSBzcGVj
aWZpYyBmdW5jdGlvbiwgcmlnaHQ/DQo+IA0KPj4gI2lmZGVmIFZJREVPX1NDUkVFTl9JTkZP
DQo+PiBzdHJ1Y3Qgc2NyZWVuX2luZm8gc2NyZWVuX2luZm8gPSB7DQo+PiAJLyogc2V0IHZh
bHVlcyBoZXJlICovDQo+PiB9DQo+PiAjZW5kaWYNCj4+DQo+PiBUaGlzIGFsbG93cyB1cyB0
byBkaXNhYmxlIGNvZGUgdGhhdCByZXF1aXJlcyBzY3JlZW5faW5mby9lZGlkX2luZm8sIGJ1
dA0KPj4gYWxzbyBkaXNhYmxlIHNjcmVlbl9pbmZvL2VkaWRfaW5mbyB1bmxlc3Mgc3VjaCBj
b2RlIGhhcyBiZWVuIGVuYWJsZWQgaW4NCj4+IHRoZSBrZXJuZWwgY29uZmlnLg0KPj4NCj4+
IFNvbWUgYXJjaGl0ZWN0dXJlcyBjdXJyZW50bHkgbWltaWMgdGhpcyBieSBndWFyZGluZyBz
Y3JlZW5faW5mbyB3aXRoDQo+PiBpZmRlZiBDT05GSUdfVlQgb3Igc2ltaWxhci4gSSdkIGxp
a2UgdG8gbWFrZSB0aGlzIG1vcmUgZmxleGlibGUuIFRoZQ0KPj4gY29zdCBvZiBhIGZldyBt
b3JlIGludGVybmFsIEtjb25maWcgdG9rZW5zIHNlZW1zIG5lZ2xpZ2libGUuDQo+IA0KPiBJ
IGRlZmluaXRlbHkgZ2V0IGl0IGZvciB0aGUgc2NyZWVuX2luZm8sIHdoaWNoIG5lZWRzIHRo
ZSBjb21wbGV4aXR5Lg0KPiBGb3IgQVJDSEFSQ0hfSEFTX0VESURfSU5GTyBJIHdvdWxkIGhv
cGUgdGhhdCBpdCdzIG5ldmVyIHNlbGVjdGVkIGJ5DQo+IGFueXRoaW5nIG90aGVyIHRoYW4g
eDg2LCBzbyBJIHdvdWxkIHN0aWxsIGdvIHdpdGgganVzdCBhIGRlcGVuZGVuY3kNCj4gb24g
eDg2IGZvciBzaW1wbGljaXR5LCBidXQgSSBkb24ndCBtaW5kIGhhdmluZyB0aGUgZXh0cmEg
c3ltYm9sIGlmIHRoYXQNCj4ga2VlcHMgaXQgbW9yZSBjb25zaXN0ZW50IHdpdGggaG93IHRo
ZSBzY3JlZW5faW5mbyBpcyBoYW5kbGVkLg0KDQpXZWxsLCBJJ2QgbGlrZSB0byBhZGQgZWRp
ZF9pbmZvIHRvIHBsYXRmb3JtcyB3aXRoIEVGSS4gV2hhdCB3b3VsZCBiZSANCmFybS9hcm02
NCBhbmQgbG9vbmdhcmNoLCBJIGd1ZXNzLiBTZWUgYmVsb3cgZm9yIHRoZSBmdXR1cmUgcGxh
bnMuDQoNCj4gDQo+Pj4gSSBzdXBwb3NlIHlvdSBjb3VsZCB1c2UgRklSTVdBUkVfRURJRCBv
biBFRkkgb3IgT0Ygc3lzdGVtcyB3aXRob3V0DQo+Pj4gdGhlIG5lZWQgZm9yIGEgZ2xvYmFs
IGVkaWRfaW5mbyBzdHJ1Y3R1cmUsIGJ1dCB0aGF0IHdvdWxkIG5vdA0KPj4+IHNoYXJlIGFu
eSBjb2RlIHdpdGggdGhlIGN1cnJlbnQgZmJfZmlybXdhcmVfZWRpZCgpIGZ1bmN0aW9uLg0K
Pj4NCj4+IFRoZSBjdXJyZW50IGNvZGUgaXMgYnVpbGQgb24gdG9wIG9mIHNjcmVlbl9pbmZv
IGFuZCBlZGlkX2luZm8uIEknZA0KPj4gcHJlZmVyYWJseSBub3QgcmVwbGFjZSB0aGF0LCBp
ZiBwb3NzaWJsZS4NCj4gDQo+IE9uZSB3YXkgSSBjb3VsZCBpbWFnaW5lIHRoaXMgbG9va2lu
ZyBpbiB0aGUgZW5kIHdvdWxkIGJlDQo+IHNvbWV0aGluZyBsaWtlDQo+IA0KPiBzdHJ1Y3Qg
c2NyZWVuX2luZm8gKmZiX3NjcmVlbl9pbmZvKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gew0K
PiAgICAgICAgc3RydWN0IHNjcmVlbl9pbmZvICpzaSA9IE5VTEw7DQo+IA0KPiAgICAgICAg
aWYgKElTX0VOQUJMRUQoQ09ORklHX0VGSSkpDQo+ICAgICAgICAgICAgICBzaSA9IGVmaV9n
ZXRfc2NyZWVuX2luZm8oZGV2KTsNCj4gDQo+ICAgICAgICBpZiAoSVNfRU5BQkxFRChDT05G
SUdfQVJDSF9IQVNfU0NSRUVOX0lORk8pICYmICFzaSkNCj4gICAgICAgICAgICAgIHNpID0g
c2NyZWVuX2luZm87DQo+IA0KPiAgICAgICAgcmV0dXJuIHNpOw0KPiB9DQo+IA0KPiBjb3Jy
ZXNwb25kaW5nIHRvIGZiX2Zpcm13YXJlX2VkaWQoKS4gV2l0aCB0aGlzLCBhbnkgZHJpdmVy
DQo+IHRoYXQgd2FudHMgdG8gYWNjZXNzIHNjcmVlbl9pbmZvIHdvdWxkIGNhbGwgdGhpcyBm
dW5jdGlvbg0KPiBpbnN0ZWFkIG9mIHVzaW5nIHRoZSBnbG9iYWwgcG9pbnRlciwgcGx1cyBl
aXRoZXIgTlVMTCBwb2ludGVyDQo+IGNoZWNrIG9yIGEgQ09ORklHX0FSQ0hfSEFTX1NDUkVF
Tl9JTkZPIGRlcGVuZGVuY3kuDQo+IA0KPiBUaGlzIHdheSB3ZSBjb3VsZCBjb21wbGV0ZWx5
IGVsaW1pbmF0ZSB0aGUgZ2xvYmFsIHNjcmVlbl9pbmZvDQo+IG9uIGFybTY0LCByaXNjdiwg
YW5kIGxvb25nYXJjaCBidXQgc3RpbGwgdXNlIHRoZSBlZmkgYW5kDQo+IGh5cGVydiBmcmFt
ZWJ1ZmZlci9kcm0gZHJpdmVycy4NCg0KSWYgcG9zc2libGUsIEknZCBsaWtlIHRvIHJlbW92
ZSBnbG9iYWwgc2NyZWVuX2luZm8gYW5kIGVkaWRfaW5mbyANCmVudGlyZWx5IGZyb20gZmJk
ZXYgYW5kIHRoZSB2YXJpb3VzIGNvbnNvbGVzLg0KDQpXZSBjdXJyZW50bHkgdXNlIHNjcmVl
bl9pbmZvIHRvIHNldCB1cCB0aGUgZ2VuZXJpYyBmcmFtZWJ1ZmZlciBkZXZpY2UgaW4gDQpk
cml2ZXJzL2Zpcm13YXJlL3N5c2ZiLmMuIEknZCBsaWtlIHRvIHVzZSBlZGlkX2luZm8gaGVy
ZSBhcyB3ZWxsLCBzbyANCnRoYXQgdGhlIGdlbmVyaWMgZ3JhcGhpY3MgZHJpdmVycyBjYW4g
Z2V0IEVESUQgaW5mb3JtYXRpb24uDQoNCkZvciB0aGUgZmV3IGZiZGV2IGRyaXZlcnMgYW5k
IGNvbnNvbGVzIHRoYXQgcmVxdWlyZSB0aGUgZ2xvYmFsIA0Kc2NyZWVuX2luZm8vZWRpZF9p
bmZvLCBJJ2QgcmF0aGVyIHByb3ZpZGUgbG9va3VwIGZ1bmN0aW9ucyBpbiBzeXNmYiANCihl
LmcuLCBzeXNmYl9nZXRfc2NyZWVuX2luZm8oKSwgc3lzZmJfZ2V0X2VkaWRfaW5mbygpKS4g
VGhlIGdsb2JhbCANCnNjcmVlbl9pbmZvL2VkaWRfaW5mbyBzdGF0ZSB3b3VsZCB0aGVuIGJl
Y29tZSBhbiBpbnRlcm5hbCBhcnRpZmFjdCBvZiANCnRoZSBzeXNmYiBjb2RlLg0KDQpIb3Bl
ZnVsbHkgdGhhdCBleHBsYWlucyBzb21lIG9mIHRoZSBkZWNpc2lvbnMgbWFkZSBpbiB0aGlz
IHBhdGNoc2V0Lg0KDQpCZXN0IHJlZ2FyZHMNClRob21hcw0KDQo+IA0KPiAgICAgIEFybmQN
Cg0KLS0gDQpUaG9tYXMgWmltbWVybWFubg0KR3JhcGhpY3MgRHJpdmVyIERldmVsb3Blcg0K
U1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJIDQpGcmFua2Vuc3RyYXNzZSAx
NDYsIDkwNDYxIE51ZXJuYmVyZywgR2VybWFueQ0KR0Y6IEl2byBUb3RldiwgQW5kcmV3IE15
ZXJzLCBBbmRyZXcgTWNEb25hbGQsIEJvdWRpZW4gTW9lcm1hbg0KSFJCIDM2ODA5IChBRyBO
dWVybmJlcmcpDQo=

--------------9nOsvmrIChEQyu9JM4jWfbbm--

--------------2k3MbKSxf2z9hgV165j2f9MP
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmSlJ0oFAwAAAAAACgkQlh/E3EQov+Ar
GBAAo4esabhlv1pv1eUJEjgRW+ns5YBTZSxnTNM1zBWU8t6X1q991ybNmrQv/epD+zuQeRoa97MN
l1HgNdpESzfLQk9/SjPewRDC6ITHHLR2uBCxbrmdLnsMYYJ43lUFSFsusi1FLyQJV9RvIl7BlRYj
S679/kx2vxzLto8BoxEU+AB1/zdCvICRrITF/2cflnGB0LPhKVU1QmpMEsvOCO2nnlkGZxWl1pIr
NP0h5xgG+8DFgyWonyPJ93PMYja7LMpoPjTd9K2ErHriOEmFk++HFJTjIswsQz73XpaJBUqaJjjj
i1WduG2dQFEWI0fOtDA/O0fV4AcZgGOpv6bk2G7/E1rRZtqPdq5DpNU/ep2+GesFjOy3f0voheUI
I42NvvEBLh4PcIn2ScZTH8+O0KnIgRTgDgHH8J2rMcYqCIWJ1vi/gIK/DWc91nOyurlQ82ChZtcg
Ps4ryHUs4XcXxARdFg+dbGtAEJX9w4WK+EpdwxXqCttR5AXouPgCC4ndmaJP9xOpOTBEz/llBrrd
dR43H4TayV0zDNaWhCANKXA5yl14eFj0D7eursCdXweahKOEuAAfYKMxDLjXIV9aOy435JsF/3OG
FeYNx3StYvNqRpP9PV0q3WENW7amHTXQ9yElDbo6j22jThA7DlmTln/RUQnSkN4zcrwG/w4mP1Yl
ZK4=
=mbrs
-----END PGP SIGNATURE-----

--------------2k3MbKSxf2z9hgV165j2f9MP--
