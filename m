Return-Path: <linux-arch+bounces-9077-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1CC9C7CA0
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 21:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 705682816B9
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 20:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B58206055;
	Wed, 13 Nov 2024 20:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYFR4g+6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC286204F66;
	Wed, 13 Nov 2024 20:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731528529; cv=none; b=OADtGnHih+yeeUAoyD40blqw+vSlw2bKUpZlsAlpl3PMZWbarkqABV+9Wne8IrvgIuIpSdnV6d7Z/BE1VJIVQ1cR9v34Tf/nmVhDYgUcaLsDRd31Hs2yu4tJYB3/2wx1IchNM9qjiA9gv+177Vphlj9rZXsd9+CZ8najYYN1lzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731528529; c=relaxed/simple;
	bh=jXefo8XudMMorxCLLuteQ0VmelS+jmaq9LUBvGT6Hvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tT3CNR4tyBTYlY6Fy+PwObw7BGqXOUgukrOnEUcGqTxEzOrYrGozQ9Hd5Un2DyXdDEGbhXDevJ/hwHpAwB6483gvQKQTo33rXh/HvXW/nacQKnxPN18OzQcgjs71yL6QcfSEDsBycsQX+xeK+n+QPjK415HfkfX5nmt+tTzJP0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYFR4g+6; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb56cb61baso55679941fa.1;
        Wed, 13 Nov 2024 12:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731528526; x=1732133326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OacZP/tiZAd9bxMgqXYn+YFBmAcj2qaR00TAZkdFGrc=;
        b=XYFR4g+6FhbEF/A0AxgAFtyx2WwWXHjwq1GYnVuYSkK32VAWU/yUlhpIF1flbzOZwj
         8XnN7bPrgojXR1GnRjYIeis3Non7r0cjtUEtP1PsRAWCsC0F6O8Lw0nfoi9c+S8jL1sF
         /55MvUk3gAeG14CjfgnVNZSFr5djPSDsTAEk97eQ0EzbUI8mgWEXKFeXB+uffcaYVm5K
         1VW7mCHUU3xYaHDdZF9rx7sAetiwGNSpz+MWBoSbBVy+qd1hIQ9Bc0IdnTcHS7d54AHH
         0rF7AiR+AVGzlf8kKOtyfJsbGJEIzTdn1Hh7+7MNZA9zoYJcs9usq0CHMQVBdjdoy8b4
         F6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731528526; x=1732133326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OacZP/tiZAd9bxMgqXYn+YFBmAcj2qaR00TAZkdFGrc=;
        b=YtbBdlkKa88u0r0TJov3gz7fx7H1yJjNFtvSb+7ABsI7G2df0Pj7/6QvjBFU9eGLmA
         s3SLgvy3o4NI3ORjdwXRWrjnV0FTJEiKHNnYclLVhwQVPxbrdjPsTCFMmQ44YsawkaOl
         czWhcqkOwbjSjvery+5z6zt6sRwCvYdn2vM1x8t3fUZJCxjZ6D0bb1yOZr8DrvDM62EY
         wlAo5GTW3yOifK/UeRFkA/RlW016UWcWtbIK9BC5ukkm5Zk43+eetepUUP1ROLtbMRPC
         LPMbEoHW3L7q1jSPLFbZ3XZJoE8tCXk+NcMPDFaXyxFUkjs4FT0gdMVGlSmGQ+DKvZJA
         cbjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh5Ni4DaN5R6hN3P/DNm8QA7Bpex3CEcWHEuGsgk00k6VPzYq8yLtH1ZbnH34QnMvGBfXNmgtJsFLElO2r@vger.kernel.org, AJvYcCXmaC4L/UxqMSEtyzc6DWR4iRLQ7OKGQF/nyFS12qIL5SV+YrRdfoAij8Ir2LTykyteOAps9HyBMnUa@vger.kernel.org
X-Gm-Message-State: AOJu0YwLONwBAyQ4AhlzisNb3Pli+KZohoVmrdA4COS4UspcI7rczf9a
	Mr/KhVMnf9SK2Ld4FTr4cz4dLkW2QOoYdNc76pJbJK3MAWN2JeFHnYPR25Z0Prv4rDz1v/9WfCv
	VQECTIb5lXYS7Gr9oWdT4QHxZGDs=
