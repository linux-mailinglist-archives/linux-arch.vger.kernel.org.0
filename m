Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C764F36E03A
	for <lists+linux-arch@lfdr.de>; Wed, 28 Apr 2021 22:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240999AbhD1UaJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Apr 2021 16:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240942AbhD1UaI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Apr 2021 16:30:08 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34176C06138D
        for <linux-arch@vger.kernel.org>; Wed, 28 Apr 2021 13:29:23 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id gc22-20020a17090b3116b02901558435aec1so6023182pjb.4
        for <linux-arch@vger.kernel.org>; Wed, 28 Apr 2021 13:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UeII31CqNuFlE2BoTtr+fZN9wyzsy3hprcPYll4covw=;
        b=jylj96Rw3QUQm4doFDBK0kop0iQgCV6NfySkOr5T98cqbEgl0duruUVIG5KC7g1OvD
         XbTL/oRiSQ9ur3CZJRvyYbHIxY99dg3xegs4Ok2C8JzBM74t3TX7EC/VLwhZfoPz+u4/
         RcByLq8jJDIgsj0tknp3coppc77n13njbPFO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UeII31CqNuFlE2BoTtr+fZN9wyzsy3hprcPYll4covw=;
        b=XNctRVP0TT53CPJ5fyba+BPWIfSolLNajCetLiGn0To0TeoG/UaJ3+C+2AWPMoM6UY
         /Uv2NDytVxp+QMYrOhG5XMKKmT3FY8N/qEx1/0XQXBNNtBzT/kQ+h24Y1TuZKMGOSf5y
         1SSnzA5NV4kmv/6AsEUMxrB8jtSxnBPPOG1hh2zUPRad6HCiXAgQ+W+OJClAY1QbNqDJ
         gR3m2yLT4bJ7GxOyrq+9kJyEiYrqywwDmiLb4SknO26gwMu1iz1iuFpFt1DccnzT+CdU
         KMufUBKKKGmwmltrTPqm3ot35gyzRbc10SE3EdsKCXPj3QS32WO+7LoU1ULTrolclKHo
         zv1g==
X-Gm-Message-State: AOAM530Nc6yNWSB3kJwnhofh5hYhD8JkewmQQgGcFQW2jl9AkxU/Lqiz
        nipVcTSAvfHvwok/Pj/bKdWb/Q==
X-Google-Smtp-Source: ABdhPJwYkEDNlOuREptaQ5l3kQMV3gSjH3e1SrIdJIlzfjRSlDOr3aN5Uamkiddf+M4fmetyZadajQ==
X-Received: by 2002:a17:90a:8c8c:: with SMTP id b12mr36346748pjo.35.1619641762540;
        Wed, 28 Apr 2021 13:29:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k15sm516116pfi.0.2021.04.28.13.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 13:29:21 -0700 (PDT)
Date:   Wed, 28 Apr 2021 13:29:20 -0700
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
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: [PATCH v26 1/9] x86/cet/ibt: Add Kconfig option for Indirect
 Branch Tracking
Message-ID: <202104281329.564AACB@keescook>
References: <20210427204720.25007-1-yu-cheng.yu@intel.com>
 <20210427204720.25007-2-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427204720.25007-2-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 27, 2021 at 01:47:12PM -0700, Yu-cheng Yu wrote:
> Indirect Branch Tracking (IBT) provides protection against CALL-/JMP-
> oriented programming attacks.  It is active when the kernel has this
> feature enabled, and the processor and the application support it.
> When this feature is enabled, legacy non-IBT applications continue to
> work, but without IBT protection.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
