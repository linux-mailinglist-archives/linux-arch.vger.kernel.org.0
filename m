Return-Path: <linux-arch+bounces-11005-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 594E5A6B129
	for <lists+linux-arch@lfdr.de>; Thu, 20 Mar 2025 23:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFC167AF239
	for <lists+linux-arch@lfdr.de>; Thu, 20 Mar 2025 22:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939D122AE65;
	Thu, 20 Mar 2025 22:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="VoOM3OEI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7800522A7E5
	for <linux-arch@vger.kernel.org>; Thu, 20 Mar 2025 22:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742510582; cv=none; b=mGjX63kU8JARLvWwMdRwKq/RE2XREXB5FK2fbOE3lJ0JfZ7CfuV4esJrjhextxMeNxShgonHEe4uElUB0a+uSgPgALPbTjA7cmxRnUqy5+kK5b6jJ73dx2u7JdRKjUlDqUWfSHaZ95+8KqANmk6gPdEOwbvzNLUGS4K6fPlNGI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742510582; c=relaxed/simple;
	bh=jHUyecYfqBSkuj/RyiebN9WzmLHzCNiNfUukvDXyi9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txTt3ebs+NlOACrRL5Bjatb1XexyRMO6Kv7akg8xXnySWFG889YJpVNKnTAE23UCNEel3slZaws5K1SLMeBTX8GPAe+RBvDGe0DbAedbOoqdHaF+i5fOfqDcxOtSZp8LvqTop61i4xg/NctZpeQ3j5WMWhF1tHgHRysEL9bGUxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=VoOM3OEI; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6f74b78df93so15658337b3.0
        for <linux-arch@vger.kernel.org>; Thu, 20 Mar 2025 15:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742510578; x=1743115378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qn+4G/BZfte1kQZajpdgC3z6H+wA6NVBYYf22eoImB8=;
        b=VoOM3OEIlvD+S6M3S0KQmAPSCcZez/wVYCZrtShBQa7ZLMuzjPOjNkbvdO7RILoAbc
         D1FRkGbtJ1Us224W+vCenCJHZJyKifdtRRQBJ2Z9K6Il8SIqiOQWZ/znECJKKNXALsVS
         TtRrUng1d6ZAj+NkDUav9LhvupLpk8VdX2UjzvTLkcoYav5uHKObhQHiOv2k/AYDQ2Dn
         4bnX6j+rhk2fDd1QvC1kLtqSUL6vCMmUZhVucILCxSWWMj1g4QjCOT9cMQdn3DjLKELe
         leYH56s3W8QGPzGxOu4z4jG9kDXCtRpZiJTlb427FuJ5htQGGRX+ZPvRfJqcCGGTPVe8
         bCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742510578; x=1743115378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qn+4G/BZfte1kQZajpdgC3z6H+wA6NVBYYf22eoImB8=;
        b=mpcwf1DEeRooZqi05uY6/YqOde8vJ6wfMMpvh0Dx5DYKpsGL9A0621OUecUfpJ28Na
         2j/W7tQknQ75QMDp3VWRGu3eQVjyymcwF903zQB2iIrfDtQ01+UUARp1mu/I+2jvGk3q
         DRndTPxTcBXuO3D4l2wFmPM2PVCHjR6oq8KA1eQij6gOVgEJhD/fJ+OvV53HOVuKY2yc
         4YpFcmrXT6NuRgTDT5TckU93XwqnveX1JV4vNlWvYKaJ/AsOPGlBbSmjYPqqnViTfwmQ
         1/mc5TpUN6KQ0sjnrkyIJwCqhAHVxA0raGbLIpDlqF9tJKV/QeqpMxca6ygFfyDATLRs
         jgWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXo4GMYYmjb1UbrCiafqD31qZSaCcWwy3/jDaa2k3hl2L5KZcAgLEbCS0a1MD59I2Qa4JU6hrbT5b/j@vger.kernel.org
X-Gm-Message-State: AOJu0YyHD3zX8lAQsV/ZeCecEehpwHqm4vmxdB2JdAnELyfYLxDnXW0Z
	0WM/WuUXIDXtEfbprimVz+SQy6i6UGz448xn7H2bPEVhh+TPrYQEBy+BU5qbl/X+OWQjsRnvltb
	oLfBI4RVHvdMpCmjWz0T8wNOqUAzNc2+jskQrxw==
