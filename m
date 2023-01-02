Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8E565AD06
	for <lists+linux-arch@lfdr.de>; Mon,  2 Jan 2023 05:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjABEQa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 1 Jan 2023 23:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABEQ3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 1 Jan 2023 23:16:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964E9EAE;
        Sun,  1 Jan 2023 20:16:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2237860DEF;
        Mon,  2 Jan 2023 04:16:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B4FC433D2;
        Mon,  2 Jan 2023 04:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672632986;
        bh=PbOa+zgeHMYDcl2ey0zsaINIrw5jd8rI1I/q7iKwxok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H12XXjoUpq7h6gyIHassmpAQU/kHiPF6Q9Z8JFur0P+G4+fRpPXSomZQJGvw8zOr2
         0FbfjlbD+mYcNErHjCQBIfLnpn5BiOHbFCNX6SDxp4MHG/bshA610Nxrld5X6Xkgx9
         +phkkTt2c0jlch2f2Um0OYyNqrXTgIkeybWZlMIPMKsIrj8rfjvfuYbVGfS/kngHrd
         HQlyFYRQ7nbtKoOHHpJv9GrDOsXdNBHw6gEn+NGFBgQcHBBJ4Pm6GjwGPhifLl88Qx
         PdaI67ZWgCURdaIbgoyZwscf6edoPRuCJ4FhJ5X03S2k56Eqbr/nHucl8SjjVbmkoP
         Z0S1E145fqr8w==
Date:   Sun, 1 Jan 2023 21:16:23 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Dennis Gilmore <dennis@ausil.us>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, llvm@lists.linux.dev
Subject: Re: [PATCH v2] arch: fix broken BuildID for arm64 and riscv
Message-ID: <Y7Jal56f6UBh1abE@dev-arch.thelio-3990X>
References: <20221226184537.744960-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221226184537.744960-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Masahiro,

