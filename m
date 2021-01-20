Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BEE2FC8FB
	for <lists+linux-arch@lfdr.de>; Wed, 20 Jan 2021 04:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731950AbhATC3b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Jan 2021 21:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729224AbhATC2U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jan 2021 21:28:20 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1461C061757
        for <linux-arch@vger.kernel.org>; Tue, 19 Jan 2021 18:27:39 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id m5so1176242pjv.5
        for <linux-arch@vger.kernel.org>; Tue, 19 Jan 2021 18:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xmX908JENsIXDrEuDymsi+FvEW13oaUohjpobi1D9g4=;
        b=DYqc0rK++mSjK9zWY3Hn25MhlWE0ZyNQekd3rVmaee6yC8pzSYsyKDkAiqed3zoXye
         VyEU98eJmECkaRhvM9QRbb+GgMrA4NIJYd6laFvasrNeBF/biMC7fbui4V2fBSsV49Kz
         +7L0bZe6iEzGTF+N8o0RmUf4OJYkTawW7ssOL1XgkY8TLfo7GiaYm1z+F52C+VDvSp5U
         +Wnyf/e/Po9rEYG04XqowaPCS6kv9sUYBhyxUEDj4CwdQPhsaM7Vw9o8/IQ3jS9iePam
         Ibe9ZO2O/CPhFzBd2cMMUXvNOQtODdYlkoY2zJ/hQBQIWV+NuDllyEHVKYnTY9DnXfly
         ipCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xmX908JENsIXDrEuDymsi+FvEW13oaUohjpobi1D9g4=;
        b=jZA1W5tBghkyMd3bipOyDItodEI8qn3aQ/I9Mg1Yx5FR+/t///JZnCJq048HoKnBSr
         CPzqRmXfKK0EnnUFOYbH4xE2nLXvMa7NgjFPqUgDNgUoYpE4jcJqaNgucANK0ltT12b4
         VS34uWmVgnCgqnvr2vcIWUOWe+dH68VUYjNdEWqTmliyPogWQswdX4ceYrixy6rCagI4
         DIv54JdDOonUdk68TNX4mhO3ynKfm1m0nzMevnkn8shbilzrZV215lCPan9iSxAVu04N
         z8bbeifTp1iD3AItEBssa9VBAMohz1yhY5HvI36Xwt5ZEawlqfnesldLKTAq1IULhXB7
         HqLg==
X-Gm-Message-State: AOAM533L+woQh+j5Wgr50iHgL0fo0lVzFFEFHALZKmbXRXVJ/YtnWUB+
        nvysv1TmAjgnXA8OgIDFE+I=
X-Google-Smtp-Source: ABdhPJxvrx4G9jyn55O6bB/Z7HSP8HjG7sIXrm2A4GpA7Sd6y4lzBL8DA/LGDvTtpEkNWSCCOWiihA==
X-Received: by 2002:a17:902:ed88:b029:de:86f9:3e09 with SMTP id e8-20020a170902ed88b02900de86f93e09mr7593378plj.38.1611109659043;
        Tue, 19 Jan 2021 18:27:39 -0800 (PST)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id 21sm378356pfx.84.2021.01.19.18.27.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jan 2021 18:27:38 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id 340EA20442D28F; Wed, 20 Jan 2021 11:27:36 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     thehajime@gmail.com, tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org
Subject: [RFC v8 00/20] Unifying LKL into UML
Date:   Wed, 20 Jan 2021 11:27:05 +0900
Message-Id: <cover.1611103406.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is another spin of the unification of LKL into UML.  Updated and
fixed comments from our v7 patches.  The summary is listed in the
changelog below.

Note that the whole patchset requires the patch "um: ubd: fix command
line handling of ubd" to be correctly tested, which I previously
submitted.


Changes in rfc v8:
- stop using the term "nommu" mode, "library" mode instead
- generic atomic64 rewrite to use gcc builtin atomics
- use kernel-doc format for comments
- stop using a collection of function pointer (struct lkl_host_operations),
  but weak functions
