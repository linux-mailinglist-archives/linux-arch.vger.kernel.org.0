Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92EB2308EAE
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 21:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbhA2UrI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 15:47:08 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49618 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233283AbhA2Uqu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 29 Jan 2021 15:46:50 -0500
Received: from zn.tnic (p200300ec2f0c9a00329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 691531EC0430;
        Fri, 29 Jan 2021 21:46:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611953165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zSehSWcL9VybinDm7WII9GULh26hKSqIlgsL9Bvhs18=;
        b=JB568EAXEEM0A+43P+i+CDYgulgMshj/+/H0ermgIM6fBUYc07UwL5Zs6q0jMC750w0Yc/
        zI/lHHYVeTc25RsvGjZ4dn9nVAf/Ube4zuVvwJtBopH3bX9uPMp/zH1RD7FdoMcmaJcb65
        5puJv2axJ9yH67zksU8gQS8Ug0enlc8=
Date:   Fri, 29 Jan 2021 21:46:01 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
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
Subject: Re: [PATCH v18 02/25] x86/cet/shstk: Add Kconfig option for
 user-mode control-flow protection
Message-ID: <20210129204601.GG27841@zn.tnic>
References: <40a5a9b5-9c83-473d-5f62-a16ecde50f2a@intel.com>
 <86F8CE62-A94B-46BD-9A29-DBE1CC14AA83@amacapital.net>
 <58d5f029-ee8a-ca93-f0e6-0278db22e208@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <58d5f029-ee8a-ca93-f0e6-0278db22e208@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 29, 2021 at 12:33:43PM -0800, Dave Hansen wrote:
> In that case is there any reason to keep the "depends on CPU_SUP_INTEL"?

Probably not. I haven't heard of the AMD implementation being somehow
different from Intel's.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
