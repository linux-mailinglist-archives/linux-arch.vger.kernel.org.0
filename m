Return-Path: <linux-arch+bounces-2439-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F5D85738C
	for <lists+linux-arch@lfdr.de>; Fri, 16 Feb 2024 02:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3DF11C22707
	for <lists+linux-arch@lfdr.de>; Fri, 16 Feb 2024 01:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C6FD512;
	Fri, 16 Feb 2024 01:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="nUf6VsQU"
X-Original-To: linux-arch@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0C2D267;
	Fri, 16 Feb 2024 01:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708048206; cv=none; b=XPKr0VczzZOxqcgOXE/dWb23nZCeKmlWcy58kUGL8pHDxOuexgTPPk45axFqEig2MQhp0yWDkFROr2w68hhU9kDCnS74Azh4wb4py97TG4JyO6KLF77NFIZNgRAGe2TLo+p4Hh1Rky/UurZYIZ6/gwdHBK4pZbDHcQHtGTmF4qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708048206; c=relaxed/simple;
	bh=saLfcLUL39+420u2mxj3V5PQjfC34V0/2rSMyznlyOc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j6/aSTkwKwSHMAWyQ+FbG8ICink9R4IgX2i0Wwxi3+wucu1LIUGgYqijaDGPJQZ75py6/dqze8WOB2aYzBOZUU2wipWoDoIYfyWCE3/uNbE5oeb0PuJf1dlpcAwZcF9GULO4+cAZFJsiI/NjB6faw62Jgj6qrMdWMs5Sm9ANbxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=nUf6VsQU; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1708048200;
	bh=ilgT5dMTrGshreLT/xmA8StB9lAVJjM5yFaL9rWoLlY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nUf6VsQUornJVXtxyPvxjC3f4ZR4GXUYzm/uzcLAo4CF/ClAUxiy8kug865ZUbReq
	 9HtzdPrYVc5xEj2oWXSf/7BkXWuFNLwVjCUGQgEr6qLtJ6H7HgPlDejG+HNNIjAwbi
	 6w8cIduvfIdwqAfB3CP4wlilbEwRkoZj0s9s7M0KGc93FVcSrQKRWAEMqJnr/M/+34
	 K1EJhFueA8dhCIeYVomM86vptheCj3l4Jj/gKneCKLES8lTCF2mTkGRRNt/IQdncMO
	 bybEcODsRExRcydq4WNOog++4G+FboWUqACVsgpwhiDflxujhcgmHgKWXGqbcqSz3m
	 AymH3IjTkKV3w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TbZcm04G8z4wcp;
	Fri, 16 Feb 2024 12:49:59 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Peter Bergner <bergner@linux.ibm.com>, Arnd Bergmann <arnd@kernel.org>,
 linux-api@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, Szabolcs Nagy
 <szabolcs.nagy@arm.com>, Nick Piggin <npiggin@au1.ibm.com>
Subject: Re: [PATCH v2] uapi/auxvec: Define AT_HWCAP3 and AT_HWCAP4 aux
 vector, entries
In-Reply-To: <a50cf258-b861-40e5-8ca9-dec7721400ec@linux.ibm.com>
References: <a406b535-dc55-4856-8ae9-5a063644a1af@linux.ibm.com>
 <aa657f01-7cb1-43f4-947e-173fc8a53f1f@app.fastmail.com>
 <a50cf258-b861-40e5-8ca9-dec7721400ec@linux.ibm.com>
Date: Fri, 16 Feb 2024 12:49:59 +1100
Message-ID: <87edddp48o.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Peter Bergner <bergner@linux.ibm.com> writes:
> On 2/15/24 2:16 AM, Arnd Bergmann wrote:
>> On Wed, Feb 14, 2024, at 23:34, Peter Bergner wrote:
>>> The powerpc toolchain keeps a copy of the HWCAP bit masks in our TCB for fast
>>> access by the __builtin_cpu_supports built-in function.  The TCB space for
>>> the HWCAP entries - which are created in pairs - is an ABI extension, so
>>> waiting to create the space for HWCAP3 and HWCAP4 until we need them is
>>> problematical.  Define AT_HWCAP3 and AT_HWCAP4 in the generic uapi header
>>> so they can be used in glibc to reserve space in the powerpc TCB for their
>>> future use.
>>>
>>> I scanned through the Linux and GLIBC source codes looking for unused AT_*
>>> values and 29 and 30 did not seem to be used, so they are what I went
>>> with.  This has received Acked-by's from both GLIBC and Linux kernel
>>> developers and no reservations or Nacks from anyone.
>>>
>>> Arnd, we seem to have consensus on the patch below.  Is this something
>>> you could take and apply to your tree? 
>>>
>> 
>> I don't mind taking it, but it may be better to use the
>> powerpc tree if that is where it's actually being used.
>
> So this is not a powerpc only patch, but we may be the first arch
> to use it.  Szabolcs mentioned that aarch64 was pretty quickly filling
> up their AT_HWCAP2 and that they will eventually require using AT_HWCAP3
> as well.  If you still think this should go through the powerpc tree,
> I can check on that.

I'm happy to take it with Arnd's ack.

I trimmed up the commit message a bit, see below.

cheers


Author:     Peter Bergner <bergner@linux.ibm.com>
AuthorDate: Wed Feb 14 16:34:06 2024 -0600
Commit:     Michael Ellerman <mpe@ellerman.id.au>
CommitDate: Fri Feb 16 12:42:59 2024 +1100

    uapi/auxvec: Define AT_HWCAP3 and AT_HWCAP4 aux vector, entries

    The powerpc toolchain keeps a copy of the HWCAP bit masks in the TCB
    for fast access by the __builtin_cpu_supports() built-in function. The
    TCB space for the HWCAP entries - which are created in pairs - is an ABI
    extension, so waiting to create the space for HWCAP3 and HWCAP4 until
    they are needed is problematic. Define AT_HWCAP3 and AT_HWCAP4 in the
    generic uapi header so they can be used in glibc to reserve space in the
    powerpc TCB for their future use.

    I scanned through the Linux and GLIBC source codes looking for unused
    AT_* values and 29 and 30 did not seem to be used, so they are what I
    went with.

    Signed-off-by: Peter Bergner <bergner@linux.ibm.com>
    Acked-by: Adhemerval Zanella <adhemerval.zanella@linaro.org>
    Acked-by: Nicholas Piggin <npiggin@gmail.com>
    Acked-by: Szabolcs Nagy <szabolcs.nagy@arm.com>
    Acked-by: Arnd Bergmann <arnd@arndb.de>
    Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
    Link: https://msgid.link/a406b535-dc55-4856-8ae9-5a063644a1af@linux.ibm.com

