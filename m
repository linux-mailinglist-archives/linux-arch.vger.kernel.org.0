Return-Path: <linux-arch+bounces-10963-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062EFA6967D
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 18:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4FD37A41F9
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 17:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7A41F8751;
	Wed, 19 Mar 2025 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9biRIG4"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43921EF384;
	Wed, 19 Mar 2025 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742405420; cv=none; b=J3Ej9vwA75SRTicQgWAzQQiQYzWbEESBcDaqA12Y8UFTI8PQVNECAk61dq/VfFCdFufbuPK+357CbGnXZQLlUVIkYosxJt0/ZNZ/4byLkYbsNKXRfNYvxU1jZkX9ZYL/fuL3nvqqVuA7u9hl36UmiO+EZ45G3vptjzzXLLIJXjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742405420; c=relaxed/simple;
	bh=gpKrn8HW8AZZySNjAdZoJyOHfdkLfMonlBIG0pb7rJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6Z9lECtmiHJMXN2dt2cxdDs9aUGJiOdDlsL2/D404PfPHhXD5W+9pyZIz19nMGxWth7iSa41aSa9fg7w1qM1KkQaUQtMciygs3bNTsFER2ueWwd3+T3LpvkJOeRXixLTC1v4+fqDhWPCX8cew8uwVhkQCsaD4hHW3LXcsAByRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9biRIG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4230AC4CEEC;
	Wed, 19 Mar 2025 17:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742405418;
	bh=gpKrn8HW8AZZySNjAdZoJyOHfdkLfMonlBIG0pb7rJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z9biRIG4v4RALHETyvhDmvsnPST2Po+0NgCvGoxxlYmK5oqGJFq3Rp9gX67v29Wa1
	 bH7PO28pgmcU0v/QDX91o2kqmi4Ab/alUwXSnKEhUVmpijp2QXT1kbAeE/BeUTB2w4
	 DztQSBkjHjFDEOE1vXLqLSxoM+x0cOQXFjAy/9AkqphJzxmv9vEJiHhiDLT1IF9R0a
	 fvSkmrweH3Uqz5StTuzwnCRMzNnOP5xPmKGZG3FJCiX6/cCFVHJE4wc1QmxnLfYKX6
	 xZfGhbjQVQFVC+38sI2KRQZeyUXfOYxq9jp9xJit0e9jNp+XS4+tmVbVnRQlE5ZirP
	 KE1eon15QED6w==
Date: Wed, 19 Mar 2025 10:30:10 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Julian Vetter <julian@outer-limits.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org
Subject: Re: [PATCH 5/6] mips: drop GENERIC_IOMAP wrapper
Message-ID: <20250319173010.GA84652@ax162>
References: <20250315105907.1275012-1-arnd@kernel.org>
 <20250315105907.1275012-6-arnd@kernel.org>
 <20250318203906.GA4089579@ax162>
 <5b2779f8-573d-401e-817e-979e02f811d3@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b2779f8-573d-401e-817e-979e02f811d3@app.fastmail.com>

On Tue, Mar 18, 2025 at 10:13:35PM +0100, Arnd Bergmann wrote:
> Thanks for the report, I missed that the generic ioport_map() function
> is missing the PCI_IOBASE macro, we should probably remove that from
> the asm-generic/io.h header and require architectures to define it
> themselves, since the NULL fallback is pretty much always wrong.
> 
> There is also a type mismatch between the MIPS
> PCI_IOBASE/mips_io_port_base and the one that asm-generic/io.h
> expects, so I had to add a couple of extra typecasts, which
> makes it rather ugly, but the change below seems to work.

Thanks, that does make the -Wnull-pointer-arithmetic warnings disappear.
That build still fails in next-20250319 (which includes that change) at
the end with:

  $ make -skj"$(nproc)" ARCH=mips CROSS_COMPILE=mips-linux- mrproper malta_defconfig all
  ERROR: modpost: "pci_iounmap" [drivers/net/wireless/intel/ipw2x00/ipw2100.ko] undefined!

which appears related to this original change.

Cheers,
Nathan

