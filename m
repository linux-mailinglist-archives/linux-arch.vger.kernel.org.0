Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205A3313D41
	for <lists+linux-arch@lfdr.de>; Mon,  8 Feb 2021 19:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbhBHSWK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Feb 2021 13:22:10 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42148 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233251AbhBHSVA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 8 Feb 2021 13:21:00 -0500
Received: from zn.tnic (p200300ec2f073f0023a6d1f14b392727.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:3f00:23a6:d1f1:4b39:2727])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7CAD61EC04D1;
        Mon,  8 Feb 2021 19:20:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612808412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qeF+mQeeKnzlVS28rZchr2a9Z1+kGh/ZuRWejrk4LHk=;
        b=RyHFSrVqG/V+VmsocywmZDdM4WcsK//kIh7Oaaiji5e3Gs2wJIJKSn8xv1kgJANIL1D8N1
        ShAAXcxGx5SBiCN96gwGM5AFDdhXJJVn/0/Jgmv2e0kDuGVm9DLVbGfgiK4fA2MNrngX7Z
        aB9OHNbXk/TJCLE6MbJLJELNmqpiNHw=
Date:   Mon, 8 Feb 2021 19:20:09 +0100
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
        Pengfei Xu <pengfei.xu@intel.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH v19 06/25] x86/cet: Add control-protection fault handler
Message-ID: <20210208182009.GE18227@zn.tnic>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-7-yu-cheng.yu@intel.com>
 <20210205135927.GH17488@zn.tnic>
 <2d829cba-784e-635a-e0c5-a7b334fa9b40@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2d829cba-784e-635a-e0c5-a7b334fa9b40@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 05, 2021 at 10:00:21AM -0800, Yu, Yu-cheng wrote:
> The ratelimit here is only for #CP, and its rate is not counted together
> with other types of faults.  If a task gets here, it will exit.  The only
> condition the ratelimit will trigger is when multiple tasks hit #CP at once,
> which is unlikely.  Are you suggesting that we do not need the ratelimit
> here?

I'm trying to first find out why is it there.

Is this something you've hit during testing and thought, oh well, this
needs a ratelimit or was it added just because?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
