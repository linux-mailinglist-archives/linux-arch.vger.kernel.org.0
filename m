Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162E028E793
	for <lists+linux-arch@lfdr.de>; Wed, 14 Oct 2020 21:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgJNT62 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Oct 2020 15:58:28 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57504 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgJNT61 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Oct 2020 15:58:27 -0400
Received: from zn.tnic (p200300ec2f0c4400a8a63b86eef17592.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:4400:a8a6:3b86:eef1:7592])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7DFFB1EC0493;
        Wed, 14 Oct 2020 21:58:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602705506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uVK0IVgQlEoTLJbQHod8IqvQSLETuGNRNz6XABf3VLk=;
        b=dZ4P2/ENBkzVR3E/jykivRdYFeSM0709RXOdeXsygIC/ruApxwjwwpAWUzsPzZSJZhIjNS
        GP7PCo1zI76n/GfLb4/0Hxtw/LYFXH/rk2j/4DIQDCf2Whxo1qupCW5EGY9cuPx/lHxkVw
        VO9yU79WqRRJVimHtXFamo/IqyNJbn4=
Date:   Wed, 14 Oct 2020 21:58:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 5/8] x86/clear_page: add clear_page_uncached()
Message-ID: <20201014195823.GC18196@zn.tnic>
References: <20201014083300.19077-1-ankur.a.arora@oracle.com>
 <20201014083300.19077-6-ankur.a.arora@oracle.com>
 <CALCETrVKLv5DPByFcj7E5SBbv4mFt7mGQ9j-HU7G5u_aPGCYsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrVKLv5DPByFcj7E5SBbv4mFt7mGQ9j-HU7G5u_aPGCYsQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 14, 2020 at 08:45:37AM -0700, Andy Lutomirski wrote:
> On Wed, Oct 14, 2020 at 1:33 AM Ankur Arora <ankur.a.arora@oracle.com> wrote:
> >
> > Define clear_page_uncached() as an alternative_call() to clear_page_nt()
> > if the CPU sets X86_FEATURE_NT_GOOD and fallback to clear_page() if it
> > doesn't.
> >
> > Similarly define clear_page_uncached_flush() which provides an SFENCE
> > if the CPU sets X86_FEATURE_NT_GOOD.
> 
> As long as you keep "NT" or "MOVNTI" in the names and keep functions
> in arch/x86, I think it's reasonable to expect that callers understand
> that MOVNTI has bizarre memory ordering rules.  But once you give
> something a generic name like "clear_page_uncached" and stick it in
> generic code, I think the semantics should be more obvious.

Why does it have to be a separate call? Why isn't it behind the
clear_page() alternative machinery so that the proper function is
selected at boot? IOW, why does a user of clear_page functionality need
to know at all about an "uncached" variant?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
