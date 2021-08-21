Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2BE3F3B6A
	for <lists+linux-arch@lfdr.de>; Sat, 21 Aug 2021 18:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhHUQ1g (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 21 Aug 2021 12:27:36 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40166 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229571AbhHUQ1g (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 21 Aug 2021 12:27:36 -0400
Received: from zn.tnic (p200300ec2f24ae00bda189edbc359330.dip0.t-ipconnect.de [IPv6:2003:ec:2f24:ae00:bda1:89ed:bc35:9330])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 34D691EC0236;
        Sat, 21 Aug 2021 18:26:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629563211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0X9mARlIoI2YRPMAIxP7vYnoH77rVjJv4iOG9yPzbYo=;
        b=beFqjaCUR9g7x13v6kfDTVD7cJJ5lUQ02pYgQqgQQW+Dx4bC8R5jG/1T5ZRYq6EDDb5+xa
        bw0pZXorCmCVKLFYYdtk53S2JVodDz0MBX3kC+g2G6IQ6GLmr+H4J/r4sw2B7gBfwwqSDs
        rfWLAA2/wQdC4xwNfxLmtKRs7WN/+Sw=
Date:   Sat, 21 Aug 2021 18:27:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v28 09/32] x86/mm: Introduce _PAGE_COW
Message-ID: <YSEpcQG7WEa8hl9c@zn.tnic>
References: <YRwT7XX36fQ2GWXn@zn.tnic>
 <1A27F5DF-477B-45B7-AD33-CC68D9B7CB89@amacapital.net>
 <YRwbD1hCYFXlYysI@zn.tnic>
 <490345b6-3e3d-4692-8162-85dcb71434c9@www.fastmail.com>
 <YRwjnmT9O8jYmL/9@zn.tnic>
 <9a2b91ea-6a07-b7c8-24ac-3a15f62fbb7c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9a2b91ea-6a07-b7c8-24ac-3a15f62fbb7c@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 18, 2021 at 09:38:30AM -0700, Yu, Yu-cheng wrote:
> We can visualize the type of a mm area by looking at vma->vm_flags, e.g.

visualize?

> maybe_mkwrite(), and PTE macros as lower-level operatives.  These two have
> some relations but not one-to-one.  Note that a PTE in a writable area is
> not always pte_write().
> 
> I have considered and implemented a shadow stack PTE either pte_write() or
> not.  Making shadow stack as pte_write() results in less arch_* macros and
> less confusion in copy-on-write code.  That is one more thing to consider.

Ok, even though I'm still not 100% convinced by both amluto's and your
arguments. Let's try it and see what happens...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
