Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84746F56E7
	for <lists+linux-arch@lfdr.de>; Wed,  3 May 2023 13:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjECLGv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 May 2023 07:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjECLGu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 May 2023 07:06:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8ABB49CC;
        Wed,  3 May 2023 04:06:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8050662CC1;
        Wed,  3 May 2023 11:06:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319CAC433D2;
        Wed,  3 May 2023 11:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683112007;
        bh=1Z/abXjYScbaeQJORhJfZ1yaBTS2vU/U1cufhR2GD0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DYeRD57ViS93rxSgHpAWB7YMqFMUVx8+EiMfSRn6yQEG7G9RSDQSNSSe1sxzZ3BLo
         GvrB3gAjIST0ilFZUg8IMfwBDx8wfH+KA+j3pBm5lWI8UmkhRuaPcCrBRvajh/kKlf
         sc97elHz9FlAP3leMT4UaefDRJMGkLzMHZE6FdoaOvmUUjuDHCL58u0eFmESKWCS4j
         iTu0lEr+kmh/c3tzKSar0Ap1ePkXfG5K61exCSLbCF+9ApT/2au8DOYFlhGDOEhdXg
         2pQvwMWVokBgoPnt+ruSQN7Puaw5HnfRo4DOOVEE3FkCyWkRa5+PjlZzOTI1BYYKE3
         QatkVXcriRXBA==
Date:   Wed, 3 May 2023 13:06:44 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org, Brian Cain <bcain@quicinc.com>,
        linux-hexagon@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        linux-openrisc@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] Remove HAVE_VIRT_CPU_ACCOUNTING_GEN option
Message-ID: <ZFJARBDqWPLSy7Ge@localhost.localdomain>
References: <20230429063348.125544-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230429063348.125544-1-npiggin@gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Le Sat, Apr 29, 2023 at 04:33:48PM +1000, Nicholas Piggin a écrit :
> This option was created in commit 554b0004d0ec4 ("vtime: Add
> HAVE_VIRT_CPU_ACCOUNTING_GEN Kconfig") for architectures to indicate
> they support the 64-bit cputime_t required for VIRT_CPU_ACCOUNTING_GEN.
> 
> The cputime_t type has since been removed, so this doesn't have any
> meaning. Remove it.

Well, cputime_t has disappeared but not the u64 type used
for task/cpu time accounting.

But now we have the vtime seqcount. Though we already had it
when we introduced that Kconfig switch so I can't remember why
this was necessary :-(

It _looks_ OK but I might be missing something...

Thanks.
