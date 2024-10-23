Return-Path: <linux-arch+bounces-8456-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2BB9AC351
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 11:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0722B25397
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 09:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F4B199384;
	Wed, 23 Oct 2024 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kEm18jp9"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC26D1662FA
	for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729675041; cv=none; b=TNkxDbxBVldihcuRFX8fJ0d+u/trXydYL9zMFB9LWi3N/3yAsSilH0gLhILeVkdrfADAIsI2wgjb3zv3jDJdyGEchaZyXQcyEptEQunn9ftkuHTh4lFTm/n67g0jWgqjqMFCKfw/dstB5bpqERHgzRB9bpjsd5p0mRLyutGHCIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729675041; c=relaxed/simple;
	bh=wtB++VIztt5HrzVDtGHAG03WXfiePjTR9YlbhZgm7nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xg1LfQ8aUuqshYbxf0/pezNv8IboEGrBwUri3v4E9lcmMiy/9Iqg8ukLiBMGu0Tlwfq3JJUvR+Wc9a/5GvsxhvAuNw670IdhMlh5TXJs5W4a6XbyjoWsT/buY1pxwjBmmXqCvE5QieHig/tY7ILBI35f1tsbZfi6vOtI+I1w4kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kEm18jp9; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb5740a03bso72927271fa.1
        for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 02:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729675037; x=1730279837; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wtB++VIztt5HrzVDtGHAG03WXfiePjTR9YlbhZgm7nk=;
        b=kEm18jp9oVSa4aHpLvgQY6kkTT73NBiru6GfBDn0PIb1CnYcKvrgbjPmCfpGiDr+kG
         4vehjsYwxn69krYfkMutCZTjDHevYompOb5glfhqBTiBqFpnh7BugBXV9++nmBBsmW2C
         XXF8GYJFm1zj410ZUqDDrZYCN2S8LkNfFNs/r/kYTbkJnPlViaBwSin7aFQ0x8XbkqLO
         DN5VXy+GFMAssCOX3hPS2QmtJsaCle6S3+zkKbN0TVVgL553OOihgbNiH4TcI0jmdfnl
         r1Ul2TiDbNzkPvif5eMOEl9D/LQlhH2Y46DW/9MQucejzekOqfR6soZXtks9S6eVCPeu
         A0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729675037; x=1730279837;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wtB++VIztt5HrzVDtGHAG03WXfiePjTR9YlbhZgm7nk=;
        b=JSJITujqHHnoDRkRcY0k9LOdqcYEZmhiK6eFzIf43da/kZQJISdO4ZwLq/umOsOKjC
         sHn4aWt/P3SUO2eHDdT/0foIFSeP/xvycmOHN+1AEjdGkM0u4Ezz1Z2MGh14kV6c+fFF
         y4kBV3qD+a4A9FIA7Sh7NNV0EiBU1zHw5rC5+Kzii+vJUiqxlCRmfbhuJsDENhPOJiIV
         Bdp+TzgSOE7uySwrri6IKqHfp2c+ML1N59M+P0/zCxC9JRmFP+fmc6UOpM7zdgjmGaQP
         OmmnqyN4cDQ21bw5PdK8yDcRH8lMeL0C6GhnRy5Qis4pQJRvVLIsOwRqas+HvzFmvYcj
         i/YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM148UssjtvJL8ez7rk1TEpVfP+1oR5D1e8ZMKUY8ICIOtw/AZMTgzwxr9AOS/KgGZwX8xfI8Vp9/Z@vger.kernel.org
X-Gm-Message-State: AOJu0YwpTIFaOZWxQxRMciu7VyzahP1MYdklRAscDQBmooOmGUAYZuOi
	neLYoZ3NMxDdn3YeGs8Ac5GQgv5gGf0vadC3eGpr3VS9hGiyFMdFhYXS3GdkpQeHnUMLRT0hGCK
	Ee74aikhBwX+w5Sq8eIUYf+ec1AAJVLc8A/RS
