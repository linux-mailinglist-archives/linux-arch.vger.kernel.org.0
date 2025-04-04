Return-Path: <linux-arch+bounces-11278-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D70A7B90C
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 10:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C85973B9FD7
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 08:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13951A072C;
	Fri,  4 Apr 2025 08:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b9ynigyL"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6053E1A0728;
	Fri,  4 Apr 2025 08:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743755870; cv=none; b=SiJPxry0g10TROy9shICM8h6IixPJqtrrrhk3zYSxLcHDZhwHJL0YRk6t0xs0mLe4OUxwyG6B08wLAbcvqceE1xXuzi4t6VC6sEty22HImOmwZJEfa5MOYdxl7KHNnW0kOeh5sNciTnHmW2BEzBXnrUdX3FwT0N27059Ke42QOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743755870; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxt7vszLNub4Xh1iHMOWNM7OoOLVD75iZSIKUi2xIxzdpzWgHLydiRxDGzfOP1F5ntrx4w3W3uwSUssgPZ8xvCArp+3V/n9WNqGwEvKeDGf5I8HTH5wCCcdtfmUtLOpgHIYPfrJZm8eiCNPrHtQD77nEcTwEP/zu8s9mKOZJtCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b9ynigyL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=b9ynigyLSYfpDLOe50Yfd+KG5R
	HwYyGLa+5zgVe9LgUhBFhhTiC/udOC0SdVLL1GVyFC0PJ8nj1z8A3YhBFBj8lDchr0/s5BVKAr9LB
	0UyzVK8XWMw2aLVJrbYeN9cTip4xfo8lKPdTKThKG+RZoDPWxMMb3CoSEs0h1Ni8Zys/cYrWUAJHn
	Asztnl9bb8PbqB8iKJEVVPbkbIdLYeAL6Ab7S2fPf2Zvf50J00Ugqx/wOPaaiz9dR/5/lZhl2Fc8/
	iWZgPfdbGMvSJ4L+tnpuNRfNPdZzmpGLlwIHTwjRK1bPYgwELAakXS0v7t5SR2CB/drJyCmccwS9P
	ICNanojA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0cYe-0000000BAVs-3Skp;
	Fri, 04 Apr 2025 08:37:48 +0000
Date: Fri, 4 Apr 2025 01:37:48 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	linux-crypto@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 0/7] More CRC kconfig option cleanups
Message-ID: <Z--aXGphZRKyyPa0@infradead.org>
References: <20250401221600.24878-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401221600.24878-1-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


