Return-Path: <linux-arch+bounces-620-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48505802893
	for <lists+linux-arch@lfdr.de>; Sun,  3 Dec 2023 23:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9694280C95
	for <lists+linux-arch@lfdr.de>; Sun,  3 Dec 2023 22:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCA219BA3;
	Sun,  3 Dec 2023 22:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6LdAEBc"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A7CD9;
	Sun,  3 Dec 2023 14:56:47 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32fdc5be26dso2984168f8f.2;
        Sun, 03 Dec 2023 14:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701644205; x=1702249005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJi9qF8pgvawz26+Rs2puTVGd6loLTzCzC78oIA/ddI=;
        b=W6LdAEBcfp63SDg3ELT5v81/0t+tFxaXJmc2QjMYhcBLnIgJB/5ZKrrK5jGEhPaXvc
         QOLh5KQ7XTzZ13ibO1MxQY8H5lte7ntwf4XDWHVNWqyaa57GCEycIlzLbswURbgZcJ0u
         sHl4/0hA23YkyzlWhsl1BQlR+GyBXHoN1IgoJCzbtZRhysy24IIaowmQRvuasigqKHK2
         7gmLv9WUg45MYFCtbIkwn8jBj1+qfO5ANUQ7968OLao01YsyrzsuyiiUVs3enWBewZl0
         /Ay9zAi11+7x+g8FD04zPGJfbJch/bndIXYkbVV9g9wvLR77EVuNq2ZxpGr0gkvwDinF
         JDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701644205; x=1702249005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJi9qF8pgvawz26+Rs2puTVGd6loLTzCzC78oIA/ddI=;
        b=MVfkT8YyvPEZ349gQbDeSES3i7s0V6BEuLi7bQTZQFxje7XKpf4obb5/au2xhhmynu
         M0BON+BpdWPBICdF8ZRe6CQtZB/E81V5BDdUbX3CLjoWkvO5E1KDeqZpusABMVbE2Mrj
         HsBOvgL1bsHWFWRiSX1lZgEkiwV/Aw/gprpOLdreMqsw4CBXJVMLuQprbdF9LSM297kt
         LMT9BAGorr6MFuB7aJYAAPm0errfZVNOJ7XThc6RMdEvj+lw6Rf+yMj933k97VYVi9P1
         Xq4MYSvfEwzHJ88RCm6S0M/tyyRtMZwaUQXFKn1QGSN/zGCRWEXvAbfWFjAtcHlwdw08
         b2iw==
X-Gm-Message-State: AOJu0Yz9jTB68ohlDDVqGzHOvxT5+Y6UGf+zWtKNDnrkSzA+HSLihMZv
	h7JlzxznqHy+By5z133xxDEc/lf4Xo23DDFnrsA=
X-Google-Smtp-Source: AGHT+IEht3oAYfsgqpGNOk2/k9P8eZfPqowfJ4EKfz5sEX92w1kszJ7CYrdNtRCFybm8a1Is7rqcJiCthaihUsBg/mI=
X-Received: by 2002:adf:b608:0:b0:333:3821:233a with SMTP id
 f8-20020adfb608000000b003333821233amr1629307wre.18.1701644205229; Sun, 03 Dec
 2023 14:56:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130133630.192490507@infradead.org> <20231130134204.136058029@infradead.org>
In-Reply-To: <20231130134204.136058029@infradead.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 3 Dec 2023 14:56:34 -0800
Message-ID: <CAADnVQJqE=aE7mHVS54pnwwnDS0b67iJbr+t4j5F4HRyJSTOHw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86/cfi,bpf: Fix BPF JIT call
To: Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>, 
	Song Liu <songliubraving@meta.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Sami Tolvanen <samitolvanen@google.com>, Kees Cook <keescook@chromium.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	linux-riscv <linux-riscv@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-arch <linux-arch@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Joao Moreira <joao@overdrivepizza.com>, 
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 5:43=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
>
>  void bpf_prog_kallsyms_del(struct bpf_prog *fp)
> @@ -691,6 +708,9 @@ void bpf_prog_kallsyms_del(struct bpf_pr
>                 return;
>
>         bpf_ksym_del(&fp->aux->ksym);
> +#ifdef CONFIG_FINEIBT
> +       bpf_ksym_del(&fp->aux->ksym_prefix);
> +#endif
>  }

