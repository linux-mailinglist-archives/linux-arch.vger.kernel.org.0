Return-Path: <linux-arch+bounces-9513-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3009FCD45
	for <lists+linux-arch@lfdr.de>; Thu, 26 Dec 2024 20:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68DF11882F5B
	for <lists+linux-arch@lfdr.de>; Thu, 26 Dec 2024 19:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED60136353;
	Thu, 26 Dec 2024 19:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MxOHzMre"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFA7335C7
	for <linux-arch@vger.kernel.org>; Thu, 26 Dec 2024 19:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735240196; cv=none; b=aAMmP3czSsY5MvhxSh/Oa+GNPeth3WcO2McDHvUJMYEKMCi5kFQ3ro0KehBJOdi+FOahxH6wg6SVGzn1hGGUcocF/DX2lxHfxuIacmtpC2yeFZba5pBOn98TmyqMu6sZS01mQd8i+p4IlTcXruK5y1jIKeMK/cQiVhKb2sI8V54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735240196; c=relaxed/simple;
	bh=pSWpbJXD8hWdcvU7ZuqPnkDEj4NBtkAidcz3T23gn6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtVD0y1csG47BbPAFentEYchI7PvlrM0W9sNYZYUk+zkPdUCJXpcQeroFaiDG4mlty+MMQScH/P8Kig7rdNH7QG4twc9grGQ+BTk0KZ04BpP4yNwCHdlGYCHCDuWWzmu/xL4V77mPvqu0PdwNe2NVEp4n7fSM4WRklxmd8u/aXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MxOHzMre; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaee0b309adso490830866b.3
        for <linux-arch@vger.kernel.org>; Thu, 26 Dec 2024 11:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1735240193; x=1735844993; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/NMUImSjcGHKg+Gvj2KvEBIgCuv7UhXeK5cD/H4h4A=;
        b=MxOHzMresXypveDY7OK4X45ygU/v2uc4o7omjA3U0tGJwyNkcdoOhNl3OD8WZmw/RJ
         SQdppL+SBgcPFeJjrwLgXgxTjIwdl8bndEQvoIEvc5RBqYWtV4c4AyDW0G19fFjac6Nd
         BFHdz5xcDWmWKI+HLncTVVdxvGNcWUPTFXJhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735240193; x=1735844993;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q/NMUImSjcGHKg+Gvj2KvEBIgCuv7UhXeK5cD/H4h4A=;
        b=qFCLj5VhsQT9tBHecqeazFKY8SdXs9lbxj9Quc8JKrnKqpQtpIOvG2qHftraW1sWLO
         7XCvLlmuSS+y5zN1TQ96ZOM7gmnqXpuAQTxMZoSPegcZhwYGI+Jf5hJZ3N3XpsTu2ACf
         H4oFzwNIlS2cyw49J/ElcBOWIKln7zPjOZd2pGMtXF9VfIgy/wuYWXFjG0xAV4T1vK1t
         4Odb06q2D+ze0RAww0j06SOEw5PK8Y5+1zx/uVSUI/NIwjNQ1mLl0phZPUPR9l+s3xjM
         kLP07w/KzERRk9v5AsXYhvx55K9vhsDklp8Z3rsSvTN3QiFHaiuNqDeS9iQIfIx7IRUr
         mU3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWWc5rq2haKgxxgxuBgT634xWf3eqqLDDpzSkc37Zri3r6ClYbCJ4mr/rX2djlwW9wSdrrXq81Agozf@vger.kernel.org
X-Gm-Message-State: AOJu0YwSs7CXv13Vdtp0mDIdlrBGYMNRk2Uo1cLCzv7yRkiMdlKtt0rw
	90p8pHLEIAKvm+48R4cSx9HIn2YcFw5R0PmxfY0iOlYEgbRs1uJc5zMbq96nL9jWSJ53DhMxKID
	weDOyMA==
X-Gm-Gg: ASbGncveP4uR3uDfDSJBLlTFD+B2txRRSIYwplGpK/v3Ti+pK65Jpyf58TsJ9nKlfXp
	EW6mWDF3dOaLBrQj4h9DA9lRD+N0BO4790QXF5BjTGNoiycU3kl1xG6pv82lpbOhXBsiXWdF+BX
	w3DhARm2e9Qu0vTpf8OYnBu5dHpXvUfcOMAnvKxIel8L+RmcWMIwxlAMtV8mWz+qTQw6S5WlSOR
	qcG+fmrBU1ox2rUhXphPJDpgApP2YlA38Xk1Ke7A9YCCQxZRGhlLUeF+4rUTAZLsjDkgi79tCo/
	uzBaQ3DZxiXH80vHSq0R5Nm9n2fn9CU=
