Return-Path: <linux-arch+bounces-2768-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8AE86B6B5
	for <lists+linux-arch@lfdr.de>; Wed, 28 Feb 2024 19:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B691F2295E
	for <lists+linux-arch@lfdr.de>; Wed, 28 Feb 2024 18:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235A079B78;
	Wed, 28 Feb 2024 18:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="07Nj3u52"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6F079B7E
	for <linux-arch@vger.kernel.org>; Wed, 28 Feb 2024 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143523; cv=none; b=Gpj8fChGvY79HUFSBgljwN1ikAG8lu1PAVBH3/aRNaYoQzqCfx6mpRHNHzMRHutujkCBVBZW3/4qmHw+l7it7y4MoM9/RKdtCzADFHdHUUQSnV1twoqxIYT31TZ15Toc4zmUbbbdDRTXchGeOLlXZi8m7Q35vbeofQ7E14khPX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143523; c=relaxed/simple;
	bh=M5RWLefMMZcrjC6ohvg7ZMSlCbzmM6eu4zL9kM45cas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSqyJoyqsoNWvVpcrtPwbKSMOS5yb1W4zx2Ab0zmUnBJVvWB+bc77qKJNipNDUxMYF5Cmymbr2IQaJckR3g8fuipE2qXoDFt8lQPuAITW5OBJuNdBdU64wYml1r5IsV9cUbTOEgDKQnpHPiE/qAAAvZSvJuisQsA3rfIArKAx94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=07Nj3u52; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso68573276.1
        for <linux-arch@vger.kernel.org>; Wed, 28 Feb 2024 10:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709143520; x=1709748320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5RWLefMMZcrjC6ohvg7ZMSlCbzmM6eu4zL9kM45cas=;
        b=07Nj3u52kU5HkNbHmQi6GSJlFvm+hwSmH23kU9J3YIdBUAZcfVKU5HQ3RCYnYic0v6
         QLRHfuCjI9k+jiAG3w+DoaSoumtOezIBDz1r8Kz8fHtyP7r7SZx31n43NzTdmop/PO2A
         8mM/4NeVzeoWdN0ez7/q13ruSZDGpAfWv4C6Jt0Y0ZDccQI15hWg5epL5i0sGXGwRR2Z
         QyHgs217g8YnqC7+n46M+BhjmuNXp3pKxFMqFRf5dLwy6cELVZXPEu+Ogd7PlX5F4r/Y
         GY/qYMx/nxnzCGNBgbHCEaaY4EPWcJbvRoW29RCrocuMaX6hzZjZnlqLuzHzfEmrYQi9
         uEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709143520; x=1709748320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5RWLefMMZcrjC6ohvg7ZMSlCbzmM6eu4zL9kM45cas=;
        b=d85s+zXVgpS0jwXg4FmmILHEd2foJhclyrtAJqDh7/f9Ma4laCWsCF4yQbdYza/Wr8
         ABh8rJ5nvgj2H22fY7Ah9SzERXnFMPrWpP+q4y9DLKQJ0WcKAJiamwXYrBCG2F8uWrWT
         aNihUzDEspqsjOQoQeOeuLSu9QzYnJ8/8vQMRypqwr43DQ2xdow29feDJX2cUgPIVjWr
         dvffGURZSVezsCthJY7+Ko+vwDMdSt3C/lRaXe2vI4vh6p/8in+04GqMMvCmpkJfm5wU
         aNcfSNAhX0rMCGgu/XJv3TbnwcI3U56N5VE8DkAo64stWx/KEB6xumUvSgPxzc3D7uAZ
         Hejw==
X-Forwarded-Encrypted: i=1; AJvYcCVytTSY080dCsgBdfdbReCay2ox552s0oArJyiRKReJYoCxnK9qNbfMVBZcs4sBLrPZUmgDeiPqXPAw+dhF6E4E61/N7qcOIY/txg==
X-Gm-Message-State: AOJu0Yzk41tPKO2LXOe9lbkVp10wrJcy1FBG/3RTToncimGETzpRodVE
	N4dliId4o7/bHxULKoBVYy6SmdRB9/Nh8QCsoDI4fZUtC7ncSEK0DTwyFGafKS3fHXautYIPXtA
	Go8RRTr/IbCClWzXEjnjRbbXohiY09bpz0qP2
X-Google-Smtp-Source: AGHT+IGXC8lezvXLfyLFgurkGO2/8+xbMmbLbWU2Dhx0X772e49nOZcLM0/mejcqQER1kvdSNB2vVup4Slt3VEZ2U4I=
X-Received: by 2002:a25:4687:0:b0:dc2:398b:fa08 with SMTP id
 t129-20020a254687000000b00dc2398bfa08mr21101yba.31.1709143520037; Wed, 28 Feb
 2024 10:05:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-15-surenb@google.com>
 <1287d17e-9f9e-49a4-8db7-cf3bbbb15d02@suse.cz>
In-Reply-To: <1287d17e-9f9e-49a4-8db7-cf3bbbb15d02@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 28 Feb 2024 18:05:08 +0000
Message-ID: <CAJuCfpGSNut2st7vKYJE7NXb6BPjd=DFW_VEUKfw=hGyzUpqJw@mail.gmail.com>
Subject: Re: [PATCH v4 14/36] lib: add allocation tagging support for memory
 allocation profiling
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

On Wed, Feb 28, 2024 at 8:29=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 2/21/24 20:40, Suren Baghdasaryan wrote:
> >
> > +static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)
> > +{
> > + __alloc_tag_sub(ref, bytes);
> > +}
> > +
> > +static inline void alloc_tag_sub_noalloc(union codetag_ref *ref, size_=
t bytes)
> > +{
> > + __alloc_tag_sub(ref, bytes);
> > +}
> > +
>
> Nit: just notice these are now the same and maybe you could just drop bot=
h
> wrappers and rename __alloc_tag_sub to alloc_tag_sub?

Ack.

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>

