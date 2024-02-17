Return-Path: <linux-arch+bounces-2472-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 496EA8590C7
	for <lists+linux-arch@lfdr.de>; Sat, 17 Feb 2024 17:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8CF1C20A2A
	for <lists+linux-arch@lfdr.de>; Sat, 17 Feb 2024 16:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E467CF1E;
	Sat, 17 Feb 2024 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEuCh4Nf"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5933A657BE;
	Sat, 17 Feb 2024 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708186241; cv=none; b=fzbU2zMFceSJxpxb5OvkfcBygEtU/77TJjOF3+K2MBE6UCi0aA5BxCiCVh8V6pUF2QTDgORMs2MDyTgpwrR7ihH3xeMNxcE06mxCOqDCjbiIJ4NEz6Ibes69hCe4wgdnLaeWeab2+LQZe6co+iGcpelgHctFMNU5fU8yrKbfqnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708186241; c=relaxed/simple;
	bh=TlkPr8Bk0hf2IBX145DAXLzNeJEF5v5nNXWhGlopdeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oyacWll+AztLVviHR4Tlrbf8OFbmGTDf9WQTrczKvpiHq1rvwhVdFrPCnurcDt+OttiuW7ed3jfo3BzilzDWZlmtKoN2sYDeY7AQA1nOYQk8dvXvA8s+rR2JPOIaPU3bsj3rd6P7+U5QeTJpoS4UY45Y6lYc6QjWgFOKlz+RYCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEuCh4Nf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB484C43141;
	Sat, 17 Feb 2024 16:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708186240;
	bh=TlkPr8Bk0hf2IBX145DAXLzNeJEF5v5nNXWhGlopdeg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IEuCh4NfdXj8D9T+ivVhOSJXFtOo1eSUw9VluA4qAnNuPhJ7WZz5uIBkLB/BY+CjA
	 UuHWkzHSznovLMMJ6PRqpbAdhRjFw3TQZV0p19dr9hu0YyuEbCtLnE1fIHbDiGtbwL
	 bTAIqmxUn+PDZt6r3jRYi2O2+MgaJjH2E2ehsZ+wQk5PWoyN7VIoSNL4mWjlYe3NLc
	 4b/gpfYIhrWMOs7SCxTkN92ufgJSWJjcqPTLGlkH8Kotjixl77NXc0ZBW8b/q/GTcr
	 XFqIzI6gvDEkWRwWYSccyU+xS24jHMja8AdB4KyPXsQwF9f02NHrwfXobGUpSpq11/
	 qZHc5GDQDFATw==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-512a85806fcso350422e87.2;
        Sat, 17 Feb 2024 08:10:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW8LAzhxBTx0ZaV8UZzQmB2VNP4HWgcOazXAkchNg9y6WL01wYd17LKJNmx5EWKyJoVKOdC79xzihRkeTFQP17R/UuEgEbeCCfkwfSMuQTMLZwCC1yznT3wbWARqszvtUpCKyuzVdnfmQ==
X-Gm-Message-State: AOJu0YwNbGoJmxwEHgHvdPzEYsja4sXicYkvPLy1i97ynXJ1t84/Bp3H
	rMfd2H+lViJxF2YGQgphMWvTY8/J3f4oNCAcN8suahhJK4x47MqbfB6P1REQuAmX3ik6R3Qchuq
	CZax6d2yspXj4dtbgZ/DaZp1spNg=
X-Google-Smtp-Source: AGHT+IEkM5KquFSZuoXI9HJdzRKh1TBNPNCqh9yXAqz+KOdwPKpXcP6oFJ0S0iwmstSAif+Mj7dmJ+/lxUjVPsDvfA8=
X-Received: by 2002:a05:6512:3fa:b0:511:46df:7ef4 with SMTP id
 n26-20020a05651203fa00b0051146df7ef4mr4459789lfq.22.1708186238813; Sat, 17
 Feb 2024 08:10:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213124143.1484862-13-ardb+git@google.com>
 <20240213124143.1484862-15-ardb+git@google.com> <20240217125102.GSZdCrtgI-DnHA8DpK@fat_crate.local>
 <CAMj1kXEcTfvRcNh_VDhj5QxzMhD9rFhVmeAfuSF7vm1c_4_iHg@mail.gmail.com>
In-Reply-To: <CAMj1kXEcTfvRcNh_VDhj5QxzMhD9rFhVmeAfuSF7vm1c_4_iHg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 17 Feb 2024 17:10:27 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFkX2hwt7Z-_xMveC-RHrxmXWcrneVH66HsjBcXOLAH0g@mail.gmail.com>
Message-ID: <CAMj1kXFkX2hwt7Z-_xMveC-RHrxmXWcrneVH66HsjBcXOLAH0g@mail.gmail.com>
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

