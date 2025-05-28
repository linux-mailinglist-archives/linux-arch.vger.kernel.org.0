Return-Path: <linux-arch+bounces-12127-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4BBAC68B1
	for <lists+linux-arch@lfdr.de>; Wed, 28 May 2025 13:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4AE47A2963
	for <lists+linux-arch@lfdr.de>; Wed, 28 May 2025 11:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF9610E3;
	Wed, 28 May 2025 11:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rijkq6tL"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BF7283FC7
	for <linux-arch@vger.kernel.org>; Wed, 28 May 2025 11:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748433514; cv=none; b=sbk8AnEUYX1qCmiFsAAu9FWXL0MtKpykWRuYRnbe7zRaFjPZHJb6fJw84xhUDY7Nqngux247bUYe61D859vatqG+h/1fLc4LOiO+kM6JYYDHDRyc6VEaw5JEf2t+14lla9ykomkPa8L6Ee3Ce4Pjc9aABGo92bKBCtFxH3MxU0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748433514; c=relaxed/simple;
	bh=uqLfNCsPFReS3TjBwcJGNhZ7jyyK/I/7U5AD7S57Ihw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hzK8cXvFNeHQWY2C5m0FFxAeac9nA7Dt0C4oOsIHZG8zKCxII65YSdReA1cQ8nwfm497SQ0f3ULH8vN2F+jVXgr5B4TOBvQJpGuTo4isd0D4WgJgCUvNQo8Ttax1EO/Mb9M72Toexqn5/l9pjQMJo+nVyD2c8eomA9tbep5N2Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rijkq6tL; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6024087086dso9445a12.0
        for <linux-arch@vger.kernel.org>; Wed, 28 May 2025 04:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748433510; x=1749038310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2XUtX4SPu9qwcGqv2AmbcDuaO05VPiEnKxAStG2Rco=;
        b=rijkq6tL9lLaGdLs9DyhH9TWIkf59RmIGBuut720G317CD2929a8/rtOd4lw9fNQCJ
         jdTJ9TGgjmpZZEMjYBD5FGfQFMWeHPJxTUevZ34wxjgIKFCg2KunoVduh4xzo6Wvc7GH
         iPkIZzsmWbq26nUnvYcb3sZemKhgcIWSV/hFyK3JRDdpA/LsCAuTIXWWDP6AmKpwgTHs
         qX8sQQlHO55LSeXqbd1zoJHHNr7xFLw0DmaoSAyvVk+PTLcNmiR/vZ5Go8E+apjoTzLI
         pzlJ22TVXkAolpJRRQaW3UFpmfgM09kp4E3/peqOl5NCUk2KYcWW7h0oq6tsEih0xAEf
         X4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748433510; x=1749038310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2XUtX4SPu9qwcGqv2AmbcDuaO05VPiEnKxAStG2Rco=;
        b=kqECfEMKd7Kz03McVsdFdCaF5jFIAIRE2jrIzaeY5LzRcAjzN8Z5ZbfFP+2MEQoT2Y
         Wn5v9ee3dq9kN6gGv8pueHnU+MfBsX2SdyenHlhdmIFlV5Sjl2jiS2m5et6g7xkwzdaD
         VY97B7pWXr7IaTtuU5ic94ls6evjOpRUY8KF/S3osnIx7n9ksbsql4YRTvOFV02M9tsy
         8A+utQoimJ6X8RMWlGXgajvDite8aGoD1TedPzpiSrhqUzxw3AE1ZV/ZraMHcUv2/lMt
         Gczn/KyEi5XPpN7I8kwq+OWV+aJOD3OYlRhkU2Nu6ie1BMo+z/QFieTeGxBqFVwYe2kS
         k+5g==
X-Gm-Message-State: AOJu0YxB6ZN6QDBwH1YoN+XA3ODrE20MtQaSvKIHIUihUmOnErM/KzEL
	AkUr32GgBBkBblIPGNd1MRjCBCX7GWmtFURoq9QYd0MkmmV0+l8MyOJJaWxGpmVlnbWwQ7LOhdj
	1ipj73L99eZdZfmCp2236wrADf5YBto/bxLLHvyCPiIdfXXaAyhl5bGM7
