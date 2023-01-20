Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDC6674861
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 01:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjATA52 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Jan 2023 19:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjATA51 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jan 2023 19:57:27 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D3D9F06E
        for <linux-arch@vger.kernel.org>; Thu, 19 Jan 2023 16:57:25 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id u1-20020a17090a450100b0022936a63a21so7574858pjg.4
        for <linux-arch@vger.kernel.org>; Thu, 19 Jan 2023 16:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lEHXslOior1iC36oZl8rvCBEJjihHqep9sJwUDMqsEg=;
        b=f3y4Qq2kjIJ57POmydv+v0X2WmxwQwjCJNO+IzVXLoV2114lAMl6Ch00VZy9aIEyBd
         oilRLW1fxHa2Ex9xwuimXDFKNwIjlloI72Kl1kNyAIT+zMOSEFmfLcV8/zKlxRqJ+YKW
         3Z+JnxVbm1Lhnb6pdZm0/iDTmL4b2OBJDWeY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEHXslOior1iC36oZl8rvCBEJjihHqep9sJwUDMqsEg=;
        b=S72UKpGcfmYLU0eLeoXo94EKnSV1m0+yqY3gdbrFZLjIqVXL7VCiug4WC2oNuHbQif
         jbhxY7B/M9YT/Omrhg4GEomC/ouzxFUKUD/2hHsHkniGNdf9h/lY1KZUn4a5y8WcOH81
         oWBdOeKpcKuOK8lUfs1jn9C5OJ9SGIUVk3u9v+Wx+rfQH3PDz+UdCrNM8iPXCIqBAkBU
         37NhIcyEGg1udqmYJ4LbyA5AvY4QMpX/nQLYKJPZnNsQYXTcMoQgX9NFn8uaRWbADpNh
         IrQUtmKeClYpbDfT/xvb0RQUDqbOCgGy2tk24l6/SpJnqeLUf8jhQxxHk/c4YdZKYedM
         piIg==
X-Gm-Message-State: AFqh2krvsZhNn5U+rKHER/y6ilOCYERmFh/Uz4CswVAhLdj5kkt+EUlx
        X+S3QjNt/ISp4uQ+BBCZZ4lEmg==
X-Google-Smtp-Source: AMrXdXuzvSuvcNQXbjmD67x6eCKVyFgfIP6jDqIDZgYrd6B5X7omXzC+CDMYarBYrLg2yENuyJffyg==
X-Received: by 2002:a05:6a21:151a:b0:b8:927a:6a9d with SMTP id nq26-20020a056a21151a00b000b8927a6a9dmr14012280pzb.9.1674176245077;
        Thu, 19 Jan 2023 16:57:25 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u11-20020a6540cb000000b0046ff3634a78sm21576083pgp.71.2023.01.19.16.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 16:57:24 -0800 (PST)
Date:   Thu, 19 Jan 2023 16:57:23 -0800
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
Subject: Re: [PATCH v5 11/39] x86/mm: Update pte_modify for _PAGE_COW
Message-ID: <202301191657.3B81D1C589@keescook>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119212317.8324-12-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119212317.8324-12-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 19, 2023 at 01:22:49PM -0800, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> The Write=0,Dirty=1 PTE has been used to indicate copy-on-write pages.
> However, newer x86 processors also regard a Write=0,Dirty=1 PTE as a
> shadow stack page. In order to separate the two, the software-defined
> _PAGE_DIRTY is changed to _PAGE_COW for the copy-on-write case, and
> pte_*() are updated to do this.
> 
> pte_modify() takes a "raw" pgprot_t which was not necessarily created
> with any of the existing PTE bit helpers. That means that it can return a
> pte_t with Write=0,Dirty=1, a shadow stack PTE, when it did not intend to
> create one.
> 
> However pte_modify() changes a PTE to 'newprot', but it doesn't use the
> pte_*(). Modify it to also move _PAGE_DIRTY to _PAGE_COW. Do this by
> using the pte_mkdirty() helper. Since pte_mkdirty() also sets the soft
> dirty bit, extract a helper that optionally doesn't set
> _PAGE_SOFT_DIRTY. This helper will allow future logic for deciding when to
> move _PAGE_DIRTY to _PAGE_COW can live in one place.
> 
> Apply the same changes to pmd_modify().
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
