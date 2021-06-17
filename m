Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C533AA885
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jun 2021 03:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhFQBZs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Jun 2021 21:25:48 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43453 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230239AbhFQBZs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 16 Jun 2021 21:25:48 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4G547t2Dcmz9sRK;
        Thu, 17 Jun 2021 11:23:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1623893019;
        bh=Lcb2dMbhechCmOAsVMjFJF1Q5m5ZN1yIgPu4v2lWEzQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FFuIqQ0d1IO7+8c2R7C3UaIAbs4XmgHZMW3/k0A6cst4tmWTj9zRbGKt0endBnJfv
         i+gOLWVxcLe5F6nNFxQsnf4C0RpOSfPvPfYqM31AayDVqzt5E+lsZ5mqz9xsfoqJUw
         64tp+I+skZgMSfoaB9sXjrumzoqZ1RCW5gWRnXTD9+uNlsbta/JxUtXin7p0//9y6T
         ZliYQGiLHKP2r5dduauCHB1vQet6wt7Ln2L3PcD/WDuhbXqtivyPnecha9VHZW/wnm
         MtULaIvomxoZSUmYwSsDNBnfB4p6wi9JywyqsN8SvtDFUrD/MNK/27rsIp+PY6kJ8i
         tNGPZO4W/Facw==
Date:   Thu, 17 Jun 2021 11:23:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        kernel test robot <lkp@intel.com>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, kbuild-all@lists.01.org
Subject: Re: +
 mm-rename-pud_page_vaddr-to-pud_pgtable-and-make-it-return-pmd_t.patch
 added to -mm tree
Message-ID: <20210617112337.465c2607@canb.auug.org.au>
In-Reply-To: <20210616160904.cf834ee8c9e7a26008aa833e@linux-foundation.org>
References: <20210615233808.hzjGO1gF2%akpm@linux-foundation.org>
        <202106162159.MurvDMy6-lkp@intel.com>
        <87zgvpnbl7.fsf@linux.ibm.com>
        <20210616160904.cf834ee8c9e7a26008aa833e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/a/+9AWFMGRAeBWcsE/82QFB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--Sig_/a/+9AWFMGRAeBWcsE/82QFB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Wed, 16 Jun 2021 16:09:04 -0700 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> On Wed, 16 Jun 2021 19:41:32 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux=
.ibm.com> wrote:
>=20
> > We may want to fixup pgd_page_vaddr correctly later. pgd_page_vaddr() g=
ets
> > cast to different pointer types based on architecture. But for now this
> > should work? This ensure we keep the pgd_page_vaddr() same as before.  =
=20
>=20
> I'll drop
>=20
> mm-rename-pud_page_vaddr-to-pud_pgtable-and-make-it-return-pmd_t.patch
> mm-rename-p4d_page_vaddr-to-p4d_pgtable-and-make-it-return-pud_t.patch   =
      =20
>=20
> for now.

Dropped form linux-next today (along with my fix from yesterday).

--=20
Cheers,
Stephen Rothwell

--Sig_/a/+9AWFMGRAeBWcsE/82QFB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmDKpBkACgkQAVBC80lX
0GzE6Qf9F9328LVgfB4V5Iv/4uPQk5jfyblmoxIn6ZJqV0uqu+dplGIY4vT0wwV5
K1aQ3HB1ESIFEAiSXffgkj3zETi5BkR8O32X08gwXq7yYbHEWZ+pQvJfSFzU6g9g
j6xql8TjMtYUFuvNT5QWrz38nRKB5IGvAA9YDxYsJPX6RKlCjWyIkF9Iooscg5s3
2lTSr2KZ8hUXF++sM1VXUCtksGbcZsdsugOGYpi1VBwvIT+Jc/WUSO3pp5Hrb02y
gDFtYDryQiN/XIdjYCDqLWjhQ7cnjTZJY0q9j5pUjFvQdgrgmT/5n63BxxegqQ65
vUoFVdDhDmKUeJ1s8LTXpvIliUuZWg==
=zFs2
-----END PGP SIGNATURE-----

--Sig_/a/+9AWFMGRAeBWcsE/82QFB--
