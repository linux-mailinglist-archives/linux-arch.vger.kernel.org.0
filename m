Return-Path: <linux-arch+bounces-8330-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05919A5C9B
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 09:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C06B51C21794
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 07:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EEF1D14F0;
	Mon, 21 Oct 2024 07:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B1DB5bC5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135791D12F9
	for <linux-arch@vger.kernel.org>; Mon, 21 Oct 2024 07:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729495297; cv=none; b=T1Dsloc0E3zHxCFJKrgftH2sywzbT1mrYrM8lyXOwHtxEu57CkctDF50jde9hKbFxhp1F5K8TEqU3X077S6mrN6FahawA831FDDro9VSuT8CA+jFIrkXUg4SvLhy3b90tdRG9jr5nbjQKVsh9u6wnRXs4Th1x0RFlPX6iUlJBpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729495297; c=relaxed/simple;
	bh=u7mbkFbLccM2lr1dpHGOrtIFIX6zwELH/gCl+41CUSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jj/aFzz+NIL/2atkIKa/ydmU+1Z08f+phLrl1XUFqTcbWtiIP7zEn/EAoGBuXgWRp3Rv/MIE3odlbr/vS/ZXioEuvV6m1y6kmGj1+Th/92VCx7q6czLoEafJzC/Pc14niionrOqRbGzlG8jGun9j9grOYTE3zcVPEnC8+06KbdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B1DB5bC5; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7aa086b077so463255366b.0
        for <linux-arch@vger.kernel.org>; Mon, 21 Oct 2024 00:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729495293; x=1730100093; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sM4ACN0kxcjfg5UR2mRm8TYbMyjtVqVwofUPN7ArdNY=;
        b=B1DB5bC5U2viQQ3ofI3XE2foauUP3xDOk706VJU+4PpHE/G0cTqm0su7f9KC9xS4AY
         vuwYCwW5F9DZrdyblTloeJZl7s8g53rwI+i8T2XjIXPFBOtoBVjM5kxe0laU1aN7ljjz
         cD7PHfGfHMv7E8B8TNRr5YXEBPRX5x1fs9RzPXgSOXt380I1KAzJkqUmZRvlGwUDdQQg
         Jk0LbQMtdzeHPLU1p4b30CO+N3I+0AbtQ28H38CySVeqzmi+T7Ftz79vHapasHpbABJs
         yldrCvts8sK676By1QzThRqx0U0/J6YbxIF0AZYfWKw67hTBZwHndCkCC+7OKmnUfA32
         mSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729495293; x=1730100093;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sM4ACN0kxcjfg5UR2mRm8TYbMyjtVqVwofUPN7ArdNY=;
        b=CQr6ZGij5VnR0ZReT8XhHHWeS7QSNBOvlbCbWSdKTzVp9e3xVQGYQQOV9Yq1u/WUMX
         aUCjzMRpv9NxlHEMrowmA3M6V4mtPSK5tQ1XZtXlulHYFkuFhFl0cf75o/rSQch/LaGs
         oBRsRkONJrGsImYvx7s8wmfvA9PEUOZgeNmyt1buHwxApZDjwY13IK+3ZNd8JUrIYfwE
         5ZBm5o9l9po1suFS1N/RaXtLV6Pkxj0WIFqf7DJcRKjC2PSaGcloRug/Gi2okjJmIaCG
         7ooTWZz6YlupUEcZo7hnKCv/1poRFae7FMsmGs0T1/K2ZnYsJo7s0orurDpXDsiKP261
         Q6mw==
X-Forwarded-Encrypted: i=1; AJvYcCVGQRsG5UmFmZ8XhK7YyeTocowfkmbelWRyQ0TJwyADaMSQ6d6W2hLzHfTVSulvxp1GYSpegXLUhRaW@vger.kernel.org
X-Gm-Message-State: AOJu0YxeAFTuosNHq2b2xFdk/OySsGsKVMzcqCmwpQCB82BTs6+deFKo
	MDfif3OThu08ucMkDtCKdRXqo6p4COuQgmNi2rKukstxtNkmsCdiXlldvwPNaFw=
X-Google-Smtp-Source: AGHT+IH7c0NP6cQiTSwyl//5zHrNCLOmGdFL9dCgtDAoFWr5dtBuuJz0loN2CEAZ3ZOL1zVScXIQ/Q==
X-Received: by 2002:a17:906:c10b:b0:a9a:1792:f05 with SMTP id a640c23a62f3a-a9a69ba907cmr1161713466b.31.1729495293159;
        Mon, 21 Oct 2024 00:21:33 -0700 (PDT)
