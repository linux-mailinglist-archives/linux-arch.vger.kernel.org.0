Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E533DB7B0
	for <lists+linux-arch@lfdr.de>; Fri, 30 Jul 2021 13:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238609AbhG3LYz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Jul 2021 07:24:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230157AbhG3LYz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Jul 2021 07:24:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A36360E76;
        Fri, 30 Jul 2021 11:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627644291;
        bh=lJMGbbryAzQ8PnK7imdPOWLE5dWTVPTjzZiW9Wn/SSM=;
        h=From:To:Cc:Subject:Date:From;
        b=KFuP5asfdkHq66xuplXbvEW/8yac66Cjy0lLAcnD8v/PCGcn7/gzLSNqaMpzsSUHx
         xQ9mE/W7NP/HxYT2o8jbh+K0GqLi77mJOp0Yrbh6Pm511T0zILaCIa3BX3yOZkG33h
         nkTSgkA+LYmNb9EjTVLoZU8ItpwzejzSUWugZ/Yq3nOv5maAXwYg8ViytSYZ7bGaJD
         NW/ueOgfvAfUUYGLF7zinGyI/7e8gC9Jhorg99iPoqFO76HjOXI4283dew+DHKLKQc
         T2vbvULJ7Xg9QVg1IjdRomeZcLT9JXj05bL98Jh3WnPMKBmXzRMSgso8yqL4WChsin
         DezltYtu4kyfw==
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
Subject: [PATCH v11 00/16] Add support for 32-bit tasks on asymmetric AArch32 systems
Date:   Fri, 30 Jul 2021 12:24:27 +0100
Message-Id: <20210730112443.23245-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi everyone,

This is version eleven of the patches previously posted here:

  v1: https://lore.kernel.org/r/20201027215118.27003-1-will@kernel.org
  v2: https://lore.kernel.org/r/20201109213023.15092-1-will@kernel.org
  v3: https://lore.kernel.org/r/20201113093720.21106-1-will@kernel.org
  v4: https://lore.kernel.org/r/20201124155039.13804-1-will@kernel.org
  v5: https://lore.kernel.org/r/20201208132835.6151-1-will@kernel.org
  v6: https://lore.kernel.org/r/20210518094725.7701-1-will@kernel.org
  v7: https://lore.kernel.org/r/20210525151432.16875-1-will@kernel.org
  v8: https://lore.kernel.org/r/20210602164719.31777-1-will@kernel.org
  v9: https://lore.kernel.org/r/20210608180313.11502-1-will@kernel.org
 v10: https://lore.kernel.org/r/20210623173848.318-1-will@kernel.org

The main changes since v10 are:

  * Now based on v5.14-rc1

  * Fixed a lockup found during testing where select_fallback_rq()
    could return an invalid CPU when trying to prioritise a destination
    on the same NUMA node

Greg kindly pointed out a potential issue with the new 'aarch32_el0'
file in sysfs, where the contents will be truncated if we need to
display more than a PAGE_SIZE of data. However, I have elected not to
address this for now as (a) I do not think we'll ever have hardware in
that configuration (yeah, I know...) and (b) It is useful for scripts
if the file behaves the same as the other files in the same directory
(e.g. 'online'). Should a solution to this problem emerge for the other
files, I will be happy to adopt it here as well.

This series is now mostly scheduler stuff, but the last few patches are
arm64 and so I would suggest a shared branch in -tip for merging.

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
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: kernel-team@android.com

--->8

Will Deacon (16):
  sched: Introduce task_cpu_possible_mask() to limit fallback rq
    selection
  cpuset: Don't use the cpu_possible_mask as a last resort for cgroup v1
  cpuset: Honour task_cpu_possible_mask() in guarantee_online_cpus()
  cpuset: Cleanup cpuset_cpus_allowed_fallback() use in
    select_fallback_rq()
  sched: Reject CPU affinity changes based on task_cpu_possible_mask()
  sched: Introduce task_struct::user_cpus_ptr to track requested
    affinity
  sched: Split the guts of sched_setaffinity() into a helper function
  sched: Allow task CPU affinity to be restricted on asymmetric systems
  sched: Introduce dl_task_check_affinity() to check proposed affinity
  arm64: Implement task_cpu_possible_mask()
  arm64: exec: Adjust affinity for compat tasks with mismatched 32-bit
    EL0
  arm64: Prevent offlining first CPU with 32-bit EL0 on mismatched
    system
  arm64: Advertise CPUs capable of running 32-bit applications in sysfs
  arm64: Hook up cmdline parameter to allow mismatched 32-bit EL0
  arm64: Remove logic to kill 32-bit tasks on 64-bit-only cores
  Documentation: arm64: describe asymmetric 32-bit support

 .../ABI/testing/sysfs-devices-system-cpu      |   9 +
 .../admin-guide/kernel-parameters.txt         |  11 +
 Documentation/arm64/asymmetric-32bit.rst      | 155 ++++++++
 Documentation/arm64/index.rst                 |   1 +
 arch/arm64/include/asm/elf.h                  |   6 +-
 arch/arm64/include/asm/mmu_context.h          |  13 +
 arch/arm64/kernel/cpufeature.c                |  51 ++-
 arch/arm64/kernel/process.c                   |  47 ++-
 arch/arm64/kernel/signal.c                    |  26 --
 include/linux/cpuset.h                        |   8 +-
 include/linux/mmu_context.h                   |  14 +
 include/linux/sched.h                         |  21 ++
 init/init_task.c                              |   1 +
 kernel/cgroup/cpuset.c                        |  59 ++-
 kernel/fork.c                                 |   2 +
 kernel/sched/core.c                           | 344 ++++++++++++++----
 kernel/sched/sched.h                          |   1 +
 17 files changed, 628 insertions(+), 141 deletions(-)
 create mode 100644 Documentation/arm64/asymmetric-32bit.rst

-- 
2.32.0.402.g57bb445576-goog

