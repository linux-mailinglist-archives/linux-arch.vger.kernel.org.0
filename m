Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6600743A1B
	for <lists+linux-arch@lfdr.de>; Fri, 30 Jun 2023 12:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjF3K6X (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Jun 2023 06:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjF3K6L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Jun 2023 06:58:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B088358A;
        Fri, 30 Jun 2023 03:58:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 519B91FD71;
        Fri, 30 Jun 2023 10:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688122688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2CwTpDXeyLmBKUlds2ElaCuZL15ny16KA33WqVd3m78=;
        b=iMQyE5ictp9N6kFgnFU/DKY7qAbWO7P35oJSQbBOn4snVKzmiKJdjeUMIVm5T3YHQhdQ4R
        HVOGuh0ss2MMvauuwHmWiwrUy5Tl3nGNyd8LIazsqaQsTPRdCS/0Ah2tqb4M8myJC/CFf2
        W5TOrKlbHAToQgpphxrzWyDwqeSrbg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688122688;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2CwTpDXeyLmBKUlds2ElaCuZL15ny16KA33WqVd3m78=;
        b=0vCor6ANznmzLSCl29v+7NlDOQ0Dl1v17DMqTRs5xQE7E01xsDYEUngaBwR2VB5CfolvBJ
        WFvGVgUMYoSVTJDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D220138F8;
        Fri, 30 Jun 2023 10:58:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n/IYBkC1nmQtGgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 30 Jun 2023 10:58:08 +0000
Message-ID: <4673a16d-0ca1-5c3e-b3f3-f8da34482f65@suse.de>
Date:   Fri, 30 Jun 2023 12:58:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] arch/sparc: Add module license and description for fbdev
 helpers
Content-Language: en-US
To:     Helge Deller <deller@gmx.de>, davem@davemloft.net, arnd@arndb.de,
        linux@roeck-us.net, sam@ravnborg.org
Cc:     sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20230627145843.31794-1-tzimmermann@suse.de>
 <a290cf05-8f6b-3b88-32fc-66f6a173d5c4@gmx.de>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <a290cf05-8f6b-3b88-32fc-66f6a173d5c4@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------31QIJC0szw3TXVlFhNmmvLw9"
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
--------------31QIJC0szw3TXVlFhNmmvLw9
Content-Type: multipart/mixed; boundary="------------P0nSPZg40R8rR7WaalzGUXp3";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Helge Deller <deller@gmx.de>, davem@davemloft.net, arnd@arndb.de,
 linux@roeck-us.net, sam@ravnborg.org
Cc: sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Message-ID: <4673a16d-0ca1-5c3e-b3f3-f8da34482f65@suse.de>
Subject: Re: [PATCH] arch/sparc: Add module license and description for fbdev
 helpers
References: <20230627145843.31794-1-tzimmermann@suse.de>
 <a290cf05-8f6b-3b88-32fc-66f6a173d5c4@gmx.de>
In-Reply-To: <a290cf05-8f6b-3b88-32fc-66f6a173d5c4@gmx.de>

