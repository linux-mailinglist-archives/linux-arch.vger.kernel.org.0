Return-Path: <linux-arch+bounces-6722-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0065B962E84
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 19:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59F17B212F1
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 17:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CD61A76C1;
	Wed, 28 Aug 2024 17:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="TpjlmABV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB391A76BD
	for <linux-arch@vger.kernel.org>; Wed, 28 Aug 2024 17:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724866204; cv=none; b=MjJTse2+sJifJqVX55/YzHxP2BBIpyyfGAhCWy3rLKWJG+4KwTgGKTv0ZEBzPsxtZO1Qg1MH7fxTf4y+M2KFjqtEJx2tJ1X/7Es+tadvk/vWLWi8B/6tA87lzveCjbqpwpPxlN+Fy9tTvYB7xyIi4rCNg/2jo/r9c5eJtdkAvQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724866204; c=relaxed/simple;
	bh=OmO27VpmrhU31qsKclIqtL8TYK6eYIyOBD8Nc1b6/sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bieRYiVBTV5bxO/xI55D+um5kTPFA/Oo12/uz7GJMRu1NUPGQ/o+sdTtbujkWDjraa5FZz9JAkYfvxe1OZWetNxl3y9X3+LJ/h2B7/1HexX59W5fJfBblBWop5Q+rhwkae58C/lPE2zK52HdrmxzfCXZOAYnwPgIe5kGLXLy5hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=TpjlmABV; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7142a30e3bdso690891b3a.0
        for <linux-arch@vger.kernel.org>; Wed, 28 Aug 2024 10:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724866201; x=1725471001; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=izEx2iGerEnX7WB/2Mpvv+y1MVG/tbs1FdX9CKEIcSg=;
        b=TpjlmABVarE4pTP8IIaQW8r5WIQYE/q3k9AeSj0TQiS4s0FQFCY1jMUcUe0LRUfGFC
         jPnXTIofU2ZBnLJmLBckW74bTp12Br6sNHp0gkyPrrwI4S61o3Ne15rtg6ZuFYDl2Uk5
         6k3gPBu8aWLCcsgsVCmn79ZYsuAPuMa2RIRLfnIIV1vh1oWSTQA7Rsz+76jPoT1uIJoq
         e0+vcl0p569SySs5UL5JHZVcWOX7iYAEc8V+KSYx+FbCIqS/gTcI4W6FleCgt85tNWEu
         yvvd5LNLTtPOmPM8n8yH9nAENwfZSYvPp3p3mRAZcMK8Ggusd2479ddcaB2HMt330v/p
         6Xgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724866201; x=1725471001;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=izEx2iGerEnX7WB/2Mpvv+y1MVG/tbs1FdX9CKEIcSg=;
        b=ZFzZwe3gi5iUaZU2ZlXC+CjCDMs+gbj2tAj9aqVHPGLD5ImK27WK3MzPXvPL/1PGVl
         C+WvuOQuB/6OUQ68PwBGNMjEJC5Vsc+Iq24adYXVV9nv2Jtx3T8n64dOYL+9O0Xd++cX
         Wk2AguA32pfWVPtywlQzi0bscawJV2k4khbKIxKnuXdsUgTVChrnQ6QWRGiXVB592NzZ
         F5L16GXmLJuzY37SSARNXg/B6hzYF1WQEwOu/Ir/vlnZwyP7C8NxVfR7wkewg0KQj/ej
         uPDS3JnvIZdhG7+OXOcsOhXKPJB3vLJQuHkWBj0Y1qt6qpdIvQ5UqeBVvoLDUsoQeSIK
         6M5A==
X-Forwarded-Encrypted: i=1; AJvYcCUFnqJNXGl8ExebHLWjsF5kRauYcMkBpl2fqjMGrJxEFVSBNTiyc4adnk1C0JUg0q0Co9vlz5+INqWb@vger.kernel.org
X-Gm-Message-State: AOJu0YwyeUL2dw3MwV8O1FsXnfoS5tTefD8FBAGuLgxFxcGl3TusvVNc
	/TubnT24eLWZ4yD9+QwtCM2a4FCaCWRrIvLhet6Ipf0ehJwOTHXdow91c/MPP38=
X-Google-Smtp-Source: AGHT+IHMsuvXLfTW+bLvG1ZAGccaibo4i2N0hBI/JcHNn1qd40DIOjpRRFBts/vAK3nn3l/ntjAfHA==
X-Received: by 2002:a17:903:1210:b0:1fb:2ebc:d16b with SMTP id d9443c01a7336-204f9bb4194mr38041435ad.7.1724866201061;
        Wed, 28 Aug 2024 10:30:01 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385581393sm101427625ad.102.2024.08.28.10.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 10:30:00 -0700 (PDT)
