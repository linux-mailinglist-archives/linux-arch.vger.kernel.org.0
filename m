Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224443BD8A2
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 16:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbhGFOph (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 10:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbhGFOpc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jul 2021 10:45:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F1EC0613AD
        for <linux-arch@vger.kernel.org>; Tue,  6 Jul 2021 07:31:13 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625579481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I7YDanFK9pzB5Y+m5EjpM3UimxNDTwFAGgiErt/H6CQ=;
        b=pc/29rOQzrRcPCmO0jGZLFRHrJ8klbjFgJxTTnR7ATLueW9bz9nFbgnTABmZyU+9L3USFQ
        IOYW/uUOQwBvnusmbp0iW0ku015f/WwDr7YJNLkhqw6kazSb4E+X4szNHYz6XxkCxNdvHR
        RKNY9xXpzbLx6LEPVDJzT9t4w6/La67Zmn7dxmiz8qEaAdMqvnFH8Pxg/gxTtKdjgUQcmW
        ddrvUcHUrcnL5ZouiaYHVS2Ftz1HfbeKB+nGKACI3Pel1tnLv0rNaccj9weOxVeJotKIzo
        rJRA6FHtjm1ZR0FMOgdC1p5XEfErWqyZXbKWyMUBVutyped8LFeTXGJYEb0SHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625579481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I7YDanFK9pzB5Y+m5EjpM3UimxNDTwFAGgiErt/H6CQ=;
        b=MxG7xoJ4CEth/g3h3Wk+8SU8YGJ0ZnUeTkqiA9rzOl3r+PGwzjTbqVM1RtnIS8BF8Z/4R2
        SLXcI+2lxzR7myCw==
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH 09/19] LoongArch: Add system call support
In-Reply-To: <20210706041820.1536502-10-chenhuacai@loongson.cn>
References: <20210706041820.1536502-1-chenhuacai@loongson.cn> <20210706041820.1536502-10-chenhuacai@loongson.cn>
Date:   Tue, 06 Jul 2021 15:51:21 +0200
Message-ID: <87tul7r1nq.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Chen!

On Tue, Jul 06 2021 at 12:18, Huacai Chen wrote:
> +	li.d	t1, _TIF_WORK_SYSCALL_ENTRY
> +	LONG_L	t0, tp, TI_FLAGS	# syscall tracing enabled?
> +	and	t0, t1, t0
> +	bnez	t0, syscall_trace_entry
> +
> +syscall_common:
> +	/* Check to make sure we don't jump to a bogus syscall number. */
> +	li.w	t0, __NR_syscalls
> +	sub.d	t2, a7, t0
> +	bgez	t2, illegal_syscall
> +
> +	/* Syscall number held in a7 */
> +	slli.d	t0, a7, 3		# offset into table
> +	la	t2, sys_call_table
> +	add.d	t0, t2, t0
> +	ld.d	t2, t0, 0		#syscall routine
> +	beqz    t2, illegal_syscall
> +
> +	jalr	t2			# Do The Real Thing (TM)
> +
> +	ld.d	t1, sp, PT_R11		# syscall number
> +	addi.d	t1, t1, 1		# +1 for handle_signal
> +	st.d	t1, sp, PT_R0		# save it for syscall restarting
> +	st.d	v0, sp, PT_R4		# result

Please do not add _again_ TIF handling in ASM. Please use the generic
entry code infrastructure for this. It handles the complete set of TIF
bits (if enabled in config) out of the box and it does so correctly.

Thanks,

        tglx


