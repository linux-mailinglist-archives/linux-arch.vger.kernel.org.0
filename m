Return-Path: <linux-arch+bounces-2299-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D5A853A43
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 19:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D67512906BA
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 18:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F822F9CE;
	Tue, 13 Feb 2024 18:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzjSO5Pa"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DEF6087F;
	Tue, 13 Feb 2024 18:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707850267; cv=none; b=orwnITpiSeIY/n15Ujl4mQ4KjleXWMC882l7wxyuAFy6jkWYuqXcc7YROo/91x2JD4ZScsxfuq3NGHSIJ/qOrsKnnU/d/BzukuoZ4xSmhpGJAOd0ITo9AR1QK9CatRZnOz3trM5U2jVHN2voWohLiE2m7nr5GXjoOTpGDTyjysg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707850267; c=relaxed/simple;
	bh=jeWKaG7vs09dK29mGycWBK7NeH7Y5V4KDjtQm2EvQs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfdMdFBhZ1WVOebsRDfKR7tbJHoqdxWBb1SODoKGd/Vm0dhh4Zx/dFfrgmq3lSfuDLhUsrI+xLTje7J0PScs2v9gweH4pHUSQ7Sc/b5M1tGE0DoX5KLk++EEPrzYCeiVBX2vluuzkl+Zd5pd5KJ+OkW/iTsLFu4XhAyncqyPrIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzjSO5Pa; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33b189ae5e8so2059417f8f.2;
        Tue, 13 Feb 2024 10:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707850264; x=1708455064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VZSu/ICCwgH/MzK/59qpKGnX2HpFwqdrjeqh9wkkz7E=;
        b=UzjSO5Pay3+O0KvU6NAv44EN5wrL5MdNFK7RXFYQ0S8VYVqTLsHxP1IGIAD8P7Whps
         XXgevXtQ1AwPbTaEnChPf47l/pH6+sn6QgcA1YVgrn+/csuhQnJ+27jS2hSgL757sEIU
         p9yA56ehE2gZweVsezfyE2/uXHikrUMXCJx46CIP7E27kG97vFuHdZexLNf9BdkhkN6B
         OZz0LgWNC8tmSAB5w6r2wxxlikc519k5guYj/gZYrOR49PLBcMRFZb91oTPDzLaXCoQi
         dU8v0wbYd8At8Rx4SF8cUYlt+oUirNw4Y29WNI6VY/OOoGve27XsF2VzC06vO4VxNANd
         jQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707850264; x=1708455064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZSu/ICCwgH/MzK/59qpKGnX2HpFwqdrjeqh9wkkz7E=;
        b=HS/dyugD9OUZIzGSeftA2dnU8RX5I7APogWgGXQ4Ko5K78j8aViiBQcd47gPnEmi48
         ALNwAfyuavaKIPgF9qedyHkY005bUSTodK6Hjy+wwuWMbCqYp1HvjknCocKsFSPuXK27
         vgcBpz0F9zZdaj9RCHj1J/XUcW9XewIiwbSoj/YXKNnj6ocoDIiMVgLsqZPpFFtDj5LM
         iKQL+po8WmOL3FGlmlyOL2ouBXlr8MnIkGnFWh06fooGT6BSf39egF8Bs6jFg8mlCmVr
         63vLfGLgfEJJmvRHene/jEtjYi4fu06InlbGe739jQTz8oVvcKHoXo7/AJH0CNV1V1+M
         NWvg==
X-Forwarded-Encrypted: i=1; AJvYcCUeS7ftFbG3+S6TG6YRUryxs5WLFHeu1L5HuUTXKppCp8K/wMVzZM25skNcXfkjrAtzuX4yIDJ3P2apv4Fdmz3uxxPlvzqgTvFJ5u4xy0vNGeWawozsFs0Nf+mTVmfFmULkIaAK7y6uAYU1gAHtwNhLF8Dm8XwVlzSZnCJph0bq2TfXhA==
X-Gm-Message-State: AOJu0YwpN6Jn4pnSUVzi/FAsRl/20RWItXFc/5vUng48YOpaz9AiwUrp
	m76umfB11TCHOV6PRpJ1sgn9KaWkB9If2w5NIfcNzLWsazQ94Mg=
