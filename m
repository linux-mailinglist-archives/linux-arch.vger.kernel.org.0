Return-Path: <linux-arch+bounces-7502-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E5C98AB6E
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 19:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1D3D282B6E
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 17:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADBB198A2F;
	Mon, 30 Sep 2024 17:52:43 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA49618C31;
	Mon, 30 Sep 2024 17:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727718763; cv=none; b=eNXfxwvuT/ROQD3KIkd9twcZXFETLspFPcgXevhqbrYQlLI3axJF49mvEjPVDX/6bGABN2aUDN1QTbaCfoi1oELVt9Ihhpr7axA2ZjveNUgirakQNxtgx4Pw5xzUOse+jVJz/OX7vBl0bUojjPBP5bX8DyhPGSEMJ0sjSmAinM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727718763; c=relaxed/simple;
	bh=TOOuuBttpBHTK/VFXkEJ6D++xCveU/rYxT8fYGWJb0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eUlqCzLWa5Qfdeell2ku9MyBkLvvpb8uShe7g97ZnTpoaISii1kcOzVOMcRk2WL0Q0yTDqhG5DgIcjPpNZLoUhpY4o6dzhqJzIgGyE47otVHHOznZXE3cGMFM7VNgJNCTkCLlJCel0gGSatgMsMD5tS3fgmjFBZ6V/rL47imutg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso4032163276.1;
        Mon, 30 Sep 2024 10:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727718758; x=1728323558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1uPwxLcg5Bq74tqCqqhr1kbUuC1X8WKeLcVZP/gaR94=;
        b=wJHVcNIzZNnVZFP9y2ScfvG0sWkJYkBHHdlF/oFKmjyPKJHmrJLDPu+Ag0cZ2dmOAv
         sh+H2qUo0qBcMXxyU4pzHhqDpeOUN2iZwmM3f79rTZ3O2JjPaIAIuTFJ7H2lQoxwt+ie
         ycj1DMnN4qYcDx1EF7c6iXWv7cPm5DtaVsmxQIxmrmZ4dXWBHC2oOxs4iqKwj4+wa9xh
         oMzJJlCMPCqdcECgVSEOYisRCBdFAOH26J5U8tcZOI/f5RO0Wsj4uiks6rfyQeWYSrqZ
         O2TwRgQbeffB5NoFaHZU5CYvLrFlwtv/PDbEkQ26fSaj2YDL1IiZOo9Li5zUkRtVOOs6
         f27g==
X-Forwarded-Encrypted: i=1; AJvYcCUWg/q/yfysl0oA5kRiNztYAvwnp11SwfCOFpNJK/c+zgh3+6rY5u/VRfFomN8pqjtQTPTgvX/PO/2Iqdd0@vger.kernel.org, AJvYcCVBaL0pjmy6xSMTYG0TWF7NDjCHaX6+R6GNO6HMh7unVPO3dliWhLrS6SdYzirWIhH/VBEA89utH5bY+Q==@vger.kernel.org, AJvYcCXcjSnHPMhuklkyl5e3uu1hGANWSS/50zNeuGwoCqU66tjNXbx/Jir8llQWbWtAJ9+TDcOOz/0KiWwjCg==@vger.kernel.org, AJvYcCXdi5DN0jBeqAbFTDmLNPep9yasKRB7moSYmhSB8AGpPLgAqE+yWCLKvxB2+yJomPcG/P1AyNYwfywmup3K@vger.kernel.org, AJvYcCXuGLLMwd3EuYGvWAcwJcS9I7hiLjxhzBFN7Cmw5KloVWWHTB/FD4mBZwj6g9XSmH1vnUI9GtVzcuk=@vger.kernel.org, AJvYcCXzJxgVxN9ySfJfbjxQ3mIMqcb88O76hqXF/2bImqd9MrwgQrvhmk+QDgfSHBv+7aztnTDKQoBOlk7CkA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWZU9AmRDdihWWxqAD3TIS1n9vfGUF9NLZFGy+k9Pd0soxVTgC
	WznBOTUG93mMTccs8HAmZy6ZsjneKG47OKdaskQix5BjUH5diXRHwsOeiO4a
X-Google-Smtp-Source: AGHT+IHOv+HbpqmfBe8XWVdJmLn/+157Wl7GTtutPjDKKRI2377B5oy/De67xatOq0WToPCPAcHx5Q==
X-Received: by 2002:a05:6902:2289:b0:e25:abb9:c71b with SMTP id 3f1490d57ef6-e2604c7b6e1mr10920364276.39.1727718758067;
        Mon, 30 Sep 2024 10:52:38 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e25e6294a3csm2405672276.52.2024.09.30.10.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 10:52:37 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6db20e22c85so40537767b3.0;
        Mon, 30 Sep 2024 10:52:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUdEsNjs3zt6wJjpNMcqVEFEvlDwKzd5snRfxqXo+xkxuhvxBuBHVN951N+euzF28TWnPjWcUR3z8ArdAVV@vger.kernel.org, AJvYcCV9Nacq52xn5QiAuS2T74gVYoTrNvyCRqXgE/sCBvtBewRVdxe7oUIMB3YE7nL/74EUJ8oAFSvB19RISA==@vger.kernel.org, AJvYcCVrXUdWycwLzNdRBSa6Ox4TKaBxKPnC0FXXvcV9oqr1xRiZ3Qg4Z9aTQSzRseis4+nAdor6WjnjeTj5o7Mg@vger.kernel.org, AJvYcCW6MfbFO/BxzMJkeF8l4RU68v2ciQDnHqbU2U5kk9i+OY+DsijDJZuKLS1hqCjAIoSRpr3A6EPb22I=@vger.kernel.org, AJvYcCX9jMiNIOf7vLKOH4Gb6R/DL9riKEP3ipBgqS2ZQrtMqRaJcK4qC8UbmEtBZEs2mcLW5Gj7w91B8kxLZw==@vger.kernel.org, AJvYcCXEpqhdyc2ge0Dl9BQdDlfA9ilu7syN6hiF+B25S/2z7a7DupgtHOc9lnbAeGALaZRxBlLaDAxfU8n3KA==@vger.kernel.org
X-Received: by 2002:a05:690c:d1b:b0:6dd:ba22:d946 with SMTP id
 00721157ae682-6e247561690mr104291347b3.13.1727718756479; Mon, 30 Sep 2024
 10:52:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930132321.2785718-1-jvetter@kalrayinc.com> <20240930132321.2785718-9-jvetter@kalrayinc.com>
In-Reply-To: <20240930132321.2785718-9-jvetter@kalrayinc.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 30 Sep 2024 19:52:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWpiS-MgQZ8YyX=PDvQ+ZvS5TdMV5wn11MKFZVT7CHDhg@mail.gmail.com>
Message-ID: <CAMuHMdWpiS-MgQZ8YyX=PDvQ+ZvS5TdMV5wn11MKFZVT7CHDhg@mail.gmail.com>
Subject: Re: [PATCH v7 08/10] sh: Align prototypes of IO memcpy/memset
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
> Align the prototypes of the memcpy_{from,to}io and memset_io functions
> with the new ones from iomap_copy.c and remove function declarations,
> because they are now declared in asm-generic/io.h.
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

