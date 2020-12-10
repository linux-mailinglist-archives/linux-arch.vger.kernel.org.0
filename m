Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C662D63E3
	for <lists+linux-arch@lfdr.de>; Thu, 10 Dec 2020 18:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392873AbgLJRmr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Dec 2020 12:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391065AbgLJRmm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Dec 2020 12:42:42 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FECAC0613CF;
        Thu, 10 Dec 2020 09:42:02 -0800 (PST)
Received: from zn.tnic (p200300ec2f0d4100e4701ee3c8ed8bc5.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:4100:e470:1ee3:c8ed:8bc5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 125411EC054C;
        Thu, 10 Dec 2020 18:42:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607622121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DMxIl+sUswXky4hhx8cQNgi4k4soKTP3TjDz/GFCjaw=;
        b=iNEHVi15kmRdMHYS4OMEd1JmZaUshnKRI5nbl3emQfzm4SnYizyFXY93PnbbSOvoLSYBQV
        tWyfO3QpKd1baUIDBU1XePAbFK9WwLEWIw0dkN8xvaUtOrrcF5wgzsX1knpxXSRHRO79Ws
        Ef3HwocPJpikX283wWeE1yYoYmvMiHQ=
Date:   Thu, 10 Dec 2020 18:41:55 +0100
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
Subject: Re: [PATCH v15 08/26] x86/mm: Introduce _PAGE_COW
Message-ID: <20201210174155.GD26529@zn.tnic>
References: <20201110162211.9207-1-yu-cheng.yu@intel.com>
 <20201110162211.9207-9-yu-cheng.yu@intel.com>
 <20201208175014.GD27920@zn.tnic>
 <218503f6-eec1-94b0-8404-6f92c55799e3@intel.com>
 <20201208184727.GF27920@zn.tnic>
 <cddc2cc5-a04e-ce9c-6fdf-2e7a29346cf7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cddc2cc5-a04e-ce9c-6fdf-2e7a29346cf7@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 08, 2020 at 11:24:16AM -0800, Yu, Yu-cheng wrote:
> Case (a) is a normal writable data page that has gone through fork(). So it

Writable?

> has W=0, D=1.  But here, the software chooses not to use the D bit, and

But it has W=0. So not writable?

> instead, W=0, COW=1.

So the "new" way of denoting that the page is modified is COW=1
*when* on CET hw. The D=1 bit is still used on the rest thus the two
_PAGE_DIRTY_BITS.

Am I close?

> Case (b) is a normal read-only data page.  Since it is read-only, fork()
> won't affect it.  In __get_user_pages(), a copy of the read-only page is
> needed, and the page is duplicated.  The software sets COW=1 for the new
> copy.

That makes more sense.

> Thread-A is writing to a writable page, and the page's PTE is becoming W=1,
> D=1.  In the middle of it, Thread-B is changing the PTE to W=0.

Yah, add that to the explanation pls.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
