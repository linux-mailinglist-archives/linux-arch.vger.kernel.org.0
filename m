Return-Path: <linux-arch+bounces-7640-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4C798E6FF
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 01:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8BA1F24615
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 23:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA03F1A071C;
	Wed,  2 Oct 2024 23:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cY/dGMKX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE87E19F42F
	for <linux-arch@vger.kernel.org>; Wed,  2 Oct 2024 23:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727912063; cv=none; b=UFpYWtXnWTM9JI/xZ/QTzf1RMQe6FxAl/wM+72QHDwwT7wFi9szL2m+2ij33TYmqh1XBiioGfGAa56pxoUJYlUhYS3D0I/HUrskGkLcx2KiA2CyJfgV9zCspS0BzHkVUgMOEyhZxprnO7leNvX6wr8qo7zy88M/TeOFNKCSjUWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727912063; c=relaxed/simple;
	bh=Lie6O9sJl63FI1OpJaBUB78suhFUkbeqvo9RmUOmzmM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=hLKAHWtrX9NqLGI5lfBabuPmxB2RIUPXg0Soi2+P31WrJIDlSdUX1CsCQ1AKbtKkdKldgA8SooU8PP/qs+2J0PX8k77UvGC/tiFFtl3kJMwuP4HWnhrzXGqFTj/dcE/pL0CNt41l9hgN7CbD+jrEy/P/6x3Vrg3S0mQFdJ5HxEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cY/dGMKX; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e2261adfdeso6683647b3.2
        for <linux-arch@vger.kernel.org>; Wed, 02 Oct 2024 16:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727912061; x=1728516861; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=14e13Hoyr5VMrj1jISTD53jFiFeUhPa+WN666QY0L8k=;
        b=cY/dGMKXCnb1UwNlWO8XsRsG0nenKlRxNXE3FwmeKJycto9nXsy2FoqaLKGCFSjJsV
         g6oOLoKH6MCufa/8U6W9UMJ5T6InIolof/lJdClhqPGXgfa1U2mWv/cSURS6Xv66h3xE
         fIprar+e+X3xCNM5vliJxUzgM/fWNKu3T95UFlguq2rhkVr+szFQVYi3C2bwNjjxdt4k
         8Az5YDuB8peYFAPGUiL3KPh+OcEKMSm1qP5mhYxVa78nwBFbj1KkdqGnwYs1Rpc34WnC
         0Q4Ey3U5pZyZMKE1JlhqCJqNYHxpJVORASLcpH+nSeB5nzkSqonvMraZkW1jA/JWRuJo
         M6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727912061; x=1728516861;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=14e13Hoyr5VMrj1jISTD53jFiFeUhPa+WN666QY0L8k=;
        b=h+JJxDCvooL7Q89NHaQnt+8DshKMz6H94nRkHaTFS0os4+lHhjkwTAcn+3WF+wgdud
         kYJd+A4Cb8lHja2taZc1frRByiH/5F7gpiQHtx9T/dGElRZGyQ/l7shU2ck0fr/q4lHk
         23dwVa3UAPomW6w2YLEyB7ttHxl0fWdCZCnzHwkaopDDd4y01rOqDhlyu2KaM0NJfbOK
         IzKPFvuaS+CgpGvyGAsANcXH4WXP7fy6K4LmwGOXjrkbdTdan2UQRifJvMp7KzGsdcJP
         iElLDxjnES9mYocXrT7UhYzGkyoPuIX6DhenobY3sAFB7/K3dsu4d83Eo/Z/V7+b/qB2
         OOgg==
X-Forwarded-Encrypted: i=1; AJvYcCUBlcmlePE1Cr8U8PsAQdiu9oUV2eEQ9yeSABJJ8Vt6P9qNt3kiIp4nyjcfaIDVViq856zqbVz9KcTv@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3DS+rjoR+lFcbaEuEFjcSshgEW0jHv47JtxmMIaf7AlgWdf6Y
	TyCHP8CX1IhWpAWnigF6qHGtyA5rKHIqdjHXz2OVrqgQNlt/gC7q1A5d+9fjt7vjKQ==
