Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932A74FACA1
	for <lists+linux-arch@lfdr.de>; Sun, 10 Apr 2022 10:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbiDJIGg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 10 Apr 2022 04:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbiDJIGe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 10 Apr 2022 04:06:34 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EB4606E7
        for <linux-arch@vger.kernel.org>; Sun, 10 Apr 2022 01:04:24 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id i23-20020a9d6117000000b005cb58c354e6so9195418otj.10
        for <linux-arch@vger.kernel.org>; Sun, 10 Apr 2022 01:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=vS2s2qRevra2XEsFF3mSNB6jYFDG6iqb3Cu6xK44T5w=;
        b=Li9YdVUVqp0sNmfxs6nv4NNpyPzm8bGG/the7OIBqSo1JGcFhZWoNFg9lf2ROaUmFi
         3mz05iZGfTWperb7Ok/G4OK9Ta/MhLswL1/6cA9xfrjAiXQwyzL8uB0o2QLaHor3WpFW
         7QBD++pHwAqwowvS0S36bjTfpsEQM4FXy0orqj/kkVHDBp8MnKKBxu+LVw5CqSpMycIW
         Xmgn6R7fNGbYF7Z/l4lwQrOU/pHlj5sdVZkdHwOiYzW2BYYPymXAnCOqVUOE6H5zWas4
         pqA1iJ1wvsJUMu+4HhWhypqAG9jkVLeTyoJGlmI2j6WnXayocEjqm1bpyX7E3prjbrAW
         Z+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=vS2s2qRevra2XEsFF3mSNB6jYFDG6iqb3Cu6xK44T5w=;
        b=q5culdjh+M4O1oQRX5aBcqWstMDZpzgUpXAKhT3GLQBIKZiRvHjEeAFsbqPGdrXRRt
         HMs+ySis1/PlYxheiGOTZxw/v4zIXpUd9tDFXBwtJ3DUIjRns7s4nZuoaMdzDEZLhNHP
         lY7ubO+iLNOHtHx/JQFxw9S30Qvn/M8Ng1TfG+Jh5NBcF7H5lqFrSn54GaA8Ui8Hk/v5
         I02N1wz/+uDOl3x8tlQkBnash1OvR2lkWCkFLpXCwmWbptxCVLh0IQYoUZ9J1sCnHPY+
         +9ShtkoEpuBWMHOfYSuPM78IrJT0C9ZqJWPNODVy+nOgIAyKjgdyccKan0zz4wSVBm7s
         3Ntw==
X-Gm-Message-State: AOAM530BDclEHufDW6vpthuWs0NHKdZAJ/U6wozxEJxaXc6e/GJDZI3C
        qjUs6kSZ88WcghhmJ04uea3exg==
X-Google-Smtp-Source: ABdhPJwuUsxhMJlcTXCsTWUNi3Ca75DoosL6uhnW6f+xEXD95nBE4QwZrKmWdAfMv/HsKALTxrW2Aw==
X-Received: by 2002:a05:6830:82a:b0:5b2:36d5:1603 with SMTP id t10-20020a056830082a00b005b236d51603mr9400402ots.240.1649577864303;
        Sun, 10 Apr 2022 01:04:24 -0700 (PDT)
Received: from [192.168.224.179] ([172.58.198.202])
        by smtp.gmail.com with ESMTPSA id lh22-20020a0568700b1600b000e2ba035051sm762425oab.58.2022.04.10.01.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 01:04:23 -0700 (PDT)
Message-ID: <130c8036-208c-2f6b-999c-31b2e507ecb5@landley.net>
Date:   Sun, 10 Apr 2022 03:08:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [RFC PULL] remove arch/h8300
Content-Language: en-US
From:   Rob Landley <rob@landley.net>
To:     Greg Ungerer <gerg@linux-m68k.org>,
        Finn Thain <fthain@linux-m68k.org>
