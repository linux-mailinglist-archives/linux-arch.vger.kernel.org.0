Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0863B855
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2019 17:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391208AbfFJPal (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jun 2019 11:30:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:40690 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391204AbfFJPak (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 Jun 2019 11:30:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jun 2019 08:30:39 -0700
X-ExtLoop1: 1
Received: from yyu32-desk1.sc.intel.com ([143.183.136.147])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jun 2019 08:30:39 -0700
Message-ID: <e26f7d09376740a5f7e8360fac4805488b2c0a4f.camel@intel.com>
Subject: Re: [PATCH v7 03/14] x86/cet/ibt: Add IBT legacy code bitmap setup
 function
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
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
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
Date:   Mon, 10 Jun 2019 08:22:33 -0700
In-Reply-To: <25281DB3-FCE4-40C2-BADB-B3B05C5F8DD3@amacapital.net>
References: <20190606200926.4029-1-yu-cheng.yu@intel.com>
         <20190606200926.4029-4-yu-cheng.yu@intel.com>
         <20190607080832.GT3419@hirez.programming.kicks-ass.net>
         <aa8a92ef231d512b5c9855ef416db050b5ab59a6.camel@intel.com>
         <20190607174336.GM3436@hirez.programming.kicks-ass.net>
         <b3de4110-5366-fdc7-a960-71dea543a42f@intel.com>
         <34E0D316-552A-401C-ABAA-5584B5BC98C5@amacapital.net>
         <7e0b97bf1fbe6ff20653a8e4e147c6285cc5552d.camel@intel.com>
         <25281DB3-FCE4-40C2-BADB-B3B05C5F8DD3@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2019-06-07 at 13:43 -0700, Andy Lutomirski wrote:
> > On Jun 7, 2019, at 12:49 PM, Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> > 
> > On Fri, 2019-06-07 at 11:29 -0700, Andy Lutomirski wrote:
> > > > On Jun 7, 2019, at 10:59 AM, Dave Hansen <dave.hansen@intel.com> wrote:
> > > > 
> > > > > On 6/7/19 10:43 AM, Peter Zijlstra wrote:
> > > > > I've no idea what the kernel should do; since you failed to answer the
> > > > > question what happens when you point this to garbage.
> > > > > 
> > > > > Does it then fault or what?
> > > > 
> > > > Yeah, I think you'll fault with a rather mysterious CR2 value since
> > > > you'll go look at the instruction that faulted and not see any
> > > > references to the CR2 value.
> > > > 
> > > > I think this new MSR probably needs to get included in oops output when
> > > > CET is enabled.
> > > 
> > > This shouldn’t be able to OOPS because it only happens at CPL 3,
> > > right?  We
> > > should put it into core dumps, though.
> > > 
> > > > 
> > > > Why don't we require that a VMA be in place for the entire bitmap?
> > > > Don't we need a "get" prctl function too in case something like a JIT is
> > > > running and needs to find the location of this bitmap to set bits
> > > > itself?
> > > > 
> > > > Or, do we just go whole-hog and have the kernel manage the bitmap
> > > > itself. Our interface here could be:
> > > > 
> > > >   prctl(PR_MARK_CODE_AS_LEGACY, start, size);
> > > > 
> > > > and then have the kernel allocate and set the bitmap for those code
> > > > locations.
> > > 
> > > Given that the format depends on the VA size, this might be a good
> > > idea.  I
> > > bet we can reuse the special mapping infrastructure for this — the VMA
> > > could
> > > be a MAP_PRIVATE special mapping named [cet_legacy_bitmap] or similar, and
> > > we
> > > can even make special rules to core dump it intelligently if needed.  And
> > > we
> > > can make mremap() on it work correctly if anyone (CRIU?) cares.
> > > 
> > > Hmm.  Can we be creative and skip populating it with zeros?  The CPU
> > > should
> > > only ever touch a page if we miss an ENDBR on it, so, in normal operation,
> > > we
> > > don’t need anything to be there.  We could try to prevent anyone from
> > > *reading* it outside of ENDBR tracking if we want to avoid people
> > > accidentally
> > > wasting lots of memory by forcing it to be fully populated when the read
> > > it.
> > > 
> > > The one downside is this forces it to be per-mm, but that seems like a
> > > generally reasonable model anyway.
> > > 
> > > This also gives us an excellent opportunity to make it read-only as seen
> > > from
> > > userspace to prevent exploits from just poking it full of ones before
> > > redirecting execution.
> > 
> > GLIBC sets bits only for legacy code, and then makes the bitmap read-
> > only.  That
> > avoids most issues:
> 
> How does glibc know the linear address space size?  We don’t want LA64 to
> break old binaries because the address calculation changed.

When an application starts, its highest stack address is determined.
It uses that as the maximum the bitmap needs to cover.

Yu-cheng
