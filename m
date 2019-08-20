Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2821796617
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2019 18:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbfHTQRm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Aug 2019 12:17:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:58739 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfHTQRm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Aug 2019 12:17:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 09:17:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
   d="scan'208";a="169130943"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by orsmga007.jf.intel.com with ESMTP; 20 Aug 2019 09:17:39 -0700
Message-ID: <fb058c3d56bb070706aa5f8502b4d8f0da265b74.camel@intel.com>
Subject: Re: [PATCH v8 18/27] mm: Introduce do_mmap_locked()
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
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
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
Date:   Tue, 20 Aug 2019 09:08:34 -0700
In-Reply-To: <20190820010200.GI1916@linux.intel.com>
References: <20190813205225.12032-1-yu-cheng.yu@intel.com>
         <20190813205225.12032-19-yu-cheng.yu@intel.com>
         <20190820010200.GI1916@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2019-08-19 at 18:02 -0700, Sean Christopherson wrote:
> On Tue, Aug 13, 2019 at 01:52:16PM -0700, Yu-cheng Yu wrote:
> > There are a few places that need do_mmap() with mm->mmap_sem held.
> > Create an in-line function for that.
> > 
> > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> > ---
> >  include/linux/mm.h | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index bc58585014c9..275c385f53c6 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2394,6 +2394,24 @@ static inline void mm_populate(unsigned long addr,
> > unsigned long len)
> >  static inline void mm_populate(unsigned long addr, unsigned long len) {}
> >  #endif
> >  
> > +static inline unsigned long do_mmap_locked(struct file *file,
> > +	unsigned long addr, unsigned long len, unsigned long prot,
> > +	unsigned long flags, vm_flags_t vm_flags, struct list_head *uf)
> > +{
> > +	struct mm_struct *mm = current->mm;
> > +	unsigned long populate;
> > +
> > +	down_write(&mm->mmap_sem);
> > +	addr = do_mmap(file, addr, len, prot, flags, vm_flags, 0,
> > +		       &populate, uf);
> > +	up_write(&mm->mmap_sem);
> > +
> > +	if (populate)
> > +		mm_populate(addr, populate);
> > +
> > +	return addr;
> > +}
> 
> Any reason not to put this in cet.c, as suggested by PeterZ?  All of the
> calls from CET have identical params except for @len, e.g. you can add
> 'static unsigned long cet_mmap(unsigned long len)' and bury most of the
> copy-paste code in there.
> 
> https://lkml.kernel.org/r/20190607074707.GD3463@hirez.programming.kicks-ass.ne
> t

Yes, I will do that.  I thought this would be useful in other places, but
currently only in mpx.c.

Yu-cheng
