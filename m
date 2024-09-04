Return-Path: <linux-arch+bounces-7018-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0D196C378
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 18:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC91280E42
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 16:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00EE1DCB1A;
	Wed,  4 Sep 2024 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="guCovA1g"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC811DB55E
	for <linux-arch@vger.kernel.org>; Wed,  4 Sep 2024 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466100; cv=none; b=GXQyp2x6ntKcgG72CEWrBanTHcJzFdLX9GIzUyI4OyvUfLIr0CHKPOEO5YHLYal0yCFcc9dsB+A4bS8y5Wt7uAgnT8om9GMIBi9xzukBSbHpeRInaAs5VK+vSoKU1Evs/f2b3A0DQRMva6rNG8/u8oq/EG4BgQWaWJQyHiTGHQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466100; c=relaxed/simple;
	bh=YM1KtulpPCPRxDHtU0Vtn8bNsr5FCjaa/VxQ6MRU0CE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uJ9t+1U5n3knOwmYNCoatq/peu8ntKlUxFj229HCPoyD2ZaJjd2I6Wv13D13fgQtSrgqPmJSCyjxP2E+6ytUmE9e/oqtVpn86CqwgYnGSTD3DqYHOlrnxUZx45pRQPTSSoTQGOeKUAAohnbQQBinIf6NGQPx/68CZwFVpXBAd/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=guCovA1g; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20546b8e754so251255ad.1
        for <linux-arch@vger.kernel.org>; Wed, 04 Sep 2024 09:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725466098; x=1726070898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60X+GVTsm77C3O7RWqxDsSogxlp8g48EOsrd3C6f93s=;
        b=guCovA1gBnohMEzY0C0GexzqA6pnBxgpKp4NsfReo820gnDZAS7yCUl2szpGuOvwWr
         z2xhwb+GA5m7K04Wm79AD2Hq0zZ6Ej7XKtBfGnM0pKAi6lUcUcOAe+p9dGBivReNXE6y
         sOal071Gvt0/JZCuF3dY8o+Moq+OQ8BXnZFs7LW29wwhmG5NDJG+CtInrKyNAlHxpTO5
         0EY+VHy7eyY5hQRVFSfB5Kodo1plXzbwcWRg61I+DWS3HVB1Kw9tOiheNP4UFLUstEDJ
         3yCBy6Sh+ZNyuwsmDlGrn3TuN4E85dEiiNlfQE4zPrexkod/dcKdwyP+/RzNvMwsCBNo
         /gYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725466098; x=1726070898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60X+GVTsm77C3O7RWqxDsSogxlp8g48EOsrd3C6f93s=;
        b=sapC5bDVHFPukYyQZp54eXrcxrAH73U9vZrnvNet0jmKR7kq1/21pVj4/4lmldwavk
         +TGX7/5USccI3CNFc360aezTIQZIl256TH4lwVRZccpuMRt6uguM7aehGkkoVaZfjXyE
         2XL91wV4ZJjeOwXO9+FhGjbBRsx3saoDAON/A7T58Z0qZempiscxNSwIwIfQFZtfeXXP
         1SJZes2Ca5E+Fzm7ZZy14YqrVGT1ec3swwTDumnEZPAqpuhB2TRIFCRilY9laiOQiCLM
         GB0RssudX32WNNCGCcx1/obrqbV7Xu/38lYd+JVbvn2ys0oPYdI9bGC+8zXsUq+JilIX
         tNfw==
X-Forwarded-Encrypted: i=1; AJvYcCXqTBFKvAtGxxhCGKBlzPVTmRW2KReUvQviMcfmMwtMQCv8avpd6pZQ1zydCrxTQv49nuftrRp2sRwM@vger.kernel.org
X-Gm-Message-State: AOJu0YzJPgFZLbvmLW5l2Oaa+15wqq8SrSNqf/MLyXPejqajCFZqmrVD
	lH5sPWUi5hXob562DcQjQk4c1AdNdAWbkAOmLJJvsmQrLSIdlqD2O8NAPUGen9mk8kQ/p0xXAk9
	eIes3XIONc6wNfjIJFXxjmkCi0icqHk/AQtQL
X-Google-Smtp-Source: AGHT+IEl7wqni8pYwfiTi4i+C6Cah6Qs7+S0s/DuJ3hiJc2vSd83YZ8C7wA85q+KXr69umyz9wqxDRGcOIVMOyg4Ceg=
X-Received: by 2002:a17:902:f9c6:b0:205:753e:b49a with SMTP id
 d9443c01a7336-206b07c6bfdmr3813365ad.18.1725466097883; Wed, 04 Sep 2024
 09:08:17 -0700 (PDT)
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
In-Reply-To: <70ef75d9-a573-4989-9a9d-c8bc087f212b@nvidia.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 4 Sep 2024 09:08:04 -0700
Message-ID: <CAJuCfpEQLDW1A7EX8LAcaRYdxKYBvP1E1cmYDoFXrG_V+AXv+g@mail.gmail.com>
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

On Tue, Sep 3, 2024 at 7:06=E2=80=AFPM 'John Hubbard' via kernel-team
<kernel-team@android.com> wrote:
>
> On 9/3/24 6:25 PM, John Hubbard wrote:
> > On 9/3/24 11:19 AM, Suren Baghdasaryan wrote:
> >> On Sun, Sep 1, 2024 at 10:16=E2=80=AFPM Andrew Morton <akpm@linux-foun=
dation.org> wrote:
> >>> On Sun,  1 Sep 2024 21:41:28 -0700 Suren Baghdasaryan <surenb@google.=
com> wrote:
> > ...
> >>> We shouldn't be offering things like this to our users.  If we cannot=
 decide, how
