Return-Path: <linux-arch+bounces-14566-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6947C40F31
	for <lists+linux-arch@lfdr.de>; Fri, 07 Nov 2025 17:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E2F04E27F6
	for <lists+linux-arch@lfdr.de>; Fri,  7 Nov 2025 16:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3C432E735;
	Fri,  7 Nov 2025 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvswN5Is"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DDC3321B2
	for <linux-arch@vger.kernel.org>; Fri,  7 Nov 2025 16:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762534303; cv=none; b=o7dL5MDlNNLgB/0Md6yY+tzxVbyKFGV/74sYyF/PSUCY2cvay8nNFuuophOXj+QdaPGwBCsejse+ucplkLWRLYcU8lAgcKsFGaO8AUHil9e2h7j4Zpcm42CUBrzMBA+/+/tjrNtYujn+vA/GtJEJmJwi4WtCFtDLoo7DxTRc3RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762534303; c=relaxed/simple;
	bh=lo5FBKesF/ayoU+bnF0ekqgneX2SwDiiKLW4YWbFZI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uljapYeF2sMNVQBpzQVSvxI0B2D0p5+IllH35iFza0NFmQcxpwE80M0U0ATFavvIUSwPQdsqJ5lzSepgvUsOriyl3sKdMvaFtZs9xYkUfjVWnFZIvB7UaNMoYzaEXLfRbSPLqc+lEAWdxjmPfptxnEvVjsLOO0Mn3v55nbq3kLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvswN5Is; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-340c680fe8cso876570a91.0
        for <linux-arch@vger.kernel.org>; Fri, 07 Nov 2025 08:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762534301; x=1763139101; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8AFkMVbver0dm/iOE6DY+637If9387AOkFxxxWHJIX0=;
        b=TvswN5IsvbuMUwgu+YAKyN3gYquX5sq713JphX6pFmiiBoRVoVhhd2DvAa2mTx+CY7
         GsWNH5hO8hgLgze/kOsXLGkxXFM9Z1tIV21T5C7Bh3xiUEUcGqUZcrD8c5exOzGSMHh6
         hnMvrYdi9cocUXNtepZq4YjdRfv3nTg9M+JQe7nWGMv9zkKogDgh03GDrFilBwF4cyha
         j0+jQaxBBXG3nrGCLHzvthe+5b1Efnr14y2m0htp2cnJNQOUogCs0EYN9Yop6UCR3Lvn
         2/czJa3CGBHxGyjfT9FC8AKbGj9LXAsfN5hSjhBIUgYvQT05Eex60gz5zHX6ZqvFidq0
         +a2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762534301; x=1763139101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8AFkMVbver0dm/iOE6DY+637If9387AOkFxxxWHJIX0=;
        b=MPFV7ey2D++7EGPgyYhcpmfnGE2XK13PKxC4ftDgqDO4zOfJBAYsULFyOPLilDBThU
         lCjaW82XFUMyHZe5umuGK09nZfZb7upubyvWLeTOw11kajyfWgyDebFCwVJqCPVmeF5z
         g1tG9aQlWe3Qk5eZTX65kTMy4r8aevYZU3TBNapgjpQWXdbYbqjtIP1jnf9JmSgcqX2I
         6Te46qkoOzhtGCDI5wp1en192OnieJNFSnSd1OZAwD3IXQhby+9DX/AGDukFg/ZC9K8u
         KgjTbHfPJ/kkNJhc21XsJ1xq3Z/WQNCo0GRmHBdx19pgvB1Wl6RFMB9D1CjBfA396pIq
         7VSw==
X-Forwarded-Encrypted: i=1; AJvYcCWO0CFIzupfw9+U/KtNzUvJm4ZUIa/IcaAw+36FZi4yKKMWku3FnYonE8KiykxahdZdbvds0K3i1E5v@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3QXsubwEEA/ZqmFO3md0ta3GMNalBPM2ostja53cOOCxtD4QN
	oslZKX2ATu/1Ljfb/o/oyFF4HsUCkoCPZ0jjN6v4vyt0cZnMC65K5298
