Return-Path: <linux-arch+bounces-6645-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC4B9603E3
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 10:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2201F20F2E
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 08:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818EB13A25B;
	Tue, 27 Aug 2024 08:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TORGCs/7"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B951158D79;
	Tue, 27 Aug 2024 08:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724745822; cv=none; b=aRBa4b+e9E8xi7PZsTUhAbPJAWjc7QNeqMrXC6drNqZY18CT080ZRYn6sZkGNTR367SA3qdbez58fwr6uwOYBnNe+b/6GhbYhyEu6NrqGhblgo0++OGuTCESOV67Hi9mVFQ3YxG29DKwEyyWfC8ZOslbhf23JxWdWQkWKfXM5+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724745822; c=relaxed/simple;
	bh=Uzmm5ymz9Kdo8U5i2J3vApJuNWGqBvcBgCCp8LWSRoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/KzGZQNmLwux6u3PiYOMEJv3XoG/RDHTxO/w8KxOL3gZS63/xrjrwefWnxcztOnauUG82ZGXfDjbx+eVt/9jj+ncmrLnpQTo08nKGubi19NhJDkRsCoY37hyASWdLEzXer11a0BVn5k7jOizn/K2hZuw5mjU1YAGqduM9C2KlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=TORGCs/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63334C8B7A1;
	Tue, 27 Aug 2024 08:03:40 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TORGCs/7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724745819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uzmm5ymz9Kdo8U5i2J3vApJuNWGqBvcBgCCp8LWSRoY=;
	b=TORGCs/7gC4HKVFIs54oJJTrqMS5kY0+3ykih9Z6ThQoVZ/vsLyrzOfeVn51GHXKBfwtZ6
	RiqDIBoNb31ZAgvJXn8l41ee5CELTUFr+Z73k3I/SEWAyJsyL6vaP2Hs4QqHw88LtYnJby
	synNMhSoaRx1O1AKVH96EVx8KYIEMkE=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4fa0e2f2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Aug 2024 08:03:38 +0000 (UTC)
Date: Tue, 27 Aug 2024 10:03:32 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 4/4] random: vDSO: don't use 64 bits atomics on 32 bits
 architectures
Message-ID: <Zs2IVIQwZ-8fQGZ4@zx2c4.com>
References: <cover.1724743492.git.christophe.leroy@csgroup.eu>
 <30806cb8d7e0b95dcfb9f81a4583759faa1d8f31.1724743492.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <30806cb8d7e0b95dcfb9f81a4583759faa1d8f31.1724743492.git.christophe.leroy@csgroup.eu>

On Tue, Aug 27, 2024 at 09:31:50AM +0200, Christophe Leroy wrote:
> Performing SMP atomic operations on u64 fails on powerpc32:

Thanks for this, and nice catch on the vDSO side checking on big endian.
I've applied this, fixing up the commit message and the comment,
maintaining the reverse christmas tree in getrandom.c, and adding tglx's
suggested-by tag.

Jason

