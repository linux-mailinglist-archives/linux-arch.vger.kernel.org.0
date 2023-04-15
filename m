Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E246F0B1E
	for <lists+linux-arch@lfdr.de>; Thu, 27 Apr 2023 19:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244335AbjD0RmL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Apr 2023 13:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244281AbjD0RmK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Apr 2023 13:42:10 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B15EB5584;
        Thu, 27 Apr 2023 10:41:54 -0700 (PDT)
Received: from skinsburskii.localdomain (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2EDFA21C33DF;
        Thu, 27 Apr 2023 10:41:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2EDFA21C33DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1682617312;
        bh=tQBmtbcpqnp+RILjBR0oqwhW0pMzwxDvx3m4tXPmSeg=;
        h=Subject:From:Cc:Date:From;
        b=koFTR0U8zfUvb5Uc+C+Hbp/AJH8F6PVoyRgqvwqagczF7i9s34sgxAtQuetm20+XS
         5Qm+28Pt+pSiCHLtISTWzADXqXkirskMRFVFEdzGl5W3ecGwC3+rdF73jW6Ou0nhTs
         O5MdjQWqF4ihM7lRjxSdq9BjhqMcNktql7ZPF+I0=
Subject: [PATCH 0/7] Expect immutable pointer in virt_to_phys/isa_virt_to_bus
 prototypes
From:   Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     Matt Turner <mattst88@gmail.com>, x86@kernel.org,
        Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>,
        Borislav Petkov <bp@alien8.de>, linux-ia64@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        linux-kernel@vger.kernel.org, Brian Cain <bcain@quicinc.com>,
        linux-mips@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Omar Sandoval <osandov@fb.com>, Helge Deller <deller@gmx.de>,
        linuxppc-dev@lists.ozlabs.org, linux-hexagon@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Chris Down <chris@chrisdown.name>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Sat, 15 Apr 2023 04:17:19 -0700
Message-ID: <168155718437.13678.714141668943813263.stgit@skinsburskii.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,
        MISSING_HEADERS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This series is aimed to address compilation warnings when a constant pointer
is passed to virt_to_phys and isa_virt_to_bus functions:

  warning: passing argument 1 of ‘virt_to_phys’ discards ‘const’ qualifier from pointer target type
  warning: passing argument 1 of ‘isa_virt_to_bus’ discards ‘const’ qualifier from pointer target type

The change(s) is the same for all architectures, but it's split into a series on
per-arch basis to simplify applying and testing on the maintainers side.

The following series implements...

---

Stanislav Kinsburskii (7):
      x86: asm/io.h: Expect immutable pointer in virt_to_phys/isa_virt_to_bus prototypes
      alpha: asm/io.h: Expect immutable pointer in virt_to_phys/isa_virt_to_bus prototypes
      mips: asm/io.h: Expect immutable pointer in isa_virt_to_bus prototype
      hexagon: asm/io.h: Expect immutable pointer in virt_to_phys prototype
      ia64: asm/io.h: Expect immutable pointer in virt_to_phys prototype
      powerpc: asm/io.h: Expect immutable pointer in virt_to_phys prototype
      asm-generic/io.h: Expect immutable pointer in virt_to_phys


 arch/alpha/include/asm/io.h   |    6 +++---
 arch/hexagon/include/asm/io.h |    2 +-
 arch/ia64/include/asm/io.h    |    2 +-
 arch/mips/include/asm/io.h    |    2 +-
 arch/powerpc/include/asm/io.h |    2 +-
 arch/x86/include/asm/io.h     |    4 ++--
 include/asm-generic/io.h      |    2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)


