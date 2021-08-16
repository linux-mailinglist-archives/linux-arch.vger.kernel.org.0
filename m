Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7AA3ED22B
	for <lists+linux-arch@lfdr.de>; Mon, 16 Aug 2021 12:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbhHPKnh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Aug 2021 06:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhHPKng (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Aug 2021 06:43:36 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81757C061764;
        Mon, 16 Aug 2021 03:43:05 -0700 (PDT)
Received: from zn.tnic (p200300ec2f08b5004455011f3e43b910.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:b500:4455:11f:3e43:b910])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 050AD1EC04FB;
        Mon, 16 Aug 2021 12:42:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629110579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KJr3PLH9kdh7sq6ftHE42Mk4Hk9JcVNuZWU5FfzNhng=;
        b=EdTJv86x/KgsZfUTho7nmU2tWDU7gWlJWwEPgv85zH6gBUrThHi9fC1iX5VEY4vmFQ3Wat
        4L7CZpxMtqUnumgeTAAvIdt+GZJGAVni8JOdP7ssdtvST2BWMH3jSXeGJW+5iIwTMEZB+b
        GdsXFMbpKbQbyECkWOQbzWkuxXgeI58=
Date:   Mon, 16 Aug 2021 12:43:34 +0200
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
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v28 09/32] x86/mm: Introduce _PAGE_COW
Message-ID: <YRpBVu7dCBjks71I@zn.tnic>
References: <20210722205219.7934-1-yu-cheng.yu@intel.com>
 <20210722205219.7934-10-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210722205219.7934-10-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 22, 2021 at 01:51:56PM -0700, Yu-cheng Yu wrote:
> @@ -153,13 +178,23 @@ static inline int pud_young(pud_t pud)
>  
>  static inline int pte_write(pte_t pte)
>  {
> -	return pte_flags(pte) & _PAGE_RW;
> +	/*
> +	 * Shadow stack pages are always writable - but not by normal
> +	 * instructions, and only by shadow stack operations.  Therefore,
> +	 * the W=0,D=1 test with pte_shstk().
> +	 */
> +	return (pte_flags(pte) & _PAGE_RW) || pte_shstk(pte);

Well, this is weird: if some kernel code queries a shstk page and this
here function says it is writable but then goes and tries to write into
it and that write fails, then it'll confuse the user.

IOW, from where I'm standing, that should be:

	return (pte_flags(pte) & _PAGE_RW) && !pte_shstk(pte);

as in, a writable page is one which has _PAGE_RW and it is *not* a
shadow stack page because latter is special and not really writable.

Hmmm?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
