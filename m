Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5805117B8
	for <lists+linux-arch@lfdr.de>; Wed, 27 Apr 2022 14:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbiD0Mkv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Apr 2022 08:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234504AbiD0Mku (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Apr 2022 08:40:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549FC56231;
        Wed, 27 Apr 2022 05:37:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B6DD5210EE;
        Wed, 27 Apr 2022 12:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651063053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d22YrOMPBSG2LqHBjxLzc0tJfU7q81NPH2zO5tSL0mM=;
        b=q06ozFDFlaFSTobMQ3P/xZuon2vddB3c0eG1Eo0R4D4mYhCCCGMzY7stC9ykSNGY+myWq9
        rteYXR3odqwpyzFZhoNlJ747E68r2Sbvc6Z3GtEAbfm9yJXDdNxeNzNqDf0geOtV2vXZUy
        IL+n+/zq+cXUXm+HBmiQLhY+Yypu5Yk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC00013A39;
        Wed, 27 Apr 2022 12:37:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id puMuOAw5aWLKQAAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 27 Apr 2022 12:37:32 +0000
Message-ID: <2a340424-29e6-8ad8-0181-f70450eecb80@suse.com>
Date:   Wed, 27 Apr 2022 14:37:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Oleksandr Tyshchenko <olekstysh@gmail.com>
References: <20220426134021.11210-1-jgross@suse.com>
 <20220426134021.11210-3-jgross@suse.com> <Ymgtb2dSNYz7DBqx@zn.tnic>
 <1c1a4a7d-a273-c3b0-3683-195f6e09a027@suse.com> <Ymk2/N/DdAyxQnV0@zn.tnic>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 2/2] virtio: replace
 arch_has_restricted_virtio_memory_access()
In-Reply-To: <Ymk2/N/DdAyxQnV0@zn.tnic>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------4yxVWCWCnmvq93XMZ043V0iC"
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------4yxVWCWCnmvq93XMZ043V0iC
Content-Type: multipart/mixed; boundary="------------Yxp0WC7XOxZjxaCFpkqA4mo2";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>, Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Christoph Hellwig <hch@infradead.org>,
 Oleksandr Tyshchenko <olekstysh@gmail.com>
Message-ID: <2a340424-29e6-8ad8-0181-f70450eecb80@suse.com>
Subject: Re: [PATCH 2/2] virtio: replace
 arch_has_restricted_virtio_memory_access()
References: <20220426134021.11210-1-jgross@suse.com>
 <20220426134021.11210-3-jgross@suse.com> <Ymgtb2dSNYz7DBqx@zn.tnic>
 <1c1a4a7d-a273-c3b0-3683-195f6e09a027@suse.com> <Ymk2/N/DdAyxQnV0@zn.tnic>
In-Reply-To: <Ymk2/N/DdAyxQnV0@zn.tnic>

--------------Yxp0WC7XOxZjxaCFpkqA4mo2
Content-Type: multipart/mixed; boundary="------------oWVjbTvpdC4UikamiFuIK0Ns"

