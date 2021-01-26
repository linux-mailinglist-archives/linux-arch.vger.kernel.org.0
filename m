Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29AA303D11
	for <lists+linux-arch@lfdr.de>; Tue, 26 Jan 2021 13:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391466AbhAZMfR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jan 2021 07:35:17 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37846 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403968AbhAZKY5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 Jan 2021 05:24:57 -0500
Received: from zn.tnic (p200300ec2f0d1100bcf83db545f09974.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1100:bcf8:3db5:45f0:9974])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CB2CF1EC04DE;
        Tue, 26 Jan 2021 11:24:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611656648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gmVhkBSNYh2tQM3hLJDqtgcOU5M+oLAy/Q1t/J7w2Gk=;
        b=FbU5kNmHpPusFNCpBVV5pBGxok6dOmS9QwJ6bVkKdPfT7PHs705uVSTLAyXV8gGzlJ8ux6
        gUOiHGr/iUmtLqd1K9d8Y+Nk80FL78ISu5YOtpOcY0Tc8Zmt0wPfsOsYp34A402Kxg9lZA
        GWVwADHhKN+WmOmtyVVFjcQe2CSNW4o=
Date:   Tue, 26 Jan 2021 11:24:04 +0100
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
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH v17 11/26] x86/mm: Update ptep_set_wrprotect() and
 pmdp_set_wrprotect() for transition from _PAGE_DIRTY to _PAGE_COW
Message-ID: <20210126102404.GA6514@zn.tnic>
References: <20201229213053.16395-1-yu-cheng.yu@intel.com>
 <20201229213053.16395-12-yu-cheng.yu@intel.com>
 <20210125182709.GC23290@zn.tnic>
 <8084836b-4990-90e8-5c9a-97a920f0239e@intel.com>
 <20210125215558.GK23070@zn.tnic>
 <c000e1fa-5da8-9316-ef9e-565d79308296@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c000e1fa-5da8-9316-ef9e-565d79308296@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 25, 2021 at 02:18:37PM -0800, Yu, Yu-cheng wrote:
> For example, when a thread reads a W=1, D=0 PTE and before changing it to
> W=0,D=0, another thread could have written to the page and the PTE is W=1,
> D=1 now.  When try_cmpxchg() detects the difference, old_pte is read again.

None of that is mentioned in the comment above it and if anything,
*that* is what should be explained there - not some guarantee about some
processors which doesn't even apply here.

Also, add the fact that try_cmpxchg() will update old_pte with any
modified bits - D=1 for example - when it fails. As Peter just explained
to me on IRC.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
