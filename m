Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8685622158
	for <lists+linux-arch@lfdr.de>; Wed,  9 Nov 2022 02:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiKIB1j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Nov 2022 20:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiKIB1i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Nov 2022 20:27:38 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729B55EFBE
        for <linux-arch@vger.kernel.org>; Tue,  8 Nov 2022 17:27:36 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id b62so14945171pgc.0
        for <linux-arch@vger.kernel.org>; Tue, 08 Nov 2022 17:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YTNMO4ck2krXz++IbBwhQ3ijjUgWxkKz9BEoZHo6y3I=;
        b=NQU8H5A4L1pu8n9aX/u/fdgBeTsB92TRoUCas++Wq2U47ze1vXQbN5kMKqbcdw4KU7
         pqcfiuhxAEtWlrgBhgfSRM9lzCvN1NKZRn1/Vrq1mQ/OAyipfmCn9AESHXkRAFU2ilIS
         Hb8tGealiQREStnxSFmSlDqKzawZ+Pgv8Dl9PSeYu65QVb9cx/2vPzwlL5kwI59PKLw1
         eFEUFuN1sJH3wTW8Bpmu9XggJby78Q4Wt3E3/jYCSC9ZOWvbbfba/brOOsEdpxcw98eK
         5a4nR4MfxzHMUw8rU4l4vqW64e3IkXtvha1KAltpzZ6lb6g8TcAcX58z8X9WgLHGrtlK
         Aesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YTNMO4ck2krXz++IbBwhQ3ijjUgWxkKz9BEoZHo6y3I=;
        b=OkPOYk6WtqWuThTGP+6ZiZ3H7byFhP1I4DjFtOcnbVg9RylcCa/YMThRTwKUudm9Ao
         KSo+dZeq0tnRruFvpNdTEmwvZL94jLArj84fxosmOId+sqJP+eX9PI4a3ndwDykLHZwk
         V/Yqdrfyg9YWZ6gXyrkRAIcQqk7uARIXltm4tsZnZO7FatKBZF3utcPKRgxZ56zUzF+i
         cqZSod44CfFwkW7W1HBSLAZ1NZXwalGKu+uMxVi58hDb6UdNQOXa2+7urq5TfJViy/Yt
         UKWPngLM/kUy6zASkYuX+Y/mi8Rn6r4F0EjCLSWJemOU2dTgFBHEqw1QN/bXzKjFQMwp
         f2HA==
X-Gm-Message-State: ACrzQf3va2aM5mnWqDWRHt/mz8q9EmsyXUVTd/DhTEPdzrXUlluxDJVr
        jB7jgkjV+mOiwEQAx4xd8crEBA==
X-Google-Smtp-Source: AMsMyM6eL7brZj6EJJj1SSZHlqWgSus0UcfCF0Vgs3aUuypQ7Ex6Np8S09nwKj+b3bhTrjwlqsCprQ==
X-Received: by 2002:a05:6a00:140a:b0:56c:b679:f812 with SMTP id l10-20020a056a00140a00b0056cb679f812mr58769082pfu.46.1667957255680;
        Tue, 08 Nov 2022 17:27:35 -0800 (PST)
Received: from [192.168.50.116] (c-24-4-73-83.hsd1.ca.comcast.net. [24.4.73.83])
        by smtp.gmail.com with ESMTPSA id u8-20020a1709026e0800b00186e34524e3sm7556782plk.136.2022.11.08.17.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 17:27:35 -0800 (PST)
Message-ID: <0b065367-c51d-10fc-795c-697555d40863@rivosinc.com>
Date:   Tue, 8 Nov 2022 17:27:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v12 10/17] riscv: Add sigcontext save/restore for vector
Content-Language: en-US
To:     Chris Stillson <stillson@rivosinc.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Dao Lu <daolu@rivosinc.com>,
        Conor Dooley <Conor.Dooley@microchip.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-arch <linux-arch@vger.kernel.org>
References: <20220921214439.1491510-1-stillson@rivosinc.com>
 <20220921214439.1491510-10-stillson@rivosinc.com>
From:   Vineet Gupta <vineetg@rivosinc.com>
In-Reply-To: <20220921214439.1491510-10-stillson@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

+CC linux-arch, Al Viro

