Return-Path: <linux-arch+bounces-12134-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C4BAC819D
	for <lists+linux-arch@lfdr.de>; Thu, 29 May 2025 19:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B95207B4145
	for <lists+linux-arch@lfdr.de>; Thu, 29 May 2025 17:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACDC22DFBB;
	Thu, 29 May 2025 17:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eh6KuSyL"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225471632C8;
	Thu, 29 May 2025 17:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748539324; cv=none; b=limKptNpv5TprHbBqmWFtUzWGibowhLbDjJMlKGn2BQLQsZD4X/hXjhrbGxgBVBxqhhmioErAPjq3nxjdwEb3kaVct9iC8KepKrgiVMsq/xSI/W7WY2/y+V4wEv0X17VOsTKmESFOIfmkoNIUovLyPNriyKJrheRd2ALrud9klY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748539324; c=relaxed/simple;
	bh=iOLQ+4rRbttM3iWR5mCXSK2AhMOboVS6L8bg5jzfzA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EDz7DcRXv9Ekmquenri4+fJfFIuAZ6FigCxW1SXl3jy0TnzFSOuTDSlpIzo/0bH6MM8qLdj+A2heE9x6IZOQTgJmRW1vZwaS7AvKHZi7vyGE85Hjed59sWLdpPYB+letIyUIzFu5EgrJuTZJsZm207DE0MaO/cn78Jdt5IRDIss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eh6KuSyL; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ad56cbc7b07so189519066b.0;
        Thu, 29 May 2025 10:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748539320; x=1749144120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DX8U7tbhWHGdqlNwj9oFLF/YU0AXwL1c1vUsziqoPv8=;
        b=eh6KuSyL4d/uU1hMboF0uwwRVDTzEEJRsztI/mDkr5tv2qm8Zi4h1Gb9ydmDVz6BCY
         ndLqcmfNRAyAKRSdjzT6xL5q4JwUJpw7BQH1LyQX20NWggTdgRr0B0Hz9QcM5ZYgguKu
         x0XhITXsW27L4KUxPPyuU1C+SWZQZaiObrbFVA0si0eciNFet4HbQOcuYJNLI7ooydtu
         YslbLluARIs0cpWqsxkpO4vxnTjgTRIMYjMYd/Azsk3CVYNZ0caESW80qd7m4WehAM2i
         6bH0Cpm4G9zsp/41XscLV+wtROCnFG8e7xuEtL5+xVaLa210eXmdTPErudywuk2gzl0h
         kf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748539320; x=1749144120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DX8U7tbhWHGdqlNwj9oFLF/YU0AXwL1c1vUsziqoPv8=;
        b=rsGsOTzTVUTcUNrchfZpPd5wvjCN4K7inlKLh7JdOTXIH1fS8vEA2ychriqCxl8Vaw
         co0PSYMGHn7cC6o7XAib3zGU7QonefFlKhlzcR53ZpCbDhO15btwoqU8qGXXWplFST6O
         0Vdf6FSYOz58Mpbg7psym39PGXUh7Hq8d50HC0YDzKtLlPuw5D0SZF8C5VSCZkDg9OwX
         JX3t6VA9ZvbrIojkufzQBzOgVJCUg/a4FEnYWPmHzem//jUvaWbq1p7QbnDko3ClQTcp
         mhLfwh6NBh6YMV1gvE2t7UXmyN0FMXqI1jproIMmpJt6diYkH3uHQaogaf87X/WnpvV1
         7+Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUMGxzm+VEtQakF2R7+5/tMqVmAub2kyPD5MMgmI+B2VaKHByEyBhgOR7CEhKInZyPSZEQo0YJq4yk=@vger.kernel.org, AJvYcCUTH8bO8SrocOOZXUb1g5WdDNKIPnFsw4xTkcUmn8rospPE2eRuA03WR1lBW4BDhxG9W0RJFxyoSVbcSgTW@vger.kernel.org, AJvYcCXNWVbVhUu3/mzPU0/jr1vlMfhqlyxbIIxRHLW3QhG5tSi6UyVUkMBl/3j3k1W6y8bz//FT+qQM5ouZ8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YywdP4zE2IDOWSZMl/Y8nwvVxOC7iFHawWKARKDEFNMjt9uOVmn
	ua0dk33t6w32W1GUtJlRLPM3AKMR/u0Ea0LVL47A/jEzM2eF1D+z44b3
