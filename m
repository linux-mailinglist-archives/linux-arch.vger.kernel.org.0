Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24734489EAE
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jan 2022 18:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238612AbiAJRzL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jan 2022 12:55:11 -0500
Received: from mail-vk1-f181.google.com ([209.85.221.181]:34779 "EHLO
        mail-vk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238610AbiAJRzK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jan 2022 12:55:10 -0500
Received: by mail-vk1-f181.google.com with SMTP id 191so3979566vkc.1;
        Mon, 10 Jan 2022 09:55:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dXFTaslrvvoNS6lV+4lLY/0Kq9/XDOlT+IxlTp/BRWs=;
        b=cy6zYHXpW0QEiop3S37fQ8jONN1ZzM5elCvdgJ7Yj8pGAP+sp1PTBHiKu9wlp3wHZe
         klSN997roouqxP3GqDFl9yK0Zk/ia+gwv40BibSeyfkvXrau5AiWmVtcPpRxWhPNX/fT
         fIcIuI/L70zlIZ2uoEVA5+AwkUn8qrJ6Rv0Q1IWIJ48EPPICIdcLV+7UJvjHcnhAMQoI
         IALwo7lBoxsyHawULuAppnH6mI3zH5fhwhk8EfIGPbwxD+xD4Hdt6YUfm4X9McA6RwvM
         K9lI38b0TiRJSXOVd4s92guCa7Gk0lFDS6SI6gOK3cBoUdaLlDSfhBJxkKk/kx6KvTjN
         mQmQ==
X-Gm-Message-State: AOAM531GZ9iOt1696dLW7DPCsITwPjnHD8NFg3+BsoMPUi5K10alsZTZ
        xFbkJGtLMWedLw5HbP6PE6Q4oMuH+9bC0w==
X-Google-Smtp-Source: ABdhPJxSmYrC+eY1f4DVj4RNNZZmnCsP6hU6wXmRMjlRAR3PTOwg0JJ4V4oOoPDS4ixEUELghcHCPw==
X-Received: by 2002:a1f:56c6:: with SMTP id k189mr504516vkb.36.1641837309741;
        Mon, 10 Jan 2022 09:55:09 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id x66sm4094375vke.21.2022.01.10.09.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 09:55:09 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id v12so24898420uar.7;
        Mon, 10 Jan 2022 09:55:08 -0800 (PST)
X-Received: by 2002:a67:e985:: with SMTP id b5mr430323vso.77.1641837308695;
 Mon, 10 Jan 2022 09:55:08 -0800 (PST)
MIME-Version: 1.0
References: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
 <20220103213312.9144-8-ebiederm@xmission.com> <CAMuHMdWsNBjOJh0QEx9sppA9x3WoL8H2icqukNqECFhOPremjw@mail.gmail.com>
 <YdxcszwEslyQJSuF@zeniv-ca.linux.org.uk>
In-Reply-To: <YdxcszwEslyQJSuF@zeniv-ca.linux.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jan 2022 18:54:57 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX9nhUQe_jeQCUtXeQgcQ5MBiHpPiRexh86EssoHNtJ3Q@mail.gmail.com>
Message-ID: <CAMuHMdX9nhUQe_jeQCUtXeQgcQ5MBiHpPiRexh86EssoHNtJ3Q@mail.gmail.com>
Subject: Re: [PATCH 08/17] ptrace/m68k: Stop open coding ptrace_report_syscall
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Al,

CC Michael/m68k,

On Mon, Jan 10, 2022 at 5:20 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Mon, Jan 10, 2022 at 04:26:57PM +0100, Geert Uytterhoeven wrote:
> > On Mon, Jan 3, 2022 at 10:33 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> > > The generic function ptrace_report_syscall does a little more
> > > than syscall_trace on m68k.  The function ptrace_report_syscall
> > > stops early if PT_TRACED is not set, it sets ptrace_message,
> > > and returns the result of fatal_signal_pending.
> > >
> > > Setting ptrace_message to a passed in value of 0 is effectively not
> > > setting ptrace_message, making that additional work a noop.
> > >
> > > Returning the result of fatal_signal_pending and letting the caller
> > > ignore the result becomes a noop in this change.
> > >
> > > When a process is ptraced, the flag PT_PTRACED is always set in
> > > current->ptrace.  Testing for PT_PTRACED in ptrace_report_syscall is
> > > just an optimization to fail early if the process is not ptraced.
> > > Later on in ptrace_notify, ptrace_stop will test current->ptrace under
> > > tasklist_lock and skip performing any work if the task is not ptraced.
> > >
> > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> >
> > As this depends on the removal of a parameter from
> > ptrace_report_syscall() earlier in this series:
> > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> FWIW, I would suggest taking it a bit further: make syscall_trace_enter()
> and syscall_trace_leave() in m68k ptrace.c unconditional, replace the
> calls of syscall_trace() in entry.S with syscall_trace_enter() and
> syscall_trace_leave() resp. and remove syscall_trace().
>
> Geert, do you see any problems with that?  The only difference is that
> current->ptrace_message would be set to 1 for ptrace stop on entry and
> 2 - on leave.  Currently m68k just has it 0 all along.
>
> It is user-visible (the whole point is to let the tracer see which
> stop it is - entry or exit one), so somebody using PTRACE_GETEVENTMSG
> on syscall stops would start seeing 1 or 2 instead of "0 all along".
> That's how it works on all other architectures (including m68k-nommu),
> and I doubt that anything in userland will get broken.
>
> Behaviour of PTRACE_GETEVENTMSG for other stops (fork, etc.) remains
> as-is, of course.

In fact Michael did so in "[PATCH v7 1/2] m68k/kernel - wire up
syscall_trace_enter/leave for m68k"[1], but that's still stuck...

[1] https://lore.kernel.org/r/1624924520-17567-2-git-send-email-schmitzmic@gmail.com/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
