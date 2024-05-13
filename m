Return-Path: <linux-arch+bounces-4357-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A6C8C436D
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 16:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEEAE1C22F46
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 14:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E2F4C7C;
	Mon, 13 May 2024 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPndpuG6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3900B28F7;
	Mon, 13 May 2024 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715611454; cv=none; b=RtNn48MBei94oqapwlffckSWM4s7xi2ccO6cJKUq7nFUQftMjK88J1JZBnFeXGirG4r1Q35sdI33L6XYP9krhZyAuzgwlDLOnFH/fXcimBdYmfm9lykBPr1kMGQ9uXUygpePX0BFvkUm56j3c0M4Vo5jgCWEYFWpjmrcrg9nYzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715611454; c=relaxed/simple;
	bh=Wtg/SCzNy96+c2gHSPdp5I9ooMI7e9h6W3vFbDe5cjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qX1YjDY6HYKr8Gd4vmVyW2PhRiE0waPBQa5MaXttR9kDYbUFjhO01ebcKh7gIT4EyLdgcqWgPTnIy6liLMCFBnMAvcTrnSDWXj2QH+llW9U7q3zQBWwuHgmeXNe6LI0MiWyKO948w4vR1GkhAsrBJqUqsdLloRkG2ruamKEKS4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPndpuG6; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-43df7f42ac9so25541601cf.2;
        Mon, 13 May 2024 07:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715611452; x=1716216252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klxyG+w31HTv55FUS4dEXXQle51LU0Dzt6wJnMJ2rRw=;
        b=SPndpuG6ehwX6z0etLw21/zwYSVVi+/Han6sJQEGl5Z/5MDW2/3LE6Tn7SzgS9SPmH
         4VuELCxDbHMuzJC4xrKUkADxQEnRCVeBi/E7ga/A0X7Za39Gjy2DlXX3od6vUOBNJ1Ix
         +/ybMTYhHLi1QQpljyOqNE1BkszXPPdEsgmrmmOVYdqKjqOD+WS/svRpHkQzxzFE1lvh
         AIfHcvc8T7AizrsSz53qGDAXuZuTxOrDVfoR7EIv/pdYdppnMQfn9RpnpKjDPe6tOHmX
         W249mVyzSs0WBGKPcLG5Zuy3/ulnXS4k9+zMLrK3vCzqwP0By4qmwhxgvrBqz3sYQaZm
         +rYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715611452; x=1716216252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=klxyG+w31HTv55FUS4dEXXQle51LU0Dzt6wJnMJ2rRw=;
        b=k51xsu05a6zBKHF4cbiupoXt7kq0rsXTWEQwawmJzt846fNNDjSwsKrmD5CVOCFXsS
         OWrIi+c2OMujXRzw+tuOcMyDKgK8jZz1zLVu2xYpQTE2swP1HghiFiudf5f7MW+Evg9/
         svhXSrAaHZGptHwjDi4zNO4zl6OX9YG+07hNd45DSA6qP1KpTmMtoBXp9rC71oWBeu7t
         ZMfxIQBvV47avRgy6y6M2LEU8lmn8B/GkYcxq5CfI5bLY0KypQ3EPv2Oolk4+1HDahpL
         b0FB2kmwWW3VLxUc+azEULOnmFLealtrLqb7pEDEFXXUnm2JlKC3G4f/ZOvtyfN/RKCd
         aMew==
X-Forwarded-Encrypted: i=1; AJvYcCUzQc8LwrjZgKZnlG76JkJ83FuuPfFFxqSS247F5JfRATnVff6BvKgexake6PtGOS4oLxSP+nbREJXjOkFJ327G90CToNDpXsVQv1mo
X-Gm-Message-State: AOJu0YwkGezksN/hc8Xsy8jXLzmddlYZA8pm5e8GMo2mSbQGlj7GqA/j
	DlqDfmSHB7Cc4OnmCw7uuqO6iCZkZgPe9DV36/7p+QgKIijretLi
