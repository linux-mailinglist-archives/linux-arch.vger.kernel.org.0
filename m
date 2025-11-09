Return-Path: <linux-arch+bounces-14592-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F93C439DE
	for <lists+linux-arch@lfdr.de>; Sun, 09 Nov 2025 08:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D9104E1624
	for <lists+linux-arch@lfdr.de>; Sun,  9 Nov 2025 07:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3002459D9;
	Sun,  9 Nov 2025 07:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6OYt0ud"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4259623F40C;
	Sun,  9 Nov 2025 07:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762674205; cv=none; b=cJC5XOfMFnliDf70/jD+OHW2ZJkYt9TSuWI6Wqj49MwA6Xd+K/dOwONH20DWTuxYJlOklcMEora3pI5ZBXgQttmHxjwvcZBoi2QH/cr0v2q6p1KxZxW+Gw1mSQ51Lg8Gz7SXb3djYEDpYQJNLGnZ5IJKCOq2ZxLPxp41N0qFYH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762674205; c=relaxed/simple;
	bh=MGV48XVq5NOkKwG2fIonqI+u6a72bE/vAAzrSsW3Z8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fo+PXSAnEWiu6f+OYRbe3fNl+SoJMvvdZNzYfzzwH0zktPq9C80X/DKeIn8jbfi1STL3Svg1xHn8gK7Rc1wOyfynXm0kZ26dCsfXMHS1hgAqvqwcSKpjw4uGgPb++JMcV0T5imnM671wZMxfAxjgaoIFQyDUCVHe8BdS63U4Krg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6OYt0ud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B228C16AAE;
	Sun,  9 Nov 2025 07:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762674204;
	bh=MGV48XVq5NOkKwG2fIonqI+u6a72bE/vAAzrSsW3Z8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r6OYt0udCgq1im/weT5DxRld96EIWzlmImgUXLdANb5RuA9UvSmQ2haq6oO9mJbua
	 QoPASXj052Zw81+MCFX1gLo3qeF6BOVBMG0GwgLp/YUCM0No14l4L4ML1ofvnJ4pX6
	 e/qqDWOoqT7Tty5HSYNlGWG13mLcrJYheIAP43FqcfdI6wCUycAiB7OMn2a6hYP+MT
	 PI1XWlmkMUnf3d0eJg8eBbu8uZ1hD+lXUxsHdX8KQJ0kpjp+/Av+JQG7BPN0XqiZN1
	 1CiJbkzN7kGdnZWTTktylpGisbu7zCJ//ZdcYWhIJYH+/kvVJwsrCbl8Gmr6gMAo1v
	 Ccg3TDczcIGgg==
Date: Sun, 9 Nov 2025 09:43:17 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kevin Brodsky <kevin.brodsky@arm.com>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, Linux-Arch <linux-arch@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH Resend] mm: Refine __{pgd,p4d,pud,pmd,pte}_alloc_one_*()
 about HIGHMEM
Message-ID: <aRBGFZW09oFxM4k5@kernel.org>
References: <20251107095922.3106390-1-chenhuacai@loongson.cn>
 <0fbcde0d-4fed-4aa6-b0bf-c4400b9b1cf5@app.fastmail.com>
 <aQ4jmguL-dwKea-N@fedora>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ4jmguL-dwKea-N@fedora>

On Fri, Nov 07, 2025 at 08:51:38AM -0800, Vishal Moola (Oracle) wrote:
> +Cc: Mike
> 
> On Fri, Nov 07, 2025 at 12:21:38PM +0100, Arnd Bergmann wrote:
> > On Fri, Nov 7, 2025, at 10:59, Huacai Chen wrote:
> > > __{pgd,p4d,pud,pmd,pte}_alloc_one_*() always allocate pages with GFP
> > > flag GFP_PGTABLE_KERNEL/GFP_PGTABLE_USER. These two macros are defined
> > > as follows:
> > >
> > >  #define GFP_PGTABLE_KERNEL	(GFP_KERNEL | __GFP_ZERO)
> > >  #define GFP_PGTABLE_USER	(GFP_PGTABLE_KERNEL | __GFP_ACCOUNT)
> > >
> > > There is no __GFP_HIGHMEM in them, so we needn't to clear __GFP_HIGHMEM
> > > explicitly.
> > >
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > ---
> > > Resend because the lines begin with # was eaten by git.
> > 
> > Thanks for your patch, this is an area I've also started
> > looking at, with the intention to reduce the references
> > to __GFO_HIGHMEM to the minimum we need for supporting the
> > remaining platforms that need to use highmem somewhere.
> 
> Yay! Thanks for doing that, I like less highmem :)
> 
> > I'm not sure what the reason is for your patch, I assume
> > this is meant purely as a cleanup, correct? Are you looking
> > at a wider set of related cleanups, or did you just notice
> > this one instance?
> > 
> > Note that for the moment, the 32-bit arm __pte_alloc_one() function
> > still passes __GFP_HIGHMEM when CONFIG_HIGHPTE is set, though
> > I would like to remove that code path. Unless we remove
> > that at the same time, this should probably be explained in your
> > patch description.
> 
> Skimming the functions, __pte_alloc_one_kernel() doesn't get passed in
> a gfp, while __pte_alloc_one() does. IOW I __pte_alloc_one_kernel()
> cares about architecture gfp, while the latter does care - so they are
> 2 very different cases.

__pte_alloc_one() has gfp parameter to accommodate CONFIG_HIGHPTE that x86
used to have until quite recently and arm still has.
 
> Might be helpful to explain, although I don't think it matters much.
> 
> I've cc-ed Mike, he might have more useful opinions these functions.
> 

-- 
Sincerely yours,
Mike.

