Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 997841404CA
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jan 2020 09:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgAQIDk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jan 2020 03:03:40 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46836 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729375AbgAQIDj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jan 2020 03:03:39 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so21653122wrl.13
        for <linux-arch@vger.kernel.org>; Fri, 17 Jan 2020 00:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0dxc8QtGQ0PTjujap7aKZ1LJY+erIVhDCOoHmhzPCX8=;
        b=Lfol5RQlR3KGOLzmjrmaD4btTKkwlxLirjdWy1fMTWxNPqnZsyb0NOd7gB1DJ+c78g
         gF8D8lqSDpb3r1K6LZFEATwaKrWbUKBBoiTIAFVg8GHKi1MNG3xtrVcGWy5QQppXfflX
         9SR65wlDDiu/cxOLVjoy5ZXOeninl5K6F6d/z+RNnhAGcPh61N54/d/z3PlIyPrkzJqa
         kejynOqCGEeEBoItKELgRLMSr7jkFE34Jx/8dgu9pRJXEfWNg+LtWz0c3y0K35VcZGMx
         +AfwMfiuOkfoKJ8gx7/Gt8zUgOZR4KHqYRBgHDW1Fz2iHs9rWnydYd+kJFwzoTWR5qyQ
         NifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0dxc8QtGQ0PTjujap7aKZ1LJY+erIVhDCOoHmhzPCX8=;
        b=WOloMJOtKhBNg4eDdR8e95UzXQmSfMYCayBvmqu/qSLbo/Zvhh++yLPkKOwWzNs0bk
         XBnKpRsRf6cUQQlR6PNUAUtLNAPMuYoi67vsPEnJia3Ajt4+jas0T7Kn90OofttSvMpw
         K2ebkj1ZtmnvKCQMB6JPShyE+q2ArSZ0cs2Plcys3idH2o3eMZznQ901WE1vQVCM+s4D
         oye5pnpxN6FHaRDAoSr2QGtqVQSVL4DpDjwbpdQw/Ozw1YX1T3mn+tjLa8oVmavPJrMz
         OOYAstK7QBgBj0lr5jdEqnHlndiy+ypXfrJAb5709+2dIl0aeiP2zZDCwdoC4RA+cP2P
         lBJQ==
X-Gm-Message-State: APjAAAU+yXHp4NYokG3qGgVxtgUTk6hFMttyxHNQB8Phya4wo3gNQNC8
        8pIt4+NNlGSs47YWXOI+iIa14g==
X-Google-Smtp-Source: APXvYqyPIStCdr8O+woTvblUlJbT07zm348a3w9jixRcjfWMr8KNQCBHIGn8jgpPoYfAhE5mn3DrZg==
X-Received: by 2002:adf:ef49:: with SMTP id c9mr1770134wrp.292.1579248217005;
        Fri, 17 Jan 2020 00:03:37 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id c195sm3477036wmd.45.2020.01.17.00.03.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Jan 2020 00:03:36 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Christoph Hellwig <hch@lst.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Paul Burton <paulburton@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        linux-mips@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        x86@kernel.org, Guo Ren <guoren@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Wesley Terpstra <wesley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Chris Zankel <chris@zankel.net>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Vasily Gorbik <gor@linux.ibm.com>,
        James Hogan <jhogan@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH v2 1/2] asm-generic: Make dma-contiguous.h a mandatory include/asm header
Date:   Fri, 17 Jan 2020 09:03:31 +0100
Message-Id: <0274919c5e3b134df19d943f99cb7e84e5135ccd.1579248206.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1579248206.git.michal.simek@xilinx.com>
References: <cover.1579248206.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

dma-continuguous.h is generic for all architectures except arm32 which has
its own version.

Similar change was done for msi.h by commit a1b39bae16a6
("asm-generic: Make msi.h a mandatory include/asm header")

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- New patch suggested by Christoph

 arch/arm64/include/asm/Kbuild  | 1 -
 arch/csky/include/asm/Kbuild   | 1 -
 arch/mips/include/asm/Kbuild   | 1 -
 arch/riscv/include/asm/Kbuild  | 1 -
 arch/s390/include/asm/Kbuild   | 1 -
 arch/x86/include/asm/Kbuild    | 1 -
 arch/xtensa/include/asm/Kbuild | 1 -
 include/asm-generic/Kbuild     | 1 +
 8 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index bd23f87d6c55..d3077c991962 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -3,7 +3,6 @@ generic-y += bugs.h
 generic-y += delay.h
 generic-y += div64.h
 generic-y += dma.h
-generic-y += dma-contiguous.h
 generic-y += dma-mapping.h
 generic-y += early_ioremap.h
 generic-y += emergency-restart.h
diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
index 4d4754e6bf89..bc15a26c782f 100644
--- a/arch/csky/include/asm/Kbuild
+++ b/arch/csky/include/asm/Kbuild
@@ -7,7 +7,6 @@ generic-y += delay.h
 generic-y += device.h
 generic-y += div64.h
 generic-y += dma.h
-generic-y += dma-contiguous.h
 generic-y += dma-mapping.h
 generic-y += emergency-restart.h
 generic-y += exec.h
diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 61b0fc2026e6..179403ae5837 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -6,7 +6,6 @@ generated-y += syscall_table_64_n64.h
 generated-y += syscall_table_64_o32.h
 generic-y += current.h
 generic-y += device.h
-generic-y += dma-contiguous.h
 generic-y += emergency-restart.h
 generic-y += export.h
 generic-y += irq_work.h
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 1efaeddf1e4b..ec0ca8c6ab64 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -7,7 +7,6 @@ generic-y += div64.h
 generic-y += extable.h
 generic-y += flat.h
 generic-y += dma.h
-generic-y += dma-contiguous.h
 generic-y += dma-mapping.h
 generic-y += emergency-restart.h
 generic-y += exec.h
diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index 2531f673f099..1832ae6442ef 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -7,7 +7,6 @@ generated-y += unistd_nr.h
 generic-y += asm-offsets.h
 generic-y += cacheflush.h
 generic-y += device.h
-generic-y += dma-contiguous.h
 generic-y += dma-mapping.h
 generic-y += div64.h
 generic-y += emergency-restart.h
diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index 8b52bc5ddf69..ea34464d6221 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -7,7 +7,6 @@ generated-y += unistd_32_ia32.h
 generated-y += unistd_64_x32.h
 generated-y += xen-hypercalls.h
 
-generic-y += dma-contiguous.h
 generic-y += early_ioremap.h
 generic-y += export.h
 generic-y += mcs_spinlock.h
diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
index 3acc31e55e02..271917c24b7f 100644
--- a/arch/xtensa/include/asm/Kbuild
+++ b/arch/xtensa/include/asm/Kbuild
@@ -4,7 +4,6 @@ generic-y += bug.h
 generic-y += compat.h
 generic-y += device.h
 generic-y += div64.h
-generic-y += dma-contiguous.h
 generic-y += dma-mapping.h
 generic-y += emergency-restart.h
 generic-y += exec.h
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index ddfee1bd9dc1..cd17d50697cc 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -4,5 +4,6 @@
 # (This file is not included when SRCARCH=um since UML borrows several
 # asm headers from the host architecutre.)
 
+mandatory-y += dma-contiguous.h
 mandatory-y += msi.h
 mandatory-y += simd.h
-- 
2.25.0

