Return-Path: <linux-arch+bounces-2469-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAAE858A8D
	for <lists+linux-arch@lfdr.de>; Sat, 17 Feb 2024 01:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FAA6B28DB9
	for <lists+linux-arch@lfdr.de>; Sat, 17 Feb 2024 00:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869BC4C70;
	Sat, 17 Feb 2024 00:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FAXamuuN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760B746AF
	for <linux-arch@vger.kernel.org>; Sat, 17 Feb 2024 00:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708128531; cv=none; b=rvQiQyz+PJMlrhYtezJljEoZ52v1GE5D/rl6xiK2j2pf/Um8iyVNVuQcTzkv2LFgQmGtcn1lqIvSzG2ff7Eq37m2XYjHaV5xA0B0KH82nqzuckNGkA8l1TE/V2jY+p0ChzshgHGfCiAB2ABd2kLiPEmZKSmz9VwKevQwVb81wXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708128531; c=relaxed/simple;
	bh=plU6YhEkyhkbfKgfjHrx3qjSg7IHeMnpyb2DBIHN9Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsiToyr4Z+fuvRPGrMMVWZuBDgNR51r1Gs18NxnlbjXljeMxFoKkQJBMbt7Z1NpfmXGCi6LfFyDCYlsun/U1XLl44qmKQQxwulYd7kgUhtFWyqGR1nivv66Fffg4qHS20LAKFn0X4qE9HkfMnk8S19InjLuIgnRpaneHPk7otNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FAXamuuN; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e10e50179bso1944038b3a.1
        for <linux-arch@vger.kernel.org>; Fri, 16 Feb 2024 16:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708128528; x=1708733328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S1txfacIBFBZ/O4tjcxs+bfhiTiZyaDvYXwzko6DwYw=;
        b=FAXamuuNv/zQzAsTiczfELCzSiTGSx1i/N2NTp0zupFLDQsEIxjlp36niuZ2AP+LXG
         uwz2r7+1poIRzYwVXiE5dopiurRDvewCRlMU4JDMQz2+foC3MvDRrVkWlpAZZy83/LUv
         Teb8jXfQwKklL/wDFlt/TtF/74WCF3iwL7PHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708128528; x=1708733328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1txfacIBFBZ/O4tjcxs+bfhiTiZyaDvYXwzko6DwYw=;
        b=IZrEi3vRRlgGiijDUE59RrVBckBmo/8yNAuO8yvkbWEKgpGRTqnmPhLuX422uyXgSX
         /jIyTMuAI/sRuW+iNnCpnAW8oXjKSOhs2K5XZnqSgetkOWdjqb1YcXuVMBGAa2/psio+
         PbWsCcJ2sQD+NMtulZCzK3GEnX1mUukwyIyG8iGQZ/z9e9OD9B/zQiJSJLHts/qObJTP
         w/Aw6EF2O04BazajwMZKJIxSuOIFWhLI3JOyA53NDeyq9kSGkmkJct70oeSCH2SXWoJU
         KzdCCepPWDfd68ThuuQ8YcvtJ7ewp/3xGWGwKidYci2BWOdvuHGXRvU+nJZrXAkuJ7+J
         Ae0w==
X-Forwarded-Encrypted: i=1; AJvYcCW2Vrg/s6nxH9qeROFGObo06tKmcevA2T5Jzj8LGfVSOUnX2xg8dcHocpYgjojy88DNyh9eQQqpdZTHDioKdxZYuOUEfBczDOHwFQ==
X-Gm-Message-State: AOJu0YwO9KO3mPMlWmwO7hrCDa967OBoBHhd8CTHY96HP/8F57AjV0Gq
	QNOYdmJKbZ7QqPEBcAsUA2VWRQWgG+S4Inq0qSAyD+dcJd1UygiAd1tURiyOsQ==
X-Google-Smtp-Source: AGHT+IF+QQ/9SK4sTlRF7CviXNWL9OdNoE9iSFRsOXGRftVqcaAIHIRUQhIt4OYE39Err1qxKn5GJw==
X-Received: by 2002:a05:6a21:3183:b0:19e:a9e6:c05 with SMTP id za3-20020a056a21318300b0019ea9e60c05mr7276163pzb.43.1708128527870;
        Fri, 16 Feb 2024 16:08:47 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z3-20020aa79903000000b006e094bf05f4sm487826pff.213.2024.02.16.16.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 16:08:47 -0800 (PST)
Date: Fri, 16 Feb 2024 16:08:46 -0800
From: Kees Cook <keescook@chromium.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
	roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
	willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net,
	void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, peterx@redhat.com, david@redhat.com,
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
	ndesaulniers@google.com, vvvvvv@google.com,
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
	elver@google.com, dvyukov@google.com, shakeelb@google.com,
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v3 13/35] lib: add allocation tagging support for memory
 allocation profiling
Message-ID: <202402161607.0208EB45C@keescook>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-14-surenb@google.com>
 <202402121433.5CC66F34B@keescook>
 <lvrwtp73y2upktswswekhhilrp2i742tmhcxi2c4gayyn24qd2@hdktbg3qutgb>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lvrwtp73y2upktswswekhhilrp2i742tmhcxi2c4gayyn24qd2@hdktbg3qutgb>

On Fri, Feb 16, 2024 at 06:26:06PM -0500, Kent Overstreet wrote:
> On Mon, Feb 12, 2024 at 02:40:12PM -0800, Kees Cook wrote:
> > On Mon, Feb 12, 2024 at 01:38:59PM -0800, Suren Baghdasaryan wrote:
> > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > index ffe8f618ab86..da68a10517c8 100644
> > > --- a/include/linux/sched.h
> > > +++ b/include/linux/sched.h
> > > @@ -770,6 +770,10 @@ struct task_struct {
> > >  	unsigned int			flags;
> > >  	unsigned int			ptrace;
> > >  
> > > +#ifdef CONFIG_MEM_ALLOC_PROFILING
> > > +	struct alloc_tag		*alloc_tag;
> > > +#endif
> > 
> > Normally scheduling is very sensitive to having anything early in
> > task_struct. I would suggest moving this the CONFIG_SCHED_CORE ifdef
> > area.
> 
> This is even hotter than the scheduler members; we actually do want it
> up front.

It is? I would imagine the scheduler would touch stuff more than the
allocator, but whatever works. :)

-- 
Kees Cook

