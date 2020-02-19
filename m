Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10454164BAE
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 18:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgBSRTA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 12:19:00 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:41209 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgBSRTA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 12:19:00 -0500
Received: by mail-io1-f67.google.com with SMTP id m25so1394511ioo.8
        for <linux-arch@vger.kernel.org>; Wed, 19 Feb 2020 09:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eFFLbtKV1wHoHpSbO1vGKr55xKiOdJlHlqvO+VL5miQ=;
        b=MabFU/LNJ6iK5i7PFe+0avSvRodkDyxJVTzJwbnwlmFp8ec7HckrwZ5WxlPngA3Lbu
         m0uacrHQ6Ij6wWXzRbWXh9cb9byO2GB+jpP06/CxTTIdI31eSIVpKXB5U9enJNcfLFxw
         Dq67E9Hxga7B00YTYr/Eq/p6Cz8AihY8xCBwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eFFLbtKV1wHoHpSbO1vGKr55xKiOdJlHlqvO+VL5miQ=;
        b=dX4vd/HzqGh4OmJ6Jti6wBcmxSXI1ifN4ctoDO8+fhCLWDK0n6qFUCqU0yvJn4jrK0
         7RawqGau0mihKPcze2QE5m4WutmZdZVO/R/uSngO8ssXDfGcfN2tMVUxeQxw5fHgW/gM
         Y/L4+U2zSLAQdFnecGdL7cbHthCth45QgTY2kLbJTI58QMXAM2ozqlcUdWqUbrhgiYs2
         QPAbBneVGoufkoEBFImjwaC5RFACAOeehf+ymgBTzbF51akkmQqUrbESQlkzNjPsLf97
         rd++M9bQXZhn8bmJXr00yXBsZmiey6T8hzZiMfOCLkDoUVH4kotQ/IusiKiHV+E1hPK4
         c+xA==
X-Gm-Message-State: APjAAAV6SO1QLOW5CbsxVTJXMA4VlO3xMSmaEmEtca2bpq0lLDd3RPt/
        ceps1kkm9eYmSFDJy8eW9vG9z1x55Tl/FCtukaRhZg==
X-Google-Smtp-Source: APXvYqxB0l8/vhLc9U7gaSNF9v5Zi7hFO2pFY075Vik0MUlviJ4M/JnZkM7hLnjg1q0jDOD2pAvydSBAEchSKICMsEY=
X-Received: by 2002:a6b:db0d:: with SMTP id t13mr20864493ioc.171.1582132739221;
 Wed, 19 Feb 2020 09:18:59 -0800 (PST)
MIME-Version: 1.0
References: <20200219144724.800607165@infradead.org> <20200219150744.661923520@infradead.org>
 <20200219163156.GY2935@paulmck-ThinkPad-P72> <20200219121609.45548925@gandalf.local.home>
In-Reply-To: <20200219121609.45548925@gandalf.local.home>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 19 Feb 2020 12:18:48 -0500
Message-ID: <CAEXW_YT1W4ctSt8xc2ErWwRucp2BTdV3FhB3F3iVdGogWAqELg@mail.gmail.com>
Subject: Re: [PATCH] rcu/kprobes: Comment why rcu_nmi_enter() is marked NOKPROBE
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Glexiner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 12:16 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
>
> It's confusing that rcu_nmi_enter() is marked NOKPROBE and
> rcu_nmi_exit() is not. One may think that the exit needs to be marked
> for the same reason the enter is, as rcu_nmi_exit() reverts the RCU
> state back to what it was before rcu_nmi_enter(). But the reason has
> nothing to do with the state of RCU.
>
> The breakpoint handler (int3 on x86) must not have any kprobe on it
> until the kprobe handler is called. Otherwise, it can cause an infinite
> recursion and crash the machine. It just so happens that
> rcu_nmi_enter() is called by the int3 handler before the kprobe handler
> can run, and therefore needs to be marked as NOKPROBE.
>
> Comment this to remove the confusion to why rcu_nmi_enter() is marked
> NOKPROBE but rcu_nmi_exit() is not.
>
> Link: https://lore.kernel.org/r/20200213163800.5c51a5f1@gandalf.local.home
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Reported-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> ---
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 1694a6b57ad8..ada7b2b638fb 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -846,6 +846,14 @@ void rcu_nmi_enter(void)
>  {
>         rcu_nmi_enter_common(false);
>  }
> +/*
> + * All functions called in the breakpoint trap handler (e.g. do_int3()
> + * on x86), must not allow kprobes until the kprobe breakpoint handler
> + * is called, otherwise it can cause an infinite recursion.
> + * On some archs, rcu_nmi_enter() is called in the breakpoint handler
> + * before the kprobe breakpoint handler is called, thus it must be
> + * marked as NOKPROBE.
> + */
>  NOKPROBE_SYMBOL(rcu_nmi_enter);
>
>  /**
