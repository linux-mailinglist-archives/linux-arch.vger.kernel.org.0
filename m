Return-Path: <linux-arch+bounces-14093-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B25BD8C06
	for <lists+linux-arch@lfdr.de>; Tue, 14 Oct 2025 12:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D05454FDFC4
	for <lists+linux-arch@lfdr.de>; Tue, 14 Oct 2025 10:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8A82F83CF;
	Tue, 14 Oct 2025 10:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJGus4q+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167342F7469
	for <linux-arch@vger.kernel.org>; Tue, 14 Oct 2025 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760437446; cv=none; b=bUp+THPwN7oS+CgwG0/XBgt69SXcXg2OHzUtHyNiGogijfqZMliLzz5T4jdlV1yDj3j7jFYTuhaFsJJ0J5D5HNLqLUvWKo8UBAw96CLNfs0xq/yF3vpy5ke2xPTGXlvi63m0QVPsZujlc4dwUFYlCbIKV/Qsy0xjzdOFJZAdf1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760437446; c=relaxed/simple;
	bh=NvHrsqobRMlVNo+tAxu9F71BW5DWp04J4+78E6v6/2I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AhpKxN3oONn1EUnMQrtgAJ3NiSm7txD/DxqezRi4he/LMOUovQjgkoEjNvEml4B2TGfeHlINHq1iTjuXdT8+sGJspNznPGPW0BsItsHVVAZ8Fz6+HW8kjCe7aEjBioZLX5msBQqmJrM3SXrhFrKfRN6xsYJlZ4skcmhDv8GQooI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJGus4q+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e4ad36541so53873855e9.0
        for <linux-arch@vger.kernel.org>; Tue, 14 Oct 2025 03:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760437441; x=1761042241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2B27CnCtnwt2IGtR8SnAOo/nO7i1YaXCeSpoBrMXO7I=;
        b=nJGus4q+SYUIGvndAARIM3qO3Lktr1Z0SOm1vq1+sjfRbXZeH6sLkfSF0S7jXNKoAY
         Dy8fFkrCnXxwbaUC7wSzd3cnb/ANQpABHu0Zsjs2E93SgctEem8y0v783q8iifANnFGI
         DYTnlBoEV+cf+AZAn4fh513Qxvx416dxglUYMCBIm60Tixd2wluyqzYRLmRKShx1ir7z
         bA4iRcINkApQgVwOtfchyWghh3EB91tY1ab7RGV1lNX3D9o35dlYF/FwyBynpK0Vbcte
         +bdCCamUp1Jv/MqnUqCwEIy/ojaOTqskhisZzL45ct46yDBU7IHiU4H+rkzzuVD3qS7T
         /k3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760437441; x=1761042241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2B27CnCtnwt2IGtR8SnAOo/nO7i1YaXCeSpoBrMXO7I=;
        b=TrX4oO6iOOuaJxjeOd05Nd/IuRb0W8/bXkStwy/+RCfiFkLIcyTkBD+9dTBpRW9gTq
         w2mnrYFYjOPejyVi+2J5Sbyo7XrkWraKljp9DrS3L2qqQeIiaMbGMFhDNOYEXGZnCq1G
         oWvWxTLCwIoNcVayWy8p86V+NAwIwGLuji1PnKva/mURfvuDx8KXfE0XfQZYeSNP+ryb
         +9ElGF3lYRfsM0bEf1/NAtpMqxG9tSQbc0SoXAWDlIdakrs7oKjgFPPX5hjuUtbGvZrS
         DgZKIms1iX5RR2jwT9Be5uhtAHSu8sfb+P6SCaEHdcx/zoB+HOt9ayJs2ZFBlcfdjaUD
         VjZg==
X-Forwarded-Encrypted: i=1; AJvYcCUSzjEOzlmAMLbehcVGhu9VV184ENBCliwuA2fbjhg0xo541FPXevobQC6pB+jHQFwMveibwbJL62ft@vger.kernel.org
X-Gm-Message-State: AOJu0Yws+qyZiQ+F+5CmUup20QOgqdBoSU8AxPILbVBUB0R/42zd35Gf
	hA23giZRqsZqJWi4JAvESMDURjEbCaDbykPFXtwSHHA20k2/cBr1hH0P
