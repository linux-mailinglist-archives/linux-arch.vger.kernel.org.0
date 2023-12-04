Return-Path: <linux-arch+bounces-647-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE190803C9B
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 19:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E429B20A01
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 18:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5B12EAFC;
	Mon,  4 Dec 2023 18:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="am2z3bzA"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390D9CA;
	Mon,  4 Dec 2023 10:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Fn5JFW3pO8Hqb0ORpcMbTe073F/4Aqe2CPCyASjreaI=; b=am2z3bzAwP5fDSazla1LoLuAIW
	7UNSeQLcPhNDSKwjU2Ynb3sdQEpdjr8Og7fJUTUaYqJmzIJ5IZoSnyUmqckF2pltTDnF2k5LTE0GH
	RzSf2Hae7KnpHMR/RBb4YoTG4fCBmGwdMvFP4JqYFI1t+zlrcDY7DG5O5cdNo22vxrX1rralbVNgK
	QXBTLkH7YJhtAx5UA1j9cdtIu9NYDmrgI/fRBt0cFlv0Yy0vCgeZpb213bWM40LDgqPS9gmHY7yDZ
	1iLK/lxekfYTdOJ1O9gOicnVTb4T0l/NyJSCK3FfV8Sk1aIAdZaqEky2baWQI7niPgXUh/7T3YFk8
	DK/o29cw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rADUO-004Pbk-0b;
	Mon, 04 Dec 2023 18:16:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DACA1300427; Mon,  4 Dec 2023 19:16:14 +0100 (CET)
Date: Mon, 4 Dec 2023 19:16:14 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Song Liu <song@kernel.org>, Song Liu <songliubraving@meta.com>,
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
Message-ID: <20231204181614.GA7299@noisy.programming.kicks-ass.net>
References: <20231130133630.192490507@infradead.org>
 <20231130134204.136058029@infradead.org>
 <CAADnVQJqE=aE7mHVS54pnwwnDS0b67iJbr+t4j5F4HRyJSTOHw@mail.gmail.com>
 <20231204091334.GM3818@noisy.programming.kicks-ass.net>
 <20231204111128.GV8262@noisy.programming.kicks-ass.net>
 <20231204125239.GA1319@noisy.programming.kicks-ass.net>
 <ZW4LjmUKj1q6RWdL@krava>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW4LjmUKj1q6RWdL@krava>

On Mon, Dec 04, 2023 at 06:25:34PM +0100, Jiri Olsa wrote:

> that boots properly for me but gives crash below when running bpf tests

OK, more funnies..

> [  482.145182][  T699] RIP: 0010:bpf_for_each_array_elem+0xbb/0x120
> [  482.145672][  T699] Code: 4c 01 f5 89 5c 24 04 4c 89 e7 48 8d 74 24 04 48 89 ea 4c 89 fd 4c 89 f9 45 31 c0 4d 89 eb 41 ba ef 86 cd 67 45 03 53 f1 74 02 <0f> 0b 41 ff d3 0f 1f 00 48 85 c0 75 0e 48 8d 43 01 41 8b 4c 24 24
> [  482.147221][  T699] RSP: 0018:ffffc900017e3e88 EFLAGS: 00010217
> [  482.147702][  T699] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc900017e3ed8
> [  482.152162][  T699] RDX: ffff888152eb0210 RSI: ffffc900017e3e8c RDI: ffff888152eb0000
> [  482.152770][  T699] RBP: ffffc900017e3ed8 R08: 0000000000000000 R09: 0000000000000000
> [  482.153350][  T699] R10: 000000004704ef28 R11: ffffffffa0012774 R12: ffff888152eb0000
> [  482.153951][  T699] R13: ffffffffa0012774 R14: ffff888152eb0210 R15: ffffc900017e3ed8
> [  482.154554][  T699] FS:  00007fa60d4fdd00(0000) GS:ffff88846d200000(0000) knlGS:0000000000000000
> [  482.155138][  T699] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  482.155564][  T699] CR2: 00007fa60d7d8000 CR3: 00000001502a2005 CR4: 0000000000770ef0
> [  482.156095][  T699] PKRU: 55555554
> [  482.156349][  T699] Call Trace:
> [  482.156596][  T699]  <TASK>
> [  482.156816][  T699]  ? __die_body+0x68/0xb0
> [  482.157138][  T699]  ? die+0xba/0xe0
> [  482.157456][  T699]  ? do_trap+0xa5/0x180
> [  482.157826][  T699]  ? bpf_for_each_array_elem+0xbb/0x120
> [  482.158277][  T699]  ? bpf_for_each_array_elem+0xbb/0x120
> [  482.158711][  T699]  ? do_error_trap+0xc4/0x140
> [  482.159052][  T699]  ? bpf_for_each_array_elem+0xbb/0x120
> [  482.159506][  T699]  ? handle_invalid_op+0x2c/0x40
> [  482.159906][  T699]  ? bpf_for_each_array_elem+0xbb/0x120
> [  482.160990][  T699]  ? exc_invalid_op+0x38/0x60
> [  482.161375][  T699]  ? asm_exc_invalid_op+0x1a/0x20
> [  482.161788][  T699]  ? 0xffffffffa0012774
> [  482.162149][  T699]  ? 0xffffffffa0012774
> [  482.162513][  T699]  ? bpf_for_each_array_elem+0xbb/0x120
> [  482.162905][  T699]  bpf_prog_ca45ea7f9cb8ac1a_inner_map+0x94/0x98
> [  482.163471][  T699]  bpf_trampoline_6442549234+0x47/0x1000

Looks like this trips an #UD, I'll go try and figure out what this
bpf_for_each_array_elem() does to cause this. Looks like it has an
indirect call, could be the callback_fn thing has a CFI mis-match.



