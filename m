Return-Path: <linux-arch+bounces-2309-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B0B853DAC
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 22:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9474228FB3A
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 21:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2426633E5;
	Tue, 13 Feb 2024 21:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWHFyXYV"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892AA633E3;
	Tue, 13 Feb 2024 21:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861205; cv=none; b=bzxIn3Q1K0FtcppCNxzZBrcVC87qVA/PAMsz50rfnQ3Bq6Y+02GlGYwbA2n9Q0fzziaHNOFR/xIPCd7gJgAo/IZbR399tbc7NdXAd3+l80GXWSePkDsdqTD+P9Oz4PDtwmaJZbSacVSrJS1JmIvtj7aG6KJufIHOUdQJ3NsUQH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861205; c=relaxed/simple;
	bh=ypsd4qCVKyRg4P72ROtfXjYfv/4viAmzHOaYW9On954=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rliv6FSWhpkmkUn8fY31boHm9WHL06ZNZX11xM/27dvsQ4BLi7SVl7fytBw17Ff2M4JJyZgkpmTjkw+1QifU9gr1MtMaZfLc03Xu30qKb9eKUXCKqlikVqTFQWAXxf5oud5DryqeMzt1P5fWIPS5ik4KJkbbVcVwvz+XuCMgajU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWHFyXYV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079F2C43330;
	Tue, 13 Feb 2024 21:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707861205;
	bh=ypsd4qCVKyRg4P72ROtfXjYfv/4viAmzHOaYW9On954=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DWHFyXYVp4iq6KvgaS58guwBLRO4XExU7t2Xq8mw2VriPS90cTmklK39DTLHbMghb
	 wIMAVFxoUWt0XvMae99p6uHuzOoY/cKmvMxLsd3MdDT+6RpPsSbSZMi2j+cxxZU2B2
	 BLL1d7piuoqfYl4/ZvXJBBxW0b99Xb4BAWMhleB50j00Oo9BYR7GNcX24YiOZ3hG9O
	 wkQ2QvALdK1wGcZ45HVxQ2v5prPOYL6LrYqS7+M6NqYLMrhEzdrdUoOrG+NE1zYBI2
	 epqXY96FACeQatfO+fJstw6VZyq81Irj/xicVZ1O4yfMecwV93KS3MrJsANbDTp0wx
	 YMZcDwv68GjQQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50eac018059so6241550e87.0;
        Tue, 13 Feb 2024 13:53:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX1uqVX96VY2S8Q/e+PwCCOBMrzbMkfnDQXhOZg0uY1BlfmS0KP70nDjuzcpLpkU2EVwWo2eU4COLGSdywTjJkgy6qe4saQezAJZiFT3rJKx5yiaipWqqarQWNUC6sfc5+ExsmslcqENA==
X-Gm-Message-State: AOJu0YzfMLURR/RYcd/G2wlls7wgnH7OtFJ5Ck9K1XsMb7cpFDKl8YqW
	d79Ut2zheQGm6PdahS+Jq+9QkXgdF2y5RbXEDgjT/kBG2xfjEB3MaEg7ZvV7/4Srt5ZxVtsOU0G
	M3CGwXfcj7DxwtwJTDXfHEJBmG+c=
X-Google-Smtp-Source: AGHT+IHI/s6AqAn4+gru9C0sK+MSMCHjVDZCoWnZOEyshAgWQ/HKDfdgJQ1z+yWdf4EQX/rZlJTNkQkm844cBmWgoGY=
X-Received: by 2002:a05:6512:32bb:b0:511:6ff9:8b8d with SMTP id
 q27-20020a05651232bb00b005116ff98b8dmr506646lfe.59.1707861203095; Tue, 13 Feb
 2024 13:53:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213124143.1484862-13-ardb+git@google.com>
 <20240213124143.1484862-14-ardb+git@google.com> <20240213200553.GYZcvLoYUNJOPGxoid@fat_crate.local>
In-Reply-To: <20240213200553.GYZcvLoYUNJOPGxoid@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 13 Feb 2024 22:53:11 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG4rSGaB8Q2qFcgOH=dqS0yvR8Ofur=h5C-jq_TqiFzVg@mail.gmail.com>
Message-ID: <CAMj1kXG4rSGaB8Q2qFcgOH=dqS0yvR8Ofur=h5C-jq_TqiFzVg@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] x86/startup_64: Simplify global variable
 accesses in GDT/IDT programming
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

On Tue, 13 Feb 2024 at 21:06, Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Feb 13, 2024 at 01:41:45PM +0100, Ard Biesheuvel wrote:
> > @@ -632,5 +616,5 @@ void __head startup_64_setup_env(unsigned long physbase)
> >                    "movl %%eax, %%ss\n"
> >                    "movl %%eax, %%es\n" : : "a"(__KERNEL_DS) : "memory");
> >
> > -     startup_64_load_idt(physbase);
> > +     startup_64_load_idt(&RIP_REL_REF(vc_no_ghcb));
>
> It took me a while to figure out that even if we pass in one of the two
> GHCB handler pointers, we only set it if CONFIG_AMD_MEM_ENCRYPT.
>
> I think this ontop of yours is a bit more readable as it makes it
> perfectly clear *when* the pointer is valid.
>

Looks fine to me.

> Yeah, if handler is set, we set it for the X86_TRAP_VC vector
> unconditionally but that can be changed later, if really needed.
>

We might call the parameter 'vc_handler' to make this clearer.

