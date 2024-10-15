Return-Path: <linux-arch+bounces-8188-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED4299F7ED
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 22:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA74CB22753
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 20:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259F31F76D7;
	Tue, 15 Oct 2024 20:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeA6yj5h"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC27D1B3936;
	Tue, 15 Oct 2024 20:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729023120; cv=none; b=flCsEz+TU8eycGVeQoWJkRTr17a7UmKJZislmuBLfNA6sjQytuSJx6B3nGQUtgkdN+hfwDAWid6sszyIMUBwUYClyMFrF42Fyhu1byCCiPDAHKSXeCWx+8G8kEdXu9tryTz0c6KxW+OLVzyyxWiiACa2569OXbdYWfVyZ+ywkfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729023120; c=relaxed/simple;
	bh=Y6PhmBa/nN+iDUxTFqcR/Mb33RbOlJl9A4RsS6bV0b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vh7lmVVpJqvfT2SuyTn01QJQPSrNqOINo1fmqe0P++7LKpc+a7oe7d2sBQw0SCHjpZfwrGDP+Vqtlu6EVwfKHSZN3mGjoCyaqag5LelnjsPyKKzYBJcSPjHWwBpPiy/sZZb8tMw7v2E3jk9A0vxXbRHdO0Jjadx65pR0YDiQrNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeA6yj5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB4EC4CEC6;
	Tue, 15 Oct 2024 20:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729023118;
	bh=Y6PhmBa/nN+iDUxTFqcR/Mb33RbOlJl9A4RsS6bV0b4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NeA6yj5hajfLYEdkGLWG8XB5N4aid73nUjDZb/ugsyZ3AQoALVnXt8x2U69teh7bp
	 +Jxn6eME2rpnC6+5s7BU9sn0TueSyVekqQmYatz9jkvCTO794aSB0wivMugKOyBQcF
	 f12fUI4D7cG8AqwuNBz90ooW8BLJGSzfYerkziVJS4gVWwzpr6llRoBCSoxKz8d+Fs
	 0rPGTZgvQEw9IByGG03TdQUKWcviEE7gexwsotoi1Pu3fbgseCJrzYVZZZHzQHsDOS
	 xg878mky4sIBNDtU8Y7CZD0UtD4jLkQQWx+cO7Oq3WKQ8DmXAZc3hC28g+NG7SbCgU
	 uBbk2RUOwLABQ==
Date: Tue, 15 Oct 2024 13:11:54 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
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
	sparclinux@vger.kernel.org, x86@kernel.org, kdevops@lists.linux.dev
Subject: Re: [PATCH v5 7/8] execmem: add support for cache of large ROX pages
Message-ID: <Zw7MirnsHnhRveBB@bombadil.infradead.org>
References: <20241009180816.83591-1-rppt@kernel.org>
 <20241009180816.83591-8-rppt@kernel.org>
 <Zwd7GRyBtCwiAv1v@infradead.org>
 <ZwfPPZrxHzQgYfx7@kernel.org>
 <ZwjXz0dz-RldVNx0@infradead.org>
 <ZwuIPZkjX0CfzhjS@kernel.org>
 <20241013202626.81f430a16750af0d2f40d683@linux-foundation.org>
 <Zw1uBBcG-jAgxF_t@bombadil.infradead.org>
 <Zw3rDS3GRWZe4CBu@bombadil.infradead.org>
 <Zw4DlTTbz4QwhOvU@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw4DlTTbz4QwhOvU@kernel.org>

On Tue, Oct 15, 2024 at 08:54:29AM +0300, Mike Rapoport wrote:
> On Mon, Oct 14, 2024 at 09:09:49PM -0700, Luis Chamberlain wrote:
> > Mike, please run this with kmemleak enabled and running, and also try to get
> > tools/testing/selftests/kmod/kmod.sh to pass.
> 
> There was an issue with kmemleak, I fixed it here:
> 
> https://lore.kernel.org/linux-mm/20241009180816.83591-1-rppt@kernel.org/T/#m020884c1795218cc2be245e8091fead1cda3f3e4

Ah, so this was a side fix, not part of this series, thanks.

> > I run into silly boot issues with just a guest.
> 
> Was it kmemleak or something else?

Both kmemleak and the kmod selftest failed, here is a run of the test
with this patch series:

https://github.com/linux-kdevops/linux-modules-kpd/actions/runs/11352286624/job/31574722735

We now have automated tests generated when people post patches to
linux-modules, but if you give me your github username you can push
onto the linux-kdevops/linux-modules-kpd [0] repo a random branch once you
have it ready, just cp -a the linux-ci-modules/.github [1] directory onto
your branch before a push and that'll trigger a test run (you need to
git add -f .github on your Linux branch) with our self-hosted runners.

[0] https://github.com/linux-kdevops/linux-modules-kpd
[1] https://github.com/linux-kdevops/kdevops-ci-modules

  Luis

