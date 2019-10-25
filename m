Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF1EAE55FF
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2019 23:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbfJYVfQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Oct 2019 17:35:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36394 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfJYVfP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 25 Oct 2019 17:35:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id c22so3440718wmd.1
        for <linux-arch@vger.kernel.org>; Fri, 25 Oct 2019 14:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4YxvioF+jTH30R9spDyiQENyiLpGipzh+vlA/S0UPZE=;
        b=PNp0gk4k8+U8QcqN/jFWOp9n9EWQ0bhA2fk3u7VefZpTvE3mU8p16Uy8olqK6RBkPs
         RF98rndY88zEugCxHutN4hpmb40h5aNqF4vQdKjvJxTEVKmw+QFKrdcg5DYNH5o/1jwV
         CdnJwb3mjoqbFCOHiCsCbjVWkHzjfkyieFFgl2/d163jYIrAAuRrSZT2OEFirzw4gYFM
         ekt31xdHi5RN6yZrPQq/ca31zsQVpli6hIuNQqYpCsGqmMhlKvC7kYwnLFmU/8NMh5vZ
         G+W0h8OrVaDNBCaACLo5GQwkZgfngxofNDmX/YWWlwHkcGhLBf9+1causqGOp+mMoQEc
         JMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4YxvioF+jTH30R9spDyiQENyiLpGipzh+vlA/S0UPZE=;
        b=ts0EDb81GoqvToBjR6vJwgPpOZKY+wsAzzv7TAVWhKyDvlQW0cbQc3YoQ6g8JlyeeB
         x8d3KTr1EG8nkFaXsPdMofgGv0v/FowmBdV1ngfilPzVeBm6xjBvv7+fri3gausd2ebd
         f/eVMctoVWOt77qVKACy30uXE7YzqQfX+KH4whY4TDEBdQHbWonVjOWPQ8/95iRbefhk
         uMFkPZoNrJ50GxKbuByu+1O+yEyMpzgHHDZoqRga9zKRjW7p3KtH5yy/kW+ZI0B4BIgn
         LarDRRIoVQGjcFrU/+r3cHpvUP0ef3DZyf5ZWcuLJFsehdbCKIrdcF4bb5BIuYO3MdF5
         3D8Q==
X-Gm-Message-State: APjAAAVgtrgUNd8gLZlYutcUylmUtQCxwfUub7HVO5QYqJU4UC/Eytu3
        kdB0unDhq4zxh5ANSMBDP3+51D9W46EO6z2NqvAQojSB
X-Google-Smtp-Source: APXvYqyCyJlAaS0ydeXF3PYWP60vJVbyAH1enSRbGatWq/qSOwcd4TzT0eB6mTwRJQ6fEB9rH5DzNiaSL2D9czWQGCc=
X-Received: by 2002:a1c:8086:: with SMTP id b128mr5188545wmd.104.1572039311325;
 Fri, 25 Oct 2019 14:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571798507.git.thehajime@gmail.com>
In-Reply-To: <cover.1571798507.git.thehajime@gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Fri, 25 Oct 2019 23:34:59 +0200
Message-ID: <CAFLxGvyshYxocTNrzWV0mLQ-_qZzMG7u64=ySMbjrsu8j4cwTQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/47] Unifying LKL into UML
To:     Hajime Tazaki <thehajime@gmail.com>
Cc:     linux-um@lists.infradead.org,
        Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 23, 2019 at 6:39 AM Hajime Tazaki <thehajime@gmail.com> wrote:
>
> This RFC patchset is to ask opinions from UML people, whether LKL codes is
> good to integrate into UML code base.  We wish to have any kind of feedback
> from your kind reviews.  There are numbers of commits which should be asked
> for reviews to other mailing lists; we will do it later once we got
> discussed in this mailing list.

Thanks a lot for doing this, this effort is much appreciated! :-)

> # sorry for the long list of patches: we can make it smaller by only
>   including basic set of LKL (e.g., removing foreign OS support, etc) if
>   you wish.

Let use see how the review goes. First I'll give it a high level review to make
sure we all talk about the same things.

