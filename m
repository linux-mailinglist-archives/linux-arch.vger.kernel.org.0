Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E41F193306
	for <lists+linux-arch@lfdr.de>; Wed, 25 Mar 2020 22:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgCYVvP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Mar 2020 17:51:15 -0400
Received: from mga14.intel.com ([192.55.52.115]:65091 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgCYVvO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 25 Mar 2020 17:51:14 -0400
IronPort-SDR: djFS2Wy2Bm0pYdKq90Kv16FTpCEzT3qGacrldRkPofD7BLTfivDxiwADK4KH3gQfJe67tkWQEH
 XYYarTIaPd7A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 14:51:14 -0700
IronPort-SDR: 6xgudFIjy1CzWRRc48LtFdeAxHVrlYFfTo63YZE4NYbvMjdkFxHVPJPGrO+UNQp0Xr2jTj3nKa
 WTzhXN/fIh5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,305,1580803200"; 
   d="scan'208";a="238631971"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga007.fm.intel.com with ESMTP; 25 Mar 2020 14:51:14 -0700
Message-ID: <e1122e1d77dec0d5f0a698c855833050c740a4bc.camel@intel.com>
Subject: Re: [RFC PATCH v9 25/27] x86/cet/shstk: Handle thread Shadow Stack
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Date:   Wed, 25 Mar 2020 14:51:13 -0700
In-Reply-To: <202002251324.5D515260@keescook>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
         <20200205181935.3712-26-yu-cheng.yu@intel.com>
         <202002251324.5D515260@keescook>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2020-02-25 at 13:29 -0800, Kees Cook wrote:
> On Wed, Feb 05, 2020 at 10:19:33AM -0800, Yu-cheng Yu wrote:
> > [...]
> > A 64-bit SHSTK has a fixed size of RLIMIT_STACK. A compat-mode thread SHSTK
> > has a fixed size of 1/4 RLIMIT_STACK.  This allows more threads to share a
> > 32-bit address space.
> 
> I am not understanding this part. :) Entries are sizeof(unsigned long),
> yes? A 1/2 RLIMIT_STACK would cover 32-bit, but 1/4 is less, so why does
> that provide for more threads?

Each thread has a separate shadow stack.  If each shadow stack is smaller, the
address space can accommodate more shadow stack allocations.

> >[...]
> > diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
> > index cba5c7656aab..5b45abda80a1 100644
> > --- a/arch/x86/kernel/cet.c
> > +++ b/arch/x86/kernel/cet.c
> > @@ -170,6 +170,47 @@ int cet_setup_shstk(void)
> >  	return 0;
> >  }
> >  
> > +int cet_setup_thread_shstk(struct task_struct *tsk)
> > +{
> > +	unsigned long addr, size;
> > +	struct cet_user_state *state;
> > +	struct cet_status *cet = &tsk->thread.cet;
> > +
> > +	if (!cet->shstk_enabled)
> > +		return 0;
> > +
> > +	state = get_xsave_addr(&tsk->thread.fpu.state.xsave,
> > +			       XFEATURE_CET_USER);
> > +
> > +	if (!state)
> > +		return -EINVAL;
> > +
> > +	size = rlimit(RLIMIT_STACK);
> 
> Is SHSTK incompatible with RLIM_INFINITY stack rlimits?

I will change it to:

	size = min(rlimit(RLIMIT_STACK), 4 GB);

> 
> > +
> > +	/*
> > +	 * Compat-mode pthreads share a limited address space.
> > +	 * If each function call takes an average of four slots
> > +	 * stack space, we need 1/4 of stack size for shadow stack.
> > +	 */
> > +	if (in_compat_syscall())
> > +		size /= 4;
> > +
> > +	addr = alloc_shstk(size);
> 
> I assume it'd fail here, but I worry about Stack Clash style attacks.
> I'd like to see test cases that make sure the SHSTK gap is working
> correctly.

I will work on some tests.

Thanks,
Yu-cheng


