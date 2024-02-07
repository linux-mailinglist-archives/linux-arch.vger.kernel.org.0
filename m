Return-Path: <linux-arch+bounces-2110-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF4284C8C0
	for <lists+linux-arch@lfdr.de>; Wed,  7 Feb 2024 11:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707BE1F24CAF
	for <lists+linux-arch@lfdr.de>; Wed,  7 Feb 2024 10:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5411C14281;
	Wed,  7 Feb 2024 10:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NN9Y0w6+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C30B1426E;
	Wed,  7 Feb 2024 10:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707302314; cv=none; b=on/Vpp8XptZgmd7spJY8T5NCdtVXcowXRcWSiFWtCQyC/8a9QsoMnsFbzFJB+DeUZQY7S9ffhV3mqiLHUwlVfSxp0u9e8ZXp1G2WpIm+l5SA+fPN1yWWUtUtJdFdxiHL3R3ZtsCfUSCee2Dnk6BmKWIvfRn+fNfYekN3gnmQ4HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707302314; c=relaxed/simple;
	bh=FWbEreueJluHj4F9vtAt86rpsaVoRwnaO9NeDbW+SKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VJZql97Ywizelb37Ef2ydDrpTbWB/M4BhKob9yBAQbAR593WbA7cZ3nsmPlryS73WmzpqvceylFSoj8fzha7GA6sC0vRv6irXoA0PGKEAw0wX89q7ktWvbuHkAcvPDlAPNbuT69FPggdq/nic5LZhAttFdO8CU9D5cTF3T8cnYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NN9Y0w6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D91C43399;
	Wed,  7 Feb 2024 10:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707302313;
	bh=FWbEreueJluHj4F9vtAt86rpsaVoRwnaO9NeDbW+SKg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NN9Y0w6+TdfLk3tEI/W4ss984jiERW1WCQem3fEkwo6U/zE5375c7TYNbQsFkqv9j
	 Qh1LZOtSCwx0sVzUvfEx+Mzed2dMup2wJ7gMBq0mF8tUuWtgEnswhmdZHfBldN1vNu
	 nVfwV+A6ytim15wTOkV0Qa+n4nnnmtN82t2t0/UsHVKnHEQJeNyGona0sVBxQMYaUz
	 GtZ6guy5cw47oS4afmfh5I58cCVunNPZCFWghgKSUrQHTuTfkDJRevc41Gp4Mp/0vU
	 SHSUorlRGkZtqX/TfHGqMKwdTQrFPyhH1aDadvlDXtkoq58ebDC82Ue0G94+cwDPQ9
	 dpG+4DkiNI13g==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51167496943so593382e87.2;
        Wed, 07 Feb 2024 02:38:33 -0800 (PST)
X-Gm-Message-State: AOJu0YxLAI2opJ+z8M/a/xCtl64C1IrEyy9b4pvONAAwLh0N+0V0P3Ux
	cbHjOObenPuZTjSea2QWRl4T8MtPijB9pO+Sfd8qy58kBaVTt3uS7GYWE8d4I3hx2DAUg80RqMl
	g/dQ8pL9adxtNYuAqKbsjha+xbys=
X-Google-Smtp-Source: AGHT+IGCsLsNerHiyZfPicRQ5mUAOoXrr1xuP8AL/u/lxddJxawnyhu/RtkksM4KM0BCFZzbxttbdI9MARtctBCj8qA=
X-Received: by 2002:a05:6512:33cb:b0:511:4f8c:c299 with SMTP id
 d11-20020a05651233cb00b005114f8cc299mr4496166lfg.13.1707302311964; Wed, 07
 Feb 2024 02:38:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129180502.4069817-21-ardb+git@google.com>
 <20240129180502.4069817-26-ardb+git@google.com> <20240206182115.GQZcJ4m6amwGCc7D4Z@fat_crate.local>
In-Reply-To: <20240206182115.GQZcJ4m6amwGCc7D4Z@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 7 Feb 2024 10:38:20 +0000
X-Gmail-Original-Message-ID: <CAMj1kXFtjsw9rge76P1Q=4-1emXBbQeaLsgLS9oZkm0=kUJ4mg@mail.gmail.com>
Message-ID: <CAMj1kXFtjsw9rge76P1Q=4-1emXBbQeaLsgLS9oZkm0=kUJ4mg@mail.gmail.com>
Subject: Re: [PATCH v3 05/19] x86/startup_64: Simplify CR4 handling in startup code
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

On Tue, 6 Feb 2024 at 18:21, Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Jan 29, 2024 at 07:05:08PM +0100, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > When executing in long mode, the CR4.PAE and CR4.LA57 control bits
> > cannot be updated,
>
> "Long mode requires PAE to be enabled in order to use the 64-bit
> page-translation data structures to translate 64-bit virtual addresses
> to 52-bit physical addresses."
>
> which is actually already enabled at that point:
>
> cr4            0x20                [ PAE ]
>
> "5-Level paging is enabled by setting CR4[LA57]=1 when EFER[LMA]=1.
> CR4[LA57] is ignored when long mode is not active (EFER[LMA]=0)."
>
> and if I had a 5-level guest, it would have LA57 already set too.
>
> So I think you mean "When paging is enabled" as dhansen correctly points
> out.
>

Ack.

> > and so they can simply be preserved rather than reason about whether
> > or not they need to be set. CR4.PSE has no effect in long mode so it
> > can be omitted.
>
> f4c5ca985012 ("x86_64: Show CR4.PSE on auxiliaries like on BSP")
>
> Please don't forget about git history before doing changes here.
>

My bad - I misunderstood what is going on here.

> > CR4.PGE is used to flush the TLBs, by clearing it if it was set, and
>
> ... to flush TLB entries with the global bit set.
>
> And just like the above commit says, I think the CR4 settings across all
> CPUs on the machine should be the same. So we want to keep PSE.
>
> Removing the CONFIG_X86_5LEVEL ifdeffery is nice, OTOH.
>

Cheers.

