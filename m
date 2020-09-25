Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2596E278A5D
	for <lists+linux-arch@lfdr.de>; Fri, 25 Sep 2020 16:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgIYOIw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Sep 2020 10:08:52 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:42823 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgIYOIw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 25 Sep 2020 10:08:52 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MF39S-1kF9UQ1WmW-00FT5c; Fri, 25 Sep 2020 16:08:50 +0200
Received: by mail-qk1-f171.google.com with SMTP id o5so2815289qke.12;
        Fri, 25 Sep 2020 07:08:50 -0700 (PDT)
X-Gm-Message-State: AOAM5334Fo4YdJ6Nt9saVK04WZDwEdrYKtgC5zUHBPcNzjECZf5LYT/4
        76jTHpoJ4OnOre74IousOAui3inMTUizBzE1uKY=
X-Google-Smtp-Source: ABdhPJyQJNrHwxmkVsXimz0oF76gP4lvp54BaArHPydGBupMZdO/Llk2RLPlSSrUMgxUBOdKl5ChKrJidt7yrr6I+Kw=
X-Received: by 2002:a05:620a:15a7:: with SMTP id f7mr135330qkk.3.1601042929071;
 Fri, 25 Sep 2020 07:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200918124624.1469673-1-arnd@arndb.de> <20200919081906.GV1551@shell.armlinux.org.uk>
In-Reply-To: <20200919081906.GV1551@shell.armlinux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 25 Sep 2020 16:08:31 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1k9Ms8EBD-KxsGWY8LxzWqLh-E6ZaemcTMeYoRKBaQUg@mail.gmail.com>
Message-ID: <CAK8P3a1k9Ms8EBD-KxsGWY8LxzWqLh-E6ZaemcTMeYoRKBaQUg@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] ARM: remove set_fs callers and implementation
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:VREt9jpSAxN+6ZCKg1q3IbF75qPcjf7Y5WulEmvvT0hIK5uYjdW
 Q399hLi/C8k1Qbou/nCIFLcwM9U1H8lUWC+bM+CGKdQjFPmx1pU/QB6+dT3MK3fNJ7pbF/c
 ZJhCTMr6S2BWN5WP0zCMRbmq2iD/6HGgJPuLlVR8gOR5GlqSr68hU/1RqFOD1zypBS2EICN
 qOCOFd9SH4rbyy8vv23ag==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:m8mNu48NKGs=:yCgL2qXu2cKejMmSweAnI6
 WogDfsQGw1hh/YdPHBtk61gwsuAE+CtU6xLVb2uCYR8DSdj0/21RI0AcjfN3mHNSFDs6pgpdP
 8mrv5p4CrexoTDrXk6JAWFt11NV4BeUp41fCQiTWsoiomm8RhfSSgqQk2oDsWBep3b/DHFZPe
 yzFJp+GBx8DTPhOxkheIRBSgJOr1771MnyecVSoyYdVX1u0xTXZFLdXaHSjrTYnZApfO/e+Q3
 8JebLg/VvyBevBdKDbGdzSPzZHLvq7rUu9otDXwMZtniKt8DAG0WYlP+HLpLjGidPERPLaRl6
 Y+jJZICrMPqWuoJVqZxfuXg6uyBd3wdbNRAYtbncbF3GGqXWGe+JoBrN4yWhAWKLbVEpMMMkU
 ZhwJAXMqNS5Hl3it+2u39hzA+1gBsVL5rFmykzQFT22OmT6ziJjL055Cf0JOYIV9RZMyqbUoZ
 6DgmZMPdXcj6Z09JhwTS6urPITC/fbQxdrn/4hXutRTPBOiEXXfcWJh50paqet74xVB15eznK
 iQBL3XoH6m1hKD5VQzuG8SK+TEnB/jERMGHXhBQdq36Vbtr4pEHGBLC0L+3JhZrJuVhrRLxrg
 7IJIacvGNmu25yLvec5gy5J07plBgimsko/Hrm6ciLSU8E3whO5r/wH2SFoN6GnzNYFkGCF1F
 wAvMnHxcaSnN7WdpYvmc7XIeSGj6/JPzn61fuXStHjRtuEIOdu97d2J2r4gldEihkSIsUIaJ0
 fmJCBXg63f+NxE+rmLk0ju1rREncsXy64ga58zdZDyIjQAXeUUZA706aqqNJRA3v7xEhbgRzV
 6OfVtOTQJ89OqFcuYHbAZlebSwpKhJ2r2v65Qo9yBQOIZ0tRmyJweSrJ7MFm0v7JQTNEPd7lx
 C+L5NxfE8korTDCLFAPl8cVFsxw7avH86w9yQh41SICfV5gaARgDWo3bN9pkkj/esVw34X9qS
 TodH/AKDza6DVFSywUyjMynwNdRs0mKUeMXaxDdMzaN/+ueQdipI5
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 19, 2020 at 10:19 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Fri, Sep 18, 2020 at 02:46:15PM +0200, Arnd Bergmann wrote:
> > Hi Christoph, Russell,
> >
> > Here is an updated series for removing set_fs() from arch/arm,
> > based on the previous feedback.
> >
> > I have tested the oabi-compat changes using the LTP tests for the three
> > modified syscalls using an Armv7 kernel and a Debian 5 OABI user space,
> > and I have lightly tested the get_kernel_nofault infrastructure by
> > loading the test_lockup.ko module after setting CONFIG_DEBUG_SPINLOCK.
>
> I'm not too keen on always saving the syscall number, but for the gain
> of getting rid of set_fs() I think it's worth it. However...
>
> I think there are some things to check - what value do you end up
> with as the first number in /proc/self/syscall when you do:
>
> strace cat /proc/self/syscall
>
> ?

