Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC07D5F3487
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 19:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiJCRcQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 13:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiJCRbz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 13:31:55 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F023A497
        for <linux-arch@vger.kernel.org>; Mon,  3 Oct 2022 10:31:48 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id z20so3763805plb.10
        for <linux-arch@vger.kernel.org>; Mon, 03 Oct 2022 10:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=brOcpUsUebGaNnS9rr/mt+efWwjd5MMft3vidAloMCk=;
        b=GpXJl7r64TNCgnOm/rwzqm9/zk7r5bZs1M5dug+kDOLMHf5hbIymxV51Z69U+kH4ec
         Xh+SzqohGNj3VGnNBOgqyJHMF0dIC9NSQLfJh1llp1R+BxRxZ/qIGnDPQdSLmPX14uio
         of8Xxx4zz2IGzaRCl+H1y+LAFkYlycpJPRqBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=brOcpUsUebGaNnS9rr/mt+efWwjd5MMft3vidAloMCk=;
        b=01s34q9PAbHskQO3z1jVkq8p7JAX1y6hKMRWohjF7KXHujI0DKGVQGMSAWH37Ms77c
         BW7EE5Ci+KwRp6V2lGyWDikcmiExPcfWRVS0Ft12sivUDUoTdrVjV+XMIJOAYUw1CPsb
         lAD9D7m9CAKDJ6GbOP6wDpzvJztK52ojuQH4oazMwuZZgAr4ELPBwihVYClBEPQygALg
         tW4Ebh4JiqHFZ0csP/ebIuVNfEljWb/OnxBrN757Bwd/iFeX+sAMkFmorq5INGSaHaUO
         cepiHHXezm6/O40F6Fek/yHiBoOs7tk006MEcyWjZ1GO/a/KyoNovDhIeV5uH0slBW3Q
         aF3g==
X-Gm-Message-State: ACrzQf1FL2jXfJwaJowKWOAtg6n0fz5geFWNCybJPSk93ql4h5c13/3+
        WFghiqadMLN+DrK+18pvLDFJrQ==
X-Google-Smtp-Source: AMsMyM57IJgx9Y5p5pOQkLFB+rSBDgUxwSCSiOSFplteoE6b0dUVolrJ3ykqvwSNZ198SqBVgt1Gug==
X-Received: by 2002:a17:902:7081:b0:178:6154:9d79 with SMTP id z1-20020a170902708100b0017861549d79mr23572512plk.79.1664818307148;
        Mon, 03 Oct 2022 10:31:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y23-20020a17090264d700b00176e2fa216csm7562816pli.52.2022.10.03.10.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 10:31:46 -0700 (PDT)
Date:   Mon, 3 Oct 2022 10:31:45 -0700
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
Subject: Re: [PATCH v2 04/39] x86/cpufeatures: Enable CET CR4 bit for shadow
 stack
Message-ID: <202210031031.E2942B66@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-5-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-5-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:01PM -0700, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> Utilizing CET features requires a CR4 bit to be enabled as well as bits
> to be set in CET MSRs. Setting the CR4 bit does two things:
>  1. Enables the usage of WRUSS instruction, which the kernel can use to
>     write to userspace shadow stacks.
>  2. Allows those individual aspects of CET to be enabled later via the MSR.
>  3. Allows CET to be enabled in guests
> 
> While future patches will allow the MSR values to be saved and restored
> per task, the CR4 bit will allow for WRUSS to be used regardless of if a
> tasks CET MSRs have been restored.
> 
> Kernel IBT already enables the CET CR4 bit when it detects IBT HW support
> and is configured with kernel IBT. However future patches that enable
> userspace shadow stack support will need the bit set as well. So change
> the logic to enable it in either case.
> 
> Clear MSR_IA32_U_CET in cet_disable() so that it can't live to see
> userspace in a new kexec-ed kernel that has CR4.CET set from kernel IBT.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Kees Cook <keescook@chromium.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
