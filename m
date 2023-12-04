Return-Path: <linux-arch+bounces-633-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DAA803368
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 13:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC641F210C1
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 12:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FA52420A;
	Mon,  4 Dec 2023 12:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d69pQhr9"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941B09C;
	Mon,  4 Dec 2023 04:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vNi4oarUMe/eI8dB061LbFrYbcwH4xzlO/UEVWvv3R8=; b=d69pQhr9LJbL/XW8eP8KAhPxm+
	hqvraksWyptXL7ALZD+jvHNZ/30GsSeIaBl+DmcuM1PLSrXgx+IXGiI5iyxJ6yV/+rpoaUxsd4xbB
	N+EOR2c3hgfm00+DPl8vWJviJCpVPMKRjo4iROkZWR/AU00dPd5WpXzVSwYgaPVIZ0s1p1UE7fi0x
	fLBbTa79LgpBION1ZpAWLKG9b5h34Q2p3l6Hx72EKN9vF/wz+ufS3LeTb9NHAbGjGSTMkDGwvE/Qa
	VkDMejEaj/8wUNXQhA0fLXKeizJxFYVT5JvepAsMFIRl9uQKZ5EPDl4oGPOEpZigR4KEhvcnxGAaN
	RFFkSA1Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rA8RE-000h5B-Ai; Mon, 04 Dec 2023 12:52:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4CE783003F0; Mon,  4 Dec 2023 13:52:39 +0100 (CET)
Date: Mon, 4 Dec 2023 13:52:39 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Song Liu <song@kernel.org>, Song Liu <songliubraving@meta.com>,
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
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
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
Message-ID: <20231204125239.GA1319@noisy.programming.kicks-ass.net>
References: <20231130133630.192490507@infradead.org>
 <20231130134204.136058029@infradead.org>
 <CAADnVQJqE=aE7mHVS54pnwwnDS0b67iJbr+t4j5F4HRyJSTOHw@mail.gmail.com>
 <20231204091334.GM3818@noisy.programming.kicks-ass.net>
 <20231204111128.GV8262@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204111128.GV8262@noisy.programming.kicks-ass.net>

On Mon, Dec 04, 2023 at 12:11:28PM +0100, Peter Zijlstra wrote:
> On Mon, Dec 04, 2023 at 10:13:34AM +0100, Peter Zijlstra wrote:
> 
> > > Just running test_progs it splats right away:
> > > 
> > > [   74.047757] kmemleak: Found object by alias at 0xffffffffa0001d80
> > > [   74.048272] CPU: 14 PID: 104 Comm: kworker/14:0 Tainted: G        W
> > >  O       6.7.0-rc3-00702-g41c30fec304d-dirty #5241
> > > [   74.049118] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > > BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> > > [   74.050042] Workqueue: events bpf_prog_free_deferred
> > > [   74.050448] Call Trace:
> > > [   74.050663]  <TASK>
> > > [   74.050841]  dump_stack_lvl+0x55/0x80
> > > [   74.051141]  __find_and_remove_object+0xdb/0x110
> > > [   74.051521]  kmemleak_free+0x41/0x70
> > > [   74.051828]  vfree+0x36/0x130
> > 
> > Durr, I'll see if I can get that stuff running locally, and otherwise
> > play with the robot as you suggested. Thanks!
> 
> I think it is bpf_jit_binary_pack_hdr(), which is using prog->bpf_func
> as a start address for the image, instead of jit_data->image.
> 
> This used to be true, but now it's offset.
> 
> Let me see what to do about that...

Not the prettiest of things, but the below seems to make the thing
happy...

---
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 196cc1481dec..f4357c3211bc 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3024,6 +3024,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		prog->bpf_func = (void *)image + ctx.prog_offset;
 		prog->jited = 1;
 		prog->jited_len = proglen - ctx.prog_offset;
+		prog->aux->cfi_offset = ctx.prog_offset;
 	} else {
 		prog = orig_prog;
 	}
@@ -3078,6 +3079,7 @@ void bpf_jit_free(struct bpf_prog *prog)
 			kvfree(jit_data->addrs);
 			kfree(jit_data);
 		}
+		prog->bpf_func = (void *)prog->bpf_func - prog->aux->cfi_offset;
 		hdr = bpf_jit_binary_pack_hdr(prog);
 		bpf_jit_binary_pack_free(hdr, NULL);
 		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(prog));
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8b725776e70a..e5fa0852a20f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1483,6 +1483,7 @@ struct bpf_prog_aux {
 		struct work_struct work;
 		struct rcu_head	rcu;
 	};
+	u32 cfi_offset;
 };
 
 struct bpf_prog {
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 5c84a935ba63..763742f4740f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -121,6 +121,9 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 #endif
 
 	INIT_LIST_HEAD_RCU(&fp->aux->ksym.lnode);
+#ifdef CONFIG_FINEIBT
+	INIT_LIST_HEAD_RCU(&fp->aux->ksym_prefix.lnode);
+#endif
 	mutex_init(&fp->aux->used_maps_mutex);
 	mutex_init(&fp->aux->dst_mutex);
 
@@ -709,6 +712,8 @@ void bpf_prog_kallsyms_del(struct bpf_prog *fp)
 
 	bpf_ksym_del(&fp->aux->ksym);
 #ifdef CONFIG_FINEIBT
+	if (cfi_mode != CFI_FINEIBT)
+		return;
 	bpf_ksym_del(&fp->aux->ksym_prefix);
 #endif
 }

