Return-Path: <linux-arch+bounces-1898-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7A5843B8E
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 10:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80EF71C22E50
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 09:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A986996A;
	Wed, 31 Jan 2024 09:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M84x0a7u"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92AF69958;
	Wed, 31 Jan 2024 09:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706695187; cv=none; b=ualGrJKQE4a1QwhPD71x8B8QSo/lVxHTMxOJG3S2TSMoU6Ug0QuPPr3ATtLeGqUk29lJXY4Vfqg/kJw2Q2SVrUpnzky5u1vYSMl9qgKyY9fG2Nm7u44hSnmsBmurDAQFRJXHtpSCOlKorxKQwTOIIl8+KFRBRejXALJXg5vW4gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706695187; c=relaxed/simple;
	bh=ndpOHGWhLs4zO4Wyfi6kMgHbolC9NcQlphKc2GTyubI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fXh/5Jp2hu7Rs6Z5JStrJSsCdzwgI+nT4fxj9PWypL25U1MOiQ+4l0bQacMvkUM9/KAYfbn9PoDR6kBBivC695TpaL/+OkXqDYd6cvqIijp9i1Bs2su6r3Pz59TIzmMZTncgsIikosuc9o81HbqdRkySznOKm0/IgLtC0h/cT1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M84x0a7u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324EAC433B2;
	Wed, 31 Jan 2024 09:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706695187;
	bh=ndpOHGWhLs4zO4Wyfi6kMgHbolC9NcQlphKc2GTyubI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M84x0a7uUEP4VPvSwPNa2lMonKxd3C2zSzazDaWS7Tz2K7YiZ2yCQJvmLfQ4kjTFL
	 fPPZB2vxZuG51kuLFyf3wHESUh6MIjeCwRUBrvhBFaBFtSUDgwAyXeTY2H/8heM09v
	 0HP601hjsRdcGlbb2TQqyPLHKdCL/uwCsRxkm3nMkyn5XsMC+KOvrxrBe7B5Lc0Mv9
	 AQssPuD+C8Q3EUND5bScW0xvRqE2bta6/dmyhVrwBOFi7sWn8i7DmZhFIKg0wDI6iR
	 0D37optKDWRzQX62jNCFbErFYwiCDNP5pMZUIMRAcz0D8FBCJntziFVPS4GrtFp1Xy
	 iiQEYWEhowLJw==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5102a877d50so5593864e87.0;
        Wed, 31 Jan 2024 01:59:47 -0800 (PST)
X-Gm-Message-State: AOJu0Yz/PrSX5USKZ7XMVv6D56oJjpVxmD1/jgSgmMpudefmSBpiT6bx
	OfsHYBTHvjj3J5XKMsE6dIegdgt/UIrzv0aXa08wB+LGtgPDESwnQ54uY/bltM4qVUSeAhX2NC7
	a5DVZwMIwvRbCBGpBYZTQ7tBcYXw=
X-Google-Smtp-Source: AGHT+IHu2o3YV/qlDh7sdAfKfvmX//NXwQHej5v6a5Pz31VpKNlsQ/SsOzMtvUvvKuJErm8cFEqyNj8Z3fFxAXM7bM0=
X-Received: by 2002:ac2:443a:0:b0:50f:18f7:855e with SMTP id
 w26-20020ac2443a000000b0050f18f7855emr790716lfl.39.1706695185332; Wed, 31 Jan
 2024 01:59:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129180502.4069817-21-ardb+git@google.com>
 <20240129180502.4069817-23-ardb+git@google.com> <20240131083511.GIZboGP8jPIrUZA8DF@fat_crate.local>
 <CAMj1kXG9W0XeEVR4tXDDg0Ai9XPsZGrTJaSRYUqgTV-xtFxjdQ@mail.gmail.com> <20240131092952.GCZboTECip8DbWtYtz@fat_crate.local>
In-Reply-To: <20240131092952.GCZboTECip8DbWtYtz@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 31 Jan 2024 10:59:34 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFrF4F0UdBoPLMkRS26CRKmDw6_+-zeRgNEmdOn11fsug@mail.gmail.com>
Message-ID: <CAMj1kXFrF4F0UdBoPLMkRS26CRKmDw6_+-zeRgNEmdOn11fsug@mail.gmail.com>
Subject: Re: [PATCH v3 02/19] x86/boot: Move mem_encrypt= parsing to the decompressor
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

On Wed, 31 Jan 2024 at 10:30, Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Jan 31, 2024 at 10:12:13AM +0100, Ard Biesheuvel wrote:
> > The reason we need two flags is because there is no default value to
> > use when the command line param is absent.
>
> I think absent means memory encryption disabled like with every other
> option which is not present...
>
> > There is CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT but that one is AMD
>
> ... yes, and I'm thinking that it is time we kill this. I don't think
> anything uses it. It was meant well at the time.
>
> Let's wait for Tom to wake up first, though, as he might have some
> objections...
>

OK, yeah, that would help.

AIUI this is for SME only anyway - SEV ignores this, and I suppose TDX
will do the same.

