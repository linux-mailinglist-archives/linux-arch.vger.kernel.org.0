Return-Path: <linux-arch+bounces-660-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AAD8043E9
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 02:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D83AC1C20C2E
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 01:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB9FED9;
	Tue,  5 Dec 2023 01:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRXiJkmM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB27CAF;
	Mon,  4 Dec 2023 17:18:44 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3316bb1303bso3881382f8f.0;
        Mon, 04 Dec 2023 17:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701739123; x=1702343923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jf8j7x8KL5+FXfau2GI8WqRGtfi/ioqnUgDBbWrCwc=;
        b=dRXiJkmMgX1yxKSrYMUOs+SPIgbQUY6dIghjFId5ulat6UOA4RkhMxc8WWqlPjT+Tu
         PRtFxUUYvoKqwRsFygr2Xg2YyAuTyBrDvzDrtrdZLJTIk2w6QaIDzEZxbOVGu5pGNKl+
         AaixBZtiyYkbRD1V5DzH+nR6VKQ6qtCnl5pCuwg8a6EdddLRnVbZ20CxeRmh1oMbwdhu
         s0y4v4/U7vTUMjV/w7D67ZVAzH/Rue5SAHW92TNSDDk/vko1XpbMmv7JbllaVy6vkeR9
         MMn7VoGYzNjjGLERnu08MGssvtMxqAFde4c/lRSEdkhj+43i/vzDiI6Vl+Gr+q/7r1q1
         tCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701739123; x=1702343923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jf8j7x8KL5+FXfau2GI8WqRGtfi/ioqnUgDBbWrCwc=;
        b=oK5F5Kkfiq9l7d6DVdTSyHV4+lpdKKr4YKsmgFE9C7xYruzzcdno7K2rKQDI/gSgFL
         B7JwXjJDPsL5mUUvWrBFUBghsegjNMUKYYeWBTDkh5MHPQCZsk5KR9pGwcOzJ2VxUpt8
         Ao9DmvLIlkIF0ETCdM14bDT+ymtMWVfWbzhZaVxghn6QAH6eEt8e+AJ7Bs1a4muOIvXs
         Cs3Kn0EH58KaZ6rpGaBI9gPHMLucVNAQ9MnG6vBusp7cs/Z2/sKlTjvYpw6Lz/9NIZxS
         Ov7XrX8vMymFr3PCVQn6/irSwsh5yttOSVmvsL5SaVxMLpzRKCJKhQetUkB/4AhFW/cA
         aGxw==
X-Gm-Message-State: AOJu0Yz0LvDNEWrDgNTG9v9IO3FRv4R/zjSyKvz7P/rRJFc2hc4q5ehT
	HgdL1depcnAvbaurrJI7Ub3rDthw90DjSLtJRxI=
X-Google-Smtp-Source: AGHT+IGEc+RU3aLyo6G6cXdlO/5FlaIRSUm657pq4pWBz4aI+C9RHW2IiSzyw85KCLQaAJWMQI8ODuDVbfqFALf2YSA=
X-Received: by 2002:adf:e78a:0:b0:333:2fd2:812c with SMTP id
 n10-20020adfe78a000000b003332fd2812cmr3734853wrm.73.1701739122768; Mon, 04
 Dec 2023 17:18:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130133630.192490507@infradead.org> <20231130134204.136058029@infradead.org>
 <CAADnVQJqE=aE7mHVS54pnwwnDS0b67iJbr+t4j5F4HRyJSTOHw@mail.gmail.com>
 <20231204091334.GM3818@noisy.programming.kicks-ass.net> <20231204111128.GV8262@noisy.programming.kicks-ass.net>
 <20231204125239.GA1319@noisy.programming.kicks-ass.net> <ZW4LjmUKj1q6RWdL@krava>
 <20231204181614.GA7299@noisy.programming.kicks-ass.net> <20231204183354.GC7299@noisy.programming.kicks-ass.net>
In-Reply-To: <20231204183354.GC7299@noisy.programming.kicks-ass.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 4 Dec 2023 17:18:31 -0800
Message-ID: <CAADnVQJwU5fCLcjBWM9zBY6jUcnME3+p=vvdgKK9FiLPWvXozg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86/cfi,bpf: Fix BPF JIT call
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Song Liu <song@kernel.org>, 
	Song Liu <songliubraving@meta.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Sami Tolvanen <samitolvanen@google.com>, 
	Kees Cook <keescook@chromium.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, linux-riscv <linux-riscv@lists.infradead.org>, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Joao Moreira <joao@overdrivepizza.com>, Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 10:34=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
>
> TL;DR, I think this is a pre-existing problem with kCFI + eBPF and not
> caused by my patches.

It's an old issue indeed.

To workaround I just did:
+__nocfi
 static long bpf_for_each_array_elem(struct bpf_map *map,
bpf_callback_t callback_fn,
                                    void *callback_ctx, u64 flags)

to proceed further.
test_progs passed few more tests, but then it hit:

[   13.965472] CFI failure at tcp_set_ca_state+0x51/0xd0 (target:
0xffffffffa02050d6; expected type: 0x3a47ac32)
[   13.966351] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[   13.966752] CPU: 3 PID: 2142 Comm: test_progs Tainted: G
O       6.7.0-rc3-00705-g421defd1bea0-dirty #5246
[   13.967552] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
[   13.968421] RIP: 0010:tcp_set_ca_state+0x51/0xd0
[   13.968751] Code: 70 40 ff 84 c0 74 49 48 8b 83 60 07 00 00 4c 8b
58 10 4d 85 db 74 1b 40 0f b6 f5 48 89 df 41 ba ce 53 b8 c5 45 03 53
f1 74 02 <0f> 0b 2e e8 c7 ee 31 00 0f b6 83 90 07 00 00 40 80 e5 1f 24
e0 40
[   13.975460] Call Trace:
[   13.975640]  <IRQ>
[   13.975791]  ? __die_body+0x68/0xb0
[   13.976062]  ? die+0xa4/0xd0
[   13.976273]  ? do_trap+0xa5/0x180
[   13.976513]  ? tcp_set_ca_state+0x51/0xd0
[   13.976800]  ? do_error_trap+0xb6/0x100
[   13.977076]  ? tcp_set_ca_state+0x51/0xd0
[   13.977360]  ? tcp_set_ca_state+0x51/0xd0
[   13.977644]  ? handle_invalid_op+0x2c/0x40
[   13.977934]  ? tcp_set_ca_state+0x51/0xd0
[   13.978222]  ? exc_invalid_op+0x38/0x60
[   13.978497]  ? asm_exc_invalid_op+0x1a/0x20
[   13.978798]  ? tcp_set_ca_state+0x51/0xd0
[   13.979087]  tcp_v6_syn_recv_sock+0x45c/0x6c0
[   13.979401]  tcp_check_req+0x497/0x590
[   13.979671]  tcp_v6_rcv+0x728/0xce0
[   13.979923]  ? raw6_local_deliver+0x63/0x350
[   13.980257]  ip6_protocol_deliver_rcu+0x2f6/0x560
[   13.980596]  ? ip6_input_finish+0x59/0x140
[   13.980887]  ? NF_HOOK+0x29/0x1d0
[   13.981136]  ip6_input_finish+0xcb/0x140
[   13.981415]  ? __cfi_ip6_input_finish+0x10/0x10
[   13.981738]  NF_HOOK+0x177/0x1d0
[   13.981970]  ? rcu_is_watching+0x10/0x40
[   13.982279]  ? lock_release+0x35/0x2e0
[   13.982547]  ? lock_release+0x35/0x2e0
[   13.982822]  ? NF_HOOK+0x29/0x1d0
[   13.983064]  ? __cfi_ip6_rcv_finish+0x10/0x10
[   13.983409]  NF_HOOK+0x177/0x1d0
[   13.983664]  ? ip6_rcv_core+0x50/0x6c0
[   13.983956]  ? process_backlog+0x132/0x290
[   13.984264]  ? process_backlog+0x132/0x290
[   13.984557]  __netif_receive_skb+0x5c/0x160
[   13.984856]  process_backlog+0x19e/0x290
[   13.985140]  __napi_poll+0x3f/0x1f0
[   13.985402]  net_rx_action+0x193/0x330
[   13.985672]  __do_softirq+0x14d/0x3ea
[   13.985963]  ? do_softirq+0x7f/0xb0
[   13.986243]  ? __dev_queue_xmit+0x5b/0xd50
[   13.986563]  ? ip6_finish_output2+0x222/0x7a0
[   13.986906]  do_softirq+0x7f/0xb0

The stack trace doesn't have any bpf, but it's a bpf issue too.
Here tcp_set_ca_state() calls
icsk->icsk_ca_ops->set_state(sk, ca_state);
which calls bpf prog via bpf trampoline.

re: bpf_jit_binary_pack_hdr().

since cfi_mode is __ro_after_init we don't need to waste
cfi_offset variable in prog->aux and in jit_context.

How about
+int get_cfi_offset(void)
+{
+       switch (cfi_mode) {
+       case CFI_FINEIBT:
+               return 16;
+       case CFI_KCFI:
+#ifdef CONFIG_CALL_PADDING
+               return 16;
+#else
+               return 5;
+#endif
+       default:
+               return 0;
+       }
+}
+
 struct bpf_binary_header *
 bpf_jit_binary_pack_hdr(const struct bpf_prog *fp)
 {
-       unsigned long real_start =3D (unsigned long)fp->bpf_func;
+       unsigned long real_start =3D (unsigned long)fp->bpf_func -
get_cfi_offset();

and have __weak version of get_cfi_offset() in bpf/core.c
that returns 0 and non-weak in arch/x86 like above?

Similarly remove prog_offset from jit_context and undo:

ctx->prog_offset =3D emit_prologue(...)
to keep it as 'static void emit_prologue'

since cfi offset is fixed at early boot and the same for all progs.

Separately we need to deal with bpf_for_each_array_elem()
which doesn't look easy.
And fix tcp_set_ca_state() as well (which is even harder).

Just to see where places like these are I did:
+__nocfi
 BPF_CALL_4(bpf_loop, u32, nr_loops, void *, callback_fn, void *, callback_=
ctx,
+__nocfi
 static long bpf_for_each_hash_elem(struct bpf_map *map,
bpf_callback_t callback_fn,
+__nocfi
 static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
+__nocfi
 static int __bpf_rbtree_add(struct bpf_rb_root *root,
+__nocfi
 BPF_CALL_4(bpf_user_ringbuf_drain, struct bpf_map *, map,
+__nocfi
 void tcp_set_ca_state(struct sock *sk, const u8 ca_state)
+__nocfi
 void tcp_init_congestion_control(struct sock *sk)
+__nocfi
 void tcp_enter_loss(struct sock *sk)
+__nocfi
 static void tcp_cong_avoid(struct sock *sk, u32 ack, u32 acked)
+__nocfi
 static inline void tcp_in_ack_event(struct sock *sk, u32 flags)

and more... Which is clearly not a direction to go.

Instead of annotating callers is there a way to say that
all bpf_callback_t calls are nocfi?

I feel the patches scratched the iceberg.

