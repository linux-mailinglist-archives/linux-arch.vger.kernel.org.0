Return-Path: <linux-arch+bounces-8122-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9AC99DA1F
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 01:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE25D1F22A1F
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 23:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F10C1D5AC7;
	Mon, 14 Oct 2024 23:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZEVoWlIU"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319F922318;
	Mon, 14 Oct 2024 23:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728948755; cv=none; b=uDF2N0wfnWnQB+PbPjjQEU4levrls3qkI1i77s5aJpzj8DEfTXpt+S4k9Pr+ek9CLBVxU2uDwBSxOFYs8EVw5MKNOHwEWnjZgnf0fnUMXYwN4Q+8i5AZOQ9WZNG9WVlt54I3T2Hmv516StfE6W6SFLqsqatM01IbQtiuVCfP2So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728948755; c=relaxed/simple;
	bh=XQtg5cP9HyV6IrbyncC2iesICzlVjTnl+DHBfU7OiPk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JSmuROIjr7EZgMSyC4Qn2O2+JycN4IQEvG/9AfOAz3vGOoWX4NCakcFs9GLNBYSdgbk2SHeJps0Go/OXqP/xM4URoq53ej/0s9d5a+iobGkYGkkLyKI4RyVy2fLVKjF/aAGsA+tqDhOrtvetism8V+m0Wz+0CKlYHUL4zmCHAzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZEVoWlIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8207AC4CEC3;
	Mon, 14 Oct 2024 23:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1728948753;
	bh=XQtg5cP9HyV6IrbyncC2iesICzlVjTnl+DHBfU7OiPk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZEVoWlIUzBiHRwiJR0vPiV3sOzA1+w7KorKdKv6p5yt8GoUOvwIAOf1mWchML/eEX
	 sFx8ngFC5i4W1MzuadMKYyQCSadRyKidWKeIiyV4jKIF3jufwLxSV0/A6APJBuHc1o
	 /Ui2PQkp7mTYbmOEHmB/Uf2iJEILLXV+5+9CuEFo=
Date: Mon, 14 Oct 2024 16:32:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de,
 mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, thuth@redhat.com,
 tglx@linutronix.de, bp@alien8.de, xiongwei.song@windriver.com,
 ardb@kernel.org, david@redhat.com, vbabka@suse.cz, mhocko@suse.com,
 hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net,
 willy@infradead.org, liam.howlett@oracle.com, pasha.tatashin@soleen.com,
 souravpanda@google.com, keescook@chromium.org, dennis@kernel.org,
 jhubbard@nvidia.com, yuzhao@google.com, vvvvvv@google.com,
 rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com,
 minchan@google.com, kaleshsingh@google.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 0/5] page allocation tag compression
Message-Id: <20241014163231.9ef058c82de8a6073b3edfdc@linux-foundation.org>
In-Reply-To: <20241014203646.1952505-1-surenb@google.com>
References: <20241014203646.1952505-1-surenb@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Oct 2024 13:36:41 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> Patch #2 copies module tags into virtually contiguous memory which
> serves two purposes:
> - Lets us deal with the situation when module is unloaded while there
> are still live allocations from that module. Since we are using a copy
> version of the tags we can safely unload the module. Space and gaps in
> this contiguous memory are managed using a maple tree.

Does this make "lib: alloc_tag_module_unload must wait for pending
kfree_rcu calls" unneeded?  If so, that patch was cc:stable
(justifyably), so what to do about that?

