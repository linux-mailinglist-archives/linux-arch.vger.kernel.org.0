Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67207343FE7
	for <lists+linux-arch@lfdr.de>; Mon, 22 Mar 2021 12:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhCVLdv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Mar 2021 07:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhCVLdj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Mar 2021 07:33:39 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A12FC061763
        for <linux-arch@vger.kernel.org>; Mon, 22 Mar 2021 04:33:39 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x28so20697710lfu.6
        for <linux-arch@vger.kernel.org>; Mon, 22 Mar 2021 04:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aC2zWxKh8h9yHiD2xeuwLXX1xV0ZgyBrKCIhHDY5H2o=;
        b=ZSGptlNY3TV6osXspfB6Yn0ZJO3GuxZfOL/Fu0isJaoYmVcMpPSQbVTSBn9c5mTSEA
         LTMelrPjHBm5crPLQkr9bPUQQYhynmbUipldWsBGQW2vnGJepKZ/QXFFhvUMRTACUhuw
         s9S/jbqIKXf2Vey3tdRYq6C15FpKTEc0pIR5uFfDmGz6QRdKhz9JMkd5bKgXenraMCQ8
         sX2QV60eMpa3rEE/iRF4PdvRdUdcorAtjcYY/ZdFAVPtSa0puiPKeYXNL3i5bwe+lcna
         occ6hoU7QY/zFYyxuEn9nExU2MqpMwJMmI6TKwxtodNgA0dSGLCyL8cyS3GfjnFdo4RS
         nMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aC2zWxKh8h9yHiD2xeuwLXX1xV0ZgyBrKCIhHDY5H2o=;
        b=MzZI5jjF/xy/hf0sLRD+BXk/L3UokWmGJPEuRnJH+2mnxkcDLhMudvQ72V33p8XtBU
         nFE34X/WPWSDvOdKN3oRwycUaRM/0pedDFUAPJTZAnlU78UjdL5Tl9WafXmnq0/w64bS
         XbgeUj4tg2z3UNFLfcUzY96IynxHqBeN27OkkGDju1rIrRtFyCfmXDJDtiE6QXu1+IQG
         PXgf0NO9VzSTDqQmxP4x9Mj7b34IaYtQZvn8uaSxTgyK02w2ftRFxRFKC7y2OI/d9JBA
         PX/6RoI5rN9byHZy20z8iZQvliPmfNBvg+eNEsuB3jC5yyBCVZSZYHf4CyKuJkE8VE5A
         vzmw==
X-Gm-Message-State: AOAM533J8/TkBM8Kx/haUZkuyqdJtIucPn5RWAyAZMDmAor2HwtKCgF7
        bsFiAlygafYY3UsayWJ3XFvikA==
X-Google-Smtp-Source: ABdhPJxMnipHkRpXAneqmErx/D3g0D2rkXq/Hs50ihFqlwye/4wxG9jeysmcs7uX5nhojYOuLACxOw==
X-Received: by 2002:a19:712:: with SMTP id 18mr8623697lfh.591.1616412817450;
        Mon, 22 Mar 2021 04:33:37 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w13sm1918639ljw.2.2021.03.22.04.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 04:33:36 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 5440A101DEB; Mon, 22 Mar 2021 14:33:44 +0300 (+03)
Date:   Mon, 22 Mar 2021 14:33:44 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
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
        Kees Cook <keescook@chromium.org>,
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
Subject: Re: [PATCH v23 13/28] mm: Introduce VM_SHSTK for shadow stack memory
Message-ID: <20210322113344.vf55cya7frr5hvoo@box>
References: <20210316151054.5405-1-yu-cheng.yu@intel.com>
 <20210316151054.5405-14-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316151054.5405-14-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 16, 2021 at 08:10:39AM -0700, Yu-cheng Yu wrote:
> +#ifdef CONFIG_X86_CET
> +# define VM_SHSTK	VM_HIGH_ARCH_5
> +#else
> +# define VM_SHSTK	VM_NONE
> +#endif
> +

Why not VM_SHADOW_STACK? Random reader may think SH stands for SHARED or
something.

-- 
 Kirill A. Shutemov
