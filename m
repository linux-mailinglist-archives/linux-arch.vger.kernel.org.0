Return-Path: <linux-arch+bounces-3022-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1791E87E875
	for <lists+linux-arch@lfdr.de>; Mon, 18 Mar 2024 12:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A5E2824D8
	for <lists+linux-arch@lfdr.de>; Mon, 18 Mar 2024 11:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDD53BBE9;
	Mon, 18 Mar 2024 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jV8esOJk"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B47C3BBE2;
	Mon, 18 Mar 2024 11:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710760813; cv=none; b=iTNqqOq5SwkE0TvDOGiZqlzltESTsWD3EmwZ5qTWICJ6nc3BCTyon3s5VAjFWVXYkYf5WiI3O6nZjDUy7Ly2oDNJ/qeOLDPWFZ7MnqOhecaUeocuGJJBlcRlgVS9Ra5JsHZuEkzkQS+0MAK7li+kXWrc7BTyvgJ5PbLb+WScF/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710760813; c=relaxed/simple;
	bh=BL1bAqpLJmyZg3Nv7cSa0Llbm5MKvY0HFvK/cxp2F1s=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MhfsD87kMLZfBaEF6ZSnb2wqLmKxpusXSmaClQ0lwczo5CLxM66N628Wq4xhL4tXFqumwN8rsm6Nq5JTLSWvLOt30Vn/wcnB2j/HX2IHCJwJu7d5lmcm4w/qeKYiz50cHx9UUivEAH8vxonkawyh2CxugnQ3Fvw9xIqF0zlOLm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jV8esOJk; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e6aa5c5a6fso4123876b3a.0;
        Mon, 18 Mar 2024 04:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710760812; x=1711365612; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4Mt4p7wAOdgiDEHZhgd4EK4q9C+aV5jj64LBCK23vI=;
        b=jV8esOJkRaZErKopnzHJUVO1VxyMr7L5iRbvS+F8yWjK0SSusWg0Gz6GZJ4FRZYEdg
         DuE7AakZoHllV9h74E52VLO/fP/gh7pBVXkv1UkEr8UOpRBEIn8uK+Bf+D8E4VI3MVeQ
         4P2wgVQsJlv7CFX11+wt4eq9OhlRajmFsX4vwSWr+zepyIrRmSVNZLdQuMJWtg0QGBRG
         vsJLs9RVno+CJKOti0Gn3oTo7oBg7mqn5HltKWtKpecDHPfxLB/zq4F3Uju22l4aVSO6
         SAl/mFqFFxZj8lSFcQAzhkoCaVQTnTqOOrtiAk/8c1QmnYexDQD9BgnCBdleLOe1zMi5
         94mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710760812; x=1711365612;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4Mt4p7wAOdgiDEHZhgd4EK4q9C+aV5jj64LBCK23vI=;
        b=R23chMUdlv7Ksv1NIIs+VVhaC5W7Mv7mFWaGD0XU9rswzUCTwX3mJj2yJasNdxwdq1
         t8lRgvH6eNAMI2Ls4lvW/pOFvajB3fidXggx1AudeP9J5FKuOarP+QRFyenoPpVyL2Q7
         /P2lWhM3nSPh2t1zpuSYvnhFZTvJnmaNuaU45pafBD21fcLILbX41ifsNApG3Vbgj6K7
         AUUhmcm6uwrOvgf8G9K4oXdAms7/TnbvB5novxCaFlqBzkUUzYhXevlrCMSniYv0tJe8
         J5dBsjWVH2Dn+2cGzO+4Rp+n44okAqZmu+yQhN8Q1/tYB30/kxZ/NdQfhAe0oXs323LC
         mVVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuQqbMJ77bhFu7iZz52oG/XMblpGky1AD64NwMeyxxyejKbD01VJfTdoLjTZIZHJYP3kyg/qzjsEnaoWimyIT+3rYEww8xWog+jsxaZqi+11WeZdky9jIX0oi5R+Dwaw==
X-Gm-Message-State: AOJu0Yw2jU8uKstFW6sx0sA/6FUl0HBvHXnxKqfrmiGbgyo+AuUopoWz
	moyzFH4C9IdQInzvzpSUy4iYiOY3Ph130sZmtV3S6FMnuSTYd8qZkcsbONuR/4w=
X-Google-Smtp-Source: AGHT+IEdFUYWwwKy448XkqDQFgP4aaQCiDD4BnuDEW8jsHO74CNqSRvy4lZcAPVnSbc+0/+9tf/0Pw==
X-Received: by 2002:a05:6a20:9f87:b0:1a3:6b56:d4d8 with SMTP id mm7-20020a056a209f8700b001a36b56d4d8mr704884pzb.48.1710760811728;
        Mon, 18 Mar 2024 04:20:11 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902b78b00b001dd75d4b408sm8946380pls.302.2024.03.18.04.20.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2024 04:20:11 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: Question about ISA2+pooncelock+pooncelock+pombonce litmus
From: Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <17ddc858-a926-4f12-beda-3f54cb91bfbb@paulmck-laptop>
Date: Mon, 18 Mar 2024 19:19:56 +0800
Cc: linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org,
 rcu@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E73E4593-DFA7-4A46-924C-3867CC0B4807@gmail.com>
