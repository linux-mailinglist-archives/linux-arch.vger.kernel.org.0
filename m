Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06DC03B4D5B
	for <lists+linux-arch@lfdr.de>; Sat, 26 Jun 2021 09:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhFZH31 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Jun 2021 03:29:27 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:8326 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhFZH3Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Jun 2021 03:29:25 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GBlhB5Rvrz6xt9;
        Sat, 26 Jun 2021 15:22:50 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 15:27:00 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 15:26:59 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Arnd Bergmann <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Chancellor <nathan@kernel.org>, <bpf@vger.kernel.org>
Subject: [PATCH 5/9] kallsyms: Rename is_kernel() and is_kernel_text()
Date:   Sat, 26 Jun 2021 15:34:35 +0800
Message-ID: <20210626073439.150586-6-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210626073439.150586-1-wangkefeng.wang@huawei.com>
References: <20210626073439.150586-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
index 2a2e290fa5d8..b1ed4a0bfc86 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -376,7 +376,7 @@ static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 		       void *old_addr, void *new_addr)
 {
-	if (!is_kernel_text((long)ip) &&
+	if (!is_kernel_text_or_gate_area((long)ip) &&
 	    !is_bpf_text_address((long)ip))
 		/* BPF poking in modules is not supported */
 		return -EINVAL;
diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index 3e172fc65fae..814e1cc8eabf 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -23,14 +23,14 @@
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
@@ -40,9 +40,9 @@ static inline int is_kernel(unsigned long addr)
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