X-Google-Smtp-Source: AGHT+IFvkPWDLHQT3Gtx5JJGGOJecwZ7B/rbkd7cgrlXZ9fP+lFzPxCiaYSOPYzYujteUjqgXjdomewJxB+DT79mLAc=
X-Received: by 2002:a2e:a9a6:0:b0:2fb:565a:d93c with SMTP id
 38308e7fff4ca-2fc9d33a85emr9429421fa.1.1729675036276; Wed, 23 Oct 2024
 02:17:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87a5eysmj1.fsf@mid.deneb.enyo.de> <20241023062417.3862170-1-dvyukov@google.com>
 <8471d7b1-576b-41a6-91fb-1c9baae8c540@redhat.com> <5a3d3bc8-60db-46d0-b689-9aeabcdb8eab@lucifer.local>
 <CACT4Y+ZE9Zco7KaQoT50aooXCHxhz2N_psTAFtT+ZrH14Si7aw@mail.gmail.com> <b1df934e-7012-4523-a513-d3d1536b7f72@suse.cz>
In-Reply-To: <b1df934e-7012-4523-a513-d3d1536b7f72@suse.cz>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 23 Oct 2024 11:17:05 +0200
Message-ID: <CACT4Y+Z=fjoOxn8NY8kYJd2CC1SkmjkmAmqSzJbQiU04G=BEvw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] implement lightweight guard pages
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, David Hildenbrand <david@redhat.com>, fw@deneb.enyo.de, 
	James.Bottomley@hansenpartnership.com, Liam.Howlett@oracle.com, 
	akpm@linux-foundation.org, arnd@arndb.de, brauner@kernel.org, 
	chris@zankel.net, deller@gmx.de, hch@infradead.org, ink@jurassic.park.msu.ru, 
	jannh@google.com, jcmvbkbc@gmail.com, jeffxu@chromium.org, 
	jhubbard@nvidia.com, linux-alpha@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-mm@kvack.org, linux-parisc@vger.kernel.org, mattst88@gmail.com, 
	muchun.song@linux.dev, paulmck@kernel.org, richard.henderson@linaro.org, 
	shuah@kernel.org, sidhartha.kumar@oracle.com, surenb@google.com, 
	tsbogend@alpha.franken.de, willy@infradead.org, elver@google.com, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Oct 2024 at 11:06, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 10/23/24 10:56, Dmitry Vyukov wrote:
> >>
> >> Overall while I sympathise with this, it feels dangerous and a pretty major
> >> change, because there'll be something somewhere that will break because it
> >> expects faults to be swallowed that we no longer do swallow.
> >>
> >> So I'd say it'd be something we should defer, but of course it's a highly
> >> user-facing change so how easy that would be I don't know.
> >>
> >> But I definitely don't think a 'introduce the ability to do cheap PROT_NONE
> >> guards' series is the place to also fundmentally change how user access
> >> page faults are handled within the kernel :)
> >
> > Will delivering signals on kernel access be a backwards compatible
> > change? Or will we need a different API? MADV_GUARD_POISON_KERNEL?
> > It's just somewhat painful to detect/update all userspace if we add
> > this feature in future. Can we say signal delivery on kernel accesses
> > is unspecified?
>
> Would adding signal delivery to guard PTEs only help enough the ASAN etc
> usecase? Wouldn't it be instead possible to add some prctl to opt-in the
> whole ASANized process to deliver all existing segfaults as signals instead
> of -EFAULT ?

ASAN per se does not need this (it does not use page protection).
However, if you mean bug detection tools in general, then, yes, that's
what I had in mind.
There are also things like stack guard pages in libc that would
benefit from that as well.

But I observed that some libraries intentionally use EFAULT to probe
for memory readability, i.e. use some cheap syscall to probe memory
before reading it. So changing behavior globally may not work.

