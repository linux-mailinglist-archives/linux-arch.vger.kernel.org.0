Return-Path: <linux-arch+bounces-5761-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5916A942A68
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 11:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2159D2837A3
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 09:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F351AAE22;
	Wed, 31 Jul 2024 09:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="W4AalDwo"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEEA1A8C1A
	for <linux-arch@vger.kernel.org>; Wed, 31 Jul 2024 09:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722418029; cv=none; b=i+36Hyr9EyOiiRU2VvB1lS68J4Ogp+KzuNREr6j67LShE3qtQMkmzCnS7RNrSd4VQ8nFaTSgVZhQbNW5XNIvM7dBMkCrVSBo76XL7Ut2/IdyoiYyUX+e7H1JQdp9wdRXIt8lnVpJVO4gmf5ct/l5xm48xqtIgrn86M0ImUW7wmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722418029; c=relaxed/simple;
	bh=4txZO0NyiZJsXzMrfPzPDzAvVuqnEJKl3zlQlZLsFJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWabQSOzYKnP6X/7gzE2udvtem49ElZCUb2mfs+cdaecT8yos862w5ST99nQ9UdAiXeh0k3w5AdorIO3+NzfA8L2UB1GsEA6+jpYp0wyPxMQ2QF3wih02wA/we6nwPtRSJtZxu+9Z/IoeNi3q2BhSOT4UNZki0VonnQYv8ve3RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=W4AalDwo; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52efc89dbedso7034793e87.3
        for <linux-arch@vger.kernel.org>; Wed, 31 Jul 2024 02:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1722418026; x=1723022826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p7SJK2WN3L6uZyaEdLNNOcGfMCG9Ym2ay5t0xgYijf0=;
        b=W4AalDwovk4V7gdaoc2MugPS6Z/vioPnBrEO6wr9Mf54juxGGOcwZSiCsEEzypEQT0
         FiERaZqx6tXqC3Pw2nhiXPmSE7enBLGnkow9I44AJR5COqbpz7jMbeh2vhDojUqVT2Am
         UFF6X9m6ZlMOkugSE0iYwD0CnA+mtwgwaFSr1kX++ItNdVP/TMkXVveu/485kbYaT/il
         +atBNxSlSbXXpfP2N4e4cTh0fGqfE1Yk5gg1dECOvDP4GxEcArC1Kxz6GaXJhJ4TDTB4
         2KGeNPAj88ePdyINgc0uUWOmYk/1W7bbSh4tZWGaFaqEL2mWckSPjfP1TngcchRQVg1s
         9qKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722418026; x=1723022826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7SJK2WN3L6uZyaEdLNNOcGfMCG9Ym2ay5t0xgYijf0=;
        b=gotvuctmayfLtgTUDbWVBt709lG8yYTeHtj9z63wk1fAviS+AuZL0inIuO0AzktixJ
         qsg5httDQtTpoxFmpoy+t3QMIpc1jqDNpIKoVIM09RtfsiEwirBTjDYL+e/ivj5IMh18
         LpKKD/4NKxI2yprhFzgX49NFtmnbV5nOv0uf0BEyUvsLvab8BHaTGF320nb6L9mniaGr
         ZLFTnB537Rrd7kei9WcrzNiQCmLj6YEX8mnCJJws7jVA6I7ZmzzpbooVFbhvco9heB3Y
         iBx9KmQwUqjw6eBhQ8f85W4T3AVwLsRO9X2eZAof5uHtybDFLyJRWGFKdix4s8twoPhe
         XLcA==
X-Forwarded-Encrypted: i=1; AJvYcCW7WKdgBnINR3OLHtJ5fgj5x3RAuRyPyIVEGb0KfK3bJP2h8GekIMh+yzP1E+E7dO5S3OwY2XKz3w3wnLy29mPuLKPxSM1TvqkAaQ==
X-Gm-Message-State: AOJu0YyrTzJXt6T8yBHua+K5z3aHMk3d/OcGZB9o2y2EONCG4c8ZGiNj
	ZWFBGS7eu5dPGuCLii0Z7FC/6o/BsGBKqCefk4uBua/51Eo7wHY5+F/L8TOhvQo=
X-Google-Smtp-Source: AGHT+IG3JIOtJ24DzWq2AbHse04McdP7VjBbSLZOo3eV9EeDpYpgjlKyfa2GCIpAnxuCqpt5LCi3OQ==
X-Received: by 2002:a05:6512:292:b0:52f:c13f:23d2 with SMTP id 2adb3069b0e04-5309b2803e4mr8247308e87.25.1722418025413;
        Wed, 31 Jul 2024 02:27:05 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac64eb3c1esm8451687a12.78.2024.07.31.02.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 02:27:04 -0700 (PDT)
Date: Wed, 31 Jul 2024 11:27:04 +0200
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
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v4 05/13] riscv: Implement cmpxchg8/16() using Zabha
Message-ID: <20240731-da4a7d7790e88a6b8960ad3e@orel>
References: <20240731072405.197046-1-alexghiti@rivosinc.com>
 <20240731072405.197046-6-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731072405.197046-6-alexghiti@rivosinc.com>

On Wed, Jul 31, 2024 at 09:23:57AM GMT, Alexandre Ghiti wrote:
> This adds runtime support for Zabha in cmpxchg8/16() operations.
> 
> Note that in the absence of Zacas support in the toolchain, CAS
> instructions from Zabha won't be used.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/Kconfig               | 18 ++++++++
>  arch/riscv/Makefile              |  3 ++
>  arch/riscv/include/asm/cmpxchg.h | 78 ++++++++++++++++++++------------
>  arch/riscv/include/asm/hwcap.h   |  1 +
>  arch/riscv/kernel/cpufeature.c   |  1 +
>  5 files changed, 72 insertions(+), 29 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

