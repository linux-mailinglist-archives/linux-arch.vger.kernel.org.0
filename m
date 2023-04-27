Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0126F01A3
	for <lists+linux-arch@lfdr.de>; Thu, 27 Apr 2023 09:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242707AbjD0HYE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Apr 2023 03:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242817AbjD0HYB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Apr 2023 03:24:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6C549D8;
        Thu, 27 Apr 2023 00:23:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D50261FDF6;
        Thu, 27 Apr 2023 07:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682580168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mwjDvnTTpUQQAU0S0NYQu7NztQ86BE/cY3YTj2NNeVM=;
        b=Un7Gx01PokhNQiVoDb02P2s+kOPGU770pEPzJrxxIAFVFRAXtAUqKAYpk5HGhcEcjn2qx3
        2C9Ze5cftpcNs/R+ie2ctuvNWHI8ZUZH2qu4rexmtorhKnrzH9Uite0TY3cAwazKzLSnM9
        bSgsC8Qen6ZvcZ9aCUO46+tQxItvtIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682580168;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mwjDvnTTpUQQAU0S0NYQu7NztQ86BE/cY3YTj2NNeVM=;
        b=MVwyD8XGPiCuNb0tm4gyVIuhyn9YeI8pxDwrB2nQC/aLSapjlluwmmOAV+r89rHGjJ5Ohb
        IWkBOldoEBcgo0BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 628F613910;
        Thu, 27 Apr 2023 07:22:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SCQXF8giSmT2JQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 27 Apr 2023 07:22:48 +0000
Message-ID: <3e33ab1d-b478-fdf5-6fbe-6580000182d1@suse.de>
Date:   Thu, 27 Apr 2023 09:22:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/5] fbdev: Move framebuffer I/O helpers to <asm/fb.h>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     deller@gmx.de, geert@linux-m68k.org, javierm@redhat.com,
        daniel@ffwll.ch, vgupta@kernel.org, chenhuacai@kernel.org,
        kernel@xen0n.name, davem@davemloft.net,
        James.Bottomley@hansenpartnership.com, arnd@arndb.de,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org
References: <20230426130420.19942-1-tzimmermann@suse.de>
 <20230426192110.GA3791243@ravnborg.org>
Content-Language: en-US
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20230426192110.GA3791243@ravnborg.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------7Tnoo09B1y1bqPUqHSpN4Mqn"
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------7Tnoo09B1y1bqPUqHSpN4Mqn
Content-Type: multipart/mixed; boundary="------------0BnAEdd7ws0JRInwI0tlF7W0";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: deller@gmx.de, geert@linux-m68k.org, javierm@redhat.com, daniel@ffwll.ch,
 vgupta@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
 davem@davemloft.net, James.Bottomley@hansenpartnership.com, arnd@arndb.de,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-parisc@vger.kernel.org
Message-ID: <3e33ab1d-b478-fdf5-6fbe-6580000182d1@suse.de>
Subject: Re: [PATCH 0/5] fbdev: Move framebuffer I/O helpers to <asm/fb.h>
References: <20230426130420.19942-1-tzimmermann@suse.de>
 <20230426192110.GA3791243@ravnborg.org>
In-Reply-To: <20230426192110.GA3791243@ravnborg.org>

