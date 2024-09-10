Return-Path: <linux-arch+bounces-7166-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B040972848
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 06:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 087282822C0
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 04:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F90136344;
	Tue, 10 Sep 2024 04:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKu8DIMW"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC03A446D2;
	Tue, 10 Sep 2024 04:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725942192; cv=none; b=qzL40NmxUTLAsUA+qNInC26oB9JT5QX/lEnM/29puuwCX6FiSG5qg7BnPSw1YinjFs6q8TvmzaFO3hFPVlY7ftNnXG8Tye7Fc33VJU1CrSVbaN0ZMNUQox0Ysctl7zv3AizIrwvp37pWvUze9VKzvkoQtoJgpJHu8km9pgJ+rEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725942192; c=relaxed/simple;
	bh=ti/J0Gmwd5kkVGJJdLQh3N52Ghv7Vt8HBIiQrl/JFY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNrdMxpuGpWqQc01yuNDuBe0jiIPtoTiwiOsxKcYI6cdBAUgVSX1mkiqM9N7BOGiuiHyt+zQWzp6h0RLFuPyATzf2OzHbuzxjQzEhfR2pd5FN/gYlH2h1ML71jeezdyVHpDTZLuon76mUxjCWebcUmy5Vxce+YxMpUM3eD8bvBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKu8DIMW; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-49bc42bec6dso1376384137.0;
        Mon, 09 Sep 2024 21:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725942189; x=1726546989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOlH/5Y6M5gsktynthjS1eeW0QO1O+aCfqMMFXmDc9I=;
        b=lKu8DIMWuWoYM3iKIgv6CgKASmRtN13z9pamQsI5jCiIzmK5QHN78CDS42lSCNuvde
         N3d6UeIB24ozW3VAy6aIM5omPq7YDedfWkjrSdcyGVuNzaua16v+atWEAj7UxZ6oYOqx
         JGdHzJOmmVJ2+7AcxDB7cjsnKtlZQ1/PO7qBTu4SFs/RKFygDcGaHzfU0oUqtEbsYrzu
         Zo6nA/jZSSoW06OV5IL/Q/KPH/VtXcXC9H5bir2dpubi6PVKss/uwl8UptDXcR6Q55iD
         A/mlma7Ff6j3q42qs0G+GQXcQqZvcrQhuBT2O8kVt83FtIYjQcq7Xls3ws+Ubel0EgDY
         xqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725942189; x=1726546989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOlH/5Y6M5gsktynthjS1eeW0QO1O+aCfqMMFXmDc9I=;
        b=jFgsazux4u8ycZC9XnOaM0EkGVXfjM4/jPYGvaIrKaHGUXqeDTePnFECfWX3/CKUGT
         NDZaic/cURhW3U1ryJqeDeYLF6HuqHGMuhHLYmJEN3H9EbZlc5u2x4bfgqcUPGc3OLJu
         BECOj+2PQ1wgZXNe5jRDDvhfm1F7LbURk6n7nYFXLO1rZ06Q++YHUgMkLz9fJpXWwuq6
         rmRzksq6nkOm9y5e5Q0C65O9gIm7ToP3eIU+YVhXQDsxD7utd8XfWlS9ToeP8kluSI2Y
         2SYxLMSd4i+XZirQMrP9u7Qhuyo6xi+y5ATvr6ILGcT2UfoQ3I4HBpkUhge7bhT3fpyr
         53jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsIzi5gKNGeq1hPkdum7SbeaSvGIQry/4gKFzwiuKoXN/QwrTT9/C9ZPzjmQ186lTRIrHf3xdtv3p5HA==@vger.kernel.org, AJvYcCWNOdFVk20izhKKlMbjXCZBWLZ9/Wytpc8FQqgIXW1oKJJxOlwen0HElhur5vZKWiLtjr07M70IIV0lUwOk@vger.kernel.org, AJvYcCXGa4AEkxwDEUgS3DwFXTV9VcYl+nSWiMhZFjTTOvtb9QrULrysI9O7sEG+aH6BlxM6y1Cjhaya@vger.kernel.org
