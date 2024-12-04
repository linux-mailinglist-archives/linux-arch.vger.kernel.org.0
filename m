Return-Path: <linux-arch+bounces-9243-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3EC9E340F
	for <lists+linux-arch@lfdr.de>; Wed,  4 Dec 2024 08:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F92FB21412
	for <lists+linux-arch@lfdr.de>; Wed,  4 Dec 2024 07:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9DE18B492;
	Wed,  4 Dec 2024 07:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sj/XXw08"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2E3184
	for <linux-arch@vger.kernel.org>; Wed,  4 Dec 2024 07:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733297089; cv=none; b=TWYhaTNpxwb0Z85qR9wjWliz8tG9prufr7XLdBKgJymoAB4t7uqJHZq13JY2aliMNYLNGSVWC16MgzPKeLMCWq8gSm+Z0UP5ZVUIhQcpgbeGh6slj2Ms/qkUTzbF9r7oJzSsTKHTo6KUm43FZRe4+4SuQDGmgVew5av4IpVXO1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733297089; c=relaxed/simple;
	bh=Zd6OM8mfIHwQekpkQRNZQXKHnnK+oph2sfEB9l/vHwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flAr+Bj2lPl43CHDrjP/hrjO3X8xZJQZRXjv1BmiamR3/hUjwG9fuHVrg73fSFZUZVH5F58hEIOsld2F7+48bRw7Mjbr+WkaCIoLERufO4oCMgslGddpnzZHJYYuepoqPbArZt8Ry22VShamnAieEUVk8kCm7FfKogWuihX6h7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sj/XXw08; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434a95095efso3007395e9.0
        for <linux-arch@vger.kernel.org>; Tue, 03 Dec 2024 23:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733297085; x=1733901885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q7HALTGcIVNAPzHCr/BGJOOtFQkHmcHLgf3NzrBrnCw=;
        b=sj/XXw08LyQrnY9jqn2BrnlUWQKWjAPv998YN8g0Y9XlZXKmH+nIImbWwPisYoGMf0
         ZgZyTUZWYSr7Higjk4ZBcOc/kQs3UQnrqEj3JOpumaQOfm3B7F2fOYgyip786ZImOw/P
         jLIRLIOKeKmfkVXe+BKA66UhkKFA8E8rkV1yFgRI5Bwka/MMXWN1Lo2/mUNUXHe5ImMd
         uQAlAVOv6SIxApN+OddTz7Xt+Ajy6NK9Gg+ULUZoNVbytQbDuY0jPy6oLK8Ou5hq4djb
         XkRJUohDCP7rM6ZBwCa3bLG/CtM7ptLiYD/rfCROBmGdHQWlYLPBz8iLwBbH2gsU2YR6
         xRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733297085; x=1733901885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7HALTGcIVNAPzHCr/BGJOOtFQkHmcHLgf3NzrBrnCw=;
        b=UQ7Au3xrEfGHakK4RaVxsOc3OJ45RpoZPcuYqOF6j+pbCAhuy1PVVYlJOYwcJal/yJ
         +c07QYQtOfmAwqOWuK69Vf73zICfnrOh8M2xYQrXxhVqPJdwNV+fbM70+SoLn+uoecJ8
         lHltDrHEqhUKCE7Jhdzwb7TxqZcwzvx1iYTNVRYh1Oh/7i4YOzCyS9gObF6+2SUYPq6Q
         /q5HWOaqLWTQlHyKl5lyC6ZJF/YqyZigPs54cIKSIMmfygw4PxC+rBIfaFUCfITCaLdP
         t2q7utt2b6lg19SPTlOaTi8CfNzJxbmgKRN/uIBfHYCycfbLX6ASmVUDA7TqqVnpzbzB
         vQ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXRP74IB3Few1vb2SQwJvZTbvhMLHG42WWVOW6CbtkqN3qjQmcx/WiUBVX8TzDNPFdeebMZjQ1T4icC@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu9MZxKEu0rh1SJmaj24FDU2br47uaxQzZZNOC/zIxzoPs/RJ2
	VWw53TtzpP2R/04bwpflGSRyxQYG9ap01noUZQbFmVDXCqz50JflczAgQCIz5sQ=
