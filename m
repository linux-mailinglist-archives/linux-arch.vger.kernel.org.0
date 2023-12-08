Return-Path: <linux-arch+bounces-827-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5256C80ADF7
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 21:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8287C1C20400
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 20:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E226550259;
	Fri,  8 Dec 2023 20:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VXkjzuM/"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E962210F8;
	Fri,  8 Dec 2023 12:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Vwp6H7hbWYuJntJS7kS+l0fw/Z+oOc8mMbOkVe4byro=; b=VXkjzuM/7GoObftnaEWoZgdFYY
	L5xDBcOtO5SXticci6clYrj1K1KscYr+MoTjFYUkZz0ZWWNRoMSMcKuxO0tsaM3zEfH6eF3zU5j8O
	cUQI6yZ66caIvr7dscGTiK/hdDneafs8+XW2NtmcUWud886gJjMgBetRpivFI+2k3nYvnsQp65YfB
	hU4YX9RUqEib/aVz06p8+wivpoxMEz+kH1paTVnnirP857fswwl5sTiNJ8EbLZQRfKs655qDWsKpA
	jp0nWHX5uHWgqj/v4iexBNwei3DfCgzFy0X4rATHIUUHZG65pJYjJNbS3wxpBgX7DtbfBf97DzDCW
	GFrHBhQQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rBhZP-006WtK-Ib; Fri, 08 Dec 2023 20:35:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3799630050D; Fri,  8 Dec 2023 21:35:35 +0100 (CET)
Date: Fri, 8 Dec 2023 21:35:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Song Liu <song@kernel.org>,
	Song Liu <songliubraving@meta.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Sami Tolvanen <samitolvanen@google.com>,
	Kees Cook <keescook@chromium.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-riscv <linux-riscv@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>,
	clang-built-linux <llvm@lists.linux.dev>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Joao Moreira <joao@overdrivepizza.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 2/2] x86/cfi,bpf: Fix BPF JIT call
Message-ID: <20231208203535.GG36716@noisy.programming.kicks-ass.net>
References: <CAADnVQJwU5fCLcjBWM9zBY6jUcnME3+p=vvdgKK9FiLPWvXozg@mail.gmail.com>
 <20231206163814.GB36423@noisy.programming.kicks-ass.net>
 <20231206183713.GA35897@noisy.programming.kicks-ass.net>
 <zu5eb2robdqnp2ojwaxjhnglcummrnjaqbw6krdds6qac3bql2@5zx46c2s6ez4>
 <20231207093105.GA28727@noisy.programming.kicks-ass.net>
 <ivhrgimonsvy3tyj5iidoqmlcyqvtsh2ay3cm3ouemsdbvjzs4@6jlt6zv55tgh>
 <20231208102940.GB28727@noisy.programming.kicks-ass.net>
 <20231208134041.GD28727@noisy.programming.kicks-ass.net>
 <20231208172152.GD36716@noisy.programming.kicks-ass.net>
 <CAADnVQKsnZfFomQ4wTZz=jMZW5QCV2XiXVsi64bghHkAjJtcmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKsnZfFomQ4wTZz=jMZW5QCV2XiXVsi64bghHkAjJtcmA@mail.gmail.com>

On Fri, Dec 08, 2023 at 11:40:27AM -0800, Alexei Starovoitov wrote:

> typedef void (*btf_dtor_kfunc_t)(void *);
>         btf_dtor_kfunc_t dtor;
> but the bpf_cgroup_release takes 'struct cgroup*'.
> From kcfi pov void * == struct cgroup * ?
> Do we need to change it to 'void *cgrp' ?

Yes, doing that naively like the below, gets me lovely things like:

validate_case:FAIL:expect_msg unexpected error: -22
VERIFIER LOG:
=============
=============
EXPECTED MSG: 'Possibly NULL pointer passed to trusted arg0'
#48/7    cgrp_kfunc/cgrp_kfunc_acquire_untrusted:FAIL
run_subtest:PASS:obj_open_mem 0 nsec
libbpf: extern (func ksym) 'bpf_cgroup_release': func_proto [148] incompatible with vmlinux [125610]
libbpf: failed to load object 'cgrp_kfunc_failure'


But let me try rebuilding everything..


---
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b3be5742d6f1..078b207af7f0 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2145,10 +2145,11 @@ __bpf_kfunc struct task_struct *bpf_task_acquire(struct task_struct *p)
  * bpf_task_release - Release the reference acquired on a task.
  * @p: The task on which a reference is being released.
  */
-__bpf_kfunc void bpf_task_release(struct task_struct *p)
+__bpf_kfunc void bpf_task_release(void *p)
 {
 	put_task_struct_rcu_user(p);
 }
+EXPORT_SYMBOL_GPL(bpf_task_release);
 
 #ifdef CONFIG_CGROUPS
 /**
@@ -2169,10 +2170,11 @@ __bpf_kfunc struct cgroup *bpf_cgroup_acquire(struct cgroup *cgrp)
  * drops to 0.
  * @cgrp: The cgroup on which a reference is being released.
  */
-__bpf_kfunc void bpf_cgroup_release(struct cgroup *cgrp)
+__bpf_kfunc void bpf_cgroup_release(void *cgrp)
 {
 	cgroup_put(cgrp);
 }
+EXPORT_SYMBOL_GPL(bpf_cgroup_release);
 
 /**
  * bpf_cgroup_ancestor - Perform a lookup on an entry in a cgroup's ancestor

