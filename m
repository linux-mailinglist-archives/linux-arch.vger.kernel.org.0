Return-Path: <linux-arch+bounces-5763-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3171F942B57
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 11:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8E5285CD7
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 09:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3DF1AAE0E;
	Wed, 31 Jul 2024 09:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="W0ctBFs8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CB51A8C12
	for <linux-arch@vger.kernel.org>; Wed, 31 Jul 2024 09:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722419948; cv=none; b=ADFCpMN2f65uH3GVEDRU5yCbpFBx6XLYiemYwP6+iQBKtFEHEflvChBqVEOdW7HpNj6hQvqGE6Q8qVaCKlcSJn/LPak0LK9DBBnXKO5ttltyJJVCaGZII/4fBl9Hrd5UsAkpecbUEk6lcn3AGtZDQATeorL128cLk8pjx1Vn064=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722419948; c=relaxed/simple;
	bh=wTVQfpXR1XuPyTPgw7aCES0qm8DAblDVWLz4UjOeLo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRQwuestPSqF3hO2b6jOmApj9uMzVsoWWWOnUoZh/s6GM1V5+A5sok9SSxF/lxBFh9SEjl9K8CaFZ7mTTiDTv2PpLfBS8BemH+kSOEkISeZ13XbQ+l5tWYyNYCYA0ML78n9PYkSw+Kl4Ja5q0CS58Ao2zl9TLsmAXoqGagaioxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=W0ctBFs8; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-369f68f63b1so2581729f8f.2
        for <linux-arch@vger.kernel.org>; Wed, 31 Jul 2024 02:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1722419944; x=1723024744; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DZL9zyo8+QIZP9qYtmF0cSugcmoTJ8zS+zVFfXlZuPA=;
        b=W0ctBFs8kq26P8fUDQKS5n3ggW6hOMU0zCQ2noljG1twi9ETAzXRSTRMRU0bUVQhKH
         z3LMzel6S6spB7nqSz2P6a/+0v2XMSTV6kSUAbYd7EtH3EaChpRnyKUK5BVqgSZdx41y
         c9lbv480C8Yk6NsJyoTYBQF0xkOpLOpqtGMoY8h8szrZfWAqxGZpjyyGfj5kURW+p64I
         MN3S2OXOhR6LxRjBbI1PiXper/1+31wWaHX1ujOAVDN1gn/1FYG23hnFwsYYbPfy5Exx
         lPr7i0yfmKS34E2NeEAfTFQiawzpzpgO2nneYnz1oFNX3e/6cUq9xPLB8gRS7e9zWLCm
         Z4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722419944; x=1723024744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZL9zyo8+QIZP9qYtmF0cSugcmoTJ8zS+zVFfXlZuPA=;
        b=Ysb0nV4LVvzCgAgsPs93cVl+EdyhZmyokg6FLzLo/y7jeC6Mru3n4+QuTT6L3afWC/
         jee55iwOKyta6LYwrjrsVW8bazhR+/VerozWBjNu95bBnPoZxBgKQpQNA96tJmv54GAl
         MTs2uHXpCcFSBSVShN5oFTrbkXBsUXUHoO4O9z/8fMlAwx4HWHOWzYZtZDBxoUEqp63e
         bHC/hH+3vcE8Zz4341IbJKNqwiD3rOLr0bstbGZlg+VidsyDKWbYzk9Y4k++U4ZpBczt
         PziECa4iDUcDAO8aURR8rOcMc9ELM+REyuU8AWqFEKYzLfCsvuqG4dbF6O9i66Zt+4ww
         ghHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr8QfFSgO2qEWzmgEqSMJnJRGl1568MZLd3I2am+aqdVpGruYsZXV+sDtNBBg15ETen8ByeHmEBsU1r2kTjIwnW76LPOitAlpIAQ==
X-Gm-Message-State: AOJu0YzqGL9Qnzb+5XCICjTkvaoA38+p79RvHLP8Nx+8IMF6dz4IpwUa
	IxHqYqI6Z1vdU9m+Z8nfXfdmbfr6/f3Qs/rwa+OUcRHR6nx8aDx31ODwIzpRFH8=
X-Google-Smtp-Source: AGHT+IGj2vgkkOoloE2p739Ji1R+yoNVMoR4esedc6MTJxKkDNqXruJjeVInsrb0lGpkMUOuVeEVSA==
X-Received: by 2002:a5d:59a6:0:b0:368:71bc:2b08 with SMTP id ffacd0b85a97d-36b5cee3038mr10692404f8f.3.1722419943456;
        Wed, 31 Jul 2024 02:59:03 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36861b70sm16532045f8f.102.2024.07.31.02.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 02:59:03 -0700 (PDT)
