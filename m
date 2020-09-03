Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F82525BE4D
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 11:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgICJSo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 05:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbgICJRt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 05:17:49 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46807C061249
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 02:17:49 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id nw23so2841125ejb.4
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 02:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lr26ux0OOjKqBElJON72X2bDuUHIIFflkukJO3BWbvU=;
        b=ibaN6UVuyMWanD/p/syhzRmTyFuupe1wk12IPBNXGichEgTkklyUUzy7oxzAUVwF14
         5bnjjmfHLlMy5ji9KSMCLbP7UER0UcEHRPFkukXNMEJrAXyWkKKhNA6xGa5CjZ55qrBn
         M1JIPvdv5M1d5OYPv0nEEBa9+CWY76zMCqtZxvvUXWq+fTYMqlOYzh0VOa8DBh4sIxIU
         gPAB3kITbTsjqhMnV9JKcuqDcJEd+mL27vzwiNl8NSdIRVhBbvONoim/RFqzbpZ1zGDX
         KdUU4dB2O45UnNf3T4r/QYNBddgXEb080EB4ixmCZwI96W4HF9pMuBnfG+4vo77c214P
         +hmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lr26ux0OOjKqBElJON72X2bDuUHIIFflkukJO3BWbvU=;
        b=EiGgw8rP/LZU80OXADfxLYzyXTSNWbHv0zxH4Pg+9czqwCGVjhmZ0VYWcdPbPD84r6
         gMjxxWSsnXhsgnX+ZmtfJ0qRKABwht/2PqqdqLCmZr4U45eYoKCUam6OteLIDUxD5b3C
         z/vPKwqQGoU1q6hJhdxeKAMSSK3MoITLDpQ7K1hQKSMDj+BFVpg5UPBcZuBzj7s3QhQQ
         1L8fpmOOsxqrptceFXSFZzw4w0SzPdm+rBasdBJMWg9d9nd/hHMGnr/2XfDCkfubd584
         57Wsz3W6RdSMRDGnmWa6I0PlWFhmTa2m0jAM5nrwPZn8oRV8eycgG2rpXSv+S2K0JAmh
         EDHQ==
X-Gm-Message-State: AOAM530kftJIfnN3CLBYdDAjJU/BJFz86g5gbqS8AaOiGVvBG1HZ9Amp
        QojhpEcAC/CKB79PuTqG8has2g==
X-Google-Smtp-Source: ABdhPJzEdTeSQp0oSfef6z3rNf21sKeagThs669GopkjjafQDEK3m3QDA/V0e2Zh7SmEpjSfWGhgLw==
X-Received: by 2002:a17:906:5856:: with SMTP id h22mr1120110ejs.480.1599124667692;
        Thu, 03 Sep 2020 02:17:47 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-919a-a06e-64ac-0036-822c-68d3.ipv6.broadband.iol.cz. [2a00:1028:919a:a06e:64ac:36:822c:68d3])
        by smtp.gmail.com with ESMTPSA id gw6sm2638439ejb.47.2020.09.03.02.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 02:17:46 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v2 05/10] kvm: arm64: Add helpers for accessing nVHE hyp per-cpu vars
Date:   Thu,  3 Sep 2020 11:17:07 +0200
Message-Id: <20200903091712.46456-6-dbrazdil@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200903091712.46456-1-dbrazdil@google.com>
References: <20200903091712.46456-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Defining a per-CPU variable in hyp/nvhe will result in its name being
prefixed with __kvm_nvhe_. Add helpers for declaring these variables
in kernel proper and accessing them with this_cpu_ptr and per_cpu_ptr.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_asm.h | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 469c0662f7f3..2b89817cdb01 100644
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
+#define this_cpu_ptr_hyp(sym)		(&__nvhe_undefined_symbol)
+#define per_cpu_ptr_hyp(sym, cpu)	(&__nvhe_undefined_symbol)
 #endif
 
 /* Translate a kernel address @ptr into its equivalent linear mapping */
-- 
2.28.0.402.g5ffc5be6b7-goog

