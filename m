Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F53294B6A
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 12:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392365AbgJUKqm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 06:46:42 -0400
Received: from foss.arm.com ([217.140.110.172]:33472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390103AbgJUKqm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Oct 2020 06:46:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2832D6E;
        Wed, 21 Oct 2020 03:46:41 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 878203F66E;
        Wed, 21 Oct 2020 03:46:40 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     Morten Rasmussen <morten.rasmussen@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Qais Yousef <qais.yousef@arm.com>
Subject: [RFC PATCH v2 3/4] arm64: export emulate_sys_reg()
Date:   Wed, 21 Oct 2020 11:46:10 +0100
Message-Id: <20201021104611.2744565-4-qais.yousef@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021104611.2744565-1-qais.yousef@arm.com>
References: <20201021104611.2744565-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

And get_arm64_ftr_reg() to allow exposing sanitized version of
id_aa64fpr0 register to user space.

To avoid a clash, rename emulate_sys_reg() in kvm code to be prefixed
with 'kvm_'.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 3 +++
 arch/arm64/kernel/cpufeature.c      | 4 ++--
 arch/arm64/kvm/sys_regs.c           | 4 ++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 338637907e6a..2b87f17b2bd4 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -80,6 +80,8 @@ struct arm64_ftr_reg {
 
 extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
 
+struct arm64_ftr_reg *get_arm64_ftr_reg(u32 sys_id);
+
 extern unsigned int __read_mostly sysctl_enable_asym_32bit;
 
 /*
@@ -579,6 +581,7 @@ void __init setup_cpu_features(void);
 void check_local_cpu_capabilities(void);
 
 u64 read_sanitised_ftr_reg(u32 id);
+int emulate_sys_reg(u32 id, u64 *valp);
 
 static inline bool cpu_supports_mixed_endian_el0(void)
 {
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 1bbdfa9e911d..6f795c8221f4 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -648,7 +648,7 @@ static struct arm64_ftr_reg *get_arm64_ftr_reg_nowarn(u32 sys_id)
  * returns - Upon success,  matching ftr_reg entry for id.
  *         - NULL on failure but with an WARN_ON().
  */
-static struct arm64_ftr_reg *get_arm64_ftr_reg(u32 sys_id)
+struct arm64_ftr_reg *get_arm64_ftr_reg(u32 sys_id)
 {
 	struct arm64_ftr_reg *reg;
 
@@ -2774,7 +2774,7 @@ static inline int emulate_id_reg(u32 id, u64 *valp)
 	return 0;
 }
 
-static int emulate_sys_reg(u32 id, u64 *valp)
+int emulate_sys_reg(u32 id, u64 *valp)
 {
 	struct arm64_ftr_reg *regp;
 
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index c9fb172f9b01..aad0ef7489db 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2353,7 +2353,7 @@ static bool is_imp_def_sys_reg(struct sys_reg_params *params)
 	return params->Op0 == 3 && (params->CRn & 0b1011) == 0b1011;
 }
 
-static int emulate_sys_reg(struct kvm_vcpu *vcpu,
+static int kvm_emulate_sys_reg(struct kvm_vcpu *vcpu,
 			   struct sys_reg_params *params)
 {
 	const struct sys_reg_desc *r;
@@ -2412,7 +2412,7 @@ int kvm_handle_sys_reg(struct kvm_vcpu *vcpu)
 	params.regval = vcpu_get_reg(vcpu, Rt);
 	params.is_write = !(esr & 1);
 
-	ret = emulate_sys_reg(vcpu, &params);
+	ret = kvm_emulate_sys_reg(vcpu, &params);
 
 	if (!params.is_write)
 		vcpu_set_reg(vcpu, Rt, params.regval);
-- 
2.25.1

