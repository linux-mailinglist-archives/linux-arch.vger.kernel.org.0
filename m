Return-Path: <linux-arch+bounces-12249-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E82DACF3F8
	for <lists+linux-arch@lfdr.de>; Thu,  5 Jun 2025 18:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD0C3A6607
	for <lists+linux-arch@lfdr.de>; Thu,  5 Jun 2025 16:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316221E25E3;
	Thu,  5 Jun 2025 16:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsWQZHnL"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCE51DC9BB;
	Thu,  5 Jun 2025 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749140255; cv=none; b=nsRhlSvOQBfj+0D2hyf/tpLhFekKwJAbx9iBiv8uFzmzC0BNAkHwS8cz9JZILpZxSR8LyNqFH81pPVj8mL5BHaxgu8VuBGnr1XcGvh1pp77d4883/0w8GUv0No72Uoyn/Tve9dcxrLCLH6duMPzz4Y8Yr/kPTxa9mC/OwHXsuIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749140255; c=relaxed/simple;
	bh=jiNQHaHwrEJnwf9xrdZ5xZApiTYZdF4xgyB3brVqBe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UK+kqZPYo9obGDPOl3PpypeFev/gXdhzWu+zumKmiJdv3KK58dI06NiUYrTa6lymN5ttV3MncUnvYR9eP1659+1qOsFgdM/jOuMd+MHz/qaBvUr+iAr6qhAQyAtiTYjHftHSGYQ1lnHxgTdAWmN2dVshCvc3sMiIEi6SnlmQvaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsWQZHnL; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-442fda876a6so9564345e9.0;
        Thu, 05 Jun 2025 09:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749140251; x=1749745051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dGbqrQdsgTzP3UjIz0kbTw/JkIIyQml15jcZJHvF5Y=;
        b=dsWQZHnLtzUjsZkcrrt2KLTTchmo+CZZiERCiy9e+xjW5PHXFiXBKdcQof0nVSYO/+
         yHzR20Wljvv7g736oZQiINnq+0vhFKu0vBONuOjuZDc6OQekY+iJebfJw6dPw3t1+2+h
         hV6c3ZD2F/icEgcADabC3JoJD7O04mhjO4iDn3aTL+xdQiiIYOo7bCWOy/dS3LZaqZHK
         46fpvI4vthZ7JGPUkkDKF7WVOHyVrtH97tzpkVQAeYrCKOMW9LjxAgzf2HpAD6X1ePPQ
         83xcIMfli2nMLn3dnSO933kXadrpEqbGlhmqWtnsv/W9FPA+youks3F4ZtlvD7HZTdf5
         hUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749140251; x=1749745051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dGbqrQdsgTzP3UjIz0kbTw/JkIIyQml15jcZJHvF5Y=;
        b=K7HMZAZZyKFEbkboQ0nYSbfydEr1ikn/i15AvLBRSalE0DvhCyS0IVPWQzclQu0tYV
         fKM76Ws44e4q8G6Xudmnt4jiDaWIFlrkVg9lCp8GhbSHeYObgaZdcoJxndRgWSbtq32u
         aWQC3ixGUsXpBJ+nOlYAqiXkN38lGLTXaQobhCBaQXq0pTCbt8xKm8o2c8eHU82sJUxr
         5HQJxOpfF06Ckr56an3nhEC05Ek3GwI9nk5xuDQWXyKdIxhNjaOtxa5vCb7ek6cp8zds
         QCsolO4vVUqialWk/4pdUnK3gZgI6NfdmQLq8zxyeHe6QcHN+q5tIma6tceVA42sSZAF
         +5yg==
X-Forwarded-Encrypted: i=1; AJvYcCUiyrp6vJLuutvPyfMJuo3vMSQH/6YJwJpXouglHeFnBy6h1fMihqWYHZEXpx+MpO1CsmCmjoaS3r4tOg==@vger.kernel.org, AJvYcCWgahJcgRMJm+2KaTeSsqMUwRyQkLWDzCTulXiTiYpiQb8zQLVsJapv2h/xEVwnRbvIXVUB8ijE@vger.kernel.org, AJvYcCWo6sD0P8A9nn93XS0GiF5/RaXb/rNcS3k8+Dp1r3xUbZOjCmK9U+EP5qD9AKZEA257BakYmjpVWafSwa5VM5A=@vger.kernel.org, AJvYcCWpQ7ePuhqsJH+3yrL4t1DUqaF7jeyjT2FZQtGpxIEl5o06JzaRSxx2Ro5HLRR3Aqy5pCE=@vger.kernel.org, AJvYcCX6Rugxcv6dU8fqEOLSWTu0WFuaYAd/xeU2KR86T3uESgwR0QpC2aI8xXeKS64IuRIzA1YjGiskYxR1SxH4@vger.kernel.org
X-Gm-Message-State: AOJu0YxYUmYyPXfQ76MQpDLApg/cC/Jaa1At6JZc+TmxIldH8D6MZtF/
	4V117mcaqfdvTa8hIR+CmNsNJcp81G883AEhLj356bF7gFqenq2b7Q+2X991il8YRQPT1RyGIdl
	Deo/e6UDdadWZjOMKXV0lIok4JTdSo+U=
X-Gm-Gg: ASbGnct7xX2GwRi3arf4iOQqHCwfo4J9WCl+1eTBMgElGIgtcRZ0W+tgfx0+y4kpl6h
	MBL902ZU7ohHILnZ5Q1bmM7MoDx51VW+6/6l3QoXL0xCzHodp4v9pjthcMh/9T2AE+dBkwVMTm7
	ZVRnKSuRNHsMkD8uK16t8iECv4PEFRmzXfAEisQ5z9bZVLXHeU
