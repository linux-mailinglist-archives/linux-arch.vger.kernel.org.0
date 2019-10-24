Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCCDE2E79
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2019 12:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405195AbfJXKNX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Oct 2019 06:13:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33954 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392022AbfJXKNX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Oct 2019 06:13:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id t16so20260260wrr.1
        for <linux-arch@vger.kernel.org>; Thu, 24 Oct 2019 03:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=E0Qq1lNGBY9K/n1HNDcbzQvafIKVtTjxua78199y0Ag=;
        b=OtTWbUvVOM2iwHQpoOwwI1UnAhJtD/y62mQMVMkoYZ3ww+sDiC0C3IVG9ZscaJrkgn
         NiBnR4njWxQei6rPGKV8+iiYVsHt2ZkE68QaPZeRekFJJQspWgxtS6/IwwKIn6NsCN8J
         dUAjvOWvpMN1FNiWpaIKhxe/aCKbqfL7L5fzqvitsDciXZIG0QmnNnfhZyca12TzIUwo
         S6yOHYEz+joDlgRS8h3Z15r3Gm3TikUIL52QNvB4841Y3Wzp9yWt6P821bKvL3wfbr42
         jxs0VqvaNcXG3yGTN28xAxP+cFltZXNyUMq9olcO2XQ03AfofbVSElP2koxuww1GtWEQ
         cesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=E0Qq1lNGBY9K/n1HNDcbzQvafIKVtTjxua78199y0Ag=;
        b=p1fkk8De4Jff/TrDRr86YAMql7LQPs7/24vkfYc9NdKTofgp3smEYz7PBa5b07g2um
         CaMUUdSA3RzZDLuC2jmQ8HKOGvWhtjBn85EuBwqksHVMyAEf4umLV2aZjzpgIBqHotMc
         JGYdrSHNmbJ2zIgOEqsDgWTrIcZrG6TOqKaDY7I9YO/eSXVpKfNA8uvv3xCJsYOpfCwW
         8oS4lOeiO3Sv9SJCBb01+Fg/Z+ianA9lsP0mAhwPwpITPjfSqSFi5gBTXBFDEFa5NZvY
         ddl6fIELCvpjngMFBSFhoN8mWJJXlE1UEoJubw5qX7e45s4CBqpoctSD0uafYZ0BmUKL
         WgNg==
X-Gm-Message-State: APjAAAVr9O7PAipyqdzcCbvU3wU/02CKBFDX/piqaUuFw07v0mgWRiSu
        1PfI1kuDQ7q5sAsFUtK5AUy2mg==
X-Google-Smtp-Source: APXvYqwsbNByeVpgsdT7AP1vJKjq5FS1kvH+EeS+2LruajwpjBeA7AqFH480WTXQmfmey1xz1ZMgAw==
X-Received: by 2002:adf:fd8a:: with SMTP id d10mr2894178wrr.368.1571912000848;
        Thu, 24 Oct 2019 03:13:20 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id f204sm1273607wmf.32.2019.10.24.03.13.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Oct 2019 03:13:20 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, palmer@sifive.com,
        hch@infradead.org, longman@redhat.com, helgaas@kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Jackie Liu <liuyun01@kylinos.cn>,
        Wesley Terpstra <wesley@sifive.com>,
        Firoz Khan <firoz.khan@linaro.org>, sparclinux@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        James Hogan <jhogan@kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Burton <paul.burton@mips.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-snps-arc@lists.infradead.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-mips@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] asm-generic: Make msi.h a mandatory include/asm header
Date:   Thu, 24 Oct 2019 12:13:11 +0200
Message-Id: <a021f232968cfffe3f2d838da47214c6bbdeeedb.1571911976.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571911976.git.michal.simek@xilinx.com>
References: <cover.1571911976.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1571911976.git.michal.simek@xilinx.com>
References: <cover.1571911976.git.michal.simek@xilinx.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

msi.h is generic for all architectures expect of x86 which has own version.
Enabling MSI by including msi.h to architecture Kbuild is just additional
step which doesn't need to be done.
The patch was created based on request to enable MSI for Microblaze.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

https://lore.kernel.org/linux-riscv/20191008154604.GA7903@infradead.org/
---
 arch/arc/include/asm/Kbuild     | 1 -
 arch/arm/include/asm/Kbuild     | 1 -
 arch/arm64/include/asm/Kbuild   | 1 -
 arch/mips/include/asm/Kbuild    | 1 -
 arch/powerpc/include/asm/Kbuild | 1 -
 arch/riscv/include/asm/Kbuild   | 1 -
 arch/sparc/include/asm/Kbuild   | 1 -
 include/asm-generic/Kbuild      | 1 +
 8 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
index 393d4f5e1450..1b505694691e 100644
--- a/arch/arc/include/asm/Kbuild
+++ b/arch/arc/include/asm/Kbuild
@@ -17,7 +17,6 @@ generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
 generic-y += mmiowb.h
-generic-y += msi.h
 generic-y += parport.h
 generic-y += percpu.h
 generic-y += preempt.h
diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index 68ca86f85eb7..fa579b23b4df 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -12,7 +12,6 @@ generic-y += local.h
 generic-y += local64.h
 generic-y += mm-arch-hooks.h
 generic-y += mmiowb.h
-generic-y += msi.h
 generic-y += parport.h
 generic-y += preempt.h
 generic-y += seccomp.h
diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index 98a5405c8558..bd23f87d6c55 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -16,7 +16,6 @@ generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
 generic-y += mmiowb.h
-generic-y += msi.h
 generic-y += qrwlock.h
 generic-y += qspinlock.h
 generic-y += serial.h
diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index c8b595c60910..61b0fc2026e6 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -13,7 +13,6 @@ generic-y += irq_work.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
-generic-y += msi.h
 generic-y += parport.h
 generic-y += percpu.h
 generic-y += preempt.h
diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index 64870c7be4a3..17726f2e46de 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -10,4 +10,3 @@ generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += preempt.h
 generic-y += vtime.h
-generic-y += msi.h
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 16970f246860..1efaeddf1e4b 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -22,7 +22,6 @@ generic-y += kvm_para.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mm-arch-hooks.h
-generic-y += msi.h
 generic-y += percpu.h
 generic-y += preempt.h
 generic-y += sections.h
diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index b6212164847b..62de2eb2773d 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -18,7 +18,6 @@ generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
 generic-y += mmiowb.h
 generic-y += module.h
-generic-y += msi.h
 generic-y += preempt.h
 generic-y += serial.h
 generic-y += trace_clock.h
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index adff14fcb8e4..ddfee1bd9dc1 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -4,4 +4,5 @@
 # (This file is not included when SRCARCH=um since UML borrows several
 # asm headers from the host architecutre.)
 
+mandatory-y += msi.h
 mandatory-y += simd.h
-- 
2.17.1

