Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8112064136F
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 03:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbiLCCdd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 21:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235022AbiLCCdc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 21:33:32 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D55DD11CF
        for <linux-arch@vger.kernel.org>; Fri,  2 Dec 2022 18:33:29 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id k2-20020a17090a4c8200b002187cce2f92so9943995pjh.2
        for <linux-arch@vger.kernel.org>; Fri, 02 Dec 2022 18:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UQHpdcG0W3UOHn08MSLP1Hn9wMHJIZSaG2NLULB4U7o=;
        b=E3bdGTvQFJOu55KJyamBSJ4T9NSqfMM5Csnbxgq36xtAGpgkHrj/bujWh1mOR7TYN8
         w9hvOgwZSBtg9CIC6o64G1mfBhzL8E6UCAO5O3zJFxZgKtNAMkoa0XsW6kX7wn5wqlWs
         OaqF8Uxv3zj9vtEdDaJG6lGtv3V4g96YLmq84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQHpdcG0W3UOHn08MSLP1Hn9wMHJIZSaG2NLULB4U7o=;
        b=XGvoT/TZI7lk0eQOTlqfo9oP0uwdbEYFWBS2v8DaM9jIjRIsrsK3lDnBbQeIloBFm4
         xyYac6f4FNCa/zYwoKHftPCT6R/6vg7GwDIFsN/+iRsZ/PBo+fOkLdPWFHHujfI9o3pf
         ImRxMeteEquyYVVdFk8bBNiQQdN33vjVzXxb19Bb4f6GaNLZRf0p0MEgjU74gbmbqPOV
         4A2Prolg8WQAD5MpW+JMbEGFE0RC5sVcanBctdl2IdxOk0U1I/N9vH5KIwsy2P2IeImh
         XCQUdJfFedEjAHAgfLnV6kcyfDaHc4n7F5bxQZm/2geIkccIfix+anLzmpoTFN39dTgS
         I14Q==
X-Gm-Message-State: ANoB5pnj262+rxvHIIQXLTs6QMt4bITlyhKlnoJD9giLO3pPHdrC2Ue6
        72NP2KoVprOh5WOhvdYWax0uAQ==
X-Google-Smtp-Source: AA0mqf4geVaa0a643GENg2McukE2oodkrSBYzsuzasDBLw/p2NXrif8eGSQbP+ryc5PiIYw/fBbkSQ==
X-Received: by 2002:a17:90a:8b18:b0:219:1897:f72b with SMTP id y24-20020a17090a8b1800b002191897f72bmr36568022pjn.141.1670034808999;
        Fri, 02 Dec 2022 18:33:28 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e68-20020a621e47000000b00574db8ca00fsm5706861pfe.185.2022.12.02.18.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 18:33:28 -0800 (PST)
Date:   Fri, 2 Dec 2022 18:33:27 -0800
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
Subject: Re: [PATCH v4 13/39] x86/mm: Start actually marking _PAGE_COW
Message-ID: <202212021833.58C233E5@keescook>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
 <20221203003606.6838-14-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203003606.6838-14-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 02, 2022 at 04:35:40PM -0800, Rick Edgecombe wrote:
> The recently introduced _PAGE_COW should be used instead of the HW Dirty
> bit whenever a PTE is Write=0, in order to not inadvertently create
> shadow stack PTEs. Update pte_mk*() helpers to do this, and apply the same
> changes to pmd and pud.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
