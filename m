Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6BE30FDDC
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 21:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239113AbhBDTyU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 14:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239480AbhBDTwQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 14:52:16 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9873BC0611C2
        for <linux-arch@vger.kernel.org>; Thu,  4 Feb 2021 11:50:32 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id d2so2429103pjs.4
        for <linux-arch@vger.kernel.org>; Thu, 04 Feb 2021 11:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XEd3fj8C4Ej+cJekaWRpKIX0Ali26hPYu3xkyPp+pQI=;
        b=V5fnl7iYb3ZfPR+qNCY00qtPY4Zo5HYT4FKsFoDpMe4St8xT2WymhYRfA9fonj0t3N
         Ry2p+pd8ObmedFtbRyxsyqpdCtPiUnK/CB8gzC4Rin9XIv5zwglllzt9qQtP3qrZnaNn
         Kw0ZealDwP8Jmc0Ncx2MO/2X5U9uN8ETdkHt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XEd3fj8C4Ej+cJekaWRpKIX0Ali26hPYu3xkyPp+pQI=;
        b=DQu1BGgVqsWWXHTVeHzHyka6Yue0rxDMCJh6xVnz8klPbSilnxH/KTC5uSD2MSgo9/
         7huDBzwrOyHawOM/7Dq681m17rIF1B6qq3GI6eFwGCtbNjAf3qg1VBV54H9UJ98oiGo3
         FH/6DGe6gj8Ps9m7I9guW3+IjuDkyg8WP+ch7YUb7aAoWKmFIGwtywwyKeRjujdKmvgZ
         3rZJwErprZlz5CdkU047rAZLZ3SkbYJzT+7jB2+ej/eeDf3ksgMCr3H6YxybH9VKFB0M
         HuVgAdoS3Z1bC2WO5EeV+jVWuCvN2dDmQWmhQwboZtVrJ9YOWGJs8J4HbNoQQZV3qyE6
         kn9w==
X-Gm-Message-State: AOAM530t1/AP6i8GTSMS14eNO2zCBnQlJNvplj5XthJwVmw3JMBvP2MV
        dfVLaVBmF8caXk5eFUIKD5p1NQ==
X-Google-Smtp-Source: ABdhPJwfpfyghfmT/Ru4dywPKebiyk1pC42NUyPTKH7Ad7iGmSNe6CUYVTXcosUzU4cQj9KWOzUFPg==
X-Received: by 2002:a17:902:8604:b029:e2:a249:4474 with SMTP id f4-20020a1709028604b02900e2a2494474mr651325plo.15.1612468232240;
        Thu, 04 Feb 2021 11:50:32 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w13sm7059295pfc.7.2021.02.04.11.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 11:50:31 -0800 (PST)
Date:   Thu, 4 Feb 2021 11:50:30 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH v19 7/7] x86/vdso: Insert endbr32/endbr64 to vDSO
Message-ID: <202102041150.20388FEF25@keescook>
References: <20210203225902.479-1-yu-cheng.yu@intel.com>
 <20210203225902.479-8-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203225902.479-8-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 03, 2021 at 02:59:02PM -0800, Yu-cheng Yu wrote:
> From: "H.J. Lu" <hjl.tools@gmail.com>
> 
> When Indirect Branch Tracking (IBT) is enabled, vDSO functions may be
> called indirectly, and must have ENDBR32 or ENDBR64 as the first
> instruction.  The compiler must support -fcf-protection=branch so that it
> can be used to compile vDSO.
> 
> Signed-off-by: H.J. Lu <hjl.tools@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
