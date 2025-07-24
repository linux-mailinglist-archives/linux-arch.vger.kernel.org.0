Return-Path: <linux-arch+bounces-12905-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD281B1098A
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 13:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFBBD1CE0CBB
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 11:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF17C29E118;
	Thu, 24 Jul 2025 11:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AdOvdEii"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5B026462E
	for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 11:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753357811; cv=none; b=bbR/A9RcBkKUhisHReyPllU4CXCuxAB7Wa+RCdJnFaU06/55dIK8MpE1ZTkWGUo6K7P62WLk16KVOLx6fUhINR4BDiRjYHgoHienIIFTUaUWuI0/IZrYlLtdTNmVQv9VhjyiuRmTmmMKnGGe5Wk5YqckHj8Jtnml8Q9wvILYx0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753357811; c=relaxed/simple;
	bh=8cluCteuDaeEHilrPgaAP7D8NZC6BRNHRAoug+rcWzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HPgAUk5eK85kQOBwm7k+B+se5s1Qi0IHfr2KScDtIi9jYzrQGORQnO+bf/hBB6/H1dx8KfEpcOuBkrOt38d9DVDf6yd1wT7h9AFZ0QBQP/JPo5aPePG/AfkBj06qQuahlP934bup+jYabi4SpU9iu4OnjV5scS7XjyEn9wj1kaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AdOvdEii; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60b86fc4b47so7373a12.1
        for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 04:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753357808; x=1753962608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYe+DmXF1buplEHORrFzaCZO48D/b0dqy0xaljLYUw0=;
        b=AdOvdEiiJciChejIdXLICyn23FaQiZ6il7W8oa0iWEXvdFU5+Znp2guGaTg+cJo5G2
         4VU5rlqdSJS65/C24PgEWnqGenrt4EFryAraue9U8AsqcOcnM4b/ynkE3hiD5wuCZoo3
         eHYlCTRAcpsE7/NMJGkEJ3HZCVxWRYIkUdYD2Kh5vqIyuSiCV8VVMcLO6hGDY+LMEO48
         UUeG/rPdEwE2TmBmT9BqzoTkF9E4Pc2VqFLQvH5shYWQxa73Ct7cX4hUApYY0/c57MNQ
         3/yh0+NuyjulbBWVRgRRXnRKlPCLDFiuk1QyfdyHg8wDErm0VlmLW03H7o6YIHeE8qTh
         X77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753357808; x=1753962608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYe+DmXF1buplEHORrFzaCZO48D/b0dqy0xaljLYUw0=;
        b=lhFMxT9KQfHRsvY4SeGDXQBhTrtNR3yx1IEmYOUNLBtmL6Lho35hWH2rc3QMH93UUp
         m7Ez2w/U1qhBRqiaCwAWbA2ymQBIhToue9Rp79wcxoqnIIT7UXv4ULz7uWAi9UkCSTfh
         uDvIbeLkS4LqmAUUdt+Sfbjk4su8jAENihLkQxxA38KC+j74v8AfKeJfc6kyjW0/y3dF
         mWcgv7BEgXyPNSr/KYD2vwfT/epJWl6TE+iQ1KwUjB1h/clar7p+hw1Y0DQATkqtW9kl
         niUfVVdE0ZsN6LL25k3rluuawdr66Nc5ju9vg93cxLxqEW8p7wGTYpY3JDvVkq1kLMSG
         sxXw==
X-Gm-Message-State: AOJu0Ywdy4ARudjRm8Mjn2+mcEWN751Sgzcm9UNKcULeeasx6PhvN/QL
	bAD7QjaQ+M1HY5Qc786zw/biJ6HUnVF+1hdCNlaJDGeAM9MIxWhQTcsmpckpwsfenlD6uwWP7MJ
	ZaX3gTT2/Z5lruinECCoi956IWyVqROJGJeg6mJNW7WBGS0+vY3qDpHIi
X-Gm-Gg: ASbGncsEiAvWiiw8D6u2eH9Sl3iKU2Q8SZXco7GSaHnPVn3wBkfSy7MxBk+bDfpMwO1
	COMDwzKNhGgRV3RgJi3wzK3x06ywW9xbShSFpJ7RCR/NECF4+EVs8jds9Z8P76xJDCYFaOhkj0z
	E2TnLmfxCRK11BBYglYKmMGn6uj1UClS/fCRZT+akU5jSfNuUjCIbwrVTAyMeaEePj4CZoYESzV
	lg3OO60ox5Wu7nteeRHDsf1Uy37G7cgq7HF99sG
