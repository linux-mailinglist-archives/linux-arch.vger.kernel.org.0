Return-Path: <linux-arch+bounces-5160-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A32E5918E43
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2024 20:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 579C928C587
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2024 18:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAD01922E4;
	Wed, 26 Jun 2024 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAFC4muV"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033011922DC;
	Wed, 26 Jun 2024 18:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426146; cv=none; b=XoBn1FrxWGywUIUVrntuV2HBm6tTdQpPTa0rxC1LZPIhROtDSZV305EZ8r7vyRoUCy1Lm8v9cGQ3n+ki/Kr+03hAUzpKQrt1wDAqRForRQhoem37bBK9wtFS2yyOAcB7/6H2j6l0ymUU992j0i1T6D1vkVVGvAmyyDvvksLbybI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426146; c=relaxed/simple;
	bh=XvPakGWqLqw4+G0WYS9I3w8tq12OU4wO70EbFUiNh9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HklSWCuLVrSt6Mcfe5gO+fpaz2s3+LE9niNlJR0iZq6tfYVH29fMyj/GiJ1TXDtUYOOQcrMFyFg3OEf9fbrnoAOQaSgSTfETHSHyGPG1Oh1QGxIg9p95PXmIey0WLu1Gutj6s02LIdeucSGJCjPDmvawRPBd7PX+YqCm8H3WwFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAFC4muV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDF3C32782;
	Wed, 26 Jun 2024 18:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719426145;
	bh=XvPakGWqLqw4+G0WYS9I3w8tq12OU4wO70EbFUiNh9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LAFC4muVlgWf7QPgFZuVW6oXDXMvaHNZyS/WPVGNcBE5eRMxVzfH9hPZu6SuFjPmi
	 gie3bweDbUcPj+ZzJdWy2oKcC7vxz8cr7NeMYV4540mRL6LVl4fpViu8IJYbV8JUx+
	 8CWxdpcaxMAb9x5EwHRNJtkQQTb8hc5V6IeerRQnDos3CZw/1tBO+D7hFomQ4Ryvv6
	 0FLVTgiSTmnjm0ORYRaaC0ZTUqjCGPNuwhNf5wxxxybIvvpwvWn7Cg1FtNVLAWJUho
	 BZt01d0D4QB30vfiGWY6RPCfXRHRdZbp0nnMd9oc7rh5jNibMnKXzB5J7OWugOU5BB
	 LPyipGnvBcnbQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 5/5] kconfig: refactor error messages in sym_check_print_recursive()
Date: Thu, 27 Jun 2024 03:22:04 +0900
Message-ID: <20240626182212.3758235-6-masahiroy@kernel.org>
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

Improve the error messages and clean up redundant code.

[1] remove redundant next_sym->name checks

If 'next_sym' is a choice, the first 'if' block is executed. In the
subsequent 'else if' blocks, 'next_sym" is not a choice, hence
next_sym->name is not NULL.

[2] remove redundant sym->name checks

A choice is never selected or implied by anyone because it has no name
(it is syntactically impossible). If it is, sym->name is not NULL.

[3] Show the location of choice instead of "<choice>"

"part of choice <choice>" does not convey useful information. Since a
choice has no name, it is more informative to display the file name and
line number.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/symbol.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 787f0667836b..c05d188a1857 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -1107,37 +1107,37 @@ static void sym_check_print_recursive(struct symbol *last_sym)
 				prop->filename, prop->lineno);
 
 		if (sym_is_choice(next_sym)) {
-			fprintf(stderr, "%s:%d:\tsymbol %s is part of choice %s\n",
+			choice = list_first_entry(&next_sym->menus, struct menu, link);
+
+			fprintf(stderr, "%s:%d:\tsymbol %s is part of choice block at %s:%d\n",
 				menu->filename, menu->lineno,
 				sym->name ? sym->name : "<choice>",
-				next_sym->name ? next_sym->name : "<choice>");
+				choice->filename, choice->lineno);
 		} else if (stack->expr == &sym->dir_dep.expr) {
 			fprintf(stderr, "%s:%d:\tsymbol %s depends on %s\n",
 				prop->filename, prop->lineno,
 				sym->name ? sym->name : "<choice>",
-				next_sym->name ? next_sym->name : "<choice>");
+				next_sym->name);
 		} else if (stack->expr == &sym->rev_dep.expr) {
 			fprintf(stderr, "%s:%d:\tsymbol %s is selected by %s\n",
 				prop->filename, prop->lineno,
-				sym->name ? sym->name : "<choice>",
-				next_sym->name ? next_sym->name : "<choice>");
+				sym->name, next_sym->name);
 		} else if (stack->expr == &sym->implied.expr) {
 			fprintf(stderr, "%s:%d:\tsymbol %s is implied by %s\n",
 				prop->filename, prop->lineno,
-				sym->name ? sym->name : "<choice>",
-				next_sym->name ? next_sym->name : "<choice>");
+				sym->name, next_sym->name);
 		} else if (stack->expr) {
 			fprintf(stderr, "%s:%d:\tsymbol %s %s value contains %s\n",
 				prop->filename, prop->lineno,
 				sym->name ? sym->name : "<choice>",
 				prop_get_type_name(prop->type),
-				next_sym->name ? next_sym->name : "<choice>");
+				next_sym->name);
 		} else {
 			fprintf(stderr, "%s:%d:\tsymbol %s %s is visible depending on %s\n",
 				prop->filename, prop->lineno,
 				sym->name ? sym->name : "<choice>",
 				prop_get_type_name(prop->type),
-				next_sym->name ? next_sym->name : "<choice>");
+				next_sym->name);
 		}
 	}
 
-- 
2.43.0


