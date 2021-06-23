Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3473B1FC8
	for <lists+linux-arch@lfdr.de>; Wed, 23 Jun 2021 19:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFWRmf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Jun 2021 13:42:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:37252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230298AbhFWRmT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 Jun 2021 13:42:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B61960231;
        Wed, 23 Jun 2021 17:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624470002;
        bh=27mqifx4RHv2jYv6wumbRZ6i5tNp3M1CzGg20SmdtIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CA5yt9SwUy4+ixd2voxsPeHYr4Wum4FMR5LelXy4D9p0IQ/xCOU4Iw/EBOapIJiPr
         xy8+t9voI6trYpZo0nmQtvnuExomXIN0xyHFWH6XleJFYIisednknI5RuPaihIu4TN
         UntSj/m7tjSvtC3nVrLmmhygJPzb6dOUnrm047Mm6Ry2bspIUYCl3cRXiqVoLW/RaB
         CLeDTDZmx07puiXouGIvr/Krdr876AWA71Wn/0qPMin6r5x1L23w2k1jtZx18b9kCF
         bz/A6gbajCZtcERN2SWd0vO6un8lBoKpewayiGw9jBw6in32uT+64Kx22WdmoGD2BF
         v5u0gBGymiSyA==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, kernel-team@android.com
Subject: [PATCH v10 16/16] Documentation: arm64: describe asymmetric 32-bit support
Date:   Wed, 23 Jun 2021 18:38:48 +0100
Message-Id: <20210623173848.318-17-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210623173848.318-1-will@kernel.org>
References: <20210623173848.318-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Document support for running 32-bit tasks on asymmetric 32-bit systems
and its impact on the user ABI when enabled.

Signed-off-by: Will Deacon <will@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |   3 +
 Documentation/arm64/asymmetric-32bit.rst      | 155 ++++++++++++++++++
 Documentation/arm64/index.rst                 |   1 +
 3 files changed, 159 insertions(+)
 create mode 100644 Documentation/arm64/asymmetric-32bit.rst

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a2e453919bb6..5a1dc7e628a5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -295,6 +295,9 @@
 			EL0 is indicated by /sys/devices/system/cpu/aarch32_el0
 			and hot-unplug operations may be restricted.
 
+			See Documentation/arm64/asymmetric-32bit.rst for more
+			information.
+
 	amd_iommu=	[HW,X86-64]
 			Pass parameters to the AMD IOMMU driver in the system.
 			Possible values are:
