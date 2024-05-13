Return-Path: <linux-arch+bounces-4365-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E018C45C0
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 19:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7857DB242DE
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 17:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2B71CF8B;
	Mon, 13 May 2024 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="dcglDbHn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D81A20B34
	for <linux-arch@vger.kernel.org>; Mon, 13 May 2024 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715620231; cv=none; b=V8o8gf02csQIW8AElsjIa3BZ/bQCmlnsTvsqNpzclKlbY3fkQ4Y09ZtL06J+HJCYUGM94ZDq2bF1RbI8GLe1dZj929NAxNgbyPwmng5usa2iqZdFs1emE8gFT6p2XBKTaHbyc+bSUGek6ajB3VFlS7W8kP2Sk6cNbqJgES4k3WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715620231; c=relaxed/simple;
	bh=EI6c/QMQ5HAqFK04YaBmLqb9m7QAdUj1S3neb/u6+FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdqWxwS1w+rYomwV6iS0OYLwdDCpkXX5SMIQDqoGG5BRKjVqEdT1puzlw6kse7ZDRtp4XmNfZD5TXGMuqYrW3Kh2T3Qh/jdb1OSssx+oSD7nNzxPhQIZ/yBCVpAChgNvYJQMrWMrPc1+1Z/vd51TlYEyB8JOhv4PmMVStamzLsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=dcglDbHn; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36c82ca80adso21359655ab.3
        for <linux-arch@vger.kernel.org>; Mon, 13 May 2024 10:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715620227; x=1716225027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UB0FE6D84soTVPuPflHviR2eZCvIzly+XATYaT1hwdk=;
        b=dcglDbHn8wK6Jo7zXLp8LI52Vdd2xYi6XW4ysasPkD3ZXxutvqLix/GKesFLTZTdq/
         i6EDy9M28gkVUSoLu6pwvDl1G0+B7evRKDX3FZZYNghTLAMqdqDKxEDDKo2ESyQ7ei5t
         aFjo2fgPq5ziswobow38z9eDUaUGFHqlLaiGX4HU3fv59+uiEkt9BzNxqx1bFCmEbVfT
         2JVeS4oqYjmjl0T89caR4pqXLZVtkVV0RSo628q0DmjjkSsvRNSq6bMmdSY4WXsdeqZZ
         xdtDvfyueWv+HY2l6B8Jx0iNQrVf7LKx2BG3OeL73XOQ6oXpU8QMUXm45G/T4+ZfSc7J
         P6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715620227; x=1716225027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UB0FE6D84soTVPuPflHviR2eZCvIzly+XATYaT1hwdk=;
        b=KbuBLWlUnmcNpah7wndSoDkq4xDDZUXcmxNnn44+0JH9NWKT63WbCOO2I9ACJbvuBh
         FWcYUc9DrjFmaAuCsq5cULQOmQm36qeNrtZXZKEjpUaxbn6vxbrl6CMw8GkGDk3SCDaF
         toq33CR8763meMeWYOZy8r0hdYSUmqlvLyCr//3ACRC5ysPg6Fw0StA7IK2s/iAM5eSG
         fybX+zqUNnW1U0nNbXsx45siGbo5wXx5u/t2pHGFYmQBhzh64PFIXb8/xnLWAkTjcGB6
         BJf8cWvSQQ+jGWWTKL+f/KnlYZyY/tz0UMQ0fukTDl35O3uUDJz1s6qlndwtFsvRmrT0
         kiAg==
X-Forwarded-Encrypted: i=1; AJvYcCVJWqBnepX+BBarqAxkIPnQaHxu+Opa3OvN3c6QygWB0XCYSOobWaRPaICtpkERq2N2pEiC/lkDk9tWz1vZSirtYwX1kDaQArNQeA==
X-Gm-Message-State: AOJu0YwizKIT5kWJcMmU8uGy9WFsUjmiiewmsyC5KeRrTFB5VRkBZIXy
	Mmj2048jOqjtN0wfzpsXPr91qkpfu7VC4QrOFLF0jKOcP4M9+WI9RmSiucqbU3c=
