Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6FD12FF625
	for <lists+linux-arch@lfdr.de>; Thu, 21 Jan 2021 21:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbhAUUmE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Jan 2021 15:42:04 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48672 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbhAUUmB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 Jan 2021 15:42:01 -0500
Received: from zn.tnic (p200300ec2f157500fb5fde66f083fa9c.dip0.t-ipconnect.de [IPv6:2003:ec:2f15:7500:fb5f:de66:f083:fa9c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5DBEB1EC026D;
        Thu, 21 Jan 2021 21:41:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611261678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6wzwOhvBmSjSU2bMPkrqdBsoyczaTsVK0FjOw4Itbks=;
        b=P40vr2r0ywK6EjiClnHStP/a+gYoB8gULMgUma93Tz4K4DF/kykiyHsK0ccTCuBZ/Usj9v
        USFijhl/n+2TvBmcdHu+wQYPZyKbbMo3tkuBsQHdihbtmYgjeoSFlNKHcGh4K0TBxmhz2A
        y/TI7VTHBegmKLZD0IpL81KaKeuwB+Y=
Date:   Thu, 21 Jan 2021 21:41:13 +0100
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
Subject: Re: [PATCH v17 08/26] x86/mm: Introduce _PAGE_COW
Message-ID: <20210121204113.GG32060@zn.tnic>
References: <20201229213053.16395-1-yu-cheng.yu@intel.com>
 <20201229213053.16395-9-yu-cheng.yu@intel.com>
 <20210121184405.GE32060@zn.tnic>
 <b4d4bec7-504e-2443-4cf3-0801b179000f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b4d4bec7-504e-2443-4cf3-0801b179000f@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 21, 2021 at 12:16:23PM -0800, Yu, Yu-cheng wrote:
> It clears _PAGE_DIRTY and sets _PAGE_COW.  That is,
> 
> if (pte.pte & _PAGE_DIRTY) {
> 	pte.pte &= ~_PAGE_DIRTY;
> 	pte.pte |= _PAGE_COW;
> }
> 
> So, shifting makes resulting code more efficient.

Efficient for what? Is this a hot path?

If not, I'd take readable code any day of the week.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
