Return-Path: <linux-arch+bounces-4359-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312EA8C44D1
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 18:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E9D4B20C09
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 16:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC5D15532B;
	Mon, 13 May 2024 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXWHZhb2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9604957CAA;
	Mon, 13 May 2024 16:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715616388; cv=none; b=PDFkcF1myS+Ib3wgPH+vNBO0sMQxfgI1Pxm7Md/JC9WqowL4oB54SAvdDPDpFjSgDhUQsvs8YQUdAmImoyWQSlsFK4EboJYUJ8JHlGCpsDvz05xI9D8Uu60degUy+gHHK/2atIyZs/i8IKqookTjDvvGZOralnXo8n3RP3fVhiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715616388; c=relaxed/simple;
	bh=W50rNf7/4M3f9bs48L2PLqWwglat3pectTPKAqzLpE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nove0LODtyyXFMnASD3KvpCofRM3ZXCZ1SH2sz1q3uAHLIndJk+PyGP0+js0v/dQaKG63aSZFlSFEB7Iv1A4L5YPRv82fDI1yQ0R2sczZ7pyveZpe0u24emhQihkdqnXUWfd+yp9Qoz1rb/dykjiv88YuxHYkIx+hwPlW15aNMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXWHZhb2; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-792b8cd0825so440614285a.0;
        Mon, 13 May 2024 09:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715616386; x=1716221186; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4gbmpq2Su2BRil5MNs27c7tp8UGhZaW53JUFnGusgs=;
        b=VXWHZhb2DRtUVc8byJgPMjYARlcAH2/t3cDkjf4r854CqLBpJuwEQfoudv+KDByfhX
         V/i+nVBUp3gbgIAqIzK11BEwYA+47Xj5S5+s/94IAxRryU5Dm88Fjy/hcaUPueyoCS1f
         yIvdPUBS0s7zPSHsts2Y7O0NG+whurjySHIdxZTxDhcrA/1TwkgemEAEd/Mtuw/kqlG3
         zDQUmIpepJX13c+5SaU3H0zZAsoPR2+mO8vRxl7n2T2EJ07Azzjgzs/YF5O8E80op3PG
         o3jmIp2p1etQpFiG/HM/i2ASkx5izaBLtDscSAi3tuN8JFQWn5NbsdXD6N8IkNSL/4Bh
         IsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715616386; x=1716221186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4gbmpq2Su2BRil5MNs27c7tp8UGhZaW53JUFnGusgs=;
        b=PYL4RCth+Wd2pTfUUGQC3RwW97/xitXgaX431t6tZHnJPchO9gPRJEiYWShLrDr8OC
         /P9kV2pTPewuuZYg2/x+ve9NlJnersuv2N1ZbLEtgfgmRnWZzJHu5oqH8/Xnf24Yds5v
         U8mKBdn69Up2692YnHb3cLvX1FQBc285AVrsmUr3ywZxakSHnYZiE84OytFAtahiNTh8
         SizZdxTfRMg45sJbnEyOBAHZJAXs8uN4DKMfEZWQkh63TMEk2y8WfoO9fm4VRaW4slhn
         C36GTd7cL96+MFJJI2baPfNMtPHuhHZ4dMgvHItGxuReJ1QBiyXn+itygoM7R3w2txFq
         pqIA==
X-Forwarded-Encrypted: i=1; AJvYcCUFXjt60CvQpujtYzXuTLEbOG/YKMiDjL4eTA3BkunTZ6qocFZCZywwNNucQsA1Eb2l1A7gpI+cCnecxPFb6OFO60iGPm9QKO8CSqDP
X-Gm-Message-State: AOJu0Yz7ZttpD8Y9IAj4OLNjcedsG37R1NKn0iMfyz+0sC5M1wAF8Flw
	7v3KoGa8PlyO2imrSDq96aYzz12yP4DDHeSToih9xR0OxS2JXG4u
X-Google-Smtp-Source: AGHT+IFdAVRXiyxWPKayMl7gu0mq1+1r0Cub8vE8UFevG5KbWhm49Zx4ObkCl/WFz76bkANc4YWCZw==
X-Received: by 2002:a05:6214:3d8d:b0:6a0:b9bf:3cb3 with SMTP id 6a1803df08f44-6a1681da9a9mr134617586d6.34.1715616386492;
        Mon, 13 May 2024 09:06:26 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1797ebsm44497456d6.4.2024.05.13.09.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 09:06:25 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id BDC64120006D;
	Mon, 13 May 2024 11:57:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 13 May 2024 11:57:25 -0400
