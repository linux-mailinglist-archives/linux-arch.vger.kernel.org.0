Return-Path: <linux-arch+bounces-8152-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4ABB99DC16
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 04:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 842CC283107
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 02:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD34165EED;
	Tue, 15 Oct 2024 02:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y360Mv2d"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DAF156677
	for <linux-arch@vger.kernel.org>; Tue, 15 Oct 2024 02:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728958270; cv=none; b=mXkikCDMOsAGZTutzKpV6GdZoVX96ygyaUv6jS7I6cDeU7lwYLe8Rm1Vw2fQyfh6nN9L7uENTRvqbYhks6bf+1r2+SKf4b+s91Df7MbfaqUNyQHm4LnzG4cqoby+k+o6FWCBXmEv7GcMTk1zZAy8V+1CtRUwlnIFDpvzl18n05E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728958270; c=relaxed/simple;
	bh=cp5t3VeTtkuoMF2OUixwX5JKFXUbhGQ52ryZqxRB4Zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EdF2x0eSZAfNwpUahCftbIiln3lEe4xoea2QZbgJC4MMJEUOFoOKtFkPLrnPcwYYEsr/97LZsDoqvQfks7MOTXWPn9Lns6fTMZYCjqD5aohHOxjvekfPxRc89PlLjqCGFlwztz/iG96VYc1BPRMqcJ/O/2ZqHu6f51nJq7JCun8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y360Mv2d; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-460395fb1acso577461cf.0
        for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2024 19:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728958267; x=1729563067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4d393RqsyL/BJ4Co9qwq0LGbkJ+IqpYMBLpcbUgTRI=;
        b=Y360Mv2dh+DrR/NbznQjhDsyIZUnSXqr3uY9OGnhkZuRoUiaUKI7bGAAm5atliSYYy
         wLYONCu0g5evfshCyulyDLrRbMTKycGRRwqN4Taf+MSGHGBoGiNIx1f/eP1qPb/EKKrS
         hjCPGrBprC0vckzeWGDRDPcvlPfb1kOogbxuqf5wyW/3YFTOz9bWjGrY+IJvzt9ruH4+
         OrTotZNYJ4qEZ7hAAsRrurh5+p/81d6geFye5s5AQ3fSU+fVj4ujwC8ApsG7n/QNmdZV
         wryqoHW4kFHDxGKJjIW+wJOm9FHu4K53bP+vBedHnzHiRwSQG1zJV9qNjyHCj5Lc/21n
         cSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728958267; x=1729563067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4d393RqsyL/BJ4Co9qwq0LGbkJ+IqpYMBLpcbUgTRI=;
        b=srrByPwBFc7W5N1YXMNQ0ullWpjNXbVdn7ZbjSJ9i+JTbAF7RSCtmpRbaBPNPvcTNg
         57nOOqQw4WXQeCWtVUr7LFH6FIwrnRZYxXuz85GYwygLGDGapXJRae3wWF+M7MYJzoME
         E5cnNW3HhhlUxBwC0xs1H7HJmsci+nwq+xZymt1Koc36YRoTNBztA5oWe09xBU5/hU0n
         a5kv4yvreT8Q2kKQYtotY+cj77Xw+81nk9mx4eamrDvQCHRP3JdM1qLKYi+ZGpZbL5XW
         vAgaZW9xBS9xeD1NFqOLA8olJ89U2HqIsQc/FUoub9xS95QC3hLKhj9n4rX8Zcmh7877
         u6MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqxpQqGygfWTXes7oIgmqZ11UfZeNhSmEiwkmoa90rsdgJgm23eOMpyJVYs+j30uNT+31frJZlRSlH@vger.kernel.org
X-Gm-Message-State: AOJu0YyaYrybdZDFunpiEWbartTMNt2OcOkUsTb51ekwIbpvq0HMtqCH
	4pBv3UxJuxUj0/2qlIS4QEA9LhJxk7g5TWfg00c03xPXBQhI5AHZtcPrW7/Clatwnfij6ClyB1S
	duehWgcp8WmpBkbF+8ugYWriee8Q9UZG1xCnZ
X-Google-Smtp-Source: AGHT+IH2LRfRBm57PdBw/tS8q8+UtN+Kyr0mTZGba3MM4WXhOw4k5NEo7Tk1C6FhBp0+hTMOPWmhXG8Ppv2xTgArgLA=
X-Received: by 2002:a05:622a:5b8a:b0:460:4777:b060 with SMTP id
 d75a77b69052e-46059c777b6mr6458551cf.27.1728958266985; Mon, 14 Oct 2024
 19:11:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014203646.1952505-1-surenb@google.com> <20241014203646.1952505-3-surenb@google.com>
 <20241014165149.6adebbf38fdc0a1f79ded66b@linux-foundation.org>
In-Reply-To: <20241014165149.6adebbf38fdc0a1f79ded66b@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 14 Oct 2024 19:10:56 -0700
Message-ID: <CAJuCfpETusPzdjEg01zahF7NOStQJZmoM5Jabqd5tJpCCQrj2g@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] alloc_tag: load module tags into separate
 contiguous memory
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de, 
	mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, thuth@redhat.com, 
	tglx@linutronix.de, bp@alien8.de, xiongwei.song@windriver.com, 
	ardb@kernel.org, david@redhat.com, vbabka@suse.cz, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, yuzhao@google.com, vvvvvv@google.com, 
	rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 4:51=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 14 Oct 2024 13:36:43 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > When a module gets unloaded there is a possibility that some of the
> > allocations it made are still used and therefore the allocation tags
> > corresponding to these allocations are still referenced. As such, the
> > memory for these tags can't be freed. This is currently handled as an
> > abnormal situation and module's data section is not being unloaded.
> > To handle this situation without keeping module's data in memory,
> > allow codetags with longer lifespan than the module to be loaded into
> > their own separate memory. The in-use memory areas and gaps after
> > module unloading in this separate memory are tracked using maple trees.
> > Allocation tags arrange their separate memory so that it is virtually
> > contiguous and that will allow simple allocation tag indexing later on
> > in this patchset. The size of this virtually contiguous memory is set
> > to store up to 100000 allocation tags.
> >
> > ...
> >
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -1254,22 +1254,17 @@ static int module_memory_alloc(struct module *m=
od, enum mod_mem_type type)
> >       return 0;
> >  }
> >
> > -static void module_memory_free(struct module *mod, enum mod_mem_type t=
ype,
> > -                            bool unload_codetags)
> > +static void module_memory_free(struct module *mod, enum mod_mem_type t=
ype)
> >  {
> >       struct module_memory *mem =3D &mod->mem[type];
> > -     void *ptr =3D mem->base;
> >
> >       if (mem->is_rox)
> >               vfree(mem->rw_copy);
> >
> > -     if (!unload_codetags && mod_mem_type_is_core_data(type))
> > -             return;
> > -
> > -     execmem_free(ptr);
> > +     execmem_free(mem->base);
> >  }
>
> The changes around here are dependent upon Mike's "module: make
> module_memory_{alloc,free} more self-contained", which is no longer in
> mm-unstable.  I assume Mike is working on a v2 so I'll park this series
> for now.

Looks like the last update on Mike's patchset was back in May. Let me
check with Mike if he is planning to get it out soon. I would like my
patchset to get into 6.12 if possible.
Thanks,
Suren.

