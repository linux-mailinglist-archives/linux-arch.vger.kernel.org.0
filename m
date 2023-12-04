Return-Path: <linux-arch+bounces-642-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC95E803A46
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 17:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84392B20B5C
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 16:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D829B2E655;
	Mon,  4 Dec 2023 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qEWxb0RO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AC0B4
	for <linux-arch@vger.kernel.org>; Mon,  4 Dec 2023 08:28:36 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-332c46d5988so3583745f8f.1
        for <linux-arch@vger.kernel.org>; Mon, 04 Dec 2023 08:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701707315; x=1702312115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ExnfZxVYVMvXtVrPDzieFUCNS347qRDxh4C9hinedE=;
        b=qEWxb0ROnOfJMhKvDo4MvjXpD2MAGB8kZvwAzAiVX4jO7/Zy/TDimvW0xcVAKwfkUo
         YHqMPNAcD4lFRVqqeAacrPYdVJuoGVVZru978HyGQA4o7u39bexQrL48ebV6IoSu6Zed
         tqPaBGdPcJLnQH99LDPc23sIB3omMCEp5JPTk9Lm2ri5mjqXr7gGMGjhBsaERjUUn0P/
         Hwpr91AgtC8e5CKVcudPbZax3lY2Mu6dcfNHy35ovolNgehGP1+AjQXquq8auod1DjbI
         VbA5yoJNtpqNso76h1MCuT946WNW3NSS075h7x1FgFmPAbV70GtkT2E188PToy5sLHTc
         Xh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701707315; x=1702312115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ExnfZxVYVMvXtVrPDzieFUCNS347qRDxh4C9hinedE=;
        b=YgquuUNuV5eEcF+XP+jsnnezwuGM/ZVVKkwdOqdnl9q8t1LEw5fYQiwWflzjN6qY0q
         DWhH2MWHF++NZW6pU6rsjju8lbZ3rBpS/Zpk6MDzO5TU8jeDkCk8DDLbO0OU96dqKSNp
         +iQDyDU03H5TIMPLuSSbaGuoga9mHvwOA26GOdzgiZSssthkT9+tVyHHwGpP1fyMRT2q
         8mGkSOzHAza9oPwX+ap030dpQah/5t1ZgOi6f5UwHQGXMAaqXpbvEOdte9VCYGW1Pe+D
         xUVd9T0xyHStGGQ2L4nM8SRnMsbDxQqWya7ob2HhYE5ps/n+GhYChfuFGnTrCX05a9y6
         ccjQ==
X-Gm-Message-State: AOJu0YztjdbGc6S3iESDUIUTzVqIZbENvkpr5EyniYspFzXYR9+hcbfV
	LquXpRYe2scNvTDmE8OGXmfe7g4K/GxWkTXAp83Okg==
X-Google-Smtp-Source: AGHT+IGnOKjeCz5yB866/XKel7WGP0XqRZykiL2PjFZMSwT0owq2u4yw/k+2hL+LNgiWmi11i0MklXo5mO20cDi5GUg=
X-Received: by 2002:a5d:50c2:0:b0:333:2fd2:5d51 with SMTP id
 f2-20020a5d50c2000000b003332fd25d51mr3535271wrt.131.1701707315273; Mon, 04
 Dec 2023 08:28:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120144642.591358648@infradead.org> <20231120154948.708762225@infradead.org>
 <20231122021817.ggym3biyfeksiplo@macbook-pro-49.dhcp.thefacebook.com>
 <20231122111517.GR8262@noisy.programming.kicks-ass.net> <CABCJKufBiJjUdmnuy=HkV+dDnZ=xne-OBwPSfJ21RX9c0AzCZw@mail.gmail.com>
In-Reply-To: <CABCJKufBiJjUdmnuy=HkV+dDnZ=xne-OBwPSfJ21RX9c0AzCZw@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 4 Dec 2023 08:28:21 -0800
Message-ID: <CAKwvOd=ZgoeXQAZZoLNYmd0OyuHktsnxLtcKzH4MEoDkPXnqyA@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/cfi,bpf: Fix BPF JIT call
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	davem@davemloft.net, dsahern@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, keescook@chromium.org, nathan@kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev, jpoimboe@kernel.org, joao@overdrivepizza.com, 
	mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 3:54=E2=80=AFPM Sami Tolvanen <samitolvanen@google.c=
om> wrote:
>
> On Wed, Nov 22, 2023 at 3:15=E2=80=AFAM Peter Zijlstra <peterz@infradead.=
org> wrote:
> >
> > So the kCFI thing is 'new' but readily inspected by objdump or godbolt:
> >
> >   https://godbolt.org/z/sGe18z3ca
> >
> > (@Sami, that .Ltmp15 thing, I don't see that in the kernel, what
> > compiler flag makes that go away?)
>
> Hmm, that looks like that's what we emit to .kcfi_traps. I suppose
> Godbolt just doesn't show the section directives?

Filter > [uncheck] Directives

>
> https://github.com/llvm/llvm-project/blob/main/llvm/test/CodeGen/X86/kcfi=
.ll#L30
>
> Sami



--=20
Thanks,
~Nick Desaulniers

