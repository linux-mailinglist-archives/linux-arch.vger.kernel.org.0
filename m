Return-Path: <linux-arch+bounces-7796-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C21D9993E3F
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 07:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF374B236B8
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 05:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDEE139CEC;
	Tue,  8 Oct 2024 05:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lx6Wwt6p"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B9E3A1CD
	for <linux-arch@vger.kernel.org>; Tue,  8 Oct 2024 05:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728364591; cv=none; b=LwByc8pal3RlW6rRoAUEyd2UjELpGyOkAulZN3RI1Q7yldF/jbssDEW1+BDbXwhiQ01NE5W60lLU5zTSmL3Hgtt87QCxMqM+HtRXRRcw1Y+GoroOyACxXSSa41vhnM6XWt4u5NrG9qc5ojEMkXSPWxuPinfZJSwCGZcEz1MAgwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728364591; c=relaxed/simple;
	bh=J+sL/JH0w5uxfdfZLeo2CgWwLFTpOCgCJ9fT9v9s7sA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Egk16o/kFiAHIdLMnRxwf0dXVC35vzLRpzCr3qsSYHINSmZZc44n6QUP64isZtEYkOmQJm3lon7B4BROUxKb6MxNlZVfsI2huqn/BHjeoFWagENc6Tzui6sHDztS+wRD38GzJSfHC9hlLfU52FTVjeloVlmNo5vH1m3G02TvG0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=lx6Wwt6p; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-82cd872755dso238060039f.1
        for <linux-arch@vger.kernel.org>; Mon, 07 Oct 2024 22:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1728364589; x=1728969389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4w/TdKOPPfwgKMj85c6/te+TDmMrhbBdxi4k1LLIvc=;
        b=lx6Wwt6pfemKtg/RtsUkh6zDXx+AMz2u0XC29jh3q6XGNRXDJyCEhkRdOgYFcDPU61
         dn5uW6y9KwHovP3mgvRj5hzQFEeGkq5yruXm/xei0zfQDP4mdl50KJRLL0Bm5FvNYvtS
         9XLj30EwxrVfPGWLG1GU6+Hg5eu3rXJX7VFRHw8A5+8iMWithntSRSsM8op0l5wdQw8H
         K43UnN/dnkjJxgJgdutFmFW6zcsc9OplF9dUy/TKgk/d5/je/a2QFJKGDfF/hf/7aXL2
         dSBX913GuMhdeFvJ3um/fUKbVwq3sVok8iu2Go4mTHtEj9rTWXSpuJE0ViHCjC8nT23q
         HHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728364589; x=1728969389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4w/TdKOPPfwgKMj85c6/te+TDmMrhbBdxi4k1LLIvc=;
        b=G6Kf/pJmM7Hlok6RpfIKzuhpRZBv8Skx1azLJA4G233fle4Wr7u76Ydu4qhbtde7RO
         uelHemp4ZYMdnuHtEOZGkZUB9yx50omkEEyYZ5xmzRpf2AbdksOkS3vTjJjtuUZHg/Sp
         be/l9FA0n5cYqlcBvwcWgtOQhEzN19cbhOEPjRqdJAZ9uhR0b2gP2JPOXuKEjNR82uI7
         3uoUZrggix4vbrOI/sdICuJFRm51QsjKfj2Om8aZAc5sBZnWk3aKvNAUyigZWYqaJdHk
         9jCtnLDaalrBojkqgrHvM9IsGYHIvYgh61EIWCU9fsRbQ9dB0TaOsEo5PMZe1xNVvRpr
         96rw==
X-Forwarded-Encrypted: i=1; AJvYcCUEpPjtwdd46BclLtw1pJUb+/stjJWIRF0HeB8GCZ3pNEc/VEve7qa0m2ytblkC3DT5YGMH+uHhF/Bs@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8HJj7cbc6RB1t3XO1l8G0oL9CZF8PDgoET6b+D/07wdlAImSi
	sVjoQBagbNNeIKvn0iRnFXFrk89OI9HD54l7goeRTmSIKc35M5KUmx0T54iMQGArwjoo8A3gaz4
	0ePaHOGzdph//3caILwilt7gIoOc1cmE7tmxu7A==
