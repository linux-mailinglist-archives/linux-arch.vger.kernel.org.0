Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195E93A3E50
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jun 2021 10:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhFKIwG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Jun 2021 04:52:06 -0400
Received: from mail-ua1-f51.google.com ([209.85.222.51]:43627 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhFKIwF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Jun 2021 04:52:05 -0400
Received: by mail-ua1-f51.google.com with SMTP id f1so2310733uaj.10;
        Fri, 11 Jun 2021 01:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ifAGUPWDxWLdwD/TBCG2zW8z6+MGYCS4uLUux0tgU4s=;
        b=cwSVbedGPH1HoQRU7LcjJut5OAMax5Vs/AvytjLY3x/2sZEmG9MoY0UsaxTSmXNqq3
         fL6Zg20JQOObNHDt2GHNX710V8AwHqKTNqYE9ZgWwwGEKkclYj0bTq/HXIK31uFEN1p8
         tF/ZC0OjuKzWvT/tklFjA/3gZfY/TKhIpLYPSaT7DzvRxT/CPOTfZVTuPz1k2c4XHFsp
         fVIkmEoe723W5sqFll1Okfs30WseGcZ76CKAPviz46jEkpZeTTIpIkCEhW0Va6YdZUs/
         WWjb46LCrPBh+xRII+666+17FCbe1tVk2d1I5TZkac/pdtkT/ILpvGIBPLumuEQxdeWm
         jkpw==
X-Gm-Message-State: AOAM532g7/zohzVsjVaFYTs+9/5/D7NF5NCla8gKugvmiL9ZLIRLlo67
        mNuCw2K8b5sXrZ/bC/YnKqVN2ciP4f8HZQtyoqE=
X-Google-Smtp-Source: ABdhPJzbyPX5gPeNCkUUxGlNBv5MPjCTQnfbsIAbZJkKiL21UsU0PKAX3/X6PRWC2NYqV9JQbybafT1XLL5zi6s4hwQ=
X-Received: by 2002:ab0:484b:: with SMTP id c11mr1936247uad.100.1623401407055;
 Fri, 11 Jun 2021 01:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210611082810.970791107@infradead.org> <20210611082838.222401495@infradead.org>
In-Reply-To: <20210611082838.222401495@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 11 Jun 2021 10:49:56 +0200
Message-ID: <CAMuHMdWg=Z47A=WEQegn9W_FU-WFDWvmNOWDVm5Kge=d_-GYhA@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] sched: Introduce task_is_running()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hoi Peter,

Thanks for your patch!

On Fri, Jun 11, 2021 at 10:36 AM Peter Zijlstra <peterz@infradead.org> wrote:
> Replace a bunch of 'p->state == TASK_RUNNING' with a new helper:
> task_is_running(p).

You're also sticking a READ_ONCE() in the helper, which wasn't done
by any of the old implementations? Care to mention why?

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Davidlohr Bueso <dave@stgolabs.net>

>  arch/m68k/kernel/process.c     |    2 +-

Regardless:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
