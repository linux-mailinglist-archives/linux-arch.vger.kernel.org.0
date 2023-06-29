Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C35274280F
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jun 2023 16:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjF2OQP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Jun 2023 10:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbjF2OP5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jun 2023 10:15:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB2510F8;
        Thu, 29 Jun 2023 07:15:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 115BD1F8BE;
        Thu, 29 Jun 2023 14:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688048146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q65MrPND/7yigyGkkVaQv3PQCRFF3v8RQQr5wgYKJ4U=;
        b=s5JOc8n8tpgL5OXiwnL8w6zpYIqqlCDaOLW3w88YMpIjRUxkvQkO6NRNIt9jOHN0HgF2Fq
        CEE12CMxPsuHuR2Rj56wE5TKKGpQSVoKooSGAMqklM3JJkq6OL25h3K07P4Eug37hDXLAc
        7g/kM59z8HFYepLM6955/HcgLHYADmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688048146;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q65MrPND/7yigyGkkVaQv3PQCRFF3v8RQQr5wgYKJ4U=;
        b=tEVfZk/EBx5R152Y3wRTv3qKOoinL0AeH3IvxHdRals/NwSpUpuzUq/YkJoHDuV95SXcm2
        yZ5mytzsE1+h/pAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 92DC813905;
        Thu, 29 Jun 2023 14:15:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BK8tIhGSnWS0EQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 29 Jun 2023 14:15:45 +0000
Message-ID: <f9185435-74bb-a325-8fe6-3beb51a66e0a@suse.de>
Date:   Thu, 29 Jun 2023 16:15:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 00/12] arch,fbdev: Move screen_info into arch/
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Helge Deller <deller@gmx.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@gmail.com>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        linux-mips@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongarch@lists.linux.dev,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
References: <20230629121952.10559-1-tzimmermann@suse.de>
 <4d711508-c299-49f2-8691-e75d68f2485e@app.fastmail.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <4d711508-c299-49f2-8691-e75d68f2485e@app.fastmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------CFrYrwjwiHrQCUAXlrkYN4LE"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------CFrYrwjwiHrQCUAXlrkYN4LE
Content-Type: multipart/mixed; boundary="------------LMXlbR5vBx4VnpM1p0HGCgvn";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Arnd Bergmann <arnd@arndb.de>, Helge Deller <deller@gmx.de>,
 Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@gmail.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-hyperv@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 linux-mips@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, loongarch@lists.linux.dev,
 linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Message-ID: <f9185435-74bb-a325-8fe6-3beb51a66e0a@suse.de>
Subject: Re: [PATCH 00/12] arch,fbdev: Move screen_info into arch/
References: <20230629121952.10559-1-tzimmermann@suse.de>
 <4d711508-c299-49f2-8691-e75d68f2485e@app.fastmail.com>
In-Reply-To: <4d711508-c299-49f2-8691-e75d68f2485e@app.fastmail.com>

