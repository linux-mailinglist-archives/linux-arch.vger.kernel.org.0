Return-Path: <linux-arch+bounces-2488-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4128685A9B4
	for <lists+linux-arch@lfdr.de>; Mon, 19 Feb 2024 18:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF95286982
	for <lists+linux-arch@lfdr.de>; Mon, 19 Feb 2024 17:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E605E446CF;
	Mon, 19 Feb 2024 17:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="norgVx53"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D765446B8
	for <linux-arch@vger.kernel.org>; Mon, 19 Feb 2024 17:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363070; cv=none; b=ugN+/7DKU85Q9cSaSvo6YKfu4tB2fYahzptY5D3LEpaoVs6B6A7OxYLtHbopup9AidNoHBEjd2KJzoS05YC6kb9AVBRKaDopfa5li5y/9ubIfFKm0vn3btXe5XAPJx4im2qUMMb8AvSvDuwClbEYbzgPj3CBHOI0+Nptfjq88M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363070; c=relaxed/simple;
	bh=WTUgtDUhgLo3w13qAUwpQFiIiTT2/XDD2PV7WnKy99s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HUP5cl5jbo1U/ZqmDdAKnIH1aOMQ739j15x0KjM38Cdld8yW4A9wZ7ycwGyMSR7+lMHOMXWOXJV7m+x1h6ArmQyQGjMtBv3CVFhOuUb0UQ7F856q+VYTbnVoz5GXVUyS0q5EUGXf2367ATwY9OlDo97GzogXZgxrylzLeVJsqtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=norgVx53; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-607f94d0b7cso34109087b3.3
        for <linux-arch@vger.kernel.org>; Mon, 19 Feb 2024 09:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708363068; x=1708967868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTUgtDUhgLo3w13qAUwpQFiIiTT2/XDD2PV7WnKy99s=;
        b=norgVx53gDG4kXkhfxad0gWRNtKF1aWfbm2vIPVSmisOFTbyC/gcFaADEANMzR1qFU
         HXkDCrNuHPo0wu44wABPHWOuiITZUNYAvs9xk6gIsckTeapOZA0KY3I/z7ykwfhMYazs
         ke4GYoqqvwp30iorNaRtaNq0zORTjo3fnyTsRmWUm0T9dN8UcZX+dW+5ViRnAXd161Sn
         hucaqv9FZl+0oDMdFViG5PoVfQqWVMZNsOwVFGQUZsEXgB673sKKHFtmNfq+QbHJTDQ2
         V2HB0/90ENPI7qWUQ1HVo8/O3AXCPis61ANIBWPjMmBHCSyJpG1X4mNP5uGprLnxxAgI
         2dDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708363068; x=1708967868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTUgtDUhgLo3w13qAUwpQFiIiTT2/XDD2PV7WnKy99s=;
        b=QNymjX0uvhzqW/P7oRwHEBYNqFQKVO+9oaPP4k3y9PLpq25IVMDsRW0ljbFosSxdYk
         wPhYOW+tHLIlj4TY0Tb2Ak693/vqWciuHnEU4LHghTRcMBhruc/HubsnvPuFTPy5ML/N
         lJTzOVAs+03+7kjcaQrKcFaqbe9jdJcnS5yRHZGvoWKPDjAVEiI8xfB+mERUbWXFfSD5
         b/L+xDpGU4QKBJvHrRsJ/VaUPp/etku96iKjHk5DwxlbajYDjNiT3QFxqUAMXTk7pPNw
         cCBYDWIIj1kbvtjmzSl3btc0t8xVsDnuqb3KUzdeLhHBIkehmATN9ZiYNcHKrGaraAkM
         fD2w==
