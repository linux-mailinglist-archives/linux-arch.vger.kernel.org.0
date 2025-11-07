Return-Path: <linux-arch+bounces-14565-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 959DEC40E68
	for <lists+linux-arch@lfdr.de>; Fri, 07 Nov 2025 17:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C54B23A7F7F
	for <lists+linux-arch@lfdr.de>; Fri,  7 Nov 2025 16:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C7C32ABF1;
	Fri,  7 Nov 2025 16:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HY1jJp4k"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5FB27F736
	for <linux-arch@vger.kernel.org>; Fri,  7 Nov 2025 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762533275; cv=none; b=H/ByNPb4QNLKj9NHwCdovbqEtgkwGBMJb1VfwGsfKhQ/PeKYA6DaFoIraYs/3zDYWzZn64vTuGQaGA9PEuQd/EN75ygFRoi1wtkRtElwu5F0vrXEhMvwGZCpCsCMhii1+1sgMiD6ckz3MzWNHQxhF2fUT1S6L4y9LExM3fMGMkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762533275; c=relaxed/simple;
	bh=d/47TYkjEMLXtX4t4ZX9yfnVLo6hbFvwaZrWlGu6Vyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAxgmY8Ll9R40UPDlf9JjbwAs4maK1Gg9Pm7O1OMhIGabEsUtRSpIJ3uJsrmNhBEzwsYO0Ah6ht+my93N12HJgmSXPiR7MqCrqxbDF8p08ssiW9k36CuIOHPkR8dT86+DzJNFaDtdIQDtTXlHIVvpez+sXzYA4impQkqeNpIq8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HY1jJp4k; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso767094b3a.3
        for <linux-arch@vger.kernel.org>; Fri, 07 Nov 2025 08:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762533273; x=1763138073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JqLak/jfCX9SGb1FCs6K/y+jVBV6jjnaDsVxIe2L6n0=;
        b=HY1jJp4kkxlMl1XLdjiAPs56oxM/0hyu1F2tgy0NAPk3GUHQ4EaCQw+XIcC7toM/sb
         /pzX2ta5j2weLAcJ9O/ylmdYJ8gYpOWMXAuyphynkxfxGid9kFvSFT0NlFVQkJm6TghH
         TbeY7H3PhNo6jwUHeqNIf2QBFsMjpJBjMl0S2u+jMk0oAkO0jdl9xSefoQekgG4Bn9tp
         b3+LqL9H46Lds/TCPspbgc/JjOB9L6WhgcjEJRniSBgLJPq4LDk+iFzCsyhet86fouXr
         Osqdi6pXx5Y+DN/sSJOG3/7FYyzMbo/ymWzpDcqGcsq2C7bx1PjKnuQx8/LzhxPaAdF7
         i5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762533273; x=1763138073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqLak/jfCX9SGb1FCs6K/y+jVBV6jjnaDsVxIe2L6n0=;
        b=wsc9nvFfXKR0pVJFW1IfBM6TuqrAMsyINcwW5tPdDAuplEYdqyv7tH68r46+4JZuNv
         MlHDl0oBeut8H6AqD+yut50ZggHqJLVvGjfuZk0qWgaSVjDMYj/rBlLiVN1hdg7sk6Cl
         FlMDtdF6i7I+aHvEhvAxMXprU+u7mzUew21RWl3d2q1bD6rLahG/BzJwnNXX3dVWe+UI
         yHJnuSCy/kkaPdrlNxGqqGgMJAe0xGy+L0S2NHT5u+/1F6V4Riz1nQFtwNZYbyUzKPId
         XOfLq7xfTKURSahNn+qxjRdYjUgTBKSJIgHz9g9sWlNHaURfjqjUxaKXrvbP5sdPPTWv
         wx7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXlu0WKxtsN4+klPgh+vDXqP6U/nY6hqazywtSDXYjBNb8UeqDqAKso2aennObhqcXsFdQNp3ITVKMV@vger.kernel.org
X-Gm-Message-State: AOJu0YxrUrTSqwY7wuVSNA6B5AVyTwdn9UlBtFQ6mwtEJ/KfJGKv84L4
	kNqX9Sp4czBtdgs68g8QS50P1Rk4vA5maPjdMvx2nj1Rsk6BxzcApAWAanQYBmBY
