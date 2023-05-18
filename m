Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F81570827B
	for <lists+linux-arch@lfdr.de>; Thu, 18 May 2023 15:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjERNQg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 May 2023 09:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbjERNQI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 May 2023 09:16:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F822105;
        Thu, 18 May 2023 06:15:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FC2C64F51;
        Thu, 18 May 2023 13:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B72C4339C;
        Thu, 18 May 2023 13:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684415696;
        bh=lQTH6fQXqgDOV13+OOf/m8+ReoWieEMsKkpHvX1KsBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U6EWjbahGfHXvROjB2vQAPwqJYGK9YXMzzTxQLwkq71y9CcePnOM9o0N6RgIJxBAA
         iTUw77TFtCy266dawOWVsx7sYBg81q/acOunzlByttuu/7hUXMU6bAdWUJ7eOvEQgU
         3It9oF8OK6aVWRyoLzt3nCb15zQ4TaRdM2/T7/NKOFw0Jcs8EDOLPfiSuZYUmrZnzE
         fbsFQvX+QYCwyd2VkmID9Zbj0EnVj2cHi1nzb1M6HAeGrGFDVk/Au69twErCk4x7+s
         JeniPBb8OhNwQRv4lKBbLI+UqzRKL20bsZWqfA8S6smJl087/UeJQBxf7ivFSyJJGH
         lfg8CnyC2mhlA==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, mark.rutland@arm.com, bjorn@kernel.org,
        paul.walmsley@sifive.com, catalin.marinas@arm.com, will@kernel.org,
        rppt@kernel.org, anup@brainfault.org, shihua@iscas.ac.cn,
        jiawei@iscas.ac.cn, liweiwei@iscas.ac.cn, luxufan@iscas.ac.cn,
        chunyu@iscas.ac.cn, tsu.yubo@gmail.com, wefu@redhat.com,
        wangjunqiang@iscas.ac.cn, kito.cheng@sifive.com,
        andy.chiu@sifive.com, vincent.chen@sifive.com,
        greentime.hu@sifive.com, corbet@lwn.net, wuwei2016@iscas.ac.cn,
        jrtc27@jrtc27.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH 22/22] riscv: s64ilp32: Temporary workaround solution to gcc problem
Date:   Thu, 18 May 2023 09:10:13 -0400
Message-Id: <20230518131013.3366406-23-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230518131013.3366406-1-guoren@kernel.org>
References: <20230518131013.3366406-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

There is an existing problem in 64ilp32 gcc that combines two pointers
in one register. Liao is solving that problem. Before he finishes the
job, we could prevent it with a simple noinline attribute, fortunately.

struct path {
	struct vfsmount *mnt;
	struct dentry *dentry;
} __randomize_layout;

struct nameidata {
        struct path     path;
        struct qstr     last;
        struct path     root;
...
} __randomize_layout;

	struct nameidata *nd
	...
	nd->path = nd->root;
6c88                	ld	a0,24(s1)
				^^ // Wrong arg of mntget
e088                	sd	a0,0(s1)
	// Need inserting "lw a0,0(s1)" here
	mntget(path->mnt);
2a6150ef          	jal	c01ce946 <mntget>

Any gcc helps are welcome :)

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: LiaoShihua <shihua@iscas.ac.cn>
---
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index edfedfbccaef..22a2ef77e074 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -541,7 +541,7 @@ EXPORT_SYMBOL(inode_permission);
  *
  * Given a path increment the reference count to the dentry and the vfsmount.
  */
-void path_get(const struct path *path)
+void noinline path_get(const struct path *path)
 {
 	mntget(path->mnt);
 	dget(path->dentry);
-- 
2.36.1

