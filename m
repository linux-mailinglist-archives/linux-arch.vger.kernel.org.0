Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E06E7AAA76
	for <lists+linux-arch@lfdr.de>; Fri, 22 Sep 2023 09:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjIVHlI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Sep 2023 03:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjIVHlI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Sep 2023 03:41:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B586195;
        Fri, 22 Sep 2023 00:40:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1DBF21F38A;
        Fri, 22 Sep 2023 07:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695368457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=UzGwVSjCR+yrFPQyulO5JFw6QA4KG0lIL/Ovv19nuW0=;
        b=q0wXyfa7VKohYeGvfMV9OwXzUerxqyyRSCMEIu1AzS19RbP/lgKdE7ADR1dJ7isHFduccz
        PzycuR8DqGEoR7jcaRRmhAq3eVAmpABLzw1f4WUVxPGZjjFt5KIirgAzQrGTEQILav7mHX
        FpBy6HejQqPlYiR3RMK4U9XHrXIWARM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695368457;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=UzGwVSjCR+yrFPQyulO5JFw6QA4KG0lIL/Ovv19nuW0=;
        b=HJ8cMoVH3n0b50SM9KRefgE3ppqzlQ/byNBIh3g6Nl8D+bOk8Xfbm5PcA1IZARyxgLy1iU
        rD+JOrvLST5UDGBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA34B13478;
        Fri, 22 Sep 2023 07:40:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id q1oJLAhFDWXuJAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 22 Sep 2023 07:40:56 +0000
Message-ID: <79b3dd76-7b3e-4be2-946a-6f20532f7ff8@suse.de>
Date:   Fri, 22 Sep 2023 09:40:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] fbdev: Avoid file argument in fb_pgprotect()
To:     Javier Martinez Canillas <javierm@redhat.com>, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, arnd@arndb.de,
        deller@gmx.de
Cc:     linux-arch@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-m68k@lists.linux-m68k.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20230912135050.17155-1-tzimmermann@suse.de>
 <20230912135050.17155-2-tzimmermann@suse.de>
 <87il85l1d4.fsf@minerva.mail-host-address-is-not-set>
Content-Language: en-US
From:   Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <87il85l1d4.fsf@minerva.mail-host-address-is-not-set>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------WWtw0AZdar3TECEKBCRy3XTn"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------WWtw0AZdar3TECEKBCRy3XTn
Content-Type: multipart/mixed; boundary="------------8JZrsftAebvYOCedOF8WyKJL";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Javier Martinez Canillas <javierm@redhat.com>, mpe@ellerman.id.au,
 npiggin@gmail.com, christophe.leroy@csgroup.eu, arnd@arndb.de, deller@gmx.de
Cc: linux-arch@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-m68k@lists.linux-m68k.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-ID: <79b3dd76-7b3e-4be2-946a-6f20532f7ff8@suse.de>
Subject: Re: [PATCH v4 1/5] fbdev: Avoid file argument in fb_pgprotect()
References: <20230912135050.17155-1-tzimmermann@suse.de>
 <20230912135050.17155-2-tzimmermann@suse.de>
 <87il85l1d4.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87il85l1d4.fsf@minerva.mail-host-address-is-not-set>