X-Gm-Gg: ASbGncsnQyp+oESgKdLoZlfBjIu7Jy/dlMfiqtdG+Gp7B1znHB3utujzNjuml2JwoPQ
	pFMlz8aWJRVlZ6/4uscGRHxfreaEwsjRx5vtQjbU8uHA0MAjIyXI+tWes6DP/aZqLNvbbbmfbQp
	tIq6oh3QnVXC+LX7g6BCiAu/WaWJoE1nOQZeOctdkuIBweF26hyZ/e7NB/qgKi+vMkrR82cRaoi
	kulrmhyVeFOhBXnNmee+p3AhYCu9YFnRqWsKu5vsYGw0Es+Nd27VOo=
X-Google-Smtp-Source: AGHT+IHZjJV3X8DRwpZM2LIoO92mMGlR//mHmz04yaqsi0BXvmxHIJLtu+q3X/2NMlr6oqVbQxPx4A==
X-Received: by 2002:a5d:64e6:0:b0:385:dedb:a15b with SMTP id ffacd0b85a97d-385fd9ac147mr4271554f8f.24.1733297085485;
        Tue, 03 Dec 2024 23:24:45 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd3a410sm17723351f8f.46.2024.12.03.23.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 23:24:44 -0800 (PST)
Date: Wed, 4 Dec 2024 10:24:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-sparse@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	linux-arch@vger.kernel.org, netdev@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Nadav Amit <nadav.amit@gmail.com>, Brian Gerst <brgerst@gmail.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/6] Enable strict percpu address space checks
Message-ID: <5b8d0dee-8fb6-45af-ba6c-7f74aff9a4b8@stanley.mountain>
References: <20241126172332.112212-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126172332.112212-1-ubizjak@gmail.com>

On Tue, Nov 26, 2024 at 06:21:17PM +0100, Uros Bizjak wrote:
> This patchset enables strict percpu address space checks via x86 named 
> address space qualifiers. Percpu variables are declared in
> __seg_gs/__seg_fs named AS and kept named AS qualified until they
> are dereferenced via percpu accessor. This approach enables various
> compiler checks for cross-namespace variable assignments.
> 
> Please note that current version of sparse doesn't know anything about
> __typeof_unqual__() operator. Avoid the usage of __typeof_unqual__()
> when sparse checking is active to prevent sparse errors with unknowing
> keyword.

I don't think it would be super hard to add support to Sparse.  The only places
where typeof and typeof_unqual are different is that you have to mask away the
qualifiers in examine_typeof()?

I would take over Sparse maintainership but I'm far too sloppy to do it.  We
should get Greg to take over, he likes abandoned projects.  ;)

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 ast-inspect.c |  1 +
 ctags.c       |  1 +
 dissect.c     |  1 +
 evaluate.c    |  3 ++-
 parse.c       | 24 +++++++++++++++++++++---
 show-parse.c  |  1 +
 symbol.c      | 17 ++++++++++++++++-
 symbol.h      |  1 +
 8 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/ast-inspect.c b/ast-inspect.c
index b510cd9b1d2c..e940a93a411e 100644
--- a/ast-inspect.c
+++ b/ast-inspect.c
@@ -110,6 +110,7 @@ static const char *symbol_type_name(enum type type)
 		[SYM_UNION] = "SYM_UNION",
 		[SYM_ENUM] = "SYM_ENUM",
 		[SYM_TYPEOF] = "SYM_TYPEOF",
+		[SYM_TYPEOF_UNQUAL] = "SYM_TYPEOF_UNQUAL",
 		[SYM_BITFIELD] = "SYM_BITFIELD",
 		[SYM_LABEL] = "SYM_LABEL",
 		[SYM_RESTRICT] = "SYM_RESTRICT",
diff --git a/ctags.c b/ctags.c
index aa5f9718d847..afdc42b77b98 100644
--- a/ctags.c
+++ b/ctags.c
@@ -151,6 +151,7 @@ static void examine_symbol(struct symbol *sym)
 		sym->kind = 'e';
 	case SYM_PTR:
 	case SYM_TYPEOF:
