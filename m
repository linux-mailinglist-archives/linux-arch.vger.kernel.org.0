Return-Path: <linux-arch+bounces-11599-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A04A1A9D995
	for <lists+linux-arch@lfdr.de>; Sat, 26 Apr 2025 11:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F5287AA11A
	for <lists+linux-arch@lfdr.de>; Sat, 26 Apr 2025 09:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7414D21CA0C;
	Sat, 26 Apr 2025 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGvie6s6"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379BF224226;
	Sat, 26 Apr 2025 09:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745658468; cv=none; b=sBdnFYBQvQhoUp86aLOtKEUS8ZTT3cX5o+R1NCEL2nDct931UNUx56qu/AELvu5iWLFJud7ASnEWwLauSeddSvZ9SdOKomavs/sGDnz9FMu7pS1VpiYE8UHk2mgj27vVs+X/e5wdE2LNh2bJiol099Nv3KXuswW/myv3w3iI7lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745658468; c=relaxed/simple;
	bh=tWnubF9yZCDGQjCpvAPwhcthzUF61M7My64owmsX1wE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQgSLtoVGwzgH1W4fC2u16TqL+OcJDdLHU24OcgNYFDIjc+/khBXTx4sIRiwSJYA1X6CCfDb78IyO77EauVM8Q5dhKFgPUmymgstSw0buhUZ+bIRIz2ANYQtiKkX1P7Do78VcWjA8qpjuC7eT4PYZ5iITue/SN8D32ZgSVrZzBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGvie6s6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3438C4CEE8;
	Sat, 26 Apr 2025 09:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745658467;
	bh=tWnubF9yZCDGQjCpvAPwhcthzUF61M7My64owmsX1wE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BGvie6s6s+W7PK3hxSq8nPlG8ennMfM3lnISFEQrUyC4UzK78trdr7Q3N4PxZWKGm
	 u3JYC0P0nu2po5zLfchiwxvN07nheJw1c8N3DJ0oYXgLh08sxsGZzR+BZhoCgqYD87
	 kykCpg/vW//2i+YNodprO2sgjUXdo+RjDbir/vOJ6Aq1fSh2X3o5aharuwWiRNr/wQ
	 HJB5V2cdNkHE2Yqtyhq9ZamuUFceakG8CT0ggdIczCuVeA0YaxctVXQcTQcrXHPZbe
	 J0BHWNzQwvXFFybH2feeOqiJZWQXbxgWkrSLrYO/nUzaMAHa5G1KZNn7WjNo2k3f3o
	 Wt/RAbFEwiipw==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30bfe0d2b6dso29853061fa.3;
        Sat, 26 Apr 2025 02:07:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVSR9DbmCR86WQB3YMTkX+lZ4eolEumGk7AolNPjaEWT4SprFH0HQBzglCqVmEnJA/oLJHyAejp1gY74cVs@vger.kernel.org, AJvYcCVhrOirHO0HA1JLMELibq1kxXE5+B2pbxAXTfCj2u4qgQpgfiiHnAM5zFSXSYW9kKCeNGfw+jpTkKX+RQ==@vger.kernel.org, AJvYcCWS1GhMe/1cEd85xR+64z7tLu8RSXqsXIXaaFKHyNnvQoBfrLsn8YHwAGRvQa4BGKU/V5mAzs4Kw/MS@vger.kernel.org, AJvYcCWfMVKzvyr8ZJ9bWnxte36HQhPyj/0PlpTue4q0auTq09urvbgxpex5aH3Q/6QgXxZPXaaYMbZz891o+w==@vger.kernel.org, AJvYcCWxmv0UXNpcxxMnWkmHvCAuVKXAL2NfDJLnYZNXvOX4JCGMZAIGtcMMzdY0urk1VxSpQ4ct92raY7E4oA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuiKReGLeII1PZDaj6rann1cYjfjSS/OnRRN+un2KkV7o1OkZN
	nQ9J7CrKOk7i5fTH7ESY13x384IhLjw2VbZOq7bipCGdS7A7ee+QOAM5zaVqUScRkfDnlF848tf
	/R2DPnJURTZg9I2Ht7MejLokeP0c=
X-Google-Smtp-Source: AGHT+IFQ6d5LkceuPYf/xl1qz8Cz4agL96VnxeacTrxQe8bWMsw0LVAsS8Ui3mFUbafLHpHr7zqezdjks0Oba2s2Raw=
X-Received: by 2002:a2e:a9a8:0:b0:30c:1fc4:418e with SMTP id
 38308e7fff4ca-31907611d52mr17479061fa.26.1745658466100; Sat, 26 Apr 2025
 02:07:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250426065041.1551914-1-ebiggers@kernel.org> <20250426065041.1551914-4-ebiggers@kernel.org>
In-Reply-To: <20250426065041.1551914-4-ebiggers@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 26 Apr 2025 11:07:35 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHd7zDfH3FzrEiEd07SHa9Kg_P0LYaKNZL-WFR1gYwxww@mail.gmail.com>
X-Gm-Features: ATxdqUGuJmhadssxS6Ou5Vd5gSzDagv6eV7-J6URiZ1n5H0_6vtm3_ipq2KqSAM
Message-ID: <CAMj1kXHd7zDfH3FzrEiEd07SHa9Kg_P0LYaKNZL-WFR1gYwxww@mail.gmail.com>
Subject: Re: [PATCH 03/13] crypto: arm64/sha256 - remove obsolete chunking logic
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org, 
	linux-s390@vger.kernel.org, x86@kernel.org, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 26 Apr 2025 at 08:51, Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> Since kernel-mode NEON sections are now preemptible on arm64, there is
> no longer any need to limit the length of them.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  arch/arm64/crypto/sha256-glue.c | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

