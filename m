Return-Path: <linux-arch+bounces-12346-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 424FFAD9A75
	for <lists+linux-arch@lfdr.de>; Sat, 14 Jun 2025 08:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61845189E7A0
	for <lists+linux-arch@lfdr.de>; Sat, 14 Jun 2025 06:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658991C84CD;
	Sat, 14 Jun 2025 06:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MqXdnNm+"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D180C1E1DE2
	for <linux-arch@vger.kernel.org>; Sat, 14 Jun 2025 06:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749883141; cv=none; b=TCKw1iIKsgBljQt3yeX+ADxuQYmSnLB0r/bcFwBqI06nc/EO/QHWOaI1rNYsSOrTg5aOB7XhIywwbaAwZ5TcePYByphzwhAaKnHXsBmoUJf+n1+yyQCbVh6jQeXpmcxuqer0eYHWqV3GGdKnz7CYhC5A7ZA3gyxe3sI6TM3Ppz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749883141; c=relaxed/simple;
	bh=ET0tpyP6PrAU1OacOrq3YNe2YWuvJI83mU8Z+ljqn7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Papi9zDdPiuNzgGXim2NyuKGm0D0Qb7CutQxFu0/fto5cEKDo+3yA/Zl+bKb9VQdo7+lv0un2kbd+5yyhv0Apsmz0f43x9wTNMeF35ps5dwnml8vBOCDNKqn9ahvK2FdwlCs2rzhkCNchA6mwUgFdulHpLyVo230OuvQa8pwoCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MqXdnNm+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HThJMMG4DuZ7d/Hl32ZYTcnQ1XPuu7CGF+Y6xiwkkWU=; b=MqXdnNm+8F9ERz4GBAo9AD8JnE
	MWv/Z4An3D7UHYjBw5SyJywwl/CsqpPtoSv63BXc98GMBP3wX4c/thbT+cvw2SvJzJOHnbY/rnpiN
	bnPdPKiWFsJkovY75YgpAmoL/9rwnSkRTIIapxJzgPwzNoWOrqU5w4vPuAVjwNF+z2k9vE+BDtPXb
	vfZM9cb3MX0ZOYYOmLDcWGdIpzkGn5VrJiFuLHfMHL2cGwVlTfhTDdP+gmfzUEC/HZaPPpDsjLNjD
	KlCjrbqp5eRELa1s8tpP6xy1i+2saVHuz1cZeUYk2p/tHmbjskUZ1iH2M3QjEjhZbO1/XOjmP+Ut2
	PAjsC1VA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQKXY-00000002PcW-2D3T;
	Sat, 14 Jun 2025 06:38:56 +0000
Date: Sat, 14 Jun 2025 07:38:56 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCHES] untangling asm/param.h
Message-ID: <20250614063856.GA564958@ZenIV>
References: <20241202040207.GM3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202040207.GM3387508@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Dec 02, 2024 at 04:02:07AM +0000, Al Viro wrote:
> Currently the kernel-side include of asm/param.h is handled in four
> different ways, depending upon the architecture:
>     
> 1) alpha:
> asm/param.h resolves to arch/alpha/include/asm/param.h, which
> 	* pulls uapi/asm/param.h (resolves to arch/alpha/include/uapi/asm/param.h)
> 		* which defines HZ, EXEC_PAGESIZE, NOGROUP and MAXHOSTNAMELEN
> 	* undefines HZ
> 	* redefines HZ to CONFIG_HZ
> 	* defines USER_HZ to 1024, which is what uapi/asm/param.h had for HZ
> 	* defines CLOCKS_PER_SEC to USER_HZ
>     
> 2) arc, arm, csky, microblaze, nios2, parisc, powerpc, riscv, s390, sh, x86:
> asm/param.h resolves to (generated) arch/$ARCH/include/uapi/asm/param.h, which
> 	* pulls asm-generic/param.h, which resolves to include/asm-generic/param.h, which
> 		* pulls uapi/asm-generic/param.h (resolves to include/uapi/asm-generic/param.h)
> 			* which defines HZ, EXEC_PAGESIZE, NOGROUP and MAXHOSTNAMELEN
> 		* undefines HZ
> 		* redefines HZ to CONFIG_HZ
> 		* defines USER_HZ to 100, which is what uapi/asm-generic/param.h had for HZ
> 		* defines CLOCKS_PER_SEC to USER_HZ
>     
> 3) arm64, hexagon, m68k, mips, openrisc, sparc:
> asm/param.h resolves to arch/$ARCH/include/uapi/asm/param.h, which
> 	* defines EXEC_PAGESIZE
> 	* pulls asm-generic/param.h, which resolves to include/asm-generic/param.h, which
> 		* pulls uapi/asm-generic/param.h (resolves to include/uapi/asm-generic/param.h)
> 			* which defines HZ, NOGROUP and MAXHOSTNAMELEN
> 		* undefines HZ
> 		* redefines HZ to CONFIG_HZ
> 		* defines USER_HZ to 100, which is what uapi/asm-generic/param.h had for HZ
> 		* defines CLOCKS_PER_SEC to USER_HZ
> 
> 4) loongarch, um, xtensa:
> asm/param.h resolves to (generated) arch/$ARCH/include/asm/param.h, which
> 	* pulls asm-generic/param.h, which resolves to include/asm-generic/param.h, which
> 		* pulls uapi/asm-generic/param.h (resolves to include/uapi/asm-generic/param.h)
> 			* which defines HZ, EXEC_PAGESIZE, NOGROUP and MAXHOSTNAMELEN
> 		* undefines HZ
> 		* redefines HZ to CONFIG_HZ
> 		* defines USER_HZ to 100, which is what uapi/asm-generic/param.h had for HZ
> 		* defines CLOCKS_PER_SEC to USER_HZ
> 
> There is an additional complication for userland side of xtensa - it has
> a private copy of include/uapi/asm-generic/param.h, with extra definition
> (NGROUPS) stuck in it.
> 
> Once upon a time we used to have NGROUPS in all asm/param.h (all with the
> same value); in 2004 that got removed, along with the limit on number
> of supplementary groups.  Unfortunately, xtensa port got started out
> of tree before the purge and hadn't been merged into mainline until
> 2005, and several years down the road that was enough to escape the
> consolidation of asm/param.h.
> 
> The difference between alpha and the rest of architectures is that on
> alpha the userland HZ is not 100 but 1024.  That wouldn't be a big deal,
> but kernel-side we want the userland definition seen as USER_HZ, with
> HZ itself redefined as CONFIG_HZ.  Since nothing in the macro body gets
> expanded at #define time, there's no way to preserve the value HZ had
> been defined to - not after we redefine it.
> 
> This series massages the things to simpler and more uniform shape.
> By the end of it,
> 	* all arch/*/include/uapi/asm/param.h are either generated includes
> of <asm-generic/param.h> or a #define or two followed by such include.
> 	* no arch/*/include/asm/param.h anywhere, generated or not.
> 	* include <asm/param.h> resolves to arch/*/include/uapi/asm/param.h
> of the architecture in question (or that of host in case of uml).
> 	* include/asm-generic/param.h pulls uapi/asm-generic/param.h and
> deals with USER_HZ, CLOCKS_PER_SEC and with HZ redefinition after that.


Branch rebased to 6.16-rc1 and force-pushed to
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #headers.param

No changes in patches since the last time around; see
https://lore.kernel.org/all/20241202040207.GM3387508@ZenIV/ for the old
posting.

Folks, if nobody objects, I'm putting this stuff into -next this cycle.

