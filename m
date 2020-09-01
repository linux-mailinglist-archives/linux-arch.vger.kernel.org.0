Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8BE258CC2
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 12:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgIAK2J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 06:28:09 -0400
Received: from foss.arm.com ([217.140.110.172]:40064 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbgIAK2H (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Sep 2020 06:28:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B96D330E;
        Tue,  1 Sep 2020 03:28:06 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06EF93F71F;
        Tue,  1 Sep 2020 03:28:02 -0700 (PDT)
Date:   Tue, 1 Sep 2020 11:28:00 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
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
Message-ID: <20200901102758.GY6642@arm.com>
References: <086c73d8-9b06-f074-e315-9964eb666db9@intel.com>
 <73c2211f-8811-2d9f-1930-1c5035e6129c@intel.com>
 <af258a0e-56e9-3747-f765-dfe45ce76bba@intel.com>
 <ef7f9e24-f952-d78c-373e-85435f742688@intel.com>
 <20200826164604.GW6642@arm.com>
 <87ft892vvf.fsf@oldenburg2.str.redhat.com>
 <CALCETrVeNA0Kt2rW0CRCVo1JE0CKaBxu9KrJiyqUA8LPraY=7g@mail.gmail.com>
 <0e9996bc-4c1b-cc99-9616-c721b546f857@intel.com>
 <4f2dfefc-b55e-bf73-f254-7d95f9c67e5c@intel.com>
 <CAMe9rOqt9kbqERC8U1+K-LiDyNYuuuz3TX++DChrRJwr5ajt6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMe9rOqt9kbqERC8U1+K-LiDyNYuuuz3TX++DChrRJwr5ajt6Q@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 27, 2020 at 06:26:11AM -0700, H.J. Lu wrote:
> On Wed, Aug 26, 2020 at 12:57 PM Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > On 8/26/20 11:49 AM, Yu, Yu-cheng wrote:
> > >> I would expect things like Go and various JITs to call it directly.
> > >>
> > >> If we wanted to be fancy and add a potentially more widely useful
> > >> syscall, how about:
> > >>
> > >> mmap_special(void *addr, size_t length, int prot, int flags, int type);
> > >>
> > >> Where type is something like MMAP_SPECIAL_X86_SHSTK.  Fundamentally,
> > >> this is really just mmap() except that we want to map something a bit
> > >> magical, and we don't want to require opening a device node to do it.
> > >
> > > One benefit of MMAP_SPECIAL_* is there are more free bits than MAP_*.
> > > Does ARM have similar needs for memory mapping, Dave?
> >
> > No idea.
> >
> > But, mmap_special() is *basically* mmap2() with extra-big flags space.
> > I suspect it will grow some more uses on top of shadow stacks.  It could
> > have, for instance, been used to allocate MPX bounds tables.
> 
> There is no reason we can't use
> 
> long arch_prctl (int, unsigned long, unsigned long, unsigned long, ..);
> 
> for ARCH_X86_CET_MMAP_SHSTK.   We just need to use
> 
> syscall (SYS_arch_prctl, ARCH_X86_CET_MMAP_SHSTK, ...);


For arm64 (and sparc etc.) we continue to use the regular mmap/mprotect
family of calls.  One or two additional arch-specific mmap flags are
sufficient for now.

Is x86 definitely not going to fit within those calls?

For now, I can't see what arg[2] is used for (and hence the type
argument of mmap_special()), but I haven't dug through the whole series.

Cheers
---Dave
