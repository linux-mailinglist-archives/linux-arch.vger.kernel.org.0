Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6082A660CA9
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jan 2023 07:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjAGGZi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 7 Jan 2023 01:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjAGGZh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 7 Jan 2023 01:25:37 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B72669BA;
        Fri,  6 Jan 2023 22:25:35 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id jn22so3922893plb.13;
        Fri, 06 Jan 2023 22:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9I9FUCKmX9nkV6+/A438eiwX+2D9JXqs+q6SgJ5Jvbc=;
        b=De9Ip9VyUNuClk2I63TYF05h/4/yfXtwNnurA/6JW7cjk3EAhGh6iOojjwoAxWOhRF
         gz8GVjCcOWCVlf3bUVZMjyb5//7Dd5ree1p6+c+8hHc/SglQ3Frv//AfGHItgOgQohsE
         BBtZXEs7qhB/F9w8dcU5Qt4zXhSH1FhiGFq31gtzYsXvCM97O/ZwSrza58seb2dM2SQG
         k6tvHMFMLdh7bnCEeIgoSIuHvvRpXT+wFQG36nY+asWkAr55IzSAFQNRbDb9nyBn2PNk
         khk0lRZALmwAEfRVuYpwtbdItXqfHh36/22hKoXsI4cfmW4I/VEqJG+RjKNOTiouyfcV
         gByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9I9FUCKmX9nkV6+/A438eiwX+2D9JXqs+q6SgJ5Jvbc=;
        b=XbvIVGN6Bx8srYEk7sRuulIxwpNsyj8bkMTAKKCiqPRBuE9d2olWlnuXgBEoxX7XxK
         yxm/R6rRkmu7YHLMHLbCxpsacMbUHDz5uP19hL65hBqKwe1i/9ltUedTtUhTHFfbwbIB
         LUk+X7mArIhbdmxxNvhAaOaNg9qIBeKbcL6FnvNWnGkJW3815/4qkjC1UJhaDFzlUmrq
         f546k1wpaW9sDCMkHY28WSSkeCmo83ptituB5wiV20Yv9uPIe6yReSQ6VYepCsoClg8R
         ngMUb/qdfPmI94LtnDFr7Q6jRJxUy8TBxI6wMWSSU4ti1gl8n7x2In83vNQKJ7BeFJdD
         RMqw==
X-Gm-Message-State: AFqh2krBERqDXXhzn2UDMce/abXAM8FIm+LV/Ner9SYhv4S2ZM3k+uDq
        ROS/qF8m8YARQSyXVpp2HsWbKgT0qkeGQGm3tcA=
X-Google-Smtp-Source: AMrXdXspUyEJNzpdUTFCijDY3pi/wJONoLW92mY7TzpekHwUhEWdrd7tU5fpp+o47GlhNRpENXgnGMzcNAhSJWbz+dE=
X-Received: by 2002:a17:90b:1112:b0:223:dd6f:13b2 with SMTP id
 gi18-20020a17090b111200b00223dd6f13b2mr4153961pjb.56.1673072735034; Fri, 06
 Jan 2023 22:25:35 -0800 (PST)
MIME-Version: 1.0
References: <20230103164359.24347-1-ysionneau@kalray.eu>
In-Reply-To: <20230103164359.24347-1-ysionneau@kalray.eu>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Sat, 7 Jan 2023 14:25:23 +0800
Message-ID: <CAEr6+ECRh_9App18zmcS6FUR81YYhR=n4kGdeZAtQBsdMB55_A@mail.gmail.com>
Subject: Re: [RFC PATCH 00/25] Upstream kvx Linux port
To:     Yann Sionneau <ysionneau@kalray.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, bpf@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        devicetree@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
        Eric Paris <eparis@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jason Baron <jbaron@akamai.com>, Jiri Olsa <jolsa@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Kieran Bingham <kbingham@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-audit@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-perf-users@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-riscv@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Piggin <npiggin@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Moore <paul@paul-moore.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, Alex Michon <amichon@kalray.eu>,
        Ashley Lesdalons <alesdalons@kalray.eu>,
        Benjamin Mugnier <mugnier.benjamin@gmail.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Guillaume Missonnier <gmissonnier@kalray.eu>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Jean-Christophe Pince <jcpince@gmail.com>,
        Jonathan Borne <jborne@kalray.eu>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Julian Vetter <jvetter@kalray.eu>,
        Julien Hascoet <jhascoet@kalray.eu>,
        Julien Villette <jvillette@kalray.eu>,
        Louis Morhet <lmorhet@kalray.eu>,
        Luc Michel <lmichel@kalray.eu>,
        =?UTF-8?Q?Marc_Poulhi=C3=A8s?= <dkm@kataplop.net>,
        Marius Gligor <mgligor@kalray.eu>,
        Samuel Jones <sjones@kalray.eu>,
        Thomas Costis <tcostis@kalray.eu>,
        Vincent Chardon <vincent.chardon@elsys-design.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On Wed, Jan 4, 2023 at 1:01 AM Yann Sionneau <ysionneau@kalray.eu> wrote:
>
> This patch series adds support for the kv3-1 CPU architecture of the kvx =
family
> found in the Coolidge (aka MPPA3-80) SoC of Kalray.
>
> This is an RFC, since kvx support is not yet upstreamed into gcc/binutils=
,
> therefore this patch series cannot be merged into Linux for now.
>
> The goal is to have preliminary reviews and to fix problems early.
>
> The Kalray VLIW processor family (kvx) has the following features:
> * 32/64 bits execution mode
> * 6-issue VLIW architecture
> * 64 x 64bits general purpose registers
> * SIMD instructions
> * little-endian
> * deep learning co-processor
>
> Kalray kv3-1 core which is the third of the kvx family is embedded in Kal=
ray
> Coolidge SoC currently used on K200 and K200-LP boards.
>
> The Coolidge SoC contains 5 clusters each of which is made of:
> * 4MiB of on-chip memory (SMEM)
> * 1 dedicated safety/security core (kv3-1 core).
> * 16 PEs (Processing Elements) (kv3-1 cores).
> * 16 Co-processors (one per PE)
> * 2 Crypto accelerators
>
> The Coolidge SoC contains the following features:
> * 5 Clusters
> * 2 100G Ethernet controllers
> * 8 PCIe GEN4 controllers (Root Complex and Endpoint capable)
> * 2 USB 2.0 controllers
> * 1 Octal SPI-NOR flash controller
> * 1 eMMC controller
> * 3 Quad SPI controllers
> * 6 UART
> * 5 I2C controllers (3 of which are SMBus capable)
> * 4 CAN controllers
> * 1 OTP memory
>
> A kvx toolchain can be built using:
> # install dependencies: texinfo bison flex libgmp-dev libmpc-dev libmpfr-=
dev
> $ git clone https://github.com/kalray/build-scripts
> $ cd build-scripts
> $ source last.refs
> $ ./build-kvx-xgcc.sh output

I would like to build the kvx-xgcc to compile and test the linux
kernel, but it reported a compile error.
I wonder what version of gcc you are using.

My build environment:
VERSION=3D"20.04.2 LTS (Focal Fossa)"
gcc version 9.3.0 (Ubuntu 9.3.0-17ubuntu1~20.04)


Compile error:
$ ./build-kvx-xgcc.sh output

../../binutils/libiberty/fibheap.c: In function =E2=80=98fibheap_replace_ke=
y_data=E2=80=99:
../../binutils/libiberty/fibheap.c:38:24: error: =E2=80=98LONG_MIN=E2=80=99=
 undeclared
(first use in this function)
   38 | #define FIBHEAPKEY_MIN LONG_MIN
      |                        ^~~~~~~~
../../binutils/libiberty/fibheap.c:220:30: note: in expansion of macro
=E2=80=98FIBHEAPKEY_MIN=E2=80=99
  220 |   if (okey =3D=3D key && okey !=3D FIBHEAPKEY_MIN)
      |                              ^~~~~~~~~~~~~~
../../binutils/libiberty/fibheap.c:36:1: note: =E2=80=98LONG_MIN=E2=80=99 i=
s defined
in header =E2=80=98<limits.h>=E2=80=99; did you forget to =E2=80=98#include=
 <limits.h>=E2=80=99?
   35 | #include "fibheap.h"
  +++ |+#include <limits.h>
   36 |
../../binutils/libiberty/fibheap.c:38:24: note: each undeclared
identifier is reported only once for each function it appears in
   38 | #define FIBHEAPKEY_MIN LONG_MIN
      |                        ^~~~~~~~
../../binutils/libiberty/fibheap.c:220:30: note: in expansion of macro
=E2=80=98FIBHEAPKEY_MIN=E2=80=99
  220 |   if (okey =3D=3D key && okey !=3D FIBHEAPKEY_MIN)
      |                              ^~~~~~~~~~~~~~
../../binutils/libiberty/fibheap.c: In function =E2=80=98fibheap_delete_nod=
e=E2=80=99:
../../binutils/libiberty/fibheap.c:38:24: error: =E2=80=98LONG_MIN=E2=80=99=
 undeclared