--------------P0nSPZg40R8rR7WaalzGUXp3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgSGVsZ2UNCg0KQW0gMzAuMDYuMjMgdW0gMTE6NDMgc2NocmllYiBIZWxnZSBEZWxsZXI6
DQo+IE9uIDYvMjcvMjMgMTY6NTgsIFRob21hcyBaaW1tZXJtYW5uIHdyb3RlOg0KPj4gQWRk
IE1PRFVMRV9MSUNFTlNFKCkgYW5kIE1PRFVMRV9ERVNDUklQVElPTigpIGZvciBmYmRldiBo
ZWxwZXJzDQo+PiBvbiBzcGFyYy4gRml4ZXMgdGhlIGZvbGxvd2luZyBlcnJvcjoNCj4+DQo+
PiBFUlJPUjogbW9kcG9zdDogbWlzc2luZyBNT0RVTEVfTElDRU5TRSgpIGluIGFyY2gvc3Bh
cmMvdmlkZW8vZmJkZXYubw0KPj4NCj4+IFJlcG9ydGVkLWJ5OiBHdWVudGVyIFJvZWNrIDxs
aW51eEByb2Vjay11cy5uZXQ+DQo+PiBDbG9zZXM6IA0KPj4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvZHJpLWRldmVsL2M1MjVhZGM5LTY2MjMtNDY2MC04NzE4LWUwYzkzMTE1NjNiOEBy
b2Vjay11cy5uZXQvDQo+PiBTdWdnZXN0ZWQtYnk6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJu
ZGIuZGU+DQo+PiBGaXhlczogNGVlYzBiMzA0OGZjICgiYXJjaC9zcGFyYzogSW1wbGVtZW50
IGZiX2lzX3ByaW1hcnlfZGV2aWNlKCkgaW4gDQo+PiBzb3VyY2UgZmlsZSIpDQo+PiBDYzog
IkRhdmlkIFMuIE1pbGxlciIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+DQo+PiBDYzogSGVsZ2Ug
RGVsbGVyIDxkZWxsZXJAZ214LmRlPg0KPj4gQ2M6IFNhbSBSYXZuYm9yZyA8c2FtQHJhdm5i
b3JnLm9yZz4NCj4+IENjOiBzcGFyY2xpbnV4QHZnZXIua2VybmVsLm9yZw0KPj4gU2lnbmVk
LW9mZi1ieTogVGhvbWFzIFppbW1lcm1hbm4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+DQo+PiAt
LS0NCj4+IMKgIGFyY2gvc3BhcmMvdmlkZW8vZmJkZXYuYyB8IDMgKysrDQo+PiDCoCAxIGZp
bGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+IA0KPiBJJ3ZlIHF1ZXVlZCBpdCB1cCBp
biB0aGUgZmJkZXYgZ2l0IHRyZWUgYnV0IHdpbGwgZHJvcCBpdCBhbnl0aW1lDQo+IGlmIHNv
bWVvbmUgcHJlZmVycyB0byB0YWtlIHRoaXMgcGF0Y2ggdGhyb3VnaCBhbm90aGVyIHRyZWUu
Li4uDQoNCkl0J3MgaW4gZHJtLW1pc2MtbmV4dC1maXhlcyBhbHJlYWR5Lg0KDQpCZXN0IHJl
Z2FyZHMNClRob21hcw0KDQo+IA0KPiBUaGFua3MhDQo+IEhlbGdlDQo+IA0KPiANCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvYXJjaC9zcGFyYy92aWRlby9mYmRldi5jIGIvYXJjaC9zcGFyYy92
aWRlby9mYmRldi5jDQo+PiBpbmRleCAyNTgzN2YxMjgxMzJkLi5iZmY2NmRkMTkwOWE0IDEw
MDY0NA0KPj4gLS0tIGEvYXJjaC9zcGFyYy92aWRlby9mYmRldi5jDQo+PiArKysgYi9hcmNo
L3NwYXJjL3ZpZGVvL2ZiZGV2LmMNCj4+IEBAIC0yMSwzICsyMSw2IEBAIGludCBmYl9pc19w
cmltYXJ5X2RldmljZShzdHJ1Y3QgZmJfaW5mbyAqaW5mbykNCj4+IMKgwqDCoMKgwqAgcmV0
dXJuIDA7DQo+PiDCoCB9DQo+PiDCoCBFWFBPUlRfU1lNQk9MKGZiX2lzX3ByaW1hcnlfZGV2
aWNlKTsNCj4+ICsNCj4+ICtNT0RVTEVfREVTQ1JJUFRJT04oIlNwYXJjIGZiZGV2IGhlbHBl
cnMiKTsNCj4+ICtNT0RVTEVfTElDRU5TRSgiR1BMIik7DQo+IA0KDQotLSANClRob21hcyBa
aW1tZXJtYW5uDQpHcmFwaGljcyBEcml2ZXIgRGV2ZWxvcGVyDQpTVVNFIFNvZnR3YXJlIFNv
bHV0aW9ucyBHZXJtYW55IEdtYkgNCkZyYW5rZW5zdHJhc3NlIDE0NiwgOTA0NjEgTnVlcm5i
ZXJnLCBHZXJtYW55DQpHRjogSXZvIFRvdGV2LCBBbmRyZXcgTXllcnMsIEFuZHJldyBNY0Rv
bmFsZCwgQm91ZGllbiBNb2VybWFuDQpIUkIgMzY4MDkgKEFHIE51ZXJuYmVyZykNCg==

--------------P0nSPZg40R8rR7WaalzGUXp3--

--------------31QIJC0szw3TXVlFhNmmvLw9
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmSetT8FAwAAAAAACgkQlh/E3EQov+CN
Qg/+KlH96aEpdTWE4I10bRtY7YDL6RLCkgbhpnCgX6Fg2dkONKQY//FRqfzfh1GVqQZ9EJo4Gsbm
mcjQ60tJBrDN2/lRYJkx/VYRwy7ANhh9tEhPGZ4CqdV4P7zdTU1QcYx47ayMiyZPLzUw4q3YF1vY
j0RwKvWFcPvmV//UEh4OlkSvgk+g+5lxJgmw/ixNl/Trodh+TTfrO890dgFWdXbMkfipebBkYVDO
BiwivkMu2YXtb/qGl+To4q0l0z7U9iV7riAUAQcAFn9BQqMpDOThDO1OxTVxVjH43eBtRSjK/Tyt
s/tRm+piiiOGVDrhMv4i4KbeEsO/AaZ/qRIq87hwG0w9pai85RsXRN5L52KoEUhLbQ7Ylm+p/KHW
zhWTcx3Pv6DK0JLqPDNseUR6v9Z7EBoS8pphWpF7uBQm7+DmAyWVRVBg/iNxLlydZ8KywvobZyl4
5hGagbaf0BJcdgma+fkRghsZq9/MbMJXwiEJAUcsuOq8zSNUHcOTxn5Qb+C/xwDUK2iAWFjzqQxx
qOtWb77dtCIuWFtR1Ox8N4/RChcmuYQzSZxv93Xpp30WR3O/177yDnuOGlOJKTjCGU/FhVcfag/6
Tl54qmWWPhApmYrTmCSGtO0a4YtfSfKDEa3tySn6Rs2yZA1l68TcDKIqwFZfnsAm4+XENF3O/6DL
ArQ=
=pTBo
-----END PGP SIGNATURE-----

--------------31QIJC0szw3TXVlFhNmmvLw9--
