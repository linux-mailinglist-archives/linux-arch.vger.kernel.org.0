Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 303A012CD91
	for <lists+linux-arch@lfdr.de>; Mon, 30 Dec 2019 09:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfL3IXz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Dec 2019 03:23:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:47566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbfL3IXy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Dec 2019 03:23:54 -0500
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C939220748;
        Mon, 30 Dec 2019 08:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577694234;
        bh=bxf8EZJDD9igkh37WLh+g0Si6gef3N0HX1lUMypoJt8=;
        h=From:To:Cc:Subject:Date:From;
        b=W+8GXso80Dwc/3pFcCMN0HfMHf1aM3LMavYJbUL8UziJS+fG0RxQevVHV9AG5kza1
         wB3ArfXjh2mYXmaM+swivMWpI4CEpXYJfOVmhAIxRBM0ijXq3h/I7fe66vSvAaHiD1
         AG17nFdPOMT3TsRjvVHzY2M38nTRhB5Nt3ooty+g=
From:   guoren@kernel.org
To:     linux-csky@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        arnd@arndb.de, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 1/5] MAINTAINERS: csky: Add mailing list for csky
Date:   Mon, 30 Dec 2019 16:23:27 +0800
Message-Id: <20191230082331.30976-1-guoren@kernel.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Add mailing list and it's convenient for maintain C-SKY
subsystem.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e4f170d8bc29..1b0e8dcefb94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3553,6 +3553,7 @@ F:	sound/pci/oxygen/
 
 C-SKY ARCHITECTURE
 M:	Guo Ren <guoren@kernel.org>
+L:	linux-csky@vger.kernel.org
 T:	git https://github.com/c-sky/csky-linux.git
 S:	Supported
 F:	arch/csky/
-- 
2.17.0

