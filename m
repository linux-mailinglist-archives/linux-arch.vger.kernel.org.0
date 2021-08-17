Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A60E3EF2EA
	for <lists+linux-arch@lfdr.de>; Tue, 17 Aug 2021 21:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229466AbhHQTyX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Aug 2021 15:54:23 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60408 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233658AbhHQTyW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Aug 2021 15:54:22 -0400
Received: from zn.tnic (p200300ec2f117500b0ae8110978caeec.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:7500:b0ae:8110:978c:aeec])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9B1A41EC030F;
        Tue, 17 Aug 2021 21:53:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629230022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=aIPbkILpcrd+GjwKNb2Ar1grIyTzLxIuzU20uQTvckM=;
        b=YQJb4Z7vHcSycsuDkROq8+S722knun6LHl0bmKH2CQr5g1k7r8t8LVNTPXyMCk9n3OuN/4
        edcppWeEwOk63eHEXk7sMxlSD4sqyIT6KK10prREwkg+OqHbMPuX16XGTwRXbGG459/Fz4
        RKyzTHY9Gs2iFZ/pb7nwiX2YUpf4ll0=
Date:   Tue, 17 Aug 2021 21:54:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
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
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v28 09/32] x86/mm: Introduce _PAGE_COW
Message-ID: <YRwT7XX36fQ2GWXn@zn.tnic>
References: <20210722205219.7934-1-yu-cheng.yu@intel.com>
 <20210722205219.7934-10-yu-cheng.yu@intel.com>
 <YRpBVu7dCBjks71I@zn.tnic>
 <59b9b98b-28e7-fc13-f13b-0079e184826f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <59b9b98b-28e7-fc13-f13b-0079e184826f@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 17, 2021 at 11:24:29AM -0700, Yu, Yu-cheng wrote:
> Indeed, this can be looked at in a few ways.  We can visualize pte_write()
> as 'CPU can write to it with MOV' or 'CPU can write to it with any opcodes'.
> Depending on whatever pte_write() is, copy-on-write code can be adjusted
> accordingly.

Can be?

I think you should exclude shadow stack pages from being writable
and treat them as read-only. How the CPU writes them is immaterial -
pte/pmd_write() is used by normal kernel code to query whether the page
is writable or not by any instruction - not by the CPU.

And since normal kernel code cannot write shadow stack pages, then for
that code those pages are read-only.

If special kernel code using shadow stack management insns needs
to modify a shadow stack, then it can check whether a page is
pte/pmd_shstk() but that code is special anyway.

Hell, a shadow stack page is (Write=0, Dirty=1) so calling it writable
			      ^^^^^^^
is simply wrong.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
