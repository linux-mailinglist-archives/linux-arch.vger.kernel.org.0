Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4829365D30A
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jan 2023 13:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjADMuT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Jan 2023 07:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjADMuR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Jan 2023 07:50:17 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8A91704B;
        Wed,  4 Jan 2023 04:50:16 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E1EFD1EC02DD;
        Wed,  4 Jan 2023 13:50:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672836615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2QcybxR9ZjqVi2pA+cenn1kHGCAZq3Ei7zS8JekyCcI=;
        b=aETOzOZvJlnJF8PfQBrcbuWt6IltMqy9vcCU1WOK+/7n/uCZUVIUBT4bisySQHxERCl0mf
        OST8S8/arWL4feZYPq4MxP06osGgTxi6YtCg/VuOMT4bTM8pc7chrrT1jm0zzHC5aDr6Pw
        lLQisN7O9IRC95JCUYxfent3UOPuUXg=
Date:   Wed, 4 Jan 2023 13:50:10 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "jannh@google.com" <jannh@google.com>,
        "x86@kernel.org" <x86@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v4 07/39] x86: Add user control-protection fault handler
Message-ID: <Y7V2AjJsfBnk4Ibx@zn.tnic>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
 <20221203003606.6838-8-rick.p.edgecombe@intel.com>
 <Y6HglBhrccduDTQA@zn.tnic>
 <3aaf1b0d67492415acb9b3d06bb97e916cb7b77a.camel@intel.com>
 <Y6Li9oIl/tK96KUf@zn.tnic>
 <0e529db5f814ef7af7b197962c752a1454510a49.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0e529db5f814ef7af7b197962c752a1454510a49.camel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 21, 2022 at 09:42:50PM +0000, Edgecombe, Rick P wrote:
> Oh, you mean the whole Kconfig thing. Yea, I mean I see the point about
> typical configs. But at least CONFIG_X86_CET seems consistent with
> CONFIG_INTEL_TDX_GUEST, CONFIG_IOMMU_SVA, etc.
> 
> What about moving it out of traps.c to a cet.c, like
> exc_vmm_communication for CONFIG_AMD_MEM_ENCRT? Then the inclusion
> logic lives in the build files, instead of an ifdef.

Yeah, that definitely sounds cleaner. Another example would be the #MC handler
being in mce code and not in traps.c.

So yeah, the reason why I'm even mentioning this is that I get an allergic
reaction when I see unwieldy ifdeffery in one screen worth of code. But this is
just me. :)

> One aspect that has come up a couple of times, is how closely related
> all these CET features are (or aren't). Shadow stack and IBT are mostly
> separate, but do share an xfeature and an exception type. Similarly for
> supervisor and user mode support for either of the CET features. So
> maybe that is what is unusual here. There are some aspects that make
> them look like separate features, which leads people to think they
> should be separate in the code. But actually separating them leads to
> excess ifdefery.

Yeah, I think you solved that correctly by having the common X86_CET symbol
selected by the two.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
