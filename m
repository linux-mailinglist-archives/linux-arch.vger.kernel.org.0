Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27621480B58
	for <lists+linux-arch@lfdr.de>; Tue, 28 Dec 2021 17:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbhL1Qfq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Dec 2021 11:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbhL1Qfq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Dec 2021 11:35:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18986C061574;
        Tue, 28 Dec 2021 08:35:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C54ACB8125D;
        Tue, 28 Dec 2021 16:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CD0C36AE7;
        Tue, 28 Dec 2021 16:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640709343;
        bh=FeS2EfiHBY+grSsnbveXQExSBkQjtpJV3R6rmS0ZbiE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=c98Jwney8HCFHv+to7+69XkxjFyjMsUw2FottiRMdPD7Gxg+jDVvMQ0fdT+tGgzt1
         /DCD1jTXA7AkwMZXc8eYFd4QZkeIPHu82Ngln8qnHqVYBdx9kvlz5U69Ig3nepZIOE
         ZZ45Qqc8Wm6St7KnIiisO3ZziJymv7zDhhKmaDFc96Qi+1nk55L5EsB6RXwh3OWUvQ
         NjawCX/lQmXHBKhjr4umk7m6CxCuYRaW6ft1NDESBaJdtfFv8TwLnMHOeyU8ZesaDv
         W33/hhPDUMdmpwh80kfo9woW1lVVLCWYhLhWiG1goXkHB9KYxDG3AVqiNAA27ey9vi
         VGlu1oMrllxDA==
Date:   Tue, 28 Dec 2021 10:35:41 -0600
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
Message-ID: <20211228163541.GA1599602@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b719d661f9ba7a23776b00a2f250d14cb21bafa.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 28, 2021 at 04:25:25PM +0100, Niklas Schnelle wrote:
> On Mon, 2021-12-27 at 16:33 -0600, Bjorn Helgaas wrote:
> > On Mon, Dec 27, 2021 at 05:43:13PM +0100, Niklas Schnelle wrote:

> > If we keep it in drivers/pci, please update the subject line to make
> > it more specific and match the convention, e.g.,
> > 
> >   PCI: Compile quirk_tigerpoint_bm_sts() only when HAS_IOPORT set
> 
> Ah yeah I was going back and forth between matching this within the
> series vs matching the subsystem. I guess going with the subsystem is
> mote important long term.

Haha, yes, a little ambiguity there.  I do think the subsystem is more
important because the identity of the series is mostly lost after it's
applied.  Thanks for thinking about it!

> > BTW, git complains about some whitespace errors in other patches:
> > 
> >   Applying: char: impi, tpm: depend on HAS_IOPORT
> >   .git/rebase-apply/patch:92: trailing whitespace.
> > 	    If you have a TPM security chip from Atmel say Yes and it
> >   .git/rebase-apply/patch:93: trailing whitespace.
> > 	    will be accessible from within Linux.  To compile this driver
> >   warning: 2 lines add whitespace errors.
> >   Applying: video: handle HAS_IOPORT dependencies
> >   .git/rebase-apply/patch:23: trailing whitespace.
> > 
> >   warning: 1 line adds whitespace errors.
> 
> That is very strange. I did run checkpatch before. There are a few
> warnings not to touch obsolete code unnecessarily and a check about
> using udelay() (pre-existing) plus two missing blank lines in pci-
> quirks.h that I ignored because it matches the sorounding style.
> 
> I did notice that lore fails to render the subject lines for some of
> the patches. But I just tried fetching the patches with b4 on top of
> v5.16-rc7 and the resulting tree passes "./scripts/checkpatch.pl --git
> v5.16-rc7..HEAD" and has an empty diff to my branch. What tool did you
> use to check?

