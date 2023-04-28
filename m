Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4764C6F1919
	for <lists+linux-arch@lfdr.de>; Fri, 28 Apr 2023 15:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346185AbjD1NNd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Apr 2023 09:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346255AbjD1NNS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Apr 2023 09:13:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D87F59D0;
        Fri, 28 Apr 2023 06:13:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E9063200A9;
        Fri, 28 Apr 2023 13:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682687594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=szrQthY9BCigQPbNERe1ChdCnHb8Pc/WkCHBMAi2mjU=;
        b=MsOQq1yC5QuTKcGQeF+votlZIKQkjH76x9Qc8EtR4YEAArFpMtgvIkV7tb6fwiHJEwTwfq
        XeOKVXSLlOj7MKddAuxgsgGRdfOLviTRhBjFLcznN6N7CKhEsEr5hi2x+XTgMwxxufFVDW
        88rN1WOJBGRMV6JuYosbl96hYEWdf+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682687594;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=szrQthY9BCigQPbNERe1ChdCnHb8Pc/WkCHBMAi2mjU=;
        b=eWt+e4Lx+jEXGwvcvse5IJi0kI8/OEzm/d6bR99BxBObsoJOOkVIqtzJCFuSd4MYTcR/8C
        aUX1NYXHaApGheAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8AA60138FA;
        Fri, 28 Apr 2023 13:13:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XdUWIWrGS2S5FAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 28 Apr 2023 13:13:14 +0000
Message-ID: <9f1a0333-2b38-aff8-b7ec-1e7e2d6f203e@suse.de>
Date:   Fri, 28 Apr 2023 15:13:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 4/5] fbdev: Include <linux/io.h> in drivers
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
References: <20230428092711.406-1-tzimmermann@suse.de>
 <20230428092711.406-5-tzimmermann@suse.de>
 <20230428130702.GD3995435@ravnborg.org>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20230428130702.GD3995435@ravnborg.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------K8mbcyK73ItkXrLpqFqbRMJT"
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------K8mbcyK73ItkXrLpqFqbRMJT
Content-Type: multipart/mixed; boundary="------------i1vI92Qck051EDO3TuJJL9FR";
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
Message-ID: <9f1a0333-2b38-aff8-b7ec-1e7e2d6f203e@suse.de>
Subject: Re: [PATCH v2 4/5] fbdev: Include <linux/io.h> in drivers
References: <20230428092711.406-1-tzimmermann@suse.de>
 <20230428092711.406-5-tzimmermann@suse.de>
 <20230428130702.GD3995435@ravnborg.org>
In-Reply-To: <20230428130702.GD3995435@ravnborg.org>

