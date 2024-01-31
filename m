Return-Path: <linux-arch+bounces-1896-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79ACF843B20
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 10:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1904B1F2C489
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 09:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8C2657BE;
	Wed, 31 Jan 2024 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BI+GR4Bj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D69560DCC;
	Wed, 31 Jan 2024 09:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706693423; cv=none; b=DUGZK0bGR9ACpZyjpFr5dI5kV4aFKoKyuP4EV6DuNBQDHHLQzKlaVOo9es3f0kEWaaZQKUIpANLSF7gUf/Yy9xp/0Rwjkpgb2i7EfEPuzgYAkY7gkIwq6ibCWYs1mp9sPSftBAcZsHP6Juav7z6ffV3Kb1nxXR/CXtQjtuxzvrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706693423; c=relaxed/simple;
	bh=Gez7VbeF659gZEkC8FCMwPC1tU8GUsrN0yYCZ4bjcxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMZBC/bjujBI8weztxN/LFT3NOqnOH6EO/8pmmfmfLnqYrEIgWGbOtrj7pWAvaZmbH1EUyL11zmluAn0q/yZdnd+56d4ju62KkzMkHvDoOCyUdERICz7sG425PofPHxiyviHyf750fj7CrWCn4WKEjPXIqW8MeRjEC5RBZMfyGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BI+GR4Bj; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0327840E00C5;
	Wed, 31 Jan 2024 09:30:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id s-UgUl8KYLm8; Wed, 31 Jan 2024 09:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706693415; bh=r2DcM4ro+qsysihnxyBJGhyOPymf2yk6oBbpEdllaa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BI+GR4Bj7fdTu0/S9ol+YgYAt0RK7PFx2iM963t17eHrJTwzJQCfzG7UXy9CXuZf1
	 PwldErDu3oKQaLUtO82oAVq6+jOBblBG7D5fjcDzInWveqnSzcIo1xAkANVGeGS1ki
	 +JxvVZZuxZ4RF+ltMamgsePeF+bgrJmYCY4gUc2iCxSGiXLjLN7RaTmMEZSfuXijB9
	 BV/6lHgclTJQ6cNbBD8uBOcp+bzY4QCnxvQGLOSntcb481/NKa4Mmh90zw7foaokgd
	 lcdeOr/Beo8y77zxhNKhnwGsZFt/hVOZuiomjBnxWnBuwU2XfxC/Fa/dmFFTahXmGH
	 M+0WvEQYfX8zlt+/XT298P3pulbY6es94YHCRqxUO+6qvYHVvn6pxJhfuBjhsnnVyS
	 +VlY+fauYYaORevg6fv6VjF0zBaKEzToTiiSNQW13FBfKFrUXaxOmgOHLEiY/tPmMY
	 /rAtd030CkTitXwLmqQ99EbVESF4JHRDlKbEaIkCy7msta5Kn9gwcoXrI7MFiX/tnz
	 r0BCazYpItueZWMsw/KdjrpNgjl/4MSWq+aLktLSvbOV8S1jKEFyWXVnAC68fH6vnA
	 fIdjt9v5ntQoWKUphjQ6qzOuSUgEtrX4d2iWt0NxiTZnzUmtMgFGdYnRf0x5NN1EjY
	 M+MBm8Sb2v4q5KVIonf7FVO4=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AA30140E0177;
	Wed, 31 Jan 2024 09:29:57 +0000 (UTC)
Date: Wed, 31 Jan 2024 10:29:52 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>,
	linux-arch@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v3 02/19] x86/boot: Move mem_encrypt= parsing to the
 decompressor
Message-ID: <20240131092952.GCZboTECip8DbWtYtz@fat_crate.local>
References: <20240129180502.4069817-21-ardb+git@google.com>
 <20240129180502.4069817-23-ardb+git@google.com>
 <20240131083511.GIZboGP8jPIrUZA8DF@fat_crate.local>
 <CAMj1kXG9W0XeEVR4tXDDg0Ai9XPsZGrTJaSRYUqgTV-xtFxjdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXG9W0XeEVR4tXDDg0Ai9XPsZGrTJaSRYUqgTV-xtFxjdQ@mail.gmail.com>

On Wed, Jan 31, 2024 at 10:12:13AM +0100, Ard Biesheuvel wrote:
> The reason we need two flags is because there is no default value to
> use when the command line param is absent.

I think absent means memory encryption disabled like with every other
option which is not present...

> There is CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT but that one is AMD

... yes, and I'm thinking that it is time we kill this. I don't think
anything uses it. It was meant well at the time.

Let's wait for Tom to wake up first, though, as he might have some
objections...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

