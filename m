Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F5A641341
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 03:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbiLCCUv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 21:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234701AbiLCCUu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 21:20:50 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E14FA8FE6
        for <linux-arch@vger.kernel.org>; Fri,  2 Dec 2022 18:20:50 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 82so5869470pgc.0
        for <linux-arch@vger.kernel.org>; Fri, 02 Dec 2022 18:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pdj4rQnZt3ghY0JYsDbW8G29zmubdAJq8qnfUhP1bDw=;
        b=gsBDlFYIA6+ssXAuRQnSCJpEb8pM4SDnpeDeLeFetrTCxdejKvNiZg4cCs8RzVeSVR
         aCDxlveDMDqzJ0/uwkJSoqvEnryHxT4HvfWZkKCjiqK9uowsLom9/PdT5VLwDe7XrNm0
         QZiu0h6AvVRpdlpM9Nd8QSrYGdi9ypFGXRNzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdj4rQnZt3ghY0JYsDbW8G29zmubdAJq8qnfUhP1bDw=;
        b=hBQ4obA98dBKt5AImOAMw2vw10AH8MM2AHGfNy2dGvPDMoPKWwRnPGO4JSJqWiLV8H
         meATzefqo5ZgqjrO36vSeroMouN2L24nu9iKLP5CC9RkNy50abxI3GRDdIloHKWTfzDb
         pk+AURVuLLHRLggauddxsNaOKnF+O4J7jLIL7Vs0HYlzDKdXm8UNNfznd2Ie6nGMBtQ0
         zQkHmxRow7dr4+o7nHRBC5C/O6stXOYRhDf319RaRdKxYyJ5Mhd1IXKXWKcknsC03uhk
         QHFBiFrVazgHe4q0mZYswCHlGgkljsmc5+KMkCNEFpW4KCIqYKaRuScpp40m65Q7Nf7q
         5ewA==
X-Gm-Message-State: ANoB5pmC+MPKYSfh7TIccjwSQWbNuiqxUPEnTQEUs+UCXp0ankHlcZsi
        WOCQSq4VvQ+cHP9/niEIb+mkjA==
X-Google-Smtp-Source: AA0mqf4mF13JhpORx1pjJYPRNcogO+X7Oh29vGm+VcX+eNni2cgUCbmjN8FPxQdYEN/m921aEDZQ9A==
X-Received: by 2002:a62:5b43:0:b0:573:6cfc:2210 with SMTP id p64-20020a625b43000000b005736cfc2210mr57434898pfb.55.1670034049745;
        Fri, 02 Dec 2022 18:20:49 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z19-20020aa79493000000b00576670cc170sm1903619pfk.93.2022.12.02.18.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 18:20:49 -0800 (PST)
Date:   Fri, 2 Dec 2022 18:20:48 -0800
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
Subject: Re: [PATCH v4 02/39] x86/shstk: Add Kconfig option for Shadow Stack
Message-ID: <202212021820.72F8CAE9E@keescook>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
 <20221203003606.6838-3-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203003606.6838-3-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 02, 2022 at 04:35:29PM -0800, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> Shadow Stack provides protection for applications against function return
> address corruption. It is active when the processor supports it, the
> kernel has CONFIG_X86_SHADOW_STACK enabled, and the application is built
> for the feature. This is only implemented for the 64-bit kernel. When it
> is enabled, legacy non-Shadow Stack applications continue to work, but
> without protection.
> 
> Since there is another feature that utilizes CET (Kernel IBT) that will
> share implementation with Shadow Stacks, create CONFIG_CET to signify
> that at least one CET feature is configured.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
