Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871F36413BE
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 03:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbiLCCwj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 21:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbiLCCwi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 21:52:38 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CF6B49
        for <linux-arch@vger.kernel.org>; Fri,  2 Dec 2022 18:52:34 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id fa4-20020a17090af0c400b002198d1328a0so2347035pjb.0
        for <linux-arch@vger.kernel.org>; Fri, 02 Dec 2022 18:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J6Bi98oKuxFWgcdJnIttlj0hQxwkrhCnC895Z7MBrPA=;
        b=G3PwPkklAW4vkncmaBzEMICopZp3Mv692M00zFs27IW9i/6mvm03dt//cegrsFawer
         Uk/v7oR2bXRlYn6JZTG6VV3/FgAq9tdCv4VQqbEryYFq1Zryqks//J9vOxjCDvTajMSL
         Cn3V/5fwZghyCOmIJ898KnniIOWpzz1R5ycFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6Bi98oKuxFWgcdJnIttlj0hQxwkrhCnC895Z7MBrPA=;
        b=1bLREHbIzL2tz2E6F/k9YvnMmF2ZxjjklAA0hUtY/P0T9FkZ+8Z6DTnsiK5TPYqiEc
         kpkTkCMgVWOyo/BjVq8xd8QbyvDbGHaooxT2KUDCc4sHbuSGIaoGj/1Ca7Bu706hOXKW
         DBb0s8Oianh0mkaOP0As9u8D7XrUp/+oqEGiIIjkJBkjEyBL/nSbWLH/zsvVMszNt/7i
         NO6PCXWcVtQXoz2lACD4rfM55Ff0F15t0s9xAeB2i27vSmx6L5qR+F8PVXy8FdpYWc+N
         JkLubts8Cz7ch0gRlvOw6rQI5ZSDthyaevvLTPwoH0eESCc9K2WMI3wDrDJeLZc3br/R
         0jZA==
X-Gm-Message-State: ANoB5pmoA6gzFiJriy8+qWiYN7Mp0QEiODXVpFBfHjRl4iFxJ5sedWgY
        EGaMPw4Z54FUU6G/wQzpaHGy/Q==
X-Google-Smtp-Source: AA0mqf7wuueuka+zZZhnHrTJv5Bs8Z9bgUPy37YEHYzhG6WAxqMTnTK9X0leDnFE/fsw8X1YGvoPwg==
X-Received: by 2002:a17:90a:5d05:b0:219:57e:7790 with SMTP id s5-20020a17090a5d0500b00219057e7790mr43217497pji.3.1670035953807;
        Fri, 02 Dec 2022 18:52:33 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c194-20020a621ccb000000b0056d3b8f530csm5759664pfc.34.2022.12.02.18.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 18:52:33 -0800 (PST)
Date:   Fri, 2 Dec 2022 18:52:32 -0800
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
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com
Subject: Re: [PATCH v4 31/39] x86/shstk: Support wrss for userspace
Message-ID: <202212021852.88C57CF544@keescook>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
 <20221203003606.6838-32-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203003606.6838-32-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 02, 2022 at 04:35:58PM -0800, Rick Edgecombe wrote:
> For the current shadow stack implementation, shadow stacks contents can't
> easily be provisioned with arbitrary data. This property helps apps
> protect themselves better, but also restricts any potential apps that may
> want to do exotic things at the expense of a little security.
> 
> The x86 shadow stack feature introduces a new instruction, wrss, which
> can be enabled to write directly to shadow stack permissioned memory from
> userspace. Allow it to get enabled via the prctl interface.
> 
> Only enable the userspace wrss instruction, which allows writes to
> userspace shadow stacks from userspace. Do not allow it to be enabled
> independently of shadow stack, as HW does not support using WRSS when
> shadow stack is disabled.
> 
> From a fault handler perspective, WRSS will behave very similar to WRUSS,
> which is treated like a user access from a #PF err code perspective.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
