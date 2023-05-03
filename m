Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E126F52DE
	for <lists+linux-arch@lfdr.de>; Wed,  3 May 2023 10:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjECINF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 May 2023 04:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjECINE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 May 2023 04:13:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642AF49EC;
        Wed,  3 May 2023 01:12:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 20EC9200C6;
        Wed,  3 May 2023 08:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683101555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tc9DIPq7pTkoGAht2wWI5nJunFRzyPMlSCfbCZiBK1c=;
        b=AfL6iumxVF5n6IeMDDLsMqi8GAlhyHaR3kxkrAEw5LnrYWieIJZS2G6Ts+xRLr/c8FGjyS
        m6Am9kPZxnfO7W1jhSUc3DraDg+JgcMeLiHpJczw8yyNzgIrhc7jI1xqvf/b0+WrkoYEYa
        Us6CRneW8nTxDe1t+psl10HBXWsJJ6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683101555;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tc9DIPq7pTkoGAht2wWI5nJunFRzyPMlSCfbCZiBK1c=;
        b=FGzkoeTCbAxNseTk6a0KodvewqCUifKU/cEBznf4woz4fVH8jrwLfQfXnKA+dtvcl7WpaY
        2zRnYIhzuUnF2cBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ACF2013584;
        Wed,  3 May 2023 08:12:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MDUrKXIXUmQdZwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 03 May 2023 08:12:34 +0000
Message-ID: <97bbdb2f-6245-caf2-c0f6-d628873bd6db@suse.de>
Date:   Wed, 3 May 2023 10:12:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 4/6] fbdev: Include <linux/io.h> via <asm/fb.h>
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-arch@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        arnd@arndb.de, deller@gmx.de, chenhuacai@kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        James.Bottomley@hansenpartnership.com,
        linux-m68k@lists.linux-m68k.org, geert@linux-m68k.org,
        loongarch@lists.linux.dev, vgupta@kernel.org,
        sparclinux@vger.kernel.org, kernel@xen0n.name,
        linux-snps-arc@lists.infradead.org, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org
References: <20230502130223.14719-1-tzimmermann@suse.de>
 <20230502130223.14719-5-tzimmermann@suse.de>
 <20230502195429.GA319489@ravnborg.org>
 <563673c0-799d-e353-974c-91b1ab881a22@suse.de>
 <87354dyj9i.fsf@minerva.mail-host-address-is-not-set>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <87354dyj9i.fsf@minerva.mail-host-address-is-not-set>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------dSf0EVbufBs83iVbfepPLDAU"
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------dSf0EVbufBs83iVbfepPLDAU
Content-Type: multipart/mixed; boundary="------------jY06Zzru0ezybpxu1Q2sypmE";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Javier Martinez Canillas <javierm@redhat.com>,
 Sam Ravnborg <sam@ravnborg.org>
Cc: linux-arch@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org, arnd@arndb.de,
 deller@gmx.de, chenhuacai@kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, James.Bottomley@hansenpartnership.com,
 linux-m68k@lists.linux-m68k.org, geert@linux-m68k.org,
 loongarch@lists.linux.dev, vgupta@kernel.org, sparclinux@vger.kernel.org,
 kernel@xen0n.name, linux-snps-arc@lists.infradead.org, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org
Message-ID: <97bbdb2f-6245-caf2-c0f6-d628873bd6db@suse.de>
Subject: Re: [PATCH v3 4/6] fbdev: Include <linux/io.h> via <asm/fb.h>
References: <20230502130223.14719-1-tzimmermann@suse.de>
 <20230502130223.14719-5-tzimmermann@suse.de>
 <20230502195429.GA319489@ravnborg.org>
 <563673c0-799d-e353-974c-91b1ab881a22@suse.de>
 <87354dyj9i.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87354dyj9i.fsf@minerva.mail-host-address-is-not-set>

