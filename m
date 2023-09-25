Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153E37AD291
	for <lists+linux-arch@lfdr.de>; Mon, 25 Sep 2023 10:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjIYIA3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Sep 2023 04:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjIYIA2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Sep 2023 04:00:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CABB3;
        Mon, 25 Sep 2023 01:00:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CA1DF21865;
        Mon, 25 Sep 2023 08:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695628820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=qTH8gZm0MyF+kzuhQ5/fA+S+2mk5RISCXxaHsfjda/c=;
        b=uSF52ccaQX/M9MRz8Hsrj0NZSIQpyfqQD1exCWDsoYbHctNstAL8nRIP0CmCSOTeJjFx36
        yTva2QsV+dUpycPkUAR7RImWLXUG2V5eBVjw3xMbDJ9opazWxUhKEFoNKgxmyuHM2eoOCL
        fGVT86Gd8gSNmw8QDfnWr1DoRSK69JQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695628820;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=qTH8gZm0MyF+kzuhQ5/fA+S+2mk5RISCXxaHsfjda/c=;
        b=bmW6Dv6g5QP+NBQR3cSOYgwlpg/hB+arCL+klhUqA8AY/sv1UrxP6su7CWAWElsDAfBphA
        AtGzxu4d4HXC7IAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 84CC013A67;
        Mon, 25 Sep 2023 08:00:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3ABMHxQ+EWX5TQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 25 Sep 2023 08:00:20 +0000
Message-ID: <de09143e-ab7f-4ccc-8a5a-50e0f48c1b40@suse.de>
Date:   Mon, 25 Sep 2023 10:00:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] ppc, fbdev: Clean up fbdev mmap helper
Content-Language: en-US
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        arnd@arndb.de, deller@gmx.de, javierm@redhat.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, sparclinux@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org
References: <20230922080636.26762-1-tzimmermann@suse.de>
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
In-Reply-To: <20230922080636.26762-1-tzimmermann@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------q82hWMO8aTWh56X0j3GgJefx"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------q82hWMO8aTWh56X0j3GgJefx
Content-Type: multipart/mixed; boundary="------------Fluze0fCGK5ao12VH4rOtnGR";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
 arnd@arndb.de, deller@gmx.de, javierm@redhat.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org
Message-ID: <de09143e-ab7f-4ccc-8a5a-50e0f48c1b40@suse.de>
Subject: Re: [PATCH v5 0/5] ppc, fbdev: Clean up fbdev mmap helper
References: <20230922080636.26762-1-tzimmermann@suse.de>
In-Reply-To: <20230922080636.26762-1-tzimmermann@suse.de>

--------------Fluze0fCGK5ao12VH4rOtnGR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