X-Gm-Gg: ASbGncunwA+AN99UpL05yoh2TyfjjTVYRGBNroyIgoDKhlSdCJrpzHg35OoUx5KBwRA
	PvRAeVJdg1/Ni6s0zIK3pY7QLubR5MoDhZCdHWLI9C2f2Q0lshOASlkt8E5ZVKmFoJ2RHgDSw3n
	vuNV7fdoTNr0PsdR0tgq/ijE0RwlDq58PzpV1cYFDuTOrsbxryoMNMgIuWQKG2KgEv7SUA56B1D
	WuriuevguvFlC5Pd8eOnZkY7vOthvM3lEDM+BXzPngXFonFo03TlJEb8XBGEGPB8cc8TyXOTDUc
	KruMBNxt3d5NQaWqAzGNhov/oX1kWRb83yvacRC5izFSpuMPqjPfCBTIYPRxabjtbSCiSyjfb0F
	8JVTTDN2lkB3bZmnLNf5lr0n489qXAbZ5KTE9r6LK7RRAs5H4IfTj/Ui4Ae60vuz+CImCoLsyGo
	E+1vDFkHGZdYzAFdY7Sg==
X-Google-Smtp-Source: AGHT+IFJLN+ZyNIVUulNgloN7eKBRUWfhH8DTaEyEj2PWqBPSZ2eXtCGpbEULmWHbXarmuQpgFVGnQ==
X-Received: by 2002:a05:600c:4688:b0:46e:4372:5395 with SMTP id 5b1f17b1804b1-46fa9b01ff5mr167772905e9.25.1760437441227;
        Tue, 14 Oct 2025 03:24:01 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cf70fsm22150016f8f.27.2025.10.14.03.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 03:24:00 -0700 (PDT)
Date: Tue, 14 Oct 2025 11:23:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Finn Thain <fthain@linux-m68k.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Boqun Feng
 <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Mark Rutland
 <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Geert
 Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [RFC v3 1/5] documentation: Discourage alignment assumptions
Message-ID: <20251014112359.451d8058@pumpkin>
In-Reply-To: <76571a0e5ed7716701650ec80b7a0cd1cf07fde6.1759875560.git.fthain@linux-m68k.org>
References: <cover.1759875560.git.fthain@linux-m68k.org>
	<76571a0e5ed7716701650ec80b7a0cd1cf07fde6.1759875560.git.fthain@linux-m68k.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 08 Oct 2025 09:19:20 +1100
Finn Thain <fthain@linux-m68k.org> wrote:

> Discourage assumptions that simply don't hold for all Linux ABIs.
> Exceptions to the natural alignment rule for scalar types include
> long long on i386 and sh.
> ---
>  Documentation/core-api/unaligned-memory-access.rst | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/Documentation/core-api/unaligned-memory-access.rst b/Documentation/core-api/unaligned-memory-access.rst
> index 5ceeb80eb539..1390ce2b7291 100644
> --- a/Documentation/core-api/unaligned-memory-access.rst
> +++ b/Documentation/core-api/unaligned-memory-access.rst
> @@ -40,9 +40,6 @@ The rule mentioned above forms what we refer to as natural alignment:
>  When accessing N bytes of memory, the base memory address must be evenly
>  divisible by N, i.e. addr % N == 0.
>  
> -When writing code, assume the target architecture has natural alignment
> -requirements.

I think I'd be more explicit, perhaps:
Note that not all architectures align 64bit items on 8 byte boundaries or
even 32bit items on 4 byte boundaries.

	David

> -
>  In reality, only a few architectures require natural alignment on all sizes
>  of memory access. However, we must consider ALL supported architectures;
>  writing code that satisfies natural alignment requirements is the easiest way
> @@ -103,10 +100,6 @@ Therefore, for standard structure types you can always rely on the compiler
>  to pad structures so that accesses to fields are suitably aligned (assuming
>  you do not cast the field to a type of different length).
>  
> -Similarly, you can also rely on the compiler to align variables and function
> -parameters to a naturally aligned scheme, based on the size of the type of
> -the variable.
> -
>  At this point, it should be clear that accessing a single byte (u8 or char)
>  will never cause an unaligned access, because all memory addresses are evenly
>  divisible by one.


