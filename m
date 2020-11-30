Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773882C8C72
	for <lists+linux-arch@lfdr.de>; Mon, 30 Nov 2020 19:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388013AbgK3SPl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Nov 2020 13:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbgK3SPl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Nov 2020 13:15:41 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D534CC0613D4;
        Mon, 30 Nov 2020 10:15:00 -0800 (PST)
Received: from zn.tnic (p200300ec2f0c0400dc0f4426b730eaa1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:400:dc0f:4426:b730:eaa1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 382831EC0249;
        Mon, 30 Nov 2020 19:14:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606760099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DsIkyRDqsHAg65QslwmCp09JK5IjAEIZ6mx1FlBzzao=;
        b=cYDnN961MFrBT2jgiFz98Jd1x2JPsKSatoVYE6Ap3wX8nWbvd9+BnwaGXSppVat3ie+7Pi
        4M3BhZGFiVKezT3prSdk2+xQZivfw0GqWSQ6QMI/IL1S8vhW1jUqZE0+8bZfSt56qp4ZcU
        4ImngURjhKH93VTjAU3Fj/J8Y+wUYtw=
Date:   Mon, 30 Nov 2020 19:15:00 +0100
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
Subject: Re: [PATCH v15 05/26] x86/cet/shstk: Add Kconfig option for
 user-mode Shadow Stack
Message-ID: <20201130181500.GH6019@zn.tnic>
References: <20201110162211.9207-1-yu-cheng.yu@intel.com>
 <20201110162211.9207-6-yu-cheng.yu@intel.com>
 <20201127171012.GD13163@zn.tnic>
 <98e1b159-bf32-5c67-455b-f798023770ef@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <98e1b159-bf32-5c67-455b-f798023770ef@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Nov 28, 2020 at 08:23:59AM -0800, Yu, Yu-cheng wrote:
> We have X86_BRANCH_TRACKING_USER too.  My thought was, X86_CET means any of
> kernel/user shadow stack/ibt.

It is not about what it means - it is what you're going to use/need. You have
ifdeffery both with X86_CET and X86_SHADOW_STACK_USER.

This one

+#ifdef CONFIG_X86_SHADOW_STACK_USER
+#define DISABLE_SHSTK	0
+#else
+#define DISABLE_SHSTK	(1 << (X86_FEATURE_SHSTK & 31))
+#endif

for example, is clearly wrong and wants to be #ifdef CONFIG_X86_CET, for
example. Unless I'm missing something totally obvious.

In any case, you need to analyze what Kconfig defines the code will
need and to what they belong and add only the minimal subset needed.
Our Kconfig symbols space is already nuts so adding more needs to be
absolutely justified.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
