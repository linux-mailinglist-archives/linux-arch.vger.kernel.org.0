Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2C611F45F
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2019 14:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfEOM32 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 May 2019 08:29:28 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37222 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfEOM31 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 May 2019 08:29:27 -0400
Received: by mail-vs1-f68.google.com with SMTP id o5so1566244vsq.4;
        Wed, 15 May 2019 05:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cgdsZEIH2W5eTMf3uaLx4q/hdk2jHzw6fNgJE2/Ss+k=;
        b=Kl1WAuyv9mYDtkcZTKYWwrcEjYd5h2UITDxQ0i8bc3etfxEnmdO91neWn/D44ScI5o
         2dPdO26CQ2qpDl0OYOdMME31KZPnk7J8rqt+3+UpgGHGJf3t+chzENYfs7KbrbcznjdH
         vIvZbymPN0VSnn0Lvj2a3Rkl5szI2YD322jgtVWxlH4lV7ufSmV17xZStx7q5sWryg49
         pBT++UmGoudT2A4o0d6xVTbTeqSpws9htAsHYUAgQg0bJaeFwQQVrHN7HYMFZ8iOvBTX
         ZHz5cXs/jzxNfwyxJFN2ZaYbWBoR9+6Ak/XcQ7PIif51U6J0arvK8IuGEdf44ZxsMA44
         4y9A==
X-Gm-Message-State: APjAAAUaz+8HolnY8TfWhHskyIP01Y9I2M/xPNoy+LiPFTZvtYNQJwpj
        XRwh9qVedYi6mqWJlHL+YhcutX43utUGBoWcLrM=
X-Google-Smtp-Source: APXvYqzDAJzfhabDwTYAYFXSOnY37iC0IXZoLvq4QwE8CVpdlrcgi5gg8xMkv97L4kuyL6Wc28Zhp7a2DMatRjdZeGY=
X-Received: by 2002:a67:8e03:: with SMTP id q3mr20471095vsd.152.1557923365973;
 Wed, 15 May 2019 05:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190515100400.3450-1-christian@brauner.io>
In-Reply-To: <20190515100400.3450-1-christian@brauner.io>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 May 2019 14:29:14 +0200
Message-ID: <CAMuHMdUKJOP2H4cVy0Na5hjn2-HUbfvE_zbctS4L9d-h9Oru4Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] pid: add pidfd_open()
To:     Christian Brauner <christian@brauner.io>
Cc:     Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        elena.reshetova@intel.com, Linux-Arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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

On Wed, May 15, 2019 at 12:04 PM Christian Brauner <christian@brauner.io> wrote:
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
> caller can currently not create a pollable pidfd. This is a huge problem
> for Android's low memory killer (LMK) and service managers such as systemd.
> Both are examples of tools that want to make use of pidfds to get reliable
> notification of process exit for non-parents (pidfd polling) and race-free
> signal sending (pidfd_send_signal()). They intend to switch to this API for
> process supervision/management as soon as possible. Having no way to get
> pollable pidfds from PID-only processes is one of the biggest blockers for
> them in adopting this api. With pidfd_open() making it possible to retrieve
> pidfd for PID-based processes we enable them to adopt this api.
>
> In line with Arnd's recent changes to consolidate syscall numbers across
> architectures, I have added the pidfd_open() syscall to all architectures
> at the same time.
>
> Signed-off-by: Christian Brauner <christian@brauner.io>

>  arch/m68k/kernel/syscalls/syscall.tbl       |  1 +

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
