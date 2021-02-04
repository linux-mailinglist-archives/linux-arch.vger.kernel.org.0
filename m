Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDB230FDD8
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 21:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236985AbhBDTx7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 14:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238249AbhBDTvf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 14:51:35 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A9CC06178C
        for <linux-arch@vger.kernel.org>; Thu,  4 Feb 2021 11:50:06 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id y10so2322913plk.7
        for <linux-arch@vger.kernel.org>; Thu, 04 Feb 2021 11:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iBLMSCpzZcV26JDbm3Tk5TNwyOXOFPL+xJ3FCBgJOmc=;
        b=KyXxS/2xKJybcjPjmedT7sMpt9sCUlQgZi1EhPWosNSp79EUf68HPjqOdC8eSZP+6T
         79C8OvKn7CzmZWMokBs2i0HnigmaZ9loo+T7R5/Li0/H5ESiyaQDa7J6saI4f2qoPOZe
         FbJkQSX9K2yoM/hr85Q6/ePU+9uqQU8vk/iwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iBLMSCpzZcV26JDbm3Tk5TNwyOXOFPL+xJ3FCBgJOmc=;
        b=FjqlF3hChTpdQdboSbR2U7WZ8gVkPvCbzSOtNv4sxmnJnwRkMsrKMiUS/LW6+oF3K9
         ghKBNZ4cbgIop886U54uaaivMzu0XRZvoFslYkE6tLltObEjEOpByrXRsLSfgPYD9ByN
         2+SVUQOcK3RbPLU/VPqnG/rXalsN9u+cRM3LId9O+gtis+uTi/nPsC+uf0o8Tonx5lZe
         EJxelA5JX+5cuGoZArtm3JMDjmPCKeYuaFsve0nfPMamAEfK6z1rCyTvnJK1RotDdu54
         x9IQnn4B8anV9MCnZ914kbf8Cb0H7lQp3OzTL3ZWeLCxFxDCEUcNKWm1T/Z6xVnbBfWn
         QYOg==
X-Gm-Message-State: AOAM531XrMHt3Adm9GUlKpKoXBW/gZuxQog93W7giKOovLohR+/lpRPq
        leBZqZjc0kFe6mv5iH/FT6xLOA==
X-Google-Smtp-Source: ABdhPJxua1tNWSGKQMHDctfR/EJ5HVJZgKa0i2RmDdeE+oFlQXkcMFPwElJCu+Wj04jC5RzqPm8IZQ==
X-Received: by 2002:a17:90a:71c1:: with SMTP id m1mr592331pjs.48.1612468205972;
        Thu, 04 Feb 2021 11:50:05 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o4sm6029930pjs.57.2021.02.04.11.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 11:50:05 -0800 (PST)
Date:   Thu, 4 Feb 2021 11:50:03 -0800
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
Subject: Re: [PATCH v19 2/7] x86/cet/ibt: User-mode Indirect Branch Tracking
 support
Message-ID: <202102041150.1390D8B9@keescook>
References: <20210203225902.479-1-yu-cheng.yu@intel.com>
 <20210203225902.479-3-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203225902.479-3-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 03, 2021 at 02:58:57PM -0800, Yu-cheng Yu wrote:
> Introduce user-mode Indirect Branch Tracking (IBT) support.  Add routines
> for the setup/disable of IBT.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
