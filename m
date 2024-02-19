Return-Path: <linux-arch+bounces-2483-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A0385A13E
	for <lists+linux-arch@lfdr.de>; Mon, 19 Feb 2024 11:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A95BD1C21829
	for <lists+linux-arch@lfdr.de>; Mon, 19 Feb 2024 10:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3F52C1AA;
	Mon, 19 Feb 2024 10:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIJumwB8"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF88E25610;
	Mon, 19 Feb 2024 10:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708339516; cv=none; b=szy/5n/Yv7RZHM2isonWBO/qewUOlZ79FXak6mdC7WSCJI2yHwUAWTmDkaGZWpAAhRmfbIcPi98u2Hnm6D/PQl4TkjA4JnBttnkGxBw5ZFg9uUzUuqtNiNNnaNF6yfPX6VHZUYhsL8cYzPHyvGZNPl0Fhz2WQ82SkTEOBNK4L4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708339516; c=relaxed/simple;
	bh=9QblGuBQMTRAxMtLQSmfipyT83uQRzyTThIhaJdzMpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f8jStiDDb8c1wz4eigDKbSz2APXDgZoQJZ8BLm9yZFORwZsh1CEWUhkm72tqHRtYbF7ktFft8xa8VKLaucRmrQ7dC1CTudOKF1qMuRN+KRtK5s0da2jq3386qHE1sRkVo7l8q8IE6H/6UQ8tNjwBr8Gn7L5C99p+ojr/iYkCrjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIJumwB8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6987C433B2;
	Mon, 19 Feb 2024 10:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708339515;
	bh=9QblGuBQMTRAxMtLQSmfipyT83uQRzyTThIhaJdzMpk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZIJumwB8R7eqK60oBr6HKlh5JwvXfpAWD/GV6rAjoPva0gCmMfTvjmup+QgCN9W4B
	 4QFZq86BaQvNwDnqpmhcbkDoYbyw+ewKWzVML75MmhrGtgJTmUl6WYc/DOSQY+BmFU
	 RTKL/R/HVPB4V10pnEU7fdcgssxA8XmmNdKGn7QQJo2eAeH2FUdqXae6/RQO5rznLi
	 Srryh0ClDisBEIrH93xRdkt5EiuBtEIWAhYH/290R1eYJGuGSmGzOpdZw/WzuJFI20
	 k4H8GlizlvtQ9hAARbzFmH4zfzqtDRWHSaWA4FNqx4BdNwH6vtv4n9ZgTcY1dbTuVO
	 gEGKgfjlmA1BA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512bce554a5so341026e87.3;
        Mon, 19 Feb 2024 02:45:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVEA2eckF7jdfu5AHlDPTOX5m1R0kMQzksnMthEyfyrzKGl6nscc3fVOMIKmPaXbZSc7cpDcu9VUIRRYSOp/otRktSxTFLpAJF2dCEK234uWVNMvw5+VL84Y6iPXFpzAW5Biwf9RiRmPQ==
X-Gm-Message-State: AOJu0YwZJWyrgZNJmf93SupTjzChQNAjTdS8UXQ2R+I4oYKeMfckGf1u
	3EyPwIFj8nFuK+4rZJbV3hZL264YVzFcOUSjbz4Q0ta2YqKDO2pfTQAQbzm1eE2ymrYkoGxec0v
	ugrixA9CxxqXh/axzu9DcVxY7rTY=
X-Google-Smtp-Source: AGHT+IGve/Indyni0P6jSyCDOmmbyO6bbEweKh22oyzFIGyceMfXrkQZDi1GAUKLeQmGxmskcIp0PrTvN6XjEPSgt3g=
X-Received: by 2002:a05:6512:2150:b0:512:be4c:b532 with SMTP id
 s16-20020a056512215000b00512be4cb532mr211883lfr.59.1708339513934; Mon, 19 Feb
 2024 02:45:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213124143.1484862-13-ardb+git@google.com>
 <20240213124143.1484862-15-ardb+git@google.com> <20240217125102.GSZdCrtgI-DnHA8DpK@fat_crate.local>
 <CAMj1kXEcTfvRcNh_VDhj5QxzMhD9rFhVmeAfuSF7vm1c_4_iHg@mail.gmail.com>
 <CAMj1kXFkX2hwt7Z-_xMveC-RHrxmXWcrneVH66HsjBcXOLAH0g@mail.gmail.com> <20240219095530.GBZdMlkgf_jzDxM8XR@fat_crate.local>
In-Reply-To: <20240219095530.GBZdMlkgf_jzDxM8XR@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 19 Feb 2024 11:45:02 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG0uwH7SDq3HK6cKqoq5V28e54r2PdeJ=MH5eexXnV6Ew@mail.gmail.com>
Message-ID: <CAMj1kXG0uwH7SDq3HK6cKqoq5V28e54r2PdeJ=MH5eexXnV6Ew@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] x86/startup_64: Replace pointer fixups with
 RIP-relative references
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Glaze <dionnaglaze@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Feb 2024 at 10:56, Borislav Petkov <bp@alien8.de> wrote:
>
> On Sat, Feb 17, 2024 at 05:10:27PM +0100, Ard Biesheuvel wrote:
> > Maybe this is better?
>
> Yap, looks better.
>
> Btw, when you paste those diffs ontop, can pls make sure you paste them
> in applicable form so that I can apply them and look at them in detail?
>
> gmail mangles them:
>
> > +
> > +               pgd[pgd_index(__START_KERNEL_map)] = (pgdval_t)p4d |
> > _PAGE_TABLE_NOENC;
>
> For example, linebreak here.
>

Yeah, sorry about that.

