Return-Path: <linux-arch+bounces-5159-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B246E918E40
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2024 20:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E253E1C214D2
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2024 18:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A008119149E;
	Wed, 26 Jun 2024 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKTadVta"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755F3191498;
	Wed, 26 Jun 2024 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426144; cv=none; b=IrcVQCBHwyq4/TUVm/Wpe94uNiyeEg+WGNgoai8WUSX7mSmJHMUL1dDXy98XamWdvRvSorgO8ZxqOWj0ZGQqmlUO+VhcqxBjA9GJTkJt2NZhYNlv93+0SgihEcsS+Wvuk5CvusatXuoyQx3btpnEEmBHLBrHNqGNK7JcTZL0zBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426144; c=relaxed/simple;
	bh=GC2BWddRy6yTtw5o3dHS8w3Cc3U6bmyDnb9HpImLReM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aGkNUHET55acE3QkOg30A7QyAdNfkDQvNGHITcK7yYMrTQIr+kzJrg3RQV4aABHN+gGNeEGyLzaE+iNWgNthURal6imltJCHe0g5mrLr+u4foDltMw7fdlUxGwIObTvuGTLQZ+OXbaclNrzTjvu0toBLtWr3Grogb2SzAqHYznk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKTadVta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A15CC32782;
	Wed, 26 Jun 2024 18:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719426144;
	bh=GC2BWddRy6yTtw5o3dHS8w3Cc3U6bmyDnb9HpImLReM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NKTadVtaEaYc9+jGtfoCy8BoKJblUEZ3Dsjl/PHqHHo6WhpHuLw+eOh+qVNz5TIIR
	 /YNLDYTqSERQVmM2A6mCiKCogRIJPzPFlGfMSxc5RpulIgPnebJ/zfo3U/L+NsntPa
	 R7nhkm+pCcQDG8Gvn6YmMc7uuk6tQKD+/Zlvn3k4VkcAbIcKObrHzRq1oj7MFdFPPm
	 D/sfX0NbcDspyQ7eMdrWcDlHXFjDTZzFfJG7+aE5eLx8iVzzXiZeShrqBv84IfLV2d
	 BoaQeXbJZiDYv6V3ESKDdCCORMO0IZ7DeWDeqIG6uyHiHQ/d5oqIsQhHYLAYUvx1DA
	 KUOjj5Swo9Vkw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 4/5] kconfig: improve error message for recursive dependency in choice
Date: Thu, 27 Jun 2024 03:22:03 +0900
Message-ID: <20240626182212.3758235-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240626182212.3758235-1-masahiroy@kernel.org>
References: <20240626182212.3758235-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kconfig detects recursive dependencies in a choice block, but the error
message is unclear.

[Test Code]

    choice
            prompt "choose"
            depends on A

    config A
            bool "A"

    config B
            bool "B"

    endchoice

[Result]

    Kconfig:1:error: recursive dependency detected!
    Kconfig:1:      choice <choice> contains symbol A
    Kconfig:5:      symbol A is part of choice <choice>
    For a resolution refer to Documentation/kbuild/kconfig-language.rst
    subsection "Kconfig recursive dependency limitations"

The phrase "contains symbol A" does not accurately describe the problem.
The issue is that the choice depends on A, which is a member of itself.

The first if-block does not print a sensible message. Remove it.

This commit improves the error message to:

    Kconfig:1:error: recursive dependency detected!
    Kconfig:1:      symbol <choice> symbol is visible depending on A
    Kconfig:5:      symbol A is part of choice <choice>
    For a resolution refer to Documentation/kbuild/kconfig-language.rst
    subsection "Kconfig recursive dependency limitations"

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/symbol.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 0c4b2894ac4e..787f0667836b 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -1106,12 +1106,7 @@ static void sym_check_print_recursive(struct symbol *last_sym)
 			fprintf(stderr, "%s:%d:error: recursive dependency detected!\n",
 				prop->filename, prop->lineno);
 
-		if (sym_is_choice(sym)) {
-			fprintf(stderr, "%s:%d:\tchoice %s contains symbol %s\n",
-				menu->filename, menu->lineno,
-				sym->name ? sym->name : "<choice>",
-				next_sym->name ? next_sym->name : "<choice>");
-		} else if (sym_is_choice(next_sym)) {
+		if (sym_is_choice(next_sym)) {
 			fprintf(stderr, "%s:%d:\tsymbol %s is part of choice %s\n",
 				menu->filename, menu->lineno,
 				sym->name ? sym->name : "<choice>",
-- 
2.43.0


