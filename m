Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74861D5BA9
	for <lists+linux-arch@lfdr.de>; Fri, 15 May 2020 23:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgEOVdq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 May 2020 17:33:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:49479 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbgEOVdq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 May 2020 17:33:46 -0400
IronPort-SDR: rjx1Bjtp71FatJIwHqJg2ZcIKG5tXG0BFAMW9FpOneoRHQRZKhidfZzC66oRgSt17keFIE7WWC
 Ou4NizKCeDJA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 14:33:45 -0700
IronPort-SDR: gOvKgDGmB5WzruN5yXXKLsAMyljyX+RYXJfeyIzc1yrVpIPo7o0atEfAuJk8N9xLs8ad2pQRhT
 9yEIkVHRnUcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,396,1583222400"; 
   d="scan'208";a="263317095"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga003.jf.intel.com with ESMTP; 15 May 2020 14:33:44 -0700
Message-ID: <44c055342bda4fb4730703f987ae35195d1d0c38.camel@intel.com>
Subject: Re: [PATCH v10 01/26] Documentation/x86: Add CET description
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
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
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Date:   Fri, 15 May 2020 14:33:49 -0700
In-Reply-To: <b0581ddc-0d99-cbcf-278e-0be55ba939a0@intel.com>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
         <20200429220732.31602-2-yu-cheng.yu@intel.com>
         <b5197a8d-5d8b-e1f7-68d4-58d80261904c@intel.com>
         <dd5b9bab31ecf247a0b4890e22bfbb486ff52001.camel@intel.com>
         <5cc163ff9058d1b27778e5f0a016c88a3b1a1598.camel@intel.com>
         <b0581ddc-0d99-cbcf-278e-0be55ba939a0@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2020-05-15 at 11:39 -0700, Dave Hansen wrote:
> On 5/12/20 4:20 PM, Yu-cheng Yu wrote:
> > On Wed, 2020-04-29 at 16:02 -0700, Yu-cheng Yu wrote:
> > > On Wed, 2020-04-29 at 15:53 -0700, Dave Hansen wrote:
> > > > On 4/29/20 3:07 PM, Yu-cheng Yu wrote:
> > > > > +Note:
> > > > > +  There is no CET-enabling arch_prctl function.  By design, CET is enabled
> > > > > +  automatically if the binary and the system can support it.
> > > > 
> > > > I think Andy and I danced around this last time.  Let me try to say it
> > > > more explicitly.
> > > > 
> > > > I want CET kernel enabling to able to be disconnected from the on-disk
> > > > binary.  I want a binary compiled with CET to be able to disable it, and
> > > > I want a binary not compiled with CET to be able to enable it.  I want
> > > > different threads in a process to be able to each have different CET status.
> > > 
> > > The kernel patches we have now can be modified to support this model.  If after
> > > discussion this is favorable, I will modify code accordingly.
> > 
> > To turn on/off and to lock CET are application-level decisions.  The kernel does
> > not prevent any of those.  Should there be a need to provide an arch_prctl() to
> > turn on CET, it can be added without any conflict to this series.
> 
> I spelled out what I wanted pretty clearly.  On your next post, could
> you please directly address each of the things I asked for?  Please
> directly answer the following questions in your next post with respect
> to the code you post:
> 
> Can a binary compiled with CET run without CET?

Yes, but a few details:

- The shadow stack is transparent to the application.  A CET application does
not have anything different from a non-CET application.  However, if a CET
application uses any CET instructions (e.g. INCSSP), it must first check if CET
is turned on.
- If an application is compiled for IBT, the compiler inserts ENDBRs at branch
targets.  These are nops if IBT is not on.

> Can a binary compiled without CET run CET-enabled code?

Partially yes, but in reality somewhat difficult.

- If a non-CET application does exec() of a CET binary, then CET is enabled.
- If a not-CET application does fork(), and the child wants to turn on CET, it
would be difficult to manage the stack frames, unless the child knows what is is
doing.  The JIT examples I mentioned previously run with CET enabled from the
beginning.  Do you have a reason to do this?  In other words, if the JIT code
needs CET, the app could have started with CET in the first place.
- If you are asking about dlopen(), the library will have the same setting as
the main application.  Do you have any reason to have a library running with
CET, but the application does not have CET?

> Can different threads in a process have different CET enabling state?

Yes, if the parent starts with CET, children can turn it off.  But for the same
reason described above, it is difficult to turn on CET from the middle.

> > > > Which JITs was this tested with?  I think as a bare minimum we need to
> > > > know that this design can accommodate _a_ modern JIT.  It would be
> > > > horrible if the browser javascript engines couldn't use this design, for
> > > > instance.
> > > 
> > > JIT work is still in progress.  When that is available I will test it.
> > 
> > I found CET has been enabled in LLVM JIT, Mesa JIT as well as sljit which is
> > used by jit.  So the current model works with JIT.
> 
> Great!  I'm glad the model works.  That's not what I asked, though.
> 
> Does this *code* work?  Could you please indicate which JITs have been
> enabled to use the code in this series?  How much of the new ABI is in use?

JIT does not necessarily use all of the ABI.  The JIT changes mainly fix stack
frames and insert ENDBRs.  I do not work on JIT.  What I found is LLVM JIT fixes
are tested and in the master branch.  Sljit fixes are in the release.

> Where are the selftests/ for this new ABI?  Were you planning on
> submitting any with this series?

The ABI is more related to the application side, and therefore most suitable for
GLIBC unit tests.  The more complicated areas such as pthreads, signals,
ucontext, fork() are all included there.  I have been constantly running these
tests without any problems.  I can provide more details if testing is the
concern.

Yu-cheng

