Return-Path: <linux-arch+bounces-8083-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D381099CC0D
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 15:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98091283B6C
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 13:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A26D18453C;
	Mon, 14 Oct 2024 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLiQSRny"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B5C231C8A;
	Mon, 14 Oct 2024 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728914362; cv=none; b=qjtIjNseTc3pXdGBDZJjunkjRuGWHhN0sD1GiZGm7F/cdlSIqBjl6sYV3aoWkY/JcB6Tb7f4NcMmbBVGxQUnCAX2/oaCv7GcCO5OGwknNvuk6pYwv5xFfa2ENWf3EZietkPO7gJKfTI0+ZDFh6xiMYiJRGi+fp4HhJ9f3LqRxSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728914362; c=relaxed/simple;
	bh=OFpg+lOM6lZXKg41f2jamDsHYXkihHB1FSkYSOpNp7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/nWItRzsgfzzcu13HWRYTtBamUL8dB7WFjL2F8QjN+9uvbBDByzykx1O5/MSYbJWjkU77z51FI+2WXKPHHw2YnbS5xaUqb10GP6I9GLZgiiNqThRa2QpkdXKrsm/O5dLj+mEy2x0/tY+R0hMEuolyuCpdQ7fYYDN4IcUJEUW6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLiQSRny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93215C4CEC3;
	Mon, 14 Oct 2024 13:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728914361;
	bh=OFpg+lOM6lZXKg41f2jamDsHYXkihHB1FSkYSOpNp7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XLiQSRnyrpGh3KeRNqwVQin1xwWw8rjBh6YtiIP+ymVkvW8PlGuD4VtJIxOmpdA7B
	 kLkCXSdWO7/FV7LDmeiT3sDuHbEWfE+uDkzGg9u0jQtgPxwbFMt+IYVBxBrs8U2LC1
	 9Nadzv3qkoFqNSpWKUSyaxfFzYjt/ZSWSsyITg1OKm1SPfPzUCVpR3eToqy/TZ6K43
	 5XWZnSHQHQ7upIBccE716ZkFnzDKlzLGLucKHqBxRdpjzBny2jaw725EkRJ1uOMeI1
	 0f+RlmDrO9MpoT9zo3HWfgQn1fmyMap2Almoz8XozNC3KcwbCpAd0AZ4ckWWNQjHHO
	 bhyzWaJbPd0OQ==
Date: Mon, 14 Oct 2024 14:59:12 +0100
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
Subject: Re: [PATCH 1/9] vdso: Remove timekeeper argument of
 __arch_update_vsyscall()
Message-ID: <20241014135911.GB17505@willie-the-truck>
References: <20241010-vdso-generic-arch_update_vsyscall-v1-0-7fe5a3ea4382@linutronix.de>
 <20241010-vdso-generic-arch_update_vsyscall-v1-1-7fe5a3ea4382@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241010-vdso-generic-arch_update_vsyscall-v1-1-7fe5a3ea4382@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Oct 10, 2024 at 05:44:44PM +0200, Thomas Weiﬂschuh wrote:
> No implementation of this hook uses the passed in timekeeper anymore.
> 
> This avoids including a non-VDSO header while building the VDSO,
> which can lead to compilation errors.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
>  arch/arm64/include/asm/vdso/vsyscall.h | 3 +--
>  include/asm-generic/vdso/vsyscall.h    | 3 +--
>  kernel/time/vsyscall.c                 | 2 +-
>  3 files changed, 3 insertions(+), 5 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will

