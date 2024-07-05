Return-Path: <linux-arch+bounces-5277-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A36928373
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jul 2024 10:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E813280CD6
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jul 2024 08:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF83314533A;
	Fri,  5 Jul 2024 08:13:10 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7A1143C64;
	Fri,  5 Jul 2024 08:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720167190; cv=none; b=pU5gJaomtE37KY7x4YTOPNXCZXtClwmTHR6vm3Mg4euyc/5bqBP68X8bzUfQYY+djMiUhGMNiTf3vJSgtJX7FnoTdoJ52glGtN3+nL/Y/QOS8LwyMNWiLZ2Z482SCZR4KGT0gOyrPjyQ3CKwiEz8g8pXsHXiRv6shL38B5n4dUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720167190; c=relaxed/simple;
	bh=r8RsOl90vUmFb3iH2mDrRyejM11RkeHxvGCGNnKIo5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WXgBuO9bGtfSUONsGIiVqr7y5ENzUOgXIjr/kymPH3hsoFXs5HYqwA9b8TyyhJp4bDW5Oqe3nblPyuoYG9ie818nspc7G2cZlxIo9g56XMnZVlsL1s5rCiffXsMQMGzztfS/CCgy2oObEuMmkTG4LI808IlrXxNZB/aHzE3zhDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-650866942aeso13016347b3.0;
        Fri, 05 Jul 2024 01:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720167188; x=1720771988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipFWrtbP2pnadKQDEjq7tVSKBPDnD8noGTMoh58siUs=;
        b=uVnfIwjbgmgIwz2TgLsoRKEP+mDpvBHI5l/DL1UhOvzAikOPkANoJrHMm9Sophe56a
         pMuzJ+ksGJGSbG9EQctyoLUVEbiHDCXHpLuoXWnaZBTpmNFbxJzKdTIHwgi0bLInF4Cc
         hEpyRAXNLbogMUooNqelYUl392dPHaaNba/A1Qw1K4qboic1yizCH6GMT0lVlMeaxbpN
         ZC1Nk8c3o9MbmzbswwC448i/4l8dZM/1II7Xhwb4S+G73J/7JwjVXWP1Y8HoBSlHqIj+
         RVwUXlJGurNSe/Ax3Z6MytTC0Lk7SxYli8zg5mpqVpoXRoHLdHDdfs4mtBlvipRVLFmE
         WOZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWASXcyQo3Em++vhPerPFTkIn7Bs8mJX+0gQuLb/7m7DiP0hC3SRrQCD1hFgcrCFyK1jRbSNZoucz/8eTzOAPyTr9G8qHq1G29VJatifWnKnXnXlq+IAF39oqCbKFXy/3dcFAxkmnJWm3RB/Avq/Rq464SSfBWQWhHUTHbKHM3dein5HGjcJWhVNUL/06FanmJSK5OdEN9rYbU8+NAVnTZqI6dTGY/x8AY6SKlw0AGPerVvhTRZPiJd6HhPUZnyz7MAh2BUvQ==
X-Gm-Message-State: AOJu0Yxv7C5EUWUBGyoEj0OlZMUOV38ZoLp6nLOMi1L7JlJmhewo6eOW
	QwdAHEZ0Oi95r4efjckkReIpspvxzDvtu0oOWiQofXhRoBVkPGy9GNBa7GFz
X-Google-Smtp-Source: AGHT+IE5w6dodX6tkNdpYo2JcOIQFCoBaWvJ3qj0W+78A8aPmU0fAixL3wQKsWOqabg+jcNHcrGYNg==
X-Received: by 2002:a0d:ea0d:0:b0:61a:e4ef:51d with SMTP id 00721157ae682-652d61e9c9dmr39923847b3.9.1720167188342;
        Fri, 05 Jul 2024 01:13:08 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-64a9ba5a2e7sm27802817b3.80.2024.07.05.01.13.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 01:13:08 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6504101cfd6so12313287b3.3;
        Fri, 05 Jul 2024 01:13:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWEXA0Z7eKZyJwrR4v8wVZLcf0Cj9LlgAmdcgphSbZE+xmcYZSi9s2HFwI5UVUusKBaQtpv3xv5ItuVKPwoO026FIEkhZnaFRWtwrjzBAQ2RsigT2FexW4IjaRTOVN+kX5Cldv44AEtWPvBuo8G2lqBTpS5mGJEf9DTvQCZ4OFVGaKp07wZZZLc1IdcvBJWHfKTeRkF/Cs9ecWANVar8UGkiEPzKgZ07fXx/SvuZf8nvvs2eCyqLK9wvfYcS9tgMPgV7Vockg==
X-Received: by 2002:a81:431f:0:b0:633:8b49:f97c with SMTP id
 00721157ae682-652d842fd27mr38728927b3.37.1720167188020; Fri, 05 Jul 2024
 01:13:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704143611.2979589-1-arnd@kernel.org> <20240704143611.2979589-8-arnd@kernel.org>
In-Reply-To: <20240704143611.2979589-8-arnd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 5 Jul 2024 10:12:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV-JtJWixt8J45rhZbpb7S90EDhp=x5iGGBhmUZyyQSnw@mail.gmail.com>
Message-ID: <CAMuHMdV-JtJWixt8J45rhZbpb7S90EDhp=x5iGGBhmUZyyQSnw@mail.gmail.com>
Subject: Re: [PATCH 07/17] clone3: drop __ARCH_WANT_SYS_CLONE3 macro
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Vineet Gupta <vgupta@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Christian Brauner <brauner@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-openrisc@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 4:38=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:
> From: Arnd Bergmann <arnd@arndb.de>
>
> When clone3() was introduced, it was not obvious how each architecture
> deals with setting up the stack and keeping the register contents in
> a fork()-like system call, so this was left for the architecture
> maintainers to implement, with __ARCH_WANT_SYS_CLONE3 defined by those
> that already implement it.
>
> Five years later, we still have a few architectures left that are missing
> clone3(), and the macro keeps getting in the way as it's fundamentally
> different from all the other __ARCH_WANT_SYS_* macros that are meant
> to provide backwards-compatibility with applications using older
> syscalls that are no longer provided by default.
>
> Address this by reversing the polarity of the macro, adding an
> __ARCH_BROKEN_SYS_CLONE3 macro to all architectures that don't
> already provide the syscall, and remove __ARCH_WANT_SYS_CLONE3
> from all the other ones.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

>  arch/m68k/include/asm/unistd.h                 | 1 -

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

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

