Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B098F387F20
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 19:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351341AbhERSAE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 14:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345799AbhERSAD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 May 2021 14:00:03 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4B2C061573;
        Tue, 18 May 2021 10:58:45 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ae2009fe1e516c71afc1c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:e200:9fe1:e516:c71a:fc1c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 95C221EC01FC;
        Tue, 18 May 2021 19:58:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1621360723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lYrYc/sDhQ8UivR+VcXmOLyHqj3bMiuASqw7cjE5B8M=;
        b=kE3yncmQkEk2XHVbvQL9S4NC32KK+jj+Fl0PYMMYE8G0kYExZoHA05jH4Ec1u4xQh42DVJ
        /PDQrNJrUjwflMJLWeG8oDZx1rrAv+9NAVmH0fphIxf1YyMY6xnNMzCdKt5kgt3lxj5pzh
        EOgqO07ZZOj8oFfimX/wdixvqNsyjf0=
Date:   Tue, 18 May 2021 19:58:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
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
Subject: Re: [PATCH v26 24/30] x86/cet/shstk: Introduce shadow stack token
 setup/verify routines
Message-ID: <YKQATkbU4DJ/nC3T@zn.tnic>
References: <20210427204315.24153-1-yu-cheng.yu@intel.com>
 <20210427204315.24153-25-yu-cheng.yu@intel.com>
 <YKIfIEyW+sR+bDCk@zn.tnic>
 <e225e357-a1d5-9596-8900-79e6b94cf924@intel.com>
 <20210518001316.GR15897@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210518001316.GR15897@asgard.redhat.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 18, 2021 at 02:14:14AM +0200, Eugene Syromiatnikov wrote:
> Speaking of which, I wonder what would happen if a 64-bit process makes
> a 32-bit system call (using int 0x80, for example), and gets a signal.

I guess that's the next patch. And I see amluto has some concerns...

/me goes read.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
