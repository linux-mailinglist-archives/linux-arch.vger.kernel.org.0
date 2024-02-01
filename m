Return-Path: <linux-arch+bounces-1973-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 453A5845D09
	for <lists+linux-arch@lfdr.de>; Thu,  1 Feb 2024 17:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00CE2298BCA
	for <lists+linux-arch@lfdr.de>; Thu,  1 Feb 2024 16:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC613160895;
	Thu,  1 Feb 2024 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWcvEHCk"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47A715D5BA;
	Thu,  1 Feb 2024 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804164; cv=none; b=UknDnTv2Ue+LpTVoj3sh/XWtbSrrg/Z66oEFXjlW7JIeuvaE/SFYpATQ4SVe8VOwcXEv8fpd/EhBm6BPP2QnEVorGrAfnLn9YGYPGHw8ucRabvK9gKwleE0lFUBtDpgOlLJIwHINkROBLmXWfcoJ5R6mfTV7vXbAGaCtSgYd+C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804164; c=relaxed/simple;
	bh=KIv/fPGPmFB9fnYjlnfz0tTFBP50SqUKsGSXl+uC83I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EvHs4niaR6YFevlJp2JOD7jfdMe27ojWhiXyFn7euPItd+75WLg1Em0cRDdFAi72JA7eAXHm/BeYqYDmTVSFEwwpOp2oW8TgiAPQDsTuz+AK2LVEHtd5pL+bYY9Vc4poKUE+FVx+GRdvAFNN2GBqSQSLVKhilIQFbX0sTm12SSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWcvEHCk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA5AC433A6;
	Thu,  1 Feb 2024 16:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706804164;
	bh=KIv/fPGPmFB9fnYjlnfz0tTFBP50SqUKsGSXl+uC83I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jWcvEHCk6NPvkAwDiApDyJCJ3CmqrBtyA67xJeSSTahG+ig0UMgVlwx4ipHbTjRwL
	 ly1hjVcT/dRWjq9SUx9m4DiDvftphyqDOjJjsSqDLFfukL2e6rCFI7i47L10TgWGgd
	 gfj0RMa+9S+J4LSimyGzUitIGJ6EgvIG+OiwU074mwA4c8n17n4P/EeH0iIvRWMTQK
	 m7WSNgRrR3U71ffPondudt0Xd+zGc12JRaGaL1/SFWxCM+73xMhA4817td3oACzFOF
	 FM5QYv4V8PiX/0qiWAvbM/gYMN7ITcAUlb6FmZ3gtTQhCBt9hNqBuXmZkBuy+FDAMc
	 kKCEiCZIfDcGA==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cf33b909e8so21765801fa.0;
        Thu, 01 Feb 2024 08:16:04 -0800 (PST)
X-Gm-Message-State: AOJu0Yx63SmZkkedS/Onut7NzSjoxTLY3p3Q7yl53DBcTS3D/Kj02D1b
	tCQQdej2RA3BAv0kB2/FgNWLa5XWYp0E/3bUPgHXe1zRfAQTM+R/yb0y1v0RALcSWUYsEAoehMK
	F6HE5JYCdhVBbtQ/og8sY4vxOU+o=
X-Google-Smtp-Source: AGHT+IGCz2AvcYNo8VPFy1Gw6nGWuB+5qmsVqWWYqW5UFbannAB2SzVvLb5a0QRqGMvdcoV5bRlxSDtXGv23RdSYYfE=
X-Received: by 2002:a2e:b546:0:b0:2cd:9e2f:c631 with SMTP id
 a6-20020a2eb546000000b002cd9e2fc631mr1571302ljn.10.1706804162761; Thu, 01 Feb
 2024 08:16:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129180502.4069817-21-ardb+git@google.com>
 <20240129180502.4069817-23-ardb+git@google.com> <20240131083511.GIZboGP8jPIrUZA8DF@fat_crate.local>
 <CAMj1kXG9W0XeEVR4tXDDg0Ai9XPsZGrTJaSRYUqgTV-xtFxjdQ@mail.gmail.com>
 <20240131092952.GCZboTECip8DbWtYtz@fat_crate.local> <8b38ef82-ec2b-4845-9732-15713a0e2a85@amd.com>
In-Reply-To: <8b38ef82-ec2b-4845-9732-15713a0e2a85@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 1 Feb 2024 17:15:51 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH4U7X3_xgwhYUgbWqVfnzL5Dx0QaUhb_5TpZGQEh=_8g@mail.gmail.com>
Message-ID: <CAMj1kXH4U7X3_xgwhYUgbWqVfnzL5Dx0QaUhb_5TpZGQEh=_8g@mail.gmail.com>
Subject: Re: [PATCH v3 02/19] x86/boot: Move mem_encrypt= parsing to the decompressor
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Kevin Loughlin <kevinloughlin@google.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 15:17, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 1/31/24 03:29, Borislav Petkov wrote:
> > On Wed, Jan 31, 2024 at 10:12:13AM +0100, Ard Biesheuvel wrote:
> >> The reason we need two flags is because there is no default value to
> >> use when the command line param is absent.
> >
> > I think absent means memory encryption disabled like with every other
> > option which is not present...
> >
> >> There is CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT but that one is AMD
> >
> > ... yes, and I'm thinking that it is time we kill this. I don't think
> > anything uses it. It was meant well at the time.
> >
> > Let's wait for Tom to wake up first, though, as he might have some
> > objections...
>
> I don't know if anyone is using the AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
> config option, but I don't have an issue removing it.
>

OK, I'll remove it in the next rev.

