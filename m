Return-Path: <linux-arch+bounces-2302-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8D6853B50
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 20:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C54A1F23F58
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 19:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0B960263;
	Tue, 13 Feb 2024 19:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AcOEiBsi"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAA960895
	for <linux-arch@vger.kernel.org>; Tue, 13 Feb 2024 19:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707853174; cv=none; b=uh3ag/c3ITn/mKA9Wl+eWaS0OGxaSElSVVd0IOMDxLaWfgWGI+8r5yNDlzZisGiSAJcJiiwIM+rOSLYkK2elqL5hLoYAyM9WITR51DMaUX68BQYetPrpO3OkEhdyYZTQdCnwaaiIevQ7I6fx9D5gDmWFXB9TTaZslxarmJ2cpa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707853174; c=relaxed/simple;
	bh=WugeM4ood6CkrQx4S8VYLxOYhsFp0MouGTEG4EYnhvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dltBABGNw2y9JkTM4J+kje8V0C1DnINAuGUt4f+AJN5sQuqu0opvuZDH8e5IVoFpJKuYbtkYv8bmnPOBdj1wRZFoPpfz8jefSLH0Ndyjm3BJ5I1V3Ca9I+g5gGrnUafBwMCuc8U8yJeQX2BTlh1D8fYp07qnK4xvUWFLDl+DwJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AcOEiBsi; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e0cd3bed29so1469457b3a.1
        for <linux-arch@vger.kernel.org>; Tue, 13 Feb 2024 11:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707853172; x=1708457972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ietkBkC2vKvuAqqNl42bgKpXgTuLqEZ+6d6zSno8GJQ=;
        b=AcOEiBsi26nUwX2RYbHdE8FZrY84ATUWIY03Jskk0jVgnFJ+zqr1qZ64KOrxItM1CI
         yrzKFYvMg8CwWi86Z7nMbUh2ExPtsBNMwWwyzQhm00k2XYaPrxwYgeSKXmK7G4uwlUSh
         AAs1a+vR3QPpLtD83neD4qDysLvTWnZ0p7rwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707853172; x=1708457972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ietkBkC2vKvuAqqNl42bgKpXgTuLqEZ+6d6zSno8GJQ=;
        b=N27ITv35ZiHO8W4eRzWh/lJ/Qow4XVZwavRKFY8L7NL1d4PImHEn8m9C0Gsi62VWog
         9ncXzdba7N6OsTsB3krzInHWOor+Q4PyZeUQ+yuYlnMlIthILSNbBKaZa6hZs3959CQA
         JhUv0sQBA4h6JSdunn8aukBMoHBVGPOn/DkkYKi3RKN2rVtMP5QAx5LuEXPVH2tNVCL9
         5sgPvDpuob5kebIBWwP7+ciwbq7weG8m1m3HS3T28L4+UQ20eh7LSB6KUM/1lF4AjJY9
         0SaIw2LeQRrxyjkYqx2SLOsAl7jKG6b+7fGKdoTckU2QzJCHm/cbRXKbAf+cgmm4kHG0
         wCTw==
X-Forwarded-Encrypted: i=1; AJvYcCU4Cp9bPZRgoUdGHWcEAihMY84HlrwBYqqWMhomXoP6pXkvubWTuGqHr8gYIFuID0Nb2HTF87DZpuV3MRQPFsbK8H5X98pqb8gL8Q==
X-Gm-Message-State: AOJu0Yy2a3rfYuBKJcsVXjkYBhSdxKmFbw5GVXo4dFTWVUwK0d/OyLVx
	550hfn3jsG3S3ltop08tq3y71vx++RSE2pXTVVNsdJOKAU0Yoe4vZm22lXhmBQ==
