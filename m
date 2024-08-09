Return-Path: <linux-arch+bounces-6127-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0331194D1FE
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 16:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A17101F2331A
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 14:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB78196C6C;
	Fri,  9 Aug 2024 14:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WTxp6Je9"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D849193078
	for <linux-arch@vger.kernel.org>; Fri,  9 Aug 2024 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723213079; cv=none; b=sBM8AswRjOWCUsrYdMJO2tXBcZKeqLzqIPzhjzJEJt5Js7fYo4iPHVy4jsF5QJEtWfHxmGbCLMCW/Me4ZE+l3pnjJ9afcTp2aFa7eQjhqHmQiAuJ1s0D0vTrgdrovUpF8fbJpfbGrEKEqlSh3UTvHaK5Sl1bdKAmXw8cLjxGzWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723213079; c=relaxed/simple;
	bh=XOoT5lIIZ0pRM81fO0Euaca1XI+u9g4rBghoetfTgy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=koch21YaOm59xedRnVQIv7sEm3KULsvXn0qMCTWfSv7fLryiaPWjRAO81+wOmLfE3QyicABbHXfl+pSzfQQ6PxFKtHH3hvIjXZ5rbj/e0cH3/l+t67LhardIYHlj49aa+uMvmEIiChH07tIBR/W7+woh3/7mrGdnuex5WtkrpS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WTxp6Je9; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so9931a12.1
        for <linux-arch@vger.kernel.org>; Fri, 09 Aug 2024 07:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723213076; x=1723817876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOoT5lIIZ0pRM81fO0Euaca1XI+u9g4rBghoetfTgy0=;
        b=WTxp6Je999t+kn1Ow5M76Wtg9iLz+QJ6kALtH0vxLcMSRf0V0m33+9C7v3/mBWBZoD
         a8lKpuTztTJKt41fGLLCaVsSBDoXoKh1+Ni1T+wzhNpkfx2jNqihCqeX0hA8QMSbnXiO
         cpZKQ3iOeMriPjTODa+QgPBvkJGbk92agqgPKBwf/d6QuwYPlLyZGD1LHG+Cxfv1ocMY
         iM3Q+ow9T6UiG1tt0IOOd2adJVCEZgCEWSxiB7cmeaQZG/aeviCpoqnXhr2KyPl+2poU
         EE6MwjDmHSL2v7Z7vsS0ZLgSksztC5fu5VQ54j5fd0Or7yvrLE/xXlIufcbz29BVxm15
         9cUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723213076; x=1723817876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOoT5lIIZ0pRM81fO0Euaca1XI+u9g4rBghoetfTgy0=;
        b=OzJqyWW4hNe2WdYSmjqlANb8SU+bbAYhB5od1Y0dcEymkjpoF90F6Hn1hTwsfBCAQj
         1w09aemWqQmOrz9109yP7bqncp+G/PbO+f8SGc8dRWKum30zhtefO7V2qAJS35UbOlQd
         u5pFN0ptU7bHvf1E1kQJUINZRROV8hUZRTOIBpNBV03DCWR1KtK0QDtPX4GcI6MZT93S
         LTyxEiLOSvXI7WMOGBzXaLzUkG+79/u6YPY3YYdTSQFSp8+LoSZ+CGBDPSTx7wo8haaI
         oGkYxNnPW/4TL9DsLd9IubwVMzeKk9LtnGEsMVaCRH4A/TebfJIc2r5DqYJR8sAynxMu
         m7eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQflTGe+gJMFGTSiEEktusGuHf6HfHAtcG6/c9gO58WumcPB0g5S0yc9nxLzH1sZD5Evh40iN1S5vblCbFkK+qTAqJ/hWZzFPHbw==
X-Gm-Message-State: AOJu0YwTELAkJy6FTMHrrjEgRnuhrOW52CawFn6Po2SCOpoBNSdEIWpQ
	fzJJCa+EvOH4gPTJ2ZZeGWe69YE/3x2MosuCJX0vk0qx98SOc7mkErHyl18cd2CoJ+IPo1LtrhG
	aSmU1K1G5YLQksLUX42kMyy6J+I1jEgDNbakM
X-Google-Smtp-Source: AGHT+IG4FJuMRgOPLrNVllaBIrEDQBkPDDIpRd/2JU+QjaXaE3XDW4T5ngFYVh/mKQgDCJH+Vn9glx33KtIoCA3ICtA=
X-Received: by 2002:a05:6402:26c3:b0:5aa:19b1:ffc7 with SMTP id
 4fb4d7f45d1cf-5bbbc4d3f2bmr168346a12.2.1723213074852; Fri, 09 Aug 2024
 07:17:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-runtime-constants-refactor-v1-1-90c2c884c3f8@google.com>
 <dba4f23f-385c-4b8c-84ee-cb2a7c791aae@app.fastmail.com> <CAG48ez1hJg+178Z8i6Toc1dBYBF4O2jm7HNZy-a594En6AP5Ug@mail.gmail.com>
In-Reply-To: <CAG48ez1hJg+178Z8i6Toc1dBYBF4O2jm7HNZy-a594En6AP5Ug@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 9 Aug 2024 16:17:16 +0200
Message-ID: <CAG48ez2vzhYcgt2dtZLx0j6eK92xEHwjFfowg57fAuhQ-0_zCg@mail.gmail.com>
Subject: Re: [PATCH] runtime constants: move list of constants to vmlinux.lds.h
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 12:00=E2=80=AFAM Jann Horn <jannh@google.com> wrote=
:
> On Tue, Jul 30, 2024 at 11:29=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wr=
ote:
> > On Tue, Jul 30, 2024, at 22:15, Jann Horn wrote:
> > > Refactor the list of constant variables into a macro.
> > > This should make it easier to add more constants in the future.
> > >
> > > Signed-off-by: Jann Horn <jannh@google.com>
> > > ---
> > > I'm not sure whose tree this has to go through - I guess Arnd's?
> >
> > This is for 6.12, right?
>
> Yeah.
>
> > I can take it through the asm-generic
> > tree if that helps, but someone else should review it first.
> >
> > If you have any other patches that would depend on this patch,
> > you can also take it through the other tree and add
> >
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> >
> > for cross-architecture bits.
>
> Thanks!
>
> I was thinking of maybe trying to write a patch based on it that'd
> have to go through the MM tree (for using this in kfence), though I'm
> not sure whether I'll actually do that yet. So your suggestion makes
> sense, maybe hold off on putting this in a tree for now...

I don't think I'll get around to doing anything on top of this patch
for the next few months at least, please take it through your tree.

