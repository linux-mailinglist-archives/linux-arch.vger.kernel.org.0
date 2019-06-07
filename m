Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06E5939285
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2019 18:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbfFGQxF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Jun 2019 12:53:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:40312 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729172AbfFGQxF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 7 Jun 2019 12:53:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2019 09:53:04 -0700
X-ExtLoop1: 1
Received: from yyu32-desk1.sc.intel.com ([143.183.136.147])
  by fmsmga005.fm.intel.com with ESMTP; 07 Jun 2019 09:53:03 -0700
Message-ID: <ac8827d7b516f4b58e1df20f45b94998d36c418c.camel@intel.com>
Subject: Re: [PATCH v7 03/14] x86/cet/ibt: Add IBT legacy code bitmap setup
 function
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
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
Date:   Fri, 07 Jun 2019 09:45:02 -0700
In-Reply-To: <76B7B1AE-3AEA-4162-B539-990EF3CCE2C2@amacapital.net>
References: <20190606200926.4029-1-yu-cheng.yu@intel.com>
         <20190606200926.4029-4-yu-cheng.yu@intel.com>
         <20190607080832.GT3419@hirez.programming.kicks-ass.net>
         <aa8a92ef231d512b5c9855ef416db050b5ab59a6.camel@intel.com>
         <76B7B1AE-3AEA-4162-B539-990EF3CCE2C2@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2019-06-07 at 09:35 -0700, Andy Lutomirski wrote:
> > On Jun 7, 2019, at 9:23 AM, Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> > 
> > > On Fri, 2019-06-07 at 10:08 +0200, Peter Zijlstra wrote:
> > > > On Thu, Jun 06, 2019 at 01:09:15PM -0700, Yu-cheng Yu wrote:
> > > > Indirect Branch Tracking (IBT) provides an optional legacy code bitmap
> > > > that allows execution of legacy, non-IBT compatible library by an
> > > > IBT-enabled application.  When set, each bit in the bitmap indicates
> > > > one page of legacy code.
> > > > 
> > > > The bitmap is allocated and setup from the application.
> > > > +int cet_setup_ibt_bitmap(unsigned long bitmap, unsigned long size)
> > > > +{
> > > > +    u64 r;
> > > > +
> > > > +    if (!current->thread.cet.ibt_enabled)
> > > > +        return -EINVAL;
> > > > +
> > > > +    if (!PAGE_ALIGNED(bitmap) || (size > TASK_SIZE_MAX))
> > > > +        return -EINVAL;
> > > > +
> > > > +    current->thread.cet.ibt_bitmap_addr = bitmap;
> > > > +    current->thread.cet.ibt_bitmap_size = size;
> > > > +
> > > > +    /*
> > > > +     * Turn on IBT legacy bitmap.
> > > > +     */
> > > > +    modify_fpu_regs_begin();
> > > > +    rdmsrl(MSR_IA32_U_CET, r);
> > > > +    r |= (MSR_IA32_CET_LEG_IW_EN | bitmap);
> > > > +    wrmsrl(MSR_IA32_U_CET, r);
> > > > +    modify_fpu_regs_end();
> > > > +
> > > > +    return 0;
> > > > +}
> > > 
> > > So you just program a random user supplied address into the hardware.
> > > What happens if there's not actually anything at that address or the
> > > user munmap()s the data after doing this?
> > 
> > This function checks the bitmap's alignment and size, and anything else is
> > the
> > app's responsibility.  What else do you think the kernel should check?
> > 
> 
> One might reasonably wonder why this state is privileged in the first place
> and, given that, why we’re allowing it to be written like this.
> 
> Arguably we should have another prctl to lock these values (until exec) as a
> gardening measure.

We can prevent the bitmap from being set more than once.  I will test it.

Yu-cheng
