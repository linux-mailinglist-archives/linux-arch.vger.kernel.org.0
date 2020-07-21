Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01DAC227837
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 07:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725294AbgGUFfq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 01:35:46 -0400
Received: from verein.lst.de ([213.95.11.211]:50620 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgGUFfq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Jul 2020 01:35:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 78C446736F; Tue, 21 Jul 2020 07:35:42 +0200 (CEST)
Date:   Tue, 21 Jul 2020 07:35:42 +0200
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
Message-ID: <20200721053542.GA10301@lst.de>
References: <20200714105505.935079-1-hch@lst.de> <20200714105505.935079-2-hch@lst.de> <20200718013849.GA157764@roeck-us.net> <20200718094846.GA8593@lst.de> <20200720221046.GA86726@roeck-us.net> <20200721045834.GA9613@lst.de> <eb470677-b569-a6f0-e63b-60149b54863a@roeck-us.net> <20200721052022.GA10011@lst.de> <7fc565fe-411e-6a0b-8aaf-0bf808f0d6a9@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7fc565fe-411e-6a0b-8aaf-0bf808f0d6a9@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 20, 2020 at 10:30:30PM -0700, Guenter Roeck wrote:
> Guess I lost it somewhere. Are you saying the check was wrong all along
> and your patch fixed it ?

Oh, it is a little complicated.

Normally we have two address space limits, KERNEL_DS and USER_DS,
and they are supposed to be different.  armnommu and m68k define them
to the same value for no good reason.  That leads to:

uaccess_kernel always returning true as it does a positive check
agains KERNEL_DS, which disables a bunch of drivers like sg and
rdma, and could also lead to really strange and probably broken
results in a few places.

It also leads to the SIGKILL in addr_limit_user_check never
triggering due to the negatіve check, which is ok as the limits
never are different.
