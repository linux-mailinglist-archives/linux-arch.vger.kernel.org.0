Return-Path: <linux-arch+bounces-5204-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611B291CED4
	for <lists+linux-arch@lfdr.de>; Sat, 29 Jun 2024 21:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877501C20F4C
	for <lists+linux-arch@lfdr.de>; Sat, 29 Jun 2024 19:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F26413D2A2;
	Sat, 29 Jun 2024 19:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGYcE/2Q"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4915513C3CA;
	Sat, 29 Jun 2024 19:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719688817; cv=none; b=t0bbYz0Dd5u5AyPR+zKTYsihokmTwTp6mGTyWHWW/f1BplkfLmgOa6OR2gaOQ4ESwUiotlmQqgloHcrQzUxe9Y/zBtjVh7sngDGKlMh7hhF9CPZKQKNeyNdD1aBszzMOv7pbBG26P2tSllSztgNtT62hESKVJ9NJSxTA8vDJRjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719688817; c=relaxed/simple;
	bh=KQXlYNGO5t0XXiirkC3HwO844EDhcpK5l5BlMakQQbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrPrPvSBqfnzxal3pzDdb2qEUkowvRCH2zEqeJ6mR5GM/k4J3dD5Jb0p3BX/hhmVCeoWmFJzM/WMR5Y15g3O+T+MXi9KP3lx5jjwyb8GxpqhpJUMutyXo1lH8N6Plet6FGU5UfjhlVoqANn74tQUp4pY5oTRoSZGPvnvtgbFOzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGYcE/2Q; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52e7d2278d8so2362249e87.3;
        Sat, 29 Jun 2024 12:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719688813; x=1720293613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=115ZNpFqbD4D/Gv906cLAl5QOwsv87o++hj04Lr8r4Y=;
        b=eGYcE/2QFrkSgFBJUFPNX/0d71dDurLoaV0hOk0HY5GM56PVT3Bfgfd4sBv81wFp9V
         CcAY06koocUCv6IA48sV6jD+fjX7DuXO15DpsxC4J0ADtpAiso2wTqqSboo8+s1OVmNt
         ioD93kOmP+hha00lMuaNd59SrRDUkNpq/NJcxRqA0GbO13wNQZjU0zn4xhyJIoQY803E
         49j0EKCMIkAcCC4/7l7ixZDMbv0QGz72Stdjq2l+hR1NCzV2PlBw04QolPdokXHU7hvG
         9PYqmYqZqSxabzd6KM+xkniu7ihfC8WYYIhbnITfmDpPz2GQTfY42ESIry7l6HqsHR2c
         NvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719688813; x=1720293613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=115ZNpFqbD4D/Gv906cLAl5QOwsv87o++hj04Lr8r4Y=;
        b=TXVG+jBhFAY4idXVIR+KwWpPeptG3aOug7gb5vWsmXHeAMCPZXmtB1VYwINruuNoEX
         aviADpw8Q3XceMStmc9LEDhC0vRfiK9hHE9bxj144jw+8Ktp/tleyz5QAM1t5sDzUtag
         i9IRkLmO69Ayxx7IxENG/avGFYr8vvz9zEKZKmX+L0BYQyx2BySAs3yQRBAGH+ZgL4Vi
         DizXCCgIrrn5jwZVuPKl+sUDfXwHICHxvRQts1HWgdArNc4sUaRM26iAYPDqQBL07RVC
         jtzkqXL/1o+R4YkJHzCcg+bF6okOQf1Q/zDf6Twmc05J8nb/cHJoJlvXmWnAywYZaS2z
         V0Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWoDcfNCfCQsZiTD6839JZ7iAYgQeIR2J49Elf0BciIjqtRYox6wP9Y2sXNy3hqrzsv0OnllH3CbGnSSPal0JSDyivkSu7zvWvATNIfqEX2qM17eFnmXhL2Z+qGLHKow2Zi9RDO9CmbP25VvjvURzBYrrRkJewAI1Squ3yOCTjNiU6xEQ==
