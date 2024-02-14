Return-Path: <linux-arch+bounces-2360-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1D98552AB
	for <lists+linux-arch@lfdr.de>; Wed, 14 Feb 2024 19:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40ED1283F03
	for <lists+linux-arch@lfdr.de>; Wed, 14 Feb 2024 18:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60A813A26C;
	Wed, 14 Feb 2024 18:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YlVG9fIo"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F6413475E
	for <linux-arch@vger.kernel.org>; Wed, 14 Feb 2024 18:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707936694; cv=none; b=aSZURCs5MLaGctKCSVUOnZzS/c12rR+d3wPIOXnCj/ATU2MrF6qx45bCnzh0J8ZaZETT9ZtS2F1HJXJI/9kknTz6Kv060OKiWtKLB3NZPTtIG0J/zPn+mY+gZwjycdd+qj9qRJjP/Vh/4v8z8Je9NABF9a3EMTQ+HJ/M/JafH38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707936694; c=relaxed/simple;
	bh=Z3dYemjv+ptpRw8TmiD3eBcby1+9nhEoYONXK3+Hucc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iehfnQpZlF+x/6PnG5qW2snnGO/FJGv6TOq1kSYXIvR/b6pn6Ns5budNDfeohnU/22CLpe7IGvqcUNoyplof8vHHgiBFyTyFt1yjdzamITUIKpNzEm7yiUWuTFNvu5PDjOYvhdH8/F55VsO2MfBFCPv5EsGsFOr7m78Sm127usY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YlVG9fIo; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc74435c428so5655900276.2
        for <linux-arch@vger.kernel.org>; Wed, 14 Feb 2024 10:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707936692; x=1708541492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3dYemjv+ptpRw8TmiD3eBcby1+9nhEoYONXK3+Hucc=;
        b=YlVG9fIo3Rss/JeoPb4KseQqFN/IxoCnoZcPRYOw03muJm0fogK68045X4TGybrITd
         H8VFKoTAXnNbuaedu4GlUqgOxyXMqtvRbUtZwpV5XpFtoL+jJo5shKnjPbTnJgLgI2RK
         Lwulrwh5Jo7M4b8DABj+nx7pdMv+XIsP6MQcqfDk/g79wHvavdrdvNyFr/RYkt9jk06Q
         74FDf29PF3Pm4wjJMauTuD75tsYmqSXStTpZdLOMVCcRa8/OQt+VMkvz4efTTHIYWgdG
         LqNlOOy3X3pU9DJNODqBuxkepS38Q1K3EBuwpyrytqcLrOmBUccmchkMDKq8YwC8d/Jy
         yFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707936692; x=1708541492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3dYemjv+ptpRw8TmiD3eBcby1+9nhEoYONXK3+Hucc=;
        b=imqpJ4w8JKcKfvtY2TaiBj5DDxyH9eHulfx+sSh8f1yoUu3uSLr14B5VY1Ryf9pggM
         +kesxupVB/RqF6r+yRFp+0ahIIx2abs6D4SdMZsmBG81x7rGqttLwej2MoOT4n/OVRaJ
         5FkNj+l3CYu3BashnTw5s9JezB+BYYcN5+GGUniFViIMS2HzXuNQVY3rG8yTDA8l00qY
         T0eC8vKRu4XL31G8jP2SwrUH6K87OwtVZrNklLyXSd+wmAJBnnqnGG3ESuGGVeWdEvGo
         YbFNZk+zrY4dyY/6kx5Nih84nM734n3zWHz2dr5D9nS5sGe5jT3NKHSdzS6NUHHsWyEl
         3Vng==
X-Forwarded-Encrypted: i=1; AJvYcCXP4lDqihsXt4Oc+3eFr4km5+ZF5AfmC7K8NN2BLCYkyW7vVyWcZgJlS0EjEsRL0dnbGF2W6lVIA2VYVSlbZ9WOCua3VodpIarxkQ==
X-Gm-Message-State: AOJu0YyUPTlV6nsyZBb6fFo+cY1Qnj114ai5+bbtbi8QD2Z+xhDmxLNg
	5IM4bgpd9VgW3+9f1rHFNThngj3G9/sbbTlVE1Lb+Ije8xYMMzSBBpS47xTCYIzracAQeOevAeH
	yb0CThWnWrTe72dwqMqTGiQkbIsLcFZJP6USa
X-Google-Smtp-Source: AGHT+IHWH0vlRzImJau0V3Wmd3OBdnK4rpH2SIvmlGc1pOUFvNFGuZtgS0W2bVHllZLC/d1mRR8xn6Gdka1Irsg/sWQ=
X-Received: by 2002:a25:a02a:0:b0:dc2:2b0d:613e with SMTP id
 x39-20020a25a02a000000b00dc22b0d613emr2929866ybh.10.1707936691500; Wed, 14
 Feb 2024 10:51:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <Zc0KEfoCVvP1kWvA@black.fi.intel.com>
In-Reply-To: <Zc0KEfoCVvP1kWvA@black.fi.intel.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 14 Feb 2024 10:51:16 -0800
Message-ID: <CAJuCfpHEbeF2Pve462nSqcEja_ygWGvbJqzkc+NGZefRxJ6VUw@mail.gmail.com>
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
To: Andy Shevchenko <andy@black.fi.intel.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
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

On Wed, Feb 14, 2024 at 10:44=E2=80=AFAM Andy Shevchenko
<andy@black.fi.intel.com> wrote:
>
> On Mon, Feb 12, 2024 at 01:38:46PM -0800, Suren Baghdasaryan wrote:
> > Memory allocation, v3 and final:
>
> Would be nice to have --base added to cover letter. The very first patch
> can't be applied on today's Linux Next.

Sorry about that. It as based on Linus` ToT at the time of posting
(7521f258ea30 Merge tag 'mm-hotfixes-stable-2024-02-10-11-16' of
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm). I also applied
it to mm-unstable with only one trivial merge conflict in one of the
patches.

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
>

