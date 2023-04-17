Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC096E4319
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 11:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjDQJDv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 05:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjDQJDu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 05:03:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4CA199F;
        Mon, 17 Apr 2023 02:03:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0A8891F381;
        Mon, 17 Apr 2023 09:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681722227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d8A2ZUy/lVcriOnB4f9oVvXNmiXwKTFdxYnQjf9J06M=;
        b=BkMeIzsCaz/1qsCpBY3shJ9SdbEY8+WDuXDejoaHRIauiQ2ZOOMwTBr7sRPMgY8XWExQeE
        oeCrwHYTYBgYmcqDhb9i/RVyMXUqnNzgaV8Lrfz+FCwVBVppBXYyvlHsYTdNvHtkOehmlb
        M2dFpk9G2vIhcI9oPzCLoNiIE4hntOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681722227;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d8A2ZUy/lVcriOnB4f9oVvXNmiXwKTFdxYnQjf9J06M=;
        b=LAFt+Vockryc+5LBbO/a8ZoTBFoaqimB5HQI5t71BPiB2N2EMs4YZO59LSiealCh9tV0AW
        T27q/nNszvC8H3BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F46113319;
        Mon, 17 Apr 2023 09:03:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pcOfIXILPWTNVgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 17 Apr 2023 09:03:46 +0000
Message-ID: <2b4f75b8-aa83-8e41-7c99-7c8d573c0f31@suse.de>
Date:   Mon, 17 Apr 2023 11:03:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 01/19] fbdev: Prepare generic architecture helpers
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     arnd@arndb.de, daniel.vetter@ffwll.ch, deller@gmx.de,
        javierm@redhat.com, gregkh@linuxfoundation.org,
        linux-arch@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org
References: <20230406143019.6709-1-tzimmermann@suse.de>
 <20230406143019.6709-2-tzimmermann@suse.de>
 <CAMuHMdUfViWzPbB+GcGUwxmGNxAohfq71Jed3DzS=Cb+gBzotg@mail.gmail.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <CAMuHMdUfViWzPbB+GcGUwxmGNxAohfq71Jed3DzS=Cb+gBzotg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------xWwPiIYmrlcSVPwysV4e9Klk"
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------xWwPiIYmrlcSVPwysV4e9Klk
Content-Type: multipart/mixed; boundary="------------8LwHOmqVih1SSnC0wxvh5ylS";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: arnd@arndb.de, daniel.vetter@ffwll.ch, deller@gmx.de, javierm@redhat.com,
 gregkh@linuxfoundation.org, linux-arch@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, x86@kernel.org
Message-ID: <2b4f75b8-aa83-8e41-7c99-7c8d573c0f31@suse.de>
Subject: Re: [PATCH v2 01/19] fbdev: Prepare generic architecture helpers
References: <20230406143019.6709-1-tzimmermann@suse.de>
 <20230406143019.6709-2-tzimmermann@suse.de>
 <CAMuHMdUfViWzPbB+GcGUwxmGNxAohfq71Jed3DzS=Cb+gBzotg@mail.gmail.com>
In-Reply-To: <CAMuHMdUfViWzPbB+GcGUwxmGNxAohfq71Jed3DzS=Cb+gBzotg@mail.gmail.com>