On Tue, Dec 27, 2022 at 03:45:37AM +0900, Masahiro Yamada wrote:
> Dennis Gilmore reports that the BuildID is missing in the arm64 vmlinux
> since commit 994b7ac1697b ("arm64: remove special treatment for the
> link order of head.o").
> 
> The issue is that the type of .notes section, which contains the BuildID,
> changed from NOTES to PROGBITS.
> 
> Ard Biesheuvel figured out that whichever object gets linked first gets
> to decide the type of a section. The PROGBITS type is the result of the
> compiler emitting .note.GNU-stack as PROGBITS rather than NOTE.
> 
> While Ard provided a fix for arm64, I want to fix this globally because
> the same issue is happening on riscv since commit 2348e6bf4421 ("riscv:
> remove special treatment for the link order of head.o"). This problem
> will happen in general for other architectures if they start to drop
> unneeded entries from scripts/head-object-list.txt.
> 
> Discard .note.GNU-stack in include/asm-generic/vmlinux.lds.h.
> 
> Link: https://lore.kernel.org/lkml/CAABkxwuQoz1CTbyb57n0ZX65eSYiTonFCU8-LCQc=74D=xE=rA@mail.gmail.com/
> Fixes: 994b7ac1697b ("arm64: remove special treatment for the link order of head.o")
> Fixes: 2348e6bf4421 ("riscv: remove special treatment for the link order of head.o")
> Reported-by: Dennis Gilmore <dennis@ausil.us>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> Changes in v2:
>   - discard .note.GNU-stack before .notes because many architectures
>     call DISCARDS at the end of their linker scripts
> 
>  include/asm-generic/vmlinux.lds.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index a94219e9916f..659bf3b31c91 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -891,7 +891,12 @@
>  #define PRINTK_INDEX
>  #endif
>  
> +/*
> + * Discard .note.GNU-stack, which is emitted as PROGBITS by the compiler.
> + * Otherwise, the type of .notes section would become PROGBITS instead of NOTES.
> + */
>  #define NOTES								\
> +	/DISCARD/ : { *(.note.GNU-stack) }				\
>  	.notes : AT(ADDR(.notes) - LOAD_OFFSET) {			\
>  		BOUNDED_SECTION_BY(.note.*, _notes)			\
>  	} NOTES_HEADERS							\
> -- 
> 2.34.1
> 
> 

I just bisected this change as the cause of a few link failures that we
now see in CI with Debian's binutils (2.35.2):

https://storage.tuxsuite.com/public/clangbuiltlinux/continuous-integration2/builds/2Jjl88DXc3YRi2RtvXAzlS8NQ4p/build.log

This does not appear to be related to clang/LLVM because I can easily
reproduce it with Debian's s390x GCC and binutils building defconfig:

$ s390x-linux-gnu-gcc --version | head -1
s390x-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110

$ s390x-linux-gnu-ld --version | head -1
GNU ld (GNU Binutils for Debian) 2.35.2

$ make -skj"$(nproc)" ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- O=build mrproper defconfig all
...
`.exit.text' referenced in section `.s390_return_reg' of fs/jbd2/journal.o: defined in discarded section `.exit.text' of fs/jbd2/journal.o
`.exit.text' referenced in section `__jump_table' of fs/fuse/inode.o: defined in discarded section `.exit.text' of fs/fuse/inode.o
`.exit.text' referenced in section `__jump_table' of fs/fuse/inode.o: defined in discarded section `.exit.text' of fs/fuse/inode.o
`.exit.text' referenced in section `.s390_indirect_call' of fs/btrfs/super.o: defined in discarded section `.exit.text' of fs/btrfs/super.o
`.exit.text' referenced in section `.s390_return_mem' of fs/btrfs/super.o: defined in discarded section `.exit.text' of fs/btrfs/super.o
`.exit.text' referenced in section `.s390_return_mem' of fs/btrfs/volumes.o: defined in discarded section `.exit.text' of fs/btrfs/volumes.o
`.exit.text' referenced in section `.s390_return_mem' of fs/btrfs/volumes.o: defined in discarded section `.exit.text' of fs/btrfs/volumes.o
`.exit.text' referenced in section `__bug_table' of crypto/algboss.o: defined in discarded section `.exit.text' of crypto/algboss.o
`.exit.text' referenced in section `.s390_return_mem' of crypto/algboss.o: defined in discarded section `.exit.text' of crypto/algboss.o
`.exit.text' referenced in section `.s390_return_reg' of crypto/xor.o: defined in discarded section `.exit.text' of crypto/xor.o
`.exit.text' referenced in section `.s390_return_reg' of lib/atomic64_test.o: defined in discarded section `.exit.text' of lib/atomic64_test.o
`.exit.text' referenced in section `.s390_return_mem' of drivers/char/tpm/tpm-dev-common.o: defined in discarded section `.exit.text' of drivers/char/tpm/tpm-dev-common.o
`.exit.text' referenced in section `.s390_return_mem' of drivers/char/tpm/tpm-dev-common.o: defined in discarded section `.exit.text' of drivers/char/tpm/tpm-dev-common.o
`.exit.text' referenced in section `.s390_return_mem' of drivers/scsi/sd.o: defined in discarded section `.exit.text' of drivers/scsi/sd.o
`.exit.text' referenced in section `.altinstructions' of drivers/md/md.o: defined in discarded section `.exit.text' of drivers/md/md.o
`.exit.text' referenced in section `.altinstructions' of drivers/md/md.o: defined in discarded section `.exit.text' of drivers/md/md.o
`.exit.text' referenced in section `.s390_indirect_call' of drivers/md/dm.o: defined in discarded section `.exit.text' of drivers/md/dm.o
`.exit.text' referenced in section `.s390_return_reg' of net/802/psnap.o: defined in discarded section `.exit.text' of net/802/psnap.o
`.exit.text' referenced in section `.altinstructions' of net/iucv/iucv.o: defined in discarded section `.exit.text' of net/iucv/iucv.o
`.exit.text' referenced in section `__bug_table' of drivers/s390/cio/qdio_thinint.o: defined in discarded section `.exit.text' of drivers/s390/cio/qdio_thinint.o
`.exit.text' referenced in section `.s390_return_mem' of drivers/s390/block/dasd_diag.o: defined in discarded section `.exit.text' of drivers/s390/block/dasd_diag.o
`.exit.text' referenced in section `.s390_return_mem' of drivers/s390/char/tty3270.o: defined in discarded section `.exit.text' of drivers/s390/char/tty3270.o
`.exit.text' referenced in section `__bug_table' of drivers/s390/net/qeth_l3_main.o: defined in discarded section `.exit.text' of drivers/s390/net/qeth_l3_main.o
`.exit.text' referenced in section `__bug_table' of drivers/s390/net/qeth_l3_main.o: defined in discarded section `.exit.text' of drivers/s390/net/qeth_l3_main.o
s390x-linux-gnu-ld: BFD (GNU Binutils for Debian) 2.35.2 assertion fail ../../bfd/elf64-s390.c:3349
...

I ended up bisecting binutils for the fix, as I could not reproduce it
with 2.36+. My bisect landed on commit 21401fc7bf6 ("Duplicate output
sections in scripts"):

https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=21401fc7bf67dbf73f4a3eda4bcfc58fa4211584

Unfortunately, I cannot immediately grok why this commit cause the above
issue nor why the binutils commit resolves it so I figured I would
immediately report it for public investigation's sake and quicker
resolution.

Cheers,
Nathan
