Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C473A3D8972
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jul 2021 10:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbhG1IH1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jul 2021 04:07:27 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:12275 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbhG1IHZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jul 2021 04:07:25 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GZR1x6dsFz1CPkQ;
        Wed, 28 Jul 2021 16:01:25 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 16:07:14 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 16:07:13 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <rostedt@goodmis.org>, <mingo@redhat.com>, <davem@davemloft.net>,
        <ast@kernel.org>, <ryabinin.a.a@gmail.com>
CC:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, Kefeng Wang <wangkefeng.wang@huawei.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Nathan Chancellor" <nathan@kernel.org>, <bpf@vger.kernel.org>
Subject: [PATCH v2 5/7] kallsyms: Rename is_kernel() and is_kernel_text()
Date:   Wed, 28 Jul 2021 16:13:18 +0800
Message-ID: <20210728081320.20394-6-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210728081320.20394-1-wangkefeng.wang@huawei.com>
References: <20210728081320.20394-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The is_kernel[_text]() function check the address whether or not
in kernel[_text] ranges, also they will check the address whether
or not in gate area, so use better name.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: bpf@vger.kernel.org
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/x86/net/bpf_jit_comp.c | 2 +-
 include/linux/kallsyms.h    | 8 ++++----
 kernel/cfi.c                | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 333650b9372a..c87d0dd4370d 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -372,7 +372,7 @@ static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 		       void *old_addr, void *new_addr)
 {
-	if (!is_kernel_text((long)ip) &&
+	if (!is_kernel_text_or_gate_area((long)ip) &&
 	    !is_bpf_text_address((long)ip))
 		/* BPF poking in modules is not supported */
 		return -EINVAL;
diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index 8a9d329c927c..4f501ac9c2c2 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -24,14 +24,14 @@
 struct cred;
 struct module;
 
-static inline int is_kernel_text(unsigned long addr)
+static inline int is_kernel_text_or_gate_area(unsigned long addr)
 {
 	if ((addr >= (unsigned long)_stext && addr < (unsigned long)_etext))
 		return 1;
 	return in_gate_area_no_mm(addr);
 }
 
-static inline int is_kernel(unsigned long addr)
+static inline int is_kernel_or_gate_area(unsigned long addr)
 {
 	if (addr >= (unsigned long)_stext && addr < (unsigned long)_end)
 		return 1;
@@ -41,9 +41,9 @@ static inline int is_kernel(unsigned long addr)
 static inline int is_ksym_addr(unsigned long addr)
 {
 	if (IS_ENABLED(CONFIG_KALLSYMS_ALL))
-		return is_kernel(addr);
+		return is_kernel_or_gate_area(addr);
 
-	return is_kernel_text(addr) || is_kernel_inittext(addr);
+	return is_kernel_text_or_gate_area(addr) || is_kernel_inittext(addr);
 }
 
 static inline void *dereference_symbol_descriptor(void *ptr)
diff --git a/kernel/cfi.c b/kernel/cfi.c
index e17a56639766..e7d90eff4382 100644
--- a/kernel/cfi.c
+++ b/kernel/cfi.c
@@ -282,7 +282,7 @@ static inline cfi_check_fn find_check_fn(unsigned long ptr)
 {
 	cfi_check_fn fn = NULL;
 
-	if (is_kernel_text(ptr))
+	if (is_kernel_text_or_gate_area(ptr))
 		return __cfi_check;
 
 	/*
-- 
2.26.2

