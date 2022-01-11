Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABFC48BAE3
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jan 2022 23:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345982AbiAKWnI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jan 2022 17:43:08 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:44787 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245679AbiAKWnI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Jan 2022 17:43:08 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id BDFBC2B001EB;
        Tue, 11 Jan 2022 17:43:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 11 Jan 2022 17:43:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ore8dv
        WM0JKihk7KMxojL1R4RgpvIFLf1KOnBxVgtZE=; b=QM3EFuZU3HYDksJk3yyYYd
        Uc/46nL4E+JEU+jx3mRPEK+Hfn/dfBYNite3IRsAsv3/EES5EUO8LKdpddZqZxG2
        lxsk07NDd0iqIp+kj+qOxXuFuhk0JLxwchP9ADpZk5yLVwsrBRBFslzdFQm1Ma2Q
        dv3q2sh43UfaC1q3wlzHNqVZl9TCFuDQGlXTPgGxrBKdS/t//Cz/RqVOKxY6W5Fl
        smHrEo6DRlE+Ja0RJjxLPf7xBo29NT0QRzO7ZJzKAgcBW9k4IU1gybxswtB5ECfz
        vdjiT6Uuwi5S8STvls7P1waJeKSXVUbe7uOOK6dxOfNWwsho5JJFd6WEsyUaaYmQ
        ==
X-ME-Sender: <xms:-QfeYV_yzx34TALBD21GjyMiQQZ_IGsMFgqtXFICXQONCTXOZfriTw>
    <xme:-QfeYZuo1Z4OsIDpATbw619ebj3HtYhvsZWsXTVXX6fIhq6TWInCsASS2We_i_9Pk
    Dvo7y962u1OUTm0Sl0>
X-ME-Received: <xmr:-QfeYTBkuGYyaMCudP-oZEjjCDffbZtMMIvyOzEnz-wVKTniQia7PXRj_pc58AoYsyV_DV_TGKs1if1l2XsmDgh9GUtSAO5eIpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudehgedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfv
    hhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrth
    htvghrnhepkeevvedtkeeftdefhfdvgfelleefhfdtfeeiteejjeevgffhudefjeekhefg
    uedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmheikehk
    rdhorhhg
X-ME-Proxy: <xmx:-QfeYZc0qae5bTmMSpBv34Ezm959JNgkFGJNxcHcvGUL_Hxl6M1mzA>
    <xmx:-QfeYaPSwhHauZNh8WQtCxE_xm0IXuOzpRiXokDeJc6LLpuvszoy1Q>
    <xmx:-QfeYbm9XKKo9E-pfR4VoNj6Ho0uO5TGmc9jZViHrAhYaoyLQR7SkA>
    <xmx:-gfeYbi4CCNZQIHMd-RWiCKJm0eGhZi2rCMzunjD0wUGX4GyDK5eIalxqro>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jan 2022 17:43:03 -0500 (EST)
Date:   Wed, 12 Jan 2022 09:42:52 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Michael Schmitz <schmitzmic@gmail.com>
cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH 08/17] ptrace/m68k: Stop open coding
 ptrace_report_syscall
In-Reply-To: <acf7b627-2dec-c76c-2aa0-6b4c6addd793@gmail.com>
Message-ID: <d660267-ce4f-e598-9b40-5cdbb4566c7@linux-m68k.org>
References: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org> <20220103213312.9144-8-ebiederm@xmission.com> <CAMuHMdWsNBjOJh0QEx9sppA9x3WoL8H2icqukNqECFhOPremjw@mail.gmail.com> <YdxcszwEslyQJSuF@zeniv-ca.linux.org.uk> <CAMuHMdX9nhUQe_jeQCUtXeQgcQ5MBiHpPiRexh86EssoHNtJ3Q@mail.gmail.com>
 <acf7b627-2dec-c76c-2aa0-6b4c6addd793@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 11 Jan 2022, Michael Schmitz wrote:

