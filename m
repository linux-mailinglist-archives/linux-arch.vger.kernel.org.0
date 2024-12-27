Return-Path: <linux-arch+bounces-9518-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 803EE9FD5C2
	for <lists+linux-arch@lfdr.de>; Fri, 27 Dec 2024 16:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 240C2166071
	for <lists+linux-arch@lfdr.de>; Fri, 27 Dec 2024 15:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A291DD525;
	Fri, 27 Dec 2024 15:59:13 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A1F1FB3;
	Fri, 27 Dec 2024 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735315153; cv=none; b=CGE/FJfV5UheYJcaYPQ5nZSt4N8xD47cONCZbtkki5CPCYBv+W1DKEMLt9NzTw5fBGUeKpkP6i889p7VXAwuxJVYqRtDwpcVuGT9ETRpf3L0tumKPkGSnmUfmXJIYwtd+zKN+AqHIxfjtmUDCH8nKbO8KvgwjeUv9rTbQGeHh68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735315153; c=relaxed/simple;
	bh=8CRzzvrqRDrf+AFSJqOO/buxuiH6/+dCxnKWLm1TXvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XfVfR14qfLEk7HDGJ8YQppbs0w2jtpCZI0qI7cHY4W5axzazPFkvwvXmsiq/Dn8FcgmnPhTzM/pxDlPVxuxbWT7MMLmAcgbXO424Ax2AOWRYVfdPnx1V8G+gQJMy7MzBmNOBHnMxCburmbNBBCV3zLa4FnA4/QY9NaVVsQkPjEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-85ba92b3acfso3105947241.1;
        Fri, 27 Dec 2024 07:59:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735315150; x=1735919950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlObdDLNvDqmciLfK/sczAtcUt2zlZOZP8yBX48mfx8=;
        b=TpHfJMBFr82OR3DyyzhGT4Ibt/Ogefx+RXm0IRU2T5N8LE1aBdwynV9Ukvl1wmbBp8
         /V3rbV68bwiJogEoSYlA337l0fwA0qADzchhtN3aBVYRxxIzrjnjD0cZcByO46mc3vYN
         Ctafj3hLndQXgOUEN5vOpgfCH+A3JDOqYLkhcxOaocLA7li6EeaUWdR8GbgZzrGb1nqP
         ENiXfnd1PbdkgosN3nmAROjG4I/JuhKNj7/TJOKOGfszTGo9Y/IOmgLh3+DrSYxZCUeQ
         kVOlw6BJqoft6jWeE/tJ9WT6mvU47WVyJaGuBIKsyHXIg3+B8EdC4sBjP8FakyJW2J3U
         5NVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGn0Qn3z3M13vYX0IUI4Y1hHDBhwmKexjg2IqkjQwe4EjSYytjSbSnD8XjogHLJzV9DmmNegh09ggF@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb6sh4LgzQ0amgrgCFHJrHsxb54VxqBt+RthA62KV5C25fimPu
	tDa8xUlwKfB4akAHWw/V6MEmM9LloQN+JiDJmhvq/Dttimf1RgD6kyabPIB+
X-Gm-Gg: ASbGnctc5aQxtZ6TZBmdwzMVjBrqTJPIas8kLS8iviuVvBlYnhqHRewBe0NdlM793Gm
	InIFbPkFVevAeyhYEYlsb3NJPLi7BQWVNX2i1bzVkosGLjBBr8NxRp9LJyxlg8RjYIfa6Nu3DuT
	c2LGcEAHJV6YbyjRIpCyx8WTChgS8cR4x+AMrGCONtxWWR29a8U/FfKdwxeamd3+vV+s3lLkoak
	XIp+9X+MJDledWLAssh1QfPf6W1VlLfqHWMx2bQqHIsHJFF3HmsRuOUZG0WHHW0rIz26MjM2cB4
	irHmsWG6omfeZcqxsiA=
X-Google-Smtp-Source: AGHT+IF1bBPYOEpti9GtYhAw5r3Aif7laM/cuw0i9r2nZGK0aSDpw9js8o/aNSKt+RJLboWMlpZZqg==
X-Received: by 2002:a05:6102:c46:b0:4b2:5c1a:bb57 with SMTP id ada2fe7eead31-4b2cc447400mr24727166137.20.1735315150466;
        Fri, 27 Dec 2024 07:59:10 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8610ad5a149sm3072127241.35.2024.12.27.07.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Dec 2024 07:59:10 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4affbc4dc74so3850167137.0;
        Fri, 27 Dec 2024 07:59:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQt5G2CLw8yYozW4vJIMNlcoTjTkyiakGUyRXt/6BWP/Q3D28BARz2B3wNRQUhg7RfaV0Z4Ln/gY7J@vger.kernel.org
X-Received: by 2002:a05:6102:3a0b:b0:4b1:1eb5:8ee5 with SMTP id
 ada2fe7eead31-4b2cc47782amr21558940137.25.1735315150014; Fri, 27 Dec 2024
 07:59:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241222222259.GF1977892@ZenIV>
In-Reply-To: <20241222222259.GF1977892@ZenIV>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 27 Dec 2024 16:58:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVpTtcT9LVGNvFLm4cvrNF=fe1dVsi2zo73Yee3oYrJYQ@mail.gmail.com>
Message-ID: <CAMuHMdVpTtcT9LVGNvFLm4cvrNF=fe1dVsi2zo73Yee3oYrJYQ@mail.gmail.com>
Subject: Re: [PATCH] sh: exports for delay.h
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Al,

On Sun, Dec 22, 2024 at 11:23=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>         __delay() is either exported or exists as a static inline
> on all architectures - except sh.
>
>         Add the missing export of __delay(), move the exports of
> the rest of that bunch from sh_ksyms32.c to the place where all
> of them are defined (i.e. arch/sh/lib/delay.c).
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Thanks for your patch!

> --- a/arch/sh/lib/delay.c
> +++ b/arch/sh/lib/delay.c
> @@ -7,6 +7,7 @@
>
>  #include <linux/sched.h>
>  #include <linux/delay.h>
> +#include <linux/export.h>
>
>  void __delay(unsigned long loops)
>  {
> @@ -29,6 +30,7 @@ void __delay(unsigned long loops)
>                 : "0" (loops)
>                 : "t");
>  }
> +EXPORT_SYMBOL(__delay);

Please do not export __delay, as it is an internal implementation detail.
Drivers should not call __delay() directly, as it has non-standardized
semantics, or may not even exist.

Unfortunately this comes up once in a while, cfr. commit
7619f957dc8cb8b2 ("Revert "sh: add missing EXPORT_SYMBOL() for
__delay"").

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

