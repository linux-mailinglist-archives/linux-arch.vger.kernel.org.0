Return-Path: <linux-arch+bounces-9286-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E59DC9E6801
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2024 08:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A584C2835DA
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2024 07:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A76D1D7992;
	Fri,  6 Dec 2024 07:35:59 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86631B4F1F;
	Fri,  6 Dec 2024 07:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733470559; cv=none; b=jFv4RfDjV/FaePTI28LM2MNT6zpM4BRJMoiu+yiXZK1QD1GdIMYZaE3Sq+oQWSwXukNpZtWu4lQMotlyZxSJkEJB2g2jOYa2fTBZBUgJbvPAsAuw58JkdxKJgDbL30byAOAJNKym5JKlWhIxrye/SJSYyC2iKW/m87wEWQ092DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733470559; c=relaxed/simple;
	bh=GWVUSjQxAvUUmMLC8RroneMaixS408dLu1A7yPcAjoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9rrGkZJ8BZwEnsxVHrkdCrD/s8MqD4XLBb41gch/veQpDaLLVFyEwstxFiBD3qgyx3Zn9+gTWp4RDINJoVpL+6Dr9Ha5k+0hyYoJIvXrX844o+N2Rj3gO9pew24Zkmm1etoZcvOurLaQ+K6uuuNO+51WDm290sI/o11ej7kSrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-29e998c70f9so1211817fac.2;
        Thu, 05 Dec 2024 23:35:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733470557; x=1734075357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e04UQN4Bgq81Dxa3sAw+VWMHnoxLZmrzryZOBk+bxd8=;
        b=Ag/TrsDsvhZ6lqLQlJxZ4AMdRyMNKpx7D4S1dzdzA9rxtBKP9gh+Be/uKdRfb7btRe
         KEVwmghKJ6KR7oucOY0UMUiYrtW6eG47ZWSqkGPqJnNLTehH5dqxLxDfzsbeJd8SaEIv
         uMBJa8T1/E9aXbnQGxN0xUBe0zsqLroV6KGMBFQ/uU/FYwd9nIGn7kA/GPcxyb5wjKd4
         /D5gBW6qh4I1O3YaOaTtGLIA7TcEguWRQVfZ4Ko9YDlCLoHBsepYWnqo2ae5J4nM7JDM
         iGCFEIB/GwTwDF5uQHf6bYjXIXGqdNwM1CrH4DK8mpcsmF2FitsBfR2OfHiIjlTUSOm9
         nv7g==
X-Forwarded-Encrypted: i=1; AJvYcCUAM7HsEoyD2jQ1BviLcCy1J5eckh5hK81YCBLYBfzRjSzv1kz1HACqZeUbFEHbAMvEtE46jjMc1gs+8CoD@vger.kernel.org, AJvYcCUJHa9+fyW7M2eY30O6gW1F1j0qDkYtvqTM57DI0Emf+FPW4WQ1mJoBu6W3WbEw2kW6dZ11LOsG@vger.kernel.org, AJvYcCWjQkulUhH0pMj/26QyPxA/7oi+GzMrD+Qu0KGosPlArvlECCH1CDw/l8lKdmC7jMTJmldcgah2B7cyoo+8Azo=@vger.kernel.org, AJvYcCXSBC/PCEDcgux1oxtJLgDU/qK8CkP7A01zy+MDFlyOjZkIMMnycFYn9lCCo0gbX3XaeJRW55LUHfxm@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/If1Z5j7GFwV205kE6WRtSM2KNnpG3yjWiQbwkrikjPayBbWi
	EblRM6/y6/AOQt1HLBXehfEk1If+Lg25chLS8NUEL00ycGnJDnE0
