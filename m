Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E7179AFA5
	for <lists+linux-arch@lfdr.de>; Tue, 12 Sep 2023 01:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238056AbjIKVGS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Sep 2023 17:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239772AbjIKO2U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Sep 2023 10:28:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98599CF0;
        Mon, 11 Sep 2023 07:28:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 67C2421846;
        Mon, 11 Sep 2023 14:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694442493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=DxxA77i6Js4DK2nswQ7o2txnNvzTWjf3yx7T37E1lq0=;
        b=MpELdkRlwCZa+F1REJdd7NhDHaizBI1aSYnlzLwAD9mUvUVweS50uJb+rY+rOqQiyFVaK2
        PHfTUzQhSHcP84eRKqUDbhyt5GtDetMpX2qCKBRED/LGWOJpSz74v02MwObIPWDoFrJrpb
        gfWP7nMY4PFhzb6o/b+xF3v1KiHNbFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694442493;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=DxxA77i6Js4DK2nswQ7o2txnNvzTWjf3yx7T37E1lq0=;
        b=fZ9+ZKGfuLJg6ikbfl3Lwy8x4ukJphONoPWB91BVS+1Y3knf2iKpmt1Ltvv1MRXBsj2cM+
        c6XW8hphgVhdnEAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0F1C0139CC;
        Mon, 11 Sep 2023 14:28:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nN+vOvwj/2R7SwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 11 Sep 2023 14:28:12 +0000
Message-ID: <20b77eb3-5761-4346-910b-5dd67aa4076c@suse.de>
Date:   Mon, 11 Sep 2023 16:28:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] fbdev: Replace fb_pgprotect() with
 fb_pgprot_device()
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "deller@gmx.de" <deller@gmx.de>
Cc:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <20230911131033.27745-1-tzimmermann@suse.de>
 <20230911131033.27745-3-tzimmermann@suse.de>
 <1fac068f-f13c-71f4-c9bb-bb331d2d1c04@csgroup.eu>
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
In-Reply-To: <1fac068f-f13c-71f4-c9bb-bb331d2d1c04@csgroup.eu>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------1WabY0iBOmscdR6st3k4e1C8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------1WabY0iBOmscdR6st3k4e1C8
Content-Type: multipart/mixed; boundary="------------2f6NCVgzHZqf4xSBalWnsyhb";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "npiggin@gmail.com" <npiggin@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "deller@gmx.de" <deller@gmx.de>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Message-ID: <20b77eb3-5761-4346-910b-5dd67aa4076c@suse.de>
Subject: Re: [PATCH v3 2/5] fbdev: Replace fb_pgprotect() with
 fb_pgprot_device()
References: <20230911131033.27745-1-tzimmermann@suse.de>
 <20230911131033.27745-3-tzimmermann@suse.de>
 <1fac068f-f13c-71f4-c9bb-bb331d2d1c04@csgroup.eu>
In-Reply-To: <1fac068f-f13c-71f4-c9bb-bb331d2d1c04@csgroup.eu>

