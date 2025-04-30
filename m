Return-Path: <linux-arch+bounces-11754-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C879AA5270
	for <lists+linux-arch@lfdr.de>; Wed, 30 Apr 2025 19:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B259A1B36
	for <lists+linux-arch@lfdr.de>; Wed, 30 Apr 2025 17:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C45165F13;
	Wed, 30 Apr 2025 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CKZV7+v+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BE825E440
	for <linux-arch@vger.kernel.org>; Wed, 30 Apr 2025 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746033342; cv=none; b=YxsapIn5Ai1WE8WBmsQMn4S67sGMFbFg5VNLQU6D9H9TzENYK7VMx+97506T4PwueM0HYUpStfB43dnjfYC7v2xgVR7BV1HBXeIl3R/Ba1eA+n9cpBq8YmGDfK4Sr3XG1A7Sn1QzP8wyAynqfr70O00aPx7SJRuByLZEFicXELc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746033342; c=relaxed/simple;
	bh=a1OE5bfqiQpD3wUqlPPLecFwn0/TgL4JwzH7YA5a96I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=qpohYBKouPdde3OqcFEyePCHvsT81LUtxUaJ8+U0qR9UlX8nVOiPdBh0fzTfveYKLCnyzjd8Az1JdvY9pPQc/s/pcnNKBDbncdsErHbGZawb1VwHlua/YYQrkHUh4TLIoVeXqmMpCzwG3RN7QCuEy52p2Lzmg2LMjUela0XCQ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CKZV7+v+; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-af8f28f85a7so32253a12.2
        for <linux-arch@vger.kernel.org>; Wed, 30 Apr 2025 10:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746033340; x=1746638140; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2l6EpSn49twaG/1RM3U2XqpvkRe6FWEsiPTfIGBFJKk=;
        b=CKZV7+v+XqB+eJFxYGGWtpU9caUc4ZRN1HuxhZXHfbOTcz6zoe+1HDakACaCwvr0v/
         c16wy5ntS+PcxuklMLxmQ3n9xdqquA2/3cVj1Sqz9WdK55ASlLEbCCrmgevyvBIciQhw
         mpqJH89ypTJ1ELKqP6xNBaVoqWoCQkV2tv2f+USmNr2d3vBg4e+lURuOkZgS7v5L51Zj
         H743/he3U8UPxjE6StyRhpD8w/2dlYUSrASyKECtXEIZH4mX9ILRaqAaKraq6XZ8ynFG
         JTFpZSwB901Wpkpgk1YspfHD3pJ0IKfGYBCi/nM5Ypnb4ItpvX7m8CAQVFWlS4/WhtJc
         oBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746033340; x=1746638140;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2l6EpSn49twaG/1RM3U2XqpvkRe6FWEsiPTfIGBFJKk=;
        b=D2wbCLAkjMjy1rT0CIjUhGzezwGYKyGgAcatz5D4oVWLq7iSQxUT3dy/71qbdf7+LM
         maIn3ws7YYplyb048wbuvDXosYewdgC7+cVTBB+unlozVBlDdtMsR0TS7mrcuKkdrU0F
         lsvk3dWqb6s2xP60K2YPUvtolOZBPPX+6BaK48PRFv/PnsDQdurySWI7A17GdVeitt2d
         3S/a9Bym0FrmRokftM0roIRFh/kM/Se8pFsAhajptXDQf2QozVDpprLSibFDN4Ecc25j
         pFOyM4uFOT+r+qYNDj5MbWJ7AYnjlKVhGvON+pE/fsuRwlEwYBaGMtr0Brs28NUEqnX+
         cp0A==
X-Forwarded-Encrypted: i=1; AJvYcCXLWCxOFPg3JgQYrnSUlCXK0jGjQPhKyiDiyUG830WMpjsppQBLYMpbMnRen7b2sEk7KWg7zkc9WHrW@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+2YiWirLGuopuycjEFWu+hwpa+ZgmqeeSR+HByPQTGBf5XnB8
	KMNK8NhCnCu0oL9LpwqUBflg6Or4CZQccmtCYhjCY1/xH1JbPjsEbYFdD1dpgLv0qa5MuU8p5WW
	ib0PBKQ==
X-Google-Smtp-Source: AGHT+IHwG7pdNLiBaAM24HThjkOi7tLfoBL4L6u/i7asjEelEVXiAdsmMsTUPy8p7bw7xwkQu9IheoDEPmPe
X-Received: from pgbfq21.prod.google.com ([2002:a05:6a02:2995:b0:af2:3b16:9767])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d8c:b0:1f1:432:f4a3
 with SMTP id adf61e73a8af0-20aa2fcc884mr4171936637.23.1746033340179; Wed, 30
 Apr 2025 10:15:40 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:15:29 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430171534.132774-1-irogers@google.com>
Subject: [PATCH v2 0/5] Silence some clang -Wshorten-64-to-32 warnings
From: Ian Rogers <irogers@google.com>
To: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Jakub Kicinski <kuba@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"

Clang's shorten-64-to-32 can be useful to spot certain kinds of bugs
that can be more prevalent in C code due to implicit 64 to 32-bit
casting. Add some explicit casts to header files so as to avoid the
warning when these headers are used.

This patch started out as a single patch in a series for the perf tool
where a bug could have been identified were -Wshorten-64-to-32
enabled:
https://lore.kernel.org/lkml/20250401182347.3422199-3-irogers@google.com/

v2: Rebase and try to address Arnd Bergmann's comments wrt the commit
    message. Arnd also mentioned doing larger refactors, changing
    return types and adding helper functions. I've held off doing this
    given concerns over breaking printf flags.

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
2.49.0.906.g1f30a19c02-goog