> Am 11.01.2022 um 06:54 schrieb Geert Uytterhoeven:
> > Hi Al,
> >
> > CC Michael/m68k,
> >
> > On Mon, Jan 10, 2022 at 5:20 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >> On Mon, Jan 10, 2022 at 04:26:57PM +0100, Geert Uytterhoeven wrote:
> >>> On Mon, Jan 3, 2022 at 10:33 PM Eric W. Biederman <ebiederm@xmission.com>
> >>> wrote:
> >>>> The generic function ptrace_report_syscall does a little more
> >>>> than syscall_trace on m68k.  The function ptrace_report_syscall
> >>>> stops early if PT_TRACED is not set, it sets ptrace_message,
> >>>> and returns the result of fatal_signal_pending.
> >>>>
> >>>> Setting ptrace_message to a passed in value of 0 is effectively not
> >>>> setting ptrace_message, making that additional work a noop.
> >>>>
> >>>> Returning the result of fatal_signal_pending and letting the caller
> >>>> ignore the result becomes a noop in this change.
> >>>>
> >>>> When a process is ptraced, the flag PT_PTRACED is always set in
> >>>> current->ptrace.  Testing for PT_PTRACED in ptrace_report_syscall is
> >>>> just an optimization to fail early if the process is not ptraced.
> >>>> Later on in ptrace_notify, ptrace_stop will test current->ptrace under
> >>>> tasklist_lock and skip performing any work if the task is not ptraced.
> >>>>
> >>>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> >>>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> >>>
> >>> As this depends on the removal of a parameter from
> >>> ptrace_report_syscall() earlier in this series:
> >>> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >>
> >> FWIW, I would suggest taking it a bit further: make syscall_trace_enter()
> >> and syscall_trace_leave() in m68k ptrace.c unconditional, replace the
> >> calls of syscall_trace() in entry.S with syscall_trace_enter() and
> >> syscall_trace_leave() resp. and remove syscall_trace().
> >>
> >> Geert, do you see any problems with that?  The only difference is that
> >> current->ptrace_message would be set to 1 for ptrace stop on entry and
> >> 2 - on leave.  Currently m68k just has it 0 all along.
> >>
> >> It is user-visible (the whole point is to let the tracer see which
> >> stop it is - entry or exit one), so somebody using PTRACE_GETEVENTMSG
> >> on syscall stops would start seeing 1 or 2 instead of "0 all along".
> >> That's how it works on all other architectures (including m68k-nommu),
> >> and I doubt that anything in userland will get broken.
> >>
> >> Behaviour of PTRACE_GETEVENTMSG for other stops (fork, etc.) remains
> >> as-is, of course.
> >
> > In fact Michael did so in "[PATCH v7 1/2] m68k/kernel - wire up
> > syscall_trace_enter/leave for m68k"[1], but that's still stuck...
> >
> > [1]
> > https://lore.kernel.org/r/1624924520-17567-2-git-send-email-schmitzmic@gmail.com/
> 
> That patch (for reasons I never found out) did interact badly with 
> Christoph Hellwig's 'remove set_fs' patches (and Al's signal fixes which 
> Christoph's patches are based upon). Caused format errors under memory 
> stress tests quite reliably, on my 030 hardware.
> 

Those patches have since been merged, BTW.

> Probably needs a fresh look - the signal return path got changed by Al's 
> patches IIRC, and I might have relied on offsets to data on the stack 
> that are no longer correct with these patches. Or there's a race between 
> the syscall trap and signal handling when returning from interrupt 
> context ...
> 
> Still school hols over here so I won't have much peace and quiet until 
> February.
> 

So the patch works okay with Aranym 68040 but not Motorola 68030? Since 
there is at least one known issue affecting both Motorola 68030 and Hatari 
68030, perhaps this patch is not the problem. In anycase, Al's suggestion 
to split the patch into two may help in that testing two smaller patches 
might narrow down the root cause.
