Return-Path: <linux-arch+bounces-2661-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7E485EDBF
	for <lists+linux-arch@lfdr.de>; Thu, 22 Feb 2024 01:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82900284CCD
	for <lists+linux-arch@lfdr.de>; Thu, 22 Feb 2024 00:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809956FB5;
	Thu, 22 Feb 2024 00:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="u6MzgmLQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E1FEC3
	for <linux-arch@vger.kernel.org>; Thu, 22 Feb 2024 00:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708560778; cv=none; b=qjVq8TGnpm7vaO9rrIXyr1R4XwSK4uFzWLo7votRYGLZ3S7d6Olk+iYKED3fE3X3zapbiHIQLj3+DO+lWpFH8kuL5sBVzPnNp06f8XytrxKOSKgMCPmrH7yQKvPLi6nv56MmU2L0q4JojR2cFFwubmKlw95TS+vZ5mgSMEhLBHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708560778; c=relaxed/simple;
	bh=yPsvw9vJzS5OOehh2obqY5C9ccmf1AALBE4na8IWGEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LnoiFhMco08DZaoKqYWSVDhCBW25odnRvECoShZw6Snsitpt/fUti+mBHfN90J3Zq5zQqBc4AVFN/eu93YgsE/OSholZq6cEFwC5W/IzF9kWfJynRahjvxoBb3ih67rwhMXzkcQrYfTP4pBgd6U/B1AKQ37bxmhFGBU+g/KASnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=u6MzgmLQ; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-42dc86cc35dso6148901cf.1
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 16:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708560776; x=1709165576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPsvw9vJzS5OOehh2obqY5C9ccmf1AALBE4na8IWGEE=;
        b=u6MzgmLQHfOebLxBK3vq95PpgzpVyRoBGEcnq8JMV+Pt8FGSWmlAh2hfIioBlyCYSC
         hqyrh19LMeFU5IOtb+lnUbXtbjscpRxjjRrXJRRZs4XF1+uOlSuDQEmhWkGSDqdb2oPR
         nvXlPVHnD+zlVdfmkdxtKfibDp5Da97/9sSjWBSuFRpzBLozYGilxEwIVSsftN91kFuh
         rYicFEHecReyhUKLRgFk8VgBpv1rbqlI6g+fAxEjvTb2AiGftkkGhBQZBhJqkJNfNmpc
         PwA9mhxAVv0p/KuSrzB9VLt2DFF59hi6k+tYXUeOnH7sKgatrJe5V7y9sXAwMNlXFx6m
         2abQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708560776; x=1709165576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPsvw9vJzS5OOehh2obqY5C9ccmf1AALBE4na8IWGEE=;
        b=QY5YZ2n5jA7pgThSOSMiP4E9EeerOhNMRtWcpe1Lp8rY+p51N0ze1we1Jp40SviV0M
         55Ju1Lvx0xXCngWTsxZFKKfYRnaCA+PgSkdBUr8ZQfljAyrAYe5VFtNhPfJjkqrRtJOw
         Pvjs1QsuWAaTtfm+JyEkKze1h4TjxWBaCltWlmjN+uxwcKtSmD3IFT+jJzBslcz1FRmL
         AYysoE9bMu6HoC9lMnjc+mcDJVriw5W8RXHRgYMoMasOoupUkA49BSdnoyjWtJRkj0Tb
         sdt5BX+iDLrzNUWMeDME2sOTdolu/4J1W6x3fUmN9FwcvgdzAy1Bh6bWkJKoyutck5ic
         7k0w==
X-Forwarded-Encrypted: i=1; AJvYcCXLGckcyD+rJr2TxE74CKBbI4CfI25yX50h0ABdYch4coQ+DbGeOlz1an3orSIJhgumjjJgUATqcC+CaLnCXBN7t3xTAt6JGR2/gw==
X-Gm-Message-State: AOJu0YzuxP7FXhEhzK0j2CVPoSaY30/UTzNIH8fDKk3+PFevuCueUito
	yV1EP63UjCZhaZd6+fEA1v6lLEMc5q8LlU2CFYzwC3Ylw23qnc4yfxZ05IhMSJw5o1+zpEwVAEX
	OPlJSd7bDX6J/FgBIOlqjULnxVbM0KnfPp4o/Uw==
X-Google-Smtp-Source: AGHT+IHC2jE3/DoAiHiK02zORvbTKUG6myX0k7i1f+aHTzOQJjz8xfPJY5H0xjNb5qm6LzazHkaY+DyA8GGq0QMoj/o=
X-Received: by 2002:a05:622a:1996:b0:42e:1911:93fc with SMTP id
 u22-20020a05622a199600b0042e191193fcmr11082250qtc.55.1708560775667; Wed, 21
 Feb 2024 16:12:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-11-surenb@google.com>
In-Reply-To: <20240221194052.927623-11-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Feb 2024 19:12:19 -0500
Message-ID: <CA+CK2bBBcJfgBU-O600Wx-2yHs6RUdhT+n0wsHtieU-rSHn-Ng@mail.gmail.com>
Subject: Re: [PATCH v4 10/36] slab: objext: introduce objext_flags as
 extension to page_memcg_data_flags
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 2:41=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> Introduce objext_flags to store additional objext flags unrelated to memc=
g.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

