Return-Path: <linux-arch+bounces-11668-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26934A9F9CC
	for <lists+linux-arch@lfdr.de>; Mon, 28 Apr 2025 21:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0FC189F77C
	for <lists+linux-arch@lfdr.de>; Mon, 28 Apr 2025 19:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C363D297A46;
	Mon, 28 Apr 2025 19:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WjjYRwHC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2C0297A45
	for <linux-arch@vger.kernel.org>; Mon, 28 Apr 2025 19:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745869299; cv=none; b=M4K3O/m5FErIKuo4JrsaUjsXKVka6F1ljYYtdQGMiZl/FBp7oS42X9Gq5BBQ1/a8vaiukee77eockDEmR1wfdnp8Egf4ujAmlxSm/af0PpN3zzNZe6nthene6eh+CbhriW7fIioJKUWtpEaXMIVU7WZj/T+jwFktGMei/v1lbQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745869299; c=relaxed/simple;
	bh=3pvkFQ8g4boXkvIWB8jDh9QF4pYMLHjNV7YjF0sO8hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qe9TAyTUdcD8Z/ntT7nWpSRY7dridOx4ebFkQfg1FNna/6zbJFTTJG3XrbkNhC5DrnBEZUXDzJ+6XG1Fu/dvFTg0FLTZgGMu7RovcVJWGg/AVlnQQcdWsws+YGmp2S20uhEjJYOAbyZKjRHKdMwbMZppHC30vQpuXwKelhXrufs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WjjYRwHC; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-47666573242so79521cf.0
        for <linux-arch@vger.kernel.org>; Mon, 28 Apr 2025 12:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745869296; x=1746474096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKWfssF+u5OUQugx4NcnkN6zDxuj94azMg1svC/t3H0=;
        b=WjjYRwHC/qZSZVAactDgZXhFc0Xw8lCBYMygy9YzWvi4y4zUZkYGN/bFC+TuvyqmPw
         ZHZckhskYZ0GDnqxcPsx9m2xxVxaTnM+7lYH8gvXC6L/x2jXHREZINXsypMKdejHoqUH
         b2C/fkcMRB0aoEmyKIjB3ZJOa9SzgmT+CDPaz7/3FmwymiWU6zdFNBOGC0kjdPi/GOuT
         AmNMjM96x2eeiHySUMgdVj2qKp3QfQyXG2GZ4C7JkpQ/nw/3tFEbDWL5p76EDzKEhCTb
         qPtH2h1dWcmouVBOyIovm3SCiLytS5pt9yPcgYtsTFrSGVR9XesGZ+PTIgMamaM2E/zd
         rvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745869296; x=1746474096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKWfssF+u5OUQugx4NcnkN6zDxuj94azMg1svC/t3H0=;
        b=PxCEXX8PqD1uScG2YbVRWFHIR+quHeZXLsOGhCtgEbHkajhCdyKNzGCEKwUD1dA4K5
         vn4MdM5ILum4oGy05eMAyopG5pgqGwTHhEo/a5ZkZzwIamr8nc4nyji3wnNTYofC6epb
         2wpBlXr7k7KOK1rHQaMTg5jFOFvVa1De6w9/JVelEomnFQRXAufwgZuuy8J2ND8KqJ1h
         Zvokqcel23QQDqcq/5oC01M8qY4haGzkwx29JtScTN5WRcTE37VIB/VxdKYG2xmwnyCt
         ccIrv89wDr17sN73oY/jrEEpmmdzMcJLPqezZyuteEUxHCtzK2Y5l8jGjGMsuJbvj5Yc
         nifw==
X-Gm-Message-State: AOJu0YyGGdfjYxoz8COfSz/iQuPIKFVC9M7z0kXWRRs1Hkgy6AegVtSW
	t9bZ9ALhjkya0E7JrgJsfCLueKJe0qZupMPazoQdj03PqwxCc01riJ8lqQT17mHxFpoD+p/oDBY
	2vtTIIfoha5IlkhFNMEeXWZ54rciHhmO5aC6p9SNmMV5i0wVnNQ==
X-Gm-Gg: ASbGncvShU3IYV0cKsjH7/Sk9Uo0N6dewTiMD+c/VP+5TMAnoso8MxDFYpMZ0wEuUaJ
	cJvS3fGOL9v0Vr2sOd1P/d/xr6Ol/kGXDvgQ7mr+42hE90Dt494KncpWnaLEfEUCyN+yZ0yq+kk
	8oibGJxuKPSP09InNaoqns1Eb88gpOuAQ=
