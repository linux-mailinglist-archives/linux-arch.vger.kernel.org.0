Return-Path: <linux-arch+bounces-9291-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DCA9E79E0
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2024 21:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B686628337A
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2024 20:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A611CDFD4;
	Fri,  6 Dec 2024 20:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1oB/ZI0"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E95D1C5490;
	Fri,  6 Dec 2024 20:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515994; cv=none; b=IJRfdC8+hn2dkpKx8foKIfaJj0/ruaS4naC3/vRitlRurPrPhgRDwbLqA2whyhddp3I98zsflCY4LhooHURzh6f8smIuMww/YBQR07RHTzBlvAD32HTUuyO6Xvr2nR8qKwmIM1YhqGDSwCDxJSX1fZCRlDa1URKaRxoHEssagoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515994; c=relaxed/simple;
	bh=RAnkvM/BvCShbirWZQVBaFP+0SeE2bPdrROWZ73tLWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cbcB4y5lWLXahkhqJuGJt/DgvNWkaByOYF+dykuREE37LnH5MRY3zg2P6Tv04EP5XVHlOuHzNKeWK2HZ5DyKHaw/dpaRGr+Njf5b4YgSs8qQCcTHUuDNiHpY4xepP7SGYFecP+gBH8GR1jBp3swLPFQ8l6jPKAr4dIDZlmlW2Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1oB/ZI0; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30033e07ef3so8605641fa.0;
        Fri, 06 Dec 2024 12:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733515990; x=1734120790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ig8zvMrquNxr9h6es/FC4GH4Fy/YJCq5InLvynwUlIw=;
        b=m1oB/ZI0rU/y7vGbAGA9x6PgiETQSzUCdllkN4Cz4fTR79o+eB6xRc72OjUv49n70P
         My6cwETGnu4dfbIlcHbVFJJm7FAiYMUpPTAg2Z4yR8c80SjOagWNzbO5OizAClb9NjaS
         tUYGI+WhXIPLld80GBkIoOLJIy8eLWx0kjD5x+KI7gSMFbzS/ft3xA/87LQ89v6h0g/I
         B0Fu/FaA0Gv1TXga3dUbSH8P4OK2Sqbo2ec5ClEAO2HCyUELtmCu/MoNWuLmX9wQVy3A
         EhAH9gzjQkB5U/CpY98Sda2OYKjYr4eaht5NIdWEJWXKipbsiJBp4WFNJOhIic0gCNIj
         3vsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733515990; x=1734120790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ig8zvMrquNxr9h6es/FC4GH4Fy/YJCq5InLvynwUlIw=;
        b=xGE8X3kcYQvOtzIpGGZS0eBjt+wwuovJJRHtXWIE9L+btC/8Cbs+gdjBacD7JXFmbw
         h2IkNnmkDwJsrom85YCcLai9YdMhYOtxqFPnt5WqAgzhrkcHHVzmeT9VV2+72Z4lfbcI
         Rcu4WkHP9m/dsZkx6EPHFmsrv5vjrEpqeDIVP8np1A6tcqnustLZ+0HqOH5TcGVdf1g5
         t0T2rr9eB/Wli/FNx7PV6SBe69COmrCUH/mekp2z6z+1ktMO2UwumDHukydWSqVA3zhm
         Xk4u76JX411d/WNvWRFGsybZ9GLVq4fkvGPhGlVl/m1EDdunjTt4t6zHWdEMfu05u4tA
         rGUA==
X-Forwarded-Encrypted: i=1; AJvYcCVEZ+sa3HwDabIUMuWxj3a+ETeJTcJQzcxdFX/qBFBGCa2PH7RplgDhTkck1UO/lhlxVimffLB6@vger.kernel.org, AJvYcCWhdyjxL7R/+gEg+6fUfyY1wFftcZoGSUlh4yi4u2/BbLpeD/DJ4qr8ON1dysg54mvuIgBypLMxylILfQZ5@vger.kernel.org, AJvYcCWzD1INquHxnbfDS0CcSBrEyUhDQjJRjrEOnYox7ltUyGCFHswjnxpTGr77jDFbTCornHkP2AlEJQY2dJVek88=@vger.kernel.org, AJvYcCXmdFvgJaTcWdXEo5o5sxvNJsuybxwZCu5fn7vV3d8S//quE8TTuguu0amvFOtV5tqema1DouL6TnQq@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgmb8TVbqTbAbdYmVg2vkdMl8NekOHY2OFMl5sI0DpNGPukH7Y
	jZg9FLySkrgH5fwDL4v8p0mz51PvlOg5i2edYs7vxDK857aHUSTfU6xHoAPJkM7b0jtnhNrkVxP
	NVCVVAYSkIvTQ8P0x2+yIGPJOI3o=
X-Gm-Gg: ASbGncsfEKdIS1gSw7BQ4UgBirmOBIvHwLuhl5fH5b36rrDfYmbwkJEn40WKNtLP6Y+
	uojfUT0yasuU93T/130O5tYfwh/qUgqE=
