Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A941480C0F
	for <lists+linux-arch@lfdr.de>; Tue, 28 Dec 2021 18:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbhL1R2b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Dec 2021 12:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbhL1R2b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Dec 2021 12:28:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8608C061574;
        Tue, 28 Dec 2021 09:28:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20405B8111E;
        Tue, 28 Dec 2021 17:28:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8C2C36AE8;
        Tue, 28 Dec 2021 17:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640712507;
        bh=dXA+jtJKXsZeuGL+gqW27tuo78x2G9m366Sa3KzPs/Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=crA/K81U+X4as89k12VFJhq7l5G6mmRiyHJCr7rvQuKaJSWdRD8HsUWMtEiR6YiT9
         xkh3fc1SixiPjDrMU7N3s05mIn5FkXwJyvfvz2HzU6vrRz2riOGV87mq/O3z4d8tQl
         l3wzHW2xFwKfv/dalFrjV7NW+fNDw/8hVQWXM7ZxJJ/MA9xQMMsO/9gsZW7o3NqZJ4
         IikED5UaPWdt+nNRLG32gAEABqEKOfGQmWnJ51QmGxTBRsSymGbPiYQxhpnJTOsMHR
         ZQBcfSywIaDJPWsFdgoWCxTk5qfXOwl/2CtDSh3spa9fUbjDU36CMRuAVLEtAj2MBM
         dc88VkjPVXadA==
Date:   Tue, 28 Dec 2021 11:28:25 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org
Subject: Re: [RFC 28/32] PCI: make quirk using inw() depend on HAS_IOPORT
Message-ID: <20211228172825.GA1604151@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5112a787b635d5d2fc80a7f126c28176ad151098.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 28, 2021 at 05:52:05PM +0100, Niklas Schnelle wrote:
> On Tue, 2021-12-28 at 10:35 -0600, Bjorn Helgaas wrote:
> > On Tue, Dec 28, 2021 at 04:25:25PM +0100, Niklas Schnelle wrote:
> > > On Mon, 2021-12-27 at 16:33 -0600, Bjorn Helgaas wrote:

> > > > BTW, git complains about some whitespace errors in other patches:
> > > > 
> > > >   Applying: char: impi, tpm: depend on HAS_IOPORT
> > > >   .git/rebase-apply/patch:92: trailing whitespace.
> > > > 	    If you have a TPM security chip from Atmel say Yes and it
> > > >   .git/rebase-apply/patch:93: trailing whitespace.
> > > > 	    will be accessible from within Linux.  To compile this driver
> > > >   warning: 2 lines add whitespace errors.
> > > >   Applying: video: handle HAS_IOPORT dependencies
> > > >   .git/rebase-apply/patch:23: trailing whitespace.
> > > > 
> > > >   warning: 1 line adds whitespace errors.
> > > 
> > > ... But I just tried fetching the patches with b4 on top of
> > > v5.16-rc7 and the resulting tree passes "./scripts/checkpatch.pl
> > > --git v5.16-rc7..HEAD" and has an empty diff to my branch. What
> > > tool did you use to check?
> > 
> > "git am" is what complained.  Here's what I did:
> > 
> >   $ git checkout -b wip/niklas v5.16-rc1
> 
> Ah this seems to be because my patches are against v5.16-rc7. I
> noted that in the cover letter but I guess that is easy to miss and
> might not match expectations.

I get the same complaints when applying to v5.16-rc7:

  $ git checkout -b wip/niklas3 v5.16-rc7
  $ b4 am -om/ 20211227164317.4146918-1-schnelle@linux.ibm.com
  $ git am m/20211227_schnelle_kconfig_introduce_has_ioport_and_legacy_pci_options.mbx
