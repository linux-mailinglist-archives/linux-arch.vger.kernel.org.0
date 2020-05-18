Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7211D7AFD
	for <lists+linux-arch@lfdr.de>; Mon, 18 May 2020 16:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgEROVV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 May 2020 10:21:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:29438 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbgEROVV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 May 2020 10:21:21 -0400
IronPort-SDR: 785uuoDhT3VkOSqzFEFmJInsEm6GDfkvxdDMZPdNkhilYu6TUGae8RlCiXS/JWY57cjnEO44Hi
 0FJBXp+fiiOw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 07:21:20 -0700
IronPort-SDR: Ju000fylxMRhD3U/zlfjUVehdqzMEoACEpsreORet3y01wLHG2QgRGl47fIRMgZyBs6Nevex3n
 AIYVqL+3ccTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="288587097"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga004.fm.intel.com with ESMTP; 18 May 2020 07:21:20 -0700
Message-ID: <b3a0b0a404f1d1c588244889e71fe08508f0c31e.camel@intel.com>
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
Date:   Mon, 18 May 2020 07:21:26 -0700
In-Reply-To: <6f2ef0e5-d3bb-2b52-dc81-8228fec4a3f5@intel.com>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
         <20200429220732.31602-2-yu-cheng.yu@intel.com>
         <b5197a8d-5d8b-e1f7-68d4-58d80261904c@intel.com>
         <dd5b9bab31ecf247a0b4890e22bfbb486ff52001.camel@intel.com>
         <5cc163ff9058d1b27778e5f0a016c88a3b1a1598.camel@intel.com>
         <b0581ddc-0d99-cbcf-278e-0be55ba939a0@intel.com>
         <44c055342bda4fb4730703f987ae35195d1d0c38.camel@intel.com>
         <32235ffc-6e6c-fb3d-80c4-a0478e2d0e0f@intel.com>
         <b09658f92eb66c1d1be509813939b9ed827f9cf0.camel@intel.com>
         <631f071c-c755-a818-6a97-b333eb1fe21c@intel.com>
         <0f751be6d25364c25ee4bddc425b61e626dcd942.camel@intel.com>
         <6f2ef0e5-d3bb-2b52-dc81-8228fec4a3f5@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2020-05-18 at 06:41 -0700, Dave Hansen wrote:
> On 5/15/20 7:53 PM, Yu-cheng Yu wrote:
> > On Fri, 2020-05-15 at 16:56 -0700, Dave Hansen wrote:
> > > What's my recourse as an end user?  I want to run my app and turn off
> > > CET for that app.  How can I do that?
> > 
> > GLIBC_TUNABLES=glibc.tune.hwcaps=-SHSTK,-IBT
> 
> Like I mentioned to H.J., this is something that we need to at least
> acknowledge the existence of in the changelog and probably even the
> Documentation/.

Sure.  I will do that.

> 
> > > > >  I think you're saying that the CET-enabled binary would do
> > > > > arch_setup_elf_property() when it was first exec()'d.  Later, it could
> > > > > use the new prctl(ARCH_X86_CET_DISABLE) to disable its shadow stack,
> > > > > then fork() and the child would not be using CET.  Right?
> > > > > 
> > > > > What is ARCH_X86_CET_DISABLE used for, anyway?
> > > > 
> > > > Both the parent and the child can do ARCH_X86_CET_DISABLE, if CET is
> > > > not locked.
> > > 
> > > Could you please describe a real-world example of why
> > > ARCH_X86_CET_DISABLE exists?  What kinds of apps will use it, or *are*
> > > using it?  Why was it created in the first place?
> > 
> > Currently, ld-linux turns off CET if the binary being loaded does not support
> > CET.
> 
> Great!  Could this please be immortalized in the documentation for the
> prctl()?

Yes.

> 
> > > > > > > Does this *code* work?  Could you please indicate which JITs have been
> > > > > > > enabled to use the code in this series?  How much of the new ABI is in use?
> > > > > > 
> > > > > > JIT does not necessarily use all of the ABI.  The JIT changes mainly fix stack
> > > > > > frames and insert ENDBRs.  I do not work on JIT.  What I found is LLVM JIT fixes
> > > > > > are tested and in the master branch.  Sljit fixes are in the release.
> > > > > 
> > > > > Huh, so who is using the new prctl() ABIs?
> > > > 
> > > > Any code can use the ABI, but JIT code CET-enabling part mostly do not use these
> > > > new prctl()'s, except, probably to get CET status.
> > > 
> > > Which applications specifically are going to use the new prctl()s which
> > > this series adds?  How are they going to use them?
> > > 
> > > "Any code can use them" is not a specific enough answer.
> > 
> > We have four arch_ptctl() calls.  ARCH_X86_CET_DISABLE and ARCH_X86_CET_LOCK are
> > used by ld-linux.  ARCH_X86_CET_STATUS are used in many places to determine if
> > CET is on.  ARCH_X86_CET_ALLOC_SHSTK is used in ucontext related handling, but
> > it can be use by any application to switch shadow stacks.
> 
> Could some of this information be added to the documentation, please?
> It would also be nice to have some more details about how apps end up
> using ARCH_X86_CET_STATUS.  Why would they care that CET is on?

Yes.

Yu-cheng