+	case SYM_TYPEOF_UNQUAL:
 	case SYM_BITFIELD:
 	case SYM_FN:
 	case SYM_ARRAY:
diff --git a/dissect.c b/dissect.c
index 300d5ca99c97..9419c5931fbb 100644
--- a/dissect.c
+++ b/dissect.c
@@ -212,6 +212,7 @@ static void examine_sym_node(struct symbol *node, struct symbol *parent)
 	while ((base = node->ctype.base_type) != NULL)
 		switch (base->type) {
 		case SYM_TYPEOF:
+		case SYM_TYPEOF_UNQUAL:
 			node->ctype.base_type =
 				do_expression(U_VOID, base->initializer);
 			break;
diff --git a/evaluate.c b/evaluate.c
index fe716f631987..85a6447ba3ce 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -358,7 +358,8 @@ static inline int classify_type(struct symbol *type, struct symbol **base)
 	};
 	if (type->type == SYM_NODE)
 		type = type->ctype.base_type;
-	if (type->type == SYM_TYPEOF) {
+	if (type->type == SYM_TYPEOF ||
+	    type->type == SYM_TYPEOF_UNQUAL) {
 		type = examine_symbol_type(type);
 		if (type->type == SYM_NODE)
 			type = type->ctype.base_type;
diff --git a/parse.c b/parse.c
index f868bf63a0f5..95894bf5e54d 100644
--- a/parse.c
+++ b/parse.c
@@ -54,7 +54,7 @@ static struct token *handle_attributes(struct token *token, struct decl_state *c
 typedef struct token *declarator_t(struct token *, struct symbol *, struct decl_state *);
 static declarator_t
 	struct_specifier, union_specifier, enum_specifier,
-	attribute_specifier, typeof_specifier,
+	attribute_specifier, typeof_specifier, typeof_unqual_specifier,
 	storage_specifier, thread_specifier;
 static declarator_t generic_qualifier;
 static declarator_t autotype_specifier;
@@ -196,6 +196,13 @@ static struct symbol_op typeof_op = {
 	.set = Set_S|Set_T,
 };
 
+static struct symbol_op typeof_unqual_op = {
+	.type = KW_SPECIFIER,
+	.declarator = typeof_unqual_specifier,
+	.test = Set_Any,
+	.set = Set_S|Set_T,
+};
+
 static struct symbol_op autotype_op = {
 	.type = KW_SPECIFIER,
 	.declarator = autotype_specifier,
@@ -480,6 +487,7 @@ static struct init_keyword {
 	/* Typedef ... */
 	N("typedef",		&typedef_op,	.mods = MOD_USERTYPE),
 	A("typeof",		&typeof_op),
+	A("typeof_unqual",	&typeof_unqual_op),
 	N("__auto_type",	&autotype_op),
 
 	/* Type qualifiers */
@@ -1052,7 +1060,7 @@ static struct token *enum_specifier(struct token *token, struct symbol *sym, str
 	return ret;
 }
 
-static struct token *typeof_specifier(struct token *token, struct symbol *sym, struct decl_state *ctx)
+static struct token *typeof_specifier_helper(struct token *token, struct symbol *sym, struct decl_state *ctx, bool qual)
 {
 
 	if (!match_op(token, '(')) {
@@ -1065,7 +1073,7 @@ static struct token *typeof_specifier(struct token *token, struct symbol *sym, s
 		ctx->ctype.base_type = sym->ctype.base_type;
 		apply_ctype(token->pos, &ctx->ctype, &sym->ctype);
 	} else {
-		struct symbol *typeof_sym = alloc_symbol(token->pos, SYM_TYPEOF);
+		struct symbol *typeof_sym = alloc_symbol(token->pos, qual? SYM_TYPEOF : SYM_TYPEOF_UNQUAL);
 		token = parse_expression(token->next, &typeof_sym->initializer);
 
 		typeof_sym->endpos = token->pos;
@@ -1078,6 +1086,16 @@ static struct token *typeof_specifier(struct token *token, struct symbol *sym, s
 	return expect(token, ')', "after typeof");
 }
 
+static struct token *typeof_specifier(struct token *token, struct symbol *sym, struct decl_state *ctx)
+{
+	return typeof_specifier_helper(token, sym, ctx, true);
+}
+
+static struct token *typeof_unqual_specifier(struct token *token, struct symbol *sym, struct decl_state *ctx)
+{
+	return typeof_specifier_helper(token, sym, ctx, false);
+}
+
 static struct token *autotype_specifier(struct token *token, struct symbol *sym, struct decl_state *ctx)
 {
 	ctx->ctype.base_type = &autotype_ctype;
diff --git a/show-parse.c b/show-parse.c
index e2fc18bb4b3d..ceb6b3cb6f82 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -59,6 +59,7 @@ static void do_debug_symbol(struct symbol *sym, int indent)
 		[SYM_UNION] = "unin",
 		[SYM_ENUM] = "enum",
 		[SYM_TYPEOF] = "tpof",
+		[SYM_TYPEOF_UNQUAL] = "tpof_unqual",
 		[SYM_BITFIELD] = "bitf",
 		[SYM_LABEL] = "labl",
 		[SYM_RESTRICT] = "rstr",
diff --git a/symbol.c b/symbol.c
index 91352a3a447b..7060acb666d9 100644
--- a/symbol.c
+++ b/symbol.c
@@ -541,7 +541,7 @@ static struct symbol *examine_pointer_type(struct symbol *sym)
 	return sym;
 }
 
-static struct symbol *examine_typeof(struct symbol *sym)
+static struct symbol *examine_typeof_helper(struct symbol *sym, bool qual)
 {
 	struct symbol *base = evaluate_expression(sym->initializer);
 	unsigned long mod = 0;
@@ -550,6 +550,8 @@ static struct symbol *examine_typeof(struct symbol *sym)
 		base = &bad_ctype;
 	if (base->type == SYM_NODE) {
 		mod |= base->ctype.modifiers & MOD_TYPEOF;
+		if (!qual)
+			mod &= ~MOD_QUALIFIER;
 		base = base->ctype.base_type;
 	}
 	if (base->type == SYM_BITFIELD)
@@ -560,6 +562,16 @@ static struct symbol *examine_typeof(struct symbol *sym)
 	return examine_node_type(sym);
 }
 
+static struct symbol *examine_typeof(struct symbol *sym)
+{
+	return examine_typeof_helper(sym, true);
+}
+
+static struct symbol *examine_typeof_unqual(struct symbol *sym)
+{
+	return examine_typeof_helper(sym, false);
+}
+
 /*
  * Fill in type size and alignment information for
  * regular SYM_TYPE things.
@@ -595,6 +607,8 @@ struct symbol *examine_symbol_type(struct symbol * sym)
 		return sym;
 	case SYM_TYPEOF:
 		return examine_typeof(sym);
+	case SYM_TYPEOF_UNQUAL:
+		return examine_typeof_unqual(sym);
 	case SYM_PREPROCESSOR:
 		sparse_error(sym->pos, "ctype on preprocessor command? (%s)", show_ident(sym->ident));
 		return NULL;
@@ -628,6 +642,7 @@ const char* get_type_name(enum type type)
 	[SYM_UNION] = "union",
 	[SYM_ENUM] = "enum",
 	[SYM_TYPEOF] = "typeof",
+	[SYM_TYPEOF_UNQUAL] = "typeof_unqual",
 	[SYM_BITFIELD] = "bitfield",
 	[SYM_LABEL] = "label",
 	[SYM_RESTRICT] = "restrict",
diff --git a/symbol.h b/symbol.h
index 88130c15d4bd..3552d4391621 100644
--- a/symbol.h
+++ b/symbol.h
@@ -65,6 +65,7 @@ enum type {
 	SYM_UNION,
 	SYM_ENUM,
 	SYM_TYPEOF,
+	SYM_TYPEOF_UNQUAL,
 	SYM_BITFIELD,
 	SYM_LABEL,
 	SYM_RESTRICT,
-- 
2.45.2


