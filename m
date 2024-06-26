Return-Path: <linux-arch+bounces-5157-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC53918E3A
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2024 20:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B27E1C21C8D
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2024 18:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B045419069E;
	Wed, 26 Jun 2024 18:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5Fy0+li"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851A619069A;
	Wed, 26 Jun 2024 18:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426141; cv=none; b=tTs5BYCatZBx7UEHNfdK1HZbldLcmk3NvaaAXCNwIX++ZyP7uGgGC7ArBWZGkUFRvIYpv3NiPdkOQpem8JafPCxbK1FS6n8wh9U9XyRxEre1nPSf6kLYsOgOl1LgUBNUX/NX+ElFT44jVeQe5U6zKjhkeSy61PYTDqCT3LZ8mvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426141; c=relaxed/simple;
	bh=K6eyZafDNxc0r7Gy5hMuPtGD16Eyfc5K9o++6y6ClXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qi+LhPGs/u4Kgt/LFegQgSGjDKRvIpxeQary3IO9FpygrOR7emWf7WVCDN7moFgFpLFcVXRYQ65ng4YxA/oq9n9SSqOnbovzt1jlBIVV2vtMKCwkiU9bsH7gS3w62z1cO2eibvAc+9720EgNbDujtYg/LIOswwZEdotwKrIRrV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5Fy0+li; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D516C32782;
	Wed, 26 Jun 2024 18:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719426141;
	bh=K6eyZafDNxc0r7Gy5hMuPtGD16Eyfc5K9o++6y6ClXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e5Fy0+liLs4AE8oCGRpMxpx42yZ7Fx4VxqhI4Deljux8xkMZbFmFCrLXk4d8uj4hV
	 n6vsbkprYmk9IsIYYNwJKK5MlWcGHqbwN55olaGn/rY/QhuM9xxJSPaKXR1MWsPX7W
	 3g0AWZDmFFw08BpfZSijv1zDvahFAUm6BkxxNKy+fui8migzEesR5u2tEBCPKXEavT
	 gSvYTlKsusVF8pS6XG/4tumkhmPzAsfKBEIE1rno3AmFrrhwKwe6r7LblwffdxBNN1
	 clv3Qp5qTSTvF5ohe0cpcv6Ld6JTY+J00S94xPZb3nv3okTHfjkBye2wFyrjmReWly
	 yk3CdAxWMP04w==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/5] kconfig: fix conditional prompt behavior for choice
Date: Thu, 27 Jun 2024 03:22:01 +0900
Message-ID: <20240626182212.3758235-3-masahiroy@kernel.org>
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

When a prompt is followed by "if <expr>", the symbol is configurable
when the if-conditional evaluates to true.

A typical usage is as follows:

    menuconfig BLOCK
            bool "Enable the block layer" if EXPERT
            default y

When EXPERT=n, the prompt is hidden, but this config entry is still
active, and BLOCK is set to its default value 'y'. When EXPERT=y, the
prompt is shown, making BLOCK a user-configurable option.

This usage is common throughout the kernel tree, but it has never worked
within a choice block.

[Test Code]

    config EXPERT
            bool "Allow expert users to modify more options"

    choice
            prompt "Choose" if EXPERT

    config A
            bool "A"

    config B
            bool "B"

    endchoice

[Result]

    # CONFIG_EXPERT is not set

When the prompt is hidden, the choice block should produce the default
without asking for the user's preference. Hence, the output should be:

    # CONFIG_EXPERT is not set
    CONFIG_A=y
    # CONFIG_B is not set

Removing unnecessary hacks fixes the issue.

This commit also changes the behavior of 'select' by choice members.

[Test Code 2]

    config MODULES
            def_bool y
            modules

    config DEP
            def_tristate m

    if DEP

    choice
            prompt "choose"

    config A
            bool "A"
            select C

    endchoice

    config B
            def_bool y
            select D

    endif

    config C
            tristate

    config D
            tristate

The current output is as follows:

    CONFIG_MODULES=y
    CONFIG_DEP=m
    CONFIG_A=y
    CONFIG_B=y
    CONFIG_C=y
    CONFIG_D=m

With this commit, the output will be changed as follows:

    CONFIG_MODULES=y
    CONFIG_DEP=m
    CONFIG_A=y
    CONFIG_B=y
    CONFIG_C=m
    CONFIG_D=m