X-Google-Smtp-Source: AGHT+IEZfiB8pXzpt4oTJI9EtYekid2EcqXtR2fGxDYw45bzG0njNvPMvJROlerSAOqpFeKk2/THgQ==
X-Received: by 2002:ac8:5a8c:0:b0:43a:ea41:c9cd with SMTP id d75a77b69052e-43dfdb70c38mr144182491cf.59.1715611452216;
        Mon, 13 May 2024 07:44:12 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df56d0396sm56146551cf.86.2024.05.13.07.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 07:44:10 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 17EB11200066;
	Mon, 13 May 2024 10:44:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 13 May 2024 10:44:10 -0400
X-ME-Sender: <xms:OSdCZljZOf7-imLihoohQWZX-8m6yvUHkqHtLOqr7RANGBn_E5CmdQ>
    <xme:OSdCZqC2_CxYxosSMYwEUF9nVezAdO0wSVnJbG0aZS5mH4YQ0sGVPIrjUOkjV3epX
    QfSz5Edj62j1K_qNg>
X-ME-Received: <xmr:OSdCZlHajUarthijE2U_ktGuEOq_Lb47h4bZQim7UUVDbamxDwSfW3bT3MD2eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteehuddujedvkedtkeefgedv
    vdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:OSdCZqQmGkIrcsTnl0epQGXiWt-PlLdxwYILx8Ldrq-ibjb2Ht0Jmg>
    <xmx:OSdCZiyQTbdPxpvFGon0cPOY7kSEqTzUibBPmQSTtLDSLkJK8ffOfg>
    <xmx:OSdCZg6HBE2gNQGLe0nZUb22UdPQkTX-A7yEz8oCi_iqmLKq_LFAqg>
    <xmx:OSdCZnymyfOP9rnTt3LwYtz9ZAZYbmr88uOYnoBFDiKGwRicCZhDRQ>
    <xmx:OidCZqgXcAPCEkkwCBau8KqmV2q4A5fwUBPLKiR1ZlACW77gu5zBT4pk>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 10:44:09 -0400 (EDT)
Date: Mon, 13 May 2024 07:44:00 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de,
	peterz@infradead.org, dianders@chromium.org, pmladek@suse.com,
	arnd@arndb.de, torvalds@linux-foundation.org, kernel-team@meta.com
Subject: Re: [PATCH v2 cmpxchg 09/13] lib: Add one-byte emulation function
Message-ID: <ZkInMNOsLO5XbDj5@boqun-archlinux>
References: <b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop>
 <20240501230130.1111603-9-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501230130.1111603-9-paulmck@kernel.org>