X-Gm-Gg: ASbGncv3Bvo85Q9nXnZ39P9X5Txywls7WeyuKpaZy4kZmFm9GJvdjYArHO1ilkHqrU5
	B50tZ0q4qjDUGxz648qOxwoYBfVgND0MPjcqfiKZS+Gb2YZWy4flSgIgqDtVstQQO2YTO5iYA98
	ycaqgO6Lw/QJCZZnVc07gfC9so3EM=
X-Google-Smtp-Source: AGHT+IGmYWppAb1TiIqTjy/w+R69Tu+tZXikOvPPA4dXCqNye2klzCsCnnoPJTKEOwtSTNPJ9gWuo2HlZH9leRcscHA=
X-Received: by 2002:a05:690c:64c8:b0:6f4:8207:c68d with SMTP id
 00721157ae682-700babfd564mr17209397b3.3.1742510578457; Thu, 20 Mar 2025
 15:42:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-22-e51202b53138@rivosinc.com> <D8LFQYX4EHF8.2AJ01XL34WK0W@ventanamicro.com>
In-Reply-To: <D8LFQYX4EHF8.2AJ01XL34WK0W@ventanamicro.com>
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 20 Mar 2025 15:42:44 -0700
X-Gm-Features: AQ5f1Jo-nHEMu5qFdaTum9uSomYqo-G7mLCiMbL1c8nby8c7DsEke_Gukp9eNFU
Message-ID: <CAKC1njTyiaBkmHvAM8VT_MG4Cdch=H9P8r3C-m-=QQEuzyrRNA@mail.gmail.com>
Subject: Re: [PATCH v12 22/28] riscv: enable kernel access to shadow stack
 memory via FWFT sbi call
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
	Zong Li <zong.li@sifive.com>, linux-riscv <linux-riscv-bounces@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 3:10=E2=80=AFPM Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcma=
r@ventanamicro.com> wrote:
>
> 2025-03-14T14:39:41-07:00, Deepak Gupta <debug@rivosinc.com>:
> > Kernel will have to perform shadow stack operations on user shadow stac=
k.
> > Like during signal delivery and sigreturn, shadow stack token must be
> > created and validated respectively. Thus shadow stack access for kernel
> > must be enabled.
>
> Why can't kernel access the user shadow stack through an aliased WR
> mapping?

It can, although that opens up a can of worms. If this alternating
mapping is user mode
then ensuring that another threat in userspace can't write to this
address in this window
of signal handling. A kernel alternate mapping can be created, but
that can lead to all
sorts of requirements of ensuring the page is pinned down. IIRC, It
has been debated
on x86 shadow stack merge time as well on how a flaky alias mapping approac=
h can
become and weaken the threat model it is supposed to protect against.

Simply using `ssamoswap` is simple and serves the purpose. Enabling shadow =
stack
access for the kernel doesn't have any adverse effect on the kernel.

>
> > In future when kernel shadow stacks are enabled for linux kernel, it mu=
st
> > be enabled as early as possible for better coverage and prevent imbalan=
ce
> > between regular stack and shadow stack. After `relocate_enable_mmu` has
> > been done, this is as early as possible it can enabled.
> >
> > Reviewed-by: Zong Li <zong.li@sifive.com>
> > Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> > ---
> > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> > @@ -320,6 +326,12 @@ SYM_CODE_START(_start_kernel)
> >       la tp, init_task
> >       la sp, init_thread_union + THREAD_SIZE
> >       addi sp, sp, -PT_SIZE_ON_STACK
> > +     li a7, SBI_EXT_FWFT
> > +     li a6, SBI_EXT_FWFT_SET
> > +     li a0, SBI_FWFT_SHADOW_STACK
> > +     li a1, 1 /* enable supervisor to access shadow stack access */
> > +     li a2, SBI_FWFT_SET_FLAG_LOCK
> > +     ecall
>
> I think the ecall can fail even on machines that have Zicfiss, so it
> would be good to disable user shadow stack if that happens.