X-Google-Smtp-Source: AGHT+IHnlFySwR+8UwPIuT9VPL/wx9DrJSsUhydtIRVh1GkX59EZ30iuuC75sXRlJYmbf5IN/Ca3sWSmdf5LCCyugMM=
X-Received: by 2002:a05:6402:b68:b0:60e:2e88:13b4 with SMTP id
 4fb4d7f45d1cf-614cce2dc64mr65056a12.3.1753357807420; Thu, 24 Jul 2025
 04:50:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250330164229.2174672-1-varadgautam@google.com>
 <CAOLDJO+=+hcz498KRc+95dF5y3hZdtm+3y35o2rBC9qAOF-vDg@mail.gmail.com>
 <CAOLDJOKiEmde5Max0BnTBVpNmfpm-wwYLJ4Etv8D2KZKPHyFzw@mail.gmail.com> <CAOLDJOJ=QcQ065UTAdGayO2kbpGMOwCtdEGVm8TvQO8Wf8CSMw@mail.gmail.com>
In-Reply-To: <CAOLDJOJ=QcQ065UTAdGayO2kbpGMOwCtdEGVm8TvQO8Wf8CSMw@mail.gmail.com>
From: Varad Gautam <varadgautam@google.com>
Date: Thu, 24 Jul 2025 17:19:55 +0530
X-Gm-Features: Ac12FXw5rHA0qEk2K2aCJQhi5TShjriLhXTQkqH6qLXve_2C61ZGcrxKU54nPgw
Message-ID: <CAOLDJOJ98EccMJ4O3FyX4mSFtHnbQ4iwwXsHT2EbLL+KrXfvtw@mail.gmail.com>
Subject: Re: [PATCH] asm-generic/io.h: Skip trace helpers if rwmmio events are disabled
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Sai Prakash Ranjan <quic_saipraka@quicinc.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 5:28=E2=80=AFPM Varad Gautam <varadgautam@google.co=
m> wrote:
>
> On Mon, Apr 28, 2025 at 9:41=E2=80=AFPM Varad Gautam <varadgautam@google.=
com> wrote:
> >
> > On Mon, Apr 7, 2025 at 6:13=E2=80=AFPM Varad Gautam <varadgautam@google=
.com> wrote:
> > >
> > > On Sun, Mar 30, 2025 at 6:42=E2=80=AFPM Varad Gautam <varadgautam@goo=
gle.com> wrote:
> > > >
> > > > With `CONFIG_TRACE_MMIO_ACCESS=3Dy`, the `{read,write}{b,w,l,q}{_re=
laxed}()`
> > > > mmio accessors unconditionally call `log_{post_}{read,write}_mmio()=
`
> > > > helpers, which in turn call the ftrace ops for `rwmmio` trace event=
s
> > > >
> > > > This adds a performance penalty per mmio accessor call, even when
> > > > `rwmmio` events are disabled at runtime (~80% overhead on local
> > > > measurement).
> > > >
> > > > Guard these with `tracepoint_enabled()`.
> > > >
> > > > Signed-off-by: Varad Gautam <varadgautam@google.com>
> > > > Fixes: 210031971cdd ("asm-generic/io: Add logging support for MMIO =
accessors")
> > > > Cc: <stable@vger.kernel.org>
> > >
> > > Ping.
> > >
> >
> > Ping.
> >
>
> Ping. Arnd, can this be picked up into the asm-generic tree?
>

Ping.

> > > > ---
> > > >  include/asm-generic/io.h | 98 +++++++++++++++++++++++++++---------=
----
> > > >  1 file changed, 66 insertions(+), 32 deletions(-)
> > > >
> > > > diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> > > > index 3c61c29ff6ab..a9b5da547523 100644
> > > > --- a/include/asm-generic/io.h
> > > > +++ b/include/asm-generic/io.h
> > > > @@ -75,6 +75,7 @@
> > > >  #if IS_ENABLED(CONFIG_TRACE_MMIO_ACCESS) && !(defined(__DISABLE_TR=
ACE_MMIO__))
> > > >  #include <linux/tracepoint-defs.h>
> > > >
> > > > +#define rwmmio_tracepoint_enabled(tracepoint) tracepoint_enabled(t=
racepoint)
> > > >  DECLARE_TRACEPOINT(rwmmio_write);
> > > >  DECLARE_TRACEPOINT(rwmmio_post_write);
> > > >  DECLARE_TRACEPOINT(rwmmio_read);
> > > > @@ -91,6 +92,7 @@ void log_post_read_mmio(u64 val, u8 width, const =
volatile void __iomem *addr,
> > > >
> > > >  #else
> > > >
> > > > +#define rwmmio_tracepoint_enabled(tracepoint) false
> > > >  static inline void log_write_mmio(u64 val, u8 width, volatile void=
 __iomem *addr,
> > > >                                   unsigned long caller_addr, unsign=
ed long caller_addr0) {}
> > > >  static inline void log_post_write_mmio(u64 val, u8 width, volatile=
 void __iomem *addr,
> > > > @@ -189,11 +191,13 @@ static inline u8 readb(const volatile void __=
iomem *addr)
> > > >  {
> > > >         u8 val;
> > > >
> > > > -       log_read_mmio(8, addr, _THIS_IP_, _RET_IP_);
> > > > +       if (rwmmio_tracepoint_enabled(rwmmio_read))
> > > > +               log_read_mmio(8, addr, _THIS_IP_, _RET_IP_);
> > > >         __io_br();
> > > >         val =3D __raw_readb(addr);
> > > >         __io_ar(val);
> > > > -       log_post_read_mmio(val, 8, addr, _THIS_IP_, _RET_IP_);
> > > > +       if (rwmmio_tracepoint_enabled(rwmmio_post_read))
> > > > +               log_post_read_mmio(val, 8, addr, _THIS_IP_, _RET_IP=
_);
> > > >         return val;
> > > >  }
> > > >  #endif
> > > > @@ -204,11 +208,13 @@ static inline u16 readw(const volatile void _=
_iomem *addr)
> > > >  {
> > > >         u16 val;
> > > >
> > > > -       log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
> > > > +       if (rwmmio_tracepoint_enabled(rwmmio_read))
> > > > +               log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
> > > >         __io_br();
> > > >         val =3D __le16_to_cpu((__le16 __force)__raw_readw(addr));
> > > >         __io_ar(val);
> > > > -       log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_IP_);
> > > > +       if (rwmmio_tracepoint_enabled(rwmmio_post_read))
> > > > +               log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_I=
P_);
> > > >         return val;
> > > >  }
> > > >  #endif
> > > > @@ -219,11 +225,13 @@ static inline u32 readl(const volatile void _=
_iomem *addr)
> > > >  {
> > > >         u32 val;
> > > >
> > > > -       log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
> > > > +       if (rwmmio_tracepoint_enabled(rwmmio_read))
> > > > +               log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
> > > >         __io_br();
> > > >         val =3D __le32_to_cpu((__le32 __force)__raw_readl(addr));
> > > >         __io_ar(val);
> > > > -       log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_);
> > > > +       if (rwmmio_tracepoint_enabled(rwmmio_post_read))
> > > > +               log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_I=
P_);
> > > >         return val;
> > > >  }
> > > >  #endif
> > > > @@ -235,11 +243,13 @@ static inline u64 readq(const volatile void _=
_iomem *addr)
> > > >  {
> > > >         u64 val;
> > > >
> > > > -       log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
> > > > +       if (rwmmio_tracepoint_enabled(rwmmio_read))
> > > > +               log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
> > > >         __io_br();
> > > >         val =3D __le64_to_cpu((__le64 __force)__raw_readq(addr));
> > > >         __io_ar(val);
> > > > -       log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
> > > > +       if (rwmmio_tracepoint_enabled(rwmmio_post_read))
> > > > +               log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_I=
P_);
> > > >         return val;
> > > >  }
> > > >  #endif
> > > > @@ -249,11 +259,13 @@ static inline u64 readq(const volatile void _=
_iomem *addr)
> > > >  #define writeb writeb
> > > >  static inline void writeb(u8 value, volatile void __iomem *addr)
> > > >  {
> > > > -       log_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
> > > > +       if (rwmmio_tracepoint_enabled(rwmmio_write))
> > > > +               log_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_)=
;
> > > >         __io_bw();
> > > >         __raw_writeb(value, addr);
> > > >         __io_aw();
> > > > -       log_post_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
> > > > +       if (rwmmio_tracepoint_enabled(rwmmio_post_write))
> > > > +               log_post_write_mmio(value, 8, addr, _THIS_IP_, _RET=
_IP_);
> > > >  }
> > > >  #endif
> > > >
> > > > @@ -261,11 +273,13 @@ static inline void writeb(u8 value, volatile =
void __iomem *addr)
> > > >  #define writew writew
> > > >  static inline void writew(u16 value, volatile void __iomem *addr)
> > > >  {
> > > > -       log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
> > > > +       if (rwmmio_tracepoint_enabled(rwmmio_write))
> > > > +               log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_=
);
> > > >         __io_bw();
> > > >         __raw_writew((u16 __force)cpu_to_le16(value), addr);
> > > >         __io_aw();
> > > > -       log_post_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
> > > > +       if (rwmmio_tracepoint_enabled(rwmmio_post_write))
> > > > +               log_post_write_mmio(value, 16, addr, _THIS_IP_, _RE=
T_IP_);
> > > >  }
> > > >  #endif
> > > >
> > > > @@ -273,11 +287,13 @@ static inline void writew(u16 value, volatile=
 void __iomem *addr)