X-ME-Sender: <xms:ZThCZr6gi8nYVWkrQmhy1JCVDspkAygljkopbm_0hOB6LOybFdB4hg>
    <xme:ZThCZg5B_H3aDA7HJydaJM3lClLk-65oMLLyEp6uF_OXWP1rUaKufZ_OVTkCqQ_PT
    9XRLJBZMBT-E8Gzug>
X-ME-Received: <xmr:ZThCZiefIlsCdbobQp44zxOJ0-nD7F3vZdWuFsRRpz7sFmIg2Szr3GWyrtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:ZThCZsI5krcXZBdHOG7YSGTuCiXq5SDQiS4OJ1yZxkSW1vyiXy-_mw>
    <xmx:ZThCZvKnQkB5Oh1VvJdPr-oD5m577T1ttls1CIreTVKFmSGzMCTRzA>
    <xmx:ZThCZlyKQ28ci07GMc8g6ggMDt3zVmk6anx9qGe-u6Y2kNBoxKKOqA>
    <xmx:ZThCZrIiftUZHmI9Zv8rkFUfMEAawGCpV-EfojHie9FSJVV9JzuM8A>
    <xmx:ZThCZqZ-qZplEvDtPtypIZpn2Vu7_6zrwDMOyoA_JpaQ2IsYkFalFINh>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 11:57:25 -0400 (EDT)
Date: Mon, 13 May 2024 08:57:16 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de,
	peterz@infradead.org, dianders@chromium.org, pmladek@suse.com,
	arnd@arndb.de, torvalds@linux-foundation.org, kernel-team@meta.com,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 cmpxchg 09/13] lib: Add one-byte emulation function
Message-ID: <ZkI4XPJLeCtabfGh@boqun-archlinux>
References: <b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop>
 <20240501230130.1111603-9-paulmck@kernel.org>
 <ZkInMNOsLO5XbDj5@boqun-archlinux>
 <9f0ff126-2806-488e-97cc-7258eff0c574@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f0ff126-2806-488e-97cc-7258eff0c574@paulmck-laptop>

On Mon, May 13, 2024 at 08:41:27AM -0700, Paul E. McKenney wrote:
[...]
> > > +#include <linux/types.h>
> > > +#include <linux/export.h>
> > > +#include <linux/instrumented.h>
> > > +#include <linux/atomic.h>
> > > +#include <linux/panic.h>
> > > +#include <linux/bug.h>
> > > +#include <asm-generic/rwonce.h>
> > > +#include <linux/cmpxchg-emu.h>
> > > +
> > > +union u8_32 {
> > > +	u8 b[4];
> > > +	u32 w;
> > > +};
> > > +
> > > +/* Emulate one-byte cmpxchg() in terms of 4-byte cmpxchg. */
> > > +uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new)
> > > +{
> > > +	u32 *p32 = (u32 *)(((uintptr_t)p) & ~0x3);
> > > +	int i = ((uintptr_t)p) & 0x3;
> > > +	union u8_32 old32;
> > > +	union u8_32 new32;
> > > +	u32 ret;
> > > +
> > > +	ret = READ_ONCE(*p32);
> > > +	do {
> > > +		old32.w = ret;
> > > +		if (old32.b[i] != old)
> > > +			return old32.b[i];
> > > +		new32.w = old32.w;
> > > +		new32.b[i] = new;
> > > +		instrument_atomic_read_write(p, 1);
> > > +		ret = data_race(cmpxchg(p32, old32.w, new32.w)); // Overridden above.
> > 
> > Just out of curiosity, why is this `data_race` needed? cmpxchg is atomic
> > so there should be no chance for a data race?
> 
> That is what I thought, too.  ;-)
> 
> The problem is that the cmpxchg() covers 32 bits, and so without that
> data_race(), KCSAN would complain about data races with perfectly
> legitimate concurrent accesses to the other three bytes.
> 
> The instrument_atomic_read_write(p, 1) beforehand tells KCSAN to complain
> about concurrent accesses, but only to that one byte.
> 

Oh, I see. For that purpose, maybe we can just use raw_cmpxchg() here,
i.e. a cmpxchg() without any instrument in it. Cc Mark in case I'm
missing something.

Regards,
Boqun

> 							Thanx, Paul
> 