X-Gm-Gg: ASbGnct099fnQxlxxOEPZRcUQGXPUqQoQLBBR0yVH7v7tAYe54fGsUi0l2bQ8U4niu5
	iH+Y4xt1tupNy8MAvejptM3eMIujlWbRSr08NWKrmz86eqJ2XIpqnwusqjjzUtEzauShrSbHSMb
	gRpPJgeRvp+N5kXvc9kaq612rn945eRcGmzH2AgkwiAw2SA5jnpos8I02rJhfdhiBu2vT+0YW9+
	Zjh/1xtx3BMxFCRB/2vmc0n+zys3yvzs5uMFUKAuQWOyVxfuds3Ev1E9mAQ3o1HDTtkjn33Z5M/
	AUfTlJpymhihHrQ/inDKDt1khqFaNOk/UfxblOcvtiep8GxO705GA7FhJ5td0O1KRdO4CNOMS3O
	Jm5r5OW6sXeyxfr24J6i9iElXJugpa3BJYmOI5bthdqIF58ufy5zc7SO8rCK++Pvluc1aFETpZ+
	1Xk1teWrwwqGJ6uEW/xOem3M9JA2KARaQdAJGsumz5m1g=
X-Google-Smtp-Source: AGHT+IFnwQ/WImm/C+/qPggS8zhJNo1gfsDpe/BSoNdEd3IY9EjFMukzBP1w3IzjMAKSy446Tz7DtQ==
X-Received: by 2002:a05:6a00:94c4:b0:7ab:2fd6:5d42 with SMTP id d2e1a72fcca58-7b0bd5ad1abmr4812086b3a.16.1762533273200;
        Fri, 07 Nov 2025 08:34:33 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0ccb5a517sm3354317b3a.57.2025.11.07.08.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 08:34:32 -0800 (PST)
Date: Fri, 7 Nov 2025 08:34:29 -0800
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lance Yang <ioworker0@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Huacai Chen <chenhuacai@kernel.org>, Jan Kara <jack@suse.cz>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, david@kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH Resend] mm: Refine __{pgd,p4d,pud,pmd,pte}_alloc_one_*()
 about HIGHMEM
Message-ID: <aQ4flRonlCygowKA@fedora>
References: <20251107095922.3106390-1-chenhuacai@loongson.cn>
 <20251107114455.59111-1-ioworker0@gmail.com>
 <f0efca40-aa3b-41ba-a8e4-c9595c19778e@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0efca40-aa3b-41ba-a8e4-c9595c19778e@app.fastmail.com>

On Fri, Nov 07, 2025 at 01:50:06PM +0100, Arnd Bergmann wrote:
> On Fri, Nov 7, 2025, at 12:44, Lance Yang wrote:
> > From: Lance Yang <lance.yang@linux.dev>
> > On Fri,  7 Nov 2025 17:59:22 +0800, Huacai Chen wrote:
> >> 
> >>   */
> >>  static inline pte_t *__pte_alloc_one_kernel_noprof(struct mm_struct *mm)
> >>  {
> >> -	struct ptdesc *ptdesc = pagetable_alloc_noprof(GFP_PGTABLE_KERNEL &
> >> -			~__GFP_HIGHMEM, 0);
> >> +	struct ptdesc *ptdesc = pagetable_alloc_noprof(GFP_PGTABLE_KERNEL, 0);
> >
> > I looked into the history and it seems you are right. This defensive pattern
> > was likely introduced by Vishal Moola in commit c787ae5[1].
> 
> Right, so not even so long ago, so we need to make sure we agree
> on a direction and don't send opposite patches in the name of
> cleanups.

I took a look, this patch is the direction we want to go :).

> > After this cleanup, would it make sense to add a BUILD_BUG_ON() somewhere
> > to check that __GFP_HIGHMEM is not present in GFP_PGTABLE_KERNEL and
> > GFP_PGTABLE_USER? This would prevent any future regression ;)
> >
> > Just a thought ...

In this case, I don't think the extra check is necessary. This is a
remnant of defensively converting callers to the ptdesc api from
get_free_pages() variants (which masks off GFP_HIGHMEM internally).
I doubt we'll ever be changing those macros to support highmem.

> I think we can go either way here, but I'd tend towards not
> adding more checks but instead removing any mention of __GFP_HIGHMEM
> that we can show is either pointless or can be avoided, with
> the goal of having only a small number of actual highmem
> allocations remaining in places we do care about (normal
> page cache, zram, possibly huge pages).

+1

I'm not familiar with which architectures use highmem or not, so
theres likely more cases like this patch that are remnants of the
ptdesc conversion.

git grep "pagetable_alloc.*GFP_HIGHMEM" shows at least 5 references
inline that can definitely be removed. I'll go ahead and clean those up,
but I'll leave the rest to people more familiar with the architectures.

