Return-Path: <linux-arch+bounces-8084-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B31B399CC15
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 15:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B1B5B21F76
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 13:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C381A2C06;
	Mon, 14 Oct 2024 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSUyMHM3"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3102231C8A;
	Mon, 14 Oct 2024 13:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728914389; cv=none; b=WS3egqDU/iSjLTMWZ/3l95DVcmDk/Bh78JQRwNAlETrBx7KSagyL69CbA+rVDDO1UnsQYiEYXiVNWdkRghh+RZpSmM2RAuftul38eliHl1HEG5bjm6E9P7E2g7E/Wlu9fPw4GkXcNk109TeXO0Uj+gghB7p+Wh1In1uj9f5T2E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728914389; c=relaxed/simple;
	bh=H9P82NUHjzhSG+q03ylKXcErnfke+kcbkRkAXEXtqss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kx2JmdhbvtqOMvU1AZyd+2Zyx6/ZzT+3dEA0L8NAXaVfHKzs+zlRzfuvZ91PSUtVYXTMVi9xy9iC+TQhakYA5Ltw3MCmw7owNXRfAsJ5G+Zt34JKrdDWINmbRi9WH/iW5QOfPJ+xts0LlOeFWXfO+UXqGzkvGWJXfNjKyR30Ptw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSUyMHM3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE44C4CEC3;
	Mon, 14 Oct 2024 13:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728914388;
	bh=H9P82NUHjzhSG+q03ylKXcErnfke+kcbkRkAXEXtqss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NSUyMHM312ILKPLeoDrkDB5PqqmMcQXJGNf/rrrQ0VjEAD4ebiRUhrIyozWQ2eGPN
	 K4ege7WiwKlk46bvSDbx03kr9XUeKzrIYI4sHwciGOxO0WMzPdKSJ6ENhrZWuDWWeY
	 GLi+EB0emlojuZERgAdKWUPgzjI84Bo+t6HxU4mNonaA5w49WHQf50KtXnMSmKMsWX
	 VOXG+zGYmKJPumw9ypG4H8TIPF5FA1wC7F43lKOpZWuVLy+l+3UHOeD0LqDjmxV0Su
	 7VJ4wdZCBX9uUsoWFr9xRbWSzq4LDNiwWQS7Z9d2YGbMNLUObt8UqFKWlzg4mwT3bi
	 W27SYygaZmeJQ==
Date: Mon, 14 Oct 2024 14:59:39 +0100
From: Will Deacon <will@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-s390@vger.kernel.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 3/9] arm64: vdso: Remove timekeeper include
Message-ID: <20241014135939.GC17505@willie-the-truck>
References: <20241010-vdso-generic-arch_update_vsyscall-v1-0-7fe5a3ea4382@linutronix.de>
 <20241010-vdso-generic-arch_update_vsyscall-v1-3-7fe5a3ea4382@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241010-vdso-generic-arch_update_vsyscall-v1-3-7fe5a3ea4382@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Oct 10, 2024 at 05:44:46PM +0200, Thomas Weiﬂschuh wrote:
> Since the generic VDSO clock mode storage is used, this header file is
> unused and can be removed.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
>  arch/arm64/kernel/vdso.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> index 706c9c3a7a50a4574e77da296e9c83e1e2a9f5ab..8ef20c16bc482e92de8098d55000c9999b89830e 100644
> --- a/arch/arm64/kernel/vdso.c
> +++ b/arch/arm64/kernel/vdso.c
> @@ -19,7 +19,6 @@
>  #include <linux/signal.h>
>  #include <linux/slab.h>
>  #include <linux/time_namespace.h>
> -#include <linux/timekeeper_internal.h>
>  #include <linux/vmalloc.h>
>  #include <vdso/datapage.h>
>  #include <vdso/helpers.h>

Acked-by: Will Deacon <will@kernel.org>

Will

