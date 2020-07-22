Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F0A229D5B
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jul 2020 18:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731141AbgGVQpK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jul 2020 12:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731025AbgGVQpI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2020 12:45:08 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4936C0619E0
        for <linux-arch@vger.kernel.org>; Wed, 22 Jul 2020 09:45:07 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s10so2533570wrw.12
        for <linux-arch@vger.kernel.org>; Wed, 22 Jul 2020 09:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZXiAbLOq4ubRUcURJC9B1BLv2xJ+3CpTn0EBGii9veo=;
        b=FdmUXfPpY7o9uEYvSP5nVu4ofg8PL0EkzaQt7c+IphnlbncN6veKPYDXPYLTXRODhI
         6vN22+BUNOewLPRoB+VyntfTGU4957QCwvCWV4Rw7/XkrQ5nCgRdII3n6ncKJXismyaG
         QS0jI990BiiNf12aOl1OO24EJqhL4eaTHvJhZbTDwwVFTC3dpmWz+SUWBIJik8UNPp67
         ECuHSrQPykTUctnyqBj2l7S9VS7/jA1LuCpMeq71p8zbNS1+omtsRiI4ZMO+HJbglaMO
         Mum0PSJ1/kp1e9/TTPm0RAKKWXHtacAuaJYN4Yme80qiYihUdK+xHTp+LbJ5sEzZYVCJ
         fGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZXiAbLOq4ubRUcURJC9B1BLv2xJ+3CpTn0EBGii9veo=;
        b=UyQFr9GBbyb3RBqvw70829WZI6weKTCXNw8wT7Zjc66uhHBnA8pAZ4WvYoAOnYL00r
         kswkHEMw4d8bEUeeyLzuxlZJC7GRa9Kvy43GIU8EQ2fxBEmIMzHaKlS4K4bqyMDt4zpc
         ZpEDBHqBKE9Z6a2PJH+AxeVNt8RVnAKVd7QvbLn32ri2UpzF8/P+RdM5PsmCxgL8mfqD
         g+ZqVR2vKu63Gcn+ZPHjlU5tbadviAb83h1t4PjAieAXaEBGpzWuv8xfmIblGewVKwME
         r+r3A5jjw6eVo08A5fDUgcOrlMI0pC+wk8V+KP8Tb9mlnGyUmeVKiLWp426xCEglz7Gq
         M2NA==
X-Gm-Message-State: AOAM533V8GspxphMRH9Akv8H7tkq6iyJ3/lQCP/AVaF8Zi5tgRvzoHdi
        7USQqnUjU0rZNfIlyP70dd9Mhg==
X-Google-Smtp-Source: ABdhPJzJgI+HFT65fE1fBmZ9mEiYEXOQtPMo4T9cTDa2bRmHKYwwP+XUbleLmCwLMIPgGxnThsRfXw==
X-Received: by 2002:a5d:6288:: with SMTP id k8mr347278wru.373.1595436306334;
        Wed, 22 Jul 2020 09:45:06 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:b0ee:900a:e004:b9d0])
        by smtp.gmail.com with ESMTPSA id 33sm590292wri.16.2020.07.22.09.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 09:45:05 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
        kernel-team@google.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH 4/9] kvm: arm64: Add helpers for accessing nVHE hyp per-cpu vars
Date:   Wed, 22 Jul 2020 17:44:19 +0100
Message-Id: <20200722164424.42225-5-dbrazdil@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722164424.42225-1-dbrazdil@google.com>
References: <20200722164424.42225-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Defining a per-CPU variable in hyp/nvhe will result in its name being prefixed
with __kvm_nvhe_. Add helpers for declaring these variables in kernel proper
and accessing them with this_cpu_ptr and per_cpu_ptr.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_asm.h | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index bbd14e205aba..3d69cab873e4 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -60,9 +60,21 @@
 	DECLARE_KVM_VHE_SYM(sym);		\
 	DECLARE_KVM_NVHE_SYM(sym)
 
+#define DECLARE_KVM_VHE_PER_CPU(type, sym)	\
+	DECLARE_PER_CPU(type, sym)
+#define DECLARE_KVM_NVHE_PER_CPU(type, sym)	\
+	DECLARE_PER_CPU(type, kvm_nvhe_sym(sym))
+
+#define DECLARE_KVM_HYP_PER_CPU(type, sym)	\
+	DECLARE_KVM_VHE_PER_CPU(type, sym);	\
+	DECLARE_KVM_NVHE_PER_CPU(type, sym)
+
 #define CHOOSE_VHE_SYM(sym)	sym
 #define CHOOSE_NVHE_SYM(sym)	kvm_nvhe_sym(sym)
 
+#define this_cpu_ptr_nvhe(sym)		this_cpu_ptr(&kvm_nvhe_sym(sym))
+#define per_cpu_ptr_nvhe(sym, cpu)	per_cpu_ptr(&kvm_nvhe_sym(sym), cpu)
+
 #ifndef __KVM_NVHE_HYPERVISOR__
 /*
  * BIG FAT WARNINGS:
@@ -75,12 +87,21 @@
  * - Don't let the nVHE hypervisor have access to this, as it will
  *   pick the *wrong* symbol (yes, it runs at EL2...).
  */
-#define CHOOSE_HYP_SYM(sym)	(is_kernel_in_hyp_mode() ? CHOOSE_VHE_SYM(sym) \
+#define CHOOSE_HYP_SYM(sym)		(is_kernel_in_hyp_mode()	\
+					   ? CHOOSE_VHE_SYM(sym)	\
 					   : CHOOSE_NVHE_SYM(sym))
+#define this_cpu_ptr_hyp(sym)		(is_kernel_in_hyp_mode()	\
+					   ? this_cpu_ptr(&sym)		\
+					   : this_cpu_ptr_nvhe(sym))
+#define per_cpu_ptr_hyp(sym, cpu)	(is_kernel_in_hyp_mode()	\
+					   ? per_cpu_ptr(&sym, cpu)	\
+					   : per_cpu_ptr_nvhe(sym, cpu))
 #else
 /* The nVHE hypervisor shouldn't even try to access anything */
 extern void *__nvhe_undefined_symbol;
-#define CHOOSE_HYP_SYM(sym)	__nvhe_undefined_symbol
+#define CHOOSE_HYP_SYM(sym)		__nvhe_undefined_symbol
+#define this_cpu_ptr_hyp(sym)		&__nvhe_undefined_symbol
+#define per_cpu_ptr_hyp(sym, cpu)	&__nvhe_undefined_symbol
 #endif
 
 /* Translate a kernel address @ptr into its equivalent linear mapping */
-- 
2.27.0