- use python3, not python
- use c99 initializers for strerror
- add comments/descriptions about thread implementation
- remove redundant Kconfig entries (RAID6_PQ_BENCHMARK, STACKTRACE_SUPPORT,
  etc)
- refine code comments
- stop using NPROC for the internal -j flag
- remove make argument of "UMMODE=library"
- preserve the vmlinux file as it is
- rework commit history with reasonable files
- rework test framework using kselftest (tools/testing/selftests/um/)
- add documentation, MAINTAINERS


Changes in rfc v7:
- preserve `make ARCH=um` syntax to build UML
- introduce `make ARCH=um UMMODE=library` to build library mode
- fix undefined symbols issue during modpost
- clean up makefiles (arch/um, tools/um)

Changes in rfc v6:
- rebase with the current linus tree

Changes in rfc v5:
- rewrite whole patchset from scratch
- move arch-dependent code of arch/um and arch/x86/um to tools/um
 - mainly code under os-Linux/ involved
 - introduce 2-stage build (kernel, and host-dependent parts)
 - clean up vmlinux.lds.S
- put LKL-specific implementations as a SUBARCH under arch/um/nommu
- introduce !CONFIG_MMU in arch/um
- use struct arch_thread and arch_switch_to() for subarch-specific
  thread implementation
- integrate with the IRQ infrastructure of UML
- tested with block device drivers (ubd) for the proof

