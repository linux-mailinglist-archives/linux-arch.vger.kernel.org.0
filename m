Return-Path: <linux-arch+bounces-625-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DC1802E3E
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 10:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13561C209E9
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 09:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF1712E6C;
	Mon,  4 Dec 2023 09:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Oq2r/tZ4"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E3CCD;
	Mon,  4 Dec 2023 01:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=17YJ1z3ogS9ZFtbiaMgUZd7PQ1LHRkBWBWcBGoc/CJ8=; b=Oq2r/tZ4GMYvXmULCX+LD6Qfz7
	HO9OVNz8XCXQMgxz/LWfORxgl/H3LTq81ngFJsgHC93qrKcMcjpBQX8v5qQhdci74NGvXZAJ/yVju
	sK9gFvSFKKjG+KTta5qWhde5JaQQriDgSlX54kLf3MXV6oHLk1PYPA8HeGphIfHdNTawm8bbTLJrU
	NgcMlwn6/lrZmRXbfPHQFRxpn4ftLCB5eM9fnRnJvlMZpH3BmDJrGqa4dnsA7VRIdxnJbQVajyNOi
	Bn006jXGBXzTqb9dfS3GtKtm0DDTPpLydkfwONe+R1/uAJi3EvwQfUiJ18EbM5lGDJHCoVpl5xoSe
	3fM7hPwA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rA51D-004JwZ-2M;
	Mon, 04 Dec 2023 09:13:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4D01F300472; Mon,  4 Dec 2023 10:13:34 +0100 (CET)
Date: Mon, 4 Dec 2023 10:13:34 +0100
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
Message-ID: <20231204091334.GM3818@noisy.programming.kicks-ass.net>
References: <20231130133630.192490507@infradead.org>
 <20231130134204.136058029@infradead.org>
 <CAADnVQJqE=aE7mHVS54pnwwnDS0b67iJbr+t4j5F4HRyJSTOHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJqE=aE7mHVS54pnwwnDS0b67iJbr+t4j5F4HRyJSTOHw@mail.gmail.com>

On Sun, Dec 03, 2023 at 02:56:34PM -0800, Alexei Starovoitov wrote:
> On Thu, Nov 30, 2023 at 5:43 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> >
> >  void bpf_prog_kallsyms_del(struct bpf_prog *fp)
> > @@ -691,6 +708,9 @@ void bpf_prog_kallsyms_del(struct bpf_pr
> >                 return;
> >
> >         bpf_ksym_del(&fp->aux->ksym);
> > +#ifdef CONFIG_FINEIBT
> > +       bpf_ksym_del(&fp->aux->ksym_prefix);
> > +#endif
> >  }
> 
> Thank you for addressing all comments, but it panics during boot with:
> 
> [    3.109474] RIP: 0010:bpf_prog_kallsyms_del+0x10f/0x140
> [    3.109867] Code: 26 e0 00 ff 05 32 dd dd 01 48 8d bb 80 03 00 00
> 48 c7 c6 b8 b3 00 83 e8 ef 25 e0 00 48 8b 83 58 03 00 00 48 8b 8b 60
> 03 00 00 <48> 89 48 08 48 89 01 4c 89 b3 60 03 00 00 48 c7 c7 10 0b 7b
> 83 5b
> [    3.111282] RSP: 0000:ffffc90000013e08 EFLAGS: 00010246
> [    3.116968] Call Trace:
> [    3.117163]  <TASK>
> [    3.117328]  ? __die_body+0x68/0xb0
> [    3.117599]  ? page_fault_oops+0x317/0x390
> [    3.117909]  ? debug_objects_fill_pool+0x19/0x440
> [    3.118283]  ? debug_objects_fill_pool+0x19/0x440
> [    3.118715]  ? do_user_addr_fault+0x4cd/0x560
> [    3.119045]  ? exc_page_fault+0x62/0x1c0
> [    3.119350]  ? asm_exc_page_fault+0x26/0x30
> [    3.119675]  ? bpf_prog_kallsyms_del+0x10f/0x140
> [    3.120023]  ? bpf_prog_kallsyms_del+0x101/0x140
> [    3.120381]  __bpf_prog_put_noref+0x12/0xf0
> [    3.120704]  bpf_prog_put_deferred+0xe9/0x110
> [    3.121035]  bpf_prog_put+0xbb/0xd0
> [    3.121307]  bpf_prog_release+0x15/0x20
> 
> Adding the following:
> 
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 5c84a935ba63..5013fd53adfd 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -709,6 +709,8 @@ void bpf_prog_kallsyms_del(struct bpf_prog *fp)
> 
>         bpf_ksym_del(&fp->aux->ksym);
>  #ifdef CONFIG_FINEIBT
> +       if (cfi_mode != CFI_FINEIBT)
> +               return;
>         bpf_ksym_del(&fp->aux->ksym_prefix);
>  #endif
>  }
> 
> fixes the boot issue, but test_progs is not happy.

Damn, I'm an idiot :-), I knew I should've boot tested all
configurations again :/

> Just running test_progs it splats right away:
> 
> [   74.047757] kmemleak: Found object by alias at 0xffffffffa0001d80
> [   74.048272] CPU: 14 PID: 104 Comm: kworker/14:0 Tainted: G        W
>  O       6.7.0-rc3-00702-g41c30fec304d-dirty #5241
> [   74.049118] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> [   74.050042] Workqueue: events bpf_prog_free_deferred
> [   74.050448] Call Trace:
> [   74.050663]  <TASK>
> [   74.050841]  dump_stack_lvl+0x55/0x80
> [   74.051141]  __find_and_remove_object+0xdb/0x110
> [   74.051521]  kmemleak_free+0x41/0x70
> [   74.051828]  vfree+0x36/0x130

Durr, I'll see if I can get that stuff running locally, and otherwise
play with the robot as you suggested. Thanks!