--------------8LwHOmqVih1SSnC0wxvh5ylS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgR2VlcnQNCg0KQW0gMTEuMDQuMjMgdW0gMTA6MDggc2NocmllYiBHZWVydCBVeXR0ZXJo
b2V2ZW46DQo+IEhpIFRob21hcywNCj4gDQo+IE9uIFRodSwgQXByIDYsIDIwMjMgYXQgNDoz
MOKAr1BNIFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPiB3cm90ZToN
Cj4+IEdlbmVyaWMgaW1wbGVtZW50YXRpb25zIG9mIGZiX3BncHJvdGVjdCgpIGFuZCBmYl9p
c19wcmltYXJ5X2RldmljZSgpDQo+PiBoYXZlIGJlZW4gaW4gdGhlIHNvdXJjZSBjb2RlIGZv
ciBhIGxvbmcgdGltZS4gUHJlcGFyZSB0aGUgaGVhZGVyIGZpbGUNCj4+IHRvIG1ha2UgdXNl
IG9mIHRoZW0uDQo+Pg0KPj4gSW1wcm92ZSB0aGUgY29kZSBieSB1c2luZyBhbiBpbmxpbmUg
ZnVuY3Rpb24gZm9yIGZiX3BncHJvdGVjdCgpDQo+PiBhbmQgYnkgcmVtb3ZpbmcgaW5jbHVk
ZSBzdGF0ZW1lbnRzLiBUaGUgZGVmYXVsdCBtb2RlIHNldCBieQ0KPj4gZmJfcGdwcm90ZWN0
KCkgaXMgbm93IHdyaXRlY29tYmluZSwgd2hpY2ggaXMgd2hhdCBtb3N0IHBsYXRmb3Jtcw0K
Pj4gd2FudC4NCj4+DQo+PiBTeW1ib2xzIGFyZSBwcm90ZWN0ZWQgYnkgcHJlcHJvY2Vzc29y
IGd1YXJkcy4gQXJjaGl0ZWN0dXJlcyB0aGF0DQo+PiBwcm92aWRlIGEgc3ltYm9sIG5lZWQg
dG8gZGVmaW5lIGEgcHJlcHJvY2Vzc29yIHRva2VuIG9mIHRoZSBzYW1lDQo+PiBuYW1lIGFu
ZCB2YWx1ZS4gT3RoZXJ3aXNlIHRoZSBoZWFkZXIgZmlsZSB3aWxsIHByb3ZpZGUgYSBnZW5l
cmljDQo+PiBpbXBsZW1lbnRhdGlvbi4gVGhpcyBwYXR0ZXJuIGhhcyBiZWVuIHRha2VuIGZy
b20gPGFzbS9pby5oPi4NCj4+DQo+PiB2MjoNCj4+ICAgICAgICAgICogIHVzZSB3cml0ZWNv
bWJpbmUgbWFwcGluZ3MgYnkgZGVmYXVsdCAoQXJuZCkNCj4+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5Ac3VzZS5kZT4NCj4gDQo+IFRoYW5r
cyBmb3IgeW91ciBwYXRjaCENCj4gDQo+PiAtLS0gYS9pbmNsdWRlL2FzbS1nZW5lcmljL2Zi
LmgNCj4+ICsrKyBiL2luY2x1ZGUvYXNtLWdlbmVyaWMvZmIuaA0KPj4gQEAgLTEsMTMgKzEs
MzIgQEANCj4+ICAgLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgKi8NCj4+
ICsNCj4+ICAgI2lmbmRlZiBfX0FTTV9HRU5FUklDX0ZCX0hfDQo+PiAgICNkZWZpbmUgX19B
U01fR0VORVJJQ19GQl9IXw0KPj4gLSNpbmNsdWRlIDxsaW51eC9mYi5oPg0KPj4NCj4+IC0j
ZGVmaW5lIGZiX3BncHJvdGVjdCguLi4pIGRvIHt9IHdoaWxlICgwKQ0KPj4gKy8qDQo+PiAr
ICogT25seSBpbmNsdWRlIHRoaXMgaGVhZGVyIGZpbGUgZnJvbSB5b3VyIGFyY2hpdGVjdHVy
ZSdzIDxhc20vZmIuaD4uDQo+PiArICovDQo+PiArDQo+PiArI2luY2x1ZGUgPGFzbS9wYWdl
Lmg+DQo+PiArDQo+PiArc3RydWN0IGZiX2luZm87DQo+PiArc3RydWN0IGZpbGU7DQo+PiAr
DQo+PiArI2lmbmRlZiBmYl9wZ3Byb3RlY3QNCj4+ICsjZGVmaW5lIGZiX3BncHJvdGVjdCBm
Yl9wZ3Byb3RlY3QNCj4+ICtzdGF0aWMgaW5saW5lIHZvaWQgZmJfcGdwcm90ZWN0KHN0cnVj
dCBmaWxlICpmaWxlLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBvZmYpDQo+IA0KPiBEb2Vz
IHRoaXMgYWZmZWN0IGFueSBub01NVSBwbGF0Zm9ybXMgdGhhdCByZWxpZWQgb24gZmJfcGdw
cm90ZWN0KCkNCj4gZG9pbmcgbm90aGluZyBiZWZvcmU/DQo+IFBlcmhhcHMgdGhlIGJvZHkg
YmVsb3cgc2hvdWxkIGJlIHByb3RlY3RlZCBieSAiI2lmZGVmIENPTkZJR19NTVUiPw0KDQpJ
IGNhbm5vdCBjb25jbHVzaXZlbHkgYW5zd2VyIHRoaXMgcXVlc3Rpb24sIGJ1dCBJIGRpZCBz
b21lIGdyZXAnaW5nIA0KKCdnaXQgZ3JlcCBuZGVmIHwgZ3JlcCBDT05GSUdfTU1VJyk6DQoN
Ck9ubHkgdGhlIGFyY2hpdGVjdHVyZXMgaW4gdGhpcyBwYXRjaHNldCBwcm92aWRlIDxhc20v
ZmIuaD4gYnV0IG5vdGhpbmcgDQphbnl3aGVyZSB1c2VzIDxhc20tZ2VuZXJpYy9mYi5oPiB5
ZXQuIEFuZCBvZiB0aG9zZSBhcmNoaXRlY3R1cmVzLCBvbmx5IA0KYXJtIGFuZCBtNjhrIGhh
dmUgIUNPTkZJR19NTVUgY2FzZXMuIFRob3NlIGFyZSBoYW5kbGVkIGluIHRoZSByc3AgDQpw
YXRjaGVzLiBJIHRoaW5rIHdlJ3JlIGdvb2QuDQoNCj4gDQo+PiArew0KPj4gKyAgICAgICB2
bWEtPnZtX3BhZ2VfcHJvdCA9IHBncHJvdF93cml0ZWNvbWJpbmUodm1hLT52bV9wYWdlX3By
b3QpOw0KPiANCj4gU2hvdWxkbid0IHRoaXMgdXNlIHRoZSBwZ3Byb3RfdmFsKCkgd3JhcHBl
cj8NCg0KTm8sIEkgdGhpbmsuIEdyZXAnaW5nIGZvciB2bV9wYWdlX3Byb3QsIEknbSBub3Qg
c2VlaW5nIGl0IGJlaW5nIHVzZWQgaW4gDQpzdWNoIGFzc2lnbm1lbnRzLg0KDQpCZXN0IHJl
Z2FyZHMNClRob21hcw0KDQo+IA0KPj4gK30NCj4+ICsjZW5kaWYNCj4gDQo+IEdye29ldGpl
LGVldGluZ31zLA0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+IA0K
DQotLSANClRob21hcyBaaW1tZXJtYW5uDQpHcmFwaGljcyBEcml2ZXIgRGV2ZWxvcGVyDQpT
VVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgNCk1heGZlbGRzdHIuIDUsIDkw
NDA5IE7DvHJuYmVyZywgR2VybWFueQ0KKEhSQiAzNjgwOSwgQUcgTsO8cm5iZXJnKQ0KR2Vz
Y2jDpGZ0c2bDvGhyZXI6IEl2byBUb3Rldg0K

