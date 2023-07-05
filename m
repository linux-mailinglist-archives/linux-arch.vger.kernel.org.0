Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDD7747ED7
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jul 2023 10:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjGEICP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jul 2023 04:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjGEICO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jul 2023 04:02:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12E2E5;
        Wed,  5 Jul 2023 01:02:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 560861FD7F;
        Wed,  5 Jul 2023 08:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688544130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1537KsrqgtTf3qMTeFjDvl3IIymI/B25iZrixbbnSNE=;
        b=IwehquhGrrxeA07eNql4jR23niZ/iiorDNs/g1jBq6KYVhLc7Q5aDspthVNETuks8N2182
        TFa90v6mZYTq3TWYosoHRyG9pnWv2/s+/dMYyiftL4a3LbOfqAMl6Khxe8jIkwu2wfFtpK
        V/FrYOxN1QnZgnOGjB3hNVLqYUkXl4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688544130;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1537KsrqgtTf3qMTeFjDvl3IIymI/B25iZrixbbnSNE=;
        b=ZGEq7iIM11LfGRt0DlOIzHPVm6XPL8FyNIYZ7x//Nfra+mVnCizN8ZPGkQyV/lCwixo7fv
        oz/TdXngu4nAhFBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C9EA13460;
        Wed,  5 Jul 2023 08:02:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WfgTBoEjpWRJPwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 05 Jul 2023 08:02:09 +0000
Message-ID: <96a9b754-ddf1-aa6b-fb25-16cb09a22bf2@suse.de>
Date:   Wed, 5 Jul 2023 10:02:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [06/12] arch: Declare screen_info in <asm/screen_info.h>
Content-Language: en-US
To:     Sui Jingfeng <suijingfeng@loongson.cn>, arnd@arndb.de,
        deller@gmx.de, daniel@ffwll.ch, airlied@gmail.com
Cc:     linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-ia64@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
        Rich Felker <dalias@libc.org>, Guo Ren <guoren@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
        linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, linux-arch@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-hexagon@vger.kernel.org, linux-staging@lists.linux.dev,
        Russell King <linux@armlinux.org.uk>,
        linux-csky@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Matt Turner <mattst88@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        loongarch@lists.linux.dev,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>, Zi Yan <ziy@nvidia.com>,
        linux-arm-kernel@lists.infradead.org,
        Brian Cain <bcain@quicinc.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-kernel@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        linux-alpha@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>, x86@kernel.org
References: <20230629121952.10559-7-tzimmermann@suse.de>
 <02a6f36c-521f-4ff0-a0bf-1f8781c853e3@loongson.cn>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <02a6f36c-521f-4ff0-a0bf-1f8781c853e3@loongson.cn>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------mvTV0S2N0xU0yyoORtj2zLF6"
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
--------------mvTV0S2N0xU0yyoORtj2zLF6
Content-Type: multipart/mixed; boundary="------------b2X5ouefEi1LmiskbVc9m302";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Sui Jingfeng <suijingfeng@loongson.cn>, arnd@arndb.de, deller@gmx.de,
 daniel@ffwll.ch, airlied@gmail.com
Cc: linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-ia64@vger.kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
 Rich Felker <dalias@libc.org>, Guo Ren <guoren@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 Will Deacon <will@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 linux-arch@vger.kernel.org,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-hexagon@vger.kernel.org,
 linux-staging@lists.linux.dev, Russell King <linux@armlinux.org.uk>,
 linux-csky@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Sami Tolvanen <samitolvanen@google.com>,
 Juerg Haefliger <juerg.haefliger@canonical.com>,
 Matt Turner <mattst88@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Albert Ou <aou@eecs.berkeley.edu>, Kees Cook <keescook@chromium.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Chris Zankel <chris@zankel.net>,
 Frederic Weisbecker <frederic@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Niklas Schnelle
 <schnelle@linux.ibm.com>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 loongarch@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>,
 Thomas Gleixner <tglx@linutronix.de>, Zi Yan <ziy@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, Brian Cain <bcain@quicinc.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 linux-kernel@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, linux-alpha@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>,
 x86@kernel.org
Message-ID: <96a9b754-ddf1-aa6b-fb25-16cb09a22bf2@suse.de>
Subject: Re: [06/12] arch: Declare screen_info in <asm/screen_info.h>
References: <20230629121952.10559-7-tzimmermann@suse.de>
 <02a6f36c-521f-4ff0-a0bf-1f8781c853e3@loongson.cn>
In-Reply-To: <02a6f36c-521f-4ff0-a0bf-1f8781c853e3@loongson.cn>

