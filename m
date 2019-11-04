Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4152EDC06
	for <lists+linux-arch@lfdr.de>; Mon,  4 Nov 2019 11:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfKDKCf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Nov 2019 05:02:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:53892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbfKDKCf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Nov 2019 05:02:35 -0500
Received: from rapoport-lnx (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3768B217F4;
        Mon,  4 Nov 2019 10:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572861754;
        bh=RwuWoZThXjDNqHvn7aTTzoFOSaLFxJpu4JuE9FFAq2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZQXJDyCwPvvErBhc/JPFvqf0ahcZeThDhCNKls9A5hiFMXg7/bxxaR+FRMEZqomQo
         7UkvkxzVQJ8UmcmpblINg/P6vMg4z3dq8+ii2/Ci/olfoMvg0slJoe+lmMsP+7zPv5
         4p/WigolfFBvLYahqoidIrM5ZrPlGWpuHfVEwAZI=
Date:   Mon, 4 Nov 2019 12:02:22 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Jeff Dike <jdike@addtoit.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>, Peter Rosin <peda@axentia.se>,
        Richard Weinberger <richard@nod.at>,
        Rolf Eike Beer <eike-kernel@sf-tec.de>,
        Russell King <linux@armlinux.org.uk>,
        Sam Creasey <sammy@sammy.net>,
        Vincent Chen <deanbo422@gmail.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-um@lists.infradead.org,
        sparclinux <sparclinux@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v3 13/13] mm: remove __ARCH_HAS_4LEVEL_HACK and
 include/asm-generic/4level-fixup.h
Message-ID: <20191104100221.GC23288@rapoport-lnx>
References: <1572850587-20314-1-git-send-email-rppt@kernel.org>
 <1572850587-20314-14-git-send-email-rppt@kernel.org>
 <CAK8P3a3e7oG5NMPbhgQOoKvB0Z5ui0iAHHFqyAxy87Nd903Vmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3e7oG5NMPbhgQOoKvB0Z5ui0iAHHFqyAxy87Nd903Vmw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 04, 2019 at 10:11:51AM +0100, Arnd Bergmann wrote:
> On Mon, Nov 4, 2019 at 7:58 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > From: Mike Rapoport <rppt@linux.ibm.com>
> >
> > There are no architectures that use include/asm-generic/4level-fixup.h
> > therefore it can be removed along with __ARCH_HAS_4LEVEL_HACK define.
> >
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> 
> For asm-generic:
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Have you discussed how the series should get merged? I assume an initial
> set of patches can just go through architecture maintainer trees, but
> whatever patches don't get picked up that way would go through either
> Andrew's -mm tree (for memory management) or my asm-generic tree
> (for cross-architecture cleanups).

I thought that the entire set could go via -mm or asm-generic, but if
architecture maintainers would prefer to pick relevant patches to the arch
trees, I'll resend the rest afterwards.
 
> Since there is still at least one regression, I expect not to do anything
> for now. Please let me know when/if you expect me to merge the
> remaining patches.

Sure, thanks!

>       Arnd

-- 
Sincerely yours,
Mike.
