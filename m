Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E5D6413B2
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 03:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbiLCCqe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 21:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbiLCCqc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 21:46:32 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B73A7AAD
        for <linux-arch@vger.kernel.org>; Fri,  2 Dec 2022 18:46:31 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id w37so5858479pga.5
        for <linux-arch@vger.kernel.org>; Fri, 02 Dec 2022 18:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x+iLzqLDRY8UcQo0kKaaiN6ym6n/piiBIem/JqSdM8A=;
        b=KLzTo/tj7fIZeyP6gGrmfwf7X2IIEHGD1jltxx9K7xaNqkJIEo2ao0fIlZ0ZxDmUiC
         qF7c/md/lqiCB6dbfTfOl/Y48oTUdStOp/fhv7niMr2q7sE+u3nPThEVD2d3zq2laFom
         Y1V+fLsh83W1YJqts6oUwQvUVC6YqhrwGtB4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+iLzqLDRY8UcQo0kKaaiN6ym6n/piiBIem/JqSdM8A=;
        b=fQ+Obe6foMpVmKeCRKdl/h483fn1Axc3RpzLaouijKn2fLHssyAkmxPgc72YbbWVvG
         lnLfvp9AwdiRuKaFAIh853WHCxY9+1aGdjqCo4ALMk1LUnTZSXAqBBLhoIm6pCY+54Nd
         DIky6AxNd64J+IsQL82fMsOQx0W4MtCI355Dqa0bfSTl3HQXfLt1QCEjl0WssHk4lOpK
         SJfjkNyMFmPUsBuRvc6w7YtowZKVq5jzgGheI2TLxMGeGxTYbIxfmw9TwCaNC9q068i8
         KdYA+pNa6Tsn37X4XqhvwQ/go/V3FggEvyPff8lvMw5J4dsJqVPEo3BRHH2gA5TFC5Yk
         oRhg==
X-Gm-Message-State: ANoB5pl1eao3S10Cfscte2Lm98PCShM8Uscrd6Iiyd5sse/cB5l2U6Hy
        u4/qwdX6gUCqEiJjqSColBDqzg==
X-Google-Smtp-Source: AA0mqf6oAj6h5qu6AVbtVOXDQ0T/xnbet5XcclolXxVNuIuRy36+i9HcF8uT5nTMG4W5pJqoQv8dyw==
X-Received: by 2002:a62:ea0e:0:b0:575:7bb:d6fc with SMTP id t14-20020a62ea0e000000b0057507bbd6fcmr31612264pfh.79.1670035591199;
        Fri, 02 Dec 2022 18:46:31 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p2-20020a1709027ec200b0017da2798025sm6153534plb.295.2022.12.02.18.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 18:46:30 -0800 (PST)
Date:   Fri, 2 Dec 2022 18:46:29 -0800
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
Subject: Re: [PATCH v4 29/39] x86/shstk: Handle signals for shadow stack
Message-ID: <202212021846.AECD42F51@keescook>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
 <20221203003606.6838-30-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203003606.6838-30-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 02, 2022 at 04:35:56PM -0800, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> When a signal is handled normally the context is pushed to the stack
> before handling it. For shadow stacks, since the shadow stack only track's
> return addresses, there isn't any state that needs to be pushed. However,
> there are still a few things that need to be done. These things are
> userspace visible and which will be kernel ABI for shadow stacks.
> 
> One is to make sure the restorer address is written to shadow stack, since
> the signal handler (if not changing ucontext) returns to the restorer, and
> the restorer calls sigreturn. So add the restorer on the shadow stack
> before handling the signal, so there is not a conflict when the signal
> handler returns to the restorer.
> 
> The other thing to do is to place some type of checkable token on the
> thread's shadow stack before handling the signal and check it during
> sigreturn. This is an extra layer of protection to hamper attackers
> calling sigreturn manually as in SROP-like attacks.
> 
> For this token we can use the shadow stack data format defined earlier.
> Have the data pushed be the previous SSP. In the future the sigreturn
> might want to return back to a different stack. Storing the SSP (instead
> of a restore offset or something) allows for future functionality that
> may want to restore to a different stack.
> 
> So, when handling a signal push
>  - the SSP pointing in the shadow stack data format
>  - the restorer address below the restore token.
> 
> In sigreturn, verify SSP is stored in the data format and pop the shadow
> stack.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
