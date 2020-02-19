Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D73F164C48
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 18:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgBSRmc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 12:42:32 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33670 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgBSRmc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 12:42:32 -0500
Received: from zn.tnic (p200300EC2F095500C57DC876B1A4488F.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:5500:c57d:c876:b1a4:488f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9FFFF1EC0591;
        Wed, 19 Feb 2020 18:42:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582134150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DpvCtMjqcX25XbMiHHt7/X8aEcXXE9Ghl88YlkXaLKo=;
        b=cZiQCPVUp+LrsSX1QyqrebwJk24EqpWZK+j7W+aJxC8JJ1UoTV5ioerAUuCl7iI1p2CQ/k
        vQfI+wh/l37W+kADEV+CXvgpbnqMlhoNanR//2X50YNLOLzAiWRVfAYKjTDtCHAKBs3tis
        Hmrq69Zv7llUJmARUzJoTwtkd6FarZk=
Date:   Wed, 19 Feb 2020 18:42:23 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Greg KH <gregkh@linuxfoundation.org>, gustavo@embeddedor.com,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3 02/22] x86,mce: Delete ist_begin_non_atomic()
Message-ID: <20200219174223.GE30966@zn.tnic>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.488895196@infradead.org>
 <20200219171309.GC32346@zn.tnic>
 <CALCETrWBEDjenqze3wVc6TkUt_g+OFx9TQbYysLH+6fku=aWjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrWBEDjenqze3wVc6TkUt_g+OFx9TQbYysLH+6fku=aWjQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 09:21:48AM -0800, Andy Lutomirski wrote:
> Unless there is a signal pending and the signal setup code is about to
> hit the same failed memory.  I suppose we can just treat cases like
> this as "oh well, time to kill the whole system".
>
> But we should genuinely agree that we're okay with deferring this handling.

Good catch!

static void exit_to_usermode_loop(struct pt_regs *regs, u32 cached_flags)
{

	...

		/* deal with pending signal delivery */
                if (cached_flags & _TIF_SIGPENDING)
                        do_signal(regs);

                if (cached_flags & _TIF_NOTIFY_RESUME) {
                        clear_thread_flag(TIF_NOTIFY_RESUME);
                        tracehook_notify_resume(regs);
                        rseq_handle_notify_resume(NULL, regs);
                }


Err, can we make task_work run before we handle signals? Or there's a
reason it is run in this order?

Comment over task_work_add() says:

 * This is like the signal handler which runs in kernel mode, but it doesn't
 * try to wake up the @task.

which sounds to me like this should really run before the signal
handlers...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
