Return-Path: <linux-arch+bounces-7022-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B0A96C430
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 18:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87B48B2184D
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 16:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014671E00B6;
	Wed,  4 Sep 2024 16:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4ltTx5rw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668841E0088
	for <linux-arch@vger.kernel.org>; Wed,  4 Sep 2024 16:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725467742; cv=none; b=TJRF+kMOpg0E9e188wvmu2bQFFCxqC5CPW8OZ/v8vVqibk+UfvaTadHeqiNB8yIK78LjC8rqjQRlfx9diBhFJmKXaKl/9t3+AI2UKIoSvDbn4g1OxEBIaP1v0bvDSiILH7Al1qqhiqZL8dclH9xVZpi84+3JG0/5GPelphm0T4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725467742; c=relaxed/simple;
	bh=jjSmm3IMrrNj7/yAkHdR/SNScgpadLXLJ9+wQvAD/oE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TuI56jCuytX5pj6voe71bDlKVoyrCbvIP1QXV9teWd3vmXM4apMeJ6GR8aGbtVmIsP+vNKY83qeyGgCWoGdXLkYTUEXSkJCM8T+o/ljfya6HUwWGDigmrxLRI+pMUols1KjRKtha5mgu7bLNLOYCBv1G7cY6YQ5po4ONYcUQy5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4ltTx5rw; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4567deb9f9dso292471cf.1
        for <linux-arch@vger.kernel.org>; Wed, 04 Sep 2024 09:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725467740; x=1726072540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVVWyulqkWcIIt3eaXgVpDF1IQ1j/qkoZQP/yErWHv4=;
        b=4ltTx5rwoiymj2i5iNgvtgATQt+lcOHKEkNw29JggmO8sGgQpPJFTJxLllCuB7sk20
         ztdRkKaLPjfttKex+EWnPGoeczVweLHKWRHAWbH3GXHL3yv6EWPoh9VkN7lIMaPJRP5Z
         OV0WOoC0dJohL8lsFK1BYR7t1VVCMvFO79aQBI+fQo7qcyzUuyCBkTO2v0v3SX9h/ZD6
         +JMrsD0Ve0mrlIrgjhpEZ7N0T61iy3Qu9W93WxHbD1V56ddf+4wLgbQYS9jeA/0FTVza
         ToByxofhNmnVQgI6TnoJKbyRv5DLtwD0i3IYbQvIdzQnhMCkd3nBTbMFkmLIktm4QsEF
         NNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725467740; x=1726072540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVVWyulqkWcIIt3eaXgVpDF1IQ1j/qkoZQP/yErWHv4=;
        b=AnybOkx0N/GyRMzYVo1WmJhDUQbjJvdDGeurx+D5ISWA71nRaWgZOCj5ASzeKbjvrw
         OsMN4Ent8WZIhGosXb5spyRCBhXBneE/CeQ7bO3wVu16LUREES6PWIceaOdnL1tEMpJx
         V4un7zkIYvpB5AphxmBxpWPmAWI5EwjZKW4OaHK5ZddvhzIQ3JZPQkVIFolseM/AK2ly
         il5scxZbelrQRB6/zVJNU9AdLZcg+f9gBJI6Z8YFnWdLIxUNxBefr17cn8XYKzS5CPeI
         VczHBCu+opTp7O8kJ1q/shqHd2Lr3xij3GAFoHE9Hd0J2wYvbvI/42STHvh37xETrAMe
         EQqg==
X-Forwarded-Encrypted: i=1; AJvYcCUM+ynPMzBV+Je+DhFIpwO6cb6qbzNvbOqLptusEYmVUgtunSAoqQew9Y2LiZH++8W0tU8v3jObgU7C@vger.kernel.org
X-Gm-Message-State: AOJu0YwohyvkuApJN3JHP1ECfgeWiyutR38iSi107DD8g20dlxq1zAKB
	j8pL/gTykwFTE0Pr1VpSqf+RXNcPKMdwMjm7aiD4PhfxiXaQmKPkd4l38s5jLuZLHw76CbWjn6n
	IKUej6JZw6xSjxSBv1bWpQNyh4mc8SAD2stQ9