X-Google-Smtp-Source: AGHT+IGI5hhbR76SaMhvMS6rpO7UF0lyS4/ap6HuK71delvjMtqUQfVpDb93oQnS/myoTiGFaT2DpA==
X-Received: by 2002:a05:6a20:9597:b0:19c:9eea:e731 with SMTP id iu23-20020a056a20959700b0019c9eeae731mr714528pzb.40.1707853171791;
        Tue, 13 Feb 2024 11:39:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWyG9gxyXGlbRRdmOV6B4qvcgJ5aoPE54mlbk3MLiCBp0xMgkE4p2+fWrPvq110VLKaYQfADCqz80FoPr9CtX4DoLVfpMrmhnP3Ui0m7n4g4IeJ8jzvSaR3Hh+QGlzwGUiS05714tdUeaBEKScY9Ts6eDsR4exJSc+J2dCHQa4AgMk8JIcJYf9zx94cAyQzX7SkHpJRGsrUEzs6Oql36rCEMM8qQMU4aGGieauO+T4Jr4GuLnYa9Z82LDWaKIfDEmvwYsAN8WRhlNY7/SMWBesK08wvZNAWhnIV3N6prHisQ6PMqW1AlivXMKXJl0lxuMY/NTSC4XMYRydKOcCxEZC3SzLIzUhKUVetqbrlxCDuJ3XYRZEL++RrARyIPRimYwFGfFA=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p19-20020a056a0026d300b006e0e3ef5f23sm3769549pfw.101.2024.02.13.11.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 11:39:31 -0800 (PST)
Date: Tue, 13 Feb 2024 11:39:30 -0800
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
Message-ID: <202402131138.2CFC8CD5E@keescook>
References: <ecb049aa-bcac-45c7-bbb1-4612d094935a@p183>
 <202402050445.0331B94A73@keescook>
 <acd02481-ca2e-412a-8c6b-d9dff1345139@p183>
 <202402091625.4DF63CDD0B@keescook>
 <54774e70-1e94-44f5-b318-fdfd5115041d@p183>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54774e70-1e94-44f5-b318-fdfd5115041d@p183>

On Tue, Feb 13, 2024 at 09:51:01PM +0300, Alexey Dobriyan wrote:
> On Fri, Feb 09, 2024 at 04:41:36PM -0800, Kees Cook wrote:
> > On Fri, Feb 09, 2024 at 03:30:37PM +0300, Alexey Dobriyan wrote:
> > > On Mon, Feb 05, 2024 at 04:48:08AM -0800, Kees Cook wrote:
> > > > On Mon, Feb 05, 2024 at 12:51:43PM +0300, Alexey Dobriyan wrote:
> > > > > +#define ARCH_AT_PAGE_SHIFT_MASK					\
> > > > > +	do {							\
> > > > > +		u32 val = 1 << 12;				\
> > > > > +		if (boot_cpu_has(X86_FEATURE_PSE)) {		\
> > > > > +			val |= 1 << 21;				\
> > > > > +		}						\
> > > > > +		if (boot_cpu_has(X86_FEATURE_GBPAGES)) {	\
> > > > > +			val |= 1 << 30;				\
> > > > > +		}						\
> > > > 
> > > > Can we use something besides literal "12", "21", and "30" values here?
> > > 
> > > Ehh, no, why? Inside x86_64 the page shifts are very specific numbers,
> > > they won't change.
> > 
> > Well, it's nicer to have meaningful words to describe these things.
> 
> Not really. Inside specific arch page shifts are fixed, so using names
> is just more macros one need to remember.
> 
> If I were to invent names (which I wouldn't), the best names are
> 
> 	PAGE_SHIFT
> 	PAGE_SHIFT2
> 	PAGE_SHIFT3
> 	...
> 
> with PAGE_SHIFT2, PAGE_SHIFT3 being optional macros if arch doesn't support
> multiple page sizes.
> 
> > In fact, PAGE_SHIFT already exists for 12, and HPAGE_SHIFT already exists
> > for 21. Please use those, and add another, perhaps GBPAGE_SHIFT, for 30.
> 
> HPAGE_SHIFT is bad name, H doesn't describe anything unless arch is
> known. Hugepages is marketing name. If GBPAGE_SHIFT is good name,
> then HPAGE_SHIFT is bad name, it should've been MBPAGE_SHIFT, which
> wrong because it is 2 MiB not 1 MiB.
> 
> BTW parisc has REAL_HPAGE_SHIFT !

Sure, I mean, we've got an x86-specific function here, so let's use the
x86-specific macros we already have for 12 and 21, and then add the
missing one for 30.

-- 
Kees Cook

