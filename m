Return-Path: <linux-arch+bounces-2711-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA6986221E
	for <lists+linux-arch@lfdr.de>; Sat, 24 Feb 2024 02:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788451F26F11
	for <lists+linux-arch@lfdr.de>; Sat, 24 Feb 2024 01:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5229DDDCB;
	Sat, 24 Feb 2024 01:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zntyXLY0"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79089C13B
	for <linux-arch@vger.kernel.org>; Sat, 24 Feb 2024 01:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708739982; cv=none; b=usZduYMgrQU5lxhqiRjDjCpFm7tvMArhDExY0wfnI9vKuXlRzo2ArtcTNnkOuNY9ONgWK7BXSk83UXdxixhiBJH0opFG0YHG8zcuj/b12V9TLMbG/Bvc3VvH88zHghtX5iTS29oht+Moh1ut6udk2dV1/n5w57N/J26SMgEuz6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708739982; c=relaxed/simple;
	bh=T+a2SRS9CYU21NdR/LXMyfpfOaFxGBggdHbbvAXJGNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cqaZ52BV4sBSXRt4S4XPObhZv3hggS82LB6faSQ5urPudKNeB78xXjbIhpjfGb7VmR/lizdwnZ9Kl4ePg3UHQwuwwo4OivsjllhliGkLkui/MrP7LmNYfbOS+Mj7Uev+yn209/CiZTgRy3/ot6L4jwC1BH6NyB5nMDVTRWwU4+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zntyXLY0; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc6e080c1f0so1007420276.2
        for <linux-arch@vger.kernel.org>; Fri, 23 Feb 2024 17:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708739979; x=1709344779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+a2SRS9CYU21NdR/LXMyfpfOaFxGBggdHbbvAXJGNw=;
        b=zntyXLY0prDLuWUAhvw7ixaIAkbzjzN//FBBd3O1inJndHdJNJMleIJeV7pmILIE3j
         H1sZwAVtjmK4UL17vQLGrErXQgtH9PEo56eebJxhiRdq5oKHMvaMmWnyndxXsxaPDXpP
         B0G+/TPLtQdYA+tqWpY1HLN0IUBPlHROJ6oEHXFr4bBEs5NbLPiYkVxGTthTCwdI89AD
         BsSQ+baqISaQvSdgEpLz+sjf7DYzOqk9VgIBOYVwAc0IiEDMsCy1yTyDzz4GGOko2bpL
         LXdoK1umc4qmBuz/eYU/H3495v3656CSywMDPyRHm/YcM7FljiuX4s/TNoB7YqCFRu8+
         lwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708739979; x=1709344779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+a2SRS9CYU21NdR/LXMyfpfOaFxGBggdHbbvAXJGNw=;
        b=q5Yk/kuYjK8R4aVLAW56PUI/KgO1PqYG2m/4Qo39ZW4D0lagGNxYkGeATHWntciLi0
         C+T+qmc/kzvj5Qg0onHgDY9RFBfgnZR34tlstHCmsYpIgTJ3pR62ffhIKU+9O6Zeg7O5
         zBuDm0NbVSJPO1UYELv/hUfIcxF6XBRdVNejcTdOmvOE3367LYlmPB4qqdZj2ziRAgQ/
         vkXpmcvNkDlKRmKoCziXT6n3LsbZ9KXJqbLrRcpIH8+XlxbGfCWWKzE9Qm3n5BL0Xhfo
         ft0N/eJlyyFGXu/eO1o9RVhj92wtnzIDvxO/4tD/wvQR8sWN+IN7Vubm1LEfKyHxFJOd
         29OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqxkuD0LHTljKZses3gw2UcGk8xka2Wj2I+GGP/7M/rsuOjBJGGBaSaZcatGvpasdy1eJk5IGyaS+bOTCa5AzBOk2xlMbJ0q84pA==
X-Gm-Message-State: AOJu0Yz5QUMj3cUDTzjsZJ670mLzbQamXisrBScBi56r4SWGk5V7+PuK
	+A3zrbL4AMmXej25kTAHmCd2WvgPwCXPkyB/b6pnJMlzf7VQzSoK+OgniHfFJuGidgH415li46W
	q5lNbPfbDBAfTplm41JYfCgnO0ICVh55kBZDf
X-Google-Smtp-Source: AGHT+IE96gofthBIDY1zcxV1fCC6ZYb0ubhfQdxrWxQDA5xXy9sf7lsJXU+uVwoyJAnzh9d/485wU5tc9VrVgvYEwvY=
X-Received: by 2002:a25:aa67:0:b0:dcc:b69c:12e1 with SMTP id
 s94-20020a25aa67000000b00dccb69c12e1mr1515692ybi.59.1708739979162; Fri, 23
 Feb 2024 17:59:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-7-surenb@google.com>
 <Zdc6LUWnPOBRmtZH@tiehlicka> <20240222132410.6e1a2599@meshulam.tesarici.cz> <CAJuCfpGNoMa4G3o_us+Pn2wvAKxA2L=7WEif2xHT7tR76Mbw5g@mail.gmail.com>
In-Reply-To: <CAJuCfpGNoMa4G3o_us+Pn2wvAKxA2L=7WEif2xHT7tR76Mbw5g@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 23 Feb 2024 17:59:26 -0800
Message-ID: <CAJuCfpHY1T2jCCitt7cufKSeXP7zhh_f9gVN0UNZoOQz1cNBjw@mail.gmail.com>
Subject: Re: [PATCH v4 06/36] mm: enumerate all gfp flags
To: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc: Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, kent.overstreet@linux.dev, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
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
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 11:26=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Thu, Feb 22, 2024 at 4:24=E2=80=AFAM 'Petr Tesa=C5=99=C3=ADk' via kern=
el-team
> <kernel-team@android.com> wrote:
> >
> > On Thu, 22 Feb 2024 13:12:29 +0100
> > Michal Hocko <mhocko@suse.com> wrote:
> >
> > > On Wed 21-02-24 11:40:19, Suren Baghdasaryan wrote:
> > > > Introduce GFP bits enumeration to let compiler track the number of =
used
> > > > bits (which depends on the config options) instead of hardcoding th=
em.
> > > > That simplifies __GFP_BITS_SHIFT calculation.
> > > >
> > > > Suggested-by: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz>
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > >
> > > I thought I have responded to this patch but obviously not the case.
> > > I like this change. Makes sense even without the rest of the series.
> > > Acked-by: Michal Hocko <mhocko@suse.com>
> >
> > Thank you, Michal. I also hope it can be merged without waiting for the
> > rest of the series.
>
> Thanks Michal! I can post it separately. With the Ack I don't think it
> will delay the rest of the series.

Stand-alone version is posted as v5 here:
https://lore.kernel.org/all/20240224015800.2569851-1-surenb@google.com/

> Thanks,
> Suren.
>
> >
> > Petr T
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to kernel-team+unsubscribe@android.com.
> >

