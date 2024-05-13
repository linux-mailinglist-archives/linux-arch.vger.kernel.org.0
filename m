Return-Path: <linux-arch+bounces-4376-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D588C46FA
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 20:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98C55B21D8B
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 18:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D53539FEC;
	Mon, 13 May 2024 18:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="sqiZz3wA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0702825755
	for <linux-arch@vger.kernel.org>; Mon, 13 May 2024 18:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715625421; cv=none; b=n4qMQsMK4BBnQABg7OMlgKSRNGMivY8jp6DQTx548RrmCDgor5/XQcjPFZCH+/QM8XMt8Ed4eSwPjAmNrPBj2N4lJHMlGTG+JU9Go6OCizr2kpkGv2W146LjjL1WLscaKEwpE0vyT7LKaL7/MPt2torB7LmORzJyMMAbEQky7k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715625421; c=relaxed/simple;
	bh=BvI39EAKtQpX2KnQvFJ2uFQpNAn8Ssm0ZY3/iNJ4Gpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjLA524+UGO+E7FiVdaT9UU5njctYYOq6n88a9lNVqvuDyWu7G2ogt/zoR0YGzEBIJEHRT6gqUu3WughBW2fX+zjrtc2XW5k5XHhOOM2DK/JLuEMTv7RKrKn4Om5HbY4Xn/E+35W89DK7UEz9gX2DT9KNh5u9sG45zjJm81e8v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=sqiZz3wA; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f447260f9dso3741505b3a.0
        for <linux-arch@vger.kernel.org>; Mon, 13 May 2024 11:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715625418; x=1716230218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EJ8xaQQ9gfY7+cG8KujzU2LQ7mZBfQgErlO4DocitkQ=;
        b=sqiZz3wAwg5d+gK3gtKX4HKCKs2PF74FqtvCGajcnnYeWbJq3WC0abaoFWnXZIqQ0x
         T4dj7JPXyu4ZOAYWUZfPui7zFPbs94RPwLZH6/l4WEf8A/Gs0/7UETu3HnJm/m3FEIgN
         GRMJ5QS9yinp/S1ynzQ5op+NKIFHX1QCNEUnqP4FOqoUdoYOFQwy9kzgITsUo+6pWJnP
         Qxo1HTVi9Gc+jDT26CJN5OMYSa8P6NMEXRP06/RIcQtk8bspvf2a2kRlavPfwrCzJ42q
         rJnGGsLk0jnABqGWZmX6XjEdjcxY4AAU9YxL54sI36jZlUD5RFn/kkrM6Y915I7Gel51
         swpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715625418; x=1716230218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJ8xaQQ9gfY7+cG8KujzU2LQ7mZBfQgErlO4DocitkQ=;
        b=mOpA60VETWTs30H87f+EZN206gfUPv2KBy+arADDGSJMkNqGhHSw1Ne+rhgFclFCzV
         +rD4pmlRoyT5JUyCFrQGYoh/AivHu1VCg72R6DEEPC1aUqvs8YZSt7/6HzU2hDC9B1gp
         8m0PBBYkXLjzwL+0cFFqUTwB0hmlJitNQW9AOWwivW6+n3v982FTxDUwSPBJe9FgFT15
         XAOPabxhBGhldtfcrOkbHJl5MnMAIndluIInknl3oFPXhn+tMqByWjguEuEqNOm8z2el
         6QjbdGnfSy66+yS3Gg6HgyZ8b1tuN5DAJNMrIbYrZHnNaQf9h5EGAnTe4oeAoQzbRNAB
         1vBA==
X-Forwarded-Encrypted: i=1; AJvYcCU+4XVc91xLvVXbqEgs/1FgjttMfEdRRGWcvMHk5Oi98v0AZo8GfxKBS3nl5td4RjtvLvIScSYZjH5eWfR7F/F39IdRXwh5HIXFmQ==
X-Gm-Message-State: AOJu0YzzXwx0RPDFkJoU1KQB5fn/E8cHYHWyCOwxnQRMiI4AmFMA58MO
	aK5wUdQjnR/HjGkWO6OkiOLvNv358h9Q1oHwxqhhbzMrk4RVPdD1TRX0h9CCnSE=
