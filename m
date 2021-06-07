Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D4539D4D8
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 08:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhFGGVN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 02:21:13 -0400
Received: from verein.lst.de ([213.95.11.211]:44476 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229436AbhFGGVN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Jun 2021 02:21:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BD91467373; Mon,  7 Jun 2021 08:19:18 +0200 (CEST)
Date:   Mon, 7 Jun 2021 08:19:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     guoren@kernel.org, anup.patel@wdc.com, palmerdabbelt@google.com,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        drew@beagleboard.org, liush@allwinnertech.com,
        lazyparser@gmail.com, wefu@redhat.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Guo Ren <guoren@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH v2 06/11] riscv: pgtable: Add DMA_COHERENT with
 custom PTE attributes
Message-ID: <20210607061918.GA24060@lst.de>
References: <1622970249-50770-1-git-send-email-guoren@kernel.org> <1622970249-50770-10-git-send-email-guoren@kernel.org> <610849b6f66e8d5a9653c9f62f46c48d@mailhost.ics.forth.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <610849b6f66e8d5a9653c9f62f46c48d@mailhost.ics.forth.gr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jun 06, 2021 at 08:22:14PM +0300, Nick Kossifidis wrote:
> This patch violates the Privilege Spec section 4.4.1 that clearly states:
>
> "Bits63–54 are reserved for future standard use and must be zeroed by 
> software for forward compatibility"
>
> Standard use means that valid values can only be defined by the Priv. Spec, 
> not by the vendor (otherwise they'd be marked as "custom use" or "platform 
> use"), and since they "must" be zeroed by software we 'll be violating the 
> Privilege Spec if we do otherwise.

Yes, that is why I think it is a no-go.
