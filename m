Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24B4AF43E2
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2019 10:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbfKHJvS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Nov 2019 04:51:18 -0500
Received: from ivanoab7.miniserver.com ([37.128.132.42]:57534 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731032AbfKHJvS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2019 04:51:18 -0500
X-Greylist: delayed 2279 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Nov 2019 04:51:17 EST
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1iT0KR-0000jV-5C; Fri, 08 Nov 2019 09:13:16 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1iT0KN-0004tC-Vw; Fri, 08 Nov 2019 09:13:14 +0000
Subject: Re: [RFC v2 00/37] Unifying LKL into UML
To:     Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Akira Moroo <retrage01@gmail.com>
References: <cover.1571798507.git.thehajime@gmail.com>
 <cover.1573179553.git.thehajime@gmail.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <a4d1cb5c-04cd-b6c3-bc96-c5ef08bbcffe@cambridgegreys.com>
Date:   Fri, 8 Nov 2019 09:13:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cover.1573179553.git.thehajime@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 08/11/2019 05:02, Hajime Tazaki wrote:
> This RFC patchset is to ask opinions from folks, whether LKL codes is good
> to integrate into UML code base.  We wish to have any kind of feedback from
> your kind reviews.  There are numbers of commits which should be asked for
> reviews to other mailing lists; we will do it later once we got discussed
> in this mailing list.
> 
> # sorry for the long list of patches: we can make it smaller by only
>    including basic set of LKL (e.g., removing foreign OS support, etc) if
>    you wish.
> 
> 
> rfc v2:
> - use UMMODE instead of SUBARCH to switch UML or LKL
> - tools/lkl directory is still there. I confirmed we can move under arch/um
>    (e.g., arch/um/lkl/hosts).  I will move it IF this is preferable.
> - drop several patches involved non-uml directory
> - drop several patches which are not required
> - refine commit logs
> - document updated
> 
> 
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
> 2. Share common parts of implementation between UML and LKL.
> 3. Reimplement UML features with LKL API (if we wish)
> 
> For the step 1, we put LKL as one of UMMODE in order to make less effort to
> integrate (make ARCH=um UMMODE=library).  The modification to existing UML
> code is trying to be minimized.
> 
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
> 
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
>    um: irq: Fix LAST_IRQ usage in init_IRQ() (2019-09-16 08:38:58 +0200)
> 
> are available in the Git repository at:
> 
>    git://github.com/thehajime/linux 61b15bfb52c7f1f066685c90a1cfe8346b3faec9
>    https://github.com/thehajime/linux/tree/upstream-to-uml-5.5-rc1-v2
> 
> Andreas Abel (1):
>    kallsyms: Add a config option to select section for kallsyms
> 
> Hajime Tazaki (6):
>    lkl: add system call hijack support
>    scripts: revert CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX patches
>    lkl: Android ARM (arm/arm64) support
>    um lkl: add CI tests
>    um: use lkl virtio_net_tap device as UML device
>    um: add lkl virtio-blk device
> 
> Octavian Purdila (29):
>    asm-generic: atomic64: allow using generic atomic64 on 64bit platforms
>    arch: add __SYSCALL_DEFINE_ARCH
>    lkl: architecture skeleton for Linux kernel library
>    lkl: host interface
>    lkl: memory handling
>    lkl: kernel threads support
>    lkl: interrupt support
>    lkl: system call interface and application API
>    lkl: timers, time and delay support
>    lkl: memory mapped I/O support
>    lkl: basic kernel console support
>    lkl: initialization and cleanup
>    lkl: plug in the build system
>    lkl tools: skeleton for host side library, tests and tools
>    lkl tools: host lib: add utilities functions
>    lkl tools: host lib: memory mapped I/O helpers
>    lkl tools: host lib: virtio devices
>    lkl tools: host lib: virtio block device
>    lkl tools: host lib: filesystem helpers
>    lkl tools: host lib: posix host operations
>    lkl tools: "boot" test
>    lkl tools: tool that reads/writes to/from a filesystem image
>    lkl tools: tool that converts a filesystem image to tar
>    lkl tools: virtio: add network device support
>    checkpatch: avoid showing BIT_ULL warnings for tools/ files
>    lkl tools: add lklfuse
>    lkl: add documentation
>    lkl: add support for Windows hosts
>    lkl tools: add support for Windows host
> 
> Thomas Liebetraut (1):
>    tools: Add the lkl host library to the common tools Makefile
> 
>   .circleci/config.yml                       | 276 ++++++
>   Documentation/virt/uml/lkl.txt             | 453 ++++++++++
>   MAINTAINERS                                |   8 +
>   Makefile                                   |   4 +-
>   arch/Kconfig                               |   6 +
>   arch/um/Kconfig                            |  32 +-
>   arch/um/Makefile                           | 151 +---
>   arch/um/Makefile.um                        | 152 ++++
>   arch/um/configs/x86_64_defconfig           |   6 +
>   arch/um/include/asm/Kbuild                 |   1 +
>   arch/um/include/asm/io.h                   |   4 +
>   arch/um/kernel/syscall.c                   |  53 ++
>   arch/um/lkl/.gitignore                     |   2 +
>   arch/um/lkl/Kconfig                        |  91 ++
>   arch/um/lkl/Kconfig.debug                  |   0
>   arch/um/lkl/Makefile                       |  69 ++
>   arch/um/lkl/auto.conf                      |   1 +
>   arch/um/lkl/configs/lkl_defconfig          |  91 ++
>   arch/um/lkl/include/asm/Kbuild             |  80 ++
>   arch/um/lkl/include/asm/bitsperlong.h      |  11 +
>   arch/um/lkl/include/asm/byteorder.h        |   7 +
>   arch/um/lkl/include/asm/cpu.h              |  14 +
>   arch/um/lkl/include/asm/elf.h              |  15 +
>   arch/um/lkl/include/asm/host_ops.h         |  10 +
>   arch/um/lkl/include/asm/io.h               | 104 +++
>   arch/um/lkl/include/asm/irq.h              |  15 +
>   arch/um/lkl/include/asm/mutex.h            |   7 +
>   arch/um/lkl/include/asm/page.h             |  14 +
>   arch/um/lkl/include/asm/pgtable.h          |  62 ++
>   arch/um/lkl/include/asm/processor.h        |  60 ++
>   arch/um/lkl/include/asm/ptrace.h           |  25 +
>   arch/um/lkl/include/asm/sched.h            |  23 +
>   arch/um/lkl/include/asm/setup.h            |   7 +
>   arch/um/lkl/include/asm/syscalls.h         |  18 +
>   arch/um/lkl/include/asm/syscalls_32.h      |  43 +
>   arch/um/lkl/include/asm/thread_info.h      |  70 ++
>   arch/um/lkl/include/asm/tlb.h              |  12 +
>   arch/um/lkl/include/asm/uaccess.h          |  64 ++
>   arch/um/lkl/include/asm/unistd.h           |  29 +
>   arch/um/lkl/include/asm/unistd_32.h        |  31 +
>   arch/um/lkl/include/asm/vmlinux.lds.h      |  14 +
>   arch/um/lkl/include/asm/xor.h              |   9 +
>   arch/um/lkl/include/system/stdarg.h        |   2 +
>   arch/um/lkl/include/uapi/asm/Kbuild        |   9 +
>   arch/um/lkl/include/uapi/asm/bitsperlong.h |  13 +
>   arch/um/lkl/include/uapi/asm/byteorder.h   |  11 +
>   arch/um/lkl/include/uapi/asm/host_ops.h    | 153 ++++
>   arch/um/lkl/include/uapi/asm/irq.h         |  36 +
>   arch/um/lkl/include/uapi/asm/sigcontext.h  |  16 +
>   arch/um/lkl/include/uapi/asm/siginfo.h     |  11 +
>   arch/um/lkl/include/uapi/asm/swab.h        |  11 +
>   arch/um/lkl/include/uapi/asm/syscalls.h    | 348 ++++++++
>   arch/um/lkl/include/uapi/asm/unistd.h      |  18 +
>   arch/um/lkl/kernel/Makefile                |   4 +
>   arch/um/lkl/kernel/asm-offsets.c           |   2 +
>   arch/um/lkl/kernel/console.c               |  42 +
>   arch/um/lkl/kernel/cpu.c                   | 223 +++++
>   arch/um/lkl/kernel/irq.c                   | 193 +++++
>   arch/um/lkl/kernel/misc.c                  |  60 ++
>   arch/um/lkl/kernel/setup.c                 | 193 +++++
>   arch/um/lkl/kernel/syscalls.c              | 246 ++++++
>   arch/um/lkl/kernel/syscalls_32.c           | 159 ++++
>   arch/um/lkl/kernel/threads.c               | 227 +++++
>   arch/um/lkl/kernel/time.c                  | 145 ++++
>   arch/um/lkl/kernel/vmlinux.lds.S           |  51 ++
>   arch/um/lkl/mm/Makefile                    |   1 +
>   arch/um/lkl/mm/bootmem.c                   |  66 ++
>   arch/um/lkl/scripts/headers_install.py     | 195 +++++
>   arch/um/os-Linux/Makefile                  |   5 +
>   arch/um/os-Linux/lkl_dev.c                 | 188 +++++
>   certs/system_certificates.S                |  16 +-
>   include/asm-generic/atomic64.h             |   2 +
>   include/asm-generic/export.h               |  34 +-
>   include/asm-generic/vmlinux.lds.h          | 279 ++++---
>   include/linux/compiler_attributes.h        |   4 +
>   include/linux/export.h                     |  23 +-
>   include/linux/linkage.h                    |  12 +-
>   include/linux/syscalls.h                   |   6 +
>   init/Kconfig                               |  12 +
>   lib/.gitignore                             |   2 +
>   lib/raid6/.gitignore                       |   1 +
>   scripts/.gitignore                         |   2 +
>   scripts/Makefile.build                     |   9 +-
>   scripts/adjust_autoksyms.sh                |   6 +
>   scripts/basic/.gitignore                   |   1 +
>   scripts/checkpatch.pl                      |  13 +-
>   scripts/depmod.sh                          |  25 +-
>   scripts/genksyms/genksyms.c                |  11 +-
>   scripts/kallsyms.c                         |  54 +-
>   scripts/kconfig/.gitignore                 |   1 +
>   scripts/link-vmlinux.sh                    |  10 +
>   scripts/mod/.gitignore                     |   1 +
>   scripts/mod/modpost.c                      |  30 +-
>   tools/Makefile                             |  11 +-
>   tools/lkl/.gitignore                       |  15 +
>   tools/lkl/Build                            |   6 +
>   tools/lkl/Makefile                         | 130 +++
>   tools/lkl/Makefile.autoconf                | 114 +++
>   tools/lkl/Targets                          |  25 +
>   tools/lkl/bin/lkl-hijack.sh                |  23 +
>   tools/lkl/cptofs.c                         | 635 ++++++++++++++
>   tools/lkl/fs2tar.c                         | 410 +++++++++
>   tools/lkl/include/.gitignore               |   1 +
>   tools/lkl/include/lkl.h                    | 928 +++++++++++++++++++++
>   tools/lkl/include/lkl_config.h             |  61 ++
>   tools/lkl/include/lkl_host.h               | 160 ++++
>   tools/lkl/include/mingw32/sys/socket.h     |   4 +
>   tools/lkl/lib/.gitignore                   |   3 +
>   tools/lkl/lib/Build                        |  26 +
>   tools/lkl/lib/Makefile                     |  33 +
>   tools/lkl/lib/config.c                     | 793 ++++++++++++++++++
>   tools/lkl/lib/dbg.c                        | 300 +++++++
>   tools/lkl/lib/dbg_handler.c                |  44 +
>   tools/lkl/lib/endian.h                     |  31 +
>   tools/lkl/lib/fs.c                         | 433 ++++++++++
>   tools/lkl/lib/hijack/Build                 |   4 +
>   tools/lkl/lib/hijack/hijack.c              | 620 ++++++++++++++
>   tools/lkl/lib/hijack/init.c                | 252 ++++++
>   tools/lkl/lib/hijack/init.h                |   8 +
>   tools/lkl/lib/hijack/xlate.c               | 613 ++++++++++++++
>   tools/lkl/lib/hijack/xlate.h               |  13 +
>   tools/lkl/lib/iomem.c                      |  88 ++
>   tools/lkl/lib/iomem.h                      |  15 +
>   tools/lkl/lib/jmp_buf.c                    |  14 +
>   tools/lkl/lib/jmp_buf.h                    |   8 +
>   tools/lkl/lib/net.c                        | 818 ++++++++++++++++++
>   tools/lkl/lib/nt-host.c                    | 375 +++++++++
>   tools/lkl/lib/posix-host.c                 | 439 ++++++++++
>   tools/lkl/lib/utils.c                      | 266 ++++++
>   tools/lkl/lib/virtio.c                     | 644 ++++++++++++++
>   tools/lkl/lib/virtio.h                     | 115 +++
>   tools/lkl/lib/virtio_blk.c                 | 132 +++
>   tools/lkl/lib/virtio_net.c                 | 345 ++++++++
>   tools/lkl/lib/virtio_net_dpdk.c            | 480 +++++++++++
>   tools/lkl/lib/virtio_net_fd.c              | 195 +++++
>   tools/lkl/lib/virtio_net_fd.h              |  50 ++
>   tools/lkl/lib/virtio_net_macvtap.c         |  32 +
>   tools/lkl/lib/virtio_net_pipe.c            |  76 ++
>   tools/lkl/lib/virtio_net_raw.c             |  94 +++
>   tools/lkl/lib/virtio_net_tap.c             | 111 +++
>   tools/lkl/lib/virtio_net_vde.c             | 168 ++++
>   tools/lkl/lklfuse.c                        | 658 +++++++++++++++
>   tools/lkl/scripts/checkpatch.sh            |  60 ++
>   tools/lkl/scripts/lkl-jenkins.sh           |  21 +
>   tools/lkl/tests/Build                      |   3 +
>   tools/lkl/tests/boot.c                     | 562 +++++++++++++
>   tools/lkl/tests/boot.sh                    |   9 +
>   tools/lkl/tests/cla.c                      | 159 ++++
>   tools/lkl/tests/cla.h                      |  33 +
>   tools/lkl/tests/disk.c                     | 189 +++++
>   tools/lkl/tests/disk.sh                    |  70 ++
>   tools/lkl/tests/hijack-test.sh             | 760 +++++++++++++++++
>   tools/lkl/tests/lklfuse.sh                 | 110 +++
>   tools/lkl/tests/net-setup.sh               | 134 +++
>   tools/lkl/tests/net-test.c                 | 317 +++++++
>   tools/lkl/tests/net.sh                     | 186 +++++
>   tools/lkl/tests/run.py                     | 182 ++++
>   tools/lkl/tests/run_netperf.sh             |  98 +++
>   tools/lkl/tests/tap13.py                   | 209 +++++
>   tools/lkl/tests/test.c                     | 126 +++
>   tools/lkl/tests/test.h                     |  72 ++
>   tools/lkl/tests/test.sh                    | 240 ++++++
>   tools/lkl/tests/valgrind.supp              |  85 ++
>   tools/lkl/tests/valgrind2xunit.py          |  69 ++
>   usr/initramfs_data.S                       |   4 +-
>   165 files changed, 19489 insertions(+), 354 deletions(-)
>   create mode 100644 .circleci/config.yml
>   create mode 100644 Documentation/virt/uml/lkl.txt
>   create mode 100644 arch/um/Makefile.um
>   create mode 100644 arch/um/lkl/.gitignore
>   create mode 100644 arch/um/lkl/Kconfig
>   create mode 100644 arch/um/lkl/Kconfig.debug
>   create mode 100644 arch/um/lkl/Makefile
>   create mode 100644 arch/um/lkl/auto.conf
>   create mode 100644 arch/um/lkl/configs/lkl_defconfig
>   create mode 100644 arch/um/lkl/include/asm/Kbuild
>   create mode 100644 arch/um/lkl/include/asm/bitsperlong.h
>   create mode 100644 arch/um/lkl/include/asm/byteorder.h
>   create mode 100644 arch/um/lkl/include/asm/cpu.h
>   create mode 100644 arch/um/lkl/include/asm/elf.h
>   create mode 100644 arch/um/lkl/include/asm/host_ops.h
>   create mode 100644 arch/um/lkl/include/asm/io.h
>   create mode 100644 arch/um/lkl/include/asm/irq.h
>   create mode 100644 arch/um/lkl/include/asm/mutex.h
>   create mode 100644 arch/um/lkl/include/asm/page.h
>   create mode 100644 arch/um/lkl/include/asm/pgtable.h
>   create mode 100644 arch/um/lkl/include/asm/processor.h
>   create mode 100644 arch/um/lkl/include/asm/ptrace.h
>   create mode 100644 arch/um/lkl/include/asm/sched.h
>   create mode 100644 arch/um/lkl/include/asm/setup.h
>   create mode 100644 arch/um/lkl/include/asm/syscalls.h
>   create mode 100644 arch/um/lkl/include/asm/syscalls_32.h
>   create mode 100644 arch/um/lkl/include/asm/thread_info.h
>   create mode 100644 arch/um/lkl/include/asm/tlb.h
>   create mode 100644 arch/um/lkl/include/asm/uaccess.h
>   create mode 100644 arch/um/lkl/include/asm/unistd.h
>   create mode 100644 arch/um/lkl/include/asm/unistd_32.h
>   create mode 100644 arch/um/lkl/include/asm/vmlinux.lds.h
>   create mode 100644 arch/um/lkl/include/asm/xor.h
>   create mode 100644 arch/um/lkl/include/system/stdarg.h
>   create mode 100644 arch/um/lkl/include/uapi/asm/Kbuild
>   create mode 100644 arch/um/lkl/include/uapi/asm/bitsperlong.h
>   create mode 100644 arch/um/lkl/include/uapi/asm/byteorder.h
>   create mode 100644 arch/um/lkl/include/uapi/asm/host_ops.h
>   create mode 100644 arch/um/lkl/include/uapi/asm/irq.h
>   create mode 100644 arch/um/lkl/include/uapi/asm/sigcontext.h
>   create mode 100644 arch/um/lkl/include/uapi/asm/siginfo.h
>   create mode 100644 arch/um/lkl/include/uapi/asm/swab.h
>   create mode 100644 arch/um/lkl/include/uapi/asm/syscalls.h
>   create mode 100644 arch/um/lkl/include/uapi/asm/unistd.h
>   create mode 100644 arch/um/lkl/kernel/Makefile
>   create mode 100644 arch/um/lkl/kernel/asm-offsets.c
>   create mode 100644 arch/um/lkl/kernel/console.c
>   create mode 100644 arch/um/lkl/kernel/cpu.c
>   create mode 100644 arch/um/lkl/kernel/irq.c
>   create mode 100644 arch/um/lkl/kernel/misc.c
>   create mode 100644 arch/um/lkl/kernel/setup.c
>   create mode 100644 arch/um/lkl/kernel/syscalls.c
>   create mode 100644 arch/um/lkl/kernel/syscalls_32.c
>   create mode 100644 arch/um/lkl/kernel/threads.c
>   create mode 100644 arch/um/lkl/kernel/time.c
>   create mode 100644 arch/um/lkl/kernel/vmlinux.lds.S
>   create mode 100644 arch/um/lkl/mm/Makefile
>   create mode 100644 arch/um/lkl/mm/bootmem.c
>   create mode 100755 arch/um/lkl/scripts/headers_install.py
>   create mode 100644 arch/um/os-Linux/lkl_dev.c
>   create mode 100644 tools/lkl/.gitignore
>   create mode 100644 tools/lkl/Build
>   create mode 100644 tools/lkl/Makefile
>   create mode 100644 tools/lkl/Makefile.autoconf
>   create mode 100644 tools/lkl/Targets
>   create mode 100755 tools/lkl/bin/lkl-hijack.sh
>   create mode 100644 tools/lkl/cptofs.c
>   create mode 100644 tools/lkl/fs2tar.c
>   create mode 100644 tools/lkl/include/.gitignore
>   create mode 100644 tools/lkl/include/lkl.h
>   create mode 100644 tools/lkl/include/lkl_config.h
>   create mode 100644 tools/lkl/include/lkl_host.h
>   create mode 100644 tools/lkl/include/mingw32/sys/socket.h
>   create mode 100644 tools/lkl/lib/.gitignore
>   create mode 100644 tools/lkl/lib/Build
>   create mode 100644 tools/lkl/lib/Makefile
>   create mode 100644 tools/lkl/lib/config.c
>   create mode 100644 tools/lkl/lib/dbg.c
>   create mode 100644 tools/lkl/lib/dbg_handler.c
>   create mode 100644 tools/lkl/lib/endian.h
>   create mode 100644 tools/lkl/lib/fs.c
>   create mode 100644 tools/lkl/lib/hijack/Build
>   create mode 100644 tools/lkl/lib/hijack/hijack.c
>   create mode 100644 tools/lkl/lib/hijack/init.c
>   create mode 100644 tools/lkl/lib/hijack/init.h
>   create mode 100644 tools/lkl/lib/hijack/xlate.c
>   create mode 100644 tools/lkl/lib/hijack/xlate.h
>   create mode 100644 tools/lkl/lib/iomem.c
>   create mode 100644 tools/lkl/lib/iomem.h
>   create mode 100644 tools/lkl/lib/jmp_buf.c
>   create mode 100644 tools/lkl/lib/jmp_buf.h
>   create mode 100644 tools/lkl/lib/net.c
>   create mode 100644 tools/lkl/lib/nt-host.c
>   create mode 100644 tools/lkl/lib/posix-host.c
>   create mode 100644 tools/lkl/lib/utils.c
>   create mode 100644 tools/lkl/lib/virtio.c
>   create mode 100644 tools/lkl/lib/virtio.h
>   create mode 100644 tools/lkl/lib/virtio_blk.c
>   create mode 100644 tools/lkl/lib/virtio_net.c
>   create mode 100644 tools/lkl/lib/virtio_net_dpdk.c
>   create mode 100644 tools/lkl/lib/virtio_net_fd.c
>   create mode 100644 tools/lkl/lib/virtio_net_fd.h
>   create mode 100644 tools/lkl/lib/virtio_net_macvtap.c
>   create mode 100644 tools/lkl/lib/virtio_net_pipe.c
>   create mode 100644 tools/lkl/lib/virtio_net_raw.c
>   create mode 100644 tools/lkl/lib/virtio_net_tap.c
>   create mode 100644 tools/lkl/lib/virtio_net_vde.c
>   create mode 100644 tools/lkl/lklfuse.c
>   create mode 100755 tools/lkl/scripts/checkpatch.sh
>   create mode 100755 tools/lkl/scripts/lkl-jenkins.sh
>   create mode 100644 tools/lkl/tests/Build
>   create mode 100644 tools/lkl/tests/boot.c
>   create mode 100755 tools/lkl/tests/boot.sh
>   create mode 100644 tools/lkl/tests/cla.c
>   create mode 100644 tools/lkl/tests/cla.h
>   create mode 100644 tools/lkl/tests/disk.c
>   create mode 100755 tools/lkl/tests/disk.sh
>   create mode 100755 tools/lkl/tests/hijack-test.sh
>   create mode 100755 tools/lkl/tests/lklfuse.sh
>   create mode 100644 tools/lkl/tests/net-setup.sh
>   create mode 100644 tools/lkl/tests/net-test.c
>   create mode 100755 tools/lkl/tests/net.sh
>   create mode 100755 tools/lkl/tests/run.py
>   create mode 100755 tools/lkl/tests/run_netperf.sh
>   create mode 100644 tools/lkl/tests/tap13.py
>   create mode 100644 tools/lkl/tests/test.c
>   create mode 100644 tools/lkl/tests/test.h
>   create mode 100644 tools/lkl/tests/test.sh
>   create mode 100644 tools/lkl/tests/valgrind.supp
>   create mode 100755 tools/lkl/tests/valgrind2xunit.py
> 

I am reading the patch-set and I have a recurring question as I read it. 
It applies to IRQ, mmap IO, timers, devices, etc

The question is: "What is the unerlying req to replace the existing UML 
code for the library".

F.e timers in UML have been moved to an underlying POSIX timers call now 
and that can probably work on any system that offers it. If there is 
some presentation/documentation/etc material which I can read which goes 
through the actual choices it will be very helpful.

The same question applies the other way around too. I like the hostops 
approach, we can probably adopt some of that in UML proper to make it 
more portable and easier to have alternative implementations for the 
underlying host side operations.

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