Thank you for addressing all comments, but it panics during boot with:

[    3.109474] RIP: 0010:bpf_prog_kallsyms_del+0x10f/0x140
[    3.109867] Code: 26 e0 00 ff 05 32 dd dd 01 48 8d bb 80 03 00 00
48 c7 c6 b8 b3 00 83 e8 ef 25 e0 00 48 8b 83 58 03 00 00 48 8b 8b 60
03 00 00 <48> 89 48 08 48 89 01 4c 89 b3 60 03 00 00 48 c7 c7 10 0b 7b
83 5b
[    3.111282] RSP: 0000:ffffc90000013e08 EFLAGS: 00010246
[    3.116968] Call Trace:
[    3.117163]  <TASK>
[    3.117328]  ? __die_body+0x68/0xb0
[    3.117599]  ? page_fault_oops+0x317/0x390
[    3.117909]  ? debug_objects_fill_pool+0x19/0x440
[    3.118283]  ? debug_objects_fill_pool+0x19/0x440
[    3.118715]  ? do_user_addr_fault+0x4cd/0x560
[    3.119045]  ? exc_page_fault+0x62/0x1c0
[    3.119350]  ? asm_exc_page_fault+0x26/0x30
[    3.119675]  ? bpf_prog_kallsyms_del+0x10f/0x140
[    3.120023]  ? bpf_prog_kallsyms_del+0x101/0x140
[    3.120381]  __bpf_prog_put_noref+0x12/0xf0
[    3.120704]  bpf_prog_put_deferred+0xe9/0x110
[    3.121035]  bpf_prog_put+0xbb/0xd0
[    3.121307]  bpf_prog_release+0x15/0x20

Adding the following:

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 5c84a935ba63..5013fd53adfd 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -709,6 +709,8 @@ void bpf_prog_kallsyms_del(struct bpf_prog *fp)

        bpf_ksym_del(&fp->aux->ksym);
 #ifdef CONFIG_FINEIBT
+       if (cfi_mode !=3D CFI_FINEIBT)
+               return;
        bpf_ksym_del(&fp->aux->ksym_prefix);
 #endif
 }

fixes the boot issue, but test_progs is not happy.

Just running test_progs it splats right away:

[   74.047757] kmemleak: Found object by alias at 0xffffffffa0001d80
[   74.048272] CPU: 14 PID: 104 Comm: kworker/14:0 Tainted: G        W
 O       6.7.0-rc3-00702-g41c30fec304d-dirty #5241
[   74.049118] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
[   74.050042] Workqueue: events bpf_prog_free_deferred
[   74.050448] Call Trace:
[   74.050663]  <TASK>
[   74.050841]  dump_stack_lvl+0x55/0x80
[   74.051141]  __find_and_remove_object+0xdb/0x110
[   74.051521]  kmemleak_free+0x41/0x70
[   74.051828]  vfree+0x36/0x130
[   74.052076]  ? process_scheduled_works+0x1d7/0x520
[   74.052463]  bpf_prog_pack_free+0x42/0x1a0
[   74.052803]  ? process_scheduled_works+0x1d7/0x520
[   74.053194]  bpf_jit_binary_pack_free+0x17/0x30
[   74.053565]  bpf_jit_free+0x57/0x90
[   74.053856]  process_scheduled_works+0x250/0x520
[   74.054234]  worker_thread+0x26f/0x400
[   74.054542]  ? __cfi_worker_thread+0x10/0x10
[   74.054909]  kthread+0x113/0x130
[   74.055178]  ? __cfi_kthread+0x10/0x10
[   74.055487]  ret_from_fork+0x48/0x60
[   74.055793]  ? __cfi_kthread+0x10/0x10
[   74.056102]  ret_from_fork_asm+0x11/0x30
[   74.056427]  </TASK>
[   74.056616] kmemleak: Object 0xffffffffa0000000 (size 2097152):
[   74.057089] kmemleak:   comm "swapper/0", pid 1, jiffies 4294667572
[   74.057594] kmemleak:   min_count =3D 2
[   74.057892] kmemleak:   count =3D 2
[   74.058164] kmemleak:   flags =3D 0x1
[   74.058448] kmemleak:   checksum =3D 0
[   74.058746] kmemleak:   backtrace:
[   74.059025]  kmemleak_vmalloc+0x2d/0xd0
[   74.059338]  __vmalloc_node_range+0x7e0/0x810
[   74.059726]  module_alloc+0x5f/0x70
[   74.060015]  bpf_prog_pack_alloc+0x167/0x260
[   74.060374]  bpf_jit_binary_pack_alloc+0xca/0x1e0
[   74.060760]  bpf_int_jit_compile+0x3c5d/0x4140
[   74.061120]  bpf_prog_select_runtime+0x239/0x320
[   74.061496]  bpf_prepare_filter+0x49d/0x4c0
[   74.061844]  bpf_prog_create+0x80/0xc0
[   74.062149]  ptp_classifier_init+0x29/0x40
[   74.062480]  sock_init+0x9c/0xb0
[   74.062753]  do_one_initcall+0xdd/0x2f0
[   74.063067]  do_initcall_level+0x98/0x105
[   74.063394]  do_initcalls+0x43/0x80
[   74.063687]  kernel_init_freeable+0x15f/0x1d0
[   74.064039]  kernel_init+0x1a/0x1b0

