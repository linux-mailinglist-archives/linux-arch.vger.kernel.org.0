Return-Path: <linux-arch+bounces-839-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B895380B213
	for <lists+linux-arch@lfdr.de>; Sat,  9 Dec 2023 05:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C5FCB20AF9
	for <lists+linux-arch@lfdr.de>; Sat,  9 Dec 2023 04:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E6E15B4;
	Sat,  9 Dec 2023 04:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeESuLTe"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E9110DF;
	Fri,  8 Dec 2023 20:51:40 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-332fd78fa9dso2566897f8f.3;
        Fri, 08 Dec 2023 20:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702097499; x=1702702299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9jLsGhfGkMZnWhDYfHQ0jvQvXqjfciOlusSLK9GhRY=;
        b=KeESuLTeX8T5ede0i/kSECpSnduJslTf/82J4Z57rkWkSf8dSMVICt52nYkMFTOITW
         099C3aWGMtSw770fNLMxYbnj8Flv7HGJMeJpx8n29C0BMB+kz4LKbf26wUiYEVblcqIV
         eJ8kmYDYcNE8tfSblEWCCPuvlQ3sIoo3DhX/ssxWrC8rnhS9czhqJAmkrmA9WOD3ILP1
         o3Vj1z3dABjSQA3jPb9x9rm6dDK+EO1NpB+Sb/FmhNhAwpJM4qECPWTrf5YHCr/+8iNw
         puYmU9Fvq4imcj/3AzNgZ4XiuRgkS2XibAg3jB69haE6GgMTNRlrxNG9Dehpb6ffErJ/
         KmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702097499; x=1702702299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9jLsGhfGkMZnWhDYfHQ0jvQvXqjfciOlusSLK9GhRY=;
        b=AeMAll1+7Hm+LqvEgTNXH0lzxGQd4etsowOeyJqcehBysYX5I4uc9Bn/MeYGzNIATK
         yLBMYbR/TPVfdBazATRCdYDkV5ACWwR+DXXvHkqlbdHklegH/ug7DMclYdEl5i5VGRDx
         ItNK+dxzOLR7/4oRJqk6HKC/c2A5dskk82CsyTfZENAtSPjwXavvsj1JN/NWcykxBhJM
         px07D4wQwEGJCLANU0RO1ophOJr/50eKInDah80Nmivxk3tPQgSDR5VWVLYRklF8CeRd
         sXN1uGZoP2G5QVErF5YbJ4tN0PJeDUkmEsZUSFnaBK4cXauohmYLCv+04+rHD78zjNB9
         1+eQ==
X-Gm-Message-State: AOJu0YyiAm7KxmTwW4K2yvhry/jBGf0KDBa9HkklvsuoE/W6DggJA4xe
	b2VWKJndrwX0/dEB2ZjxJB8qBxffeQ0xqXUlzbc=
X-Google-Smtp-Source: AGHT+IGWegoXbG6riU09aOxjScmI6QdU76ibtag8Pupqd8K6QoQZC3fgz8qhZUFCULCtLMsl2YQJg9oU3fR3idrWio4=
X-Received: by 2002:adf:ce8d:0:b0:333:49a8:73e4 with SMTP id
 r13-20020adfce8d000000b0033349a873e4mr197659wrn.201.1702097499187; Fri, 08
 Dec 2023 20:51:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207093105.GA28727@noisy.programming.kicks-ass.net>
 <ivhrgimonsvy3tyj5iidoqmlcyqvtsh2ay3cm3ouemsdbvjzs4@6jlt6zv55tgh>
 <20231208102940.GB28727@noisy.programming.kicks-ass.net> <20231208134041.GD28727@noisy.programming.kicks-ass.net>
 <20231208172152.GD36716@noisy.programming.kicks-ass.net> <CAADnVQKsnZfFomQ4wTZz=jMZW5QCV2XiXVsi64bghHkAjJtcmA@mail.gmail.com>
 <20231208203535.GG36716@noisy.programming.kicks-ass.net> <CAADnVQJzCw=qcG+jHBYG0q0SxLPkwghni0wpgV4A4PkpgVbGPw@mail.gmail.com>
 <20231208205241.GK28727@noisy.programming.kicks-ass.net> <CAADnVQL3KsJONShsstDq5jrpbc_4FOU-VQPJgDCt50N9asoFzA@mail.gmail.com>
 <20231208224557.GH36716@noisy.programming.kicks-ass.net>
In-Reply-To: <20231208224557.GH36716@noisy.programming.kicks-ass.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Dec 2023 20:51:27 -0800
Message-ID: <CAADnVQ+Z7UcXXBBhMubhcMM=R-dExk-uHtfOLtoLxQ1XxEpqEA@mail.gmail.com>
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

On Fri, Dec 8, 2023 at 2:46=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
>
> Ok, did that. Current patches (on top of bpf-next) are here:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/cfi

Looks really great. The last patch is cleaner than I expected. Good idea.

> (really should try and write better changelogs, but it's too late)

commit logs look fine except the "pilfer" word that I had to look up
in the dictionary :)

> [  247.721063]  ? bpf_throw+0x9b/0xf0
> [  247.721126]  ? bpf_test_run+0x108/0x350
> [  247.721191]  ? bpf_prog_5555714b685bf0cf_exception_throw_always_1+0x26=
/0x26
> [  247.721301]  ? bpf_test_run+0x108/0x350
> [  247.721368]  bpf_test_run+0x212/0x350
> [  247.721433]  ? slab_build_skb+0x22/0x110
> [  247.721503]  bpf_prog_test_run_skb+0x347/0x4a0
>
> But I'm too tired to think staight. Is  this a bpf_callback_t vs
> bpf_exception_cb difference?

Yep.
It's easy to fix:
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0e162eae8639..e36b3f41751e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1484,7 +1484,7 @@ struct bpf_prog_aux {
        int cgroup_atype; /* enum cgroup_bpf_attach_type */
        struct bpf_map *cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE];
        char name[BPF_OBJ_NAME_LEN];
-       unsigned int (*bpf_exception_cb)(u64 cookie, u64 sp, u64 bp);
+       u64 (*bpf_exception_cb)(u64 cookie, u64 sp, u64 bp, u64, u64);
 #ifdef CONFIG_SECURITY
        void *security;
 #endif
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index fe229b28e4a9..650ebe8ff183 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2537,7 +2537,7 @@ __bpf_kfunc void bpf_throw(u64 cookie)
         * which skips compiler generated instrumentation to do the same.
         */
        kasan_unpoison_task_stack_below((void *)(long)ctx.sp);
-       ctx.aux->bpf_exception_cb(cookie, ctx.sp, ctx.bp);
+       ctx.aux->bpf_exception_cb(cookie, ctx.sp, ctx.bp, 0, 0);
        WARN(1, "A call to BPF exception callback should never return\n");
 }

and with that all of test_progs runs successfully without CFI panics.
*happy dance*

Only test_progs -t btf/line_info fails suspiciously.
There we check that line info embedded in the prog looks sane.
New cfi preamble is probably tripping something.
It could be a test issue. I'll investigate. It's not a blocker.

Do you mind resending the whole set so that BPF CI can test it
on different archs ?

