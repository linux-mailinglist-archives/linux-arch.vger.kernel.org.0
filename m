Return-Path: <linux-arch+bounces-5920-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A11945C36
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 12:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13E9D1C21382
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 10:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9007B1DD383;
	Fri,  2 Aug 2024 10:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlYhtMN9"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EA71DC49F;
	Fri,  2 Aug 2024 10:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722595359; cv=none; b=R2gEC86XIIzcXPvc7utXp3sQ84q/OY342RuOyuWudOdJa7YJ0cIWdGnpXSo+aJXxRzQmbYg048QP/PqoQhJMJW5RwYUFQ1/o/tGWZ8gprXxBjibjpdDruLJeCj65yj8z9xUsS3BRt1RjkkLpPyRnNDG+2l6Rzu2MVI+1RMBbiKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722595359; c=relaxed/simple;
	bh=tf6flvtX1gVejZ+GfrxQ9k2Ka/XJ1zKsDj4ciAwEtmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c56tu+hjEd7JDUViYqg9xPbCYFOyQVuCVrKv2Habo7qpTOPsiVriOriqcVVDEEDhbmoYCLoiYLQgIUqVVgSo7JtqQnB1nPsckqE6zgRV1s7ov+mCshi48eeSkk1cm5O4AOeTJMns521hn5TzI6GNIVBjRq70iBKEgcesXQPCVm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlYhtMN9; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-820f047c4e4so2297098241.0;
        Fri, 02 Aug 2024 03:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722595356; x=1723200156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYzWrQLSRsB6tMp797adyM6wE4ytay2lUb6AMeydM08=;
        b=mlYhtMN94kAD7nGbbsUPYWDy0+U2GizrY18KFsgg+lmG1o/kMd87NktmhiF8oJ8Mdx
         V0kRUUTN2bPe1bZI2EnSj3KdeK3D9SGYTGDTtNJh/qjl9+u4jqH5GhC4UFS8ObOob/Qs
         IXIGDzoMGDysOH97ia7uWV4XTYoQpO49z/BrX/tS4fyEtBdDMqExOFzDKJuPaVPUCw1/
         8EAEOFCo3butEgdLqArj7KVCXw4LBoDoar6pmRtJkzHea+XBd5zH5iHp2YoXoPIXji2O
         GtNhzLjOjiBWxvXL+FF0hDW6ybhaz9hfYrwcoeg+Pevi9bm8nO8IK6abYWUNKdaID0+c
         r+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722595356; x=1723200156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYzWrQLSRsB6tMp797adyM6wE4ytay2lUb6AMeydM08=;
        b=anB5rbbQp+OYsFUnH7ErOKxd9u9mCTNdBRNggTmv8LH5ttk/0xOTymbI7vkao7PJDq
         OB+52Q7jQQVPPgkJ2KgN5N6qGzWRIABnX9JVr3d1ePuTjKHt/98Y3pioBg/f5D4vS4Ia
         tpZtmYsB8G/g41jdJaMGcQwX8zuOXv+XVn9f6aOQ7l2ArZFgVI3JYewa3W3pLHvhrKMn
         PMJaz/NofRYlNM7FFgahPXhUgWuiHrv0ZD2WuPY8c7bFwFMdd4GiChBXSCGPIp0LS7BJ
         o+nbwQpSTDmVggkSUNi9Mjb309HamYXRpdGhIi862zw1eKNCUTvrziTKqw/BOofjWKwl
         vD7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX/1aRE175UCyXbA4scxo9PTgSsAdu3wRwmiK9oyu4tkrSAMt1o3/S5a6wi2ITpMdfwLlpjvcJIvyFGIsB5VbDoDZ4QRrXKqtwpNnyNPER0LtgTCMiP55cpPVK8INM+/LqjGfZ+0Grlk2h8p3qd3C6y1H2d17P/zSId6qVVrxpbpwc=
X-Gm-Message-State: AOJu0YyEXjbIkbNVduwKweKSseTU4cnP9eyJlEUDdB26/fCMrGgOWtnu
	CeUvuP418LqPWGThQcMUycQfyonX82c0OL9jK+14YK8T5Z6jJV/sd76pyGVhhv2QcGeh/L9QRs6
	k5YWSlwaR2jIv5HFvHkBrqCeFoRg=
