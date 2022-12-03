Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6438964139D
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 03:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbiLCCkH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 21:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235230AbiLCCkE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 21:40:04 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2529FA44D
        for <linux-arch@vger.kernel.org>; Fri,  2 Dec 2022 18:40:03 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id cm20so6555265pjb.1
        for <linux-arch@vger.kernel.org>; Fri, 02 Dec 2022 18:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XLViDR2zcWqltZaMqOGe9UxH/Um8wO533PT9cRofQvA=;
        b=T4HzE5jaCq8vZkmDtWPOboOLn6craU7f/b/P8EJ6uRQd8L1E2whKgn4WGwiBS1b7U6
         c8zE9oXrXi/eg25YVdEdHOwAzyoEsHNE9+Rf7MSyNkzA0myb+7xNNtjPfTkKgGY2pyyN
         cXtIAN+AegJpgeHjkS/87VgCfN9Su2eIhsrLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLViDR2zcWqltZaMqOGe9UxH/Um8wO533PT9cRofQvA=;
        b=15XSyB4pHuA98UhCWB9WMoutnvDS5uhElvcp0mQpbtrBkVHy9Dn0lbXv3QILp9acge
         ANbhmvcogLWd2l8+FTjv7vtd2SNK1qFWg1JF+SgnpBKJX8wobH5/H5JgnKUaM/BwxU0A
         rOvlMfY7V3EyaKawED2ziN/Db7KqTQPpPUlhQQqLGqcOUAsTPyZev6fTyWOedd97mQKG
         XfIbCn1lBRAvfuuR0yNbDhr4Cbv0NPMVDHvzDk5cx4GkYr0y9VUkd0qHkuIYGLE/03l5
         eCeG/IOJEKM3sb1Y0l8FMZol0HKfMtYuYAKMxcEKQpWFiWLYn20a+ZKstc8anHOF1FB1
         YAIA==
X-Gm-Message-State: ANoB5pkb8phweHMGq4kQNi8YS7XFEOKQfCQtapjI1DyTPypX4MpJVNUK
        /qpw3vUoyXphNpqRDlXiiNA1Tg==
X-Google-Smtp-Source: AA0mqf5A/xJVhK8c81WSI6tm1qf38hEAd20DFdNPVcIcrs0OziQiD4xi28050EAgthHM5YFZZ45KCA==
X-Received: by 2002:a17:903:555:b0:189:959a:84d8 with SMTP id jo21-20020a170903055500b00189959a84d8mr23315184plb.38.1670035203342;
        Fri, 02 Dec 2022 18:40:03 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id cx5-20020a17090afd8500b002135de3013fsm5351942pjb.32.2022.12.02.18.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 18:40:02 -0800 (PST)
Date:   Fri, 2 Dec 2022 18:40:02 -0800
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
Subject: Re: [PATCH v4 24/39] mm: Warn on shadow stack memory in wrong vma
Message-ID: <202212021840.D890531@keescook>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
 <20221203003606.6838-25-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203003606.6838-25-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 02, 2022 at 04:35:51PM -0800, Rick Edgecombe wrote:
> The x86 Control-flow Enforcement Technology (CET) feature includes a new
> type of memory called shadow stack. This shadow stack memory has some
> unusual properties, which requires some core mm changes to function
> properly.
> 
> One sharp edge is that PTEs that are both Write=0 and Dirty=1 are
> treated as shadow by the CPU, but this combination used to be created by
> the kernel on x86. Previous patches have changed the kernel to now avoid
> creating these PTEs unless they are for shadow stack memory. In case any
> missed corners of the kernel are still creating PTEs like this for
> non-shadow stack memory, and to catch any re-introductions of the logic,
> warn if any shadow stack PTEs (Write=0, Dirty=1) are found in non-shadow
> stack VMAs when they are being zapped. This won't catch transient cases
> but should have decent coverage. It will be compiled out when shadow
> stack is not configured.
> 
> In order to check if a pte is shadow stack in core mm code, add default
> implmentations for pte_shstk() and pmd_shstk().
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