"git am" is what complained.  Here's what I did:

  $ git checkout -b wip/niklas v5.16-rc1
  Switched to a new branch 'wip/niklas'
  10:30:06 ~/linux (wip/niklas)$ b4 am -om/ 20211227164317.4146918-1-schnelle@linux.ibm.com
  Looking up https://lore.kernel.org/r/20211227164317.4146918-1-schnelle%40linux.ibm.com
  Grabbing thread from lore.kernel.org/all/20211227164317.4146918-1-schnelle%40linux.ibm.com/t.mbox.gz
  Analyzing 70 messages in the thread
  Checking attestation on all messages, may take a moment...
  ---
    ✓ [PATCH RFC 1/32] Kconfig: introduce and depend on LEGACY_PCI
    ✓ [PATCH RFC 2/32] Kconfig: introduce HAS_IOPORT option and select it as necessary
    ✓ [PATCH RFC 3/32] ACPI: Kconfig: add HAS_IOPORT dependencies
    ✓ [PATCH RFC 4/32] parport: PC style parport depends on HAS_IOPORT
    ✓ [PATCH RFC 5/32] char: impi, tpm: depend on HAS_IOPORT
    ✓ [PATCH RFC 6/32] speakup: Kconfig: add HAS_IOPORT dependencies
      + Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
    ✓ [PATCH RFC 7/32] Input: gameport: add ISA and HAS_IOPORT dependencies
    ✓ [PATCH RFC 8/32] comedi: Kconfig: add HAS_IOPORT dependencies
    ✓ [PATCH RFC 9/32] sound: Kconfig: add HAS_IOPORT dependencies
    ✓ [PATCH RFC 10/32] i2c: Kconfig: add HAS_IOPORT dependencies
    ✓ [PATCH RFC 11/32] Input: Kconfig: add HAS_IOPORT dependencies
    ✓ [PATCH RFC 12/32] iio: adc: Kconfig: add HAS_IOPORT dependencies
    ✓ [PATCH RFC 13/32] hwmon: Kconfig: add HAS_IOPORT dependencies
    ✓ [PATCH RFC 14/32] leds: Kconfig: add HAS_IOPORT dependencies
    ✓ [PATCH RFC 15/32] media: Kconfig: add HAS_IOPORT dependencies
    ✓ [PATCH RFC 16/32] misc: handle HAS_IOPORT dependencies
    ✓ [PATCH RFC 17/32] net: Kconfig: add HAS_IOPORT dependencies
      + Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
    ✓ [PATCH RFC 18/32] pcmcia: Kconfig: add HAS_IOPORT dependencies
      + Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>
    ✓ [PATCH RFC 19/32] platform: Kconfig: add HAS_IOPORT dependencies
    ✓ [PATCH RFC 20/32] pnp: Kconfig: add HAS_IOPORT dependencies
    ✓ [PATCH RFC 21/32] power: Kconfig: add HAS_IOPORT dependencies
    ✓ [PATCH RFC 22/32] video: handle HAS_IOPORT dependencies
    ✓ [PATCH RFC 23/32] rtc: Kconfig: add HAS_IOPORT dependencies
    ✓ [PATCH RFC 24/32] scsi: Kconfig: add HAS_IOPORT dependencies
    ✓ [PATCH RFC 25/32] watchdog: Kconfig: add HAS_IOPORT dependencies
    ✓ [PATCH RFC 26/32] drm: handle HAS_IOPORT dependencies
    ✓ [PATCH RFC 27/32] PCI/sysfs: make I/O resource depend on HAS_IOPORT
    ✓ [PATCH RFC 28/32] PCI: make quirk using inw() depend on HAS_IOPORT
    ✓ [PATCH RFC 29/32] firmware: dmi-sysfs: handle HAS_IOPORT dependencies
    ✓ [PATCH RFC 30/32] /dev/port: don't compile file operations without CONFIG_DEVPORT
    ✓ [PATCH RFC 31/32] usb: handle HAS_IOPORT dependencies
    ✓ [PATCH RFC 32/32] asm-generic/io.h: drop inb() etc for HAS_IOPORT=n
    ---
    ✓ Signed: DKIM/ibm.com (From: schnelle@linux.ibm.com)
  ---
  Total patches: 32
  ---
  Cover: m/20211227_schnelle_kconfig_introduce_has_ioport_and_legacy_pci_options.cover
   Link: https://lore.kernel.org/r/20211227164317.4146918-1-schnelle@linux.ibm.com
   Base: not specified
	 git am m/20211227_schnelle_kconfig_introduce_has_ioport_and_legacy_pci_options.mbx
  10:30:32 ~/linux (wip/niklas)$ git am m/20211227_schnelle_kconfig_introduce_has_ioport_and_legacy_pci_options.mbx
  Applying: Kconfig: introduce and depend on LEGACY_PCI
  Applying: Kconfig: introduce HAS_IOPORT option and select it as necessary
  Applying: ACPI: Kconfig: add HAS_IOPORT dependencies
  Applying: parport: PC style parport depends on HAS_IOPORT
  Applying: char: impi, tpm: depend on HAS_IOPORT
  .git/rebase-apply/patch:92: trailing whitespace.
	    If you have a TPM security chip from Atmel say Yes and it
  .git/rebase-apply/patch:93: trailing whitespace.
	    will be accessible from within Linux.  To compile this driver
  warning: 2 lines add whitespace errors.
  Applying: speakup: Kconfig: add HAS_IOPORT dependencies
  Applying: Input: gameport: add ISA and HAS_IOPORT dependencies
  Applying: comedi: Kconfig: add HAS_IOPORT dependencies
  Applying: sound: Kconfig: add HAS_IOPORT dependencies
  Applying: i2c: Kconfig: add HAS_IOPORT dependencies
  Applying: Input: Kconfig: add HAS_IOPORT dependencies
  Applying: iio: adc: Kconfig: add HAS_IOPORT dependencies
  Applying: hwmon: Kconfig: add HAS_IOPORT dependencies
  Applying: leds: Kconfig: add HAS_IOPORT dependencies
  Applying: media: Kconfig: add HAS_IOPORT dependencies
  Applying: misc: handle HAS_IOPORT dependencies
  Applying: net: Kconfig: add HAS_IOPORT dependencies
  Applying: pcmcia: Kconfig: add HAS_IOPORT dependencies
  Applying: platform: Kconfig: add HAS_IOPORT dependencies
  Applying: pnp: Kconfig: add HAS_IOPORT dependencies
  Applying: power: Kconfig: add HAS_IOPORT dependencies
  Applying: video: handle HAS_IOPORT dependencies
  .git/rebase-apply/patch:23: trailing whitespace.

  warning: 1 line adds whitespace errors.
  Applying: rtc: Kconfig: add HAS_IOPORT dependencies
  Applying: scsi: Kconfig: add HAS_IOPORT dependencies
  Applying: watchdog: Kconfig: add HAS_IOPORT dependencies
  Applying: drm: handle HAS_IOPORT dependencies
  Applying: PCI/sysfs: make I/O resource depend on HAS_IOPORT
  Applying: PCI: make quirk using inw() depend on HAS_IOPORT
  Applying: firmware: dmi-sysfs: handle HAS_IOPORT dependencies
  Applying: /dev/port: don't compile file operations without CONFIG_DEVPORT
  Applying: usb: handle HAS_IOPORT dependencies
  Applying: asm-generic/io.h: drop inb() etc for HAS_IOPORT=n
  10:30:55 ~/linux (wip/niklas)$
