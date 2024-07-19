Return-Path: <linux-arch+bounces-5515-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E0B937588
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2024 11:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1574F28209A
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2024 09:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B4277109;
	Fri, 19 Jul 2024 09:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fNjwIbjN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F0957CBC
	for <linux-arch@vger.kernel.org>; Fri, 19 Jul 2024 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721380306; cv=none; b=elAIxehmUFlbXG0qab7BLbnGPeMCqT1Z56nPIOiX9d1tn5KP425kKGSrg+WC3yd5ww2H55YLhVuWIHhHSlpkGpJE3UXGYcZu3gTUJQcgpDyUyAK76FG3VfJOYssNRBRYwBD8/qykefowuZ2IIz6bsD74Ql45FYppG6UBlT78bWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721380306; c=relaxed/simple;
	bh=zSLuKaN+gBA5/2qa6gHM65PDw7SxQxl6CWR+d4GMVCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mxEePdGgubYCA4D47QKV27w1/28xRhnLBMePq3vASxd4ZQN7NZ4qxB7M7IgODCLiBthV1ayt4YLM3vfQG6GwCiYZeUMCuTedUa8MlkU3nuOv07pXmx29z+GY4rvtpqHhyl0iAMrr17yPpeE9acL5Jdtk/wBZigZXSLde9n2GohM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fNjwIbjN; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a10bb7bcd0so905275a12.3
        for <linux-arch@vger.kernel.org>; Fri, 19 Jul 2024 02:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721380303; x=1721985103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLucreB4C7Cq/x6iCkzClVthNh5Hb9jZ55GIvzS0dF8=;
        b=fNjwIbjN9aI1n/fU/uuIOYhXZbN3YDZy11mPKTwmXrdS+pk8/GvOUgQ/1LUOXQeNH6
         jGrXie9odqUYzeX37Wqw8Rp1yN8hyBRNXgzZHry85L0SOqMToUUkSPJkyiFFDKXu+oP5
         u7tk0Wv+MOwCbg5/ud78w+JyaKe2Nw/u2yq2Lv3/aqMISmgtxiODR1kn4Y2x66WIBluX
         c+wiqptc9TDvqGjh9Na0IFquZrMgLAL2n+GnBtXwv17mh1zBwKRzUHegCpIF9Zc3V1ju
         47A6WH6KmT62T2WF1N1UneLWpUphv8ZTLbF8UGEvjrjX9qwosXrIiifMKnXZ/HJq6tJg
         /8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721380303; x=1721985103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLucreB4C7Cq/x6iCkzClVthNh5Hb9jZ55GIvzS0dF8=;
        b=pv9hLu8AvBgNOEAL20hX4+JVCCnZ0MhmJ00cd99PgOk2b1o18e34iz+Pq5ySrge8bX
         5WsrP2PZA2WQLpkXSBOWAB/exzPOvQBzIwug/Wy4CjT9RSy6g7koI+npRGOglxCxwnDk
         0/Iw5kCCo7JTVcz2JFi1tQf/jo6nWgGj+a0GJDfpXnQgbdNZDrzW1VwAqrtUffSF48wD
         NPguN88hyer38kbZakpDHuWMXlIxpoNQ2+novplViB7pa4NGvgrPcOszDUEU8Z9LBH2A
         nMrfKRO15kNT3d2Y5k+zRC6VWmsk1Lt3Ivc128a8TuMIIEbkdFdyeVjLuNMQYTCP9dKX
         KXyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX7KdSEApoA7U+NoJnAsML+Q7i8xKveRQM+ozaOmDWUMtWkc/cHkW5t4n4+4mXMKaDnZCv9woxYE1Jlte6zgjfN+1CjSuZbS7/Hg==
X-Gm-Message-State: AOJu0YxaAEGWeeeRFAGfNOLr5KdG3ha1x5/Rue5aWBWnKdKravPK/IMp
	ay/ccKQKRPBdY4Om085eGcuAArZdFSj9z1Kt/7QmhB0mVUTK/GlweeQMXOh2EWy8l1mQF4Qz+E6
	6ds/c0bWxirEhTg94V13Rf8Ov1CFsnp7PS6rkMg==
X-Google-Smtp-Source: AGHT+IFO6hf+5HOcO5Mu3nZVEBJhdhYQsXgwhq2XadyFC/SlzZiV7DtJ0QY08kz7HxyLbxCqNNPbNHwc+UPc/5DYNsY=
X-Received: by 2002:a17:906:bb0b:b0:a77:c8a8:fd71 with SMTP id
 a640c23a62f3a-a7a01192e56mr514488966b.32.1721380303298; Fri, 19 Jul 2024
 02:11:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717061957.140712-1-alexghiti@rivosinc.com>
 <20240717061957.140712-10-alexghiti@rivosinc.com> <da5ba38a-8848-439e-b80a-3d6584111a78@sifive.com>
In-Reply-To: <da5ba38a-8848-439e-b80a-3d6584111a78@sifive.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Fri, 19 Jul 2024 11:11:32 +0200
Message-ID: <CAHVXubiUfyPJtTzhm2N7yuv6CPqdDvL+Lm3Fq=8XT=gn77qPMA@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] riscv: Add ISA extension parsing for Ziccrse
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 2:53=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Hi Alex,
>
> On 2024-07-17 1:19 AM, Alexandre Ghiti wrote:
> > Add support to parse the Ziccrse string in the riscv,isa string.
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/hwcap.h | 1 +
> >  arch/riscv/kernel/cpufeature.c | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hw=
cap.h
> > index f71ddd2ca163..863b9b7d4a4f 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -82,6 +82,7 @@
> >  #define RISCV_ISA_EXT_ZACAS          73
> >  #define RISCV_ISA_EXT_XANDESPMU              74
> >  #define RISCV_ISA_EXT_ZABHA          75
> > +#define RISCV_ISA_EXT_ZICCRSE                76
> >
> >  #define RISCV_ISA_EXT_XLINUXENVCFG   127
> >
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeat=
ure.c
> > index c125d82c894b..93d8cc7e232c 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -306,6 +306,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D=
 {
> >       __RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
> >       __RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> >       __RISCV_ISA_EXT_DATA(xandespmu, RISCV_ISA_EXT_XANDESPMU),
> > +     __RISCV_ISA_EXT_DATA(ziccrse, RISCV_ISA_EXT_ZICCRSE),
>
> Please sort this entry per the comment at the beginning of the array.

Done, thanks

Alex

>
> Regards,
> Samuel
>
> >  };
> >
> >  const size_t riscv_isa_ext_count =3D ARRAY_SIZE(riscv_isa_ext);
>