Changes in rfc v4: (https://lwn.net/Articles/816276/)
- Rebase on the current uml/master branch
- Fix IRQ handling (bug fix)
- drop a patch for CONFIG_GENERIC_ATOMIC64 (comment by Peter Zijlstra)
- implement vector net driver for UMMODE_LIB (comment by Anton)
- clean up uapi headers to avoid duplicates
- clean up IRQ handling code (comment by Anton)
- fix error handling in test code (comments by David Disseldorp)

Changes in rfc v3:
- use UML drivers (net, block) from LKL programs
- drop virtio device implementations
- drop mingw32 (Windows) host
- drop android (arm/aarch64) host
- drop FreeBSD (x86_64) host
- drop LD_PRELOAD (hijack) support
- update milestone

rfc v2:
- use UMMODE instead of SUBARCH to switch UML or LKL
- tools/lkl directory is still there. I confirmed we can move under arch/um
  (e.g., arch/um/lkl/hosts).  I will move it IF this is preferable.
- drop several patches involved non-uml directory
- drop several patches which are not required
- refine commit logs
- document updated




LKL (Linux Kernel Library) is aiming to allow reusing the Linux kernel code
as extensively as possible with minimal effort and reduced maintenance
overhead.

Examples of how LKL can be used are: creating userspace applications
(running on Linux and other operating systems) that can read or write Linux
filesystems or can use the Linux networking stack, creating kernel drivers
for other operating systems that can read Linux filesystems, bootloaders
support for reading/writing Linux filesystems, etc.

With LKL, the kernel code is compiled into an object file that can be
directly linked by applications. The API offered by LKL is based on the
Linux system call interface.

LKL is originally implemented as an architecture port in arch/lkl, but this
series of commits tries to integrate this into arch/um as one of the mode
of UML.  This was discussed during RFC email of LKL (*1).

The latest LKL version can be found at https://github.com/lkl/linux

Milestone
=========
This patches is a first step toward upstreaming *library mode* of
Linux kernel, but we think we need to have several steps toward our
goal, describing in the below.


Milestone 1: LKL lib on top of UML
 * Kernel - Host build split
 -  Build UML as a relocatable object using the UML's kernel linker script.
 -  Move the ptrace and other well isolated os code out of arch/um to
    tools/um
 -  Use standard host toolchain to create a static library stripped of
    the ptrace code. Use standard host toolchain to build the main UML
    executable.
 -  Add library init API that creates the UML kernel process and starts
    UML.
 * System calls APIs
 -  Add new system call interface based on UML's irq facility.
 -  Use the LKL scripts to export the required headers to create system
    calls APIs that use the UML system calls infrastructure.
 -  Keep the underlying host and driver operations (threads, irqs, etc.)
    as they are now in UML.
 * Boot test
 -  Port the LKL boot test to verify that we are able to programatically
    issue system calls.

Milestone 2: add virtio disk support
 * Export asm/io.h operations to host/os. Create IO access operations
   and redirect them to weak os_ variants that use the current UML
   implementation.
 * Add the LKL IO access layer including generic virtio handling and the
   virtio block device code.
 * Port LKL disk test and disk apps (lklfuse, fs2tar, cptofs)

Milestone 3: new arch ports
  * Abstract the system call / IRQ mode the move the implementation to host
  * Abstract the thread model and move the implementation to host
  * Add LKL thread model and LKL ports


Building LKL the host library and LKL applications
==================================================

% make ARCH=um SUBARCH=lkl defconfig
% make ARCH=um SUBARCH=lkl

will build LKL as a object file, it will install it in
tools/um/libtogether with the headers files in tools/um/include then
will build the host library, tests and a few of application examples:

* tools/testing/selftests/um/boot.c - a simple applications that uses
  LKL and exercises the basic LKL APIs

* tools/testing/selftests/um/disk.c - a simple applications that tests
  LKL and exercises the basic filesystem-related LKL APIs

Those tests can run with the following kselftest command:

    $ make ARCH=um SUBARCH=lkl TARGETS="um" kselftest

Supported hosts
===============

Currently LKL supports Linux userspace applications. New hosts can be added
relatively easy if the host supports gcc and GNU ld. Previous versions of
LKL supported Windows kernel and Haiku kernel hosts, and we also have WIP
patches with rump-hypercall interface, used in UEFI, as well as macOS
userspace (part of POSIX).

There is also musl-libc port for LKL, which might be interested in for some
folks.


Further readings about LKL
=========================

- Discussion in github LKL issue
https://github.com/lkl/linux/issues/304

- LKL (an article)
https://www.researchgate.net/profile/Nicolae_Tapus2/publication/224164682_LKL_The_Linux_kernel_library/links/02bfe50fd921ab4f7c000000.pdf

*1 RFC email to LKML (back in 2015)
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1012277.html


Please review the following changes for suitability for inclusion. If you have
any objections or suggestions for improvement, please respond to the patches. If
you agree with the changes, please provide your Acked-by.

The following changes since commit 19c329f6808995b142b3966301f217c831e7cf31:

  Linux 5.11-rc4 (2021-01-17 16:37:05 -0800)

are available in the Git repository at:

  git://github.com/thehajime/linux 043677211bb5562397c511911e7861c3e217611b
  https://github.com/thehajime/linux/tree/uml-lkl-5.11rc4-v8

Hajime Tazaki (18):
  um: move arch/um/os-Linux dir to tools/um/uml
  um: move arch/x86/um/os-Linux to tools/um/uml/
  um: extend arch_switch_to for alternate SUBARCH
  um: add UML library mode
  um: lkl: host interface
  um: lkl: memory handling
  um: lkl: kernel thread support
  um: lkl: system call interface and application API
  um: lkl: basic console support
  um: lkl: initialization and cleanup
  um: lkl: integrate with irq infrastructure of UML
  um: lkl: plug in the build system
  um: host: add library mode build for ARCH=um
  um: host: add utilities functions
  um: host: posix host operations
  selftests/um: lkl: add test programs for library mode of UML
  um: lkl: add block device support of UML
  um: lkl: add documentation

Octavian Purdila (2):
  um: split build in kernel and host parts
  um: implement os_initcalls and os_exitcalls

 Documentation/virt/uml/lkl.txt                |  48 ++
 MAINTAINERS                                   |  10 +
 arch/um/Kconfig                               |  37 +-
 arch/um/Makefile                              |  41 +-
 arch/um/configs/lkl_defconfig                 |  73 +++
 arch/um/drivers/Makefile                      |  10 +-
 .../um/{os-Linux => }/drivers/ethertap_kern.c |   0
 arch/um/{os-Linux => }/drivers/tuntap_kern.c  |   0
 arch/um/include/asm/common.lds.S              |  99 ----
 arch/um/include/asm/host_ops.h                |   9 +
 arch/um/include/asm/mmu.h                     |   3 +
 arch/um/include/asm/mmu_context.h             |  10 +
 arch/um/include/asm/page.h                    |  15 +
 arch/um/include/asm/pgtable.h                 |  27 +
 arch/um/include/asm/thread_info.h             |  24 +
 arch/um/include/asm/uaccess.h                 |   6 +
 arch/um/include/asm/xor.h                     |   3 +-
 arch/um/include/shared/as-layout.h            |   1 +
 .../drivers => include/shared}/etap.h         |   0
 arch/um/include/shared/init.h                 |  19 +-
 arch/um/include/shared/os.h                   |   1 +
 .../drivers => include/shared}/tuntap.h       |   0
 arch/um/kernel/Makefile                       |  13 +-
 arch/um/kernel/dyn.lds.S                      | 171 -------
 arch/um/kernel/irq.c                          |  13 +
 arch/um/kernel/process.c                      |  14 +-
 arch/um/kernel/reboot.c                       |   5 +
 arch/um/kernel/time.c                         |   2 +
 arch/um/kernel/um_arch.c                      |  16 +
 arch/um/kernel/uml.lds.S                      | 115 -----
 arch/um/{os-Linux => kernel}/user_syms.c      |   0
 arch/um/kernel/vmlinux.lds.S                  |  92 +++-
 arch/um/lkl/Makefile                          |   2 +
 arch/um/lkl/Makefile.um                       |  18 +
 arch/um/lkl/include/asm/Kbuild                |   7 +
 arch/um/lkl/include/asm/archparam.h           |   1 +
 arch/um/lkl/include/asm/atomic.h              |  11 +
 arch/um/lkl/include/asm/atomic64.h            |  91 ++++
 arch/um/lkl/include/asm/cpu.h                 |  15 +
 arch/um/lkl/include/asm/elf.h                 |  19 +
 arch/um/lkl/include/asm/mm_context.h          |   8 +
 arch/um/lkl/include/asm/processor.h           |  48 ++
 arch/um/lkl/include/asm/ptrace.h              |  21 +
 arch/um/lkl/include/asm/sched.h               |  23 +
 arch/um/lkl/include/asm/segment.h             |   9 +
 arch/um/lkl/include/asm/syscall_wrapper.h     |  57 +++
 arch/um/lkl/include/asm/syscalls.h            |  15 +
 arch/um/lkl/include/uapi/asm/Kbuild           |   6 +
 arch/um/lkl/include/uapi/asm/bitsperlong.h    |  16 +
 arch/um/lkl/include/uapi/asm/byteorder.h      |  13 +
 arch/um/lkl/include/uapi/asm/host_ops.h       | 280 +++++++++++
 arch/um/lkl/include/uapi/asm/sigcontext.h     |  12 +
 arch/um/lkl/include/uapi/asm/syscalls.h       | 301 ++++++++++++
 arch/um/lkl/include/uapi/asm/unistd.h         |  17 +
 arch/um/lkl/um/Kconfig                        |  21 +
 arch/um/lkl/um/Makefile                       |   4 +
 arch/um/lkl/um/bootmem.c                      | 107 ++++
 arch/um/lkl/um/console.c                      |  41 ++
 arch/um/lkl/um/cpu.c                          | 269 ++++++++++
 arch/um/lkl/um/delay.c                        |  31 ++
 arch/um/lkl/um/setup.c                        | 179 +++++++
 arch/um/lkl/um/shared/sysdep/archsetjmp.h     |  13 +
 arch/um/lkl/um/shared/sysdep/faultinfo.h      |   8 +
 arch/um/lkl/um/shared/sysdep/kernel-offsets.h |  12 +
 arch/um/lkl/um/shared/sysdep/mcontext.h       |   9 +
 arch/um/lkl/um/shared/sysdep/ptrace.h         |  42 ++
 arch/um/lkl/um/shared/sysdep/ptrace_user.h    |   7 +
 arch/um/lkl/um/syscalls.c                     | 193 ++++++++
 arch/um/lkl/um/threads.c                      | 261 ++++++++++
 arch/um/lkl/um/unimplemented.c                |  70 +++
 arch/um/lkl/um/user_constants.h               |  13 +
 arch/um/os-Linux/Makefile                     |  21 -
 arch/um/os-Linux/drivers/Makefile             |  13 -
 arch/um/scripts/headers_install.py            | 200 ++++++++
 arch/x86/um/Makefile                          |   2 +-
 arch/x86/um/os-Linux/Makefile                 |  13 -
 arch/x86/um/ptrace_32.c                       |   2 +-
 arch/x86/um/syscalls_64.c                     |   2 +-
 scripts/headers_install.sh                    |   6 +-
 scripts/link-vmlinux.sh                       |  42 +-
 tools/testing/selftests/Makefile              |   3 +
 tools/testing/selftests/um/Makefile           |  16 +
 tools/testing/selftests/um/boot.c             | 376 ++++++++++++++
 tools/testing/selftests/um/cla.c              | 159 ++++++
 tools/testing/selftests/um/cla.h              |  33 ++
 tools/testing/selftests/um/disk-ext4.sh       |   6 +
 tools/testing/selftests/um/disk-vfat.sh       |   6 +
 tools/testing/selftests/um/disk.c             | 166 +++++++
 tools/testing/selftests/um/disk.sh            |  67 +++
 tools/testing/selftests/um/test.c             | 128 +++++
 tools/testing/selftests/um/test.h             |  72 +++
 tools/testing/selftests/um/test.sh            | 181 +++++++
 tools/um/.gitignore                           |   1 +
 tools/um/Makefile                             |  76 +++
 tools/um/Targets                              |   9 +
 tools/um/include/lkl.h                        | 364 ++++++++++++++
 tools/um/include/lkl_host.h                   |  19 +
 tools/um/lib/Build                            |   7 +
 tools/um/lib/fs.c                             | 461 ++++++++++++++++++
 tools/um/lib/jmp_buf.c                        |  14 +
 tools/um/lib/posix-host.c                     | 273 +++++++++++
 tools/um/lib/utils.c                          | 207 ++++++++
 tools/um/uml/Build                            |  59 +++
 tools/um/uml/drivers/Build                    |  10 +
 .../um/uml}/drivers/ethertap_user.c           |   0
 .../um/uml}/drivers/tuntap_user.c             |   0
 {arch/um/os-Linux => tools/um/uml}/elf_aux.c  |   0
 {arch/um/os-Linux => tools/um/uml}/execvp.c   |   4 -
 {arch/um/os-Linux => tools/um/uml}/file.c     |   0
 {arch/um/os-Linux => tools/um/uml}/helper.c   |   0
 {arch/um/os-Linux => tools/um/uml}/irq.c      |   0
 tools/um/uml/lkl/Build                        |   1 +
 tools/um/uml/lkl/registers.c                  |  21 +
 tools/um/uml/lkl/unimplemented.c              |  21 +
 {arch/um/os-Linux => tools/um/uml}/main.c     |   0
 {arch/um/os-Linux => tools/um/uml}/mem.c      |   0
 {arch/um/os-Linux => tools/um/uml}/process.c  |   2 +
 .../um/os-Linux => tools/um/uml}/registers.c  |   0
 {arch/um/os-Linux => tools/um/uml}/sigio.c    |   0
 {arch/um/os-Linux => tools/um/uml}/signal.c   |  12 +-
 .../skas/Makefile => tools/um/uml/skas/Build  |   6 +-
 {arch/um/os-Linux => tools/um/uml}/skas/mem.c |   0
 .../os-Linux => tools/um/uml}/skas/process.c  |   3 +-
 {arch/um/os-Linux => tools/um/uml}/start_up.c |   0
 {arch/um/os-Linux => tools/um/uml}/time.c     |   0
 {arch/um/os-Linux => tools/um/uml}/tty.c      |   0
 {arch/um/os-Linux => tools/um/uml}/umid.c     |   0
 {arch/um/os-Linux => tools/um/uml}/util.c     |  26 +
 tools/um/uml/x86/Build                        |  11 +
 .../os-Linux => tools/um/uml/x86}/mcontext.c  |   0
 .../um/os-Linux => tools/um/uml/x86}/prctl.c  |   0
 .../os-Linux => tools/um/uml/x86}/registers.c |   0
 .../os-Linux => tools/um/uml/x86}/task_size.c |   0
 .../um/os-Linux => tools/um/uml/x86}/tls.c    |   0
 134 files changed, 5743 insertions(+), 525 deletions(-)
 create mode 100644 Documentation/virt/uml/lkl.txt
 create mode 100644 arch/um/configs/lkl_defconfig
 rename arch/um/{os-Linux => }/drivers/ethertap_kern.c (100%)
 rename arch/um/{os-Linux => }/drivers/tuntap_kern.c (100%)
 delete mode 100644 arch/um/include/asm/common.lds.S
 create mode 100644 arch/um/include/asm/host_ops.h
 rename arch/um/{os-Linux/drivers => include/shared}/etap.h (100%)
 rename arch/um/{os-Linux/drivers => include/shared}/tuntap.h (100%)
 delete mode 100644 arch/um/kernel/dyn.lds.S
 delete mode 100644 arch/um/kernel/uml.lds.S
 rename arch/um/{os-Linux => kernel}/user_syms.c (100%)
 create mode 100644 arch/um/lkl/Makefile
 create mode 100644 arch/um/lkl/Makefile.um
 create mode 100644 arch/um/lkl/include/asm/Kbuild
 create mode 100644 arch/um/lkl/include/asm/archparam.h
 create mode 100644 arch/um/lkl/include/asm/atomic.h
 create mode 100644 arch/um/lkl/include/asm/atomic64.h
 create mode 100644 arch/um/lkl/include/asm/cpu.h
 create mode 100644 arch/um/lkl/include/asm/elf.h
 create mode 100644 arch/um/lkl/include/asm/mm_context.h
 create mode 100644 arch/um/lkl/include/asm/processor.h
 create mode 100644 arch/um/lkl/include/asm/ptrace.h
 create mode 100644 arch/um/lkl/include/asm/sched.h
 create mode 100644 arch/um/lkl/include/asm/segment.h
 create mode 100644 arch/um/lkl/include/asm/syscall_wrapper.h
 create mode 100644 arch/um/lkl/include/asm/syscalls.h
 create mode 100644 arch/um/lkl/include/uapi/asm/Kbuild
 create mode 100644 arch/um/lkl/include/uapi/asm/bitsperlong.h
 create mode 100644 arch/um/lkl/include/uapi/asm/byteorder.h
 create mode 100644 arch/um/lkl/include/uapi/asm/host_ops.h
 create mode 100644 arch/um/lkl/include/uapi/asm/sigcontext.h
 create mode 100644 arch/um/lkl/include/uapi/asm/syscalls.h
 create mode 100644 arch/um/lkl/include/uapi/asm/unistd.h
 create mode 100644 arch/um/lkl/um/Kconfig
 create mode 100644 arch/um/lkl/um/Makefile
 create mode 100644 arch/um/lkl/um/bootmem.c
 create mode 100644 arch/um/lkl/um/console.c
 create mode 100644 arch/um/lkl/um/cpu.c
 create mode 100644 arch/um/lkl/um/delay.c
 create mode 100644 arch/um/lkl/um/setup.c
 create mode 100644 arch/um/lkl/um/shared/sysdep/archsetjmp.h
 create mode 100644 arch/um/lkl/um/shared/sysdep/faultinfo.h
 create mode 100644 arch/um/lkl/um/shared/sysdep/kernel-offsets.h
 create mode 100644 arch/um/lkl/um/shared/sysdep/mcontext.h
 create mode 100644 arch/um/lkl/um/shared/sysdep/ptrace.h
 create mode 100644 arch/um/lkl/um/shared/sysdep/ptrace_user.h
 create mode 100644 arch/um/lkl/um/syscalls.c
 create mode 100644 arch/um/lkl/um/threads.c
 create mode 100644 arch/um/lkl/um/unimplemented.c
 create mode 100644 arch/um/lkl/um/user_constants.h
 delete mode 100644 arch/um/os-Linux/Makefile
 delete mode 100644 arch/um/os-Linux/drivers/Makefile
 create mode 100755 arch/um/scripts/headers_install.py
 delete mode 100644 arch/x86/um/os-Linux/Makefile
 create mode 100644 tools/testing/selftests/um/Makefile
 create mode 100644 tools/testing/selftests/um/boot.c
 create mode 100644 tools/testing/selftests/um/cla.c
 create mode 100644 tools/testing/selftests/um/cla.h
 create mode 100755 tools/testing/selftests/um/disk-ext4.sh
 create mode 100755 tools/testing/selftests/um/disk-vfat.sh
 create mode 100644 tools/testing/selftests/um/disk.c
 create mode 100755 tools/testing/selftests/um/disk.sh
 create mode 100644 tools/testing/selftests/um/test.c
 create mode 100644 tools/testing/selftests/um/test.h
 create mode 100644 tools/testing/selftests/um/test.sh
 create mode 100644 tools/um/.gitignore
 create mode 100644 tools/um/Makefile
 create mode 100644 tools/um/Targets
 create mode 100644 tools/um/include/lkl.h
 create mode 100644 tools/um/include/lkl_host.h
 create mode 100644 tools/um/lib/Build
 create mode 100644 tools/um/lib/fs.c
 create mode 100644 tools/um/lib/jmp_buf.c
 create mode 100644 tools/um/lib/posix-host.c
 create mode 100644 tools/um/lib/utils.c
 create mode 100644 tools/um/uml/Build
 create mode 100644 tools/um/uml/drivers/Build
 rename {arch/um/os-Linux => tools/um/uml}/drivers/ethertap_user.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/drivers/tuntap_user.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/elf_aux.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/execvp.c (98%)
 rename {arch/um/os-Linux => tools/um/uml}/file.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/helper.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/irq.c (100%)
 create mode 100644 tools/um/uml/lkl/Build
 create mode 100644 tools/um/uml/lkl/registers.c
 create mode 100644 tools/um/uml/lkl/unimplemented.c
 rename {arch/um/os-Linux => tools/um/uml}/main.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/mem.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/process.c (99%)
 rename {arch/um/os-Linux => tools/um/uml}/registers.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/sigio.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/signal.c (96%)
 rename arch/um/os-Linux/skas/Makefile => tools/um/uml/skas/Build (56%)
 rename {arch/um/os-Linux => tools/um/uml}/skas/mem.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/skas/process.c (99%)
 rename {arch/um/os-Linux => tools/um/uml}/start_up.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/time.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/tty.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/umid.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/util.c (89%)
 create mode 100644 tools/um/uml/x86/Build
 rename {arch/x86/um/os-Linux => tools/um/uml/x86}/mcontext.c (100%)
 rename {arch/x86/um/os-Linux => tools/um/uml/x86}/prctl.c (100%)
 rename {arch/x86/um/os-Linux => tools/um/uml/x86}/registers.c (100%)
 rename {arch/x86/um/os-Linux => tools/um/uml/x86}/task_size.c (100%)
 rename {arch/x86/um/os-Linux => tools/um/uml/x86}/tls.c (100%)

-- 
2.21.0 (Apple Git-122.2)

