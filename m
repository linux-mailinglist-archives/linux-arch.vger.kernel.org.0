Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42E049AE7E
	for <lists+linux-arch@lfdr.de>; Fri, 23 Aug 2019 13:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391650AbfHWL6Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Aug 2019 07:58:24 -0400
Received: from foss.arm.com ([217.140.110.172]:32980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389426AbfHWL6Y (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Aug 2019 07:58:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15A1E337;
        Fri, 23 Aug 2019 04:58:23 -0700 (PDT)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DDF03F246;
        Fri, 23 Aug 2019 04:58:21 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dave.martin@arm.com, james.morse@arm.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, takahiro.akashi@linaro.org,
        hidehiro.kawai.ez@hitachi.com
Subject: [RFC PATCH 0/7] Unify SMP stop generic logic to common code
Date:   Fri, 23 Aug 2019 12:57:13 +0100
Message-Id: <20190823115720.605-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

the logic underlying SMP stop and kexec crash procedures, beside containing
some arch-specific bits, is mostly generic and common across all archs:
despite this fact, such logic is now scattered across all architectures and
on some of them is flawed, in such a way that, under some specific
conditions, you can end up with a CPU left still running after a panic and
possibly lost across a subsequent kexec crash reboot. [1]

Beside the flaws on some archs, there is anyway lots of code duplication,
so this patch series attempts to move into common code all the generic SMP
stop and crash logic, fixing observed issues, and leaving only the arch
specific bits inside properly provided arch-specific helpers.

An architecture willing to rely on this SMP common logic has to define its
own helpers and set CONFIG_ARCH_USE_COMMON_SMP_STOP=y.
The series wire this up for arm64.

Behaviour is not changed for architectures not adopting this new common
logic.

Tested as follows:
- arm64:
 1. boot/reboot
 2. panic on a starting CPU within a 2 CPUs system (freezing properly)
 3. kexec reboot after a panic like 2. (not losing any CPU on reboot)
 4. kexec reboot after a panic like 2. and a simultaneous reboot
    (instrumenting code to delay the stop messages transmission
     to have time to inject a reboot -f)
- x86:
 1. boot/reboot
 2. panic
 3. kexec crash

Thanks

Cristian

[1]

[root@arch ~]# echo 1 > /sys/devices/system/cpu/cpu1/online
[root@arch ~]# [  152.583368] ------------[ cut here ]------------
[  152.583872] kernel BUG at arch/arm64/kernel/cpufeature.c:852!
[  152.584693] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[  152.585228] Modules linked in:
[  152.586040] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.3.0-rc5-00001-gcabd12118c4a-dirty #2
[  152.586218] Hardware name: Foundation-v8A (DT)
[  152.586478] pstate: 000001c5 (nzcv dAIF -PAN -UAO)
[  152.587260] pc : has_cpuid_feature+0x35c/0x360
[  152.587398] lr : verify_local_elf_hwcaps+0x6c/0xf0
[  152.587520] sp : ffff0000118bbf60
[  152.587605] x29: ffff0000118bbf60 x28: 0000000000000000
[  152.587784] x27: 0000000000000000 x26: 0000000000000000
[  152.587882] x25: ffff00001167a010 x24: ffff0000112f59f8
[  152.587992] x23: 0000000000000000 x22: 0000000000000000
[  152.588085] x21: ffff0000112ea018 x20: ffff000010fe5518
[  152.588180] x19: ffff000010ba3f30 x18: 0000000000000036
[  152.588285] x17: 0000000000000000 x16: 0000000000000000
[  152.588380] x15: 0000000000000000 x14: ffff80087a821210
[  152.588481] x13: 0000000000000000 x12: 0000000000000000
[  152.588599] x11: 0000000000000080 x10: 00400032b5503510
[  152.588709] x9 : 0000000000000000 x8 : ffff000010b93204
[  152.588810] x7 : 00000000800001d8 x6 : 0000000000000005
[  152.588910] x5 : 0000000000000000 x4 : 0000000000000000
[  152.589021] x3 : 0000000000000000 x2 : 0000000000008000
[  152.589121] x1 : 0000000000180480 x0 : 0000000000180480
[  152.589379] Call trace:
[  152.589646]  has_cpuid_feature+0x35c/0x360
[  152.589763]  verify_local_elf_hwcaps+0x6c/0xf0
[  152.589858]  check_local_cpu_capabilities+0x88/0x118
[  152.589968]  secondary_start_kernel+0xc4/0x168
[  152.590530] Code: d53801e0 17ffff58 d5380600 17ffff56 (d4210000)
[  152.592215] ---[ end trace 80ea98416149c87e ]---
[  152.592734] Kernel panic - not syncing: Attempted to kill the idle task!
[  152.593173] Kernel Offset: disabled
[  152.593501] CPU features: 0x0004,20c02008
[  152.593678] Memory Limit: none
[  152.594208] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
[root@arch ~]# bash: echo: write error: Input/output error
[root@arch ~]#
[root@arch ~]#
[root@arch ~]# echo HELO
HELO

Cristian Marussi (7):
  smp: add generic SMP-stop support to common code
  smp: unify crash_ and smp_send_stop() logic
  smp: coordinate concurrent crash/smp stop calls
  smp: address races of starting CPUs while stopping
  arm64: smp: use generic SMP stop common code
  arm64: smp: use SMP crash-stop common code
  arm64: smp: add arch specific cpu parking helper

 arch/arm64/Kconfig           |   3 +
 arch/arm64/include/asm/smp.h |   2 -
 arch/arm64/kernel/smp.c      | 127 ++++++++--------------------
 include/linux/smp.h          |  44 ++++++++++
 kernel/panic.c               |  26 ------
 kernel/smp.c                 | 158 +++++++++++++++++++++++++++++++++++
 6 files changed, 239 insertions(+), 121 deletions(-)

-- 
2.17.1