Received: from localhost (109-81-89-238.rct.o2.cz. [109.81.89.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91559dfcsm167515166b.132.2024.10.21.00.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 00:21:32 -0700 (PDT)
Date: Mon, 21 Oct 2024 09:21:32 +0200
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
Message-ID: <ZxYA_CHt8tVjowPQ@tiehlicka>
References: <CAJD7tkY0zzwX1BCbayKSXSxwKEGiEJzzKggP8dJccdajsr_bKw@mail.gmail.com>
 <cd848c5f-50cd-4834-a6dc-dff16c586e49@nvidia.com>
 <6a2a84f5-8474-432f-b97e-18552a9d993c@redhat.com>
 <CAJuCfpGkuaCh+PxKbzMbu-81oeEdzcfjFThoRk+-Cezf0oJWZg@mail.gmail.com>
 <9c81a8bb-18e5-4851-9925-769bf8535e46@redhat.com>
 <CAJuCfpH-YqwEi1aqUAF3rCZGByFpvKVSfDckATtCFm=J_4+QOw@mail.gmail.com>
 <ZxJcryjDUk_LzOuj@tiehlicka>
 <CAJuCfpGV3hwCRJj6D-SnSOc+VEe5=_045R1aGJEuYCL7WESsrg@mail.gmail.com>
 <ZxKWBfQ_Lps93fY1@tiehlicka>
 <CAJuCfpHa9qjugR+a3cs6Cud4PUcPWdvc+OgKTJ1qnryyJ9+WXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHa9qjugR+a3cs6Cud4PUcPWdvc+OgKTJ1qnryyJ9+WXA@mail.gmail.com>

On Fri 18-10-24 10:45:39, Suren Baghdasaryan wrote:
> On Fri, Oct 18, 2024 at 10:08 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Fri 18-10-24 09:04:24, Suren Baghdasaryan wrote:
> > > On Fri, Oct 18, 2024 at 6:03 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Tue 15-10-24 08:58:59, Suren Baghdasaryan wrote:
> > > > > On Tue, Oct 15, 2024 at 8:42 AM David Hildenbrand <david@redhat.com> wrote:
> > > > [...]
> > > > > > Right, I think what John is concerned about (and me as well) is that
> > > > > > once a new feature really needs a page flag, there will be objection
> > > > > > like "no you can't, we need them for allocation tags otherwise that
> > > > > > feature will be degraded".
> > > > >
> > > > > I do understand your concern but IMHO the possibility of degrading a
> > > > > feature should not be a reason to always operate at degraded capacity
> > > > > (which is what we have today). If one is really concerned about
> > > > > possible future regression they can set
> > > > > CONFIG_PGALLOC_TAG_USE_PAGEFLAGS=n and keep what we have today. That's
> > > > > why I'm strongly advocating that we do need
> > > > > CONFIG_PGALLOC_TAG_USE_PAGEFLAGS so that the user has control over how
> > > > > this scarce resource is used.
> > > >
> > > > I really do not think users will know how/why to setup this and I wouldn't
> > > > even bother them thinking about that at all TBH.
> > > >
> > > > This is an implementation detail. It is fine to reuse unused flags space
> > > > as a storage as a performance optimization but why do you want users to
> > > > bother with that? Why would they ever want to say N here?
> > >
> > > In this patch you can find a couple of warnings that look like this:
> > >
> > > pr_warn("With module %s there are too many tags to fit in %d page flag
> > > bits. Memory profiling is disabled!\n", mod->name,
> > > NR_UNUSED_PAGEFLAG_BITS);
> > > emitted when we run out of page flag bits during a module loading,
> > >
> > > pr_err("%s: alignment %lu is incompatible with allocation tag
> > > indexing, disable CONFIG_PGALLOC_TAG_USE_PAGEFLAGS",  mod->name,
> > > align);
> > > emitted when the arch-specific section alignment is incompatible with
> > > alloc_tag indexing.
> >
> > You are asking users to workaround implementation issue by configuration
> > which sounds like a really bad idea. Why cannot you make the fallback
> > automatic?
> 
> Automatic fallback is possible during boot, when we decide whether to
> enable page extensions or not. So, if during boot we decide to disable
> page extensions and use page flags, we can't go back and re-enable
> page extensions after boot is complete. Since there is a possibility
> that we run out of page flags at runtime when we load a new module,
> this leaves this case when we can't reference the module tags and we
> can't fall back to page extensions, so we have to disable memory
> profiling.

Right, I do understand (I guess) the challenge. I am just arguing that
it makes really no sense to tell user to recompile the kernel with a
CONFIG_FOO to workaround this limitation. Please note that many users of
this feature will simply use a precompiled (e.g. distribution) kernels.
Once you force somebody to recompile with
CONFIG_PGALLOC_TAG_USE_PAGEFLAGS=n they are not going back to a more
memory optimal implementation.

Just my 2cents
-- 
Michal Hocko
SUSE Labs

