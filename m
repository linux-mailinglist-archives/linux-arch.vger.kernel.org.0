Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15B353B97E
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jun 2022 15:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbiFBNL4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jun 2022 09:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbiFBNLz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jun 2022 09:11:55 -0400
X-Greylist: delayed 475 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Jun 2022 06:11:53 PDT
Received: from sym2.noone.org (sym.noone.org [IPv6:2a01:4f8:120:4161::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF351EB6
        for <linux-arch@vger.kernel.org>; Thu,  2 Jun 2022 06:11:53 -0700 (PDT)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4LDR6N62M9zvjhW; Thu,  2 Jun 2022 15:03:56 +0200 (CEST)
Date:   Thu, 2 Jun 2022 15:03:56 +0200
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        rppt@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] riscv: Wire up memfd_secret in UAPI header
Message-ID: <20220602130355.y4npvxm3wegnwjpp@distanz.ch>
References: <20220505084611.tut66faep5r37r6c@distanz.ch>
 <mhng-671a8d6b-c318-431b-b209-c6bde465a420@palmer-ri-x1c9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-671a8d6b-c318-431b-b209-c6bde465a420@palmer-ri-x1c9>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2022-06-02 at 07:57:21 +0200, Palmer Dabbelt <palmer@dabbelt.com> wrote:
> On Thu, 05 May 2022 01:46:11 PDT (-0700), tklauser@distanz.ch wrote:
> > On 2022-05-05 at 10:18:15 +0200, Tobias Klauser <tklauser@distanz.ch> wrote:
> > > Move the __ARCH_WANT_MEMFD_SECRET define added in commit 7bb7f2ac24a0
> > > ("arch, mm: wire up memfd_secret system call where relevant") to
> > > <uapi/asm/unistd.h> so __NR_memfd_secret is defined when including
> > > <unistd.h> in userspace.
> > > 
> > > This allows the memds_secret selftest to pass on riscv.
> >                   ^- this should say memfd_secret
> > 
> > I can fix it up in a v2 if needed.
> 
> No big deal, I don't mind squashing stuff like that.  This is on for-next
> (no fixes, I'm still on 5.19).  I added
> 
> Fixes: 7bb7f2ac24a0 ("arch, mm: wire up memfd_secret system call where relevant")
> Cc: stable@vger.kernel.org
> 
> but LMK if you think that's wrong for some reason.

All of the above sounds good to me. Thank you!
