Return-Path: <linux-arch+bounces-2262-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC83F852301
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 01:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D137284F44
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 00:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4FA256A;
	Tue, 13 Feb 2024 00:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=soleen.com header.i=@soleen.com header.b="hRFx8OzL"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182C864F
	for <linux-arch@vger.kernel.org>; Tue, 13 Feb 2024 00:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783300; cv=none; b=FIoftzDEPp2pPeGn50QgdMBRy5uhT19jbQbv1VoxQyPbbBw355eMJdvWWiMFwacWG/zBYFbT/1xtU/nQKUs9hJBHYNxet0Z9LKQh5Ew+g25WMUdMJiTZ1SwNVg7xgc/6tzYjpo1MaPJKbmEdF7IsGU41tG5alreCeelMP8XDZm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783300; c=relaxed/simple;
	bh=p+IVeRU3f9COk3wBMTH0iIf+8fVqKG0n9hzN9kdq2Xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YB5DXj90Qked2+wfjhHp69Mddw1eCHR0Lq83hZKDb3wuxmbzLny2cdfFdQQNV7BOCCO5gqVeWaqXJRu+dQkSUEKgNtjHCJVsAr9aZn6+NjUL+2vF7RNDppTuJe5dtek6Cz8ztJWsHHrS16SN3Rb5J5imMVwBE2xhHkI2VeRGlvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com; spf=none smtp.mailfrom=soleen.com; dkim=fail (0-bit key) header.d=soleen.com header.i=@soleen.com header.b=hRFx8OzL reason="key not found in DNS"; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=soleen.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6dc8b280155so2674180a34.0
        for <linux-arch@vger.kernel.org>; Mon, 12 Feb 2024 16:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1707783298; x=1708388098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zpkbch4s+SL6zR3ce+cP/IOGuaScUrbATNvaMsX6gQU=;
        b=hRFx8OzLpzZfkX2KYjLz4MEK93nwhIERYV36+ueQxJxoEiHKMQL/1nEjdZ+7VSdbnf
         siT39azOSxjFsh9kTAOIuasSKEjL0EFsOsuZ1OEiypY/Q3hVEUMNHWJWjqyTUj/IyQFT
         tLV1wc7OS5h52ntKwWemX0veu7L2EfUlY9A7hdSorOd5CLoGWAIZ7u6C3IDp4GDa1eqD
         epkpLwBxzRsy+dYvA+NpDHfSpCTF+zyOMqrG10Sb+ySK6Cm1hzKZ5DHceUiz02THdlF9
         aF33k3ujEKG2VjS0Cn7Yf/4/qpOuWXFxZJbKA+6dw8lTQE4hLZDefHslyXT+60uZCqLy
         eXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707783298; x=1708388098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zpkbch4s+SL6zR3ce+cP/IOGuaScUrbATNvaMsX6gQU=;
        b=b99aaEspTV2rrwv3e7XujHXnenZOTYupP3TQkl0hgGV6ltql5uNaqdcrQAqFZ/4nZO
         dfhBS8kaRfOtPrGwnwaFQZxmdeUJ5tIZQG3KOALyEEXoS2oPfY7+7ONKndtEzUfGZmGL
         vhLV0wwMKyPWoEAQgxxJXK7UNciOitSrJiOVevEkKrxD8WtafULMwqqMoNREMOS+ITd2
         86r24WPCWw+4iAvZqnll/JqfQ4mJ7P9ahvqCY1k4BRG0svQVQ2rJVEyTy7A5RLrvioV+
         bKlalsF7xG2Is6CCbGgC+d+U51Pzc276V4S0edeRDnmuTLY9XWICEIc60S63lcr9WtbG
         lRFw==
X-Forwarded-Encrypted: i=1; AJvYcCUriftRJ1ijvUOB3cNEtBwCnIaK++rGhBoxrr/tdOwn7i7uS2FkNbfn6GWnND3uWJFXK5Sr1gE17mDBlkTy8OCySP/fqad94jJshg==
X-Gm-Message-State: AOJu0YyPtVN7yH282oE124Uf7ZBCJzRxJ8FFx+WD3Zfx75uy74XxlI2+
	K8nh/nMCULVzqbF6mDRJ2gWHM+ewm10DFSvLUXpush2FA62Rs6qcogIqDH9aBHgxdrGnl2WDwiQ
	ylzxVsmAUpJXZooT+x6QGiaz/1bM+i7Y5srjzAw==
X-Google-Smtp-Source: AGHT+IENA2I2vQZTmviXZDRj9zPa9m0qm240EbRNcQEFbOk5GS9Qd9oHISJT+KIV/8e+A1RHV9ji5tIu3nuHQqetP/o=
X-Received: by 2002:a05:6830:12c2:b0:6e2:e953:6fee with SMTP id
 a2-20020a05683012c200b006e2e9536feemr3152110otq.24.1707783298148; Mon, 12 Feb
 2024 16:14:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com>
In-Reply-To: <20240212213922.783301-1-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 12 Feb 2024 19:14:20 -0500
Message-ID: <CA+CK2bBLD-mZ4ne56Awxbiy0EGpJq69k5qUKZwcXVB1Rt581TQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
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

On Mon, Feb 12, 2024 at 4:39=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> Memory allocation, v3 and final:
>
> Overview:
> Low overhead [1] per-callsite memory allocation profiling. Not just for d=
ebug
> kernels, overhead low enough to be deployed in production.
>
> We're aiming to get this in the next merge window, for 6.9. The feedback
> we've gotten has been that even out of tree this patchset has already
> been useful, and there's a significant amount of other work gated on the
> code tagging functionality included in this patchset [2].
>
> Example output:
>   root@moria-kvm:~# sort -h /proc/allocinfo|tail
>    3.11MiB     2850 fs/ext4/super.c:1408 module:ext4 func:ext4_alloc_inod=
e
>    3.52MiB      225 kernel/fork.c:356 module:fork func:alloc_thread_stack=
_node
>    3.75MiB      960 mm/page_ext.c:270 module:page_ext func:alloc_page_ext
>    4.00MiB        2 mm/khugepaged.c:893 module:khugepaged func:hpage_coll=
apse_alloc_folio
>    10.5MiB      168 block/blk-mq.c:3421 module:blk_mq func:blk_mq_alloc_r=
qs
>    14.0MiB     3594 include/linux/gfp.h:295 module:filemap func:folio_all=
oc_noprof
>    26.8MiB     6856 include/linux/gfp.h:295 module:memory func:folio_allo=
c_noprof
>    64.5MiB    98315 fs/xfs/xfs_rmap_item.c:147 module:xfs func:xfs_rui_in=
it
>    98.7MiB    25264 include/linux/gfp.h:295 module:readahead func:folio_a=
lloc_noprof
>     125MiB     7357 mm/slub.c:2201 module:slub func:alloc_slab_page

This kind of memory profiling would be an incredible asset in cloud
environments.

Over the past year, we've encountered several kernel memory overhead
issues. Two particularly severe cases involved excessively large IOMMU
page tables (20GB per machine) and IOVA magazines (up to 8GB).
Considering thousands of machines were affected, the cumulative memory
waste was huge.

While we eventually resolved these issues with custom kernel profiling
hacks (some based on this series) and kdump analysis, comprehensive
memory profiling would have significantly accelerated the diagnostic
process, pinpointing the precise source of the allocations.

