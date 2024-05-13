Return-Path: <linux-arch+bounces-4373-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 176A38C46CD
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 20:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DDA1B21681
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 18:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB44D43155;
	Mon, 13 May 2024 18:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="loiOnv6p"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEE84207A
	for <linux-arch@vger.kernel.org>; Mon, 13 May 2024 18:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715624974; cv=none; b=j6yNEUbnvs4+sH/pppZZc13SQMr0UlQL4aJ/o1xtbmWy1Cnc5LSwm5o0a/n3xy5813n2hZa9gAXZgTjVdewmhiD32w9PuLX3fChEOJV2BnaIRnWOC6qb4/WXasxTi+bFAnv53obHKfymEEyVlIlenUbUoAyosz/oTSeltHGA84Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715624974; c=relaxed/simple;
	bh=HE0FXVQon6YE2VqxfdPsjgpv5qFG4R1N/nJHFvW5Kdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxS5UEak+O97+j7ZtvrMAQheZuU7B3CjdZQrW5T/2s5TXLKbdlhZXv4xSLhi53dzTmXGCG+Y9Uh737EJzO+aEtQBtfad9uRhbs1cf0MPV3btXwUOwG5brtocV26KLuOeME7VwoPOy1/GjufPsqPr0osQ+tSLGKPUf/Jq06mwdmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=loiOnv6p; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2b3646494a8so3697668a91.2
        for <linux-arch@vger.kernel.org>; Mon, 13 May 2024 11:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715624972; x=1716229772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PiRTZzs1aSfsYke8dHlxZkqknmQw6lQNFES/HAZTAzg=;
        b=loiOnv6pgLCQu3cze/KF4lA4FAj2/Iqj8tTvhKJeLO+TBEtfEbRoriSejTylJ5iLAt
         PF7y2rviFmJQVZyHb9el4t7lho6XhWeXeWdVzSsTkFY65mMjqP/3Ex1Vtdf96yIkcuW9
         TBRHrPItXbENrC/fRLSmXW4GgLx/LOxgpPnuibtFNOZzBBkINE5JCd2bsPgTJ+DWVmv4
         ZhHOU7Gj7joYYfUk9NzkmRtcdTmQ61wBfXxQvB3ud44PFscoA1oObrPanNXj2sL7cYJj
         tXPrCLbMqlbVWwc4n6Xao9d3XTd53mWoMhIbxT7JZ9abe4ssbPHsdZ3c2vPqoh25+Xnn
         nqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715624972; x=1716229772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PiRTZzs1aSfsYke8dHlxZkqknmQw6lQNFES/HAZTAzg=;
        b=rJx4x8PY+SiZQwuxzLAXIoP3IcLsQld+QpsrPgRfj4vD/3UGISq9yNarPP7TZCPD5W
         s+udMFo0YjoAHACIcyfPatCZd6yOpf2UoWQniT9xYYCamZtyr1RV/KzoP1QXjLAaTuxZ
         psqjTSer8ecxMc5Xbzg0ZcTkDWGQYISGhMOdfFV4ERR3YjrXAlTeFIV4KjB8sM+xH42F
         uKW9eJCD05AGw7PUpJ0JMQXsB6WxaxIgIyj3JpaAMMupjeRAIDndBCcYBXWzu8msH37l
         tP832YqhALpyaftvhwJMGY/pYqD5tkk2CpuWncFNSZOKWzhpbTe4kEKD7IMD1mRp0A6p
         j9XA==
X-Forwarded-Encrypted: i=1; AJvYcCXVOuPawO61BKw+t7MbK/cZ5gXe+X5bIC2g8HE/KPMJSZcd8Rlgzdr5XQ8bomU9FbIxTO1IBk/XhUv5qzDGk/IXHg3HVq8+vvJzeg==
X-Gm-Message-State: AOJu0YxI467GQDIMe67/xgdHpMutlhhtwFPxqMWETWJX1ioIlUlgA7KH
	U63UELCPuKyQSb6r5NEYzAMdjcqThk6cWwZC54HEW+yeSyEJKGxmzAWPJ5aRUWY=