Cc:     Daniel Palmer <daniel@0x0f.com>, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Max Filippov <jcmvbkbc@gmail.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
References: <Yib9F5SqKda/nH9c@infradead.org>
 <CAK8P3a1dUVsZzhAe81usLSkvH29zHgiV9fhEkWdq7_W+nQBWbg@mail.gmail.com>
 <YkmWh2tss8nXKqc5@infradead.org>
 <CAK8P3a0QdFOJbM72geYTWOKumeKPSCVD8Nje5pBpZWazX0GEnQ@mail.gmail.com>
 <6a38e8b8-7ccc-afba-6826-cb6e4f92af83@linux-m68k.org>
 <CAFr9PXkk=8HOxPwVvFRzqHZteRREWxSOOcdjrcOPe0d=9AW2yQ@mail.gmail.com>
 <5b7687d4-8ba5-ad79-8a74-33fc2496a3db@linux-m68k.org>
 <8f9be869-7244-d92a-4683-f9c53da97755@landley.net>
 <3d5cf48c-94f1-2948-1683-4a2a87f4c697@linux-m68k.org>
 <147dc6cc-1fbb-558f-8e6d-29d4327d54b4@linux-m68k.org>
 <ae4125f5-e725-43ed-d05b-b1f88c0cd50c@landley.net>
In-Reply-To: <ae4125f5-e725-43ed-d05b-b1f88c0cd50c@landley.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/10/22 02:26, Rob Landley wrote:
>> FWIW this will do it:
>> 
>>      qemu-system-m68k -nographic -machine mcf5208evb -kernel vmlinux
>> 
>> That will boot an m5208evb_defconfig generated vmlinux.
>> But you will need a user space to get a full boot to login/shell.
> 
> No FDPIC support. :(

First stab at switching on CONFIG_BINFMT_FDPIC in the coldfire config and adding
enough stuff to shut up the compiler. Maybe it'll let me load a PIE binary?
Dunno yet, but it compiled a vmlinux that booted to the same panic as the
previous one because I haven't fed it an initramfs yet...

I also had to disable CONFIG_ELF_CORE or else the link died with:

m68k-linux-musl-ld: fs/binfmt_elf_fdpic.o: in function `elf_dump_thread_status':
binfmt_elf_fdpic.c:(.text+0x18): undefined reference to `task_user_regset_view'
make: *** [Makefile:1155: vmlinux] Error 1

But when I did THAT it compiled. :)

diff --git a/arch/m68k/include/asm/elf.h b/arch/m68k/include/asm/elf.h
index 3d387ceaea3f..bcb072396640 100644
--- a/arch/m68k/include/asm/elf.h
+++ b/arch/m68k/include/asm/elf.h
@@ -114,4 +114,6 @@ typedef struct user_m68kfp_struct elf_fpregset_t;

 #define ELF_PLATFORM  (NULL)

+#define ELF_FDPIC_CORE_EFLAGS 0
+
 #endif
diff --git a/arch/m68k/include/asm/mmu.h b/arch/m68k/include/asm/mmu.h
index 5c15aacb1370..6f6d83b731ed 100644
--- a/arch/m68k/include/asm/mmu.h
+++ b/arch/m68k/include/asm/mmu.h
@@ -8,6 +8,10 @@ typedef unsigned long mm_context_t;
 #else
 typedef struct {
 	unsigned long		end_brk;
+#ifdef CONFIG_BINFMT_ELF_FDPIC
+        unsigned long           exec_fdpic_loadmap;
+        unsigned long           interp_fdpic_loadmap;
+#endif
 } mm_context_t;
 #endif

diff --git a/arch/m68k/include/uapi/asm/ptrace.h
b/arch/m68k/include/uapi/asm/ptrace.h
index 19a1b9d0d858..869601381f30 100644
--- a/arch/m68k/include/uapi/asm/ptrace.h
+++ b/arch/m68k/include/uapi/asm/ptrace.h
@@ -71,6 +71,10 @@ struct switch_stack {
 #define PTRACE_SETREGS            13
 #define PTRACE_GETFPREGS          14
 #define PTRACE_SETFPREGS          15
+#define PTRACE_GETFDPIC           31
+
+#define PTRACE_GETFDPIC_EXEC      0
+#define PTRACE_GETFDPIC_INTERP    1

 #define PTRACE_GET_THREAD_AREA    25

diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 4d5ae61580aa..073360aa982c 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -45,7 +45,7 @@ config ARCH_USE_GNU_PROPERTY
 config BINFMT_ELF_FDPIC
 	bool "Kernel support for FDPIC ELF binaries"
 	default y if !BINFMT_ELF
-	depends on (ARM || (SUPERH && !MMU))
+	depends on (ARM || (SUPERH && !MMU) || M68K)
 	select ELFCORE
 	help
 	  ELF FDPIC binaries are based on ELF, but allow the individual load



Rob