X-Google-Smtp-Source: AGHT+IGUPl9bUb2AtqmJgMMwqJL5WOyWW/bu2C2sYkLxxdXxyfOHETWbs6bdfaxg45e8xmMvwNOpmA==
X-Received: by 2002:a05:6e02:1aad:b0:36c:5239:d1bf with SMTP id e9e14a558f8ab-36cc146501emr137929285ab.13.1715620227366;
        Mon, 13 May 2024 10:10:27 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340c8a6921sm8038288a12.43.2024.05.13.10.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 10:10:26 -0700 (PDT)
Date: Mon, 13 May 2024 10:10:22 -0700
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
Subject: Re: [PATCH v3 15/29] riscv/shstk: If needed allocate a new shadow
 stack on clone
Message-ID: <ZkJJflk6Lhx3QSji@debug.ba.rivosinc.com>
References: <20240403234054.2020347-1-debug@rivosinc.com>
 <20240403234054.2020347-16-debug@rivosinc.com>
 <5f66b425-679a-4f1f-9ca1-0c0bf3950a0a@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5f66b425-679a-4f1f-9ca1-0c0bf3950a0a@ghiti.fr>

On Sun, May 12, 2024 at 07:05:27PM +0200, Alexandre Ghiti wrote:
>On 04/04/2024 01:35, Deepak Gupta wrote:
>>Userspace specifies VM_CLONE to share address space and spawn new thread.
>
>
>CLONE_VM?

Yes I meant CLONE_VM, will fix it.

>
>
>>`clone` allow userspace to specify a new stack for new thread. However
>>there is no way to specify new shadow stack base address without changing
>>API. This patch allocates a new shadow stack whenever VM_CLONE is given.
>>
>>In case of VM_FORK, parent is suspended until child finishes and thus can
>
>
>You mean CLONE_VFORK here right?

Yes I meant CLONE_VFORK, will fix it.