X-Google-Smtp-Source: AGHT+IH+Ty0j8y1rMi3qIdW9D1GBjwFUCgNbj/ybXxuP+yPokUwOwGDsjX0Or/b5B3jpVXuCf2tg7OCJLKU451ZI+X4=
X-Received: by 2002:a05:6102:c13:b0:48f:df86:dba with SMTP id
 ada2fe7eead31-4945bdc47f7mr4371320137.5.1722595356171; Fri, 02 Aug 2024
 03:42:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731133318.527-1-justinjiang@vivo.com> <20240731091715.b78969467c002fa3a120e034@linux-foundation.org>
 <dbead7ca-e9a4-4ee8-9247-4e1ba9f6695c@vivo.com> <CAGsJ_4xv--92w+hOVWtMtYK-0TsR6z67xiHEXCvuRNvXx71b2A@mail.gmail.com>
 <820dfff4-1f09-474e-aa68-30d779a72fed@vivo.com>
In-Reply-To: <820dfff4-1f09-474e-aa68-30d779a72fed@vivo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 2 Aug 2024 22:42:24 +1200
Message-ID: <CAGsJ_4xV3010jJ1o_zLw9_rcpTHRR4vd+N_4FF7_9NezT7Ezpg@mail.gmail.com>
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

On Thu, Aug 1, 2024 at 10:33=E2=80=AFPM zhiguojiang <justinjiang@vivo.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/8/1 15:36, Barry Song =E5=86=99=E9=81=93:
> > On Thu, Aug 1, 2024 at 2:31=E2=80=AFPM zhiguojiang <justinjiang@vivo.co=
m> wrote:
> >>
> >> =E5=9C=A8 2024/8/1 0:17, Andrew Morton =E5=86=99=E9=81=93:
> >>> [Some people who received this message don't often get email from akp=
m@linux-foundation.org. Learn why this is important at https://aka.ms/Learn=
AboutSenderIdentification ]
> >>>
> >>> On Wed, 31 Jul 2024 21:33:14 +0800 Zhiguo Jiang <justinjiang@vivo.com=
> wrote:
> >>>
> >>>> The main reasons for the prolonged exit of a background process is t=
he
> >>> The kernel really doesn't have a concept of a "background process".
> >>> It's a userspace concept - perhaps "the parent process isn't waiting =
on
> >>> this process via wait()".
> >>>
> >>> I assume here you're referring to an Android userspace concept?  I
> >>> expect that when Android "backgrounds" a process, it does lots of
> >>> things to that process.  Perhaps scheduling priority, perhaps
> >>> alteration of various MM tunables, etc.
> >>>
> >>> So rather than referring to "backgrounding" it would be better to
> >>> identify what tuning alterations are made to such processes to bring
> >>> about this behavior.
> >> Hi Andrew Morton,
> >>
> >> Thank you for your review and comments.
> >>
> >> You are right. The "background process" here refers to the process
> >> corresponding to an Android application switched to the background.
> >> In fact, this patch is applicable to any exiting process.
> >>
> >> The further explaination the concept of "multiple exiting processes",
> >> is that it refers to different processes owning independent mm rather
> >> than sharing the same mm.
> >>
> >> I will use "mm" to describe process instead of "background" in next
> >> version.
> >>>> time-consuming release of its swap entries. The proportion of swap m=
emory
> >>>> occupied by the background process increases with its duration in th=
e
> >>>> background, and after a period of time, this value can reach 60% or =
more.
> >>> Again, what is it about the tuning of such processes which causes thi=
s
> >>> behavior?
> >> When system is low memory, memory recycling will be trigged, where
> >> anonymous folios in the process will be continuously reclaimed, result=
ing
> >> in an increase of swap entries occupies by this process. So when the
> >> process is killed, it takes more time to release it's swap entries ove=
r
> >> time.
> >>
> >> Testing datas of process occuping different physical memory sizes at
> >> different time points:
> >> Testing Platform: 8GB RAM
> >> Testing procedure:
> >> After booting up, start 15 processes first, and then observe the
> >> physical memory size occupied by the last launched process at
> >> different time points.
> >>
> >> Example:
> >> The process launched last: com.qiyi.video
> >> |  memory type  |  0min  |  1min  | BG 5min | BG 10min | BG 15min |
> >> -------------------------------------------------------------------
> >> |     VmRSS(KB) | 453832 | 252300 |  204364 |   199944 |  199748  |
> >> |   RssAnon(KB) | 247348 |  99296 |   71268 |    67808 |   67660  |
> >> |   RssFile(KB) | 205536 | 152020 |  132144 |   131184 |  131136  |
> >> |  RssShmem(KB) |   1048 |    984 |     952 |     952  |     952  |
> >> |    VmSwap(KB) | 202692 | 334852 |  362880 |   366340 |  366488  |
> >> | Swap ratio(%) | 30.87% | 57.03% |  63.97% |   64.69% |  64.72%  |
> >> min - minute.
> >>
> >> Based on the above datas, we can know that the swap ratio occupied by
> >> the process gradually increases over time.
> > If I understand correctly, during zap_pte_range(), if 64.72% of the ano=
nymous
> > pages are actually swapped out, you end up zapping 100 PTEs but only fr=
eeing
> > 36.28 pages of memory. By doing this asynchronously, you prevent the
> > swap_release operation from blocking the process of zapping normal
> > PTEs that are mapping to memory.
> >
> > Could you provide data showing the improvements after implementing
> > asynchronous freeing of swap entries?
> Hi Barry,
>
> Your understanding is correct. From the perspective of the benefits of
> releasing the physical memory occupied by the exiting process, an
> asynchronous kworker releasing swap entries can indeed accelerate
> the exiting process to release its pte_present memory (e.g. file and
> anonymous folio) faster.
>
> In addition, from the perspective of CPU resources, for scenarios where
> multiple exiting processes are running simultaneously, an asynchronous
> kworker instead of multiple exiting processes is used to release swap
> entries can release more CPU core resources for the current non-exiting
> and important processes to use, thereby improving the user experience
> of the current non-exiting and important processes. I think this is the
> main contribution of this modification.
>
> Example:
> When there are multiple processes and the system memory is low, if
> the camera processes are started at this time, it will trigger the
> instantaneous killing of many processes because the camera processes
> need to alloc a large amount of memory, resulting in multiple exiting
> processes running simultaneously. These exiting processes will compete
> with the current camera processes for CPU resources, and the release of
> physical memory occupied by multiple exiting processes due to scheduling
> is slow, ultimately affecting the slow execution of the camera process.
>
> By using this optimization modification, multiple exiting processes can
> quickly exit, freeing up their CPU resources and physical memory of
> pte_preset, improving the running speed of camera processes.
>
> Testing Platform: 8GB RAM
> Testing procedure:
> After restarting the machine, start 15 app processes first, and then
> start the camera app processes, we monitor the cold start and preview
> time datas of the camera app processes.
>
> Test datas of camera processes cold start time (unit: millisecond):
> |  seq   |   1  |   2  |   3  |   4  |   5  |   6  | average |
> | before | 1498 | 1476 | 1741 | 1337 | 1367 | 1655 |   1512  |
> | after  | 1396 | 1107 | 1136 | 1178 | 1071 | 1339 |   1204  |
>
> Test datas of camera processes preview time (unit: millisecond):
> |  seq   |   1  |   2  |   3  |   4  |   5  |   6  | average |
> | before |  267 |  402 |  504 |  513 |  161 |  265 |   352   |
> | after  |  188 |  223 |  301 |  203 |  162 |  154 |   205   |
>
> Base on the average of the six sets of test datas above, we can see that
> the benefit datas of the modified patch:
> 1. The cold start time of camera app processes has reduced by about 20%.
> 2. The preview time of camera app processes has reduced by about 42%.

