Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0894C6B02C3
	for <lists+linux-arch@lfdr.de>; Wed,  8 Mar 2023 10:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjCHJXe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Mar 2023 04:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjCHJXc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Mar 2023 04:23:32 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D2376F71;
        Wed,  8 Mar 2023 01:23:31 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9637E1EC0691;
        Wed,  8 Mar 2023 10:23:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1678267409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=802coS+HxbpOP0Cayz2V/ZmNxZUObxQN5WW++zeQd1k=;
        b=f40c4cP7e6n+tchcjwucO7lAQuNx4scQ0Zxa/wJFrusM2kjP65DJOobsS+A4fZx0N2tqxn
        ObA+C7n+KvQLDyHulxod5y6RaUSxFzNqDULV2cTjsGGYH7I89sVhiHA1K0LqN/vi8BjDpO
        fvfErsztx6I36Hkn7IcRdGEz1ePE1Bk=
Date:   Wed, 8 Mar 2023 10:23:24 +0100
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
Subject: Re: [PATCH v7 27/41] x86/mm: Warn if create Write=0,Dirty=1 with raw
 prot
Message-ID: <ZAhUDE+6F71onz0W@zn.tnic>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-28-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230227222957.24501-28-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 27, 2023 at 02:29:43PM -0800, Rick Edgecombe wrote:
> When user shadow stack is use, Write=0,Dirty=1 is treated by the CPU as
			   ^
			   in

> shadow stack memory. So for shadow stack memory this bit combination is
> valid, but when Dirty=1,Write=1 (conventionally writable) memory is being
> write protected, the kernel has been taught to transition the Dirty=1
> bit to SavedDirty=1, to avoid inadvertently creating shadow stack
> memory. It does this inside pte_wrprotect() because it knows the PTE is
> not intended to be a writable shadow stack entry, it is supposed to be
> write protected.


> 
> However, when a PTE is created by a raw prot using mk_pte(), mk_pte()
> can't know whether to adjust Dirty=1 to SavedDirty=1. It can't
> distinguish between the caller intending to create a shadow stack PTE or
> needing the SavedDirty shift.
> 
> The kernel has been updated to not do this, and so Write=0,Dirty=1
> memory should only be created by the pte_mkfoo() helpers. Add a warning
> to make sure no new mk_pte() start doing this.

Might wanna add the note from below here:

"... start doing this, like, for example, set_memory_rox() did."

> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Tested-by: Kees Cook <keescook@chromium.org>
> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> 
> ---
> v6:
>  - New patch (Note, this has already been a useful warning, it caught the
>    newly added set_memory_rox() doing this)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
