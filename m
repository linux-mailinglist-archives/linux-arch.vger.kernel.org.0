Return-Path: <linux-arch+bounces-4841-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F29904610
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 23:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A92C1F2417D
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 21:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291FF7D086;
	Tue, 11 Jun 2024 21:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZbsExdp3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B595386
	for <linux-arch@vger.kernel.org>; Tue, 11 Jun 2024 21:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718140135; cv=none; b=MCrUQ34QCFMYH71PBOQwDfTjVBMvgRs/53hQJ3P7yUUGBah2vuRdZwDwoIvYJ8dE3t837wUufhr5zw8oN2XDdYOy8f5FrYsRajAbenFtKcrqV08QrFzvA2nt6xnBgeD+M7X19D4sdZkZ1R+SHgYxRLO3MxnIsL7GcZXIktuZ0Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718140135; c=relaxed/simple;
	bh=s73kx/qkmllyoFJabQ4swMZUTOUEOOuq9/NOP0odZQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DCURsK/0g4ZIPgMsGXvO66XzxgyF0C/p6x1TNdr6qveE7zsbcSf2jkpN8185fB75gYyA3zzJFx6fa45DWL6n2hJUir6zpHuFoNj4dnmDcgNqtnkPbBd/h9V3V/wJXWBUOgtZ54F919ez4vRQS5ZNTkfy6ZvY1yOANZqDhuZ5xKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZbsExdp3; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6f253a06caso175033866b.1
        for <linux-arch@vger.kernel.org>; Tue, 11 Jun 2024 14:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718140131; x=1718744931; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=alDbuvqzhZBPPdXqSWlCg+9FBjnZcAzHPWh0nIeAhME=;
        b=ZbsExdp3Q6zJ9gLVYRgI/kKZ214oXxrcoWEORcQLSx3yuLWJ/AvtpBh2SbdCXyNi//
         UZaiz2SMHnFVVj1EpLCyImD3zXR/b64ovANY71IT0ivdpl+a2kd9JyX8Pb392x61v/Dw
         jASPUjnsOqz4FRL9/42SvdjDHK+wW0mORzGPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718140131; x=1718744931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=alDbuvqzhZBPPdXqSWlCg+9FBjnZcAzHPWh0nIeAhME=;
        b=RL22ScSm2ZfQQJJiHQjlhDgarl1uQcxGkuFzsIxl6cVNglYdJc0ltOSB5G3fnOK+Bf
         CND9eKaIdZI246cG+kbZPmVQ18pyJmNWvSMnJOojsGGJhpWCmbyIj66X8tCQ6DnyKh2X
         kJ3lBXGoULzIG8MJePTJ0MdCogro8zUc38elkDLZTY7YrH4Z8nG8jx/+ZfrHQpY/DtT2
         atviHQu4rNk1eXrz1qQJrIzo9WE6GKYOrKsX9ZDa9pPnlVp2baA48SqLNbECKTaxw5lH
         4mZBf5bwjDmaZozXbYFNRL4UCqHB9AnZVvItbepkr9WJVEBxFGU8t932ADD+eyhtzHZL
         jjuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpUN692tFoFn68UvEO9ypMkrgVGGH5dTYiwYoz3slnghrHkef7g7dhD8kDLX+YliCOovaXHlvPWKRpKMdjSVxF1UjCjyToutUxfA==
X-Gm-Message-State: AOJu0Yx8LXWvhOuIWEQtfhvsTR6HoZLWmgM/pCrkhPzeoUwTJcjya6W/
	lGkoiGD0tGAMeOPcGkiN+dAhaG63J8d2+6rGEZE+K5NUExb++RMIT8lS6nJjEb+ssTmgXd55M2d
	0EvDElA==
X-Google-Smtp-Source: AGHT+IHRMo/Bg/AXY7LwnCQzS9Gj21xvUWgUnClYAZvGQcBiFkaM5EcNcFnNh5F9psrV/kiJmNdD3g==
X-Received: by 2002:a17:906:16d9:b0:a6f:a54:1598 with SMTP id a640c23a62f3a-a6f0a541702mr754685566b.49.1718140131281;
        Tue, 11 Jun 2024 14:08:51 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f37662fa1sm133300066b.17.2024.06.11.14.08.50
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 14:08:50 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6f04afcce1so193491866b.2
        for <linux-arch@vger.kernel.org>; Tue, 11 Jun 2024 14:08:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwsWwB1eB7hbXp6DM3wlesPfbYMZo3POsLgUeXHNoYatJSX7k08kEOszl2UkId29Zeq0vkT3RPuOEqIFAVNF6Vvji5GSNZIsiQFQ==