This sounds quite promising. I understand that asynchronous releasing
of swap entries can help killed processes free memory more quickly,
allowing your camera app to access it faster. However, I=E2=80=99m unsure
about the impact of swap-related lock contention. My intuition is that
it might not be significant, given that the cluster uses a single lock
and its relatively small size helps distribute the swap locks.

Anyway, I=E2=80=99m very interested in your patchset and can certainly
appreciate its benefits from my own experience working on phones. I=E2=80=
=99m
quite busy with other issues at the moment, but I hope to provide you
with detailed comments in about two weeks.

> >
> >>>> Additionally, the relatively lengthy path for releasing swap entries
> >>>> further contributes to the longer time required for the background p=
rocess
> >>>> to release its swap entries.
> >>>>
> >>>> In the multiple background applications scenario, when launching a l=
arge
> >>>> memory application such as a camera, system may enter a low memory s=
tate,
> >>>> which will triggers the killing of multiple background processes at =
the
> >>>> same time. Due to multiple exiting processes occupying multiple CPUs=
 for
> >>>> concurrent execution, the current foreground application's CPU resou=
rces
> >>>> are tight and may cause issues such as lagging.
> >>>>
> >>>> To solve this problem, we have introduced the multiple exiting proce=
ss
> >>>> asynchronous swap memory release mechanism, which isolates and cache=
s
> >>>> swap entries occupied by multiple exit processes, and hands them ove=
r
> >>>> to an asynchronous kworker to complete the release. This allows the
> >>>> exiting processes to complete quickly and release CPU resources. We =
have
> >>>> validated this modification on the products and achieved the expecte=
d
> >>>> benefits.
> >>> Dumb question: why can't this be done in userspace?  The exiting
> >>> process does fork/exit and lets the child do all this asynchronous fr=
eeing?
> >> The logic optimization for kernel releasing swap entries cannot be
> >> implemented in userspace. The multiple exiting processes here own
> >> their independent mm, rather than parent and child processes share the
> >> same mm. Therefore, when the kernel executes multiple exiting process
> >> simultaneously, they will definitely occupy multiple CPU core resource=
s
> >> to complete it.
> >>>> It offers several benefits:
> >>>> 1. Alleviate the high system cpu load caused by multiple exiting
> >>>>      processes running simultaneously.
> >>>> 2. Reduce lock competition in swap entry free path by an asynchronou=
s
> >>>>      kworker instead of multiple exiting processes parallel executio=
n.
> >>> Why is lock contention reduced?  The same amount of work needs to be
> >>> done.
> >> When multiple CPU cores run to release the different swap entries belo=
ng
> >> to different exiting processes simultaneously, cluster lock or swapinf=
o
> >> lock may encounter lock contention issues, and while an asynchronous
> >> kworker that only occupies one CPU core is used to complete this work,
> >> it can reduce the probability of lock contention and free up the
> >> remaining CPU core resources for other non-exiting processes to use.
> >>>> 3. Release memory occupied by exiting processes more efficiently.
> >>> Probably it's slightly less efficient.
> >> We observed that using an asynchronous kworker can result in more free
> >> memory earlier. When multiple processes exit simultaneously, due to CP=
U
> >> core resources competition, these exiting processes remain in a
> >> runnable state for a long time and cannot release their occupied memor=
y
> >> resources timely.
> >>> There are potential problems with this approach of passing work to a
> >>> kernel thread:
> >>>
> >>> - The process will exit while its resources are still allocated.  But
> >>>     its parent process assumes those resources are now all freed and =
the
> >>>     parent process then proceeds to allocate resources.  This results=
 in