> > > >  #define writel writel
> > > >  static inline void writel(u32 value, volatile void __iomem *addr)
> > > >  {
> > > > -       log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
> > > > +       if (rwmmio_tracepoint_enabled(rwmmio_write))
> > > > +               log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_=
);
> > > >         __io_bw();
> > > >         __raw_writel((u32 __force)__cpu_to_le32(value), addr);
> > > >         __io_aw();
> > > > -       log_post_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
> > > > +       if (rwmmio_tracepoint_enabled(rwmmio_post_write))
> > > > +               log_post_write_mmio(value, 32, addr, _THIS_IP_, _RE=
T_IP_);
> > > >  }
> > > >  #endif
> > > >
> > > > @@ -286,11 +302,13 @@ static inline void writel(u32 value, volatile=
 void __iomem *addr)
> > > >  #define writeq writeq
> > > >  static inline void writeq(u64 value, volatile void __iomem *addr)
> > > >  {
> > > > -       log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
> > > > +       if (rwmmio_tracepoint_enabled(rwmmio_write))
> > > > +               log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_=
);
> > > >         __io_bw();
> > > >         __raw_writeq((u64 __force)__cpu_to_le64(value), addr);
> > > >         __io_aw();
> > > > -       log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
> > > > +       if (rwmmio_tracepoint_enabled(rwmmio_post_write))
> > > > +               log_post_write_mmio(value, 64, addr, _THIS_IP_, _RE=
T_IP_);
> > > >  }
> > > >  #endif
> > > >  #endif /* CONFIG_64BIT */
> > > > @@ -306,9 +324,11 @@ static inline u8 readb_relaxed(const volatile =
void __iomem *addr)
> > > >  {
> > > >         u8 val;
> > > >
> > > > -       log_read_mmio(8, addr, _THIS_IP_, _RET_IP_);
> > > > +       if (rwmmio_tracepoint_enabled(rwmmio_read))
> > > > +               log_read_mmio(8, addr, _THIS_IP_, _RET_IP_);
> > > >         val =3D __raw_readb(addr);
> > > > -       log_post_read_mmio(val, 8, addr, _THIS_IP_, _RET_IP_);
> > > > +       if (rwmmio_tracepoint_enabled(rwmmio_post_read))
> > > > +               log_post_read_mmio(val, 8, addr, _THIS_IP_, _RET_IP=
_);
> > > >         return val;
> > > >  }
> > > >  #endif
> > > > @@ -319,9 +339,11 @@ static inline u16 readw_relaxed(const volatile=
 void __iomem *addr)
