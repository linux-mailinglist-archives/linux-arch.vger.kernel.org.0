Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6625F3451
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 19:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiJCRSO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 13:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiJCRSN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 13:18:13 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35107B78
        for <linux-arch@vger.kernel.org>; Mon,  3 Oct 2022 10:18:12 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so10511563pjk.2
        for <linux-arch@vger.kernel.org>; Mon, 03 Oct 2022 10:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=DUSAgm1tGARrhgAa+YXJyBkN7A5KbivkL+1rvMQ+tQc=;
        b=Of4O9so7/tSkTzAhtAmZ+McsJYDlbXtDFPfPIaWqeHQqx0dNBvuOCri5UaoKbaXhOK
         y6gXjMlY2as/UO/bCo3kBsjsJP7fvzviBg59V2TvtA70FIIFvHZxrHXgb8EaKe3XjuwU
         Wg6HcGRQExXlzVGqQhNLlqWLYTLYRjlajnCQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=DUSAgm1tGARrhgAa+YXJyBkN7A5KbivkL+1rvMQ+tQc=;
        b=EQUvFmSuOIoa1jVDwQaY9XPMsSm/xM3Msw7pImhhFmvCZXN/aYzDS+mVFKXRqPDkBM
         lSlWG9lXdj46ZvbmwpwQFkmTwtYYzxrB2Vrp2UcdNY1FKKuwK1HYPrkJpltOYWtfQU8v
         2WuSlmbtsDRijRMtEepsvbGOrwqPdScgIY6bfBFPiBV5lcV/pNT0VUn38kgGTKHTvuO3
         8adQdqLX0JzfHRVuO05GwbQFdPAa/RVQMTL8HTJt2u+R8WqEuAONETXrSFGL3gfSaGZH
         DdMLN7GRzcXFCxdK1LR3fv/yQCQtc6irtDJ80kCvTI8NQe9krU/mgdepResEpvLZvmjX
         AUfg==
X-Gm-Message-State: ACrzQf0QaPVrLRKRHTqd9qpMeDvI0gsLgu3aVn9MIKm8xWYqxd2N2cIG
        Jm+AUwzDhCSms+WXNEFPt918nA==
X-Google-Smtp-Source: AMsMyM6gix+5GlV36V2qSUzA6hoZQ8rkNTODSa4bi8qPDTOaiRU0xMg3oXO3dVq8uVOs01K5lS8u7w==
X-Received: by 2002:a17:90b:1648:b0:203:c8d3:99b0 with SMTP id il8-20020a17090b164800b00203c8d399b0mr13356266pjb.54.1664817491587;
        Mon, 03 Oct 2022 10:18:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o17-20020a639a11000000b0043ba3d6ea3fsm7069554pge.54.2022.10.03.10.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 10:18:10 -0700 (PDT)
Date:   Mon, 3 Oct 2022 10:18:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
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
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v2 01/39] Documentation/x86: Add CET description
Message-ID: <202210031006.02C79ED58@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-2-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-2-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 29, 2022 at 03:28:58PM -0700, Rick Edgecombe wrote:
> [...]
> +Overview
> +========
> +
> +Control-flow Enforcement Technology (CET) is term referring to several
> +related x86 processor features that provides protection against control
> +flow hijacking attacks. The HW feature itself can be set up to protect
> +both applications and the kernel. Only user-mode protection is implemented
> +in the 64-bit kernel.

This likely needs rewording, since it's not strictly true any more:
IBT is supported in kernel-mode now (CONFIG_X86_IBT).

> +CET introduces Shadow Stack and Indirect Branch Tracking. Shadow stack is
> +a secondary stack allocated from memory and cannot be directly modified by
> +applications. When executing a CALL instruction, the processor pushes the
> +return address to both the normal stack and the shadow stack. Upon
> +function return, the processor pops the shadow stack copy and compares it
> +to the normal stack copy. If the two differ, the processor raises a
> +control-protection fault. Indirect branch tracking verifies indirect
> +CALL/JMP targets are intended as marked by the compiler with 'ENDBR'
> +opcodes. Not all CPU's have both Shadow Stack and Indirect Branch Tracking
> +and only Shadow Stack is currently supported in the kernel.
> +
> +The Kconfig options is X86_SHADOW_STACK, and it can be disabled with
> +the kernel parameter clearcpuid, like this: "clearcpuid=shstk".
> +
> +To build a CET-enabled kernel, Binutils v2.31 and GCC v8.1 or LLVM v10.0.1
> +or later are required. To build a CET-enabled application, GLIBC v2.28 or
> +later is also required.
> +
> +At run time, /proc/cpuinfo shows CET features if the processor supports
> +CET.

Maybe call them out by name: shstk ibt

> +CET arch_prctl()'s
> +==================
> +
> +Elf features should be enabled by the loader using the below arch_prctl's.
> +
> +arch_prctl(ARCH_CET_ENABLE, unsigned int feature)
> +    Enable a single feature specified in 'feature'. Can only operate on
> +    one feature at a time.

Does this mean only 1 bit out of the 32 may be specified?

> +
> +arch_prctl(ARCH_CET_DISABLE, unsigned int feature)
> +    Disable features specified in 'feature'. Can only operate on
> +    one feature at a time.
> +
> +arch_prctl(ARCH_CET_LOCK, unsigned int features)
> +    Lock in features at their current enabled or disabled status.

How is the "features" argument processed here?

> [...]
> +Proc status
> +===========
> +To check if an application is actually running with shadow stack, the
> +user can read the /proc/$PID/arch_status. It will report "wrss" or
> +"shstk" depending on what is enabled.

TIL about "arch_status". :) Why is this a separate file? "status" is
already has unique field names.

> +Fork
> +----
> +
> +The shadow stack's vma has VM_SHADOW_STACK flag set; its PTEs are required
> +to be read-only and dirty. When a shadow stack PTE is not RO and dirty, a
> +shadow access triggers a page fault with the shadow stack access bit set
> +in the page fault error code.
> +
> +When a task forks a child, its shadow stack PTEs are copied and both the
> +parent's and the child's shadow stack PTEs are cleared of the dirty bit.
> +Upon the next shadow stack access, the resulting shadow stack page fault
> +is handled by page copy/re-use.
> +
> +When a pthread child is created, the kernel allocates a new shadow stack
> +for the new thread.

Perhaps speak to the ASLR characteristics of the shstk here?

Also, it seems if there is a "Fork" section, there should be an "Exec"
section? I suspect it would be short: shstk is disabled when execve() is
called and must be re-enabled from userspace, yes?

-Kees

-- 
Kees Cook
