Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F94D6A98F7
	for <lists+linux-arch@lfdr.de>; Fri,  3 Mar 2023 15:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjCCOAa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Mar 2023 09:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjCCOA3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Mar 2023 09:00:29 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD335C13B;
        Fri,  3 Mar 2023 06:00:28 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 242C31EC0657;
        Fri,  3 Mar 2023 15:00:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1677852027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qnYHVDGtQv3jnmqIeyy8ite/fQyg2MBE/ckQjSbBpNM=;
        b=YlRhGsYyfadQXHimloeHMfYzHgPMt4rRKJ5ZJpz3f7rZXiR4DcSs61vbGpJcRD7wubIbgn
        Cy5sYRTCmvgOgF2q8BIUBY0oGyQjXPUVKD2axEEDzT4EdiJfZum0kFSwUDEeQjb4kIYCi9
        dwYF79zrOj6nrFa4wG5FeRtKoWY9ZUM=
Date:   Fri, 3 Mar 2023 15:00:22 +0100
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
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v7 19/41] x86/mm: Check shadow stack page fault errors
Message-ID: <ZAH9dhFGtbR5J8j+@zn.tnic>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-20-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230227222957.24501-20-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 27, 2023 at 02:29:35PM -0800, Rick Edgecombe wrote:
> @@ -1310,6 +1324,23 @@ void do_user_addr_fault(struct pt_regs *regs,
>  
>  	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
>  
> +	/*
> +	 * For conventionally writable pages, a read can be serviced with a
> +	 * read only PTE. But for shadow stack, there isn't a concept of
> +	 * read-only shadow stack memory. If it a PTE has the shadow stack

s/it //

> +	 * permission, it can be modified via CALL and RET instructions. So
> +	 * core MM needs to fault in a writable PTE and do things it already
> +	 * does for write faults.
> +	 *
> +	 * Shadow stack accesses (read or write) need to be serviced with
> +	 * shadow stack permission memory, which always include write
> +	 * permissions. So in the case of a shadow stack read access, treat it
> +	 * as a WRITE fault. This will make sure that MM will prepare
> +	 * everything (e.g., break COW) such that maybe_mkwrite() can create a
> +	 * proper shadow stack PTE.
> +	 */
> +	if (error_code & X86_PF_SHSTK)
> +		flags |= FAULT_FLAG_WRITE;
>  	if (error_code & X86_PF_WRITE)
>  		flags |= FAULT_FLAG_WRITE;
>  	if (error_code & X86_PF_INSTR)
> -- 
> 2.17.1
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
