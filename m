Return-Path: <linux-arch+bounces-7212-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFC197579F
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 17:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07A5BB298F4
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 15:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95751AC8A3;
	Wed, 11 Sep 2024 15:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=syndicat.com header.i=@syndicat.com header.b="n/nWhaAY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.syndicat.com (mail.syndicat.com [62.146.89.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8213A1ABEB8;
	Wed, 11 Sep 2024 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.89.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726069798; cv=none; b=fIcxhRA+JMWxD7KPDUFtbop3dSxseFvQJs84Yuaa1CRWqZzmBIfO5cGBjp6INIm+K4KGsSHTqOWT+C1QDMsmnLIlaI4xTLeMa0Z9fGUYX0UIduwGXZtcENAAN2NTT6n102CzxO/w2PKVLWoe8WgSpZ0ZsA43aM3njUKfK11WOLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726069798; c=relaxed/simple;
	bh=rsDjtUbs6FEUozaeUr5ELGw2oV4jRVnMxSabRL/2HgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjaMvqtGRR53Qn9q8iySMd/PspomoOJbC4d14IerC/aMTu6Nicy06NiPrwgSmUPvr6xD2l/4DLykhAMHPzxt+7u6CrvH5qoQK9h0x4TRPZMRul0ZHO+LbwA3C7YTfDk9YfL/PNdvn9TeXDxGsQto2iebqsJnlJ65x41EPU4RNN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=syndicat.com; spf=pass smtp.mailfrom=syndicat.com; dkim=pass (1024-bit key) header.d=syndicat.com header.i=@syndicat.com header.b=n/nWhaAY; arc=none smtp.client-ip=62.146.89.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=syndicat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=syndicat.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=syndicat.com; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fzIXo3yyzydPZssY8Emq0ERM7FiN4ixdZ6PRUNbHpxU=; b=n/nWhaAYBBuf3nzNnd7Sqg7jbe
	2+Fmmi494pA1/npuLQeAVIeBTOimjs5oJuV4GdO3BBowfzJrOz1vFOFAfqcmC5TRBFhSLMQGFfn02
	XIOWKcCvGhGQmY9VvnEpuyLLRNEuokHtithLAuCK9+PnE2NGdiyUh7y9bbJkPeoVQOqo=;
Received: from localhost.syndicat.com ([127.0.0.1]:51771 helo=localhost)
	by mail.syndicat.com with esmtp (Syndicat PostHamster 12.2 4.96.1)
	(envelope-from <nd@syndicat.com>)
	id 1soPbM-0007FZ-0h;
	Wed, 11 Sep 2024 17:49:52 +0200
X-Virus-Scanned: amavisd-new at syndicat.com
Received: from mail.syndicat.com ([127.0.0.1])
	by localhost (mail.syndicat.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0ONhiC24LKMG; Wed, 11 Sep 2024 17:49:51 +0200 (CEST)
Received: from p579493d3.dip0.t-ipconnect.de ([87.148.147.211]:57025 helo=gongov.localnet)
	by mail.syndicat.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Syndicat PostHamster 12.2 4.96.1)
	(envelope-from <nd@syndicat.com>)
	id 1soPbL-0002M7-23;
	Wed, 11 Sep 2024 17:49:51 +0200
From: Niels Dettenbach <nd@syndicat.com>
To: linux-arch@vger.kernel.org
Cc: stable@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH 1/1] x86: SMT broken on Xen PV DomU since 6.9 (updated)
Date: Wed, 11 Sep 2024 17:49:46 +0200
Message-ID: <3301863.oiGErgHkdL@gongov>
Organization: Syndicat IT&Internet
In-Reply-To: <4242435.1IzOArtZ34@gongov>
References: <4242435.1IzOArtZ34@gongov>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Report-Abuse-To: abuse@syndicat.com (see https://www.syndicat.com/kontakt/kontakte/)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - mail.syndicat.com
X-AntiAbuse: Original Domain - 
X-AntiAbuse: Sender Address Domain - syndicat.com

Am Mittwoch, 11. September 2024, 10:53:30  schrieb Niels Dettenbach:
> virtual machines under Xen Hypervisor (DomU) running in Xen PV mode use a
> special, nonstandard synthetized CPU topology which "just works" under
> kernels 6.9.x while newer kernels assuming a "crash kernel" and disable
> SMT (reducing to one CPU core) because the newer topology implementation
> produces a wrong error "[Firmware Bug]: APIC enumeration order not
> specification compliant" after new topology checks which are improper for
> Xen PV platform. As a result, the kernel disables SMT and activates just
> one CPU core within the VM (DomU).
> 
> The patch disables the regarding checks if it is running in Xen PV
> mode (only) and bring back SMT / all CPUs as in the past to such DomU
> VMs.
> 
> Signed-off-by: Niels Dettenbach <nd@syndicat.com>
> 

Signed-off-by: Niels Dettenbach <nd@syndicat.com>
---

A reworked proposal patch which substitutes my initial proposed patch:


--- linux/arch/x86/kernel/cpu/topology.c        2024-09-11 17:42:42.699278317 +0200
+++ linux/arch/x86/kernel/cpu/topology.c.orig   2024-09-11 09:53:16.194095250 +0200
@@ -132,14 +132,6 @@
        u64 msr;

        /*
-        * assume Xen PV has a working (special) topology
-        */
-       if (xen_pv_domain()) {
-               topo_info.real_bsp_apic_id = topo_info.boot_cpu_apic_id;
-               return false;
-       }
-
-       /*
         * There is no real good way to detect whether this a kdump()
         * kernel, but except on the Voyager SMP monstrosity which is not
         * longer supported, the real BSP APIC ID is the first one which is

 