On 9/21/22 14:43, Chris Stillson wrote:
> From: Greentime Hu <greentime.hu@sifive.com>
> 
> This patch adds sigcontext save/restore for vector. The vector registers
> will be saved in datap pointer. The datap pointer will be allocated
> dynamically when the task needs in kernel space. The datap pointer will
> be set right after the __riscv_v_state data structure to save all the
> vector registers in the signal handler stack.
> 
> Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>   arch/riscv/include/uapi/asm/sigcontext.h |  24 ++++
>   arch/riscv/kernel/asm-offsets.c          |   2 +
>   arch/riscv/kernel/signal.c               | 165 ++++++++++++++++++++++-
>   3 files changed, 187 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/include/uapi/asm/sigcontext.h b/arch/riscv/include/uapi/asm/sigcontext.h
> index 84f2dfcfdbce..b8a0fd7d7cfc 100644
> --- a/arch/riscv/include/uapi/asm/sigcontext.h
> +++ b/arch/riscv/include/uapi/asm/sigcontext.h
> @@ -8,6 +8,23 @@
>   
>   #include <asm/ptrace.h>
>   
> +/* The Magic number for signal context frame header. */
> +#define RVV_MAGIC	0x53465457
> +#define END_MAGIC	0x0
> +
> +/* The size of END signal context header. */
> +#define END_HDR_SIZE	0x0
> +
> +struct __riscv_ctx_hdr {
> +	__u32 magic;
> +	__u32 size;
> +};
> +
> +struct __sc_riscv_v_state {
> +	struct __riscv_ctx_hdr head;
> +	struct __riscv_v_state v_state;
> +} __attribute__((aligned(16)));
> +
>   /*
>    * Signal context structure
>    *
> @@ -17,6 +34,13 @@
>   struct sigcontext {
>   	struct user_regs_struct sc_regs;
>   	union __riscv_fp_state sc_fpregs;
> +	/*
> +	 * 4K + 128 reserved for vector state and future expansion.
> +	 * This space is enough to store the vector context whose VLENB
> +	 * is less or equal to 128.
> +	 * (The size of the vector context is 4144 byte as VLENB is 128)

At first glace it seems this only supports 128 byte V regs. Better to 
add some words saying that wider reg file is handled in code too.

> +	 */
> +	__u8 __reserved[4224] __attribute__((__aligned__(16)));

Is alignment of 8 not enough or is this future-proofing.

> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
> index 37e3e6a8d877..80316ef7bb78 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -75,6 +75,8 @@ void asm_offsets(void)
>   	OFFSET(TSK_STACK_CANARY, task_struct, stack_canary);
>   #endif
>   
> +	OFFSET(RISCV_V_STATE_MAGIC, __riscv_ctx_hdr, magic);
> +	OFFSET(RISCV_V_STATE_SIZE, __riscv_ctx_hdr, size);
>   	OFFSET(RISCV_V_STATE_VSTART, __riscv_v_state, vstart);
>   	OFFSET(RISCV_V_STATE_VL, __riscv_v_state, vl);
>   	OFFSET(RISCV_V_STATE_VTYPE, __riscv_v_state, vtype);
> diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
> index 38b05ca6fe66..41d9a02c7098 100644
> --- a/arch/riscv/kernel/signal.c
> +++ b/arch/riscv/kernel/signal.c
> @@ -20,15 +20,16 @@
>   #include <asm/csr.h>
>   
>   extern u32 __user_rt_sigreturn[2];
> +static size_t rvv_sc_size;
>   
>   #define DEBUG_SIG 0
>   
>   struct rt_sigframe {
>   	struct siginfo info;
> -	struct ucontext uc;
>   #ifndef CONFIG_MMU
>   	u32 sigreturn_code[2];
>   #endif
> +	struct ucontext uc;
>   };

Just for the record this is NOT a userspace abi change (for SA_SIGINFO 
signal handlers in userspace) since they are only provided struct 
ucontext pointer. kernel is free to rearrange stuff in struct 
rt_sigframe as it deems fits.

