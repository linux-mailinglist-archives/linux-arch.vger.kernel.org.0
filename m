Return-Path: <linux-arch+bounces-11215-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC626A7877A
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 07:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ACB33AE97D
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 05:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5638D1C84AB;
	Wed,  2 Apr 2025 05:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYmFtQSm"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A3F2AF10;
	Wed,  2 Apr 2025 05:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743570157; cv=none; b=Z/PKsaGym/kTDNR52mk9wkua7u/X0qFZ5b8BYavKFwAwA715oMg7TuS+1i7pBFw9tSfak58g2OkVX99flc74jlFvgY/Z2DblXPkKTLtAQSUy12K71+hXqZARlBWrFO4wPplL6FSZocx8CSyib6xu13VIN3X4VcDC1MZp9RcKZc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743570157; c=relaxed/simple;
	bh=jHwdZ7kA79/d/YYMR3uBup0ETZ6ZDIwY8MOVLQ9Sn8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuI5Pcky4noX5QUr3+dVk+2pSxCtPWQ5u62xzg8nniN+JzMegSKuFiccrm6N/TYxeoPGJ9Ft/KAEpZ52gVhEszm26c/Y1zqmrqYmUJGrtEzr3GnuiuSVas4FMMNjNvlKMK8PDIRh1CfdCLAIYLMUpF/x1uighQRAHxMlUglAqSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYmFtQSm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C893C4CEDD;
	Wed,  2 Apr 2025 05:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743570156;
	bh=jHwdZ7kA79/d/YYMR3uBup0ETZ6ZDIwY8MOVLQ9Sn8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qYmFtQSm9PO2RMuCWFuMxVaDa2Lw82+9atrBIoug8tzCivbITp2W9WCwswjYXzrVX
	 ubuRZPTi6Bk2UdMoZaKsI4EVMnhVoyJrdEXiRJQjON4D6C08LEEZQ8zCDlEvboAriU
	 hmy+bgZuuf3vs7pjh2wl1sUT109pfTjrytl9RoXH1F56pTB7wQyLfrjXgEUf2+CKHB
	 NAzznAyLKaYnmgxoUIhWk6WkhFh89wcnk49XdfAmWnoLxIm6zCYaYaeyqtUD2rwG0B
	 iA6lmx/qYSNorIIChNlMA2ZB4MJEK+T0uE1soOMGQRhQQriq+SyMP+iyG7y03IcWci
	 MFb1WhUiQCWtg==
Date: Tue, 1 Apr 2025 22:02:34 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	linux-crypto@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/7] lib/crc: remove unnecessary prompt for CONFIG_CRC32
 and drop 'default y'
Message-ID: <20250402050234.GB317606@sol.localdomain>
References: <20250401221600.24878-1-ebiggers@kernel.org>
 <20250401221600.24878-2-ebiggers@kernel.org>
 <2c1cbb51-cc16-4292-ad30-482d93935d91@infradead.org>
 <20250402035107.GA317606@sol.localdomain>
 <81aac5ff-8698-4059-92a2-bccb998eb000@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81aac5ff-8698-4059-92a2-bccb998eb000@infradead.org>

On Tue, Apr 01, 2025 at 09:50:57PM -0700, Randy Dunlap wrote:
> 
> 
> On 4/1/25 8:51 PM, Eric Biggers wrote:
> > On Tue, Apr 01, 2025 at 08:42:41PM -0700, Randy Dunlap wrote:
> >> Hi 
> >>
> >> On 4/1/25 3:15 PM, Eric Biggers wrote:
> >>> From: Eric Biggers <ebiggers@google.com>
> >>>
> >>> All modules that need CONFIG_CRC32 already select it, so there is no
> >>> need to bother users about the option, nor to default it to y.
> >>>
> >>
> >> My memory from 10-20 years ago could be foggy, but ISTR that someone made at least
> >> CRC16 and CRC32 user-selectable in order to support out-of-tree modules...
> >> FWIW.
> >> But they would not need to be default y.
> > 
> > That's not supported by upstream, though.
> 
> Which part is not supported by upstream?

Having prompts for library kconfig options solely because out-of-tree modules
might need them.

- Eric

