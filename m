Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950621CBB64
	for <lists+linux-arch@lfdr.de>; Sat,  9 May 2020 01:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgEHXtd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 May 2020 19:49:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727983AbgEHXtb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 May 2020 19:49:31 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2009C2496F
        for <linux-arch@vger.kernel.org>; Fri,  8 May 2020 23:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588981771;
        bh=mIKkm78zlsFmzyNyUggpg/nLJ1Pv+yfyI9aRpBMvboY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qgrr/ZVrtyMMSjMvGdjIv+FxJZuAng9m7yuTdoCTyOB79iIyIxJif4vCLsbkFNCoK
         qXIxL+QBwozjrrBbZe3ADXJGrf4sPvGFA4/sHOtcGrKlf1HKamC+RT5s3LctwL8pAQ
         ysSq0F9r3y6BM21/Dmx5hSBkWO5ZF2Tjj3znNxI0=
Received: by mail-wm1-f51.google.com with SMTP id r26so12544043wmh.0
        for <linux-arch@vger.kernel.org>; Fri, 08 May 2020 16:49:31 -0700 (PDT)
X-Gm-Message-State: AGi0PuaSJthJQ7qdjVlDSqqDFpVHsppQaYFfCfQDxp/UyybtU8uAPCGz
        /lRVKwNwC7QZP0bHUN2MdFo2mfXNb2gMXHFiPZCyzQ==
X-Google-Smtp-Source: APiQypK0d4AuGP8O5iSc/+LZKwChQkendzKhSNJ9rrZnhtoC2RLyao6v06bE42N0zruNedhXQebsB28r6/WvMhKE28c=
X-Received: by 2002:a1c:9989:: with SMTP id b131mr18252758wme.176.1588981769476;
 Fri, 08 May 2020 16:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200508144043.13893-1-joro@8bytes.org> <CALCETrX0ubjc0Gf4hCY9RWH6cVEKF1hv3RzqToKMt9_bEXXBvw@mail.gmail.com>
 <20200508213609.GU8135@suse.de>
In-Reply-To: <20200508213609.GU8135@suse.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 8 May 2020 16:49:17 -0700
X-Gmail-Original-Message-ID: <CALCETrVxP87o2+aaf=RLW--DSpMrs=BXSQphN6bG5Y4X+OY8GQ@mail.gmail.com>
Message-ID: <CALCETrVxP87o2+aaf=RLW--DSpMrs=BXSQphN6bG5Y4X+OY8GQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] mm: Get rid of vmalloc_sync_(un)mappings()
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Andy Lutomirski <luto@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 8, 2020 at 2:36 PM Joerg Roedel <jroedel@suse.de> wrote:
>
> On Fri, May 08, 2020 at 02:33:19PM -0700, Andy Lutomirski wrote:
> > On Fri, May 8, 2020 at 7:40 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> > What's the maximum on other system types?  It might make more sense to
> > take the memory hit and pre-populate all the tables at boot so we
> > never have to sync them.
>
> Need to look it up for 5-level paging, with 4-level paging its 64 pages
> to pre-populate the vmalloc area.
>
> But that would not solve the problem on x86-32, which needs to
> synchronize unmappings on the PMD level.

What changes in this series with x86-32?  We already do that
synchronization, right?  IOW, in the cases where the vmalloc *fault*
code does anything at all, we should have a small bound for how much
memory to preallocate and, if we preallocate it, then there is nothing
to sync and nothing to fault.  And we have the benefit that we never
need to sync anything on 64-bit, which is kind of nice.

Do we actually need PMD-level things for 32-bit?  What if we just
outlawed huge pages in the vmalloc space on 32-bit non-PAE?

Or maybe the net result isn't much of a cleanup after all given the
need to support 32-bit.

>
>
>         Joerg
