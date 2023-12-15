Return-Path: <linux-arch+bounces-1072-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EF581448D
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 10:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25565B229EF
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 09:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C338124B39;
	Fri, 15 Dec 2023 09:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HnOlO/cK"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061A917996;
	Fri, 15 Dec 2023 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=cG37Lky4vNGjI+/dn78V8dged+rcVq6oxgHwY0WVgrM=; b=HnOlO/cKUyALtWFkVS+r+9xPPj
	W8PtzBF/Ag2XAodU9cpkAPlJOKG6sCB7AjvimCTrEb5e15JI6mbhdhAuLXKjD4qhF67REnTRkcT5R
	Q9F9ePvPqYS8n6SN/4cevBgqVZ0Sct1sdx5cs2oMDt6nEZLZlkzQ/Monzno8X29cLfBZhkWyB/OKW
	S4Ywj+Bu2R6eV5V9m0DrxorpYikjPcmvTjIgwrJqLxZBLVz1t2BziAQ5XgunVD/XEU7gGG20fFUPk
	eOYHdeaPSr2R1cqz/Gsr8qy5oAKCQpncNzmQuBU0ZaX4w6tudaj+eth8AK45GC4Snht/g5h+uQpB2
	Ex/lSrZw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rE4ZF-009rG2-0y;
	Fri, 15 Dec 2023 09:33:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id EB92A3006F6; Fri, 15 Dec 2023 10:33:11 +0100 (CET)
Message-Id: <20231215092707.910319166@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 15 Dec 2023 10:12:23 +0100
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
Subject: [PATCH v3 7/7] x86/cfi,bpf: Fix bpf_exception_cb() signature
References: <20231215091216.135791411@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Alexei Starovoitov <alexei.starovoitov@gmail.com>

As per the earlier patches, BPF sub-programs have bpf_callback_t
signature and CFI expects callers to have matching signature. This is
violated by bpf_prog_aux::bpf_exception_cb().

[peterz: Changelog]
Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/CAADnVQ+Z7UcXXBBhMubhcMM=R-dExk-uHtfOLtoLxQ1XxEpqEA@mail.gmail.com
---
 include/linux/bpf.h  |    2 +-
 kernel/bpf/helpers.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1484,7 +1484,7 @@ struct bpf_prog_aux {
 	int cgroup_atype; /* enum cgroup_bpf_attach_type */
 	struct bpf_map *cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE];
 	char name[BPF_OBJ_NAME_LEN];
-	unsigned int (*bpf_exception_cb)(u64 cookie, u64 sp, u64 bp);
+	u64 (*bpf_exception_cb)(u64 cookie, u64 sp, u64 bp, u64, u64);
 #ifdef CONFIG_SECURITY
 	void *security;
 #endif
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2537,7 +2537,7 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 	 * which skips compiler generated instrumentation to do the same.
 	 */
 	kasan_unpoison_task_stack_below((void *)(long)ctx.sp);
-	ctx.aux->bpf_exception_cb(cookie, ctx.sp, ctx.bp);
+	ctx.aux->bpf_exception_cb(cookie, ctx.sp, ctx.bp, 0, 0);
 	WARN(1, "A call to BPF exception callback should never return\n");
 }
 



