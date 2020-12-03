Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3012CD261
	for <lists+linux-arch@lfdr.de>; Thu,  3 Dec 2020 10:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgLCJTz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Dec 2020 04:19:55 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40994 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbgLCJTz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 3 Dec 2020 04:19:55 -0500
Received: from zn.tnic (p200300ec2f0dc500e3882204d739572d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:c500:e388:2204:d739:572d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E21EE1EC0445;
        Thu,  3 Dec 2020 10:19:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606987154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Wwv5G443TsDdbXBzoiZmkw5jQa4JBgiUS1Z73lJ+AgU=;
        b=cxiF//WXSd6Th8WQd2lMn4NUaCvLTtCeFfbHmK2GQibJsZUFu6rkvjwRcfRxwgFzeXKu3D
        +msowrzH4sfz20eFGyxBUnUYYPpLi7FxmZjsF/5WEHrzwIWSc8g9FMcOPULuldGQ1aWdhs
        4UHAwqLZgyjEBFupmE8noZH3G8oLr/s=
Date:   Thu, 3 Dec 2020 10:19:10 +0100
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
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v15 06/26] x86/mm: Change _PAGE_DIRTY to _PAGE_DIRTY_HW
Message-ID: <20201203091910.GE3059@zn.tnic>
References: <20201110162211.9207-1-yu-cheng.yu@intel.com>
 <20201110162211.9207-7-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201110162211.9207-7-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 10, 2020 at 08:21:51AM -0800, Yu-cheng Yu wrote:
> Before introducing _PAGE_COW for non-hardware memory management purposes in
> the next patch, rename _PAGE_DIRTY to _PAGE_DIRTY_HW and _PAGE_BIT_DIRTY to
> _PAGE_BIT_DIRTY_HW to make meanings more clear.  There are no functional
> changes from this patch.

There's no guarantee for "next" or "this" patch when a patch gets
applied so reword your commit message pls.

Also, I fail to understand here what _PAGE_DIRTY_HW makes more clear?
The page dirty bit is clear enough to me so why the churn?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
