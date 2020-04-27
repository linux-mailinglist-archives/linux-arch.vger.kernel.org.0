Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22EF1BAF0D
	for <lists+linux-arch@lfdr.de>; Mon, 27 Apr 2020 22:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgD0UNO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Apr 2020 16:13:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43909 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgD0UNN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Apr 2020 16:13:13 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jTA7l-0006kq-1D; Mon, 27 Apr 2020 20:13:05 +0000
Date:   Mon, 27 Apr 2020 22:13:03 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Hagen Paul Pfeifer <hagen@jauu.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC v2] ptrace, pidfd: add pidfd_ptrace syscall
Message-ID: <20200427201303.tbiipopeapxofn6h@wittgenstein>
References: <20200426130100.306246-1-hagen@jauu.net>
 <20200426163430.22743-1-hagen@jauu.net>
 <20200427170826.mdklazcrn4xaeafm@wittgenstein>
 <CAG48ez0hskhN7OkxwHX-Bo5HGboJaVEk8udFukkTgiC=43ixcw@mail.gmail.com>
 <87zhawdc6w.fsf@x220.int.ebiederm.org>
 <20200427185929.GA1768@laniakea>
 <CAK8P3a2Ux1pDZEBjgRSPMJXvwUAvbPastX2ynVVC2iPTTDK_ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a2Ux1pDZEBjgRSPMJXvwUAvbPastX2ynVVC2iPTTDK_ow@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 27, 2020 at 10:08:03PM +0200, Arnd Bergmann wrote:
> On Mon, Apr 27, 2020 at 8:59 PM Hagen Paul Pfeifer <hagen@jauu.net> wrote:
> >
> > * Eric W. Biederman | 2020-04-27 13:18:47 [-0500]:
> >
> > >I am conflicted about that but I have to agree.    Instead of
> > >duplicating everything it would be good enough to duplicate the once
> > >that cause the process to be attached to use.  Then there would be no
> > >more pid races to worry about.
> >
> > >How does this differ using the tracing related infrastructure we have
> > >for the kernel on a userspace process?  I suspect augmenting the tracing
> > >infrastructure with the ability to set breakpoints and watchpoints (aka
> > >stopping userspace threads and processes might be a more fertile
> > >direction to go).
> > >
> > >But I agree either we want to just address the races in PTRACE_ATTACH
> > >and PTRACE_SIEZE or we want to take a good hard look at things.
> > >
> > >There is a good case for minimal changes because one of the cases that
> > >comes up is how much work will it take to change existing programs.  But
> > >ultimately ptrace pretty much sucks so a very good set of test cases and
> > >documentation for what we want to implement would be a very good idea.
> >
> > Hey Eric, Jann, Christian, Arnd,
> >
> > thank you for your valuable input! IMHO I think we have exactly two choices
> > here:
> >
> > a) we go with my patchset that is 100% ptrace feature compatible - except the
> >    pidfd thing - now and in the future. If ptrace is extended pidfd_ptrace is
> >    automatically extended and vice versa. Both APIs are feature identical
> >    without any headaches.
> > b) leave ptrace completely behind us and design ptrace that we have always
> >    dreamed of! eBPF filters, ftrace kernel architecture, k/uprobe goodness,
> >    a speedy API to copy & modify large chunks of data, io_uring/epoll support
> >    and of course: pidfd based (missed likely thousands of other dreams)
> >
> > I think a solution in between is not worth the effort! It will not be
> > compatible in any way for the userspace and the benefit will be negligible.
> > Ptrace is horrible API - everybody knows that but developers get comfy with
> > it. You find examples everywhere, why should we make it harder for the user for
> > no or little benefit (except that stable handle with pidfd and some cleanups)?
> >
> > Any thoughts on this?
> 
> The way I understood Jann was that instead of a new syscall that duplicates
> everything in ptrace(), there would only need to be a new ptrace request
> such as PTRACE_ATTACH_PIDFD that behaves like PTRACE_ATTACH
> but takes a pidfd as the second argument, perhaps setting the return value
> to the pid on success. Same for PTRACE_SEIZE.

That was my initial suggestion, yes. Any enum that identifies a target
by a pid will get a new _PIDFD version and the pidfd is passed as pid_t
argument. That should work and is similar to what I did for waitid()
P_PIDFD. Realistically, there shouldn't be any system where pid_t is
smaller than an int that we care about.

> 
> In effect this is not much different from your a), just a variation on the
> calling conventions. The main upside is that it avoids adding another
> ugly interface, the flip side is that it makes the existing one slightly worse
> by adding complexity.

Basically, if a new syscall than please a proper re-design with real
benefits.

In the meantime we could make due with the _PIDFD variant. And then if
someone wants to do the nitty gritty work of adding a ptrace variant
purely based on pidfds and with a better api and features that e.g. Jann
pointed out then by all means, please do so. I'm sure we would all
welcome this as well.

Christian
