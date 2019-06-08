Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB80A3A217
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jun 2019 22:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfFHUwa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jun 2019 16:52:30 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38279 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbfFHUw3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jun 2019 16:52:29 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id BFAAC801E8; Sat,  8 Jun 2019 22:52:15 +0200 (CEST)
Date:   Sat, 8 Jun 2019 22:52:18 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v7 03/14] x86/cet/ibt: Add IBT legacy code bitmap setup
 function
Message-ID: <20190608205218.GA2359@xo-6d-61-c0.localdomain>
References: <20190606200926.4029-1-yu-cheng.yu@intel.com>
 <20190606200926.4029-4-yu-cheng.yu@intel.com>
 <20190607080832.GT3419@hirez.programming.kicks-ass.net>
 <aa8a92ef231d512b5c9855ef416db050b5ab59a6.camel@intel.com>
 <20190607174336.GM3436@hirez.programming.kicks-ass.net>
 <b3de4110-5366-fdc7-a960-71dea543a42f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3de4110-5366-fdc7-a960-71dea543a42f@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi!

> > I've no idea what the kernel should do; since you failed to answer the
> > question what happens when you point this to garbage.
> > 
> > Does it then fault or what?
> 
> Yeah, I think you'll fault with a rather mysterious CR2 value since
> you'll go look at the instruction that faulted and not see any
> references to the CR2 value.
> 
> I think this new MSR probably needs to get included in oops output when
> CET is enabled.
> 
> Why don't we require that a VMA be in place for the entire bitmap?
> Don't we need a "get" prctl function too in case something like a JIT is
> running and needs to find the location of this bitmap to set bits itself?
> 
> Or, do we just go whole-hog and have the kernel manage the bitmap
> itself. Our interface here could be:
> 
> 	prctl(PR_MARK_CODE_AS_LEGACY, start, size);
> 
> and then have the kernel allocate and set the bitmap for those code
> locations.

For the record, that sounds like a better interface than userspace knowing
about the bitmap formats...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
