Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93FF3435348
	for <lists+linux-arch@lfdr.de>; Wed, 20 Oct 2021 20:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhJTS70 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Oct 2021 14:59:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbhJTS70 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Oct 2021 14:59:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CB6760249;
        Wed, 20 Oct 2021 18:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634756231;
        bh=c2jY8ymiMY3Oy2Z6jKQ2ADQk+YS+0uIHTAIHMyrj4d4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Xu1dOdPw2L6TAe2uNnx5QTRy2Td63u6NBwzyWaSCCHj4d+uj3Ldfj99IzK1AXdsN/
         71BtESWYDYs8jseaEui6EPQAZvryhze45cI20z6T8nrQ8pLgLcbiNEBLGdzCrGSf2r
         Y3gXCtE591i/ocFl13+ceByW3vqR+ofuDyeWaCrKbFQpOgrwqcL2bYOamkuIEIZoco
         /r/PLJH1mRuizppkP252a/HFJHu8Y5s7MDLMFhtcBtv/3/68x6G9hntS6f8wvk/HkC
         GXYhe6/WTmqSjuT2Ckf7jsFwV2T6nBjfXjSdxImT+9486PfRAlQ/6ZIG4kJYzSffX7
         rjMJvE096L/Cw==
Date:   Wed, 20 Oct 2021 13:57:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sunil Muthuswamy <sunilmut@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, maz@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, arnd@arndb.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        Sunil Muthuswamy <sunilmut@microsoft.com>
Subject: Re: [PATCH v3 1/2] PCI: hv: Make the code arch neutral by adding
 arch specific interfaces
Message-ID: <20211020185709.GA2630556@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634226794-9540-2-git-send-email-sunilmut@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 14, 2021 at 08:53:13AM -0700, Sunil Muthuswamy wrote:
> From: Sunil Muthuswamy <sunilmut@microsoft.com>
> 
> Encapsulate arch dependencies in Hyper-V vPCI through a set of interfaces,
> listed below. Adding these arch specific interfaces will allow for an
> implementation for other arch, such as ARM64.
> 
> Implement the interfaces for X64, which is essentially just moving over the
> current implementation.

I think you mean x86, not X64, right?

Bjorn
