Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E943934046B
	for <lists+linux-arch@lfdr.de>; Thu, 18 Mar 2021 12:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhCRLQm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Mar 2021 07:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbhCRLQL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Mar 2021 07:16:11 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D888C06174A;
        Thu, 18 Mar 2021 04:16:11 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0fad0050896a9c56ff90be.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:ad00:5089:6a9c:56ff:90be])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1F3F71EC058C;
        Thu, 18 Mar 2021 12:16:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1616066169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=d9ZitKvEvuE1VBzOzL/yhpYXdhJ71yl0vc6GsYkRX+E=;
        b=roCkwQgPBxlDfuGla7p4H1ykzB59WOAyMlwHeR+8g49vfBLZRs9AS3NMiHET4KpK14c7Nw
        RbZHmJDMY73sbg3x4h8hLQ6UKXGwXEEZwDU9JSBzVJ4CVno4imgRmnp4YDrilxbqR63Xa7
        7wIFLIXWVkkA3fzRO0t1X1E5TCg51H0=
Date:   Thu, 18 Mar 2021 12:16:12 +0100
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
Subject: Re: [PATCH v23 16/28] mm: Fixup places that call pte_mkwrite()
 directly
Message-ID: <20210318111612.GC19570@zn.tnic>
References: <20210316151054.5405-1-yu-cheng.yu@intel.com>
 <20210316151054.5405-17-yu-cheng.yu@intel.com>
 <20210318094740.GA19570@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210318094740.GA19570@zn.tnic>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 18, 2021 at 10:47:40AM +0100, Borislav Petkov wrote:
> As with the previous one, I guess this one needs a mm person ACK. I
> mean, it is pretty obvious but still...

And that needs to happen for all mm patches in here.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
