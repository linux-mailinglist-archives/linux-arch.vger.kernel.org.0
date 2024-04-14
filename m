Return-Path: <linux-arch+bounces-3656-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A2C8A40FC
	for <lists+linux-arch@lfdr.de>; Sun, 14 Apr 2024 09:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70F4528223D
	for <lists+linux-arch@lfdr.de>; Sun, 14 Apr 2024 07:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C3F208A9;
	Sun, 14 Apr 2024 07:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmbOtwx+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D287918AEA;
	Sun, 14 Apr 2024 07:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713080216; cv=none; b=DKld9Pp49zF9Te/Svggjw8BLiGFZCOz7u0rHe2U8qj2XnDbQHkUVHehhtCUgsz8JXZ+VgAvNBOWNaPf0dUS9yw+lXrSWGWFA3V3oafYA2thwmSrVg/OEtza6mUfFrvKU6ob+mk9FlzS2/jiIgWnazny2j7vTK1g6FcANOl2JEzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713080216; c=relaxed/simple;
	bh=BR4ur7se43kPXCUVLf6Y0OP7MVR1Rv+aJKN+ghbILUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyhNf6CF5wc2xDNZ24qXst0+eDciVjc6ncR+gJxvUiu2HYEv/CWrcH7LyIxfwsUrPFDC9S+Y/+yWOQmIBIWuauWVSKzBaQ87maGyBuarWHMsQphNOs6LkNIUFEOeQYnKAFCsBnpJq4sXLaS06SRm5kCPgQ6SuL/H5xJjEj9CcbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmbOtwx+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE94C072AA;
	Sun, 14 Apr 2024 07:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713080215;
	bh=BR4ur7se43kPXCUVLf6Y0OP7MVR1Rv+aJKN+ghbILUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pmbOtwx+uhP9H/utYH9BcUL2xj/Ka1KVJK6b6TlmVmh5wUN7RShrmZqV3fElednNr
	 PLo23bk1pmangeGEqKrrJDDbzSUKdOzPxLiI6z2Iv0Oqmq0sxdrHrCLrAzh28co+BJ
	 bbmel8ioD6s7h8xAsEjrBLYjbfLdAea51klVDqMWT34WOMNgeL1cFP32fZOxdlRVJd
	 dArt+DeqqoJkVwora/vo+eApqnXKwkDrxmR4m2ImVxkqhTucJm4Z8bchhp91LsvSAl
	 CS1YOGLHOkOTp2BnI7lfvt/mhQnS3DMYKllAZRqZvCg/EMbqu21/uaEQilGMpGUDUw
	 GnSi9UsVWFWxg==
Date: Sun, 14 Apr 2024 10:35:43 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@infradead.org>, Helge Deller <deller@gmx.de>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>, Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [RFC PATCH 5/7] x86/module: perpare module loading for ROX
 allocations of text
Message-ID: <ZhuHT3dnFTDVUpHL@kernel.org>
References: <20240411160526.2093408-1-rppt@kernel.org>
 <20240411160526.2093408-6-rppt@kernel.org>
 <Zhj58NVS/iQnPeIq@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zhj58NVS/iQnPeIq@gmail.com>

On Fri, Apr 12, 2024 at 11:08:00AM +0200, Ingo Molnar wrote:
> 
> * Mike Rapoport <rppt@kernel.org> wrote:
> 
> >  	for (s = start; s < end; s++) {
> >  		void *addr = (void *)s + *s;
> > +		void *wr_addr = addr + module_writable_offset(mod, addr);
> 
> So instead of repeating this pattern in a dozen of places, why not use a 
> simpler method:
> 
> 		void *wr_addr = module_writable_address(mod, addr);
> 
> or so, since we have to pass 'addr' to the module code anyway.

Agree.
 
> The text patching code is pretty complex already.
> 
> Thanks,
> 
> 	Ingo

-- 
Sincerely yours,
Mike.

