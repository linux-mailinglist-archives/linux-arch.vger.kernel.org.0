Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB6B2F483A
	for <lists+linux-arch@lfdr.de>; Wed, 13 Jan 2021 11:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbhAMKE6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Jan 2021 05:04:58 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37676 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbhAMKE5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Jan 2021 05:04:57 -0500
Received: from zn.tnic (p200300ec2f0b5c00b2d62b1c55c494d5.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:5c00:b2d6:2b1c:55c4:94d5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 052ED1EC0373;
        Wed, 13 Jan 2021 11:04:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610532256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6Q836lvEI8WL7BDS9FwTyp3jQYCAq9tax7h39eSviyg=;
        b=QGhyTjv+8jrsJmW04auJ2WzRUI8x3z3h3Nxe1Iofsa5h9SNwPhWVcm/kTr2VofD+ot0uEi
        bR8WMYNsVxyzR9uzfEztPrm+Wzta+YIiesKnMhkrnCnIz5NiIFbiNmce9zipmTdW9b6nvc
        PUt9/J0L3nIz3b7JgjwDsvnXLiuuciE=
Date:   Wed, 13 Jan 2021 11:04:16 +0100
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
Subject: Re: [PATCH v17 04/26] x86/cpufeatures: Introduce X86_FEATURE_CET and
 setup functions
Message-ID: <20210113100416.GB16960@zn.tnic>
References: <20201229213053.16395-5-yu-cheng.yu@intel.com>
 <20210111230900.5916-1-yu-cheng.yu@intel.com>
 <20210112123854.GE13086@zn.tnic>
 <0b144668-a989-6bc7-0b0d-2195d2d73397@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0b144668-a989-6bc7-0b0d-2195d2d73397@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 12, 2021 at 03:02:06PM -0800, Yu, Yu-cheng wrote:
> Should I send an updated patch?  Thanks!

No, this is not how review works.

Usually, you send your patchset, wait a week or two to gather feedback,
incorporate that feedback or discuss/dispute it and you send your next
version. You should know the process by now...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
