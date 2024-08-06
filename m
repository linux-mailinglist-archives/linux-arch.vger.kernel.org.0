Return-Path: <linux-arch+bounces-6070-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B21CB949C45
	for <lists+linux-arch@lfdr.de>; Wed,  7 Aug 2024 01:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33A9B1F2435B
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2024 23:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDF0175D48;
	Tue,  6 Aug 2024 23:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fN7oSuah"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16362158DC0;
	Tue,  6 Aug 2024 23:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722986734; cv=none; b=CYhJLD8ASbFqq11Cnys8MJoBkdj4QLhIgSF2jVMvQ6rhTXB2UNwbNEya7/tZXN/6KF5NUDWzjhZXsbOm2ZTSfbDWuIJr0TxERFX5IxY8Bo3bZWgjtvbv20YR/FgMYfmi/pdS+gj6kS8D1CK3aeEnDlUPb5LGT+/M7bbCbcViU6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722986734; c=relaxed/simple;
	bh=6ZRRPBKkMSaxmVdpbwsaWDoYkf+fA6dKf22zWHhMhSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYg/ycRQK4EIMlbrBQOYbIwiVDSzCImA3NRHiLTtgIXQbi6Kqtw8EFzhVF0fYAJ6jcVQsXsni63t1WEp3swIE25ngINBRDai1uyytESZboa3Gkc/X/xhT413o5N/XzEZGp++X+y2PsqC9GZT3EQ97IOEHqXKEVP62efxD/DE8i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fN7oSuah; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4f6be9d13cdso431798e0c.3;
        Tue, 06 Aug 2024 16:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722986732; x=1723591532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kn1X94t9UKU9+zjgXbaa22ND3HJp/723o1tByU9QibM=;
        b=fN7oSuahZqOuV9bwzX8MutX9bPcA37DntcIT9EfhN1NQMuQotcycU42cYFduY9+aC6
         wY68KzBEqazH+P+f5krmjzKiH1KNqeOPzMy6AYGL/EFQungJknARWehZgtaEzoeH+ZWb
         acDzbxE9YxkEWZUT7A5CpSQ4gjMKr+K5B5B/djThRGdsiK3/qq0ANoHtrZ3IksIR1PW8
         UUamSDKAl09hktLAxVHBQJs7Zi30ID1WGPrLy/zrxzobhlq2Fm98S8m46PSqbUVs+kaB
         bxu8z+fehaor9dn2t65NAbw6DsvQaqKd3UVhoUP0hl8+XHk38soRu1TM0RrA8zq8c1GB
         oZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722986732; x=1723591532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kn1X94t9UKU9+zjgXbaa22ND3HJp/723o1tByU9QibM=;
        b=up0JnKkuIW6f7tflnMqMng32mfOdVDrnvt0K/GRiawEX0oSHPy4ELfikfXpRJ+XPHD
         /CUgyemBryPeWlVKDIx3gs9dAtAWUOuX7NOtTCf78qv9g7d+fGvlwDpFfoKtPhvziNI0
         fP2X7cRU1z3CiE+ozSnadgQ1111LW70FB5atygvZwDtf63EvN+CnJL8KEYinvLjFbeDk
         v4uV3wZvRe1JLHgJcV427RQZxZdO5hwqPRI/4Cb64/IEcw656JrvH1P2tkVSFrYBHt1L
         Ofa+6Zg/GiFgLVT2+XW0yQN0sdUba92a8CkxjOI1bqN8ok74pgOna4RvuqpeUSOIF0Xj
         FemA==
X-Forwarded-Encrypted: i=1; AJvYcCX+/mJ0OIjRoLPv/xGVs/xtgAgaaZeABHxEcZ2AWTSKVoszdYuFMHF9GRq2tZmPLyuGrdfccah1JwqtU1P0omC/e43govvdifX2PxvhJyzNIq817aIzLr6jJCqsk+vCcGtogCTurF2breJ5lXS6S60vha0XvlkT3gjIqJ8sFyWf+s0=
X-Gm-Message-State: AOJu0YwEZ/Mb5m/7hG5LgvSpEXSgpXIiQbLUP9KSDkznRErzYpXTry6r
	rvnYZDXEeHeqxSUDFDloQ+cqtVslL6hDxPcKdtnGRUE8RxcJcB1ufGnpGlkXGr19ZBr12cxPAxY
	1nS50claPn4bX7dL1D3LCWvVCDUg=
