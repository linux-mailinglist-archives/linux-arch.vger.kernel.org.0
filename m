Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD5B69C25C
	for <lists+linux-arch@lfdr.de>; Sun, 19 Feb 2023 21:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjBSUjc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 Feb 2023 15:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjBSUjb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Feb 2023 15:39:31 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801A418B00
        for <linux-arch@vger.kernel.org>; Sun, 19 Feb 2023 12:39:30 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id p7so1332562plf.9
        for <linux-arch@vger.kernel.org>; Sun, 19 Feb 2023 12:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VSb9sHqoGaX0ZmNLCacxp8wGphEMlpICECfuxg/6qfo=;
        b=bu4z3fK3Nw4HhLOx/qgH3yNXGHbhBqxOBEwd5mLyqsfX5MQUjD7h2lfuho4muVXNow
         Nn81BNCLyl6wHaPe2rR7v7GePfrSc7J9n9IbIl92KLHp2WKLsoVcbNFhiKj7rV0xH2C+
         9WG0yXt0ferrSb+q0i88lvD0cAA5YyVFUZ9Kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSb9sHqoGaX0ZmNLCacxp8wGphEMlpICECfuxg/6qfo=;
        b=oxQAG0Yk9SMspyBNDSasuaxPldocvdFxWKQC3xBGrv7x5pgLc+oSfsg/+jNNGf9y8p
         kupeHLONH7LHuZA1IUtHAW0C530TrECz0Kckj7rwQC+llvHSBWdEGwvykK8ZpCf8UPB9
         /tHiuA0eUvTnow5+Ny31lkaRO38USsTBK6PHCyJkBPtm8+qlED/zgfevaQAsEPCoFEQc
         UZZd/cjEGA4jGdnTXk0Fj5+tWro248ePEhBG/0mlAtJihnLYmujHIsmARblRktV+BdWV
         5tmk2lc2g2tYJqY7GVks0b8416smbs44DezjGDOT8fbJHZYz29nH88u5yOIam4iG2xRJ
         9GCA==
X-Gm-Message-State: AO0yUKVfkrZuNXyeFDglHQHOG3iKEj6dI36/xzE86mvBqyURDCYgmPuQ
        5C0M+wA9po0q30UDnSc3/cJJWA==
X-Google-Smtp-Source: AK7set8Z0ntrqwUzPx0nvUWdIPEe1au4xT4h8TIYhX6gENNMytmy/Bxwko3qUQliHF8keZ//uamelA==
X-Received: by 2002:a17:903:32cf:b0:19b:441c:3913 with SMTP id i15-20020a17090332cf00b0019b441c3913mr2016208plr.44.1676839169923;
        Sun, 19 Feb 2023 12:39:29 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r6-20020a170902be0600b00199537a7466sm6345581pls.39.2023.02.19.12.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 12:39:29 -0800 (PST)
Message-ID: <63f28901.170a0220.7090.af7b@mx.google.com>
X-Google-Original-Message-ID: <202302191238.@keescook>
Date:   Sun, 19 Feb 2023 12:39:28 -0800
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
        david@redhat.com, debug@rivosinc.com, linux-s390@vger.kernel.org
Subject: Re: [PATCH v6 12/41] s390/mm: Introduce pmd_mkwrite_kernel()
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
 <20230218211433.26859-13-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230218211433.26859-13-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 18, 2023 at 01:14:04PM -0800, Rick Edgecombe wrote:
> The x86 Control-flow Enforcement Technology (CET) feature includes a new
> type of memory called shadow stack. This shadow stack memory has some
> unusual properties, which requires some core mm changes to function
> properly.
> 
> One of these changes is to allow for pmd_mkwrite() to create different
> types of writable memory (the existing conventionally writable type and
> also the new shadow stack type). Future patches will convert pmd_mkwrite()
> to take a VMA in order to facilitate this, however there are places in the
> kernel where pmd_mkwrite() is called outside of the context of a VMA.
> These are for kernel memory. So create a new variant called
> pmd_mkwrite_kernel() and switch the kernel users over to it. Have
> pmd_mkwrite() and pmd_mkwrite_kernel() be the same for now. Future patches
> will introduce changes to make pmd_mkwrite() take a VMA.
> 
> Only do this for architectures that need it because they call pmd_mkwrite()
> in arch code without an associated VMA. Since it will only currently be
> used in arch code, so do not include it in arch_pgtable_helpers.rst.
> 
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mm@kvack.org
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Yup, 1:1 refactor.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
