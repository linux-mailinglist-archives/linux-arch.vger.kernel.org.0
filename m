Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72C0422A68
	for <lists+linux-arch@lfdr.de>; Mon, 20 May 2019 05:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfETDai (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 May 2019 23:30:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfETDai (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 19 May 2019 23:30:38 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C0782082C;
        Mon, 20 May 2019 03:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558323038;
        bh=7WcP7geRnCdillAQ5KdZSxTQZjeTSwXA+zJ2pR9Vmew=;
        h=From:To:Cc:Subject:Date:From;
        b=0SnIZywVbZH0hJ9oAjMlka3xsvHP3J8+a9gXL+4vuvCU7YFNCdD6AJARXUBxs6Wth
         jlmP5rfrLpC3tIBr3ZyHqNgAYovTx79RXKL6NYgdZy9bs4M2twuZZ6FC5BK66xiyuI
         lgdyRduxjfEfq4R80WTsFsckEHZhtqPydV8G9mEE=
From:   guoren@kernel.org
To:     ren_guo@c-sky.com, han_mao@c-sky.com, yibin_liu@c-sky.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arnd.de, linux-csky@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add mailing list for csky architecture
Date:   Mon, 20 May 2019 11:27:59 +0800
Message-Id: <1558322879-12358-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Add the newly created linux-csky@vger.kernel.org mailing list for patch
reviews and discussions.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5cfbea4..b5fadcc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3474,6 +3474,7 @@ F:	sound/pci/oxygen/
 
 C-SKY ARCHITECTURE
 M:	Guo Ren <guoren@kernel.org>
+L:	linux-csky@vger.kernel.org
 T:	git https://github.com/c-sky/csky-linux.git
 S:	Supported
 F:	arch/csky/
-- 
2.7.4

