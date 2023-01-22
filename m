Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4900C676BC4
	for <lists+linux-arch@lfdr.de>; Sun, 22 Jan 2023 10:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjAVJDH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 22 Jan 2023 04:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjAVJDG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 22 Jan 2023 04:03:06 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF25D18D;
        Sun, 22 Jan 2023 01:03:01 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id 5so3540871plo.3;
        Sun, 22 Jan 2023 01:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qo2maMGLx1uz0+zRSTh18JzfRbAiMqj0UbFWh6Xut3U=;
        b=nWqb5ocjm0nPmjnI6JlGlvv98LPIRC/qlp0xZB6ROYJmSxC9deZ77GGuiUfM0PJ76B
         i/GG33MtMjCyKYqdSBqJFJ6ZiTni8T+x/7bTttv+rCj+3WlPuKlLNeU82kimaH82/3j9
         IZOtbTr6PQ8vssuU9onvgd8P2s1SoBgtlEdheA+m9YFYJ7OzdinVMLSL95a051lOd1YF
         KzLRb4eHBU++uLdMHrNMzRNcHSjHDX3m6W0yPTaTXl+f9+4HXVUmcRFprpQmxWVI03bt
         UIERd0npsrfnfl7hHvqXDYGQSmUGSpUAEqJFjyZFydy5G1bMzBmmLjfQtfrWta4QTcQg
         8WKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qo2maMGLx1uz0+zRSTh18JzfRbAiMqj0UbFWh6Xut3U=;
        b=67Xd7ILWizuWjl5u8z8z0hjs/D1i9TQlxKEsLpcu5Ycd1CvhJYF3vy6RghWBGkCBFZ
         u0kSVTCnt9OpRSz5XRZjpQzTLpXVQYcoCKy+6l6n2+mVenkiw9aNwsWd4PN0Z4TN+ZX5
         +e/3K/8VIVlYOEgpIt0dfsKxphCcMojg7VpqqsQLXVd43r32kIcXpF5vfQSHR5JAHFeG
         gTHkqg/x7Ob5zaQ/z2I4i0aAHrClmU8QNGdwgegRTyzhZeDe0hd/f8ffE0y5BS82kPHO
         sdtyQTLtKjPvyQ/K/iFCGEm0AZs9giAfa/CpujnB6Y0FjuSjytldayG/6EhMPRfEkxLs
         Krow==
X-Gm-Message-State: AFqh2koHGwEpB/AI5/Oj5GWoo1hAftvgHH8l956+jdlIUn1k9pjY/95T
        h6eIMGRtsL5PtU5lZCFHCpg=
X-Google-Smtp-Source: AMrXdXv6IjKLPdUIYkRBAGuV2EiIN8CoKyc8EtlOCRfHc1hNtQrpryD2Y+NdaCxAH+Os7y5H9JFq8g==
X-Received: by 2002:a17:90b:2690:b0:227:21f5:8295 with SMTP id pl16-20020a17090b269000b0022721f58295mr21248782pjb.47.1674378180220;
        Sun, 22 Jan 2023 01:03:00 -0800 (PST)
Received: from debian.me (subs03-180-214-233-17.three.co.id. [180.214.233.17])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090a8f0300b00219220edf0dsm4458078pjo.48.2023.01.22.01.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 01:02:59 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 079671035FD; Sun, 22 Jan 2023 16:02:55 +0700 (WIB)
Date:   Sun, 22 Jan 2023 16:02:55 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Yann Sionneau <ysionneau@kalray.eu>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Clement Leger <clement@clement-leger.fr>,
        Vincent Chardon <vincent.chardon@elsys-design.com>,
        Marc =?utf-8?B?UG91bGhpw6hz?= <dkm@kataplop.net>,
        Julian Vetter <jvetter@kalray.eu>,
        Samuel Jones <sjones@kalray.eu>,
        Ashley Lesdalons <alesdalons@kalray.eu>,
        Thomas Costis <tcostis@kalray.eu>,
        Marius Gligor <mgligor@kalray.eu>,
        Jonathan Borne <jborne@kalray.eu>,
        Julien Villette <jvillette@kalray.eu>,
        Luc Michel <lmichel@kalray.eu>,
        Louis Morhet <lmorhet@kalray.eu>,
        Julien Hascoet <jhascoet@kalray.eu>,
        Jean-Christophe Pince <jcpince@gmail.com>,
        Guillaume Missonnier <gmissonnier@kalray.eu>,
        Alex Michon <amichon@kalray.eu>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <git@xen0n.name>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Bibo Mao <maobibo@loongson.cn>,
        Atish Patra <atishp@atishpatra.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Qi Liu <liuqi115@huawei.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Benjamin Mugnier <mugnier.benjamin@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-audit@redhat.com,
        linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH v2 01/31] Documentation: kvx: Add basic documentation
Message-ID: <Y8z7v53A/UDKFd7j@debian.me>
References: <20230120141002.2442-1-ysionneau@kalray.eu>
 <20230120141002.2442-2-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7vv3XoSTF5zTpOoA"
Content-Disposition: inline
In-Reply-To: <20230120141002.2442-2-ysionneau@kalray.eu>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--7vv3XoSTF5zTpOoA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2023 at 03:09:32PM +0100, Yann Sionneau wrote:
> Add some documentation for the kvx architecture and its Linux port.

"Document the kvx Linux port. The documentation covers design decision,
memory management, exception handling, and SMP."

>  Documentation/arch.rst               |   1 +
>  Documentation/kvx/index.rst          |  17 ++
>  Documentation/kvx/kvx-exceptions.rst | 256 ++++++++++++++++++++++++
>  Documentation/kvx/kvx-iommu.rst      | 191 ++++++++++++++++++
>  Documentation/kvx/kvx-mmu.rst        | 287 +++++++++++++++++++++++++++
>  Documentation/kvx/kvx-smp.rst        |  39 ++++
>  Documentation/kvx/kvx.rst            | 273 +++++++++++++++++++++++++
>  7 files changed, 1064 insertions(+)
>  create mode 100644 Documentation/kvx/index.rst
>  create mode 100644 Documentation/kvx/kvx-exceptions.rst
>  create mode 100644 Documentation/kvx/kvx-iommu.rst
>  create mode 100644 Documentation/kvx/kvx-mmu.rst
>  create mode 100644 Documentation/kvx/kvx-smp.rst
>  create mode 100644 Documentation/kvx/kvx.rst
>=20

The documentation reads a rather odd and unclear to me, so I have to
write the improv:

---- >8 ----
diff --git a/Documentation/kvx/kvx-exceptions.rst b/Documentation/kvx/kvx-e=
xceptions.rst
index 5e01e934192f13..efb162edadb6a0 100644
--- a/Documentation/kvx/kvx-exceptions.rst
+++ b/Documentation/kvx/kvx-exceptions.rst
@@ -1,9 +1,9 @@
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-Exceptions
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Exception handling in kvx
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 On kvx, handlers are set using ``$ev`` (exception vector) register which
-specifies a base address. An offset is added to ``$ev`` upon exception
+specifies the base address. An offset is added to ``$ev`` upon exception
 and the result is used as the new ``$pc``.
 The offset depends on which exception vector the cpu wants to jump to:
