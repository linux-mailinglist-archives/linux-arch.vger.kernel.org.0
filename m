Return-Path: <linux-arch+bounces-3675-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFD68A4D76
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 13:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441001F22841
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 11:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E588B60ED0;
	Mon, 15 Apr 2024 11:17:08 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0BD5D497;
	Mon, 15 Apr 2024 11:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713179828; cv=none; b=VEwgKeD/ympvA58rr+EEXk41x0ndSPGIC5sN2303wF1Od6uRE9BOwCYdn5N1PPcLyDY+1aC0T+oFBpH+9MESdfH5Yq5hacqihC1gjZjZ6dd5Q4MxCXXamfz/Zjd3Wmh6VWm0P0lSk86fWd1ByTzicTJJ2boGj3xIit8KcLnHet4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713179828; c=relaxed/simple;
	bh=OPrxxm549sdcK2roWgENrl0hX8PfxL3zKFt5RKh160M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9F6GAW4mQAOBSou+7VEJFNZ+C0zDuSg0GO8bXJ5VB/+jLJJhqCFukfugYgeQTd+S7XhE/YOcq38GbrLruQSHFfZDfk8UMWQvQ/rapJJgbJ+43IasT7yi4OrczDgy2dgJ8zUxPDyhsD9vaQnqFjaqQjWh4LHNO+ld2FnGRREa1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-61ad5f2c231so6564727b3.2;
        Mon, 15 Apr 2024 04:17:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713179824; x=1713784624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDiun8fBl0neiQNLp2j8KsuRQma3u2I4LgI70HkeRT4=;
        b=lxQcYuhPFq40+wpIrczNkGDcP839B3YLcaDlY4ffcC0UMm6S9yiy0WYv8B2Qb+hAo0
         pLuEyOfrxCKbhRvXMw1dFCqt1vRgORAXZYRhz+v3uYP5qcMEi/eZo3bdbMpgvTJH+Bgg
         gL7IO3VWYcQmRPPkVOf3TDJMR5ZfD3D8+DCC6ATUKwMSwNjZZVPVpkTO0+4oZ3H6O3Kh
         BzU1MXa+wmlWU2YqdG2ZzqKMN9bKLGxUGJNb+lOKB0LuosEVHU0rZEZVtpl3U2eD0GFE
         q8EW1IXHacy3IoKWk82bcrmOH4CNkusH3C7ZyxwcLkdW6jUvGQXMuLA8YyUeMK6rtUWA
         yuVw==
X-Forwarded-Encrypted: i=1; AJvYcCWMwc7xOpyG8AJrRDufcfUnYxXrzlWJSp+LLhM5njyUSjwAclcnfsN3gwbdoJvyjFXNCPmi9E0/Xof8YarKtbo42N4Zu1hVDKOzQLUm4psEhHw1ePmEL/FAyk7toHcgliWyJJdBVo0PcGM15wawUmMzxSzsqnCQU7ft/yIX1EGDWQLQXENmW0tSg9OGk3sTswal+niiYdM168BFiNxWoBr6ciHcy6rO
X-Gm-Message-State: AOJu0YyXhG/giGLKTw49nc5DJOfUFiA/wIYbm+OIr6baGcaRLFQysttF
	U+j4u7s8TRMT580uMd5uuUYgEIgDK/pxJp7V5IX7UWsEFNVG+73gnTDrQC+r
X-Google-Smtp-Source: AGHT+IEy/EG30AHiiLyOIcVCuwjLV8jFb0Ff+EFNBNBwFjfWepPEWlyJ6uIw9f9UHCpoayc9YFIu0w==
X-Received: by 2002:a05:690c:6011:b0:61a:cde6:6542 with SMTP id hf17-20020a05690c601100b0061acde66542mr2525701ywb.16.1713179824600;
        Mon, 15 Apr 2024 04:17:04 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id i76-20020a816d4f000000b006145f80d24dsm2019004ywc.29.2024.04.15.04.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 04:17:03 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dd02fb9a31cso2464294276.3;
        Mon, 15 Apr 2024 04:17:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUC6XR22uK9PgXQPyLIF/k31Y60AHayN5zLs/sH+fdEUjbIDbGo2eV0njmfJVLkL3qO0uhacvhizIY0m7Z7Pb2e7FRoi2utqk3wabdU3xdLVdoOOM7bzniluyRUNysKH29+3TZAEo4qUMqOwz2TXB9RXphzRdZaOGaCWukQbGcbkgfSP2OIsMKTTJRJziAC1tCKjCky1h7F7qLOxO+ffgk/pZK+VsTO
X-Received: by 2002:a25:4b82:0:b0:de0:f753:ad25 with SMTP id
 y124-20020a254b82000000b00de0f753ad25mr8758272yba.1.1713179822967; Mon, 15
 Apr 2024 04:17:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409175108.1512861-1-seanjc@google.com> <20240409175108.1512861-2-seanjc@google.com>
 <20240413115324.53303a68@canb.auug.org.au> <87edb9d33r.fsf@mail.lhotse> <87bk6dd2l4.fsf@mail.lhotse>
In-Reply-To: <87bk6dd2l4.fsf@mail.lhotse>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Apr 2024 13:16:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWD+UKZAkiUQUJOeRkOoyT4cH1o8=Gu465=K-Ub7O4y9A@mail.gmail.com>
Message-ID: <CAMuHMdWD+UKZAkiUQUJOeRkOoyT4cH1o8=Gu465=K-Ub7O4y9A@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86/cpu: Actually turn off mitigations by default for SPECULATION_MITIGATIONS=n
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Sean Christopherson <seanjc@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Sat, Apr 13, 2024 at 11:38=E2=80=AFAM Michael Ellerman <mpe@ellerman.id.=
au> wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
> > Stephen Rothwell <sfr@canb.auug.org.au> writes:
> ...
> >> On Tue,  9 Apr 2024 10:51:05 -0700 Sean Christopherson <seanjc@google.=
com> wrote:
> ...
> >>> diff --git a/kernel/cpu.c b/kernel/cpu.c
> >>> index 8f6affd051f7..07ad53b7f119 100644
> >>> --- a/kernel/cpu.c
> >>> +++ b/kernel/cpu.c
> >>> @@ -3207,7 +3207,8 @@ enum cpu_mitigations {
> >>>  };
> >>>
> >>>  static enum cpu_mitigations cpu_mitigations __ro_after_init =3D
> >>> -   CPU_MITIGATIONS_AUTO;
> >>> +   IS_ENABLED(CONFIG_SPECULATION_MITIGATIONS) ? CPU_MITIGATIONS_AUTO=
 :
> >>> +                                                CPU_MITIGATIONS_OFF;
> >>>
> >>>  static int __init mitigations_parse_cmdline(char *arg)
> >>>  {
>
> I think a minimal workaround/fix would be:
>
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 2b8fd6bb7da0..290be2f9e909 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -191,6 +191,10 @@ config GENERIC_CPU_AUTOPROBE
>  config GENERIC_CPU_VULNERABILITIES
>         bool
>
> +config SPECULATION_MITIGATIONS
> +       def_bool y
> +       depends on !X86
> +
>  config SOC_BUS
>         bool
>         select GLOB

Thanks, that works for me (on arm64), so
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

