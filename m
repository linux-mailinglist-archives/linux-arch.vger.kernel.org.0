Return-Path: <linux-arch+bounces-11006-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF60A6B177
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 00:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACB8E18988A3
	for <lists+linux-arch@lfdr.de>; Thu, 20 Mar 2025 23:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D2222A4E1;
	Thu, 20 Mar 2025 23:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="D9N3LRzE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA4D2236E9
	for <linux-arch@vger.kernel.org>; Thu, 20 Mar 2025 23:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742512169; cv=none; b=jwZGsMJnowzSpRI3kAsiHj7tp4uqpTHO9bKc5nIVHgzXjaHcfWNgPrspSgRZ7yDdNsnfziCoSxEJn2ObVKiUfQzghtSk/ElVHTDJWydH2XfElPrNm6SAhciTrG5QNzXypOpphYUL007jJabhFAzGWnlziF+T/m1VaFRx21dEVPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742512169; c=relaxed/simple;
	bh=m3fIwQ9KL4fgaQ92P1LNTsIoLo1mURu7HsKB6VAksDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YO2N3HavSEFjk74WaC5jMk24amNmCZpqy2w6tyuJH1xnOXZe6+BVohqRlimzzJyFBzyqmcUovK1QdPs3xMMkLhRu8BCKfhaNaYPBoziuVxZzTh1R70po6qLTH/UtOXnBPifG5j4RjQsygGtI6Bb0AHm+KIb9oU5mnxow1ylrTYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=D9N3LRzE; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6fece18b3c8so12341167b3.3
        for <linux-arch@vger.kernel.org>; Thu, 20 Mar 2025 16:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742512166; x=1743116966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NsQLaUzZKjouDcBV/YPUh/MkwoWlaLe69i4Or3Hkjms=;
        b=D9N3LRzEwVwUGzERakDxMC1Z12UtJQpmpaeZL0v0HL23mPdVp9Dy/ClhM4kYxMIf2r
         pQ6/VSqYOQcAjbWaxXxv/iyhpVV1hvO9EumTCou5UITQ1ARPzg6SUYHR+iF+ONhkC52C
         yHNDMGQDmuYo9WMyYYD1D7wuRHAHytIE5jUNORDdQeIgAJMi1PcNe511MjC/FcAlBi5p
         Z6oAcvChIxIHhbzkmQLVP2E7Fqo4lju85tJIx69osgoBROfJCU5K1xql7eq2Zlgfyy3B
         yEDTh4G26QMDU2oEKL2DhvfGQf/CrsHoCf9o4SuLsGr+nU+aJNEJ1/xlqj1ZwrdXokN/
         519Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742512166; x=1743116966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NsQLaUzZKjouDcBV/YPUh/MkwoWlaLe69i4Or3Hkjms=;
        b=L++AsyED9N2j5wmydTIRhK8ipPWaqQVZGlOGW7BzKdttxiD67upWXL1kd7xfeuuCMa
         KESRqQjX1AnTwtK5LyJCd+IDNLLGohcQK5V//L2a544UfVPvq2oPsFUo9lMMauCJgdYm
         koaz4IPhSRUdGWLlcJgWYrBCX3d51Q0fkb6Xg+7Mh7nQI+kf91EIsuiNLt3TcjgMmKfH
         K0dyaWEr0R9zsjQnx3PLflktLnP2uPkqxlGFDshDdGXBFBMmou4wO0cfYiNTThYJUoFd
         7H6FDryu8J5SxyMcp2e779gbHB92mYDEaTIi/p4sL+YgywoV8AUr2TiNJIMkedYDIOH0
         6mHw==
X-Forwarded-Encrypted: i=1; AJvYcCWGYFcNODBs/FEXzRwxEaQDHEO2M0NZX0TpmxKgfBDisccJJDZOdfhHn1Xd1xC3arbncMyPKd7uhk/y@vger.kernel.org
X-Gm-Message-State: AOJu0YyBvEboK8v7nS8mBSgyQgPedTo2FJ7gR18Fof5sDtR6XJ+CdYmG
	G7l4hKOzWc7k1+UhIWfsH8Vxz3HiLz3DpmMJo2qBm2H148BuOBsmT7VcaT6lHTl2wafUVQFhL/U
	6zDm68VhXuk+TSZ9Hm2TMJBX6GPSJtKBmm5LI3Q==
X-Gm-Gg: ASbGncvCWfzu8RG6Ut1u/8VYRRMt9Kcm/uTVTYNIWvKzvFWT3TLDRFRb7wbIEZPP8c5
	vnYDHOvs1KbB0yLzWF14Uj9viUAnkF+rqGNCe8DB3n/+b740uupaSW/dellMpm8X91XG0eY2LcS
	s/pHSHt2i4+ZHVKeLaLNZPX+rlUs4728p2H4Wk2Q==
