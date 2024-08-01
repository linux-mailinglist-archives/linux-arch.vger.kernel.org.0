Return-Path: <linux-arch+bounces-5824-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CF094447C
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 08:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1C7C1C2237E
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 06:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38C615747D;
	Thu,  1 Aug 2024 06:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="VALmha5B"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745D7142633
	for <linux-arch@vger.kernel.org>; Thu,  1 Aug 2024 06:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722493872; cv=none; b=nK/y3GcmciJztlkR1CfDuzLSD5JRAOoIuEXeZT8QVY9aYZ7LcmoE+3NkG7CqCZ6ctjdhXTeCmnyYJb4RzPs8sk0d7FWcKlxg+5XidG3nbZE2LMv6stnCAMD8lwrjQGGelRrsHZC7DWGiftFWSssQxkogu7YbXgu26WYZcKs0yV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722493872; c=relaxed/simple;
	bh=7hiJyExXsvFNCdkfgjNWRGOg631lI6JSQvQdwmfuouM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nAPJY1NFiW6qs9tb3P4h6nMVEfPUSvur1DmXVwF2Et3/daaWpVMsHzi57/YvWGNS0Phh+VxARRKhb0PdUqFLslEDhDOhGe06THbLXY86UxmYB7+qGwdqO1CAZYz3hoGP9TKmJwBhicyVPPn68e1sf5sj+iNWzhD+aeYodMA8q8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=VALmha5B; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7a9a7af0d0so858664366b.3
        for <linux-arch@vger.kernel.org>; Wed, 31 Jul 2024 23:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722493869; x=1723098669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZtgOTmyz4Jo80Ebg+IqO3Y085ck8x5IgntpNpkonWA4=;
        b=VALmha5Bcnc4scaHYy4MfF03OrZ/0QOC9ADGxSUAzewwtE/8Su20rgbwuAXxmveG2O
         qop0Vc1I7nId+O64sPmvb2rqq9s6bmJK7jvoB6SMpVWwpzPOHRHtAnTnxImjNZ9fmWBJ
         rvkZDceJfpSoRpPnkAdh9tVtd9+54J3pmYn2K/QjX7tnjhg9Z7m+B3AYlGM6lXzlmON2
         TyW/8yEI7M1zQn39+oRLL6VxlWwGiEGSWXc+mP3EAbypNHvr0uN3i4U2PGWReedza8Lx
         gVQBsQe87d2UCd+eJxjo3ZlTFOxH3lcBOfPlgDVlsFOjct0lCTC0I5u3eBzgi1x4QU9F
         mOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722493869; x=1723098669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZtgOTmyz4Jo80Ebg+IqO3Y085ck8x5IgntpNpkonWA4=;
        b=i3//R6qaZ4T1XZA0cUSvBzNnHexJFaj7JNxlzc4DKxszsrDr1O07h7SqHBkyXbxYa4
         HpbFMZ00hbmF/CSsFfKJE0kc+uF9wH3PWk9ow+33qCpgpijDxzhnP4k9MDMuQV6IhYn0
         u+gVUNNDs2I2L2pOurCXLFMBuJ9TqPoa6YahwMYjCjgzG5gi6WuxJ5gMpqq/I68ldo42
         rtCNyocJT3pVipyscnMjQbo9fURAJh8YPkwl9jdg54lZ3mIMQTQqSHc38xJlCUHvtEbk
         1MmKswGJoaJ6aXd8LEpvws9Z+g42Ec8pcA9OEm2oPAhDff1kX4bZ/GN7tyqrUgZSCEYh
         NpaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrX5rBGzBWA7Yy5hzs0tbJ0VCLbH677NubmtYqidCWY5ESXiz5DM6VF9EE/KNp5CutJsYFxJEGL6zF7HKcxPI0r0BiUZV3zslVmA==
X-Gm-Message-State: AOJu0YyADXU6M/mB9s9ilEFzVo6MJwkQk/FIVK3FOUvhMtqZsOTB7Jr2
	FpTyNV4aYnwdp/Xh/BtJjX1YBBiRcU1lZN6bp9CzLeyvA1vZMxp0nc4uxBDspHimTdbBL7/IQwi
	T3/B4WjxSsPIRuBDQxwheET3Lw3QF/XGKdhv6KQ==
