Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB4D67488B
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 02:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjATBGC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Jan 2023 20:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjATBGB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jan 2023 20:06:01 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F765A45F2
        for <linux-arch@vger.kernel.org>; Thu, 19 Jan 2023 17:05:59 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 36so2981021pgp.10
        for <linux-arch@vger.kernel.org>; Thu, 19 Jan 2023 17:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H4TW/mMX9vHUYk3yGya6Na5dTq4l6jC7NCx7bdr4o80=;
        b=GHEBYWM71KcqC5IMJtDotYmMWZ2J1cCxD2jT1NDnzRmtQPHNkrdKXu9KjsOV4/duvV
         wNgaKj9Yp8D/ruJ1/qexuBysFjsKCivy+xErk/QBXiw97XYk+sixdofMmVpLdB7VM9gr
         jEi7DAuX79LAOWY3nGHtcd0xDRVRA3hLKB2sY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4TW/mMX9vHUYk3yGya6Na5dTq4l6jC7NCx7bdr4o80=;
        b=dfHih9pLlWbCjEuVvuhIiGjA7Siw8Rf8VYIjcjDDspyWZZUv06Vhrf86XmThPJIa3P
         FPkDR3wZA5G0JouuwwCbRyM/RRDmqfRwEezDy5qYmzrkDZt2KP3hE7uoIdxC7iHQiBjd
         h/UjILoQOUaOwmaj18bldHMP7bSQ0ZchQnHjo48lz02RvqAperr37+d53Er2cJZKu9eM
         wxBDxdau7ElAxh3HOiTMiGf+7hmbJLKfVjeim6K+8p7Uqc4GXeOt04b1J53KWAdqDejc
         jl1+nQVM9hGzG1bNagJmz7mra37ACjNyVTSMI5kMwjfJNdPCnJUpNJZ7RoTMdPEl6XdO
         3d9w==
X-Gm-Message-State: AFqh2kp8qFkm86Kr3CCWDINuhUbg/gH3LEcGxzULpmF+as6MwjMcX6NE
        sRzsjHcW9o4WrgeDWFL+aYLtGQ==
X-Google-Smtp-Source: AMrXdXsmLKX2r49mhsSf2hD4QP2t7yFQlbPA7Kf3OI6gCpsn1iW3fXxhIAxFlAdIDjUI7XgTM7f2Bw==
X-Received: by 2002:a62:1c93:0:b0:583:3adc:baed with SMTP id c141-20020a621c93000000b005833adcbaedmr14702073pfc.8.1674176758779;
        Thu, 19 Jan 2023 17:05:58 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e8-20020aa79808000000b005897f5436c0sm19809081pfl.118.2023.01.19.17.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 17:05:58 -0800 (PST)
Date:   Thu, 19 Jan 2023 17:05:57 -0800
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
Subject: Re: [PATCH v5 29/39] x86/shstk: Introduce routines modifying shstk
Message-ID: <202301191705.9D4E6EA@keescook>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119212317.8324-30-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119212317.8324-30-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 19, 2023 at 01:23:07PM -0800, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> Shadow stacks are normally written to via CALL/RET or specific CET
> instructions like RSTORSSP/SAVEPREVSSP. However during some Linux
> operations the kernel will need to write to directly using the ring-0 only
> WRUSS instruction.
> 
> A shadow stack restore token marks a restore point of the shadow stack, and
> the address in a token must point directly above the token, which is within
> the same shadow stack. This is distinctively different from other pointers
> on the shadow stack, since those pointers point to executable code area.
> 
> Introduce token setup and verify routines. Also introduce WRUSS, which is
> a kernel-mode instruction but writes directly to user shadow stack.
> 
> In future patches that enable shadow stack to work with signals, the kernel
> will need something to denote the point in the stack where sigreturn may be
> called. This will prevent attackers calling sigreturn at arbitrary places
> in the stack, in order to help prevent SROP attacks.
> 
> To do this, something that can only be written by the kernel needs to be
> placed on the shadow stack. This can be accomplished by setting bit 63 in
> the frame written to the shadow stack. Userspace return addresses can't
> have this bit set as it is in the kernel range. It is also can't be a
> valid restore token.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
