Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F82838757A
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 11:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241332AbhERJsz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 05:48:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241211AbhERJsz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 05:48:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9300961364;
        Tue, 18 May 2021 09:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621331257;
        bh=+aD6s2CW64ddOEmGtbEeJlNomwFr3AXy1aAqW/dipgs=;
        h=From:To:Cc:Subject:Date:From;
        b=IYUwwCHhX1Vf8oYpxNpGf6++BqWm/NS7uPnVByLvNooP/itpOe8BH3CNlb2E/8xix
         6CNlnWRAebrcFkubh/0Tg4elcqAcDFHvEE6e77DRh5+e/TlF3SEdelPBLew/iOTQSu
         n6K45hDso4SuXq8lhctYBxP1qx90eAi9LKd2W5SMNVYsfaHOG2O9H0NQDR7NI51OCg
         ujbtekWjzE6jD2AVEZd7zqYhdB7zKEGAxReOFNe9kPxIdxXJhYaqg4EsqkE3j9BQje
         Vh3nQe5lxuAd2nfDPPpU/iAOZAJ09v/wh8fPDI6pFt6u0d4yWoKw86zVw6XEv/dkJD
         mfVIa+IaPqUlw==
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
Subject: [PATCH v6 00/21] Add support for 32-bit tasks on asymmetric AArch32 systems
Date:   Tue, 18 May 2021 10:47:04 +0100
Message-Id: <20210518094725.7701-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi folks,

This is the long-awaited v6 of these patches which I last posted at the
end of last year:

  v1: https://lore.kernel.org/r/20201027215118.27003-1-will@kernel.org
  v2: https://lore.kernel.org/r/20201109213023.15092-1-will@kernel.org
  v3: https://lore.kernel.org/r/20201113093720.21106-1-will@kernel.org
  v4: https://lore.kernel.org/r/20201124155039.13804-1-will@kernel.org
  v5: https://lore.kernel.org/r/20201208132835.6151-1-will@kernel.org

There was also a nice LWN writeup in case you've forgotten what this is
about:

	https://lwn.net/Articles/838339/

It's taken me a while to get a v6 of this together, partly due to
addressing the review feedback on v5, but also because this has now seen
testing on real hardware which threw up some surprises in suspend/resume,
SCHED_DEADLINE and compat hwcap reporting. Thanks to Quentin for helping
me to debug those issues.

The aim of this series is to allow 32-bit ARM applications to run on
arm64 SoCs where not all of the CPUs support the 32-bit instruction set.
Unfortunately, such SoCs are real and will continue to be productised
over the next few years at least. I can assure you that I'm not just
doing this for fun.

Changes in v6 include:

  * Save/restore the affinity mask across execve() to 32-bit and back to
    64-bit again.

  * Allow 32-bit deadline tasks, but skip straight to fallback path when
    determining new affinity mask on execve().

  * Fixed resume-from-suspend path when the resuming CPU is 64-bit-only
    by deferring wake-ups for 32-bit tasks until the secondary CPUs are
    back online.

  * Bug fixes (compat hwcaps, memory leak, cpuset fallback path).

  * Documentation for arm64. It's in the divisive .rst format, but please
    take a look anyway!

I'm pretty happy with this now and it seems to do the right thing,
although the new patches in this revision would certainly benefit from
review. Series based on v5.13-rc1.

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
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: kernel-team@android.com

--->8

Will Deacon (21):
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
  sched: Admit forcefully-affined tasks into SCHED_DEADLINE
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
 Documentation/arm64/asymmetric-32bit.rst      | 149 ++++++++
 Documentation/arm64/index.rst                 |   1 +
 arch/arm64/include/asm/cpu.h                  |  44 +--
 arch/arm64/include/asm/cpucaps.h              |   3 +-
 arch/arm64/include/asm/cpufeature.h           |   8 +-
 arch/arm64/include/asm/mmu_context.h          |  13 +
 arch/arm64/kernel/cpufeature.c                | 227 +++++++++---
 arch/arm64/kernel/cpuinfo.c                   |  53 +--
 arch/arm64/kernel/process.c                   |  21 +-
 arch/arm64/kvm/arm.c                          |  11 +-
 include/linux/cpuset.h                        |   3 +-
 include/linux/freezer.h                       |   6 +
 include/linux/mmu_context.h                   |   8 +
 include/linux/sched.h                         |  15 +
 init/init_task.c                              |   1 +
 kernel/cgroup/cpuset.c                        |  45 ++-
 kernel/fork.c                                 |   2 +
 kernel/freezer.c                              |  10 +-
 kernel/hung_task.c                            |   4 +-
 kernel/sched/core.c                           | 323 ++++++++++++++----
 kernel/sched/sched.h                          |   1 +
 23 files changed, 781 insertions(+), 187 deletions(-)
 create mode 100644 Documentation/arm64/asymmetric-32bit.rst

-- 
2.31.1.751.gd2f1c929bd-goog

