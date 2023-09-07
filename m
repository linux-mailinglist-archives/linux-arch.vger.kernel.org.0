Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB693797912
	for <lists+linux-arch@lfdr.de>; Thu,  7 Sep 2023 19:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239559AbjIGRBN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Sep 2023 13:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241011AbjIGRAz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Sep 2023 13:00:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B1B1FD4;
        Thu,  7 Sep 2023 10:00:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 718DC1F894;
        Thu,  7 Sep 2023 06:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694069356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tmj3YHu3EiPuUc2HxOOZqAmbdUq5Gwk17anV60bvF+8=;
        b=yU5vier603aXq694itOfrhcjO0QSHPRLF/lueeHBJRSFUC3ta/5WKm18iCH7aRInx50Y+P
        dlMhxITKyHPvX7XYfZO1ZbjPB2vCg0rpYfZ3c3LfWzbuYpPHxgIL6/rmdCV96ZMwIYptlc
        2oKsah8Sk+Q1z216oGZcPV1/w+fHjzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694069356;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tmj3YHu3EiPuUc2HxOOZqAmbdUq5Gwk17anV60bvF+8=;
        b=iW1d0smaEK2EyWUqniHZl4q0Puf5OimB6EzUPBXkH3k0urRlYwtK2wxMIBgTEFdPvs65/2
        9I7N9s+LaZpvbcCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2DBCA1358B;
        Thu,  7 Sep 2023 06:49:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DNAbCmxy+WTFegAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 07 Sep 2023 06:49:16 +0000
Message-ID: <fc126f04-64f1-3403-2e12-54c723c68855@suse.de>
Date:   Thu, 7 Sep 2023 08:49:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 2/5] fbdev: Replace fb_pgprotect() with
 fb_pgprot_device()
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Helge Deller <deller@gmx.de>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, sparclinux@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Linux-Arch <linux-arch@vger.kernel.org>
References: <20230906144801.25297-1-tzimmermann@suse.de>
 <20230906144801.25297-3-tzimmermann@suse.de>
 <8865aa0a-ec40-41ca-a77e-9172cec49f07@app.fastmail.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <8865aa0a-ec40-41ca-a77e-9172cec49f07@app.fastmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------TEh4cvhQbs1k527ukntUhmr1"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------TEh4cvhQbs1k527ukntUhmr1
Content-Type: multipart/mixed; boundary="------------LMUVyb40kina8IJoOFeFeOP2";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Helge Deller <deller@gmx.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Linux-Arch <linux-arch@vger.kernel.org>
Message-ID: <fc126f04-64f1-3403-2e12-54c723c68855@suse.de>
Subject: Re: [PATCH v2 2/5] fbdev: Replace fb_pgprotect() with
 fb_pgprot_device()
References: <20230906144801.25297-1-tzimmermann@suse.de>
 <20230906144801.25297-3-tzimmermann@suse.de>
 <8865aa0a-ec40-41ca-a77e-9172cec49f07@app.fastmail.com>
In-Reply-To: <8865aa0a-ec40-41ca-a77e-9172cec49f07@app.fastmail.com>