X-Google-Smtp-Source: AGHT+IFicEZcKeNvrbf0O6DdxrDGspREEgzWPCly98S4fjg/+yKIhmUX03N3FPrODmM7wQKDwilkhg==
X-Received: by 2002:a17:90a:9604:b0:2b3:ed2:1a77 with SMTP id 98e67ed59e1d1-2b6cc340388mr9349756a91.10.1715624972209;
        Mon, 13 May 2024 11:29:32 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b628ea6affsm10023078a91.54.2024.05.13.11.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 11:29:31 -0700 (PDT)
Date: Mon, 13 May 2024 11:29:27 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: paul.walmsley@sifive.com, rick.p.edgecombe@intel.com,
	broonie@kernel.org, Szabolcs.Nagy@arm.com, kito.cheng@sifive.com,
	keescook@chromium.org, ajones@ventanamicro.com,
	conor.dooley@microchip.com, cleger@rivosinc.com,
	atishp@atishpatra.org, bjorn@rivosinc.com, alexghiti@rivosinc.com,
	samuel.holland@sifive.com, conor@kernel.org,
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
	charlie@rivosinc.com, apatel@ventanamicro.com,
	mchitale@ventanamicro.com, dbarboza@ventanamicro.com,
	sameo@rivosinc.com, shikemeng@huaweicloud.com, willy@infradead.org,
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
Message-ID: <ZkJcB5u+0bZ2KsS+@debug.ba.rivosinc.com>
References: <20240403234054.2020347-1-debug@rivosinc.com>
 <20240403234054.2020347-11-debug@rivosinc.com>
 <c759444d-fe84-4a61-8448-80fb692c7904@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c759444d-fe84-4a61-8448-80fb692c7904@ghiti.fr>

