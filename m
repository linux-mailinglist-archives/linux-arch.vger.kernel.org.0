Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E456388674
	for <lists+linux-arch@lfdr.de>; Wed, 19 May 2021 07:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbhESFWL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 May 2021 01:22:11 -0400
Received: from verein.lst.de ([213.95.11.211]:36587 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229598AbhESFWL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 May 2021 01:22:11 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2DEDA67373; Wed, 19 May 2021 07:20:49 +0200 (CEST)
Date:   Wed, 19 May 2021 07:20:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     guoren@kernel.org
Cc:     anup.patel@wdc.com, palmerdabbelt@google.com, drew@beagleboard.org,
        hch@lst.de, wefu@redhat.com, lazyparser@gmail.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
Message-ID: <20210519052048.GA24853@lst.de>
References: <1621400656-25678-1-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621400656-25678-1-git-send-email-guoren@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 19, 2021 at 05:04:13AM +0000, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The RISC-V ISA doesn't yet specify how to query or modify PMAs, so let
> vendors define the custom properties of memory regions in PTE.

Err, hell no.   The ISA needs to gets this fixed first.  Then we can
talk about alternatives patching things in or trapping in the SBI.
But if the RISC-V ISA can't get these basic done after years we can't
support it in Linux at all.
