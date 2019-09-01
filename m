Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75003A4849
	for <lists+linux-arch@lfdr.de>; Sun,  1 Sep 2019 10:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfIAICd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 1 Sep 2019 04:02:33 -0400
Received: from verein.lst.de ([213.95.11.211]:40658 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbfIAICd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 1 Sep 2019 04:02:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id F351D227A8A; Sun,  1 Sep 2019 10:02:27 +0200 (CEST)
Date:   Sun, 1 Sep 2019 10:02:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Guo Ren <guoren@kernel.org>, Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        openrisc@lists.librecores.org, linux-mtd@lists.infradead.org,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, linux-riscv@lists.infradead.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 24/26] riscv: use the generic ioremap code
Message-ID: <20190901080227.GB12035@lst.de>
References: <20190817073253.27819-1-hch@lst.de> <20190817073253.27819-25-hch@lst.de> <alpine.DEB.2.21.9999.1908171421560.4130@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1908171421560.4130@viisi.sifive.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Aug 17, 2019 at 02:22:15PM -0700, Paul Walmsley wrote:
> Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>
> Tested-by: Paul Walmsley <paul.walmsley@sifive.com> # rv32, rv64 boot
> Acked-by: Paul Walmsley <paul.walmsley@sifive.com> # arch/riscv

Can you also take a look at the patch adding the generic code?
