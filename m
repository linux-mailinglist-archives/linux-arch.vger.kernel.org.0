Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9205A6AFE0
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2019 21:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388650AbfGPTaP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Jul 2019 15:30:15 -0400
Received: from smtp.duncanthrax.net ([89.31.1.170]:49247 "EHLO
        smtp.duncanthrax.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728858AbfGPTaP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jul 2019 15:30:15 -0400
X-Greylist: delayed 2219 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jul 2019 15:30:13 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=duncanthrax.net; s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date;
        bh=dKHH4h/q3QG6V+WLSyHa/70tf/GFmuqAjtSnkGY7D2U=; b=EInCxkcX8/U7HJUwQX6zQawdSA
        3En7UuZMxWmfpQQF+KD4KM1ZhQkrsY8ilze4mu+wmEjt4CDQ5zYqbUN3KgJVT6QaszCyuS3hR9bBO
        qU7MV+VzceEfmsLdf7RLymVUnFZS5OewOtK76S4aHj4tYo94hhMXGfxzrzYwOcQMJw1Y=;
Received: from [134.3.44.134] (helo=t470p.stackframe.org)
        by smtp.eurescom.eu with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.86_2)
        (envelope-from <svens@stackframe.org>)
        id 1hnSZc-0000Wk-IO; Tue, 16 Jul 2019 20:53:12 +0200
Date:   Tue, 16 Jul 2019 20:53:10 +0200
From:   Sven Schnelle <svens@stackframe.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>, mpe@ellerman.id.au
Subject: Re: [PATCH 1/2] arch: mark syscall number 435 reserved for clone3
Message-ID: <20190716185310.GA12537@t470p.stackframe.org>
References: <20190714192205.27190-1-christian@brauner.io>
 <20190714192205.27190-2-christian@brauner.io>
 <e14eb2f9-43cb-0b9d-dec4-b7e7dcd62091@de.ibm.com>
 <20190716130631.tohj4ub54md25dys@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716130631.tohj4ub54md25dys@brauner.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

[Adding Helge to CC list]

On Tue, Jul 16, 2019 at 03:06:33PM +0200, Christian Brauner wrote:
> On Mon, Jul 15, 2019 at 03:56:04PM +0200, Christian Borntraeger wrote:
> > I think Vasily already has a clone3 patch for s390x with 435. 
> 
> A quick follow-up on this. Helge and Michael have asked whether there
> are any tests for clone3. Yes, there will be and I try to have them
> ready by the end of the this or next week for review. In the meantime I
> hope the following minimalistic test program that just verifies very
> very basic functionality (It's not pretty.) will help you test:
> [..]

On PA-RISC this seems to work fine with Helge's patch to wire up the
clone3 syscall.

root@c3750:/# clonetest
Parent process received child's pid 84 as return value
Parent process received child's pidfd 3
Parent process received child's pid 84 as return argument
Child process with pid 84
root@c3750:/# echo $?
0

Regards
Sven