X-Google-Smtp-Source: AGHT+IHljy+LoIqRi4m59r5NW96Zx9RUujcAPzsJblEj/I1z4yadqfI1VE3DoTtvbIg5PXHzHL/unxbytcYK+wMwODQ=
X-Received: by 2002:a05:600c:6298:b0:43c:fe15:41cb with SMTP id
 5b1f17b1804b1-451f0ac62ddmr74940415e9.15.1749140251202; Thu, 05 Jun 2025
 09:17:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127160709.80604-1-ubizjak@gmail.com> <20250127160709.80604-7-ubizjak@gmail.com>
 <02c00acd-9518-4371-be2c-eb63e5d11d9c@kernel.org> <8ea2aefc-2847-433e-b56e-5caad49e54f2@kernel.org>
In-Reply-To: <8ea2aefc-2847-433e-b56e-5caad49e54f2@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Jun 2025 09:17:19 -0700
X-Gm-Features: AX0GCFvfio4DaSSiJPkWxk8FfTQS7aYWnm7rRe7RN7TCaeYNdx8m0LgRscw5pY4
Message-ID: <CAADnVQ+ukqmyNJ7eT8Z=2GY5cGAt38VJtzOjEbH_3aKCUC5qLg@mail.gmail.com>
Subject: Re: Large modules with 6.15 [was: [PATCH v4 6/6] percpu/x86: Enable
 strict percpu checks via named AS qualifiers]
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>, X86 ML <x86@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-bcachefs@vger.kernel.org, 
	linux-arch <linux-arch@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Nadav Amit <nadav.amit@gmail.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 7:32=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> wr=
ote:
>
> Cc BPF people, just so you know.
>
> On 05. 06. 25, 16:27, Jiri Slaby wrote:
> > On 27. 01. 25, 17:05, Uros Bizjak wrote:
> >> This patch declares percpu variables in __seg_gs/__seg_fs named AS
> >> and keeps them named AS qualified until they are dereferenced with
> >> percpu accessor. This approach enables various compiler check
> >> for cross-namespace variable assignments.
> >>
> >> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> >> Acked-by: Nadav Amit <nadav.amit@gmail.com>
> >> Cc: Dennis Zhou <dennis@kernel.org>
> >> Cc: Tejun Heo <tj@kernel.org>
> >> Cc: Christoph Lameter <cl@linux.com>
> >> Cc: Thomas Gleixner <tglx@linutronix.de>
> >> Cc: Ingo Molnar <mingo@kernel.org>
> >> Cc: Borislav Petkov <bp@alien8.de>
> >> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> >> Cc: "H. Peter Anvin" <hpa@zytor.com>
> >> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> >> Cc: Andy Lutomirski <luto@kernel.org>
> >> Cc: Brian Gerst <brgerst@gmail.com>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> ---
> >>   arch/x86/include/asm/percpu.h | 15 ++++++++++++---
> >>   1 file changed, 12 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/
> >> percpu.h
> >> index 27f668660abe..474d648bca9a 100644
> >> --- a/arch/x86/include/asm/percpu.h
> >> +++ b/arch/x86/include/asm/percpu.h
> >> @@ -95,9 +95,18 @@
> >>   #endif /* CONFIG_SMP */
> >> -#define __my_cpu_type(var)    typeof(var) __percpu_seg_override
> >> -#define __my_cpu_ptr(ptr)    (__my_cpu_type(*(ptr))*)(__force
> >> uintptr_t)(ptr)
> >> -#define __my_cpu_var(var)    (*__my_cpu_ptr(&(var)))
> >> +#if defined(CONFIG_USE_X86_SEG_SUPPORT) && defined(USE_TYPEOF_UNQUAL)
> >> +# define __my_cpu_type(var)    typeof(var)
> >> +# define __my_cpu_ptr(ptr)    (ptr)
> >> +# define __my_cpu_var(var)    (var)
> >> +
> >> +# define __percpu_qual        __percpu_seg_override
> >> +#else
> >> +# define __my_cpu_type(var)    typeof(var) __percpu_seg_override
> >> +# define __my_cpu_ptr(ptr)    (__my_cpu_type(*(ptr))*)(__force
> >> uintptr_t)(ptr)
> >> +# define __my_cpu_var(var)    (*__my_cpu_ptr(&(var)))
> >> +#endif
> >> +
> >
> > Another issue with this is this causes all modules in 6.15 are 2-4 time=
s
> > (compressed size) bigger:
> > $ ll /usr/lib/modules/*-[0-9]-default/kernel/drivers/atm/atmtcp.ko.zst
> >  > -rw-r--r--. 1 root root 10325 May 13 11:49 /usr/lib/modules/6.14.6-2=
-
> > default/kernel/drivers/atm/atmtcp.ko.zst
> >  > -rw-r--r--. 1 root root 39677 Jun  2 09:13 /usr/lib/modules/6.15.0-1=
-
> > default/kernel/drivers/atm/atmtcp.ko.zst
> >
> > It's due to larger .BTF section:
> > .BTF              PROGBITS         0000000000000000  [-00003080-]
> > [-       00000000000011a8-]  {+00003100+}
> > {+       0000000000012cf8+}  0000000000000000           0     0     1
> >
> > There are a lot of new BTF types defined in each module like:
> > +attribute_group STRUCT
> > +backing_dev_info STRUCT
> > +bdi_writeback STRUCT
> > +bin_attribute STRUCT
> > +bio_end_io_t TYPEDEF
> > +bio_list STRUCT
> > +bio_set STRUCT
> > +bio STRUCT
> > +bio_vec STRUCT
> >
> > Reverting this gives me back to normal sizes.
> >
> > Any ideas?

Try newer pahole ?
It was fixed by:
https://lore.kernel.org/bpf/20250429161042.2069678-1-alan.maguire@oracle.co=
m/

