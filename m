Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C59F29CB82
	for <lists+linux-arch@lfdr.de>; Tue, 27 Oct 2020 22:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374482AbgJ0Vv1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Oct 2020 17:51:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505991AbgJ0Vv1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Oct 2020 17:51:27 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC0782222C;
        Tue, 27 Oct 2020 21:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603835486;
        bh=Esg3EpfECFhTL7iOJ/NxBoUqAj8LX4q6jNym7Nfr4Mg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wfeRS9GZUSTaVPY8xaTFMD+96LQjW11D886hCcuB950L8h1O6rLEFyxbmF3qmBMDH
         fY5AkV1PLoGFmxSL0vYvc/koVgyRjyQ+5H9cKcnW0fMncOmrrFadiXejDkpvPIOMsP
         ZDHgILA2q3Xn13YJeeBvUV0Nm57BXbl1oyKU12uw=
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, James Morse <james.morse@arm.com>
Subject: [PATCH 1/6] KVM: arm64: Handle Asymmetric AArch32 systems
Date:   Tue, 27 Oct 2020 21:51:13 +0000
Message-Id: <20201027215118.27003-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027215118.27003-1-will@kernel.org>
References: <20201027215118.27003-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Qais Yousef <qais.yousef@arm.com>

On a system without uniform support for AArch32 at EL0, it is possible
for the guest to force run AArch32 at EL0 and potentially cause an
illegal exception if running on a core without AArch32. Add an extra
check so that if we catch the guest doing that, then we prevent it from
running again by resetting vcpu->arch.target and return
ARM_EXCEPTION_IL.

We try to catch this misbehaviour as early as possible and not rely on
an illegal exception occuring to signal the problem. Attempting to run a
32bit app in the guest will produce an error from QEMU if the guest
exits while running in AArch32 EL0.

Tested on Juno by instrumenting the host to fake asym aarch32 and
instrumenting KVM to make the asymmetry visible to the guest.

Cc: James Morse <james.morse@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
[will: Incorporated feedback from Marc]
Link: https://lore.kernel.org/r/20201021104611.2744565-2-qais.yousef@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/arm.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index f56122eedffc..a3b32df1afb0 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -808,6 +808,25 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 
 		preempt_enable();
 
+		/*
+		 * The ARMv8 architecture doesn't give the hypervisor
+		 * a mechanism to prevent a guest from dropping to AArch32 EL0
+		 * if implemented by the CPU. If we spot the guest in such
+		 * state and that we decided it wasn't supposed to do so (like
+		 * with the asymmetric AArch32 case), return to userspace with
+		 * a fatal error.
+		 */
+		if (!system_supports_32bit_el0() && vcpu_mode_is_32bit(vcpu)) {
+			/*
+			 * As we have caught the guest red-handed, decide that
+			 * it isn't fit for purpose anymore by making the vcpu
+			 * invalid. The VMM can try and fix it by issuing  a
+			 * KVM_ARM_VCPU_INIT if it really wants to.
+			 */
+			vcpu->arch.target = -1;
+			ret = ARM_EXCEPTION_IL;
+		}
+
 		ret = handle_exit(vcpu, ret);
 	}
 
-- 
2.29.0.rc2.309.g374f81d7ae-goog