On Sat, 17 Feb 2024 at 14:58, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Sat, 17 Feb 2024 at 13:51, Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Tue, Feb 13, 2024 at 01:41:46PM +0100, Ard Biesheuvel wrote:
> > > @@ -201,25 +201,19 @@ unsigned long __head __startup_64(unsigned long physaddr,
> > >       load_delta += sme_get_me_mask();
> > >
> > >       /* Fixup the physical addresses in the page table */
> > > -
> > > -     pgd = fixup_pointer(early_top_pgt, physaddr);
> > > -     p = pgd + pgd_index(__START_KERNEL_map);
> > > -     if (la57)
> > > -             *p = (unsigned long)level4_kernel_pgt;
> > > -     else
> > > -             *p = (unsigned long)level3_kernel_pgt;
> > > -     *p += _PAGE_TABLE_NOENC - __START_KERNEL_map + load_delta;
> > > -
> > >       if (la57) {
> > > -             p4d = fixup_pointer(level4_kernel_pgt, physaddr);
> > > -             p4d[511] += load_delta;
> > > +             p4d = (p4dval_t *)&RIP_REL_REF(level4_kernel_pgt);
> > > +             p4d[MAX_PTRS_PER_P4D - 1] += load_delta;
> > >       }
> > >
> > > -     pud = fixup_pointer(level3_kernel_pgt, physaddr);
> > > -     pud[510] += load_delta;
> > > -     pud[511] += load_delta;
> > > +     pud = &RIP_REL_REF(level3_kernel_pgt)->pud;
> > > +     pud[PTRS_PER_PUD - 2] += load_delta;
> > > +     pud[PTRS_PER_PUD - 1] += load_delta;
> > > +
> > > +     pgd = &RIP_REL_REF(early_top_pgt)->pgd;
> >
> > Let's do the pgd assignment above, where it was so that we have that
> > natural order of p4d -> pgd -> pud ->pmd etc manipulations.
> >
>
> pud and p4d need to be assigned first, unless we want to keep taking
> the addresses of level4_kernel_pgt and level3_kernel_pgt twice as
> before.
>
> > > +     pgd[PTRS_PER_PGD - 1] = (pgdval_t)(la57 ? p4d : pud) | _PAGE_TABLE_NOENC;
> >
> > I see what you mean with pgd_index(__START_KERNEL_map) always being 511
> > but this:
> >
> >         pgd[pgd_index(__START_KERNEL_map)] = (pgdval_t)(la57 ? p4d : pud) | _PAGE_TABLE_NOENC;
> >
> > says exactly what gets mapped there in the pagetable while
> >
> >         PTRS_PER_PGD - 1
> >
> > makes me wonder what's that last pud supposed to map.
> >
>
> Fair enough. But the same applies to p4d[] and pud[].
>
> > Other than that, my gut feeling right now is, this would need extensive
> > testing so that we make sure there's no fallout from it.
> >
>
> More testing is always good, but I am not particularly nervous about
> these changes.
>
> I could split this up into 3+ patches so we could bisect any resulting
> issues more effectively.

Maybe this is better?

--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -165,14 +165,14 @@
  * doesn't have to generate PC-relative relocations when accessing globals from
  * that function. Clang actually does not generate them, which leads to
  * boot-time crashes. To work around this problem, every global pointer must
- * be adjusted using fixup_pointer().
+ * be accessed using RIP_REL_REF().
  */
 unsigned long __head __startup_64(unsigned long physaddr,
                                  struct boot_params *bp)
 {
        pmd_t (*early_pgts)[PTRS_PER_PMD] = RIP_REL_REF(early_dynamic_pgts);
-       unsigned long load_delta, *p;
        unsigned long pgtable_flags;
+       unsigned long load_delta;
        pgdval_t *pgd;
        p4dval_t *p4d;
        pudval_t *pud;
@@ -202,17 +202,14 @@ unsigned long __head __startup_64(unsigned long physaddr,

        /* Fixup the physical addresses in the page table */

-       pgd = fixup_pointer(early_top_pgt, physaddr);
-       p = pgd + pgd_index(__START_KERNEL_map);
-       if (la57)
-               *p = (unsigned long)level4_kernel_pgt;
-       else
-               *p = (unsigned long)level3_kernel_pgt;
-       *p += _PAGE_TABLE_NOENC - __START_KERNEL_map + load_delta;
+       pgd = &RIP_REL_REF(early_top_pgt)->pgd;
+       pgd[pgd_index(__START_KERNEL_map)] += load_delta;

        if (la57) {
-               p4d = fixup_pointer(level4_kernel_pgt, physaddr);
-               p4d[511] += load_delta;
+               p4d = (p4dval_t *)&RIP_REL_REF(level4_kernel_pgt);
+               p4d[MAX_PTRS_PER_P4D - 1] += load_delta;
+
+               pgd[pgd_index(__START_KERNEL_map)] = (pgdval_t)p4d |
_PAGE_TABLE_NOENC;
        }

        RIP_REL_REF(level3_kernel_pgt)[PTRS_PER_PUD - 2].pud += load_delta;
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 3cac98c61066..fb2a98c29094 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -653,7 +653,8 @@ SYM_CODE_END(vc_no_ghcb)
        .balign 4

 SYM_DATA_START_PTI_ALIGNED(early_top_pgt)
-       .fill   512,8,0
+       .fill   511,8,0
+       .quad   level3_kernel_pgt - __START_KERNEL_map + _PAGE_TABLE_NOENC
        .fill   PTI_USER_PGD_FILL,8,0
 SYM_DATA_END(early_top_pgt)