X-Google-Smtp-Source: AGHT+IEtFJqHdWFS93HqHX5hpNlL66iEYhRvuRmrd98dRBICcH+zlHlVBgPVDx05Rv0/gkrNtS6Lwg==
X-Received: by 2002:a05:6a00:2406:b0:6f3:86ac:5eae with SMTP id d2e1a72fcca58-6f4e03843d1mr10090101b3a.28.1715625418280;
        Mon, 13 May 2024 11:36:58 -0700 (PDT)
Received: from ghost ([2600:1010:b062:ae34:7efe:e26b:c29e:9a14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a9d9acsm7881752b3a.90.2024.05.13.11.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 11:36:57 -0700 (PDT)
Date: Mon, 13 May 2024 11:36:49 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Deepak Gupta <debug@rivosinc.com>
Cc: paul.walmsley@sifive.com, rick.p.edgecombe@intel.com,
	broonie@kernel.org, Szabolcs.Nagy@arm.com, kito.cheng@sifive.com,
	keescook@chromium.org, ajones@ventanamicro.com,
	conor.dooley@microchip.com, cleger@rivosinc.com,
	atishp@atishpatra.org, alex@ghiti.fr, bjorn@rivosinc.com,
	alexghiti@rivosinc.com, samuel.holland@sifive.com, conor@kernel.org,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org, corbet@lwn.net, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, oleg@redhat.com,
	akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, lstoakes@gmail.com,
	shuah@kernel.org, brauner@kernel.org, andy.chiu@sifive.com,
	jerry.shih@sifive.com, hankuan.chen@sifive.com,
	greentime.hu@sifive.com, evan@rivosinc.com, xiao.w.wang@intel.com,
	apatel@ventanamicro.com, mchitale@ventanamicro.com,
	dbarboza@ventanamicro.com, sameo@rivosinc.com,
	shikemeng@huaweicloud.com, willy@infradead.org,
	vincent.chen@sifive.com, guoren@kernel.org, samitolvanen@google.com,
	songshuaishuai@tinylab.org, gerg@kernel.org, heiko@sntech.de,
	bhe@redhat.com, jeeheng.sia@starfivetech.com, cyy@cyyself.name,
	maskray@google.com, ancientmodern4@gmail.com,
	mathis.salmen@matsal.de, cuiyunhui@bytedance.com,
	bgray@linux.ibm.com, mpe@ellerman.id.au, baruch@tkos.co.il,
	alx@kernel.org, david@redhat.com, catalin.marinas@arm.com,
	revest@chromium.org, josh@joshtriplett.org, shr@devkernel.io,
	deller@gmx.de, omosnace@redhat.com, ojeda@kernel.org,
	jhubbard@nvidia.com
Subject: Re: [PATCH v3 10/29] riscv/mm : ensure PROT_WRITE leads to VM_READ |
 VM_WRITE
Message-ID: <ZkJdYvkUqHkX7yPf@ghost>
References: <20240403234054.2020347-1-debug@rivosinc.com>
 <20240403234054.2020347-11-debug@rivosinc.com>
 <Zj6LfpQhOjTLEx2O@ghost>
 <ZkJSLTk1iWFGJZCQ@debug.ba.rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkJSLTk1iWFGJZCQ@debug.ba.rivosinc.com>

On Mon, May 13, 2024 at 10:47:25AM -0700, Deepak Gupta wrote:
> On Fri, May 10, 2024 at 02:02:54PM -0700, Charlie Jenkins wrote:
> > On Wed, Apr 03, 2024 at 04:34:58PM -0700, Deepak Gupta wrote:
> > > `arch_calc_vm_prot_bits` is implemented on risc-v to return VM_READ |
> > > VM_WRITE if PROT_WRITE is specified. Similarly `riscv_sys_mmap` is
> > > updated to convert all incoming PROT_WRITE to (PROT_WRITE | PROT_READ).
> > > This is to make sure that any existing apps using PROT_WRITE still work.
> > > 
> > > Earlier `protection_map[VM_WRITE]` used to pick read-write PTE encodings.
> > > Now `protection_map[VM_WRITE]` will always pick PAGE_SHADOWSTACK PTE
> > > encodings for shadow stack. Above changes ensure that existing apps
> > > continue to work because underneath kernel will be picking
> > > `protection_map[VM_WRITE|VM_READ]` PTE encodings.
> > > 
> > > Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> > > ---
> > >  arch/riscv/include/asm/mman.h    | 24 ++++++++++++++++++++++++
> > >  arch/riscv/include/asm/pgtable.h |  1 +
> > >  arch/riscv/kernel/sys_riscv.c    | 11 +++++++++++
> > >  arch/riscv/mm/init.c             |  2 +-
> > >  mm/mmap.c                        |  1 +
> > >  5 files changed, 38 insertions(+), 1 deletion(-)
> > >  create mode 100644 arch/riscv/include/asm/mman.h
> > > 
> > > diff --git a/arch/riscv/include/asm/mman.h b/arch/riscv/include/asm/mman.h
> > > new file mode 100644
> > > index 000000000000..ef9fedf32546
> > > --- /dev/null
> > > +++ b/arch/riscv/include/asm/mman.h
> > > @@ -0,0 +1,24 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef __ASM_MMAN_H__
> > > +#define __ASM_MMAN_H__
> > > +
> > > +#include <linux/compiler.h>
> > > +#include <linux/types.h>
> > > +#include <uapi/asm/mman.h>
> > > +
> > > +static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> > > +	unsigned long pkey __always_unused)
> > > +{
> > > +	unsigned long ret = 0;
> > > +
> > > +	/*
> > > +	 * If PROT_WRITE was specified, force it to VM_READ | VM_WRITE.
> > > +	 * Only VM_WRITE means shadow stack.
> > > +	 */
> > > +	if (prot & PROT_WRITE)
> > > +		ret = (VM_READ | VM_WRITE);
> > > +	return ret;
> > > +}
> > > +#define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
> > > +
> > > +#endif /* ! __ASM_MMAN_H__ */
> > > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> > > index 6066822e7396..4d5983bc6766 100644
> > > --- a/arch/riscv/include/asm/pgtable.h
> > > +++ b/arch/riscv/include/asm/pgtable.h
> > > @@ -184,6 +184,7 @@ extern struct pt_alloc_ops pt_ops __initdata;
> > >  #define PAGE_READ_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_EXEC)
> > >  #define PAGE_WRITE_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ |	\
> > >  					 _PAGE_EXEC | _PAGE_WRITE)
> > > +#define PAGE_SHADOWSTACK       __pgprot(_PAGE_BASE | _PAGE_WRITE)
> > > 
> > >  #define PAGE_COPY		PAGE_READ
> > >  #define PAGE_COPY_EXEC		PAGE_READ_EXEC
> > > diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> > > index f1c1416a9f1e..846c36b1b3d5 100644
> > > --- a/arch/riscv/kernel/sys_riscv.c
> > > +++ b/arch/riscv/kernel/sys_riscv.c
> > > @@ -8,6 +8,8 @@
> > >  #include <linux/syscalls.h>
> > >  #include <asm/cacheflush.h>
> > >  #include <asm-generic/mman-common.h>
> > > +#include <vdso/vsyscall.h>
> > > +#include <asm/mman.h>
> > > 
> > >  static long riscv_sys_mmap(unsigned long addr, unsigned long len,
> > >  			   unsigned long prot, unsigned long flags,
> > > @@ -17,6 +19,15 @@ static long riscv_sys_mmap(unsigned long addr, unsigned long len,
> > >  	if (unlikely(offset & (~PAGE_MASK >> page_shift_offset)))
> > >  		return -EINVAL;
> > > 
> > > +	/*
> > > +	 * If only PROT_WRITE is specified then extend that to PROT_READ
> > > +	 * protection_map[VM_WRITE] is now going to select shadow stack encodings.
> > > +	 * So specifying PROT_WRITE actually should select protection_map [VM_WRITE | VM_READ]
> > > +	 * If user wants to create shadow stack then they should use `map_shadow_stack` syscall.
> > > +	 */
> > > +	if (unlikely((prot & PROT_WRITE) && !(prot & PROT_READ)))
> > 
> > The comments says that this should extend to PROT_READ if only
> > PROT_WRITE is specified. This condition instead is checking if
> > PROT_WRITE is selected but PROT_READ is not. If prot is (VM_EXEC |
> > VM_WRITE) then it would be extended to (VM_EXEC | VM_WRITE | VM_READ).
> > This will not currently cause any issues because these both map to the
> > same value in the protection_map PAGE_COPY_EXEC, however this seems to
> > be not the intention of this change.
> > 
> > prot == PROT_WRITE better suits the condition explained in the comment.
> 
> If someone specifies this (PROT_EXEC | PROT_WRITE) today, it works because
> of the way permissions are setup in `protection_map`. On risc-v there is no
> way to have a page which is execute and write only. So expectation is that
> if some apps were using `PROT_EXEC | PROT_WRITE` today, they were working
> because internally it was translating to read, write and execute on page
> permissions level. This patch make sure that, it stays same from page
> permissions perspective.
> 
> If someone was using PROT_EXEC, it may translate to execute only and this change
> doesn't impact that.
> 
> Patch simply looks for presence of `PROT_WRITE` and absence of `PROT_READ` in
> protection flags and if that condition is satisfied, it assumes that caller assumed
> page is going to be read allowed as well.

The purpose of this change is for compatibility with shadow stack pages
but this affects flags for pages that are not shadow stack pages.
Adding PROT_READ to the other cases is redundant as protection_map
already handles that mapping. Permissions being strictly PROT_WRITE is
the only case that needs to be handled, and is the only case that is
called out in the commit message and in the comment.

- Charlie

> 
> 
> > 
> > > +		prot |= PROT_READ;
> > > +
> > >  	return ksys_mmap_pgoff(addr, len, prot, flags, fd,
> > >  			       offset >> (PAGE_SHIFT - page_shift_offset));
> > >  }
> > > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > > index fa34cf55037b..98e5ece4052a 100644
> > > --- a/arch/riscv/mm/init.c
> > > +++ b/arch/riscv/mm/init.c
> > > @@ -299,7 +299,7 @@ pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
> > >  static const pgprot_t protection_map[16] = {
> > >  	[VM_NONE]					= PAGE_NONE,
> > >  	[VM_READ]					= PAGE_READ,
> > > -	[VM_WRITE]					= PAGE_COPY,
> > > +	[VM_WRITE]					= PAGE_SHADOWSTACK,
> > >  	[VM_WRITE | VM_READ]				= PAGE_COPY,
> > >  	[VM_EXEC]					= PAGE_EXEC,
> > >  	[VM_EXEC | VM_READ]				= PAGE_READ_EXEC,
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index d89770eaab6b..57a974f49b00 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -47,6 +47,7 @@
> > >  #include <linux/oom.h>
> > >  #include <linux/sched/mm.h>
> > >  #include <linux/ksm.h>
> > > +#include <linux/processor.h>
> > 
> > It doesn't seem like this is necessary for this patch.
> 
> Thanks. Yeah it looks like I forgot to remove this over the churn.
> Will fix it.
> 
> > 
> > - Charlie
> > 
> > > 
> > >  #include <linux/uaccess.h>
> > >  #include <asm/cacheflush.h>
> > > --
> > > 2.43.2
> > > 

