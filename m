Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E9569C282
	for <lists+linux-arch@lfdr.de>; Sun, 19 Feb 2023 21:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjBSUrY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 Feb 2023 15:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjBSUrX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Feb 2023 15:47:23 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF41318B29
        for <linux-arch@vger.kernel.org>; Sun, 19 Feb 2023 12:47:21 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id t4so1703748pjy.1
        for <linux-arch@vger.kernel.org>; Sun, 19 Feb 2023 12:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EQwHKFAOnqqVUFe2laozm23usPDD0BYqQFbDjsfGGZ0=;
        b=cMqm3sf+CmIV57EOrdFSH0Y6quW1uWdpJcrFTd2t38yjyfvYHAp87tnscm0cD4ruFl
         v7qL2TLj0IqBM7k0klpcJ9znFuXEQiRHtOHi3tlHnL14nRlrX+q4Wk3TqWjm4O4KDzjW
         jUhoMrl2bUhJOv+E5HJY1Zph4VZoAfhujd/fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQwHKFAOnqqVUFe2laozm23usPDD0BYqQFbDjsfGGZ0=;
        b=t+Vka99zDoSyf5PXhOSipjhsKFVCKYRPH3LkmQW3lhUmrN596imcMbKQ42cxAgKSFW
         sOGXEKmE26Zr7Y45Q9I+lZS5C9O2WIGVZQ6sSGBvSzoxIxvo83VSxnFbD8mDnDuaekKR
         5ddznSYv61sXDUhmtEUp3aFMPRzca8vbqj3SClM5JwBtFuARo65nt0k+8XPXlPlnUkbo
         1oN3PXESWwQRf4CiJ5TsmMahlB3lJmwpWzWHyrCUOYhQcXsarQK3z1FcSRX7+rm23Be0
         kWJm+b2g2jvGVcaS3Qj7j0Y/Uzj9ZS9WIdAS4crJ+VohAt+IzOXsbkaARHGqNtiB71SN
         Vc4g==
X-Gm-Message-State: AO0yUKUqDghqQpMxXhYvReavGJUDzFI7watSA8D05zeTGWhWHrVnX0X9
        oSA3sRVHEDEGiYnxM9N5a1mzYQ==
X-Google-Smtp-Source: AK7set/hFIrWVTPTKDhOCxl9WJjZkcr/+hEi3oT24AxwvFiqzEXI+5JP9z5meWKExDOcc6n6nMbzbA==
X-Received: by 2002:a05:6a20:6929:b0:c7:2086:634b with SMTP id q41-20020a056a20692900b000c72086634bmr14963415pzj.18.1676839641160;
        Sun, 19 Feb 2023 12:47:21 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 65-20020a630044000000b004f2c088328bsm1020035pga.43.2023.02.19.12.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 12:47:20 -0800 (PST)
Message-ID: <63f28ad8.630a0220.b1efe.14e5@mx.google.com>
X-Google-Original-Message-ID: <202302191245.@keescook>
Date:   Sun, 19 Feb 2023 12:47:20 -0800
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
        david@redhat.com, debug@rivosinc.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v6 37/41] selftests/x86: Add shadow stack test
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
 <20230218211433.26859-38-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230218211433.26859-38-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 18, 2023 at 01:14:29PM -0800, Rick Edgecombe wrote:
> Add a simple selftest for exercising some shadow stack behavior:
>  - map_shadow_stack syscall and pivot
>  - Faulting in shadow stack memory
>  - Handling shadow stack violations
>  - GUP of shadow stack memory
>  - mprotect() of shadow stack memory
>  - Userfaultfd on shadow stack memory
> 
> Since this test exercises a recently added syscall manually, it needs
> to find the automatically created __NR_foo defines. Per the selftest
> documentation, KHDR_INCLUDES can be used to help the selftest Makefile's
> find the headers from the kernel source. This way the new selftest can
> be built inside the kernel source tree without installing the headers
> to the system. So also add KHDR_INCLUDES as described in the selftest
> docs, to facilitate this.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

I'll get some test hardware and run this myself too, but overall,
ignoring the lack of kselftest_harness.h, it looks good:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