Please CC linux-arch@vger.kernel.org for the next patch round.
Integrating LKL (into arch/um/) is something which needs more audience and
feedback from Arnd Bergmann, our global arch maintainer.


>
>
> LKL (Linux Kernel Library) is aiming to allow reusing the Linux kernel code
> as extensively as possible with minimal effort and reduced maintenance
> overhead.
>
> Examples of how LKL can be used are: creating userspace applications
> (running on Linux and other operating systems) that can read or write Linux
> filesystems or can use the Linux networking stack, creating kernel drivers
> for other operating systems that can read Linux filesystems, bootloaders
> support for reading/writing Linux filesystems, etc.
>
> With LKL, the kernel code is compiled into an object file that can be
> directly linked by applications. The API offered by LKL is based on the
> Linux system call interface.
>
> LKL is originally implemented as an architecture port in arch/lkl, but this
> series of commits tries to integrate this into arch/um as one of the mode
> of UML.  This was discussed during RFC email of LKL (*1).
>
> The latest LKL version can be found at https://github.com/lkl/linux
>
> Milestone
> =========
> This patches is just a first step toward upstreaming *library mode* of
> Linux kernel, but we think we need to have several steps toward our goal,
> describing in the below.
>
> 1. Put LKL code under arch/um (arch/um/lkl), and build it in a
> separate way from UML.

Makes sense.

> 2. Share common parts of implementation between UML and LKL.

Since both UML and LKL are usermode ports there is a lot of potential.
From my side it is also no big deal if there is some duplication which can be
resolved in later releases. Unifiing needs deep thoughts and miding odd corner
cases.

> 3. Reimplement UML features with LKL API (if we wish)

Yep. In the last release UML got virtio support, so there is hope. ;-)

> For the step 1, we put LKL as one of SUBARCH in order to make less effort
> to integrate (make ARCH=um SUBARCH=lkl).  The modification to existing UML
> code is trying to be minimized.

I'm not sure if SUBARCH is the right approach. How do I build a i386
lkl on x86_64?
Maybe we can use another variable like UMMODE={library,kernel}?

> The RFC patches also includes and a bit of step 2 as a proof of possibility
> to share the code.  For this, we used the virtio device code of LKL and use
> it from UML by enabling virtio-mmio driver with UML code.
>
>
>
> Building LKL the host library and LKL applications
> ==================================================
>
> % cd tools/lkl
> % make

Is there a reason why tool/lkl is not under arch/um?