> >>>     a time period where peak resource consumption is higher than it w=
as
> >>>     before such a change.
> >> - I don't think this modification will cause such a problem. Perhaps I
> >>     haven't fully understood your meaning yet. Can you give me a speci=
fic
> >>     example?
> > Normally, after completing zap_pte_range, your swap slots are returned =
to
> > the swap file, except for a few slot caches. However, with the asynchro=
nous
> > approach, it means that even after your process has completely exited,
> >   some swap slots might still not be released to the system. This could
> > potentially starve other processes waiting for swap slots to perform
> > swap-outs. I assume this isn't a critical issue for you because, in the
> > case of killing processes, freeing up memory is more important than
> > releasing swap entries?
>   I did not encounter issues caused by the slow release of swap entries
> by asynchronous kworker during our testing. Normally, asynchronous
> kworker can also release cached swap entries in a short period of time.
> Of course, if the system allows, it is necessary to increase the running
> priority of the asynchronous kworker appropriately in order to release
> swap entries faster, which is also beneficial for the system.
>
> The swap-out datas for swap entries is also compressed and stored in the
> zram memory space, so it is relatively important to release the zram
> memory space corresponding to swap entries as soon as possible.
> >
> >>> - If all CPUs are running in userspace with realtime policy
> >>>     (SCHED_FIFO, for example) then the kworker thread will not run,
> >>>     indefinitely.
> >> - In my clumsy understanding, the execution priority of kernel threads
> >>     should not be lower than that of the exiting process, and the
> >>     asynchronous kworker execution should only be triggered when the
> >>     process exits. The exiting process should not be set to SCHED_LFO,
> >>     so when the exiting process is executed, the asynchronous kworker
> >>     should also have opportunity to get timely execution.
> >>> - Work which should have been accounted to the exiting process will
> >>>     instead go unaccounted.
> >> - You are right, the statistics of process exit time may no longer be
> >>     complete.
> >>> So please fully address all these potential issues.
> >> Thanks
> >> Zhiguo

Thanks
Barry

