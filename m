Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5C022E781
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2019 23:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfE2VhN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 May 2019 17:37:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46325 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfE2VhN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 May 2019 17:37:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id r7so2729863wrr.13;
        Wed, 29 May 2019 14:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Z/j/DHIs2LqXKNaoMidLfEH1GNjBTo+f8bWLzrCEysU=;
        b=Bv1ATfN1zsW6uwRy1fi6lD0r6158DlYKWB1iHSlxbtZLTCLWO48hXOcjLTsvfukM0c
         uZc4mQN63CrBjtfNEUsMTEtqpBcbKwC8WvG/VJpaOnQtqewPJV/WX9/R+IRegg7koMZr
         VkzIgnSs2A2SdDmY9ufjuzDt0yG6U+rt+L5orEXCmkmyNfXJJ9F2rKialWY+BzlZz4qQ
         HZ7dcmKvt2ZEC1dnGoxlgH+zq2w5L/QqStA145O3dGzkb3aPy111zy6YvwuF5HLgl3gz
         9p+hUA9e5didovXiUbxrZ36gTbwPScINaO+bhd1EDrizJQbqTRxhKWnsLyKiAdXU9DjR
         xtsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Z/j/DHIs2LqXKNaoMidLfEH1GNjBTo+f8bWLzrCEysU=;
        b=SZT2aKqYn5zrJEWvq9t0WIoPmTmibX1bKJ7PpeaaammIkW0b9BR4cBpgbjQJxHS8hX
         qbC91okrs7McV3Oywq5cz/pzKs8dgPewMouiUJ50so3rStNxKcWG2JtcLSqbMneJGQx0
         eLfl3Hmlbf1KQtfiYkiMLbr6Tx7HuuB8shiRDcSf4UKl0Uz6BwGNxVnpy51IW3JnY8Iy
         FXT2NYVvscRMZead9fnW5Oe7+wHD3SFM3o5t9m6Mw8FNxWvs3zKiOn8Mif61o+pe6PIu
         hUpZiHvh37EYL0g5tJph7jkcGl1Oetg+SZLXkiWeVFeX5aaoe6N0GsvuSaEFuIUEhPzb
         0hkQ==
X-Gm-Message-State: APjAAAWKPBHHJ77mtwoJLikU6V2d+KEGn+GXGJS95bdrLLeAOy1zxo1R
        mqMWM2yQxZNyGcLEHa4Jdgybdg8=
X-Google-Smtp-Source: APXvYqz5Xs2abGWOV1nrmofmFEGyNuelZ+2JOzdItYbOs4FrMLpP6BFT+kh/GE1JcLfJTv/k9T06/A==
X-Received: by 2002:a5d:4fc1:: with SMTP id h1mr105094wrw.323.1559165831399;
        Wed, 29 May 2019 14:37:11 -0700 (PDT)
Received: from avx2 ([46.53.251.224])
        by smtp.gmail.com with ESMTPSA id 67sm1083679wmd.38.2019.05.29.14.37.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 14:37:10 -0700 (PDT)
Date:   Thu, 30 May 2019 00:37:08 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH] elf: align AT_RANDOM bytes
Message-ID: <20190529213708.GA10729@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

AT_RANDOM content is always misaligned on x86_64:

	$ LD_SHOW_AUXV=1 /bin/true | grep AT_RANDOM
	AT_RANDOM:       0x7fff02101019

glibc copies first few bytes for stack protector stuff, aligned
access should be slightly faster.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -144,11 +144,15 @@ static int padzero(unsigned long elf_bss)
 #define STACK_ALLOC(sp, len) ({ \
 	elf_addr_t __user *old_sp = (elf_addr_t __user *)sp; sp += len; \
 	old_sp; })
+#define STACK_ALIGN(sp, align)	\
+	((typeof(sp))(((unsigned long)sp + (int)align - 1) & ~((int)align - 1)))
 #else
 #define STACK_ADD(sp, items) ((elf_addr_t __user *)(sp) - (items))
 #define STACK_ROUND(sp, items) \
 	(((unsigned long) (sp - items)) &~ 15UL)
 #define STACK_ALLOC(sp, len) ({ sp -= len ; sp; })
+#define STACK_ALIGN(sp, align)	\
+	((typeof(sp))((unsigned long)sp & ~((int)align - 1)))
 #endif
 
 #ifndef ELF_BASE_PLATFORM
@@ -217,6 +221,12 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
 			return -EFAULT;
 	}
 
+	/*
+	 * glibc copies first bytes for stack protector purposes
+	 * which are misaligned on x86_64 because strlen("x86_64") + 1 == 7.
+	 */
+	p = STACK_ALIGN(p, sizeof(long));
+
 	/*
 	 * Generate 16 random bytes for userspace PRNG seeding.
 	 */
