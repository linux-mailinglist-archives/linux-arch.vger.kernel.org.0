Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A7D747EC8
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jul 2023 10:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjGEIAP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jul 2023 04:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjGEIAO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jul 2023 04:00:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9649F12A;
        Wed,  5 Jul 2023 01:00:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0409721B29;
        Wed,  5 Jul 2023 08:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688544008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9QZJExG+QXkmHTLOgw2VTHmTUhOBLZWT/ESLdRRfdIk=;
        b=n4qSX9rTZOxMJFKbG5iSbspL9vp0laPxiBbW3soRKq3y0VvPF8VS/P0Eu2fcLngXCA6CvQ
        0WUtY/xmxFBjIOkwO5zf53bTMQ9I/1vfAJzYkHo+iVfdEncWj9e6vyUddgyc45/7NlJ5Fx
        65O5s1CJmhREcHFntCBAqUMeMv22WbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688544008;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9QZJExG+QXkmHTLOgw2VTHmTUhOBLZWT/ESLdRRfdIk=;
        b=a1Pk3Hq7PR1VsRsn8nXT6djvrCc9QDb7vMm/LqNRP7ZjFS6N9jReGidm0+Z2Lf8wAqbqAW
        Z2NfJogXmgTMuXBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6AB2413460;
        Wed,  5 Jul 2023 08:00:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RaIVGQcjpWQzPgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 05 Jul 2023 08:00:07 +0000
Message-ID: <120ca7ab-628e-c9d8-696d-97432c497049@suse.de>
Date:   Wed, 5 Jul 2023 10:00:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [01/12] efi: Do not include <linux/screen_info.h> from EFI header
Content-Language: en-US
To:     Sui Jingfeng <suijingfeng@loongson.cn>, arnd@arndb.de,
        deller@gmx.de, daniel@ffwll.ch, airlied@gmail.com
Cc:     linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mips@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-arch@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-staging@lists.linux.dev,
        Russell King <linux@armlinux.org.uk>,
        linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20230629121952.10559-2-tzimmermann@suse.de>
 <26e355dd-049c-fa82-dc5d-565b86339253@loongson.cn>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <26e355dd-049c-fa82-dc5d-565b86339253@loongson.cn>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------kiThIjo0NexkkWUhwJOB0jU3"
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
--------------kiThIjo0NexkkWUhwJOB0jU3
Content-Type: multipart/mixed; boundary="------------EYs5PmO7i5TkEHZcogd86iWc";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Sui Jingfeng <suijingfeng@loongson.cn>, arnd@arndb.de, deller@gmx.de,
 daniel@ffwll.ch, airlied@gmail.com
Cc: linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-staging@lists.linux.dev, Russell King <linux@armlinux.org.uk>,
 linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-ID: <120ca7ab-628e-c9d8-696d-97432c497049@suse.de>
Subject: Re: [01/12] efi: Do not include <linux/screen_info.h> from EFI header
References: <20230629121952.10559-2-tzimmermann@suse.de>
 <26e355dd-049c-fa82-dc5d-565b86339253@loongson.cn>
In-Reply-To: <26e355dd-049c-fa82-dc5d-565b86339253@loongson.cn>

