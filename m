Return-Path: <linux-arch+bounces-12411-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C08EAE10FA
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jun 2025 04:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 031754A1EAE
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jun 2025 02:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39354128816;
	Fri, 20 Jun 2025 02:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XplCFzea"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D4115E97
	for <linux-arch@vger.kernel.org>; Fri, 20 Jun 2025 02:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750385788; cv=none; b=rVhTQfPuh4j6U+gYDhXVxBsc5oiFf9VO1Rv1yv6JunG2GmG+6e0Yy5NMUXSaaZ0lMnJqmqOzSQJBwkvel2OvSry3CqoK7+vb3RjmgZeCDzNe3CNqFHab1qxbfTEqWBV7aP/m3a5N1RZv4CdQXzbs8EKIKx0wooNEHqXPcFvytxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750385788; c=relaxed/simple;
	bh=g5OW8tuvyxUA+t6pLcKEEoc1EraU6/LLk2G3G1r0G+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l3LuBuo5cwT1Tc9NQ3bl3MFUsWiCxtinrerXIgTc4VGbDuB+CO72mfQwMmMBsiMn+KYneWz25GQpzOL3jiF+Bn3YNYjDKnLA9DnhWStBhSxuv1KDpszUFaXdx/iZnb05KEbLYNycyVFI31irkNqta6evzKUmhEjJxxOtkJKR/ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=XplCFzea; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-86a464849c2so45823639f.1
        for <linux-arch@vger.kernel.org>; Thu, 19 Jun 2025 19:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1750385784; x=1750990584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6VzlhRVh//x5/bp+2ihBVL31M01Rg7PAdE9X0/n0so=;
        b=XplCFzeaT0UI3xYRmaARyqEdD97XMne1e3DHmUxq4ajv1NXr3mZN6+HpBn8+p4y2vC
         ZIffVKiUiG6KqmOdRuglV8AMpVVmK4nQTkuQSjZlY1bJ3tlTIJtJsnRVEpwYPO8bF9ZX
         giodreBA5Y6kd9L+peqjqAaxHRKKBPHIrTMEqj5/1zVehCA4H5ioBfnGCDoUjl1btvGI
         JJSJ5VgF+p49cEhlNOYrOoebp+TLtvBmv8rMIAvDfPLEKH8iJ4gBUk+BkE/JCwXSq42/
         t/oyEI5d6twFBpd+vHXXEusMArMv3k+DWtDse9duVqJ/nAclXbHwBvjmkeTMQd910xpN
         opeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750385784; x=1750990584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6VzlhRVh//x5/bp+2ihBVL31M01Rg7PAdE9X0/n0so=;
        b=DNtuj9rD9bK1OeYYjldYjBjvqqQBWIwz305Ie53RgHcKS4om/EWvFwq0uQRFAAQF4x
         0CCBhHS4foTGf7G7uZlsLFUhiuU3SC5vaDFYITBhpH71kpQHFlPXT4+dokwLMVj9bbNc
         U9Kppq4j6ySCtjtfxCwKqyigV1M3PjJd2Pwbm1usZpXN3yqyrXCfp8yLUNhQrdh/Ipov
         RUEJjyevf0mDYL6W3fAdI6UL9eOI3YE7mJJwRipkA6F3npWMFwscDkm4MWIzdUdeyxM7
         /ci5dUTw+BnHyUbz95LxXLKmnnjXEkBEubzCRb6DHOdOQ2CZGmTBExcLPkzjhg6yJOeB
         /iwg==
X-Forwarded-Encrypted: i=1; AJvYcCWVNeXT9Nc3CDwupuLF+2OI317u7nniDSNQFrNcEebvk8MY3MWAgSq4grz3uPqOhCSQIf4XOpA3lfHy@vger.kernel.org
X-Gm-Message-State: AOJu0Yzueebi2jQvQYsl3FYXNsSO+RUJPyoZJc8iYaKwk2p+3wBOwRKF
	cM1AzEFlYRQWLP8heJtewzewh3OKRn0mqsZepCMZPoz2RLBmvcf0Hg9MUsaUANLZZ1OwgYLTMPZ
	rD8a8MxQ3aUIx53gbZOpmhhFFvnCd682etIwTmpIDag==
