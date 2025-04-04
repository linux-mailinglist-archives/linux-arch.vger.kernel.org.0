Return-Path: <linux-arch+bounces-11276-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F2BA7B8F8
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 10:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B597189E287
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 08:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7901991DD;
	Fri,  4 Apr 2025 08:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l1BZnnXN"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F1A17B425;
	Fri,  4 Apr 2025 08:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743755765; cv=none; b=eFfvVTVygJhDAWrSRruThYjO7Ihr14vZF+aHjTePZE9D/8ugStpL4vaN5Awi12YStqU8wG8Hf+hDzrenoi4KlAdorHAtbJPOhla9fVUUaeyD8RWBRkkRCDZyDiix/tdvSsmFoixdaaeuY24ZZzIuh15a42JvDtk/fWxJqE+O5B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743755765; c=relaxed/simple;
	bh=cpAYU27T+6cUvzLWCJPLe/61xl0whQmDjfkQg8Fljjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1TBsO+wIUu04PF2GwqrYZRFIg+ZG2mGszFugfzRNXAWhYwyXjM/LVL+Mb8H1xKAiTRcZ4wwmQSoTm/o5PP3figLfFL+37kBYx05O1O3stKSH6DYmCAEewjSmL4HcGiKUk8kKb6WVSfso2se82x1UngulEyp/b9uXcbJhRjOr0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=l1BZnnXN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iyhrJRyNvZ9ef/6I8LSnRyHP6bfuwM1VgqmMV8KADj4=; b=l1BZnnXNlfsZWilk1ZSrlozH/k
	ois7x0XB03CpSjQBHQbmS50cYpJi6nRKTu5FpmbpVbjNl6/lqLSDH6yFpYF1v8i5zXnuoyTY1eugm
	9/6snfoO4H+dvxcdSpkcKiipbMCWJJE0JfyMkTJ7KuO5c5cs9QC4layZhQXYfC+2oLDGjgGk1U4Z/
	8pk8MXagRqPKip/nRdzizm6gycQvgGuztcRRRFILS7IYNbLE1vrK0xsTOq6C6N/6Ni0Pgx6ssLr28
	M8IuYGKqWWVTDsoTKwxRcM1cJKR6uzbspfrTU3GX7vzYrOhOnLWaQvFhiFeSvQymI8fftWgjuip7g
	oQdeFZwA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0cWy-0000000BAF4-0EUT;
	Fri, 04 Apr 2025 08:36:04 +0000
Date: Fri, 4 Apr 2025 01:36:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/7] lib/crc: remove unnecessary prompt for CONFIG_CRC32
 and drop 'default y'
Message-ID: <Z--Z9HtsGbpGin9K@infradead.org>
References: <20250401221600.24878-1-ebiggers@kernel.org>
 <20250401221600.24878-2-ebiggers@kernel.org>
 <2c1cbb51-cc16-4292-ad30-482d93935d91@infradead.org>
 <20250402035107.GA317606@sol.localdomain>
 <81aac5ff-8698-4059-92a2-bccb998eb000@infradead.org>
 <20250402050234.GB317606@sol.localdomain>
 <b5589b7d-d4a1-4b12-a845-afdbb26ed845@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5589b7d-d4a1-4b12-a845-afdbb26ed845@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Apr 01, 2025 at 10:56:32PM -0700, Randy Dunlap wrote:
> > Having prompts for library kconfig options solely because out-of-tree modules
> > might need them.
> 
> Well, I think that is was supported for many years. I don't see how it
> would become unsupported all of a sudden. IMHO.

Doing crap for out of tree modules was never in any way supported.
Occasional sloppy maintainers let it slip in but we always fix it ASAP
when noticed.


