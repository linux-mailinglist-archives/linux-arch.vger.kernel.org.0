Return-Path: <linux-arch+bounces-11277-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71647A7B8FE
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 10:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D79F17A01D
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 08:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8753419995D;
	Fri,  4 Apr 2025 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jgvIHHdD"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4007319994F;
	Fri,  4 Apr 2025 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743755840; cv=none; b=FnyvfnZQDQfToY77cyBFjoYMNY0GmPdKiqYfLoH1UXeOpEXiFodywKxlM7SIMtJ5FWeWrwNM+m1auMLF7KpHCkS/GawHNYKld4Ztd0EMDhpeTJCAAGnC72SG10km2mXopNvtDN6OKWlzUtp9ezgqmx0xLIqZF9BBRW/bg+ToArI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743755840; c=relaxed/simple;
	bh=AEVc7jJ5wVZJd8UQkwBkZ0fFoF4aMa5hBy4BVBYGX14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWF1ExgqB9O0rJEowTqZduIjMKlsORtEP2XZWzVbm4YqVdwzM7bP99I/E3hAhG6i69LtGY/0CKOgWbi81XIQ2ZkEn4SmMj68jWOQye8jxJP1IzS+X2fMGdZPn6y/q8WRCkF9f0MUaxkQZKJxCvFBjB6XDYpwTWXcCZNgJzIc+VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jgvIHHdD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KfS5Z2KntBZx7miP6TngOOEv0Pcp0oG2FKWreVv1b5M=; b=jgvIHHdDIqU7r164qyTzVnF+6H
	5YmEkEtqjWsNSyUIPYdOwplYMFJ2dkL8bFd35pRfWI2taP3wjVAC0cL4CabjPCTrrnNFxM009ZxVH
	r+a5lhFKiCVkoLprGl6rlKRYrd8ZIaVwaHWYXvhFDsZmlphqVKGqrknYCV86/rVyOZ9jSi3SfaL4S
	UAJr6VQVGc0qx+YXA1ailKJMSWZziXGyR4p2uTNU+9gyCgTObZh38OW6hKsCRa29e1I1/lh72+0t/
	U4sSK8USvP91+ojRD9i7QNLYAvcuEvuaO/BvWo4rm00Q/S1CUGt1mViK5Q1lygtzS8XN979jGeRH9
	Gk0k1/3g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0cY9-0000000BARO-3CpM;
	Fri, 04 Apr 2025 08:37:17 +0000
Date: Fri, 4 Apr 2025 01:37:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	linux-crypto@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 6/7] lib/crc: document all the CRC library kconfig options
Message-ID: <Z--aPZDWPiW05FNS@infradead.org>
References: <20250401221600.24878-1-ebiggers@kernel.org>
 <20250401221600.24878-7-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401221600.24878-7-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Apr 01, 2025 at 03:15:59PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Previous commits removed all the original CRC kconfig help text, since
> it was oriented towards people configuring the kernel, and the options
> are no longer user-selectable.  However, it's still useful for there to
> be help text for kernel developers.  Add this.

I usually document hidden options using comments instead of the help
text to clearly distinguish them for visible options.  Not sure if there
is a general preference either way, I just through I'd drop this here.