--------------b2X5ouefEi1LmiskbVc9m302
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMDUuMDcuMjMgdW0gMDM6MjEgc2NocmllYiBTdWkgSmluZ2Zlbmc6DQo+IEhp
LCBUaG9tYXMNCj4gDQo+IA0KPiBJIGxvdmUgeW91ciBwYXRjaCwgeWV0IGFmdGVyIGFwcGxp
ZWQgeW91ciBwYXRjaCwgdGhlIGxpbnV4IGtlcm5lbCBmYWlsIA0KPiB0byBjb21waWxlIG9u
IG15IExvb25nQXJjaCBtYWNoaW5lLg0KDQpzY3JlZW5faW5mbyBpcyBtaXNzaW5nLiBJIHRo
aW5rIHRoaXMgc2hvdWxkIGJlIHNvbHZlZCB3aXRoIHlvdXIgdXBkYXRlIA0KdG8gcGF0Y2gg
MS4NCg0KQmVzdCByZWdhcmRzDQpUaG9tYXMNCg0KPiANCj4gDQo+IGBgYA0KPiANCj4gIMKg
IENDwqDCoMKgwqDCoCBhcmNoL2xvb25nYXJjaC9rZXJuZWwvZWZpLm8NCj4gYXJjaC9sb29u
Z2FyY2gva2VybmVsL2VmaS5jOiBJbiBmdW5jdGlvbiDigJhpbml0X3NjcmVlbl9pbmZv4oCZ
Og0KPiBhcmNoL2xvb25nYXJjaC9rZXJuZWwvZWZpLmM6Nzc6NTQ6IGVycm9yOiBpbnZhbGlk
IGFwcGxpY2F0aW9uIG9mIA0KPiDigJhzaXplb2bigJkgdG8gaW5jb21wbGV0ZSB0eXBlIOKA
mHN0cnVjdCBzY3JlZW5faW5mb+KAmQ0KPiAgwqDCoCA3NyB8wqDCoMKgwqDCoMKgwqDCoCBz
aSA9IGVhcmx5X21lbXJlbWFwKHNjcmVlbl9pbmZvX3RhYmxlLCBzaXplb2YoKnNpKSk7DQo+
ICDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIF4NCj4gYXJjaC9sb29uZ2FyY2gva2VybmVsL2VmaS5jOjgyOjk6IGVy
cm9yOiDigJhzY3JlZW5faW5mb+KAmSB1bmRlY2xhcmVkIChmaXJzdCANCj4gdXNlIGluIHRo
aXMgZnVuY3Rpb24pDQo+ICDCoMKgIDgyIHzCoMKgwqDCoMKgwqDCoMKgIHNjcmVlbl9pbmZv
ID0gKnNpOw0KPiAgwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoCBefn5+fn5+fn5+fg0K
PiBhcmNoL2xvb25nYXJjaC9rZXJuZWwvZWZpLmM6ODI6OTogbm90ZTogZWFjaCB1bmRlY2xh
cmVkIGlkZW50aWZpZXIgaXMgDQo+IHJlcG9ydGVkIG9ubHkgb25jZSBmb3IgZWFjaCBmdW5j
dGlvbiBpdCBhcHBlYXJzIGluDQo+IGFyY2gvbG9vbmdhcmNoL2tlcm5lbC9lZmkuYzo4Mjoy
MzogZXJyb3I6IGludmFsaWQgdXNlIG9mIHVuZGVmaW5lZCB0eXBlIA0KPiDigJhzdHJ1Y3Qg
c2NyZWVuX2luZm/igJkNCj4gIMKgwqAgODIgfMKgwqDCoMKgwqDCoMKgwqAgc2NyZWVuX2lu
Zm8gPSAqc2k7DQo+ICDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBeDQo+IGFyY2gvbG9vbmdhcmNoL2tlcm5lbC9lZmkuYzo4Mzoy
OTogZXJyb3I6IGludmFsaWQgYXBwbGljYXRpb24gb2YgDQo+IOKAmHNpemVvZuKAmSB0byBp
bmNvbXBsZXRlIHR5cGUg4oCYc3RydWN0IHNjcmVlbl9pbmZv4oCZDQo+ICDCoMKgIDgzIHzC
oMKgwqDCoMKgwqDCoMKgIG1lbXNldChzaSwgMCwgc2l6ZW9mKCpzaSkpOw0KPiAgwqDCoMKg
wqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgXg0KPiBhcmNoL2xvb25nYXJjaC9rZXJuZWwvZWZpLmM6ODQ6MzQ6IGVycm9y
OiBpbnZhbGlkIGFwcGxpY2F0aW9uIG9mIA0KPiDigJhzaXplb2bigJkgdG8gaW5jb21wbGV0
ZSB0eXBlIOKAmHN0cnVjdCBzY3JlZW5faW5mb+KAmQ0KPiAgwqDCoCA4NCB8wqDCoMKgwqDC
oMKgwqDCoCBlYXJseV9tZW11bm1hcChzaSwgc2l6ZW9mKCpzaSkpOw0KPiAgwqDCoMKgwqDC
oCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIF4NCj4gbWFrZVszXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1
aWxkOjI1MjogYXJjaC9sb29uZ2FyY2gva2VybmVsL2VmaS5vXSANCj4gRXJyb3IgMQ0KPiBt
YWtlWzNdOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLg0KPiBtYWtlWzJd
OiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6NDk0OiBhcmNoL2xvb25nYXJjaC9rZXJu
ZWxdIEVycm9yIDINCj4gbWFrZVsxXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjQ5
NDogYXJjaC9sb29uZ2FyY2hdIEVycm9yIDINCj4gbWFrZVsxXTogKioqIFdhaXRpbmcgZm9y
IHVuZmluaXNoZWQgam9icy4uLi4NCj4gbWFrZTogKioqIFtNYWtlZmlsZToyMDI2OiAuXSBF
cnJvciAyDQo+IA0KPiBgYGANCj4gDQo+IE9uIDIwMjMvNi8yOSAxOTo0NSwgVGhvbWFzIFpp
bW1lcm1hbm4gd3JvdGU6DQo+PiBUaGUgdmFyaWFibGUgc2NyZWVuX2luZm8gZG9lcyBub3Qg
ZXhpc3Qgb24gYWxsIGFyY2hpdGVjdHVyZXMuIERlY2xhcmUNCj4+IGl0IGluIDxhc20tZ2Vu
ZXJpYy9zY3JlZW5faW5mby5oPi4gQWxsIGFyY2hpdGVjdHVyZXMgdGhhdCBkbyBkZWNsYXJl
IGl0DQo+PiB3aWxsIHByb3ZpZGUgaXQgdmlhIDxhc20vc2NyZWVuX2luZm8uaD4uDQo+Pg0K
Pj4gQWRkIHRoZSBLY29uZmlnIHRva2VuIEFSQ0hfSEFTX1NDUkVFTl9JTkZPIHRvIGd1YXJk
IGFnYWluc3QgYWNjZXNzIG9uDQo+PiBhcmNoaXRlY3R1cmVzIHRoYXQgZG9uJ3QgcHJvdmlk
ZSBzY3JlZW5faW5mby4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgWmltbWVybWFu
biA8dHppbW1lcm1hbm5Ac3VzZS5kZT4NCj4+IENjOiBSaWNoYXJkIEhlbmRlcnNvbiA8cmlj
aGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4NCj4+IENjOiBJdmFuIEtva3NoYXlza3kgPGlu
a0BqdXJhc3NpYy5wYXJrLm1zdS5ydT4NCj4+IENjOiBNYXR0IFR1cm5lciA8bWF0dHN0ODhA
Z21haWwuY29tPg0KPj4gQ2M6IFJ1c3NlbGwgS2luZyA8bGludXhAYXJtbGludXgub3JnLnVr
Pg0KPj4gQ2M6IENhdGFsaW4gTWFyaW5hcyA8Y2F0YWxpbi5tYXJpbmFzQGFybS5jb20+DQo+
PiBDYzogV2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz4NCj4+IENjOiBHdW8gUmVuIDxn
dW9yZW5Aa2VybmVsLm9yZz4NCj4+IENjOiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNv
bT4NCj4+IENjOiBIdWFjYWkgQ2hlbiA8Y2hlbmh1YWNhaUBrZXJuZWwub3JnPg0KPj4gQ2M6
IFdBTkcgWHVlcnVpIDxrZXJuZWxAeGVuMG4ubmFtZT4NCj4+IENjOiBUaG9tYXMgQm9nZW5k
b2VyZmVyIDx0c2JvZ2VuZEBhbHBoYS5mcmFua2VuLmRlPg0KPj4gQ2M6IERpbmggTmd1eWVu
IDxkaW5ndXllbkBrZXJuZWwub3JnPg0KPj4gQ2M6IE1pY2hhZWwgRWxsZXJtYW4gPG1wZUBl
bGxlcm1hbi5pZC5hdT4NCj4+IENjOiBOaWNob2xhcyBQaWdnaW4gPG5waWdnaW5AZ21haWwu
Y29tPg0KPj4gQ2M6IENocmlzdG9waGUgTGVyb3kgPGNocmlzdG9waGUubGVyb3lAY3Nncm91
cC5ldT4NCj4+IENjOiBQYXVsIFdhbG1zbGV5IDxwYXVsLndhbG1zbGV5QHNpZml2ZS5jb20+
DQo+PiBDYzogUGFsbWVyIERhYmJlbHQgPHBhbG1lckBkYWJiZWx0LmNvbT4NCj4+IENjOiBB
bGJlcnQgT3UgPGFvdUBlZWNzLmJlcmtlbGV5LmVkdT4NCj4+IENjOiBZb3NoaW5vcmkgU2F0
byA8eXNhdG9AdXNlcnMuc291cmNlZm9yZ2UuanA+DQo+PiBDYzogUmljaCBGZWxrZXIgPGRh
bGlhc0BsaWJjLm9yZz4NCj4+IENjOiBKb2huIFBhdWwgQWRyaWFuIEdsYXViaXR6IDxnbGF1
Yml0ekBwaHlzaWsuZnUtYmVybGluLmRlPg0KPj4gQ2M6ICJEYXZpZCBTLiBNaWxsZXIiIDxk
YXZlbUBkYXZlbWxvZnQubmV0Pg0KPj4gQ2M6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51
dHJvbml4LmRlPg0KPj4gQ2M6IEluZ28gTW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPg0KPj4g
Q2M6IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPg0KPj4gQ2M6IERhdmUgSGFuc2Vu
IDxkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb20+DQo+PiBDYzogeDg2QGtlcm5lbC5vcmcN
Cj4+IENjOiAiSC4gUGV0ZXIgQW52aW4iIDxocGFAenl0b3IuY29tPg0KPj4gQ2M6IENocmlz
IFphbmtlbCA8Y2hyaXNAemFua2VsLm5ldD4NCj4+IENjOiBNYXggRmlsaXBwb3YgPGpjbXZi
a2JjQGdtYWlsLmNvbT4NCj4+IENjOiBIZWxnZSBEZWxsZXIgPGRlbGxlckBnbXguZGU+DQo+
PiBDYzogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCj4+IENjOiBLZWVzIENvb2sg
PGtlZXNjb29rQGNocm9taXVtLm9yZz4NCj4+IENjOiAiUGF1bCBFLiBNY0tlbm5leSIgPHBh
dWxtY2tAa2VybmVsLm9yZz4NCj4+IENjOiBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJh
ZGVhZC5vcmc+DQo+PiBDYzogRnJlZGVyaWMgV2Vpc2JlY2tlciA8ZnJlZGVyaWNAa2VybmVs
Lm9yZz4NCj4+IENjOiBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3Jn
Pg0KPj4gQ2M6IEFyZCBCaWVzaGV1dmVsIDxhcmRiQGtlcm5lbC5vcmc+DQo+PiBDYzogU2Ft
aSBUb2x2YW5lbiA8c2FtaXRvbHZhbmVuQGdvb2dsZS5jb20+DQo+PiBDYzogSnVlcmcgSGFl
ZmxpZ2VyIDxqdWVyZy5oYWVmbGlnZXJAY2Fub25pY2FsLmNvbT4NCj4+IENjOiBHZWVydCBV
eXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPj4gQ2M6IEFuc2h1bWFuIEto
YW5kdWFsIDxhbnNodW1hbi5raGFuZHVhbEBhcm0uY29tPg0KPj4gQ2M6IE5pa2xhcyBTY2hu
ZWxsZSA8c2NobmVsbGVAbGludXguaWJtLmNvbT4NCj4+IENjOiAiUnVzc2VsbCBLaW5nIChP
cmFjbGUpIiA8cm1rK2tlcm5lbEBhcm1saW51eC5vcmcudWs+DQo+PiBDYzogTGludXMgV2Fs
bGVpaiA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPg0KPj4gQ2M6IFNlYmFzdGlhbiBSZWlj
aGVsIDxzZWJhc3RpYW4ucmVpY2hlbEBjb2xsYWJvcmEuY29tPg0KPj4gQ2M6ICJNaWtlIFJh
cG9wb3J0IChJQk0pIiA8cnBwdEBrZXJuZWwub3JnPg0KPj4gQ2M6ICJLaXJpbGwgQS4gU2h1
dGVtb3YiIDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPg0KPj4gQ2M6IFppIFlh
biA8eml5QG52aWRpYS5jb20+DQo+PiBBY2tlZC1ieTogV0FORyBYdWVydWkgPGdpdEB4ZW4w
bi5uYW1lPiAjIGxvb25nYXJjaA0KPj4gLS0tDQo+PiDCoCBhcmNoL0tjb25maWfCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDYgKysrKysrDQo+PiDC
oCBhcmNoL2FscGhhL0tjb25maWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKg
IDEgKw0KPj4gwqAgYXJjaC9hcm0vS2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfMKgIDEgKw0KPj4gwqAgYXJjaC9hcm02NC9LY29uZmlnwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsNCj4+IMKgIGFyY2gvY3NreS9LY29uZmlnwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEgKw0KPj4gwqAgYXJjaC9oZXhh
Z29uL0tjb25maWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMSArDQo+PiDCoCBh
cmNoL2lhNjQvS2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAx
ICsNCj4+IMKgIGFyY2gvbG9vbmdhcmNoL0tjb25maWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoCAxICsNCj4+IMKgIGFyY2gvbWlwcy9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfMKgIDEgKw0KPj4gwqAgYXJjaC9uaW9zMi9LY29uZmlnwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsNCj4+IMKgIGFyY2gvcG93ZXJwYy9LY29u
ZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEgKw0KPj4gwqAgYXJjaC9yaXNj
di9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsNCj4+IMKg
IGFyY2gvc2gvS2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
wqAgMSArDQo+PiDCoCBhcmNoL3NwYXJjL0tjb25maWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfMKgIDEgKw0KPj4gwqAgYXJjaC94ODYvS2NvbmZpZ8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEgKw0KPj4gwqAgYXJjaC94dGVuc2EvS2NvbmZp
Z8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEgKw0KPj4gwqAgZHJpdmVycy92
aWRlby9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAzICsrKw0KPj4gwqAg
aW5jbHVkZS9hc20tZ2VuZXJpYy9LYnVpbGTCoMKgwqDCoMKgwqDCoCB8wqAgMSArDQo+PiDC
oCBpbmNsdWRlL2FzbS1nZW5lcmljL3NjcmVlbl9pbmZvLmggfCAxMiArKysrKysrKysrKysN
Cj4+IMKgIGluY2x1ZGUvbGludXgvc2NyZWVuX2luZm8uaMKgwqDCoMKgwqDCoCB8wqAgMiAr
LQ0KPj4gwqAgMjAgZmlsZXMgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPj4gwqAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvYXNtLWdlbmVyaWMvc2Ny
ZWVuX2luZm8uaA0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL0tjb25maWcgYi9hcmNoL0tj
b25maWcNCj4+IGluZGV4IDIwNWZkMjNlMGNhZGEuLjJmNTgyOTNmZDdiY2IgMTAwNjQ0DQo+
PiAtLS0gYS9hcmNoL0tjb25maWcNCj4+ICsrKyBiL2FyY2gvS2NvbmZpZw0KPj4gQEAgLTE0
NjYsNiArMTQ2NiwxMiBAQCBjb25maWcgQVJDSF9IQVNfTk9OTEVBRl9QTURfWU9VTkcNCj4+
IMKgwqDCoMKgwqDCoMKgIGFkZHJlc3MgdHJhbnNsYXRpb25zLiBQYWdlIHRhYmxlIHdhbGtl
cnMgdGhhdCBjbGVhciB0aGUgDQo+PiBhY2Nlc3NlZCBiaXQNCj4+IMKgwqDCoMKgwqDCoMKg
IG1heSB1c2UgdGhpcyBjYXBhYmlsaXR5IHRvIHJlZHVjZSB0aGVpciBzZWFyY2ggc3BhY2Uu
DQo+PiArY29uZmlnIEFSQ0hfSEFTX1NDUkVFTl9JTkZPDQo+PiArwqDCoMKgIGJvb2wNCj4+
ICvCoMKgwqAgaGVscA0KPj4gK8KgwqDCoMKgwqAgU2VsZWN0ZWQgYnkgYXJjaGl0ZWN0dXJl
cyB0aGF0IHByb3ZpZGUgYSBnbG9iYWwgaW5zdGFuY2Ugb2YNCj4+ICvCoMKgwqDCoMKgIHNj
cmVlbl9pbmZvLg0KPj4gKw0KPj4gwqAgc291cmNlICJrZXJuZWwvZ2Nvdi9LY29uZmlnIg0K
Pj4gwqAgc291cmNlICJzY3JpcHRzL2djYy1wbHVnaW5zL0tjb25maWciDQo+PiBkaWZmIC0t
Z2l0IGEvYXJjaC9hbHBoYS9LY29uZmlnIGIvYXJjaC9hbHBoYS9LY29uZmlnDQo+PiBpbmRl
eCBhNWMyYjFhYTQ2YjAyLi5kNzQ5MDExZDg4YjE0IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9h
bHBoYS9LY29uZmlnDQo+PiArKysgYi9hcmNoL2FscGhhL0tjb25maWcNCj4+IEBAIC00LDYg
KzQsNyBAQCBjb25maWcgQUxQSEENCj4+IMKgwqDCoMKgwqAgZGVmYXVsdCB5DQo+PiDCoMKg
wqDCoMKgIHNlbGVjdCBBUkNIXzMyQklUX1VTVEFUX0ZfVElOT0RFDQo+PiDCoMKgwqDCoMKg
IHNlbGVjdCBBUkNIX0hBU19DVVJSRU5UX1NUQUNLX1BPSU5URVINCj4+ICvCoMKgwqAgc2Vs
ZWN0IEFSQ0hfSEFTX1NDUkVFTl9JTkZPDQo+PiDCoMKgwqDCoMKgIHNlbGVjdCBBUkNIX01J
R0hUX0hBVkVfUENfUEFSUE9SVA0KPj4gwqDCoMKgwqDCoCBzZWxlY3QgQVJDSF9NSUdIVF9I
QVZFX1BDX1NFUklPDQo+PiDCoMKgwqDCoMKgIHNlbGVjdCBBUkNIX05PX1BSRUVNUFQNCj4+
IGRpZmYgLS1naXQgYS9hcmNoL2FybS9LY29uZmlnIGIvYXJjaC9hcm0vS2NvbmZpZw0KPj4g
aW5kZXggMGZiNGIyMThmNjY1OC4uYTlkMDFlZTY3YTkwZSAxMDA2NDQNCj4+IC0tLSBhL2Fy
Y2gvYXJtL0tjb25maWcNCj4+ICsrKyBiL2FyY2gvYXJtL0tjb25maWcNCj4+IEBAIC0xNSw2
ICsxNSw3IEBAIGNvbmZpZyBBUk0NCj4+IMKgwqDCoMKgwqAgc2VsZWN0IEFSQ0hfSEFTX01F
TUJBUlJJRVJfU1lOQ19DT1JFDQo+PiDCoMKgwqDCoMKgIHNlbGVjdCBBUkNIX0hBU19OT05f
T1ZFUkxBUFBJTkdfQUREUkVTU19TUEFDRQ0KPj4gwqDCoMKgwqDCoCBzZWxlY3QgQVJDSF9I
QVNfUFRFX1NQRUNJQUwgaWYgQVJNX0xQQUUNCj4+ICvCoMKgwqAgc2VsZWN0IEFSQ0hfSEFT
X1NDUkVFTl9JTkZPDQo+PiDCoMKgwqDCoMKgIHNlbGVjdCBBUkNIX0hBU19TRVRVUF9ETUFf
T1BTDQo+PiDCoMKgwqDCoMKgIHNlbGVjdCBBUkNIX0hBU19TRVRfTUVNT1JZDQo+PiDCoMKg
wqDCoMKgIHNlbGVjdCBBUkNIX1NUQUNLV0FMSw0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
NjQvS2NvbmZpZyBiL2FyY2gvYXJtNjQvS2NvbmZpZw0KPj4gaW5kZXggMzQzZTFlMWNhZTEw
YS4uMjFhZGRjNDcxNWJiMyAxMDA2NDQNCj4+IC0tLSBhL2FyY2gvYXJtNjQvS2NvbmZpZw0K
Pj4gKysrIGIvYXJjaC9hcm02NC9LY29uZmlnDQo+PiBAQCAtMzYsNiArMzYsNyBAQCBjb25m
aWcgQVJNNjQNCj4+IMKgwqDCoMKgwqAgc2VsZWN0IEFSQ0hfSEFTX05PTl9PVkVSTEFQUElO
R19BRERSRVNTX1NQQUNFDQo+PiDCoMKgwqDCoMKgIHNlbGVjdCBBUkNIX0hBU19QVEVfREVW
TUFQDQo+PiDCoMKgwqDCoMKgIHNlbGVjdCBBUkNIX0hBU19QVEVfU1BFQ0lBTA0KPj4gK8Kg
wqDCoCBzZWxlY3QgQVJDSF9IQVNfU0NSRUVOX0lORk8NCj4+IMKgwqDCoMKgwqAgc2VsZWN0
IEFSQ0hfSEFTX1NFVFVQX0RNQV9PUFMNCj4+IMKgwqDCoMKgwqAgc2VsZWN0IEFSQ0hfSEFT
X1NFVF9ESVJFQ1RfTUFQDQo+PiDCoMKgwqDCoMKgIHNlbGVjdCBBUkNIX0hBU19TRVRfTUVN
T1JZDQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9jc2t5L0tjb25maWcgYi9hcmNoL2Nza3kvS2Nv
bmZpZw0KPj4gaW5kZXggNGRmMWY4YzlkMTcwYi4uMjg0NDRlNTgxZmMxZiAxMDA2NDQNCj4+
IC0tLSBhL2FyY2gvY3NreS9LY29uZmlnDQo+PiArKysgYi9hcmNoL2Nza3kvS2NvbmZpZw0K
Pj4gQEAgLTEwLDYgKzEwLDcgQEAgY29uZmlnIENTS1kNCj4+IMKgwqDCoMKgwqAgc2VsZWN0
IEFSQ0hfVVNFX1FVRVVFRF9SV0xPQ0tTDQo+PiDCoMKgwqDCoMKgIHNlbGVjdCBBUkNIX1VT
RV9RVUVVRURfU1BJTkxPQ0tTDQo+PiDCoMKgwqDCoMKgIHNlbGVjdCBBUkNIX0hBU19DVVJS
RU5UX1NUQUNLX1BPSU5URVINCj4+ICvCoMKgwqAgc2VsZWN0IEFSQ0hfSEFTX1NDUkVFTl9J
TkZPDQo+PiDCoMKgwqDCoMKgIHNlbGVjdCBBUkNIX0lOTElORV9SRUFEX0xPQ0sgaWYgIVBS
RUVNUFRJT04NCj4+IMKgwqDCoMKgwqAgc2VsZWN0IEFSQ0hfSU5MSU5FX1JFQURfTE9DS19C
SCBpZiAhUFJFRU1QVElPTg0KPj4gwqDCoMKgwqDCoCBzZWxlY3QgQVJDSF9JTkxJTkVfUkVB
RF9MT0NLX0lSUSBpZiAhUFJFRU1QVElPTg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvaGV4YWdv
bi9LY29uZmlnIGIvYXJjaC9oZXhhZ29uL0tjb25maWcNCj4+IGluZGV4IDU0ZWFkZjI2NTE3
ODYuLmNjNjgzYzBhNDNkMzQgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL2hleGFnb24vS2NvbmZp
Zw0KPj4gKysrIGIvYXJjaC9oZXhhZ29uL0tjb25maWcNCj4+IEBAIC01LDYgKzUsNyBAQCBj
b21tZW50ICJMaW51eCBLZXJuZWwgQ29uZmlndXJhdGlvbiBmb3IgSGV4YWdvbiINCj4+IMKg
IGNvbmZpZyBIRVhBR09ODQo+PiDCoMKgwqDCoMKgIGRlZl9ib29sIHkNCj4+IMKgwqDCoMKg
wqAgc2VsZWN0IEFSQ0hfMzJCSVRfT0ZGX1QNCj4+ICvCoMKgwqAgc2VsZWN0IEFSQ0hfSEFT
X1NDUkVFTl9JTkZPDQo+PiDCoMKgwqDCoMKgIHNlbGVjdCBBUkNIX0hBU19TWU5DX0RNQV9G
T1JfREVWSUNFDQo+PiDCoMKgwqDCoMKgIHNlbGVjdCBBUkNIX05PX1BSRUVNUFQNCj4+IMKg
wqDCoMKgwqAgc2VsZWN0IERNQV9HTE9CQUxfUE9PTA0KPj4gZGlmZiAtLWdpdCBhL2FyY2gv
aWE2NC9LY29uZmlnIGIvYXJjaC9pYTY0L0tjb25maWcNCj4+IGluZGV4IGU3OWYxNWUzMmE0
NTEuLjhiMWU3ODVlNmQ1M2QgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL2lhNjQvS2NvbmZpZw0K
Pj4gKysrIGIvYXJjaC9pYTY0L0tjb25maWcNCj4+IEBAIC0xMCw2ICsxMCw3IEBAIGNvbmZp
ZyBJQTY0DQo+PiDCoMKgwqDCoMKgIGJvb2wNCj4+IMKgwqDCoMKgwqAgc2VsZWN0IEFSQ0hf
QklORk1UX0VMRl9FWFRSQV9QSERSUw0KPj4gwqDCoMKgwqDCoCBzZWxlY3QgQVJDSF9IQVNf
RE1BX01BUktfQ0xFQU4NCj4+ICvCoMKgwqAgc2VsZWN0IEFSQ0hfSEFTX1NDUkVFTl9JTkZP
DQo+PiDCoMKgwqDCoMKgIHNlbGVjdCBBUkNIX0hBU19TVFJOQ1BZX0ZST01fVVNFUg0KPj4g
wqDCoMKgwqDCoCBzZWxlY3QgQVJDSF9IQVNfU1RSTkxFTl9VU0VSDQo+PiDCoMKgwqDCoMKg
IHNlbGVjdCBBUkNIX01JR0hUX0hBVkVfUENfUEFSUE9SVA0KPj4gZGlmZiAtLWdpdCBhL2Fy
Y2gvbG9vbmdhcmNoL0tjb25maWcgYi9hcmNoL2xvb25nYXJjaC9LY29uZmlnDQo+PiBpbmRl
eCBkMzhiMDY2ZmM5MzFiLi42YWFiMmZiNzc1M2RhIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9s
b29uZ2FyY2gvS2NvbmZpZw0KPj4gKysrIGIvYXJjaC9sb29uZ2FyY2gvS2NvbmZpZw0KPj4g
QEAgLTEzLDYgKzEzLDcgQEAgY29uZmlnIExPT05HQVJDSA0KPj4gwqDCoMKgwqDCoCBzZWxl
Y3QgQVJDSF9IQVNfRk9SVElGWV9TT1VSQ0UNCj4+IMKgwqDCoMKgwqAgc2VsZWN0IEFSQ0hf
SEFTX05NSV9TQUZFX1RISVNfQ1BVX09QUw0KPj4gwqDCoMKgwqDCoCBzZWxlY3QgQVJDSF9I
QVNfUFRFX1NQRUNJQUwNCj4+ICvCoMKgwqAgc2VsZWN0IEFSQ0hfSEFTX1NDUkVFTl9JTkZP
DQo+PiDCoMKgwqDCoMKgIHNlbGVjdCBBUkNIX0hBU19USUNLX0JST0FEQ0FTVCBpZiBHRU5F
UklDX0NMT0NLRVZFTlRTX0JST0FEQ0FTVA0KPj4gwqDCoMKgwqDCoCBzZWxlY3QgQVJDSF9J
TkxJTkVfUkVBRF9MT0NLIGlmICFQUkVFTVBUSU9ODQo+PiDCoMKgwqDCoMKgIHNlbGVjdCBB
UkNIX0lOTElORV9SRUFEX0xPQ0tfQkggaWYgIVBSRUVNUFRJT04NCj4+IGRpZmYgLS1naXQg
YS9hcmNoL21pcHMvS2NvbmZpZyBiL2FyY2gvbWlwcy9LY29uZmlnDQo+PiBpbmRleCA2NzVh
ODY2MGNiODVhLi5jMGFlMDk3ODljYjZkIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9taXBzL0tj
b25maWcNCj4+ICsrKyBiL2FyY2gvbWlwcy9LY29uZmlnDQo+PiBAQCAtMTAsNiArMTAsNyBA
QCBjb25maWcgTUlQUw0KPj4gwqDCoMKgwqDCoCBzZWxlY3QgQVJDSF9IQVNfS0NPVg0KPj4g
wqDCoMKgwqDCoCBzZWxlY3QgQVJDSF9IQVNfTk9OX09WRVJMQVBQSU5HX0FERFJFU1NfU1BB
Q0UgaWYgIUVWQQ0KPj4gwqDCoMKgwqDCoCBzZWxlY3QgQVJDSF9IQVNfUFRFX1NQRUNJQUwg
aWYgISgzMkJJVCAmJiBDUFVfSEFTX1JJWEkpDQo+PiArwqDCoMKgIHNlbGVjdCBBUkNIX0hB
U19TQ1JFRU5fSU5GTw0KPj4gwqDCoMKgwqDCoCBzZWxlY3QgQVJDSF9IQVNfU1RSTkNQWV9G
Uk9NX1VTRVINCj4+IMKgwqDCoMKgwqAgc2VsZWN0IEFSQ0hfSEFTX1NUUk5MRU5fVVNFUg0K
Pj4gwqDCoMKgwqDCoCBzZWxlY3QgQVJDSF9IQVNfVElDS19CUk9BRENBU1QgaWYgR0VORVJJ
Q19DTE9DS0VWRU5UU19CUk9BRENBU1QNCj4+IGRpZmYgLS1naXQgYS9hcmNoL25pb3MyL0tj
b25maWcgYi9hcmNoL25pb3MyL0tjb25maWcNCj4+IGluZGV4IGU1OTM2NDE3ZDNjZDMuLjcx
ODNlZWEyODIyMTIgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL25pb3MyL0tjb25maWcNCj4+ICsr
KyBiL2FyY2gvbmlvczIvS2NvbmZpZw0KPj4gQEAgLTMsNiArMyw3IEBAIGNvbmZpZyBOSU9T
Mg0KPj4gwqDCoMKgwqDCoCBkZWZfYm9vbCB5DQo+PiDCoMKgwqDCoMKgIHNlbGVjdCBBUkNI
XzMyQklUX09GRl9UDQo+PiDCoMKgwqDCoMKgIHNlbGVjdCBBUkNIX0hBU19ETUFfUFJFUF9D
T0hFUkVOVA0KPj4gK8KgwqDCoCBzZWxlY3QgQVJDSF9IQVNfU0NSRUVOX0lORk8NCj4+IMKg
wqDCoMKgwqAgc2VsZWN0IEFSQ0hfSEFTX1NZTkNfRE1BX0ZPUl9DUFUNCj4+IMKgwqDCoMKg
wqAgc2VsZWN0IEFSQ0hfSEFTX1NZTkNfRE1BX0ZPUl9ERVZJQ0UNCj4+IMKgwqDCoMKgwqAg
c2VsZWN0IEFSQ0hfSEFTX0RNQV9TRVRfVU5DQUNIRUQNCj4+IGRpZmYgLS1naXQgYS9hcmNo
L3Bvd2VycGMvS2NvbmZpZyBiL2FyY2gvcG93ZXJwYy9LY29uZmlnDQo+PiBpbmRleCBiZmY1
ODIwYjdjZGExLi5iMWFjYWQzMDc2MTgwIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9wb3dlcnBj
L0tjb25maWcNCj4+ICsrKyBiL2FyY2gvcG93ZXJwYy9LY29uZmlnDQo+PiBAQCAtMTQ4LDYg
KzE0OCw3IEBAIGNvbmZpZyBQUEMNCj4+IMKgwqDCoMKgwqAgc2VsZWN0IEFSQ0hfSEFTX1BU
RV9ERVZNQVDCoMKgwqDCoMKgwqDCoCBpZiBQUENfQk9PSzNTXzY0DQo+PiDCoMKgwqDCoMKg
IHNlbGVjdCBBUkNIX0hBU19QVEVfU1BFQ0lBTA0KPj4gwqDCoMKgwqDCoCBzZWxlY3QgQVJD
SF9IQVNfU0NBTEVEX0NQVVRJTUXCoMKgwqDCoMKgwqDCoCBpZiANCj4+IFZJUlRfQ1BVX0FD
Q09VTlRJTkdfTkFUSVZFICYmIFBQQ19CT09LM1NfNjQNCj4+ICvCoMKgwqAgc2VsZWN0IEFS
Q0hfSEFTX1NDUkVFTl9JTkZPDQo+PiDCoMKgwqDCoMKgIHNlbGVjdCBBUkNIX0hBU19TRVRf
TUVNT1JZDQo+PiDCoMKgwqDCoMKgIHNlbGVjdCBBUkNIX0hBU19TVFJJQ1RfS0VSTkVMX1JX
WMKgwqDCoCBpZiAoUFBDX0JPT0szUyB8fCBQUENfOHh4IA0KPj4gfHwgNDB4KSAmJiAhSElC
RVJOQVRJT04NCj4+IMKgwqDCoMKgwqAgc2VsZWN0IEFSQ0hfSEFTX1NUUklDVF9LRVJORUxf
UldYwqDCoMKgIGlmIFBQQ184NXh4ICYmICFISUJFUk5BVElPTiANCj4+ICYmICFSQU5ET01J
WkVfQkFTRQ0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvS2NvbmZpZyBiL2FyY2gvcmlz
Y3YvS2NvbmZpZw0KPj4gaW5kZXggNTk2NmFkOTdjMzBjMy4uYjVhNDhmODQyNGFmOSAxMDA2
NDQNCj4+IC0tLSBhL2FyY2gvcmlzY3YvS2NvbmZpZw0KPj4gKysrIGIvYXJjaC9yaXNjdi9L
Y29uZmlnDQo+PiBAQCAtMjksNiArMjksNyBAQCBjb25maWcgUklTQ1YNCj4+IMKgwqDCoMKg
wqAgc2VsZWN0IEFSQ0hfSEFTX05PTl9PVkVSTEFQUElOR19BRERSRVNTX1NQQUNFDQo+PiDC
oMKgwqDCoMKgIHNlbGVjdCBBUkNIX0hBU19QTUVNX0FQSQ0KPj4gwqDCoMKgwqDCoCBzZWxl
Y3QgQVJDSF9IQVNfUFRFX1NQRUNJQUwNCj4+ICvCoMKgwqAgc2VsZWN0IEFSQ0hfSEFTX1ND
UkVFTl9JTkZPDQo+PiDCoMKgwqDCoMKgIHNlbGVjdCBBUkNIX0hBU19TRVRfRElSRUNUX01B
UCBpZiBNTVUNCj4+IMKgwqDCoMKgwqAgc2VsZWN0IEFSQ0hfSEFTX1NFVF9NRU1PUlkgaWYg
TU1VDQo+PiDCoMKgwqDCoMKgIHNlbGVjdCBBUkNIX0hBU19TVFJJQ1RfS0VSTkVMX1JXWCBp
ZiBNTVUgJiYgIVhJUF9LRVJORUwNCj4+IGRpZmYgLS1naXQgYS9hcmNoL3NoL0tjb25maWcg
Yi9hcmNoL3NoL0tjb25maWcNCj4+IGluZGV4IDA0Yjk1NTBjZjAwNzAuLjAwMWY1MTQ5OTUy
YjQgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3NoL0tjb25maWcNCj4+ICsrKyBiL2FyY2gvc2gv
S2NvbmZpZw0KPj4gQEAgLTEwLDYgKzEwLDcgQEAgY29uZmlnIFNVUEVSSA0KPj4gwqDCoMKg
wqDCoCBzZWxlY3QgQVJDSF9IQVNfR0lHQU5USUNfUEFHRQ0KPj4gwqDCoMKgwqDCoCBzZWxl
Y3QgQVJDSF9IQVNfR0NPVl9QUk9GSUxFX0FMTA0KPj4gwqDCoMKgwqDCoCBzZWxlY3QgQVJD
SF9IQVNfUFRFX1NQRUNJQUwNCj4+ICvCoMKgwqAgc2VsZWN0IEFSQ0hfSEFTX1NDUkVFTl9J
TkZPDQo+PiDCoMKgwqDCoMKgIHNlbGVjdCBBUkNIX0hBU19USUNLX0JST0FEQ0FTVCBpZiBH
RU5FUklDX0NMT0NLRVZFTlRTX0JST0FEQ0FTVA0KPj4gwqDCoMKgwqDCoCBzZWxlY3QgQVJD
SF9ISUJFUk5BVElPTl9QT1NTSUJMRSBpZiBNTVUNCj4+IMKgwqDCoMKgwqAgc2VsZWN0IEFS
Q0hfTUlHSFRfSEFWRV9QQ19QQVJQT1JUDQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9zcGFyYy9L
Y29uZmlnIGIvYXJjaC9zcGFyYy9LY29uZmlnDQo+PiBpbmRleCA4NTM1ZTE5MDYyZjY1Li5l
NGJmYjgwYjQ4Y2ZlIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9zcGFyYy9LY29uZmlnDQo+PiAr
KysgYi9hcmNoL3NwYXJjL0tjb25maWcNCj4+IEBAIC0xMyw2ICsxMyw3IEBAIGNvbmZpZyA2
NEJJVA0KPj4gwqAgY29uZmlnIFNQQVJDDQo+PiDCoMKgwqDCoMKgIGJvb2wNCj4+IMKgwqDC
oMKgwqAgZGVmYXVsdCB5DQo+PiArwqDCoMKgIHNlbGVjdCBBUkNIX0hBU19TQ1JFRU5fSU5G
Tw0KPj4gwqDCoMKgwqDCoCBzZWxlY3QgQVJDSF9NSUdIVF9IQVZFX1BDX1BBUlBPUlQgaWYg
U1BBUkM2NCAmJiBQQ0kNCj4+IMKgwqDCoMKgwqAgc2VsZWN0IEFSQ0hfTUlHSFRfSEFWRV9Q
Q19TRVJJTw0KPj4gwqDCoMKgwqDCoCBzZWxlY3QgRE1BX09QUw0KPj4gZGlmZiAtLWdpdCBh
L2FyY2gveDg2L0tjb25maWcgYi9hcmNoL3g4Ni9LY29uZmlnDQo+PiBpbmRleCA1M2JhYjEy
M2E4ZWU0Li5kN2MyYmY0ZWU0MDNkIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYvS2NvbmZp
Zw0KPj4gKysrIGIvYXJjaC94ODYvS2NvbmZpZw0KPj4gQEAgLTkxLDYgKzkxLDcgQEAgY29u
ZmlnIFg4Ng0KPj4gwqDCoMKgwqDCoCBzZWxlY3QgQVJDSF9IQVNfTk9OTEVBRl9QTURfWU9V
TkfCoMKgwqAgaWYgUEdUQUJMRV9MRVZFTFMgPiAyDQo+PiDCoMKgwqDCoMKgIHNlbGVjdCBB
UkNIX0hBU19VQUNDRVNTX0ZMVVNIQ0FDSEXCoMKgwqAgaWYgWDg2XzY0DQo+PiDCoMKgwqDC
oMKgIHNlbGVjdCBBUkNIX0hBU19DT1BZX01DwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiBY
ODZfNjQNCj4+ICvCoMKgwqAgc2VsZWN0IEFSQ0hfSEFTX1NDUkVFTl9JTkZPDQo+PiDCoMKg
wqDCoMKgIHNlbGVjdCBBUkNIX0hBU19TRVRfTUVNT1JZDQo+PiDCoMKgwqDCoMKgIHNlbGVj
dCBBUkNIX0hBU19TRVRfRElSRUNUX01BUA0KPj4gwqDCoMKgwqDCoCBzZWxlY3QgQVJDSF9I
QVNfU1RSSUNUX0tFUk5FTF9SV1gNCj4+IGRpZmYgLS1naXQgYS9hcmNoL3h0ZW5zYS9LY29u
ZmlnIGIvYXJjaC94dGVuc2EvS2NvbmZpZw0KPj4gaW5kZXggM2M2ZTU0NzFmMDI1Yi4uYzZj
YmQ3NDU5OTM5YyAxMDA2NDQNCj4+IC0tLSBhL2FyY2gveHRlbnNhL0tjb25maWcNCj4+ICsr
KyBiL2FyY2gveHRlbnNhL0tjb25maWcNCj4+IEBAIC04LDYgKzgsNyBAQCBjb25maWcgWFRF
TlNBDQo+PiDCoMKgwqDCoMKgIHNlbGVjdCBBUkNIX0hBU19ETUFfUFJFUF9DT0hFUkVOVCBp
ZiBNTVUNCj4+IMKgwqDCoMKgwqAgc2VsZWN0IEFSQ0hfSEFTX0dDT1ZfUFJPRklMRV9BTEwN
Cj4+IMKgwqDCoMKgwqAgc2VsZWN0IEFSQ0hfSEFTX0tDT1YNCj4+ICvCoMKgwqAgc2VsZWN0
IEFSQ0hfSEFTX1NDUkVFTl9JTkZPDQo+PiDCoMKgwqDCoMKgIHNlbGVjdCBBUkNIX0hBU19T
WU5DX0RNQV9GT1JfQ1BVIGlmIE1NVQ0KPj4gwqDCoMKgwqDCoCBzZWxlY3QgQVJDSF9IQVNf
U1lOQ19ETUFfRk9SX0RFVklDRSBpZiBNTVUNCj4+IMKgwqDCoMKgwqAgc2VsZWN0IEFSQ0hf
SEFTX0RNQV9TRVRfVU5DQUNIRUQgaWYgTU1VDQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92
aWRlby9LY29uZmlnIGIvZHJpdmVycy92aWRlby9LY29uZmlnDQo+PiBpbmRleCA4YjJiOWFj
MzdjM2RmLi5kNGE3MmJlYTU2YmUwIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy92aWRlby9L
Y29uZmlnDQo+PiArKysgYi9kcml2ZXJzL3ZpZGVvL0tjb25maWcNCj4+IEBAIC0yMSw2ICsy
MSw5IEBAIGNvbmZpZyBTVElfQ09SRQ0KPj4gwqAgY29uZmlnIFZJREVPX0NNRExJTkUNCj4+
IMKgwqDCoMKgwqAgYm9vbA0KPj4gK2NvbmZpZyBBUkNIX0hBU19TQ1JFRU5fSU5GTw0KPj4g
K8KgwqDCoCBib29sDQo+PiArDQo+PiDCoCBjb25maWcgVklERU9fTk9NT0RFU0VUDQo+PiDC
oMKgwqDCoMKgIGJvb2wNCj4+IMKgwqDCoMKgwqAgZGVmYXVsdCBuDQo+PiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9hc20tZ2VuZXJpYy9LYnVpbGQgYi9pbmNsdWRlL2FzbS1nZW5lcmljL0ti
dWlsZA0KPj4gaW5kZXggOTQxYmU1NzRiYmUwMC4uNWU1ZDQxNThhNGI0YiAxMDA2NDQNCj4+
IC0tLSBhL2luY2x1ZGUvYXNtLWdlbmVyaWMvS2J1aWxkDQo+PiArKysgYi9pbmNsdWRlL2Fz
bS1nZW5lcmljL0tidWlsZA0KPj4gQEAgLTQ3LDYgKzQ3LDcgQEAgbWFuZGF0b3J5LXkgKz0g
cGVyY3B1LmgNCj4+IMKgIG1hbmRhdG9yeS15ICs9IHBnYWxsb2MuaA0KPj4gwqAgbWFuZGF0
b3J5LXkgKz0gcHJlZW1wdC5oDQo+PiDCoCBtYW5kYXRvcnkteSArPSByd29uY2UuaA0KPj4g
K21hbmRhdG9yeS15ICs9IHNjcmVlbl9pbmZvLmgNCj4+IMKgIG1hbmRhdG9yeS15ICs9IHNl
Y3Rpb25zLmgNCj4+IMKgIG1hbmRhdG9yeS15ICs9IHNlcmlhbC5oDQo+PiDCoCBtYW5kYXRv
cnkteSArPSBzaG1wYXJhbS5oDQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9hc20tZ2VuZXJp
Yy9zY3JlZW5faW5mby5oIA0KPj4gYi9pbmNsdWRlL2FzbS1nZW5lcmljL3NjcmVlbl9pbmZv
LmgNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAwLi42
ZmQwZTUwZmFiZmNkDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9pbmNsdWRlL2FzbS1n
ZW5lcmljL3NjcmVlbl9pbmZvLmgNCj4+IEBAIC0wLDAgKzEsMTIgQEANCj4+ICsvKiBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCAqLw0KPj4gKw0KPj4gKyNpZm5kZWYgX0FT
TV9HRU5FUklDX1NDUkVFTl9JTkZPX0gNCj4+ICsjZGVmaW5lIF9BU01fR0VORVJJQ19TQ1JF
RU5fSU5GT19IDQo+PiArDQo+PiArI2luY2x1ZGUgPHVhcGkvbGludXgvc2NyZWVuX2luZm8u
aD4NCj4+ICsNCj4+ICsjaWYgZGVmaW5lZChDT05GSUdfQVJDSF9IQVNfU0NSRUVOX0lORk8p
DQo+PiArZXh0ZXJuIHN0cnVjdCBzY3JlZW5faW5mbyBzY3JlZW5faW5mbzsNCj4+ICsjZW5k
aWYNCj4+ICsNCj4+ICsjZW5kaWYgLyogX0FTTV9HRU5FUklDX1NDUkVFTl9JTkZPX0ggKi8N
Cj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NjcmVlbl9pbmZvLmggYi9pbmNsdWRl
L2xpbnV4L3NjcmVlbl9pbmZvLmgNCj4+IGluZGV4IGVhYjcwODEzOTJkNTAuLmM3NjRiOWE1
MWMyNGIgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3NjcmVlbl9pbmZvLmgNCj4+
ICsrKyBiL2luY2x1ZGUvbGludXgvc2NyZWVuX2luZm8uaA0KPj4gQEAgLTQsNiArNCw2IEBA
DQo+PiDCoCAjaW5jbHVkZSA8dWFwaS9saW51eC9zY3JlZW5faW5mby5oPg0KPj4gLWV4dGVy
biBzdHJ1Y3Qgc2NyZWVuX2luZm8gc2NyZWVuX2luZm87DQo+PiArI2luY2x1ZGUgPGFzbS9z
Y3JlZW5faW5mby5oPg0KPj4gwqAgI2VuZGlmIC8qIF9TQ1JFRU5fSU5GT19IICovDQo+IA0K
DQotLSANClRob21hcyBaaW1tZXJtYW5uDQpHcmFwaGljcyBEcml2ZXIgRGV2ZWxvcGVyDQpT
VVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgNCkZyYW5rZW5zdHJhc3NlIDE0
NiwgOTA0NjEgTnVlcm5iZXJnLCBHZXJtYW55DQpHRjogSXZvIFRvdGV2LCBBbmRyZXcgTXll
cnMsIEFuZHJldyBNY0RvbmFsZCwgQm91ZGllbiBNb2VybWFuDQpIUkIgMzY4MDkgKEFHIE51
ZXJuYmVyZykNCg==

