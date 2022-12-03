Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA62E64134E
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 03:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbiLCCYr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 21:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbiLCCYq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 21:24:46 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A6ED49D9
        for <linux-arch@vger.kernel.org>; Fri,  2 Dec 2022 18:24:44 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 130so6511905pfu.8
        for <linux-arch@vger.kernel.org>; Fri, 02 Dec 2022 18:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sycaKxrnAspMqyMU77ofh2U6+r7smc986YIDXo/lwrY=;
        b=IZNU2dMUs6dvRCVJt3dLZHnp6oLw0v5rzZGKA6Kd8bm4NsBjo1K2kKghVQvOMP5i79
         V5hckw+Ac+GOxd2xVatczR8mFDBRoQEA/NmtdC3AfnW+31NXeBuq84WimyN5Nqyd8TDC
         +oYC0Sul0eoDxnpiV5qkpFYReUt5JMZM+klbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sycaKxrnAspMqyMU77ofh2U6+r7smc986YIDXo/lwrY=;
        b=klm8VSIdkie7+OUzeh2VKdPsajol5W4H4ido/De+mo5bcepB91BGZXgPUTkw5X0Pfu
         kCGdkFhnL96IAaF0jmX91GUeKk2xhZonRInBvt9m9CL6+9C7bDMxg/s/uTCLHO9ZGt2h
         STpizwif1d5bbnqbBo90JYuObm1eb4dnBnSNWlx6/CjfEGqIWgLT25AhTAA0KNAw0WTd
         9gkKBLBW++bKUEosqXKejuPZyErQdPDziRWGVua87XE8/sDT7f3VRoqJr0Bv9YqNbw5D
         LPauGIyfAQNrbamgLHDvZ6zpV66phHK9uJHvRp1z4rxPDF+vnSzTNRbEd1YnBkpsAZOV
         7V6Q==
X-Gm-Message-State: ANoB5pmghjHBJo+hlTDKGRGxisByYdblEDYVf4mSySH2vw1/CkF2eT5V
        wJvaxQq891V3oPeC3lkN2t1Xfg==
X-Google-Smtp-Source: AA0mqf6ecGDellGthenD6ceIHI53cmnvUC0Mod6jRuSERrc/xcY+2kDsyICXdTabTZG7Un5WGhNfAw==
X-Received: by 2002:a63:1655:0:b0:478:4cf6:d01 with SMTP id 21-20020a631655000000b004784cf60d01mr17112608pgw.279.1670034283967;
        Fri, 02 Dec 2022 18:24:43 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 74-20020a62164d000000b0056c0d129edfsm5718087pfw.121.2022.12.02.18.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 18:24:43 -0800 (PST)
Date:   Fri, 2 Dec 2022 18:24:42 -0800
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
Subject: Re: [PATCH v4 05/39] x86/fpu/xstate: Introduce CET MSR and XSAVES
 supervisor states
Message-ID: <202212021824.8EE4948F9@keescook>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
 <20221203003606.6838-6-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203003606.6838-6-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 02, 2022 at 04:35:32PM -0800, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> Shadow stack register state can be managed with XSAVE. The registers
> can logically be separated into two groups:
>         * Registers controlling user-mode operation
>         * Registers controlling kernel-mode operation
> 
> The architecture has two new XSAVE state components: one for each group
> of those groups of registers. This lets an OS manage them separately if
> it chooses. Future patches for host userspace and KVM guests will only
> utilize the user-mode registers, so only configure XSAVE to save
> user-mode registers. This state will add 16 bytes to the xsave buffer
> size.
> 
> Future patches will use the user-mode XSAVE area to save guest user-mode
> CET state. However, VMCS includes new fields for guest CET supervisor
> states. KVM can use these to save and restore guest supervisor state, so
> host supervisor XSAVE support is not required.
> 
> Adding this exacerbates the already unwieldy if statement in
> check_xstate_against_struct() that handles warning about un-implemented
> xfeatures. So refactor these check's by having XCHECK_SZ() set a bool when
> it actually check's the xfeature. This ends up exceeding 80 chars, but was
> better on balance than other options explored. Pass the bool as pointer to
> make it clear that XCHECK_SZ() can change the variable.
> 
> While configuring user-mode XSAVE, clarify kernel-mode registers are not
> managed by XSAVE by defining the xfeature in
> XFEATURE_MASK_SUPERVISOR_UNSUPPORTED, like is done for XFEATURE_MASK_PT.
> This serves more of a documentation as code purpose, and functionally,
> only enables a few safety checks.
> 
> Both XSAVE state components are supervisor states, even the state
> controlling user-mode operation. This is a departure from earlier features
> like protection keys where the PKRU state is a normal user
> (non-supervisor) state. Having the user state be supervisor-managed
> ensures there is no direct, unprivileged access to it, making it harder
> for an attacker to subvert CET.
> 
> To facilitate this privileged access, define the two user-mode CET MSRs,
> and the bits defined in those MSRs relevant to future shadow stack
> enablement patches.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