=20
@@ -35,12 +35,13 @@ Interrupts and traps are serviced similarly, ie:
=20
  - Jump to handler
  - Save all registers
- - Prepare the call (do_IRQ or trap_handler)
+ - Prepare the call (``do_IRQ`` or ``trap_handler``)
  - restore all registers
  - return from exception
=20
-entry.S file is (as for other architectures) the entry point into the kern=
el.
-It contains all assembly routines related to interrupts/traps/syscall.
+As in other architectures, ``entry.S`` file is the entry point into the
+kernel. It contains all assembly routines related to
+interrupts/traps/syscall.
=20
 Syscall handling
 ----------------
@@ -51,7 +52,7 @@ a syscall from the kernel.
=20
 Syscalls are handled differently than interrupts/exceptions. From an ABI
 point of view, syscalls are like function calls: any caller-saved register
-can be clobbered by the syscall. However, syscall parameters are passed
+can be clobberred by the syscall. However, syscall parameters are passed
 using registers r0 through r7. These registers must be preserved to avoid
 clobberring them before the actual syscall function.
=20
@@ -59,23 +60,23 @@ On syscall from userspace (``scall`` instruction), the =
processor will put
 the syscall number in $es.sn and switch from user to kernel privilege
 mode. ``kvx_syscall_handler`` will be called in kernel mode.
=20
-The following steps are then taken:
+Below is the path when executing syscall:
=20
- 1. Switch to kernel stack
- 2. Extract syscall number
- 3. If the syscall number is bogus, set the syscall function to ``sys_ni_s=
yscall``
- 4. If tracing is enabled
+ 1. Switch to kernel stack.
+ 2. Extract syscall number. If it is bogus, set the syscall function to
+    ``sys_ni_syscall``.
+ 3. If tracing is enabled:
=20
-    - Jump to ``trace_syscall_enter``
+    - Jump to ``trace_syscall_enter``.
     - Save syscall arguments (``r0`` -> ``r7``) on stack in ``pt_regs``.
     - Call ``do_trace_syscall_enter`` function.
=20
- 5. Restore syscall arguments since they have been modified by C call
- 6. Call the syscall function
- 7. Save ``$r0`` in ``pt_regs`` since it can be clobberred afterward
- 8. If tracing is enabled, call ``trace_syscall_exit``.
- 9. Call ``work_pending``
- 10. Return to user !
+ 4. Restore syscall arguments since they have been modified by C call.
+ 5. Call the syscall function.
+ 6. Save ``$r0`` in ``pt_regs`` since it can be clobberred afterward.
+ 7. If tracing is enabled, call ``trace_syscall_exit``.
+ 8. Call ``work_pending``.
+ 9. Return to user.
=20
 The trace call is handled out of the fast path. All slow path handling
 is done in another part of code to avoid messing with the cache.
@@ -84,25 +85,25 @@ Signals
 -------
=20
 Signals are handled when exiting kernel before returning to user.
-When handling a signal, the path is the following:
+When handling a signal, the execution path is:
=20
- 1. User application is executing normally
-    Then any exception happens (syscall, interrupt, trap)
- 2. The exception handling path is taken
-    and before returning to user, pending signals are checked
- 3. Signal are handled by ``do_signal``.
-    Registers are saved and a special part of the stack is modified
+ 1. User application is executing normally, then any exception happens
+    (syscall, interrupt, trap).
+ 2. The exception handling path is taken and before returning to user,
+    pending signals are checked.
+ 3. Signals are handled by ``do_signal``.
+ 4. Registers are saved and a special part of the stack is modified
     to create a trampoline to call ``rt_sigreturn``,
     ``$spc`` is modified to jump to user signal handler;
     ``$ra`` is modified to jump to sigreturn trampoline directly after
     returning from user signal handler.
- 4. User signal handler is called after ``rfe`` from exception
+ 5. User signal handler is called after ``rfe`` from exception
     when returning, ``$ra`` is retored to ``$pc``, resulting in a call
     to the syscall trampoline.
- 5. syscall trampoline is executed, leading to rt_sigreturn syscall
- 6. ``rt_sigreturn`` syscall is executed. Previous registers are restored =
to
+ 6. syscall trampoline is executed, leading to ``rt_sigreturn`` syscall.
+ 7. ``rt_sigreturn`` syscall is executed. Previous registers are restored =
to
     allow returning to user correctly.
- 7. User application is restored at the exact point it was interrupted
+ 8. User application is restored at the exact point it was interrupted
     before.
=20
 ::
@@ -170,12 +171,12 @@ When handling a signal, the path is the following:
 Registers handling
 ------------------
=20
-MMU is disabled in all exceptions paths, during register save and restorat=
ion.
-This will prevent from triggering MMU fault (such as TLB miss) which could
-clobber the current register state. Such event can occurs when RWX mode is
-enabled and the memory accessed to save register can trigger a TLB miss.
-Aside from that which is common for all exceptions path, registers are sav=
ed
-differently depending on the exception type.
+MMU is disabled in all exceptions paths, during register save and
+restoration. This will prevent triggering MMU fault (such as TLB miss)
+which could clobber the current register state. Such event can occurs when
+RWX mode is enabled and the memory accessed to save register can trigger a
+TLB miss. Aside from that which is common for all exceptions path,
+registers are saved differently depending on the exception type.
=20
 Interrupts and traps
 --------------------
@@ -196,7 +197,7 @@ saved on the stack in ``pt_regs`` before executing the =
signal handler and
 restored after that. Since only caller-saved registers have been saved bef=
ore
 checking for pending work, callee-saved registers also need to be saved to
 restore everything correctly when before returning to user.
-This path is the following (a bit more complicated !)::
+The path is (note: a rather more complicated)::
=20
         +------------+
         | Save caller|          +-----------+  Ret   +------------+
@@ -244,13 +245,13 @@ This path is the following (a bit more complicated !)=
::
 Syscalls
 --------
=20
-As explained before, for syscalls, we can use whatever callee-saved regist=
ers
-we want since syscall are seen as a "classic" call from ABI pov.
-Only different path is the one for clone. For this path, since the child e=
xpects
-to find same callee-registers content than his parent, we must save them b=
efore
-executing the clone syscall and restore them after that for the child. Thi=
s is
-done via a redefinition of __sys_clone in assembly which will be called in=
 place
-of the standard sys_clone. This new call will save callee saved registers
-in pt_regs. Parent will return using the syscall standard path. Freshly sp=
awned
-child however will be woken up via ret_from_fork which will restore all
-registers (even if caller saved are not needed).
+As explained before, for syscalls, any arbitrary callee-saved registers ca=
n be
+used since syscall are seen as a "classic" call from ABI pov. The only sys=
call
+with different path is ``clone()``. For this path, since the child expects=
 to
