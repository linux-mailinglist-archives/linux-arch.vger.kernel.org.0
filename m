Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B9C37A5DA
	for <lists+linux-arch@lfdr.de>; Tue, 11 May 2021 13:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbhEKLgp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 May 2021 07:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbhEKLgp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 May 2021 07:36:45 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD804C06175F
        for <linux-arch@vger.kernel.org>; Tue, 11 May 2021 04:35:38 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id h4so28210752lfv.0
        for <linux-arch@vger.kernel.org>; Tue, 11 May 2021 04:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Le0Ew1Hg9KvgF6la0IVI4c8P/UYPK3oIC8S0v1P/CXY=;
        b=UV4F7xsUhFUHbA1Rt4aUC+TkWj2LsXA90mQqrzmQetnGSqhTWOhlHIdRmNkriRRdHG
         En11f5rwNkzEopt/p81S0ZLB7JqTWk3Sg+oDmy7bKDWwpRgIuABxB4hVFpzKq5lQkyQO
         lzWzvMvCcV+3cC+u3Af/IXNj83qwkghjYLpXRnB67s4FXmUFZz1q4RcJM5RuHFudut0n
         QKcimK7Iulxv3/gPkMwastZrAozSuyOcanocRWiE2RJhRS2bA8TVetZRUglbLOjCv3JR
         nGZFENVvZKIrLb88wJVbs5XExg8wbyn5/YK+ESrw0NQAmJco0W2ZGHjhx4P9IUEH3cBv
         nLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Le0Ew1Hg9KvgF6la0IVI4c8P/UYPK3oIC8S0v1P/CXY=;
        b=YY43ki1KsdO0PRzYFKllgTZjUS1mrt4UuccKi5+iL/QdAmbZ6k8kWaW1uWzRArbzo/
         EDx2wWuyaNUID3cwRQkMUc9ohu1AAtKDlm2Z15z5LEWTy59NG6Ig3j12ShDM9mbDFvX+
         eWR/ARouhDbUw9jlAfEqP60XugLEpaBN7A2QSZP5KVeIc38kUQens9z17aOygUzKDyvL
         v1E+YLQnzs/kyngpXptBYLzwrbmjVIhORYL/uDCOhDGkNAttOwWl307LYmcVNf9GrF/Q
         9ZRnTwzEPdueKjJ66mphmm3DL5WHc9Soy6Xg8btYlD0fROxsdJWe/30Qx368LssRGgHL
         kuCA==
X-Gm-Message-State: AOAM531HrKS4w/J9UdjpcBBfXwL4CsN4JIXynNLnBVo314NNYWRpBXAw
        SlqfV7X9byFnFSvjx69r5tMcsQ==
X-Google-Smtp-Source: ABdhPJxDAf43hUbtVcN3je+p5bV1NnAEkVOyB91N3WfTapOVx8IiLDHDsJqmKf0Ko6pqzpOzMNntKA==
X-Received: by 2002:a05:6512:374b:: with SMTP id a11mr20151995lfs.377.1620732937423;
        Tue, 11 May 2021 04:35:37 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id u27sm2578687lfm.239.2021.05.11.04.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 04:35:36 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 0E4C5102615; Tue, 11 May 2021 14:35:37 +0300 (+03)
Date:   Tue, 11 May 2021 14:35:37 +0300
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
        Haitao Huang <haitao.huang@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v26 29/30] mm: Update arch_validate_flags() to test vma
 anonymous
Message-ID: <20210511113537.d2uqen4pyh6xx53o@box>
References: <20210427204315.24153-1-yu-cheng.yu@intel.com>
 <20210427204315.24153-30-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427204315.24153-30-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 27, 2021 at 01:43:14PM -0700, Yu-cheng Yu wrote:
> When newer VM flags are being created, such as VM_MTE, it becomes necessary
> for mmap/mprotect to verify if certain flags are being applied to an
> anonymous VMA.
> 
> To solve this, one approach is adding a VM flag to track that MAP_ANONYMOUS
> is specified [1], and then using the flag in arch_validate_flags().
> 
> Another approach is passing the VMA to arch_validate_flags(), and check
> vma_is_anonymous().
> 
> To prepare the introduction of PROT_SHADOW_STACK, which creates a shadow
> stack mapping and can be applied only to an anonymous VMA, update
> arch_validate_flags() to pass in the VMA.
> 
> [1] commit 9f3419315f3c ("arm64: mte: Add PROT_MTE support to mmap() and mprotect()"),
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
