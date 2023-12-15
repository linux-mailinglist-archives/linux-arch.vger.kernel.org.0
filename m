Return-Path: <linux-arch+bounces-1067-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E1A814478
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 10:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0045B1F235B3
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 09:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8EC18045;
	Fri, 15 Dec 2023 09:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bnPrR5+C"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C976814290;
	Fri, 15 Dec 2023 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=78VUp4ekMeaCQuFyW0sC3Rbbj/THiYo4c7UXzXOpUYU=; b=bnPrR5+CXr7BBoaFWXx1hwtAwH
	2F2PEBm7YfZ8Z+ek5E6sU2NggQXV8mH21iJOx8IuUUKojL8nl8piu1SVhyFdQehQqPX2euFT8vltW
	gihZz2bb9gv+VspJ5CUh/WjJz42XFPueBSyn/WRVvdtzjuELfVeUcwPUpxitCH1rPHzI5cnsWn6R6
	OA71iWY86Q5Duna4NQFs5qEO9r76fyhbsZt9MW8nobXMxoFO5xvrRTH57KxULwxHYWII82RLcrG8u
	0xuFVu5NdLh7F6MnKASZQN+xq+AblZov9qntQ2dc8J39R9EsSjSbj7uUsPN6ddau0FzX8ZUSPYnLe
	HmXCrtSg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rE4ZE-00FSOc-4Z; Fri, 15 Dec 2023 09:33:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id DB5FA301157; Fri, 15 Dec 2023 10:33:11 +0100 (CET)
Message-Id: <20231215092707.799451071@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 15 Dec 2023 10:12:22 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: paul.walmsley@sifive.com,
 palmer@dabbelt.com,
 aou@eecs.berkeley.edu,
 tglx@linutronix.de,
 mingo@redhat.com,
 bp@alien8.de,
 dave.hansen@linux.intel.com,
 x86@kernel.org,
 hpa@zytor.com,
 davem@davemloft.net,
 dsahern@kernel.org,
 daniel@iogearbox.net,
 andrii@kernel.org,
 martin.lau@linux.dev,
 song@kernel.org,
 yonghong.song@linux.dev,
 john.fastabend@gmail.com,
 kpsingh@kernel.org,
 sdf@google.com,
 haoluo@google.com,
 jolsa@kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 samitolvanen@google.com,
 keescook@chromium.org,
 nathan@kernel.org,
 ndesaulniers@google.com,
 linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org,
 bpf@vger.kernel.org,
 linux-arch@vger.kernel.org,
 llvm@lists.linux.dev,
 jpoimboe@kernel.org,
 joao@overdrivepizza.com,
 mark.rutland@arm.com,
 peterz@infradead.org
Subject: [PATCH v3 6/7] bpf: Fix dtor CFI
References: <20231215091216.135791411@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Ensure the various dtor functions match their prototype and retain
their CFI signatures, since they don't have their address taken, they
are prone to not getting CFI, making them impossible to call
indirectly.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/bpf/cpumask.c |    8 +++++++-
 kernel/bpf/helpers.c |   16 ++++++++++++++--
 net/bpf/test_run.c   |   15 +++++++++++++--
 3 files changed, 34 insertions(+), 5 deletions(-)

--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -96,6 +96,12 @@ __bpf_kfunc void bpf_cpumask_release(str
 	migrate_enable();
 }
 
+__bpf_kfunc void bpf_cpumask_release_dtor(void *cpumask)
+{
+	bpf_cpumask_release(cpumask);
+}
+CFI_NOSEAL(bpf_cpumask_release_dtor);
+
 /**
  * bpf_cpumask_first() - Get the index of the first nonzero bit in the cpumask.
  * @cpumask: The cpumask being queried.
@@ -441,7 +447,7 @@ static const struct btf_kfunc_id_set cpu
 
 BTF_ID_LIST(cpumask_dtor_ids)
 BTF_ID(struct, bpf_cpumask)
-BTF_ID(func, bpf_cpumask_release)
+BTF_ID(func, bpf_cpumask_release_dtor)
 
 static int __init cpumask_kfunc_init(void)
 {
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2150,6 +2150,12 @@ __bpf_kfunc void bpf_task_release(struct
 	put_task_struct_rcu_user(p);
 }
 
+__bpf_kfunc void bpf_task_release_dtor(void *p)
+{
+	put_task_struct_rcu_user(p);
+}
+CFI_NOSEAL(bpf_task_release_dtor);
+
 #ifdef CONFIG_CGROUPS
 /**
  * bpf_cgroup_acquire - Acquire a reference to a cgroup. A cgroup acquired by
@@ -2174,6 +2180,12 @@ __bpf_kfunc void bpf_cgroup_release(stru
 	cgroup_put(cgrp);
 }
 
+__bpf_kfunc void bpf_cgroup_release_dtor(void *cgrp)
+{
+	cgroup_put(cgrp);
+}
+CFI_NOSEAL(bpf_cgroup_release_dtor);
+
 /**
  * bpf_cgroup_ancestor - Perform a lookup on an entry in a cgroup's ancestor
  * array. A cgroup returned by this kfunc which is not subsequently stored in a
@@ -2570,10 +2582,10 @@ static const struct btf_kfunc_id_set gen
 
 BTF_ID_LIST(generic_dtor_ids)
 BTF_ID(struct, task_struct)
-BTF_ID(func, bpf_task_release)
+BTF_ID(func, bpf_task_release_dtor)
 #ifdef CONFIG_CGROUPS
 BTF_ID(struct, cgroup)
-BTF_ID(func, bpf_cgroup_release)
+BTF_ID(func, bpf_cgroup_release_dtor)
 #endif
 
 BTF_SET8_START(common_btf_ids)
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -600,10 +600,21 @@ __bpf_kfunc void bpf_kfunc_call_test_rel
 	refcount_dec(&p->cnt);
 }
 
+__bpf_kfunc void bpf_kfunc_call_test_release_dtor(void *p)
+{
+	bpf_kfunc_call_test_release(p);
+}
+CFI_NOSEAL(bpf_kfunc_call_test_release_dtor);
+
 __bpf_kfunc void bpf_kfunc_call_memb_release(struct prog_test_member *p)
 {
 }
 
+__bpf_kfunc void bpf_kfunc_call_memb_release_dtor(void *p)
+{
+}
+CFI_NOSEAL(bpf_kfunc_call_memb_release_dtor);
+
 __bpf_kfunc_end_defs();
 
 BTF_SET8_START(bpf_test_modify_return_ids)
@@ -1671,9 +1682,9 @@ static const struct btf_kfunc_id_set bpf
 
 BTF_ID_LIST(bpf_prog_test_dtor_kfunc_ids)
 BTF_ID(struct, prog_test_ref_kfunc)
-BTF_ID(func, bpf_kfunc_call_test_release)
+BTF_ID(func, bpf_kfunc_call_test_release_dtor)
 BTF_ID(struct, prog_test_member)
-BTF_ID(func, bpf_kfunc_call_memb_release)
+BTF_ID(func, bpf_kfunc_call_memb_release_dtor)
 
 static int __init bpf_prog_test_run_init(void)
 {



