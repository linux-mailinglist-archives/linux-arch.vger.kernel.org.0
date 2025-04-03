Return-Path: <linux-arch+bounces-11246-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7471A7A847
	for <lists+linux-arch@lfdr.de>; Thu,  3 Apr 2025 18:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71A59173158
	for <lists+linux-arch@lfdr.de>; Thu,  3 Apr 2025 16:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB4C252907;
	Thu,  3 Apr 2025 16:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B1o3lMzw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE392528F2
	for <linux-arch@vger.kernel.org>; Thu,  3 Apr 2025 16:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743699435; cv=none; b=pyG8sNOBLDhnmnubFwIkrJluikWmAOP8Aw5Or3Set/uhr9HVUh5GJUr30SLee0Ot0yO4vLpVfgzGIKbtr6gvsyogLxFE9hQXaVFYP0OjWV38gn7RQ6DljG7Ty5dNGCknpJYQefL+haNmp12ADCzCOfwI+gK3obONdcpkR62aUtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743699435; c=relaxed/simple;
	bh=Qz0QomEC//r00eQAz30vgB3K0BsSHU+UqMrkppYie2E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=bT+8F6gEo6qXGtIo0N1zAw5MZKS9vTfmgxDibuIrdbaLRIko3JCCvtt0MLwWnsnqV+iSE+WRBcBjn8R9vPsTVmXs1s9UmTqJ3gUt3UUKsH0/R0V9Tb8/U4rJj1UQrjUH2FaZltjCm01t+kt9uJ1jdZsNktHXMeUjP6C8IEF4Hs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B1o3lMzw; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3032f4eca83so1133735a91.3
        for <linux-arch@vger.kernel.org>; Thu, 03 Apr 2025 09:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743699433; x=1744304233; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qW8HptWxtTGnb+NyUFSz4Rsqb7n3gW/Agd38GBuyPl4=;
        b=B1o3lMzwD14k3bQAZ1MkTFtPfdRm57m0XkwJqZ56pieytS+1MjjhvMb7ZdPIUxJs2a
         cz82DsWEbendEHhSFmw+048SMdpzyZBBc97CSh07M9o3nEevDV9fC5kuboK8XTTJG2Tb
         e5wS4UniK/VCDtThybyK7zLV/NVEGEmKAVRAJ1FE7MRnmPbw7lZ+iory8vrslXWYRnvH
         BmhO0fSiBeq9s220qz29hVGwzZ+EnU5EhDyTzyGxd+YRrHH2MJvELwMtgcS4R3mjHMLX
         jysuxpCKJA0F5o9Rx4zuh2MOIMtHiQ/+msHugU26XdY9lvbNBWd7Luqcnv+FWr+IWwWZ
         24vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743699433; x=1744304233;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qW8HptWxtTGnb+NyUFSz4Rsqb7n3gW/Agd38GBuyPl4=;
        b=YvDJ2dRx4yoZmAH154lTFms9fDs0HZlYgUIuaKGadaSKKWbnhbzQ3g539W3SDeRqOl
         lqFb84O/UzOufBaTcC4MLniGV8eQpvqpXon9NcueSm0qYKY6iHKoE+lgIhhAEX/RFSlm
         L6/R4cS/IZQllfgpSH7a4BhsxN6MoyB0aPiFeziPKS4khD4jx0WZ7Gi/q7LKGh/iOWNL
         /ytsY2nRhncj+6kU/airj2aqJm7tXkCkZKgUa+W9GCLiPBxilSs+XWpv7OYQyy2Tp3L4
         gDgtC+aCn13KFW/iGU/S31dye5zKTOYFDwVfk747lnkKws5wHFlCjbyt6DiiQWCZ9Rtj
         8W+g==
X-Forwarded-Encrypted: i=1; AJvYcCVGVpzcUXY+P4rDxecTi0sP49jA67Jov97rBknIFuSeaZkzLJ6nI5CS9S6POT+ZjKxZjzSWfjLJE4Tg@vger.kernel.org
X-Gm-Message-State: AOJu0Yxufjh8tkHbEmvSDz3PEh1UmZAkp7VwFynWZ/eCGywMjJ2xp6rz
	BpM5ARTPwqw3C4TzHf6JEP+MwEH+m2mRaf/0wXH9i13WYcZNXMCZ6yk3aMlPP5Uqa7jOpensfRA
	Fgkpreg==
X-Google-Smtp-Source: AGHT+IF0CIOoJJeJRQHOUC3EpHHqa58y0n4/IbXEbLHpY4GALdcPXwOZpF/CmwFTc4V9Kvparfq+Lmxq0y9x
X-Received: from pjd11.prod.google.com ([2002:a17:90b:54cb:b0:2ff:5752:a78f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b0d:b0:2ff:52e1:c4b4
 with SMTP id 98e67ed59e1d1-306a4b8597emr236433a91.32.1743699433573; Thu, 03
 Apr 2025 09:57:13 -0700 (PDT)
Date: Thu,  3 Apr 2025 09:57:00 -0700
In-Reply-To: <20250403165702.396388-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250403165702.396388-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250403165702.396388-4-irogers@google.com>
Subject: [PATCH v1 3/5] bitops: Silence a clang -Wshorten-64-to-32 warning
From: Ian Rogers <irogers@google.com>
To: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Jakub Kicinski <kuba@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

The clang warning -Wshorten-64-to-32 can be useful to catch
inadvertent truncation. In some instances this truncation can lead to
changing the sign of a result, for example, truncation to return an
int to fit a sort routine. Silence the warning by making the implicit
truncation explicit.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/asm-generic/bitops/fls64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/bitops/fls64.h b/include/asm-generic/bitops/fls64.h
index 866f2b2304ff..9ad3ff12f454 100644
--- a/include/asm-generic/bitops/fls64.h
+++ b/include/asm-generic/bitops/fls64.h
@@ -21,7 +21,7 @@ static __always_inline int fls64(__u64 x)
 	__u32 h = x >> 32;
 	if (h)
 		return fls(h) + 32;
-	return fls(x);
+	return fls((__u32)x);
 }
 #elif BITS_PER_LONG == 64
 static __always_inline int fls64(__u64 x)
-- 
2.49.0.504.g3bcea36a83-goog


