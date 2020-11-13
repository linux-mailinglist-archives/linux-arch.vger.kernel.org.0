Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF112B184A
	for <lists+linux-arch@lfdr.de>; Fri, 13 Nov 2020 10:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgKMJhh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Nov 2020 04:37:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:49902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbgKMJhg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 13 Nov 2020 04:37:36 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D9C12145D;
        Fri, 13 Nov 2020 09:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605260255;
        bh=0m7tITM+sACKVGwthAYaKOdpWkbZnc/kOaFs7o5SSUg=;
        h=From:To:Cc:Subject:Date:From;
        b=KPJouh67DVluGQjm0JAgtVMS0eEBJ3kP6AxQJ+cOxHxa8sT4+2fZOeiniadwmSdD3
         3gyV6qjrYjx2PjgChMu+/2Ez9R5cq9KRI1NHMjP1bReCTm8iyl4Qz0dcPmxqE+CsXZ
         bxMJQ/EyAmvhG4KdLH65zu7DegVBrNHHK0s/0Xd8=
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
        kernel-team@android.com
Subject: [PATCH v3 00/14] An alternative series for asymmetric AArch32 systems
Date:   Fri, 13 Nov 2020 09:37:05 +0000
Message-Id: <20201113093720.21106-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi again everyone,

	I'm not a scheduler hacker,
	I'm a scheduler hacker's mate.
	I'm only hacking the scheduler,
	'cos trying to run 32-bit applications on systems where not all of the CPUs support it is GREAT.

It's Friday 13th, and I'm back with version three of the increasingly
popular patches I previously posted here:

  v1: https://lore.kernel.org/r/20201027215118.27003-1-will@kernel.org
  v2: https://lore.kernel.org/r/20201109213023.15092-1-will@kernel.org

and which started life as a reimplementation of some patches from Qais:

  https://lore.kernel.org/r/20201021104611.2744565-1-qais.yousef@arm.com

The aim of this series is to allow 32-bit ARM applications to run on
arm64 SoCs where not all of the CPUs support the 32-bit instruction set.

There are some major changes in v3:

  * Add some scheduler hooks for restricting a task's affinity mask
  * Implement these hooks for arm64 so that we can avoid 32-bit tasks
    running on 64-bit-only cores
  * Restrict affinity mask of 32-bit tasks on execve()
  * Prevent hot-unplug of all 32-bit CPUs if we have a mismatched system
  * Ensure 32-bit EL0 cpumask is zero-initialised (oops)

It's worth mentioning that this approach goes directly against my
initial proposal for punting the affinity management to userspace,
because it turns out that doesn't really work. There are cases where the
kernel has to muck with the affinity mask explicitly, such as execve(),
CPU hotplug and cpuset balancing. Ensuring that these don't lead to
random SIGKILLs as far as userspace is concerned means avoiding any
64-bit-only CPUs appearing in the affinity mask for a 32-bit task, at
which point it's easier just to handle everything in the kernel anyway.

- Patches 1-6 hack the arm64 CPU feature code to allow 32-bit tasks to
  run on a mismatched system, but forcing SIGKILL if a task ends up on
  the wrong CPU. This is gated on a command-line option; without it, a
  mismatched system will be treated as 64-bit-only.

- Patches 7-11 add scheduler functionality necessary to constrain the
  CPU affinity mask on a per-task basis and hook this up for execve() on
  arm64.

- Patches 12-14 finish off the arm64 plumbing and remove the logic for
  killing misplaced tasks, as it adds overhead to the context-switch and
  ret-to-user paths.

This seems to do the right thing in my contrived QEMU environment, but
as I say, I'm not a scheduler hacker so I'm open to alternative ideas.

Cheers,

Will

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Qais Yousef <qais.yousef@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Quentin Perret <qperret@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: kernel-team@android.com

--->8

Will Deacon (14):
  arm64: cpuinfo: Split AArch32 registers out into a separate struct
  arm64: Allow mismatched 32-bit EL0 support
  KVM: arm64: Kill 32-bit vCPUs on systems with mismatched EL0 support
  arm64: Kill 32-bit applications scheduled on 64-bit-only CPUs
  arm64: Advertise CPUs capable of running 32-bit applications in sysfs
  arm64: Hook up cmdline parameter to allow mismatched 32-bit EL0
  sched: Introduce restrict_cpus_allowed_ptr() to limit task CPU
    affinity
  arm64: exec: Adjust affinity for compat tasks with mismatched 32-bit
    EL0
  cpuset: Don't use the cpu_possible_mask as a last resort for cgroup v1
  sched: Introduce arch_cpu_allowed_mask() to limit fallback rq
    selection
  sched: Reject CPU affinity changes based on arch_cpu_allowed_mask()
  arm64: Prevent offlining first CPU with 32-bit EL0 on mismatched
    system
  arm64: Implement arch_cpu_allowed_mask()
  arm64: Remove logic to kill 32-bit tasks on 64-bit-only cores

 .../ABI/testing/sysfs-devices-system-cpu      |   9 +
 .../admin-guide/kernel-parameters.txt         |   7 +
 arch/arm64/include/asm/cpu.h                  |  44 ++--
 arch/arm64/include/asm/cpucaps.h              |   2 +-
 arch/arm64/include/asm/cpufeature.h           |   8 +-
 arch/arm64/include/asm/mmu_context.h          |  12 +
 arch/arm64/kernel/cpufeature.c                | 219 ++++++++++++++----
 arch/arm64/kernel/cpuinfo.c                   |  53 +++--
 arch/arm64/kernel/process.c                   |  17 +-
 arch/arm64/kvm/arm.c                          |  11 +-
 include/linux/sched.h                         |   1 +
 kernel/cgroup/cpuset.c                        |   6 +-
 kernel/sched/core.c                           |  90 +++++--
 13 files changed, 370 insertions(+), 109 deletions(-)

-- 
2.29.2.299.gdc1121823c-goog

