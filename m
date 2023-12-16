Return-Path: <linux-arch+bounces-1099-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 656798155B9
	for <lists+linux-arch@lfdr.de>; Sat, 16 Dec 2023 01:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39681F2433C
	for <lists+linux-arch@lfdr.de>; Sat, 16 Dec 2023 00:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C72ED7;
	Sat, 16 Dec 2023 00:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyqciA6i"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7DE7F2;
	Sat, 16 Dec 2023 00:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40c256ffdbcso14139625e9.2;
        Fri, 15 Dec 2023 16:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702688040; x=1703292840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0wkBeN2mknWfCaYD90okNAjhG97xOBmh5EL3y5dSjM=;
        b=gyqciA6i/mJasUIygwZqT91L2RbW+6l4OPQaxt0zuF0AL5S3f3tBNiZj0MPm7hSnfh
         6clUfr1NIs2Li/E/e9VgOh0AJeM6on0arofnNyZSrQPSo9W4RpItqzYbO2uBBRCH8O7r
         NAPnZd1lKCz/JXLTAfgENF1VCRtHTtZmDI1DPTqkU26XIS8N9LiLURuTcIq5XshKFPCR
         vhVM7TOv+21aPYw6C+PRhra7d22qRyBf9Z1T5IVXRefXyzRG/tL0Z2FjuMWS7LT0HPmB
         AM/Skj2oXcVgWw1kzy5FI3G5+cn6YfjFkZ5z5p66PM3DaqFozKI6tIhqwsfntp6Zp4ho
         ogpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702688040; x=1703292840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0wkBeN2mknWfCaYD90okNAjhG97xOBmh5EL3y5dSjM=;
        b=ZEtRGCTrAFjlW+hF1j7OfRcc/1UD4ZhnueZ6oV3GeDqxYuW7gYbMi2rKJSXjY0dhYR
         mfEz6wyFzTIwiguJcFQzXQZ1WiIc56IF1o2GTf6U8kBHgMwGNEnvgKJcvWPNee0U3Bio
         +Y2NKO53JzwR2BI12SM2oUvOgoF11po8i2+ENN1xNtH3hehV3CctmLhjlR8oL6Rw5DuY
         MQOjcqZTxXPnBtsk7rXvARTPrfd6ASYqtQo/L5sAKAiy/0WOdqqBRGJ+SnevQzOlVmPD
         uLeHl1TywqW0VxdpX1ANBz4kRkkmN13OIHtcRc/H4d98EBSwU9XJfy/ydwNoMYAoRKKR
         vcSw==
X-Gm-Message-State: AOJu0Yx/KaTsG9jW/H4ecF5xoD7wzW9iUuLhZO6b7Z5FHDvcB9nV5cIx
	0e1irjkncRAwwHoOqv71v+I+oi3l0fWzIS2J0wk=
X-Google-Smtp-Source: AGHT+IFuGmazbLWUSb4nLKggAzQnLeNmhiza7lIRh77ULXtw19cTSgKhotygxYJ0AUw8jKf6X6LfkImHGcy9Q5DkS7c=
X-Received: by 2002:adf:f609:0:b0:336:458b:38d with SMTP id
 t9-20020adff609000000b00336458b038dmr2405362wrp.115.1702688040032; Fri, 15
 Dec 2023 16:54:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215091216.135791411@infradead.org>
In-Reply-To: <20231215091216.135791411@infradead.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 15 Dec 2023 16:53:48 -0800
Message-ID: <CAADnVQJoEkdjyCEJRPASjBw1QGsKYrF33QdMGc1RZa9b88bAEA@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] x86/cfi,bpf: Fix CFI vs eBPF
To: Peter Zijlstra <peterz@infradead.org>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
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

On Fri, Dec 15, 2023 at 1:33=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> Hi!
>
> What started with the simple observation that bpf_dispatcher_*_func() was
> broken for calling CFI functions with a __nocfi calling context for FineI=
BT
> ended up with a complete BPF wide CFI fixup.
>
> With these changes on the BPF selftest suite passes without crashing -- t=
here's
> still a few failures, but Alexei has graciously offered to look into thos=
e.
>
> (Alexei, I have presumed your SoB on the very last patch, please update
> as you see fit)
>
> Changes since v2 are numerous but include:
>  - cfi_get_offset() -- as a means to communicate the offset (ast)
>  - 5 new patches fixing various BPF internals to be CFI clean

Looks great to me. Pushed to bpf-next.

There is a failure on s390 that I temporarily denylisted
with an extra patch.
And sent a proposed fix:
https://lore.kernel.org/bpf/20231216004549.78355-1-alexei.starovoitov@gmail=
.com/

Ilya,
please take a look.

> Note: it *might* be possible to merge the
> bpf_bpf_tcp_ca.c:unsupported_ops[] thing into the CFI stubs, as is
> get_info will have a NULL stub, unlike the others.

That's a good idea. Will clean up unsupported_ops.
Either myself or Martin will follow up.

