Return-Path: <linux-arch+bounces-3123-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32763887638
	for <lists+linux-arch@lfdr.de>; Sat, 23 Mar 2024 01:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63DC21C2287F
	for <lists+linux-arch@lfdr.de>; Sat, 23 Mar 2024 00:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C130DA31;
	Sat, 23 Mar 2024 00:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eiKbLkSa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bEAsb7Bi"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B24A621;
	Sat, 23 Mar 2024 00:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711154527; cv=none; b=iSiUYe2YXPzo+EXjz5iGdfS6RMsUyBoNVqABA8Q2Zn9z7nIlz38gKCSjIVazGs+xESRIhjwnLQMHn9VsiRj+A2dsdINQPMRi7SZcoE7F8xk2TpwOuUvgZoBNHOqHMs2Cj5/Vy9iv2g1b+Wt2eLRa3tw1W6JfNIDTqE9hr0smYWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711154527; c=relaxed/simple;
	bh=VG76lI2ZKWeJag+zZx5VSi9z780CgVU/nTzoEV6nJ/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PVK0rk/6igFmaC5AlEfw6l+5Zn6bMEreDompw5sGmNmbrYemZB9i0Z9OHZ20kC97iOHlEOWo2kgBkasAFCsyfp0PQlHukuOUhnDCg3Ot5uVsymTDKmSRBYLH517JNmfeWkXhhjLvylZKdZra2Rz7Tj//TQU1fuGGkOs4Fq/WH8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eiKbLkSa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bEAsb7Bi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711154524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KASqGBVESWShyton5ws5e4AKhW61Ak7l2WXOYTqetwM=;
	b=eiKbLkSalN507RpSncW2Q0She6oTlcjn691pienBGqKa0vhUbbjV/P8TGbsUTZ9rli01yG
	dyxB4IHmoZPP+0qGtgtI5RJ5bzWsx42Ct53B8wwpvS0ZTiIBDrB0el2QdQTQvcFDr2i+ST
	yahaEu7JFs30yQtddWZo3ThoSmQw4chIBztghQtVhJibQWqkCd78Atk4OVXPrBO1srA7+D
	wYk4FiHRhpOsCl6tFbQbJySLx/hGc4Ka7XfqIpXC23n8sFBhwqpRpq5TmO8IhyNVZGvxkM
	Y8wNXsLee2mrRXIlAsaVObcvcN58u0TY48QSdV2xu0bn87rYO9tYW/ZYBu99jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711154524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KASqGBVESWShyton5ws5e4AKhW61Ak7l2WXOYTqetwM=;
	b=bEAsb7BiaPv5dpKF5KRSx4jaDSbh7g9U7wvowQ8/NtAsAQQjF4NWC0du72bGnC+wSwa+3g
	zHHp7MNaCI/T+nCQ==
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: richardcochran@gmail.com, luto@kernel.org, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 arnd@arndb.de, geert@linux-m68k.org, peterz@infradead.org,
 hannes@cmpxchg.org, sohil.mehta@intel.com, rick.p.edgecombe@intel.com,
 nphamcs@gmail.com, palmer@sifive.com, keescook@chromium.org,
 legion@kernel.org, mark.rutland@arm.com, mszeredi@redhat.com,
 casey@schaufler-ca.com, reibax@gmail.com, davem@davemloft.net,
 brauner@kernel.org, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v7] posix-timers: add clock_compare system call
In-Reply-To: <878r29hjds.ffs@tglx>
References: <878r29hjds.ffs@tglx>
Date: Sat, 23 Mar 2024 01:42:03 +0100
Message-ID: <875xxdhj8k.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Mar 23 2024 at 01:38, Thomas Gleixner wrote:
> PTP_SYS_OFFSET_EXTENDED moves the outer sample points as close as
> possible to the actual PCH read and provides both outer samples to user
> space for analysis. It was introduced for a reason, no?

That said, it's a sad state of affairs that 16 drivers which did exist
before the introduction of the gettimex64() callback have not been
converted over to it within 4.5 years.

What's even worse is that 14 drivers have been merged _after_ the
gettimex64() callback got introduced without implementing it:

2019-02-12   drivers/net/ethernet/freescale/enetc/enetc_ptp.c
2019-10-24   drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
2019-11-15   drivers/net/dsa/ocelot/felix_vsc9959.c
2020-01-12   drivers/net/ethernet/xscale/ptp_ixp46x.c
2020-06-20   drivers/net/ethernet/mscc/ocelot_vsc7514.c
2020-06-24   drivers/net/phy/mscc/mscc_ptp.c
2020-08-24   drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
2020-11-05   drivers/net/dsa/hirschmann/hellcreek_ptp.c
2022-02-01   drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
2022-03-04   drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
2022-05-10   drivers/net/ethernet/sfc/siena/ptp.c
2022-11-02   drivers/net/ethernet/renesas/rcar_gen4_ptp.c
2023-01-13   drivers/net/dsa/microchip/ksz_ptp.c
2023-03-22   drivers/net/wireless/intel/iwlwifi/mvm/ptp.c

Not Sagi's fault at all, but it's telling and coherent with the approach
to solve the problem at hand.

See the previous reply for the observation on the letters P and C in PTP.

Oh well,

        tglx

