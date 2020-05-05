Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0471C61AD
	for <lists+linux-arch@lfdr.de>; Tue,  5 May 2020 22:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbgEEUMJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 May 2020 16:12:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727785AbgEEUMJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 5 May 2020 16:12:09 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 619D920721;
        Tue,  5 May 2020 20:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588709528;
        bh=iCXbhk1z7F/kDs/nVraqaeYgCyIHXWPhAh8/VhmA1Xc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Pqbqjcp4PnFOmgqIDXj+8Bjl6/5/ohqBUkYxBuWzwlincpqWy3FQ0xkMGyVHwccvX
         WM2WCc/TBYfgYOWauIGtOhNuO3kK/yFKTFM/3sVIa4qR6GQIMPYaJ7YCqa0w6CoXwz
         sir6b1/N/Bs7N2CIGHNBpBp9fd/ysavQ6VdHSk/Y=
Date:   Tue, 5 May 2020 13:12:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm/hugetlb: Introduce
 HAVE_ARCH_CLEAR_HUGEPAGE_FLAGS
Message-Id: <20200505131206.bee7b103431bff077c2ca0cf@linux-foundation.org>
In-Reply-To: <21460cbc-8e9a-b956-5797-57b2e1df9fb1@arm.com>
References: <1586864670-21799-1-git-send-email-anshuman.khandual@arm.com>
        <1586864670-21799-4-git-send-email-anshuman.khandual@arm.com>
        <20200425175511.7a68efb5e2f4436fe0328c1d@linux-foundation.org>
        <87d37591-caa2-b82b-392a-3a29b2c7e9a6@arm.com>
        <20200425200124.20d0c75fcaef05d062d3667c@linux-foundation.org>
        <21460cbc-8e9a-b956-5797-57b2e1df9fb1@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 5 May 2020 08:21:34 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> >>> static inline void arch_clear_hugepage_flags(struct page *page)
> >>> {
> >>> 	<some implementation>
> >>> }
> >>> #define arch_clear_hugepage_flags arch_clear_hugepage_flags
> >>>
> >>> It's a small difference - mainly to avoid adding two variables to the
> >>> overall namespace where one would do.
> >>
> >> Understood, will change and resend.
> > 
> > That's OK - I've queued up that fix.
> >
> 
> Hello Andrew,
> 
> I might not have searched all the relevant trees or might have just searched
> earlier than required. But I dont see these patches (or your proposed fixes)
> either in mmotm (2020-04-29-23-04) or in next-20200504. Wondering if you are
> waiting on a V2 for this series accommodating the changes you had proposed.

hm.  I think I must have got confused and thought you were referring to
a different patch.  Yes please, let's have v2.
