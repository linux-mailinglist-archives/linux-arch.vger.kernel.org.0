Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B2233F4C5
	for <lists+linux-arch@lfdr.de>; Wed, 17 Mar 2021 16:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbhCQP4o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Mar 2021 11:56:44 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37704 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231878AbhCQP4Q (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 17 Mar 2021 11:56:16 -0400
Received: from zn.tnic (p200300ec2f094a000fa04028afd60743.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:4a00:fa0:4028:afd6:743])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9165B1EC056D;
        Wed, 17 Mar 2021 16:56:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1615996571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jKbFwAc3tzTE1JguNnjYbxfLAPfDUjYL9hlZmr/NLIY=;
        b=LzKzQSFwh9U2Yq/59xL+M9GfQEid0oY5SAwuAjSVqtWer0V2MII7mfaPgF0EsI2g0sJ6gv
        +Z97J++b/vmGzsGs5pL0DpeCT9X4bAPjmwFtbMdlOn/MKdXhTpwHa8GX1OsVrVesgCzXHG
        gkz0Ae20Iigp/0Szx2YiOTY+d2tPgvI=
Date:   Wed, 17 Mar 2021 16:56:08 +0100
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
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: [PATCH v23 15/28] x86/mm: Update maybe_mkwrite() for shadow stack
Message-ID: <20210317155608.GB25069@zn.tnic>
References: <20210316151054.5405-1-yu-cheng.yu@intel.com>
 <20210316151054.5405-16-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210316151054.5405-16-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 16, 2021 at 08:10:41AM -0700, Yu-cheng Yu wrote:
> When serving a page fault, maybe_mkwrite() makes a PTE writable if its vma
> has VM_WRITE.
> 
> A shadow stack vma has VM_SHSTK.  Its PTEs have _PAGE_DIRTY, but not
> _PAGE_WRITE.  In fork(), _PAGE_DIRTY is cleared to effect copy-on-write,

						  to cause

> and in page fault, _PAGE_DIRTY is restored and the shadow stack page is

      in the page fault handler...

> writable again.
> 
> Update maybe_mkwrite() by introducing arch_maybe_mkwrite(), which sets
> _PAGE_DIRTY for a shadow stack PTE.
> 
> Apply the same changes to maybe_pmd_mkwrite().
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/x86/Kconfig        |  4 ++++
>  arch/x86/mm/pgtable.c   | 18 ++++++++++++++++++
>  include/linux/mm.h      |  2 ++
>  include/linux/pgtable.h | 24 ++++++++++++++++++++++++
>  mm/huge_memory.c        |  2 ++
>  5 files changed, 50 insertions(+)

Looks straightforward to me but I guess it needs a mm person's ack.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
