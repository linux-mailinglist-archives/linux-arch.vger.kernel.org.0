Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9F2D17C580
	for <lists+linux-arch@lfdr.de>; Fri,  6 Mar 2020 19:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgCFShO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Mar 2020 13:37:14 -0500
Received: from mga12.intel.com ([192.55.52.136]:28577 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgCFShO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Mar 2020 13:37:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 10:37:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,523,1574150400"; 
   d="scan'208";a="275637536"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga002.fm.intel.com with ESMTP; 06 Mar 2020 10:37:13 -0800
Message-ID: <070d9d78981f0aad2baf740233e8dfc32ecd29d7.camel@intel.com>
Subject: Re: [RFC PATCH v9 05/27] x86/cet/shstk: Add Kconfig option for
 user-mode Shadow Stack protection
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
Date:   Fri, 06 Mar 2020 10:37:13 -0800
In-Reply-To: <d4dabb84-5636-2657-c45e-795f3f2dcbbc@intel.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
         <20200205181935.3712-6-yu-cheng.yu@intel.com>
         <d4dabb84-5636-2657-c45e-795f3f2dcbbc@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2020-02-26 at 10:05 -0800, Dave Hansen wrote:
> On 2/5/20 10:19 AM, Yu-cheng Yu wrote:
> > +# Check assembler Shadow Stack suppot
> 
> 				  ^ support
> 
> > +ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
> > +  ifeq ($(call as-instr, saveprevssp, y),)
> > +      $(error CONFIG_X86_INTEL_SHADOW_STACK_USER not supported by the assembler)
> > +  endif
> > +endif
> 
> Is this *just* looking for instruction support in the assembler?
> 
> We usually just .byte them, like this for pkeys:
> 
>         asm volatile(".byte 0x0f,0x01,0xee\n\t"
>                      : "=a" (pkru), "=d" (edx)
>                      : "c" (ecx));
> 
> That way everybody with old toolchains can still build the kernel (and
> run/test code with your config option on, btw...).

We used to do this for CET instructions, but after adding kernel-mode
instructions and inserting ENDBR's, the code becomes cluttered.  I also
found an earlier discussion on the ENDBR:

https://lore.kernel.org/lkml/CALCETrVRH8LeYoo7V1VBPqg4WS0Enxtizt=T7dPvgoeWfJrdzA@mail.gmail.com/

It makes sense to let the user know early on that the system cannot support
CET and cannot build a CET-enabled kernel.

One thing we can do is to disable CET in Kconfig and not in kernel
build, which I will do in the next version.

Yu-cheng

