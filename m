Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0971CDF26
	for <lists+linux-arch@lfdr.de>; Mon, 11 May 2020 17:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbgEKPgq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 May 2020 11:36:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:38788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgEKPgp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 11 May 2020 11:36:45 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 213BB20746
        for <linux-arch@vger.kernel.org>; Mon, 11 May 2020 15:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589211405;
        bh=i3uY6cCArW5hN5wosQGib94nUFas1R+dCNb46rnxnio=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Mand0CvgonAGC5tTER+gjn+UohBoFWO9E+pZN3apVITUdnYCHVAmLp0NEc8uYh98N
         /wifwK92lqfAfP6sw9L+wWpbXDFB6mv8Syvn5eQhJ+R0OgZgYWIzompe9OVQMzydtM
         049xxjdwYGxUSCTTO18sd3JPRPkRaF6J4hU4xSew=
Received: by mail-wr1-f53.google.com with SMTP id x17so11560538wrt.5
        for <linux-arch@vger.kernel.org>; Mon, 11 May 2020 08:36:45 -0700 (PDT)
X-Gm-Message-State: AGi0PuaY1mD9iVuF/PrcbaQjeXuqp2v7biKhd2McuIuKt1q6wspAcgGd
        mtdGnV6QSrYnoD/GxB0eTXMgeuPaSV5Df4zU678DKg==
X-Google-Smtp-Source: APiQypKYHwNhLBwoJlhPPniwIw7oYGiw+n5i3yhd81TiNyC7Z2AxSsFXseCP0z5QwgjDURBB18+lg0Z/ydWdr/AywuM=
X-Received: by 2002:adf:a298:: with SMTP id s24mr9033222wra.184.1589211403564;
 Mon, 11 May 2020 08:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200508144043.13893-1-joro@8bytes.org> <CALCETrX0ubjc0Gf4hCY9RWH6cVEKF1hv3RzqToKMt9_bEXXBvw@mail.gmail.com>
 <20200508213609.GU8135@suse.de> <CALCETrVxP87o2+aaf=RLW--DSpMrs=BXSQphN6bG5Y4X+OY8GQ@mail.gmail.com>
 <20200509175217.GV8135@suse.de> <CALCETrVU-+G3K5ABBRSEMiwnskL4mZsVcoTESZXnu34J7TaOqw@mail.gmail.com>
 <20200511074243.GE2957@hirez.programming.kicks-ass.net>
In-Reply-To: <20200511074243.GE2957@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 11 May 2020 08:36:31 -0700
X-Gmail-Original-Message-ID: <CALCETrVyoAXXOqm8cYs+31fjWK8mcnKR+wM0_HeJx9=bOaZC6Q@mail.gmail.com>
Message-ID: <CALCETrVyoAXXOqm8cYs+31fjWK8mcnKR+wM0_HeJx9=bOaZC6Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] mm: Get rid of vmalloc_sync_(un)mappings()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        Joerg Roedel <joro@8bytes.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
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

On Mon, May 11, 2020 at 12:42 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sat, May 09, 2020 at 12:05:29PM -0700, Andy Lutomirski wrote:
>
> > On x86_64, the only real advantage is that the handful of corner cases
> > that make vmalloc faults unpleasant (mostly relating to vmap stacks)
> > go away.  On x86_32, a bunch of mind-bending stuff (everything your
> > series deletes but also almost everything your series *adds*) goes
> > away.  There may be a genuine tiny performance hit on 2-level systems
> > due to the loss of huge pages in vmalloc space, but I'm not sure I
> > care or that we use them anyway on these systems.  And PeterZ can stop
> > even thinking about RCU.
> >
> > Am I making sense?
>
> I think it'll work for x86_64 and that is really all I care about :-)

Sadly, I think that Joerg has convinced my that this doesn't really
work for 32-bit unless we rework the LDT code or drop support for
something that we might not want to drop support for.  So, last try --
maybe we can start defeaturing 32-bit:

What if we make 32-bit PTI depend on PAE?  And drop 32-bit Xen PV
support?  And make 32-bit huge pages depend on PAE?  Then 32-bit
non-PAE can use the direct-mapped LDT, 32-bit PTI (and optionally PAE
non-PTI) can use the evil virtually mapped LDT.  And 32-bit non-PAE
(the 2-level case) will only have pointers to page tables at the top
level.  And then we can preallocate.

Or maybe we don't want to defeature this much, or maybe the memory hit
from this preallocation will hurt little 2-level 32-bit systems too
much.

(Xen 32-bit PV support seems to be on its way out upstream.)
