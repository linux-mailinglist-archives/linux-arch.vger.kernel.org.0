Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBB7212594
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jul 2020 16:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbgGBOHh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 10:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729510AbgGBOHg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 10:07:36 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34789C08C5C1
        for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2020 07:07:36 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id h22so12592647pjf.1
        for <linux-arch@vger.kernel.org>; Thu, 02 Jul 2020 07:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lXQQhXMGKOP/bCC6CrzWkaHQadUIdM3P4wpsu3pX9PY=;
        b=sjPomfkUBMXXaUTmesB6kAyVOUx36bhlWzL8Xbq0JjXGGBN7kog9dsna3WKKZdHV/f
         ZAISfkNnKEEu5I7lHJVbQjq7vdi0POu2dcrJOsHWiimDr3FmI9c6PX3Ck9dz0kmUiV4t
         Z6nYupYqoxO0R1avzeSxJs1dG0KDkVFe6L/3Z1tP9rnw03tJy0BXRXyry8lFf7NpYARQ
         d0KNfQq+CbjWtL9tYJLRZ1lqqJzzs0+AodY1KYRLpFvDAi20xWwel9cUNmh+sLsadOvZ
         C6g1Z+xdZbUZHG8baa3fxfxO7eUVfi1mvL5BnxQ178eF23h34oA9ICfp4dNT4V2tMCwL
         eNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lXQQhXMGKOP/bCC6CrzWkaHQadUIdM3P4wpsu3pX9PY=;
        b=J2eJioZy2ussM8jDAjb2LU0rWeHP8gU0Eyp5pnhbTcnXMc4BXo/HE2R/1Qz5CrOmOj
         udvobyyPCELn9YzhviIb/QKUWf8HFgjwNoB7pn6uN62eKbf8CHWAPvJmTqDdDMWkVd5R
         Psy5zZuX0icWIfRMcRGuugyfSiZUFSnLCm7neapxkqaq03PgZoG76yh6WeKqCCOAdqdQ
         uEkE+8nrikbnKSThBt4IxfB4feCJqxCvg2tfeHaA3vljgK4p+GlXmAwMkQUT75RL/cu6
         rIHDH+BXablafzZgNaPbfy6X6GzvanJhDqSz7daj9Esy16CSZi81k+o9gQuxezNTEUlD
         tAkQ==
X-Gm-Message-State: AOAM530om+28UULDY2xh+ByqshgwCaLXNgsnXPbFXnbqsR7p6Cxz8MRn
        9M2vqtf9qgjZiYamS8kVNZY=
X-Google-Smtp-Source: ABdhPJyO6D8K9DxlXaxYi8I5xtoG/pObs4TyHtKWV7iA/8S7psNLnBoRmGTXz5sofWWzYyP5D7gJrw==
X-Received: by 2002:a17:902:502:: with SMTP id 2mr27684716plf.62.1593698854135;
        Thu, 02 Jul 2020 07:07:34 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id 21sm8964094pgy.20.2020.07.02.07.07.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jul 2020 07:07:33 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id AA557202D31CE3; Thu,  2 Jul 2020 23:07:29 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v5 00/21] Unifying LKL into UML
Date:   Thu,  2 Jul 2020 23:06:54 +0900
Message-Id: <cover.1593697069.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1585579244.git.thehajime@gmail.com>
References: <cover.1585579244.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is another spin of the unification of LKL into UML.  Based on the
discussion of v4 patchset, we have tried to address issue raised and
rewrote the patchset from scratch.  The summary is listed in the
changelog below.

Although there are still bugs in the patchset, we'd like to ask your
opinions on the design we changed.

The milestone section is also updated: this patchset is for the
milestone 1, though the common init API is still not implemented yet.


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
This patches is a first step toward upstreaming *library mode* of Linux kernel,
but we think we need to have several steps toward our goal, describing in the
below.


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

% cd tools/um
% make

will build LKL as a object file, it will install it in tools/um/lib together
with the headers files in tools/um/include then will build the host library,
tests and a few of application examples:

* tests/boot - a simple applications that uses LKL and exercises the basic
  LKL APIs

