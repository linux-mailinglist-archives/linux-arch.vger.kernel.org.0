Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C05287B7F
	for <lists+linux-arch@lfdr.de>; Thu,  8 Oct 2020 20:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgJHSQ5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Oct 2020 14:16:57 -0400
Received: from foss.arm.com ([217.140.110.172]:42696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbgJHSQ4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Oct 2020 14:16:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AC451529;
        Thu,  8 Oct 2020 11:16:55 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BBC73F802;
        Thu,  8 Oct 2020 11:16:54 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     Morten Rasmussen <morten.rasmussen@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Qais Yousef <qais.yousef@arm.com>
Subject: [RFC PATCH 1/3] arm64: kvm: Handle Asymmetric AArch32 systems
Date:   Thu,  8 Oct 2020 19:16:39 +0100
Message-Id: <20201008181641.32767-2-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201008181641.32767-1-qais.yousef@arm.com>
References: <20201008181641.32767-1-qais.yousef@arm.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On a system without uniform support for AArch32 at EL0, it is possible
for the guest to force run AArch32 at EL0 and potentially cause an
illegal exception if running on the wrong core.

Add an extra check to catch if the guest ever does that and prevent it
from running again, treating it as ARM_EXCEPTION_IL.

We try to catch this misbehavior as early as possible and not rely on
PSTATE.IL to occur.

Tested on Juno by instrumenting the host to:

	* Fake asym aarch32.
	* Comment out hiding of ID registers from the guest.

Any attempt to run 32bit app in the guest will produce such error on
qemu:

	# ./test
	error: kvm run failed Invalid argument
	R00=ffff0fff R01=ffffffff R02=00000000 R03=00087968
	R04=000874b8 R05=ffd70b24 R06=ffd70b2c R07=00000055
	R08=00000000 R09=00000000 R10=00000000 R11=00000000
	R12=0000001c R13=ffd6f974 R14=0001ff64 R15=ffff0fe0
	PSR=a0000010 N-C- A usr32

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 arch/arm64/kvm/arm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index b588c3b5c2f0..22ff3373d855 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -644,6 +644,11 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	struct kvm_run *run = vcpu->run;
 	int ret;
 
+	if (!system_supports_32bit_el0() && vcpu_mode_is_32bit(vcpu)) {
+		kvm_err("Illegal AArch32 mode at EL0, can't run.");
+		return -ENOEXEC;
+	}
+
 	if (unlikely(!kvm_vcpu_initialized(vcpu)))
 		return -ENOEXEC;
 
@@ -804,6 +809,17 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 
 		preempt_enable();
 
+		/*
+		 * For asym aarch32 systems we present a 64bit only system to
+		 * the guest. But in case it managed somehow to escape that and
+		 * enter 32bit mode, catch that and prevent it from running
+		 * again.
+		 */
+		if (!system_supports_32bit_el0() && vcpu_mode_is_32bit(vcpu)) {
+			kvm_err("Detected illegal AArch32 mode at EL0, exiting.");
+			ret = ARM_EXCEPTION_IL;
+		}
+
 		ret = handle_exit(vcpu, ret);
 	}
 
-- 
2.17.1

