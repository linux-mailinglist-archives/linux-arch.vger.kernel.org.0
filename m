Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16947262692
	for <lists+linux-arch@lfdr.de>; Wed,  9 Sep 2020 06:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgIIE74 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Sep 2020 00:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgIIE7a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Sep 2020 00:59:30 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA61C061755
        for <linux-arch@vger.kernel.org>; Tue,  8 Sep 2020 21:59:29 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w7so1094345pfi.4
        for <linux-arch@vger.kernel.org>; Tue, 08 Sep 2020 21:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=HusqWcfyGC+ql/Zjk8Q/vdT8PXZvHACLiqB7zBTzSvM=;
        b=dXk9To9Q1v53+uIxoDd356SC63Me668w/PlIGfYaPZoiOq+kn5JzBDG8ISHZzGFR/k
         w6AdfCOfQQlYd55zyhFFzYbLm1I0TPelctdgEe/K9UMvxGwjkSzTtfrc1LT1sKDfT03Z
         dno8EwQRVyVcB8ZtO7RcNpgHhYzbLVFqj2C/j7zM9pq/KypLsbvt/Fany2AguiScA1Ey
         EPBF/OTN5dgB6E+LZ7CfaDQjxRQHj6mr2sUqN8fvo1AoHZhdWukXGh77ZrwkYllqc5gt
         mf+j9mk3CClJcSqPaMOz/Z/4FqfVFjDk3n4YfpUEbOWsOulYfeo/VKskrzezIDCeMubf
         5/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=HusqWcfyGC+ql/Zjk8Q/vdT8PXZvHACLiqB7zBTzSvM=;
        b=jFevWlYTjO7De9ji/BzEeGgLqj198CPi1y0ev04T3EOusu41h+6ZB9Ig+D6kLu4pea
         xc/EfGQDz4rrfmZfFUQe5N9MsconaYE09oI/28y4QNrgtq+4I7ldrHpRzO54OZ9fbEAG
         6QtCZCBq5tFxsQA12jCbSJbXe/UIIqZrMZiWUDEPZ/0mrm4J4dqiK83rjqrKVGQT9oAv
         iimmvQlyn+KGu98CtpKETeCc8n+2DwrJO6Yg0+SGCQgA8P1ohClORSQzBW5SMgoLaTWg
         W1FkjqSSUM2piDrPmQkEVaGLC9cjyQs+zeIL4RNrX8vx/tlI/ajJ5pTjpauv44f+bXql
         XgSg==
X-Gm-Message-State: AOAM5329wqkadrfhArmoXGdPI2+Qf+FzpSdHKFldX5ZL266uoWDrUV4y
        fOZae6b+5MletyFh50mklxcObQ==
X-Google-Smtp-Source: ABdhPJy4MS198jyOfSH08aNpUpExBegNhbKMjNLEX4M8IafVuBqxEO3l93M82iDwSb1jkLq+09tyxg==
X-Received: by 2002:aa7:8756:: with SMTP id g22mr2064694pfo.37.1599627569034;
        Tue, 08 Sep 2020 21:59:29 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id u71sm1061068pfc.43.2020.09.08.21.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 21:59:28 -0700 (PDT)
Date:   Tue, 08 Sep 2020 21:59:28 -0700 (PDT)
X-Google-Original-Date: Tue, 08 Sep 2020 21:55:52 PDT (-0700)
Subject:     Re: [PATCH 8/8] riscv: remove address space overrides using set_fs()
In-Reply-To: <20200907055825.1917151-9-hch@lst.de>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, viro@zeniv.linux.org.uk,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-ca158d54-5e36-4407-a4da-097c9ddc7dfc@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, 06 Sep 2020 22:58:25 PDT (-0700), Christoph Hellwig wrote:
> Stop providing the possibility to override the address space using
> set_fs() now that there is no need for that any more.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/Kconfig                   |  1 -
>  arch/riscv/include/asm/thread_info.h |  6 ------
>  arch/riscv/include/asm/uaccess.h     | 27 +--------------------------
>  arch/riscv/kernel/process.c          |  1 -
>  4 files changed, 1 insertion(+), 34 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 460e3971a80fde..33dde87218ddab 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -86,7 +86,6 @@ config RISCV
>  	select SPARSE_IRQ
>  	select SYSCTL_EXCEPTION_TRACE
>  	select THREAD_INFO_IN_TASK
> -	select SET_FS
>  	select UACCESS_MEMCPY if !MMU
>
>  config ARCH_MMAP_RND_BITS_MIN
> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
> index 464a2bbc97ea33..a390711129de64 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -24,10 +24,6 @@
>  #include <asm/processor.h>
>  #include <asm/csr.h>
>
> -typedef struct {
> -	unsigned long seg;
> -} mm_segment_t;
> -
>  /*
>   * low level task data that entry.S needs immediate access to
>   * - this struct should fit entirely inside of one cache line
> @@ -39,7 +35,6 @@ typedef struct {
>  struct thread_info {
>  	unsigned long		flags;		/* low level flags */
>  	int                     preempt_count;  /* 0=>preemptible, <0=>BUG */
> -	mm_segment_t		addr_limit;
>  	/*
>  	 * These stack pointers are overwritten on every system call or
>  	 * exception.  SP is also saved to the stack it can be recovered when
> @@ -59,7 +54,6 @@ struct thread_info {
>  {						\
>  	.flags		= 0,			\
>  	.preempt_count	= INIT_PREEMPT_COUNT,	\
> -	.addr_limit	= KERNEL_DS,		\
>  }
>
>  #endif /* !__ASSEMBLY__ */
> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
> index 264e52fb62b143..c47e6b35c551f4 100644
> --- a/arch/riscv/include/asm/uaccess.h
> +++ b/arch/riscv/include/asm/uaccess.h
> @@ -26,29 +26,6 @@
>  #define __disable_user_access()							\
>  	__asm__ __volatile__ ("csrc sstatus, %0" : : "r" (SR_SUM) : "memory")
>
> -/*
> - * The fs value determines whether argument validity checking should be
> - * performed or not.  If get_fs() == USER_DS, checking is performed, with
> - * get_fs() == KERNEL_DS, checking is bypassed.
> - *
> - * For historical reasons, these macros are grossly misnamed.
> - */
> -
> -#define MAKE_MM_SEG(s)	((mm_segment_t) { (s) })
> -
> -#define KERNEL_DS	MAKE_MM_SEG(~0UL)
> -#define USER_DS		MAKE_MM_SEG(TASK_SIZE)
> -
> -#define get_fs()	(current_thread_info()->addr_limit)
> -
> -static inline void set_fs(mm_segment_t fs)
> -{
> -	current_thread_info()->addr_limit = fs;
> -}
> -
> -#define uaccess_kernel() (get_fs().seg == KERNEL_DS.seg)
> -#define user_addr_max()	(get_fs().seg)
> -
>  /**
>   * access_ok: - Checks if a user space pointer is valid
>   * @addr: User space pointer to start of block to check
> @@ -76,9 +53,7 @@ static inline void set_fs(mm_segment_t fs)
>   */
>  static inline int __access_ok(unsigned long addr, unsigned long size)
>  {
> -	const mm_segment_t fs = get_fs();
> -
> -	return size <= fs.seg && addr <= fs.seg - size;
> +	return size <= TASK_SIZE && addr <= TASK_SIZE - size;
>  }
>
>  /*
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index 2b97c493427c9e..19225ec65db62f 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -84,7 +84,6 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
>  	}
>  	regs->epc = pc;
>  	regs->sp = sp;
> -	set_fs(USER_DS);
>  }
>
>  void flush_thread(void)

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
