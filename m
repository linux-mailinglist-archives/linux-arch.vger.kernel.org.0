Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9AC6A7297
	for <lists+linux-arch@lfdr.de>; Wed,  1 Mar 2023 19:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjCASGV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Mar 2023 13:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjCASGU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Mar 2023 13:06:20 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B5BB440;
        Wed,  1 Mar 2023 10:06:16 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BB4671EC0646;
        Wed,  1 Mar 2023 19:06:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1677693974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Qr3M2ykwdizDOp0OOH8+sXnlOm6IAYEHuNArnLVf8t8=;
        b=fxGUe6x4K96TDUeg9BjZQkEKKWQLRDd4rbSk86ZfMPKSpeRy8SjFm8TCU3JNg/NV9M4wSF
        PDjfPWESbSddXdZo76RncViZ4Nko8sxZsBCWToo/FhuhjZB519Qfp2G1i3TTPJSx6MQmRg
        Sf4AMQb5/nDf5namJ/WyhvM6H+qkPsE=
Date:   Wed, 1 Mar 2023 19:06:09 +0100
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
        david@redhat.com, debug@rivosinc.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH v7 08/41] x86/shstk: Add user control-protection fault
 handler
Message-ID: <Y/+UEdolvD1U+tGw@zn.tnic>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-9-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230227222957.24501-9-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 27, 2023 at 02:29:24PM -0800, Rick Edgecombe wrote:
> diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
> index 7ad22b705b64..cc10d8be9d74 100644
> --- a/arch/x86/kernel/cet.c
> +++ b/arch/x86/kernel/cet.c
> @@ -4,10 +4,6 @@
>  #include <asm/bugs.h>
>  #include <asm/traps.h>
>  
> -static __ro_after_init bool ibt_fatal = true;
> -
> -extern void ibt_selftest_ip(void); /* code label defined in asm below */
> -
>  enum cp_error_code {
>  	CP_EC        = (1 << 15) - 1,

From a previous review:

"That looks like a mask, so

        CP_EC_MASK

I guess."

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
