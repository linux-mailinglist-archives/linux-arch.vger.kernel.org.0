Return-Path: <linux-arch+bounces-2190-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638DC8517DD
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 16:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A53A283DE5
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 15:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42243C6AB;
	Mon, 12 Feb 2024 15:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pb7TQuAh"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEF23C694;
	Mon, 12 Feb 2024 15:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751446; cv=none; b=Jb5Q8xUZcF+role7K2rTTwm5HOMwiRSvH4bhR0SQvstc4I97qrJ82OrKJ1R5SQRec+047QqZIi7YNfB0J375/kDd1z0mgNLC2e7QKBSsuiPXnPU3IeXqkPARFQe6C+jlKEqDXZUprPSeo7uHBInBU0OfAf1nMTU1d9m5cW6wiJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751446; c=relaxed/simple;
	bh=WWUVJAhmle29IPDO4RHpaZbuj8n80ec/lO+P4P9s3sU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n1nV2cHLeQjZ7N3rXCY/kROOG3K1V4vsOqSKdDcRW9aZ9NlW0x2olqg9Im2dJ5msbFiZCcMbyc+YBkL14GsAoBsv+/weDsg14z17xGFebMs1Q7neV/IZ94b84MQr1ac7++yzfcTX3BvUDIrIONkTkP5sAjrv+Tl/WS2DFOLaAKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pb7TQuAh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3341CC43399;
	Mon, 12 Feb 2024 15:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707751446;
	bh=WWUVJAhmle29IPDO4RHpaZbuj8n80ec/lO+P4P9s3sU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Pb7TQuAh5LA2V0Z1dQbw1kV4UTkB48nJHh5Z7sC/btLGtAe5e9A1pMVEDYkxshldY
	 VguzMoWcI2M+N3bbvhtS0dLP0+pHzaSiK7F5dgAQi64/pCfVQStkqtzAhzavXURgB2
	 wtzkzz6aXMms0If8UyhaF9f3mod0RbGSfQxQ7+cvkiAg8jXcUU3cE7fVyqZTaIsKFO
	 WRrZWf0UTZqwRyiDk7e0O+S2eWYsmJ5KY8uo4DRj9vpeHoaXtn0DWmIYcLp61Vt5Nu
	 dPWJatH+M8jGWtmsL+qLgUPbKcJd2c72qZbpk40uV4GlarsmD6LwUHeg8LB7CeuoWj
	 6U0pLrcxB2mNw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-511490772f6so4043318e87.2;
        Mon, 12 Feb 2024 07:24:06 -0800 (PST)
X-Gm-Message-State: AOJu0YzQpL+F1BfV8Yavm1AFPSbEqdcU5Bdv2ySK/VuRH2QQwAMCVERT
	US8HufFcuJA5TjkTchpoQGTYiTFeZ8uudz6/bIvd+Qou8gO58VVeD1qsxdI4o/rmpOfRTVKXVeb
	piiVkQXSG3EZ0/V+wR9jKOOV0T8w=
X-Google-Smtp-Source: AGHT+IHIWYUd8/JvmBEqXUvmGaRWai49eznUC5vZoorTEhUDMCzAofBDgtcWjpFO1JFOZmeCNxyWxz6PBlsbAxS4kk0=
X-Received: by 2002:a05:6512:238d:b0:511:81ed:1a53 with SMTP id
 c13-20020a056512238d00b0051181ed1a53mr5043463lfv.42.1707751444365; Mon, 12
 Feb 2024 07:24:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129180502.4069817-21-ardb+git@google.com>
 <20240129180502.4069817-30-ardb+git@google.com> <20240212143717.GWZcotHRH-8a3x1gTH@fat_crate.local>
In-Reply-To: <20240212143717.GWZcotHRH-8a3x1gTH@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 12 Feb 2024 16:23:53 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGNnHzCWJB8RHYUqePRjN_k-8mRXKTM3B_Qq2je3k5iyQ@mail.gmail.com>
Message-ID: <CAMj1kXGNnHzCWJB8RHYUqePRjN_k-8mRXKTM3B_Qq2je3k5iyQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/19] x86/head64: Simplify GDT/IDT initialization code
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Glaze <dionnaglaze@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Feb 2024 at 15:37, Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Jan 29, 2024 at 07:05:12PM +0100, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > There used to be two separate code paths for programming the IDT early:
> > one that was called via the 1:1 mapping, and one via the kernel virtual
> > mapping, where the former used explicit pointer fixups to obtain 1:1
> > mapped addresses.
> >
> > That distinction is now gone so the GDT/IDT init code can be unified and
> > simplified accordingly.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/kernel/head64.c | 57 +++++++-------------
> >  1 file changed, 18 insertions(+), 39 deletions(-)
>
> Ok, I don't see anything wrong here and since this one is the last of
> the cleanup, lemme stop here so that you can send a new revision. We can
> deal with whether we want .pi.text later.
>

OK.

I'll have the next rev out shortly, thanks.

