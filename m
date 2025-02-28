Return-Path: <linux-arch+bounces-10461-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F68CA48E27
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 02:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E282C16CA89
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 01:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC4C4502A;
	Fri, 28 Feb 2025 01:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHpSuR97"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F2B1805A;
	Fri, 28 Feb 2025 01:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740707351; cv=none; b=O3W5nAVCuNeiHpohcAJRxE+9ydmkhOR+QTv5c9Ez7kQ4WPU05JvP5YtmhApunbRDFSs6VZmQqEQtC2jtJKks1iNwhwQXrzqFQ4KT/aGrGT9pQu3jTYrXewBsOZiwX/fXdc0oCvOVjfvnVFKP+j+58t9tb1ipNFch5FXD6qipD4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740707351; c=relaxed/simple;
	bh=4f6/W//9xE9AdBnvNcLwO8IKzB0WtJQz8HWVX03MYe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOuo45yJXvcTY3dJuPk8NA/O7n0wNKnHgXC+PXoJ0Sx28JvcVU5hikJ8BFtgdrU8u8F79VzwcsFPxbLQM6sO75ZOZovMXmeFSJSxn6U0g9Fd44N7eC0bzELK6nIcKjDsHcCAC8YDtLjmZZ515FAnYt7wIxEr2h/UOZXpmaFKcME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHpSuR97; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c0970e2e79so287124485a.3;
        Thu, 27 Feb 2025 17:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740707348; x=1741312148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgnCFalO1rVu1AXO1D06Gc1GDBlEbCjjlOcT3fgeh38=;
        b=fHpSuR97+2z6lZqrh2LwH04+qrwKG7ZFHTnPqPxKJXd/RgUd70quGQ2hP9PbyM28iw
         s0yTqU1jiGC2oHeER5MGKUZGITKjJoXCnWXfcGrLQuLUhpHfGOxCRdA6WTaFOl8D7/L3
         RsenvzcAvqD9DGGGEL27j8vKk7nPbmdTSG15YG5ZQMdHboGQgPET2kxJGELrga+SwRcx
         NAm0NCRjRvl6C6gXFTtjxCGLASWnvHKmp9AKYiXffjRenlXXwIxUw+poI/it+0Y3XWx+
         fEJn7hSZLeK0ZSI0JfKyJf94dunntd320iWCWVs6JNCbRVJOgRXOblnzsJVZZRqhfZ4n
         5iOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740707348; x=1741312148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wgnCFalO1rVu1AXO1D06Gc1GDBlEbCjjlOcT3fgeh38=;
        b=qoL2b6nuCWlCxlAnCQ/8bAlTNGOORhlY7ujcQZWtNzGvkbpw+8fPYV+MCw2FToBpQN
         nrEnRn0B4Mb7n1cG2H4z8HMUBL38uaScmZ26Ji70AcGTJ9YbUxT309RMAlO1scSklV+e
         /kWVFK2xb1AyzUYgeCFRXinQnL38f+vKNKkFFCbCYC0aKNn3PPz//DDueT5/+lHjG8b+
         h+4xrsZHHGXPoRhvU1dtsOKBXOzTMPYXuKUdBJsSy/ouep9T0YqWxjNPO5yTOfmeqTPS
         TlX1AyHNS4HEn7BmbvIrRmmsDSyci9MyjMzlZb0VlTdxmqO11/IF12AS/sU8tR9fQaSS
         Kd7w==
X-Forwarded-Encrypted: i=1; AJvYcCUANmBqVna1oZftBHJvnyL0dsi9F0ydPJj0CmHfb9EoOU8FWoyoYc9CDwQGQ2OfH4PuuXPuhNu0Jd+fKddn@vger.kernel.org, AJvYcCUW8Apng9E1wjrW+HJRNVfvfMa+WIXs2IFiRlDcz/8FnRl/P+ZYc1l6shLehh2exod1zWhCy/Mst0fy6Q==@vger.kernel.org, AJvYcCW4z8TGGIT5RK93vBOfrn05Q6uqgfhmigmA/y4M6/rr0K78rpArxzxbJ3RAemHkGmNE1HPkzmWUjZUe@vger.kernel.org
X-Gm-Message-State: AOJu0YwBc9zRhAFzAq+Q6+o+q4DOiz57fnVQh6wXDQ4QoNG7IslBdDLO
	dMGFhgqyx0l/Y0GU8WoHfWR8zroe4tatpXYU+kESQFFMvu1wIekV
