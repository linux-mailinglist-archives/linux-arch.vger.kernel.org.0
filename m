Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571EF57E9AB
	for <lists+linux-arch@lfdr.de>; Sat, 23 Jul 2022 00:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbiGVWbu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Jul 2022 18:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbiGVWbt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Jul 2022 18:31:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE91CA6FB6;
        Fri, 22 Jul 2022 15:31:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79ECA6220B;
        Fri, 22 Jul 2022 22:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B40C341C6;
        Fri, 22 Jul 2022 22:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658529107;
        bh=Fu/FeSpx214X/BoevcG6EdcLDKAQmFEJ4sg9DFLd4o4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZLV9f00xXHBEZYi6orEA7bLQq5EBmkjAC5OfsmVms59T4noJqnthFEJctnRQzcz0q
         saujHsxGUH2AqpZYlYrMt2cHABd3CBr66SzRuzUJFwWAD3cbyYVCMZbVjvwo/fepiF
         nMuA9fEXrGKvFb9oBxCYdvL5ZTl7fAmamCCjK8/pXWHEddPhcCmQIfU4N61F6zDLVV
         8mp5ksuEju114L04yVutuvqeopl1JZpmzw5RajfSgQybSjyVXJ/v+9IwcrzJlIA4f7
         zS3kqAW22nepuIGjCi9zt12w9Rh+H06irv2dok0IHfYI/phb0B5TDEr90WIHFpPN94
         B84Q/D5pLIURQ==
Date:   Fri, 22 Jul 2022 17:31:46 -0500
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
Message-ID: <20220722223146.GA1947394@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtsaA2Zjqa/XZZou@antec>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jul 23, 2022 at 06:43:31AM +0900, Stafford Horne wrote:

> I will respin a v6 as we didn't get a reply on this.  Bjorn are you
> planning to apply the series before the upcoming merge window?

I see your v6, and I can apply it.  I only got patches 1, 2, 4
(without the csky patch).  Do you want that to go a separate route?  I
don't care either way, but not sure it improves things to split it
across trees.

Bjorn
