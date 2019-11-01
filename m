Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16048EC06A
	for <lists+linux-arch@lfdr.de>; Fri,  1 Nov 2019 10:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbfKAJUP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Fri, 1 Nov 2019 05:20:15 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:60088 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728271AbfKAJUP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Nov 2019 05:20:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id DEA1E608313B;
        Fri,  1 Nov 2019 10:20:11 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8IWPWn6JPQyM; Fri,  1 Nov 2019 10:20:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B72236083139;
        Fri,  1 Nov 2019 10:20:10 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sbwSZl86X70W; Fri,  1 Nov 2019 10:20:10 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id F410762EBCC0;
        Fri,  1 Nov 2019 10:20:09 +0100 (CET)
Date:   Fri, 1 Nov 2019 10:20:09 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>, davem <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jeff Dike <jdike@addtoit.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        torvalds <torvalds@linux-foundation.org>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>, Peter Rosin <peda@axentia.se>,
        Rolf Eike Beer <eike-kernel@sf-tec.de>,
        Russell King <linux@armlinux.org.uk>,
        Sam Creasey <sammy@sammy.net>,
        Vincent Chen <deanbo422@gmail.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        linux-alpha <linux-alpha@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-c6x-dev <linux-c6x-dev@linux-c6x.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-parisc <linux-parisc@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Message-ID: <1435962204.69872.1572600009245.JavaMail.zimbra@nod.at>
In-Reply-To: <1572597584-6390-13-git-send-email-rppt@kernel.org>
References: <1572597584-6390-1-git-send-email-rppt@kernel.org> <1572597584-6390-13-git-send-email-rppt@kernel.org>
Subject: Re: [PATCH v2 12/13] um: add support for folded p4d page tables
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: add support for folded p4d page tables
Thread-Index: S6h0nIi9frMaCZ4VaOjeTjwnLFOM0w==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Mike Rapoport" <rppt@kernel.org>

[...]

> #define pte_page(x) pfn_to_page(pte_pfn(x))
> diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
> index 417ff64..6fd17bc 100644
> --- a/arch/um/kernel/mem.c
> +++ b/arch/um/kernel/mem.c
> @@ -92,10 +92,26 @@ static void __init one_md_table_init(pud_t *pud)
> #endif
> }
> 
> +static void __init one_pud_table_init(p4d_t *p4d)
> +{
> +#if CONFIG_PGTABLE_LEVELS > 3

Isn't this dead code?

For uml we have:
config PGTABLE_LEVELS
        int
        default 3 if 3_LEVEL_PGTABLES
        default 2

Thanks,
//richard
