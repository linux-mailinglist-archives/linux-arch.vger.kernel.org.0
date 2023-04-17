Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F119A6E4329
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 11:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjDQJEs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 05:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjDQJEr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 05:04:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990E34EC4;
        Mon, 17 Apr 2023 02:04:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 55A821F381;
        Mon, 17 Apr 2023 09:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681722280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b6sKemqSNeqSuzvlbtysiTKcK5tWpdbhBfOYMbe1xpA=;
        b=lEbyRvZ0mhA+HTDSg/bXcfjaxsomSGRcRcjAVr8tOXKoCIe65JHXtQwHv+wj7v7Ke+mxUp
        bIvywh/2mTvYmeDpIakryjRc6GWveByKR+d8zJyovqzoed8ILUJDIM9PJ1iTG2s35Y4y2b
        /H4VpktNgiA/80+JLQ6zI2hzIjIGiiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681722280;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b6sKemqSNeqSuzvlbtysiTKcK5tWpdbhBfOYMbe1xpA=;
        b=EFaog30zlwFDQPmFwOt7LFAWdUfZI1apM55oIu7KK0oVl8+PIBxm8zHlg/ELchgxNZjEUD
        aIQOnTvp5Q6hvbAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA51213319;
        Mon, 17 Apr 2023 09:04:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EEoeNKcLPWRGVwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 17 Apr 2023 09:04:39 +0000
Message-ID: <4450d4bf-a6e0-764e-d1c4-efba272f0529@suse.de>
Date:   Mon, 17 Apr 2023 11:04:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 02/19] arch/arc: Implement <asm/fb.h> with generic
 helpers
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org,
        Vineet Gupta <vgupta@kernel.org>
References: <20230406143019.6709-1-tzimmermann@suse.de>
 <20230406143019.6709-3-tzimmermann@suse.de>
 <27c1210f-4e40-4bbc-905b-155427465e00@app.fastmail.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <27c1210f-4e40-4bbc-905b-155427465e00@app.fastmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------iPEL9xuP1J0A8seUIdWajJMz"
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------iPEL9xuP1J0A8seUIdWajJMz
Content-Type: multipart/mixed; boundary="------------ITCxEOG7I6GWaznxs8pYlTkW";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Helge Deller <deller@gmx.de>, Javier Martinez Canillas <javierm@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-snps-arc@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org,
 Vineet Gupta <vgupta@kernel.org>
Message-ID: <4450d4bf-a6e0-764e-d1c4-efba272f0529@suse.de>
Subject: Re: [PATCH v2 02/19] arch/arc: Implement <asm/fb.h> with generic
 helpers
References: <20230406143019.6709-1-tzimmermann@suse.de>
 <20230406143019.6709-3-tzimmermann@suse.de>
 <27c1210f-4e40-4bbc-905b-155427465e00@app.fastmail.com>
In-Reply-To: <27c1210f-4e40-4bbc-905b-155427465e00@app.fastmail.com>

