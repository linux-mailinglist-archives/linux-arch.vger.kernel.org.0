Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C0828E83A
	for <lists+linux-arch@lfdr.de>; Wed, 14 Oct 2020 23:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgJNVMY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Oct 2020 17:12:24 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39550 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbgJNVMY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Oct 2020 17:12:24 -0400
Received: from zn.tnic (p200300ec2f0c4400e816bcc7a66b170f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:4400:e816:bcc7:a66b:170f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8FC491EC026E;
        Wed, 14 Oct 2020 23:12:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602709942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n2EEh9T4loDsc3k0fpJFPs2bQyJ8KCqgdH0vrYdkYXE=;
        b=ooooy8z0oo+7/MV/pYkQOKvxejlWueeJ5rMNIb/HNMCUdEQduuW3bPBVgB6pLLxFD+6Hto
        3FSyicn4jrjY2TBWpUhiB8bSYHLEvoWsdnovlPKO820Mi9JUKth3F/w+NXoa5HqXzsOSoM
        IRbWLoNUiHIkyE40VZUh1z7JVwbwwYQ=
Date:   Wed, 14 Oct 2020 23:12:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
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
Message-ID: <20201014211214.GD18196@zn.tnic>
References: <20201014195823.GC18196@zn.tnic>
 <22E29783-F1F5-43DA-B35F-D75FB247475D@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22E29783-F1F5-43DA-B35F-D75FB247475D@amacapital.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 14, 2020 at 02:07:30PM -0700, Andy Lutomirski wrote:
> I assume it’s for a little optimization of clearing more than one
> page per SFENCE.
>
> In any event, based on the benchmark data upthread, we only want to do
> NT clears when they’re rather large, so this shouldn’t be just an
> alternative. I assume this is because a page or two will fit in cache
> and, for most uses that allocate zeroed pages, we prefer cache-hot
> pages. When clearing 1G, on the other hand, cache-hot is impossible
> and we prefer the improved bandwidth and less cache trashing of NT
> clears.

Yeah, use case makes sense but people won't know what to use. At the
time I was experimenting with this crap, I remember Linus saying that
that selection should be made based on the size of the area cleared, so
users should not have to know the difference.

Which perhaps is the only sane use case I see for this.

> Perhaps SFENCE is so fast that this is a silly optimization, though,
> and we don’t lose anything measurable by SFENCEing once per page.

Yes, I'd like to see real use cases showing improvement from this, not
just microbenchmarks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