X-Google-Smtp-Source: AGHT+IEJo8CGXetuwMFbv1W2aQKOun7/HjSLcAGLnb8agyhYJuKzN5jkatMrqHB1SqwQacuICSLD2qahbPJf14U4biM=
X-Received: by 2002:a05:651c:212a:b0:2fb:5688:55c0 with SMTP id
 38308e7fff4ca-2ff4c633485mr21641851fa.38.1731528525823; Wed, 13 Nov 2024
 12:08:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113120327.5239-1-suravee.suthikulpanit@amd.com>
 <20241113120327.5239-6-suravee.suthikulpanit@amd.com> <cac1ccd3-4b81-4374-a49d-9afad755b19c@app.fastmail.com>
 <20241113132031.GF35230@nvidia.com> <CAFULd4a1PHREX6ws9Gyu=TaaZvdgLfh6peoE5Tt010uGyY9Hgw@mail.gmail.com>
 <20241113140914.GI35230@nvidia.com> <CAFULd4aGDM5ySO-PeOH0+_U89mnqYqQ7v+U0ZsMode3bxs_X7w@mail.gmail.com>
 <20241113142807.GJ35230@nvidia.com> <CAFULd4aFvGj=kz5Si9WpAr33KFtJDO5+sdNO=NBB+boS=E-E_Q@mail.gmail.com>
 <20241113163451.GK35230@nvidia.com> <CAFULd4bvDhfSprPEyirvX9VmKK_fpxaVNRO02oqT_KQAdLFhfg@mail.gmail.com>
In-Reply-To: <CAFULd4bvDhfSprPEyirvX9VmKK_fpxaVNRO02oqT_KQAdLFhfg@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 13 Nov 2024 21:08:34 +0100
Message-ID: <CAFULd4bwyrsXFXJzZQnGyZsQo_RisQLR7qkjMdBBONQzp67xCg@mail.gmail.com>
Subject: Re: [PATCH v10 05/10] iommu/amd: Introduce helper function to update
 256-bit DTE
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, vasant.hegde@amd.com, 
	Linux-Arch <linux-arch@vger.kernel.org>, Kevin Tian <kevin.tian@intel.com>, jon.grimm@amd.com, 
	santosh.shukla@amd.com, pandoh@google.com, kumaranand@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 8:50=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> On Wed, Nov 13, 2024 at 5:34=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> =
wrote:
> >
> > On Wed, Nov 13, 2024 at 03:36:14PM +0100, Uros Bizjak wrote:
> > > On Wed, Nov 13, 2024 at 3:28=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.c=
om> wrote:
> > > >
> > > > On Wed, Nov 13, 2024 at 03:14:09PM +0100, Uros Bizjak wrote:
> > > > > > > Even without atomicity guarantee, __READ_ONCE() still prevent=
s the
> > > > > > > compiler from performing unwanted optimizations (please see t=
he first
> > > > > > > comment in include/asm-generic/rwonce.h) and unwanted reorder=
ing of
> > > > > > > reads and writes when this function is inlined. This macro do=
es cast
> > > > > > > the read to volatile, but IMO it is much more readable to use
> > > > > > > __READ_ONCE() than volatile qualifier.
> > > > > >
> > > > > > Yes it does, but please explain to me what "unwanted reordering=
" is
> > > > > > allowed here?
> > > > >
> > > > > It is a static function that will be inlined by the compiler
> > > > > somewhere, so "unwanted reordering" depends on where it will be
> > > > > inlined. *IF* it will be called from safe code, then this limitat=
ion
> > > > > for the compiler can be lifted.
> > > >
> > > > As long as the values are read within the spinlock the order does n=
ot
> > > > matter. READ_ONCE() is not required to contain reads within spinloc=
ks.
> > >
> > > Indeed. But then why complicate things with cmpxchg, when we have
> > > exclusive access to the shared memory? No other thread can access the
> > > data, protected by spinlock; it won't change between invocations of
> > > cmpxchg in the loop, and atomic access via cmpxchg is not needed.
> >
> > This is writing to memory shared by HW and HW is doing a 256 bit
> > atomic load.
> >
> > It is important that the CPU do a 128 bit atomic write.
> >
> > cmpxchg is not required, but a 128 bit store is. cmpxchg128 is the
> > only primitive Linux offers.
>
> If we want to exercise only the atomic property of cmpxchg16b, then we
> can look at arch/x86/lib/atomic64_set_cx8.S how cmpxchg8b is used to
> implement the core of arch_atomic64_set() for x86_32:
>
> SYM_FUNC_START(atomic64_set_cx8)
> 1:
> /* we don't need LOCK_PREFIX since aligned 64-bit writes
>  * are atomic on 586 and newer */
>     cmpxchg8b (%esi)
>     jne 1b
>
>     RET
> SYM_FUNC_END(atomic64_set_cx8)
>
> we *do* have arch_try_cmpxchg128_local() that declares cmpxchg16b
> without lock prefix, and perhaps we can use it to create 128bit store,
> something like:
>
> static __always_inline void iommu_atomic128_set(__int128 *ptr, __int128 v=
al)
> {
>     __int128 old =3D *ptr;
>
>     do {
>     } while (!arch_try_cmpxchg128_local(ptr, &old, val));
> }

Eh, I forgot that data does not change, so we don't need the cmpxchg loop.

static __always_inline void iommu_atomic128_set(__int128 *ptr, __int128 val=
)
 {
     arch_cmpxchg128_local(ptr, *ptr, val);
}

should do the trick.

Uros.

