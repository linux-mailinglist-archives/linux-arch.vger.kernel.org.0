Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5728B4C12D9
	for <lists+linux-arch@lfdr.de>; Wed, 23 Feb 2022 13:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240502AbiBWMj1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Feb 2022 07:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240497AbiBWMj0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Feb 2022 07:39:26 -0500
X-Greylist: delayed 1600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Feb 2022 04:38:57 PST
Received: from mail.sf-mail.de (mail.sf-mail.de [IPv6:2a01:4f8:1c17:6fae:616d:6c69:616d:6c69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15949EBA1
        for <linux-arch@vger.kernel.org>; Wed, 23 Feb 2022 04:38:57 -0800 (PST)
Received: (qmail 25820 invoked from network); 23 Feb 2022 12:10:27 -0000
Received: from p200300cf070b2500041073fffe58035b.dip0.t-ipconnect.de ([2003:cf:70b:2500:410:73ff:fe58:35b]:33114 HELO eto.sf-tec.de) (auth=eike@sf-mail.de)
        by mail.sf-mail.de (Qsmtpd 0.38dev) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPSA
        for <guoren@kernel.org>; Wed, 23 Feb 2022 13:10:27 +0100
From:   Rolf Eike Beer <eb@emlix.com>
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        anup@brainfault.org, gregkh@linuxfoundation.org,
        liush@allwinnertech.com, wefu@redhat.com, drew@beagleboard.org,
        wangjunqiang@iscas.ac.cn, hch@lst.de, guoren@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V5 17/21] riscv: compat: vdso: Add setup additional pages implementation
Date:   Wed, 23 Feb 2022 13:12:03 +0100
Message-ID: <4379941.LvFx2qVVIh@eto.sf-tec.de>
Organization: emlix GmbH
In-Reply-To: <20220201150545.1512822-18-guoren@kernel.org>
References: <20220201150545.1512822-1-guoren@kernel.org> <20220201150545.1512822-18-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2230114.ElGaqSPkdT"; micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_FAIL,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--nextPart2230114.ElGaqSPkdT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

> @@ -66,35 +68,35 @@ static int vdso_mremap(const struct vm_special_mapping
> *sm, return 0;
>  }
>=20
> -static int __init __vdso_init(void)
> +static int __init __vdso_init(struct __vdso_info *vdso_info)
>  {
>  	unsigned int i;
>  	struct page **vdso_pagelist;
>  	unsigned long pfn;
>=20
> -	if (memcmp(vdso_info.vdso_code_start, "\177ELF", 4)) {
> +	if (memcmp(vdso_info->vdso_code_start, "\177ELF", 4)) {
>  		pr_err("vDSO is not a valid ELF object!\n");
>  		return -EINVAL;
>  	}
>=20

Does anyone actually guarantee that this is at least this 4 bytes long?

Eike
=2D-=20
Rolf Eike Beer, emlix GmbH, https://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source
--nextPart2230114.ElGaqSPkdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCYhYkkwAKCRCr5FH7Xu2t
/HZ1A/sGakdodHOoW1ysqdO2mluUIlVSczhoHppED9p5Oqf4/05LhsOcrrn6E4wn
FAbLE4CKEv7FmrqmAPFnGfZbWwZ84QdgQsHHh6uZYCAuT6R1HCWRl5SY1RaO1NOW
ry0P7NXzDWBNe9XTWbZgk51OxZLS3JtlUaiQaF+U03M5yVKtgw==
=oRLD
-----END PGP SIGNATURE-----

--nextPart2230114.ElGaqSPkdT--



