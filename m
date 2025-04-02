Return-Path: <linux-arch+bounces-11213-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4879A786EF
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 05:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F08B16E8F2
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 03:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39A4226CF0;
	Wed,  2 Apr 2025 03:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hn71NVSV"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A8315D1;
	Wed,  2 Apr 2025 03:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743565869; cv=none; b=AiM/J7+mGy1W4GBhiebhCKYJTurj2g5mPu3Qw02sVqfqIgryaJQ8De60tnsUMRvhjRiA5lRQoYy51lmvemxH19wAjxQmexWDBcjomDbHkw7xln0vY5sQqH2i71xWGJmu8ctf1GJXGOqsqDQ7GeV63oFQqrf2tVJ4LLN+9Q1wzkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743565869; c=relaxed/simple;
	bh=QUiuMuIQDzD0JO+0s6YlUtgXJWr0xnlvEdN09u2jWUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/gUJPEIXgcsh/Jyt7vi/5bz8uaSicoaCPptVNzls0zi7BBPtwcrPsu1bVEYobsaZ64yxIkzqahcBLF+tMDPKQ0dZ9QT+Z5iliDGSKS93sWUgB8M4wmDJG0g/7x2e0wmufFLk6iz9aXXqnbn7tAdbLDOFRfF8Wkop/9GAYwI6lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hn71NVSV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57ED7C4CEDD;
	Wed,  2 Apr 2025 03:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743565869;
	bh=QUiuMuIQDzD0JO+0s6YlUtgXJWr0xnlvEdN09u2jWUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hn71NVSVXjRtESLJmkKiuV2gEVYRuJfmD0oD5/OuRrZUso0U35Abpmo82b0RPMiNt
	 eaxQWWzVeMVr97zVZtTsXM4rP1VNWe4dxgYcItpdCFh/ZfGwVHgNgCLwqtjI/tW4MD
	 UTaDk0SEMWwH78l60mNxBIFhMV7TqW9oAKba0t2ljT+CZ2uyoflZvcFE//ugv7ShJI
	 CYqDBcf7HRdY71TNxxwGwoPJCd06nSxDv+4jwhl+l6wA/MQULr1PM+yjeOFV2VQrjl
	 jeGj7jwL61Muj8lchs98OflKPKtIQm7/OFZ5zRW52oNhy98mgNakxDCnmq2dNNrEnK
	 fLd769xOYch4Q==
Date: Tue, 1 Apr 2025 20:51:07 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	linux-crypto@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/7] lib/crc: remove unnecessary prompt for CONFIG_CRC32
 and drop 'default y'
Message-ID: <20250402035107.GA317606@sol.localdomain>
References: <20250401221600.24878-1-ebiggers@kernel.org>
 <20250401221600.24878-2-ebiggers@kernel.org>
 <2c1cbb51-cc16-4292-ad30-482d93935d91@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c1cbb51-cc16-4292-ad30-482d93935d91@infradead.org>

On Tue, Apr 01, 2025 at 08:42:41PM -0700, Randy Dunlap wrote:
> Hi 
> 
> On 4/1/25 3:15 PM, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > All modules that need CONFIG_CRC32 already select it, so there is no
> > need to bother users about the option, nor to default it to y.
> > 
> 
> My memory from 10-20 years ago could be foggy, but ISTR that someone made at least
> CRC16 and CRC32 user-selectable in order to support out-of-tree modules...
> FWIW.
> But they would not need to be default y.

That's not supported by upstream, though.

- Eric

