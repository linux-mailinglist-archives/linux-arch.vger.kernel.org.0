Return-Path: <linux-arch+bounces-1887-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EC78437EB
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 08:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 521931F25ED2
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 07:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C1351004;
	Wed, 31 Jan 2024 07:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="f1siF1NH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2C450A7C;
	Wed, 31 Jan 2024 07:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706686348; cv=none; b=ingBTlWgyo/sb66AKYXTjhh5xqkNvMdvF/d7WqrOyZqkjEX+FcFdY96bbn4Nsbsc+tNo8PRrJ1O77ojuXhStIIr6TpPZDFHDK/F/iaQSKuJnG/PRi81FpZli2EP3HiWhHhEkRCEmzutYxKrVg9yigjKPH3Vc7GwA/trhSrpGVNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706686348; c=relaxed/simple;
	bh=pgyAw8iVHEbKDoIUzik08bQYOc4UhRc4AOUSm9mIbiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5ruAqrZbRVTNNCpugsJkNXPzTVGkKILOkeu2qtLujZUCmm2tM09Nd9uF5/nd/UpyGrnjJtC2N3hennHLeWi42FDQDm9g/tDnM0EjO/N0YO27UzVzML0ZFR4ryKh0bq3Gi+6Mmn6YXAqCbWwS3rAGuq3YjiQ4HA9wfEthfv3448=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=f1siF1NH; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 76C9E40E0177;
	Wed, 31 Jan 2024 07:32:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uu-ek8orGlLV; Wed, 31 Jan 2024 07:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706686341; bh=4Kjl9jkNKfQ+jTyuemj6gc3E9MJ5mD2Pes6z9Kzttk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f1siF1NHDuVwULjFf7dcR0YIrzh5ESly6O2pk1RpPg3mexdymmqb8WkleMy5AaCaT
	 +LEa3/Ti+zdJR3cC7wwZIi7P6SLMOcGxbP7MRa480cs4PvoW7JTgX7hcr7fi829Aaf
	 pqAdmdjfb2TN1FnRC42B6LhbES3mtXZxd+odQUxlHtj2gSf54Euri06mBpcVjKoni3
	 RoxSxQnDUmol1J0Qf8S8NTaU8PEBVGYOUV99PcezuZefCXEurUBqk+N00mVUofE0M8
	 QaAfb5XWyK4oVeFUrbE2u94H4NA6OEVaGk9aQCFJARNhth9gSvYrh5yj9yZ1VyYuI/
	 f5Wue99ErQqCF+oWV0ABrd4JYS2DeHoQZh/FpEdV/5dROw63OQwU84xDTqFqZnfpa7
	 y+AAeT9taj42oV3yscn4nN/tUUz6Ah/k4hW6Mp4I+s9JH0D0ZrHXNAsexOsC2jddZU
	 bWenXqv3+PHkdAucidcGxxXuNg0N08J0Llhem3yYg7cHFfls+reYf3kXexehYVNCqU
	 Vrupnzqig0BngwQOccnoorA2pYAz775lVG9ZxgJH5oNEpezw7knquviR6WK37ARAGH
	 kjJOJmvVvvRY+bWXL5w+rfpgCxl9yMJINny7camU96eoz3Ex61PVTWWj97uOs+I1Jc
	 4nSLQq1KG7NtPwXpA/yq977w=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1C05240E01FA;
	Wed, 31 Jan 2024 07:32:03 +0000 (UTC)
Date: Wed, 31 Jan 2024 08:31:56 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
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
Subject: Re: [PATCH v3 01/19] efi/libstub: Add generic support for parsing
 mem_encrypt=
Message-ID: <20240131073156.GHZbn3bILaWLEluzp-@fat_crate.local>
References: <20240129180502.4069817-21-ardb+git@google.com>
 <20240129180502.4069817-22-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240129180502.4069817-22-ardb+git@google.com>

On Mon, Jan 29, 2024 at 07:05:04PM +0100, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Parse the mem_encrypt= command line parameter from the EFI stub if
> CONFIG_ARCH_HAS_MEM_ENCRYPT=y, so that it can be passed to the early
> boot code by the arch code in the stub.

I guess all systems which do memory encryption are EFI systems anyway so
we should not worry about the old ones...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

