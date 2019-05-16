Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6F2220A52
	for <lists+linux-arch@lfdr.de>; Thu, 16 May 2019 16:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfEPO4X (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 May 2019 10:56:23 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:43977 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbfEPO4W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 May 2019 10:56:22 -0400
Received: by mail-vk1-f193.google.com with SMTP id h72so1096777vkh.10;
        Thu, 16 May 2019 07:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=05GCtpont9YEywFzf84z1q9MwrqOSiu52jwQOd14/zs=;
        b=NqRraoEHORwbbMw0jdlkm1gqvvZ7Ona5zso2iADzUe435KgwdUeQrFVeZK1kG8w3y2
         tDOGY1PhQsbuWp4zX4vuepzAtxDAz0xqKqexS2aNqtCf2ZemV+LdDZ1L3vOsk2oVrOv3
         MxO25Edon6SuprOVYFKacjdA1qnVMLJNHlkwQ7goZwTRdBbKKWaNEOG0mJWa0jqyWyXt
         NqUhxBQRV/tfAsvKIHdEoSp4QhfDxMdJDI42EpnMOYsym5B+UsK4gjR4v4C7ch7wGZ0w
         XN9nhIpclGns00wQgPac8PDAASbkljVJvIS2qc3V5naQoIy4Wf4kyR6xuMSJfwWtcuhX
         UjmQ==
X-Gm-Message-State: APjAAAXyUvKL8IARnIGhuVSdX5oNXGKE4NR6SxAcypv2R5+XyV/CC6jD
        mIcZY/4zymv28Z180BYrS/sXP9gzz36sJG+9a2I=
X-Google-Smtp-Source: APXvYqwJkEyDq3zOtk8OfRAodMj5uaJzILWIRnCKOk3dtxYk7GsdMRXLOna8zNuSkRyU4hilGsRAQgTc6aWaoZtw994=
X-Received: by 2002:a1f:c2c1:: with SMTP id s184mr23362067vkf.65.1558018580810;
 Thu, 16 May 2019 07:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190516135944.7205-1-christian@brauner.io>
In-Reply-To: <20190516135944.7205-1-christian@brauner.io>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 16 May 2019 16:56:08 +0200
Message-ID: <CAMuHMdVbUJ0+28Lc2wHPah8UUk8Ou9m81KzLvhrcMsJzz2bX2A@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] pid: add pidfd_open()
To:     Christian Brauner <christian@brauner.io>,
        David Howells <dhowells@redhat.com>
Cc:     Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        elena.reshetova@intel.com, Linux-Arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
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

Hi Christian, David,

On Thu, May 16, 2019 at 4:00 PM Christian Brauner <christian@brauner.io> wrote:
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

> +428    common  pidfd_open                      sys_pidfd_open

This number conflicts with "[PATCH 4/4] uapi: Wire up the mount API
syscalls on non-x86 arches", which is requested to be included before
rc1.

Note that none of this is part of linux-next.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