X-Google-Smtp-Source: AGHT+IG0G2DEzT2VVZoK3Ur9Db+zaKrR7asWSUiFE+IhNY+2eRdo3M5XI8ZHWzY4YMnBkLjtPRZSiQ==
X-Received: by 2002:a5d:5143:0:b0:33c:d5a7:4fc with SMTP id u3-20020a5d5143000000b0033cd5a704fcmr126938wrt.16.1707850263837;
        Tue, 13 Feb 2024 10:51:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVdWhlPicAlD80n1REmmnyM41Vxu9NbVAefRMubI/Mae9u8O2OkMFk6XQbd4ZfvDm6Va8tXFmGmYcPcwfefiYvg2PcwSGqStdmz55Is7vqjWps15xZhGuaBqlp/seoGUP3u47oqX4NIy1rbguTbKeH/VJd+PiEQIz2xpZcx4Er/BJ/f5647vYjL7OuDq2H1UXHelOuMORrC/08ImM5prPbDSW/Vl87TC6pkL+7CSw+0BePmnQYxRVJqbL+NXWtlkka1oCOQnV2M+eNAD0Dmpl4+FTjQt0mPHfYlUJzZxhqDqzHSBphi49Qg0di1VXrTgA/EnuuJoh4IvlgiSIM/OH2750HczDNW4VWRhbjE/D9FPZLRseGofHElYGO62mF+xzxLvXE=
Received: from p183 ([46.53.249.38])
        by smtp.gmail.com with ESMTPSA id dv5-20020a0560000d8500b0033b483d1abcsm10226994wrb.53.2024.02.13.10.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 10:51:03 -0800 (PST)
Date: Tue, 13 Feb 2024 21:51:01 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Florian Weimer <fweimer@redhat.com>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, Eric Biederman <ebiederm@xmission.com>,
	linux-mm@kvack.org
Subject: Re: [PATCH v4] ELF: AT_PAGE_SHIFT_MASK -- supply userspace with
 available page shifts
Message-ID: <54774e70-1e94-44f5-b318-fdfd5115041d@p183>
References: <ecb049aa-bcac-45c7-bbb1-4612d094935a@p183>
 <202402050445.0331B94A73@keescook>
 <acd02481-ca2e-412a-8c6b-d9dff1345139@p183>
 <202402091625.4DF63CDD0B@keescook>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202402091625.4DF63CDD0B@keescook>

On Fri, Feb 09, 2024 at 04:41:36PM -0800, Kees Cook wrote:
> On Fri, Feb 09, 2024 at 03:30:37PM +0300, Alexey Dobriyan wrote:
> > On Mon, Feb 05, 2024 at 04:48:08AM -0800, Kees Cook wrote:
> > > On Mon, Feb 05, 2024 at 12:51:43PM +0300, Alexey Dobriyan wrote:
> > > > +#define ARCH_AT_PAGE_SHIFT_MASK					\
> > > > +	do {							\
> > > > +		u32 val = 1 << 12;				\
> > > > +		if (boot_cpu_has(X86_FEATURE_PSE)) {		\
> > > > +			val |= 1 << 21;				\
> > > > +		}						\
> > > > +		if (boot_cpu_has(X86_FEATURE_GBPAGES)) {	\
> > > > +			val |= 1 << 30;				\
> > > > +		}						\
> > > 
> > > Can we use something besides literal "12", "21", and "30" values here?
> > 
> > Ehh, no, why? Inside x86_64 the page shifts are very specific numbers,
> > they won't change.
> 
> Well, it's nicer to have meaningful words to describe these things.

Not really. Inside specific arch page shifts are fixed, so using names
is just more macros one need to remember.

If I were to invent names (which I wouldn't), the best names are

	PAGE_SHIFT
	PAGE_SHIFT2
	PAGE_SHIFT3
	...

with PAGE_SHIFT2, PAGE_SHIFT3 being optional macros if arch doesn't support
multiple page sizes.

> In fact, PAGE_SHIFT already exists for 12, and HPAGE_SHIFT already exists
> for 21. Please use those, and add another, perhaps GBPAGE_SHIFT, for 30.

HPAGE_SHIFT is bad name, H doesn't describe anything unless arch is
known. Hugepages is marketing name. If GBPAGE_SHIFT is good name,
then HPAGE_SHIFT is bad name, it should've been MBPAGE_SHIFT, which
wrong because it is 2 MiB not 1 MiB.

BTW parisc has REAL_HPAGE_SHIFT !