X-Google-Smtp-Source: AGHT+IFDRrLxIAnQM1sktWzlO7b7dXnBgFLapHyMV4vMjPpWfJaidUEdMv15+RgA77Z60kHjKJe06Yio1uLKOlCq2sA=
X-Received: by 2002:a05:690c:9a05:b0:6fb:277f:f022 with SMTP id
 00721157ae682-700bac63638mr18849517b3.15.1742512166144; Thu, 20 Mar 2025
 16:09:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-19-e51202b53138@rivosinc.com> <D8LG1TTBMPWX.3MKAEM8X1WYAX@ventanamicro.com>
In-Reply-To: <D8LG1TTBMPWX.3MKAEM8X1WYAX@ventanamicro.com>
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 20 Mar 2025 16:09:12 -0700
X-Gm-Features: AQ5f1JreP6HXwpJ5ynf6jYICgHmcVMtUgEM9ETC-KUSuZNcuhzZ0eOngfgfDvqY
Message-ID: <CAKC1njQ8P2mNiiev-NDyTJPjJ6AAVqrtHMcwt_sc5A7Z+3-Jrg@mail.gmail.com>
Subject: Re: [PATCH v12 19/28] riscv/ptrace: riscv cfi status and state via
 ptrace and in core files
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
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
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com, 
	richard.henderson@linaro.org, jim.shu@sifive.com, andybnac@gmail.com, 
	kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com, 
	evan@rivosinc.com, cleger@rivosinc.com, alexghiti@rivosinc.com, 
	samitolvanen@google.com, broonie@kernel.org, rick.p.edgecombe@intel.com, 
	linux-riscv <linux-riscv-bounces@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 3:24=E2=80=AFPM Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcma=
r@ventanamicro.com> wrote:
>
> 2025-03-14T14:39:38-07:00, Deepak Gupta <debug@rivosinc.com>:
> > Expose a new register type NT_RISCV_USER_CFI for risc-v cfi status and
> > state. Intentionally both landing pad and shadow stack status and state
> > are rolled into cfi state. Creating two different NT_RISCV_USER_XXX wou=
ld
> > not be useful and wastage of a note type. Enabling or disabling of feat=
ure
> > is not allowed via ptrace set interface. However setting `elp` state or
> > setting shadow stack pointer are allowed via ptrace set interface. It i=
s
> > expected `gdb` might have use to fixup `elp` state or `shadow stack`
> > pointer.
> >
> > Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> > ---
> >  arch/riscv/include/uapi/asm/ptrace.h | 18 ++++++++
> >  arch/riscv/kernel/ptrace.c           | 83 ++++++++++++++++++++++++++++=
++++++++
> >  include/uapi/linux/elf.h             |  1 +
> >  3 files changed, 102 insertions(+)
> >
> > diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/=
uapi/asm/ptrace.h
> > index 659ea3af5680..e6571fba8a8a 100644
> > --- a/arch/riscv/include/uapi/asm/ptrace.h
> > +++ b/arch/riscv/include/uapi/asm/ptrace.h
> > @@ -131,6 +131,24 @@ struct __sc_riscv_cfi_state {
> >       unsigned long ss_ptr;   /* shadow stack pointer */
> >  };
> >
> > +struct __cfi_status {
> > +     /* indirect branch tracking state */
> > +     __u64 lp_en : 1;
> > +     __u64 lp_lock : 1;
> > +     __u64 elp_state : 1;
> > +
> > +     /* shadow stack status */
> > +     __u64 shstk_en : 1;
> > +     __u64 shstk_lock : 1;
>
> I remember there was deep hatred towards bitfields in the Linux
> community, have things changes?

hmm. I didn't know about the strong hatred.
Although I can see lots of examples of this pattern in existing kernel code=
.
No strong feelings on my side, I can change this and have it single 64bit f=
ield
and accessed via bitmasks.

>
> > +     __u64 rsvd : sizeof(__u64) - 5;
>
> I think you meant "64 - 5".

eeh. bad bug. thanks.

>
> > +};
> > +
> > +struct user_cfi_state {
> > +     struct __cfi_status     cfi_status;
> > +     __u64 shstk_ptr;
> > +};
> > +
> >  #endif /* __ASSEMBLY__ */
> >
> >  #endif /* _UAPI_ASM_RISCV_PTRACE_H */
> > diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
> > @@ -224,6 +297,16 @@ static const struct user_regset riscv_user_regset[=
] =3D {
> >               .set =3D tagged_addr_ctrl_set,
> >       },
> >  #endif
> > +#ifdef CONFIG_RISCV_USER_CFI
> > +     [REGSET_CFI] =3D {
> > +             .core_note_type =3D NT_RISCV_USER_CFI,
> > +             .align =3D sizeof(__u64),
> > +             .n =3D sizeof(struct user_cfi_state) / sizeof(__u64),
> > +             .size =3D sizeof(__u64),
>
> Why not `size =3D sizeof(struct user_cfi_state)` and `n =3D 1`?

yeah another good catch.
Should write a kselftest against it, so that it can be caught.

>
> > +             .regset_get =3D riscv_cfi_get,
> > +             .set =3D riscv_cfi_set,
> > +     },
> > +#endif
>
> [I haven't yet reviewed if a new register is the right thing to do nor
>  looked at the rest of the patch.]