X-Google-Smtp-Source: AGHT+IFRosENkf6QvFVAL8Dd3CPNJYACxr4z2huPX4vhkPrrEkzPkP3ySL6yLGZMIV2DOLm7ZQ5Q5fQT5hqm0DOdCB4=
X-Received: by 2002:ac8:5993:0:b0:456:7501:7c4d with SMTP id
 d75a77b69052e-457f7afcf16mr3378481cf.9.1725467739803; Wed, 04 Sep 2024
 09:35:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902044128.664075-1-surenb@google.com> <20240902044128.664075-6-surenb@google.com>
 <20240901220931.53d3ad335ae9ac3fe7ef3928@linux-foundation.org>
 <CAJuCfpHL04DyQn5WLz0GZ_zMYyg1b6UwKd_+8DSko843uSk7Ww@mail.gmail.com>
 <3kfgku2oxdcnqgtsevsc6digb2zyapbvchbcarrjipyxgytv2n@7tolozzacukf>
 <CAJuCfpGbHShimigbm7ckT76hK9YUc_gy0jb9e5ddq7yjqDKOig@mail.gmail.com> <yuu6tc2gxqp4ob2su4btd3f7gsnwmwtgrh2em7wwihajdfv2fj@vrrmk4sx77vp>
In-Reply-To: <yuu6tc2gxqp4ob2su4btd3f7gsnwmwtgrh2em7wwihajdfv2fj@vrrmk4sx77vp>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 4 Sep 2024 09:35:28 -0700
Message-ID: <CAJuCfpGPvsQamSdQecgqKXaEkkHLLOFbhiMwyo15aE_w=PNZFw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] alloc_tag: make page allocation tag reference size configurable
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, corbet@lwn.net, arnd@arndb.de, 
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

On Wed, Sep 4, 2024 at 9:25=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Tue, Sep 03, 2024 at 07:04:51PM GMT, Suren Baghdasaryan wrote:
> > On Tue, Sep 3, 2024 at 6:17=E2=80=AFPM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > >
> > > On Tue, Sep 03, 2024 at 06:07:28PM GMT, Suren Baghdasaryan wrote:
> > > > On Sun, Sep 1, 2024 at 10:09=E2=80=AFPM Andrew Morton <akpm@linux-f=
oundation.org> wrote:
> > > > >
> > > > > On Sun,  1 Sep 2024 21:41:27 -0700 Suren Baghdasaryan <surenb@goo=
gle.com> wrote:
> > > > >
> > > > > > Introduce CONFIG_PGALLOC_TAG_REF_BITS to control the size of th=
e
> > > > > > page allocation tag references. When the size is configured to =
be
> > > > > > less than a direct pointer, the tags are searched using an inde=
x
> > > > > > stored as the tag reference.
> > > > > >
> > > > > > ...
> > > > > >
> > > > > > +config PGALLOC_TAG_REF_BITS
> > > > > > +     int "Number of bits for page allocation tag reference (10=
-64)"
> > > > > > +     range 10 64
> > > > > > +     default "64"
> > > > > > +     depends on MEM_ALLOC_PROFILING
> > > > > > +     help
> > > > > > +       Number of bits used to encode a page allocation tag ref=
erence.
> > > > > > +
> > > > > > +       Smaller number results in less memory overhead but limi=
ts the number of
> > > > > > +       allocations which can be tagged (including allocations =
from modules).
> > > > > > +
> > > > >
> > > > > In other words, "we have no idea what's best for you, you're on y=
our
> > > > > own".
> > > > >
> > > > > I pity our poor users.
> > > > >
> > > > > Can we at least tell them what they should look at to determine w=
hether
> > > > > whatever random number they chose was helpful or harmful?
> > > >
> > > > At the end of my reply in
> > > > https://lore.kernel.org/all/CAJuCfpGNYgx0GW4suHRzmxVH28RGRnFBvFC6WO=
+F8BD4HDqxXA@mail.gmail.com/#t
> > > > I suggested using all unused page flags. That would simplify things
> > > > for the user at the expense of potentially using more memory than w=
e
> > > > need.
> > >
> > > Why would that use more memory, and how much?
> >
> > Say our kernel uses 5000 page allocations and there are additional 100
> > allocations from all the modules we are loading at runtime. They all
> > can be addressed using 13 bits (8192 addressable tags), so the
> > contiguous memory we will be preallocating to store these tags is 8192
> > * sizeof(alloc_tag). sizeof(alloc_tag) is 40 bytes as of today but
> > might increase in the future if we add more fields there for other
> > uses (like gfp_flags for example). So, currently this would use 320KB.
> > If we always use 16 bits we would be preallocating 2.5MB. So, that
> > would be 2.2MB of wasted memory. Using more than 16 bits (65536
> > addressable tags) will be impractical anytime soon (current number
> > IIRC is a bit over 4000).
>
> I see, it's not about the page bits, it's about the contiguous array of
> alloc tags?
>
> What if we just reserved address space, and only filled it in as needed?

That might be possible. I'll have to try that. Thanks!

