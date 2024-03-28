Return-Path: <linux-arch+bounces-3011-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BD787D090
	for <lists+linux-arch@lfdr.de>; Fri, 15 Mar 2024 16:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7585A1F21F34
	for <lists+linux-arch@lfdr.de>; Fri, 15 Mar 2024 15:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AC43F9E9;
	Fri, 15 Mar 2024 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BK1grvRy"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A083E474
	for <linux-arch@vger.kernel.org>; Fri, 15 Mar 2024 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710517634; cv=none; b=gLbyZepOpEX0zT9pBXFVITse2FCl4QGJ8ZCHRLMd7rsi7/WbI7Yvyai82FsEoUvIob0HljLn07oPgMi8GqsdVH87kN24p0dEhTiCJn5ifixwhvIYygHbPep5OZIL+t3ICD2EOnki+KZUKW6gsaSzqUv6340WNdWHtWtKv0DT2g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710517634; c=relaxed/simple;
	bh=wNtT6+0t+kGzkNhG5FyRgYZZ74DtQijFGV7l7mpb0Ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lqTGgCFLOZirYaJtdim4k+pdXDjiyxBIAnv/ca0vj8BHpGgrUxihrgBRQCfLRedWriL8jWPL1yl+JSlqKJYA1gitUi+MKLCPoWPDdvuYaVMlgggJT8eCYVkpccNYjSFvHMxZ4GXNtwblF0yamlYfL6Hu0/ONPGHRR71mEw+teuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BK1grvRy; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-60a3c48e70fso24479937b3.1
        for <linux-arch@vger.kernel.org>; Fri, 15 Mar 2024 08:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710517631; x=1711122431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hTYJR/EPYVQveJbg5FctPr1PKFKWOQ5oCn+BSWzHW0=;
        b=BK1grvRy0GHfMYHQ/RADrgIOOArUHGsc9V9yMuEKUvHDWqdM6klTeI+9Z7Oam/sMoo
         Zs22/qsOuClHiTVqN7YvL/pFRDkWcsLJG3YdL0ZYBd17g4wf5f8aY51KGl26wOY17FH5
         kSrgnTgXtBg1H+IERx/QKVpNEp2fNdolrXUDJAWoMQwo/VkMHNldV/x9SYE+lgYVloK7
         TF2QoIVu4k8YJSGWZ/z/zvoyo2bHgLm2yOAps6MBjiHnpF9Xlkh/Aqo5kly72MY7s+Su
         mtst0LviU8A/+0YeiJwKtd+oq6cUXloRNoOqWuAG+lOG+LVr066k02W5V0atYmHs0t7y
         +S3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710517631; x=1711122431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5hTYJR/EPYVQveJbg5FctPr1PKFKWOQ5oCn+BSWzHW0=;
        b=eCIbxhC/E86aejCVnLeXxKp7zYKYaMVrbMFrnOGjRMd9oCzKyuabEbKW2xhVdjGMyO
         OKzgofXZ1qD+MZdJvbgaBRdenn853w/rBbWzs8ctsYDQyfBO68OFsZ35ShVdNK9IaGYV
         t/AjahvokJVwjIpXO6F0NUFxWKBNDEfLkvxUVvUfJ8tJ3B0FquCn0xqRMLqEP4YRcsxr
         faTYKSb9Mt+1crwu7tTmI6nKdnFFpZ8rzfkIShvAGoEJeihcKlBFkIEdDRZ56whgk2PW
         NBC+R4fKaOv5lGJ7abKOVKNoKfOtUx4vnHcxlXze6lQagnl7gRDQsaWo6cKyzyGrtbqh
         3/jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKen2E4rncmelYNWPKFU/P3Nn0Ec0YYJCRulXrks7MG3hnzDVvnHrRZS8qqbwZz3E1ag9Ar/NtDR1HNPhAfxstftli9aJxFmqkcw==
X-Gm-Message-State: AOJu0YyjlK9pMIPcq+14RQvmSGlogIBO+0GGU5eT/EWxX47EQqoSHvrD
	rNQUIReIkGXNIl04u7+KcUa4spT16xW4bs0dLVz9Rt7Hjoh0kh5bpU8WbXAoLOkxX2F+Wuc4VFu
	LtKjdu1Lsw01/ReuYetzg6TlAbfpqNakx8HWK
X-Google-Smtp-Source: AGHT+IEwiyjib3jLb0fcW3RfIFy8PuKVxjXiqnQa/2aHEZk0YzBmdn1yExjQqvOF2tJR6SyIA+70XUnt7nI7TF8fE6Y=
X-Received: by 2002:a25:ad5f:0:b0:dc7:4f61:5723 with SMTP id
 l31-20020a25ad5f000000b00dc74f615723mr4966380ybe.39.1710517631010; Fri, 15
 Mar 2024 08:47:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com> <20240306182440.2003814-15-surenb@google.com>
 <ZfRaBJ8nq57TAG6L@casper.infradead.org>
In-Reply-To: <ZfRaBJ8nq57TAG6L@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 15 Mar 2024 08:47:00 -0700
Message-ID: <CAJuCfpEpMwfEgrsMALqpzH=3FL0WxrXY1bRkvezMdCw2BAtQRg@mail.gmail.com>
Subject: Re: [PATCH v5 14/37] lib: introduce support for page allocation tagging
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 7:24=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Mar 06, 2024 at 10:24:12AM -0800, Suren Baghdasaryan wrote:
> > +static inline void pgalloc_tag_add(struct page *page, struct task_stru=
ct *task,
> > +                                unsigned int order)
>
> If you make this "unsigned int nr" instead of order, (a) it won't look
> completely insane (what does adding an order even mean?) and (b) you
> can reuse it from the __free_pages path.

Sounds good to me.

>
> > @@ -1101,6 +1102,7 @@ __always_inline bool free_pages_prepare(struct pa=
ge *page,
> >               /* Do not let hwpoison pages hit pcplists/buddy */
> >               reset_page_owner(page, order);
> >               page_table_check_free(page, order);
> > +             pgalloc_tag_sub(page, order);
>
> Obviously you'll need to make sure all the callers now pass in 1 <<
> order instead of just order.

Ack.

>

