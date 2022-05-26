Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B57534782
	for <lists+linux-arch@lfdr.de>; Thu, 26 May 2022 02:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343833AbiEZAdw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 May 2022 20:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343900AbiEZAdv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 May 2022 20:33:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B9EA7750;
        Wed, 25 May 2022 17:33:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC1E9B81EC6;
        Thu, 26 May 2022 00:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A33C385B8;
        Thu, 26 May 2022 00:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653525227;
        bh=ZWKxggY+VnUVpjU4MoysVSsuD3COCyMSaEfvLuXgVRs=;
        h=From:To:Cc:Subject:Date:From;
        b=PBq6fKCo1Bz3EIujJxTKMMGWJbuJ0AOm4fbJNtj8D7eFmMOLfK3VAk6A1OaQ06kA7
         M2FK2VWqIbFP/w+aXhQmOrUMA9u4hBzaVVAdyZP9o2exDmH4Nibf3XvUZoN7hoy0dp
         UIeJnJNof3D2CKGFKMtat6wU1/gHTxYJRiObxv9PG4vBEsytYeMwGTvjwuC8Q37AVO
         6Sb4JbA3ZcaOfeURQqnr0HQ2JaBTBZIaewKvENbOxbpbKDYBXVPgaGOXz5rj4i0wDv
         EH6DMCyHBlTpLyMCQm7MqAIrrFGoRhQr41peKlgwcAfgISDqQsBFjicLqSrLq42uzR
         pwgWjvgD7iZNg==
From:   guoren@kernel.org
To:     palmer@rivosinc.com, arnd@arndb.de, linux@roeck-us.net,
        palmer@dabbelt.com, heiko@sntech.de
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH V2] riscv: compat: Using seperated vdso_maps for compat_vdso_info
Date:   Wed, 25 May 2022 20:33:39 -0400
Message-Id: <20220526003339.2948309-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This is a fixup for vdso implementation which caused musl to
fail.

[   11.600082] Run /sbin/init as init process
[   11.628561] init[1]: unhandled signal 11 code 0x1 at
0x0000000000000000 in libc.so[ffffff8ad39000+a4000]
[   11.629398] CPU: 0 PID: 1 Comm: init Not tainted
5.18.0-rc7-next-20220520 #1
[   11.629462] Hardware name: riscv-virtio,qemu (DT)
[   11.629546] epc : 00ffffff8ada1100 ra : 00ffffff8ada13c8 sp :
00ffffffc58199f0
[   11.629586]  gp : 00ffffff8ad39000 tp : 00ffffff8ade0998 t0 :
ffffffffffffffff
[   11.629598]  t1 : 00ffffffc5819fd0 t2 : 0000000000000000 s0 :
00ffffff8ade0cc0
[   11.629610]  s1 : 00ffffff8ade0cc0 a0 : 0000000000000000 a1 :
00ffffffc5819a00
[   11.629622]  a2 : 0000000000000001 a3 : 000000000000001e a4 :
00ffffffc5819b00
[   11.629634]  a5 : 00ffffffc5819b00 a6 : 0000000000000000 a7 :
0000000000000000
[   11.629645]  s2 : 00ffffff8ade0ac8 s3 : 00ffffff8ade0ec8 s4 :
00ffffff8ade0728
[   11.629656]  s5 : 00ffffff8ade0a90 s6 : 0000000000000000 s7 :
00ffffffc5819e40
[   11.629667]  s8 : 00ffffff8ade0ca0 s9 : 00ffffff8addba50 s10:
0000000000000000
[   11.629678]  s11: 0000000000000000 t3 : 0000000000000002 t4 :
0000000000000001
[   11.629688]  t5 : 0000000000020000 t6 : ffffffffffffffff
[   11.629699] status: 0000000000004020 badaddr: 0000000000000000
cause: 000000000000000d

The last __vdso_init(&compat_vdso_info) replaces the data in normal
vdso_info. This is an obvious bug.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Heiko Stübner <heiko@sntech.de>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
---
Changes in V2:
 - Add Tested-by
 - Rename vvar & vdso in /proc/<pid>/maps.
---
 arch/riscv/kernel/vdso.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index 50fe4c877603..957f164c9778 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -206,12 +206,23 @@ static struct __vdso_info vdso_info __ro_after_init = {
 };
 
 #ifdef CONFIG_COMPAT
+static struct vm_special_mapping rv_compat_vdso_maps[] __ro_after_init = {
+	[RV_VDSO_MAP_VVAR] = {
+		.name   = "[compat vvar]",
+		.fault = vvar_fault,
+	},
+	[RV_VDSO_MAP_VDSO] = {
+		.name   = "[compat vdso]",
+		.mremap = vdso_mremap,
+	},
+};
+
 static struct __vdso_info compat_vdso_info __ro_after_init = {
 	.name = "compat_vdso",
 	.vdso_code_start = compat_vdso_start,
 	.vdso_code_end = compat_vdso_end,
-	.dm = &rv_vdso_maps[RV_VDSO_MAP_VVAR],
-	.cm = &rv_vdso_maps[RV_VDSO_MAP_VDSO],
+	.dm = &rv_compat_vdso_maps[RV_VDSO_MAP_VVAR],
+	.cm = &rv_compat_vdso_maps[RV_VDSO_MAP_VDSO],
 };
 #endif
 
-- 
2.36.1