X-Gm-Gg: ASbGncvwx+5im8U8Q4Bvno+dYiRoE/qnuiceQJbA+yALu7YNI9Bgk/uiPiVAP+94y3t
	w5C2tMqgeRhdTP+/XghoSZYWpWNb/L8iZuY8VCt9cMfXg/PI2WtzITNKvW5vszF4fQhOR6nyUtS
	DVSbzrMFBq8J/Jtx0kRuxJG64WJ4Jd3S2BdHQA+W4YJDmhdx220F8waAUL9afBJFBczWpz4pQZR
	rUcAaFzj3rRsRc75Mia+d2ekfPEoLbmAcJPNPrXLS7SLLTZmzZkWqhZA2C7
X-Google-Smtp-Source: AGHT+IEuZaAtLFt7J5lrqNm1axRoJWe4AUHjojGK9/xI3HOEczyiq8ngMxRqB/ki0aT6JOUV5jSY9A==
X-Received: by 2002:a05:6870:3b8e:b0:29e:247b:4f77 with SMTP id 586e51a60fabf-29f733405d8mr2472478fac.20.1733470556826;
        Thu, 05 Dec 2024 23:35:56 -0800 (PST)
Received: from V92F7Y9K0C.lan ([136.25.84.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156e1e20sm2442332a12.32.2024.12.05.23.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 23:35:56 -0800 (PST)
Date: Thu, 5 Dec 2024 23:35:53 -0800
From: Dennis Zhou <dennis@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, linux-arch@vger.kernel.org,
	netdev@vger.kernel.org, Nadav Amit <nadav.amit@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Brian Gerst <brgerst@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 5/6] percpu: Repurpose __percpu tag as a named address
 space qualifier
Message-ID: <Z1KpWenJGqhjtNL9@V92F7Y9K0C.lan>
References: <20241205154247.43444-1-ubizjak@gmail.com>
 <20241205154247.43444-6-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205154247.43444-6-ubizjak@gmail.com>

Hi Uros,

On Thu, Dec 05, 2024 at 04:40:55PM +0100, Uros Bizjak wrote:
> The patch introduces per_cpu_qual define and repurposes __percpu
> tag as a named address space qualifier using the new define.
> 
> Arches can now conditionally define __per_cpu_qual as their
> named address space qualifier for percpu variables.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Acked-by: Nadav Amit <nadav.amit@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dennis Zhou <dennis@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Brian Gerst <brgerst@gmail.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  include/asm-generic/percpu.h   | 15 +++++++++++++++
>  include/linux/compiler_types.h |  2 +-
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
> index 50597b975a49..3b93b168faa1 100644
> --- a/include/asm-generic/percpu.h
> +++ b/include/asm-generic/percpu.h
> @@ -6,6 +6,21 @@
>  #include <linux/threads.h>
>  #include <linux/percpu-defs.h>
>  
> +/*
> + * per_cpu_qual is the qualifier for the percpu named address space.
> + *
> + * Most arches use generic named address space for percpu variables but
> + * some arches define percpu variables in different named address space
> + * (on the x86 arch, percpu variable may be declared as being relative
> + * to the %fs or %gs segments using __seg_fs or __seg_gs named address
> + * space qualifier).
> + */
> +#ifdef __per_cpu_qual

I read through the series and I think my only nit would be here. Can we
name this __percpu_qual? My thoughts are that it keeps it consistent
with the old address space identifier and largely most of the core
percpu stuff is defined with percpu as the naming scheme.

> +# define per_cpu_qual __per_cpu_qual
> +#else
> +# define per_cpu_qual
> +#endif
> +
>  #ifdef CONFIG_SMP
>  
>  /*
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 981cc3d7e3aa..877fe0c43c5d 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -57,7 +57,7 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
>  #  define __user	BTF_TYPE_TAG(user)
>  # endif
>  # define __iomem
> -# define __percpu	BTF_TYPE_TAG(percpu)
> +# define __percpu	per_cpu_qual BTF_TYPE_TAG(percpu)
>  # define __rcu		BTF_TYPE_TAG(rcu)
>  
>  # define __chk_user_ptr(x)	(void)0
> -- 
> 2.42.0
> 

Thanks,
Dennis

