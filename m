Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A596267486A
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 01:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjATA76 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Jan 2023 19:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjATA74 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jan 2023 19:59:56 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD09A1029
        for <linux-arch@vger.kernel.org>; Thu, 19 Jan 2023 16:59:55 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d3so3965280plr.10
        for <linux-arch@vger.kernel.org>; Thu, 19 Jan 2023 16:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uiOy7MsAVXCDi4yykgCEJP615rzoTkEvmwPXfFVYVQA=;
        b=VBHls2lLd7XEu8aue7DbkQvXQ37PW2//QqsV2W8dczleQ1Ps1UB6eDmU9KXMP5ttsN
         F/GKW5mx9ZYlzYhgLSdj53/o0umWjbPEJSEH8npDn2brASONuPwm9Ot+p8h+h7BYg1hK
         K1QpFXcUhel/q0dONN90cxImX5GtL3kCHcSuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiOy7MsAVXCDi4yykgCEJP615rzoTkEvmwPXfFVYVQA=;
        b=5KvBHvSuWf8PM8I0ET+CEEMP46HB2wKIOYyMmpJCLEbkrsPXklxpDeH/t4iu5gWv30
         j8RnlCjgMaGN9kJi7yvY0vpUmEN4Lg90HFBhZkJxvnV1DC4QRJHGhgi0DEeONzfu/KqE
         STfMQOUQy6zuoyui7wXMTVuIX8u4vtm2KujfMb4vHc/Of2n8fOHOjR9b+8k3JxTXbMUR
         TOkmHc6NCDbT8efEzmplQmq92ws0LWNqWz5Rt7g1iVNhnoIYwGS+hgkBhASKBeRJbZv7
         61MxTNvVzgr/wEOOx8hzuymEF6wglU+xqIaIANxR+o5WweySPmLsQPae+66Qth4drNj2
         Yslw==
X-Gm-Message-State: AFqh2kqpwiitP/Lc10teLt4z1C/bk9eSyPDju4IR0jfjEKYd6It1xZI3
        QFRPUDxPe7ZOGl9uAn5/d5laQA==
X-Google-Smtp-Source: AMrXdXsd0nbSulNLJk98i1TAtXfzuLUV/MdDPQrv4yHjXSBb1o0r3isynBZ7MuOj9TBz0Qc0m88Yhg==
X-Received: by 2002:a17:902:d706:b0:193:2c1b:3367 with SMTP id w6-20020a170902d70600b001932c1b3367mr13591546ply.1.1674176394926;
        Thu, 19 Jan 2023 16:59:54 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902eb9000b00194d14d8e54sm1790804plg.96.2023.01.19.16.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 16:59:54 -0800 (PST)
Date:   Thu, 19 Jan 2023 16:59:53 -0800
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
Subject: Re: [PATCH v5 16/39] x86/mm: Check shadow stack page fault errors
Message-ID: <202301191659.1B1439CF7@keescook>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119212317.8324-17-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119212317.8324-17-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 19, 2023 at 01:22:54PM -0800, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> The CPU performs "shadow stack accesses" when it expects to encounter
> shadow stack mappings. These accesses can be implicit (via CALL/RET
> instructions) or explicit (instructions like WRSS).
> 
> Shadow stack accesses to shadow-stack mappings can result in faults in
> normal, valid operation just like regular accesses to regular mappings.
> Shadow stacks need some of the same features like delayed allocation, swap
> and copy-on-write. The kernel needs to use faults to implement those
> features.
> 
> The architecture has concepts of both shadow stack reads and shadow stack
> writes. Any shadow stack access to non-shadow stack memory will generate
> a fault with the shadow stack error code bit set.
> 
> This means that, unlike normal write protection, the fault handler needs
> to create a type of memory that can be written to (with instructions that
> generate shadow stack writes), even to fulfill a read access. So in the
> case of COW memory, the COW needs to take place even with a shadow stack
> read. Otherwise the page will be left (shadow stack) writable in
> userspace. So to trigger the appropriate behavior, set FAULT_FLAG_WRITE
> for shadow stack accesses, even if the access was a shadow stack read.
> 
> For the purpose of making this clearer, consider the following example.
> If a process has a shadow stack, and forks, the shadow stack PTEs will
> become read-only due to COW. If the CPU in one process performs a shadow
> stack read access to the shadow stack, for example executing a RET and
> causing the CPU to read the shadow stack copy of the return address, then
> in order for the fault to be resolved the PTE will need to be set with
> shadow stack permissions. But then the memory would be changeable from
> userspace (from CALL, RET, WRSS, etc). So this scenario needs to trigger
> COW, otherwise the shared page would be changeable from both processes.
> 
> Shadow stack accesses can also result in errors, such as when a shadow
> stack overflows, or if a shadow stack access occurs to a non-shadow-stack
> mapping. Also, generate the errors for invalid shadow stack accesses.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
