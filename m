Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28A5E391D7
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2019 18:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbfFGQY3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Jun 2019 12:24:29 -0400
Received: from mga03.intel.com ([134.134.136.65]:24376 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730446AbfFGQY3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 7 Jun 2019 12:24:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2019 09:24:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,563,1557212400"; 
   d="scan'208";a="182719826"
Received: from yyu32-desk1.sc.intel.com ([143.183.136.147])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jun 2019 09:24:27 -0700
Message-ID: <ea07ae367f9d130cfe7a3e508d478956c2bf47a7.camel@intel.com>
Subject: Re: [PATCH v7 18/27] mm: Introduce do_mmap_locked()
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
Date:   Fri, 07 Jun 2019 09:16:26 -0700
In-Reply-To: <20190607074707.GD3463@hirez.programming.kicks-ass.net>
References: <20190606200646.3951-1-yu-cheng.yu@intel.com>
         <20190606200646.3951-19-yu-cheng.yu@intel.com>
         <20190607074322.GP3419@hirez.programming.kicks-ass.net>
         <20190607074707.GD3463@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2019-06-07 at 09:47 +0200, Peter Zijlstra wrote:
> On Fri, Jun 07, 2019 at 09:43:22AM +0200, Peter Zijlstra wrote:
> > On Thu, Jun 06, 2019 at 01:06:37PM -0700, Yu-cheng Yu wrote:
> > > There are a few places that need do_mmap() with mm->mmap_sem held.
> > > Create an in-line function for that.
> > > 
> > > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> > > ---
> > >  include/linux/mm.h | 18 ++++++++++++++++++
> > >  1 file changed, 18 insertions(+)
> > > 
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index 398f1e1c35e5..7cf014604848 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -2411,6 +2411,24 @@ static inline void mm_populate(unsigned long addr,
> > > unsigned long len)
> > >  static inline void mm_populate(unsigned long addr, unsigned long len) {}
> > >  #endif
> > >  
> > > +static inline unsigned long do_mmap_locked(unsigned long addr,
> > > +	unsigned long len, unsigned long prot, unsigned long flags,
> > > +	vm_flags_t vm_flags)
> > > +{
> > > +	struct mm_struct *mm = current->mm;
> > > +	unsigned long populate;
> > > +
> > > +	down_write(&mm->mmap_sem);
> > > +	addr = do_mmap(NULL, addr, len, prot, flags, vm_flags, 0,
> > > +		       &populate, NULL);
> > 
> > Funny thing how do_mmap() takes a file pointer as first argument and
> > this thing explicitly NULLs that. That more or less invalidates the name
> > do_mmap_locked().
> > 
> > > +	up_write(&mm->mmap_sem);
> > > +
> > > +	if (populate)
> > > +		mm_populate(addr, populate);
> > > +
> > > +	return addr;
> > > +}
> 
> You also don't retain that last @uf argument.
> 
> I'm thikning you're better off adding a helper to the cet.c file; call
> it cet_mmap() or whatever.

Ok, I will fix that.

Yu-cheng