--------------b2X5ouefEi1LmiskbVc9m302--

--------------mvTV0S2N0xU0yyoORtj2zLF6
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmSlI4AFAwAAAAAACgkQlh/E3EQov+DI
0w/+PYJb9P5D0YHxaR79JQ9BgY8voxyNlpbj3JugWhVEK4lAPHN8z+HSRdwU4wfxOKsZX1FBTpfk
bECSmBytyxhdDXkMtRL4gRLc49qGRdyGlT9+WI2awawdEmoq9+Ek960DInc9AHFLlLXkgaaaJ6Uj
WvWoRYw61aYfvVjA9TYAlncUklR+YvyskWujVDdDvR31kRW+rWZzqqCmwGIiu/RGejvWR+K+5z57
ytaiLWEbgdRotAfjTUOYA3AsuO9MNYSVyiYvJAU3NOQZ245oaW3DJ73UEZQuMB4lHh6CAMl+r2Az
lbetwa4pgiJ3HBwK3WI5zMUlpEJ1MNOZ683EplCe+6F/30GbHtn0xNYSRhcnZn3Wztrtfb/NJiDS
ub+fAYffkbCcleXSKJjUFZRsKRdpYZFWWrBmnP/6FM6LXdXzGU/qUewdy+v0DXr162f2hINbPN8D
zmvuKrIlXMoWx0rgj3DkVaUFG3D59X4TUWcKwap1SsGhImHjX4VibaLu96eH2H9mEnRBUaiBz20u
1uWWM+Cpug4xP+sDiGsGk55NRdoViH+hEhSj6dqCZYrYriGiwGdhcbT9hVzLWJVVUazIFFYkO9Ws
q5YOCxp+LUlkRJhp7GkJ8jgK0b07LDMBc1v56u6b3nUtZfQl37lxNyfDtN2hZvNcrO5wYNKrt4UT
Mb8=
=Uq4J
-----END PGP SIGNATURE-----

--------------mvTV0S2N0xU0yyoORtj2zLF6--