--------------LMUVyb40kina8IJoOFeFeOP2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgQXJuZA0KDQpBbSAwNi4wOS4yMyB1bSAyMTo1MyBzY2hyaWViIEFybmQgQmVyZ21hbm46
DQo+IE9uIFdlZCwgU2VwIDYsIDIwMjMsIGF0IDEwOjM1LCBUaG9tYXMgWmltbWVybWFubiB3
cm90ZToNCj4+IFJlbmFtZSB0aGUgZmJkZXYgbW1hcCBoZWxwZXIgZmJfcGdwcm90ZWN0KCkg
dG8gZmJfcGdwcm90X2RldmljZSgpLg0KPj4gVGhlIGhlbHBlciBzZXRzIFZNQSBwYWdlLWFj
Y2VzcyBmbGFncyBmb3IgZnJhbWVidWZmZXJzIGluIGRldmljZSBJL08NCj4+IG1lbW9yeS4g
VGhlIG5ldyBuYW1lIGZvbGxvd3MgcGdwcm90X2RldmljZSgpLCB3aGljaCBkb2VzIHRoZSBz
YW1lIGZvcg0KPj4gYXJiaXRyYXJ5IGRldmljZXMuDQo+Pg0KPj4gQWxzbyBjbGVhbiB1cCB0
aGUgaGVscGVyJ3MgcGFyYW1ldGVycyBhbmQgcmV0dXJuIHZhbHVlLiBJbnN0ZWFkIG9mDQo+
PiB0aGUgVk1BIGluc3RhbmNlLCBwYXNzIHRoZSBpbmRpdmlkaWFsIHBhcmFtZXRlcnMgc2Vw
YXJhdGVseTogZXhpc3RpbmcNCj4+IHBhZ2UtYWNjZXNzIGZsYWdzLCB0aGUgVk1BcyBzdGFy
dCBhbmQgZW5kIGFkZHJlc3NlcyBhbmQgdGhlIG9mZnNldA0KPj4gaW4gdGhlIHVuZGVybHlp
bmcgZGV2aWNlIG1lbW9yeSByc3AgZmlsZS4gUmV0dXJuIHRoZSBuZXcgcGFnZS1hY2Nlc3MN
Cj4+IGZsYWdzLiBUaGVzZSBjaGFuZ2VzIGFsaWduIGZiX3BncHJvdF9kZXZpY2UoKSBjbG9z
ZXIgd2l0aCBwZ3Byb3RfZGV2aWNlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFRob21hcyBa
aW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPg0KPiANCj4gVGhpcyBtYWtlcyBzZW5z
ZSBhcyBhIGNsZWFudXAsIGJ1dCBJJ20gbm90IHN1cmUgdGhlIG5ldyBuYW1pbmcgaXMgaGVs
cGZ1bC4NCj4gDQo+IFRoZSAncGdwcm90X2RldmljZScgcGVybWlzc2lvbnMgYXJlIGJhc2Vk
IG9uIEFybSdzIG1lbW9yeSBhdHRyaWJ1dGVzLA0KPiB3aGljaCBoYXZlIHNsaWdodGx5IGRp
ZmZlcmVudCBiZWhhdmlvciBmb3IgImRldmljZSIsICJ1bmNhY2hlZCIgYW5kDQo+ICJ3cml0
ZWNvbWJpbmUiIG1hcHBpbmdzLiBJIHRoaW5rIHNpbXBseSBjYWxsaW5nIHRoaXMgb25lIHBn
cHJvdF9mYigpDQo+IG9yIGZiX3BncHJvdCgpIHdvdWxkIGJlIGxlc3MgY29uZnVzaW5nLCBz
aW5jZSBkZXBlbmRpbmcgb24gdGhlIGFyY2hpdGVjdHVyZQ0KPiBpdCBhcHBlYXJzIHRvIGdp
dmUgZWl0aGVyIHVuY2FjaGVkIG9yIHdyaXRlY29tYmluZSBtYXBwaW5ncyBidXQgbm90DQo+
ICJkZXZpY2UiIG9uIHRoZSBhcmNoaXRlY3R1cmVzIHdoZXJlIHRoaXMgaXMgZGlmZmVyZW50
Lg0KDQpJIHNlZS4gVGhhbmtzIGZvciB0aGUgaW5mby4gSSBsaWtlIHBncHJvdF9mYigpIG1h
eWJlIA0KcGdwcm90X2ZyYW1lYnVmZmVyKCkuIEknbGwgdXBkYXRlIHRoZSBwYXRjaHNldC4N
Cg0KT25lIHRoaW5nIEkndmUgYmVlbiB3b25kZXJpbmcgaXMgd2hldGhlciBJIHNob3VsZCBh
dHRlbXB0IHRvIGludGVncmF0ZSANCnRoZSBoZWxwZXJzIGluIDxhc20vZmIuaD4gaW4gdGhl
IHJlZ3VsYXIgYXNtIGhlYWRlcnMuIFNvIHRoZSBwZ3Byb3QgY29kZSANCndvdWxkIGdvIGlu
dG8gcGd0YWJsZS5oLCB0aGUgSS9PIGZ1bmN0aW9ucyB3b3VsZCBnbyBpbnRvIGlvLmguIFRo
ZSBJL08gDQpmdW5jdGlvbnMgY291bGQgdGhlbiBiZSBjYWxsZWQgcmVhZGJfZmIoKSwgd3Jp
dGVsX2ZiKCksIG1lbWNweV90b2ZiKCkgDQphbmQgc28gb24uIFdvdWxkIHlvdSBwcmVmZXIg
dGhhdCBvciByYXRoZXIgbm90Pw0KDQpCZXN0IHJlZ2FyZHMNClRob21hcw0KDQo+IA0KPiAg
ICAgICAgQXJuZA0KDQotLSANClRob21hcyBaaW1tZXJtYW5uDQpHcmFwaGljcyBEcml2ZXIg
RGV2ZWxvcGVyDQpTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgNCkZyYW5r
ZW5zdHJhc3NlIDE0NiwgOTA0NjEgTnVlcm5iZXJnLCBHZXJtYW55DQpHRjogSXZvIFRvdGV2
LCBBbmRyZXcgTXllcnMsIEFuZHJldyBNY0RvbmFsZCwgQm91ZGllbiBNb2VybWFuDQpIUkIg
MzY4MDkgKEFHIE51ZXJuYmVyZykNCg==

--------------LMUVyb40kina8IJoOFeFeOP2--

--------------TEh4cvhQbs1k527ukntUhmr1
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmT5cmsFAwAAAAAACgkQlh/E3EQov+AQ
9hAAnu8YqJbF8kuGEVKqu7BhEZrJ9Yg8lVBP8+c6r7PW6z5NYHSXwtGmySIopyd4c4C6RiUDOq0f
gI96wa8Ze85a2vVyPMg0vAJxt94DgCURK37L+tMo/jgRP5uTUuRNwSEYURjpsMT4Zbjc1jNgz5b4
CP7SZuXBRIj8JAP/SPbpHoo+j8m3PNLcpEZjlk+H81zy7s4kLFftw3bBaB6Lu8TBfYCFKIwuGmjJ
p55XdNWIbj8q8S6Hhh5DN2lFf6qz7p1DRysLVL8q0dtoyXifftoxU8C7baO0/IM2do6tbNucY+9U
WJRa+UkMasd314eJ4H+F9oSbKG2hrRJAv98eg1Wbf/+VRylJCYa5HsdHHWCGAoBtxUuK1HqarqvF
Rrqw/Zt1qsEKHNzlzzq9Qlm15+9n5z6FnbXJgUzkApr20orOHu2DLf9FkUNGDOmykOQfNfWC+I0k
x5dEx6KxgKUhekd4Q8kiaT/EeqMOV+F31TvezVRo9VuM9uRH2WqtH3LS+9T+NzNQx/+aG9WdrcVM
cWPvt+RifTXdXPhpZA6pKAOe049mKxkdC6iQp0A9L1YB4QP6iNYgR7wqVvQunMCfoQPJcIo9n4aL
MmcPjtLmozw7BV3fBCeMuWrk41msZ7qbrAyvOrDuMjQtnYMp6cEeLZOcUHk96uZze9DH8vxZat0Q
FY4=
=9dZp
-----END PGP SIGNATURE-----

--------------TEh4cvhQbs1k527ukntUhmr1--
