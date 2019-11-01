Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2910FEC059
	for <lists+linux-arch@lfdr.de>; Fri,  1 Nov 2019 10:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfKAJNE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Fri, 1 Nov 2019 05:13:04 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:59878 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfKAJNE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Nov 2019 05:13:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8EBD962EBCBC;
        Fri,  1 Nov 2019 10:13:00 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id PQahXYOT46px; Fri,  1 Nov 2019 10:12:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2AE38608313B;
        Fri,  1 Nov 2019 10:12:56 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id c14mF2Z6Kv1A; Fri,  1 Nov 2019 10:12:55 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id C825D6083139;
        Fri,  1 Nov 2019 10:12:55 +0100 (CET)
Date:   Fri, 1 Nov 2019 10:12:55 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
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
        linux-alpha@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org,
        linux-um <linux-um@lists.infradead.org>,
        sparclinux@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Message-ID: <1156525130.69849.1572599575743.JavaMail.zimbra@nod.at>
In-Reply-To: <1572597584-6390-12-git-send-email-rppt@kernel.org>
References: <1572597584-6390-1-git-send-email-rppt@kernel.org> <1572597584-6390-12-git-send-email-rppt@kernel.org>
Subject: Re: [PATCH v2 11/13] um: remove unused pxx_offset_proc() and
 addr_pte() functions
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: remove unused pxx_offset_proc() and addr_pte() functions
Thread-Index: uAt1m92PQC0j1btKcTDhR35rev+lrQ==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Mike Rapoport" <rppt@kernel.org>
> An: linux-mm@kvack.org
> CC: "Andrew Morton" <akpm@linux-foundation.org>, "anton ivanov" <anton.ivanov@cambridgegreys.com>, "Arnd Bergmann"
> <arnd@arndb.de>, "davem" <davem@davemloft.net>, "Geert Uytterhoeven" <geert@linux-m68k.org>, "Greentime Hu"
> <green.hu@gmail.com>, "Greg Ungerer" <gerg@linux-m68k.org>, "Helge Deller" <deller@gmx.de>, "James E.J. Bottomley"
> <James.Bottomley@HansenPartnership.com>, "Jeff Dike" <jdike@addtoit.com>, "Kirill A. Shutemov" <kirill@shutemov.name>,
> "torvalds" <torvalds@linux-foundation.org>, "Mark Salter" <msalter@redhat.com>, "Matt Turner" <mattst88@gmail.com>,
> "Michal Simek" <monstr@monstr.eu>, "Peter Rosin" <peda@axentia.se>, "richard" <richard@nod.at>, "Rolf Eike Beer"
> <eike-kernel@sf-tec.de>, "Russell King" <linux@armlinux.org.uk>, "Sam Creasey" <sammy@sammy.net>, "Vincent Chen"
> <deanbo422@gmail.com>, "Vineet Gupta" <Vineet.Gupta1@synopsys.com>, "Mike Rapoport" <rppt@kernel.org>,
> linux-alpha@vger.kernel.org, "linux-arch" <linux-arch@vger.kernel.org>, "linux-arm-kernel"
> <linux-arm-kernel@lists.infradead.org>, linux-c6x-dev@linux-c6x.org, "linux-kernel" <linux-kernel@vger.kernel.org>,
> linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org, "linux-um" <linux-um@lists.infradead.org>,
> sparclinux@vger.kernel.org, "Mike Rapoport" <rppt@linux.ibm.com>
> Gesendet: Freitag, 1. November 2019 09:39:42
> Betreff: [PATCH v2 11/13] um: remove unused pxx_offset_proc() and addr_pte() functions

> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The pxx_offset_proc() and addr_pte() functions are never used.
> Remove them.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
