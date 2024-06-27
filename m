Return-Path: <linux-arch+bounces-5165-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 385C191A5B4
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jun 2024 13:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C451F25348
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jun 2024 11:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639B914A4DD;
	Thu, 27 Jun 2024 11:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FixWVH9y"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57A013AA4C;
	Thu, 27 Jun 2024 11:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719489216; cv=none; b=e1C4vYEqupSSww0C86t69oxQIOauieu4IL0E4YHXx5GXZOkSJYmkc/5IPKLeVHPo4BlkFr0a7XA2PMcPMQw7OFyBsCCGudqHIqqpp494/VKEEO0KBcLWUk4AQIrq0eRyCZDHIsvYiLlmPS94KLKheMxupmZ0ONQ/OT4VSyfcUtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719489216; c=relaxed/simple;
	bh=02Eo7ZreZ7k6s2432VKLtDeD2NoZmTQTCZnul0+urPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7XrjBmtDVHD17o33ozm5ef+nTMxmY4Sl2N+PWDbyD7RmoIHaHwkIoNM5Y4ak3KFw2o7nhY021uxE/aURVlnMcJ6SW6gLjLdRtl3bRREf2j1oHxOC3vfH51ftxWNZZuXy0LgjZSuHK2GXXaEoqHzKEnrLB5ozkZu/Nss8VFBY7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FixWVH9y; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57d05e0017aso1779428a12.1;
        Thu, 27 Jun 2024 04:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719489213; x=1720094013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jcNyZGznc5fPRIAycn+yX2TaeomztoG0VIVAkH7fqvg=;
        b=FixWVH9yVrZMZhEjLK1lFtzJ/fB/ZyF/95bXLjm2ONoefd/RshoxLmGSrzNCzUz9IJ
         7Y00jZHZ+excEcLOSV1ZZew8whIA4ApqJ1OnJ2J74hKeXmIjiyc8Vb5SWTp6bCcCftJd
         M13Guk4GZsxyw/QVR8YHWIa6hah25c8EBRldzK3bfk8eoz+lERQR4eK4/VrMAig0pI5t
         oAi7WXU6hLFqI/7dyJ8rc0vfLkSeUYb6Y1VGOwXLm5ruDlG+2Cbc0H3nwkDInT2FlrEt
         Z4DK2KPf6EgHP7+ny+s8Nmx3NGoWwxjANlgAgJ5kv+RyvPbqjBXLpXP21DiU4Tg+/rV9
         I+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719489213; x=1720094013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcNyZGznc5fPRIAycn+yX2TaeomztoG0VIVAkH7fqvg=;
        b=A4xI8jI7EAuJxi0AalPJMH310SxXNXDbROUwGpWeqzHvGB7bymbRkj8fsqqVodh8i2
         64ueen0fm03pl6X+vgAF/eNyMO8SSxKBx2xkpe++EoBFQ3DIBPsrBewrtsMzN+sYivso
         m1JsF3RuFxIUtBayFc+ZTEzCSN+++erkBbZ7RVOzKotB4U/KQKRFAn5+r7kLrbyOeJ3Z
         AKYudUK7LKf+PEHBq1GVyeGgvNKFr4S8LZ/KCxDeECyuvSgH9Bjnyuoa0uHqiCAJl8MN
         1gsLf62/Ae4abyFFIzG1UtpEVA33POcVVCwduM2+2A7cwkPSStArdMgAYFVP9/KhCvwf
         z27A==
X-Forwarded-Encrypted: i=1; AJvYcCXmlpbYVZYohl5roARMoYQkFlGEeCux3vRaKJOiZDeiPtafG48dvQEjcaLUtbLsqPapypk0R9/MFkVlZImTajn7UPOKa0amt/EnTSGQKIC8KYc62RA0mXGkp/mChw4TPVimmimkOvoHCCeistYs/Ol64uH06PBvsdrOWx5qRpPs26sc3w==
X-Gm-Message-State: AOJu0YzZcwUSnuAIAvsCG2Y+tviMMkcRsz7YuduJ+aNCo3mEm4VATe4s
	TKMhVJarEwMDMNoOpvPqoYmkHGMgjrkwKWDnSV0eB9s3B6Q9NFRJ
X-Google-Smtp-Source: AGHT+IGLItRQBo55yU3VI7Wivwhx6v+M1XTrEZj2isMxyFDWUA2A65q19H3IxMSRCHBj2w2WgDoQVA==
X-Received: by 2002:a17:906:230d:b0:a6f:50ae:e0a with SMTP id a640c23a62f3a-a715f978a7amr818590366b.37.1719489212385;
        Thu, 27 Jun 2024 04:53:32 -0700 (PDT)
