Return-Path: <linux-arch+bounces-5834-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 122DF94459C
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 09:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F9C1C204FC
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 07:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE21316D4EF;
	Thu,  1 Aug 2024 07:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEILie34"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E3B158529;
	Thu,  1 Aug 2024 07:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722497827; cv=none; b=JE0eeckkPZemnAcC+Noi3BLAYk2N39YKqF19GpGA4+UZDWA9FH86RKM+i2pEj9fdRVY/N++i6vhXl04jjVLssaVBTnBzhGX41Ave7pCvTsaVGYXQrylwXT5MvgmVotdV3yxDS2BRcFOQPZ8rSsVwjs/A9QYVuXO7E5i6fCpBics=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722497827; c=relaxed/simple;
	bh=WaUR4hy93i4Ek9LDJ+97SoWsUtXnI8FAu3DXyuoQc5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQ+uNheu8NkdkAFtU7UAuzQWmIpKZSx8lUXHffcPj+/gmYMhBcrRQtJpsBiHzED1njgFnCZubq/iAqbVu6BuyvnHLON1mBH7HDAWdayVGgBrLJGdno35Go3HtQ6LHYvQ53gQPfMUgmdzdZxABO7Wa18mnX4oeo2+jRzVFF0RuHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEILie34; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-492a8333cb1so1699631137.3;
        Thu, 01 Aug 2024 00:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722497825; x=1723102625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfuN7vtcTfjCBA2br92dqKx97adSDLYFKLRcwy0cyB8=;
        b=BEILie34Xgjoz5OdPq5k722hSaPBOw5DH2xGASRzjkRkOB9GYpIj3JJrMutHTNsnj3
         iemj5lLKWRGrYAfptvLYfVlr0TH/9nTpAsudM09irbf/X0f8LurIcc1DoQNFtUnGhq8U
         3gcTxzIctGzuqWBBWlVs+J4utI5wmsj+z3w8qTMyAdgyk14aLU4ln4Mc+gOiQAHdV+vp
         F1x0jBzXDC/XE6PIDRaG+vlYzwiUkeNxJcAsX256uZ0PPCVVuiuTMxj0MxIZu2bgxFX0
         M0iQhAtvogDiKrC9pp//OmNtnG+x132nO0ydBNOuxkWEE/5tUbynWvTvdygWcO7J1Id+
         SxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722497825; x=1723102625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sfuN7vtcTfjCBA2br92dqKx97adSDLYFKLRcwy0cyB8=;
        b=KOg4rNAOU4oTjlhPGi4PnY9Www6YP9lys76+1iZgy+u1KW976q2HHD1bDOg0zuGQeH
         zews7JnjZlLkGkQuzlLtC1cF68xsK0UhSf5is1qijX3O9RDlvN53m0RyY+s/ozWw5V/H
         aykx1ERZKLw9Gy2Q5gBe05ZSxUJS7rL4E97LNDG4fEaIBliTQmp7CgXz49t9NEh73M+r
         HqSqqNeVPyA6u4J1xLPNgFohlonk+2YboSYkrEtIrRvpCB3XC3aNgLJYlE45XfaJFJre
         cPwkwj1GhN1+y5vIJLnzppwIIrhnIbvCY9k1q/Lt2h8UomurWyrbgvFkwXVx/NAKm+mP
         Fr0A==
X-Forwarded-Encrypted: i=1; AJvYcCUu7ORTNBFknVszSy8d6GZh8ZG/IHVdl5j+UHTUyLUg6OFfH0ZL1/k7pK7JxL2uzd89NoVDdSu0k5GVwHmz@vger.kernel.org, AJvYcCVNriCBXX0mpY8cNSixKW6aJ7DXQgEoTyFQZhROI/yMwfunj4pTuthRewKJPVeMHwIJN+myCkjY@vger.kernel.org, AJvYcCVdjLazOgBXA2CD1D6WzCnajomIvbFyk+AKlFMEKxEJ/TXCxSrYbjbnDW4PGDd83GSzErQPPu9DzQBqNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJWtDhU33WOZiBU2ZdkI9gcLC0O6BQodjVgn0L+5Cdu3NFwNV2
	TJwX32X56LYbTwfzloZVR1KhZAgaCASs7hjNUgTi5xFzAliDqgGl1Lw5YhX2goB0qbd4R3HM9er
	Xxfuk8+lAKLkdJKK78nlRbBSCmXM=