(first use in this function)
   38 | #define FIBHEAPKEY_MIN LONG_MIN
      |                        ^~~~~~~~
../../binutils/libiberty/fibheap.c:261:36: note: in expansion of macro
=E2=80=98FIBHEAPKEY_MIN=E2=80=99
  261 |   fibheap_replace_key (heap, node, FIBHEAPKEY_MIN);
      |                                    ^~~~~~~~~~~~~~
../../binutils/libiberty/fibheap.c:38:24: note: =E2=80=98LONG_MIN=E2=80=99 =
is defined
in header =E2=80=98<limits.h>=E2=80=99; did you forget to =E2=80=98#include=
 <limits.h>=E2=80=99?
   38 | #define FIBHEAPKEY_MIN LONG_MIN
      |                        ^~~~~~~~
../../binutils/libiberty/fibheap.c:261:36: note: in expansion of macro
=E2=80=98FIBHEAPKEY_MIN=E2=80=99
  261 |   fibheap_replace_key (heap, node, FIBHEAPKEY_MIN);
      |                                    ^~~~~~~~~~~~~~


> The kvx toolchain will be installed in the "output" directory.
>
> A buildroot image (kernel+rootfs) and toolchain can be built using:
> $ git clone -b coolidge-for-upstream https://github.com/kalray/buildroot
> $ cd buildroot
> $ make O=3Dbuild_kvx kvx_defconfig
> $ make O=3Dbuild_kvx
>
> The vmlinux image can be found in buildroot/build_kvx/images/vmlinux.
>
> If you are just interested in building the Linux kernel with no rootfs yo=
u can
> just do this with the kvx-elf- toolchain:
> $ make ARCH=3Dkvx O=3Dbuild_kvx CROSS_COMPILE=3Dkvx-elf- default_defconfi=
g
> $ make ARCH=3Dkvx O=3Dbuild_kvx CROSS_COMPILE=3Dkvx-elf- -j$(($(nproc) + =
1))
>
> The vmlinux ELF can be run with qemu by doing:
> # install dependencies: ninja pkg-config libglib-2.0-dev cmake libfdt-dev=
 libpixman-1-dev zlib1g-dev
