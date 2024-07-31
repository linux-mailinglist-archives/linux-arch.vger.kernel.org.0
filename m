Return-Path: <linux-arch+bounces-5737-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 441A394247B
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 04:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A306B240D9
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 02:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EF6101C4;
	Wed, 31 Jul 2024 02:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjFk1R4j"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DA412B63;
	Wed, 31 Jul 2024 02:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722392345; cv=none; b=C+OGW1fVd2MxfYcUZ09OCndcxuUvNYz5A38V4n9nEfXwvTEjLlQnd92gchCvkVeOVHcTj/fU6lEVv9USg0GrxoCFWatIVyPqeQbC73eWcopC7Z6ylFAxHMyGc/5h+iGNizBpQPqQYJ1jHdk27lNlibrcyUPuScB24u81yf4eoIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722392345; c=relaxed/simple;
	bh=psVZlw9PpG9cw5fogbCKd62dVx/dheAvsRci2ZwK2Vc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tnrwlVS/BrrngHu6ofNCYcndvNsIPj67y3+BDQZyjS+h5WzjZS5443N5nX1Hk/s38UiLQoq2EzxUyH+co5wzLUz0GiJHHbbw9i/ZSiT1kskdvI5yWezjnDvFDPZKGTVibQowvr1SR5b18BNVHWpGneoQx9FHEA0eF81ZJpzIzA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjFk1R4j; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-81ff6a80cbbso1499310241.1;
        Tue, 30 Jul 2024 19:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722392343; x=1722997143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EuTTBgp92FvKs6e3kX5RBQcJaA1lmI6qmSNZuE7MUYw=;
        b=CjFk1R4jn9AEVIy1N9rLXWX4iHxnhB1+gtWwvWage1NfdyXWoDxTc3+MCzOaOmQkmZ
         IgTf+Yrqsnsqso/4qXJAuAvp37NpreBxb/Sh2aG/PTLBEFfwlQaDAfKJWCfvjck+aPh5
         qmHTK5koE/WXWXMe82/7i1eWJrFltCc/SageOqYoBDwqQd1JVeVyWT7obDGq+fFhgiCc
         YkGSyXiP3Uho9YgXDPHgX0aNhgtSWYEgKgsM6/nxpCiK4lMeG5SKKH7W09HAj7q0Hsyo
         oVryHp/T3ynYxuxAMaZRdPfmDCqEnKWof6aIFUvAPhWYeagvfb7/BebGGtbmaO7VCSMN
         SQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722392343; x=1722997143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EuTTBgp92FvKs6e3kX5RBQcJaA1lmI6qmSNZuE7MUYw=;
        b=NV7jWltCXQGH4Ug20CJbDAcrm8A9C+DChYpVvbnqI3r3paFfNQPwYPc2nW7zcJSF63
         qi6FtBmgsfWdiKQMA47f6cRuNigig75ANZnqFIjbr7OcctDEuU73pT2PrmdL9Kc6SP5i
         OCTaBy+eIvESF34lI/hDCqZdyS7tXLV0/OOF2hkEBmlbn5ngaWG5E+4c6NdDcCco31Fx
         JQs4agu1868FNORjzznDRcQKiJlZW4a9YMGOlbSHIKqwyixBdTDNUUutfOhoA+IFAkGf
         erh9zs3eOdCPAZpI74WD5ATmKJ4zZgqVUaVEXtnKI7dUYr86wZ9TwN3ZUp25ZhcGvdr8
         EOPg==
X-Forwarded-Encrypted: i=1; AJvYcCUu72AB14VsDsFsnlbXXWswEoo3wepEaX4nYWQXCDKKWC6K3LSoCkkEF74NtqrqXUHyypQQJVRBHfgRsu1tiq/n4I7aTTCNmJaAeAsXz3Hyi6uE+rddTKNQhkLrcRKlB7odhhG8+AlFGdOPbyC5U2XhdfkrVHm9DuCpwhj1juHt5YI=
X-Gm-Message-State: AOJu0Yx9hTsBtALlSa2XQRrDY/z2iqjhTWkXtXS65arxgjUnOdDWgFk/
	GPEEgWkQv1zy6h9F6sZnIHlsqWJwxp01AV8it51DJoVFRYWz4rppQrPKn8EcD+3ruL53pmxcN2J
	70ZmmE92lGbJwS6Vct/t/0GSiXf8=
