Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D105C6F52EC
	for <lists+linux-arch@lfdr.de>; Wed,  3 May 2023 10:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjECIPx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 May 2023 04:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjECIPw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 May 2023 04:15:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B035BE74;
        Wed,  3 May 2023 01:15:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 39EE42243F;
        Wed,  3 May 2023 08:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683101747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VW0FfpZ5EtETq7yCOkYo+qlix2ZyBUBojsHtq2hd8TA=;
        b=MuQvChSfA2IDS6S05iNDyQyZ2a6O9gkfCvfv/juDEp+/JjYfCXaw5aRdllBqtORd4w0lvH
        MMpF1p0h+HksQzidlVaG1vTBVkrGE6k5WfrGi9yOZqvMjIqK0X/anK3bUtV69XdPDWSyzT
        ktL7D5G363WQJN2rFiox3mUujejjMqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683101747;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VW0FfpZ5EtETq7yCOkYo+qlix2ZyBUBojsHtq2hd8TA=;
        b=FhwTHUpLesjcxw7yI5n/tkbaRQvucKeGimE41tUf5EiJbg1iyL+bNuq0pfbzjRTqSeLlA+
        R9NJc45dKlBxqIAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF39413584;
        Wed,  3 May 2023 08:15:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id m070LDIYUmQ/aQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 03 May 2023 08:15:46 +0000
Message-ID: <828664d0-3562-56cc-019d-1bb8a55826b5@suse.de>
Date:   Wed, 3 May 2023 10:15:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 6/6] fbdev: Rename fb_mem*() helpers
Content-Language: en-US
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
References: <20230502130223.14719-1-tzimmermann@suse.de>
 <20230502130223.14719-7-tzimmermann@suse.de>
 <20230502200813.GC319489@ravnborg.org>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20230502200813.GC319489@ravnborg.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Yg2pS7gKZkskFTz8vk2lKAPH"
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Yg2pS7gKZkskFTz8vk2lKAPH
Content-Type: multipart/mixed; boundary="------------v700H0v7Hs7IzDa1ExtAP020";
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
Message-ID: <828664d0-3562-56cc-019d-1bb8a55826b5@suse.de>
Subject: Re: [PATCH v3 6/6] fbdev: Rename fb_mem*() helpers
References: <20230502130223.14719-1-tzimmermann@suse.de>
 <20230502130223.14719-7-tzimmermann@suse.de>
 <20230502200813.GC319489@ravnborg.org>
In-Reply-To: <20230502200813.GC319489@ravnborg.org>

