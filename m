Return-Path: <linux-arch+bounces-5779-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B81943383
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 17:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9FE11C21B9E
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 15:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D3A5A10B;
	Wed, 31 Jul 2024 15:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="hxtbbpEN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4D01B3F1A
	for <linux-arch@vger.kernel.org>; Wed, 31 Jul 2024 15:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722440522; cv=none; b=EMup1+WQi0AnxJZ/9Tv2WOz80IDFqpRv0f2+NhaGjVR8yvSvPpIC0qrE4L2bCPxuqoj9aHqB2ccwzMDmBpemZ9BzRZO8va7PoprZDBHrFLuA2uH1n2LbK4thPUBtdnILag30MLmtd3CBo9VDnXSZq/rlIzsehkMCl1ra4hmVTDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722440522; c=relaxed/simple;
	bh=v5vaRlpTTd21X7XtxD7BVDxM5CtrMc34R7AxFqKMdcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YiYI2ugnLs5Bg4YE48wm2PbIZ1on4hpEWfDINsbL64qB2Qvan2JGvD2dJtSuA1FexIel1ps7S8UXZ/TMLkMCMQYtFRwplrO72yj169MqHB3FZp83Kjve12VoIzplMyEz32qEHr3MZh2zuxqHmFWCYEDn/Eap0LhaPP2Uwo8DG9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=hxtbbpEN; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5b391c8abd7so4234828a12.2
        for <linux-arch@vger.kernel.org>; Wed, 31 Jul 2024 08:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1722440519; x=1723045319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UYT2Cc0DbDwz0EHSJcGoeWCUyU6S/hmw9Y4vANMOf9c=;
        b=hxtbbpENYvcRgcLOLNUO2/KLHrc2ar4y25zbjldojDRo0RktvL76BJSE4IfodtpuN+
         Ub9nhi456AdqYb9FFk1qMoVk9dA3eqBgHprxzhySP++meCDsFOON5QaQC5lav4663lTs
         hdA652uV1KEq/18jRX8HtaY84TcIUD90L12QDjo0t6FlyQsUpB7u5K8x/F11MhFLzFIH
         pZp0AOzWwacizXnAXkRxWv7rRQijc3KEi7PuBRNO2RpiI1+hr2qqyaptIm/UO4zgehpc
         XQhqsIV48b1Zbayi0dkusZIgS8GvNh4kkV1U3FUMEL6t8PbnKK2oSDu+zawrnZSMLJY9
         4cow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722440519; x=1723045319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYT2Cc0DbDwz0EHSJcGoeWCUyU6S/hmw9Y4vANMOf9c=;
        b=NvmL+UPk3UxeWxV7rmCDMrIKxL0X2wIiCs0KWNO2mldoY50hsS4uMOetiS8P1C4DNq
         Q+FZrMqCWoEfNqRv3NwZHpizZtGnmjbvkUe6WcBplxgT+q0ThLM+WxG3DltokcPOthNC
         XKT7MYtyuMr3ctW8/Yy3P587EhgqjwsKAEQ1bHSIn/MwwxCQDr7l3midT8iGLFYk9+jh
         zRVqOw1J/hwz9O+0KGuFvfpF9LJvaAunpkCI9Hy6h8Kqf8w9XA4Cjw6AsGy3fERAeEZQ
         FIWImya8S4qJGBrHpOb4pTwsp9gBhogg1n5SLO2735veNeHoUQrzQ4QOMkAO8109cvwT
         /Gfg==
X-Forwarded-Encrypted: i=1; AJvYcCWJzSIQ+baF8fEuA3aNbYN+Q8zEj9fAy0r013LWQxiLfMj7271OnLAqZFMcKRN4vFVXIJJWDA4CHiKwQHTg3dyU3D0kuF1BXfWMhg==
X-Gm-Message-State: AOJu0YyqU4gIBaoGfANHKP2iED8i8kJAK4F/FVuCNBRvQPCAHAFtPTg8
	qp0F5GK2iM3LRaG8btc0bE+M5NvpTBzarw8PJRhr8NcLjizjTUHr6T2kxhpbVj4=
X-Google-Smtp-Source: AGHT+IEBk2d0ul2kTsNJSlKbs/TvRwodD3XnxLeAClb0/bTlm8Fcz5PpHV1kex7uf9VNsTgb5Tg1BA==
X-Received: by 2002:a17:907:728c:b0:a7a:a892:8e0b with SMTP id a640c23a62f3a-a7d40015a95mr1067366266b.19.1722440518929;
        Wed, 31 Jul 2024 08:41:58 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb82f2sm784530866b.204.2024.07.31.08.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 08:41:58 -0700 (PDT)
Date: Wed, 31 Jul 2024 17:41:57 +0200
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
Subject: Re: [PATCH v4 07/13] riscv: Implement arch_cmpxchg128() using Zacas
Message-ID: <20240731-98a368a296fa83a2e8ff8bec@orel>
References: <20240731072405.197046-1-alexghiti@rivosinc.com>
 <20240731072405.197046-8-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731072405.197046-8-alexghiti@rivosinc.com>

On Wed, Jul 31, 2024 at 09:23:59AM GMT, Alexandre Ghiti wrote:
> Now that Zacas is supported in the kernel, let's use the double word
> atomic version of amocas to improve the SLUB allocator.
> 
> Note that we have to select fixed registers, otherwise gcc fails to pick
> even registers and then produces a reserved encoding which fails to
> assemble.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/Kconfig               |  1 +
>  arch/riscv/include/asm/cmpxchg.h | 38 ++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

