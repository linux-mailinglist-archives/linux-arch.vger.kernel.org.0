Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 054435097A
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jun 2019 13:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfFXLLT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jun 2019 07:11:19 -0400
Received: from gate.crashing.org ([63.228.1.57]:40470 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727282AbfFXLLT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Jun 2019 07:11:19 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5OBB6U9029913;
        Mon, 24 Jun 2019 06:11:07 -0500
Message-ID: <41b68d14c2805da16e8b563236232c22e9203ec0.camel@kernel.crashing.org>
Subject: Re: Archs using generic PCI controller drivers vs. resource policy
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-arch@vger.kernel.org
Date:   Mon, 24 Jun 2019 21:11:04 +1000
In-Reply-To: <20190624110206.GA6541@infradead.org>
References: <5f3dcc3a8dafad188e3adb8ee9cf347bebdee7f6.camel@kernel.crashing.org>
         <20190624110206.GA6541@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2019-06-24 at 04:02 -0700, Christoph Hellwig wrote:
> On Sun, Jun 23, 2019 at 10:30:42AM +1000, Benjamin Herrenschmidt wrote:
> > This is wrong. I want to move it to the architecture (initially,
> > eventually it should be platform driven, but the default will start
> > with architecture specific to avoid changing the existing behaviours
> > while consolidating the code).
> 
> Doing this per arch sounds fundamentally wrong.  At best per firmware
> type, but hopefully firmware messing with PCIe setup is slowly going
> away, at least outside of x86.

No it's actually the other way around. UEFI/ACPI is growing outside of
x86 and it *is* essing with PCIe in ways we need to deal with better
(it's somewhat broken on arm64 today).

That said, the policy doesn't belong in the host bridge driver. It's
platform (or firmware) driven. At the moment, those platform/firmware
type decisions are done in the architecture. This can change, but I
won't change everything in one day.

Keep in mind that what I'm doing is a clean up keeping existing
behaviours as much as possible. Once we don't have 36 different ways of
doing the same thing, we can look at whether we want to change the
actual policies for some platforms/firmware/arch combinations.

Today, it's a practical fact that the resource allocation policy is
driven by the arch/platform code.

The fact that some host bridge drivers in drivers/pci/controller
effectively implement a resource allocation policy by diretly calling
stuff they shouldn't be calling is what I'm trying to fix.

So I just want to make the arch (today) set a default policy and have
the controller drivers call a generic function that performs the
resource management according to said policy.

> > To do that right, I want to understand which archs can potentially use
> > the code in drivers/pci/controller today so I can change those archs to
> > explicitely set the default to "reassign everything" (and take the
> > policy out of the drivers themselves).
> > 
> > So far I've counted arm, arm64 (DT, not ACPI) and nios2. Any other ?
> 
> riscv at least and probably anything that can be synthesized to common
> FPGAs with PCIe support.

Ok. I'll set riscv default policy to reassign all like arm and arm64
for now.

Cheers,
Ben.

