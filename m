Return-Path: <linux-arch+bounces-15860-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E65C4D3A537
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 11:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3F4E3007221
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 10:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4825F2FFF8F;
	Mon, 19 Jan 2026 10:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSPheOcY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3A72DC334
	for <linux-arch@vger.kernel.org>; Mon, 19 Jan 2026 10:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768819083; cv=none; b=TMuPnxVAqeqQrDtOP4VsjxyJaXElJfBoXZgrHGVJccsA3RndoMuESBPRUWyZVimI7T+OD6ET7UEOof/sOqxiYUlpmyALVrrarX9x/aBbYRlrwrQLB4o95Q0pCQdZFnqSSuB0QNZJgO7gE8hECbEP/mcwm4AzVW+opMFv5Ov6HEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768819083; c=relaxed/simple;
	bh=2dACDU8Xs+stj8hpKb8+ZGcAqIGCj+l+MMqYOB1bDxw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IW3Bm27xH09LQO9lDdmBgDB0tGbE8E5dmukQiRuvoEDjbTMjQkK4uD1vwQGnazw9SR7S9gV9njiaEqw2cJc13tK68Dm/MSZlfJZdYo34etD2i8cyvsOEbS9fMR0pE3gGRXtOQF8LKGjJnYpp0jLZDskOx8SsXTdYQs1rd4Nu3TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSPheOcY; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47ee0291921so26853035e9.3
        for <linux-arch@vger.kernel.org>; Mon, 19 Jan 2026 02:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768819080; x=1769423880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQ2bza/GhxjbFSXBJjgkzfILhnSLH4B1G1xiFJgsY3k=;
        b=CSPheOcYpir1rqjcm0S4r0+tMCaz3O+0ppYPFFlnstqqKPik0OHMcMwDYcUbgAuXOX
         AAvCimWrj75vWGH3W+ERA7YZNupAVb0YyZdFSXSMaZ9luoe+yr9piZ/u/29D6XTpz552
         YbrkvDHbY+ImcvMXmi7dZxJ//S19tKjZWgcxCkt/YYADFwEnA17xYlVJBGbagS+qiMuY
         RkfeOVtwU30HeYAc1+o8eelxq4Z16by+lzfq5ovc1DXSlbAZGfRAV14LL6GnA+066zNj
         CvejRlcjygKibP9g2QIAU7mp9kZxE//XWTqeXGb5jGlZ4xXSY9MBIVy3A8QFDDuzdGew
         Ky9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768819080; x=1769423880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oQ2bza/GhxjbFSXBJjgkzfILhnSLH4B1G1xiFJgsY3k=;
        b=pqZafRBGmt4Q5qbZl039E+QwWDcb8/PJL8f+yrN/F8bZDGLn4x3L6fwe+4duZegtri
         oKS/CJazswyuD44C3nIiXuutYqgZPp0DZeJkyYReopNRnYeC7j9C0q24IDjtFMZxEohm
         AjK6IHR0utvxOH+5bdjVNNS5YaQ4wvu8R0/9VkpLBzRns7d2Vd4Ta5s0JzR7mnot6pkU
         QI/ryO1IK+t2dcl0tY5KRVdVccLFd/b0Vjlx/a1HCVNHmzaYkYxCKr6XNGZSHWojgQZH
         9Yk10g+LX42b+gX69365yzW6EVHY04wxdDsFDrmqtEQmgePVI65GTCub5bv9b9NhSpQJ
         j8tA==
X-Forwarded-Encrypted: i=1; AJvYcCUS1YGOX72yk89f2/TLCD27n5+UXN3Xtlw6fMi8MKVY2aWxy2+iOH7HRRXTQojhN+N3yTMuIUdTtwib@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Y28FKJ31WiomwuK9ZB7z+/SX1IodmgIn9HJsS1OayFiAlHzE
	oA4c5iWEkq8GB3NuTZOcKW3Fvs7mreF3m3X/EIMeS90br1T4O5vekgr5
X-Gm-Gg: AY/fxX77CFpwfMHmRlfuw0g++JvAyUot3ZK91GOVVTE+9ITe2LX+G1GrWKpy6R4DK8H
	dNAKsTDPPYwDlcDNvecsIYtAqGLQjQ5mjauJYCSRQCn3XmGQDHuFabnjlmR1yWganHY3RGpTr2M
	kGVrG82FDUqHx+8jRvIrLxqJyvRRFaRoB5zyvQonSalf83/Dv/5rtncsYvBkToL3iRcypQv9BEK
	9Acv+1Q6fu+EYoRCw512O41YXKpsvgsbCj668smAELC0vvAz+PzaBc0vi7xc7wWJfEpP2vWtznC
	fcz4dXqtHbzOnY/GV4Gx3ZBzj7zUTNoqwiuMJldFxyMvXjF5AcRqTuLtcTg3O9WRJ/cpJ/ZlY6R
	DJlPuzZFSdcb/o39k7zS9f4eSpGlQne+bkqex55SVvwhABVAQTtQHmCbLWIpiRE+aGi3UqgD5eZ
	/GhSYpoUhV6BqZ9stMHFpvuH5z1MQ7MHkGsGtE9/vww5OPFd8SKCvd
