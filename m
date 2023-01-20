Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626DD674849
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 01:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjATAua (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Jan 2023 19:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjATAu3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jan 2023 19:50:29 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463C79003
        for <linux-arch@vger.kernel.org>; Thu, 19 Jan 2023 16:50:27 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id g23so3934681plq.12
        for <linux-arch@vger.kernel.org>; Thu, 19 Jan 2023 16:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R2aEPPbfB/worS45EAxatPQssMYjlVb1o5H9g9LucF0=;
        b=lZ5Lch+fy2oLgIdUAA75L9S48vEREC8i/frZUS5ItPKxp3Pld370+Dr1dRugVzsT+M
         7heNk7KiSyRSOUwU7RFFj47VfbQhnuJAgSEyvRD0fgxnkBfzNE5EOjIorGzYdWbr52z4
         4rmF4UPJPe8tgvkNN/exAf+u0UyWvpPid5+ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2aEPPbfB/worS45EAxatPQssMYjlVb1o5H9g9LucF0=;
        b=j59tz5R7htyL94ZweflULXzNZ1pJOyMEcRGw5Bvgh8VGrzx8MkoFOLrlsWe25kS3Jo
         DMOAzqh0tZ7LhO14QOKJUrr8BbdEmghF45fshgflQ3EMQq5Lz2m9XcJmYipSslKubIR3
         Fw0hbMMbvrZj8aqrrkTIVj1PGQQjaURwHNUseiO0FNyEuMD5tqTbtuLIQtrDY0A1bMvu
         eTWIoibMCcsJ0y8sicdnC8QSx1G0JNi3VBdqznYgXmT/JZ4BH1lCRH7bN1+OzdtiOML1
         Ljo71qxljf2nTYpCnx0MjcbiWThx/Spj/ZmMEu4/P6wNzjalIihjxyqldbzKPD63/061
         3J3w==
X-Gm-Message-State: AFqh2kol0htauDZxq+fwkR9aG6pQdbZXBNtmuIQ3g8e8obBkqeQ/MXQt
        07VUzsh/1ow5dmynHcm1x3N47w==
X-Google-Smtp-Source: AMrXdXtc7roB+w/tCl6tJQ9aF1cdAEg63HAhbectzk8kGPfsJ3hnUhD7/rAtxmwtE0GL8Q/xUmc13g==
X-Received: by 2002:a17:90a:71c3:b0:229:77f:6d2f with SMTP id m3-20020a17090a71c300b00229077f6d2fmr13141866pjs.44.1674175826738;
        Thu, 19 Jan 2023 16:50:26 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mt19-20020a17090b231300b0022704cc03ebsm238569pjb.41.2023.01.19.16.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 16:50:26 -0800 (PST)
Date:   Thu, 19 Jan 2023 16:50:25 -0800
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
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH v5 07/39] x86: Add user control-protection fault handler
Message-ID: <202301191649.5283D6C@keescook>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119212317.8324-8-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119212317.8324-8-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 19, 2023 at 01:22:45PM -0800, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> A control-protection fault is triggered when a control-flow transfer
> attempt violates Shadow Stack or Indirect Branch Tracking constraints.
> For example, the return address for a RET instruction differs from the copy
> on the shadow stack.
> 
> There already exists a control-protection fault handler for handling kernel
> IBT faults. Refactor this fault handler into separate user and kernel
> handlers, like the page fault handler. Add a control-protection handler
> for usermode. To avoid ifdeffery, put them both in a new file cet.c, which
> is compiled in the case of either of the two CET features supported in the
> kernel: kernel IBT or user mode shadow stack. Move some static inline
> functions from traps.c into a header so they can be used in cet.c.
> 
> Opportunistically fix a comment in the kernel IBT part of the fault
> handler that is on the end of the line instead of preceding it.
> 
> Keep the same behavior for the kernel side of the fault handler, except for
> converting a BUG to a WARN in the case of a #CP happening when the feature
> is missing. This unifies the behavior with the new shadow stack code, and
> also prevents the kernel from crashing under this situation which is
> potentially recoverable.
> 
> The control-protection fault handler works in a similar way as the general
> protection fault handler. It provides the si_code SEGV_CPERR to the signal
> handler.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

This diff would have been a bit easier to review if the file move was
separate from the addition of the handler, but regardless:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
