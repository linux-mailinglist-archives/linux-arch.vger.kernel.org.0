Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2E128F042
	for <lists+linux-arch@lfdr.de>; Thu, 15 Oct 2020 12:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731214AbgJOKfm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Oct 2020 06:35:42 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38596 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731220AbgJOKfl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Oct 2020 06:35:41 -0400
Received: from zn.tnic (p200300ec2f0ed200d49a97be428f152e.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:d200:d49a:97be:428f:152e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 354A01EC0284;
        Thu, 15 Oct 2020 12:35:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602758140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZVf1ic7c+5qbe1kvMGzYPhD6kZkQ1kdeKGnHwzIPNCc=;
        b=RJFNy71qR3kfFzJ/+npNj8Vfl7cv+0r5u0HfGOj9sXwbKguqx0tSx0YceHjqN0WDwQV7q6
        ygNW+Dl8zgGwJBV8aNLviF4VSjuWMLRlcF6dNDqDp448swLTKTuovTLJkp8xcX1/sIF3pI
        r02e6aA2ZuedpCXiSNBD1KPggr9SOtY=
Date:   Thu, 15 Oct 2020 12:35:35 +0200
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
Message-ID: <20201015103535.GC11838@zn.tnic>
References: <20201014195823.GC18196@zn.tnic>
 <22E29783-F1F5-43DA-B35F-D75FB247475D@amacapital.net>
 <20201014211214.GD18196@zn.tnic>
 <3de58840-1f4c-566b-3a66-46d57475820c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3de58840-1f4c-566b-3a66-46d57475820c@oracle.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 14, 2020 at 08:37:44PM -0700, Ankur Arora wrote:
> I don't disagree but I think the selection of cached/uncached route should
> be made where we have enough context available to be able to choose to do
> this.
>
> This could be for example, done in mm_populate() or gup where if say the
> extent is larger than LLC-size, it takes the uncached path.

Are there examples where we don't know the size?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