diff --git a/Documentation/arm64/asymmetric-32bit.rst b/Documentation/arm64/asymmetric-32bit.rst
new file mode 100644
index 000000000000..64a0b505da7d
--- /dev/null
+++ b/Documentation/arm64/asymmetric-32bit.rst
@@ -0,0 +1,155 @@
+======================
+Asymmetric 32-bit SoCs
+======================
+
+Author: Will Deacon <will@kernel.org>
+
+This document describes the impact of asymmetric 32-bit SoCs on the
+execution of 32-bit (``AArch32``) applications.
+
+Date: 2021-05-17
+
+Introduction
+============
+
+Some Armv9 SoCs suffer from a big.LITTLE misfeature where only a subset
+of the CPUs are capable of executing 32-bit user applications. On such
+a system, Linux by default treats the asymmetry as a "mismatch" and
+disables support for both the ``PER_LINUX32`` personality and
+``execve(2)`` of 32-bit ELF binaries, with the latter returning
+``-ENOEXEC``. If the mismatch is detected during late onlining of a
+64-bit-only CPU, then the onlining operation fails and the new CPU is
+unavailable for scheduling.
+
+Surprisingly, these SoCs have been produced with the intention of
+running legacy 32-bit binaries. Unsurprisingly, that doesn't work very
+well with the default behaviour of Linux.
+
+It seems inevitable that future SoCs will drop 32-bit support
+altogether, so if you're stuck in the unenviable position of needing to
+run 32-bit code on one of these transitionary platforms then you would
+be wise to consider alternatives such as recompilation, emulation or
+retirement. If neither of those options are practical, then read on.
+
+Enabling kernel support
+=======================
+
+Since the kernel support is not completely transparent to userspace,
+allowing 32-bit tasks to run on an asymmetric 32-bit system requires an
+explicit "opt-in" and can be enabled by passing the
+``allow_mismatched_32bit_el0`` parameter on the kernel command-line.
+
+For the remainder of this document we will refer to an *asymmetric
+system* to mean an asymmetric 32-bit SoC running Linux with this kernel
+command-line option enabled.
+
+Userspace impact
+================
+
+32-bit tasks running on an asymmetric system behave in mostly the same
+way as on a homogeneous system, with a few key differences relating to
+CPU affinity.
+
+sysfs
+-----
+
+The subset of CPUs capable of running 32-bit tasks is described in
+``/sys/devices/system/cpu/aarch32_el0`` and is documented further in
+``Documentation/ABI/testing/sysfs-devices-system-cpu``.
+
+**Note:** CPUs are advertised by this file as they are detected and so
+late-onlining of 32-bit-capable CPUs can result in the file contents
+being modified by the kernel at runtime. Once advertised, CPUs are never
+removed from the file.
+
+``execve(2)``
+-------------
+
+On a homogeneous system, the CPU affinity of a task is preserved across
+``execve(2)``. This is not always possible on an asymmetric system,
+specifically when the new program being executed is 32-bit yet the
+affinity mask contains 64-bit-only CPUs. In this situation, the kernel
+determines the new affinity mask as follows:
+
+  1. If the 32-bit-capable subset of the affinity mask is not empty,
+     then the affinity is restricted to that subset and the old affinity
+     mask is saved. This saved mask is inherited over ``fork(2)`` and
+     preserved across ``execve(2)`` of 32-bit programs.
+
+     **Note:** This step does not apply to ``SCHED_DEADLINE`` tasks.
+     See `SCHED_DEADLINE`_.
+
+  2. Otherwise, the cpuset hierarchy of the task is walked until an
+     ancestor is found containing at least one 32-bit-capable CPU. The
+     affinity of the task is then changed to match the 32-bit-capable
+     subset of the cpuset determined by the walk.
+
+  3. On failure (i.e. out of memory), the affinity is changed to the set
+     of all 32-bit-capable CPUs of which the kernel is aware.
+
+A subsequent ``execve(2)`` of a 64-bit program by the 32-bit task will
+invalidate the affinity mask saved in (1) and attempt to restore the CPU
+affinity of the task using the saved mask if it was previously valid.
+This restoration may fail due to intervening changes to the deadline
+policy or cpuset hierarchy, in which case the ``execve(2)`` continues
+with the affinity unchanged.
+
+Calls to ``sched_setaffinity(2)`` for a 32-bit task will consider only
+the 32-bit-capable CPUs of the requested affinity mask. On success, the
+affinity for the task is updated and any saved mask from a prior
+``execve(2)`` is invalidated.
+
+``SCHED_DEADLINE``
+------------------
+
+Explicit admission of a 32-bit deadline task to the default root domain
+(e.g. by calling ``sched_setattr(2)``) is rejected on an asymmetric
+32-bit system unless admission control is disabled by writing -1 to
+``/proc/sys/kernel/sched_rt_runtime_us``.
+
+``execve(2)`` of a 32-bit program from a 64-bit deadline task will
+return ``-ENOEXEC`` if the root domain for the task contains any
+64-bit-only CPUs and admission control is enabled. Concurrent offlining
+of 32-bit-capable CPUs may still necessitate the procedure described in
+`execve(2)`_, in which case step (1) is skipped and a warning is
+emitted on the console.
+
+**Note:** It is recommended that a set of 32-bit-capable CPUs are placed
+into a separate root domain if ``SCHED_DEADLINE`` is to be used with
+32-bit tasks on an asymmetric system. Failure to do so is likely to
+result in missed deadlines.
+
+Cpusets
+-------
+
+The affinity of a 32-bit task on an asymmetric system may include CPUs
+that are not explicitly allowed by the cpuset to which it is attached.
+This can occur as a result of the following two situations:
+
+  - A 64-bit task attached to a cpuset which allows only 64-bit CPUs
+    executes a 32-bit program.
+
+  - All of the 32-bit-capable CPUs allowed by a cpuset containing a
+    32-bit task are offlined.
+
+In both of these cases, the new affinity is calculated according to step
+(2) of the process described in `execve(2)`_ and the cpuset hierarchy is
+unchanged irrespective of the cgroup version.
+
+CPU hotplug
+-----------
+
+On an asymmetric system, the first detected 32-bit-capable CPU is
+prevented from being offlined by userspace and any such attempt will
+return ``-EPERM``. Note that suspend is still permitted even if the
+primary CPU (i.e. CPU 0) is 64-bit-only.
+
+KVM
+---
+
+Although KVM will not advertise 32-bit EL0 support to any vCPUs on an
+asymmetric system, a broken guest at EL1 could still attempt to execute
+32-bit code at EL0. In this case, an exit from a vCPU thread in 32-bit
+mode will return to host userspace with an ``exit_reason`` of
+``KVM_EXIT_FAIL_ENTRY`` and will remain non-runnable until successfully
+re-initialised by a subsequent ``KVM_ARM_VCPU_INIT`` operation.
diff --git a/Documentation/arm64/index.rst b/Documentation/arm64/index.rst
index 97d65ba12a35..4f840bac083e 100644
--- a/Documentation/arm64/index.rst
+++ b/Documentation/arm64/index.rst
@@ -10,6 +10,7 @@ ARM64 Architecture
     acpi_object_usage
     amu
     arm-acpi
+    asymmetric-32bit
     booting
     cpu-feature-registers
     elf_hwcaps
-- 
2.32.0.93.g670b81a890-goog

