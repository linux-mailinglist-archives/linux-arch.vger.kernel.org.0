Return-Path: <linux-arch+bounces-4956-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 835F590C283
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jun 2024 05:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC8661F237EF
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jun 2024 03:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9801EA8D;
	Tue, 18 Jun 2024 03:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foLQDn1t"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8780933C9;
	Tue, 18 Jun 2024 03:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718681915; cv=none; b=c6754BPUbNi+mZCn1s95dXYxAapTkfUEbzvAz0IdETmAei5oG9cA3lrSi/YjkJRloTjiIOaIAZNNAwoEhyCWnOidYa2rPO2tZKoaOmwkFw0j4lARNy5Wv3CsvzRiBHYpfFiZOqSZNWovGMDSxLahUXgzpo2oTbhW4KKN4Qd2eRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718681915; c=relaxed/simple;
	bh=16vjqC5pylA9Ku8yvf01alSldo9ulnmEY5mtiiBdDd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbutWWr1gsFesuK7E8L/EqgoWdBdCxzIloUrg8vRjhWdVgGFLTLhM2A9sh+wObJRlkRg+jRn9eoTU3j0k3KmNbg5BztfZrS3xK1+QTdfdTYDbr9vaID+2ZiI30RiZgpXoCY0ZKSFZzzqHPc2+iXOk9u+SQWyF9ATVzYejbGvE/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foLQDn1t; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6b065d12e81so24411806d6.0;
        Mon, 17 Jun 2024 20:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718681912; x=1719286712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/L6383qc7XZyKDMmbl5YQqnW5/fQWf0HfmWMo0uUfgo=;
        b=foLQDn1tBFQSq7y+4TrXfP9jXkeK6qcG+MbubyDVnM/hu5UJ2rsRYSB9BL0LJIJtOq
         EonAqYTcCUR6eyo4JGsHxNKkHGhIAQatpibctO4rkLxRIozlFL7OR9D1aPqg/EMnXvM8
         yyh0tviUL0MRVELeuRm+e7hfVATwOvE2WzqI1Ci18KkqN01VzIiL1g9EyM57elCOpdji
         z+r3IPBKRdHbpRIRkHyQ2vBhToxbh/nC5qSxs1su0U+r8H9qSRvpEhO+3f9ha1dJonPi
         bsNk/HXWIquwbjluUKAewoBqEgzNI+4q2tUF1vZ8xlEst5zsbKM2jJnPQwOF49tJPdAq
         Oo4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718681912; x=1719286712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/L6383qc7XZyKDMmbl5YQqnW5/fQWf0HfmWMo0uUfgo=;
        b=qttZ2e49Op2LxfD+Le1Hcxx69CE9awIrhfjInGn7ukKC6oDe2JaHYFZ7+fyRS1wVxR
         bPTZfeAgh0sIKHenv1Ro3AiTGaP3zz8yHseRc4TCkmqqrK0crnF5jjhszc1SkrcSx6Go
         N81w4LfEL5tcFmBJLwH37iHbflWbUn0PO5r+txS3TLIIimaRvkOWJDKDLQ3Mctctfrse
         slyUmGEtlMMT2jBgY0Ni7XE0+h3YUidRErXaKJh4Bt/oNX9iEDTRQQYk+YGw4hYBPppZ
         qIviCqmllrPqyVMeUBvqtsi+2iU1Zsw92a549JbkUOotJAcQmD0Z5A0uIUbOKHX2JvBL
         TU8A==
X-Forwarded-Encrypted: i=1; AJvYcCV5/EaNzS2BDORkSd7p2yfYaPoRREB5hN2E1RRDZKL2/xwXuLtD2oNT4LHuR10tZaRhWxDjlnMYYpt5FrJJ71qw4nd01XhRY3FJhuHnZ98LZdSDjL+FZSolxf26p+1KmNiGXn041bK/Ng==
X-Gm-Message-State: AOJu0YyCznAorjRg1Jlrrx5jWrkkmxoiA+M/+aavITQq8zOtEEMLO9H7
	3fEJwjv4onhFj2N8Ke9NASbv0Z61e/aEABcoam0rjBVNbMAvideh
X-Google-Smtp-Source: AGHT+IGTZ9y/IKf7+x9v3f+JI23cgeQY8nwOvBPIvDoArDIc+Hjb65TlWmj1M3n8w47AXywCCqqEEQ==
X-Received: by 2002:a0c:ec86:0:b0:6b0:82cc:5e76 with SMTP id 6a1803df08f44-6b2afdb7cc5mr135967546d6.62.1718681912262;
        Mon, 17 Jun 2024 20:38:32 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5ee07d9sm61740026d6.110.2024.06.17.20.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 20:38:31 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 4BB531200068;
	Mon, 17 Jun 2024 23:38:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 17 Jun 2024 23:38:31 -0400
X-ME-Sender: <xms:NwFxZjXt6SgesqS7KDxugg8C4buk-t7N1AP_WeZN-KG4Lv2bVyj_-w>
    <xme:NwFxZrm5iYFony8lotoz3Taw8poQkYEkEaPsVsYs2zcfk0TlV9WZH1aUO40086nSg
    Agaex1rxQNVKTBGig>
X-ME-Received: <xmr:NwFxZvahbIB3Q5krQs7cYG033K22MfnQHEqv5PI-rC7H6ChCumZbZ2VCew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedviedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:NwFxZuVlby9fUFkwY8pR_tLGDN0UnwQssiqbmRn-rokG89VpM1_0CQ>
    <xmx:NwFxZtnkWQmtMbZAFOtL7fwOg-T963hv8uoTpIYP48ASyKXHeJEjVw>
    <xmx:NwFxZrcC1GUYpnkJGrhPq3KRtHBZSK2atYnOgUbaUEWo48qJZl3tCg>
    <xmx:NwFxZnEjB3sSx6Yau2p8vnttrF099newrfM2EkunXqs-nEi2bpT_4w>
    <xmx:NwFxZvlpvn6L7CvlZBbN1AYFG7DZdWQvv3yZy_QGgvA3jZ_6dOA7qOvn>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Jun 2024 23:38:30 -0400 (EDT)
Date: Mon, 17 Jun 2024 20:38:29 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: stern@rowland.harvard.edu, will@kernel.org, peterz@infradead.org,
	npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr, paulmck@kernel.org, akiyks@gmail.com,
	dlustig@nvidia.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	hernan.poncedeleon@huaweicloud.com,
	jonas.oberhauser@huaweicloud.com
Subject: Re: [PATCH v3] tools/memory-model: Document herd7 (abstract)
 representation
Message-ID: <ZnEBNXAKB1yzC-p5@Boquns-Mac-mini.home>
References: <20240617201759.1670994-1-parri.andrea@gmail.com>
 <ZnC-cqQOEU2fd9tO@boqun-archlinux>
 <ZnD+sRgr9C6r8+v0@andrea>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnD+sRgr9C6r8+v0@andrea>

On Tue, Jun 18, 2024 at 05:27:45AM +0200, Andrea Parri wrote:
> > Just to double check, there is also a ->po relation between R*[once] and
> > W*[once], right?
> 
> That's right.  rmw = rmw & po
> 
> I could add a note about that, but I would stick with the current patch
> /version (and your Reviewed-by:) unless other requests.
> 

Current version is fine to me, thanks!

Regards,
Boqun

>   Andrea