CONFIG_C will be changed to 'm' because 'select C' will inherit the
dependency on DEP, which is 'm'.

This change is aligned with the behavior of 'select' outside a choice
block; 'select D' depends on DEP, therefore D is selected by (B && DEP).

Note:

With this commit, allmodconfig will set CONFIG_USB_ROLE_SWITCH to 'm'
instead of 'y'. I did not see any build regression with this change.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/menu.c   | 38 +++-----------------------------------
 scripts/kconfig/symbol.c |  2 +-
 2 files changed, 4 insertions(+), 36 deletions(-)

diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index 23c95e54660d..b1fbaf2ff792 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -306,7 +306,7 @@ static void _menu_finalize(struct menu *parent, bool inside_choice)
 	struct menu *menu, *last_menu;
 	struct symbol *sym;
 	struct property *prop;
-	struct expr *parentdep, *basedep, *dep, *dep2;
+	struct expr *basedep, *dep, *dep2;
 
 	sym = parent->sym;
 	if (parent->list) {
@@ -315,24 +315,6 @@ static void _menu_finalize(struct menu *parent, bool inside_choice)
 		 * and propagate parent dependencies before moving on.
 		 */
 
-		bool is_choice = false;
-
-		if (sym && sym_is_choice(sym))
-			is_choice = true;
-
-		if (is_choice) {
-			/*
-			 * Use the choice itself as the parent dependency of
-			 * the contained items. This turns the mode of the
-			 * choice into an upper bound on the visibility of the
-			 * choice value symbols.
-			 */
-			parentdep = expr_alloc_symbol(sym);
-		} else {
-			/* Menu node for 'menu', 'if' */
-			parentdep = parent->dep;
-		}
-
 		/* For each child menu node... */
 		for (menu = parent->list; menu; menu = menu->next) {
 			/*
@@ -341,7 +323,7 @@ static void _menu_finalize(struct menu *parent, bool inside_choice)
 			 */
 			basedep = rewrite_m(menu->dep);
 			basedep = expr_transform(basedep);
-			basedep = expr_alloc_and(expr_copy(parentdep), basedep);
+			basedep = expr_alloc_and(expr_copy(parent->dep), basedep);
 			basedep = expr_eliminate_dups(basedep);
 			menu->dep = basedep;
 
@@ -405,15 +387,12 @@ static void _menu_finalize(struct menu *parent, bool inside_choice)
 			}
 		}
 
-		if (is_choice)
-			expr_free(parentdep);
-
 		/*
 		 * Recursively process children in the same fashion before
 		 * moving on
 		 */
 		for (menu = parent->list; menu; menu = menu->next)
-			_menu_finalize(menu, is_choice);
+			_menu_finalize(menu, sym && sym_is_choice(sym));
 	} else if (!inside_choice && sym) {
 		/*
 		 * Automatic submenu creation. If sym is a symbol and A, B, C,
@@ -541,17 +520,6 @@ static void _menu_finalize(struct menu *parent, bool inside_choice)
 		sym_check_prop(sym);
 		sym->flags |= SYMBOL_WARNED;
 	}
-
-	/*
-	 * For choices, add a reverse dependency (corresponding to a select) of
-	 * '<visibility> && y'. This prevents the user from setting the choice
-	 * mode to 'n' when the choice is visible.
-	 */
-	if (sym && sym_is_choice(sym) && parent->prompt) {
-		sym->rev_dep.expr = expr_alloc_or(sym->rev_dep.expr,
-				expr_alloc_and(parent->prompt->visible.expr,
-					expr_alloc_symbol(&symbol_yes)));
-	}
 }
 
 void menu_finalize(void)
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index e5441378c4b0..1cb8b6a22c5a 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -868,7 +868,7 @@ const char *sym_get_string_value(struct symbol *sym)
 
 bool sym_is_changeable(struct symbol *sym)
 {
-	return sym->visible > sym->rev_dep.tri;
+	return !sym_is_choice(sym) && sym->visible > sym->rev_dep.tri;
 }
 
 HASHTABLE_DEFINE(sym_hashtable, SYMBOL_HASHSIZE);
-- 
2.43.0