X-Google-Smtp-Source: AGHT+IEAb9/CWKiFOrSPayRnBgtZa1u8k/Ptg2eV385V48qOG0DWCp5CYFLMT8RoDHirI5xvzEF77DD/lGFLx92h63g=
X-Received: by 2002:ac8:5a8b:0:b0:477:2c12:9253 with SMTP id
 d75a77b69052e-4885b57a7e0mr788161cf.16.1745869296193; Mon, 28 Apr 2025
 12:41:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250330164229.2174672-1-varadgautam@google.com> <CAOLDJO+=+hcz498KRc+95dF5y3hZdtm+3y35o2rBC9qAOF-vDg@mail.gmail.com>
In-Reply-To: <CAOLDJO+=+hcz498KRc+95dF5y3hZdtm+3y35o2rBC9qAOF-vDg@mail.gmail.com>
From: Varad Gautam <varadgautam@google.com>
Date: Mon, 28 Apr 2025 21:41:24 +0200
X-Gm-Features: ATxdqUFuTivxUUQ8V8ic_I5aXx6zoGkrsdP9Pi1LrRBFnss-Olz0Mr2pZPcUuEY
Message-ID: <CAOLDJOKiEmde5Max0BnTBVpNmfpm-wwYLJ4Etv8D2KZKPHyFzw@mail.gmail.com>
Subject: Re: [PATCH] asm-generic/io.h: Skip trace helpers if rwmmio events are disabled
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Sai Prakash Ranjan <quic_saipraka@quicinc.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 6:13=E2=80=AFPM Varad Gautam <varadgautam@google.com=
> wrote:
>
> On Sun, Mar 30, 2025 at 6:42=E2=80=AFPM Varad Gautam <varadgautam@google.=
com> wrote:
> >
> > With `CONFIG_TRACE_MMIO_ACCESS=3Dy`, the `{read,write}{b,w,l,q}{_relaxe=
d}()`
> > mmio accessors unconditionally call `log_{post_}{read,write}_mmio()`
> > helpers, which in turn call the ftrace ops for `rwmmio` trace events
> >
> > This adds a performance penalty per mmio accessor call, even when
> > `rwmmio` events are disabled at runtime (~80% overhead on local
> > measurement).
> >
> > Guard these with `tracepoint_enabled()`.
> >
> > Signed-off-by: Varad Gautam <varadgautam@google.com>
> > Fixes: 210031971cdd ("asm-generic/io: Add logging support for MMIO acce=
ssors")
> > Cc: <stable@vger.kernel.org>
>
> Ping.
>

Ping.

> > ---
> >  include/asm-generic/io.h | 98 +++++++++++++++++++++++++++-------------
> >  1 file changed, 66 insertions(+), 32 deletions(-)
> >
> > diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> > index 3c61c29ff6ab..a9b5da547523 100644
> > --- a/include/asm-generic/io.h
> > +++ b/include/asm-generic/io.h
> > @@ -75,6 +75,7 @@
> >  #if IS_ENABLED(CONFIG_TRACE_MMIO_ACCESS) && !(defined(__DISABLE_TRACE_=
MMIO__))
> >  #include <linux/tracepoint-defs.h>
> >
> > +#define rwmmio_tracepoint_enabled(tracepoint) tracepoint_enabled(trace=
point)
> >  DECLARE_TRACEPOINT(rwmmio_write);
> >  DECLARE_TRACEPOINT(rwmmio_post_write);
> >  DECLARE_TRACEPOINT(rwmmio_read);
> > @@ -91,6 +92,7 @@ void log_post_read_mmio(u64 val, u8 width, const vola=
tile void __iomem *addr,
> >
> >  #else
> >
> > +#define rwmmio_tracepoint_enabled(tracepoint) false
> >  static inline void log_write_mmio(u64 val, u8 width, volatile void __i=
omem *addr,
> >                                   unsigned long caller_addr, unsigned l=
ong caller_addr0) {}
> >  static inline void log_post_write_mmio(u64 val, u8 width, volatile voi=
d __iomem *addr,
> > @@ -189,11 +191,13 @@ static inline u8 readb(const volatile void __iome=
m *addr)
> >  {
> >         u8 val;
> >
> > -       log_read_mmio(8, addr, _THIS_IP_, _RET_IP_);
> > +       if (rwmmio_tracepoint_enabled(rwmmio_read))
> > +               log_read_mmio(8, addr, _THIS_IP_, _RET_IP_);
> >         __io_br();
> >         val =3D __raw_readb(addr);
> >         __io_ar(val);
> > -       log_post_read_mmio(val, 8, addr, _THIS_IP_, _RET_IP_);
> > +       if (rwmmio_tracepoint_enabled(rwmmio_post_read))
> > +               log_post_read_mmio(val, 8, addr, _THIS_IP_, _RET_IP_);
> >         return val;
> >  }
> >  #endif
> > @@ -204,11 +208,13 @@ static inline u16 readw(const volatile void __iom=
em *addr)
> >  {
> >         u16 val;
> >
> > -       log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
> > +       if (rwmmio_tracepoint_enabled(rwmmio_read))
> > +               log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
> >         __io_br();
> >         val =3D __le16_to_cpu((__le16 __force)__raw_readw(addr));
> >         __io_ar(val);
> > -       log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_IP_);
> > +       if (rwmmio_tracepoint_enabled(rwmmio_post_read))
> > +               log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_IP_);
> >         return val;
> >  }
> >  #endif
> > @@ -219,11 +225,13 @@ static inline u32 readl(const volatile void __iom=
em *addr)
> >  {
> >         u32 val;
> >
> > -       log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
> > +       if (rwmmio_tracepoint_enabled(rwmmio_read))
> > +               log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
> >         __io_br();
> >         val =3D __le32_to_cpu((__le32 __force)__raw_readl(addr));
> >         __io_ar(val);
> > -       log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_);
> > +       if (rwmmio_tracepoint_enabled(rwmmio_post_read))
> > +               log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_);
> >         return val;
> >  }
> >  #endif
> > @@ -235,11 +243,13 @@ static inline u64 readq(const volatile void __iom=
em *addr)
> >  {
> >         u64 val;
> >
> > -       log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
> > +       if (rwmmio_tracepoint_enabled(rwmmio_read))
> > +               log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
> >         __io_br();
> >         val =3D __le64_to_cpu((__le64 __force)__raw_readq(addr));
> >         __io_ar(val);
> > -       log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
> > +       if (rwmmio_tracepoint_enabled(rwmmio_post_read))
> > +               log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
> >         return val;
> >  }
> >  #endif
> > @@ -249,11 +259,13 @@ static inline u64 readq(const volatile void __iom=
em *addr)
> >  #define writeb writeb
> >  static inline void writeb(u8 value, volatile void __iomem *addr)
> >  {
> > -       log_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
> > +       if (rwmmio_tracepoint_enabled(rwmmio_write))
> > +               log_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
> >         __io_bw();
> >         __raw_writeb(value, addr);
> >         __io_aw();
> > -       log_post_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
> > +       if (rwmmio_tracepoint_enabled(rwmmio_post_write))
> > +               log_post_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_=
);
> >  }
> >  #endif
> >
> > @@ -261,11 +273,13 @@ static inline void writeb(u8 value, volatile void=
 __iomem *addr)
