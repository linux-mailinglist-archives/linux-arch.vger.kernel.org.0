Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4901C6413CD
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 03:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbiLCCzw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 21:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234557AbiLCCzv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 21:55:51 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BA44A5A1
        for <linux-arch@vger.kernel.org>; Fri,  2 Dec 2022 18:55:51 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id z14so2652745pfr.11
        for <linux-arch@vger.kernel.org>; Fri, 02 Dec 2022 18:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n2U2r+2t7pkXJfqUVDBQCHb1t4+jJyTASRBi7nj2p/k=;
        b=ATpOOq4FoL+4Yp2Dgf6WeXAC1dU8qOSQQP1qF3+pWOHUBvu3pwQfSKS7wGOII2ScCT
         tTCMi9+GPdv9E7fhMUWl0xLvYy3xjMdMWswcNd9euLVaiLW2FflFl39Kh6ko7mGBUPDv
         mu3Jx6n7d8C6bgEMDGlVI+2tfYAVEXVrGJtUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2U2r+2t7pkXJfqUVDBQCHb1t4+jJyTASRBi7nj2p/k=;
        b=H6XIEaCRP4flumLhi89O43dk2qxSAxx7+WTKljDfag6g8gnFLTTKQ6Dbw7ujFANIcj
         U4O60HxyPIiEPdyNX3J3uDpuUDMAOpRFq3hKwAnys7Jtdwso2tHLYhO7hGCs0ww+G5VE
         +/aAntpPcPd6z/26g0Kg9QsDPftQPI49FyaU/3iiEPh8JmjXThYUI5DykRwdvWQzF4/k
         FlHyOaB4IcUae3mWn0Lwrfxd44vQIG73MnWiR8JPhQbNDveZAwljc6F8g+xlcl+bLvzO
         0p1tzQMdTBDqNdydgr6x5+6cHwY7385wfNjpXiI+JuQFsbxQ6dn9/nP80R5x73pzMT8q
         Lw1A==
X-Gm-Message-State: ANoB5pl5iA7rZ5INt/Z5Oo6Up81SvzOo1PSslc8k95rJMuYJYEiDEFBh
        y3FXfW842ojQoze7shdlcA2C9g==
X-Google-Smtp-Source: AA0mqf5A1qERUjt/R+6TLTBviWIJ7Ee6ql5DOsOsuuxe2fjmgyBWCWRVOpwsDrrukXVaieWbRbMZWA==
X-Received: by 2002:a05:6a00:21c8:b0:562:e0fb:3c79 with SMTP id t8-20020a056a0021c800b00562e0fb3c79mr54806230pfj.39.1670036150539;
        Fri, 02 Dec 2022 18:55:50 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i17-20020a170902c95100b00189847cd4acsm6330926pla.237.2022.12.02.18.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 18:55:50 -0800 (PST)
Date:   Fri, 2 Dec 2022 18:55:49 -0800
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
Subject: Re: [PATCH v4 37/39] x86: Add PTRACE interface for shadow stack
Message-ID: <202212021855.41F90E2D9@keescook>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
 <20221203003606.6838-38-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203003606.6838-38-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 02, 2022 at 04:36:04PM -0800, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> Some applications (like GDB) would like to tweak shadow stack state via
> ptrace. This allows for existing functionality to continue to work for
> seized shadow stack applications. Provide an regset interface for
> manipulating the shadow stack pointer (SSP).
> 
> There is already ptrace functionality for accessing xstate, but this
> does not include supervisor xfeatures. So there is not a completely
> clear place for where to put the shadow stack state. Adding it to the
> user xfeatures regset would complicate that code, as it currently shares
> logic with signals which should not have supervisor features.
> 
> Don't add a general supervisor xfeature regset like the user one,
> because it is better to maintain flexibility for other supervisor
> xfeatures to define their own interface. For example, an xfeature may
> decide not to expose all of it's state to userspace, as is actually the
> case for  shadow stack ptrace functionality. A lot of enum values remain
> to be used, so just put it in dedicated shadow stack regset.
> 
> The only downside to not having a generic supervisor xfeature regset,
> is that apps need to be enlightened of any new supervisor xfeature
> exposed this way (i.e. they can't try to have generic save/restore
> logic). But maybe that is a good thing, because they have to think
> through each new xfeature instead of encountering issues when new a new
> supervisor xfeature was added.
> 
> By adding a shadow stack regset, it also has the effect of including the
> shadow stack state in a core dump, which could be useful for debugging.
> 
> The shadow stack specific xstate includes the SSP, and the shadow stack
> and WRSS enablement status. Enabling shadow stack or wrss in the kernel
> involves more than just flipping the bit. The kernel is made aware that
> it has to do extra things when cloning or handling signals. That logic
> is triggered off of separate feature enablement state kept in the task
> struct. So the flipping on HW shadow stack enforcement without notifying
> the kernel to change its behavior would severely limit what an application
> could do without crashing, and the results would depend on kernel
> internal implementation details. There is also no known use for controlling
> this state via prtace today. So only expose the SSP, which is something
> that userspace already has indirect control over.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
