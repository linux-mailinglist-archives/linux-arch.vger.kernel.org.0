Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A5124A07A
	for <lists+linux-arch@lfdr.de>; Wed, 19 Aug 2020 15:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgHSNq5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Aug 2020 09:46:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59111 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728681AbgHSNqr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Aug 2020 09:46:47 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k8OQB-0005pv-If; Wed, 19 Aug 2020 13:46:31 +0000
Date:   Wed, 19 Aug 2020 15:46:29 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Matthew Wilcox <willy@infradead.org>, peterz@infradead.org,
        Christoph Hewllig <hch@infradead.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stafford Horne <shorne@gmail.com>,
        Kars de Jong <jongk@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Greentime Hu <green.hu@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>, linux-doc@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, sparclinux@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 00/11] Introduce kernel_clone(), kill _do_fork()
Message-ID: <20200819134629.mvd4nupme7q2hmtz@wittgenstein>
References: <20200818173411.404104-1-christian.brauner@ubuntu.com>
 <20200818174447.GV17456@casper.infradead.org>
 <20200819074340.GW2674@hirez.programming.kicks-ass.net>
 <20200819084556.im5zfpm2iquzvzws@wittgenstein>
 <20200819111851.GY17456@casper.infradead.org>
 <87a6yq222c.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a6yq222c.fsf@x220.int.ebiederm.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 19, 2020 at 08:32:59AM -0500, Eric W. Biederman wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> 
> > On Wed, Aug 19, 2020 at 10:45:56AM +0200, Christian Brauner wrote:
> >> On Wed, Aug 19, 2020 at 09:43:40AM +0200, peterz@infradead.org wrote:
> >> > On Tue, Aug 18, 2020 at 06:44:47PM +0100, Matthew Wilcox wrote:
> >> > > On Tue, Aug 18, 2020 at 07:34:00PM +0200, Christian Brauner wrote:
> >> > > > The only remaining function callable outside of kernel/fork.c is
> >> > > > _do_fork(). It doesn't really follow the naming of kernel-internal
> >> > > > syscall helpers as Christoph righly pointed out. Switch all callers and
> >> > > > references to kernel_clone() and remove _do_fork() once and for all.
> >> > > 
> >> > > My only concern is around return type.  long, int, pid_t ... can we
> >> > > choose one and stick to it?  pid_t is probably the right return type
> >> > > within the kernel, despite the return type of clone3().  It'll save us
> >> > > some work if we ever go through the hassle of growing pid_t beyond 31-bit.
> >> > 
> >> > We have at least the futex ABI restricting PID space to 30 bits.
> >> 
> >> Ok, looking into kernel/futex.c I see 
> >> 
> >> pid_t pid = uval & FUTEX_TID_MASK;
> >> 
> >> which is probably what this referes to and /proc/sys/kernel/threads-max
> >> is restricted to FUTEX_TID_MASK.
> >> 
> >> Afaict, that doesn't block switching kernel_clone() to return pid_t. It
> >> can't create anything > FUTEX_TID_MASK anyway without yelling EAGAIN at
> >> userspace. But it means that _if_ we were to change the size of pid_t
> >> we'd likely need a new futex API. 
> >
> > Yes, there would be a lot of work to do to increase the size of pid_t.
> > I'd just like to not do anything to make that harder _now_.  Stick to
> > using pid_t within the kernel.
> 
> Just so people are aware.  If you look in include/linux/threads.h you
> can see that the maximum value of PID_MAX_LIMIT limits pids to 22 bits.
> 
> Further the design decisions of pids keeps us densly using pids.  So I
> expect it will be a while before we even come close to using 30 bits of
> pid space.

Also because it's simply annoying to have to type really large pid
numbers on the shell. Yes yes, that's a very privileged
developer-centric complaint but it matters when you have to do a quick
kill -9. Chromebook users obviously won't care about how large their
pids are for sure.

Tbf, related to discussions last year, systemd now actually raises the
default limit from ~33000 to 4194304. Which seems like an ok compromise.

Christian
