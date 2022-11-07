Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64E561FDB1
	for <lists+linux-arch@lfdr.de>; Mon,  7 Nov 2022 19:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbiKGSjG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Nov 2022 13:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbiKGSis (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Nov 2022 13:38:48 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E2E2AE02;
        Mon,  7 Nov 2022 10:37:23 -0800 (PST)
Received: from zn.tnic (p200300ea9733e71f329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e71f:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 76AF71EC059D;
        Mon,  7 Nov 2022 19:37:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667846242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ltXQMShsByXnuTxy9rVs5hzHUnj2fKxptiwJ6JDDxxI=;
        b=WswS6nowYrD7HOA1CKiSinEVVs19Mx1DZJ4uL8wIXOH8iq5mjHNOq5BUqN3Zi+F/VLE5k4
        sbVF7XPPF4xDL9ywiYCT7mZkuO35NXnjOevEOCyiB0ycO0OzCbdJ4AyaaigoYMoFwkjTLy
        jP11GdsqJjf3Gl9rB7peaxnb7aCERuA=
Date:   Mon, 7 Nov 2022 19:37:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 04/37] x86/cpufeatures: Enable CET CR4 bit for shadow
 stack
Message-ID: <Y2lQXXCQRTiYljIg@zn.tnic>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
 <20221104223604.29615-5-rick.p.edgecombe@intel.com>
 <Y2lHxb5BnbQi499s@zn.tnic>
 <14b4c6e3d5b7b259e832ff44e64597f1cf344ffe.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <14b4c6e3d5b7b259e832ff44e64597f1cf344ffe.camel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 07, 2022 at 06:19:48PM +0000, Edgecombe, Rick P wrote:
> It was to catch if the software user shadow stack feature gets disabled
> at boot with the "clearcpuid" command.

I don't understand. clearcpuid does setup_clear_cpu_cap() too. It would
eventually clear the bit in boot_cpu_data.x86_capability's AFAICT.

cpu_feature_enabled() looks at boot_cpu_data too.

So what's the problem?

Oh, and also, you've added that clearcpuid thing to the help docs.
Please remove it. clearcpuid= taints the kernel and we've left it in
because some of your colleagues really wanted it for testing or whatnot.
But it is crap and it was on its way out at some point so we better not
proliferate its use any more.

> Is there a better way to do this?

Yeah, cpu_feature_enabled() should be enough and if it isn't, then we
need to fix it to be.

Which reminds me, I'd need to take Maxim's patch too:

https://lore.kernel.org/r/20220718141123.136106-3-mlevitsk@redhat.com

as it is a simplification.

> > Here you need to do
> > 
> > 	setup_clear_cpu_cap(X86_FEATURE_IBT);
> > 	setup_clear_cpu_cap(X86_FEATURE_SHSTK);
> 
> This only gets called by kexec way after boot, as kexec is prepping to
> transition to the new kernel. Do we want to be clearing feature bits at
> that time?

Hmm, I was under the impression you'll have the usual chicken bit
"noshstk" which gets added with every big feature. So it'll call that
thing here.

> Sure, sorry about that. I'll target tip for the next version.

Thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
