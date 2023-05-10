Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FFA6FDFE6
	for <lists+linux-arch@lfdr.de>; Wed, 10 May 2023 16:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237386AbjEJOUJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 May 2023 10:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237304AbjEJOUH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 May 2023 10:20:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC7430E9;
        Wed, 10 May 2023 07:20:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 25EE31F88B;
        Wed, 10 May 2023 14:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683728405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QBY1CUl18lOJ0pZbAna3bD8AqADxhu2MjNLI56Dsrlc=;
        b=pWOeXk20/Qv6MW5EA8PX0Uj7HRZS1+AvxB+XbEgbczz1d3AlH76ZW8S5nfTE6SZoi5SL9f
        TOxBK4QaPKOoh1wav0M6Zi5mVrR0uPEz+HTGJEYq2OoQyqOvPOf9m/mfs0SfSxJWAJzN6V
        +tUCgBdKmsl6m0X6C8o+u2HpkSq/rig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683728405;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QBY1CUl18lOJ0pZbAna3bD8AqADxhu2MjNLI56Dsrlc=;
        b=ZpzoYOEcm4w7HPmZfTHM0vLDWB5hVjE3SPq5CCOcYFNeLV/EdG6W41T8ffZax+VXqSn8E6
        5Bx1nhO8FP7T7lAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A037138E5;
        Wed, 10 May 2023 14:20:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eR2KHBSoW2TsLAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 10 May 2023 14:20:04 +0000
Message-ID: <487ff03b-d753-972f-7a06-a1d5efda917d@suse.de>
Date:   Wed, 10 May 2023 16:20:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v6 5/6] fbdev: Move framebuffer I/O helpers into
 <asm/fb.h>
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     deller@gmx.de, javierm@redhat.com, daniel@ffwll.ch,
        vgupta@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
        davem@davemloft.net, James.Bottomley@hansenpartnership.com,
        arnd@arndb.de, sam@ravnborg.org, suijingfeng@loongson.cn,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org
References: <20230510110557.14343-1-tzimmermann@suse.de>
 <20230510110557.14343-6-tzimmermann@suse.de>
 <CAMuHMdVV-MQV3C_o6JxPj23h3zo0kMmsn9ZEWJxsrzr6YpKmyg@mail.gmail.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <CAMuHMdVV-MQV3C_o6JxPj23h3zo0kMmsn9ZEWJxsrzr6YpKmyg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------3cdaEmcUeI0SbzHd3kEA0OwP"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------3cdaEmcUeI0SbzHd3kEA0OwP
Content-Type: multipart/mixed; boundary="------------4ynAak94t4CmV8rDWgNLeyOO";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: deller@gmx.de, javierm@redhat.com, daniel@ffwll.ch, vgupta@kernel.org,
 chenhuacai@kernel.org, kernel@xen0n.name, davem@davemloft.net,
 James.Bottomley@hansenpartnership.com, arnd@arndb.de, sam@ravnborg.org,
 suijingfeng@loongson.cn, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, sparclinux@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org
Message-ID: <487ff03b-d753-972f-7a06-a1d5efda917d@suse.de>
Subject: Re: [PATCH v6 5/6] fbdev: Move framebuffer I/O helpers into
 <asm/fb.h>
References: <20230510110557.14343-1-tzimmermann@suse.de>
 <20230510110557.14343-6-tzimmermann@suse.de>
 <CAMuHMdVV-MQV3C_o6JxPj23h3zo0kMmsn9ZEWJxsrzr6YpKmyg@mail.gmail.com>
In-Reply-To: <CAMuHMdVV-MQV3C_o6JxPj23h3zo0kMmsn9ZEWJxsrzr6YpKmyg@mail.gmail.com>

