Return-Path: <linux-arch+bounces-8267-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E179A3F18
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2024 15:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF343282830
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2024 13:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB3918E351;
	Fri, 18 Oct 2024 13:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MLe0m+Yw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA05433B5
	for <linux-arch@vger.kernel.org>; Fri, 18 Oct 2024 13:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729256629; cv=none; b=st4p6096VXcLEoPh1zbPsDzvQLzTeE8llfLOkgMDnEwXcv2164N7oWaX79pzUydPUUTSso5+Sale1V6Rh+ZfEj3tcifP5p42O0xaS7BZEh09o45XWRn3GWXkxUjYn4eCyhWKTZHkLjujCnmdDNB5uURd4ZMq1JMbZqfSs8DlwnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729256629; c=relaxed/simple;
	bh=DOTTWquBNd8l+IUT7seOntP4YwH3dQlJJjlVuG2vkoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STTCz7uDZqSEQaUYaYmAwk+5HA002wLAEBObh053vNoAJC7t0CrfDN/igcqjPdJfweg8gAvKYOIlZOkoeWZuGVWCfx5daBGmpAVbOxmJ0aysztW7s8R4RVs0Lblhlvbiy/cW90KEZqDYau9f/ZfE7anNEOOTFQPlMDq3YC9CSKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MLe0m+Yw; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f2b95775so2662888e87.1
        for <linux-arch@vger.kernel.org>; Fri, 18 Oct 2024 06:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729256624; x=1729861424; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sODVftRiJEB/0R5ZKHQ3MqkxJS24ttUXB9G8dSmRS9Y=;
        b=MLe0m+YwOZw5T3i7E7vshUSIdYq8vzl5BWKB/pMavPMbzsJWkMBxEpkmwpbXT1lBLv
         VOCe7bKuVRTE5yHfs2YWM94kfljeKj8aIhGKYVjNZ29yVmuXEsIKDKuigpVZ3P2gqxPa
         wRn42l6M5hdxnJjHueVdKGalKaZv+X6qJ9qAcvJOPSyQ2Do/yeySv/4CPMG2yDjxMLZf
         E7rlIpzXxv0bPKzBdZMDUSH7gewESdQz06HVMX+LH7MrL9RPOyIjfeNFj/38l1vhg89q
         /usswJaZrsnk8GZaoqElSM+EynFrXnlLaPdhE+RdA436HsudnqKUGNvvFu5xEi0CNQFU
         SyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729256624; x=1729861424;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sODVftRiJEB/0R5ZKHQ3MqkxJS24ttUXB9G8dSmRS9Y=;
        b=hh4aGXnIrViEog9Ub9jcXV7R+C9gq+5nEdN9dNcrR0IBkSq99+z1cy2HlfLGU4+VG/
         WbiqDo358LLdQTtsvI08wnjByUXA2XBXzzqD6tXzZuf5D7rd7tJ/dR9glKyLH2WSu34o
         Sh8iIisq3BRJ5TRLcLRtq+rBUaiRHL0NOPmCVyPNGq6LioBDyax1C4FwnQNkQ0Blh0UP
         thhcDonB5miHDA+S4OzL8VtNPmjUY4oRNWPt7j3wpAkA/cpZi06joBSLFRvLSgGthpCJ
         a6sHn0bLBO/RZhsSEC9jE8pZyHkdRaGcKtK2K5KYdV1Il7G9UQrIDw9UKbX8N4ISWD4P
         KCsA==
X-Forwarded-Encrypted: i=1; AJvYcCU/mCtncR0H0trIoGsqFsY37ZsThweyh55gAM0EygBHl1KT22/n7DBH0KdXhExEgWFF0yfS6n9ONl2k@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpc3admhDLNY7WgJYjFJs7Q0j9rjhkQMoQOVlLiDA/+Ll7akx+
	fkNRY8zAx58q1LhlcPnqCK7SLuztfNCFAA4NE006RUF7uokTEDwa3FBoqkKLDMU=
X-Google-Smtp-Source: AGHT+IEkARo88tz9Es4BK+YT+IflxGdlBCDgKhTnNhRNnTwvn1zSXl9sNOjA8rduKHJn/2Ffh9OhwA==
X-Received: by 2002:a05:6512:3d24:b0:539:89a8:600f with SMTP id 2adb3069b0e04-53a15452b7dmr2496478e87.23.1729256624502;
        Fri, 18 Oct 2024 06:03:44 -0700 (PDT)
Received: from localhost (109-81-89-238.rct.o2.cz. [109.81.89.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68c27893sm93408266b.195.2024.10.18.06.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 06:03:43 -0700 (PDT)
Date: Fri, 18 Oct 2024 15:03:43 +0200
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
Message-ID: <ZxJcryjDUk_LzOuj@tiehlicka>
References: <20241014203646.1952505-1-surenb@google.com>
 <20241014203646.1952505-6-surenb@google.com>
 <CAJD7tkY0zzwX1BCbayKSXSxwKEGiEJzzKggP8dJccdajsr_bKw@mail.gmail.com>
 <cd848c5f-50cd-4834-a6dc-dff16c586e49@nvidia.com>
 <6a2a84f5-8474-432f-b97e-18552a9d993c@redhat.com>
 <CAJuCfpGkuaCh+PxKbzMbu-81oeEdzcfjFThoRk+-Cezf0oJWZg@mail.gmail.com>
 <9c81a8bb-18e5-4851-9925-769bf8535e46@redhat.com>
 <CAJuCfpH-YqwEi1aqUAF3rCZGByFpvKVSfDckATtCFm=J_4+QOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpH-YqwEi1aqUAF3rCZGByFpvKVSfDckATtCFm=J_4+QOw@mail.gmail.com>

On Tue 15-10-24 08:58:59, Suren Baghdasaryan wrote:
> On Tue, Oct 15, 2024 at 8:42 AM David Hildenbrand <david@redhat.com> wrote:
[...]
> > Right, I think what John is concerned about (and me as well) is that
> > once a new feature really needs a page flag, there will be objection
> > like "no you can't, we need them for allocation tags otherwise that
> > feature will be degraded".
> 
> I do understand your concern but IMHO the possibility of degrading a
> feature should not be a reason to always operate at degraded capacity
> (which is what we have today). If one is really concerned about
> possible future regression they can set
> CONFIG_PGALLOC_TAG_USE_PAGEFLAGS=n and keep what we have today. That's
> why I'm strongly advocating that we do need
> CONFIG_PGALLOC_TAG_USE_PAGEFLAGS so that the user has control over how
> this scarce resource is used.

I really do not think users will know how/why to setup this and I wouldn't
even bother them thinking about that at all TBH. 

This is an implementation detail. It is fine to reuse unused flags space
as a storage as a performance optimization but why do you want users to
bother with that? Why would they ever want to say N here?
-- 
Michal Hocko
SUSE Labs

