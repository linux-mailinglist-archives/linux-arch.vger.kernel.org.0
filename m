Return-Path: <linux-arch+bounces-7036-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE7D96C92A
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 23:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808101F26C75
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 21:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7261016EC19;
	Wed,  4 Sep 2024 21:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UfdzCB5s"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB021154BFF
	for <linux-arch@vger.kernel.org>; Wed,  4 Sep 2024 21:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725484069; cv=none; b=N2gNR12Rr5Hd0rz1CJlByMA+elzxSMF5HEGyGCv6k4HBtzVcRn8WtFqnV9epp0QF3ljvSabPggiHuh+9U3LbJn4wFYpHeorOrRUiWbS5Mv3rkgggsSWCZDjeNf1d9PYo3rNzgaVzxFH9WaP7ELZGKeUAWTjLTfJAYfJ5FIkt7xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725484069; c=relaxed/simple;
	bh=uqOzk7cpoKkEi2MG7rO8J+EGBTGB6GV6x/+HS5AP9MY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CwxkK3MygfFjEWWIS9KGdJFx2RUvIx5tY4XYGn9RYZQYdDpvZbVeNGcZKIAvUXo92LreXf5bCGN9yyZ38MA99f3cDeXSehoqxHLt2ra9GfTe8oPOXdRy9AWFfJxQpbQxxjdpYNzC2JomikYBIX/p+HPP40mTRtYhGUbwRiX040A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UfdzCB5s; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a045f08fd6so21425ab.0
        for <linux-arch@vger.kernel.org>; Wed, 04 Sep 2024 14:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725484067; x=1726088867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w42R7BNbzfV9m9Ak5XplqSqEhc1UT4kjpkgNMP3MoEY=;
        b=UfdzCB5sHb6PJvB65wMCgLjR9cZnYete4t2lk0uR6fZBMaOJtgwrlFFa3SbMr/WuOp
         2GkLviVRZyPS/EIssHzblOE3O4kgS0FbnopapRAjsRkR5AD4sAoepzD4lVEwr0Jl3jdh
         GEV28fmd2xrV5u8vcw1tRr9koP30wMBWgsCoG32FjiGbngdNvFo3nbC/EMzEwewNckmO
         y3re6TxfUehlRWcPUs8pjqUUJc8zVzr7+T9iyVLaQS1U4OEsPtLs8CpxpORAEWv7od8f
         VioXN5x16Nzd61oRaAH+KDSZyr3O4KQtN9DRrU7v0MFnD1KdOqau9AXpcDOSBkRMSD20
         tF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725484067; x=1726088867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w42R7BNbzfV9m9Ak5XplqSqEhc1UT4kjpkgNMP3MoEY=;
        b=vW7Y6SLBYQR9IV5cEwJn3J1WWqjYqDuN6NTh11p8lwK5BJdAbaxR3zg+MDWwWIGNxs
         9wiod0hNsQek5mTYD69QlkzYDmaD5NH7J8lalWlLsCZRQb1j+WnVLfrM8fGu+JD47sli
         kGcmJF1Jgr2OAvjWaquf53LwbmtSO0nE5B9sWE8tPn+Zwbug0PajZ02CscPmiulJz7Ko
         TFrWMNO3ZfWb1fLLMm2MkNom9SnJSfobMAKvTQ7e8PB3IdFXFU+louLifk1iu2UzKaGZ
         pn2Cv2sHkMFrRBPSQ5M/KnhYloFs27i2eC8VUDU4yb1VZiWhS6NiLrEVtQ2W0nVg2Soh
         0Nug==
X-Forwarded-Encrypted: i=1; AJvYcCW74wa3O7ZWB+EkBgu8DHuXfY5yU2FisjbXh6GkpW51DpDy9aAaLcdg2T+BRQJ3xmyjYVAcd9oLm9tn@vger.kernel.org
X-Gm-Message-State: AOJu0YxwFPHXZHg8oRu2cGQ7WKKfnoLa2OII2dmcr1lYww3z+MeVJF8u
	omR3f1zOogsQatzAAQGfnMKSU1A2DYzhP6flSxmioGeceVFwJGpOKQO1SwaFBXeZjhwX1x8HM5/
	kIV/Eneeq86pyq1/X35DlOAmEOQevfFYWrNzi
X-Google-Smtp-Source: AGHT+IGl61F4f0ftYFMGsiQbwYzHE/z5H02ZJShnK57l4cZ0n0C26unhLmoZ1lt/9kS0S1twnCdNwstxD7QTkD9leS4=
X-Received: by 2002:a05:6e02:194e:b0:377:14ab:42ea with SMTP id
 e9e14a558f8ab-3a047199bb8mr996875ab.16.1725484066426; Wed, 04 Sep 2024
 14:07:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902044128.664075-1-surenb@google.com> <20240902044128.664075-7-surenb@google.com>
 <20240901221636.5b0af3694510482e9d9e67df@linux-foundation.org>
 <CAJuCfpGNYgx0GW4suHRzmxVH28RGRnFBvFC6WO+F8BD4HDqxXA@mail.gmail.com>
 <47c4ef47-3948-4e46-8ea5-6af747293b18@nvidia.com> <70ef75d9-a573-4989-9a9d-c8bc087f212b@nvidia.com>
 <CAJuCfpEQLDW1A7EX8LAcaRYdxKYBvP1E1cmYDoFXrG_V+AXv+g@mail.gmail.com> <c55739ec-3f0c-4f37-ad86-fe337d71d5a2@nvidia.com>
In-Reply-To: <c55739ec-3f0c-4f37-ad86-fe337d71d5a2@nvidia.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 4 Sep 2024 14:07:31 -0700
Message-ID: <CAJuCfpH_BSiQiNyUs8Jx3WZHmEELW3_NESi8ii0XCQR_x+gxNg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] alloc_tag: config to store page allocation tag
 refs in page flags
