Return-Path: <linux-arch+bounces-7500-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3824A98AB60
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 19:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7EA91F235A4
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 17:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D22198A0D;
	Mon, 30 Sep 2024 17:51:10 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC6F18C31;
	Mon, 30 Sep 2024 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727718670; cv=none; b=VPyM5Q/atKRjXyPn0ToCKyyM8QwSWQlRBlzZ1ZAw0tPjaM05GoJ4hK/3E4cp77NysvSOtD4ObwicXLw3GlhDg/kdXqGOnGHGIMsaas24mg3EmRvUez2pJw+lIadzLpjcEGwCSsrFvlaCulep3AYlehZPH8GD/lgRqFozA6BHC78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727718670; c=relaxed/simple;
	bh=x0pDw+4SzE1MkSrrBfzhcseWxrldz0hn0pxuu1IaAPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gq120dC7DIduTuIz4ogWfNCPDlG0MR59qv7DTupf5xMyLMfmYt4kHawrYyGKz9DIRbFf9/skmf7n1zMu59PPMMJIEgQwjZxX2K8ISuu4um6wi1YnYp0I186eWMkwONhSUTG+uy5PunFvkbwt8h2l821j9UGICjoeaD+GiaH9qBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ddfdeed0c9so36307877b3.2;
        Mon, 30 Sep 2024 10:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727718667; x=1728323467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERWUip0Hd+3xSPGc5KF+LIvmSrz8p98q0i+WVSFZa2o=;
        b=p7Aqwcvtq57p9vfgE4tPN3TuNn2ex3OXgaFUSgkpaDvHWaYBB96GctEZHfK85dNmb9
         QCRV958TudcF0K+oA1Wfn29hcAB/reO+kqOMacxeWjQ15oXPmgK2PN8rd98gZSdDiLMi
         eZn5Oo/nB0+e5uwcu3tQeLeq72apFjSDnmHR0Wv4lQg0OXUa4vtivopt5KoxlLB5LCFr
         wqjkO1m/RjQNNlKY/Orr+Ejb5feTTVyfUltJVY/QxwZ55iofO6cC3PaJo0DnvUkFuEAo
         KYzYB6vt72svkmHYnFI2DGZVE7kJpb7yyWDeNrbdz549xNR8SA+q2JV8sM8B3FaMdIeP
         OXcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2xMbojouJPYbmWf/LzHa5gzdgcvXCBm2sBcBAnnlY1vfq8UeIMKuiQK6dV7olxelR9Qd7o7qxgkB4EQ==@vger.kernel.org, AJvYcCUkNc10IU1/cNpJeKvNteYIyDUPV/KrUi/9IqfhvxVtKo6yg4xq2SQHhCt3njRWJ716OcapJ9BiJOU9IA==@vger.kernel.org, AJvYcCVVJTnSqRvM5XHiK1qD4FvOnwCKV7bW3uzNULNCEJ2ay8Q5uUCYfjf/oSMFQIaikHCghgYOCIJsB5ShCG4R@vger.kernel.org, AJvYcCXOUJNeYTxA+Ji4anNBppkRLASiq3iy1TDV7l7qoCQpoWCE7mzncO2vmygw4zTPSvbQH6qauwd5q9w=@vger.kernel.org, AJvYcCXVpV8wVG5sU1GkAPTccXm+8C5akyrh1h59uiSXva/qBbmkgpIRuqWNiP8FzfuqXEeRhT5HBuT1nncZMQ==@vger.kernel.org, AJvYcCXk1WrfU56Vh3LkX/eH3H/XlvAdv0ziPSzzucloflBpFweJ6lUSlPsp3uN46FpqVLt3kpQyxuQzMFHgooCo@vger.kernel.org
X-Gm-Message-State: AOJu0YzCJKv66ivHGticXtBIr0Zt840NUjVV1TEv1fOswuUdMb/9SMEC
	B8/+iCAOqHG3c2mY/wr3b2goQTq2oIK1F2MOELUW0ksBXyDlJ4eJwrhQ1cI2
X-Google-Smtp-Source: AGHT+IGhI3xA3cIv039jfiaPXUaypRnJS+EgpF8JI6aXodMaOUUnC76Ea3hLfuXu5U9hzxiNEsrILg==
X-Received: by 2002:a05:690c:89:b0:6e2:50a:f436 with SMTP id 00721157ae682-6e2475e2fa0mr89233007b3.36.1727718667090;
        Mon, 30 Sep 2024 10:51:07 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2452f7c57sm14992637b3.2.2024.09.30.10.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 10:51:07 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6d9f65f9e3eso39744247b3.3;
        Mon, 30 Sep 2024 10:51:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1EEN8COv+QD4dqKTC2Y8oArj9kyuGIGCl3Alvof4LWwbEd5gGSqoVQgs40X7BpjYCYg9UCTS6dUM=@vger.kernel.org, AJvYcCUEf9/HYpJPVH7jSyulvETno10N7/rxbYQbEa7599nsa80qsXK01LG+/aA7xAZigv9V1l4r4QkiwZBvUw6+@vger.kernel.org, AJvYcCVI1pEJEY1WY/uC9xNp4sEc3mJRRpPcnzvOTz6lIQP7peFNKI7uLRPKaLNbdYcH7gySMC3KhdyfXAWH5A==@vger.kernel.org, AJvYcCVKo71wgRZCGcTe/XZKzkO/KyTiCZiBpjsHoOggYN8HbPT0AZMdtbUNcGRAPYP+jkHkPwNAYHwQg1a1v3Gy@vger.kernel.org, AJvYcCWFr/jteD0p8zyR2J2uRavgRt7Mia0BoUg1Rt7nkk+G1zo4Go9fg2gfwl/IKLBTIt+Pslav93DZBQB6rw==@vger.kernel.org, AJvYcCXl/8kHvfw2XbUU7X83Kc/vNghIoZRSygY9CJ6PEYfK9BXwPs3TbewyfGB3LCarnsM3Bl0qQ50cK7Q6tQ==@vger.kernel.org
X-Received: by 2002:a05:690c:c0f:b0:6d3:d842:5733 with SMTP id
 00721157ae682-6e2475e3050mr104508727b3.35.1727718666765; Mon, 30 Sep 2024
 10:51:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930132321.2785718-1-jvetter@kalrayinc.com> <20240930132321.2785718-11-jvetter@kalrayinc.com>
In-Reply-To: <20240930132321.2785718-11-jvetter@kalrayinc.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 30 Sep 2024 19:50:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX03ornwefrTfSYfH-XoEE4CHN+u5m7ay5_LrTq8XHOJA@mail.gmail.com>
Message-ID: <CAMuHMdX03ornwefrTfSYfH-XoEE4CHN+u5m7ay5_LrTq8XHOJA@mail.gmail.com>
Subject: Re: [PATCH v7 10/10] arm: Align prototype of IO memset
To: Julian Vetter <jvetter@kalrayinc.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-alpha@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
	Yann Sionneau <ysionneau@kalrayinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 3:25=E2=80=AFPM Julian Vetter <jvetter@kalrayinc.co=
m> wrote:
> Align prototype of the memset_io function with the new one from
> iomap_copy.c
>
> Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
> Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
> ---
> Changes for v7:
> - New patch

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