References: <12E5C279-ADB1-463E-83E2-0A4F5D193754@gmail.com>
 <17ddc858-a926-4f12-beda-3f54cb91bfbb@paulmck-laptop>
To: "Paul E . McKenney" <paulmck@kernel.org>
X-Mailer: Apple Mail (2.3774.300.61.1.2)



> 2024=E5=B9=B43=E6=9C=8818=E6=97=A5 07:02=EF=BC=8CPaul E. McKenney =
<paulmck@kernel.org> wrote=EF=BC=9A
>=20
> On Mon, Mar 18, 2024 at 01:47:43AM +0800, Alan Huang wrote:
>> Hi,
>>=20
>> I=E2=80=99m playing with the LKMM, then I saw the =
ISA2+pooncelock+pooncelock+pombonce.
>>=20
>> The original litmus is as follows:
>> ------------------------------------------------------
>> P0(int *x, int *y, spinlock_t *mylock)
>> {
>> spin_lock(mylock);
>> WRITE_ONCE(*x, 1);
>> WRITE_ONCE(*y, 1);
>> spin_unlock(mylock);
>> }
>>=20
>> P1(int *y, int *z, spinlock_t *mylock)
>> {
>> int r0;
>>=20
>> spin_lock(mylock);
>> r0 =3D READ_ONCE(*y);
>> WRITE_ONCE(*z, 1);
>> spin_unlock(mylock);
>> }
>>=20
>> P2(int *x, int *z)
>> {
>> int r1;
>> int r2;
>>=20
>> r2 =3D READ_ONCE(*z);
>> smp_mb();
>> r1 =3D READ_ONCE(*x);
>> }
>>=20
>> exists (1:r0=3D1 /\ 2:r2=3D1 /\ 2:r1=3D0)
>> ------------------------------------------------------
>> Of course, the result is Never.=20
>>=20
>> But when I delete P0=E2=80=99s spin_lock and P1=E2=80=99s =
spin_unlock:
>> -------------------------------------------------------
>> P0(int *x, int *y, spinlock_t *mylock)
>> {
>> WRITE_ONCE(*x, 1);
>> WRITE_ONCE(*y, 1);
>> spin_unlock(mylock);
>> }
>>=20
>> P1(int *y, int *z, spinlock_t *mylock)
>> {
>> int r0;
>>=20
>> spin_lock(mylock);
>> r0 =3D READ_ONCE(*y);
>> WRITE_ONCE(*z, 1);
>> }
>>=20
>> P2(int *x, int *z)
>> {
>> int r1;
>> int r2;
>>=20
>> r2 =3D READ_ONCE(*z);
>> smp_mb();
>> r1 =3D READ_ONCE(*x);
>> }
>>=20
>> exists (1:r0=3D1 /\ 2:r2=3D1 /\ 2:r1=3D0)
>> ------------------------------------------------------
>> Then herd told me the result is Sometimes.
>=20
> You mean like this?
>=20
> Test ISA2+pooncelock+pooncelock+pombonce Allowed
> States 8
> 1:r0=3D0; 2:r1=3D0; 2:r2=3D0;
> 1:r0=3D0; 2:r1=3D0; 2:r2=3D1;
> 1:r0=3D0; 2:r1=3D1; 2:r2=3D0;
> 1:r0=3D0; 2:r1=3D1; 2:r2=3D1;
> 1:r0=3D1; 2:r1=3D0; 2:r2=3D0;
> 1:r0=3D1; 2:r1=3D0; 2:r2=3D1;
> 1:r0=3D1; 2:r1=3D1; 2:r2=3D0;
> 1:r0=3D1; 2:r1=3D1; 2:r2=3D1;
> Ok
> Witnesses
> Positive: 1 Negative: 7
> Flag unmatched-unlock
> Condition exists (1:r0=3D1 /\ 2:r2=3D1 /\ 2:r1=3D0)
> Observation ISA2+pooncelock+pooncelock+pombonce Sometimes 1 7
> Time ISA2+pooncelock+pooncelock+pombonce 0.01
> Hash=3Df55b8515e48310f812aa676084f2cc88
>=20
>> Is this expected?=20
>=20
> There are no locks held initially, so why can't the following
> sequence of events unfold:
>=20
> o P1() acquires the lock.
>=20
> o P0() does WRITE_ONCE(*y, 1). (Yes, out of order)
>=20
> o P1() does READ_ONCE(*y), and gets 1.
>=20
> o P1() does WRITE_ONCE(*z, 1).
>=20
> o P2() does READ_ONCE(*z) and gets 1.
>=20
> o P2() does smp_mb(), but there is nothing to order with.
>=20
> o P2() does READ_ONCE(*x) and gets 0.
>=20
> o P0() does WRITE_ONCE(*x, 1), but too late to affect P2().
>=20
> o P0() releases the lock that is does not hold, which is why you see
> the "Flag unmatched-unlock" in the output.  LKMM is complaining
> that the litmus test is not legitimate, and rightly so!


Oh! I missed that line, Thank you for pointing this out! :)

>=20
> Or am I missing your point?
>=20
> Thanx, Paul



