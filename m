Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89287436DF7
	for <lists+linux-arch@lfdr.de>; Fri, 22 Oct 2021 01:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbhJUXLl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 19:11:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230500AbhJUXLk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 Oct 2021 19:11:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 328976128E;
        Thu, 21 Oct 2021 23:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634857763;
        bh=xs401OyNs3MqjYVdTWFF8caYtEXqw/jnMQ34Ytv3WjQ=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=V+0oDB7ALCQhfqkMZ2i4dvrFQek30bkmM5P1H+6eAqIXInq4lWwkg4tPJOfBcj0UW
         mXOWp/9dwvtjLS1CPvHxXzXjn+4z/+fqR7S2Qa3XY99CCzr4IUMmS70HGY0suG/cD7
         or0/O6h0H1ahjdyMzRIFUj6Zbn7ntYhQJf12+t1pyxJODjuFrw/TJYlHBzU5+B0EC+
         hfVuYnZxqJEOi/aNwGS/ez3y9ijb5A2aGWX9y1HRclpf2TGKAe3+npAFBGglK5lTgO
         WYPBXRYSuHGvGvVSr5nsxpUdYDze+ldo9Q3MoC01iG8LpnWSq27NcWJsCHK4e4vnMc
         xoNUlCjjNmiYQ==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2F44F27C0054;
        Thu, 21 Oct 2021 19:09:21 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Thu, 21 Oct 2021 19:09:21 -0400
X-ME-Sender: <xms:IPNxYZxkgX3XhU6P3GQIShBZQw7sCfxoptDNLKRmnaIol2Qz3Qgnxw>
    <xme:IPNxYZQaQgA-sqZEj_Kw0CBFDeGFZFfylCLcfVrR4brUF519Ji9svoi0aBpMQQAv3
    oHFDs68nFL8tbu-41g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvjedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedthfehtedtvdetvdetudfgueeuhfdtudegvdelveelfedvteelfffg
    fedvkeegfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedukeeh
    ieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugi
    drlhhuthhordhush
X-ME-Proxy: <xmx:IPNxYTWh1k-FZhCgd9zAm6eHwPrZOAJuLyo6aY7FT0VXIs0RzBzqRg>
    <xmx:IPNxYbit96pKQj-kg8hedSurtPzLRHhpYa3zr4Sa2KhmhNJZZ6vCUQ>
    <xmx:IPNxYbALbEOgVeb2EXWIPzFkoHWxvPM4yY-z8YnXIGJn52Iee_NouQ>
    <xmx:IfNxYXussyy7jeaQNG-hpt96_mdVXR1V7oM_rZzElGmYNYkiGThPecuIzKs>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2C17621E006E; Thu, 21 Oct 2021 19:09:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1369-gd055fb5e7c-fm-20211018.002-gd055fb5e
Mime-Version: 1.0
Message-Id: <b5d52d25-7bde-4030-a7b1-7c6f8ab90660@www.fastmail.com>
In-Reply-To: <20211020174406.17889-10-ebiederm@xmission.com>
References: <87y26nmwkb.fsf@disp2133>
 <20211020174406.17889-10-ebiederm@xmission.com>
Date:   Thu, 21 Oct 2021 16:08:58 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc:     linux-arch@vger.kernel.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Oleg Nesterov" <oleg@redhat.com>,
        "Al Viro" <viro@ZenIV.linux.org.uk>,
        "Kees Cook" <keescook@chromium.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 10/20] signal/vm86_32: Properly send SIGSEGV when the vm86 state
 cannot be saved.
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On Wed, Oct 20, 2021, at 10:43 AM, Eric W. Biederman wrote:
> Instead of pretending to send SIGSEGV by calling do_exit(SIGSEGV)
> call force_sigsegv(SIGSEGV) to force the process to take a SIGSEGV
> and terminate.

Why?  I realize it's more polite, but is this useful enough to justify the need for testing and potential security impacts?

>
> Update handle_signal to return immediately when save_v86_state fails
> and kills the process.  Returning immediately without doing anything
> except killing the process with SIGSEGV is also what signal_setup_done
> does when setup_rt_frame fails.  Plus it is always ok to return
> immediately without delivering a signal to a userspace handler when a
> fatal signal has killed the current process.
>

I can mostly understand the individual sentences, but I don't understand what you're getting it.  If a fatal signal has killed the current process and we are guaranteed not to hit the exit-to-usermode path, then, sure, it's safe to return unless we're worried that the core dump code will explode.

But, unless it's fixed elsewhere in your series, force_sigsegv() is itself quite racy, or at least looks racy -- it can race against another thread calling sigaction() and changing the action to something other than SIG_DFL.  So it does not appear to actually reliably kill the caller, especially if exposed to a malicious user program.



> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: H Peter Anvin <hpa@zytor.com>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  arch/x86/kernel/signal.c  | 6 +++++-
>  arch/x86/kernel/vm86_32.c | 2 +-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> index f4d21e470083..25a230f705c1 100644
> --- a/arch/x86/kernel/signal.c
> +++ b/arch/x86/kernel/signal.c
> @@ -785,8 +785,12 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
>  	bool stepping, failed;
>  	struct fpu *fpu = &current->thread.fpu;
> 
> -	if (v8086_mode(regs))
> +	if (v8086_mode(regs)) {
>  		save_v86_state((struct kernel_vm86_regs *) regs, VM86_SIGNAL);
> +		/* Has save_v86_state failed and killed the process? */
> +		if (fatal_signal_pending(current))
> +			return;

This might be an ABI break, or at least it could be if anyone cared about vm86.  Imagine this wasn't guarded by if (v8086_mode) and was just if (fatal_signal_pending(current)) return;  Then all the other processing gets skipped if a fatal signal is pending (e.g. from a concurrent kill), which could cause visible oddities in a core dump, I think.  Maybe it's minor.

> +	}
> 
>  	/* Are we from a system call? */
>  	if (syscall_get_nr(current, regs) != -1) {
> diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
> index 63486da77272..040fd01be8b3 100644
> --- a/arch/x86/kernel/vm86_32.c
> +++ b/arch/x86/kernel/vm86_32.c
> @@ -159,7 +159,7 @@ void save_v86_state(struct kernel_vm86_regs *regs, 
> int retval)
>  	user_access_end();
>  Efault:
>  	pr_alert("could not access userspace vm86 info\n");
> -	do_exit(SIGSEGV);
> +	force_sigsegv(SIGSEGV);

This causes us to run unwitting kernel code with the vm86 garbage still loaded into the relevant architectural areas (see the chunk if save_v86_state that's inside preempt_disable()).  So NAK, especially since the aforementioned race might cause the exit-to-usermode path to actually run with who-knows-what consequences.

If you really want to make this change, please arrange for save_v86_state() to switch out of vm86 mode *before* anything that might fail so that it's guaranteed to at least put the task in a sane state.  And write an explicit test case that tests it.  I could help with the latter if you do the former.

--Andy
