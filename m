Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E48130FE2E
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 21:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240007AbhBDUZA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 15:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240041AbhBDUYv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 15:24:51 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1E2C061794
        for <linux-arch@vger.kernel.org>; Thu,  4 Feb 2021 12:24:11 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id e9so2490758pjj.0
        for <linux-arch@vger.kernel.org>; Thu, 04 Feb 2021 12:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YiBh8kjoQsH+w1ie1OfB7U+mi5FxxL8KWnwrDiJ80SQ=;
        b=PPt+H4wqt1A6KWRSkPhPkxwMn/vw3TKT91vvsKmHebL+0nltYCjD9IrFeHTRAjQymj
         BUG3q3cW2DBZiH22qiC37rSeMW4mlApOQfqnOR82W1zU+j/au6dXILhqYy9A8+6Iv8qY
         bcd9AfXep4kZgB1Vmchd6yJteQKwVnKD37aR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YiBh8kjoQsH+w1ie1OfB7U+mi5FxxL8KWnwrDiJ80SQ=;
        b=SaHh20L3kwWZMDBbpLtC+I2c9DtCTEcLq74cfnGdH/aTWR1BxLd3r0G/6ZtqMNUBeH
         gW14+TuulD6J32xtkTbtP7DoIuFGm2aufPHzMNPhpbztBE6L9mHOY59r8sb51qnEhWJI
         PPMz5a2JB/f06HrpMh3obpSkbOFlt2P7Hgjf3rivkOn/SyQ5wvR0hkf7W4uv8hkU8+54
         aAkYTsA7kCO3qk3HcHlINYguzXnXeT+A3oJ+ytVh7nsvTPqyDWaqum8kHjPiqSKOwV3g
         aibXu0nGYqSve0qeOSD1/ueavSVmMFY31hlZwX+WD4EMVNAzawzZkvvj89KxKQ//DorE
         +5pQ==
X-Gm-Message-State: AOAM533476/fhO554+EqAKjp7+QUF//gyfdvdAFS4O406YvHFMt80jDi
        tb5QPSnc7y0qouiOqqlMl+ytpQ==
X-Google-Smtp-Source: ABdhPJw0Vm+wT2LUNwph4uBXmL08ISQPaD4Ai/QvO5oPqXHsNDkCcUZJ728ruOrlMF1dvvaBvhbAXQ==
X-Received: by 2002:a17:902:59dc:b029:e2:9e80:1537 with SMTP id d28-20020a17090259dcb02900e29e801537mr954553plj.66.1612470251540;
        Thu, 04 Feb 2021 12:24:11 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k11sm6241168pfc.22.2021.02.04.12.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 12:24:10 -0800 (PST)
Date:   Thu, 4 Feb 2021 12:24:09 -0800
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
Subject: Re: [PATCH v19 16/25] mm: Add guard pages around a shadow stack.
Message-ID: <202102041224.5D300A122B@keescook>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-17-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203225547.32221-17-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 03, 2021 at 02:55:38PM -0800, Yu-cheng Yu wrote:
> INCSSP(Q/D) increments shadow stack pointer and 'pops and discards' the
> first and the last elements in the range, effectively touches those memory
> areas.
> 
> The maximum moving distance by INCSSPQ is 255 * 8 = 2040 bytes and
> 255 * 4 = 1020 bytes by INCSSPD.  Both ranges are far from PAGE_SIZE.
> Thus, putting a gap page on both ends of a shadow stack prevents INCSSP,
> CALL, and RET from going beyond.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Yay guard pages! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