--------------oWVjbTvpdC4UikamiFuIK0Ns
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjcuMDQuMjIgMTQ6MjgsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gV2VkLCBB
cHIgMjcsIDIwMjIgYXQgMDg6Mzc6MzFBTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IE9uIDI2LjA0LjIyIDE5OjM1LCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+Pj4gT24g
VHVlLCBBcHIgMjYsIDIwMjIgYXQgMDM6NDA6MjFQTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3
cm90ZToNCj4+Pj4gICAgLyogcHJvdGVjdGVkIHZpcnR1YWxpemF0aW9uICovDQo+Pj4+ICAg
IHN0YXRpYyB2b2lkIHB2X2luaXQodm9pZCkNCj4+Pj4gICAgew0KPj4+PiAgICAJaWYgKCFp
c19wcm90X3ZpcnRfZ3Vlc3QoKSkNCj4+Pj4gICAgCQlyZXR1cm47DQo+Pj4+ICsJcGxhdGZv
cm1fc2V0X2ZlYXR1cmUoUExBVEZPUk1fVklSVElPX1JFU1RSSUNURURfTUVNX0FDQ0VTUyk7
DQo+Pj4NCj4+PiBLaW5kYSBsb25nLWlzaCBmb3IgbXkgdGFzdGUuIEknbGwgcHJvYmFibHkg
Y2FsbCBpdDoNCj4+Pg0KPj4+IAlwbGF0Zm9ybV9zZXQoKQ0KPj4+DQo+Pj4gYXMgaXQgaXMg
aW1wbGljaXQgdGhhdCBpdCBzZXRzIGEgZmVhdHVyZSBiaXQuDQo+Pg0KPj4gT2theSwgZmlu
ZSB3aXRoIG1lLg0KPj4NCj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvbW0vbWVt
X2VuY3J5cHRfaWRlbnRpdHkuYyBiL2FyY2gveDg2L21tL21lbV9lbmNyeXB0X2lkZW50aXR5
LmMNCj4+Pj4gaW5kZXggYjQzYmMyNGQyYmI2Li42MDQzYmE2Y2QxN2QgMTAwNjQ0DQo+Pj4+
IC0tLSBhL2FyY2gveDg2L21tL21lbV9lbmNyeXB0X2lkZW50aXR5LmMNCj4+Pj4gKysrIGIv
YXJjaC94ODYvbW0vbWVtX2VuY3J5cHRfaWRlbnRpdHkuYw0KPj4+PiBAQCAtNDAsNiArNDAs
NyBAQA0KPj4+PiAgICAjaW5jbHVkZSA8bGludXgvbW0uaD4NCj4+Pj4gICAgI2luY2x1ZGUg
PGxpbnV4L21lbV9lbmNyeXB0Lmg+DQo+Pj4+ICAgICNpbmNsdWRlIDxsaW51eC9jY19wbGF0
Zm9ybS5oPg0KPj4+PiArI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtLWZlYXR1cmUuaD4NCj4+
Pj4gICAgI2luY2x1ZGUgPGFzbS9zZXR1cC5oPg0KPj4+PiAgICAjaW5jbHVkZSA8YXNtL3Nl
Y3Rpb25zLmg+DQo+Pj4+IEBAIC01NjYsNiArNTY3LDEwIEBAIHZvaWQgX19pbml0IHNtZV9l
bmFibGUoc3RydWN0IGJvb3RfcGFyYW1zICpicCkNCj4+Pj4gICAgCX0gZWxzZSB7DQo+Pj4+
ICAgIAkJLyogU0VWIHN0YXRlIGNhbm5vdCBiZSBjb250cm9sbGVkIGJ5IGEgY29tbWFuZCBs
aW5lIG9wdGlvbiAqLw0KPj4+PiAgICAJCXNtZV9tZV9tYXNrID0gbWVfbWFzazsNCj4+Pj4g
Kw0KPj4+PiArCQkvKiBTZXQgcmVzdHJpY3RlZCBtZW1vcnkgYWNjZXNzIGZvciB2aXJ0aW8u
ICovDQo+Pj4+ICsJCXBsYXRmb3JtX3NldF9mZWF0dXJlKFBMQVRGT1JNX1ZJUlRJT19SRVNU
UklDVEVEX01FTV9BQ0NFU1MpOw0KPj4+DQo+Pj4gSHVoLCB3aGF0IGRvZXMgdGhhdCBoYXZl
IHRvIGRvIHdpdGggU01FPw0KPj4NCj4+IEkgcGlja2VkIHRoZSBmdW5jdGlvbiB3aGVyZSBz
ZXZfc3RhdHVzIGlzIGJlaW5nIHNldCwgYXMgdGhpcyBzZWVtZWQgdG8gYmUNCj4+IHRoZSBj
b3JyZWN0IHBsYWNlIHRvIHNldCB0aGUgZmVhdHVyZSBiaXQuDQo+IA0KPiBXaGF0IEkgZG9u
J3QgdW5kZXJzdGFuZCBpcyB3aGF0IGRvZXMgcmVzdHJpY3RlZCBtZW1vcnkgYWNjZXNzIGhh
dmUgdG8gZG8NCj4gd2l0aCBBTUQgU0VWIGFuZCBob3cgZG9lcyBwbGF5IHRvZ2V0aGVyIHdp
dGggd2hhdCB5b3UgZ3V5cyBhcmUgdHJ5aW5nIHRvDQo+IGRvPw0KPiANCj4gVGhlIGJpZyBw
aWN0dXJlIHBscy4NCg0KQWgsIG9rYXkuDQoNCkZvciBzdXBwb3J0IG9mIHZpcnRpbyB3aXRo
IFhlbiB3ZSB3YW50IHRvIG5vdCBvbmx5IHN1cHBvcnQgdGhlIHZpcnRpbw0KZGV2aWNlcyBs
aWtlIEtWTSwgYnV0IHVzZSBncmFudHMgZm9yIGxldHRpbmcgdGhlIGd1ZXN0IGRlY2lkZSB3
aGljaA0KcGFnZXMgYXJlIGFsbG93ZWQgdG8gYmUgbWFwcGVkIGJ5IHRoZSBiYWNrZW5kIChk
b20wKS4NCg0KSW5zdGVhZCBvZiBwaHlzaWNhbCBndWVzdCBhZGRyZXNzZXMgdGhlIGd1ZXN0
IHdpbGwgdXNlIGdyYW50LWlkcyAocGx1cw0Kb2Zmc2V0KS4gSW4gb3JkZXIgdG8gYmUgYWJs
ZSB0byBoYW5kbGUgdGhpcyBhdCB0aGUgYmFzaWMgdmlydGlvIGxldmVsDQppbnN0ZWFkIG9m
IHRoZSBzaW5nbGUgdmlydGlvIGRldmljZSBkcml2ZXJzLCB3ZSBuZWVkIHRvIHVzZSBkZWRp
Y2F0ZWQNCmRtYS1vcHMuIEFuZCB0aG9zZSB3aWxsIGJlIHVzZWQgYnkgdmlydGlvIG9ubHks
IGlmIHRoZSAicmVzdHJpY3RlZA0KdmlydGlvIG1lbW9yeSByZXF1ZXN0IiBmbGFnIGlzIHNl
dCwgd2hpY2ggaXMgdXNlZCBieSBTRVYsIHRvby4gSW4gb3JkZXINCnRvIGxldCB2aXJ0aW8g
c2V0IHRoaXMgZmxhZywgd2UgbmVlZCBhIHdheSB0byBjb21tdW5pY2F0ZSB0byB2aXJ0aW8N
CnRoYXQgdGhlIHJ1bm5pbmcgc3lzdGVtIGlzIGVpdGhlciBhIFNFViBndWVzdCBvciBhIFhl
biBndWVzdC4NCg0KSFRILA0KDQoNCkp1ZXJnZW4NCg==
--------------oWVjbTvpdC4UikamiFuIK0Ns
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------oWVjbTvpdC4UikamiFuIK0Ns--

--------------Yxp0WC7XOxZjxaCFpkqA4mo2--

--------------4yxVWCWCnmvq93XMZ043V0iC
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmJpOQwFAwAAAAAACgkQsN6d1ii/Ey/b
Cgf+OFbFg23c2x3esEwpLFGK2DbchkAtehLhMC4hV+WOchRjx+cNrrBmB5wRJyksEWRaRa42I31A
vA84qya9Pv4iTNIBKA2BC8IQzwrveSLvxnQRupbnf8Pp55rLd7Q6MJ4GwSOn3JSh9gotleHr1v4+
W5Hr7/cycD30NMenQC39VauZmXbAimQjTtB+ziwCp/vBikBp9Nmw6Rb2JbK4n9vhdsSM6vzkO/Ee
16up4ta/88swh/qYj7ECcjAZ5Z8QjEkGE9aIe9iSejlhMrkfNcHsRv3PpBQZt3S3xBx1eTgDOxbK
py0az+PKVoqhazEOve+t2II48euW2CiDFjIcZaPYjA==
=uG7B
-----END PGP SIGNATURE-----

--------------4yxVWCWCnmvq93XMZ043V0iC--