+find same callee-registers content from its parent, these registers must be
+saved before executing ``clone()`` and restore them after it is executed f=
or the
+child. This is done via a redefinition of ``__sys_clone`` in assembly whic=
h will
+be called in place of the standard ``__sys_clone``. This new call saves
+callee-saved registers in ``pt_regs``. The parent returns using the syscall
+standard path. Freshly spawned child however is woken up via ``ret_from_fo=
rk``
+which restores all registers (even if caller saved are not needed).
diff --git a/Documentation/kvx/kvx-iommu.rst b/Documentation/kvx/kvx-iommu.=
rst
index 240995d315ce46..cdcfa9e8e21cb4 100644
--- a/Documentation/kvx/kvx-iommu.rst
+++ b/Documentation/kvx/kvx-iommu.rst
@@ -1,41 +1,40 @@
 .. SPDX-License-Identifier: GPL-2.0
=20
-=3D=3D=3D=3D=3D
-IOMMU
-=3D=3D=3D=3D=3D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+kvx IOMMU
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 General Overview
 ----------------
=20
-To exchange data between device and users through memory, the driver
-has to  set up a buffer by doing some kernel allocation. The buffer uses
-virtual address and the physical address is obtained through the MMU.
-When the device wants to access the same physical memory space it uses
-the bus address which is obtained by using the DMA mapping API. The
-Coolidge SoC includes several IOMMUs for clusters, PCIe peripherals,
-SoC peripherals, and more; that will translate this "bus address" into
-a physical one for DMA operations.
+To exchange data between device and users through memory, the driver has t=
o  set
+up a buffer by doing some kernel allocation. The buffer uses virtual addre=
ss and
+the physical address is obtained through the MMU. When the device wants to
+access the same physical memory space it uses the bus address which is obt=
ained
+by using the DMA mapping API. The Coolidge SoC includes several IOMMUs for
+clusters, PCIe peripherals, SoC peripherals, and more; these IOMMUs will
+translate this "bus address" into the physical one for DMA operations.
=20
-Bus addresses are IOVA (I/O Virtual Address) or DMA addresses. These
-addresses can be obtained by calling the allocation functions of the DMA A=
PIs.
-It can also be obtained through classical kernel allocation of physical
-contiguous memory and then calling mapping functions of the DMA API.
+Bus addresses are IOVA (I/O Virtual Address) or DMA addresses. These addre=
sses
+can be obtained by calling the allocation functions of the DMA APIs. It ca=
n also
+be obtained through classical allocation of physical contiguous memory and=
 then
+calling mapping functions of the DMA API.
=20
-In order to be able to use the kvx IOMMU we have implemented the IOMMU DMA
-interface in arch/kvx/mm/dma-mapping.c. DMA functions are registered by
-implementing arch_setup_dma_ops() and generic IOMMU functions. Generic IOM=
MU
-are calling our specific IOMMU functions that adds or remove mappings betw=
een
-DMA addresses and physical addresses in the IOMMU TLB.
+In order to be able to use the kvx IOMMU, the necessary IOMMU DMA interfac=
e is
+implemented in ``arch/kvx/mm/dma-mapping.c``. DMA functions are registered=
 by
+implementing ``arch_setup_dma_ops()`` and generic IOMMU functions. The lat=
ter
+calls kvx-specific IOMMU functions that add or remove mappings between DMA
+addresses and physical addresses in the IOMMU TLB.
=20
-Specific IOMMU functions are defined in the kvx IOMMU driver. The kvx IOMMU
-driver manage two physical hardware IOMMU: one used for TX and one for RX.
-In the next section we described the HW IOMMUs.
+Specific IOMMU functions are defined in the kvx IOMMU driver. Thedriver ma=
nages
+two physical hardware IOMMU: one used for TX and one for RX. In the next s=
ection
+we described the hardware IOMMUs.
=20
 Cluster IOMMUs
 --------------
=20
 IOMMUs on cluster are used for DMA and cryptographic accelerators.
-There are six IOMMUs connected to the:
+There are six IOMMUs, each connected to:
=20
  - cluster DMA tx
  - cluster DMA rx
@@ -48,20 +47,18 @@ SoC peripherals IOMMUs
 ----------------------
=20
 Since SoC peripherals are connected to an AXI bus, two IOMMUs are used: on=
e for
-each AXI channel (read and write). These two IOMMUs are shared between all=
 master
-devices and DMA. These two IOMMUs will have the same entries but need to b=
e configured
-independently.
+each AXI channel (read and write). These are shared between all master dev=
ices
+and DMA. These have the same entries but need to be configured separately.
=20
 PCIe IOMMUs
 -----------
=20
-There is a slave IOMMU (read and write from the MPPA to the PCIe endpoint)
-and a master IOMMU (read and write from a PCIe endpoint to system DDR).
-The PCIe root complex and the MSI/MSI-X controller have been designed to u=
se
-the IOMMU feature when enabled. (For example for supporting endpoint that
-support only 32 bits addresses and allow them to access any memory in a
-64 bits address space). For security reason it is highly recommended to
-activate the IOMMU for PCIe.
+There is a slave IOMMU (read and write from the MPPA to the PCIe endpoint)=
 and a
+master IOMMU (read and write from a PCIe endpoint to system memory). The P=
CIe
+root complex and the MSI/MSI-X controller have been designed to use the IO=
MMU
+feature when enabled, for example for supporting endpoint that support only
+32-bit addresses and allow them to access any memory in a 64-bit address s=
pace).
+For security reason it is highly recommended to activate the IOMMU for PCI=
e.
=20
 IOMMU implementation
 --------------------
@@ -102,90 +99,88 @@ and translations that occurs between memory and device=
s::
      +--------------+
=20
=20
-There is also an IOMMU dedicated to the crypto module but this module will=
 not
-be accessed by the operating system.
+There is also an IOMMU dedicated to the crypto module but the operating sy=
stem
+doesn't access it.
=20
-We will provide one driver to manage IOMMUs RX/TX. All of them will be
-described in the device tree to be able to get their particularities. See
-the example below that describes the relation between IOMMU, DMA and NoC in
-the cluster.
+The kernel provides a driver to manage RX/TX IOMMUs. All of them is descri=
bed in
+the device tree in detail. See the example below that describes the relati=
on
+between IOMMU, DMA and NoC in the cluster.
=20
-IOMMU is related to a specific bus like PCIe we will be able to specify th=
at
-all peripherals will go through this IOMMU.
+IOMMU is related to a specific bus like PCIe, thus it is preferred to spec=
ify
+that all peripherals will go through it.
=20
 IOMMU Page table
 ~~~~~~~~~~~~~~~~
=20
-We need to be able to know which IO virtual addresses (IOVA) are mapped in=
 the
