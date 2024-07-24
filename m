Return-Path: <linux-arch+bounces-5608-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D9893AFE5
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 12:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5583F1C21DEB
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jul 2024 10:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763841448E2;
	Wed, 24 Jul 2024 10:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uI2UdNIc"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B7D1C6A3;
	Wed, 24 Jul 2024 10:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721817231; cv=none; b=kIL+MuHorOJnQX6LWMyh4q3OP2BeQlwwHvvFga4QS4XEnEwU3qIRHr+rhboUkMYBNfzIsyUDyym1IU5k3hy2RPQBKfgBcgmab3RuMKf/bj3a3ayjpfNytRpbo8HDoGgI1mXUQgeUpv2ZvvEV0RlQIerTmGVGUJVJXjp3IbYRkIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721817231; c=relaxed/simple;
	bh=chkuohYruBsZOkXAIVCAGn1FeJRHNQhNsex2ncTdVxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pc17Hz2h6BYe4jHYciKH7mMWcymi1Pu+hydm42pfaHcRUW/4z1uZ8f4wzy0/9d5K3x7hOgsVtMSPMhAZMV8KQqAqTdZ/xoAi/1ddeH5pzkMg7pFuIxnnBkx/PMDPfjugtNXOyI7gOt/9fX3NSQbNAYRxiU6CeEcG2i+jpimU9BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uI2UdNIc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CDAC4AF0C;
	Wed, 24 Jul 2024 10:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721817230;
	bh=chkuohYruBsZOkXAIVCAGn1FeJRHNQhNsex2ncTdVxM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uI2UdNIcVE5bzNoyMNftY7nynFYxjXH8DWjTH7fv/Vof0DWc9oIpyw32X4ie0aBur
	 Lt68OfhcpzLRsAdkkBWpDegxjTlXHThjBNbRxWT3izOw8At1Xa6QkElmaZrMo/jpPy
	 JFNYT1PfAzwr5cHXyebSEurbIQJdEuXtkEZUk7G6InTOWCSsaAV97jMOXdIcjPv1zt
	 uuJnsyUgZaN6KtYIaRX5deARmtZFuMkGZgW4LjGZC+5fV111QhcRlhWioDBAjZJ0Gj
	 jU4UkdtQdjFCiOFltiggYH+RWOwQyTJLqQe3aLOy/dItYBhwW0Ojwg6jeeE5J8DTDR
	 y49FvKAHzcI7w==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso16670991fa.2;
        Wed, 24 Jul 2024 03:33:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWTMF225BswL7xeHw0y3d8bs0svNT4fRE37v/bzJOcViS0LdXbYRiZ/YeL0eUPzYIf7irMHBEOqt+nLDWx+Cx1Waiy+qCWuACQufg==
X-Gm-Message-State: AOJu0YyY4XLyEJZwl3iJJhF4hhSi2PpmD2UOJaGM76ZcdIay2SgWGg/n
	FrkkNcuJceZGLavcylHEnqO9laJRZQZTM3VZA3+YeWjH0wCYxiVhy6a2rGmGgydMeY1BZDuMEGY
	bycZVnbjIPYNQXmTWdxlaSxbDRRU=
X-Google-Smtp-Source: AGHT+IGPGjln8TR9TSGq0jAZpZTe7jVqYhkrBA2Y5oq1Rgg363wXXKoJpj94/uUZMyYrxlieaxEqS5FI5iq3/RslYl8=
X-Received: by 2002:a2e:93cb:0:b0:2ef:2c3c:512a with SMTP id
 38308e7fff4ca-2f02b99cf1fmr20185091fa.42.1721817229130; Wed, 24 Jul 2024
 03:33:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724103142.165693-1-anshuman.khandual@arm.com>
In-Reply-To: <20240724103142.165693-1-anshuman.khandual@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 24 Jul 2024 12:33:38 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHogmW9ZAZ8M3VtXvBvRrZ9L8DANmW0_rZ8TUx0DE9EaQ@mail.gmail.com>
Message-ID: <CAMj1kXHogmW9ZAZ8M3VtXvBvRrZ9L8DANmW0_rZ8TUx0DE9EaQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] uapi: Add support for GENMASK_U128()
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Anshuman,

On Wed, 24 Jul 2024 at 12:31, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> This adds support for GENMASK_U128() and some corresponding tests as well.
> GENMASK_U128() generated 128 bit masks will be required later on the arm64
> platform for enabling FEAT_SYSREG128 and FEAT_D128 features.
>
> Question:
>
> Proposed GENMASK_U128() depends on __int128 data type being supported in
> the compiler. Just wondering if that requires some compiler version #ifdefs
> or something similar ?
>

CONFIG_ARCH_SUPPORTS_INT128 comes to mind

