Return-Path: <linux-arch+bounces-2170-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C58850142
	for <lists+linux-arch@lfdr.de>; Sat, 10 Feb 2024 01:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A11128DBA3
	for <lists+linux-arch@lfdr.de>; Sat, 10 Feb 2024 00:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864184417;
	Sat, 10 Feb 2024 00:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AwRQBu2b"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23C13FFE
	for <linux-arch@vger.kernel.org>; Sat, 10 Feb 2024 00:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707525700; cv=none; b=keg8p3oBOzJ+Qk09PuSAwrU4W2VZbwB/K9aio4680Ca1fQwZvr+D/1YI4FuNWlq+Xq6PZty44vSVKNq5A/+BO7je/+ueyvG0seaaCrrljpWk82PkTFRc5JXOZqVHegRjehrGU/efiEVqT1mFCmw4F+ilkukfg9hdRzewg7n3pEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707525700; c=relaxed/simple;
	bh=uaj+OYImc6pR0lmcssEWsxa5HoLz2yNaHuud4NFc32Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0Mi+Auut4KGJ1Tj6BYJg4n7n2PrqzXG8LFbQjowhrtWhJ7tUhBbKGdPspKXpsP+NHzs65xwVdh9LPT+ZaxxgnmFiM7tO/TzauxiPir1IHitOBBc+PbtMdWW3mbZYcKeeC4wRJy90ONP0zjEwj+L8SsG8pXyjbOI2JtDLLtE8ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AwRQBu2b; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-595aa5b1fe0so1009663eaf.2
        for <linux-arch@vger.kernel.org>; Fri, 09 Feb 2024 16:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707525698; x=1708130498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dmaz8p75u7mzpXhtpMk9515wZM+iZMpymbDpuB6M7Z4=;
        b=AwRQBu2b/SEdkRGb3LaDhy9zyZ8QRwItUrrc1MRRG+YGlJpNRTJTsAOtKl/AdFIYKM
         eoiQDD6JSYFw1eBDXHkC4lnrft5XxzP9M8ThTpu78OAKIs1TYbQXxj5NG/5K4pCBPpTk
         95tBFcTpyBBYuM2geeJzVBv+mOm5sxLq3Vo7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707525698; x=1708130498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmaz8p75u7mzpXhtpMk9515wZM+iZMpymbDpuB6M7Z4=;
        b=e5ZEk8ILjl9o9ckPPwli1mfW1g5P1twfs05jggE8E+VUD+q2rZxT0Lj35njCW7EIzn
         ql1ZK755shFoKAukH7iDZhaCIKgC+HXssiYONmNl6Jgvc/xUR+tnjPWziarApu67aS0g
         FGRy89vYa/NCUkF7n4QylCnTuL1KXDxZCIDWE6EmVSRfPRs0IGvOvF6OxUgeQ/LuuWvB
         y+Si28IrYi8BRiKWEycc+Z6iKBc5yuUt55tHDWN0wnZsJPuDJGhVFwbPoV5P2zHonGJv
         3hftjR5PXQ9Gm0WlgiTBrh/+4z0mqmrymU7lmPIdEg/XZ8kUTT8ag7imv8N/jk0YJ99P
         ubrg==
X-Forwarded-Encrypted: i=1; AJvYcCWP1A6hAxbXn1Ht08HXs+WizuKFXnyTt8WsAzFpfWpyjogmQxzT627y7tkBj0aAciukh68Un7gUlzx1c56mMc1JbRdh7Vcz97C3fA==
X-Gm-Message-State: AOJu0YzLwMH4vQtkEhplGhliM5TyBPP6i/Ly8g/4pTzm5U3vzzKfOXH3
	Xx+cCDAQiHpqKDnEvNcBY+05mxJwUm0xhBbb3ILVO+XkOw5rnxidOAnDskG5og==
X-Google-Smtp-Source: AGHT+IG50cX3SGHnouz2I5cJYHWcWTeXfMJQH2UtMUPyw9qByO/8KdBHnDefOiHuRW4TUWLAfnycOA==
X-Received: by 2002:a05:6358:724f:b0:178:a555:c312 with SMTP id i15-20020a056358724f00b00178a555c312mr1170320rwa.32.1707525698012;
        Fri, 09 Feb 2024 16:41:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV1gaS76qWGniXOEblPMj6bXYMyFR+efck6AVg6G3A8vKuWiPn+KoqjbTqNv9YfYlg2IZb+xuVWwlV5O8UyzUQV2NoAiKPGqmqD6zV25fXVPQDADkzbAxIYU9s7tHkeSlvVuzh7y+GoGdfoWlycnl1ITaJwPNnHtREkXShJ/2sRtBEMnuuVw/t46ogRWfJt8bHdkNc0cMaTOzXRpqAQvOwFSu+UZODy3aABjFGutVG8LyPP4aCzSTqL4WeqWBE3waMFtfjX2m8aZc99bhCxH8tkFx8J8x4SJELUVWzR7rBaJkxjCssHbBEqmKzsmbA0iFHo2Qp3Ojklc2xeWnvrSohQubEUS0cekPRummvncuOVAB1RCqPTKK5AzbS2mEIMJkUnpTo=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gx20-20020a17090b125400b00296e567aaf9sm2430047pjb.14.2024.02.09.16.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 16:41:37 -0800 (PST)
Date: Fri, 9 Feb 2024 16:41:36 -0800
From: Kees Cook <keescook@chromium.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
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
Message-ID: <202402091625.4DF63CDD0B@keescook>
References: <ecb049aa-bcac-45c7-bbb1-4612d094935a@p183>
 <202402050445.0331B94A73@keescook>
 <acd02481-ca2e-412a-8c6b-d9dff1345139@p183>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acd02481-ca2e-412a-8c6b-d9dff1345139@p183>

On Fri, Feb 09, 2024 at 03:30:37PM +0300, Alexey Dobriyan wrote:
> On Mon, Feb 05, 2024 at 04:48:08AM -0800, Kees Cook wrote:
> > On Mon, Feb 05, 2024 at 12:51:43PM +0300, Alexey Dobriyan wrote:
> > > +#define ARCH_AT_PAGE_SHIFT_MASK					\
> > > +	do {							\
> > > +		u32 val = 1 << 12;				\
> > > +		if (boot_cpu_has(X86_FEATURE_PSE)) {		\
> > > +			val |= 1 << 21;				\
> > > +		}						\
> > > +		if (boot_cpu_has(X86_FEATURE_GBPAGES)) {	\
> > > +			val |= 1 << 30;				\
> > > +		}						\
> > 
> > Can we use something besides literal "12", "21", and "30" values here?
> 
> Ehh, no, why? Inside x86_64 the page shifts are very specific numbers,
> they won't change.

Well, it's nicer to have meaningful words to describe these things. In
fact, PAGE_SHIFT already exists for 12, and HPAGE_SHIFT already exists
for 21. Please use those, and add another, perhaps GBPAGE_SHIFT, for 30.

-Kees

-- 
Kees Cook