--------------4ynAak94t4CmV8rDWgNLeyOO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgR2VlcnQNCg0KQW0gMTAuMDUuMjMgdW0gMTQ6MzQgc2NocmllYiBHZWVydCBVeXR0ZXJo
b2V2ZW46DQo+IEhpIFRob21hcywNCj4gDQo+IE9uIFdlZCwgTWF5IDEwLCAyMDIzIGF0IDE6
MDbigK9QTSBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5Ac3VzZS5kZT4gd3JvdGU6
DQo+PiBJbXBsZW1lbnQgZnJhbWVidWZmZXIgSS9PIGhlbHBlcnMsIHN1Y2ggYXMgZmJfcmVh
ZCooKSBhbmQgZmJfd3JpdGUqKCksDQo+PiBpbiB0aGUgYXJjaGl0ZWN0dXJlJ3MgPGFzbS9m
Yi5oPiBoZWFkZXIgZmlsZSBvciB0aGUgZ2VuZXJpYyBvbmUuDQo+Pg0KPj4gVGhlIGNvbW1v
biBjYXNlIGhhcyBiZWVuIHRoZSB1c2Ugb2YgcmVndWxhciBJL08gZnVuY3Rpb25zLCBzdWNo
IGFzDQo+PiBfX3Jhd19yZWFkYigpIG9yIG1lbXNldF9pbygpLiBBIGZldyBhcmNoaXRlY3R1
cmVzIHVzZWQgcGxhaW4gc3lzdGVtLQ0KPj4gbWVtb3J5IHJlYWRzIGFuZCB3cml0ZXMuIFNw
YXJjIHVzZWQgaGVscGVycyBmb3IgaXRzIFNCdXMuDQo+Pg0KPj4gVGhlIGFyY2hpdGVjdHVy
ZXMgdGhhdCB1c2VkIHNwZWNpYWwgY2FzZXMgcHJvdmlkZSB0aGUgc2FtZSBjb2RlIGluDQo+
PiB0aGVpciBfX3Jhd18qKCkgSS9PIGhlbHBlcnMuIFNvIHRoZSBwYXRjaCByZXBsYWNlcyB0
aGlzIGNvZGUgd2l0aCB0aGUNCj4+IF9fcmF3XyooKSBmdW5jdGlvbnMgYW5kIG1vdmVzIGl0
IHRvIDxhc20tZ2VuZXJpYy9mYi5oPiBmb3IgYWxsDQo+PiBhcmNoaXRlY3R1cmVzLg0KPj4N
Cj4+IHY2Og0KPj4gICAgICAgICAgKiBmaXggZmJfcmVhZHEoKS9mYl93cml0ZXEoKSBvbiA2
NC1iaXQgbWlwcyAoa2VybmVsIHRlc3Qgcm9ib3QpDQo+PiB2NToNCj4+ICAgICAgICAgICog
aW5jbHVkZSA8bGludXgvaW8uaD4gaW4gPGFzbS1nZW5lcmljL2ZiPjsgZml4IHMzOTAgYnVp
bGQNCj4+IHY0Og0KPj4gICAgICAgICAgKiBpYTY0LCBsb29uZ2FyY2gsIHNwYXJjNjQ6IGFk
ZCBmYl9tZW0qKCkgdG8gYXJjaCBoZWFkZXJzDQo+PiAgICAgICAgICAgIHRvIGtlZXAgY3Vy
cmVudCBzZW1hbnRpY3MgKEFybmQpDQo+PiB2MzoNCj4+ICAgICAgICAgICogaW1wbGVtZW50
IGFsbCBhcmNoaXRlY3R1cmVzIHdpdGggZ2VuZXJpYyBoZWxwZXJzDQo+PiAgICAgICAgICAq
IHN1cHBvcnQgcmVvcmRlcmluZyBhbmQgbmF0aXZlIGJ5dGUgb3JkZXIgKEdlZXJ0LCBBcm5k
KQ0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFu
bkBzdXNlLmRlPg0KPj4gVGVzdGVkLWJ5OiBTdWkgSmluZ2ZlbmcgPHN1aWppbmdmZW5nQGxv
b25nc29uLmNuPg0KPj4gUmV2aWV3ZWQtYnk6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIu
ZGU+DQo+Pg0KPj4gYWRkIG1pcHMgZmJfcSgpDQoNCk9vcHMsIGxlZnQtb3ZlciBmb20gc3F1
YXNoaW5nIHBhdGNoZXMuDQoNCj4gDQo+PiAtLS0gYS9hcmNoL21pcHMvaW5jbHVkZS9hc20v
ZmIuaA0KPj4gKysrIGIvYXJjaC9taXBzL2luY2x1ZGUvYXNtL2ZiLmgNCj4+IEBAIC0xMiw2
ICsxMiwyOCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgZmJfcGdwcm90ZWN0KHN0cnVjdCBmaWxl
ICpmaWxlLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwNCj4+ICAgfQ0KPj4gICAjZGVm
aW5lIGZiX3BncHJvdGVjdCBmYl9wZ3Byb3RlY3QNCj4+DQo+PiArLyoNCj4+ICsgKiBNSVBT
IGRvZXNuJ3QgZGVmaW5lIF9fcmF3XyBJL08gbWFjcm9zLCBzbyB0aGUgaGVscGVycw0KPj4g
KyAqIGluIDxhc20tZ2VuZXJpYy9mYi5oPiBkb24ndCBnZW5lcmF0ZSBmYl9yZWFkcSgpIGFu
ZA0KPj4gKyAqIGZiX3dyaXRlKCkuIFdlIGhhdmUgdG8gcHJvdmlkZSB0aGVtIGhlcmUuDQo+
IA0KPiBNSVBTIGRvZXMgbm90IGluY2x1ZGUgPGFzbS1nZW5lcmljL2lvLmg+LCAgbm9yIGRl
ZmluZSBpdHMgb3duDQoNCkkga25vdywgdGhhdCdzIHdoeSB0aGUgVE9ETyBzYXlzIHRvIGNv
bnZlcnQgaXQgdG8gZ2VuZXJpYyBJL08uDQoNCj4gX19yYXdfcmVhZHEoKSBhbmQgX19yYXdf
d3JpdGVxKCkuLi4NCg0KSXQgZG9lc24ndCBkZWZpbmUgdGhvc2UgbWFjcm9zLCBidXQgaXQg
Z2VuZXJhdGVzIGZ1bmN0aW9uIGNhbGxzIG9mIHRoZSANCnNhbWUgbmFtZXMuIEZvbGxvdyB0
aGUgbWFjcm9zIGF0DQoNCiANCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L2xh
dGVzdC9zb3VyY2UvYXJjaC9taXBzL2luY2x1ZGUvYXNtL2lvLmgjTDM1Nw0KDQpJdCBleHBh
bmRzIHRvIGEgdmFyaWV0eSBvZiBoZWxwZXJzLCBpbmNsdWRpbmcgX19yYXdfKigpLg0KDQo+
IA0KPj4gKyAqDQo+PiArICogVE9ETzogQ29udmVydCBNSVBTIHRvIGdlbmVyaWMgSS9PLiBU
aGUgaGVscGVycyBiZWxvdyBjYW4NCj4+ICsgKiAgICAgICB0aGVuIGJlIHJlbW92ZWQuDQo+
PiArICovDQo+PiArI2lmZGVmIENPTkZJR182NEJJVA0KPj4gK3N0YXRpYyBpbmxpbmUgdTY0
IGZiX3JlYWRxKGNvbnN0IHZvbGF0aWxlIHZvaWQgX19pb21lbSAqYWRkcikNCj4+ICt7DQo+
PiArICAgICAgIHJldHVybiBfX3Jhd19yZWFkcShhZGRyKTsNCj4gDQo+IC4uLiBzbyBob3cg
Y2FuIHRoaXMgY2FsbCB3b3JrPw0KDQpPbiA2NC1iaXQgYnVpbGRzLCB0aGVyZSdzIF9fcmF3
X3JlYWRxKCkgYW5kIF9fcmF3X3dyaXRlcSgpLg0KDQpBdCBmaXJzdCwgSSB0cmllZCB0byBk
byB0aGUgcmlnaHQgdGhpbmcgYW5kIGNvbnZlcnQgTUlQUyB0byB3b3JrIHdpdGggDQo8YXNt
LWdlbmVyaWMvaW8uaD4uIEJ1dCB0aGF0IGNyZWF0ZWQgYSB0b24gb2YgZm9sbG93LXVwIGVy
cm9ycyBpbiBvdGhlciANCmhlYWRlcnMuIFNvIGZvciBub3csIGl0J3MgYmV0dGVyIHRvIGhh
bmRsZSB0aGlzIHByb2JsZW0gaW4gYXNtL2ZiLmguDQoNCkJlc3QgcmVnYXJkcw0KVGhvbWFz
DQoNCj4gDQo+PiArfQ0KPj4gKyNkZWZpbmUgZmJfcmVhZHEgZmJfcmVhZHENCj4+ICsNCj4+
ICtzdGF0aWMgaW5saW5lIHZvaWQgZmJfd3JpdGVxKHU2NCBiLCB2b2xhdGlsZSB2b2lkIF9f
aW9tZW0gKmFkZHIpDQo+PiArew0KPj4gKyAgICAgICBfX3Jhd193cml0ZXEoYiwgYWRkcik7
DQo+PiArfQ0KPj4gKyNkZWZpbmUgZmJfd3JpdGVxIGZiX3dyaXRlcQ0KPj4gKyNlbmRpZg0K
Pj4gKw0KPj4gICAjaW5jbHVkZSA8YXNtLWdlbmVyaWMvZmIuaD4NCj4gDQo+IEdye29ldGpl
LGVldGluZ31zLA0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+IA0K
DQotLSANClRob21hcyBaaW1tZXJtYW5uDQpHcmFwaGljcyBEcml2ZXIgRGV2ZWxvcGVyDQpT
VVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgNCkZyYW5rZW5zdHJhc3NlIDE0
NiwgOTA0NjEgTnVlcm5iZXJnLCBHZXJtYW55DQpHRjogSXZvIFRvdGV2LCBBbmRyZXcgTXll
cnMsIEFuZHJldyBNY0RvbmFsZCwgQm91ZGllbiBNb2VybWFuDQpIUkIgMzY4MDkgKEFHIE51
ZXJuYmVyZykNCg==