> > > >  {
> > > >         u16 val;
> > > >
> > > > -       log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
> > > > +       if (rwmmio_tracepoint_enabled(rwmmio_read))
> > > > +               log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
> > > >         val =3D __le16_to_cpu((__le16 __force)__raw_readw(addr));
> > > > -       log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_IP_);
> > > > +       if (rwmmio_tracepoint_enabled(rwmmio_post_read))
> > > > +               log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_I=
P_);
> > > >         return val;
> > > >  }
> > > >  #endif
> > > > @@ -332,9 +354,11 @@ static inline u32 readl_relaxed(const volatile=
 void __iomem *addr)
> > > >  {
> > > >         u32 val;
> > > >
> > > > -       log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
> > > > +       if (rwmmio_tracepoint_enabled(rwmmio_read))
> > > > +               log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
> > > >         val =3D __le32_to_cpu((__le32 __force)__raw_readl(addr));
> > > > -       log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_);
> > > > +       if (rwmmio_tracepoint_enabled(rwmmio_post_read))
> > > > +               log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_I=
P_);
> > > >         return val;
> > > >  }
> > > >  #endif
> > > > @@ -345,9 +369,11 @@ static inline u64 readq_relaxed(const volatile=
 void __iomem *addr)
> > > >  {
> > > >         u64 val;
> > > >
> > > > -       log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
> > > > +       if (rwmmio_tracepoint_enabled(rwmmio_read))
> > > > +               log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
> > > >         val =3D __le64_to_cpu((__le64 __force)__raw_readq(addr));
> > > > -       log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
> > > > +       if (rwmmio_tracepoint_enabled(rwmmio_post_read))
> > > > +               log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_I=
P_);
> > > >         return val;
> > > >  }
> > > >  #endif
> > > > @@ -356,9 +382,11 @@ static inline u64 readq_relaxed(const volatile=
 void __iomem *addr)
