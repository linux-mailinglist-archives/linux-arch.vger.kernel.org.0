Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85B26835C3
	for <lists+linux-arch@lfdr.de>; Tue, 31 Jan 2023 19:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjAaSzj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Jan 2023 13:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjAaSzf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Jan 2023 13:55:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610A35649C;
        Tue, 31 Jan 2023 10:55:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2F6861646;
        Tue, 31 Jan 2023 18:55:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249B8C433EF;
        Tue, 31 Jan 2023 18:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675191318;
        bh=bIDjyyvdysd52cz3wo+R2FqIpQuhXwaSP+2JinM77Zs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p4r9YCVihzZrIRlizFq96lF4LsuRcYuXyit+cVXFPxJSxGfL99cms2/SSKpvkF2Pp
         NgIawOhOvw555KfS+LAiMfG5/YT2a/THCQd4ucSFldwug8pgOxrs80vH+lCVDLHIZh
         fh6CSOEpoCrswZLqAXRWz9pZ9CFIa58ZjTeMXFlgy8V6KmgUqFk322AZ/O2du+jfxI
         cQP8VEptS2HT9jSp8zZqLDDlrzS+XSn+HUeeyHjnm0LO863o/QOiqT647VANwYetka
         9TpahVOYB0s8YL82xibnQ7Ggye7lO/va5K0QbIxfYIjwKYESn8Y2//JUV74+mpgZ7e
         krHdpZB95Rbtg==
Date:   Tue, 31 Jan 2023 18:55:07 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Brian Cain <bcain@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rich Felker <dalias@libc.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vineet Gupta <vgupta@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        x86@kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v2 4/4] mm, arch: add generic implementation of
 pfn_valid() for FLATMEM
Message-ID: <Y9lkCz73v7/iyyLj@spud>
References: <20230129124235.209895-1-rppt@kernel.org>
 <20230129124235.209895-5-rppt@kernel.org>
 <Y9lULIIOneBUFE/E@spud>
 <Y9lg7R1Yd931C+y5@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hiaCFsst32mLBZni"
Content-Disposition: inline
In-Reply-To: <Y9lg7R1Yd931C+y5@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--hiaCFsst32mLBZni
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mike,

On Tue, Jan 31, 2023 at 08:41:49PM +0200, Mike Rapoport wrote:
> On Tue, Jan 31, 2023 at 05:47:24PM +0000, Conor Dooley wrote:
> > On Sun, Jan 29, 2023 at 02:42:35PM +0200, Mike Rapoport wrote:
> > > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > >=20
> > > Every architecture that supports FLATMEM memory model defines its own
> > > version of pfn_valid() that essentially compares a pfn to max_mapnr.
> > >=20
> > > Use mips/powerpc version implemented as static inline as a generic
> > > implementation of pfn_valid() and drop its per-architecture definitio=
ns.
> > >=20
> > > Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > Acked-by: Guo Ren <guoren@kernel.org>		# csky
> > > Acked-by: Huacai Chen <chenhuacai@loongson.cn>	# LoongArch
> > > Acked-by: Stafford Horne <shorne@gmail.com>	# OpenRISC
> >=20
> > Hmm, so this landed in linux-next today and I bisected a boot failure in
> > my CI to it. However, I am not really sure if it is a real issue worth
> > worrying about as the platform it triggered on is supposed to be using
> > SPARSEMEM, but isn't.
> > I had thought that my CI was using a config with SPARSEMEM since that
> > became required for riscv defconfig builds to boot in v6.1-rc1, but I
> > must have just forgotten to add it to my $platform_defconfig builds too.
> > However, those $platform_defconfig builds continued booting without
> > SPARSEMEM enabled until today.
>=20
> The issue seems to be that the generic pfn_valid() does not take into
> account pfn_offset when it compares it with max_mapnr.
> Can you please test with the patch below?
>=20
> diff --git a/include/asm-generic/memory_model.h b/include/asm-generic/mem=
ory_model.h
> index 13d2a844d928..6796abe1900e 100644
> --- a/include/asm-generic/memory_model.h
> +++ b/include/asm-generic/memory_model.h
> @@ -26,7 +26,7 @@ static inline int pfn_valid(unsigned long pfn)
>  	extern unsigned long max_mapnr;
>  	unsigned long pfn_offset =3D ARCH_PFN_OFFSET;
> =20
> -	return pfn >=3D pfn_offset && pfn < max_mapnr;
> +	return pfn >=3D pfn_offset && (pfn - pfn_offset) < max_mapnr;
>  }
>  #define pfn_valid pfn_valid
>  #endif

Gave that a go, board is booting properly again! Feel free to add a:
Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks for the prompt fix!


--hiaCFsst32mLBZni
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY9lkCwAKCRB4tDGHoIJi
0pIDAP9nc8RsXGyfp84b29PfLE6bd1djEIZ71+YYWPrhRbOT0QEAs5hvd2Aq0mES
TzWIEs2xL7+wjwVIWLwPjr1kP0shHA0=
=AQg2
-----END PGP SIGNATURE-----

--hiaCFsst32mLBZni--
