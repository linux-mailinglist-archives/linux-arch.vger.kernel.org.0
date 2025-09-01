Return-Path: <linux-arch+bounces-13348-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D98B3E202
	for <lists+linux-arch@lfdr.de>; Mon,  1 Sep 2025 13:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D06D8440D62
	for <lists+linux-arch@lfdr.de>; Mon,  1 Sep 2025 11:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66CB320CC9;
	Mon,  1 Sep 2025 11:47:44 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAD2320388;
	Mon,  1 Sep 2025 11:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756727264; cv=none; b=RylJZyp1RTVr2i0T/uA8LadAO17jk63q7K7Y3ykvdPqQJOHxZiIwZ0tZPa2XD7QAiT7AB+flSaSS0L8E6s9J8aOJvyFbRgR0ytqS5n2Rlo8aWEjC5dVaImGHx8Be/Wnh62Mfv4mEquoGHGYIHoWlrACnnZjj+vDaz6LuAD31wUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756727264; c=relaxed/simple;
	bh=zY3utwnKAL6932h1h4Y9EISWhegh8t1HALWIz/sE5Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZV35WkuW+JAPRBKcebUc9uKo4jqdOgvLvJj9Mj3dkPZmM2MU5T15b9pbdWmhwOwjS1d6LlJEvfiBaKNnjg4OWWQRASFRr3ugU0XAIU2eg+amCoAMksLSgqq/eW8g9grKGtU6uoJhy18xP8Q3NAoeNkuw0z1+bc331gOgfrgpS2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6A2C4CEF9;
	Mon,  1 Sep 2025 11:47:40 +0000 (UTC)
Date: Mon, 1 Sep 2025 12:47:38 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
	arnd@arndb.de, will@kernel.org, peterz@infradead.org,
	akpm@linux-foundation.org, mark.rutland@arm.com,
	harisokn@amazon.com, cl@gentwo.org, ast@kernel.org,
	memxor@gmail.com, zhenglifeng1@huawei.com,
	xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v4 3/5] arm64: rqspinlock: Remove private copy of
 smp_cond_load_acquire_timewait
Message-ID: <aLWH2g_AvROarMFV@arm.com>
References: <20250829080735.3598416-1-ankur.a.arora@oracle.com>
 <20250829080735.3598416-4-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829080735.3598416-4-ankur.a.arora@oracle.com>

On Fri, Aug 29, 2025 at 01:07:33AM -0700, Ankur Arora wrote:
> In preparation for defining smp_cond_load_acquire_timewait(), remove
> the private copy. Lacking this, the rqspinlock code falls back to using
> smp_cond_load_acquire().
> 
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

