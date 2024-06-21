Return-Path: <linux-arch+bounces-5001-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA57D911F1C
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jun 2024 10:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69D661F2648B
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jun 2024 08:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAAF16D4F4;
	Fri, 21 Jun 2024 08:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="nYaDaquc"
X-Original-To: linux-arch@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B4616B3B9;
	Fri, 21 Jun 2024 08:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959497; cv=none; b=AqPgWN8KafgjtFv3wU3+JZzjpFfnG8Q1dhGyAhsM1vq6p6+dgzcIYX40slwBouBAnFn3DxlX9kFuU3LxgwUbPS3ptwncfVhPn+xe/0PyszANCwqYY7FMzmmwrhyvX3t9Uf015bs2z63jhBpEmk5HK77o5ucoLtP7fYn7PzPE/oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959497; c=relaxed/simple;
	bh=RpckdAUHxpE3PguMTPlZMv4GmZLmasBaPDXDoZBRkPE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B1CA3F0EUmzrmjwx0mYeSNp8SThqYBKpd8gGnmqgacQInj3O1sksbnhDllZUiXysFcC+FfY5m7UjlfZYMs92o5oiZuyfIzarZeny55pch6+xHNKAx0gED8jzCl8uQmT7PvafQxl7Y+T7EggEubYlpDGZagSoqms3nZqTXF9UjQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=nYaDaquc; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vnRm0j85otx50gSN5LqFcKunoR/H3ua98B1Wub0g2Lg=; t=1718959493; x=1719564293; 
	b=nYaDaqucSyVb876NSrVRp8vKQ8Gio7rL52u3C9JteReAhHge663w9C8FI4MJy4UhSTZEgQoeOrC
	/v3OwEkDDyvtTF3QzkgVojyEUsorci95sFQz63qlvqh7eAsB8RKpNLS28/BIgdkjCQi+HJkSriKyE
	2AYMwbo5n+vOqE/hzI85JKoBbUu+W6Grt6xd1SQsLisACSVSJUIYIa9tk2OgTwnbI/wOy81FMKQum
	0uo24gEar31ZBfMSX6ZvJhN6ddbfnzk2Cap/eOYzwJrPXmBFicXRoWiHvrXhRN/UlEHbPOKVbiZTq
	ILs1NWlCWp/Gsu707DGha15ifXAoq9eXjdsQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1sKZsu-00000001rSo-3cOK; Fri, 21 Jun 2024 10:44:41 +0200
Received: from p5b13a475.dip0.t-ipconnect.de ([91.19.164.117] helo=suse-laptop-2.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1sKZsv-00000001cr3-0HzV; Fri, 21 Jun 2024 10:44:41 +0200
Message-ID: <366548c1a0d9749e42c0d0c993414a353c9b0b02.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 09/15] sh: rework sync_file_range ABI
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Arnd Bergmann <arnd@kernel.org>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org, Helge Deller
 <deller@gmx.de>, linux-parisc@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
 sparclinux@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Brian Cain <bcain@quicinc.com>,
 linux-hexagon@vger.kernel.org, Guo Ren <guoren@kernel.org>, 
 linux-csky@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
 linux-s390@vger.kernel.org, Rich Felker <dalias@libc.org>, 
 linux-sh@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
 linux-fsdevel@vger.kernel.org, libc-alpha@sourceware.org, 
 musl@lists.openwall.com, ltp@lists.linux.it, stable@vger.kernel.org
Date: Fri, 21 Jun 2024 10:44:39 +0200
In-Reply-To: <20240620162316.3674955-10-arnd@kernel.org>
References: <20240620162316.3674955-1-arnd@kernel.org>
	 <20240620162316.3674955-10-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Arnd,

thanks for your patch!

On Thu, 2024-06-20 at 18:23 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The unusual function calling conventions on superh ended up causing
                                              ^^^^^^
                                       It's spelled SuperH

> sync_file_range to have the wrong argument order, with the 'flags'
> argument getting sorted before 'nbytes' by the compiler.
>=20
> In userspace, I found that musl, glibc, uclibc and strace all expect the
> normal calling conventions with 'nbytes' last, so changing the kernel
> to match them should make all of those work.
>=20
> In order to be able to also fix libc implementations to work with existin=
g
> kernels, they need to be able to tell which ABI is used. An easy way
> to do this is to add yet another system call using the sync_file_range2
> ABI that works the same on all architectures.
>=20
> Old user binaries can now work on new kernels, and new binaries can
> try the new sync_file_range2() to work with new kernels or fall back
> to the old sync_file_range() version if that doesn't exist.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 75c92acdd5b1 ("sh: Wire up new syscalls.")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/sh/kernel/sys_sh32.c           | 11 +++++++++++
>  arch/sh/kernel/syscalls/syscall.tbl |  3 ++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/sh/kernel/sys_sh32.c b/arch/sh/kernel/sys_sh32.c
> index 9dca568509a5..d5a4f7c697d8 100644
> --- a/arch/sh/kernel/sys_sh32.c
> +++ b/arch/sh/kernel/sys_sh32.c
> @@ -59,3 +59,14 @@ asmlinkage int sys_fadvise64_64_wrapper(int fd, u32 of=
fset0, u32 offset1,
>  				 (u64)len0 << 32 | len1, advice);
>  #endif
>  }
> +
> +/*
> + * swap the arguments the way that libc wants it instead of

I think "swap the arguments to the order that libc wants them" would
be easier to understand here.

> + * moving flags ahead of the 64-bit nbytes argument
> + */
> +SYSCALL_DEFINE6(sh_sync_file_range6, int, fd, SC_ARG64(offset),
> +                SC_ARG64(nbytes), unsigned int, flags)
> +{
> +        return ksys_sync_file_range(fd, SC_VAL64(loff_t, offset),
> +                                    SC_VAL64(loff_t, nbytes), flags);
> +}
> diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscall=
s/syscall.tbl
> index bbf83a2db986..c55fd7696d40 100644
> --- a/arch/sh/kernel/syscalls/syscall.tbl
> +++ b/arch/sh/kernel/syscalls/syscall.tbl
> @@ -321,7 +321,7 @@
>  311	common	set_robust_list			sys_set_robust_list
>  312	common	get_robust_list			sys_get_robust_list
>  313	common	splice				sys_splice
> -314	common	sync_file_range			sys_sync_file_range
> +314	common	sync_file_range			sys_sh_sync_file_range6
                                                                 ^^^^^^ Why=
 the suffix 6 here?

>  315	common	tee				sys_tee
>  316	common	vmsplice			sys_vmsplice
>  317	common	move_pages			sys_move_pages
> @@ -395,6 +395,7 @@
>  385	common	pkey_alloc			sys_pkey_alloc
>  386	common	pkey_free			sys_pkey_free
>  387	common	rseq				sys_rseq
> +388	common	sync_file_range2		sys_sync_file_range2
>  # room for arch specific syscalls
>  393	common	semget				sys_semget
>  394	common	semctl				sys_semctl

I wonder how you discovered this bug. Did you look up the calling conventio=
n on SuperH
and compare the argument order for the sys_sync_file_range system call docu=
mented there
with the order in the kernel?

Did you also check what order libc uses? I would expect libc on SuperH miso=
rdering the
arguments as well unless I am missing something. Or do we know that the cod=
e is actually
currently broken?

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

