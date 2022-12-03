Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF8764133B
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 03:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbiLCCUS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 21:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbiLCCUQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 21:20:16 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67F0B2751
        for <linux-arch@vger.kernel.org>; Fri,  2 Dec 2022 18:20:13 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id jl24so6225163plb.8
        for <linux-arch@vger.kernel.org>; Fri, 02 Dec 2022 18:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uWTcrQs76OXnN9lbgVOglSiDBLgPYobcjd4cqmFFNh0=;
        b=br0isiwIge4UTmUJvBAJu/hBvPA1Lr+Q6aU07D4VkWEjqVthAO51+vJImZ1FrZHRdD
         VwddOLnbJ/XU9t7ILuN1HA+G47+zvC5AQpnHVRuGKqkY67gReiKKFP9GgZqMko0YcNtw
         ClxdvdHcude27V4L/cMq4ecvT54mwZxIkLN4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWTcrQs76OXnN9lbgVOglSiDBLgPYobcjd4cqmFFNh0=;
        b=17l5/ks5zaP03arWN6sY010GHSTp9mEA5iKod/ATLMVI3cKfjRhncBvcGmffSqZMH9
         Q8mE4nrsCiDFkLjYv3l0n3koWPg4OhzByURQmmleT04XGBOKtEhtZ1Y/la+V0jKMgyBZ
         EOMhPf/Kn5YmQlG2ctaizJ/Y/3xVNkriovm48N1UYLZbXEzOX0Tu02cPYXh/5rk0F/to
         SYKS1Tlo/0zfcOtZFk5JiVzFIoITS1UETZjnuGC0pNZOEVMDgjoq/G0cf9UfiAa7sCIS
         H2SY4ppN7ayQeX2q3JqyG5zk2pSXqauc4+LfzE8WIWFwtxE3snM/Rec6A3xnZn72o1Ib
         m45w==
X-Gm-Message-State: ANoB5pkZsAIeUH/+OBh9DylovgmezXurKsnJD74rwUCRmNtRRvTHippz
        CN6vgpPYxKu9h3e8jdFbtFcf6Q==
X-Google-Smtp-Source: AA0mqf5I/xkYCiW+AL4KD543i0yq8zicOFbYEE9zrRwPsqNnGgfsCRnMQokLFlIn+NMdh7ZPPB+0Rg==
X-Received: by 2002:a17:902:ef44:b0:185:40ca:68b8 with SMTP id e4-20020a170902ef4400b0018540ca68b8mr56029977plx.16.1670034013379;
        Fri, 02 Dec 2022 18:20:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p2-20020a622902000000b0056e8eb09d58sm5891712pfp.170.2022.12.02.18.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 18:20:12 -0800 (PST)
Date:   Fri, 2 Dec 2022 18:20:12 -0800
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
Subject: Re: [PATCH v4 01/39] Documentation/x86: Add CET shadow stack
 description
Message-ID: <202212021820.AD41327@keescook>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
 <20221203003606.6838-2-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203003606.6838-2-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 02, 2022 at 04:35:28PM -0800, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> Introduce a new document on Control-flow Enforcement Technology (CET).
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