--------------EYs5PmO7i5TkEHZcogd86iWc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMDUuMDcuMjMgdW0gMDM6NDAgc2NocmllYiBTdWkgSmluZ2Zlbmc6DQo+IEhp
LCBUaG9tYXMNCj4gDQo+IA0KPiBJIGxvdmUgeW91ciBwYXRjaCwgTG9vbmdBcmNoIGFsc28g
aGF2ZSBVRUZJIEdPUCBzdXBwb3J0LA0KPiANCj4gTWF5YmUgdGhlIGFyY2gvbG9vbmdhcmNo
L2tlcm5lbC9lZmkuYyBkb24ndCBpbmNsdWRlIHRoZSAnI2luY2x1ZGUgDQo+IDxsaW51eC9z
Y3JlZW5faW5mby5oPicgZXhwbGljaXRseS4NCg0KT2gsIHRoYW5rIHlvdSBmb3IgdGVzdGlu
Zy4gSSB0cnkgdG8gYnVpbGQgYXJjaC8gY2hhbmdlcyBvbiBhbGwgb2YgdGhlIA0KYWZmZWN0
ZWQgcGxhdGZvcm1zLCBidXQgSSBjYW5ub3QgYnVpbGQgZm9yIGFsbCBvZiB0aGVtLiBJIGhh
dmUgbm8gbWVhbnMgDQpvZiBidWlsZGluZyBmb3IgbG9vbmdhcmNoIEFUTS4NCg0KSSdsbCB1
cGRhdGUgdGhlIHBhdGNoIGFjY29yZGluZyB0byB5b3VyIGZlZWRiYWNrLg0KDQpCZXN0IHJl
Z2FyZHMNClRob21hcw0KDQo+IA0KPiANCj4gYGBgDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJj
aC9sb29uZ2FyY2gva2VybmVsL2VmaS5jIGIvYXJjaC9sb29uZ2FyY2gva2VybmVsL2VmaS5j
DQo+IGluZGV4IDNkNDQ4ZmVmM2FmNC4uMDRmNGQyMTdhZWZiIDEwMDY0NA0KPiAtLS0gYS9h
cmNoL2xvb25nYXJjaC9rZXJuZWwvZWZpLmMNCj4gKysrIGIvYXJjaC9sb29uZ2FyY2gva2Vy
bmVsL2VmaS5jDQo+IEBAIC0xOSw2ICsxOSw3IEBADQo+ICDCoCNpbmNsdWRlIDxsaW51eC9t
ZW1ibG9jay5oPg0KPiAgwqAjaW5jbHVkZSA8bGludXgvcmVib290Lmg+DQo+ICDCoCNpbmNs
dWRlIDxsaW51eC91YWNjZXNzLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvc2NyZWVuX2luZm8u
aD4NCj4gDQo+ICDCoCNpbmNsdWRlIDxhc20vZWFybHlfaW9yZW1hcC5oPg0KPiAgwqAjaW5j
bHVkZSA8YXNtL2VmaS5oPg0KPiBgYGANCj4gDQo+IA0KPiBPbiAyMDIzLzYvMjkgMTk6NDUs
IFRob21hcyBaaW1tZXJtYW5uIHdyb3RlOg0KPj4gVGhlIGhlYWRlciBmaWxlIDxsaW51eC9l
ZmkuaD4gZG9lcyBub3QgbmVlZCBhbnl0aGluZyBmcm9tDQo+PiA8bGludXgvc2NyZWVuX2lu
Zm8uaD4uIERlY2xhcmUgc3RydWN0IHNjcmVlbl9pbmZvIGFuZCByZW1vdmUNCj4+IHRoZSBp
bmNsdWRlIHN0YXRlbWVudHMuIFVwZGF0ZSBhIG51bWJlciBvZiBzb3VyY2UgZmlsZXMgdGhh
dA0KPj4gcmVxdWlyZSBzdHJ1Y3Qgc2NyZWVuX2luZm8ncyBkZWZpbml0aW9uLg0KPj4NCj4+
IFNpZ25lZC1vZmYtYnk6IFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRl
Pg0KPj4gQ2M6IEFyZCBCaWVzaGV1dmVsIDxhcmRiQGtlcm5lbC5vcmc+DQo+PiBDYzogUnVz
c2VsbCBLaW5nIDxsaW51eEBhcm1saW51eC5vcmcudWs+DQo+PiBDYzogQ2F0YWxpbiBNYXJp
bmFzIDxjYXRhbGluLm1hcmluYXNAYXJtLmNvbT4NCj4+IENjOiBXaWxsIERlYWNvbiA8d2ls
bEBrZXJuZWwub3JnPg0KPj4gUmV2aWV3ZWQtYnk6IEphdmllciBNYXJ0aW5leiBDYW5pbGxh
cyA8amF2aWVybUByZWRoYXQuY29tPg0KPiANCj4gV2l0aCB0aGUgYWJvdmUgaXNzdWUgc29s
dmVkLCBwbGVhc2UgdGFrZSBteSBSLUIgaWYgeW91IHdvdWxkIGxpa2UuDQo+IA0KPiANCj4g
UmV2aWV3ZWQtYnk6IFN1aSBKaW5nZmVuZyA8c3VpamluZ2ZlbmdAbG9vbmdzb24uY24+DQo+
IA0KPj4gLS0tDQo+PiDCoCBhcmNoL2FybS9rZXJuZWwvZWZpLmPCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAyICsrDQo+PiDCoCBhcmNoL2Fy
bTY0L2tlcm5lbC9lZmkuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHwgMSArDQo+PiDCoCBkcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL2VmaS1z
dHViLWVudHJ5LmMgfCAyICsrDQo+PiDCoCBkcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHVi
L3NjcmVlbl9pbmZvLmPCoMKgwqAgfCAyICsrDQo+PiDCoCBpbmNsdWRlL2xpbnV4L2VmaS5o
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
IDMgKystDQo+PiDCoCA1IGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9rZXJuZWwvZWZpLmMgYi9h
cmNoL2FybS9rZXJuZWwvZWZpLmMNCj4+IGluZGV4IGUyYjlkMjYxOGM2NzIuLmU5NDY1NWVm
MTZiYjMgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL2FybS9rZXJuZWwvZWZpLmMNCj4+ICsrKyBi
L2FyY2gvYXJtL2tlcm5lbC9lZmkuYw0KPj4gQEAgLTUsNiArNSw4IEBADQo+PiDCoCAjaW5j
bHVkZSA8bGludXgvZWZpLmg+DQo+PiDCoCAjaW5jbHVkZSA8bGludXgvbWVtYmxvY2suaD4N
Cj4+ICsjaW5jbHVkZSA8bGludXgvc2NyZWVuX2luZm8uaD4NCj4+ICsNCj4+IMKgICNpbmNs
dWRlIDxhc20vZWZpLmg+DQo+PiDCoCAjaW5jbHVkZSA8YXNtL21hY2gvbWFwLmg+DQo+PiDC
oCAjaW5jbHVkZSA8YXNtL21tdV9jb250ZXh0Lmg+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9h
cm02NC9rZXJuZWwvZWZpLmMgYi9hcmNoL2FybTY0L2tlcm5lbC9lZmkuYw0KPj4gaW5kZXgg
YmFhYjhkZDNlYWQzYy4uM2FmYmU1MDNiMDY2ZiAxMDA2NDQNCj4+IC0tLSBhL2FyY2gvYXJt
NjQva2VybmVsL2VmaS5jDQo+PiArKysgYi9hcmNoL2FybTY0L2tlcm5lbC9lZmkuYw0KPj4g
QEAgLTksNiArOSw3IEBADQo+PiDCoCAjaW5jbHVkZSA8bGludXgvZWZpLmg+DQo+PiDCoCAj
aW5jbHVkZSA8bGludXgvaW5pdC5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9zY3JlZW5faW5m
by5oPg0KPj4gwqAgI2luY2x1ZGUgPGFzbS9lZmkuaD4NCj4+IMKgICNpbmNsdWRlIDxhc20v
c3RhY2t0cmFjZS5oPg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvZWZpL2xp
YnN0dWIvZWZpLXN0dWItZW50cnkuYyANCj4+IGIvZHJpdmVycy9maXJtd2FyZS9lZmkvbGli
c3R1Yi9lZmktc3R1Yi1lbnRyeS5jDQo+PiBpbmRleCBjYzRkY2FlYTY3ZmE2Li4yZjE5MDJl
NWQ0MDc1IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9l
Zmktc3R1Yi1lbnRyeS5jDQo+PiArKysgYi9kcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHVi
L2VmaS1zdHViLWVudHJ5LmMNCj4+IEBAIC0xLDYgKzEsOCBAQA0KPj4gwqAgLy8gU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQ0KPj4gwqAgI2luY2x1ZGUgPGxpbnV4
L2VmaS5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9zY3JlZW5faW5mby5oPg0KPj4gKw0KPj4g
wqAgI2luY2x1ZGUgPGFzbS9lZmkuaD4NCj4+IMKgICNpbmNsdWRlICJlZmlzdHViLmgiDQo+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9zY3JlZW5faW5m
by5jIA0KPj4gYi9kcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL3NjcmVlbl9pbmZvLmMN
Cj4+IGluZGV4IDRiZTFjNGQxZjkyMmIuLmE1MWVjMjAxY2EzY2IgMTAwNjQ0DQo+PiAtLS0g
YS9kcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL3NjcmVlbl9pbmZvLmMNCj4+ICsrKyBi
L2RyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvc2NyZWVuX2luZm8uYw0KPj4gQEAgLTEs
NiArMSw4IEBADQo+PiDCoCAvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0K
Pj4gwqAgI2luY2x1ZGUgPGxpbnV4L2VmaS5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9zY3Jl
ZW5faW5mby5oPg0KPj4gKw0KPj4gwqAgI2luY2x1ZGUgPGFzbS9lZmkuaD4NCj4+IMKgICNp
bmNsdWRlICJlZmlzdHViLmgiDQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9lZmku
aCBiL2luY2x1ZGUvbGludXgvZWZpLmgNCj4+IGluZGV4IDU3MWQxYTZlMWI3NDQuLjM2MDg5
NWE1NTcyYzAgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2VmaS5oDQo+PiArKysg
Yi9pbmNsdWRlL2xpbnV4L2VmaS5oDQo+PiBAQCAtMjQsMTAgKzI0LDExIEBADQo+PiDCoCAj
aW5jbHVkZSA8bGludXgvcmFuZ2UuaD4NCj4+IMKgICNpbmNsdWRlIDxsaW51eC9yZWJvb3Qu
aD4NCj4+IMKgICNpbmNsdWRlIDxsaW51eC91dWlkLmg+DQo+PiAtI2luY2x1ZGUgPGxpbnV4
L3NjcmVlbl9pbmZvLmg+DQo+PiDCoCAjaW5jbHVkZSA8YXNtL3BhZ2UuaD4NCj4+ICtzdHJ1
Y3Qgc2NyZWVuX2luZm87DQo+PiArDQo+PiDCoCAjZGVmaW5lIEVGSV9TVUNDRVNTwqDCoMKg
wqDCoMKgwqAgMA0KPj4gwqAgI2RlZmluZSBFRklfTE9BRF9FUlJPUsKgwqDCoMKgwqDCoMKg
ICggMSB8ICgxVUwgPDwgKEJJVFNfUEVSX0xPTkctMSkpKQ0KPj4gwqAgI2RlZmluZSBFRklf
SU5WQUxJRF9QQVJBTUVURVLCoMKgwqAgKCAyIHwgKDFVTCA8PCAoQklUU19QRVJfTE9ORy0x
KSkpDQo+IA0KDQotLSANClRob21hcyBaaW1tZXJtYW5uDQpHcmFwaGljcyBEcml2ZXIgRGV2
ZWxvcGVyDQpTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgNCkZyYW5rZW5z
dHJhc3NlIDE0NiwgOTA0NjEgTnVlcm5iZXJnLCBHZXJtYW55DQpHRjogSXZvIFRvdGV2LCBB
bmRyZXcgTXllcnMsIEFuZHJldyBNY0RvbmFsZCwgQm91ZGllbiBNb2VybWFuDQpIUkIgMzY4
MDkgKEFHIE51ZXJuYmVyZykNCg==