X-Gm-Gg: ASbGncv6VvX4Qrcy4nW6jqg8mXT7OfRgacpN/C3izrd7Bki9PIVSubHhpMW+pBKxTUb
	S7RFj64zEvuEztwQxY61BTumaHfUiFhip0MJJEEatziH4L9DrjXpv17Dc0TQoFUDBvgXHueO8St
	xWam1zXBm8h37iGHZLFgUw8z0u1rXIz+fU2C+YPhTM8JlxGyMeoH/LQuzsA2czvztLMeD/gohcP
	dlOx6Z/itl7IjYX0UOgbk1CG1mo+dz6xA+0XegtW9rsZvC1VyhdZeBmXTm4lvIBjKekFWnkbGVb
	11jprLFX8K/7IyHbzrGpF7XPRPbJ2NRMv36m/dVgSMpwfAerJOoBi6JGttVBoxXqh750sE3T3vV
	ZVScw21f2FJAea3Rq
X-Google-Smtp-Source: AGHT+IH+ANmJBVtGY4D/p2Ms1Ijf1z4GnsONbS648U41oA9SZ64R8X5gd2eiXYMgM3MQubjTaAh0dA==
X-Received: by 2002:a05:620a:410a:b0:7c0:b81f:7af1 with SMTP id af79cd13be357-7c39c4c7052mr216558685a.33.1740707348135;
        Thu, 27 Feb 2025 17:49:08 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c378d9fe2bsm180028885a.88.2025.02.27.17.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 17:49:07 -0800 (PST)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 295611200043;
	Thu, 27 Feb 2025 20:49:07 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 27 Feb 2025 20:49:07 -0500
X-ME-Sender: <xms:ExbBZ8MZMzLo6wrs94z19Qna9HA9xNeyrc4pBglvufiqyimFpFKkOg>
    <xme:ExbBZy9GoWore1KeXe5TixiJYQ5ERVzDbIuOZf2LLKyFkaxkqU0kK_nXAk4E9R8RE
    cweDv8FBWeYqoq3lg>
X-ME-Received: <xmr:ExbBZzR0bbi4DNLW6yJmTJhWoxmtNOEUZq42CBvJMgutc1Gz6WTWqp1tog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekledutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvfedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhihuhguvgesrhgvughhrghtrdgtohhmpd
    hrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtoh
    eptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtphhtthhopeifihhl
    lheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgtrgeslhhinhhugidrihgsmhdrtg
    homhdprhgtphhtthhopehgohhrsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtohep
    rghgohhruggvvghvsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtohepsghorhhnth
    hrrggvghgvrheslhhinhhugidrihgsmhdrtghomh
X-ME-Proxy: <xmx:ExbBZ0ue1Fk-rzeaa9ghPHz3tDImUCTQRhkKbVOvUiILSX2jgeNDTw>
    <xmx:ExbBZ0eMJnkPghCpEqFTDlnOM67LJC_6Mnc_0ibrAZzsceLutZRZxA>
    <xmx:ExbBZ40gzJsSPQXSLvJLsE6Zzc8WNwCuOHNca4oa5wTpTUoWQMA2eQ>
    <xmx:ExbBZ48bwnUBk7F59BtYYCPJSorDpmTbgh3D7Vcm33kxiIe9NRK6Yw>
    <xmx:ExbBZ78C7frC_qb8BNNJIcxUYMBbt7-KUtM0u9RUa1NHtz6cAFLQYJgy>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 20:49:06 -0500 (EST)
Date: Thu, 27 Feb 2025 17:49:05 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Juergen Christ <jchrist@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	"moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:S390 ARCHITECTURE" <linux-s390@vger.kernel.org>,
	"open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v9 2/9] preempt: Introduce __preempt_count_{sub,
 add}_return()
Message-ID: <Z8EWEe-zdPzKlOD8@Mac.home>
References: <20250227221924.265259-1-lyude@redhat.com>
 <20250227221924.265259-3-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227221924.265259-3-lyude@redhat.com>

On Thu, Feb 27, 2025 at 05:10:13PM -0500, Lyude Paul wrote:
> From: Boqun Feng <boqun.feng@gmail.com>
> 

Lyude, please add something similar to below as the changelog in the
future version.

In order to use preempt_count() to tracking the interrupt disable
nesting level, __preempt_count_{add,sub}_return() are introduced, as
their name suggest, these primitives return the new value of the
preempt_count() after changing it. The following example shows the usage
of it in local_interrupt_disable():

	// increase the HARDIRQ_DISABLE bit
	new_count = __preempt_count_add_return(HARDIRQ_DISABLE_OFFSET);

	// if it's the first-time increment, then disable the interrupt
	// at hardware level.
	if (new_count & HARDIRQ_DISABLE_MASK == HARDIRQ_DISABLE_OFFSET) {
		local_irq_save(flags);
		raw_cpu_write(local_interrupt_disable_state.flags, flags);
	}

Having these primitives will avoid a read of preempt_count() after
changing preempt_count() on certain architectures.