--------------2f6NCVgzHZqf4xSBalWnsyhb
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCkFtIDExLjA5LjIzIHVtIDE2OjE5IHNjaHJpZWIgQ2hyaXN0b3BoZSBMZXJveToNCj4g
DQo+IExlIDExLzA5LzIwMjMgw6AgMTU6MDgsIFRob21hcyBaaW1tZXJtYW5uIGEgw6ljcml0
wqA6DQo+PiBSZW5hbWUgdGhlIGZiZGV2IG1tYXAgaGVscGVyIGZiX3BncHJvdGVjdCgpIHRv
IHBncHJvdF9mcmFtZWJ1ZmZlcigpLg0KPj4gVGhlIGhlbHBlciBzZXRzIFZNQSBwYWdlLWFj
Y2VzcyBmbGFncyBmb3IgZnJhbWVidWZmZXJzIGluIGRldmljZSBJL08NCj4+IG1lbW9yeS4N
Cj4+DQo+PiBBbHNvIGNsZWFuIHVwIHRoZSBoZWxwZXIncyBwYXJhbWV0ZXJzIGFuZCByZXR1
cm4gdmFsdWUuIEluc3RlYWQgb2YNCj4+IHRoZSBWTUEgaW5zdGFuY2UsIHBhc3MgdGhlIGlu
ZGl2aWRpYWwgcGFyYW1ldGVycyBzZXBhcmF0ZWx5OiBleGlzdGluZw0KPj4gcGFnZS1hY2Nl
c3MgZmxhZ3MsIHRoZSBWTUFzIHN0YXJ0IGFuZCBlbmQgYWRkcmVzc2VzIGFuZCB0aGUgb2Zm
c2V0DQo+PiBpbiB0aGUgdW5kZXJseWluZyBkZXZpY2UgbWVtb3J5IHJzcCBmaWxlLiBSZXR1
cm4gdGhlIG5ldyBwYWdlLWFjY2Vzcw0KPj4gZmxhZ3MuIFRoZXNlIGNoYW5nZXMgYWxpZ24g
cGdwcm90X2ZyYW1lYnVmZmVyKCkgd2l0aCBvdGhlciBwZ3Byb3RfKCkNCj4+IGZ1bmN0aW9u
cy4NCj4+DQo+PiB2MzoNCj4+IAkqIHJlbmFtZSBmYl9wZ3Byb3RlY3QoKSB0byBwZ3Byb3Rf
ZnJhbWVidWZmZXIoKSAoQXJuZCkNCj4gDQo+IFRoZW4gbWF5YmUgdGhlIFN1YmplY3Q6IG5l
ZWRzIHRvIGJlIGNoYW5nZWQgYXMgd2VsbC4NCg0KQXJnaGguIFNvcnJ5Lg0KDQo+IA0KPj4N
Cj4+IFNpZ25lZC1vZmYtYnk6IFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNl
LmRlPg0KPj4gLS0tDQo+PiAgICBhcmNoL2lhNjQvaW5jbHVkZS9hc20vZmIuaCAgICAgICAg
ICAgfCAxNSArKysrKysrLS0tLS0tLS0NCj4+ICAgIGFyY2gvbTY4ay9pbmNsdWRlL2FzbS9m
Yi5oICAgICAgICAgICB8IDE5ICsrKysrKysrKystLS0tLS0tLS0NCj4+ICAgIGFyY2gvbWlw
cy9pbmNsdWRlL2FzbS9mYi5oICAgICAgICAgICB8IDExICsrKysrLS0tLS0tDQo+PiAgICBh
cmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vZmIuaCAgICAgICAgfCAxMyArKysrKy0tLS0tLS0t
DQo+PiAgICBhcmNoL3NwYXJjL2luY2x1ZGUvYXNtL2ZiLmggICAgICAgICAgfCAxNSArKysr
KysrKystLS0tLS0NCj4+ICAgIGFyY2gveDg2L2luY2x1ZGUvYXNtL2ZiLmggICAgICAgICAg
ICB8IDEwICsrKysrKy0tLS0NCj4+ICAgIGFyY2gveDg2L3ZpZGVvL2ZiZGV2LmMgICAgICAg
ICAgICAgICB8IDE1ICsrKysrKysrLS0tLS0tLQ0KPj4gICAgZHJpdmVycy92aWRlby9mYmRl
di9jb3JlL2ZiX2NocmRldi5jIHwgIDMgKystDQo+PiAgICBpbmNsdWRlL2FzbS1nZW5lcmlj
L2ZiLmggICAgICAgICAgICAgfCAxMiArKysrKystLS0tLS0NCj4+ICAgIDkgZmlsZXMgY2hh
bmdlZCwgNTggaW5zZXJ0aW9ucygrKSwgNTUgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL2FyY2gvaWE2NC9pbmNsdWRlL2FzbS9mYi5oIGIvYXJjaC9pYTY0L2luY2x1ZGUv
YXNtL2ZiLmgNCj4+IGluZGV4IDE3MTdiMjZmZDQyM2YuLjdmY2UwZDU0MjM1OTAgMTAwNjQ0
DQo+PiAtLS0gYS9hcmNoL2lhNjQvaW5jbHVkZS9hc20vZmIuaA0KPj4gKysrIGIvYXJjaC9p
YTY0L2luY2x1ZGUvYXNtL2ZiLmgNCj4+IEBAIC04LDE3ICs4LDE2IEBADQo+PiAgICANCj4+
ICAgICNpbmNsdWRlIDxhc20vcGFnZS5oPg0KPj4gICAgDQo+PiAtc3RydWN0IGZpbGU7DQo+
PiAtDQo+PiAtc3RhdGljIGlubGluZSB2b2lkIGZiX3BncHJvdGVjdChzdHJ1Y3QgZmlsZSAq
ZmlsZSwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsDQo+PiAtCQkJCXVuc2lnbmVkIGxv
bmcgb2ZmKQ0KPj4gK3N0YXRpYyBpbmxpbmUgcGdwcm90X3QgcGdwcm90X2ZyYW1lYnVmZmVy
KHBncHJvdF90IHByb3QsDQo+PiArCQkJCQkgIHVuc2lnbmVkIGxvbmcgdm1fc3RhcnQsIHVu
c2lnbmVkIGxvbmcgdm1fZW5kLA0KPj4gKwkJCQkJICB1bnNpZ25lZCBsb25nIG9mZnNldCkN
Cj4+ICAgIHsNCj4+IC0JaWYgKGVmaV9yYW5nZV9pc193Yyh2bWEtPnZtX3N0YXJ0LCB2bWEt
PnZtX2VuZCAtIHZtYS0+dm1fc3RhcnQpKQ0KPj4gLQkJdm1hLT52bV9wYWdlX3Byb3QgPSBw
Z3Byb3Rfd3JpdGVjb21iaW5lKHZtYS0+dm1fcGFnZV9wcm90KTsNCj4+ICsJaWYgKGVmaV9y
YW5nZV9pc193Yyh2bV9zdGFydCwgdm1fZW5kIC0gdm1fc3RhcnQpKQ0KPj4gKwkJcmV0dXJu
IHBncHJvdF93cml0ZWNvbWJpbmUocHJvdCk7DQo+PiAgICAJZWxzZQ0KPj4gLQkJdm1hLT52
bV9wYWdlX3Byb3QgPSBwZ3Byb3Rfbm9uY2FjaGVkKHZtYS0+dm1fcGFnZV9wcm90KTsNCj4+
ICsJCXJldHVybiBwZ3Byb3Rfbm9uY2FjaGVkKHByb3QpOw0KPj4gICAgfQ0KPj4gLSNkZWZp
bmUgZmJfcGdwcm90ZWN0IGZiX3BncHJvdGVjdA0KPj4gKyNkZWZpbmUgcGdwcm90X2ZyYW1l
YnVmZmVyIHBncHJvdF9mcmFtZWJ1ZmZlcg0KPj4gICAgDQo+PiAgICBzdGF0aWMgaW5saW5l
IHZvaWQgZmJfbWVtY3B5X2Zyb21pbyh2b2lkICp0bywgY29uc3Qgdm9sYXRpbGUgdm9pZCBf
X2lvbWVtICpmcm9tLCBzaXplX3QgbikNCj4+ICAgIHsNCj4+IGRpZmYgLS1naXQgYS9hcmNo
L202OGsvaW5jbHVkZS9hc20vZmIuaCBiL2FyY2gvbTY4ay9pbmNsdWRlL2FzbS9mYi5oDQo+
PiBpbmRleCAyNDI3M2ZjN2FkOTE3Li45OTQxYjc0MzRiNjk2IDEwMDY0NA0KPj4gLS0tIGEv
YXJjaC9tNjhrL2luY2x1ZGUvYXNtL2ZiLmgNCj4+ICsrKyBiL2FyY2gvbTY4ay9pbmNsdWRl
L2FzbS9mYi5oDQo+PiBAQCAtNSwyNiArNSwyNyBAQA0KPj4gICAgI2luY2x1ZGUgPGFzbS9w
YWdlLmg+DQo+PiAgICAjaW5jbHVkZSA8YXNtL3NldHVwLmg+DQo+PiAgICANCj4+IC1zdHJ1
Y3QgZmlsZTsNCj4+IC0NCj4+IC1zdGF0aWMgaW5saW5lIHZvaWQgZmJfcGdwcm90ZWN0KHN0
cnVjdCBmaWxlICpmaWxlLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwNCj4+IC0JCQkJ
dW5zaWduZWQgbG9uZyBvZmYpDQo+PiArc3RhdGljIGlubGluZSBwZ3Byb3RfdCBwZ3Byb3Rf
ZnJhbWVidWZmZXIocGdwcm90X3QgcHJvdCwNCj4+ICsJCQkJCSAgdW5zaWduZWQgbG9uZyB2
bV9zdGFydCwgdW5zaWduZWQgbG9uZyB2bV9lbmQsDQo+PiArCQkJCQkgIHVuc2lnbmVkIGxv
bmcgb2Zmc2V0KQ0KPj4gICAgew0KPj4gICAgI2lmZGVmIENPTkZJR19NTVUNCj4+ICAgICNp
ZmRlZiBDT05GSUdfU1VOMw0KPj4gLQlwZ3Byb3RfdmFsKHZtYS0+dm1fcGFnZV9wcm90KSB8
PSBTVU4zX1BBR0VfTk9DQUNIRTsNCj4+ICsJcGdwcm90X3ZhbChwcm90KSB8PSBTVU4zX1BB
R0VfTk9DQUNIRTsNCj4+ICAgICNlbHNlDQo+PiAgICAJaWYgKENQVV9JU18wMjBfT1JfMDMw
KQ0KPj4gLQkJcGdwcm90X3ZhbCh2bWEtPnZtX3BhZ2VfcHJvdCkgfD0gX1BBR0VfTk9DQUNI
RTAzMDsNCj4+ICsJCXBncHJvdF92YWwocHJvdCkgfD0gX1BBR0VfTk9DQUNIRTAzMDsNCj4+
ICAgIAlpZiAoQ1BVX0lTXzA0MF9PUl8wNjApIHsNCj4+IC0JCXBncHJvdF92YWwodm1hLT52
bV9wYWdlX3Byb3QpICY9IF9DQUNIRU1BU0swNDA7DQo+PiArCQlwZ3Byb3RfdmFsKHByb3Qp
ICY9IF9DQUNIRU1BU0swNDA7DQo+PiAgICAJCS8qIFVzZSBuby1jYWNoZSBtb2RlLCBzZXJp
YWxpemVkICovDQo+PiAtCQlwZ3Byb3RfdmFsKHZtYS0+dm1fcGFnZV9wcm90KSB8PSBfUEFH
RV9OT0NBQ0hFX1M7DQo+PiArCQlwZ3Byb3RfdmFsKHByb3QpIHw9IF9QQUdFX05PQ0FDSEVf
UzsNCj4+ICAgIAl9DQo+PiAgICAjZW5kaWYgLyogQ09ORklHX1NVTjMgKi8NCj4+ICAgICNl
bmRpZiAvKiBDT05GSUdfTU1VICovDQo+PiArDQo+PiArCXJldHVybiBwcm90Ow0KPj4gICAg
fQ0KPj4gLSNkZWZpbmUgZmJfcGdwcm90ZWN0IGZiX3BncHJvdGVjdA0KPj4gKyNkZWZpbmUg
cGdwcm90X2ZyYW1lYnVmZmVyIHBncHJvdF9mcmFtZWJ1ZmZlcg0KPj4gICAgDQo+PiAgICAj
aW5jbHVkZSA8YXNtLWdlbmVyaWMvZmIuaD4NCj4+ICAgIA0KPj4gZGlmZiAtLWdpdCBhL2Fy
Y2gvbWlwcy9pbmNsdWRlL2FzbS9mYi5oIGIvYXJjaC9taXBzL2luY2x1ZGUvYXNtL2ZiLmgN
Cj4+IGluZGV4IDE4YjcyMjY0MDNiYWQuLmQ5OGQ2NjgxZDY0ZWMgMTAwNjQ0DQo+PiAtLS0g
YS9hcmNoL21pcHMvaW5jbHVkZS9hc20vZmIuaA0KPj4gKysrIGIvYXJjaC9taXBzL2luY2x1
ZGUvYXNtL2ZiLmgNCj4+IEBAIC0zLDE0ICszLDEzIEBADQo+PiAgICANCj4+ICAgICNpbmNs
dWRlIDxhc20vcGFnZS5oPg0KPj4gICAgDQo+PiAtc3RydWN0IGZpbGU7DQo+PiAtDQo+PiAt
c3RhdGljIGlubGluZSB2b2lkIGZiX3BncHJvdGVjdChzdHJ1Y3QgZmlsZSAqZmlsZSwgc3Ry
dWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsDQo+PiAtCQkJCXVuc2lnbmVkIGxvbmcgb2ZmKQ0K
Pj4gK3N0YXRpYyBpbmxpbmUgcGdwcm90X3QgcGdwcm90X2ZyYW1lYnVmZmVyKHBncHJvdF90
IHByb3QsDQo+PiArCQkJCQkgIHVuc2lnbmVkIGxvbmcgdm1fc3RhcnQsIHVuc2lnbmVkIGxv
bmcgdm1fZW5kLA0KPj4gKwkJCQkJICB1bnNpZ25lZCBsb25nIG9mZnNldCkNCj4+ICAgIHsN
Cj4+IC0Jdm1hLT52bV9wYWdlX3Byb3QgPSBwZ3Byb3Rfbm9uY2FjaGVkKHZtYS0+dm1fcGFn
ZV9wcm90KTsNCj4+ICsJcmV0dXJuIHBncHJvdF9ub25jYWNoZWQocHJvdCk7DQo+PiAgICB9
DQo+PiAtI2RlZmluZSBmYl9wZ3Byb3RlY3QgZmJfcGdwcm90ZWN0DQo+PiArI2RlZmluZSBw
Z3Byb3RfZnJhbWVidWZmZXIgcGdwcm90X2ZyYW1lYnVmZmVyDQo+PiAgICANCj4+ICAgIC8q
DQo+PiAgICAgKiBNSVBTIGRvZXNuJ3QgZGVmaW5lIF9fcmF3XyBJL08gbWFjcm9zLCBzbyB0
aGUgaGVscGVycw0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9m
Yi5oIGIvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL2ZiLmgNCj4+IGluZGV4IDYxZTNiODgw
NmRiNjkuLjNjZWNmMTRkNTFkZTggMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3Bvd2VycGMvaW5j
bHVkZS9hc20vZmIuaA0KPj4gKysrIGIvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL2ZiLmgN
Cj4+IEBAIC0yLDIzICsyLDIwIEBADQo+PiAgICAjaWZuZGVmIF9BU01fRkJfSF8NCj4+ICAg
ICNkZWZpbmUgX0FTTV9GQl9IXw0KPj4gICAgDQo+PiAtI2luY2x1ZGUgPGxpbnV4L2ZzLmg+
DQo+PiAtDQo+PiAgICAjaW5jbHVkZSA8YXNtL3BhZ2UuaD4NCj4+ICAgIA0KPj4gLXN0YXRp
YyBpbmxpbmUgdm9pZCBmYl9wZ3Byb3RlY3Qoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCB2
bV9hcmVhX3N0cnVjdCAqdm1hLA0KPj4gLQkJCQl1bnNpZ25lZCBsb25nIG9mZikNCj4+ICtz
dGF0aWMgaW5saW5lIHBncHJvdF90IHBncHJvdF9mcmFtZWJ1ZmZlcihwZ3Byb3RfdCBwcm90
LA0KPj4gKwkJCQkJICB1bnNpZ25lZCBsb25nIHZtX3N0YXJ0LCB1bnNpZ25lZCBsb25nIHZt
X2VuZCwNCj4+ICsJCQkJCSAgdW5zaWduZWQgbG9uZyBvZmZzZXQpDQo+PiAgICB7DQo+PiAg
ICAJLyoNCj4+ICAgIAkgKiBQb3dlclBDJ3MgaW1wbGVtZW50YXRpb24gb2YgcGh5c19tZW1f
YWNjZXNzX3Byb3QoKSBkb2VzDQo+PiAgICAJICogbm90IHVzZSB0aGUgZmlsZSBhcmd1bWVu
dC4gU2V0IGl0IHRvIE5VTEwgaW4gcHJlcGFyYXRpb24NCj4+ICAgIAkgKiBvZiBsYXRlciB1
cGRhdGVzIHRvIHRoZSBpbnRlcmZhY2UuDQo+PiAgICAJICovDQo+PiAtCXZtYS0+dm1fcGFn
ZV9wcm90ID0gcGh5c19tZW1fYWNjZXNzX3Byb3QoTlVMTCwgUEhZU19QRk4ob2ZmKSwNCj4+
IC0JCQkJCQkgdm1hLT52bV9lbmQgLSB2bWEtPnZtX3N0YXJ0LA0KPj4gLQkJCQkJCSB2bWEt
PnZtX3BhZ2VfcHJvdCk7DQo+PiArCXJldHVybiBwaHlzX21lbV9hY2Nlc3NfcHJvdChOVUxM
LCBQSFlTX1BGTihvZmZzZXQpLCB2bV9lbmQgLSB2bV9zdGFydCwgcHJvdCk7DQo+PiAgICB9
DQo+PiAtI2RlZmluZSBmYl9wZ3Byb3RlY3QgZmJfcGdwcm90ZWN0DQo+PiArI2RlZmluZSBw
Z3Byb3RfZnJhbWVidWZmZXIgcGdwcm90X2ZyYW1lYnVmZmVyDQo+PiAgICANCj4+ICAgICNp
bmNsdWRlIDxhc20tZ2VuZXJpYy9mYi5oPg0KPj4gICAgDQo+PiBkaWZmIC0tZ2l0IGEvYXJj
aC9zcGFyYy9pbmNsdWRlL2FzbS9mYi5oIGIvYXJjaC9zcGFyYy9pbmNsdWRlL2FzbS9mYi5o
DQo+PiBpbmRleCA1NzJlY2QzZTFjYzQ4Li4yNDQ0MGMwZmRhNDkwIDEwMDY0NA0KPj4gLS0t
IGEvYXJjaC9zcGFyYy9pbmNsdWRlL2FzbS9mYi5oDQo+PiArKysgYi9hcmNoL3NwYXJjL2lu
Y2x1ZGUvYXNtL2ZiLmgNCj4+IEBAIC00LDE1ICs0LDE4IEBADQo+PiAgICANCj4+ICAgICNp
bmNsdWRlIDxsaW51eC9pby5oPg0KPj4gICAgDQo+PiArI2luY2x1ZGUgPGFzbS9wYWdlLmg+
DQo+PiArDQo+PiAgICBzdHJ1Y3QgZmJfaW5mbzsNCj4+IC1zdHJ1Y3QgZmlsZTsNCj4+IC1z
dHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3Q7DQo+PiAgICANCj4+ICAgICNpZmRlZiBDT05GSUdfU1BB
UkMzMg0KPj4gLXN0YXRpYyBpbmxpbmUgdm9pZCBmYl9wZ3Byb3RlY3Qoc3RydWN0IGZpbGUg
KmZpbGUsIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLA0KPj4gLQkJCQl1bnNpZ25lZCBs
b25nIG9mZikNCj4+IC17IH0NCj4+IC0jZGVmaW5lIGZiX3BncHJvdGVjdCBmYl9wZ3Byb3Rl
Y3QNCj4+ICtzdGF0aWMgaW5saW5lIHBncHJvdF90IHBncHJvdF9mcmFtZWJ1ZmZlcihwZ3By
b3RfdCBwcm90LA0KPj4gKwkJCQkJICB1bnNpZ25lZCBsb25nIHZtX3N0YXJ0LCB1bnNpZ25l
ZCBsb25nIHZtX2VuZCwNCj4+ICsJCQkJCSAgdW5zaWduZWQgbG9uZyBvZmZzZXQpDQo+PiAr
ew0KPj4gKwlyZXR1cm4gcHJvdDsNCj4+ICt9DQo+PiArI2RlZmluZSBwZ3Byb3RfZnJhbWVi
dWZmZXIgcGdwcm90X2ZyYW1lYnVmZmVyDQo+PiAgICAjZW5kaWYNCj4+ICAgIA0KPj4gICAg
aW50IGZiX2lzX3ByaW1hcnlfZGV2aWNlKHN0cnVjdCBmYl9pbmZvICppbmZvKTsNCj4+IGRp
ZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9mYi5oIGIvYXJjaC94ODYvaW5jbHVk
ZS9hc20vZmIuaA0KPj4gaW5kZXggMjM4NzNkYThmYjc3Yy4uYzNiOTU4MmRlN2VmZCAxMDA2
NDQNCj4+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2ZiLmgNCj4+ICsrKyBiL2FyY2gv
eDg2L2luY2x1ZGUvYXNtL2ZiLmgNCj4+IEBAIC0yLDEyICsyLDE0IEBADQo+PiAgICAjaWZu
ZGVmIF9BU01fWDg2X0ZCX0gNCj4+ICAgICNkZWZpbmUgX0FTTV9YODZfRkJfSA0KPj4gICAg
DQo+PiArI2luY2x1ZGUgPGFzbS9wYWdlLmg+DQo+PiArDQo+PiAgICBzdHJ1Y3QgZmJfaW5m
bzsNCj4+IC1zdHJ1Y3QgZmlsZTsNCj4+IC1zdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3Q7DQo+PiAg
ICANCj4+IC12b2lkIGZiX3BncHJvdGVjdChzdHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0IHZt
X2FyZWFfc3RydWN0ICp2bWEsIHVuc2lnbmVkIGxvbmcgb2ZmKTsNCj4+IC0jZGVmaW5lIGZi
X3BncHJvdGVjdCBmYl9wZ3Byb3RlY3QNCj4+ICtwZ3Byb3RfdCBwZ3Byb3RfZnJhbWVidWZm
ZXIocGdwcm90X3QgcHJvdCwNCj4+ICsJCQkgICAgdW5zaWduZWQgbG9uZyB2bV9zdGFydCwg
dW5zaWduZWQgbG9uZyB2bV9lbmQsDQo+PiArCQkJICAgIHVuc2lnbmVkIGxvbmcgb2Zmc2V0
KTsNCj4+ICsjZGVmaW5lIHBncHJvdF9mcmFtZWJ1ZmZlciBwZ3Byb3RfZnJhbWVidWZmZXIN
Cj4+ICAgIA0KPj4gICAgaW50IGZiX2lzX3ByaW1hcnlfZGV2aWNlKHN0cnVjdCBmYl9pbmZv
ICppbmZvKTsNCj4+ICAgICNkZWZpbmUgZmJfaXNfcHJpbWFyeV9kZXZpY2UgZmJfaXNfcHJp
bWFyeV9kZXZpY2UNCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni92aWRlby9mYmRldi5jIGIv
YXJjaC94ODYvdmlkZW8vZmJkZXYuYw0KPj4gaW5kZXggNDlhMDQ1MjQwMmU5Ny4uMWRkNjUy
OGNjOTQ3YyAxMDA2NDQNCj4+IC0tLSBhL2FyY2gveDg2L3ZpZGVvL2ZiZGV2LmMNCj4+ICsr
KyBiL2FyY2gveDg2L3ZpZGVvL2ZiZGV2LmMNCj4+IEBAIC0xMywxNiArMTMsMTcgQEANCj4+
ICAgICNpbmNsdWRlIDxsaW51eC92Z2FhcmIuaD4NCj4+ICAgICNpbmNsdWRlIDxhc20vZmIu
aD4NCj4+ICAgIA0KPj4gLXZvaWQgZmJfcGdwcm90ZWN0KHN0cnVjdCBmaWxlICpmaWxlLCBz
dHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwgdW5zaWduZWQgbG9uZyBvZmYpDQo+PiArcGdw
cm90X3QgcGdwcm90X2ZyYW1lYnVmZmVyKHBncHJvdF90IHByb3QsDQo+PiArCQkJICAgIHVu
c2lnbmVkIGxvbmcgdm1fc3RhcnQsIHVuc2lnbmVkIGxvbmcgdm1fZW5kLA0KPj4gKwkJCSAg
ICB1bnNpZ25lZCBsb25nIG9mZnNldCkNCj4+ICAgIHsNCj4+IC0JdW5zaWduZWQgbG9uZyBw
cm90Ow0KPj4gLQ0KPj4gLQlwcm90ID0gcGdwcm90X3ZhbCh2bWEtPnZtX3BhZ2VfcHJvdCkg
JiB+X1BBR0VfQ0FDSEVfTUFTSzsNCj4+ICsJcGdwcm90X3ZhbChwcm90KSAmPSB+X1BBR0Vf
Q0FDSEVfTUFTSzsNCj4+ICAgIAlpZiAoYm9vdF9jcHVfZGF0YS54ODYgPiAzKQ0KPj4gLQkJ
cGdwcm90X3ZhbCh2bWEtPnZtX3BhZ2VfcHJvdCkgPQ0KPj4gLQkJCXByb3QgfCBjYWNoZW1v
ZGUycHJvdHZhbChfUEFHRV9DQUNIRV9NT0RFX1VDX01JTlVTKTsNCj4+ICsJCXBncHJvdF92
YWwocHJvdCkgfD0gY2FjaGVtb2RlMnByb3R2YWwoX1BBR0VfQ0FDSEVfTU9ERV9VQ19NSU5V
Uyk7DQo+PiArDQo+PiArCXJldHVybiBwcm90Ow0KPj4gICAgfQ0KPj4gLUVYUE9SVF9TWU1C
T0woZmJfcGdwcm90ZWN0KTsNCj4+ICtFWFBPUlRfU1lNQk9MKHBncHJvdF9mcmFtZWJ1ZmZl
cik7DQo+PiAgICANCj4+ICAgIGludCBmYl9pc19wcmltYXJ5X2RldmljZShzdHJ1Y3QgZmJf
aW5mbyAqaW5mbykNCj4+ICAgIHsNCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpZGVvL2Zi
ZGV2L2NvcmUvZmJfY2hyZGV2LmMgYi9kcml2ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUvZmJfY2hy
ZGV2LmMNCj4+IGluZGV4IGVhZGI4MWY1M2E4MjEuLjMyYTczMTViNGI2ZGQgMTAwNjQ0DQo+
PiAtLS0gYS9kcml2ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUvZmJfY2hyZGV2LmMNCj4+ICsrKyBi
L2RyaXZlcnMvdmlkZW8vZmJkZXYvY29yZS9mYl9jaHJkZXYuYw0KPj4gQEAgLTM2NSw3ICsz
NjUsOCBAQCBzdGF0aWMgaW50IGZiX21tYXAoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCB2
bV9hcmVhX3N0cnVjdCAqdm1hKQ0KPj4gICAgCW11dGV4X3VubG9jaygmaW5mby0+bW1fbG9j
ayk7DQo+PiAgICANCj4+ICAgIAl2bWEtPnZtX3BhZ2VfcHJvdCA9IHZtX2dldF9wYWdlX3By
b3Qodm1hLT52bV9mbGFncyk7DQo+PiAtCWZiX3BncHJvdGVjdChmaWxlLCB2bWEsIHN0YXJ0
KTsNCj4+ICsJdm1hLT52bV9wYWdlX3Byb3QgPSBwZ3Byb3RfZnJhbWVidWZmZXIodm1hLT52
bV9wYWdlX3Byb3QsIHZtYS0+dm1fc3RhcnQsDQo+PiArCQkJCQkgICAgICAgdm1hLT52bV9l
bmQsIHN0YXJ0KTsNCj4+ICAgIA0KPj4gICAgCXJldHVybiB2bV9pb21hcF9tZW1vcnkodm1h
LCBzdGFydCwgbGVuKTsNCj4+ICAgIH0NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2FzbS1n
ZW5lcmljL2ZiLmggYi9pbmNsdWRlL2FzbS1nZW5lcmljL2ZiLmgNCj4+IGluZGV4IGJiN2Vl
OWM3MGU2MDMuLjZjY2FiYjQwMGFhNjYgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2FzbS1n
ZW5lcmljL2ZiLmgNCj4+ICsrKyBiL2luY2x1ZGUvYXNtLWdlbmVyaWMvZmIuaA0KPj4gQEAg
LTEyLDE0ICsxMiwxNCBAQA0KPj4gICAgI2luY2x1ZGUgPGxpbnV4L3BndGFibGUuaD4NCj4+
ICAgIA0KPj4gICAgc3RydWN0IGZiX2luZm87DQo+PiAtc3RydWN0IGZpbGU7DQo+PiAgICAN
Cj4+IC0jaWZuZGVmIGZiX3BncHJvdGVjdA0KPj4gLSNkZWZpbmUgZmJfcGdwcm90ZWN0IGZi
X3BncHJvdGVjdA0KPj4gLXN0YXRpYyBpbmxpbmUgdm9pZCBmYl9wZ3Byb3RlY3Qoc3RydWN0
IGZpbGUgKmZpbGUsIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLA0KPj4gLQkJCQl1bnNp
Z25lZCBsb25nIG9mZikNCj4+ICsjaWZuZGVmIHBncHJvdF9mcmFtZWJ1ZmZlcg0KPj4gKyNk
ZWZpbmUgcGdwcm90X2ZyYW1lYnVmZmVyIHBncHJvdF9mcmFtZWJ1ZmZlcg0KPj4gK3N0YXRp
YyBpbmxpbmUgcGdwcm90X3QgcGdwcm90X2ZyYW1lYnVmZmVyKHBncHJvdF90IHByb3QsDQo+
PiArCQkJCQkgIHVuc2lnbmVkIGxvbmcgdm1fc3RhcnQsIHVuc2lnbmVkIGxvbmcgdm1fZW5k
LA0KPj4gKwkJCQkJICB1bnNpZ25lZCBsb25nIG9mZnNldCkNCj4+ICAgIHsNCj4+IC0Jdm1h
LT52bV9wYWdlX3Byb3QgPSBwZ3Byb3Rfd3JpdGVjb21iaW5lKHZtYS0+dm1fcGFnZV9wcm90
KTsNCj4+ICsJcmV0dXJuIHBncHJvdF93cml0ZWNvbWJpbmUocHJvdCk7DQo+PiAgICB9DQo+
PiAgICAjZW5kaWYNCj4+ICAgIA0KDQotLSANClRob21hcyBaaW1tZXJtYW5uDQpHcmFwaGlj
cyBEcml2ZXIgRGV2ZWxvcGVyDQpTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdt
YkgNCkZyYW5rZW5zdHJhc3NlIDE0NiwgOTA0NjEgTnVlcm5iZXJnLCBHZXJtYW55DQpHRjog
SXZvIFRvdGV2LCBBbmRyZXcgTXllcnMsIEFuZHJldyBNY0RvbmFsZCwgQm91ZGllbiBNb2Vy
bWFuDQpIUkIgMzY4MDkgKEFHIE51ZXJuYmVyZykNCg==

