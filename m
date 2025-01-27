Return-Path: <linux-arch+bounces-9909-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1839EA1CF72
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 02:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52D09165CA3
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 01:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F86925A649;
	Mon, 27 Jan 2025 01:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BG7Ld0Yt"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAFE25A63C
	for <linux-arch@vger.kernel.org>; Mon, 27 Jan 2025 01:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737941499; cv=none; b=dXBSXW3B3Q64rlc1ceTuu2nILoblQ40mQPKf43VvmxIZlai0A8GN29MDUn8KdsgQ6B6UpEng/hP13A+QxVNLZFTAHEAh0Uq7k20cKEC3baHSVHwVysXyzv/bYQjVKR0IpBTZeoW7mk1Cw6a3y58NtZi3JHVAjHM6BORc3APtY/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737941499; c=relaxed/simple;
	bh=C9oaLXpO6owfOTt2dwUE8h3tAvblW+8hazUUIkKzqu4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JSmr63xlcLd0k+Mo56JQqZOp/+DBebHp1Q/xwTNPUGQ4Ajfa9dO+c2y2GbQcuX6681CIWALosaANdgVQuYg/vo7s9oFeprb5VR4eeSK0HzTG+KqWowzxSpNN+D9KZ5HyPgjWjw/n6Iy6YkpUzYVz2Q+5w+x0IUU6NUejLbn6UB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BG7Ld0Yt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21675fd60feso86699255ad.2
        for <linux-arch@vger.kernel.org>; Sun, 26 Jan 2025 17:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737941497; x=1738546297; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=POceRtMWVWLLwpVXZyFlwaFV2xC0SiBcMp9OIByqfZ8=;
        b=BG7Ld0YtBbudRPbCK45DhRDkzWEDC88EkET4QRjRmnem/PX5Hkhk2rXDJx0BOUn9zw
         VzPAzdvHe0wAgwF/fjFalICsz+Yc2KTz7FTRtnTV7XshQqIHpDA4efDmsPTA+TWDFOE+
         3d0bHozhTSRFZ6/s5/I/uGtwJ+AuI7W1RaZO4GxDHPREIh3IbHFUZSFBdXqpDfP7JRoL
         yJmKxADzGJlqD6GV89kGI0i0sIKbm85XEcUhNRZZ46cjBMzAi2SpPzFr6bpU+7kXZozG
         7m0XnnrZcTJYP359OG0b2LDbu7hzaV6EcC7G1jgPawq9TQiM6/hkJiJ7s5YMevTcEx3L
         tQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737941497; x=1738546297;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=POceRtMWVWLLwpVXZyFlwaFV2xC0SiBcMp9OIByqfZ8=;
        b=P8jAmYM1tErQ+oi+hyg3pzCnB+cjG5h22iX0UG6dbhUYdMiDsJP0YZOQTPtm0nLOwM
         kEWxCQB3p8qoYq1tjchc2CavJAMiSBbgVDxfFV85g2OEoztR4QvLzgH6MKx2YqkNBVDd
         8GnrOY/FRgI10odCZKG5VYQvoa7mCNtWenZPIQzOhUZ1HnzKpbmjlFvazzFPfRUVTWfH
         /eqfFrQhGwsysNDonbH3ZJ5fuys8r46k1DmjtX4R5isXDflimZb+xEGm2Wl06GE/yi5e
         zeJ5HYXN9srVHljcA1V0aArWFqxNjMilu5LEeRwul91yan+dPe4vkROqLcmKqpGmCLao
         YryQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd2i5GoirysLHxc3nhs3z7ZFCiZLusoUFlKhFmBeCop8CYwV0dyQEkfQFe4N47iCfpBFuVTuG/f3Sw@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/UsKJ0kyNFBby7WbLaqSUM0h2ZPljsbrO19zHPR3057rCGtxY
	He9Gxbc56uWlTFHZq1gHspJfeaBpAw2ir+UeBMcGtTndinEIz4hhbc9740Ms8A==
