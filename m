Return-Path: <linux-arch+bounces-10671-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65672A5D167
	for <lists+linux-arch@lfdr.de>; Tue, 11 Mar 2025 22:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F34517CC4D
	for <lists+linux-arch@lfdr.de>; Tue, 11 Mar 2025 21:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8585263F31;
	Tue, 11 Mar 2025 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1iHqPEK"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504F91386DA;
	Tue, 11 Mar 2025 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741727240; cv=none; b=PL3zvAbWTUDu+7deZ69JBiNfkRyosqmvycJD0EhgsxOyVAqp1oLI+mTwQSzIpuHh8Pr08Ri+W4S/a6IDYu1RreIXmaFKkimQT1nWY7nQkaaOF9ky8YKb/475xY+f2yzm/ztIDCcujm68NPnRemQlMhHiuaQrfiwz+64CUWVvBQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741727240; c=relaxed/simple;
	bh=rNimSVN80xWe5rcUWVjkmfCgcoptPPb9Jv9OZmpPkd4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1z2akSPjKUnyHGPupSdQxL2wMGpC1BlofJAYH2/e/HwbR7yL4PglCJ/JZT/8in8IkPoEBSxy04VJw7IvJ7mjw1QRA8C/ic3jmcIvJk53lJtTsWY899Bsp/qpw3M2++lPkKdQOqHioCZjZMdureHxxQ4UK22Dx1+5ASZiGa9hLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1iHqPEK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BDBC4CEE9;
	Tue, 11 Mar 2025 21:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741727240;
	bh=rNimSVN80xWe5rcUWVjkmfCgcoptPPb9Jv9OZmpPkd4=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=C1iHqPEKFmOZ1AdRri3tQAqNRCUTPzRJDLMlo7w9miEeyKlINu4yaWAdRhzIs0paH
	 jfkQRnK0XKmpkNOb3HtMEZGNKykGUrnuj1eWXqoXCuk4rS12Ikm530MvS19u7Mf4J3
	 tH/UJQzFzlpWZeIQ8GU3qF5sOrZxvuNLkXsoHttkETnhl82ybMrj85LRdzmLv+hBla
	 wPX3Fb5aCd0lbfNzAcpKqyB8kieIZqzft75UbkCyh4kRvACkkIIDZ2qg0qRSwpfeTU
	 KbinhUeYSjsKqONFQqPFUHd8wwI3NPOSMI/Iwxdn5G8aIP9ZQgz2eFjKKr2GfyLFcr
	 AI9TcpmJNf73w==
Date: Tue, 11 Mar 2025 23:06:56 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Guo Ren <guoren@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH 10/13] arch, mm: set high_memory in free_area_init()
Message-ID: <Z9Cl8JKkRGhaRrgM@kernel.org>
References: <20250306185124.3147510-1-rppt@kernel.org>
 <20250306185124.3147510-11-rppt@kernel.org>
 <cee346ec-5fa5-4d0b-987b-413ee585dbaa@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cee346ec-5fa5-4d0b-987b-413ee585dbaa@sirena.org.uk>

Hi Mark,

On Tue, Mar 11, 2025 at 05:51:06PM +0000, Mark Brown wrote:
> On Thu, Mar 06, 2025 at 08:51:20PM +0200, Mike Rapoport wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > high_memory defines upper bound on the directly mapped memory.
> > This bound is defined by the beginning of ZONE_HIGHMEM when a system has
> > high memory and by the end of memory otherwise.
> > 
> > All this is known to generic memory management initialization code that
> > can set high_memory while initializing core mm structures.
> > 
> > Remove per-architecture calculation of high_memory and add a generic
> > version to free_area_init().
> 
> This patch appears to be causing breakage on a number of 32 bit arm
> platforms, including qemu's virt-2.11,gic-version=3.  Affected platforms
> die on boot with no output, a bisect with qemu points at this commit and
> those for physical platforms appear to be converging on the same place.

Can you share how this can be reproduced with qemu?

-- 
Sincerely yours,
Mike.

