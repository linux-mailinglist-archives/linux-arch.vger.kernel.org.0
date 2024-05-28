Return-Path: <linux-arch+bounces-4567-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 260218D22E6
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2024 20:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 560A31C22D73
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2024 18:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACD431A89;
	Tue, 28 May 2024 18:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDnSQ7ay"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA2E3D393;
	Tue, 28 May 2024 18:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716919235; cv=none; b=RaE1sJYP3HQ4iBIpt+EEGEYlenrLtIXq/liryVjXoMDOCrervH9A3zcmKfR6FNxfRuvcVlPQgGObMiQKsgq09LzcObVmti/GSEPYOS6IhAzuYrjvwM6cpVmDqE366ft1zjXebjlMZAYO8gUIxPjltYxeAjzDcvPjYNm6oezieks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716919235; c=relaxed/simple;
	bh=HTi4edYcJ+nU8knFjd7zyAuvpyUOEoajt4ywPw8se+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDAWsJTHLlUZT5NaJOObhtbH5fVYP27cP5XlvWej58kMFPSZV8zIKMcYkA6fkkvfRXJXn1C6xcddbMgR62RI/l4ic9QHDVNVif17NlYnHIPEi2f6JLLHcv01c+dZMPRyOsAo5o1V1xdml9+6i5ezFD30wM7BcaJcmdWXFTjCcL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDnSQ7ay; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5788eaf5366so1364947a12.2;
        Tue, 28 May 2024 11:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716919232; x=1717524032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/eecjvGqvQVC6ZWS6Qar373HjapbDvtdOZ42+zPeWi0=;
        b=GDnSQ7ay5ngiQN5tO02t8xbXxZVnqIdUYb4D5qyKXpV8vVos/FKFaTXHst31gTCeuS
         FI3e/EjTPzjluSG7hzqYzscYBm2RKwWZHUGYPZtCZ4yYNAmhG2XBSdSmaa24VgXq/N6S
         +l5aWba5y58wxonwMqzHMjQUk7QGBK8nY3sN016R1ZtKJb0WgLBzguNNMP4F+IJB3iCk
         dmSxApVFlWQOxmBRCenpc5J7RjrI65tt6/iq5WkcbNdCNDf7S0EvHHrZDwpy7cDZ3oN+
         uJQ3HnWRZZ3RAPGRxQVVl8dZxir/nADmr23N8q39uBHAOERcAp49gzBP3YCVrwqwuZN8
         6vBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716919232; x=1717524032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eecjvGqvQVC6ZWS6Qar373HjapbDvtdOZ42+zPeWi0=;
        b=V5t8OCnno+PO529DkFHiziZQSVHwhYUA6DS/YuYw0W+tnItZ9ax7j8hfA9ZidjNiUb
         sclgZ0PNfqBbU+wiL0qDvI6zSDNrrb7VDDIX842xUxuaWKVpDMMaXIR2WrxYDmKEr4md
         f7wph4ZXM4c8Tf4Otis5PJZxcpe7nsWWG4sj+2kidMOKpPP3IVQxr0bEw7e395NIooMm
         weLb8NvqAX0oO0/LfO3+Yw26JPf3V8CZte8U2I3z0ulvrHu8ZYJHKN2iJfvVVw0xNrQi
         I0JODbqT3lamKjHOAU4Aq3x+zRVtJHJxd5tMTLC1OBY2ekWoxBTVQbNs7fOM5TcyFPeQ
         BccQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxhJn5KK4ZDU9ceKtaovdSa1bvZFV2s1iosmxpCLDwFX7gqhF6ktQQG0GC1ODLkMtECyxyAGjVl3wdeCPPbn5/PyMAVT53w537eTGFIBC2qhq7Hf3GZFwZLxFHpmSF02W+k8mn6u6HEeGhM7PPt/s18Kxpa66IEDQDWFKoOUfGqJfF9g==
X-Gm-Message-State: AOJu0Yxk00/tzX47dD026y8dMiR25VjpnR2Ro8BUz7gMZ9lkUik5QIw+
	6yinlY0+v89g0rLflbTJvcjaTY/TqvyDGdiVefEnmF2cgHac/p2I
X-Google-Smtp-Source: AGHT+IEO4l+HTjYGVCjXbbD0O8/ek58vjia6UWCUjps9g02FYVlxFnqF5M3Q6IdqFSApclX99EyMUA==
X-Received: by 2002:a17:906:c20e:b0:a5a:1871:e2a1 with SMTP id a640c23a62f3a-a62649bcfebmr930552566b.33.1716919232133;
        Tue, 28 May 2024 11:00:32 -0700 (PDT)
Received: from andrea ([151.76.32.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a639ef1da1csm13068566b.147.2024.05.28.11.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 11:00:31 -0700 (PDT)
Date: Tue, 28 May 2024 20:00:26 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 4/7] riscv: Implement xchg8/16() using Zabha
Message-ID: <ZlYbupL5XgzgA0MX@andrea>
References: <20240528151052.313031-1-alexghiti@rivosinc.com>
 <20240528151052.313031-5-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528151052.313031-5-alexghiti@rivosinc.com>

> -#define __arch_xchg_masked(prepend, append, r, p, n)			\
> +#define __arch_xchg_masked(swap_sfx, prepend, append, r, p, n)		\

This actually indicates a problem in the current (aka, no Zabha)
implementation: without your series, xchg16() gets mapped to

  lr.w     a2,(a3)
  and      a1,a2,a5
  or       a1,a1,a4
  sc.w     a1,a1,(a3)
  bnez     a1,43c <.L0^B1>

which is clearly wrong... (other "fully-ordered LR/SC sequences"
instead follow the mapping

  lr.w     a2,(a3)
  and      a1,a2,a5
  or       a1,a1,a4
  sc.w.rl  a1,a1,(a3)
  bnez     a1,43c <.L0^B1>
  fence    rw,rw  )

A similar consideration for xchg8().

  Andrea