X-Google-Smtp-Source: AGHT+IHj+3nyjDRUlzo6HU3+Ye4UA98AMbnjv3+zlmAvnKbqvLOrOys0YnN7vCUlZP6Nh+cnnTYFiH4anmDFOKj+zMw=
X-Received: by 2002:a05:6602:14c1:b0:82a:2143:8 with SMTP id
 ca18e2360f4ac-834f7d65974mr1658309439f.10.1728364589159; Mon, 07 Oct 2024
 22:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com>
 <20241001-v5_user_cfi_series-v1-16-3ba65b6e550f@rivosinc.com>
 <CANXhq0rpwQkZ9+mZLGVUq=r4WiA8BbZ-eeTDogf3fzeEPqeeqA@mail.gmail.com> <ZwRvAEwFbrpq3zZq@debug.ba.rivosinc.com>
In-Reply-To: <ZwRvAEwFbrpq3zZq@debug.ba.rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Tue, 8 Oct 2024 13:16:17 +0800
Message-ID: <CANXhq0qaokjDC9hb75_dpGuyOd_ex8+q7YNe8pAg7dbTcxuLSg@mail.gmail.com>
Subject: Re: [PATCH 16/33] riscv/shstk: If needed allocate a new shadow stack
 on clone
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
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com, 
	richard.henderson@linaro.org, jim.shu@sifive.com, andybnac@gmail.com, 
	kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com, 
	evan@rivosinc.com, cleger@rivosinc.com, alexghiti@rivosinc.com, 
	samitolvanen@google.com, broonie@kernel.org, rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 7:30=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> wr=
ote:
>
> On Mon, Oct 07, 2024 at 04:17:47PM +0800, Zong Li wrote:
> >On Wed, Oct 2, 2024 at 12:20=E2=80=AFAM Deepak Gupta <debug@rivosinc.com=
> wrote:
> >>
> >> Userspace specifies CLONE_VM to share address space and spawn new thre=
ad.
> >> `clone` allow userspace to specify a new stack for new thread. However
> >> there is no way to specify new shadow stack base address without chang=
ing
> >> API. This patch allocates a new shadow stack whenever CLONE_VM is give=
n.
> >>
> >> In case of CLONE_VFORK, parent is suspended until child finishes and t=
hus
> >> can child use parent shadow stack. In case of !CLONE_VM, COW kicks in
> >> because entire address space is copied from parent to child.
> >>
> >> `clone3` is extensible and can provide mechanisms using which shadow s=
tack
> >> as an input parameter can be provided. This is not settled yet and bei=
ng
> >> extensively discussed on mailing list. Once that's settled, this commi=
t
> >> will adapt to that.
> >>
> >> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> >> ---
> >>  arch/riscv/include/asm/usercfi.h |  25 ++++++++
>
> ... snipped...
>
> >> +
> >> +/*
> >> + * This gets called during clone/clone3/fork. And is needed to alloca=
te a shadow stack for
> >> + * cases where CLONE_VM is specified and thus a different stack is sp=
ecified by user. We
> >> + * thus need a separate shadow stack too. How does separate shadow st=
ack is specified by
> >> + * user is still being debated. Once that's settled, remove this part=
 of the comment.
> >> + * This function simply returns 0 if shadow stack are not supported o=
r if separate shadow
> >> + * stack allocation is not needed (like in case of !CLONE_VM)
> >> + */
> >> +unsigned long shstk_alloc_thread_stack(struct task_struct *tsk,
> >> +                                          const struct kernel_clone_a=
rgs *args)
> >> +{
> >> +       unsigned long addr, size;
> >> +
> >> +       /* If shadow stack is not supported, return 0 */
> >> +       if (!cpu_supports_shadow_stack())
> >> +               return 0;
> >> +
> >> +       /*
> >> +        * If shadow stack is not enabled on the new thread, skip any
> >> +        * switch to a new shadow stack.
> >> +        */
> >> +       if (is_shstk_enabled(tsk))
> >
> >Hi Deepak,
> >Should it be '!' is_shstk_enabled(tsk)?
>
> Yes it is a bug. It seems like fork without CLONE_VM or with CLONE_VFORK,=
 it was returning
> 0 anyways. And in the case of CLONE_VM (used by pthread), it was not doin=
g the right thing.

Hi Deepak,
I'd like to know if I understand correctly. Could I know whether there
might also be a risk when the user program doesn't enable the CFI and
the kernel doesn't activate CFI. Because this flow will still try to
allocate the shadow stack and execute the ssamowap command. Thanks

> Most of the testing has been with busybox build (independent binaries0 dr=
iven via buildroot
> setup. Wondering why it wasn't caught.
>
> Anyways, will fix it. Thanks for catching it.
>
> >
> >> +               return 0;
> >> +
> >> +       /*

