Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368EB489D63
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jan 2022 17:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbiAJQUK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jan 2022 11:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237046AbiAJQUJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jan 2022 11:20:09 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA54C06173F;
        Mon, 10 Jan 2022 08:20:09 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6xOt-0013Jc-8T; Mon, 10 Jan 2022 16:20:03 +0000
Date:   Mon, 10 Jan 2022 16:20:03 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 08/17] ptrace/m68k: Stop open coding ptrace_report_syscall
Message-ID: <YdxcszwEslyQJSuF@zeniv-ca.linux.org.uk>
References: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
 <20220103213312.9144-8-ebiederm@xmission.com>
 <CAMuHMdWsNBjOJh0QEx9sppA9x3WoL8H2icqukNqECFhOPremjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWsNBjOJh0QEx9sppA9x3WoL8H2icqukNqECFhOPremjw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 10, 2022 at 04:26:57PM +0100, Geert Uytterhoeven wrote:
> On Mon, Jan 3, 2022 at 10:33 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> > The generic function ptrace_report_syscall does a little more
> > than syscall_trace on m68k.  The function ptrace_report_syscall
> > stops early if PT_TRACED is not set, it sets ptrace_message,
> > and returns the result of fatal_signal_pending.
> >
> > Setting ptrace_message to a passed in value of 0 is effectively not
> > setting ptrace_message, making that additional work a noop.
> >
> > Returning the result of fatal_signal_pending and letting the caller
> > ignore the result becomes a noop in this change.
> >
> > When a process is ptraced, the flag PT_PTRACED is always set in
> > current->ptrace.  Testing for PT_PTRACED in ptrace_report_syscall is
> > just an optimization to fail early if the process is not ptraced.
> > Later on in ptrace_notify, ptrace_stop will test current->ptrace under
> > tasklist_lock and skip performing any work if the task is not ptraced.
> >
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> As this depends on the removal of a parameter from
> ptrace_report_syscall() earlier in this series:
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

FWIW, I would suggest taking it a bit further: make syscall_trace_enter()
and syscall_trace_leave() in m68k ptrace.c unconditional, replace the
calls of syscall_trace() in entry.S with syscall_trace_enter() and
syscall_trace_leave() resp. and remove syscall_trace().

Geert, do you see any problems with that?  The only difference is that
current->ptrace_message would be set to 1 for ptrace stop on entry and
2 - on leave.  Currently m68k just has it 0 all along.

It is user-visible (the whole point is to let the tracer see which
stop it is - entry or exit one), so somebody using PTRACE_GETEVENTMSG
on syscall stops would start seeing 1 or 2 instead of "0 all along".
That's how it works on all other architectures (including m68k-nommu),
and I doubt that anything in userland will get broken.

Behaviour of PTRACE_GETEVENTMSG for other stops (fork, etc.) remains
as-is, of course.
