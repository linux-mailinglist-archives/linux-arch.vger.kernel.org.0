Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5735095F
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jun 2019 13:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbfFXLCH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jun 2019 07:02:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60750 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727732AbfFXLCH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jun 2019 07:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PFY9YDguHF6FMnJNZWqDPWf/bS92KNk3W1oVKgmmLeQ=; b=mHhQ2OuaDFL9ZDRIK7Zn++Uqp
        FM1NThIDBSKiU3AoeejFsePBlOxbkE9BY26+Ynm9DyDbFvKKsSacc27JrDujO+2T/Hk4zCHpSNnJw
        UEHhVDF+ac+z+vle5GZzSVor66xI5pSVtLu01dArKl9vJFo4l+9noV0oIx54mVk7tcbKHOqIhmrGZ
        /xsVaOjNEnCIGFFVkvwfz8Pw4O4YBPifSauzoMhQ9EQhY4DIX9v7o1imrE5nGhCm4wR2c+uCBuGXe
        9zs9dliK9LKZFTL/6vXahJ9hETH6Q6HuflDrDh04k/Te/J+/2G1+aBUOoWFgOX8lFAKrPQ6kbNXbB
        x4Gtww9vw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hfMje-0003JZ-MV; Mon, 24 Jun 2019 11:02:06 +0000
Date:   Mon, 24 Jun 2019 04:02:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: Archs using generic PCI controller drivers vs. resource policy
Message-ID: <20190624110206.GA6541@infradead.org>
References: <5f3dcc3a8dafad188e3adb8ee9cf347bebdee7f6.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f3dcc3a8dafad188e3adb8ee9cf347bebdee7f6.camel@kernel.crashing.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jun 23, 2019 at 10:30:42AM +1000, Benjamin Herrenschmidt wrote:
> This is wrong. I want to move it to the architecture (initially,
> eventually it should be platform driven, but the default will start
> with architecture specific to avoid changing the existing behaviours
> while consolidating the code).

Doing this per arch sounds fundamentally wrong.  At best per firmware
type, but hopefully firmware messing with PCIe setup is slowly going
away, at least outside of x86.

> To do that right, I want to understand which archs can potentially use
> the code in drivers/pci/controller today so I can change those archs to
> explicitely set the default to "reassign everything" (and take the
> policy out of the drivers themselves).
> 
> So far I've counted arm, arm64 (DT, not ACPI) and nios2. Any other ?

riscv at least and probably anything that can be synthesized to common
FPGAs with PCIe support.
