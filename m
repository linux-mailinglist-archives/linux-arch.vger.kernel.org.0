Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB551DEB83
	for <lists+linux-arch@lfdr.de>; Fri, 22 May 2020 17:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbgEVPKK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 May 2020 11:10:10 -0400
Received: from mga12.intel.com ([192.55.52.136]:38059 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729931AbgEVPKK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 May 2020 11:10:10 -0400
IronPort-SDR: tPfV+Jvicw1Ya/yQczp8lMnqPu1DcTSmYnFSO2Fo4vjKg9wqZ3INEtZiE+he/WcpLwsIdBeGBV
 c2LmAs5gyDAw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 08:10:09 -0700
IronPort-SDR: ICX66KiVS7ynOm0TtiHoLqVvaMKYuZAKDIVrXtjZd+youn2HnEcznyDbZ3QRNEjO4m32Md26v3
 gzK5lB5dFfwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,422,1583222400"; 
   d="scan'208";a="344197433"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga001.jf.intel.com with ESMTP; 22 May 2020 08:10:08 -0700
Message-ID: <cc3d7668eb7dd738a85f0b0935624496efae43be.camel@intel.com>
Subject: Re: [RFC PATCH 5/5] selftest/x86: Add CET quick test
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Date:   Fri, 22 May 2020 08:10:14 -0700
In-Reply-To: <20200522092848.GJ325280@hirez.programming.kicks-ass.net>
References: <20200521211720.20236-1-yu-cheng.yu@intel.com>
         <20200521211720.20236-6-yu-cheng.yu@intel.com>
         <20200522092848.GJ325280@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2020-05-22 at 11:28 +0200, Peter Zijlstra wrote:
> On Thu, May 21, 2020 at 02:17:20PM -0700, Yu-cheng Yu wrote:
> 
> > +#pragma GCC push_options
> > +#pragma GCC optimize ("O0")
> > +void ibt_violation(void)
> > +{
> > +#ifdef __i386__
> > +	asm volatile("lea 1f, %eax");
> > +	asm volatile("jmp *%eax");
> > +#else
> > +	asm volatile("lea 1f, %rax");
> > +	asm volatile("jmp *%rax");
> > +#endif
> > +	asm volatile("1:");
> > +	result[test_id] = -1;
> > +	test_id++;
> > +	setcontext(&ucp);
> > +}
> > +
> > +void shstk_violation(void)
> > +{
> > +#ifdef __i386__
> > +	unsigned long x = 0;
> > +
> > +	((unsigned long *)&x)[2] = (unsigned long)stack_hacked;
> > +#else
> > +	unsigned long long x = 0;
> > +
> > +	((unsigned long long *)&x)[2] = (unsigned long)stack_hacked;
> > +#endif
> > +}
> > +#pragma GCC pop_options
> 
> This is absolutely atrocious.
> 
> The #pragma like Kees already said just need to go. Also, there's
> absolutely no clue what so ever what it attempts to achieve.
> 
> The __i386__ ifdeffery is horrible crap. Splitting an asm with #ifdef
> like that is also horrible crap.
> 
> This is not how you write code.
> 
> Get asm/asm.h into userspace and then write something like:
> 
> 
> void ibt_violation(void)
> {
> 	asm volatile("lea  1f, %" _ASM_AX "\n\t"
> 		     "jmp  *%" _ASM_AX "\n\t"
> 		     "1:\n\t" ::: "a");
> 
> 	WRITE_ONCE(result[test_id], -1);
> 	WRITE_ONCE(test_id, test_id+1);
> 
> 	setcontext(&ucp);
> }
> 
> void shstk_violation(void)
> {
> 	unsigned long x = 0;
> 
> 	WRITE_ONCE(x[2], stack_hacked);
> }

Thanks!  I will change it.

Yu-cheng

