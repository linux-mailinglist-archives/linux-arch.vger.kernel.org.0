Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FE33F9EA3
	for <lists+linux-arch@lfdr.de>; Fri, 27 Aug 2021 20:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhH0SVQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Aug 2021 14:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhH0SVP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Aug 2021 14:21:15 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FF6C061757;
        Fri, 27 Aug 2021 11:20:25 -0700 (PDT)
Received: from zn.tnic (p200300ec2f111700cf40790d4c46ba75.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:1700:cf40:790d:4c46:ba75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 580311EC0464;
        Fri, 27 Aug 2021 20:20:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630088420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZX+dUaso9hY7Jwyhm9+J+9xSIFkf/Ba913Jr6PxHR8M=;
        b=hxhN/9qaxv9CejLRWw/PIxqlAS/tScL1xrIYrKtj0tITUY//ZNg6TZHq5y6GLCwkNmGnkE
        ea7gb0qDI/2HlzvGLbqA8//rLOTvTBv+aGCGxfMwcbe6UrZnn/Srne1S5PpjyNBIjZoDrV
        Ii6Bm3VbSHJ/Qikkp8eaLIl1EwOJ1So=
Date:   Fri, 27 Aug 2021 20:21:02 +0200
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
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v29 23/32] x86/cet/shstk: Add user-mode shadow stack
 support
Message-ID: <YSktDrcJIAo9mQBV@zn.tnic>
References: <20210820181201.31490-1-yu-cheng.yu@intel.com>
 <20210820181201.31490-24-yu-cheng.yu@intel.com>
 <YSfAbaMxQegvmN2p@zn.tnic>
 <fa372ba8-7019-46d6-3520-03859e44cad9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fa372ba8-7019-46d6-3520-03859e44cad9@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 27, 2021 at 11:10:31AM -0700, Yu, Yu-cheng wrote:
> Because on context switches the whole xstates are switched together,
> we need to make sure all are in registers.

There's context switch code which does that already.

Why would shstk_setup() be responsible for switching the whole extended
states buffer instead of only the shadow stack stuff only?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