X-Gm-Gg: ASbGnct1hQR5PZzpXvwOdhTloORiIqxJzULIdOT/sTtXGm/VOn+Jx4FPSSjnUV+9jFP
	Z+TigNnLkNC50TwGWFkivr6KKdnwAG/MWgdCI5m9tw4SUzORmfuZAcz6DScNbLCbpZd3+aM+nec
	bP4p8uN7yMPtr0jpoCMA4tJoICz8khKH2JVmuCpGxB/eszCOXT98XbuhePyHqe1MSRT8D8bZBk0
	UBj0QeG5tAGYGWPSrvTLdbq7EHXXN/2lH9yU3aQMuEzvU2jqNppsTaaej9skMpAp7kMpP2K5q+d
	goxmn2m3UrE/R2SddCD1E1cRRvHaen1XFeZC/040dcxMK8R2FQSYqS0vbev8DJXBWGhqYLYktty
	iHo0uMitolhjNnw4dAN0T9dJw1k581fc+/uiSMz/rXBEXJ2ri1n0Tty43pmnuru0xhbdxiysBRQ
	Fx9FBFGlf8YW45ucXfx63kIFHD/7koAwKoxKHFw7vu0+U=
X-Google-Smtp-Source: AGHT+IEjgH81f9xZXDJ+ZCNw7+vkxCMp9mabCfJ6FR/hm1eQNTQUyGS8b/UpSimHVrrkBrWZ05u0Hg==
X-Received: by 2002:a17:90b:51c4:b0:340:c261:f9f0 with SMTP id 98e67ed59e1d1-3434c4eb054mr4745463a91.15.1762534300892;
        Fri, 07 Nov 2025 08:51:40 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34362f1f231sm936024a91.10.2025.11.07.08.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 08:51:40 -0800 (PST)
Date: Fri, 7 Nov 2025 08:51:38 -0800
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kevin Brodsky <kevin.brodsky@arm.com>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, Linux-Arch <linux-arch@vger.kernel.org>,
	linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH Resend] mm: Refine __{pgd,p4d,pud,pmd,pte}_alloc_one_*()
 about HIGHMEM
Message-ID: <aQ4jmguL-dwKea-N@fedora>
References: <20251107095922.3106390-1-chenhuacai@loongson.cn>
 <0fbcde0d-4fed-4aa6-b0bf-c4400b9b1cf5@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fbcde0d-4fed-4aa6-b0bf-c4400b9b1cf5@app.fastmail.com>

+Cc: Mike

On Fri, Nov 07, 2025 at 12:21:38PM +0100, Arnd Bergmann wrote:
> On Fri, Nov 7, 2025, at 10:59, Huacai Chen wrote:
> > __{pgd,p4d,pud,pmd,pte}_alloc_one_*() always allocate pages with GFP
> > flag GFP_PGTABLE_KERNEL/GFP_PGTABLE_USER. These two macros are defined
> > as follows:
> >
> >  #define GFP_PGTABLE_KERNEL	(GFP_KERNEL | __GFP_ZERO)
> >  #define GFP_PGTABLE_USER	(GFP_PGTABLE_KERNEL | __GFP_ACCOUNT)
> >
> > There is no __GFP_HIGHMEM in them, so we needn't to clear __GFP_HIGHMEM
> > explicitly.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> > Resend because the lines begin with # was eaten by git.
> 
> Thanks for your patch, this is an area I've also started
> looking at, with the intention to reduce the references
> to __GFO_HIGHMEM to the minimum we need for supporting the
> remaining platforms that need to use highmem somewhere.

Yay! Thanks for doing that, I like less highmem :)

> I'm not sure what the reason is for your patch, I assume
> this is meant purely as a cleanup, correct? Are you looking
> at a wider set of related cleanups, or did you just notice
> this one instance?
> 
> Note that for the moment, the 32-bit arm __pte_alloc_one() function
> still passes __GFP_HIGHMEM when CONFIG_HIGHPTE is set, though
> I would like to remove that code path. Unless we remove
> that at the same time, this should probably be explained in your
> patch description.

Skimming the functions, __pte_alloc_one_kernel() doesn't get passed in
a gfp, while __pte_alloc_one() does. IOW I __pte_alloc_one_kernel()
cares about architecture gfp, while the latter does care - so they are
2 very different cases.

Might be helpful to explain, although I don't think it matters much.

I've cc-ed Mike, he might have more useful opinions these functions.

