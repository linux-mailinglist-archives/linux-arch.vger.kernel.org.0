Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63A524A239
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jun 2019 15:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbfFRNcc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Jun 2019 09:32:32 -0400
Received: from foss.arm.com ([217.140.110.172]:41266 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfFRNcc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 Jun 2019 09:32:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CBDA2B;
        Tue, 18 Jun 2019 06:32:31 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 956973F718;
        Tue, 18 Jun 2019 06:32:27 -0700 (PDT)
Date:   Tue, 18 Jun 2019 14:32:25 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
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
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Subject: Re: [PATCH v7 22/27] binfmt_elf: Extract .note.gnu.property from an
 ELF file
Message-ID: <20190618133223.GD2790@e103592.cambridge.arm.com>
References: <87lfy9cq04.fsf@oldenburg2.str.redhat.com>
 <20190611114109.GN28398@e103592.cambridge.arm.com>
 <031bc55d8dcdcf4f031e6ff27c33fd52c61d33a5.camel@intel.com>
 <20190612093238.GQ28398@e103592.cambridge.arm.com>
 <87imt4jwpt.fsf@oldenburg2.str.redhat.com>
 <alpine.DEB.2.21.1906171418220.1854@nanos.tec.linutronix.de>
 <20190618091248.GB2790@e103592.cambridge.arm.com>
 <20190618124122.GH3419@hirez.programming.kicks-ass.net>
 <87ef3r9i2j.fsf@oldenburg2.str.redhat.com>
 <20190618125512.GJ3419@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618125512.GJ3419@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 18, 2019 at 02:55:12PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 18, 2019 at 02:47:00PM +0200, Florian Weimer wrote:
> > * Peter Zijlstra:
> > 
> > > I'm not sure I read Thomas' comment like that. In my reading keeping the
> > > PT_NOTE fallback is exactly one of those 'fly workarounds'. By not
> > > supporting PT_NOTE only the 'fine' people already shit^Hpping this out
> > > of tree are affected, and we don't have to care about them at all.
> > 
> > Just to be clear here: There was an ABI document that required PT_NOTE
> > parsing.
> 
> URGH.
> 
> > The Linux kernel does *not* define the x86-64 ABI, it only
> > implements it.  The authoritative source should be the ABI document.
> >
> > In this particularly case, so far anyone implementing this ABI extension
> > tried to provide value by changing it, sometimes successfully.  Which
> > makes me wonder why we even bother to mainatain ABI documentation.  The
> > kernel is just very late to the party.
> 
> How can the kernel be late to the party if all of this is spinning
> wheels without kernel support?

PT_GNU_PROPERTY is mentioned and allocated a p_type value in hjl's
spec [1], but otherwise seems underspecified.

In particular, it's not clear whether a PT_GNU_PROPERTY phdr _must_ be
emitted for NT_GNU_PROPERTY_TYPE_0.  While it seems a no-brainer to emit
it, RHEL's linker already doesn't IIUC, and there are binaries in the
wild.

Maybe this phdr type is a late addition -- I haven't attempted to dig
through the history.


For arm64 we don't have this out-of-tree legacy to support, so we can
avoid exhausitvely searching for the note: no PT_GNU_PROPERTY ->
no note.

So, can we do the same for x86, forcing RHEL to carry some code out of
tree to support their legacy binaries?  Or do we accept that there is
already a de facto ABI and try to be compatible with it?


From my side, I want to avoid duplication between x86 and arm64, and
keep unneeded complexity out of the ELF loader where possible.

Cheers
---Dave


[1] https://github.com/hjl-tools/linux-abi/wiki/Linux-Extensions-to-gABI
