Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25CE217E540
	for <lists+linux-arch@lfdr.de>; Mon,  9 Mar 2020 18:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgCIRA7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Mar 2020 13:00:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:41999 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbgCIRA7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 9 Mar 2020 13:00:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 10:00:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,534,1574150400"; 
   d="scan'208";a="230995194"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga007.jf.intel.com with ESMTP; 09 Mar 2020 10:00:56 -0700
Message-ID: <0f43463e02d1be2af6bcf8ff6917e751ba7676a0.camel@intel.com>
Subject: Re: [RFC PATCH v9 01/27] Documentation/x86: Add CET description
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
        Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Date:   Mon, 09 Mar 2020 10:00:56 -0700
In-Reply-To: <9ae1cf84-1d84-1d34-c0ce-48b0d70b8f3f@intel.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
         <20200205181935.3712-2-yu-cheng.yu@intel.com>
         <9ae1cf84-1d84-1d34-c0ce-48b0d70b8f3f@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2020-02-26 at 09:57 -0800, Dave Hansen wrote:
> > index ade4e6ec23e0..8b69ebf0baed 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -3001,6 +3001,12 @@
> >  			noexec=on: enable non-executable mappings (default)
> >  			noexec=off: disable non-executable mappings
> >  
> > +	no_cet_shstk	[X86-64] Disable Shadow Stack for user-mode
> > +			applications
> 
> If we ever add kernel support, "no_cet_shstk" will mean "no cet shstk
> for userspace"?

What about no_user_shstk, no_kernel_shstk?

> 
> > +	no_cet_ibt	[X86-64] Disable Indirect Branch Tracking for user-mode
> > +			applications
> > +
> >  	nosmap		[X86,PPC]
> >  			Disable SMAP (Supervisor Mode Access Prevention)
> >  			even if it is supported by processor.
> 
> BTW, this documentation is misplaced.  It needs to go to the spot where
> you introduce the code for these options.

We used to introduce the document later in the series.  The feedback was to
introduce it first so that readers know what to expect.

[...]

> > diff --git a/Documentation/x86/intel_cet.rst b/Documentation/x86/intel_cet.rst
> > new file mode 100644
> > index 000000000000..71e2462fea5c
> > --- /dev/null
> > +++ b/Documentation/x86/intel_cet.rst
> > @@ -0,0 +1,294 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=========================================
> > +Control-flow Enforcement Technology (CET)
> > +=========================================
> > +
> > +[1] Overview
> > +============
> > +
> > +Control-flow Enforcement Technology (CET) provides protection against
> > +return/jump-oriented programming (ROP) attacks.  It can be setup to

[...]

> > +
> > +There are two kernel configuration options:
> > +
> > +    X86_INTEL_SHADOW_STACK_USER, and
> > +    X86_INTEL_BRANCH_TRACKING_USER.
> > +
> > +To build a CET-enabled kernel, Binutils v2.31 and GCC v8.1 or later
> > +are required.
> 
> Why are these needed to build a CET-enabled kernel?

We could (and used to) allow legacy toolchains, but after considering
practical purposes, dropped the support.  We can continue the discussion,
and if those are desired, bring them back.

[...]

> > +[2] CET assembly instructions
> > +=============================
> 
> Why do we need this in the kernel?  What is specific to Linux or the
> kernel?  Why wouldn't I just go read the SDM if I want to know how the
> instructions work?

Now the SDM has this.  I will drop this section.

> > +[3] Application Enabling
> > +========================
> > +
> > +An application's CET capability is marked in its ELF header and can
> > +be verified from the following command output, in the
> > +NT_GNU_PROPERTY_TYPE_0 field:
> > +
> > +    readelf -n <application>
> > +
> > +If an application supports CET and is statically linked, it will run
> > +with CET protection.  If the application needs any shared libraries,
> > +the loader checks all dependencies and enables CET only when all
> > +requirements are met.
> 
> What about shared libraries loaded after the program starts?

The loader does the check for dlopen().


> > +[4] Legacy Libraries
> > +====================
> > +
> > +GLIBC provides a few tunables for backward compatibility.
> > +
> > +GLIBC_TUNABLES=glibc.tune.hwcaps=-SHSTK,-IBT
> > +    Turn off SHSTK/IBT for the current shell.
> > +
> > +GLIBC_TUNABLES=glibc.tune.x86_shstk=<on, permissive>
> > +    This controls how dlopen() handles SHSTK legacy libraries::
> > +
> > +        on         - continue with SHSTK enabled;
> > +        permissive - continue with SHSTK off.
> 
> This seems like manpage fodder more than kernel documentation to me.

Yes, we can drop this as well.

[...]

> > +Note:
> > +  There is no CET-enabling arch_prctl function.  By design, CET is
> > +  enabled automatically if the binary and the system can support it.
> 
> This is kinda interesting.  It means that a JIT couldn't choose to
> protect the code it generates and have different rules from itself?

JIT needs to be updated for CET first.  Once that is done, it runs with CET
enabled.  It can use the NOTRACK prefix, for example.

> > +  The parameters passed are always unsigned 64-bit.  When an IA32
> > +  application passing pointers, it should only use the lower 32 bits.
> 
> Won't a 32-bit app calling prctl() use the 32-bit ABI?  How would it
> even know it's running on a 64-bit kernel?

The 32-bit app is passing only a pointer to an array of 64-bit numbers.

> 
> > +[6] The implementation of the SHSTK
> > +===================================
> > +
> > +SHSTK size
> > +----------
> > +
> > +A task's SHSTK is allocated from memory to a fixed size of
> > +RLIMIT_STACK.
> 
> I can't really parse that sentence.  Is this saying that shadow stacks
> are limited by and share space with normal stacks via RLIMIT_STACK?
> 
> >  A compat-mode thread's SHSTK size is 1/4 of
> > +RLIMIT_STACK.  The smaller 32-bit thread SHSTK allows more threads to
> > +share a 32-bit address space.
> 
> I thought the size was passed in from userspace?  Where does this sizing
> take place?  Is this a convention or is it being enforced?

I will make this (and other things you pointed out) clear in the next
version.

Yu-cheng

