Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D856867483E
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 01:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjATArH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Jan 2023 19:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjATArD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jan 2023 19:47:03 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DEAA5783
        for <linux-arch@vger.kernel.org>; Thu, 19 Jan 2023 16:46:58 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id a9-20020a17090a740900b0022a0e51fb17so894362pjg.3
        for <linux-arch@vger.kernel.org>; Thu, 19 Jan 2023 16:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ayJn/GYBuR/fjLdDFpqtJAjszedzztZoiWdekO0asUc=;
        b=LKldp5a7K3BsUCsXJfb8c+4bU1Z1rcCPaC6m1IG3+dGP0kcfglcgNPJWU6gHFk57BM
         ygiHAt3O1+ekCwb5p5hlgI2h7bYQzAca7U8VlDDtO9oyTPawyLWlpYuU/HICfsTWVNiu
         9XqTBs/GbFlq+lrpUCNHjoePJxihOK9Iw0aYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayJn/GYBuR/fjLdDFpqtJAjszedzztZoiWdekO0asUc=;
        b=nPtIq779yajm4CNJQxCb5ys3fJAsQRDLZyWVpKs4atEUrgYlH26bU9Gnu7y+r81w/R
         T8bFd2qRmFoE2fO0yI0O5b0ybXNb4rQ9EC7d+OpqgGTWOcR9bBxphS2WJZ9GoG5pBVfn
         LSGUtteJYLaM18pRPWzXlXotVoiJVc9ks0Cb5zjeuta+gHTgB865u05WcqxY+O21W1kP
         XNcc+L1O40E1QlFJQqMFi3ZrZqG0LsZEwgIDRp1zYUm8aLC+8mChcPVCHAAXv7+WAX+p
         30ToJ6Q46JLkljmC1fiFNerZyQNBLjGTdkiN43tJQhg1hVjmeqTRTNGxcn2anY3TBjKt
         7FAw==
X-Gm-Message-State: AFqh2krrSZuSatlnlxc6bS/+UVyDqPlboDT4ycR6QTDebzrOFnQEXbg5
        aMYllDDlWPA2ZEj3KLEqwNmSkw==
X-Google-Smtp-Source: AMrXdXuKfEj0zOvGfr1iA/kr1NdJ/npdryHNpx4REj8VhMm71VRKkoixQ6w2KxNIbipwCihUiBMNPQ==
X-Received: by 2002:a17:902:cec7:b0:191:2a9c:52a1 with SMTP id d7-20020a170902cec700b001912a9c52a1mr17245912plg.19.1674175618067;
        Thu, 19 Jan 2023 16:46:58 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c8-20020a170902d48800b001925c3ec34esm2560903plg.196.2023.01.19.16.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 16:46:57 -0800 (PST)
Date:   Thu, 19 Jan 2023 16:46:56 -0800
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
Subject: Re: [PATCH v5 05/39] x86/fpu/xstate: Introduce CET MSR and XSAVES
 supervisor states
Message-ID: <202301191646.BE63FEC@keescook>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119212317.8324-6-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119212317.8324-6-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 19, 2023 at 01:22:43PM -0800, Rick Edgecombe wrote:
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