--------------2f6NCVgzHZqf4xSBalWnsyhb--

--------------1WabY0iBOmscdR6st3k4e1C8
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmT/I/wFAwAAAAAACgkQlh/E3EQov+BR
SRAAq3j0MvyhnUmkK3lfV/GwwArCbyeicavxeCyXdX11lan6NYtX09mwPnZEaCnoHe0vSkXtZTdZ
o/0yJqCPaTepKAOiqXHs8g0881y6Y11Ns6EFAwjfhwdD1igICbyQr51+GvnJSFu5nTCAnxO3CoSX
uzbZ6XUMlSnOt9liRhneRB5W0LFwFcoFjginvyQIC5PJ9+RCMgP2FhhoX6xecr9JLpbFf0ZVFLh1
Di7IFdYACw7CIzUKiqhl42lS1P/S860VNKu66NtT7wkqJ2vkZAs3lWxm4jV6Z+BcsdQiMOvnndwY
4ajTIZXQKdbgYAq6jfr98OGbPaKYgLLXj2z2V8iXq/y3m9yEsVmb9PmtpO0y5eWkq7EkK2DjrwM+
yI5GwJ7vmZAkNFlYgRHOlkVRknrmjn0snMIMwEv4f3vS3m22VS0NMnCeGUuIw/I1bKj/QoI3gg4m
r7GR621Q225Bxm3hp2+SYooiiWqwvJ8vv3g3fpQtf9ge9DHtk4XR1wREk7V7vW7h4+63A0Z0PRl5
cES/gcgxarPegK96Hxovzm9flF/p9MgZo0VKXK+K/okv8Q2dReZJiVLh8nnnSZnmBnT+MytHMd3z
ni/iNisi8p9ocWwiXEvruFzbkjkUryzKLCxvLMwsDhZjYJoS0rwodWB7PHuhgLvxKyeumYUm6zRI
3MM=
=+lXo
-----END PGP SIGNATURE-----

--------------1WabY0iBOmscdR6st3k4e1C8--
