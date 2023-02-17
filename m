Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F6B69B047
	for <lists+linux-arch@lfdr.de>; Fri, 17 Feb 2023 17:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjBQQMG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Feb 2023 11:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBQQMF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Feb 2023 11:12:05 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2C071495;
        Fri, 17 Feb 2023 08:11:41 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 98D951EC0947;
        Fri, 17 Feb 2023 17:11:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676650299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4y1K+ippPallw44msMIiTOwFvw7Y/qQvd/jrIKuWufQ=;
        b=pC0kWiA8XgbbDqXoBi0ZQAhCQQnBzSEOtx+o6/Z3o1Bmsd/vToZtakDOiDpFp68pxrqaoi
        I5pLmz/+ZlM8JR8KIK4/kruEfhCaPEV/O8VJmUVFzMef3BCF7EMkt0WDHDIjC7+2vCaCL/
        wXw8LH85DU+DgfJWSHEHhvlJl91iUXs=
Date:   Fri, 17 Feb 2023 17:11:35 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v5 11/39] x86/mm: Update pte_modify for _PAGE_COW
Message-ID: <Y++nN8x08RopoWJr@zn.tnic>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119212317.8324-12-rick.p.edgecombe@intel.com>
 <Y+T+ZxydCZS1Yjmz@zn.tnic>
 <49d20fcd197e85e8475f5170db78780f06396cc0.camel@intel.com>
 <Y+ZNL4o57lCrmwpb@zn.tnic>
 <15c76808ac5975df2294d0c7edf0abfe8587da2d.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <15c76808ac5975df2294d0c7edf0abfe8587da2d.camel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 10, 2023 at 05:00:05PM +0000, Edgecombe, Rick P wrote:
> 	/*
> 	 * Dirty bit is not preserved above so it can be done
> 	 * in a special way for the shadow stack case, where it
> 	 * may need to set _PAGE_SAVED_DIRTY. __pte_mkdirty() will do
> 	 * this in the case of shadow stack.
> 	 */
> 	if (oldval & _PAGE_DIRTY)
> 		if (cpu_feature_enabled(X86_FEATURE_USER_SHSTK) &&
> 		    !pte_write(pte_result))
> 			pte_set_flags(pte_result, _PAGE_SAVED_DIRTY);
> 		else
> 			pte_set_flags(pte_result, _PAGE_DIRTY);
> 	}
> 
> 	return pte_result;
> }
> 
> So the later logic of doing the _PAGE_SAVED_DIRTY (_PAGE_COW) part is
> not centralized. It's ok?

I think so.

1. If you have a single pte_mkdirty() and not also a __ helper, then
   there's less confusion for callers as to which interface they should be
   using

2. The not centralized part is a single conditional so it's not like
   you're saving on gazillion code lines

So I'd prefer that.

If we end up needing this in more places then we can carve it out into
a proper helper which is not in a header file such that anyone can use
it but move the whole functionality into cet.c or so where we can
control its visibility to the rest of the kernel.

I'd say.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
