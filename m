Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE7E2D3357
	for <lists+linux-arch@lfdr.de>; Tue,  8 Dec 2020 21:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731394AbgLHUQN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Dec 2020 15:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731152AbgLHUPM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Dec 2020 15:15:12 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EECC0613D6;
        Tue,  8 Dec 2020 12:14:32 -0800 (PST)
Received: from zn.tnic (p200300ec2f0f08004da90e847a90bd48.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:800:4da9:e84:7a90:bd48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 433751EC053F;
        Tue,  8 Dec 2020 19:47:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607453247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=N7zLgo+iGnV/6dQc9oAjeLX3V0c+bnEUyOPpx3AqhUE=;
        b=qVpEjpAW6ERZtUChtOctB0atXOEQ9sLnL3RAG8ruZzpOCH41xOHx3EnwVn4iyhbQl9vBz4
        HI/Yk9gZwrTzU7nxtY7YhtvWO9Sj8BsNle4GW/6iHTq6qVmAR4dqc+EmS78ViFZXu7SFiJ
        JS2rHxlWADJXb4GziJW4KqDoA5cUXM0=
Date:   Tue, 8 Dec 2020 19:47:27 +0100
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
Message-ID: <20201208184727.GF27920@zn.tnic>
References: <20201110162211.9207-1-yu-cheng.yu@intel.com>
 <20201110162211.9207-9-yu-cheng.yu@intel.com>
 <20201208175014.GD27920@zn.tnic>
 <218503f6-eec1-94b0-8404-6f92c55799e3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <218503f6-eec1-94b0-8404-6f92c55799e3@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 08, 2020 at 10:25:15AM -0800, Yu, Yu-cheng wrote:
> > Both are "R/O + _PAGE_COW". Where's the difference? The dirty bit?
> 
> The PTEs are the same for both (a) and (b), but come from different routes.

Do not be afraid to go into detail and explain to me what those routes
are please.

> > > (e) A page where the processor observed a Write=1 PTE, started a write, set
> > >      Dirty=1, but then observed a Write=0 PTE.
> > 
> > How does that happen? Something changed the PTE's W bit to 0 in-between?
> 
> Yes.

Also do not scare from going into detail and explaining what you mean
here. Example?

> > Does _PAGE_COW mean dirty too?
> 
> Yes.  Basically [read-only & dirty] is created by software.  Now the
> software uses a different bit.

That convention:

"[read-only & dirty] is created by software."

needs some prominent writeup somewhere explaining what it is.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