X-Google-Smtp-Source: AGHT+IET32HsRUmh5QkmUwiju7XuwyuRfEv3IIhJFoZqlfnE3LGBqWMtNG5FTioR1NG2RfcEAUn/nvMGw2OZ8dW8FGQ=
X-Received: by 2002:a05:6102:2909:b0:493:badb:74ef with SMTP id
 ada2fe7eead31-493fad48fdcmr13920389137.26.1722392342815; Tue, 30 Jul 2024
 19:19:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730114426.511-1-justinjiang@vivo.com>
In-Reply-To: <20240730114426.511-1-justinjiang@vivo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 31 Jul 2024 10:18:49 +0800
Message-ID: <CAGsJ_4xdnQjQyJVMfN7ZSW3OMvJhFRErjwMGSCDZACQOVWeesw@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: tlb swap entries batch async release
To: Zhiguo Jiang <justinjiang@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-arch@vger.kernel.org, cgroups@vger.kernel.org, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 7:44=E2=80=AFPM Zhiguo Jiang <justinjiang@vivo.com>=
 wrote:
>
> The main reasons for the prolonged exit of a background process is the
> time-consuming release of its swap entries. The proportion of swap memory
> occupied by the background process increases with its duration in the
> background, and after a period of time, this value can reach 60% or more.

Do you know the reason? Could they be contending for a cluster lock or
something?
Is there any perf data or flamegraph available here?

> Additionally, the relatively lengthy path for releasing swap entries
> further contributes to the longer time required for the background proces=
s
> to release its swap entries.
>
> In the multiple background applications scenario, when launching a large
> memory application such as a camera, system may enter a low memory state,
> which will triggers the killing of multiple background processes at the
> same time. Due to multiple exiting processes occupying multiple CPUs for
> concurrent execution, the current foreground application's CPU resources
> are tight and may cause issues such as lagging.
>
> To solve this problem, we have introduced the multiple exiting process
> asynchronous swap memory release mechanism, which isolates and caches
> swap entries occupied by multiple exit processes, and hands them over
> to an asynchronous kworker to complete the release. This allows the
> exiting processes to complete quickly and release CPU resources. We have
> validated this modification on the products and achieved the expected
> benefits.
>
> It offers several benefits:
> 1. Alleviate the high system cpu load caused by multiple exiting
>    processes running simultaneously.
> 2. Reduce lock competition in swap entry free path by an asynchronous

 Do you have data on which lock is affected? Could it be a cluster lock?

>    kworker instead of multiple exiting processes parallel execution.
> 3. Release memory occupied by exiting processes more efficiently.
>
> Zhiguo Jiang (2):
>   mm: move task_is_dying to h headfile
>   mm: tlb: multiple exiting processes's swap entries async release
>
>  include/asm-generic/tlb.h |  50 +++++++
>  include/linux/mm_types.h  |  58 ++++++++
>  include/linux/oom.h       |   6 +
>  mm/memcontrol.c           |   6 -
>  mm/memory.c               |   3 +-
>  mm/mmu_gather.c           | 297 ++++++++++++++++++++++++++++++++++++++
>  6 files changed, 413 insertions(+), 7 deletions(-)
>  mode change 100644 =3D> 100755 include/asm-generic/tlb.h
>  mode change 100644 =3D> 100755 include/linux/mm_types.h
>  mode change 100644 =3D> 100755 include/linux/oom.h
>  mode change 100644 =3D> 100755 mm/memcontrol.c
>  mode change 100644 =3D> 100755 mm/memory.c
>  mode change 100644 =3D> 100755 mm/mmu_gather.c

Can you check your local filesystem to determine why you're running
the chmod command?

>
> --
> 2.39.0
>

Thanks
Barry