RllJLCBJIGludGVudCB0byBtZXJnZSBwYXRjaGVzIDEgYW5kIDIgb2YgdGhpcyBwYXRjaHNl
dCBpbnRvIA0KZHJtLW1pc2MtbmV4dC4gVGhlIHVwZGF0ZXMgZm9yIFBvd2VyUEMgY2FuIGJl
IG1lcmdlZCB0aHJvdWdoIFBQQyB0cmVlcyANCmxhdGVyLiBMZXQgbWUga25vdyBpZiB0aGlz
IGRvZXMgbm90IHdvcmsgZm9yIHlvdS4NCg0KQmVzdCByZWdhcmRzDQpUaG9tYXMNCg0KQW0g
MjIuMDkuMjMgdW0gMTA6MDQgc2NocmllYiBUaG9tYXMgWmltbWVybWFubjoNCj4gQ2xlYW4g
dXAgYW5kIHJlbmFtZSBmYl9wZ3Byb3RlY3QoKSB0byB3b3JrIHdpdGhvdXQgc3RydWN0IGZp
bGUuIFRoZW4NCj4gcmVmYWN0b3IgdGhlIGltcGxlbWVudGF0aW9uIGZvciBQb3dlclBDLiBU
aGlzIGNoYW5nZSBoYXMgYmVlbiBkaXNjdXNzZWQNCj4gYXQgWzFdIGluIHRoZSBjb250ZXh0
IG9mIHJlZmFjdG9yaW5nIGZiZGV2J3MgbW1hcCBjb2RlLg0KPiANCj4gVGhlIGZpcnN0IHR3
byBwYXRjaGVzIHVwZGF0ZSBmYmRldiBhbmQgcmVwbGFjZSBmYmRldidzIGZiX3BncHJvdGVj
dCgpDQo+IHdpdGggcGdwcm90X2ZyYW1lYnVmZmVyKCkgb24gYWxsIGFyY2hpdGVjdHVyZXMu
IFRoZSBuZXcgaGVscGVyJ3Mgc3RyZWFtLQ0KPiBsaW5lZCBpbnRlcmZhY2UgZW5hYmxlcyBt
b3JlIHJlZmFjdG9yaW5nIHdpdGhpbiBmYmRldidzIG1tYXANCj4gaW1wbGVtZW50YXRpb24u
DQo+IA0KPiBQYXRjaGVzIDMgdG8gNSBhZGFwdCBQb3dlclBDJ3MgaW50ZXJuYWwgaW50ZXJm
YWNlcyB0byBwcm92aWRlDQo+IHBoeXNfbWVtX2FjY2Vzc19wcm90KCkgdGhhdCB3b3JrcyB3
aXRob3V0IHN0cnVjdCBmaWxlLiBOZWl0aGVyIHRoZQ0KPiBhcmNoaXRlY3R1cmUgY29kZSBv
ciBmYmRldiBoZWxwZXJzIG5lZWQgdGhlIHBhcmFtZXRlci4NCj4gDQo+IHY1Og0KPiAJKiBp
bXByb3ZlIGNvbW1pdCBkZXNjcmlwdGlvbnMgKEphdmllcikNCj4gCSogYWRkIG1pc3Npbmcg
dGFncyAoR2VlcnQpDQo+IHY0Og0KPiAJKiBmaXggY29tbWl0IG1lc3NhZ2UgKENocmlzdG9w
aGUpDQo+IHYzOg0KPiAJKiByZW5hbWUgZmJfcGdyb3RlY3QoKSB0byBwZ3Byb3RfZnJhbWVi
dWZmZXIoKSAoQXJuZCkNCj4gdjI6DQo+IAkqIHJlb3JkZXIgcGF0Y2hlcyB0byBzaW1wbGlm
eSBtZXJnaW5nIChNaWNoYWVsKQ0KPiANCj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xpbnV4cHBjLWRldi81NTAxYmE4MC1iZGIwLTYzNDQtMTZiMC0wNDY2YTk1MGY4MmNAc3Vz
ZS5jb20vDQo+IA0KPiBUaG9tYXMgWmltbWVybWFubiAoNSk6DQo+ICAgIGZiZGV2OiBBdm9p
ZCBmaWxlIGFyZ3VtZW50IGluIGZiX3BncHJvdGVjdCgpDQo+ICAgIGZiZGV2OiBSZXBsYWNl
IGZiX3BncHJvdGVjdCgpIHdpdGggcGdwcm90X2ZyYW1lYnVmZmVyKCkNCj4gICAgYXJjaC9w
b3dlcnBjOiBSZW1vdmUgdHJhaWxpbmcgd2hpdGVzcGFjZXMNCj4gICAgYXJjaC9wb3dlcnBj
OiBSZW1vdmUgZmlsZSBwYXJhbWV0ZXIgZnJvbSBwaHlzX21lbV9hY2Nlc3NfcHJvdCBjb2Rl
DQo+ICAgIGFyY2gvcG93ZXJwYzogQ2FsbCBpbnRlcm5hbCBfX3BoeXNfbWVtX2FjY2Vzc19w
cm90KCkgaW4gZmJkZXYgY29kZQ0KPiANCj4gICBhcmNoL2lhNjQvaW5jbHVkZS9hc20vZmIu
aCAgICAgICAgICAgICAgICB8IDE1ICsrKysrKystLS0tLS0tLQ0KPiAgIGFyY2gvbTY4ay9p
bmNsdWRlL2FzbS9mYi5oICAgICAgICAgICAgICAgIHwgMTkgKysrKysrKysrKy0tLS0tLS0t
LQ0KPiAgIGFyY2gvbWlwcy9pbmNsdWRlL2FzbS9mYi5oICAgICAgICAgICAgICAgIHwgMTEg
KysrKystLS0tLS0NCj4gICBhcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vYm9vazNzL3BndGFi
bGUuaCB8IDEwICsrKysrKysrLS0NCj4gICBhcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vZmIu
aCAgICAgICAgICAgICB8IDEzICsrKysrLS0tLS0tLS0NCj4gICBhcmNoL3Bvd2VycGMvaW5j
bHVkZS9hc20vbWFjaGRlcC5oICAgICAgICB8IDEzICsrKysrKy0tLS0tLS0NCj4gICBhcmNo
L3Bvd2VycGMvaW5jbHVkZS9hc20vbm9oYXNoL3BndGFibGUuaCB8IDEwICsrKysrKysrLS0N
Cj4gICBhcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vcGNpLmggICAgICAgICAgICB8ICA0ICst
LS0NCj4gICBhcmNoL3Bvd2VycGMva2VybmVsL3BjaS1jb21tb24uYyAgICAgICAgICB8ICAz
ICstLQ0KPiAgIGFyY2gvcG93ZXJwYy9tbS9tZW0uYyAgICAgICAgICAgICAgICAgICAgIHwg
IDggKysrKy0tLS0NCj4gICBhcmNoL3NwYXJjL2luY2x1ZGUvYXNtL2ZiLmggICAgICAgICAg
ICAgICB8IDE1ICsrKysrKysrKy0tLS0tLQ0KPiAgIGFyY2gveDg2L2luY2x1ZGUvYXNtL2Zi
LmggICAgICAgICAgICAgICAgIHwgMTAgKysrKysrLS0tLQ0KPiAgIGFyY2gveDg2L3ZpZGVv
L2ZiZGV2LmMgICAgICAgICAgICAgICAgICAgIHwgMTUgKysrKysrKystLS0tLS0tDQo+ICAg
ZHJpdmVycy92aWRlby9mYmRldi9jb3JlL2ZiX2NocmRldi5jICAgICAgfCAgMyArKy0NCj4g
ICBpbmNsdWRlL2FzbS1nZW5lcmljL2ZiLmggICAgICAgICAgICAgICAgICB8IDEyICsrKysr
Ky0tLS0tLQ0KPiAgIDE1IGZpbGVzIGNoYW5nZWQsIDg2IGluc2VydGlvbnMoKyksIDc1IGRl
bGV0aW9ucygtKQ0KPiANCj4gDQo+IGJhc2UtY29tbWl0OiBmOGQyMWNiMTdhOTliNzU4NjIx
OTYwMzZiYjRiYjkzZWU5NjM3Yjc0DQoNCi0tIA0KVGhvbWFzIFppbW1lcm1hbm4NCkdyYXBo
aWNzIERyaXZlciBEZXZlbG9wZXINClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkg
R21iSA0KRnJhbmtlbnN0cmFzc2UgMTQ2LCA5MDQ2MSBOdWVybmJlcmcsIEdlcm1hbnkNCkdG
OiBJdm8gVG90ZXYsIEFuZHJldyBNeWVycywgQW5kcmV3IE1jRG9uYWxkLCBCb3VkaWVuIE1v
ZXJtYW4NCkhSQiAzNjgwOSAoQUcgTnVlcm5iZXJnKQ0K

