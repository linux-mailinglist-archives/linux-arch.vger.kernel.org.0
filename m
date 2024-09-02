Return-Path: <linux-arch+bounces-6913-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A7F968889
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2024 15:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD7EB1F2373C
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2024 13:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4CC205E38;
	Mon,  2 Sep 2024 13:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TYNrn+sO"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C217205E29;
	Mon,  2 Sep 2024 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282719; cv=none; b=fLr02pTpExUa41zuGeJElvoM+AdnQbHm98Lpf9jhO1K3LPF0uVqP6jxazFgJNqUJObEuBCmC7f5W02/woOu2YiPJziYAWH/OBtKV7LGFJSlEwRJmxE8qwCkTtNbzQD+fuXSKmXK43KvYlhHnP+xGyzAfNOsX/MCoPwhXnSLGeQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282719; c=relaxed/simple;
	bh=gx1O+C2Apjy6gFGimEEw36zJ1VKn28kDUmuUzLrIm/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYkVigSKMZN+mT1C4moygPQ+UE7/l82dxNwAsesMDgLekwoTbzdf93uatL9xQ6qCyQqFdWtt1/PbtB6x4APCaLRPY6V7cFFOai+Eg2KyrHRbHbO03GEFh9hGF8ukFv//KrqK3aqJ5GeaMIad4igOlbNh5WcAGbw+FiBYNaiIiMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=TYNrn+sO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E7EC4CEC2;
	Mon,  2 Sep 2024 13:11:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TYNrn+sO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725282715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ajNhpQQ8pAn81+LIVUJdAsztwcnl2COxj6CoGDej39E=;
	b=TYNrn+sOOWcxaykfNDnNDmi61JtCkS+TrpjgHIzBfSS1sPXvkzpTmDWsJRbFaXPFpbvaqc
	B66SCqvixYBCdPacgD5LYLdOPhGYKVdceuFllDZJn21oFQCKxzVwruRCix5YzZvYNbqz2r
	cWLQEnWN1eAHp1vQCzK4b3oLmTGU6+E=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 669363c7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Sep 2024 13:11:55 +0000 (UTC)
Date: Mon, 2 Sep 2024 15:11:53 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Cc: Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, ardb@kernel.org
Subject: Re: [PATCH v2] aarch64: vdso: Wire up getrandom() vDSO implementation
Message-ID: <ZtW5meR5iLrkKErJ@zx2c4.com>
References: <20240829201728.2825-1-adhemerval.zanella@linaro.org>
 <20240830114645.GA8219@willie-the-truck>
 <963afe11-fd48-4fe9-be70-2e202f836e34@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <963afe11-fd48-4fe9-be70-2e202f836e34@linaro.org>

Hey Christophe (for header logic) & Will (for arm64 stuff),

