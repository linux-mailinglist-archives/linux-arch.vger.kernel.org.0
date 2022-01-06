Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0E44863C8
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jan 2022 12:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238559AbiAFLjg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jan 2022 06:39:36 -0500
Received: from foss.arm.com ([217.140.110.172]:52276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238526AbiAFLjg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Jan 2022 06:39:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8744811D4;
        Thu,  6 Jan 2022 03:39:35 -0800 (PST)
Received: from e123427-lin.Home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 034723F774;
        Thu,  6 Jan 2022 03:39:30 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     bp@alien8.de, robh@kernel.org, arnd@arndb.de, bhelgaas@google.com,
        tglx@linutronix.de, maz@kernel.org, wei.liu@kernel.org,
        Sunil Muthuswamy <sunilmut@linux.microsoft.com>,
        sthemmin@microsoft.com, decui@microsoft.com,
        haiyangz@microsoft.com, kw@linux.com, hpa@zytor.com,
        mingo@redhat.com, kys@microsoft.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-hyperv@vger.kernel.org,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        linux-arch@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v8 0/2] PCI: hv: Hyper-V vPCI for arm64
Date:   Thu,  6 Jan 2022 11:39:24 +0000
Message-Id: <164146914675.4069.11121648725605783394.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <1641411156-31705-1-git-send-email-sunilmut@linux.microsoft.com>
References: <1641411156-31705-1-git-send-email-sunilmut@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 5 Jan 2022 11:32:34 -0800, Sunil Muthuswamy wrote:
> From: Sunil Muthuswamy <sunilmut@microsoft.com>
> 
> Current Hyper-V vPCI code only compiles and works for x86. There are some
> hardcoded assumptions about the architectural IRQ chip and other arch
> defines.
> 
> Add support for Hyper-V vPCI for arm64 by first breaking the current hard
> coded dependency using a set of new interfaces and implementing those for
> x86 first. That is in the first patch. The second patch adds support for
> Hyper-V vPCI for arm64 by implementing the above mentioned interfaces. That
> is done by introducing a Hyper-V vPCI specific MSI IRQ domain & chip for
> allocating SPI vectors.
> 
> [...]

Applied to pci/hv, thanks!

[1/2] PCI: hv: Make the code arch neutral by adding arch specific interfaces
      https://git.kernel.org/lpieralisi/pci/c/6c63f4da30
[2/2] PCI: hv: Add arm64 Hyper-V vPCI support
      https://git.kernel.org/lpieralisi/pci/c/c10bdb758c

Thanks,
Lorenzo
