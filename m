Return-Path: <linux-arch+bounces-15762-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EC4D17211
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 08:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 32E453012C52
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 07:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E57C311C10;
	Tue, 13 Jan 2026 07:56:17 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-vk1-f193.google.com (mail-vk1-f193.google.com [209.85.221.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8408E3090CC
	for <linux-arch@vger.kernel.org>; Tue, 13 Jan 2026 07:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768290977; cv=none; b=vBS0Bhra4AhQqoHEOueuNwCiGThfndU7Dc9RdvNHtE08+Od0wDpXCDGfK8KNvgVTa1/cEo3qoLvCjNaWShgeEE1FOBa1db9uOVwpagPqOnmBQ44949yOAPGcLGIZGdia/bGild5TV1L4zBFREVZhWQo50GXlZpX5gme3VTrsoL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768290977; c=relaxed/simple;
	bh=n0dF2Fe8tSdrXokCIMgp4lK4sPjCkU1ooCoSBypgxBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g6Qmq3NK7aOzrX0WBJMrkxP781b67xxDu1tv3NZxC1NCm6uCu1xqyMFnyfJvfF9TvhFHlbwMjnBww70vsXns2t+w+a1i/BGgwCfqi77VibCriDxa80jFL6+oaoPR+YqbUnO7n02oLEK0YK/Cxta67jkVcdXIdjgYFv4hZLOHqCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f193.google.com with SMTP id 71dfb90a1353d-560227999d2so2469864e0c.1
        for <linux-arch@vger.kernel.org>; Mon, 12 Jan 2026 23:56:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768290974; x=1768895774;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmIOh9tePUcFI+zdOYsAhgLlKNGSbSvD7MYXL084Vks=;
        b=Je4IN48hUIrEIGU+9WZjXfzn7nXlaL22iV9kbAbQHDBIC5/ZpZhLhPlpW1EZNILl7/
         FR4dkBGiIjyINHR52V7hui4atmA6/ylhq/ngS0nuCLV8f8pBtsfaQCndY+Sn8EQLDzpb
         M9H7ko35bSLX1ie3E6Ck7s83p9MjVHrPSOdjZUayEFAJZWlXPl1911pWHwM4X1QDHysx
         qjMGNhLgj2aYG9OHovnHQ8RbVo7aoYdYg2ul68LojZlLn+fuX8Fcn91br9OEF4rmuVyb
         Aw0eTj6fk84hwizKrc7ocLjNEIWXQXV5KQ8nOkq05HKzudaKUARQPhklqgC8L3Kr1tmB
         ieBw==
X-Forwarded-Encrypted: i=1; AJvYcCXyH7k1MGAhbymZuId0K6e3Ti7JN6pGj8Bu1n1JKg/d1tjJ3ycasgb7c+UyL9ZjwTMVcxVZj0T6hR3l@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+G/6EaZdT3os/Y30GBF3SAmPDlk0A2j7tYwEBtydSSumiIVlo
	kIRqIUbELBhc5pbNkG68YznRs+ksTyZRZpi0ZCAJ6Y/T5rt8l9ew1eBSUhUTzHI8qNQ=
X-Gm-Gg: AY/fxX4ht2VZxGxJVkJNRYRzjBXX6UmdX4DwvV4AgRO8r1ngBNvUi06jf/M2B9lFcQp
	gkOfd7FuRtS3b8Df5Tp1L9Y9Lp8muSqWoYeln5wDY8tNTuVupzCByy0pa6JfXNnkvzyHpR3Gi1e
	1QlXRBXlRC1T2HUhYOrQFJN+D7kheTPW92pdLZdSpgWY396IK9js/43RXT2tJyTAh14nk4rfYNj
	8UhWUGJXyNPgbKDYu4BOhDL+mpU99Ivo1c3UOyKsFUcRoYWSlpvb1KL7mjIiIQ9t9kbILaW2f6G
	1gpTsTrCsG14UMfANh/gvGIPZMpqCsWzikfu1enir97nkIG1jghy0NaoYDcoasx/PeIz8jVBQck
	KQ0QjMLvWdveZjtgz0yQA4bFO2FmyoNam9lqHjSjzzdf5DzAZwqBor01rxuMEJeAiWPPkWg40gX
	Q+wGf5yJCWN10VoCco8yiaytny9jIAMEfKkcz3AWQKLchT+yuc
X-Google-Smtp-Source: AGHT+IHL9VYaQJhK4tCWuiEMB5+ppBq3+lU0lbhHy0jeN/fBEhcNnCDXTJWuxTtWfaYcedqwYEMgeQ==
X-Received: by 2002:a05:6102:54aa:b0:5ef:a644:ca4 with SMTP id ada2fe7eead31-5efa6441614mr4199373137.23.1768290974537;
        Mon, 12 Jan 2026 23:56:14 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ee9d013b3csm15277511137.5.2026.01.12.23.56.13
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 23:56:13 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5f1726c2a72so94135137.3
        for <linux-arch@vger.kernel.org>; Mon, 12 Jan 2026 23:56:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX18KxpTSb5XG+TadoQXhn3gqvmvwitq/gC8+697dZfZmpQApilvyuQ10j0lSrdtNqqXh2X19LgOwXe@vger.kernel.org
X-Received: by 2002:a05:6102:3a06:b0:5ee:9fa4:19d7 with SMTP id
 ada2fe7eead31-5ee9fa41a9bmr5674729137.35.1768290972875; Mon, 12 Jan 2026
 23:56:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768281748.git.fthain@linux-m68k.org> <51ebf844e006ca0de408f5d3a831e7b39d7fc31c.1768281748.git.fthain@linux-m68k.org>
In-Reply-To: <51ebf844e006ca0de408f5d3a831e7b39d7fc31c.1768281748.git.fthain@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 13 Jan 2026 08:56:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXSXcxzhgfFyc3sBdyoJ4vq9sMpzLBLcZskqtZXdAjH+g@mail.gmail.com>
X-Gm-Features: AZwV_Qg_Z9QZfAG1qbe85SkafzpcqvnHvixniNVcQY02OLTaoULqX8NYTMrQWAM
Message-ID: <CAMuHMdXSXcxzhgfFyc3sBdyoJ4vq9sMpzLBLcZskqtZXdAjH+g@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] atomic: Add alignment check to instrumented atomic operations
To: Finn Thain <fthain@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	Sasha Levin <sashal@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Ard Biesheuvel <ardb@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"

Hi Finn,

On Tue, 13 Jan 2026 at 06:39, Finn Thain <fthain@linux-m68k.org> wrote:
> From: Peter Zijlstra <peterz@infradead.org>
>
> Add a Kconfig option for debug builds which logs a warning when an
> instrumented atomic operation takes place that's misaligned.
> Some platforms don't trap for this.
>
> [ fthain: added __DISABLE_EXPORTS conditional and refactored as helper
> function. ]
>
> Cc: Sasha Levin <sashal@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Link: https://lore.kernel.org/lkml/20250901093600.GF4067720@noisy.programming.kicks-ass.net/
> Link: https://lore.kernel.org/linux-next/df9fbd22-a648-ada4-fee0-68fe4325ff82@linux-m68k.org/
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
>
> ---
> Checkpatch.pl says...
> ERROR: Missing Signed-off-by: line by nominal patch author 'Peter Ziljstra <peterz@infradead.org>'

Alternatively, you can credit Peter using

    Suggested-by: Peter Zijlstra <peterz@infradead.org>

just before the Link-header pointing to his suggestion.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