X-Received: by 2002:a17:906:f191:b0:a6f:37b7:52e6 with SMTP id
 a640c23a62f3a-a6f37b75431mr247440966b.2.1718140129865; Tue, 11 Jun 2024
 14:08:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610204821.230388-1-torvalds@linux-foundation.org>
 <20240610204821.230388-5-torvalds@linux-foundation.org> <ZmhfNRViOhyn-Dxi@J2N7QTR9R3>
 <CAHk-=wiHp60JjTs=qZDboGnQxKSzv=hLyjEp+8StqvtjOKY64w@mail.gmail.com>
 <ZmiN_7LMp2fbKhIw@J2N7QTR9R3> <CAHk-=wipw+_LKyXpuq9X7suf1VDUX4wD6iCuxFJKm9g2+ntFkQ@mail.gmail.com>
 <CAHk-=wgq4kMyeyhSm-Hrw1cQMi81=2JGznyVugeCejJoy1QSwg@mail.gmail.com> <ZmiyA3ASwk7PV3Rq@J2N7QTR9R3>
In-Reply-To: <ZmiyA3ASwk7PV3Rq@J2N7QTR9R3>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 11 Jun 2024 14:08:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=widPe38fUNjUOmX11ByDckaeEo9tN4Eiyke9u1SAtu9sA@mail.gmail.com>
Message-ID: <CAHk-=widPe38fUNjUOmX11ByDckaeEo9tN4Eiyke9u1SAtu9sA@mail.gmail.com>
Subject: Re: [PATCH 4/7] arm64: add 'runtime constant' support
To: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Anvin <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	"the arch/x86 maintainers" <x86@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Jun 2024 at 13:22, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On arm64 we have early ("boot") and late ("system-wide") alternatives.
> We apply the system-wide alternatives in apply_alternatives_all(), a few
> callees deep under smp_cpus_done(), after secondary CPUs are brought up,
> since that has to handle mismatched features in big.LITTLE systems.

Annoyingly, we don't have any generic model for this. Maybe that would
be a good thing regardless, but your point that you have big.LITTLE
issues does kind of reinforce the thing that different architectures
have different requirements for the alternatives patching.

On arm64, the late alternatives seem to be in

  kernel_init() ->
    kernel_init_freeable() ->
      smp_init() ->
        smp_cpus_done() ->
          setup_system_features() ->
            setup_system_capabilities() ->
              apply_alternatives_all()

which is nice and late - that's when the system is fully initialized,
and kernel_init() is already running as the first real thread.

On x86, the alternatives are finalized much earlier in

  start_kernel() ->
    arch_cpu_finalize_init ->
      alternative_instructions()

which is quite early, much closer to the early arm64 case.

Now, even that early x86 timing is good enough for vfs_caches_early(),
which is also done from start_kernel() fairly early on - and before
the arch_cpu_finalize_init() code is run.

But ...

> I had assumed that we could use late/system-wide alternatives here, since
> those get applied after vfs_caches_init_early(), but maybe that's too
> late?

So vfs_caches_init_early() is *one* case for the dcache init, but for
the NUMA case, we delay the dcache init until after the MM setup has
been completed, and do it relatively later in the init sequence at
vfs_caches_init().

See that horribly named 'hashdist' variable ('dist' is not 'distance',
it's 'distribute'). It's not dcache-specific, btw. There's a couple of
other hashes that do that whole "NUMA distribution or not" thing..

Annoying, yes. I'm not sure that the dual init makes any actual sense
- I think it's entirely a historical oddity.

But that "done conditionally in two different places" may be ugly, but
even if we fixed it, we'd fix it by doing it in just once, and it
would be that later "NUMA has been initialized" vfs_caches_init()
case.

Which is too late for the x86 alternatives.

The arm64 late case would seem to work fine. It's late enough to be
after all "core kernel init", but still early enough to be before the
"generic" initcalls that will start initializing filesystems etc (that
then need the vfs code to have been initialized).

So that "smp_init()" placement that arm64 has is actually a very good
place for at least the dcache case. It's just not what x86 does.

Note that my "just replace the constants" model avoids all the
ordering issues because it just does the constant initialization
synchronously when the constant is initialized.

So it doesn't depend on any other ordering at all, and there is no
worry about subtle differences in when alternatives are applied, or
when the uses happen.

(It obviously does have the same ordering requirement that the
variable initialization itself has: the dcache init itself has to
happen before any dcache use, but that's neither surprising nor a new
ordering imposed by the runtime constant case).

There's an advantage to just being self-sufficient and not tying into
random other subsystems that have random other constraints.

              Linus

