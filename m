Return-Path: <linux-arch+bounces-2484-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5183385A14C
	for <lists+linux-arch@lfdr.de>; Mon, 19 Feb 2024 11:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 845DA1C21EA6
	for <lists+linux-arch@lfdr.de>; Mon, 19 Feb 2024 10:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB1F2C68C;
	Mon, 19 Feb 2024 10:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PM6pzIX0"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688612C686;
	Mon, 19 Feb 2024 10:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708339672; cv=none; b=b25fYoGVOu6oYU7ACqgjUdOmUEX1c2teBf6j4HJuyaH7nqoVYlEGqfv3fUwrbDBW5cYRasBlm/ZB4IYKt9vMsf4y8DNaFhJSA6OMxO4rE9gaawQF82gpHQqZlSzDqGm/Qdbn50ymyCVmwXIiBcxsqvgFxtOiSQoSB2pYEscI+OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708339672; c=relaxed/simple;
	bh=Jfo6TfwmGwLUsV6LesciDk9MRgp2/h+EYgVBnXUJszM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g8tOKB9sM2CtglQhwcs0DeGfAvhrAn09ukxpy578yvoK5GwRwpJ2RAFDdlbu3CoHykBM6tVVNrwfNSf2zOmnEegRyVsmJJXI79qqSvC0B8/9OzoJ7A4TRzGaem8iI1yE4CCVPQ4q3od2VYthYcsy9UZ2BrP4QWqJIks/97OYbQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PM6pzIX0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC801C433C7;
	Mon, 19 Feb 2024 10:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708339672;
	bh=Jfo6TfwmGwLUsV6LesciDk9MRgp2/h+EYgVBnXUJszM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PM6pzIX03tt4ZjrxnYPJXPGUX5ADnjh07V73zqD2omNQ4Xk9qSfJfl3GsLdLJnffd
	 osYaXkKlJpqogY/SPg0hw1jVPJHtWPS1r9N6APmdJ87PXKsoc9GjxT4fFtkmgFOrR1
	 wvtMoS8iRqGbO5JMuv8sHJAdVZyrj9X9p7Sfor/wo433BXO0vGAM9VhhRj+LmuDDrk
	 pPDYP9aFdOFUkfTAZXOMwbd1F1LIHXzO/hYoj3X/6ImodrI7my9qlMbbuBGDHMDzl/
	 2Cg3vo0E0huhrCNGfaBoQL+h1RS6xZIg7zoLXAs3STouIJZaSC2+ox6jA9Aty5i06L
	 0ozKuW1QQq/JQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512bd533be0so344670e87.0;
        Mon, 19 Feb 2024 02:47:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUpdvI9Mf0CmQMGu4pAR3QfKyyTcN3Tg5i91pHmCnZZnCNdwXnfu8U47BCOoT4hjg8UzVmh98TkzQI39lCfeDlMSVJDrNYb2sDTxTNKrkttPlDqrAkffG9hRsIlLzhlj/A9rYnLZSncPw==
X-Gm-Message-State: AOJu0Yw33nuJbNyK+asppnUyFl3m2F64e519J5kcR1FuKY9ZsyK28h9I
	hZSe52SOQ8zrFMUAISIpBiXOBamJ8tBFsql1HzmPWu4MCNzy8aZewocsv/ifp+3/muu6Fy/ikki
	l7u8FCKeAz+W7rtBiynafIe9RUS4=
X-Google-Smtp-Source: AGHT+IGuVJ1P1iK/x+vOmrtC/tU48rUsDna2+oeh1glDTw2nC4sRpzBKFaqlDQkaZk6qcR3xVV+mXqWRMCazBcGGgSs=
X-Received: by 2002:a05:6512:609:b0:512:a984:267f with SMTP id
 b9-20020a056512060900b00512a984267fmr2885423lfe.58.1708339670239; Mon, 19 Feb
 2024 02:47:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213124143.1484862-13-ardb+git@google.com>
 <20240213124143.1484862-15-ardb+git@google.com> <20240217125102.GSZdCrtgI-DnHA8DpK@fat_crate.local>
 <CAMj1kXEcTfvRcNh_VDhj5QxzMhD9rFhVmeAfuSF7vm1c_4_iHg@mail.gmail.com> <20240219100124.GCZdMm9IAWoMcfEKhF@fat_crate.local>
In-Reply-To: <20240219100124.GCZdMm9IAWoMcfEKhF@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 19 Feb 2024 11:47:39 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH7CtN2j1os7Ujw7G_xtD2H0g=pfxNBLK=ayj4XGPkudA@mail.gmail.com>
Message-ID: <CAMj1kXH7CtN2j1os7Ujw7G_xtD2H0g=pfxNBLK=ayj4XGPkudA@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] x86/startup_64: Replace pointer fixups with
 RIP-relative references
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

On Mon, 19 Feb 2024 at 11:01, Borislav Petkov <bp@alien8.de> wrote:
>
> On Sat, Feb 17, 2024 at 02:58:29PM +0100, Ard Biesheuvel wrote:
> > More testing is always good, but I am not particularly nervous about
> > these changes.
>
> Perhaps but there's a big difference between testing everything as much
> as one can and *then* queueing it - vs testing a bit, not being really
> nervous about the changes and then someone reporting a snafu when the
> patches are already in Linus' tree.
>
> Means dropping everything and getting on that. And then imagine a couple
> more breakages happening in parallel and needing urgent attention.
>
> Not something you wanna deal with. Speaking from my experience, at
> least.
>

Not disagreeing with that.

> > I could split this up into 3+ patches so we could bisect any resulting
> > issues more effectively.
>
> Yeah, splitting changes into separate bits - ala, one logical change per
> patch - is always a good idea.
>
> In this particular case, I don't mind splitting them even more so that
> it is perfectly clear what happens and looking at those changes doesn't
> make people have to go look at the source to figure out what the change
> actually looks like applied, in order to fully grok it.
>

I split this into 5 patches for v5. The final patch in this v4 is
broken for CONFIG_X86_5LEVEL=n so I was going to have to respin
anyway. (I'll pick up the latest version of patch #1 you pasted)

