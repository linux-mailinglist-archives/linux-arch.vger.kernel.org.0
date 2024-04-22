Return-Path: <linux-arch+bounces-3892-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DACC8AD3FD
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 20:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02FC9281ED7
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 18:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0181154453;
	Mon, 22 Apr 2024 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFjAm3nG"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85A41847;
	Mon, 22 Apr 2024 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713810736; cv=none; b=QznZ5pBJl0AHmDy48WduUBUcGmD1B5IijLy07IEf5r/lnv88qxYRvA5oQaYlwdAlpqc1GVY1w1jWVl0QJqGwczxeeYfnZSSyAcfepfHnjKaKOF2nbfqgLPQaF761qomi9Pp7CLQeTv3/4Q6nT+jkRFMRRAHrU+7khNTTDfbwIaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713810736; c=relaxed/simple;
	bh=41bQmayZLa9F2TS6BjEFSDm7V8S6LLEq/o95h7wxG6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l28eZyiFEZGZ1i/VsciXHLakue8jpER4MkOl+eJHmzT4EU9NaymBI9aKgNE9lZM/8yoE6WRNH4NyIldiPpWKYf1t9kvuTHhyts5SEsj2/ZLFCkaNrcxQpiqy6FhTHbHod+xQPd+97s1/vPOsXJ5KKbqXRqeBgtbDl/8gOtm5gBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFjAm3nG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA94C4AF0B;
	Mon, 22 Apr 2024 18:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713810736;
	bh=41bQmayZLa9F2TS6BjEFSDm7V8S6LLEq/o95h7wxG6E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WFjAm3nG7XUTrBnb9o2ks89OQgjxiSe5eWX8YxXd1sW0hbIxt8VjaFgdNY7jwwl/k
	 AfWjBBQkR55Va8AnJ9aZ9HNo3aWGj92Hg8yQfe6AZc/sgCyr09/ddJev56eXLxhUbk
	 bYRNUKDXSWSv0PHnlWydUHx0kp/IGq0ZRSR0xO71ow/Lfv7EI3MTbMaLFw4v7bXSFJ
	 3STUYz/yJHlp6VqKWBeoWQO13+U5j6+pSZw+u4eCUWHpkY832oOPrwYV84rmuYW4C/
	 bOCj02N41ZbDl+Gdwcz6EkWfYsWwZ5MhWh4lcO8wHP44/mjOjwNi1xfPxSrEJkKHPw
	 nRWV7XhBkaFPQ==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2da08b06e0dso56752861fa.2;
        Mon, 22 Apr 2024 11:32:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVAiL4f0XpoTnbX2tsCYaeKCYRiAi5LlPsAXRg2XqaLnBfw0mAuWdG/n2s/rm1fN67yq2GFli/x7nix6Ci20zGBFF2tfTCPkpcU/cIUBXZfkl7bWOQ674srKDnADgriyGJjKil0QaqrFI6dYTBROAkgPQKjtNQoJOgjlaRxPYZtdGQ1xcGmfmo0LD51lKKVhfV+73d6mxcL3emy2Up/snWYvkBkSLoI6l8HPx139+GJVqJqGWEqCwbslJXVJ+i8E6ipAnU54pLeSVwJhoM1dTOLgvLRzXWjcDvU2C4oMB/Tgx3uj0qCNRGpKIrpvjSk81tsEbxLki9rk8infjoGwWTgUgZ/U+KECMhad5na35inrctV6TP7qU+I+9l7U++LRZ9ZsqeiFMXTp8B2pjo9iEXyJe6o+/8L3LQDsvbol2gD9M6TJmM+Tb/uvUQ=
X-Gm-Message-State: AOJu0YzIVj4kudDkOfIdSzPU7qWk5hi4ACyrTbrFxV2xQk0sd40r9cdc
	G+YEaqz2iHHiLezycD0rMYEcmoO8FS2eYfkJpBR1rkwmo709PQ8NsIDTsIZrqnsyZnn0247incU
	B6rCbtRT3RUAl8E2ws3o7ouKDoIs=