> >>> can they?
> >>
> >> Thinking about the ease of use, the CONFIG_PGALLOC_TAG_REF_BITS is the
> >> hardest one to set. The user does not know how many page allocations
>
> I should probably clarify my previous reply, so here is the more detailed
> version:
>
> >> are there. I think I can simplify this by trying to use all unused
> >> page flag bits for addressing the tags. Then, after compilation we can
>
> Yes.
>
> >> follow the rules I mentioned before:
> >> - If the available bits are not enough to address all kernel page
> >> allocations, we issue an error. The user should disable
> >> CONFIG_PGALLOC_TAG_USE_PAGEFLAGS.
>
> The configuration should disable itself, in this case. But if that is
> too big of a change for now, I suppose we could fall back to an error
> message to the effect of, "please disable CONFIG_PGALLOC_TAG_USE_PAGEFLAG=
S
> because the kernel build system is still too primitive to do that for you=
". :)

I don't think we can detect this at build time. We need to know how
many page allocations there are, which we find out only after we build
the kernel image (from the section size that holds allocation tags).
Therefore it would have to be a post-build check. So I think the best
we can do is to generate the error like the one you suggested after we
build the image.
Dependency on CONFIG_PAGE_EXTENSION is yet another complexity because
if we auto-disable CONFIG_PGALLOC_TAG_USE_PAGEFLAGS, we would have to
also auto-enable CONFIG_PAGE_EXTENSION if it's not already enabled.

I'll dig around some more to see if there is a better way.

>
>
> >> - If there are enough unused bits but we have to push last_cpupid out
> >> of page flags, we issue a warning and continue. The user can disable
> >> CONFIG_PGALLOC_TAG_USE_PAGEFLAGS if last_cpupid has to stay in page
> >> flags.
>
> Let's try to decide now, what that tradeoff should be. Just pick one base=
d
> on what some of us perceive to be the expected usefulness and frequency o=
f
> use between last_cpuid and these tag refs.
>
> If someone really needs to change the tradeoff for that one bit, then tha=
t
> someone is also likely able to hack up a change for it.

Yeah, from all the feedback, I realize that by pursuing the maximum
flexibility I made configuring this mechanism close to impossible. I
think the first step towards simplifying this would be to identify
usable configurations. From that POV, I can see 3 useful modes:

1. Page flags are not used. In this mode we will use direct pointer
references and page extensions, like we do today. This mode is used
when we don't have enough page flags. This can be a safe default which
keeps things as they are today and should always work.
2. Page flags are used but not forced. This means we will try to use
all free page flags bits (up to a reasonable limit of 16) without
pushing out last_cpupid.
3. Page flags are forced. This means we will try to use all free page
flags bits after pushing last_cpupid out of page flags. This mode
could be used if the user cares about memory profiling more than the
performance overhead caused by last_cpupid.

I'm not 100% sure (3) is needed, so I think we can skip it until
someone asks for it. It should be easy to add that in the future.
If we detect at build time that we don't have enough page flag bits to
cover kernel allocations for modes (2) or (3), we issue an error
prompting the user to reconfigure to mode (1).

Ideally, I would like to have (2) as default mode and automatically
fall back to (1) when it's impossible but as I mentioned before, I
don't yet see a way to do that automatically.

For loadable modules, I think my earlier suggestion should work fine.
If a module causes us to run out of space for tags, we disable memory
profiling at runtime and log a warning for the user stating that we
disabled memory profiling and if the user needs it they should
configure mode (1). I *think* I can even disable profiling only for
that module and not globally but I need to try that first.

I can start with modes (1) and (2) support which requires only
CONFIG_PGALLOC_TAG_USE_PAGEFLAGS defaulted to N. Any user can try
enabling this config and if that builds fine then keeping it for
better performance and memory usage. Does that sound acceptable?
Thanks,
Suren.

>
> thanks,
> --
> John Hubbard
>
> >> - If we run out of addressing space during module loading, we disable
> >> allocation tagging and continue. The user should disable
> >> CONFIG_PGALLOC_TAG_USE_PAGEFLAGS.
> >
> > If the computer already knows what to do, it should do it, rather than
> > prompting the user to disable a deeply mystifying config parameter.
> >
> >>
> >> This leaves one outstanding case:
> >> - If we run out of addressing space during module loading but we would
> >> not run out of space if we pushed last_cpupid out of page flags during
> >> compilation.
> >> In this case I would want the user to have an option to request a
> >> larger addressing space for page allocation tags at compile time.
> >> Maybe I can keep CONFIG_PGALLOC_TAG_REF_BITS for such explicit
> >> requests for a larger space? This would limit the use of
> >> CONFIG_PGALLOC_TAG_REF_BITS to this case only. In all other cases the
> >> number of bits would be set automatically. WDYT?
> >
> > Manually dealing with something like this is just not going to work.
> >
> > The more I read this story, the clearer it becomes that this should be
> > entirely done by the build system: set it, or don't set it, automatical=
ly.
> >
> > And if you can make it not even a kconfig item at all, that's probably =
even
> > better.
> >
> > And if there is no way to set it automatically, then that probably mean=
s
> > that the feature is still too raw to unleash upon the world.
> >
> > thanks,
>
>
>
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>

