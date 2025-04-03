Return-Path: <linux-arch+bounces-11243-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B717BA7A841
	for <lists+linux-arch@lfdr.de>; Thu,  3 Apr 2025 18:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D21F1894323
	for <lists+linux-arch@lfdr.de>; Thu,  3 Apr 2025 16:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253332512FB;
	Thu,  3 Apr 2025 16:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g204yCj1"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DCA2512E8
	for <linux-arch@vger.kernel.org>; Thu,  3 Apr 2025 16:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743699430; cv=none; b=oJORvjI6J3n1MHYr6Bsx0SnyquzymSEZbxsKmGPNQeGi+GtIoZ+FDo+DU4yDZSQ9OJiufGaMXvA6BoDJJ+wBy1v8mmPAT1VwzY+Dz+E97kleG++T9xUKWQ3amg7tLP3orat2XajFl8x9fLJ52d7XDsVnEk5Fc0Omu3/hJd4bEms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743699430; c=relaxed/simple;
	bh=fdOp0vaeXCptqfAjSbXItKngfrBjdP7k4t4yM8BWbPY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=VIo483NMD35hflzgrUOiTChqracHpQjH6JhqCIL+4YFUNBv1yZM1awhWFFDv6NcdHB8WRS2u1/vebvhmSj3UxjmO1IDzX0N2GFvbKVjy9M/noRyKJtXU75SUjWoanpcPJ8r7bmmSL3DBzcWKSyH1naHpzJfQpTHfvEWatKrNjmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g204yCj1; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2240a96112fso16104105ad.2
        for <linux-arch@vger.kernel.org>; Thu, 03 Apr 2025 09:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743699428; x=1744304228; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KniokNw71uZt3EWA3MKzISYWsuZYW7vx6n4uto9whYI=;
        b=g204yCj1y+OF0HXoxb4MApMnUiKAQDrjS5ruRP/f0NIenHGDmANkQnTnilfWsXSWfc
         TcsZl6r4j5bqtK3wd4NZINK2hbH64hAKW6HSU9UmAWPixtPxy/m7Eb2quUAgAyP0BxKp
         br9Pw/qs+d2IWGUc9aATR/meCQJ3VJoiSFysZnhyv25LPSz2kkxSRMzW9CSHFyVEkU6D
         gcwsNGNJSPUL87KKcv6u9AWVzTHo9gp9uhDJVuXtfRFCPG4jfp05LkpZHCZN0Ug6hOgF
         DsPVoyqSvxw30RBH01WFAtb/iNCGMz1LFXdOP/dnGlDACnHHrO/ZpI5HDyl9JX4nN3wh
         dsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743699428; x=1744304228;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KniokNw71uZt3EWA3MKzISYWsuZYW7vx6n4uto9whYI=;
        b=UWzF2+kvP6fTPXAiGfcV1zHAH+9213lTBQkz8blZ7Yfhc/MCnptB1uz4D+70+KC+Vj
         JSJ6RdJKjtii91F8hrX/9+Y7pyB5wDiveaKLT6mAIWysaLELGR50Bbqat9KTUGZNvkNa
         +Ne2q0no+y79mwNxzU6zYHnLI4louXMSSjCDvkc6n6PbQDw4D2G9GntUSGPysesV/rIw
         JrTDFEIzr9pZoblYV4dEhkoBNuLsYsyO8MnjazWF2im0rhzMHHW5XCXvn/C67vEHhi7w
         YzmP2FONVccpEut/fmSrBSe3ncUqr/KM12OvP0PQBOxx5Wcmb+lWDCMOmYmoRjKeCd+b
         tx1w==
X-Forwarded-Encrypted: i=1; AJvYcCVa9AKqUoWQRoU9kYU1UnvdHjvj0NFTqtmDeuHk2sWuFeUFAkO8750UZ87ZjhwcSB6jGQgrMT7FRxl7@vger.kernel.org
X-Gm-Message-State: AOJu0YwaLiiJd7vhOio+kB3IqzEMqIiFfIKaIlAQ5nD8u6/j47h//8A9
	2k4R7fdQEErLlrwLFAqAGmxV/aVKYdG2OBIitEeijObJ52zHkw9asZ9ZkDlfoSk+70GOAR+FRYP
	j9wdPDg==
X-Google-Smtp-Source: AGHT+IHIlj/ZnHOBNDNsCb4540qonImmu1XaeLfZnMmaQauAJSUWy8yWztGxmNvCylihSdUp2wrZRIuXuhrh
X-Received: from plsu6.prod.google.com ([2002:a17:902:bf46:b0:226:35f8:66fb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:41cb:b0:224:1acc:14db
 with SMTP id d9443c01a7336-22977d97f60mr49062095ad.29.1743699427861; Thu, 03
 Apr 2025 09:57:07 -0700 (PDT)
Date: Thu,  3 Apr 2025 09:56:57 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250403165702.396388-1-irogers@google.com>
Subject: [PATCH v1 0/5] Silence some clang -Wshorten-64-to-32 warnings
From: Ian Rogers <irogers@google.com>
To: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Jakub Kicinski <kuba@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Clang's shorten-64-to-32 can be useful to spot certain kinds of bugs
that can be more prevalent in C code due to implicit 64 to 32-bit
casting. Add some explicit casts to header files so as to avoid the
warning when these headers are used.

This patch started out as a single patch in a series for the perf tool
where a bug could have been identified were -Wshorten-64-to-32
enabled:
https://lore.kernel.org/lkml/20250401182347.3422199-3-irogers@google.com/

Ian Rogers (5):
  bitfield: Silence a clang -Wshorten-64-to-32 warning
  bitmap: Silence a clang -Wshorten-64-to-32 warning
  bitops: Silence a clang -Wshorten-64-to-32 warning
  math64: Silence a clang -Wshorten-64-to-32 warning
  hash.h: Silence a clang -Wshorten-64-to-32 warning

 include/asm-generic/bitops/fls64.h | 2 +-
 include/linux/bitfield.h           | 2 +-
 include/linux/bitmap.h             | 2 +-
 include/linux/hash.h               | 2 +-
 include/linux/math64.h             | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.49.0.504.g3bcea36a83-goog


