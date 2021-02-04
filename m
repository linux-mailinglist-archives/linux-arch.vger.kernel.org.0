Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9E230FE10
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 21:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239945AbhBDUVs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 15:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239777AbhBDUVn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 15:21:43 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AB0C061797
        for <linux-arch@vger.kernel.org>; Thu,  4 Feb 2021 12:21:02 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id e9so2486014pjj.0
        for <linux-arch@vger.kernel.org>; Thu, 04 Feb 2021 12:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l281j3ItWk9H1C+Zr+UKWfAUNh5R5Gnsi8pKJzoTn0Y=;
        b=m8bNR4kU1FTOhjXyaVKDbA4cJ6CUhZEAt/Acj2okLlIxhkSswEUS5rh6/beYKqU5Vv
         TnBIgnOmsom9UNzPdiRegE73O4iBMPoKye2XicDP5jWBCvmifNLmjKp2S/L72D+Q5hcD
         QdJgZCK8fwHFv1D4+EtdJ73MaSWkzRtnHxwRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l281j3ItWk9H1C+Zr+UKWfAUNh5R5Gnsi8pKJzoTn0Y=;
        b=DSMU24itagGUrE47M3EQZ9VxazCWwy5fjOxn49Tf84SOIeFxYzskgFiM4q6wK7omob
         XGrJDgVl6ETklMceY3vetAVMmSySiMslZwv2XNG5rwhiI8Tz5fQtkrlJRAS18wccQU1S
         MIdd4lv+xVTw7TuTtXXwkcqfDFa2SDNNuHhFIXMXWR5nb76udiDDJ1Jr2ex/XU3XqYyR
         TpQbDiFAWlv+Gi/QDYE5u3tYyiFXe3EoldYrtjMiP6Ode303nTZgWGMPEkYfFu5NLDQE
         qPbOjTNXn01BEOTXizeRiZdlsZdgH/eKIavPOxWaHfsTGqt0iha3R1vc7FGUXKFhSQtF
         3mrw==
X-Gm-Message-State: AOAM533tljI7i/5a9/ErEg4wUjoWHfdwZNJDTls7whqEFMctFGXb9aVt
        BGTjXh4uA3V1pjg4ly53zVGbDw==
X-Google-Smtp-Source: ABdhPJyGwK26WUMO7/KU2gMLYXNT/yAeEL27yvxDIb2PjlNVa9vK2qg04E5s4vM2GT6XMXvgvyy4ow==
X-Received: by 2002:a17:902:8604:b029:e2:a249:4474 with SMTP id f4-20020a1709028604b02900e2a2494474mr745841plo.15.1612470061943;
        Thu, 04 Feb 2021 12:21:01 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 62sm5499904pfg.160.2021.02.04.12.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 12:21:01 -0800 (PST)
Date:   Thu, 4 Feb 2021 12:21:00 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH v19 11/25] x86/mm: Update ptep_set_wrprotect() and
 pmdp_set_wrprotect() for transition from _PAGE_DIRTY to _PAGE_COW
Message-ID: <202102041220.3F62D2775@keescook>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-12-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203225547.32221-12-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 03, 2021 at 02:55:33PM -0800, Yu-cheng Yu wrote:
> When Shadow Stack is introduced, [R/O + _PAGE_DIRTY] PTE is reserved for
> shadow stack.  Copy-on-write PTEs have [R/O + _PAGE_COW].
> 
> When a PTE goes from [R/W + _PAGE_DIRTY] to [R/O + _PAGE_COW], it could
> become a transient shadow stack PTE in two cases:
> 
> The first case is that some processors can start a write but end up seeing
> a read-only PTE by the time they get to the Dirty bit, creating a transient
> shadow stack PTE.  However, this will not occur on processors supporting
> Shadow Stack, and a TLB flush is not necessary.
> 
> The second case is that when _PAGE_DIRTY is replaced with _PAGE_COW non-
> atomically, a transient shadow stack PTE can be created as a result.
> Thus, prevent that with cmpxchg.
> 
> Dave Hansen, Jann Horn, Andy Lutomirski, and Peter Zijlstra provided many
> insights to the issue.  Jann Horn provided the cmpxchg solution.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
