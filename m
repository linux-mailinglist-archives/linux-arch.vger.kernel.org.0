Return-Path: <linux-arch+bounces-2558-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D366A85D6BA
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 12:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744541F22439
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 11:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493173FB3C;
	Wed, 21 Feb 2024 11:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIDZjQNe"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDA13F8DE;
	Wed, 21 Feb 2024 11:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708514494; cv=none; b=mIA0C2haYMicpc7GjUfJGhOBfKLb/rGhTiVjBLNiFIv4CKxnNqHXu3DOQDFJjH3v2FDsBzyAy/Evok1vTla6XPsYM01JzXGyo0uIUbmghDNyWhT1zxEeYpqqmygmZ6aIXfP52siFTm5jb4yehEpaL+kF+HkqSvaW01/qlK5DJC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708514494; c=relaxed/simple;
	bh=o0CqUPepkCs4CIXUQmn68WLLpOl3MGSW9LG6aS9an1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sxsRDGG/2fqGK9qS7cwlkAkDFaAeZZOf7kNyQ007A0fKiI5F/JcGmYxIcz4U9zJWaAZnCs4NYnvTh+E7OFsYKnxpyzmGkS++UvmwKJ/Ss2SCO0JtBFRKo/Wev8a+CA2KyBZUKwpv8p5XWALVhkcQMNaOJTLTGe+qcbhZWo+RqrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIDZjQNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF332C43330;
	Wed, 21 Feb 2024 11:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708514493;
	bh=o0CqUPepkCs4CIXUQmn68WLLpOl3MGSW9LG6aS9an1M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UIDZjQNenQnobihqE49sOc2MzYna0gFzBVSsOmHAyxxjANs4hfMGTWNntJ4L+1LfX
	 p+UXKCkO0GykJvj9CJux0EuOSGLIvk/7s3SkhEYbLTK1eD/g9QDoOFlFF+wD/LtbCB
	 dPj6cnCu5Ng+dEmBlBaVIxFcZ5K/CkO/06gvgPB36D8MpO9kphbWa1ZwBmbBzFBt4+
	 yfr0pYmm7ozVkUtxSlpiA8Q9tETh5ZCtcCrpzXomkMmcAOr3SpQH5FxRpKuXX9sBHr
	 FZxqYlpqmUiFjV+SLT60+SCo7vHX4o/pJDyEmyNxSD7WVBOwJxLaWzWTesrG8fA5ue
	 intdUM1dSDTFA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-512d19e2cb8so659859e87.0;
        Wed, 21 Feb 2024 03:21:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWh8PTf/Q2YK3b9OILooe+s5p2OmWmj3qVmmgwsvbLmld9pzqyhTSlB0nM4RJ7HAIzEZTHqcSgPruSz/46JD4CkovFYVA2+SlrWlg==
X-Gm-Message-State: AOJu0Ywcpvf33yT21/ZvG123/WMHAsf38FE/vIB/Xg96jFYMDu78yqc7
	7g7IrfBi1aH99tkO/07OkHmPvXSbVGD2Oq6sjKvuSLx+TARu4qnGylKq61j2cNgV3qIFhmv2OP6
	AUFcMbXfgY4zU6HwAIC+/ZnOcImw=
X-Google-Smtp-Source: AGHT+IFItFVuoCUXnrWGruHwPbQE2pZbaQLwrHXniho9YmMHt/jsPGHVp4KFocto40/DeSjOaOAGLl9Ln5KUPWGiUcg=
X-Received: by 2002:a05:6512:744:b0:512:9de5:baf1 with SMTP id
 c4-20020a056512074400b005129de5baf1mr5617243lfs.34.1708514492059; Wed, 21 Feb
 2024 03:21:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213124143.1484862-13-ardb+git@google.com>
 <20240213124143.1484862-17-ardb+git@google.com> <20240220184513.GAZdTzOQN33Nccwkno@fat_crate.local>
 <CAMj1kXF=cGHR4FVUqGrobjB4HxTmm=1upn3TpVEC-_8D9GM=uQ@mail.gmail.com>
 <20240221100916.GCZdXLzHb-31GMw-f-@fat_crate.local> <CAMj1kXGqHf3b3zho_0CPccTkgXRnTrxsG_qDjhP9P+US-u2AGw@mail.gmail.com>
 <20240221111245.GDZdXarZsZd7eZw_BK@fat_crate.local>
In-Reply-To: <20240221111245.GDZdXarZsZd7eZw_BK@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 21 Feb 2024 12:21:20 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFNFxARF4bmB=a2PWT8uYLacs0GxOGkP319RLXH9Q0k7A@mail.gmail.com>
Message-ID: <CAMj1kXFNFxARF4bmB=a2PWT8uYLacs0GxOGkP319RLXH9Q0k7A@mail.gmail.com>
Subject: Re: [PATCH v4 04/11] x86/startup_64: Defer assignment of 5-level
 paging global variables
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 12:13, Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Feb 21, 2024 at 11:20:13AM +0100, Ard Biesheuvel wrote:
> > Just the below should be sufficient
> >
> > --- a/arch/x86/include/asm/pgtable_64_types.h
> > +++ b/arch/x86/include/asm/pgtable_64_types.h
> > @@ -22,7 +22,7 @@ typedef struct { pteval_t pte; } pte_t;
> >  typedef struct { pmdval_t pmd; } pmd_t;
> >
> > -#ifdef CONFIG_X86_5LEVEL
> >  extern unsigned int __pgtable_l5_enabled;
> >
> > +#ifdef CONFIG_X86_5LEVEL
> >  #ifdef USE_EARLY_PGTABLE_L5
>
> Perhaps but the CONFIG_X86_5LEVEL ifdeffery is just ugly and getting
> unnecessary.
>

That all gets ripped out in the last patch.


Btw v5 is good to go, in case you're ok switching to that:

https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=x86-pie-for-sev-v5

