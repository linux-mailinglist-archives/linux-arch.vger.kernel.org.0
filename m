Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2104764137C
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 03:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbiLCCfE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 21:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234951AbiLCCfC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 21:35:02 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89214D587E
        for <linux-arch@vger.kernel.org>; Fri,  2 Dec 2022 18:35:01 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id 4so6288182pli.0
        for <linux-arch@vger.kernel.org>; Fri, 02 Dec 2022 18:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XQs9tVfGT9YvsTDVtvy9w4wMLhjzx69/QPDnzOH4S3c=;
        b=BdWCY0D6/wr/oO1soihVhNirwM62d3x+s0tgQ6bwd5Rj7JWEA/AE/XrfRopNOAwoz/
         05TXAjAuCW+vWbam1c1pbg13GCl4Mz1YtIeOJ4DYFu7vJpwyP3u/pJk7EQbmF1Fsbvxo
         IbSQDRCtw92dj9E+wfFDvqc9KGav6VtbWimEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQs9tVfGT9YvsTDVtvy9w4wMLhjzx69/QPDnzOH4S3c=;
        b=BCr0sznmcmv+zS+SGf6xWJ5jG7zDbkqiK7dZOt8i/DBIbXZq+XehHyQRZ8H6MNiBTm
         7NfJOmflvVWIbxyorZJQ6IEwFEA2BDb4oLIb9udEMPCwnSTiuGkh7VIa/3Tl48PUuGBC
         xUHRWqwTLnigP07NUPkH6FFqgGMwF5NpshV6hf7YYclL8aDcUiFQad7tbJ8XcDxa6Erl
         7pzjuoM7hk2d6+JP9HiMXeXUR1B0sYrIEBtUkBI/EtZoR8qQMm72tVFN9yTQjTMPVpMc
         iZ8QuDHe/P/V9cCrmFtlfKV63rBJw6PaYiwFHw8yy5JDsPTa71g0bJwpoLzxpaghB/r5
         KWBg==
X-Gm-Message-State: ANoB5pm2iG504dgxaqBkeUEv2ueUMafgeA/k6dAsF1EZxWhT0iUVU9fB
        tSiE663rOZIyM8hFkG77pjjYqQ==
X-Google-Smtp-Source: AA0mqf7uStX3Ydoku6VU5WdR7aRvh89xtQi2ykwRpNP9wSfKDZaPCJnsBpzs/d7FPH3HpDywGEnbxA==
X-Received: by 2002:a17:90a:5918:b0:213:df25:7e8a with SMTP id k24-20020a17090a591800b00213df257e8amr86239470pji.154.1670034901104;
        Fri, 02 Dec 2022 18:35:01 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l12-20020a170902e2cc00b00176a6ba5969sm439650plc.98.2022.12.02.18.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 18:35:00 -0800 (PST)
Date:   Fri, 2 Dec 2022 18:34:59 -0800
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
Subject: Re: [PATCH v4 17/39] x86/mm: Update maybe_mkwrite() for shadow stack
Message-ID: <202212021834.200AFA92BC@keescook>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
 <20221203003606.6838-18-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203003606.6838-18-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 02, 2022 at 04:35:44PM -0800, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> When serving a page fault, maybe_mkwrite() makes a PTE writable if there is
> a write access to it, and its vma has VM_WRITE. Shadow stack accesses to
> shadow stack vma's are also treated as write accesses by the fault handler.
> This is because setting shadow stack memory makes it writable via some
> instructions, so COW has to happen even for shadow stack reads.
> 
> So maybe_mkwrite() should continue to set VM_WRITE vma's as normally
> writable, but also set VM_WRITE|VM_SHADOW_STACK vma's as shadow stack.
> 
> Do this by adding a pte_mkwrite_shstk() and a cross-arch stub. Check for
> VM_SHADOW_STACK in maybe_mkwrite() and call pte_mkwrite_shstk()
> accordingly.
> 
> Apply the same changes to maybe_pmd_mkwrite().
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