--------------8JZrsftAebvYOCedOF8WyKJL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgSmF2aWVyDQoNCkFtIDIwLjA5LjIzIHVtIDEwOjAxIHNjaHJpZWIgSmF2aWVyIE1hcnRp
bmV6IENhbmlsbGFzOg0KPiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5Ac3VzZS5k
ZT4gd3JpdGVzOg0KPiANCj4gSGVsbG8gVGhvbWFzLA0KPiANCj4+IE9ubHkgUG93ZXJQQydz
IGZiX3BncHJvdGVjdCgpIG5lZWRzIHRoZSBmaWxlIGFyZ3VtZW50LCBhbHRob3VnaA0KPj4g
dGhlIGltcGxlbWVudGF0aW9uIGRvZXMgbm90IHVzZSBpdC4gUGFzcyBOVUxMIHRvIHRoZSBp
bnRlcm5hbA0KPiANCj4gQ2FuIHlvdSBwbGVhc2UgbWVudGlvbiB0aGUgZnVuY3Rpb24gdGhh
dCdzIHRoZSBpbXBsZW1lbnRhdGlvbiBmb3INCg0KU3VyZQ0KDQo+IFBvd2VyUEMgPyBJZiBJ
J20gbG9va2luZyBhdCB0aGUgY29kZSBjb3JyZWN0bHksIHRoYXQgZnVuY3Rpb24gaXMNCj4g
cGh5c19tZW1fYWNjZXNzX3Byb3QoKSBkZWZpbmVkIGluIHRoZSBhcmNoL3Bvd2VycGMvbW0v
bWVtLmMgZmlsZToNCj4gDQo+IHBncHJvdF90IHBoeXNfbWVtX2FjY2Vzc19wcm90KHN0cnVj
dCBmaWxlICpmaWxlLCB1bnNpZ25lZCBsb25nIHBmbiwNCj4gCQkJICAgICAgdW5zaWduZWQg
bG9uZyBzaXplLCBwZ3Byb3RfdCB2bWFfcHJvdCkNCj4gew0KPiAJaWYgKHBwY19tZC5waHlz
X21lbV9hY2Nlc3NfcHJvdCkNCj4gCQlyZXR1cm4gcHBjX21kLnBoeXNfbWVtX2FjY2Vzc19w
cm90KGZpbGUsIHBmbiwgc2l6ZSwgdm1hX3Byb3QpOw0KPiANCj4gCWlmICghcGFnZV9pc19y
YW0ocGZuKSkNCj4gCQl2bWFfcHJvdCA9IHBncHJvdF9ub25jYWNoZWQodm1hX3Byb3QpOw0K
PiANCj4gCXJldHVybiB2bWFfcHJvdDsNCj4gfQ0KPiANCj4gYW5kIGlmIHNldCwgcHBjX21k
LnBoeXNfbWVtX2FjY2Vzc19wcm90IGlzIHBjaV9waHlzX21lbV9hY2Nlc3NfcHJvdCgpDQo+
IHRoYXQgaXMgZGVmaW5lZCBpbiB0aGUgYXJjaC9wb3dlcnBjL2tlcm5lbC9wY2ktY29tbW9u
LmMgc291cmNlIGZpbGU6DQo+IA0KPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51
eC92Ni42LXJjMi9zb3VyY2UvYXJjaC9wb3dlcnBjL2tlcm5lbC9wY2ktY29tbW9uLmMjTDUy
NA0KDQpZZXMsIHRoYXQncyBjb3JyZWN0LiBUaGUgb25seSB2YWx1ZSBmb3IgdGhhdCBmdW5j
dGlvbiBwb2ludGVyIGFwcGVhcnMgdG8gDQpiZSBwY2lfcGh5c19tZW1fYWNjZXNzX3Byb3Qo
KQ0KDQo+IA0KPiBUaGF0IGZ1bmN0aW9uIGluZGVlZCBkb2Vzbid0IHVzZSB0aGUgZmlsZSBh
cmd1bWVudC4gU28geW91ciBwYXRjaCBsb29rcw0KPiBjb3JyZWN0IHRvIG1lLg0KPiANCj4g
UmV2aWV3ZWQtYnk6IEphdmllciBNYXJ0aW5leiBDYW5pbGxhcyA8amF2aWVybUByZWRoYXQu
Y29tPg0KDQpUaGFua3MNCg0KQmVzdCByZWdhcmRzDQpUaG9tYXMNCg0KPiANCg0KLS0gDQpU
aG9tYXMgWmltbWVybWFubg0KR3JhcGhpY3MgRHJpdmVyIERldmVsb3Blcg0KU1VTRSBTb2Z0
d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJIDQpGcmFua2Vuc3RyYXNzZSAxNDYsIDkwNDYx
IE51ZXJuYmVyZywgR2VybWFueQ0KR0Y6IEl2byBUb3RldiwgQW5kcmV3IE15ZXJzLCBBbmRy
ZXcgTWNEb25hbGQsIEJvdWRpZW4gTW9lcm1hbg0KSFJCIDM2ODA5IChBRyBOdWVybmJlcmcp
DQo=

--------------8JZrsftAebvYOCedOF8WyKJL--

--------------WWtw0AZdar3TECEKBCRy3XTn
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmUNRQgFAwAAAAAACgkQlh/E3EQov+D1
wBAAkkU6MKDBuTUiaD5TKHmO7dXPKVu+AbeDL4Nke0dAJDVIT+UBb+vi1qxDQB8YYspeiMfvCzWG
cgvmtKC2LLNIvGbNIgSr3lxDRjIVhAMtz2vgO46C3YYKmC+2yvbkf1kpPqO/RshwRPGSq1MaL10P
945+zfGtItDzcX7eq3vaeyE+4NjnlHY4RAolQTyks2slRTKCEZ4yMhrf5gWegjGdLHWq+Z30mZht
1s3wXdSHhpo29wiBcIkPHWCJHbmVafC+xAfbjvCu5H4oK8Ftj5/Ina3RCDxC9p3UaZ+t326qCNjJ
nzWbrs4IP/eLt/tA3x0zfF914RJa8IobSscsWTWhM6Cth+vxh3h8P0IXgJAiU+T9WFTQL0beFmyq
aeDDx0UFVbD74FrgyETElnCygHLpuwt7SGRSAncJcYHIqxYgrqIZj5+3PjTz2TLyzCy2HVtEzLJe
c+aIxxt1A9DpBD2/FuoL2dnOg8wPHVDg1IW8eL5nnTI/H8V5APzplncFtAN+DFaKzU0Rh+hJX70O
AZkJze0bICeSTuN9EG6wVMzo7fY+jN9WcWoA64sUd92rLr9PicSDovOn4DQKDKRikp1HOMHwGz1A
U/VS8zMmskbqpUSuCDszZDUNJaP9DVC1GMZ2aJjiK3s0878gJNCOKxUyA/FgII+GJle1GwblCwJB
DOs=
=tnOC
-----END PGP SIGNATURE-----

--------------WWtw0AZdar3TECEKBCRy3XTn--
