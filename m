Return-Path: <linux-arch+bounces-4570-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B28478D28F8
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 01:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43201C2437D
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2024 23:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7CE13D89A;
	Tue, 28 May 2024 23:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFpDmLKI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D22B140384;
	Tue, 28 May 2024 23:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716940469; cv=none; b=egbGmpAITk3cbvs8Vpl1yY3RxwWh3Qx/xaJo0V/hhTwy53evG4b41l2/dAlq1MMhDdb5rLC2jgrmyKUs3JnZnoIlD07laZ36xpEmx+EeIvh6RpheFkUJzRiUJ1XKrzvuZPp1JFVeEDM1hmhJwftvgAL0Lswreu0y1aTxjkI88VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716940469; c=relaxed/simple;
	bh=/W3e8geK/8V/pJI8LI/mKqvkPRhYyE0QhjBX7G82yL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8RdDsG3r69mPuVR0ekbaapiRNsg97Za/VYvA3xcX+4neKfjJUw4AkmSrt3xATMt3ON+1WQgxPTzGbw6EPs0Mm8dLsjmOMnWX4x0pwF43TeT7kIjtSw64qagJzQilHqkwffanRAHAyHhkd5VGJ1cM5E+UtFIQh09lLNT6n3yZ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFpDmLKI; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5785c1e7448so1410515a12.2;
        Tue, 28 May 2024 16:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716940466; x=1717545266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e000vksGZKxcpTxpZnBmsIz0xFc2hPH9avlD+baB/tQ=;
        b=nFpDmLKIZhDR2+01LtZJaIZRvM0txK4YMWqzRg41jwsXh38qPRq5mvP9QsQqG4Ggqt
         hYWFhwWOlbfVGZdPWA0I8Nfwh4oj03BW5Tzen+zxZqXUyg3iClmZ1UOJS3dOkWRsQ17t
         l728qUzYTSQJudqWC1BUekMAKXaargTWo/bIZ0RSXsV44WYR8yFtIVL8+nFieoW4VQbB
         BldIbpzCzOs1+F4MBmPL4OfFHoUkDcyLFp01/2e1bb/w9s97aN0fcjZLKtZxBRcHKCMw
         3Fbtmnf9CgQFFs0FTGG4N6gZ5LgPl49QD0UrVRUZrdatrjFwv4qRGrfBfsHg/fQZ1lm5
         ujcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716940466; x=1717545266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e000vksGZKxcpTxpZnBmsIz0xFc2hPH9avlD+baB/tQ=;
        b=r1PPgVoPdKXkgB82MuXxI9YZFhaBNMMixf0EV42x1ZN6mZsMIUNI8RYgw7fsoGOthO
         RvlRw4FtyAy4PWCYSVAdGdzXF90CAs4VP5/fL2Gr6iVTQfn2cZ4S0+hQnwcYnhEtFumg
         cgc58PLeUi+i2DaktYCoQ7AwIh5fMPcYpYd9Og4jlq2GmxZlbzuOcyzDQJVoSRZeDrE0
         sl3Gb8rtuaargRKIErAcC1Yc0TVjZCKj+hmdO6+pFB+KhTZLNOIpeT4iZf/QorUiBIaL
         zmo3HDVXTvWk/wQDKBT9nlsLZi5SwmvZuVD0WtXf1jkEqFtGpHlmdis+Yw8NKYDoKGLy
         2Jww==
X-Forwarded-Encrypted: i=1; AJvYcCVhdDETGqt3b477Ec5SACx2yChYm9/roh4Y2Qymf84/HGaOXAjPIBojvGW21uy0QPe6yuJ5rXX0sytt7PCQUG74TjkT5yAOG7huh69IBvgTX/96j37GSEKiCfBcOU9sOQVcDADC1BMMgCnEen6oIRMmjGQD61eU198QC96ymLfeiqu+lg==
X-Gm-Message-State: AOJu0Yw2Gvq8OJEkCQd5q4XIlNiKlLTq6gY/6fFDupMBahKpJWgRN486
	oixhYusHzw//sydavnPVws8IBGXV/C01JqMfu+JyrJkc3uXKupO2
X-Google-Smtp-Source: AGHT+IHsWsOkBOksuCIUt51kqHsxAps4Tg6mOyc5noJl3q1Tf55mM9iZjLhMWu87KAeA5fz6kMcg+w==
X-Received: by 2002:a50:9b12:0:b0:572:67d9:3400 with SMTP id 4fb4d7f45d1cf-578519ba232mr8723411a12.39.1716940466319;
        Tue, 28 May 2024 16:54:26 -0700 (PDT)
Received: from andrea ([151.76.32.59])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57852339fc4sm7658198a12.15.2024.05.28.16.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 16:54:25 -0700 (PDT)
Date: Wed, 29 May 2024 01:54:21 +0200
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
Subject: Re: [PATCH 2/7] riscv: Implement cmpxchg8/16() using Zabha
Message-ID: <ZlZurXUUUfXHZJaX@andrea>
References: <20240528151052.313031-1-alexghiti@rivosinc.com>
 <20240528151052.313031-3-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528151052.313031-3-alexghiti@rivosinc.com>

> +zabha:									\
> +	__asm__ __volatile__ (						\
> +		prepend							\
> +		"	amocas" cas_sfx " %0, %z2, %1\n"		\
> +		append							\
> +		: "+&r" (r), "+A" (*(p))				\
> +		: "rJ" (n)						\
> +		: "memory");						\

Couldn't a platform have Zabha but not have Zacas?  I don't see how this
asm goto could work in such case, what am I missing?

  Andrea

