Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3226287B7E
	for <lists+linux-arch@lfdr.de>; Thu,  8 Oct 2020 20:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgJHSQx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Oct 2020 14:16:53 -0400
Received: from foss.arm.com ([217.140.110.172]:42680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbgJHSQx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Oct 2020 14:16:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 497F8D6E;
        Thu,  8 Oct 2020 11:16:52 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED9113F802;
        Thu,  8 Oct 2020 11:16:50 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     Morten Rasmussen <morten.rasmussen@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Qais Yousef <qais.yousef@arm.com>
Subject: [RFC PATCH 0/3] Add support for Asymmetric AArch32 systems
Date:   Thu,  8 Oct 2020 19:16:38 +0100
Message-Id: <20201008181641.32767-1-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This RFC series enables AArch32 EL0 support on systems where only a subset of
CPUs implement it. AArch32 feature asymmetry comes with downsides, but it is
likely that some vendors are willing to accept those to maintain AArch32 EL0
support on systems where some cores are AArch64 only.

Enabling AArch32 when it isn't supported on all CPUs inevitably requires
careful affinity management of AArch32 tasks. The bare minimum kernel support
is offered by the second patch which put the burden of managing task affinity
entirely on user-space. AAarch32 tasks receive SIGKILL if they try to run on
a non-AArch32 CPU. The third patch is optional and overrides task affinity in
some cases to prevent AArch32 tasks getting SIGKILL.

We don't expose the asymmetry to userspace. If we want to delegate affinity
management to user space we need to introduce a way to do that.
/sys/devices/system/cpu/cpu*/regs/identification/midr_el1 contains the specific
CPU ID. This could be extended to expose the other ID_* registers where the
AArch32 feature can be detected.

If the user hotplugs all 32bit capable CPUs, then all running 32bit tasks will
be SIGKILLed if scheduled.

Patch 1 ensures KVM handles such systems properly. Especially if the guest is
misbehaving and tries to force run aarch32 regardless of what ID registers
advertise.

Patch 2 introduces basic asymetric aarch32 support. It will SIGKILL any task as
soon as it scheduled on the wrong CPU even if its affinity allows it to migrate
to a capable CPU.

Patch 3 suggests how handling the affinity problem could be done in the kernel.
It's not a generic solution, rather a demonstration of what could potentially
be done.

Qais Yousef (3):
  arm64: kvm: Handle Asymmetric AArch32 systems
  arm64: Add support for asymmetric AArch32 EL0 configurations
  arm64: Handle AArch32 tasks running on non AArch32 cpu

 arch/arm64/Kconfig                   | 14 +++++
 arch/arm64/include/asm/cpu.h         |  2 +
 arch/arm64/include/asm/cpucaps.h     |  3 +-
 arch/arm64/include/asm/cpufeature.h  | 22 +++++++-
 arch/arm64/include/asm/thread_info.h |  5 +-
 arch/arm64/kernel/cpufeature.c       | 77 ++++++++++++++++++----------
 arch/arm64/kernel/cpuinfo.c          | 71 +++++++++++++++----------
 arch/arm64/kernel/process.c          | 17 ++++++
 arch/arm64/kernel/signal.c           | 33 ++++++++++++
 arch/arm64/kvm/arm.c                 | 17 ++++++
 arch/arm64/kvm/guest.c               |  2 +-
 arch/arm64/kvm/sys_regs.c            | 14 ++++-
 12 files changed, 218 insertions(+), 59 deletions(-)

-- 
2.17.1

