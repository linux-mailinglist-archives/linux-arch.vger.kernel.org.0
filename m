Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF042C2CE5
	for <lists+linux-arch@lfdr.de>; Tue, 24 Nov 2020 17:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390003AbgKXQ23 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Nov 2020 11:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbgKXQ22 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Nov 2020 11:28:28 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2E9C0613D6;
        Tue, 24 Nov 2020 08:28:28 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id y7so7811130lji.8;
        Tue, 24 Nov 2020 08:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L/WTciL200KuzPXNNyWqR+3bYdqz/jfmbk7jc3OEM2Y=;
        b=mbG/IE5YbXI1u9xO3V9+lkskzWsD3gTjNtlXgxbBlr1viFpDoFh5Fx/CY8FHCZkii5
         omvpE8i0SmjnlRQ1lxYuK1gKFiLLScVQ3DEn4RhpJXsj3cDGzOJF+1NQVNrs7rvewDsh
         CG7c+8aciBB4NpVbPIenHJTgQ+bbeHATqMkiKEKi8t3zL6JaeelCAdQpwjj35HEoVvSU
         jARwyjY6L1l/MZifcezWOitUpWFh86GYkPLIl4HIShWyls2JZG8C43HM1HkDc44f4w9t
         7WsH4mFGx5Au7KyAd8K1EZ19T6Tp8vCBX0Bm6UYYSZVgp60u66bqHx9G3bcLyt2QASUQ
         qBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L/WTciL200KuzPXNNyWqR+3bYdqz/jfmbk7jc3OEM2Y=;
        b=tkfkAL6MgDE73yJZp5XJ7xyNC2tf1MdOKu6Hp7VDjNU43juopmvi2E0ZyPTkX8oJHa
         H4milHD6u70CxRiYmwLJ5yTQ7pDf/Jpgv5rOU/AHagsVlSqeXraF4o6e/A/I+H5JeTD2
         ixf0r6AoEsk/9kSSMcLXMToYxkRvxaRJO6YGzsJK4QMT2y5iWOlmfvTPCmInXJzMASMe
         M3Cg+VpqSI0gqyrXcUqIT2a/bdsQuHOan8Q2DXpWFZNsXha2Rc5jOsB6GX1gqG8ngPD8
         KiwjhQB2TZukVsYRB+7g89MqQyppZh0A0zA2MD5fsDmoB59BjlQLPiCrAbQFZ2WsIv/R
         SUlQ==
X-Gm-Message-State: AOAM532BfKc13EwtmgiJPLGS1snHnCdd6ZEkPLZU9jMm1l+VLwakyi7h
        tih3XNfcH8iyiSWgX4fpxJQ=
X-Google-Smtp-Source: ABdhPJzxoahaP3kzK+1IjAJX5x8xEKt8vbhiJVqE6nIVipvrEecVl3fqGf03pNOrI4NAtFKJZd651g==
X-Received: by 2002:a2e:84c7:: with SMTP id q7mr2161531ljh.415.1606235306672;
        Tue, 24 Nov 2020 08:28:26 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id b79sm1787218lfg.243.2020.11.24.08.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 08:28:25 -0800 (PST)
Subject: Re: [PATCH v2 04/10] seccomp: Migrate to use SYSCALL_WORK flag
To:     Gabriel Krisman Bertazi <krisman@collabora.com>, tglx@linutronix.de
Cc:     hch@infradead.org, mingo@redhat.com, keescook@chromium.org,
        arnd@arndb.de, luto@amacapital.net, wad@chromium.org,
        rostedt@goodmis.org, paul@paul-moore.com, eparis@redhat.com,
        oleg@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, kernel@collabora.com,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
References: <20201116174206.2639648-1-krisman@collabora.com>
 <20201116174206.2639648-5-krisman@collabora.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <20646400-0e16-0eb5-c829-3b77df8c38e3@gmail.com>
Date:   Tue, 24 Nov 2020 19:28:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201116174206.2639648-5-krisman@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

