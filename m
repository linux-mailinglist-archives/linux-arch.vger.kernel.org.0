Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF5C4F71AF
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2019 11:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfKKKPg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Nov 2019 05:15:36 -0500
Received: from verein.lst.de ([213.95.11.211]:48523 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbfKKKPg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 11 Nov 2019 05:15:36 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8B1EE68BE1; Mon, 11 Nov 2019 11:15:31 +0100 (CET)
Date:   Mon, 11 Nov 2019 11:15:31 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>,
        the arch/x86 maintainers <x86@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org,
        "moderated list:NIOS2 ARCHITECTURE" 
        <nios2-dev@lists.rocketboards.org>, openrisc@lists.librecores.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/21] asm-generic: ioremap_uc should behave the same
 with and without MMU
Message-ID: <20191111101531.GA12294@lst.de>
References: <20191029064834.23438-1-hch@lst.de> <20191029064834.23438-11-hch@lst.de> <CAK8P3a2o4R+E2hTrHrmNy7K1ki3_98aWE5a-fjkQ_NWW=xd_gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2o4R+E2hTrHrmNy7K1ki3_98aWE5a-fjkQ_NWW=xd_gQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 11, 2019 at 11:09:05AM +0100, Arnd Bergmann wrote:
> Maybe we could move the definition into the atyfb driver itself?
> 
> As I understand it, the difference between ioremap()/ioremap_nocache()
> and ioremap_uc() only exists on pre-PAT x86-32 systems (i.e. 486, P5,
> Ppro, PII, K6, VIA C3), while on more modern systems (all non-x86,
> PentiumIII, Athlon, VIA C7)  those three are meant to be synonyms
> anyway.

That's not how I understood it.  Based on the code and the UC-
explanation ioremap_uc always overrides the MTRR, which can still
be present on more modern x86 systems.  In fact I remember a patch
floating around very recently adding another ioremap_uc caller in
some Atom platform device driver that works around buggy MTRR
tables.  Also this series actually adds a new override and a few
callers for ia64 platform code, which works very similar to x86
based on the comments in the code.  That being said I'm not sure
the callers in ia64 are really required, but it was the safest thing
to do as part of this cleanup.