> >  #define writew writew
> >  static inline void writew(u16 value, volatile void __iomem *addr)
> >  {
> > -       log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
> > +       if (rwmmio_tracepoint_enabled(rwmmio_write))
> > +               log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
> >         __io_bw();
> >         __raw_writew((u16 __force)cpu_to_le16(value), addr);
> >         __io_aw();
> > -       log_post_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
> > +       if (rwmmio_tracepoint_enabled(rwmmio_post_write))
> > +               log_post_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP=
_);
> >  }
> >  #endif
> >
> > @@ -273,11 +287,13 @@ static inline void writew(u16 value, volatile voi=
d __iomem *addr)
> >  #define writel writel
> >  static inline void writel(u32 value, volatile void __iomem *addr)
> >  {
> > -       log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
> > +       if (rwmmio_tracepoint_enabled(rwmmio_write))
> > +               log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
> >         __io_bw();
> >         __raw_writel((u32 __force)__cpu_to_le32(value), addr);
> >         __io_aw();
> > -       log_post_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
> > +       if (rwmmio_tracepoint_enabled(rwmmio_post_write))
> > +               log_post_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP=
_);
> >  }
> >  #endif
> >
> > @@ -286,11 +302,13 @@ static inline void writel(u32 value, volatile voi=
d __iomem *addr)
> >  #define writeq writeq
> >  static inline void writeq(u64 value, volatile void __iomem *addr)
> >  {
> > -       log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
> > +       if (rwmmio_tracepoint_enabled(rwmmio_write))
> > +               log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
> >         __io_bw();
> >         __raw_writeq((u64 __force)__cpu_to_le64(value), addr);
> >         __io_aw();
> > -       log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
> > +       if (rwmmio_tracepoint_enabled(rwmmio_post_write))
> > +               log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP=
_);
> >  }
> >  #endif
> >  #endif /* CONFIG_64BIT */
> > @@ -306,9 +324,11 @@ static inline u8 readb_relaxed(const volatile void=
 __iomem *addr)
