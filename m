Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C010E3904DA
	for <lists+linux-arch@lfdr.de>; Tue, 25 May 2021 17:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhEYPQq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 May 2021 11:16:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbhEYPQq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 May 2021 11:16:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1EBB6141C;
        Tue, 25 May 2021 15:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621955716;
        bh=VuWyCYBd+Pcg6EfPgBrmBqLbQhO5LCy7WzJg2drhWmo=;
        h=From:To:Cc:Subject:Date:From;
        b=Babp0+Pg6rDUQiFi/JZ8jy7Nw2VJbsLcrtjBPzDIYB4mHOgzwQxaNF8UJeSqJ8Sht
         HwOUafC9OuJAU3jxpATM0PTSXw54I8ocERBQlgksN2NEKHRHx7xJNC1ePbd2aohepB
         6pwrC/ZabAEl0y8metSnXZw9ZOROdSLZFJmvA4r+inRqm1mN4z0pfIEIt3RSYNNGDN
         cCQoNbykBc2hFKamG7VYXtyvRWRKGytZlBCqTBqpQdmYvtZQ4/uLne+Q7dOli1vSJP
         qSG0IFYu47I5AOyeRRo6CKreQY2r6Vo8LGkt3W4Gl2WSEGTfKPw/aeURMGyJVPnv4F
         aQGqtouWQD5Sw==
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
        kernel-team@android.com
Subject: [PATCH v7 00/22] Add support for 32-bit tasks on asymmetric AArch32 systems
Date:   Tue, 25 May 2021 16:14:10 +0100
Message-Id: <20210525151432.16875-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

Here is v7 of the asymmetric 32-bit support patches that I previously
posted here:

  v1: https://lore.kernel.org/r/20201027215118.27003-1-will@kernel.org
  v2: https://lore.kernel.org/r/20201109213023.15092-1-will@kernel.org
  v3: https://lore.kernel.org/r/20201113093720.21106-1-will@kernel.org
  v4: https://lore.kernel.org/r/20201124155039.13804-1-will@kernel.org
  v5: https://lore.kernel.org/r/20201208132835.6151-1-will@kernel.org
  v6: https://lore.kernel.org/r/20210518094725.7701-1-will@kernel.org

There was also a nice LWN writeup in case you've forgotten what this is
about:

	https://lwn.net/Articles/838339/

Changes since v6 include:

  * Bug fix for a pre-existing scheduler migration bug spotted by
    Valentin (nice work!). I've put this patch at the start.

  * Prevent execve() of a 32-bit program from a 64-bit deadline task if
    the forced affinity would violate admission control

  * Fixed a memory leak and missing rcu_read_lock() spotted by Qais
    (thanks!)

  * Handle race between forcing affinity on execve() and CPU hot-unplug

  * Updated documentation

  * Introduce task_cpu_possible() macro as suggested by Peter Z

  * Added some acks/reviewed-by tags, although I didn't include these
    where patches have changed significantly since last time.

Series now based on v5.13-rc3 to avoid conflicting with arm64 cpucaps
rework merged at -rc2.

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
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: kernel-team@android.com

--->8

Will Deacon (22):
  sched: Favour predetermined active CPU as migration destination
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
  sched: Introduce task_struct::user_cpus_ptr to track requested
    affinity
  sched: Split the guts of sched_setaffinity() into a helper function
  sched: Allow task CPU affinity to be restricted on asymmetric systems
  sched: Introduce task_cpus_dl_admissible() to check proposed affinity
  freezer: Add frozen_or_skipped() helper function
  sched: Defer wakeup in ttwu() for unschedulable frozen tasks
  arm64: Implement task_cpu_possible_mask()
  arm64: exec: Adjust affinity for compat tasks with mismatched 32-bit
    EL0
  arm64: Prevent offlining first CPU with 32-bit EL0 on mismatched
    system
  arm64: Hook up cmdline parameter to allow mismatched 32-bit EL0
  arm64: Remove logic to kill 32-bit tasks on 64-bit-only cores
  Documentation: arm64: describe asymmetric 32-bit support

 .../ABI/testing/sysfs-devices-system-cpu      |   9 +
 .../admin-guide/kernel-parameters.txt         |  11 +
 Documentation/arm64/asymmetric-32bit.rst      | 154 ++++++++
 Documentation/arm64/index.rst                 |   1 +
 arch/arm64/include/asm/cpu.h                  |  44 ++-
 arch/arm64/include/asm/cpufeature.h           |   8 +-
 arch/arm64/include/asm/elf.h                  |   6 +-
 arch/arm64/include/asm/mmu_context.h          |  13 +
 arch/arm64/kernel/cpufeature.c                | 227 ++++++++---
 arch/arm64/kernel/cpuinfo.c                   |  53 +--
 arch/arm64/kernel/process.c                   |  44 ++-
 arch/arm64/kvm/arm.c                          |  11 +-
 arch/arm64/tools/cpucaps                      |   3 +-
 include/linux/cpuset.h                        |   3 +-
 include/linux/freezer.h                       |   6 +
 include/linux/mmu_context.h                   |  11 +
 include/linux/sched.h                         |  21 ++
 init/init_task.c                              |   1 +
 kernel/cgroup/cpuset.c                        |  53 ++-
 kernel/fork.c                                 |   2 +
 kernel/freezer.c                              |  10 +-
 kernel/hung_task.c                            |   4 +-
 kernel/sched/core.c                           | 351 ++++++++++++++----
 kernel/sched/sched.h                          |   1 +
 24 files changed, 850 insertions(+), 197 deletions(-)
 create mode 100644 Documentation/arm64/asymmetric-32bit.rst

-- 
2.31.1.818.g46aad6cb9e-goog