--------------ITCxEOG7I6GWaznxs8pYlTkW
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCkFtIDA2LjA0LjIzIHVtIDE2OjQzIHNjaHJpZWIgQXJuZCBCZXJnbWFubjoNCj4gT24g
VGh1LCBBcHIgNiwgMjAyMywgYXQgMTY6MzAsIFRob21hcyBaaW1tZXJtYW5uIHdyb3RlOg0K
Pj4gKw0KPj4gICBzdGF0aWMgaW5saW5lIHZvaWQgZmJfcGdwcm90ZWN0KHN0cnVjdCBmaWxl
ICpmaWxlLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwNCj4+ICAgCQkJCXVuc2lnbmVk
IGxvbmcgb2ZmKQ0KPj4gICB7DQo+PiAgIAl2bWEtPnZtX3BhZ2VfcHJvdCA9IHBncHJvdF9u
b25jYWNoZWQodm1hLT52bV9wYWdlX3Byb3QpOw0KPj4gICB9DQo+PiArI2RlZmluZSBmYl9w
Z3Byb3RlY3QgZmJfcGdwcm90ZWN0DQo+IA0KPiBJIHN0aWxsIGZlZWwgdGhhdCBmb3IgYXJj
aGl0ZWN0dXJlcyBsaWtlIGFyYyB0aGF0IGRvbid0IGhhdmUNCj4gcGdwcm90X3dyaXRlY29t
YmluZSgpLCBpdCB3b3VsZCBiIGJlc3QgdG8gZ28gd2l0aCB0aGUNCj4gZ2VuZXJpYyBpbXBs
ZW1lbnRhdGlvbiB0aGF0IGN1cnJlbnRseSBiZWhhdmVzIHRoZSBleGFjdA0KPiBzYW1lIHdh
eS4gSWYgcGdwcm90X3dyaXRlY29tYmluZSgpIGdldHMgYWRkZWQgaW4gdGhlIGZ1dHVyZSwN
Cj4gaXQgd291bGQgY2F1c2UgdGhlIGFyY2hpdGVjdHVyZSB0byBiZWhhdmUgYXMgZXhwZWN0
ZWQgcmF0aGVyDQo+IHRoYW4gaW50cm9kdWNpbmcgdGhlIHNhbWUgYnVnIHRoYXQgbWlwcyBo
YXMuDQoNCk9LLCBJJ2xsIGNoYW5nZSBpdC4NCg0KPiANCj4gICAgICAgIEFybmQNCg0KLS0g
DQpUaG9tYXMgWmltbWVybWFubg0KR3JhcGhpY3MgRHJpdmVyIERldmVsb3Blcg0KU1VTRSBT
b2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJIDQpNYXhmZWxkc3RyLiA1LCA5MDQwOSBO
w7xybmJlcmcsIEdlcm1hbnkNCihIUkIgMzY4MDksIEFHIE7DvHJuYmVyZykNCkdlc2Now6Rm
dHNmw7xocmVyOiBJdm8gVG90ZXYNCg==

--------------ITCxEOG7I6GWaznxs8pYlTkW--

--------------iPEL9xuP1J0A8seUIdWajJMz
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmQ9C6cFAwAAAAAACgkQlh/E3EQov+Ac
QBAAsfmjop5GpI2/M6n6MvSHBTqHHtmA95cabDcKwQFUOYGC55wDQtKCk1YbTbOeOOp4DHs0Rob4
xWSoykdeIUiYGbc8U+MPXGhCdo2C2sKIZkY1wgmuti3n3EkfC6k6Cx9aCz+tiJ+jd9E45wBaOnaE
56XOzZWvxMz+zYzMPsC0pDMXkpZW1XtmvqXrjF6Ohri8O/In5if4HwkiXyJhY0aEXDHB5qLJU+SI
b+YsRcUJLtzaBG/4xUkrhyP1kpTB/tNLYF4Z9fw7YtOUj+DXACQArqlHD8tVe+Z8HfxPmhRId6bp
XouIgS+7VDb0Utb5Nd22dACIzY1DC6CXiz04MI8o++SCFEAK/FZedYlrXtkriEEYX2pcvlUbU+1p
1RB16i/tjmLBhntUmgiUCOQZxk1IIcpOn13HiEGxkin8oFdsKztsrpK15yCcuTY0/1vlx/bahdFv
Mtsy0ss6D9F1XmgpgRJjQkxR1KNV6LNvXzC56bQdk1qiPg6hRRIh5V65ygR1nowW8PHA3kZw5aS0
tGeYxjnvqz41zAoXzDM3bDKjPcdgFfuzm25s3Z3nwqLsD8nKpoSR6Jr+IpXKNxikB8yx3b9GCTbe
C/MTua22YAkNdKZ2MS00YzB8dMZ0u2ZCINsYOTcIYIN+s8mpb7LPO7Zj36RDWZCJMILkijh/NUmM
Xe0=
=9BHz
-----END PGP SIGNATURE-----

--------------iPEL9xuP1J0A8seUIdWajJMz--