--------------jY06Zzru0ezybpxu1Q2sypmE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMDMuMDUuMjMgdW0gMDk6MTkgc2NocmllYiBKYXZpZXIgTWFydGluZXogQ2Fu
aWxsYXM6DQo+IFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPiB3cml0
ZXM6DQo+IA0KPiBIZWxsbyBUaG9tYXMsDQo+IA0KPj4gQW0gMDIuMDUuMjMgdW0gMjE6NTQg
c2NocmllYiBTYW0gUmF2bmJvcmc6DQo+Pj4gT24gVHVlLCBNYXkgMDIsIDIwMjMgYXQgMDM6
MDI6MjFQTSArMDIwMCwgVGhvbWFzIFppbW1lcm1hbm4gd3JvdGU6DQo+IA0KPiBbLi4uXQ0K
PiANCj4+Pj4gICAgI2luY2x1ZGUgPGxpbnV4L2NvbnNvbGUuaD4gLyogV2h5IHNob3VsZCBm
YiBkcml2ZXIgY2FsbCBjb25zb2xlIGZ1bmN0aW9ucz8gYmVjYXVzZSBjb25zb2xlX2xvY2so
KSAqLw0KPj4+PiAgICAjaW5jbHVkZSA8dmlkZW8vdmdhLmg+DQo+Pj4+ICAgIA0KPj4+PiAr
I2luY2x1ZGUgPGFzbS9mYi5oPg0KPj4+DQo+Pj4gV2hlbiB3ZSBoYXZlIGEgaGVhZGVyIGxp
a2UgbGludXgvZmIuaCAtIGl0IGlzIG15IHVuZGVyc3RhbmRpbmcgdGhhdCBpdCBpcw0KPj4+
IHByZWZlcnJlZCB0byBpbmNsdWRlIHRoYXQgZmlsZSwgYW5kIG5vdCB0aGUgYXNtL2ZiLmgg
dmFyaWFudC4NCj4+Pg0KPj4+IFRoaXMgaXMgYXNzdW1pbmcgdGhlIGxpbnV4L2ZiLmggY29u
dGFpbnMgdGhlIGdlbmVyaWMgc3R1ZmYsIGFuZCBpbmNsdWRlcw0KPj4+IGFzbS9mYi5oIGZv
ciB0aGUgYXJjaGl0ZWN0dXJlIHNwZWNpZmljIHBhcnRzLg0KPj4+DQo+Pj4gU28gZHJpdmVy
cyB3aWxsIGluY2x1ZGUgbGludXgvZmIuaCBhbmQgdGhlbiB0aGV5IGF1dG9tYXRpY2FsbHkg
Z2V0IHRoZQ0KPj4+IGFyY2hpdGVjdHVyZSBzcGVjaWZpYyBwYXJ0cyBmcm9tIGFzbS9mYi5o
Lg0KPj4+DQo+Pj4gSW4gb3RoZXIgd29yZHMsIGRyaXZlcnMgYXJlIG5vdCBzdXBwb3NlZCB0
byBpbmNsdWRlIGFzbS9mYi5oLCBpZg0KPj4+IGxpbnV4LmZiLmggZXhpc3RzIC0gYW5kIGxp
bnV4L2ZiLmggc2hhbGwgaW5jbHVkZSB0aGUgYXNtL2ZiLmguDQo+Pj4NCj4+PiBJZiB0aGUg
YWJvdmUgaG9sZHMgdHJ1ZSwgdGhlbiBpdCBpcyB3cm9uZyBhbmQgbm90IG5lZWRlZCB0byBh
ZGQgYXNtL2ZiLmgNCj4+PiBhcyBzZWVuIGFib3ZlLg0KPj4+DQo+Pj4NCj4+PiBUaGVyZSBh
cmUgY291bnRsZXNzIGV4YW1wbGVzIHdoZXJlIHRoZSBhYm92ZSBhcmUgbm90IGZvbGxvd2Vk
LA0KPj4+IGJ1dCB0byBteSBiZXN0IHVuZGVyc3RhbmRpbmcgdGhlIGFib3ZlIGl0IHRoZSBw
cmVmZXJyZWQgd2F5IHRvIGRvIGl0Lg0KPj4NCj4+IFdoZXJlIGRpZCB5b3VoZXIgdGhpcz8g
SSBvbmx5IGtub3cgYWJvdXQgdGhpcyBpbiB0aGUgY2FzZSBvZiBhc20vaW8uaA0KPj4gdnMu
IGxpbnV4L2lvLmguDQo+Pg0KPiANCj4gSSB1bmRlcnN0YW5kIHRoYXQncyB0aGUgY2FzZSB0
b28uIEkgYmVsaWV2ZSBldmVuIGNoZWNrcGF0Y2gucGwgY29tcGxhaW5zDQo+IGFib3V0IGl0
PyAobm90IHRoYXQgdGhlIHNjcmlwdCBhbHdheXMgZ2V0IHJpZ2h0LCBidXQganVzdCBhcyBh
biBleGFtcGxlKS4NCg0KRG8geW91IGtub3cgaWYgdGhhdCdzIHRoZSBnZW5lcmFsIHJ1bGU/
IElmIHNvLCB3ZSBtaWdodCB3YW50IHRvIA0KcmVwdXJwb3NlIDxhc20vZmJpby5oPiBmb3Ig
dGhlIGZyYW1lYnVmZmVyIEkvTyBmdW5jdGlvbnMuDQoNCkJlc3QgcmVnYXJkcw0KVGhvbWFz
DQoNCj4gDQoNCi0tIA0KVGhvbWFzIFppbW1lcm1hbm4NCkdyYXBoaWNzIERyaXZlciBEZXZl
bG9wZXINClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSA0KRnJhbmtlbnN0
cmFzc2UgMTQ2LCA5MDQ2MSBOdWVybmJlcmcsIEdlcm1hbnkNCkdGOiBJdm8gVG90ZXYsIEFu
ZHJldyBNeWVycywgQW5kcmV3IE1jRG9uYWxkLCBCb3VkaWVuIE1vZXJtYW4NCkhSQiAzNjgw
OSAoQUcgTnVlcm5iZXJnKQ0K

