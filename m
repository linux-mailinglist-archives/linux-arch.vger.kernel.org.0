Return-Path: <linux-arch+bounces-10037-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 939FCA295D9
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2025 17:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8083A79CD
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2025 16:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707AA1917E3;
	Wed,  5 Feb 2025 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FygjAEt0"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0371519B1;
	Wed,  5 Feb 2025 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738771737; cv=none; b=r8cV9OkDlfOWq3A9ACc5HARcp2l7QmaUzEdL1Wr/IPu9LXnKhvAAT/KUs79vV1jpp1KGvK88So1NZ6oUdGReHrKxxavCKPgZ2gzYv4yUApEjtNdXqVXHB1kHw9cbmLtPvhtY+QgZYjW9AEaAWtazz2x1opKWE+hUbNeAomlKULg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738771737; c=relaxed/simple;
	bh=RhaEejtIzyjMiU/812JSoT1N/SGqGANo8ENt1YOM/Xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gWHwDhQTC2UdEdY+uHmKWsAlYaWI++C5xP5XlIXsG57Tr/+UbO/Um0NI5qLrzPURheNVjfJ8zfjYDWwnL8VCMCpuIQixgJL3gmqJ4i7jmzUoWJIYtd9LRti/EMA49hGo84zHW8YxLn+WFWVreNEGUX0+Slew44STfHRRQ8GPFx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FygjAEt0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA43BC4CEE3;
	Wed,  5 Feb 2025 16:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738771736;
	bh=RhaEejtIzyjMiU/812JSoT1N/SGqGANo8ENt1YOM/Xk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FygjAEt0ry4lE7T+mHKzgy+PS2QyM0UGOgLc3XWotiPUJ6DKPsh1Ar/CjR8aX94WY
	 HWlzh3c2/P//PLuIQCX5kYsLmHpMA4hCErpB3ZmbSGCVoynRamAoGxPf+bVZEm/hFp
	 cyajelxdmY0wFIT0/EZhp+RMGzPRxBifrlxMToe2eCIMRwU1ImK8hjjLi9CiG4t3RE
	 wB0NubMl/06hMuYLMprZxBCg/+rAucdM7w18R7NNOC0B4JrbAuYEdTPe/RMY5bkMgQ
	 RfcheSuuAjTiqAah4jXEP1ff0M1Qv7IKPJtzIOMnsYNYbvrphpNW/mt/shQX928DSs
	 Sr2hlfeTPeXTw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53e3a37ae07so7798313e87.3;
        Wed, 05 Feb 2025 08:08:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWx0nMhlgg6b4JcT/FzsUx3ODTXbeBHNzieaePmm0GxeB5g/vz7Dl4NyzjYlingkf3OFwEejk7x9RBx@vger.kernel.org, AJvYcCX9VTxy4ni0UN7TMOm30WvSYbzr7o5q6qEAojN0PeucRCERMdYAUKMREOAVBE1BhsKD85Ps+zGwcKuyFN73xw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxR7dwoHo8WMAYDfsTgcs2mJXHaqhBhxzEGkBdqFYUoH5CFBru
	bBraZQM80ktd2THYTj33pDuPABdcwqduVJlkiwGKg7ZM6hKNZta7wyXTe6QRcsbnrAQVigzJecV
	DIlAv8Uy3TGCN6+apGy2K8Feoxy8=
X-Google-Smtp-Source: AGHT+IGA5C7LqMJRIR+zc6GD2Sn7Ir0KtIousGtQnb5kwILD1qf2m4XzchrOh1RNRT1+NdhlZv6y0ohGziqKehNek7U=
X-Received: by 2002:a05:6512:ac6:b0:53e:395c:688e with SMTP id
 2adb3069b0e04-544059fd068mr1177110e87.10.1738771735305; Wed, 05 Feb 2025
 08:08:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201185143.1745708-1-masahiroy@kernel.org>
In-Reply-To: <20250201185143.1745708-1-masahiroy@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 6 Feb 2025 01:08:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNASFyJL8UOfFXxFcaoSNavkxf1dfShUZGF=pgbRYOARctA@mail.gmail.com>
X-Gm-Features: AWEUYZl1pzD30d8udCUuys8oj8GOyX6D1JtItfiOeZYh7qXhqeHJY7Wb_RTqrPQ
Message-ID: <CAK7LNASFyJL8UOfFXxFcaoSNavkxf1dfShUZGF=pgbRYOARctA@mail.gmail.com>
Subject: Re: [PATCH v3] kbuild: keep symbols for symbol_get() even with CONFIG_TRIM_UNUSED_KSYMS
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Daniel Gomez <da.gomez@samsung.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 2, 2025 at 3:51=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>
> Linus observed that the symbol_request(utf8_data_table) call fails when
> CONFIG_UNICODE=3Dy and CONFIG_TRIM_UNUSED_KSYMS=3Dy.
>
> symbol_get() relies on the symbol data being present in the ksymtab for
> symbol lookups. However, EXPORT_SYMBOL_GPL(utf8_data_table) is dropped
> due to CONFIG_TRIM_UNUSED_KSYMS, as no module references it in this case.
>
> Probably, this has been broken since commit dbacb0ef670d ("kconfig option
> for TRIM_UNUSED_KSYMS").
>
> This commit addresses the issue by leveraging modpost. Symbol names
> passed to symbol_get() are recorded in the special .no_trim_symbol
> section, which is then parsed by modpost to forcibly keep such symbols.
> The .no_trim_symbol section is discarded by the linker scripts, so there
> is no impact on the size of the final vmlinux or modules.
>
> This commit cannot resolve the issue for direct calls to __symbol_get()
> because the symbol name is not known at compile-time.
>
> Although symbol_get() may eventually be deprecated, this workaround
> should be good enough meanwhile.
>
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> Changes in v3:
>  - More precise check in case symbol_get() is called from a module
>
> Changes in v2:
>  - Call keep_no_trim_symbols() for modules as well.
>    EXPORT_SYMBOL() may disppear if symbol_get() calls a symbol
>    within this same module.
>
>  include/asm-generic/vmlinux.lds.h |  1 +
>  include/linux/module.h            |  5 ++++-
>  scripts/mod/modpost.c             | 35 +++++++++++++++++++++++++++++++
>  scripts/mod/modpost.h             |  6 ++++++
>  scripts/module.lds.S              |  1 +
>  5 files changed, 47 insertions(+), 1 deletion(-)
>

Applied to linux-kbuild/fixes.



--=20
Best Regards
Masahiro Yamada