> $ git clone https://github.com/kalray/qemu-builder
> $ cd qemu-builder
> $ git submodule update --init
> $ make -j$(($(nproc) + 1))
> $ ./qemu-system-kvx -m 1024 -nographic -kernel <path/to/vmlinux>
>
> Yann Sionneau (25):
>   Documentation: kvx: Add basic documentation
>   kvx: Add ELF-related definitions
>   kvx: Add build infrastructure
>   kvx: Add CPU definition headers
>   kvx: Add atomic/locking headers
>   kvx: Add other common headers
>   kvx: Add boot and setup routines
>   kvx: Add exception/interrupt handling
>   kvx: irqchip: Add support for irq controllers
>   kvx: Add process management
>   kvx: Add memory management
>   kvx: Add system call support
>   kvx: Add signal handling support
>   kvx: Add ELF relocations and module support
>   kvx: Add misc common routines
>   kvx: Add some library functions
>   kvx: Add multi-processor (SMP) support
>   kvx: Add kvx default config file
>   kvx: power: scall poweroff driver
>   kvx: gdb: add kvx related gdb helpers
>   kvx: Add support for ftrace
>   kvx: Add support for jump labels
>   kvx: Add debugging related support
>   kvx: Add support for CPU Perf Monitors
>   kvx: Add support for cpuinfo
>
>  .../kalray,kvx-core-intc.txt                  |   22 +
>  .../devicetree/bindings/perf/kalray-pm.txt    |   21 +
>  Documentation/kvx/kvx-exceptions.txt          |  246 +
>  Documentation/kvx/kvx-iommu.txt               |  183 +
>  Documentation/kvx/kvx-mmu.txt                 |  272 +
>  Documentation/kvx/kvx-smp.txt                 |   36 +
>  Documentation/kvx/kvx.txt                     |  268 +
>  arch/kvx/Kconfig                              |  249 +
>  arch/kvx/Kconfig.debug                        |   70 +
>  arch/kvx/Makefile                             |   52 +
>  arch/kvx/configs/default_defconfig            |  130 +
>  arch/kvx/include/asm/Kbuild                   |   20 +
>  arch/kvx/include/asm/asm-prototypes.h         |   14 +
>  arch/kvx/include/asm/atomic.h                 |  104 +
>  arch/kvx/include/asm/barrier.h                |   15 +
>  arch/kvx/include/asm/bitops.h                 |  207 +
>  arch/kvx/include/asm/bitrev.h                 |   32 +
>  arch/kvx/include/asm/break_hook.h             |   69 +
>  arch/kvx/include/asm/bug.h                    |   67 +
>  arch/kvx/include/asm/cache.h                  |   46 +
>  arch/kvx/include/asm/cacheflush.h             |  181 +
>  arch/kvx/include/asm/clocksource.h            |   17 +
>  arch/kvx/include/asm/cmpxchg.h                |  185 +
>  arch/kvx/include/asm/current.h                |   22 +
>  arch/kvx/include/asm/dame.h                   |   31 +
>  arch/kvx/include/asm/debug.h                  |   35 +
>  arch/kvx/include/asm/elf.h                    |  155 +
>  arch/kvx/include/asm/fixmap.h                 |   47 +
>  arch/kvx/include/asm/ftrace.h                 |   41 +
>  arch/kvx/include/asm/futex.h                  |  141 +
>  arch/kvx/include/asm/hardirq.h                |   14 +
>  arch/kvx/include/asm/hugetlb.h                |   36 +
>  arch/kvx/include/asm/hw_breakpoint.h          |   72 +
>  arch/kvx/include/asm/hw_irq.h                 |   14 +
>  arch/kvx/include/asm/insns.h                  |   16 +
>  arch/kvx/include/asm/insns_defs.h             |  197 +
>  arch/kvx/include/asm/io.h                     |   34 +
>  arch/kvx/include/asm/ipi.h                    |   16 +
>  arch/kvx/include/asm/irqflags.h               |   58 +
>  arch/kvx/include/asm/jump_label.h             |   59 +
>  arch/kvx/include/asm/l2_cache.h               |   75 +
>  arch/kvx/include/asm/l2_cache_defs.h          |   64 +
>  arch/kvx/include/asm/linkage.h                |   13 +
>  arch/kvx/include/asm/mem_map.h                |   44 +
>  arch/kvx/include/asm/mmu.h                    |  296 +
>  arch/kvx/include/asm/mmu_context.h            |  156 +
>  arch/kvx/include/asm/mmu_stats.h              |   38 +
>  arch/kvx/include/asm/page.h                   |  187 +
>  arch/kvx/include/asm/page_size.h              |   29 +
>  arch/kvx/include/asm/pci.h                    |   36 +
>  arch/kvx/include/asm/perf_event.h             |   90 +
>  arch/kvx/include/asm/pgalloc.h                |  101 +
>  arch/kvx/include/asm/pgtable-bits.h           |  102 +
>  arch/kvx/include/asm/pgtable.h                |  451 ++
>  arch/kvx/include/asm/privilege.h              |  211 +
>  arch/kvx/include/asm/processor.h              |  176 +
>  arch/kvx/include/asm/ptrace.h                 |  217 +
>  arch/kvx/include/asm/pwr_ctrl.h               |   45 +
>  arch/kvx/include/asm/rm_fw.h                  |   16 +
>  arch/kvx/include/asm/sections.h               |   18 +
>  arch/kvx/include/asm/setup.h                  |   29 +
>  arch/kvx/include/asm/sfr.h                    |  107 +
>  arch/kvx/include/asm/sfr_defs.h               | 5028 +++++++++++++++++
>  arch/kvx/include/asm/smp.h                    |   42 +
>  arch/kvx/include/asm/sparsemem.h              |   15 +
>  arch/kvx/include/asm/spinlock.h               |   16 +
>  arch/kvx/include/asm/spinlock_types.h         |   17 +
>  arch/kvx/include/asm/stackprotector.h         |   47 +
>  arch/kvx/include/asm/stacktrace.h             |   44 +
>  arch/kvx/include/asm/string.h                 |   20 +
>  arch/kvx/include/asm/swab.h                   |   48 +
>  arch/kvx/include/asm/switch_to.h              |   21 +
>  arch/kvx/include/asm/symbols.h                |   16 +
>  arch/kvx/include/asm/sys_arch.h               |   51 +
>  arch/kvx/include/asm/syscall.h                |   73 +
>  arch/kvx/include/asm/syscalls.h               |   21 +
>  arch/kvx/include/asm/thread_info.h            |   78 +
>  arch/kvx/include/asm/timex.h                  |   20 +
>  arch/kvx/include/asm/tlb.h                    |   24 +
>  arch/kvx/include/asm/tlb_defs.h               |  131 +
>  arch/kvx/include/asm/tlbflush.h               |   58 +
>  arch/kvx/include/asm/traps.h                  |   76 +
>  arch/kvx/include/asm/types.h                  |   12 +
>  arch/kvx/include/asm/uaccess.h                |  324 ++
>  arch/kvx/include/asm/unistd.h                 |   11 +
>  arch/kvx/include/asm/vermagic.h               |   12 +
>  arch/kvx/include/asm/vmalloc.h                |   10 +
>  arch/kvx/include/uapi/asm/Kbuild              |    1 +
>  arch/kvx/include/uapi/asm/bitsperlong.h       |   14 +
>  arch/kvx/include/uapi/asm/byteorder.h         |   12 +
>  arch/kvx/include/uapi/asm/cachectl.h          |   25 +
>  arch/kvx/include/uapi/asm/ptrace.h            |  114 +
>  arch/kvx/include/uapi/asm/sigcontext.h        |   16 +
>  arch/kvx/include/uapi/asm/unistd.h            |   16 +
>  arch/kvx/kernel/Makefile                      |   27 +
>  arch/kvx/kernel/asm-offsets.c                 |  157 +
>  arch/kvx/kernel/break_hook.c                  |   77 +
>  arch/kvx/kernel/common.c                      |   11 +
>  arch/kvx/kernel/cpuinfo.c                     |   96 +
>  arch/kvx/kernel/dame_handler.c                |  113 +
>  arch/kvx/kernel/debug.c                       |   64 +
>  arch/kvx/kernel/entry.S                       | 1759 ++++++
>  arch/kvx/kernel/ftrace.c                      |  339 ++
>  arch/kvx/kernel/head.S                        |  612 ++
>  arch/kvx/kernel/hw_breakpoint.c               |  556 ++
>  arch/kvx/kernel/insns.c                       |  146 +
>  arch/kvx/kernel/io.c                          |   96 +
>  arch/kvx/kernel/irq.c                         |   78 +
>  arch/kvx/kernel/jump_label.c                  |   34 +
>  arch/kvx/kernel/kvx_ksyms.c                   |   29 +
>  arch/kvx/kernel/l2_cache.c                    |  448 ++
>  arch/kvx/kernel/mcount.S                      |  340 ++
>  arch/kvx/kernel/module.c                      |  148 +
>  arch/kvx/kernel/perf_event.c                  |  609 ++
>  arch/kvx/kernel/process.c                     |  212 +
>  arch/kvx/kernel/prom.c                        |   24 +
>  arch/kvx/kernel/ptrace.c                      |  461 ++
>  arch/kvx/kernel/reset.c                       |   37 +
>  arch/kvx/kernel/return_address.c              |   55 +
>  arch/kvx/kernel/setup.c                       |  178 +
>  arch/kvx/kernel/signal.c                      |  266 +
>  arch/kvx/kernel/smp.c                         |  110 +
>  arch/kvx/kernel/smpboot.c                     |  127 +
>  arch/kvx/kernel/stacktrace.c                  |  173 +
>  arch/kvx/kernel/sys_kvx.c                     |   58 +
>  arch/kvx/kernel/syscall_table.c               |   19 +
>  arch/kvx/kernel/time.c                        |  242 +
>  arch/kvx/kernel/traps.c                       |  243 +
>  arch/kvx/kernel/vdso.c                        |   87 +
>  arch/kvx/kernel/vmlinux.lds.S                 |  173 +
>  arch/kvx/lib/Makefile                         |    6 +
>  arch/kvx/lib/clear_page.S                     |   40 +
>  arch/kvx/lib/copy_page.S                      |   90 +
>  arch/kvx/lib/delay.c                          |   39 +
>  arch/kvx/lib/memcpy.c                         |   70 +
>  arch/kvx/lib/memset.S                         |  351 ++
>  arch/kvx/lib/strlen.S                         |  122 +
>  arch/kvx/lib/usercopy.S                       |   90 +
>  arch/kvx/mm/Makefile                          |   10 +
>  arch/kvx/mm/cacheflush.c                      |  154 +
>  arch/kvx/mm/dma-mapping.c                     |   95 +
>  arch/kvx/mm/extable.c                         |   24 +
>  arch/kvx/mm/fault.c                           |  264 +
>  arch/kvx/mm/hugetlbpage.c                     |  317 ++
>  arch/kvx/mm/init.c                            |  527 ++
>  arch/kvx/mm/kernel_rwx.c                      |  228 +
>  arch/kvx/mm/mmap.c                            |   31 +
>  arch/kvx/mm/mmu.c                             |  204 +
>  arch/kvx/mm/mmu_stats.c                       |   94 +
>  arch/kvx/mm/tlb.c                             |  433 ++
>  arch/kvx/platform/Makefile                    |    7 +
>  arch/kvx/platform/ipi.c                       |  110 +
>  arch/kvx/platform/pwr_ctrl.c                  |   93 +
>  drivers/irqchip/Kconfig                       |   27 +
>  drivers/irqchip/Makefile                      |    4 +
>  drivers/irqchip/irq-kvx-apic-gic.c            |  349 ++
>  drivers/irqchip/irq-kvx-apic-mailbox.c        |  465 ++
>  drivers/irqchip/irq-kvx-core-intc.c           |   82 +
>  drivers/irqchip/irq-kvx-itgen.c               |  224 +
>  drivers/power/reset/kvx-scall-poweroff.c      |   53 +
>  include/linux/cpuhotplug.h                    |    2 +
>  include/linux/irqchip/irq-kvx-apic-gic.h      |   21 +
>  include/linux/irqchip/irq-kvx-apic-mailbox.h  |   29 +
>  include/linux/irqchip/irq-kvx-itgen.h         |   24 +
>  include/uapi/linux/audit.h                    |    1 +
>  include/uapi/linux/elf-em.h                   |    1 +
>  include/uapi/linux/elf.h                      |    1 +
>  scripts/gdb/arch/Makefile                     |   11 +
>  scripts/gdb/arch/__init__.py                  |    1 +
>  scripts/gdb/arch/kvx/Makefile                 |   25 +
>  scripts/gdb/arch/kvx/__init__.py              |    1 +
>  scripts/gdb/arch/kvx/constants.py.in          |   74 +
>  scripts/gdb/arch/kvx/mmu.py                   |  199 +
>  scripts/gdb/arch/kvx/page_table_walk.py       |  207 +
>  tools/include/uapi/asm/bitsperlong.h          |    2 +
>  175 files changed, 25814 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controlle=
r/kalray,kvx-core-intc.txt
>  create mode 100644 Documentation/devicetree/bindings/perf/kalray-pm.txt
>  create mode 100644 Documentation/kvx/kvx-exceptions.txt
>  create mode 100644 Documentation/kvx/kvx-iommu.txt
>  create mode 100644 Documentation/kvx/kvx-mmu.txt
>  create mode 100644 Documentation/kvx/kvx-smp.txt
>  create mode 100644 Documentation/kvx/kvx.txt
>  create mode 100644 arch/kvx/Kconfig
>  create mode 100644 arch/kvx/Kconfig.debug
>  create mode 100644 arch/kvx/Makefile
>  create mode 100644 arch/kvx/configs/default_defconfig
>  create mode 100644 arch/kvx/include/asm/Kbuild
>  create mode 100644 arch/kvx/include/asm/asm-prototypes.h
>  create mode 100644 arch/kvx/include/asm/atomic.h
>  create mode 100644 arch/kvx/include/asm/barrier.h
>  create mode 100644 arch/kvx/include/asm/bitops.h
>  create mode 100644 arch/kvx/include/asm/bitrev.h
>  create mode 100644 arch/kvx/include/asm/break_hook.h
>  create mode 100644 arch/kvx/include/asm/bug.h
>  create mode 100644 arch/kvx/include/asm/cache.h
>  create mode 100644 arch/kvx/include/asm/cacheflush.h
>  create mode 100644 arch/kvx/include/asm/clocksource.h
>  create mode 100644 arch/kvx/include/asm/cmpxchg.h
>  create mode 100644 arch/kvx/include/asm/current.h
>  create mode 100644 arch/kvx/include/asm/dame.h
>  create mode 100644 arch/kvx/include/asm/debug.h
>  create mode 100644 arch/kvx/include/asm/elf.h
>  create mode 100644 arch/kvx/include/asm/fixmap.h
>  create mode 100644 arch/kvx/include/asm/ftrace.h
>  create mode 100644 arch/kvx/include/asm/futex.h
>  create mode 100644 arch/kvx/include/asm/hardirq.h
>  create mode 100644 arch/kvx/include/asm/hugetlb.h
>  create mode 100644 arch/kvx/include/asm/hw_breakpoint.h
>  create mode 100644 arch/kvx/include/asm/hw_irq.h
>  create mode 100644 arch/kvx/include/asm/insns.h
>  create mode 100644 arch/kvx/include/asm/insns_defs.h
>  create mode 100644 arch/kvx/include/asm/io.h
>  create mode 100644 arch/kvx/include/asm/ipi.h
>  create mode 100644 arch/kvx/include/asm/irqflags.h
>  create mode 100644 arch/kvx/include/asm/jump_label.h
>  create mode 100644 arch/kvx/include/asm/l2_cache.h
>  create mode 100644 arch/kvx/include/asm/l2_cache_defs.h
>  create mode 100644 arch/kvx/include/asm/linkage.h
>  create mode 100644 arch/kvx/include/asm/mem_map.h
>  create mode 100644 arch/kvx/include/asm/mmu.h
>  create mode 100644 arch/kvx/include/asm/mmu_context.h
>  create mode 100644 arch/kvx/include/asm/mmu_stats.h
>  create mode 100644 arch/kvx/include/asm/page.h
>  create mode 100644 arch/kvx/include/asm/page_size.h
>  create mode 100644 arch/kvx/include/asm/pci.h
>  create mode 100644 arch/kvx/include/asm/perf_event.h
>  create mode 100644 arch/kvx/include/asm/pgalloc.h
>  create mode 100644 arch/kvx/include/asm/pgtable-bits.h
>  create mode 100644 arch/kvx/include/asm/pgtable.h
>  create mode 100644 arch/kvx/include/asm/privilege.h
>  create mode 100644 arch/kvx/include/asm/processor.h
>  create mode 100644 arch/kvx/include/asm/ptrace.h
>  create mode 100644 arch/kvx/include/asm/pwr_ctrl.h
>  create mode 100644 arch/kvx/include/asm/rm_fw.h
>  create mode 100644 arch/kvx/include/asm/sections.h
>  create mode 100644 arch/kvx/include/asm/setup.h
>  create mode 100644 arch/kvx/include/asm/sfr.h
>  create mode 100644 arch/kvx/include/asm/sfr_defs.h
>  create mode 100644 arch/kvx/include/asm/smp.h
>  create mode 100644 arch/kvx/include/asm/sparsemem.h
>  create mode 100644 arch/kvx/include/asm/spinlock.h
>  create mode 100644 arch/kvx/include/asm/spinlock_types.h
>  create mode 100644 arch/kvx/include/asm/stackprotector.h
>  create mode 100644 arch/kvx/include/asm/stacktrace.h
>  create mode 100644 arch/kvx/include/asm/string.h
>  create mode 100644 arch/kvx/include/asm/swab.h
>  create mode 100644 arch/kvx/include/asm/switch_to.h
>  create mode 100644 arch/kvx/include/asm/symbols.h
>  create mode 100644 arch/kvx/include/asm/sys_arch.h
>  create mode 100644 arch/kvx/include/asm/syscall.h
>  create mode 100644 arch/kvx/include/asm/syscalls.h
>  create mode 100644 arch/kvx/include/asm/thread_info.h
>  create mode 100644 arch/kvx/include/asm/timex.h
>  create mode 100644 arch/kvx/include/asm/tlb.h
>  create mode 100644 arch/kvx/include/asm/tlb_defs.h
>  create mode 100644 arch/kvx/include/asm/tlbflush.h
>  create mode 100644 arch/kvx/include/asm/traps.h
>  create mode 100644 arch/kvx/include/asm/types.h
>  create mode 100644 arch/kvx/include/asm/uaccess.h
>  create mode 100644 arch/kvx/include/asm/unistd.h
>  create mode 100644 arch/kvx/include/asm/vermagic.h
>  create mode 100644 arch/kvx/include/asm/vmalloc.h
>  create mode 100644 arch/kvx/include/uapi/asm/Kbuild
>  create mode 100644 arch/kvx/include/uapi/asm/bitsperlong.h
>  create mode 100644 arch/kvx/include/uapi/asm/byteorder.h
>  create mode 100644 arch/kvx/include/uapi/asm/cachectl.h
>  create mode 100644 arch/kvx/include/uapi/asm/ptrace.h
>  create mode 100644 arch/kvx/include/uapi/asm/sigcontext.h
>  create mode 100644 arch/kvx/include/uapi/asm/unistd.h
>  create mode 100644 arch/kvx/kernel/Makefile
>  create mode 100644 arch/kvx/kernel/asm-offsets.c
>  create mode 100644 arch/kvx/kernel/break_hook.c
>  create mode 100644 arch/kvx/kernel/common.c
>  create mode 100644 arch/kvx/kernel/cpuinfo.c
>  create mode 100644 arch/kvx/kernel/dame_handler.c
>  create mode 100644 arch/kvx/kernel/debug.c
>  create mode 100644 arch/kvx/kernel/entry.S
>  create mode 100644 arch/kvx/kernel/ftrace.c
>  create mode 100644 arch/kvx/kernel/head.S
>  create mode 100644 arch/kvx/kernel/hw_breakpoint.c
>  create mode 100644 arch/kvx/kernel/insns.c
>  create mode 100644 arch/kvx/kernel/io.c
>  create mode 100644 arch/kvx/kernel/irq.c
>  create mode 100644 arch/kvx/kernel/jump_label.c
>  create mode 100644 arch/kvx/kernel/kvx_ksyms.c
>  create mode 100644 arch/kvx/kernel/l2_cache.c
>  create mode 100644 arch/kvx/kernel/mcount.S
>  create mode 100644 arch/kvx/kernel/module.c
>  create mode 100644 arch/kvx/kernel/perf_event.c
>  create mode 100644 arch/kvx/kernel/process.c
>  create mode 100644 arch/kvx/kernel/prom.c
>  create mode 100644 arch/kvx/kernel/ptrace.c
>  create mode 100644 arch/kvx/kernel/reset.c
>  create mode 100644 arch/kvx/kernel/return_address.c
>  create mode 100644 arch/kvx/kernel/setup.c
>  create mode 100644 arch/kvx/kernel/signal.c
>  create mode 100644 arch/kvx/kernel/smp.c
>  create mode 100644 arch/kvx/kernel/smpboot.c
>  create mode 100644 arch/kvx/kernel/stacktrace.c
>  create mode 100644 arch/kvx/kernel/sys_kvx.c
>  create mode 100644 arch/kvx/kernel/syscall_table.c
>  create mode 100644 arch/kvx/kernel/time.c
>  create mode 100644 arch/kvx/kernel/traps.c
>  create mode 100644 arch/kvx/kernel/vdso.c
>  create mode 100644 arch/kvx/kernel/vmlinux.lds.S
>  create mode 100644 arch/kvx/lib/Makefile
>  create mode 100644 arch/kvx/lib/clear_page.S
>  create mode 100644 arch/kvx/lib/copy_page.S
>  create mode 100644 arch/kvx/lib/delay.c
>  create mode 100644 arch/kvx/lib/memcpy.c
>  create mode 100644 arch/kvx/lib/memset.S
>  create mode 100644 arch/kvx/lib/strlen.S
>  create mode 100644 arch/kvx/lib/usercopy.S
>  create mode 100644 arch/kvx/mm/Makefile
>  create mode 100644 arch/kvx/mm/cacheflush.c
>  create mode 100644 arch/kvx/mm/dma-mapping.c
>  create mode 100644 arch/kvx/mm/extable.c
>  create mode 100644 arch/kvx/mm/fault.c
>  create mode 100644 arch/kvx/mm/hugetlbpage.c
>  create mode 100644 arch/kvx/mm/init.c
>  create mode 100644 arch/kvx/mm/kernel_rwx.c
>  create mode 100644 arch/kvx/mm/mmap.c
>  create mode 100644 arch/kvx/mm/mmu.c
>  create mode 100644 arch/kvx/mm/mmu_stats.c
>  create mode 100644 arch/kvx/mm/tlb.c
>  create mode 100644 arch/kvx/platform/Makefile
>  create mode 100644 arch/kvx/platform/ipi.c
>  create mode 100644 arch/kvx/platform/pwr_ctrl.c
>  create mode 100644 drivers/irqchip/irq-kvx-apic-gic.c
>  create mode 100644 drivers/irqchip/irq-kvx-apic-mailbox.c
>  create mode 100644 drivers/irqchip/irq-kvx-core-intc.c
>  create mode 100644 drivers/irqchip/irq-kvx-itgen.c
>  create mode 100644 drivers/power/reset/kvx-scall-poweroff.c
>  create mode 100644 include/linux/irqchip/irq-kvx-apic-gic.h
>  create mode 100644 include/linux/irqchip/irq-kvx-apic-mailbox.h
>  create mode 100644 include/linux/irqchip/irq-kvx-itgen.h
>  create mode 100644 scripts/gdb/arch/Makefile
>  create mode 100644 scripts/gdb/arch/__init__.py
>  create mode 100644 scripts/gdb/arch/kvx/Makefile
>  create mode 100644 scripts/gdb/arch/kvx/__init__.py
>  create mode 100644 scripts/gdb/arch/kvx/constants.py.in
>  create mode 100644 scripts/gdb/arch/kvx/mmu.py
>  create mode 100644 scripts/gdb/arch/kvx/page_table_walk.py
>
> --
> 2.37.2
>
>
>
>
>


--=20
Thanks,
JeffXie
