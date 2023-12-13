Return-Path: <linux-arch+bounces-970-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FA2810CBC
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 09:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD75281C85
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 08:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119E21EB3E;
	Wed, 13 Dec 2023 08:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyFHmbnm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E03A0;
	Wed, 13 Dec 2023 00:49:03 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c339d2b88so51939775e9.3;
        Wed, 13 Dec 2023 00:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702457342; x=1703062142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3iYD9RnPAzZn/twKQIifseItY/M9p2JS4Pz3uXMUgu8=;
        b=NyFHmbnmYpVcXLy2MQhJO01BuqPH9Dt2FgFjTrdqz1HqEPpvMJ/xyTVNeHQuk5rQtx
         5AZYmicjiOssR2pLT0jefLL4DO/qGWHXMzSv02rQxT/TkhTdFP9BpakEYFZ4wwdFN0Vj
         FRteLKnSqdkxTPG5z+htr/JzUjuEPbHtgbzuX/I+aeWe2M22ugYxcUoKzHXhdrarSzyd
         9tWnXBbdD7aR+T9TQAb5TySjOA3OaPGggnKcAxipRtBVo0vtGsqB1qcWPzl7edsfwOuy
         qtflaNtUOuZEHtBRePAVHUctZoHa5JF/kcDsDm0v0l9366x/X2xhm0kteibd4aWtiqIK
         aYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702457342; x=1703062142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3iYD9RnPAzZn/twKQIifseItY/M9p2JS4Pz3uXMUgu8=;
        b=CiLqhF6lnK7dOwN60JvPJV1izfxRsBeCf16VYMZrSFOSQ2NG0kiFckdwu4In+kD/VT
         ugJQZBcNN6/LZFAix2ewF8yfS8SlVKAFbeBNJHdrPAQ2tpf/ObLB5w/ALgObrjujpIbW
         12317yEuc2GgsKSg9cNdQ7BXGzXbwIUwR+0Rt7StcOiM5G6kHc5VIf99tiHQPKgGKDRX
         lv4zTdiFD0Jnva8FC2WOlZdzd/Ob8ReafbSiiiUsCkHnk8M6CcOlPHknLCDgPH3G33UI
         EYHNdlB63gP1ucjeY0tFqlkD4/GXBTwIf3+VGFK/Z8Gy0I8cfzNbvQZpbMMqQQn+7U+S
         1ceg==
X-Gm-Message-State: AOJu0YzlUWmEA+MDLXXN/O2Tvkk2vhgZ0VFdk6xQIVC31iBSsa6aro4m
	5ojXc4mHATCyZqy/JFTf2NDi9nHlzXuEd12W3YI=
X-Google-Smtp-Source: AGHT+IFBk1lNKv3BcxKBdjQgOw3kbIIuMtHUxLUHRm6/4kNBX81PypqFHKgMOYx4nqumSh9nXBONTvkOTaO2J8UGnLQ=
X-Received: by 2002:a05:600c:44e:b0:40c:6e8:610a with SMTP id
 s14-20020a05600c044e00b0040c06e8610amr4076458wmb.56.1702457341628; Wed, 13
 Dec 2023 00:49:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20221219061758.23321-1-ashimida.1990@gmail.com>
 <20230325085416.95191-1-ashimida.1990@gmail.com> <20230327093016.GB4253@hirez.programming.kicks-ass.net>
 <CABCJKueH6ohH27xCPz9a_ndRR26Na_mo=MGF3eqjwV2=gJy+wQ@mail.gmail.com>
In-Reply-To: <CABCJKueH6ohH27xCPz9a_ndRR26Na_mo=MGF3eqjwV2=gJy+wQ@mail.gmail.com>
From: Dan Li <ashimida.1990@gmail.com>
Date: Wed, 13 Dec 2023 16:48:50 +0800
Message-ID: <CAE+Z0PFZaa2bwtfY5P7ZDYH4JjMxKpJgqz0m+KJ_ks4dctzAKA@mail.gmail.com>
Subject: Re: [RFC/RFT,V2] CFI: Add support for gcc CFI in aarch64
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Aaron Tomlin <atomlin@redhat.com>, 
	Alexander Potapenko <glider@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, 
	Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>, Brian Gerst <brgerst@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Changbin Du <changbin.du@intel.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Eric W. Biederman" <ebiederm@xmission.com>, 
	Frederic Weisbecker <frederic@kernel.org>, gcc-patches@gcc.gnu.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Kalesh Singh <kaleshsingh@google.com>, Kees Cook <keescook@chromium.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Marco Elver <elver@google.com>, 
	Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Michael Roth <michael.roth@amd.com>, Michal Marek <michal.lkml@markovi.net>, 
	Miguel Ojeda <ojeda@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nicolas Schier <nicolas@fjasle.eu>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Richard Sandiford <richard.sandiford@arm.com>, Song Liu <song@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Tom Rix <trix@redhat.com>, Uros Bizjak <ubizjak@gmail.com>, 
	Will Deacon <will@kernel.org>, x86@kernel.org, Yuntao Wang <ytcoode@gmail.com>, 
	Yu Zhao <yuzhao@google.com>, Zhen Lei <thunder.leizhen@huawei.com>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	wanglikun@lixiang.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ Likun

On Tue, 28 Mar 2023 at 06:18, Sami Tolvanen <samitolvanen@google.com> wrote=
:
>
> On Mon, Mar 27, 2023 at 2:30=E2=80=AFAM Peter Zijlstra <peterz@infradead.=
org> wrote:
> >
> > On Sat, Mar 25, 2023 at 01:54:16AM -0700, Dan Li wrote:
> >
> > > In the compiler part[4], most of the content is the same as Sami's
> > > implementation[3], except for some minor differences, mainly includin=
g:
> > >
> > > 1. The function typeid is calculated differently and it is difficult
> > > to be consistent.
> >
> > This means there is an effective ABI break between the compilers, which
> > is sad :-( Is there really nothing to be done about this?
>
> I agree, this would be unfortunate, and would also be a compatibility
> issue with rustc where there's ongoing work to support
> clang-compatible CFI type hashes:
>
> https://github.com/rust-lang/rust/pull/105452
>
> Sami

