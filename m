Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9AFC2B37EB
	for <lists+linux-arch@lfdr.de>; Sun, 15 Nov 2020 19:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbgKOSip (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 15 Nov 2020 13:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgKOSio (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 15 Nov 2020 13:38:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3A9C0613D1;
        Sun, 15 Nov 2020 10:38:44 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605465522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O4mgR0kHkYjGB2CrntfnSMeBIDhzCNl2DmyYq35MLl0=;
        b=E1SpT58uj57870IoxbMzDovdySlH/UOrN4fG7EVSG+gVuSbdsNqVkiFBGB6qJA5aoYeZSV
        cTq0eCmRAbc1Fn7XEG2HHod5kbh7LKeeJiMDlYuzWSTSFoDBd8EF8JZj8U/rgr/rZ1Mdps
        fv+pjyK/V4sOL3zJdB6NyZyk9DoYu9KCM8wm3b96+y46Tai2Zjboy7FAQjkKMnRYyMa1aO
        58Zf8bvyMpku3nM5hPVIKRy8TB98aqG9rSOTiWhV+4UE35z1Sl2e4zYXxozv+hWFX/Is5L
        5GKCmEpJF+c7Xxfp5yONa36rlbujzmjo69d1Mka6tfTh4+Lm+VnwPPny5LHs9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605465522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O4mgR0kHkYjGB2CrntfnSMeBIDhzCNl2DmyYq35MLl0=;
        b=7jIUMERIvDFev2Ut8f0IFEa1aGM9KjWKagnilHHX98lIYHtl/FB0+ONh5ZBwqLl9HfLlF/
        AF3i5mIxZJM47tCw==
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     mingo@redhat.com, keescook@chromium.org, arnd@arndb.de,
        luto@amacapital.net, wad@chromium.org, rostedt@goodmis.org,
        paul@paul-moore.com, eparis@redhat.com, oleg@redhat.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: Re: [PATCH 03/10] kernel: entry: Wire up syscall_work in common entry code
In-Reply-To: <20201114032917.1205658-4-krisman@collabora.com>
References: <20201114032917.1205658-1-krisman@collabora.com> <20201114032917.1205658-4-krisman@collabora.com>
Date:   Sun, 15 Nov 2020 19:38:42 +0100
Message-ID: <87v9e68nyl.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 13 2020 at 22:29, Gabriel Krisman Bertazi wrote:

"kernel: entry:" is not the right subsystem prefix.

git log kernel/entry/ might give you a hint.

> Prepares the common entry code to use the SYSCALL_WORK flags. They
> will

s/Prepares/Prepare/

> be defined in subsequent patches for each type of syscall
> work. SYSCALL_WORK_ENTRY/EXIT are defined for the transition, as they
> will replace the TIF_ equivalent defines.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  include/linux/entry-common.h |  3 +++
>  kernel/entry/common.c        | 15 +++++++++------
>  2 files changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index 1a128baf3628..cbc5c702ee4d 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -64,6 +64,9 @@
>  	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT |			\
>  	 _TIF_SYSCALL_TRACEPOINT | ARCH_SYSCALL_EXIT_WORK)
>  
> +#define SYSCALL_WORK_ENTER	(0)
> +#define SYSCALL_WORK_EXIT	(0)
> +
>  /*
>   * TIF flags handled in exit_to_user_mode_loop()
>   */
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index bc75c114c1b3..5a4bb72ff28e 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -42,7 +42,7 @@ static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
>  }
>  
>  static long syscall_trace_enter(struct pt_regs *regs, long syscall,
> -				unsigned long ti_work)
> +				unsigned long ti_work, unsigned long work)
>  {
>  	long ret = 0;
>  
> @@ -75,10 +75,11 @@ static __always_inline long
>  __syscall_enter_from_user_work(struct pt_regs *regs, long syscall)
>  {
>  	unsigned long ti_work;
> +	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);

Even if this is temporary this code uses reverse fir tree ordering of
variable declarations:

	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
 	unsigned long ti_work;

Thanks,

        tglx
