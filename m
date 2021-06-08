Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2AEC39FE5A
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 20:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbhFHSFV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Jun 2021 14:05:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232789AbhFHSFV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Jun 2021 14:05:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A19361376;
        Tue,  8 Jun 2021 18:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623175407;
        bh=NcujDDXF1n/aqovTU+s65bQnPyqX0sU2KIFBfkdTF80=;
        h=From:To:Cc:Subject:Date:From;
        b=LZH20+6sC4MpdtBvfvpJ4bA7kaS7JYa9hKBEiZ5X0aN/sRIMro0aXl+FmEKysLD38
         c3YC1STSZuYz0vLkUbsqQy65nUZj5z0LkB640rnZI6L2SRkOi0hT6t9zPZoiTDLRnh
         a+xQUba+0ali3YJoKJvJwXgPoO3hPl7QjzkCjH74ZTzVr9jyL9u2JFiXWbxMDkoT4E
         FIp78FKMdxJzhjF4aIUl1WFt9XgI9rqh3UrfF3YCwbYPyfNYECg92GyydMMuWNld9Y
         MKbNKox8UxP5hAZH5MZiv9lrMoHIGvkYVj9JZ7sJiV0TKyXlXAYIVix75SV5ambZNq
         UpyNIGGBPEWsw==
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
Subject: [PATCH v9 00/20] Add support for 32-bit tasks on asymmetric AArch32 systems
Date:   Tue,  8 Jun 2021 19:02:53 +0100
Message-Id: <20210608180313.11502-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi everyone,

The sun is shining and its time for your weekly dose of asymmetric
32-bit support patches, previously seen at:

  v1: https://lore.kernel.org/r/20201027215118.27003-1-will@kernel.org
  v2: https://lore.kernel.org/r/20201109213023.15092-1-will@kernel.org
  v3: https://lore.kernel.org/r/20201113093720.21106-1-will@kernel.org
  v4: https://lore.kernel.org/r/20201124155039.13804-1-will@kernel.org
  v5: https://lore.kernel.org/r/20201208132835.6151-1-will@kernel.org
  v6: https://lore.kernel.org/r/20210518094725.7701-1-will@kernel.org
  v7: https://lore.kernel.org/r/20210525151432.16875-1-will@kernel.org
  v8: https://lore.kernel.org/r/20210602164719.31777-1-will@kernel.org

There was also a nice LWN writeup in case you've forgotten what this is
about:

	https://lwn.net/Articles/838339/

Changes since v8 include:

  * Renamed task_cpus_dl_admissible() and changed return type [Daniel]
  * Renamed update_mismatched_32bit_el0_cpu_features() [Mark R]
  * Improved comments [Mark R and Valentin]
  * Cleaned up cpuset_cpus_allowed_fallback() [Valentin]
  * Remove redundant rcu_read_{lock,unlock}() in cpuset_cpus_allowed()
  * Added some more acks/reviewed-by tags

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

Will Deacon (20):
  arm64: cpuinfo: Split AArch32 registers out into a separate struct
  arm64: Allow mismatched 32-bit EL0 support
  KVM: arm64: Kill 32-bit vCPUs on systems with mismatched EL0 support
  arm64: Kill 32-bit applications scheduled on 64-bit-only CPUs
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
 arch/arm64/include/asm/cpu.h                  |  44 +--
 arch/arm64/include/asm/cpufeature.h           |   8 +-
 arch/arm64/include/asm/elf.h                  |   6 +-
 arch/arm64/include/asm/mmu_context.h          |  13 +
 arch/arm64/kernel/cpufeature.c                | 232 +++++++++---
 arch/arm64/kernel/cpuinfo.c                   |  53 +--
 arch/arm64/kernel/process.c                   |  44 ++-
 arch/arm64/kvm/arm.c                          |  11 +-
 arch/arm64/tools/cpucaps                      |   3 +-
 include/linux/cpuset.h                        |   8 +-
 include/linux/mmu_context.h                   |  14 +
 include/linux/sched.h                         |  21 ++
 init/init_task.c                              |   1 +
 kernel/cgroup/cpuset.c                        |  59 +--
 kernel/fork.c                                 |   2 +
 kernel/sched/core.c                           | 340 ++++++++++++++----
 kernel/sched/sched.h                          |   1 +
 21 files changed, 841 insertions(+), 195 deletions(-)
 create mode 100644 Documentation/arm64/asymmetric-32bit.rst

-- 
2.32.0.rc1.229.g3e70b5a671-goog

