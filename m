Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1705D156
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jul 2019 16:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfGBORd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Jul 2019 10:17:33 -0400
Received: from gate.crashing.org ([63.228.1.57]:54750 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbfGBORd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Jul 2019 10:17:33 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x62EHQG7016707;
        Tue, 2 Jul 2019 09:17:27 -0500
Message-ID: <1c5b15f9bc714a5e5a05bd788e1e041c3e9ffd85.camel@kernel.crashing.org>
Subject: Re: Archs using generic PCI controller drivers vs. resource policy
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Greg Ungerer <gregungerer00@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Date:   Wed, 03 Jul 2019 00:17:25 +1000
In-Reply-To: <bafcb3eb-2bf0-2ea7-00e4-50e729406978@linux-m68k.org>
References: <5f3dcc3a8dafad188e3adb8ee9cf347bebdee7f6.camel@kernel.crashing.org>
         <bafcb3eb-2bf0-2ea7-00e4-50e729406978@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2019-07-02 at 23:24 +1000, Greg Ungerer wrote:
> > So far I've counted arm, arm64 (DT, not ACPI) and nios2. Any other
> > ?
> 
> For the m68k platforms which support PCI (which is only some of
> the more modern ColdFire variants) they expect PCI resources to
> be assigned by Linux. There is no boot firmware that will do that
> before kernel startup.
> 
> The PCI root driver complex is already in the arch area though
> (arch/m68k/coldfire/pci.c) so that is essentially what you
> want to achieve right?

Thanks !

So no I'm not trying to move controllers to arch. It makes sense to
have controllers live in generic code when those controller are IP
blocks from mobs like DesignWare that various SoC vendors chose to
integrate, regardless of the CPU architecture.

The issue is more about the resource allocation policy. I want to move
that *out* of the host controller drivers. That policy essentially
depends on whether a given platform/board trusts its firmware or not,
so it's fundamentally arch specific.

There are various reason which I can elaborate if you want wy some
platforms actually need to trust the firmware, at least partially.

Most embedded platforms don't give a damn and are happy for Linux to
reassign everything.

Cheers,
Ben.

