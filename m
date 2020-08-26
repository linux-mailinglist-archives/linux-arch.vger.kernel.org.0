Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374B32535BB
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 19:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgHZRIu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 13:08:50 -0400
Received: from foss.arm.com ([217.140.110.172]:49226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726854AbgHZRIu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Aug 2020 13:08:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2A95101E;
        Wed, 26 Aug 2020 10:08:48 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B85B3F68F;
        Wed, 26 Aug 2020 10:08:44 -0700 (PDT)
Date:   Wed, 26 Aug 2020 18:08:42 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
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
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
Message-ID: <20200826170841.GX6642@arm.com>
References: <20200825002540.3351-1-yu-cheng.yu@intel.com>
 <20200825002540.3351-26-yu-cheng.yu@intel.com>
 <CALCETrVpLnZGfWWLpJO+aZ9aBbx5KGaCskejXiCXF1GtsFFoPg@mail.gmail.com>
 <2d253891-9393-44d0-35e0-4b9a2da23cec@intel.com>
 <086c73d8-9b06-f074-e315-9964eb666db9@intel.com>
 <73c2211f-8811-2d9f-1930-1c5035e6129c@intel.com>
 <af258a0e-56e9-3747-f765-dfe45ce76bba@intel.com>
 <ef7f9e24-f952-d78c-373e-85435f742688@intel.com>
 <20200826164604.GW6642@arm.com>
 <87ft892vvf.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ft892vvf.fsf@oldenburg2.str.redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 26, 2020 at 06:51:48PM +0200, Florian Weimer wrote:
> * Dave Martin:
> 
> > On Tue, Aug 25, 2020 at 04:34:27PM -0700, Yu, Yu-cheng wrote:
> >> On 8/25/2020 4:20 PM, Dave Hansen wrote:
> >> >On 8/25/20 2:04 PM, Yu, Yu-cheng wrote:
> >> >>>>I think this is more arch-specific.  Even if it becomes a new syscall,
> >> >>>>we still need to pass the same parameters.
> >> >>>
> >> >>>Right, but without the copying in and out of memory.
> >> >>>
> >> >>Linux-api is already on the Cc list.  Do we need to add more people to
> >> >>get some agreements for the syscall?
> >> >What kind of agreement are you looking for?  I'd suggest just coding it
> >> >up and posting the patches.  Adding syscalls really is really pretty
> >> >straightforward and isn't much code at all.
> >> >
> >> 
> >> Sure, I will do that.
> >
> > Alternatively, would a regular prctl() work here?
> 
> Is this something appliation code has to call, or just the dynamic
> loader?
> 
> prctl in glibc is a variadic function, so if there's a mismatch between
> the kernel/userspace syscall convention and the userspace calling
> convention (for variadic functions) for specific types, it can't be made
> to work in a generic way.
>
> The loader can use inline assembly for system calls and does not have
> this issue, but applications would be implcated by it.

To the extent that this is a problem, libc's prctl() wrapper has to
handle it already.  New prctl() calls tend to demand precisely 4
arguments and require unused arguments to be 0, but this is more down to
policy rather than because anything breaks otherwise.

You're right that this has implications: for i386, libc probably pulls
more arguments off the stack than are really there in some situations.
This isn't a new problem though.  There are already generic prctls with
fewer than 4 args that are used on x86.

Merging the actual prctl() and arch_prctl() syscalls doesn't acutally
stop libc from retaining separate wrappers if they have different
argument marshaling requirements in some corner cases.


There might be some underlying reason by x86 has its own call and nobody
else followed the same model, but I don't know what it is.

Cheers
---Dave