>   
>   #ifdef CONFIG_FPU
> @@ -85,16 +86,155 @@ static long save_fp_state(struct pt_regs *regs,
>   #define restore_fp_state(task, regs) (0)
>   #endif
>   
> +#ifdef CONFIG_VECTOR
> +static long restore_v_state(struct pt_regs *regs, void **sc_reserved_ptr)

For ease of reading I would move save before restore.

> +{
> +	long err;
> +	struct __sc_riscv_v_state __user *state = (struct __sc_riscv_v_state *)(*sc_reserved_ptr);
> +	void *datap;
> +	__u32 magic;
> +	__u32 size;
> +
> +	/* Get magic number and check it. */
> +	err = __get_user(magic, &state->head.magic);
> +	err = __get_user(size, &state->head.size);
> +	if (unlikely(err))
> +		return err;
> +
> +	if (magic != RVV_MAGIC || size != rvv_sc_size)
> +		return -EINVAL;
> +
> +	/* Copy everything of __sc_riscv_v_state except datap. */
> +	err = __copy_from_user(&current->thread.vstate, &state->v_state,
> +			       RISCV_V_STATE_DATAP);
> +	if (unlikely(err))
> +		return err;
> +
> +	/* Copy the pointer datap itself. */
> +	err = __get_user(datap, &state->v_state.datap);
> +	if (unlikely(err))
> +		return err;
> +
> +
> +	/* Copy the whole vector content from user space datap. */
> +	err = __copy_from_user(current->thread.vstate.datap, datap, riscv_vsize);
> +	if (unlikely(err))
> +		return err;
> +
> +	vstate_restore(current, regs);
> +
> +	/* Move sc_reserved_ptr to point the next signal context frame. */
> +	*sc_reserved_ptr += size;
> +
> +	return err;
> +}
> +
> +static long save_v_state(struct pt_regs *regs, void **sc_reserved_free_ptr)
> +{
> +	/*
> +	 * Put __sc_riscv_v_state to the user's signal context space pointed
> +	 * by sc_reserved_free_ptr and the datap point the address right
> +	 * after __sc_riscv_v_state.
> +	 */
> +	struct __sc_riscv_v_state __user *state = (struct __sc_riscv_v_state *)
> +		(*sc_reserved_free_ptr);
> +	void *datap = state + 1;
> +	long err;
> +
> +	*sc_reserved_free_ptr += rvv_sc_size;
> +
> +	err = __put_user(RVV_MAGIC, &state->head.magic);
> +	err = __put_user(rvv_sc_size, &state->head.size);

Can we copy these markers *after* the actual context is succesfully 
copied. What if it fails (user stack can't grow anymore etc), then we 
leave this half cooked state on stack.

Granted the process would most likely be killed anyways in such case.

> +
> +	vstate_save(current, regs);
> +	/* Copy everything of vstate but datap. */
> +	err = __copy_to_user(&state->v_state, &current->thread.vstate,
> +			     RISCV_V_STATE_DATAP);
> +	if (unlikely(err))
> +		return err;
> +
> +	/* Copy the pointer datap itself. */
> +	err = __put_user(datap, &state->v_state.datap);
> +	if (unlikely(err))
> +		return err;
> +
> +	/* Copy the whole vector content to user space datap. */
> +	err = __copy_to_user(datap, current->thread.vstate.datap, riscv_vsize);
> +
> +	return err;
> +}
> +#else
> +#define save_v_state(task, regs) (0)
> +#define restore_v_state(task, regs) (0)
> +#endif
> +
>   static long restore_sigcontext(struct pt_regs *regs,
>   	struct sigcontext __user *sc)
>   {
>   	long err;
> +	void *sc_reserved_ptr = sc->__reserved;
>   	/* sc_regs is structured the same as the start of pt_regs */
>   	err = __copy_from_user(regs, &sc->sc_regs, sizeof(sc->sc_regs));
>   	/* Restore the floating-point state. */
>   	if (has_fpu())
>   		err |= restore_fp_state(regs, &sc->sc_fpregs);
> +
> +	while (1 && !err) {
> +		__u32 magic, size;
> +		struct __riscv_ctx_hdr *head = (struct __riscv_ctx_hdr *)sc_reserved_ptr;
> +
> +		err |= __get_user(magic, &head->magic);
> +		err |= __get_user(size, &head->size);
> +		if (err)
> +			goto done;
> +
> +		switch (magic) {
> +		case 0:
> +			if (size)
> +				goto invalid;
> +			goto done;
> +		case RVV_MAGIC:
> +			if (!has_vector())
> +				goto invalid;
> +			if (size != rvv_sc_size)
> +				goto invalid;
> +			err |= restore_v_state(regs, &sc_reserved_ptr);
> +			break;

See question below. Is this 2 pass header check due to Vector or for 
some future extension ?

> +		default:
> +			goto invalid;
> +		}
> +	}
> +done:
>   	return err;
> +
> +invalid:
> +	return -EINVAL;
> +}
> +
> +static size_t cal_rt_frame_size(void)

> +{
> +	struct rt_sigframe __user *frame;
> +	static size_t frame_size;
> +	size_t total_context_size = 0;
> +	size_t sc_reserved_size = sizeof(frame->uc.uc_mcontext.__reserved);

Perhaps nit-picking, but "sc_reserved_size" and such names are 
confusing. Its ok to call the mcontext field __reserved but in rest of 
code lets avoid reserved - plain sctxt or some such will suffice.

> +
> +	if (frame_size)
> +		goto done;
> +
> +	frame_size = sizeof(*frame);
> +
> +	if (has_vector())
> +		total_context_size += rvv_sc_size;
> +	/* Preserved a __riscv_ctx_hdr for END signal context header. */
> +	total_context_size += sizeof(struct __riscv_ctx_hdr);
> +
> +	if (total_context_size > sc_reserved_size)
> +		frame_size += (total_context_size - sc_reserved_size);
> +
> +	frame_size = round_up(frame_size, 16);
> +done:
> +	return frame_size;

This seems to be a one time computation, given we are checking a static 
frame_size everytime, could we just calculate this once in 
init_rt_signal_env() below in a now file scoped static variable ?

> +
>   }
>   
>   SYSCALL_DEFINE0(rt_sigreturn)
> @@ -103,13 +243,14 @@ SYSCALL_DEFINE0(rt_sigreturn)
>   	struct rt_sigframe __user *frame;
>   	struct task_struct *task;
>   	sigset_t set;
> +	size_t frame_size = cal_rt_frame_size();
>   
>   	/* Always make any pending restarted system calls return -EINTR */
>   	current->restart_block.fn = do_no_restart_syscall;
>   
>   	frame = (struct rt_sigframe __user *)regs->sp;
>   
> -	if (!access_ok(frame, sizeof(*frame)))
> +	if (!access_ok(frame, frame_size))
>   		goto badframe;
>   
>   	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
> @@ -142,11 +283,20 @@ static long setup_sigcontext(struct rt_sigframe __user *frame,
>   {
>   	struct sigcontext __user *sc = &frame->uc.uc_mcontext;
>   	long err;
> +	void *sc_reserved_free_ptr = sc->__reserved;
> +
>   	/* sc_regs is structured the same as the start of pt_regs */
>   	err = __copy_to_user(&sc->sc_regs, regs, sizeof(sc->sc_regs));
>   	/* Save the floating-point state. */
>   	if (has_fpu())
>   		err |= save_fp_state(regs, &sc->sc_fpregs);
> +	/* Save the vector state. */
> +	if (has_vector())
> +		err |= save_v_state(regs, &sc_reserved_free_ptr);
> +
> +	/* Put END __riscv_ctx_hdr at the end. */
> +	err = __put_user(END_MAGIC, &((struct __riscv_ctx_hdr *)sc_reserved_free_ptr)->magic);
> +	err = __put_user(END_HDR_SIZE, &((struct __riscv_ctx_hdr *)sc_reserved_free_ptr)->size);

I really don't understand the need for this trailing header stuff. Is 
this due to variable sized vector or enginnering for a yet to be 
invented future extension's state.
But if so, won't we add a new ctx_hdr + magic for "foo" when that 
happens. After all we were not doing this for existing FP stuff, granted 
FP is all fixed size.

For Vector: magic+size tuple should be enough to identify/locate the ctx 
info.


>   	return err;
>   }
>   
> @@ -178,9 +328,10 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
>   {
>   	struct rt_sigframe __user *frame;
>   	long err = 0;
> +	size_t frame_size = cal_rt_frame_size();
>   
> -	frame = get_sigframe(ksig, regs, sizeof(*frame));
> -	if (!access_ok(frame, sizeof(*frame)))
> +	frame = get_sigframe(ksig, regs, frame_size);
> +	if (!access_ok(frame, frame_size))
>   		return -EFAULT;
>   
>   	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
> @@ -326,3 +477,9 @@ asmlinkage __visible void do_notify_resume(struct pt_regs *regs,
>   	if (thread_info_flags & _TIF_NOTIFY_RESUME)
>   		resume_user_mode_work(regs);
>   }
> +
> +void init_rt_signal_env(void);
> +void __init init_rt_signal_env(void)
> +{
> +	rvv_sc_size = sizeof(struct __sc_riscv_v_state) + riscv_vsize;

See above, should be precompute the output of cal_rt_frame_size() here too.
