Return-Path: <linux-arch+bounces-12791-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A73B06899
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 23:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C93188A1D8
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 21:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2BC2C158C;
	Tue, 15 Jul 2025 21:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="12f7H4tG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08E02C08A0
	for <linux-arch@vger.kernel.org>; Tue, 15 Jul 2025 21:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752615242; cv=none; b=Ivur8Aq+klAmTgCzwg9fr08j6o1MCN1yGlJBri//cMYacLHvMSokg8ZLPcflbuouk2WaP5tYD8pOzeYShZ74V4Yzc2S3Ev3SG9SeiqB8RUQjZQni+pSN9vEisj0q3O/ME4G02aGfz8abm6amC0L8+Nb7QSff8VR3738IT4DAXzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752615242; c=relaxed/simple;
	bh=RQkuw+2OLc9J+WTcYerziGNr+/GSLP5a3H8wgWR3l6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6QV/5+3W+w1nRD8uR+/FyppTLM261sfyt2syY6e16AyJGqUjl0n+mp43p62I3cXuF49ryItYGHiNdCl4+PJ7UxUTXD75L2MZxgFHhklkNr0/Nigr3wD8dbmNiZX0X9NPLJz+gv+x4BsJJHLg+wEhP9KyoUhpXlHdVY221TlGjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=12f7H4tG; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e8986a25cbfso4255377276.0
        for <linux-arch@vger.kernel.org>; Tue, 15 Jul 2025 14:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1752615239; x=1753220039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrtJ2tPWtnyQlcXjVKipZJ0PUZK8lOTycW08ecfRLFU=;
        b=12f7H4tGvMszfB6P6/AublkfuAt3VdHmU33W2Q1NwvPnzvsVRlneb8HIbrXmuhCUKh
         RPnG1jrkmzaEf5edsrP/5v/xDIXT1I0XiyIYzRsGf+AzEKD4dYOep0mhroeRubv7yNmc
         TJys8HwQY4hfcPEMpdnNkjXzvfxZI9tEsb2kKTdiZdRDCFupeVXO7xqCG15IXzMQLfuk
         rHZYc9/ZNAqlp0i7E2A3xZ+jXesHlIhexpXDad5N4T8GOcRI0lWMs2r+gNyHDiW+6PBR
         FG2Rg5lKYou1oNaqgUjphMDdztOsbofJmhIkwhOJmRviJ6CYgRvasJcakzsd85EkYA4c
         huog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752615239; x=1753220039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrtJ2tPWtnyQlcXjVKipZJ0PUZK8lOTycW08ecfRLFU=;
        b=EIFtVy5dOYcSRL3AIIP+59meTzZ6XYZAkx2pH1fCesxvKexf7I23lrjCa3el3B3VJB
         r+dGdhreq/q5xLF8JffDArmE42Xok8Ry6a2ui2qxhFh9aJC1gixmlFK+UotSGg+Z9rmR
         Hem/LQ2oPjafPeaYpSQRiA2Z7IH71Y2z3v/Q2JBuyxAN5qX/lIAk0GroC5P7+i+Hrkhr
         A9x1LE/FcLOH23JalAsBJs+JQtuaVLIH4FwCyFgd23k4n6OnYsGWL1AL1/JgS7r/vkxL
         7CgdQjL2GMTMpnoIUJS5riqjDptF11EuLyGv7PD/vipGblOE6NbACAjUxLP5fLuH2V1y
         plFA==
X-Forwarded-Encrypted: i=1; AJvYcCXKLjVrfegSLoMMtJ/r/hysx8HMJeb+JTdmnqQZkCCQK8DEoRLdJS+xHkncPUShXLWISX0lndLgdhnU@vger.kernel.org
X-Gm-Message-State: AOJu0YyEnwYLcRWtGlTakL7rb6f/zH8YHt8WMiLfzmSskZtqdkKKUVWL
	Ktw397ar0TMfnr1INDEyOCNk6nc6+rFzW46tY+nzUtooEnmRV/M4EatBTGL+rGZws/xbZW8t2dL
	oWgQnIkFsuYSMdNcFfIraaSEI0T30/szKJoSdfH1a6A==
X-Gm-Gg: ASbGncvADmQffPBkn1wGSPquaFX8MdJD13Atsd6Rc5vdrc9ogc2WZrXyBsU8B1x+kDy
	ugPKRa9sjLtBIk7ZyrNKNblUe1L1jVc6e4YRQlbYggZ9SD4xsLVcxkzR7T7Pi4J3Zz/jcXPpJaP
	F16xPWSPY6kzFC/RfFFOmyjVzNQsc+pO3Ul3iJ7ohcWbCxUnOIJ4eCcN2sJvN7SunI68E+3DnaG
	VR+xZtd
