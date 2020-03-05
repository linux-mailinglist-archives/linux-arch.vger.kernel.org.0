Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C73FC17AFE5
	for <lists+linux-arch@lfdr.de>; Thu,  5 Mar 2020 21:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgCEUoV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Mar 2020 15:44:21 -0500
Received: from mga04.intel.com ([192.55.52.120]:1390 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbgCEUoV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 5 Mar 2020 15:44:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 12:44:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,519,1574150400"; 
   d="scan'208";a="244396203"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga006.jf.intel.com with ESMTP; 05 Mar 2020 12:44:19 -0800
Message-ID: <6e9214021448a04bfad823535eaa2320496fdabf.camel@intel.com>
Subject: Re: [RFC PATCH v9 04/27] x86/cet: Add control-protection fault
 handler
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
Date:   Thu, 05 Mar 2020 12:44:19 -0800
In-Reply-To: <0bc74a85-7058-0cca-62b8-949c8a881c62@intel.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
         <20200205181935.3712-5-yu-cheng.yu@intel.com>
         <0bc74a85-7058-0cca-62b8-949c8a881c62@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2020-02-26 at 09:10 -0800, Dave Hansen wrote:
> On 2/5/20 10:19 AM, Yu-cheng Yu wrote:
> > diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
> > index 87ef69a72c52..8ed406f469e7 100644
> > --- a/arch/x86/kernel/idt.c
> > +++ b/arch/x86/kernel/idt.c
> > @@ -102,6 +102,10 @@ static const __initconst struct idt_data def_idts[] = {
> >  #elif defined(CONFIG_X86_32)
> >  	SYSG(IA32_SYSCALL_VECTOR,	entry_INT80_32),
> >  #endif
> > +
> > +#ifdef CONFIG_X86_64
> > +	INTG(X86_TRAP_CP,		control_protection),
> > +#endif
> >  };
> 
> This patch in particular appears to have all of its code unconditionally
> compiled in.  That's in contrast to things that have Kconfig options, like:
> 
> #ifdef CONFIG_X86_MCE
>         INTG(X86_TRAP_MC,               &machine_check),
> #endif
> 
> or:
> 
> #ifdef CONFIG_X86_THERMAL_VECTOR
>         INTG(THERMAL_APIC_VECTOR,       thermal_interrupt),
> #endif
> 
> Is there a reason this code is always compiled in on 64-bit even when
> the config option is off?

I will change it to CONFIG_X86_INTEL_CET.

Yu-cheng