X-Google-Smtp-Source: AGHT+IEt3+EX9yk7C1SBDu+blfaTia7GUs2USzvugPfeSyBWkcu2ovT9O6mqRNcPjjj9TmjJxepfcQVNhkNVZUXd6AU=
X-Received: by 2002:a05:6122:311b:b0:4f6:ca2:ad0 with SMTP id
 71dfb90a1353d-4f89ff45ec9mr13580385e0c.1.1722986731757; Tue, 06 Aug 2024
 16:25:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731133318.527-1-justinjiang@vivo.com> <20240731091715.b78969467c002fa3a120e034@linux-foundation.org>
 <dbead7ca-e9a4-4ee8-9247-4e1ba9f6695c@vivo.com> <20240806133823.5cb3f27ef30c42dad5d0c3e8@linux-foundation.org>
 <CAGsJ_4x1tLEmRFbnUYcNYtV73SyBYpBtAx_syjfcnjrom-R+4w@mail.gmail.com> <20240806153947.1af20ffccfb42f1e8d981d6f@linux-foundation.org>
In-Reply-To: <20240806153947.1af20ffccfb42f1e8d981d6f@linux-foundation.org>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 7 Aug 2024 06:21:20 +0800
Message-ID: <CAGsJ_4wVT7uHFdExwPxFD=91Wvn1RR_7L6ACvpQuWteKWOaJag@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] mm: tlb swap entries batch async release
To: Andrew Morton <akpm@linux-foundation.org>
Cc: zhiguojiang <justinjiang@vivo.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-arch@vger.kernel.org, cgroups@vger.kernel.org, 
	kernel test robot <lkp@intel.com>, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 6:39=E2=80=AFAM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Wed, 7 Aug 2024 04:32:09 +0800 Barry Song <21cnbao@gmail.com> wrote:
>
> > > > their independent mm, rather than parent and child processes share =
the
> > > > same mm. Therefore, when the kernel executes multiple exiting proce=
ss
> > > > simultaneously, they will definitely occupy multiple CPU core resou=
rces
> > > > to complete it.
> > >
> > > What I'm asking is why not change those userspace processes so that t=
hey
> > > fork off a child process which shares the MM (shared mm_struct) and
> > > then the original process exits, leaving the asynchronously-running
> > > child to clean up the MM resources.
> >
> > Not Zhiguo. From my perspective as a phone engineer, this issue isn't r=
elated
> > to the parent-child process or the wait() function. Phones rely heavily=
 on
> > mechanisms similar to the OOM killer to function efficiently. For insta=
nce,
> > if you're using apps like YouTube, TikTok, and Facebook, and then you
> > open the camera app to take a photo, the camera app becomes the foregro=
und
> > process and demands a lot of memory. In this scenario, the phone might
> > decide to terminate the most memory-consuming and less important apps,
> > such as TikTok or YouTube, to free up memory for the camera app. TikTok
> > and YouTube become less important because they are no longer occupying
> > the phone's screen and have moved to the background. The faster TikTok
> > and YouTube can be unmapped, the quicker the camera app can launch,
> > enhancing the user experience.
>
> I don't see how this relates to my question.
>
> Userspace can arrange for these resources to be released in an
> asynchronous fashion (can't it?).  So why change the kernel to do that?

I don't believe that userspace can distinguish between swap entries
and PTEs that point to folios.

If we are killing tiktok now, we will be performing munmap
and zap_pte_range(). The PTEs for tiktok might look like this:

PTE0 - page
PTE1 - swap
PTE2 - swap
PTE3 - page
PTE4 - swap
PTE5 - swap
PTE6 - swap
PTE7 - page

Currently, zap_pte_range is freeing all PTEs one by one. While PTE0,
PTE2, and PTE7 can contribute to freeing memory and help accelerate
the launch of the new camera app, PTE1, PTE3, PTE4, PTE5, and
PTE6 do not. They are blocking the memory release of PTE0, PTE2,
and PTE7.

By handling this in kernel space, freeing memory and releasing
swaps won't block each other:

T1                                             T2
PTE0 - page              PTE1 -SWAP
PTE3 - page              PTE2-SWAP
PTE7 - page              PTE4 -SWAP
...

On phones, over 60% of an app's memory could be in swap. This 60%
is obstructing the normal memory release for munmap.

Thanks
Barry

