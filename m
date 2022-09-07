Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2675B0DE5
	for <lists+linux-arch@lfdr.de>; Wed,  7 Sep 2022 22:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiIGUQ2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Sep 2022 16:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiIGUQ1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Sep 2022 16:16:27 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5085579EC5;
        Wed,  7 Sep 2022 13:16:21 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.49.87]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MbRwP-1p39QX2McD-00bvPR; Wed, 07 Sep 2022 22:16:00 +0200
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 7D65A3C09F;
        Wed,  7 Sep 2022 22:15:59 +0200 (CEST)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id D363E3C6B; Wed,  7 Sep 2022 22:15:57 +0200 (CEST)
Date:   Wed, 7 Sep 2022 22:15:57 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 0/8] kbuild: various cleanups
Message-ID: <Yxj7/WxCcdIuEHG6@bergen.fjasle.eu>
References: <20220906061313.1445810-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hKJQcIhkK02ICY+m"
Content-Disposition: inline
In-Reply-To: <20220906061313.1445810-1-masahiroy@kernel.org>
Jabber-ID: nicolas@jabber.no
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:mbqiW6nNSfkXCdVLPO8j3hNgZZIVQ1f1O++++JHzjgbvY9BZEzT
 SqyvfsK4aLzPqnKZYAWOXMsZ7Lyn0mbOm5HUiU2OH0BVQMuCFV1ttNeUhauHfagMxXm54o2
 yovLgjZT3J+yEBleshK6EouI/LRruJS1+dB7d384uUkG8+AJ2c317iySqSXEtyHkcultoDV
 5LzreVoBV3pnM5ZFsP67g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cX8yd2ZMl0g=:ebJ6VZCE2BGeky+xTBJLyh
 DzBraCzGk+5FDXx7AodA3YUN5Yx86iOGfMOXZ2aWPiK4LTP8ukkFbVQK2NfWjl1V9Mx7mzN0C
 eqXNjJJTDNxhRPH9n5wNKsLodeg8Rjop9x508zGIWMbc568nnRzC44398AdKllf1M/3/GWLhU
 mpD4uFlvNCUqEu2f58kaHbZtacPJPxFuoeZs8yMu9qpRnbmtPGDXSRVJatTvGD/wtC3TxzEb2
 c5Ke1C64DOCkN4O5daULZTql3RrgkIVi0/meBCe7lILTQjucOyK1qS63z9fDrxu6yz3lP4bGZ
 NcP74sRgQX1VBjRudLzgcON2rHjPJTUA0DdrPB3EBPAOxQ9oAOD5L5lpU3XNZx4/cImuKr1IK
 s2rT9htW+t3gles3B8mC6t2H2GiBGyvoZj8dK0mdXFtTbYxdPHxhSsMmxw59iK4togfrjgqfJ
 eD+Vvq7ZXFN/tSH1j36vs5RRvKhCVQXzRpQRQ4kUQocA5qZ6maLZxCqEuDCPlRzjAm2gOJ87W
 KkdSbLutHWY0+a/DCJRYjYqQo4NNf9MEl43h+8dS/RZzZYktJAYuwxtlR9WL2KwJFOU+4pSb4
 8HIsgoyoeJGLr7ZBcZFRGNcsTTuExsKC768UmwhNw/9de86ZlP4TQs9I1W+IFrl5m6NL4ILTj
 jLrPN6h7YjcuKMGlrV+FVEW2jYAQfa+FoBvMo8kFWEYT+wECHYOALFsOhZ4FgqgZGx83AKu1Q
 21Wn3BJz0Qa8Y1G4im+X1rOegB/gvLUsImHfnuRZWj7bmRH88xpZRApSn0C5Vvygo1rEHkztJ
 E8cx+Ws
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--hKJQcIhkK02ICY+m
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue,  6 Sep 2022 15:13:05 +0900 Masahiro Yamada wrote:
>=20
>  - Refactor single target build to make it work more correctly
>  - Link vmlinux and modules in parallel
>  - Remove head-y syntax
>=20
>=20
> Masahiro Yamada (8):
>   kbuild: fix and refactor single target build
>   kbuild: rename modules.order in sub-directories to .modules.order
>   kbuild: move core-y and drivers-y to ./Kbuild
>   kbuild: move .vmlinux.objs rule to Makefile.modpost
>   kbuild: move vmlinux.o rule to the top Makefile
>   kbuild: unify two modpost invocations
>   kbuild: use obj-y instead extra-y for objects placed at the head
>   kbuild: remove head-y syntax

I'm not able to apply the patchset, neither on your current kbuild=20
branch nor on for-next.  What am I missing here?  Could you give me a=20
hint for a patchset base?

Thanks and kind regards,
Nicolas

--hKJQcIhkK02ICY+m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmMY+/0ACgkQB1IKcBYm
EmkEiBAAkCa2NYVixVsjRRb65SA+QAIyoK0Hes6o9vPdgIcoMVca5e4t9n6imP+C
FAdCmmv5+TZwaJyKiDI3Kv57nlrOkkumBK/PhlUUejaVXH1LUjcojXZP7GEsifEu
osbHXuP5M7Q3lpbouOm6Wicm2q45qHrEPW10Shs2wJCiwkz4T3d510/XHrrxjOwC
EyNsmIeySZw0Rze9a9ZdUZWCQ5n1KAGNhhTQdM1lv7NDDiZWr26DO/lk0ywevSLe
Wh2As7XEomTahK/ZjiX0Qxez3Zn0Fcf/t1L3zLImbIT4M/mTarOGio6C86hgbZDh
QXW8Jzq+oO09IiDm+8MWOL/0uZKxJDPyuIHa7n+6BmqXcDrvlKoNsZ231JLmOmcN
jQ6EnIEeLGc7ZIv+ZZ1rL0HkpJOqPHO9EM1x9mEqLNZRUm3OrhhTePj7Lc/+dZdT
6ysBtCitZp3wX1+7aw+/jcIjZUvZ7aZXAWBOOUTKGJueC1l0vu3Q7aP6E64gnGb7
g5S0TnHtDfoeJLJoE65o1hPwm0jxJGi5xJKOR2ptKe2+rY5B6SY8CziS216URtS8
PIVj6w1qsSljdbJdC/uUcr6CX3GP+Vl6A9OzVikHuVa83tCUU/wuFBMXbOfQ5QOQ
I4jAJMV89B3a/Mn29ey4tuxYiHXbd940SjBwIWhJV5ZBndNh56A=
=+bbr
-----END PGP SIGNATURE-----

--hKJQcIhkK02ICY+m--