X-Google-Smtp-Source: AGHT+IEL0FWUHmCKYIOk93aax6U4BdFHP3q3Bogcq6+CoScwmomqpj0/rB2eiX3SYQzXlZuuQSNAuqDXXtIwEOxd65Y=
X-Received: by 2002:a2e:9496:0:b0:2d8:1d29:23a8 with SMTP id
 c22-20020a2e9496000000b002d81d2923a8mr6582027ljh.29.1713810734431; Mon, 22
 Apr 2024 11:32:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZiE91CJcNw7gBj9g@kernel.org> <CAPhsuW4au6v8k8Ab7Ff6Yj64rGvZ7wkz=Xrgh8ZZtLyscpChqQ@mail.gmail.com>
 <ZiFd567L4Zzm2okO@kernel.org> <CAPhsuW5SL4_=ZXdHZV8o0KS+5Vf25UMvEKhRgFQLioFtf2pgoQ@mail.gmail.com>
 <ZiIVVBgaDN4RsroT@kernel.org> <CAPhsuW7WoU+a46FhqqH8f-3=ehxeD4wSgKDWegMin1pT49OSWw@mail.gmail.com>
 <ZiKjmaDgz_56ovbv@kernel.org> <CAPhsuW7Nj1Sa_9xQtTgHz9AmX39zdh2x2COqA-qmkfpfX9hNWw@mail.gmail.com>
 <ZiLNGgVSQ7_cg58y@kernel.org> <CAPhsuW4KRM4O4RFbYQrt=Coqyh9w29WiF2YF=8soDfauLFsKBA@mail.gmail.com>
 <ZiNDGjkcqEPqruza@kernel.org> <20240420181121.d6c7be11a6f98dc2462f8b41@kernel.org>
In-Reply-To: <20240420181121.d6c7be11a6f98dc2462f8b41@kernel.org>
From: Song Liu <song@kernel.org>
Date: Mon, 22 Apr 2024 11:32:02 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5RYfq8FOtMkO69cdQ3Bc1p2kQPWE2crts1UMhqJr+7sQ@mail.gmail.com>
Message-ID: <CAPhsuW5RYfq8FOtMkO69cdQ3Bc1p2kQPWE2crts1UMhqJr+7sQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/15] mm: introduce execmem_alloc() and execmem_free()
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Bjorn Topel <bjorn@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, "David S. Miller" <davem@davemloft.net>, 
	Dinh Nguyen <dinguyen@kernel.org>, Donald Dutile <ddutile@redhat.com>, 
	Eric Chanudet <echanude@redhat.com>, Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, 
	Huacai Chen <chenhuacai@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Luis Chamberlain <mcgrof@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nadav Amit <nadav.amit@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Puranjay Mohan <puranjay12@gmail.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Russell King <linux@armlinux.org.uk>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Will Deacon <will@kernel.org>, bpf@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linux-mm@kvack.org, linux-modules@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
	netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Masami and Mike,

On Sat, Apr 20, 2024 at 2:11=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
[...]
> > >
> > > IIUC, we need to update __execmem_cache_alloc() to take a range point=
er as
> > > input. module text will use "range" for EXECMEM_MODULE_TEXT, while kp=
robe
> > > will use "range" for EXECMEM_KPROBE. Without "map to" concept or shar=
ing
> > > the "range" object, we will have to compare different range parameter=
s to check
> > > we can share cached pages between module text and kprobe, which is no=
t
> > > efficient. Did I miss something?
>
> Song, thanks for trying to eplain. I think I need to explain why I used
> module_alloc() originally.
>
> This depends on how kprobe features are implemented on the architecture, =
and
> how much features are supported on kprobes.
>
> Because kprobe jump optimization and kprobe jump-back optimization need t=
o
> use a jump instruction to jump into the trampoline and jump back from the
> trampoline directly, if the architecuture jmp instruction supports +-2GB =
range
> like x86, it needs to allocate the trampoline buffer inside such address =
space.
> This requirement is similar to the modules (because module function needs=
 to
> call other functions in the kernel etc.), at least kprobes on x86 used
> module_alloc().
>
> However, if an architecture only supports breakpoint/trap based kprobe,
> it does not need to consider whether the execmem is allocated.
>
> >
> > We can always share large ROX pages as long as they are within the corr=
ect
> > address space. The permissions for them are ROX and the alignment
> > differences are due to KASAN and this is handled during allocation of t=
he
> > large page to refill the cache. __execmem_cache_alloc() only needs to l=
imit
> > the search for the address space of the range.
>
> So I don't think EXECMEM_KPROBE always same as EXECMEM_MODULE_TEXT, it
> should be configured for each arch. Especially, if it is only used for
> searching parameter, it looks OK to me.

Thanks for the explanation!

I was thinking "we can have EXECMEM_KPROBE share the same parameters as
EXECMEM_MODULE_TEXT for all architectures". But this thought is built on to=
p
of assumptions on future changes/improvements within multiple sub systems.
At this moment, I have no objections moving forward with current execmem AP=
Is.

Thanks,
Song

