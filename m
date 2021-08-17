Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343683EF3F7
	for <lists+linux-arch@lfdr.de>; Tue, 17 Aug 2021 22:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbhHQUY5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Aug 2021 16:24:57 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36438 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237174AbhHQUYu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Aug 2021 16:24:50 -0400
Received: from zn.tnic (p200300ec2f117500b0ae8110978caeec.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:7500:b0ae:8110:978c:aeec])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AE11B1EC0556;
        Tue, 17 Aug 2021 22:24:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629231843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+yrW1YvDcJlPpXHuTQ1+89i5Y+U+96ERda2RQcSaGuw=;
        b=C1Bn0CPqvgGS5KpuudK22E1dJgTY5NTPkSI/Q5w0bDTkKQS0cynnWoc28EOwfoGfko1TrU
        us4DsxErEjkL3Gc0hHVcKYod7BmJDBUm0iGq5XjnZIed5vtQez3c/44kaZGK73NiO4Libs
        IYHHUABPOb4wMwNtsp9Lfvg7eUfxZtA=
Date:   Tue, 17 Aug 2021 22:24:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
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
Message-ID: <YRwbD1hCYFXlYysI@zn.tnic>
References: <YRwT7XX36fQ2GWXn@zn.tnic>
 <1A27F5DF-477B-45B7-AD33-CC68D9B7CB89@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1A27F5DF-477B-45B7-AD33-CC68D9B7CB89@amacapital.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 17, 2021 at 01:13:09PM -0700, Andy Lutomirski wrote:
> > If special kernel code using shadow stack management insns needs
> > to modify a shadow stack, then it can check whether a page is
> > pte/pmd_shstk() but that code is special anyway.
> > 
> > Hell, a shadow stack page is (Write=0, Dirty=1) so calling it writable
> >                  ^^^^^^^
> > is simply wrong.
> 
> But it *is* writable using WRUSS, and it’s also writable by CALL,

Well, if we have to be precise, CALL doesn't write it directly - it
causes for shadow stack to be written as part of CALL's execution. Yeah
yeah, potato potato.

> WRSS, etc.

Thus the "special kernel code" thing above. I've left it in instead of
snipping it.

> Now if the mm code tries to write protect it and expects sensible
> semantics, the results could be interesting. At the very least,
> someone would need to validate that RET reading a read only shadow
> stack page does the right thing.

Huh?

A shadow stack page is RO (W=0).

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