Date: Wed, 31 Jul 2024 11:59:02 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org, Andrea Parri <andrea@rivosinc.com>
Subject: Re: [PATCH v4 06/13] riscv: Improve zacas fully-ordered cmpxchg()
Message-ID: <20240731-260cce60e1a6cd06670d1b24@orel>
References: <20240731072405.197046-1-alexghiti@rivosinc.com>
 <20240731072405.197046-7-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731072405.197046-7-alexghiti@rivosinc.com>

On Wed, Jul 31, 2024 at 09:23:58AM GMT, Alexandre Ghiti wrote:
> The current fully-ordered cmpxchgXX() implementation results in:
> 
>   amocas.X.rl     a5,a4,(s1)
>   fence           rw,rw
> 
> This provides enough sync but we can actually use the following better
> mapping instead:
> 
>   amocas.X.aqrl   a5,a4,(s1)

We won't get release semantics if the exchange fails. Does that matter?

> 
> Suggested-by: Andrea Parri <andrea@rivosinc.com>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/cmpxchg.h | 72 +++++++++++++++++++-------------
>  1 file changed, 44 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> index ebcd4a30ae60..391730367213 100644
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -107,8 +107,10 @@
>   * store NEW in MEM.  Return the initial value in MEM.  Success is
>   * indicated by comparing RETURN with OLD.
>   */
> -
> -#define __arch_cmpxchg_masked(sc_sfx, cas_sfx, prepend, append, r, p, o, n)	\
> +#define __arch_cmpxchg_masked(sc_sfx, cas_sfx,					\
> +			      sc_prepend, sc_append,				\
> +			      cas_prepend, cas_append,				\
> +			      r, p, o, n)					\
>  ({										\
>  	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) &&				\
>  	    IS_ENABLED(CONFIG_RISCV_ISA_ZACAS) &&				\
> @@ -117,9 +119,9 @@
>  		r = o;								\
>  										\
>  		__asm__ __volatile__ (						\
> -			prepend							\
> +			cas_prepend							\
>  			"	amocas" cas_sfx " %0, %z2, %1\n"		\
> -			append							\
> +			cas_append							\
>  			: "+&r" (r), "+A" (*(p))				\
>  			: "rJ" (n)						\
>  			: "memory");						\
> @@ -134,7 +136,7 @@
>  		ulong __rc;							\
>  										\
>  		__asm__ __volatile__ (						\
> -			prepend							\
> +			sc_prepend							\
>  			"0:	lr.w %0, %2\n"					\
>  			"	and  %1, %0, %z5\n"				\
>  			"	bne  %1, %z3, 1f\n"				\
> @@ -142,7 +144,7 @@
>  			"	or   %1, %1, %z4\n"				\
>  			"	sc.w" sc_sfx " %1, %1, %2\n"			\
>  			"	bnez %1, 0b\n"					\
> -			append							\
> +			sc_append							\
>  			"1:\n"							\
>  			: "=&r" (__retx), "=&r" (__rc), "+A" (*(__ptr32b))	\
>  			: "rJ" ((long)__oldx), "rJ" (__newx),			\
> @@ -153,16 +155,19 @@
>  	}									\
>  })
>  
> -#define __arch_cmpxchg(lr_sfx, sc_cas_sfx, prepend, append, r, p, co, o, n)	\
> +#define __arch_cmpxchg(lr_sfx, sc_sfx, cas_sfx,				\
> +		       sc_prepend, sc_append,				\
> +		       cas_prepend, cas_append,				\
> +		       r, p, co, o, n)					\
>  ({									\
>  	if (IS_ENABLED(CONFIG_RISCV_ISA_ZACAS) &&			\
>  	    riscv_has_extension_unlikely(RISCV_ISA_EXT_ZACAS)) {	\
>  		r = o;							\
>  									\
>  		__asm__ __volatile__ (					\
> -			prepend						\
> -			"	amocas" sc_cas_sfx " %0, %z2, %1\n"	\
> -			append						\
> +			cas_prepend					\
> +			"	amocas" cas_sfx " %0, %z2, %1\n"	\
> +			cas_append					\
>  			: "+&r" (r), "+A" (*(p))			\
>  			: "rJ" (n)					\
>  			: "memory");					\
> @@ -170,12 +175,12 @@
>  		register unsigned int __rc;				\
>  									\
>  		__asm__ __volatile__ (					\
> -			prepend						\
> +			sc_prepend					\
>  			"0:	lr" lr_sfx " %0, %2\n"			\
>  			"	bne  %0, %z3, 1f\n"			\
> -			"	sc" sc_cas_sfx " %1, %z4, %2\n"		\
> +			"	sc" sc_sfx " %1, %z4, %2\n"		\

nit: If patch3 hadn't renamed sc_sfx to sc_cas_sfx then we wouldn't
need to rename it again now.

>  			"	bnez %1, 0b\n"				\
> -			append						\
> +			sc_append					\
>  			"1:\n"						\
>  			: "=&r" (r), "=&r" (__rc), "+A" (*(p))		\
>  			: "rJ" (co o), "rJ" (n)				\
> @@ -183,7 +188,9 @@
>  	}								\
>  })
>  
> -#define _arch_cmpxchg(ptr, old, new, sc_cas_sfx, prepend, append)	\
> +#define _arch_cmpxchg(ptr, old, new, sc_sfx, cas_sfx,			\
> +		      sc_prepend, sc_append,				\
> +		      cas_prepend, cas_append)				\
>  ({									\
>  	__typeof__(ptr) __ptr = (ptr);					\
>  	__typeof__(*(__ptr)) __old = (old);				\
> @@ -192,22 +199,28 @@
>  									\
>  	switch (sizeof(*__ptr)) {					\
>  	case 1:								\
> -		__arch_cmpxchg_masked(sc_cas_sfx, ".b" sc_cas_sfx,	\
> -					prepend, append,		\
> -					__ret, __ptr, __old, __new);    \
> +		__arch_cmpxchg_masked(sc_sfx, ".b" cas_sfx,		\
> +				      sc_prepend, sc_append,		\
> +				      cas_prepend, cas_append,		\
> +				      __ret, __ptr, __old, __new);	\
>  		break;							\
>  	case 2:								\
> -		__arch_cmpxchg_masked(sc_cas_sfx, ".h" sc_cas_sfx,	\
> -					prepend, append,		\
> -					__ret, __ptr, __old, __new);	\
> +		__arch_cmpxchg_masked(sc_sfx, ".h" cas_sfx,		\
> +				      sc_prepend, sc_append,		\
> +				      cas_prepend, cas_append,		\
> +				      __ret, __ptr, __old, __new);	\
>  		break;							\
>  	case 4:								\
> -		__arch_cmpxchg(".w", ".w" sc_cas_sfx, prepend, append,	\
> -				__ret, __ptr, (long), __old, __new);	\
> +		__arch_cmpxchg(".w", ".w" sc_sfx, ".w" cas_sfx,		\
> +			       sc_prepend, sc_append,			\
> +			       cas_prepend, cas_append,			\
> +			       __ret, __ptr, (long), __old, __new);	\
>  		break;							\
>  	case 8:								\
> -		__arch_cmpxchg(".d", ".d" sc_cas_sfx, prepend, append,	\
> -				__ret, __ptr, /**/, __old, __new);	\
> +		__arch_cmpxchg(".d", ".d" sc_sfx, ".d" cas_sfx,		\
> +			       sc_prepend, sc_append,			\
> +			       cas_prepend, cas_append,			\
> +			       __ret, __ptr, /**/, __old, __new);	\
>  		break;							\
>  	default:							\
>  		BUILD_BUG();						\
> @@ -216,16 +229,19 @@
>  })
>  
>  #define arch_cmpxchg_relaxed(ptr, o, n)					\
> -	_arch_cmpxchg((ptr), (o), (n), "", "", "")
> +	_arch_cmpxchg((ptr), (o), (n), "", "", "", "", "", "")
>  
>  #define arch_cmpxchg_acquire(ptr, o, n)					\
> -	_arch_cmpxchg((ptr), (o), (n), "", "", RISCV_ACQUIRE_BARRIER)
> +	_arch_cmpxchg((ptr), (o), (n), "", "",				\
> +		      "", RISCV_ACQUIRE_BARRIER, "", RISCV_ACQUIRE_BARRIER)
>  
>  #define arch_cmpxchg_release(ptr, o, n)					\
> -	_arch_cmpxchg((ptr), (o), (n), "", RISCV_RELEASE_BARRIER, "")
> +	_arch_cmpxchg((ptr), (o), (n), "", "",				\
> +		      RISCV_RELEASE_BARRIER, "", RISCV_RELEASE_BARRIER, "")
>  
>  #define arch_cmpxchg(ptr, o, n)						\
> -	_arch_cmpxchg((ptr), (o), (n), ".rl", "", "	fence rw, rw\n")
> +	_arch_cmpxchg((ptr), (o), (n), ".rl", ".aqrl",			\
> +		      "", RISCV_FULL_BARRIER, "", "")

These aren't the easiest things to read, but I can't think of a way to
improve it other than maybe some macro annotations. E.g.

 #define SC_SFX(x)      x
 #define CAS_SFX(x)     x
 #define SC_PREPEND(x)  x
 #define SC_APPEND(x)   x
 #define CAS_PREPEND(x) x
 #define CAS_APPEND(x)  x

 #define arch_cmpxchg(ptr, o, n)                        \
     _arch_cmpxchg(ptr, o, n,                           \
         SC_SFX(".rl"), CAS_SFX(".aqrl"),               \
         SC_PREPEND(""), SC_APPEND(RISCV_FULL_BARRIER), \
	 CAS_PREPEND(""), CAS_APPEND(""))

>  
>  #define arch_cmpxchg_local(ptr, o, n)					\
>  	arch_cmpxchg_relaxed((ptr), (o), (n))
> -- 
> 2.39.2
>

Thanks,
drew