> It should be 3, not 0x900003. I suspect you're getting the latter
> with these changes.  IIRC, task_thread_info(task)->syscall needs to
> be the value _without_ the offset, otherwise tracing will break.

It seems broken in different ways, depending on the combination
of kernel and userland:

1. EABI armv5-versatile kernel, EABI Debian 5:
$ cat /proc/self/syscall
0 0x1500000000003 0x1500000000400 0x1500000000400 0x60000013c7800480
0xc0008668c0112f8c 0xc0112d14c68e1f68 0xbeab06f8 0xb6e80d4c
$ strace -f cat /proc/self/syscall
execve("/bin/cat", ["cat", "/proc/self/syscall"], [/* 16 vars */]) =
-1 EINTR (Interrupted system call)
dup(2)                                  = -1 EINTR (Interrupted system call)
write(2, "strace: exec: Interrupted system "..., 38) = -1 EINTR
(Interrupted system call)
exit_group(1)                           = ?

2. EABI kernel, OABI Debian 5:
$ cat /proc/self/syscall
3 0x1500000000003 0x13ccc00000400 0x1500000000400 0x60000013c7800480
0xc0008de0c0112f8c 0xc0112d14c7313f68 0xbeed27d0 0xb6eab324
$ strace cat /proc/self/syscall
execve("/bin/cat", ["cat", "/proc/self/syscall"], [/* 16 vars */]) = -1090648236
--- SIGILL (Illegal instruction) @ 0 (0) ---
+++ killed by SIGILL +++

3. OABI kernel, OABI Debian 5:
 cat /proc/self/syscall
9437187 0x1500000000003 0x13ccc00000400 0x1500000000400 0x100060000013
0x15000c72cff6c 0xc72cfe9000000000 0xbece27d0 0xb6f2f324
$ strace cat /proc/self/syscall
execve("/bin/cat", ["cat", "/proc/self/syscall"], [/* 16 vars */]) = -1095141548
--- SIGILL (Illegal instruction) @ 0 (0) ---
+++ killed by SIGILL +++

I suspect the OABI strace in Debian is broken since it crashes on
both kernels. I'll look into fixing the output without strace first then.

       Arnd