--------------8LwHOmqVih1SSnC0wxvh5ylS--

--------------xWwPiIYmrlcSVPwysV4e9Klk
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmQ9C3IFAwAAAAAACgkQlh/E3EQov+Cm
UBAAp1ZwVmrz8T2+3vZ7ZpV1ctroomnDLRbTJNv29Sy/VKoywyu1xmGePsWLIqjuhReXF1xbOWtq
6Ue7vAdNub4kTqGjoZy70Ct7WQAmjozmebI6ZRJEEq7aFTji2pVlikWgChEQwLMiDpsYF1vgB8vp
8I0sP1t8Cu3HRGRyybCR2Y6WpsEk4lB4mrJxlflHRmOvFQDMZB+Y38C24LwGO6SsLIybsqB0am6d
QrsVdKA0ByFWKQ47LhJ8tfzdpekveM9t0yR5QLhQ/9Mg1+KiyuNjcIs2dkgIoRPwEG5dkGGJ3YCy
W12J2+Gehydj2i/55iYwpKKB0abS5Bj4vFXHqvvV2xcyrxOmdCktMRD3UR7yxs9Aa24LC1qbpZxv
1Qk+Y/SMMZj/Nm3nIxYkobOrLgSJwEZYSbjXxVaQ7ViK6lQsMesVjAh1DFRXyTuohxVbP8onI2CU
KL5SMAALHxHJPdG60K+/+L07gXuB5nyJFejrDlCVP9aPcJafeoWP3t/qN1xJUR4LMRyuIFgFF8qM
+5slKCT46KthVsu6GI5dsqbhQnDMAPrjlY+6GFc0jQMERh1v4J2Ev2l6o4Cy75Ru18WqY+FzcXMV
Cr2lTlxPDrR9nUC7bONXRlrB9N2sm0RYhhZ1fpZ+sXFRah0tYDBoAIfCGzzvzjOJb/6TDxhYrza8
bkQ=
=Y3tV
-----END PGP SIGNATURE-----

--------------xWwPiIYmrlcSVPwysV4e9Klk--
