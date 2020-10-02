Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3124280C37
	for <lists+linux-arch@lfdr.de>; Fri,  2 Oct 2020 04:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387498AbgJBCHB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Oct 2020 22:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733275AbgJBCHA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Oct 2020 22:07:00 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACC2C0613D0
        for <linux-arch@vger.kernel.org>; Thu,  1 Oct 2020 19:07:00 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id e23so367760vsk.2
        for <linux-arch@vger.kernel.org>; Thu, 01 Oct 2020 19:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vT94c58c5RJpPi7b9HKxloC1mNQH0vp26xTTILK9X5s=;
        b=SyWPxJQjF1pyN0tV9nljtIiQi7IAU4ykxGKYZ+Ngd0KIBmRApBv8Lys4YpoYU593S3
         R/81CTJRQli3fwWhMot/+N4MW2z9TutEevFLsPxdQT04VEDJf3EcDb7TxTqPw16raYmL
         O185M4iVi+3hsx1y5CvCknDPjkmzzw/9oxohxNKfqhyfWVgIu2chMpy4PROp5XBAYtfw
         FhfullWI5DsudxJwmWVhfm3K5WnYqpDGnYdwOeDSZPIpIYNezYXrtPq++798LoUDLvAf
         jsLd/mLSMkpNOeJC2ZXc4XqQD5T+2H2J74a1Im5Bjz83C+9BqVudzCgo4FUKJFYPsFIw
         L07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vT94c58c5RJpPi7b9HKxloC1mNQH0vp26xTTILK9X5s=;
        b=W8Z2QugCAwEzjOK0n1ll2b/bMU1DGqDYX9vkdCpLihhTl6H8OM13iVwXgh6aOqc1qx
         gd27xwODZl5sZN+fw2KcXySZgPWP3/YA1ii80ADfmfPxcPMN6dfQdgQnBB23rIom0a9D
         EMVG7cJ4Vy76Rx8pDeUS1ajbziTsUJwo0FV4EZloO40O+um8DfMdqk/lY/amxXY1yQpV
         rCz+7iTQTqTXzjc2tqu5usxh48EkZIgTiYtBKptxGI6oEKRoSQjP980p2eDV4HkMQv3T
         xBKta0XYA8RoBQGsnyhVsHf/mUN8PtZSleV2FJyFx3ig1lQ3DUPC/iRc4RM2RmDF1mau
         F3vQ==
X-Gm-Message-State: AOAM532IrVR2lGR+FW1O8e4YNvYqSvOHlzJKeG0aotPMnWEPhEPyfBFf
        g2MAQg5tIBBiNODr8Ruj0taJtpCFsqoIpiihcZo62w==
X-Google-Smtp-Source: ABdhPJxoSqWOWqkgye3JYdbsMetKDhjeqdmku/0TOcCNaVVCZlRIiJXTsWsPQC2qA8YecqG4ck2fb88Uv71SNqE97IM=
X-Received: by 2002:a67:e83:: with SMTP id 125mr124303vso.22.1601604419476;
 Thu, 01 Oct 2020 19:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200925145649.5438-1-yu-cheng.yu@intel.com> <20200925145649.5438-20-yu-cheng.yu@intel.com>
In-Reply-To: <20200925145649.5438-20-yu-cheng.yu@intel.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Thu, 1 Oct 2020 19:06:48 -0700
Message-ID: <CAMn1gO4cxSt8-8qVbAei0jPErTtARdsEY4js6Fi=kzozAuE3yQ@mail.gmail.com>
Subject: Re: [PATCH v13 19/26] mm: Re-introduce do_mmap_pgoff()
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 25, 2020 at 7:57 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> There was no more caller passing vm_flags to do_mmap(), and vm_flags was
> removed from the function's input by:
>
>     commit 45e55300f114 ("mm: remove unnecessary wrapper function do_mmap_pgoff()").
>
> There is a new user now.  Shadow stack allocation passes VM_SHSTK to
> do_mmap().  Re-introduce the vm_flags and do_mmap_pgoff().

I would prefer to change the callers to pass the additional 0 argument
instead of bringing the wrapper function back, but if we're going to
bring it back then we should fix the naming (both functions take a
pgoff argument, so the previous name do_mmap_pgoff() was just plain
confusing).

Peter
