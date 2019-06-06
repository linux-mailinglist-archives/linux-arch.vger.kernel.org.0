Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AABD3806B
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2019 00:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbfFFWS6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jun 2019 18:18:58 -0400
Received: from mga18.intel.com ([134.134.136.126]:41329 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbfFFWS6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Jun 2019 18:18:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2019 15:18:57 -0700
X-ExtLoop1: 1
Received: from yyu32-desk1.sc.intel.com ([143.183.136.147])
  by orsmga004.jf.intel.com with ESMTP; 06 Jun 2019 15:18:56 -0700
Message-ID: <93ee5b103b8261d2b50de89f8658d133639a9af5.camel@intel.com>
Subject: Re: [PATCH v7 04/27] x86/fpu/xstate: Introduce XSAVES system states
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@amacapital.net>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
Date:   Thu, 06 Jun 2019 15:10:55 -0700
In-Reply-To: <4effb749-0cdc-6a49-6352-7b2d4aa7d866@intel.com>
References: <20190606200646.3951-1-yu-cheng.yu@intel.com>
         <20190606200646.3951-5-yu-cheng.yu@intel.com>
         <0a2f8b9b-b96b-06c8-bae0-b78b2ca3b727@intel.com>
         <5EE146A8-6C8C-4C5D-B7C0-AB8AD1012F1E@amacapital.net>
         <4effb749-0cdc-6a49-6352-7b2d4aa7d866@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2019-06-06 at 15:08 -0700, Dave Hansen wrote:
> 
> On 6/6/19 3:04 PM, Andy Lutomirski wrote:
> > > But, that seems broken.  If we have supervisor state, we can't 
> > > always defer the load until return to userspace, so we'll never?? 
> > > have TIF_NEED_FPU_LOAD.  That would certainly be true for 
> > > cet_kernel_state.
> > 
> > Ugh. I was sort of imagining that we would treat supervisor state
> 
>  completely separately from user state.  But can you maybe give
> examples of exactly what you mean?
> > 
> > > It seems like we actually need three classes of XSAVE states: 1. 
> > > User state
> > 
> > This is FPU, XMM, etc, right?
> 
> Yep.
> 
> > > 2. Supervisor state that affects user mode
> > 
> > User CET?
> 
> Yep.
> 
> > > 3. Supervisor state that affects kernel mode
> > 
> > Like supervisor CET?  If we start doing supervisor shadow stack, the 
> > context switches will be real fun.  We may need to handle this in 
> > asm.
> 
> Yeah, that's what I was thinking.
> 
> I have the feeling Yu-cheng's patches don't comprehend this since
> Sebastian's patches went in after he started working on shadow stacks.
> 
> > Where does PKRU fit in?  Maybe we can treat it as #3?
> 
> I thought Sebastian added specific PKRU handling to make it always
> eager.  It's actually user state that affect kernel mode. :)

For CET user states, we need to restore before making changes.  If they are not
being changed (i.e. signal handling and syscalls), then they are restored only
before going back to user-mode.

For CET kernel states, we only need to make small changes in the way similar to
the PKRU handling, right?  We'll address it when sending CET kernel-mode
patches.

I will put in more comments as suggested by Dave in earlier emails.

Yu-cheng