X-Google-Smtp-Source: AGHT+IGx04si4V8GDZUMjmPGLAJNMLD/FLSH9iT4JiQeGnLtSZxzfZoLY2gFZ+CbFpGugwviVfBE/7dkB9wixnRK3ZY=
X-Received: by 2002:a05:6102:3f51:b0:493:bf46:7f00 with SMTP id
 ada2fe7eead31-4945069ca67mr2432377137.5.1722497824850; Thu, 01 Aug 2024
 00:37:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731133318.527-1-justinjiang@vivo.com> <20240731091715.b78969467c002fa3a120e034@linux-foundation.org>
 <dbead7ca-e9a4-4ee8-9247-4e1ba9f6695c@vivo.com>
In-Reply-To: <dbead7ca-e9a4-4ee8-9247-4e1ba9f6695c@vivo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 1 Aug 2024 15:36:52 +0800
Message-ID: <CAGsJ_4xv--92w+hOVWtMtYK-0TsR6z67xiHEXCvuRNvXx71b2A@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] mm: tlb swap entries batch async release
To: zhiguojiang <justinjiang@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-arch@vger.kernel.org, cgroups@vger.kernel.org, 
	kernel test robot <lkp@intel.com>, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 2:31=E2=80=AFPM zhiguojiang <justinjiang@vivo.com> w=
rote:
>
>
>
> =E5=9C=A8 2024/8/1 0:17, Andrew Morton =E5=86=99=E9=81=93:
> > [Some people who received this message don't often get email from akpm@=
linux-foundation.org. Learn why this is important at https://aka.ms/LearnAb=
outSenderIdentification ]
> >
> > On Wed, 31 Jul 2024 21:33:14 +0800 Zhiguo Jiang <justinjiang@vivo.com> =
wrote:
> >
> >> The main reasons for the prolonged exit of a background process is the
> > The kernel really doesn't have a concept of a "background process".
> > It's a userspace concept - perhaps "the parent process isn't waiting on
> > this process via wait()".
> >
> > I assume here you're referring to an Android userspace concept?  I
> > expect that when Android "backgrounds" a process, it does lots of
> > things to that process.  Perhaps scheduling priority, perhaps
> > alteration of various MM tunables, etc.
> >
> > So rather than referring to "backgrounding" it would be better to
> > identify what tuning alterations are made to such processes to bring
> > about this behavior.
> Hi Andrew Morton,
>
> Thank you for your review and comments.
>
> You are right. The "background process" here refers to the process
> corresponding to an Android application switched to the background.
> In fact, this patch is applicable to any exiting process.
>
> The further explaination the concept of "multiple exiting processes",
> is that it refers to different processes owning independent mm rather
> than sharing the same mm.
>
> I will use "mm" to describe process instead of "background" in next
> version.
> >
> >> time-consuming release of its swap entries. The proportion of swap mem=
ory
> >> occupied by the background process increases with its duration in the
> >> background, and after a period of time, this value can reach 60% or mo=
re.
> > Again, what is it about the tuning of such processes which causes this
> > behavior?
> When system is low memory, memory recycling will be trigged, where
> anonymous folios in the process will be continuously reclaimed, resulting
> in an increase of swap entries occupies by this process. So when the
> process is killed, it takes more time to release it's swap entries over
> time.
>
> Testing datas of process occuping different physical memory sizes at
> different time points:
> Testing Platform: 8GB RAM
> Testing procedure:
> After booting up, start 15 processes first, and then observe the
> physical memory size occupied by the last launched process at
> different time points.
>
> Example:
> The process launched last: com.qiyi.video
> |  memory type  |  0min  |  1min  | BG 5min | BG 10min | BG 15min |
> -------------------------------------------------------------------
> |     VmRSS(KB) | 453832 | 252300 |  204364 |   199944 |  199748  |
> |   RssAnon(KB) | 247348 |  99296 |   71268 |    67808 |   67660  |
> |   RssFile(KB) | 205536 | 152020 |  132144 |   131184 |  131136  |
> |  RssShmem(KB) |   1048 |    984 |     952 |     952  |     952  |
> |    VmSwap(KB) | 202692 | 334852 |  362880 |   366340 |  366488  |
> | Swap ratio(%) | 30.87% | 57.03% |  63.97% |   64.69% |  64.72%  |
> min - minute.
>
> Based on the above datas, we can know that the swap ratio occupied by
> the process gradually increases over time.