[   74.064993] Trying to vfree() bad address (000000001f212011)
[   74.065625] WARNING: CPU: 14 PID: 104 at mm/vmalloc.c:2692
remove_vm_area+0x141/0x150

[   74.089515] Trying to vfree() nonexistent vm area (000000001f212011)
[   74.090234] WARNING: CPU: 14 PID: 104 at mm/vmalloc.c:2827 vfree+0xfe/0x=
130

[   74.129930] Trying to vfree() bad address (000000009ed2080e)
[   74.130408] WARNING: CPU: 14 PID: 149 at mm/vmalloc.c:2692
remove_vm_area+0x141/0x150

and eventually panics with:

[   74.195676] BUG: unable to handle page fault for address: ffffffffa00020=
c0
[   74.196541] #PF: supervisor read access in kernel mode
[   74.197548] #PF: error_code(0x0000) - not-present page
[   74.201441] PGD 3058067 P4D 3058067 PUD 3059063 PMD 101d69067 PTE 0
[   74.202162] Oops: 0000 [#1] PREEMPT SMP PTI
[   74.202602] CPU: 14 PID: 2151 Comm: kworker/14:5 Tainted: G
W  O       6.7.0-rc3-00702-g41c30fec304d-dirty #5241
[   74.203567] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
[   74.204551] Workqueue: events bpf_prog_free_deferred
[   74.205039] RIP: 0010:bpf_prog_pack_free+0x20/0x1a0
[   74.205469] Code: 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 0f 1f
44 00 00 55 41 57 41 56 53 49 89 fe 48 c7 c7 60 0b 7b 83 31 f6 e8 30
a7 e2 00 <41> 8b 0e 48 8b 3d 36 71 6d 02 f3 48 0f b8 c7 48 98 48 c1 e0
15 48
[   74.207102] RSP: 0018:ffffc900006e7de0 EFLAGS: 00010282
[   74.214890] Call Trace:
[   74.215108]  <TASK>
[   74.215305]  ? __die_body+0x68/0xb0
[   74.215620]  ? page_fault_oops+0x317/0x390
[   74.215977]  ? do_kern_addr_fault+0x8a/0xb0
[   74.216351]  ? exc_page_fault+0xa0/0x1c0
[   74.216697]  ? asm_exc_page_fault+0x26/0x30
[   74.217055]  ? process_scheduled_works+0x1d7/0x520
[   74.217481]  ? bpf_prog_pack_free+0x20/0x1a0
[   74.217857]  ? process_scheduled_works+0x1d7/0x520
[   74.218279]  bpf_jit_binary_pack_free+0x17/0x30
[   74.218676]  bpf_jit_free+0x57/0x90
[   74.218983]  process_scheduled_works+0x250/0x520
[   74.219388]  worker_thread+0x26f/0x400

The kernel was compiled with:
CONFIG_CC_HAS_SLS=3Dy
CONFIG_CC_HAS_RETURN_THUNK=3Dy
CONFIG_CC_HAS_ENTRY_PADDING=3Dy
CONFIG_FUNCTION_PADDING_CFI=3D11
CONFIG_FUNCTION_PADDING_BYTES=3D11
CONFIG_CALL_PADDING=3Dy
CONFIG_FINEIBT=3Dy
CONFIG_HAVE_CALL_THUNKS=3Dy
CONFIG_SPECULATION_MITIGATIONS=3Dy
CONFIG_PAGE_TABLE_ISOLATION=3Dy
CONFIG_RETPOLINE=3Dy
CONFIG_RETHUNK=3Dy
CONFIG_CPU_UNRET_ENTRY=3Dy
...
CONFIG_DEBUG_KMEMLEAK=3Dy
...
CONFIG_CFI_CLANG=3Dy

and 'make LLVM=3D1', of course.

I suspect the above vmalloc/prog_pack issue is somehow
related to the patches, but I cannot prove, since without
this CFI fixes it also panics:

[   29.079722] CFI failure at bpf_for_each_array_elem+0xa6/0x100
(target: bpf_prog_5a19eca5d8e54e9b_check_elem+0x0/0x42; expected type:
0xe37465df)
[   29.080884] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[   29.081244] CPU: 8 PID: 2142 Comm: test_progs Tainted: G
O       6.7.0-rc3-00699-g90679706d486 #5242
[   29.082662] RIP: 0010:bpf_for_each_array_elem+0xa6/0x100
[   29.083027] Code: af ef 4c 01 ed 44 89 7c 24 04 4c 89 e7 48 8d 74
24 04 48 89 ea 48 89 d9 45 31 c0 4d 89 f3 41 ba 21 9a 8b 1c 45 03 53
f1 74 02 <0f> 0b 2e e8 62 95 de 00 48 85 c0 75 0e 49 8d 47 01 41 8b 4c
24 24
[   29.084282] RSP: 0018:ffffc9000269fea8 EFLAGS: 00010286
[   29.089633] Call Trace:
[   29.089805]  <TASK>
[   29.089953]  ? __die_body+0x68/0xb0
[   29.090192]  ? die+0xa4/0xd0
[   29.090391]  ? do_trap+0xa5/0x180
[   29.090619]  ? bpf_for_each_array_elem+0xa6/0x100
[   29.090941]  ? do_error_trap+0xb6/0x100
[   29.091200]  ? bpf_for_each_array_elem+0xa6/0x100
[   29.091516]  ? bpf_for_each_array_elem+0xa6/0x100
[   29.091848]  ? handle_invalid_op+0x2c/0x40
[   29.092123]  ? bpf_for_each_array_elem+0xa6/0x100
[   29.092439]  ? exc_invalid_op+0x38/0x60
[   29.092699]  ? asm_exc_invalid_op+0x1a/0x20
[   29.092985]  ? 0xffffffffa0000b8c
[   29.093212]  ? 0xffffffffa0000b8c
[   29.093439]  ? bpf_for_each_array_elem+0xa6/0x100
[   29.093759]  ? preempt_count_add+0x5d/0xb0
[   29.094034]  bpf_prog_ca45ea7f9cb8ac1a_inner_map+0x94/0x98
[   29.094415]  bpf_trampoline_6442516600+0x47/0x1000
[   29.094743]  __x64_sys_getpgid+0x9/0x20

which is expected.
In this case test_progs proceeds further before it CFI aborts.
With CFI fixes vmalloc panics sooner.

Song,

you're an expert in prog_pack logic, please take a look as well.


Peter,

if you're struggling to setup bpf tests locally feel free
to add an extra patch that adds
CONFIG_FINEIBT=3Dy and others
to tools/testing/selftests/bpf/config.x86_64
and resend.
BPF CI will apply that patch to kconfig while building the kernel
and will run the tests accordingly.
It will be ignored with gcc builds, but clang builds should pick it up.

Or do this:
https://docs.kernel.org/bpf/bpf_devel_QA.html#q-how-do-i-run-bpf-ci-on-my-c=
hanges-before-sending-them-out-for-review

It might be easier to test this way.
Same point about extra patch for tools/testing/selftests/bpf/config.x86_64.

