Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A0D3404DB
	for <lists+linux-arch@lfdr.de>; Thu, 18 Mar 2021 12:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhCRLmg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Mar 2021 07:42:36 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46746 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229745AbhCRLmf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Mar 2021 07:42:35 -0400
Received: from zn.tnic (p200300ec2f0fad0050896a9c56ff90be.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:ad00:5089:6a9c:56ff:90be])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DD2AB1EC058C;
        Thu, 18 Mar 2021 12:42:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1616067754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=juGypyyvGVDiN/c+F2eQhiED/jKNk5rEPOGLa5dTkZg=;
        b=GSopJWzga1p24chp7vKmIUmQlxYwu4JXl5KVf/B6/arMqYxmzfpTXjIvrTVjewYPeR8Tep
        2VO0f/ufVW3LldqKevgvUWMuUVzm55jKJyycpYjG2WIgJUtPzhy7VxHVzJShTCplr9+6gv
        A8vEtcFgbBT6hPk1mkrv3T5t4CF2JGE=
Date:   Thu, 18 Mar 2021 12:42:32 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
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
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v23 21/28] mm: Re-introduce vm_flags to do_mmap()
Message-ID: <20210318114232.GD19570@zn.tnic>
References: <20210316151054.5405-1-yu-cheng.yu@intel.com>
 <20210316151054.5405-22-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210316151054.5405-22-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 16, 2021 at 08:10:47AM -0700, Yu-cheng Yu wrote:
> There was no more caller passing vm_flags to do_mmap(), and vm_flags was
> removed from the function's input by:
> 
>     commit 45e55300f114 ("mm: remove unnecessary wrapper function do_mmap_pgoff()").
> 
> There is a new user now.  Shadow stack allocation passes VM_SHSTK to
> do_mmap().  Re-introduce vm_flags to do_mmap(), but without the old wrapper
> do_mmap_pgoff().

Why does this matter at all?

$ git grep do_mmap_pgoff
$

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