> >  {
> >         u8 val;
> >
> > -       log_read_mmio(8, addr, _THIS_IP_, _RET_IP_);
> > +       if (rwmmio_tracepoint_enabled(rwmmio_read))
> > +               log_read_mmio(8, addr, _THIS_IP_, _RET_IP_);
> >         val =3D __raw_readb(addr);
> > -       log_post_read_mmio(val, 8, addr, _THIS_IP_, _RET_IP_);
> > +       if (rwmmio_tracepoint_enabled(rwmmio_post_read))
> > +               log_post_read_mmio(val, 8, addr, _THIS_IP_, _RET_IP_);
> >         return val;
> >  }
> >  #endif
> > @@ -319,9 +339,11 @@ static inline u16 readw_relaxed(const volatile voi=
d __iomem *addr)
> >  {
> >         u16 val;
> >
> > -       log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
> > +       if (rwmmio_tracepoint_enabled(rwmmio_read))
> > +               log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
> >         val =3D __le16_to_cpu((__le16 __force)__raw_readw(addr));
> > -       log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_IP_);
> > +       if (rwmmio_tracepoint_enabled(rwmmio_post_read))
> > +               log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_IP_);
> >         return val;
> >  }
> >  #endif
> > @@ -332,9 +354,11 @@ static inline u32 readl_relaxed(const volatile voi=
d __iomem *addr)
> >  {
> >         u32 val;
> >
> > -       log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
> > +       if (rwmmio_tracepoint_enabled(rwmmio_read))
> > +               log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
> >         val =3D __le32_to_cpu((__le32 __force)__raw_readl(addr));
> > -       log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_);
> > +       if (rwmmio_tracepoint_enabled(rwmmio_post_read))
> > +               log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_);
> >         return val;
> >  }
> >  #endif
> > @@ -345,9 +369,11 @@ static inline u64 readq_relaxed(const volatile voi=
d __iomem *addr)
> >  {
> >         u64 val;
> >
> > -       log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
> > +       if (rwmmio_tracepoint_enabled(rwmmio_read))
> > +               log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
> >         val =3D __le64_to_cpu((__le64 __force)__raw_readq(addr));
> > -       log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
> > +       if (rwmmio_tracepoint_enabled(rwmmio_post_read))
> > +               log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
> >         return val;
> >  }
> >  #endif
> > @@ -356,9 +382,11 @@ static inline u64 readq_relaxed(const volatile voi=
d __iomem *addr)
> >  #define writeb_relaxed writeb_relaxed
> >  static inline void writeb_relaxed(u8 value, volatile void __iomem *add=
r)
> >  {
> > -       log_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
> > +       if (rwmmio_tracepoint_enabled(rwmmio_write))
> > +               log_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
> >         __raw_writeb(value, addr);
> > -       log_post_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
> > +       if (rwmmio_tracepoint_enabled(rwmmio_post_write))
> > +               log_post_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_=
);
> >  }
> >  #endif
> >
> > @@ -366,9 +394,11 @@ static inline void writeb_relaxed(u8 value, volati=
le void __iomem *addr)
> >  #define writew_relaxed writew_relaxed
> >  static inline void writew_relaxed(u16 value, volatile void __iomem *ad=
dr)
> >  {
> > -       log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
> > +       if (rwmmio_tracepoint_enabled(rwmmio_write))
> > +               log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
> >         __raw_writew((u16 __force)cpu_to_le16(value), addr);
> > -       log_post_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
> > +       if (rwmmio_tracepoint_enabled(rwmmio_post_write))
> > +               log_post_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP=
_);
> >  }
> >  #endif
> >
> > @@ -376,9 +406,11 @@ static inline void writew_relaxed(u16 value, volat=
ile void __iomem *addr)
> >  #define writel_relaxed writel_relaxed
> >  static inline void writel_relaxed(u32 value, volatile void __iomem *ad=
dr)
> >  {
> > -       log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
> > +       if (rwmmio_tracepoint_enabled(rwmmio_write))
> > +               log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
> >         __raw_writel((u32 __force)__cpu_to_le32(value), addr);
> > -       log_post_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
> > +       if (rwmmio_tracepoint_enabled(rwmmio_post_write))
> > +               log_post_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP=
_);
> >  }
> >  #endif
> >
> > @@ -386,9 +418,11 @@ static inline void writel_relaxed(u32 value, volat=
ile void __iomem *addr)
> >  #define writeq_relaxed writeq_relaxed
> >  static inline void writeq_relaxed(u64 value, volatile void __iomem *ad=
dr)
> >  {
> > -       log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
> > +       if (rwmmio_tracepoint_enabled(rwmmio_write))
> > +               log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
> >         __raw_writeq((u64 __force)__cpu_to_le64(value), addr);
> > -       log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
> > +       if (rwmmio_tracepoint_enabled(rwmmio_post_write))
> > +               log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP=
_);
> >  }
> >  #endif
> >
> > --
> > 2.49.0.472.ge94155a9ec-goog
> >