X-Google-Smtp-Source: AGHT+IGCKaJ30FgEU9oUZBdt1y3mH+iUXfyse7Ifs2EUpNCPkcgPwDdhg+BBqKki8Uxjaui4Z+qh19h6sLlMzePfjC4=
X-Received: by 2002:a17:906:ba82:b0:a72:8d2f:859c with SMTP id
 a640c23a62f3a-a7daf562837mr70124066b.33.1722493868606; Wed, 31 Jul 2024
 23:31:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731072405.197046-1-alexghiti@rivosinc.com>
 <20240731072405.197046-3-alexghiti@rivosinc.com> <20240731-56ba72420d7f745dacb66fd8@orel>
 <CAHVXubjrrWVnw1ufXRJh_5N9M5UiOVZseb0C78fjLaYhNKF7eA@mail.gmail.com> <20240731-676154f31336c78bafea57d0@orel>
In-Reply-To: <20240731-676154f31336c78bafea57d0@orel>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Thu, 1 Aug 2024 08:30:57 +0200
Message-ID: <CAHVXubhUVi=Ryc4fF+7Z12h7p1aQtVwHfD6YGfw676aijjw5Rg@mail.gmail.com>
Subject: Re: [PATCH v4 02/13] riscv: Do not fail to build on byte/halfword
 operations with Zawrs
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>, 
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 6:14=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Wed, Jul 31, 2024 at 05:52:46PM GMT, Alexandre Ghiti wrote:
> > Hi Drew,
> >
> > On Wed, Jul 31, 2024 at 4:10=E2=80=AFPM Andrew Jones <ajones@ventanamic=
ro.com> wrote:
> > >
> > > On Wed, Jul 31, 2024 at 09:23:54AM GMT, Alexandre Ghiti wrote:
> > > > riscv does not have lr instructions on byte and halfword but the
> > > > qspinlock implementation actually uses such atomics provided by the
> > > > Zabha extension, so those sizes are legitimate.
> > >
> > > We currently always come to __cmpwait() through smp_cond_load_relaxed=
()
> > > and queued_spin_lock_slowpath() adds another invocation.
> >
> > atomic_cond_read_relaxed() and smp_cond_load_acquire() also call
> > smp_cond_load_relaxed()
> >
> > And here https://elixir.bootlin.com/linux/v6.11-rc1/source/kernel/locki=
ng/qspinlock.c#L380,
> > the size passed is 1.
>
> Oh, I see.
>
> >
> > > However, isn't
> > > the reason we're hitting the BUILD_BUG() because the switch fails to =
find
> > > a case for 16, not because it fails to find cases for 1 or 2? The new
> > > invocation passes a pointer to a struct mcs_spinlock, which looks lik=
e
> > > it has size 16. We need to ensure that when ptr points to a pointer t=
hat
> > > we pass the size of uintptr_t.
> >
> > I guess you're refering to this call here
> > https://elixir.bootlin.com/linux/v6.11-rc1/source/kernel/locking/qspinl=
ock.c#L551,
> > but it's a pointer to a pointer, which will then pass a size 8.
>
> Ah, missed that '&'...
>
> >
> > And the build error that I get is the following:
> >
> > In function '__cmpwait',
> >     inlined from 'queued_spin_lock_slowpath' at
> > ../kernel/locking/qspinlock.c:380:3:
> > ./../include/linux/compiler_types.h:510:45: error: call to
> > '__compiletime_assert_2' declared with attribute error: BUILD_BUG
> > failed
> >   510 |         _compiletime_assert(condition, msg,
> > __compiletime_assert_, __COUNTER__)
> >       |                                             ^
> > ./../include/linux/compiler_types.h:491:25: note: in definition of
> > macro '__compiletime_assert'
> >   491 |                         prefix ## suffix();
> >          \
> >       |                         ^~~~~~
> > ./../include/linux/compiler_types.h:510:9: note: in expansion of macro
> > '_compiletime_assert'
> >   510 |         _compiletime_assert(condition, msg,
> > __compiletime_assert_, __COUNTER__)
> >       |         ^~~~~~~~~~~~~~~~~~~
> > ../include/linux/build_bug.h:39:37: note: in expansion of macro
> > 'compiletime_assert'
> >    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond),=
 msg)
> >       |                                     ^~~~~~~~~~~~~~~~~~
> > ../include/linux/build_bug.h:59:21: note: in expansion of macro
> > 'BUILD_BUG_ON_MSG'
> >    59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
> >       |                     ^~~~~~~~~~~~~~~~
> > ../arch/riscv/include/asm/cmpxchg.h:376:17: note: in expansion of
> > macro 'BUILD_BUG'
> >   376 |                 BUILD_BUG();
> >
> > which points to the first smp_cond_load_relaxed() I mentioned above.
> >
>
> OK, you've got me straightened out now, but can we only add the fallback
> for sizes 1 and 2 and leave the default as a BUILD_BUG()?

Yes, sure, I'll do that.

Thanks,

Alex

>
> Thanks,
> drew

