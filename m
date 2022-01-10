Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6E2489C24
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jan 2022 16:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbiAJP1K (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jan 2022 10:27:10 -0500
Received: from mail-vk1-f172.google.com ([209.85.221.172]:44003 "EHLO
        mail-vk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbiAJP1K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jan 2022 10:27:10 -0500
Received: by mail-vk1-f172.google.com with SMTP id w206so7427695vkd.10;
        Mon, 10 Jan 2022 07:27:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D+q4x/sYXAhv4ZjaVJYvHS+YTEcPkfdqO3yd5/tp6kM=;
        b=wjXv37IQESR1zC4gUW6PSj89PJ3FBR2uPsgMLfoau4l5ZRYrSEdoFxBWP+sHyYFLRA
         7MCXMUGDdx6cDdMyIZ8FOvlkrUbDvg/KqM8e5/9hnQCfleM1p8GdXHl381OOUOZGQzlf
         qx87ao5PBf58IHMplkZJX4eCjEMpMZkblcp1n9yag4Vf1yElbXSE2yIWcO0tTkusz9j4
         +kGAVmq34sL2WV88abx9vv1W6rrhAFLR9sCx/mkaczxtvlrsd98asc4zB2qomzrVv3G8
         JPTKSVURz6QLBu4bi7ckn6oDpFqmop6ZY8m8QetmEhJoHQGBN34+0nVfgppLnaNFJH8w
         ZONQ==
X-Gm-Message-State: AOAM533/XeJow9ivzDQNYz/ccSOz4ZC4sipP3RB4Dy8sAnxcSKFY4sbF
        7VY/nXLRpCqvvxyjBrFw1F6rQmwuR8zeIw==
X-Google-Smtp-Source: ABdhPJxUXALCe0JoHtOObweG9dtvBjR3YU0iioYCM4Zd2PWVY6tsEH4NdAAwqYt3GFiakIXvEZFBBA==
X-Received: by 2002:a05:6122:201e:: with SMTP id l30mr167036vkd.10.1641828429424;
        Mon, 10 Jan 2022 07:27:09 -0800 (PST)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id n15sm3452528vkf.35.2022.01.10.07.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 07:27:09 -0800 (PST)
Received: by mail-ua1-f42.google.com with SMTP id v12so24036687uar.7;
        Mon, 10 Jan 2022 07:27:08 -0800 (PST)
X-Received: by 2002:a67:e985:: with SMTP id b5mr123619vso.77.1641828428579;
 Mon, 10 Jan 2022 07:27:08 -0800 (PST)
MIME-Version: 1.0
References: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org> <20220103213312.9144-8-ebiederm@xmission.com>
In-Reply-To: <20220103213312.9144-8-ebiederm@xmission.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jan 2022 16:26:57 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWsNBjOJh0QEx9sppA9x3WoL8H2icqukNqECFhOPremjw@mail.gmail.com>
Message-ID: <CAMuHMdWsNBjOJh0QEx9sppA9x3WoL8H2icqukNqECFhOPremjw@mail.gmail.com>
Subject: Re: [PATCH 08/17] ptrace/m68k: Stop open coding ptrace_report_syscall
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 3, 2022 at 10:33 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> The generic function ptrace_report_syscall does a little more
> than syscall_trace on m68k.  The function ptrace_report_syscall
> stops early if PT_TRACED is not set, it sets ptrace_message,
> and returns the result of fatal_signal_pending.
>
> Setting ptrace_message to a passed in value of 0 is effectively not
> setting ptrace_message, making that additional work a noop.
>
> Returning the result of fatal_signal_pending and letting the caller
> ignore the result becomes a noop in this change.
>
> When a process is ptraced, the flag PT_PTRACED is always set in
> current->ptrace.  Testing for PT_PTRACED in ptrace_report_syscall is
> just an optimization to fail early if the process is not ptraced.
> Later on in ptrace_notify, ptrace_stop will test current->ptrace under
> tasklist_lock and skip performing any work if the task is not ptraced.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

As this depends on the removal of a parameter from
ptrace_report_syscall() earlier in this series:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
