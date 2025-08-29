Return-Path: <linux-arch+bounces-13337-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA41B3B97B
	for <lists+linux-arch@lfdr.de>; Fri, 29 Aug 2025 12:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 957DC1CC0C9B
	for <lists+linux-arch@lfdr.de>; Fri, 29 Aug 2025 10:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1BC3164DD;
	Fri, 29 Aug 2025 10:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RowSZijb"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6CC314A9F
	for <linux-arch@vger.kernel.org>; Fri, 29 Aug 2025 10:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756464883; cv=none; b=El2wFWLpHGt2dcmmYFIem181eC6NFc05o254xXTMzsk6b5Ko1vzNyXIl+A3jCexCa6y+bXybkbX2Z724erxBqXJs8qyQaCXaeWNSP2pczlfbOMGun8x8toBmQ/Gih7AavUMY4yl5y5DCS4ClRukg5Y+/r8ZfwsCVy8XlgBVZnx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756464883; c=relaxed/simple;
	bh=dffa0L6234ztRx9C96gKJmKJajvyCWjO/vN19K5vk8I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OJPWmafjfiAryiPjGFA/ludTYCF3TvX6/FOHLkN/4urrrVXoebAg5161pb8IOD9pNdeYn00LjDKaMQlk/auud1yhI+lKpnDSktMh4xGZF9w7LsbgysyML+KjijhgHMyQY/o7lInBPh7Qw8xxXjeOD1iCUWitRYzMAkF4TuZcyPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RowSZijb; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3c584459d02so1273916f8f.0
        for <linux-arch@vger.kernel.org>; Fri, 29 Aug 2025 03:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756464879; x=1757069679; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=enXXJwtnX6u3ZFaViBZUrEuTl1Z1GtEQPAAtWrQl1uo=;
        b=RowSZijbnosPDZitROCFUrCrCmw9+GNPVwsIzaloRPXtrpSy9qj94pOwfGirV9HQtW
         6zQepS4zggglD0kzFsQPakFq2ilqXGg0SkPiOVHHNepAPH7fQZtpjSlGuRqjvr8Qex0e
         FRXZJb+eXk43dTSm2c6rSD46JBTu/4BMJecCH3cylRoY4mUD2yXk8kP4qFaK+iOj+iY+
         Ookoj+oQFxeSCvgVfLbL1ApZRr73o4AmXGl/3cjVM3GIXcBKqbSJ/6o/ioeX1H/fJ4E9
         /iJccqhkw/h0OzL1yp5bsS4BOsTVoJ+Ml/HuQmZDZmArPRIQi2N3g/LTkUUwtqoPs5qp
         3zsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756464879; x=1757069679;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=enXXJwtnX6u3ZFaViBZUrEuTl1Z1GtEQPAAtWrQl1uo=;
        b=IdbgjT5/gTN+aP4TKxyevTeVBjq30g5yOXghC9gZCzzUzCTGnD/x9jjI2D4mYgqlrc
         OXuUbQqWGPS94419jfjmj+MyMJ00lzfVF0ZCmgFkC0ZrVfEuYqhK4NnM+zRUtDH11yjb
         DDGylvHR0+lszcd59dLTexpsyn62Jwx1B8kGDEvfJokrI7/IsNz2o547aFWEbOrvEJiy
         0LGsJFYvvdruWlD63pzS3g9ggmzoot08bKfcWAHewN2ug3Ip4EreGvB/pbA7pH29g+p7
         bjkix7t9lBOkMPpPPlvYMdGUheYtjcQ30OvJJZbLgtmiCuZQJGfyi/pQ6gI2Z/PKeSVl
         5XHA==
X-Forwarded-Encrypted: i=1; AJvYcCV2Jvp1LYQhmuoQtSFOBIs2Se2rZ+boT2cXAxt41FvLIJjTR5BX0LcP16lc1K3bsmq22Yc8omyBX+qz@vger.kernel.org
X-Gm-Message-State: AOJu0YyT083wi+CQu3J8hy3CNIBDaB+eo0Dsv2TtBLP+LDCqoXRNrEXL
	1UYSYEUHRnHnr4pSOQmHoam4JnQwpPXYGoqPU9pLT93jMCDA4RXnbfNfcrQIL+t9peDlslEvxRC
	bAl4moOpQXhqEPcUDpw==
X-Google-Smtp-Source: AGHT+IGg/yFiglPyxsXk2HLgEh4ox4wWOVB+V0V2/cy4dlrL4d8IE17mWIFRoJoeOCGIJ/ix3IDhjY7+D14g08c=
X-Received: from wmbjg19.prod.google.com ([2002:a05:600c:a013:b0:459:de2a:4d58])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:40c9:b0:3c9:52db:9f64 with SMTP id ffacd0b85a97d-3c952dba323mr13516384f8f.22.1756464879493;
 Fri, 29 Aug 2025 03:54:39 -0700 (PDT)
Date: Fri, 29 Aug 2025 10:54:18 +0000
In-Reply-To: <20250829105418.3053274-1-sidnayyar@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829105418.3053274-1-sidnayyar@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250829105418.3053274-11-sidnayyar@google.com>
Subject: [PATCH 10/10] module loader: enforce symbol import protection
From: Siddharth Nayyar <sidnayyar@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>
Cc: Nicolas Schier <nicolas.schier@linux.dev>, Petr Pavlu <petr.pavlu@suse.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Siddharth Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="UTF-8"

The module loader will reject unsigned modules from loading if such a
module attempts to import a symbol which has the import protection bit
set in the kflagstab entry for the symbol.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
---
 kernel/module/internal.h |  1 +
 kernel/module/main.c     | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 061161cc79d9..98faaf8900aa 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -108,6 +108,7 @@ struct find_symbol_arg {
 	const u32 *crc;
 	const struct kernel_symbol *sym;
 	enum mod_license license;
+	bool is_protected;
 };
 
 /* modules using other modules */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 4437c2a451ea..ece074a6ba7b 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -380,6 +380,7 @@ static bool find_exported_symbol_in_section(const struct symsearch *syms,
 	fsa->crc = symversion(syms->crcs, sym - syms->start);
 	fsa->sym = sym;
 	fsa->license = (sym_flags & KSYM_FLAG_GPL_ONLY) ? GPL_ONLY : NOT_GPL_ONLY;
+	fsa->is_protected = sym_flags & KSYM_FLAG_PROTECTED;
 
 	return true;
 }
@@ -1273,6 +1274,11 @@ static const struct kernel_symbol *resolve_symbol(struct module *mod,
 		goto getname;
 	}
 
+	if (fsa.is_protected && !mod->sig_ok) {
+		fsa.sym = ERR_PTR(-EACCES);
+		goto getname;
+	}
+
 getname:
 	/* We must make copy under the lock if we failed to get ref. */
 	strscpy(ownername, module_name(fsa.owner), MODULE_NAME_LEN);
@@ -1550,8 +1556,12 @@ static int simplify_symbols(struct module *mod, const struct load_info *info)
 				break;
 
 			ret = PTR_ERR(ksym) ?: -ENOENT;
-			pr_warn("%s: Unknown symbol %s (err %d)\n",
-				mod->name, name, ret);
+			if (ret == -EACCES)
+				pr_warn("%s: Protected symbol %s (err %d)\n",
+					mod->name, name, ret);
+			else
+				pr_warn("%s: Unknown symbol %s (err %d)\n",
+					mod->name, name, ret);
 			break;
 
 		default:
-- 
2.51.0.338.gd7d06c2dae-goog


