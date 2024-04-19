Return-Path: <linux-arch+bounces-3825-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C0D8AB264
	for <lists+linux-arch@lfdr.de>; Fri, 19 Apr 2024 17:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A41E91C23448
	for <lists+linux-arch@lfdr.de>; Fri, 19 Apr 2024 15:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7AC1304B6;
	Fri, 19 Apr 2024 15:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHj3fHUB"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52BC77F13;
	Fri, 19 Apr 2024 15:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541839; cv=none; b=llxUtTwdAiKq8S2FEKL8LydSacvUQ9TpvrR9IJhg6N05U6DgWqyv6AGjaWydIydVEz5g0C0lpIwrVRZkWuNf/mYF7s6xZI1D5eBUk476x9Pph/MxBKWrwKPxcSuyAi/6wqycKbzEIdg91jxUnH9NppKyaWOLzDxaonOTtiP4YfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541839; c=relaxed/simple;
	bh=4syrMVBjLG+mqSAuWdu45onjerLE6hugRcJZYIbTm9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRQOzsrj/ljKZqDXeCjzoqjDfNZ7gDiQqNMj/V3zxy6Yy3GW8lNZ8Wpj+4Ze0h9to0OYve361+ZtgU+i+EptEWjNOZhPbTulto8OduVyHbVsfZKROE8yHI0m5CxDzD1YOGYxJOieOXc7RpR1PtGT81f/avI2+EjtzQDf6o8E0W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHj3fHUB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33F9C3277B;
	Fri, 19 Apr 2024 15:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713541839;
	bh=4syrMVBjLG+mqSAuWdu45onjerLE6hugRcJZYIbTm9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OHj3fHUBZ5oW6uWZr153zLjsZ6q0yv8DxwxD0Zy4isctsEWry5XXGSfR8Vc3hMrh/
	 vizLT7qFrrEF533kmJCP3HWtZ7Qzr6mVAw251VXfA8O2WlqLyeSYgvuFfPALuIdv03
	 8KfWQePVkfruiceot7yZycnjNdoMZw4MifC81l3AU9dBYam0QRDoIaUN7a6lFYb8MN
	 K0Whze6qtl25bkJdh4oiv03gWibiSz5LhY9l5mv+w3PTDhkRKRk4JGDzV2xKnexhV7
	 tGBMGlG1WEFnNmkggVGWaWOAgxzIa+Avjitv3Mny3kNElAG5XpvzSHnQsEDp7b51Tm
	 Ziw7Ozh3aQ/+w==
Date: Fri, 19 Apr 2024 18:49:17 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Masami Hiramatsu <masami.hiramatsu@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Donald Dutile <ddutile@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nadav Amit <nadav.amit@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v4 14/15] kprobes: remove dependency on CONFIG_MODULES
Message-ID: <ZiKSffcTiP2c6fbs@kernel.org>
References: <20240411160051.2093261-1-rppt@kernel.org>
 <20240411160051.2093261-15-rppt@kernel.org>
 <20240418061615.5fad23b954bf317c029acc4d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418061615.5fad23b954bf317c029acc4d@gmail.com>

Hi Masami,

On Thu, Apr 18, 2024 at 06:16:15AM +0900, Masami Hiramatsu wrote:
> Hi Mike,
> 
> On Thu, 11 Apr 2024 19:00:50 +0300
> Mike Rapoport <rppt@kernel.org> wrote:
> 
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > 
> > kprobes depended on CONFIG_MODULES because it has to allocate memory for
> > code.
> > 
> > Since code allocations are now implemented with execmem, kprobes can be
> > enabled in non-modular kernels.
> > 
> > Add #ifdef CONFIG_MODULE guards for the code dealing with kprobes inside
> > modules, make CONFIG_KPROBES select CONFIG_EXECMEM and drop the
> > dependency of CONFIG_KPROBES on CONFIG_MODULES.
> 
> Thanks for this work, but this conflicts with the latest fix in v6.9-rc4.
> Also, can you use IS_ENABLED(CONFIG_MODULES) instead of #ifdefs in
> function body? We have enough dummy functions for that, so it should
> not make a problem.

The code in check_kprobe_address_safe() that gets the module and checks for
__init functions does not compile with IS_ENABLED(CONFIG_MODULES). 
I can pull it out to a helper or leave #ifdef in the function body,
whichever you prefer.
 
> -- 
> Masami Hiramatsu

-- 
Sincerely yours,
Mike.

