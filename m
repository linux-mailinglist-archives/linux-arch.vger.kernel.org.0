Return-Path: <linux-arch+bounces-11609-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCADA9DE36
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 03:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A96E25A56FA
	for <lists+linux-arch@lfdr.de>; Sun, 27 Apr 2025 01:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0537D22068A;
	Sun, 27 Apr 2025 01:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="ZBrOvF8Q"
X-Original-To: linux-arch@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E52442A83;
	Sun, 27 Apr 2025 01:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745716019; cv=none; b=mbgUd5koTJwWY+4CCw5I6meoJlzBZGcfB+E1bVn0sb7vLkFisMN4xCyYCph3u9pnrzlmT+PxtFTfLSehRFS+5mGDkrB73Um5vzT9OuYTwijoe5HeDmmkLKbTphQjLv/jiHuYGcYYoEd66ogQKEHeZI7swi0ZTXjEwSuvTvKih3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745716019; c=relaxed/simple;
	bh=NEjCPwylKFu5h1oJCIOdgWyzeTdHMf2449XU97bfmA4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sLWdmNcM1367378YZT5DxydMCQiRISVQdGRfCoRfJnAcoF5My6YJd8UMDeUM+RMxe1tldBacYPBrnBYUFurJN2NqNQNhE72bBuV+h7zr725x6AzL+pdBLIUatY+gbScD9TtITaaaOkLl14xR+b41nK9PecBpFljaJh+08OmGso4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=ZBrOvF8Q; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jYBIW8eL1CHTTgYqVhOJdPq6bgjz5FSbg7i5wPZVhNg=; b=ZBrOvF8Qo8J4cuQs3xdMmfCOmr
	a75wN5BWC+Ggi02u2OkOXrfsQ9WcEbBmShuNkPBIwY5k8gKcO64kwqMOWu5SPYtCvTaxpGgh1merV
	okY/E4Dc3UjeuouK5DAuujPEUKJfgmyff4qyX0PDfV+qHY82qO5T9bV8EaMigXon62TNK2EShmvTo
	ycU37GIkPwCW2lxYAvbAPFbfWsCtQGn/1V5XhZLm7Uc2ZJ/D0WP+sndPm7ZWFW45zCDDyvSMrD663
	EmNxoqe0ba9PaADtu/SUu+jI7XAmTYVSPafPQOTMCQhhe/7wTYd2mJVuiomGfs3Ucf7Lp5k0I/HvN
	DyF1yCTQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u8qTr-001JP9-0H;
	Sun, 27 Apr 2025 09:06:52 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 27 Apr 2025 09:06:51 +0800
Date: Sun, 27 Apr 2025 09:06:51 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
	linux-s390@vger.kernel.org, x86@kernel.org, ardb@kernel.org,
	Jason@zx2c4.com, torvalds@linux-foundation.org
Subject: Re: [PATCH 01/13] crypto: sha256 - support arch-optimized lib and
 expose through shash
Message-ID: <aA2DKzOh8xhCYY8C@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250426065041.1551914-2-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel

Eric Biggers <ebiggers@kernel.org> wrote:
>
> +static int crypto_sha256_update_arch(struct shash_desc *desc, const u8 *data,
> +                                    unsigned int len)
> +{
> +       sha256_update(shash_desc_ctx(desc), data, len);
> +       return 0;
> +}

Please use the block functions directly in the shash implementation.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

