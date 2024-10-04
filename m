Return-Path: <linux-arch+bounces-7685-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C1198FF6E
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 11:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53C7EB21EF6
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 09:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2DF140E30;
	Fri,  4 Oct 2024 09:14:47 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3022139D0B;
	Fri,  4 Oct 2024 09:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728033287; cv=none; b=jH/nFEMe6cD+P5a/u99Rc+LoX8sK1DpaqNvOnHS1KlpVor4gRsdzFSmDFt2cQenFI/8dS0bwnUwnuqZhMzqAgpd6zGmuXMA25gkHXK3yJwEqW5pO5Pr8wEh5lKhkzhvZPMoRxOXATLmTPD+WAViXMpNL95M3OCcRip1yl2akIdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728033287; c=relaxed/simple;
	bh=Pf4GmLXQoQ2W68DP1c87CA7klKU82fS2YGTZSKNS2Fc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eM0ctCGr55z/3fKW0NT3G+pJ9z/PMCwtoC8d621E0Wk1bjpXaggYpfHh+EI0mP7xxHKRXRkMzVZRONFzBezAOuftb7yaIpsW/CR6OtoGzXrQ0GL4DOOSkz24R+FYhWJVYW9Yh8aIXw40cidTIp+3DkM9ZequbC9eqz0MQ9XkfTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-84e857bc0feso1084061241.0;
        Fri, 04 Oct 2024 02:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728033282; x=1728638082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6chgMlM/7sl+CMw3ASA+dhKJBOdZlXw4dSmmetI2ODY=;
        b=FUbwyJUw/XsMWLUj26DN+wMiNtO+KzyIZ3jGeFHhBMAJCCLek8vZkiWCUTE+iOY6lm
         6fHamYT8XTi7aKKnKpn3ltGIW0mGfwwg+swdegncu35cTEY1/O9K6g1MsyunHOvKZ0T3
         ZTt7ITZXjgw484SZSP967Fn2FIYgWbWxlarET0cIFOQ4Z4vZuCFCxpmFbRaeLE8ofIy/
         O1S8CqxbngT5RTY7K3U9KJuLoxCLDYW6K+zHZzcxXJ1/kC8HDQBRPuwtomXI+EwsKobe
         aYibhVBWg2NucHUIDgPbJM0ZOrZaZ320MNcI1TsSIP6zd1igJBhWQVWHB0IeGqZ4fX4o
         lDxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJh8J74JQp0UhNGaytk+PlKWqoKdFMSYoXyQ/zdN/4NG4GShbEpFfEKN8qgSubOd9irbE7Kqw3ingu@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8yqFpaYyl+qXcDGO+vDxSc2+G5GJJ+50jd+rRU1HtLvZPu/bM
	s+uVjCwp/kxbkeA4rm7lR62wS4sUmU72Z9t3Dm3vtfMgTaGg/AcRbWYB22m4
X-Google-Smtp-Source: AGHT+IGU6C/bFWdWXY/GvOLTqQ/oJV/lZPlQWHFSigxQNrzMk6AVLsDs+84z6FBZ/OZ/iV+wRPva+Q==
X-Received: by 2002:a05:6102:c8d:b0:492:76e9:961a with SMTP id ada2fe7eead31-4a405cc19d1mr1031726137.1.1728033282336;
        Fri, 04 Oct 2024 02:14:42 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4a3f9be47c6sm452141137.17.2024.10.04.02.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 02:14:42 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-84e857bc0feso1084049241.0;
        Fri, 04 Oct 2024 02:14:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXuEm14tQNXCfGlvDTvlfO81AcgApat3WBtsnOr3o3gYSYpQXsoz5Oc3rUcacYgkxEI1hpY/79IrWoU@vger.kernel.org
X-Received: by 2002:a05:690c:6185:b0:6e2:2684:7f62 with SMTP id
 00721157ae682-6e2b534de12mr42115587b3.8.1728032856220; Fri, 04 Oct 2024
 02:07:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003152910.3287259-1-vincenzo.frascino@arm.com> <20241003152910.3287259-3-vincenzo.frascino@arm.com>
In-Reply-To: <20241003152910.3287259-3-vincenzo.frascino@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 4 Oct 2024 11:07:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXBF_aCmROPX3gfU5APt-v2QOvsqdEa-8ZpwuuxnFLaXQ@mail.gmail.com>
Message-ID: <CAMuHMdXBF_aCmROPX3gfU5APt-v2QOvsqdEa-8ZpwuuxnFLaXQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vdso: Introduce vdso/page.h
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 5:30=E2=80=AFPM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
> The VDSO implementation includes headers from outside of the
> vdso/ namespace.
>
> Introduce vdso/page.h to make sure that the generic library
> uses only the allowed namespace.
>
> Note: on a 32-bit architecture UL is an unsigned 32 bit long. Hence when
> it supports 64-bit phys_addr_t we might end up in situation in which the
> top 32 bit are cleared. To prevent this issue this patch provides
> separate macros for PAGE_MASK.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Thanks for your patch!

>  arch/m68k/include/asm/page.h       |  6 ++----

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

> --- /dev/null
> +++ b/include/vdso/page.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __VDSO_PAGE_H
> +#define __VDSO_PAGE_H
> +
> +#include <uapi/linux/const.h>
> +
> +/*
> + * PAGE_SHIFT determines the page size.
> + *
> + * Note: This definition is required because PAGE_SHIFT is used
> + * in several places throuout the codebase.

throughout

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

