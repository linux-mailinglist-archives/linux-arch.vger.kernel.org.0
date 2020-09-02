Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7F525AC70
	for <lists+linux-arch@lfdr.de>; Wed,  2 Sep 2020 16:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgIBOAE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Sep 2020 10:00:04 -0400
Received: from foss.arm.com ([217.140.110.172]:38552 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbgIBN6l (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Sep 2020 09:58:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D830231B;
        Wed,  2 Sep 2020 06:58:40 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24EBA3F71F;
        Wed,  2 Sep 2020 06:58:37 -0700 (PDT)
Date:   Wed, 2 Sep 2020 14:58:35 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Florian Weimer <fweimer@redhat.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Subject: Re: [PATCH v11 25/25] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
Message-ID: <20200902135832.GD6642@arm.com>
References: <20200826164604.GW6642@arm.com>
 <87ft892vvf.fsf@oldenburg2.str.redhat.com>
 <CALCETrVeNA0Kt2rW0CRCVo1JE0CKaBxu9KrJiyqUA8LPraY=7g@mail.gmail.com>
 <0e9996bc-4c1b-cc99-9616-c721b546f857@intel.com>
 <4f2dfefc-b55e-bf73-f254-7d95f9c67e5c@intel.com>
 <CAMe9rOqt9kbqERC8U1+K-LiDyNYuuuz3TX++DChrRJwr5ajt6Q@mail.gmail.com>
 <20200901102758.GY6642@arm.com>
 <c91bbad8-9e45-724b-4526-fe3674310c57@intel.com>
 <CALCETrWJQgtO_tP1pEaDYYsFgkZ=fOxhyTRE50THcxYoHyTTwg@mail.gmail.com>
 <32005d57-e51a-7c7f-4e86-612c2ff067f3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32005d57-e51a-7c7f-4e86-612c2ff067f3@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 01, 2020 at 11:11:37AM -0700, Dave Hansen wrote:
> On 9/1/20 10:45 AM, Andy Lutomirski wrote:
> >>> For arm64 (and sparc etc.) we continue to use the regular mmap/mprotect
> >>> family of calls.  One or two additional arch-specific mmap flags are
> >>> sufficient for now.
> >>>
> >>> Is x86 definitely not going to fit within those calls?
> >> That can work for x86.  Andy, what if we create PROT_SHSTK, which can
> >> been seen only from the user.  Once in kernel, it is translated to
> >> VM_SHSTK.  One question for mremap/mprotect is, do we allow a normal
> >> data area to become shadow stack?
> > I'm unconvinced that we want to use a somewhat precious PROT_ or VM_
> > bit for this.  Using a flag bit makes sense if we expect anyone to
> > ever map an fd or similar as a shadow stack, but that seems a bit odd
> > in the first place.  To me, it seems more logical for a shadow stack
> > to be a special sort of mapping with a special vm_ops, not a normal
> > mapping with a special flag set.  Although I realize that we want
> > shadow stacks to work like anonymous memory with respect to fork().
> > Dave?
> 
> I actually don't like the idea of *creating* mappings much.
> 
> I think the pkey model has worked out pretty well where we separate
> creating the mapping from doing something *to* it, like changing
> protections.  For instance, it would be nice if we could preserve things
> like using hugetlbfs or heck even doing KSM for shadow stacks.
> 
> If we're *creating* mappings, we've pretty much ruled out things like
> hugetlbfs.
> 
> Something like mprotect_shstk() would allow an implementation today that
> only works on anonymous memory *and* sets up a special vm_ops.  But, the
> same exact ABI could do wonky stuff in the future if we decided we
> wanted to do shadow stacks on DAX or hugetlbfs or whatever.
> 
> I don't really like the idea of PROT_SHSTK those are plumbed into a
> bunch of interfaces.  But, I also can't deny that it seems to be working
> fine for the arm64 folks.

Note, there are some rough edges, such as what happens when someone
calls mprotect() on memory marked with PROT_BTI.  Unless the caller
knows whether PROT_BTI should be set for that page, the flag may get
unintentionally cleared.  Since the flag only applies to text pages
though, it's not _that_ much of a concern.  Software that deals with
writable text pages is also usually involved in generating the code and
so will know about PROT_BTI.  That's was the theory anyway.

In the longer term, it might be preferable to have a mprotect2() that
can leave some flags unmodified, and that doesn't silently ignore
unknown flags (at least one of mmap or mprotect does; I don't recall
which).  We attempt didn't go this far, for now.

For arm64 it seemed fairly natural for the BTI flag to be a PROT_ flag,
but I don't know enough detail about x86 shstk to know whether it's a
natural fit there.

Cheers
---Dave