> will build LKL as a object file, it will install it in tools/lkl/lib together
> with the headers files in tools/lkl/include then will build the host library,
> tests and a few of application examples:
>
> * tests/boot - a simple applications that uses LKL and exercises the basic
> LKL APIs
>
> * tests/net-test - a simple applications that uses network feature of
> LKL and exercises the basic network-related APIs
>
> * fs2tar - a tool that converts a filesystem image to a tar archive
>
> * cptofs/cpfromfs - a tool that copies files to/from a filesystem image
>
> % make run-tests
>
> should run the above `tests/boot` and `tests/net-test` and report errors if
> there are any.
>
> Supported hosts
> ===============
>
> Currently LKL supports POSIX and Windows userspace applications. New hosts
> can be added relatively easy if the host supports gcc and GNU ld. Previous
> versions of LKL supported Windows kernel and Haiku kernel hosts, and we
> also have WIP patches (not included in this RFC) with rump-hypercall
> interface, used in UEFI, as well as macOS userspace (part of POSIX?).
>
> There is also musl-libc port for LKL, which might be interested in for some
> folks.
>
>
> Further readings about LKL
> =========================
>
> - Discussion in github LKL issue
> https://github.com/lkl/linux/issues/304
>
> - LKL (an article)
> https://www.researchgate.net/profile/Nicolae_Tapus2/publication/224164682_LKL_The_Linux_kernel_library/links/02bfe50fd921ab4f7c000000.pdf
>
> *1 RFC email to LKML (back in 2015)
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1012277.html
>
>
>
> Please review the following changes for suitability for inclusion. If you have
> any objections or suggestions for improvement, please respond to the patches. If
> you agree with the changes, please provide your Acked-by.
>
> The following changes since commit 73625ed66389d4c620520058d828f43a93ab4d0c:
>
>   um: irq: Fix LAST_IRQ usage in init_IRQ() (2019-09-16 08:38:58 +0200)
>
> are available in the Git repository at:
>
>   git://github.com/thehajime/linux d380ec02dd0cd97afe08706093b59329e6b09fe2
>   https://github.com/thehajime/linux/tree/upstream-to-uml-5.5-rc1
>
> Akira Moroo (2):
>   Revert "vmlinux.lds.h: remove stale <linux/export.h> include"
>   um lkl: use ARCH=um SUBARCH=lkl for tools/lkl
>
> Andreas Abel (1):
>   kallsyms: Add a config option to select section for kallsyms
>
> Hajime Tazaki (9):
>   lkl: Android ARM (arm/arm64) support
>   Revert "export.h: remove code for prefixing symbols with underscore"
>   Revert "linux/linkage.h: replace VMLINUX_SYMBOL_STR() with
>     __stringify()"
>   Revert "vmlinux.lds.h: remove no-op macro VMLINUX_SYMBOL()"
>   Revert "kbuild: remove CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX"
>   Revert "kallsyms: remove symbol prefix support"
>   um lkl: add CI tests
>   um: use lkl virtio_net_tap device as UML device
>   um: add lkl virtio-blk device
>
> Octavian Purdila (34):
>   asm-generic: atomic64: allow using generic atomic64 on 64bit platforms
>   kbuild: allow architectures to automatically define kconfig symbols
>   lkl: architecture skeleton for Linux kernel library
>   lkl: host interface
>   lkl: memory handling
>   lkl: kernel threads support
>   lkl: interrupt support
>   lkl: system call interface and application API
>   lkl: timers, time and delay support
>   lkl: memory mapped I/O support
>   lkl: basic kernel console support
>   lkl: initialization and cleanup
>   lkl: plug in the build system
>   lkl tools: skeleton for host side library, tests and tools
>   lkl tools: host lib: add utilities functions
>   lkl tools: host lib: memory mapped I/O helpers
>   lkl tools: host lib: virtio devices
>   lkl tools: host lib: virtio block device
>   lkl tools: host lib: filesystem helpers
>   lkl tools: host lib: posix host operations
>   lkl tools: "boot" test
>   lkl tools: tool that converts a filesystem image to tar
>   lkl tools: tool that reads/writes to/from a filesystem image
>   lkl tools: virtio: add network device support
>   lkl: add support for Windows hosts
>   lkl tools: add support for Windows host
>   lkl tools: add lklfuse
>   lkl: add initial system call hijack support (a.k.a. NUSE of libos)
>   lkl: add documentation
>   cpu: add cpu_yield_to_irqs
>   signal: use CONFIG_X86_32 instead of __i386__
>   arch: add __SYSCALL_DEFINE_ARCH
>   xfs: support for non-mmu architectures
>   checkpatch: avoid showing BIT_ULL warnings for tools/ files
>
> Thomas Liebetraut (1):
>   tools: Add the lkl host library to the common tools Makefile
>
>  .circleci/config.yml                          | 248 +++++
>  Documentation/lkl.txt                         | 470 +++++++++
>  MAINTAINERS                                   |   8 +
>  Makefile                                      |   3 +
>  README.md                                     |   1 +
>  arch/Kconfig                                  |   6 +
>  arch/um/Kconfig                               |  56 +-
>  arch/um/Makefile                              | 115 +--
>  arch/um/Makefile.um                           | 121 +++
>  arch/um/auto.conf                             |   0
>  arch/um/configs/x86_64_defconfig              |   6 +
>  arch/um/include/asm/Kbuild                    |   6 +
>  arch/um/include/asm/io.h                      |   4 +
>  arch/um/lkl/.gitignore                        |   2 +
>  arch/um/lkl/Kconfig                           |  96 ++
>  arch/um/lkl/Kconfig.debug                     |   0
>  arch/um/lkl/Makefile                          |   0
>  arch/um/lkl/Makefile.um                       |  70 ++
>  arch/um/lkl/auto.conf                         |   1 +
>  arch/um/lkl/configs/lkl_defconfig             |  95 ++
>  arch/um/lkl/include/asm/Kbuild                |  80 ++
>  arch/um/lkl/include/asm/bitsperlong.h         |  11 +
>  arch/um/lkl/include/asm/byteorder.h           |   7 +
>  arch/um/lkl/include/asm/cpu.h                 |  14 +
>  arch/um/lkl/include/asm/elf.h                 |  15 +
>  arch/um/lkl/include/asm/host_ops.h            |  12 +
>  arch/um/lkl/include/asm/io.h                  | 104 ++
>  arch/um/lkl/include/asm/irq.h                 |  15 +
>  arch/um/lkl/include/asm/mutex.h               |   7 +
>  arch/um/lkl/include/asm/page.h                |  14 +
>  arch/um/lkl/include/asm/pgtable.h             |  62 ++
>  arch/um/lkl/include/asm/processor.h           |  60 ++
>  arch/um/lkl/include/asm/ptrace.h              |  25 +
>  arch/um/lkl/include/asm/sched.h               |  23 +
>  arch/um/lkl/include/asm/setup.h               |   7 +
>  arch/um/lkl/include/asm/syscalls.h            |  18 +
>  arch/um/lkl/include/asm/syscalls_32.h         |  43 +
>  arch/um/lkl/include/asm/thread_info.h         |  70 ++
>  arch/um/lkl/include/asm/tlb.h                 |  12 +
>  arch/um/lkl/include/asm/uaccess.h             |  64 ++
>  arch/um/lkl/include/asm/unistd.h              |  29 +
>  arch/um/lkl/include/asm/unistd_32.h           |  31 +
>  arch/um/lkl/include/asm/vmlinux.lds.h         |  14 +
>  arch/um/lkl/include/asm/xor.h                 |   9 +
>  arch/um/lkl/include/system/stdarg.h           |   2 +
>  arch/um/lkl/include/uapi/asm/Kbuild           |   9 +
>  arch/um/lkl/include/uapi/asm/bitsperlong.h    |  13 +
>  arch/um/lkl/include/uapi/asm/byteorder.h      |  11 +
>  arch/um/lkl/include/uapi/asm/host_ops.h       | 153 +++
>  arch/um/lkl/include/uapi/asm/irq.h            |  36 +
>  arch/um/lkl/include/uapi/asm/sigcontext.h     |  16 +
>  arch/um/lkl/include/uapi/asm/siginfo.h        |  11 +
>  arch/um/lkl/include/uapi/asm/swab.h           |  11 +
>  arch/um/lkl/include/uapi/asm/syscalls.h       | 348 +++++++
>  arch/um/lkl/include/uapi/asm/unistd.h         |  18 +
>  arch/um/lkl/kernel/Makefile                   |   4 +
>  arch/um/lkl/kernel/asm-offsets.c              |   2 +
>  arch/um/lkl/kernel/console.c                  |  42 +
>  arch/um/lkl/kernel/cpu.c                      | 223 +++++
>  arch/um/lkl/kernel/irq.c                      | 193 ++++
>  arch/um/lkl/kernel/misc.c                     |  60 ++
>  arch/um/lkl/kernel/setup.c                    | 193 ++++
>  arch/um/lkl/kernel/syscalls.c                 | 246 +++++
>  arch/um/lkl/kernel/syscalls_32.c              | 159 +++
>  arch/um/lkl/kernel/threads.c                  | 227 +++++
>  arch/um/lkl/kernel/time.c                     | 145 +++
>  arch/um/lkl/kernel/vmlinux.lds.S              |  51 +
>  arch/um/lkl/mm/Makefile                       |   1 +
>  arch/um/lkl/mm/bootmem.c                      |  66 ++
>  arch/um/lkl/scripts/headers_install.py        | 195 ++++
>  arch/um/lkl/um/Makefile                       |   1 +
>  .../um/lkl/um/include/sysdep/kernel-offsets.h |   4 +
>  arch/um/os-Linux/Makefile                     |   5 +
>  arch/um/os-Linux/lkl_dev.c                    | 188 ++++
>  arch/x86/um/syscalls_64.c                     |  53 +
>  crypto/xor.c                                  |   2 +
>  fs/xfs/xfs_buf.c                              |  26 +
>  include/asm-generic/atomic64.h                |   2 +
>  include/asm-generic/export.h                  |  34 +-
>  include/asm-generic/vmlinux.lds.h             | 293 +++---
>  include/linux/compiler_attributes.h           |   4 +
>  include/linux/cpu.h                           |   1 +
>  include/linux/export.h                        |  23 +-
>  include/linux/linkage.h                       |  12 +-
>  include/linux/syscalls.h                      |   6 +
>  init/Kconfig                                  |  12 +
>  kernel/cpu.c                                  |   5 +
>  kernel/signal.c                               |   2 +-
>  lib/.gitignore                                |   2 +
>  lib/raid6/.gitignore                          |   1 +
>  lib/raid6/algos.c                             |   9 +-
>  scripts/.gitignore                            |   2 +
>  scripts/Makefile.build                        |   7 +-
>  scripts/adjust_autoksyms.sh                   |   7 +-
>  scripts/basic/.gitignore                      |   1 +
>  scripts/checkpatch.pl                         |   3 +-
>  scripts/kallsyms.c                            |  58 +-
>  scripts/kconfig/.gitignore                    |   1 +
>  scripts/link-vmlinux.sh                       |  10 +
>  scripts/mod/.gitignore                        |   1 +
>  tools/Makefile                                |  11 +-
>  tools/lkl/.gitignore                          |  14 +
>  tools/lkl/Build                               |   6 +
>  tools/lkl/Makefile                            | 130 +++
>  tools/lkl/Makefile.autoconf                   | 114 +++
>  tools/lkl/Targets                             |  27 +
>  tools/lkl/bin/arm-linux-androideabi-ld        |   1 +
>  tools/lkl/bin/lkl-hijack.sh                   |  23 +
>  tools/lkl/cptofs.c                            | 635 ++++++++++++
>  tools/lkl/fs2tar.c                            | 410 ++++++++
>  tools/lkl/include/.gitignore                  |   1 +
>  tools/lkl/include/lkl.h                       | 928 ++++++++++++++++++
>  tools/lkl/include/lkl_config.h                |  61 ++
>  tools/lkl/include/lkl_host.h                  | 160 +++
>  tools/lkl/include/mingw32/sys/socket.h        |   4 +
>  tools/lkl/lib/.gitignore                      |   3 +
>  tools/lkl/lib/Build                           |  25 +
>  tools/lkl/lib/Makefile                        |  32 +
>  tools/lkl/lib/config.c                        | 793 +++++++++++++++
>  tools/lkl/lib/dbg.c                           | 300 ++++++
>  tools/lkl/lib/dbg_handler.c                   |  44 +
>  tools/lkl/lib/endian.h                        |  31 +
>  tools/lkl/lib/fs.c                            | 433 ++++++++
>  tools/lkl/lib/hijack/Build                    |   4 +
>  tools/lkl/lib/hijack/hijack.c                 | 618 ++++++++++++
>  tools/lkl/lib/hijack/init.c                   | 252 +++++
>  tools/lkl/lib/hijack/init.h                   |   8 +
>  tools/lkl/lib/hijack/xlate.c                  | 613 ++++++++++++
>  tools/lkl/lib/hijack/xlate.h                  |  13 +
>  tools/lkl/lib/iomem.c                         |  88 ++
>  tools/lkl/lib/iomem.h                         |  15 +
>  tools/lkl/lib/jmp_buf.c                       |  14 +
>  tools/lkl/lib/jmp_buf.h                       |   8 +
>  tools/lkl/lib/net.c                           | 818 +++++++++++++++
>  tools/lkl/lib/nt-host.c                       | 375 +++++++
>  tools/lkl/lib/posix-host.c                    | 439 +++++++++
>  tools/lkl/lib/utils.c                         | 266 +++++
>  tools/lkl/lib/virtio.c                        | 644 ++++++++++++
>  tools/lkl/lib/virtio.h                        | 115 +++
>  tools/lkl/lib/virtio_blk.c                    | 132 +++
>  tools/lkl/lib/virtio_net.c                    | 342 +++++++
>  tools/lkl/lib/virtio_net_dpdk.c               | 480 +++++++++
>  tools/lkl/lib/virtio_net_fd.c                 | 195 ++++
>  tools/lkl/lib/virtio_net_fd.h                 |  50 +
>  tools/lkl/lib/virtio_net_macvtap.c            |  32 +
>  tools/lkl/lib/virtio_net_pipe.c               |  76 ++
>  tools/lkl/lib/virtio_net_raw.c                |  94 ++
>  tools/lkl/lib/virtio_net_tap.c                | 111 +++
>  tools/lkl/lib/virtio_net_vde.c                | 168 ++++
>  tools/lkl/lklfuse.c                           | 658 +++++++++++++
>  tools/lkl/scripts/checkpatch.sh               |  60 ++
>  tools/lkl/scripts/dpdk-sdk-build.sh           |  18 +
>  tools/lkl/scripts/lkl-jenkins.sh              |  21 +
>  tools/lkl/tests/Build                         |   3 +
>  tools/lkl/tests/boot.c                        | 562 +++++++++++
>  tools/lkl/tests/boot.sh                       |   9 +
>  tools/lkl/tests/cla.c                         | 159 +++
>  tools/lkl/tests/cla.h                         |  33 +
>  tools/lkl/tests/disk.c                        | 189 ++++
>  tools/lkl/tests/disk.sh                       |  70 ++
>  tools/lkl/tests/hijack-test.sh                | 760 ++++++++++++++
>  tools/lkl/tests/lklfuse.sh                    | 110 +++
>  tools/lkl/tests/net-setup.sh                  | 134 +++
>  tools/lkl/tests/net-test.c                    | 317 ++++++
>  tools/lkl/tests/net.sh                        | 186 ++++
>  tools/lkl/tests/run.py                        | 186 ++++
>  tools/lkl/tests/run_netperf.sh                |  98 ++
>  tools/lkl/tests/tap13.py                      | 209 ++++
>  tools/lkl/tests/test.c                        | 126 +++
>  tools/lkl/tests/test.h                        |  72 ++
>  tools/lkl/tests/test.sh                       | 240 +++++
>  tools/lkl/tests/valgrind.supp                 |  85 ++
>  tools/lkl/tests/valgrind2xunit.py             |  69 ++
>  173 files changed, 19464 insertions(+), 330 deletions(-)
>  create mode 100644 .circleci/config.yml
>  create mode 100644 Documentation/lkl.txt
>  create mode 120000 README.md
>  create mode 100644 arch/um/Makefile.um
>  create mode 100644 arch/um/auto.conf
>  create mode 100644 arch/um/lkl/.gitignore
>  create mode 100644 arch/um/lkl/Kconfig
>  create mode 100644 arch/um/lkl/Kconfig.debug
>  create mode 100644 arch/um/lkl/Makefile
>  create mode 100644 arch/um/lkl/Makefile.um
>  create mode 100644 arch/um/lkl/auto.conf
>  create mode 100644 arch/um/lkl/configs/lkl_defconfig
>  create mode 100644 arch/um/lkl/include/asm/Kbuild
>  create mode 100644 arch/um/lkl/include/asm/bitsperlong.h
>  create mode 100644 arch/um/lkl/include/asm/byteorder.h
>  create mode 100644 arch/um/lkl/include/asm/cpu.h
>  create mode 100644 arch/um/lkl/include/asm/elf.h
>  create mode 100644 arch/um/lkl/include/asm/host_ops.h
>  create mode 100644 arch/um/lkl/include/asm/io.h
>  create mode 100644 arch/um/lkl/include/asm/irq.h
>  create mode 100644 arch/um/lkl/include/asm/mutex.h
>  create mode 100644 arch/um/lkl/include/asm/page.h
>  create mode 100644 arch/um/lkl/include/asm/pgtable.h
>  create mode 100644 arch/um/lkl/include/asm/processor.h
>  create mode 100644 arch/um/lkl/include/asm/ptrace.h
>  create mode 100644 arch/um/lkl/include/asm/sched.h
>  create mode 100644 arch/um/lkl/include/asm/setup.h
>  create mode 100644 arch/um/lkl/include/asm/syscalls.h
>  create mode 100644 arch/um/lkl/include/asm/syscalls_32.h
>  create mode 100644 arch/um/lkl/include/asm/thread_info.h
>  create mode 100644 arch/um/lkl/include/asm/tlb.h
>  create mode 100644 arch/um/lkl/include/asm/uaccess.h
>  create mode 100644 arch/um/lkl/include/asm/unistd.h
>  create mode 100644 arch/um/lkl/include/asm/unistd_32.h
>  create mode 100644 arch/um/lkl/include/asm/vmlinux.lds.h
>  create mode 100644 arch/um/lkl/include/asm/xor.h
>  create mode 100644 arch/um/lkl/include/system/stdarg.h
>  create mode 100644 arch/um/lkl/include/uapi/asm/Kbuild
>  create mode 100644 arch/um/lkl/include/uapi/asm/bitsperlong.h
>  create mode 100644 arch/um/lkl/include/uapi/asm/byteorder.h
>  create mode 100644 arch/um/lkl/include/uapi/asm/host_ops.h
>  create mode 100644 arch/um/lkl/include/uapi/asm/irq.h
>  create mode 100644 arch/um/lkl/include/uapi/asm/sigcontext.h
>  create mode 100644 arch/um/lkl/include/uapi/asm/siginfo.h
>  create mode 100644 arch/um/lkl/include/uapi/asm/swab.h
>  create mode 100644 arch/um/lkl/include/uapi/asm/syscalls.h
>  create mode 100644 arch/um/lkl/include/uapi/asm/unistd.h
>  create mode 100644 arch/um/lkl/kernel/Makefile
>  create mode 100644 arch/um/lkl/kernel/asm-offsets.c
>  create mode 100644 arch/um/lkl/kernel/console.c
>  create mode 100644 arch/um/lkl/kernel/cpu.c
>  create mode 100644 arch/um/lkl/kernel/irq.c
>  create mode 100644 arch/um/lkl/kernel/misc.c
>  create mode 100644 arch/um/lkl/kernel/setup.c
>  create mode 100644 arch/um/lkl/kernel/syscalls.c
>  create mode 100644 arch/um/lkl/kernel/syscalls_32.c
>  create mode 100644 arch/um/lkl/kernel/threads.c
>  create mode 100644 arch/um/lkl/kernel/time.c
>  create mode 100644 arch/um/lkl/kernel/vmlinux.lds.S
>  create mode 100644 arch/um/lkl/mm/Makefile
>  create mode 100644 arch/um/lkl/mm/bootmem.c
>  create mode 100755 arch/um/lkl/scripts/headers_install.py
>  create mode 100644 arch/um/lkl/um/Makefile
>  create mode 100644 arch/um/lkl/um/include/sysdep/kernel-offsets.h
>  create mode 100644 arch/um/os-Linux/lkl_dev.c
>  create mode 100644 tools/lkl/.gitignore
>  create mode 100644 tools/lkl/Build
>  create mode 100644 tools/lkl/Makefile
>  create mode 100644 tools/lkl/Makefile.autoconf
>  create mode 100644 tools/lkl/Targets
>  create mode 120000 tools/lkl/bin/arm-linux-androideabi-ld
>  create mode 100755 tools/lkl/bin/lkl-hijack.sh
>  create mode 100644 tools/lkl/cptofs.c
>  create mode 100644 tools/lkl/fs2tar.c
>  create mode 100644 tools/lkl/include/.gitignore
>  create mode 100644 tools/lkl/include/lkl.h
>  create mode 100644 tools/lkl/include/lkl_config.h
>  create mode 100644 tools/lkl/include/lkl_host.h
>  create mode 100644 tools/lkl/include/mingw32/sys/socket.h
>  create mode 100644 tools/lkl/lib/.gitignore
>  create mode 100644 tools/lkl/lib/Build
>  create mode 100644 tools/lkl/lib/Makefile
>  create mode 100644 tools/lkl/lib/config.c
>  create mode 100644 tools/lkl/lib/dbg.c
>  create mode 100644 tools/lkl/lib/dbg_handler.c
>  create mode 100644 tools/lkl/lib/endian.h
>  create mode 100644 tools/lkl/lib/fs.c
>  create mode 100644 tools/lkl/lib/hijack/Build
>  create mode 100644 tools/lkl/lib/hijack/hijack.c
>  create mode 100644 tools/lkl/lib/hijack/init.c
>  create mode 100644 tools/lkl/lib/hijack/init.h
>  create mode 100644 tools/lkl/lib/hijack/xlate.c
>  create mode 100644 tools/lkl/lib/hijack/xlate.h
>  create mode 100644 tools/lkl/lib/iomem.c
>  create mode 100644 tools/lkl/lib/iomem.h
>  create mode 100644 tools/lkl/lib/jmp_buf.c
>  create mode 100644 tools/lkl/lib/jmp_buf.h
>  create mode 100644 tools/lkl/lib/net.c
>  create mode 100644 tools/lkl/lib/nt-host.c
>  create mode 100644 tools/lkl/lib/posix-host.c
>  create mode 100644 tools/lkl/lib/utils.c
>  create mode 100644 tools/lkl/lib/virtio.c
>  create mode 100644 tools/lkl/lib/virtio.h
>  create mode 100644 tools/lkl/lib/virtio_blk.c
>  create mode 100644 tools/lkl/lib/virtio_net.c
>  create mode 100644 tools/lkl/lib/virtio_net_dpdk.c
>  create mode 100644 tools/lkl/lib/virtio_net_fd.c
>  create mode 100644 tools/lkl/lib/virtio_net_fd.h
>  create mode 100644 tools/lkl/lib/virtio_net_macvtap.c
>  create mode 100644 tools/lkl/lib/virtio_net_pipe.c
>  create mode 100644 tools/lkl/lib/virtio_net_raw.c
>  create mode 100644 tools/lkl/lib/virtio_net_tap.c
>  create mode 100644 tools/lkl/lib/virtio_net_vde.c
>  create mode 100644 tools/lkl/lklfuse.c
>  create mode 100755 tools/lkl/scripts/checkpatch.sh
>  create mode 100755 tools/lkl/scripts/dpdk-sdk-build.sh
>  create mode 100755 tools/lkl/scripts/lkl-jenkins.sh
>  create mode 100644 tools/lkl/tests/Build
>  create mode 100644 tools/lkl/tests/boot.c
>  create mode 100755 tools/lkl/tests/boot.sh
>  create mode 100644 tools/lkl/tests/cla.c
>  create mode 100644 tools/lkl/tests/cla.h
>  create mode 100644 tools/lkl/tests/disk.c
>  create mode 100755 tools/lkl/tests/disk.sh
>  create mode 100755 tools/lkl/tests/hijack-test.sh
>  create mode 100755 tools/lkl/tests/lklfuse.sh
>  create mode 100644 tools/lkl/tests/net-setup.sh
>  create mode 100644 tools/lkl/tests/net-test.c
>  create mode 100755 tools/lkl/tests/net.sh
>  create mode 100755 tools/lkl/tests/run.py
>  create mode 100755 tools/lkl/tests/run_netperf.sh
>  create mode 100644 tools/lkl/tests/tap13.py
>  create mode 100644 tools/lkl/tests/test.c
>  create mode 100644 tools/lkl/tests/test.h
>  create mode 100644 tools/lkl/tests/test.sh
>  create mode 100644 tools/lkl/tests/valgrind.supp
>  create mode 100755 tools/lkl/tests/valgrind2xunit.py
>
> --
> 2.20.1 (Apple Git-117)
>
>
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um



-- 
Thanks,
//richard