X-Forwarded-Encrypted: i=1; AJvYcCVZbyp0SXA5WZ1xTKbqLmZOYkKyywKhEqR11bUJ/RLFAJQ+f7rwXgZDOtZvHXitNL+2QMWRA/w0/bcn1c2dNqeH0wb3YQtE/Evpww==
X-Gm-Message-State: AOJu0YyYQ6PnrylEv4T4zoJzcyrbqOZUQdOukFk5gKmCaQyJGvP2A17l
	8cufpO9iwzryTf8hAWubCUw5Hm6WGltYxRfa64NFjJ7OR7M74Z+4yOqjr/PZ2TZSWExprHGneo3
	E0uYTKR5xwvFkxikz93a8Ig2MMPxXhsOP6rkM
X-Google-Smtp-Source: AGHT+IG9AHtZq/nRnFo+ipW0aGaGM/b0s2YVjCOPysu8kdznAi+vUsM501VBmjXmNGbLKPb0POAqw7+QMoqVeqlQNww=
X-Received: by 2002:a81:9b02:0:b0:607:9613:2afa with SMTP id
 s2-20020a819b02000000b0060796132afamr11401400ywg.0.1708363067747; Mon, 19 Feb
 2024 09:17:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zc3X8XlnrZmh2mgN@tiehlicka> <CAJuCfpHc2ee_V6SGAc_31O_ikjGGNivhdSG+2XNcc9vVmzO-9g@mail.gmail.com>
 <Zc4_i_ED6qjGDmhR@tiehlicka> <CAJuCfpHq3N0h6dGieHxD6Au+qs=iKAifFrHAMxTsHTcDrOwSQA@mail.gmail.com>
 <ruxvgrm3scv7zfjzbq22on7tj2fjouydzk33k7m2kukm2n6uuw@meusbsciwuut>
 <320cd134-b767-4f29-869b-d219793ba8a1@suse.cz> <efxe67vo32epvmyzplmpd344nw2wf37azicpfhvkt3zz4aujm3@n27pl5j5zahj>
 <20240215180742.34470209@gandalf.local.home> <20240215181648.67170ed5@gandalf.local.home>
 <20240215182729.659f3f1c@gandalf.local.home> <mi5zw42r6c2yfg7fr2pfhfff6hudwizybwydosmdiwsml7vqna@a5iu6ksb2ltk>
In-Reply-To: <mi5zw42r6c2yfg7fr2pfhfff6hudwizybwydosmdiwsml7vqna@a5iu6ksb2ltk>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 19 Feb 2024 09:17:36 -0800
Message-ID: <CAJuCfpEARb8t8pc8WVZYB=yPk6G_kYGmJTMOdgiMHaYYKW3fUA@mail.gmail.com>
Subject: Re: [PATCH v3 31/35] lib: add memory allocations report in show_mem()
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, 
	akpm@linux-foundation.org, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org, 
	liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, bsegall@google.com, bristot@redhat.com, 
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 
	42.hyeyoo@gmail.com, glider@google.com, elver@google.com, dvyukov@google.com, 
	shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 3:56=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Thu, Feb 15, 2024 at 06:27:29PM -0500, Steven Rostedt wrote:
> > All this, and we are still worried about 4k for useful debugging :-/

I was planning to refactor this function to print one record at a time
with a smaller buffer but after discussing with Kent, he has plans to
reuse this function and having the report in one buffer is needed for
that.

> Every additional 4k still needs justification. And whether we burn a
> reserve on this will have no observable effect on user output in
> remotely normal situations; if this allocation ever fails, we've already
> been in an OOM situation for awhile and we've already printed out this
> report many times, with less memory pressure where the allocation would
> have succeeded.

I'm not sure this claim will always be true, specifically in the case
of low-end devices with relatively low amounts of reserves and in the
presence of a possible quick memory usage spike. We should also
consider a case when panic_on_oom is set. All we get is one OOM
report, so we get only one chance to capture this report. In any case,
I don't yet have data to prove or disprove this claim but it will be
interesting to test it with data from the field once the feature is
deployed.

For now I think with Vlastimil's __GFP_NOWARN suggestion the code
becomes safe and the only risk is to lose this report. If we get cases
with reports missing this data, we can easily change to reserved
memory.

