Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208A669C275
	for <lists+linux-arch@lfdr.de>; Sun, 19 Feb 2023 21:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjBSUoA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 Feb 2023 15:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjBSUn7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Feb 2023 15:43:59 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597DE14492
        for <linux-arch@vger.kernel.org>; Sun, 19 Feb 2023 12:43:58 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id o3so1534242plg.2
        for <linux-arch@vger.kernel.org>; Sun, 19 Feb 2023 12:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fKpHzd6Tbyr33yS2bO12JJwJSKx89ozdMUK74ZvMWQY=;
        b=lyB+LBtwPWQHHdKAlNRydMkf2elDFztWlBg6fmvpqXPnZh65qZQww0NMO+8xbYqZB7
         U9nfNbftnOH17cvV3hB7fmXC1rwq6ayNMO0P2Oq/eSedQ5vAmiJMfXKM02tjgGZ1jGsy
         tWqFbd/xVeuocI///kXq5zK9U+wa6hiXFpVGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKpHzd6Tbyr33yS2bO12JJwJSKx89ozdMUK74ZvMWQY=;
        b=7j3s1r6xyFs0LXILzvcHWH4iEarY5bdbbaghFZi0xTgJbK3eC7qhhmtkjesfX1M4XS
         gge1oDGTWaJexP5vRz7ZjM5YK8H9BnAR8Bvj6Gc9Csxl6vvbCBJgrc2ODmjDegLX2fZV
         ZwwViRcZc0JS694FyEb3CVTVksF2AUDgmA8u2wLe/6NaMSh7aAwLKQyYJ7RZCzaSwRpV
         z5UH3aTOSiNp5w6Tol8f5I4seImkh++isqlpwncfybCRSe+3hTp5bQ5g4GLkb6fY5lF3
         ZGGhwQwcAaNWi4RCd2wMkUSKKrLhg1Fu5mBKKGOT10AkasZnmISrFGrsIS4UmR6mKLGa
         rKPA==
X-Gm-Message-State: AO0yUKWgbdt1YeoJxcbsaE0xyxxYSNWiwzDOlL0IIu6sFfnY3ow+seVj
        Wce5A23Ew6JY5HM32OuVGmXmIA==
X-Google-Smtp-Source: AK7set+kcWCM2o49kDDpOvmw8Xuw/R9fB8lqTkZ5n1j58QZPck4H7MjP6asqe7McnmMIWyDzXFGOcw==
X-Received: by 2002:a17:903:2305:b0:19a:a4fc:7f80 with SMTP id d5-20020a170903230500b0019aa4fc7f80mr1247862plh.26.1676839437793;
        Sun, 19 Feb 2023 12:43:57 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k3-20020a170902e90300b0019a837be977sm6312881pld.271.2023.02.19.12.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 12:43:57 -0800 (PST)
Message-ID: <63f28a0d.170a0220.21bf7.b03c@mx.google.com>
X-Google-Original-Message-ID: <202302191243.@keescook>
Date:   Sun, 19 Feb 2023 12:43:56 -0800
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
        david@redhat.com, debug@rivosinc.com
Subject: Re: [PATCH v6 25/41] x86/mm: Introduce MAP_ABOVE4G
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
 <20230218211433.26859-26-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230218211433.26859-26-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 18, 2023 at 01:14:17PM -0800, Rick Edgecombe wrote:
> The x86 Control-flow Enforcement Technology (CET) feature includes a new
> type of memory called shadow stack. This shadow stack memory has some
> unusual properties, which require some core mm changes to function
> properly.
> 
> One of the properties is that the shadow stack pointer (SSP), which is a
> CPU register that points to the shadow stack like the stack pointer points
> to the stack, can't be pointing outside of the 32 bit address space when
> the CPU is executing in 32 bit mode. It is desirable to prevent executing
> in 32 bit mode when shadow stack is enabled because the kernel can't easily
> support 32 bit signals.
> 
> On x86 it is possible to transition to 32 bit mode without any special
> interaction with the kernel, by doing a "far call" to a 32 bit segment.
> So the shadow stack implementation can use this address space behavior
> as a feature, by enforcing that shadow stack memory is always crated
> outside of the 32 bit address space. This way userspace will trigger a
> general protection fault which will in turn trigger a segfault if it
> tries to transition to 32 bit mode with shadow stack enabled.
> 
> This provides a clean error generating border for the user if they try
> attempt to do 32 bit mode shadow stack, rather than leave the kernel in a
> half working state for userspace to be surprised by.
> 
> So to allow future shadow stack enabling patches to map shadow stacks
> out of the 32 bit address space, introduce MAP_ABOVE4G. The behavior
> is pretty much like MAP_32BIT, except that it has the opposite address
> range. The are a few differences though.
> 
> If both MAP_32BIT and MAP_ABOVE4G are provided, the kernel will use the
> MAP_ABOVE4G behavior. Like MAP_32BIT, MAP_ABOVE4G is ignored in a 32 bit
> syscall.

Should the interface refuse to accept both set instead?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
