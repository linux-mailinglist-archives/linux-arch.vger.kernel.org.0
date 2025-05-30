Return-Path: <linux-arch+bounces-12151-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 466D5AC8974
	for <lists+linux-arch@lfdr.de>; Fri, 30 May 2025 09:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C62A244FB
	for <lists+linux-arch@lfdr.de>; Fri, 30 May 2025 07:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F1321578F;
	Fri, 30 May 2025 07:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHEgB0C0"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA18C213254;
	Fri, 30 May 2025 07:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748591565; cv=none; b=HRMkHFd06ylTCnyTgXLTahmtMzgHkgQ0p0SAk/P8lLnh7+zyN2O1/Of+yoHTXhAu9jXIc4wyLXXr+22n6Sy4oCtUip9DYLUjUX4Be7do+F3m4z4RgTPPu1pUDc03IQsBdyO3Er43IoDyjsXl16xGL0dDAidKWsVSYoAZpd6uqzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748591565; c=relaxed/simple;
	bh=r8IP4NCo5XgD5PidO3HPYahdoy790r8YukrCMHSEkBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1QFdKE1TXJJiTnCv7hAoNYOgNV+8wDgcdE0LZ4m/VCSFZ2uZOvSVJKdikuRfJkBo+vqwTJrpBQG/utm+x3TS9D2c3tL3RmgpVE1wfhbIhY+7tR2xr3D17KIqTmRFCp7r4HkKab4X6Ma2Tq9gk6DpBCKEZr+EUmHt1JwCrTLUjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHEgB0C0; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-86d587dbc15so1212772241.1;
        Fri, 30 May 2025 00:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748591560; x=1749196360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKtlyRzdj1hzUN4lNvAG8wP0iwSwojEvBGmYnQtcdS0=;
        b=MHEgB0C0dp/QTi+0x1+DDsZaOiXUVHLwi1rCau2ZthJcptc3EGfhdUwVrWkI4FIb22
         wwZKHmQR3gYauwL/GEgY4tHnP0qO0hit4/FUZK6bMvtYY/eoZ77Yp5XkMVLRmGPlFzSw
         t9lML+dS5ryH1dCoNKdzSXEE/5Z2Vde8Rj2jALm8mtChhmSWIPKaZnFnWW0N6pkbPDN8
         I6TQIGz3Q22LPqOOR/XYvNXcaM1FalqKnMZaEn6l1pYGM5Ls+8NJDYh+YOqNc9n9ZrPG
         HxpjsT4ZXguwdjIugVIcm2E6HywYTmBWC6vizi66+dbl6V//YQTSlnZ3cDfJ+ZuVDerK
         CU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748591560; x=1749196360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZKtlyRzdj1hzUN4lNvAG8wP0iwSwojEvBGmYnQtcdS0=;
        b=M/qKxkAtR7qwXXxa9uUUTS50cfNIazMj6lkl1y44TtTFJqfS9jjlNpUTWn7Z2y60fA
         qN9gnuJbylCG+UAgWr8B2KasYyjpc3rUV+zh7hI/L0tI7sms3pTO6qf1qQLQSzRE0h+9
         Xgz3nkRcjFAo7SO5pBudoV80KXCRreGEaqT48S3RkWtUH7nNepM6E58mnLqFwN0E3nyj
         16skYpf3BciEsvHmE1xQPBpTsWj3n9Sz5KV92J+1RdVj106VO2UPpB7B+dRz/JlRlUae
         8teWt68Hh8YB96FF/ovtlzKzHkwq3NIhJsM3/xEFWGdC4f4O52Vq00WKr/u+abyOq9cy
         vN+A==
