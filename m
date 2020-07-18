Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED2E224A6E
	for <lists+linux-arch@lfdr.de>; Sat, 18 Jul 2020 11:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgGRJsu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Jul 2020 05:48:50 -0400
Received: from verein.lst.de ([213.95.11.211]:41559 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbgGRJsu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 18 Jul 2020 05:48:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0A28768BEB; Sat, 18 Jul 2020 11:48:46 +0200 (CEST)
Date:   Sat, 18 Jul 2020 11:48:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@lst.de>, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] syscalls: use uaccess_kernel in
 addr_limit_user_check
Message-ID: <20200718094846.GA8593@lst.de>
References: <20200714105505.935079-1-hch@lst.de> <20200714105505.935079-2-hch@lst.de> <20200718013849.GA157764@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718013849.GA157764@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 17, 2020 at 06:38:50PM -0700, Guenter Roeck wrote:
> Hi,
> 
> On Tue, Jul 14, 2020 at 12:55:00PM +0200, Christoph Hellwig wrote:
> > Use the uaccess_kernel helper instead of duplicating it.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> This patch causes a severe hiccup with my mps2-an385 boot test.

I guess that is a nommu config?

Can you try this patch?

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index b19c9bec1f7a63..cc7daf374a6eb6 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -263,7 +263,7 @@ extern int __put_user_8(void *, unsigned long long);
  */
 #define USER_DS			KERNEL_DS
 
-#define uaccess_kernel()	(true)
+#define uaccess_kernel()	(false)
 #define __addr_ok(addr)		((void)(addr), 1)
 #define __range_ok(addr, size)	((void)(addr), 0)
 #define get_fs()		(KERNEL_DS)
