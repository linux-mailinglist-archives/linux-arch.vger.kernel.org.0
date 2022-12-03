Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D04A6413A9
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 03:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbiLCCo0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 21:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbiLCCoY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 21:44:24 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712C46F80B
        for <linux-arch@vger.kernel.org>; Fri,  2 Dec 2022 18:44:23 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so6690275pjo.3
        for <linux-arch@vger.kernel.org>; Fri, 02 Dec 2022 18:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4dlKif1ZvnqP6fqB1QWIg1KA4Ojy8aY4ojSm5QzsaqQ=;
        b=JYaR+zgpAk73txGe1j+x7Gd0Q9OfSP4rlxVQK/OupY+gNmcJR/9STitKgFIuNdWvIq
         wRPfTZ2RrIqeDWV19i5hwCyXUczsjcZCfpCdaLhdh31xbEzQoo5bKan/pBTBqFZmLTiY
         t7MHgfxNSYr+jiGRZbORKDLpvhHxAm3qdLS1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dlKif1ZvnqP6fqB1QWIg1KA4Ojy8aY4ojSm5QzsaqQ=;
        b=YMBc8oDsqdHdLzwJOdxlsEIGu6/JB1OqvLceTx41vjY8Y9xlJVcYibsWM6wdOX5SNs
         6eAIbZDePC180HLq6fzDJ61pThkLIotDz7FTK942TyZ+chY9ccdZns/35QrptXLM8IMl
         CJRRtOSBcAbtFpL843ICQ2evIOME1UZPQ/0RfNNiGcLhx8IAYGNP5MLWrwzHFQiB7l+n
         OMV2gaYzN5I5Cpnt5VItIzeCeX2Uyot9tGDxWB0BlL/HDaK6SxpL504NggPZsMNPNv6R
         UldMbBdUAjZz6MoRLLg+Rq/QYJMgwvYJVy2wF2T6HGjU62f4O/q76ah5jLMRLc7gkhAR
         UWXA==
X-Gm-Message-State: ANoB5plpDQ/dMAKD8zSV9ew0YiXtlaMG7SYmpA85ETiCxjeX6oPBbSTP
        Myds7/HfMxQu9/1AhxbYOf7I1g==
X-Google-Smtp-Source: AA0mqf4tSqXeGiuc5Pf6/1RmNBUy/t0YdoCLyWnsfRj5Qv75KbKNER0Hx6ZISuteeyLDCXFEDpLbjA==
X-Received: by 2002:a17:902:7885:b0:189:1366:fba7 with SMTP id q5-20020a170902788500b001891366fba7mr56854862pll.45.1670035462913;
        Fri, 02 Dec 2022 18:44:22 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y23-20020a17090264d700b00187197c499asm6262673pli.164.2022.12.02.18.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 18:44:22 -0800 (PST)
Date:   Fri, 2 Dec 2022 18:44:21 -0800
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
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v4 27/39] x86/shstk: Handle thread shadow stack
Message-ID: <202212021844.D61875795@keescook>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
 <20221203003606.6838-28-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203003606.6838-28-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 02, 2022 at 04:35:54PM -0800, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> When a process is duplicated, but the child shares the address space with
> the parent, there is potential for the threads sharing a single stack to
> cause conflicts for each other. In the normal non-cet case this is handled
> in two ways.
> 
> With regular CLONE_VM a new stack is provided by userspace such that the
> parent and child have different stacks.
> 
> For vfork, the parent is suspended until the child exits. So as long as
> the child doesn't return from the vfork()/CLONE_VFORK calling function and
> sticks to a limited set of operations, the parent and child can share the
> same stack.
> 
> For shadow stack, these scenarios present similar sharing problems. For the
> CLONE_VM case, the child and the parent must have separate shadow stacks.
> Instead of changing clone to take a shadow stack, have the kernel just
> allocate one and switch to it.
> 
> Use stack_size passed from clone3() syscall for thread shadow stack size. A
> compat-mode thread shadow stack size is further reduced to 1/4. This
> allows more threads to run in a 32-bit address space. The clone() does not
> pass stack_size, which was added to clone3(). In that case, use
> RLIMIT_STACK size and cap to 4 GB.
> 
> For shadow stack enabled vfork(), the parent and child can share the same
> shadow stack, like they can share a normal stack. Since the parent is
> suspended until the child terminates, the child will not interfere with
> the parent while executing as long as it doesn't return from the vfork()
> and overwrite up the shadow stack. The child can safely overwrite down
> the shadow stack, as the parent can just overwrite this later. So CET does
> not add any additional limitations for vfork().
> 
> Userspace implementing posix vfork() can actually prevent the child from
> returning from the vfork() calling function, using CET. Glibc does this
> by adjusting the shadow stack pointer in the child, so that the child
> receives a #CP if it tries to return from vfork() calling function.
> 
> Free the shadow stack on thread exit by doing it in mm_release(). Skip
> this when exiting a vfork() child since the stack is shared in the
> parent.
> 
> During this operation, the shadow stack pointer of the new thread needs
> to be updated to point to the newly allocated shadow stack. Since the
> ability to do this is confined to the FPU subsystem, change
> fpu_clone() to take the new shadow stack pointer, and update it
> internally inside the FPU subsystem. This part was suggested by Thomas
> Gleixner.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