X-Gm-Message-State: AOJu0Ywlc0PKzKZNzUcoXCAaRd+Dlwx5O4+51+GMPSXEfdJGNlwQ5NJJ
	kc1jOiwMfcV+5o82puSo8cT/Eyg1kK/FCOABRY9Govh+RPXRMCpk
X-Google-Smtp-Source: AGHT+IHJmrqKd+ZUfaM7arqCzy8Vv8yoDvxco3EeRFo3mfQJCEF1GHI4mFixe6ydIK4oX9Pq6c0aJg==
X-Received: by 2002:a05:6512:2345:b0:52c:76ac:329b with SMTP id 2adb3069b0e04-52e82687e21mr1665502e87.35.1719688812427;
        Sat, 29 Jun 2024 12:20:12 -0700 (PDT)
Received: from andrea (host-79-49-165-53.retail.telecomitalia.it. [79.49.165.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf18933sm187310666b.13.2024.06.29.12.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 12:20:11 -0700 (PDT)
Date: Sat, 29 Jun 2024 21:19:41 +0200
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
Message-ID: <ZoBeTTdMYdXU8gxD@andrea>
References: <20240626130347.520750-1-alexghiti@rivosinc.com>
 <20240626130347.520750-4-alexghiti@rivosinc.com>
 <Zn1StcN3H0r/eHjh@andrea>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn1StcN3H0r/eHjh@andrea>

> I admit that I found this all quite difficult to read; IIUC, this is
> missing an IS_ENABLED(CONFIG_RISCV_ISA_ZACAS) check.  How about adding
> such a check under the zabha: label (replacing/in place of the second
> IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) check) and moving the corresponding
> asm goto statement there, perhaps as follows? (on top of this patch)

[...]

> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> index b9a3fdcec919..3c913afec150 100644
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -110,15 +110,12 @@
>  	__label__ no_zacas, zabha, end;					\
>  									\
>  	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {			\
> -		asm goto(ALTERNATIVE("j %[no_zacas]", "nop", 0,		\
> -				     RISCV_ISA_EXT_ZACAS, 1)		\
> -			 : : : : no_zacas);				\
>  		asm goto(ALTERNATIVE("nop", "j %[zabha]", 0,		\
>  				     RISCV_ISA_EXT_ZABHA, 1)		\
>  			 : : : : zabha);				\
>  	}								\
>  									\
> -no_zacas:;								\
> +no_zacas:								\
>  	u32 *__ptr32b = (u32 *)((ulong)(p) & ~0x3);			\
>  	ulong __s = ((ulong)(p) & (0x4 - sizeof(*p))) * BITS_PER_BYTE;	\
>  	ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)	\
> @@ -148,16 +145,20 @@ no_zacas:;								\
>  	goto end;							\
>  									\
>  zabha:									\
> -	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {			\
> -		__asm__ __volatile__ (					\
> -			prepend						\
> -			"	amocas" cas_sfx " %0, %z2, %1\n"	\
> -			append						\
> -			: "+&r" (r), "+A" (*(p))			\
> -			: "rJ" (n)					\
> -			: "memory");					\
> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZAZAS)) {			\
> +		asm goto(ALTERNATIVE("j %[no_zacas]", "nop", 0,		\
> +				     RISCV_ISA_EXT_ZACAS, 1)		\
> +			 : : : : no_zacas);				\
>  	}								\
> -end:;									\
> +									\
> +	__asm__ __volatile__ (						\
> +		prepend							\
> +		"	amocas" cas_sfx " %0, %z2, %1\n"		\
> +		append							\
> +		: "+&r" (r), "+A" (*(p))				\
> +		: "rJ" (n)						\
> +		: "memory");						\
> +end:									\
>  })
>  
>  #define __arch_cmpxchg(lr_sfx, sc_cas_sfx, prepend, append, r, p, co, o, n)	\

Unfortunately, this diff won't work e.g. when ZABHA is supported and
detected at boot while ZACAS is not supported; more thinking required...

  Andrea