% make run-tests

should run the above `tests/boot` and `tests/net-test` and report errors if
there are any.

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

The following changes since commit f6e8c474390be2e6f5bd0b8966e19958214609ff:

  um: virtio: Replace zero-length array with flexible-array (2020-06-02 22:38:00 +0200)

are available in the Git repository at:

  git://github.com/thehajime/linux b6eab5512a8168bbb46a485e9386e8cbd812b511
  https://github.com/thehajime/linux/tree/uml-lkl-5.8rc1-v5

Hajime Tazaki (18):
  um: move arch/um/os-Linux dir to tools/um/uml
  um: move arch/x86/um/os-Linux to tools/um/uml/
  scritps: um: suppress warnings if SRCARCH=um
  um: extend arch_switch_to for alternate SUBARCH
  um: add nommu mode for UML library mode
  um: nommu: host interface
  um: nommu: memory handling
  um: nommu: kernel thread support
  um: nommu: system call interface and application API
  um: nommu: basic console support
  um: nommu: initialization and cleanup
  um: nommu: integrate with irq infrastructure of UML
  um: nommu: plug in the build system
  um: host: add nommu build for ARCH=um
  um: host: add utilities functions
  um: host: posix host operations
  um: host: add test programs
  um: nommu: add block device support of UML

Octavian Purdila (3):
  um: split build in kernel and host parts
  um: add os init and exit calls
  um: host: implement os_initcalls and os_exitcalls

 arch/um/Kconfig                               |  29 +-
 arch/um/Makefile                              |  25 +-
 arch/um/drivers/Makefile                      |  10 +-
 .../um/{os-Linux => }/drivers/ethertap_kern.c |   0
 arch/um/{os-Linux => }/drivers/tuntap_kern.c  |   0
 arch/um/include/asm/common.lds.S              |  99 ----
 arch/um/include/asm/host_ops.h                |   9 +
 arch/um/include/asm/mmu.h                     |   3 +
 arch/um/include/asm/mmu_context.h             |   8 +
 arch/um/include/asm/page.h                    |  15 +
 arch/um/include/asm/pgtable.h                 |  27 +
 arch/um/include/asm/thread_info.h             |  24 +
 arch/um/include/asm/uaccess.h                 |   6 +
 arch/um/include/asm/xor.h                     |   3 +-
 arch/um/include/shared/as-layout.h            |   1 +
 .../drivers => include/shared}/etap.h         |   0
 arch/um/include/shared/init.h                 |  18 +-
 arch/um/include/shared/os.h                   |   1 +
 .../drivers => include/shared}/tuntap.h       |   0
 arch/um/include/uapi/asm/Kbuild               |   2 +
 arch/um/kernel/Makefile                       |  12 +-
 arch/um/kernel/dyn.lds.S                      | 171 -------
 arch/um/kernel/irq.c                          |  13 +
 arch/um/kernel/process.c                      |  14 +-
 arch/um/kernel/reboot.c                       |   5 +
 arch/um/kernel/time.c                         |   2 +
 arch/um/kernel/um_arch.c                      |  16 +
 arch/um/kernel/uml.lds.S                      | 115 -----
 arch/um/kernel/vmlinux.lds.S                  |  91 +++-
 arch/um/nommu/Makefile                        |   1 +
 arch/um/nommu/Makefile.um                     |  18 +
 arch/um/nommu/include/asm/Kbuild              |   6 +
 arch/um/nommu/include/asm/archparam.h         |   1 +
 arch/um/nommu/include/asm/atomic.h            |  11 +
 arch/um/nommu/include/asm/atomic64.h          | 114 +++++
 arch/um/nommu/include/asm/bitsperlong.h       |  12 +
 arch/um/nommu/include/asm/byteorder.h         |   7 +
 arch/um/nommu/include/asm/cpu.h               |  16 +
 arch/um/nommu/include/asm/elf.h               |  15 +
 arch/um/nommu/include/asm/mm_context.h        |   8 +
 arch/um/nommu/include/asm/processor.h         |  46 ++
 arch/um/nommu/include/asm/ptrace.h            |  21 +
 arch/um/nommu/include/asm/sched.h             |  23 +
 arch/um/nommu/include/asm/segment.h           |   9 +
 arch/um/nommu/include/asm/syscall_wrapper.h   |  57 +++
 arch/um/nommu/include/asm/syscalls.h          |  15 +
 arch/um/nommu/include/uapi/asm/Kbuild         |   4 +
 arch/um/nommu/include/uapi/asm/bitsperlong.h  |  11 +
 arch/um/nommu/include/uapi/asm/byteorder.h    |  11 +
 arch/um/nommu/include/uapi/asm/host_ops.h     | 122 +++++
 arch/um/nommu/include/uapi/asm/sigcontext.h   |  12 +
 arch/um/nommu/include/uapi/asm/syscalls.h     | 287 +++++++++++
 arch/um/nommu/include/uapi/asm/unistd.h       |  17 +
 arch/um/nommu/um/Kconfig                      |  45 ++
 arch/um/nommu/um/Makefile                     |   4 +
 arch/um/nommu/um/bootmem.c                    |  86 ++++
 arch/um/nommu/um/console.c                    |  42 ++
 arch/um/nommu/um/cpu.c                        | 247 ++++++++++
 arch/um/nommu/um/delay.c                      |  31 ++
 arch/um/nommu/um/setup.c                      | 178 +++++++
 arch/um/nommu/um/shared/sysdep/archsetjmp.h   |  13 +
 arch/um/nommu/um/shared/sysdep/faultinfo.h    |   8 +
 .../nommu/um/shared/sysdep/kernel-offsets.h   |  12 +
 arch/um/nommu/um/shared/sysdep/mcontext.h     |   9 +
 arch/um/nommu/um/shared/sysdep/ptrace.h       |  42 ++
 arch/um/nommu/um/shared/sysdep/ptrace_user.h  |   7 +
 arch/um/nommu/um/syscalls.c                   | 199 ++++++++
 arch/um/nommu/um/threads.c                    | 261 ++++++++++
 arch/um/nommu/um/unimplemented.c              |  70 +++
 arch/um/nommu/um/user_constants.h             |  13 +
 arch/um/os-Linux/Makefile                     |  19 -
 arch/um/os-Linux/drivers/Makefile             |  13 -
 arch/um/scripts/headers_install.py            | 197 ++++++++
 arch/x86/um/Makefile                          |   2 +-
 arch/x86/um/os-Linux/Makefile                 |  13 -
 arch/x86/um/ptrace_32.c                       |   2 +-
 arch/x86/um/syscalls_64.c                     |   2 +-
 scripts/headers_install.sh                    |   3 +
 scripts/link-vmlinux.sh                       |  42 +-
 tools/um/Makefile                             |  82 ++++
 tools/um/Targets                              |  13 +
 tools/um/include/lkl.h                        | 357 ++++++++++++++
 tools/um/include/lkl_host.h                   |  27 +
 tools/um/lib/Build                            |   7 +
 tools/um/lib/fs.c                             | 461 ++++++++++++++++++
 tools/um/lib/jmp_buf.c                        |  14 +
 tools/um/lib/jmp_buf.h                        |   8 +
 tools/um/lib/posix-host.c                     | 293 +++++++++++
 tools/um/lib/utils.c                          | 213 ++++++++
 tools/um/tests/Build                          |   2 +
 tools/um/tests/boot.c                         | 393 +++++++++++++++
 tools/um/tests/boot.sh                        |   9 +
 tools/um/tests/cla.c                          | 159 ++++++
 tools/um/tests/cla.h                          |  33 ++
 tools/um/tests/disk.c                         | 168 +++++++
 tools/um/tests/disk.sh                        |  70 +++
 tools/um/tests/run.py                         | 174 +++++++
 tools/um/tests/tap13.py                       | 209 ++++++++
 tools/um/tests/test.c                         | 126 +++++
 tools/um/tests/test.h                         |  72 +++
 tools/um/tests/test.sh                        | 181 +++++++
 tools/um/uml/Build                            |  57 +++
 tools/um/uml/drivers/Build                    |  10 +
 .../um/uml}/drivers/ethertap_user.c           |   0
 .../um/uml}/drivers/tuntap_user.c             |   0
 {arch/um/os-Linux => tools/um/uml}/elf_aux.c  |   0
 {arch/um/os-Linux => tools/um/uml}/execvp.c   |   4 -
 {arch/um/os-Linux => tools/um/uml}/file.c     |   0
 {arch/um/os-Linux => tools/um/uml}/helper.c   |   0
 {arch/um/os-Linux => tools/um/uml}/irq.c      |   0
 {arch/um/os-Linux => tools/um/uml}/main.c     |   0
 {arch/um/os-Linux => tools/um/uml}/mem.c      |   0
 tools/um/uml/nommu/Build                      |   1 +
 tools/um/uml/nommu/registers.c                |  21 +
 tools/um/uml/nommu/unimplemented.c            |  21 +
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
 .../um/os-Linux => tools/um/uml}/user_syms.c  |   1 +
 {arch/um/os-Linux => tools/um/uml}/util.c     |  26 +
 tools/um/uml/x86/Build                        |  11 +
 .../os-Linux => tools/um/uml/x86}/mcontext.c  |   0
 .../um/os-Linux => tools/um/uml/x86}/prctl.c  |   0
 .../os-Linux => tools/um/uml/x86}/registers.c |   0
 .../os-Linux => tools/um/uml/x86}/task_size.c |   0
 .../um/os-Linux => tools/um/uml/x86}/tls.c    |   0
 134 files changed, 5846 insertions(+), 523 deletions(-)
 rename arch/um/{os-Linux => }/drivers/ethertap_kern.c (100%)
 rename arch/um/{os-Linux => }/drivers/tuntap_kern.c (100%)
 delete mode 100644 arch/um/include/asm/common.lds.S
 create mode 100644 arch/um/include/asm/host_ops.h
 rename arch/um/{os-Linux/drivers => include/shared}/etap.h (100%)
 rename arch/um/{os-Linux/drivers => include/shared}/tuntap.h (100%)
 create mode 100644 arch/um/include/uapi/asm/Kbuild
 delete mode 100644 arch/um/kernel/dyn.lds.S
 delete mode 100644 arch/um/kernel/uml.lds.S
 create mode 100644 arch/um/nommu/Makefile
 create mode 100644 arch/um/nommu/Makefile.um
 create mode 100644 arch/um/nommu/include/asm/Kbuild
 create mode 100644 arch/um/nommu/include/asm/archparam.h
 create mode 100644 arch/um/nommu/include/asm/atomic.h
 create mode 100644 arch/um/nommu/include/asm/atomic64.h
 create mode 100644 arch/um/nommu/include/asm/bitsperlong.h
 create mode 100644 arch/um/nommu/include/asm/byteorder.h
 create mode 100644 arch/um/nommu/include/asm/cpu.h
 create mode 100644 arch/um/nommu/include/asm/elf.h
 create mode 100644 arch/um/nommu/include/asm/mm_context.h
 create mode 100644 arch/um/nommu/include/asm/processor.h
 create mode 100644 arch/um/nommu/include/asm/ptrace.h
 create mode 100644 arch/um/nommu/include/asm/sched.h
 create mode 100644 arch/um/nommu/include/asm/segment.h
 create mode 100644 arch/um/nommu/include/asm/syscall_wrapper.h
 create mode 100644 arch/um/nommu/include/asm/syscalls.h
 create mode 100644 arch/um/nommu/include/uapi/asm/Kbuild
 create mode 100644 arch/um/nommu/include/uapi/asm/bitsperlong.h
 create mode 100644 arch/um/nommu/include/uapi/asm/byteorder.h
 create mode 100644 arch/um/nommu/include/uapi/asm/host_ops.h
 create mode 100644 arch/um/nommu/include/uapi/asm/sigcontext.h
 create mode 100644 arch/um/nommu/include/uapi/asm/syscalls.h
 create mode 100644 arch/um/nommu/include/uapi/asm/unistd.h
 create mode 100644 arch/um/nommu/um/Kconfig
 create mode 100644 arch/um/nommu/um/Makefile
 create mode 100644 arch/um/nommu/um/bootmem.c
 create mode 100644 arch/um/nommu/um/console.c
 create mode 100644 arch/um/nommu/um/cpu.c
 create mode 100644 arch/um/nommu/um/delay.c
 create mode 100644 arch/um/nommu/um/setup.c
 create mode 100644 arch/um/nommu/um/shared/sysdep/archsetjmp.h
 create mode 100644 arch/um/nommu/um/shared/sysdep/faultinfo.h
 create mode 100644 arch/um/nommu/um/shared/sysdep/kernel-offsets.h
 create mode 100644 arch/um/nommu/um/shared/sysdep/mcontext.h
 create mode 100644 arch/um/nommu/um/shared/sysdep/ptrace.h
 create mode 100644 arch/um/nommu/um/shared/sysdep/ptrace_user.h
 create mode 100644 arch/um/nommu/um/syscalls.c
 create mode 100644 arch/um/nommu/um/threads.c
 create mode 100644 arch/um/nommu/um/unimplemented.c
 create mode 100644 arch/um/nommu/um/user_constants.h
 delete mode 100644 arch/um/os-Linux/Makefile
 delete mode 100644 arch/um/os-Linux/drivers/Makefile
 create mode 100755 arch/um/scripts/headers_install.py
 delete mode 100644 arch/x86/um/os-Linux/Makefile
 create mode 100644 tools/um/Makefile
 create mode 100644 tools/um/Targets
 create mode 100644 tools/um/include/lkl.h
 create mode 100644 tools/um/include/lkl_host.h
 create mode 100644 tools/um/lib/Build
 create mode 100644 tools/um/lib/fs.c
 create mode 100644 tools/um/lib/jmp_buf.c
 create mode 100644 tools/um/lib/jmp_buf.h
 create mode 100644 tools/um/lib/posix-host.c
 create mode 100644 tools/um/lib/utils.c
 create mode 100644 tools/um/tests/Build
 create mode 100644 tools/um/tests/boot.c
 create mode 100755 tools/um/tests/boot.sh
 create mode 100644 tools/um/tests/cla.c
 create mode 100644 tools/um/tests/cla.h
 create mode 100644 tools/um/tests/disk.c
 create mode 100755 tools/um/tests/disk.sh
 create mode 100755 tools/um/tests/run.py
 create mode 100644 tools/um/tests/tap13.py
 create mode 100644 tools/um/tests/test.c
 create mode 100644 tools/um/tests/test.h
 create mode 100644 tools/um/tests/test.sh
 create mode 100644 tools/um/uml/Build
 create mode 100644 tools/um/uml/drivers/Build
 rename {arch/um/os-Linux => tools/um/uml}/drivers/ethertap_user.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/drivers/tuntap_user.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/elf_aux.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/execvp.c (98%)
 rename {arch/um/os-Linux => tools/um/uml}/file.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/helper.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/irq.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/main.c (100%)
 rename {arch/um/os-Linux => tools/um/uml}/mem.c (100%)
 create mode 100644 tools/um/uml/nommu/Build
 create mode 100644 tools/um/uml/nommu/registers.c
 create mode 100644 tools/um/uml/nommu/unimplemented.c
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
 rename {arch/um/os-Linux => tools/um/uml}/user_syms.c (99%)
 rename {arch/um/os-Linux => tools/um/uml}/util.c (89%)
 create mode 100644 tools/um/uml/x86/Build
 rename {arch/x86/um/os-Linux => tools/um/uml/x86}/mcontext.c (100%)
 rename {arch/x86/um/os-Linux => tools/um/uml/x86}/prctl.c (100%)
 rename {arch/x86/um/os-Linux => tools/um/uml/x86}/registers.c (100%)
 rename {arch/x86/um/os-Linux => tools/um/uml/x86}/task_size.c (100%)
 rename {arch/x86/um/os-Linux => tools/um/uml/x86}/tls.c (100%)

-- 
2.21.0 (Apple Git-122.2)

