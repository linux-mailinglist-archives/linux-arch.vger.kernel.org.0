Return-Path: <linux-arch+bounces-1073-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C5581448F
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 10:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FD6328439B
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 09:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC3224B53;
	Fri, 15 Dec 2023 09:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j2nwutH6"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA6119BDF;
	Fri, 15 Dec 2023 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-Id:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=M6xOa2fYXl3T5Nij1IGMapcelc4vod3qWujvkNL82EQ=; b=j2nwutH6cjxGn6zu9q2Jxr8W3/
	lkRuWHA2VNVNiroJZLzT3fOMTKjNSK3zCVlitlmqCKQRc9laFozuwpeLaX80Nl7i1NNbb0Kkkv5Hs
	zNiDBMcPiWrP8fj+JA+GnjcNpHzvNZ2IXuwpp7btsy8hWHGWejQeP82Tud78W4yQ2XkZiAAYMOfll
	HNyB5ItcoZlsTNiJ4XPTiu0S/fO4WybnLTjLpeBqgENl/hsbTr3bpZciOgIQFP2jjLI9l3eElim4H
	bzk1m8T76cJeCvy43cpiRZwwtWYIkWf5BK1MB6n8Ia2VTaIl/vzPClRahZBKIudlpWS+fp3yQpKD5
	Qm4R46Ig==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rE4ZE-009rFx-0N;
	Fri, 15 Dec 2023 09:33:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id BCB7C3005B2; Fri, 15 Dec 2023 10:33:11 +0100 (CET)
Message-Id: <20231215091216.135791411@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 15 Dec 2023 10:12:16 +0100
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
Subject: [PATCH v3 0/7] x86/cfi,bpf: Fix CFI vs eBPF
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Hi!

What started with the simple observation that bpf_dispatcher_*_func() was
broken for calling CFI functions with a __nocfi calling context for FineIBT
ended up with a complete BPF wide CFI fixup.

With these changes on the BPF selftest suite passes without crashing -- there's
still a few failures, but Alexei has graciously offered to look into those.

(Alexei, I have presumed your SoB on the very last patch, please update
as you see fit)

Changes since v2 are numerous but include:
 - cfi_get_offset() -- as a means to communicate the offset (ast)
 - 5 new patches fixing various BPF internals to be CFI clean

Note: it *might* be possible to merge the
bpf_bpf_tcp_ca.c:unsupported_ops[] thing into the CFI stubs, as is
get_info will have a NULL stub, unlike the others.

---
 arch/riscv/include/asm/cfi.h   |   3 +-
 arch/riscv/kernel/cfi.c        |   2 +-
 arch/x86/include/asm/cfi.h     | 126 +++++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/alternative.c  |  87 +++++++++++++++++++++++---
 arch/x86/kernel/cfi.c          |   4 +-
 arch/x86/net/bpf_jit_comp.c    | 134 +++++++++++++++++++++++++++++++++++------
 include/asm-generic/Kbuild     |   1 +
 include/linux/bpf.h            |  27 ++++++++-
 include/linux/cfi.h            |  12 ++++
 kernel/bpf/bpf_struct_ops.c    |  16 ++---
 kernel/bpf/core.c              |  25 ++++++++
 kernel/bpf/cpumask.c           |   8 ++-
 kernel/bpf/helpers.c           |  18 +++++-
 net/bpf/bpf_dummy_struct_ops.c |  31 +++++++++-
 net/bpf/test_run.c             |  15 ++++-
 net/ipv4/bpf_tcp_ca.c          |  69 +++++++++++++++++++++
 16 files changed, 528 insertions(+), 50 deletions(-)