X-Google-Smtp-Source: AGHT+IFpsbObUJH+vI8s73i/WdqY27wJNDCJFPLhXWJvzrW9aW/Q0PSjEgLWBEVAaWsrJztzlATyLsU=
X-Received: from xur.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2330])
 (user=xur job=sendgmr) by 2002:a25:b314:0:b0:e25:fcb:3205 with SMTP id
 3f1490d57ef6-e263842f473mr13083276.8.1727912060817; Wed, 02 Oct 2024 16:34:20
 -0700 (PDT)
Date: Wed,  2 Oct 2024 16:34:01 -0700
In-Reply-To: <20241002233409.2857999-1-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241002233409.2857999-1-xur@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20241002233409.2857999-3-xur@google.com>
Subject: [PATCH v2 2/6] objtool: Fix unreachable instruction warnings for weak funcitons
From: Rong Xu <xur@google.com>
To: Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>, 
	Sriraman Tallam <tmsriram@google.com>, David Li <davidxl@google.com>, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>, Alice Ryhl <aliceryhl@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bill Wendling <morbo@google.com>, Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>, 
	Brian Gerst <brgerst@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Heiko Carstens <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Juergen Gross <jgross@suse.com>, Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Masahiro Yamada <masahiroy@kernel.org>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Samuel Holland <samuel.holland@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Wei Yang <richard.weiyang@gmail.com>, workflows@vger.kernel.org, x86@kernel.org, 
	"Xin Li (Intel)" <xin@zytor.com>
Content-Type: text/plain; charset="UTF-8"

In the presence of both weak and strong function definitions, the
linker drops the weak symbol in favor of a strong symbol, but
leaves the code in place. Code in ignore_unreachable_insn() has
some heuristics to suppress the warning, but it does not work when
-ffunction-sections is enabled.

Suppose function foo has both strong and weak definitions.
Case 1: The strong definition has an annotated section name,
like .init.text. Only the weak definition will be placed into
.text.foo. But since the section has no symbols, there will be no
"hole" in the section.

Case 2: Both sections are without an annotated section name.
Both will be placed into .text.foo section, but there will be only one
symbol (the strong one). If the weak code is before the strong code,
there is no "hole" as it fails to find the right-most symbol before
the offset.

The fix is to use the first node to compute the hole if hole.sym
is empty. If there is no symbol in the section, the first node
will be NULL, in which case, -1 is returned to skip the whole
section.

Co-developed-by: Han Shen <shenhan@google.com>
Signed-off-by: Han Shen <shenhan@google.com>
Signed-off-by: Rong Xu <xur@google.com>
Suggested-by: Sriraman Tallam <tmsriram@google.com>
Suggested-by: Krzysztof Pszeniczny <kpszeniczny@google.com>
---
 tools/objtool/elf.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 3d27983dc908..6f64d611faea 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -224,12 +224,17 @@ int find_symbol_hole_containing(const struct section *sec, unsigned long offset)
 	if (n)
 		return 0; /* not a hole */
 
-	/* didn't find a symbol for which @offset is after it */
-	if (!hole.sym)
-		return 0; /* not a hole */
+	/*
+	 * @offset >= sym->offset + sym->len, find symbol after it.
+	 * When hole.sym is empty, use the first node to compute the hole.
+	 * If there is no symbol in the section, the first node will be NULL,
+	 * in which case, -1 is returned to skip the whole section.
+	 */
+	if (hole.sym)
+		n = rb_next(&hole.sym->node);
+	else
+		n = rb_first_cached(&sec->symbol_tree);
 
-	/* @offset >= sym->offset + sym->len, find symbol after it */
-	n = rb_next(&hole.sym->node);
 	if (!n)
 		return -1; /* until end of address space */
 
-- 
2.46.1.824.gd892dcdcdd-goog