X-Gm-Message-State: AOJu0Yzud11jqohoGvVp0hxW1Cff5pl2beWZkteRZYVltrppI/ujQOVP
	FRV1TY27fxjUrqus+MF5UNj7cwPheigFVUExK/XYzt6qtZftFKqvwdVsCk/UgvVKtb9Eea4J+5s
	uw/XF/2D0azf8hA9L8y6WjmYRlo4=
X-Google-Smtp-Source: AGHT+IHBfJE65bVIUFZvrv6B8kWV68SwZD1l4mxUkUBrgzNMnQicKN/5HK2hynKCnQAMYdKF8mj7GzmFGG5Sq5KVU3s=
X-Received: by 2002:a05:6102:358a:b0:493:c767:3fe2 with SMTP id
 ada2fe7eead31-49bde0f8f48mr10038718137.1.1725942189307; Mon, 09 Sep 2024
 21:23:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805153639.1057-1-justinjiang@vivo.com> <20240805153639.1057-3-justinjiang@vivo.com>
 <f58950cd-dbe3-4629-ac92-30c76db7849a@redhat.com> <d8445378-4eb2-4d5c-b3b8-1e1a5a3b1458@vivo.com>
In-Reply-To: <d8445378-4eb2-4d5c-b3b8-1e1a5a3b1458@vivo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 10 Sep 2024 16:22:54 +1200
Message-ID: <CAGsJ_4z=u8Da4V+8HcX944SwmspXydavazoFwziZF9kCkqE-Yg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm: tlb: add tlb swap entries batch async release
To: zhiguojiang <justinjiang@vivo.com>
Cc: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-arch@vger.kernel.org, cgroups@vger.kernel.org, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 2:44=E2=80=AFAM zhiguojiang <justinjiang@vivo.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/9/9 14:49, David Hildenbrand =E5=86=99=E9=81=93:
> > On 05.08.24 17:36, Zhiguo Jiang wrote:
> >> One of the main reasons for the prolonged exit of the process with
> >> independent mm is the time-consuming release of its swap entries.
> >> The proportion of swap memory occupied by the process increases over
> >> time due to high memory pressure triggering to reclaim anonymous folio
> >> into swapspace, e.g., in Android devices, we found this proportion can
> >> reach 60% or more after a period of time. Additionally, the relatively
> >> lengthy path for releasing swap entries further contributes to the
> >> longer time required to release swap entries.
> >>
> >> Testing Platform: 8GB RAM
> >> Testing procedure:
> >> After booting up, start 15 processes first, and then observe the
> >> physical memory size occupied by the last launched process at differen=
t
> >> time points.
> >> Example: The process launched last: com.qiyi.video
> >> |  memory type  |  0min  |  1min  |   5min  |   10min  | 15min  |
> >> -------------------------------------------------------------------
> >> |     VmRSS(KB) | 453832 | 252300 |  204364 |   199944 | 199748  |
> >> |   RssAnon(KB) | 247348 |  99296 |   71268 |    67808 | 67660  |
> >> |   RssFile(KB) | 205536 | 152020 |  132144 |   131184 | 131136  |
> >> |  RssShmem(KB) |   1048 |    984 |     952 |     952  | 952  |
> >> |    VmSwap(KB) | 202692 | 334852 |  362880 |   366340 | 366488  |
> >> | Swap ratio(%) | 30.87% | 57.03% |  63.97% |   64.69% | 64.72%  |
> >> Note: min - minute.
> >>
> >> When there are multiple processes with independent mm and the high
> >> memory pressure in system, if the large memory required process is
> >> launched at this time, system will is likely to trigger the
> >> instantaneous
> >> killing of many processes with independent mm. Due to multiple exiting
> >> processes occupying multiple CPU core resources for concurrent
> >> execution,
> >> leading to some issues such as the current non-exiting and important
> >> processes lagging.
> >>
> >> To solve this problem, we have introduced the multiple exiting process
> >> asynchronous swap entries release mechanism, which isolates and caches
> >> swap entries occupied by multiple exiting processes, and hands them ov=
er
> >> to an asynchronous kworker to complete the release. This allows the
> >> exiting processes to complete quickly and release CPU resources. We ha=
ve
> >> validated this modification on the Android products and achieved the
> >> expected benefits.
> >>
> >> Testing Platform: 8GB RAM
> >> Testing procedure:
> >> After restarting the machine, start 15 app processes first, and then
> >> start the camera app processes, we monitor the cold start and preview
> >> time datas of the camera app processes.
> >>
> >> Test datas of camera processes cold start time (unit: millisecond):
> >> |  seq   |   1  |   2  |   3  |   4  |   5  |   6  | average |
> >> | before | 1498 | 1476 | 1741 | 1337 | 1367 | 1655 |   1512  |
> >> | after  | 1396 | 1107 | 1136 | 1178 | 1071 | 1339 |   1204  |
> >>
> >> Test datas of camera processes preview time (unit: millisecond):
> >> |  seq   |   1  |   2  |   3  |   4  |   5  |   6  | average |
> >> | before |  267 |  402 |  504 |  513 |  161 |  265 |   352   |
> >> | after  |  188 |  223 |  301 |  203 |  162 |  154 |   205   |
> >>
> >> Base on the average of the six sets of test datas above, we can see th=
at
> >> the benefit datas of the modified patch:
> >> 1. The cold start time of camera app processes has reduced by about 20=
%.
> >> 2. The preview time of camera app processes has reduced by about 42%.
> >>
> >> It offers several benefits:
> >> 1. Alleviate the high system cpu loading caused by multiple exiting
> >>     processes running simultaneously.
> >> 2. Reduce lock competition in swap entry free path by an asynchronous
> >>     kworker instead of multiple exiting processes parallel execution.
> >> 3. Release pte_present memory occupied by exiting processes more
> >>     efficiently.
> >>
> >> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
> >> ---
> >>   arch/s390/include/asm/tlb.h |   8 +
> >>   include/asm-generic/tlb.h   |  44 ++++++
> >>   include/linux/mm_types.h    |  58 +++++++
> >>   mm/memory.c                 |   3 +-
> >>   mm/mmu_gather.c             | 296 ++++++++++++++++++++++++++++++++++=
++
> >>   5 files changed, 408 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
> >> index e95b2c8081eb..3f681f63390f
> >> --- a/arch/s390/include/asm/tlb.h
> >> +++ b/arch/s390/include/asm/tlb.h
> >> @@ -28,6 +28,8 @@ static inline bool __tlb_remove_page_size(struct
> >> mmu_gather *tlb,
> >>           struct page *page, bool delay_rmap, int page_size);
> >>   static inline bool __tlb_remove_folio_pages(struct mmu_gather *tlb,
> >>           struct page *page, unsigned int nr_pages, bool delay_rmap);
> >> +static inline bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
> >> +        swp_entry_t entry, int nr);
> >
> >
> > The problem I am having is that swap entries don't have any
> > intersection with the TLB. It sounds like we're squeezing something
> > into an existing concept (MMU gather) that just doesn't belong in there=
.
> I referred to the mechanism of batch release in tlb, and perhaps a new
> structure needs to be created to implement this feature.

We already use swap_slots_cache to collect multiple swap entries and
free them in
batches. Would it be better to incorporate our new logic there? might
be much less
change and don't need to touch zap_pte_range() ?  for example, while slot_c=
aches
are almost full, wake up the async thread to free? Or, do you think
that cache->free_lock
is also a contended lock?

>
> Thanks
> Zhiguo
>

Thanks
Barry