On Fri, Aug 30, 2024 at 09:28:29AM -0300, Adhemerval Zanella Netto wrote:
> >> diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
> >> index 938ca539aaa6..7c9711248d9b 100644
> >> --- a/lib/vdso/getrandom.c
> >> +++ b/lib/vdso/getrandom.c
> >> @@ -5,6 +5,7 @@
> >>  
> >>  #include <linux/array_size.h>
> >>  #include <linux/minmax.h>
> >> +#include <linux/mm.h>
> >>  #include <vdso/datapage.h>
> >>  #include <vdso/getrandom.h>
> >>  #include <vdso/unaligned.h>
> > 
> > Looks like this should be a separate change?
> 
> 
> It is required so arm64 can use  c-getrandom-y, otherwise vgetrandom.o build
> fails:
> 
> CC      arch/arm64/kernel/vdso/vgetrandom.o
> In file included from ./include/uapi/linux/mman.h:5,
>                  from /mnt/projects/linux/linux-git/lib/vdso/getrandom.c:13,
>                  from <command-line>:
> ./arch/arm64/include/asm/mman.h: In function ‘arch_calc_vm_prot_bits’:
> ./arch/arm64/include/asm/mman.h:14:13: error: implicit declaration of function ‘system_supports_bti’ [-Werror=implicit-function-declaration]
>    14 |         if (system_supports_bti() && (prot & PROT_BTI))
>       |             ^~~~~~~~~~~~~~~~~~~
> ./arch/arm64/include/asm/mman.h:15:24: error: ‘VM_ARM64_BTI’ undeclared (first use in this function); did you mean ‘ARM64_BTI’?
>    15 |                 ret |= VM_ARM64_BTI;
>       |                        ^~~~~~~~~~~~
>       |                        ARM64_BTI
> ./arch/arm64/include/asm/mman.h:15:24: note: each undeclared identifier is reported only once for each function it appears in
> ./arch/arm64/include/asm/mman.h:17:13: error: implicit declaration of function ‘system_supports_mte’ [-Werror=implicit-function-declaration]
>    17 |         if (system_supports_mte() && (prot & PROT_MTE))
>       |             ^~~~~~~~~~~~~~~~~~~
> ./arch/arm64/include/asm/mman.h:18:24: error: ‘VM_MTE’ undeclared (first use in this function)
>    18 |                 ret |= VM_MTE;
>       |                        ^~~~~~
> ./arch/arm64/include/asm/mman.h: In function ‘arch_calc_vm_flag_bits’:
> ./arch/arm64/include/asm/mman.h:32:24: error: ‘VM_MTE_ALLOWED’ undeclared (first use in this function)
>    32 |                 return VM_MTE_ALLOWED;
>       |                        ^~~~~~~~~~~~~~
> ./arch/arm64/include/asm/mman.h: In function ‘arch_validate_flags’:
> ./arch/arm64/include/asm/mman.h:59:29: error: ‘VM_MTE’ undeclared (first use in this function)
>    59 |         return !(vm_flags & VM_MTE) || (vm_flags & VM_MTE_ALLOWED);
>       |                             ^~~~~~
> ./arch/arm64/include/asm/mman.h:59:52: error: ‘VM_MTE_ALLOWED’ undeclared (first use in this function)
>    59 |         return !(vm_flags & VM_MTE) || (vm_flags & VM_MTE_ALLOWED);
>       |                                                    ^~~~~~~~~~~~~~
> arch/arm64/kernel/vdso/vgetrandom.c: In function ‘__kernel_getrandom’:
> arch/arm64/kernel/vdso/vgetrandom.c:18:25: error: ‘ENOSYS’ undeclared (first use in this function); did you mean ‘ENOSPC’?
>    18 |                 return -ENOSYS;
>       |                         ^~~~~~
>       |                         ENOSPC
> cc1: some warnings being treated as errors
> 
> I can move to a different patch, but this is really tied to this patch.

Adhemerval kept this change in this patch for v3, which, if it's
necessary, is fine with me. But I was looking to see if there was
another way of doing it, because including linux/mm.h inside of vdso
code is kind of contrary to your project with e379299fe0b3 ("random:
vDSO: minimize and simplify header includes").

getrandom.c includes uapi/linux/mman.h for the mmap constants. That
seems fine; it's userspace code after all. But then uapi/linux/mman.h
has this:

   #include <asm/mman.h>
   #include <asm-generic/hugetlb_encode.h>
   #include <linux/types.h>

The asm-generic/ one resolves to uapi/asm-generic. But the asm/ one
resolves to arch code, which is where we then get in trouble on ARM,
where arch/arm64/include/asm/mman.h has all sorts of kernel code in it.

Maybe, instead, it should resolve to arch/arm64/include/uapi/asm/mman.h,
which is the header that userspace actually uses in normal user code?

Is this a makefile problem? What's going on here? Seems like this is
something worth sorting out. Or I can take Adhemerval's v3 as-is and
we'll grit our teeth and work it out later, as you prefer. But I thought
I should mention it.

Thoughts?

Jason

