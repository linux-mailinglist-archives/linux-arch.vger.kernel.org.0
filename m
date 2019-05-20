Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16FA823937
	for <lists+linux-arch@lfdr.de>; Mon, 20 May 2019 16:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403786AbfETOB1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 May 2019 10:01:27 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46215 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391227AbfETOB1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 May 2019 10:01:27 -0400
Received: by mail-lf1-f65.google.com with SMTP id l26so10369838lfh.13;
        Mon, 20 May 2019 07:01:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k5M5HG3kl0pUgSauCfNvkeVzL85t6u8JUUHdn9mhx04=;
        b=gYRUQQ4I3isRR7yIrkfU1fErhS5LAmJO+q9UZ5/bRVsNPQluoj03UfNUL0I7XHQmPj
         UZ2hsjhiaoVzaX4F48wqCM37pZKXTCzzV3HcPIwpo8gXTZjDNqlW/wuS0GgG0LegM+gI
         cNMjXLFp96QzPp8AfhXpbUO7HQYwk8Z75SjoQ+JlGPOv46Ef1MiIn18V3x9efkcUJD9J
         PlxDJQZTjBlAieJyET4XPM8TZMzNQg4ZBskiE8w+m40Vm+dNE8P+s6odhuKlquJNLaoK
         ShIT0NSW/TwHCve/P6PCqI3YFqhqzzLZZAcghjQOTS/X+zmesDQtj3e3qaEIP8sPvIl4
         /rmw==
X-Gm-Message-State: APjAAAUUVMB2FLp0pKtTLw42V4U6rGCWPsCzdPM172VxiLue3r/jhsle
        s3lzmQVUJRMsjcNOzJSJ3ajML15pXchIyw3GjHo=
X-Google-Smtp-Source: APXvYqzBXH0Bn12gU+O/WKysSzgvfoDb4ZQdIiC8js/Lv4/NzbFVAIlWC//CHbjkYuLxxyAwqyeGdyzFagcgQl6QGI8=
X-Received: by 2002:a19:a887:: with SMTP id r129mr1920861lfe.16.1558360883054;
 Mon, 20 May 2019 07:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190520134605.29116-1-christian@brauner.io>
In-Reply-To: <20190520134605.29116-1-christian@brauner.io>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 May 2019 16:00:44 +0200
Message-ID: <CAMuHMdVfy-fWVGzd8orLHbC=pOmUH-ocvhjj2DCZdEQRxctYQA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pid: add pidfd_open()
To:     Christian Brauner <christian@brauner.io>
Cc:     Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-mips@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        elena.reshetova@intel.com, Linux-Arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Android Kernel Team <kernel-team@android.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, surenb@google.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, cyphar@cyphar.com,
        Andy Lutomirski <luto@amacapital.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 20, 2019 at 3:46 PM Christian Brauner <christian@brauner.io> wrote:
> This adds the pidfd_open() syscall. It allows a caller to retrieve pollable
> pidfds for a process which did not get created via CLONE_PIDFD, i.e. for a
> process that is created via traditional fork()/clone() calls that is only
> referenced by a PID:
>
> int pidfd = pidfd_open(1234, 0);
> ret = pidfd_send_signal(pidfd, SIGSTOP, NULL, 0);
>
> With the introduction of pidfds through CLONE_PIDFD it is possible to
> created pidfds at process creation time.
> However, a lot of processes get created with traditional PID-based calls
> such as fork() or clone() (without CLONE_PIDFD). For these processes a
> caller can currently not create a pollable pidfd. This is a problem for
> Android's low memory killer (LMK) and service managers such as systemd.
> Both are examples of tools that want to make use of pidfds to get reliable
> notification of process exit for non-parents (pidfd polling) and race-free
> signal sending (pidfd_send_signal()). They intend to switch to this API for
> process supervision/management as soon as possible. Having no way to get
> pollable pidfds from PID-only processes is one of the biggest blockers for
> them in adopting this api. With pidfd_open() making it possible to retrieve
> pidfds for PID-based processes we enable them to adopt this api.
>
> In line with Arnd's recent changes to consolidate syscall numbers across
> architectures, I have added the pidfd_open() syscall to all architectures
> at the same time.
>
> Signed-off-by: Christian Brauner <christian@brauner.io>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>

>  arch/m68k/kernel/syscalls/syscall.tbl       |  1 +

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