+It is necessary to know which IO virtual addresses (IOVA) are mapped in the
 TLB in order to be able to remove entries when a device finishes a transfe=
r and
 release memory. This information could be extracted when needed by computi=
ng all
 sets used by the memory and then reads all sixteen ways and compare them t=
o the
-IOVA but it won't be efficient. We also need to be able to translate an IO=
VA
-to a physical address as required by the iova_to_phys IOMMU ops that is us=
ed
-by DMA. Like previously it can be done by extracting the set from the addr=
ess
+IOVA but it won't be efficient. It is also necessary to translate an IOVA
+to a physical address as required by the ``iova_to_phys`` IOMMU ops that i=
s used
+by DMA. Again, it can be done by extracting the set from the address
 and comparing the IOVA to each sixteen entries of the given set.
=20
-A solution is to keep a page table for the IOMMU. But this method is not
-efficient for reloading an entry of the TLB without the help of an hardware
-page table. So to prevent the need of a refill we will update the TLB when=
 a
-device request access to memory and if there is no more slot available in =
the
-TLB we will just fail and the device will have to try again later. It is n=
ot
-efficient but at least we won't need to manage the refill of the TLB.
+A possible solution is to keep a page table for the IOMMU. However, this m=
ethod
+is not efficient for reloading an entry of the TLB without the help of an
+hardware page table. Thus, to prevent the need to refill the TLB is update=
d when
+a device requests access to memory and if there is no more slot available =
in the
+TLB, the request will just fail and the device will have to try again late=
r. It
+is not efficient but at least managing TLB refill can be avoided.
=20
 This limits the total amount of memory that can be used for transfer betwe=
en
-device and memory (see Limitations section below).
-To be able to manage bigger transfer we can implement the huge page table =
in
-the Linux kernel and use a page table that match the size of huge page tab=
le
-for a given IOMMU (typically the PCIe IOMMU).
+device and memory (see Limitations section below). In order to manage bigg=
er
+transfer, it is required to implement the huge page table size in the Linux
+kernel and use a page table that match the size of huge page table for a g=
iven
+IOMMU (typically the PCIe IOMMU).
=20
-As we won't refill the TLB we know that we won't have more than 128*16 ent=
ries.
-In this case we can simply keep a table with all possible entries.
+Consequently, the maximum page table entries is 128*16 (2048) and the appr=
oach
+to manage IOMMU TLB is to keep a table with all possible entries.
=20
 Maintenance interface
 ~~~~~~~~~~~~~~~~~~~~~
=20
-It is possible to have several "maintainers" for the same IOMMU. The drive=
r is
-using two of them. One that writes the TLB and another interface reads TLB=
=2E For
-debug purpose it is possible to display the content of the tlb by using the
-following command in gdb::
+It is possible to have several "maintainers" for the same IOMMU. The drive=
r uses
+two of them: one that writes the TLB and another that reads TLB. For debug=
ging
+purpose it is possible to display the TLB content in gdb by::
=20
   gdb> p kvx_iommu_dump_tlb( <iommu addr>, 0)
=20
 Since different management interface are used for read and write it is saf=
e to
-execute the above command at any moment.
+execute the above command at any time.
=20
 Interrupts
 ~~~~~~~~~~
=20
 IOMMU can have 3 kind of interrupts that corresponds to 3 different types =
of
-errors (no mapping. protection, parity). When the IOMMU is shared between
-clusters (SoC periph and PCIe) then fifteen IRQs are generated according t=
o the
+errors: no mapping, protection, and parity. When the IOMMU is shared betwe=
en
+clusters (SoC periph and PCIe), 15 IRQs are generated corresponding to the
 configuration of an association table. The association table is indexed by=
 the
-ASN number (9 bits) and the entry of the table is a subscription mask with=
 one
+ASN number (9-bit) and the entry of the table is a subscription mask with =
one
 bit per destination. Currently this is not managed by the driver.
=20
 The driver is only managing interrupts for the cluster. The mode used is t=
he
-stall one. So when an interrupt occurs it is managed by the driver. All ot=
hers
+stall one. Thus, when an interrupt occurs it is managed by the driver. All=
 other
 interrupts that occurs are stored and the IOMMU is stalled. When driver cl=
eans
-the first interrupt others will be managed one by one.
+up the first interrupt, other interrupts will be managed sequentially.
=20
 ASN (Address Space Number)
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
=20
 This is also know as ASID in some other architecture. Each device will hav=
e a
 given ASN that will be given through the device tree. As address space is
-managed at the IOMMU domain level we will use one group and one domain per=
 ID.
-ASN are coded on 9 bits.
+managed at the IOMMU domain level one group and one domain per ID is used.=
 ASNs
+are 9-bit encoded.
=20
 Device tree
 -----------
=20
-Relationships between devices, DMAs and IOMMUs are described in the
-device tree (see `Documentation/devicetree/bindings/iommu/kalray,kvx-iommu=
=2Etxt`
-for more details).
+Relationships between devices, DMAs and IOMMUs are described in the device=
 tree
+(see ``Documentation/devicetree/bindings/iommu/kalray,kvx-iommu.txt`` for
+details).
=20
 Limitations
 -----------
=20
-Only supporting 4KB page size will limit the size of mapped memory to 8MB
-because the IOMMU TLB can have at most 128*16 entries.
+Since the kernel only supports 4KB page size, the size of mapped memory is
+limited to 8MB because the IOMMU TLB can have at most 128*16 (2048) entrie=
s.
diff --git a/Documentation/kvx/kvx-mmu.rst b/Documentation/kvx/kvx-mmu.rst
index b7186331396c09..ea40acad9969bd 100644
--- a/Documentation/kvx/kvx-mmu.rst
+++ b/Documentation/kvx/kvx-mmu.rst
@@ -1,29 +1,29 @@
 .. SPDX-License-Identifier: GPL-2.0
=20
-=3D=3D=3D
-MMU
-=3D=3D=3D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
+kvx Memory Management Unit
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
=20
-Virtual addresses are on 41 bits for kvx when using 64-bit mode.
-To differentiate kernel from user space, we use the high order bit
-(bit 40). When bit 40 is set, then the higher remaining bits must also be
-set to 1. The virtual address must be extended with 1 when the bit 40 is s=
et,
-if not the address must be zero extended. Bit 40 is set for kernel space
-mappings and not set for user space mappings.
+Virtual addresses are on 41 bits for kvx when using 64-bit mode. To
+differentiate kernel from user space, the high order bit (bit 40) is used.=
 When
+it is set, the higher remaining bits must also be set to 1. The virtual ad=
dress
+must be extended by 1 when the bit 40 is set, otherwise the address must be
+zero extended. Bit 40 is set for kernelspace mappings and not set for user=
space
+mappings.
=20
 Memory Map
 ----------
=20
 In Linux physical memories are arranged into banks according to the cost o=
f an
-access in term of distance to a memory. As we are UMA architecture we only=
 have