--------------jY06Zzru0ezybpxu1Q2sypmE--

--------------dSf0EVbufBs83iVbfepPLDAU
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmRSF3IFAwAAAAAACgkQlh/E3EQov+Co
3g/6A1O5+d0Sok09homhPOuVYuX/fK3UvhI7SSV8CChfilInrDjHcBh3jZGT5VD8NdGux1i8OQxK
SNEswIVXK40SH6+Y0VAdvKHmixI6U2QTDsL7MBhKwd5zqxJaC633oR+0O5npj9Uo53fZexFuxt2V
e/CxFlEFP30w+g5h8llM8g4Orz09mTPc2adxi5sG2jxhW6W/2sln8thofU3yEW+ktvjmpe+mu8fT
72z8h3S5FP2SiZx09O6cKPR6GAf77CRPpigHnaw9SGeLDC3av+/X0Cet6toxCdExmHUKOqooBdQp
MqElnyMAn8XN5YTFfwd2IfIFVyUdgni/3Kj0NAF2OtX6Y6u3gM/zoRZu4dBoThTh3P7alznR5hHX
0rOZUuoOooOsRvjyx9nwL1zfgW5PbSrgC0RP0kka8Rbqofr7cCqLq2JxczFEOEzDZJc1c2fyw5PJ
QxN47HbhHLwTQ4vjSy9USnQgxUz5Jg9yleUgYY/BvZZjEgHJWx/h7k2U+bgjWbJYaX0KyHe8uSto
TVHJWxWdhESiQ3IqKgNzEj4iWc0Ocyeb5WdhBxWFyu3CuzN2Nr9LBsXEdDrUoTpySpABcGwOtjWJ
CdQhriQsbKyN63JDZU7KL211DvtCm4TQn7hLgIIwfJoNQcc7FvwDJYkgNXl2IVsfLHQcbDpJiGjV
J3o=
=n0cz
-----END PGP SIGNATURE-----

--------------dSf0EVbufBs83iVbfepPLDAU--
