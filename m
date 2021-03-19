Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B5A34183A
	for <lists+linux-arch@lfdr.de>; Fri, 19 Mar 2021 10:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhCSJ2N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Mar 2021 05:28:13 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51268 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhCSJ2J (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Mar 2021 05:28:09 -0400
Received: from zn.tnic (p200300ec2f091e00ccf0bdf306f8eebc.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:1e00:ccf0:bdf3:6f8:eebc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3FBE41EC0598;
        Fri, 19 Mar 2021 10:28:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1616146087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=x5iZs50qGLJl3wWJ6Z8Q/HzduN81imNbW0pU6JloYuo=;
        b=h9c+OWSFsKDiriwZ4T3n4NNMY19803vt4GuW/AcaffbPxaSNUfNucDuudBqw1YPqk5BYqz
        sVoCdpmAtrWjKbk7Y/cMI1PahAmEIY49jZAhreJVMI3B8oH1aWYVvsgzIewg+mmcuDlTV+
        3Sw5pKWCvU+z2Xj55irdKup90tXAYFU=
Date:   Fri, 19 Mar 2021 10:28:06 +0100
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
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: [PATCH v23 22/28] x86/cet/shstk: User-mode shadow stack support
Message-ID: <20210319092806.GB6251@zn.tnic>
References: <20210316151054.5405-1-yu-cheng.yu@intel.com>
 <20210316151054.5405-23-yu-cheng.yu@intel.com>
 <20210318123215.GE19570@zn.tnic>
 <b05ee7eb-1b5d-f84f-c8f3-bfe9426e8a7d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b05ee7eb-1b5d-f84f-c8f3-bfe9426e8a7d@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 18, 2021 at 12:05:58PM -0700, Yu, Yu-cheng wrote:
> Maybe I would add comments here.

Yap.

Also, looking forward in the set, I see prctl_set() and that is also
done on current so should be ok.

In any case, yes, documenting the assumptions and expectations wrt
current here is a good idea.

> If vm_munmap() returns -EINTR, mmap_lock is held by something else. That
> lock should not be held forever.  For other types of error, the loop stops.

Ok I guess. The subsequent WARN_ON_ONCE() looks weird too but that
should not fire, right? :)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
