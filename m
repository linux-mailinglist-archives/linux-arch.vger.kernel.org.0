Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A164ECAA4
	for <lists+linux-arch@lfdr.de>; Fri,  1 Nov 2019 23:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfKAV7Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Nov 2019 17:59:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbfKAV7Y (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 1 Nov 2019 17:59:24 -0400
Received: from rapoport-lnx (190.228.71.37.rev.sfr.net [37.71.228.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6ED020679;
        Fri,  1 Nov 2019 21:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572645563;
        bh=QiZm9ub4TObxGGKcca2WTm6kN/XMUXB/j0wvSJ5M3eA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IHcZXPG5aOVX7THF5w1BhXuPpEAFbXmlm1YNYoLN1/wia+WcGzRCfkdX1Ruwcf8B0
         7VsDchfB2H1tc1VfaQdn38Nf40YHULbzg3WrgWUI8RNC8o7I6dxUJNNV8Ww/2Gbls9
         tJJ3TSp8O0lGrXdZetQvfatdTrJJjGLz2VuJU/Ck=
Date:   Fri, 1 Nov 2019 22:59:11 +0100
From:   Mike Rapoport <rppt@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jeff Dike <jdike@addtoit.com>,
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
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-parisc@vger.kernel.org, linux-um@lists.infradead.org,
        sparclinux@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v2 01/13] alpha: use pgtable-nop4d instead of 4level-fixup
Message-ID: <20191101215905.GB20065@rapoport-lnx>
References: <1572597584-6390-1-git-send-email-rppt@kernel.org>
 <1572597584-6390-2-git-send-email-rppt@kernel.org>
 <20191101091157.q4cesn6vsiy5qj2j@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101091157.q4cesn6vsiy5qj2j@box>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 01, 2019 at 12:11:57PM +0300, Kirill A. Shutemov wrote:
> On Fri, Nov 01, 2019 at 10:39:32AM +0200, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > It is not likely alpha will have 5-level page tables.
> > 
> > Replace usage of include/asm-generic/4level-fixup.h and implied
> > __ARCH_HAS_4LEVEL_HACK with include/asm-generic/pgtable-nop4d.h and adjust
> > page table manipulation macros and functions accordingly.
> 
> Not pgtable-nop4d.h, but pgtable-nopud.h. Also in subject.

Ouch, of course.
 
> -- 
>  Kirill A. Shutemov

-- 
Sincerely yours,
Mike.