On Wed, May 01, 2024 at 04:01:26PM -0700, Paul E. McKenney wrote:
> Architectures are required to provide four-byte cmpxchg() and 64-bit
> architectures are additionally required to provide eight-byte cmpxchg().
> However, there are cases where one-byte cmpxchg() would be extremely
> useful.  Therefore, provide cmpxchg_emu_u8() that emulates one-byte
> cmpxchg() in terms of four-byte cmpxchg().
> 
> Note that this emulations is fully ordered, and can (for example) cause
> one-byte cmpxchg_relaxed() to incur the overhead of full ordering.
> If this causes problems for a given architecture, that architecture is
> free to provide its own lighter-weight primitives.
> 
> [ paulmck: Apply Marco Elver feedback. ]
> [ paulmck: Apply kernel test robot feedback. ]
> [ paulmck: Drop two-byte support per Arnd Bergmann feedback. ]
> 
> Link: https://lore.kernel.org/all/0733eb10-5e7a-4450-9b8a-527b97c842ff@paulmck-laptop/
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Acked-by: Marco Elver <elver@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: <linux-arch@vger.kernel.org>
> ---
>  arch/Kconfig                |  3 +++
>  include/linux/cmpxchg-emu.h | 15 +++++++++++++
>  lib/Makefile                |  1 +
>  lib/cmpxchg-emu.c           | 45 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 64 insertions(+)
>  create mode 100644 include/linux/cmpxchg-emu.h
>  create mode 100644 lib/cmpxchg-emu.c
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 9f066785bb71d..284663392eef8 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1609,4 +1609,7 @@ config CC_HAS_SANE_FUNCTION_ALIGNMENT
>  	# strict alignment always, even with -falign-functions.
>  	def_bool CC_HAS_MIN_FUNCTION_ALIGNMENT || CC_IS_CLANG
>  
> +config ARCH_NEED_CMPXCHG_1_EMU
> +	bool
> +
>  endmenu
> diff --git a/include/linux/cmpxchg-emu.h b/include/linux/cmpxchg-emu.h
> new file mode 100644
> index 0000000000000..998deec67740a
> --- /dev/null
> +++ b/include/linux/cmpxchg-emu.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Emulated 1-byte and 2-byte cmpxchg operations for architectures
> + * lacking direct support for these sizes.  These are implemented in terms
> + * of 4-byte cmpxchg operations.
> + *
> + * Copyright (C) 2024 Paul E. McKenney.
> + */
> +
> +#ifndef __LINUX_CMPXCHG_EMU_H
> +#define __LINUX_CMPXCHG_EMU_H
> +
> +uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new);
> +
> +#endif /* __LINUX_CMPXCHG_EMU_H */
> diff --git a/lib/Makefile b/lib/Makefile
> index ffc6b2341b45a..cc3d52fdb477d 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -236,6 +236,7 @@ obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
>  lib-$(CONFIG_GENERIC_BUG) += bug.o
>  
>  obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
> +obj-$(CONFIG_ARCH_NEED_CMPXCHG_1_EMU) += cmpxchg-emu.o
>  
>  obj-$(CONFIG_DYNAMIC_DEBUG_CORE) += dynamic_debug.o
>  #ensure exported functions have prototypes
> diff --git a/lib/cmpxchg-emu.c b/lib/cmpxchg-emu.c
> new file mode 100644
> index 0000000000000..27f6f97cb60dd
> --- /dev/null
> +++ b/lib/cmpxchg-emu.c
> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Emulated 1-byte cmpxchg operation for architectures lacking direct
> + * support for this size.  This is implemented in terms of 4-byte cmpxchg
> + * operations.
> + *
> + * Copyright (C) 2024 Paul E. McKenney.
> + */
> +
> +#include <linux/types.h>
> +#include <linux/export.h>
> +#include <linux/instrumented.h>
> +#include <linux/atomic.h>
> +#include <linux/panic.h>
> +#include <linux/bug.h>
> +#include <asm-generic/rwonce.h>
> +#include <linux/cmpxchg-emu.h>
> +
> +union u8_32 {
> +	u8 b[4];
> +	u32 w;
> +};
> +
> +/* Emulate one-byte cmpxchg() in terms of 4-byte cmpxchg. */
> +uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new)
> +{
> +	u32 *p32 = (u32 *)(((uintptr_t)p) & ~0x3);
> +	int i = ((uintptr_t)p) & 0x3;
> +	union u8_32 old32;
> +	union u8_32 new32;
> +	u32 ret;
> +
> +	ret = READ_ONCE(*p32);
> +	do {
> +		old32.w = ret;
> +		if (old32.b[i] != old)
> +			return old32.b[i];
> +		new32.w = old32.w;
> +		new32.b[i] = new;
> +		instrument_atomic_read_write(p, 1);
> +		ret = data_race(cmpxchg(p32, old32.w, new32.w)); // Overridden above.

Just out of curiosity, why is this `data_race` needed? cmpxchg is atomic
so there should be no chance for a data race?

Regards,
Boqun

> +	} while (ret != old32.w);
> +	return old;
> +}
> +EXPORT_SYMBOL_GPL(cmpxchg_emu_u8);
> -- 
> 2.40.1
> 

