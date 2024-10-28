Return-Path: <linux-arch+bounces-8671-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9B59B3DC4
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 23:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11012282029
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 22:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55763192B81;
	Mon, 28 Oct 2024 22:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="Tm6rP5jl"
X-Original-To: linux-arch@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607CC18FDC2;
	Mon, 28 Oct 2024 22:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730154848; cv=none; b=RxBMRxeydbjhVGGp6VBjBufI4MUkQ3HTmp/Fia2xem35SvbSdD1n0Be5YCG3zYtk+tLivfyz6Zx1UVTNhe+LGa4LYqt1yIEuWBKQ3Nyh5Vz3PqHYbLBwDlV0/9/+55PbsztRsLWkDPjLtwYx/jM9bKdh01trCVEmnyIiZkBefsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730154848; c=relaxed/simple;
	bh=/a7TPo3x6JPQlGrjMtShHu1VXX1m3umif9vry9xooZ4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lOyIu94aBsqBcdj7eHhGHmOtM32fFvOkEz4s4KEnOj162PTUtYEGooIn4tg6UVEnrAiETh34f1wmv8zEXw+8VUkf++JEH3uK7q5q68yIPx1QuPMkljifdqi2DK5XC4O8J22tgSuzSgIj16uiqIdBLSXEvlHKVPC2xaFyPWK16nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=Tm6rP5jl; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1730154845;
	bh=/a7TPo3x6JPQlGrjMtShHu1VXX1m3umif9vry9xooZ4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Tm6rP5jldCQOeell3AmKqZKnOJIWi/qOOYt5wEp7iz3Mf/s+a8rkByuQN2aBeLL4/
	 wyoICDSOFSU6BM4nd9URwyPeQ4BFH7+dzVNmTat8i04s2oxpFGrUELGeji+5PPQPsx
	 XT72YgcL825ZX1MmuErPXWQwdw2dpMcyOQ1ofdu8=
Received: by gentwo.org (Postfix, from userid 1003)
	id C573540262; Mon, 28 Oct 2024 15:34:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id C406C401C8;
	Mon, 28 Oct 2024 15:34:05 -0700 (PDT)
Date: Mon, 28 Oct 2024 15:34:05 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Davidlohr Bueso <dave@stgolabs.net>
cc: Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de, 
    linux-kernel@vger.kernel.org, mingo@redhat.com, dvhart@infradead.org, 
    andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>, 
    urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com, 
    Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org, 
    linux-mm@kvack.org, linux-arch@vger.kernel.org, malteskarupke@web.de, 
    llong@redhat.com
Subject: Re: [PATCH 2/6] futex: Implement FUTEX2_NUMA
In-Reply-To: <whmqaksbwuksdobz2fomqi3pa7btf2ucjtr3i4bz3oglidz3n2@27zggp5udztd>
Message-ID: <fb7924fa-79e8-ff7a-084e-b0695feb1ff4@gentwo.org>
References: <20241025090347.244183920@infradead.org> <20241025093944.485691531@infradead.org> <dce4d83c-fb3f-3581-71e4-33dad3f91e07@gentwo.org> <whmqaksbwuksdobz2fomqi3pa7btf2ucjtr3i4bz3oglidz3n2@27zggp5udztd>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 27 Oct 2024, Davidlohr Bueso wrote:

> On Fri, 25 Oct 2024, Christoph Lameter (Ampere) wrote:\n
>
> > Would it be possible to follow the NUMA memory policy set up for a task
> > when making these decisions? We may not need a separate FUTEX2_NUMA
> > option. There are supportive functions in mm/mempolicy.c that will yield
> > a node for the futex logic to use.
>
> With numa-awareness, when would lookups ever want to be anywhere but
> local? mempolicy is about allocations, futexes are not that.

futexes use kernel metadata right? Those allocations are controlled by
the tasks memory policy.