-one bank and thus one node.
+access in term of distance to a memory. As kvx is an UMA architecture ther=
e is
+only one bank and thus one node.
=20
 A node is divided into several kind of zone. For example if DMA can only a=
ccess
-a specific area in the physical memory we will define a ZONE_DMA for this =
purpose.
-In our case we are considering that DMA can access all DDR so we don't hav=
e a specific
-zone for this. On 64 bit architecture all DDR can be mapped in virtual ker=
nel space
-so there is no need for a ZONE_HIGHMEM. That means that in our case there =
is
-only one ZONE_NORMAL. This will be updated if DMA cannot access all memory.
+a specific area in the physical memory, the region is called ``ZONE_DMA``.=
 In
+kvx we assume that DMA can access all memory so we don't have a specific z=
one
+for this purpose. On 64-bit architecture all memory can be mapped in virtu=
al
+kernel space so ``ZONE_HIGHMEM`` is unnecessary. This implies that there is
+only ``ZONE_NORMAL``. This can change if DMA cannot access all memory.
=20
 Currently, the memory mapping is the following for 4KB page:
=20
@@ -42,96 +42,97 @@ Currently, the memory mapping is the following for 4KB =
page:
 Enable the MMU
 --------------
=20
-All kernel functions and symbols are in virtual memory except for kvx_star=
t()
-function which is loaded at 0x0 in physical memory.
-To be able to switch from physical addresses to virtual addresses we choos=
e to
+All kernel functions and symbols are in virtual memory except for
+``kvx_start()`` function which is loaded at 0x0 in physical memory.  To be=
 able
+to switch from physical addresses to virtual addresses, the decision is to
 setup the TLB at the very beginning of the boot process to be able to map =
both
-pieces of code. For this we added two entries in the LTLB. The first one,
-LTLB[0], contains the mapping between virtual memory and DDR. Its size is =
512MB.
-The second entry, LTLB[1], contains a flat mapping of the first 2MB of the=
 SMEM.
-Once those two entries are present we can enable the MMU. LTLB[1] will be
-removed during paging_init() because once we are really running in virtual=
 space
-it will not be used anymore.
-In order to access more than 512MB DDR memory, the remaining memory (> 512=
MB) is
-refill using a comparison in kernel_perf_refill that does not walk the ker=
nel
-page table, thus having a faster refill time for kernel. These entries are
-inserted into the LTLB for easier computation (4 LTLB entries). The drawba=
ck of
-this approach is that mapped entries are using RWX protection attributes,
-leading to no protection at all.
+pieces of code. For this purpose, two LTLB entries are added. The first on=
e,
+LTLB[0], contains the mapping between virtual and physical memory. Its siz=
e is
+512MB.  The second pme, LTLB[1], contains a flat mapping of the first 2MB =
of
+the SMEM.  Once those two entries are present the MMU can be enabled. LTLB=
[1]
+will be removed during ``paging_init()`` because once the kernel is runnin=
g in
+virtual memory space it will not be used anymore.  In order to access more=
 than
+512MB of physical memory, the remaining memory (> 512MB) is refilled using=
 a
+comparison in ``kernel_perf_refill`` that does not walk the kernel page ta=
ble,
+thus having a faster kernel refill time. These entries are inserted into t=
he
+LTLB for easier computation (4 LTLB entries). The drawback of this approac=
h is
+that mapped entries are using RWX protection attributes, leading to no
+protection at all and anything can happen.
=20
 Kernel strict RWX
 -----------------
=20
-``CONFIG_STRICT_KERNEL_RWX`` is enabled by default in defconfig.
-Once booted, if ``CONFIG_STRICT_KERNEL_RWX`` is enable, the kernel text an=
d memory
-will be mapped in the init_mm page table. Once mapped, the refill routine =
for
-the kernel is patched to always do a page table walk, bypassing the faster
-comparison but enforcing page protection attributes when refilling.
-Finally, the LTLB[0] entry is replaced by a 4K one, mapping only exception=
s with
-RX protection. It allows us to never trigger nomapping on nomapping refill
-routine which would (obviously) not work... Once this is done, we can flus=
h the
-4 LTLB entries for kernel refill in order to be sure there is no stalled
+``CONFIG_STRICT_KERNEL_RWX`` is enabled by default in defconfig. Once the
+kernel is booted, if the aforementioned configuration is enabled, the kern=
el
+text and memory will be mapped in the ``init_mm`` page table. Once mapped,=
 the
+refill routine for the kernel is patched to always walk the page table,
+bypassing the faster comparison but enforcing page protection attributes w=
hen
+refilling. Finally, the LTLB[0] entry is replaced by a 4K one, mapping only
+read-only (RX) exceptions. It allows us to never trigger nomapping on noma=
pping
+refill routine which would (obviously) not work. Once this is done, 4 LTLB
+entries can be flused for kernel refill in order to be sure there is no st=
alled
 entries and that new entries inserted in JTLB will apply.
=20
 By default, the following policy is applied on vmlinux sections:
=20
  - init_data: RW
- - init_text: RX (or RWX if parameter rodata=3Doff)
- - text: RX (or RWX if parameter rodata=3Doff)
+ - init_text: RX (or RWX if ``rodata=3Doff`` parameter is specified)
+ - text: RX (or RWX if ``rodata=3Doff`` is specified)
  - rodata: RW before init, RO after init
  - sdata: RW
=20
-Kernel RWX mode can then be switched on/off using /sys/kvx/kernel_rwx file.
+Kernel RWX mode can then be switched on/off with ``/sys/kvx/kernel_rwx``.
=20
 Privilege Level
 ---------------
=20
-Since we are using privilege levels on kvx, we make use of the virtual
-spaces to be in the same space as the user. The kernel will have the
+Since kvx uses privilege levels, the virtual memory space is leveraged so =
that
+the kernel memory space is same as userspace. The kernel will have the
 $ps.mmup set in kernel (PL1) and unset for user (PL2).
-As said in kvx documentation, we have two cases when the kernel is
-booted:
+As mentioned in :doc:`kvx`, there are two cases when the kernel is booted:
=20
- - Either we have been booted by someone (bootloader, hypervisor, etc)
- - Or we are alone (boot from flash)
+ - Boot via intermediaries (bootloader, hypervisor, etc)
+ - Direct boot from flash.
=20
-In both cases, we will use the virtual space 0. Indeed, if we are alone
-on the core, then it means nobody is using the MMU and we can take the
-first virtual space. If not alone, then when writing an entry to the tlb
-using writetlb instruction, the hypervisor will catch it and change the
+In both cases, the virtual space 0 is used. Indeed, if there is only the k=
ernel
+running on the core, nothing else is using the MMU and the first virtual s=
pace
+can be used directly by the kernel. Otherwise, when writing an entry to th=
e tlb
+using ``writetlb`` instruction, the hypervisor will catch it and change the
 virtual space accordingly.
=20
 Memblock
 =3D=3D=3D=3D=3D=3D=3D=3D
