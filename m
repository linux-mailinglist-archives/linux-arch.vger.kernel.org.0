Return-Path: <linux-arch+bounces-2471-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9778E858FDC
	for <lists+linux-arch@lfdr.de>; Sat, 17 Feb 2024 14:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2C8A1C210D0
	for <lists+linux-arch@lfdr.de>; Sat, 17 Feb 2024 13:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF9E7AE6D;
	Sat, 17 Feb 2024 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMybhXTt"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4037AE6B;
	Sat, 17 Feb 2024 13:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708178323; cv=none; b=euZ9NSHClbKuRpXhyZjH/mitf1LznCPOu0ALJamRIihYi8G2Xy+crmZiHy8IjXU5G1bMEsHXpeeKvmgiWItaVa98oza0NTX7uLryySoheMxORKvWrFXz9v3vZUwB3ac4y3RNk6O5bMt7T6ZgtcEahxZT8cJNa7rQ8QGT4Goy74Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708178323; c=relaxed/simple;
	bh=sAcCq6XtoR8XkUX+DFBUEtNZIwxNLsoCtzehSVHrAak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+ePemkKi+5R78ZTtdkYI4k9oHJmuPdTilZrmMN65n1kNeNq3nudDYIHG+fi1H7auAQmK6YaD7hiRDUPOJ4FWpZJKT/Ko44FRtaM9A0Oxxguib6fB9mpQHYqMXTScmhe2sTpTd43GJLV4aBNAK0ol9fmGKIlYOavgp4GvZKEnB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMybhXTt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9578C43143;
	Sat, 17 Feb 2024 13:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708178322;
	bh=sAcCq6XtoR8XkUX+DFBUEtNZIwxNLsoCtzehSVHrAak=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XMybhXTtKs5/vD1wbX9sUp59xaK45kNYcooAWwDJlP4wfaCe44p9iEFkUmXqE/bcy
	 +nVgvXQmsAv9KSLMmDES+r4/BhEWiBHR/e93DfJasSwkVD07Fr+9M4beJobHY4aUII
	 YiCl9VBoxdeHSrc8pipogKyWWAhD0zaZ3ONWvugiJLCyWiFzdr1xQgdzdHFJwPkszP
	 Hv7y6zZ14GMYR3zQ3NMJVkFrpzX+RiiuAPsXRJvPBchCXrnfL0pqJBjcXu1GPNrTES
	 O5vqmUmbWOpUl2Tv+Xg6k13CCFhiKHE8JMdQOtemY9Nct4PF0FSR6+xh+OyDJ4sPMq
	 +ngHWB80/MVTQ==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d21a68dd3bso19062871fa.1;
        Sat, 17 Feb 2024 05:58:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXLm6dSvAc0sIP4vpLkxck6ThtTfWlXBw/EfRHKNVc56DBSC0i0amCcVRgMljncxcxmAkC011SgcMkdCIzmkGhNxB4Tl8fnVQOohTj12/7tRj0R8XMisazZUS8gKHB23Dt17PV6Q0b2gw==
X-Gm-Message-State: AOJu0YzXceD3/70MUkHOe0PHAe7oCS9hPk0BxOMrRCkjNtk/TtpqVxrm
	ET7EscLULspPn/qo5SMunq6nk6DxOMA9JaHMzKZ+j5pOZLIk9tnpTGPgiQWBOYNN0DvmXKlO0//
	0hsJwIuCwk5wXP0EoXuTLsjucFjs=
X-Google-Smtp-Source: AGHT+IEDEpA2fOislw0nRMmvh9fts/HvdzRjOlV5V4Oj3nOdgApmC0o349jTB1qWSyd5IiTujPllDlPw1+V9isA6YH0=
X-Received: by 2002:a05:651c:1051:b0:2d0:a469:8a43 with SMTP id
 x17-20020a05651c105100b002d0a4698a43mr5663443ljm.18.1708178320718; Sat, 17
 Feb 2024 05:58:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213124143.1484862-13-ardb+git@google.com>
 <20240213124143.1484862-15-ardb+git@google.com> <20240217125102.GSZdCrtgI-DnHA8DpK@fat_crate.local>
In-Reply-To: <20240217125102.GSZdCrtgI-DnHA8DpK@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 17 Feb 2024 14:58:29 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEcTfvRcNh_VDhj5QxzMhD9rFhVmeAfuSF7vm1c_4_iHg@mail.gmail.com>
Message-ID: <CAMj1kXEcTfvRcNh_VDhj5QxzMhD9rFhVmeAfuSF7vm1c_4_iHg@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] x86/startup_64: Replace pointer fixups with
 RIP-relative references
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Glaze <dionnaglaze@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Feb 2024 at 13:51, Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Feb 13, 2024 at 01:41:46PM +0100, Ard Biesheuvel wrote:
> > @@ -201,25 +201,19 @@ unsigned long __head __startup_64(unsigned long physaddr,
> >       load_delta += sme_get_me_mask();
> >
> >       /* Fixup the physical addresses in the page table */
> > -
> > -     pgd = fixup_pointer(early_top_pgt, physaddr);
> > -     p = pgd + pgd_index(__START_KERNEL_map);
> > -     if (la57)
> > -             *p = (unsigned long)level4_kernel_pgt;
> > -     else
> > -             *p = (unsigned long)level3_kernel_pgt;
> > -     *p += _PAGE_TABLE_NOENC - __START_KERNEL_map + load_delta;
> > -
> >       if (la57) {
> > -             p4d = fixup_pointer(level4_kernel_pgt, physaddr);
> > -             p4d[511] += load_delta;
> > +             p4d = (p4dval_t *)&RIP_REL_REF(level4_kernel_pgt);
> > +             p4d[MAX_PTRS_PER_P4D - 1] += load_delta;
> >       }
> >
> > -     pud = fixup_pointer(level3_kernel_pgt, physaddr);
> > -     pud[510] += load_delta;
> > -     pud[511] += load_delta;
> > +     pud = &RIP_REL_REF(level3_kernel_pgt)->pud;
> > +     pud[PTRS_PER_PUD - 2] += load_delta;
> > +     pud[PTRS_PER_PUD - 1] += load_delta;
> > +
> > +     pgd = &RIP_REL_REF(early_top_pgt)->pgd;
>
> Let's do the pgd assignment above, where it was so that we have that
> natural order of p4d -> pgd -> pud ->pmd etc manipulations.
>

pud and p4d need to be assigned first, unless we want to keep taking
the addresses of level4_kernel_pgt and level3_kernel_pgt twice as
before.

> > +     pgd[PTRS_PER_PGD - 1] = (pgdval_t)(la57 ? p4d : pud) | _PAGE_TABLE_NOENC;
>
> I see what you mean with pgd_index(__START_KERNEL_map) always being 511
> but this:
>
>         pgd[pgd_index(__START_KERNEL_map)] = (pgdval_t)(la57 ? p4d : pud) | _PAGE_TABLE_NOENC;
>
> says exactly what gets mapped there in the pagetable while
>
>         PTRS_PER_PGD - 1
>
> makes me wonder what's that last pud supposed to map.
>

Fair enough. But the same applies to p4d[] and pud[].

> Other than that, my gut feeling right now is, this would need extensive
> testing so that we make sure there's no fallout from it.
>

More testing is always good, but I am not particularly nervous about
these changes.

I could split this up into 3+ patches so we could bisect any resulting
issues more effectively.