> > > >  #define writeb_relaxed writeb_relaxed
> > > >  static inline void writeb_relaxed(u8 value, volatile void __iomem =
*addr)
> > > >  {
> > > > -       log_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
> > > > +       if (rwmmio_tracepoint_enabled(rwmmio_write))
> > > > +               log_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_)=
;
> > > >         __raw_writeb(value, addr);
> > > > -       log_post_write_mmio(value, 8, addr, _THIS_IP_, _RET_IP_);
> > > > +       if (rwmmio_tracepoint_enabled(rwmmio_post_write))
> > > > +               log_post_write_mmio(value, 8, addr, _THIS_IP_, _RET=
_IP_);
> > > >  }
> > > >  #endif
> > > >
> > > > @@ -366,9 +394,11 @@ static inline void writeb_relaxed(u8 value, vo=
latile void __iomem *addr)
> > > >  #define writew_relaxed writew_relaxed
> > > >  static inline void writew_relaxed(u16 value, volatile void __iomem=
 *addr)
> > > >  {
> > > > -       log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
> > > > +       if (rwmmio_tracepoint_enabled(rwmmio_write))
> > > > +               log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_=
);
> > > >         __raw_writew((u16 __force)cpu_to_le16(value), addr);
> > > > -       log_post_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
> > > > +       if (rwmmio_tracepoint_enabled(rwmmio_post_write))
> > > > +               log_post_write_mmio(value, 16, addr, _THIS_IP_, _RE=
T_IP_);
> > > >  }
> > > >  #endif
> > > >
> > > > @@ -376,9 +406,11 @@ static inline void writew_relaxed(u16 value, v=
olatile void __iomem *addr)
> > > >  #define writel_relaxed writel_relaxed
> > > >  static inline void writel_relaxed(u32 value, volatile void __iomem=
 *addr)
> > > >  {
> > > > -       log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
> > > > +       if (rwmmio_tracepoint_enabled(rwmmio_write))
> > > > +               log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_=
);
> > > >         __raw_writel((u32 __force)__cpu_to_le32(value), addr);
> > > > -       log_post_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
> > > > +       if (rwmmio_tracepoint_enabled(rwmmio_post_write))
> > > > +               log_post_write_mmio(value, 32, addr, _THIS_IP_, _RE=
T_IP_);
> > > >  }
> > > >  #endif
> > > >
> > > > @@ -386,9 +418,11 @@ static inline void writel_relaxed(u32 value, v=
olatile void __iomem *addr)
> > > >  #define writeq_relaxed writeq_relaxed
> > > >  static inline void writeq_relaxed(u64 value, volatile void __iomem=
 *addr)
> > > >  {
> > > > -       log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
> > > > +       if (rwmmio_tracepoint_enabled(rwmmio_write))
> > > > +               log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_=
);
> > > >         __raw_writeq((u64 __force)__cpu_to_le64(value), addr);
> > > > -       log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
> > > > +       if (rwmmio_tracepoint_enabled(rwmmio_post_write))
> > > > +               log_post_write_mmio(value, 64, addr, _THIS_IP_, _RE=
T_IP_);
> > > >  }
> > > >  #endif
> > > >
> > > > --
> > > > 2.49.0.472.ge94155a9ec-goog
> > > >