On Sun, May 12, 2024 at 06:24:45PM +0200, Alexandre Ghiti wrote:
>Hi Deepak,
>
>On 04/04/2024 01:34, Deepak Gupta wrote:
>>`arch_calc_vm_prot_bits` is implemented on risc-v to return VM_READ |
>>VM_WRITE if PROT_WRITE is specified. Similarly `riscv_sys_mmap` is
>>updated to convert all incoming PROT_WRITE to (PROT_WRITE | PROT_READ).
>>This is to make sure that any existing apps using PROT_WRITE still work.
>>
>>Earlier `protection_map[VM_WRITE]` used to pick read-write PTE encodings.
>>Now `protection_map[VM_WRITE]` will always pick PAGE_SHADOWSTACK PTE
>>encodings for shadow stack. Above changes ensure that existing apps
>>continue to work because underneath kernel will be picking
>>`protection_map[VM_WRITE|VM_READ]` PTE encodings.
>>
>>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>>---
>>  arch/riscv/include/asm/mman.h    | 24 ++++++++++++++++++++++++
>>  arch/riscv/include/asm/pgtable.h |  1 +
>>  arch/riscv/kernel/sys_riscv.c    | 11 +++++++++++
>>  arch/riscv/mm/init.c             |  2 +-
>>  mm/mmap.c                        |  1 +
>>  5 files changed, 38 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/riscv/include/asm/mman.h
>>
>>diff --git a/arch/riscv/include/asm/mman.h b/arch/riscv/include/asm/mman.h
>>new file mode 100644
>>index 000000000000..ef9fedf32546
>>--- /dev/null
>>+++ b/arch/riscv/include/asm/mman.h
>>@@ -0,0 +1,24 @@
>>+/* SPDX-License-Identifier: GPL-2.0 */
>>+#ifndef __ASM_MMAN_H__
>>+#define __ASM_MMAN_H__
>>+
>>+#include <linux/compiler.h>
>>+#include <linux/types.h>
>>+#include <uapi/asm/mman.h>
>>+
>>+static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
>>+	unsigned long pkey __always_unused)
>>+{
>>+	unsigned long ret = 0;
>>+
>>+	/*
>>+	 * If PROT_WRITE was specified, force it to VM_READ | VM_WRITE.
>>+	 * Only VM_WRITE means shadow stack.
>>+	 */
>>+	if (prot & PROT_WRITE)
>>+		ret = (VM_READ | VM_WRITE);
>>+	return ret;
>>+}
>>+#define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
>>+
>>+#endif /* ! __ASM_MMAN_H__ */
>>diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
>>index 6066822e7396..4d5983bc6766 100644
>>--- a/arch/riscv/include/asm/pgtable.h
>>+++ b/arch/riscv/include/asm/pgtable.h
>>@@ -184,6 +184,7 @@ extern struct pt_alloc_ops pt_ops __initdata;
>>  #define PAGE_READ_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_EXEC)
>>  #define PAGE_WRITE_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ |	\
>>  					 _PAGE_EXEC | _PAGE_WRITE)
>>+#define PAGE_SHADOWSTACK       __pgprot(_PAGE_BASE | _PAGE_WRITE)
>>  #define PAGE_COPY		PAGE_READ
>>  #define PAGE_COPY_EXEC		PAGE_READ_EXEC
>>diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
>>index f1c1416a9f1e..846c36b1b3d5 100644
>>--- a/arch/riscv/kernel/sys_riscv.c
>>+++ b/arch/riscv/kernel/sys_riscv.c
>>@@ -8,6 +8,8 @@
>>  #include <linux/syscalls.h>
>>  #include <asm/cacheflush.h>
>>  #include <asm-generic/mman-common.h>
>>+#include <vdso/vsyscall.h>
>>+#include <asm/mman.h>
>>  static long riscv_sys_mmap(unsigned long addr, unsigned long len,
>>  			   unsigned long prot, unsigned long flags,
>>@@ -17,6 +19,15 @@ static long riscv_sys_mmap(unsigned long addr, unsigned long len,
>>  	if (unlikely(offset & (~PAGE_MASK >> page_shift_offset)))
>>  		return -EINVAL;
>>+	/*
>>+	 * If only PROT_WRITE is specified then extend that to PROT_READ
>>+	 * protection_map[VM_WRITE] is now going to select shadow stack encodings.
>>+	 * So specifying PROT_WRITE actually should select protection_map [VM_WRITE | VM_READ]
>>+	 * If user wants to create shadow stack then they should use `map_shadow_stack` syscall.
>>+	 */
>>+	if (unlikely((prot & PROT_WRITE) && !(prot & PROT_READ)))
>>+		prot |= PROT_READ;
>>+
>>  	return ksys_mmap_pgoff(addr, len, prot, flags, fd,
>>  			       offset >> (PAGE_SHIFT - page_shift_offset));
>>  }
>>diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>>index fa34cf55037b..98e5ece4052a 100644
>>--- a/arch/riscv/mm/init.c
>>+++ b/arch/riscv/mm/init.c
>>@@ -299,7 +299,7 @@ pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
>>  static const pgprot_t protection_map[16] = {
>>  	[VM_NONE]					= PAGE_NONE,
>>  	[VM_READ]					= PAGE_READ,
>>-	[VM_WRITE]					= PAGE_COPY,
>>+	[VM_WRITE]					= PAGE_SHADOWSTACK,
>>  	[VM_WRITE | VM_READ]				= PAGE_COPY,
>>  	[VM_EXEC]					= PAGE_EXEC,
>>  	[VM_EXEC | VM_READ]				= PAGE_READ_EXEC,
>>diff --git a/mm/mmap.c b/mm/mmap.c
>>index d89770eaab6b..57a974f49b00 100644
>>--- a/mm/mmap.c
>>+++ b/mm/mmap.c
>>@@ -47,6 +47,7 @@
>>  #include <linux/oom.h>
>>  #include <linux/sched/mm.h>
>>  #include <linux/ksm.h>
>>+#include <linux/processor.h>
>>  #include <linux/uaccess.h>
>>  #include <asm/cacheflush.h>
>
>
>What happens if someone restricts the permission to PROT_WRITE using 
>mprotect()? I would say this is an issue since it would turn the pages 
>into shadow stack pages.

look at this patch in this patch series.
"riscv/mm : ensure PROT_WRITE leads to VM_READ | VM_WRITE"

It implements `arch_calc_vm_prot_bits` for risc-v and enforces that incoming
PROT_WRITE is converted to VM_READ | VM_WRITE. And thus it'll become read/write
memory. This way `mprotect` can be used to convert a shadow stack page to
read/write memory but not a regular memory to shadow stack page.

>
>