Regards,
Boqun

> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  arch/arm64/include/asm/preempt.h | 18 ++++++++++++++++++
>  arch/s390/include/asm/preempt.h  | 19 +++++++++++++++++++
>  arch/x86/include/asm/preempt.h   | 10 ++++++++++
>  include/asm-generic/preempt.h    | 14 ++++++++++++++
>  4 files changed, 61 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
> index 0159b625cc7f0..49cb886c8e1dd 100644
> --- a/arch/arm64/include/asm/preempt.h
> +++ b/arch/arm64/include/asm/preempt.h
> @@ -56,6 +56,24 @@ static inline void __preempt_count_sub(int val)
>  	WRITE_ONCE(current_thread_info()->preempt.count, pc);
>  }
>  
> +static inline int __preempt_count_add_return(int val)
> +{
> +	u32 pc = READ_ONCE(current_thread_info()->preempt.count);
> +	pc += val;
> +	WRITE_ONCE(current_thread_info()->preempt.count, pc);
> +
> +	return pc;
> +}
> +
> +static inline int __preempt_count_sub_return(int val)
> +{
> +	u32 pc = READ_ONCE(current_thread_info()->preempt.count);
> +	pc -= val;
> +	WRITE_ONCE(current_thread_info()->preempt.count, pc);
> +
> +	return pc;
> +}
> +
>  static inline bool __preempt_count_dec_and_test(void)
>  {
>  	struct thread_info *ti = current_thread_info();
> diff --git a/arch/s390/include/asm/preempt.h b/arch/s390/include/asm/preempt.h
> index 6ccd033acfe52..67a6e265e9fff 100644
> --- a/arch/s390/include/asm/preempt.h
> +++ b/arch/s390/include/asm/preempt.h
> @@ -98,6 +98,25 @@ static __always_inline bool should_resched(int preempt_offset)
>  	return unlikely(READ_ONCE(get_lowcore()->preempt_count) == preempt_offset);
>  }
>  
> +static __always_inline int __preempt_count_add_return(int val)
> +{
> +	/*
> +	 * With some obscure config options and CONFIG_PROFILE_ALL_BRANCHES
> +	 * enabled, gcc 12 fails to handle __builtin_constant_p().
> +	 */
> +	if (!IS_ENABLED(CONFIG_PROFILE_ALL_BRANCHES)) {
> +		if (__builtin_constant_p(val) && (val >= -128) && (val <= 127)) {
> +			return val + __atomic_add_const(val, &get_lowcore()->preempt_count);
> +		}
> +	}
> +	return val + __atomic_add(val, &get_lowcore()->preempt_count);
> +}
> +
> +static __always_inline int __preempt_count_sub_return(int val)
> +{
> +	return __preempt_count_add_return(-val);
> +}
> +
>  #define init_task_preempt_count(p)	do { } while (0)
>  /* Deferred to CPU bringup time */
>  #define init_idle_preempt_count(p, cpu)	do { } while (0)
> diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
> index 919909d8cb77e..405e60f4e1a77 100644
> --- a/arch/x86/include/asm/preempt.h
> +++ b/arch/x86/include/asm/preempt.h
> @@ -84,6 +84,16 @@ static __always_inline void __preempt_count_sub(int val)
>  	raw_cpu_add_4(pcpu_hot.preempt_count, -val);
>  }
>  
> +static __always_inline int __preempt_count_add_return(int val)
> +{
> +	return raw_cpu_add_return_4(pcpu_hot.preempt_count, val);
> +}
> +
> +static __always_inline int __preempt_count_sub_return(int val)
> +{
> +	return raw_cpu_add_return_4(pcpu_hot.preempt_count, -val);
> +}
> +
>  /*
>   * Because we keep PREEMPT_NEED_RESCHED set when we do _not_ need to reschedule
>   * a decrement which hits zero means we have no preempt_count and should
> diff --git a/include/asm-generic/preempt.h b/include/asm-generic/preempt.h
> index 51f8f3881523a..c8683c046615d 100644
> --- a/include/asm-generic/preempt.h
> +++ b/include/asm-generic/preempt.h
> @@ -59,6 +59,20 @@ static __always_inline void __preempt_count_sub(int val)
>  	*preempt_count_ptr() -= val;
>  }
>  
> +static __always_inline int __preempt_count_add_return(int val)
> +{
> +	*preempt_count_ptr() += val;
> +
> +	return *preempt_count_ptr();
> +}
> +
> +static __always_inline int __preempt_count_sub_return(int val)
> +{
> +	*preempt_count_ptr() -= val;
> +
> +	return *preempt_count_ptr();
> +}
> +
>  static __always_inline bool __preempt_count_dec_and_test(void)
>  {
>  	/*
> -- 
> 2.48.1
> 

