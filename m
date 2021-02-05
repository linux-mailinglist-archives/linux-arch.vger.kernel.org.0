Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19DB310FE8
	for <lists+linux-arch@lfdr.de>; Fri,  5 Feb 2021 19:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbhBEQr1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Feb 2021 11:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbhBEQpN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Feb 2021 11:45:13 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAC7C061788
        for <linux-arch@vger.kernel.org>; Fri,  5 Feb 2021 10:26:55 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id x23so3379802pfn.6
        for <linux-arch@vger.kernel.org>; Fri, 05 Feb 2021 10:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9PTifcKN8spL3ClpqXcFGHeUFpoZ67atZiPMBU3wuDs=;
        b=HS3+D2H5qhhSXm5Mhv9pAeIQrIxIDrLLhrbubqDRQEHMzcshMMVXCtDGapcRO+w0Mh
         Ry8wZrTRSu5DzM6JkcjQdB4e+rwquqcyHdk4BllNxbt4vd8dhxxn1Gu3pKXPPcBOYGMW
         19euoavfkMowdIXaQ6HyNSFWSTVzj4YuS1o84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9PTifcKN8spL3ClpqXcFGHeUFpoZ67atZiPMBU3wuDs=;
        b=rUsJfarLtoE82KNyOn5zRxddwpsZeL/fuq/7AF9VzKN2F2PXQhWcIXHLMnUZtK/DFn
         7blKtuCZvC8Q4Q2CX4w8qT0XnpEbjNXP6+BkUdjh132y/tJhGAt8c0xbB1WUxBy+9YCU
         NGtdgoNySGdvcaVvhbBVrRs0WskBsUZeYo3y5NIbr0nMvHdQEvCWeMHbrM2T/AqdlChx
         7MAj4A92lxMvC6v8yIV416G9seCab+VnS1ICile6vM6VXVXPdWKK+TLmnGZyzyZKXPni
         N7GEEeT6G4QI6vdrZd2f5nhphm7ZSobTR/QASFKbTrS7MjnEXmZkQcBBPQQit0mxn0Y6
         2RCg==
X-Gm-Message-State: AOAM531R9aklLp60UWB/yePgifjkbY2e+67xE+Uj14sTY8xWiEMNNgkJ
        KGM7a20XMVXVlgRRIZnoWFY2AQ==
X-Google-Smtp-Source: ABdhPJyovoQ5m59St1KtJeobhPYp42OO5wY6rGeSKoIt1K/gK6R9dUzhVZK3/QwGz1Hw+E4zxyllEA==
X-Received: by 2002:a63:1c08:: with SMTP id c8mr5528896pgc.228.1612549614604;
        Fri, 05 Feb 2021 10:26:54 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m4sm3441246pfd.130.2021.02.05.10.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 10:26:53 -0800 (PST)
Date:   Fri, 5 Feb 2021 10:26:52 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
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
Subject: Re: [PATCH v19 24/25] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
Message-ID: <202102051026.B250352D4@keescook>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-25-yu-cheng.yu@intel.com>
 <202102041235.BA6C4982F@keescook>
 <6d7dd90f-dc03-06ce-57a2-57e4c2f803f3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d7dd90f-dc03-06ce-57a2-57e4c2f803f3@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 04, 2021 at 03:41:59PM -0800, Yu, Yu-cheng wrote:
> On 2/4/2021 12:35 PM, Kees Cook wrote:
> > On Wed, Feb 03, 2021 at 02:55:46PM -0800, Yu-cheng Yu wrote:
> > > arch_prctl(ARCH_X86_CET_STATUS, u64 *args)
> > >      Get CET feature status.
> > > 
> > >      The parameter 'args' is a pointer to a user buffer.  The kernel returns
> > >      the following information:
> > > 
> > >      *args = shadow stack/IBT status
> > >      *(args + 1) = shadow stack base address
> > >      *(args + 2) = shadow stack size
> > 
> > What happens if this needs to grow in the future? Should the first u64
> > contain the array size?
> > 
> > Otherwise, looks sensible.
> > 
> > -Kees
> > 
> 
> The first item is a bitmap, and there are two possible bits.  Should there
> be a need, we can then do things about it.  My thought at the moment is, we
> may not meet the situation.  Can we keep this for now?

Ah, good point. Yes, since that's a bitmap it ends up describing what
follows. This is fine as-is. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>


-- 
Kees Cook
