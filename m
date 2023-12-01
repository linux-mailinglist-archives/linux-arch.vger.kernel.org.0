Return-Path: <linux-arch+bounces-588-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 874FE8008C6
	for <lists+linux-arch@lfdr.de>; Fri,  1 Dec 2023 11:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17002B20A75
	for <lists+linux-arch@lfdr.de>; Fri,  1 Dec 2023 10:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07A61D52F;
	Fri,  1 Dec 2023 10:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T3NEQtyO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5ivKSLWo"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB8110D7;
	Fri,  1 Dec 2023 02:45:08 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1701427507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qEECtfSCuNJnYbbSSxaa7Yhx563AZhnbYIPY9oqxOFE=;
	b=T3NEQtyO3UjVNcOPdRfDLPqBbceTA/S3RG5pLrN/U1R54Q2+LC7E1qyZMq6Qdr2Lwq04Q7
	o3RbMWPKuiDtnTWhcOihAwr10MgQL4MPJzwPuXjSE8T6gp+VGjfk6u/Ymyla3VOKfAsmmc
	Ccc1ZPp7aRV0WvqXtoVD6atSILRTlOYC+gmZcP1quvkiE5ooEnP1dGy3CQhMQmnhHkyoNi
	fjrSBFLZgwtCeutL0TuwQN8B6ZHMA2t6ITEqL89vyADio0MnrI5DVfPUnv3HUa3tTRDL7e
	+EhhGYzs843vvIZov1ZEMz4EArysm5xib9rklBXUl6z6IburTOa1nE4pPpkQBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1701427507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qEECtfSCuNJnYbbSSxaa7Yhx563AZhnbYIPY9oqxOFE=;
	b=5ivKSLWokv5u4EWLeFetTD8/zTFsnE28leOpFAM1uIFAuW0E1rMX60gedKhj/gj0RQebhI
	nzpCyFo1nVj5NNDA==
To: Russell King <rmk+kernel@armlinux.org.uk>, linux-pm@vger.kernel.org,
 loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 kvmarm@lists.linux.dev, x86@kernel.org, linux-csky@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-parisc@vger.kernel.org
Cc: Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, jianyong.wu@arm.com, justin.he@arm.com, James
 Morse <james.morse@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>
Subject: Re: [PATCH 01/21] arch_topology: Make
 register_cpu_capacity_sysctl() tolerant to late CPUs
In-Reply-To: <E1r5R2g-00CsyV-Ss@rmk-PC.armlinux.org.uk>
References: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
 <E1r5R2g-00CsyV-Ss@rmk-PC.armlinux.org.uk>
Date: Fri, 01 Dec 2023 11:45:06 +0100
Message-ID: <87v89ixkul.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Nov 21 2023 at 13:43, Russell King wrote:
> ---
> If the offline CPUs thing is a problem for the tools that consume
> this value, we'd need to move cpu_capacity to be part of cpu.c's
> common_cpu_attr_groups. However, attempts to discuss this just end
> up in a black hole, so this is a non-starter. Thus, if this needs
> to be done, it can be done as a separate patch.

Offline CPUs have 0 capacity by definition....

