Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABAD6B0217
	for <lists+linux-arch@lfdr.de>; Wed,  8 Mar 2023 09:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjCHIyF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Mar 2023 03:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjCHIyE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Mar 2023 03:54:04 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02149580E8;
        Wed,  8 Mar 2023 00:54:01 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0D24B1EC068F;
        Wed,  8 Mar 2023 09:54:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1678265640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Lx+RtzEAI/Slt9PnACaAiwIIiVncBJt8vf25npLTWIw=;
        b=Tq5bUtS4Q5K9bX5guN+oxYuAy7F6QgZ2H55hEoG3FMab4FjiaTFTYnjGlWPRxMH3d6tF1U
        AL+Z5rk8nMkZp9oAb33R9UMNB9T0zBgq1lFONG2kG9ezmNUmdEOv2+WpNqS/oGO6X+ue/B
        RvMeh/XO2tf5CdetPqmMpOYWWW2TKlA=
Date:   Wed, 8 Mar 2023 09:53:54 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com
Subject: Re: [PATCH v7 26/41] mm: Warn on shadow stack memory in wrong vma
Message-ID: <ZAhNInCPPYt0q6Kl@zn.tnic>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-27-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230227222957.24501-27-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 27, 2023 at 02:29:42PM -0800, Rick Edgecombe wrote:
> The x86 Control-flow Enforcement Technology (CET) feature includes a new
> type of memory called shadow stack. This shadow stack memory has some
> unusual properties, which requires some core mm changes to function
> properly.
> 
> One sharp edge is that PTEs that are both Write=0 and Dirty=1 are
> treated as shadow by the CPU, but this combination used to be created by
> the kernel on x86. Previous patches have changed the kernel to now avoid
> creating these PTEs unless they are for shadow stack memory. In case any
> missed corners of the kernel are still creating PTEs like this for
> non-shadow stack memory, and to catch any re-introductions of the logic,
> warn if any shadow stack PTEs (Write=0, Dirty=1) are found in non-shadow
> stack VMAs when they are being zapped. This won't catch transient cases
> but should have decent coverage. It will be compiled out when shadow
> stack is not configured.
> 
> In order to check if a pte is shadow stack in core mm code, add two arch

s/pte/PTE/

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