--------------v700H0v7Hs7IzDa1ExtAP020
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMDIuMDUuMjMgdW0gMjI6MDggc2NocmllYiBTYW0gUmF2bmJvcmc6DQo+IEhp
IFRob21hcy4NCj4gDQo+IE9uIFR1ZSwgTWF5IDAyLCAyMDIzIGF0IDAzOjAyOjIzUE0gKzAy
MDAsIFRob21hcyBaaW1tZXJtYW5uIHdyb3RlOg0KPj4gVXBkYXRlIHRoZSBuYW1lcyBvZiB0
aGUgZmJfbWVtKigpIGhlbHBlcnMgdG8gYmUgY29uc2lzdGVudCB3aXRoIHRoZWlyDQo+PiBy
ZWd1bGFyIGNvdW50ZXJwYXJ0cy4gSGVuY2UsIGZiX21lbXNldCgpIG5vdyBiZWNvbWVzIGZi
X21lbXNldF9pbygpLA0KPj4gZmJfbWVtY3B5X2Zyb21mYigpIG5vdyBiZWNvbWVzIGZiX21l
bWNweV9mcm9taW8oKSBhbmQgZmJfbWVtY3B5X3RvZmIoKQ0KPj4gYmVjb21lcyBmYl9tZW1j
cHlfdG9pbygpLiBObyBmdW5jdGlvbmFsIGNoYW5nZXMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1i
eTogVGhvbWFzIFppbW1lcm1hbm4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+DQo+PiAtLS0NCj4g
Li4uDQo+PiAgIA0KPj4gLSNpZm5kZWYgZmJfbWVtY3B5X2Zyb21mYg0KPj4gLXN0YXRpYyBp
bmxpbmUgdm9pZCBmYl9tZW1jcHlfZnJvbWZiKHZvaWQgKnRvLCBjb25zdCB2b2xhdGlsZSB2
b2lkIF9faW9tZW0gKmZyb20sIHNpemVfdCBuKQ0KPj4gKyNpZm5kZWYgZmJfbWVtY3B5X2Zy
b21pbw0KPj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBmYl9tZW1jcHlfZnJvbWlvKHZvaWQgKnRv
LCBjb25zdCB2b2xhdGlsZSB2b2lkIF9faW9tZW0gKmZyb20sIHNpemVfdCBuKQ0KPj4gICB7
DQo+PiAgIAltZW1jcHlfZnJvbWlvKHRvLCBmcm9tLCBuKTsNCj4+ICAgfQ0KPj4gLSNkZWZp
bmUgZmJfbWVtY3B5X2Zyb21mYiBmYl9tZW1jcHlfZnJvbWZiDQo+PiArI2RlZmluZSBmYl9t
ZW1jcHlfZnJvbWlvIGZiX21lbWNweV9mcm9taW8NCj4+ICAgI2VuZGlmDQo+PiAgIA0KPj4g
LSNpZm5kZWYgZmJfbWVtY3B5X3RvZmINCj4+IC1zdGF0aWMgaW5saW5lIHZvaWQgZmJfbWVt
Y3B5X3RvZmIodm9sYXRpbGUgdm9pZCBfX2lvbWVtICp0bywgY29uc3Qgdm9pZCAqZnJvbSwg
c2l6ZV90IG4pDQo+PiArI2lmbmRlZiBmYl9tZW1jcHlfdG9pbw0KPj4gK3N0YXRpYyBpbmxp
bmUgdm9pZCBmYl9tZW1jcHlfdG9pbyh2b2xhdGlsZSB2b2lkIF9faW9tZW0gKnRvLCBjb25z
dCB2b2lkICpmcm9tLCBzaXplX3QgbikNCj4+ICAgew0KPj4gICAJbWVtY3B5X3RvaW8odG8s
IGZyb20sIG4pOw0KPj4gICB9DQo+PiAtI2RlZmluZSBmYl9tZW1jcHlfdG9mYiBmYl9tZW1j
cHlfdG9mYg0KPj4gKyNkZWZpbmUgZmJfbWVtY3B5X3RvaW8gZmJfbWVtY3B5X3RvaW8NCj4+
ICAgI2VuZGlmDQo+PiAgIA0KPj4gICAjaWZuZGVmIGZiX21lbXNldA0KPj4gLXN0YXRpYyBp
bmxpbmUgdm9pZCBmYl9tZW1zZXQodm9sYXRpbGUgdm9pZCBfX2lvbWVtICphZGRyLCBpbnQg
Yywgc2l6ZV90IG4pDQo+PiArc3RhdGljIGlubGluZSB2b2lkIGZiX21lbXNldF9pbyh2b2xh
dGlsZSB2b2lkIF9faW9tZW0gKmFkZHIsIGludCBjLCBzaXplX3QgbikNCj4+ICAgew0KPj4g
ICAJbWVtc2V0X2lvKGFkZHIsIGMsIG4pOw0KPj4gICB9DQo+PiAtI2RlZmluZSBmYl9tZW1z
ZXQgZmJfbWVtc2V0DQo+PiArI2RlZmluZSBmYl9tZW1zZXQgZmJfbWVtc2V0X2lvDQo+IA0K
PiBUaGUgc3RhdGljIGlubGluZXMgd3JhcHBlcnMgZG9lcyBub3QgcHJvdmlkZSBhbnkgdmFs
dWUsIGFuZCBjb3VsZCBiZSByZXBsYWNlZCBieQ0KPiBkaXJlY3QgY2FsbHMgdG8gbWVtY3B5
X2Zyb21pbygpLCBtZW1jcHlfdG9pbygpLCBtZW1zZXRfaW8oKS4NCj4gDQo+IElmIHlvdSBk
ZWNpZGUgdG8ga2VlcCB0aGUgd3JhcHBlcnMgSSB3aWxsIG5vdCBob2xkIHlvdSBiYWNrLCBz
byB0aGUNCj4gcGF0Y2ggaGFzIG15Og0KPiBSZXZpZXdlZC1ieTogU2FtIFJhdm5ib3JnIDxz
YW1AcmF2bmJvcmcub3JnPg0KPiANCj4gQnV0IEkgcHJlZmVyIHRoZSBkaXJlY3QgY2FsbHMg
d2l0aG91dCB0aGUgd3JhcHBlcnMuLi4uDQoNCkF0IGZpcnN0IEkgd2FzIGFsc28gc2tlcHRp
Y2FsIGlmIHRob3NlIGZiX21lbSooKSB3cmFwcGVycyBhcmUgbmVlZGVkLiANCkJ1dCBBcm5k
IG1lbnRpb25lZCB0aGF0IHRoZXJlIGFyZSBzdWJ0bGUgZGlmZmVyZW5jZXMgYmV0d2VlbiB0
aGUgY3VycmVudCANCmNvZGUgYW5kIExpbnV4JyBtZW0qX2lvKCkgZnVuY3Rpb25zLiBLZWVw
aW5nIHRoZSB3cmFwcGVycyBtaWdodCBiZSBuZWVkZWQuDQoNCkJlc3QgcmVnYXJkcw0KVGhv
bWFzDQoNCj4gDQo+IAlTYW0NCg0KLS0gDQpUaG9tYXMgWmltbWVybWFubg0KR3JhcGhpY3Mg
RHJpdmVyIERldmVsb3Blcg0KU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJI
DQpGcmFua2Vuc3RyYXNzZSAxNDYsIDkwNDYxIE51ZXJuYmVyZywgR2VybWFueQ0KR0Y6IEl2
byBUb3RldiwgQW5kcmV3IE15ZXJzLCBBbmRyZXcgTWNEb25hbGQsIEJvdWRpZW4gTW9lcm1h
bg0KSFJCIDM2ODA5IChBRyBOdWVybmJlcmcpDQo=

