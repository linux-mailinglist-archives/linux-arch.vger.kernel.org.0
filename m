Return-Path: <linux-arch+bounces-8180-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF9099F085
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 17:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2ED1C2380D
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 15:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6761B392E;
	Tue, 15 Oct 2024 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DEmBhcCd"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA611B3928
	for <linux-arch@vger.kernel.org>; Tue, 15 Oct 2024 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729004363; cv=none; b=ciAxaSNz+qzEqhJmcK1WqFLN7Gb/cqexSFGu8BZbUYeVmEjQy1gfm/BdB/lkG5PEZlI5YAWiyh+d5sQ0IVwcxEwFGNaJ/Q1ZOd6ljRd7fE5fxVkuLSFX3I23G2Y3jtT+zNZpS1ARqON5SmlpZ89625kk8yO22vnpPiRCYQ1rGys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729004363; c=relaxed/simple;
	bh=ReNaXLa7EDSRsWOehh9otylGaRM81/DA1a4vQfbmQsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hbn+lTu7u3TuRpwa7x4USBIFx1y5NjMk1a+g6BdEKbvFqbyXJAzVajCTvBlAPMveeafDuXePWZdHwaH02U062/LbgkbKysUUoEKXqUXVnRhUxuwEFKZtW6lKk3G20AvyrZ2Z4fb4pIC/a7SS6b9Fr2TzfKNQ4b/1HiRr2BCaaT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DEmBhcCd; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-460395fb1acso758661cf.0
        for <linux-arch@vger.kernel.org>; Tue, 15 Oct 2024 07:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729004361; x=1729609161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ReNaXLa7EDSRsWOehh9otylGaRM81/DA1a4vQfbmQsM=;
        b=DEmBhcCdB5A2jDMTLKX2IzIzb+vyqvFup++qxZakzxJV3w7Fy5VN3CtHpdt84jqtDU
         VlcDxLbwq7G74/b/AtlwhfyvxPsx+XdS0iRCJJX7PBnI3QJTwjKx/NVemGz93tucNHA3
         4RVmydkh4DLUQt5NoQ8H4MZGye2FlkTZXgN9UBP6L5JJjsOaMfBvZvq24GHoly+rrpvw
         WJSTHlfbhytYF4ibnhMFT9ZOQgdj8T1dU6k51aCnWPXiwkzKrt17eipPxYO9n++XgULQ
         ZxXAuLuCd8l3wmninF3UrNw8zP+dQyrqj8WzNBZyEnxh9s0W+UAFL+WzOKmZoh9t27y8
         rq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729004361; x=1729609161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ReNaXLa7EDSRsWOehh9otylGaRM81/DA1a4vQfbmQsM=;
        b=Rax4BYtntMqsAnAy97BRWpdqYqwd9JcIgHzt/jc70EbdHVrTujaPyfFzqcqZnMohID
         Cj48P4ojAsR1ZP6v5ijx1j4kjnTvm/y4iElSWFh08KfkRQIQIgAg03ueJ6ZKug275DR+
         t0ZhNbL10Z8jYZ7rOfS2m5bEqjiOZSQQNagifaMom3V/xXzd2HaD2tPiMTmqCuYn4YUk
         KynqhK+QwsEaqZhqzwAUA2sKkZpd9QlT8+4BNmyyy23RLpa/B7cWPj/AiZBYFenShXMd
         5PZm/kWsFwpWAX5Gv1B1k6oldJMQbydCKVyjC1MBkspvakHyzyPi3nXZWS5ql+OxGgtq
         Fl3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDnxXsV9SBFLsvl6/bZepJLNhaNF1mL6PmmYGwKQbEEJTZj10wVXVA097oup8v5POtuOiAcCgYrrHd@vger.kernel.org
X-Gm-Message-State: AOJu0YxJRq7ulNoe9Mx737BjnLlXyearD0GZtmWeNjfj/Or/UNesEkIj
	D+WGsc05vt3Pev9PcB43F7/2aRnv4E1NoDXSWZrwA5z1BKbCnqDuKC5eKa8cZ8BWcpvKKOVcDI5
	bUQ/eHTlLU1GRzR0855AAMWBPnTwRH5S1Kch0
