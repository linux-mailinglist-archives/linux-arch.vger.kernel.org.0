Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E24617CCB5
	for <lists+linux-arch@lfdr.de>; Sat,  7 Mar 2020 08:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgCGHrE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 7 Mar 2020 02:47:04 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44329 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgCGHrE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 7 Mar 2020 02:47:04 -0500
Received: by mail-qt1-f195.google.com with SMTP id h16so3488419qtr.11
        for <linux-arch@vger.kernel.org>; Fri, 06 Mar 2020 23:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CJaGuE6xjlwUdKde+nh834lDDnUaVIY1l9gUCqflQZs=;
        b=mrboOzb015mzZ3cdDvl8jKCqwe6B++cNC3lPjplgSU3Rn2LrOOqmFKlya7+9SnKiKE
         K9IGQleQRLSPUPNSg3t4FDzKjrls7eqdvZQjcrllrAbZl7OtPfK9NW8FB7y0xDgVZahC
         UYHbP/kZVR6JzdYRDnaOaRBj3k1aF+6UR14kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CJaGuE6xjlwUdKde+nh834lDDnUaVIY1l9gUCqflQZs=;
        b=cIZNrTUyvmVke67jYDZ/0MsPm+ZSDsCvAS1f6FfRDq8TkV6DiXAOZ0Fr6sunoYq7D2
         GfxBd0erUqi02owttw4Po2vaKbT35JXteZXye+jyAV6+NAy/0/sQ+GC7HRT4ZJ1jGt5F
         LpQdzydILvgzReEAPF8c9/sy6hJcvoLtYdQV4tLJT02kNa0Guwn1BQNmeYGV/7XSPFWd
         C/V4qmG0AL60u9OjZ4ceCjJxo1luX43J2XauhWINjtinYHyaCUFEiqJ5GCuQilDJjMNy
         PsWWG4waojvZMR6zwtCoF4joh7JLS+S0UQz5R0USviaFMoNXOAjxjVq5a0eAWNoydWiJ
         CiPQ==
X-Gm-Message-State: ANhLgQ1F7idxYaDIRFkMYgZGUyD4+OCX/vKv1j6Na6WPAJjofzYg/VbG
        sLt6NZa0jHYxNutKXIzZC8d75g==
X-Google-Smtp-Source: ADFU+vtziRMfTg1yps/AiQZAfaYNlrFmOCmXTvfWuxMug3AFf0WhRHxfqc72oVQu22YI2hEdemYf6g==
X-Received: by 2002:aed:38c8:: with SMTP id k66mr3241657qte.50.1583567223388;
        Fri, 06 Mar 2020 23:47:03 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id i132sm19278276qke.41.2020.03.06.23.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 23:47:02 -0800 (PST)
Date:   Sat, 7 Mar 2020 02:47:02 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] x86/kprobes: Prohibit probing on rcu_nmi_exit() and
 ist_exit()
Message-ID: <20200307074702.GA231616@google.com>
References: <158355013189.14191.9105069890402942867.stgit@devnote2>
 <20200307032831.GL2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307032831.GL2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 06, 2020 at 07:28:31PM -0800, Paul E. McKenney wrote:
> On Sat, Mar 07, 2020 at 12:02:12PM +0900, Masami Hiramatsu wrote:
> > Prohibit probing on rcu_nmi_exit() and ist_exit() which
> > are called from do_int3()'s kprobe path after kprobe_int3_handler().
> > 
> > The commit c13324a505c7 ("x86/kprobes: Prohibit probing on
> > functions before kprobe_int3_handler()") tried to fix similar
> > issue, but it only marks the functions before kprobe_int3_handler()
> > in do_int3().
> > 
> > If we put a kprobe on rcu_nmi_exit() or ist_exit(), the kprobes
> > will detect reentrance. However, it only skips the kprobe handler,
> > exits from do_int3() and hits ist_exit() and rcu_nmi_exit() again.
> > Thus, it causes another int3 exception and finally we will get
> > the kernel panic with "Unrecoverable kprobe detected." error message.
> > 
> > This is reproducible by the following commands.
> > 
> > / # echo 0 > /proc/sys/debug/kprobes-optimization
> > / # echo p vfs_read > /sys/kernel/debug/tracing/kprobe_events
> > / # echo p rcu_nmi_exit >> /sys/kernel/debug/tracing/kprobe_events
> > / # echo 1 > /sys/kernel/debug/tracing/events/kprobes/enable
> > 
> > Fixes: c13324a505c7 ("x86/kprobes: Prohibit probing on functions before kprobe_int3_handler()")
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: stable@vger.kernel.org
> 
> From an RCU perspective:
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> 

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

> > ---
> >  arch/x86/kernel/traps.c |    1 +
> >  kernel/rcu/tree.c       |    1 +
> >  2 files changed, 2 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> > index 6ef00eb6fbb9..c63fb7697794 100644
> > --- a/arch/x86/kernel/traps.c
> > +++ b/arch/x86/kernel/traps.c
> > @@ -115,6 +115,7 @@ void ist_exit(struct pt_regs *regs)
> >  	if (!user_mode(regs))
> >  		rcu_nmi_exit();
> >  }
> > +NOKPROBE_SYMBOL(ist_exit);
> >  
> >  /**
> >   * ist_begin_non_atomic() - begin a non-atomic section in an IST exception
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index d91c9156fab2..c49ea0e919f9 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -670,6 +670,7 @@ void rcu_nmi_exit(void)
> >  {
> >  	rcu_nmi_exit_common(false);
> >  }
> > +NOKPROBE_SYMBOL(rcu_nmi_exit);
> >  
> >  /**
> >   * rcu_irq_exit - inform RCU that current CPU is exiting irq towards idle
> > 
