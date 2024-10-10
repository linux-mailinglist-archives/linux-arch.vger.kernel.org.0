Return-Path: <linux-arch+bounces-7958-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 584DF998249
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 11:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03DC21F21E64
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 09:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23BD1B3725;
	Thu, 10 Oct 2024 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOVNNKtr"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E16919F41D;
	Thu, 10 Oct 2024 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728552807; cv=none; b=qPbpPVDQ+a8w6ozik17wcF4sHnzlSlMtYbOOBirI1CMQ7+FaASMvxnkQT84rDIHBrntHdnO4iEosLxOUZQa8SmUQGYr9DaJv+xEzR3v4/zcN8qEY9NRQaAZsDCe73IqkOWfDbNaxYTazOrc7k0bSNL6zeym/myyb35m2V6Bfp5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728552807; c=relaxed/simple;
	bh=IHjj8Pm1cvim8ImsaUaQl0ADY0QKS9kDKJZxcyI9510=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/kr7K7j/QChCjIu/QlHZg+ZRwrQVwQxKsyHLxgkTbFOEYPnBEgIqKDJxaMzUqyKWyjV/9jfdPxGIV2KeMOft14D/2mFu75sW25ifO3tF+kcunTi0J88LrnA4YI+JF9sL/alYVzkHMgepippNUT45QyNC9v5b6Aey+zKF7CbpTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOVNNKtr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18111C4CEC5;
	Thu, 10 Oct 2024 09:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728552807;
	bh=IHjj8Pm1cvim8ImsaUaQl0ADY0QKS9kDKJZxcyI9510=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TOVNNKtrf8daQuuMacjY7pAlRlt/k4vb7wjQCQYF0aVuw/4MxtY1IEDmecYy869WA
	 eL70bjSLCWzeSg87onzBIfUU+BSv9+MhwYkC/eIJ924jg8Lyc5Ubk1r7GreDoZptDJ
	 teVpdajxre4MsBPJA9mql4sRA7irY3J0uloNZaSVW+zDmxt4CzZVh6D1UOnW7YD45l
	 /XMlYCHBMS9YgkvBhtdnENr2FDWIvohUoNzgrqIpRpXIOWraQQuc8IrP9OJlfmnsWJ
	 /Y7TcehyVVbI3ky02lFC2Bu9TlmKaTridXnO8cdxvFKPK24cuDB2/RZZ9PsqYrxZV2
	 Py4W9D9Jti/XA==
Date: Thu, 10 Oct 2024 12:29:39 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v5 7/8] execmem: add support for cache of large ROX pages
Message-ID: <Zweeg3oc-zrrG_D9@kernel.org>
References: <20241009180816.83591-1-rppt@kernel.org>
 <20241009180816.83591-8-rppt@kernel.org>
 <20241009132427.5c94fb5942bae3832446bca5@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009132427.5c94fb5942bae3832446bca5@linux-foundation.org>

On Wed, Oct 09, 2024 at 01:24:27PM -0700, Andrew Morton wrote:
> On Wed,  9 Oct 2024 21:08:15 +0300 Mike Rapoport <rppt@kernel.org> wrote:
> 
> > Using large pages to map text areas reduces iTLB pressure and improves
> > performance.
> 
> Are there any measurable performance improvements?

I don't have any numbers, I just followed the common sense of "less TLB
entries is better" and relied on Thomas comments from previous discussions.
 
> What are the effects of this series upon overall memory consumption?
 
There will be some execmem cache fragmentation and an increase in memory
consumption. It depends on the actual modules loaded and how large it the
fragmentation.

For a set of pretty randomly chosen modules where most come from
net/netfilter I see an increase from 19M to 25M.

> The lack of acks is a bit surprising for a v5 patch, but I'll add all
> this to mm.git for some testing, thanks.
> 

-- 
Sincerely yours,
Mike.