To: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, kent.overstreet@linux.dev, corbet@lwn.net, 
	arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, 
	thuth@redhat.com, tglx@linutronix.de, bp@alien8.de, 
	xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com, 
	vbabka@suse.cz, mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	dennis@kernel.org, yuzhao@google.com, vvvvvv@google.com, rostedt@goodmis.org, 
	iamjoonsoo.kim@lge.com, rientjes@google.com, minchan@google.com, 
	kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 11:58=E2=80=AFAM 'John Hubbard' via kernel-team
<kernel-team@android.com> wrote:
>
> On 9/4/24 9:08 AM, Suren Baghdasaryan wrote:
> > On Tue, Sep 3, 2024 at 7:06=E2=80=AFPM 'John Hubbard' via kernel-team
> > <kernel-team@android.com> wrote:
> >> On 9/3/24 6:25 PM, John Hubbard wrote:
> >>> On 9/3/24 11:19 AM, Suren Baghdasaryan wrote:
> >>>> On Sun, Sep 1, 2024 at 10:16=E2=80=AFPM Andrew Morton <akpm@linux-fo=
undation.org> wrote:
> >>>>> On Sun,  1 Sep 2024 21:41:28 -0700 Suren Baghdasaryan <surenb@googl=
e.com> wrote:
> ...
> >> The configuration should disable itself, in this case. But if that is
> >> too big of a change for now, I suppose we could fall back to an error
> >> message to the effect of, "please disable CONFIG_PGALLOC_TAG_USE_PAGEF=
LAGS
> >> because the kernel build system is still too primitive to do that for =
you". :)
> >
> > I don't think we can detect this at build time. We need to know how
> > many page allocations there are, which we find out only after we build
> > the kernel image (from the section size that holds allocation tags).
> > Therefore it would have to be a post-build check. So I think the best
> > we can do is to generate the error like the one you suggested after we
> > build the image.
> > Dependency on CONFIG_PAGE_EXTENSION is yet another complexity because
> > if we auto-disable CONFIG_PGALLOC_TAG_USE_PAGEFLAGS, we would have to
> > also auto-enable CONFIG_PAGE_EXTENSION if it's not already enabled.
> >
> > I'll dig around some more to see if there is a better way.
> >>
> >>>> - If there are enough unused bits but we have to push last_cpupid ou=
t
> >>>> of page flags, we issue a warning and continue. The user can disable
> >>>> CONFIG_PGALLOC_TAG_USE_PAGEFLAGS if last_cpupid has to stay in page
> >>>> flags.
> >>
> >> Let's try to decide now, what that tradeoff should be. Just pick one b=
ased
> >> on what some of us perceive to be the expected usefulness and frequenc=
y of
> >> use between last_cpuid and these tag refs.
> >>
> >> If someone really needs to change the tradeoff for that one bit, then =
that
> >> someone is also likely able to hack up a change for it.
> >
> > Yeah, from all the feedback, I realize that by pursuing the maximum
> > flexibility I made configuring this mechanism close to impossible. I
> > think the first step towards simplifying this would be to identify
> > usable configurations. From that POV, I can see 3 useful modes:
> >
> > 1. Page flags are not used. In this mode we will use direct pointer
> > references and page extensions, like we do today. This mode is used
> > when we don't have enough page flags. This can be a safe default which
> > keeps things as they are today and should always work.
>
> Definitely my favorite so far.
>
> > 2. Page flags are used but not forced. This means we will try to use
> > all free page flags bits (up to a reasonable limit of 16) without
> > pushing out last_cpupid.
>
> This is a logical next step, agreed.
>
> > 3. Page flags are forced. This means we will try to use all free page
> > flags bits after pushing last_cpupid out of page flags. This mode
> > could be used if the user cares about memory profiling more than the
> > performance overhead caused by last_cpupid.
> >
> > I'm not 100% sure (3) is needed, so I think we can skip it until
> > someone asks for it. It should be easy to add that in the future.
>
> Right.
>
> > If we detect at build time that we don't have enough page flag bits to
> > cover kernel allocations for modes (2) or (3), we issue an error
> > prompting the user to reconfigure to mode (1).
> >
> > Ideally, I would like to have (2) as default mode and automatically
> > fall back to (1) when it's impossible but as I mentioned before, I
> > don't yet see a way to do that automatically.
> >
> > For loadable modules, I think my earlier suggestion should work fine.
> > If a module causes us to run out of space for tags, we disable memory
> > profiling at runtime and log a warning for the user stating that we
> > disabled memory profiling and if the user needs it they should
> > configure mode (1). I *think* I can even disable profiling only for
> > that module and not globally but I need to try that first.
> >
> > I can start with modes (1) and (2) support which requires only
> > CONFIG_PGALLOC_TAG_USE_PAGEFLAGS defaulted to N. Any user can try
> > enabling this config and if that builds fine then keeping it for
> > better performance and memory usage. Does that sound acceptable?
> > Thanks,
> > Suren.
> >
>
> How badly do we need (2)? Because this is really expensive:
>
>     a) It adds complexity to a complex,delicate core part of mm.
>
>     b) It adds constraints, which prevent possible future features.
>
> It's not yet clear that (2) is valuable enough (compared to (1))
> to compensate, at least from what I've read. Unless I missed
> something big.

(1) is what we already have today.
(2) would allow us to drop page_ext dependency, so there is
considerable memory saving and performance improvement (no need to
lookup the page extension on each tag reference). The benefits are
described in the cover letter at:
https://lore.kernel.org/all/20240902044128.664075-1-surenb@google.com/.


>
>
> thanks,
> --
> John Hubbard
>
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>