--------------Fluze0fCGK5ao12VH4rOtnGR--

--------------q82hWMO8aTWh56X0j3GgJefx
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmURPhQFAwAAAAAACgkQlh/E3EQov+Bx
2Q//SqO8b2GRtxEIaJ3wV0O6yIScRYeHaRTeKGsBfTNJL8MJZBQvrpqHh/k0SfZzan1OHmk+BcDl
V4cUUn2PU5cx53XW0YAXXZWmsxGDDvgP8wnG9caJ3n2yzAAsXHU0L53/o6X9vir2jtM0mCwaSn0i
rXX097++MnsvKGpvIA8pwzHXOYMeHFTT/65WDzdQJUlZ5Gd/dtalp4Gs0k7aNtITW/6GBkBMM3pY
Vr3KVGIaWfsYcjtrFAApWgh3ztR10RBxCVsI0Pq5hVDIxoehv4YBHUU1VXqMa2FPXx/Ykl8xKdpb
BEdn540KUUvgbZEGKifaSHpwOcB/KATjnPAHITXTmycF/4lXZfYfY6fSy8awBOAIin2oWvbdvKOU
ZJpqprGwG2Iau61ukxqOtp79uEnwaHAL6E1j0XPKyLufxTlIzxPO1FwshsApmacuHU8GAfgFW6rX
YEgwCTy3dUX78ZJLkjvGcR/Nd/S6nYNxMwyEsyXiZgJoJxtdmTaldXZ+yx6R3Ww73kLK0jHVTp1p
bc//mLihQyzThV3APmse9d6bt4m53672cAdQFe1BPq9bjJECS256w/Z1rzAKKY/xSfzBtiCDXwuf
ELOsnzXEAwhnw6rR6ADPWVCJgfrU76H2HiZVTAdW+Kuf3B9WbiuIIEbjhfXihe6e96s/fCPzl1/Q
CQQ=
=u3tQ
-----END PGP SIGNATURE-----

--------------q82hWMO8aTWh56X0j3GgJefx--
