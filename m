Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C876756A8
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 15:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjATOM3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Jan 2023 09:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjATOLq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jan 2023 09:11:46 -0500
Received: from fx306.security-mail.net (smtpout30.security-mail.net [85.31.212.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC846C79D0
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 06:11:00 -0800 (PST)
Received: from localhost (fx306.security-mail.net [127.0.0.1])
        by fx306.security-mail.net (Postfix) with ESMTP id BB98A35CF57
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 15:10:28 +0100 (CET)
Received: from fx306 (fx306.security-mail.net [127.0.0.1]) by
 fx306.security-mail.net (Postfix) with ESMTP id 8144F35CEFC; Fri, 20 Jan
 2023 15:10:28 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx306.security-mail.net (Postfix) with ESMTPS id D69B735CF42; Fri, 20 Jan
 2023 15:10:27 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id A1E9327E043D; Fri, 20 Jan 2023
 15:10:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 7762E27E0430; Fri, 20 Jan 2023 15:10:27 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 JyeDd67fLWzC; Fri, 20 Jan 2023 15:10:27 +0100 (CET)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id E4DF627E0439; Fri, 20 Jan 2023
 15:10:26 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <ea9e.63caa0d3.d4f6b.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 7762E27E0430
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1674223827;
 bh=pa4ScTG872xOzuRt8GX8Xf9/eL9W3gZxwoN/kQBQFss=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=mCuKc4/UeROfSPy0qESb6bWw6haYw2yj/Thuaz88gp4Xo6fY7v11akHAnwnsq/SE/
 l71YYm+MloYSX37ktexP6Ugc0NvI9sQziU77LnSg76PpXxXYDYmYnCLgz0FFptdvhN
 uCVOH2np8u2uDy77i3yNVSUCOsRcLW4hLIHMTeNw=
From:   Yann Sionneau <ysionneau@kalray.eu>
To:     Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Yann Sionneau <ysionneau@kalray.eu>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Clement Leger <clement@clement-leger.fr>,
        Vincent Chardon <vincent.chardon@elsys-design.com>,
        Marc =?utf-8?b?UG91bGhpw6hz?= <dkm@kataplop.net>,
        Julian Vetter <jvetter@kalray.eu>,
        Samuel Jones <sjones@kalray.eu>,
        Ashley Lesdalons <alesdalons@kalray.eu>,
        Thomas Costis <tcostis@kalray.eu>,
        Marius Gligor <mgligor@kalray.eu>,
        Jonathan Borne <jborne@kalray.eu>,
        Julien Villette <jvillette@kalray.eu>,
        Luc Michel <lmichel@kalray.eu>,
        Louis Morhet <lmorhet@kalray.eu>,
        Julien Hascoet <jhascoet@kalray.eu>,
        Jean-Christophe Pince <jcpince@gmail.com>,
        Guillaume Missonnier <gmissonnier@kalray.eu>,
        Alex Michon <amichon@kalray.eu>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <git@xen0n.name>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Bibo Mao <maobibo@loongson.cn>,
        Atish Patra <atishp@atishpatra.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Qi Liu <liuqi115@huawei.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Benjamin Mugnier <mugnier.benjamin@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-audit@redhat.com,
        linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Subject: [RFC PATCH v2 06/31] Documentation: Add binding for
 kalray,kv3-1-ipi-ctrl
Date:   Fri, 20 Jan 2023 15:09:37 +0100
Message-ID: <20230120141002.2442-7-ysionneau@kalray.eu>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230120141002.2442-1-ysionneau@kalray.eu>
References: <20230120141002.2442-1-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Jules Maselbas <jmaselbas@kalray.eu>

Add documentation for `kalray,kv3-1-ipi-ctrl` binding.

Co-developed-by: Jules Maselbas <jmaselbas@kalray.eu>
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---

Notes:
    V1 -> V2: new patch

 .../kalray/kalray,kv3-1-ipi-ctrl.yaml         | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/kalray/kalray,kv3-1-ipi-ctrl.yaml

diff --git a/Documentation/devicetree/bindings/kalray/kalray,kv3-1-ipi-ctrl.yaml b/Documentation/devicetree/bindings/kalray/kalray,kv3-1-ipi-ctrl.yaml
new file mode 100644
index 000000000000..dc8026b12905
--- /dev/null
+++ b/Documentation/devicetree/bindings/kalray/kalray,kv3-1-ipi-ctrl.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/kalray/kalray,kv3-1-ipi-ctrl#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Kalray kv3-1 Inter-Processor Interrupt Controller (IPI)
+
+description: |
+  The Inter-Processor Interrupt Controller (IPI) provides a fast synchronization
+  mechanism to the software. It exposes eight independent set of registers that
+  can be use to notify each processor in the cluster.
+  A set of registers contains two 32-bit registers:
+    - 17-bit interrupt control, one bit per core, raise an interrupt on write
+    - 17-bit mask, one per core, to enable interrupts
+
+  Bit at offsets 0 to 15 selects cores in the cluster, respectively PE0 to PE15,
+  while bit at offset 16 is for the cluster Resource Manager (RM) core.
+
+  The eight output interrupts are connected to each processor core interrupt
+  controller (intc).
+
+properties:
+  compatible:
+    const: kalray,kv3-1-ipi-ctrl
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupt-parent
+  - interrupts
+
+examples:
+  - |
+    ipi: inter-processor-interrupt@ad0000 {
+        compatible = "kalray,kv3-1-ipi-ctrl";
+        reg = <0x00 0xad0000 0x00 0x1000>;
+        interrupt-parent = <&intc>;
+        interrupts = <24>;
+    };
+
+...
-- 
2.37.2





