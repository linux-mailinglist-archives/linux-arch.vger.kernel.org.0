Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE874FEEF
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jun 2019 04:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfFXCCC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 23 Jun 2019 22:02:02 -0400
Received: from gate.crashing.org ([63.228.1.57]:48706 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbfFXCCC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 23 Jun 2019 22:02:02 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5NNn5nJ006584;
        Sun, 23 Jun 2019 18:49:06 -0500
Message-ID: <c82439de338dfd26266305013cd4ebbb8fd30834.camel@kernel.crashing.org>
Subject: Re: Archs using generic PCI controller drivers vs. resource policy
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Date:   Mon, 24 Jun 2019 09:49:04 +1000
In-Reply-To: <5f3dcc3a8dafad188e3adb8ee9cf347bebdee7f6.camel@kernel.crashing.org>
References: <5f3dcc3a8dafad188e3adb8ee9cf347bebdee7f6.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, 2019-06-23 at 10:30 +1000, Benjamin Herrenschmidt wrote:
> 
> So far I've counted arm, arm64 (DT, not ACPI) and nios2. Any other ?

Hrm... nios2 doesn't do PCI despite what the Kconfig entry for
PCIE_ALTERA might want to let you believe.

So, anybody other than arm and arm64 using host bridge drivers in
drivers/pci/controller ?

Cheers,
Ben.