--------------LMXlbR5vBx4VnpM1p0HGCgvn
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMjkuMDYuMjMgdW0gMTU6MzEgc2NocmllYiBBcm5kIEJlcmdtYW5uOg0KPiBP
biBUaHUsIEp1biAyOSwgMjAyMywgYXQgMTM6NDUsIFRob21hcyBaaW1tZXJtYW5uIHdyb3Rl
Og0KPj4gVGhlIHZhcmlhYmxlcyBzY3JlZW5faW5mbyBhbmQgZWRpZF9pbmZvIHByb3ZpZGUg
aW5mb3JtYXRpb24gYWJvdXQNCj4+IHRoZSBzeXN0ZW0ncyBzY3JlZW4sIGFuZCBwb3NzaWJs
eSBFRElEIGRhdGEgb2YgdGhlIGNvbm5lY3RlZCBkaXNwbGF5Lg0KPj4gQm90aCBhcmUgZGVm
aW5lZCBhbmQgc2V0IGJ5IGFyY2hpdGVjdHVyZSBjb2RlLiBCdXQgYm90aCB2YXJpYWJsZXMg
YXJlDQo+PiBkZWNsYXJlZCBpbiBub24tYXJjaCBoZWFkZXIgZmlsZXMuIERlcGVuZGVuY2ll
cyBhcmUgYXQgYmVhc2UgbG9vc2VseQ0KPj4gdHJhY2tlZC4gVG8gcmVzb2x2ZSB0aGlzLCBt
b3ZlIHRoZSBnbG9iYWwgc3RhdGUgc2NyZWVuX2luZm8gYW5kIGl0cw0KPj4gY29tcGFuaW9u
IGVkaWRfaW5mbyBpbnRvIGFyY2gvLiBPbmx5IGRlY2xhcmUgdGhlbSBvbiBhcmNoaXRlY3R1
cmVzDQo+PiB0aGF0IGRlZmluZSB0aGVtLiBMaXN0IGRlcGVuZGVuY2llcyBvbiB0aGUgdmFy
aWFibGVzIGluIHRoZSBLY29uZmlnDQo+PiBmaWxlcy4gQWxzbyBjbGVhbiB1cCB0aGUgY2Fs
bGVycy4NCj4+DQo+PiBQYXRjaCAxIHRvIDQgcmVzb2x2ZSBhIG51bWJlciBvZiB1bm5lY2Vz
c2FyeSBpbmNsdWRlIHN0YXRlbWVudHMgb2YNCj4+IDxsaW51eC9zY3JlZW5faW5mby5oPi4g
VGhlIGhlYWRlciBzaG91bGQgb25seSBiZSBpbmNsdWRlZCBpbiBzb3VyY2UNCj4+IGZpbGVz
IHRoYXQgYWNjZXNzIHN0cnVjdCBzY3JlZW5faW5mby4NCj4+DQo+PiBQYXRjaGVzIDUgdG8g
NyBtb3ZlIHRoZSBkZWNsYXJhdGlvbiBvZiBzY3JlZW5faW5mbyBhbmQgZWRpZF9pbmZvIHRv
DQo+PiA8YXNtLWdlbmVyaWMvc2NyZWVuX2luZm8uaD4uIEFyY2hpdGVjdHVyZXMgdGhhdCBw
cm92aWRlIGVpdGhlciBzZXQNCj4+IGEgS2NvbmZpZyB0b2tlbiB0byBlbmFibGUgdGhlbS4N
Cj4+DQo+PiBQYXRjaGVzIDggdG8gOSBtYWtlIHVzZXJzIG9mIHNjcmVlbl9pbmZvIGRlcGVu
ZCBvbiB0aGUgYXJjaGl0ZWN0dXJlJ3MNCj4+IGZlYXR1cmUuDQo+Pg0KPj4gRmluYWxseSwg
cGF0Y2hlcyAxMCB0byAxMiByZXdvcmsgZmJkZXYncyBoYW5kbGluZyBvZiBmaXJtd2FyZSBF
RElEDQo+PiBkYXRhIHRvIG1ha2UgdXNlIG9mIGV4aXN0aW5nIGhlbHBlcnMgYW5kIHRoZSBy
ZWZhY3RvcmVkIGVkaWRfaW5mby4NCj4+DQo+PiBUZXN0ZWQgb24geDg2LTY0LiBCdWlsdCBm
b3IgYSB2YXJpZXR5IG9mIHBsYXRmb3Jtcy4NCj4gDQo+IFRoaXMgYWxsIGxvb2tzIGxpa2Ug
YSBuaWNlIGNsZWFudXAhDQoNCkkgZ3Vlc3MgdGhhdCBwYXRjaGVzIDEgdG8gNCBhcmUgdW5j
b250cm92ZXJzaWFsIGFuZCBjb3VsZCBiZSBsYW5kZWQgDQpxdWlja2x5LiBQYXRjaGVzIDEw
IHRvIDEyIGFyZSBwcm9iYWJseSBhcyB3ZWxsLg0KDQo+IA0KPj4gRnV0dXJlIGRpcmVjdGlv
bnM6IHdpdGggdGhlIHBhdGNoc2V0IGluIHBsYWNlLCBpdCB3aWxsIGJlY29tZSBwb3NzaWJs
ZQ0KPj4gdG8gcHJvdmlkZSBzY3JlZW5faW5mbyBhbmQgZWRpZF9pbmZvIG9ubHkgaWYgdGhl
cmUgYXJlIHVzZXJzLiBTb21lDQo+PiBhcmNoaXRlY3R1cmVzIGRvIHRoaXMgYnkgdGVzdGlu
ZyBmb3IgQ09ORklHX1ZULCBDT05GSUdfRFVNTVlfQ09OU09MRSwNCj4+IGV0Yy4gQSBtb3Jl
IHVuaWZvcm0gYXBwcm9hY2ggd291bGQgYmUgbmljZS4gV2Ugc2hvdWxkIGFsc28gYXR0ZW1w
dA0KPj4gdG8gbWluaW1pemUgYWNjZXNzIHRvIHRoZSBnbG9iYWwgc2NyZWVuX2luZm8gYXMg
bXVjaCBhcyBwb3NzaWJsZS4gVG8NCj4+IGRvIHNvLCBzb21lIGRyaXZlcnMsIHN1Y2ggYXMg
ZWZpZmIgYW5kIHZlc2FmYiwgd291bGQgcmVxdWlyZSBhbiB1cGRhdGUuDQo+PiBUaGUgZmly
bXdhcmUncyBFRElEIGRhdGEgY291bGQgcG9zc2libHkgbWFkZSBhdmFpbGFibGUgb3V0c2lk
ZSBvZiBmYmRldi4NCj4+IEZvciBleGFtcGxlLCB0aGUgc2ltcGxlZHJtIGFuZCBvZmRybSBk
cml2ZXJzIGNvdWxkIHByb3ZpZGUgc3VjaCBkYXRhDQo+PiB0byB1c2Vyc3BhY2UgY29tcG9z
aXRvcnMuDQo+IA0KPiBJIHN1c3BlY3QgdGhhdCBtb3N0IGFyY2hpdGVjdHVyZXMgdGhhdCBw
cm92aWRlIGEgc2NyZWVuX2luZm8gb25seQ0KPiBoYXZlIHRoaXMgaW4gb3JkZXIgdG8gY29t
cGlsZSB0aGUgZnJhbWVidWZmZXIgZHJpdmVycywgYW5kIHByb3ZpZGUNCj4gaGFyZGNvZGVk
IGRhdGEgdGhhdCBkb2VzIG5vdCBldmVuIHJlZmxlY3QgYW55IHJlYWwgaGFyZHdhcmUuDQoN
ClRoYXQncyBxdWl0ZSBwb3NzaWJsZS4gT25seSB4ODYncyBib290cGFyYW0gYW5kIEVGSSBj
b2RlIHNldHMgDQpzY3JlZW5faW5mbyBmcm9tIGV4dGVybmFsIGRhdGEuIFRoZSByZXN0IGlz
IGhhcmRjb2RlZC4gQSBudW1iZXIgb2YgDQphcmNoaXRlY3R1cmVzIHByb3RlY3Qgc2NyZWVu
X2luZm8gd2l0aCBDT05GSUdfVlQsIENPTkZJR19EVU1NWV9DT05TT0xFLCANCmV0Yy4gSW4g
YSBsYXRlciBwYXRjaHNldCwgSSB3YW50ZWQgdG8gY2hhbmdlIHRoaXMgc3VjaCB0aGF0IHRo
ZXNlIHVzZXJzIA0Kb2Ygc2NyZWVuX2luZm8gd291bGQgZW5hYmxlIHRoZSBmZWF0dXJlIHZp
YSBzZWxlY3QgaW4gdGhlaXIgS2NvbmZpZy4NCg0KRG8geW91IGtub3cgdGhlIHJlYXNvbiBm
b3IgdGhpcyBicmFuY2ggaW4gZHVtbXljb246DQoNCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4u
Y29tL2xpbnV4L3Y2LjQvc291cmNlL2RyaXZlcnMvdmlkZW8vY29uc29sZS9kdW1teWNvbi5j
I0wyMQ0KDQpXaGF0IGlzIHNwZWNpYWwgYWJvdXQgYXJtIHRoYXQgZHVtbXljb24gdXNlcyB0
aGUgc2NyZWVuaW5mbz8NCg0KPiANCj4gV2UgY2FuIHByb2JhYmx5IHJlZHVjZSB0aGUgbnVt
YmVyIG9mIGFyY2hpdGVjdHVyZXMgdGhhdCBkbyB0aGlzDQo+IGEgbG90LCBlc3BlY2lhbGx5
IGlmIHdlIGdldCBFRkkgb3V0IG9mIHRoZSBwaWN0dXJlLg0KDQpDYW4geW91IGVsYWJvcmF0
ZT8NCg0KQmVzdCByZWdhcmRzDQpUaG9tYXMNCg0KPiANCj4gICAgICAgIEFybmQNCg0KLS0g
DQpUaG9tYXMgWmltbWVybWFubg0KR3JhcGhpY3MgRHJpdmVyIERldmVsb3Blcg0KU1VTRSBT
b2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJIDQpGcmFua2Vuc3RyYXNzZSAxNDYsIDkw
NDYxIE51ZXJuYmVyZywgR2VybWFueQ0KR0Y6IEl2byBUb3RldiwgQW5kcmV3IE15ZXJzLCBB
bmRyZXcgTWNEb25hbGQsIEJvdWRpZW4gTW9lcm1hbg0KSFJCIDM2ODA5IChBRyBOdWVybmJl
cmcpDQo=

