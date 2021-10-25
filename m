Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D93543A682
	for <lists+linux-arch@lfdr.de>; Tue, 26 Oct 2021 00:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbhJYW2V (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Oct 2021 18:28:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233780AbhJYW1v (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 Oct 2021 18:27:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC5DD61039;
        Mon, 25 Oct 2021 22:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635200728;
        bh=P5tlFsGtCPtUOWR1BRMJeM7BfDDHkMcNJV0LpkK2SbE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AsTyAg2M09vff6Gj3gBQf5TF2l1dygeTp0Yy626Wt1k8ZOb8bAxXW+/GLdFsBnuPS
         Uj2FluXu+PtFicvWB36W+GW+kW/W/Pdb2hkEFZRHGCKwwA6ib7dnC7OIVSkuKwOb6D
         /V2C1790g4GX8VsA/H2MWNrQcbWPNc5LC8UV2x/MpAJxnjFKPn/BWKSy/sx+NdLEk6
         HEBZDeNCAUZuyQ8o8g1UiQwEn+FS5avdYvHlptFcGTr+mhY0sM0aOYgBsig1M53swJ
         X3v3zzyUWkiJHofoe7vejy7weMqD8UmANf2d/uxphiLkrtcWi/hEUuJgOvTkLuO96L
         71i50wkf2b6mw==
Message-ID: <4b203254-a333-77b1-0fa9-75c11fabac36@kernel.org>
Date:   Mon, 25 Oct 2021 15:25:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2 10/32] signal/vm86_32: Properly send SIGSEGV when the
 vm86 state cannot be saved.
Content-Language: en-US
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, H Peter Anvin <hpa@zytor.com>
References: <87y26nmwkb.fsf@disp2133>
 <20211020174406.17889-10-ebiederm@xmission.com> <875ytkygfj.fsf_-_@disp2133>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <875ytkygfj.fsf_-_@disp2133>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/25/21 13:53, Eric W. Biederman wrote:
> 
> Update save_v86_state to always complete all of it's work except
> possibly some of the copies to userspace even if save_v86_state takes
> a fault.  This ensures that the kernel is always in a sane state, even
> if userspace has done something silly.
> 
> When save_v86_state takes a fault update it to force userspace to take
> a SIGSEGV and terminate the userspace application.
> 
> As Andy pointed out in review of the first version of this change
> there are races between sigaction and the application terinating.  Now
> that the code has been modified to always perform all save_v86_state's
> work (except possibly copying to userspace) those races do not matter
> from a kernel perspective.
> 
> Forcing the userspace application to terminate (by resetting it's
> handler to SIGDFL) is there to keep everything as close to the current
> behavior as possible while removing the unique (and difficult to
> maintain) use of do_exit.
> 
> If this new SIGSEGV happens during handle_signal the next time around
> the exit_to_user_mode_loop, SIGSEGV will be delivered to userspace.
> 
> All of the callers of handle_vm86_trap and handle_vm86_fault run the
> exit_to_user_mode_loop before they return to userspace any signal sent
> to the current task during their execution will be delivered to the
> current task before that tasks exits to usermode.
> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: H Peter Anvin <hpa@zytor.com>
> v1: https://lkml.kernel.org/r/20211020174406.17889-10-ebiederm@xmission.com
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
>   arch/x86/kernel/vm86_32.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Any does this look better?

Conceptually yes, but:

> 
> I think by just completing all of the work that isn't copying to
> userspace this makes save_v86_state much more robust.
> 
> diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
> index 63486da77272..933cafab7832 100644
> --- a/arch/x86/kernel/vm86_32.c
> +++ b/arch/x86/kernel/vm86_32.c
> @@ -140,6 +140,7 @@ void save_v86_state(struct kernel_vm86_regs *regs, int retval)
>   
>   	user_access_end();
>   
> +exit_vm86:
>   	preempt_disable();
>   	tsk->thread.sp0 = vm86->saved_sp0;
>   	tsk->thread.sysenter_cs = __KERNEL_CS;
> @@ -159,7 +160,8 @@ void save_v86_state(struct kernel_vm86_regs *regs, int retval)
>   	user_access_end();
>   Efault:
>   	pr_alert("could not access userspace vm86 info\n");
> -	do_exit(SIGSEGV);
> +	force_sigsegv(SIGSEGV);
> +	goto exit_vm86;
>   }
>   
>   static int do_vm86_irq_handling(int subfunction, int irqnumber);
> 

I think the result would be nicer if, instead of adding an extra goto, 
you just literally moved all the cleanup under the unsafe_put_user()s 
above them.  Unless I missed something, none of the put_user stuff reads 
any state that is written by the cleanup code.

--Andy
