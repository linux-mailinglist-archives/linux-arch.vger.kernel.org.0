Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872C02A9C14
	for <lists+linux-arch@lfdr.de>; Fri,  6 Nov 2020 19:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbgKFS2j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Nov 2020 13:28:39 -0500
Received: from mail.skyhub.de ([5.9.137.197]:35248 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgKFS2j (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Nov 2020 13:28:39 -0500
Received: from zn.tnic (p200300ec2f0d1f00570cf78b071a7fce.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1f00:570c:f78b:71a:7fce])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5C4761EC047F;
        Fri,  6 Nov 2020 19:28:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1604687317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0dCrt2bo7ao0s5Db0UkWo185mnioH6HrSSqToa1Rk6M=;
        b=lG3pAyYv3D6a7HejoZ42uGNv3kVm3K7AO9R6HBDUf1q8pZt1NZ6WVvn9v+YLfrvBNhajt/
        aA11jyMY4fpKmsov02L2BLVbc4aj2CSJK3kQ0L3b2GOJqCLqhOarPLqILco34A1hIquNmj
        V3FTCtID+3IDJpC0jPUOfvaKMcoCLXU=
Date:   Fri, 6 Nov 2020 19:28:22 +0100
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
Subject: Re: [PATCH v14 01/26] Documentation/x86: Add CET description
Message-ID: <20201106182822.GH14914@zn.tnic>
References: <20201012153850.26996-1-yu-cheng.yu@intel.com>
 <20201012153850.26996-2-yu-cheng.yu@intel.com>
 <20201106173410.GG14914@zn.tnic>
 <ebaff261-f8ad-d184-edd5-8efbd675deeb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ebaff261-f8ad-d184-edd5-8efbd675deeb@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 06, 2020 at 10:16:47AM -0800, Yu, Yu-cheng wrote:
> In the current shell, if GLIBC_TUNABLES variable is set as such,
> applications started will have CET features disabled.  I can put more
> details here, or maybe a reference to the GLIBC man pages.

Why do you keep repeating "the current shell"? You pass it with
setenv(3) too, can't you?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
