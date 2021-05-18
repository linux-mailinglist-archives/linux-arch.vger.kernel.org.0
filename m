Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC33C3875AC
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 11:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348264AbhERJvA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 05:51:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348147AbhERJu3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 05:50:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8011561404;
        Tue, 18 May 2021 09:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621331332;
        bh=cLV1ruPvNZQWbLhrPTW5PTi59kS93zO0HxNZ8xc2n5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PpUmRDuQPotlvWn6Zdm8S/5OhittrHyEVMvHp0uVcz4ZQfZit07yzmo/gvmt5fJsE
         cANOh+AlooAZYy7DCWLxMZulfgk9zCvL47X8Tn92OpSXCSPJeD3/tzsPsoTZXrUQkC
         vqHcsROicuUlVI0xVzlbqTLW7e+1kAKB8hVDeVnGS1ZX22G1ESF0XRx9ExjyuyR1OM
         gvoxgDN/VeMMK2hlyigf3JRWaHnKV60msIvhPv6RakToZXn5bVmQZpnB46ht3jbu8Z
         5C6SSpXjuLXDH9n7Hwurn7z7rPVcR4gNK9M0rCfL/1BZha1gy5IxmVW1IvUiZCR5YY
         CpM3nGLV19GbQ==
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
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com
Subject: [PATCH v6 21/21] Documentation: arm64: describe asymmetric 32-bit support
Date:   Tue, 18 May 2021 10:47:25 +0100
Message-Id: <20210518094725.7701-22-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210518094725.7701-1-will@kernel.org>
References: <20210518094725.7701-1-will@kernel.org>
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
 Documentation/arm64/asymmetric-32bit.rst      | 149 ++++++++++++++++++
 Documentation/arm64/index.rst                 |   1 +
 3 files changed, 153 insertions(+)
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
index 000000000000..baf02c143363
--- /dev/null
+++ b/Documentation/arm64/asymmetric-32bit.rst
@@ -0,0 +1,149 @@
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
+system* to mean an SoC running Linux with this kernel command-line
+option enabled.
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
+Admitting a 32-bit task to the deadline scheduler (e.g. by calling
+``sched_setattr(2)``) will, if valid, consider the affinity mask saved
+by a previous call to ``execve(2)`` for the purposes of input validation
+in preference to the running affinity of the task. 64-bit deadline tasks
+will skip step (1) of the process described in `execve(2)`_ when
+executed a 32-bit program.
+
+**Note:** It is recommended that the 32-bit-capable CPUs are placed into
+a separate root domain if ``SCHED_DEADLINE`` is to be used with 32-bit
+tasks on an asymmetric system. Failure to do so is likely to result in
+missed deadlines.
+
+Cpusets
+-------
+
+The affinity of a 32-bit task may include CPUs that are not explicitly
+allowed by the cpuset to which it is attached. This can occur as a
+result of the following two situations:
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
+When the kernel detects asymmetric 32-bit hardware, the first detected
+32-bit-capable CPU is prevented from being offlined by userspace and any
+such attempt will return ``-EPERM``. Note that suspend is still
+permitted even if the primary CPU (i.e. CPU 0) is 64-bit-only.
+
+KVM
+---
+
+Although KVM will not advertise 32-bit EL0 support to any vCPUs on an
+asymmetric system, a broken guest at EL1 could still attempt to execute
+32-bit code at EL0. In this case, an exit from a vCPU thread in 32-bit
+mode will return to host userspace with an ``exit_reason`` of
+``KVM_EXIT_FAIL_ENTRY``.
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
2.31.1.751.gd2f1c929bd-goog

