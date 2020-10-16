Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EADE290B3C
	for <lists+linux-arch@lfdr.de>; Fri, 16 Oct 2020 20:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391549AbgJPSVv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Oct 2020 14:21:51 -0400
Received: from mail.skyhub.de ([5.9.137.197]:32892 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391545AbgJPSVv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 16 Oct 2020 14:21:51 -0400
Received: from zn.tnic (p200300ec2f0d0d00cf555b949331184a.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:d00:cf55:5b94:9331:184a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 15C821EC0502;
        Fri, 16 Oct 2020 20:21:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602872510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YUQjk3PEP/Lxo9pK9C44oGWzEABQvzmK7tR90OE3q3A=;
        b=MfcdBprO82Gs6USW3t2uxtDnPe1JyUvB0k99HSBCcmVqvcLThIJkxEdkmwMpSfYDH5N1kP
        MrZXJ2BALq3J8u5gh7xlv9mJuZqSpLP0lRjVkOhhDoM60RM5sdUx68Y9dfuw+VRziFrW/J
        goMyW63H1+aGXJPvshIJoTJqgJoiyrI=
Date:   Fri, 16 Oct 2020 20:21:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
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
Message-ID: <20201016182140.GJ8483@zn.tnic>
References: <20201014195823.GC18196@zn.tnic>
 <22E29783-F1F5-43DA-B35F-D75FB247475D@amacapital.net>
 <20201014211214.GD18196@zn.tnic>
 <3de58840-1f4c-566b-3a66-46d57475820c@oracle.com>
 <20201015103535.GC11838@zn.tnic>
 <593f3b75-678c-1cd4-a7f0-55257dc84caf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <593f3b75-678c-1cd4-a7f0-55257dc84caf@oracle.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 15, 2020 at 02:20:36PM -0700, Ankur Arora wrote:
> The case I was thinking of was that clear_huge_page()

That loop in clear_gigantic_page() there could be optimized not to
iterate over the pages but do a NTA moves in one go, provided they're
contiguous.

> or faultin_page() would

faultin_page() goes into the bowels of mm fault handling, you'd have to
be more precise what exactly you mean with that one.

> know the size to a page unit, while the higher level function would know the
> whole extent and could optimize differently based on that.

Just don't forget that this "optimization" of yours comes at the price
of added code complexity and you're putting the onus on the people to
know which function to call. So it is not for free and needs to be
carefully weighed.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
