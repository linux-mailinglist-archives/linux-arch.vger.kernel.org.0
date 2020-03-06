Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B03217C8B7
	for <lists+linux-arch@lfdr.de>; Sat,  7 Mar 2020 00:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgCFXKc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Mar 2020 18:10:32 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33045 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgCFXKc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Mar 2020 18:10:32 -0500
Received: by mail-lf1-f66.google.com with SMTP id c20so3240756lfb.0;
        Fri, 06 Mar 2020 15:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qe8wUFv1rWfO0Jj+EAuF6LQPlbPXK3Z6EOrgI0Gdx9k=;
        b=LulrOrqpx0/0G8hFYqFzxTYNXXW1JCsFHC320W5pxat1R/Gq10mUIexXFg2X0IjgkH
         R/8OhsWZREwdNq+pWnetJCN+wKY6PPWO7dlynTtYJFZLdrxNLmuvOkDAxdvIqtMfa5Pf
         SNsnvvVnhVemr+T/5x7OgVlT89LwffGVOAG3Kgl/Qk6tX4RwNOAgMKPi67hqLUslbQpd
         FWE6uU0yvEXZRKex0XGHlyDOzviTBdAyQl1dH+YWCS9YJG9oNNCaXTXIbmDewUqRKY7N
         yGRAGMRJms0Yc3KcFiF3OJg4QbEE4Jg4HxqFtz9uiU5Qd3B82bawpm43rnyZe0QSVjMT
         BuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qe8wUFv1rWfO0Jj+EAuF6LQPlbPXK3Z6EOrgI0Gdx9k=;
        b=KCyZKLhJbCNBYIQCKd2ReG5OvD08oUk9LtFQF6dCaJHaUZUe0JN9JnWIbPC4zRsATo
         ZugppOY6e+iyHuIUvhR4zpT9RJutZpqRVYsKpkmD05bkHtb0g68eRGHUZt9Zrf1E9jJ6
         tS2qeMg6O3uTYothNo4O0Jl7iZITgBWV8mfElYC/59y3wdMVc1nKYpYrKEgywB64Y5z2
         +pau6BZuDI/Vw1oPhHrpyavFvMKbxorEx5tmdElF/bn5oC6txiZ6Fmat6LRoQFueufnc
         Ik2HKt3GuLsWPcMZHIN3x0KvsswtLu7pj4p19uw0VhPqmP50pJf+ESLnuiCA8ec55c4r
         qJtA==
X-Gm-Message-State: ANhLgQ0gXqdtqcgVmOH6ij6+NilG1FM6sH7ASdGJTm2+z+UH01HY/z3u
        e7IBsZGOJk3Inv8uEGt7kgWBkCRA68fYJUuGWJ4=
X-Google-Smtp-Source: ADFU+vsWXcoIQAUDTax0XOY1RpvoM6JRnIfSwIJuQvEjIepHZNV7DI+yPeXZlM2SlMk1yIeSgf5HOkbcz+PE0R5Ub0o=
X-Received: by 2002:a05:6512:304c:: with SMTP id b12mr3256481lfb.196.1583536229276;
 Fri, 06 Mar 2020 15:10:29 -0800 (PST)
MIME-Version: 1.0
References: <20200221133416.777099322@infradead.org> <20200306104335.GF3348@worktop.programming.kicks-ass.net>
 <20200306113135.GA8787@worktop.programming.kicks-ass.net> <CAADnVQKp=UKg8HAuMOFknhmXtfm_LVu_ynTNJuedHqKdA6zh1g@mail.gmail.com>
 <1896740806.20220.1583510668164.JavaMail.zimbra@efficios.com>
 <20200306125500.6aa75c0d@gandalf.local.home> <609624365.20355.1583526166349.JavaMail.zimbra@efficios.com>
 <20200306154556.6a829484@gandalf.local.home> <65796626.20397.1583528124078.JavaMail.zimbra@efficios.com>
In-Reply-To: <65796626.20397.1583528124078.JavaMail.zimbra@efficios.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 6 Mar 2020 15:10:17 -0800
Message-ID: <CAADnVQKot7kEYsEQrEszGeTuug4fpWGkc4GKA_yNeFi6OHe3uw@mail.gmail.com>
Subject: Re: [PATCH v4 16/27] tracing: Remove regular RCU context for _rcuidle
 tracepoints (again)
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        dan carpenter <dan.carpenter@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 6, 2020 at 12:55 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Mar 6, 2020, at 3:45 PM, rostedt rostedt@goodmis.org wrote:
>
> > On Fri, 6 Mar 2020 15:22:46 -0500 (EST)
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> >
> >> I agree with the overall approach. Just a bit of nitpicking on the API:
> >>
> >> I understand that the "prio" argument is a separate argument because it can take
> >> many values. However, "rcu" is just a boolean, so I wonder if we should not
> >> rather
> >> introduce a "int flags" with a bitmask enum, e.g.
> >
> > I thought about this approach, but thought it was a bit overkill. As the
> > kernel doesn't have an internal API, I figured we can switch this over to
> > flags when we get another flag to add. Unless you can think of one in the
> > near future.
>
> The additional feature I have in mind for near future would be to register
> a probe which can take a page fault to a "sleepable" tracepoint. This would
> require preemption to be enabled and use of SRCU.

I'm working on sleepable bpf as well and this extra flag for tracepoints
would come very handy, so I would go with flags approach right away.
We wouldn't need to touch the same protos multiple times,
less conflicts for us all, etc.
