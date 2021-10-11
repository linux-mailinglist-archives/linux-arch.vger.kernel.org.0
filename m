Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87AB3428CA1
	for <lists+linux-arch@lfdr.de>; Mon, 11 Oct 2021 14:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236478AbhJKMKE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Oct 2021 08:10:04 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:39481 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbhJKMKC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Oct 2021 08:10:02 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HScxs05F1z4xqg;
        Mon, 11 Oct 2021 23:08:00 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org
In-Reply-To: <20210910141940.2598035-1-schnelle@linux.ibm.com>
References: <20210910141940.2598035-1-schnelle@linux.ibm.com>
Subject: Re: [PATCH 0/1] Arch use of pci_dev_is_added()
Message-Id: <163395400023.4094789.2020698522524936572.b4-ty@ellerman.id.au>
Date:   Mon, 11 Oct 2021 23:06:40 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 10 Sep 2021 16:19:39 +0200, Niklas Schnelle wrote:
> In my proposal to make pci_dev_is_added() more regularly usable by arch code
> you mentioned[0] that you believe the uses in arch/powerpc are not necessary
> anymore. From code reading I agree and so does Oliver O'Halloran[1].
> 
> So as promised here is a patch removing them. I only compile tested this as
> I don't have access to a powerpc system.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Drop superfluous pci_dev_is_added() calls
      https://git.kernel.org/powerpc/c/452f145eca73945222923525a7eba59cf37909cc

cheers
