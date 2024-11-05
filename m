Return-Path: <linux-arch+bounces-8849-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1179BC69F
	for <lists+linux-arch@lfdr.de>; Tue,  5 Nov 2024 08:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F563285020
	for <lists+linux-arch@lfdr.de>; Tue,  5 Nov 2024 07:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677E91FEFD9;
	Tue,  5 Nov 2024 07:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3dpbmwH"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E3C1FEFD4;
	Tue,  5 Nov 2024 07:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730790175; cv=none; b=RcJeWZ6v52G06I3IJ7catWvPxRXIlj3AmNTX2upEKe1gL281mlAVS6gvBS/Dnx3uI01DCsNpKqn9u0c9oSZV5qwNVN7DlCoeW/sTgLbBL3Eh/eN1R+gPA887izB1NONSr5EHSJL9AFi5oQBp4jyT6f++7QML7iywRBOBvn02JEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730790175; c=relaxed/simple;
	bh=vfcX72EWl1PlKyFBzjhHz5V71yaLAfzK3VjVgomZL4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uj/7jDTU/QqpD9FFIjKjnCvPfRZF9vJoxPylVeB5cmvjdCmI+cxnpcr9kIWY/H6xMRd+aj/A/5iI9dPeHF4wvcqSAQifexW70in+eKc3yObppkL/p9VI6ZIRoQCk7d1C1zWjQqppaNwnaOEV960KLEQc7l9IaQq/cGWTUHwoh24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3dpbmwH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B12C4CECF;
	Tue,  5 Nov 2024 07:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730790174;
	bh=vfcX72EWl1PlKyFBzjhHz5V71yaLAfzK3VjVgomZL4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i3dpbmwHLfd+qUmJoaWeTGPHb10DC+M0kf+DMEykGWoYpGOuSUDviaUCAAx4zIAfi
	 my4z1l/oyVoPrY5WEhvGAqrSv0MLPuXbzVIKUoMd0jh8oEVUCEONnRV4s7PDepCIp9
	 ZD54y4ohFGVDY1Cs7nPdmpyfCNtvqUqW5KJ/Ch+xipF5ZFMCAivKT3JR6Xd9V1a/4G
	 LvZ1wHQ1rlIUNyplCl+fPkOtsT/XeAFLJAPXe+EdvajpWUHCrgFIHiD89oCp0/Bkx4
	 xYtH7/sknC5+POJtdvm/YMmFy0WRYObll2kMIURKDi3pF/30ytxQP7HSq81EZrmTXO
	 namiYtOl86+Aw==
Date: Tue, 5 Nov 2024 09:02:26 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Andreas Larsson <andreas@gaisler.com>,
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
	Suren Baghdasaryan <surenb@google.com>,
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
Subject: Re: [PATCH v7 6/8] x86/module: prepare module loading for ROX
 allocations of text
Message-ID: <ZynDAhW0lKCfOqZl@kernel.org>
References: <20241023162711.2579610-1-rppt@kernel.org>
 <20241023162711.2579610-7-rppt@kernel.org>
 <20241104232741.GA3843610@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104232741.GA3843610@thelio-3990X>

Hi Nathan,

On Mon, Nov 04, 2024 at 04:27:41PM -0700, Nathan Chancellor wrote:
> Hi Mike,
> 
> On Wed, Oct 23, 2024 at 07:27:09PM +0300, Mike Rapoport wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > When module text memory will be allocated with ROX permissions, the
> > memory at the actual address where the module will live will contain
> > invalid instructions and there will be a writable copy that contains the
> > actual module code.
> > 
> > Update relocations and alternatives patching to deal with it.
> > 
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Tested-by: kdevops <kdevops@lists.linux.dev>
> 
> Hopefully the last time you have to hear from me, as I am only
> experiencing issues with only one of my test machines at this point and
> it is my only machine that supports IBT, so it seems to point to
> something specific with the IBT part of the FineIBT support. I notice
> either a boot hang or an almost immediate reboot (triple fault?). I
> guess this is how I missed reporting this earlier, as my machine was
> falling back to the default distribution kernel after the restart and I
> did not notice I was not actually testing a -next kernel.
> 
> Checking out the version of this change that is in next-20241104, commit
> 7ca6ed09db62 ("x86/module: prepare module loading for ROX allocations of
> text"), it boots with either 'cfi=off' or 'cfi=kcfi' but it exhibits the
> issues noted above with 'cfi=fineibt'. At the immediate parent, commit
> b575d981092f ("arch: introduce set_direct_map_valid_noflush()"), all
> three combinations boot fine.
> 
>   $ uname -r; tr ' ' '\n' </proc/cmdline | grep cfi=
> 
>   6.12.0-rc5-debug-00214-g7ca6ed09db62
>   cfi=kcfi
> 
>   6.12.0-rc5-debug-00214-g7ca6ed09db62
>   cfi=off
> 
>   6.12.0-rc5-debug-00213-gb575d981092f
>   cfi=fineibt
> 
>   6.12.0-rc5-debug-00213-gb575d981092f
>   cfi=kcfi
> 
>   6.12.0-rc5-debug-00213-gb575d981092f
>   cfi=off
> 
> I do not think this machine has an accessible serial port and I do not
> think IBT virtualization is supported via either KVM or TCG in QEMU, so
> I am not sure how to get more information about what is going on here. I
> wanted to try reverting these changes on top of next-20241104 but there
> was a non-trivial conflict in mm/execmem.c due to some changes on top,
> so I just tested in the mm history.
> 
> If there is any other information I can provide or patches I can test, I
> am more than happy to do so.

Yes, please :)

There's a silly mistake in cfi_rewrite_endbr() in that commit, the patch
below should fix it. Can you please test?

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 3407efc26528..243843e44e89 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1241,7 +1241,7 @@ static void cfi_rewrite_endbr(s32 *start, s32 *end, struct module *mod)
 		void *addr = (void *)s + *s;
 		void *wr_addr = module_writable_address(mod, addr);
 
-		poison_endbr(addr+16, wr_addr, false);
+		poison_endbr(addr + 16, wr_addr + 16, false);
 	}
 }
 
 
> Cheers,
> Nathan

-- 
Sincerely yours,
Mike.