X-Received: by 2002:a05:600c:37cc:b0:480:1b65:b741 with SMTP id 5b1f17b1804b1-4801eac97b9mr131919725e9.15.1768819079773;
        Mon, 19 Jan 2026 02:37:59 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe7bc14sm76766515e9.20.2026.01.19.02.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 02:37:59 -0800 (PST)
Date: Mon, 19 Jan 2026 10:37:58 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas.weissschuh@linutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andreas Larsson
 <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 4/4] asm-generic/bitsperlong.h: Add sanity checks for
 __BITS_PER_LONG
Message-ID: <20260119103758.3afb5927@pumpkin>
In-Reply-To: <20260119111037-4decf57f-2094-4fac-bcf4-03506791b197@linutronix.de>
References: <20260116-vdso-compat-checkflags-v1-0-4a83b4fbb0d3@linutronix.de>
	<20260116-vdso-compat-checkflags-v1-4-4a83b4fbb0d3@linutronix.de>
	<20260119100619.479bcff3@pumpkin>
	<20260119111037-4decf57f-2094-4fac-bcf4-03506791b197@linutronix.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Jan 2026 11:13:08 +0100
Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de> wrote:

> On Mon, Jan 19, 2026 at 10:06:19AM +0000, David Laight wrote:
> > On Fri, 16 Jan 2026 08:40:27 +0100
> > Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de> wrote:
> >  =20
> > > The value of __BITS_PER_LONG from architecture-specific logic should
> > > always match the generic one if that is available. It should also mat=
ch
> > > the actual C type 'long'.
> > >=20
> > > Mismatches can happen for example when building the compat vDSO. Eith=
er
> > > during the compilation, see commit 9a6d3ff10f7f ("arm64: uapi: Provide
> > > correct __BITS_PER_LONG for the compat vDSO"), or when running sparse
> > > when mismatched CHECKFLAGS are inherited from the kernel build.
> > >=20
> > > Add some consistency checks which detect such issues early and clearl=
y.
> > > The tests are added to the UAPI header to make sure it is also used w=
hen
> > > building the vDSO as that is not supposed to use regular kernel heade=
rs.
> > >=20
> > > The kernel-interal BITS_PER_LONG is not checked as it is derived from
> > > CONFIG_64BIT and therefore breaks for the compat vDSO. See the simila=
r,
> > > deactivated check in include/asm-generic/bitsperlong.h.
> > >=20
> > > Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> > > ---
> > >  include/uapi/asm-generic/bitsperlong.h | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >=20
> > > diff --git a/include/uapi/asm-generic/bitsperlong.h b/include/uapi/as=
m-generic/bitsperlong.h
> > > index fadb3f857f28..9d762097ae0c 100644
> > > --- a/include/uapi/asm-generic/bitsperlong.h
> > > +++ b/include/uapi/asm-generic/bitsperlong.h
> > > @@ -28,4 +28,18 @@
> > >  #define __BITS_PER_LONG_LONG 64
> > >  #endif
> > > =20
> > > +/* Consistency checks */
> > > +#ifdef __KERNEL__
> > > +#if defined(__CHAR_BIT__) && defined(__SIZEOF_LONG__)
> > > +#if __BITS_PER_LONG !=3D (__CHAR_BIT__ * __SIZEOF_LONG__)
> > > +#error Inconsistent word size. Check uapi/asm/bitsperlong.h
> > > +#endif
> > > +#endif
> > > +
> > > +#ifndef __ASSEMBLER__
> > > +_Static_assert(sizeof(long) * 8 =3D=3D __BITS_PER_LONG,
> > > +	       "Inconsistent word size. Check uapi/asm/bitsperlong.h"); =20
> >=20
> > nak...
> >=20
> > You can't assume the compiler has _Static_assert().
> > All the ones that do probably define __SIZEOF_LONG__.
> > You could use something 'old-school' like:
> > typedef char __inconsistent_long_size[1 - 2 * (sizeof(long) * 8 !=3D __=
BITS_PER_LONG))]; =20
>=20
> This is only used when building the kernel, it never actually reaches
> userspace. And all supported compilers for the kernel do have _Static_ass=
ert().
> As indicated by other users of _Static_assert() we have elsewhere in the =
tree.

Don't you need a check that it isn't wrong on a user system?
Which is what I thought it was doing.

The earlier check can also just be:

#if defined(__SIZEOF_LONG__) && __BITS_PER_LONG !=3D 8 * __SIZEOF_LONG__
#error Inconsistent word size. Check uapi/asm/bitsperlong.h
#endif

	David

>=20
> >=20
> > 	David
> >  =20
> > > +#endif
> > > +#endif /* __KERNEL__ */
> > > +
> > >  #endif /* _UAPI__ASM_GENERIC_BITS_PER_LONG */ =20