Date: Wed, 28 Aug 2024 10:29:55 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Shuah Khan <shuah@kernel.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-mm@kvack.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 07/16] powerpc: mm: Support MAP_BELOW_HINT
Message-ID: <Zs9ek1Cr1SaQzSqg@ghost>
References: <20240827-patches-below_hint_mmap-v1-0-46ff2eb9022d@rivosinc.com>
 <20240827-patches-below_hint_mmap-v1-7-46ff2eb9022d@rivosinc.com>
 <a43c52c6-c1ac-4ef3-b511-08f0459bddad@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a43c52c6-c1ac-4ef3-b511-08f0459bddad@csgroup.eu>

On Wed, Aug 28, 2024 at 08:34:49AM +0200, Christophe Leroy wrote:
> Hi Charlie,
> 
> Le 28/08/2024 à 07:49, Charlie Jenkins a écrit :
> > Add support for MAP_BELOW_HINT to arch_get_mmap_base() and
> > arch_get_mmap_end().
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >   arch/powerpc/include/asm/task_size_64.h | 36 +++++++++++++++++++++++++++------
> >   1 file changed, 30 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/task_size_64.h b/arch/powerpc/include/asm/task_size_64.h
> > index 239b363841aa..a37a5a81365d 100644
> > --- a/arch/powerpc/include/asm/task_size_64.h
> > +++ b/arch/powerpc/include/asm/task_size_64.h
> > @@ -72,12 +72,36 @@
> >   #define STACK_TOP_MAX TASK_SIZE_USER64
> >   #define STACK_TOP (is_32bit_task() ? STACK_TOP_USER32 : STACK_TOP_USER64)
> > -#define arch_get_mmap_base(addr, len, base, flags) \
> > -	(((addr) > DEFAULT_MAP_WINDOW) ? (base) + TASK_SIZE - DEFAULT_MAP_WINDOW : (base))
> > +#define arch_get_mmap_base(addr, len, base, flags)					\
> 
> This macro looks quite big for a macro, can it be a static inline function
> instead ? Same for the other macro below.
> 

I had overlooked that possibility, I think that's a great solution, I
will change that.

> > +({											\
> > +	unsigned long mmap_base;							\
> > +	typeof(flags) _flags = (flags);							\
> > +	typeof(addr) _addr = (addr);							\
> > +	typeof(base) _base = (base);							\
> > +	typeof(len) _len = (len);							\
> > +	unsigned long rnd_gap = DEFAULT_MAP_WINDOW - (_base);				\
> > +	if (_flags & MAP_BELOW_HINT && _addr != 0 && ((_addr + _len) > BIT(VA_BITS - 1)))\
> > +		mmap_base = (_addr + _len) - rnd_gap;					\
> > +	else										\
> > +		mmap_end = ((_addr > DEFAULT_MAP_WINDOW) ?				\
> > +				_base + TASK_SIZE - DEFAULT_MAP_WINDOW :		\
> > +				_base);							\
> > +	mmap_end;									\
> 
> mmap_end doesn't exist, did you mean mmap_base ?

Oh whoops, thank you!

- Charlie

> 
> > +})
> > -#define arch_get_mmap_end(addr, len, flags) \
> > -	(((addr) > DEFAULT_MAP_WINDOW) || \
> > -	 (((flags) & MAP_FIXED) && ((addr) + (len) > DEFAULT_MAP_WINDOW)) ? TASK_SIZE : \
> > -									    DEFAULT_MAP_WINDOW)
> > +#define arch_get_mmap_end(addr, len, flags)							\
> > +({												\
> > +	unsigned long mmap_end;									\
> > +	typeof(flags) _flags = (flags);								\
> > +	typeof(addr) _addr = (addr);								\
> > +	typeof(len) _len = (len);								\
> > +	if (_flags & MAP_BELOW_HINT && _addr != 0 && ((_addr + _len) > BIT(VA_BITS - 1)))	\
> > +		mmap_end = (_addr + _len);							\
> > +	else											\
> > +		mmap_end = (((_addr) > DEFAULT_MAP_WINDOW) ||					\
> > +				(((_flags) & MAP_FIXED) && ((_addr) + (_len) > DEFAULT_MAP_WINDOW))\
> > +				? TASK_SIZE : DEFAULT_MAP_WINDOW)				\
> > +	mmap_end;										\
> > +})
> >   #endif /* _ASM_POWERPC_TASK_SIZE_64_H */
> > 

