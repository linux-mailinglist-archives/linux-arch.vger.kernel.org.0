Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD1CDE9A23
	for <lists+linux-arch@lfdr.de>; Wed, 30 Oct 2019 11:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfJ3KkA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Oct 2019 06:40:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51598 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfJ3KkA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Oct 2019 06:40:00 -0400
Received: from [91.217.168.176] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iPlOF-00009u-Rt; Wed, 30 Oct 2019 11:39:47 +0100
Date:   Wed, 30 Oct 2019 11:39:46 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Christoph Hellwig <hch@lst.de>
cc:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
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
Subject: Re: [PATCH 08/21] x86: Clean up ioremap()
In-Reply-To: <20191029064834.23438-9-hch@lst.de>
Message-ID: <alpine.DEB.2.21.1910301139330.19226@nanos.tec.linutronix.de>
References: <20191029064834.23438-1-hch@lst.de> <20191029064834.23438-9-hch@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 29 Oct 2019, Christoph Hellwig wrote:

> Use ioremap() as the main implemented function, and defines
> ioremap_nocache() as a deprecated alias of ioremap() in
> preparation of removing ioremap_nocache() entirely.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
