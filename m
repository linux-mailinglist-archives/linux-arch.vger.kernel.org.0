Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26EF36E046
	for <lists+linux-arch@lfdr.de>; Wed, 28 Apr 2021 22:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241967AbhD1UbA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Apr 2021 16:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241927AbhD1Ua7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Apr 2021 16:30:59 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2103C06138B
        for <linux-arch@vger.kernel.org>; Wed, 28 Apr 2021 13:30:12 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id h14-20020a17090aea8eb02901553e1cc649so7541589pjz.0
        for <linux-arch@vger.kernel.org>; Wed, 28 Apr 2021 13:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P+vKZ+ijBuTYKlW4ksMgx+Vfg6fzuznEGR/mj5GiueA=;
        b=cjFidoHrwQOs6nvggZcyJHPrqy+fC3lyB+khjXw8XuHUFFpmXhDbTFYt4Z0pcBKzIu
         +pYRKW5ncOZPFtP4kJPVLZD6RWZVY/45yIeJMmu7wv3lRl6oGjQUu/+MiO4G0VaeNB52
         7LZlajzspTx8tLP+6aHqhBrlwyTRwrLFleo7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P+vKZ+ijBuTYKlW4ksMgx+Vfg6fzuznEGR/mj5GiueA=;
        b=H4eDbaUHCJS0z/oVR/ZC16X5A72yDn0qKdLntQnfvGO/7j6coV923btbrTSJY5sahZ
         0jV5fMUN9DlumudKIFQjCJhyXdXdu8jWF4R1DgcFlu+FzLR40yJ7r4Vs1jbvpvsUx7aZ
         9wJNt+2dPAUo2ouhSJ1QjdZoUGLnUr42HfEgoGaw6577LNj15EErzFF7Ecp8Y5kt8FcE
         hyCMRxMnEhK0zNgBYJwf9b307TqOTmtmVFsNUWtQBTWGRdgFrD6dkHANhJxa+2IlZtbo
         TF1KK0npYjoYqyVSDMFNoWSUmXUSFvCupuEoXCxEALzDcCfHi3OQkpbDAsYGhoBzJPz4
         QV7A==
X-Gm-Message-State: AOAM530Mk2dfWDTYsQfo2smm+Mkj96A1Vu259KAak80aKybu5UT0N3Yi
        NVEGVY+zF1zsmCa1mUuJzNZOXA==
X-Google-Smtp-Source: ABdhPJyBQNS6Zhg9r+1Ydyw6DrEvZh5KvBBtP08tgx1YOKud2zKIe07WgXGa7qTG+VtPhaq9gdPUog==
X-Received: by 2002:a17:902:8601:b029:e6:7b87:8add with SMTP id f1-20020a1709028601b02900e67b878addmr32266307plo.3.1619641812285;
        Wed, 28 Apr 2021 13:30:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i20sm318571pjz.48.2021.04.28.13.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 13:30:11 -0700 (PDT)
Date:   Wed, 28 Apr 2021 13:30:10 -0700
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
Subject: Re: [PATCH v26 2/9] x86/cet/ibt: Add user-mode Indirect Branch
 Tracking support
Message-ID: <202104281330.4269E2B@keescook>
References: <20210427204720.25007-1-yu-cheng.yu@intel.com>
 <20210427204720.25007-3-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427204720.25007-3-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 27, 2021 at 01:47:13PM -0700, Yu-cheng Yu wrote:
> Introduce user-mode Indirect Branch Tracking (IBT) support.  Add routines
> for the setup/disable of IBT.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
