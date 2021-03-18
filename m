Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296253409CC
	for <lists+linux-arch@lfdr.de>; Thu, 18 Mar 2021 17:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhCRQNW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Mar 2021 12:13:22 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36602 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231806AbhCRQNA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Mar 2021 12:13:00 -0400
Received: from zn.tnic (p200300ec2f0fad00070f6d4b275c681b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:ad00:70f:6d4b:275c:681b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6FF7E1EC0591;
        Thu, 18 Mar 2021 17:12:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1616083978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iYAk+sBJZsOFN0LDj0WLxWQznRPOAKXobgPMm4BR1jY=;
        b=iZU645W5+QzgvAjHSsEnafuzbLMH+MFR6eKTL53NMcfWNWWCuVIioJi0L2FcA2BLpKT06m
        gJ/GltvmLMHhfRDWQB3kSksfu1SSX1G6ndpxcKb9xM3QyQvZNQNP9TmzLtd/IW6rREqyu3
        P+M28m7Fx9Fzv71SMDm+OIAzp4gn0J4=
Date:   Thu, 18 Mar 2021 17:13:01 +0100
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
        Haitao Huang <haitao.huang@intel.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v23 21/28] mm: Re-introduce vm_flags to do_mmap()
Message-ID: <20210318161301.GG19570@zn.tnic>
References: <20210316151054.5405-1-yu-cheng.yu@intel.com>
 <20210316151054.5405-22-yu-cheng.yu@intel.com>
 <20210318114232.GD19570@zn.tnic>
 <af1f109b-c36e-b548-ae15-752f7af7c1d4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <af1f109b-c36e-b548-ae15-752f7af7c1d4@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 18, 2021 at 08:59:28AM -0700, Yu, Yu-cheng wrote:
> Right, do_mmap_pgoff() was removed by commit 45e55300f114.  This patch does
> not add back the wrapper.  Instead, add vm_flags to do_mmap(). Please advice
> if I misunderstand the question.

I'm just wondering why you even need to mention do_mmap_pgoff() since
that thing is gone now...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
