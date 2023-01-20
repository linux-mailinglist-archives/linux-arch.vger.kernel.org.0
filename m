Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF0167489F
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 02:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjATBIl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Jan 2023 20:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjATBIg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jan 2023 20:08:36 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707E6A25BD
        for <linux-arch@vger.kernel.org>; Thu, 19 Jan 2023 17:08:31 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id s67so3002254pgs.3
        for <linux-arch@vger.kernel.org>; Thu, 19 Jan 2023 17:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IKjpKG/0VocbPsTgOAYreGyrIOHwyNS9ZDx1w2/uFlc=;
        b=oJC5N30Rq1p+j/FEklleU4l+AvUjwvBZj/den3boKI4D6JnF3UlkXKY4Meml9D0gnf
         1yJtNHfV9AOMvGx+cgg0SWgqW48ffqVfzD8jj/mkUEzC9ZSJMziLP5D7/uE2s9a/Nm5y
         DclcwstDwRUoEkZqbEFMSy7gh9yUFipcpV6Ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKjpKG/0VocbPsTgOAYreGyrIOHwyNS9ZDx1w2/uFlc=;
        b=vdzK+2D657dApPU959pDzn0b/bMZVdF4Gvfqw7YLJ+wADmTKW+u8xuUZ4WrEfZKZeL
         HCSRRwImvr2R5eYjkGbfbg8YiIidUbsGvD+ZG3moXa1LdOoMnHErzvHuB49dcvKALwup
         9NVXSj4UI8sqXSLDesMEEZ663zpCRxRii+Oh3b3lpC6v1WkPjLpU1dFHnOawY6RyIbKZ
         SmErclZw9ga2lFQbPGd0o4/XWetjkWUEEU11YDYNLJoexn6lXHMJPNBxfuInRRWA/PHc
         gLzLUhgwlhlrGaKDb22hZvWsqdCixOEV2YU4KOoHwfIu4B7/ZNofb9NJJnd+huNRWgK8
         ieQw==
X-Gm-Message-State: AFqh2kpAfVcMhYru/RU2Ikttzf6Yz58yxlvDRPlk43CklZUVZezAA6q8
        /KafRQd3Cvd7RTXr7AhUDZxq5g==
X-Google-Smtp-Source: AMrXdXteajZq89ZabMBH5kmQJI6F7YH0Nd65Pp6tC2Lf3UwSDgUIFO1En5tQmtQQFaJJAv5FrqIxcw==
X-Received: by 2002:a62:1901:0:b0:582:5b8e:533 with SMTP id 1-20020a621901000000b005825b8e0533mr33070215pfz.16.1674176910689;
        Thu, 19 Jan 2023 17:08:30 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z26-20020aa79f9a000000b0058da92f7c8dsm8566394pfr.17.2023.01.19.17.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 17:08:30 -0800 (PST)
Date:   Thu, 19 Jan 2023 17:08:29 -0800
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
Subject: Re: [PATCH v5 39/39] x86/shstk: Add ARCH_SHSTK_STATUS
Message-ID: <202301191708.9E60F837@keescook>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119212317.8324-40-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119212317.8324-40-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 19, 2023 at 01:23:17PM -0800, Rick Edgecombe wrote:
> CRIU and GDB need to get the current shadow stack and WRSS enablement
> status. This information is already available via /proc/pid/status, but
> this is inconvenient for CRIU because it involves parsing the text output
> in an area of the code where this is difficult. Provide a status
> arch_prctl(), ARCH_SHSTK_STATUS for retrieving the status. Have arg2 be a
> userspace address, and make the new arch_prctl simply copy the features
> out to userspace.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Suggested-by: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
