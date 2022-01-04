Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5CD483BFD
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jan 2022 07:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiADGau (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 01:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiADGat (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jan 2022 01:30:49 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B82AC061761;
        Mon,  3 Jan 2022 22:30:49 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id i31so79477553lfv.10;
        Mon, 03 Jan 2022 22:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cuvNM+fmPp7INL1ambomuCdWYuuyXMJr3D3Te79Ur4w=;
        b=QO/looSWJ6nChw5+HyWpxBKu595c/9UDIhnA0EKGNO4G4JGF4N5WBj3XFoT4wtb+z7
         C7bjlEfCbdI6N2Sz/8fbR3V5k9Kd/WoKBgwB7Zt5DrIFn/sM/IlXiwWNTjuxnKmnMBf1
         LwGjBWBnGxgiCGN3UXL6zGRZbGBiySC02zwLaE56rqlV8/19VOHY2wsIQbLRscLQGxL3
         lvGe41MXDt91vbMVBAVHb+6soxydhkE8LoYuUFoAVEy+GtZmvKv4noJjw/4WUmUnPScI
         9YdELuKji7j1x5t+1zAF2TKnq35CwWnj6QdTQ8nYDvNWrC05eV2gp++7LrSob1v/2RFG
         GN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cuvNM+fmPp7INL1ambomuCdWYuuyXMJr3D3Te79Ur4w=;
        b=syoiGb5v9/Ws+aPszBr2eljAdkH3kPWSoZcPu0j30Cw/r1EeyHkJGfiN8otcAbVqr4
         lVF0va/qPgqMa0zA4oEfTZM09jDzNjBwuD8vEOIW/4EgGcOnhq5NVsqskt0l+PIppe1b
         AnhQM9snLQA68ACPi4Ukhnd+Om0Rc3tnFS/UezXijwUSRGd3AEvasUtMpl7We4HhGbzP
         dlbTNHII7+uTaPltmMyO3dXUkjI+GiCwvniVd8VFbP0Rn/N4mf4f1fgMx3qJKPlL4qY8
         zmSNpN7QU7ctLhw1BfF2FbS/5KYIAK1ZDOnXo7RBNOI5TWWlrKTzcezKiRBQih2xj/xo
         zeaQ==
X-Gm-Message-State: AOAM5321Fn6v7cwpWyk811pECwzC/jmsyzJxHPHVvw1dq1hj+rStXCJr
        /gR0lbxSoXvQ8qE4R6U3oNv8ilwPjHY=
X-Google-Smtp-Source: ABdhPJw7N+Os/lmP85L07QMUBbcJRt1+NdfEgBJ2Ea2//cwiP8kyDq1HX5QYpVYpJqtFD1M+aK02Sg==
X-Received: by 2002:a19:6748:: with SMTP id e8mr13089220lfj.358.1641277846907;
        Mon, 03 Jan 2022 22:30:46 -0800 (PST)
Received: from [192.168.2.145] (46-138-43-24.dynamic.spd-mgts.ru. [46.138.43.24])
        by smtp.googlemail.com with ESMTPSA id c23sm56445lfm.80.2022.01.03.22.30.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 22:30:46 -0800 (PST)
Subject: Re: [PATCH 1/8] signal: Make SIGKILL during coredumps an explicit
 special case
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <20211213225350.27481-1-ebiederm@xmission.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9363765f-9883-75ee-70f1-a1a8e9841812@gmail.com>
Date:   Tue, 4 Jan 2022 09:30:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211213225350.27481-1-ebiederm@xmission.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

14.12.2021 01:53, Eric W. Biederman пишет:
> Simplify the code that allows SIGKILL during coredumps to terminate
> the coredump.  As far as I can tell I have avoided breaking it
> by dumb luck.
> 
> Historically with all of the other threads stopping in exit_mm the
> wants_signal loop in complete_signal would find the dumper task and
> then complete_signal would wake the dumper task with signal_wake_up.
> 
> After moving the coredump_task_exit above the setting of PF_EXITING in
> commit 92307383082d ("coredump: Don't perform any cleanups before
> dumping core") wants_signal will consider all of the threads in a
> multi-threaded process for waking up, not just the core dumping task.
> 
> Luckily complete_signal short circuits SIGKILL during a coredump marks
> every thread with SIGKILL and signal_wake_up.  This code is arguably
> buggy however as it tries to skip creating a group exit when is already
> present, and it fails that a coredump is in progress.
> 
> Ever since commit 06af8679449d ("coredump: Limit what can interrupt
> coredumps") was added dump_interrupted needs not just TIF_SIGPENDING
> set on the dumper task but also SIGKILL set in it's pending bitmap.
> This means that if the code is ever fixed not to short-circuit and
> kill a process after it has already been killed the special case
> for SIGKILL during a coredump will be broken.
> 
> Sort all of this out by making the coredump special case more special,
> and perform all of the work in prepare_signal and leave the rest of
> the signal delivery path out of it.
> 
> In prepare_signal when the process coredumping is sent SIGKILL find
> the task performing the coredump and use sigaddset and signal_wake_up
> to ensure that task reports fatal_signal_pending.
> 
> Return false from prepare_signal to tell the rest of the signal
> delivery path to ignore the signal.
> 
> Update wait_for_dump_helpers to perform a wait_event_killable wait
> so that if signal_pending gets set spuriously the wait will not
> be interrupted unless fatal_signal_pending is true.
> 
> I have tested this and verified I did not break SIGKILL during
> coredumps by accident (before or after this change).  I actually
> thought I had and I had to figure out what I had misread that kept
> SIGKILL during coredumps working.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  fs/coredump.c   |  4 ++--
>  kernel/signal.c | 11 +++++++++--
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/coredump.c b/fs/coredump.c
> index a6b3c196cdef..7b91fb32dbb8 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -448,7 +448,7 @@ static void coredump_finish(bool core_dumped)
>  static bool dump_interrupted(void)
>  {
>  	/*
> -	 * SIGKILL or freezing() interrupt the coredumping. Perhaps we
> +	 * SIGKILL or freezing() interrupted the coredumping. Perhaps we
>  	 * can do try_to_freeze() and check __fatal_signal_pending(),
>  	 * but then we need to teach dump_write() to restart and clear
>  	 * TIF_SIGPENDING.
> @@ -471,7 +471,7 @@ static void wait_for_dump_helpers(struct file *file)
>  	 * We actually want wait_event_freezable() but then we need
>  	 * to clear TIF_SIGPENDING and improve dump_interrupted().
>  	 */
> -	wait_event_interruptible(pipe->rd_wait, pipe->readers == 1);
> +	wait_event_killable(pipe->rd_wait, pipe->readers == 1);
>  
>  	pipe_lock(pipe);
>  	pipe->readers--;
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 8272cac5f429..7e305a8ec7c2 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -907,8 +907,15 @@ static bool prepare_signal(int sig, struct task_struct *p, bool force)
>  	sigset_t flush;
>  
>  	if (signal->flags & (SIGNAL_GROUP_EXIT | SIGNAL_GROUP_COREDUMP)) {
> -		if (!(signal->flags & SIGNAL_GROUP_EXIT))
> -			return sig == SIGKILL;
> +		struct core_state *core_state = signal->core_state;
> +		if (core_state) {
> +			if (sig == SIGKILL) {
> +				struct task_struct *dumper = core_state->dumper.task;
> +				sigaddset(&dumper->pending.signal, SIGKILL);
> +				signal_wake_up(dumper, 1);
> +			}
> +			return false;
> +		}
>  		/*
>  		 * The process is in the middle of dying, nothing to do.
>  		 */
> 

Hi,

This patch breaks userspace, in particular it breaks gst-plugin-scanner
of GStreamer which hangs now on next-20211224. IIUC, this tool builds a
registry of good/working GStreamer plugins by loading them and
blacklisting those that don't work (crash). Before the hang I see
systemd-coredump process running, taking snapshot of gst-plugin-scanner
and then gst-plugin-scanner gets stuck.

Bisection points at this patch, reverting it restores
gst-plugin-scanner. Systemd-coredump still running, but there is no hang
anymore and everything works properly as before.

I'm seeing this problem on ARM32 and haven't checked other arches.
Please fix, thanks in advance.