--------------LMXlbR5vBx4VnpM1p0HGCgvn--

--------------CFrYrwjwiHrQCUAXlrkYN4LE
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmSdkhAFAwAAAAAACgkQlh/E3EQov+Cu
Tg//bygjjxurZdvVdIVUnqm52gTBbmuqrg1+0a2A1NhLl3ItDa+Fa8VdwKZMYjT82NZWf6ztWWO+
3ld/w0vPq53sC5ezkR4UqQVTns8H+SQfIDfmrzAUaZAA/nuW3YSUqb7bdxT20Y5jusJRTE1SwAVr
e10d9BwV6PFQhW+5B2nKjA+l6ydKSaFtuuk+LcqcPk3hUhjkjCbyde0wQ/xz8vYyQDUnDDu3ps1m
2eHKIiZYKwio5jBjDHu+VJXenpJlUKoY73Gg07rYULY2oF8gsVojrvrOdPdChtQIICQ8Tfcopx2p
CZK3p6e6BENp3jZ+LFxTK5vGhU2H3Sqca+8lre6km/Rvndo25RRp0Lx4zQAK4qev3ED7v9IYl5jA
QypuI5zTr/ZM2gCNznpmRh2nPgI0ANwxXiQ1mwUGNF8WQXcN1AzPXRDol1cgfmR57hBKmSA+hB8u
NtLxVCUy25j+hFBKSy//2mP1Fs2/rb6Lo5FysOtYvI09HHNN+1LGhVNQ88E2ro22tNMWMKF+3Cws
NNYJoCXaihkeLtqPXup+tUh3zl2H9QoVMephO9RQlUKK3TyMYW64yXoCpxkeqTdWdFJAHOMgb4DS
PKAUhXyJn0b4KQ61EqybTsYXnaIt/LglY+Itk1p0OqlJp8p7Pl0LiD520nE2QkO4XKRkehoctFaN
zKs=
=lOlT
-----END PGP SIGNATURE-----

--------------CFrYrwjwiHrQCUAXlrkYN4LE--
