Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95611674838
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 01:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjATAqm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Jan 2023 19:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjATAql (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jan 2023 19:46:41 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A071B90853
        for <linux-arch@vger.kernel.org>; Thu, 19 Jan 2023 16:46:26 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id d8so4130449pjc.3
        for <linux-arch@vger.kernel.org>; Thu, 19 Jan 2023 16:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P1wnVSZdra+euEs7ZvKDTGyvbT6g6viojgbgmEshJwE=;
        b=mrcA3bRAfRsxg962kSM9tEKDUYTUg47gO03Fl0Kq0/nsxlmmWfudI9OPr3V0fBBN0q
         SOzp5bOcdDI4N4u4dxAv+c+bS+x2EUsiZbZAmFpmxaL/enWKLIir3E2hUYb3nH5vK5M+
         226Z4Y5MF/vfMm5VHfAHPVavGegauof4l6Q7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1wnVSZdra+euEs7ZvKDTGyvbT6g6viojgbgmEshJwE=;
        b=EpjoxFn/yiSmmooRQB/8n5xDbUECh28gDnOHmBN/sI3IsFWAie3HNdmp6jJm+nQwoC
         Z9U17rMbUwFYYLDsUL5PXcd722Neq8Vnp+yGH10USzzGP9W9wrOMp7fVGPwbimb4q/Aa
         EUEhjB1WYyGCNyewy6gTvW2S7840vwr7UG2Rbg0TL9kMxCh20OOJhj2T7q+NakrBwuzE
         FmDyRRTh8BDB7TiO03Mj6ifGouOqV/Pp1QaRC4KCPa1ysxcdMUYq+IcbKBlHyNF0S6CZ
         PRVAeqK6h/nse9GG1/8hc4LeTNk/dx6ku6wWxp70bucOwSuuz59BW+shO0uf3KCgcZeq
         UzZA==
X-Gm-Message-State: AFqh2kqH2iixti2bBth9qe+Al2JMKf0/rOgILjrsugHSovJWWI5TbpHX
        Q1KdZMEpN/OwzA9AD6Nvch7QGA==
X-Google-Smtp-Source: AMrXdXvz4LrAbyOlE6ugjAl0CAgWr/m2tS2CGoI+FfZesn3j5vlMIGe5u5ya9NwlUhOtYRWYqiuS0g==
X-Received: by 2002:a17:902:b60e:b0:192:8b0e:98e1 with SMTP id b14-20020a170902b60e00b001928b0e98e1mr12059970pls.54.1674175586170;
        Thu, 19 Jan 2023 16:46:26 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w9-20020a1709026f0900b00194b3a7853esm4528706plk.181.2023.01.19.16.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 16:46:25 -0800 (PST)
Date:   Thu, 19 Jan 2023 16:46:24 -0800
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
Subject: Re: [PATCH v5 04/39] x86/cpufeatures: Enable CET CR4 bit for shadow
 stack
Message-ID: <202301191646.E739868F@keescook>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119212317.8324-5-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119212317.8324-5-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 19, 2023 at 01:22:42PM -0800, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> Setting CR4.CET is a prerequisite for utilizing any CET features, most of
> which also require setting MSRs.
> 
> Kernel IBT already enables the CET CR4 bit when it detects IBT HW support
> and is configured with kernel IBT. However, future patches that enable
> userspace shadow stack support will need the bit set as well. So change
> the logic to enable it in either case.
> 
> Clear MSR_IA32_U_CET in cet_disable() so that it can't live to see
> userspace in a new kexec-ed kernel that has CR4.CET set from kernel IBT.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
