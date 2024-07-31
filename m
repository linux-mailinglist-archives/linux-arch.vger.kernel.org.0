Return-Path: <linux-arch+bounces-5781-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D929433F8
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 18:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7E6BB22F24
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 16:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46781BC06F;
	Wed, 31 Jul 2024 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="TNEjvtAf"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAD91BBBD9
	for <linux-arch@vger.kernel.org>; Wed, 31 Jul 2024 16:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722442490; cv=none; b=lF3z5HLmAVZ57yKg1bRvaDn319+46eksIf+GX6W9PEJVm22UFnwszX7TXtbh9/r4h+4UetYu748r0QZX3x9ZDLBhNJnutI0eFEcRl3YqBKl1h8hnqhecwzI1vFBauJUCh/yg9otpcHi+0WmrX2v10LOpp2eWby+5+iF9OyJ/6KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722442490; c=relaxed/simple;
	bh=cNmf4hLHtT750pA4+kUwJFpSQGwrs+yeu83m+UjRIKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDN1WIH0iYxyMP5sNhyJsIfxBauqGDSvpoBiW4tdK8T0EOg9WyoiY8/ZUtLZCgsf8S/OhUv5jGliPScGLCujcUo9CcrG0IT5zzHiH7xdKvLAWCG6e3igseJlZiDdGSb9KLEM3UXHPqv9VsXUbMGW7pUNvccnw7PiFy30uLv2gVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=TNEjvtAf; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52f01993090so9089770e87.2
        for <linux-arch@vger.kernel.org>; Wed, 31 Jul 2024 09:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1722442487; x=1723047287; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=67YJB4t8a3rStJX7eamZLcHUt6OpExFZ1HW0neqY3tc=;
        b=TNEjvtAfiXB59yP8d9MNytBR4BC6wS4j4CLxEWVfx7ztJz8FCRhuLcsCS/ffejOuDx
         vXq+S7MwvTWPWd01WawevthYB8DX3advZL805A2Yj18bF3ph0guCrlCJvYEOkj+tOl/c
         +utLdNFVKnXxHXRqt1+uKT26OjUanUSPEjOLTuhiSHhHGxRT41vN38fFUGjB/EhofBWM
         MCW1TMxwBjW6Z9IJl6+3vNkop5Fg5A+mTMBP9P1Q5ctW55DjPkjX/31tAhZKh96OKnCX
         7W/tvOFp9K0AG053j/IGSVvU8v79erAt+Ln1yUmdgR0Zrm6gUUMSKlmTcxhzSmPuUsaD
         r+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722442487; x=1723047287;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=67YJB4t8a3rStJX7eamZLcHUt6OpExFZ1HW0neqY3tc=;
        b=YgT6lSs7CJYuwbFWHKjfWdBYI2/7rbh2IJ0uyA10DOkue50LXNeoTdPTtdCTc+yAzm
         XydUzB78Cg2oZvjtT5A+MZ0zmKMJ/XXnm0+BTP3KAOYVp8PRNqJAiu9IiSrdIGVnY+S0
         0v+R6ZXVKZHaVGJpBYIUvHdi8jWgTEHGmPmv2M9ikbW6Gzg55UUYYT8KOY1m1w39CxP8
         g7K0dyfs+Uq4F/AIF3H0wsv2Irk3VI7ay0sBOtD7loIjVmbmqNdRugmrZvzzDljg/wNn
         jXAfaXZ+24x4chi3F+1/wqEADymrlntARMDweKK97kuTr30EEFK97NA3BftYynM9LFHW
         +rsg==
X-Forwarded-Encrypted: i=1; AJvYcCXZu9j23M+sAfNOqzKnr1DZ99yThycaGMahz3VQaX0/oWQT1uQMOUBCWBDHKE2KQ2Vpf6rNYwFONG4FdSyU+ZpSJvk2uYBrq+/m6g==
X-Gm-Message-State: AOJu0YyWAw52IZpPKWd7y80Ksko9osfy+xDvKZ4XclCCyxCblkhX+5vl
	nedHLz7Eu3zD/r73ORkFSgLZzVyFRsEkAxXexYkZa00+5sTr9Z+Vd5n23eizSWQ=
