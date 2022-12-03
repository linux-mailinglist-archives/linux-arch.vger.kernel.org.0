Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA221641381
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 03:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbiLCCha (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 21:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbiLCCh3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 21:37:29 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C59D5847
        for <linux-arch@vger.kernel.org>; Fri,  2 Dec 2022 18:37:28 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id x13-20020a17090a46cd00b00218f611b6e9so6701692pjg.1
        for <linux-arch@vger.kernel.org>; Fri, 02 Dec 2022 18:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oDrBZAQ9dEymmeztlBFZKPMsI8zCA1Y+uTeDvwebtj0=;
        b=QXTeqyNf09nL4ihD3rc8zTJ3kQ0m2WTtL1DZTt6tAiD9WLlbJ2V3DUXo16B14iGew9
         yvF5tqIBHYNZs8q810PNVrKvX10/GGR1yc60nEPB/qL+H1G53m/ugcND1HflOkD83FjL
         VVTQM23Ooc4TcwV6s0oaObc7nzzwBXlNShCLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDrBZAQ9dEymmeztlBFZKPMsI8zCA1Y+uTeDvwebtj0=;
        b=gZeg5VsPvap63Bv+Za21BZfuUkWcNfWj7WDB/GmKuZe8WWqLcKb/z2hnoI3A5ifs+h
         WbnvXdQ5NzS+7eQRq7NAKAE+H77upRIGfMUE1ClAYAbaFEvKakoXp0zxxCdFdhjyHaAA
         vJczGgeZx3dG4gxhA/QR3etCkwL2Y8TStD0LXjdi95FevzeyAK/S+9bpPAjeAvnmjwmd
         rz4PEUWNv86RJa75Xs1qW3zguelPyxjl404CnxZOEJFPHsbSN3e6Rf7o2puxT6YeBCXu
         arZyt1BLRloP7eRxn1LM9ETTt4iPgbDipz5Cqz1Adw+DLjMn/zx0dfCBmT8h3+7xKk0y
         iOew==
X-Gm-Message-State: ANoB5pkBLF8Lil50mZgfrAcfhSpuU2iLthRGiejoeKtrJFhY05XEwgXk
        Fi/1eSjWJQ5LtZ8TCta6MSU4NQ==
X-Google-Smtp-Source: AA0mqf6Yiy5i07xGDs9XahDJ4dz0BQpR9Pb4qYcyOeS+OtU0c7pIrWALrEQ88lg1YSkd43nZoT7wjQ==
X-Received: by 2002:a17:902:a511:b0:174:7d26:812f with SMTP id s17-20020a170902a51100b001747d26812fmr55899215plq.63.1670035047871;
        Fri, 02 Dec 2022 18:37:27 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g19-20020a170902e39300b00189a540f545sm6186408ple.191.2022.12.02.18.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 18:37:27 -0800 (PST)
Date:   Fri, 2 Dec 2022 18:37:26 -0800
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
Subject: Re: [PATCH v4 18/39] mm: Fixup places that call pte_mkwrite()
 directly
Message-ID: <202212021837.73582B63@keescook>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
 <20221203003606.6838-19-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203003606.6838-19-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 02, 2022 at 04:35:45PM -0800, Rick Edgecombe wrote:
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
>    shadow stack VMA's won't be VM_SHARED, so it is not nessary.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