>
>
>>child use parent shadow stack. In case of !VM_CLONE, COW kicks in because
>>entire address space is copied from parent to child.
>>
>>`clone3` is extensible and can provide mechanisms using which shadow stack
>>as an input parameter can be provided. This is not settled yet and being
>>extensively discussed on mailing list. Once that's settled, this commit
>>will adapt to that.
>>
>>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>>---
>>  arch/riscv/include/asm/usercfi.h |  39 ++++++++++
>>  arch/riscv/kernel/process.c      |  12 ++-
>>  arch/riscv/kernel/usercfi.c      | 121 +++++++++++++++++++++++++++++++
>>  3 files changed, 171 insertions(+), 1 deletion(-)
>>
>>diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/usercfi.h
>>index 4fa201b4fc4e..b47574a7a8c9 100644
>>--- a/arch/riscv/include/asm/usercfi.h
>>+++ b/arch/riscv/include/asm/usercfi.h
>>@@ -8,6 +8,9 @@
>>  #ifndef __ASSEMBLY__
>>  #include <linux/types.h>
>>+struct task_struct;
>>+struct kernel_clone_args;
>>+
>>  #ifdef CONFIG_RISCV_USER_CFI
>>  struct cfi_status {
>>  	unsigned long ubcfi_en : 1; /* Enable for backward cfi. */
>>@@ -17,6 +20,42 @@ struct cfi_status {
>>  	unsigned long shdw_stk_size; /* size of shadow stack */
>>  };
>>+unsigned long shstk_alloc_thread_stack(struct task_struct *tsk,
>>+							const struct kernel_clone_args *args);
>>+void shstk_release(struct task_struct *tsk);
>>+void set_shstk_base(struct task_struct *task, unsigned long shstk_addr, unsigned long size);
>>+void set_active_shstk(struct task_struct *task, unsigned long shstk_addr);
>>+bool is_shstk_enabled(struct task_struct *task);
>>+
>>+#else
>>+
>>+static inline unsigned long shstk_alloc_thread_stack(struct task_struct *tsk,
>>+					   const struct kernel_clone_args *args)
>>+{
>>+	return 0;
>>+}
>>+
>>+static inline void shstk_release(struct task_struct *tsk)
>>+{
>>+
>>+}
>>+
>>+static inline void set_shstk_base(struct task_struct *task, unsigned long shstk_addr,
>>+								unsigned long size)
>>+{
>>+
>>+}
>>+
>>+static inline void set_active_shstk(struct task_struct *task, unsigned long shstk_addr)
>>+{
>>+
>>+}
>>+
>>+static inline bool is_shstk_enabled(struct task_struct *task)
>>+{
>>+	return false;
>>+}
>>+
>>  #endif /* CONFIG_RISCV_USER_CFI */
>>  #endif /* __ASSEMBLY__ */
>>diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
>>index ce577cdc2af3..ef48a25b0eff 100644
>>--- a/arch/riscv/kernel/process.c
>>+++ b/arch/riscv/kernel/process.c
>>@@ -26,6 +26,7 @@
>>  #include <asm/cpuidle.h>
>>  #include <asm/vector.h>
>>  #include <asm/cpufeature.h>
>>+#include <asm/usercfi.h>
>>  register unsigned long gp_in_global __asm__("gp");
>>@@ -202,7 +203,8 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
>>  void exit_thread(struct task_struct *tsk)
>>  {
>>-
>>+	if (IS_ENABLED(CONFIG_RISCV_USER_CFI))
>>+		shstk_release(tsk);
>>  }
>>  int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>>@@ -210,6 +212,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>>  	unsigned long clone_flags = args->flags;
>>  	unsigned long usp = args->stack;
>>  	unsigned long tls = args->tls;
>>+	unsigned long ssp = 0;
>>  	struct pt_regs *childregs = task_pt_regs(p);
>>  	memset(&p->thread.s, 0, sizeof(p->thread.s));
>>@@ -225,11 +228,18 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>>  		p->thread.s[0] = (unsigned long)args->fn;
>>  		p->thread.s[1] = (unsigned long)args->fn_arg;
>>  	} else {
>>+		/* allocate new shadow stack if needed. In case of CLONE_VM we have to */
>>+		ssp = shstk_alloc_thread_stack(p, args);
>>+		if (IS_ERR_VALUE(ssp))
>>+			return PTR_ERR((void *)ssp);
>>+
>>  		*childregs = *(current_pt_regs());
>>  		/* Turn off status.VS */
>>  		riscv_v_vstate_off(childregs);
>>  		if (usp) /* User fork */
>>  			childregs->sp = usp;
>>+		if (ssp) /* if needed, set new ssp */
>>+			set_active_shstk(p, ssp);
>>  		if (clone_flags & CLONE_SETTLS)
>>  			childregs->tp = tls;
>>  		childregs->a0 = 0; /* Return value of fork() */
>>diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
>>index c4ed0d4e33d6..11ef7ab925c9 100644
>>--- a/arch/riscv/kernel/usercfi.c
>>+++ b/arch/riscv/kernel/usercfi.c
>>@@ -19,6 +19,41 @@
>>  #define SHSTK_ENTRY_SIZE sizeof(void *)
>>+bool is_shstk_enabled(struct task_struct *task)
>>+{
>>+	return task->thread_info.user_cfi_state.ubcfi_en ? true : false;
>>+}
>>+
>>+void set_shstk_base(struct task_struct *task, unsigned long shstk_addr, unsigned long size)
>>+{
>>+	task->thread_info.user_cfi_state.shdw_stk_base = shstk_addr;
>>+	task->thread_info.user_cfi_state.shdw_stk_size = size;
>>+}
>>+
>>+unsigned long get_shstk_base(struct task_struct *task, unsigned long *size)
>>+{
>>+	if (size)
>>+		*size = task->thread_info.user_cfi_state.shdw_stk_size;
>>+	return task->thread_info.user_cfi_state.shdw_stk_base;
>>+}
>>+
>>+void set_active_shstk(struct task_struct *task, unsigned long shstk_addr)
>>+{
>>+	task->thread_info.user_cfi_state.user_shdw_stk = shstk_addr;
>>+}
>>+
>>+/*
>>+ * If size is 0, then to be compatible with regular stack we want it to be as big as
>>+ * regular stack. Else PAGE_ALIGN it and return back
>>+ */
>>+static unsigned long calc_shstk_size(unsigned long size)
>>+{
>>+	if (size)
>>+		return PAGE_ALIGN(size);
>>+
>>+	return PAGE_ALIGN(min_t(unsigned long long, rlimit(RLIMIT_STACK), SZ_4G));
>>+}
>>+
>>  /*
>>   * Writes on shadow stack can either be `sspush` or `ssamoswap`. `sspush` can happen
>>   * implicitly on current shadow stack pointed to by CSR_SSP. `ssamoswap` takes pointer to
>>@@ -147,3 +182,89 @@ SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsi
>>  	return allocate_shadow_stack(addr, aligned_size, size, set_tok);
>>  }
>>+
>>+/*
>>+ * This gets called during clone/clone3/fork. And is needed to allocate a shadow stack for
>>+ * cases where CLONE_VM is specified and thus a different stack is specified by user. We
>>+ * thus need a separate shadow stack too. How does separate shadow stack is specified by
>>+ * user is still being debated. Once that's settled, remove this part of the comment.
>>+ * This function simply returns 0 if shadow stack are not supported or if separate shadow
>>+ * stack allocation is not needed (like in case of !CLONE_VM)
>>+ */
>>+unsigned long shstk_alloc_thread_stack(struct task_struct *tsk,
>>+					   const struct kernel_clone_args *args)
>>+{
>>+	unsigned long addr, size;
>>+
>>+	/* If shadow stack is not supported, return 0 */
>>+	if (!cpu_supports_shadow_stack())
>>+		return 0;
>>+
>>+	/*
>>+	 * If shadow stack is not enabled on the new thread, skip any
>>+	 * switch to a new shadow stack.
>>+	 */
>>+	if (is_shstk_enabled(tsk))
>>+		return 0;
>>+
>>+	/*
>>+	 * For CLONE_VFORK the child will share the parents shadow stack.
>>+	 * Set base = 0 and size = 0, this is special means to track this state
>>+	 * so the freeing logic run for child knows to leave it alone.
>>+	 */
>>+	if (args->flags & CLONE_VFORK) {
>>+		set_shstk_base(tsk, 0, 0);
>>+		return 0;
>>+	}
>>+
>>+	/*
>>+	 * For !CLONE_VM the child will use a copy of the parents shadow
>>+	 * stack.
>>+	 */
>>+	if (!(args->flags & CLONE_VM))
>>+		return 0;
>>+
>>+	/*
>>+	 * reaching here means, CLONE_VM was specified and thus a separate shadow
>>+	 * stack is needed for new cloned thread. Note: below allocation is happening
>>+	 * using current mm.
>>+	 */
>>+	size = calc_shstk_size(args->stack_size);
>>+	addr = allocate_shadow_stack(0, size, 0, false);
>>+	if (IS_ERR_VALUE(addr))
>>+		return addr;
>>+
>>+	set_shstk_base(tsk, addr, size);
>>+
>>+	return addr + size;
>>+}
>>+
>>+void shstk_release(struct task_struct *tsk)
>>+{
>>+	unsigned long base = 0, size = 0;
>>+	/* If shadow stack is not supported or not enabled, nothing to release */
>>+	if (!cpu_supports_shadow_stack() ||
>>+		!is_shstk_enabled(tsk))
>>+		return;
>>+
>>+	/*
>>+	 * When fork() with CLONE_VM fails, the child (tsk) already has a
>>+	 * shadow stack allocated, and exit_thread() calls this function to
>>+	 * free it.  In this case the parent (current) and the child share
>>+	 * the same mm struct. Move forward only when they're same.
>>+	 */
>>+	if (!tsk->mm || tsk->mm != current->mm)
>>+		return;
>>+
>>+	/*
>>+	 * We know shadow stack is enabled but if base is NULL, then
>>+	 * this task is not managing its own shadow stack (CLONE_VFORK). So
>>+	 * skip freeing it.
>>+	 */
>>+	base = get_shstk_base(tsk, &size);
>>+	if (!base)
>>+		return;
>>+
>>+	vm_munmap(base, size);
>>+	set_shstk_base(tsk, 0, 0);
>>+}

