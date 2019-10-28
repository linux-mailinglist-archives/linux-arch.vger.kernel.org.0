Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF7ABE7516
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2019 16:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfJ1PaC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Oct 2019 11:30:02 -0400
Received: from verein.lst.de ([213.95.11.211]:35067 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbfJ1PaB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 Oct 2019 11:30:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C147268B05; Mon, 28 Oct 2019 16:29:56 +0100 (CET)
Date:   Mon, 28 Oct 2019 16:29:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Guo Ren <guoren@kernel.org>, Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-mtd@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/21] x86: clean up ioremap
Message-ID: <20191028152956.GA28048@lst.de>
References: <20191017174554.29840-1-hch@lst.de> <20191017174554.29840-9-hch@lst.de> <alpine.DEB.2.21.1910211019540.1904@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1910211019540.1904@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 21, 2019 at 10:23:03AM +0200, Thomas Gleixner wrote:
> Should this go with your larger series or can this be picked up
> independently?

This should all go together.
