Return-Path: <linux-arch+bounces-2742-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600B2867DF4
	for <lists+linux-arch@lfdr.de>; Mon, 26 Feb 2024 18:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A6AF28E669
	for <lists+linux-arch@lfdr.de>; Mon, 26 Feb 2024 17:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987A5131747;
	Mon, 26 Feb 2024 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FpRiBDv+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B99F131737
	for <linux-arch@vger.kernel.org>; Mon, 26 Feb 2024 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967522; cv=none; b=GoyP3hpjII604uvwKxsIf3CsW240/ZBuCtCQgocd1lhEXGv0ZlO9xWwXQihH20tjM8WvSGVNBql7e40MHNGTf8emEy6shVQIYBr7qgBoYl3Xd7qhb955nydfnpZkpfYT4iAIVh4FSGmL36/cDzfR2V38chE2pq4ftw1cu4UluiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967522; c=relaxed/simple;
	bh=Chynr1L1b/d5TcYFCNc4RvKn+tu9v2QwhIq+NAH+cTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3Z/k2LE9qsLrg/9NwW3yrhhb9/FfYTr8aoNVAtrVTfx203LMKnRs3c73YswgOxtJ3ScQr2itsFYmuTVeiomK9iNM8tuAwA+ZV9SLPexvSNt3lZV5ZN9oM2Ec/BfkrMdyU1rrFI7AcSTMgrhituzp61/XRLauAch7ZtsOsgkbYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FpRiBDv+; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc745927098so3101728276.3
        for <linux-arch@vger.kernel.org>; Mon, 26 Feb 2024 09:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708967519; x=1709572319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Chynr1L1b/d5TcYFCNc4RvKn+tu9v2QwhIq+NAH+cTo=;
        b=FpRiBDv+CAV4Y6DNyKhilSCvwzfE05AWMZswNQENVfSKH9LDwic2wN/R6WnSjGiJRY
         XLh1loIgNFgYP+YkN0DMJOO0yInyIT66++RmRqEp9lMKhJzaPz7za3p6D4F0FkFOOdjy
         TKywspDmeXUx5/Bi9fLUnmwVqrWD9oVP8AtA5BGpPpfrjXTU4EMm1hLHZ06rbHDYmR/T
         QG8tVN3ExGz/BT+fuMexyKcxVmoRzl9al+fJHXXiHgRA9UcGVrYxYap4LZHPDE3gEB1U
         EUNBT6rRGCB8h2UwQSx3Ovq6T4B1sAbyWagQoZocd22ZG7aI30pzUd5Kd3nQ0PF/5xbS
         7PtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708967519; x=1709572319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Chynr1L1b/d5TcYFCNc4RvKn+tu9v2QwhIq+NAH+cTo=;
        b=in0cyuDw9ZsFT+UBBZa7vNCpLlG1f6dhSYSFFxKRgOzDILV9649wE/MAwiI6C1poDl
         J+V0IZJFkaEAey0SWW7REyF05VFtSVTatK4sNc6hfgdiJMOKYw9yZCYrZtnJu+CIB+Vg
         d+j52Ef+iIW2KkkdJ1Q+VjfT8TK9DBUaHDt32GmKdT7iTu92202MeH0zVSp7XByNsAMk
         Ca8+DLwBqpLjk/B7lKcYorYk38aC6WnVkEug9PU8jgWYGeIPB5on1coAXjYigBg4cU7z
         m5vNUzgROkRX5TrOdArFm7/e5jSycq2l1PStIg81xw29yVlbBeqPwQYP1X0KabJBRmUl
         bzGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9b3MzqJFGqV0pGd2LHLsilsoqgkm2kKr+lou+kyO8DvEKgM3Jq2yS12FuZZ+dQBJKD7Oyou8xLPTpHAaNIOSwHQAUtrqv/HclDw==
X-Gm-Message-State: AOJu0YwCH+lWayy31qPLxx3bl/f/te4kcr79rIBscWu5Ihbg5OqJqVl4
	+3VfJqzuJebFlapFNpuHWCZXVqiDsgwBpQoR51E9EJidQYkWqVN46sR1ht7j00zTMEP5UxIWszF
	5IJhjC8XBtkSlVkzkerIBmeDABh4ACJssQYCZ
X-Google-Smtp-Source: AGHT+IFIvCWhsm/t6u8M8LFQ9aoCdr7tXSqiWENlQfptKH682IaVJyWTqKPlBpDf+9Q2OFcqiRYx3fgZnfrpOzBGyTM=
X-Received: by 2002:a25:acd2:0:b0:dcc:2caa:578b with SMTP id
 x18-20020a25acd2000000b00dcc2caa578bmr5024557ybd.40.1708967519035; Mon, 26
 Feb 2024 09:11:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-16-surenb@google.com>
 <d6141a99-3409-447b-88ac-16c24b0a892e@suse.cz>
In-Reply-To: <d6141a99-3409-447b-88ac-16c24b0a892e@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 26 Feb 2024 09:11:45 -0800
Message-ID: <CAJuCfpGZ6W-vjby=hWd5F3BOCLjdeda2iQx_Tz-HcyjCAsmKVg@mail.gmail.com>
Subject: Re: [PATCH v4 15/36] lib: introduce support for page allocation tagging
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
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

On Mon, Feb 26, 2024 at 9:07=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 2/21/24 20:40, Suren Baghdasaryan wrote:
> > Introduce helper functions to easily instrument page allocators by
> > storing a pointer to the allocation tag associated with the code that
> > allocated the page in a page_ext field.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
>
> The static key usage seems fine now. Even if the page_ext overhead is sti=
ll
> always paid when compiled in, you mention in the cover letter there's a p=
lan
> for boot-time toggle later, so

Yes, I already have a simple patch for that to be included in the next
revision: https://github.com/torvalds/linux/commit/7ca367e80232345f471b77b3=
ea71cf82faf50954

>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

>
>