X-Gm-Gg: ASbGncunGBE2Jr7h875iOAZg4G+DTvjmCV5hQbDT8L4VweS50IcMbYKSiQjmzFkn6XZ
	Wfs6h4tH4EvqxyP2IE/KTDlOLQg2peFMH4sdWvN9ea8iVB17sgOWpMlRi//ILZQZ3amwWmh/LJW
	Hbxk9vtYQ8Doto3QOa/qECaxquD1uU2FPtrSOqG9UbndXleQ==
X-Google-Smtp-Source: AGHT+IFMb9mI6JMrDwTDWGg+EBY6yLgAqHEKa1UTY7olo+luMJ+3DWC5EwQujeTUmlUkh6NOSS/MWljD6rFkZYVc5ek=
X-Received: by 2002:a05:6602:8303:b0:867:15a5:d16 with SMTP id
 ca18e2360f4ac-8762e7372bemr28998539f.8.1750385784285; Thu, 19 Jun 2025
 19:16:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604-v5_user_cfi_series-v17-0-4565c2cf869f@rivosinc.com>
 <20250604-v5_user_cfi_series-v17-15-4565c2cf869f@rivosinc.com> <CANXhq0pRXX_OMW2g2ui-k7Z_ZT+5a8Sra8oE28nBh5B9K2L5bQ@mail.gmail.com>
In-Reply-To: <CANXhq0pRXX_OMW2g2ui-k7Z_ZT+5a8Sra8oE28nBh5B9K2L5bQ@mail.gmail.com>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 20 Jun 2025 10:16:12 +0800
X-Gm-Features: AX0GCFudFSxSRELkYOW_7RRTcSiKTWMBH5CUlpZzl260C95QwRIsmCDm3_hQ72g
Message-ID: <CANXhq0p3MVLMsr_r0RWMti476pT0EMx61PQArjo2fUauTdpXaQ@mail.gmail.com>
Subject: Re: [PATCH v17 15/27] riscv/traps: Introduce software check exception
 and uprobe handling
To: Deepak Gupta <debug@rivosinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, Jann Horn <jannh@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com, 
	richard.henderson@linaro.org, jim.shu@sifive.com, andybnac@gmail.com, 
	kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com, 
	evan@rivosinc.com, cleger@rivosinc.com, alexghiti@rivosinc.com, 
	samitolvanen@google.com, broonie@kernel.org, rick.p.edgecombe@intel.com, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 3:31=E2=80=AFPM Zong Li <zong.li@sifive.com> wrote:
