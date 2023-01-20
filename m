Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D76674865
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 01:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjATA65 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Jan 2023 19:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjATA64 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jan 2023 19:58:56 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA1BA102E
        for <linux-arch@vger.kernel.org>; Thu, 19 Jan 2023 16:58:54 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id u1-20020a17090a450100b0022936a63a21so7577367pjg.4
        for <linux-arch@vger.kernel.org>; Thu, 19 Jan 2023 16:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GEKQrNYn84SyiMVwHi+ViZWnsYeclQ5eLRq6WaqYGnM=;
        b=WTVRqDMtqMbOq3WxN4ZlPrftWcBbtb/jMaQ1oUFq/yTG37R8QPQQctOPc6wEJIy9cn
         sFJi8BNizlbkDUe+lV4xBp4Xz0Df1GHAl9ouKhsQDgig9FXqEA2W018U2RKJheW6BQwu
         V+6HtxqBrikt2OTm3snafSbjE6BAfKIXLlqR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEKQrNYn84SyiMVwHi+ViZWnsYeclQ5eLRq6WaqYGnM=;
        b=b2V2UMw4tsBtzYJIatEXH7T1aDLu/l4fZqOfr3yuBS+TwIXqYJmkcdn0gOfvrRkFjU
         tuwC7DwlFMg/BAPo/Lz6r4D+yI5T+/4a3pfVzY8TsX8kb6ETOLyT38T2X1k14TWBDmIb
         tZg0koalb4oKJ/vxY8ah2uSuaU09XTCR7x/Wn95z2Nq6PNixSTCxkRairPNeYUw11S2T
         JA72MZ0hZzT/0RQMPJ7uWReRjc1L8oVtWxnbocNRVTkDHvnnV7UG9dCu3M+lm+PB5l92
         b/78UpbSd+9TM0XhWy3/VIvUYJ1cl7ltfNUBs+ABSf1mt2TmpNRBC9anSuSQQQ77KHt3
         ARmg==
X-Gm-Message-State: AFqh2kp66vlih1lG9g7+SeD0pTQWX9AtuAPNMK6VEnexY6yv9Rm20RqJ
        6yxP/L1iqH30nNKuc+55xIqcSA==
X-Google-Smtp-Source: AMrXdXvLTdfw9Jwlvrx1JO80QJ++CAVLO10EXvyZNLLYuS5e7D3oR3YyzWtevP1p2YPfAvW/OuuJfQ==
X-Received: by 2002:a17:902:e846:b0:194:df3e:51b3 with SMTP id t6-20020a170902e84600b00194df3e51b3mr1569881plg.26.1674176334316;
        Thu, 19 Jan 2023 16:58:54 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902684900b0019488090884sm9626469pln.273.2023.01.19.16.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 16:58:53 -0800 (PST)
Date:   Thu, 19 Jan 2023 16:58:53 -0800
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
Subject: Re: [PATCH v5 12/39] x86/mm: Update ptep_set_wrprotect() and
 pmdp_set_wrprotect() for transition from _PAGE_DIRTY to _PAGE_COW
Message-ID: <202301191658.A599D620B@keescook>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119212317.8324-13-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119212317.8324-13-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 19, 2023 at 01:22:50PM -0800, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> When shadow stack is in use, Write=0,Dirty=1 PTE are preserved for
> shadow stack. Copy-on-write PTEs then have Write=0,Cow=1.
> 
> When a PTE goes from Write=1,Dirty=1 to Write=0,Cow=1, it could
> become a transient shadow stack PTE in two cases:
> 
> 1. Some processors can start a write but end up seeing a Write=0 PTE by
>    the time they get to the Dirty bit, creating a transient shadow stack
>    PTE. However, this will not occur on processors supporting shadow
>    stack, and a TLB flush is not necessary.
> 
> 2. When _PAGE_DIRTY is replaced with _PAGE_COW non-atomically, a transient
>    shadow stack PTE can be created as a result. Thus, prevent that with
>    cmpxchg.
> 
> In the case of pmdp_set_wrprotect(), for nopmd configs the ->pmd operated
> on does not exist and the logic would need to be different. Although the
> extra functionality will normally be optimized out when user shadow
> stacks are not configured, also exclude it in the preprocessor stage so
> that it will still compile. User shadow stack is not supported there by
> Linux anyway. Leave the cpu_feature_enabled() check so that the
> functionality also gets disabled based on runtime detection of the
> feature.
> 
> Similarly, compile it out in ptep_set_wrprotect() due to a clang warning
> on i386. Like above, the code path should get optimized out on i386
> since shadow stack is not supported on 32 bit kernels, but this makes
> the compiler happy.
> 
> Dave Hansen, Jann Horn, Andy Lutomirski, and Peter Zijlstra provided many
> insights to the issue. Jann Horn provided the cmpxchg solution.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
