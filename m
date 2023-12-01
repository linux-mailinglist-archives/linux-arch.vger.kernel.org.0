Return-Path: <linux-arch+bounces-589-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1657800951
	for <lists+linux-arch@lfdr.de>; Fri,  1 Dec 2023 12:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B084B20D87
	for <lists+linux-arch@lfdr.de>; Fri,  1 Dec 2023 11:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EC0210E4;
	Fri,  1 Dec 2023 11:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gVfDLjU5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="supcOG+E"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFB2197;
	Fri,  1 Dec 2023 03:06:33 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1701428792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HEhlj+ipjqr4tEgJOcMvjQsGJg7PSMW3Lo0ITUjqyJ8=;
	b=gVfDLjU5umc+p3JXfSXFKIMVGVVvh/YAfNpBHT1q4t9H27RaW8vqhGxIzPvK5LwXvQwvdF
	/JYPTDKNgMJUwy1VQmekKDtiuw9J5MRT8kLobRdLxKlvOUfGx43e57Db2Cd7dAx9syetOZ
	BU7cmbjv5BmHUc0EAy6VO+z0aR26jT/u8M8FH2BQ6+zo9e37Okp4KeSLznfNh/tj+3D+nn
	JUnzrC6xa7Oy2ZtOmEpsPXJWO6wneo3/X5sumqAOekkfTiY5vVbLzAykjFEs+lfH/gjvHp
	2hQwTTxf7jJz2QGhGaXroHm9dcH/i6GePiLaIo9jyy0ijxHr/8RoxXDlbrf0jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1701428792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HEhlj+ipjqr4tEgJOcMvjQsGJg7PSMW3Lo0ITUjqyJ8=;
	b=supcOG+ERH+rcQKMhNStZbjQi0qWHuaxf3SWtVLs0rM9jaVZ7Iy5x6/vAzCqSSHennIM26
	dvRnrytMPd0gRKCA==
To: Russell King <rmk+kernel@armlinux.org.uk>, linux-pm@vger.kernel.org,
 loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 kvmarm@lists.linux.dev, x86@kernel.org, linux-csky@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-parisc@vger.kernel.org
Cc: Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, jianyong.wu@arm.com, justin.he@arm.com, James
 Morse <james.morse@arm.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH 08/21] drivers: base: Implement weak arch_unregister_cpu()
In-Reply-To: <E1r5R3H-00CszC-2n@rmk-PC.armlinux.org.uk>
References: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
 <E1r5R3H-00CszC-2n@rmk-PC.armlinux.org.uk>
Date: Fri, 01 Dec 2023 12:06:31 +0100
Message-ID: <87sf4mxjuw.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Nov 21 2023 at 13:44, Russell King wrote:
> ---
> An open question remains from the RFC v2 posting: should we provide a
> __weak stub for !HOTPLUG_CPU as well, since in later patches ACPI may
> reference this if the compiler doesn't optimise as we expect?

You mean:

extern void foo(void);

    if (!IS_ENABLED(CONFIG_FOO))
    	foo();

The kernel uses this pattern for years and if someday a compiler starts
to fail to eliminate the call to 'foo()' for CONFIG_FOO=n then you
already get hundreds linkage fails today.

So adding one more in later patches won't matter much :)