>
> On Thu, Jun 5, 2025 at 1:17=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> =
wrote:
> >
> > zicfiss / zicfilp introduces a new exception to priv isa `software chec=
k
> > exception` with cause code =3D 18. This patch implements software check
> > exception.
> >
> > Additionally it implements a cfi violation handler which checks for cod=
e
> > in xtval. If xtval=3D2, it means that sw check exception happened becau=
se of
> > an indirect branch not landing on 4 byte aligned PC or not landing on
> > `lpad` instruction or label value embedded in `lpad` not matching label
> > value setup in `x7`. If xtval=3D3, it means that sw check exception hap=
pened
> > because of mismatch between link register (x1 or x5) and top of shadow
> > stack (on execution of `sspopchk`).
> >
> > In case of cfi violation, SIGSEGV is raised with code=3DSEGV_CPERR.
> > SEGV_CPERR was introduced by x86 shadow stack patches.
> >
> > To keep uprobes working, handle the uprobe event first before reporting
> > the CFI violation in software-check exception handler. Because when the
> > landing pad is activated, if the uprobe point is set at the lpad
> > instruction at the beginning of a function, the system triggers a softw=
are
> > -check exception instead of an ebreak exception due to the exception
> > priority, then uprobe can't work successfully.
> >
> > Co-developed-by: Zong Li <zong.li@sifive.com>
> > Reviewed-by: Zong Li <zong.li@sifive.com>
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/asm-prototypes.h |  1 +
> >  arch/riscv/include/asm/entry-common.h   |  2 ++
> >  arch/riscv/kernel/entry.S               |  3 ++
> >  arch/riscv/kernel/traps.c               | 51 +++++++++++++++++++++++++=
++++++++
> >  4 files changed, 57 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/asm-prototypes.h b/arch/riscv/inclu=
de/asm/asm-prototypes.h
> > index cd627ec289f1..5a27cefd7805 100644
> > --- a/arch/riscv/include/asm/asm-prototypes.h
> > +++ b/arch/riscv/include/asm/asm-prototypes.h
> > @@ -51,6 +51,7 @@ DECLARE_DO_ERROR_INFO(do_trap_ecall_u);
> >  DECLARE_DO_ERROR_INFO(do_trap_ecall_s);
> >  DECLARE_DO_ERROR_INFO(do_trap_ecall_m);
> >  DECLARE_DO_ERROR_INFO(do_trap_break);
> > +DECLARE_DO_ERROR_INFO(do_trap_software_check);
> >
> >  asmlinkage void handle_bad_stack(struct pt_regs *regs);
> >  asmlinkage void do_page_fault(struct pt_regs *regs);
> > diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include=
/asm/entry-common.h
> > index b28ccc6cdeea..34ed149af5d1 100644
> > --- a/arch/riscv/include/asm/entry-common.h
> > +++ b/arch/riscv/include/asm/entry-common.h
> > @@ -40,4 +40,6 @@ static inline int handle_misaligned_store(struct pt_r=
egs *regs)
> >  }
> >  #endif
> >
> > +bool handle_user_cfi_violation(struct pt_regs *regs);
> > +
> >  #endif /* _ASM_RISCV_ENTRY_COMMON_H */
> > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > index 978115567bca..8d25837a9384 100644
> > --- a/arch/riscv/kernel/entry.S
> > +++ b/arch/riscv/kernel/entry.S
> > @@ -474,6 +474,9 @@ SYM_DATA_START_LOCAL(excp_vect_table)
> >         RISCV_PTR do_page_fault   /* load page fault */
> >         RISCV_PTR do_trap_unknown
> >         RISCV_PTR do_page_fault   /* store page fault */
> > +       RISCV_PTR do_trap_unknown /* cause=3D16 */
> > +       RISCV_PTR do_trap_unknown /* cause=3D17 */
> > +       RISCV_PTR do_trap_software_check /* cause=3D18 is sw check exce=
ption */
> >  SYM_DATA_END_LABEL(excp_vect_table, SYM_L_LOCAL, excp_vect_table_end)
> >
> >  #ifndef CONFIG_MMU
> > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> > index 8ff8e8b36524..64388370e1ad 100644
> > --- a/arch/riscv/kernel/traps.c
> > +++ b/arch/riscv/kernel/traps.c
> > @@ -354,6 +354,57 @@ void do_trap_ecall_u(struct pt_regs *regs)
> >
> >  }
> >
> > +#define CFI_TVAL_FCFI_CODE     2
> > +#define CFI_TVAL_BCFI_CODE     3
> > +/* handle cfi violations */
> > +bool handle_user_cfi_violation(struct pt_regs *regs)
> > +{
> > +       unsigned long tval =3D csr_read(CSR_TVAL);
> > +       bool is_fcfi =3D (tval =3D=3D CFI_TVAL_FCFI_CODE && cpu_support=
s_indirect_br_lp_instr());
> > +       bool is_bcfi =3D (tval =3D=3D CFI_TVAL_BCFI_CODE && cpu_support=
s_shadow_stack());
> > +
> > +       /*
> > +        * Handle uprobe event first. The probe point can be a valid ta=
rget
> > +        * of indirect jumps or calls, in this case, forward cfi violat=
ion
> > +        * will be triggered instead of breakpoint exception.
> > +        */
> > +       if (is_fcfi && probe_breakpoint_handler(regs))
> > +               return true;
>
> Hi  Deepak,
> Sorry for missing something earlier. I think we would like to clear
> sstatus.SPELP in the uprobe handling case. For example:
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index c2ea999c1167..e8492bb57e09 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -349,8 +349,10 @@ bool handle_user_cfi_violation(struct pt_regs *regs)
>         bool is_fcfi =3D (tval =3D=3D CFI_TVAL_FCFI_CODE &&
> cpu_supports_indirect_br_lp_instr());
>         bool is_bcfi =3D (tval =3D=3D CFI_TVAL_BCFI_CODE &&
> cpu_supports_shadow_stack());
>
> -       if (is_fcfi && probe_breakpoint_handler(regs))
> +       if (is_fcfi && probe_breakpoint_handler(regs)) {
> +               regs->status =3D regs->status & ~SR_ELP;
>                 return true;
> +       }
>
>         if (is_fcfi || is_bcfi) {
>                 do_trap_error(regs, SIGSEGV, SEGV_CPERR, regs->epc,
>
>
> When a user mode CFI violation occurs, the ELP state should be 1, and
> the system traps into supervisor mode. During this trap, sstatus.SPELP
> is set to 1, and the ELP state is reset to 0. If we don=E2=80=99t clear
> sstatus.SPELP, the ELP state will become 1 again after executing the
> sret instruction. As a result, the system might trigger another
> forward CFI violation upon executing the next instruction in the user
> program, unless it happens to be a lpad instruction.
>
> The previous patch was tested on QEMU, but QEMU does not set the
> sstatus.SPELP bit to 1 when a forward CFI violation occurs. Therefore,
> I suspect that QEMU might also require some fixes.

Hi Deepak,
The issue with QEMU was that the sw-check exception bit in medeleg
couldn't be set. This has been fixed in the latest QEMU mainline. I
have re-tested the latest QEMU version, and it works.

>
> Thanks
>
> > +
> > +       if (is_fcfi || is_bcfi) {
> > +               do_trap_error(regs, SIGSEGV, SEGV_CPERR, regs->epc,
> > +                             "Oops - control flow violation");
> > +               return true;
> > +       }
> > +
> > +       return false;
> > +}
> > +
> > +/*
> > + * software check exception is defined with risc-v cfi spec. Software =
check
> > + * exception is raised when:-
> > + * a) An indirect branch doesn't land on 4 byte aligned PC or `lpad`
> > + *    instruction or `label` value programmed in `lpad` instr doesn't
> > + *    match with value setup in `x7`. reported code in `xtval` is 2.
> > + * b) `sspopchk` instruction finds a mismatch between top of shadow st=
ack (ssp)
> > + *    and x1/x5. reported code in `xtval` is 3.
> > + */
> > +asmlinkage __visible __trap_section void do_trap_software_check(struct=
 pt_regs *regs)
> > +{
> > +       if (user_mode(regs)) {
> > +               irqentry_enter_from_user_mode(regs);
> > +
> > +               /* not a cfi violation, then merge into flow of unknown=
 trap handler */
> > +               if (!handle_user_cfi_violation(regs))
> > +                       do_trap_unknown(regs);
> > +
> > +               irqentry_exit_to_user_mode(regs);
> > +       } else {
> > +               /* sw check exception coming from kernel is a bug in ke=
rnel */
> > +               die(regs, "Kernel BUG");
> > +       }
> > +}
> > +
> >  #ifdef CONFIG_MMU
> >  asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
> >  {
> >
> > --
> > 2.43.0
> >

