Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14D705C408
	for <lists+linux-arch@lfdr.de>; Mon,  1 Jul 2019 21:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfGAT5Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Jul 2019 15:57:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:12848 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbfGAT5Q (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Jul 2019 15:57:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jul 2019 12:57:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,440,1557212400"; 
   d="scan'208";a="361947326"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by fmsmga005.fm.intel.com with ESMTP; 01 Jul 2019 12:57:15 -0700
Message-ID: <c99aa450d6cc9a0d23d24734a165e5ffbd9ecc7a.camel@intel.com>
Subject: Re: [RFC PATCH 3/3] Prevent user from writing to IBT bitmap.
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
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
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
Date:   Mon, 01 Jul 2019 12:48:56 -0700
In-Reply-To: <CALCETrXsXXJWTSJxUO8YxHUo=QJKmHyJa7iz+jOBjWMRhno4rA@mail.gmail.com>
References: <20190628194158.2431-1-yu-cheng.yu@intel.com>
         <20190628194158.2431-3-yu-cheng.yu@intel.com>
         <CALCETrXsXXJWTSJxUO8YxHUo=QJKmHyJa7iz+jOBjWMRhno4rA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 2019-06-29 at 16:44 -0700, Andy Lutomirski wrote:
> On Fri, Jun 28, 2019 at 12:50 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> > 
> > The IBT bitmap is visiable from user-mode, but not writable.
> > 
> > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> > 
> > ---
> >  arch/x86/mm/fault.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > index 59f4f66e4f2e..231196abb62e 100644
> > --- a/arch/x86/mm/fault.c
> > +++ b/arch/x86/mm/fault.c
> > @@ -1454,6 +1454,13 @@ void do_user_addr_fault(struct pt_regs *regs,
> >          * we can handle it..
> >          */
> >  good_area:
> > +#define USER_MODE_WRITE (FAULT_FLAG_WRITE | FAULT_FLAG_USER)
> > +       if (((flags & USER_MODE_WRITE)  == USER_MODE_WRITE) &&
> > +           (vma->vm_flags & VM_IBT)) {
> > +               bad_area_access_error(regs, hw_error_code, address, vma);
> > +               return;
> > +       }
> > +
> 
> Just make the VMA have VM_WRITE and VM_MAYWRITE clear.  No new code
> like this should be required.

Ok, I will work on that.

Thanks,
Yu-cheng
