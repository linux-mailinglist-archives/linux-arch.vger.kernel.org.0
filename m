Return-Path: <linux-arch+bounces-3722-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A318A6960
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 13:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1735C1C20D96
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 11:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F535128393;
	Tue, 16 Apr 2024 11:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="BshHmH48"
X-Original-To: linux-arch@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFAB127E3D;
	Tue, 16 Apr 2024 11:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713265607; cv=none; b=Sj/v5DhAjR3uH/xXxRphluEduFG8JwrI8kNcwUJSU+alErJmDZIOjgTr1ijbabeC7wc7s1MBAjd71H6umsnqlod+pesmV0gjhMTbUac1fmgevNapC20LBwRPD1f1D6GwmGavMvQWuGZlTy2kA6UM7i6mdIAYFMSxnnWi/00oLqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713265607; c=relaxed/simple;
	bh=6YyzjOcrpjM2awxpuoWmwqK1BSbLE0TEGbSa1cisklg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CYmkGAAtpV7+7kMHW7hBRYVwzlEuaQ2Czwk3yR7fRENlGn3ylPLua2+zdKFP8VJUR8+bcCbdX/tQEtG3cQHxsnj7V28GsYYE3j54X4AJkYz1cLdm0X+uJdi74VLzpeYSpthHELj9e1cWTEngeP7eOVDfGBoyrAZ6zrSE5qD8NNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=BshHmH48; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1713265594;
	bh=m0OXBfeSJNV67OWiwlg58xXaL5nRVTZ9FFXZTv4YfRA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BshHmH48hI2RHWM/xhDdoBq6VpEtUFcBGkMSWHrzLiOiE0TheY5hTBRpG1wc20YxQ
	 BNWaqxEG4uZt80If+ksNGJS3kWD4eIS/i7uhp5CnKdC6VueM7JF0JSaTYKwQwih2/z
	 Og+6U+bnQE9axLAC5y41TOmdCAi/9aH/2kGYIIa1Cqau8hD8mXXo53SbLknPqyv1Te
	 xFY2lD888iOGSAomxoaCTXleIdnXZPzN2H87wCv/bR1q4kda/McrUf/xadTOE6qM0y
	 MexQLEXPwXDr/cndRUWqG6qGdtu8OZscIqJbK4uu/keTeOEbMRm1eDLApmARTY/toS
	 9STWuWmVTv/xg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VJh7C3WSSz4x1H;
	Tue, 16 Apr 2024 21:06:31 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sean Christopherson <seanjc@google.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Jonathan Corbet
 <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Pawan Gupta
 <pawan.kumar.gupta@linux.intel.com>, Daniel Sneddon
 <daniel.sneddon@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 1/3] x86/cpu: Actually turn off mitigations by default
 for SPECULATION_MITIGATIONS=n
In-Reply-To: <Zh06O35yKIF2vNdE@google.com>
References: <20240409175108.1512861-1-seanjc@google.com>
 <20240409175108.1512861-2-seanjc@google.com>
 <20240413115324.53303a68@canb.auug.org.au> <87edb9d33r.fsf@mail.lhotse>
 <87bk6dd2l4.fsf@mail.lhotse>
 <CAMuHMdWD+UKZAkiUQUJOeRkOoyT4cH1o8=Gu465=K-Ub7O4y9A@mail.gmail.com>
 <Zh06O35yKIF2vNdE@google.com>
Date: Tue, 16 Apr 2024 21:06:31 +1000
Message-ID: <87sezlbm88.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sean Christopherson <seanjc@google.com> writes:
> On Mon, Apr 15, 2024, Geert Uytterhoeven wrote:
>> On Sat, Apr 13, 2024 at 11:38=E2=80=AFAM Michael Ellerman <mpe@ellerman.=
id.au> wrote:
>> > Michael Ellerman <mpe@ellerman.id.au> writes:
>> > > Stephen Rothwell <sfr@canb.auug.org.au> writes:
>> > ...
>> > >> On Tue,  9 Apr 2024 10:51:05 -0700 Sean Christopherson <seanjc@goog=
le.com> wrote:
>> > ...
>> > >>> diff --git a/kernel/cpu.c b/kernel/cpu.c
>> > >>> index 8f6affd051f7..07ad53b7f119 100644
>> > >>> --- a/kernel/cpu.c
>> > >>> +++ b/kernel/cpu.c
>> > >>> @@ -3207,7 +3207,8 @@ enum cpu_mitigations {
>> > >>>  };
>> > >>>
>> > >>>  static enum cpu_mitigations cpu_mitigations __ro_after_init =3D
>> > >>> -   CPU_MITIGATIONS_AUTO;
>> > >>> +   IS_ENABLED(CONFIG_SPECULATION_MITIGATIONS) ? CPU_MITIGATIONS_A=
UTO :
>> > >>> +                                                CPU_MITIGATIONS_O=
FF;
>> > >>>
>> > >>>  static int __init mitigations_parse_cmdline(char *arg)
>> > >>>  {
>> >
>> > I think a minimal workaround/fix would be:
>> >
>> > diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
>> > index 2b8fd6bb7da0..290be2f9e909 100644
>> > --- a/drivers/base/Kconfig
>> > +++ b/drivers/base/Kconfig
>> > @@ -191,6 +191,10 @@ config GENERIC_CPU_AUTOPROBE
>> >  config GENERIC_CPU_VULNERABILITIES
>> >         bool
>> >
>> > +config SPECULATION_MITIGATIONS
>> > +       def_bool y
>> > +       depends on !X86
>> > +
>> >  config SOC_BUS
>> >         bool
>> >         select GLOB
>>=20
>> Thanks, that works for me (on arm64), so
>> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Oof.  I completely missed that "cpu_mitigations" wasn't x86-only.  I can'=
t think
> of better solution than an on-by-default generic Kconfig, though can't th=
at it
> more simply be:
>
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 2b8fd6bb7da0..5930cb56ee29 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -191,6 +191,9 @@ config GENERIC_CPU_AUTOPROBE
>  config GENERIC_CPU_VULNERABILITIES
>         bool
>=20=20
> +config SPECULATION_MITIGATIONS
> +       def_bool !X86
> +

Yeah that works too.

cheers