=20
 When the kernel starts there is no memory allocator available. One of the =
first
-step in the kernel is to detect the amount of DDR available by getting this
-information in the device tree and initialize the low-level "memblock" all=
ocator.
+step in the kernel is to detect the amount of available memory by gathering
+this information from the device tree and initialize the low-level "memblo=
ck"
+allocator.
=20
-We start by reserving memory for the whole kernel. For instance with a dev=
ice
-tree containing 512MB of DDR you could see the following boot messages::
+memblock initialization starts by reserving memory for the whole kernel. F=
or
+instance, with a device tree containing 512MB RAM device dmseg will print::
=20
   setup_bootmem: Memory  : 0x100000000 - 0x120000000
   setup_bootmem: Reserved: 0x10001f000 - 0x1002d1bc0
=20
-During the paging init we need to set:
+During the paging init three settings need to be set:
=20
- - min_low_pfn that is the lowest PFN available in the system
- - max_low_pfn that indicates the end if NORMAL zone
- - max_pfn that is the number of pages in the system
+ - ``min_low_pfn`` - the lowest PFN available in the system
+ - ``max_low_pfn`` - the end if NORMAL zone
+ - ``max_pfn`` - the number of pages in the system
=20
-This setting is used for dividing memory into pages and for configuring the
-zone. See the memory map section for more information about ZONE.
+This setting is used for dividing memory into pages and for configuring zo=
nes.
+See the memory map section for more details.
=20
-Zones are configured in free_area_init_core(). During start_kernel() other
-allocations are done for command line, cpu areas, PID hash table, different
-caches for VFS. This allocator is used until mem_init() is called.
+Zones are configured in ``free_area_init_core()``. During ``start_kernel()=
``
+other allocations are done for command line, cpu areas, PID hash table, and
+different caches for VFS. The memblock allocator is used until ``mem_init(=
)``
+is called.
=20
-mem_init() is provided by the architecture. For MPPA we just call
-free_all_bootmem() that will go through all pages that are not used by the
-low level allocator and mark them as not used. So physical pages that are
-reserved for the kernel are still used and remain in physical memory. All =
pages
-released will now be used by the buddy allocator.
+``mem_init()`` is provided by the architecture. For MPPA ``free_all_bootme=
m()``
+is called, which goes through all pages that are not used by the low level
+allocator and mark them as not used. Thus, physical pages that are reserve=
d for
+the kernel are still used and remain in physical memory. All pages released
+will now be used by the buddy allocator.
=20
 Peripherals
 -----------
@@ -143,20 +144,20 @@ LTLB Usage
 ----------
=20
 LTLB is used to add resident mapping which allows for faster MMU lookup.
-Currently, the LTLB is used to map some mandatory kernel pages and to allo=
w fast
-accesses to l2 cache (mailbox and registers).
-When CONFIG_STRICT_KERNEL_RWX is disabled, 4 entries are reserved for kern=
el
-TLB refill using 512MB pages. When CONFIG_STRICT_KERNEL_RWX is enabled, th=
ese
-entries are unused since kernel is paginated using the same mecanism than =
for
-user (page walking and entries in JTLB)
+Currently, the LTLB is used to map some mandatory kernel pages and to allow
+fast accesses to l2 cache (mailbox and registers). When
+``CONFIG_STRICT_KERNEL_RWX`` is disabled, 4 entries are reserved for kerne=
l TLB
+refill using 512MB pages. When ``CONFIG_STRICT_KERNEL_RWX`` is enabled, th=
ese
+entries are unused since kernel is paginated using the same mecanism as in=
 the
+userspace (page walking and entries in JTLB)
=20
 Page Table
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-We only support three levels for the page table and 4KB for page size.
+Only three-level page table and 4KB page size are supported.
=20
-3 levels page table
--------------------
+3-level page table
+------------------
=20
 ::
=20
@@ -169,16 +170,16 @@ We only support three levels for the page table and 4=
KB for page size.
            |          +----------------------->  [29:21] PMD offset (9 bit=
s)
            +---------------------------------->  [39:30] PGD offset (10 bi=
ts)
=20
-Bits 40 to 64 are signed extended according to bit 39. If bit 39 is equal =
to 1
-we are in kernel space.
+Bits 40 to 64 are signed extended according to bit 39. If this bit is equa=
l to
+1 the process is in kernel space.
=20
-As 10 bits are used for PGD we need to allocate 2 pages.
+As 10 bits are used for PGD 2 pages need to be allocated.
=20
 PTE format
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-About the format of the PTE entry, as we are not forced by hardware for ch=
oices,
-we choose to follow the format described in the RiscV implementation as a
+For PTE entry format, instead of being forced by hardware constraints,
+the decision is to follow the format described in the RISC-V port as a
 starting point::
=20
    +---------+--------+----+--------+---+---+---+---+---+---+------+---+--=
-+
@@ -202,43 +203,35 @@ starting point::
 Huge bit must be somewhere in the first 12 bits to be able to detect it
 when reading the PMD entry.
=20
-PageSZ must be on bit 10 and 11 because it matches the TEL.PS bits. And
-by doing that it is easier in assembly to set the TEL.PS to PageSZ.
+PageSZ must be on bit 10 and 11 because it matches the TEL.PS bits. As suc=
h,
+it is easier in assembly to set the TEL.PS to PageSZ.
=20
 Fast TLB refill
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-kvx core does not feature a hardware page walker. This work must be done
-by the core in software. In order to optimize TLB refill, a special fast
-path is taken when entering in kernel space.
-In order to speed up the process, the following actions are taken:
+kvx core does not feature a hardware page walker. Instead, page walking mu=
st
+be done by the core in software. In order to optimize TLB refill, a special
+fast path is utilizedwhen entering in kernel space. In order to speed up t=
he
+process, the TLB refill process is:
=20
- 1. Save some registers in a per process scratchpad
- 2. If the trap is a nomapping then try the fastpath
- 3. Save some more registers for this fastpath
- 4. Check if faulting address is a memory direct mapping one.
-
-    * If entry is a direct mapping one and RWX is not enabled, add an entr=
y into LTLB
-    * If not, continue
-
- 5. Try to walk the page table
-
-    * If entry is not present, take the slowpath (do_page_fault)
-
- 6. Refill the tlb properly
- 7. Exit by restoring only a few registers
+ 1. Save some registers in a per process scratchpad.
+ 2. If the trap is a nomapping then try the fastpath, then save more regis=
ters
+    for that path.
+ 3. Check if faulting address is a memory direct mapping one. If it is the=
 case
+    and RWX is not enabled, add an entry into LTLB. Otherwise, continue.
+ 4. Try to walk the page table If entry is not present, take the slowpath
+    (``do_page_fault``)
+ 5. Refill the tlb.
+ 6. Exit by restoring only a few registers
=20
 ASN Handling
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-Disclaimer: Some part of this are taken from ARC architecture.
-
 kvx MMU provides 9-bit ASN (Address Space Number) in order to tag TLB entr=
