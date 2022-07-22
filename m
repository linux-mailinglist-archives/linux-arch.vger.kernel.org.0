Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EBD57E9EC
	for <lists+linux-arch@lfdr.de>; Sat, 23 Jul 2022 00:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbiGVWmQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Jul 2022 18:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236916AbiGVWmE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Jul 2022 18:42:04 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5EC3713E2E;
        Fri, 22 Jul 2022 15:41:55 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 5D6F792009C; Sat, 23 Jul 2022 00:41:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 598B392009B;
        Fri, 22 Jul 2022 23:41:54 +0100 (BST)
Date:   Fri, 22 Jul 2022 23:41:54 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Rob Herring <robh@kernel.org>
cc:     Arnd Bergmann <arnd@arndb.de>, Palmer Dabbelt <palmer@dabbelt.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stafford Horne <shorne@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-um <linux-um@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] asm-generic: Add new pci.h and use it
In-Reply-To: <CAL_JsqKZoru2VZLeovPnQWe01ZMdw0krq0tcPx1O6YFUKa-L0g@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2207222328230.48997@angie.orcam.me.uk>
References: <CAL_Jsq+_5-fhXddhxG2mr-4HD_brcKZExkZqvME1yEpa6dOGGg@mail.gmail.com> <mhng-7e3146ca-79b8-4e16-98a9-e354fb6d03ba@palmer-mbp2014> <CAL_JsqJHZEcnJi+UHQbYWVoy1okQjHSc9T377P1q8oOJnHBWFw@mail.gmail.com> <CAK8P3a2aTS74TG8F+cVHX969hMQHKP3Ai5V0h-m+GeAq6kq5pQ@mail.gmail.com>
 <CAL_JsqKZoru2VZLeovPnQWe01ZMdw0krq0tcPx1O6YFUKa-L0g@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 22 Jul 2022, Rob Herring wrote:

> P.S. I really wish I/O space would disappear completely.

 Some systems make it happen already, such as the POWER9 platform and its 
PHB4 host bridge (which doesn't handle PCIe TLP I/O read or write commands 
at all), however some PCI/e devices do require I/O space, such as IEEE 
1284 parallel port adapters.  Some PCI devices dating back as far as to 
1990s provide dual mapping of their resources via an I/O and a memory BAR 
both at a time, so we can choose which to use depending on circumstances.

 FWIW,

  Maciej
