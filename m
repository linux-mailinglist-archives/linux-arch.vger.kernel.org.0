Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31B840BC90
	for <lists+linux-arch@lfdr.de>; Wed, 15 Sep 2021 02:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhIOAYq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Sep 2021 20:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhIOAYp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Sep 2021 20:24:45 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5D6C061574;
        Tue, 14 Sep 2021 17:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1631665405;
        bh=Pliqrcvr6CmlpuzEgkusFjzlu2wuAo+oNPelgwZk/tI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=TPy4x0c0qB00Uky/okfi0agfYTTirGCIOxGnyL3Z2WJjcy9Ij+y6eYt34V0foPR/O
         o1okl98XSAlBWoLSjBK2ST30QS4MIAlF6Q5jA9WbJd+t/pYlgoXvxAw0bJWuqYJ3kd
         7a7a6bYzwZZ6/qCNoSAmjasAfhIO+tm/yfC0Qr4vHTgZfWFSMgRJZ0XA3P/TYxv3W8
         HAXDqW2k6pmwvEaigI491dok7/GBd2trlcrP8o0JI2Q9R8YjbcSTnLHIZiytZzNpto
         aHqxor2QYwZ9tGiIR0+zkTxf7ARZwTpGwCyhJhFhBNQsj7LzgLsiKQ4LnRpQ+coT+7
         P6bVDxR2ZyoQQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4H8LXr70S6z9s5R;
        Wed, 15 Sep 2021 10:23:24 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Oliver O'Halloran <oohall@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/1] powerpc: Drop superfluous pci_dev_is_added() calls
In-Reply-To: <20210914193130.GA1447657@bjorn-Precision-5520>
References: <20210914193130.GA1447657@bjorn-Precision-5520>
Date:   Wed, 15 Sep 2021 10:23:22 +1000
Message-ID: <87o88uk7ph.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> writes:
> On Fri, Sep 10, 2021 at 04:19:40PM +0200, Niklas Schnelle wrote:
>> On powerpc, pci_dev_is_added() is called as part of SR-IOV fixups
>> that are done under pcibios_add_device() which in turn is only called in
>> pci_device_add() whih is called when a PCI device is scanned.
>> 
>> Now pci_dev_assign_added() is called in pci_bus_add_device() which is
>> only called after scanning the device. Thus pci_dev_is_added() is always
>> false and can be dropped.
>> 
>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
>
> This doesn't touch the PCI core, so maybe makes sense for you to take
> it, Michael?  But let me know if you think otherwise.

Yeah I'm happy to take it, thanks.

cheers