ies.
 It allows for multiple process with the same virtual space to cohabit with=
out
-the need to flush TLB everytime we context switch.
-kvx implementation to use them is based on other architectures (such as arc
-or xtensa) and uses a wrapping ASN counter containing both cycle/generatio=
n and
-asn.
+the need to flush TLB every time context switch is done. The kvx implement=
ation
+is based on other architectures (such as arc or xtensa) and uses a wrappin=
g ASN
+counter containing both cycle/generation and asn.
=20
 ::
=20
@@ -250,27 +243,26 @@ asn.
 This ASN counter is incremented monotonously to allocate new ASNs. When the
 counter reaches 511 (9 bit), TLB is completely flushed and a new cycle is
 started. A new allocation cycle, post rollover, could potentially reassign=
 an
-ASN to a different task. Thus the rule is to reassign an ASN when the curr=
ent
-context cycles does not match the allocation cycle.
-The 64 bit @cpu_asn_cache (and mm->asn) have 9 bits MMU ASN and rest 55 bi=
ts
-serve as cycle/generation indicator and natural 64 bit unsigned math
-automagically increments the generation when lower 9 bits rollover.
-When the counter completely wraps, we reset the counter to first cycle val=
ue
-(ie cycle =3D 1). This allows to distinguish context without any ASN and o=
ld cycle
-generated value with the same operation (XOR on cycle).
+ASN to a different task, hence the rule is to reassign an ASN when the cur=
rent
+context cycles does not match the allocation cycle. The 64-bit
+``@cpu_asn_cache`` (and ``mm->asn``) have 9 bits of MMU ASN and the rest 55
+bits serve as cycle/generation indicator and natural 64 bit unsigned math
+automagically increments the generation when lower 9 bits rolls over. When=
 the
+counter completely wraps, the counter is reset to first cycle value (ie cy=
cle =3D
+1). This allows to distinguish context without any ASN and old cycle gener=
ated
+value with the same operation (XOR on cycle).
=20
 Huge page
 =3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-Currently only 3 level page table has been implemented for 4KB base page s=
ize.
-So the page shift is 12 bits, the pmd shift is 21 and the pgdir shift is 3=
0 bits.
-This choice implies that for 4KB base page size if we use a PMD as a huge
-page the size will be 2MB and if we use a PUD as a huge page it will be 1G=
B.
+Currently only 3-level page table is implemented for 4KB base page size. As
+such, the page shift is 12-bit, the pmd shift is 21 and the pgdir shift is
+30-bit. This also implies that for 4KB base page size, if PMD is used as a=
 huge
+page the size will be 2MB and if PUD is used, it will be 1GB.
=20
-To support other huge page sizes (64KB and 512MB) we need to use several
-contiguous entries in the page table. For huge page of 64KB we will need to
-use 16 entries in the PTE and for a huge page of 512MB it means that 256
-entries in PMD will be used.
+To support other huge page sizes (64KB and 512MB) it is necessary to use
+several contiguous entries in the page table. For 64KB page size 16 entrie=
s in
+the PTE are needed whereas for 512MB page size it requires 256 entries in =
PMD.
=20
 Debug
 =3D=3D=3D=3D=3D
@@ -278,10 +270,10 @@ Debug
 In order to debug the page table and tlb entries, gdb scripts contains com=
mands
 which allows to dump the page table:
=20
-:``lx-kvx-page-table-walk``: Display the current process page table by def=
ault
-:``lx-kvx-tlb-decode``: Display the content of $tel and $teh into somethin=
g readable
+  * ``lx-kvx-page-table-walk``: Display the current process page table by =
default
+  * ``lx-kvx-tlb-decode``: Display human-readable content of $tel and $teh
=20
-Other commands available in kvx-gdb are the following:
+Other commands available in kvx-gdb are:
=20
-:``mppa-dump-tlb``: Display the content of TLBs (JTLB and LTLB)
-:``mppa-lookup-addr``: Find physical address matching a virtual one
+  * ``mppa-dump-tlb``: Display the content of TLBs (JTLB and LTLB)
+  * ``mppa-lookup-addr``: Find physical address matching a virtual address
diff --git a/Documentation/kvx/kvx-smp.rst b/Documentation/kvx/kvx-smp.rst
index 12efddbfd1e04d..69cec021bc2acd 100644
--- a/Documentation/kvx/kvx-smp.rst
+++ b/Documentation/kvx/kvx-smp.rst
@@ -1,34 +1,33 @@
-=3D=3D=3D
-SMP
-=3D=3D=3D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+kvx Symmetric Multiprocessing
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
=20
-The Coolidge SoC is comprised of 5 clusters, each organized as a group
-of 17 cores: 16 application core (PE) and 1 secure core (RM).
-These 17 cores have their L1 cache coherent with the local Tightly
-Coupled Memory (TCM or SMEM). The L2 cache is necessary for SMP support
-is and implemented with a mix of HW support and SW firmware. The L2 cache
-data and meta-data are stored in the TCM.
-The RM core is not meant to run Linux and is reserved for implementing
-hypervisor services, thus only 16 processors are available for SMP.
+The Coolidge SoC is comprised of 5 clusters, each organized as a group of =
17
+cores: 16 application core (PE) and 1 secure core (RM). These cores have t=
heir
+L1 cache coherent with the local Tightly Coupled Memory (TCM or SMEM). The=
 L2
+cache is necessary for SMP support is and implemented with a mix of HW sup=
port
+and SW firmware. The L2 cache data and meta-data are stored in the TCM. As=
 the
+RM core is not meant to run Linux and is reserved for implementing hypervi=
sor
+services, only 16 processors are available for SMP.
=20
 Booting
 -------
=20
-When booting the kvx processor, only the RM is woken up. This RM will
-execute a portion of code located in the section named ``.rm_firmware``.
-By default, a simple power off code is embedded in this section.
-To avoid embedding the firmware in kernel sources, the section is patched
-using external tools to add the L2 firmware (and replace the default firmw=
are).
-Before executing this firmware, the RM boots the PE0. PE0 will then enable=
 L2
-coherency and request will be stalled until RM boots the L2 firmware.
+When booting the kvx processor, only the RM core is woken up. This core wi=
ll
+execute a portion of code located in the section named ``.rm_firmware``. By
+default, a simple power off code is embedded in this section. To avoid emb=
edding
+the firmware in kernel sources, the section is patched using external tool=
s to
+add the L2 firmware (and replace the default firmware). Before executing t=
his
+firmware, the core boots the PE0, which the latter will then enable L2 coh=
erency
+and request will be stalled until the core boots the L2 firmware.
=20
 Locking primitives
 ------------------