X-Gm-Gg: ASbGncvK50k30kUsat3/cYRjFEmsrq9gF7EAlfMKh5cuTRhhPEb9RwgiAo4WLTnW8d+
	9No2UqofFPztvxep0LrDlTLy8Rn0jjSq7a6TdmEnk0t7g1owThcJQBxajtpgpWIPjaHaBtJl83H
	9+Wv7N1vh1D5XleNPltWZ5QJYJz7cFfqSMu1pb/YCzRfB6wzWDlGRRfFVsXvage8zLTC2dh2Q+P
	rjUwPYeaz6vmjtMHgkNt29NW16ecT/XtCu5Rcma4IcJwVvW5PugxQc6W4KgaMQmx5xg8ew0FErX
	1/ALB5ytotfsal5jPeEZjVH8F1S4gBuIkQc4rz3DpAR+uysj66JyL4wg4xX43sGK
X-Google-Smtp-Source: AGHT+IF3nXHvDnjkTs9Lalq7+vB5ht9+80y0rjngMtsBffGQq/s/lUsmT7Sh1KnuAANnuh5JXv4mvw==
X-Received: by 2002:a05:6a20:7f96:b0:1d9:c78f:4207 with SMTP id adf61e73a8af0-1eb2147d3f9mr58967025637.11.1737941496837;
        Sun, 26 Jan 2025 17:31:36 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ac496cb2106sm5282233a12.67.2025.01.26.17.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 17:31:35 -0800 (PST)
Date: Sun, 26 Jan 2025 17:31:25 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
    Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Jann Horn <jannh@google.com>, Peter Zijlstra <peterz@infradead.org>, 
    Will Deacon <will@kernel.org>, 
    "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
    Nick Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3] mmu_gather: move tlb flush for VM_PFNMAP/VM_MIXEDMAP
 vmas into free_pgtables()