16.11.2020 20:42, Gabriel Krisman Bertazi пишет:
> When one the generic syscall entry code, use the syscall_work field in
> struct thread_info and specific SYSCALL_WORK flags to setup this syscall
> work.  This flag has the advantage of being architecture independent.
> 
> Users of the flag outside of the generic entry code should rely on the
> accessor macros, such that the flag is still correctly resolved for
> architectures that don't use the generic entry code and still rely on
> TIF flags for system call work.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> ---
> Changes since v2:
>   - Drop explicit value assignment in enum (tglx)
>   - Avoid FLAG/_FLAG defines (tglx)
>   - Fix comment to refer to SYSCALL_WORK_SECCOMP (me)
> ---
>  include/asm-generic/syscall.h | 2 +-
>  include/linux/entry-common.h  | 8 ++------
>  include/linux/seccomp.h       | 2 +-
>  include/linux/thread_info.h   | 6 ++++++
>  kernel/entry/common.c         | 2 +-
>  kernel/fork.c                 | 2 +-
>  kernel/seccomp.c              | 6 +++---
>  7 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/include/asm-generic/syscall.h b/include/asm-generic/syscall.h
> index f3135e734387..524d8e68ff5e 100644
> --- a/include/asm-generic/syscall.h
> +++ b/include/asm-generic/syscall.h
> @@ -135,7 +135,7 @@ void syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
>   * Returns the AUDIT_ARCH_* based on the system call convention in use.
>   *
>   * It's only valid to call this when @task is stopped on entry to a system
> - * call, due to %TIF_SYSCALL_TRACE, %TIF_SYSCALL_AUDIT, or %TIF_SECCOMP.
> + * call, due to %TIF_SYSCALL_TRACE, %TIF_SYSCALL_AUDIT, or %SYSCALL_WORK_SECCOMP.
>   *
>   * Architectures which permit CONFIG_HAVE_ARCH_SECCOMP_FILTER must
>   * provide an implementation of this.
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index cbc5c702ee4d..f3fc4457f63f 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -21,10 +21,6 @@
>  # define _TIF_SYSCALL_TRACEPOINT	(0)
>  #endif
>  
> -#ifndef _TIF_SECCOMP
> -# define _TIF_SECCOMP			(0)
> -#endif
> -
>  #ifndef _TIF_SYSCALL_AUDIT
>  # define _TIF_SYSCALL_AUDIT		(0)
>  #endif
> @@ -49,7 +45,7 @@
>  #endif
>  
>  #define SYSCALL_ENTER_WORK						\
> -	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | _TIF_SECCOMP |	\
> +	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT  |			\
>  	 _TIF_SYSCALL_TRACEPOINT | _TIF_SYSCALL_EMU |			\
>  	 ARCH_SYSCALL_ENTER_WORK)
>  
> @@ -64,7 +60,7 @@
>  	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT |			\
>  	 _TIF_SYSCALL_TRACEPOINT | ARCH_SYSCALL_EXIT_WORK)
>  
> -#define SYSCALL_WORK_ENTER	(0)
> +#define SYSCALL_WORK_ENTER	(SYSCALL_WORK_SECCOMP)
>  #define SYSCALL_WORK_EXIT	(0)
>  
>  /*
> diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
> index 02aef2844c38..47763f3999f7 100644
> --- a/include/linux/seccomp.h
> +++ b/include/linux/seccomp.h
> @@ -42,7 +42,7 @@ struct seccomp {
>  extern int __secure_computing(const struct seccomp_data *sd);
>  static inline int secure_computing(void)
>  {
> -	if (unlikely(test_thread_flag(TIF_SECCOMP)))
> +	if (unlikely(test_syscall_work(SECCOMP)))
>  		return  __secure_computing(NULL);
>  	return 0;
>  }
> diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
> index f2d78de55840..1d6488130b5c 100644
> --- a/include/linux/thread_info.h
> +++ b/include/linux/thread_info.h
> @@ -35,6 +35,12 @@ enum {
>  	GOOD_STACK,
>  };
>  
> +enum syscall_work_bit {
> +	SYSCALL_WORK_BIT_SECCOMP,
> +};
> +
> +#define SYSCALL_WORK_SECCOMP		BIT(SYSCALL_WORK_BIT_SECCOMP)
> +
>  #include <asm/thread_info.h>
>  
>  #ifdef __KERNEL__
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index 51c25f774791..c321056c73d7 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -54,7 +54,7 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
>  	}
>  
>  	/* Do seccomp after ptrace, to catch any tracer changes. */
> -	if (ti_work & _TIF_SECCOMP) {
> +	if (work & SYSCALL_WORK_SECCOMP) {
>  		ret = __secure_computing(NULL);
>  		if (ret == -1L)
>  			return ret;
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 7199d359690c..4433c9c60100 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1625,7 +1625,7 @@ static void copy_seccomp(struct task_struct *p)
>  	 * to manually enable the seccomp thread flag here.
>  	 */
>  	if (p->seccomp.mode != SECCOMP_MODE_DISABLED)
> -		set_tsk_thread_flag(p, TIF_SECCOMP);
> +		set_task_syscall_work(p, SECCOMP);
>  #endif
>  }
>  
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 8ad7a293255a..f67e92d11ad7 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -356,14 +356,14 @@ static inline void seccomp_assign_mode(struct task_struct *task,
>  
>  	task->seccomp.mode = seccomp_mode;
>  	/*
> -	 * Make sure TIF_SECCOMP cannot be set before the mode (and
> +	 * Make sure SYSCALL_WORK_SECCOMP cannot be set before the mode (and
>  	 * filter) is set.
>  	 */
>  	smp_mb__before_atomic();
>  	/* Assume default seccomp processes want spec flaw mitigation. */
>  	if ((flags & SECCOMP_FILTER_FLAG_SPEC_ALLOW) == 0)
>  		arch_seccomp_spec_mitigate(task);
> -	set_tsk_thread_flag(task, TIF_SECCOMP);
> +	set_task_syscall_work(task, SECCOMP);
>  }
>  
>  #ifdef CONFIG_SECCOMP_FILTER
> @@ -929,7 +929,7 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
>  
>  	/*
>  	 * Make sure that any changes to mode from another thread have
> -	 * been seen after TIF_SECCOMP was seen.
> +	 * been seen after SYSCALL_WORK_SECCOMP was seen.
>  	 */
>  	rmb();
>  
> 

Hi,

This patch broke seccomp on arm32 using linux-next, chromium browser
doesn't work anymore and there are these errors in KMSG:

Unhandled prefetch abort: breakpoint debug exception (0x002) at ...

Note that arm doesn't use CONFIG_GENERIC_ENTRY. Please fix, thanks in
advance.
