Return-Path: <linux-arch+bounces-3784-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A39488A9497
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 10:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43F3D1F22AF8
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 08:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2257C6E3;
	Thu, 18 Apr 2024 08:05:15 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BF976050;
	Thu, 18 Apr 2024 08:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713427515; cv=none; b=m76jVjqXeT0GoO/rpxlZ17VcrQVO90wVO7FGwAWTaxNG4+sgUB53zdyEwElo3px4jGES3LC3qnivsTojt2z9CXiKV/YkhVZmigR8Gi0yft8p4ZPu2I3KuDndEF3V9IX1EsqgVJmgwU2QnL9o+F+FdYZaISV+mNyq+EdaPcFLg5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713427515; c=relaxed/simple;
	bh=UOFVBPczXHCcz1zMmMSNpm25XldDzmqdDVCBSLjFSp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lyGXgP8IXLWy1US4o1BlmZzgtGNhdwUDM0BVa4G9qqge0WJVXI8A6aJjbawLync/OTzo32LROF+VDJr6/NcR8fV8cTxNhN3iZGJUSc06Gq67CQjXps5q7MOexQL9dXG0pKC5eFOXXKVA2cZVi/j6F3EqLCW5hbnSbuoKbn1PE34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6181237230dso5496157b3.2;
        Thu, 18 Apr 2024 01:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713427507; x=1714032307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLR4mBggObO8r2nSCZJdXRmeilUQBfk6WVycNxbYaLg=;
        b=gayppHqw+V3f6+Q/JsOoC0TuQitRMgPUsLya7iRAOU0IWgKlu8RpiIzwhwoWNq3GKI
         hXZPzP9kWur6W7+z9gzmUa0X2EosVqcXaaYlPvevZBlQJE4qn+8sPRfodcJegJ8h8R0I
         oJkpcInCwNEQbSzy3pDYSghW+rg5LuYatmIj7/Zrx2yjZ49DGwSXLu8GWBLVGi/wIIBE
         OpRypDCpzv3z867KeYwjAqWCFehlHXZW2idvtJqLbg+lWmsqkV3F6/wM8HTYH71mBiD4
         NaESoaeMqD4kIgwBjspJ1oECvY3Y7hCHe2mZ0X84POvPK9qZ/V2t8jQkdKnSaVfD4ywd
         sxrg==
X-Forwarded-Encrypted: i=1; AJvYcCUiAvDvP6mvxmHMA7u3IN8/CoyYIUb8liksS8bgUmfOXf5lMZv3dg6tSZLAeDUcOtv33b0Dts4KwOasSfPMfgMehf9MwtHgP2K2ED/XUPrEn9cUTjZWktEXDJeqSgWs6NYunw9OG6U=
X-Gm-Message-State: AOJu0YxhazPAZVNW2YgueGxBbr440FxibiXgrebDfA1X9jkgHxAVEGlB
	K+AiU4rfJWZ86QrYK2QOizU6tGNrJOjG7Ijn/sCgc48ZmpaO4Jr3QwpThyPtmvo=
X-Google-Smtp-Source: AGHT+IEBesv3zCiqVap2Rlfgf7RH249ZOi2RworH0dUT7AJaQnUi7dvADJmE2TdxgnVInSJviZ1aWQ==
X-Received: by 2002:a05:690c:74c6:b0:61a:db67:b84f with SMTP id jw6-20020a05690c74c600b0061adb67b84fmr2529880ywb.27.1713427507587;
        Thu, 18 Apr 2024 01:05:07 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id l189-20020a0de2c6000000b006180137ccf6sm117566ywe.4.2024.04.18.01.05.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 01:05:06 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcbef31a9dbso435638276.1;
        Thu, 18 Apr 2024 01:05:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQBItiBexU8b92YNvivwIPM1acmpk1EfqqRpaS3sGWewpbg7iDvGZ4/TXmgxToD6u7rLqs1GE6Hom3TB8lgcbnosUa/XvxUxfF+pyzP2EwZLbU4B2pOasRsxOyYkWebPfHSBCPp6k=
X-Received: by 2002:a05:6902:342:b0:dc6:b779:7887 with SMTP id
 e2-20020a056902034200b00dc6b7797887mr2234306ybs.20.1713427506764; Thu, 18 Apr
 2024 01:05:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7b3646e0-667c-48e2-8f09-e493c43c30cb@paulmck-laptop> <20240408174944.907695-12-paulmck@kernel.org>
In-Reply-To: <20240408174944.907695-12-paulmck@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Apr 2024 10:04:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW6zi+ZO_xC7jvi_cy5u2mydui1sCDE2pdpCoFmfBLWug@mail.gmail.com>
Message-ID: <CAMuHMdW6zi+ZO_xC7jvi_cy5u2mydui1sCDE2pdpCoFmfBLWug@mail.gmail.com>
Subject: Re: [PATCH cmpxchg 12/14] sh: Emulate one-byte cmpxchg
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, elver@google.com, 
	akpm@linux-foundation.org, tglx@linutronix.de, peterz@infradead.org, 
	dianders@chromium.org, pmladek@suse.com, torvalds@linux-foundation.org, 
	Arnd Bergmann <arnd@arndb.de>, Andi Shyti <andi.shyti@linux.intel.com>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Masami Hiramatsu <mhiramat@kernel.org>, linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Mon, Apr 8, 2024 at 7:50=E2=80=AFPM Paul E. McKenney <paulmck@kernel.org=
> wrote:
> Use the new cmpxchg_emu_u8() to emulate one-byte cmpxchg() on sh.
>
> [ paulmck: Drop two-byte support per Arnd Bergmann feedback. ]
>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Thanks for your patch!

> --- a/arch/sh/include/asm/cmpxchg.h
> +++ b/arch/sh/include/asm/cmpxchg.h
> @@ -56,6 +56,8 @@ static inline unsigned long __cmpxchg(volatile void * p=
tr, unsigned long old,
>                 unsigned long new, int size)
>  {
>         switch (size) {
> +       case 1:
> +               return cmpxchg_emu_u8((volatile u8 *)ptr, old, new);

The cast is not needed.

>         case 4:
>                 return __cmpxchg_u32(ptr, old, new);
>         }

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

