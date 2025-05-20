Return-Path: <linux-arch+bounces-12025-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 975C8ABE061
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 18:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69C6C1BC2FD7
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 16:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7937627FB2E;
	Tue, 20 May 2025 16:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L2n9gtF5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB04927FB08
	for <linux-arch@vger.kernel.org>; Tue, 20 May 2025 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747757549; cv=none; b=vA5tjTxbdVapIxE+C33LNcuHujDrtSxjrDvepS6cTx66u45YHSOupfkSM1uaNCnbUTlO8AKHxDnYQbMVcBHf+PD3+bfW40JyBNiWOeqgdLM9BtzALD0XVazovQe/PkvMmLLVGPID2CShkmkhrfBgWcFm0VSKclt22+oCTei1ujg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747757549; c=relaxed/simple;
	bh=dCA79GdEf2BJmDDrmeRq5F+pP47GMPjElfXfXEKb4SM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OUmVQAeZizuTd9NANZAXGIBF2Xl7QHpmb0TEzYCPwI1dfvf6R3QYX7PBOHEwKJ7lX1SPx24ZMkFpr+LRU0Yk249w+sZd0UcVrMIy83vCQ3ayrj7JJTcPY6tUJpVMKkn65ijsEj5wUH+lEAg0GOh9cG1oVXX5Gnu1YLu0MmL46mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L2n9gtF5; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso23248a12.1
        for <linux-arch@vger.kernel.org>; Tue, 20 May 2025 09:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747757546; x=1748362346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCA79GdEf2BJmDDrmeRq5F+pP47GMPjElfXfXEKb4SM=;
        b=L2n9gtF5X+IajN4zBd//uPdZxYtan77Bm+jgY2mVuPVY1c3hwH1gX1/le1HcGCdqv5
         OEI3Pn9aOhZEfKrXuVuAxr42RrWNtMUM2d4rcI+1WyNgFhhSJDeQ5kBE0Ba2JP+6JXKb
         u/NOUEtNIj844iuFuseXF1VllmvOECR3vq/Ptai3sceAoA0jBFh5+ks4PIQ065EMocRw
         lfliL9j4Tl/UIOE/OvewB1WO+2nmyozTrtKu3HvnHdCOsUDcdBzrZkscZwjSZrPNhAlc
         rAYsTyioY0t5qYo9JqCYdRYUlDMqiGpNm2dO2FexqKM80k22Qa1FI5q5P5/eAeuNxkEJ
         uRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747757546; x=1748362346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCA79GdEf2BJmDDrmeRq5F+pP47GMPjElfXfXEKb4SM=;
        b=vVrwF9EuJFpRAIdAtj9kD6+5q8Xvl6kRpxP659hU8jNBTMdCN62OIXS4l2JinSEniI
         olDNIXytySYaqcPcIHWsV/KcaH1e+xL5WZ5/SqfoSgXtiXzUVMsyn6xLDXm2y75zI36p
         pAYgu9+eaow7MtCnav9aUErH5lAJ9ivySIqGiNPooacj/7pc0sOdScLH03dtbCGKXWf4
         TP2q4qc6pDGHkKHF8SrLfnXu4lfln+gfu8n6o35tObECcmN2LWbDdiUmxM7rxA68UOZy
         PCxWnSEcQ6VOOREqwjZPLlaBqFaKc5QgnzNG70yu6DB88O1RbQjI87gire/Se0X63fZB
         oCxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmYbD41/xsxnxxbMdFSSfEtb2BuG6IwvbbFy7CC+A60qLX0T1C7UXw3fsfMKa3cM0+UvF05QS8+k9c@vger.kernel.org
X-Gm-Message-State: AOJu0YxL0LXTK0gi+Ytblibk4P49djQ4ggACb7nNAb3BClt2Eay8SAIz
	3TfqPvhDAs0V+0xLJWm2OszP5nyh08VYJQumIuUu6JBFu2VNHE0Krdh99ooovsM6cMccV3/Rwo+
	Mew5Jpv9JzEBFAXBE4J93xcbWcPIAAxjl1s22cR3e
X-Gm-Gg: ASbGncvF2IdcBd6mZnp7CoRvhP39OCF1UF2pFpD+qPIUdHo/LqJgi8uyUYjQLIzIz39
	C6X11eR7YqkVGiTYmuLS7kw70Ox1OWH6On7fnb7nlVOkGoOxIXNyYeSQnGc95+wZDSwNLyKAGTp
	ccG5rRddCI56bjI3FEMFmmvnc0TXG9oS0roLjRrkrDVcehgHeWf5blZZhnFPK7OzhNxHzRhQ==
X-Google-Smtp-Source: AGHT+IGc42rApFWcTa/Db9urC+6de9XjVpoRSlYKv1EzaBRtUg91wVs9QiTfOv/mUWDqbtnUY0o4c3XpLCRdQZVMfdI=
X-Received: by 2002:a05:6402:368:b0:5fc:e6a6:6a34 with SMTP id
 4fb4d7f45d1cf-6019c7917b7mr298024a12.6.1747757545583; Tue, 20 May 2025
 09:12:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <617413860ff194dfb1afedb175b2d84a457e449d.1747686021.git.lorenzo.stoakes@oracle.com>
 <czd62f2vzwv6fow4ikvzlkjdj5odhc3nhtc72onwip52baobg5@yc5pjiqoqnh4>
In-Reply-To: <czd62f2vzwv6fow4ikvzlkjdj5odhc3nhtc72onwip52baobg5@yc5pjiqoqnh4>
From: Jann Horn <jannh@google.com>
Date: Tue, 20 May 2025 18:11:49 +0200
X-Gm-Features: AX0GCFsQa4Bq0ym39Zq1y67kysJIT5gWTvNiOCDRl00jzzxRfRwLOK8_Q-b-SDI
Message-ID: <CAG48ez2+UEifqF=GRat0dStPfDNXzzewHU=zxj0+FbOXL=mKVQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] mm/madvise: add PMADV_SET_FORK_EXEC_DEFAULT
 process_madvise() flag
To: Pedro Falcato <pfalcato@suse.de>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, 
	linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 10:38=E2=80=AFAM Pedro Falcato <pfalcato@suse.de> w=
rote:
> - PMADV_INHERIT_FORK. This makes it so the flag is propagated to child pr=
ocesses (does not imply PMADV_FUTURE)

Do we think there will be flags settable through this API that we
explicitly _don't_ want to inherit on fork()? My understanding is that
sort of the default for fork() is to inherit everything, and things
that don't get inherited are weird special cases (like mlock() state).
(While the default for execve() is to inherit nothing about the MM.)

(I guess you could make a case that in a fork+exec sequence, the child
might not want to create hugepage between fork and exec... but this is
probably not the right place to control that?)