X-Gm-Gg: ASbGncuYdu0yLEq/jKMkPGodbhJxxu2hM1eHa8V0A+DKAmDpJXJYAh2uTECyMDfnhrM
	S6fRKmG+7uErifng3OT62UH5lJ8ajBGPU9aomzj9tAl9mMeCbGF/Q+ch0SNJveab4ug1xuwyk5m
	ky1uHbj4qaMloPDLp+aEjpJ9ALicy6tfl916VQihnP4Q==
X-Google-Smtp-Source: AGHT+IFIDhE8NDO8HZc/OxZa5KJm1C4cQJpwlrXfKSGcZ74HDROn8Cm5Lq7/g16dzpxYshqRL9DDapgwSen9QTHMZo8=
X-Received: by 2002:a05:6402:2073:b0:604:5e64:71e6 with SMTP id
 4fb4d7f45d1cf-60514c5f26fmr92019a12.0.1748433510015; Wed, 28 May 2025
 04:58:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250330164229.2174672-1-varadgautam@google.com>
 <CAOLDJO+=+hcz498KRc+95dF5y3hZdtm+3y35o2rBC9qAOF-vDg@mail.gmail.com> <CAOLDJOKiEmde5Max0BnTBVpNmfpm-wwYLJ4Etv8D2KZKPHyFzw@mail.gmail.com>