--------------EYs5PmO7i5TkEHZcogd86iWc--

--------------kiThIjo0NexkkWUhwJOB0jU3
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmSlIwYFAwAAAAAACgkQlh/E3EQov+C9
kg/9FAe1MaqN1jjybJ72WFMD71jRRKD6+u0ZqqxvttOXVvJ0EVwTVbKj2/Y+xFeqG1h+9cOB5eaA
FuQYX7fQEB2RCbmp7Sc56uN6RNTAxbtjBdSzYyhOOKIVj2KA0eNXMOc01lErusQcptItLdaJAQuX
Oh5qviaXu/mTaTlGQYvycxmMYZPIXQ+qaTWXKNtOaPFWXa70Q4X21VwUotuarb6xk0TdppNug/Tw
C6pwxC6i8ieYmAcWwc8TGD8YlJGNjSS47WJBVwycEg//6PLgWnrXgDHDWyUVrLgR68aGli/q04GJ
vVnwln5Vf1Atzw79k4Q+tCZicPlaTrOvEmtkYkWtq4kY1dnOSWx6fiwNgxhZYZjsiSg78WDyWV1h
en6Ofba+0dPqZeoCQo1wVcjFi5leHZwkV1NUDftSElJhQ10g47vWEYHCYKNU6V0A6Pxz1m/XffFo
hNI+AhHslw2idU71efQ682oAKAn8u3UF0d1r8bPx2owXnadCEphDrYIArGt32NrNekQRVaCOCNyn
pjUbHApcXwPsRWC1McXOo/yZDc1yA6N5NE8MbxNf90pLd4AgBlWPF6E0oVKutStRSlXNVM9DiLuF
Gt3a2V2xw9TeeTB9BmV1jx72c4VO8NfxXOTyw5g9rJRbeOdOXV8hzq6AIOajWvbcJATve20NFhem
/iw=
=i2D3
-----END PGP SIGNATURE-----

--------------kiThIjo0NexkkWUhwJOB0jU3--
