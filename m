Return-Path: <linux-arch+bounces-1790-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4311A8411B3
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 19:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF721288258
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 18:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC9015AAB9;
	Mon, 29 Jan 2024 18:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PePKihMI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADAC15AAAE
	for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 18:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551563; cv=none; b=GFkOxnSZhqZIYYQjibZjHg+P1LS7W63EfirorE4W4v6YIQYjIysdr2mBDMDQZ3bXufjx3cnc+xEOeq0t/RYOF+ORiuefb12aZzS33fCenYFAvbr/O4VpdwHTgj61uM4p+mJozz99bV2/CxgR08JUg8zLvhNgXeNWrHjEL7YNu4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551563; c=relaxed/simple;
	bh=ywQcTtrCDMHJcI+QkXWX2nFyJwoVE8xehI2i+Z3nGsk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d8G1Yg2a6LhI1C2hqO0uQxCP4f2uMxB8+X1U2DVD4dy8+uYUH6dSS8+lsBAwbREfVD3UrQjwcU3iIsMjVXMFBF51Ln9Bhfd1zKr9SJSV2gVd+u39mzs+34ge6qoXHtHWqhXEm36z4iGW69xa9XZjiEdbsfyI0XirdKQK3AbJ4Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PePKihMI; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-33af3a64df6so416937f8f.1
        for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 10:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706551560; x=1707156360; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fLLl1bcVbRYtnIzLBeH2xJGti8beoepv/z/uSZlJPHo=;
        b=PePKihMIIMoDRiafr8/B5H0JSooV6zBWN12mgzsMtuezB4BxjNtZqUuUwJ0AX7Jo1X
         LTg84Ia83obzKLG+p06g835IqPxjaUAKnuOAyRCW+dSe2tDftB5D4lpvIi9oUgVDMAfA
         upbEeHjGTvTxNgCeGTYe1kYJ1f0pB4gdN9AgmDBul4vNOGGv221vJmK6BeQkqs2wl155
         pGy8ltGR0DTI01dlvkwIcEPlAwAC7pYA5ILDkBklmYCpkh1EG7xhbzDCkmadwkBWDg0n
         fzyEBI18fOPI89duJF+eQ+wnTJVV4XDHXp6/xAZm3Q2x13N2V1iYeMp86YnevNLWM/4a
         TfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706551560; x=1707156360;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLLl1bcVbRYtnIzLBeH2xJGti8beoepv/z/uSZlJPHo=;
        b=Vq2NERia1cEnuZoCjEtm7xlWbrI9i5dH8gts5nTKBeeduqXv20yi06hJ+U6BG0Lgsq
         b302OvT/fKscLD5UVH7j/ZvEBUjIza3M97uy68EwDDfpOAhF7i2zdeIPZtp6RYNeLhEC
         3A8XmUWzc71Y4590aSwtUW00ChNXTQySCVoRdemT/sJwGu6/KrDWYiOhGG2aYQkXdI0W
         vN5VfNj3SPpPE5iX51ffRBYwmW4amibaxHJlzbVKDSZABpASso9L3tsVT2moari8zpnf
         TQbR7v7rzk0NYxPV5hr2DZiD9MtEmQqioGjQNGmjheAHKwYgKK3eeUGIoK96w7VL4opd
         mXbQ==
X-Gm-Message-State: AOJu0YwTpoe79L2YdSFv9R9zrxPyULMXfgGXtzs+gF8wPFwP8ttYrfIC
	m/7MJZdrAlSHT/lpG7LLO1EaUU7XCqxlHLVzD2w0Ja7ATUQOU6dNTYB9Hk3rdqfPSs2hSg==
X-Google-Smtp-Source: AGHT+IFRYaQgWgn7lS/fBsOiZY67lNa50V8yvvYuuoCz5vPDJOnfUaUEOPLRn1IO8EMDt34AydE5rmRl
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6000:1e06:b0:33a:e517:57f1 with SMTP id
 bj6-20020a0560001e0600b0033ae51757f1mr89123wrb.0.1706551560216; Mon, 29 Jan
 2024 10:06:00 -0800 (PST)
Date: Mon, 29 Jan 2024 19:05:16 +0100
In-Reply-To: <20240129180502.4069817-21-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240129180502.4069817-21-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=979; i=ardb@kernel.org;
 h=from:subject; bh=DDaOUA3J+CFMHhm3e2XXAeDqtyhjkdr8A2J8hJRp8QM=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXX7i7vMP9b7C0XfsczNYLSSucj1x3p6wJuiY837VhzfN
 +vbpewPHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiakcYGVby7QyTU6idwMOc
 J38qUmJ1p+F91buzM3Z8Xzphas7LJ+sZGZYqnkl8ycjtbnKv6+ovZ1E/e8uaWONjpw6xe+z87Cp rxgYA
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129180502.4069817-34-ardb+git@google.com>
Subject: [PATCH v3 13/19] modpost: Warn about calls from __pitext into other
 text sections
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Ensure that code that is marked as being able to safely run from a 1:1
mapping does not call into other code which might lack that property.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 scripts/mod/modpost.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 962d00df47ab..33b56d6b4e7b 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -825,6 +825,7 @@ enum mismatch {
 	ANY_INIT_TO_ANY_EXIT,
 	ANY_EXIT_TO_ANY_INIT,
 	EXTABLE_TO_NON_TEXT,
+	PI_TEXT_TO_NON_PI_TEXT,
 };
 
 /**
@@ -887,6 +888,11 @@ static const struct sectioncheck sectioncheck[] = {
 	.bad_tosec = { ".altinstr_replacement", NULL },
 	.good_tosec = {ALL_TEXT_SECTIONS , NULL},
 	.mismatch = EXTABLE_TO_NON_TEXT,
+},
+{
+	.fromsec = { ALL_PI_TEXT_SECTIONS, NULL },
+	.bad_tosec = { ALL_NON_PI_TEXT_SECTIONS, NULL },
+	.mismatch = PI_TEXT_TO_NON_PI_TEXT,
 }
 };
 
-- 
2.43.0.429.g432eaa2c6b-goog