--------------4ynAak94t4CmV8rDWgNLeyOO--

--------------3cdaEmcUeI0SbzHd3kEA0OwP
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmRbqBMFAwAAAAAACgkQlh/E3EQov+Dd
DRAAkhV2ZyqjE7iKkXuOBZoy+Ujc5OxulmPDdE2aPcVS/psjd5OY+6pjLTYnIMhKMvZCIrQDEVhn
YxlGj17+BzP0tSRmDMfsmMx5Vei/zp7yNKlvYLWw3w3tGGNp7N1ZblNoR9naemFHurOXveEacmIA
CLwT8vXxomxTK9+ybBHrOh/bD0tON1lu+YJSimXveIU8R5fofFcBkCm3l/JyyRAySW3dSr6bx49n
/OElo1cX7voHDisVHZTX7Iqu0pvu34xF4rMpzsWnKhqCIoGGaXFG9ewu14sVW+9c9OS5a2ndqlU+
X5yLonPNOre0CO3fUL28HT9pAi+rI+K6x96mVdhUoHGlHii7hQsWToTgF3x4QACdlJtHMeGficNC
HtYGlZWfcUmm10wgdSdd0aIzThaAdgwgIKulgP49E+JQ4fx2aMKXAVEwav4UKU7xEimLXZg9oNFZ
j/kVeToiUuZtQpGV4+280bfPhkLiUKRD//MX23Y28Wjr938JcSkOAz47v6LjETtmZDIJMJpdVNe7
+XZajXWUEiIBOQ9x6vevUZNFVhgjZxuSbH9gezySYEKmPJrSNzDY+j3wfdo9vLluOG0B3skvCRuk
KsAVMbAWyKqWyQCX9nKMPs1PT0eMq0tC/NWfBNY3FCIfghuhVM7NcmCplZhgqf0B47kJyHMQwQ2S
+K0=
=Hh8E
-----END PGP SIGNATURE-----

--------------3cdaEmcUeI0SbzHd3kEA0OwP--