If I understand correctly, during zap_pte_range(), if 64.72% of the anonymo=
us
pages are actually swapped out, you end up zapping 100 PTEs but only freein=
g
36.28 pages of memory. By doing this asynchronously, you prevent the
swap_release operation from blocking the process of zapping normal
PTEs that are mapping to memory.

Could you provide data showing the improvements after implementing
asynchronous freeing of swap entries?


> >
> >> Additionally, the relatively lengthy path for releasing swap entries
> >> further contributes to the longer time required for the background pro=
cess
> >> to release its swap entries.
> >>
> >> In the multiple background applications scenario, when launching a lar=
ge
> >> memory application such as a camera, system may enter a low memory sta=
te,
> >> which will triggers the killing of multiple background processes at th=
e
> >> same time. Due to multiple exiting processes occupying multiple CPUs f=
or
> >> concurrent execution, the current foreground application's CPU resourc=
es
> >> are tight and may cause issues such as lagging.
> >>
> >> To solve this problem, we have introduced the multiple exiting process
> >> asynchronous swap memory release mechanism, which isolates and caches
> >> swap entries occupied by multiple exit processes, and hands them over
> >> to an asynchronous kworker to complete the release. This allows the
> >> exiting processes to complete quickly and release CPU resources. We ha=
ve
> >> validated this modification on the products and achieved the expected
> >> benefits.
> > Dumb question: why can't this be done in userspace?  The exiting
> > process does fork/exit and lets the child do all this asynchronous free=
ing?
> The logic optimization for kernel releasing swap entries cannot be
> implemented in userspace. The multiple exiting processes here own
> their independent mm, rather than parent and child processes share the
> same mm. Therefore, when the kernel executes multiple exiting process
> simultaneously, they will definitely occupy multiple CPU core resources
> to complete it.
> >> It offers several benefits:
> >> 1. Alleviate the high system cpu load caused by multiple exiting
> >>     processes running simultaneously.
> >> 2. Reduce lock competition in swap entry free path by an asynchronous
> >>     kworker instead of multiple exiting processes parallel execution.
> > Why is lock contention reduced?  The same amount of work needs to be
> > done.
> When multiple CPU cores run to release the different swap entries belong
> to different exiting processes simultaneously, cluster lock or swapinfo
> lock may encounter lock contention issues, and while an asynchronous
> kworker that only occupies one CPU core is used to complete this work,
> it can reduce the probability of lock contention and free up the
> remaining CPU core resources for other non-exiting processes to use.
> >
> >> 3. Release memory occupied by exiting processes more efficiently.
> > Probably it's slightly less efficient.
> We observed that using an asynchronous kworker can result in more free
> memory earlier. When multiple processes exit simultaneously, due to CPU
> core resources competition, these exiting processes remain in a
> runnable state for a long time and cannot release their occupied memory
> resources timely.
> >
> > There are potential problems with this approach of passing work to a
> > kernel thread:
> >
> > - The process will exit while its resources are still allocated.  But
> >    its parent process assumes those resources are now all freed and the
> >    parent process then proceeds to allocate resources.  This results in
> >    a time period where peak resource consumption is higher than it was
> >    before such a change.
> - I don't think this modification will cause such a problem. Perhaps I
>    haven't fully understood your meaning yet. Can you give me a specific
>    example?

Normally, after completing zap_pte_range, your swap slots are returned to
the swap file, except for a few slot caches. However, with the asynchronous
approach, it means that even after your process has completely exited,
 some swap slots might still not be released to the system. This could
potentially starve other processes waiting for swap slots to perform
swap-outs. I assume this isn't a critical issue for you because, in the
case of killing processes, freeing up memory is more important than
releasing swap entries?


> > - If all CPUs are running in userspace with realtime policy
> >    (SCHED_FIFO, for example) then the kworker thread will not run,
> >    indefinitely.
> - In my clumsy understanding, the execution priority of kernel threads
>    should not be lower than that of the exiting process, and the
>    asynchronous kworker execution should only be triggered when the
>    process exits. The exiting process should not be set to SCHED_LFO,
>    so when the exiting process is executed, the asynchronous kworker
>    should also have opportunity to get timely execution.
> > - Work which should have been accounted to the exiting process will
> >    instead go unaccounted.
> - You are right, the statistics of process exit time may no longer be
>    complete.
> > So please fully address all these potential issues.
> Thanks
> Zhiguo
>

Thanks
Barry