--------------i1vI92Qck051EDO3TuJJL9FR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgU2FtDQoNCkFtIDI4LjA0LjIzIHVtIDE1OjA3IHNjaHJpZWIgU2FtIFJhdm5ib3JnOg0K
PiBPbiBGcmksIEFwciAyOCwgMjAyMyBhdCAxMToyNzoxMEFNICswMjAwLCBUaG9tYXMgWmlt
bWVybWFubiB3cm90ZToNCj4+IEZiZGV2J3MgbWFpbiBoZWFkZXIgZmlsZSwgPGxpbnV4L2Zi
Lmg+LCBpbmNsdWRlcyA8YXNtL2lvLmg+IHRvIGdldA0KPj4gZGVjbGFyYXRpb25zIG9mIEkv
TyBoZWxwZXIgZnVuY3Rpb25zLiBGcm9tIHRoZXNlIGRlY2xhcmF0b25zLCBpdCBsYXRlcg0K
Pj4gZGVmaW5lcyBmcmFtZWJ1ZmZlciBJL08gaGVscGVycywgc3VjaCBhcyBmYl97cmVhZCx3
cml0ZX1bYndscV0oKSBvcg0KPj4gZmJfbWVtc2V0KCkuDQo+Pg0KPj4gVGhlIGZyYW1lYnVm
ZmVyIEkvTyBoZWxwZXJzIHByZS1kYXRlIExpbnV4JyBjdXJyZW50IEkvTyBjb2RlIGFuZCB3
aWxsDQo+PiBiZSByZXBsYWNlZCBieSByZWd1bGFyIEkvTyBoZWxwZXJzLiBQcmVwYXJlIHRo
aXMgY2hhbmdlIGJ5IGFkZGluZyBhbg0KPj4gaW5jbHVkZSBzdGF0ZW1lbnQgZm9yIDxsaW51
eC9pby5oPiB0byBhbGwgc291cmNlIGZpbGVzIHRoYXQgdXNlIHRoZQ0KPj4gZnJhbWVidWZm
ZXIgSS9PIGhlbHBlcnMuIFRoZXkgd2lsbCBzdGlsbCBnZXQgZGVjbGFyYXRpb25zIG9mIHRo
ZSBJL08NCj4+IGZ1bmN0aW9ucyBldmVuIGFmdGVyIDxsaW51eC9mYi5oPiBoYXMgYmVlbiBj
bGVhbmVkIHVwLg0KPiBXaGVuIGZiLmggdXNlcyBhIHN5bWJvbCBmcm9tIGlvLmgsIHRoZW4g
aXQgc2hhbGwgaW5jbHVkZSB0aGF0DQo+IGZpbGUgc28gaXQgaXMgc2VsZiBjb250YWluZWQu
DQo+IFNvIGl0IGlzIHdyb25nIHRvIHB1c2ggdGhlIGlvLmggaW5jbHVkZSB0byB0aGUgdXNl
cnMgb2YNCj4gZmJfe3JlYWQsd3JpdGUseHh4fS4gTWF5YmUgZmIuaCBvbmx5IHVzZXMgbWFj
cm9zIGFzIGlzIHRoZSBjYXNlIGhlcmUsDQo+IGJ1dCB0aGF0IGlzIG5vIGV4Y3VzZSBudCB0
byBpbmNsdWRlIGlvLmguDQo+IA0KPiBEcm9wIHRoZXNlIGNoYW5nZXMuDQoNCk5vIHByb2Js
ZW0uIFRoYXQgd2FzIGRvbmUgd2l0aCBhbiBleWUgb24gcmVtb3ZpbmcgdGhlIGZiXygpIG1h
Y3JvcyANCmVudGlyZWx5LiBCdXQgdGhlIGRpc2N1c3Npb24gYXJvdW5kIHBhdGNoIDUgbm93
IGdvZXMgaW4gYSBkaWZmZXJlbnQgDQpkaXJlY3Rpb24gYW55d2F5Lg0KDQpCZXN0IHJlZ2Fy
ZHMNClRob21hcw0KDQo+IA0KPj4gRHJpdmVyIHNvdXJjZQ0KPj4gZmlsZXMgdGhhdCBhbHJl
YWR5IGluY2x1ZGUgPGFzbS9pby5oPiBjb252ZXJ0IHRvIDxsaW51eC9pby5oPi4NCj4gVGhp
cyBpcyBhIG5pY2UgY2xlYW51cCAtIHdlIHNob3VsZCBrZWVwIHRoYXQuDQo+IA0KPiAJU2Ft
DQoNCi0tIA0KVGhvbWFzIFppbW1lcm1hbm4NCkdyYXBoaWNzIERyaXZlciBEZXZlbG9wZXIN
ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSA0KRnJhbmtlbnN0cmFzc2Ug
MTQ2LCA5MDQ2MSBOdWVybmJlcmcsIEdlcm1hbnkNCkdGOiBJdm8gVG90ZXYsIEFuZHJldyBN
eWVycywgQW5kcmV3IE1jRG9uYWxkLCBCb3VkaWVuIE1vZXJtYW4NCkhSQiAzNjgwOSAoQUcg
TnVlcm5iZXJnKQ0K

--------------i1vI92Qck051EDO3TuJJL9FR--

--------------K8mbcyK73ItkXrLpqFqbRMJT
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmRLxmoFAwAAAAAACgkQlh/E3EQov+DB
Sw/+NzBofbtWHCiUo4qze7+jqvl3Bn2uyszgcZ5nOK6vBK0eS2lwMGrF01oypgJ05zObhEw7BBa9
X7OOQCAHaFPD/XiVW499dO3sbBsRxPNbvmmMWGBiw6yMT3leovksVwilyAKTPsL0RO2zzbJQeP1l
8qijSwJDN1yj8XiIPWcCHOo0bP6Xn5Af0e5JewAO5g6tdUZj7t8XspfkAHx6TIfPfBgScDLBQVnG
5dbEod1W2eDXywIKj5fxpxGd3OWia7UC7YB5qnQ/1RwNa9ts6yNKxpj8OKQKXfGLS9mlTCyR4K86
5w4vSBY2pNLeI6ph2v5v+XN9WcNTVobqlUeO8tJMKUeWiB8ryGNbBn1Kn2US8wrN+vvGm7rkPMCf
VzJxBA8mschlpuzPug67pdt4SVObAol7m3dAcL4oSQgsvyyLw2Vzy5+T0a7ebl1BgXIZy4GdF+QA
mka8caTny5EYRuWO20U7S/ZXIoxZPJGLqiw+GMn68XZ9512d0eGsPZoHM+KxqPqiJxeHgqS5tmxh
P+EFlxSmUhBFG2r0+X/SjHYkTgB5Zj6bE4BHtGRAW7RtuIQ7d1F1aKcckYQ09RQZ4WdcViJscC57
hqLPSWJ2koOE0FI0wx7BLmkNGroVVfc3cWpue5dUVeFnwz5+iarvnDTywVTxMa5vRnntE0Hj4yiu
Q8w=
=drwU
-----END PGP SIGNATURE-----

--------------K8mbcyK73ItkXrLpqFqbRMJT--