X-Gm-Gg: ASbGncvGIW4UCf4TASmIftbVq2tYWD/0lN47Xezur7Xvr2NpV91biUF/9cYG87gkO8W
	kcBXGl5KaEQKQ90U3Q+Me9I7CRNnJbAqAzLhmNHeKSlYDBH8pFWod2s55qMuEZqYK2rqsmXFvrz
	IiiApbBzQdnW3xBUj1T5vbg3IK8LHz4cWBWdzVWfUJqKoZW+/JbNWfaspctFJS80jhv8I9/pdrs
	nQku4JBH+YdeZKGhBhMj0y1BrnyQO4ZVYC+XdpAFDtgSZMz9HSy6fHuiD3BhqoU/w1W0Cfxep+e
	3pjgbErn2xh8DojTz/TTLNR/A1oOgSmqoGMl0+B5ras1X1k3/Oqay/Oh6BNX937Nk85C25ujHlh
	I6C1OVQ7RwOIJt1Vie9z+IHO4dS7oZ+zOkVc=
X-Google-Smtp-Source: AGHT+IEJTYRcGMiupd4lE9mkGQlu/Uu54Uifq4ZwoVv6lwIXWYIylPx9Wq/FUw4L5saWKvyflVZEqw==
X-Received: by 2002:a17:907:7285:b0:ad8:9c97:c2fa with SMTP id a640c23a62f3a-adb322455e1mr35760366b.4.1748539320038;
        Thu, 29 May 2025 10:22:00 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:18cd:67ac:6946:5beb? ([2620:10d:c092:500::6:9f6d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad3949bsm173685466b.129.2025.05.29.10.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 10:21:59 -0700 (PDT)
Message-ID: <e166592f-aeb3-4573-bb73-270a2eb90be3@gmail.com>
Date: Thu, 29 May 2025 18:21:55 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DISCUSSION] proposed mctl() API
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
 Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
 Christian Brauner <brauner@kernel.org>, SeongJae Park <sj@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Barry Song <21cnbao@gmail.com>, linux-mm@kvack.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, Pedro Falcato <pfalcato@suse.de>
References: <85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29/05/2025 15:43, Lorenzo Stoakes wrote:
> ## INTRODUCTION
> 
> After discussions in various threads (Usama's series adding a new prctl()
> in [0], and a proposal to adapt process_madvise() to do the same -
> conception in [1] and RFC in [2]), it seems fairly clear that it would make
> sense to explore a dedicated API to explicitly allow for actions which
> affect the virtual address space as a whole.
> 
> Also, Barry is implementing a feature (currently under RFC) which could
> additionally make use of this API (see [3]).
> 
> [0]: https://lore.kernel.org/all/20250515133519.2779639-1-usamaarif642@gmail.com/
> [1]: https://lore.kernel.org/linux-mm/c390dd7e-0770-4d29-bb0e-f410ff6678e3@lucifer.local/
> [2]: https://lore.kernel.org/all/cover.1747686021.git.lorenzo.stoakes@oracle.com/
> [3]: https://lore.kernel.org/all/20250514070820.51793-1-21cnbao@gmail.com/
> 
> While madvise() and process_madvise() are useful for altering the
> attributes of VMAs within a virtual address space, it isn't the right fit
> for something that affects the whole address space.
> 
> Additionally, a requirement of Usama's proposal (see [0]) is that we have
> the ability to propagate the change in behaviour across fork/exec. This
> further suggests the need for a dedicated interface, as this really sits
> outside the ordinary behaviour of [process_]madvise().
> 
> prctl() is too broad and encourages mm code to migrate to kernel/sys.c
> where it is at risk of bit-rotting. It can make it harder/impossible to
> isolate mm logic for testing and logic there might be missed in changes
> moving forward.
> 
> It also, like so many kernel interfaces, has 'grown roots out of its pot'
> so to speak - while it started off as an ostensible 'process' manipulation
> interface, prctl() operations manipulate a myriad of task, virtual
> address space and even specific VMA attributes.
> 
> At this stage it really is a 'catch-all' for things we simply couldn't fit
> elsewhere.
> 
> Therefore, as suggested by the rather excellent Liam Howlett, I propose an
> mm-specific interface that _explicitly_ manipulates attributes of the
> virtual address space as a whole.
> 
> I think something that mimics the simplicity of [process_]madvise() makes
> sense - have a limited set of actions that can be taken, and treat them as
> a simple action - a user requests you do XXX to the virtual address space
> (that is, across the mm_struct), and you do it.
> 


Hi Lorenzo,

Thanks for writing the proposal, this is awesome!

Whatever the community agrees with, whether its this or prctl, happy to
move forward with either as both should accomplish the usecase proposed.

I will just add some points over here in defence of prctl, this is just for
discussion, and if the community disagrees, completely happy to move forward
with new syscall as well.

When it comes to having mm code in kernel/sys.c, we can just do something
like below that can actually clean it up? 

diff --git a/kernel/sys.c b/kernel/sys.c
index 3a2df1bd9f64..bfadc339e2c5 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2467,6 +2467,12 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 
        error = 0;
        switch (option) {
+       case PR_SET_MM:
+       case PR_GET_THP_DISABLE:
+       case PR_SET_THP_DISABLE:
+       case PR_NEW_MM_THING:
+               error = some_function_in_mm_folder(); // in mm/mctl.c ?
+               break;
        case PR_SET_PDEATHSIG:
                if (!valid_signal(arg2)) {
                        error = -EINVAL;

when it comes to prctl becoming a catch-all thing, with above clean up,
we can be a lot more careful to what gets added to the mm side of prctl.

The advantage of this is it avoids having another syscall.
My personal view (which can be wrong :)) is that a new syscall should be
for something major,
and I feel that PR_DEFAULT_MADV_HUGEPAGE and PR_DEFAULT_MADV_NOHUGEPAGE
might be small enough to fit in prctl? but I completely understand
your point of view as well!

> ## INTERFACE
> 
> The proposed interface is simply:
> 
> int mctl(int pidfd, int action, unsigned int flags);
> 
> Since PIDFD_SELF is now available, it is easy to invoke this for the
> current process, while also adding the flexibility of being able to apply
> actions to other processes also.
> 
> The function will return 0 on success, -1 on failure, with errno set to the
> error that arose, standard stuff.
> 
> The behaviour will be tailored to each action taken.
> 
> To begin with, I propose a single flag:
> 
> - MCTL_SET_DEFAULT_EXEC - Persists this behaviour across fork/exec.
> 
> This again will be tailored - only certain actions will be allowed to set
> this flag, and we will of course assert appropriate capabilities, etc. upon
> its use.
> 

Sounds good to me. Just adding this here, the solution will be used in systemd
in exec_invoke, similar to how KSM is done with prctl in [1], so for the THP
solution, we would need MCTL_SET_DEFAULT_EXEC as it would need to be inherited
across fork+exec. 

[1] https://github.com/systemd/systemd/blob/2e72d3efafa88c1cb4d9b28dd4ade7c6ab7be29a/src/core/exec-invoke.c#L5046

> All actions would, impact every VMA (if adjustments to VMAs are required).
> 
> ## SECURITY
> 
> Of course, security will be of utmost concern (Jann's input is important
> here :)
> 
> We can vary security requirements depending on the action taken.
> 
> For an initial version I suggest we simply limit operations which:
> 
> - Operate on a remote process
> - Use the MCTL_SET_DEFAULT_EXEC flag
> 
> To those tasks which possess the CAP_SYS_ADMIN capability.
> 
> This may be too restrictive - be good to get some feedback on this.
> 
> I know Jann raised concerns around privileged execution and perhaps it'd be
> useful to see whether this would make more sense for the SET_DEFAULT_EXEC
> case or not.
> 
> Usama - would requiring CAP_SYS_ADMIN be egregious to your use case?
> 

My knowledge is security is limited, so please bare with me, but I actually
didn't understand the security issue and the need for CAP_SYS_ADMIN for
doing VM_(NO)HUGEPAGE.

A process can already madvise its own VMAs, and this is just doing that
for the entire process. And VM_INIT_DEF_MASK is already set to VM_NOHUGEPAGE
so it will be inherited by the parent. Just adding VM_HUGEPAGE shouldnt be
a issue? Inheriting MMF_VM_HUGEPAGE will mean that khugepaged would enter
for that process as well, which again doesnt seem like a security issue
to me.

> ## IMPLEMENTATION
> 
> I think that sensibly we'd need to add some new files here, mm/mctl.c,
> include/linux/mctl.h (the latter of providing the MCTL_xxx actions and
> flags).
> 
> We could find ways to share code between mm files where appropriate to
> avoid too much duplication.
> 
> I suggest that the best way forward, if we were minded to examine how this
> would look in practice, would be for me to implement an RFC that adds the
> interface, and a simple MCTL_SET_NOHUGEPAGE, MCTL_CLEAR_NOHUGEPAGE
> implementation as a proof of concept.
> 
> If we wanted to then go ahead with a non-RFC version, this could then form
> a foundation upon which Usama and Barry could implement their features,
> with Usama then able to add MCTL_[SET/CLEAR]_HUGEPAGE and Barry
> MCTL_[SET/CLEAR]_FADE_ON_DEATH.
> 
> Obviously I don't mean to presume to suggest how we might proceed here -
> only suggesting this might be a good way of moving forward and getting
> things done as quickly as possible while allowing you guys to move forward
> with your features.
> 
> Let me know if this makes sense, alternatively I could try to find a
> relatively benign action to implement as part of the base work, or we could
> simply collaborate to do it all in one series with multiple authors?
> 
> ## RFC
> 
> The above is all only in effect 'putting ideas out there' so this is
> entirely an RFC in spirit and intent - let me know if this makes sense in
> whole or part :)
> 
> Thanks!
> 
> Lorenzo

Again thanks for the proposal! Happy to move forward with this or prctl.
Just adding my 2 cents in this email.

Thanks
Usama


