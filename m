Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E3F5F353D
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 20:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiJCSGX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 14:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiJCSGX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 14:06:23 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E9827166
        for <linux-arch@vger.kernel.org>; Mon,  3 Oct 2022 11:06:22 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 3so10326743pga.1
        for <linux-arch@vger.kernel.org>; Mon, 03 Oct 2022 11:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=pIzTmQpobMdvo8GfKaRW2/roCkTNS3D5pBPTXA+12i8=;
        b=SXA4C8zlP/H6XYd9Wus6gRGtSyRucd9T6u9HfOHffXz/P69o11Ry2w00sgWnrMs5Xk
         wyVtfRqObDML4/alrBwbIuF3aYbADtN6HUCQ5qukqpvVWDlU7j9zT9EIV5AApI/1J1QH
         83iN0ga1Tm78Y3rGKi7ExlccIx4e25wNLa/oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=pIzTmQpobMdvo8GfKaRW2/roCkTNS3D5pBPTXA+12i8=;
        b=hplYNFQ1deJaz52qg9uDi3EBLCwE3OMPNSJSid9VbaUjThiSWIIJERu/xcS+Wr/hBx
         EHinHbk5WuexVtkT5fzzvSWE4WSux/afbkjnNSCSZE8Xn/8tSCgVUg+Cj0ud319CWio2
         W3WdkXcTqsjxZiTfvtR6l9StnwDZkC1IDn3+AGk/UN8MWrFG4yAMtzuc9puE5QR3YFmM
         xjIreKAfVh6K2ZVlwAitXDAkWpNY3E+s4kP/YvceFS3lLtGcswG0MUTZ3S2cufEJdB8V
         swnjLrx7WoN1lF0iLL6nvEBc9ZthiSkV/BgJfQsVvMlF+lIotd62VGyqeqbkqF77YfaU
         eOpw==
X-Gm-Message-State: ACrzQf1mS8BGvVQS/SG39OGzVZ2DZ899BNal3WA1qYmPrEm3BrbJ5ZAM
        ttbuKyA9rYOE9YxpIEhxNUxh9A==
X-Google-Smtp-Source: AMsMyM5neqQ02uhM3tW616MWu61HS4Vdqno2CVR6UnaXvvhzpp2blmFWahTxoonexAZ1EXGCH3aHSg==
X-Received: by 2002:a05:6a00:4c11:b0:53e:4f07:fce9 with SMTP id ea17-20020a056a004c1100b0053e4f07fce9mr24392025pfb.66.1664820381761;
        Mon, 03 Oct 2022 11:06:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x2-20020aa79562000000b0053dec787698sm4474742pfq.175.2022.10.03.11.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 11:06:20 -0700 (PDT)
Date:   Mon, 3 Oct 2022 11:06:19 -0700
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
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v2 09/39] x86/mm: Move pmd_write(), pud_write() up in the
 file
Message-ID: <202210031105.39AA8FE@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-10-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-10-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:06PM -0700, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> To prepare the introduction of _PAGE_COW, move pmd_write() and
> pud_write() up in the file, so that they can be used by other
> helpers below.  No functional changes.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Hey, a PTE patch I'm able to review! ;)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