X-Google-Smtp-Source: AGHT+IFIz0aMhmjz3POY4AtV1zcbOoDHMMbGiot4T8nIxNJKxQFlR1A64t6StVNw5SBiP8Mwz8JQRkkcRW8pMZUf+r4=
X-Received: by 2002:a2e:8058:0:b0:300:324e:34e2 with SMTP id
 38308e7fff4ca-300324e371fmr9329211fa.16.1733515989826; Fri, 06 Dec 2024
 12:13:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205154247.43444-1-ubizjak@gmail.com> <20241205154247.43444-6-ubizjak@gmail.com>
 <Z1KpWenJGqhjtNL9@V92F7Y9K0C.lan>
In-Reply-To: <Z1KpWenJGqhjtNL9@V92F7Y9K0C.lan>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 6 Dec 2024 21:13:03 +0100
Message-ID: <CAFULd4ardZ1GT0a9E_Bnu+8VAbxXTcFfvU7QrC14p+XbwdgC2A@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] percpu: Repurpose __percpu tag as a named address
 space qualifier
To: Dennis Zhou <dennis@kernel.org>
Cc: x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, linux-arch@vger.kernel.org, 
	netdev@vger.kernel.org, Nadav Amit <nadav.amit@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Brian Gerst <brgerst@gmail.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 8:35=E2=80=AFAM Dennis Zhou <dennis@kernel.org> wrot=
e:
>
> Hi Uros,
>
> On Thu, Dec 05, 2024 at 04:40:55PM +0100, Uros Bizjak wrote:
> > The patch introduces per_cpu_qual define and repurposes __percpu
> > tag as a named address space qualifier using the new define.
> >
> > Arches can now conditionally define __per_cpu_qual as their
> > named address space qualifier for percpu variables.
> >
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > Acked-by: Nadav Amit <nadav.amit@gmail.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Dennis Zhou <dennis@kernel.org>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Christoph Lameter <cl@linux.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Brian Gerst <brgerst@gmail.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > ---
> >  include/asm-generic/percpu.h   | 15 +++++++++++++++
> >  include/linux/compiler_types.h |  2 +-
> >  2 files changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.=
h
> > index 50597b975a49..3b93b168faa1 100644
> > --- a/include/asm-generic/percpu.h
> > +++ b/include/asm-generic/percpu.h
> > @@ -6,6 +6,21 @@
> >  #include <linux/threads.h>
> >  #include <linux/percpu-defs.h>
> >
> > +/*
> > + * per_cpu_qual is the qualifier for the percpu named address space.
> > + *
> > + * Most arches use generic named address space for percpu variables bu=
t
> > + * some arches define percpu variables in different named address spac=
e
> > + * (on the x86 arch, percpu variable may be declared as being relative
> > + * to the %fs or %gs segments using __seg_fs or __seg_gs named address
> > + * space qualifier).
> > + */
> > +#ifdef __per_cpu_qual
>
> I read through the series and I think my only nit would be here. Can we
> name this __percpu_qual? My thoughts are that it keeps it consistent
> with the old address space identifier and largely most of the core
> percpu stuff is defined with percpu as the naming scheme.

I based the approach on the definition of per_cpu_offset() a few lines
bellow in include/asm-generic/percpu.h:

--q--
#ifndef __per_cpu_offset
extern unsigned long __per_cpu_offset[NR_CPUS];

#define per_cpu_offset(x) (__per_cpu_offset[x])
#endif
--/q--

Sure, we can call this __percpu_qual. So, the definition in
arch/x86/include/asm/percpu.h would read as:

# define __percpu_qual      __percpu_seg_override

> > +# define per_cpu_qual __per_cpu_qual
> > +#else
> > +# define per_cpu_qual
> > +#endif

The above part could be recoded as:

#ifndef __percpu_qual
# define __percpu_qual
#endif

while the line below would become:

# define __percpu    __percpu_qual BTF_TYPE_TAG(percpu)

> > +
> >  #ifdef CONFIG_SMP
> >
> >  /*
> > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_ty=
pes.h
> > index 981cc3d7e3aa..877fe0c43c5d 100644
> > --- a/include/linux/compiler_types.h
> > +++ b/include/linux/compiler_types.h
> > @@ -57,7 +57,7 @@ static inline void __chk_io_ptr(const volatile void _=
_iomem *ptr) { }
> >  #  define __user     BTF_TYPE_TAG(user)
> >  # endif
> >  # define __iomem
> > -# define __percpu    BTF_TYPE_TAG(percpu)
> > +# define __percpu    per_cpu_qual BTF_TYPE_TAG(percpu)
> >  # define __rcu               BTF_TYPE_TAG(rcu)
> >
> >  # define __chk_user_ptr(x)   (void)0

Let me test these changes a bit, I'll send a v3 in a couple of days.

Thanks,
Uros.

