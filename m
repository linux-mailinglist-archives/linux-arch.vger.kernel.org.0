Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F6167489A
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 02:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjATBIS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Jan 2023 20:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjATBIL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jan 2023 20:08:11 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA032A57B9
        for <linux-arch@vger.kernel.org>; Thu, 19 Jan 2023 17:08:05 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id k13so4055588plg.0
        for <linux-arch@vger.kernel.org>; Thu, 19 Jan 2023 17:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=flFLctJTPfL2nXWtj1YNou8QQFyZ70WxAkpNrSzol2k=;
        b=Wn5vPjaYTZvwNCHchRHbnsIHk1WCdLejvx1AtDl8vEi8uPvw6uThwG0dwVe/H4pu0x
         cWDItOTdO/sk1AcDZle8xJFIiw9crgtNk9c/LiXJgd1qZydXSg3s2fpleRnoqRYRPNd/
         dYRQT01ECPVEyE2xdqjjf7PE+qQAB2iqNpbc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flFLctJTPfL2nXWtj1YNou8QQFyZ70WxAkpNrSzol2k=;
        b=SFCLws789b9f7xsXrAlXeHtnh6g5/Ab/w3Mkm7tZq9phh+h3Mfdv7iZGFCEa8fOytM
         /1d8SV4Q7AfLo190AZJOiTA7sI40v7+n32HNCfrz142UEIYzZA7hI9zd94uw5yWH5J4c
         EGSyK/sO80AOyWvIjKrPHRfRMutve+4QRzerZajuRvMvp5fuIWMrRm4+w6Pwb3/2mveu
         Mk64B05jb+jFUkG/i3p6Db9Rij73BLxhd6PhhyV6UmX1UtvVrq6TExMk52jrKuT8Bu0C
         CYuKlUOIJ5s0cQQln9xXcmzZhAXkaVb5JOXYsWOEaEB+SqvBa8O2SzFE6BFZi8HFfYN9
         tQNw==
X-Gm-Message-State: AFqh2kpjcl8CiedllytQFO+yj7nTHbn2sBljbrqcNhG8icClRjUJIuP0
        udX66SLouj5k+drB/l9XUZfXDQ==
X-Google-Smtp-Source: AMrXdXsQathgrTdjgVAi679ipcO9Vh3LvoE/7091JNAPiU/s9vvqq/sC6hX4drnilOyMkIKibvHXbA==
X-Received: by 2002:a05:6a21:3989:b0:b8:d65d:5f7a with SMTP id ad9-20020a056a21398900b000b8d65d5f7amr12678405pzc.35.1674176885185;
        Thu, 19 Jan 2023 17:08:05 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j18-20020a635952000000b004cd1f1a14f6sm7519083pgm.86.2023.01.19.17.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 17:08:04 -0800 (PST)
Date:   Thu, 19 Jan 2023 17:08:04 -0800
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
Subject: Re: [PATCH v5 37/39] x86: Add PTRACE interface for shadow stack
Message-ID: <202301191708.F1C43C9D8@keescook>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119212317.8324-38-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119212317.8324-38-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 19, 2023 at 01:23:15PM -0800, Rick Edgecombe wrote:
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
