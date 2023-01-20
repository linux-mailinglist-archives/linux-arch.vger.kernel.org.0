Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2106675672
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 15:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjATOLE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Jan 2023 09:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjATOLD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jan 2023 09:11:03 -0500
Received: from fx304.security-mail.net (smtpout30.security-mail.net [85.31.212.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB45C639C
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 06:10:31 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by fx304.security-mail.net (Postfix) with ESMTP id 8E30E9D0CB
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 15:10:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1674223829;
        bh=GCb+aZyhHGWJx4uFQ9PWJOzxH5FwUHqDkAret4C+DiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=cTJKwCdk2zOE4eqETytFbqd3i85IUsiNVJk9ff75Yc3gmCsCn/VF3JNOrqz44ImWR
         WJWwfKkreBYnHE86cXSRyUtuwv5EqLnop+Yw399B1LB0qrk83uUXGLO+aNwLAWxy6M
         ZtnoF15TGZCyNo2hl2QSWZCIkNzmuTUjFFQpunNM=
Received: from fx304 (localhost [127.0.0.1]) by fx304.security-mail.net
 (Postfix) with ESMTP id 1F2879D075; Fri, 20 Jan 2023 15:10:29 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx304.security-mail.net (Postfix) with ESMTPS id 5784C9D04D; Fri, 20 Jan
 2023 15:10:28 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 2855527E043D; Fri, 20 Jan 2023
 15:10:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id D8A7627E0439; Fri, 20 Jan 2023 15:10:27 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 pxiL3-7zmQbs; Fri, 20 Jan 2023 15:10:27 +0100 (CET)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 5AD1127E043E; Fri, 20 Jan 2023
 15:10:27 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <6ff5.63caa0d4.56592.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu D8A7627E0439
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1674223828;
 bh=8uCtiqDjPzOcwhlHBsakO1CoaBAI9UncGRE7J9HRCd8=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=fgJsxrw8FZvAT6LZnY+JkVSYSXWd7ACWehLxcYh/S5JZU136kC9QWyY4QSnfgA5u5
 Wk0vKyjoxIlLyuLXEBNZBi6OIR4DzL0KuNqlbHwCoM8WlaSs9d3t8vMr80S8wrF5wF
 qyJEcuXe25rOij+wlHaC/cdMXKDfNceRZ81JV0dA=
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
Subject: [RFC PATCH v2 07/31] Documentation: Add binding for
 kalray,kv3-1-pwr-ctrl
Date:   Fri, 20 Jan 2023 15:09:38 +0100
Message-ID: <20230120141002.2442-8-ysionneau@kalray.eu>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230120141002.2442-1-ysionneau@kalray.eu>
References: <20230120141002.2442-1-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Jules Maselbas <jmaselbas@kalray.eu>

Add documentation for `kalray,kv3-1-pwr-ctrl` binding.

Co-developed-by: Jules Maselbas <jmaselbas@kalray.eu>
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---

Notes:
    V1 -> V2: new patch

 .../kalray/kalray,kv3-1-pwr-ctrl.yaml         | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/kalray/kalray,kv3-1-pwr-ctrl.yaml

diff --git a/Documentation/devicetree/bindings/kalray/kalray,kv3-1-pwr-ctrl.yaml b/Documentation/devicetree/bindings/kalray/kalray,kv3-1-pwr-ctrl.yaml
new file mode 100644
index 000000000000..968674bb0c63
--- /dev/null
+++ b/Documentation/devicetree/bindings/kalray/kalray,kv3-1-pwr-ctrl.yaml
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/kalray/kalray,kv3-1-pwr-ctrl#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Kalray cluster Power Controller (pwr-ctrl)
+
+description: |
+  The Power Controller (pwr-ctrl) control cores reset and wake-up procedure.
+
+properties:
+  compatible:
+    const: kalray,kv3-1-pwr-ctrl
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    pwr_ctrl: power-controller@a40000 {
+        compatible = "kalray,kv3-1-pwr-ctrl";
+        reg = <0x00 0xa40000 0x00 0x4158>;
+    };
+
+...
-- 
2.37.2





