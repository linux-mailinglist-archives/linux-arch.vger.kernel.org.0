Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 755FEE29F9
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2019 07:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390818AbfJXFfr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Oct 2019 01:35:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390377AbfJXFfq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 24 Oct 2019 01:35:46 -0400
Received: from rapoport-lnx (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B28CB21655;
        Thu, 24 Oct 2019 05:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571895345;
        bh=HtXRJiY7E2WBnhLRCrWIVwj9zwzEbWwIp+kCGNGU0Vg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tpPSOqsLnoWaoVDB4h50UjvklrLgrRrHwG3rkhRndGIgW8V6sc9hNTf4UN34hFwxd
         EDlIQgRgR2JO3vRsExo5akPfc8ur10rMzq+eFhkh9/wE3wVVi86wgylxz9wN3JsIOW
         jZczc3/Wgo5n0bXYOQjP4NRTDpq4bC2/PUFWinU8=
Date:   Thu, 24 Oct 2019 08:35:34 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jeff Dike <jdike@addtoit.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Sam Creasey <sammy@sammy.net>,
        Vincent Chen <deanbo422@gmail.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-parisc@vger.kernel.org, linux-um@lists.infradead.org,
        sparclinux@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 04/12] m68k: nommu: use pgtable-nopud instead of
 4level-fixup
Message-ID: <20191024053533.GA12281@rapoport-lnx>
References: <1571822941-29776-1-git-send-email-rppt@kernel.org>
 <1571822941-29776-5-git-send-email-rppt@kernel.org>
 <de03a882-fb1a-455c-7c60-84ab0c4f9674@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de03a882-fb1a-455c-7c60-84ab0c4f9674@linux-m68k.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Greg,

On Thu, Oct 24, 2019 at 02:09:01PM +1000, Greg Ungerer wrote:
> Hi Mike,
> 
> On 23/10/19 7:28 pm, Mike Rapoport wrote:
> >From: Mike Rapoport <rppt@linux.ibm.com>
> >
> >The generic nommu implementation of page table manipulation takes care of
> >folding of the upper levels and does not require fixups.
> >
> >Simply replace of include/asm-generic/4level-fixup.h with
> >include/asm-generic/pgtable-nopud.h.
> >
> >Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> >---
> >  arch/m68k/include/asm/pgtable_no.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/arch/m68k/include/asm/pgtable_no.h b/arch/m68k/include/asm/pgtable_no.h
> >index c18165b..ccc4568 100644
> >--- a/arch/m68k/include/asm/pgtable_no.h
> >+++ b/arch/m68k/include/asm/pgtable_no.h
> >@@ -2,7 +2,7 @@
> >  #ifndef _M68KNOMMU_PGTABLE_H
> >  #define _M68KNOMMU_PGTABLE_H
> >-#include <asm-generic/4level-fixup.h>
> >+#include <asm-generic/pgtable-nopud.h>
> >  /*
> >   * (C) Copyright 2000-2002, Greg Ungerer <gerg@snapgear.com>
> 
> This fails to compile for me (targeting m5208evb_defconfig):
> 
>   CC      init/main.o
> In file included from ./arch/m68k/include/asm/pgtable_no.h:56:0,
>                  from ./arch/m68k/include/asm/pgtable.h:3,
>                  from ./include/linux/mm.h:99,
>                  from ./include/linux/ring_buffer.h:5,
>                  from ./include/linux/trace_events.h:6,
>                  from ./include/trace/syscall.h:7,
>                  from ./include/linux/syscalls.h:85,
>                  from init/main.c:21:
> ./include/asm-generic/pgtable.h:738:34: error: unknown type name ‘pmd_t’
>  static inline int pmd_soft_dirty(pmd_t pmd)
>                                   ^

...

> scripts/Makefile.build:265: recipe for target 'init/main.o' failed
> make[1]: *** [init/main.o] Error 1
> Makefile:1649: recipe for target 'init' failed
> make: *** [init] Error 2

The hunk below fixes the build.

diff --git a/arch/m68k/include/asm/page.h b/arch/m68k/include/asm/page.h
index c00b67a..05e1e1e 100644
--- a/arch/m68k/include/asm/page.h
+++ b/arch/m68k/include/asm/page.h
@@ -21,7 +21,7 @@
 /*
  * These are used to make use of C type-checking..
  */
-#if CONFIG_PGTABLE_LEVELS == 3
+#if !defined(CONFIG_MMU) || CONFIG_PGTABLE_LEVELS == 3
 typedef struct { unsigned long pmd[16]; } pmd_t;
 #define pmd_val(x)	((&x)->pmd[0])
 #define __pmd(x)	((pmd_t) { { (x) }, })
 
> Regards
> Greg
> 

-- 
Sincerely yours,
Mike.