In-Reply-To: <32128611-60d5-147c-7e82-7b1dfbe8236b@google.com>
Message-ID: <1e6330a1-c671-c8d0-7eab-e6b9fc7a9d2a@google.com>
References: <20250123164358.2384447-1-roman.gushchin@linux.dev> <32128611-60d5-147c-7e82-7b1dfbe8236b@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 23 Jan 2025, Hugh Dickins wrote:
> On Thu, 23 Jan 2025, Roman Gushchin wrote:
> 
> > Commit b67fbebd4cf9 ("mmu_gather: Force tlb-flush VM_PFNMAP vmas")
> > added a forced tlbflush to tlb_vma_end(), which is required to avoid a
> > race between munmap() and unmap_mapping_range(). However it added some
> > overhead to other paths where tlb_vma_end() is used, but vmas are not
> > removed, e.g. madvise(MADV_DONTNEED).
> > 
> > Fix this by moving the tlb flush out of tlb_end_vma() into
> > free_pgtables(), somewhat similar to the stable version of the
> > original commit: e.g. stable commit 895428ee124a ("mm: Force TLB flush
> > for PFNMAP mappings before unlink_file_vma()").
> > 
> > Note, that if tlb->fullmm is set, no flush is required, as the whole
> > mm is about to be destroyed.
> > 
> > ---
> 
> As Liam said, thanks.
> 
> > 
> > v3:
> >   - added initialization of vma_pfn in __tlb_reset_range() (by Hugh D.)
> > 
> > v2:
> >   - moved vma_pfn flag handling into tlb.h (by Peter Z.)
> >   - added comments (by Peter Z.)
> >   - fixed the vma_pfn flag setting (by Hugh D.)
> > 
> > Suggested-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Nick Piggin <npiggin@gmail.com>
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: linux-arch@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > ---
> >  include/asm-generic/tlb.h | 49 ++++++++++++++++++++++++++++-----------
> >  mm/memory.c               |  7 ++++++
> >  2 files changed, 42 insertions(+), 14 deletions(-)
> 

I had quite a wobble on Friday, couldn't be sure of anything at all.
But I've now spent longer, quietly thinking about this (v3) patch,
and the various races; and with Jann's help, I do feel much more
confident about it all today.

> The code looks right to me now, but not the comments (I usually
> prefer no comment to a wrong or difficult to get right comment).

Yes, the code does look right to me now.  And although I can still quibble
about the comments, I'd better not waste your time with that.  Let me say

Acked-by: Hugh Dickins <hughd@google.com>

while recognizing that this may not be the patch which goes into
the tree, since Peter has other ideas on the naming and wording.

> 
> Except when I try to write a simple enough correct comment,
> I find the code has to be changed, and that then suggests
> further changes... Sigh.
> 
> (We could also go down a path of saying that all of the vma_pfn stuff
> would be better under #fidef CONFIG_MMU_GATHER_MERGE_VMAS; but I
> think we shall only confuse ourselves that way - it shouldn't be
> enough to matter, so long as it does not add any extra TLB flushes.)
> 
> > 
> > diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> > index 709830274b75..cdc95b69b91d 100644
> > --- a/include/asm-generic/tlb.h
> > +++ b/include/asm-generic/tlb.h
> > @@ -380,8 +380,16 @@ static inline void __tlb_reset_range(struct mmu_gather *tlb)
> >  	tlb->cleared_pmds = 0;
> >  	tlb->cleared_puds = 0;
> >  	tlb->cleared_p4ds = 0;
> > +
> > +	/*
> > +	 * vma_pfn can only be set in tlb_start_vma(), so let's
> > +	 * initialize it here. Also a tlb flush issued by
> > +	 * tlb_flush_mmu_pfnmap() will cancel the vma_pfn state,
> > +	 * so that unnecessary subsequent flushes are avoided.
> 
> No, that misses the point (or misses half of the point): the
> tlb_flush_mmu_pfnmap() itself won't need to flush if for other reasons
> we've done a TLB flush since the last VM_PFNMAP|VM_MIXEDMAP vma.
> 
> What I want to write is:
> 	 * vma_pfn can only be set in tlb_start_vma(), so initialize it here.
> 	 * And then any call to tlb_flush_mmu_tlbonly() will reset it again,
> 	 * so that unnecessary subsequent flushes are avoided.
> 
> But once I look at tlb_flush_mmu_tlbonly(), I'm reminded that actually
> it does nothing, if none of cleared_ptes etc. is set: so would not reset
> vma_pfn in that case; which is okay-ish, but makes writing the comment hard.
> 
> So maybe tlb_flush_mmu_tlbonly() should do an explicit "tlb->vma_pfn = 0"
> before returning early; but that then raises the question of whether it
> would not be better just to initialize vma_pfn to 0 in __tlb_gather_mmu(),
> not touch it in __tlb_reset_range(), but reset it to 0 at the start of
> tlb_flush_mmu_tlbonly().
> 
> But it also makes me realize that tlb_flush_mmu_tlbonly() avoiding
> __tlb_reset_range() when nothing was cleared, is not all that good:
> because if flushing a small range is better than flushing a large range,
> then it would be good to reset the range even when nothing was cleared
> (though it looks stupid to reset all the fields just found 0 already).

My paragraph (about the existing code, independent of your patch) looks
nonsense to me now: if there was nothing to be cleared, then the range
would not have been updated, so would not benefit from being reset.

It's still true that there would sometimes be an optimization in setting
"tlb->vma_pfn = 0" in every tlb_flush_mmu_tlbonly(); but it's merely an
optimization, for an unusual case, which you may find demands yet more
thought than it deserves; my guess is that you will prefer not to add
that change, and that's fine by me.

So, if you did respin and change the comment (but I don't insist), maybe:
	 * vma_pfn can only be set in tlb_start_vma(), so initialize it here.
	 * And then it will be reset again after any call to tlb_flush(),
	 * so that unnecessary subsequent flushes are avoided.

Hugh