X-Google-Smtp-Source: AGHT+IEvISO96jzqDrifD8/fDYMzpjDeWUqw51Q7QrPNozv+2vXZgQFt5cwcx42ClQpdK9WUgOQU3Q==
X-Received: by 2002:a17:907:944d:b0:aa6:84d4:8021 with SMTP id a640c23a62f3a-aac34a07e84mr2161248066b.61.1735240192673;
        Thu, 26 Dec 2024 11:09:52 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0efe4c55sm994055466b.130.2024.12.26.11.09.52
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2024 11:09:52 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3ecae02beso7969667a12.0
        for <linux-arch@vger.kernel.org>; Thu, 26 Dec 2024 11:09:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWiOdZyB9+Bzpf9AlhmLZeNzPk4X0OiU4Po7woqmYPzakXreu3o1dgJzgVh0JXjtrXtbai827P7NG1P@vger.kernel.org
X-Received: by 2002:a17:907:6e90:b0:aa6:5d30:d974 with SMTP id
 a640c23a62f3a-aac2d3286bfmr2588071266b.28.1735239782146; Thu, 26 Dec 2024
 11:03:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <75B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com>
In-Reply-To: <75B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 26 Dec 2024 11:02:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj5A-fO+GnfwqGpXhFbfpS4+_8xU+dnXkSx+0AfwBYrxA@mail.gmail.com>
Message-ID: <CAHk-=wj5A-fO+GnfwqGpXhFbfpS4+_8xU+dnXkSx+0AfwBYrxA@mail.gmail.com>
Subject: Re: [RESEND PATCH] fs/pipe: Introduce a check to skip sleeping
 processes during pipe read/write
