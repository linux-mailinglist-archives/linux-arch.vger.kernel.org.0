Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E21F799D57
	for <lists+linux-arch@lfdr.de>; Sun, 10 Sep 2023 10:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237498AbjIJIcg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 10 Sep 2023 04:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241570AbjIJIcf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 10 Sep 2023 04:32:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0191210F6;
        Sun, 10 Sep 2023 01:32:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4096C43397;
        Sun, 10 Sep 2023 08:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694334710;
        bh=ZxSSeBb/S16STGNIjLgLnRd4gdTK7GWBFlxeOcsXSwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r+LRgGMW/xx8261kzbec/7ectryiunjI7NOKoSUJZMQ5GO9xW2FzxB+MpQTjPJwrP
         GqZmGTDK/Cn5Uldm9Mx54IZVN/eDq1LT+Hrd6ayDASK2ZXJSqpekvxQPcGwsuaX5J2
         U41UBqPSUW/oUH3AuoETyRMVkb9twscE6eYAz1hJSWU9FodNY8BV2gv7nBtWI0BMYk
         gDPHGGttiPk/+RxqXz0RzsFAlZOZxTaiTRLevDEXWEaO/LtMjz+hekQH0J1QF/dJuq
         CVBIe+GUx3doKxK4ICkFhf1vXR716rIvyf8B97hkgFqJ6R+xJQkXq0oOtqrgScC3qw
         ALUrMl2iBo61w==
From:   guoren@kernel.org
To:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        conor.dooley@microchip.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        leobras@redhat.com
Cc:     linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH V11 17/17] RISC-V: paravirt: pvqspinlock: KVM: Implement kvm_sbi_ext_pvlock_kick_cpu()
Date:   Sun, 10 Sep 2023 04:29:11 -0400
Message-Id: <20230910082911.3378782-18-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230910082911.3378782-1-guoren@kernel.org>
References: <20230910082911.3378782-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

We only need to call the kvm_vcpu_kick() and bring target_vcpu
from the halt state. No irq raised, no other request, just a pure
vcpu_kick.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/kvm/vcpu_sbi_pvlock.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/riscv/kvm/vcpu_sbi_pvlock.c b/arch/riscv/kvm/vcpu_sbi_pvlock.c
index 544a456c5041..914fc58aedfe 100644
--- a/arch/riscv/kvm/vcpu_sbi_pvlock.c
+++ b/arch/riscv/kvm/vcpu_sbi_pvlock.c
@@ -12,6 +12,24 @@
 #include <asm/sbi.h>
 #include <asm/kvm_vcpu_sbi.h>
 
+static int kvm_sbi_ext_pvlock_kick_cpu(struct kvm_vcpu *vcpu)
+{
+	struct kvm_cpu_context *cp = &vcpu->arch.guest_context;
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_vcpu *target;
+
+	target = kvm_get_vcpu_by_id(kvm, cp->a0);
+	if (!target)
+		return SBI_ERR_INVALID_PARAM;
+
+	kvm_vcpu_kick(target);
+
+	if (READ_ONCE(target->ready))
+		kvm_vcpu_yield_to(target);
+
+	return SBI_SUCCESS;
+}
+
 static int kvm_sbi_ext_pvlock_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 				      struct kvm_vcpu_sbi_return *retdata)
 {
@@ -21,6 +39,7 @@ static int kvm_sbi_ext_pvlock_handler(struct kvm_vcpu *vcpu, struct kvm_run *run
 
 	switch (funcid) {
 	case SBI_EXT_PVLOCK_KICK_CPU:
+		ret = kvm_sbi_ext_pvlock_kick_cpu(vcpu);
 		break;
 	default:
 		ret = SBI_ERR_NOT_SUPPORTED;
-- 
2.36.1