--------------v700H0v7Hs7IzDa1ExtAP020--

--------------Yg2pS7gKZkskFTz8vk2lKAPH
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmRSGDIFAwAAAAAACgkQlh/E3EQov+DQ
UxAAyalpNZAKb+SrH+ZBEi1COJSY+VhSOQs2gPTxEyeIhMZ0BQ9iD4lt7OQZS8FeatCbVejmWfb1
/4M6l90NWRpBa5fqGNqjh0dysWlKrAbogUPoA9yp3TAh3pmOEj0zlqMD3QngLS6HvcQt71O5fjSB
dM3nUOXtaLEMc7wPPXigGONwageohdTlo4qQd0XRzp/XhMVCfdLlI/xKPMnTpUbsrQQec4CzdIiq
zHRQfUJBh4NZmh6JhywwduXSyr2FyA+i8DGLCLCosfVes3lbNm3lPDMfXH8kR/auMzC/x4WnZ7gG
WoEKOCGTmgPvi2YCfhbEDyW/l4+2Dm66KDdYEPNR+XCGJ61g//44HJy2DcrDthjPN/LnxJPMyJMm
DYKyTdGWT7xOXyn/hTDEweo12E75EX6BoQuhEDpZ905S13BoKwKYuyHii6Sa6Ht8wBNtScDQzGFW
E9Oa7tjJZSQJAWP2RyeG2LGu9P0K+uEMu15hGlo3gJUUxevTITb9QWoBns1Ij9JPSGU/Vse/l6Ho
8ncA2bhhIC18Yl4tOilWtsckgmDCInIrgwlMrfEEiWJ00HU989oGKLzbPGb4xxKTKreJOrbDHuRb
ooiLu0shYcBWKEG9B9cwiF4+nHb8BEWEFMpu0X1sOpoIvBs2WGQPIGsIX1gy1+WkDa6+ZpCu3MMx
fqo=
=YD1+
-----END PGP SIGNATURE-----

--------------Yg2pS7gKZkskFTz8vk2lKAPH--
