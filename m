Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B3646A88E
	for <lists+linux-arch@lfdr.de>; Mon,  6 Dec 2021 21:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349484AbhLFUlF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Dec 2021 15:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245082AbhLFUlF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Dec 2021 15:41:05 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5CDC061746;
        Mon,  6 Dec 2021 12:37:36 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id v1so48107038edx.2;
        Mon, 06 Dec 2021 12:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zBLblKeg8CrULqFWVj7RAzFZmXmOvswPlK8gAVXpGvQ=;
        b=j4VEo5eVw1TtR0YsSabgZhAtbGEv6dWXafQlQs99qr1BPHoPLjjZ1fdWfnPVndnpii
         ebdq0ugWlyjmCQ4o27jqzmg/n5UUixZsG/vb4lH6DsoQoZXkAESKIwBiNjSLnAdeRtuc
         NvemIycmd820mZDlWH6BYGMkNj4KMVa78s+SbEyK/f8TVFuLi5G6WK1G9lTzPk0ZUt4U
         4fpbHdGd7AaqHwgOIa/NsNydocrNsPaVByELqK8k71S7/mVwZK/hzVfe1zyA76WQ2DMQ
         X1Hds3ZACRDogFxy6vi3gNA3YPjFJ+dA7UzfSyGgSumgCPdexmsKJjcZhlEvxkSvCeop
         YBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=zBLblKeg8CrULqFWVj7RAzFZmXmOvswPlK8gAVXpGvQ=;
        b=hGG1raoYIyt3bURn6KOBnLqU/HouNyWV3tnHlPtt/VK87vyiHkradG4D6kFeJXOj/F
         keyoirBk7scGF/mFWH3BvV4MpeZLFYULxoMhPVk4e5BWSR5UPev8HV1CCT6di1yFSpW9
         mIWv6XGshyn8azbkpYDRXr5RNTY2jQcH1UL7AypxR/xUhZ0jOQjKeA0lWIrBrXj+PPyy
         /iEWJiCGVwo7KveIZhsmht1NXUmLB8WyEqiK+Vz6/ASnaz7QQm9JxNHIOgiKDx7pC3J1
         e5/0XJwGnH4BpVnkFpLlxUUEebsEJnI3/QZCLM1sFkHAHAaOEyeVy1cSBFVBSCKXWrXF
         lYEA==
X-Gm-Message-State: AOAM533GtCr2ddDZrAC5Qz3o4i7qvQO2kd3ybJBlt1t+ofMRrE3K4xWL
        /oriFa0oipPZ/FyMrn45VUw=
X-Google-Smtp-Source: ABdhPJzrgo0Xi3nmEuzmb1ho2OIxbrUIKWnzhLf3x7/W+hp+MPI/n3GrzxQc508pMJcPgQlhyuhEbg==
X-Received: by 2002:a17:906:1396:: with SMTP id f22mr48685989ejc.228.1638823054885;
        Mon, 06 Dec 2021 12:37:34 -0800 (PST)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id x22sm7091350ejc.97.2021.12.06.12.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 12:37:34 -0800 (PST)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     Ley Foon Tan <lftan.linux@gmail.com>,
        Matteo Croce <mcroce@linux.microsoft.com>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        Bin Meng <bmeng.cn@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Guo Ren <guoren@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 3/3] riscv: optimized memset
Date:   Mon,  6 Dec 2021 21:37:03 +0100
Message-Id: <20211206203703.67597-1-kernel@esmil.dk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAFiDJ5-OJzWWR0hSZDsuAmxzxTE7cRR9Bsetpfh5vvrTxzkKPw@mail.gmail.com>
References: <CAFiDJ5-OJzWWR0hSZDsuAmxzxTE7cRR9Bsetpfh5vvrTxzkKPw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Ley Foon,

You're right it doesn't boot for me either when building with

  make ARCH=riscv LLVM=1

The following patch fixes it for me though. In hindsigt it's perhaps a
bit surprising it works without -ffreestanding in GCC.

/Emil

---
 arch/riscv/lib/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index e33263cc622a..6dfa919d4cd6 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -4,4 +4,9 @@ lib-$(CONFIG_MMU)	+= uaccess.o
 lib-$(CONFIG_64BIT)	+= tishift.o
 lib-$(CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE) += string.o
 
+# string.o implements standard library functions like memset/memcpy etc.
+# Use -ffreestanding to ensure that the compiler does not try to "optimize"
+# them into calls to themselves.
+CFLAGS_string.o := -ffreestanding
+
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
-- 
2.34.1