Received: from andrea ([217.201.220.159])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d71f1cfsm52522666b.72.2024.06.27.04.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 04:53:31 -0700 (PDT)
Date: Thu, 27 Jun 2024 13:53:25 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 03/10] riscv: Implement cmpxchg8/16() using Zabha
Message-ID: <Zn1StcN3H0r/eHjh@andrea>
References: <20240626130347.520750-1-alexghiti@rivosinc.com>
 <20240626130347.520750-4-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626130347.520750-4-alexghiti@rivosinc.com>

> -#define __arch_cmpxchg_masked(sc_sfx, prepend, append, r, p, o, n)	\
> +#define __arch_cmpxchg_masked(sc_sfx, cas_sfx, prepend, append, r, p, o, n)	\
>  ({									\
> +	__label__ no_zacas, zabha, end;					\
> +									\
> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {			\
> +		asm goto(ALTERNATIVE("j %[no_zacas]", "nop", 0,		\
> +				     RISCV_ISA_EXT_ZACAS, 1)		\
> +			 : : : : no_zacas);				\
> +		asm goto(ALTERNATIVE("nop", "j %[zabha]", 0,		\
> +				     RISCV_ISA_EXT_ZABHA, 1)		\
> +			 : : : : zabha);				\
> +	}								\
> +									\
> +no_zacas:;								\
>  	u32 *__ptr32b = (u32 *)((ulong)(p) & ~0x3);			\
>  	ulong __s = ((ulong)(p) & (0x4 - sizeof(*p))) * BITS_PER_BYTE;	\
>  	ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)	\
> @@ -133,6 +145,19 @@
>  		: "memory");						\
>  									\
>  	r = (__typeof__(*(p)))((__retx & __mask) >> __s);		\
> +	goto end;							\
> +									\
> +zabha:									\
> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {			\
> +		__asm__ __volatile__ (					\
> +			prepend						\
> +			"	amocas" cas_sfx " %0, %z2, %1\n"	\
> +			append						\
> +			: "+&r" (r), "+A" (*(p))			\
> +			: "rJ" (n)					\
> +			: "memory");					\
> +	}								\
> +end:;									\
>  })

I admit that I found this all quite difficult to read; IIUC, this is
missing an IS_ENABLED(CONFIG_RISCV_ISA_ZACAS) check.  How about adding
such a check under the zabha: label (replacing/in place of the second
IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) check) and moving the corresponding
asm goto statement there, perhaps as follows? (on top of this patch)

Also, the patch presents the first occurrence of RISCV_ISA_EXT_ZABHA;
perhaps worth moving the hwcap/cpufeature changes from patch #6 here?

  Andrea

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index b9a3fdcec919..3c913afec150 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -110,15 +110,12 @@
 	__label__ no_zacas, zabha, end;					\
 									\
 	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {			\
-		asm goto(ALTERNATIVE("j %[no_zacas]", "nop", 0,		\
-				     RISCV_ISA_EXT_ZACAS, 1)		\
-			 : : : : no_zacas);				\
 		asm goto(ALTERNATIVE("nop", "j %[zabha]", 0,		\
 				     RISCV_ISA_EXT_ZABHA, 1)		\
 			 : : : : zabha);				\
 	}								\
 									\
-no_zacas:;								\
+no_zacas:								\
 	u32 *__ptr32b = (u32 *)((ulong)(p) & ~0x3);			\
 	ulong __s = ((ulong)(p) & (0x4 - sizeof(*p))) * BITS_PER_BYTE;	\
 	ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)	\
@@ -148,16 +145,20 @@ no_zacas:;								\
 	goto end;							\
 									\
 zabha:									\
-	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {			\
-		__asm__ __volatile__ (					\
-			prepend						\
-			"	amocas" cas_sfx " %0, %z2, %1\n"	\
-			append						\
-			: "+&r" (r), "+A" (*(p))			\
-			: "rJ" (n)					\
-			: "memory");					\
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZAZAS)) {			\
+		asm goto(ALTERNATIVE("j %[no_zacas]", "nop", 0,		\
+				     RISCV_ISA_EXT_ZACAS, 1)		\
+			 : : : : no_zacas);				\
 	}								\
-end:;									\
+									\
+	__asm__ __volatile__ (						\
+		prepend							\
+		"	amocas" cas_sfx " %0, %z2, %1\n"		\
+		append							\
+		: "+&r" (r), "+A" (*(p))				\
+		: "rJ" (n)						\
+		: "memory");						\
+end:									\
 })
 
 #define __arch_cmpxchg(lr_sfx, sc_cas_sfx, prepend, append, r, p, co, o, n)	\

