Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46962C2BD7
	for <lists+linux-arch@lfdr.de>; Tue, 24 Nov 2020 16:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389951AbgKXPvC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Nov 2020 10:51:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:50306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389441AbgKXPvB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Nov 2020 10:51:01 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3779206FA;
        Tue, 24 Nov 2020 15:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606233061;
        bh=iGTW5DCrEcoewVMIU6VCUDyE6/613GOz/GK75KZKNjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yNprGCkZci+nY/k9S7bX+CIu2pXQVSeXYPSxqj3QRWeAoQN9lE4ckpdrm55w7hAAl
         X4j8xbx0oENN7L45Vw1V4aw512dKvmEo4mEmj4VD4N84aHzmWrfXB5BXlYsDkusr9r
         tIUnKgXX3HYobLwcovBi3dn0x4bo+cScstjtIju4=
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
Subject: [PATCH v4 03/14] KVM: arm64: Kill 32-bit vCPUs on systems with mismatched EL0 support
Date:   Tue, 24 Nov 2020 15:50:28 +0000
Message-Id: <20201124155039.13804-4-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201124155039.13804-1-will@kernel.org>
References: <20201124155039.13804-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

If a vCPU is caught running 32-bit code on a system with mismatched
support at EL0, then we should kill it.

Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/arm.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 5750ec34960e..d322ac0f4a8e 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -633,6 +633,15 @@ static void check_vcpu_requests(struct kvm_vcpu *vcpu)
 	}
 }
 
+static bool vcpu_mode_is_bad_32bit(struct kvm_vcpu *vcpu)
+{
+	if (likely(!vcpu_mode_is_32bit(vcpu)))
+		return false;
+
+	return !system_supports_32bit_el0() ||
+		static_branch_unlikely(&arm64_mismatched_32bit_el0);
+}
+
 /**
  * kvm_arch_vcpu_ioctl_run - the main VCPU run function to execute guest code
  * @vcpu:	The VCPU pointer
@@ -816,7 +825,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		 * with the asymmetric AArch32 case), return to userspace with
 		 * a fatal error.
 		 */
-		if (!system_supports_32bit_el0() && vcpu_mode_is_32bit(vcpu)) {
+		if (vcpu_mode_is_bad_32bit(vcpu)) {
 			/*
 			 * As we have caught the guest red-handed, decide that
 			 * it isn't fit for purpose anymore by making the vcpu
-- 
2.29.2.454.gaff20da3a2-goog

