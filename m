Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9370D2D2BE3
	for <lists+linux-arch@lfdr.de>; Tue,  8 Dec 2020 14:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgLHN33 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Dec 2020 08:29:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:47824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbgLHN33 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Dec 2020 08:29:29 -0500
From:   Will Deacon <will@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
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
Subject: [PATCH v5 00/15] An alternative series for asymmetric AArch32 systems
Date:   Tue,  8 Dec 2020 13:28:20 +0000
Message-Id: <20201208132835.6151-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

Christmas has come early: it's time for version five of these patches
which have previously appeared here:

  v1: https://lore.kernel.org/r/20201027215118.27003-1-will@kernel.org
  v2: https://lore.kernel.org/r/20201109213023.15092-1-will@kernel.org
  v3: https://lore.kernel.org/r/20201113093720.21106-1-will@kernel.org
  v4: https://lore.kernel.org/r/20201124155039.13804-1-will@kernel.org

and which started life as a reimplementation of some patches from Qais:

  https://lore.kernel.org/r/20201021104611.2744565-1-qais.yousef@arm.com

There's also now a nice writeup on LWN:

  https://lwn.net/Articles/838339/

and rumours of a feature film are doing the rounds.

[subscriber-only, but if you're reading this then you should really
 subscribe.]

The aim of this series is to allow 32-bit ARM applications to run on
arm64 SoCs where not all of the CPUs support the 32-bit instruction set.
Unfortunately, such SoCs are real and will continue to be productised
over the next few years at least. I can assure you that I'm not just
doing this for fun.

Changes in v5 include:

  * Teach cpuset_cpus_allowed() about task_cpu_possible_mask() so that
    we can avoid returning incompatible CPUs for a given task. This
    means that sched_setaffinity() can be used with larger masks (like
    the online mask) from userspace and also allows us to take into
    account the cpuset hierarchy when forcefully overriding the affinity
    for a task on execve().

  * Honour task_cpu_possible_mask() when attaching a task to a cpuset,
    so that the resulting affinity mask does not contain any incompatible
    CPUs (since it would be rejected by set_cpus_allowed_ptr() otherwise).

  * Moved overriding of the affinity mask into the scheduler core rather
    than munge affinity masks directly in the architecture backend.

  * Extended comments and documentation.

  * Some renaming and cosmetic changes.

I'm pretty happy with this now, although it still needs review and will
require rebasing to play nicely with the SCA changes in -next.

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


Will Deacon (15):
  arm64: cpuinfo: Split AArch32 registers out into a separate struct
  arm64: Allow mismatched 32-bit EL0 support
  KVM: arm64: Kill 32-bit vCPUs on systems with mismatched EL0 support
  arm64: Kill 32-bit applications scheduled on 64-bit-only CPUs
  arm64: Advertise CPUs capable of running 32-bit applications in sysfs
  sched: Introduce task_cpu_possible_mask() to limit fallback rq
    selection
  cpuset: Don't use the cpu_possible_mask as a last resort for cgroup v1
  cpuset: Honour task_cpu_possible_mask() in guarantee_online_cpus()
  sched: Reject CPU affinity changes based on task_cpu_possible_mask()
  sched: Introduce force_compatible_cpus_allowed_ptr() to limit CPU
    affinity
  arm64: Implement task_cpu_possible_mask()
  arm64: exec: Adjust affinity for compat tasks with mismatched 32-bit
    EL0
  arm64: Prevent offlining first CPU with 32-bit EL0 on mismatched
    system
  arm64: Hook up cmdline parameter to allow mismatched 32-bit EL0
  arm64: Remove logic to kill 32-bit tasks on 64-bit-only cores

 .../ABI/testing/sysfs-devices-system-cpu      |   9 +
 .../admin-guide/kernel-parameters.txt         |   8 +
 arch/arm64/include/asm/cpu.h                  |  44 ++--
 arch/arm64/include/asm/cpucaps.h              |   3 +-
 arch/arm64/include/asm/cpufeature.h           |   8 +-
 arch/arm64/include/asm/mmu_context.h          |  13 ++
 arch/arm64/kernel/cpufeature.c                | 219 ++++++++++++++----
 arch/arm64/kernel/cpuinfo.c                   |  53 +++--
 arch/arm64/kernel/process.c                   |  19 +-
 arch/arm64/kvm/arm.c                          |  11 +-
 include/linux/cpuset.h                        |   3 +-
 include/linux/mmu_context.h                   |   8 +
 include/linux/sched.h                         |   1 +
 kernel/cgroup/cpuset.c                        |  39 ++--
 kernel/sched/core.c                           | 112 +++++++--
 15 files changed, 426 insertions(+), 124 deletions(-)

-- 
2.29.2.576.ga3fc446d84-goog

