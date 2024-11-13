Return-Path: <linux-arch+bounces-9069-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F3E9C747F
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 15:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008FB281E47
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 14:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9212A1DF978;
	Wed, 13 Nov 2024 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6ZXysYY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CDE1DF75C;
	Wed, 13 Nov 2024 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731508589; cv=none; b=hXpR2T4S5G+ER8tCPwihA2dWWJ6V6aaTNwqE3uQTKZUEeHVOxPpCETW3B9Ms0bN2ssZ9p+mSokQ+Ygs8ARqNdbXKVzcbycnFBvsEI/H5hUh9whUfLj10gX3bAMGigoMbu2CMr924Fy+ZMgR8VSC0gHuI2WHSq8YcKSCkUoDpXGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731508589; c=relaxed/simple;
	bh=XwRDW7jTJnaLywO/huBDE03/EPCXyw05QNbK9s3IMWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=frbiixpvFQU/izJA5YCyF0oD7nAzWOSOHLyN8gy34po1uefoXfvKXmzYlMK6R/YYSJPpjku+nBeKKSyF7N9EI1j4TVuGIRjoGy7gjhfUvAWdBFtcDJlIq48aEstAcyzj0IW3unHIyJA1dGQdzkpUgBY56goAM5ZX66vvErgbaBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6ZXysYY; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb51f39394so61634831fa.2;
        Wed, 13 Nov 2024 06:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731508586; x=1732113386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwRDW7jTJnaLywO/huBDE03/EPCXyw05QNbK9s3IMWo=;
        b=R6ZXysYYpj8PRN2HnuMsyVEO3oWockjIUVtME8LuGqjGiYvANc6b93mXH0/WydBmms
         JrmdxH2wFL47w/oalSxQR/HFzqxujxHuzESBycYNWe1cDy214WPV/hAAIdfu06hnGAVM
         4J0MVDsrm+corEQwlNOPbIK9eI1Vp7sgx2USS7R9jSzxG0o4PHdrn3VGXBj6lghlcy8O
         HCdGd8gZlCMO7duBxmJ7AEpzmW/8MG4bSowMtFGsYKx00i0epobOP+82Q8A3axqK1Hb7
         GuYImSMkMjVIuaS1jtAaFdv+Gtj0sG62mzhErU7S8BCOKXhPFOPi50thiTp47HbOpUb+
         K9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731508586; x=1732113386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XwRDW7jTJnaLywO/huBDE03/EPCXyw05QNbK9s3IMWo=;
        b=hIjX20FA+Z1PgsPCnftZrARy/GAZskNpxwJs/QyIZ++E6SFjaNFRXlcgNOZj2agmq/
         bjpkN3qYBqYmczcnWh4QGBvtfpK4pGI5RvwXu+d2oJEIyQ4/rXmZCOSFyU+wUKDD5IYM
         0c1Ee8Y8QScsaPWFR/G99Y4LeSJGxWoWpzkUUNJMuMY6cDI/KnH0/EXZ297dg+aLL1VE
         T+vSLAzLaZn03au/1n22yP3N0Xxudnhos/FEVcOUi8w5IUoi+Zr727JWepHvFxfCMU8c
         Pu5UnItEw3cT6UJBPQEWgh/xEHyCu4bi14ExtxbaPZFbkUSR1/4gWljDp6HIEslVjlTp
         ZZMg==
X-Forwarded-Encrypted: i=1; AJvYcCVG30YC0c78Dv/4hxch9Rf9kdUC7Kfln2qmLd9wXFd3DQOb4CrLLUx6fYbP0gnRMgi/oCVv6RMIiGTk@vger.kernel.org, AJvYcCWCuTweXVQ0CcA1IS/c8KXArVFWhNSBnsjRRJn/nPzCpxqjLo0OxT/6i4T7oLXFAg/dJm9pKOdzMXWBg6ZO@vger.kernel.org
X-Gm-Message-State: AOJu0YzujYSMa6UMAWZHPblk9DsmZu6QbDn5c2u04XM4CILtKYS/qalQ
	xsA9CQZxja8HzYmwpY9nxvHjW1Ha6kWr6GNvEwuCXxmJLfA3Yy2cY3YTgGZmslMXrpeQUfZDfMv
	J+CURFPwD9CYMOZ5+9OU9+5gfWYQ=
X-Google-Smtp-Source: AGHT+IHL0uCSsyj7twvRVICsE2iNascjnWtDXWCLjSArZnwdWGQaJDvqGaAMHyNX1vtCfrj7Q5embfR9Vbkeb/9DEfI=
X-Received: by 2002:a05:651c:160c:b0:2fa:d25e:39e4 with SMTP id
 38308e7fff4ca-2ff20309255mr114185031fa.36.1731508585585; Wed, 13 Nov 2024
 06:36:25 -0800 (PST)
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
 <20241113142807.GJ35230@nvidia.com>
In-Reply-To: <20241113142807.GJ35230@nvidia.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 13 Nov 2024 15:36:14 +0100
Message-ID: <CAFULd4aFvGj=kz5Si9WpAr33KFtJDO5+sdNO=NBB+boS=E-E_Q@mail.gmail.com>
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

On Wed, Nov 13, 2024 at 3:28=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Wed, Nov 13, 2024 at 03:14:09PM +0100, Uros Bizjak wrote:
> > > > Even without atomicity guarantee, __READ_ONCE() still prevents the
> > > > compiler from performing unwanted optimizations (please see the fir=
st
> > > > comment in include/asm-generic/rwonce.h) and unwanted reordering of
> > > > reads and writes when this function is inlined. This macro does cas=
t
> > > > the read to volatile, but IMO it is much more readable to use
> > > > __READ_ONCE() than volatile qualifier.
> > >
> > > Yes it does, but please explain to me what "unwanted reordering" is
> > > allowed here?
> >
> > It is a static function that will be inlined by the compiler
> > somewhere, so "unwanted reordering" depends on where it will be
> > inlined. *IF* it will be called from safe code, then this limitation
> > for the compiler can be lifted.
>
> As long as the values are read within the spinlock the order does not
> matter. READ_ONCE() is not required to contain reads within spinlocks.

Indeed. But then why complicate things with cmpxchg, when we have
exclusive access to the shared memory? No other thread can access the
data, protected by spinlock; it won't change between invocations of
cmpxchg in the loop, and atomic access via cmpxchg is not needed.

Uros.

