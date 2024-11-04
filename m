Return-Path: <linux-arch+bounces-8830-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D2C9BAD01
	for <lists+linux-arch@lfdr.de>; Mon,  4 Nov 2024 08:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A4662821C9
	for <lists+linux-arch@lfdr.de>; Mon,  4 Nov 2024 07:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AAD18FC7C;
	Mon,  4 Nov 2024 07:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mo9Ub8eH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB5A16190C;
	Mon,  4 Nov 2024 07:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730704410; cv=none; b=mO+E5wP9pUZRuGqCWHO1CAI6FNwk+gyAPMN70PFhVyOvO/VV4OySGxUavXrjrSUELoj66H3bvdBV+DoYY8DlHVKf4IZqk1RHgylacrxaqRQiz0RWrYrXiOP2FLk359K+AvS0xyg5G7SAdob8568HsNvMN0XwENex8esvBL7T8eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730704410; c=relaxed/simple;
	bh=DN/aF0Rx4q9nI31XFvXVTZjHeGK8s9mBhUmgHGiPmzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guhqgMAx5k4bw1WaSa/SW4cg6bMmhDG1su8IAD8O+/V2nTvgDdde0HTF3I6QQ//9rJZLL40XHCDnJmESMVuIiHdKjlf+4DjLloFWRb8Nqk1RSYzp5TzBk0HtttHMU3GQ6+lg1aC1bLI4vWNhCxR0oFi7cZuff3p2AJnl5dmF3Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mo9Ub8eH; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a6acac4c3so643404366b.0;
        Sun, 03 Nov 2024 23:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730704405; x=1731309205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oImu3BDF6/CvLBQLJIYfDXK8FedxePSyT6Ukp32htEU=;
        b=mo9Ub8eHYdATvuFWLQr5hn53hxa1f9PiBuG1DD3fcQizsui8pbGSzDR/b+ZQdGOwha
         Xkvk0rksu66TehULO60rnGJwrnN9dtLpCpuT1nDXXA39NKtrZjTSJQaOv6H6vxal4Q1v
         egm4/L7MzxpwS2mokRvEPscGHjEw3XcPLPw3W5MJEHheY5FkEjwFTAoiGk5AYDKYPhNw
         nmf1eiLE19PnZBM8qKd6UaMArJLHJftFliOK54VZu7AeaubT7V9Qyp+hQOEWgVFZan3t
         D1hxqnZuFY/cbHBAAk8PdhS2sjpTmQNIL0C3VUjjHW8BBwsAxJfa02byYvabwRfJZcGl
         o1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730704405; x=1731309205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oImu3BDF6/CvLBQLJIYfDXK8FedxePSyT6Ukp32htEU=;
        b=s8ASBoAemmBHRkfFf0bM7fZCNCgVE/ifcWMmUBjQl/rmXDHLOEaYrxJ8KJJOhHfQ4y
         MSh8okNk8B9zw01c6nFGJiVYb5ydNflGZvWIejGLjA2LY8L21nN2wCMv+mcklM1gMnUK
         O1BCd0IfrCxKuJUuB8kt7rz89+dKkkEkvemPVG9oBl3hj67qlp5kn2EyGv9dWqdlQAOo
         dKpgUFZOO24TyI0soIGYYhMrFS4ou8zxgb0q8ZuOdU8lD+XHScxPlwtGwySj4iJB29HE
         Q7kfbSp+kw1HW9ZJ593kuBC2CZGzZGAdJj14RhphVvfY5H2QcvX6r3zXqQFOWxUKbgV/
         kYhg==
X-Forwarded-Encrypted: i=1; AJvYcCVo/5Gt7wxuWF6QVpQjskVjzz/PemGJHOdyroAGD+b1GxQaJpno1djLrMORIX4pITmwuNM7f2FXuI/uOJJv@vger.kernel.org, AJvYcCWeIVfCQ3w2WS/gltI76TzvPQKuVK2S13VkdMM/MjmCtZdd+H766RMsyolFX1zN4Io3/IRvCJWXJcU1@vger.kernel.org, AJvYcCXUh7rO896DaGbdUu8Y8BOKvTPN5VgOTG2hENbWKXId7vQGpr1s5QrXJJ/HN0BkoxuHgCL7B9y+l+XH6A==@vger.kernel.org, AJvYcCXXOISnPkXWicRVtPb3mgJ+wl4B5VGRj0P30dY/3/6mdCmdbxP+OS5TT2BLjiTcb31Z4xta+s30tha7@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5CviZLtf81oLFCPehM97rlrHzQ3rAa6TwDjpMHYe/P6azLvlU
	dLMaFenQH9olONfYZ01k8IFoIUxb4GQ1SChHmZar55qdpbTd6x0r
X-Google-Smtp-Source: AGHT+IFYIQZXhx+OysSO0fTZLSwThb7s3X8HqjAw+0oYmWSu9pnc41l1DW5ZVPldKXfAb5lkarCoEQ==
X-Received: by 2002:a17:907:9815:b0:a9a:9b1:f972 with SMTP id a640c23a62f3a-a9de61cf153mr2820354366b.40.1730704404610;
        Sun, 03 Nov 2024 23:13:24 -0800 (PST)
Received: from andrea ([2a01:5a8:300:22d3:2aa3:fe1f:17f7:f982])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e565e09bcsm513885466b.126.2024.11.03.23.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 23:13:24 -0800 (PST)
Date: Mon, 4 Nov 2024 09:13:19 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v6 00/13] Zacas/Zabha support and qspinlocks
Message-ID: <Zyh0D9N8SgQd_zne@andrea>
References: <20241103145153.105097-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241103145153.105097-1-alexghiti@rivosinc.com>

> Alexandre Ghiti (11):
>   riscv: Move cpufeature.h macros into their own header
>   riscv: Do not fail to build on byte/halfword operations with Zawrs
>   riscv: Implement cmpxchg32/64() using Zacas
>   dt-bindings: riscv: Add Zabha ISA extension description
>   riscv: Implement cmpxchg8/16() using Zabha
>   riscv: Improve zacas fully-ordered cmpxchg()
>   riscv: Implement arch_cmpxchg128() using Zacas
>   riscv: Implement xchg8/16() using Zabha
>   riscv: Add ISA extension parsing for Ziccrse
>   dt-bindings: riscv: Add Ziccrse ISA extension description
>   riscv: Add qspinlock support
> 
> Guo Ren (2):
>   asm-generic: ticket-lock: Reuse arch_spinlock_t of qspinlock
>   asm-generic: ticket-lock: Add separate ticket-lock.h

For the series,

Reviewed-by: Andrea Parri <parri.andrea@gmail.com>

  Andrea

