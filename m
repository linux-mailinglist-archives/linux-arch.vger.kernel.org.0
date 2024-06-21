Return-Path: <linux-arch+bounces-4993-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DED2591193A
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jun 2024 06:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8915E1F223D3
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jun 2024 04:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F324612B176;
	Fri, 21 Jun 2024 04:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHs09JN8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CA3AD4E;
	Fri, 21 Jun 2024 04:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718942912; cv=none; b=suJKh9vAA+Ro4TaV65VtkZ5Y/hHdHR7SWdcw91JHsgc1YA4HlUDxVsvCx5tgvkuyRPrqElLDNytXLGX8cFukXXc8fqJnsGzmb0mioYP4wFSfkJXEp1CQ76xHdycv9DW5hDuPKuxZefCO0gXj95SiFKVHCe8Do1EI0tV8LOsIuzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718942912; c=relaxed/simple;
	bh=39LsjG0DpJPRXGYhLaqgtuvsnN9hyT74a9AnSQco3uQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=nnhP0fKfAbep2nzOdpsvgAXasYU3Nhz9c61s1Taf089ul6cHrai7Zy565rWvt3rH65sZnG1YRdc80PmTdrkU0skcnfEg2q6tvXQt4Hr6JdwXgBQF38BRCq81AcuizNZY4qzfAZzZ5Wwrz6akklyiAAWHvowq8clinUcSs7VFAn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHs09JN8; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-24c9f892aeaso862095fac.2;
        Thu, 20 Jun 2024 21:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718942909; x=1719547709; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cc5GushuZJgdTDzjiZ5n8iT2qYkKchcdwujamhM5wSQ=;
        b=SHs09JN87juaswR9eI9gEJ4N5IezGxw7oNoDSfY3lrLwkBL+m7ROODFHU6/jy5poPY
         Hw0CTLiBoVUSI1zcOa4uggaMebkgEA8VKG78nG5ASPpviv2DG3FyCoLMcHX0K9NFpoFx
         v53oZjQ59GYac6RrBeLjX25iQigeEma/BocYS6SiHInhgyx2Lqh/rGUPP9tXR63xHqCK
         SXh4qWAfMohsXUU6OWJayaI5uiR1HbLpsSEtFKTEp1DRQlfqzmlXT3pKtMRnOsDPf7is
         ohSoRL6wOQoo8rUYM3zPqhPAbezuYKlwxxh+m4eL7yTea69Z8B3ZdZcnu3IlYObog/El
         C5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718942909; x=1719547709;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cc5GushuZJgdTDzjiZ5n8iT2qYkKchcdwujamhM5wSQ=;
        b=PorzVGgDe5qoVf5cL2JRG+X3H8xklgF5i/Oimh2qgQZdRzd/kn331hhnA31v5XcYi6
         X/gFgwtP6PBUWs/D9Y8CVDCHkXgiOImkWAekswTC/o/BEYCG9kgTec80DIE0vz6+To/E
         9+4S95WnRuV9QvA5dU+GjgESlMKnQbKwymjN1uUOIA4GGT1CPPFckS/lzWOUYTdqPMur
         PjRA4JiopW9HbUTfNy6tUw/G5l1KsaSb7jzloEfsZg+chqqsHa+fA6NjcNoj3vApdmHc
         SeTpb2qumL0T2FXCyHiPkycDmt8MfLhsPDKvPCTzrgWMWGgHPCFAPx+dSmTtZtlahE9g
         mfGg==
X-Forwarded-Encrypted: i=1; AJvYcCUno1m76Eyl8rnkhrHAW0wrRARfceejXk30EM2HmrNgCH/Xm5ClXxs0ZG4+bGWIrg5GNH8u1D8ArN/uThPeKjfDoOjQYC5pgPmlPc2YnlBOoQpD81SA55ptGSlTTuMVsj+p0DM8oB4xaw==
X-Gm-Message-State: AOJu0Yxc7+ZFtEEmeFDsYIM1TXA+Q9qstjK77pq9zhoVcChbYd5S0BHY
	EWUmZ1wb/q1of/9BUcELWp0/Ed0+IPyrPPtVY05QT/nJKkMKi1k0
X-Google-Smtp-Source: AGHT+IEhvShsaphhL4jfuKmBDDHlXXlBKAlmU3dehNd9B9FJGS5KxhxnLvjf5oDXj2ZmEt8gPDcEvQ==
X-Received: by 2002:a05:6870:8a14:b0:24f:f7e4:9f0a with SMTP id 586e51a60fabf-25c94b5a65amr8228191fac.34.1718942909437;
        Thu, 20 Jun 2024 21:08:29 -0700 (PDT)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70651085a75sm430060b3a.28.2024.06.20.21.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 21:08:29 -0700 (PDT)
Message-ID: <ae2b0f62-a593-4e7c-ab51-06d4e8a21005@gmail.com>
Date: Fri, 21 Jun 2024 13:08:24 +0900
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Paul E. McKenney" <paulmck@kernel.org>, Marco Elver <elver@google.com>
Cc: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>,
 Luc Maranget <luc.maranget@inria.fr>, Daniel Lustig <dlustig@nvidia.com>,
 Joel Fernandes <joel@joelfernandes.org>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, Andrea Parri <parri.andrea@gmail.com>,
 Alan Stern <stern@rowland.harvard.edu>, Akira Yokosawa <akiyks@gmail.com>
From: Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH lkmm 0/2] tools/memory-model: Add locking.txt and glossary.txt
 to README
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all,

[+CC: Marco, as Patch 1/2 includes update related to access-marking.txt.]

Looks to me like Andrea's herd-representation.txt has stabilized.
Patch 1/2 fills missing pieces in docs/README.

While skimming through documents, I noticed a typo in simple.txt.
Patch 2/2 fixes it.

        Thanks, Akira
--
Akira Yokosawa (2):
  tools/memory-model: Add locking.txt and glossary.txt to README
  tools/memory-model: simple.txt: Fix dangling reference to
    recipes-pairs.txt

 tools/memory-model/Documentation/README     | 17 +++++++++++++++++
 tools/memory-model/Documentation/simple.txt |  2 +-
 2 files changed, 18 insertions(+), 1 deletion(-)


base-commit: 662b960d12d280476c4b09070ed6c4b808ee91da
-- 
2.34.1