X-Google-Smtp-Source: AGHT+IHJlsYKE0BFpFyNwkK2d4xoCapcyo0nTBR4tuj5bDK0HvMMgpUVhfrZLI7tVRfTncBnkVgj2gcuDf9UaJ6fHp0=
X-Received: by 2002:a05:622a:5489:b0:460:4841:8eb5 with SMTP id
 d75a77b69052e-46059c77626mr8399751cf.19.1729004360796; Tue, 15 Oct 2024
 07:59:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014203646.1952505-1-surenb@google.com> <20241014203646.1952505-6-surenb@google.com>
 <CAJD7tkY0zzwX1BCbayKSXSxwKEGiEJzzKggP8dJccdajsr_bKw@mail.gmail.com>
 <cd848c5f-50cd-4834-a6dc-dff16c586e49@nvidia.com> <6a2a84f5-8474-432f-b97e-18552a9d993c@redhat.com>
In-Reply-To: <6a2a84f5-8474-432f-b97e-18552a9d993c@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 15 Oct 2024 07:59:08 -0700
Message-ID: <CAJuCfpGkuaCh+PxKbzMbu-81oeEdzcfjFThoRk+-Cezf0oJWZg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] alloc_tag: config to store page allocation tag
 refs in page flags
To: David Hildenbrand <david@redhat.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Yosry Ahmed <yosryahmed@google.com>, 
	akpm@linux-foundation.org, kent.overstreet@linux.dev, corbet@lwn.net, 
	arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, 
	thuth@redhat.com, tglx@linutronix.de, bp@alien8.de, 
	xiongwei.song@windriver.com, ardb@kernel.org, vbabka@suse.cz, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	yuzhao@google.com, vvvvvv@google.com, rostedt@goodmis.org, 
	iamjoonsoo.kim@lge.com, rientjes@google.com, minchan@google.com, 
	kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 12:32=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 15.10.24 01:53, John Hubbard wrote:
> > On 10/14/24 4:48 PM, Yosry Ahmed wrote:
> >> On Mon, Oct 14, 2024 at 1:37=E2=80=AFPM Suren Baghdasaryan <surenb@goo=
gle.com> wrote:
> >>>
> >>> Add CONFIG_PGALLOC_TAG_USE_PAGEFLAGS to store allocation tag
> >>> references directly in the page flags. This eliminates memory
> >>> overhead caused by page_ext and results in better performance
> >>> for page allocations.
> >>> If the number of available page flag bits is insufficient to
> >>> address all kernel allocations, profiling falls back to using
> >>> page extensions with an appropriate warning to disable this
> >>> config.
> >>> If dynamically loaded modules add enough tags that they can't
> >>> be addressed anymore with available page flag bits, memory
> >>> profiling gets disabled and a warning is issued.
> >>
> >> Just curious, why do we need a config option? If there are enough bits
> >> in page flags, why not use them automatically or fallback to page_ext
> >> otherwise?
> >
> > Or better yet, *always* fall back to page_ext, thus leaving the
> > scarce and valuable page flags available for other features?
> >
> > Sorry Suren, to keep coming back to this suggestion, I know
> > I'm driving you crazy here! But I just keep thinking it through
> > and failing to see why this feature deserves to consume so
> > many page flags.
>
> My 2 cents: there is nothing wrong about consuming unused page flags in
> a configuration. No need to let them stay unused in a configuration :)
>
> The real issue starts once another feature wants to make use of some of
> them ... in such configuration there would be less available for
> allocation tags and the performance of allocations tags might
> consequently get worse again.

Thanks for the input and indeed this is the case. If this happens, we
will get a warning telling us that page flags could not be used and
page_ext will be used instead. I think that's the best I can do given
that page flag bits is a limited resource.

>
> --
> Cheers,
>
> David / dhildenb
>

