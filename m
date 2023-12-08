Return-Path: <linux-arch+bounces-832-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4C180AE68
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 21:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FFC8281AAA
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 20:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216924CB2C;
	Fri,  8 Dec 2023 20:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2bPEZZY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E851720;
	Fri,  8 Dec 2023 12:58:14 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40c317723a8so14801395e9.3;
        Fri, 08 Dec 2023 12:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702069093; x=1702673893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPbPGj/N+kFsGtRBn7sHjIbGBUsdMj/nlx3HBVB+JYE=;
        b=G2bPEZZYSb2B5Lgnfk/xinK7luuV5ZwdA1w3m5wHamNXH8qJjF+Z1tM9OTX62/HnOE
         OhV8zvE56h0DgRyx+VDqnobABGyRfCwYI5bQaCrCcVvTydUbvZHZlNWwOoDEeo0S6XMJ
         WpKPxdPDoitky7AgxAH5ogKWjpbBgV7sx7paOModJ4beN2iXcrA3zzSN/MFQFnydjWpT
         ANWz/022lm6+6EVc9JyMwTFRHw/+rlnuE9sFPbRvEhHg6a2sgh3KA83eOnlUan8qr4fD
         egHzRbSF6k0V3veNl7t0Fxm5lhk/OKwTpHIYwts6XaninN+0oI71FYKK3eY6uHjoV8fe
         INuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702069093; x=1702673893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPbPGj/N+kFsGtRBn7sHjIbGBUsdMj/nlx3HBVB+JYE=;
        b=AvNZLiFpSt0Ht7fXUVHyJCixbhks+NWEq1RlfzmivUqCr6SKBAaD9SG3vrMa9D20pw
         ciG/N3DUdILP88kw8Cyfky8RzXvahRLECChjJIufXjBHA5MG6mJulTVkvYNQ70Z6ciPr
         E87/q6K5fTF/3Ak2oxU/HLYMdtBc3YD205JGokSelfRebozgF0xtptq8uFLKnagLCV6t
         yJxIG8+SXahF02lZvhPqbs9O0Vbn8thTKovdk7ckBTHyQ5LCf9yr25dR/4xvy8OzW4Ax
         vTxRkdOgb0muAlagBroFywnSysvOBWTRJny1jBkOISx2a4IoF6//OrFwq6q60fG6dB9Y
         d7gA==
X-Gm-Message-State: AOJu0YxlCU5TPiSwiw65RSIdjuQ37fpxLkvWHMhRfX/EhcQGfFRtSpEg
	1owx+hvaMnvpKkoxKEh/cs4W76C4+TEovppWB5A=
X-Google-Smtp-Source: AGHT+IHEvTazMB26cXxqydUXzZjQ0E1EF3LcABQy94WqsbsZZavl6RKIzemfxTaf1pZCNseT7Ws4y7rzsk2OXl7MDFE=
X-Received: by 2002:a05:600c:2947:b0:40c:2954:5ad7 with SMTP id
 n7-20020a05600c294700b0040c29545ad7mr288834wmd.120.1702069092800; Fri, 08 Dec
 2023 12:58:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206183713.GA35897@noisy.programming.kicks-ass.net>
 <zu5eb2robdqnp2ojwaxjhnglcummrnjaqbw6krdds6qac3bql2@5zx46c2s6ez4>
 <20231207093105.GA28727@noisy.programming.kicks-ass.net> <ivhrgimonsvy3tyj5iidoqmlcyqvtsh2ay3cm3ouemsdbvjzs4@6jlt6zv55tgh>
 <20231208102940.GB28727@noisy.programming.kicks-ass.net> <20231208134041.GD28727@noisy.programming.kicks-ass.net>
 <20231208172152.GD36716@noisy.programming.kicks-ass.net> <CAADnVQKsnZfFomQ4wTZz=jMZW5QCV2XiXVsi64bghHkAjJtcmA@mail.gmail.com>
 <20231208203535.GG36716@noisy.programming.kicks-ass.net> <CAADnVQJzCw=qcG+jHBYG0q0SxLPkwghni0wpgV4A4PkpgVbGPw@mail.gmail.com>
 <20231208205241.GK28727@noisy.programming.kicks-ass.net>
In-Reply-To: <20231208205241.GK28727@noisy.programming.kicks-ass.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Dec 2023 12:58:01 -0800
Message-ID: <CAADnVQL3KsJONShsstDq5jrpbc_4FOU-VQPJgDCt50N9asoFzA@mail.gmail.com>
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

On Fri, Dec 8, 2023 at 12:52=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Fri, Dec 08, 2023 at 12:41:03PM -0800, Alexei Starovoitov wrote:
> > On Fri, Dec 8, 2023 at 12:35=E2=80=AFPM Peter Zijlstra <peterz@infradea=
d.org> wrote:
>
> > > -__bpf_kfunc void bpf_task_release(struct task_struct *p)
> > > +__bpf_kfunc void bpf_task_release(void *p)
> >
> > Yeah. That won't work. We need a wrapper.
> > Since bpf prog is also calling it directly.
> > In progs/task_kfunc_common.h
> > void bpf_task_release(struct task_struct *p) __ksym;
> >
> > than later both libbpf and the verifier check that
> > what bpf prog is calling actually matches the proto
> > of what is in the kernel.
> > Effectively we're doing strong prototype check at load time.
>
> I'm still somewhat confused on how this works, where does BPF get the
> address of the function from? and what should I call the wrapper?

It starts with
register_btf_id_dtor_kfuncs() that takes a set of btf_ids:
{btf_id_of_type, btf_id_of_dtor_function}, ...

Then based on btf_id_of_dtor_function we find its type proto, name, do chec=
ks,
and eventually:
addr =3D kallsyms_lookup_name(dtor_func_name);
field->kptr.dtor =3D (void *)addr;

bpf_task_release(struct task_struct *p) would need to stay as-is,
but we can have a wrapper
void bpf_task_release_dtor(void *p)
{
  bpf_task_release(p);
}

And adjust the above lookup with extra "_dtor" suffix.

> > btw instead of EXPORT_SYMBOL_GPL(bpf_task_release)
> > can __ADDRESSABLE be used ?
> > Since it's not an export symbol.
>
> No __ADDRESSABLE() is expressly ignored, but we have IBT_NOSEAL() that
> should do it. I'll rename the thing and lift it out of x86 to avoid
> breaking all other arch builds.

Makes sense.