X-Google-Smtp-Source: AGHT+IGOSG7HPoKuH/nQ4CZs4W9P+Dy9DzwopPIOkIR/omN2X/bNWde8qWGEJwuhDElsEfYRrR40NQ==
X-Received: by 2002:ac2:5b0f:0:b0:52c:df6f:a66 with SMTP id 2adb3069b0e04-5309b2c5c91mr8627043e87.58.1722442486580;
        Wed, 31 Jul 2024 09:14:46 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad41616sm785979066b.137.2024.07.31.09.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 09:14:45 -0700 (PDT)
Date: Wed, 31 Jul 2024 18:14:44 +0200
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
Subject: Re: [PATCH v4 02/13] riscv: Do not fail to build on byte/halfword
 operations with Zawrs
Message-ID: <20240731-676154f31336c78bafea57d0@orel>
References: <20240731072405.197046-1-alexghiti@rivosinc.com>
 <20240731072405.197046-3-alexghiti@rivosinc.com>
 <20240731-56ba72420d7f745dacb66fd8@orel>
 <CAHVXubjrrWVnw1ufXRJh_5N9M5UiOVZseb0C78fjLaYhNKF7eA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHVXubjrrWVnw1ufXRJh_5N9M5UiOVZseb0C78fjLaYhNKF7eA@mail.gmail.com>

On Wed, Jul 31, 2024 at 05:52:46PM GMT, Alexandre Ghiti wrote:
> Hi Drew,
> 
> On Wed, Jul 31, 2024 at 4:10 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > On Wed, Jul 31, 2024 at 09:23:54AM GMT, Alexandre Ghiti wrote:
> > > riscv does not have lr instructions on byte and halfword but the
> > > qspinlock implementation actually uses such atomics provided by the
> > > Zabha extension, so those sizes are legitimate.
> >
> > We currently always come to __cmpwait() through smp_cond_load_relaxed()
> > and queued_spin_lock_slowpath() adds another invocation.
> 
> atomic_cond_read_relaxed() and smp_cond_load_acquire() also call
> smp_cond_load_relaxed()
> 
> And here https://elixir.bootlin.com/linux/v6.11-rc1/source/kernel/locking/qspinlock.c#L380,
> the size passed is 1.

Oh, I see.

> 
> > However, isn't
> > the reason we're hitting the BUILD_BUG() because the switch fails to find
> > a case for 16, not because it fails to find cases for 1 or 2? The new
> > invocation passes a pointer to a struct mcs_spinlock, which looks like
> > it has size 16. We need to ensure that when ptr points to a pointer that
> > we pass the size of uintptr_t.
> 
> I guess you're refering to this call here
> https://elixir.bootlin.com/linux/v6.11-rc1/source/kernel/locking/qspinlock.c#L551,
> but it's a pointer to a pointer, which will then pass a size 8.

Ah, missed that '&'...

> 
> And the build error that I get is the following:
> 
> In function '__cmpwait',
>     inlined from 'queued_spin_lock_slowpath' at
> ../kernel/locking/qspinlock.c:380:3:
> ./../include/linux/compiler_types.h:510:45: error: call to
> '__compiletime_assert_2' declared with attribute error: BUILD_BUG
> failed
>   510 |         _compiletime_assert(condition, msg,
> __compiletime_assert_, __COUNTER__)
>       |                                             ^
> ./../include/linux/compiler_types.h:491:25: note: in definition of
> macro '__compiletime_assert'
>   491 |                         prefix ## suffix();
>          \
>       |                         ^~~~~~
> ./../include/linux/compiler_types.h:510:9: note: in expansion of macro
> '_compiletime_assert'
>   510 |         _compiletime_assert(condition, msg,
> __compiletime_assert_, __COUNTER__)
>       |         ^~~~~~~~~~~~~~~~~~~
> ../include/linux/build_bug.h:39:37: note: in expansion of macro
> 'compiletime_assert'
>    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>       |                                     ^~~~~~~~~~~~~~~~~~
> ../include/linux/build_bug.h:59:21: note: in expansion of macro
> 'BUILD_BUG_ON_MSG'
>    59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>       |                     ^~~~~~~~~~~~~~~~
> ../arch/riscv/include/asm/cmpxchg.h:376:17: note: in expansion of
> macro 'BUILD_BUG'
>   376 |                 BUILD_BUG();
> 
> which points to the first smp_cond_load_relaxed() I mentioned above.
> 

OK, you've got me straightened out now, but can we only add the fallback
for sizes 1 and 2 and leave the default as a BUILD_BUG()?

Thanks,
drew

