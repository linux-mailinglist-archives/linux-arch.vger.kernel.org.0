Return-Path: <linux-arch+bounces-3785-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 961598A949A
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 10:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A86928227B
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 08:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667567C0A9;
	Thu, 18 Apr 2024 08:06:41 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A8D7CF2B;
	Thu, 18 Apr 2024 08:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713427601; cv=none; b=kw94eGrOdOX6WhMw2KGwPQkN0JiC/l/Uhc831grrPg9Cez+agej5E1/f+XP7A1h++CW2PEAH/yp64mJTZVIFjPKEasAaZo35AKDqNQswVXCgPSwfZePBp8WitCfHFDG2jIg4eq254p2iHI1n1gzsiQ1amc9vr8AvqJ5T1jHi6AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713427601; c=relaxed/simple;
	bh=N9bte2/TPMI3zkGutCDDsLAR5wV/ONUoXjSgWvRH9D4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M1KHKFBzw2Js4IiKFzILm+eruDaGiEHEqV4olbK2zhYYEfuJPzHtdqX8Wa+UpMSNVfc6uyVbedIi4aiOsYpRtqxstsMLWrkj1HolwsabTIlSSWOz3oJb7gSGnV5tP9Cek9pZqjUs0ZmvaiGKcE/LcaIV8EMBHmvknZ4FwG9cWBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6098a20ab22so4737757b3.2;
        Thu, 18 Apr 2024 01:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713427594; x=1714032394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHrj1J1rGZYSYF3rlWbb7rvxRYWFkwnRU+JdZB4MCn4=;
        b=TVCOp6SscQm3tnogSuEdDDioJRTCDod+FUvrUJ4aYN2G0UmWGvjpuP/JqAsEYama0y
         75U7+n4xnTjqMpSSfdoxFsxSmr/pQsmxVAJTBx8TUCf8wFJJvacjYzUzQnNioSvc9o1e
         oZWxXsg/HeJU1hOT4W5wDzyq0FgwJH0BP23ZHCMdfpsIzA11byK2BHN2vuQkd5+L8AMq
         cNuOEzN/lYVLz2XMD3J4hRhehiWmdH7UqRT2DFlq8rp8AfTQzKzoNc4O7/DeeNdm16g+
         n0NNxfru7BY4IZwJfYQv53tmc5SRWH6Z9Dt3o/uHAiDW60MO9WCaauFoh8hVaIakQKVA
         4B+A==
X-Forwarded-Encrypted: i=1; AJvYcCUIonRNfmM0JIvfZuJLLVrNw9LkO65y+AfBxCL17zFh8DXQI1Kb/NpCEhf5tNcjH+/nUWxLtU0shNKsOJucf1WkR+s9uUm3LU7Us0fy
X-Gm-Message-State: AOJu0YwzsXZqmAj+2Ayu/6YmRWoPcKZ8765PMdtIr6PHp7F5j7EE1bTo
	P7HA7hFIxhWeN09JH4sP9o4DZfQkiaqGmgfHg98z4cNhCNeaivfIz+QBQ3PTn6Y=
X-Google-Smtp-Source: AGHT+IH+eF4ls/vSz2d1hy0aQDBEaKkt4kP+lTad8pocH0O7UOX6XGqiX35l576fCqODAlELeHjMKQ==
X-Received: by 2002:a05:690c:3385:b0:617:cfb8:4e50 with SMTP id fl5-20020a05690c338500b00617cfb84e50mr2104186ywb.17.1713427594127;
        Thu, 18 Apr 2024 01:06:34 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id m190-20020a0dfcc7000000b006187ad29fe8sm233513ywf.61.2024.04.18.01.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 01:06:33 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-618944792c3so5361627b3.1;
        Thu, 18 Apr 2024 01:06:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVq1eb/T9wPwk+TXLK6zEF+fvxK26llnnY/6syplOi5+BUivXLez21Nm0thiReHgR7Gb3XvKyQbCNHqFwro4PwJE+w1qlYxPEk+pQAs
X-Received: by 2002:a05:690c:a87:b0:618:1956:691b with SMTP id
 ci7-20020a05690c0a8700b006181956691bmr2200093ywb.14.1713427593345; Thu, 18
 Apr 2024 01:06:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7b3646e0-667c-48e2-8f09-e493c43c30cb@paulmck-laptop> <20240408174944.907695-13-paulmck@kernel.org>
In-Reply-To: <20240408174944.907695-13-paulmck@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Apr 2024 10:06:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXAB-9GPqNBJKF=JtWNfhBv168N6eko-9VcLmLSeQaS4Q@mail.gmail.com>
Message-ID: <CAMuHMdXAB-9GPqNBJKF=JtWNfhBv168N6eko-9VcLmLSeQaS4Q@mail.gmail.com>
Subject: Re: [PATCH cmpxchg 13/14] xtensa: Emulate one-byte cmpxchg
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, elver@google.com, 
	akpm@linux-foundation.org, tglx@linutronix.de, peterz@infradead.org, 
	dianders@chromium.org, pmladek@suse.com, torvalds@linux-foundation.org, 
	Arnd Bergmann <arnd@arndb.de>, Yujie Liu <yujie.liu@intel.com>, 
	Andi Shyti <andi.shyti@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Mon, Apr 8, 2024 at 7:49=E2=80=AFPM Paul E. McKenney <paulmck@kernel.org=
> wrote:
> Use the new cmpxchg_emu_u8() to emulate one-byte cmpxchg() on xtensa.
>
> [ paulmck: Apply kernel test robot feedback. ]
> [ paulmck: Drop two-byte support per Arnd Bergmann feedback. ]
>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Thanks for your patch!

> --- a/arch/xtensa/include/asm/cmpxchg.h
> +++ b/arch/xtensa/include/asm/cmpxchg.h
> @@ -74,6 +75,7 @@ static __inline__ unsigned long
>  __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int =
size)
>  {
>         switch (size) {
> +       case 1:  return cmpxchg_emu_u8((volatile u8 *)ptr, old, new);

The cast is not needed.

>         case 4:  return __cmpxchg_u32(ptr, old, new);
>         default: __cmpxchg_called_with_bad_pointer();
>                  return old;

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