X-Google-Smtp-Source: AGHT+IEsY/f+Tj3u2hxiQCd69XmHGIDqZZR/UYSpflr/g5ySMTGOn/8ny5hxzQ44lrvSZqgfPjGQAPQXva81ZPiNP2c=
X-Received: by 2002:a05:690c:4884:b0:70f:9fcd:2075 with SMTP id
 00721157ae682-71836c27373mr5257327b3.3.1752615239506; Tue, 15 Jul 2025
 14:33:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604-v5_user_cfi_series-v17-0-4565c2cf869f@rivosinc.com>
 <20250604-v5_user_cfi_series-v17-15-4565c2cf869f@rivosinc.com>
 <CANXhq0pRXX_OMW2g2ui-k7Z_ZT+5a8Sra8oE28nBh5B9K2L5bQ@mail.gmail.com> <CANXhq0p3MVLMsr_r0RWMti476pT0EMx61PQArjo2fUauTdpXaQ@mail.gmail.com>
In-Reply-To: <CANXhq0p3MVLMsr_r0RWMti476pT0EMx61PQArjo2fUauTdpXaQ@mail.gmail.com>
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 15 Jul 2025 14:33:47 -0700
X-Gm-Features: Ac12FXzRTF7Dfs5zrF9r6Tx3chJ4aSIUc73QZXj0R8v3aOAPdwPOPGlfEeN5Jbw
Message-ID: <CAKC1njRNkSfb_0pUQoH0RwJQhWTsz9sdg_3o08w-NuSO5WypcA@mail.gmail.com>
Subject: Re: [PATCH v17 15/27] riscv/traps: Introduce software check exception
 and uprobe handling
To: Zong Li <zong.li@sifive.com>
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

Hi Zong,


On Thu, Jun 19, 2025 at 7:16=E2=80=AFPM Zong Li <zong.li@sifive.com> wrote:
>
> On Mon, Jun 16, 2025 at 3:31=E2=80=AFPM Zong Li <zong.li@sifive.com> wrot=
e:
> >
> > On Thu, Jun 5, 2025 at 1:17=E2=80=AFAM Deepak Gupta <debug@rivosinc.com=
> wrote:
> > >
> > > zicfiss / zicfilp introduces a new exception to priv isa `software ch=
eck
> > > exception` with cause code =3D 18. This patch implements software che=
ck
> > > exception.
> > >
.....

> > When a user mode CFI violation occurs, the ELP state should be 1, and
> > the system traps into supervisor mode. During this trap, sstatus.SPELP
> > is set to 1, and the ELP state is reset to 0. If we don=E2=80=99t clear
> > sstatus.SPELP, the ELP state will become 1 again after executing the
> > sret instruction. As a result, the system might trigger another
> > forward CFI violation upon executing the next instruction in the user
> > program, unless it happens to be a lpad instruction.
> >
> > The previous patch was tested on QEMU, but QEMU does not set the
> > sstatus.SPELP bit to 1 when a forward CFI violation occurs. Therefore,
> > I suspect that QEMU might also require some fixes.
>
> Hi Deepak,
> The issue with QEMU was that the sw-check exception bit in medeleg
> couldn't be set. This has been fixed in the latest QEMU mainline. I
> have re-tested the latest QEMU version, and it works.

What was this issue, can you point me to the patch in mainline?

>
> >
> > Thanks
> >
> > > +
> > > +       if (is_fcfi || is_bcfi) {
> > > +               do_trap_error(regs, SIGSEGV, SEGV_CPERR, regs->epc,
> > > +                             "Oops - control flow violation");
> > > +               return true;
> > > +       }
> > > +
> > > +       return false;
> > > +}
> > > +
> > > +/*
> > > + * software check exception is defined with risc-v cfi spec. Softwar=
e check
> > > + * exception is raised when:-
> > > + * a) An indirect branch doesn't land on 4 byte aligned PC or `lpad`
> > > + *    instruction or `label` value programmed in `lpad` instr doesn'=
t
> > > + *    match with value setup in `x7`. reported code in `xtval` is 2.
> > > + * b) `sspopchk` instruction finds a mismatch between top of shadow =
stack (ssp)
> > > + *    and x1/x5. reported code in `xtval` is 3.
> > > + */
> > > +asmlinkage __visible __trap_section void do_trap_software_check(stru=
ct pt_regs *regs)
> > > +{
> > > +       if (user_mode(regs)) {
> > > +               irqentry_enter_from_user_mode(regs);
> > > +
> > > +               /* not a cfi violation, then merge into flow of unkno=
wn trap handler */
> > > +               if (!handle_user_cfi_violation(regs))
> > > +                       do_trap_unknown(regs);
> > > +
> > > +               irqentry_exit_to_user_mode(regs);
> > > +       } else {
> > > +               /* sw check exception coming from kernel is a bug in =
kernel */
> > > +               die(regs, "Kernel BUG");
> > > +       }
> > > +}
> > > +
> > >  #ifdef CONFIG_MMU
> > >  asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs=
)
> > >  {
> > >
> > > --
> > > 2.43.0
> > >