=20
-spinlock/rwlock are using the kernel standard queued spinlock/rwlocks.
-These primitives are based on cmpxch and xchg. More particularly, it uses =
xchg16
-which is implemented as a read modify write with acswap on 32bit word since
-kvx does not have atomic cmpxchg instructions for less than 32 bits.
+spinlocks/rwlocks are implemented using the kernel standard queued
+spinlock/rwlocks. These primitives are based on cmpxch and xchg. Specifica=
lly,
+it uses xchg16 which is implemented as a read-modify-write with acswap on =
32-bit
+word since kvx does not have atomic cmpxchg instructions for less than 32 =
bits.
=20
 IPI
 ---
diff --git a/Documentation/kvx/kvx.rst b/Documentation/kvx/kvx.rst
index 9407b7d4fdf169..a172bab58dcafc 100644
--- a/Documentation/kvx/kvx.rst
+++ b/Documentation/kvx/kvx.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
=20
-=3D=3D=3D=3D=3D=3D=3D=3D=3D
-kvx Linux
-=3D=3D=3D=3D=3D=3D=3D=3D=3D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+The kvx Linux port
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 This documents will try to explain any architecture choice for the kvx
 Linux port.
@@ -154,54 +154,53 @@ and ``r21`` are set up to special values containing t=
he function to call.
 The normal path for a kernel thread is:
=20
 1. Enter copy_thread_tls and setup callee saved registers which will
-   be restored in __switch_to.
-2. set r20 and r21 (in thread_struct) to function and argument and
-   ra to ret_from_kernel_thread.
-   These callee saved will be restored in switch_to.
-3. Call _switch_to at some point.
-4. Save all callee saved register since switch_to is seen as a
+   be restored in ``__switch_to``.
+2. set ``r20`` and ``r21`` (in ``thread_struct``) to function and argument=
 and
+   ra to ``ret_from_kernel_thread``. These callee-saved registers will be
+   restored in ``__switch_to``.
+3. Call ``_switch_to`` at some point.
+4. Save all callee-saved registers since ``__switch_to`` is seen as a
    standard function call by the caller.
-5. Change stack pointer to the new stack
-6. At the end of switch to, set sr0 to the new task and use ret to
-   jump to ret_from_kernel_thread (address restored from ra).
-7. In ret_from_kernel_thread, execute the function with arguments by
-   using r20, r21 and we are done
+5. Change stack pointer to the new stack.
+6. At the end of ``__switch_to``, set sr0 to the new task and use ret to
+   jump to ``ret_from_kernel_thread`` (address restored from ra).
+7. In ret_from_kernel_thread, execute the function with arguments from
+   ``r20`` and ``r21``
=20
 For more explanations, you can refer to https://lwn.net/Articles/520227/
=20
 User thread creation
 --------------------
=20
-We are using almost the same path as copy_thread to create it.
-The detailed path is the following:
+The similar path as ``copy_thread`` is used to create threads. It consists
+of:
=20
- 1. Call start_thread which will setup user pc and stack pointer in
-    task regs. We also set sps and clear privilege mode bit.
+ 1. Call ``start_thread`` which will setup user pc and stack pointer in
+    task regs. sps and clear privilege mode bit are also set.
     When returning from exception, it will "flip" to user mode.
- 2. Enter copy_thread_tls and setup callee saved registers which will
-    be restored in __switch_to. Also, set the "return" function to be
-    ret_from_fork which will be called at end of switch_to
- 3. set r20 (in thread_struct) with tracing information.
-    (simply by lazyness to avoid computing it in assembly...)
- 4. Call _switch_to at some point.
- 5. The current pc will then be restored to be ret_from fork.
- 6. Ret from fork calls schedule_tail and then check if tracing is
-    enabled. If so call syscall_trace_exit
- 7. finally, instead of returning to kernel, we restore all registers
-    that have been setup by start_thread by restoring regs stored on
-    stack
+ 2. Enter ``copy_thread_tls`` and setup callee-saved registers which will
+    be restored in ``__switch_to``. Also, set the "return" function to be
+    ret_from_fork which will be called at end of ``__switch_to``.
+ 3. Set ``r20`` (in ``thread_struct``) with tracing information.
+    (This is done to avoid computing it in assembly.)
+ 4. Call ``__switch_to`` at some point.
+ 5. The current pc will then be restored to be ``ret_from`` fork.
+ 6. ``ret_from`` fork calls ``schedule_tail`` and then check if tracing is
+    enabled. If so call ``syscall_trace_exit``.
+ 7. Finally, instead of returning to kernel, all registers that have been
+    setup by ``start_thread`` is restored by restoring regs stored on stac=
k.
=20
 L2 handling
 -----------
=20
 On kvx, the L2 is handled by a firmware running on the RM. This firmware
 needs various information to be aware of its configuration and communicate
-with the kernel. In order to do that, when firmware is starting, the device
+with the kernel. In order to do that, when the firmware is starting, the d=
evice
 tree is given as parameter along with the "registers" zone. This zone is
-simply a memory area where data are exchanged between kernel <-> L2. When
+simply a memory area where data are exchanged between kernel and L2. When
 some commands are written to it, the kernel sends an interrupt using a mai=
lbox.
-If the L2 node is not present in the device tree, then, the RM will direct=
ly go
-into sleeping.
+If the L2 node is not present in the device tree, the RM will directly go =
into
+sleeping.
=20
 Boot diagram::
=20
@@ -244,26 +243,29 @@ Boot diagram::
   +------------+            +            v
=20
=20
-Since this driver is started early (before SMP boot), A lot of drivers
+Since this driver is started early (before initializing SMP), a lot of dri=
vers
 are not yet probed (mailboxes, IOMMU, etc) and thus can not be used.
=20
 Building
 --------
=20
-In order to build the kernel, you will need a complete kvx toolchain.
-First, setup the config using the following command line::
+In order to build the kernel, you will need kvx cross toolchain and have it
+somewhere in the ``PATH``.
+
+First, prepare the default configuration by::
=20
     $ make ARCH=3Dkvx O=3Dyour_directory defconfig
=20
-Adjust any configuration option you may need and then, build the kernel::
+Launch your desired configuration frontend (like ``menuconfig``) and then,
+build the kernel::
=20
     $ make ARCH=3Dkvx O=3Dyour_directory -j12
=20
-You will finally have a vmlinux image ready to be run::
+You will finally have ``vmlinux`` kernel image, which can be run by::
=20
     $ kvx-mppa -- vmlinux
=20
-Additionally, you may want to debug it. To do so, use kvx-gdb::
+In case you need to debug the kernel, you can simply launch::
=20
     $ kvx-gdb vmlinux
=20

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--7vv3XoSTF5zTpOoA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY8z7uAAKCRD2uYlJVVFO
o1ekAQD1hPZ7S20WNmkqC88/gpO9eVOcfRQXfhFx+RJolI1sAwEAveNhAbPyuW1F
h9/AqYQuPr2u0fbyzW2xcGDvteHPzgc=
=ONKm
-----END PGP SIGNATURE-----

--7vv3XoSTF5zTpOoA--
