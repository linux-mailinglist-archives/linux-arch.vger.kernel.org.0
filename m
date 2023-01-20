Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08627674872
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 02:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjATBBY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Jan 2023 20:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjATBBW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jan 2023 20:01:22 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45242A102D
        for <linux-arch@vger.kernel.org>; Thu, 19 Jan 2023 17:01:20 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so6736936pjq.0
        for <linux-arch@vger.kernel.org>; Thu, 19 Jan 2023 17:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QFsgarPNbICqKMSVZVyYMOF+g+3QXwsXtzOcayGvoi4=;
        b=A9WplzbOSCG6EUOsIJ7kol0hQb5oYSpseab3h1cbCZlz1ZHfA317/hf0oOx902fJYd
         pHxs1xgWKKIz2MDnngJf2LmYabDdDddSS796KfBajBl5UhpiBrj6VMDoPHJU5IfhqNLp
         8983YP9wsnceP1umAtc4itnxZVRMm3gbrbjGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFsgarPNbICqKMSVZVyYMOF+g+3QXwsXtzOcayGvoi4=;
        b=ZzVEFF4wDdletejmJAtS4xkMAv8EP5mGrRc+2Q90mMtEKpheqTDFRcsSXZYHxbTRTE
         HKAY192b3Fo4L/nE9VMPkkvVy9X4TRxsHE2BrsqZfm1P9Gpzvk1I6c2p7IcAuxGBwdo3
         LTUkoOrV6AA9BlnVK+HWNDwuqZSqa20HTrxeFDrDBETLngZyA/7PQRt1iHISh+HOj/QU
         MZojA3QFb7lv6dAeCz1BjqFBBubJLFv3Cc9kKzjswfXx/V0JVtJqJHBP9e66h1OGhjFh
         eIeD0zHOkizjmxIumyWbF25Ne3fLsXZNRp5zzcskpFVrtjk2Nm5HoDrw7+yuJKWkbCJ3
         ESng==
X-Gm-Message-State: AFqh2kp+0LvioatC1gZ5jOpwmZr9OFZSPKQN+R7zLA+nNVAitKxGqTcX
        wpf09mB7UYvV6Zd5uVhHX3FtYg==
X-Google-Smtp-Source: AMrXdXvb9cDkGke9zAyCgTEMw6x2BXISM0o26YyZuQdkPa8eazpgLD3hpkP3EYi76Rast6AtsdUb7w==
X-Received: by 2002:a05:6a20:9c8b:b0:b8:bc13:c838 with SMTP id mj11-20020a056a209c8b00b000b8bc13c838mr13594445pzb.53.1674176479784;
        Thu, 19 Jan 2023 17:01:19 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h4-20020aa79f44000000b0056d7cc80ea4sm10783612pfr.110.2023.01.19.17.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 17:01:19 -0800 (PST)
Date:   Thu, 19 Jan 2023 17:01:18 -0800
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
Subject: Re: [PATCH v5 19/39] mm: Fixup places that call pte_mkwrite()
 directly
Message-ID: <202301191701.ADBD82708A@keescook>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119212317.8324-20-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119212317.8324-20-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 19, 2023 at 01:22:57PM -0800, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> The x86 Control-flow Enforcement Technology (CET) feature includes a new
> type of memory called shadow stack. This shadow stack memory has some
> unusual properties, which requires some core mm changes to function
> properly.
> 
> With the introduction of shadow stack memory there are two ways a pte can
> be writable: regular writable memory and shadow stack memory.
> 
> In past patches, maybe_mkwrite() has been updated to apply pte_mkwrite()
> or pte_mkwrite_shstk() depending on the VMA flag. This covers most cases
> where a PTE is made writable. However, there are places where pte_mkwrite()
> is called directly and the logic should now also create a shadow stack PTE
> in the case of a shadow stack VMA.
> 
> - do_anonymous_page() and migrate_vma_insert_page() check VM_WRITE
>   directly and call pte_mkwrite(). Teach it about pte_mkwrite_shstk()
> 
> - When userfaultfd is creating a PTE after userspace handles the fault
>   it calls pte_mkwrite() directly. Teach it about pte_mkwrite_shstk()
> 
> To make the code cleaner, introduce is_shstk_write() which simplifies
> checking for VM_WRITE | VM_SHADOW_STACK together.
> 
> In other cases where pte_mkwrite() is called directly, the VMA will not
> be VM_SHADOW_STACK, and so shadow stack memory should not be created.
>  - In the case of pte_savedwrite(), shadow stack VMA's are excluded.
>  - In the case of the "dirty_accountable" optimization in mprotect(),
>    shadow stack VMA's won't be VM_SHARED, so it is not necessary.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
