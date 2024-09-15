Return-Path: <linux-arch+bounces-7329-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 785DB9796DF
	for <lists+linux-arch@lfdr.de>; Sun, 15 Sep 2024 15:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 266AF1F21A15
	for <lists+linux-arch@lfdr.de>; Sun, 15 Sep 2024 13:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970D51C68A6;
	Sun, 15 Sep 2024 13:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRkIar9R"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C3914286;
	Sun, 15 Sep 2024 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726408307; cv=none; b=l25oO3nSugrL4w2e8KRuJzjSDagayyv4pArfoylr8SXYNWOgCVvr/dUWsROBmkUOBbzBjHCaAmlVSyfO5ccPYqJ1NLl7uqoalE+j1SVLxYGUvh4zzcp6H7pu4C/uRXAu5tLyo2994tceLb5Kx7Mo3ynSGpOBwqw3m8IZaQfH1MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726408307; c=relaxed/simple;
	bh=q7WJquAI08+CAD5lP6bdNehob9Dq1wPKxQPjeFRtiiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcnXow0D86xKJDLQFT7GN7xZvlyF4TJg5Y6ilnHy2FZbX8T72QS0DVTHPUNAni0VoaCwpXv6t6dXOMOd+Nxk/VHg8n+PRJ7GlwXKvRI8bejnK+W4qKLEHMR8bAUzXa5KzHXDJ5BkA5Zn4ErnysMN7aCKHY2PVumxjZyfzCnNOr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRkIar9R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666C4C4CEC3;
	Sun, 15 Sep 2024 13:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726408306;
	bh=q7WJquAI08+CAD5lP6bdNehob9Dq1wPKxQPjeFRtiiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DRkIar9RFkBNG39Lg4VF36+C0l1NwYSaEE09Z1SxGxc6M4S+jx9O3QiS3XE0iEOXa
	 dugg4+gux8cHvhMy415EwhG2oqeI29OZXErerIPWPPLxGdjDxioHvmSB5SFgMR8cmZ
	 GF890/YHKLL0YWKx3z2y3nIavnufDvUSXph8DwoVC1aciO37Nuj9Dl/4U3xgMBW1Vr
	 QqbWqbJwbZ+B8JLq+POjgebhgVzaYSVrG+oX+aypioA+ScnFYEAUCNxQIIMCRKMIR8
	 1d75vfMvgyrvMLYGrv0O59GREHzSdXP1f5IYJf2XBPq1KtNNCfQ4hdGzn/h6TRc0iB
	 7g69hrbWPmj5g==
Date: Sun, 15 Sep 2024 16:48:27 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>,
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
Subject: Re: [PATCH v3 7/8] execmem: add support for cache of large ROX pages
Message-ID: <Zublq4tR0q7lvicK@kernel.org>
References: <20240909064730.3290724-1-rppt@kernel.org>
 <20240909064730.3290724-8-rppt@kernel.org>
 <CAMj1kXG_Z=7B_eDAk3vhtDjfcnka3AoSKNzvFQDzpvYY2EyVfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXG_Z=7B_eDAk3vhtDjfcnka3AoSKNzvFQDzpvYY2EyVfg@mail.gmail.com>

Hi Ard,

On Fri, Sep 13, 2024 at 05:00:42PM +0200, Ard Biesheuvel wrote:
> Hi Mike,
> 
> On Mon, 9 Sept 2024 at 08:51, Mike Rapoport <rppt@kernel.org> wrote:

...

> > +static void execmem_fill_trapping_insns(void *ptr, size_t size, bool writable)
> > +{
> > +       if (execmem_info->fill_trapping_insns)
> > +               execmem_info->fill_trapping_insns(ptr, size, writable);
> > +       else
> > +               memset(ptr, 0, size);
> 
> Does this really have to be a function pointer with a runtime check?
> 
> This could just be a __weak definition, with the arch providing an
> override if the memset() is not appropriate.

I prefer to keep this a method in execmem_info rather that have a __weak
definition that architectures can override.

This is not on the hot path, so I don't think a runtime check here would
matter. Still, I can fill in a default with memset at init time.

-- 
Sincerely yours,
Mike.

