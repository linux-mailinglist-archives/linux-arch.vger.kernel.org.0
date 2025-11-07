Return-Path: <linux-arch+bounces-14567-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCB4C40F73
	for <lists+linux-arch@lfdr.de>; Fri, 07 Nov 2025 17:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 225B7423038
	for <lists+linux-arch@lfdr.de>; Fri,  7 Nov 2025 16:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1726733375F;
	Fri,  7 Nov 2025 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DT62PiDh"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A92333733
	for <linux-arch@vger.kernel.org>; Fri,  7 Nov 2025 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762534746; cv=none; b=W4+iGZcpk7/bUet4fd9EwETdjEH8+HaExwuOI5GuLW6CC2QJq3bMi1kNOMHW/L64OpK/lYGSLs4Ml6qs6XY4FEsmqlm5k13JSMu6fAkKIdtGtrBMemw8kHxMmwVliry7FM573MTnEpFe/g4cUv6VhWw01UYXUief0+BBCNcZ3EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762534746; c=relaxed/simple;
	bh=cJuEyJBd8vNxec7ils9DOazLPyWiTBMKYf6Z8sfY0UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHaEP6quWv4B37HvnfAJO9mH3Z/cfJpRjSPlZWWgrPbhhRWcMhGYX278GURj55o0alPNf4sjIeXb+ii9xHGnDWaDsLzGZ2Bz1F/psseU39BrlPoODEYrL26WKkEucq2DuhRKBb8sgdtnZRWKNHKA0TY6hVlMKYQpasaYVi1KVGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DT62PiDh; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33db8fde85cso866846a91.0
        for <linux-arch@vger.kernel.org>; Fri, 07 Nov 2025 08:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762534742; x=1763139542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t4sd5p9K6Q7d7iLpd9Xn8vyRDq9SyY6gsIqiEGANBmA=;
        b=DT62PiDhor/0JlwSqPbIOUpWd7T3WeVdwYryLsv+gd1/o/WaSI0y8EuuX3i8j4eiJy
         Qe7oans013JeczyduMoN8WVd3bZTPtgtaiBI0Kki6cAQpZ+1BLrkLvOuB4ltztpZ63oC
         rTbsJerAIVj/cayccEVgNwvGrGTMhNFcTTd5WTtoLHnC9e5hoz+A5UmTPDtInXmo6FAt
         cyqY+2AAQOuPsbOrpTWBdDrN8bp6/jl32MfVQpN+Cx4kHU0S5Rdcs6JJmRzLu/MPxzlU
         auBk9jolBJdvBTPMNU0dWI3ul/AKoRrD/uikzx0nL6FJaQ+Ya7clvbpFoCg5i3GQBCgi
         phGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762534742; x=1763139542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t4sd5p9K6Q7d7iLpd9Xn8vyRDq9SyY6gsIqiEGANBmA=;
        b=Frz7oE4eq3wg4puTKEWLtmrnn/pRXrPDxskmXxlQ7DFAJOuGB0I+Buj4tiwIxJTfb6
         iZHg18mLcJH7NkRLJZQS2WsFVBnts/WB8MggPZjlrGXR6yn/AgaFIGwjkiTMYPE2zzdk
         uAUIY8EK+ioQESdY5rBUcQi7uOsF5RJEeEtvx3IUUmdKyW/5IM96Yhbln+Cmx4CdSafq
         W4doAdvhaq++qLpk6OV3kdbDicxTpYa887ieFg3aepZaZ5/2wjb2GsiJWQD5r6T6Op3G
         m/6Dw9+Q3PoXW54v/mSa5TX7wSbC3yEjdHlekvhtT31/7RkEgKOa0MbnxXk4SrBwOtLD
         7VdA==
X-Forwarded-Encrypted: i=1; AJvYcCU4BmKWiHc8NMM/7EBv0dvUk+jz7uTF7FQHAfHzlGsAbJB/Gigo44DzsP8QsLwsJe8NMaA1oKXRIX7R@vger.kernel.org
X-Gm-Message-State: AOJu0Yw40F5wFIV+iwG9hsUgAowulz951TmFjsdjCkCh+Ou9062LySQ+
	4s36i8gBhOGbthACnpmfK8EOMM3eSyZy07sCPb5GYfA7K2+Mx9aheHuY
X-Gm-Gg: ASbGncv1V4as4RUePd7J8a37WdD9RVpWA2LCRty7hIbcPF6JXXA9E03HknWmnUbd15i
	E7RI4opSGDr9WBPhICrQNk94j3/kvlSYM2NpRN5+/Ruv4MbzTgjhE9s4VBMRwuPAohTOS7qLUtO
	pMDNDJTDRsirJSFQVsyN95p4tPrLCg3tvnUn13COJnmNC4BbXoPboSK3jzeUMhFwadAVcss8t8u
	NfM4p+dJtLUETgAcqChVm8hePbw0tuAbEo+kevmoCEQniXXbmfASPj6WFTy9q1kExVCzsckOXlA
	aJ3L3eJ58nVLXAqRhJz0Yxd3VwExvO29WupY3FY6ylIVW/xUsFJ/8+4hnCNnCwOxbgB9K7nd+5A
	8t9YwbQQKsRC3TMhm05Qon+aK5+HGWl6KGS4pIzqz90LHai2L1f+UXkiWE/ulfCmeGDZrBF8Jq0
	jfU6tr+FhEgiTU7S02YKiM4eCdFKbIY4t3
X-Google-Smtp-Source: AGHT+IHMVwIIf/5HSM26FvAI00bqSm2Te209tly41PcGS5bZmMWGwjGv3U8TNmpLDYqzMgZOpWO5tg==
X-Received: by 2002:a17:90b:2547:b0:340:ecad:414 with SMTP id 98e67ed59e1d1-3434c575537mr4058720a91.27.1762534742462;
        Fri, 07 Nov 2025 08:59:02 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a67e2f82sm10072766a91.0.2025.11.07.08.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 08:59:01 -0800 (PST)
Date: Fri, 7 Nov 2025 08:58:59 -0800
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Kevin Brodsky <kevin.brodsky@arm.com>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH Resend] mm: Refine __{pgd,p4d,pud,pmd,pte}_alloc_one_*()
 about HIGHMEM
Message-ID: <aQ4lU02gPNCO9eXB@fedora>
References: <20251107095922.3106390-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107095922.3106390-1-chenhuacai@loongson.cn>

On Fri, Nov 07, 2025 at 05:59:22PM +0800, Huacai Chen wrote:
> __{pgd,p4d,pud,pmd,pte}_alloc_one_*() always allocate pages with GFP
> flag GFP_PGTABLE_KERNEL/GFP_PGTABLE_USER. These two macros are defined
> as follows:
> 
>  #define GFP_PGTABLE_KERNEL	(GFP_KERNEL | __GFP_ZERO)
>  #define GFP_PGTABLE_USER	(GFP_PGTABLE_KERNEL | __GFP_ACCOUNT)
> 
> There is no __GFP_HIGHMEM in them, so we needn't to clear __GFP_HIGHMEM
> explicitly.
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---

I'm not really sure what "Refine ... about HIGHMEM" is supposed to mean.
Might it be clearer to title this something like "Remove unnecessary
highmem in ..."?

