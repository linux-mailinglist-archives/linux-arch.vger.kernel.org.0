Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10E8FF39BA
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2019 21:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfKGUrs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Nov 2019 15:47:48 -0500
Received: from verein.lst.de ([213.95.11.211]:59613 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726949AbfKGUrs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 7 Nov 2019 15:47:48 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 35A8468BE1; Thu,  7 Nov 2019 21:47:43 +0100 (CET)
Date:   Thu, 7 Nov 2019 21:47:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
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
Subject: generic-iomap tree for linux-next
Message-ID: <20191107204743.GA22863@lst.de>
References: <20191029064834.23438-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029064834.23438-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Stephen,

can you add the generic-ioremap tree:

   git://git.infradead.org/users/hch/ioremap.git

to linux-next? 

Thanks!