--------------0BnAEdd7ws0JRInwI0tlF7W0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgU2FtDQoNCkFtIDI2LjA0LjIzIHVtIDIxOjIxIHNjaHJpZWIgU2FtIFJhdm5ib3JnOg0K
PiBIaSBUaG9tYXMuDQo+IA0KPiBPbiBXZWQsIEFwciAyNiwgMjAyMyBhdCAwMzowNDoxNVBN
ICswMjAwLCBUaG9tYXMgWmltbWVybWFubiB3cm90ZToNCj4+IEZiZGV2IHByb3ZpZGVzIGhl
bHBlcnMgZm9yIGZyYW1lYnVmZmVyIEkvTywgc3VjaCBhcyBmYl9yZWFkbCgpLA0KPj4gZmJf
d3JpdGVsKCkgb3IgZmJfbWVtY3B5X3RvX2ZiKCkuIFRoZSBpbXBsZW1lbnRhdGlvbiBvZiBl
YWNoIGhlbHBlcg0KPj4gZGVwZW5kcyBvbiB0aGUgYXJjaGl0ZWN0dXJlLiBJdCdzIHN0aWxs
IGFsbCBsb2NhdGVkIGluIGZiZGV2J3MgbWFpbg0KPj4gaGVhZGVyIGZpbGUgPGxpbnV4L2Zi
Lmg+LiBNb3ZlIGFsbCBvZiBpdCBpbnRvIGVhY2ggYXJjaHRlY3R1cmUncw0KPj4gPGFzbS9m
Yi5oPiwgd2l0aCBzaGFyZWQgY29kZSBpbiA8YXNtLWdlbmVyaWMvZmIuaD4uDQo+IA0KPiBG
b3Igb25jZSBJIHRoaW5rIHRoaXMgY2xlYW51cCBpcyBtb3ZpbmcgdGhpbmdzIGluIHRoZSB3
cm9uZyBkaXJlY3Rpb24uDQo+IA0KPiBUaGUgZmJfKiBoZWxwZXJzIHByZWRhdGVzIHRoZSBn
ZW5lcmljIGlvLmggc3VwcG9ydCBhbmQgdHJ5IHRvDQo+IGFkZCBhIGdlbmVyaWMgbGF5ZXIg
Zm9yIHJlYWQgcmVhZCAvIHdyaXRlIG9wZXJhdGlvbnMuDQo+IA0KPiBUaGUgcmlnaHQgZml4
IHdvdWxkIGJlIHRvIG1pZ3JhdGUgZmJfKiB0byB1c2UgdGhlIGlvIGhlbHBlcnMNCj4gd2Ug
aGF2ZSB0b2RheSAtIHNvIHdlIHVzZSB0aGUgZXhpc3Rpbmcgd2F5IHRvIGhhbmRsZSB0aGUg
YXJjaGl0ZWN0dXJlDQo+IHNwZWNpZmljIGRldGFpbHMuDQoNCkkgbG9va2VkIHRocm91Z2gg
dGhlIGV4aXN0aW5nIHZlcnNpb25zIG9mIHRoZSBmYl8oKSBJL08gaGVscGVycy4gVGhleSAN
CmNhbiBhcHBhcmVudGx5IGJlIGltcGxlbWVudGVkIHdpdGggdGhlIHJlZ3VsYXIgaGVscGVy
cyBvZiBzaW1pbGFyIG5hbWVzLg0KDQpJJ20gbm90IHN1cmUsIGJ1dCBldmVuIFNwYXJjIGxv
b2tzIGNvbXBhdGlibGUuIEF0IGxlYXN0IHRoZXNlIHNidXNfIA0KZnVuY3Rpb25zIHNlZW0g
dG8gYmUgZXF1aXZhbGVudCB0byB0aGUgX19yYXdfKCkgSS9PIGhlbHBlcnMgb2Ygc2ltaWxh
ciANCm5hbWVzLiBEbyB5b3Ugc3RpbGwgaGF2ZSB0aGF0IFNwYXJjIGVtdWxhdG9yPw0KDQo+
IA0KPiAgRnJvbSBhIHF1aWNrIGxvb2sgdGhlcmUgc2VlbXMgdG8gYmUgc29tZSBjaGFsbGVu
Z2VzIGJ1dCB0aGUgY3VycmVudA0KPiBoZWxwZXJzIHRoYXQgcmUtZG8gcGFydCBvZiBpby5o
IGlzIG5vdCB0aGUgd2F5IGZvcndhcmQgYW5kIGhpZGluZyB0aGVtDQo+IGluIGFyY2gvaW5j
bHVkZS9hc20vZmIuaCBzZWVtcyBjb3VudGVyIHByb2R1Y3RpdmUuDQoNCldoaWNoIGNoYWxs
ZW5nZXMgZGlkIHlvdSBzZWU/DQoNCkJlc3QgcmVnYXJkcw0KVGhvbWFzDQoNCj4gDQo+IAlT
YW0NCg0KLS0gDQpUaG9tYXMgWmltbWVybWFubg0KR3JhcGhpY3MgRHJpdmVyIERldmVsb3Bl
cg0KU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJIDQpGcmFua2Vuc3RyYXNz
ZSAxNDYsIDkwNDYxIE51ZXJuYmVyZywgR2VybWFueQ0KR0Y6IEl2byBUb3RldiwgQW5kcmV3
IE15ZXJzLCBBbmRyZXcgTWNEb25hbGQsIEJvdWRpZW4gTW9lcm1hbg0KSFJCIDM2ODA5IChB
RyBOdWVybmJlcmcpDQo=

--------------0BnAEdd7ws0JRInwI0tlF7W0--

--------------7Tnoo09B1y1bqPUqHSpN4Mqn
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmRKIscFAwAAAAAACgkQlh/E3EQov+CT
oBAA0joPCJExKZHc0py1Nmn46HLD2xkGXPqvlDNyOfv9K2WAzSvDzx5KShE1DzyUEcLTvhQfPm/D
5nQOnQrSn7HQkCIR4umRPp+nXP2coyxCHOnBIowCq2R5+j9pCCLIke3VDkTBCjo1S2FXNaWQ7akF
bWxfDg2rsatU/OkSba1nBa3LGj5JxZRa7DPQm4/HBXeL3WIuFiFEvklKelWui99NyANYaoXx7yoW
enEpmf+18GQR9FDziRZjTgETxW+/HXBqLC8vF6nuig1uqQ5TuuiT6/UomLXEdARPKkDKwq4Qg7Cq
CkIq8jsFYW3Caq7xfMmVfaz1zjSHoZ9Mc2hWnqzjSEbOgRRUpiwVVp0YmcHvr5ZkRma96jeAqXZx
YLGHYr6u7/jyNAKDs7rqsVHSwLHrrqNvIStQ0pZTt0yVI5f52dk2FhPeKqC3n3gjEVf5BwAk1gRx
lLlMhkoWTQBfkYZFtor/haDOuPrjOfKSgtU+mYD+SZVeRocMYVVqkRfvUyrZEH1yvOTYFZoK64aJ
aiKd4shbSRUdRhYx6kmwsKR35X4Ww+uXrVqOtdjMhMx0uZ7rzQCEVQ312EYW1a15koHLyAWNon2n
+UfEZE1yEvYWAqdUTcveIJ2B9Hv6jVjx1YO+vppl2GNVWBf8+ms8MW6DrPtR4AYx95gK46rcTnGM
IJY=
=bpnU
-----END PGP SIGNATURE-----

--------------7Tnoo09B1y1bqPUqHSpN4Mqn--
