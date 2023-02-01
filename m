Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221976864B9
	for <lists+linux-arch@lfdr.de>; Wed,  1 Feb 2023 11:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjBAKun (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Feb 2023 05:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjBAKum (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Feb 2023 05:50:42 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 156A25B97;
        Wed,  1 Feb 2023 02:50:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F064F2F4;
        Wed,  1 Feb 2023 02:51:22 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.12.10])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C84A33F882;
        Wed,  1 Feb 2023 02:50:38 -0800 (PST)
Date:   Wed, 1 Feb 2023 10:50:33 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>,
        Dinh Nguyen <dinguyen@kernel.org>,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCHSET] VM_FAULT_RETRY fixes
Message-ID: <Y9pD+TMP+/SyfeJm@FVFF77S0Q05N>
References: <Y9lz6yk113LmC9SI@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9lz6yk113LmC9SI@ZenIV>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 31, 2023 at 08:02:51PM +0000, Al Viro wrote:
> On x86 it had been noticed and fixed back in 2014, in 26178ec11ef3 "x86:
> mm: consolidate VM_FAULT_RETRY handling".  Some of the other architectures
> had it dealt with later - e.g. arm in 2017, the fix is 746a272e44141
> "ARM: 8692/1: mm: abort uaccess retries upon fatal signal"; xtensa -
> in 2021, the fix is 7b9acbb6aad4f "xtensa: fix uaccess-related livelock
> in do_page_fault", etc.
> 
> However, it never had been done on a bunch of architectures - the
> current mainline still has that bug on alpha, hexagon, itanic, m68k,
> microblaze, nios2, openrisc, parisc, riscv and sparc (both sparc32 and
> sparc64).  Fixes are trivial, but I've no way to test them for most
> of those architectures.

FWIW, when I fixed arm and arm64 back in 2017, I did report the issue here with
a test case (and again in 2021, with maintainers all explciitly Cc'd):

  https://lore.kernel.org/lkml/20170822102527.GA14671@leverpostej/
  https://lore.kernel.org/linux-arch/20210121123140.GD48431@C02TD0UTHF1T.local/

... so if anyone has access to those architectures, that test might be useful
for verifying the fix.

Thanks,
Mark.