To: WangYuli <wangyuli@uniontech.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yushengjin@uniontech.com, zhangdandan@uniontech.com, guanwentao@uniontech.com, 
	zhanjun@uniontech.com, oliver.sang@intel.com, ebiederm@xmission.com, 
	colin.king@canonical.com, josh@joshtriplett.org, penberg@cs.helsinki.fi, 
	manfred@colorfullife.com, mingo@elte.hu, jes@sgi.com, hch@lst.de, 
	aia21@cantab.net, arjan@infradead.org, jgarzik@pobox.com, 
	neukum@fachschaft.cup.uni-muenchen.de, oliver@neukum.name, 
	dada1@cosmosbay.com, axboe@kernel.dk, axboe@suse.de, nickpiggin@yahoo.com.au, 
	dhowells@redhat.com, nathans@sgi.com, rolandd@cisco.com, tytso@mit.edu, 
	bunk@stusta.de, pbadari@us.ibm.com, ak@linux.intel.com, ak@suse.de, 
	davem@davemloft.net, jsipek@cs.sunysb.edu, jens.axboe@oracle.com, 
	ramsdell@mitre.org, hch@infradead.org, akpm@linux-foundation.org, 
	randy.dunlap@oracle.com, efault@gmx.de, rdunlap@infradead.org, 
	haveblue@us.ibm.com, drepper@redhat.com, dm.n9107@gmail.com, jblunck@suse.de, 
	davidel@xmailserver.org, mtk.manpages@googlemail.com, 
	linux-arch@vger.kernel.org, vda.linux@googlemail.com, jmorris@namei.org, 
	serue@us.ibm.com, hca@linux.ibm.com, rth@twiddle.net, lethal@linux-sh.org, 
	tony.luck@intel.com, heiko.carstens@de.ibm.com, oleg@redhat.com, 
	andi@firstfloor.org, corbet@lwn.net, crquan@gmail.com, mszeredi@suse.cz, 
	miklos@szeredi.hu, peterz@infradead.org, a.p.zijlstra@chello.nl, 
	earl_chew@agilent.com, npiggin@gmail.com, npiggin@suse.de, julia@diku.dk, 
	jaxboe@fusionio.com, nikai@nikai.net, dchinner@redhat.com, davej@redhat.com, 
	npiggin@kernel.dk, eric.dumazet@gmail.com, tim.c.chen@linux.intel.com, 
	xemul@parallels.com, tj@kernel.org, serge.hallyn@canonical.com, 
	gorcunov@openvz.org, levinsasha928@gmail.com, penberg@kernel.org, 
	amwang@redhat.com, bcrl@kvack.org, muthu.lkml@gmail.com, muthur@gmail.com, 
	mjt@tls.msk.ru, alan@lxorguk.ukuu.org.uk, raven@themaw.net, thomas@m3y3r.de, 
	will.deacon@arm.com, will@kernel.org, josef@redhat.com, 
	anatol.pomozov@gmail.com, koverstreet@google.com, zab@redhat.com, 
	balbi@ti.com, gregkh@linuxfoundation.org, mfasheh@suse.com, 
	jlbec@evilplan.org, rusty@rustcorp.com.au, asamymuthupa@micron.com, 
	smani@micron.com, sbradshaw@micron.com, jmoyer@redhat.com, sim@hostway.ca, 
	ia@cloudflare.com, dmonakhov@openvz.org, ebiggers3@gmail.com, 
	socketpair@gmail.com, penguin-kernel@i-love.sakura.ne.jp, w@1wt.eu, 
	kirill.shutemov@linux.intel.com, mhocko@suse.com, vdavydov.dev@gmail.com, 
	vdavydov@virtuozzo.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	minchan@kernel.org, deepa.kernel@gmail.com, arnd@arndb.de, balbi@kernel.org, 
	swhiteho@redhat.com, konishi.ryusuke@lab.ntt.co.jp, dsterba@suse.com, 
	vegard.nossum@oracle.com, axboe@fb.com, pombredanne@nexb.com, 
	tglx@linutronix.de, joe.lawrence@redhat.com, mpatocka@redhat.com, 
	mcgrof@kernel.org, keescook@chromium.org, linux@dominikbrodowski.net, 
	jannh@google.com, shakeelb@google.com, guro@fb.com, willy@infradead.org, 
	khlebnikov@yandex-team.ru, kirr@nexedi.com, stern@rowland.harvard.edu, 
	elver@google.com, parri.andrea@gmail.com, paulmck@kernel.org, 
	rasibley@redhat.com, jstancek@redhat.com, avagin@gmail.com, cai@redhat.com, 
	josef@toxicpanda.com, hare@suse.de, colyli@suse.de, johannes@sipsolutions.net, 
	sspatil@android.com, alex_y_xu@yahoo.ca, mgorman@techsingularity.net, 
	gor@linux.ibm.com, jhubbard@nvidia.com, andriy.shevchenko@linux.intel.com, 
	crope@iki.fi, yzaikin@google.com, bfields@fieldses.org, jlayton@kernel.org, 
	kernel@tuxforce.de, steve@sk2.org, nixiaoming@huawei.com, 
	0x7f454c46@gmail.com, kuniyu@amazon.co.jp, alexander.h.duyck@intel.com, 
	kuni1840@gmail.com, soheil@google.com, sridhar.samudrala@intel.com, 
	Vincenzo.Frascino@arm.com, chuck.lever@oracle.com, Kevin.Brodsky@arm.com, 
	Szabolcs.Nagy@arm.com, David.Laight@aculab.com, Mark.Rutland@arm.com, 
	linux-morello@op-lists.linaro.org, Luca.Vizzarro@arm.com, 
	max.kellermann@ionos.com, adobriyan@gmail.com, lukas@schauer.dev, 
	j.granados@samsung.com, djwong@kernel.org, kent.overstreet@linux.dev, 
	linux@weissschuh.net, kstewart@efficios.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Dec 2024 at 01:44, WangYuli <wangyuli@uniontech.com> wrote:
>
>
> +config PIPE_SKIP_SLEEPER
> +       bool "Skip sleeping processes during pipe read/write"

If the optimization is correct, there is no point to having a config option.

If the optimization is incorrect, there is no point to having the code.

Either way, there's no way we'd ever have a config option for this.

> +pipe_check_wq_has_sleeper(struct wait_queue_head *wq_head)
> +{
> +               return wq_has_sleeper(wq_head);

So generally, the reason this is buggy is that it's racy due to either
CPU memory ordering issues or simply because the sleeper is going to
sleep but hasn't *quite* added itself to the wait queue.

Which is why the wakeup path takes the wq head lock.

Which is the only thing you are actually optimizing away.

> +       if (was_full && pipe_check_wq_has_sleeper(&pipe->wr_wait))
>                 wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);

End result: you need to explain why the race cannot exist.

And I think your patch is simply buggy because the race can in fact
exist, because there is no other lock than the waitqueue lock that
enforces memory ordering and protects against the "somebody is just
about to sleep" race.

That said, *if* all the wait queue work was done under the pipe mutex,
we could use the pipe mutex for exclusion instead.

That's actually how it kind of used to work long long ago (not really
- but close: it depended on the BKL originally, and adding waiters to
the wait-queues early before all the tests for full/empty, and
avoiding the races that way)

But now waiters use "wait_event_interruptible_exclusive()" explicitly
outside the pipe mutex, so the waiters and wakers aren't actually
serialized.

And no, you are unlikely to see the races in practice (particularly
the memory ordering ones). So you have to *think* about them, not test
them.

         Linus

