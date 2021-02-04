Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE62D30FD5D
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 20:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238594AbhBDTyE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 14:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239437AbhBDTvj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 14:51:39 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A72C06121C
        for <linux-arch@vger.kernel.org>; Thu,  4 Feb 2021 11:50:17 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id o16so2866915pgg.5
        for <linux-arch@vger.kernel.org>; Thu, 04 Feb 2021 11:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xVfkuBJxoMHahNTAuzjMVwQ5V275LoCHtWLRN4+qRmA=;
        b=SMhMJ0y1hFFkybLoK6RuX6W/uHtQZL/bYx1Vgct5XlRDHsQX7hEStJhU3muUb4fbEv
         hiUTrOqPhcz1pfUb97munHXmjX0c8gXGZ3hYDWbcMqclDY0sjxLOb8ku8yWr5/G0SoNh
         WUrWnsUWQvaHO1lagOpKt+BD5lQaiuCJGoC+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xVfkuBJxoMHahNTAuzjMVwQ5V275LoCHtWLRN4+qRmA=;
        b=a4s7vC4WDuYoDQExykKeJFh2vV/isueYLue2sy5C3tcH2ts1OjKj9BzSslB0gSRZI3
         kARW4f4YL+94/9fAbEhn82lNW9JTkjgx6oWdzFtHTfsJde5AXvKz5Ld6A1b9FFNU47W4
         /whQz70E/xwP8QtkSyO3zuzlG53OefRc2mAwXjB+OXGw3JSkppXwWApXDRgZpqdrpr89
         +SSLyT1RWBw3J3M+7E0aqFUhvpyHKxXDu/VYTvfGuxQc97oeuVJXsXcmfWcjnCxN/hm8
         IPJNZ6vaY8rE8QaaGVL57JFdQvVH7ycwhVjvwibzeFJATD/ucz7YFMaBXdoT5f6raKZ2
         3ZMQ==
X-Gm-Message-State: AOAM533pxWIOkNC1DahLgvcM2vwW4bEnwyD5ZtMB7mkJmigE4M3EWMl9
        XurZZw5tump6YfLGMo81WORu4w==
X-Google-Smtp-Source: ABdhPJzOajMVaIDiSuI0Zs6A72FQUA7Xr4U1otuUXAtASSA9xiRUczq+mdvc5mt1TaWo3NxHiyLjQw==
X-Received: by 2002:a62:7d03:0:b029:1bb:5919:6dec with SMTP id y3-20020a627d030000b02901bb59196decmr766097pfc.76.1612468217541;
        Thu, 04 Feb 2021 11:50:17 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y16sm7231723pfb.83.2021.02.04.11.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 11:50:16 -0800 (PST)
Date:   Thu, 4 Feb 2021 11:50:15 -0800
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
Subject: Re: [PATCH v19 4/7] x86/cet/ibt: Update ELF header parsing for
 Indirect Branch Tracking
Message-ID: <202102041150.191C2FC@keescook>
References: <20210203225902.479-1-yu-cheng.yu@intel.com>
 <20210203225902.479-5-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203225902.479-5-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 03, 2021 at 02:58:59PM -0800, Yu-cheng Yu wrote:
> An ELF file's .note.gnu.property indicates features the file supports.
> The property is parsed at loading time and passed to arch_setup_elf_
> property().  Update it for Indirect Branch Tracking.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
