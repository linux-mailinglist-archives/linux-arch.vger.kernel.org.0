Return-Path: <linux-arch+bounces-1704-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C0B83D0A2
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 00:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED87E1F212FC
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 23:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE7912E7F;
	Thu, 25 Jan 2024 23:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9cBRiB3"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EFB11731;
	Thu, 25 Jan 2024 23:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706225088; cv=none; b=IiRP1rVHbdNGRtTNvcZX3ctVJg402wDiq9R1qzPOetVkVmMByw8ycfLkCuv12v5nTQ69R6xbVBjqzuiYv6CjImXXFIVscTFAW9GqDOd0oveLJKOUVdqlrevrIdK9B9mKHiDHJ3znHE1OKd3z8AV+8yRuLjBDZuIErpBknmLGmKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706225088; c=relaxed/simple;
	bh=nvWG+QBFahtKdRU5auqjQY0W/k/VTqwcLTuI7owHaJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ecFHTYapnUGAmTdLRv9UWH5e/EPOhUhR1LS1tq7rUhBu4Rsyue2oXoru4rLgL+1DoKF2sWt0LZKGo5rE96M5FMoEUM6pT/hm94y0V1iXlPLAFUZLz3CQYGfA4cwLwgw03uj50riYQDtkA3p8iIkSOxN+zBIg2AOuNX5WWO/tve4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9cBRiB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CF8C43399;
	Thu, 25 Jan 2024 23:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706225088;
	bh=nvWG+QBFahtKdRU5auqjQY0W/k/VTqwcLTuI7owHaJE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P9cBRiB3pg4MVANgKJWfoqL8wVJluMjvpChMlST17x8HO32e3RCdVnq4mefr9ofg5
	 jSr0AN31PSu9mQmC6ZRq/619iQMhSasdEq8SzsJajb9cyx9SSrg3/cOV1wx8gTbhm/
	 CgENoVeC0A+OGB2KGe9Sb81+UMuFQ0MoeUlvh3Up7NnqURYAmNRtIdcYgEaRqlHi8k
	 FIlzVhOPEsvljKsJ01Umy2rxidUgQz7gXn0cw/Uyc9PzA5drHGbJElr2uRvk1Gbr5X
	 a+mD5EcTzDvbYc0tU/zCEpfpbW9lWbvY68yhaiYTqNatCch34Ubma5oMDP0th+Krgg
	 6S4u1bn01kQ7g==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-510133ed214so3416208e87.1;
        Thu, 25 Jan 2024 15:24:48 -0800 (PST)
X-Gm-Message-State: AOJu0YyvnUFofRxta4V7Rq0d9RyqHc9IQqKrIEJfMKhVgNZSGH2CEalR
	eCsRF6QXWbHUp/f7ClIHHKDxlFqs6t7C4XtgdvUo9dro6s4KbMSmy1tLLN5wdmsCAFZlJKR4/JY
	IqcPoFB73ovuSzX1G+Awp5yJA4LI=
X-Google-Smtp-Source: AGHT+IHB0caDko9nY9w72/lzhdsdAzPG/BA9d4nmkX755oG9KiJmerbz5g9MrFbgaGaGkBg5kzf7ENnZGzaxh4X5JdA=
X-Received: by 2002:ac2:58c6:0:b0:510:1ea5:f747 with SMTP id
 u6-20020ac258c6000000b005101ea5f747mr274447lfo.9.1706225086479; Thu, 25 Jan
 2024 15:24:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125112818.2016733-19-ardb+git@google.com>
 <20240125112818.2016733-35-ardb+git@google.com> <CAGdbjmLEsj1cSnxoneSrDy2J2SFenjEdoYa_zoDQQhtU1nccMA@mail.gmail.com>
In-Reply-To: <CAGdbjmLEsj1cSnxoneSrDy2J2SFenjEdoYa_zoDQQhtU1nccMA@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 26 Jan 2024 00:24:35 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE5bC-QgGWqhAtuRT5fDbBUgjkRyjGSwsiQcSgA-KuaYg@mail.gmail.com>
Message-ID: <CAMj1kXE5bC-QgGWqhAtuRT5fDbBUgjkRyjGSwsiQcSgA-KuaYg@mail.gmail.com>
Subject: Re: [PATCH v2 16/17] x86/sev: Drop inline asm LEA instructions for
 RIP-relative references
To: Kevin Loughlin <kevinloughlin@google.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 25 Jan 2024 at 21:46, Kevin Loughlin <kevinloughlin@google.com> wro=
te:
>
> On Thu, Jan 25, 2024 at 3:33=E2=80=AFAM Ard Biesheuvel <ardb+git@google.c=
om> wrote:
> >
> > The SEV code that may run early is now built with -fPIC and so there is
> > no longer a need for explicit RIP-relative references in inline asm,
> > given that is what the compiler will emit as well.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/mm/mem_encrypt_identity.c | 37 +++-----------------
> >  1 file changed, 5 insertions(+), 32 deletions(-)
>
> snp_cpuid_get_table() in arch/x86/kernel/sev-shared.c (a helper
> function to provide the same inline assembly pattern for RIP-relative
> references) would also no longer be needed, as all calls to it would
> now be made in position-independent code. We can therefore eliminate
> the function as part of this commit.

Yes that would be another nice cleanup.

