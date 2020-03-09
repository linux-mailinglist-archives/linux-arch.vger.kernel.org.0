Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBCCC17E863
	for <lists+linux-arch@lfdr.de>; Mon,  9 Mar 2020 20:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgCIT1a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Mar 2020 15:27:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:20358 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbgCIT1a (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 9 Mar 2020 15:27:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 12:27:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,534,1574150400"; 
   d="scan'208";a="414918030"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga005.jf.intel.com with ESMTP; 09 Mar 2020 12:27:28 -0700
Message-ID: <fed72ecc917373669ac546d4e8214793d78bd513.camel@intel.com>
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
Date:   Mon, 09 Mar 2020 12:27:28 -0700
In-Reply-To: <968af1c2-a5b4-fb48-dfa9-499ec37f677c@intel.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
         <20200205181935.3712-2-yu-cheng.yu@intel.com>
         <9ae1cf84-1d84-1d34-c0ce-48b0d70b8f3f@intel.com>
         <0f43463e02d1be2af6bcf8ff6917e751ba7676a0.camel@intel.com>
         <968af1c2-a5b4-fb48-dfa9-499ec37f677c@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2020-03-09 at 10:21 -0700, Dave Hansen wrote:
> On 3/9/20 10:00 AM, Yu-cheng Yu wrote:
> > On Wed, 2020-02-26 at 09:57 -0800, Dave Hansen wrote:
> > > > index ade4e6ec23e0..8b69ebf0baed 100644
> > > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > > @@ -3001,6 +3001,12 @@
> > > >  			noexec=on: enable non-executable mappings (default)
> > > >  			noexec=off: disable non-executable mappings
> > > >  
> > > > +	no_cet_shstk	[X86-64] Disable Shadow Stack for user-mode
> > > > +			applications
> > > 
> > > If we ever add kernel support, "no_cet_shstk" will mean "no cet shstk
> > > for userspace"?
> > 
> > What about no_user_shstk, no_kernel_shstk?

[...]

> > > > +Note:
> > > > +  There is no CET-enabling arch_prctl function.  By design, CET is
> > > > +  enabled automatically if the binary and the system can support it.
> > > 
> > > This is kinda interesting.  It means that a JIT couldn't choose to
> > > protect the code it generates and have different rules from itself?
> > 
> > JIT needs to be updated for CET first.  Once that is done, it runs with CET
> > enabled.  It can use the NOTRACK prefix, for example.
> 
> Am I missing something?
> 
> What's the direct connection between shadow stacks and Indirect Branch
> Tracking other than Intel marketing umbrellas?

What I meant is that JIT code needs to be updated first; if it skips RETs,
it needs to unwind the stack, and if it does indirect JMPs somewhere it
needs to fix up the branch target or use NOTRACK.

> > > > +  The parameters passed are always unsigned 64-bit.  When an IA32
> > > > +  application passing pointers, it should only use the lower 32 bits.
> > > 
> > > Won't a 32-bit app calling prctl() use the 32-bit ABI?  How would it
> > > even know it's running on a 64-bit kernel?
> > 
> > The 32-bit app is passing only a pointer to an array of 64-bit numbers.
> 
> Well, the documentation just talked about pointers and I naively assume
> it means the "unsigned long *" you had in there.
> 
> Rather than make suggestions, just say that the ABI is universally
> 64-bit.  Saying that the pointers must be valid is just kinda silly.
> It's also not 100% clear what an "IA32 application" *MEANS* given fun
> things like x32.

Ok, I will update the text.

> 
> Also, I went to go find this implementation in your series.  I couldn't
> find it.  Did I miss a patch?  Or are you documenting things you didn't
> even implement?

In patch #27: Add arch_prctl functions for Shadow Stack.

Yu-cheng

