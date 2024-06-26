Return-Path: <linux-arch+bounces-5158-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 705F7918E3E
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2024 20:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A3D728BCF5
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2024 18:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BAB191482;
	Wed, 26 Jun 2024 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKR/dQWQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC84D19147D;
	Wed, 26 Jun 2024 18:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426143; cv=none; b=OOlZnM/sJvLwxZS4DNyXeV4tEUrxlOt0Rsjyr+DZGlAHINvcv8HOpFNlXMzJsJxvCHuuuE7WX9+H4QxpxDeS0uYrPYgpk8+DWrczZBR1QwxJ27sUEHXzscdaS1g+ahiezGHVbrCf3AlOo0kifhzclu0aMOpGoQ33y2lFnaLicbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426143; c=relaxed/simple;
	bh=my2sMF6VVxFPJoXBASaxBfnDw1lIY0jHqG4TFeJhw2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HgicRlujNwmJw2oWmfBNHUg3AELVIEMzI1GR+VPaR/4y9Ijn6oNpxLqdOpwBMqvziUtry4Mh+5At0B1OM42p1VJ5SK9DNbvsZUhbkVBYWvCOgbG7JbvgslY5b19G4kThZ5XZUbfR19Y10Gh6Z0avO3uVHlU/+0qnALkdMaCpG4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKR/dQWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7B4C4AF09;
	Wed, 26 Jun 2024 18:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719426142;
	bh=my2sMF6VVxFPJoXBASaxBfnDw1lIY0jHqG4TFeJhw2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NKR/dQWQen/SI67rlHvvTs3BnWbAbxAODS0PiX29beEcZ2FdQYT8JQzhHnw6kcJ/x
	 V3I8EuxrdE0ZNni55LJ+9EqXqcwEZOp0kPmKOYg7q12r6HcceuV6CUVYJ76oK+0OAc
	 NuiToahyO42n2JkUJrhLQwh1JHrEa+Kj32s4jp6l5yN7lCfOK83GzYGXteoH08YM3s
	 foL3fZ6sFfJadtvoGIUQo3pjW+MSMRAgBT85heGD/ugAeheLGSs+ObapADXWfRioC9
	 P+V/u7phaiAxek+9B4c9xgmXrhLce7Rs6Ww6AwogzO2T5Yxckoy6hnVOkamjBJDVzc
	 eq7RNDMrBHXFw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 3/5] kconfig: improve error message for dependency between choice members
Date: Thu, 27 Jun 2024 03:22:02 +0900
Message-ID: <20240626182212.3758235-4-masahiroy@kernel.org>
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

A choice member must not depend on another member within the same choice
block.

Kconfig detects this, but the error message is not sensible.

[Test Code]

    choice
            prompt "choose"

    config A
            bool "A"
            depends on B

    config B
            bool "B"

    endchoice

[Result]

    Kconfig:1:error: recursive dependency detected!
    Kconfig:1:      choice <choice> contains symbol A
    Kconfig:4:      symbol A is part of choice B
    Kconfig:8:      symbol B is part of choice <choice>
    For a resolution refer to Documentation/kbuild/kconfig-language.rst
    subsection "Kconfig recursive dependency limitations"

The phrase "part of choice B" is weird because B is not a choice block,
but a choice member.

To determine whether the current symbol is a part of a choice block,
sym_is_choice(next_sym) must be checked.

This commit improves the error message to:

    Kconfig:1:error: recursive dependency detected!
    Kconfig:1:      choice <choice> contains symbol A
    Kconfig:4:      symbol A symbol is visible depending on B
    Kconfig:8:      symbol B is part of choice <choice>
    For a resolution refer to Documentation/kbuild/kconfig-language.rst
    subsection "Kconfig recursive dependency limitations"

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/symbol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 1cb8b6a22c5a..0c4b2894ac4e 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -1111,7 +1111,7 @@ static void sym_check_print_recursive(struct symbol *last_sym)
 				menu->filename, menu->lineno,
 				sym->name ? sym->name : "<choice>",
 				next_sym->name ? next_sym->name : "<choice>");
-		} else if (sym_is_choice_value(sym)) {
+		} else if (sym_is_choice(next_sym)) {
 			fprintf(stderr, "%s:%d:\tsymbol %s is part of choice %s\n",
 				menu->filename, menu->lineno,
 				sym->name ? sym->name : "<choice>",
-- 
2.43.0


