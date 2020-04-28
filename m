Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6AB1BB8B6
	for <lists+linux-arch@lfdr.de>; Tue, 28 Apr 2020 10:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgD1IVw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Apr 2020 04:21:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34708 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgD1IVv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Apr 2020 04:21:51 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jTLUl-0004Ab-MP; Tue, 28 Apr 2020 08:21:35 +0000
Date:   Tue, 28 Apr 2020 10:21:33 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
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
        Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC v2] ptrace, pidfd: add pidfd_ptrace syscall
Message-ID: <20200428082133.kusyjofgg7w2lchg@wittgenstein>
References: <CAHk-=wga3O=BoKZXR27-CDnAFareWcMxXhpWerwtCffdaH6_ow@mail.gmail.com>
 <B7A115CB-0C8C-4719-B97B-74D94231CD1E@amacapital.net>
 <CAHk-=whQzOsh9O2uhUO2VETD+hrzjKMpEJpzoUby5QHMcvgPKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whQzOsh9O2uhUO2VETD+hrzjKMpEJpzoUby5QHMcvgPKg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 27, 2020 at 09:28:14PM -0700, Linus Torvalds wrote:
> On Mon, Apr 27, 2020 at 9:17 PM Andy Lutomirski <luto@amacapital.net> wrote:
> >
> > I hate to say this, but I’m not convinced that asking the gdb folks is
> > the right approach. GDB has an ancient architecture and is
> > *incredibly* buggy. I’m sure ptrace is somewhere on the pain point
> > list, but I suspect it’s utterly dwarfed by everything else.
> 
> You may be right. However, if gdbn isn't going to use it, then I
> seriously don't think it's worth changing much.
> 
> It might be worth looking at people who don't use ptrace() for
> debugging, but for "incidental" reasons. IOW sandboxing, tracing,
> things like that.
> 
> Maybe those people want things that are simpler and don't actually
> need the kinds of hard serialization that ptrace() wants.
> 
> I'd rather add a few really simple things that might not be a full
> complement of operations for a debugger, but exactly because they
> aren't a full debugger, maybe they are things that we can tell are
> obviously secure and simple?

I think the biggest non-anecdotal user of ptrace() besides debuggers
is actually criu (and strace of course). They use it to inject parasite
code (their phrasing not mine) into another task to handle restoring the
parts of a task that can't be restored from the outside. Looking through
their repo they make quite a bit of use of ptrace functionality including
some arch specific bits:
PTRACE_GETREGSET
PTRACE_GETFPREGS
PTRACE_PEEKUSER
PTRACE_POKEUSER
PTRACE_CONT
PTRACE_SETREGSET
PTRACE_GETVFPREGS /* arm/arm64 */
PTRACE_GETVRREGS /* powerpc */
PTRACE_GETVSRREGS /* powerpc */
PTRACE_EVENT_STOP
PTRACE_GETSIGMASK
PTRACE_INTERRUPT
PTRACE_DETACH
PTRACE_GETSIGINFO
PTRACE_SEIZE
PTRACE_SETSIGMASK
PTRACE_SI_EVENT
PTRACE_SYSCALL
PTRACE_SETOPTIONS
PTRACE_ATTACH
PTRACE_O_SUSPEND_SECCOMP
PTRACE_PEEKSIGINFO
PTRACE_SECCOMP_GET_FILTER
PTRACE_SECCOMP_GET_METADATA

So I guess strace and criu would be the ones to go and ask and if they
don't care enough we already need to start squinting for other larg-ish
users. proot comes to mind
https://github.com/proot-me/proot

(From personal experience, most of the time when ptrace is used in a
 non-debugger codebase it's either to plug a security hole exploitable
 through ptracing the task and the fix is ptracing that very task to
 prevent the attacker from ptracing it (where non-dumpability alone
 doesn't cut it) or the idea is dropped immediately to not lose the
 ability to use a debugger on the program.)

Christian
