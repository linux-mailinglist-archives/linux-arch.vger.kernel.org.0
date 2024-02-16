Return-Path: <linux-arch+bounces-2464-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5898583EF
	for <lists+linux-arch@lfdr.de>; Fri, 16 Feb 2024 18:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 688291F28E43
	for <lists+linux-arch@lfdr.de>; Fri, 16 Feb 2024 17:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA6F130E5C;
	Fri, 16 Feb 2024 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="bQxTPOn9"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C19130E2F
	for <linux-arch@vger.kernel.org>; Fri, 16 Feb 2024 17:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103928; cv=none; b=aLg789okiJOjgKWyH8xzj0imcrHQYOpVFMBAqgWWqewVcplqPlkx9bPilC79hgY/+LbG3LtEM8TKvtDT+TYtTgzkgYYRhXAYjwkLZYgeSMlUxdMyKM7uDLhIWAFLUyjV1JP1ClM0YN+nrLIiG2+J3SqBlrOAcGQsT/qs3YLHbcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103928; c=relaxed/simple;
	bh=2eKrnC6xOIWZ1NTwD/IJazyXMwCp/t3u/M4Pc8vdQNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsnFcZG82DqJxgncC53hOIdJ2uynsg2bgb5B6e2DeC7n/oaUSBvqhj0m9C/UjfTDZjwgzWGZkFQ0E/rfYN8OPqQ6sSEU80xqD7llMgRTgOdN1mpoX36xRa0DomqOCm5P6Th4Fzq8D1NE980rfpRnnxAJB4NPLi77otFWnrrx7MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=bQxTPOn9; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-42c758f075dso27988571cf.0
        for <linux-arch@vger.kernel.org>; Fri, 16 Feb 2024 09:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708103925; x=1708708725; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ttXNwKWugMJyygslP182txVVK8JBh5UVtMFEymJTCI0=;
        b=bQxTPOn9WTXLnpyhxDEsmtOgQUNtA+cfA8a1UJ/SnidZ4cNowB3IzH91BFmbR8yVVX
         n5w9F5nCodKqFu4cv6Uo1TVdfDutrblXDoFJCBkpZNdgpsd3jAvxKQvocFs73FqfCfnZ
         Ty8VcdWL0UVMUiz/dwFRCwY4UMecgApLg+pC9V7lKjQCnK/TDEMitZ+rOeF6cfrnwUTN
         LvwR1PIp8T9BlpxILOqJFiRfZN2sNWNAIXHBG51pGvUgQ4AI+Dmqk3zSvYQ5y0/2lE1r
         bNuROBCX77VZOrM68PUxyOF9LjQHmtZ0WcLMbANRzuWCLmEccyY6XJidFLSGtG0TnzLC
         MGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708103925; x=1708708725;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ttXNwKWugMJyygslP182txVVK8JBh5UVtMFEymJTCI0=;
        b=D1xQYkta1BX9G03v5jiiwstAqpl2j6DB4EZRYJG/n9weskVKA/KPdQi97ejWmt+M24
         19OVu9SFsWNJBmq7XDzrJFxUdQ0QFLoBfMZxoeQsmz13GZ/1LrpZro/N+wtQRaMBTBUE
         wNbO33XhfeoEFTk2aiOID5V7iZ2f3Q3cGWZLOanr0bMtpMbj/EVWCzIxnt6oJYo4M35+
         a24cv5dAgicxFX65DIcWZu1AX3xlu2ok4Ah875HZKLhwp4JKCXzQg9c3HWpGDGTANaNM
         /sjdpfQJXGJoidG+GE+55RKDS3oHFDrXA5nWBgksgSBXf4+99ox6AesP604eXjP81+JY
         LWsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf/cN1Nnl7l9VmfDClxHDyZyUtW+WUiy1mY3njViGLhwjihECXG0R1iZCSINwbMxeOychA5jjYFYICoHb/xUCdkvH6xCQSE2jKFA==
X-Gm-Message-State: AOJu0YxONsA6qzBx4mpPQG7ZpINwgnBoJCh0yCuxpRS+nTd0d7ZPQqmm
	F62hHsHIMy6qbMS7gbm9WeWI+HNIdn20oguMvKDznlcXSq4WerGoGNyslhva/kTQy40Mm75lHLO
	D0xy/i3rhD3dMZBtB1JEZtsYW7MKifgcZCUBHVw==
X-Google-Smtp-Source: AGHT+IGK94jPimX8q7FvTT5r2WHXeqQfvdyDWPQi6YyK2aTQJC/GbkrY2OBKc6aAMFaGl9yMXVM9CDJXDWJJ3i4OZS8=
X-Received: by 2002:a05:622a:130d:b0:42c:7b12:70bd with SMTP id
 v13-20020a05622a130d00b0042c7b1270bdmr14455790qtk.9.1708103925488; Fri, 16
 Feb 2024 09:18:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-14-surenb@google.com>
 <20240215165438.cd4f849b291c9689a19ba505@linux-foundation.org>
 <wdj72247rptlp4g7dzpvgrt3aupbvinskx3abxnhrxh32bmxvt@pm3d3k6rn7pm>
 <CA+CK2bBod-1FtrWQH89OUhf0QMvTar1btTsE0wfROwiCumA8tg@mail.gmail.com>
 <iqynyf7tiei5xgpxiifzsnj4z6gpazujrisdsrjagt2c6agdfd@th3rlagul4nn> <CAJuCfpHxaCQ_sy0u88EcdkgsV-GX3AbhCaiaRW-DWYFvZK1=Ew@mail.gmail.com>
In-Reply-To: <CAJuCfpHxaCQ_sy0u88EcdkgsV-GX3AbhCaiaRW-DWYFvZK1=Ew@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 16 Feb 2024 12:18:09 -0500
Message-ID: <CA+CK2bCsW34RQtKhrp=1=3opMcfB=NSsLTnpwSejkULvo7CbTw@mail.gmail.com>
Subject: Re: [PATCH v3 13/35] lib: add allocation tagging support for memory
 allocation profiling
To: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org, 
	liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > Personally, I hate trying to count long strings digits by eyeball...
>
> Maybe something like this work for everyone then?:
>
> 160432128 (153MiB)     mm/slub.c:1826 module:slub func:alloc_slab_page

That would be even harder to parse.

This one liner should converts bytes to human readable size:
sort -rn /proc/allocinfo | numfmt --to=iec

Also, a "alloctop" script that would auto-update the current top
allocators would be useful to put in tools/mm/

Pasha

