Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54054E17C8
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2019 12:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391046AbfJWKZH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Oct 2019 06:25:07 -0400
Received: from mail.sf-mail.de ([116.202.16.50]:56427 "EHLO mail.sf-mail.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390952AbfJWKZG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 Oct 2019 06:25:06 -0400
Received: (qmail 27735 invoked from network); 23 Oct 2019 10:20:38 -0000
Received: from mail.sf-mail.de ([2a01:4f8:1c17:6fae:616d:6c69:616d:6c69]:43938 HELO webmail.sf-mail.de) (auth=eike@sf-mail.de)
        by mail.sf-mail.de (Qsmtpd 0.36dev) with (DHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA
        for <rppt@kernel.org>; Wed, 23 Oct 2019 12:20:38 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 23 Oct 2019 12:20:29 +0200
From:   Rolf Eike Beer <eike-kernel@sf-tec.de>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
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
        sparclinux@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        linux-parisc-owner@vger.kernel.org
Subject: Re: [PATCH 08/12] parisc: use pgtable-nopXd instead of 4level-fixup
In-Reply-To: <1571822941-29776-9-git-send-email-rppt@kernel.org>
References: <1571822941-29776-1-git-send-email-rppt@kernel.org>
 <1571822941-29776-9-git-send-email-rppt@kernel.org>
Message-ID: <70339cfc547e2fa0f6b98fefb1b1a9fa@sf-tec.de>
X-Sender: eike-kernel@sf-tec.de
User-Agent: Roundcube Webmail/1.3.8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> diff --git a/arch/parisc/include/asm/page.h 
> b/arch/parisc/include/asm/page.h
> index 93caf17..1d339ee 100644
> --- a/arch/parisc/include/asm/page.h
> +++ b/arch/parisc/include/asm/page.h
> @@ -42,48 +42,54 @@ typedef struct { unsigned long pte; } pte_t; /*
> either 32 or 64bit */
> 
>  /* NOTE: even on 64 bits, these entries are __u32 because we allocate
>   * the pmd and pgd in ZONE_DMA (i.e. under 4GB) */
> -typedef struct { __u32 pmd; } pmd_t;
>  typedef struct { __u32 pgd; } pgd_t;
>  typedef struct { unsigned long pgprot; } pgprot_t;
> 
> -#define pte_val(x)	((x).pte)
> -/* These do not work lvalues, so make sure we don't use them as such. 
> */
> +#if CONFIG_PGTABLE_LEVELS == 3
> +typedef struct { __u32 pmd; } pmd_t;
> +#define __pmd(x)	((pmd_t) { (x) } )
> +/* pXd_val() do not work lvalues, so make sure we don't use them as 
> such. */

For me it sounds like there is something missing, maybe an "as" before 
lvalues?
And it was "These", so plural, and now it is singular, so do -> does?

Eike
