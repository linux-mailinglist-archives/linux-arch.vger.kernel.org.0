Return-Path: <linux-arch+bounces-4151-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58358BA399
	for <lists+linux-arch@lfdr.de>; Fri,  3 May 2024 01:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 010A71C218C6
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 23:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A831CF96;
	Thu,  2 May 2024 23:00:31 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.dudau.co.uk (dliviu.plus.com [80.229.23.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC341C6A7;
	Thu,  2 May 2024 23:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.229.23.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714690831; cv=none; b=MEPtpvDWf7s26QV4qi3UG6Yb3HPMrj3kQwkS2sKU1ctEjTEQ4PjDOUjmQAlQinX+k7Da7PMcbj+ejHm2pn7noKYCI+sFVKtnfZ9fn8O0mW8c5nBNQ7swkiaLqBy56f1/c3TNGPMbUaaM8jvVDf4HpL7aWAOyHLt681uQ+CzBwe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714690831; c=relaxed/simple;
	bh=RHdXinQzCxW7+a0qagt11WYAo+XBPVjylUdFscA6mww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/OYe4MMAIuuc2PCNBkOIUadGm7kp9nWv566E9aEYEH5MHHTbX4fD+lZaZyf4kslCsCeSK1wuqXgGIyGR63jGo+2diDTfQs3pQDdDYgJa7cAgJ8OC/86iID/eAz0mdyx4KHz0CAyiNWs5wk85f+IQ+TYdXONA8+BttvakZwHnyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dudau.co.uk; spf=pass smtp.mailfrom=dudau.co.uk; arc=none smtp.client-ip=80.229.23.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dudau.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dudau.co.uk
Received: from mail.dudau.co.uk (bart.dudau.co.uk [192.168.14.2])
	by smtp.dudau.co.uk (Postfix) with SMTP id 557B041D12F3;
	Thu, 02 May 2024 23:50:36 +0100 (BST)
Received: by mail.dudau.co.uk (sSMTP sendmail emulation); Thu, 02 May 2024 23:50:36 +0100
Date: Thu, 2 May 2024 23:50:36 +0100
From: Liviu Dudau <liviu@dudau.co.uk>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Donald Dutile <ddutile@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nadav Amit <nadav.amit@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Russell King <linux@armlinux.org.uk>,
	Sam Ravnborg <sam@ravnborg.org>, Song Liu <song@kernel.org>,
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
Subject: Re: [PATCH v7 00/16] mm: jit/text allocator
Message-ID: <ZjQYvOYgURx9/+d0@bart.dudau.co.uk>
References: <20240429121620.1186447-1-rppt@kernel.org>
 <Zi_K4K-j-VB_WI4i@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zi_K4K-j-VB_WI4i@bombadil.infradead.org>

On Mon, Apr 29, 2024 at 09:29:20AM -0700, Luis Chamberlain wrote:
> On Mon, Apr 29, 2024 at 03:16:04PM +0300, Mike Rapoport wrote:
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > 
> > Hi,
> > 
> > The patches are also available in git:
> > https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=execmem/v7
> > 
> > v7 changes:
> > * define MODULE_{VADDR,END} for riscv32 to fix the build and avoid
> >   #ifdefs in a function body
> > * add Acks, thanks everybody
> 
> Thanks, I've pushed this to modules-next for further exposure / testing.
> Given the status of testing so far with prior revisions, in that only a
> few issues were found and that those were fixed, and the status of
> reviews, this just might be ripe for v6.10.

Looks like there is still some work needed. I've picked up next-20240501
and on arch/mips with CONFIG_MODULE_COMPRESS_XZ=y and CONFIG_MODULE_DECOMPRESS=y
I fail to load any module:

# modprobe rfkill
[11746.539090] Invalid ELF header magic: != ELF
[11746.587149] execmem: unable to allocate memory
modprobe: can't load module rfkill (kernel/net/rfkill/rfkill.ko.xz): Out of memory

The (hopefully) relevant parts of my .config:

CONFIG_HAVE_KERNEL_XZ=y
CONFIG_MIPS=y
CONFIG_RALINK=y
CONFIG_SOC_MT7621=y
CONFIG_EXECMEM=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_MODULES=y
# CONFIG_MODULE_DEBUG is not set
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS_NONE is not set
# CONFIG_MODULE_COMPRESS_GZIP is not set
CONFIG_MODULE_COMPRESS_XZ=y
# CONFIG_MODULE_COMPRESS_ZSTD is not set
CONFIG_MODULE_DECOMPRESS=y
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODULES_TREE_LOOKUP=y


Best regards,
Liviu


> 
>   Luis
> 

-- 
Everyone who uses computers frequently has had, from time to time,
a mad desire to attack the precocious abacus with an axe.
       	   	      	     	  -- John D. Clark, Ignition!

