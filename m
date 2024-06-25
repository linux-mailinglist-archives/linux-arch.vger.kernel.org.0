Return-Path: <linux-arch+bounces-5073-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E969161B9
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2024 10:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C4128240C
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2024 08:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1131474D4;
	Tue, 25 Jun 2024 08:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0wXqZb1"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490CD13A252;
	Tue, 25 Jun 2024 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719305815; cv=none; b=oVWLY14qwk7sAhff7YFGqNYCpGP4uCKdqa3pal6YvVbJYxm/1gNm3pipufLNfxXRUd/WhIJsSXuEYSNTB+29VhkcrJBQelrNoe/Y67VXXAnicsUjwYRozc833xTuHzOtg3wtQbqkXvXphGAX2DeYVCLY/rqNezPd66Ho2D3RtiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719305815; c=relaxed/simple;
	bh=y2qrsRso46CBes0z7OB5RrzyhO34/c+yxkccrBiwXDc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ZPeO77EVIr1HpQdnyQMdgPhs7k+68TnYYW2omxpxdJum8um/+us6dfaWkTME7naEfP5V5mkbDonT7rLK3lsRqMLjHTrTSxezJ1sLvw+MEzJ/I57lTLR1cWs8cVJJKJ73qqEy3+m57fWasad/SizwVI6YmNQzTG5+bOBqA2YEZVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0wXqZb1; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f6a837e9a3so32361435ad.1;
        Tue, 25 Jun 2024 01:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719305813; x=1719910613; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlB7dSU+Mw2GQd/jrnmHHXfnYRQZZOWLx8QiX1ye4+8=;
        b=Z0wXqZb1W0olrL4eYh73rEXn78ThRQBCP94HPyJXVY05O6/+p/gWAIVufPZBjkxWwh
         LTFlOuoysBpulfXLIvI+E/ijvjarJpPvfS06Nsjz/gzNrdo/fFWRh9YZkGi0sfvI8CTZ
         ayjdTcakCSkkEy01nKFB1J/sCX7PhF4kpYCIbHWfJ8RVrt+miIW1kU8ukGjF+42zNQH9
         kLrLIjeX5l86zM7TK/DaJWMUkg99StJRztwXvpnKvIFfQLHp2q7d35di3ulXmQ5uo/0Q
         cN2Q3ALSdqy75GGQkQzDHJi4sMdq/4OzGqqkJgK2i/dIhXWl0cB/eSSfj1Sm8Q56G5Zo
         SHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719305813; x=1719910613;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vlB7dSU+Mw2GQd/jrnmHHXfnYRQZZOWLx8QiX1ye4+8=;
        b=Fz+tii/tD1tgIxzYvbwlPmebCDZwKpus2V8Ui8gLtd5nfpz15Em4Ff/8V+Q1DuArs4
         Vxa4nd9jtkURW00fLXB+LCK1r987YOOKqygEpxM77996QfLjWrjWiauWZdXQnFpLhFwv
         BHYsQta8yGVhPLu2B5cksxCARgo2uZATLYgvHT1IPBSeNY0pWI2C5izPyFsMJiP+7KPW
         iiiQK3h9/86aJw+5TNYetk9AlT0ozPQwO2eKvIF2IE9jCSjzJoOHbyC75+RzTipXHvck
         VPqzb9hukRCKogBqzX5WlpJSWvjsMN9k7CS2205tKFPZpcAodJGjN+vV9oeFNWeSWSmT
         ygCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnxjbdzr2tCA3Qi6tFsM3GEtRK7vRPrQeT5cqGsxJeSQh6YAs7He0Mh+KIvKStQ+mCTSSGZzNoXPKwxF4TGJIvBteT9mg+4TzojCFyvC92HdxerdnPQiDa8ABFfg9fMrPMJGUkRprGvw==
X-Gm-Message-State: AOJu0YyTFg7vXAIe85XKXxC2uVmG3KycUjXFTJjr8wF6dcXpGQsh7bea
	ZS3OZUyKUi8L9Kg1tCz8WUALNU2+4nm8krJXhORHalcZIGMrfb/r
X-Google-Smtp-Source: AGHT+IHT3Lgr8tkPxMOEQ+9hWwpayu+BAXdhIJa+kUpv0N2DEa49YrOWg+P6iT/wz3J9RfiWQS9ASw==
X-Received: by 2002:a17:903:41cd:b0:1f9:b16d:f988 with SMTP id d9443c01a7336-1fa23f227efmr68520145ad.22.1719305813502;
        Tue, 25 Jun 2024 01:56:53 -0700 (PDT)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3d51d2sm76051065ad.198.2024.06.25.01.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 01:56:53 -0700 (PDT)
Message-ID: <a07d41c9-5236-44ad-8e89-f3be5da90e98@gmail.com>
Date: Tue, 25 Jun 2024 17:56:49 +0900
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Paul E. McKenney" <paulmck@kernel.org>, Marco Elver <elver@google.com>,
 Andrea Parri <parri.andrea@gmail.com>
Cc: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>,
 Luc Maranget <luc.maranget@inria.fr>, Daniel Lustig <dlustig@nvidia.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
From: Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH lkmm v2 0/2] tools/memory-model: Add locking.txt and
 glossary.txt to README
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all,

Here is a v2 series with the trailing white space fixed and Acked-by's
from Andrea applied.

Please find v1 at [1] if you need to.

[1]: https://lore.kernel.org/ae2b0f62-a593-4e7c-ab51-06d4e8a21005@gmail.com/

        Thanks, Akira
--
Akira Yokosawa (2):
  tools/memory-model: Add locking.txt and glossary.txt to README
  tools/memory-model: simple.txt: Fix stale reference to
    recipes-pairs.txt

 tools/memory-model/Documentation/README     | 17 +++++++++++++++++
 tools/memory-model/Documentation/simple.txt |  2 +-
 2 files changed, 18 insertions(+), 1 deletion(-)


base-commit: 5bdd17ab5a7259d2da562eab63abab3a6d95adcd
-- 
2.34.1


