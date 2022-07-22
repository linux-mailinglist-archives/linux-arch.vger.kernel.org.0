Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F4657EA4A
	for <lists+linux-arch@lfdr.de>; Sat, 23 Jul 2022 01:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiGVXhJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Jul 2022 19:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiGVXhI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Jul 2022 19:37:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8608C5B3;
        Fri, 22 Jul 2022 16:37:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49FA9B82B1C;
        Fri, 22 Jul 2022 23:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC594C341C7;
        Fri, 22 Jul 2022 23:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658533025;
        bh=PJaGFQLRa9txN/olKBiKrgbs2T3hctN/egs90VvxxOE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WChINgofcA4PdmBLd1iw8dC6U0G4/Dlq1JSHtJ1xVewrVWtHtFTyT0SBrmG8eemkP
         7GMuoOIjDYkuaS17Hg2g2J51ofLPRzy+rRxUvmmlScn/GAi3YC2oEefGm2+xIFVdMG
         FNZkkpwMv6ox5i0ikKJUVcSRZhQPErqfkVGEE5HUehg5SQAkZb5saktik8FsNYMszn
         HAfLwmwFJk2rzF4iLdDyS8jgMFn1ux09kZlsMK8je2c/yW4zYcrJT7yPGFDKFhpJSk
         7lI3p1m3HPU2xoUrIppEInW+HPeOxiitEVNRQmXcJC8mIdtAbBu5wASR83uI40kw8+
         UR6JG+5zFIl1g==
Date:   Fri, 22 Jul 2022 18:37:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stafford Horne <shorne@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v5 4/4] asm-generic: Add new pci.h and use it
Message-ID: <20220722233703.GA1979513@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtsrJghwLPf3uj4W@antec>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jul 23, 2022 at 07:56:38AM +0900, Stafford Horne wrote:
> On Fri, Jul 22, 2022 at 05:31:46PM -0500, Bjorn Helgaas wrote:
> > On Sat, Jul 23, 2022 at 06:43:31AM +0900, Stafford Horne wrote:
> > 
> > > I will respin a v6 as we didn't get a reply on this.  Bjorn are you
> > > planning to apply the series before the upcoming merge window?
> > 
> > I see your v6, and I can apply it.  I only got patches 1, 2, 4
> > (without the csky patch).  Do you want that to go a separate route?  I
> > don't care either way, but not sure it improves things to split it
> > across trees.
> 
> I sent 3/4 directly to you now.  Hopefully you see it.
> 
> Patch 4/4 depends on it in a sense so its best to keep 3/4 together.

I saw 3/4 before because b4 found it, but I didn't know what you had
in mind.

I applied all 4 patches to pci/header-cleanup-immutable for v5.20.

It would be convenient if (in the future) you included a 0/n cover
letter where replies like this could go.

Bjorn