In-Reply-To: <CAOLDJOKiEmde5Max0BnTBVpNmfpm-wwYLJ4Etv8D2KZKPHyFzw@mail.gmail.com>
From: Varad Gautam <varadgautam@google.com>
Date: Wed, 28 May 2025 13:58:19 +0200
X-Gm-Features: AX0GCFuns8jdkD0l27QeOARJVlRFwTB64Pnzbon82AMM-80ayFiGO9y62ugQYfU
Message-ID: <CAOLDJOJ=QcQ065UTAdGayO2kbpGMOwCtdEGVm8TvQO8Wf8CSMw@mail.gmail.com>
Subject: Re: [PATCH] asm-generic/io.h: Skip trace helpers if rwmmio events are disabled
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Sai Prakash Ranjan <quic_saipraka@quicinc.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 9:41=E2=80=AFPM Varad Gautam <varadgautam@google.co=
m> wrote:
>
> On Mon, Apr 7, 2025 at 6:13=E2=80=AFPM Varad Gautam <varadgautam@google.c=
om> wrote:
> >
> > On Sun, Mar 30, 2025 at 6:42=E2=80=AFPM Varad Gautam <varadgautam@googl=
e.com> wrote:
> > >
> > > With `CONFIG_TRACE_MMIO_ACCESS=3Dy`, the `{read,write}{b,w,l,q}{_rela=
xed}()`
> > > mmio accessors unconditionally call `log_{post_}{read,write}_mmio()`
> > > helpers, which in turn call the ftrace ops for `rwmmio` trace events
> > >
> > > This adds a performance penalty per mmio accessor call, even when
> > > `rwmmio` events are disabled at runtime (~80% overhead on local
> > > measurement).
> > >
> > > Guard these with `tracepoint_enabled()`.
> > >
> > > Signed-off-by: Varad Gautam <varadgautam@google.com>
> > > Fixes: 210031971cdd ("asm-generic/io: Add logging support for MMIO ac=
cessors")
> > > Cc: <stable@vger.kernel.org>
> >
> > Ping.
> >
>
> Ping.
>

Ping. Arnd, can this be picked up into the asm-generic tree?

> > > ---
> > >  include/asm-generic/io.h | 98 +++++++++++++++++++++++++++-----------=
--
> > >  1 file changed, 66 insertions(+), 32 deletions(-)
> > >
> > > diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> > > index 3c61c29ff6ab..a9b5da547523 100644
> > > --- a/include/asm-generic/io.h
> > > +++ b/include/asm-generic/io.h
> > > @@ -75,6 +75,7 @@
> > >  #if IS_ENABLED(CONFIG_TRACE_MMIO_ACCESS) && !(defined(__DISABLE_TRAC=
E_MMIO__))
> > >  #include <linux/tracepoint-defs.h>
> > >
> > > +#define rwmmio_tracepoint_enabled(tracepoint) tracepoint_enabled(tra=
cepoint)
> > >  DECLARE_TRACEPOINT(rwmmio_write);
> > >  DECLARE_TRACEPOINT(rwmmio_post_write);
> > >  DECLARE_TRACEPOINT(rwmmio_read);
> > > @@ -91,6 +92,7 @@ void log_post_read_mmio(u64 val, u8 width, const vo=
latile void __iomem *addr,
> > >
> > >  #else
> > >
> > > +#define rwmmio_tracepoint_enabled(tracepoint) false
> > >  static inline void log_write_mmio(u64 val, u8 width, volatile void _=
_iomem *addr,
> > >                                   unsigned long caller_addr, unsigned=
 long caller_addr0) {}
> > >  static inline void log_post_write_mmio(u64 val, u8 width, volatile v=
oid __iomem *addr,
> > > @@ -189,11 +191,13 @@ static inline u8 readb(const volatile void __io=
mem *addr)
> > >  {
> > >         u8 val;
> > >
> > > -       log_read_mmio(8, addr, _THIS_IP_, _RET_IP_);
> > > +       if (rwmmio_tracepoint_enabled(rwmmio_read))
> > > +               log_read_mmio(8, addr, _THIS_IP_, _RET_IP_);
> > >         __io_br();
> > >         val =3D __raw_readb(addr);
> > >         __io_ar(val);
> > > -       log_post_read_mmio(val, 8, addr, _THIS_IP_, _RET_IP_);
> > > +       if (rwmmio_tracepoint_enabled(rwmmio_post_read))
> > > +               log_post_read_mmio(val, 8, addr, _THIS_IP_, _RET_IP_)=
;
> > >         return val;
> > >  }
> > >  #endif
> > > @@ -204,11 +208,13 @@ static inline u16 readw(const volatile void __i=
omem *addr)
> > >  {
> > >         u16 val;
> > >
> > > -       log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
> > > +       if (rwmmio_tracepoint_enabled(rwmmio_read))
> > > +               log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
> > >         __io_br();
> > >         val =3D __le16_to_cpu((__le16 __force)__raw_readw(addr));
> > >         __io_ar(val);
> > > -       log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_IP_);
> > > +       if (rwmmio_tracepoint_enabled(rwmmio_post_read))
> > > +               log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_IP_=
);
> > >         return val;
> > >  }
> > >  #endif
> > > @@ -219,11 +225,13 @@ static inline u32 readl(const volatile void __i=
omem *addr)
> > >  {
> > >         u32 val;
> > >
> > > -       log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
> > > +       if (rwmmio_tracepoint_enabled(rwmmio_read))
> > > +               log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
> > >         __io_br();
> > >         val =3D __le32_to_cpu((__le32 __force)__raw_readl(addr));
> > >         __io_ar(val);
> > > -       log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_);
> > > +       if (rwmmio_tracepoint_enabled(rwmmio_post_read))
> > > +               log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_=
);
> > >         return val;
> > >  }
> > >  #endif
> > > @@ -235,11 +243,13 @@ static inline u64 readq(const volatile void __i=
omem *addr)
> > >  {
> > >         u64 val;
> > >
> > > -       log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
> > > +       if (rwmmio_tracepoint_enabled(rwmmio_read))
> > > +               log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
> > >         __io_br();
> > >         val =3D __le64_to_cpu((__le64 __force)__raw_readq(addr));
> > >         __io_ar(val);
> > > -       log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
> > > +       if (rwmmio_tracepoint_enabled(rwmmio_post_read))
> > > +               log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_=
);
> > >         return val;
> > >  }
> > >  #endif
> > > @@ -249,11 +259,13 @@ static inline u64 readq(const volatile void __i=
omem *addr)
> > >  #define writeb writeb
> > >  static inline void writeb(u8 value, volatile void __iomem *addr)
> > >  {
> > > -       log_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
> > > +       if (rwmmio_tracepoint_enabled(rwmmio_write))
> > > +               log_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
> > >         __io_bw();
> > >         __raw_writeb(value, addr);
> > >         __io_aw();
> > > -       log_post_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
> > > +       if (rwmmio_tracepoint_enabled(rwmmio_post_write))
> > > +               log_post_write_mmio(value, 8, addr, _THIS_IP_, _RET_I=
P_);
> > >  }
> > >  #endif
> > >
> > > @@ -261,11 +273,13 @@ static inline void writeb(u8 value, volatile vo=
id __iomem *addr)
> > >  #define writew writew
> > >  static inline void writew(u16 value, volatile void __iomem *addr)
> > >  {
> > > -       log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
> > > +       if (rwmmio_tracepoint_enabled(rwmmio_write))
> > > +               log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
> > >         __io_bw();
> > >         __raw_writew((u16 __force)cpu_to_le16(value), addr);
> > >         __io_aw();
> > > -       log_post_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
> > > +       if (rwmmio_tracepoint_enabled(rwmmio_post_write))
> > > +               log_post_write_mmio(value, 16, addr, _THIS_IP_, _RET_=
IP_);
> > >  }
> > >  #endif
> > >
> > > @@ -273,11 +287,13 @@ static inline void writew(u16 value, volatile v=
oid __iomem *addr)
> > >  #define writel writel
> > >  static inline void writel(u32 value, volatile void __iomem *addr)
> > >  {
> > > -       log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
> > > +       if (rwmmio_tracepoint_enabled(rwmmio_write))
> > > +               log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
> > >         __io_bw();
> > >         __raw_writel((u32 __force)__cpu_to_le32(value), addr);
> > >         __io_aw();
> > > -       log_post_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
> > > +       if (rwmmio_tracepoint_enabled(rwmmio_post_write))
> > > +               log_post_write_mmio(value, 32, addr, _THIS_IP_, _RET_=
IP_);
> > >  }
> > >  #endif
> > >
> > > @@ -286,11 +302,13 @@ static inline void writel(u32 value, volatile v=
oid __iomem *addr)
> > >  #define writeq writeq
> > >  static inline void writeq(u64 value, volatile void __iomem *addr)
> > >  {
> > > -       log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
> > > +       if (rwmmio_tracepoint_enabled(rwmmio_write))
> > > +               log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
> > >         __io_bw();
> > >         __raw_writeq((u64 __force)__cpu_to_le64(value), addr);
> > >         __io_aw();
> > > -       log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
> > > +       if (rwmmio_tracepoint_enabled(rwmmio_post_write))
> > > +               log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_=
IP_);
> > >  }
> > >  #endif
> > >  #endif /* CONFIG_64BIT */
> > > @@ -306,9 +324,11 @@ static inline u8 readb_relaxed(const volatile vo=
id __iomem *addr)
> > >  {
> > >         u8 val;
> > >
> > > -       log_read_mmio(8, addr, _THIS_IP_, _RET_IP_);
> > > +       if (rwmmio_tracepoint_enabled(rwmmio_read))
> > > +               log_read_mmio(8, addr, _THIS_IP_, _RET_IP_);
> > >         val =3D __raw_readb(addr);
> > > -       log_post_read_mmio(val, 8, addr, _THIS_IP_, _RET_IP_);
> > > +       if (rwmmio_tracepoint_enabled(rwmmio_post_read))
> > > +               log_post_read_mmio(val, 8, addr, _THIS_IP_, _RET_IP_)=
;
> > >         return val;
> > >  }
> > >  #endif
> > > @@ -319,9 +339,11 @@ static inline u16 readw_relaxed(const volatile v=
oid __iomem *addr)
> > >  {
> > >         u16 val;
> > >
> > > -       log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
> > > +       if (rwmmio_tracepoint_enabled(rwmmio_read))
> > > +               log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
> > >         val =3D __le16_to_cpu((__le16 __force)__raw_readw(addr));
> > > -       log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_IP_);
> > > +       if (rwmmio_tracepoint_enabled(rwmmio_post_read))
> > > +               log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_IP_=
);
> > >         return val;
> > >  }
> > >  #endif
> > > @@ -332,9 +354,11 @@ static inline u32 readl_relaxed(const volatile v=
oid __iomem *addr)
> > >  {
> > >         u32 val;
> > >
> > > -       log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
> > > +       if (rwmmio_tracepoint_enabled(rwmmio_read))
> > > +               log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
> > >         val =3D __le32_to_cpu((__le32 __force)__raw_readl(addr));
> > > -       log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_);
> > > +       if (rwmmio_tracepoint_enabled(rwmmio_post_read))
> > > +               log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_=
);
> > >         return val;
> > >  }
> > >  #endif
> > > @@ -345,9 +369,11 @@ static inline u64 readq_relaxed(const volatile v=
oid __iomem *addr)
> > >  {
> > >         u64 val;
> > >
> > > -       log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
> > > +       if (rwmmio_tracepoint_enabled(rwmmio_read))
> > > +               log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
> > >         val =3D __le64_to_cpu((__le64 __force)__raw_readq(addr));
> > > -       log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
> > > +       if (rwmmio_tracepoint_enabled(rwmmio_post_read))
> > > +               log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_=
);
> > >         return val;
> > >  }
> > >  #endif
> > > @@ -356,9 +382,11 @@ static inline u64 readq_relaxed(const volatile v=
oid __iomem *addr)
> > >  #define writeb_relaxed writeb_relaxed
> > >  static inline void writeb_relaxed(u8 value, volatile void __iomem *a=
ddr)
> > >  {
> > > -       log_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
> > > +       if (rwmmio_tracepoint_enabled(rwmmio_write))
> > > +               log_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
> > >         __raw_writeb(value, addr);
> > > -       log_post_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
> > > +       if (rwmmio_tracepoint_enabled(rwmmio_post_write))
> > > +               log_post_write_mmio(value, 8, addr, _THIS_IP_, _RET_I=
P_);
> > >  }
> > >  #endif
> > >
> > > @@ -366,9 +394,11 @@ static inline void writeb_relaxed(u8 value, vola=
tile void __iomem *addr)
> > >  #define writew_relaxed writew_relaxed
> > >  static inline void writew_relaxed(u16 value, volatile void __iomem *=
addr)
> > >  {
> > > -       log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
> > > +       if (rwmmio_tracepoint_enabled(rwmmio_write))
> > > +               log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
> > >         __raw_writew((u16 __force)cpu_to_le16(value), addr);
> > > -       log_post_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
> > > +       if (rwmmio_tracepoint_enabled(rwmmio_post_write))
> > > +               log_post_write_mmio(value, 16, addr, _THIS_IP_, _RET_=
IP_);
> > >  }
> > >  #endif
> > >
> > > @@ -376,9 +406,11 @@ static inline void writew_relaxed(u16 value, vol=
atile void __iomem *addr)
> > >  #define writel_relaxed writel_relaxed
> > >  static inline void writel_relaxed(u32 value, volatile void __iomem *=
addr)
> > >  {
> > > -       log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
> > > +       if (rwmmio_tracepoint_enabled(rwmmio_write))
> > > +               log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
> > >         __raw_writel((u32 __force)__cpu_to_le32(value), addr);
> > > -       log_post_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
> > > +       if (rwmmio_tracepoint_enabled(rwmmio_post_write))
> > > +               log_post_write_mmio(value, 32, addr, _THIS_IP_, _RET_=
IP_);
> > >  }
> > >  #endif
> > >
> > > @@ -386,9 +418,11 @@ static inline void writel_relaxed(u32 value, vol=
atile void __iomem *addr)
> > >  #define writeq_relaxed writeq_relaxed
> > >  static inline void writeq_relaxed(u64 value, volatile void __iomem *=
addr)
> > >  {
> > > -       log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
> > > +       if (rwmmio_tracepoint_enabled(rwmmio_write))
> > > +               log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
> > >         __raw_writeq((u64 __force)__cpu_to_le64(value), addr);
> > > -       log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
> > > +       if (rwmmio_tracepoint_enabled(rwmmio_post_write))
> > > +               log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_=
IP_);
> > >  }
> > >  #endif
> > >
> > > --
> > > 2.49.0.472.ge94155a9ec-goog
> > >

