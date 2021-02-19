Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13E431FD25
	for <lists+linux-arch@lfdr.de>; Fri, 19 Feb 2021 17:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhBSQdf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Feb 2021 11:33:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25957 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229587AbhBSQdc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Feb 2021 11:33:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613752322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I6g+cpj7RA6mdZS10/1lUQilWu28S5qGVK36wellnP0=;
        b=aP3dCn3CxA93cicdq69XQgZ6gtzA/8q1B2oCvE9oqPMQlME+IJIAFx0hSt1iDzZpJBOeJw
        3oDY80ea3jxqFF6r1Fw4gKDUfq0LL30ZJDaqUM+MANHFZxkhBUwh6s8g4kXZkkFxWd+Unf
        3AOFnmPQnM5WLSYSC22TUxnH8mCsaaQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-O3kIpkJzO6mE-9qhChcV4Q-1; Fri, 19 Feb 2021 11:32:01 -0500
X-MC-Unique: O3kIpkJzO6mE-9qhChcV4Q-1
Received: by mail-qt1-f197.google.com with SMTP id k90so3640606qte.4
        for <linux-arch@vger.kernel.org>; Fri, 19 Feb 2021 08:32:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I6g+cpj7RA6mdZS10/1lUQilWu28S5qGVK36wellnP0=;
        b=ICAmKMekiMbURyxdq17n3eO5kNGb8sDv9CMYi6uIT/uDPkmnoV/jGTti0VoJQm8Q+0
         DEK93q4dXsbiARxai0wv7d1qgTpCJRawTdOCoIjjl6pP3j6WjtemVzjMz1HSjEnxM+Ap
         ZI6d2veVjwxt0tqNpfhzrlI0uWtnr32d1JUmi5ZaJtHawwU2riZ5TCNYg49pwe1emLJF
         V+WxEyAjXAaPAQAOFrdJfRoX5dor+HYnJ+h5zG7AVm5WSbxMZvLHQcY43inX9eELkiz3
         ineY61ivg2iLxFYvZ6V8i4ewAjZ0WdHC/AumiMz4QZHXwCD36j0kvK+b4/PoJrY+J/pm
         dR3A==
X-Gm-Message-State: AOAM533uOJKw0r5KyU0FtJbHqd6ludDfmpo77ZBIBxYlrBASOm2vjbsv
        EpS3xl89rdcOKPihcxi8dunkGhxn0U45EN6mUiFQ3yD6fS/a7MjES+vZx6G/ytU+qFvtIVHOQ48
        CPxEcMe8nBFyvpH+23hN+tA==
X-Received: by 2002:ac8:6915:: with SMTP id e21mr9609851qtr.120.1613752320506;
        Fri, 19 Feb 2021 08:32:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz17h/UmznBda/FviRgsPcspG9PJA/b7HVNIyT7PEs084wTMUu4JpVtb4dM6Qne2OeAqIpMYg==
X-Received: by 2002:ac8:6915:: with SMTP id e21mr9609806qtr.120.1613752320172;
        Fri, 19 Feb 2021 08:32:00 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id c126sm6542670qkg.16.2021.02.19.08.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 08:31:59 -0800 (PST)
Date:   Fri, 19 Feb 2021 11:31:57 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>, Jann Horn <jannh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Hansen <dave.hansen@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Rik van Riel <riel@surriel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH RFC] mm/madvise: introduce MADV_POPULATE to
 prefault/prealloc memory
Message-ID: <20210219163157.GF6669@xz-x1>
References: <20210217154844.12392-1-david@redhat.com>
 <20210218225904.GB6669@xz-x1>
 <b24996a6-7652-f88c-301e-28417637fd02@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b24996a6-7652-f88c-301e-28417637fd02@redhat.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 19, 2021 at 09:20:16AM +0100, David Hildenbrand wrote:
> On 18.02.21 23:59, Peter Xu wrote:
> > Hi, David,
> > 
> > On Wed, Feb 17, 2021 at 04:48:44PM +0100, David Hildenbrand wrote:
> > > When we manage sparse memory mappings dynamically in user space - also
> > > sometimes involving MADV_NORESERVE - we want to dynamically populate/
> > > discard memory inside such a sparse memory region. Example users are
> > > hypervisors (especially implementing memory ballooning or similar
> > > technologies like virtio-mem) and memory allocators. In addition, we want
> > > to fail in a nice way if populating does not succeed because we are out of
> > > backend memory (which can happen easily with file-based mappings,
> > > especially tmpfs and hugetlbfs).
> > 
> > Could you explain a bit more on how do you plan to use this new interface for
> > the virtio-balloon scenario?
> 
> Sure, that will bring up an interesting point to discuss
> (MADV_POPULATE_WRITE).
> 
> I'm planning on using it in virtio-mem: whenever the guests requests the
> hypervisor (via a virtio-mem device) to make specific blocks available
> ("plug"), I want to have a configurable option ("populate=on" /
> "prealloc="on") to perform safety checks ("prealloc") and populate page
> tables.

As you mentioned in the commit message, the original goal for MADV_POPULATE
should be for performance's sake, which I can understand.  But for safety
check, I'm curious whether we'd have better way to do that besides populating
the whole memory.

E.g., can we simply ask the kernel "how much memory this process can still
allocate", then get a number out of it?  I'm not sure whether it can be done
already by either cgroup or any other facilities, or maybe it's still missing.
But I'd raise this question up, since these two requirements seem to be two
standalone issues to solve at least to me.  It could be an overkill to populate
all the memory just for a sanity check.

> 
> This becomes especially relevant for private/shared hugetlbfs and shared
> files/shmem where we have a limited pool size (e.g., huge pages, tmpfs size,
> filesystem size). But it will also come in handy when just preallocating
> (esp. zeroing) anonymous memory.
> 
> For virito-balloon it is not applicable because it really only supports
> anonymous memory and we cannot fail requests to deflate ...
> 
> --- Example ---
> 
> Example: Assume the guests requests to make 128 MB available and we're using
> hugetlbfs. Assume we're out of huge pages in the hypervisor - we want to
> fail the request - I want to do some kind of preallocation.
> 
> So I could do fallocate() on anything that's MAP_SHARED, but not on anything
> that's MAP_PRIVATE. hugetlbfs via memfd() cannot be preallocated without
> going via SIGBUS handlers.
> 
> --- QEMU memory configurations ---
> 
> I see the following combinations relevant in QEMU that I want to support
> with virito-mem:
> 
> 1) MAP_PRIVATE anonymous memory
> 2) MAP_PRIVATE on hugetlbfs (esp. via memfd)
> 3) MAP_SHARED on hugetlbfs (esp. via memfd)
> 4) MAP_SHARED on shmem (file / memfd)
> 5) MAP_SHARED on some sparse file.
> 
> Other MAP_PRIVATE mappings barely make any sense to me - "read the file and
> write to page cache" is not really applicable to VM RAM (not to mention
> doing fallocate(PUNCH_HOLE) that invalidates the private copies of all other
> mappings on that file).
> 
> --- Ways to populate/preallocate ---
> 
> I see the following ways to populate/preallocate:
> 
> a) MADV_POPULATE: write fault on writable MAP_PRIVATE, read fault on
>    MAP_SHARED
> b) Writing to MAP_PRIVATE | MAP_SHARED from user space.
> c) (below) MADV_POPULATE_WRITE: write fault on writable MAP_PRIVATE |
>    MAP_SHARED
> 
> Especially, 2) is kind of weird as implemented in QEMU
> (util/oslib-posix.c:do_touch_pages):
> 
> "Read & write back the same value, so we don't corrupt existing user/app
> data ... TODO: get a better solution from kernel so we don't need to write
> at all so we don't cause wear on the storage backing the region..."

It's interesting to know about commit 1e356fc14be ("mem-prealloc: reduce large
guest start-up and migration time.", 2017-03-14).  It seems for speeding up VM
boot, but what I can't understand is why it would cause the delay of hugetlb
accounting - I thought we'd fail even earlier at either fallocate() on the
hugetlb file (when we use /dev/hugepages) or on mmap() of the memfd which
contains the huge pages.  See hugetlb_reserve_pages() and its callers.  Or did
I miss something?

I think there's a special case if QEMU fork() with a MAP_PRIVATE hugetlbfs
mapping, that could cause the memory accouting to be delayed until COW happens.
However that's definitely not the case for QEMU since QEMU won't work at all as
late as that point.

IOW, for hugetlbfs I don't know why we need to populate the pages at all if we
simply want to know "whether we do still have enough space"..  And IIUC 2)
above is the major issue you'd like to solve too.

> 
> So if we have zero, we write zero. We'll COW pages, triggering a write fault
> - and that's the only good thing about it. For example, similar to
> MADV_POPULATE, nothing stops KSM from merging anonymous pages again. So for
> anonymous memory the actual write is not helpful at all. Similarly for
> hugetlbfs, the actual write is not necessary - but there is no other way to
> really achieve the goal.
> 
> --- How MADV_POPULATE is useful ---
> 
> With virito-mem, our VM will usually write to memory before it reads it.
> 
> With 1) and 2) it does exactly what I want: trigger COW / allocate memory
> and trigger a write fault. The only issue with 1) is that KSM might come
> around and undo our work - but that could only be avoided by writing random
> numbers to all pages from user space. Or we could simply rather disable KSM
> in that setup ...
> 
> --- How MADV_POPULATE is not perfect ---
> 
> KSM can merge anonymous pages again. Just like the current QEMU
> implementation. The only way around that is writing random numbers to the
> pages or mlocking all memory. No big news.
> 
> Nothing stops reclaim/swap code from depopulating when using files. Again,
> no big new - we have to mlock.
> 
> --- HOW MADV_POPULATE_WRITE might be useful ---
> 
> With 3) 4) 5) MADV_POPULATE does partially what I want: preallocate memory
> and populate page tables. But as it's a read fault, I think we'll have
> another minor fault on access. Not perfect, but better than failing with
> SIGBUS. One way around that would be having an additional
> MADV_POPULATE_WRITE, to use in cases where it makes sense (I think at least
> 3) and 4), most probably not on actual files like 5) ).

Right, it seems when populating memories we'll read-fault on file-backed.
However that'll be another performance issue to think about.  So I'd hope we
can start with the current virtio-mem issue on memory accounting, then we can
discuss them separately.

Btw, thanks for the long write-up, it definitely helps me to understand what
you wanted to achieve.

Thanks,

-- 
Peter Xu