X-Forwarded-Encrypted: i=1; AJvYcCVgIlGUXNLVfkmbA3fDDLWhPt3pArgsI1mIrucZdAOa2X2Q3Gm9RRb6Clvw+pUFyzCNhl/NOUBSCig=@vger.kernel.org, AJvYcCWlvqaP7fcJfNbCCq5zck9JVgfSB63U2vvrn7ZlM0P8a2ihlQO8mmCqdNLy/GUOBZ5VBhrKywX9xkRisw==@vger.kernel.org, AJvYcCXb+ofFuN9cUjIWhiK8Rlm7SnmqsWSpp7b/7kaNhhEMQM2K52YH51zv3ustu83Vkk7CWovyhpFgd7xYGARr@vger.kernel.org
X-Gm-Message-State: AOJu0YzIAtfKR7rZQiU0q8k55w9OA0jS1a/qzjS05szaOLSqU415Cbsd
	/337JmTqw0DAFo0LjFAohmvm4ZROxDv/KAWrdr4Wfp4/fHNEhg8e/j8aXZ9Si0A3uLfFpWKclVc
	l10djNp6NmqZ2Za7ZV/rDNKMY+Ae5KnA=
X-Gm-Gg: ASbGncuIi+ZoyGYMN9aM7Ayu8DzLaSQyaJlH93bWcJqgPrlUH/KuRuJvQqFpoU8Mtqq
	T9TfgYbe93fmzR92nc5l2KftetaoEZ7/wKwFkxJ5Bd6HESfBXV4XeuyxSZzHtiR1eisEqEpjDnE
	WcSWP403KuGJOi65tUJRuCR2PSgA8sc/CujR1XYjV/bUvp
X-Google-Smtp-Source: AGHT+IEu0wvQ5rhdA7BJLa2LTFM56TLWJzqwagC9Vg/DVegxmBIqU65ZnQ+yPR7TraWX6oDXCxLvKV4jW7/+CnRcrpk=
X-Received: by 2002:a05:6102:c89:b0:4e2:86e8:3188 with SMTP id
 ada2fe7eead31-4e6e473792bmr1885640137.0.1748591560495; Fri, 30 May 2025
 00:52:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local>
 <aDh9LtSLCiTLjg2X@casper.infradead.org> <20250529211423.GA1271329@cmpxchg.org>
In-Reply-To: <20250529211423.GA1271329@cmpxchg.org>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 30 May 2025 19:52:28 +1200
X-Gm-Features: AX0GCFtLq2Vrtv-b7fSZ_FGTqJuT5ElgRYnChnL5uE5cw7If3ZrbkNFfQmhEunI
Message-ID: <CAGsJ_4yKDqUu8yZjHSmWBz3CpQhU6DM0=EhibfTwHbTo+QWvZA@mail.gmail.com>
Subject: Re: [DISCUSSION] proposed mctl() API
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox <willy@infradead.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>, 
	Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	Pedro Falcato <pfalcato@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 9:14=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Thu, May 29, 2025 at 04:28:46PM +0100, Matthew Wilcox wrote:
> > Barry's problem is that we're all nervous about possibly regressing
> > performance on some unknown workloads.  Just try Barry's proposal, see
> > if anyone actually compains or if we're just afraid of our own shadows.
>
> I actually explained why I think this is a terrible idea. But okay, I
> tried the patch anyway.
>
> This is 'git log' on a hot kernel repo after a large IO stream:
>
>                                      VANILLA                      BARRY
> Real time                 49.93 (    +0.00%)         60.36 (   +20.48%)
> User time                 32.10 (    +0.00%)         32.09 (    -0.04%)
> System time               14.41 (    +0.00%)         14.64 (    +1.50%)
> pgmajfault              9227.00 (    +0.00%)      18390.00 (   +99.30%)
> workingset_refault_file  184.00 (    +0.00%)    236899.00 (+127954.05%)
>
> Clearly we can't generally ignore page cache hits just because the
> mmaps() are intermittent.

Hi Johannes,
Thanks!

Are you on v1, which lacks folio demotion[1], or v2, which includes it [2]?

[1] https://lore.kernel.org/linux-mm/20250412085852.48524-1-21cnbao@gmail.c=
om/
[2] https://lore.kernel.org/linux-mm/20250514070820.51793-1-21cnbao@gmail.c=
om/

>
> The whole point is to cache across processes and their various
> apertures into a common, long-lived filesystem space.
>
> Barry knows something about the relationship between certain processes
> and certain files that he could exploit with MADV_COLD-on-exit
> semantics. But that's not something the kernel can safely assume. Not
> without defeating the page cache for an entire class of file accesses.

Best Regards
Barry

