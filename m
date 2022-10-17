Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC9B60163A
	for <lists+linux-arch@lfdr.de>; Mon, 17 Oct 2022 20:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiJQS0x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Oct 2022 14:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiJQS0x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Oct 2022 14:26:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6D574CE6;
        Mon, 17 Oct 2022 11:26:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A844AB819FA;
        Mon, 17 Oct 2022 18:26:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BCDC433C1;
        Mon, 17 Oct 2022 18:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666031209;
        bh=1fRKVnmiM1x9FUiqzmh5+HsRy4dUfT6dd5kHN8AI6kI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zgs/T2HtU86tZLbGvtfJ/hTY1PMW34bO3QyqQbU5BuPMVfzZgwDUy66COu9nC7tOl
         gD6bubDK9kF2/OKDVwMw4K2ymrspBLbtlC3uc+f5EtPtdqFzFAkag8fMDHYlnV3ilX
         usmGNnfcjc/6ecITc/jYoQV5Kv36euaKKB6cWq+nXE2iLx8IA9/2h03/f6J+6G4umu
         RpNXslAKOK2d8J8p+j37Q0JsTdROWjUlUZm9J9VFHHumkgbkb0xlRovnROMqSJLRu0
         Ulj1RclYhwnv74PTW0nDYDhN1j7micCFzHQSLUWzbrDdo5c/n6uOkNJ+l2DT+nLZU9
         3cXSq2lVgFcJw==
Date:   Mon, 17 Oct 2022 11:26:47 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Li, Xin3" <xin3.li@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "H.Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org
Subject: Re: upgrade the orphan section warning to a hard link error
Message-ID: <Y02eZ6A/vlj8+B/c@dev-arch.thelio-3990X>
References: <BN6PR1101MB216105D169D482FC8C539059A8269@BN6PR1101MB2161.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR1101MB216105D169D482FC8C539059A8269@BN6PR1101MB2161.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Xin,

On Sun, Oct 16, 2022 at 06:28:27AM +0000, Li, Xin3 wrote:
> Arch maintainers,
> 
> We plan to upgrade the orphan section warning to a hard link error on x86.
> And I found the most recent related commit 59612b24f78a0
> ("kbuild: Hoist '--orphan-handling' into Kconfig") from by Nathan Chancellor
> has the following statement in the help section:
>  
> +config ARCH_WANT_LD_ORPHAN_WARN
> +       bool
> +       help
> +         An arch should select this symbol once all linker sections are explicitly
> +         included, size-asserted, or discarded in the linker scripts. This is
> +         important because we never want expected sections to be placed heuristically
> +         by the linker, since the locations of such sections can change between linker
> +         versions.
> +

+ Kees, who did the heavy lifting to enable '--orphan-handling=warn' for
arm64 and x86, and the ClangBuiltLinux and linux-kbuild mailing lists.
Unfortunately, for some reason, I do not see the original posting on
lore but I left the full message intact for further discussion.

> It looks to me that it actually suggests a link error rather than a warning,
> so the question is, should we do the upgrade on all architectures with
> the orphan section warning?

It might be interesting to turn orphan sections into an error if
CONFIG_WERROR is set. Perhaps something like the following (FYI, not
even compile tested)?

diff --git a/Makefile b/Makefile
index 0837445110fc..485f47fc2c07 100644
--- a/Makefile
+++ b/Makefile
@@ -1119,7 +1119,7 @@ endif
 # We never want expected sections to be placed heuristically by the
 # linker. All sections should be explicitly named in the linker script.
 ifdef CONFIG_LD_ORPHAN_WARN
-LDFLAGS_vmlinux += --orphan-handling=warn
+LDFLAGS_vmlinux += --orphan-handling=$(if $(CONFIG_WERROR),error,warn)
 endif
 
 # Align the bit size of userspace programs with the kernel

Outright turning the warning into an error with no escape hatch might be
too aggressive, as we have had these warnings triggered by new compiler
generated sections, such as in commit 848378812e40 ("vmlinux.lds.h:
Handle clang's module.{c,d}tor sections"). Unconditionally breaking the
build in these situations is unfortunate but the warnings do need to be
dealt with so I think having it error by default with the ability to
opt-out is probably worth doing. I do not have a strong opinion though.

> BTW, the following architectures enable orphan section warning,
> arm/arm64/hexagon/loongarch/mips/	powerpc/x86,
> while all other architectures just ignore it.

Right, every architecture should eventually select
CONFIG_ARCH_WANT_LD_ORPHAN_WARN so that they get this warning as well.
It is just making architecture maintainers aware of it so they can look
into it.

Cheers,
Nathan
