Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF8258C4A4
	for <lists+linux-arch@lfdr.de>; Mon,  8 Aug 2022 10:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241874AbiHHIGo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Aug 2022 04:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242100AbiHHIGf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Aug 2022 04:06:35 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93D313DD0;
        Mon,  8 Aug 2022 01:06:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 31CD7CE0F72;
        Mon,  8 Aug 2022 08:06:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C072DC433C1;
        Mon,  8 Aug 2022 08:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659945987;
        bh=O8oJK7US06ctrbwrFK6AhnyYDVDe+qcc6oGaVuVbZgk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ucjfa6QfVZzSkAjPgs+tH771FrLQURJA+lcfQx6r7YbD4/+oWwzq9VqbkDhxMtwpK
         M4PQGbG9i9IrK4C4ChmTS4G1RxftMkmtv+4DPkPXeyMRy6mGr0g9hTpi9pVm4oPLBF
         2VBprduojP+o/X10wgiUPiiGuTuRr5E0du2iCpuUnjFCKhFMAxAZp9E95f0X7OMEld
         UDMFlZGorX/8I81qppDNYpfJnEVKmX2T9U7Rg4KI0L7QxH8n6SSsc85degeud2H7xx
         NPxf9DwuyYqcgXaP2tca9Gm+PAByQH5Jlt6ZZaiKfUCOSUsXpOEk0SCiumE8caJhVy
         L8mCL/mnosJuw==
From:   guoren@kernel.org
To:     tj@kernel.org, cl@linux.com, palmer@dabbelt.com, will@kernel.org,
        catalin.marinas@arm.com, peterz@infradead.org, arnd@arndb.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>, Guo Ren <guoren@kernel.org>
Subject: [RFC PATCH 3/4] riscv: percpu: Implement this_cpu operations
Date:   Mon,  8 Aug 2022 04:05:59 -0400
Message-Id: <20220808080600.3346843-4-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220808080600.3346843-1-guoren@kernel.org>
References: <20220808080600.3346843-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This patch provides riscv specific implementations for the this_cpu
operations. We use atomic operations as appropriate (32 & 64 width).

Use AMO instructions listed below for percpu, others are generic:
 - amoadd.w/d
 - amoand.w/d
 - amoor.w/d
 - amoswap.w/d

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/percpu.h | 104 ++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 arch/riscv/include/asm/percpu.h

diff --git a/arch/riscv/include/asm/percpu.h b/arch/riscv/include/asm/percpu.h
new file mode 100644
index 000000000000..f41d339c41f3
--- /dev/null
+++ b/arch/riscv/include/asm/percpu.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _ASM_RISCV_PERCPU_H
+#define _ASM_RISCV_PERCPU_H
+
+#include <asm/cmpxchg.h>
+
+#define __PERCPU_OP_CASE(asm_type, name, sz, asm_op)			\
+static inline void							\
+__percpu_##name##_case_##sz(void *ptr, ulong val)			\
+{									\
+	__asm__ __volatile__ (						\
+		"	amo" #asm_op "." #asm_type " zero, %1, (%0)"	\
+		:							\
+		: "r" (ptr), "r" (val)					\
+		: "memory");						\
+}
+
+#define __PERCPU_RET_OP_CASE(asm_type, name, sz, asm_op, c_op)		\
+static inline u##sz							\
+__percpu_##name##_return_case_##sz(void *ptr, ulong val)		\
+{									\
+	u##sz ret;							\
+	__asm__ __volatile__ (						\
+		"	amo" #asm_op "." #asm_type " %0, %2, (%1)"	\
+		: "=r" (ret)						\
+		: "r" (ptr), "r" (val)					\
+		: "memory");						\
+									\
+	return ret c_op val;						\
+}
+
+#ifdef CONFIG_64BIT
+#define PERCPU_OP(name, asm_op)						\
+	__PERCPU_OP_CASE(w, name, 32, asm_op)				\
+	__PERCPU_OP_CASE(d, name, 64, asm_op)
+
+#define PERCPU_RET_OP(name, asm_op, c_op)				\
+	__PERCPU_RET_OP_CASE(w, name, 32, asm_op, c_op)			\
+	__PERCPU_RET_OP_CASE(d, name, 64, asm_op, c_op)
+#else  /* CONFIG_32BIT */
+#define PERCPU_OP(name, asm_op)						\
+	__PERCPU_OP_CASE(w, name, 32, asm_op)
+
+#define PERCPU_RET_OP(name, asm_op, c_op)				\
+	__PERCPU_RET_OP_CASE(w, name, 32, asm_op, c_op)
+#endif /* CONFIG_64BIT */
+
+PERCPU_OP(add, add)
+PERCPU_OP(and, and)
+PERCPU_OP(or, or)
+PERCPU_RET_OP(add, add, +)
+
+#undef __PERCPU_OP_CASE
+#undef __PERCPU_RET_OP_CASE
+#undef PERCPU_OP
+#undef PERCPU_RET_OP
+
+#define _pcp_protect(op, pcp, ...)					\
+({									\
+	preempt_disable_notrace();					\
+	op(raw_cpu_ptr(&(pcp)), __VA_ARGS__);				\
+	preempt_enable_notrace();					\
+})
+
+#define _pcp_protect_return(op, pcp, args...)				\
+({									\
+	typeof(pcp) __retval;						\
+	preempt_disable_notrace();					\
+	if (__native_word(pcp)) 					\
+		__retval = (typeof(pcp))op(raw_cpu_ptr(&(pcp)), ##args);\
+	else								\
+		BUILD_BUG();						\
+	preempt_enable_notrace();					\
+	__retval;							\
+})
+
+#define this_cpu_add_4(pcp, val)	\
+	_pcp_protect(__percpu_add_case_32, pcp, val)
+#define this_cpu_add_return_4(pcp, val)	\
+	_pcp_protect_return(__percpu_add_return_case_32, pcp, val)
+#define this_cpu_and_4(pcp, val)	\
+	_pcp_protect(__percpu_and_case_32, pcp, val)
+#define this_cpu_or_4(pcp, val)		\
+	_pcp_protect(__percpu_or_case_32, pcp, val)
+#define this_cpu_xchg_4(pcp, val)	\
+	_pcp_protect_return(xchg_relaxed, pcp, val)
+
+#ifdef CONFIG_64BIT
+#define this_cpu_add_8(pcp, val)	\
+	_pcp_protect(__percpu_add_case_64, pcp, val)
+#define this_cpu_add_return_8(pcp, val)	\
+	_pcp_protect_return(__percpu_add_return_case_64, pcp, val)
+#define this_cpu_and_8(pcp, val)	\
+	_pcp_protect(__percpu_and_case_64, pcp, val)
+#define this_cpu_or_8(pcp, val)		\
+	_pcp_protect(__percpu_or_case_64, pcp, val)
+#define this_cpu_xchg_8(pcp, val)	\
+	_pcp_protect_return(xchg_relaxed, pcp, val)
+#endif /* CONFIG_64BIT */
+
+#include <asm-generic/percpu.h>
+
+#endif /* _ASM_RISCV_PERCPU_H */
-- 
2.36.1

