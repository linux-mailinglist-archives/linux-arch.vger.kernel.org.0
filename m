Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAAF6A1C0F
	for <lists+linux-arch@lfdr.de>; Fri, 24 Feb 2023 13:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjBXMUc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Feb 2023 07:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjBXMUb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Feb 2023 07:20:31 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861875D45C;
        Fri, 24 Feb 2023 04:20:30 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 138CB1EC0723;
        Fri, 24 Feb 2023 13:20:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1677241229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3wlwiK1nNffOcPqzViDroCDgIPey06MUV3oYwrGZbKI=;
        b=r1POMqdP/hXKk7k7IpdK0dI2u/Hy0OFeiILxv284CCrDQW0R1mSntbXCdxhRuxVklJnZLf
        0twGNtT0NIrIeG8EErDShXCb0vKAS95g1CejT82cU3t8Ud0c1DXLE6SJHDd07zqEeXrUMK
        RS9BahVgyen34o3TrlrChBMlA6tXDa4=
Date:   Fri, 24 Feb 2023 13:20:19 +0100
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
Subject: Re: [PATCH v6 28/41] x86: Introduce userspace API for shadow stack
Message-ID: <Y/irg8d6OZ+OCFml@zn.tnic>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
 <20230218211433.26859-29-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230218211433.26859-29-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 18, 2023 at 01:14:20PM -0800, Rick Edgecombe wrote:
> diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
> index 500b96e71f18..b2b3b7200b2d 100644
> --- a/arch/x86/include/uapi/asm/prctl.h
> +++ b/arch/x86/include/uapi/asm/prctl.h
> @@ -20,4 +20,10 @@
>  #define ARCH_MAP_VDSO_32		0x2002
>  #define ARCH_MAP_VDSO_64		0x2003
>  
> +/* Don't use 0x3001-0x3004 because of old glibcs */

So where is this all new interface to userspace programs documented? Do
we have an agreement with all the involved parties that this is how
we're going to support shadow stacks and that this is what userspace
should do?

I'd like to avoid one more fiasco with glibc etc here...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
