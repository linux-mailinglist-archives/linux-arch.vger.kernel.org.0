Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636D13EF453
	for <lists+linux-arch@lfdr.de>; Tue, 17 Aug 2021 23:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbhHQVBT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Aug 2021 17:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhHQVBT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 17 Aug 2021 17:01:19 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F79C061764;
        Tue, 17 Aug 2021 14:00:45 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1175002d6ed1db7aad8219.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:7500:2d6e:d1db:7aad:8219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ECBC61EC054F;
        Tue, 17 Aug 2021 23:00:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629234040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mXsfggRjwQDlm0H7Ke4Yg4s+PjvD0gM8YpelP0TsXHU=;
        b=h50TDWS4H9GdDodATzIk47AkyXvA4xxH+tNY8zodUJbiv66vz2uFecq8W13pkePmohzcG+
        9bTxxFbcNJNR6KjEBv4mabKrZU3gRqlEIj14TxD1Hrp0arnMYTBjLNHIqwAoViz5K4MhkU
        9jeBsoXMtMB5jcgWi4P1gXtqA77We3I=
Date:   Tue, 17 Aug 2021 23:01:18 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "luto@amacapital.net" <luto@amacapital.net>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v28 09/32] x86/mm: Introduce _PAGE_COW
Message-ID: <YRwjnmT9O8jYmL/9@zn.tnic>
References: <YRwT7XX36fQ2GWXn@zn.tnic>
 <1A27F5DF-477B-45B7-AD33-CC68D9B7CB89@amacapital.net>
 <YRwbD1hCYFXlYysI@zn.tnic>
 <490345b6-3e3d-4692-8162-85dcb71434c9@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <490345b6-3e3d-4692-8162-85dcb71434c9@www.fastmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 17, 2021 at 01:51:52PM -0700, Andy Lutomirski wrote:
> WRSS can be used from user mode depending on the configuration.

My point being, if you're going to do shadow stack management
operations, you should check whether the target you're writing to is a
shadow stack page. Clearly userspace can't do that but userspace will
get notified of that pretty timely.

> Double-you shmouble-you. You can't write it with MOV, but you can
> write it from user code and from kernel code. As far as the mm is
> concerned, I think it should be considered writable.

Because?

> Although... anyone who tries to copy_to_user() it is going to be a bit
> surprised. Hmm.

Ok, so you see the confusion.

In any case, I don't think you can simply look at a shadow stack page as
simple writable page. There are cases where it is going to be fun.

So why are we even saying that a shadow stack page is writable? Why
can't we simply say that a shadow stack page is, well, something
special?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
