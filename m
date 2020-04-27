Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A233F1BAECD
	for <lists+linux-arch@lfdr.de>; Mon, 27 Apr 2020 22:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgD0UIY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Apr 2020 16:08:24 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:54735 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgD0UIY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Apr 2020 16:08:24 -0400
Received: from mail-qv1-f52.google.com ([209.85.219.52]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MCsDe-1jKKLV06Km-008oeH; Mon, 27 Apr 2020 22:08:21 +0200
Received: by mail-qv1-f52.google.com with SMTP id p13so9209914qvt.12;
        Mon, 27 Apr 2020 13:08:20 -0700 (PDT)
X-Gm-Message-State: AGi0Pua36kvvgbtJzCg9zrXGt3sP2/JLDHBpOXZlPNwvSG6fVSJMxOdv
        3EpV/hJt/yX3BsluJESD9R7ejphkTq7b45QLkKk=
X-Google-Smtp-Source: APiQypIH3ZdZMCO5MSptSlCYEs+1Zzb/RtMdDJ5ewsj/Ph+sCglw07RpnDXB6Ahi8xVWObaUJcuSj6MYy7NQ8XFD/ds=
X-Received: by 2002:a0c:eb11:: with SMTP id j17mr24098329qvp.197.1588018099649;
 Mon, 27 Apr 2020 13:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200426130100.306246-1-hagen@jauu.net> <20200426163430.22743-1-hagen@jauu.net>
 <20200427170826.mdklazcrn4xaeafm@wittgenstein> <CAG48ez0hskhN7OkxwHX-Bo5HGboJaVEk8udFukkTgiC=43ixcw@mail.gmail.com>
 <87zhawdc6w.fsf@x220.int.ebiederm.org> <20200427185929.GA1768@laniakea>
In-Reply-To: <20200427185929.GA1768@laniakea>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 27 Apr 2020 22:08:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2Ux1pDZEBjgRSPMJXvwUAvbPastX2ynVVC2iPTTDK_ow@mail.gmail.com>
Message-ID: <CAK8P3a2Ux1pDZEBjgRSPMJXvwUAvbPastX2ynVVC2iPTTDK_ow@mail.gmail.com>
Subject: Re: [RFC v2] ptrace, pidfd: add pidfd_ptrace syscall
To:     Hagen Paul Pfeifer <hagen@jauu.net>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:WFq6gMZfg2tmh2IlAgJs31v+iU7MXCbzJwBp5qiPN6ZPx+XM4Pe
 Mc7eFk6Vi1IrQsi2Vlb94MChBbSas3DUTZA2YtLgtVVC+5nljI9Dqsvhj6YVvoMwiQjEM4e
 cTCFPyE+48cWClepwpxRvhEsBag7E8ok1afd6Ak9hW3z2NMkImRjmLJe6Ovcqv7z06TNNSy
 C1lU3s8DnSHl4NUQLwNpg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vvdfv1gsEk8=:b7tFIBVDX2W16XSmy/OO1G
 AmF4og9RFkOiLiMhpbneFPkTFDWAXan40eBX4zmzyfxfdV+bQuDjSDdALuUiUZ39RE/UaSCb6
 d+1lnAJR4EyLKbj52+hVzFoa07vJKp3LqTvK3DSuPCCL+YJUMSsdkSNrnLWsr0no3VcCu5U6A
 agVO/wRt11au+QHG+OElnkuUVAAH0wX7LJWYs5ttjKeDelca/ClXdqsQd66TuE9ivzSDWcAUP
 sXW7ZrMwenP4nmXRMqTspt+O9zw794Ckkq92CVXTNKnhu88H/PyWlsILbD4BX8fFyEHJ+RauF
 Q0axTj6Slyu8vC5W9w3jOeT775Mm6ClDSBCRJeE6dmV55RvU61HfJetByDAdqa3fodZx6u806
 fFgIwpM522e5AZiJCQqpmnHUndezWfEhWuWsYhrhT49eEKEmNXZ7brvENFEAQUg6jpNyQqLyl
 HIeVWigFe9rgI+pGhHssi5evhEimfVy7ohnJlkgyL4eLfoKfgM1HwsPh4snYiYYCNS+0yt3cZ
 qqNsy+8PlVFFoFCfomU1pRosnmw5xDcwcIhO9jh4WgaWqetcpWkc3VraN4y0xzZwUjmj0pY7y
 YKOrSBLfoBVCgbbZCJbO4Dbpi0MQ9m4JxEmt0Ja52tjyScfr25QdgbJEFo9oegTElGljn6Z51
 AM7WMamTrMzrI29GsJD85QSE5aC/TYuBhpRyeSNJX8lfSugIINdOh+mLGpoSKtgA00cbs45vk
 oSkdqB4IOhlB1+uDlwrGiEVGWbrm5e8GGxwnTidOwKT8A81fDTD98QaIW5IcyNG2PK8hqFepw
 q3SZyy3hBVhxNHQOHXFikEz5cxX7XUWuEAKGFOdYYOmhJ61fAo=
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 27, 2020 at 8:59 PM Hagen Paul Pfeifer <hagen@jauu.net> wrote:
>
> * Eric W. Biederman | 2020-04-27 13:18:47 [-0500]:
>
> >I am conflicted about that but I have to agree.    Instead of
> >duplicating everything it would be good enough to duplicate the once
> >that cause the process to be attached to use.  Then there would be no
> >more pid races to worry about.
>
> >How does this differ using the tracing related infrastructure we have
> >for the kernel on a userspace process?  I suspect augmenting the tracing
> >infrastructure with the ability to set breakpoints and watchpoints (aka
> >stopping userspace threads and processes might be a more fertile
> >direction to go).
> >
> >But I agree either we want to just address the races in PTRACE_ATTACH
> >and PTRACE_SIEZE or we want to take a good hard look at things.
> >
> >There is a good case for minimal changes because one of the cases that
> >comes up is how much work will it take to change existing programs.  But
> >ultimately ptrace pretty much sucks so a very good set of test cases and
> >documentation for what we want to implement would be a very good idea.
>
> Hey Eric, Jann, Christian, Arnd,
>
> thank you for your valuable input! IMHO I think we have exactly two choices
> here:
>
> a) we go with my patchset that is 100% ptrace feature compatible - except the
>    pidfd thing - now and in the future. If ptrace is extended pidfd_ptrace is
>    automatically extended and vice versa. Both APIs are feature identical
>    without any headaches.
> b) leave ptrace completely behind us and design ptrace that we have always
>    dreamed of! eBPF filters, ftrace kernel architecture, k/uprobe goodness,
>    a speedy API to copy & modify large chunks of data, io_uring/epoll support
>    and of course: pidfd based (missed likely thousands of other dreams)
>
> I think a solution in between is not worth the effort! It will not be
> compatible in any way for the userspace and the benefit will be negligible.
> Ptrace is horrible API - everybody knows that but developers get comfy with
> it. You find examples everywhere, why should we make it harder for the user for
> no or little benefit (except that stable handle with pidfd and some cleanups)?
>
> Any thoughts on this?

The way I understood Jann was that instead of a new syscall that duplicates
everything in ptrace(), there would only need to be a new ptrace request
such as PTRACE_ATTACH_PIDFD that behaves like PTRACE_ATTACH
but takes a pidfd as the second argument, perhaps setting the return value
to the pid on success. Same for PTRACE_SEIZE.

In effect this is not much different from your a), just a variation on the
calling conventions. The main upside is that it avoids adding another
ugly interface, the flip side is that it makes the existing one slightly worse
by adding complexity.

       Arnd
