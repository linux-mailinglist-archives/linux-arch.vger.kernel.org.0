Return-Path: <linux-arch+bounces-8331-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 852689A5CE4
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 09:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157651F20DD3
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 07:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C331D1E81;
	Mon, 21 Oct 2024 07:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VWtj+PXW"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375041D1721
	for <linux-arch@vger.kernel.org>; Mon, 21 Oct 2024 07:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729495602; cv=none; b=qEqSPAlZmrPATjs8Mlj1b8LigyHyS8iFM/xzm1PV3s1jy2KwmCX8nrEYiG7LBkJPj9RE23kum/d92kvL/9P8gj2FlbP+BirL8hMvbbofeujwXvEdrYO+iSMQor+MYe8NIkzIYWWWI4SxH5toYZrwP4H46sqcweQZZnVimitaKvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729495602; c=relaxed/simple;
	bh=0xdTFnOsrdnUM7/fSp03gc6tKBSnSRZJsR7vT/vyDIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHU1V0qKNQZG4fE4bREgVuI6lEx4wrT81m3HkK6vy0SNSNFrT0vHNiSNHPbLw2HOV/wcW07KwVaDdbE+LTgL5xIiBeBwwTMmEnFs1gbznNdjq08zWXOKgdNrrkaLJNEg1OH1yygukQ0pegQUBv6Zqm1h+gvjsjLTv0LTbfRO0XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VWtj+PXW; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb498a92f6so45134021fa.1
        for <linux-arch@vger.kernel.org>; Mon, 21 Oct 2024 00:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729495597; x=1730100397; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1iW7zHRRBIrIicRdTUgHWKYd7YrTdzT9PhDQ/2eOzio=;
        b=VWtj+PXWM8/No/6j8nVngC9sLa/9GYl0W+WG9PC7YOC6v/MnENOW+kJ9b/30U9pUIC
         sFNxyf2/zzrF2NWPjRK6M8f858Orpi8edggj0gQst5Ua4OikD2wL61j7I/UhMmZ8kXbb
         X16zX+yLwlm2Z1YYUCIrAEiNP1MGtFyYbSuMRMoXFC/xNOSlQl6zgpBBjViPq0Rd3Ojs
         usEW5iDzj2iIx+mB0wKq1pRoo5Vp9GwU0FPV3wqT7aWyLH7M4i9PIIs0Jdw9T+h3UMYJ
         3zq9x5DXqc3xyGR16xg9OpoCi4iP3YXMnD3nF1Dz+zaFcC2731vbgb9vYdI+w7qEFdfi
         zujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729495597; x=1730100397;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1iW7zHRRBIrIicRdTUgHWKYd7YrTdzT9PhDQ/2eOzio=;
        b=MlD/J5MAMkJYzhWXE5hMs3Kqw7R4hxtzWeTP/5qmq3T6zxtOkVFcc0X1hk0L4QVS03
         4cOa89OKXJ/mff3ezo+X9IdcCexAHArYrediarJfcg6qRQeLEmEXulFPwNRWdnhjypM5
         nGzIp6PXxn6XExjB1iD0CAJwoG2LIG53GDeN1pEo5rCF+iVfdRymeZ4RwESXGkNZiJ3d
         7kwZPHlhcld2eefO+izMZTo3mGiFn24PlbTmxJJtgIWl0wM9i8VxZov6xNdX/3UKUMYt
         xRMo5GqOijkanPXo/BMCOMjpXkSldMKBp7jmjlTVRfI9f/G3eaG8y57pYlnEGVC1zMq7
         qfrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqIpIJ6N12KfQrwD7Aywm9BL/p2UnK9e44E3BxeKPpJp1ga7IXmsX3e+5x2ZJpe0iR02I+J3MhECE4@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgfs6qhiuoNoed61ucPhZluBQYyBnyKh/73iu+WPXGOT6zto2m
	djGqIhFpG423AB3rTu8+WDDBbVrC7TrzI1QrFB2HEqcmMA0c3/SSLiaismVhpcE=
X-Google-Smtp-Source: AGHT+IEaIIlMaaA/c4s+FmIRsV38tfJXNw8YcF/Nn1xqhJFI0pm7wR7caance5o0xCeMZwsESMW0uw==
X-Received: by 2002:a2e:d01:0:b0:2fb:5ac6:90f0 with SMTP id 38308e7fff4ca-2fb831e94b0mr37655971fa.34.1729495597083;
        Mon, 21 Oct 2024 00:26:37 -0700 (PDT)
