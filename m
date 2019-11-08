Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74C52F3F04
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2019 05:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfKHExC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Nov 2019 23:53:02 -0500
Received: from ozlabs.org ([203.11.71.1]:45079 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbfKHExC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 7 Nov 2019 23:53:02 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 478SZB0Shjz9s7T;
        Fri,  8 Nov 2019 15:52:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1573188777;
        bh=lsTl8lWOKmxCnD0se991UB82l6huuBGMFOozceyJHpc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Aga5bP62YWYX6iNtz585PAG4ScKlPSlTrEjqwE3ki+YzY7ybieoqKfiAYYHN3ZWFB
         dgeiWeIzKbrAc1LjDEbqb+7n6BKo8ZoNAEGb/GpuSMY/qWGblDc3ftTHDFdi/3SYk7
         f1uv5aZrwD6T5U/U9em7j4VZ9CxAvSzmWzmiTf/WhUxI4t1uwco2iMnRw+QceM6uTZ
         tLRh0cdl4StpJ6QyKwe/vbR2oz7U5o4mUFwxyUqRMMEe92kUlQJVrFAdfZZd5xU9JS
         ZYhkfWeXPzcZdut4sV7iiXkFFIh/Y1JyCFSYtdaVfsbRy5iI42riGD6QP401UVoRGe
         p7+WJZ1Mo/MGA==
Date:   Fri, 8 Nov 2019 15:52:48 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        openrisc@lists.librecores.org, linux-mtd@lists.infradead.org,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, linux-riscv@lists.infradead.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: generic-iomap tree for linux-next
Message-ID: <20191108155248.0a32a03a@canb.auug.org.au>
In-Reply-To: <20191108132000.3e7bd5b8@canb.auug.org.au>
References: <20191029064834.23438-1-hch@lst.de>
        <20191107204743.GA22863@lst.de>
        <20191108132000.3e7bd5b8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tVtmaodFaJa/ooywirx=fo/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--Sig_/tVtmaodFaJa/ooywirx=fo/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Fri, 8 Nov 2019 13:20:00 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> On Thu, 7 Nov 2019 21:47:43 +0100 Christoph Hellwig <hch@lst.de> wrote:
> >
> > can you add the generic-ioremap tree:
> >=20
> >    git://git.infradead.org/users/hch/ioremap.git
> >=20
> > to linux-next?  =20
>=20
> I assume you mean the for-next branch?

With that assumption, added from today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/tVtmaodFaJa/ooywirx=fo/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl3E9KAACgkQAVBC80lX
0GzmWwf+Klgi0tTyTa+t0RWIsOgTgCRRshcd2R+zC2TAQiqpOvNWxiNkHSOO6rPt
AIwk9/iB+0v8JHEaYe+JqqmAtlRJjfMKtLkGBCB8WLQ/Sw+V+BW+2kZfZbMDL47C
Q2NA/MqqCVxs38kWlJA+gd3xF1FJLjYYuHlhaksjzlHUVGVcCxeXRrd521DYPcwm
9ZzSoL0488rxdiISFluZ44y3nKSgX3Ye5J4DnymJod7hsctYKZvWL+GxoizD+i6m
HgzcYw5CxoMeQcS9WgBNCafeABW7i7w3jfCsmBjTNWCuUkE+Pruoct6C6G6Q5LqS
jgJAqa5QBfJCS5OsMXSaf1cZapFTkQ==
=R1aO
-----END PGP SIGNATURE-----

--Sig_/tVtmaodFaJa/ooywirx=fo/--