Received: from localhost (109-81-89-238.rct.o2.cz. [109.81.89.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b163sm1697370a12.76.2024.10.21.00.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 00:26:36 -0700 (PDT)
Date: Mon, 21 Oct 2024 09:26:35 +0200
From: Michal Hocko <mhocko@suse.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: David Hildenbrand <david@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Yosry Ahmed <yosryahmed@google.com>, akpm@linux-foundation.org,
	kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de,
	mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org,
	thuth@redhat.com, tglx@linutronix.de, bp@alien8.de,
	xiongwei.song@windriver.com, ardb@kernel.org, vbabka@suse.cz,
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net,
	willy@infradead.org, liam.howlett@oracle.com,
	pasha.tatashin@soleen.com, souravpanda@google.com,
	keescook@chromium.org, dennis@kernel.org, yuzhao@google.com,
	vvvvvv@google.com, rostedt@goodmis.org, iamjoonsoo.kim@lge.com,
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 5/5] alloc_tag: config to store page allocation tag
 refs in page flags
Message-ID: <ZxYCK0jZVmKSksA4@tiehlicka>
References: <cd848c5f-50cd-4834-a6dc-dff16c586e49@nvidia.com>
 <6a2a84f5-8474-432f-b97e-18552a9d993c@redhat.com>
 <CAJuCfpGkuaCh+PxKbzMbu-81oeEdzcfjFThoRk+-Cezf0oJWZg@mail.gmail.com>
 <9c81a8bb-18e5-4851-9925-769bf8535e46@redhat.com>
 <CAJuCfpH-YqwEi1aqUAF3rCZGByFpvKVSfDckATtCFm=J_4+QOw@mail.gmail.com>
 <ZxJcryjDUk_LzOuj@tiehlicka>
 <CAJuCfpGV3hwCRJj6D-SnSOc+VEe5=_045R1aGJEuYCL7WESsrg@mail.gmail.com>
 <ZxKWBfQ_Lps93fY1@tiehlicka>
 <CAJuCfpHa9qjugR+a3cs6Cud4PUcPWdvc+OgKTJ1qnryyJ9+WXA@mail.gmail.com>
 <CAJuCfpHFmmZhSrWo0iWST9+DGbwJZYdZx7zjHSHJLs_QY-7UbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHFmmZhSrWo0iWST9+DGbwJZYdZx7zjHSHJLs_QY-7UbA@mail.gmail.com>

On Fri 18-10-24 14:57:26, Suren Baghdasaryan wrote:
> On Fri, Oct 18, 2024 at 10:45 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Fri, Oct 18, 2024 at 10:08 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Fri 18-10-24 09:04:24, Suren Baghdasaryan wrote:
> > > > On Fri, Oct 18, 2024 at 6:03 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Tue 15-10-24 08:58:59, Suren Baghdasaryan wrote:
> > > > > > On Tue, Oct 15, 2024 at 8:42 AM David Hildenbrand <david@redhat.com> wrote:
> > > > > [...]
> > > > > > > Right, I think what John is concerned about (and me as well) is that
> > > > > > > once a new feature really needs a page flag, there will be objection
> > > > > > > like "no you can't, we need them for allocation tags otherwise that
> > > > > > > feature will be degraded".
> > > > > >
> > > > > > I do understand your concern but IMHO the possibility of degrading a
> > > > > > feature should not be a reason to always operate at degraded capacity
> > > > > > (which is what we have today). If one is really concerned about
> > > > > > possible future regression they can set
> > > > > > CONFIG_PGALLOC_TAG_USE_PAGEFLAGS=n and keep what we have today. That's
> > > > > > why I'm strongly advocating that we do need
> > > > > > CONFIG_PGALLOC_TAG_USE_PAGEFLAGS so that the user has control over how
> > > > > > this scarce resource is used.
> > > > >
> > > > > I really do not think users will know how/why to setup this and I wouldn't
> > > > > even bother them thinking about that at all TBH.
> > > > >
> > > > > This is an implementation detail. It is fine to reuse unused flags space
> > > > > as a storage as a performance optimization but why do you want users to
> > > > > bother with that? Why would they ever want to say N here?
> > > >
> > > > In this patch you can find a couple of warnings that look like this:
> > > >
> > > > pr_warn("With module %s there are too many tags to fit in %d page flag
> > > > bits. Memory profiling is disabled!\n", mod->name,
> > > > NR_UNUSED_PAGEFLAG_BITS);
> > > > emitted when we run out of page flag bits during a module loading,
> > > >
> > > > pr_err("%s: alignment %lu is incompatible with allocation tag
> > > > indexing, disable CONFIG_PGALLOC_TAG_USE_PAGEFLAGS",  mod->name,
> > > > align);
> > > > emitted when the arch-specific section alignment is incompatible with
> > > > alloc_tag indexing.
> > >
> > > You are asking users to workaround implementation issue by configuration
> > > which sounds like a really bad idea. Why cannot you make the fallback
> > > automatic?
> >
> > Automatic fallback is possible during boot, when we decide whether to
> > enable page extensions or not. So, if during boot we decide to disable
> > page extensions and use page flags, we can't go back and re-enable
> > page extensions after boot is complete. Since there is a possibility
> > that we run out of page flags at runtime when we load a new module,
> > this leaves this case when we can't reference the module tags and we
> > can't fall back to page extensions, so we have to disable memory
> > profiling.
> > I could keep page extensions always on just in case this happens but
> > that's a lot of memory waste to handle a rare case...
> 
> After thinking more about this, I suggest a couple of changes that
> IMHO would make configuration simpler:
> 1. Change the CONFIG_PGALLOC_TAG_USE_PAGEFLAGS to an early boot
> parameter.

This makes much more sense!

> Today we have a "mem_profiling" parameter to enable/disable
> memory profiling. I suggest adding "mem_profiling_use_pgflags" to
> switch the current behavior of using page extensions to use page
> flags.

I do not want to bikeshed about this but to me it would make more sense
to have an extension paramater to mem_profiling and call it something
like compress or similar so that page flags are not really carved into
naming. The docuemntation then can explain that the copression cannot be
always guaranteed and it might fail so this is more of a optimistic and
potentially failing optimization that might need to be dropped in some
usege scenarios.

> We keep the current behavior of using page extensions as
> default (mem_profiling_use_pgflags=0) because it always works even
> though it has higher overhead.

Yes this seems to be a safe default.

> 2. No auto-fallback. If mem_profiling_use_pgflags=1 and we don't have
> enough page flags (at boot time or later when we load a module), we
> simply disable memory profiling with a warning.

No strong opinion on this.

-- 
Michal Hocko
SUSE Labs

